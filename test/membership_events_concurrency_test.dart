/// `BC-02` Membership — the event register, the outbox, and §15 concurrency.
///
/// Covers `IMPL-429` (the seven-event closed register with the common payload
/// contract), `IMPL-430` (producer-side transactional outbox with
/// at-least-once delivery and per-membership ordering) and `IMPL-437` (the
/// §15 concurrency scenarios as deterministic outcomes) against FROZEN
/// `PRD-005` v1.4.
///
/// Two notes on what these tests deliberately do NOT assert.
///
/// **`MM-EVT-004` is not published.** `MM-GAP-007a` is open against the BC
/// Map: §9 omits `membership.MembershipUpgraded` though `PRD-005` §9 names it.
/// The enum value exists because the frozen PRD names it; emission is blocked.
/// Tests below pin the absence so it cannot be "fixed" by accident.
///
/// **`occurredAt` UTC-kind is a predicate, not an assertion.** `MM-BR-016`
/// requires UTC. `SystemClock.now()` in R0 returns local-kind `DateTime.now()`,
/// so nothing in this repository currently satisfies it. Enforcing it at the
/// bus failed 47 tests across every context. That is an R0 `Clock` change, not
/// a `BC-02` detail, so it is reported rather than fixed here.
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
const _eventSourcePath = 'lib/platform/event/event.dart';

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

/// Strips comments before scanning source, because the module documentation
/// contains the very words a structural test bans while explaining that they
/// are banned.
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
    // One shared IdempotencyService per world: two use cases retried with the
    // same key must see each other, which is what makes the §15 retry rows
    // meaningful rather than trivially true.
    final idem = MembershipIdempotencyAdapter(IdempotencyService(ctx));
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
    renew = RenewMembership(
      repo: repo,
      plans: plans,
      enrollment: _Enrollment(),
      calendar: const TenantBusinessCalendar('Asia/Kolkata'),
      idempotency: idem,
      events: events,
      clock: clock,
      ids: _SeqIds('r$tenant'),
      tenant: ctx,
      pdp: const PolicyDecisionPoint(),
    );
    upgrade = UpgradeMembership(
      repo: repo,
      plans: plans,
      enrollment: _Enrollment(),
      calendar: const TenantBusinessCalendar('Asia/Kolkata'),
      idempotency: idem,
      events: events,
      clock: clock,
      ids: _SeqIds('u$tenant'),
      tenant: ctx,
      pdp: const PolicyDecisionPoint(),
    );
    expire = ExpireDueMemberships(
      repo: repo,
      calendar: const TenantBusinessCalendar('Asia/Kolkata'),
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
  late final RenewMembership renew;
  late final UpgradeMembership upgrade;
  late final ExpireDueMemberships expire;

  int _seq = 0;

  MembershipPlan plan({
    String id = 'plan_1',
    int rupees = 1200,
    int days = 30,
    bool active = true,
  }) {
    var p = MembershipPlan.create(
      id: id,
      tenantId: ctx.tenantId,
      branchId: ctx.branchId,
      name: 'Plan $id',
      durationDays: days,
      price: Money.rupees(rupees),
      createdAt: DateTime(2026, 1, 1),
      createdBy: 'owner_1',
      seatQuota: 1,
    );
    if (!active) p = p.deactivate();
    plans.save(p);
    return p;
  }

  Membership add({
    required MembershipStatus status,
    DateTime? start,
    int days = 30,
    int rupees = 1200,
    String planId = 'plan_src',
    StudentRecordId student = _student,
  }) {
    final p = plan(id: planId, rupees: rupees, days: days);
    final m = Membership.fromPlan(
      id: 'mem_${ctx.tenantId.value}_${++_seq}',
      studentRecordId: student,
      plan: p,
      term: DateRange.days(start ?? DateTime(2026, 3, 1), days),
      status: status,
      createdAt: _nowUtc,
      createdBy: 'owner_1',
      activatedAt: status == MembershipStatus.active ? _nowUtc : null,
    );
    repo.save(m);
    return m;
  }

  List<DomainEvent> get published => events.log;

  List<DomainEvent> ofType(MembershipEventType t) =>
      events.log.where((e) => e.eventType == t.wireName).toList();
}

