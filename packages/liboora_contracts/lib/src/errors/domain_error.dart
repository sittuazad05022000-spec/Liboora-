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

  // ══════════════════════════════════════════════════════════════════
  // AMENDMENT A-1 — Identity & Access (BC-18)
  //
  // Appended, never interleaved: this enum is additive-only because clients
  // switch on it. Internal classification per ERR-1110..ERR-1116; every code
  // below declares an external projection via [DomainErrorCodeProjection]
  // (amendment A-7).
  //
  // These codes are the INTERNAL plane. They are never emitted to a caller
  // outside the module — only their `externalOutcome` is. See ERR-1101/1102.
  // ══════════════════════════════════════════════════════════════════

  // ── ERR-1110 class AUTH — possession proof ──────────────
  authChallengeNotIssued,
  authChallengeInvalid,
  authChallengeExpired,
  authChallengeConsumed,
  authAttemptBudgetExhausted,
  authPossessionProofIncomplete,

  // ── ERR-1111 class AUTHZ — decision ─────────────────────
  authzNoRoleGrantsPermission,
  authzConditionNarrowedToNone,
  authzScopeOutsideSubject,
  authzPermissionNotInCatalogue,
  authzEntitlementGateRefused,

  // ── ERR-1112 class SESSION ──────────────────────────────
  sessionAbsent,
  sessionUnknown,
  sessionRevoked,
  sessionExpired,
  sessionKindMismatch,
  sessionBindingUnsatisfied,
  sessionOfflineGraceExhausted,
  sessionPrivilegedOperationOffline,

  // ── ERR-1113 class DEVICE ───────────────────────────────
  deviceCeilingReached,
  deviceNotPermittedForOperation,
  deviceStateInsufficient,
  deviceAssociationConflict,

  // ── ERR-1114 class LIFECYCLE ────────────────────────────
  lifecycleTransitionNotPermitted,
  lifecycleAuthorityInsufficient,
  lifecycleDualControlRequired,
  lifecycleClosureWindowElapsed,
  lifecycleErasurePreconditionUnmet,
  lifecycleAccountErased,

  // ── ERR-1115 class VALIDATION ───────────────────────────
  identifierTypeMismatch,
  idempotencyKeyReused,

  // ── ERR-1116 class SYSTEM ───────────────────────────────
  systemDependencyUnavailable,
  systemAuditCommitUnavailable,
  systemCapacityExceeded,
  systemOperationTimeout,
  systemInvariantViolation,
}

/// ERR-1130 — the **closed** external outcome set.
///
/// This is everything a caller outside the module may ever learn. The
/// projection from [DomainErrorCode] onto this enum is deliberately lossy
/// (ERR-1131) and is not configurable by any flag, header, tenant setting or
/// environment (ERR-1102).
///
/// `xNotFound` deliberately conflates "does not exist", "exists but you may
/// not know", and "exists and the reason is itself sensitive". That is the
/// required behaviour, not an ambiguity defect.
enum ExternalOutcome {
  /// The authentication attempt did not succeed. Nothing further.
  /// Subject to the PERF-1105 latency floor.
  xUniformAuth,

  /// The presented session cannot be used. Nothing further.
  xSessionInvalid,

  /// Refused, on a resource whose existence the caller already legitimately
  /// knows.
  xDenied,

  /// Nothing is asserted about existence. Mandatory for `self` and
  /// `guardianOf` scope (CON-1146, SBR-887/888).
  xNotFound,

  /// Not available in the current state, to an already-authorised caller.
  xNotPermitted,

  /// The request was not well formed.
  xInvalidRequest,

  /// May be attempted again later.
  xTemporaryFailure,
}

/// ERR-1110..ERR-1116 — the internal classification plane.
enum ErrorClass {
  auth,
  authz,
  session,
  device,
  lifecycle,
  validation,
  system,

  /// Outside the BC-18 taxonomy: business outcomes owned by other contexts.
  /// Present so the projection switch is exhaustive.
  domainBusiness,
}

