// Conformance tests for the BC-10 identity event schemas (IMPL-201).
//
// Every assertion traces to frozen Rank-3 PRD-003 (Student_Identity_PRD_v1.md
// §4.14, SID-4.51, SID-4.52, SID-4.55) and Accepted ADR-0078. The set is
// closed; the names, emitted-when conditions and consumers below are
// transcribed from the PRD — this test is the PRD-to-code traceability.
import 'package:liboora_contracts/liboora_contracts.dart';
import 'package:test/test.dart';

void main() {
  final personId = const PersonId('person-test-0001');
  final occurredAt = DateTime.parse('2026-10-31T12:00:00.000Z');
  const actor = 'system';
  const eventId = 'evt-test-0001';

  GlobalEvent emit(IdentityEventSpec spec) => IdentityEvents.emit(
    spec,
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: 'corr-1',
    causationId: 'cause-1',
  );

  group('SID-4.51 — the closed set', () {
    test('registers exactly sixteen events', () {
      expect(IdentityEvents.specs, hasLength(16));
    });

    test('ids are SEV-1 through SEV-16 in register order', () {
      expect(
        IdentityEvents.specs.map((s) => s.id).toList(),
        List.generate(16, (i) => 'SEV-${i + 1}'),
      );
    });

    test('every event name matches the PRD §4.14 register verbatim', () {
      const prdNames = [
        'identity.PersonIdentityCreated', // SEV-1
        'identity.PersonProfileCompleted', // SEV-2
        'identity.PersonProfileUpdated', // SEV-3
        'identity.PersonNameChanged', // SEV-4
        'identity.PersonUsernameChanged', // SEV-5
        'identity.PersonUsernameReleased', // SEV-6
        'identity.PersonProfilePhotoUpdated', // SEV-7
        'identity.PersonProfilePhotoRemoved', // SEV-8
        'identity.PersonPrivacyModeChanged', // SEV-9
        'identity.PersonStatisticsVisibilityChanged', // SEV-10
        'identity.PersonAchievementsVisibilityChanged', // SEV-11
        'identity.PersonSuspended', // SEV-12
        'identity.PersonReinstated', // SEV-13
        'identity.PersonArchived', // SEV-14
        'identity.PersonRestored', // SEV-15
        'identity.PersonAnonymised', // SEV-16
      ];
      expect(IdentityEvents.specs.map((s) => s.eventType).toList(), prdNames);
    });

    test('every emitted-when condition matches the PRD §4.14 register', () {
      final byId = {for (final s in IdentityEvents.specs) s.id: s};
      expect(
        byId['SEV-1']!.emittedWhen,
        'Identity created atomically with the account',
      );
      expect(byId['SEV-2']!.emittedWhen, 'Pending Profile → Active');
      expect(byId['SEV-3']!.emittedWhen, 'Any owned profile field changed');
      expect(byId['SEV-4']!.emittedWhen, 'Full Name changed');
      expect(byId['SEV-5']!.emittedWhen, 'Username changed');
      expect(
        byId['SEV-6']!.emittedWhen,
        'Previous username left the hold period (SCFG-5)',
      );
      expect(
        byId['SEV-7']!.emittedWhen,
        'Global Profile Photo set or replaced',
      );
      expect(
        byId['SEV-8']!.emittedWhen,
        'Global Profile Photo removed or hidden',
      );
      expect(byId['SEV-9']!.emittedWhen, 'Public ⇄ Private');
      expect(
        byId['SEV-10']!.emittedWhen,
        'Study-statistics visibility toggled',
      );
      expect(byId['SEV-11']!.emittedWhen, 'Achievements visibility toggled');
      expect(
        byId['SEV-12']!.emittedWhen,
        'Identity suspended by Platform Administrator',
      );
      expect(byId['SEV-13']!.emittedWhen, 'Suspension lifted');
      expect(byId['SEV-14']!.emittedWhen, 'Identity archived');
      expect(
        byId['SEV-15']!.emittedWhen,
        'Archived identity returned to Active, same PersonId',
      );
      expect(
        byId['SEV-16']!.emittedWhen,
        'Underlying account erased by BC-18 (ID-5)',
      );
    });

    test('every consumer list matches the PRD §4.14 register', () {
      final byId = {for (final s in IdentityEvents.specs) s.id: s};
      expect(byId['SEV-1']!.consumers, ['BC-23', 'BC-24', 'BC-26']);
      expect(byId['SEV-2']!.consumers, ['BC-23', 'BC-24', 'BC-26']);
      expect(byId['SEV-3']!.consumers, ['BC-23', 'BC-24', 'BC-26', 'BC-11']);
      expect(byId['SEV-4']!.consumers, ['BC-23', 'BC-24', 'BC-11']);
      expect(byId['SEV-5']!.consumers, ['BC-23', 'BC-24', 'BC-11', 'BC-12']);
      expect(byId['SEV-6']!.consumers, ['BC-24']);
      expect(byId['SEV-7']!.consumers, ['BC-23', 'BC-24', 'BC-11']);
      expect(byId['SEV-8']!.consumers, ['BC-23', 'BC-24', 'BC-11']);
      expect(byId['SEV-9']!.consumers, ['BC-23', 'BC-24', 'BC-11', 'BC-26']);
      expect(byId['SEV-10']!.consumers, ['BC-23', 'BC-24', 'BC-26']);
      expect(byId['SEV-11']!.consumers, ['BC-23', 'BC-24', 'BC-26']);
      expect(byId['SEV-12']!.consumers, ['BC-23', 'BC-24', 'BC-11', 'BC-12']);
      expect(byId['SEV-13']!.consumers, ['BC-23', 'BC-24', 'BC-11', 'BC-12']);
      expect(byId['SEV-14']!.consumers, [
        'BC-23',
        'BC-24',
        'BC-11',
        'BC-12',
        'BC-26',
      ]);
      expect(byId['SEV-15']!.consumers, ['BC-23', 'BC-24', 'BC-11', 'BC-26']);
      expect(byId['SEV-16']!.consumers, [
        'BC-23',
        'BC-24',
        'BC-11',
        'BC-12',
        'BC-26',
      ]);
    });
  });

  group('ADR-0078 — the Global envelope', () {
    test('every event is in the identity context', () {
      for (final spec in IdentityEvents.specs) {
        expect(emit(spec).context, 'identity', reason: spec.id);
      }
    });

    test('the envelope type carries no tenantId field', () {
      final json = emit(IdentityEvents.specs.first).toJson();
      expect(
        json.containsKey('tenantId'),
        isFalse,
        reason: 'ADR-0078 §2.1 — tenantId never appears on a Global event',
      );
    });

    test('every event carries the other mandatory §9.1 envelope fields', () {
      for (final spec in IdentityEvents.specs) {
        final e = emit(spec);
        expect(e.eventId, eventId, reason: spec.id);
        expect(e.eventType, spec.eventType, reason: spec.id);
        expect(
          e.aggregateId,
          personId.value,
          reason: 'partition key = the global aggregate (PersonId)',
        );
        expect(e.occurredAt, occurredAt, reason: spec.id);
        expect(e.actorId, actor, reason: spec.id);
        expect(e.correlationId, 'corr-1', reason: spec.id);
        expect(e.causationId, 'cause-1', reason: spec.id);
      }
    });

    test('aggregateId is always the PersonId, never a tenant or record id', () {
      for (final spec in IdentityEvents.specs) {
        expect(emit(spec).aggregateId, personId.value, reason: spec.id);
      }
    });
  });

  group('SID-4.52 — the payload contract', () {
    test('every payload carries exactly the six mandatory keys', () {
      for (final spec in IdentityEvents.specs) {
        final payload = emit(spec).payload;
        expect(
          payload.keys.toSet(),
          IdentityEvents.payloadKeys,
          reason: '${spec.id} payload key set is fixed by SID-4.52',
        );
      }
    });

    test('no forbidden field ever appears in any payload', () {
      for (final spec in IdentityEvents.specs) {
        final payload = emit(spec).payload;
        for (final forbidden in IdentityEvents.forbiddenPayloadKeys) {
          expect(
            payload.containsKey(forbidden),
            isFalse,
            reason: '${spec.id} must not carry $forbidden',
          );
        }
      }
    });

    test('payload carries the identity subject and the actor', () {
      final payload = emit(IdentityEvents.specs.first).payload;
      expect(payload['personId'], personId.value);
      expect(payload['actor'], actor);
      expect(payload['schemaVersion'], IdentityEvents.schemaVersion);
    });

    test('payload carries no profile-field values (SID-4.53)', () {
      // Consumers may only invalidate caches; the payload carries no values
      // to store. The key set test above proves the schema; this asserts the
      // emitted value set too.
      for (final spec in IdentityEvents.specs) {
        final values = emit(spec).payload.values;
        expect(
          values.whereType<String>().any((v) => v.contains('@')),
          isFalse,
          reason: '${spec.id} carries no email-like value',
        );
      }
    });
  });

  group('serialisation', () {
    test('toJson → fromJson round-trips every event type', () {
      for (final spec in IdentityEvents.specs) {
        final e = emit(spec);
        final restored = GlobalEvent.fromJson(e.toJson());
        expect(restored.eventId, e.eventId, reason: spec.id);
        expect(restored.eventType, e.eventType, reason: spec.id);
        expect(restored.aggregateId, e.aggregateId, reason: spec.id);
        expect(restored.occurredAt, e.occurredAt, reason: spec.id);
        expect(restored.payload, e.payload, reason: spec.id);
        expect(restored.actorId, e.actorId, reason: spec.id);
        expect(restored.schemaVersion, e.schemaVersion, reason: spec.id);
        expect(restored.correlationId, e.correlationId, reason: spec.id);
        expect(restored.causationId, e.causationId, reason: spec.id);
      }
    });

    test('round-trip never introduces a tenantId', () {
      for (final spec in IdentityEvents.specs) {
        final restored = GlobalEvent.fromJson(emit(spec).toJson());
        expect(
          restored.toJson().containsKey('tenantId'),
          isFalse,
          reason: spec.id,
        );
      }
    });

    test('fromJson rejects a missing mandatory envelope field', () {
      final json = emit(IdentityEvents.specs.first).toJson()
        ..remove('eventType');
      expect(() => GlobalEvent.fromJson(json), throwsA(isA<TypeError>()));
    });
  });

  group('schemaVersion compatibility (additive-only)', () {
    test('the registry version is 1 and events default to it', () {
      expect(IdentityEvents.schemaVersion, 1);
      for (final spec in IdentityEvents.specs) {
        expect(emit(spec).schemaVersion, 1, reason: spec.id);
      }
    });

    test('an explicit version survives the round-trip', () {
      final e = IdentityEvents.emit(
        IdentityEvents.specs.first,
        personId: personId,
        actor: actor,
        eventId: eventId,
        occurredAt: occurredAt,
        schemaVersion: 2,
      );
      expect(e.schemaVersion, 2);
      expect(e.payload['schemaVersion'], 2);
      expect(GlobalEvent.fromJson(e.toJson()).schemaVersion, 2);
    });
  });

  group('typed factories — the consumer-facing contract', () {
    test('all sixteen factories emit their registered event type', () {
      final emitted = <String, String>{
        'SEV-1': IdentityEvents.personIdentityCreated(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-2': IdentityEvents.personProfileCompleted(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-3': IdentityEvents.personProfileUpdated(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-4': IdentityEvents.personNameChanged(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-5': IdentityEvents.personUsernameChanged(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-6': IdentityEvents.personUsernameReleased(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-7': IdentityEvents.personProfilePhotoUpdated(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-8': IdentityEvents.personProfilePhotoRemoved(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-9': IdentityEvents.personPrivacyModeChanged(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-10': IdentityEvents.personStatisticsVisibilityChanged(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-11': IdentityEvents.personAchievementsVisibilityChanged(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-12': IdentityEvents.personSuspended(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-13': IdentityEvents.personReinstated(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-14': IdentityEvents.personArchived(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-15': IdentityEvents.personRestored(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
        'SEV-16': IdentityEvents.personAnonymised(
          personId: personId,
          actor: actor,
          eventId: eventId,
          occurredAt: occurredAt,
        ).eventType,
      };
      for (final spec in IdentityEvents.specs) {
        expect(emitted[spec.id], spec.eventType, reason: spec.id);
      }
    });

    test('every event type is past-tense (envelope naming rule)', () {
      final pastTense = RegExp(r'^identity\.Person[A-Z][a-zA-Z]*(ed|sed)$');
      for (final spec in IdentityEvents.specs) {
        expect(
          pastTense.hasMatch(spec.eventType),
          isTrue,
          reason: '${spec.id} — ${spec.eventType}',
        );
      }
    });
  });
}
