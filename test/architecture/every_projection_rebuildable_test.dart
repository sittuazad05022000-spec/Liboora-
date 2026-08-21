/// **Architecture test 5 of 7 — `every_projection_rebuildable_test.dart`.**
///
/// Mandated by `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.3, whose requirement
/// cell reads verbatim:
///
/// > Each Analytics projection implements `rebuild()`
///
/// ## Divergence from the literal wording, disclosed
///
/// There is no `rebuild()` in the codebase. `AnalyticsProjections` implements
/// **`Future<void> rebuildFrom(EventBus bus)`** (`lib/platform/analytics/analytics.dart`
/// L117). The name differs; the obligation does not.
///
/// Asserting the literal string `rebuild()` would fail for a reason that has
/// nothing to do with rebuildability — a spelling mismatch between a document
/// and a method — and the natural "fix" would be to rename production code to
/// satisfy a test. That is the tail wagging the dog.
///
/// More importantly, **a method-name assertion is nearly worthless here.** A
/// `rebuild()` that exists and does nothing would satisfy §10.3 as literally
/// written while leaving every projection unrecoverable. The property that
/// actually matters is stated by the module's own doc comment:
///
/// > Every number below is rebuildable by replaying `EventBus.log` from zero.
/// > If a projection ever holds state that cannot be reconstructed that way,
/// > it has become a second source of truth and must be deleted.
///
/// So this file asserts **behaviour**: build a projection by live subscription,
/// snapshot every field it exposes, wipe it, replay the log, and require the
/// snapshot to match **exactly**. That is the test BC Map §9.1 row *Replay*
/// describes ("must be rebuildable from the log. This is tested quarterly, not
/// assumed") and the one §10.3's method-name shorthand is pointing at.
///
/// The name divergence itself is pinned in its own test, so that a future
/// rename to `rebuild()` is noticed and this comment revisited, rather than the
/// mismatch persisting unnoticed in either direction.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/platform/analytics/analytics.dart';
import 'package:liboora/platform/event/event.dart';
import 'package:liboora/platform/observability/observability.dart';
import 'package:liboora/platform/tenancy/tenancy.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const String _matrixPath =
    'docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md';
const String _bcMapPath =
    'docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md';
const String _analyticsPath = 'lib/platform/analytics/analytics.dart';

/// A fixed "today" so `_isToday()` gating inside the projection is
/// deterministic. `X-09` bans a wall-clock read in the domain; a projection
/// test that depended on the real date would be flaky by 24-hour cycle.
final DateTime _today = DateTime.utc(2026, 8, 20, 10);

const TenantId _tenantA = TenantId('T-A');
const TenantId _tenantB = TenantId('T-B');

/// Everything the projection exposes publicly, flattened for comparison.
///
/// Deliberately exhaustive: a rebuild test that compares one counter proves
/// only that one counter rebuilds. Any field omitted here is a field whose
/// unrecoverability this test would not notice.
Map<String, Object?> _snapshot(AnalyticsProjections p) {
  Map<String, Object?> metrics(TenantId t) {
    final m = p.metricsFor(t);
    return {
      'studentsEnrolled': m.studentsEnrolled,
      'membershipsCreated': m.membershipsCreated,
      'checkInsToday': m.checkInsToday,
      'checkOutsToday': m.checkOutsToday,
      'lateEntriesToday': m.lateEntriesToday,
      'flaggedEntriesToday': m.flaggedEntriesToday,
      'seatsAssigned': m.seatsAssigned,
      'seatsReleased': m.seatsReleased,
      'collectedTodayMinor': m.collectedTodayMinor,
      'duesRaisedTodayMinor': m.duesRaisedTodayMinor,
      'seatsOccupied': m.seatsOccupied,
      'insideNow': m.insideNow,
    };
  }

  return {
    'tenantA': metrics(_tenantA),
    'tenantB': metrics(_tenantB),
    'distinctAttendanceDays': p.distinctAttendanceDays(),
    // The feed is ordered and capped; compare content AND order.
    'feed': p
        .feed(limit: 1000)
        .map((i) => '${i.at.toIso8601String()}|${i.kind}|${i.headline}|${i.detail}')
        .toList(growable: false),
  };
}

var _eventSeq = 0;

