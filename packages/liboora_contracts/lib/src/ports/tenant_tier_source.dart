/// Liboora Shared Kernel (R0) — Tenant tier source port.
///
/// Platform/business (BC-21 Entitlement) needs the current tenant's tier
/// to enforce feature gates and usage limits, but must not directly
/// import platform/tenancy. This port breaks that dependency: the
/// composition root wires the concrete TenantTierSource.
library;

import '../value_objects/identifiers.dart';

enum TenantTier { starter, growth, pro }

abstract interface class TenantTierSource {
  TenantTier tenantTierFor(TenantId tenant);
}
