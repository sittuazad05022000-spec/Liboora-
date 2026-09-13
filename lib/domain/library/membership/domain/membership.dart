/// **BC-02 Membership** — aggregates `MembershipPlan` and `Membership`.
///
/// Owns the commercial right-to-use. `MembershipPlan` here is what a library
/// sells to a *student* — not `SubscriptionPlan`, which is what Liboora sells
/// to a *library* (BC-20). BC Map L203 warns the two must never be conflated.
///
/// Implements `IMPL-401` (plan aggregate root, identity and version) and
/// `IMPL-420` (the six-value status set and the closed transition machine)
/// against FROZEN `PRD-005` v1.4 at Rank 3.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

/// `MM-FR-015` — a plan is offerable to any enrolled student, or to staff only.
enum PlanAvailability { public, staffOnly }

/// `MM-FR-072` — the closed set of **exactly six** V1 values.
///
/// `Frozen` is deliberately **absent**, not merely unused. `MM-FR-073` makes it
/// unreachable and `MM-INV-012` makes that an invariant; `MM-XC-009` excludes
/// Membership Freeze from V1 altogether. `MM-FR-073` permits the field to *"be
/// modelled to admit it later"* but does not require it, so the stronger
/// reading is taken: a status that cannot be named cannot be reached by any
/// command, including one written in a year's time by someone who has not read
/// the PRD. `IMPL-420`'s test obligation is *"a seventh status is
/// unrepresentable"* — an enum with seven members would fail it.
enum MembershipStatus {
  pendingPayment,
  scheduled,
  active,
  expired,
  superseded,
  cancelled;

  /// `MM-FR-075` — `Expired`, `Superseded` and `Cancelled` are terminal.
  ///
  /// A renewal creates a **new** membership rather than reviving one of these
  /// (§6.2, `MM-BR-020`). That is why no method on [Membership] leaves a
  /// terminal state.
  bool get isTerminal =>
      this == MembershipStatus.expired ||
      this == MembershipStatus.superseded ||
      this == MembershipStatus.cancelled;

  /// `MM-BR-032` — only `Active` confers entitlement. The other five confer
  /// nothing, which `MM-AC-085` states for each by name.
  bool get confersEntitlement => this == MembershipStatus.active;
}

/// `MM-FR-006` — a **separate aggregate root** from [Membership].
///
/// BC Map §8: *"The aggregate is the transaction boundary — one aggregate, one
/// database transaction, no exceptions."* A plan is edited by an owner at
/// leisure; a membership is created at a reception desk under time pressure.
/// Different lifecycles, different actors, different contention profiles — so
/// editing a plan may never share a transaction with creating a membership.
///
/// Immutable by construction. `MM-FR-022` requires every edit to increment
/// `version`, so an edit produces a **new instance** via [withEdits] rather
/// than mutating this one. `planId`, `tenantId` and `branchId` are not
/// parameters of [withEdits] at all: `MM-FR-021` marks them IMMUTABLE, and a
/// field that cannot be named cannot be changed.
final class MembershipPlan {
  const MembershipPlan({
    required this.id,
    required this.tenantId,
    required this.branchId,
    required this.name,
    required this.durationDays,
    required this.price,
    required this.createdAt,
    required this.createdBy,
    this.availability = PlanAvailability.public,
    this.isActive = true,
    this.version = 1,
    this.description,
    this.seatQuota = 0,
  });

  /// `MM-FR-008` — required. `MM-FR-021` — IMMUTABLE (identity).
  final String id;

  /// `MM-FR-007` — scoped to exactly one tenant. `MM-FR-021` — IMMUTABLE.
  ///
  /// Changing it would be a cross-tenant data move, which `X-13` forbids.
  final TenantId tenantId;

  /// `MM-FR-007` — modelled in V1 even though multi-branch is V3
  /// (`Q-02`/`MP-CON-13`). `MM-FR-021` — IMMUTABLE.
  final BranchId branchId;

  final String name;

  /// `MM-FR-011` — a positive integer, expressed in **days, not months**.
  ///
  /// A "1 month" plan is ambiguous on 31 January, and the ambiguity lands on
  /// exactly the month-end and leap-year cases §21 requires to be
  /// deterministic. A library selling "monthly" configures 30.
  final int durationDays;

  /// Carries `currency` with it, so `MM-FR-008`'s `price` and `currency` can
  /// never disagree. A second free-standing currency field would be a way for
  /// them to drift.
  final Money price;

  final DateTime createdAt;
  final String createdBy;
  final PlanAvailability availability;

