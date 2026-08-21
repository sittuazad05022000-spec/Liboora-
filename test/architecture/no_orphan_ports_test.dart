/// **Architecture test 7 of 7 — `no_orphan_ports_test.dart`.**
///
/// Mandated by `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.3, whose requirement
/// cell reads verbatim:
///
/// > Every declared port has exactly one registered implementation at the
/// > composition root
///
/// ## Why "exactly one", and why "at the composition root"
///
/// Both halves of that sentence carry weight, and a test that checked only
/// "has an implementation somewhere" would miss the two failure modes that
/// actually happen:
///
///  * **Zero registered.** A port is declared, an adapter is written, and
///    nobody wires it. The code compiles, the abstraction looks complete, and
///    the feature is dead. This is the literal "orphan port".
///  * **More than one registered.** Two adapters for one port are wired at the
///    root. Now which one a consumer receives depends on construction order,
///    and the two will drift — one gets a bug fix, the other does not. This is
///    how a system acquires two sources of truth without anyone deciding to.
///
/// "At the composition root" is the discriminator that makes the count
/// meaningful. `Clock` has **four** implementations in this codebase
/// (`MutableClock`, `SystemClock`, `FixedClock`, plus test doubles) and that is
/// entirely correct — `FixedClock` exists so tests can pin time, and asserting
/// "one implementation per port" repository-wide would forbid test doubles
/// outright. What must be singular is the **registration**: `di.dart`
/// constructs exactly one `Clock`.
///
/// So this file counts constructor invocations inside `lib/bootstrap/di.dart`,
/// not class declarations across `lib/`. `di.dart` names itself:
///
/// > The single place in the codebase permitted to know both a port and its
/// > adapter. Every `new` of an infrastructure type happens here; nothing above
/// > this file imports an adapter.
///
/// That doc comment is the premise this test enforces.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const String _matrixPath =
    'docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md';
const String _diPath = 'lib/bootstrap/di.dart';

const List<String> _sourceRoots = ['lib', 'packages/liboora_contracts/lib'];

/// Strips comments so a port merely *discussed* in prose is not counted as
/// declared, and an adapter named in a design note is not counted as wired.
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

Iterable<File> _dartFiles() => _sourceRoots
    .map(Directory.new)
    .where((d) => d.existsSync())
    .expand((d) => d.listSync(recursive: true))
    .whereType<File>()
    .where((f) => f.path.endsWith('.dart'));

/// Every port: an `abstract [interface] class`, mapped to its file.
Map<String, String> _declaredPorts() {
  final ports = <String, String>{};
  final pattern = RegExp(
    r'^abstract\s+(?:interface\s+)?class\s+([A-Za-z0-9_]+)',
    multiLine: true,
  );
  for (final file in _dartFiles()) {
    for (final m in pattern.allMatches(_codeOnly(file.readAsStringSync()))) {
      ports[m.group(1)!] = file.path;
    }
  }
  return ports;
}

/// Every concrete class and the ports it implements.
Map<String, Set<String>> _implementationsByPort() {
  final byPort = <String, Set<String>>{};
  // Captures `final class X implements A, B {` and the wrapped-line form
  // `final class X\n    implements A, B {`.
  final pattern = RegExp(
    r'class\s+([A-Za-z0-9_]+)(?:<[^>]*>)?\s*(?:extends\s+[A-Za-z0-9_<>]+\s*)?'
    r'implements\s+([A-Za-z0-9_,<>\s]+?)\s*\{',
    multiLine: true,
  );
  for (final file in _dartFiles()) {
    final code = _codeOnly(file.readAsStringSync());
    for (final m in pattern.allMatches(code)) {
      final implementer = m.group(1)!;
      for (final raw in m.group(2)!.split(',')) {
        final port = raw.trim().replaceAll(RegExp(r'<.*>'), '');
        if (port.isEmpty) continue;
        byPort.putIfAbsent(port, () => <String>{}).add(implementer);
      }
    }
  }
  return byPort;
}

