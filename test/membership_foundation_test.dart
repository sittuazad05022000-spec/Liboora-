/// `BC-02` Membership — foundation conformance.
///
/// Covers `IMPL-400` (bounded-context skeleton and ownership boundary),
/// `IMPL-402` (tenant/branch scoping primitives) and `IMPL-407` (the nine
/// `MM-CFG-*` configurables) against FROZEN `PRD-005` v1.4.
///
/// `IMPL-400`'s test obligation is the hard one and is the reason this file
/// reads source rather than only calling methods: *"the three concepts are
/// distinct types; no `BC-01`/`BC-10` field is representable."* A test that
/// asserts *"we did not store a name"* passes vacuously — the aggregate could
/// gain the field tomorrow. So the field set is read from the declaration.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/seed.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const String _aggregatePath =
    'lib/domain/library/membership/domain/membership.dart';

/// Every `final`/`var` field declared in the membership aggregate file.
Set<String> _declaredFieldNames(String classBody) {
  final pattern = RegExp(
    r'^\s*(?:final\s+|late\s+final\s+)?[A-Za-z0-9_<>?,\s]+\s+(_?[a-z][A-Za-z0-9_]*)\s*;',
    multiLine: true,
  );
  return pattern
      .allMatches(classBody)
      .map((m) => m.group(1)!)
      .toSet();
}

String _classBody(String source, String className) {
  final start = source.indexOf('final class $className {');
  expect(
    start,
    isNot(-1),
    reason: 'Class $className not found — this scan is measuring nothing.',
  );
  // Balance braces from the class opening.
  var depth = 0;
  var i = source.indexOf('{', start);
  final from = i;
  for (; i < source.length; i++) {
    if (source[i] == '{') depth++;
    if (source[i] == '}') {
      depth--;
      if (depth == 0) break;
    }
  }
  return source.substring(from, i);
}

