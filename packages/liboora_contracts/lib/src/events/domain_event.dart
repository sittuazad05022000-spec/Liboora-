/// Liboora Shared Kernel (R0) — Domain event envelope.
library;

import '../value_objects/identifiers.dart';

/// The envelope every domain event carries.
///
/// Field set is fixed by LIBOORA_BOUNDED_CONTEXT_MAP.md §9.1. Every field here
/// exists because its absence causes a specific, known production failure:
///
/// * [eventId]      — consumer idempotency. Delivery is at-least-once.
/// * [tenantId]     — a consumer that processes without tenant context must
///                    fail loudly, never default. See forbidden edge X-13.
/// * [aggregateId]  — the partition key. Ordering is guaranteed per aggregate
///                    and *only* per aggregate.
/// * [correlationId]— ties every effect back to the originating user action.
/// * [causationId]  — the event that caused this one; builds the causal chain.
/// * [schemaVersion]— additive-only evolution; breaking change bumps this.
final class DomainEvent {
  DomainEvent({
    required this.eventId,
    required this.eventType,
    required this.tenantId,
    required this.aggregateId,
    required this.occurredAt,
    required this.payload,
    this.schemaVersion = 1,
    this.actorId,
    this.correlationId,
    this.causationId,
  });

  final String eventId;

  /// `<context>.<Aggregate><PastTenseVerb>` — e.g. `membership.MembershipRenewed`.
  ///
  /// An imperative name (`SendReminder`) is a *command*, not an event, and
  /// must not enter the bus.
  final String eventType;

  final TenantId tenantId;
  final String aggregateId;
  final DateTime occurredAt;
  final Map<String, Object?> payload;
  final int schemaVersion;
  final String? actorId;
  final String? correlationId;
  final String? causationId;

  /// The bounded context that produced this event.
  String get context => eventType.split('.').first;

  T? read<T>(String key) => payload[key] as T?;

  @override
  String toString() =>
      '$eventType[$aggregateId]@${occurredAt.toIso8601String()}';
}

/// Anything that produces domain events.
///
/// Aggregates collect events during a use case; the repository drains them
/// into the transactional outbox in the *same* transaction as the state
/// write. Application code never publishes directly — that is the difference
/// between an outbox and a race condition.
mixin EmitsEvents {
  final List<DomainEvent> _pending = [];

  List<DomainEvent> get pendingEvents => List.unmodifiable(_pending);

  void raise(DomainEvent event) => _pending.add(event);

  List<DomainEvent> drainEvents() {
    final drained = List<DomainEvent>.unmodifiable(_pending);
    _pending.clear();
    return drained;
  }
}
