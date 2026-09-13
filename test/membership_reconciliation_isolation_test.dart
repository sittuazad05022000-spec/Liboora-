/// `BC-02` Membership — failure handling, the reconciliation queue, and
/// tenant/branch isolation.
///
/// Covers `IMPL-416` (creation and activation failure handling — deterministic
/// outcomes, `MM-BR-004`'s visible reconciliation queue) and `IMPL-435`
/// (tenant isolation made structurally impossible to omit) against FROZEN
/// `PRD-005` v1.4.
///
/// `MM-NFR-005` gets particular attention because it is the rule most easily
/// got wrong in a way no user would notice: an identifier from another tenant
/// **MUST** produce a *not found*, never a *forbidden*, so existence cannot be
/// probed across tenants. "Forbidden" leaks the fact that the id is real.
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

const _student = StudentRecordId('stu_1');
final DateTime _nowUtc = DateTime.utc(2026, 3, 10, 4, 0);

final class _Ctx implements TenantContext {
  _Ctx(this._t, this._b);
  final TenantId _t;
  final BranchId _b;
  @override
  TenantId get tenantId => _t;
  @override
  BranchId get branchId => _b;
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
  _SeqIds(this._prefix);
  final String _prefix;
  int _n = 0;
  @override
  String next([String prefix = 'id']) => '${prefix}_${_prefix}_${++_n}';
}

final class _World {
  _World({
    String tenant = 'tnt_a',
    String branch = 'brn_a',
    MembershipConfig config = const DefaultMembershipConfig(),
  }) : ctx = _Ctx(TenantId(tenant), BranchId(branch)),
       clock = FixedClock(_nowUtc),
       cfg = config {
    repo = InMemoryMembershipRepository(
      TenantPartitionedStore<Membership>(ctx),
    );
    plans = InMemoryMembershipPlanRepository(
      TenantPartitionedStore<MembershipPlan>(ctx),
    );
    events = EventBus(ConsoleTelemetry(ctx));
    create = CreateMembership(
      repo: repo,
      plans: plans,
      enrollment: _Enrollment(),
      config: cfg,
      idempotency: MembershipIdempotencyAdapter(IdempotencyService(ctx)),
      events: events,
      clock: clock,
      ids: _SeqIds(tenant),
      tenant: ctx,
      pdp: const PolicyDecisionPoint(),
    );
    renew = RenewMembership(
      repo: repo,
      plans: plans,
      enrollment: _Enrollment(),
      calendar: const TenantBusinessCalendar('Asia/Kolkata'),
      idempotency: MembershipIdempotencyAdapter(IdempotencyService(ctx)),
      events: events,
      clock: clock,
      ids: _SeqIds('r$tenant'),
      tenant: ctx,
      pdp: const PolicyDecisionPoint(),
    );
    queue = MembershipReconciliation(
      repo: repo,
      calendar: const TenantBusinessCalendar('Asia/Kolkata'),
      config: cfg,
      clock: clock,
    );
  }

  final _Ctx ctx;
  final FixedClock clock;
  final MembershipConfig cfg;
  late final InMemoryMembershipRepository repo;
  late final InMemoryMembershipPlanRepository plans;
  late final EventBus events;
  late final CreateMembership create;
  late final RenewMembership renew;
  late final MembershipReconciliation queue;

  int _seq = 0;

  MembershipPlan plan({String id = 'plan_1', String branch = 'brn_a'}) {
    final p = MembershipPlan.create(
      id: id,
      tenantId: ctx.tenantId,
      branchId: BranchId(branch),
      name: 'Plan $id',
      durationDays: 30,
      price: Money.rupees(1200),
      createdAt: DateTime(2026, 1, 1),
      createdBy: 'owner_1',
      seatQuota: 1,
    );
    plans.save(p);
    return p;
  }

