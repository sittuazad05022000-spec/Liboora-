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
  MembershipValidityService(this._repo);
  final MembershipRepository _repo;

  @override
  MembershipValidity forStudent(StudentRecordId id, DateTime on) {
    for (final m in _repo.forStudent(id)) {
      if (m.isValidOn(on)) {
        return MembershipValidity(
          isValid: true,
          validUntil: m.term.end,
          seatQuota: m.plan.seatQuota,
          planName: m.plan.name,
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

    final start = startingOn ?? clock.today();
    final term = DateRange.days(start, plan.durationDays);

    // Invariant check with data supplied by the repository.
    Membership.assertNoOverlap(repo.forStudent(studentId), term);

    final m = Membership(
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
          'planName': plan.name,
          'priceMinor': plan.price.minorUnits,
          'validUntil': term.end.toIso8601String(),
        },
      ),
    ]);
    await events.drain();
    return m;
  }
}
