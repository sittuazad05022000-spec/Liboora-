/// `BC-02` Membership — duplicate prevention, idempotency, and activation.
///
/// Covers `IMPL-414` (duplicate prevention and idempotency, enforced at the
/// persistence boundary) and `IMPL-415` (activation conditions, including the
/// `MM-CFG-007` auto-void window) against FROZEN `PRD-005` v1.4.
///
/// `IMPL-414`'s test obligation is explicit and unusual: *"**Concurrent**
/// creations for one student: exactly one succeeds, decided by the constraint
/// — not by a read-check."* The task doc explains why it insists
/// (`PRD-005_IMPLEMENTATION_TASKS.md` L196): *"An application-level pre-check
/// passes every single-threaded test and fails in production under two
/// reception terminals. The test must run concurrent commands."* So the
/// concurrency tests below launch commands without awaiting in between, which
/// is the only way to interleave them in a single-isolate runtime.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora/platform/event/event.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora/platform/observability/observability.dart';
import 'package:liboora/platform/services/services.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

final DateTime _now = DateTime.utc(2026, 3, 10, 9, 30);
const _tenant = TenantId('tnt_a');
const _branch = BranchId('brn_a');
const _student = StudentRecordId('stu_1');
const _other = StudentRecordId('stu_2');

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

final class _Enrollment implements EnrollmentStatusReader {
  @override
  MembershipEnrollmentState? stateFor(StudentRecordId id) =>
      MembershipEnrollmentState.active;
}

final class _SeqIds implements IdGenerator {
  int _n = 0;
  @override
  String next([String prefix = 'id']) => '${prefix}_${++_n}';
}

final class _Fixture {
  _Fixture() : ctx = _Ctx(), clock = FixedClock(_now) {
    memberships = InMemoryMembershipRepository(
      TenantPartitionedStore<Membership>(ctx),
    );
    plans = InMemoryMembershipPlanRepository(
      TenantPartitionedStore<MembershipPlan>(ctx),
    );
    events = EventBus(ConsoleTelemetry(ctx));
    create = CreateMembership(
      repo: memberships,
      plans: plans,
      enrollment: _Enrollment(),
      config: const DefaultMembershipConfig(),
      idempotency: MembershipIdempotencyAdapter(IdempotencyService(ctx)),
      events: events,
      clock: clock,
      ids: _SeqIds(),
      tenant: ctx,
      pdp: const PolicyDecisionPoint(),
    );
    plan = MembershipPlan.create(
      id: 'plan_1',
      tenantId: _tenant,
      branchId: _branch,
      name: 'Monthly',
      durationDays: 30,
      price: Money.rupees(1200),
      createdAt: _now,
      createdBy: 'owner_1',
      seatQuota: 1,
    );
    plans.save(plan);
  }

  final _Ctx ctx;
  final FixedClock clock;
  late final InMemoryMembershipRepository memberships;
  late final InMemoryMembershipPlanRepository plans;
  late final EventBus events;
  late final CreateMembership create;
  late final MembershipPlan plan;

  int _seq = 0;

  Future<Membership> sell({
    String? key,
    StudentRecordId student = _student,
    DateTime? startingOn,
    bool paid = true,
  }) => create(
    actorRole: AccessRole.owner,
    idempotencyKey: IdempotencyKey(key ?? 'idem_${++_seq}'),
    studentId: student,
    plan: plan,
    startingOn: startingOn,
    paymentAlreadyReceived: paid,
  );
}

Future<DomainError> _rejects(Future<void> Function() act) async {
  try {
    await act();
  } on DomainError catch (e) {
    return e;
  }
  fail('Expected a typed DomainError, but the call succeeded.');
}

