/// **Architecture test — aggregate invariants for `BC-05 Fee & Collection`.**
///
/// Required by `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.3
/// (`every_aggregate_has_invariant_tests_test.dart`).
///
/// `fee_ledger.dart` states the aggregate boundary reason directly: the ledger
/// is **per student, not per invoice**, because `balance` is an invariant across
/// all dues and receipts, and a per-invoice aggregate would make "total
/// outstanding" eventually consistent — at which point `cannotArchiveWithOpenDues`
/// (the `BC-01` rule tested in `student_record_invariant_test.dart`) becomes
/// unenforceable. That coupling is why the balance assertions below are not
/// merely arithmetic checks: they are the foundation another aggregate's
/// invariant stands on.
///
/// **Four declared properties are asserted here:**
/// 1. `balance` is DERIVED, never stored (L101-103).
/// 2. A receipt is IMMUTABLE once issued (L59-60) — correction is refund + new.
/// 3. A refund may never exceed what was actually received.
/// 4. A discount above the unapproved ceiling requires owner approval, and is
///    recorded as an adjustment rather than by editing the original ask (L50-51).
///
/// **No wall clock** (`X-09`): every date is a fixed constant.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/fee/domain/fee_ledger.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const StudentRecordId _student = StudentRecordId('SR-2026-0001');

final DateTime _raisedOn = DateTime.utc(2026, 5, 1);
final DateTime _dueOn = DateTime.utc(2026, 5, 10);

FeeDue _due({
  String id = 'DUE-1',
  num rupees = 1000,
  String description = 'Monthly membership',
  FeeCategory category = FeeCategory.membership,
  String? sourceRef,
}) => FeeDue(
  id: id,
  description: description,
  amount: Money.rupees(rupees),
  raisedOn: _raisedOn,
  dueOn: _dueOn,
  category: category,
  sourceRef: sourceRef,
);

Receipt _receipt({
  String id = 'RCP-1',
  String number = 'R-0001',
  num rupees = 1000,
  bool isRefund = false,
  String? againstDueId,
}) => Receipt(
  id: id,
  receiptNumber: number,
  amount: Money.rupees(rupees),
  mode: PaymentMode.upi,
  receivedOn: _raisedOn,
  collectedBy: 'staff-7',
  againstDueId: againstDueId,
  isRefund: isRefund,
);

FeeLedger _ledger() => FeeLedger(studentRecordId: _student);

