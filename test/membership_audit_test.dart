/// `BC-02` Membership — audit through `E-20`.
///
/// Covers `IMPL-438` (audit, fire-and-forget and outbox-backed) against
/// FROZEN `PRD-005` v1.4 §17 and BC Map `E-20`.
///
/// The three obligations in the task row are structural, not behavioural, and
/// are tested as such:
///
///   * **Append-only** (`X-10`) — no update, delete, purge or modify method
///     exists on the store. Tested by scanning for one.
///   * **Never synchronous** — the domain holds no audit reference to call.
///     Tested by scanning `domain/library` for an import.
///   * **No PII in any audit payload** — tested by feeding one through.
///
/// §17 also forbids this module from storing an audit log at all, which is
/// why the trail lives in `platform/audit` and the domain only emits facts.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
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

const _prdPath =
    'docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md';
const _bcMapPath = 'docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md';
const _auditSrc = 'lib/platform/audit/audit.dart';
const _membershipSrc = 'lib/domain/library/membership/membership.dart';

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
    // The composition root's wiring, reproduced: audit subscribes on the
    // bus, so the domain never holds a reference to call.
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
    expire = ExpireDueMemberships(
      repo: repo,
      calendar: cal,
      config: const DefaultMembershipConfig(),
      events: events,
      clock: clock,
      ids: _SeqIds('x$tenant'),
      tenant: ctx,
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
  late final ExpireDueMemberships expire;

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
  // IMPL-438 — append-only, by construction (X-10).
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-438 · the trail is append-only (X-10)', () {
    test('no update, delete, purge or modify method exists', () {
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
              'X-10 / MP-GBR-13: the trail is "append-only with no update or '
              'delete path in code". "$banned" would be such a path, and '
              'AU-1 states it as an assertion: "no public mutation method '
              'exists on the audit store".',
        );
      }
    });

    test('append is the only mutation, and a correction is a new entry', () {
      final w = _World();
      w.audit.append(
        tenantId: w.ctx.tenantId,
        actor: 'owner_1',
        action: 'membership.Corrected',
        target: 'mem_1',
      );
      w.audit.append(
        tenantId: w.ctx.tenantId,
        actor: 'owner_1',
        action: 'membership.CorrectedAgain',
        target: 'mem_1',
      );
      expect(
        w.entries,
        hasLength(2),
        reason:
            'a correction is a NEW entry, never an edit of the first — which '
            'is why the count grows rather than the content changing',
      );
    });

    test('the manifest still declares the banned method names', () {
      final yaml = File('tool/module_dependencies.yaml').readAsStringSync();
      // The section runs to the next top-level key, not to a fixed byte
      // count -- a fixed window silently stops testing the moment the
      // section grows past it.
      final idx = yaml.indexOf('\nplatform/audit:');
      expect(idx, greaterThan(-1));
      final rest = yaml.substring(idx + 1);
      final nextKey = RegExp(r'\n(?=\S)').firstMatch(rest.substring(1));
      final section = nextKey == null
          ? rest
          : rest.substring(0, nextKey.start + 1);
      expect(
        section.contains('banned_method_names'),
        isTrue,
        reason:
            'the checker enforces X-10 mechanically; if this declaration is '
            'removed the test above becomes the only guard',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-438 — never synchronous (BC Map E-20).
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-438 · audit is never called synchronously (E-20)', () {
    test('the domain module does not import platform/audit', () {
      final src = File(_membershipSrc).readAsStringSync();
      expect(
        src.contains("import '../../../platform/audit/audit.dart'") ||
            src.contains('platform/audit/audit.dart'),
        isFalse,
        reason:
            'BC Map E-20: "Domain never calls audit synchronously." The '
            'strongest form of that is having no reference to call — so the '
            'subscription is wired in the composition root instead.',
      );
    });

    test('the domain names no audit type or method', () {
      final src = _codeOnly(File(_membershipSrc).readAsStringSync());
      for (final banned in [
        'AuditTrail',
        'AuditEntry',
        'audit.append',
        'recordDomainFact',
      ]) {
        expect(
          src.contains(banned),
          isFalse,
          reason:
              '§17: this module "MUST NOT call audit synchronously and MUST '
              'NOT store an audit log". "$banned" in the domain would be one '
              'or the other.',
        );
      }
    });

    test(
      'audit arrives via the bus, after the emitter has committed',
      () async {
        final w = _World();
        final p = w.plan();
        final m = await w.create(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('c1'),
          studentId: _student,
          plan: p,
          startingOn: DateTime(2026, 3, 10),
          paymentAlreadyReceived: true,
        );
        // The membership is committed AND the audit entry exists, but the
        // ordering is guaranteed one way: the write happened first, and audit
        // was delivered during drain.
        expect(w.repo.byId(m.id), isNotNull);
        expect(w.entries, hasLength(1));
        expect(w.entries.single.action, 'membership.MembershipCreated');
      },
    );

    test('a failing audit consumer does not fail the domain call', () async {
      final w = _World();
      w.events.subscribe(
        'membership.*',
        (e) => throw StateError('audit store is down'),
        consumer: 'audit-broken',
      );
      final p = w.plan();
      // AU-3: "unavailability of this platform delays audit visibility only".
      // The sale must still complete -- refusing to sell a membership because
      // the audit store is down would be the wrong trade at a reception desk.
      final m = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('c1'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      expect(w.repo.byId(m.id), isNotNull);
      expect(
        w.events.deadLetter,
        hasLength(1),
        reason: 'the failure is visible in the DLQ, not silently dropped',
      );
      expect(
        w.entries,
        hasLength(1),
        reason: 'the healthy audit consumer still recorded it',
      );
    });

    test('BC Map still declares E-20 as fire-and-forget, outbox-backed', () {
      final text = File(_bcMapPath).readAsStringSync();
      expect(
        text.contains('Event (fire-and-forget, outbox-backed)'),
        isTrue,
        reason: 'the transport requirement this test enforces must still hold',
      );
      expect(text.contains('Domain never calls audit synchronously'), isTrue);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-438 — no PII in any audit payload (MM-NFR-009).
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-438 · no PII in any audit payload (MM-NFR-009)', () {
    test('a forbidden key is stripped from the detail', () {
      final w = _World();
      w.audit.recordDomainFact(
        DomainEvent(
          eventId: 'ev_1',
          eventType: 'membership.MembershipCreated',
          tenantId: w.ctx.tenantId,
          aggregateId: 'mem_1',
          occurredAt: _nowUtc,
          payload: const {
            'membershipId': 'mem_1',
            'studentRecordId': 'stu_1',
            'fullName': 'A Student',
            'mobileNumber': '9876543210',
          },
        ),
      );
      final detail = w.entries.single.detail;
      expect(detail.containsKey('fullName'), isFalse);
      expect(detail.containsKey('mobileNumber'), isFalse);
      expect(
        detail['membershipId'],
        'mem_1',
        reason:
            'the commercial fields survive — §16.4 says this module\'s '
            'sensitive data is commercial, "not personal"',
      );
    });

    test('the audit deny-list is a superset of the bus deny-list', () {
      expect(
        kForbiddenAuditDetailKeys.containsAll(kForbiddenEventPayloadKeys),
        isTrue,
        reason:
            'audit is append-only, so a leak here is permanent in a way a '
            'leak on the bus is not — there is no delete path to clean it '
            'up with. The audit list may be stricter; it must never be '
            'laxer.',
      );
    });

    test('no real membership audit entry carries a forbidden key', () async {
      final w = _World();
      final p = w.plan();
      final m = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('c1'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: false,
      );
      await w.activate(
        actorRole: AccessRole.owner,
        membershipId: m.id,
        paymentReference: 'pay_1',
      );
      expect(w.entries, isNotEmpty);
      for (final e in w.entries) {
        for (final key in e.detail.keys) {
          expect(
            kForbiddenAuditDetailKeys.contains(key),
            isFalse,
            reason: '${e.action} recorded forbidden key "$key"',
          );
        }
      }
    });

    test('§17 still restates the no-PII rule', () {
      final text = File(_prdPath).readAsStringSync();
      expect(
        text.contains(
          'audit records carry no mobile number, name or other `BC-10` field',
        ),
        isTrue,
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-438 — §17's normative mutations table.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-438 · §17 — the audited mutations', () {
    test('membership create records actor, plan, term and status', () async {
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
      expect(e.actor, 'owner_1');
      expect(e.detail['planId'], p.id);
      expect(e.detail['studentRecordId'], _student.value);
      expect(e.detail['status'], isNotNull);
    });

    test('activation records the resulting term', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.scheduled);
      await w.activate(
        actorRole: AccessRole.owner,
        membershipId: m.id,
        paymentReference: 'pay_ref_9',
      );
      final e = w.entries
          .where((x) => x.action.endsWith('MembershipActivated'))
          .single;
      expect(e.detail['validUntil'], isNotNull);
      expect(e.detail['activatedAt'], isNotNull);
    });

    test(
      'manual activation records that the payment gate was bypassed',
      () async {
        final w = _World();
        final m = w.add(status: MembershipStatus.pendingPayment);
        await w.activate(
          actorRole: AccessRole.owner,
          membershipId: m.id,
          paymentReference: 'manual_1',
          manuallyAuthorised: true,
        );
        final e = w.entries
            .where((x) => x.action.endsWith('MembershipActivated'))
            .single;
        expect(
          e.detail['activationReason'],
          'manual_authorisation',
          reason:
              '§17 marks MM-PO-004 manual activation "Yes — elevated" and '
              'requires "the fact that the payment gate was bypassed". An '
              'audit that cannot distinguish it from a real payment cannot '
              'support that review.',
        );
      },
    );

    test('void records the reason and the actor', () async {
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
      expect(e.detail['reason'], 'duplicate sale');
      expect(e.actor, 'owner_1');
    });

    test('the expiry job is NOT recorded as a human actor', () async {
      final w = _World();
      // A scheduled job carries no ambient actor.
      final jobCtx = _JobCtx(w.ctx.tenantId, w.ctx.branchId);
      final jobEvents = EventBus(ConsoleTelemetry(jobCtx));
      final jobAudit = AuditTrail(_SeqIds('job'));
      jobEvents.subscribe(
        'membership.*',
        jobAudit.recordDomainFact,
        consumer: 'audit-bc24',
      );
      final repo = InMemoryMembershipRepository(
        TenantPartitionedStore<Membership>(jobCtx),
      );
      final plans = InMemoryMembershipPlanRepository(
        TenantPartitionedStore<MembershipPlan>(jobCtx),
      );
      final p = MembershipPlan.create(
        id: 'plan_j',
        tenantId: jobCtx.tenantId,
        branchId: jobCtx.branchId,
        name: 'Plan J',
        durationDays: 10,
        price: Money.rupees(1200),
        createdAt: DateTime(2026, 1, 1),
        createdBy: 'owner_1',
        seatQuota: 1,
      );
      plans.save(p);
      repo.save(
        Membership.fromPlan(
          id: 'mem_j1',
          studentRecordId: _student,
          plan: p,
          term: DateRange.days(DateTime(2026, 2, 1), 10),
          status: MembershipStatus.active,
          createdAt: _nowUtc,
          createdBy: 'owner_1',
          activatedAt: _nowUtc,
        ),
      );
      await ExpireDueMemberships(
        repo: repo,
        calendar: const TenantBusinessCalendar('Asia/Kolkata'),
        config: const DefaultMembershipConfig(),
        events: jobEvents,
        clock: FixedClock(_nowUtc),
        ids: _SeqIds('xj'),
        tenant: jobCtx,
      )();
      final e = jobAudit.forTenant(jobCtx.tenantId).single;
      expect(
        e.actor,
        'system',
        reason:
            '§17: for the expiry job "the actor MUST NOT be recorded as a '
            'human". Attributing a scheduled transition to whoever happened '
            'to be logged in would make the trail actively misleading.',
      );
      expect(e.detail['businessDate'], isNotNull);
    });

    test('a read produces no audit entry', () {
      final w = _World();
      w.add(status: MembershipStatus.active);
      w.repo.forStudent(_student);
      w.repo.all();
      expect(
        w.entries,
        isEmpty,
        reason:
            '§17: "Read of a membership | No | Access logging is a platform '
            'concern, not a domain mutation."',
      );
    });

    test('audit entries are tenant-scoped', () async {
      final a = _World(tenant: 'tnt_a');
      final b = _World(tenant: 'tnt_b');
      final pa = a.plan();
      await a.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('c1'),
        studentId: _student,
        plan: pa,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      expect(a.entries, hasLength(1));
      expect(
        b.audit.forTenant(b.ctx.tenantId),
        isEmpty,
        reason: 'MM-NFR-002: every write is filtered by the ambient tenant',
      );
      expect(
        a.audit.forTenant(b.ctx.tenantId),
        isEmpty,
        reason: 'and a cross-tenant read of the trail returns nothing',
      );
    });

    test('§17 still declares the mutations table normative', () {
      final text = File(_prdPath).readAsStringSync();
      expect(
        text.contains('**Mutations requiring audit — normative.**'),
        isTrue,
      );
      expect(
        text.contains('the actor **MUST NOT** be recorded as a human'),
        isTrue,
      );
    });
  });
}

/// A scheduled job's context: same tenant, no human actor.
final class _JobCtx implements TenantContext {
  _JobCtx(this._t, this._b);
  final TenantId _t;
  final BranchId _b;
  @override
  TenantId get tenantId => _t;
  @override
  BranchId get branchId => _b;
  @override
  String? get actorId => null;
  @override
  bool get hasTenant => true;
  @override
  String get correlationId => 'corr_job';
}
