/// **`IMPL-014` — the automated architecture boundary checker.**
///
/// Reads `tool/module_dependencies.yaml` — the normative machine-readable
/// manifest — and fails the build when the code contradicts it.
///
/// **Why this exists.** Every architectural rule in this repository was, until
/// now, enforced by code review. `SID-4.56` states the governing principle:
/// *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied
/// by intent."* By that standard the dependency laws were unmet. `ADR-0011`
/// raised the cost of that gap: rank 7.5 is a *half* rank whose entire purpose
/// is to keep law L2 literally true, and a half rank that nothing verifies is
/// just a comment.
///
/// **What it enforces** (ten categories, each mapped to a law or rule):
///   1. Rank ordering — a module may import only strictly lower ranks (L2).
///   2. Cross-context rules — declared `imports`/`ports` only.
///   3. Forbidden dependencies — per-module `banned_imports` globs.
///   4. Circular dependencies — file-level cycle detection (L1, no exceptions).
///   5. Same-rank violations — forbidden unless inside a declared cluster (L2).
///   6. Layer violations — no capability may import a domain module (L4).
///   7. Illegal imports — the shared kernel imports nothing (L5).
///   8. Ownership violations — a symbol declared outside its owning module.
///   9. Boundary violations — cross-module imports must target the barrel.
///  10. Architecture policies — banned symbols, globally and per layer.
///
/// **Exit codes.** `0` clean, `1` violations found, `2` the checker itself could
/// not run (missing manifest, unparseable YAML). A checker that cannot run must
/// never be mistaken for a clean build.
///
/// Usage:
///   dart run tool/check_module_boundaries.dart [--verbose]
library;

import 'dart:io';

import 'package:yaml/yaml.dart';

// ══════════════════════════════════════════════════════════════════════
// Model
// ══════════════════════════════════════════════════════════════════════

/// A single violation. Carries enough context that a developer can fix it
/// without re-deriving the rule.
final class Violation {
  Violation({
    required this.category,
    required this.rule,
    required this.file,
    required this.detail,
    this.line,
    this.severity = 'error',
    this.consumer,
    this.provider,
  });

  final String category;
  final String rule;
  final String file;
  final String detail;
  final int? line;
  final String severity;

  /// The importing module, when the violation is about an edge. Recorded so a
  /// §11 exception can be matched structurally rather than by string-matching
  /// the human-readable [detail].
  final String? consumer;

  /// The imported module, when the violation is about an edge.
  final String? provider;

  /// Set when a time-boxed §11 exception covers this violation. The violation is
  /// still reported; it just does not fail the build until the ADR expires.
  DependencyException? waiver;

  String get location => line == null ? file : '$file:$line';

  @override
  String toString() => '[$rule] $location\n    $detail';
}

/// A time-boxed, ADR-backed exception, exactly as `MODULE_DEPENDENCY_MATRIX`
/// §11 step 4 prescribes: `{from, to, mode, reason, adr, expires}`.
///
/// Three properties make this a governance record rather than a mute button:
///
///  * It **cannot be created silently.** Every field is required, including the
///    ADR that approved it and the date it dies.
///  * It **stays visible.** A matched violation is still printed, as `DEBT`,
///    with its ADR and expiry. Suppressed-and-forgotten is the failure mode
///    that turns architecture documents into fiction; §11 step 5 exists to
///    prevent it, so the count is reported on every run.
///  * It **expires.** After [expires] the exception stops applying and the
///    violation fails the build again — "debt is time-boxed by the tooling, not
///    by good intentions." An unparseable or absent date is treated as expired,
///    never as permission.
///
/// `L1` (acyclic) is explicitly outside this mechanism: §11 step 3 states it is
/// *never* approved, so [appliesTo] refuses to match a cycle regardless of what
/// the manifest asks for.
final class DependencyException {
  DependencyException({
    required this.from,
    required this.to,
    required this.reason,
    required this.adr,
    required this.expires,
  });

  final String from;
  final String to;
  final String reason;
  final String adr;
  final DateTime? expires;

  bool get isExpired {
    final date = expires;
    if (date == null) return true; // No date = no permission.
    return DateTime.now().isAfter(date);
  }

