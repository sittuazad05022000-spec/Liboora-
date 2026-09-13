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

/// `MM-FR-016` — the **entire** V1 eligibility rule set, and no more.
///
/// Two rules only: an `Active` enrollment (always applied, so it is not
/// modelled as an option) and an optional age bound. A general rule engine is
/// a product in its own right and nothing in the Master PRD or EA asks for
/// one, so the type admits nothing else.
///
/// `MM-FR-017`/`MM-XC-001`: this module **MUST NOT** read, store or compute
/// from a date of birth. The bound is therefore carried as *years* and
/// evaluated by asking `BC-01` a boolean — [isSatisfiedByAge] takes an age
/// that `BC-01` resolved, never a birth date.
///
/// ⚠ `MM-GAP-003` is OPEN: whether DOB is reliably available is unresolved
/// (`GCP-05`/`SM-GAP-10`), so age eligibility stays **`MAY`** and is never
/// mandatory. This type does not resolve that gap.
final class PlanEligibility {
  const PlanEligibility({this.minAgeYears, this.maxAgeYears});

  /// No age bound — the common case. An `Active` enrollment is still required
  /// by `MM-FR-033`, which is a creation precondition rather than a plan rule.
  static const PlanEligibility enrollmentOnly = PlanEligibility();

  final int? minAgeYears;
  final int? maxAgeYears;

  bool get hasAgeBound => minAgeYears != null || maxAgeYears != null;

