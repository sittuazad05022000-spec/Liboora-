/// **Architecture test 6 of 7 — `tenant_isolation_test.dart`.**
///
/// Mandated by `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.3, whose requirement
/// cell reads verbatim:
///
/// > Cross-tenant leak suite — queries as tenant A must never return tenant B
/// > rows, for every repository
///
/// This is the highest-consequence test in the suite. A boundary violation is
/// a maintenance problem; a cross-tenant leak is a *breach*. One library seeing
/// another library's students, fees or attendance is unrecoverable trust
/// damage, and in India it is a personal-data incident involving minors.
///
/// ## "for every repository" — the scope is enumerated mechanically
///
/// The requirement says *every* repository, so this file does not hard-code a
/// list of six and hope. It scans `lib/` for every `implements *Repository`
/// declaration and asserts that each one is either exercised by a leak test
/// below or classified as a **deliberately global context** with the authority
/// line that makes it so. A new repository added tomorrow fails this file
/// until someone writes its leak test. That is the point.
///
/// ## The two-class tenancy model, and why an unqualified assertion is wrong
///
/// BC Map §11 defines two categorically different classes, and a test that
/// asserted "every repository partitions by tenant" would be **wrong**, not
/// merely strict:
///
/// > | BC-01→09 Library Management | **Tenant-scoped.** Every row carries
/// > `tenantId`. | Row-level security + mandatory `TenantContext` … A query
/// > without tenant predicate must fail at runtime, not silently return
/// > everything. |
/// > | BC-10 Global Person Identity | **Global.** No `tenantId`. Keyed on
/// > `PersonId`. Rank 7.5. | Must never receive a `StudentRecordId` or
/// > `tenantId` (rule `ID-2`). … **Asserted by cross-tenant leak tests** +
/// > `banned_symbols`. |
///
/// So BC-10's raw `Map` in `InMemoryPersonIdentityRepository` is **not** a
/// leak — it is mandatory. `tool/module_dependencies.yaml` L219–220 bans the
/// symbols `TenantId` and `TenantContext` from `domain/person` outright
/// ("nothing — this module is not tenant-scoped (SID-4.49)"). Partitioning it
/// would violate rule `ID-2`.
///
/// Note that BC Map §11 assigns the *cross-tenant leak tests* — this file —
/// responsibility for asserting BC-10's global property too. So this file
/// asserts isolation in **both directions**: tenant-scoped repositories must
/// partition, and the global identity repository must *not*. Each is a real
/// failure mode; each has its own group below.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/attendance/attendance.dart';
import 'package:liboora/domain/library/enrollment/enrollment.dart';
import 'package:liboora/domain/library/fee/fee.dart';
import 'package:liboora/domain/library/membership/membership.dart';
import 'package:liboora/domain/library/seating/seating.dart';
import 'package:liboora/domain/person/person.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora/platform/tenancy/tenancy.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const String _matrixPath =
    'docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md';
const String _bcMapPath =
    'docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md';
const String _manifestPath = 'tool/module_dependencies.yaml';

const TenantId _tenantA = TenantId('T-ALPHA');
const TenantId _tenantB = TenantId('T-BETA');
const BranchId _branchA = BranchId('B-ALPHA-1');
const BranchId _branchB = BranchId('B-BETA-1');

final DateTime _day = DateTime.utc(2026, 8, 20);

/// Repositories that are deliberately NOT tenant-partitioned, each with the
/// authority that makes it so. A name may only be added here with a citation
/// that this file then verifies still exists — see the test
/// 'every globally-scoped exemption cites live authority'.
const Map<String, String> _globalByDesign = {
  // BC-10. BC Map §11: "Global. No tenantId. Keyed on PersonId. Rank 7.5."
  'PersonIdentityRepository': 'BC-10 Global Person Identity',
};

/// Establishes an ambient tenant. `enter` is all-named and `correlationId` is
/// required — the tenancy platform refuses to produce an unattributable audit
/// line.
MutableTenantContext _contextIn(TenantId tenant, BranchId branch) {
  final ctx = MutableTenantContext();
  ctx.enter(
    tenant: tenant,
    branch: branch,
    actor: 'arch-test',
    correlationId: 'tenant-isolation-test',
  );
  return ctx;
}