/// **Amendment A-7** — the external projection as a declared, compile-time
/// property of every code rather than a convention observed at call sites.
///
/// The switches below are exhaustive over the enum. Adding a code therefore
/// *cannot compile* until its class and its external projection are declared,
/// which is precisely the structural guarantee A-7 requires.
extension DomainErrorCodeProjection on DomainErrorCode {
  /// Internal classification. For audit, telemetry and operator diagnosis.
  /// Never leaves the module.
  ErrorClass get errorClass => switch (this) {
    DomainErrorCode.authChallengeNotIssued ||
    DomainErrorCode.authChallengeInvalid ||
    DomainErrorCode.authChallengeExpired ||
    DomainErrorCode.authChallengeConsumed ||
    DomainErrorCode.authAttemptBudgetExhausted ||
    DomainErrorCode.authPossessionProofIncomplete => ErrorClass.auth,

    DomainErrorCode.authzNoRoleGrantsPermission ||
    DomainErrorCode.authzConditionNarrowedToNone ||
    DomainErrorCode.authzScopeOutsideSubject ||
    DomainErrorCode.authzPermissionNotInCatalogue ||
    DomainErrorCode.authzEntitlementGateRefused => ErrorClass.authz,

    DomainErrorCode.sessionAbsent ||
    DomainErrorCode.sessionUnknown ||
    DomainErrorCode.sessionRevoked ||
    DomainErrorCode.sessionExpired ||
    DomainErrorCode.sessionKindMismatch ||
    DomainErrorCode.sessionBindingUnsatisfied ||
    DomainErrorCode.sessionOfflineGraceExhausted ||
    DomainErrorCode.sessionPrivilegedOperationOffline => ErrorClass.session,

    DomainErrorCode.deviceCeilingReached ||
    DomainErrorCode.deviceNotPermittedForOperation ||
    DomainErrorCode.deviceStateInsufficient ||
    DomainErrorCode.deviceAssociationConflict => ErrorClass.device,

    DomainErrorCode.lifecycleTransitionNotPermitted ||
    DomainErrorCode.lifecycleAuthorityInsufficient ||
    DomainErrorCode.lifecycleDualControlRequired ||
    DomainErrorCode.lifecycleClosureWindowElapsed ||
    DomainErrorCode.lifecycleErasurePreconditionUnmet ||
    DomainErrorCode.lifecycleAccountErased => ErrorClass.lifecycle,

    DomainErrorCode.identifierTypeMismatch ||
    DomainErrorCode.idempotencyKeyReused ||
    DomainErrorCode.validationFailed ||
    DomainErrorCode.tenantContextMissing => ErrorClass.validation,

    DomainErrorCode.systemDependencyUnavailable ||
    DomainErrorCode.systemAuditCommitUnavailable ||
    DomainErrorCode.systemCapacityExceeded ||
    DomainErrorCode.systemOperationTimeout ||
    DomainErrorCode.systemInvariantViolation => ErrorClass.system,

    _ => ErrorClass.domainBusiness,
  };