  String get expiryLabel => expires == null
      ? 'NO EXPIRY DECLARED (treated as expired)'
      : expires!.toIso8601String().split('T').first;

  /// Whether this exception covers [violation].
  ///
  /// Deliberately narrow: it matches only the `cross-context` category, only on
  /// an exact `from`/`to` pair, and never a cycle. Broadening this predicate is
  /// how a governance record decays into a blanket ignore.
  bool appliesTo(Violation violation, String? consumer, String? provider) {
    if (isExpired) return false;
    if (violation.category == 'circular-dependency') return false; // L1.
    if (violation.category != 'cross-context') return false;
    return consumer == from && provider == to;
  }
}

/// A module as declared in the manifest.
final class Module {
  Module({
    required this.name,
    required this.rank,
    required this.path,
    required this.bannedImports,
    required this.bannedSymbols,
    required this.bannedSymbolsInDomainLayer,
    required this.allowedImports,
    required this.declaredImports,
    required this.contexts,
    required this.classification,
  });

  final String name;
  final double rank;
  final String path;
  final List<String> bannedImports;
  final List<({String symbol, String useInstead})> bannedSymbols;
  final List<({String symbol, String useInstead})> bannedSymbolsInDomainLayer;
  final List<String> allowedImports;

  /// Module names this module may import at compile time (`mode: import`).
  final List<String> declaredImports;
  final List<String> contexts;
  final String? classification;
}

// ══════════════════════════════════════════════════════════════════════
// Entry point
// ══════════════════════════════════════════════════════════════════════

void main(List<String> args) {
  final verbose = args.contains('--verbose') || args.contains('-v');
  final checker = BoundaryChecker(verbose: verbose);

  final int exitCode;
  try {
    exitCode = checker.run();
  } on _CheckerError catch (e) {
    stderr.writeln('BOUNDARY CHECKER COULD NOT RUN');
    stderr.writeln('  ${e.message}');
    stderr.writeln(
      '\nExiting 2. A checker that cannot run is not a clean build.',
    );
    exit(2);
  }
  exit(exitCode);
}

final class _CheckerError implements Exception {
  _CheckerError(this.message);
  final String message;
}

// ══════════════════════════════════════════════════════════════════════
// Checker
// ══════════════════════════════════════════════════════════════════════

final class BoundaryChecker {
  BoundaryChecker({this.verbose = false});

  final bool verbose;
  final List<Violation> violations = [];

  late final Map<String, double> _ranks;
  late final Map<String, Module> _modules;
  late final YamlMap _manifest;
  late final bool _barrelOnly;

  /// Time-boxed §11 exceptions. Empty is the healthy state.
  late final List<DependencyException> _exceptions;

  /// Intra-cluster edges, declared per module. Same-rank imports are legal only
  /// between contexts listed here (the two L2 cluster exceptions).
  final Map<String, Set<String>> _clusterContexts = {};

  int run() {
    _loadManifest();
    final files = _dartFiles();

    if (files.isEmpty) {
      throw _CheckerError('No Dart source files found under lib/ or packages/.');
    }

    _log('Manifest: ${_ranks.length} ranks, ${_modules.length} modules');
    _log('Scanning ${files.length} Dart files\n');

    final graph = <String, Set<String>>{};

    for (final file in files) {
      final content = file.readAsStringSync();
      final imports = _parseImports(content);
      final module = _moduleFor(file.path);

      graph[file.path] = imports
          .map((i) => _resolveImport(i.uri, file.path))
          .whereType<String>()
          .toSet();

      _checkIllegalImports(file, module, imports); // L5 + category 7
      _checkForbiddenDependencies(file, module, imports); // category 3
      _checkRankOrdering(file, module, imports); // L2 + categories 1, 5
      _checkLayerViolations(file, module, imports); // L4 + category 6
      _checkCrossContextRules(file, module, imports); // category 2
      _checkBarrelOnly(file, module, imports); // category 9
      _checkArchitecturePolicies(file, module, content); // category 10
      _checkOwnership(file, module, content); // category 8
    }

    _checkCircularDependencies(graph); // L1 + category 4

    return _report();
  }

