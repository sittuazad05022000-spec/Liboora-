/// Liboora Shared Kernel (R0) — Global-band event envelope.
///
/// The Global band is the set of contexts that are **not tenant-scoped**:
/// `BC-10` Global Person Identity (rank 7.5) and the other Global-band
/// contexts. Their events key on `PersonId`, never on a tenant.
///
/// Authority for this envelope — Accepted `ADR-0078` §2.1:
///
/// * BC Map §9.1 L450 ("tenantId is mandatory on every domain event") is
///   **scoped, not universal**: it reaches only events from tenant-scoped or
///   tenant-aware contexts (the `BC-01→09` and `BC-19→31` bands).
/// * It does **not** reach the Global bands, because rule `ID-2` forbids
///   `tenantId` from ever appearing there (`PRD-003` `SID-4.52`, `SID-INT-4`;
///   `ADR-0011` — BC-10 stores no `tenantId`).
///
/// The BC Map's L449-450 wording is a disclosed Rank-4 clarity defect,
/// deliberately not repaired and routed to the Architecture Owner
/// (`ADR-0078` §4.2); this envelope is the operative, accepted shape.
///
/// Every other §9.1 envelope field stays **mandatory and unchanged**
/// (`ADR-0078` §2.4). A tenant-scoped consumer receiving a Global event
/// **MUST NOT** synthesise, infer or default a tenant context — it must fail
/// loudly. There is deliberately **no fallback tenant id** anywhere in this
/// file.
library;

import '../value_objects/identifiers.dart';

/// The envelope every Global-band domain event carries.
///
/// Same field set as the tenant-scoped envelope in `domain_event.dart`,
/// minus `tenantId` — see the library comment for why the omission is
/// required, not permitted.
final class GlobalEvent {
  GlobalEvent({
    required this.eventId,
    required this.eventType,
    required this.aggregateId,
    required this.occurredAt,
    required this.payload,
    required this.actorId,
    this.schemaVersion = 1,
    this.correlationId,
    this.causationId,
  });

  final String eventId;

  /// `<context>.<Aggregate><PastTenseVerb>` — e.g. `identity.PersonArchived`.
  ///
  /// An imperative name (`SendReminder`) is a *command*, not an event, and
  /// must not enter the bus.
  final String eventType;

  /// For Global-band events this is the global aggregate id — for identity
  /// events, the [PersonId] value. Ordering is guaranteed per aggregate and
  /// only per aggregate (BC Map §9.1).
  final String aggregateId;
  final DateTime occurredAt;

  /// `SID-4.52`: every identity-event payload carries event ID, event type,
  /// schema version, `PersonId`, occurred-at and actor — and never a mobile
  /// number, email, parent contact, address, `StudentRecordId`, `tenantId`,
  /// credential or OTP.
  final Map<String, Object?> payload;
  final int schemaVersion;

  /// `SID-4.52` requires an actor on every identity event payload; the
  /// envelope keeps it structured. The value is supplied by the emitter.
  final String actorId;
  final String? correlationId;
  final String? causationId;

  /// The bounded context that produced this event.
  String get context => eventType.split('.').first;

  T? read<T>(String key) => payload[key] as T?;

  Map<String, Object?> toJson() => {
    'eventId': eventId,
    'eventType': eventType,
    'schemaVersion': schemaVersion,
    'aggregateId': aggregateId,
    'occurredAt': occurredAt.toIso8601String(),
    'payload': payload,
    'actorId': actorId,
    if (correlationId != null) 'correlationId': correlationId,
    if (causationId != null) 'causationId': causationId,
  };

  factory GlobalEvent.fromJson(Map<String, Object?> json) => GlobalEvent(
    eventId: json['eventId']! as String,
    eventType: json['eventType']! as String,
    aggregateId: json['aggregateId']! as String,
    occurredAt: DateTime.parse(json['occurredAt']! as String),
    payload: (json['payload']! as Map).cast<String, Object?>(),
    actorId: json['actorId']! as String,
    schemaVersion: json['schemaVersion'] as int? ?? 1,
    correlationId: json['correlationId'] as String?,
    causationId: json['causationId'] as String?,
  );

  @override
  String toString() =>
      '$eventType[$aggregateId]@${occurredAt.toIso8601String()}';
}
