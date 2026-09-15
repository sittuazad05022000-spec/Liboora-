/// `IMPL-800` + `IMPL-801` — BC-19's ownership boundary, proven mechanically.
///
/// **What these tests are for.** The two tasks carry one acceptance test each,
/// and both are *structural* rather than behavioural:
///
///  * `IMPL-800` (`TEN-FR-001`, `TEN-FR-003`) — *"Structural: no
///    tenant-facing business record other than `Tenant` is representable in
///    this module."*
///  * `IMPL-801` (`TEN-FR-004`) — *"A second aggregate root is not
///    constructible in this module — compile-level, not convention."*
///
/// ⚠ **Why source inspection and not object construction.** Both criteria are
/// about what the module *can represent*, not about what a value does at
/// runtime. A behavioural test cannot observe the absence of a type: if
/// `Branch` came back tomorrow, every runtime assertion here would still pass.
/// So these read `tenancy.dart` and assert on its declarations, which is the
/// same instrument `every_event_has_schema_test.dart` and
/// `no_orphan_ports_test.dart` already use in this repository.
///
/// ⛔ **Deliberately NOT tested here** — each belongs to a later task and
/// testing it now would claim work that has not been done:
/// `TEN-FR-005`/`IMPL-802` (the four value objects), `TEN-INV-001`/`IMPL-807`
/// (ID immutability), `TEN-INV-002`/`IMPL-808` (residency immutability),
/// `TEN-FR-010`/`IMPL-811`, `TEN-FR-013`/`IMPL-810`, `TEN-FR-014`/`IMPL-813`.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/domain/library/policy/policy.dart';
import 'package:liboora/platform/tenancy/tenancy.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

/// The module under test, read as source.
String _tenancySource() {
  final f = File('lib/platform/tenancy/tenancy.dart');
  expect(
    f.existsSync(),
    isTrue,
    reason: 'platform/tenancy must exist for BC-19 to own anything.',
  );
  return f.readAsStringSync();
}

/// Every `final class` / `class` / `enum` declared at top level in [source].
Set<String> _declaredTypes(String source) {
  final re = RegExp(
    r'^(?:final\s+|abstract\s+|sealed\s+|base\s+)*(?:interface\s+)?(?:class|enum|mixin)\s+(\w+)',
    multiLine: true,
  );
  return re.allMatches(source).map((m) => m.group(1)!).toSet();
}

