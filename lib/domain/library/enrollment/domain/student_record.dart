/// **BC-01 Enrollment** — aggregate `StudentRecord`.
///
/// Owns the identity of a person *as a student of this library*. Tenant-scoped
/// always. Distinct from `PersonIdentity` (BC-10, global and permanent) and
/// `Account` (BC-18, credentials only) — see the Identity Triad.
///
/// One human enrolled at three libraries has **three** of these and **one**
/// `PersonId`. That asymmetry is deliberate: it is what lets an erasure request
/// anonymise the person while a library retains fee and attendance history
/// under legal basis (`ID-5`).
///
/// **DOB is not stored here** (`ADR-0179`, Option C). `SM-4.2` reserves Date of
/// Birth for BC-10; `SM-4.5` derives age from the `E-13` read. This aggregate
/// stores only the **resolved minor status** and — where BC-10 has no DOB —
/// the audited staff declaration required by `SM-4.5a`/`SM-4.5b`.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

/// Independent of `MembershipStatus`. A student can be Active with an Expired
/// membership — two separate state machines (ubiquitous language table).
enum EnrollmentStatus { active, inactive, suspended, archived }

/// `SM-3.8` — how the student came to be registered. Closed set.
enum RegistrationSource { staffAssisted, selfEnrollment, import }

/// `SM-4.5a`/`SM-4.5b` — the resolved safeguarding status of the enrollment.
/// `unknown` means BC-10 holds no DOB and no declaration has resolved the
/// question yet; such a record is **treated as a minor** (fail-safe) until a
/// declaration says otherwise.
enum MinorStatus { minor, adult, unknown }

/// `SM-4.5a` — a staff-recorded attestation of whether the student is a minor,
/// used only when BC-10's DOB is absent. Audited with actor and timestamp
/// (`SM-8.13`).
final class AgeDeclaration {
  const AgeDeclaration({
    required this.isMinor,
    required this.declaredBy,
    required this.declaredAt,
  });

  final bool isMinor;
  final String declaredBy;
  final DateTime declaredAt;
}

/// `SM-2.8`/`SM-2.13` — one append-only entry of the status history. A status
/// change never overwrites prior history (`SM-INV-9`).
final class StudentStatusChange {
  const StudentStatusChange({
    required this.to,
    required this.at,
    required this.actor,
    this.reason,
  });

  final EnrollmentStatus to;
  final DateTime at;
  final String actor;
  final String? reason;
}

// GuardianLink moved to the shared kernel (liboora_contracts) so the app can
// name it without a rank-8 import; re-exported by the enrollment barrel.

final class StudentRecord {
  StudentRecord({
    required this.id,
    required this.enrollmentNumber,
    required this.fullName,
    required this.phone,
    required this.enrolledOn,
    this.email,
    this.guardian,
    required this.personId,
    this.accountId,
    this.registrationSource,
    this.minorStatus = MinorStatus.unknown,
    this.ageDeclaration,
    this.status = EnrollmentStatus.active,
    this.photoRef,
    this.archivedAt,
    List<StudentStatusChange> statusHistory = const [],
  }) : statusHistory = List.of(statusHistory) {
    _assertInvariants();
  }

  final StudentRecordId id;
  final String enrollmentNumber;
  String fullName;
  String phone;
  String? email;
  final DateTime enrolledOn;
  GuardianLink? guardian;

  /// The person this record is a library-scoped view of.
  ///
  /// **Non-nullable** (`ID-4`, `SID-4.17`): a Global Person Identity now always
  /// exists, so there is no "unlinked student" state to degrade into. This is a
  /// downward reference to rank 7.5 — the record points at the person, never the
  /// reverse (`SID-INV-8`).
  final PersonId personId;

  /// `SM-1.2`/`SM-2.2` — the account behind the enrollment, resolved through
  /// `E-11`. Non-null for every new record (provisioning guarantees an
  /// account); legacy rows decoded before Option C hold `null` — an honest
  /// "unrecorded", never a fabricated link.
  final AccountId? accountId;

  /// `SM-3.8` — closed-set provenance. Non-null for new records; legacy rows
  /// hold `null` ("unrecorded") because inventing `StaffAssisted` would
  /// fabricate provenance.
  final RegistrationSource? registrationSource;

  /// `SM-4.5`/`SM-4.5a` — the resolved safeguarding status.
  final MinorStatus minorStatus;

  /// `SM-4.5a` — the audited staff declaration, present only when BC-10 holds
  /// no DOB.
  final AgeDeclaration? ageDeclaration;

  EnrollmentStatus status;
  FileRef? photoRef;

  /// `SM-3.14a` — when this record entered `Archived`. Drives the
  /// most-recently-archived restore targeting rule.
  DateTime? archivedAt;

