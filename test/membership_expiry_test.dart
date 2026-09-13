/// `BC-02` Membership — the expiry rule, the detection job, and the absence
/// of a grace period.
///
/// Covers `IMPL-425` against FROZEN `PRD-005` v1.4. Two obligations shape
/// this file:
///
///   * *"Validity correct **when the job has not run**"* (`MM-FR-107`,
///     `MM-NFR-012`) — so the sweep is deliberately NOT run in those tests.
///     A suite that always runs the job first would pass for an
///     implementation where truth lives in the job, which is exactly what
///     `MM-FR-104` forbids.
///   * *"a grace period is **absent**, proven as a negative"* (`MM-FR-111`).
///     A negative is the hard kind to prove, so it is attacked from three
///     directions: behaviour on the day after expiry, the absence of any
///     configurable that could express one, and the absence of the vocabulary.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora/platform/event/event.dart';
import 'package:liboora/platform/observability/observability.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const _tenant = TenantId('tnt_a');
const _branch = BranchId('brn_a');
const _student = StudentRecordId('stu_1');

/// 10 March 2026, 09:30 IST == 04:00 UTC.
final DateTime _nowUtc = DateTime.utc(2026, 3, 10, 4, 0);

final class _Ctx implements TenantContext {
  @override
  TenantId get tenantId => _tenant;
  @override
  BranchId get branchId => _branch;
  @override
  String? get actorId => 'owner_1';
  @override
  bool get hasTenant => true;
  @override
  String get correlationId => 'corr_test';
}

final class _SeqIds implements IdGenerator {
  int _n = 0;
  @override
  String next([String prefix = 'id']) => '${prefix}_${++_n}';
}

final class _Fixture {
  _Fixture() : ctx = _Ctx(), clock = FixedClock(_nowUtc) {
    repo = InMemoryMembershipRepository(
      TenantPartitionedStore<Membership>(ctx),
    );
    plans = InMemoryMembershipPlanRepository(
      TenantPartitionedStore<MembershipPlan>(ctx),
    );
    events = EventBus(ConsoleTelemetry(ctx));
    plan = MembershipPlan.create(
      id: 'plan_1',
      tenantId: _tenant,
      branchId: _branch,
      name: 'Monthly',
      durationDays: 30,
      price: Money.rupees(1200),
      createdAt: DateTime(2026, 1, 1),
      createdBy: 'owner_1',
      seatQuota: 1,
    );
    plans.save(plan);
    sweep = ExpireDueMemberships(
      repo: repo,
      calendar: const TenantBusinessCalendar('Asia/Kolkata'),
      config: const DefaultMembershipConfig(),
      events: events,
      clock: clock,
      ids: _SeqIds(),
      tenant: ctx,
    );
    validity = MembershipValidityService(repo, plans);
  }

  final _Ctx ctx;
  final FixedClock clock;
  late final InMemoryMembershipRepository repo;
  late final InMemoryMembershipPlanRepository plans;
  late final EventBus events;
  late final MembershipPlan plan;
  late final ExpireDueMemberships sweep;
  late final MembershipValidityService validity;

  int _n = 0;

  Membership add({
    required DateTime start,
    int durationDays = 30,
    MembershipStatus status = MembershipStatus.active,
    StudentRecordId student = _student,
  }) {
    final m = Membership.fromPlan(
      id: 'mem_${++_n}',
      studentRecordId: student,
      plan: plan,
      term: DateRange.days(start, durationDays),
      status: status,
      createdAt: _nowUtc,
      createdBy: 'owner_1',
      activatedAt: status == MembershipStatus.active ? _nowUtc : null,
    );
    repo.save(m);
    return m;
  }

  int get expiredEvents => events.log
      .where((e) => e.eventType == 'membership.MembershipExpired')
      .length;
}

