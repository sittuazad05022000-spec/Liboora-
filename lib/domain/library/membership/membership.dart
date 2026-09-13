/// **BC-02 Membership** — public barrel.
library;

export 'domain/membership.dart';

import 'package:liboora_contracts/liboora_contracts.dart';

import '../../../platform/data/data.dart';
import '../../../platform/event/event.dart';
import '../../../platform/identity/identity.dart';
import 'domain/membership.dart';

/// `IMPL-428` / `MM-BR-006` — the **closed** set of integration edges this
/// module may use. An eleventh is not constructible.
///
/// BC Map L292: *"if an edge is not in this table, it does not exist and
/// adding it requires an ADR."* Modelling the set as an enum makes that
/// mechanical: a developer cannot reach for `E-06` because the value does not
/// exist, so `MM-BR-008` (no `BC-06` Library Policy consumption) holds by
/// construction rather than by review.
enum MembershipEdge {
  /// `BC-01` → `BC-02`. Enrollment precondition (§3.1).
  e01EnrollmentInbound,

  /// `BC-02` → `BC-04`. `MembershipValidity`; Seating **rejects** if invalid.
  e02SeatingProjection,

  /// `BC-02` → `BC-03`. Same projection; Attendance **flags**, never blocks.
  e03AttendanceProjection,

  /// `BC-02` → `BC-05`. Created/Renewed/Upgraded → `FeeDue`.
  e07FeeOutbound,

  /// `BC-05` → `BC-02`. `FeePaymentReceived` activates a pending membership.
  e10PaymentInbound,

  /// `BC-02` → `BC-21`. Entitlement check **before** mutation.
  e17Entitlement,

  /// `BC-02` → `BC-19`. Ambient `TenantContext`; never a method parameter.
  e18Tenancy,

  /// `BC-02` → `BC-25`. Typed config accessors (§13.4).
  e19Configuration,

  /// `BC-02` → `BC-24`. Audit; outbox-backed, **never synchronous**.
  e20Audit,

  /// `BC-02` → `BC-22`. Notification facts only, never "send an SMS".
  e23Notification;

  /// `MM-BR-007` — the asymmetry that must survive future "fixes".
  ///
  /// Seating blocks on an invalid membership; Attendance records and flags.
  /// `MP-GBR-16` states it globally and BC Map §7.1 adds *"documented here so
  /// a future engineer does not 'fix' it."* Never lock a paying student out
  /// at the door.
  bool get blocksOnInvalidMembership =>
      this == MembershipEdge.e02SeatingProjection;
}

/// `IMPL-411` / `MM-FR-034` — the enrollment precondition, read over `E-01`.
///
/// Declared **here**, by the consumer, and implemented in `enrollment` and
/// wired in `di.dart`. `BC-02` therefore never imports `BC-01`: the edge is a
/// port, not a compile-time dependency, which is the same shape `seating`
/// already uses to read `MembershipValidityReader` in the other direction.
///
/// This deliberately exposes **only** the enrollment state. `MM-FR-003` and
/// `MM-BR-021` forbid `BC-01` data on this side of the boundary, so a port
/// that returned a `StudentRecord` would hand this module a name, a phone
/// number and an address it must not hold. The answer is one enum, or null
/// when the student does not exist in this tenant.
abstract interface class EnrollmentStatusReader {
  /// The student's enrollment state, or `null` when no such record exists in
  /// the current tenant.
  ///
  /// Implementations **MUST** throw rather than return `null` if the
  /// underlying `E-01` state cannot be read at all — `MM-BR-013` requires
  /// creation to fail closed, and `null` would be indistinguishable from
  /// "definitely not enrolled".
  MembershipEnrollmentState? stateFor(StudentRecordId id);
}

/// The `E-01` payload, narrowed to what `MM-FR-035` needs to name.
///
/// A copy of `BC-01`'s vocabulary rather than a shared type, because
/// `MM-FR-003` keeps the two contexts' models independent. The four values
/// are `MM-FR-035`'s own list: `Active` admits a membership, the other three
/// are named in the rejection.
enum MembershipEnrollmentState {
  active,
  inactive,
  suspended,
  archived;

