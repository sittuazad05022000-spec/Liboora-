/// **Analytics Platform — R5** (BC-22 Insights)
///
/// Read models only. This file deliberately imports **no domain context** —
/// it knows event *types* and payload *keys*, nothing else. That is what lets
/// Analytics be extracted to its own service later without dragging the
/// library domain along (forbidden edge X-12: capability platforms must never
/// depend on a domain context).
///
/// Every number below is rebuildable by replaying `EventBus.log` from zero.
/// If a projection ever holds state that cannot be reconstructed that way,
/// it has become a second source of truth and must be deleted.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

import '../event/event.dart';

/// One row of the activity feed shown on every dashboard.
final class ActivityItem {
  const ActivityItem({
    required this.at,
    required this.headline,
    required this.detail,
    required this.kind,
  });

  final DateTime at;
  final String headline;
  final String detail;

  /// Coarse bucket used for the icon and colour. Not a domain concept.
  final String kind;
}

/// Rolling counters for the dashboard tiles.
final class DashboardMetrics {
  int studentsEnrolled = 0;
  int membershipsCreated = 0;
  int checkInsToday = 0;
  int checkOutsToday = 0;
  int lateEntriesToday = 0;
  int flaggedEntriesToday = 0;
  int seatsAssigned = 0;
  int seatsReleased = 0;

  /// Minor units. Kept as `int` rather than `Money` on purpose — Analytics
  /// must not depend on domain arithmetic rules, only on reported amounts.
  int collectedTodayMinor = 0;
  int duesRaisedTodayMinor = 0;

  /// ADR-0147 section 3.5 — the presence-qualified occupancy count.
  ///
  /// Set by [AnalyticsProjections] from the active-allocation set intersected
  /// with the BC-03 open-session set. Deliberately NOT a getter over
  /// `seatsAssigned - seatsReleased`: SEAT-FR-245 states that a seat
  /// allocated to an absent student is allocated but NOT occupied, and
  /// SEAT-AC-173 fixes the arithmetic (70 allocated, 40 present -> 40).
  int seatsOccupied = 0;

  /// ADR-0147 section 3.6 — the running open-session count.
  ///
  /// NOT `checkInsToday - checkOutsToday`: that expression is day-bounded and
  /// would drop a student who checked in yesterday and has not checked out.
  int insideNow = 0;
}

/// Event-fed projection store.
///
/// Subscribes once at the composition root. Consumers are idempotent by
/// eventId inside [EventBus], so at-least-once delivery cannot double-count.
final class AnalyticsProjections {
  /// The [Clock] is accepted for composition-root compatibility but is
  /// deliberately NOT stored or read.
  ///
  /// ADR-0147 section 3.1 moved the `...Today` metrics to event time, so no
  /// projection handler reads a clock any more. ANL-INV-005 requires exactly
  /// that: "Replay from zero is deterministic — no wall-clock read inside
  /// projection logic." Keeping the parameter avoids changing three call
  /// sites for no behavioural gain; storing it would re-admit the hazard the
  /// invariant forbids.
  ///
  /// SEAT-FR-246's as-of-time obligation for `SeatsOccupied` is a READ-time
  /// concern for the surface that renders the figure, not a projection input.
  // ignore: avoid_unused_constructor_parameters
  AnalyticsProjections(Clock clock);

  final Map<String, DashboardMetrics> _byTenant = {};
  final List<ActivityItem> _feed = [];

  /// Per-student attendance-day tallies, keyed `studentId#yyyy-MM-dd`.
  final Set<String> _attendanceDays = {};

  /// IST is UTC+05:30 — ANL-FR-055, MP-CON-12.
  static const Duration _istOffset = Duration(hours: 5, minutes: 30);

  /// Active seat allocations per tenant: `seatLabel` -> `studentRecordId`.
  ///
  /// ADR-0147 section 3.5. `SeatAssigned` adds, `SeatReleased` removes and
  /// `SeatTransferred` re-points. This is the "current allocation set" that
  /// SEAT-FR-116 names as one of the two inputs to occupancy.
  final Map<String, Map<String, String>> _allocationsByTenant = {};

  /// Students with a currently-open attendance session, per tenant.
  ///
  /// ADR-0147 sections 3.5 and 3.6. `StudentCheckedIn` opens a session and
  /// `StudentCheckedOut` closes it. Deliberately NOT day-bounded: an open
  /// session may span IST days, and D-10c rules that such a student is still
  /// inside. This is SEAT-FR-116's "current BC-03 open-session set".
  final Map<String, Set<String>> _openSessionsByTenant = {};

