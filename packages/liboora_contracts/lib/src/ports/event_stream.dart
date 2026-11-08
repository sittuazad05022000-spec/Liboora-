/// Liboora Shared Kernel (R0) — Event stream port.
///
/// The single capability that analytics and any other event-consuming
/// platform needs from the event backbone: subscribe to a pattern, and
/// read the full log for replay. No replay() method — the log getter IS
/// the replay mechanism.
library;

import 'dart:async';

import '../events/domain_event.dart';

typedef EventHandler = FutureOr<void> Function(DomainEvent event);

abstract interface class EventStream {
  void subscribe(
    String pattern,
    EventHandler handler, {
    required String consumer,
  });

  List<DomainEvent> get log;
}
