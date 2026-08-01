/// Liboora Shared Kernel (R0) — Randomness port.
///
/// Forbidden edge X-09: `Random()` is banned as an ambient call. Unpredictable
/// values are a *dependency*, exactly like time and identity generation.
///
/// This port exists because a possession challenge derived from any function of
/// its own subject (a hash, a counter, a timestamp) is not a secret. It is the
/// mechanism named in
/// `tool/module_dependencies.yaml -> banned_symbols_in_domain_layer`.
library;

/// Source of unpredictable values.
///
/// Implementations that are *not* cryptographically secure must never be wired
/// into a credential, challenge or token path.
abstract interface class RandomSource {
  /// Uniform value in `[0, max)`. `max` must be positive.
  int nextInt(int max);
}

/// Test adapter — deterministic, explicitly insecure.
///
/// Named so that its appearance in a production wiring is obvious at a glance.
final class FixedRandomSource implements RandomSource {
  FixedRandomSource(this._values) {
    assert(_values.isNotEmpty, 'a random source needs at least one value');
  }

  final List<int> _values;
  int _cursor = 0;

  @override
  int nextInt(int max) {
    final v = _values[_cursor % _values.length];
    _cursor++;
    return v % max;
  }
}
