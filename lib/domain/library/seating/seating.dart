/// **BC-04 Seating** — public barrel.
library;

export 'domain/seat_allocation.dart';

import 'package:liboora_contracts/liboora_contracts.dart';

import '../../../platform/business/business.dart';
import '../../../platform/data/data.dart';
import '../../../platform/event/event.dart';
import '../../../platform/identity/identity.dart';
import '../membership/membership.dart';
import 'domain/seat_allocation.dart';

abstract interface class SeatLayoutRepository {
  SeatLayout? forBranch(BranchId id);
  void save(SeatLayout layout);
}

final class InMemorySeatLayoutRepository implements SeatLayoutRepository {
  InMemorySeatLayoutRepository(this._store);
  final TenantPartitionedStore<SeatLayout> _store;

  @override
  SeatLayout? forBranch(BranchId id) => _store.get(id.value);

  @override
  void save(SeatLayout layout) => _store.put(layout.branchId.value, layout);
}

abstract interface class SeatAllocationRepository {
  /// Everything ever recorded for this seat — the aggregate needs the full
  /// set to evaluate its overlap invariant.
  List<SeatAllocation> forSeat(String seatId);
  List<SeatAllocation> forStudent(StudentRecordId id);
  List<SeatAllocation> activeOn(DateTime day);
  List<SeatAllocation> all();
  SeatAllocation? byId(String id);
  void save(SeatAllocation a);
}

final class InMemorySeatAllocationRepository
    implements SeatAllocationRepository {
  InMemorySeatAllocationRepository(this._store);
  final TenantPartitionedStore<SeatAllocation> _store;

  @override
  List<SeatAllocation> forSeat(String seatId) =>
      _store.where((a) => a.seatId == seatId);

  @override
  List<SeatAllocation> forStudent(StudentRecordId id) =>
      _store.where((a) => a.studentRecordId == id);

  @override
  List<SeatAllocation> activeOn(DateTime day) =>
      _store.where((a) => a.isActiveOn(day));

  @override
  List<SeatAllocation> all() => _store.all();

  @override
  SeatAllocation? byId(String id) => _store.get(id);

  @override
  void save(SeatAllocation a) => _store.put(a.id, a);
}

/// Read model for the seat-map screen. Built on demand from the two
/// repositories — never a second source of truth.
final class SeatOccupancy {
  const SeatOccupancy({
    required this.seat,
    required this.allocation,
    required this.studentName,
  });

  final Seat seat;
  final SeatAllocation? allocation;
  final String? studentName;

  bool get isOccupied => allocation != null;
}

/// Use case: assign a seat.
///
/// Contrast with `CheckInStudent`. Attendance **flags** an invalid membership;
/// Seating **blocks** it (edge E-02 vs E-03). Not an inconsistency — a
/// deliberate business rule. Letting someone study is cheap to reverse;
/// giving away a reserved chair is not.
final class AssignSeat {
  AssignSeat({
    required this.allocations,
    required this.layouts,
    required this.validity,
    required this.entitlements,
    required this.events,
    required this.clock,
    required this.ids,
    required this.tenant,
    required this.pdp,
  });

  final SeatAllocationRepository allocations;
  final SeatLayoutRepository layouts;
  final MembershipValidityReader validity;
  final EntitlementService entitlements;
  final EventBus events;
  final Clock clock;
  final IdGenerator ids;
  final TenantContext tenant;
  final PolicyDecisionPoint pdp;