  /// `SM-2.13`/`SM-INV-9` — append-only. Legacy rows restored before Option C
  /// carry an empty history: pre-feature transitions are unrecoverable and are
  /// never synthesized.
  final List<StudentStatusChange> statusHistory;

  /// `SM-4.5b` — the fail-safe safeguarding question. A record whose minor
  /// status is unknown and undeclared **is** treated as a minor; only an
  /// explicit adult declaration (or a derived adult status) opens the gate.
  bool get requiresGuardian => switch (minorStatus) {
    MinorStatus.minor => true,
    MinorStatus.adult => false,
    MinorStatus.unknown => ageDeclaration?.isMinor ?? true,
  };

  void _appendStatus(StudentStatusChange change) {
    statusHistory.add(change);
  }

  void _assertInvariants() {
    // ID-4 / SID-4.17: the identity reference is mandatory. Checked rather than
    // assumed, because "a rule that cannot be checked shall be treated as
    // unmet, not as satisfied by intent" (SID-4.56).
    if (!personId.isValid) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'A student record requires the PersonId of the person it represents.',
      );
    }
    if (fullName.trim().isEmpty) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'Student name is required.',
      );
    }
    // At least one contactable channel — a student we cannot reach cannot be
    // sent a fee reminder, which is the product's main revenue lever.
    if (phone.trim().isEmpty && (email ?? '').trim().isEmpty) {
      throw const DomainError(
        DomainErrorCode.contactChannelRequired,
        'At least one contact channel (phone or email) is required.',
      );
    }
    // `SM-INV-3` via the `SM-4.5b` fail-safe: a minor — or a record whose
    // minor status cannot be checked — requires a guardian.
    if (requiresGuardian && guardian == null) {
      throw const DomainError(
        DomainErrorCode.guardianRequiredForMinor,
        'A guardian is mandatory for minors, and for any record whose minor '
        'status is unknown (SM-4.5b fail-safe).',
      );
    }
  }

  /// `SM-2.3` — `Active → Suspended`; reason required by the authority table.
  void suspend({
    required String actor,
    required DateTime at,
    required String reason,
  }) {
    if (status == EnrollmentStatus.archived) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'An archived record cannot be suspended (SM-2.10).',
      );
    }
    if (reason.trim().isEmpty) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'A suspension requires a reason (SM-2.3).',
      );
    }
    status = EnrollmentStatus.suspended;
    _appendStatus(
      StudentStatusChange(to: status, at: at, actor: actor, reason: reason),
    );
  }

  /// `SM-2.3` — `Inactive → Active` (no reason) and `Suspended → Active`
  /// (reason required). `SM-2.10`: archived records leave only via restore.
  void reactivate({required String actor, required DateTime at, String? reason}) {
    if (status == EnrollmentStatus.archived) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'An archived record cannot be reactivated; restore it (SM-2.10).',
      );
    }
    if (status == EnrollmentStatus.suspended &&
        (reason == null || reason.trim().isEmpty)) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'Reactivating a suspended student requires a reason (SM-2.3).',
      );
    }
    status = EnrollmentStatus.active;
    _appendStatus(
      StudentStatusChange(to: status, at: at, actor: actor, reason: reason),
    );
  }

  /// Invariant: cannot archive with an outstanding balance. The caller
  /// supplies the balance from BC-05 (edge E-09) — Enrollment does not read
  /// the fee ledger directly. `SM-2.3`: archive is a transition with actor and
  /// timestamp; `SM-3.14a` records `archivedAt`.
  void archive({
    required Money outstandingBalance,
    required String actor,
    required DateTime at,
  }) {
    if (outstandingBalance.isPositive) {
      throw DomainError(
        DomainErrorCode.cannotArchiveWithOpenDues,
        'Cannot archive $fullName — ${outstandingBalance.formatted} still outstanding.',
        context: {'balance': outstandingBalance.minorUnits},
      );
    }
    if (status == EnrollmentStatus.archived) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'The record is already archived.',
      );
    }
    status = EnrollmentStatus.archived;
    archivedAt = at;
    _appendStatus(
      StudentStatusChange(to: status, at: at, actor: actor),
    );
  }

  /// `SM-2.3` — `Archived → Active`, **TR-1 only** (owner); the use case
  /// enforces that through the PDP. Restoring appends history; the audit
  /// entry is the `SM-EV-2` the use case emits.
  void restore({required String actor, required DateTime at}) {
    if (status != EnrollmentStatus.archived) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'Only an archived record can be restored (SM-2.3).',
      );
    }
    status = EnrollmentStatus.active;
    archivedAt = null;
    _appendStatus(
      StudentStatusChange(to: status, at: at, actor: actor, reason: 'restore'),
    );
  }
}
