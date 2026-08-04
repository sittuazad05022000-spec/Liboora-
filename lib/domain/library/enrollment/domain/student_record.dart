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
library;

import 'package:liboora_contracts/liboora_contracts.dart';

/// Independent of `MembershipStatus`. A student can be Active with an Expired
/// membership — two separate state machines (ubiquitous language table).
enum EnrollmentStatus { active, inactive, suspended, archived }

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

final class StudentRecord {
  StudentRecord({
    required this.id,
    required this.enrollmentNumber,
    required this.fullName,
    required this.phone,
    required this.dateOfBirth,
    required this.enrolledOn,
    this.email,
    this.guardian,
    required this.personId,
    this.status = EnrollmentStatus.active,
    this.photoRef,
  }) {
    _assertInvariants();
  }

  final StudentRecordId id;
  final String enrollmentNumber;
  String fullName;
  String phone;
  String? email;
  final DateTime dateOfBirth;
  final DateTime enrolledOn;
  GuardianLink? guardian;

  /// The person this record is a library-scoped view of.
  ///
  /// **Non-nullable** (`ID-4`, `SID-4.17`): a Global Person Identity now always
  /// exists, so there is no "unlinked student" state to degrade into. This is a
  /// downward reference to rank 7.5 — the record points at the person, never the
  /// reverse (`SID-INV-8`).
  final PersonId personId;

  EnrollmentStatus status;
  FileRef? photoRef;

  int ageOn(DateTime when) {
    var age = when.year - dateOfBirth.year;
    if (when.month < dateOfBirth.month ||
        (when.month == dateOfBirth.month && when.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  bool isMinorOn(DateTime when) => ageOn(when) < 18;

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
    if (isMinorOn(enrolledOn) && guardian == null) {
      throw const DomainError(
        DomainErrorCode.guardianRequiredForMinor,
        'A guardian is mandatory for students under 18.',
      );
    }
  }

  void suspend() => status = EnrollmentStatus.suspended;
  void reactivate() => status = EnrollmentStatus.active;

  /// Invariant: cannot archive with an outstanding balance. The caller
  /// supplies the balance from BC-05 (edge E-09) — Enrollment does not read
  /// the fee ledger directly.
  void archive({required Money outstandingBalance}) {
    if (outstandingBalance.isPositive) {
      throw DomainError(
        DomainErrorCode.cannotArchiveWithOpenDues,
        'Cannot archive $fullName — ${outstandingBalance.formatted} still outstanding.',
        context: {'balance': outstandingBalance.minorUnits},
      );
    }
    status = EnrollmentStatus.archived;
  }
}
