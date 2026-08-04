/// Liboora Shared Kernel (R0) — Global Person Identity creation port.
library;

import '../value_objects/identifiers.dart';

/// Creates the Global Person Identity that must accompany every account.
///
/// **Why this interface lives in the shared kernel (R0).**
///
/// `ADR-0011` places Global Person Identity at rank **7.5**, while
/// Identity & Access (`BC-18`) is rank **4**. `BC-18` is nevertheless the only
/// context that may cause an identity to come into existence, and it must do so
/// *synchronously, in the same unit of work* as account creation — creation is
/// explicitly **not** event-driven, because an event would open a window in
/// which an account exists without an identity (`SID-4.11`, `SID-4.12`,
/// `SID-INV-2`).
///
/// A direct call from rank 4 to rank 7.5 would be an **upward** dependency,
/// forbidden by law **L2**, and a capability importing a domain module is
/// forbidden by law **L4**. The resolution is dependency inversion, exactly as
/// used for [Clock] and [IdGenerator]: the *interface* sits at rank 0 where
/// everything may depend on it, the *implementation* sits in `domain/person`,
/// and the two are joined at the composition root.
///
/// This keeps every law intact — no exception was added to any of them.
abstract interface class PersonIdentityFactory {
  /// Create the identity for [account] and return its [PersonId].
  ///
  /// Contract:
  ///   * Exactly one identity per account — never zero, never two
  ///     (`SID-INV-1`). A second call for the same account is a programming
  ///     error, not a business outcome.
  ///   * The [PersonId] is generated here and **never** supplied by a caller
  ///     (`SID-3.5`).
  ///   * Throwing **must** fail the surrounding account creation. Partial
  ///     identities are never persisted (`SID-3.9`, `SID-AC-1`).
  ///   * [displayName] is the name already collected by registration. The
  ///     verified mobile number is deliberately **not** a parameter: the
  ///     identity module may never receive, store or index it (`SID-4.13`,
  ///     `SID-INV-5`, `SXC-1`).
  PersonId createFor({required AccountId account, required String displayName});
}
