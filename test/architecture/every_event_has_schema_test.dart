/// **Architecture test 4 of 7 — `every_event_has_schema_test.dart`.**
///
/// Mandated by `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.3, whose requirement
/// cell reads verbatim:
///
/// > Each event in context map §9 exists in the registry with a `schemaVersion`
///
/// ## ⛔ THE REGISTRY DOES NOT EXIST. This is a disclosed blocker, not a pass.
///
/// The rule names three things: the §9 event set, **a registry**, and a
/// `schemaVersion` per entry. The first and third exist. The second does not:
///
/// * `docs/10-architecture/README.md` open action item **#4** states it in the
///   document's own words — "Context Map §9 fixes the 30 V1 event *names,
///   producers and consumers*. Still required: payload schemas, `schemaVersion`
///   registry entries, and partition keys."
/// * BC Map §9.1 row *Schema evolution* says evolution is "Registry-enforced",
///   naming a mechanism that has no implementation.
/// * A scan of `lib/` and `packages/` finds no registry type: `schemaVersion`
///   occurs only as a field on the `DomainEvent` envelope.
///
/// **This file does not create that registry.** Assigning a `schemaVersion` to
/// each of the 43 declared events would be authoring the V1 Event Catalog — an
/// unassigned architecture deliverable — inside a test file. That is precisely
/// the "do not invent architecture authority" line. A test may enforce a
/// decision; it may not make one.
///
/// **Nor does it weaken the rule to green.** Instead it splits the requirement:
///
/// | Half | Status | Handling |
/// |---|---|---|
/// | Envelope carries `schemaVersion`, non-optional in effect | enforceable now | asserted |
/// | Every event **raised in code** is declared in §9 | enforceable now | asserted |
/// | §9 naming convention (facts, not commands) | enforceable now | asserted |
/// | Envelope matches the §9.1 field list | enforceable now | asserted |
/// | A **registry** maps every §9 event to a `schemaVersion` | ⛔ blocked | pinned + reported |
///
/// The blocked half is pinned by a test that asserts the registry's *absence*
/// and fails the moment one appears. That is not a green tick over a gap: the
/// gap is measured, named, and reported as a remaining blocker. When the Event
/// Catalog lands, this suite goes red and demands the real assertion.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const String _bcMapPath =
    'docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md';
const String _matrixPath =
    'docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md';
const String _archReadmePath = 'docs/10-architecture/README.md';

/// The field list BC Map §9.1 fixes for the envelope. Order-insensitive.
const Set<String> _requiredEnvelopeFields = {
  'eventId',
  'eventType',
  'schemaVersion',
  'occurredAt',
  'tenantId',
  'actorId',
  'correlationId',
  'causationId',
  'aggregateId',
  'payload',
};

/// Irregular past participles that carry no `-ed` / `-en` suffix.
///
/// Needed because the convention is enforced on SHAPE, and `MessageSent` is as
/// much a fact as `StudentEnrolled`.
const Set<String> _irregularPastParticiples = {
  'Sent',
  'Taken',
  'Frozen',
  'Unfrozen',
  'Held',
  'Left',
  'Kept',
  'Lost',
  'Made',
  'Built',
  'Found',
  'Read',
  'Set',
  'Put',
  'Won',
};

/// Event names §9 declares that contain no past-tense token, together with the
/// reason §9 gives for the exception.
///
/// This is a DISCLOSURE list, not a bypass: the map's value must appear in §9
/// near the event, and an entry here whose justification has vanished from §9
/// will fail the test below. Adding a name here without a §9 justification is
/// therefore not a way to silence the rule.
const Map<String, String> _nonPastTenseWithStatedReason = {
  // §9 annotates this row verbatim: "Reminder trigger (fact, not command)".
  // It is a present-participle *state* — the membership IS expiring — which is
  // a fact about the world, not an instruction to anybody.
  'membership.MembershipExpiringSoon': 'fact, not command',
};

