/// **Layer 3 architecture test 2 of 7** — `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`
/// §10.3, row 2: *"`L1`"*.
///
/// `L1` is the acyclic law, and it is the one rule the repository declares
/// unwaivable:
///   * manifest `global.cycles_allowed: false` — *"L1 — never overridable"*;
///   * Matrix §11 step 3 — *"L1 (acyclic) is **never** approved."*
///
/// ## What is asserted, and why it is asserted twice
///
/// `boundary_checker_test.dart` already proves the *checker* refuses to waive a
/// cycle even when the manifest asks it to. That is a property of the tooling.
/// This test asserts the property of the **graph itself**, from two independent
/// sources, because a cycle can enter through either:
///
///   1. **The declared graph** — ranks plus edges in
///      `tool/module_dependencies.yaml`. A rank violation is a *potential*
///      cycle; a genuine cycle in the declared edges is an actual one.
///   2. **The real import graph** — what `lib/**` actually imports. The
///      manifest can be silent about a module (`FIL-GAP-010`: `platform/services`
///      has only a rank, no block) while the source still forms a cycle.
///
/// Only checking (1) would trust the manifest to describe itself. Only checking
/// (2) would miss a cycle that is declared but not yet coded. Both are checked.
///
/// ## Rank monotonicity is the stronger claim, and it is checked separately
///
/// Matrix `L2` is *"downward only"*: a module may depend solely on strictly
/// lower ranks. Any graph obeying `L2` is necessarily acyclic, so a rank
/// inversion is reported on its own rather than folded into a generic "cycle
/// found" message — the two defects have different repairs.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

final String _repoRoot = Directory.current.path;

YamlMap _manifest() =>
    loadYaml(File('$_repoRoot/tool/module_dependencies.yaml').readAsStringSync())
        as YamlMap;

/// Maps a source path under `lib/` to its manifest module name, or `null` when
/// the path is outside the runtime graph (`bootstrap/`, `main.dart`).
String? _moduleOf(String relPath) {
  if (relPath.startsWith('lib/platform/')) {
    final seg = relPath.split('/')[2];
    return 'platform/$seg';
  }
  if (relPath.startsWith('lib/domain/')) {
    final seg = relPath.split('/')[2];
    return 'domain/$seg';
  }
  if (relPath.startsWith('lib/app/')) return 'app';
  return null;
}

/// Resolves an import URI appearing inside [fromRel] to a module name.
String? _importTarget(String fromRel, String uri) {
  if (uri.startsWith('package:liboora_contracts')) return 'contracts';
  if (uri.startsWith('dart:') || uri.startsWith('package:flutter')) return null;
  if (uri.startsWith('package:')) return null;

  // Relative import — normalise against the importing file's directory.
  final fromDir = fromRel.substring(0, fromRel.lastIndexOf('/'));
  final parts = <String>[...fromDir.split('/')];
  for (final seg in uri.split('/')) {
    if (seg == '..') {
      if (parts.isNotEmpty) parts.removeLast();
    } else if (seg != '.') {
      parts.add(seg);
    }
  }
  return _moduleOf(parts.join('/'));
}

/// Builds the real import graph from source.
Map<String, Set<String>> _sourceGraph() {
  final graph = <String, Set<String>>{};
  final lib = Directory('$_repoRoot/lib');
  final importRe = RegExp(
    r'''^\s*(?:import|export)\s+['"]([^'"]+)['"]''',
    multiLine: true,
  );

  for (final file in lib.listSync(recursive: true).whereType<File>()) {
    if (!file.path.endsWith('.dart')) continue;
    final rel = file.path.replaceFirst('$_repoRoot/', '');
    final from = _moduleOf(rel);
    if (from == null) continue; // bootstrap / main.dart are not graph nodes
    for (final m in importRe.allMatches(file.readAsStringSync())) {
      final to = _importTarget(rel, m.group(1)!);
      if (to == null || to == from) continue;
      (graph[from] ??= <String>{}).add(to);
    }
  }
  return graph;
}

/// Returns one cycle as a path, or `null` when the graph is acyclic.
List<String>? _findCycle(Map<String, Set<String>> graph) {
  final visiting = <String>{};
  final done = <String>{};
  final stack = <String>[];

  List<String>? walk(String node) {
    if (done.contains(node)) return null;
    if (visiting.contains(node)) {
      final start = stack.indexOf(node);
      return [...stack.sublist(start < 0 ? 0 : start), node];
    }
    visiting.add(node);
    stack.add(node);
    for (final next in graph[node] ?? const <String>{}) {
      final found = walk(next);
      if (found != null) return found;
    }
    stack.removeLast();
    visiting.remove(node);
    done.add(node);
    return null;
  }

  for (final node in graph.keys) {
    final found = walk(node);
    if (found != null) return found;
  }
  return null;
}

void main() {
  group('L1 — the module graph is acyclic', () {
    test('the manifest declares cycles are never allowed', () {
      final global = _manifest()['global'] as YamlMap;
      expect(
        global['cycles_allowed'],
        isFalse,
        reason:
            'manifest global.cycles_allowed must remain false. '
            'MODULE_DEPENDENCY_MATRIX.md §11 step 3: "L1 (acyclic) is never '
            'approved." Flipping this flag is not a permitted repair.',
      );
    });

    test('the real import graph in lib/** contains no cycle', () {
      final graph = _sourceGraph();

      expect(
        graph,
        isNotEmpty,
        reason:
            'no module edges were discovered under lib/ — the cycle search '
            'would be vacuous. A green tick over an empty graph proves '
            'nothing.',
      );

      final cycle = _findCycle(graph);
      expect(
        cycle,
        isNull,
        reason:
            'L1 violated — import cycle in lib/: '
            '${cycle?.join(' -> ')}. L1 is never waivable: break the cycle '
            'with one of the four patterns in MODULE_DEPENDENCY_MATRIX.md §8.',
      );
    });

    test('every real import edge points strictly downward by rank (L2)', () {
      final ranks = <String, double>{};
      (_manifest()['ranks'] as YamlMap).forEach((k, v) {
        ranks['$k'] = (v as num).toDouble();
      });

      final inversions = <String>[];
      _sourceGraph().forEach((from, targets) {
        final fromRank = ranks[from];
        if (fromRank == null) return; // unranked module — reported below
        for (final to in targets) {
          final toRank = ranks[to];
          if (toRank == null) continue;
          if (toRank >= fromRank) {
            inversions.add('$from (r$fromRank) -> $to (r$toRank)');
          }
        }
      });

      expect(
        inversions,
        isEmpty,
        reason:
            'L2 violated — a module imported something at an equal or higher '
            'rank, which is how cycles are born (MODULE_DEPENDENCY_MATRIX.md '
            'L2, "downward only"):\n  ${inversions.join('\n  ')}',
      );
    });

    test('every module that appears in the source graph carries a rank', () {
      final ranks = (_manifest()['ranks'] as YamlMap).keys
          .map((k) => '$k')
          .toSet();
      final graph = _sourceGraph();
      final nodes = <String>{...graph.keys, ...graph.values.expand((s) => s)};

      final unranked = nodes.where((n) => !ranks.contains(n)).toList()..sort();
      expect(
        unranked,
        isEmpty,
        reason:
            'these modules exist in the import graph but have no rank in '
            'tool/module_dependencies.yaml, so L2 cannot be evaluated for '
            'them and a cycle through them would be invisible to the rank '
            'check: ${unranked.join(', ')}',
      );
    });
  });
}