/// Class names constructed inside the composition root.
///
/// Matches `Foo(` and `const Foo(` but deliberately not a type annotation
/// (`final Foo x;`) — declaring a field of a port type is not registering an
/// adapter.
Set<String> _constructedInCompositionRoot() {
  final code = _codeOnly(File(_diPath).readAsStringSync());
  final constructed = <String>{};
  for (final m in RegExp(r'(?<![\w.])([A-Z][A-Za-z0-9_]*)\s*\(').allMatches(
    code,
  )) {
    constructed.add(m.group(1)!);
  }
  // `TenantPartitionedStore<StudentRecord>(...)` — generic construction.
  for (final m in RegExp(
    r'(?<![\w.])([A-Z][A-Za-z0-9_]*)\s*<[^>()]*>\s*\(',
  ).allMatches(code)) {
    constructed.add(m.group(1)!);
  }
  return constructed;
}

void main() {
  // ════════════════════════════════════════════════════════════════════
  // The obligation, and the integrity of the scan that enforces it.
  // ════════════════════════════════════════════════════════════════════
  group('the obligation and the scan behind it', () {
    test('Matrix §10.3 still requires exactly one registered implementation '
        'at the composition root', () {
      final matrix = File(_matrixPath).readAsStringSync();
      expect(matrix, contains('no_orphan_ports_test.dart'));
      expect(
        matrix,
        contains('exactly one registered implementation'),
        reason: 'The §10.3 requirement has been reworded away from "exactly '
            'one registered implementation". Re-derive this test against the '
            'current wording rather than leaving it asserting a rule that no '
            'longer exists.',
      );
      expect(
        matrix,
        contains('composition root'),
        reason: 'The "at the composition root" qualifier is gone from §10.3. '
            'That qualifier is what makes the count correct — without it the '
            'rule would forbid test doubles.',
      );
    });

    test('the composition root is where the matrix says it is, and still '
        'claims sole wiring authority', () {
      final di = File(_diPath);
      expect(
        di.existsSync(),
        isTrue,
        reason: 'The composition root $_diPath does not exist. Everything '
            'below is scanning nothing.',
      );
      final source = di.readAsStringSync();
      expect(
        source,
        contains('Composition Root'),
        reason: '$_diPath no longer identifies itself as the composition '
            'root. If wiring moved, this test must follow it.',
      );
      expect(
        source,
        contains('Every `new` of an infrastructure type happens here'),
        reason: 'The composition root has withdrawn its claim to be the only '
            'place adapters are constructed. That claim is the premise of '
            'this entire file; if it is false, counting registrations here '
            'proves nothing.',
      );
    });

    test('the port and implementation scans are non-vacuous', () {
      // Without this, a broken regex turns every assertion below into
      // "no ports declared, therefore no orphans" — a green suite that
      // checks nothing.
      final ports = _declaredPorts();
      final impls = _implementationsByPort();
      final constructed = _constructedInCompositionRoot();

      expect(ports, isNotEmpty, reason: 'Parsed zero ports.');
      expect(impls, isNotEmpty, reason: 'Parsed zero implementations.');
      expect(
        constructed,
        isNotEmpty,
        reason: 'Parsed zero constructor calls from the composition root.',
      );

      // Anchor on known-present facts, so a regex that silently degrades to
      // matching only a subset is caught.
      expect(ports.keys, contains('Clock'));
      expect(ports.keys, contains('TenantContext'));
      expect(ports.keys, contains('StudentRepository'));
      expect(impls['Clock'], contains('MutableClock'));
      expect(constructed, contains('MutableTenantContext'));
      expect(constructed, contains('EventBus'));
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // Zero registered — the literal orphan.
  // ════════════════════════════════════════════════════════════════════
  group('no port is left unregistered', () {
    test('every declared port has at least one implementation somewhere', () {
      final ports = _declaredPorts();
      final impls = _implementationsByPort();

      final unimplemented = ports.keys
          .where((p) => !(impls[p]?.isNotEmpty ?? false))
          .toList()
        ..sort();

      expect(
        unimplemented,
        isEmpty,
        reason: 'These ports are declared but nothing implements them: '
            '$unimplemented.\n'
            'A port with no adapter is a promise the system cannot keep. '
            'Either write the adapter or delete the port — a declared '
            'abstraction with no implementation makes the architecture look '
            'more complete than it is.',
      );
    });

    test('every declared port has EXACTLY ONE implementation registered at '
        'the composition root', () {
      final ports = _declaredPorts();
      final impls = _implementationsByPort();
      final constructed = _constructedInCompositionRoot();

      final zero = <String>[];
      final many = <String>[];

      for (final port in ports.keys) {
        final registered =
            (impls[port] ?? const <String>{}).intersection(constructed);
        if (registered.isEmpty) {
          zero.add('$port (implementations exist but none is wired: '
              '${(impls[port] ?? const <String>{}).toList()..sort()})');
        } else if (registered.length > 1) {
          many.add('$port -> ${registered.toList()..sort()}');
        }
      }

      expect(
        zero,
        isEmpty,
        reason: 'ORPHAN PORT — these ports have adapters that are never wired '
            'at the composition root:\n  ${zero.join('\n  ')}\n'
            'Nothing can consume them, so the capability they describe does '
            'not exist at runtime however complete the code looks.',
      );

      expect(
        many,
        isEmpty,
        reason: 'AMBIGUOUS REGISTRATION — more than one adapter for the same '
            'port is constructed at the composition root:\n'
            '  ${many.join('\n  ')}\n'
            'Which one a consumer receives now depends on wiring order, and '
            'the two will drift apart. Pick one, or introduce a named '
            'distinction that makes the choice explicit.',
      );
    });

    test('no adapter is constructed OUTSIDE the composition root', () {
      // The inverse of the rule, and the leak that quietly repeals it: if an
      // adapter is constructed elsewhere, the singular registration proven
      // above is no longer the only one that matters.
      final ports = _declaredPorts();
      final impls = _implementationsByPort();

      // Restrict to implementations of a port DECLARED IN THIS REPOSITORY.
      //
      // The first draft flattened every `implements` clause, which swept in
      // `DomainError implements Exception` and `Money implements
      // Comparable<Money>` — then reported twelve "violations" because domain
      // code throws `DomainError(...)`. Throwing an exception is not wiring an
      // adapter, and `Exception`/`Comparable` are dart:core types, not ports
      // this architecture declares. The rule governs adapters for *our* ports;
      // widening it past that produced pure noise, and noise is how a checker
      // gets ignored and then disabled.
      final adapters = <String>{
        for (final entry in impls.entries)
          if (ports.containsKey(entry.key)) ...entry.value,
      };

      // Vacuity guard: if the intersection above ever empties, this test would
      // silently stop checking anything.
      expect(
        adapters,
        isNotEmpty,
        reason: 'No adapters resolved for any declared port. The scan is '
            'broken and the assertion below is vacuous.',
      );
      expect(adapters, contains('MutableTenantContext'));

      // Test doubles and alternative adapters are legitimate; they simply must
      // not be built inside production code outside the root. Restrict the
      // scan to lib/ excluding the root itself.
      final offenders = <String>[];
      for (final file in _dartFiles()) {
        if (file.path == _diPath) continue;
        if (!file.path.startsWith('lib/')) continue;
        final code = _codeOnly(file.readAsStringSync());
        for (final adapter in adapters) {
          // A class constructing ITSELF (a factory or named constructor) is
          // not a wiring violation.
          if (code.contains('class $adapter')) continue;
          if (RegExp('(?<![\\w.])$adapter\\s*\\(').hasMatch(code)) {
            offenders.add('${file.path} constructs $adapter');
          }
        }
      }

      expect(
        offenders,
        isEmpty,
        reason: 'Adapters are being constructed outside the composition '
            'root:\n  ${offenders.join('\n  ')}\n'
            'This is how a second, unregistered instance of a port enters the '
            'system. Inject the dependency instead of constructing it.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // Observed, disclosed, and pinned — not silently tolerated.
  // ════════════════════════════════════════════════════════════════════
  group('DISCLOSED OBSERVATIONS about the current wiring', () {
    test('a port with multiple implementations keeps exactly one wired — '
        'Clock is the worked example', () {
      // This test exists to prove the distinction in the header is real and
      // load-bearing, not a rationalisation. Clock legitimately has several
      // implementations; only one may be registered.
      final impls = _implementationsByPort()['Clock'] ?? const <String>{};
      final constructed = _constructedInCompositionRoot();

      expect(
        impls.length,
        greaterThan(1),
        reason: 'Clock no longer has multiple implementations, so this file no '
            'longer demonstrates why "registered" differs from "declared". '
            'Pick another multi-adapter port or remove this test — do not '
            'leave it asserting a coincidence.',
      );

      final wired = impls.intersection(constructed);
      expect(
        wired.length,
        1,
        reason: 'Clock has ${impls.length} implementations ($impls) and '
            '${wired.length} of them are wired ($wired). Exactly one must be.',
      );
      expect(
        wired.single,
        'MutableClock',
        reason: 'The registered Clock changed to ${wired.single}. That is a '
            'legitimate decision, but it changes time behaviour '
            'system-wide — update this pin deliberately.',
      );
    });

    test('OBSERVED GAP — IdentityDirectory is declared and implemented but '
        'has no consumer', () {
      // Not a failure of §10.3: `InMemoryPersonIdentityRepository` implements
      // it and IS constructed at the root, so the port has exactly one
      // registered implementation. But nothing anywhere depends on the port
      // type, so the abstraction is currently doing no work.
      //
      // Recorded rather than "fixed": deleting a declared port is an
      // architecture decision (BC-10 / E-13 surface), and inventing a consumer
      // to justify it would be worse. This test fails if the situation
      // CHANGES, so the observation cannot silently rot.
      final consumers = <String>[];
      for (final file in _dartFiles()) {
        if (file.path.endsWith('lib/domain/person/person.dart')) continue;
        if (_codeOnly(file.readAsStringSync()).contains('IdentityDirectory')) {
          consumers.add(file.path);
        }
      }

      expect(
        consumers,
        isEmpty,
        reason: 'PROGRESS DETECTED — IdentityDirectory now has a consumer '
            '($consumers). Remove this disclosure and, if the port is now '
            'wired by type, assert that instead.',
      );

      // And it must still be registered, so this observation cannot be
      // confused with an orphan.
      final impls = _implementationsByPort()['IdentityDirectory'] ??
          const <String>{};
      expect(impls, contains('InMemoryPersonIdentityRepository'));
      expect(
        _constructedInCompositionRoot(),
        contains('InMemoryPersonIdentityRepository'),
        reason: 'IdentityDirectory has become a true orphan port — its only '
            'implementation is no longer wired at the composition root.',
      );
    });

    test('OBSERVED — three container fields are typed to a concrete adapter '
        'rather than to a port', () {
      // `identities`, `socialPresences` and `telemetry` are declared on
      // AppContainer as `InMemoryPersonIdentityRepository`,
      // `InMemorySocialPresenceRepository` and `ConsoleTelemetry`. Consumers
      // reaching them through the container therefore depend on the adapter,
      // not the abstraction — the coupling the ports exist to prevent.
      //
      // This is NOT a §10.3 violation and is not being reported as one. It is
      // pinned so the count cannot grow unnoticed: swapping to Firestore is
      // advertised as "a change to di.dart and nothing else", and every
      // concretely-typed field is a place where that claim weakens.
      final code = _codeOnly(File(_diPath).readAsStringSync());
      final concreteFields = RegExp(
        r'^\s*final\s+(In[A-Z][A-Za-z0-9_]*|Console[A-Z][A-Za-z0-9_]*)\s+'
        r'([a-z][A-Za-z0-9_]*)\s*;',
        multiLine: true,
      ).allMatches(code).map((m) => '${m.group(2)}: ${m.group(1)}').toList()
        ..sort();

      expect(
        concreteFields.length,
        3,
        reason: 'The number of container fields typed to a concrete adapter '
            'changed to ${concreteFields.length} ($concreteFields).\n'
            'If it GREW, a new field bypasses its port — prefer the port '
            'type. If it SHRANK, that is an improvement: update this pin.',
      );
    });
  });
}
