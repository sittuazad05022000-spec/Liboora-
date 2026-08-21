/// **Architecture test — `E-22`'s consumer list is enforced, and cannot drift.**
///
/// Closes the *testing* side of `FIL-GAP-012`'s implementation half
/// (`ADR-0059`). Frozen `FIL-FR-006` reads:
///
/// > The module SHALL serve a caller only where the caller's bounded context
/// > appears in `E-22`'s consumer list as recorded in BC Map §7.3. A caller
/// > whose context is absent SHALL be refused.
///
/// ## Why this file parses the BC Map instead of trusting the code
///
/// The dangerous way to satisfy `FIL-FR-006` is to hard-code
/// `{BC-01, BC-10, BC-12, BC-14}` in Dart and move on. That creates a **second
/// source of truth** for a Rank 4 register, and the failure is silent in the
/// worst direction: a future ADR amends `E-22`, the map changes, the code does
/// not, and `FIL-FR-006` — a requirement *written to read the register* —
/// carries on enforcing last year's topology while every document says
/// otherwise.
///
/// So the first group below **reads `E-22`'s consumer cell out of
/// `LIBOORA_BOUNDED_CONTEXT_MAP.md`** and asserts the executable constant
/// equals it. Neither can move alone. That is also the distinction the `B-2`
/// instruction draws: this file does not check that the PRD *contains a
/// sentence* about consumers — it extracts the **authority** and executes the
/// **code**, so it cannot pass by agreeing with prose about itself.
///
/// ## What else is pinned here
///
///  * `BC-11` and `BC-13` are refused. They are absent from `E-22` **by
///    decision** (`ADR-0055` §3 tested necessity per context), not by
///    oversight, and the manifest's module-grained grant at **L242** would
///    admit them if the context-grained list did not refuse them (`GCP-23`).
///  * The refusal leaks nothing (`FIL-FR-094`).
///  * `FIL-FR-007` is unwidenable — asserted against the *shape* of the API.
///  * `FIL-XC-019`/`020`/`022` ownership stays out of `BC-29`.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/platform/services/services.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const String _bcMapPath =
    'docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md';
const String _portPath =
    'packages/liboora_contracts/lib/src/ports/file_access.dart';

/// The consumer cell of the `E-22` row, as the BC Map states it.
///
/// §7's row shape is `| E-22 | <consumers> | <provider> | ... |`, so the
/// consumers are the second cell. Parsed rather than pattern-matched against an
/// expected value, so this helper cannot bake in the answer it is checking.
Set<String> _consumersFromBcMap() {
  final lines = File(_bcMapPath).readAsLinesSync();
  for (final line in lines) {
    final trimmed = line.trimLeft();
    if (!trimmed.startsWith('| E-22 ')) continue;
    final cells = trimmed.split('|').map((c) => c.trim()).toList();
    // cells[0] is empty (leading pipe), cells[1] == 'E-22', cells[2] consumers.
    return cells[2]
        .split(',')
        .map((c) => c.trim())
        .where((c) => c.isNotEmpty)
        .toSet();
  }
  return const <String>{};
}

/// The port's **declarations**, with documentation removed.
///
/// Two of the assertions below ask whether foreign concepts have entered the
/// port's *API*. Scanning the raw file cannot answer that: `file_access.dart`
/// deliberately documents what it refuses to know — its `FIL-XC-022` row reads
/// *"Abuse reports, moderation verdicts, strikes, bans | `BC-13`"* — so a
/// substring scan over prose reports "the port mentions moderation" about a
/// comment whose entire purpose is to say moderation belongs elsewhere. That
/// penalises the port for being explicit about its own exclusions, which is the
/// opposite of the property under test.
///
/// So the foreign-concept scans run over declarations only. Documentation is
/// checked *separately*, and positively: the exclusion table must still be
/// there (see the two `documents the exclusion` tests). Both directions are
/// therefore covered — an exclusion cannot be silently implemented, and it
/// cannot be silently undocumented.
String _portDeclarations() {
  final lines = File(_portPath).readAsLinesSync();
  final code = lines
      .where((l) {
        final t = l.trimLeft();
        return !t.startsWith('///') && !t.startsWith('//');
      })
      .join('\n');
  return code;
}

BoundedContextId _ctx(String id) => BoundedContextId(id);

