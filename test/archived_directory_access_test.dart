/// IMPL-318 LMD-27 — archived-directory access is TR-1/TR-2 only, enforced at
/// the session gate.
///
/// The role check lives in `SessionController.studentsPage` (the app's single
/// sanctioned entry to the paginated roster), so this test drives it through a
/// real `AppContainer` with real issued sessions rather than calling the
/// boundary adapter directly — the adapter is unreachable from the UI, and the
/// session gate is the enforcement point the UI actually traverses.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/seed.dart';
import 'package:liboora/domain/library/enrollment/enrollment.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';
import 'package:liboora/app/shared/session.dart';

final DateTime _day = DateTime.utc(2026, 8, 20);

Account _account(String id, AccessRole role) => Account(
      id: AccountId(id),
      phone: '98100000$id',
      displayName: 'User $id',
      personId: PersonId('per_$id'),
      roles: {
        kDemoTenant.value: {role},
      },
    );

void main() {
  Future<SessionController> controllerFor(AccessRole role) async {
    final container = await AppContainer.boot();
    final account = _account('acc_${role.name}', role);
    container.auth.registerProvisionedAccount(account);
    final session = container.auth.issueSession(
      account: account,
      tenant: kDemoTenant,
      branch: kDemoBranch,
    );
    if (session == null) fail('issueSession refused the ${role.name} account');
    container.sessionStore.save(session);
    final controller = SessionController(container);
    expect(controller.isSignedIn, isTrue,
        reason: '${role.name} session must be live for this test');
    return controller;
  }

  test('TR-3 Reception cannot request archived records', () async {
    final controller = await controllerFor(AccessRole.reception);

    // The live roster is readable — the gate blocks the filter, not the read.
    final live = controller.studentsPage();
    expect(live.items, isEmpty);
    expect(live.nextCursor, isNull);

    expect(
      () => controller.studentsPage(includeArchived: true),
      throwsA(
        isA<DomainError>().having(
          (e) => e.code,
          'code',
          DomainErrorCode.authzNoRoleGrantsPermission,
        ),
      ),
    );
  });

  test('TR-1 Owner and TR-2 Manager may request archived records', () async {
    for (final role in [AccessRole.owner, AccessRole.manager]) {
      final controller = await controllerFor(role);

      final archived = StudentRecord(
        id: StudentRecordId('SR-ARC'),
        tenantId: kDemoTenant,
        enrollmentNumber: 'EN-002',
        fullName: 'Archived Student',
        phone: '9000000002',
        dateOfBirth: DateTime.utc(2000, 1, 1),
        enrolledOn: _day,
        registeredAt: _day,
        registrationSource: RegistrationSource.staffAssisted,
        personId: PersonId('per_arc'),
      );
      archived.status = EnrollmentStatus.archived;
      controller.container.students.save(archived);
      controller.container.students.save(
        StudentRecord(
          id: StudentRecordId('SR-LIVE'),
          tenantId: kDemoTenant,
          enrollmentNumber: 'EN-001',
          fullName: 'Live Student',
          phone: '9000000001',
          dateOfBirth: DateTime.utc(2000, 1, 1),
          enrolledOn: _day,
          registeredAt: _day,
          registrationSource: RegistrationSource.staffAssisted,
          personId: PersonId('per_live'),
        ),
      );

      final withArchived = controller.studentsPage(includeArchived: true);
      expect(withArchived.items.length, 2, reason: '$role');

      final live = controller.studentsPage();
      expect(live.items.length, 1, reason: '$role');
      expect(live.items.single.fullName, 'Live Student', reason: '$role');
    }
  });

  test('a signed-out session is the least-privileged role and is refused',
      () async {
    final container = await AppContainer.boot();
    final controller = SessionController(container);

    expect(controller.isSignedIn, isFalse);
    expect(controller.role, AccessRole.student);
    expect(
      () => controller.studentsPage(includeArchived: true),
      throwsA(isA<DomainError>()),
    );
  });

  test('LMD-25/LMD-26 the two statuses are independent and the expiry '
      'indicator follows the BC-02 projection with the configured threshold',
      () async {
    final controller = await controllerFor(AccessRole.owner);
    final container = controller.container;
    final pinned = DateTime.utc(2026, 3, 10, 4, 0);
    container.clock.pin(pinned);

    final plan = MembershipPlan.create(
      id: 'plan_exp',
      tenantId: kDemoTenant,
      branchId: kDemoBranch,
      name: 'Monthly',
      durationDays: 30,
      price: Money.rupees(1200),
      createdAt: pinned,
      createdBy: 'test',
      seatQuota: 1,
    );
    container.membershipPlans.save(plan);

    StudentRecord student(String n) => StudentRecord(
          id: StudentRecordId('SR-$n'),
          tenantId: kDemoTenant,
          enrollmentNumber: 'EN-$n',
          fullName: 'Student $n',
          phone: '90000000$n',
          dateOfBirth: DateTime.utc(2000, 1, 1),
          enrolledOn: _day,
          registeredAt: _day,
          registrationSource: RegistrationSource.staffAssisted,
          personId: PersonId('per_$n'),
        );
    final expiring = student('A');
    final safe = student('B');
    final expired = student('C');
    for (final s in [expiring, safe, expired]) {
      container.students.save(s);
    }

    void addMembership(StudentRecordId id, DateTime start, int seq) {
      container.memberships.save(
        Membership.fromPlan(
          id: 'mem_$seq',
          studentRecordId: id,
          plan: plan,
          term: DateRange.days(start, 30),
          status: MembershipStatus.active,
          createdAt: pinned,
          createdBy: 'test',
          activatedAt: pinned,
        ),
      );
    }

    // Clock: 10 March. A ends 15 March (5 days, inside SMCFG-3 = 7);
    // B ends 30 March (20 days); C expired on 30 January.
    addMembership(expiring.id, DateTime.utc(2026, 2, 14), 1);
    addMembership(safe.id, DateTime.utc(2026, 3, 1), 2);
    addMembership(expired.id, DateTime.utc(2026, 1, 1), 3);

    final page = controller.studentsPage();
    final byName = {for (final v in page.items) v.fullName: v};

    expect(byName['Student A']!.isExpiringSoon, isTrue,
        reason: '5 days remaining is within the SMCFG-3 threshold');
    expect(byName['Student B']!.isExpiringSoon, isFalse,
        reason: '20 days remaining is outside the threshold');
    expect(byName['Student C']!.isExpiringSoon, isFalse,
        reason: 'expired is not "expiring soon"');

    // LMD-25: enrollment status is BC-01's own state machine, independent of
    // the membership facts. All three students are enrollment-active while
    // their membership proximity differs — one indicator each, never merged.
    expect(byName.values.map((v) => v.enrollmentStatus), everyElement('active'));
  });
}