  Membership add({
    required MembershipStatus status,
    DateTime? start,
    String branch = 'brn_a',
    StudentRecordId student = _student,
    DateTime? createdAt,
  }) {
    final p = plan(id: 'plan_$branch', branch: branch);
    final m = Membership.fromPlan(
      id: 'mem_${ctx.tenantId.value}_${++_seq}',
      studentRecordId: student,
      plan: p,
      term: DateRange.days(start ?? DateTime(2026, 3, 1), 30),
      status: status,
      createdAt: createdAt ?? _nowUtc,
      createdBy: 'owner_1',
      activatedAt: status == MembershipStatus.active ? _nowUtc : null,
    );
    repo.save(m);
    return m;
  }

  Future<Membership> sell({MembershipPlan? onPlan, bool paid = true}) => create(
    actorRole: AccessRole.owner,
    idempotencyKey: IdempotencyKey('idem_${++_seq}'),
    studentId: _student,
    plan: onPlan ?? plan(),
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
  // IMPL-416 — MM-FR-050: no partial state
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-050 no partial state on failure', () {
    test('a refused creation leaves no row, no event, and no idempotency '
        'record that would make a retry lie', () async {
      final w = _World();
      final retired = w.plan().deactivate();
      w.plans.save(retired);

      await _rejects(() => w.sell(onPlan: retired));

      expect(w.repo.all(), isEmpty);
      expect(w.events.log, isEmpty);

      // And a retry with a valid plan still works -- the failed attempt did
      // not burn the student's slot or poison anything.
      final ok = await w.sell();
      expect(ok.id, isNotNull);
    });

    test(
      'every failure path yields a TYPED error, never a bare throw',
      () async {
        final w = _World();

        // Deactivated plan.
        final retired = w.plan(id: 'p_off').deactivate();
        w.plans.save(retired);
        expect(
          (await _rejects(() => w.sell(onPlan: retired))).code,
          DomainErrorCode.validationFailed,
        );

        // Out-of-window start date.
        final w2 = _World();
        final e2 = await _rejects(
          () => w2.create(
            actorRole: AccessRole.owner,
            idempotencyKey: const IdempotencyKey('k'),
            studentId: _student,
            plan: w2.plan(),
            startingOn: DateTime(2026, 1, 1),
            paymentAlreadyReceived: true,
          ),
        );
        expect(e2.code, DomainErrorCode.validationFailed);
        expect(e2.context['field'], 'startDate');

        // Overlap.
        final w3 = _World();
        final p = w3.plan();
        await w3.sell(onPlan: p);
        expect(
          (await _rejects(() => w3.sell(onPlan: p))).code,
          DomainErrorCode.overlappingMembershipTerm,
        );
      },
    );

    test('a failed renewal writes nothing and leaves the source alone '
        '(MM-FR-091)', () async {
      final w = _World();
      final src = w.add(status: MembershipStatus.cancelled);

      await _rejects(
        () => w.renew(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('k'),
          sourceMembershipId: src.id,
        ),
      );

      expect(w.repo.all(), hasLength(1));
      expect(w.repo.byId(src.id)!.status, MembershipStatus.cancelled);
      expect(w.events.log, isEmpty);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-416 — MM-BR-004: the visible reconciliation queue
  // ════════════════════════════════════════════════════════════════════
  group('MM-BR-004 reconciliation queue', () {
    test('a healthy world produces an empty queue', () async {
      final w = _World();
      await w.sell();
      expect(w.queue.items(), isEmpty);
    });

    test('a PendingPayment membership past MM-CFG-007 is queued', () {
      final w = _World();
      w.add(
        status: MembershipStatus.pendingPayment,
        // Created 30 days ago; the void window is 7.
        createdAt: _nowUtc.subtract(const Duration(days: 30)),
      );

      final items = w.queue.items();
      expect(items, hasLength(1));
      expect(items.single.reason, ReconciliationReason.pendingPaymentExpired);
      expect(
        items.single.detail,
        contains('7 days'),
        reason:
            'The queue is VISIBLE (MM-BR-004), so the entry has to say why '
            'in words a reception desk can act on.',
      );
    });

    test('a PendingPayment membership inside the window is NOT queued', () {
      final w = _World();
      w.add(
        status: MembershipStatus.pendingPayment,
        createdAt: _nowUtc.subtract(const Duration(days: 3)),
      );
      expect(w.queue.items(), isEmpty);
    });

    test('an Active membership whose term elapsed but which the sweep has not '
        'materialised is queued (MM-FR-107)', () {
      final w = _World();
      // Term ran 1-30 January; today is 10 March; status still Active.
      w.add(status: MembershipStatus.active, start: DateTime(2026, 1, 1));

      final items = w.queue.items();
      expect(items, hasLength(1));
      expect(
        items.single.reason,
        ReconciliationReason.expiredButNotMaterialised,
      );
      expect(
        items.single.detail,
        contains('Validity already reports false'),
        reason:
            'The disagreement is the ROW being out of step, not validity '
            'being wrong -- MM-FR-107 already guarantees the read.',
      );
    });

    test('a Scheduled membership whose startDate has passed is queued', () {
      final w = _World();
      // Started 1 March, still Scheduled, today is the 10th.
      w.add(status: MembershipStatus.scheduled, start: DateTime(2026, 3, 1));

      final items = w.queue.items();
      expect(items, hasLength(1));
      expect(
        items.single.reason,
        ReconciliationReason.scheduledButNotActivated,
      );
    });

    test(
      'a Scheduled membership whose startDate is still ahead is NOT queued',
      () {
        final w = _World();
        w.add(status: MembershipStatus.scheduled, start: DateTime(2026, 4, 1));
        expect(w.queue.items(), isEmpty);
      },
    );

    test('terminal memberships are never queued', () {
      final w = _World();
      for (final status in MembershipStatus.values.where((s) => s.isTerminal)) {
        w.add(status: status, start: DateTime(2026, 1, 1));
      }
      expect(
        w.queue.items(),
        isEmpty,
        reason:
            'A retired membership cannot disagree with anything; MM-BR-024 '
            'makes terminal states the retirement path.',
      );
    });

    test('the queue is DERIVED, so fixing the membership clears the entry '
        'with no second write', () {
      final w = _World();
      final m = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 1, 1),
      );
      expect(w.queue.items(), hasLength(1));

      m.expire();
      w.repo.save(m);

      expect(
        w.queue.items(),
        isEmpty,
        reason:
            'A stored queue table would still hold the stale entry. '
            'Deriving it means it cannot disagree with the rows it '
            'describes.',
      );
    });

    test('the queue reads no ledger and no balance (MM-BR-001)', () {
      final w = _World();
      w.add(
        status: MembershipStatus.pendingPayment,
        createdAt: _nowUtc.subtract(const Duration(days: 30)),
      );
      // Every entry is derived from status, term and createdAt -- all BC-02's
      // own fields. "Paid but not active" in the MONEY sense is BC-05's half
      // of the same queue, because MM-BR-001 forbids a balance here.
      expect(w.queue.items().single.membership.priceSnapshot, isA<Money>());
      expect(w.queue.items(), hasLength(1));
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-435 — MM-NFR-003/004/005: isolation
  // ════════════════════════════════════════════════════════════════════
  group('MM-NFR-003 cross-tenant access is impossible', () {
    test('two tenants using identical ids never see each other', () async {
      final a = _World(tenant: 'tnt_a');
      final b = _World(tenant: 'tnt_b');

      await a.sell();
      await b.sell();

      expect(a.repo.all(), hasLength(1));
      expect(b.repo.all(), hasLength(1));
      expect(
        a.repo.all().single.id,
        isNot(b.repo.all().single.id),
        reason: 'Different id generators, but the isolation is the store\'s.',
      );
    });

    test('an identifier from another tenant produces NOT FOUND, never '
        'FORBIDDEN (MM-NFR-005)', () async {
      final a = _World(tenant: 'tnt_a');
      final b = _World(tenant: 'tnt_b');
      final theirs = await b.sell();

      // Direct read.
      expect(a.repo.byId(theirs.id), isNull, reason: 'Absent, not refused.');

      // And through a use case, where the error CODE is the observable.
      final e = await _rejects(
        () => a.renew(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('k'),
          sourceMembershipId: theirs.id,
        ),
      );
      expect(
        e.code,
        DomainErrorCode.notFound,
        reason:
            'MM-NFR-005: a "forbidden" would confirm the id is real, '
            'letting an attacker probe existence across tenants one id at '
            'a time.',
      );
    });

    test(
      'the not-found error carries no evidence the id exists elsewhere',
      () async {
        final a = _World(tenant: 'tnt_a');
        final b = _World(tenant: 'tnt_b');
        final theirs = await b.sell();

        final e = await _rejects(
          () => a.renew(
            actorRole: AccessRole.owner,
            idempotencyKey: const IdempotencyKey('k'),
            sourceMembershipId: theirs.id,
          ),
        );
        expect(e.message.toLowerCase(), isNot(contains('tnt_b')));
        expect(e.message.toLowerCase(), isNot(contains('forbidden')));
        expect(e.message.toLowerCase(), isNot(contains('permission')));
      },
    );

    test('the reconciliation queue is tenant-scoped (MM-NFR-003)', () {
      final a = _World(tenant: 'tnt_a');
      final b = _World(tenant: 'tnt_b');

      b.add(status: MembershipStatus.active, start: DateTime(2026, 1, 1));

      expect(
        a.queue.items(),
        isEmpty,
        reason: 'Tenant A must not see tenant B\'s problems.',
      );
      expect(b.queue.items(), hasLength(1));
    });

    test('a store with no tenant in scope refuses to answer rather than '
        'answering globally', () {
      // The partitioned store throws when unscoped -- so omitting the
      // tenant predicate is not a silent full-table read. This is the
      // MM-NFR-003 "impossible, not merely denied" property.
      expect(
        () => TenantPartitionedStore<Membership>(_Unscoped()).all(),
        throwsA(isA<TenantContextMissing>()),
      );
    });
  });

  group('MM-NFR-004 branch scoping', () {
    test(
      'a membership carries its own branchId, snapshotted from the plan',
      () {
        final w = _World();
        final m = w.add(status: MembershipStatus.active, branch: 'brn_north');
        expect(m.branchId, const BranchId('brn_north'));
      },
    );

    test('branch-level read filtering is supported (MM-NFR-004)', () {
      final w = _World();
      w.add(
        status: MembershipStatus.active,
        branch: 'brn_north',
        student: const StudentRecordId('s1'),
      );
      w.add(
        status: MembershipStatus.active,
        branch: 'brn_south',
        student: const StudentRecordId('s2'),
      );
      w.add(
        status: MembershipStatus.active,
        branch: 'brn_north',
        student: const StudentRecordId('s3'),
      );

      expect(w.repo.forBranch(const BranchId('brn_north')), hasLength(2));
      expect(w.repo.forBranch(const BranchId('brn_south')), hasLength(1));
      expect(w.repo.forBranch(const BranchId('brn_nowhere')), isEmpty);
      // Required "even though multi-branch is V3" (MP-CON-13) -- so it exists
      // and is tested now, rather than being retrofitted when its absence
      // would already be a cross-branch leak.
    });

    test('the branch is snapshotted, so withdrawing the plan does not orphan '
        'the membership\'s branch (MM-FR-020)', () {
      final w = _World();
      final m = w.add(status: MembershipStatus.active, branch: 'brn_north');

      // The plan is withdrawn from the catalogue entirely.
      final gone = w.plans.byId('plan_brn_north')!.deactivate();
      w.plans.save(gone);

      expect(
        m.branchId,
        const BranchId('brn_north'),
        reason:
            'Reading branch through planId would make it unanswerable for '
            'a membership whose plan has been withdrawn.',
      );
      expect(w.repo.forBranch(const BranchId('brn_north')), hasLength(1));
    });
  });
}

final class _Unscoped implements TenantContext {
  @override
  TenantId get tenantId => throw const TenantContextMissing();
  @override
  BranchId get branchId => throw const TenantContextMissing();
  @override
  String? get actorId => null;
  @override
  bool get hasTenant => false;
  @override
  String get correlationId => 'corr_unscoped';
}
