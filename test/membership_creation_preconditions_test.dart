/// `BC-02` Membership — creation preconditions, creation outputs and the
/// persistence rules.
///
/// Covers `IMPL-411` (active enrollment over `E-01`, selectable plan),
/// `IMPL-413` (creation outputs and initial status) and `IMPL-426`
/// (persistence rules — tenant key, no hard delete) against FROZEN
/// `PRD-005` v1.4.
///
/// `IMPL-411`'s test obligation is the sharp one: *"Creation refused when
/// enrollment is not `Active`; **fails closed** when the `E-01` stream is
/// unavailable."* Failing closed is the case a happy-path test never reaches,
/// so the `E-01` double here can be told to break, and the test asserts that
/// nothing was written when it did.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora/platform/event/event.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora/platform/observability/observability.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const String _modulePath = 'lib/domain/library/membership/membership.dart';

final DateTime _now = DateTime.utc(2026, 3, 10, 9, 30);
const _tenant = TenantId('tnt_a');
const _branch = BranchId('brn_a');
const _student = StudentRecordId('stu_1');

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

/// An `E-01` double that can be told to be unavailable.
///
/// `MM-BR-013` distinguishes "not enrolled" from "cannot tell", and the whole
/// point of the rule is that the second must not be silently treated as the
/// first. So this double models both.
final class _Enrollment implements EnrollmentStatusReader {
  _Enrollment(this.state);
  MembershipEnrollmentState? state;
  bool unavailable = false;
  int reads = 0;

  @override
  MembershipEnrollmentState? stateFor(StudentRecordId id) {
    reads++;
    if (unavailable) {
      throw const EnrollmentStreamUnavailable('E-01 stream is down');
    }
    return state;
  }
}

final class _SeqIds implements IdGenerator {
  int _n = 0;
  @override
  String next([String prefix = 'id']) => '${prefix}_${++_n}';
}

