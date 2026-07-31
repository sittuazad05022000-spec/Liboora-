/// Liboora Shared Kernel (R0) — Id generation port.
library;

/// Identifier generation as a dependency (forbidden edge X-09).
///
/// Deterministic ids in tests make event assertions readable instead of
/// matching on regexes.
abstract interface class IdGenerator {
  String next([String prefix]);
}

/// Production adapter — timestamp + counter. Sufficient for a single-writer
/// modular monolith; swap for UUIDv7 when the first service is extracted.
final class SequentialIdGenerator implements IdGenerator {
  int _counter = 0;

  @override
  String next([String prefix = 'id']) {
    _counter++;
    final ts = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    return '${prefix}_${ts}_${_counter.toRadixString(36)}';
  }
}