DomainEvent _event(
  String type,
  TenantId tenant, {
  required String aggregateId,
  Map<String, Object?> payload = const {},
  DateTime? at,
}) {
  _eventSeq++;
  return DomainEvent(
    eventId: 'EV-$_eventSeq',
    eventType: type,
    tenantId: tenant,
    aggregateId: aggregateId,
    occurredAt: at ?? _today,
    payload: payload,
  );
}

/// A representative event log covering **every** type the projection
/// subscribes to, across two tenants, with the today/not-today branch and the
/// late/flagged payload branches exercised.
List<DomainEvent> _representativeLog() {
  _eventSeq = 0;
  final yesterday = _today.subtract(const Duration(days: 1));
  return [
    _event(
      'enrollment.StudentEnrolled',
      _tenantA,
      aggregateId: 'SR-1',
      payload: const {'fullName': 'Aisha Khan', 'enrollmentNumber': 'EN-001'},
    ),
    _event(
      'enrollment.StudentEnrolled',
      _tenantB,
      aggregateId: 'SR-9',
      payload: const {'fullName': 'Rahul Verma', 'enrollmentNumber': 'EN-900'},
    ),
    _event(
      'membership.MembershipCreated',
      _tenantA,
      aggregateId: 'MEM-1',
      payload: const {
        'planName': 'Monthly',
        'validUntil': '2026-09-20T00:00:00.000Z',
      },
    ),
    // Today, on time, membership valid.
    _event(
      'attendance.StudentCheckedIn',
      _tenantA,
      aggregateId: 'AD-1',
      payload: const {
        'studentRecordId': 'SR-1',
        'method': 'qr',
        'lateEntry': false,
        'membershipValid': true,
      },
    ),
    // Today, LATE and FLAGGED — exercises both conditional counters.
    _event(
      'attendance.StudentCheckedIn',
      _tenantA,
      aggregateId: 'AD-2',
      payload: const {
        'studentRecordId': 'SR-2',
        'method': 'gps',
        'lateEntry': true,
        'membershipValid': false,
      },
    ),
    // NOT today — must be ignored by the today-gated handlers. This is the
    // branch a rebuild is most likely to get wrong, because replay happens at
    // a different moment than live delivery did.
    _event(
      'attendance.StudentCheckedIn',
      _tenantA,
      aggregateId: 'AD-3',
      payload: const {
        'studentRecordId': 'SR-3',
        'method': 'wifi',
        'lateEntry': false,
        'membershipValid': true,
      },
      at: yesterday,
    ),
    _event(
      'attendance.StudentCheckedOut',
      _tenantA,
      aggregateId: 'AD-1',
      payload: const {'minutesInside': 180},
    ),
    _event(
      'attendance.StudentCheckedOut',
      _tenantA,
      aggregateId: 'AD-3',
      payload: const {'minutesInside': 60},
      at: yesterday,
    ),
    _event(
      'seating.SeatAssigned',
      _tenantA,
      aggregateId: 'ALLOC-1',
      payload: const {'seatLabel': 'A-14', 'studentRecordId': 'SR-1'},
    ),
    _event(
      'seating.SeatReleased',
      _tenantA,
      aggregateId: 'ALLOC-1',
      payload: const {'seatLabel': 'A-14', 'reason': 'left'},
    ),
    _event(
      'seating.SeatAssigned',
      _tenantB,
      aggregateId: 'ALLOC-9',
      payload: const {'seatLabel': 'B-02', 'studentRecordId': 'SR-9'},
    ),
    _event(
      'fee.FeeDueRaised',
      _tenantA,
      aggregateId: 'LEDGER-1',
      payload: const {'amountMinor': 120000, 'description': 'Monthly'},
    ),
    _event(
      'fee.FeePaymentReceived',
      _tenantA,
      aggregateId: 'LEDGER-1',
      payload: const {'amountMinor': 100000, 'receiptNumber': 'R-0001'},
    ),
    _event(
      'fee.FeePaymentReceived',
      _tenantB,
      aggregateId: 'LEDGER-9',
      payload: const {'amountMinor': 50000, 'receiptNumber': 'R-9001'},
    ),
  ];
}

