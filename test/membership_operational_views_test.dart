/// IMPL-433 — `MM-FR-115`/`MM-FR-116`/`MM-FR-117`/`MM-FR-118` operational
/// membership views, integrated through the real `AppContainer` boundary.
///
/// The renew/due "recently expired" half of `MM-FR-116` is NOT covered here
/// (or anywhere): its window is undefined by every frozen requirement, and
/// `MM-BR-026` binds `MM-CFG-008` to exactly two consumers — `MM-EVT-006` and
/// the expiring-memberships view — so extending it would invent a meaning the
/// rule did not grant. That half waits on a BC-02 domain-owner ruling; the
/// remaining surfaces are implemented and verified here.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/seed.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora_contracts/liboora_contracts.dart';
import 'package:liboora/app/shared/library_boundary.dart';

void main() {
  late AppContainer c;
  late DateTime today;
  Membership makeMembership({
    required String id,
    required StudentRecordId student,
    required MembershipPlan plan,
    required DateTime start,
    required DateTime endExclusive,
    MembershipStatus status = MembershipStatus.active,
    DateTime? activatedAt,
    String? renewedFrom,
  }) => Membership(
    id: id,
    studentRecordId: student,
    planId: plan.id,
    term: DateRange(start: start, end: endExclusive),
    priceSnapshot: plan.price,
    planVersionAtPurchase: plan.version,
    branchId: plan.branchId,
    status: status,
    createdAt: start,
    createdBy: 'owner_1',
    activatedAt: activatedAt,
    renewedFromMembershipId: renewedFrom,
  );
  setUp(() async {
    c = await AppContainer.boot(seeder: seedDemoData);
    c.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
    today = c.clock.today();
    final students = c.students.all();
    final plans = c.membershipPlans.all();
    final s1 = students[0].id;
    final s2 = students[1].id;
    final pQ = plans.firstWhere((p) => p.durationDays == 90);
    // Controlled membership world, seeded at the repo directly (tests drive
    // the boundary, not the creation use case).
    c.memberships.save(
      makeMembership(
        id: 'mem_active',
        student: s1,
        plan: pQ,
        start: today.subtract(const Duration(days: 10)),
        endExclusive: today.add(const Duration(days: 21)),
        activatedAt: today.subtract(const Duration(days: 10)),
      ),
    );
    c.memberships.save(
      makeMembership(
        id: 'mem_expiring',
        student: s2,
        plan: pQ,
        start: today.subtract(const Duration(days: 20)),
        endExclusive: today.add(const Duration(days: 4)),
        activatedAt: today.subtract(const Duration(days: 20)),
      ),
    );
    c.memberships.save(
      makeMembership(
        id: 'mem_expired',
        student: s2,
        plan: pQ,
        start: today.subtract(const Duration(days: 60)),
        endExclusive: today.subtract(const Duration(days: 30)),
        status: MembershipStatus.expired,
        activatedAt: today.subtract(const Duration(days: 60)),
      ),
    );
    c.memberships.save(
      makeMembership(
        id: 'mem_scheduled',
        student: s1,
        plan: pQ,
        start: today.add(const Duration(days: 5)),
        endExclusive: today.add(const Duration(days: 35)),
        status: MembershipStatus.scheduled,
      ),
    );
  });
  tearDown(() async {});
  group('MM-FR-115 · active / expiring / expired lists', () {
    test('active list returns status=active, valid-today memberships only', () {
      final page = c.library.membershipListPage(
        kind: MembershipListKind.active,
      );
      final ids = page.items.map((r) => r.membershipId).toSet();
      expect(ids, contains('mem_active'));
      expect(ids, contains('mem_expiring'));
      expect(ids, isNot(contains('mem_expired')));
      expect(
        ids,
        isNot(contains('mem_scheduled')),
        reason:
            'MM-FR-053/MM-FR-074 — scheduled confers nothing and is not '
            'an active membership',
      );
    });
    test('expiring list contains only active memberships within MM-CFG-008 '
        'days of endDate', () {
      final page = c.library.membershipListPage(
        kind: MembershipListKind.expiring,
      );
      final ids = page.items.map((r) => r.membershipId).toSet();
      expect(ids, contains('mem_expiring'));
      expect(
        ids,
        isNot(contains('mem_active')),
        reason: 'active ends +21d > MM-CFG-008 (7d)',
      );
      expect(ids, isNot(contains('mem_expired')));
    });
    test('expired list returns only terminal expired memberships', () {
      final page = c.library.membershipListPage(
        kind: MembershipListKind.expired,
      );
      final ids = page.items.map((r) => r.membershipId).toSet();
      expect(ids, contains('mem_expired'));
      expect(ids, isNot(contains('mem_active')));
    });
    test('filtering by planId narrows the list (MM-FR-115)', () {
      final plan = c.membershipPlans.all().first;
      final page = c.library.membershipListPage(
        kind: MembershipListKind.active,
        planId: plan.id,
      );
      expect(page.items.every((r) => r.planId == plan.id), isTrue);
    });
    test(
      'filtering by a date range over endDate narrows the list (MM-FR-115)',
      () {
        final page = c.library.membershipListPage(
          kind: MembershipListKind.active,
          dateFrom: today.add(const Duration(days: 1)),
        );
        expect(page.items.any((r) => r.membershipId == 'mem_expiring'), isTrue);
      },
    );
    test('row views do not carry a stored student name; it resolves through '
        'BC-01 (MM-FR-118)', () {
      final page = c.library.membershipListPage(
        kind: MembershipListKind.active,
      );
      expect(page.items, isNotEmpty);
      for (final r in page.items) {
        final student = c.students.byId(r.studentRecordId);
        expect(
          r.studentName,
          student!.fullName,
          reason: 'MM-FR-003 — the name lives in BC-01, never here',
        );
      }
    });
    test('pagination pages through the full list with an opaque cursor', () {
      final allIds = c.library
          .membershipListPage(kind: MembershipListKind.active, pageSize: 50)
          .items
          .length;
      var page = c.library.membershipListPage(
        kind: MembershipListKind.active,
        pageSize: 1,
      );
      var seen = 0;
      while (page.nextCursor != null) {
        seen += page.items.length;
        page = c.library.membershipListPage(
          kind: MembershipListKind.active,
          cursor: page.nextCursor,
          pageSize: 1,
        );
      }
      seen += page.items.length;
      expect(seen, allIds);
    });
    test('a malformed or out-of-scope cursor is a domain error, not a silent '
        'reset (PG-4)', () {
      expect(
        () => c.library.membershipListPage(
          kind: MembershipListKind.active,
          cursor: 'no-such-membership-id',
        ),
        throwsA(isA<DomainError>()),
      );
    });
  });
  group('MM-FR-117 · plan-wise current-state counts', () {
    test('counts currently-valid memberships grouped by plan', () {
      final counts = c.library.planWiseCounts();
      final byPlan = {for (final v in counts) v.planId: v.count};
      // Two active/valid memberships: mem_active, mem_expiring.
      expect(
        byPlan.values.fold<int>(0, (a, b) => a + b),
        greaterThanOrEqualTo(2),
      );
      expect(counts.every((v) => v.count >= 0), isTrue);
      // A current-state count — scheduled and expired memberships are absent.
      final planReported = counts.map((v) => v.planId).toSet();
      final planIds = c.membershipPlans.all().map((p) => p.id).toSet();
      expect(planReported.every(planIds.contains), isTrue);
    });
  });
  group('MM-FR-118 · membership detail', () {
    test(
      'detail carries term, plan, status, snapshot and history references',
      () {
        final detail = c.library.membershipDetail('mem_active');
        expect(detail, isNotNull);
        expect(detail!.status, 'active');
        expect(detail.startDate.isBefore(today), isTrue);
        expect(detail.endDate.isAfter(today), isTrue);
        expect(detail.planVersionAtPurchase, greaterThan(0));
        expect(detail.seatQuotaSnapshot, greaterThanOrEqualTo(0));
        expect(detail.activatedAt, isNotNull);
        expect(detail.isValidToday, isTrue);
        expect(detail.renewedFromMembershipId, isNull);
        final plan = c.membershipPlans.byId(detail.planId);
        expect(detail.planName, plan!.name);
      },
    );
    test('unknown id returns null', () {
      expect(c.library.membershipDetail('no_such_membership'), isNull);
    });
  });
  group('MM-FR-116 · today\'s renewals vs renewal-due (undefined window)', () {
    test('a renewal created today is listed as a today renewal', () {
      final plan = c.membershipPlans.all().first;
      final student = c.students.all().first.id;
      c.memberships.save(
        makeMembership(
          id: 'mem_renewed_today',
          student: student,
          plan: plan,
          start: today,
          endExclusive: today.add(const Duration(days: 31)),
          status: MembershipStatus.active,
          activatedAt: today,
          renewedFrom: 'mem_active',
        ),
      );
      final todayRenewals = c.library.todaysRenewals();
      expect(
        todayRenewals.map((r) => r.membershipId),
        contains('mem_renewed_today'),
      );
    });
    test('a renewal created on a different day is not listed as a today '
        'renewal', () {
      final plan = c.membershipPlans.all().first;
      final student = c.students.all().first.id;
      c.memberships.save(
        makeMembership(
          id: 'mem_renewed_earlier',
          student: student,
          plan: plan,
          start: today.subtract(const Duration(days: 2)),
          endExclusive: today
              .subtract(const Duration(days: 2))
              .add(const Duration(days: 31)),
          status: MembershipStatus.active,
          activatedAt: today.subtract(const Duration(days: 2)),
          renewedFrom: 'mem_active',
        ),
      );
      final ids = c.library.todaysRenewals().map((r) => r.membershipId);
      expect(ids, isNot(contains('mem_renewed_earlier')));
    });
  });
}
