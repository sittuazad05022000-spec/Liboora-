/// The **library boundary** — the consumer-declared port between the app and
/// `BC-01`..`BC-05` (`ADR-0012` §3.4).
///
/// `app` may depend on `domain/library` only in **port mode**: an interface
/// declared by the consumer, implemented at the composition root, DI-wired,
/// with **no compile-time import** of the domain barrels. This file is that
/// consumer-declared surface: pure view records over `liboora_contracts` types,
/// plus the [LibraryReads] interface the composition root implements.
///
/// Why app-owned views and not the domain aggregates: a port interface may not
/// reference the implementing module's types (rank 8 may not import rank 9 to
/// read the interface, and rank 9 may not import rank 8's internals to see the
/// aggregates). The views carry exactly the fields the screens render — no
/// invariant logic crosses the boundary, so the aggregate remains the sole
/// enforcer (`AP-1`).
///
/// The adapter implementing this interface lives in `lib/bootstrap/` — the
/// composition root, the one place permitted to know a port and its adapter
/// (the same rule `provisionIdentityForEnrollment` already follows).
library;

import 'package:liboora_contracts/liboora_contracts.dart';

import 'package:liboora/domain/library/enrollment/enrollment.dart';

/// How a collected fee was paid. Mirrors the domain enum one-to-one; the
/// mapping happens at the composition root, never in a widget (`AP-1`).
enum PayInMode { cash, upi, card, bankTransfer, cheque }

/// One roster row as the UI renders it.
final class StudentView {
  const StudentView({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.enrollmentNumber,
    required this.enrollmentStatus,
    required this.isExpiringSoon,
    required this.isArchived,
    this.photoRef,
  });

  final StudentRecordId id;
  final String fullName;
  final String phone;
  final String enrollmentNumber;

  /// Enrollment status from BC-01: independent of membership status (LMD-25).
  final EnrollmentStatus enrollmentStatus;

  /// Membership expiry indicator derived from BC-02 projection using SMCFG-3
  /// threshold. Not a replacement for membership status (LMD-26).
  final bool isExpiringSoon;

  /// Whether this record is archived. Hidden by default per LMD-27.
  final bool isArchived;

  /// Opaque file reference (BC-29 / E-22) — never bytes, never a path.
  final FileRef? photoRef;
}

/// One page of [StudentView]. [nextCursor] is opaque and server-generated
/// (`PG-1`/`PG-2`); null means the last page.
final class StudentPageView {
  const StudentPageView({required this.items, required this.nextCursor});

  final List<StudentView> items;
  final String? nextCursor;
}

/// Membership validity as the dashboards render it.
final class MembershipValidityView {
  const MembershipValidityView({
    required this.isValid,
    required this.planName,
    required this.validUntil,
    required this.seatQuota,
  });

  /// `MM-FR-067` — never re-derived from [validUntil] by the caller.
  final bool isValid;
  final DateTime? validUntil;
  final int seatQuota;
  final String planName;
}

/// One raised charge, display-shaped.
final class FeeDueView {
  const FeeDueView({
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

/// One immutable receipt. [mode] is the payment channel label only.
final class ReceiptView {
  const ReceiptView({
    required this.receiptNumber,
    required this.amount,
    required this.mode,
    required this.receivedOn,
    required this.collectedBy,
  });

  final String receiptNumber;
  final Money amount;
  final PayInMode mode;
  final DateTime receivedOn;
  final String collectedBy;
}

/// A student's fee ledger, projected for display.
final class FeeLedgerView {
  const FeeLedgerView({
    required this.totalDue,
    required this.totalReceived,
    required this.dues,
    required this.receipts,
  });

  final Money totalDue;
  final Money totalReceived;
  final List<FeeDueView> dues;
  final List<ReceiptView> receipts;
}

/// The guardian facts the enrollment form collects. The conversion to the
/// domain's guardian link happens behind the boundary, at the composition
/// root — the UI never names a domain type.
final class GuardianDraft {
  const GuardianDraft({required this.name, required this.phone});

  final String name;
  final String phone;
}

/// One seat and, when held, who holds it and until when.
final class SeatOccupancyView {
  const SeatOccupancyView({
    required this.seatLabel,
    required this.seatZone,
    required this.hasPowerSocket,
    required this.isOccupied,
    this.studentName,
    this.allocationId,
    this.allocatedOn,
    this.untilEnd,
  });

  final String seatLabel;
  final String seatZone;
  final bool hasPowerSocket;
  final bool isOccupied;

  /// Present only while the seat is occupied.
  final String? studentName;

  /// The live allocation, if any. Releasing a seat releases by this id.
  final String? allocationId;
  final DateTime? allocatedOn;
  final DateTime? untilEnd;
}

/// Membership term as the plan page renders it.
final class MembershipTermView {
  const MembershipTermView({
    required this.planId,
    required this.planName,
    required this.start,
    required this.endDate,
    required this.price,
    required this.isValidNow,
  });

  final String planId;
  final String planName;
  final DateTime start;
  final DateTime endDate;
  final Money price;
  final bool isValidNow;
}

/// The reads (and the two commands whose argument types are domain-owned)
/// that the app boundary consumes. Implemented at the composition root.
abstract interface class LibraryBoundary {
  // ── Reads ──
  List<StudentView> roster();

  /// Paginated roster. [cursor] is treated as opaque (`PG-2`); a malformed
  /// cursor surfaces as a [DomainError], never a silent reset (`PG-4`).
  /// [pageSize] — optional override per LMD-10; clamped to SMCFG-2 maximum (50).
  /// [includeArchived] — if false (default), excludes `EnrollmentStatus.archived`;
  /// TR-1 Owner and TR-2 Manager are authorized to set this to true (LMD-27).
  StudentPageView rosterPage({
    String? cursor,
    int? pageSize,
    bool includeArchived = false,
  });

  StudentView? studentById(StudentRecordId id);

  String nameOf(StudentRecordId id);

  MembershipValidityView validityOf(StudentRecordId id);

  FeeLedgerView? ledgerOf(StudentRecordId id);

  Money outstandingOf(StudentRecordId id);

  Money get totalOutstanding;

  Money get raisedAll;

  Money get receivedAll;

  /// Every receipt across every ledger, newest first.
  List<ReceiptView> receiptsAll();

  List<StudentView> expiringSoon();

  List<StudentView> withOpenDues();

  bool isInsideNow(StudentRecordId id);

  List<SeatOccupancyView> seatMap();

  ({int total, int occupied, int free}) seatSummary();

  /// Fraction of the currently valid term elapsed, for the membership meter.
  double elapsedMembershipFraction(StudentRecordId id);

  /// Full membership history for a student, newest first. Each term carries
  /// its own plan name snapshot (MM-FR-026) — a later plan edit can never
  /// restate a past term.
  List<MembershipTermView> membershipHistory(StudentRecordId id);

  // ── Commands whose parameter types cross the boundary ──
  Future<void> enrollStudent({
    required String actorRoleName,
    required String fullName,
    required String phone,
    required DateTime dateOfBirth,
    GuardianDraft? guardian,
  });

  Future<void> collectFee({
    required String actorRoleName,
    required StudentRecordId studentId,
    required Money amount,
    required PayInMode mode,
  });
}