/// Builds a live-fed projection and returns it with its bus.
Future<({AnalyticsProjections projections, EventBus bus})> _liveFed() async {
  final tenantContext = MutableTenantContext();
  // `enter` is all-named and `correlationId` is required: the tenancy platform
  // refuses to produce an unattributable log line. Supplying it here is not
  // ceremony — `ConsoleTelemetry.log` reads the ambient tenant on every write,
  // and an unentered context throws `TenantContextMissing` rather than
  // defaulting (tenancy.dart L63: "never default").
  tenantContext.enter(
    tenant: _tenantA,
    branch: const BranchId('B-A1'),
    actor: 'arch-test',
    correlationId: 'projection-rebuild-test',
  );
  final bus = EventBus(ConsoleTelemetry(tenantContext));
  final projections = AnalyticsProjections(FixedClock(_today))..register(bus);

  bus.enqueue(_representativeLog());
  await bus.drain();
  return (projections: projections, bus: bus);
}

void main() {
  // ════════════════════════════════════════════════════════════════════
  group('the rebuild obligation is still declared, and is behavioural', () {
    test('Matrix §10.3 still requires this test and names the obligation', () {
      final text = File(_matrixPath).readAsStringSync();
      expect(
        text,
        contains('every_projection_rebuildable_test.dart'),
        reason: 'Matrix §10.3 no longer names this test.',
      );
      expect(
        text,
        contains('Analytics projection'),
        reason:
            'The §10.3 requirement wording changed. Re-read it before '
            'trusting this file to implement it.',
      );
    });

    test('DISCLOSED DIVERGENCE — the method is rebuildFrom(), not rebuild()',
        () {
      final src = File(_analyticsPath).readAsStringSync();

      expect(
        src,
        contains('rebuildFrom(EventBus bus)'),
        reason:
            'AnalyticsProjections no longer exposes rebuildFrom(EventBus). If '
            'it was renamed to rebuild(), update this test and the header '
            'comment — the divergence this test tracks would then be resolved.',
      );

      // Pin the literal absence, so a future rename is a visible event rather
      // than a silent convergence nobody records.
      expect(
        RegExp(r'\brebuild\s*\(\s*\)').hasMatch(src),
        isFalse,
        reason:
            '✅ A no-argument rebuild() now exists in $_analyticsPath, matching '
            'the literal Matrix §10.3 wording. Update this test and remove the '
            'divergence note from the file header.',
      );
    });

    test('BC Map §9.1 states the replay property this test enforces', () {
      final text = File(_bcMapPath).readAsStringSync();
      expect(
        text,
        contains('must be rebuildable from the log'),
        reason:
            'BC Map §9.1 row "Replay" is the authority for asserting behaviour '
            'rather than a method name. If that row changed, re-read it.',
      );
    });

    test('the projection module imports no domain context — X-12', () {
      // The reason rebuildability is achievable at all: the projection knows
      // event types and payload keys, nothing else. A domain import here would
      // mean rebuild had to reconstruct domain objects too.
      final src = File(_analyticsPath).readAsStringSync();
      final domainImports = RegExp(r'''import\s+['"]([^'"]*domain[^'"]*)['"]''')
          .allMatches(src)
          .map((m) => m.group(1)!)
          .toList();
      expect(
        domainImports,
        isEmpty,
        reason:
            'Forbidden edge X-12: capability platforms must never depend on a '
            'domain context. Found: ${domainImports.join(', ')}',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // THE REAL TEST — replay must reproduce live-fed state exactly.
  // ════════════════════════════════════════════════════════════════════
  group('replaying the log from zero reproduces the projection exactly', () {
    test('the representative log is non-trivial and covers every subscribed '
        'event type', () {
      // Vacuity guard. A rebuild test over an empty log passes trivially:
      // clearing nothing and replaying nothing always matches.
      final log = _representativeLog();
      expect(log, isNotEmpty);

      // NOTE on the literal: a raw triple-single-quoted string cannot be used
      // here. The pattern ends in `'` and the terminator is `'''`, so the four
      // adjacent quotes are ambiguous and the analyzer reports
      // `unterminated_string_literal`. This exact mistake broke test 4 at its
      // line 168. A raw double-quoted string has no such collision.
      final subscribed = RegExp(r"bus\.subscribe\(\s*'([^']+)'")
          .allMatches(File(_analyticsPath).readAsStringSync())
          .map((m) => m.group(1)!)
          .toSet();
      expect(
        subscribed,
        isNotEmpty,
        reason: 'Could not parse any bus.subscribe() call from the projection.',
      );

      final covered = log.map((e) => e.eventType).toSet();
      final uncovered = subscribed.difference(covered).toList()..sort();
      expect(
        uncovered,
        isEmpty,
        reason:
            'The projection subscribes to these event types but the '
            'representative log never emits them, so their rebuildability is '
            'UNTESTED: ${uncovered.join(', ')}. Add them to '
            '_representativeLog().',
      );
    });

    test('live-fed state is non-empty before the rebuild is attempted', () async {
      // Second vacuity guard: if live feeding produced nothing, "before ==
      // after" would hold for the wrong reason.
      final fed = await _liveFed();
      final before = _snapshot(fed.projections);

      expect(
        (before['tenantA']! as Map)['studentsEnrolled'],
        1,
        reason: 'Live subscription did not accumulate. The comparison below '
            'would then be empty-vs-empty.',
      );
      expect((before['feed']! as List), isNotEmpty);
      expect(before['distinctAttendanceDays'], greaterThan(0));
    });

    test('rebuildFrom() reproduces EVERY exposed field, byte for byte',
        () async {
      final fed = await _liveFed();
      final before = _snapshot(fed.projections);

      await fed.projections.rebuildFrom(fed.bus);
      final after = _snapshot(fed.projections);

      expect(
        after,
        equals(before),
        reason:
            'Replaying EventBus.log from zero did not reproduce the live-fed '
            'projection. Per $_analyticsPath: "if a projection ever holds '
            'state that cannot be reconstructed that way, it has become a '
            'second source of truth and must be deleted."\n'
            'BEFORE: $before\nAFTER:  $after',
      );
    });

    test('rebuild is idempotent — replaying twice does not double-count',
        () async {
      // The failure mode a clear-then-replay implementation is prone to: if
      // rebuildFrom() forgot to clear one collection, the first rebuild would
      // still match (append to empty) and only the second would drift.
      final fed = await _liveFed();

      await fed.projections.rebuildFrom(fed.bus);
      final once = _snapshot(fed.projections);
      await fed.projections.rebuildFrom(fed.bus);
      final twice = _snapshot(fed.projections);

      expect(
        twice,
        equals(once),
        reason:
            'A second rebuild changed the projection, which means rebuildFrom() '
            'does not fully reset state before replaying. Recovery would then '
            'depend on how many times it had been run.',
      );
    });

    test('rebuild from a fresh instance matches the live-fed instance',
        () async {
      // The real disaster-recovery shape: the process died, the projection is
      // gone, and only the log survives. This is stricter than the in-place
      // rebuild above, because nothing at all is inherited from live delivery.
      final fed = await _liveFed();
      final before = _snapshot(fed.projections);

      final fresh = AnalyticsProjections(FixedClock(_today));
      await fresh.rebuildFrom(fed.bus);

      expect(
        _snapshot(fresh),
        equals(before),
        reason:
            'A brand-new projection rebuilt from the log alone does not match '
            'the live-fed one. Some state therefore originated somewhere other '
            'than the event log, and cannot survive a restart.',
      );
    });

    test('tenant partitioning survives rebuild — no cross-tenant bleed',
        () async {
      // A rebuild that dropped the tenant dimension would still match on
      // totals if the test only checked one tenant. Both are asserted, and
      // their independence is asserted too.
      final fed = await _liveFed();
      await fed.projections.rebuildFrom(fed.bus);

      final a = fed.projections.metricsFor(_tenantA);
      final b = fed.projections.metricsFor(_tenantB);

      expect(a.studentsEnrolled, 1);
      expect(b.studentsEnrolled, 1);
      expect(
        a.seatsAssigned,
        1,
        reason: 'Tenant A had one assignment and one release.',
      );
      expect(
        b.seatsAssigned,
        1,
        reason: 'Tenant B had one assignment and no release.',
      );
      expect(
        a.seatsReleased,
        1,
        reason:
            'If rebuild merged tenants, B\'s release count would pick up A\'s.',
      );
      expect(b.seatsReleased, 0);
      expect(
        b.collectedTodayMinor,
        50000,
        reason:
            'Tenant B collected 50000 minor units; A collected 100000. Equal '
            'values here would mean the tenant key was lost on replay.',
      );
      expect(a.collectedTodayMinor, 100000);
    });

    test('an unknown tenant reads as zero rather than leaking another '
        'tenant\'s numbers', () async {
      final fed = await _liveFed();
      await fed.projections.rebuildFrom(fed.bus);

      final unknown = fed.projections.metricsFor(const TenantId('T-NEVER'));
      expect(unknown.studentsEnrolled, 0);
      expect(unknown.collectedTodayMinor, 0);
      expect(
        unknown.seatsAssigned,
        0,
        reason:
            'A default that fell back to any populated tenant would be a '
            'cross-tenant read (X-13).',
      );
    });

    test('date-gated handlers behave identically on replay', () async {
      // The yesterday check-in must be excluded both live and on rebuild. If
      // rebuildFrom() used a different clock, or none, this is where it shows.
      final fed = await _liveFed();
      final liveCheckIns = fed.projections.metricsFor(_tenantA).checkInsToday;

      await fed.projections.rebuildFrom(fed.bus);
      final rebuiltCheckIns = fed.projections.metricsFor(_tenantA).checkInsToday;

      expect(
        liveCheckIns,
        2,
        reason:
            'Three check-ins were emitted for tenant A; one occurred '
            'yesterday and must not count toward "today".',
      );
      expect(
        rebuiltCheckIns,
        liveCheckIns,
        reason:
            'The today-gate produced a different answer on replay. A '
            'projection whose value depends on WHEN it was rebuilt is not '
            'rebuildable in any useful sense.',
      );
      expect(
        fed.projections.distinctAttendanceDays(),
        greaterThanOrEqualTo(2),
        reason:
            'distinctAttendanceDays is a Set keyed on student#date; it must '
            'survive replay without duplication.',
      );
    });

    test('the feed retains order and content across rebuild', () async {
      final fed = await _liveFed();
      final before = fed.projections.feed(limit: 1000);

      await fed.projections.rebuildFrom(fed.bus);
      final after = fed.projections.feed(limit: 1000);

      expect(after.length, before.length);
      for (var i = 0; i < before.length; i++) {
        expect(
          after[i].headline,
          before[i].headline,
          reason:
              'Feed item $i differs after rebuild. The activity feed is '
              'ordered; reconstructing it out of order would silently rewrite '
              'the visible history of the library.',
        );
        expect(after[i].at, before[i].at);
        expect(after[i].kind, before[i].kind);
      }
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // DISCLOSED SCOPE — what "each Analytics projection" covers today.
  // ════════════════════════════════════════════════════════════════════
  group('DISCLOSED SCOPE — projection inventory', () {
    test('AnalyticsProjections is the only Analytics projection class, and '
        'the count is pinned', () {
      final src = File(_analyticsPath).readAsStringSync();
      final classes = RegExp(r'^final class (\w+)', multiLine: true)
          .allMatches(src)
          .map((m) => m.group(1)!)
          .toSet();

      expect(
        classes,
        contains('AnalyticsProjections'),
        reason: 'The projection class was renamed or removed.',
      );

      // `ActivityItem` and `DashboardMetrics` are value/row types, not
      // projections — they hold no subscription and have nothing to rebuild.
      final projectionLike = classes
          .where((c) => c.contains('Projection'))
          .toList()
        ..sort();
      expect(
        projectionLike,
        ['AnalyticsProjections'],
        reason:
            'A new projection class appeared in $_analyticsPath: '
            '${projectionLike.join(', ')}. Matrix §10.3 requires EACH '
            'Analytics projection to be rebuildable, so extend the snapshot '
            'and the representative log to cover it. Adding a projection '
            'without extending this test would leave it unverified.',
      );
    });

    test('BC-21 EntitlementSet is derived state and is NOT in scope here', () {
      // Recorded so the omission is deliberate rather than overlooked. BC Map
      // §8 lists EntitlementSet as "Derived state only — never hand-edited;
      // recomputable from Subscription events". It is a BC-21 concern living
      // in platform/business, not an Analytics projection, and it has no
      // rebuild entry point yet.
      final src = File('lib/platform/business/business.dart');
      expect(src.existsSync(), isTrue);
      final text = src.readAsStringSync();
      expect(
        text,
        contains('rebuildable from Subscription events'),
        reason:
            'platform/business no longer documents EntitlementService as '
            'rebuildable. If it gained a rebuild entry point, it becomes '
            'testable and this exclusion must be revisited.',
      );
      expect(
        RegExp(r'\brebuild\w*\s*\(').hasMatch(text),
        isFalse,
        reason:
            '✅ platform/business now exposes a rebuild method. BC-21 '
            'EntitlementSet is declared "derived state only, recomputable from '
            'Subscription events" — add a replay test for it and remove this '
            'exclusion.',
      );
    });
  });
}
