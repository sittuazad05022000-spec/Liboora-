/// **The 12 certified `DashboardMetrics` metrics — `IMPL-2005`**
///
/// Certified by `Accepted` **`ADR-0147`** (2026-09-18), which resolved
/// `ANL-OBD-001`: a Certified Metric definition is owned **jointly** by the
/// Product Owner and the Architecture Owner.
///
/// Every definition below is transcribed from `ADR-0147` §3. Nothing here
/// invents a business meaning, a threshold, a period or a payload contract.
///
/// ## Why this file exists rather than more entries in `semantic_layer.dart`
///
/// `ADR-0097`'s `ProfileViews` must remain byte-unchanged (`ADR-0147` header),
/// and mixing two certification instruments in one declaration site makes it
/// hard to see which ADR authorises which metric. `AN-2` — "no metric defined
/// outside the semantic layer" — is satisfied because this file **is** part of
/// the semantic layer: it lives in `platform/analytics`, it takes the
/// `CertifiedMetric` type from `semantic_layer.dart`, and no module outside
/// this layer constructs one.
///
/// ## What `ADR-0147` did NOT certify
///
/// - `UniqueViewers` — still NOT certified (`ADR-0097` §5, rules `U1`-`U8`).
/// - No 13th metric. The certified set is exactly `ProfileViews` + these 12.
/// - No `guardianOf` scope: `ANL-OBD-004` is OPEN and HIGH RISK.
library;

import 'semantic_layer.dart';

/// The shared `freshnessExpectation` for all 12 — `ADR-0147` §3.3.
///
/// Transcribed from `ADR-0097` §4.2, which discharges `ANL-FR-057`
/// behaviourally. `ANL-CFG-003`'s numeric threshold remains OWED to SRE
/// (`ANL-GAP-020`); no number is substituted here.
const String _freshness =
    'Where BC-26 is unavailable or the value cannot be resolved, the surface '
    'MUST mark itself temporarily unavailable. It MUST NOT render zero, a '
    'stale value of unknown age, or an inferred value. ADR-0097 section 4.2. '
    'The numeric threshold ANL-CFG-003 is OWED to SRE (ANL-GAP-020).';

/// `timeSemantics` for the six `...Today` metrics — `ADR-0147` §3.1 regime 1.
const String _istDay =
    'The half-open IST interval [00:00:00 IST, next-day 00:00:00 IST), '
    'start-inclusive and end-exclusive, evaluated against the event own '
    'occurredAt and NEVER against a read-time clock. IST is fixed by '
    'ANL-FR-055 and MP-CON-12. Event time is required by ANL-INV-005: a '
    'wall-clock read inside projection logic makes replay non-deterministic. '
    'No other period is certified.';

/// `timeSemantics` for the four cumulative metrics — §3.1 regime 2.
const String _cumulative =
    'Cumulative since inception. No window, reset or comparison period is '
    'certified: ADR-0097 T5 certifies no period beyond the ProfileViews '
    '7-day window, and PRD-009 supplies none for these counters.';

/// `owningContext` for all 12 — BC Map L135 and L385.
const String _owner = 'BC-26 Analytics Read Model';

const String _countUnit =
    'A dimensionless non-negative integer count of events';

const String _minorUnit =
    'INR minor units as an integer. Deliberately not Money: PRD-009 section '
    '8.3 states analytics must not depend on domain arithmetic rules, only on '
    'reported amounts.';

/// The 12 metrics certified by `ADR-0147`, in `DashboardMetrics` field order.
///
/// `ANL-INV-004` — exactly one active definition per `metricId` per version —
/// is enforced by [CertifiedMetricRegistry.register], which throws on a
/// duplicate versioned key.
abstract final class DashboardMetricsCatalog {
  /// 1 — `ADR-0147` §3.2 row 1.
  static final CertifiedMetric studentsEnrolled = CertifiedMetric(
    metricId: 'StudentsEnrolled',
    name: 'Students enrolled',
    definition:
        'The cumulative count of students enrolled in the tenant since '
        'inception.',
    sourceEvents: const <String>['enrollment.StudentEnrolled'],
    calculation:
        'One qualifying enrollment.StudentEnrolled fact increments the count '
        'by exactly one. Idempotent on eventId (ANL-FR-003). No fact is '
        'attributed to any other tenant (ANL-INV-006).',
    owningContext: _owner,
    timeSemantics: _cumulative,
    freshnessExpectation: _freshness,
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    unit: _countUnit,
  );