  // ────────────────────────────────────────────────────────────────
  // Manifest
  // ────────────────────────────────────────────────────────────────

  /// Parses the `exceptions:` list into [DependencyException] records.
  ///
  /// A malformed entry is a **checker error**, not a skipped line. If someone
  /// adds an exception without an ADR or an expiry date, the correct outcome is
  /// a loud failure telling them what §11 requires — silently ignoring the
  /// entry would hide both the exception and the debt it represents.
  List<DependencyException> _parseExceptions(Object? node) {
    if (node == null) return const [];
    if (node is! YamlList) {
      throw _CheckerError('`exceptions:` must be a list.');
    }

    final result = <DependencyException>[];
    for (var i = 0; i < node.length; i++) {
      final entry = node[i];
      if (entry is! YamlMap) {
        throw _CheckerError('exceptions[$i] is not a mapping.');
      }

      String required(String key) {
        final value = entry[key];
        if (value == null || value.toString().trim().isEmpty) {
          throw _CheckerError(
            'exceptions[$i] is missing `$key`. MODULE_DEPENDENCY_MATRIX §11 '
            'requires from, to, reason, adr and expires on every exception.',
          );
        }
        return value.toString();
      }

      final from = required('from');
      final to = required('to');
      final reason = required('reason');
      final adr = required('adr');
      final rawExpiry = required('expires');

      final expires = DateTime.tryParse(rawExpiry);
      if (expires == null) {
        throw _CheckerError(
          'exceptions[$i] has an unparseable `expires` value "$rawExpiry". '
          'Use YYYY-MM-DD.',
        );
      }

      if (!_ranks.containsKey(from) || !_ranks.containsKey(to)) {
        throw _CheckerError(
          'exceptions[$i] names an unknown module ($from -> $to).',
        );
      }

      result.add(
        DependencyException(
          from: from,
          to: to,
          reason: reason,
          adr: adr,
          expires: expires,
        ),
      );
    }
    return result;
  }

  void _loadManifest() {
    final file = File('tool/module_dependencies.yaml');
    if (!file.existsSync()) {
      throw _CheckerError(
        'tool/module_dependencies.yaml not found. '
        'Run from the repository root.',
      );
    }

    final YamlMap doc;
    try {
      final parsed = loadYaml(file.readAsStringSync());
      if (parsed is! YamlMap) {
        throw _CheckerError('Manifest root is not a mapping.');
      }
      doc = parsed;
    } on YamlException catch (e) {
      throw _CheckerError('Manifest is not valid YAML: $e');
    }
    _manifest = doc;

    final rawRanks = doc['ranks'];
    if (rawRanks is! YamlMap || rawRanks.isEmpty) {
      throw _CheckerError('Manifest declares no ranks.');
    }
    _ranks = {
      for (final e in rawRanks.entries)
        e.key.toString(): (e.value as num).toDouble(),
    };

    final global = doc['global'];
    _barrelOnly =
        global is YamlMap && global['barrel_only_cross_module'] == true;

    _exceptions = _parseExceptions(doc['exceptions']);

    _modules = {};
    for (final name in _ranks.keys) {
      final block = doc[name];
      final blockMap = block is YamlMap ? block : null;
      _modules[name] = Module(
        name: name,
        rank: _ranks[name]!,
        path: blockMap?['path']?.toString() ?? _defaultPath(name),
        bannedImports: _stringList(blockMap?['banned_imports']),
        bannedSymbols: _symbolList(blockMap?['banned_symbols']),
        bannedSymbolsInDomainLayer: _symbolList(
          blockMap?['banned_symbols_in_domain_layer'],
        ),
        allowedImports: _stringList(blockMap?['allowed_imports']),
        declaredImports: _declaredImports(blockMap?['imports']),
        contexts: _stringList(blockMap?['contexts']),
        classification: blockMap?['classification']?.toString(),
      );

      // Record declared intra-cluster edges for the same-rank check.
      final edges = blockMap?['internal_edges'];
      if (edges is YamlList) {
        final set = <String>{};
        for (final e in edges) {
          if (e is YamlMap) {
            final from = e['from'];
            final to = e['to'];
            if (from != null) set.add(from.toString());
            if (to is YamlList) {
              set.addAll(to.map((t) => t.toString()));
            } else if (to != null) {
              set.add(to.toString());
            }
          }
        }
        _clusterContexts[name] = set;
      }
    }
  }

