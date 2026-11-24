/// App-facing read models and ports for the library contexts
/// (`PRD-004` §3.4 wave 4).
///
/// `app` declares `domain/library` under `ports:`, never `imports:`
/// (`tool/module_dependencies.yaml` L534 vs L628 — the nine `TASK-D10`
/// boundary sites). These types are the contract surface that lets the UI
/// read library data without naming a rank-8 type: adapters at the
/// composition root map the domain aggregates onto these shapes, exactly as
/// `BranchView` already does for BC-06 display facts.
///
/// Every field below mirrors a field a screen demonstrably consumes today.
/// Nothing is invented, and no analytics counter substitutes for an entity:
/// these are read models over the owning repositories, built on demand.
///
/// `PaymentMode` and `GuardianLink` are shared-kernel value objects moved
/// here from `BC-05`/`BC-01` so both the domain and the UI can name the one
/// definition; the owning domain barrels re-export them for compatibility.
library;

import '../value_objects/date_range.dart';
import '../value_objects/identifiers.dart';
import '../value_objects/money.dart';

// ── Shared value objects (moved from owning domains) ────────────────

/// How a payment physically arrived. Structural fact of `BC-05`; named by
/// the collect dialog and by every receipt renderer.
enum PaymentMode { cash, upi, card, bankTransfer, cheque }

/// A student's guardian of record. Read on the `StudentRecord` aggregate and
/// supplied by the walk-in enrollment dialog for minors.
final class GuardianLink {
  const GuardianLink({
    required this.name,
    required this.phone,
    this.relation = 'Parent',
  });

  final String name;
  final String phone;
  final String relation;
}

// ── Enrollment reads (BC-01) ─────────────────────────────────────────

/// One student as the roster and detail sheet see them.
final class StudentEntry {
  const StudentEntry({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.enrollmentNumber,
  });

  final StudentRecordId id;
  final String fullName;
  final String phone;
  final String enrollmentNumber;
}

/// One bounded page of the roster (PG-1..PG-4). [nextCursor] is the opaque
/// server-issued continuation token; null means end of roster.
final class StudentPage {
  const StudentPage({required this.items, required this.nextCursor});

  final List<StudentEntry> items;
  final String? nextCursor;
}

/// The student-directory read surface.
abstract interface class StudentDirectoryPort {
  List<StudentEntry> all();

  /// Bounded, cursor-paginated roster. Malformed or foreign-tenant cursors
  /// throw — never a silent reset (PG-4).
  StudentPage page({String? cursor});

  StudentEntry? byId(StudentRecordId id);

  /// Students whose membership expires within the policy window.
  List<StudentEntry> expiringSoon();

  /// Students carrying an open (positive) balance.
  List<StudentEntry> withOpenDues();

  /// Verifies [cursor] belongs to the tenant currently in scope.
  void verifyCursorTenant(String cursor);
}

// ── Membership reads (BC-02) ─────────────────────────────────────────

/// Whether a student holds an active plan right now, and until when.
final class ValidityView {
  const ValidityView({
    required this.planName,
    required this.isValid,
    required this.validUntil,
    required this.seatQuota,
  });

  final String planName;
  final bool isValid;

  /// The inclusive last business date, or null when invalid (`MM-FR-055`).
  final DateTime? validUntil;
  final int seatQuota;
}

/// One membership term on record, for the plan-history screen.
final class MembershipTermView {
  const MembershipTermView({
    required this.planName,
    required this.term,
    required this.endsOn,
    required this.price,
    required this.isActiveOn,
  });

  /// Resolved from the plan catalogue at read time (`MM-FR-026`); the
  /// withdrawn-plan fallback stays an adapter decision, not a UI guess.
  final String planName;

  /// The half-open term (`[start, end)`) — `lengthInDays` and `start` drive
  /// the elapsed-fraction meter.
  final DateRange term;

  /// The inclusive last business date (`MM-FR-039` — computed, never stored).
  final DateTime endsOn;

  /// The immutable at-purchase snapshot, not the plan's current price.
  final Money price;
  final bool isActiveOn;
}

abstract interface class MembershipReadPort {
  ValidityView validityOf(StudentRecordId id);

  /// Every term on record for the student, oldest first.
  List<MembershipTermView> historyFor(StudentRecordId id);
}

// ── Fee reads (BC-05) ────────────────────────────────────────────────

/// One raised charge.
final class DueView {
  const DueView({
    required this.description,
    required this.dueOn,
    required this.discount,
    required this.netAmount,
  });

  final String description;
  final DateTime dueOn;
  final Money discount;
  final Money netAmount;
}

/// One immutable receipt.
final class ReceiptView {
  const ReceiptView({
    required this.receiptNumber,
    required this.mode,
    required this.amount,
    required this.receivedOn,
    required this.collectedBy,
  });

  final String receiptNumber;
  final PaymentMode mode;
  final Money amount;
  final DateTime receivedOn;
  final String collectedBy;
}

/// A student's ledger as the money screens see it. Balance is deliberately
/// absent — the owning aggregate derives it (`totalDue - totalReceived`),
/// and no read model may store a second source of truth.
final class LedgerView {
  const LedgerView({
    required this.totalDue,
    required this.totalReceived,
    required this.dues,
    required this.receipts,
  });

  final Money totalDue;
  final Money totalReceived;
  final List<DueView> dues;
  final List<ReceiptView> receipts;
}

abstract interface class FeeReadPort {
  LedgerView? ledgerFor(StudentRecordId id);

  /// Outstanding balance for one student (zero when no ledger exists).
  Money outstandingFor(StudentRecordId id);

  bool hasOpenDues(StudentRecordId id);

  /// Sum of every ledger's balance — the collections header figure.
  Money totalOutstanding();

  /// All-time raised/received totals across every ledger.
  ({Money raised, Money received}) totals();

  /// Every receipt on record, newest first.
  List<ReceiptView> allReceipts();
}

// ── Seating reads (BC-04) ────────────────────────────────────────────

/// One seat on the map, with its live allocation if any.
final class SeatOccupancyView {
  const SeatOccupancyView({
    required this.seatId,
    required this.label,
    required this.zone,
    required this.hasPowerSocket,
    required this.isOccupied,
    required this.studentName,
    required this.allocationId,
    required this.allocatedUntil,
  });

  final String seatId;
  final String label;
  final String zone;
  final bool hasPowerSocket;
  final bool isOccupied;
  final String? studentName;

  /// Present exactly when [isOccupied]; the release command's handle.
  final String? allocationId;

  /// The allocation window's half-open end, as the seat dialog shows it.
  final DateTime? allocatedUntil;
}

abstract interface class SeatingReadPort {
  /// The branch's live seat map. [nameOf] resolves a student id to a display
  /// name, mirroring the domain service's contract.
  List<SeatOccupancyView> currentMap(
    String Function(StudentRecordId id) nameOf,
  );

  ({int total, int occupied, int free}) summary();
}