  /// 2 — `ADR-0147` §3.2 row 2.
  static final CertifiedMetric membershipsCreated = CertifiedMetric(
    metricId: 'MembershipsCreated',
    name: 'Memberships created',
    definition:
        'The cumulative count of memberships created in the tenant since '
        'inception.',
    sourceEvents: const <String>['membership.MembershipCreated'],
    calculation:
        'One membership.MembershipCreated fact (MM-EVT-001) increments the '
        'count by exactly one. Idempotent on eventId.',
    owningContext: _owner,
    timeSemantics: _cumulative,
    freshnessExpectation: _freshness,
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    unit: _countUnit,
  );

  /// 3 — `ADR-0147` §3.2 row 3.
  static final CertifiedMetric checkInsToday = CertifiedMetric(
    metricId: 'CheckInsToday',
    name: 'Check-ins today',
    definition: 'The count of student check-ins recorded on one IST day.',
    sourceEvents: const <String>['attendance.StudentCheckedIn'],
    calculation:
        'One attendance.StudentCheckedIn fact (ATT-EVT-001) whose occurredAt '
        'falls inside the IST day interval increments the count by exactly '
        'one.',
    owningContext: _owner,
    timeSemantics: _istDay,
    freshnessExpectation: _freshness,
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    unit: _countUnit,
  );

  /// 4 — `ADR-0147` §3.2 row 4.
  static final CertifiedMetric checkOutsToday = CertifiedMetric(
    metricId: 'CheckOutsToday',
    name: 'Check-outs today',
    definition: 'The count of student check-outs recorded on one IST day.',
    sourceEvents: const <String>['attendance.StudentCheckedOut'],
    calculation:
        'One attendance.StudentCheckedOut fact (ATT-EVT-002) whose occurredAt '
        'falls inside the IST day interval increments the count by exactly '
        'one.',
    owningContext: _owner,
    timeSemantics: _istDay,
    freshnessExpectation: _freshness,
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    unit: _countUnit,
  );

  /// 5 — `ADR-0147` §3.2 row 5.
  ///
  /// BC-26 counts the flag as received. It does NOT define lateness: the
  /// `lateEntryPolicy` belongs to `BC-06` Library Policy and reaches `BC-03`
  /// over `E-04` (`ATT-PO-002`, "conform, do not translate").
  static final CertifiedMetric lateEntriesToday = CertifiedMetric(
    metricId: 'LateEntriesToday',
    name: 'Late entries today',
    definition:
        'The count of check-ins on one IST day that BC-03 flagged as a late '
        'entry. BC-26 counts the flag as received and does not define '
        'lateness: the lateEntryPolicy is owned by BC-06 Library Policy and '
        'reaches BC-03 over E-04.',
    sourceEvents: const <String>['attendance.StudentCheckedIn'],
    calculation:
        'A qualifying attendance.StudentCheckedIn fact inside the IST day '
        'interval whose lateEntry flag is true increments the count by one. '
        'An absent or non-true flag does not increment.',
    owningContext: _owner,
    timeSemantics: _istDay,
    freshnessExpectation: _freshness,
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    unit: _countUnit,
  );

