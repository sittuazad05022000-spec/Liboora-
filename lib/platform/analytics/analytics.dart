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

  int get seatsOccupied => seatsAssigned - seatsReleased;
  int get insideNow => checkInsToday - checkOutsToday;
}

/// Event-fed projection store.
///
/// Subscribes once at the composition root. Consumers are idempotent by
/// eventId inside [EventBus], so at-least-once delivery cannot double-count.
final class AnalyticsProjections {
  AnalyticsProjections(this._clock);

  final Clock _clock;

  final Map<String, DashboardMetrics> _byTenant = {};
  final List<ActivityItem> _feed = [];

  /// Per-student attendance-day tallies, keyed `studentId#yyyy-MM-dd`.
  final Set<String> _attendanceDays = {};

  static const int _feedCap = 200;

  DashboardMetrics metricsFor(TenantId tenant) =>
      _byTenant.putIfAbsent(tenant.value, DashboardMetrics.new);

  List<ActivityItem> feed({int limit = 20}) =>
      _feed.reversed.take(limit).toList(growable: false);

  int distinctAttendanceDays() => _attendanceDays.length;

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
    bus.subscribe('fee.FeePaymentReceived', _onPayment, consumer: 'analytics');
    bus.subscribe('fee.FeeDueRaised', _onDueRaised, consumer: 'analytics');
  }

  /// Rebuild everything from the log. Proof that no state is unrecoverable.
  Future<void> rebuildFrom(EventBus bus) async {
    _byTenant.clear();
    _feed.clear();
    _attendanceDays.clear();
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

  bool _isToday(DateTime when) {
    final t = _clock.today();
    return when.year == t.year && when.month == t.month && when.day == t.day;
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
    if (!_isToday(e.occurredAt)) return;
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
    if (!_isToday(e.occurredAt)) return;
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
    _push(
      e,
      'seating',
      'Seat ${e.payload['seatLabel']} assigned',
      'to ${e.payload['studentRecordId']}',
    );
  }

  void _onSeatReleased(DomainEvent e) {
    metricsFor(e.tenantId).seatsReleased++;
    _push(
      e,
      'seating',
      'Seat ${e.payload['seatLabel']} released',
      '${e.payload['reason']}',
    );
  }

  void _onPayment(DomainEvent e) {
    final amount = (e.payload['amountMinor'] as int?) ?? 0;
    if (_isToday(e.occurredAt)) {
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
    if (_isToday(e.occurredAt)) {
      metricsFor(e.tenantId).duesRaisedTodayMinor += amount;
    }
  }
}