void main() {
  final source = File(_aggregatePath).readAsStringSync();

  // ════════════════════════════════════════════════════════════════════
  // IMPL-400 — ownership boundary: BC-01 and BC-10 fields are not
  // representable inside BC-02.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-400 · BC-02 owns membership and nothing else', () {
    test('the scan is non-vacuous', () {
      expect(source, contains('final class Membership {'));
      expect(source, contains('final class MembershipPlan {'));
      final fields = _declaredFieldNames(_classBody(source, 'Membership'));
      expect(
        fields,
        contains('planId'),
        reason:
            'Field scan returned nothing recognisable. If this breaks, every '
            'exclusion below passes trivially and proves nothing.',
      );
    });

    test('MM-FR-003 / MM-XC-001 — no student profile or identity field is '
        'representable on Membership', () {
      final fields = _declaredFieldNames(_classBody(source, 'Membership'));

      // MM-FR-003: a Membership references a StudentRecordId and MUST NOT
      // store a PersonId, an AccountId, or any profile field.
      const forbidden = {
        'personId',
        'accountId',
        'fullName',
        'name',
        'phone',
        'email',
        'dateOfBirth',
        'dob',
        'photoRef',
        'guardian',
        'address',
        'enrollmentNumber',
      };

      final leaked = fields.intersection(forbidden);
      expect(
        leaked,
        isEmpty,
        reason:
            'MM-XC-001 makes storing or mutating a student profile field '
            'IMPOSSIBLE, not merely undone. These fields are declared on the '
            'Membership aggregate: $leaked. A membership references a student; '
            'it does not describe one.',
      );
    });

    test('MM-FR-005 — EnrollmentStatus is not stored, derived or copied', () {
      expect(
        source.contains('EnrollmentStatus'),
        isFalse,
        reason:
            'MM-FR-005: this module MUST NOT write, derive or infer '
            'EnrollmentStatus, and MUST NOT store a copy of it. MM-FR-004 '
            'keeps the two state machines independent (BC Map L209).',
      );
    });

    test('MM-XC-002 — no ledger, seat or attendance field is representable',
        () {
      final fields = _declaredFieldNames(_classBody(source, 'Membership'));
      const foreign = {
        'balance',
        'amountPaid',
        'receipts',
        'dues',
        'seatId',
        'seatNumber',
        'checkInAt',
        'punches',
        'attendance',
      };
      final leaked = fields.intersection(foreign);
      expect(
        leaked,
        isEmpty,
        reason:
            'MM-XC-002 forbids writing to BC-01/BC-03/BC-04/BC-05. Holding '
            'their fields here is the first step to writing them: $leaked',
      );
    });

    test('the three concepts are distinct types', () {
      // MembershipPlan (offer), Membership (granted right), MembershipStatus
      // (lifecycle position) — one type each, never fused.
      expect(source, contains('enum MembershipStatus'));
      expect(source, contains('final class MembershipPlan'));
      expect(source, contains('final class Membership {'));
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-402 — tenant scoping is ambient, never a domain parameter.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-402 · tenant scope is ambient (MM-BR-027, MM-INV-007)', () {
    test('MM-NFR-002 — tenantId is not accepted as a domain-method parameter',
        () {
      // The compile-level rule TenantContext's own doc states: "It is never
      // passed as a domain method parameter — that would leak infrastructure
      // into the domain signature."
      final offenders = RegExp(
        r'(?:TenantId|BranchId)\s+(?:required\s+)?tenantId|'
        r'required\s+TenantId\s+tenant',
      ).allMatches(
        File('lib/domain/library/membership/membership.dart').readAsStringSync(),
      );
      expect(
        offenders,
        isEmpty,
        reason:
            'A use case that accepts tenantId can be called with the wrong '
            'one. MM-BR-027 requires the tenant to equal the AMBIENT context '
            'on every read and write, which only holds if it is never an '
            'argument.',
      );
    });

    test('MM-INV-007 — a plan carries its tenant and cannot be re-scoped', () {
      final body = _classBody(source, 'MembershipPlan');
      expect(body, contains('final TenantId tenantId;'));
      expect(body, contains('final BranchId branchId;'));

      // MM-FR-021 marks both IMMUTABLE. withEdits() is the only edit path and
      // must not name them.
      final edits = body.substring(body.indexOf('MembershipPlan withEdits('));
      final sig = edits.substring(0, edits.indexOf('}) =>') + 5);
      expect(
        sig.contains('tenantId') || sig.contains('branchId'),
        isFalse,
        reason:
            'MM-FR-021: changing tenantId or branchId would be a cross-tenant '
            'data move, which X-13 forbids. A parameter that does not exist '
            'cannot be passed.',
      );
    });

    test('a repository read with no tenant in scope throws, never defaults',
        () async {
      final c = await AppContainer.boot(seeder: seedDemoData);
      // No enterScope() — this is the dangerous state.
      expect(
        () => c.memberships.all(),
        throwsA(isA<TenantContextMissing>()),
        reason:
            'Returning every tenant\'s memberships when the scope is unset is '
            'the worst possible default. MM-NFR-003/004 require failure.',
      );
      expect(() => c.membershipPlans.all(), throwsA(isA<TenantContextMissing>()));
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // IMPL-407 — the nine MM-CFG-* configurables.
  // ════════════════════════════════════════════════════════════════════
  group('IMPL-407 · the nine MM-CFG-* configurables', () {
    const cfg = DefaultMembershipConfig();

    test('all nine §13.4 defaults are carried verbatim', () {
      expect(cfg.defaultCurrency, 'INR'); // MM-CFG-001
      expect(cfg.maxEnrollmentStaleness, const Duration(seconds: 5)); // 002
      expect(cfg.maxBackdateDays, 7); // MM-CFG-003
      expect(cfg.maxForwardDateDays, 90); // MM-CFG-004
      expect(cfg.idempotencyRetention, const Duration(days: 30)); // 005
      expect(cfg.tenantTimezone, 'Asia/Kolkata'); // MM-CFG-006
      expect(cfg.pendingPaymentVoidWindow, const Duration(days: 7)); // 007
      expect(cfg.expiringSoonDays, 7); // MM-CFG-008
      expect(cfg.reDeriveTermOnDelayedActivation, isFalse); // MM-CFG-009
    });

    test('MM-BR-026 — MM-CFG-008 resolves to ONE value, not two equal ones',
        () {
      // The rule: the expiring-soon threshold behind MM-EVT-006 and behind the
      // expiring view must be the SAME source, "so the reminder and the list
      // can never disagree". Two accessors returning 7 would pass a naive
      // test; changing the source must move both readers together.
      const shifted = DefaultMembershipConfig(expiringSoonDays: 3);
      expect(shifted.expiringSoonDays, 3);

      final declaration =
          File('packages/liboora_contracts/lib/src/ports/membership_config.dart')
              .readAsStringSync();
      final thresholdAccessors =
          RegExp(r'get\s+\w*[Ee]xpiring\w*\s*;').allMatches(declaration).length;
      expect(
        thresholdAccessors,
        1,
        reason:
            'MM-BR-026 needs exactly one expiring-soon accessor on the port. '
            'Found $thresholdAccessors. A second one is how the reminder and '
            'the list drift apart.',
      );
    });

    test('no raw string lookup exists anywhere in the membership module', () {
      for (final path in [
        _aggregatePath,
        'lib/domain/library/membership/membership.dart',
      ]) {
        final code = File(path).readAsStringSync();
        expect(
          RegExp(r"""config\[|getConfig\(\s*['"]|setting\(\s*['"]""")
              .hasMatch(code),
          isFalse,
          reason:
              '§13.4 requires typed accessors, never raw string lookups. '
              'Offender: $path',
        );
      }
    });

    test('the config is reachable through the container as a port', () async {
      final c = await AppContainer.boot(seeder: seedDemoData);
      expect(c.membershipConfig, isA<MembershipConfig>());
      expect(c.membershipConfig.expiringSoonDays, 7);
    });
  });
}
