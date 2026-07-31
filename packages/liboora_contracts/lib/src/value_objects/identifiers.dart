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
