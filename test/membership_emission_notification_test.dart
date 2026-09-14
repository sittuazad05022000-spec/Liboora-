/// `BC-02` Membership — lifecycle event emission, and Notification as facts.
///
/// Covers `IMPL-431` (event emission wired to every lifecycle transition) and
/// `IMPL-439` (notification integration as facts only) against FROZEN
/// `PRD-005` v1.4.
///
/// Two boundaries are load-bearing here.
///
/// **`MM-GAP-007` is CLOSED; `MM-GAP-007a` is OPEN.** `MembershipActivated`
/// and `MembershipVoided` are absent from BC Map §9 but ratified into
/// `BC-02`'s surface on 2026-08-04, and `MM-FR-054`/`MM-FR-078` say **MUST
/// emit** — so they are emitted. `MembershipUpgraded` is also absent from §9
/// and is **not** ratified: that is `MM-GAP-007a`, still open against the BC
/// Map. The two cases look alike and are not.
///
/// **`MM-BR-019`.** Notification and Analytics are consumers of facts, not
/// part of this domain. `IMPL-439`'s whole content is that no send path
/// exists — which is tested by looking for one and failing if it is found.
library;

import 'dart:io';

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

const _prdPath =
    'docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md';
const _membershipSrc = 'lib/domain/library/membership/membership.dart';
const _eventSrc = 'lib/platform/event/event.dart';

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

/// Strips comments before scanning source: the module documentation names the
/// very things a structural test bans, while explaining that they are banned.
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
    renew = RenewMembership(
      repo: repo,
      plans: plans,
      enrollment: _Enrollment(),
      calendar: cal,
      idempotency: idem,
      events: events,
      clock: clock,
      ids: _SeqIds('r$tenant'),
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
  late final CreateMembership create;
  late final ActivateMembership activate;
  late final VoidMembership voidIt;
  late final RenewMembership renew;
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
    String planId = 'plan_src',
  }) {
    final p = plan(id: planId, days: days);
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

  List<DomainEvent> ofType(MembershipEventType t) =>
      events.log.where((e) => e.eventType == t.wireName).toList();
}

