/// Liboora Shared Kernel (R0) — BC-10 Global Person Identity event schemas.
///
/// Implements `SEV-1` … `SEV-16` — the **closed set** of V1 domain events for
/// `BC-10`, exactly as registered in frozen Rank-3 `PRD-003`
/// (`Student_Identity_PRD_v1.md` §4.14) and mirrored in the Bounded Context
/// Map §9 event catalogue (L424-428) and the module manifest
/// (`tool/module_dependencies.yaml`, `domain/person` `emits_events`).
///
/// Rules implemented here, without addition or interpretation:
///
/// * `SID-4.51` — the set is closed for V1. Adding an event requires an
///   update to the PRD register and to BC Map §9 first. The registry below
///   exposes exactly sixteen specs; the conformance test enforces that count.
/// * `SID-4.52` — every payload carries event ID, event type, schema version,
///   `PersonId`, occurred-at and actor, and never a mobile number, email,
///   parent contact, address, `StudentRecordId`, `tenantId`, credential or
///   OTP.
/// * `SID-4.53` — consumers may invalidate display caches with these events;
///   they carry no profile-field values to store. The payloads below carry no
///   such values for that reason.
/// * `ADR-0078` §2.1/§2.4 — Global envelope: every §9.1 envelope field except
///   `tenantId`, which `ID-2` forbids in the Global band. No fallback tenant
///   id is created anywhere.
/// * `SID-4.55` — delivery is at-least-once; consumers must be idempotent,
///   keyed on `eventId`.
///
/// Emission wiring (outbox drain, transactional coupling) is **not** part of
/// this schema library — it belongs to the emitting tasks (`IMPL-203`,
/// `IMPL-205`). Nothing here publishes anything.
library;

import '../value_objects/identifiers.dart';
import 'global_event.dart';

/// One registered identity event: its PRD identifiers and contract surface,
/// transcribed verbatim from `Student_Identity_PRD_v1.md` §4.14.
final class IdentityEventSpec {
  const IdentityEventSpec({
    required this.id,
    required this.eventType,
    required this.emittedWhen,
    required this.consumers,
  });

  /// The PRD register id — `SEV-1` … `SEV-16`.
  final String id;

  /// The wire name, `identity.Person<PastTense>` per the envelope naming rule.
  final String eventType;

  /// The "Emitted when" column of PRD-003 §4.14, verbatim.
  final String emittedWhen;

  /// The "Consumers" column of PRD-003 §4.14, verbatim.
  final List<String> consumers;
}

/// The closed registry of `SEV-1` … `SEV-16` and the factories that emit them.
abstract final class IdentityEvents {
  /// `SID-4.52` — every payload carries the schema version. Additive-only
  /// within this major version (BC Map §9.1; `DomainEvent` doc comment).
  static const int schemaVersion = 1;

  /// The sixteen registered events, in PRD register order. **Closed set**
  /// (`SID-4.51`) — the conformance test asserts this length.
  static const List<IdentityEventSpec> specs = [
    IdentityEventSpec(
      id: 'SEV-1',
      eventType: 'identity.PersonIdentityCreated',
      emittedWhen: 'Identity created atomically with the account',
      consumers: ['BC-23', 'BC-24', 'BC-26'],
    ),
    IdentityEventSpec(
      id: 'SEV-2',
      eventType: 'identity.PersonProfileCompleted',
      emittedWhen: 'Pending Profile → Active',
      consumers: ['BC-23', 'BC-24', 'BC-26'],
    ),
    IdentityEventSpec(
      id: 'SEV-3',
      eventType: 'identity.PersonProfileUpdated',
      emittedWhen: 'Any owned profile field changed',
      consumers: ['BC-23', 'BC-24', 'BC-26', 'BC-11'],
    ),
    IdentityEventSpec(
      id: 'SEV-4',
      eventType: 'identity.PersonNameChanged',
      emittedWhen: 'Full Name changed',
      consumers: ['BC-23', 'BC-24', 'BC-11'],
    ),
    IdentityEventSpec(
      id: 'SEV-5',
      eventType: 'identity.PersonUsernameChanged',
      emittedWhen: 'Username changed',
      consumers: ['BC-23', 'BC-24', 'BC-11', 'BC-12'],
    ),
    IdentityEventSpec(
      id: 'SEV-6',
      eventType: 'identity.PersonUsernameReleased',
      emittedWhen: 'Previous username left the hold period (SCFG-5)',
      consumers: ['BC-24'],
    ),
    IdentityEventSpec(
      id: 'SEV-7',
      eventType: 'identity.PersonProfilePhotoUpdated',
      emittedWhen: 'Global Profile Photo set or replaced',
      consumers: ['BC-23', 'BC-24', 'BC-11'],
    ),
    IdentityEventSpec(
      id: 'SEV-8',
      eventType: 'identity.PersonProfilePhotoRemoved',
      emittedWhen: 'Global Profile Photo removed or hidden',
      consumers: ['BC-23', 'BC-24', 'BC-11'],
    ),
    IdentityEventSpec(
      id: 'SEV-9',
      eventType: 'identity.PersonPrivacyModeChanged',
      emittedWhen: 'Public ⇄ Private',
      consumers: ['BC-23', 'BC-24', 'BC-11', 'BC-26'],
    ),
    IdentityEventSpec(
      id: 'SEV-10',
      eventType: 'identity.PersonStatisticsVisibilityChanged',
      emittedWhen: 'Study-statistics visibility toggled',
      consumers: ['BC-23', 'BC-24', 'BC-26'],
    ),
    IdentityEventSpec(
      id: 'SEV-11',
      eventType: 'identity.PersonAchievementsVisibilityChanged',
      emittedWhen: 'Achievements visibility toggled',
      consumers: ['BC-23', 'BC-24', 'BC-26'],
    ),
    IdentityEventSpec(
      id: 'SEV-12',
      eventType: 'identity.PersonSuspended',
      emittedWhen: 'Identity suspended by Platform Administrator',
      consumers: ['BC-23', 'BC-24', 'BC-11', 'BC-12'],
    ),
    IdentityEventSpec(
      id: 'SEV-13',
      eventType: 'identity.PersonReinstated',
      emittedWhen: 'Suspension lifted',
      consumers: ['BC-23', 'BC-24', 'BC-11', 'BC-12'],
    ),
    IdentityEventSpec(
      id: 'SEV-14',
      eventType: 'identity.PersonArchived',
      emittedWhen: 'Identity archived',
      consumers: ['BC-23', 'BC-24', 'BC-11', 'BC-12', 'BC-26'],
    ),
    IdentityEventSpec(
      id: 'SEV-15',
      eventType: 'identity.PersonRestored',
      emittedWhen: 'Archived identity returned to Active, same PersonId',
      consumers: ['BC-23', 'BC-24', 'BC-11', 'BC-26'],
    ),
    IdentityEventSpec(
      id: 'SEV-16',
      eventType: 'identity.PersonAnonymised',
      emittedWhen: 'Underlying account erased by BC-18 (ID-5)',
      consumers: ['BC-23', 'BC-24', 'BC-11', 'BC-12', 'BC-26'],
    ),
  ];