final class _Fixture {
  _Fixture({
    MembershipEnrollmentState? enrollmentState =
        MembershipEnrollmentState.active,
    MembershipConfig config = const DefaultMembershipConfig(),
  }) : ctx = _Ctx(),
       clock = FixedClock(_now),
       enrollment = _Enrollment(enrollmentState) {
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
      enrollment: enrollment,
      config: config,
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
  final _Enrollment enrollment;
  late final InMemoryMembershipRepository memberships;
  late final InMemoryMembershipPlanRepository plans;
  late final EventBus events;
  late final CreateMembership create;
  late final MembershipPlan plan;

  Future<Membership> sell({
    DateTime? startingOn,
    MembershipPlan? using,
    bool paid = true,
  }) => create(
    actorRole: AccessRole.owner,
    studentId: _student,
    plan: using ?? plan,
    startingOn: startingOn,
    paymentAlreadyReceived: paid,
  );
}

/// Published events. `_outbox` is private, so the bus is drained and the log
/// read -- which also proves the events were publishable, not merely staged.
Future<List<DomainEvent>> _published(_Fixture f) async {
  await f.events.drain();
  return f.events.log;
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
  // IMPL-411 — creation preconditions
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-411 creation preconditions', () {
    test('an active enrollment admits a membership (MM-FR-033)', () async {
      final f = _Fixture();
      final m = await f.sell();
      expect(m.studentRecordId, _student);
      expect(f.enrollment.reads, greaterThan(0), reason: 'E-01 must be read.');
    });

    test('Inactive, Suspended and Archived are each refused, and the error '
        'NAMES the state (MM-FR-035)', () async {
      for (final state in const [
        MembershipEnrollmentState.inactive,
        MembershipEnrollmentState.suspended,
        MembershipEnrollmentState.archived,
      ]) {
        final f = _Fixture(enrollmentState: state);
        final e = await _rejects(f.sell);

        expect(e.code, DomainErrorCode.validationFailed);
        expect(
          e.context['enrollmentStatus'],
          state.name,
          reason:
              'MM-FR-035 requires the failure to name the enrollment state, '
              'so a caller can explain it without guessing.',
        );
        expect(
          f.memberships.all(),
          isEmpty,
          reason: 'MM-FR-033: refused before anything is mutated.',
        );
      }
    });

    test('only Active admits — the enum offers no fourth admitting state '
        '(MM-FR-033)', () {
      final admitting = MembershipEnrollmentState.values
          .where((s) => s.admitsNewMembership)
          .toList();
      expect(admitting, [MembershipEnrollmentState.active]);
    });

    test('an unknown student is refused rather than enrolled by default '
        '(MM-FR-033)', () async {
      final f = _Fixture(enrollmentState: null);
      final e = await _rejects(f.sell);
      expect(e.code, DomainErrorCode.notFound);
      expect(f.memberships.all(), isEmpty);
    });

    test('creation FAILS CLOSED when the E-01 stream is unavailable '
        '(MM-BR-013)', () async {
      final f = _Fixture();
      f.enrollment.unavailable = true;

      // The distinct exception type is the point: it must NOT be caught and
      // downgraded into "probably enrolled". MM-BR-013 forbids assuming an
      // active enrollment when the stream cannot be read.
      await expectLater(f.sell(), throwsA(isA<EnrollmentStreamUnavailable>()));

      expect(
        f.memberships.all(),
        isEmpty,
        reason: 'Failing closed means nothing was written.',
      );
      expect(
        f.events.log,
        isEmpty,
        reason: 'No event may be published for a creation that failed.',
      );
    });

    test('"unavailable" and "not enrolled" are different types, so they cannot '
        'be collapsed by accident (MM-BR-013)', () {
      expect(
        const EnrollmentStreamUnavailable('x'),
        isNot(isA<DomainError>()),
        reason:
            'A shared type would let one catch clause swallow both, which '
            'is exactly the fail-open MM-BR-013 forbids.',
      );
    });

    test(
      'a deactivated plan is not selectable (MM-FR-020, MM-FR-033)',
      () async {
        final f = _Fixture();
        final retired = f.plan.deactivate();
        f.plans.save(retired);

        final e = await _rejects(() => f.sell(using: retired));
        expect(e.code, DomainErrorCode.validationFailed);
        expect(e.context['field'], 'isActive');
        expect(f.memberships.all(), isEmpty);
      },
    );

    test('a plan that is not in THIS tenant catalogue is refused '
        '(MM-BR-029, MM-FR-033)', () async {
      final f = _Fixture();
      // Constructed, never saved into this tenant's catalogue — which is
      // indistinguishable from a plan belonging to another tenant, because
      // the store is partitioned.
      final foreign = MembershipPlan.create(
        id: 'plan_foreign',
        tenantId: const TenantId('tnt_b'),
        branchId: const BranchId('brn_b'),
        name: 'Other Tenant Monthly',
        durationDays: 30,
        price: Money.rupees(999),
        createdAt: _now,
        createdBy: 'owner_2',
      );

      final e = await _rejects(() => f.sell(using: foreign));
      expect(e.code, DomainErrorCode.validationFailed);
      expect(e.context['field'], 'planId');
      expect(f.memberships.all(), isEmpty);
    });

    test('an unauthorised actor is refused before E-01 is even consulted '
        '(MM-FR-033, §16.3)', () async {
      final f = _Fixture();
      await expectLater(
        f.create(
          actorRole: AccessRole.student,
          studentId: _student,
          plan: f.plan,
        ),
        throwsA(anything),
      );
      expect(
        f.enrollment.reads,
        0,
        reason:
            'Authorisation is the first precondition; a refused actor must '
            'not cause a cross-context read.',
      );
      expect(f.memberships.all(), isEmpty);
    });

    test('BC-02 does not import BC-01 — E-01 is a port, not a dependency '
        '(MM-FR-003, law L3)', () {
      final source = File(_modulePath).readAsStringSync();
      expect(
        source.contains("import '../enrollment/enrollment.dart'"),
        isFalse,
        reason:
            'The enrollment precondition is read through '
            'EnrollmentStatusReader, declared by this consumer and wired in '
            'di.dart. An import would make the edge a compile-time '
            'dependency and put BC-01 fields within reach.',
      );
      expect(source.contains('StudentRecord '), isFalse);
      expect(
        source.contains(
          'abstract interface class '
          'EnrollmentStatusReader',
        ),
        isTrue,
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-413 — creation outputs and initial status
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-413 creation outputs and initial status', () {
    test(
      'startDate defaults to the current business date (MM-FR-038)',
      () async {
        final f = _Fixture();
        final m = await f.sell();
        expect(m.term.start, f.clock.today());
      },
    );

    test('startDate is bounded by MM-CFG-003 behind and MM-CFG-004 ahead '
        '(MM-FR-038)', () async {
      final f = _Fixture();
      final cfg = const DefaultMembershipConfig();

      // Just inside both bounds: accepted.
      final back = await f.sell(
        startingOn: f.clock.today().subtract(
          Duration(days: cfg.maxBackdateDays),
        ),
      );
      expect(back.term.start, isNotNull);

      // Just outside the back bound: refused, and the error reports the
      // bound it broke rather than only saying "invalid".
      final f2 = _Fixture();
      final tooOld = await _rejects(
        () => f2.sell(
          startingOn: f2.clock.today().subtract(
            Duration(days: cfg.maxBackdateDays + 1),
          ),
        ),
      );
      expect(tooOld.code, DomainErrorCode.validationFailed);
      expect(tooOld.context['maxBackdateDays'], cfg.maxBackdateDays);

      // Just outside the forward bound.
      final f3 = _Fixture();
      final tooFar = await _rejects(
        () => f3.sell(
          startingOn: f3.clock.today().add(
            Duration(days: cfg.maxForwardDateDays + 1),
          ),
        ),
      );
      expect(tooFar.code, DomainErrorCode.validationFailed);
      expect(tooFar.context['maxForwardDateDays'], cfg.maxForwardDateDays);
    });

    test('the bounds are read from config, not hard-coded — a retuned window '
        'moves them (MM-CFG-003, MM-CFG-004, E-19)', () async {
      // Proves the rule is wired to the port. With a 1-day window, a 5-day
      // back-date must fail; with the default 7, it must pass.
      final tight = _Fixture(
        config: const DefaultMembershipConfig(maxBackdateDays: 1),
      );
      final e = await _rejects(
        () => tight.sell(
          startingOn: tight.clock.today().subtract(const Duration(days: 5)),
        ),
      );
      expect(e.context['maxBackdateDays'], 1);

      final loose = _Fixture();
      final ok = await loose.sell(
        startingOn: loose.clock.today().subtract(const Duration(days: 5)),
      );
      expect(
        ok.term.start,
        loose.clock.today().subtract(const Duration(days: 5)),
      );
    });

    test('endDate is computed by the module and cannot be supplied by the '
        'caller (MM-FR-039)', () async {
      final f = _Fixture();
      final m = await f.sell();

      // Derived from the plan's duration, not from any input.
      expect(m.term.start, f.clock.today());
      expect(m.term.lengthInDays, f.plan.durationDays);

      // Structural: there is no endDate parameter to pass.
      final source = File(_modulePath).readAsStringSync();
      expect(
        RegExp(r'DateTime\??\s+endDate').hasMatch(source),
        isFalse,
        reason:
            'MM-FR-039 says endDate MUST NOT be supplied by the caller. The '
            'strongest form of that is no parameter existing.',
      );
    });

    test('on success the membership persists every MM-FR-040 field and emits '
        'MM-EVT-001', () async {
      final f = _Fixture();
      final m = await f.sell();

      // Persisted.
      final stored = f.memberships.byId(m.id);
      expect(stored, isNotNull);
      expect(stored!.priceSnapshot, Money.rupees(1200));
      expect(stored.currencySnapshot, 'INR');
      expect(stored.planVersionAtPurchase, f.plan.version);
      expect(stored.createdAt, _now);
      expect(stored.createdBy, 'owner_1');

      // Emitted.
      final created = (await _published(
        f,
      )).where((e) => e.eventType == 'membership.MembershipCreated').toList();
      expect(created, hasLength(1));
      final p = created.single.payload;
      expect(p['priceMinor'], Money.rupees(1200).minorUnits);
      expect(p['currency'], 'INR');
      expect(p['planVersionAtPurchase'], f.plan.version);
      expect(p['createdAt'], _now.toIso8601String());
      expect(p['createdBy'], 'owner_1');
    });

    test('the initial status follows the payment dependency and is never '
        'invented (MM-FR-043, MM-FR-041)', () async {
      final unpaid = _Fixture();
      final pending = await unpaid.sell(paid: false);
      expect(pending.status, MembershipStatus.pendingPayment);
      expect(pending.activatedAt, isNull);

      final settled = _Fixture();
      final active = await settled.sell(paid: true);
      expect(active.status, MembershipStatus.active);
      expect(active.activatedAt, _now);
    });

    test('creation records no monetary transaction (MM-FR-044)', () async {
      final f = _Fixture();
      await f.sell();
      // The only event this module emits is the membership fact. A FeeDue,
      // receipt or payment event here would be BC-05's job taken by force.
      expect((await _published(f)).map((e) => e.eventType).toSet(), {
        'membership.MembershipCreated',
      });
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-426 — persistence rules
  // Obligation: "tenantId in every primary/unique key; no delete path
  // exists."
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-426 persistence rules', () {
    test('the store namespaces every key by tenant, so tenantId is part of the '
        'key by construction (MM-BR-023)', () {
      final source = File('lib/platform/data/data.dart').readAsStringSync();
      expect(
        source.contains(r"'${_tenantContext.tenantId.value}::$id'"),
        isTrue,
        reason:
            'X-13 requires tenantId in the key. Building it inside the '
            'store means a repository cannot forget it — there is no '
            'un-namespaced write path to call.',
      );
    });

    test('no repository exposes a hard delete (MM-BR-024)', () {
      final source = File(_modulePath).readAsStringSync();
      for (final banned in const [
        'void delete(',
        'void remove(',
        'void purge(',
        'void hardDelete(',
      ]) {
        expect(
          source.contains(banned),
          isFalse,
          reason:
              'MM-BR-024: memberships are retired through terminal states, '
              'never deleted. Found "$banned".',
        );
      }
    });

    test('retirement happens through a terminal status, and the row stays '
        'readable afterwards (MM-BR-024)', () async {
      // An UNPAID membership, because MM-FR-074 does not permit
      // Active -> Cancelled. Only PendingPayment and Scheduled may be
      // voided; a live membership retires through Expired or Superseded.
      // Using the lawful path here keeps this test about MM-BR-024
      // (retirement is not deletion) instead of accidentally asserting a
      // transition the frozen table forbids.
      final f = _Fixture();
      final m = await f.sell(paid: false);
      expect(m.status, MembershipStatus.pendingPayment);

      m.cancel();
      expect(m.status, MembershipStatus.cancelled);
      expect(m.status.isTerminal, isTrue);
      f.memberships.save(m);

      // Still there. This is the difference between retirement and deletion
      // that MM-BR-024 is protecting: the history survives.
      expect(f.memberships.byId(m.id), isNotNull);
      expect(f.memberships.byId(m.id)!.status, MembershipStatus.cancelled);
      expect(f.memberships.all(), hasLength(1));
    });

    test('no SQL, DDL or migration statement appears in the module '
        '(MM-BR-025)', () {
      final source = File(_modulePath).readAsStringSync();
      for (final banned in const [
        'CREATE TABLE',
        'ALTER TABLE',
        'DROP TABLE',
        'SELECT ',
        'INSERT INTO',
      ]) {
        expect(source.contains(banned), isFalse, reason: 'Found "$banned".');
      }
    });
  });
}