  String _defaultPath(String module) {
    if (module == 'contracts') return 'packages/liboora_contracts/lib';
    if (module == 'app') return 'lib/app';
    return 'lib/$module';
  }

  List<String> _stringList(Object? node) {
    if (node is YamlList) return node.map((e) => e.toString()).toList();
    return const [];
  }

  List<({String symbol, String useInstead})> _symbolList(Object? node) {
    if (node is! YamlList) return const [];
    final out = <({String symbol, String useInstead})>[];
    for (final e in node) {
      if (e is YamlMap) {
        final s = e['symbol']?.toString();
        if (s != null) {
          out.add((symbol: s, useInstead: e['use_instead']?.toString() ?? ''));
        }
      }
    }
    return out;
  }

  /// `imports:` entries with `mode: import` are the only compile-time module
  /// dependencies a module may have. Everything else is a port or an event.
  List<String> _declaredImports(Object? node) {
    if (node is! YamlList) return const [];
    final out = <String>[];
    for (final e in node) {
      if (e is YamlMap && (e['mode']?.toString() ?? 'import') == 'import') {
        final t = e['target']?.toString();
        if (t != null) out.add(t);
      }
    }
    return out;
  }

  // ────────────────────────────────────────────────────────────────
  // File discovery and import parsing
  // ────────────────────────────────────────────────────────────────

  List<File> _dartFiles() {
    final roots = ['lib', 'packages'];
    final out = <File>[];
    for (final root in roots) {
      final dir = Directory(root);
      if (!dir.existsSync()) continue;
      for (final entity in dir.listSync(recursive: true, followLinks: false)) {
        if (entity is! File) continue;
        if (!entity.path.endsWith('.dart')) continue;
        if (entity.path.contains('/.dart_tool/')) continue;
        if (entity.path.endsWith('.g.dart')) continue;
        if (entity.path.endsWith('.freezed.dart')) continue;
        out.add(entity);
      }
    }
    out.sort((a, b) => a.path.compareTo(b.path));
    return out;
  }

  /// Line-based import extraction.
  ///
  /// Deliberately not an AST parse: the checker must run with no build step and
  /// no analyzer dependency, so it stays usable in CI even when the project does
  /// not compile — which is exactly when a boundary regression is most likely.
  List<({String uri, int line})> _parseImports(String content) {
    final out = <({String uri, int line})>[];
    final lines = content.split('\n');
    var inBlockComment = false;

    for (var i = 0; i < lines.length; i++) {
      var line = lines[i].trim();

      if (inBlockComment) {
        final end = line.indexOf('*/');
        if (end == -1) continue;
        line = line.substring(end + 2).trim();
        inBlockComment = false;
      }
      final blockStart = line.indexOf('/*');
      if (blockStart != -1) {
        line = line.substring(0, blockStart).trim();
        inBlockComment = !line.contains('*/');
      }
      if (line.startsWith('//') || line.isEmpty) continue;

      final match = RegExp(
        r'''^\s*(?:import|export)\s+['"]([^'"]+)['"]''',
      ).firstMatch(line);
      if (match != null) {
        out.add((uri: match.group(1)!, line: i + 1));
      }
    }
    return out;
  }

  /// The module a path belongs to. Longest declared path wins, so
  /// `lib/domain/person` beats a hypothetical `lib/domain`.
  Module? _moduleFor(String path) {
    final normalised = path.startsWith('./') ? path.substring(2) : path;
    Module? best;
    for (final m in _modules.values) {
      if (normalised.startsWith('${m.path}/') || normalised == m.path) {
        if (best == null || m.path.length > best.path.length) best = m;
      }
    }
    return best;
  }

