/// LIBORA Shared Kernel (R0) — DateRange.
library;

/// A half-open date interval `[start, end)`.
///
/// Used by BC-02 Membership (`Term`), BC-04 Seating (allocation windows) and
/// BC-06 Library Policy (effective-dated rules).
///
/// Half-open by design: it makes "no overlapping active terms" (a Membership
/// invariant) expressible without off-by-one arguments about midnight.
final class DateRange {
  DateRange({required DateTime start, required DateTime end})
      : start = _dateOnly(start),
        end = _dateOnly(end) {
    if (!this.end.isAfter(this.start)) {
      throw ArgumentError(
        'DateRange end ($end) must be strictly after start ($start).',
      );
    }
  }

  /// A range of [days] length beginning at [start].
  factory DateRange.days(DateTime start, int days) => DateRange(
        start: start,
        end: _dateOnly(start).add(Duration(days: days)),
      );

  /// A calendar-month range, correctly handling short months.
  factory DateRange.months(DateTime start, int months) {
    final s = _dateOnly(start);
    var year = s.year;
    var month = s.month + months;
    year += (month - 1) ~/ 12;
    month = ((month - 1) % 12) + 1;
    final lastDay = DateTime(year, month + 1, 0).day;
    final day = s.day > lastDay ? lastDay : s.day;
    return DateRange(start: s, end: DateTime(year, month, day));
  }

  final DateTime start;
  final DateTime end;

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  int get lengthInDays => end.difference(start).inDays;

  bool contains(DateTime moment) {
    final d = _dateOnly(moment);
    return !d.isBefore(start) && d.isBefore(end);
  }

  /// True when the two ranges share at least one day.
  ///
  /// This is the predicate behind the Membership invariant
  /// "no overlapping active terms for one StudentRecordId".
  bool overlaps(DateRange other) =>
      start.isBefore(other.end) && other.start.isBefore(end);

  DateRange extendBy(int days) =>
      DateRange(start: start, end: end.add(Duration(days: days)));

  /// Days remaining from [now], clamped at zero.
  int daysRemainingFrom(DateTime now) {
    final d = _dateOnly(now);
    if (!d.isBefore(end)) return 0;
    if (d.isBefore(start)) return lengthInDays;
    return end.difference(d).inDays;
  }

  @override
  String toString() =>
      '${start.toIso8601String().substring(0, 10)} → '
      '${end.toIso8601String().substring(0, 10)}';

  @override
  bool operator ==(Object other) =>
      other is DateRange && other.start == start && other.end == end;

  @override
  int get hashCode => Object.hash(start, end);
}