  /// `SID-4.52` — the exact payload key set of every identity event.
  static const Set<String> payloadKeys = {
    'eventId',
    'eventType',
    'schemaVersion',
    'personId',
    'occurredAt',
    'actor',
  };

  /// The fields `SID-4.52` forbids in any identity-event payload.
  static const Set<String> forbiddenPayloadKeys = {
    'mobileNumber',
    'email',
    'parentContact',
    'address',
    'studentRecordId',
    'tenantId',
    'credential',
    'otp',
  };

  /// Emits the event registered as [spec] — the generic, spec-driven form of
  /// the sixteen typed factories below. The payload carries exactly the
  /// `SID-4.52` key set; the envelope is the ADR-0078 Global shape.
  static GlobalEvent emit(
    IdentityEventSpec spec, {
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
    int schemaVersion = schemaVersion,
  }) => GlobalEvent(
    eventId: eventId,
    eventType: spec.eventType,
    aggregateId: personId.value,
    occurredAt: occurredAt,
    payload: {
      'eventId': eventId,
      'eventType': spec.eventType,
      'schemaVersion': schemaVersion,
      'personId': personId.value,
      'occurredAt': occurredAt.toIso8601String(),
      'actor': actor,
    },
    actorId: actor,
    schemaVersion: schemaVersion,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-1` — `identity.PersonIdentityCreated`.
  static GlobalEvent personIdentityCreated({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[0],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-2` — `identity.PersonProfileCompleted`.
  static GlobalEvent personProfileCompleted({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[1],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-3` — `identity.PersonProfileUpdated`.
  static GlobalEvent personProfileUpdated({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[2],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-4` — `identity.PersonNameChanged`.
  static GlobalEvent personNameChanged({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[3],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-5` — `identity.PersonUsernameChanged`.
  static GlobalEvent personUsernameChanged({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[4],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-6` — `identity.PersonUsernameReleased`.
  static GlobalEvent personUsernameReleased({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[5],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-7` — `identity.PersonProfilePhotoUpdated`.
  static GlobalEvent personProfilePhotoUpdated({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[6],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-8` — `identity.PersonProfilePhotoRemoved`.
  static GlobalEvent personProfilePhotoRemoved({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[7],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-9` — `identity.PersonPrivacyModeChanged`.
  static GlobalEvent personPrivacyModeChanged({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[8],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-10` — `identity.PersonStatisticsVisibilityChanged`.
  static GlobalEvent personStatisticsVisibilityChanged({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[9],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-11` — `identity.PersonAchievementsVisibilityChanged`.
  static GlobalEvent personAchievementsVisibilityChanged({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[10],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-12` — `identity.PersonSuspended`.
  static GlobalEvent personSuspended({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[11],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-13` — `identity.PersonReinstated`.
  static GlobalEvent personReinstated({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[12],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-14` — `identity.PersonArchived`.
  static GlobalEvent personArchived({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[13],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-15` — `identity.PersonRestored`.
  static GlobalEvent personRestored({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[14],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );

  /// `SEV-16` — `identity.PersonAnonymised`.
  static GlobalEvent personAnonymised({
    required PersonId personId,
    required String actor,
    required String eventId,
    required DateTime occurredAt,
    String? correlationId,
    String? causationId,
  }) => emit(
    specs[15],
    personId: personId,
    actor: actor,
    eventId: eventId,
    occurredAt: occurredAt,
    correlationId: correlationId,
    causationId: causationId,
  );
}
