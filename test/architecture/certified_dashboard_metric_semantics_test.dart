/// **ADR-0147 — behavioural conformance of the twelve certified counters**
///
/// `ADR-0147` (Accepted 2026-09-18) certifies the twelve `DashboardMetrics`
/// counters and closes `ANL-OBD-001` for those twelve only. Certification is
/// a *definitional* act: it fixes `definition`, `calculation`,
/// `timeSemantics` and `freshnessExpectation` for each metric.
///
/// `no_metric_defined_outside_semantic_layer_test.dart` proves the
/// **definitions exist and are complete** (`ANL-FR-008`/`ANL-FR-009`). That
/// is a document-shaped check and it cannot notice a projection that computes
/// something other than what its definition says.
///
/// This file closes that gap. Each test below names the clause it enforces
/// and fails if the projection drifts from the certified wording. Three of
/// them exist because the pre-`ADR-0147` code was measurably wrong, not
/// because a rule might hypothetically be broken later:
///
///   * `ANL-INV-005` — the projection read `_clock.today()` inside handler
///     logic, so replay from zero was *not* deterministic.
///   * `SEAT-FR-245` — `seatsOccupied` was `seatsAssigned - seatsReleased`,
///     which is allocation, not occupancy.
///   * `SEAT-AC-173` — that arithmetic returned 70 where the frozen
///     acceptance criterion fixes 40.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/platform/analytics/analytics.dart';
import 'package:liboora/platform/event/event.dart';
import 'package:liboora/platform/observability/observability.dart';
import 'package:liboora/platform/tenancy/tenancy.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const TenantId _tenantA = TenantId('T-A');
const TenantId _tenantB = TenantId('T-B');

/// 2026-08-20 10:00 UTC = 15:30 IST on 2026-08-20.
final DateTime _baseUtc = DateTime.utc(2026, 8, 20, 10);

var _seq = 0;

DomainEvent _event(
  String type,
  TenantId tenant, {
  required String aggregateId,
  Map<String, Object?> payload = const {},
  DateTime? at,
}) {
  _seq++;
  return DomainEvent(
    eventId: 'EV-CERT-$_seq',
    eventType: type,
    tenantId: tenant,
    aggregateId: aggregateId,
    occurredAt: at ?? _baseUtc,
    payload: payload,
  );
}

/// Feeds [log] to a fresh projection whose clock is [clockNow].
///
/// `clockNow` is varied deliberately in the `ANL-INV-005` test. If the
/// projection reads it, the two runs diverge; if it does not, they cannot.
Future<AnalyticsProjections> _fed(
  List<DomainEvent> log, {
  DateTime? clockNow,
}) async {
  final tenantContext = MutableTenantContext()
    ..enter(
      tenant: _tenantA,
      branch: const BranchId('B-A1'),
      actor: 'adr-0147-test',
      correlationId: 'certified-metric-semantics',
    );
  final bus = EventBus(ConsoleTelemetry(tenantContext));
  final projections = AnalyticsProjections(FixedClock(clockNow ?? _baseUtc))
    ..register(bus);
  bus.enqueue(log);
  await bus.drain();
  return projections;
}

DomainEvent _checkIn(TenantId t, String studentRecordId, {DateTime? at}) =>
    _event(
      'attendance.StudentCheckedIn',
      t,
      aggregateId: 'AD-$studentRecordId',
      payload: {
        'studentRecordId': studentRecordId,
        'method': 'qr',
        'lateEntry': false,
        'membershipValid': true,
      },
      at: at,
    );

DomainEvent _checkOut(TenantId t, String studentRecordId, {DateTime? at}) =>
    _event(
      'attendance.StudentCheckedOut',
      t,
      aggregateId: 'AD-$studentRecordId',
      payload: {'studentRecordId': studentRecordId, 'minutesInside': 60},
      at: at,
    );

DomainEvent _assign(
  TenantId t,
  String seatLabel,
  String studentRecordId, {
  DateTime? at,
}) => _event(
  'seating.SeatAssigned',
  t,
  aggregateId: 'ALLOC-$seatLabel',
  payload: {'seatLabel': seatLabel, 'studentRecordId': studentRecordId},
  at: at,
);

