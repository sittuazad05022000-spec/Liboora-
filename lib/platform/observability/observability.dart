/// **Observability Platform — R3**
library;

import 'package:flutter/foundation.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

/// Development adapter. Swap for OTLP export without touching a single
/// domain file — that is the point of the port.
final class ConsoleTelemetry implements Telemetry {
  ConsoleTelemetry(this._tenantContext);

  final TenantContext _tenantContext;
  final Map<String, int> counters = {};
  final List<String> recent = [];

  @override
  void log(
    LogLevel level,
    String message, {
    Map<String, Object?> fields = const {},
  }) {
    // Tenant + correlation on every line. Without these, a multi-tenant
    // incident is unresolvable.
    final tenant = _tenantContext.hasTenant
        ? _tenantContext.tenantId.value
        : '-';
    final line =
        '[${level.name.toUpperCase()}] [$tenant] $message'
        '${fields.isEmpty ? '' : ' $fields'}';
    recent.add(line);
    if (recent.length > 200) recent.removeAt(0);
    if (kDebugMode) debugPrint(line);
  }

  @override
  void counter(
    String name, {
    int value = 1,
    Map<String, String> tags = const {},
  }) {
    counters[name] = (counters[name] ?? 0) + value;
  }

  @override
  Future<T> span<T>(String name, Future<T> Function() action) async {
    final sw = Stopwatch()..start();
    try {
      return await action();
    } finally {
      sw.stop();
      log(LogLevel.debug, 'span:$name', fields: {'ms': sw.elapsedMilliseconds});
    }
  }
}