  static const int _feedCap = 200;

  DashboardMetrics metricsFor(TenantId tenant) =>
      _byTenant.putIfAbsent(tenant.value, DashboardMetrics.new);

  List<ActivityItem> feed({int limit = 20}) =>
      _feed.reversed.take(limit).toList(growable: false);

  int distinctAttendanceDays() => _attendanceDays.length;

  Map<String, String> _allocations(TenantId tenant) =>
      _allocationsByTenant.putIfAbsent(tenant.value, () => <String, String>{});

  Set<String> _openSessions(TenantId tenant) =>
      _openSessionsByTenant.putIfAbsent(tenant.value, () => <String>{});

  /// Recompute the two point-in-time metrics for one tenant.
  ///
  /// ADR-0147 section 3.5: `SeatsOccupied` is the count of active allocations
  /// whose allocated student is in the open-session set — never
  /// `seatsAssigned - seatsReleased`, which is *allocation* (SEAT-FR-245: "a
  /// seat allocated to an absent student is allocated but not occupied").
  /// SEAT-AC-173 fixes the arithmetic: 70 allocated, 40 checked in -> 40.
  ///
  /// ADR-0147 section 3.6: `InsideNow` is the size of the open-session set,
  /// not day-bounded.
  ///
  /// Reads no wall clock, so replay from zero is deterministic
  /// (ANL-INV-005).
  void _recomputePointInTime(TenantId tenant) {
    final Map<String, String> allocations = _allocations(tenant);
    final Set<String> open = _openSessions(tenant);
    int occupied = 0;
    for (final String studentRecordId in allocations.values) {
      if (open.contains(studentRecordId)) occupied++;
    }
    final DashboardMetrics m = metricsFor(tenant);
    m.seatsOccupied = occupied;
    m.insideNow = open.length;
  }

  /// Wire every projection to the bus. Called once, from `bootstrap/`.
  void register(EventBus bus) {
    bus.subscribe(
      'enrollment.StudentEnrolled',
      _onEnrolled,
      consumer: 'analytics',
    );
    bus.subscribe(
      'membership.MembershipCreated',
      _onMembership,
      consumer: 'analytics',
    );
    bus.subscribe(
      'attendance.StudentCheckedIn',
      _onCheckIn,
      consumer: 'analytics',
    );
    bus.subscribe(
      'attendance.StudentCheckedOut',
      _onCheckOut,
      consumer: 'analytics',
    );
    bus.subscribe(
      'seating.SeatAssigned',
      _onSeatAssigned,
      consumer: 'analytics',
    );
    bus.subscribe(
      'seating.SeatReleased',
      _onSeatReleased,
      consumer: 'analytics',
    );
    // SEAT-EVT-003, routed to BC-26 by BC Map L418. ADR-0147 section 3.5
    // residue (1): BC-04 never emits this today, so the handler is dead code
    // until transfers are implemented. Subscribing anyway honours the
    // declared contract rather than silently ignoring a routed event.
    bus.subscribe(
      'seating.SeatTransferred',
      _onSeatTransferred,
      consumer: 'analytics',
    );
    bus.subscribe('fee.FeePaymentReceived', _onPayment, consumer: 'analytics');
    bus.subscribe('fee.FeeDueRaised', _onDueRaised, consumer: 'analytics');
  }

  /// Rebuild everything from the log. Proof that no state is unrecoverable.
  Future<void> rebuildFrom(EventBus bus) async {
    _byTenant.clear();
    _feed.clear();
    _attendanceDays.clear();
    _allocationsByTenant.clear();
    _openSessionsByTenant.clear();
    _reportingDay = null;
    for (final e in bus.log) {
      switch (e.eventType) {
        case 'enrollment.StudentEnrolled':
          _onEnrolled(e);
        case 'membership.MembershipCreated':
          _onMembership(e);
        case 'attendance.StudentCheckedIn':
          _onCheckIn(e);
        case 'attendance.StudentCheckedOut':
          _onCheckOut(e);
        case 'seating.SeatAssigned':
          _onSeatAssigned(e);
        case 'seating.SeatReleased':
          _onSeatReleased(e);
        case 'seating.SeatTransferred':
          _onSeatTransferred(e);
        case 'fee.FeePaymentReceived':
          _onPayment(e);
        case 'fee.FeeDueRaised':
          _onDueRaised(e);
      }
    }
  }

