/// E-11 — Account resolution port.
///
/// Resolution of an `AccountId` to its associated person identity and roles.
///
/// **Port direction**: `BC-01 Enrollment` → `BC-18 Identity & Access` (E-11).
///
/// **Purpose**: Enrollment must resolve an existing `AccountId` to obtain its
/// `PersonId` and tenant-scoped roles, without creating or mutating accounts.
/// AccountCreation (new accounts) is `AR-2`, this port is `AR-6` — resolution.
library;

import '../value_objects/identifiers.dart';

/// The output of resolving an AccountId — the data needed for enrollment.
///
/// Carries the global person identity and the tenant-scoped roles that
/// enrollment needs. The role set is keyed by tenant-id.
final class AccountInfo {
  const AccountInfo({
    required this.personId,
    required this.rolesByTenant,
  });

  /// The global person identity tied to this account.
  final PersonId personId;

  /// Tenant-scoped role assignments: tenantId → roles held there.
  final Map<String, Set<String>> rolesByTenant;

  /// Roles held in a specific tenant. Empty if no roles.
  Set<String> rolesIn(TenantId tenant) =>
      rolesByTenant[tenant.value] ?? const {};
}

/// Resolves an account by its globally-unique identifier.
abstract interface class AccountResolution {
  /// Resolve [accountId] to its `PersonId` and tenant-scoped roles.
  ///
  /// Returns `null` if the account does not exist (fail-closed behavior).
  AccountInfo? byId(AccountId accountId);
}