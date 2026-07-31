/// Liboora Shared Kernel (R0) — Tenant context port.
library;

import '../errors/domain_error.dart';
import 'identifiers_export.dart';

/// Ambient multi-tenant scope.
///
/// This is the `◇*` exception in the dependency matrix: rank R2 (row-level
/// security) needs the tenant, but it is established at rank R9 (the request
/// edge). A downward import would violate law L2, so the *interface* lives
/// here in R0 and everyone reads it.
///
/// Three constraints keep this from degrading into a global variable:
///  1. Read-only outside the composition root — no exported setter.
///  2. Reading it unset **throws** [TenantContextMissing]. It never defaults.
///  3. It is never passed as a domain method parameter — that would leak
///     infrastructure into the domain signature.
abstract interface class TenantContext {
  /// Throws [TenantContextMissing] when no tenant is in scope.
  TenantId get tenantId;

  BranchId get branchId;

  /// Current actor, for audit attribution.
  String? get actorId;

  bool get hasTenant;

  /// Ties every downstream effect back to one user action.
  String get correlationId;
}