InProcessFileAccess _fixture() => InProcessFileAccess();

const FileRef _object = FileRef('FILE-0001');
const PersonId _recipient = PersonId('P-0002');
const EligibilityDecisionRef _decision = EligibilityDecisionRef('DEC-0003');

void main() {
  // ════════════════════════════════════════════════════════════════════
  // The code is a COPY of the map, and is proven to be.
  // ════════════════════════════════════════════════════════════════════
  group('the executable consumer list equals the BC Map', () {
    test('the parse is non-vacuous — the E-22 row was actually found', () {
      final fromMap = _consumersFromBcMap();
      expect(
        fromMap,
        isNotEmpty,
        reason: 'Parsed no consumers from $_bcMapPath. Either the E-22 row '
            'moved or §7\'s table shape changed. Until this is fixed every '
            'assertion below is vacuous — "the map lists nothing, therefore '
            'the code matches it" is a green test that checks nothing.',
      );
      // Anchor on a fact that predates ADR-0055, so a parser that silently
      // degrades to matching a subset is caught.
      expect(
        fromMap,
        contains('BC-01'),
        reason: 'BC-01 has been an E-22 consumer since the map was written.',
      );
    });

    test('e22ConsumerContexts is exactly BC Map L331, in both directions', () {
      final fromMap = _consumersFromBcMap();

      final missingFromCode = fromMap.difference(e22ConsumerContexts);
      final extraInCode = e22ConsumerContexts.difference(fromMap);

      expect(
        missingFromCode,
        isEmpty,
        reason: 'DRIFT — the BC Map lists $missingFromCode as an E-22 consumer '
            'and the code does not admit it.\n'
            'If an ADR amended E-22, this is the code that must follow. '
            'FIL-FR-006 was written to READ the register, so leaving the '
            'constant behind means the requirement silently enforces an '
            'obsolete topology while every document says otherwise.',
      );
      expect(
        extraInCode,
        isEmpty,
        reason: 'UNAUTHORISED WIDENING — the code admits $extraInCode, which '
            'the BC Map does not list as an E-22 consumer.\n'
            'BC Map L292: "If an edge is not in this table, it does not '
            'exist." FIL-FR-007 forbids widening the list, and a consumer '
            'admitted in code but not in the map is exactly that — an edge '
            'asserted by implementation rather than by an accepted ADR.',
      );
    });

    test('ADR-0055\'s ruling is the one in force — BC-12 admitted, BC-11 and '
        'BC-13 refused', () {
      final fromMap = _consumersFromBcMap();
      // Asserted against the MAP, not against the constant, so this test is
      // about the architecture decision rather than about the copy of it.
      expect(
        fromMap,
        contains('BC-12'),
        reason: 'BC-12 has left E-22\'s consumer list. ADR-0055 admitted it so '
            'V1 student-to-student sharing would be servable; removing it '
            'un-resolves FIL-GAP-012 and B-11.',
      );
      expect(
        fromMap,
        isNot(contains('BC-11')),
        reason: 'BC-11 has been added to E-22. ADR-0055 §3 tested it and '
            'REFUSED it — Social Graph answers eligibility as a boolean and '
            'never holds a FileRef. If that changed, it needs its own ADR, and '
            'this pin is where the decision must be argued.',
      );
      expect(
        fromMap,
        isNot(contains('BC-13')),
        reason: 'BC-13 has been added to E-22. ADR-0055 §3 REFUSED it — Trust '
            '& Safety reaches File & Media OUTBOUND over E-14.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // FIL-FR-006 — the rule actually refuses somebody.
  // ════════════════════════════════════════════════════════════════════
  group('FIL-FR-006 is enforced, not merely written', () {
    test('every context the map lists is permitted', () {
      final port = _fixture();
      for (final id in _consumersFromBcMap()) {
        expect(
          port.isPermittedConsumer(_ctx(id)),
          isTrue,
          reason: '$id is on E-22\'s consumer list and the port refuses it. '
              'That is a refusal the architecture does not authorise.',
        );
      }
    });

    test('BC-11 and BC-13 are refused BY CODE, which is what ADR-0055 could '
        'not itself make true', () {
      // SEEDED deliberately. With an unseeded fixture, grantRead's notFound
      // check is reachable, so a missing authorisation guard still throws —
      // and a loose throwsA(isA<DomainError>()) would read that as a refusal.
      // Mutation M2 (guard deleted from grantRead) survived exactly that way.
      // Seeding the object removes notFound from the picture, so the only
      // error that can arrive is the authorisation refusal being tested.
      final port = _fixture()..seed(_object);
      for (final id in ['BC-11', 'BC-13']) {
        expect(
          port.isPermittedConsumer(_ctx(id)),
          isFalse,
          reason: '$id is permitted. ADR-0055 §4.3 refused it, and the '
              'manifest L242 grant (module-grained, GCP-23) would let it link '
              'this port — so this check is the only thing standing between a '
              'domain/social caller and an edge the map says does not exist.',
        );
        expect(
          () => port.resolve(_ctx(id), _object),
          throwsA(
            isA<DomainError>().having(
              (e) => e.code,
              'code',
              DomainErrorCode.forbidden,
            ),
          ),
          reason: '$id was not refused on the read path.',
        );
        expect(
          () => port.grantRead(
            _ctx(id),
            _object,
            recipient: _recipient,
            decision: _decision,
          ),
          throwsA(
            isA<DomainError>().having(
              (e) => e.code,
              'code',
              DomainErrorCode.forbidden,
            ),
          ),
          reason: '$id was not refused on the grant path WITH forbidden. A '
              'guard on read but not on write is not a boundary — and an '
              'error of some other kind (notFound, say) is not a refusal, it '
              'is an unauthorised caller reaching business logic.',
        );
      }
    });

    test('an arbitrary unlisted context is refused, so the rule is not a '
        'two-name blocklist', () {
      final port = _fixture();
      for (final id in ['BC-03', 'BC-17', 'BC-99', '', 'bc-12', 'BC-12 ']) {
        expect(
          port.isPermittedConsumer(_ctx(id)),
          isFalse,
          reason: 'Unlisted context "$id" was permitted. FIL-FR-006 is an '
              'allow-list; anything not on it is refused, including '
              'near-misses in case and whitespace.',
        );
      }
    });

    test('a permitted caller can resolve a known object and gets null for an '
        'unknown one', () {
      final port = _fixture()..seed(_object);
      expect(port.resolve(_ctx('BC-12'), _object), _object);
      expect(
        port.resolve(_ctx('BC-12'), const FileRef('FILE-NOPE')),
        isNull,
        reason: 'An unknown object must be null, not an error — FIL-FR-094 '
            'requires that absence and denial be indistinguishable, and an '
            'error here would confirm the storage layout to a caller.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // FIL-FR-094 — the refusal leaks nothing.
  // ════════════════════════════════════════════════════════════════════
  group('the refusal discloses nothing (FIL-FR-094)', () {
    test('the error names no edge, no consumer list, no object and no context',
        () {
      final port = _fixture()..seed(_object);
      DomainError? caught;
      try {
        port.resolve(_ctx('BC-11'), _object);
      } on DomainError catch (e) {
        caught = e;
      }
      expect(caught, isNotNull, reason: 'BC-11 was not refused at all.');

      final text = caught.toString();
      for (final forbidden in [
        'E-22',
        'BC-11',
        'BC-01',
        'BC-12',
        'consumer',
        'FILE-0001',
        _bcMapPath,
      ]) {
        expect(
          text,
          isNot(contains(forbidden)),
          reason: 'The refusal "$text" leaks "$forbidden". FIL-FR-094 forbids '
              'a progress or access surface from confirming existence or '
              'revealing internals — naming the edge hands an unauthorised '
              'caller the topology, and naming the object confirms it exists.',
        );
      }
    });

    test('an unauthorised caller cannot tell a known object from an unknown '
        'one', () {
      final port = _fixture()..seed(_object);
      String refusalFor(FileRef ref) {
        try {
          port.resolve(_ctx('BC-11'), ref);
          return 'NOT REFUSED';
        } on DomainError catch (e) {
          return e.toString();
        }
      }

      expect(
        refusalFor(_object),
        refusalFor(const FileRef('FILE-DOES-NOT-EXIST')),
        reason: 'The refusal differs between a known and an unknown object, so '
            'an unauthorised caller can enumerate storage by comparing errors. '
            'This is the enumeration oracle FIL-FR-094 names explicitly.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // FIL-FR-007 — there is no way to widen the list.
  // ════════════════════════════════════════════════════════════════════
  group('the consumer list cannot be widened (FIL-FR-007)', () {
    test('the declared set is a compile-time constant with no mutation surface',
        () {
      // Structural, not behavioural: the guarantee is that no API exists to
      // widen the list, so it is asserted against the port's source.
      final source = File(_portPath).readAsStringSync();
      expect(
        source,
        contains('const Set<String> e22ConsumerContexts'),
        reason: 'The consumer list is no longer a compile-time constant. A '
            'mutable list can be widened at runtime, which FIL-FR-007 forbids.',
      );
      for (final widener in [
        'void allow(',
        'void register(',
        'set consumers',
        'addConsumer',
      ]) {
        expect(
          source,
          isNot(contains(widener)),
          reason: 'The port has acquired "$widener". FIL-FR-007 is enforced by '
              'the SHAPE of this API — a caller cannot widen what it cannot '
              'address — and adding a widening surface repeals that by '
              'construction, whatever the comments say.',
        );
      }
    });

    test('the port cites the map as its authority, so the copy is traceable',
        () {
      final source = File(_portPath).readAsStringSync();
      expect(
        source,
        contains('L331'),
        reason: 'The transcription no longer names the BC Map line it copies. '
            'An untraceable copy of a Rank 4 register is indistinguishable '
            'from an invented one.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // FIL-XC-019 / 020 / 022 — no ownership moved into BC-29.
  // ════════════════════════════════════════════════════════════════════
  group('no ownership moved into BC-29', () {
    test('a grant requires a RECORDED decision reference, never a boolean '
        '(FIL-FR-076, X-13)', () {
      final source = File(_portPath).readAsStringSync();
      expect(
        source,
        contains('EligibilityDecisionRef'),
        reason: 'The eligibility decision reference is gone from the port.',
      );
      for (final derived in [
        'bool eligible',
        'bool canMessage',
        'canMessage(',
        'isFriend',
        'bool blocked',
      ]) {
        expect(
          source,
          isNot(contains(derived)),
          reason: 'The port has acquired "$derived". FIL-XC-019 forbids this '
              'module from evaluating or storing eligibility, and FIL-FR-076 '
              'requires the decision RECORDED, not re-derived — a second '
              'canMessage evaluation could disagree with BC-11\'s (X-13).',
        );
      }
    });

    test('the port stores the decision reference and does not interpret it',
        () {
      final port = _fixture()..seed(_object);
      port.grantRead(
        _ctx('BC-12'),
        _object,
        recipient: _recipient,
        decision: _decision,
      );
      expect(
        port.grantFor(_object, _recipient),
        _decision,
        reason: 'The recorded decision must be returned as the reference it '
            'is, so BC-29 cannot substitute a judgement of its own.',
      );
      expect(port.grantCount, 1);
    });

    test('a replayed grant is idempotent, so a resent share does not '
        'accumulate access facts', () {
      final port = _fixture()..seed(_object);
      for (var i = 0; i < 4; i++) {
        port.grantRead(
          _ctx('BC-12'),
          _object,
          recipient: _recipient,
          decision: _decision,
        );
      }
      expect(
        port.grantCount,
        1,
        reason: 'Four identical grants produced ${port.grantCount} access '
            'facts. The FIL-FR-093 reasoning — no second audit fact for a '
            'repeated operation — applies to access as well as to bytes.',
      );
    });

    test('granting on an unknown object fails rather than inventing one', () {
      final port = _fixture();
      expect(
        () => port.grantRead(
          _ctx('BC-12'),
          const FileRef('FILE-GHOST'),
          recipient: _recipient,
          decision: _decision,
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.notFound,
          ),
        ),
        reason: 'A grant against a nonexistent object would create access to '
            'something that does not exist, and FIL-FR-057/083 assume a '
            'derivative is never the sole copy of anything.',
      );
      expect(port.grantCount, 0);
    });

    test('the port holds no message semantics or moderation surface '
        '(FIL-XC-020, FIL-XC-022)', () {
      final declarations = _portDeclarations();
      for (final foreign in [
        'messageText',
        'String body',
        'readReceipt',
        'deliveredAt',
        'conversationId',
        'reportAbuse',
        'moderat',
        'strike',
        'ban(',
      ]) {
        expect(
          declarations.toLowerCase(),
          isNot(contains(foreign.toLowerCase())),
          reason: 'The port DECLARES "$foreign". FIL-XC-020 keeps message '
              'text, ordering, receipts and conversation membership with '
              'BC-12; FIL-XC-022 keeps moderation with BC-13. A file port that '
              'knows any of it has absorbed ownership ADR-0055 §4.4 '
              'explicitly did not move.',
        );
      }
    });

    test('the port documents the exclusion it refuses to implement', () {
      // The counterpart to the scan above. Removing documentation is how a
      // boundary quietly stops being a decision and becomes an accident: the
      // next author cannot see that BC-11/BC-12/BC-13 ownership was weighed
      // and left alone (ADR-0055 §4.4). Asserting the citations survive is
      // cheap; recovering the reasoning after it is deleted is not.
      final source = File(_portPath).readAsStringSync();
      for (final citation in [
        'FIL-XC-019',
        'FIL-XC-020',
        'FIL-XC-021',
        'FIL-XC-022',
        'BC-11',
        'BC-13',
      ]) {
        expect(
          source,
          contains(citation),
          reason: 'The port no longer cites $citation. The exclusion is still '
              'in force (ADR-0055 §4.4 relies on it); an undocumented '
              'exclusion is one an author will re-add in good faith.',
        );
      }
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // Tenancy — nothing invented against the global identity architecture.
  // ════════════════════════════════════════════════════════════════════
  group('the port creates no tenancy rule', () {
    test('no surface takes a tenant identifier, because E-22 serves a '
        'global-class consumer', () {
      // BC Map §11 makes BC-10 global ("No tenantId", rule ID-2) and it is an
      // E-22 consumer via ADR-0016. A mandatory tenant parameter would be
      // unsatisfiable there and would breach frozen TEN-FR-018.
      //
      // Declarations only: the port's doc comment cites TEN-FR-018 and names
      // the ambient TenantContext in order to explain why it takes NEITHER.
      // Reading that explanation as a violation would make the port fail for
      // justifying its own correctness.
      final declarations = _portDeclarations();
      for (final tenancy in ['TenantId', 'tenantId', 'TenantContext']) {
        expect(
          declarations,
          isNot(contains(tenancy)),
          reason: 'The port DECLARES "$tenancy". E-22 serves the GLOBAL-class '
              'consumer BC-10, so a tenant parameter is unsatisfiable for it '
              'and TEN-FR-018 forbids tenant_id in global contexts. Tenancy '
              'belongs to the ambient TenantContext, not to this boundary.',
        );
      }
      expect(_consumersFromBcMap(), contains('BC-10'));
    });

    test('the port documents why it takes no tenant, citing the tenancy class',
        () {
      // Without this, a future author sees a port with no tenantId, assumes an
      // omission, and "fixes" it — breaking BC-10 and TEN-FR-018 at once.
      final source = File(_portPath).readAsStringSync();
      for (final citation in ['TEN-FR-018', 'BC-10', 'ID-2']) {
        expect(
          source,
          contains(citation),
          reason: 'The port no longer cites $citation. The absence of a tenant '
              'parameter is a DECISION about the two-class tenancy model, and '
              'an undocumented decision reads as an oversight.',
        );
      }
    });

    test('the declaration stripper is sound for this file — no block comments',
        () {
      // The stripper is line-based. A `/* ... */` block containing foreign
      // tokens would survive it and, worse, a block comment could hide a real
      // declaration from the scans above. Assert the precondition rather than
      // assume it, so the day it stops holding is the day this fails.
      final source = File(_portPath).readAsStringSync();
      expect(
        source,
        isNot(contains('/*')),
        reason: 'The port now uses block comments. _portDeclarations() strips '
            'only line comments, so the foreign-concept scans in this file are '
            'no longer sound. Teach the stripper about block comments before '
            'relying on those assertions again.',
      );
      // Non-vacuity: the stripper must retain the actual API.
      expect(
        _portDeclarations(),
        contains('abstract interface class FileAccess'),
        reason: 'The stripper removed the declarations it exists to isolate. '
            'Every isNot(contains(...)) assertion built on it would then pass '
            'against anything at all.',
      );
    });
  });
}