  /// Resolve an import URI to a repository path, or null when external.
  String? _resolveImport(String uri, String fromPath) {
    if (uri.startsWith('dart:')) return null;

    if (uri.startsWith('package:liboora_contracts/')) {
      return 'packages/liboora_contracts/lib/'
          '${uri.substring('package:liboora_contracts/'.length)}';
    }
    if (uri.startsWith('package:liboora/')) {
      return 'lib/${uri.substring('package:liboora/'.length)}';
    }
    if (uri.startsWith('package:')) return null;

    // Relative import.
    final dir = fromPath.contains('/')
        ? fromPath.substring(0, fromPath.lastIndexOf('/'))
        : '.';
    final segments = <String>[...dir.split('/'), ...uri.split('/')];
    final stack = <String>[];
    for (final s in segments) {
      if (s == '.' || s.isEmpty) continue;
      if (s == '..') {
        if (stack.isNotEmpty) stack.removeLast();
      } else {
        stack.add(s);
      }
    }
    return stack.join('/');
  }

  /// The module an import URI targets, or null when external/unresolvable.
  Module? _targetModule(String uri, String fromPath) {
    final resolved = _resolveImport(uri, fromPath);
    if (resolved == null) return null;
    return _moduleFor(resolved);
  }

  // ────────────────────────────────────────────────────────────────
  // 7 + L5 — illegal imports
  // ────────────────────────────────────────────────────────────────

  void _checkIllegalImports(
    File file,
    Module? module,
    List<({String uri, int line})> imports,
  ) {
    if (module == null) return;

    // L5: the shared kernel imports nothing beyond a declared allow-list.
    if (module.name == 'contracts') {
      for (final imp in imports) {
        final uri = imp.uri;
        if (uri.startsWith('package:')) {
          violations.add(
            Violation(
              category: 'illegal-import',
              rule: 'L5',
              file: file.path,
              line: imp.line,
              detail:
                  'The shared kernel imports nothing. Found "$uri". '
                  'A kernel that imports anything is a transitive backdoor '
                  'around L2 and L4.',
            ),
          );
          continue;
        }
        if (uri.startsWith('dart:') &&
            module.allowedImports.isNotEmpty &&
            !module.allowedImports.contains(uri)) {
          violations.add(
            Violation(
              category: 'illegal-import',
              rule: 'L5',
              file: file.path,
              line: imp.line,
              detail:
                  '"$uri" is not in the kernel allow-list '
                  '(${module.allowedImports.join(", ")}).',
            ),
          );
        }
      }
    }
  }

  // ────────────────────────────────────────────────────────────────
  // 3 — forbidden dependencies (banned_imports globs)
  // ────────────────────────────────────────────────────────────────

  void _checkForbiddenDependencies(
    File file,
    Module? module,
    List<({String uri, int line})> imports,
  ) {
    if (module == null) return;

    for (final imp in imports) {
      for (final banned in module.bannedImports) {
        final resolved = _resolveImport(imp.uri, file.path);
        final candidates = <String>[imp.uri, if (resolved != null) resolved];
        // Module-relative form, e.g. "domain/social/social.dart".
        if (resolved != null && resolved.startsWith('lib/')) {
          candidates.add(resolved.substring(4));
        }
        if (candidates.any((c) => _globMatch(banned, c))) {
          violations.add(
            Violation(
              category: 'forbidden-dependency',
              rule: 'banned_imports',
              file: file.path,
              line: imp.line,
              detail:
                  'Module "${module.name}" must not import "$banned". '
                  'Found "${imp.uri}".',
            ),
          );
          break;
        }
      }
    }
  }

  bool _globMatch(String pattern, String value) {
    final escaped = RegExp.escape(pattern)
        .replaceAll(r'\*\*', '\u0000DOUBLE\u0000')
        .replaceAll(r'\*', '[^/]*')
        .replaceAll('\u0000DOUBLE\u0000', '.*');
    return RegExp('^$escaped').hasMatch(value) ||
        RegExp('^$escaped\$').hasMatch(value);
  }

  // ────────────────────────────────────────────────────────────────
  // 1 + 5 + L2 — rank ordering and same-rank violations
  // ────────────────────────────────────────────────────────────────

