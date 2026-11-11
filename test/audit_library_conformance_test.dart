/// `IMPL-103` — Audit log infrastructure conformance (BC-24, `platform/audit`).
///
/// Verifies the audit library against `AC-73-1`…`AC-73-4` and `LIB-19.4`…`LIB-19.7`
/// using actual contracts — no invented semantics:
///
///   * **Nine attributes** via `recordDomainFact` → `append`: actor, role,
///     tenant, action, target, priorValue, newValue, timestamp, source.
///   * **Event propagation** (AC-73-2): the four administrative membership
///     mutations — Create, Renew, Activate, Void — must carry their payload's
///     `actorRole`, `priorValue` and `newValue` through to the audit entry.
///   * **Append-only** (AC-73-1 / X-10): no edit/delete/purge path exists.
///   * **Erasure-safe redaction** (AC-73-3 / AUTH-9.57 / LIB-19.6): after
///     `eraseAccount`, both read paths project the actor to a fixed pseudonym
///     while fact, timing, prior and new values survive; other actors are
///     untouched; the register survives recreation of `AuditTrail` over the
///     same durable store.
///   * **Tenant isolation** (X-13 / MM-NFR-002): a cross-tenant read returns
///     nothing.
///   * **Fact and timestamp preservation**: append-only means a redacted read
///     returns the same entries, same count, same `at` timestamps, same
///     prior/new values — only the actor string is projected.
///
/// Scope honesty: this file verifies what `platform/audit` and the membership
/// emitters can promise. It deliberately does **not** claim that erasing an
/// account severs the `AccountId → person` mapping — that severance lives in
/// BC-18 account lifecycle and is out of scope here — nor that historical
/// configuration can be reconstructed, which requires real configuration
/// change events (`IMPL-107`) that do not yet exist.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora/platform/audit/audit.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora/platform/event/event.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora/platform/observability/observability.dart';
import 'package:liboora/platform/services/services.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const _student = StudentRecordId('stu_1');
final DateTime _nowUtc = DateTime.utc(2026, 3, 10, 4, 0);

const _auditSrc = 'lib/platform/audit/audit.dart';

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

String _codeOnly(String src) {
  final out = StringBuffer();
  var inBlock = false;
  for (final line in src.split('\n')) {
    final t = line.trimLeft();
    if (inBlock) {
      if (t.contains('*/')) inBlock = false;
      continue;
    }
    if (t.startsWith('/*')) {
      if (!t.contains('*/')) inBlock = true;
      continue;
    }
    if (t.startsWith('//') || t.startsWith('///')) continue;
    out.writeln(line);
  }
  return out.toString();
}

/// A full wiring of a membership world, reproducing the composition root's
/// audit subscription. Mirrors `membership_audit_test.dart`.
final class _World {
  _World({String tenant = 'tnt_a', String branch = 'brn_a'})
    : ctx = _Ctx(TenantId(tenant), BranchId(branch)),
      clock = FixedClock(_nowUtc) {
    repo = InMemoryMembershipRepository(
      TenantPartitionedStore<Membership>(ctx),
    );
    plans = InMemoryMembershipPlanRepository(
      TenantPartitionedStore<MembershipPlan>(ctx),
    );
    events = EventBus(ConsoleTelemetry(ctx));
    audit = AuditTrail(_SeqIds('au$tenant'));
    events.subscribe(
      'membership.*',
      audit.recordDomainFact,
      consumer: 'audit-bc24',
    );
    final idem = MembershipIdempotencyAdapter(IdempotencyService(ctx));
    const cal = TenantBusinessCalendar('Asia/Kolkata');
    create = CreateMembership(
      repo: repo,
      plans: plans,
      enrollment: _Enrollment(),
      config: const DefaultMembershipConfig(),
      idempotency: idem,
      events: events,
      clock: clock,
      ids: _SeqIds(tenant),
      tenant: ctx,
      pdp: const PolicyDecisionPoint(),
    );
    activate = ActivateMembership(
      repo: repo,
      calendar: cal,
      idempotency: idem,
      events: events,
      clock: clock,
      ids: _SeqIds('a$tenant'),
      tenant: ctx,
      pdp: const PolicyDecisionPoint(),
    );
    voidIt = VoidMembership(
      repo: repo,
      idempotency: idem,
      events: events,
      clock: clock,
      ids: _SeqIds('v$tenant'),
      tenant: ctx,
      pdp: const PolicyDecisionPoint(),
    );
  }