  /// `MM-FR-018`/`MM-FR-020` — deactivation is the retirement path; an
  /// inactive plan is not selectable for a new membership.
  final bool isActive;

  /// `MM-FR-022` — incremented by every edit. `MM-FR-026` snapshots it onto
  /// the membership as `planVersionAtPurchase`, so a pricing dispute can name
  /// the exact revision that was sold.
  final int version;

  /// `MM-FR-009` — optional.
  final String? description;

  /// Seats *included*, distinct from `Seat` (BC-04) which is a physical
  /// position. See the ubiquitous language table. `MM-FR-009` — optional.
  final int seatQuota;

  /// `MM-FR-008` — exposed as a named field, derived from [price] so the two
  /// are structurally incapable of disagreeing.
  String get currency => price.currency;

  /// `MM-FR-010` — the uniqueness scope for `name`: per tenant **and** branch,
  /// so reception staff are never shown two identically named plans.
  String get uniquenessScope => '${tenantId.value}::${branchId.value}';

  /// `MM-FR-022` — an edit increments `version`.
  ///
  /// Scope and identity are absent from the parameter list by design
  /// (`MM-FR-021`). The full post-use mutability table (`MM-FR-023`…`025`) is
  /// `IMPL-406` and is **not** enforced here; this method exists so that
  /// `IMPL-401`'s version rule holds for every edit that does occur.
  MembershipPlan withEdits({
    String? name,
    int? durationDays,
    Money? price,
    PlanAvailability? availability,
    bool? isActive,
    String? description,
    int? seatQuota,
  }) => MembershipPlan(
    id: id,
    tenantId: tenantId,
    branchId: branchId,
    name: name ?? this.name,
    durationDays: durationDays ?? this.durationDays,
    price: price ?? this.price,
    createdAt: createdAt,
    createdBy: createdBy,
    availability: availability ?? this.availability,
    isActive: isActive ?? this.isActive,
    version: version + 1,
    description: description ?? this.description,
    seatQuota: seatQuota ?? this.seatQuota,
  );

  /// `MM-FR-018` — deactivate. `MM-FR-019` — this leaves every committed
  /// membership untouched, which holds structurally because a membership holds
  /// snapshots rather than a live reference.
  MembershipPlan deactivate() => withEdits(isActive: false);

  MembershipPlan activate() => withEdits(isActive: true);
}

/// `MM-BR-020` — one membership, one transaction.
///
/// Holds `planId` plus the `MM-FR-026` snapshots rather than the plan object.
/// That is the structural reason `MM-FR-023` holds: a price edit cannot reach
/// backwards into a sold term, because the sold term does not read the plan.
final class Membership {
  Membership({
    required this.id,
    required this.studentRecordId,
    required this.planId,
    required this.term,
    required this.priceSnapshot,
    required this.planVersionAtPurchase,
    MembershipStatus status = MembershipStatus.active,
  }) : _status = status;

  /// Takes the `MM-FR-026` snapshots from [plan] *"at that moment"*.
  ///
  /// A snapshot read from anywhere other than the plan being sold is how the
  /// amount and the version come to disagree.
  factory Membership.fromPlan({
    required String id,
    required StudentRecordId studentRecordId,
    required MembershipPlan plan,
    required DateRange term,
    MembershipStatus status = MembershipStatus.active,
  }) => Membership(
    id: id,
    studentRecordId: studentRecordId,
    planId: plan.id,
    term: term,
    priceSnapshot: plan.price,
    planVersionAtPurchase: plan.version,
    status: status,
  );

  final String id;
  final StudentRecordId studentRecordId;

  /// `MM-BR-021` — exactly one plan reference, never zero.
  final String planId;

  final DateRange term;

  /// `MM-FR-026`/`MM-FR-027` — immutable for the life of the membership.
  ///
  /// `final`, so `MM-INV-006` (*"historical pricing cannot change"*) is a
  /// compile-time property rather than a rule someone must remember.
  final Money priceSnapshot;

  /// `MM-FR-026` — `currencySnapshot`, derived from [priceSnapshot] so the
  /// amount and its currency cannot be separated or made to disagree.
  String get currencySnapshot => priceSnapshot.currency;

  /// `MM-FR-026`/`MM-FR-027` — immutable. Proves *which* plan revision was
  /// sold; a price alone cannot.
  final int planVersionAtPurchase;

  /// Mutable only through the `MM-FR-074` transition machine below.
  MembershipStatus _status;

  MembershipStatus get status => _status;