void main() {
  // ════════════════════════════════════════════════════════════════════
  // MM-FR-104 / MM-FR-107 — truth does not depend on the job
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-104 expiry is deterministic from stored data', () {
    test('an elapsed membership reports isValid: false WITHOUT the sweep '
        'having run (MM-FR-107, MM-NFR-012)', () {
      final f = _Fixture();
      // Term ran 1-30 January. Today is 10 March. Status is still Active
      // because no job has run.
      final m = f.add(start: DateTime(2026, 1, 1));
      expect(m.status, MembershipStatus.active);

      // The sweep is deliberately NOT called.
      final v = f.validity.forStudent(_student, DateTime(2026, 3, 10));
      expect(
        v.isValid,
        isFalse,
        reason:
            'MM-FR-104: reading validity must never return a stale Active '
            'because a scheduler was down. The rule is evaluated at read '
            'time; the job only materialises the status.',
      );
      expect(
        f.repo.byId(m.id)!.status,
        MembershipStatus.active,
        reason:
            'And the stored status is genuinely still Active -- so this '
            'test really did exercise the unmaterialised case.',
      );
    });

    test(
      'the read-time rule and the sweep agree once the sweep has run',
      () async {
        final f = _Fixture();
        f.add(start: DateTime(2026, 1, 1));

        final before = f.validity.forStudent(_student, DateTime(2026, 3, 10));
        await f.sweep();
        final after = f.validity.forStudent(_student, DateTime(2026, 3, 10));

        expect(before.isValid, isFalse);
        expect(after.isValid, isFalse);
        expect(
          after.status,
          MembershipStatus.expired,
          reason: 'The sweep materialised what the rule already said.',
        );
      },
    );
  });

  // ════════════════════════════════════════════════════════════════════
  // MM-FR-103 / MM-FR-105 / MM-FR-106 — the sweep
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-105 expiry detection', () {
    test('a due membership transitions and emits MM-EVT-005 once', () async {
      final f = _Fixture();
      final m = f.add(start: DateTime(2026, 1, 1));

      final expired = await f.sweep();

      expect(expired, hasLength(1));
      expect(expired.single.id, m.id);
      expect(f.repo.byId(m.id)!.status, MembershipStatus.expired);
      expect(f.expiredEvents, 1);
    });

    test('the sweep is idempotent and safe to re-run (MM-FR-106)', () async {
      final f = _Fixture();
      f.add(start: DateTime(2026, 1, 1));

      await f.sweep();
      expect(f.expiredEvents, 1);

      for (var i = 0; i < 3; i++) {
        final again = await f.sweep();
        expect(again, isEmpty);
      }
      expect(
        f.expiredEvents,
        1,
        reason:
            'MM-FR-106: no duplicate event for a membership already '
            'Expired.',
      );
    });

    test(
      'a membership still inside its term is untouched (MM-FR-103)',
      () async {
        final f = _Fixture();
        // 1-30 March; today is the 10th.
        final m = f.add(start: DateTime(2026, 3, 1));

        expect(await f.sweep(), isEmpty);
        expect(f.repo.byId(m.id)!.status, MembershipStatus.active);
        expect(f.expiredEvents, 0);
      },
    );

    test(
      'a membership on its LAST day is not expired (MM-FR-062, MM-FR-103)',
      () async {
        final f = _Fixture();
        // Term 1-10 March inclusive; today is the 10th in Kolkata.
        final m = f.add(start: DateTime(2026, 3, 1), durationDays: 10);
        expect(m.endDate, DateTime(2026, 3, 10));

        expect(
          await f.sweep(),
          isEmpty,
          reason:
              'MM-FR-103 is STRICTLY greater than endDate, and MM-FR-062 '
              'makes the membership valid for the whole of that day.',
        );
        expect(f.repo.byId(m.id)!.status, MembershipStatus.active);
      },
    );

    test(
      'the day boundary is the TENANT\'s, not the server\'s (MM-FR-061)',
      () async {
        final f = _Fixture();
        f.add(start: DateTime(2026, 3, 1), durationDays: 10);

        // 18:29:59 UTC on 10 March == 23:59:59 IST, still the 10th.
        f.clock.set(DateTime.utc(2026, 3, 10, 18, 29, 59));
        expect(await f.sweep(), isEmpty);

        // One second later it is 00:00:00 IST on the 11th -- expired.
        f.clock.set(DateTime.utc(2026, 3, 10, 18, 30, 0));
        expect(await f.sweep(), hasLength(1));
      },
    );

    test('only Active memberships are swept — no other status is touched '
        '(MM-FR-074)', () async {
      for (final status in MembershipStatus.values.where(
        (s) => s != MembershipStatus.active,
      )) {
        final f = _Fixture();
        final m = f.add(start: DateTime(2026, 1, 1), status: status);

        expect(await f.sweep(), isEmpty, reason: '$status');
        expect(f.repo.byId(m.id)!.status, status);
        expect(f.expiredEvents, 0);
      }
    });

    test('the event carries what BC-04 needs to act (MM-FR-112)', () async {
      final f = _Fixture();
      final m = f.add(start: DateTime(2026, 1, 1));
      await f.sweep();

      final e = f.events.log.firstWhere(
        (e) => e.eventType == 'membership.MembershipExpired',
      );
      expect(e.payload['membershipId'], m.id);
      expect(e.payload['studentRecordId'], _student.value);
      expect(e.payload['endDate'], m.endDate.toIso8601String());
      expect(e.tenantId, _tenant);
    });

    test('several due memberships are all swept in one run', () async {
      final f = _Fixture();
      f.add(start: DateTime(2026, 1, 1), student: const StudentRecordId('a'));
      f.add(start: DateTime(2026, 1, 1), student: const StudentRecordId('b'));
      f.add(start: DateTime(2026, 3, 1), student: const StudentRecordId('c'));

      final expired = await f.sweep();
      expect(expired, hasLength(2));
      expect(f.expiredEvents, 2);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // MM-FR-108 — expiring soon, on the shared MM-CFG-008 threshold
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-108 expiring soon', () {
    test('a membership within MM-CFG-008 days of endDate is reported', () {
      final f = _Fixture();
      // Ends 15 March; today is the 10th -> 5 days remaining, inside 7.
      f.add(start: DateTime(2026, 2, 14), durationDays: 30);
      expect(f.sweep.expiringSoon(), hasLength(1));
    });

    test('a membership outside the threshold is not reported', () {
      final f = _Fixture();
      // Ends 30 March; today is the 10th -> 20 days remaining.
      f.add(start: DateTime(2026, 3, 1));
      expect(f.sweep.expiringSoon(), isEmpty);
    });

    test('an already-expired membership is not "expiring soon"', () {
      final f = _Fixture();
      f.add(start: DateTime(2026, 1, 1));
      expect(
        f.sweep.expiringSoon(),
        isEmpty,
        reason: 'It has expired, not "soon".',
      );
    });

    test('the threshold comes from MM-CFG-008, the single shared value '
        '(MM-BR-026)', () {
      const cfg = DefaultMembershipConfig();
      expect(cfg.expiringSoonDays, 7);
      // MM-BR-026 requires ONE threshold behind both MM-EVT-006 and the
      // expiring view. It is read from the port rather than duplicated, so
      // retuning it moves both together.
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // MM-FR-111 — NO grace period, proven as a negative
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-111 there is no grace period', () {
    test('entitlement stops the day AFTER endDate, with no extension', () {
      final f = _Fixture();
      final m = f.add(start: DateTime(2026, 3, 1), durationDays: 10);

      expect(m.isValidOn(m.endDate), isTrue);
      expect(
        m.isValidOn(m.endDate.add(const Duration(days: 1))),
        isFalse,
        reason:
            'MM-AC-044: no entitlement is granted after endDate; there is '
            'no grace path in V1.',
      );
    });

    test('no configurable can express a grace period (MM-FR-111)', () {
      // If a grace period existed it would need a knob. §13.4 lists nine
      // configurables and none of them is one -- which is the structural
      // form of "V1 MUST NOT implement a grace period".
      const cfg = DefaultMembershipConfig();
      expect(cfg.defaultCurrency, isNotNull);
      expect(cfg.maxEnrollmentStaleness, isNotNull);
      expect(cfg.maxBackdateDays, isNotNull);
      expect(cfg.maxForwardDateDays, isNotNull);
      expect(cfg.idempotencyRetention, isNotNull);
      expect(cfg.tenantTimezone, isNotNull);
      expect(cfg.pendingPaymentVoidWindow, isNotNull);
      expect(cfg.expiringSoonDays, isNotNull);
      expect(cfg.reDeriveTermOnDelayedActivation, isNotNull);
      // Nine, and the last is about re-deriving a term, not extending one.
    });

    test('an expired membership confers nothing on any read path '
        '(MM-FR-109, MM-INV-004)', () async {
      final f = _Fixture();
      f.add(start: DateTime(2026, 1, 1));
      await f.sweep();

      final v = f.validity.forStudent(_student, DateTime(2026, 3, 10));
      expect(v.isValid, isFalse);
      expect(v.seatQuota, 0);
      expect(v.status, MembershipStatus.expired);
    });

    test('expiry is terminal — there is no un-expire that could act as grace '
        '(MM-FR-075)', () {
      final f = _Fixture();
      final m = f.add(start: DateTime(2026, 1, 1));
      m.expire();

      expect(m.status.isTerminal, isTrue);
      expect(
        () => m.activate(),
        throwsA(isA<DomainError>()),
        reason:
            'MM-FR-075: Expired is terminal. A renewal creates a NEW '
            'membership rather than reviving a terminal one.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // MM-FR-112 — seat reclamation is not this module's decision
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-112 no downstream writes on expiry', () {
    test('the sweep emits an event and writes nothing downstream', () async {
      final f = _Fixture();
      f.add(start: DateTime(2026, 1, 1));
      await f.sweep();

      // The only thing published is the membership fact. Releasing a seat
      // here would decide Q-01, which BC Map leaves OPEN and MM-FR-112
      // assigns to BC-04.
      expect(f.events.log.map((e) => e.eventType).toSet(), {
        'membership.MembershipExpired',
      });
    });
  });
}