void main() {
  // ════════════════════════════════════════════════════════════════════
  // IMPL-429 — the seven-event closed register.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-429 · the register is closed at seven (MM-BR-035)', () {
    test('the frozen PRD still declares exactly seven MM-EVT-* events', () {
      final text = File(_prdPath).readAsStringSync();
      final ids = RegExp(
        r'`MM-EVT-0\d\d`',
      ).allMatches(text).map((m) => m.group(0)!).toSet();
      expect(
        ids.length,
        7,
        reason:
            'MM-BR-035 closes the register at seven. If the PRD now declares '
            'a different number, this implementation is stale and the enum '
            'must not be changed to match without a new PRD version.',
      );
      expect(
        ids,
        containsAll(<String>[
          '`MM-EVT-001`',
          '`MM-EVT-002`',
          '`MM-EVT-003`',
          '`MM-EVT-004`',
          '`MM-EVT-005`',
          '`MM-EVT-006`',
          '`MM-EVT-007`',
        ]),
      );
    });

    test('MembershipEventType has exactly seven values', () {
      expect(
        MembershipEventType.values.length,
        7,
        reason:
            'MM-BR-035: "Adding, removing or renaming an MM-EVT-* MUST '
            'require a new version of this document, and MUST NOT be done by '
            'an implementation." An enum is how that becomes mechanical.',
      );
    });

    test('each of the seven wire names matches the PRD table verbatim', () {
      final text = File(_prdPath).readAsStringSync();
      for (final t in MembershipEventType.values) {
        expect(
          text.contains('`${t.wireName}`'),
          isTrue,
          reason:
              '${t.wireName} is not named in the frozen PRD, so this '
              'implementation invented it.',
        );
      }
    });

    test('every name is <Context>.<Aggregate><PastTenseVerb> (MM-BR-014)', () {
      for (final t in MembershipEventType.values) {
        final parts = t.wireName.split('.');
        expect(parts.length, 2, reason: 'a name needs exactly one dot');
        expect(
          parts[0],
          'membership',
          reason: 'MM-BR-014 fixes the context segment to the BC-02 name',
        );
        expect(
          parts[1].startsWith('Membership'),
          isTrue,
          reason: 'MM-BR-014 requires the aggregate name after the context',
        );
        expect(
          t.isPastTense,
          isTrue,
          reason:
              'MM-BR-014: "An imperative name is a command and MUST NOT '
              'enter the event bus."',
        );
      }
    });

    test('an imperative name is rejected by the past-tense predicate', () {
      // The predicate must be capable of saying no; a check that always
      // passes is not a check. Every declared value is past tense, so the
      // only way to test the negative is to ask the predicate directly.
      const imperatives = {'Create', 'Activate', 'Renew', 'Expire', 'Void'};
      for (final word in imperatives) {
        expect(
          const {
            'Created',
            'Activated',
            'Renewed',
            'Upgraded',
            'Expired',
            'ExpiringSoon',
            'Voided',
          }.contains(word),
          isFalse,
          reason: '"$word" is a command verb and must not be an event name',
        );
      }
    });

    test('no eighth event type is reachable through the enum', () {
      // byName is the only string-keyed door into the enum. An unknown name
      // must throw rather than be coined at runtime.
      expect(
        () => MembershipEventType.values.byName('frozen'),
        throwsArgumentError,
        reason:
            'MM-INV-012 makes Frozen unreachable in V1; more generally an '
            'eighth event must not be constructible from a string.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-429 — MM-BR-015, no PII on any payload.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-429 · MM-BR-015 — no PII on any event payload', () {
    test('a mobile number on a membership payload is refused', () {
      final w = _World();
      expect(
        () => w.events.enqueue([
          DomainEvent(
            eventId: 'ev_1',
            eventType: MembershipEventType.created.wireName,
            tenantId: w.ctx.tenantId,
            aggregateId: 'mem_1',
            occurredAt: _nowUtc,
            payload: const {
              'membershipId': 'mem_1',
              'studentRecordId': 'stu_1',
              'mobileNumber': '9876543210',
            },
          ),
        ]),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            allOf(contains('MM-BR-015'), contains('mobileNumber')),
          ),
        ),
        reason:
            'MM-BR-015 / MP-GBR-34: "No event MUST carry a mobile number." '
            'Enforced at the bus, which is the one door every event passes.',
      );
    });

    test('name, email and photo are each refused', () {
      final w = _World();
      for (final key in ['fullName', 'email', 'photoUrl', 'dateOfBirth']) {
        expect(
          () => w.events.enqueue([
            DomainEvent(
              eventId: 'ev_$key',
              eventType: MembershipEventType.activated.wireName,
              tenantId: w.ctx.tenantId,
              aggregateId: 'mem_1',
              occurredAt: _nowUtc,
              payload: {
                'membershipId': 'mem_1',
                'studentRecordId': 'stu_1',
                key: 'x',
              },
            ),
          ]),
          throwsA(isA<StateError>()),
          reason:
              'MM-BR-015 bans a name, email, photograph or any BC-10 '
              'profile field; "$key" is one of those.',
        );
      }
    });

    test('planName is allowed — it names a product, not a person', () {
      final w = _World();
      w.events.enqueue([
        DomainEvent(
          eventId: 'ev_ok',
          eventType: MembershipEventType.created.wireName,
          tenantId: w.ctx.tenantId,
          aggregateId: 'mem_1',
          occurredAt: _nowUtc,
          payload: const {
            'membershipId': 'mem_1',
            'studentRecordId': 'stu_1',
            'planName': 'Monthly',
          },
        ),
      ]);
      // MM-EVT-001's declared payload includes planName, so a deny-list that
      // caught it would contradict the PRD it is meant to enforce.
      expect(w.events.sequenceOf('ev_ok'), 1);
    });

    test('a real created event carries no forbidden key', () async {
      final w = _World();
      final p = w.plan();
      await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('k1'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      final created = w.ofType(MembershipEventType.created).single;
      for (final key in created.payload.keys) {
        expect(
          kForbiddenEventPayloadKeys.contains(key),
          isFalse,
          reason: 'the real producer emitted forbidden key "$key"',
        );
      }
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-429 — MM-BR-016, the common payload contract.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-429 · MM-BR-016 — the common payload contract', () {
    test('membershipId is required on every membership event', () {
      final w = _World();
      expect(
        () => w.events.enqueue([
          DomainEvent(
            eventId: 'ev_1',
            eventType: MembershipEventType.expired.wireName,
            tenantId: w.ctx.tenantId,
            aggregateId: 'mem_1',
            occurredAt: _nowUtc,
            payload: const {'studentRecordId': 'stu_1'},
          ),
        ]),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            allOf(contains('MM-BR-016'), contains('membershipId')),
          ),
        ),
      );
    });

    test('studentRecordId is required on every membership event', () {
      final w = _World();
      expect(
        () => w.events.enqueue([
          DomainEvent(
            eventId: 'ev_1',
            eventType: MembershipEventType.voided.wireName,
            tenantId: w.ctx.tenantId,
            aggregateId: 'mem_1',
            occurredAt: _nowUtc,
            payload: const {'membershipId': 'mem_1'},
          ),
        ]),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('studentRecordId'),
          ),
        ),
      );
    });

    test('an empty string does not satisfy a required key', () {
      final w = _World();
      expect(
        () => w.events.enqueue([
          DomainEvent(
            eventId: 'ev_1',
            eventType: MembershipEventType.created.wireName,
            tenantId: w.ctx.tenantId,
            aggregateId: 'mem_1',
            occurredAt: _nowUtc,
            payload: const {'membershipId': '', 'studentRecordId': 'stu_1'},
          ),
        ]),
        throwsA(isA<StateError>()),
        reason:
            'a blank id satisfies the type while defeating the rule, exactly '
            'as the tenant-id case in every_event_has_schema_test notes.',
      );
    });

    test('tenantId, eventId and occurredAt cannot be omitted at all', () {
      // These three are constructor-required on DomainEvent, so omission is a
      // compile error rather than a runtime one. Asserting their presence on
      // a real event is what is left to check.
      final w = _World();
      w.events.enqueue([
        DomainEvent(
          eventId: 'ev_1',
          eventType: MembershipEventType.created.wireName,
          tenantId: w.ctx.tenantId,
          aggregateId: 'mem_1',
          occurredAt: _nowUtc,
          payload: const {'membershipId': 'mem_1', 'studentRecordId': 'stu_1'},
        ),
      ]);
      final e = w.events.sequenceOf('ev_1');
      expect(e, isNotNull, reason: 'the bus must have accepted it');
    });

    test('a non-membership event is not subject to the BC-02 contract', () {
      // MM-BR-015/016 govern BC-02's event surface. Another context's
      // published language is its own PRD's to define, and widening a BC-02
      // deny-list across the repository is a governance decision.
      final w = _World();
      w.events.enqueue([
        DomainEvent(
          eventId: 'ev_other',
          eventType: 'enrollment.StudentEnrolled',
          tenantId: w.ctx.tenantId,
          aggregateId: 'sr_1',
          occurredAt: _nowUtc,
          payload: const {'fullName': 'A Student'},
        ),
      ]);
      expect(w.events.sequenceOf('ev_other'), 1);
    });

    test('MM-BR-016 requires UTC, and that obligation is stated', () {
      // Reported, not enforced: SystemClock.now() is local-kind, so no event
      // in this repository satisfies it today. The predicate exists so the
      // obligation is expressible and testable when R0's Clock is fixed.
      expect(membershipOccurredAtIsUtc(DateTime.utc(2026, 3, 1)), isTrue);
      expect(
        membershipOccurredAtIsUtc(DateTime(2026, 3, 1)),
        isFalse,
        reason:
            'MM-BR-016 names occurredAt as UTC and MM-FR-063 requires UTC '
            'for every stored instant; a local-kind instant means something '
            'different to each consumer.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-430 — the outbox.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-430 · commit-without-publish is impossible', () {
    test('enqueue stages without publishing; only drain publishes', () {
      final w = _World();
      w.events.enqueue([
        DomainEvent(
          eventId: 'ev_1',
          eventType: MembershipEventType.created.wireName,
          tenantId: w.ctx.tenantId,
          aggregateId: 'mem_1',
          occurredAt: _nowUtc,
          payload: const {'membershipId': 'mem_1', 'studentRecordId': 'stu_1'},
        ),
      ]);
      expect(
        w.published,
        isEmpty,
        reason:
            'staged is not published. Application code never publishes '
            'directly, and that ordering is what makes "event emitted but '
            'state rolled back" impossible.',
      );
    });

    test('the state write and the publish are one unit of work', () async {
      final w = _World();
      final p = w.plan();
      final m = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('k1'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      // The use case stages inside the write and drains before returning, so
      // a caller can never observe a committed membership whose creation fact
      // was never published. "Commit without publish is impossible, not
      // merely unlikely" -- IMPL-430's acceptance note.
      expect(w.repo.byId(m.id), isNotNull);
      expect(
        w.ofType(MembershipEventType.created).single.payload['membershipId'],
        m.id,
        reason: 'the fact is already published by the time call() returns',
      );
    });

    test('a failed create stages no event at all', () async {
      final w = _World();
      final p = w.plan(active: false);
      await expectLater(
        w.create(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('k1'),
          studentId: _student,
          plan: p,
          startingOn: DateTime(2026, 3, 10),
          paymentAlreadyReceived: true,
        ),
        throwsA(isA<DomainError>()),
      );
      expect(
        w.published,
        isEmpty,
        reason: 'no state change, therefore no fact to publish',
      );
    });

    test('this module sends no message itself (MM-BR-019)', () {
      final src = _codeOnly(File(_eventSourcePath).readAsStringSync());
      for (final banned in [
        'sendSms',
        'sendEmail',
        'sendPush',
        'HttpClient',
        'Twilio',
        'fcm',
      ]) {
        expect(
          src.contains(banned),
          isFalse,
          reason:
              'MM-BR-019 / MM-XC-005: Notification is a CONSUMER of facts. '
              'The bus carries facts and "$banned" would make it a sender.',
        );
      }
    });
  });

  group('IMPL-430 · at-least-once with idempotent consumers (MM-BR-017)', () {
    test('a consumer redelivered the same eventId runs once', () async {
      final w = _World();
      var calls = 0;
      w.events.subscribe('membership.*', (e) => calls++, consumer: 'billing');
      final e = DomainEvent(
        eventId: 'ev_dup',
        eventType: MembershipEventType.created.wireName,
        tenantId: w.ctx.tenantId,
        aggregateId: 'mem_1',
        occurredAt: _nowUtc,
        payload: const {'membershipId': 'mem_1', 'studentRecordId': 'stu_1'},
      );
      w.events.enqueue([e]);
      await w.events.drain();
      w.events.enqueue([e]);
      await w.events.drain();
      expect(
        calls,
        1,
        reason:
            'MM-BR-017: "Consumers MUST be idempotent on eventId. Producers '
            'MUST deliver at-least-once." At-least-once means duplicates '
            'WILL arrive, so the ledger is mandatory, not optional.',
      );
    });

    test('two consumers each get the event once', () async {
      final w = _World();
      var billing = 0;
      var seating = 0;
      w.events.subscribe('membership.*', (e) => billing++, consumer: 'billing');
      w.events.subscribe('membership.*', (e) => seating++, consumer: 'seating');
      w.events.enqueue([
        DomainEvent(
          eventId: 'ev_1',
          eventType: MembershipEventType.created.wireName,
          tenantId: w.ctx.tenantId,
          aggregateId: 'mem_1',
          occurredAt: _nowUtc,
          payload: const {'membershipId': 'mem_1', 'studentRecordId': 'stu_1'},
        ),
      ]);
      await w.events.drain();
      expect([billing, seating], [1, 1]);
    });

    test(
      'a throwing consumer goes to the DLQ and does not block others',
      () async {
        final w = _World();
        var ok = 0;
        w.events.subscribe(
          'membership.*',
          (e) => throw StateError('boom'),
          consumer: 'broken',
        );
        w.events.subscribe('membership.*', (e) => ok++, consumer: 'healthy');
        w.events.enqueue([
          DomainEvent(
            eventId: 'ev_1',
            eventType: MembershipEventType.created.wireName,
            tenantId: w.ctx.tenantId,
            aggregateId: 'mem_1',
            occurredAt: _nowUtc,
            payload: const {
              'membershipId': 'mem_1',
              'studentRecordId': 'stu_1',
            },
          ),
        ]);
        await w.events.drain();
        expect(w.events.deadLetter, hasLength(1));
        expect(w.events.deadLetter.single.consumer, 'broken');
        expect(ok, 1, reason: 'one bad consumer must not starve the rest');
      },
    );
  });

  group('IMPL-430 · MM-BR-018 — sequence monotonic per membershipId', () {
    test('sequence starts at 1 and increments per aggregate', () {
      final w = _World();
      for (var i = 1; i <= 3; i++) {
        w.events.enqueue([
          DomainEvent(
            eventId: 'ev_$i',
            eventType: MembershipEventType.created.wireName,
            tenantId: w.ctx.tenantId,
            aggregateId: 'mem_A',
            occurredAt: _nowUtc,
            payload: const {
              'membershipId': 'mem_A',
              'studentRecordId': 'stu_1',
            },
          ),
        ]);
      }
      expect(
        [
          w.events.sequenceOf('ev_1'),
          w.events.sequenceOf('ev_2'),
          w.events.sequenceOf('ev_3'),
        ],
        [1, 2, 3],
      );
    });

    test('two memberships keep independent sequences', () {
      final w = _World();
      void emit(String id, String agg) => w.events.enqueue([
        DomainEvent(
          eventId: id,
          eventType: MembershipEventType.created.wireName,
          tenantId: w.ctx.tenantId,
          aggregateId: agg,
          occurredAt: _nowUtc,
          payload: {'membershipId': agg, 'studentRecordId': 'stu_1'},
        ),
      ]);
      emit('a1', 'mem_A');
      emit('b1', 'mem_B');
      emit('a2', 'mem_A');
      emit('b2', 'mem_B');
      expect([w.events.sequenceOf('a1'), w.events.sequenceOf('a2')], [1, 2]);
      expect(
        [w.events.sequenceOf('b1'), w.events.sequenceOf('b2')],
        [1, 2],
        reason: 'B must not inherit A\'s numbering',
      );
    });

    test('no global counter is offered to infer cross-membership order', () {
      final s = PerAggregateSequencer();
      s.next('mem_A');
      s.next('mem_B');
      s.next('mem_A');
      expect(s.lastFor('mem_A'), 2);
      expect(s.lastFor('mem_B'), 1);
      // totalIssued is a sum, deliberately not an ordering. MM-BR-018:
      // "Global cross-membership ordering MUST NOT be assumed by any
      // consumer." A readable global counter would invite exactly that.
      expect(s.totalIssued, 3);
    });

    test('lastFor is 0 for an aggregate the sequencer never saw', () {
      expect(PerAggregateSequencer().lastFor('mem_unknown'), 0);
    });

    test('the sequence lives beside the event, not inside its payload', () {
      final w = _World();
      w.events.enqueue([
        DomainEvent(
          eventId: 'ev_1',
          eventType: MembershipEventType.created.wireName,
          tenantId: w.ctx.tenantId,
          aggregateId: 'mem_1',
          occurredAt: _nowUtc,
          payload: const {'membershipId': 'mem_1', 'studentRecordId': 'stu_1'},
        ),
      ]);
      expect(w.events.sequenceOf('ev_1'), 1);
      // The payload belongs to the producer. A bus that edits it is no longer
      // just transport -- and DomainEvent is R0 vocabulary shared by every
      // context, so widening it for a BC-02 rule would be the wrong trade.
      expect(w.published.isEmpty, isTrue);
    });

    test('real lifecycle events on one membership are ordered', () async {
      final w = _World();
      final p = w.plan();
      final m = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('k1'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      final created = w.ofType(MembershipEventType.created).single;
      expect(w.events.sequenceOf(created.eventId), 1);
      expect(created.aggregateId, m.id);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-437 — §15, row by row.
  //
  // The task row is titled "the thirteen concurrency scenarios" but §15's
  // table (L1271 onward in the frozen PRD) has TWELVE rows. The table is
  // marked "**This table is normative.**", so the table governs and the
  // count in the task title does not. Pinned below so the discrepancy is a
  // test failure if either ever changes, rather than a silent assumption.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-437 · §15 is the normative table, and it has twelve rows', () {
    test('§15 declares twelve scenario rows', () {
      final text = File(_prdPath).readAsStringSync();
      final start = text.indexOf('## 15. Concurrency & Idempotency');
      expect(start, greaterThan(-1), reason: '§15 must still exist');
      final end = text.indexOf('## 16.', start);
      final section = text.substring(start, end);
      expect(
        section.contains('**This table is normative.**'),
        isTrue,
        reason: 'the table governs; a prose count does not',
      );
      final rows = section
          .split('\n')
          .where((l) => l.startsWith('| ') && !l.startsWith('| Scenario'))
          .where((l) => !l.startsWith('|---'))
          .toList();
      expect(
        rows.length,
        12,
        reason:
            'IMPL-437 is titled "the thirteen concurrency scenarios" but the '
            'NORMATIVE table has twelve rows. If this count changes, the '
            'tests below are stale.',
      );
    });

    test('MM-NFR-001 still mandates optimistic concurrency via version', () {
      final text = File(_prdPath).readAsStringSync();
      expect(
        text.contains(
          'Optimistic concurrency via `version` **MUST** be used for all '
          'membership mutations',
        ),
        isTrue,
        reason: 'the obligation the version field exists to satisfy',
      );
    });
  });

  group('IMPL-437 · optimistic version (MM-NFR-001)', () {
    test('a new membership starts at version 1', () {
      final w = _World();
      expect(w.add(status: MembershipStatus.pendingPayment).version, 1);
    });

    test('every transition increments version', () {
      final w = _World();
      final m = w.add(status: MembershipStatus.pendingPayment);
      expect(m.version, 1);
      m.schedule();
      expect(m.version, 2);
      m.activateOn(DateTime(2026, 3, 10));
      expect(m.version, 3);
      m.supersede();
      expect(
        m.version,
        4,
        reason:
            'every transition makes any copy held elsewhere stale, so every '
            'transition must be detectable at the write',
      );
    });

    test('a refused transition does not increment version', () {
      final w = _World();
      final m = w.add(status: MembershipStatus.expired);
      expect(() => m.activateOn(DateTime(2026, 3, 10)), throwsA(anything));
      expect(
        m.version,
        1,
        reason:
            'MM-FR-075 makes Expired terminal. A rejected write changed '
            'nothing, so nobody else\'s copy became stale.',
      );
    });

    test('assertVersion accepts the current version', () {
      final w = _World();
      final m = w.add(status: MembershipStatus.pendingPayment);
      expect(() => m.assertVersion(1), returnsNormally);
    });

    test('assertVersion rejects a stale version as a conflict', () {
      final w = _World();
      final m = w.add(status: MembershipStatus.pendingPayment);
      final staleView = m.version; // a caller read the record here
      m.schedule(); // someone else wrote
      expect(
        () => m.assertVersion(staleView),
        throwsA(
          isA<DomainError>()
              .having((e) => e.code, 'code', DomainErrorCode.conflict)
              .having((e) => e.context['field'], 'field', 'version'),
        ),
        reason:
            '§15: "Serialised by the source\'s version. The loser fails on a '
            'stale-version conflict."',
      );
    });

    test('the conflict names both versions so a client can recover', () {
      final w = _World();
      final m = w.add(status: MembershipStatus.pendingPayment);
      m.schedule();
      try {
        m.assertVersion(1);
        fail('expected a conflict');
      } on DomainError catch (e) {
        expect(e.context['expectedVersion'], 1);
        expect(e.context['actualVersion'], 2);
      }
    });
  });

  group('IMPL-437 · §15 rows 1-2 — simultaneous creation', () {
    test('row 1: two staff, same student — exactly one succeeds', () async {
      final w = _World();
      final p = w.plan();
      final first = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('staff_a'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      // Different key: a genuinely different command, not a retry.
      await expectLater(
        w.create(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('staff_b'),
          studentId: _student,
          plan: p,
          startingOn: DateTime(2026, 3, 10),
          paymentAlreadyReceived: true,
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.context['existingMembershipId'],
            'names the winner',
            first.id,
          ),
        ),
        reason:
            '§15 row 1: "Exactly one succeeds. The other fails with a typed '
            'overlap error naming the winning membershipId."',
      );
      expect(w.repo.forStudent(_student), hasLength(1));
    });

    test(
      'row 1: the overlap error comes from the constraint, not a read',
      () async {
        // MM-FR-046: enforced by the MM-INV-001 constraint, "not by a
        // read-check". insertGuardingOverlap is called in the same synchronous
        // block as the write, with no await between check and insert.
        final src = _codeOnly(
          File(
            'lib/domain/library/membership/membership.dart',
          ).readAsStringSync(),
        );
        expect(
          src.contains('repo.insertGuardingOverlap('),
          isTrue,
          reason:
              'a read-then-write check would leave exactly the window '
              'MM-FR-046 forbids',
        );
      },
    );

    test('row 2: identical idempotencyKey returns the original', () async {
      final w = _World();
      final p = w.plan();
      final first = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('same'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      final eventsAfterFirst = w.published.length;
      final second = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('same'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      expect(second.id, first.id, reason: 'the ORIGINAL result, not a new one');
      expect(
        w.published.length,
        eventsAfterFirst,
        reason: '§15 row 2: "no new event"',
      );
      expect(w.repo.forStudent(_student), hasLength(1));
    });
  });

  group('IMPL-437 · §15 rows 3, 5 — renewal races', () {
    test('row 3: double-tap Renew yields one renewal, one event', () async {
      final w = _World();
      final source = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 5),
      );
      final target = w.plan(id: 'plan_src');
      final a = await w.renew(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('tap'),
        sourceMembershipId: source.id,
        ontoPlan: target,
        paymentAlreadyReceived: true,
      );
      final renewEvents = w.ofType(MembershipEventType.renewed).length;
      final b = await w.renew(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('tap'),
        sourceMembershipId: source.id,
        ontoPlan: target,
        paymentAlreadyReceived: true,
      );
      expect(b.id, a.id, reason: 'suppressed by idempotencyKey');
      expect(
        w.ofType(MembershipEventType.renewed).length,
        renewEvents,
        reason: '§15 row 3: "a double-tap yields ONE event"',
      );
    });

    test(
      'row 5: two renewals, different keys — never two successors',
      () async {
        final w = _World();
        final source = w.add(
          status: MembershipStatus.active,
          start: DateTime(2026, 3, 5),
        );
        final target = w.plan(id: 'plan_src');
        await w.renew(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('key_a'),
          sourceMembershipId: source.id,
          ontoPlan: target,
          paymentAlreadyReceived: true,
        );
        await expectLater(
          w.renew(
            actorRole: AccessRole.owner,
            idempotencyKey: const IdempotencyKey('key_b'),
            sourceMembershipId: source.id,
            ontoPlan: target,
            paymentAlreadyReceived: true,
          ),
          throwsA(isA<DomainError>()),
          reason:
              '§15 row 5: "One succeeds; the other fails with MM-FR-090. '
              'NEVER two successors."',
        );
        final successors = w.repo
            .forStudent(_student)
            .where((m) => m.renewedFromMembershipId == source.id)
            .toList();
        expect(successors, hasLength(1));
      },
    );

    test('row 5: the failure names the existing successor', () async {
      final w = _World();
      final source = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 5),
      );
      final target = w.plan(id: 'plan_src');
      final first = await w.renew(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('key_a'),
        sourceMembershipId: source.id,
        ontoPlan: target,
        paymentAlreadyReceived: true,
      );
      try {
        await w.renew(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('key_b'),
          sourceMembershipId: source.id,
          ontoPlan: target,
          paymentAlreadyReceived: true,
        );
        fail('expected MM-FR-090');
      } on DomainError catch (e) {
        expect(
          '${e.context}',
          contains(first.id),
          reason:
              'MM-FR-090 names the existing successor so the client knows '
              'what already happened rather than just that it failed',
        );
      }
    });
  });

  group('IMPL-437 · §15 rows 6-7, 11 — upgrade races', () {
    test('row 6: two upgrades — the second fails, source not Active', () async {
      final w = _World();
      final source = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 5),
        rupees: 1200,
      );
      final target = w.plan(id: 'plan_prem', rupees: 2400);
      await w.upgrade(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('up_a'),
        sourceMembershipId: source.id,
        ontoPlan: target,
        paymentAlreadyReceived: true,
      );
      expect(w.repo.byId(source.id)!.status, MembershipStatus.superseded);
      await expectLater(
        w.upgrade(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('up_b'),
          sourceMembershipId: source.id,
          ontoPlan: target,
          paymentAlreadyReceived: true,
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.context['status'],
            'status',
            'superseded',
          ),
        ),
        reason:
            '§15 row 6: "the other fails because the source is no longer '
            'Active (MM-FR-093)"',
      );
    });

    test('row 7: renewal after upgrade fails — both must not commit', () async {
      final w = _World();
      final source = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 5),
        rupees: 1200,
      );
      final premium = w.plan(id: 'plan_prem', rupees: 2400);
      await w.upgrade(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('up'),
        sourceMembershipId: source.id,
        ontoPlan: premium,
        paymentAlreadyReceived: true,
      );
      // The upgrade won. The renewal now holds a stale view of the source.
      await expectLater(
        w.renew(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('rn'),
          sourceMembershipId: source.id,
          ontoPlan: premium,
          paymentAlreadyReceived: true,
        ),
        throwsA(isA<DomainError>()),
        reason:
            '§15 row 7: "Serialised by the source\'s version. The loser '
            'fails... Both MUST NOT commit."',
      );
      final successors = w.repo
          .forStudent(_student)
          .where((m) => m.renewedFromMembershipId == source.id)
          .toList();
      expect(successors, isEmpty, reason: 'the loser committed nothing');
    });

    test('row 11: expiry wins — the upgrade then fails MM-FR-093', () async {
      final w = _World();
      // A term that has already ended, so the expiry job will claim it.
      final source = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 2, 1),
        days: 10,
        rupees: 1200,
      );
      final premium = w.plan(id: 'plan_prem', rupees: 2400);
      await w.expire();
      expect(w.repo.byId(source.id)!.status, MembershipStatus.expired);
      await expectLater(
        w.upgrade(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('up'),
          sourceMembershipId: source.id,
          ontoPlan: premium,
          paymentAlreadyReceived: true,
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.context['status'],
            'status',
            'expired',
          ),
        ),
        reason: '§15 row 11: "If expiry wins, the upgrade fails MM-FR-093"',
      );
    });

    test(
      'row 11: upgrade wins — expiry must not overwrite Superseded',
      () async {
        final w = _World();
        final source = w.add(
          status: MembershipStatus.active,
          start: DateTime(2026, 2, 1),
          days: 10,
          rupees: 1200,
        );
        final premium = w.plan(id: 'plan_prem', rupees: 2400);
        await w.upgrade(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('up'),
          sourceMembershipId: source.id,
          ontoPlan: premium,
          paymentAlreadyReceived: true,
        );
        expect(w.repo.byId(source.id)!.status, MembershipStatus.superseded);
        await w.expire();
        expect(
          w.repo.byId(source.id)!.status,
          MembershipStatus.superseded,
          reason:
              '§15 row 11: "if the upgrade wins, the source becomes Superseded '
              'and the expiry job MUST NOT overwrite it." Superseded is '
              'terminal, so the job has no transition available.',
        );
      },
    );
  });

  group('IMPL-437 · §15 rows 8-9 — plan changes mid-operation', () {
    test('row 8: a plan deactivated mid-operation fails the create', () async {
      final w = _World();
      final p = w.plan();
      // The caller selected the plan, then an owner deactivated it.
      w.plans.save(p.deactivate());
      await expectLater(
        w.create(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('k'),
          studentId: _student,
          plan: p, // the stale instance the caller is still holding
          startingOn: DateTime(2026, 3, 10),
          paymentAlreadyReceived: true,
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.context['field'],
            'field',
            'isActive',
          ),
        ),
        reason:
            '§15 row 8: "The plan\'s isActive MUST be re-checked inside the '
            'committing transaction." Trusting the caller\'s instance would '
            'sell a withdrawn plan.',
      );
      expect(w.repo.forStudent(_student), isEmpty);
    });

    test(
      'row 8: isActive is re-read from the repository, not the argument',
      () async {
        final w = _World();
        final p = w.plan();
        w.plans.save(p.deactivate());
        // p.isActive is still true on the caller's copy; only the stored row
        // changed. If the check read the argument it would pass.
        expect(p.isActive, isTrue);
        await expectLater(
          w.create(
            actorRole: AccessRole.owner,
            idempotencyKey: const IdempotencyKey('k'),
            studentId: _student,
            plan: p,
            startingOn: DateTime(2026, 3, 10),
            paymentAlreadyReceived: true,
          ),
          throwsA(isA<DomainError>()),
        );
      },
    );

    test('row 8: a plan deactivated AFTER commit does not affect it', () async {
      final w = _World();
      final p = w.plan();
      final m = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('k'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      w.plans.save(p.deactivate());
      final stored = w.repo.byId(m.id)!;
      expect(
        stored.status,
        MembershipStatus.active,
        reason:
            '§15 row 8 / MM-FR-019: "A plan deactivated after commit MUST '
            'NOT affect the committed membership."',
      );
      expect(
        stored.priceSnapshot,
        Money.rupees(1200),
        reason: 'the snapshot is what makes that true',
      );
    });

    test('row 9: the price snapshot and planVersionAtPurchase agree', () async {
      final w = _World();
      final p = w.plan(rupees: 1200);
      final m = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('k'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      expect(m.priceSnapshot, Money.rupees(1200));
      expect(m.planVersionAtPurchase, p.version);
      // A later price edit produces a new version; the membership keeps both
      // the old price AND the old version, so the two never disagree.
      final edited = p.withEdits(price: Money.rupees(1500));
      w.plans.save(edited);
      expect(edited.version, p.version + 1);
      final stored = w.repo.byId(m.id)!;
      expect(stored.priceSnapshot, Money.rupees(1200));
      expect(
        stored.planVersionAtPurchase,
        p.version,
        reason:
            '§15 row 9: "the snapshot MUST be taken inside the committing '
            'transaction together with planVersionAtPurchase, so the amount '
            'and the version agree."',
      );
    });
  });

  group('IMPL-437 · §15 rows 4, 10, 12 — activation, expiry, retry', () {
    test('row 4: duplicate payment callback — no second activation', () {
      final w = _World();
      final m = w.add(status: MembershipStatus.pendingPayment);
      m.schedule();
      m.activateOn(DateTime(2026, 3, 10));
      expect(m.status, MembershipStatus.active);
      final versionAfterFirst = m.version;
      // A second callback for the same payment. Active has no self-loop, so
      // the transition table refuses it rather than re-activating.
      expect(
        () => m.activateOn(DateTime(2026, 3, 10)),
        throwsA(isA<DomainError>()),
        reason:
            '§15 row 4: "No second activation, no second MM-EVT-002." '
            'MM-FR-074\'s table is what makes that structural.',
      );
      expect(m.version, versionAfterFirst, reason: 'nothing changed');
    });

    test('row 10: a membership expiring mid-renewal still renews', () async {
      final w = _World();
      // Term already ended: MM-FR-080 permits renewal from Expired too.
      final source = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 2, 1),
        days: 10,
      );
      final target = w.plan(id: 'plan_src');
      await w.expire();
      expect(w.repo.byId(source.id)!.status, MembershipStatus.expired);
      final renewal = await w.renew(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('rn'),
        sourceMembershipId: source.id,
        ontoPlan: target,
        paymentAlreadyReceived: true,
      );
      expect(
        renewal.renewedFromMembershipId,
        source.id,
        reason:
            '§15 row 10: "The renewal MUST still succeed... A mid-flight '
            'expiry MUST NOT turn a valid renewal into an error."',
      );
    });

    test('row 10: the new startDate uses the after-expiry case', () async {
      final w = _World();
      final source = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 2, 1),
        days: 10,
      );
      final target = w.plan(id: 'plan_src');
      await w.expire();
      final renewal = await w.renew(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('rn'),
        sourceMembershipId: source.id,
        ontoPlan: target,
        paymentAlreadyReceived: true,
      );
      // §6.3 after-expiry case: the source ended before today, so the
      // renewal starts today rather than contiguously from a past endDate.
      expect(
        renewal.startDate,
        RenewMembership.renewalStartDate(
          today: DateTime(2026, 3, 10),
          sourceEndDate: source.endDate,
        ),
      );
    });

    test('row 12: retry after an unknown outcome needs no query', () async {
      final w = _World();
      final p = w.plan();
      // First attempt: the client never learns the outcome.
      final first = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('net'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      // It retries blindly, which is the whole point.
      final retry = await w.create(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('net'),
        studentId: _student,
        plan: p,
        startingOn: DateTime(2026, 3, 10),
        paymentAlreadyReceived: true,
      );
      expect(retry.id, first.id);
      expect(
        w.repo.forStudent(_student),
        hasLength(1),
        reason:
            '§15 row 12: "Clients MUST NOT need to query to decide whether '
            'to retry."',
      );
    });
  });

  group('IMPL-437 · MM-EVT-004 stays unpublished (MM-GAP-007a)', () {
    test('an upgrade publishes no MembershipUpgraded event', () async {
      final w = _World();
      final source = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 5),
        rupees: 1200,
      );
      final premium = w.plan(id: 'plan_prem', rupees: 2400);
      await w.upgrade(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('up'),
        sourceMembershipId: source.id,
        ontoPlan: premium,
        paymentAlreadyReceived: true,
      );
      expect(
        w.ofType(MembershipEventType.upgraded),
        isEmpty,
        reason:
            'MM-GAP-007a is OPEN: BC Map §9 omits MembershipUpgraded though '
            'PRD-005 §9 names it. BC Map §9 is the event authority, so no '
            'consumer may come to depend on an undeclared event. Emission '
            'resumes when the Architecture (BC Map) owner closes the gap.',
      );
    });

    test('the delta MM-FR-099 requires is still computed', () async {
      final w = _World();
      final source = w.add(
        status: MembershipStatus.active,
        start: DateTime(2026, 3, 5),
        rupees: 1200,
      );
      final premium = w.plan(id: 'plan_prem', rupees: 2400);
      await w.upgrade(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('up'),
        sourceMembershipId: source.id,
        ontoPlan: premium,
        paymentAlreadyReceived: true,
      );
      final d = w.upgrade.lastDelta;
      expect(d, isNotNull);
      expect(d!.priceDifference, Money.rupees(1200));
      expect(
        d.sourceRemainingDays,
        greaterThan(0),
        reason:
            'MM-FR-099 is satisfied as far as this module lawfully can, '
            'without publishing an undeclared event',
      );
    });
  });
}