void main() {
  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 1 — balance is DERIVED across all dues and receipts.
  // ════════════════════════════════════════════════════════════════════
  group('BC-05 invariant: balance is derived, never stored', () {
    test('an empty ledger owes nothing and has no open dues', () {
      final l = _ledger();
      expect(l.totalDue, Money.zero);
      expect(l.totalReceived, Money.zero);
      expect(l.balance, Money.zero);
      expect(
        l.hasOpenDues,
        isFalse,
        reason:
            'A zero balance must not read as "open", or every newly enrolled '
            'student would be unarchivable from day one.',
      );
    });

    test('balance tracks dues and receipts across the whole ledger', () {
      final l = _ledger();
      l.raiseDue(_due(id: 'DUE-1', rupees: 1000));
      l.raiseDue(_due(id: 'DUE-2', rupees: 500, category: FeeCategory.seat));

      expect(l.totalDue, Money.rupees(1500));
      expect(l.balance, Money.rupees(1500));
      expect(l.hasOpenDues, isTrue);

      l.recordReceipt(_receipt(id: 'RCP-1', rupees: 1200));

      expect(
        l.balance,
        Money.rupees(300),
        reason:
            'A per-invoice aggregate could not answer this in one consistent '
            'read — which is the stated reason the ledger is per student.',
      );
      expect(l.hasOpenDues, isTrue);
    });

    test('a fully settled ledger has no open dues', () {
      final l = _ledger();
      l.raiseDue(_due(rupees: 1000));
      l.recordReceipt(_receipt(rupees: 1000));

      expect(l.balance, Money.zero);
      expect(
        l.hasOpenDues,
        isFalse,
        reason:
            'This is the condition BC-01 archive() reads. If a settled ledger '
            'still reported open dues, no student could ever be archived.',
      );
    });

    test('an over-payment produces a negative balance, not an error', () {
      final l = _ledger();
      l.raiseDue(_due(rupees: 1000));
      l.recordReceipt(_receipt(rupees: 1200));

      expect(l.balance, Money.rupees(-200));
      expect(
        l.hasOpenDues,
        isFalse,
        reason:
            'hasOpenDues is isPositive (L105), so a credit balance is not an '
            'open due. A library holding advance money must not be blocked '
            'from archiving over its own credit.',
      );
    });

    test('a negative due cannot be constructed', () {
      expect(
        () => FeeDue(
          id: 'DUE-X',
          description: 'refund disguised as a due',
          amount: Money.rupees(-100),
          raisedOn: _raisedOn,
          dueOn: _dueOn,
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.validationFailed,
          ),
        ),
        reason:
            'A negative due is a credit wearing the wrong type; it would make '
            'totalDue reduce the balance without any receipt to justify it.',
      );
    });

    test('a duplicate due id is refused', () {
      final l = _ledger();
      l.raiseDue(_due(id: 'DUE-1', rupees: 1000));

      expect(
        () => l.raiseDue(_due(id: 'DUE-1', rupees: 1000)),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.conflict,
          ),
        ),
        reason:
            'A replayed raise-due request must not double-charge the student. '
            'The id is the idempotency handle at this boundary.',
      );
      expect(l.totalDue, Money.rupees(1000));
      expect(l.dues.length, 1);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 2 — a receipt is immutable once issued.
  // ════════════════════════════════════════════════════════════════════
  group('BC-05 invariant: a receipt is immutable once issued', () {
    test('re-recording the same receipt id is refused with the code that '
        'names the reason', () {
      final l = _ledger();
      l.raiseDue(_due(rupees: 1000));
      l.recordReceipt(_receipt(id: 'RCP-1', number: 'R-0001', rupees: 1000));

      DomainError? caught;
      try {
        l.recordReceipt(_receipt(id: 'RCP-1', number: 'R-0001', rupees: 400));
      } on DomainError catch (e) {
        caught = e;
      }

      expect(caught, isNotNull);
      expect(
        caught!.code,
        DomainErrorCode.receiptImmutable,
        reason:
            'A generic conflict would not tell the caller the remedy. The '
            'message must point at refund-plus-new-receipt (L163-164).',
      );
      expect(
        l.totalReceived,
        Money.rupees(1000),
        reason:
            'The rejected rewrite must not alter the collected total. '
            'Reprinting a receipt has to reproduce it byte for byte (L59-60).',
      );
    });

    test('a zero or negative receipt is refused', () {
      final l = _ledger();
      l.raiseDue(_due(rupees: 1000));

      for (final rupees in [0, -100]) {
        expect(
          () => l.recordReceipt(_receipt(id: 'RCP-$rupees', rupees: rupees)),
          throwsA(
            isA<DomainError>().having(
              (e) => e.code,
              'code',
              DomainErrorCode.validationFailed,
            ),
          ),
          reason:
              'A zero-value receipt is a document asserting a payment that did '
              'not happen. Amount under test: $rupees.',
        );
      }
      expect(l.receipts, isEmpty);
    });

    test('correction is expressed as a refund plus a new receipt, and both '
        'survive in the record', () {
      final l = _ledger();
      l.raiseDue(_due(rupees: 1000));
      l.recordReceipt(_receipt(id: 'RCP-1', number: 'R-0001', rupees: 1000));

      // The prescribed remedy: refund the wrong receipt, issue a correct one.
      l.recordReceipt(
        _receipt(id: 'RCP-2', number: 'R-0002', rupees: 1000, isRefund: true),
      );
      l.recordReceipt(_receipt(id: 'RCP-3', number: 'R-0003', rupees: 900));

      expect(
        l.receipts.length,
        3,
        reason:
            'All three documents must remain. Collapsing them into one edited '
            'receipt is exactly what receiptImmutable forbids.',
      );
      expect(l.totalReceived, Money.rupees(900));
      expect(l.balance, Money.rupees(100));
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 3 — a refund may never exceed what was received.
  // ════════════════════════════════════════════════════════════════════
  group('BC-05 invariant: a refund cannot exceed receipts', () {
    test('refunding more than was received is refused', () {
      final l = _ledger();
      l.raiseDue(_due(rupees: 1000));
      l.recordReceipt(_receipt(id: 'RCP-1', rupees: 500));

      DomainError? caught;
      try {
        l.recordReceipt(
          _receipt(id: 'RCP-2', number: 'R-0002', rupees: 800, isRefund: true),
        );
      } on DomainError catch (e) {
        caught = e;
      }

      expect(caught, isNotNull);
      expect(caught!.code, DomainErrorCode.refundExceedsReceipts);
      expect(
        caught.context['received'],
        Money.rupees(500).minorUnits,
        reason:
            'The refusal must state what WAS received, so the desk can issue '
            'the correct amount without a second guess.',
      );
      expect(l.totalReceived, Money.rupees(500));
    });

    test('refunding exactly what was received is permitted', () {
      final l = _ledger();
      l.raiseDue(_due(rupees: 1000));
      l.recordReceipt(_receipt(id: 'RCP-1', rupees: 500));

      l.recordReceipt(
        _receipt(id: 'RCP-2', number: 'R-0002', rupees: 500, isRefund: true),
      );

      expect(
        l.totalReceived,
        Money.zero,
        reason:
            'A full refund must return the collected total to zero exactly; a '
            'strict bound here would block legitimate full refunds.',
      );
      expect(l.balance, Money.rupees(1000));
    });

    test('a refund contributes negatively to the collected total', () {
      final r = _receipt(rupees: 300, isRefund: true);
      expect(r.signedAmount, Money.rupees(-300));
      expect(
        _receipt(rupees: 300).signedAmount,
        Money.rupees(300),
        reason:
            'If a refund were signed positive, refunding money would increase '
            'reported collection.',
      );
    });

    test('a second refund is measured against the balance left after the '
        'first', () {
      final l = _ledger();
      l.raiseDue(_due(rupees: 1000));
      l.recordReceipt(_receipt(id: 'RCP-1', rupees: 1000));
      l.recordReceipt(
        _receipt(id: 'RCP-2', number: 'R-0002', rupees: 600, isRefund: true),
      );

      // Only 400 remains held.
      expect(
        () => l.recordReceipt(
          _receipt(id: 'RCP-3', number: 'R-0003', rupees: 500, isRefund: true),
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.refundExceedsReceipts,
          ),
        ),
        reason:
            'The bound is totalReceived, which is already net of earlier '
            'refunds. Checking against the gross would let the library refund '
            'the same money twice.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 4 — discount ceiling and the original-ask preservation rule.
  // ════════════════════════════════════════════════════════════════════
  group('BC-05 invariant: discount requires approval above the ceiling', () {
    test('a discount within the unapproved ceiling is permitted', () {
      final l = _ledger();
      l.raiseDue(_due(id: 'DUE-1', rupees: 1000));

      // 20% of 1000 = 200, the boundary itself.
      l.applyDiscount(
        dueId: 'DUE-1',
        discount: Money.rupees(200),
        approvedByOwner: false,
      );

      expect(l.totalDiscount, Money.rupees(200));
      expect(l.balance, Money.rupees(800));
      expect(FeeLedger.maxUnapprovedPercent, 20);
    });

    test('a discount above the ceiling is refused without owner approval', () {
      final l = _ledger();
      l.raiseDue(_due(id: 'DUE-1', rupees: 1000));

      DomainError? caught;
      try {
        l.applyDiscount(
          dueId: 'DUE-1',
          discount: Money.rupees(300),
          approvedByOwner: false,
        );
      } on DomainError catch (e) {
        caught = e;
      }

      expect(caught, isNotNull);
      expect(caught!.code, DomainErrorCode.discountRequiresApproval);
      expect(
        l.totalDiscount,
        Money.zero,
        reason:
            'The refusal must leave the due untouched. The rule is enforced '
            'here precisely so no UI path can bypass it (L124-125).',
      );
      expect(l.balance, Money.rupees(1000));
    });

    test('the same discount is permitted with owner approval', () {
      // Vacuity guard: proves the ceiling is a gate, not a hard maximum.
      final l = _ledger();
      l.raiseDue(_due(id: 'DUE-1', rupees: 1000));

      l.applyDiscount(
        dueId: 'DUE-1',
        discount: Money.rupees(300),
        approvedByOwner: true,
      );

      expect(l.totalDiscount, Money.rupees(300));
      expect(l.balance, Money.rupees(700));
    });

    test('a discount exceeding the original amount is refused even with '
        'approval', () {
      final l = _ledger();
      l.raiseDue(_due(id: 'DUE-1', rupees: 1000));

      expect(
        () => l.applyDiscount(
          dueId: 'DUE-1',
          discount: Money.rupees(1100),
          approvedByOwner: true,
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.validationFailed,
          ),
        ),
        reason:
            'Owner approval raises the ceiling, it does not permit a negative '
            'net due — which would be a credit created without a receipt.',
      );
      expect(l.totalDiscount, Money.zero);
    });

    test('a negative discount is refused', () {
      final l = _ledger();
      l.raiseDue(_due(id: 'DUE-1', rupees: 1000));

      expect(
        () => l.applyDiscount(
          dueId: 'DUE-1',
          discount: Money.rupees(-100),
          approvedByOwner: true,
        ),
        throwsA(isA<DomainError>()),
        reason:
            'A negative discount is a surcharge applied through the discount '
            'path, escaping whatever approval a surcharge would require.',
      );
    });

    test('a discount preserves the original ask and only changes netAmount',
        () {
      final l = _ledger();
      l.raiseDue(_due(id: 'DUE-1', rupees: 1000));

      l.applyDiscount(
        dueId: 'DUE-1',
        discount: Money.rupees(150),
        approvedByOwner: false,
      );

      final due = l.dues.single;
      expect(
        due.amount,
        Money.rupees(1000),
        reason:
            'L50-51: discounts are recorded as adjustments, never by editing '
            'amount — the original ask must remain auditable.',
      );
      expect(due.discount, Money.rupees(150));
      expect(due.netAmount, Money.rupees(850));
    });

    test('discounting a due that is not on this ledger is refused', () {
      final l = _ledger();
      l.raiseDue(_due(id: 'DUE-1', rupees: 1000));

      expect(
        () => l.applyDiscount(
          dueId: 'DUE-NOPE',
          discount: Money.rupees(50),
          approvedByOwner: true,
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.notFound,
          ),
        ),
        reason:
            'Silently ignoring an unknown due id would report success for a '
            'discount that was never applied.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // INVARIANT 5 — overdue is derived from the due date, not a stored flag.
  // ════════════════════════════════════════════════════════════════════
  group('BC-05 invariant: overdue is derived per day', () {
    test('a due is overdue only strictly after its due date', () {
      final l = _ledger();
      l.raiseDue(_due(id: 'DUE-1', rupees: 1000));

      expect(l.overdueOn(_dueOn), isEmpty, reason: 'Due date itself is not late.');
      expect(
        l.overdueOn(_dueOn.add(const Duration(days: 1))).length,
        1,
        reason:
            'A stored overdue flag would need a sweep to stay true; deriving '
            'it per query cannot go stale.',
      );
    });

    test('the money domain boundary is not crossed by this aggregate', () {
      // BC-05 money flows student -> library. BC-20 SubscriptionCharge
      // (library -> Liboora) shares the word "payment" and nothing else; the
      // file exists to prevent conflating them (L3-6). The proof available at
      // this layer is that no category names a subscription concern.
      expect(
        FeeCategory.values.map((c) => c.name),
        <String>['membership', 'seat', 'locker', 'lateFee', 'security', 'other'],
        reason:
            'If a subscription/platform-billing category ever appears here, '
            'the two money domains have been merged and BC-20 has leaked into '
            'BC-05.',
      );
    });
  });
}
