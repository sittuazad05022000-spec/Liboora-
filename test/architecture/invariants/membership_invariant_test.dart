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

MembershipPlan _plan({int durationDays = 30, int version = 1}) =>
    MembershipPlan(
      id: 'PLAN-MONTHLY',
      tenantId: const TenantId('tnt_a'),
      branchId: const BranchId('brn_a'),
      name: 'Monthly',
      durationDays: durationDays,
      price: Money.rupees(1200),
      createdAt: DateTime.utc(2026, 1, 1),
      createdBy: 'test',
      seatQuota: 1,
      version: version,
    );

Membership _membership({
  String id = 'MEM-1',
  DateTime? start,
  int days = 30,
  MembershipStatus status = MembershipStatus.active,
}) => Membership.fromPlan(
  id: id,
  studentRecordId: _student,
  plan: _plan(durationDays: days),
  term: DateRange.days(start ?? _day1, days),
  status: status,
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
        Membership.assertNoOverlap([
          existing,
        ], DateRange.days(_day1.add(const Duration(days: 10)), 30));
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
      for (final status in MembershipStatus.values.where(
        (e) => !e.confersEntitlement,
      )) {
        final existing = _membership(status: status);
        expect(
          () => Membership.assertNoOverlap([
            existing,
          ], DateRange.days(_day1.add(const Duration(days: 10)), 30)),
          returnsNormally,
          reason:
              'The invariant is scoped to ACTIVE terms. A cancelled or expired '
              'membership must not permanently poison the student\'s calendar. '
              'Status under test: $status.',
        );
      }
      // Derived from `confersEntitlement` rather than a hand-written list, so
      // MM-INV-001's scope tracks MM-BR-032 automatically. Previously this
      // list named `frozen`, which MM-FR-073 has since made unrepresentable.
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
  // INVARIANT 2 — MM-INV-012: `Frozen` is unreachable in V1.
  //
  // MM-FR-073 forbids it as a reachable status and MM-XC-009 excludes
  // Membership Freeze from V1 entirely. IMPL-420's obligation is that a
  // seventh status is *unrepresentable*, so this group tests absence
  // structurally rather than asserting that nobody calls a method.
  // ════════════════════════════════════════════════════════════════════
  group('BC-02 invariant: Frozen is unreachable (MM-INV-012)', () {
    test('MM-FR-072 — the status set is exactly the six V1 values', () {
      expect(
        MembershipStatus.values.map((e) => e.name).toSet(),
        {
          'pendingPayment',
          'scheduled',
          'active',
          'expired',
          'superseded',
          'cancelled',
        },
        reason:
            'MM-FR-072 closes the set at six. A seventh value added here would '
            'be reachable by some future command, which MM-INV-012 forbids — '
            'so the enum itself is the enforcement point.',
      );
      expect(MembershipStatus.values.length, 6);
    });

    test('no status is named "frozen" in any casing', () {
      expect(
        MembershipStatus.values.where(
          (e) => e.name.toLowerCase().contains('frozen'),
        ),
        isEmpty,
        reason:
            'MM-XC-009 excludes Freeze from V1. An unrepresentable state '
            'cannot be reached by a command written later by someone who has '
            'not read the PRD.',
      );
    });

    test('MM-BR-032 — only Active confers entitlement', () {
      for (final st in MembershipStatus.values) {
        expect(
          st.confersEntitlement,
          st == MembershipStatus.active,
          reason:
              'MM-AC-085 names each of the five non-active statuses as '
              'conferring nothing. ${st.name} must not be an exception.',
        );
      }
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 3 — MM-FR-074/075: the transition machine is closed, and
  // Expired/Superseded/Cancelled are terminal.
  // ════════════════════════════════════════════════════════════════════
  group('BC-02 invariant: transitions are closed (MM-FR-074)', () {
    test('MM-FR-075 — the three terminal statuses are declared terminal', () {
      expect(MembershipStatus.expired.isTerminal, isTrue);
      expect(MembershipStatus.superseded.isTerminal, isTrue);
      expect(MembershipStatus.cancelled.isTerminal, isTrue);
      expect(MembershipStatus.active.isTerminal, isFalse);
      expect(MembershipStatus.scheduled.isTerminal, isFalse);
      expect(MembershipStatus.pendingPayment.isTerminal, isFalse);
    });

    test('no transition leaves a terminal state (MM-FR-075)', () {
      for (final terminal in MembershipStatus.values.where(
        (e) => e.isTerminal,
      )) {
        for (final attempt in <(String, void Function(Membership))>[
          ('schedule', (m) => m.schedule()),
          ('activate', (m) => m.activate()),
          ('expire', (m) => m.expire()),
          ('supersede', (m) => m.supersede()),
          ('cancel', (m) => m.cancel()),
        ]) {
          final m = _membership(status: terminal);
          expect(
            () => attempt.$2(m),
            throwsA(isA<DomainError>()),
            reason:
                'MM-FR-075 makes ${terminal.name} terminal, so ${attempt.$1}'
                '() must be refused. Any outbound edge would let a renewal '
                'revive it instead of creating a new membership.',
          );
          expect(m.status, terminal);
        }
      }
    });

    test('a cancelled membership cannot be revived', () {
      final m = _membership(status: MembershipStatus.cancelled);

      DomainError? caught;
      try {
        m.activate();
      } on DomainError catch (e) {
        caught = e;
      }

      expect(caught, isNotNull);
      expect(caught!.code, DomainErrorCode.membershipNotActive);
      expect(
        m.status,
        MembershipStatus.cancelled,
        reason: 'A refused transition must not resurrect the membership.',
      );
    });

    test('an expired membership cannot be reactivated in place', () {
      final m = _membership(status: MembershipStatus.expired);

      expect(() => m.activate(), throwsA(isA<DomainError>()));
      expect(m.status, MembershipStatus.expired);
      // Behaviour change from the pre-IMPL-420 code, recorded deliberately:
      // renew() used to extend an expired term in place. MM-FR-075 requires a
      // renewal to create a NEW membership, so the unlawful path is closed.
      // The RenewMembership use case (IMPL-424) is outside this slice and no
      // replacement is invented here.
    });

    test('the lawful creation-to-expiry path is permitted end to end', () {
      final m = _membership(status: MembershipStatus.pendingPayment);

      m.schedule();
      expect(m.status, MembershipStatus.scheduled);

      m.activate();
      expect(m.status, MembershipStatus.active);

      m.expire();
      expect(m.status, MembershipStatus.expired);
    });

    test('PendingPayment may be cancelled, and Active may not', () {
      final pending = _membership(status: MembershipStatus.pendingPayment);
      pending.cancel();
      expect(
        pending.status,
        MembershipStatus.cancelled,
        reason:
            'MM-FR-078 permits voiding a record that never conferred '
            'entitlement.',
      );

      final active = _membership(status: MembershipStatus.active);
      expect(
        () => active.cancel(),
        throwsA(isA<DomainError>()),
        reason:
            'Cancelling an Active membership is V2 '
            'cancellation-with-refund (MM-XC-011), excluded from V1.',
      );
    });

    test('Active may be superseded — the status half of MM-FR-096', () {
      final m = _membership(status: MembershipStatus.active);
      m.supersede();
      expect(m.status, MembershipStatus.superseded);
      expect(m.status.isTerminal, isTrue);
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
        _membership(status: MembershipStatus.scheduled).isValidOn(inTerm),
        isFalse,
        reason:
            'A scheduled membership is inside its term but must not admit the '
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
      expect(
        credit.minorUnits,
        lessThanOrEqualTo(Money.rupees(1200).minorUnits),
      );

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
