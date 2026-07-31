/// Composition-root clock adapter.
///
/// Lives in `bootstrap/` rather than the shared kernel because pinning time
/// is a *wiring* concern. Domain code depends only on the `Clock` port and
/// cannot tell the difference — which is the whole point.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

final class MutableClock implements Clock {
  DateTime? _pinned;

  /// Pin the clock to a fixed instant (used while seeding, so demo data
  /// lands at believable times of day rather than all at startup).
  void pin(DateTime at) => _pinned = at;

  void unpin() => _pinned = null;

  @override
  DateTime now() => _pinned ?? DateTime.now();

  @override
  DateTime today() {
    final n = now();
    return DateTime(n.year, n.month, n.day);
  }

  /// Today at [hour]:[minute]. Always the current calendar day, so pinning
  /// never silently shifts the date across midnight.
  DateTime todayAt(int hour, int minute) {
    final t = DateTime.now();
    return DateTime(t.year, t.month, t.day, hour, minute);
  }
}