  /// Validates the bound itself. A reversed or negative bound is a typed
  /// rejection naming the field (`MM-FR-009`, `IMPL-403`).
  void assertValid() {
    final lo = minAgeYears;
    final hi = maxAgeYears;
    if (lo != null && lo < 0) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'minAgeYears must not be negative.',
        context: {'field': 'minAgeYears'},
      );
    }
    if (hi != null && hi < 0) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'maxAgeYears must not be negative.',
        context: {'field': 'maxAgeYears'},
      );
    }
    if (lo != null && hi != null && hi < lo) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'maxAgeYears ($hi) must not be below minAgeYears ($lo).',
        context: {'field': 'maxAgeYears'},
      );
    }
  }

  /// `MM-FR-017` — evaluated from an age supplied by `BC-01`, never derived
  /// from a stored date of birth.
  bool isSatisfiedByAge(int ageYears) {
    final lo = minAgeYears;
    final hi = maxAgeYears;
    if (lo != null && ageYears < lo) return false;
    if (hi != null && ageYears > hi) return false;
    return true;
  }
}

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
    this.eligibility = PlanEligibility.enrollmentOnly,
  });

  /// `MM-FR-018` — create, with every `MM-FR-008`…`015` field validated
  /// before an instance exists.
  ///
  /// Validation lives in a factory rather than in the caller, so there is no
  /// path that constructs an invalid plan and validates it afterwards.
  /// `IMPL-403`'s obligation is that each field's validation *"rejects with a
  /// typed error naming the field"*.
  factory MembershipPlan.create({
    required String id,
    required TenantId tenantId,
    required BranchId branchId,
    required String name,
    required int durationDays,
    required Money price,
    required DateTime createdAt,
    required String createdBy,
    PlanAvailability availability = PlanAvailability.public,
    bool isActive = true,
    String? description,
    int seatQuota = 0,
    PlanEligibility eligibility = PlanEligibility.enrollmentOnly,
  }) {
    _assertFields(
      id: id,
      name: name,
      durationDays: durationDays,
      price: price,
      createdBy: createdBy,
      seatQuota: seatQuota,
      eligibility: eligibility,
    );
    return MembershipPlan(
      id: id,
      tenantId: tenantId,
      branchId: branchId,
      name: name,
      durationDays: durationDays,
      price: price,
      createdAt: createdAt,
      createdBy: createdBy,
      availability: availability,
      isActive: isActive,
      description: description,
      seatQuota: seatQuota,
      eligibility: eligibility,
    );
  }

  static void _assertFields({
    required String id,
    required String name,
    required int durationDays,
    required Money price,
    required String createdBy,
    required int seatQuota,
    required PlanEligibility eligibility,
  }) {
    void reject(String field, String message) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        message,
        context: {'field': field},
      );
    }

    if (id.trim().isEmpty) reject('planId', 'planId must not be blank.');
    if (createdBy.trim().isEmpty) {
      reject('createdBy', 'createdBy must not be blank.');
    }
    // MM-FR-010's uniqueness is a repository concern; blankness is not.
    if (name.trim().isEmpty) reject('name', 'Plan name must not be blank.');
    // MM-FR-011 — a positive integer, in days.
    if (durationDays <= 0) {
      reject(
        'durationDays',
        'durationDays must be a positive integer, got $durationDays.',
      );
    }
    // MM-FR-012 — non-negative, and Money already guarantees minor units
    // rather than a floating-point type.
    if (price.minorUnits < 0) {
      reject('price', 'price must not be negative.');
    }
    // MM-FR-013 — an ISO-4217 code.
    if (!_isIso4217(price.currency)) {
      reject(
        'currency',
        '"${price.currency}" is not an ISO-4217 currency code.',
      );
    }
    // MM-FR-014 — a non-negative integer.
    if (seatQuota < 0) {
      reject('seatQuota', 'seatQuota must not be negative.');
    }
    eligibility.assertValid();
  }

  /// `MM-FR-013` — shape check only.
  ///
  /// Deliberately **not** a closed list of currencies: `PRD-005` names no
  /// allowed set and `MM-CFG-001` merely supplies a default, so enumerating
  /// one here would invent a requirement. Three upper-case letters is what
  /// ISO-4217 specifies and all this module is entitled to assert.
  static bool _isIso4217(String code) => RegExp(r'^[A-Z]{3}$').hasMatch(code);

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

  /// `MM-FR-016` — optional, and limited to the two specified rules.
  final PlanEligibility eligibility;

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
    PlanEligibility? eligibility,
  }) {
    // MM-FR-024: currency is IMMUTABLE once any membership references the
    // plan. Money carries its currency, so a price edit could smuggle one in.
    final nextPrice = price ?? this.price;
    if (nextPrice.currency != this.price.currency) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'A plan\'s currency cannot change: it would silently restate the '
        'meaning of every price snapshot taken against it.',
        context: {'field': 'currency', 'planId': id},
      );
    }

    // An edit is validated by the same rules as a creation. A plan that could
    // be edited into an invalid state is not validated, merely gated.
    _assertFields(
      id: id,
      name: name ?? this.name,
      durationDays: durationDays ?? this.durationDays,
      price: nextPrice,
      createdBy: createdBy,
      seatQuota: seatQuota ?? this.seatQuota,
      eligibility: eligibility ?? this.eligibility,
    );

    return MembershipPlan(
      id: id,
      tenantId: tenantId,
      branchId: branchId,
      name: name ?? this.name,
      durationDays: durationDays ?? this.durationDays,
      price: nextPrice,
      createdAt: createdAt,
      createdBy: createdBy,
      availability: availability ?? this.availability,
      isActive: isActive ?? this.isActive,
      version: version + 1,
      description: description ?? this.description,
      seatQuota: seatQuota ?? this.seatQuota,
      eligibility: eligibility ?? this.eligibility,
    );
  }

  /// `MM-FR-020`/`MM-BR-029` — selectable for create, renew or upgrade.
  ///
  /// One predicate, so the three call sites cannot drift apart. Tenant match
  /// is the caller's ambient concern (`MM-BR-027`); this answers the plan's
  /// own half.
  bool get isSelectable => isActive;

  /// `MM-FR-015` — a `StaffOnly` plan never appears in a student-facing list
  /// (`MM-AC-012`).
  bool get isStudentVisible =>
      isActive && availability == PlanAvailability.public;

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
    this.seatQuotaSnapshot = 0,
    this.createdAt,
    this.createdBy,
    DateTime? activatedAt,
    String? activatedBy,
    this.renewedFromMembershipId,
    this.upgradedFromMembershipId,
  }) : _status = status,
       _activatedAt = activatedAt,
       _activatedBy = activatedBy {
    // MM-INV-010: exactly one plan reference, never zero.
    if (planId.trim().isEmpty) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'A membership must reference exactly one plan.',
        context: {'field': 'planId', 'membershipId': id},
      );
    }
    // MM-FR-012 / §13.1: priceSnapshot >= 0.
    if (priceSnapshot.minorUnits < 0) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'priceSnapshot must not be negative.',
        context: {'field': 'priceSnapshot', 'membershipId': id},
      );
    }
    // MM-INV-011: activatedAt is set if and only if the membership has ever
    // been Active. Constructing a PendingPayment row that already claims an
    // activation timestamp would make the audit trail lie.
    if (_activatedAt != null && _status == MembershipStatus.pendingPayment) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'activatedAt cannot be set on a membership that has never been '
        'active.',
        context: {'field': 'activatedAt', 'membershipId': id},
      );
    }
  }

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
    DateTime? createdAt,
    String? createdBy,
    DateTime? activatedAt,
    String? activatedBy,
    String? renewedFromMembershipId,
    String? upgradedFromMembershipId,
  }) => Membership(
    id: id,
    studentRecordId: studentRecordId,
    planId: plan.id,
    term: term,
    priceSnapshot: plan.price,
    planVersionAtPurchase: plan.version,
    // MM-FR-025: the quota published for an active membership must not move
    // when the plan's quota changes, so it is snapshotted like the price.
    seatQuotaSnapshot: plan.seatQuota,
    status: status,
    createdAt: createdAt,
    createdBy: createdBy,
    activatedAt: activatedAt,
    activatedBy: activatedBy,
    renewedFromMembershipId: renewedFromMembershipId,
    upgradedFromMembershipId: upgradedFromMembershipId,
  );

  /// `MM-FR-041` — the initial status, decided by the payment condition and
  /// **never invented**.
  ///
  /// `PendingPayment` when an amount is owed and no outcome has arrived;
  /// `Active` when the amount is zero or a payment outcome already exists.
  ///
  /// `MM-BR-001`/`MM-BR-002`: the *amount* comes from the plan's own snapshot
  /// and the *outcome* is a boolean this module was told, over `E-10`. No
  /// ledger is read, no balance is computed, no gateway is called — which is
  /// why the parameter is `paymentAlreadyReceived` and not an amount paid.
  static MembershipStatus initialStatusFor({
    required Money applicableAmount,
    required bool paymentAlreadyReceived,
    DateTime? startDate,
    DateTime? today,
  }) {
    final settled = applicableAmount.minorUnits == 0 || paymentAlreadyReceived;
    if (!settled) return MembershipStatus.pendingPayment;

    // MM-FR-053: a settled membership whose startDate is still in the future
    // is held in Scheduled and confers nothing until that date. MM-FR-074's
    // table says the same thing as a transition row:
    //   -- -> Scheduled  (amount = 0 or already paid, FUTURE startDate)
    //   -- -> Active     (amount = 0 or already paid, startDate = today)
    //
    // Without this, an advance sale made in March for an April term would
    // confer entitlement in March -- a student walking in today with an
    // April membership would be let through.
    if (startDate != null && today != null && startDate.isAfter(today)) {
      return MembershipStatus.scheduled;
    }
    return MembershipStatus.active;
  }

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

  /// §13.1 — the seat allowance conferred, snapshotted. `MM-FR-025`.
  final int seatQuotaSnapshot;

  /// §13.1 creation metadata. UTC (`MM-FR-063`).
  final DateTime? createdAt;
  final String? createdBy;

  /// §13.1 — `renewedFromMembershipId` / `upgradedFromMembershipId`.
  ///
  /// Lineage **fields only**. §24.1 classifies these as `B — Recommended for
  /// V1` precisely because *"the Membership History feature surface remains
  /// V2"*, so the ids are carried and no history UI is implied.
  final String? renewedFromMembershipId;
  final String? upgradedFromMembershipId;

  DateTime? _activatedAt;
  String? _activatedBy;

  /// §13.1 — write-once activation metadata. `MM-INV-011`: set if and only if
  /// the membership has ever been `Active`.
  DateTime? get activatedAt => _activatedAt;
  String? get activatedBy => _activatedBy;

  /// `MM-BR-001` / `MM-XC-004` — the money boundary, stated as a property.
  ///
  /// This aggregate holds an *amount that applies* and nothing else: no
  /// balance, no receipt, no refund, no ledger entry. The distinction is the
  /// whole reason `BC-05` exists.
  Money get applicableAmount => priceSnapshot;

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

  /// Calendar day, without a time component that would imply more precision
  /// than a term has (`MM-FR-056`: a term is a date range, not a timestamp
  /// range).
  static String _isoDay(DateTime d) => d.toIso8601String().substring(0, 10);

  /// Invariant `MM-INV-001`: no overlapping active terms for one student.
  /// [existing] is supplied by the repository — the aggregate does not query.
  static void assertNoOverlap(List<Membership> existing, DateRange proposed) {
    for (final m in existing) {
      // MM-FR-049 counts any NON-TERMINAL membership as a conflict, not only
      // an entitling one. A PendingPayment row already holds the student's
      // term: letting a second sale overlap it would create the double-booking
      // MM-INV-001 forbids, and would then activate into two live memberships
      // the moment both payments landed.
      if (!m.status.isTerminal && m.term.overlaps(proposed)) {
        throw DomainError(
          DomainErrorCode.overlappingMembershipTerm,
          'This student already has a membership from '
          '${_isoDay(m.term.start)} to ${_isoDay(m.term.end)} '
          '(status: ${m.status.name}).',
          // MM-FR-049: name the conflicting membershipId AND its term, so the
          // actor can tell which sale is in the way rather than guessing. The
          // existing membership is deliberately NOT returned -- they may have
          // intended a different plan.
          context: {
            'existingMembershipId': m.id,
            'existingStatus': m.status.name,
            'existingStartDate': _isoDay(m.term.start),
            'existingEndDate': _isoDay(m.term.end),
          },
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
  ///
  /// `MM-INV-011` — `activatedAt` is written **once**, on the first
  /// activation. A later transition through `Active` must not overwrite it:
  /// the audit question is *"when did entitlement begin"*, and that has one
  /// answer per membership.
  void activate({DateTime? at, String? by}) {
    _transitionTo(MembershipStatus.active);
    _activatedAt ??= at;
    _activatedBy ??= by;
  }

  /// `MM-FR-052` — activation is permitted only when the **term window** also
  /// allows it: `startDate` reached, `endDate` not passed.
  ///
  /// Separate from [activate] because the transition table (`MM-FR-074`) and
  /// the term window are two different gates, and `MM-FR-052` requires
  /// *both*. Activating a membership whose `endDate` has already passed would
  /// produce an `Active` row that confers nothing — valid by the status
  /// machine and wrong by the calendar.
  void activateOn(DateTime day, {String? by}) {
    if (day.isBefore(term.start)) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'This membership cannot activate before its start date '
        '(${_isoDay(term.start)}).',
        context: {
          'membershipId': id,
          'startDate': _isoDay(term.start),
          'attemptedOn': _isoDay(day),
        },
      );
    }
    if (!term.contains(day)) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'This membership cannot activate after its end date '
        '(${_isoDay(term.end)}).',
        context: {
          'membershipId': id,
          'endDate': _isoDay(term.end),
          'attemptedOn': _isoDay(day),
        },
      );
    }
    activate(at: day, by: by);
  }

  /// `MM-FR-054`/`MM-CFG-007` — has this `PendingPayment` membership sat
  /// unpaid past the void window?
  ///
  /// A predicate rather than a mutation: the *decision* is the aggregate's,
  /// but voiding is a command with an actor and an event behind it
  /// (`MM-EVT-007`), so the aggregate does not quietly cancel itself.
  bool isStalePendingPayment(DateTime now, {required Duration window}) {
    if (_status != MembershipStatus.pendingPayment) return false;
    final since = createdAt;
    if (since == null) return false;
    return now.difference(since) > window;
  }

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