DomainEvent _release(TenantId t, String seatLabel, {DateTime? at}) => _event(
  'seating.SeatReleased',
  t,
  aggregateId: 'ALLOC-$seatLabel',
  payload: {'seatLabel': seatLabel, 'reason': 'left'},
  at: at,
);

void main() {
  setUp(() => _seq = 0);

  group('ANL-INV-005 — replay from zero is deterministic', () {
    test(
      'the same log under two different clocks yields the same numbers',
      () async {
        // ANL-INV-005: "Replay from zero is deterministic — no wall-clock read
        // inside projection logic." Before ADR-0147 the day-scoped handlers
        // gated on `_clock.today()`, so this test would have failed: the same
        // log replayed a day later produced zeroes for the ...Today counters.
        final List<DomainEvent> log = <DomainEvent>[
          _checkIn(_tenantA, 'SR-1'),
          _checkOut(_tenantA, 'SR-1'),
          _event(
            'fee.FeePaymentReceived',
            _tenantA,
            aggregateId: 'LEDGER-1',
            payload: const {'amountMinor': 100000, 'receiptNumber': 'R-1'},
          ),
        ];

        Future<Map<String, int>> run(DateTime clockNow) async {
          _seq = 0;
          final p = await _fed(log, clockNow: clockNow);
          final m = p.metricsFor(_tenantA);
          return <String, int>{
            'checkInsToday': m.checkInsToday,
            'checkOutsToday': m.checkOutsToday,
            'collectedTodayMinor': m.collectedTodayMinor,
            'insideNow': m.insideNow,
            'seatsOccupied': m.seatsOccupied,
          };
        }

        // A clock one year LATER than every event in the log.
        final Map<String, int> later = await run(DateTime.utc(2027, 8, 20, 10));
        // A clock one year EARLIER than every event in the log.
        final Map<String, int> earlier = await run(
          DateTime.utc(2025, 8, 20, 10),
        );

        expect(
          later,
          earlier,
          reason:
              'ANL-INV-005 is breached: the projection still reads a wall '
              'clock, so the numbers depend on WHEN the replay happens rather '
              'than on the facts replayed.',
        );
        // Guard against the assertion passing because BOTH runs are empty.
        expect(
          later.values.any((int v) => v > 0),
          isTrue,
          reason:
              'The log must actually move the counters, or equality above '
              'would prove nothing.',
        );
      },
    );

    test('the day-scoped counters follow event time, not the clock', () async {
      // The clock is set to a day on which NOTHING happened. Under the old
      // `_clock.today()` gate every ...Today counter would read 0.
      final p = await _fed(<DomainEvent>[
        _checkIn(_tenantA, 'SR-1'),
        _checkIn(_tenantA, 'SR-2'),
      ], clockNow: DateTime.utc(2030, 1, 1));

      expect(
        p.metricsFor(_tenantA).checkInsToday,
        2,
        reason:
            'ADR-0147 §3.1: the reporting day is established by the event '
            'stream (the event\'s own occurredAt), never by the clock.',
      );
    });
  });

  group('ADR-0147 §3.1 — the IST day is a half-open interval', () {
    test('18:29:59 UTC is still the same IST day', () async {
      // 18:29:59Z + 05:30 = 23:59:59 IST on 2026-08-20 — inside the day.
      final p = await _fed(<DomainEvent>[
        _checkIn(_tenantA, 'SR-1', at: DateTime.utc(2026, 8, 20, 0, 0)),
        _checkIn(_tenantA, 'SR-2', at: DateTime.utc(2026, 8, 20, 18, 29, 59)),
      ]);

      expect(
        p.metricsFor(_tenantA).checkInsToday,
        2,
        reason:
            'Both facts fall in [00:00 IST 2026-08-20, 00:00 IST 2026-08-21), '
            'which ADR-0147 §3.1 certifies as one reporting day.',
      );
    });

    test('18:30:00 UTC opens the next IST day and resets the counters', () async {
      // 18:30:00Z + 05:30 = 00:00:00 IST on 2026-08-21 — the end of the
      // interval is EXCLUSIVE, so this is a new day.
      final p = await _fed(<DomainEvent>[
        _checkIn(_tenantA, 'SR-1', at: DateTime.utc(2026, 8, 20, 12)),
        _checkIn(_tenantA, 'SR-2', at: DateTime.utc(2026, 8, 20, 18, 30)),
      ]);

      expect(
        p.metricsFor(_tenantA).checkInsToday,
        1,
        reason:
            'ADR-0147 §3.1: the interval is start-inclusive and end-exclusive, '
            'so 00:00:00 IST belongs to the NEW day. The day-scoped counters '
            'reset rather than accumulating across two days, which would '
            'publish a two-day number under a one-day definition.',
      );
    });

    test(
      'a fact for an earlier IST day does not re-open a closed day',
      () async {
        final p = await _fed(<DomainEvent>[
          // Establish 2026-08-21 as the reporting day.
          _checkIn(_tenantA, 'SR-1', at: DateTime.utc(2026, 8, 21, 12)),
          // A late-arriving fact for 2026-08-20.
          _checkIn(_tenantA, 'SR-2', at: DateTime.utc(2026, 8, 20, 12)),
        ]);

        expect(
          p.metricsFor(_tenantA).checkInsToday,
          1,
          reason:
              'ADR-0147 §3.1: a closed day is not silently re-opened. '
              'ANL-FR-052 requires a restatement to be VISIBLE, and a counter '
              'that quietly absorbed the backdated fact would restate without '
              'one.',
        );
      },
    );
  });

  group('ADR-0147 §3.5 — SeatsOccupied is presence-qualified', () {
    test('SEAT-AC-173 — 70 allocated, 40 present reads 40, not 70', () async {
      // The frozen acceptance criterion, verbatim arithmetic. The
      // pre-ADR-0147 getter (`seatsAssigned - seatsReleased`) returned 70.
      final List<DomainEvent> log = <DomainEvent>[];
      for (int i = 1; i <= 70; i++) {
        log.add(_assign(_tenantA, 'S-$i', 'SR-$i'));
      }
      for (int i = 1; i <= 40; i++) {
        log.add(_checkIn(_tenantA, 'SR-$i'));
      }

      final m = (await _fed(log)).metricsFor(_tenantA);

      expect(
        m.seatsOccupied,
        40,
        reason:
            'SEAT-AC-173 fixes this number. SEAT-FR-245: "a seat allocated to '
            'an absent student is allocated but NOT occupied."',
      );
      expect(
        m.seatsAssigned - m.seatsReleased,
        70,
        reason:
            'The allocation count is 70 and remains available — ADR-0147 §2.3 '
            'resolves the SEAT conflict by STRUCTURAL SEPARATION, keeping '
            'both readings rather than amending either PRD.',
      );
      expect(
        m.seatsOccupied,
        isNot(m.seatsAssigned - m.seatsReleased),
        reason:
            'If these ever coincide by construction, occupancy has silently '
            'become allocation again.',
      );
    });

    test('checking out vacates the seat without releasing it', () async {
      final log = <DomainEvent>[
        _assign(_tenantA, 'S-1', 'SR-1'),
        _checkIn(_tenantA, 'SR-1'),
        _checkOut(_tenantA, 'SR-1'),
      ];
      final m = (await _fed(log)).metricsFor(_tenantA);

      expect(m.seatsOccupied, 0, reason: 'The student is no longer present.');
      expect(
        m.seatsAssigned - m.seatsReleased,
        1,
        reason:
            'The allocation survives the absence — SEAT-FR-245 separates the '
            'two readings precisely so a lunch break is not a release.',
      );
    });

    test(
      'releasing the seat vacates it while the student stays inside',
      () async {
        // The converse of the test above, and the other half of SEAT-FR-116's
        // intersection: remove the ALLOCATION rather than the presence.
        final log = <DomainEvent>[
          _assign(_tenantA, 'S-1', 'SR-1'),
          _checkIn(_tenantA, 'SR-1'),
          _release(_tenantA, 'S-1'),
        ];
        final m = (await _fed(log)).metricsFor(_tenantA);

        expect(
          m.seatsOccupied,
          0,
          reason: 'No allocation remains, so no seat is occupied.',
        );
        expect(
          m.insideNow,
          1,
          reason:
              'Losing a seat is not leaving the library. ADR-0147 §3.6 makes '
              'InsideNow depend on the attendance session alone.',
        );
      },
    );

    test('presence without an allocation is not occupancy', () async {
      final m = (await _fed(<DomainEvent>[
        _checkIn(_tenantA, 'SR-1'),
      ])).metricsFor(_tenantA);

      expect(
        m.seatsOccupied,
        0,
        reason:
            'SEAT-FR-116 makes occupancy the INTERSECTION of the allocation '
            'set and the open-session set. A present student holding no seat '
            'occupies no seat.',
      );
      expect(m.insideNow, 1, reason: 'They are, however, inside.');
    });

    test('occupancy does not bleed across tenants', () async {
      final m = await _fed(<DomainEvent>[
        _assign(_tenantA, 'S-1', 'SR-1'),
        // Same student identifier, different tenant. If the sets were global,
        // tenant A would read 1.
        _checkIn(_tenantB, 'SR-1'),
      ]);

      expect(m.metricsFor(_tenantA).seatsOccupied, 0);
      expect(m.metricsFor(_tenantB).seatsOccupied, 0);
      expect(m.metricsFor(_tenantA).insideNow, 0);
      expect(m.metricsFor(_tenantB).insideNow, 1);
    });
  });

  group('ADR-0147 §3.6 — InsideNow is point-in-time, not day-scoped', () {
    test('an open session spanning the IST midnight still counts', () async {
      // Checked in 2026-08-20 23:00 IST (17:30Z); still open after a fact
      // lands on the next IST day.
      final p = await _fed(<DomainEvent>[
        _checkIn(_tenantA, 'SR-1', at: DateTime.utc(2026, 8, 20, 17, 30)),
        // A payment on the NEXT IST day advances the reporting day and resets
        // the day-scoped counters.
        _event(
          'fee.FeePaymentReceived',
          _tenantA,
          aggregateId: 'LEDGER-1',
          payload: const {'amountMinor': 1000, 'receiptNumber': 'R-1'},
          at: DateTime.utc(2026, 8, 20, 20),
        ),
      ]);
      final m = p.metricsFor(_tenantA);

      expect(
        m.insideNow,
        1,
        reason:
            'ADR-0147 §3.6 and D-10c: a student who has not checked out is '
            'still inside. InsideNow carries no window, so the day rollover '
            'must not clear it.',
      );
      expect(
        m.checkInsToday,
        0,
        reason:
            'The day-scoped counter DID reset — which is what makes the '
            'assertion above meaningful rather than incidental.',
      );
    });

    test('an unknown tenant reads zero, never another tenant\'s number', () {
      expect(
        AnalyticsProjections(
          FixedClock(_baseUtc),
        ).metricsFor(const TenantId('T-NEVER-SEEN')).insideNow,
        0,
      );
    });
  });

  group('ADR-0147 §7 R-9 — SeatTransferred is consumed defensively', () {
    test(
      'a transfer re-points the allocation without changing the count',
      () async {
        final log = <DomainEvent>[
          _assign(_tenantA, 'S-1', 'SR-1'),
          _checkIn(_tenantA, 'SR-1'),
          _event(
            'seating.SeatTransferred',
            _tenantA,
            aggregateId: 'ALLOC-S-1',
            payload: const {
              'studentRecordId': 'SR-1',
              'fromSeatLabel': 'S-1',
              'toSeatLabel': 'S-2',
            },
          ),
        ];
        final m = (await _fed(log)).metricsFor(_tenantA);

        expect(
          m.seatsOccupied,
          1,
          reason:
              'A transfer moves one student between seats. It must not double '
              'the occupancy, which is what a naive add-without-remove would do.',
        );
      },
    );

    test(
      'a transfer naming no source still cannot leave two seats held',
      () async {
        // The payload of seating.SeatTransferred is specified NOWHERE
        // (ADR-0147 §7 R-9) and no producer emits it. The consumer therefore
        // must not assume `fromSeatLabel` is present.
        final log = <DomainEvent>[
          _assign(_tenantA, 'S-1', 'SR-1'),
          _checkIn(_tenantA, 'SR-1'),
          _event(
            'seating.SeatTransferred',
            _tenantA,
            aggregateId: 'ALLOC-S-1',
            payload: const {'studentRecordId': 'SR-1', 'toSeatLabel': 'S-2'},
          ),
        ];
        final m = (await _fed(log)).metricsFor(_tenantA);

        expect(
          m.seatsOccupied,
          1,
          reason:
              'With no source named the consumer drops any seat the student '
              'already held, so a transfer cannot inflate occupancy through an '
              'under-specified payload.',
        );
      },
    );

    test('an unusable transfer payload is ignored, not fatal', () async {
      // No studentRecordId at all. ANL-FR-009 rejects blank DEFINITIONS; a
      // malformed FACT is a different matter and must not take the dashboard
      // down, because BC-26 does not control what BC-04 emits.
      final log = <DomainEvent>[
        _assign(_tenantA, 'S-1', 'SR-1'),
        _checkIn(_tenantA, 'SR-1'),
        _event(
          'seating.SeatTransferred',
          _tenantA,
          aggregateId: 'ALLOC-S-1',
          payload: const {'seatLabel': 'S-9'},
        ),
      ];
      final m = (await _fed(log)).metricsFor(_tenantA);

      expect(m.seatsOccupied, 1, reason: 'State is left untouched.');
    });

    test('BC-04 still emits no SeatTransferred — the residue is real', () {
      // ADR-0147 §7 R-9 records that the consumer is currently unreachable.
      // If a producer appears, this test fails and the residue must be
      // closed in the ADR rather than quietly dropped.
      // Scanned from `lib/` rather than from a guessed seating path: an
      // earlier version of this test named two directories that do not
      // exist, so it passed while asserting nothing. Anchoring on the whole
      // tree cannot be defeated by a module move.
      const String consumer = 'lib/platform/analytics/analytics.dart';
      final libRoot = Directory('lib');
      expect(
        libRoot.existsSync(),
        isTrue,
        reason: 'Run from the package root, or this test proves nothing.',
      );

      // Sanity: the emission the seating aggregate DOES perform must be
      // visible to this scan, otherwise a false negative below is
      // indistinguishable from a true one.
      final List<File> dartFiles = libRoot
          .listSync(recursive: true)
          .whereType<File>()
          .where((File f) => f.path.endsWith('.dart'))
          .toList(growable: false);
      expect(
        dartFiles.any(
          (File f) =>
              f.path != consumer &&
              !f.path.endsWith('dashboard_metrics_catalog.dart') &&
              f.readAsStringSync().contains('SeatAssigned'),
        ),
        isTrue,
        reason:
            'The scan cannot find the SeatAssigned producer that SEAT-EVT-001 '
            'requires and the code demonstrably has, so the SeatTransferred '
            'result below would be a false negative.',
      );

      final List<String> producers = dartFiles
          .where(
            (File f) =>
                // The consumer and the catalog both NAME the event; naming is
                // not emitting.
                f.path != consumer &&
                !f.path.endsWith('dashboard_metrics_catalog.dart') &&
                f.readAsStringSync().contains('SeatTransferred'),
          )
          .map((File f) => f.path)
          .toList(growable: false);

      expect(
        producers,
        isEmpty,
        reason:
            'A producer for seating.SeatTransferred now exists. ADR-0147 §7 '
            'R-9 assumed none did and left the payload UNCERTIFIED — the '
            'consumer guesses a shape. That residue must now be closed by an '
            'ADR supplying the payload contract, not by inferring the '
            'contract from whatever the new producer happens to emit.',
      );
    });
  });
}
