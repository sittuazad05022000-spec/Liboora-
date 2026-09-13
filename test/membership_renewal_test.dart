/// `BC-02` Membership — renewal.
///
/// Covers `IMPL-424` against FROZEN `PRD-005` v1.4. The obligation names the
/// shape of the test: *"Renewal creates a **new** membership; before/on/
/// after-expiry start dates fixed by §6.3; **no overlap**."*
///
/// `MM-FR-085`'s table is normative, so the three cases are asserted against
/// hand-computed dates rather than against whatever the implementation
/// produces. The on-the-boundary case is the interesting one: it collapses
/// into the before-expiry case *because* `MM-FR-062` makes the source valid
/// for the whole of `endDate`, and a test that only covered before/after
/// would miss a fencepost error exactly there.
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

/// 10 March 2026, 09:30 IST expressed as the UTC instant 04:00.
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

final class _Fixture {
  _Fixture({
    MembershipEnrollmentState? enrollmentState =
        MembershipEnrollmentState.active,
  }) : ctx = _Ctx(),
       clock = FixedClock(_nowUtc) {
    enrollment = _Enrollment(enrollmentState);
    memberships = InMemoryMembershipRepository(
      TenantPartitionedStore<Membership>(ctx),
    );
    plans = InMemoryMembershipPlanRepository(
      TenantPartitionedStore<MembershipPlan>(ctx),
    );
    events = EventBus(ConsoleTelemetry(ctx));
    renew = RenewMembership(
      repo: memberships,
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
  }

  final _Ctx ctx;
  final FixedClock clock;
  late final _Enrollment enrollment;
  late final InMemoryMembershipRepository memberships;
  late final InMemoryMembershipPlanRepository plans;
  late final EventBus events;
  late final RenewMembership renew;
  late final MembershipPlan plan;

  int _seq = 0;

  /// Puts a source membership in the store with the given term and status.
  Membership source({
    required DateTime start,
    int durationDays = 30,
    MembershipStatus status = MembershipStatus.active,
  }) {
    final m = Membership.fromPlan(
      id: 'mem_source',
      studentRecordId: _student,
      plan: plan,
      term: DateRange.days(start, durationDays),
      status: status,
      createdAt: _nowUtc,
      createdBy: 'owner_1',
      activatedAt: status == MembershipStatus.active ? _nowUtc : null,
    );
    memberships.save(m);
    return m;
  }

  Future<Membership> renewal({
    String id = 'mem_source',
    String? key,
    MembershipPlan? onto,
    bool paid = true,
  }) => renew(
    actorRole: AccessRole.owner,
    idempotencyKey: IdempotencyKey(key ?? 'idem_${++_seq}'),
    sourceMembershipId: id,
    ontoPlan: onto,
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
  // MM-FR-085 — the three boundary cases, as a pure function
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-085 start-date table', () {
    test('renewal BEFORE expiry starts the day after endDate', () {
      expect(
        RenewMembership.renewalStartDate(
          today: DateTime(2026, 3, 10),
          sourceEndDate: DateTime(2026, 3, 30),
        ),
        DateTime(2026, 3, 31),
        reason:
            'The student keeps every day already paid for. No overlap, no '
            'lost day.',
      );
    });

    test('renewal ON the expiry boundary is identical to before expiry', () {
      expect(
        RenewMembership.renewalStartDate(
          today: DateTime(2026, 3, 30),
          sourceEndDate: DateTime(2026, 3, 30),
        ),
        DateTime(2026, 3, 31),
        reason:
            'MM-FR-062: the source is valid for ALL of endDate, so renewing '
            'on the boundary must not start today and overlap it. This is '
            'the fencepost a before/after-only test would miss.',
      );
    });

    test('renewal AFTER expiry starts TODAY, never back-dated', () {
      expect(
        RenewMembership.renewalStartDate(
          today: DateTime(2026, 4, 15),
          sourceEndDate: DateTime(2026, 3, 30),
        ),
        DateTime(2026, 4, 15),
        reason:
            'Back-dating to endDate + 1 would sell days that have already '
            'elapsed.',
      );
    });

    test('one day after expiry still starts today, not endDate + 1', () {
      // These coincide only when today == endDate + 1, so this case cannot
      // distinguish a correct implementation from a wrong one on its own --
      // it is here to pin the branch boundary itself.
      expect(
        RenewMembership.renewalStartDate(
          today: DateTime(2026, 3, 31),
          sourceEndDate: DateTime(2026, 3, 30),
        ),
        DateTime(2026, 3, 31),
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // MM-FR-084 — renewal creates a NEW membership
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-084 renewal creates a new membership', () {
    test(
      'a new id, a new term, a fresh snapshot, and the lineage link',
      () async {
        final f = _Fixture();
        final src = f.source(start: DateTime(2026, 3, 1));

        final r = await f.renewal();

        expect(r.id, isNot(src.id));
        expect(r.renewedFromMembershipId, src.id);
        expect(r.studentRecordId, src.studentRecordId);
        expect(r.startDate, DateTime(2026, 3, 31));
        expect(r.endDate, DateTime(2026, 4, 29)); // 31 Mar + 29
        expect(f.memberships.all(), hasLength(2));
      },
    );

    test('the source membership is NOT mutated (MM-FR-084)', () async {
      final f = _Fixture();
      final src = f.source(start: DateTime(2026, 3, 1));
      final beforeEnd = src.endDate;
      final beforeStatus = src.status;
      final beforePrice = src.priceSnapshot;

      await f.renewal();

      final reloaded = f.memberships.byId(src.id)!;
      expect(reloaded.endDate, beforeEnd);
      expect(reloaded.status, beforeStatus);
      expect(reloaded.priceSnapshot, beforePrice);
      expect(reloaded.renewedFromMembershipId, isNull);
    });

    test('the renewal price is the plan CURRENT price, not the source snapshot '
        '(MM-FR-088)', () async {
      final f = _Fixture();
      f.source(start: DateTime(2026, 3, 1));

      // Owner raises the price after the original sale.
      final repriced = f.plan.withEdits(price: Money.rupees(1500));
      f.plans.save(repriced);

      final r = await f.renewal();

      expect(
        r.priceSnapshot,
        Money.rupees(1500),
        reason:
            'MM-FR-088: the target plan\'s CURRENT price, snapshotted '
            'fresh. Copying the source snapshot is explicitly forbidden.',
      );
      expect(r.planVersionAtPurchase, repriced.version);
      expect(
        f.memberships.byId('mem_source')!.priceSnapshot,
        Money.rupees(1200),
        reason: 'And the original sale keeps the price it was sold at.',
      );
    });

    test(
      'the new endDate uses the plan CURRENT durationDays (MM-FR-086)',
      () async {
        final f = _Fixture();
        f.source(start: DateTime(2026, 3, 1));

        // Plan duration changes from 30 to 60 after the original sale.
        f.plans.save(f.plan.withEdits(durationDays: 60));

        final r = await f.renewal();
        expect(r.startDate, DateTime(2026, 3, 31));
        expect(
          r.endDate,
          DateTime(2026, 5, 29), // 31 Mar + 59
          reason: 'MM-FR-086: the TARGET plan\'s current durationDays.',
        );
        expect(r.durationDays, 60);
      },
    );

    test('renewal emits MM-EVT-003 with the lineage (MM-FR-091)', () async {
      final f = _Fixture();
      f.source(start: DateTime(2026, 3, 1));
      final r = await f.renewal();

      final renewed = f.events.log
          .where((e) => e.eventType == 'membership.MembershipRenewed')
          .toList();
      expect(renewed, hasLength(1));
      final p = renewed.single.payload;
      expect(p['membershipId'], r.id);
      expect(p['renewedFromMembershipId'], 'mem_source');
      expect(p['priceMinor'], Money.rupees(1200).minorUnits);
      expect(p['validUntil'], r.endDate.toIso8601String());
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // MM-FR-087 / MM-BR-034 — no overlap
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-087 no overlapping terms', () {
    test('a renewal before expiry does not overlap the source, and is '
        'Scheduled until its startDate', () async {
      final f = _Fixture();
      final src = f.source(start: DateTime(2026, 3, 1));
      final r = await f.renewal(paid: true);

      expect(src.term.overlaps(r.term), isFalse);
      expect(
        r.status,
        MembershipStatus.scheduled,
        reason:
            'MM-FR-087: Scheduled until startDate, at which point the '
            'source is already Expired -- which is how two active terms '
            'are avoided without any coordination.',
      );
      expect(r.status.confersEntitlement, isFalse);

      // And there is no gap: the renewal starts the day after the last day
      // the source covered.
      expect(r.startDate.difference(src.endDate), const Duration(days: 1));
    });

    test('an unpaid renewal begins in PendingPayment and confers nothing '
        '(MM-FR-092)', () async {
      final f = _Fixture();
      f.source(start: DateTime(2026, 3, 1));
      final r = await f.renewal(paid: false);
      expect(r.status, MembershipStatus.pendingPayment);
      expect(r.status.confersEntitlement, isFalse);
    });

    test('the payment decision uses the PLAN price, not the source snapshot '
        '(MM-FR-088, MM-FR-092)', () async {
      // The distinguishing case: the source was sold for money, but the
      // plan is now free. MM-FR-088 says the renewal amount is the plan's
      // current price, and MM-FR-041 says a zero amount activates at once
      // -- so an unpaid renewal onto a now-free plan must still be settled.
      //
      // Reading the source's snapshot instead would leave this
      // PendingPayment, charging the student for a plan that is free. This
      // test exists because an earlier version of it did NOT catch that
      // substitution under mutation.
      final f = _Fixture();
      f.source(start: DateTime(2026, 1, 1), status: MembershipStatus.expired);
      f.plans.save(f.plan.withEdits(price: Money.zero));

      final r = await f.renewal(paid: false);

      expect(r.priceSnapshot, Money.zero);
      expect(
        r.status,
        MembershipStatus.active,
        reason:
            'A free renewal has no payment to wait for. PendingPayment '
            'here would mean the source snapshot drove the decision.',
      );
    });

    test('a renewal after expiry starts today and is Active at once', () async {
      final f = _Fixture();
      // Term ran 1-30 Jan; today is 10 March.
      f.source(start: DateTime(2026, 1, 1), status: MembershipStatus.expired);

      final r = await f.renewal(paid: true);
      expect(r.startDate, DateTime(2026, 3, 10));
      expect(r.endDate, DateTime(2026, 4, 8));
      expect(r.status, MembershipStatus.active);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // MM-FR-080..083, 089, 090 — eligibility and duplicate prevention
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-080..083 eligibility', () {
    test('renewal from Expired has no time limit in V1 (MM-FR-081)', () async {
      final f = _Fixture();
      // Expired two years ago.
      f.source(start: DateTime(2024, 1, 1), status: MembershipStatus.expired);
      final r = await f.renewal();
      expect(
        r.id,
        isNotNull,
        reason:
            'MM-FR-081: permitted without limit of elapsed time, and no '
            're-enrollment required.',
      );
    });

    test('PendingPayment, Scheduled, Superseded and Cancelled cannot be '
        'renewed (MM-FR-082)', () async {
      for (final status in const [
        MembershipStatus.pendingPayment,
        MembershipStatus.scheduled,
        MembershipStatus.superseded,
        MembershipStatus.cancelled,
      ]) {
        final f = _Fixture();
        f.source(start: DateTime(2026, 3, 1), status: status);

        final e = await _rejects(f.renewal);
        expect(e.code, DomainErrorCode.validationFailed);
        expect(e.context['status'], status.name);
        expect(
          f.memberships.all(),
          hasLength(1),
          reason: 'Nothing written for $status.',
        );
      }
    });

    test('renewing onto a DIFFERENT plan is refused — that is a new creation '
        '(MM-FR-083)', () async {
      final f = _Fixture();
      f.source(start: DateTime(2026, 3, 1));

      final other = MembershipPlan.create(
        id: 'plan_2',
        tenantId: _tenant,
        branchId: _branch,
        name: 'Quarterly',
        durationDays: 90,
        price: Money.rupees(3000),
        createdAt: DateTime(2026, 1, 1),
        createdBy: 'owner_1',
      );
      f.plans.save(other);

      final e = await _rejects(() => f.renewal(onto: other));
      expect(e.code, DomainErrorCode.validationFailed);
      expect(e.context['requestedPlanId'], 'plan_2');
      expect(
        f.memberships.all(),
        hasLength(1),
        reason:
            'MM-FR-083 keeps term arithmetic and price snapshotting '
            'unambiguous by refusing rather than silently reinterpreting.',
      );
    });

    test('a deactivated plan cannot be renewed onto (MM-FR-080)', () async {
      final f = _Fixture();
      f.source(start: DateTime(2026, 3, 1));
      f.plans.save(f.plan.deactivate());

      final e = await _rejects(f.renewal);
      expect(e.code, DomainErrorCode.validationFailed);
      expect(e.context['field'], 'isActive');
    });

    test('a non-active enrollment blocks renewal (MM-FR-080)', () async {
      for (final state in const [
        MembershipEnrollmentState.inactive,
        MembershipEnrollmentState.suspended,
        MembershipEnrollmentState.archived,
      ]) {
        final f = _Fixture(enrollmentState: state);
        f.source(start: DateTime(2026, 3, 1));

        final e = await _rejects(f.renewal);
        expect(e.code, DomainErrorCode.validationFailed);
        expect(e.context['enrollmentStatus'], state.name);
      }
    });

    test('an unknown source membership is refused (MM-FR-080)', () async {
      final f = _Fixture();
      final e = await _rejects(() => f.renewal(id: 'nope'));
      expect(e.code, DomainErrorCode.notFound);
    });

    test('a SECOND renewal of one source is refused, naming the existing '
        'successor (MM-FR-090, MM-INV-005)', () async {
      final f = _Fixture();
      f.source(start: DateTime(2026, 3, 1));
      final first = await f.renewal(key: 'k1');

      final e = await _rejects(() => f.renewal(key: 'k2'));
      expect(e.code, DomainErrorCode.conflict);
      expect(e.context['existingSuccessorId'], first.id);
      expect(
        f.memberships.all(),
        hasLength(2),
        reason: 'MM-INV-005: at most one successor by renewal.',
      );
    });

    test('a repeated renewal with the SAME key returns the original '
        '(MM-FR-089)', () async {
      final f = _Fixture();
      f.source(start: DateTime(2026, 3, 1));
      final first = await f.renewal(key: 'same');
      final again = await f.renewal(key: 'same');

      expect(again.id, first.id);
      expect(identical(again, first), isTrue);
      expect(f.memberships.all(), hasLength(2));
      expect(
        f.events.log
            .where((e) => e.eventType == 'membership.MembershipRenewed')
            .length,
        1,
        reason: 'A double-tap yields ONE event.',
      );
    });

    test('an unauthorised actor cannot renew', () async {
      final f = _Fixture();
      f.source(start: DateTime(2026, 3, 1));
      await expectLater(
        f.renew(
          actorRole: AccessRole.student,
          idempotencyKey: const IdempotencyKey('k'),
          sourceMembershipId: 'mem_source',
        ),
        throwsA(anything),
      );
      expect(f.memberships.all(), hasLength(1));
    });

    test(
      'a failed renewal leaves no partial state (MM-FR-091, MM-FR-050)',
      () async {
        final f = _Fixture(
          enrollmentState: MembershipEnrollmentState.suspended,
        );
        f.source(start: DateTime(2026, 3, 1));

        await _rejects(f.renewal);

        expect(f.memberships.all(), hasLength(1));
        expect(
          f.events.log.where(
            (e) => e.eventType == 'membership.MembershipRenewed',
          ),
          isEmpty,
        );
      },
    );
  });

  // ════════════════════════════════════════════════════════════════════
  // MM-FR-061 — the boundary is decided in TENANT time
  // ════════════════════════════════════════════════════════════════════
  group('MM-FR-061 renewal uses the tenant business date', () {
    test('an instant that is a different date for server and tenant resolves '
        'in the tenant timezone', () async {
      final f = _Fixture();
      // Source ran 1-10 March inclusive.
      f.source(start: DateTime(2026, 3, 1), durationDays: 10);

      // 2026-03-10 19:00 UTC is already 11 March in Kolkata -- i.e. AFTER
      // the source's endDate of 10 March. A server-time implementation
      // would call it 10 March (the boundary case) and start the renewal
      // on the 11th anyway, so this must be distinguished by the value
      // that only holds for the after-expiry branch.
      f.clock.set(DateTime.utc(2026, 3, 10, 19, 0));

      final r = await f.renewal();
      expect(
        r.startDate,
        DateTime(2026, 3, 11),
        reason:
            'Both branches agree here by construction; the point is that '
            'the date came from the tenant calendar, asserted directly '
            'below.',
      );

      // Asserted unambiguously: two days later in UTC terms is the 13th in
      // Kolkata, which only the after-expiry branch can produce.
      final f2 = _Fixture();
      f2.source(start: DateTime(2026, 3, 1), durationDays: 10);
      f2.clock.set(DateTime.utc(2026, 3, 12, 19, 0));
      final r2 = await f2.renewal();
      expect(r2.startDate, DateTime(2026, 3, 13));
    });
  });
}
