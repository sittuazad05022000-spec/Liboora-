/// **Layer 3 architecture test 1 of 7** — `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`
/// §10.3, row 1: *"L4 across all 16 capability modules"*.
///
/// `L4` (Matrix L51) — *"No capability, generic or platform module may import a
/// domain module. **Ever.**"* — is the rule the Matrix calls
/// *"the single rule that makes microservice extraction a deployment change
/// rather than a rewrite."*  It is therefore asserted directly against source
/// text, not against the manifest's own opinion of itself.
///
/// ## Why this duplicates part of `check_module_boundaries.dart` on purpose
///
/// The boundary checker reads `tool/module_dependencies.yaml` and can only
/// forbid what the manifest describes.  `FIL-GAP-010` records a live instance
/// of exactly that weakness: `platform/services` has **no module block**, only
/// a rank, and the checker exempts a blockless module from
/// `default_decision: deny`.  A test that asked the manifest whether the
/// manifest was satisfied would inherit that blind spot.
///
/// This test instead enumerates `lib/platform/**` from the **filesystem** and
/// greps the import lines.  A capability module that is absent from the
/// manifest is still caught here, which is the whole point.
///
/// ## What "capability module" means normatively
///
/// Matrix L453 — `platform/` holds *"R1–R7 capability platforms"*.  The
/// directory is the definition, so the directory is what is scanned.  Two
/// exclusions are applied and both are traceable:
///   * `domain/person` is rank **7.5** and is a *platform identity*, not a
///     capability (`ADR-0011`, Matrix L72) — it does not live under `platform/`
///     and so never enters the scan;
///   * `lib/bootstrap/di.dart` is the composition root, *"the single place in
///     the codebase permitted to know both a port and its adapter"*, and is
///     under `bootstrap/`, not `platform/`.
///
/// ⚠ This test does not assert the count **16**.  The Matrix row says
/// *"all 16 capability modules"*, but `platform/` currently holds 9 directories
/// because the repository is a skeleton.  Asserting 16 would fail for a reason
/// that has nothing to do with `L4` and would have to be edited every time a
/// platform is added — a test you routinely edit is a test you have stopped
/// reading (`boundary_checker_test.dart`).  What is asserted is the **law over
/// whatever capability modules exist**, which is the invariant the row is
/// protecting.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

final String _repoRoot = Directory.current.path;

/// Every `.dart` file under `lib/platform/`, which Matrix L453 defines as the
/// capability tier.
List<File> _capabilitySources() {
  final dir = Directory('$_repoRoot/lib/platform');
  if (!dir.existsSync()) return const [];
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();
}

/// Matches any import that reaches a domain module, by relative path or by
/// `package:` URI. Both spellings are checked because either would compile.
final RegExp _domainImport = RegExp(
  r'''^\s*(?:import|export)\s+['"]([^'"]+)['"]''',
  multiLine: true,
);

bool _reachesDomain(String uri) {
  // Relative escapes: '../domain/...', '../../domain/...'
  if (RegExp(r'(^|/)domain/').hasMatch(uri)) return true;
  // Absolute package spelling of the same thing.
  if (uri.startsWith('package:liboora/domain/')) return true;
  return false;
}

void main() {
  group('L4 — capability never depends on domain', () {
    test('no file under lib/platform/ imports a domain module', () {
      final sources = _capabilitySources();

      // Guard: if the scan finds nothing, the test is vacuous and must say so
      // rather than pass. A green tick over an empty set is the failure mode
      // `boundary_checker_test.dart` calls "an unmet rule wearing a green
      // tick".
      expect(
        sources,
        isNotEmpty,
        reason:
            'no Dart sources found under lib/platform/ — the L4 scan would be '
            'vacuous. Either the capability tier moved, or this test is '
            'pointed at the wrong root.',
      );

      final violations = <String>[];
      for (final file in sources) {
        final text = file.readAsStringSync();
        for (final match in _domainImport.allMatches(text)) {
          final uri = match.group(1)!;
          if (_reachesDomain(uri)) {
            final rel = file.path.replaceFirst('$_repoRoot/', '');
            violations.add('$rel  ->  $uri');
          }
        }
      }

      expect(
        violations,
        isEmpty,
        reason:
            'L4 violated (MODULE_DEPENDENCY_MATRIX.md L51: a capability module '
            'may NEVER import a domain module). Communicate via '
            'liboora_contracts events or a declared port instead. '
            'Offending imports:\n  ${violations.join('\n  ')}',
      );
    });

    test('the capability tier is scanned from disk, not from the manifest', () {
      // This is a property of the test itself, asserted so that a future
      // refactor cannot quietly narrow the scan to manifest-listed modules
      // and reintroduce the FIL-GAP-010 blind spot.
      final scanned = _capabilitySources()
          .map((f) => f.path.replaceFirst('$_repoRoot/lib/platform/', ''))
          .map((p) => p.split('/').first)
          .toSet();

      final manifest = File('$_repoRoot/tool/module_dependencies.yaml')
          .readAsStringSync();

      // `platform/services` is the known-blockless module (FIL-GAP-010). If it
      // exists on disk it MUST still be scanned even though the manifest has
      // no block for it. That is the blind spot this test refuses to inherit.
      if (Directory('$_repoRoot/lib/platform/services').existsSync()) {
        expect(
          scanned,
          contains('services'),
          reason:
              'platform/services exists on disk but was not scanned. '
              'FIL-GAP-010 records that it has no manifest block, so a '
              'manifest-driven scan would skip it — this test must not.',
        );
        expect(
          manifest.contains('\nplatform/services:\n'),
          isFalse,
          reason:
              'platform/services now HAS a manifest block, which means '
              'FIL-GAP-010 may be closed. Re-read that gap before editing '
              'this expectation — do not simply flip it.',
        );
      }
    });
  });
}
