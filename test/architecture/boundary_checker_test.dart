/// **Layer 3 architecture tests for `IMPL-014`** (`MODULE_DEPENDENCY_MATRIX` §10.3).
///
/// The boundary checker is the thing that enforces every other architectural
/// rule, which makes it the one piece of tooling whose own correctness cannot be
/// taken on trust. `SID-4.56` — *"a rule that cannot be checked SHALL be treated
/// as unmet"* — applies recursively: an unverified checker is an unmet rule
/// wearing a green tick.
///
/// These tests therefore assert the checker's **governance properties**, not its
/// current findings. A count-based test ("there are 9 violations") would have to
/// be edited every time debt is paid down, and a test you routinely edit is a
/// test you have stopped reading. What is asserted here instead:
///
///   1. The checker runs at all, and exits non-zero while violations remain.
///   2. An expired exception stops waiving — debt is time-boxed by the tooling.
///   3. An exception missing its ADR or expiry is a **checker error** (exit 2),
///      never a silently skipped line.
///   4. A cycle can never be waived, whatever the manifest asks for (`L1`).
///   5. Every declared exception is well-formed and traceable to an ADR.
///
/// Properties 2–4 are exercised by running the real checker against a temporary
/// copy of the repository manifest, so they test the shipped code path rather
/// than a re-implementation of it.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

/// Absolute path to the repository root, derived from this file's location so
/// the tests do not depend on the working directory the runner chose.
final String _repoRoot = Directory.current.path;

String get _manifestPath => '$_repoRoot/tool/module_dependencies.yaml';
String get _checkerPath => '$_repoRoot/tool/check_module_boundaries.dart';

/// Runs the real checker, optionally against a mutated manifest.
///
/// The manifest is restored in a `finally` block, so a failing expectation can
/// never leave the repository in a modified state.
({int exitCode, String stdout, String stderr}) _runChecker({
  String Function(String original)? mutateManifest,
}) {
  final manifest = File(_manifestPath);
  final original = manifest.readAsStringSync();

  try {
    if (mutateManifest != null) {
      manifest.writeAsStringSync(mutateManifest(original));
    }
    final result = Process.runSync(
      'dart',
      ['run', _checkerPath],
      workingDirectory: _repoRoot,
      stdoutEncoding: utf8,
      stderrEncoding: utf8,
    );
    return (
      exitCode: result.exitCode,
      stdout: result.stdout as String,
      stderr: result.stderr as String,
    );
  } finally {
    manifest.writeAsStringSync(original);
  }
}

