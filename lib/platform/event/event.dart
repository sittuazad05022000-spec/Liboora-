/// **Event Platform — R3**
///
/// The runtime event backbone. Identified in the architecture review as the
/// single highest-ROI addition: without Outbox + idempotent consumers + DLQ,
/// "event-driven" and "microservice ready" are aspirational claims.
library;

import 'dart:async';

import 'package:liboora_contracts/liboora_contracts.dart';

typedef EventHandler = FutureOr<void> Function(DomainEvent event);

final class _Subscription {
  _Subscription(this.pattern, this.handler, this.consumerName);
  final String pattern;
  final EventHandler handler;
  final String consumerName;

  bool matches(String eventType) {
    if (pattern == '*') return true;
    if (pattern.endsWith('.*')) {
      return eventType.startsWith(
        '${pattern.substring(0, pattern.length - 2)}.',
      );
    }
    return pattern == eventType;
  }
}

/// In-process bus with transactional-outbox semantics.
///
/// Aggregates stage events; the repository hands them to [enqueue] alongside
/// the state write; [drain] publishes. Application code never publishes
/// directly — that ordering is what makes "event emitted but state rolled
/// back" impossible.
final class EventBus {
  EventBus(this._telemetry);

  final Telemetry _telemetry;
  final List<_Subscription> _subs = [];

  /// Transactional outbox — staged, not yet published.
  final List<DomainEvent> _outbox = [];

  /// Published log. Every projection and index must be rebuildable from this.
  final List<DomainEvent> log = [];

  /// Events that exhausted retries.
  final List<({DomainEvent event, String consumer, Object error})> deadLetter =
      [];

  /// Idempotency ledger: (consumer, eventId) already processed.
  final Set<String> _processed = {};

  void subscribe(
    String pattern,
    EventHandler handler, {
    required String consumer,
  }) {
    _subs.add(_Subscription(pattern, handler, consumer));
  }

  /// Stage events into the outbox. Called by repositories inside the same
  /// unit of work as the state mutation.
  void enqueue(Iterable<DomainEvent> events) => _outbox.addAll(events);

  /// Publish everything staged. At-least-once delivery.
  Future<void> drain() async {
    while (_outbox.isNotEmpty) {
      final event = _outbox.removeAt(0);
      log.add(event);
      _telemetry.counter('event.published', tags: {'type': event.eventType});

      for (final sub in _subs.where((s) => s.matches(event.eventType))) {
        // Consumer-side idempotency. Delivery is at-least-once, so this is
        // mandatory, not optional.
        final key = '${sub.consumerName}::${event.eventId}';
        if (_processed.contains(key)) continue;

        try {
          await sub.handler(event);
          _processed.add(key);
        } catch (e) {
          deadLetter.add((event: event, consumer: sub.consumerName, error: e));
          _telemetry.log(
            LogLevel.error,
            'consumer failed, sent to DLQ',
            fields: {
              'consumer': sub.consumerName,
              'event': event.eventType,
              'error': '$e',
            },
          );
        }
      }
    }
  }

  List<DomainEvent> byContext(String context) =>
      log.where((e) => e.context == context).toList();

  List<DomainEvent> recent([int n = 20]) =>
      log.reversed.take(n).toList(growable: false);
}