  // ── Handlers ─────────────────────────────────────────────────────────

  void _push(DomainEvent e, String kind, String headline, String detail) {
    _feed.add(
      ActivityItem(
        at: e.occurredAt,
        headline: headline,
        detail: detail,
        kind: kind,
      ),
    );
    if (_feed.length > _feedCap) _feed.removeAt(0);
  }

  /// The IST day key for an event, per ADR-0147 section 3.1.
  ///
  /// ADR-0147 fixes the period as the half-open IST interval
  /// `[00:00:00 IST, next-day 00:00:00 IST)` — start-inclusive,
  /// end-exclusive — evaluated against the event's own `occurredAt`.
  ///
  /// ANL-INV-005 forbids a wall-clock read inside projection logic. The
  /// previous implementation called `Clock.today()` here, which made a replay
  /// from zero non-deterministic: the same log produced different values on
  /// different days. This function reads only the event.
  ///
  /// IST is UTC+05:30, fixed by ANL-FR-055 and MP-CON-12. Shifting the
  /// instant by the offset and then truncating yields the civil IST date; a
  /// half-open interval follows because every instant maps to exactly one
  /// date, with no gap and no overlap at the boundary.
  static String _istDayKey(DateTime occurredAt) {
    final DateTime ist = occurredAt.toUtc().add(_istOffset);
    final String m = ist.month.toString().padLeft(2, '0');
    final String d = ist.day.toString().padLeft(2, '0');
    return '${ist.year}-$m-$d';
  }

  /// The IST day currently being reported, or `null` before any event.
  ///
  /// The `...Today` metrics hold values for one IST day. Which day that is
  /// follows from the event stream, never from the clock. When a fact arrives
  /// for a later IST day, the six day-scoped counters reset and begin
  /// accumulating for that day; facts for an earlier day are ignored by those
  /// counters, because a metric that silently re-opened a closed day would
  /// restate without the visible restatement ANL-FR-052 requires.
  String? _reportingDay;

  /// Returns true when [occurredAt] belongs to the reporting IST day, first
  /// advancing the reporting day if the event is newer.
  bool _inReportingDay(DomainEvent e) {
    final String key = _istDayKey(e.occurredAt);
    final String? current = _reportingDay;
    if (current == null || key.compareTo(current) > 0) {
      _reportingDay = key;
      _resetDayScopedCounters();
      return true;
    }
    return key == current;
  }

  void _resetDayScopedCounters() {
    for (final DashboardMetrics m in _byTenant.values) {
      m.checkInsToday = 0;
      m.checkOutsToday = 0;
      m.lateEntriesToday = 0;
      m.flaggedEntriesToday = 0;
      m.collectedTodayMinor = 0;
      m.duesRaisedTodayMinor = 0;
    }
  }

  void _onEnrolled(DomainEvent e) {
    metricsFor(e.tenantId).studentsEnrolled++;
    _push(
      e,
      'enrollment',
      '${e.payload['fullName']} enrolled',
      'Enrollment no. ${e.payload['enrollmentNumber']}',
    );
  }

  void _onMembership(DomainEvent e) {
    metricsFor(e.tenantId).membershipsCreated++;
    _push(
      e,
      'membership',
      'Membership created',
      '${e.payload['planName']} · valid to '
          '${(e.payload['validUntil'] as String).substring(0, 10)}',
    );
  }

  void _onCheckIn(DomainEvent e) {
    final m = metricsFor(e.tenantId);

    // ADR-0147 section 3.6 — session state is NOT day-bounded, so it is
    // updated BEFORE the IST-day filter below. A check-in on an earlier day
    // still opens a session that InsideNow and SeatsOccupied must see.
    final Object? sid = e.payload['studentRecordId'];
    if (sid is String && sid.isNotEmpty) {
      _openSessions(e.tenantId).add(sid);
      _recomputePointInTime(e.tenantId);
    }

    if (!_inReportingDay(e)) return;
    m.checkInsToday++;
    if (e.payload['lateEntry'] == true) m.lateEntriesToday++;
    if (e.payload['membershipValid'] == false) m.flaggedEntriesToday++;
    _attendanceDays.add(
      '${e.payload['studentRecordId']}#'
      '${e.occurredAt.toIso8601String().substring(0, 10)}',
    );
    _push(
      e,
      'attendance',
      'Check-in',
      '${e.payload['studentRecordId']} · ${e.payload['method']}',
    );
  }