/// Bare imperative verbs. A local name that is EXACTLY one of these (or begins
/// with one and has no past-tense token anywhere) is a command.
///
/// BC Map §9 is explicit: "An event named as an imperative (`SendReminder`) is a
/// command, belongs to Workflow, and must not enter the event bus as a domain
/// event."
const List<String> _imperativeStems = [
  'Send',
  'Create',
  'Update',
  'Delete',
  'Assign',
  'Notify',
  'Process',
  'Handle',
  'Trigger',
  'Execute',
  'Apply',
  'Charge',
  'Revoke',
  'Grant',
  'Suspend',
  'Provision',
  'Recompute',
  'Purge',
  'Rebuild',
];

/// Splits `FeePaymentReceived` into `[Fee, Payment, Received]`.
List<String> _pascalTokens(String s) =>
    RegExp(r'[A-Z][a-z0-9]*').allMatches(s).map((m) => m.group(0)!).toList();

/// True when any token in the local name is past-tense-shaped.
///
/// Shape, not vocabulary. `<Aggregate><PastTenseVerb>` means the verb may sit
/// after a noun — `RefundIssued` is the noun "Refund" plus "Issued", which an
/// implementation that only inspected the PREFIX would misread as the
/// imperative "Refund".
bool _hasPastTenseToken(String localName) => _pascalTokens(localName).any(
      (t) =>
          t.endsWith('ed') || t.endsWith('en') ||
          _irregularPastParticiples.contains(t),
    );

/// A §9 event name that is **shorthand** in the table and whose full name
/// differs from the literal backticked token.
///
/// §9 writes some rows as `billing.SubscriptionActivated` / `Cancelled` /
/// `PaymentFailed`, where the 2nd and 3rd tokens inherit the aggregate prefix
/// from the 1st. Recorded explicitly rather than guessed, so a reader can see
/// which names are literal and which are expanded.
const Map<String, String> _shorthandExpansions = {
  'membership.Unfrozen': 'membership.MembershipUnfrozen',
  'billing.Cancelled': 'billing.SubscriptionCancelled',
  'billing.PaymentFailed': 'billing.SubscriptionPaymentFailed',
};

// ══════════════════════════════════════════════════════════════════════
// Parsing §9
// ══════════════════════════════════════════════════════════════════════

/// Every event name declared in BC Map §9, keyed to its producing context.
Map<String, String> _parseSection9() {
  final file = File(_bcMapPath);
  if (!file.existsSync()) {
    fail('Cannot find $_bcMapPath — the event authority.');
  }
  final lines = file.readAsLinesSync();

  var start = -1;
  var end = lines.length;
  for (var i = 0; i < lines.length; i++) {
    final l = lines[i].trim();
    if (start == -1 && RegExp(r'^#{2,3}\s+9\.\s').hasMatch(l)) {
      start = i;
      continue;
    }
    if (start != -1 && RegExp(r'^#{2,4}\s+9\.1').hasMatch(l)) {
      end = i;
      break;
    }
  }
  if (start == -1) fail('Could not locate "## 9." in $_bcMapPath.');

  final events = <String, String>{};
  final rowShape = RegExp(r'^\|\s*(BC-\d{2})\s*\|([^|]*)\|');

  for (var i = start; i < end; i++) {
    final m = rowShape.firstMatch(lines[i]);
    if (m == null) continue;
    final ctx = m.group(1)!;
    final cell = m.group(2)!;

    // Qualified `context.EventName`, or a bare `EventName` continuing the
    // slash-list started by the previous qualified token in the same cell.
    final tokens = RegExp(
      r'`([a-z][A-Za-z0-9]*\.[A-Za-z0-9]+|[A-Z][A-Za-z0-9]+)`',
    ).allMatches(cell).map((x) => x.group(1)!);

    String? prefix;
    for (final t in tokens) {
      final full = t.contains('.')
          ? t
          : (prefix == null ? null : '$prefix.$t');
      if (t.contains('.')) prefix = t.split('.').first;
      if (full == null) continue;
      events[full] = ctx;
    }
  }
  return events;
}