void main() {
  // ════════════════════════════════════════════════════════════════════
  // IMPL-431 — MM-EVT-002, activation.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-431 · activation emits MM-EVT-002 (MM-FR-054)', () {
    test('activating a Scheduled membership emits exactly one event', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.scheduled);
      await w.activate(
        actorRole: AccessRole.owner,
        membershipId: m.id,
        paymentReference: 'pay_1',
      );
      expect(w.repo.byId(m.id)!.status, MembershipStatus.active);
      expect(w.ofType(MembershipEventType.activated), hasLength(1));
    });

    test('the payload carries the MM-EVT-002 declared fields', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.scheduled);
      await w.activate(
        actorRole: AccessRole.owner,
        membershipId: m.id,
        paymentReference: 'pay_1',
      );
      final e = w.ofType(MembershipEventType.activated).single;
      // §12's MM-EVT-002 row: activatedAt, activationReason, term.
      expect(e.payload['activatedAt'], isNotNull);
      expect(e.payload['activationReason'], 'payment_received');
      expect(e.payload['startDate'], isNotNull);
      expect(e.payload['validUntil'], isNotNull);
      // MM-BR-016's common set.
      expect(e.payload['membershipId'], m.id);
      expect(e.payload['studentRecordId'], _student.value);
    });

    test('MM-PO-004 manual authorisation is a distinct reason', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.pendingPayment);
      await w.activate(
        actorRole: AccessRole.owner,
        membershipId: m.id,
        paymentReference: 'manual_1',
        manuallyAuthorised: true,
      );
      expect(
        w
            .ofType(MembershipEventType.activated)
            .single
            .payload['activationReason'],
        'manual_authorisation',
        reason:
            'MM-FR-052 lists manual MM-PO-004 activation as a SEPARATE '
            'alternative to a payment outcome, so the fact must say which '
            'happened — a reconciliation cannot tell them apart otherwise.',
      );
    });

    test(
      '§15 row 4: a duplicate payment callback emits no second event',
      () async {
        final w = _World();
        final m = w.add(status: MembershipStatus.scheduled);
        final first = await w.activate(
          actorRole: AccessRole.owner,
          membershipId: m.id,
          paymentReference: 'pay_1',
        );
        final second = await w.activate(
          actorRole: AccessRole.owner,
          membershipId: m.id,
          paymentReference: 'pay_1',
        );
        expect(second.id, first.id);
        expect(
          w.ofType(MembershipEventType.activated),
          hasLength(1),
          reason:
              '§15 row 4: "Activation is idempotent on paymentReference. No '
              'second activation, no second MM-EVT-002."',
        );
      },
    );

    test('a duplicate callback SUCCEEDS rather than erroring', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.scheduled);
      await w.activate(
        actorRole: AccessRole.owner,
        membershipId: m.id,
        paymentReference: 'pay_1',
      );
      // A gateway retrying an unacknowledged callback is not making a
      // mistake. If the second call threw, the gateway would retry forever
      // or mark the payment failed -- both worse than a quiet success.
      expect(
        await w.activate(
          actorRole: AccessRole.owner,
          membershipId: m.id,
          paymentReference: 'pay_1',
        ),
        isA<Membership>(),
      );
    });

    test('two DIFFERENT payment references do not both activate', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.scheduled);
      await w.activate(
        actorRole: AccessRole.owner,
        membershipId: m.id,
        paymentReference: 'pay_1',
      );
      await expectLater(
        w.activate(
          actorRole: AccessRole.owner,
          membershipId: m.id,
          paymentReference: 'pay_2',
        ),
        throwsA(isA<DomainError>()),
        reason:
            'idempotency suppresses a RETRY; it must not be the only thing '
            'standing between a second distinct callback and a double '
            'activation. MM-FR-074 refuses the transition.',
      );
      expect(w.ofType(MembershipEventType.activated), hasLength(1));
    });

    test('activation is refused before startDate (MM-FR-052)', () async {
      final w = _World();
      final m = w.add(
        status: MembershipStatus.scheduled,
        start: DateTime(2026, 4, 1),
      );
      await expectLater(
        w.activate(
          actorRole: AccessRole.owner,
          membershipId: m.id,
          paymentReference: 'pay_1',
        ),
        throwsA(isA<DomainError>()),
      );
      expect(
        w.ofType(MembershipEventType.activated),
        isEmpty,
        reason: 'MM-FR-091: no partial state, and therefore no fact',
      );
    });

    test(
      'a cross-tenant id is NOT FOUND, never forbidden (MM-NFR-005)',
      () async {
        final a = _World(tenant: 'tnt_a');
        final b = _World(tenant: 'tnt_b');
        final m = a.add(status: MembershipStatus.scheduled);
        await expectLater(
          b.activate(
            actorRole: AccessRole.owner,
            membershipId: m.id,
            paymentReference: 'pay_1',
          ),
          throwsA(
            isA<DomainError>().having(
              (e) => e.code,
              'code',
              DomainErrorCode.notFound,
            ),
          ),
          reason:
              'MM-NFR-005: "forbidden" would confirm the id is real, making '
              'existence probeable across tenants.',
        );
      },
    );
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-431 — MM-EVT-007, void before activation.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-431 · void emits MM-EVT-007 (MM-FR-078)', () {
    test('voiding a PendingPayment membership emits one event', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.pendingPayment);
      await w.voidIt(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('v1'),
        membershipId: m.id,
        reason: 'created against the wrong student',
      );
      expect(w.repo.byId(m.id)!.status, MembershipStatus.cancelled);
      expect(w.ofType(MembershipEventType.voided), hasLength(1));
    });

    test('the payload carries reason and voidedBy', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.scheduled);
      await w.voidIt(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('v1'),
        membershipId: m.id,
        reason: 'duplicate sale',
      );
      final e = w.ofType(MembershipEventType.voided).single;
      expect(e.payload['reason'], 'duplicate sale');
      expect(e.payload['voidedBy'], 'owner_1');
    });

    test('voiding an Active membership is refused and emits nothing', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.active);
      await expectLater(
        w.voidIt(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('v1'),
          membershipId: m.id,
          reason: 'change of mind',
        ),
        throwsA(isA<DomainError>()),
        reason:
            'MM-FR-079: this MUST NOT be extended to an Active membership. '
            'Cancellation with refund is V2 (MM-XC-011).',
      );
      expect(w.ofType(MembershipEventType.voided), isEmpty);
    });

    test('a void with a blank reason emits nothing (MM-FR-078)', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.pendingPayment);
      await expectLater(
        w.voidIt(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('v1'),
          membershipId: m.id,
          reason: '   ',
        ),
        throwsA(isA<DomainError>()),
      );
      expect(w.ofType(MembershipEventType.voided), isEmpty);
    });

    test('a repeated void yields one event', () async {
      final w = _World();
      final m = w.add(status: MembershipStatus.pendingPayment);
      await w.voidIt(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('v1'),
        membershipId: m.id,
        reason: 'duplicate sale',
      );
      await w.voidIt(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('v1'),
        membershipId: m.id,
        reason: 'duplicate sale',
      );
      expect(w.ofType(MembershipEventType.voided), hasLength(1));
    });

    test('voiding frees the MM-INV-001 slot', () async {
      final w = _World();
      final p = w.plan();
      final first = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('c1'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: false,
      );
      await w.voidIt(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('v1'),
        membershipId: first.id,
        reason: 'wrong plan selected',
      );
      // MM-FR-102 names void-and-recreate as the correction path, so the
      // recreate has to actually work.
      final replacement = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('c2'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      expect(replacement.id, isNot(first.id));
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-431 — MM-EVT-006, expiring soon.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-431 · expiring-soon emits MM-EVT-006 (MM-FR-108)', () {
    test('a membership inside the threshold is notified once', () async {
      final w = _World();
      // endDate = 2026-03-12, threshold default is 7 days.
      w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 3),
        days: 10,
      );
      final notified = await w.expire.notifyExpiringSoon();
      expect(notified, hasLength(1));
      expect(w.ofType(MembershipEventType.expiringSoon), hasLength(1));
    });

    test('exactly once per threshold crossing, across runs', () async {
      final w = _World();
      w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 3),
        days: 10,
      );
      await w.expire.notifyExpiringSoon();
      await w.expire.notifyExpiringSoon();
      await w.expire.notifyExpiringSoon();
      expect(
        w.ofType(MembershipEventType.expiringSoon),
        hasLength(1),
        reason:
            'MM-FR-108: "exactly once per membership per threshold '
            'crossing". Keying on the day would re-emit tomorrow.',
      );
    });

    test('the payload carries endDate and daysRemaining', () async {
      final w = _World();
      final m = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 3),
        days: 10,
      );
      await w.expire.notifyExpiringSoon();
      final e = w.ofType(MembershipEventType.expiringSoon).single;
      expect(e.payload['endDate'], m.endDate.toIso8601String());
      expect(e.payload['daysRemaining'], isA<int>());
      expect(e.payload['daysRemaining'], greaterThan(0));
    });

    test('a membership outside the threshold is not notified', () async {
      final w = _World();
      w.add(status: MembershipStatus.active, start: DateTime(2026, 3, 10));
      expect(
        await w.expire.notifyExpiringSoon(),
        isEmpty,
        reason: 'endDate is 2026-04-08, far outside MM-CFG-008',
      );
    });

    test('expiringSoon() itself emits nothing — it is a query', () async {
      final w = _World();
      w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 3),
        days: 10,
      );
      final due = w.expire.expiringSoon();
      expect(due, hasLength(1));
      expect(
        w.ofType(MembershipEventType.expiringSoon),
        isEmpty,
        reason:
            'a read must not have side effects — a view refresh would '
            'otherwise consume the "exactly once" budget',
      );
    });

    test('MM-EVT-006 is a fact, and carries no instruction', () async {
      final w = _World();
      w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 3),
        days: 10,
      );
      await w.expire.notifyExpiringSoon();
      final e = w.ofType(MembershipEventType.expiringSoon).single;
      for (final key in ['channel', 'template', 'recipient', 'message']) {
        expect(
          e.payload.containsKey(key),
          isFalse,
          reason:
              '§12: MM-EVT-006 is "a fact, not a command". "$key" would make '
              'it an instruction to BC-22, which MM-BR-019 forbids.',
        );
      }
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-431 — renewal, already wired, re-pinned for the task's own claim.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-431 · renewal emission (MM-FR-089…092)', () {
    test('a successful renewal emits exactly one MM-EVT-003', () async {
      final w = _World();
      final source = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 5),
      );
      await w.renew(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('r1'),
        sourceMembershipId: source.id,
        ontoPlan: w.plan(),
        paymentAlreadyReceived: true,
      );
      expect(w.ofType(MembershipEventType.renewed), hasLength(1));
    });

    test('the "existing successor" path emits NO event (MM-FR-090)', () async {
      final w = _World();
      final source = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 5),
      );
      await w.renew(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('r1'),
        sourceMembershipId: source.id,
        ontoPlan: w.plan(),
        paymentAlreadyReceived: true,
      );
      final after = w.ofType(MembershipEventType.renewed).length;
      await expectLater(
        w.renew(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('r2'),
          sourceMembershipId: source.id,
          ontoPlan: w.plan(),
          paymentAlreadyReceived: true,
        ),
        throwsA(isA<DomainError>()),
      );
      expect(
        w.ofType(MembershipEventType.renewed).length,
        after,
        reason:
            'IMPL-431 requires the error path to "emit correctly" — and the '
            'correct emission for a rejected renewal is none at all. '
            'MM-FR-091 leaves no partial state.',
      );
    });

    test('MM-FR-092: a renewal awaiting payment emits no activation', () async {
      final w = _World();
      final source = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 5),
      );
      final renewal = await w.renew(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('r1'),
        sourceMembershipId: source.id,
        ontoPlan: w.plan(),
        paymentAlreadyReceived: false,
      );
      expect(renewal.status, MembershipStatus.pendingPayment);
      expect(
        w.ofType(MembershipEventType.activated),
        isEmpty,
        reason:
            'MM-FR-092: a renewal requiring payment MUST NOT confer '
            'entitlement until the payment outcome arrives',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-431 — the register is fully wired, minus the blocked one.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-431 · every V1 transition has a producer', () {
    test('six of the seven MM-EVT-* are raised in lib/', () {
      final src = File(_membershipSrc).readAsStringSync();
      final wired = <MembershipEventType>[];
      for (final t in MembershipEventType.values) {
        if (src.contains("eventType: MembershipEventType.${t.name}.wireName") ||
            src.contains("eventType: '${t.wireName}'")) {
          wired.add(t);
        }
      }
      expect(
        wired.map((t) => t.name).toSet(),
        {
          'created',
          'activated',
          'renewed',
          'expired',
          'expiringSoon',
          'voided',
        },
        reason:
            'All six emittable V1 events now have a producer. The seventh, '
            'upgraded, is blocked by MM-GAP-007a.',
      );
    });

    test('⛔ MM-EVT-004 has no producer, and that is deliberate', () {
      final src = File(_membershipSrc).readAsStringSync();
      expect(
        src.contains('eventType: MembershipEventType.upgraded.wireName'),
        isFalse,
        reason:
            'MM-GAP-007a is OPEN against the BC Map: §9 omits '
            'MembershipUpgraded though PRD-005 §9 names it, and ADR-0019 '
            'does not close it. Unlike MM-GAP-007 — which WAS ratified for '
            'Activated and Voided on 2026-08-04 — there is no ratification '
            'to rely on here. Emitting would let a consumer depend on an '
            'event the Published Language has not declared.',
      );
    });

    test('MM-GAP-007a is still open in the frozen record', () {
      final adr = File(
        'docs/00-governance/adr/'
        'ADR-0019-membership-management-prd-v1.4-baseline.md',
      ).readAsStringSync();
      expect(
        adr.contains('MM-GAP-007a'),
        isTrue,
        reason:
            'if this gap were closed, the producer above should be wired in '
            'the same change — this test is the reminder',
      );
    });

    test('MM-GAP-007 by contrast is recorded as closed', () {
      final text = File(_prdPath).readAsStringSync();
      expect(
        text.contains('**Status of `MM-GAP-007`: closed.**'),
        isTrue,
        reason:
            'this is the evidence that Activated and Voided may be emitted '
            'despite their absence from BC Map §9',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-439 — Notification as facts only.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-439 · no send path exists (MM-XC-005)', () {
    test('the domain module contains no message-send call', () {
      final src = _codeOnly(File(_membershipSrc).readAsStringSync());
      for (final banned in [
        'sendSms',
        'sendSMS',
        'sendEmail',
        'sendPush',
        'sendMessage',
        'notify(',
        'SmsGateway',
        'PushService',
        'MailerClient',
      ]) {
        expect(
          src.contains(banned),
          isFalse,
          reason:
              'MM-XC-005: "Sending an SMS, push, email or in-app message" is '
              'BC-22\'s, per MP-GBR-33. "$banned" would be a send path.',
        );
      }
    });

    test('the event platform contains no send path either', () {
      final src = _codeOnly(File(_eventSrc).readAsStringSync());
      for (final banned in [
        'sendSms',
        'sendEmail',
        'sendPush',
        'HttpClient',
        'Socket',
      ]) {
        expect(
          src.contains(banned),
          isFalse,
          reason:
              'MM-BR-019 keeps Notification a CONSUMER of facts. The bus '
              'carries facts; it must not deliver messages.',
        );
      }
    });

    test('no gateway call or credential (MM-XC-003)', () {
      final src = _codeOnly(File(_membershipSrc).readAsStringSync());
      for (final banned in [
        'apiKey',
        'apiSecret',
        'gatewayToken',
        'PaymentGateway',
        'chargeCard',
        'capturePayment',
        'upiIntent',
      ]) {
        expect(
          src.contains(banned),
          isFalse,
          reason:
              'MM-XC-003: "Processing a card/UPI/cash payment, calling a '
              'gateway, or holding a gateway credential" is excluded. '
              'MM-FR-044 repeats it.',
        );
      }
    });

    test('no ledger, balance, receipt or refund record (MM-XC-004)', () {
      final src = _codeOnly(File(_membershipSrc).readAsStringSync());
      for (final banned in [
        'class Ledger',
        'LedgerEntry',
        'accountBalance',
        'Receipt(',
        'class Receipt',
        'RefundRecord',
        'issueRefund',
      ]) {
        expect(
          src.contains(banned),
          isFalse,
          reason:
              'MM-XC-004 / MM-BR-001: BC-05 owns the monetary ledger, '
              'balance, receipt and refund record.',
        );
      }
    });

    test('no membership event instructs a channel', () async {
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
      expect(w.events.log, isNotEmpty);
      for (final e in w.events.log) {
        for (final key in [
          'channel',
          'template',
          'templateId',
          'recipient',
          'smsBody',
          'pushTitle',
          'sendAt',
        ]) {
          expect(
            e.payload.containsKey(key),
            isFalse,
            reason:
                'MM-XC-005 / E-23: "Domain emits facts, never \'send an '
                'SMS\'". "$key" on ${e.eventType} would be a command.',
          );
        }
      }
    });

    test('E-23 exists as an edge, and carries no send capability', () {
      // The edge to BC-22 IS declared -- E-23 is one of MM-BR-006's ten, and
      // BC Map §7 L332 describes it as "Domain emits *facts*
      // (MembershipExpiringSoon), never 'send an SMS'". So the test is not
      // that the edge is absent; it is that the edge is one-way and
      // fact-shaped. MM-BR-019 puts Notification outside this domain as a
      // CONSUMER, which requires an edge to consume across.
      final edges = MembershipEdge.values;
      expect(edges, hasLength(10), reason: 'MM-BR-006 declares ten edges');
      expect(
        edges.map((e) => e.name),
        contains('e23Notification'),
        reason: 'E-23 is declared; removing it would break MM-BR-006',
      );
      expect(
        MembershipEdge.e23Notification.blocksOnInvalidMembership,
        isFalse,
        reason:
            'only E-02 seating blocks on validity (MP-GBR-16). A '
            'notification edge that could block would be a synchronous '
            'dependency on BC-22, which MM-BR-019 forbids.',
      );
    });

    test('no eleventh edge is constructible (MM-BR-006)', () {
      expect(
        () => MembershipEdge.values.byName('e24SomethingNew'),
        throwsArgumentError,
        reason:
            'MM-BR-008 closes the edge set. An eleventh edge is how a send '
            'path would arrive.',
      );
    });

    test('MM-XC-003/004/005 are still excluded in the frozen PRD', () {
      final text = File(_prdPath).readAsStringSync();
      for (final id in ['MM-XC-003', 'MM-XC-004', 'MM-XC-005']) {
        expect(
          text.contains('`$id`'),
          isTrue,
          reason: 'the exclusion this test enforces must still exist',
        );
      }
    });
  });
}
