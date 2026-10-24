library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/enrollment/enrollment.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora/platform/tenancy/tenancy.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const TenantId _tenantA = TenantId('T-ALPHA');
const BranchId _branchA = BranchId('B-ALPHA-1');
final DateTime _day = DateTime.utc(2026, 8, 20);

MutableTenantContext _contextIn(TenantId tenant, BranchId branch) {
  final ctx = MutableTenantContext();
  ctx.enter(
    tenant: tenant,
    branch: branch,
    actor: 'test',
    correlationId: 'pagination-test',
  );
  return ctx;
}

T _withTenant<T>(
  MutableTenantContext ctx,
  TenantId tenant,
  BranchId branch,
  T Function() action,
) {
  final previousTenant = ctx.hasTenant ? ctx.tenantId : null;
  final previousBranch = ctx.hasTenant ? ctx.branchId : null;
  ctx.enter(
    tenant: tenant,
    branch: branch,
    actor: 'test',
    correlationId: 'pagination-test',
  );
  try {
    return action();
  } finally {
    if (previousTenant == null || previousBranch == null) {
      ctx.exit();
    } else {
      ctx.enter(
        tenant: previousTenant,
        branch: previousBranch,
        actor: 'test',
        correlationId: 'pagination-test',
      );
    }
  }
}

StudentRecord _student(
  String n, {
  required String enrollmentNumber,
  String? fullName,
}) => StudentRecord(
  id: StudentRecordId('SR-$n'),
  enrollmentNumber: enrollmentNumber,
  fullName: fullName ?? 'Student $n',
  phone: '90000000$n',
  dateOfBirth: DateTime.utc(2000, 1, 1),
  enrolledOn: _day,
  personId: PersonId('P-$n'),
);