/// Event names actually raised anywhere in `lib/`.
Map<String, String> _raisedEventTypes() {
  final out = <String, String>{};
  final dir = Directory('lib');
  if (!dir.existsSync()) fail('Cannot find lib/.');
  final shape = RegExp(r"eventType:\s*'([^']+)'");
  for (final f in dir.listSync(recursive: true).whereType<File>()) {
    if (!f.path.endsWith('.dart')) continue;
    for (final m in shape.allMatches(f.readAsStringSync())) {
      out[m.group(1)!] = f.path;
    }
  }
  return out;
}

void main() {
  final declared = _parseSection9();
  final raised = _raisedEventTypes();

  // ════════════════════════════════════════════════════════════════════
  group('§9 parse integrity', () {
    test('the §9 table parses to a non-empty event set', () {
      // Vacuity guard: every assertion below is quantified over `declared`.
      expect(
        declared,
        isNotEmpty,
        reason:
            'The §9 event table did not parse. An empty set would make every '
            'assertion in this file pass over nothing.',
      );
      expect(
        declared.length,
        43,
        reason:
            'Measured §9 event count changed to ${declared.length}. Update '
            'this pin in the same change that edits §9, so the edit is '
            'deliberate. Parsed: '
            '${(declared.keys.toList()..sort()).join(', ')}',
      );
    });

    test('every declared name is fully qualified as <context>.<Event>', () {
      for (final name in declared.keys) {
        expect(
          name,
          matches(RegExp(r'^[a-z][A-Za-z0-9]*\.[A-Z][A-Za-z0-9]+$')),
          reason:
              '$name does not match the binding §9 convention '
              '"<Context>.<Aggregate><PastTenseVerb>". An unqualified event '
              'name cannot be routed to a producing context.',
        );
      }
    });

    test('every declared event name is past-tense-shaped — events are facts',
        () {
      // The rule is enforced on SHAPE across the whole local name, not on its
      // first token. An earlier draft of this test checked whether the name
      // STARTED with an imperative stem and produced a false positive on
      // `fee.RefundIssued` — where "Refund" is the aggregate noun and "Issued"
      // is the past-tense verb. Checking the prefix tests the wrong half of
      // `<Aggregate><PastTenseVerb>`.
      final offenders = <String>[];
      for (final name in declared.keys) {
        final local = name.split('.').last;
        if (_hasPastTenseToken(local)) continue;
        if (_nonPastTenseWithStatedReason.containsKey(name)) continue;
        offenders.add(name);
      }

      expect(
        offenders,
        isEmpty,
        reason:
            '§9 forbids imperative event names: "an event named as an '
            'imperative is a command, belongs to Workflow, and must not enter '
            'the event bus as a domain event". These declared names contain no '
            'past-tense token and no recorded exception: '
            '${offenders.join(', ')}',
      );
    });

    test('no declared event is a BARE imperative verb', () {
      // Catches the specific failure §9 names — `SendReminder` — which does
      // contain no past-tense token and would already be caught above, but is
      // asserted separately because the two rules have different repairs:
      // a bare imperative must MOVE to Workflow, whereas a mis-tensed fact
      // must be RENAMED.
      final offenders = <String>[];
      for (final name in declared.keys) {
        final local = name.split('.').last;
        if (_hasPastTenseToken(local)) continue;
        final first = _pascalTokens(local).firstOrNull;
        if (first != null && _imperativeStems.contains(first)) {
          offenders.add('$name (imperative "$first" → belongs to Workflow)');
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'A command must not enter the event bus as a domain event: '
            '${offenders.join(', ')}',
      );
    });

    test('each non-past-tense exception is justified by §9 itself', () {
      // Prevents the exception map from becoming a silent bypass. The stated
      // reason must actually appear in the BC Map, near the event, or the
      // "exception" is this test file inventing an allowance.
      expect(
        _nonPastTenseWithStatedReason,
        isNotEmpty,
        reason:
            'If §9 no longer contains a non-past-tense event name, delete the '
            'exception map and the two tests that consult it.',
      );

      final bcMap = File(_bcMapPath).readAsStringSync();
      for (final entry in _nonPastTenseWithStatedReason.entries) {
        final localName = entry.key.split('.').last;
        expect(
          declared.containsKey(entry.key),
          isTrue,
          reason:
              '${entry.key} is listed as an exception but is no longer '
              'declared in §9. Remove the stale exception.',
        );
        expect(
          bcMap,
          contains(entry.value),
          reason:
              'The exception for ${entry.key} claims §9 justifies it with '
              '"${entry.value}", but that text is not in $_bcMapPath. An '
              'exception with no authority behind it is this test file '
              'granting itself an allowance.',
        );
        // And the justification must sit on a line that mentions the event,
        // not merely somewhere in a 700-line document. The event name appears
        // on several lines (§9's declaring row, and the E-23 edge row that
        // cites it as an example), so ALL mentions are considered and at least
        // one must carry the justification.
        final mentioning = bcMap
            .split('\n')
            .where((l) => l.contains(localName))
            .toList();
        expect(
          mentioning,
          isNotEmpty,
          reason: '$localName is not mentioned anywhere in $_bcMapPath.',
        );
        expect(
          mentioning.any((l) => l.contains(entry.value)),
          isTrue,
          reason:
              'The justification "${entry.value}" for ${entry.key} was found '
              'in $_bcMapPath but NOT on any line that mentions the event. It '
              'must annotate the event it excuses, or the exception is '
              'unsupported. Lines mentioning $localName:\n'
              '${mentioning.map((l) => '  $l').join('\n')}',
        );
      }
    });

    test('DISCLOSED INCONSISTENCY — README says 30 events, §9 declares 43', () {
      // Not a failure of either document's intent, but the two disagree, and a
      // reader trusting the README would under-build the catalogue by 13
      // events. Recorded here rather than silently resolved: deciding which
      // number is correct is an amendment to an authority document, which a
      // test file has no standing to make.
      final readme = File(_archReadmePath);
      expect(readme.existsSync(), isTrue, reason: 'Missing $_archReadmePath.');
      final text = readme.readAsStringSync();

      expect(
        text,
        contains('the 30 V1 event'),
        reason:
            'The README no longer says "30 V1 event". If it was corrected to '
            'match the ${declared.length} names §9 declares, delete this test '
            'and note the resolution — the inconsistency it tracks is gone.',
      );
      expect(
        declared.length,
        isNot(30),
        reason:
            'README open action item #4 and §9 now agree. Remove this '
            'disclosure test.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // ENFORCEABLE HALF 1 — the envelope.
  // ════════════════════════════════════════════════════════════════════
  group('the envelope carries schemaVersion, per §9.1', () {
    test('schemaVersion is present, positive, and defaults rather than '
        'being nullable', () {
      final e = DomainEvent(
        eventId: 'EV-1',
        eventType: 'enrollment.StudentEnrolled',
        tenantId: const TenantId('T-1'),
        aggregateId: 'SR-1',
        occurredAt: DateTime.utc(2026, 7, 1),
        payload: const {},
      );

      expect(
        e.schemaVersion,
        1,
        reason:
            'An event with no schemaVersion cannot be evolved additively — a '
            'consumer has no way to know which shape it received.',
      );
      expect(
        e.schemaVersion,
        greaterThan(0),
        reason: 'Version 0 is not a version.',
      );
      expect(
        e.schemaVersion,
        isA<int>(),
        reason:
            'A nullable or String version would let an unversioned event onto '
            'the bus, which is the failure §9.1 "Registry-enforced" exists to '
            'prevent.',
      );
    });

    test('an explicit schemaVersion is honoured — evolution is expressible', () {
      final e = DomainEvent(
        eventId: 'EV-2',
        eventType: 'fee.FeePaymentReceived',
        tenantId: const TenantId('T-1'),
        aggregateId: 'LEDGER-1',
        occurredAt: DateTime.utc(2026, 7, 1),
        payload: const {},
        schemaVersion: 3,
      );
      expect(
        e.schemaVersion,
        3,
        reason:
            'A breaking change requires "a new schemaVersion with dual '
            'publication during migration" (§9.1). If the field were ignored, '
            'dual publication would be impossible.',
      );
    });

    test('the envelope exposes every field §9.1 fixes', () {
      final src = File(
        'packages/liboora_contracts/lib/src/events/domain_event.dart',
      );
      expect(src.existsSync(), isTrue);
      final text = src.readAsStringSync();

      final missing = _requiredEnvelopeFields
          .where((f) => !RegExp('\\b$f\\b').hasMatch(text))
          .toList()
        ..sort();

      expect(
        missing,
        isEmpty,
        reason:
            'BC Map §9.1 fixes the envelope field set. Missing from '
            'DomainEvent: ${missing.join(', ')}. Each field is there because '
            'its absence causes a specific production failure, enumerated in '
            'the class doc comment.',
      );
    });

    test('tenantId is mandatory and strongly typed — X-13', () {
      // §9.1: "tenantId is mandatory on every domain event. A consumer that
      // processes an event without establishing tenant context must fail
      // loudly, not default." A required TenantId parameter is how that is
      // made non-bypassable rather than merely documented.
      final e = DomainEvent(
        eventId: 'EV-3',
        eventType: 'attendance.StudentCheckedIn',
        tenantId: const TenantId('T-7'),
        aggregateId: 'AD-1',
        occurredAt: DateTime.utc(2026, 7, 1),
        payload: const {},
      );
      expect(e.tenantId, isA<TenantId>());
      expect(e.tenantId.value, 'T-7');
      expect(
        e.tenantId.isValid,
        isTrue,
        reason:
            'A blank tenant id would satisfy the type while defeating the '
            'rule.',
      );
    });

    test('context is derived from eventType, not stored separately', () {
      final e = DomainEvent(
        eventId: 'EV-4',
        eventType: 'membership.MembershipRenewed',
        tenantId: const TenantId('T-1'),
        aggregateId: 'MEM-1',
        occurredAt: DateTime.utc(2026, 7, 1),
        payload: const {},
      );
      expect(
        e.context,
        'membership',
        reason:
            'A separately stored context could disagree with the event name, '
            'giving two answers to "who produced this".',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // ENFORCEABLE HALF 2 — nothing undeclared reaches the bus.
  // ════════════════════════════════════════════════════════════════════
  group('every event raised in code is declared in §9', () {
    test('no undeclared event type is raised anywhere in lib/', () {
      expect(
        raised,
        isNotEmpty,
        reason:
            'No raised eventType literals found in lib/. Either the scanner is '
            'broken or no events are emitted; either way this must not pass '
            'silently.',
      );

      final undeclared = <String>[];
      for (final entry in raised.entries) {
        final name = entry.key;
        final isDeclared = declared.containsKey(name) ||
            _shorthandExpansions.values.contains(name);
        if (!isDeclared) undeclared.add('${entry.key}  (${entry.value})');
      }

      expect(
        undeclared,
        isEmpty,
        reason:
            'These event types are raised in code but are NOT declared in BC '
            'Map §9:\n${undeclared.map((u) => '  - $u').join('\n')}\n\n'
            '§9 is the Published Language. An event on the bus that no context '
            'declares has no owner, no documented consumer set and no schema — '
            'it is a private message using public infrastructure.',
      );
    });

    test('every raised event name obeys the §9 naming convention', () {
      for (final entry in raised.entries) {
        expect(
          entry.key,
          matches(RegExp(r'^[a-z][A-Za-z0-9]*\.[A-Z][A-Za-z0-9]+$')),
          reason:
              '${entry.key} in ${entry.value} is not '
              '<context>.<Aggregate><PastTenseVerb>.',
        );
      }
    });

    test('the raised set is reported against §9 coverage', () {
      // A measurement, pinned so a change is deliberate. Low coverage is the
      // expected state of a skeleton and is NOT asserted as acceptable — it is
      // asserted as *known*.
      expect(
        raised.length,
        8,
        reason:
            'Measured: ${raised.length} of ${declared.length} declared §9 '
            'events are raised in lib/. Raised: '
            '${(raised.keys.toList()..sort()).join(', ')}.\n'
            'An INCREASE is progress — update this pin in the same change. '
            'A DECREASE means an event producer was removed while §9 still '
            'declares the event, which is an architecture regression.',
      );

      final unraised = declared.keys.where((e) => !raised.containsKey(e)).length;
      expect(
        unraised,
        declared.length - raised.length,
        reason: 'Partition failure between raised and unraised events.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // ⛔ THE BLOCKED HALF — pinned so it cannot be forgotten or faked.
  // ════════════════════════════════════════════════════════════════════
  group('⛔ BLOCKER — the schemaVersion registry does not exist', () {
    test('Matrix §10.3 still requires a registry, so the obligation stands',
        () {
      final matrix = File(_matrixPath);
      expect(matrix.existsSync(), isTrue);
      final text = matrix.readAsStringSync();
      expect(
        text,
        contains('every_event_has_schema_test.dart'),
        reason: 'Matrix §10.3 no longer names this test.',
      );
      expect(
        text,
        contains('exists in the registry with a `schemaVersion`'),
        reason:
            'The §10.3 requirement wording changed. Re-read it before '
            'trusting this file\'s split of enforceable vs blocked.',
      );
    });

    test('the architecture README still records the registry as an OPEN '
        'action item', () {
      // This is the authority for calling it a blocker rather than a defect.
      final text = File(_archReadmePath).readAsStringSync();
      expect(
        text,
        contains('`schemaVersion` registry entries'),
        reason:
            'README open action item #4 no longer lists "schemaVersion '
            'registry entries" as outstanding. If the V1 Event Catalog has '
            'landed, this whole group must be REPLACED by a real registry '
            'assertion: every one of the ${declared.length} §9 events resolved '
            'to a registered schemaVersion. Do not simply delete this group — '
            'that would drop the §10.3 requirement entirely.',
      );
    });

    test('no event registry exists in code — asserted as ABSENT, and this '
        'test fails the moment one appears', () {
      // Deliberately inverted. Passing means "still blocked, still reported".
      // Failing means "a registry now exists" — which is the good outcome and
      // must force this file to be rewritten to assert against it.
      final found = <String>[];
      for (final root in ['lib', 'packages']) {
        final dir = Directory(root);
        if (!dir.existsSync()) continue;
        for (final f in dir.listSync(recursive: true).whereType<File>()) {
          if (!f.path.endsWith('.dart')) continue;
          final text = f.readAsStringSync();
          if (RegExp(
            r'\bclass\s+\w*Event\w*Registry\b|\bclass\s+\w*Registry\w*Event\b'
            r'|const\s+\w*eventRegistry\b|\beventSchemaRegistry\b',
          ).hasMatch(text)) {
            found.add(f.path);
          }
        }
      }

      expect(
        found,
        isEmpty,
        reason:
            '✅ GOOD NEWS, INTENTIONAL FAILURE. An event registry now appears '
            'to exist in: ${found.join(', ')}.\n\n'
            'The blocker this group tracks is resolved. Replace this group '
            'with the real §10.3 assertion: for each of the '
            '${declared.length} §9 events, the registry resolves it to a '
            'positive schemaVersion, and no registry entry exists for an event '
            '§9 does not declare.',
      );
    });

    test('the blocker is stated in one place, with its consequence', () {
      // A self-check that this file's disclosure has not been quietly edited
      // out, leaving the other tests looking like full coverage of §10.3.
      final self = File('test/architecture/every_event_has_schema_test.dart');
      expect(self.existsSync(), isTrue);
      final text = self.readAsStringSync();
      expect(
        text,
        contains('THE REGISTRY DOES NOT EXIST'),
        reason:
            'The blocker disclosure was removed from this file\'s header. '
            'Without it, the passing tests above read as complete coverage of '
            'Matrix §10.3, which they are not.',
      );
    });
  });
}