  /// `MM-FR-033` — only an `Active` enrollment may receive a membership.
  bool get admitsNewMembership => this == MembershipEnrollmentState.active;
}

/// `MM-BR-013` — raised when the `E-01` stream cannot be read.
///
/// A distinct type from "not enrolled" on purpose: the two must never be
/// collapsed, because assuming an active enrollment on an unavailable stream
/// is the exact failure `MM-BR-013` forbids.
final class EnrollmentStreamUnavailable implements Exception {
  const EnrollmentStreamUnavailable(this.reason);
  final String reason;

  @override
  String toString() => 'EnrollmentStreamUnavailable: $reason';
}

/// `IMPL-414` / `MM-FR-047` — idempotency, declared as a port by this
/// consumer (law L3).
///
/// A narrow interface rather than an import of `IdempotencyService`. The
/// boundary checker's own `ADR-0012` note on the
/// `domain/library -> platform/services` edge says the fix is *"only the
/// interfaces are missing"* — so this declares one instead of joining the
/// waived debt. The adapter is wired in `di.dart`.
///
/// Two methods, not three: `seen` is redundant when [recall] already
/// distinguishes a hit from a miss, and offering both invites the
/// check-then-recall race that idempotency exists to prevent.
abstract interface class MembershipIdempotencyStore {
  /// The membership previously created under [key], or `null`.
  Membership? recall(IdempotencyKey key);

  /// Record [result] against [key]. Tenant-scoped (`MM-FR-048`).
  void remember(IdempotencyKey key, Membership result);
}

abstract interface class MembershipRepository {
  List<Membership> forStudent(StudentRecordId id);
  List<Membership> all();
  Membership? byId(String id);
  void save(Membership m);

  /// `IMPL-414` / `MM-FR-046` — insert a **new** membership, rejecting an
  /// overlapping term at the persistence boundary.
  ///
  /// `MM-FR-046` requires overlap to be enforced *"by a database-level
  /// constraint or an equivalent serialising lock, not by a read-then-write
  /// check in application code"*. This project has no SQL layer (`MM-BR-025`
  /// specifies none), so the equivalent is provided here: the overlap scan
  /// and the write happen in **one synchronous block with no suspension
  /// point between them**, inside the repository that owns the partition.
  ///
  /// That is the honest strength of the guarantee, and it is worth stating
  /// exactly. Dart runs one isolate, so two reception terminals interleave
  /// only at `await` boundaries. A read-then-write in the *use case* has an
  /// `await` between the check and the save, and is therefore genuinely
  /// unsafe; this has none, so no second command can observe the gap. When a
  /// real database is introduced, this method is the single place that must
  /// become a unique/exclusion constraint — the call sites do not change.
  ///
  /// Throws [DomainError] with [DomainErrorCode.overlappingMembershipTerm]
  /// naming the conflicting membership (`MM-FR-049`).
  void insertGuardingOverlap(Membership m);
}

/// `MM-FR-006` — the plan aggregate has its own repository.
///
/// A shared repository would make it easy to write both aggregates in one
/// transaction, which is precisely what `MM-FR-006` forbids.
abstract interface class MembershipPlanRepository {
  List<MembershipPlan> all();

  /// `MM-FR-020`/`MM-BR-029` — the plans selectable for a create, renewal or
  /// upgrade target.
  List<MembershipPlan> selectable();

  /// `MM-FR-015` — the plans a student may be shown. A `StaffOnly` plan is
  /// absent (`MM-AC-012`).
  List<MembershipPlan> studentVisible();

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

  @override
  void insertGuardingOverlap(Membership m) {
    // Synchronous, single block, no await: the check and the write cannot be
    // interleaved. See MembershipRepository.insertGuardingOverlap.
    Membership.assertNoOverlap(
      _store.where((e) => e.studentRecordId == m.studentRecordId),
      m.term,
    );
    _store.put(m.id, m);
  }
}