  /// ERR-1130 projection. The only thing a caller outside the module sees.
  ExternalOutcome get externalOutcome => switch (this) {
    // ERR-1110 — every authentication condition is indistinguishable.
    DomainErrorCode.authChallengeNotIssued ||
    DomainErrorCode.authChallengeInvalid ||
    DomainErrorCode.authChallengeExpired ||
    DomainErrorCode.authChallengeConsumed ||
    DomainErrorCode.authAttemptBudgetExhausted ||
    DomainErrorCode.authPossessionProofIncomplete =>
      ExternalOutcome.xUniformAuth,

    // ERR-1112 — expiry, revocation and unknown are one outcome.
    DomainErrorCode.sessionAbsent ||
    DomainErrorCode.sessionUnknown ||
    DomainErrorCode.sessionRevoked ||
    DomainErrorCode.sessionExpired ||
    DomainErrorCode.sessionKindMismatch ||
    DomainErrorCode.sessionBindingUnsatisfied ||
    DomainErrorCode.sessionOfflineGraceExhausted ||
    DomainErrorCode.sessionPrivilegedOperationOffline =>
      ExternalOutcome.xSessionInvalid,

    // ERR-1111 — existence already known to the caller.
    DomainErrorCode.authzNoRoleGrantsPermission ||
    DomainErrorCode.authzConditionNarrowedToNone ||
    DomainErrorCode.authzPermissionNotInCatalogue ||
    DomainErrorCode.authzEntitlementGateRefused ||
    DomainErrorCode.forbidden => ExternalOutcome.xDenied,

    // ERR-1111 / CON-1146 — `self` and `guardianOf` are never disclosive.
    DomainErrorCode.authzScopeOutsideSubject ||
    DomainErrorCode.lifecycleAccountErased ||
    DomainErrorCode.crossTenantAccess ||
    DomainErrorCode.notFound => ExternalOutcome.xNotFound,

    // ERR-1114 / ERR-1113 — authorised caller, state or device refuses.
    DomainErrorCode.lifecycleTransitionNotPermitted ||
    DomainErrorCode.lifecycleAuthorityInsufficient ||
    DomainErrorCode.lifecycleDualControlRequired ||
    DomainErrorCode.lifecycleClosureWindowElapsed ||
    DomainErrorCode.lifecycleErasurePreconditionUnmet ||
    DomainErrorCode.deviceCeilingReached ||
    DomainErrorCode.deviceNotPermittedForOperation ||
    DomainErrorCode.deviceStateInsufficient ||
    DomainErrorCode.deviceAssociationConflict => ExternalOutcome.xNotPermitted,

    // ERR-1115.
    DomainErrorCode.identifierTypeMismatch ||
    DomainErrorCode.idempotencyKeyReused ||
    DomainErrorCode.validationFailed ||
    DomainErrorCode.tenantContextMissing ||
    DomainErrorCode.conflict => ExternalOutcome.xInvalidRequest,

    // ERR-1116 — transient; never projected as success (ERR-1116).
    DomainErrorCode.systemDependencyUnavailable ||
    DomainErrorCode.systemAuditCommitUnavailable ||
    DomainErrorCode.systemCapacityExceeded ||
    DomainErrorCode.systemOperationTimeout ||
    DomainErrorCode.systemInvariantViolation =>
      ExternalOutcome.xTemporaryFailure,

    // Codes owned by other contexts. Not part of the BC-18 disclosure
    // surface; projected by nearest equivalent so the switch is total.
    DomainErrorCode.tenantSuspended ||
    DomainErrorCode.entitlementExceeded ||
    DomainErrorCode.featureNotEnabled ||
    DomainErrorCode.cannotArchiveWithOpenDues ||
    DomainErrorCode.membershipNotActive ||
    DomainErrorCode.freezeAllowanceExceeded ||
    DomainErrorCode.alreadyCheckedIn ||
    DomainErrorCode.notCheckedIn ||
    DomainErrorCode.outsideWorkingHours ||
    DomainErrorCode.verificationFailed ||
    DomainErrorCode.seatAlreadyOccupied ||
    DomainErrorCode.seatNotAvailable ||
    DomainErrorCode.membershipRequiredForSeat ||
    DomainErrorCode.seatQuotaExceeded ||
    DomainErrorCode.discountRequiresApproval ||
    DomainErrorCode.receiptImmutable => ExternalOutcome.xNotPermitted,

    DomainErrorCode.duplicateEnrollmentNumber ||
    DomainErrorCode.guardianRequiredForMinor ||
    DomainErrorCode.contactChannelRequired ||
    DomainErrorCode.overlappingMembershipTerm ||
    DomainErrorCode.checkOutBeforeCheckIn ||
    DomainErrorCode.refundExceedsReceipts => ExternalOutcome.xInvalidRequest,
  };

  /// ERR-1135 — retriability is declared, never inferred.
  bool get isRetriable => errorClass == ErrorClass.system;
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

  /// ERR-1130 — what a caller outside the module is told. Amendment A-7.
  ExternalOutcome get externalOutcome => code.externalOutcome;

  /// ERR-1110..1116 — internal classification. Never leaves the module.
  ErrorClass get errorClass => code.errorClass;

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
