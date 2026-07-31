/// **BC-06 Library Policy** — aggregate `BranchPolicy`.
///
/// The rule *source*. Attendance, Seating and Fee are rule *consumers*
/// (Conformist — they accept this model as-is, no translation).
library;

import 'package:liboora_contracts/liboora_contracts.dart';

final class WorkingHours {
  const WorkingHours({required this.opensAt, required this.closesAt});

  /// Minutes from midnight.
  final int opensAt;
  final int closesAt;

  bool contains(DateTime t) {
    final m = t.hour * 60 + t.minute;
    return m >= opensAt && m < closesAt;
  }

  String get display => '${_fmt(opensAt)} – ${_fmt(closesAt)}';

  static String _fmt(int m) {
    final h = m ~/ 60, mm = m % 60;
    final period = h >= 12 ? 'PM' : 'AM';
    final h12 = h % 12 == 0 ? 12 : h % 12;
    return '$h12:${mm.toString().padLeft(2, '0')} $period';
  }
}

final class BranchPolicy {
  BranchPolicy({
    required this.branchId,
    required this.workingHours,
    required this.effectiveFrom,
    this.holidays = const {},
    this.graceMinutes = 15,
    this.maxSeatTransfersPerDay = 2,
    this.seatReleaseGraceHours = 24,
  });

  final BranchId branchId;
  final WorkingHours workingHours;

  /// Policies are effective-dated and never retroactive: historical
  /// attendance must remain judgeable under the rules that were live at the
  /// time it was recorded.
  final DateTime effectiveFrom;

  final Set<String> holidays; // ISO yyyy-MM-dd
  final int graceMinutes;
  final int maxSeatTransfersPerDay;

  /// Open question Q-01 — configurable, defaults to a 24h grace period.
  final int seatReleaseGraceHours;

  bool isHoliday(DateTime d) =>
      holidays.contains(d.toIso8601String().substring(0, 10));

  bool isOpenAt(DateTime t) => !isHoliday(t) && workingHours.contains(t);

  /// Late relative to opening, allowing for grace.
  bool isLateEntry(DateTime t) {
    final m = t.hour * 60 + t.minute;
    return m > workingHours.opensAt + graceMinutes;
  }
}
