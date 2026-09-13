/// **BC-02 Membership** — public barrel.
library;

export 'domain/membership.dart';

import 'package:liboora_contracts/liboora_contracts.dart';

import '../../../platform/data/data.dart';
import '../../../platform/event/event.dart';
import '../../../platform/identity/identity.dart';
import 'domain/membership.dart';

abstract interface class MembershipRepository {
  List<Membership> forStudent(StudentRecordId id);
  List<Membership> all();
  Membership? byId(String id);
  void save(Membership m);
}

/// `MM-FR-006` — the plan aggregate has its own repository.
///
/// A shared repository would make it easy to write both aggregates in one
/// transaction, which is precisely what `MM-FR-006` forbids.
abstract interface class MembershipPlanRepository {
  List<MembershipPlan> all();

  /// `MM-FR-020` — the plans selectable for a new membership.
  List<MembershipPlan> selectable();

  MembershipPlan? byId(String id);
  void save(MembershipPlan plan);
}

final class InMemoryMembershipRepository implements MembershipRepository {
  InMemoryMembershipRepository(this._store);
  final TenantPartitionedStore<Membership> _store;

  @override
  List<Membership> forStudent(StudentRecordId id) =>
      _store.where((m) => m.studentRecordId == id);

  @override
  List<Membership> all() => _store.all();

  @override
  Membership? byId(String id) => _store.get(id);

  @override
  void save(Membership m) => _store.put(m.id, m);
}

final class InMemoryMembershipPlanRepository
    implements MembershipPlanRepository {
  InMemoryMembershipPlanRepository(this._store);
  final TenantPartitionedStore<MembershipPlan> _store;

  @override
  List<MembershipPlan> all() => _store.all();

  @override
  List<MembershipPlan> selectable() => _store.where((p) => p.isActive);

  @override
  MembershipPlan? byId(String id) => _store.get(id);

  /// `MM-FR-010` — `name` is unique per (tenantId, branchId) among plans that
  /// are not archived.
  ///
  /// The store is already tenant-partitioned, so this checks the branch half
  /// and relies on the partition for the tenant half — the same division of
  /// labour every other repository here uses.
  @override
  void save(MembershipPlan plan) {
    final clash = _store.where(
      (p) =>
          p.id != plan.id &&
          p.isActive &&
          p.branchId == plan.branchId &&
          p.name.toLowerCase() == plan.name.toLowerCase(),
    );
    if (clash.isNotEmpty) {
      throw DomainError(
        DomainErrorCode.conflict,
        'A plan named "${plan.name}" already exists in this branch. '
        'Reception staff must never be shown two identically named plans.',
        context: {'existingPlanId': clash.first.id, 'field': 'name'},
      );
    }
    _store.put(plan.id, plan);
  }
}

/// Published projection consumed by Seating (E-02) and Attendance (E-03).
///
/// Seating BLOCKS on invalid membership; Attendance RECORDS and flags. That
/// asymmetry is a deliberate business rule — never lock a paying student out
/// at the door — documented so nobody "fixes" it later.
final class MembershipValidity {
  const MembershipValidity({
    required this.isValid,
    required this.validUntil,
    required this.seatQuota,
    required this.planName,
  });

  final bool isValid;
  final DateTime? validUntil;
  final int seatQuota;
  final String planName;

  static const MembershipValidity none = MembershipValidity(
    isValid: false,
    validUntil: null,
    seatQuota: 0,
    planName: '—',
  );
}

abstract interface class MembershipValidityReader {
  MembershipValidity forStudent(StudentRecordId id, DateTime on);
}

final class MembershipValidityService implements MembershipValidityReader {
  MembershipValidityService(this._repo, this._plans);
  final MembershipRepository _repo;
  final MembershipPlanRepository _plans;

  @override
  MembershipValidity forStudent(StudentRecordId id, DateTime on) {
    for (final m in _repo.forStudent(id)) {
      if (m.isValidOn(on)) {
        // MM-FR-025: seatQuota published for an active membership must not
        // change when the plan changes. A missing plan (deleted catalogue row,
        // or a membership restored before its plan) must not deny a paid
        // student their seat, so quota falls back to zero and the term still
        // reports valid.
        final plan = _plans.byId(m.planId);
        return MembershipValidity(
          isValid: true,
          validUntil: m.term.end,
          seatQuota: plan?.seatQuota ?? 0,
          planName: plan?.name ?? '—',
        );
      }
    }
    return MembershipValidity.none;
  }
}

final class CreateMembership {
  CreateMembership({
    required this.repo,
    required this.events,
    required this.clock,
    required this.ids,
    required this.tenant,
    required this.pdp,
  });

  final MembershipRepository repo;
  final EventBus events;
  final Clock clock;
  final IdGenerator ids;
  final TenantContext tenant;
  final PolicyDecisionPoint pdp;

  Future<Membership> call({
    required AccessRole actorRole,
    required StudentRecordId studentId,
    required MembershipPlan plan,
    DateTime? startingOn,
  }) async {
    pdp.require(actorRole, Permission.createMembership);

    // MM-FR-020: a deactivated plan must not be selectable for a new
    // membership. Checked before any mutation, per MM-FR-033.
    if (!plan.isActive) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'The plan "${plan.name}" is not active and cannot be sold.',
        context: {'planId': plan.id, 'field': 'isActive'},
      );
    }

    final start = startingOn ?? clock.today();
    final term = DateRange.days(start, plan.durationDays);

    // Invariant check with data supplied by the repository.
    Membership.assertNoOverlap(repo.forStudent(studentId), term);

    // MM-FR-026: the snapshots are taken from the plan being sold, at this
    // moment, together with its version.
    final m = Membership.fromPlan(
      id: ids.next('mem'),
      studentRecordId: studentId,
      plan: plan,
      term: term,
    );
    repo.save(m);

    events.enqueue([
      DomainEvent(
        eventId: ids.next('evt'),
        eventType: 'membership.MembershipCreated',
        tenantId: tenant.tenantId,
        aggregateId: m.id,
        occurredAt: clock.now(),
        actorId: tenant.actorId,
        correlationId: tenant.correlationId,
        payload: {
          'membershipId': m.id,
          'studentRecordId': studentId.value,
          'planId': m.planId,
          'planName': plan.name,
          // MM-FR-026: the snapshot, not the live plan price.
          'priceMinor': m.priceSnapshot.minorUnits,
          'currency': m.currencySnapshot,
          'planVersionAtPurchase': m.planVersionAtPurchase,
          'validUntil': term.end.toIso8601String(),
        },
      ),
    ]);
    await events.drain();
    return m;
  }
}
