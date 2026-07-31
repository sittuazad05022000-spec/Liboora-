/// **BC-03 Attendance** — aggregate `AttendanceDay`.
///
/// The aggregate is one **student-day**, not one punch. Every invariant that
/// matters ("check-out after check-in", "one open session", "idempotent
/// punch") is day-scoped. Making the punch the aggregate would push those
/// into a service layer where they cannot be enforced transactionally.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

enum VerificationMethod { qr, gps, wifi, manual }

final class Punch {
  const Punch({
    required this.at,
    required this.method,
    required this.idempotencyKey,
    this.capturedOffline = false,
  });

  final DateTime at;
  final VerificationMethod method;
  final IdempotencyKey idempotencyKey;
  final bool capturedOffline;
}

final class AttendanceDay {
  AttendanceDay({
    required this.studentRecordId,
    required this.date,
    this.membershipValidAtEntry = true,
    this.lateEntry = false,
  });

  final StudentRecordId studentRecordId;
  final DateTime date;

  final List<Punch> entries = [];
  final List<Punch> exits = [];

  /// Attendance RECORDS and FLAGS rather than blocking (edge E-03). Never
  /// lock a paying student out at the door over a stale projection.
  bool membershipValidAtEntry;
  bool lateEntry;

  final List<String> corrections = [];

  bool get isOpen => entries.length > exits.length;

  Duration get timeInside {
    var total = Duration.zero;
    for (var i = 0; i < exits.length && i < entries.length; i++) {
      total += exits[i].at.difference(entries[i].at);
    }
    return total;
  }

  DateTime? get firstEntry => entries.isEmpty ? null : entries.first.at;
  DateTime? get lastExit => exits.isEmpty ? null : exits.last.at;

  bool _alreadyProcessed(IdempotencyKey key) =>
      entries.any((p) => p.idempotencyKey == key) ||
      exits.any((p) => p.idempotencyKey == key);

  /// Idempotent by (studentRecordId, date, idempotencyKey).
  ///
  /// A student double-tapping the QR scanner, or an offline punch replayed on
  /// reconnect, must not create two entries. Returns false when the punch was
  /// a duplicate — the caller treats that as success, not an error.
  bool checkIn(Punch punch) {
    if (_alreadyProcessed(punch.idempotencyKey)) return false;
    if (isOpen) {
      throw const DomainError(
        DomainErrorCode.alreadyCheckedIn,
        'This student is already checked in. Check out first.',
      );
    }
    entries.add(punch);
    return true;
  }

  bool checkOut(Punch punch) {
    if (_alreadyProcessed(punch.idempotencyKey)) return false;
    if (!isOpen) {
      throw const DomainError(
        DomainErrorCode.notCheckedIn,
        'This student is not currently checked in.',
      );
    }
    if (punch.at.isBefore(entries.last.at)) {
      throw const DomainError(
        DomainErrorCode.checkOutBeforeCheckIn,
        'Check-out time cannot precede check-in time.',
      );
    }
    exits.add(punch);
    return true;
  }

  /// Corrections are append-only with actor and reason (never an edit).
  void recordCorrection(String actor, String reason) =>
      corrections.add('$actor: $reason');
}
