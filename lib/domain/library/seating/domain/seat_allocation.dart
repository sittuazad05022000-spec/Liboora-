/// **BC-04 Seating** — aggregates `SeatLayout` and `SeatAllocation`.
///
/// This is the one context in V1 where eventual consistency is **not**
/// acceptable (context map §10). Two students cannot occupy one physical
/// chair, and there is no compensating action that undoes the argument at
/// 7am. The uniqueness check therefore lives inside the aggregate, enforced
/// synchronously, never in a projection.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

/// Physical seat descriptor. Value object — seats are identified by their
/// label on the wall, which is what staff and students actually say aloud.
final class Seat {
  const Seat({
    required this.id,
    required this.label,
    required this.zone,
    this.hasPowerSocket = false,
    this.isCorner = false,
  });

  final String id;

  /// What is printed on the seat: "A-14". Part of the ubiquitous language.
  final String label;

  /// "Silent Zone", "Discussion Zone", "AC Hall".
  final String zone;

  final bool hasPowerSocket;
  final bool isCorner;
}

/// The seat inventory of one branch.
///
/// Deliberately a separate aggregate from [SeatAllocation]: the layout changes
/// a few times a year, allocations change hourly. Putting them in one
/// aggregate would serialise every booking behind a furniture edit.
final class SeatLayout {
  SeatLayout({required this.branchId, required List<Seat> seats})
    : _seats = {for (final s in seats) s.id: s};

  final BranchId branchId;
  final Map<String, Seat> _seats;

  List<Seat> get seats => _seats.values.toList(growable: false);
  int get capacity => _seats.length;

  Seat? byId(String id) => _seats[id];

  Seat require(String id) {
    final s = _seats[id];
    if (s == null) {
      throw DomainError(
        DomainErrorCode.notFound,
        'Seat $id does not exist in this branch layout.',
        context: {'seatId': id, 'branchId': branchId.value},
      );
    }
    return s;
  }

  List<String> get zones =>
      {for (final s in _seats.values) s.zone}.toList()..sort();

  void addSeat(Seat seat) {
    if (_seats.containsKey(seat.id)) {
      throw DomainError(
        DomainErrorCode.conflict,
        'Seat ${seat.label} already exists.',
        context: {'seatId': seat.id},
      );
    }
    _seats[seat.id] = seat;
  }
}

enum AllocationStatus { active, released, transferred, expired }

/// Aggregate root. Invariant: **at most one non-terminal allocation per seat
/// per overlapping window**, enforced by [assertSeatFree] before construction.
final class SeatAllocation {
  SeatAllocation({
    required this.id,
    required this.seatId,
    required this.seatLabel,
    required this.studentRecordId,
    required this.window,
    required this.allocatedOn,
    this.status = AllocationStatus.active,
  });

  final String id;
  final String seatId;

  /// Denormalised for display. Copying a label is not a boundary violation —
  /// copying a *decision* would be.
  final String seatLabel;

  final StudentRecordId studentRecordId;
  final DateRange window;
  final DateTime allocatedOn;

  AllocationStatus status;
  DateTime? releasedOn;
  String? releaseReason;

  /// Transfers are capped by branch policy; count lives on the allocation so
  /// the cap is enforceable without a cross-aggregate query.
  int transfersToday = 0;

  bool get isActive => status == AllocationStatus.active;

  bool isActiveOn(DateTime day) => isActive && window.contains(day);

  int daysRemainingFrom(DateTime now) => window.daysRemainingFrom(now);

  /// **The invariant.** Called with every allocation already recorded for the
  /// seat. Passing the candidate set in — rather than letting the aggregate
  /// reach for a repository — keeps the domain layer free of infrastructure
  /// (law L3) while still enforcing the rule inside the transaction.
  static void assertSeatFree(
    Iterable<SeatAllocation> existingForSeat,
    DateRange proposed, {
    String? excludingAllocationId,
  }) {
    for (final a in existingForSeat) {
      if (a.id == excludingAllocationId) continue;
      if (!a.isActive) continue;
      if (a.window.overlaps(proposed)) {
        throw DomainError(
          DomainErrorCode.seatAlreadyOccupied,
          'Seat ${a.seatLabel} is already allocated to another student until '
          '${a.window.end.toIso8601String().substring(0, 10)}.',
          context: {
            'seatId': a.seatId,
            'conflictingAllocationId': a.id,
            'occupiedUntil': a.window.end.toIso8601String(),
          },
        );
      }
    }
  }

  void release({required DateTime on, required String reason}) {
    if (!isActive) {
      throw DomainError(
        DomainErrorCode.conflict,
        'Allocation is already ${status.name}.',
        context: {'allocationId': id, 'status': status.name},
      );
    }
    status = AllocationStatus.released;
    releasedOn = on;
    releaseReason = reason;
  }

  void markTransferred({required DateTime on}) {
    if (!isActive) {
      throw DomainError(
        DomainErrorCode.conflict,
        'Only an active allocation can be transferred.',
        context: {'allocationId': id, 'status': status.name},
      );
    }
    status = AllocationStatus.transferred;
    releasedOn = on;
    releaseReason = 'Transferred to another seat';
  }

  void expire({required DateTime on}) {
    if (!isActive) return;
    status = AllocationStatus.expired;
    releasedOn = on;
    releaseReason = 'Membership term ended';
  }
}