  void _checkRankOrdering(
    File file,
    Module? module,
    List<({String uri, int line})> imports,
  ) {
    if (module == null) return;

    for (final imp in imports) {
      final target = _targetModule(imp.uri, file.path);
      if (target == null || target.name == module.name) continue;

      if (target.rank > module.rank) {
        violations.add(
          Violation(
            category: 'rank-ordering',
            rule: 'L2',
            file: file.path,
            line: imp.line,
            detail:
                'Upward dependency: "${module.name}" (rank ${_fmt(module.rank)}) '
                'imports "${target.name}" (rank ${_fmt(target.rank)}). '
                'A module may depend only on strictly lower ranks. '
                'Invert it with a port declared in contracts.',
          ),
        );
      } else if (target.rank == module.rank) {
        violations.add(
          Violation(
            category: 'same-rank',
            rule: 'L2',
            file: file.path,
            line: imp.line,
            detail:
                'Same-rank dependency: "${module.name}" imports "${target.name}", '
                'both at rank ${_fmt(module.rank)}. Forbidden outside a declared '
                'cluster. Use an event or a port.',
          ),
        );
      }
    }
  }

  String _fmt(double d) =>
      d == d.roundToDouble() ? d.toInt().toString() : d.toString();

  // ────────────────────────────────────────────────────────────────
  // 6 + L4 — layer violations
  // ────────────────────────────────────────────────────────────────

  void _checkLayerViolations(
    File file,
    Module? module,
    List<({String uri, int line})> imports,
  ) {
    if (module == null) return;
    if (!module.name.startsWith('platform/')) return;

    for (final imp in imports) {
      final target = _targetModule(imp.uri, file.path);
      if (target == null) continue;
      if (target.name.startsWith('domain/') || target.name == 'app') {
        violations.add(
          Violation(
            category: 'layer-violation',
            rule: 'L4',
            file: file.path,
            line: imp.line,
            detail:
                'Capability "${module.name}" imports "${target.name}". '
                'No capability may import a domain module — ever. This is the '
                'rule that keeps service extraction a deployment change rather '
                'than a rewrite. Communicate via contracts events or a port.',
          ),
        );
      }
    }
  }

  // ────────────────────────────────────────────────────────────────
  // 2 — cross-context rules: only declared compile-time imports
  // ────────────────────────────────────────────────────────────────

  void _checkCrossContextRules(
    File file,
    Module? module,
    List<({String uri, int line})> imports,
  ) {
    if (module == null) return;
    // The composition root is the one place permitted to know a port and its
    // adapter, so its imports are governed by banned_imports alone.
    if (_isCompositionRoot(file.path)) return;
    if (module.declaredImports.isEmpty) return;

    for (final imp in imports) {
      final target = _targetModule(imp.uri, file.path);
      if (target == null || target.name == module.name) continue;
      if (target.rank >= module.rank) continue; // reported by the rank check

      if (!module.declaredImports.contains(target.name)) {
        violations.add(
          Violation(
            category: 'cross-context',
            rule: 'default_decision: deny',
            file: file.path,
            line: imp.line,
            detail:
                '"${module.name}" imports "${target.name}", which it does not '
                'declare as `mode: import`. Declared compile-time imports: '
                '${module.declaredImports.join(", ")}. Anything else must be a '
                'port, an event or a command.',
            consumer: module.name,
            provider: target.name,
          ),
        );
      }
    }
  }

  bool _isCompositionRoot(String path) =>
      path.endsWith('lib/bootstrap/di.dart') ||
      path.endsWith('lib/bootstrap/seed.dart') ||
      path.endsWith('lib/main.dart');

  // ────────────────────────────────────────────────────────────────
  // 9 — barrel-only cross-module imports
  // ────────────────────────────────────────────────────────────────

  void _checkBarrelOnly(
    File file,
    Module? module,
    List<({String uri, int line})> imports,
  ) {
    if (!_barrelOnly || module == null) return;

    for (final imp in imports) {
      final resolved = _resolveImport(imp.uri, file.path);
      if (resolved == null) continue;
      final target = _moduleFor(resolved);
      if (target == null || target.name == module.name) continue;
      if (target.name == 'contracts') continue; // package barrel, already public

      // Permitted: <path>/<leaf>.dart where leaf is the module's own barrel.
      final relative = resolved.substring(target.path.length + 1);
      final depth = relative.split('/').length;
      final looksLikeBarrel = depth <= 2;

      if (!looksLikeBarrel) {
        violations.add(
          Violation(
            category: 'boundary-violation',
            rule: 'barrel_only_cross_module',
            file: file.path,
            line: imp.line,
            detail:
                'Cross-module import reaches into "${target.name}" internals: '
                '"$relative". Import the module barrel instead. Reaching past a '
                'barrel couples callers to a layout that is free to change.',
          ),
        );
      }
    }
  }

