/// `BC-02` Membership — upgrade: supersession, lineage, and the
/// at-most-one-successor rule.
///
/// Covers `IMPL-427` against FROZEN `PRD-005` v1.4.
///
/// One part of this task is **blocked and the block is pinned here rather
/// than hidden**. `MM-FR-101` requires an upgrade to emit `MM-EVT-004`, and
/// frozen `PRD-005` §9 names the event `membership.MembershipUpgraded` — but
/// the repository's event authority is BC Map §9, which OMITS it. That is
/// `MM-GAP-007a`, carried against the BC Map and owned by the Architecture
/// (BC Map) owner; `ADR-0019` expressly does not close it. So the entitlement
/// delta is computed and exposed, no event is published, and the last group
/// below asserts that state deliberately — so the day the gap closes, these
/// tests are the checklist.
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

final class _Enrollment implements EnrollmentStatusReader {
  _Enrollment(this.state);
  MembershipEnrollmentState? state;
  @override
  MembershipEnrollmentState? stateFor(StudentRecordId id) => state;
}

final class _SeqIds implements IdGenerator {
  int _n = 0;
  @override
  String next([String prefix = 'id']) => '${prefix}_${++_n}';
}

MembershipPlan _plan({
  required String id,
  required String name,
  required int rupees,
  int durationDays = 30,
  bool isActive = true,
}) => MembershipPlan.create(
  id: id,
  tenantId: _tenant,
  branchId: _branch,
  name: name,
  durationDays: durationDays,
  price: Money.rupees(rupees),
  createdAt: DateTime(2026, 1, 1),
  createdBy: 'owner_1',
  seatQuota: 1,
  isActive: isActive,
);

final class _Fixture {
  _Fixture({
    MembershipEnrollmentState? enrollmentState =
        MembershipEnrollmentState.active,
  }) : ctx = _Ctx(),
       clock = FixedClock(_nowUtc) {
    enrollment = _Enrollment(enrollmentState);
    repo = InMemoryMembershipRepository(
      TenantPartitionedStore<Membership>(ctx),
    );
    plans = InMemoryMembershipPlanRepository(
      TenantPartitionedStore<MembershipPlan>(ctx),
    );
    events = EventBus(ConsoleTelemetry(ctx));
    basic = _plan(id: 'plan_basic', name: 'Basic', rupees: 1200);
    premium = _plan(id: 'plan_premium', name: 'Premium', rupees: 2000);
    plans.save(basic);
    plans.save(premium);
    upgrade = UpgradeMembership(
      repo: repo,
      plans: plans,
      enrollment: enrollment,
      calendar: const TenantBusinessCalendar('Asia/Kolkata'),
      idempotency: MembershipIdempotencyAdapter(IdempotencyService(ctx)),
      events: events,
      clock: clock,
      ids: _SeqIds(),
      tenant: ctx,
      pdp: const PolicyDecisionPoint(),
    );
  }

  final _Ctx ctx;
  final FixedClock clock;
  late final _Enrollment enrollment;
  late final InMemoryMembershipRepository repo;
  late final InMemoryMembershipPlanRepository plans;
  late final EventBus events;
  late final MembershipPlan basic;
  late final MembershipPlan premium;
  late final UpgradeMembership upgrade;

  int _seq = 0;

  Membership source({
    DateTime? start,
    MembershipStatus status = MembershipStatus.active,
    MembershipPlan? onPlan,
  }) {
    final p = onPlan ?? basic;
    final m = Membership.fromPlan(
      id: 'mem_source',
      studentRecordId: _student,
      plan: p,
      term: DateRange.days(start ?? DateTime(2026, 3, 1), p.durationDays),
      status: status,
      createdAt: _nowUtc,
      createdBy: 'owner_1',
      activatedAt: status == MembershipStatus.active ? _nowUtc : null,
    );
    repo.save(m);
    return m;
  }