/// Runs [action] with the context switched to [tenant], **then restores the
/// previous tenant**.
///
/// Switching a single shared context is the realistic shape of the bug this
/// suite hunts: a request boundary sets the tenant, and every repository built
/// on top must follow it. Two separate stores would prove nothing, because two
/// stores cannot leak into each other in the first place.
///
/// The restore is not cosmetic. The first draft of this helper entered the new
/// tenant and never returned, so every assertion written after a `_asTenant`
/// block was silently evaluated **as the wrong tenant** — five tests failed
/// and one (BC-03) *passed* only because both tenants held exactly one
/// symmetric row. A leak suite whose own scope handling is broken reports
/// findings about nothing. Restoring in a `finally` is what makes the
/// post-block assertions mean "read back as tenant A".
T _asTenant<T>(
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
    actor: 'arch-test',
    correlationId: 'tenant-isolation-test',
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
        actor: 'arch-test',
        correlationId: 'tenant-isolation-test',
      );
    }
  }
}

/// Source text with comments removed.
///
/// A naive `source.contains('TenantId')` scan matches `domain/person`'s own
/// doc comment, which *documents the prohibition*:
///
/// > It holds no `StudentRecordId` and no `TenantId`, so it *cannot* answer
/// > "which libraries does this person attend?"
///
/// Failing a module for explaining the rule it obeys is the checker punishing
/// good documentation. Only executable references count.
String _codeOnly(String source) {
  final withoutBlocks = source.replaceAll(
    RegExp(r'/\*.*?\*/', dotAll: true),
    '',
  );
  return withoutBlocks
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');
}

StudentRecord _student(String n, {required String enrollmentNumber}) =>
    StudentRecord(
      id: StudentRecordId('SR-$n'),
      enrollmentNumber: enrollmentNumber,
      fullName: 'Student $n',
      phone: '90000000$n',
      dateOfBirth: DateTime.utc(2000, 1, 1),
      enrolledOn: _day,
      personId: PersonId('P-$n'),
    );

Membership _membership(String n, StudentRecordId student) => Membership(
  id: 'M-$n',
  studentRecordId: student,
  plan: MembershipPlan(
    id: 'PLAN-$n',
    name: 'Plan $n',
    price: Money.rupees(1000),
    durationDays: 30,
    seatQuota: 1,
  ),
  term: DateRange.days(_day, 30),
);

/// Every `implements *Repository` class declared under `lib/`.
Set<String> _declaredRepositoryImplementations() {
  final found = <String>{};
  for (final entity in Directory('lib').listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    final matches = RegExp(
      r'implements\s+([A-Za-z0-9_,\s]+?)\s*\{',
    ).allMatches(entity.readAsStringSync());
    for (final m in matches) {
      for (final raw in m.group(1)!.split(',')) {
        final name = raw.trim();
        if (name.endsWith('Repository')) found.add(name);
      }
    }
  }
  return found;
}