  /// `MM-FR-065`/`MM-BR-032` — validity is decided at read time by the term
  /// and the status together, never by a stored flag.
  bool isValidOn(DateTime day) =>
      _status.confersEntitlement && term.contains(day);

  int daysRemainingFrom(DateTime now) => term.daysRemainingFrom(now);

  bool expiringSoon(DateTime now, {int within = 7}) {
    final d = daysRemainingFrom(now);
    return _status.confersEntitlement && d > 0 && d <= within;
  }

  /// Invariant `MM-INV-001`: no overlapping active terms for one student.
  /// [existing] is supplied by the repository — the aggregate does not query.
  static void assertNoOverlap(List<Membership> existing, DateRange proposed) {
    for (final m in existing) {
      if (m.status.confersEntitlement && m.term.overlaps(proposed)) {
        throw DomainError(
          DomainErrorCode.overlappingMembershipTerm,
          'This student already has an active membership until '
          '${m.term.end.toIso8601String().substring(0, 10)}.',
          context: {'existingMembershipId': m.id},
        );
      }
    }
  }

  /// `MM-FR-074` — the **only** permitted V1 transitions. Any other is
  /// impossible, which is what makes this table normative rather than
  /// advisory.
  ///
  /// Payment *triggers* are deliberately absent: `MM-BR-001`…`003` place money
  /// outside `BC-02` entirely, so this machine models the state change and
  /// never the condition that authorises it.
  static const Map<MembershipStatus, Set<MembershipStatus>> _allowed = {
    MembershipStatus.pendingPayment: {
      MembershipStatus.scheduled,
      MembershipStatus.active,
      MembershipStatus.cancelled,
    },
    MembershipStatus.scheduled: {
      MembershipStatus.active,
      MembershipStatus.cancelled,
    },
    MembershipStatus.active: {
      MembershipStatus.expired,
      MembershipStatus.superseded,
    },
    // MM-FR-075: terminal. No outbound transition exists, so a renewal has no
    // choice but to create a new membership.
    MembershipStatus.expired: <MembershipStatus>{},
    MembershipStatus.superseded: <MembershipStatus>{},
    MembershipStatus.cancelled: <MembershipStatus>{},
  };

  void _transitionTo(MembershipStatus next) {
    final permitted = _allowed[_status] ?? const <MembershipStatus>{};
    if (!permitted.contains(next)) {
      throw DomainError(
        DomainErrorCode.membershipNotActive,
        'A membership cannot move from ${_status.name} to ${next.name}. '
        '${_status.isTerminal ? '${_status.name} is terminal; a renewal must '
                  'create a new membership.' : 'MM-FR-074 does not permit it.'}',
        context: {'membershipId': id, 'from': _status.name, 'to': next.name},
      );
    }
    _status = next;
  }

  /// `PendingPayment` → `Scheduled`. The payment condition is satisfied but
  /// `startDate` has not been reached, so nothing is conferred yet.
  void schedule() => _transitionTo(MembershipStatus.scheduled);

  /// → `Active`. Entitlement begins.
  void activate() => _transitionTo(MembershipStatus.active);

  /// `Active` → `Expired` when `endDate` has passed.
  void expire() => _transitionTo(MembershipStatus.expired);

  /// `Active` → `Superseded`, on an upgrade commit (§6).
  ///
  /// The *upgrade* use case is `IMPL-427` and is not implemented; this is the
  /// status half only, present because `MM-FR-074` lists the edge and
  /// `MM-FR-075` requires `Superseded` to exist as a terminal state.
  void supersede() => _transitionTo(MembershipStatus.superseded);

  /// `MM-FR-078` — void before activation. Not a V2 cancellation-with-refund
  /// (`MM-XC-011`): permitted only from a state that never conferred
  /// entitlement, which the transition table enforces.
  void cancel() => _transitionTo(MembershipStatus.cancelled);

  /// `Q-06` — Membership computes the entitlement *delta*; the Business
  /// Platform executes the money. Returns value, never a charge.
  ///
  /// Reads the immutable `MM-FR-026` snapshot, so the credit cannot be altered
  /// by a later plan edit. Behaviour is unchanged from the pre-`IMPL-401`
  /// implementation: the term's length equals the `durationDays` sold, because
  /// the term was constructed from it.
  Money prorationCreditFor(DateTime now) {
    final remaining = daysRemainingFrom(now);
    if (remaining <= 0) return Money.zero;
    return priceSnapshot.prorate(remaining, term.lengthInDays);
  }
}
