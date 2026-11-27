// IMPL-313 — `LCFG-5` Member Directory configuration gating.
//
// Pins the frozen contract: `LMD-4` (exposure gated by `LCFG-5`, default
// Disabled, `AP-3`), `LMD-5`/`LIB-16.6` (disabling suppresses exposure
// without deleting any record), `LMD-6` (typed accessor, never a raw string
// lookup) and `LMD-10` (`SMCFG-1` default page size, `SMCFG-2` maximum).
//
// The gate sits on the Session facade — the surface the UI binds through —
// and answers *suppressed* (empty roster, empty page, null lookup) without
// touching the repository, so suppression structurally cannot delete data.
// The composition-root port (`c.studentDirectory`) stays ungated and is what
// these tests read to prove the records survived.
import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/app/shared/session.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  Future<StudentRecordId> enrollStudent(
    AppContainer into,
    String name,
    String phone,
  ) async {
    final (personId, accountId) = into.provisionIdentityForEnrollment(
      phone: phone,
      displayName: name,
      dateOfBirth: DateTime(2000, 1, 1),
    );
    final student = await into.enrollStudent(
      actorRole: AccessRole.owner,
      idempotencyKey: IdempotencyKey('test_gate_$phone'),
      accountId: accountId,
      fullName: name,
      phone: phone,
      personId: personId,
    );
    return student.id;
  }

  group('DefaultStudentDirectoryConfig — frozen defaults', () {
    test('LCFG-5 defaults to Disabled (AP-3, deny by default)', () {
      const config = DefaultStudentDirectoryConfig();
      expect(config.memberDirectoryEnabled, isFalse);
    });

    test('SMCFG-1 = 20 and SMCFG-2 = 50, verbatim (PRD-004 §10.3)', () {
      const config = DefaultStudentDirectoryConfig();
      expect(config.directoryDefaultPageSize, 20);
      expect(config.directoryMaxPageSize, 50);
    });

    test('defaults sit inside their published ranges (LMD-10)', () {
      const config = DefaultStudentDirectoryConfig();
      expect(config.directoryDefaultPageSize, inInclusiveRange(5, 50));
      expect(config.directoryMaxPageSize, inInclusiveRange(10, 100));
    });
  });

  group('LCFG-5 gating on the Session facade', () {
    late AppContainer c;
    late SessionController session;

    setUp(() async {
      c = await AppContainer.boot();
      c.enterScope(
        tenant: const TenantId('t_test'),
        branch: const BranchId('b_test'),
        actor: 'tester',
      );
      session = SessionController(c);
    });

    test(
      'default-disabled suppresses the three directory reads (LMD-4)',
      () async {
        final id = await enrollStudent(c, 'Asha Verma', '9000000001');

        expect(session.directoryEnabled, isFalse);
        expect(session.students, isEmpty);

        final page = session.studentsPage();
        expect(page.items, isEmpty);
        expect(page.nextCursor, isNull);

        expect(session.studentById(id), isNull);
      },
    );

    test(
      'suppression deletes nothing — records survive intact (LIB-16.6, LMD-5)',
      () async {
        final id = await enrollStudent(c, 'Bilal Khan', '9000000002');

        // The facade answers suppressed…
        expect(session.students, isEmpty);
        expect(session.studentById(id), isNull);

        // …while the composition-root port still holds the record, and the
        // ungated operational reads keep answering.
        expect(c.studentDirectory.byId(id), isNotNull);
        expect(c.studentDirectory.all(), hasLength(1));
        expect(session.validityOf(id), isNotNull);
      },
    );

    test('enrollment still works while the directory is disabled', () async {
      final id = await enrollStudent(c, 'Chitra Rao', '9000000003');
      expect(c.studentDirectory.byId(id), isNotNull);
      expect(session.students, isEmpty);
    });

    test(
      'enabling LCFG-5 restores the same reads — the LIB-16.6 inverse',
      () async {
        final enabled = await AppContainer.boot(
          directoryConfig: const DefaultStudentDirectoryConfig(
            memberDirectoryEnabled: true,
          ),
        );
        addTearDown(enabled.leaveScope);
        enabled.enterScope(
          tenant: const TenantId('t_test'),
          branch: const BranchId('b_test'),
          actor: 'tester',
        );
        final on = SessionController(enabled);

        final id = await enrollStudent(enabled, 'Dinesh Patel', '9000000004');
        expect(on.directoryEnabled, isTrue);
        expect(on.students.map((s) => s.id), contains(id));
        expect(on.studentsPage().items, isNotEmpty);
        expect(on.studentById(id)?.fullName, 'Dinesh Patel');
      },
    );

    test(
      'when enabled, pagination semantics are unchanged (PG-1..PG-4)',
      () async {
        final enabled = await AppContainer.boot(
          directoryConfig: const DefaultStudentDirectoryConfig(
            memberDirectoryEnabled: true,
          ),
        );
        addTearDown(enabled.leaveScope);
        enabled.enterScope(
          tenant: const TenantId('t_test'),
          branch: const BranchId('b_test'),
          actor: 'tester',
        );
        final on = SessionController(enabled);
        await enrollStudent(enabled, 'Eshwar Iyer', '9000000005');

        final page = on.studentsPage();
        expect(page.items, hasLength(1));
        expect(page.nextCursor, isNull); // fewer than one page

        // PG-4: a malformed cursor is refused, never silently reset.
        expect(
          () => on.studentsPage(cursor: 'garbage'),
          throwsA(isA<DomainError>()),
        );
      },
    );
  });
}
