/// **Architecture test 3 of 7 — `every_aggregate_has_invariant_tests_test.dart`.**
///
/// Mandated by `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.3, whose requirement
/// cell reads verbatim:
///
/// > Each of the 17 aggregates in context map §8 has a corresponding invariant
/// > test file
///
/// ## What this test actually asserts, and why it is not the literal sentence
///
/// The literal sentence cannot be asserted today, and asserting it anyway would
/// produce a red build for a reason that has nothing to do with invariant
/// coverage. `LIBOORA_BOUNDED_CONTEXT_MAP.md` §8 declares **17 rows / 21
/// aggregate names**, but `lib/domain/` currently contains **7** of those
/// aggregate classes. The other 14 names are declared architecture with no
/// implementation yet — there is no code for an invariant test to constrain.
///
/// A test demanding 21 invariant files would therefore fail permanently, and a
/// permanently-red required check is a check the pipeline learns to ignore.
/// `SID-4.56` — *"a rule that cannot be checked SHALL be treated as unmet"* —
/// cuts the other way too: a rule asserted against absent code is not being
/// checked, it is being performed.
///
/// So this file asserts the **enforceable half** of the Matrix rule:
///
///   **Every aggregate root declared in BC Map §8 that EXISTS as a class in
///   `lib/domain/` SHALL have a corresponding invariant test file.**
///
/// and then makes the unenforceable half **impossible to forget**, by pinning
/// the number of declared-but-unimplemented aggregates. The moment any of those
/// 14 gains an implementation, this suite goes red until an invariant test file
/// arrives with it. The gap is therefore *disclosed and mechanically tracked*
/// rather than silently passed — which is the distinction between a gap and a
/// hidden defect.
///
/// ## Why the aggregate list is parsed from the BC Map, not hard-coded here
///
/// A hard-coded list in a test file becomes a second source of truth that
/// drifts from §8 the first time §8 changes. Parsing means adding a row to §8
/// automatically extends this test's obligation set.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The authority. Read, never written.
const String _bcMapPath =
    'docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md';

const String _matrixPath =
    'docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md';

const String _domainRoot = 'lib/domain';
const String _invariantTestDir = 'test/architecture/invariants';

/// The count §10.3 states. Pinned so that a change to the Matrix sentence is
/// noticed here rather than silently diverging.
const int _matrixDeclaredAggregateCount = 17;

/// Aggregate roots declared in BC Map §8 that have **no implementation** in
/// `lib/domain/` yet.
///
/// This is a DISCLOSURE, not a permission list. Each entry means: the
/// architecture declares this aggregate, no code implements it, and therefore
/// no invariant test can constrain it yet. Implementing any of these without
/// also adding an invariant test file will turn this suite red — which is the
/// entire purpose of writing the list down.
///
/// Shrinking this set is the expected direction of travel. Growing it is not,
/// and requires deleting working code to achieve.
const Set<String> _declaredButNotImplemented = {
  // BC-10 Global Identity (platform/identity — declared, not yet built here)
  'GlobalStudentProfile',
  // BC-11 Social Graph
  'Friendship',
  'BlockList',
  // BC-12 Messaging  — the FIL-GAP-012 consumer. Still unimplemented, which is
  // exactly why the File & Media implementation half cannot yet be proven.
  'Conversation',
  // BC-13 Trust & Safety
  'ModerationCase',
  // BC-18 Identity & Access
  'Account',
  'AccessPolicy',
  // BC-19 Tenancy
  'Tenant',
  // BC-20 Subscription & Billing
  'Subscription',
  'SubscriptionInvoice',
  // BC-21 Entitlement
  'EntitlementSet',
  // BC-24 Audit Trail
  'AuditEntry',
  // BC-26 Analytics Read Model
  'Projection',
  // BC-27 AI Assistance
  'AgentRun',
};

// ══════════════════════════════════════════════════════════════════════
// Parsing
// ══════════════════════════════════════════════════════════════════════

/// One parsed BC Map §8 row.
final class _AggregateRow {
  _AggregateRow(this.context, this.roots);

  final String context;
  final List<String> roots;
}

