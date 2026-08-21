/// **Architecture test — aggregate invariants for `BC-06 Library Policy`.**
///
/// Required by `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.3
/// (`every_aggregate_has_invariant_tests_test.dart`).
///
/// `branch_policy.dart` names this aggregate the rule **source**, with
/// Attendance, Seating and Fee as rule **consumers** in a Conformist
/// relationship — they accept this model as-is, with no translation. Two
/// consequences are tested here:
///
/// 1. **Effective dating is structural, not advisory.** The file states that
///    policies "are effective-dated and never retroactive: historical
///    attendance must remain judgeable under the rules that were live at the
///    time it was recorded." A policy object therefore carries
///    `effectiveFrom`, and every judgement made with it is a judgement under
///    one specific version.
/// 2. **Every consumer-facing predicate is a pure function of the policy plus
///    the instant supplied.** Nothing reads the wall clock (`X-09`), so the
///    same policy and the same instant must always produce the same verdict.
///
/// **A note on what is NOT asserted.** `BranchPolicy` has no `_assertInvariants`
/// constructor guard, so a nonsensical `WorkingHours` (closes before it opens)
/// is currently constructible. That is recorded below as an observed gap rather
/// than asserted as a rule — writing `expect(throws...)` for a guard that does
/// not exist would be a test asserting the documentation over the code, and
/// inventing the guard here would be this test file deciding a product rule it
/// has no standing to decide.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/policy/domain/branch_policy.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const BranchId _branch = BranchId('BR-1');

/// Fixed effective date. Nothing here samples the clock.
final DateTime _effectiveFrom = DateTime.utc(2026, 1, 1);

/// 09:00 (540) to 21:00 (1260) — a plausible study-hall day.
const WorkingHours _nineToNine = WorkingHours(opensAt: 540, closesAt: 1260);

DateTime _at(int hour, [int minute = 0]) =>
    DateTime.utc(2026, 6, 15, hour, minute);

BranchPolicy _policy({
  WorkingHours hours = _nineToNine,
  Set<String> holidays = const {},
  int graceMinutes = 15,
  int maxSeatTransfersPerDay = 2,
  int seatReleaseGraceHours = 24,
  DateTime? effectiveFrom,
}) => BranchPolicy(
  branchId: _branch,
  workingHours: hours,
  effectiveFrom: effectiveFrom ?? _effectiveFrom,
  holidays: holidays,
  graceMinutes: graceMinutes,
  maxSeatTransfersPerDay: maxSeatTransfersPerDay,
  seatReleaseGraceHours: seatReleaseGraceHours,
);

