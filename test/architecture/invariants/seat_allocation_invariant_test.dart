/// **Architecture test — aggregate invariants for `BC-04 Seating`.**
///
/// Required by `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.3
/// (`every_aggregate_has_invariant_tests_test.dart`). BC Map §8 lists **two**
/// aggregates for `BC-04` — `SeatAllocation` and `SeatLayout` — so both are
/// covered here, in separate groups.
///
/// **Why this file is the strictest of the set.** `seat_allocation.dart` opens
/// with the statement that this is "the one context in V1 where eventual
/// consistency is **not** acceptable ... there is no compensating action that
/// undoes the argument at 7am." Every other aggregate can be repaired after the
/// fact. A double-booked chair cannot. The uniqueness rule is therefore tested
/// at its exact boundaries — adjacency, self-exclusion, terminal states — and
/// not merely in the happy overlap case.
///
/// **The rule is `assertSeatFree`, and it is a static guard called BEFORE
/// construction** (L82, L119-122). The candidate set is passed in rather than
/// fetched, which is what keeps `domain/` free of infrastructure under law
/// `L3`. A test that expected the aggregate to perform a lookup would be
/// asserting an `L3` violation.
///
/// **No wall clock** (`X-09`): every date is a fixed constant.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/seating/domain/seat_allocation.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

final DateTime _day1 = DateTime.utc(2026, 4, 1);

const StudentRecordId _studentA = StudentRecordId('SR-A');
const StudentRecordId _studentB = StudentRecordId('SR-B');
const BranchId _branch = BranchId('BR-1');

const Seat _seatA14 = Seat(id: 'S-A14', label: 'A-14', zone: 'Silent Zone');

SeatAllocation _alloc({
  String id = 'ALLOC-1',
  String seatId = 'S-A14',
  StudentRecordId? student,
  DateTime? start,
  int days = 30,
  AllocationStatus status = AllocationStatus.active,
}) => SeatAllocation(
  id: id,
  seatId: seatId,
  seatLabel: 'A-14',
  studentRecordId: student ?? _studentA,
  window: DateRange.days(start ?? _day1, days),
  allocatedOn: start ?? _day1,
  status: status,
);