void main() {
  group('IMPL-800 · TEN-FR-001 + TEN-FR-003 — the ownership boundary', () {
    test('Tenant is owned here', () {
      // TEN-FR-001: the module SHALL own the Tenant aggregate.
      expect(_declaredTypes(_tenancySource()), contains('Tenant'));
    });

    test('no tenant-facing business record other than Tenant', () {
      // TEN-FR-003, and the exact defect D-013-01 recorded against this file:
      // a Branch class with name and address lived here until IMPL-801.
      final types = _declaredTypes(_tenancySource());

      expect(
        types,
        isNot(contains('Branch')),
        reason:
            'Branch belongs to BC-06 (Bounded Context Map L210, PRD-002 L56). '
            'ADR-0050 section 3.1 recorded its presence here as code defect '
            'D-013-01. It is now BranchDisplay in domain/library/policy.',
      );

      // The register at Bounded Context Map section 8 L381 lists Tenant plus
      // four value objects and nothing else. Anything business-shaped beyond
      // that set would be a second record. TenantTier is the one value object
      // that exists today; the other three are IMPL-802's to add.
      const permitted = {
        'Tenant',
        'TenantTier',
        'Quota',
        'ResidencyRegion',
        'TenantLifecycleState',
        // Infrastructure, not a tenant-facing record: the writable holder for
        // the R0 TenantContext interface (section 8.3 cycle-breaking pattern).
        'MutableTenantContext',
      };
      expect(
        types.difference(permitted),
        isEmpty,
        reason:
            'Only Tenant, its declared value objects and the tenant-context '
            'holder may be declared in platform/tenancy (TEN-FR-003).',
      );
    });

    test('Tenant carries no branch collection', () {
      // The field, not just the type, is what made TEN-FR-003 false: a
      // List<Branch> on Tenant is a tenant-facing business record held by
      // BC-19 regardless of where the element type is declared.
      final src = _tenancySource();
      expect(src, isNot(contains('List<Branch>')));
      expect(src, isNot(contains('branches')));
    });

    test('BranchId is still used, and still comes from R0', () {
      // The fix must not overshoot. Tenant context carries a branch id, and
      // BranchId is a rank-0 contract, so using it here is correct and is
      // what lets a rank-4 module scope by branch without knowing what a
      // branch is.
      final src = _tenancySource();
      expect(src, contains('BranchId'));
      expect(
        src,
        isNot(contains('class BranchId')),
        reason: 'BranchId is declared in liboora_contracts; never redeclared.',
      );
    });
  });

  group('IMPL-801 · TEN-FR-004 — Tenant is the only aggregate root', () {
    test('exactly one aggregate root is declared', () {
      final types = _declaredTypes(_tenancySource());

      // An aggregate root here is a type carrying identity plus business
      // fields. Tenant qualifies; the context holder does not (it has no
      // identity of its own and no business state).
      final roots = types.where(
        (t) => t != 'MutableTenantContext' && t != 'TenantTier',
      );
      expect(
        roots,
        equals({'Tenant'}),
        reason: 'TEN-FR-004: Tenant SHALL be the module only aggregate root.',
      );
    });

    test('a Tenant can be constructed without any branch argument', () {
      // Compile-level, as the task requires: this would not compile if
      // Tenant still demanded a branches list.
      const t = Tenant(
        id: TenantId('t-1'),
        name: 'Test Library',
        tier: TenantTier.starter,
      );
      expect(t.id.value, 't-1');
      expect(t.suspended, isFalse);
    });
  });

  group('BC-06 now owns branch display data', () {
    test('BranchDisplay carries exactly the three decided fields', () {
      const b = BranchDisplay(
        id: BranchId('b-1'),
        name: 'Lajpat Nagar',
        address: 'Block C, New Delhi',
      );
      expect(b.id.value, 'b-1');
      expect(b.name, 'Lajpat Nagar');
      expect(b.address, 'Block C, New Delhi');
    });

    test('BranchReader reads back what was saved, ordered by name', () {
      final repo = BranchDisplayRepository();
      repo.save(
        const BranchDisplay(id: BranchId('b-2'), name: 'Saket', address: 'PER'),
      );
      repo.save(
        const BranchDisplay(
          id: BranchId('b-1'),
          name: 'Lajpat Nagar',
          address: 'Block C',
        ),
      );

      final BranchReader reader = repo;
      expect(reader.displayFor(const BranchId('b-1')).name, 'Lajpat Nagar');
      expect(
        reader.allDisplays().map((b) => b.name).toList(),
        ['Lajpat Nagar', 'Saket'],
        reason: 'allDisplays sorts by name so the UI need not.',
      );
    });

    test('an unknown branch is refused, never defaulted', () {
      // Same contract as PolicyReader.forBranch: a fabricated branch label is
      // worse than a loud failure.
      final repo = BranchDisplayRepository();
      expect(
        () => repo.displayFor(const BranchId('nope')),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.notFound,
          ),
        ),
      );
    });

    test('no Floor or Zone is introduced by this slice', () {
      // PRD-002 LIB-10/LIB-11 remain unimplemented; the decision excluded
      // them explicitly.
      final src = File(
        'lib/domain/library/policy/domain/branch_display.dart',
      ).readAsStringSync();
      final types = _declaredTypes(src);
      expect(types, equals({'BranchDisplay'}));
    });
  });

  group('the UI seam preserves existing behaviour', () {
    test('BranchView carries the same three facts across the app boundary', () {
      const v = BranchView(
        id: BranchId('b-1'),
        name: 'Lajpat Nagar',
        address: 'Block C',
      );
      expect(v.id.value, 'b-1');
      expect(v.name, 'Lajpat Nagar');
      expect(v.address, 'Block C');
    });

    test('app declares no import of the BC-06 barrel', () {
      // app lists domain/library under ports:, not imports: (manifest L534),
      // so importing the barrel from app is a boundary violation. Measured
      // during implementation: doing so moved the checker from 9 to 10
      // findings, which is why the projection lives at the composition root.
      final session = File('lib/app/shared/session.dart').readAsStringSync();
      expect(session, isNot(contains('domain/library/policy/policy.dart')));
    });
  });
}