void main() {
  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 1 — working hours are a half-open interval [opensAt, closesAt).
  // ════════════════════════════════════════════════════════════════════
  group('BC-06 invariant: working hours are half-open', () {
    test('the opening minute is inside and the closing minute is outside', () {
      const h = _nineToNine;

      expect(
        h.contains(_at(9, 0)),
        isTrue,
        reason: 'A student arriving exactly at opening is not early.',
      );
      expect(
        h.contains(_at(20, 59)),
        isTrue,
        reason: 'The last minute before closing is still open.',
      );
      expect(
        h.contains(_at(21, 0)),
        isFalse,
        reason:
            'contains() is >= opensAt && < closesAt (L18). If closing were '
            'inclusive, "open until 9pm" and "open at 9pm" would be the same '
            'claim, and two adjacent policies could both own one minute.',
      );
    });

    test('instants outside the interval are outside on both sides', () {
      const h = _nineToNine;
      expect(h.contains(_at(8, 59)), isFalse);
      expect(h.contains(_at(21, 1)), isFalse);
      expect(h.contains(_at(0)), isFalse);
    });

    test('the verdict depends only on hour and minute, never on the date', () {
      const h = _nineToNine;
      // Same clock time, different days — including a leap-adjacent date.
      expect(h.contains(DateTime.utc(2026, 1, 1, 10)), isTrue);
      expect(h.contains(DateTime.utc(2028, 2, 29, 10)), isTrue);
      expect(
        h.contains(DateTime.utc(2026, 12, 31, 22)),
        isFalse,
        reason:
            'Calendar concerns belong to the holiday set, not to the hours. '
            'Mixing them would make one rule answer two questions.',
      );
    });

    test('display formatting is stable and 12-hour, including noon and '
        'midnight edges', () {
      // The display string is consumed by staff-facing UI; a silent format
      // change is a support call, so it is pinned.
      expect(_nineToNine.display, '9:00 AM – 9:00 PM');
      expect(
        const WorkingHours(opensAt: 0, closesAt: 720).display,
        '12:00 AM – 12:00 PM',
        reason:
            'Hour 0 and hour 12 are the two cases a naive %12 gets wrong, '
            'printing "0:00" or "0:00 PM".',
      );
      expect(
        const WorkingHours(opensAt: 545, closesAt: 1265).display,
        '9:05 AM – 9:05 PM',
        reason: 'Minutes must be zero-padded, not rendered as "9:5".',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 2 — a holiday closes the branch regardless of the hour.
  // ════════════════════════════════════════════════════════════════════
  group('BC-06 invariant: a holiday overrides working hours', () {
    test('a branch is closed on a holiday even inside working hours', () {
      final p = _policy(holidays: const {'2026-06-15'});
      final middleOfDay = _at(13);

      expect(
        p.workingHours.contains(middleOfDay),
        isTrue,
        reason: 'Establishes that the hour itself is not the reason.',
      );
      expect(p.isHoliday(middleOfDay), isTrue);
      expect(
        p.isOpenAt(middleOfDay),
        isFalse,
        reason:
            'isOpenAt is !isHoliday && contains (L60). If the holiday did not '
            'dominate, staff would have to close the branch by editing hours, '
            'which would then be wrong for every other day.',
      );
    });

    test('a non-holiday day inside hours is open', () {
      // Vacuity guard: without this, a policy that reported "closed" always
      // would satisfy the assertion above.
      final p = _policy(holidays: const {'2026-06-16'});
      expect(p.isHoliday(_at(13)), isFalse);
      expect(p.isOpenAt(_at(13)), isTrue);
    });

    test('a holiday is matched on the calendar date only, not the instant', () {
      final p = _policy(holidays: const {'2026-06-15'});
      // Two very different times on the same declared holiday.
      expect(p.isHoliday(DateTime.utc(2026, 6, 15, 0, 1)), isTrue);
      expect(p.isHoliday(DateTime.utc(2026, 6, 15, 23, 59)), isTrue);
      expect(
        p.isHoliday(DateTime.utc(2026, 6, 14, 23, 59)),
        isFalse,
        reason:
            'A holiday that bled into the previous evening would close the '
            'branch for a session students had already paid for.',
      );
    });

    test('an empty holiday set never closes the branch', () {
      final p = _policy();
      expect(p.isHoliday(_at(13)), isFalse);
      expect(p.isOpenAt(_at(13)), isTrue);
      expect(p.isOpenAt(_at(3)), isFalse, reason: 'Still bounded by hours.');
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 3 — lateness is measured against opening PLUS grace.
  //
  // This is the value Attendance (BC-03) stamps onto `AttendanceDay.lateEntry`
  // as a Conformist consumer. It must be computable from the policy alone.
  // ════════════════════════════════════════════════════════════════════
  group('BC-06 invariant: lateness is opening plus grace', () {
    test('arrival within the grace window is not late', () {
      final p = _policy(graceMinutes: 15); // opens 09:00, grace to 09:15

      expect(p.isLateEntry(_at(9, 0)), isFalse);
      expect(
        p.isLateEntry(_at(9, 15)),
        isFalse,
        reason:
            'The guard is > opensAt + grace (L65), so the final grace minute '
            'is still on time. Flagging it would make the advertised grace '
            'period one minute shorter than stated.',
      );
    });

    test('arrival one minute past the grace window is late', () {
      final p = _policy(graceMinutes: 15);
      expect(p.isLateEntry(_at(9, 16)), isTrue);
      expect(p.isLateEntry(_at(11, 0)), isTrue);
    });

    test('a zero grace period makes any minute past opening late', () {
      final p = _policy(graceMinutes: 0);
      expect(p.isLateEntry(_at(9, 0)), isFalse);
      expect(
        p.isLateEntry(_at(9, 1)),
        isTrue,
        reason:
            'Grace must be genuinely configurable to zero; a hard-coded floor '
            'would override the branch owner\'s policy.',
      );
    });

    test('an early arrival is never late', () {
      final p = _policy(graceMinutes: 15);
      expect(
        p.isLateEntry(_at(8, 30)),
        isFalse,
        reason:
            'Arriving before opening is a different condition (isOpenAt is '
            'false); it must not also be reported as late.',
      );
      expect(p.isOpenAt(_at(8, 30)), isFalse);
    });

    test('lateness is independent of the holiday set', () {
      // Observed separation of concerns: isLateEntry (L63) consults hours and
      // grace only. On a holiday the branch is closed, and "late" is simply
      // not the question being asked.
      final p = _policy(holidays: const {'2026-06-15'}, graceMinutes: 15);
      expect(p.isOpenAt(_at(11)), isFalse);
      expect(
        p.isLateEntry(_at(11)),
        isTrue,
        reason:
            'Recorded as observed behaviour, not endorsed: callers must gate '
            'on isOpenAt before interpreting isLateEntry.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 4 — effective dating: a policy is a versioned rule set.
  // ════════════════════════════════════════════════════════════════════
  group('BC-06 invariant: policies are effective-dated, never retroactive', () {
    test('a policy carries the date from which it governs', () {
      final p = _policy(effectiveFrom: DateTime.utc(2026, 4, 1));
      expect(
        p.effectiveFrom,
        DateTime.utc(2026, 4, 1),
        reason:
            'Without this field a rule change would silently re-judge every '
            'historical attendance row (L45-47).',
      );
    });

    test('two policy versions judge the same instant differently, and neither '
        'mutates the other', () {
      final oldRules = _policy(
        effectiveFrom: DateTime.utc(2026, 1, 1),
        graceMinutes: 30,
      );
      final newRules = _policy(
        effectiveFrom: DateTime.utc(2026, 6, 1),
        graceMinutes: 5,
      );
      final arrival = _at(9, 20);

      expect(
        oldRules.isLateEntry(arrival),
        isFalse,
        reason: 'Under the 30-minute grace that was live, this was on time.',
      );
      expect(
        newRules.isLateEntry(arrival),
        isTrue,
        reason: 'Under the 5-minute grace, the same arrival is late.',
      );
      expect(
        oldRules.graceMinutes,
        30,
        reason:
            'This is the whole point of effective dating: the historical '
            'verdict must remain reproducible after the rule changes. If the '
            'new policy could mutate the old one, it could not.',
      );
    });

    test('rule fields are immutable on a constructed policy', () {
      // Enforced by the compiler: every rule field is `final` (L42-55).
      // Asserted through behaviour — repeated reads are stable — because a
      // compile-time property cannot be asserted at runtime.
      final p = _policy(graceMinutes: 15);
      final first = p.isLateEntry(_at(9, 16));
      final second = p.isLateEntry(_at(9, 16));
      expect(first, second);
      expect(p.graceMinutes, 15);
      expect(p.branchId, _branch);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 5 — consumer-facing caps are carried, not invented downstream.
  // ════════════════════════════════════════════════════════════════════
  group('BC-06 invariant: caps consumed by other contexts are sourced here',
      () {
    test('the seat transfer cap is a policy value with a sane default', () {
      // BC-04 enforces the cap (SeatAllocation.transfersToday) but must not
      // OWN the number. Conformist: the consumer accepts this model as-is.
      expect(_policy().maxSeatTransfersPerDay, 2);
      expect(_policy(maxSeatTransfersPerDay: 5).maxSeatTransfersPerDay, 5);
      expect(
        _policy(maxSeatTransfersPerDay: 0).maxSeatTransfersPerDay,
        0,
        reason:
            'Zero must be expressible — a branch banning transfers outright is '
            'a legitimate policy, not an invalid one.',
      );
    });

    test('the seat release grace is a policy value and defaults to 24 hours',
        () {
      expect(
        _policy().seatReleaseGraceHours,
        24,
        reason:
            'L54 ties this to open question Q-01 and calls it configurable '
            'with a 24h default. That default is asserted so a silent change '
            'is visible; Q-01 itself remains open and is not decided here.',
      );
      expect(_policy(seatReleaseGraceHours: 48).seatReleaseGraceHours, 48);
    });

    test('OBSERVED GAP — WorkingHours has no ordering guard', () {
      // A closing minute before the opening minute is currently constructible.
      // The resulting interval is empty, so the branch reads as permanently
      // closed rather than producing a contradictory verdict.
      const inverted = WorkingHours(opensAt: 1260, closesAt: 540);

      expect(
        inverted.contains(_at(13)),
        isFalse,
        reason:
            'An inverted interval degenerates to "always closed", which is at '
            'least self-consistent.',
      );
      expect(
        inverted.contains(_at(22)),
        isFalse,
        reason:
            'Recorded, NOT endorsed. BranchPolicy has no _assertInvariants, so '
            'this input is accepted. Whether an inverted interval should be '
            'refused at construction, or supported as an overnight window, is '
            'a product decision this test file has no authority to make. It is '
            'asserted as observed so the answer is visible and the behaviour '
            'cannot change unnoticed.',
      );
    });
  });
}