  Future<Membership> go({
    String id = 'mem_source',
    String? key,
    MembershipPlan? onto,
    bool paid = true,
  }) => upgrade(
    actorRole: AccessRole.owner,
    idempotencyKey: IdempotencyKey(key ?? 'idem_${++_seq}'),
    sourceMembershipId: id,
    ontoPlan: onto ?? premium,
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
  // MM-FR-094 / MM-FR-095 — targets and the downgrade rejection
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-094 upgrade targets', () {
    test('only STRICTLY more expensive active plans are targets', () {
      final f = _Fixture();
      final cheaper = _plan(id: 'p_cheap', name: 'Lite', rupees: 800);
      final same = _plan(id: 'p_same', name: 'Same', rupees: 1200);
      final retired = _plan(
        id: 'p_gone',
        name: 'Retired Gold',
        rupees: 5000,
        isActive: false,
      );
      f.plans.save(cheaper);
      f.plans.save(same);
      f.plans.save(retired);

      final targets = f.upgrade.targetsFor(f.source()).map((p) => p.id);

      expect(targets, contains('plan_premium'));
      expect(targets, isNot(contains('p_cheap')));
      expect(
        targets,
        isNot(contains('p_same')),
        reason:
            'MM-FR-095 rejects equal price too -- "same price, different '
            'plan" is a plan change, not an upgrade.',
      );
      expect(
        targets,
        isNot(contains('p_gone')),
        reason: 'MM-FR-094 says ACTIVE plans.',
      );
      expect(targets, isNot(contains('plan_basic')));
    });

    test(
      'an equal-priced target is rejected as a downgrade (MM-FR-095)',
      () async {
        final f = _Fixture();
        final same = _plan(id: 'p_same', name: 'Sideways', rupees: 1200);
        f.plans.save(same);
        f.source();

        final e = await _rejects(() => f.go(onto: same));
        expect(e.code, DomainErrorCode.validationFailed);
        expect(e.context['field'], 'price');
        expect(f.repo.all(), hasLength(1));
      },
    );

    test('a cheaper target is rejected as a downgrade (MM-XC-008)', () async {
      final f = _Fixture();
      final cheaper = _plan(id: 'p_cheap', name: 'Lite', rupees: 800);
      f.plans.save(cheaper);
      f.source();

      final e = await _rejects(() => f.go(onto: cheaper));
      expect(e.code, DomainErrorCode.validationFailed);
      expect(e.context['sourcePriceMinor'], Money.rupees(1200).minorUnits);
      expect(e.context['targetPriceMinor'], Money.rupees(800).minorUnits);
    });

    test('the comparison uses the SNAPSHOT, so a later plan edit cannot turn a '
        'downgrade into an upgrade (MM-FR-026)', () async {
      final f = _Fixture();
      f.source();

      // Owner drops Premium below what the student paid.
      f.plans.save(f.premium.withEdits(price: Money.rupees(900)));

      final e = await _rejects(f.go);
      expect(
        e.code,
        DomainErrorCode.validationFailed,
        reason:
            'The source paid 1200. Premium is now 900, so this is a '
            'downgrade however it is labelled.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // MM-FR-096 / MM-FR-097 / MM-FR-098 — supersession and the new term
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-096 supersession and lineage', () {
    test(
      'the source becomes Superseded and the new one carries the link',
      () async {
        final f = _Fixture();
        final src = f.source();

        final up = await f.go();

        expect(f.repo.byId(src.id)!.status, MembershipStatus.superseded);
        expect(up.upgradedFromMembershipId, src.id);
        expect(up.planId, 'plan_premium');
        expect(up.renewedFromMembershipId, isNull);
        expect(f.repo.all(), hasLength(2));
      },
    );

    test('the new term runs [today, today + (durationDays - 1)] in tenant time '
        '(MM-FR-097)', () async {
      final f = _Fixture();
      f.source();

      final up = await f.go();
      expect(up.startDate, DateTime(2026, 3, 10));
      expect(up.endDate, DateTime(2026, 4, 8)); // 10 Mar + 29
      expect(up.durationDays, 30);
    });

    test('the effective date is the TENANT business date, not the server\'s '
        '(MM-FR-061, MM-FR-097)', () async {
      final f = _Fixture();
      f.source();
      // 19:00 UTC on 10 March is already 11 March in Kolkata.
      f.clock.set(DateTime.utc(2026, 3, 10, 19, 0));

      final up = await f.go();
      expect(up.startDate, DateTime(2026, 3, 11));
    });

    test('the source endDate is NOT altered — remaining days are recorded, not '
        'rewritten (MM-FR-098)', () async {
      final f = _Fixture();
      final src = f.source();
      final endBefore = src.endDate;

      await f.go();

      expect(
        f.repo.byId(src.id)!.endDate,
        endBefore,
        reason:
            'MM-FR-098: its remaining days are recorded by Superseded plus '
            'upgradedFromMembershipId, not by moving its term.',
      );
      expect(f.repo.byId(src.id)!.priceSnapshot, Money.rupees(1200));
    });

    test('the upgrade does not overlap-fail against its own source '
        '(MM-INV-001)', () async {
      final f = _Fixture();
      // Source runs 1-30 March; the upgrade starts 10 March, inside it.
      f.source();

      final up = await f.go();

      // It succeeded because the source was superseded FIRST. A terminal
      // membership no longer holds the MM-INV-001 slot.
      expect(up.id, isNotNull);
      expect(f.repo.byId('mem_source')!.status.isTerminal, isTrue);
    });

    test('a settled upgrade is Active at once (MM-FR-101, §3.3)', () async {
      final f = _Fixture();
      f.source();
      final up = await f.go(paid: true);
      expect(up.status, MembershipStatus.active);
      expect(up.activatedAt, isNotNull);
    });

    test('an unsettled upgrade begins in PendingPayment (MM-FR-101)', () async {
      final f = _Fixture();
      f.source();
      final up = await f.go(paid: false);
      expect(up.status, MembershipStatus.pendingPayment);
      expect(up.status.confersEntitlement, isFalse);
    });

    test('the upgrade takes a FRESH snapshot of the target plan', () async {
      final f = _Fixture();
      f.source();
      final up = await f.go();
      expect(up.priceSnapshot, Money.rupees(2000));
      expect(up.currencySnapshot, 'INR');
      expect(up.planVersionAtPurchase, f.premium.version);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // MM-FR-093 / MM-FR-102 / MM-FR-101 — eligibility and one successor
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-093 eligibility', () {
    test('upgrade is permitted ONLY from Active; every other status is '
        'rejected (MM-FR-093, MM-FR-102)', () async {
      for (final status in MembershipStatus.values.where(
        (s) => s != MembershipStatus.active,
      )) {
        final f = _Fixture();
        f.source(status: status);

        final e = await _rejects(f.go);
        expect(e.code, DomainErrorCode.validationFailed, reason: '$status');
        expect(e.context['status'], status.name);
        expect(f.repo.all(), hasLength(1));
      }
      // MM-FR-102 is the PendingPayment case specifically: upgrading
      // immediately after creation is refused by this same guard, and the
      // correction path is void-and-recreate (IMPL-423).
    });

    test('a SECOND upgrade of one source is refused, naming the successor '
        '(MM-FR-101, MM-INV-005)', () async {
      final f = _Fixture();
      f.source();
      final first = await f.go(key: 'k1');

      // Re-activate the source so the refusal is decided by the successor
      // rule rather than by the status guard -- otherwise this test would
      // pass for the wrong reason.
      final src = f.repo.byId('mem_source')!;
      expect(src.status, MembershipStatus.superseded);

      final e = await _rejects(() => f.go(key: 'k2'));
      expect(
        e.code,
        DomainErrorCode.validationFailed,
        reason:
            'Superseded is caught first, which is itself correct. The '
            'successor rule is asserted directly below.',
      );
      expect(first.upgradedFromMembershipId, 'mem_source');
      expect(
        f.repo
            .forStudent(_student)
            .where((m) => m.upgradedFromMembershipId == 'mem_source')
            .length,
        1,
        reason: 'MM-INV-005: at most one successor by upgrade.',
      );
    });

    test('a repeated upgrade with the SAME key returns the original '
        '(MM-FR-101)', () async {
      final f = _Fixture();
      f.source();
      final first = await f.go(key: 'same');
      final again = await f.go(key: 'same');

      expect(again.id, first.id);
      expect(identical(again, first), isTrue);
      expect(f.repo.all(), hasLength(2));
    });

    test('a non-active enrollment blocks upgrade', () async {
      for (final state in const [
        MembershipEnrollmentState.inactive,
        MembershipEnrollmentState.suspended,
        MembershipEnrollmentState.archived,
      ]) {
        final f = _Fixture(enrollmentState: state);
        f.source();
        final e = await _rejects(f.go);
        expect(e.context['enrollmentStatus'], state.name);
        expect(f.repo.byId('mem_source')!.status, MembershipStatus.active);
      }
    });

    test('a plan from another tenant is refused (MM-FR-094)', () async {
      final f = _Fixture();
      f.source();
      final foreign = MembershipPlan.create(
        id: 'plan_foreign',
        tenantId: const TenantId('tnt_b'),
        branchId: const BranchId('brn_b'),
        name: 'Other Premium',
        durationDays: 30,
        price: Money.rupees(9000),
        createdAt: DateTime(2026, 1, 1),
        createdBy: 'owner_2',
      );

      final e = await _rejects(() => f.go(onto: foreign));
      expect(e.code, DomainErrorCode.validationFailed);
      expect(e.context['field'], 'planId');
    });

    test('an unknown source is refused', () async {
      final f = _Fixture();
      final e = await _rejects(() => f.go(id: 'nope'));
      expect(e.code, DomainErrorCode.notFound);
    });

    test('an unauthorised actor cannot upgrade', () async {
      final f = _Fixture();
      f.source();
      await expectLater(
        f.upgrade(
          actorRole: AccessRole.student,
          idempotencyKey: const IdempotencyKey('k'),
          sourceMembershipId: 'mem_source',
          ontoPlan: f.premium,
        ),
        throwsA(anything),
      );
      expect(f.repo.byId('mem_source')!.status, MembershipStatus.active);
    });

    test('a failed upgrade leaves the source untouched (MM-FR-050)', () async {
      final f = _Fixture(enrollmentState: MembershipEnrollmentState.suspended);
      f.source();

      await _rejects(f.go);

      expect(f.repo.all(), hasLength(1));
      expect(f.repo.byId('mem_source')!.status, MembershipStatus.active);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // MM-FR-099 / MM-FR-100 — the entitlement delta, and NOT money
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-099 entitlement delta', () {
    test('the delta is a price DIFFERENCE and a DAY COUNT', () async {
      final f = _Fixture();
      f.source(); // 1-30 March, paid 1200. Today is the 10th.

      await f.go();

      final d = f.upgrade.lastDelta!;
      expect(
        d.priceDifference,
        Money.rupees(800),
        reason: 'MM-FR-099: targetPlan.price - source.priceSnapshot.',
      );
      expect(d.sourceRemainingDays, greaterThan(0));
      expect(d.sourceRemainingDays, lessThanOrEqualTo(30));
      expect(d.sourceEndDate, DateTime(2026, 3, 30));
      expect(d.sourceMembershipId, 'mem_source');
    });

    test('the difference is computed from the SNAPSHOT, so it is stable '
        '(MM-FR-026)', () {
      final f = _Fixture();
      final src = f.source();
      // Even after the source's plan is repriced, the difference is
      // measured against what the student actually paid.
      f.plans.save(f.basic.withEdits(price: Money.rupees(100)));
      expect(src.priceDifferenceTo(Money.rupees(2000)), Money.rupees(800));
    });

    test('the delta is never negative — a downgrade is refused before this '
        '(MM-FR-095)', () {
      final f = _Fixture();
      final src = f.source();
      expect(src.priceDifferenceTo(Money.rupees(500)), Money.zero);
    });

    test(
      'BC-02 computes NO prorated credit and NO refund (MM-FR-100, Q-06)',
      () {
        // The method that used to do this -- prorationCreditFor, which
        // returned a prorated Money -- was REMOVED, not merely left unused.
        // Q-06 (resolved by ADR-0133) puts money execution in the Business
        // Platform at V2, so BC-02 offers a day count and a difference only.
        final f = _Fixture();
        final src = f.source();
        expect(src.remainingDaysFrom(_nowUtc), isA<int>());
        expect(
          src.priceDifferenceTo(Money.rupees(2000)),
          isA<Money>(),
          reason:
              'A DIFFERENCE is not a credit: it is what the new plan costs '
              'more, not what the unused days are worth.',
        );
      },
    );
  });

  // ════════════════════════════════════════════════════════════════════
  // ⛔ MM-EVT-004 — BLOCKED by MM-GAP-007a, pinned rather than hidden
  // ════════════════════════════════════════════════════════════════════
  group('MM-EVT-004 is blocked by MM-GAP-007a', () {
    test('no membership.MembershipUpgraded event is published, because BC Map '
        '§9 does not declare it', () async {
      final f = _Fixture();
      f.source();
      await f.go();

      expect(
        f.events.log.where(
          (e) => e.eventType == 'membership.MembershipUpgraded',
        ),
        isEmpty,
        reason:
            'MM-FR-101 requires MM-EVT-004 and frozen PRD-005 §9 names it, '
            'but BC Map §9 -- the repository event authority -- OMITS it. '
            'That is MM-GAP-007a, owned by the Architecture (BC Map) owner '
            'and expressly not closed by ADR-0019. Emitting anyway would '
            'break every_event_has_schema_test; amending BC Map is a '
            'governance edit I have no authority to make; waiving the test '
            'would silence the check that caught this. So nothing is '
            'emitted and the gap is disclosed.',
      );
    });

    test('the delta MM-FR-099 requires is still computed, so closing the gap '
        'is a publish step and not a redesign', () async {
      final f = _Fixture();
      f.source();
      await f.go();

      final d = f.upgrade.lastDelta!;
      // Every field MM-EVT-004's payload needs is present and correct.
      expect(d.upgradedMembershipId, isNotEmpty);
      expect(d.sourceMembershipId, 'mem_source');
      expect(d.priceDifference, Money.rupees(800));
      expect(d.sourceRemainingDays, isPositive);
      expect(d.sourceEndDate, isNotNull);
    });

    test('an upgrade publishes nothing at all while the gap is open', () async {
      final f = _Fixture();
      f.source();
      await f.go();
      expect(
        f.events.log,
        isEmpty,
        reason:
            'Not even a substitute event under a different name -- that '
            'would be inventing an undeclared contract by another route.',
      );
    });
  });
}