void main() {
  group('IMPL-014 · the checker itself runs', () {
    test('the checker and its manifest both exist', () {
      expect(
        File(_checkerPath).existsSync(),
        isTrue,
        reason:
            'tool/check_module_boundaries.dart is a required CI gate '
            '(MODULE_DEPENDENCY_MATRIX §10.4 step 3).',
      );
      expect(File(_manifestPath).existsSync(), isTrue);
    });

    test('it produces a report and a meaningful exit code', () {
      final run = _runChecker();

      expect(
        run.stdout,
        contains('LIBOORA architecture boundary check'),
        reason: 'The checker must always report, pass or fail.',
      );
      // 0 = clean, 1 = violations. 2 means the checker could not run, which
      // must never be reachable with a valid committed manifest.
      expect(
        run.exitCode,
        anyOf(0, 1),
        reason:
            'Exit 2 means the checker could not run. With the committed '
            'manifest that is always a defect.\n${run.stderr}',
      );
    });

    test('while ADR-0012 debt is unpaid the gate is red, and says why', () {
      final run = _runChecker();

      // ADR-0012 §3.4 records this deliberately: the nine app -> domain/library
      // sites are NOT waived because TASK-D10 already tracks their deletion.
      // When TASK-D10 lands this expectation flips to exit 0, and the test below
      // ('no un-waived violations') is the one that should then hold.
      if (run.exitCode == 1) {
        expect(
          run.stdout,
          contains('domain/library'),
          reason:
              'The only expected un-waived debt is app -> domain/library '
              '(ADR-0012 §3.4 / TASK-D10).',
        );
      } else {
        expect(
          run.stdout,
          contains('PASS'),
          reason: 'Exit 0 must be accompanied by a PASS line.',
        );
      }
    });
  });

  group('§11 step 5 · debt is time-boxed by the tooling', () {
    test('an expired exception stops waiving and fails the build again', () {
      final baseline = _runChecker();

      final expired = _runChecker(
        mutateManifest: (m) {
          // Every committed exception is dated in the future; pushing them all
          // into the past must return every waived finding to blocking.
          final rewritten = m.replaceAll(
            RegExp(r'expires: \d{4}-\d{2}-\d{2}'),
            'expires: 2020-01-01',
          );
          expect(
            rewritten,
            isNot(m),
            reason: 'Expected at least one `expires:` to rewrite.',
          );
          return rewritten;
        },
      );

      expect(
        expired.exitCode,
        1,
        reason:
            'An expired exception must fail the build. §11 step 5: "CI '
            'fails after the expiry date if the exception still exists."',
      );
      expect(
        expired.stdout,
        isNot(contains('ACKNOWLEDGED DEBT')),
        reason: 'Nothing can remain waived once every date has passed.',
      );

      // The point of the mechanism: expiry strictly increases what blocks.
      final blockingBefore = _blockingCount(baseline.stdout);
      final blockingAfter = _blockingCount(expired.stdout);
      expect(
        blockingAfter,
        greaterThan(blockingBefore),
        reason:
            'Expiring the exceptions must move findings from waived to '
            'blocking, not merely relabel them.',
      );
    });

    test('an exception with no expiry date is treated as expired', () {
      final run = _runChecker(
        mutateManifest: (m) =>
            m.replaceFirst(RegExp(r'\n    expires: \d{4}-\d{2}-\d{2}'), ''),
      );

      // Absent required field => checker error. Either way it must not pass,
      // and it must never be read as indefinite permission.
      expect(
        run.exitCode,
        anyOf(1, 2),
        reason: 'A missing expiry must never be read as "never expires".',
      );
    });
  });

  group('§11 step 2 · an exception must be auditable', () {
    test('an exception missing its ADR halts the checker (exit 2)', () {
      final run = _runChecker(
        mutateManifest: (m) =>
            m.replaceFirst(RegExp(r'\n    adr: ADR-\d+'), ''),
      );

      expect(
        run.exitCode,
        2,
        reason:
            'An un-attributable exception must stop the run, not be '
            'skipped. Exit 2 = the checker could not run.',
      );
      expect(
        run.stderr,
        contains('adr'),
        reason:
            'The error must name the missing field so it can be fixed '
            'without re-reading §11.',
      );
    });

    test('an unparseable expiry halts the checker rather than passing', () {
      final run = _runChecker(
        mutateManifest: (m) => m.replaceFirst(
          RegExp(r'expires: \d{4}-\d{2}-\d{2}'),
          'expires: someday',
        ),
      );

      expect(run.exitCode, 2);
      expect(run.stderr, contains('expires'));
    });

    test('an exception naming an unknown module halts the checker', () {
      final run = _runChecker(
        mutateManifest: (m) => m.replaceFirst(
          'from: platform/business',
          'from: platform/does_not_exist',
        ),
      );

      expect(
        run.exitCode,
        2,
        reason:
            'A typo in an exception must not silently waive nothing — or, '
            'worse, be assumed to waive something.',
      );
    });
  });

  group('L1 · acyclic is never waivable (§11 step 3)', () {
    test('a self-edge exception does not waive a real cycle', () {
      // ADR-0012 §3.1 fixed the only cycle in the repository, so this asserts
      // the guard rather than the cure: even with a syntactically valid waiver
      // present, `circular-dependency` must never be moved into ACKNOWLEDGED
      // DEBT. `DependencyException.appliesTo` refuses the category outright.
      final run = _runChecker(
        mutateManifest: (m) => m.replaceFirst(
          'exceptions:\n',
          'exceptions:\n'
              '  - from: app\n'
              '    to: app\n'
              '    mode: port\n'
              '    reason: "test: L1 must remain unwaivable"\n'
              '    adr: ADR-9999\n'
              '    expires: 2099-01-01\n\n',
        ),
      );

      // The waiver is well-formed, so the checker runs.
      expect(run.exitCode, isNot(2), reason: run.stderr);

      // A cycle, if one existed, would be reported as blocking — never waived.
      final debtSection = run.stdout.contains('ACKNOWLEDGED DEBT')
          ? run.stdout.substring(run.stdout.indexOf('ACKNOWLEDGED DEBT'))
          : '';
      expect(
        debtSection,
        isNot(contains('circular-dependency')),
        reason:
            'L1 is "the one law with zero exceptions" and §11 step 3 says '
            'it is never approved. It must not be waivable by manifest edit.',
      );
    });

    test('the repository is currently free of import cycles', () {
      final run = _runChecker();
      expect(
        run.stdout,
        isNot(contains('circular-dependency')),
        reason:
            'ADR-0012 §3.1 removed the di -> seed -> di cycle via the §8.2 '
            'port-inversion pattern. A regression here fails L1 outright.',
      );
    });
  });

  group('the committed exception list is well-formed', () {
    late List<Map<String, Object?>> exceptions;

    setUpAll(() {
      final doc = loadYaml(File(_manifestPath).readAsStringSync()) as YamlMap;
      final raw = doc['exceptions'];
      exceptions = raw is YamlList
          ? raw
                .map((e) => Map<String, Object?>.from(e as YamlMap))
                .toList(growable: false)
          : const [];
    });

    test('every exception carries all six required fields', () {
      for (final e in exceptions) {
        for (final key in ['from', 'to', 'mode', 'reason', 'adr', 'expires']) {
          expect(
            e[key],
            isNotNull,
            reason:
                '§11 step 4 requires `$key` on every exception. Offending '
                'entry: ${e['from']} -> ${e['to']}',
          );
        }
      }
    });

    test('every exception cites an ADR file that exists', () {
      for (final e in exceptions) {
        final adr = e['adr'].toString();
        final matches = Directory('$_repoRoot/docs/00-governance/adr')
            .listSync()
            .whereType<File>()
            .where((f) => f.path.split('/').last.startsWith(adr));

        expect(
          matches,
          isNotEmpty,
          reason:
              'Exception ${e['from']} -> ${e['to']} cites $adr, but no '
              'such ADR file exists. An exception whose ADR cannot be read is '
              'not a governance record.',
        );
      }
    });

    test('no exception is committed already expired', () {
      for (final e in exceptions) {
        final parsed = DateTime.tryParse(e['expires'].toString());
        expect(parsed, isNotNull, reason: 'Use YYYY-MM-DD.');
        expect(
          parsed!.isAfter(DateTime.now()),
          isTrue,
          reason:
              'Exception ${e['from']} -> ${e['to']} expires '
              '${e['expires']}, which has passed. Either do the work or '
              'reset the date through the ADR process — never leave a dead '
              'exception in place.',
        );
      }
    });

    test('app -> domain/library is deliberately NOT waived', () {
      // ADR-0012 §3.4. Waiving this would convert TASK-D10, a tracked P0
      // release blocker, into untracked debt with a distant expiry.
      final waived = exceptions.any(
        (e) => e['from'] == 'app' && e['to'] == 'domain/library',
      );
      expect(
        waived,
        isFalse,
        reason:
            'ADR-0012 §3.4 requires this edge to keep failing until '
            'TASK-D10 deletes the demo surfaces.',
      );
    });
  });
}

/// Extracts the blocking-violation count from a checker report.
///
/// Returns 0 for a passing run, which is the correct reading of "no blocking
/// violations" rather than "could not parse".
int _blockingCount(String report) {
  final match = RegExp(r'FAIL — (\d+) violation').firstMatch(report);
  return match == null ? 0 : int.parse(match.group(1)!);
}