  /// 6 — `ADR-0147` §3.2 row 6.
  ///
  /// Membership validity belongs to `BC-02` and reaches `BC-03` over `E-03`,
  /// which "flags, never blocks" (`ATT-PO-001`).
  static final CertifiedMetric flaggedEntriesToday = CertifiedMetric(
    metricId: 'FlaggedEntriesToday',
    name: 'Flagged entries today',
    definition:
        'The count of check-ins on one IST day where the membership-validity '
        'projection was flagged invalid. Validity is owned by BC-02 '
        'Membership and reaches BC-03 over E-03, which flags and never '
        'blocks.',
    sourceEvents: const <String>['attendance.StudentCheckedIn'],
    calculation:
        'A qualifying attendance.StudentCheckedIn fact inside the IST day '
        'interval whose membershipValid flag is false increments the count by '
        'one. An absent flag does not increment.',
    owningContext: _owner,
    timeSemantics: _istDay,
    freshnessExpectation: _freshness,
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    unit: _countUnit,
  );

  /// 7 — `ADR-0147` §3.2 row 7.
  static final CertifiedMetric seatsAssigned = CertifiedMetric(
    metricId: 'SeatsAssigned',
    name: 'Seats assigned',
    definition:
        'The cumulative count of seat allocations becoming Active, from any '
        'origin, since inception.',
    sourceEvents: const <String>['seating.SeatAssigned'],
    calculation:
        'One seating.SeatAssigned fact (SEAT-EVT-001, emitted when an '
        'allocation becomes Active from any origin) increments the count by '
        'exactly one. This is an ALLOCATION count and MUST NOT be presented '
        'as occupancy (SEAT-FR-245).',
    owningContext: _owner,
    timeSemantics: _cumulative,
    freshnessExpectation: _freshness,
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    unit: _countUnit,
  );

  /// 8 — `ADR-0147` §3.2 row 8.
  static final CertifiedMetric seatsReleased = CertifiedMetric(
    metricId: 'SeatsReleased',
    name: 'Seats released',
    definition:
        'The cumulative count of seat allocations becoming Released, from any '
        'cause, since inception.',
    sourceEvents: const <String>['seating.SeatReleased'],
    calculation:
        'One seating.SeatReleased fact (SEAT-EVT-002, emitted when an '
        'allocation becomes Released from any cause) increments the count by '
        'exactly one.',
    owningContext: _owner,
    timeSemantics: _cumulative,
    freshnessExpectation: _freshness,
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    unit: _countUnit,
  );

  /// 9 — `ADR-0147` §3.2 row 9.
  ///
  /// PENDING payments are excluded BY DEFINITION, not by filtering:
  /// `FEE-EVT-002` publishes "only when a payment reaches CONFIRMED".
  static final CertifiedMetric collectedTodayMinor = CertifiedMetric(
    metricId: 'CollectedTodayMinor',
    name: 'Collected today',
    definition:
        'The sum, in INR minor units, of payments confirmed on one IST day. '
        'PENDING payments are excluded by definition: FEE-EVT-002 publishes '
        'fee.FeePaymentReceived only when a payment reaches CONFIRMED.',
    sourceEvents: const <String>['fee.FeePaymentReceived'],
    calculation:
        'For each fee.FeePaymentReceived fact whose occurredAt falls inside '
        'the IST day interval, add its amountMinor to the running sum. A '
        'missing amount contributes zero. BC-26 performs no currency '
        'arithmetic beyond addition of reported minor units.',
    owningContext: _owner,
    timeSemantics: _istDay,
    freshnessExpectation: _freshness,
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    unit: _minorUnit,
  );

  /// 10 — `ADR-0147` §3.2 row 10.
  static final CertifiedMetric duesRaisedTodayMinor = CertifiedMetric(
    metricId: 'DuesRaisedTodayMinor',
    name: 'Dues raised today',
    definition:
        'The sum, in INR minor units, of fee obligations created on one IST '
        'day.',
    sourceEvents: const <String>['fee.FeeDueRaised'],
    calculation:
        'For each fee.FeeDueRaised fact (FEE-EVT-001, published when an '
        'obligation is created) whose occurredAt falls inside the IST day '
        'interval, add its amountMinor to the running sum. A missing amount '
        'contributes zero.',
    owningContext: _owner,
    timeSemantics: _istDay,
    freshnessExpectation: _freshness,
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    unit: _minorUnit,
  );