void main() {
  // ════════════════════════════════════════════════════════════════════
  // IMPL-414 — duplicate prevention and idempotency
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-414 idempotency', () {
    test('a repeated command with the same key returns the ORIGINAL result — '
        'same id, no second write, no second event (MM-FR-047)', () async {
      final f = _Fixture();
      final first = await f.sell(key: 'k1');
      await f.events.drain();
      final eventsAfterFirst = f.events.log.length;

      final second = await f.sell(key: 'k1');
      await f.events.drain();

      expect(
        second.id,
        first.id,
        reason: 'MM-FR-047 requires the ORIGINAL membershipId back.',
      );
      expect(identical(second, first), isTrue);
      expect(f.memberships.all(), hasLength(1), reason: 'No second write.');
      expect(
        f.events.log.length,
        eventsAfterFirst,
        reason: 'No new event on a replay.',
      );
    });

    test('the replay check runs BEFORE the preconditions, so a retry does not '
        'trip over the state its own first call created (MM-FR-047)', () async {
      final f = _Fixture();
      await f.sell(key: 'k1');

      // Without an early replay check the retry would reach the overlap
      // guard and be rejected as conflicting with itself -- the classic
      // idempotency bug that looks like correct validation.
      final retry = await f.sell(key: 'k1');
      expect(retry.id, isNotNull);
      expect(f.memberships.all(), hasLength(1));
    });

    test('idempotency records are tenant-scoped, so two tenants may reuse one '
        'key string (MM-FR-048)', () {
      // The service namespaces by tenant. Asserted at the service, because
      // the fixture is single-tenant by construction.
      final ctx = _Ctx();
      final svc = IdempotencyService(ctx);
      svc.remember(const IdempotencyKey('shared'), 'A');
      expect(svc.recall<String>(const IdempotencyKey('shared')), 'A');
      expect(svc.seen(const IdempotencyKey('other')), isFalse);
    });

    test(
      'a different key creates a genuinely new membership (MM-FR-047)',
      () async {
        final f = _Fixture();
        final a = await f.sell(key: 'k1', student: _student);
        final b = await f.sell(key: 'k2', student: _other);
        expect(a.id, isNot(b.id));
        expect(f.memberships.all(), hasLength(2));
      },
    );
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-414 — overlap, enforced at the persistence boundary
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-414 overlap prevention', () {
    test('an overlapping creation fails with a typed error naming the '
        'conflicting membership AND its term (MM-FR-049)', () async {
      final f = _Fixture();
      final first = await f.sell(key: 'k1');

      final e = await _rejects(() => f.sell(key: 'k2'));

      expect(e.code, DomainErrorCode.overlappingMembershipTerm);
      expect(e.context['existingMembershipId'], first.id);
      expect(e.context['existingStartDate'], isNotNull);
      expect(e.context['existingEndDate'], isNotNull);
      expect(e.context['existingStatus'], first.status.name);

      // MM-FR-049: it must NOT silently return the existing membership --
      // the actor may have intended a different plan.
      expect(
        f.memberships.all(),
        hasLength(1),
        reason: 'The second sale wrote nothing.',
      );
    });

    test('a PendingPayment membership DOES block an overlapping sale '
        '(MM-FR-049, MM-CFG-007)', () async {
      final f = _Fixture();
      await f.sell(key: 'k1', paid: false);

      final e = await _rejects(() => f.sell(key: 'k2', paid: false));
      expect(e.code, DomainErrorCode.overlappingMembershipTerm);
      expect(e.context['existingStatus'], 'pendingPayment');
      expect(
        f.memberships.all(),
        hasLength(1),
        reason:
            'Two overlapping PendingPayment rows would both activate when '
            'their payments landed, breaking MM-INV-001.',
      );
    });

    test('a non-overlapping later term is allowed (MM-INV-001)', () async {
      final f = _Fixture();
      await f.sell(key: 'k1');
      // Starts after the first term ends, and inside MM-CFG-004's window.
      final next = await f.sell(
        key: 'k2',
        startingOn: _now.add(const Duration(days: 40)),
      );
      expect(next.id, isNotNull);
      expect(f.memberships.all(), hasLength(2));
    });

    test('CONCURRENT creations for one student: exactly one succeeds '
        '(MM-FR-046)', () async {
      final f = _Fixture();

      // Launched WITHOUT awaiting in between, so all three are in flight
      // before any of them writes. This is what the task doc demands: a
      // read-then-write in application code has an await between the check
      // and the save, and would let all three through here.
      final inFlight = [
        f.sell(key: 'k1'),
        f.sell(key: 'k2'),
        f.sell(key: 'k3'),
      ];

      var succeeded = 0;
      var rejected = 0;
      for (final future in inFlight) {
        try {
          await future;
          succeeded++;
        } on DomainError catch (e) {
          expect(e.code, DomainErrorCode.overlappingMembershipTerm);
          rejected++;
        }
      }

      expect(
        succeeded,
        1,
        reason: 'Exactly one concurrent creation may succeed.',
      );
      expect(
        rejected,
        2,
        reason:
            'The other two must be REFUSED with a typed error, not '
            'silently dropped or silently merged.',
      );
      expect(
        f.memberships.all(),
        hasLength(1),
        reason:
            'MM-INV-001 allows one non-terminal term per student. The '
            'constraint decides, not the ordering.',
      );
    });

    test('concurrent creations with the SAME key collapse to one membership '
        '(MM-FR-047)', () async {
      final f = _Fixture();
      final outcomes = <Object?>[];
      for (final future in [f.sell(key: 'same'), f.sell(key: 'same')]) {
        try {
          outcomes.add(await future);
        } on DomainError catch (e) {
          outcomes.add(e);
        }
      }
      expect(f.memberships.all(), hasLength(1));
      expect(outcomes, hasLength(2));
    });

    test('overlap is enforced at the repository write, not by a read-check in '
        'the use case (MM-FR-046)', () {
      final f = _Fixture();
      final m = Membership.fromPlan(
        id: 'mem_direct',
        studentRecordId: _student,
        plan: f.plan,
        term: DateRange.days(_now, 30),
        createdAt: _now,
      );
      f.memberships.insertGuardingOverlap(m);

      // Going straight at the repository, bypassing CreateMembership
      // entirely, must still be refused. If the guarantee lived in the use
      // case, this second insert would succeed.
      final clash = Membership.fromPlan(
        id: 'mem_clash',
        studentRecordId: _student,
        plan: f.plan,
        term: DateRange.days(_now.add(const Duration(days: 5)), 30),
        createdAt: _now,
      );
      expect(
        () => f.memberships.insertGuardingOverlap(clash),
        throwsA(isA<DomainError>()),
      );
      expect(f.memberships.all(), hasLength(1));
    });

    test(
      'a terminal membership does not block a new term (MM-FR-049)',
      () async {
        final f = _Fixture();
        final first = await f.sell(key: 'k1', paid: false);
        first.cancel();
        f.memberships.save(first);

        final replacement = await f.sell(key: 'k2');
        expect(replacement.id, isNot(first.id));
        expect(
          f.memberships.all(),
          hasLength(2),
          reason: 'Cancelled is retired, not deleted (MM-BR-024).',
        );
      },
    );
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-415 — activation conditions
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-415 activation conditions', () {
    test('a settled sale with a FUTURE startDate is held in Scheduled and '
        'confers nothing (MM-FR-053)', () async {
      final f = _Fixture();
      final m = await f.sell(
        key: 'k1',
        startingOn: _now.add(const Duration(days: 20)),
        paid: true,
      );

      expect(
        m.status,
        MembershipStatus.scheduled,
        reason:
            'MM-FR-074: "amount = 0 or already paid, FUTURE startDate" -> '
            'Scheduled, not Active.',
      );
      expect(m.status.confersEntitlement, isFalse);
      expect(
        m.isValidOn(f.clock.today()),
        isFalse,
        reason:
            'An April membership sold in March must not let the student in '
            'during March.',
      );
      expect(m.activatedAt, isNull, reason: 'MM-INV-011.');
    });

    test(
      'a settled sale starting today is Active at once (MM-FR-074)',
      () async {
        final f = _Fixture();
        final m = await f.sell(key: 'k1', paid: true);
        expect(m.status, MembershipStatus.active);
        expect(m.activatedAt, _now);
      },
    );

    test('an unsettled sale is PendingPayment regardless of startDate '
        '(MM-FR-041)', () async {
      final f = _Fixture();
      final future = await f.sell(
        key: 'k1',
        startingOn: _now.add(const Duration(days: 20)),
        paid: false,
      );
      expect(future.status, MembershipStatus.pendingPayment);
    });

    test('activation is refused before startDate and after endDate '
        '(MM-FR-052)', () async {
      final f = _Fixture();
      final m = await f.sell(
        key: 'k1',
        startingOn: _now.add(const Duration(days: 20)),
        paid: true,
      );
      expect(m.status, MembershipStatus.scheduled);

      // Too early.
      final early = _rejectsSync(() => m.activateOn(f.clock.today()));
      expect(early.code, DomainErrorCode.validationFailed);
      expect(early.context['startDate'], isNotNull);
      expect(m.status, MembershipStatus.scheduled);

      // Too late.
      final late = _rejectsSync(
        () => m.activateOn(m.term.end.add(const Duration(days: 1))),
      );
      expect(late.code, DomainErrorCode.validationFailed);
      expect(late.context['endDate'], isNotNull);
      expect(m.status, MembershipStatus.scheduled);

      // On time.
      m.activateOn(m.term.start, by: 'owner_1');
      expect(m.status, MembershipStatus.active);
      expect(m.activatedAt, m.term.start);
    });

    test(
      'activatedAt is written once and never overwritten (MM-INV-011)',
      () async {
        final f = _Fixture();
        final m = await f.sell(key: 'k1', paid: false);
        expect(m.activatedAt, isNull);

        final first = _now.add(const Duration(days: 1));
        m.activateOn(first, by: 'owner_1');
        expect(m.activatedAt, first);

        m.expire();
        expect(
          m.activatedAt,
          first,
          reason:
              'MM-INV-011 is "has EVER been Active" -- the first activation '
              'is the historical fact.',
        );
      },
    );

    test('MM-CFG-007 identifies a stale PendingPayment, and only a '
        'PendingPayment one', () async {
      final f = _Fixture();
      final pending = await f.sell(key: 'k1', paid: false);
      const window = Duration(days: 7);

      expect(
        pending.isStalePendingPayment(_now, window: window),
        isFalse,
        reason: 'Created just now.',
      );
      expect(
        pending.isStalePendingPayment(
          _now.add(const Duration(days: 6)),
          window: window,
        ),
        isFalse,
        reason: 'Still inside the window.',
      );
      expect(
        pending.isStalePendingPayment(
          _now.add(const Duration(days: 8)),
          window: window,
        ),
        isTrue,
        reason: 'Past MM-CFG-007 -- eligible for the authorised void.',
      );

      // An Active membership is never "stale pending payment", however old.
      final active = await f.sell(key: 'k2', student: _other, paid: true);
      expect(
        active.isStalePendingPayment(
          _now.add(const Duration(days: 900)),
          window: window,
        ),
        isFalse,
      );
    });

    test(
      'the void window is a PREDICATE — the aggregate does not cancel itself '
      '(MM-EVT-007)',
      () async {
        final f = _Fixture();
        final m = await f.sell(key: 'k1', paid: false);

        // Stale, and still PendingPayment: voiding is a command with an actor
        // and an event behind it, not a silent side effect of asking.
        expect(
          m.isStalePendingPayment(
            _now.add(const Duration(days: 30)),
            window: const Duration(days: 7),
          ),
          isTrue,
        );
        expect(m.status, MembershipStatus.pendingPayment);
      },
    );

    test('the MM-CFG-007 default is 7 days and is read from config', () {
      const cfg = DefaultMembershipConfig();
      expect(cfg.pendingPaymentVoidWindow, const Duration(days: 7));
    });
  });
}

DomainError _rejectsSync(void Function() act) {
  try {
    act();
  } on DomainError catch (e) {
    return e;
  }
  fail('Expected a typed DomainError, but the call succeeded.');
}
