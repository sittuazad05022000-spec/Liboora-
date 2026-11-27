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
/// **What it enforces** (twelve categories, each mapped to a law or rule):
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
///  11. Audit mutation — a banned method name is declared (`X-10`, `AU-1`).
///  12. Tenant keys — an `X-13` surface built without a tenant scope.
///
/// **Category 13–17 · SID-INT** (added additively by ADR-0178, IMPL-220):
/// five executable `SID-DET` criteria of Accepted `ADR-0125` (§3, §4, §5,
/// §6, §8 — semantics quoted, never redefined), all scoped to
/// `domain/person`:
///  13. Credential members (ID-1/SID-INT-5) — a declared member name
///      matching a credential class (`SID-INV-5` ∩
///      `global.observability_plane.banned_content`).
///  14. Cached authorisation decisions (MP-GBR-26/X-13/SID-INT-6) — a
///      `policy_decision` port result stored in a field/static/top-level,
///      collection or memo.
///  15. Audit references (E-20/SID-INT-8) — a `platform/audit` import or
///      declared type in `domain/person`.
///  16. Undeclared store access (X-07/X-08/SID-INT-9) — another module's
///      repository/store/table/index/query type reached outside the module's
///      declared ports (port/type limb only; the string-literal limb awaits
///      artifact A1).
///  17. Cross-context aggregation (AR-1/SID-INT-11) — a declared type in
///      `domain/person` holding fields from two or more contexts.
///
/// **Categories 11 and 12 were the last two gaps.** Both rules were declared in
/// the manifest from the beginning — `banned_method_names` on `platform/audit`
/// and `global.tenant_key_required_in` — but this checker never read either key,
/// so the matrix recorded enforcement as *"10 of 12"* and both rules as
/// **unmet** under `SID-4.56`. The fix was to read the manifest that already
/// existed, not to add a rule or to soften one.
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
    required this.declaredPorts,
    required this.contexts,
    required this.classification,
    required this.bannedMethodNames,
  });

  final String name;
  final double rank;
  final String path;
  final List<String> bannedImports;
  final List<({String symbol, String useInstead})> bannedSymbols;
  final List<({String symbol, String useInstead})> bannedSymbolsInDomainLayer;
  final List<String> allowedImports;

  /// Method-name globs this module may not *declare* (`banned_method_names`).
  ///
  /// Declared on `platform/audit` as `["update*", "delete*", "purge*",
  /// "modify*"]` to enforce forbidden edge `X-10`. This key existed in the
  /// manifest from the start but was never read, which is precisely why the
  /// rule counted as unmet under `SID-4.56`.
  final List<String> bannedMethodNames;

  /// Module names this module may import at compile time (`mode: import`).
  final List<String> declaredImports;

  /// Port URIs this module declares (`ports:` entries, e.g.
  /// `platform/identity:policy_decision`). Manifest-derived data read for the
  /// `sid-int` checks (ADR-0178 §4.1): the declared allow-list that
  /// `SID-DET-9` checks persistence access against, and the port whose
  /// presence switches `SID-DET-6` on.
  final List<String> declaredPorts;

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

  /// `global.tenant_key_required_in` — the surfaces `X-13` governs. Non-empty
  /// is what switches the tenant-key check on; the checker never hard-codes
  /// this list, so widening `X-13` is a manifest edit, not a code edit.
  late final List<String> _tenantKeySurfaces;

  /// `global.observability_plane.banned_content` classes, read defensively.
  /// Empty when the manifest omits them, in which case the SID-INT checks
  /// degrade silently (authority absent ⇒ criterion not asserted).
  late final List<String> _bannedContentClasses;

  /// `global.tenant_key_violation_severity`. Declared `blocker`; carried into
  /// the violation so the report cannot understate a cross-tenant leak.
  late final String _tenantKeySeverity;

  /// Time-boxed §11 exceptions. Empty is the healthy state.
  late final List<DependencyException> _exceptions;

  /// Intra-cluster edges, declared per module. Same-rank imports are legal only
  /// between contexts listed here (the two L2 cluster exceptions).
  final Map<String, Set<String>> _clusterContexts = {};

  int run() {
    _loadManifest();
    final files = _dartFiles();

    if (files.isEmpty) {
      throw _CheckerError(
        'No Dart source files found under lib/ or packages/.',
      );
    }

    _log('Manifest: ${_ranks.length} ranks, ${_modules.length} modules');
    _log('Scanning ${files.length} Dart files\n');

    final graph = <String, Set<String>>{};

    // SID-INT pre-pass (ADR-0178 §4.1): a cheap line-based map from every
    // top-level declared type name to the module that owns it, used by the
    // SID-DET-9 and SID-DET-11 checks. Second pass over the same files; no
    // AST, consistent with _parseImports.
    final typeOwner = _buildTypeOwnerMap(files);

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
      _checkAuditMutation(file, module, content); // X-10 + category 11
      _checkTenantKey(file, module, content); // X-13 + category 12
      // 13–17 · SID-INT (ADR-0178) — scoped to domain/person; each self-gates.
      _checkSidInt5Credentials(file, module, content);
      _checkSidInt6DecisionCaching(file, module, content);
      _checkSidInt8AuditReference(file, module, content, imports);
      _checkSidInt9UndeclaredStore(file, module, content, typeOwner);
      _checkSidInt11CrossContextFields(file, module, content, typeOwner);
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

    // X-13 configuration. Read from the manifest rather than hard-coded so the
    // rule stays defined in one normative place.
    _tenantKeySurfaces = global is YamlMap
        ? _stringList(global['tenant_key_required_in'])
        : const [];
    _tenantKeySeverity =
        (global is YamlMap
            ? global['tenant_key_violation_severity']?.toString()
            : null) ??
        'blocker';

    // `global.observability_plane.banned_content` — the credential-class
    // classes ADR-0125 §3 row 4 intersects with SID-INV-5 to derive the
    // SID-DET-5 token set. Read defensively: absent (or malformed) means the
    // criterion is not asserted, never a checker error — the checks degrade,
    // they do not fail with exit 2.
    _bannedContentClasses = global is YamlMap
        ? _stringList(
            (global['observability_plane'] as YamlMap?)?['banned_content'],
          )
        : const [];

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
        declaredPorts: _stringList(blockMap?['ports']),
        contexts: _stringList(blockMap?['contexts']),
        classification: blockMap?['classification']?.toString(),
        bannedMethodNames: _stringList(blockMap?['banned_method_names']),
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

  /// **16 · SID-INT-9 — reading another context's tables or index**
  /// (`X-07/X-08 · SID-INT-9`).
  ///
  /// ADR-0125 §6 (`SID-DET-9`, **port/type limb only**): every persistence or
  /// index access from `domain/person` MUST resolve to a port declared for
  /// `domain/person` in the manifest. Mechanically: a type reference in a
  /// type position (field type, parameter type, local declaration,
  /// extends/implements clause) whose name ends in `Repository`/`Store`/
  /// `Table`/`Index`/`Query` and whose **owning module** (from the
  /// [_buildTypeOwnerMap] pre-pass) is neither `domain/person` itself, nor
  /// `contracts` (rank 0), nor absent (unknown types under-match). `SID-4.6`:
  /// this module SHALL ask through a declared synchronous port and SHALL NOT
  /// read another context's store. The manifest's eight declared ports under
  /// `default_decision: deny` are the allow-list by construction.
  ///
  /// NOT violations (ADR-0125 §6 row 5): the module's **own** repository
  /// (`PersonIdentityRepository`, `InMemoryPersonIdentityRepository`);
  /// `contracts` types (rank 0 — e.g. `DurableKeyValueStore`); a member *name*
  /// containing e.g. `Index` is not a *type* reference; dart: core types
  /// never match the suffix set.
  ///
  /// ⚠⚠ **String-literal limb NOT implemented** (ADR-0125 §6 ⚠⚠): a raw
  /// table/index name passed as a string to a declared generic port (e.g.
  /// `repository.query('bc01_student_records')`) is invisible to this check.
  /// Detecting it requires artifact **A1** (a per-context table/index name
  /// inventory), which does not exist anywhere in the repository and is NOT
  /// created here (ADR-0178 §7). The residue stays under `SID-4.56`; the rule
  /// is not narrowed to the check.
  void _checkSidInt9UndeclaredStore(
    File file,
    Module? module,
    String content,
    Map<String, String> typeOwner,
  ) {
    if (module == null || !_isDomainPerson(module)) return;
    if (module.declaredPorts.isEmpty) return; // No allow-list ⇒ not asserted.

    final storeType = RegExp(
      r'\b([A-Za-z_]\w*(?:Repository|Store|Table|Index|Query))\b',
    );
    final lines = content.split('\n');
    for (var i = 0; i < lines.length; i++) {
      final code = _codeOrEmpty(lines[i]);
      if (code.isEmpty) continue;

      for (final match in storeType.allMatches(code)) {
        final typeName = match.group(1)!;
        final owner = typeOwner[typeName];
        if (owner == null) continue; // Unknown type: under-match.
        if (owner == 'domain/person') continue; // Own repository: sanctioned.
        if (owner == 'contracts') continue; // Rank 0: not another context.

        violations.add(
          Violation(
            category: 'sid-int',
            rule: 'X-07/X-08 · SID-INT-9',
            file: file.path,
            line: i + 1,
            severity: 'blocker',
            consumer: module.name,
            provider: owner,
            detail:
                'Persistence/index type "$typeName" (owned by "$owner") is '
                'referenced in domain/person outside its declared ports '
                '(ADR-0125 §6, SID-DET-9, port/type limb). SID-4.6: ask '
                'through a declared synchronous port; SHALL NOT read another '
                'context\'s store. Allow-list: the eight declared ports under '
                'default_decision: deny.\n'
                '⚠⚠ String-literal limb NOT implemented pending artifact A1 '
                '(a raw table/index name passed as a string to a declared '
                'port is invisible here) — recorded, not invented.',
          ),
        );
      }
    }
  }

  /// **17 · SID-INT-11 — composing the aggregated profile inside this
  /// module** (`AR-1 · SID-INT-11`).
  ///
  /// ADR-0125 §8 (`SID-DET-11`): a **structural/layer check on declared
  /// field provenance** — no type declared in `domain/person` may aggregate
  /// data originating from more than one bounded context. `SID-4.9`: read
  /// composition of the aggregated profile screen SHALL occur in the
  /// application layer (app, rank 9), never inside this module; `AR-1`: a
  /// read composition "owns no aggregate".
  ///
  /// Mechanic: for each class declared in a `domain/person` file, every
  /// declared field type (`^\s+(final|late)? <Type>? <name> =|;`) is
  /// classified by its owning module: `person` (own/BC-10), `contracts`
  /// (rank 0), `primitive`, or `other` (another module's type). Violation
  /// when a class mixes own/BC-10 provenance with `other`-context
  /// provenance, or holds fields from two or more distinct non-person,
  /// non-contracts modules.
  ///
  /// NOT violations (ADR-0125 §8 row 5): `IdentityCoreFields` (single
  /// context); app-layer composition (the required location, not inspected
  /// here); `AccountId` linkage (contracts, mandated by `SID-INV-1`, not
  /// aggregation); a type merely referencing `PersonId` (contracts-owned).
  ///
  /// ⚠ **Disclosed limits, preserved** (ADR-0125 §8 ⚠): a composite assembled
  /// purely from **primitives** (`String`, `int`) that semantically originate
  /// elsewhere is NOT caught; the method-return composite limb is covered
  /// only when the composite is a declared type (then inspected as a class) —
  /// an inline composite of primitives is part of the same disclosed
  /// primitive limit. Only `domain/person` files are inspected. The residue
  /// stays under `SID-4.56`; the rule is not narrowed to the check.
  void _checkSidInt11CrossContextFields(
    File file,
    Module? module,
    String content,
    Map<String, String> typeOwner,
  ) {
    if (module == null || !_isDomainPerson(module)) return;

    const primitives = {
      'String',
      'int',
      'double',
      'bool',
      'num',
      'DateTime',
      'Duration',
      'dynamic',
      'var',
      'Object',
      'void',
      'Function',
    };
    final fieldDecl = RegExp(
      r'^\s{2,}(?:final\s+|late\s+|late\s+final\s+|static\s+|'
      r'static\s+final\s+|static\s+const\s+|const\s+)?'
      r'([A-Za-z_][\w<>,\s\?]*)\s+([a-zA-Z_]\w*)\s*(?:=|;)',
    );
    final classDecl = RegExp(
      r'^(?:abstract\s+|base\s+|final\s+|sealed\s+|interface\s+)*'
      r'(?:class|mixin|enum)\s+([A-Za-z_]\w*)',
    );

    String? currentClass;
    final contextsByClass = <String, Set<String>>{};

    void classifyField(String rawType) {
      var type = rawType.trim();
      // Generic containers: judge by their type arguments.
      while (type.startsWith('List<') ||
          type.startsWith('Map<') ||
          type.startsWith('Set<') ||
          type.startsWith('Iterable<')) {
        final inner = type.substring(type.indexOf('<') + 1);
        type = inner.endsWith('>')
            ? inner.substring(0, inner.length - 1)
            : inner;
      }
      if (type.endsWith('?')) type = type.substring(0, type.length - 1);
      final base = type.split('<').first.trim();
      if (currentClass == null) return;
      if (base.isEmpty || primitives.contains(base)) {
        contextsByClass[currentClass]!.add('primitive');
        return;
      }
      final owner = typeOwner[base];
      if (owner == null) {
        contextsByClass[currentClass]!.add(
          'primitive',
        ); // Unknown: under-match.
        return;
      }
      if (owner == 'domain/person') {
        contextsByClass[currentClass]!.add('person');
      } else if (owner == 'contracts') {
        contextsByClass[currentClass]!.add('contracts');
      } else {
        contextsByClass[currentClass]!.add(owner);
      }
    }

    final lines = content.split('\n');
    for (var i = 0; i < lines.length; i++) {
      final code = _codeOrEmpty(lines[i]);
      if (code.isEmpty) continue;
      final classMatch = classDecl.firstMatch(code.trimLeft());
      if (classMatch != null) {
        currentClass = classMatch.group(1)!;
        contextsByClass.putIfAbsent(currentClass, () => <String>{});
        continue;
      }
      if (currentClass == null) continue;
      final fieldMatch = fieldDecl.firstMatch(code);
      if (fieldMatch == null) continue;
      classifyField(fieldMatch.group(1)!);
    }

    for (final entry in contextsByClass.entries) {
      final contexts = entry.value;
      final others = contexts
          .where((c) => c != 'person' && c != 'contracts' && c != 'primitive')
          .toSet();
      final mixesOwnWithOther =
          contexts.contains('person') && others.isNotEmpty;
      final twoOtherContexts = others.length >= 2;
      if (!mixesOwnWithOther && !twoOtherContexts) continue;

      violations.add(
        Violation(
          category: 'sid-int',
          rule: 'AR-1 · SID-INT-11',
          file: file.path,
          severity: 'blocker',
          consumer: module.name,
          provider: others.join(', '),
          detail:
              'Type "${entry.key}" declared in domain/person aggregates data '
              'from more than one bounded context '
              '(${contexts.join(", ")}) (ADR-0125 §8, SID-DET-11). SID-4.9: '
              'read composition SHALL occur in the application layer (app, '
              'rank 9), never inside this module; AR-1: a read composition '
              'owns no aggregate.\n'
              '⚠ Disclosed limit: a composite assembled purely from '
              'primitives that semantically originate elsewhere is not '
              'caught — the residue stays unmet under SID-4.56.',
        ),
      );
    }
  }

  // ────────────────────────────────────────────────────────────────
  // 8 — ownership violations
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
      // The contracts package is a public barrel by design (law L5).
      if (target.name == 'contracts') {
        continue;
      }

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
  // 11 + X-10 — audit append-only (banned_method_names)
  // ────────────────────────────────────────────────────────────────

  /// Fails when a module declares a method whose name matches one of its
  /// `banned_method_names` globs.
  ///
  /// **The rule.** Forbidden edge `X-10` is *"`AUDIT` with an update or delete
  /// method"*; its stated remedy is *"append a correcting entry"*. Assertion
  /// `AU-1` puts it as *"no public mutation method exists on the audit store"*,
  /// and `AU-4` explains why: *"erasure makes a record non-identifying by key
  /// destruction; no record is ever removed."* An audit trail that can be edited
  /// cannot serve as evidence of anything.
  ///
  /// **Why declaration, not call site.** The manifest bans method *names* on the
  /// module that would own them. `X-10` is a rule about the audit store's public
  /// surface: if no mutator exists, no caller can invoke one. Checking
  /// declarations is therefore both the faithful reading and the cheaper one —
  /// it needs no call-graph and cannot be defeated by an indirect call.
  ///
  /// **Private members are still violations.** A `_deleteEntry` helper is one
  /// refactor away from being public, and `AU-4` forbids removal outright rather
  /// than merely forbidding its exposure. Narrowing this to public names would
  /// be reinterpreting the rule to make the checker quieter.
  void _checkAuditMutation(File file, Module? module, String content) {
    if (module == null) return;
    if (module.bannedMethodNames.isEmpty) return;

    final lines = content.split('\n');

    for (var i = 0; i < lines.length; i++) {
      final code = _stripComment(lines[i]);
      if (code.trim().isEmpty) continue;

      for (final name in _methodNamesDeclaredIn(code)) {
        for (final pattern in module.bannedMethodNames) {
          if (!_globMatch(pattern.toLowerCase(), name.toLowerCase())) continue;

          violations.add(
            Violation(
              category: 'audit-mutation',
              rule: 'X-10',
              file: file.path,
              line: i + 1,
              severity: 'blocker',
              consumer: module.name,
              provider: module.name,
              detail:
                  'Method "$name" is declared in "${module.name}", which bans '
                  'the pattern "$pattern" (banned_method_names). Forbidden edge '
                  'X-10: the audit store is append-only — no update, delete, '
                  'purge or modify method may exist on it.\n'
                  'Remedy (X-10, as written): append a correcting entry. '
                  'Assertion AU-4: erasure destroys the key, never the record.',
            ),
          );
        }
      }
    }
  }

  /// Method names declared on [code], as a single-line heuristic.
  ///
  /// Matches the three Dart declaration shapes that can carry a mutator name —
  /// `void delete(...)`, `Future<void> purgeAll(...) async`, and `T get x` is
  /// deliberately excluded because a getter cannot mutate. Consistent with
  /// [_parseImports], this is line-based rather than an AST parse so the checker
  /// keeps running when the project does not compile, which is exactly when a
  /// regression is most likely to be introduced.
  ///
  /// Written to under-match rather than over-match: a false positive here would
  /// pressure someone into weakening the rule to get a green build, which is the
  /// outcome the request explicitly forbids.
  Iterable<String> _methodNamesDeclaredIn(String code) {
    // <optional modifiers> <return type> name( ... )
    // The trailing '(' is what distinguishes a method from a field.
    final pattern = RegExp(
      r'^\s*(?:@\w+\s+)*'
      r'(?:external\s+|static\s+|abstract\s+)*'
      r'(?:[\w<>,\s\?\[\]\.]+\s+)?' // return type (optional: constructors)
      r'([a-zA-Z_]\w*)\s*'
      r'(?:<[^>]*>\s*)?' // generic method params
      r'\(',
    );
    final match = pattern.firstMatch(code);
    if (match == null) return const [];

    final name = match.group(1);
    if (name == null) return const [];

    // Keywords and control flow that can precede a '(' — never method names.
    const notMethods = {
      'if',
      'for',
      'while',
      'switch',
      'catch',
      'return',
      'assert',
      'super',
      'this',
      'new',
      'await',
      'yield',
      'throw',
      'else',
      'do',
      'when',
      'print',
      'expect',
      'test',
      'group',
      'setUp',
      'tearDown',
    };
    if (notMethods.contains(name)) return const [];

    return [name];
  }

  // ────────────────────────────────────────────────────────────────
  // 12 + X-13 — tenant-scoped keys
  // ────────────────────────────────────────────────────────────────

  /// The five surfaces `global.tenant_key_required_in` names, mapped to the
  /// identifier vocabulary that builds them in Dart.
  ///
  /// The manifest decides *which* surfaces `X-13` governs; this table only says
  /// what each surface looks like in code. A surface absent from the manifest is
  /// not checked, so widening `X-13` remains a manifest edit.
  static const Map<String, List<String>> _tenantKeySurfacePatterns = {
    'cache keys': ['cachekey', 'cacheentry', 'cachefor', 'cachedunder'],
    'search index names': ['indexname', 'indexfor', 'searchindex', 'indexid'],
    'vector namespaces': ['vectornamespace', 'namespace', 'vectorindex'],
    'storage prefixes': [
      'storageprefix',
      'blobprefix',
      'bucketpath',
      'storagepath',
      'objectkey',
    ],
    'projection table names': [
      'projectiontable',
      'tablename',
      'collectionname',
      'projectionname',
    ],
  };

  /// Fails when one of the `X-13` surfaces is built without a tenant scope.
  ///
  /// **Why this is the highest-severity check in the file.** The matrix calls
  /// `X-13` *"a cross-tenant data leak — the highest-severity failure class in
  /// the system"*, and the manifest sets `tenant_key_violation_severity:
  /// blocker`. In a multi-tenant SaaS a tenant-less cache key does not throw; it
  /// silently serves one library's data to another. There is no user-visible
  /// symptom until it is a breach.
  ///
  /// **What counts as compliant.** `X-13`'s stated remedy is a *"tenant-prefixed
  /// key factory"*, so this check accepts either:
  ///
  ///  * an explicit tenant term in the key expression (`tenantId`, `tenantKey`,
  ///    `TenantContext`); or
  ///  * construction through an abstraction that partitions by tenant *inside*
  ///    the store — `TenantPartitionedStore` is precisely the sanctioned factory,
  ///    and its own doc comment states it makes `X-13` "structurally
  ///    impossible for anything built on top of it".
  ///
  /// The second clause is not a loophole, it is the remedy the rule prescribes.
  /// Rejecting it would force call sites to re-prefix keys that are already
  /// partitioned — duplicated tenant logic, which is *more* leak-prone, not less.
  /// This is why the check keys off the five declared surfaces rather than every
  /// method named `_key`: a row id handed to an already-partitioned store is not
  /// one of the surfaces `X-13` governs.
  void _checkTenantKey(File file, Module? module, String content) {
    if (module == null) return;
    if (_tenantKeySurfaces.isEmpty) return; // X-13 not declared.
    if (module.name == 'contracts') return; // L5: no tenant runtime here.

    // Active identifier vocabulary, from the surfaces the manifest declares.
    final active = <String, String>{}; // pattern -> surface
    for (final surface in _tenantKeySurfaces) {
      for (final p
          in _tenantKeySurfacePatterns[surface.toLowerCase()] ??
              const <String>[]) {
        active[p] = surface;
      }
    }
    if (active.isEmpty) return;

    // A file that routes through the sanctioned factory is compliant by
    // construction for the whole file — the store applies the prefix itself.
    final usesPartitionedStore = content.contains('TenantPartitionedStore');

    final lines = content.split('\n');

    for (var i = 0; i < lines.length; i++) {
      final code = _stripComment(lines[i]);
      if (code.trim().isEmpty) continue;

      // Only lines that actually *build* a value: an assignment, a return, an
      // arrow body or a string. A declaration with no expression cannot leak.
      final buildsValue =
          code.contains('=') || code.contains('return') || code.contains('=>');
      if (!buildsValue) continue;

      final lower = code.toLowerCase();

      for (final entry in active.entries) {
        if (!lower.contains(entry.key)) continue;

        // Compliant if the expression names a tenant, or the file builds its
        // keys through the tenant-partitioned store.
        if (_mentionsTenant(lower) || usesPartitionedStore) continue;

        violations.add(
          Violation(
            category: 'tenant-key',
            rule: 'X-13',
            file: file.path,
            line: i + 1,
            severity: _tenantKeySeverity,
            consumer: module.name,
            provider: module.name,
            detail:
                'A ${entry.value.replaceAll(RegExp(r's$'), '')} is built in '
                '"${module.name}" without a tenant scope '
                '(matched "${entry.key}"). Forbidden edge X-13 requires every '
                'one of ${_tenantKeySurfaces.join(", ")} to carry tenantId.\n'
                'Severity: $_tenantKeySeverity — a cross-tenant data leak is '
                'the highest-severity failure class in the system.\n'
                'Remedy (X-13, as written): use a tenant-prefixed key factory, '
                'or route through TenantPartitionedStore, which prefixes inside '
                'the store rather than by convention at the call site.',
          ),
        );
        break; // One violation per line is enough to fix it.
      }
    }
  }

  /// Whether a lower-cased expression scopes itself to a tenant.
  bool _mentionsTenant(String lowerCode) =>
      lowerCode.contains('tenantid') ||
      lowerCode.contains('tenant_id') ||
      lowerCode.contains('tenantkey') ||
      lowerCode.contains('tenantcontext') ||
      lowerCode.contains('tenantscope') ||
      lowerCode.contains('pertenant') ||
      lowerCode.contains('fortenant');

  // ────────────────────────────────────────────────────────────────
  // 13–17 · SID-INT — the five executable SID-DET criteria (ADR-0178)
  // ────────────────────────────────────────────────────────────────
  //
  // Deliberately NOT implemented (ADR-0178 §7): SID-DET-10 — indexing a
  // never-public field — awaits artifact A2 (a machine-readable index-field
  // declaration for domain/person), which does not exist and is NOT created
  // here; the residue stays unmet under SID-4.56, never satisfied by intent.

  /// Shared gate: the five criteria of `ADR-0125` are scoped to
  /// `domain/person` and must never disturb other modules (including
  /// `domain/library`'s ADR-0012-waived `platform/audit` reference).
  bool _isDomainPerson(Module? module) => module?.name == 'domain/person';

  /// Comment-stripped code line that is not itself a comment heading.
  ///
  /// `_stripComment` only removes `//` tails, so doc-comment lines (`///`)
  /// and block-comment fragments (`/*`, `*`, `*/`) survive it; the SID-INT
  /// lexical checks skip those lines entirely.
  String _codeOrEmpty(String line) {
    final trimmed = line.trim();
    if (trimmed.isEmpty || trimmed.startsWith('/') || trimmed.startsWith('*')) {
      return '';
    }
    return _stripComment(line);
  }

  /// A line-based map from every top-level declared type name to the module
  /// that owns its file. Feeds SID-DET-9 and SID-DET-11 (ADR-0125 §6, §8).
  ///
  /// Line-based like every other pass in this checker: a declaration is a
  /// line whose stripped form starts with (optionally-modified)
  /// `class`/`enum`/`mixin`/`interface class` at column 0. Nesting is not
  /// modelled — under-match is the deliberate bias.
  Map<String, String> _buildTypeOwnerMap(List<File> files) {
    final pattern = RegExp(
      r'^(?:abstract\s+|base\s+|final\s+|sealed\s+|interface\s+)*'
      r'(class|enum|mixin)\s+([A-Za-z_]\w*)',
    );
    final out = <String, String>{};
    for (final file in files) {
      final module = _moduleFor(file.path);
      if (module == null) continue;
      for (final rawLine in file.readAsStringSync().split('\n')) {
        final code = _codeOrEmpty(rawLine);
        if (code.isEmpty) continue;
        final match = pattern.firstMatch(code);
        if (match == null) continue;
        out.putIfAbsent(match.group(2)!, () => module.name);
      }
    }
    return out;
  }

  /// CamelCase / snake_case word split of [name], lower-cased. Tokens stay
  /// traceable to the member name itself; see [_checkSidInt5Credentials].
  Set<String> _memberNameWords(String name) {
    final words = name
        .replaceAllMapped(
          RegExp(r'([a-z0-9])([A-Z])'),
          (m) => '${m.group(1)} ${m.group(2)}',
        )
        .replaceAll('_', ' ')
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toSet();
    return words;
  }

  /// **13 · SID-INT-5 — credential member names** (`ID-1 · SID-INT-5`).
  ///
  /// ADR-0125 §3 (`SID-DET-5`): a lexical scan of **declared member names**
  /// in `domain/person` — instance/static field names, getter/setter names,
  /// constructor parameter names, method names — against the credential
  /// classes. Comment-stripped: `_stripComment` removes `//` tails and whole
  /// `///` / block-comment lines are skipped by [_codeOrEmpty], so a comment
  /// naming a credential class is never flagged (person.dart L21–26 names
  /// them legitimately in prose).
  ///
  /// **The token set is derived, not invented** (ADR-0125 §3 row 4): the
  /// intersection of `SID-INV-5` ("No credential, OTP, session, device
  /// record or mobile number exists in this module's schema, events, logs or
  /// indices") with the manifest's already-declared
  /// `global.observability_plane.banned_content`, plus the module's existing
  /// `banned_symbols` (`mobileNumber`, `otp`). Tokens, each traceable to a
  /// quoted class: `mobile` ("mobile number, in any form or transform"),
  /// `challenge` ("challenge value"), the ordered pair `session`+`token`
  /// ("session token or any revalidating material"), `secret` ("device
  /// secret"), the ordered pair `key`+`material` ("key material"), `otp`
  /// (manifest banned_symbols + SID-INV-5). Word-boundary matching on the
  /// split member name is what keeps `accountId` (NOT a credential,
  /// person.dart L59–61) and `avatarRef` (an opaque FileRef) unflagged.
  ///
  /// ⚠ **Disclosed limit, preserved not narrowed** (ADR-0125 §3 ⚠): a
  /// credential stored under a **misleading name** (e.g. `note` holding an
  /// OTP) is invisible to a lexical scan. The residue stays under
  /// `SID-4.56` — unmet, not satisfied. The rule is not narrowed to the
  /// check.
  void _checkSidInt5Credentials(File file, Module? module, String content) {
    if (module == null || !_isDomainPerson(module)) return;
    if (_bannedContentClasses.isEmpty) {
      return; // Authority absent ⇒ not asserted.
    }

    // Single words and ordered word pairs, each documented with its authority.
    const singleWords = {'mobile', 'otp', 'challenge', 'secret'};
    const pairs = [('session', 'token'), ('key', 'material')];

    final lines = content.split('\n');
    for (var i = 0; i < lines.length; i++) {
      final code = _codeOrEmpty(lines[i]);
      if (code.isEmpty) continue;

      for (final name in _declaredMemberNames(code)) {
        final words = _memberNameWords(name);
        String? matchedClass;
        for (final word in words) {
          if (singleWords.contains(word)) {
            matchedClass = word == 'otp'
                ? 'otp (manifest banned_symbols · SID-INV-5)'
                : word;
            break;
          }
        }
        if (matchedClass == null) {
          for (final (a, b) in pairs) {
            if (words.contains(a) && words.contains(b)) {
              matchedClass = '$a $b';
              break;
            }
          }
        }
        if (matchedClass == null) continue;

        violations.add(
          Violation(
            category: 'sid-int',
            rule: 'ID-1 · SID-INT-5',
            file: file.path,
            line: i + 1,
            severity: 'blocker',
            consumer: module.name,
            provider: module.name,
            detail:
                'Declared member "$name" matches credential class '
                '"$matchedClass" in domain/person (ADR-0125 §3, SID-DET-5; '
                'SID-INV-5 ∩ global.observability_plane.banned_content). The '
                'credential is absent from this module and read-through from '
                'BC-18 per SID-4.13.\n'
                '⚠ Disclosed limit: a credential under a misleading name is '
                'not caught by a lexical scan; the residue stays unmet under '
                'SID-4.56.',
          ),
        );
      }
    }
  }

  /// Declared member names on a single comment-stripped [code] line, for the
  /// SID-DET-5 lexical scan. Under-match biased: fields, getters, setters,
  /// methods and constructor/named parameters whose name is declared here.
  Iterable<String> _declaredMemberNames(String code) {
    final out = <String>[];

    // Field / variable declarations: `final Type name`, `Type name;`,
    // `late final Type name`, `static const Type name =`.
    final field = RegExp(
      r'^\s*(?:static\s+)?(?:const\s+|final\s+|late\s+|var\s+|'
      r'[A-Za-z_][\w<>,\s\?]*\s+)([a-zA-Z_]\w*)\s*(?:=|;|=>|in\b)',
    );
    // Getter / setter: `Type get name =>`, `set name(value)`.
    final accessor = RegExp(
      r'^\s*(?:[\w<>,\s\?]+\s+)?(?:get|set)\s+([a-zA-Z_]\w*)',
    );
    // Method: reuse the existing shape — name immediately before `(`.
    final method = RegExp(
      r'^\s*(?:@[\w.]+\s+)*(?:external\s+|static\s+|abstract\s+)*'
      r'(?:[\w<>,\s\?\[\]\.]+\s+)?([a-zA-Z_]\w*)\s*(?:<[^>]*>\s*)?\(',
    );
    // Parameter names inside a parameter list `name: value`.
    final param = RegExp(r'(?:required\s+)?(?:this\.)?([a-zA-Z_]\w*)\s*[:=]');

    final fieldMatch = field.firstMatch(code);
    if (fieldMatch != null) out.add(fieldMatch.group(1)!);
    final accessorMatch = accessor.firstMatch(code);
    if (accessorMatch != null) out.add(accessorMatch.group(1)!);
    if (code.contains('(')) {
      final methodMatch = method.firstMatch(code);
      if (methodMatch != null) out.add(methodMatch.group(1)!);
      for (final m in param.allMatches(code)) {
        out.add(m.group(1)!);
      }
    }
    return out;
  }

  /// **14 · SID-INT-6 — caching an authorisation decision**
  /// (`MP-GBR-26/X-13 · SID-INT-6`).
  ///
  /// ADR-0125 §4 (`SID-DET-6`): a **structural, assignment-destination
  /// analysis + lexical cache-idiom sub-check — not call-graph based**. Within
  /// `domain/person`, the value returned by the declared
  /// `platform/identity:policy_decision` port (`PolicyDecisionPoint.allows` /
  /// `.scopeOf`, verified at `lib/platform/identity/identity.dart`) MUST NOT
  /// be assigned to any field, static, top-level variable, collection or
  /// memo; it may only be consumed within the invoking expression or local
  /// scope (`SID-AC-20`).
  ///
  /// **Gate (missing authority degrades, never fires):** the check runs only
  /// when `domain/person` declares the `platform/identity:policy_decision`
  /// port in the manifest. Authority absent ⇒ criterion not asserted.
  ///
  /// Violation shapes (ADR-0125 §4 row 2):
  ///  (a) a port-call result assigned to an instance field (`this._x =`),
  ///      `_`-prefixed destination (`_x =`), or a top-level (column-0)
  ///      `final/var/<Type> name =` declaration;
  ///  (b)+(d) a port-call result inserted into a `Map`/`List`/`Set` via
  ///      `.add(`/`..add(`, `[...] =`, `.putIfAbsent(` or `.update(` — a
  ///      local `Map`/`Set` keyed by subject identity is just an insertion
  ///      destination, so this one mechanical form covers both (b) and (d);
  ///  (c) a declared member whose name matches the cache idiom (`cache`,
  ///      `memo`) whose declared type is an authorisation result (`bool`,
  ///      `AccessScope`, optionally `?`/`List<…>`/`Map<…, …>`).
  ///
  /// NOT violations (ADR-0125 §4 row 5): holding the port *interface* as a
  /// constructor-injected field (the required DI shape); a local
  /// `final ok = p.allows(...)` consumed in place; caching a non-authorisation
  /// value (e.g. a settings value).
  ///
  /// ⚠ The **revocation-test** limb of §4.16's Detection column is preserved,
  /// not replaced: it remains **test authority** per `SID-AC-20`, outside
  /// this checker.
  void _checkSidInt6DecisionCaching(File file, Module? module, String content) {
    if (module == null || !_isDomainPerson(module)) return;
    if (!module.declaredPorts.contains('platform/identity:policy_decision')) {
      return; // Port not declared ⇒ criterion not asserted.
    }

    final portCall = RegExp(r'\.(allows|scopeOf)\(');
    final lines = content.split('\n');

    for (var i = 0; i < lines.length; i++) {
      final code = _codeOrEmpty(lines[i]);
      if (code.isEmpty) continue;
      if (!portCall.hasMatch(code)) continue;

      final isInsertion = RegExp(
        r'\.(?:add|putIfAbsent|update)\(|\[\s*[^\]]*\]\s*=|\.\.add\(',
      ).hasMatch(code);
      final underscoreDest = RegExp(
        r'(?<![\w.])_[a-zA-Z_]\w*\s*=[^=]',
      ).hasMatch(code);
      final thisDest = RegExp(r'this\.[a-zA-Z_]\w*\s*=[^=]').hasMatch(code);
      final plainLocalDecl = RegExp(
        r'^\s+(?:final|var)\s+[a-z][a-zA-Z0-9_]*\s*=',
      ).hasMatch(code);
      final topLevelDecl = RegExp(
        r'^(?:final|var|[A-Z][\w<>,\s\?]*)\s+[a-zA-Z_]\w*\s*=[^=]',
      ).hasMatch(code.trimLeft());

      if (isInsertion || ((underscoreDest || thisDest) && !plainLocalDecl)) {
        violations.add(
          Violation(
            category: 'sid-int',
            rule: 'MP-GBR-26/X-13 · SID-INT-6',
            file: file.path,
            line: i + 1,
            severity: 'blocker',
            consumer: module.name,
            provider: module.name,
            detail:
                'The value of a policy_decision port call (allows/scopeOf) is '
                'stored — assigned to a field/static/top-level or inserted '
                'into a collection (ADR-0125 §4, SID-DET-6, shapes a/b/d). '
                'SID-AC-20: every authorisation decision is obtained from '
                'BC-18 per request and never cached; MP-GBR-26: revocation is '
                'immediate and global, with no propagation window.\n'
                '⚠ The revocation test limb remains TEST authority '
                '(SID-AC-20), not checker authority.',
          ),
        );
        continue;
      }
      if (topLevelDecl && !plainLocalDecl) {
        violations.add(
          Violation(
            category: 'sid-int',
            rule: 'MP-GBR-26/X-13 · SID-INT-6',
            file: file.path,
            line: i + 1,
            severity: 'blocker',
            consumer: module.name,
            provider: module.name,
            detail:
                'A top-level variable is initialised from a policy_decision '
                'port call (ADR-0125 §4, SID-DET-6, shape a). SID-AC-20: '
                'obtained per request, never cached; the revocation test '
                'limb remains TEST authority (SID-AC-20).',
          ),
        );
      }
    }

    // Shape (c): cache-idiom member with an authorisation-result type.
    final cacheMember = RegExp(
      r'^\s*(?:static\s+)?(?:final\s+|late\s+final\s+|var\s+)?'
      r'(bool|AccessScope\??|List<[^>]*>|Map<[^>]*>)\s+'
      r'(\w*(cache|memo)\w*)\s*(?:=|;)',
      caseSensitive: false,
    );
    final authResultType = RegExp(
      r'^(bool|AccessScope\??|List<[^>]*(bool|AccessScope)[^>]*>|'
      r'Map<[^>]*,[^>]*(bool|AccessScope)[^>]*)$',
    );
    for (var i = 0; i < lines.length; i++) {
      final code = _codeOrEmpty(lines[i]);
      if (code.isEmpty) continue;
      final m = cacheMember.firstMatch(code);
      if (m == null) continue;
      final type = m.group(1)!.trim();
      final member = m.group(2)!;
      if (!authResultType.hasMatch(type)) continue; // Non-authz cache: fine.
      violations.add(
        Violation(
          category: 'sid-int',
          rule: 'MP-GBR-26/X-13 · SID-INT-6',
          file: file.path,
          line: i + 1,
          severity: 'blocker',
          consumer: module.name,
          provider: module.name,
          detail:
              'Member "$member" matches a cache idiom and is typed as an '
              'authorisation result ($type) in domain/person (ADR-0125 §4, '
              'SID-DET-6, shape c). SID-AC-20: never cached; revocation is '
              'immediate (MP-GBR-26). The revocation test limb remains TEST '
              'authority (SID-AC-20).',
        ),
      );
    }
  }

  // ────────────────────────────────────────────────────────────────
  // 8 — ownership violations
  // ────────────────────────────────────────────────────────────────

  /// **15 · SID-INT-8 — calling BC-24 synchronously from domain code**
  /// (`E-20 · SID-INT-8`).
  ///
  /// ADR-0125 §5 (`SID-DET-8`): `domain/person` MUST NOT import, reference as
  /// a type, or hold as a collaborator any `platform/audit` symbol. Mechanic-
  /// ally a per-module `banned_imports`-shaped test plus a type limb, per the
  /// E-20 structural equivalence: BC Map `E-20` declares the *only* sanctioned
  /// audit path to be an **event** (fire-and-forget, outbox-backed), so any
  /// reference from domain code is necessarily off-path — the ADR-0014 X-10
  /// reasoning: "if no mutator exists, no caller can invoke one. Checking
  /// declarations needs no call graph."
  ///
  /// Two limbs:
  ///  * **Import limb** — any import resolving into module `platform/audit`;
  ///  * **Type limb** — the platform/audit public type surface is derived
  ///    mechanically from the audit barrel (`lib/platform/audit/audit.dart`):
  ///    its top-level class/enum/mixin declarations (today `AuditEntry`,
  ///    `AuditTrail`). A barrel type appearing in a declared-type position in
  ///    `domain/person` (field/parameter/variable declaration line) fires.
  ///
  /// NOT violations (ADR-0125 §5 row 5): comments naming BC-24/platform/audit
  /// (comment stripping); audit *events* with `contracts` payload types;
  /// platform/audit's own files (different module); domain/library's existing
  /// reference, covered by the dated ADR-0012 waiver — this criterion is
  /// scoped to `domain/person` and does not disturb that waiver.
  ///
  /// ⚠ **Disclosed limit, preserved** (ADR-0125 §5 ⚠): a synchronous call
  /// bound through a **rank-0 contracts interface** at the composition root
  /// is not detected by import/type analysis. Recorded, not resolved; E-20 is
  /// not reinterpreted to make the check look complete. The only sanctioned
  /// audit path is an outbox event (SID-4.44, E-20).
  void _checkSidInt8AuditReference(
    File file,
    Module? module,
    String content,
    List<({String uri, int line})> imports,
  ) {
    if (module == null || !_isDomainPerson(module)) return;

    // Import limb.
    for (final imp in imports) {
      final target = _targetModule(imp.uri, file.path);
      if (target != null && target.name == 'platform/audit') {
        violations.add(
          Violation(
            category: 'sid-int',
            rule: 'E-20 · SID-INT-8',
            file: file.path,
            line: imp.line,
            severity: 'blocker',
            consumer: module.name,
            provider: target.name,
            detail:
                'domain/person imports platform/audit ("${imp.uri}") '
                '(ADR-0125 §5, SID-DET-8, import limb). SID-4.44: this module '
                'SHALL emit audit events fire-and-forget through the outbox '
                'and SHALL NOT call BC-24 synchronously from domain code. '
                'E-20: the only sanctioned audit path is an event.',
          ),
        );
      }
    }

    // Type limb: the platform/audit public surface, derived from its barrel.
    final auditTypes = _barrelTypeNames('platform/audit');
    if (auditTypes.isEmpty) return;

    final lines = content.split('\n');
    for (var i = 0; i < lines.length; i++) {
      final code = _codeOrEmpty(lines[i]);
      if (code.isEmpty) continue;
      if (!RegExp(r'=\s*|;|\(|,|<|>\s').hasMatch(code)) continue;
      if (!RegExp(
        r'(?:final|late|var|this\.|required|,\s*$|\?\s*\w+\s*[;=])',
      ).hasMatch(code)) {
        continue;
      }

      for (final typeName in auditTypes) {
        // Declared-type position: `<TypeName> <name>` / `<TypeName>? <name>`
        // as a field, parameter or local — never a comment or a string.
        final pattern = RegExp(
          r'\b' + typeName + r'\??\s+[a-z_][a-zA-Z0-9_]*\s*(?:[;=,)]|$)',
        );
        if (pattern.hasMatch(code)) {
          violations.add(
            Violation(
              category: 'sid-int',
              rule: 'E-20 · SID-INT-8',
              file: file.path,
              line: i + 1,
              severity: 'blocker',
              consumer: module.name,
              provider: 'platform/audit',
              detail:
                  'A platform/audit type ($typeName) appears as a declared '
                  'type in domain/person (ADR-0125 §5, SID-DET-8, type limb). '
                  'SID-4.44: audit facts leave this module only as '
                  'outbox-delivered events; E-20 is the only sanctioned path. '
                  '⚠ Disclosed limit: a synchronous call bound through a '
                  'rank-0 contracts interface is not detected by import/type '
                  'analysis — recorded, not resolved (SID-4.56).',
            ),
          );
        }
      }
    }
  }

  /// Top-level type names declared in [moduleName]'s barrel
  /// (`<module.path>/<leaf>.dart`), derived mechanically from source.
  List<String> _barrelTypeNames(String moduleName) {
    final module = _modules[moduleName];
    if (module == null) return const [];
    final leaf = moduleName.split('/').last;
    final barrel = File('${module.path}/$leaf.dart');
    if (!barrel.existsSync()) return const [];

    final pattern = RegExp(
      r'^(?:abstract\s+|base\s+|final\s+|sealed\s+|interface\s+)*'
      r'(?:class|enum|mixin)\s+([A-Za-z_]\w*)',
    );
    final out = <String>[];
    for (final rawLine in barrel.readAsStringSync().split('\n')) {
      final code = _codeOrEmpty(rawLine);
      if (code.isEmpty) continue;
      final match = pattern.firstMatch(code);
      if (match != null) out.add(match.group(1)!);
    }
    return out;
  }

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
      stdout.writeln(
        '          L4 capability-never-domain · L5 kernel-imports-nothing',
      );
      stdout.writeln('          + ownership, barrel, banned-symbol policies');
      stdout.writeln('          + X-10 audit append-only · X-13 tenant keys');
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
