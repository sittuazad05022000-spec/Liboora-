/// LIBOORA Shared Kernel (R0) — Error taxonomy.
library;

/// Machine-readable error codes.
///
/// Every invariant violation in the domain maps to one of these. Codes are
/// part of the published API contract: the mobile client, the BFF and the
/// support tooling all switch on them, so they are additive-only.
enum DomainErrorCode {
  // ── Generic ─────────────────────────────────────────────
  notFound,
  validationFailed,
  conflict,
  forbidden,

  // ── Multi-tenancy (BC-19) ───────────────────────────────
  tenantContextMissing,
  tenantSuspended,
  crossTenantAccess,

  // ── Entitlement (BC-21) ─────────────────────────────────
  entitlementExceeded,
  featureNotEnabled,

  // ── Enrollment (BC-01) ──────────────────────────────────
  duplicateEnrollmentNumber,
  guardianRequiredForMinor,
  contactChannelRequired,
  cannotArchiveWithOpenDues,

  // ── Membership (BC-02) ──────────────────────────────────
  overlappingMembershipTerm,
  membershipNotActive,
  freezeAllowanceExceeded,

  // ── Attendance (BC-03) ──────────────────────────────────
  alreadyCheckedIn,
  notCheckedIn,
  checkOutBeforeCheckIn,
  outsideWorkingHours,
  verificationFailed,

  // ── Seating (BC-04) ─────────────────────────────────────
  seatAlreadyOccupied,
  seatNotAvailable,
  membershipRequiredForSeat,
  seatQuotaExceeded,

  // ── Fee (BC-05) ─────────────────────────────────────────
  refundExceedsReceipts,
  discountRequiresApproval,
  receiptImmutable,
}

/// Base type for every expected, modelled failure.
///
/// A `DomainError` is a *business outcome*, not a bug. Bugs throw
/// [StateError]/[AssertionError]; domain errors are returned or thrown and
/// then rendered to the user. The distinction matters: domain errors must
/// never page an on-call engineer.
class DomainError implements Exception {
  const DomainError(this.code, this.message, {this.context = const {}});

  final DomainErrorCode code;

  /// Operator-facing message. Safe to display; contains no PII beyond what
  /// the actor already sees on screen.
  final String message;

  /// Structured detail for logs and telemetry.
  final Map<String, Object?> context;

  @override
  String toString() => 'DomainError(${code.name}): $message';
}

/// Thrown when tenant context is absent.
///
/// Deliberately fatal rather than defaulting: silently defaulting the tenant
/// is the root cause of the highest-severity failure class in the system
/// (cross-tenant leak, forbidden edge X-13).
class TenantContextMissing extends DomainError {
  const TenantContextMissing()
    : super(
        DomainErrorCode.tenantContextMissing,
        'No tenant in scope. TenantContext must be established at the '
        'request/route boundary before any repository access.',
      );
}