/// Parses the §8 aggregate table.
///
/// A §8 row is a markdown table row whose first cell begins with a `BC-NN`
/// context id and whose second cell holds one or more backticked aggregate root
/// names separated by `·`.
List<_AggregateRow> _parseSection8() {
  final file = File(_bcMapPath);
  if (!file.existsSync()) {
    fail(
      'Cannot find $_bcMapPath. This test derives its obligation set from '
      'BC Map §8; without the authority document it must fail rather than '
      'pass vacuously.',
    );
  }
  final lines = file.readAsLinesSync();

  // Locate the §8 heading, then stop at §8.1 so the sizing-notes prose and
  // §9's event table are never mistaken for aggregate rows.
  var start = -1;
  var end = lines.length;
  for (var i = 0; i < lines.length; i++) {
    final l = lines[i].trim();
    if (start == -1 && RegExp(r'^#{2,3}\s+8\.\s').hasMatch(l)) {
      start = i;
      continue;
    }
    if (start != -1 && RegExp(r'^#{2,4}\s+8\.1').hasMatch(l)) {
      end = i;
      break;
    }
  }
  if (start == -1) {
    fail('Could not locate the "## 8." aggregate section in $_bcMapPath.');
  }

  final rows = <_AggregateRow>[];
  final rowShape = RegExp(r'^\|\s*(BC-\d{2})\b([^|]*)\|([^|]*)\|');

  for (var i = start; i < end; i++) {
    final m = rowShape.firstMatch(lines[i]);
    if (m == null) continue;

    final context = m.group(1)!;
    final rootCell = m.group(3)!;

    // Root names are backticked. Italic asides such as *(per student)* and
    // *(aggregate = one student-day, not one punch)* are not backticked and are
    // therefore excluded by construction.
    final roots = RegExp(r'`([A-Z][A-Za-z0-9]*)`')
        .allMatches(rootCell)
        .map((x) => x.group(1)!)
        .toList(growable: false);

    if (roots.isEmpty) continue;
    rows.add(_AggregateRow(context, roots));
  }
  return rows;
}

/// Every class declared anywhere under `lib/domain/`.
Set<String> _domainClassNames() {
  final dir = Directory(_domainRoot);
  if (!dir.existsSync()) {
    fail('Cannot find $_domainRoot.');
  }
  final names = <String>{};
  final decl = RegExp(
    r'^\s*(?:final\s+|sealed\s+|abstract\s+|base\s+|interface\s+|mixin\s+)*'
    r'class\s+([A-Z][A-Za-z0-9_]*)',
    multiLine: true,
  );
  for (final f in dir.listSync(recursive: true).whereType<File>()) {
    if (!f.path.endsWith('.dart')) continue;
    for (final m in decl.allMatches(f.readAsStringSync())) {
      names.add(m.group(1)!);
    }
  }
  return names;
}

/// `StudentRecord` -> `student_record`.
String _snake(String pascal) => pascal
    .replaceAllMapped(
      RegExp(r'(?<=[a-z0-9])([A-Z])'),
      (m) => '_${m.group(1)}',
    )
    .toLowerCase();

/// Invariant test files present on disk, by basename.
Set<String> _invariantTestFiles() {
  final dir = Directory(_invariantTestDir);
  if (!dir.existsSync()) return const {};
  return dir
      .listSync()
      .whereType<File>()
      .map((f) => f.uri.pathSegments.last)
      .where((n) => n.endsWith('_invariant_test.dart'))
      .toSet();
}

/// True when [aggregate] has an invariant test file.
///
/// Accepts either its own file, or a file named for another aggregate in the
/// same BC Map row — `SeatLayout` is covered inside
/// `seat_allocation_invariant_test.dart`, because §8 lists the two as one row
/// and splitting them would split one invariant across two files.
bool _hasInvariantFile(
  String aggregate,
  Set<String> files,
  List<_AggregateRow> rows,
) {
  final own = '${_snake(aggregate)}_invariant_test.dart';
  if (files.contains(own)) return true;

  for (final row in rows) {
    if (!row.roots.contains(aggregate)) continue;
    for (final sibling in row.roots) {
      if (files.contains('${_snake(sibling)}_invariant_test.dart')) return true;
    }
  }
  return false;
}

