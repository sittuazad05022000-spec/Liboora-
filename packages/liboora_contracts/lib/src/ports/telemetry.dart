/// Liboora Shared Kernel (R0) — Telemetry port.
library;

enum LogLevel { debug, info, warn, error }

/// Structured, PII-safe logging and metrics.
///
/// Owned by the Observability Platform (R3). The domain depends on this
/// interface, never on a logging package — that is law L3.
abstract interface class Telemetry {
  void log(LogLevel level, String message, {Map<String, Object?> fields});

  void counter(String name, {int value, Map<String, String> tags});

  /// Times [action] and records the duration under [name].
  Future<T> span<T>(String name, Future<T> Function() action);
}