void main() {
  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 1 — at most one ACTIVE allocation per seat per overlapping
  //               window. The rule the aggregate exists to enforce.
  // ════════════════════════════════════════════════════════════════════
  group('BC-04 invariant: one active allocation per seat per window', () {
    test('an overlapping window on the same seat is refused', () {
      final existing = _alloc(days: 30);

      DomainError? caught;
      try {
        SeatAllocation.assertSeatFree(
          [existing],
          DateRange.days(_day1.add(const Duration(days: 10)), 30),
        );
      } on DomainError catch (e) {
        caught = e;
      }

      expect(
        caught,
        isNotNull,
        reason:
            'Two students in one physical chair. The file comment is explicit '
            'that no compensating action exists for this, so the refusal must '
            'be synchronous and inside the aggregate.',
      );
      expect(caught!.code, DomainErrorCode.seatAlreadyOccupied);
      expect(
        caught.context['conflictingAllocationId'],
        existing.id,
        reason:
            'Staff at the desk need to know WHICH allocation blocks them, or '
            'the refusal is unactionable at 7am.',
      );
      expect(caught.context['occupiedUntil'], isNotNull);
    });

    test('an adjacent window is permitted — the range is half-open', () {
      final existing = _alloc(days: 30);
      final adjacent = DateRange.days(existing.window.end, 30);

      expect(
        () => SeatAllocation.assertSeatFree([existing], adjacent),
        returnsNormally,
        reason:
            'Refusing back-to-back allocation would strand every seat for a '
            'day between terms and halve effective capacity.',
      );
    });

    test('a single overlapping day is enough to refuse', () {
      final existing = _alloc(days: 30);
      // Starts on the last day INSIDE the existing window.
      final oneDayOverlap = DateRange.days(
        existing.window.end.subtract(const Duration(days: 1)),
        30,
      );

      expect(
        () => SeatAllocation.assertSeatFree([existing], oneDayOverlap),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.seatAlreadyOccupied,
          ),
        ),
        reason:
            'The rule is "no shared day", not "no substantial overlap". One '
            'shared day is one argument at the desk.',
      );
    });

    test('a terminal allocation never blocks the seat', () {
      for (final status in [
        AllocationStatus.released,
        AllocationStatus.transferred,
        AllocationStatus.expired,
      ]) {
        expect(
          () => SeatAllocation.assertSeatFree(
            [_alloc(status: status)],
            DateRange.days(_day1.add(const Duration(days: 10)), 30),
          ),
          returnsNormally,
          reason:
              'A released seat that stays blocked is lost revenue and a seat '
              'nobody can sit in. Status under test: $status.',
        );
      }
    });

    test('excludingAllocationId lets an allocation be re-checked against '
        'itself without self-conflict', () {
      final existing = _alloc(id: 'ALLOC-1', days: 30);

      // Extending its own window must not collide with itself.
      expect(
        () => SeatAllocation.assertSeatFree(
          [existing],
          DateRange.days(_day1, 60),
          excludingAllocationId: 'ALLOC-1',
        ),
        returnsNormally,
        reason:
            'Without self-exclusion, no allocation could ever be extended or '
            'corrected — the record being edited would block its own edit.',
      );

      // But a DIFFERENT allocation is still checked.
      expect(
        () => SeatAllocation.assertSeatFree(
          [existing, _alloc(id: 'ALLOC-2', student: _studentB)],
          DateRange.days(_day1, 60),
          excludingAllocationId: 'ALLOC-1',
        ),
        throwsA(isA<DomainError>()),
        reason:
            'Self-exclusion must exclude exactly one id, not disable the '
            'check. This is the mutation that would make the guard vacuous.',
      );
    });

    test('the guard is not a blanket refusal', () {
      // Vacuity guard: an implementation that threw unconditionally would
      // pass the refusal tests above. This fixes the negative baseline.
      expect(
        () => SeatAllocation.assertSeatFree(const [], DateRange.days(_day1, 30)),
        returnsNormally,
      );
    });

    test('the guard is evaluated per seat by the caller, not inferred', () {
      // Observed contract: assertSeatFree does NOT filter on seatId — it
      // trusts `existingForSeat` to already be that seat's set (parameter name,
      // L124). Documented here because a caller passing a whole branch's
      // allocations would produce false conflicts across different seats.
      final otherSeat = _alloc(id: 'ALLOC-9', seatId: 'S-B02');
      expect(
        () => SeatAllocation.assertSeatFree(
          [otherSeat],
          DateRange.days(_day1.add(const Duration(days: 5)), 10),
        ),
        throwsA(isA<DomainError>()),
        reason:
            'This asserts the CURRENT contract: filtering is the caller\'s '
            'duty. If the aggregate ever starts filtering by seatId itself, '
            'this test must be revisited deliberately rather than silently.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 2 — lifecycle transitions are one-way out of `active`.
  // ════════════════════════════════════════════════════════════════════
  group('BC-04 invariant: terminal states are terminal', () {
    test('release records who/when/why and flips the seat free', () {
      final a = _alloc();
      final on = _day1.add(const Duration(days: 5));

      a.release(on: on, reason: 'student left the city');

      expect(a.status, AllocationStatus.released);
      expect(a.releasedOn, on);
      expect(
        a.releaseReason,
        'student left the city',
        reason:
            'A release without a reason cannot be defended when the student '
            'disputes it later.',
      );
      expect(a.isActive, isFalse);
      expect(a.isActiveOn(on), isFalse);
    });

    test('releasing twice is refused, and the first release survives', () {
      final a = _alloc();
      a.release(on: _day1, reason: 'first');

      DomainError? caught;
      try {
        a.release(on: _day1.add(const Duration(days: 1)), reason: 'second');
      } on DomainError catch (e) {
        caught = e;
      }

      expect(caught, isNotNull);
      expect(caught!.code, DomainErrorCode.conflict);
      expect(
        a.releaseReason,
        'first',
        reason:
            'A refused transition that still overwrites the reason destroys '
            'the original justification.',
      );
      expect(a.releasedOn, _day1);
    });

    test('a released allocation cannot be transferred', () {
      final a = _alloc();
      a.release(on: _day1, reason: 'left');

      expect(
        () => a.markTransferred(on: _day1),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.conflict,
          ),
        ),
        reason:
            'Transferring a seat the student no longer holds would allocate a '
            'seat on the strength of a right that has already ended.',
      );
      expect(a.status, AllocationStatus.released);
    });

    test('expire() on a non-active allocation is idempotent and silent', () {
      final a = _alloc();
      a.release(on: _day1, reason: 'left');

      expect(
        () => a.expire(on: _day1.add(const Duration(days: 40))),
        returnsNormally,
        reason:
            'expire() is driven by a term-end sweep that may run repeatedly '
            '(L173 returns early). Throwing would make the sweep fail on '
            'already-closed rows.',
      );
      expect(
        a.status,
        AllocationStatus.released,
        reason: 'The sweep must not overwrite a more specific terminal state.',
      );
      expect(a.releaseReason, 'left');
    });

    test('expire() on an active allocation closes it with the term reason', () {
      final a = _alloc();
      final on = _day1.add(const Duration(days: 30));

      a.expire(on: on);

      expect(a.status, AllocationStatus.expired);
      expect(a.releasedOn, on);
      expect(a.releaseReason, 'Membership term ended');
    });

    test('isActiveOn requires BOTH active status and an in-window day', () {
      final a = _alloc(days: 30);
      expect(a.isActiveOn(_day1.add(const Duration(days: 5))), isTrue);
      expect(
        a.isActiveOn(_day1.add(const Duration(days: 60))),
        isFalse,
        reason:
            'A stale active status must not grant a seat past the window; the '
            'window is the authority, and occupancy projections read this.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 3 — SeatLayout: seat identity is unique within a branch,
  //               and an unknown seat is a refusal, not a null.
  // ════════════════════════════════════════════════════════════════════
  group('BC-04 invariant: SeatLayout identity', () {
    test('adding a duplicate seat id is refused', () {
      final layout = SeatLayout(branchId: _branch, seats: const [_seatA14]);

      DomainError? caught;
      try {
        layout.addSeat(
          const Seat(id: 'S-A14', label: 'A-14 (dup)', zone: 'AC Hall'),
        );
      } on DomainError catch (e) {
        caught = e;
      }

      expect(caught, isNotNull);
      expect(caught!.code, DomainErrorCode.conflict);
      expect(
        layout.capacity,
        1,
        reason:
            'A duplicated seat id would make assertSeatFree ambiguous about '
            'which physical chair it is protecting.',
      );
      expect(layout.byId('S-A14')!.label, 'A-14');
    });

    test('require() refuses an unknown seat instead of returning null', () {
      final layout = SeatLayout(branchId: _branch, seats: const [_seatA14]);

      expect(layout.byId('S-NOPE'), isNull);
      expect(
        () => layout.require('S-NOPE'),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.notFound,
          ),
        ),
        reason:
            'Allocating against a seat that does not exist would create an '
            'allocation no one can physically honour.',
      );
    });

    test('a new distinct seat is accepted and capacity grows', () {
      // Vacuity guard for addSeat.
      final layout = SeatLayout(branchId: _branch, seats: const [_seatA14]);
      layout.addSeat(
        const Seat(id: 'S-B02', label: 'B-02', zone: 'Discussion Zone'),
      );
      expect(layout.capacity, 2);
      expect(layout.zones, ['Discussion Zone', 'Silent Zone']);
    });

    test('layout construction deduplicates by id, keeping the last', () {
      // Observed behaviour of the map comprehension at L42. Recorded so that
      // a silent seat loss during layout import is a known property rather
      // than a surprise.
      final layout = SeatLayout(
        branchId: _branch,
        seats: const [
          Seat(id: 'S-A14', label: 'first', zone: 'Z'),
          Seat(id: 'S-A14', label: 'second', zone: 'Z'),
        ],
      );
      expect(layout.capacity, 1);
      expect(layout.byId('S-A14')!.label, 'second');
    });
  });
}