void main() {
  final rows = _parseSection8();
  final declared = <String>{for (final r in rows) ...r.roots};
  final inCode = _domainClassNames();
  final files = _invariantTestFiles();

  final implemented = declared.where(inCode.contains).toSet();
  final unimplemented = declared.difference(implemented);

  // ════════════════════════════════════════════════════════════════════
  group('§8 parse integrity — the obligation set is real', () {
    test('the §8 table parses to a non-empty set of aggregate rows', () {
      // Vacuity guard. Every assertion below is quantified over `declared`;
      // if the parser silently returned nothing, they would all pass over an
      // empty set — an unmet rule wearing a green tick.
      expect(
        rows,
        isNotEmpty,
        reason:
            'The §8 table did not parse. Every downstream assertion in this '
            'file is quantified over its rows, so an empty parse would make '
            'this whole suite vacuous.',
      );
      expect(declared, isNotEmpty);
    });

    test('the row count matches the 17 that Matrix §10.3 states', () {
      expect(
        rows.length,
        _matrixDeclaredAggregateCount,
        reason:
            'Matrix §10.3 requires "each of the '
            '$_matrixDeclaredAggregateCount aggregates in context map §8". '
            'Found ${rows.length} rows in $_bcMapPath §8.\n'
            'If §8 legitimately gained or lost a context, §10.3 must be '
            'amended in the same change — the two documents cannot disagree '
            'about how many aggregates exist. Contexts parsed: '
            '${rows.map((r) => r.context).join(', ')}',
      );
    });

    test('every parsed row names at least one aggregate root, and multi-root '
        'rows are preserved', () {
      for (final r in rows) {
        expect(
          r.roots,
          isNotEmpty,
          reason: 'Row ${r.context} parsed with no aggregate root.',
        );
      }
      // §8 lists four contexts with two roots each (BC-04, BC-11, BC-18,
      // BC-20). Losing the second name would silently drop an obligation.
      final multi = rows.where((r) => r.roots.length > 1).toList();
      expect(
        multi.length,
        4,
        reason:
            'Expected 4 multi-root rows (BC-04, BC-11, BC-18, BC-20); parsed '
            '${multi.map((r) => "${r.context}=${r.roots}").join(' ')}. '
            'A dropped second root is a silently dropped invariant test '
            'obligation.',
      );
      expect(
        declared.length,
        21,
        reason:
            'Expected 21 distinct aggregate names across the 17 rows. '
            'Parsed ${declared.length}: ${(declared.toList()..sort()).join(', ')}',
      );
    });

    test('the Matrix §10.3 requirement text still says what this test '
        'implements', () {
      // If §10.3's wording is rewritten, this file's justification must be
      // re-read rather than assumed. Cheap to check, and it prevents the test
      // from quietly enforcing a rule the Matrix no longer states.
      final matrix = File(_matrixPath);
      expect(matrix.existsSync(), isTrue, reason: 'Missing $_matrixPath.');
      final text = matrix.readAsStringSync();
      expect(
        text,
        contains('every_aggregate_has_invariant_tests_test.dart'),
        reason:
            'Matrix §10.3 no longer names this test. Either the requirement '
            'was removed (in which case deleting this file is a governance '
            'decision, not a cleanup) or it was renamed.',
      );
      expect(
        text,
        contains('has a corresponding invariant test file'),
        reason:
            'The §10.3 requirement wording changed. Re-read it before '
            'trusting this test to implement it.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // THE ENFORCEABLE RULE.
  // ════════════════════════════════════════════════════════════════════
  group('every implemented aggregate has an invariant test file', () {
    test('no aggregate class exists in lib/domain/ without one', () {
      expect(
        implemented,
        isNotEmpty,
        reason:
            'No BC Map §8 aggregate was found in $_domainRoot at all. Either '
            'the domain layer was emptied or the class scanner is broken; '
            'either way this test must not pass silently.',
      );

      final missing = implemented
          .where((a) => !_hasInvariantFile(a, files, rows))
          .toList()
        ..sort();

      expect(
        missing,
        isEmpty,
        reason:
            'Matrix §10.3 requires an invariant test file per aggregate. '
            'These aggregates exist in $_domainRoot but have no invariant '
            'test:\n'
            '${missing.map((a) => '  - $a  (expected $_invariantTestDir/${_snake(a)}_invariant_test.dart)').join('\n')}\n\n'
            'An aggregate is a transaction boundary (BC Map §8). An unguarded '
            'boundary is a boundary whose invariants are enforced only by '
            'whoever last read the code.',
      );
    });

    test('every invariant test file corresponds to a declared aggregate', () {
      // The reverse direction. A stray invariant file named for something §8
      // does not declare means either §8 is incomplete or the file is testing
      // something that is not an aggregate — both worth surfacing.
      final expectedNames = {
        for (final a in declared) '${_snake(a)}_invariant_test.dart',
      };
      final orphans = files.difference(expectedNames).toList()..sort();

      expect(
        orphans,
        isEmpty,
        reason:
            'These invariant test files do not correspond to any aggregate '
            'root declared in BC Map §8: ${orphans.join(', ')}.\n'
            'Either the aggregate is missing from §8, or the file is testing a '
            'non-aggregate and should not carry the _invariant_test suffix.',
      );
    });

    test('each present invariant file actually contains assertions', () {
      // A file that satisfies the naming rule but asserts nothing would make
      // the rule above a formality. This is the same vacuity failure mode
      // found earlier in prd017_stage5.py check 10.
      expect(files, isNotEmpty, reason: 'No invariant test files found.');

      for (final name in files) {
        final src = File('$_invariantTestDir/$name').readAsStringSync();
        final expectCount = RegExp(r'\bexpect\s*\(').allMatches(src).length;
        final testCount = RegExp(r'\btest\s*\(').allMatches(src).length;

        expect(
          testCount,
          greaterThan(0),
          reason: '$name declares no test() cases.',
        );
        expect(
          expectCount,
          greaterThanOrEqualTo(testCount),
          reason:
              '$name has $testCount test() cases but only $expectCount '
              'expect() calls. A test case that asserts nothing passes '
              'unconditionally and is worse than no test, because it reports '
              'coverage it does not provide.',
        );
      }
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // THE DISCLOSED GAP — tracked mechanically so it cannot be forgotten.
  // ════════════════════════════════════════════════════════════════════
  group('DISCLOSED GAP — declared aggregates with no implementation', () {
    test('the unimplemented set matches the disclosed list exactly', () {
      final unexpectedlyMissing =
          (unimplemented.difference(_declaredButNotImplemented).toList())
            ..sort();
      final unexpectedlyPresent =
          (_declaredButNotImplemented.difference(unimplemented).toList())
            ..sort();

      expect(
        unexpectedlyMissing,
        isEmpty,
        reason:
            'These §8 aggregates have no implementation in $_domainRoot and '
            'are NOT in the disclosed gap list: '
            '${unexpectedlyMissing.join(', ')}.\n'
            'Add them to _declaredButNotImplemented with a comment, so the '
            'gap is recorded rather than absorbed.',
      );

      expect(
        unexpectedlyPresent,
        isEmpty,
        reason:
            'PROGRESS DETECTED — these aggregates are now implemented in '
            '$_domainRoot but are still listed as unimplemented: '
            '${unexpectedlyPresent.join(', ')}.\n\n'
            'This failure is the intended behaviour of the disclosure list. '
            'To clear it: write '
            '${unexpectedlyPresent.map((a) => '$_invariantTestDir/${_snake(a)}_invariant_test.dart').join(', ')} '
            'asserting the invariants that BC Map §8 declares for it, then '
            'remove the name from _declaredButNotImplemented.\n'
            'Do NOT remove the name without writing the test — that is the '
            'exact substitution this test exists to prevent.',
      );
    });

    test('coverage of §8 is reported and the arithmetic closes', () {
      expect(
        implemented.length + unimplemented.length,
        declared.length,
        reason: 'Partition failure: every declared aggregate must be in '
            'exactly one of the two sets.',
      );

      // Not an assertion of a target — a statement of the measured position,
      // pinned so it cannot regress unnoticed.
      expect(
        implemented.length,
        7,
        reason:
            'Measured §8 coverage changed. ${implemented.length} of '
            '${declared.length} declared aggregates are implemented: '
            '${(implemented.toList()..sort()).join(', ')}.\n'
            'An INCREASE is progress — update this number in the same commit '
            'that adds the aggregate and its invariant test.\n'
            'A DECREASE means an aggregate was deleted from lib/domain/ while '
            'BC Map §8 still declares it, which is an architecture regression '
            'and not a test problem.',
      );
    });

    test('the disclosed gap does not silently cover an implemented '
        'aggregate', () {
      // Belt and braces: no name may be simultaneously implemented and
      // excused. Without this, adding a name to the disclosure list would be
      // a way to delete an invariant test obligation.
      for (final name in _declaredButNotImplemented) {
        expect(
          inCode.contains(name),
          isFalse,
          reason:
              '$name is present in $_domainRoot but is listed as '
              'unimplemented. The disclosure list must never be usable as an '
              'exemption from writing an invariant test.',
        );
      }
    });
  });
}
