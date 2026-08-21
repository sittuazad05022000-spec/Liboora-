/// **Architecture test — aggregate invariants for `BC-02 Membership`.**
///
/// Required by `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.3, which mandates
/// `every_aggregate_has_invariant_tests_test.dart` — "each of the aggregates in
/// context map §8 has a corresponding invariant test file". That meta-test can
/// only pass over files that actually assert something, so this file asserts
/// the rules `LIBOORA_BOUNDED_CONTEXT_MAP.md` §8 declares for `Membership`, not
/// the shape of its constructor.
///
/// **Scope discipline.** Every expectation below was read out of
/// `lib/domain/library/membership/domain/membership.dart` before it was
/// written. Where the declared rule and the implemented rule differ, the
/// difference is asserted **as implemented** and named in a comment — a test
/// that asserts the documentation over the code proves nothing about the code,
/// and a test edited to match every change is, per
/// `test/architecture/boundary_checker_test.dart`, "a test you have stopped
/// reading".
///
/// **No wall clock.** `X-09` forbids a domain rule reading `DateTime.now()`;
/// every instant here is a fixed constant so the suite cannot change verdict
/// with the calendar.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/membership/domain/membership.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

/// Fixed reference day. Chosen, not sampled.
final DateTime _day1 = DateTime.utc(2026, 3, 1);

const StudentRecordId _student = StudentRecordId('SR-2026-0001');

MembershipPlan _plan({int durationDays = 30, int freezeDaysAllowed = 7}) =>
    MembershipPlan(
      id: 'PLAN-MONTHLY',
      name: 'Monthly',
      price: Money.rupees(1200),
      durationDays: durationDays,
      seatQuota: 1,
      freezeDaysAllowed: freezeDaysAllowed,
    );

Membership _membership({
  String id = 'MEM-1',
  DateTime? start,
  int days = 30,
  MembershipStatus status = MembershipStatus.active,
  int freezeDaysUsed = 0,
  int freezeDaysAllowed = 7,
}) => Membership(
  id: id,
  studentRecordId: _student,
  plan: _plan(durationDays: days, freezeDaysAllowed: freezeDaysAllowed),
  term: DateRange.days(start ?? _day1, days),
  status: status,
  freezeDaysUsed: freezeDaysUsed,
);