  /// 11 — `ADR-0147` §3.5. The presence-qualified occupancy metric.
  ///
  /// SeatsAssigned minus SeatsReleased is ALLOCATION and MUST NOT be used as,
  /// labelled as, or presented as occupancy (`SEAT-FR-245`, `D-9c`).
  static final CertifiedMetric seatsOccupied = CertifiedMetric(
    metricId: 'SeatsOccupied',
    name: 'Seats occupied',
    definition:
        'The point-in-time count of seats that have an active allocation '
        'whose allocated student has a currently-open attendance session. A '
        'seat allocated to an absent student is allocated but NOT occupied '
        '(SEAT-FR-245). In SEAT-AC-173 — 100 seats, 70 allocated, 40 checked '
        'in — SeatsOccupied is 40.',
    sourceEvents: const <String>[
      'seating.SeatAssigned',
      'seating.SeatReleased',
      'seating.SeatTransferred',
      'attendance.StudentCheckedIn',
      'attendance.StudentCheckedOut',
    ],
    calculation:
        'Maintain the active-allocation set (SeatAssigned adds; SeatReleased '
        'removes; SeatTransferred re-points the allocation to the destination '
        'seat) and the open-session set (StudentCheckedIn opens; '
        'StudentCheckedOut closes). SeatsOccupied is the count of active '
        'allocations whose studentRecordId is in the open-session set. '
        'Recomputable from the allocation set and the BC-03 open-session set '
        '(SEAT-FR-116). SeatsAssigned minus SeatsReleased MUST NOT be used as '
        'occupancy.',
    owningContext: _owner,
    timeSemantics:
        'Point-in-time. Not day-bounded and not a period aggregate. The '
        'figure MUST be accompanied by its as-of time (SEAT-FR-246). Reads no '
        'wall clock, so replay is deterministic (ANL-INV-005).',
    freshnessExpectation: _freshness,
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    unit: _countUnit,
  );

  /// 12 — `ADR-0147` §3.6. The running open-session count.
  ///
  /// Does NOT inherit the IST-day boundary: a student who checked in on a
  /// previous day and has not checked out IS counted as inside (`D-10c`).
  static final CertifiedMetric insideNow = CertifiedMetric(
    metricId: 'InsideNow',
    name: 'Inside now',
    definition:
        'The point-in-time count of students with a currently-open attendance '
        'session. A student who checked in on a previous day and has not '
        'checked out IS counted as inside.',
    sourceEvents: const <String>[
      'attendance.StudentCheckedIn',
      'attendance.StudentCheckedOut',
    ],
    calculation:
        'All attendance.StudentCheckedIn facts less all '
        'attendance.StudentCheckedOut facts, per tenant, NOT bounded to any '
        'day. StudentCheckedIn opens a session for a studentRecordId; '
        'StudentCheckedOut closes it. The count is the number of open '
        'sessions.',
    owningContext: _owner,
    timeSemantics:
        'Point-in-time. Deliberately does NOT inherit the IST-day boundary of '
        'the ...Today metrics, because an open session may span days. Reads '
        'no wall clock at all, so replay is deterministic (ANL-INV-005). No '
        'stale-session expiry rule is certified: none exists in the '
        'repository and none is invented (ADR-0147 section 3.6, OPEN residue '
        'routed to the Product Owner).',
    freshnessExpectation: _freshness,
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    unit: _countUnit,
  );

  /// All 12, in `DashboardMetrics` field order. `ProfileViews` is NOT here —
  /// it is certified by `ADR-0097` and registered by the semantic layer.
  static List<CertifiedMetric> get all =>
      List<CertifiedMetric>.unmodifiable(<CertifiedMetric>[
        studentsEnrolled,
        membershipsCreated,
        checkInsToday,
        checkOutsToday,
        lateEntriesToday,
        flaggedEntriesToday,
        seatsAssigned,
        seatsReleased,
        collectedTodayMinor,
        duesRaisedTodayMinor,
        seatsOccupied,
        insideNow,
      ]);
}
