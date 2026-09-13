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
    this.studentRecordId,
    this.status,
    this.planId,
    this.tenantId,
  });

  /// `MM-FR-067` — carried so no consumer re-derives the rule from
  /// [validUntil], which is the duplication `MM-FR-066` forbids.
  final bool isValid;

  /// The inclusive last business date (`MM-FR-055`), or `null` when invalid.
  final DateTime? validUntil;
  final int seatQuota;
  final String planName;

  /// `MM-FR-067` — the exact `E-02` shape names `studentRecordId`.
  final StudentRecordId? studentRecordId;

  /// `MM-FR-067` — lets the Library Member Directory show **why** something
  /// is invalid, which `PRD-004` `LMD-16`/`LMD-26` already require it to
  /// display. Without it every consumer would guess.
  final MembershipStatus? status;

  final String? planId;

  /// `MM-FR-065` — validity is tenant-qualified. Carrying the tenant makes a
  /// cross-tenant answer detectable rather than merely unlikely.
  final TenantId? tenantId;

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
  MembershipValidityService(this._repo, this._plans, {this.enrollment});
  final MembershipRepository _repo;
  final MembershipPlanRepository _plans;

  /// `IMPL-422` / `MM-FR-077` — optional `E-01` read.
  ///
  /// A student suspension **MUST** cause the projection to report
  /// `isValid: false` *"for the duration of the suspension, without mutating
  /// the membership record"*. That is why the suspension is answered here, in
  /// the read path, rather than by flipping a status: `MM-FR-070`/`MM-FR-071`
  /// forbid this module from altering the membership or writing downstream
  /// when validity is lost, and a suspension that expired a membership would
  /// be irreversible.
  ///
  /// Optional so existing call sites keep working; when absent, enrollment is
  /// simply not consulted.
  final EnrollmentStatusReader? enrollment;

  @override
  MembershipValidity forStudent(StudentRecordId id, DateTime on) {
    // MM-FR-077: a suspended student is reported invalid, and the membership
    // record is left exactly as it is -- so reinstating the student restores
    // entitlement without re-selling anything.
    final state = enrollment?.stateFor(id);
    final suspended = state != null && !state.admitsNewMembership;

    for (final m in _repo.forStudent(id)) {
      if (m.isValidOn(on)) {
        if (suspended) {
          // The membership itself is untouched and still Active; only the
          // projected answer is false. MM-FR-076: the two statuses are
          // separate fields, so `status` still reports the membership's own.
          return MembershipValidity(
            isValid: false,
            validUntil: m.endDate,
            seatQuota: 0,
            planName: _plans.byId(m.planId)?.name ?? '—',
            studentRecordId: id,
            status: m.status,
            planId: m.planId,
          );
        }
        // MM-FR-025: the quota published for an ACTIVE membership must not
        // move when the plan's quota changes — retroactively reducing it
        // could invalidate a seat a student is physically sitting in. So the
        // quota comes from the membership's own snapshot, not the live plan.
        // The plan is read for its display name only, and a missing plan does
        // not deny a paid student their seat.
        final plan = _plans.byId(m.planId);
        return MembershipValidity(
          isValid: true,
          validUntil: m.endDate,
          seatQuota: m.seatQuotaSnapshot,
          planName: plan?.name ?? '—',
          // MM-FR-067: the additional fields, so no consumer re-derives the
          // rule MM-FR-066 says must exist in exactly one place.
          studentRecordId: id,
          status: m.status,
          planId: m.planId,
        );
      }
    }

    // MM-FR-068: PendingPayment, Scheduled and Expired all report
    // isValid: false. Reporting the most recent one's status -- rather than
    // the bare `none` -- is what lets the Directory show WHY, per MM-FR-067
    // and PRD-004 LMD-16/LMD-26.
    final all = _repo.forStudent(id);
    if (all.isEmpty) return MembershipValidity.none;
    final latest = all.reduce(
      (a, b) => a.startDate.isAfter(b.startDate) ? a : b,
    );
    return MembershipValidity(
      isValid: false,
      validUntil: latest.endDate,
      seatQuota: 0,
      planName: _plans.byId(latest.planId)?.name ?? '—',
      studentRecordId: id,
      status: latest.status,
      planId: latest.planId,
    );
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
          // MM-FR-055: the inclusive last business date, not the half-open
          // DateRange bound, which is a day later.
          'validUntil': m.endDate.toIso8601String(),
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

/// `IMPL-424` — renewal.
///
/// `MM-FR-084`: renewal creates a **new** `Membership` with a new id, a new
/// term and a fresh price snapshot, and records `renewedFromMembershipId`. It
/// does not extend the source in place, and the PRD explains why: with an
/// immutable price snapshot (`MM-FR-027`) and one `FeeDue` per renewal event,
/// extending in place would make one record carry two prices and two fee
/// events, and would erase the history a library needs to answer *"what did
/// this student pay, and for which period?"*.
final class RenewMembership {
  RenewMembership({
    required this.repo,
    required this.plans,
    required this.enrollment,
    required this.calendar,
    required this.idempotency,
    required this.events,
    required this.clock,
    required this.ids,
    required this.tenant,
    required this.pdp,
  });

  final MembershipRepository repo;
  final MembershipPlanRepository plans;
  final EnrollmentStatusReader enrollment;

  /// `MM-FR-085` — "today" must be the **tenant's** business date, not the
  /// server's, because the three boundary cases turn on comparing it to
  /// `endDate` (`MM-FR-061`).
  final TenantBusinessCalendar calendar;

  final MembershipIdempotencyStore idempotency;
  final EventBus events;
  final Clock clock;
  final IdGenerator ids;
  final TenantContext tenant;
  final PolicyDecisionPoint pdp;

  /// `MM-FR-085` — the normative start-date table, as a pure function.
  ///
  /// | Case | Condition | New `startDate` |
  /// |---|---|---|
  /// | Before expiry | `Active`, `today < endDate` | `endDate + 1 day` |
  /// | On the boundary | `Active`, `today == endDate` | `endDate + 1 day` |
  /// | After expiry | `Expired`, `today > endDate` | `today` |
  ///
  /// The first two rows collapse deliberately: the source is valid for the
  /// whole of `endDate` (`MM-FR-062`), so renewing *on* the boundary is the
  /// same as renewing before it. Back-dating the third case to `endDate + 1`
  /// would sell days that have already elapsed.
  static DateTime renewalStartDate({
    required DateTime today,
    required DateTime sourceEndDate,
  }) {
    if (today.isAfter(sourceEndDate)) return today;
    return sourceEndDate.add(const Duration(days: 1));
  }

  Future<Membership> call({
    required AccessRole actorRole,
    required IdempotencyKey idempotencyKey,
    required String sourceMembershipId,
    MembershipPlan? ontoPlan,
    bool paymentAlreadyReceived = false,
  }) async {
    // MM-FR-089: idempotent per MM-FR-047, and checked first so a retry does
    // not trip over the successor its own first call created.
    final replay = idempotency.recall(idempotencyKey);
    if (replay != null) return replay;

    // Reusing createMembership rather than inventing a permission: the
    // eleven MM-PO-* protected operations are IMPL-436's subject, and that
    // task is blocked on the app-module boundary edge. Inventing a role or a
    // permission name here would pre-empt a decision that is not mine.
    pdp.require(actorRole, Permission.createMembership);

    // MM-FR-080: the source must exist in THIS tenant. The store is
    // partitioned, so a foreign id is simply absent.
    final source = repo.byId(sourceMembershipId);
    if (source == null) {
      throw DomainError(
        DomainErrorCode.notFound,
        'No membership with that id exists in this tenant.',
        context: {
          'sourceMembershipId': sourceMembershipId,
          'field': 'sourceMembershipId',
        },
      );
    }

    // MM-FR-080/082: renewable from Active or Expired ONLY. MM-FR-081 adds
    // that Expired carries no time limit in V1 and requires no re-enrollment,
    // so there is deliberately no staleness check here.
    if (source.status != MembershipStatus.active &&
        source.status != MembershipStatus.expired) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'A membership in "${source.status.name}" cannot be renewed. Only an '
        'active or expired membership may be.',
        context: {
          'sourceMembershipId': source.id,
          'status': source.status.name,
          'field': 'status',
        },
      );
    }

    // MM-FR-090/MM-INV-005: at most ONE successor by renewal.
    final existing = repo
        .forStudent(source.studentRecordId)
        .where((m) => m.renewedFromMembershipId == source.id)
        .toList();
    if (existing.isNotEmpty) {
      throw DomainError(
        DomainErrorCode.conflict,
        'This membership has already been renewed.',
        context: {
          'sourceMembershipId': source.id,
          'existingSuccessorId': existing.first.id,
          'field': 'renewedFromMembershipId',
        },
      );
    }

    // MM-FR-080: the student's enrollment must be Active. MM-BR-013's
    // fail-closed rule applies here exactly as it does to creation.
    final enrollmentState = enrollment.stateFor(source.studentRecordId);
    if (enrollmentState == null || !enrollmentState.admitsNewMembership) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'A renewal requires an active enrollment; this student is '
        '"${enrollmentState?.name ?? 'not enrolled'}".',
        context: {
          'studentRecordId': source.studentRecordId.value,
          'enrollmentStatus': enrollmentState?.name ?? 'missing',
          'field': 'enrollmentStatus',
        },
      );
    }

    // MM-FR-083: V1 renews onto the SAME plan by default. Renewing onto a
    // different plan is a new creation, not a renewal, so term arithmetic and
    // price snapshotting stay unambiguous -- so a mismatched plan is refused
    // here rather than quietly treated as a renewal.
    final plan = ontoPlan ?? plans.byId(source.planId);
    if (plan == null) {
      throw DomainError(
        DomainErrorCode.notFound,
        'The plan this membership was sold on is no longer in the catalogue.',
        context: {'planId': source.planId, 'field': 'planId'},
      );
    }
    if (plan.id != source.planId) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'V1 renews onto the same plan. Renewing onto "${plan.name}" is a new '
        'membership creation, not a renewal (MM-FR-083).',
        context: {
          'sourcePlanId': source.planId,
          'requestedPlanId': plan.id,
          'field': 'planId',
        },
      );
    }
    // MM-FR-080: the target plan must be active.
    if (!plan.isActive) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'The plan "${plan.name}" is not active and cannot be sold.',
        context: {'planId': plan.id, 'field': 'isActive'},
      );
    }

    // MM-FR-085: the boundary cases, decided against the TENANT's business
    // date (MM-FR-061) rather than the server's.
    final today = calendar.businessDateAt(clock.now());
    final start = renewalStartDate(today: today, sourceEndDate: source.endDate);

    // MM-FR-086: the new endDate comes from §4.3 using the TARGET plan's
    // CURRENT durationDays, not the duration the source was sold with.
    final term = DateRange.days(start, plan.durationDays);

    // MM-FR-092/MM-FR-087: the same payment dependency as creation. A
    // renewal before expiry starts in the future, so a settled one is
    // Scheduled until its startDate -- at which point the source is already
    // Expired, which is how MM-FR-087 avoids two active terms.
    //
    // MM-FR-088: the amount is the target plan's CURRENT price, snapshotted
    // fresh. Copying the source's snapshot is explicitly forbidden.
    final initialStatus = Membership.initialStatusFor(
      applicableAmount: plan.price,
      paymentAlreadyReceived: paymentAlreadyReceived,
      startDate: start,
      today: today,
    );

    final renewal = Membership.fromPlan(
      id: ids.next('mem'),
      studentRecordId: source.studentRecordId,
      plan: plan,
      term: term,
      status: initialStatus,
      createdAt: clock.now(),
      createdBy: tenant.actorId,
      activatedAt: initialStatus == MembershipStatus.active
          ? clock.now()
          : null,
      activatedBy: initialStatus == MembershipStatus.active
          ? tenant.actorId
          : null,
      // MM-FR-084: the lineage link.
      renewedFromMembershipId: source.id,
    );

    // MM-BR-034/MM-INV-001: enforced at the write, like every other insert.
    // MM-FR-084 also requires the source's term to be left alone, and it is:
    // nothing above mutates `source`.
    repo.insertGuardingOverlap(renewal);

    events.enqueue([
      DomainEvent(
        eventId: ids.next('evt'),
        eventType: 'membership.MembershipRenewed',
        tenantId: tenant.tenantId,
        aggregateId: renewal.id,
        occurredAt: clock.now(),
        actorId: tenant.actorId,
        correlationId: tenant.correlationId,
        payload: {
          'membershipId': renewal.id,
          'renewedFromMembershipId': source.id,
          'studentRecordId': renewal.studentRecordId.value,
          'planId': renewal.planId,
          'planName': plan.name,
          'priceMinor': renewal.priceSnapshot.minorUnits,
          'currency': renewal.currencySnapshot,
          'planVersionAtPurchase': renewal.planVersionAtPurchase,
          'status': renewal.status.name,
          'startDate': renewal.startDate.toIso8601String(),
          'validUntil': renewal.endDate.toIso8601String(),
        },
      ),
    ]);

    idempotency.remember(idempotencyKey, renewal);
    await events.drain();
    return renewal;
  }
}