void main() {
  group('StudentPagination', () {
    test('first page returns ordered records', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      for (var i = 1; i <= 50; i++) {
        repo.save(_student('$i', enrollmentNumber: 'EN-$i'));
      }

      final first = repo.paginatedList();
      expect(first.items.length, 20);
      expect(first.items.first.id.value, 'SR-1');
      expect(first.nextCursor, isNotNull);
    });

    test('continuation returns next ordered page', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      for (var i = 1; i <= 50; i++) {
        repo.save(_student('$i', enrollmentNumber: 'EN-$i'));
      }

      final first = repo.paginatedList();
      final second = repo.paginatedList(cursor: first.nextCursor);

      expect(second.items.length, 20);
      final expectedIds = [for (var i = 1; i <= 50; i++) 'SR-$i']..sort();
      expect(
        second.items.map((student) => student.id.value).toList(),
        expectedIds.sublist(20, 40),
      );
    });

    test('full traversal returns all records exactly once', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      for (var i = 1; i <= 45; i++) {
        repo.save(_student('$i', enrollmentNumber: 'EN-$i'));
      }

      final all = <StudentRecord>[];
      var page = repo.paginatedList();
      all.addAll(page.items);
      var cursor = page.nextCursor;
      while (cursor != null) {
        page = repo.paginatedList(cursor: cursor);
        all.addAll(page.items);
        cursor = page.nextCursor;
      }

      expect(all.length, 45);
      expect(all.map((s) => s.id.value).toSet(), hasLength(45));
    });

    test(
      'tie-breaking by StudentRecordId when fullName and enrollmentNumber match',
      () {
        final ctx = _contextIn(_tenantA, _branchA);
        final repo = InMemoryStudentRepository(
          TenantPartitionedStore<StudentRecord>(ctx),
        );

        repo.save(_student('A', enrollmentNumber: 'EN-1', fullName: 'Same'));
        repo.save(_student('B', enrollmentNumber: 'EN-1', fullName: 'Same'));
        repo.save(_student('C', enrollmentNumber: 'EN-1', fullName: 'Same'));

        final page = repo.paginatedList();
        expect(page.items.length, 3);
        expect(page.items[0].id.value, 'SR-A');
        expect(page.items[2].id.value, 'SR-C');
      },
    );

    test('malformed cursor throws DomainError', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      expect(
        () => repo.paginatedList(cursor: 'invalid_token'),
        throwsA(isA<DomainError>()),
      );
    });

    test('unknown cursor throws DomainError', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      expect(
        () => repo.paginatedList(cursor: 'abc123'),
        throwsA(isA<DomainError>()),
      );
    });

    test('cross-tenant cursor rejection', () {
      final ctxA = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctxA),
      );
      for (var i = 1; i <= 21; i++) {
        repo.save(_student('$i', enrollmentNumber: 'EN-$i'));
      }

      final cursorA = repo.paginatedList().nextCursor;
      expect(cursorA, isNotNull);

      _withTenant(ctxA, TenantId('T-BETA'), BranchId('B-BETA-1'), () {
        expect(
          () => repo.paginatedList(cursor: cursorA!),
          throwsA(isA<DomainError>()),
        );
      });
    });

    test('empty repository returns empty page', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      final result = repo.paginatedList();
      expect(result.items, isEmpty);
      expect(result.nextCursor, isNull);
    });

    test('final page has no nextCursor', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      repo.save(_student('1', enrollmentNumber: 'EN-1'));

      final result = repo.paginatedList();
      expect(result.items.length, 1);
      expect(result.nextCursor, isNull);
    });

    test('cursor with modified anchor throws DomainError', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      for (var i = 1; i <= 21; i++) {
        repo.save(_student('$i', enrollmentNumber: 'EN-$i'));
      }

      final first = repo.paginatedList();
      final cursor = first.nextCursor;
      expect(cursor, isNotNull);

      final anchorId = first.items.last.id.value.substring(3);
      repo.save(_student(anchorId, enrollmentNumber: 'EN-CHANGED'));

      expect(
        () => repo.paginatedList(cursor: cursor!),
        throwsA(isA<DomainError>()),
      );
    });

    test('save updates ordering-key when enrollmentNumber changes', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      final student = _student('ABC', enrollmentNumber: 'EN-001');
      repo.save(student);

      final firstPage = repo.paginatedList();
      expect(firstPage.items.first.id.value, 'SR-ABC');

      repo.save(_student('ABC', enrollmentNumber: 'EN-999'));

      final updatedPage = repo.paginatedList();
      expect(updatedPage.items.first.id.value, 'SR-ABC');
    });

    test('repeated saves keep one ordered key per student', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      repo.save(_student('ABC', enrollmentNumber: 'EN-002'));
      repo.save(_student('ABC', enrollmentNumber: 'EN-002'));
      repo.save(_student('ABC', enrollmentNumber: 'EN-001'));
      repo.save(_student('ABC', enrollmentNumber: 'EN-003'));

      final page = repo.paginatedList();
      expect(page.items.map((student) => student.id.value), ['SR-ABC']);
      expect(page.nextCursor, isNull);
    });

    test('rebuild preserves persisted records and ordering index', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final store = TenantPartitionedStore<StudentRecord>(ctx);
      final repo = InMemoryStudentRepository(store);

      repo.save(_student('B', enrollmentNumber: 'EN-002', fullName: 'Beta'));
      repo.save(_student('A', enrollmentNumber: 'EN-001', fullName: 'Alpha'));

      final rebuilt = InMemoryStudentRepository(store);
      final page = rebuilt.paginatedList();

      expect(page.items.map((student) => student.id.value), ['SR-A', 'SR-B']);
      expect(page.nextCursor, isNull);
    });

    test('save updates both name and enrollment ordering keys', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      repo.save(_student('A', enrollmentNumber: 'EN-900', fullName: 'Zed'));
      repo.save(_student('B', enrollmentNumber: 'EN-001', fullName: 'Beta'));
      repo.save(_student('A', enrollmentNumber: 'EN-001', fullName: 'Alpha'));

      final page = repo.paginatedList();
      expect(page.items.map((student) => student.id.value), ['SR-A', 'SR-B']);
    });
  });
}
