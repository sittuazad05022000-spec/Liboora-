/// Liboora Shared Kernel (R0) — Clock port.
library;

/// Time as a dependency.
///
/// Forbidden edge X-09: `DateTime.now()` is banned inside `domain/**`.
/// Attendance has clock-skew rules, memberships expire, and policies are
/// effective-dated — none of that is testable against a real wall clock.
abstract interface class Clock {
  DateTime now();
  DateTime today();
}

/// Production adapter.
final class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now();

  @override
  DateTime today() {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }
}

/// Test adapter — lets a test move time deliberately.
final class FixedClock implements Clock {
  FixedClock(this._now);

  DateTime _now;

  void advance(Duration d) => _now = _now.add(d);
  void set(DateTime t) => _now = t;

  @override
  DateTime now() => _now;

  @override
  DateTime today() => DateTime(_now.year, _now.month, _now.day);
}