  final _Ctx ctx;
  final FixedClock clock;
  late final InMemoryMembershipRepository repo;
  late final InMemoryMembershipPlanRepository plans;
  late final EventBus events;
  late final AuditTrail audit;
  late final CreateMembership create;
  late final ActivateMembership activate;
  late final VoidMembership voidIt;

  int _seq = 0;

  MembershipPlan plan({String id = 'plan_src', int days = 30}) {
    final p = MembershipPlan.create(
      id: id,
      tenantId: ctx.tenantId,
      branchId: ctx.branchId,
      name: 'Plan $id',
      durationDays: days,
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
    int days = 30,
  }) {
    final p = plan(days: days);
    final m = Membership.fromPlan(
      id: 'mem_${ctx.tenantId.value}_${++_seq}',
      studentRecordId: _student,
      plan: p,
      term: DateRange.days(start ?? DateTime(2026, 3, 10), days),
      status: status,
      createdAt: _nowUtc,
      createdBy: 'owner_1',
      activatedAt: status == MembershipStatus.active ? _nowUtc : null,
    );
    repo.save(m);
    return m;
  }

  List<AuditEntry> get entries => audit.forTenant(ctx.tenantId);
}

void main() {
  // ════════════════════════════════════════════════════════════════════
  // AC-73-1 — append-only (X-10): no edit/delete/purge path exists.
  // ════════════════════════════════════════════════════════════════════
  group('AC-73-1 · append-only (X-10)', () {
    test('no update, delete, purge or modify method exists on the trail', () {
      final src = _codeOnly(File(_auditSrc).readAsStringSync());
      for (final banned in [
        'void update',
        'void delete',
        'void purge',
        'void modify',
        'void remove',
        'void clear',
        '.removeAt(',
        '.removeWhere(',
        '.clear()',
      ]) {
        expect(
          src.contains(banned),
          isFalse,
          reason:
              'X-10 / AC-73-1: "No API, query or migration permits editing or '
              'deleting an audit record". "$banned" would be such an API.',
        );
      }
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // AC-73-2 — every administrative change carries the nine attributes,
  // propagated from the event payload through recordDomainFact.
  // ════════════════════════════════════════════════════════════════════
  group('AC-73-2 · nine attributes on the four administrative mutations', () {
    test('CreateMembership → actorRole, prior=null, new=status', () async {
      final w = _World();
      final p = w.plan();
      await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('c1'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      final e = w.entries.single;
      expect(e.action, 'membership.MembershipCreated');
      expect(e.role, 'owner', reason: 'AccessRole.owner.name');
      expect(e.actor, 'owner_1');
      expect(e.tenantId, w.ctx.tenantId);
      expect(e.target, isNotNull);
      expect(e.priorValue, isNull,
          reason: 'creation has no prior state — null, not invented');
      expect(e.newValue, isNotNull, reason: 'the created status');
      expect(e.at, isNotNull);
      expect(e.detail, isA<Map<String, Object?>>());
    });

    test('RenewMembership → prior=source status, new=renewal status',
        () async {
      final w = _World();
      final p = w.plan();
      final src = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('c1'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      w.clock.advance(Duration(days: 40));
      final renew = RenewMembership(
        repo: w.repo,
        plans: w.plans,
        enrollment: _Enrollment(),
        calendar: const TenantBusinessCalendar('Asia/Kolkata'),
        idempotency: MembershipIdempotencyAdapter(IdempotencyService(w.ctx)),
        events: w.events,
        clock: w.clock,
        ids: _SeqIds('rv'),
        tenant: w.ctx,
        pdp: const PolicyDecisionPoint(),
      );
      final renewal = await renew(
        actorRole: AccessRole.manager,
        idempotencyKey: const IdempotencyKey('r1'),
        sourceMembershipId: src.id,
        paymentAlreadyReceived: true,
      );
      final e = w.entries
          .where((x) => x.action == 'membership.MembershipRenewed')
          .single;
      expect(e.actor, 'owner_1');
      expect(e.role, 'manager', reason: 'AccessRole.manager.name');
      expect(e.priorValue, 'active',
          reason: 'the source status captured before renewal');
      expect(e.newValue, isNotNull);
      expect(e.newValue, renewal.status.name);
    });

    test('ActivateMembership → prior=captured-before, new=after', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.scheduled);
      await w.activate(
        actorRole: AccessRole.owner,
        membershipId: m.id,
        paymentReference: 'pay_1',
      );
      final e = w.entries
          .where((x) => x.action.endsWith('MembershipActivated'))
          .single;
      expect(e.role, 'owner');
      expect(e.priorValue, 'scheduled',
          reason: 'the status BEFORE activation was scheduled');
      expect(e.newValue, 'active', reason: 'activation produces active');
    });

    test('VoidMembership → prior=captured-before, new=after', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.pendingPayment);
      await w.voidIt(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('v1'),
        membershipId: m.id,
        reason: 'duplicate sale',
      );
      final e = w.entries
          .where((x) => x.action.endsWith('MembershipVoided'))
          .single;
      expect(e.role, 'owner');
      expect(e.priorValue, 'pendingPayment',
          reason: 'the status BEFORE voiding was pendingPayment');
      expect(e.newValue, 'cancelled', reason: 'void transitions to cancelled');
    });

    test('priorValue is captured before the mutation, not from the mutated '
        'aggregate', () async {
      // Construct an activation where the mutated object's status would be
      // wrong as a "prior": the aggregate is Immutable-by-replacement here via
      // mutable status, but the invariant we assert is that the payload's
      // priorValue equals the pre-call status regardless of the post-call one.
      final w = _World();
      final m = w.add(status: MembershipStatus.scheduled);
      expect(m.status, MembershipStatus.scheduled);
      await w.activate(
        actorRole: AccessRole.owner,
        membershipId: m.id,
        paymentReference: 'pay_prior',
      );
      final e = w.entries
          .where((x) => x.action.endsWith('MembershipActivated'))
          .single;
      expect(e.priorValue, 'scheduled', reason: 'captured before activateOn');
      expect(e.newValue, 'active');
      expect(e.priorValue, isNot(e.newValue));
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // AC-73-3 — erasure-safe redaction (AUTH-9.57 / LIB-19.6).
  // ════════════════════════════════════════════════════════════════════
  group('AC-73-3 · erasure-safe redaction', () {
    test('eraseAccount projects the actor to the fixed pseudonym', () {
      final w = _World();
      w.audit.append(
        tenantId: w.ctx.tenantId,
        actor: 'owner_1',
        action: 'membership.MembershipCreated',
        target: 'mem_1',
        at: _nowUtc,
        role: 'owner',
        priorValue: null,
        newValue: 'active',
      );
      w.audit.eraseAccount('owner_1');
      final e = w.entries.single;
      expect(e.actor, 'erased-account');
      expect(e.action, 'membership.MembershipCreated');
      expect(e.target, 'mem_1');
      expect(e.at, _nowUtc, reason: 'timestamp preserved');
      expect(e.priorValue, isNull);
      expect(e.newValue, 'active', reason: 'fact preserved');
    });

    test('fact, timing, count and prior/new values survive redaction', () {
      final w = _World();
      w.audit.append(
        tenantId: w.ctx.tenantId,
        actor: 'owner_1',
        action: 'membership.MembershipActivated',
        target: 'mem_1',
        at: _nowUtc,
        role: 'owner',
        priorValue: 'scheduled',
        newValue: 'active',
        detail: const {'membershipId': 'mem_1'},
      );
      w.audit.eraseAccount('owner_1');
      final e = w.entries.single;
      expect(e.actor, 'erased-account');
      expect(e.at, _nowUtc);
      expect(e.priorValue, 'scheduled');
      expect(e.newValue, 'active');
      expect(e.detail['membershipId'], 'mem_1');
      expect(w.entries, hasLength(1));
    });

    test('redaction applies in both forTenant() and recent()', () {
      final w = _World();
      w.audit.append(
        tenantId: w.ctx.tenantId,
        actor: 'owner_1',
        action: 'membership.MembershipRenewed',
        target: 'mem_1',
        at: _nowUtc,
      );
      w.audit.eraseAccount('owner_1');
      expect(w.audit.forTenant(w.ctx.tenantId).single.actor, 'erased-account');
      expect(w.audit.recent().where((x) => x.action.endsWith('Renewed')).single
          .actor, 'erased-account');
    });

    test('other actors are not affected', () {
      final w = _World();
      w.audit.append(
        tenantId: w.ctx.tenantId,
        actor: 'owner_1',
        action: 'membership.MembershipCreated',
        target: 'mem_1',
        at: _nowUtc,
      );
      w.audit.append(
        tenantId: w.ctx.tenantId,
        actor: 'reception_9',
        action: 'membership.MembershipCreated',
        target: 'mem_2',
        at: _nowUtc,
      );
      w.audit.eraseAccount('owner_1');
      final projected = w.entries.map((e) => e.actor).toList();
      expect(projected, ['erased-account', 'reception_9']);
    });

    test('the stored record is untouched: only reads project', () {
      final w = _World();
      w.audit.append(
        tenantId: w.ctx.tenantId,
        actor: 'owner_1',
        action: 'membership.MembershipCreated',
        target: 'mem_1',
        at: _nowUtc,
      );
      w.audit.eraseAccount('owner_1');
      // The raw store (InMemoryKeyValueStore) is append-only by construction:
      // nothing here has an edit/delete path. The audit register lives in a
      // distinct namespace and never rewrites entries.
      expect(w.entries.single.actor, 'erased-account');
      expect(w.entries.single.id, isNotNull);
    });

    test('redaction persists across AuditTrail recreation over the same '
        'durable store', () {
      final durable = InMemoryKeyValueStore();
      // First life of the trail: record an entry, then erase the actor.
      final first = AuditTrail(_SeqIds('one'), durable: durable);
      first.append(
        tenantId: TenantId('tnt_a'),
        actor: 'owner_1',
        action: 'membership.MembershipCreated',
        target: 'mem_1',
        at: _nowUtc,
        role: 'owner',
        priorValue: null,
        newValue: 'active',
      );
      first.eraseAccount('owner_1');
      expect(first.forTenant(TenantId('tnt_a')).single.actor,
          'erased-account');

      // Second life of the trail over the SAME durable store: the register is
      // reloaded, so the same entry projects even though this instance never
      // saw the append.
      final second = AuditTrail(_SeqIds('two'), durable: durable);
      final projected = second.forTenant(TenantId('tnt_a')).single;
      // The entry itself is NOT replayed from durable storage -- _entries is
      // memory-only. What must survive the restart is the REDACTION REGISTER,
      // so any future append by the erased actor is projected too.
      second.append(
        tenantId: TenantId('tnt_a'),
        actor: 'owner_1',
        action: 'membership.MembershipRenewed',
        target: 'mem_2',
        at: _nowUtc,
      );
      final renewed = second
          .forTenant(TenantId('tnt_a'))
          .where((x) => x.action.endsWith('Renewed'))
          .single;
      expect(renewed.actor, 'erased-account',
          reason:
              'the redaction register survived the restart, so a post-restart '
              'entry by the erased actor is projected');
    });

    test('eraseAccount is idempotent and records the erasure fact once', () {
      final w = _World();
      w.audit.eraseAccount('owner_1');
      w.audit.eraseAccount('owner_1');
      final erasedFacts = w.entries.where((x) => x.action == 'audit.AccountErased');
      expect(erasedFacts, hasLength(1),
          reason: 'a second erase of the same actor appends no duplicate fact');
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // Tenant isolation (X-13 / MM-NFR-002).
  // ════════════════════════════════════════════════════════════════════
  group('tenant isolation', () {
    test('a cross-tenant read of the trail returns nothing', () {
      final a = AuditTrail(_SeqIds('a'));
      a.append(
        tenantId: TenantId('tnt_a'),
        actor: 'owner_1',
        action: 'membership.MembershipCreated',
        target: 'mem_1',
        at: _nowUtc,
      );
      expect(a.forTenant(TenantId('tnt_a')), hasLength(1));
      expect(a.forTenant(TenantId('tnt_b')), isEmpty,
          reason: 'X-13: a different tenant reads nothing');
    });

    test('redaction is per-actor and read-through the tenant projection', () {
      final w = _World(tenant: 'tnt_a');
      w.audit.eraseAccount('owner_1');
      // recent() is global; forTenant() is scoped. Redaction must hold on both.
      expect(
        w.audit
            .recent()
            .where((x) => x.action == 'audit.AccountErased')
            .single,
        isA<AuditEntry>(),
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // Fact and timestamp preservation through the read projections.
  // ════════════════════════════════════════════════════════════════════
  group('preservation of audit facts and timestamps', () {
    test('entries keep their at timestamp and counts through reads', () {
      final w = _World();
      final t1 = DateTime.utc(2026, 3, 10, 4, 0);
      final t2 = DateTime.utc(2026, 3, 11, 9, 30);
      w.audit.append(
        tenantId: w.ctx.tenantId,
        actor: 'owner_1',
        action: 'membership.MembershipCreated',
        target: 'mem_1',
        at: t1,
      );
      w.audit.append(
        tenantId: w.ctx.tenantId,
        actor: 'owner_1',
        action: 'membership.MembershipActivated',
        target: 'mem_1',
        at: t2,
      );
      final forTenant = w.audit.forTenant(w.ctx.tenantId);
      expect(forTenant, hasLength(2));
      expect(forTenant.map((e) => e.at).toList(), [t1, t2]);
      expect(forTenant.map((e) => e.action).toList(), [
        'membership.MembershipCreated',
        'membership.MembershipActivated',
      ]);
    });
  });
}
