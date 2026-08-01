/// LIBOORA Shared Kernel (R0) — Identifiers.
///
/// Implements the **Identity Triad** from LIBOORA_BOUNDED_CONTEXT_MAP.md §4.
/// These three ids are deliberately distinct types so the compiler enforces
/// what a code review would otherwise have to catch by eye.
library;

/// Base for all strongly-typed identifiers.
///
/// Using a class per id (rather than `String`) makes rules ID-2 and ID-3
/// mechanically enforceable: a `StudentRecordId` simply cannot be passed
/// where a `PersonId` is expected.
abstract base class Identifier {
  const Identifier(this.value);

  final String value;

  bool get isValid => value.trim().isNotEmpty;

  @override
  String toString() => '$runtimeType($value)';

  @override
  bool operator ==(Object other) =>
      other is Identifier &&
      other.runtimeType == runtimeType &&
      other.value == value;

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

/// The tenant (library organisation). Owned by BC-19 Tenancy.
///
/// Mandatory on every row, event, cache key, index name and storage prefix
/// in the tenant-scoped half of the system. See forbidden edge X-13.
final class TenantId extends Identifier {
  const TenantId(super.value);
}

/// A physical branch within a tenant. Owned by BC-06 Library Policy.
///
/// Modelled in V1 even though Multi-Branch is a V3 feature — see open
/// question Q-02. Retrofitting this later is a migration across every
/// tenant-scoped table.
final class BranchId extends Identifier {
  const BranchId(super.value);
}

/// Credentials-only identity. Owned by BC-18 Identity & Access.
///
/// Global, cross-tenant. Created on first successful OTP verification.
final class AccountId extends Identifier {
  const AccountId(super.value);
}

/// The cross-library social persona. Owned by BC-10 Global Student Identity.
///
/// Global, cross-tenant. **May legitimately not exist** — a student who only
/// ever uses the library never gets one.
final class PersonId extends Identifier {
  const PersonId(super.value);
}

/// A person *as a student of one specific library*. Owned by BC-01 Enrollment.
///
/// ALWAYS tenant-scoped. One human enrolled at three libraries has three of
/// these. Rule ID-2: this id must never leave its tenant, and must never
/// appear in any social context, event or search index.
final class StudentRecordId extends Identifier {
  const StudentRecordId(super.value);
}

// ══════════════════════════════════════════════════════════════════════
// AMENDMENT A-8 — Identity & Access (BC-18) identities.
//
// These four were referenced as stable identities by the locked session,
// device, invitation and permission registers but had no type. Untyped, they
// degrade to `String` at every boundary, which is exactly how a SessionId ends
// up in a log line or a DeviceId in a cache key without a tenant prefix
// (X-13). Typing them makes those mistakes non-compiling rather than
// non-reviewed.
// ══════════════════════════════════════════════════════════════════════

/// A registered device association. Owned by BC-18 Identity & Access.
///
/// Global, like the account: one device may serve many tenants over time
/// (the shared reception-terminal pattern). Never a behavioural profile key.
final class DeviceId extends Identifier {
  const DeviceId(super.value);
}

/// An authenticated session. Owned by BC-18 Identity & Access.
///
/// Opaque and non-guessable. Never a log dimension, never a metric dimension
/// (OBS-1110), and never derived from any subject attribute.
final class SessionId extends Identifier {
  const SessionId(super.value);
}

/// An invitation to claim an account. Owned by BC-18 Identity & Access.
///
/// Single-use and time-bounded. Distinct from the account it will resolve to,
/// so that possession of an invitation never proves possession of a number.
final class InviteId extends Identifier {
  const InviteId(super.value);
}

/// A permission in the **closed** catalogue. Owned by BC-18 Identity & Access.
///
/// Typed so that a permission cannot be constructed from arbitrary input at a
/// call site: the catalogue is closed, and a closed catalogue that accepts a
/// `String` is not closed.
final class PermissionId extends Identifier {
  const PermissionId(super.value);
}

/// Idempotency key for at-most-once semantics at every boundary.
///
/// Required by: API edge, attendance check-in, payment capture, workflow
/// steps and every event consumer.
final class IdempotencyKey extends Identifier {
  const IdempotencyKey(super.value);
}

/// Opaque reference to a stored file. Owned by BC-29 File & Media.
///
/// The domain holds this — never bytes, never a raw storage path, never a URL.
final class FileRef extends Identifier {
  const FileRef(super.value);
}