  Future<SeatAllocation> call({
    required AccessRole actorRole,
    required StudentRecordId studentId,
    required String seatId,
    DateRange? window,
  }) async {
    pdp.require(actorRole, Permission.assignSeat);

    final today = clock.today();
    final v = validity.forStudent(studentId, today);

    // BLOCK. A seat is a scarce reserved resource; no membership, no seat.
    if (!v.isValid) {
      throw DomainError(
        DomainErrorCode.membershipRequiredForSeat,
        'An active membership is required before a seat can be reserved.',
        context: {'studentRecordId': studentId.value},
      );
    }

    // Seat quota: the plan may include zero seats (a "floating" plan).
    if (v.seatQuota <= 0) {
      throw DomainError(
        DomainErrorCode.seatQuotaExceeded,
        'The ${v.planName} plan does not include a reserved seat.',
        context: {'plan': v.planName},
      );
    }
    final held = allocations
        .forStudent(studentId)
        .where((a) => a.isActive)
        .length;
    if (held >= v.seatQuota) {
      throw DomainError(
        DomainErrorCode.seatQuotaExceeded,
        'This student already holds $held of ${v.seatQuota} allowed seats.',
        context: {'held': held, 'quota': v.seatQuota},
      );
    }

    final layout = layouts.forBranch(tenant.branchId);
    if (layout == null) {
      throw DomainError(
        DomainErrorCode.notFound,
        'No seat layout configured for this branch.',
        context: {'branchId': tenant.branchId.value},
      );
    }
    final seat = layout.require(seatId);

    // The allocation window defaults to the membership term — a seat should
    // never outlive the membership that justified it.
    final rawEnd = v.validUntil ?? today.add(const Duration(days: 30));
    final term =
        window ??
        DateRange(
          start: today,
          // A membership ending today would produce a zero-length window, which
          // DateRange rightly rejects. Give it one day so the seat is usable
          // for the remainder of the paid term.
          end: rawEnd.isAfter(today)
              ? rawEnd
              : today.add(const Duration(days: 1)),
        );

    // Strong consistency, in-transaction. This is the check that must never
    // move to a projection.
    SeatAllocation.assertSeatFree(allocations.forSeat(seatId), term);

    final allocation = SeatAllocation(
      id: ids.next('seat'),
      seatId: seat.id,
      seatLabel: seat.label,
      studentRecordId: studentId,
      window: term,
      allocatedOn: today,
    );
    allocations.save(allocation);
    entitlements.recordUsage(Feature.seats, 1);

    events.enqueue([
      DomainEvent(
        eventId: ids.next('evt'),
        eventType: 'seating.SeatAssigned',
        tenantId: tenant.tenantId,
        aggregateId: allocation.id,
        occurredAt: clock.now(),
        actorId: tenant.actorId,
        correlationId: tenant.correlationId,
        payload: {
          'allocationId': allocation.id,
          'seatId': seat.id,
          'seatLabel': seat.label,
          'studentRecordId': studentId.value,
          'validUntil': term.end.toIso8601String(),
        },
      ),
    ]);
    await events.drain();
    return allocation;
  }
}

final class ReleaseSeat {
  ReleaseSeat({
    required this.allocations,
    required this.entitlements,
    required this.events,
    required this.clock,
    required this.ids,
    required this.tenant,
    required this.pdp,
  });

  final SeatAllocationRepository allocations;
  final EntitlementService entitlements;
  final EventBus events;
  final Clock clock;
  final IdGenerator ids;
  final TenantContext tenant;
  final PolicyDecisionPoint pdp;

  Future<SeatAllocation> call({
    required AccessRole actorRole,
    required String allocationId,
    String reason = 'Released by staff',
  }) async {
    pdp.require(actorRole, Permission.assignSeat);

    final a = allocations.byId(allocationId);
    if (a == null) {
      throw const DomainError(
        DomainErrorCode.notFound,
        'Allocation not found.',
      );
    }

    a.release(on: clock.now(), reason: reason);
    allocations.save(a);
    entitlements.recordUsage(Feature.seats, -1);

    events.enqueue([
      DomainEvent(
        eventId: ids.next('evt'),
        eventType: 'seating.SeatReleased',
        tenantId: tenant.tenantId,
        aggregateId: a.id,
        occurredAt: clock.now(),
        actorId: tenant.actorId,
        correlationId: tenant.correlationId,
        payload: {
          'allocationId': a.id,
          'seatId': a.seatId,
          'seatLabel': a.seatLabel,
          'reason': reason,
        },
      ),
    ]);
    await events.drain();
    return a;
  }
}

/// Query service for the seat map. A read concern, kept out of the use cases.
final class SeatMapService {
  SeatMapService({
    required this.layouts,
    required this.allocations,
    required this.clock,
    required this.tenant,
  });

  final SeatLayoutRepository layouts;
  final SeatAllocationRepository allocations;
  final Clock clock;
  final TenantContext tenant;

  List<SeatOccupancy> currentMap(String Function(StudentRecordId) nameOf) {
    final layout = layouts.forBranch(tenant.branchId);
    if (layout == null) return const [];
    final today = clock.today();
    final active = allocations.activeOn(today);

    return [
      for (final seat in layout.seats)
        () {
          SeatAllocation? found;
          for (final a in active) {
            if (a.seatId == seat.id) {
              found = a;
              break;
            }
          }
          return SeatOccupancy(
            seat: seat,
            allocation: found,
            studentName: found == null ? null : nameOf(found.studentRecordId),
          );
        }(),
    ];
  }

  ({int total, int occupied, int free}) summary() {
    final map = currentMap((_) => '');
    final occupied = map.where((o) => o.isOccupied).length;
    return (total: map.length, occupied: occupied, free: map.length - occupied);
  }
}
