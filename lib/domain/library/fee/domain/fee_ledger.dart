/// **BC-05 Fee & Collection** — aggregate `FeeLedger`.
///
/// The money here flows **student → library** (`FeePayment`). Money flowing
/// **library → Liboora** is `SubscriptionCharge` and lives in BC-20. Two
/// different domains that share the word "payment"; conflating them is the
/// mistake this file exists to prevent.
///
/// Aggregate is the ledger **per student**, not per invoice. Balance is an
/// invariant across all dues and receipts, so all of them must be inside one
/// transaction boundary. A per-invoice aggregate makes "total outstanding"
/// eventually consistent, and archival-blocking (`cannotArchiveWithOpenDues`)
/// then becomes unenforceable.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

enum FeeCategory { membership, seat, locker, lateFee, security, other }

enum PaymentMode { cash, upi, card, bankTransfer, cheque }

/// A charge raised against a student.
final class FeeDue {
  FeeDue({
    required this.id,
    required this.description,
    required this.amount,
    required this.raisedOn,
    required this.dueOn,
    this.category = FeeCategory.membership,
    this.sourceRef,
  }) {
    if (amount.isNegative) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'A due cannot be negative.',
      );
    }
  }

  final String id;
  final String description;
  final Money amount;
  final DateTime raisedOn;
  final DateTime dueOn;
  final FeeCategory category;

  /// e.g. the membership id that generated this due (edge E-05).
  final String? sourceRef;

  /// Discounts are recorded as negative adjustments against the due, never by
  /// editing [amount] — the original ask must remain auditable.
  Money discount = Money.zero;

  Money get netAmount => amount - discount;

  bool isOverdueOn(DateTime day) => day.isAfter(dueOn);
}

/// Immutable once issued. Reprinting a receipt must reproduce it byte for
/// byte; a corrected receipt is a *new* document plus a refund entry.
final class Receipt {
  const Receipt({
    required this.id,
    required this.receiptNumber,
    required this.amount,
    required this.mode,
    required this.receivedOn,
    required this.collectedBy,
    this.againstDueId,
    this.isRefund = false,
    this.note,
  });

  final String id;
  final String receiptNumber;
  final Money amount;
  final PaymentMode mode;
  final DateTime receivedOn;
  final String collectedBy;
  final String? againstDueId;
  final bool isRefund;
  final String? note;

  /// Signed contribution to the collected total.
  Money get signedAmount => isRefund ? Money.zero - amount : amount;
}

final class FeeLedger {
  FeeLedger({required this.studentRecordId});

  final StudentRecordId studentRecordId;

  final List<FeeDue> dues = [];
  final List<Receipt> receipts = [];

  Money get totalDue => dues.fold(Money.zero, (sum, d) => sum + d.netAmount);

  Money get totalReceived =>
      receipts.fold(Money.zero, (sum, r) => sum + r.signedAmount);

  /// **Derived, never stored.** A stored balance is a second source of truth
  /// and will drift from the entries that justify it.
  Money get balance => totalDue - totalReceived;

  bool get hasOpenDues => balance.isPositive;

  Money get totalDiscount =>
      dues.fold(Money.zero, (sum, d) => sum + d.discount);

  List<FeeDue> overdueOn(DateTime day) =>
      dues.where((d) => d.isOverdueOn(day)).toList(growable: false);

  void raiseDue(FeeDue due) {
    if (dues.any((d) => d.id == due.id)) {
      throw DomainError(
        DomainErrorCode.conflict,
        'Due ${due.id} already recorded.',
        context: {'dueId': due.id},
      );
    }
    dues.add(due);
  }

  /// Discount above [maxUnapprovedPercent] of the original amount requires
  /// owner approval — enforced here so no UI path can bypass it.
  static const int maxUnapprovedPercent = 20;

  void applyDiscount({
    required String dueId,
    required Money discount,
    required bool approvedByOwner,
  }) {
    final due = dues.firstWhere(
      (d) => d.id == dueId,
      orElse: () => throw DomainError(
        DomainErrorCode.notFound,
        'No such due on this ledger.',
        context: {'dueId': dueId},
      ),
    );
    if (discount.isNegative || discount > due.amount) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'Discount must be between zero and the original amount.',
      );
    }
    if (!approvedByOwner &&
        discount > due.amount.prorate(maxUnapprovedPercent, 100)) {
      throw DomainError(
        DomainErrorCode.discountRequiresApproval,
        'A discount above $maxUnapprovedPercent% needs owner approval.',
        context: {'dueId': dueId, 'discount': discount.minorUnits},
      );
    }
    due.discount = discount;
  }

  /// Records a payment. The receipt object is never mutated afterwards.
  void recordReceipt(Receipt receipt) {
    if (receipts.any((r) => r.id == receipt.id)) {
      throw DomainError(
        DomainErrorCode.receiptImmutable,
        'Receipt ${receipt.receiptNumber} already exists and cannot be '
        'rewritten. Issue a refund and a new receipt instead.',
        context: {'receiptId': receipt.id},
      );
    }
    if (receipt.amount.isNegative || receipt.amount.isZero) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'Receipt amount must be positive.',
      );
    }
    if (receipt.isRefund && receipt.amount > totalReceived) {
      throw DomainError(
        DomainErrorCode.refundExceedsReceipts,
        'Cannot refund ${receipt.amount.formatted} — only '
        '${totalReceived.formatted} has been received.',
        context: {
          'refund': receipt.amount.minorUnits,
          'received': totalReceived.minorUnits,
        },
      );
    }
    receipts.add(receipt);
  }
}