  // ────────────────────────────────────────────────────────────────
  // 10 — architecture policies (banned symbols)
  // ────────────────────────────────────────────────────────────────

  void _checkArchitecturePolicies(File file, Module? module, String content) {
    if (module == null) return;

    final lines = content.split('\n');
    final isDomainLayer =
        module.name.startsWith('domain/') &&
        !file.path.contains('/infrastructure/');

    void scan(
      List<({String symbol, String useInstead})> banned,
      String ruleId,
    ) {
      for (final entry in banned) {
        for (var i = 0; i < lines.length; i++) {
          final line = lines[i];
          final code = _stripComment(line);
          if (code.contains(entry.symbol)) {
            violations.add(
              Violation(
                category: 'architecture-policy',
                rule: ruleId,
                file: file.path,
                line: i + 1,
                detail:
                    'Banned symbol "${entry.symbol}" in "${module.name}". '
                    '${entry.useInstead.isEmpty ? "" : "Use instead: ${entry.useInstead}."}',
              ),
            );
          }
        }
      }
    }

    scan(module.bannedSymbols, 'banned_symbols');
    if (isDomainLayer) {
      scan(module.bannedSymbolsInDomainLayer, 'banned_symbols_in_domain_layer');
    }
  }

  String _stripComment(String line) {
    final idx = line.indexOf('//');
    return idx == -1 ? line : line.substring(0, idx);
  }

  // ────────────────────────────────────────────────────────────────
  // 8 — ownership violations
  // ────────────────────────────────────────────────────────────────

  /// Symbols that may be *declared* only inside their owning module.
  ///
  /// This is the check that would have caught the pre-`ADR-0011` layout, where
  /// the global identity aggregate was declared inside `domain/social`.
  static const Map<String, String> _symbolOwners = {
    'PersonIdentity': 'domain/person',
    'PersonIdentityRepository': 'domain/person',
    'PersonIdentityService': 'domain/person',
    'IdentityDirectory': 'domain/person',
    'StudentRecord': 'domain/library',
    'AuthService': 'platform/identity',
    'PolicyDecisionPoint': 'platform/identity',
  };

  void _checkOwnership(File file, Module? module, String content) {
    if (module == null) return;
    final lines = content.split('\n');

    for (final entry in _symbolOwners.entries) {
      final pattern = RegExp(
        '^\\s*(?:final\\s+|abstract\\s+|base\\s+|interface\\s+|sealed\\s+'
        '|mixin\\s+)*class\\s+${RegExp.escape(entry.key)}\\b',
      );
      for (var i = 0; i < lines.length; i++) {
        if (!pattern.hasMatch(lines[i])) continue;
        if (module.name != entry.value) {
          violations.add(
            Violation(
              category: 'ownership-violation',
              rule: 'module ownership',
              file: file.path,
              line: i + 1,
              detail:
                  '"${entry.key}" is owned by "${entry.value}" but is declared '
                  'in "${module.name}". Ownership is part of the bounded '
                  'context map, not a file-layout preference.',
            ),
          );
        }
      }
    }
  }

  // ────────────────────────────────────────────────────────────────
  // 4 + L1 — circular dependencies
  // ────────────────────────────────────────────────────────────────

  void _checkCircularDependencies(Map<String, Set<String>> graph) {
    final state = <String, int>{}; // 0 unvisited, 1 on stack, 2 done
    final stack = <String>[];
    final reported = <String>{};

    void visit(String node) {
      final s = state[node] ?? 0;
      if (s == 2) return;
      if (s == 1) {
        final start = stack.indexOf(node);
        final cycle = [...stack.sublist(start), node];
        final key = (List.of(cycle)..sort()).join('|');
        if (reported.add(key)) {
          violations.add(
            Violation(
              category: 'circular-dependency',
              rule: 'L1',
              file: cycle.first,
              detail:
                  'Import cycle (L1 has zero exceptions):\n'
                  '      ${cycle.join('\n   -> ')}',
            ),
          );
        }
        return;
      }
      state[node] = 1;
      stack.add(node);
      for (final next in graph[node] ?? const <String>{}) {
        if (graph.containsKey(next)) visit(next);
      }
      stack.removeLast();
      state[node] = 2;
    }

    for (final node in graph.keys) {
      visit(node);
    }
  }