  void _onCheckOut(DomainEvent e) {
    // ADR-0147 section 3.6 — closing a session is not day-bounded either.
    final Object? sid = e.payload['studentRecordId'];
    if (sid is String && sid.isNotEmpty) {
      _openSessions(e.tenantId).remove(sid);
      _recomputePointInTime(e.tenantId);
    }

    if (!_inReportingDay(e)) return;
    metricsFor(e.tenantId).checkOutsToday++;
    _push(
      e,
      'attendance',
      'Check-out',
      '${e.payload['minutesInside']} minutes inside',
    );
  }

  void _onSeatAssigned(DomainEvent e) {
    metricsFor(e.tenantId).seatsAssigned++;

    // ADR-0147 section 3.5 — add to the active-allocation set.
    final Object? seat = e.payload['seatLabel'];
    final Object? sid = e.payload['studentRecordId'];
    if (seat is String && seat.isNotEmpty && sid is String && sid.isNotEmpty) {
      _allocations(e.tenantId)[seat] = sid;
      _recomputePointInTime(e.tenantId);
    }
    _push(
      e,
      'seating',
      'Seat ${e.payload['seatLabel']} assigned',
      'to ${e.payload['studentRecordId']}',
    );
  }

  void _onSeatReleased(DomainEvent e) {
    metricsFor(e.tenantId).seatsReleased++;

    // ADR-0147 section 3.5 — remove from the active-allocation set.
    final Object? seat = e.payload['seatLabel'];
    if (seat is String && seat.isNotEmpty) {
      _allocations(e.tenantId).remove(seat);
      _recomputePointInTime(e.tenantId);
    }
    _push(
      e,
      'seating',
      'Seat ${e.payload['seatLabel']} released',
      '${e.payload['reason']}',
    );
  }

  /// SEAT-EVT-003 consumer — ADR-0147 section 3.5 residue (1) and (2).
  ///
  /// DEFENSIVE BY CONSTRUCTION, for two measured reasons:
  ///
  /// 1. BC-04 never emits this event today. `seating.dart` emits exactly
  ///    `SeatAssigned` and `SeatReleased`, and the seating domain has no
  ///    transfer use case. This handler is therefore dead code until BC-04
  ///    implements transfers, which ADR-0147 does NOT authorise.
  /// 2. The event's PAYLOAD IS SPECIFIED NOWHERE. SEAT-FR-065 fixes the
  ///    transfer *history row* (source seat, destination seat, actor,
  ///    timestamp, reason); SEAT-AC-225 fixes only cardinality. No payload
  ///    contract exists, and ADR-0147 invents none.
  ///
  /// So this handler acts only on SEAT-FR-209's mandatory `studentRecordId`
  /// plus optional seat labels under the two names the sibling events already
  /// use. Anything absent is a no-op: re-pointing an allocation on guessed
  /// field names would fabricate the contract this comment records as
  /// missing. It never invents a count and never touches seatsAssigned or
  /// seatsReleased, because a transfer is neither an assignment nor a release
  /// (SEAT-EVT-001/002 emit on those transitions).
  void _onSeatTransferred(DomainEvent e) {
    final Object? sid = e.payload['studentRecordId'];
    if (sid is! String || sid.isEmpty) return;

    final Object? from = e.payload['fromSeatLabel'];
    final Object? to = e.payload['toSeatLabel'];
    final Map<String, String> allocations = _allocations(e.tenantId);

    if (from is String && from.isNotEmpty) {
      allocations.remove(from);
    } else {
      // No source named: drop any seat currently held by this student, so a
      // transfer cannot leave the student holding two seats.
      allocations.removeWhere((_, String held) => held == sid);
    }
    if (to is String && to.isNotEmpty) {
      allocations[to] = sid;
    }
    _recomputePointInTime(e.tenantId);

    _push(e, 'seating', 'Seat transferred', sid);
  }

  void _onPayment(DomainEvent e) {
    final amount = (e.payload['amountMinor'] as int?) ?? 0;
    if (_inReportingDay(e)) {
      metricsFor(e.tenantId).collectedTodayMinor += amount;
    }
    _push(
      e,
      'fee',
      'Payment received',
      '${e.payload['receiptNumber']} · ${e.payload['mode']}',
    );
  }

  void _onDueRaised(DomainEvent e) {
    final amount = (e.payload['amountMinor'] as int?) ?? 0;
    if (_inReportingDay(e)) {
      metricsFor(e.tenantId).duesRaisedTodayMinor += amount;
    }
  }
}
