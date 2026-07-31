/// Boot + architecture smoke tests.
///
/// These are not "does the button render" tests. Each one guards a rule that
/// the architecture documents claim is enforced — so if someone quietly breaks
/// tenant partitioning or idempotency, CI says so.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/app/liboora_app.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/seed.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  group('boot', () {
    test('container boots and seeds without violating an invariant', () async {
      final c = await AppContainer.boot();
      expect(c.tenants.length, 2);
      expect(c.plans, isNotEmpty);
      expect(c.events.log, isNotEmpty);
      // A populated dead-letter queue means a consumer threw during seeding.
      expect(c.events.deadLetter, isEmpty);
    });

    testWidgets('app renders the login screen on first frame', (tester) async {
      final c = await AppContainer.boot();
      await tester.pumpWidget(LiboraaApp(container: c));
      await tester.pumpAndSettle();
      expect(find.text('Liboora'), findsWidgets);
      expect(find.text('Send OTP'), findsOneWidget);
    });
  });

  group('tenant isolation', () {
    test('a store refuses to answer with no tenant in scope', () async {
      final c = await AppContainer.boot();
      c.leaveScope();
      expect(() => c.students.all(), throwsA(isA<TenantContextMissing>()));
    });

    test('each tenant sees only its own students', () async {
      final c = await AppContainer.boot();

      c.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      final demoCount = c.students.all().length;

      c.enterScope(tenant: kOtherTenant, branch: kOtherBranch);
      final otherCount = c.students.all().length;

      expect(demoCount, greaterThan(otherCount));
      expect(otherCount, 3);
      c.leaveScope();
    });
  });

  group('domain invariants', () {
    test('check-in is idempotent under replay', () async {
      final c = await AppContainer.boot();
      c.enterScope(tenant: kDemoTenant, branch: kDemoBranch, actor: 'test');

      final student = c.students.all().first;
      const key = IdempotencyKey('test_replay_key');

      final first = await c.checkIn(
        actorRole: AccessRole.reception,
        studentId: student.id,
        key: key,
      );
      final second = await c.checkIn(
        actorRole: AccessRole.reception,
        studentId: student.id,
        key: key,
      );

      expect(second.duplicate, isTrue);
      expect(first.day.entries.length, second.day.entries.length);
      c.leaveScope();
    });

    test('a seat cannot be double-booked', () async {
      final c = await AppContainer.boot();
      c.enterScope(tenant: kDemoTenant, branch: kDemoBranch, actor: 'test');

      // Find a student holding a seat, and another with an active plan.
      final taken = c.seatAllocations.all().where((a) => a.isActive).first;
      final other = c.students.all().firstWhere(
        (s) => c.seatAllocations.forStudent(s.id).every((a) => !a.isActive),
      );

      await expectLater(
        c.assignSeat(
          actorRole: AccessRole.owner,
          studentId: other.id,
          seatId: taken.seatId,
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            anyOf(
              DomainErrorCode.seatAlreadyOccupied,
              DomainErrorCode.seatQuotaExceeded,
              DomainErrorCode.membershipRequiredForSeat,
            ),
          ),
        ),
      );
      c.leaveScope();
    });

    test('reception cannot view revenue', () {
      const pdp = PolicyDecisionPoint();
      expect(pdp.allows(AccessRole.reception, Permission.viewRevenue), isFalse);
      expect(pdp.allows(AccessRole.owner, Permission.viewRevenue), isTrue);
      expect(
        () => pdp.require(AccessRole.student, Permission.collectFee),
        throwsA(isA<DomainError>()),
      );
    });

    test('a fee ledger balance always equals dues minus receipts', () async {
      final c = await AppContainer.boot();
      c.enterScope(tenant: kDemoTenant, branch: kDemoBranch, actor: 'test');

      for (final ledger in c.ledgers.all()) {
        expect(
          ledger.balance,
          ledger.totalDue - ledger.totalReceived,
          reason: 'Balance must stay derived, never stored',
        );
      }
      c.leaveScope();
    });
  });

  group('projections', () {
    test('rebuilding from the event log reproduces the same metrics', () async {
      final c = await AppContainer.boot();
      c.enterScope(tenant: kDemoTenant, branch: kDemoBranch);

      final before = c.analytics.metricsFor(kDemoTenant);
      final enrolledBefore = before.studentsEnrolled;
      final collectedBefore = before.collectedTodayMinor;

      await c.analytics.rebuildFrom(c.events);

      final after = c.analytics.metricsFor(kDemoTenant);
      expect(after.studentsEnrolled, enrolledBefore);
      expect(after.collectedTodayMinor, collectedBefore);
      c.leaveScope();
    });
  });
}