  // ────────────────────────────────────────────────────────────────
  // Reporting
  // ────────────────────────────────────────────────────────────────

  void _log(String msg) {
    if (verbose) stdout.writeln(msg);
  }

  /// Attaches any applicable §11 exception to each violation.
  ///
  /// Called once, before reporting, so that the report can distinguish
  /// build-breaking violations from acknowledged, dated, ADR-backed debt.
  void _applyExceptions() {
    if (_exceptions.isEmpty) return;
    for (final v in violations) {
      for (final e in _exceptions) {
        if (e.appliesTo(v, v.consumer, v.provider)) {
          v.waiver = e;
          break;
        }
      }
    }
  }

  int _report() {
    _applyExceptions();

    final version = _manifest['version'];
    stdout.writeln('─' * 72);
    stdout.writeln('LIBOORA architecture boundary check (IMPL-014)');
    stdout.writeln('Manifest version $version · ${_modules.length} modules');
    stdout.writeln('─' * 72);

    if (violations.isEmpty) {
      stdout.writeln('PASS — no boundary violations found.');
      stdout.writeln('');
      stdout.writeln('Enforced: L1 acyclic · L2 downward-only · L3 ports ·');
      stdout.writeln('          L4 capability-never-domain · L5 kernel-imports-nothing');
      stdout.writeln('          + ownership, barrel, banned-symbol policies');
      return 0;
    }

    final blocking = violations.where((v) => v.waiver == null).toList();
    final waived = violations.where((v) => v.waiver != null).toList();

    if (blocking.isNotEmpty) {
      final byCategory = <String, List<Violation>>{};
      for (final v in blocking) {
        byCategory.putIfAbsent(v.category, () => []).add(v);
      }

      stdout.writeln(
        'FAIL — ${blocking.length} violation(s) '
        'in ${byCategory.length} category(ies).\n',
      );

      final categories = byCategory.keys.toList()..sort();
      for (final category in categories) {
        final list = byCategory[category]!;
        stdout.writeln('■ $category (${list.length})');
        for (final v in list) {
          stdout.writeln('  ${v.rule.padRight(24)} ${v.location}');
          stdout.writeln('      ${v.detail.replaceAll('\n', '\n      ')}');
        }
        stdout.writeln('');
      }
    }

    // Waived findings are printed whether or not the build fails. An exception
    // that stops being visible stops being debt and becomes an assumption.
    if (waived.isNotEmpty) {
      final byEdge = <String, List<Violation>>{};
      for (final v in waived) {
        byEdge.putIfAbsent('${v.consumer} -> ${v.provider}', () => []).add(v);
      }

      stdout.writeln(
        '□ ACKNOWLEDGED DEBT — ${waived.length} finding(s) across '
        '${byEdge.length} edge(s), each covered by a dated ADR (§11).',
      );
      final edges = byEdge.keys.toList()..sort();
      for (final edge in edges) {
        final list = byEdge[edge]!;
        final w = list.first.waiver!;
        stdout.writeln('  $edge — ${list.length} site(s)');
        stdout.writeln('      ${w.adr} · expires ${w.expiryLabel}');
        stdout.writeln('      ${w.reason}');
      }
      stdout.writeln('');
    }

    stdout.writeln('─' * 72);

    if (blocking.isEmpty) {
      stdout.writeln(
        'PASS — no un-waived boundary violations. '
        '${waived.length} finding(s) remain as dated debt above; each fails '
        'this build again once its ADR expires.',
      );
      return 0;
    }

    stdout.writeln(
      'Architecture rules are normative. Fix the code, or amend '
      'tool/module_dependencies.yaml through an ADR — never silence the check.',
    );
    return 1;
  }
}