void main() {
  // ════════════════════════════════════════════════════════════════════
  // The obligation, and the scope it covers.
  // ════════════════════════════════════════════════════════════════════
  group('the leak suite obligation and its enumerated scope', () {
    test('Matrix §10.3 still requires this test, for EVERY repository', () {
      final matrix = File(_matrixPath).readAsStringSync();
      expect(
        matrix,
        contains('tenant_isolation_test.dart'),
        reason: 'Matrix §10.3 no longer names this file. If the requirement '
            'was withdrawn, that is an authority amendment (ADR), not a '
            'silent test deletion.',
      );
      expect(
        matrix,
        contains('for every repository'),
        reason: 'The §10.3 requirement cell has been narrowed from "for every '
            'repository". Verify against the current wording before '
            'reducing this suite.',
      );
    });

    test('every repository in lib/ is either leak-tested here or cited as '
        'globally scoped', () {
      final declared = _declaredRepositoryImplementations();

      // Vacuity guard. If the scan breaks, "all repositories are covered"
      // becomes trivially true and this test stops meaning anything.
      expect(
        declared,
        isNotEmpty,
        reason: 'Parsed zero repository implementations from lib/. The scan '
            'is broken; coverage below is not evidence of anything.',
      );

      // The tenant-scoped repositories exercised by the groups below.
      const leakTested = {
        'StudentRepository',
        'MembershipRepository',
        'AttendanceRepository',
        'SeatLayoutRepository',
        'SeatAllocationRepository',
        'FeeLedgerRepository',
      };

      final uncovered = declared
          .difference(leakTested)
          .difference(_globalByDesign.keys.toSet())
          .toList()
        ..sort();

      expect(
        uncovered,
        isEmpty,
        reason:
            'These repositories exist in lib/ but no cross-tenant leak test '
            'covers them, and they are not declared globally scoped: '
            '$uncovered.\n'
            'Matrix §10.3 requires the leak suite to cover EVERY repository. '
            'Add a leak test to this file, or — only with a BC Map §11 '
            'citation — add the name to _globalByDesign.',
      );

      // Reverse direction: a name listed as leak-tested that no longer exists
      // means this file is asserting against a deleted class and quietly
      // shrinking in scope.
      final stale = leakTested.difference(declared).toList()..sort();
      expect(
        stale,
        isEmpty,
        reason: 'This file claims to leak-test $stale, but no such repository '
            'is implemented in lib/ any more. Remove the stale entry and its '
            'test, or restore the repository.',
      );
    });

    test('every globally-scoped exemption cites live authority', () {
      final bcMap = File(_bcMapPath).readAsStringSync();
      final manifest = File(_manifestPath).readAsStringSync();

      expect(_globalByDesign, isNotEmpty);

      for (final entry in _globalByDesign.entries) {
        // BC Map §11 must still classify this context as Global.
        final line = bcMap
            .split('\n')
            .where((l) => l.contains(entry.value))
            .where((l) => l.contains('Global'))
            .toList();
        expect(
          line,
          isNotEmpty,
          reason:
              '${entry.key} is exempted from tenant partitioning on the '
              'grounds that ${entry.value} is a global context, but BC Map '
              '§11 no longer says so. An exemption whose authority has been '
              'withdrawn is a leak waiting to happen.',
        );
      }

      // The manifest must still ban tenant symbols from domain/person. If that
      // ban were lifted, BC-10 would become partitionable and this exemption
      // would need re-examining rather than inheriting.
      expect(
        manifest,
        contains('this module is not tenant-scoped'),
        reason: 'tool/module_dependencies.yaml no longer bans TenantId / '
            'TenantContext from domain/person. Rule ID-2 may have changed; '
            're-derive the BC-10 exemption before trusting it.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // BC-01→09: a query as tenant A must never return a tenant B row.
  // ════════════════════════════════════════════════════════════════════
  group('tenant-scoped repositories never return another tenant\'s rows', () {
    test('BC-01 Enrollment — byId, all and the uniqueness probe are all '
        'scoped', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      final a = _student('1', enrollmentNumber: 'EN-100');
      // Deliberately the SAME enrollment number in tenant B. Enrollment
      // numbers are unique *within* a library, not across the platform; if
      // the probe were global, tenant B could not issue EN-100 at all, and
      // tenant A would learn that tenant B had used it.
      final b = _student('2', enrollmentNumber: 'EN-100');

      repo.save(a);
      _asTenant(ctx, _tenantB, _branchB, () => repo.save(b));

      // Read back as A.
      expect(repo.all().map((s) => s.id.value), ['SR-1']);
      expect(repo.byId(StudentRecordId('SR-2')), isNull,
          reason: 'Tenant A resolved tenant B\'s student by id. This is a '
              'cross-tenant read of personal data.');
      expect(repo.byId(StudentRecordId('SR-1')), isNotNull);

      // And as B.
      _asTenant(ctx, _tenantB, _branchB, () {
        expect(repo.all().map((s) => s.id.value), ['SR-2']);
        expect(repo.byId(StudentRecordId('SR-1')), isNull);
        return null;
      });

      // The uniqueness probe must answer per tenant, not globally.
      expect(repo.enrollmentNumberExists('EN-100'), isTrue);
      _asTenant(ctx, _tenantB, _branchB, () {
        expect(repo.enrollmentNumberExists('EN-100'), isTrue);
        return null;
      });
      expect(repo.enrollmentNumberExists('EN-999'), isFalse);
    });

    test('BC-02 Membership — forStudent, byId and all are scoped', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryMembershipRepository(
        TenantPartitionedStore<Membership>(ctx),
      );

      // Same StudentRecordId value in both tenants. Ids are tenant-scoped, so
      // collision is legal and is precisely the dangerous case: a global
      // lookup would fuse two different people.
      final shared = StudentRecordId('SR-SHARED');
      repo.save(_membership('A', shared));
      _asTenant(ctx, _tenantB, _branchB, () => repo.save(_membership('B', shared)));

      expect(repo.forStudent(shared).map((m) => m.id), ['M-A'],
          reason: 'Tenant A saw tenant B\'s membership because both tenants '
              'use the same student id value.');
      expect(repo.byId('M-B'), isNull);
      expect(repo.all().length, 1);

      _asTenant(ctx, _tenantB, _branchB, () {
        expect(repo.forStudent(shared).map((m) => m.id), ['M-B']);
        expect(repo.byId('M-A'), isNull);
        return null;
      });
    });

    test('BC-03 Attendance — find, onDate and forStudent are scoped', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryAttendanceRepository(
        TenantPartitionedStore<AttendanceDay>(ctx),
      );

      final shared = StudentRecordId('SR-SHARED');
      repo.save(AttendanceDay(studentRecordId: shared, date: _day));

      // ASYMMETRY IS DELIBERATE. Tenant B gets TWO rows, tenant A one.
      // An earlier version of this test gave each tenant exactly one row, and
      // it PASSED even while the test's own scope handling was broken —
      // `length == 1` is true whichever tenant you are accidentally reading.
      // Equal counts cannot distinguish "correctly partitioned" from
      // "reading the wrong partition". Unequal counts can.
      _asTenant(ctx, _tenantB, _branchB, () {
        repo.save(AttendanceDay(studentRecordId: shared, date: _day));
        repo.save(
          AttendanceDay(
            studentRecordId: StudentRecordId('SR-OTHER'),
            date: _day,
          ),
        );
        return null;
      });

      // The composite key is student#date and is identical in both tenants —
      // the store's partitioning is the ONLY thing keeping these apart.
      expect(repo.onDate(_day).length, 1,
          reason: 'A daily attendance report for tenant A included tenant B '
              'rows. This leaks who was physically present in another '
              'library.');
      expect(repo.forStudent(shared).length, 1);
      expect(repo.find(shared, _day), isNotNull);
      expect(repo.find(StudentRecordId('SR-OTHER'), _day), isNull,
          reason: 'Tenant A resolved an attendance row belonging only to '
              'tenant B.');

      _asTenant(ctx, _tenantB, _branchB, () {
        expect(repo.onDate(_day).length, 2);
        expect(repo.find(StudentRecordId('SR-OTHER'), _day), isNotNull);
        return null;
      });
    });

    test('BC-04 Seating — layouts and allocations are scoped', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final layouts = InMemorySeatLayoutRepository(
        TenantPartitionedStore<SeatLayout>(ctx),
      );
      final allocations = InMemorySeatAllocationRepository(
        TenantPartitionedStore<SeatAllocation>(ctx),
      );

      // Same branch id value in two tenants: legal, and the reason a layout
      // lookup must not be global.
      final branch = BranchId('B-1');
      layouts.save(
        SeatLayout(
          branchId: branch,
          seats: [const Seat(id: 'S-1', label: 'A1', zone: 'Ground')],
        ),
      );
      _asTenant(
        ctx,
        _tenantB,
        _branchB,
        () => layouts.save(
          SeatLayout(
            branchId: branch,
            seats: [const Seat(id: 'S-9', label: 'Z9', zone: 'Loft')],
          ),
        ),
      );

      expect(layouts.forBranch(branch)!.byId('S-1'), isNotNull);
      expect(layouts.forBranch(branch)!.byId('S-9'), isNull,
          reason: 'Tenant A read tenant B\'s seat layout for the same branch '
              'id value.');

      allocations.save(
        SeatAllocation(
          id: 'AL-A',
          seatId: 'S-1',
          seatLabel: 'A1',
          studentRecordId: StudentRecordId('SR-1'),
          window: DateRange.days(_day, 30),
          allocatedOn: _day,
        ),
      );
      _asTenant(
        ctx,
        _tenantB,
        _branchB,
        () => allocations.save(
          SeatAllocation(
            id: 'AL-B',
            seatId: 'S-1', // same seat id — different physical seat
            seatLabel: 'A1',
            studentRecordId: StudentRecordId('SR-2'),
            window: DateRange.days(_day, 30),
            allocatedOn: _day,
          ),
        ),
      );

      // forSeat feeds the overlap invariant. If it returned another tenant's
      // allocations, tenant A would be *blocked* from assigning its own seat
      // by an invisible booking in another library — a leak that manifests as
      // a false conflict rather than as visible data.
      expect(allocations.forSeat('S-1').map((a) => a.id), ['AL-A'],
          reason: 'forSeat crossed the tenant boundary. The seat-overlap '
              'invariant would then be evaluated against foreign rows.');
      expect(allocations.activeOn(_day).length, 1);
      expect(allocations.byId('AL-B'), isNull);
      expect(allocations.all().length, 1);
    });

    test('BC-05 Fee — ledger lookup and openFor are scoped', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryFeeLedgerRepository(
        TenantPartitionedStore<FeeLedger>(ctx),
      );

      final shared = StudentRecordId('SR-SHARED');
      final ledgerA = repo.openFor(shared);
      ledgerA.raiseDue(
        FeeDue(
          id: 'D-A',
          description: 'Tenant A monthly',
          amount: Money.rupees(1200),
          raisedOn: _day,
          dueOn: _day,
        ),
      );
      repo.save(ledgerA);

      // openFor in tenant B must MINT A NEW ledger, not adopt tenant A's.
      _asTenant(ctx, _tenantB, _branchB, () {
        final ledgerB = repo.openFor(shared);
        expect(
          ledgerB.totalDue.isZero,
          isTrue,
          reason: 'openFor in tenant B returned a ledger already carrying '
              'tenant A\'s dues. Financial records crossed the boundary.',
        );
        expect(repo.forStudent(shared)!.totalDue.isZero, isTrue);
        return null;
      });

      expect(repo.forStudent(shared)!.totalDue, Money.rupees(1200));
      expect(repo.all().length, 1);
    });

    test('a tenant-scoped count never equals the global count when a second '
        'tenant holds rows', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final store = TenantPartitionedStore<StudentRecord>(ctx);
      final repo = InMemoryStudentRepository(store);

      repo.save(_student('1', enrollmentNumber: 'EN-1'));
      repo.save(_student('2', enrollmentNumber: 'EN-2'));
      _asTenant(
        ctx,
        _tenantB,
        _branchB,
        () => repo.save(_student('3', enrollmentNumber: 'EN-3')),
      );

      // This is the assertion the store's own doc comment was written for:
      // "Test-only: total rows across all tenants. Used by the cross-tenant
      // leak suite to assert that a tenant-scoped query never sees the global
      // count."
      expect(store.countAcrossAllTenants, 3);
      expect(store.count, 2);
      expect(
        store.count,
        lessThan(store.countAcrossAllTenants),
        reason: 'A tenant-scoped count returned the platform-wide total. '
            'Tenant A can now infer the size of other libraries.',
      );
      expect(repo.all().length, 2);
    });

    test('a repository access with NO tenant in scope fails loudly rather '
        'than returning everything', () {
      // BC Map §11: "A query without tenant predicate must fail at runtime,
      // not silently return everything." A silent empty list is almost as
      // dangerous as a silent full list — it hides the wiring bug.
      final ctx = MutableTenantContext(); // never entered
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );

      expect(
        () => repo.all(),
        throwsA(isA<TenantContextMissing>()),
        reason: 'A tenant-less read did not throw. Whether it returned [] or '
            'everything, the caller cannot tell that the tenant boundary '
            'was never established.',
      );
      expect(
        () => repo.save(_student('1', enrollmentNumber: 'EN-1')),
        throwsA(isA<TenantContextMissing>()),
        reason: 'A tenant-less WRITE did not throw. This is how an '
            'unattributable row is created.',
      );
    });

    test('exiting the tenant scope revokes access rather than retaining the '
        'last tenant', () {
      final ctx = _contextIn(_tenantA, _branchA);
      final repo = InMemoryStudentRepository(
        TenantPartitionedStore<StudentRecord>(ctx),
      );
      repo.save(_student('1', enrollmentNumber: 'EN-1'));
      expect(repo.all().length, 1);

      ctx.exit();

      // A stale ambient tenant surviving a scope exit is the classic
      // request-recycling leak: the next request inherits the previous
      // tenant's scope.
      expect(
        () => repo.all(),
        throwsA(isA<TenantContextMissing>()),
        reason: 'After exit(), the repository still resolved a tenant. A '
            'recycled request would inherit the previous tenant\'s data.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // BC-10: the inverse property. Global by design, asserted as such.
  // ════════════════════════════════════════════════════════════════════
  group('BC-10 Global Person Identity is global by design, not leaking', () {
    test('the identity repository resolves the same person regardless of any '
        'ambient tenant', () {
      // Per BC Map §11 and manifest rule ID-2, this repository takes no
      // TenantContext at all — it cannot be constructed with one. The identity
      // of a person does not change because they walked into a different
      // library, and a person is NOT re-created per tenant.
      final repo = InMemoryPersonIdentityRepository();
      final personId = PersonId('P-1');
      repo.save(
        PersonIdentity(
          personId: personId,
          accountId: AccountId('ACC-1'),
          createdAt: _day,
          displayName: 'Aarav',
        ),
      );

      // Deliberately mutate an ambient tenant context around the reads. It
      // must make no difference — that is the property.
      final ctx = _contextIn(_tenantA, _branchA);
      expect(repo.byPersonId(personId), isNotNull);
      _asTenant(ctx, _tenantB, _branchB, () {
        expect(repo.byPersonId(personId), isNotNull,
            reason: 'The Global Person Identity became invisible under a '
                'different tenant. Partitioning BC-10 violates rule ID-2 and '
                'would fork one human into many.');
        expect(repo.resolve(personId)!.displayName, 'Aarav');
        return null;
      });
      ctx.exit();
      expect(repo.byPersonId(personId), isNotNull,
          reason: 'The identity became unreadable with no tenant in scope. '
              'BC-10 is pre-authentication-capable and must not require a '
              'tenant.');
      expect(repo.count, 1);
    });

    test('the identity aggregate carries no tenant or student identifier', () {
      // Rule ID-2, asserted structurally on the real object rather than by
      // reading the manifest. The ACL (E-13) is one-directional: Enrollment
      // holds a personId; the identity holds no way back.
      final repo = InMemoryPersonIdentityRepository();
      repo.save(
        PersonIdentity(
          personId: PersonId('P-1'),
          accountId: AccountId('ACC-1'),
          createdAt: _day,
          displayName: 'Aarav',
        ),
      );

      final fields = repo.resolve(PersonId('P-1'))!;
      expect(fields.personId.value, 'P-1');

      // NOTE on an assertion deliberately NOT made here. The first draft
      // asserted `fields.toString().contains('T-') == false`. That is
      // **vacuous**: IdentityCoreFields does not override toString(), so the
      // value is always "Instance of 'IdentityCoreFields'" and the assertion
      // can never fail regardless of what the class holds. It was measured and
      // removed rather than left in as decorative coverage. The structural
      // scan below is the real check.
      final code = _codeOnly(
        File('lib/domain/person/person.dart').readAsStringSync(),
      );

      // Vacuity guard for the scan itself: if _codeOnly ever strips
      // everything, "no banned symbol found" becomes meaningless.
      expect(
        code,
        contains('class PersonIdentity'),
        reason: 'The comment-stripping scan removed the actual source. The '
            'banned-symbol assertions below would pass vacuously.',
      );

      for (final banned in ['TenantId', 'TenantContext', 'StudentRecordId']) {
        expect(
          code.contains(banned),
          isFalse,
          reason:
              'domain/person has an executable reference to $banned. Rule '
              'ID-2 forbids a tenant or operational identifier entering the '
              'global identity context; the manifest bans the symbol '
              'outright ("nothing — this module is not tenant-scoped").\n'
              'Doc-comment mentions are excluded — the module documents the '
              'prohibition it obeys, and that must not be penalised.',
        );
      }
    });
  });
}