final class InMemoryMembershipPlanRepository
    implements MembershipPlanRepository {
  InMemoryMembershipPlanRepository(this._store);
  final TenantPartitionedStore<MembershipPlan> _store;

  @override
  List<MembershipPlan> all() => _store.all();

  @override
  List<MembershipPlan> selectable() => _store.where((p) => p.isSelectable);

  @override
  List<MembershipPlan> studentVisible() =>
      _store.where((p) => p.isStudentVisible);

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
        // MM-FR-025: the quota published for an ACTIVE membership must not
        // move when the plan's quota changes — retroactively reducing it
        // could invalidate a seat a student is physically sitting in. So the
        // quota comes from the membership's own snapshot, not the live plan.
        // The plan is read for its display name only, and a missing plan does
        // not deny a paid student their seat.
        final plan = _plans.byId(m.planId);
        return MembershipValidity(
          isValid: true,
          validUntil: m.term.end,
          seatQuota: m.seatQuotaSnapshot,
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
    required this.plans,
    required this.enrollment,
    required this.config,
    required this.idempotency,
  });

  final MembershipRepository repo;
  final EventBus events;
  final Clock clock;
  final IdGenerator ids;
  final TenantContext tenant;
  final PolicyDecisionPoint pdp;

  /// `MM-FR-033` — the plan must be resolved from *this* tenant's catalogue.
  final MembershipPlanRepository plans;

  /// `E-01` — the enrollment precondition (`MM-FR-034`).
  final EnrollmentStatusReader enrollment;

  /// `E-19` — `MM-CFG-003`/`MM-CFG-004` back-date and forward-date windows.
  final MembershipConfig config;

  /// `MM-FR-047`/`MM-FR-048` — tenant-scoped idempotency records.
  final MembershipIdempotencyStore idempotency;

  Future<Membership> call({
    required AccessRole actorRole,
    required IdempotencyKey idempotencyKey,
    required StudentRecordId studentId,
    required MembershipPlan plan,
    DateTime? startingOn,
    bool paymentAlreadyReceived = false,
  }) async {
    // MM-FR-047: a repeated command with the same key and tenant returns the
    // ORIGINAL result — the same membershipId, no new event, no second write.
    // Checked first, because a retry must not re-run the preconditions and
    // fail on state the first call itself created (its own membership would
    // now be an overlap).
    //
    // The service namespaces by tenant (MM-FR-048), so two tenants using the
    // same key string are not each other's replay.
    final replay = idempotency.recall(idempotencyKey);
    if (replay != null) return replay;

    // MM-FR-033 requires every precondition to be verified BEFORE anything is
    // mutated. They are therefore all checked here, in order, and each one
    // throws — none of them degrades into a warning.
    pdp.require(actorRole, Permission.createMembership);

    // MM-FR-033: the plan must belong to this tenant/branch. Resolving it
    // from the tenant-partitioned catalogue rather than trusting the passed
    // object is what makes MM-BR-029 hold: a plan handed in from another
    // tenant simply is not there.
    if (plans.byId(plan.id) == null) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'The plan "${plan.name}" does not belong to this tenant or branch.',
        context: {'planId': plan.id, 'field': 'planId'},
      );
    }

    // MM-FR-020/MM-FR-033: a deactivated plan must not be selectable.
    if (!plan.isActive) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'The plan "${plan.name}" is not active and cannot be sold.',
        context: {'planId': plan.id, 'field': 'isActive'},
      );
    }

    // MM-FR-034/MM-FR-035: the enrollment precondition, read over E-01.
    //
    // MM-BR-013 says this must fail CLOSED. So the unavailable-stream case is
    // allowed to propagate as EnrollmentStreamUnavailable rather than being
    // caught and treated as "probably fine" -- and a null answer (no such
    // record in this tenant) is a rejection, not a pass.
    final enrollmentState = enrollment.stateFor(studentId);
    if (enrollmentState == null) {
      throw DomainError(
        DomainErrorCode.notFound,
        'No student record exists in this tenant for the given id.',
        context: {'studentRecordId': studentId.value, 'field': 'studentId'},
      );
    }
    if (!enrollmentState.admitsNewMembership) {
      // MM-FR-035: the error must NAME the enrollment state.
      throw DomainError(
        DomainErrorCode.validationFailed,
        'A student whose enrollment is "${enrollmentState.name}" cannot '
        'receive a new membership.',
        context: {
          'studentRecordId': studentId.value,
          'enrollmentStatus': enrollmentState.name,
          'field': 'enrollmentStatus',
        },
      );
    }

    // MM-FR-038: startDate defaults to the current business date, and is
    // bounded by MM-CFG-003 behind and MM-CFG-004 ahead. Read through the
    // config port (E-19), never as a literal.
    final today = clock.today();
    final start = startingOn ?? today;
    final offsetDays = start.difference(today).inDays;
    if (offsetDays < -config.maxBackdateDays) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'startDate may not be more than ${config.maxBackdateDays} days in '
        'the past.',
        context: {
          'field': 'startDate',
          'maxBackdateDays': config.maxBackdateDays,
          'requestedOffsetDays': offsetDays,
        },
      );
    }
    if (offsetDays > config.maxForwardDateDays) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'startDate may not be more than ${config.maxForwardDateDays} days in '
        'the future.',
        context: {
          'field': 'startDate',
          'maxForwardDateDays': config.maxForwardDateDays,
          'requestedOffsetDays': offsetDays,
        },
      );
    }

    // MM-FR-039: endDate is COMPUTED here and is never a caller input. There
    // is deliberately no endDate parameter on this command to supply.
    final term = DateRange.days(start, plan.durationDays);

    // Invariant check with data supplied by the repository.

    // MM-FR-041: the initial status is DECIDED by the payment condition, not
    // assumed. MM-BR-002 means this module learns a payment outcome only from
    // BC-05 over E-10, so at creation the only lawful inputs are the amount
    // that applies and whether an outcome has already arrived.
    final initialStatus = Membership.initialStatusFor(
      applicableAmount: plan.price,
      paymentAlreadyReceived: paymentAlreadyReceived,
      // MM-FR-053: an advance sale is held in Scheduled until startDate.
      startDate: start,
      today: today,
    );

    // MM-FR-026: the snapshots are taken from the plan being sold, at this
    // moment, together with its version.
    final m = Membership.fromPlan(
      id: ids.next('mem'),
      studentRecordId: studentId,
      plan: plan,
      term: term,
      status: initialStatus,
      createdAt: clock.now(),
      createdBy: tenant.actorId,
      // MM-INV-011: activation metadata exists only if it activated now.
      activatedAt: initialStatus == MembershipStatus.active
          ? clock.now()
          : null,
      activatedBy: initialStatus == MembershipStatus.active
          ? tenant.actorId
          : null,
    );
    // MM-FR-045/MM-FR-046: overlap is rejected at the persistence boundary,
    // in the same synchronous block as the write. Deliberately NOT a
    // read-then-write check up here -- there is an await above this line, so
    // a check here would leave exactly the window MM-FR-046 forbids.
    repo.insertGuardingOverlap(m);

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
          // MM-FR-040: the persisted creation metadata travels with the event
          // so BC-05 can raise the FeeDue (E-07) without reading BC-02.
          'status': m.status.name,
          'startDate': term.start.toIso8601String(),
          'createdAt': m.createdAt?.toIso8601String(),
          'createdBy': m.createdBy,
          'validUntil': term.end.toIso8601String(),
        },
      ),
    ]);

    // MM-FR-047: recorded AFTER the write succeeds. Remembering earlier would
    // make a failed creation replay as a success.
    idempotency.remember(idempotencyKey, m);

    await events.drain();
    return m;
  }
}
