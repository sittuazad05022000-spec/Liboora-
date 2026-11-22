/// Liboora Shared Kernel (R0) — event stream port.
///
/// ADR-0012 wave 1 (edge `platform/analytics -> platform/event`, waiver
/// lapsed 2026-10-31): Analytics needs subscribe-and-replay only, so the seam
/// is declared here at rank 0 and `EventBus` implements it. Consumers name
/// this port and never the bus; a future broker behind the same interface
/// changes nothing above it.
library;

import 'dart:async';

import '../events/domain_event.dart';

/// Handler for a delivered [DomainEvent].
///
/// Structurally the same type `platform/event` declares; both expand to the
/// same function type over the one R0 [DomainEvent].
typedef EventHandler = FutureOr<void> Function(DomainEvent event);

/// Read side of the event log: live subscription plus replay from zero.
abstract interface class EventStream {
  /// Subscribe [handler] to event types matching [pattern].
  ///
  /// [pattern] is `*`, a `context.*` prefix, or a full event type;
  /// [consumer] keys at-least-once idempotency.
  void subscribe(
    String pattern,
    EventHandler handler, {
    required String consumer,
  });

  /// Every published event, in log order, exactly once per listen.
  Stream<DomainEvent> replay();
}