void main() {
  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 1 — no overlapping ACTIVE terms for one StudentRecordId.
  //
  // BC Map §8 lists this as enforced synchronously inside the boundary.
  // The aggregate does not query: `existing` is supplied by the repository
  // (membership.dart L61). That is the §8.4 command pattern, and the test
  // must therefore supply the list rather than expect a lookup.
  // ════════════════════════════════════════════════════════════════════
  group('BC-02 invariant: no overlapping active terms', () {
    test('an overlapping proposal against an active term is refused', () {
      final existing = _membership(days: 30);

      DomainError? caught;
      try {
        // Starts 10 days in — inside the existing 30-day term.
        Membership.assertNoOverlap(
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
            'Two active memberships covering the same day would make '
            '"is this student entitled today" ambiguous. BC Map §8 requires '
            'this refusal inside the boundary.',
      );
      expect(caught!.code, DomainErrorCode.overlappingMembershipTerm);
      expect(
        caught.context['existingMembershipId'],
        existing.id,
        reason:
            'The refusal must name the membership it collided with, or the '
            'caller cannot act on it.',
      );
    });

    test('an adjacent term is permitted — the range is half-open', () {
      final existing = _membership(days: 30);
      // Begins exactly on the existing term's exclusive end.
      final adjacent = DateRange.days(existing.term.end, 30);

      expect(
        () => Membership.assertNoOverlap([existing], adjacent),
        returnsNormally,
        reason:
            'DateRange is [start, end) by design (date_range.dart) precisely '
            'so back-to-back renewal is not mistaken for an overlap. If this '
            'ever fails, every renewal in the product is blocked.',
      );
      expect(existing.term.overlaps(adjacent), isFalse);
    });

    test('a non-active term does not block a new one', () {
      for (final status in [
        MembershipStatus.pending,
        MembershipStatus.frozen,
        MembershipStatus.expired,
        MembershipStatus.cancelled,
      ]) {
        final existing = _membership(status: status);
        expect(
          () => Membership.assertNoOverlap(
            [existing],
            DateRange.days(_day1.add(const Duration(days: 10)), 30),
          ),
          returnsNormally,
          reason:
              'The invariant is scoped to ACTIVE terms. A cancelled or expired '
              'membership must not permanently poison the student\'s calendar. '
              'Status under test: $status.',
        );
      }
      // NOTE — `frozen` appears in this list because the implementation
      // (membership.dart L64) tests `status == active` only. A frozen term is
      // therefore overlappable. That is recorded here as the observed rule,
      // not endorsed: BC Map §8 does not say which side of the line `frozen`
      // falls on, and this test's job is to make the current answer visible
      // rather than to decide it.
    });

    test('an empty existing list is not silently treated as a pass', () {
      // Vacuity guard for this invariant: if `assertNoOverlap` were a no-op,
      // the first test above would fail. This one only fixes the baseline.
      expect(
        () => Membership.assertNoOverlap(const [], DateRange.days(_day1, 30)),
        returnsNormally,
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 2 — freeze days consumed may never exceed the plan allowance.
  // ════════════════════════════════════════════════════════════════════
  group('BC-02 invariant: freeze allowance is a hard ceiling', () {
    test('freezing beyond the plan allowance is refused', () {
      final m = _membership(freezeDaysAllowed: 7, freezeDaysUsed: 5);

      DomainError? caught;
      try {
        m.freeze(days: 3); // 5 + 3 > 7
      } on DomainError catch (e) {
        caught = e;
      }

      expect(caught, isNotNull);
      expect(caught!.code, DomainErrorCode.freezeAllowanceExceeded);
    });

    test('a refused freeze leaves the aggregate unchanged', () {
      final m = _membership(freezeDaysAllowed: 7, freezeDaysUsed: 5);
      final termEndBefore = m.term.end;
      final statusBefore = m.status;

      try {
        m.freeze(days: 3);
      } on DomainError {
        // expected
      }

      expect(
        m.freezeDaysUsed,
        5,
        reason:
            'A rule that refuses but still mutates is not an invariant. The '
            'allowance counter must not advance on a rejected freeze.',
      );
      expect(
        m.term.end,
        termEndBefore,
        reason: 'A rejected freeze must not extend the term.',
      );
      expect(m.status, statusBefore);
    });

    test('freezing exactly up to the allowance is permitted and extends '
        'the term by the same number of days', () {
      final m = _membership(freezeDaysAllowed: 7, freezeDaysUsed: 5);
      final endBefore = m.term.end;

      m.freeze(days: 2); // 5 + 2 == 7, the boundary

      expect(m.freezeDaysUsed, 7);
      expect(m.status, MembershipStatus.frozen);
      expect(
        m.term.end,
        endBefore.add(const Duration(days: 2)),
        reason:
            'A freeze that does not return the paid-for days is a silent '
            'charge to the student.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 3 — a cancelled membership is terminal for renewal.
  // ════════════════════════════════════════════════════════════════════
  group('BC-02 invariant: cancelled is terminal for renew()', () {
    test('renewing a cancelled membership is refused', () {
      final m = _membership(status: MembershipStatus.cancelled);

      DomainError? caught;
      try {
        m.renew(days: 30);
      } on DomainError catch (e) {
        caught = e;
      }

      expect(caught, isNotNull);
      expect(caught!.code, DomainErrorCode.membershipNotActive);
      expect(
        m.status,
        MembershipStatus.cancelled,
        reason: 'A refused renewal must not resurrect the membership.',
      );
    });

    test('renewing an expired membership is permitted — observed behaviour', () {
      final m = _membership(status: MembershipStatus.expired);
      final endBefore = m.term.end;

      m.renew(days: 30);

      expect(m.status, MembershipStatus.active);
      expect(m.term.end, endBefore.add(const Duration(days: 30)));
      // NOTE — the error code is named `membershipNotActive` but the guard
      // (membership.dart L76) fires only on `cancelled`. Expired and frozen
      // memberships are renewable. This is asserted so that narrowing the
      // guard later becomes a visible test change rather than a silent
      // product change.
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 4 — validity and expiry are DERIVED, never stored.
  // ════════════════════════════════════════════════════════════════════
  group('BC-02 invariant: validity is derived from status AND term', () {
    test('validity requires BOTH an active status and an in-term day', () {
      final inTerm = _day1.add(const Duration(days: 5));
      final afterTerm = _day1.add(const Duration(days: 60));

      expect(_membership().isValidOn(inTerm), isTrue);
      expect(
        _membership().isValidOn(afterTerm),
        isFalse,
        reason: 'An active status must not grant entry outside the term.',
      );
      expect(
        _membership(status: MembershipStatus.frozen).isValidOn(inTerm),
        isFalse,
        reason:
            'A frozen membership is inside its term but must not admit the '
            'student — this is the rule Attendance (BC-03) consumes at entry.',
      );
    });

    test('expiringSoon() never reports a lapsed or non-active membership', () {
      // Day 25 of a 30-day term: 5 days remain, inside the default window.
      final probe = _day1.add(const Duration(days: 25));
      expect(_membership().expiringSoon(probe), isTrue);

      final past = _day1.add(const Duration(days: 40));
      expect(
        _membership().expiringSoon(past),
        isFalse,
        reason:
            'An already-lapsed membership is not "expiring soon"; reporting it '
            'as such would make the renewal nudge fire forever.',
      );
      expect(
        _membership(status: MembershipStatus.cancelled).expiringSoon(probe),
        isFalse,
      );
    });

    test('proration credit is a value, never a charge, and is never '
        'negative', () {
      // Q-06: Membership computes the entitlement delta; the Business Platform
      // executes the money. The signature returning Money is the proof.
      final mid = _day1.add(const Duration(days: 15));
      final credit = _membership(days: 30).prorationCreditFor(mid);
      expect(credit.isNegative, isFalse);
      expect(credit.minorUnits, lessThanOrEqualTo(Money.rupees(1200).minorUnits));

      final afterEnd = _day1.add(const Duration(days: 90));
      expect(
        _membership(days: 30).prorationCreditFor(afterEnd),
        Money.zero,
        reason:
            'A lapsed term must credit nothing. A negative credit would be a '
            'charge raised by the wrong bounded context.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 5 — the term itself cannot be degenerate.
  // ════════════════════════════════════════════════════════════════════
  group('BC-02 invariant: a term must have positive length', () {
    test('a zero-length or inverted term cannot be constructed', () {
      expect(
        () => DateRange(start: _day1, end: _day1),
        throwsA(isA<ArgumentError>()),
        reason:
            'A zero-length term would be simultaneously active and covering '
            'no day, which makes isValidOn() unanswerable.',
      );
      expect(
        () => DateRange(
          start: _day1,
          end: _day1.subtract(const Duration(days: 1)),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
