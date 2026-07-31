/// **Business Platform — R6** (BC-20 Subscription & Billing, BC-21 Entitlement)
///
/// Careful: the money here is **library → Liboora** (`SubscriptionCharge`).
/// Money from **student → library** is `FeePayment` and belongs to BC-05.
/// Two different domains that happen to share the word "payment".
library;

import 'package:liboora_contracts/liboora_contracts.dart';

import '../tenancy/tenancy.dart';

enum Feature { students, seats, branches, aiInsights, advancedReports }

/// Single source of truth for "is tenant T allowed to do X, and how much is
/// left". Consulted before every gated write.
///
/// Derived state only — rebuildable from Subscription events (X-11).
final class EntitlementService {
  EntitlementService(this._tenantContext);

  final TenantContext _tenantContext;
  final Map<String, TenantTier> _tiers = {};
  final Map<String, int> _usage = {};

  static const Map<TenantTier, Map<Feature, int>> _limits = {
    TenantTier.starter: {
      Feature.students: 50,
      Feature.seats: 25,
      Feature.branches: 1,
    },
    TenantTier.growth: {
      Feature.students: 300,
      Feature.seats: 150,
      Feature.branches: 3,
    },
    TenantTier.pro: {
      Feature.students: -1,
      Feature.seats: -1,
      Feature.branches: -1,
    },
  };

  static const Map<TenantTier, Set<Feature>> _gates = {
    TenantTier.starter: {},
    TenantTier.growth: {Feature.advancedReports},
    TenantTier.pro: {Feature.advancedReports, Feature.aiInsights},
  };

  void registerTenant(TenantId id, TenantTier tier) => _tiers[id.value] = tier;

  TenantTier get _tier =>
      _tiers[_tenantContext.tenantId.value] ?? TenantTier.starter;

  /// -1 means unlimited.
  int limitFor(Feature f) => _limits[_tier]?[f] ?? -1;

  int usageOf(Feature f) =>
      _usage['${_tenantContext.tenantId.value}:${f.name}'] ?? 0;

  bool isEnabled(Feature f) => _gates[_tier]?.contains(f) ?? false;

  int? remaining(Feature f) {
    final limit = limitFor(f);
    if (limit < 0) return null; // unlimited
    return limit - usageOf(f);
  }

  /// Called BEFORE the aggregate mutates. Throws on breach.
  void check(Feature f, {int delta = 1}) {
    final limit = limitFor(f);
    if (limit < 0) return;
    if (usageOf(f) + delta > limit) {
      throw DomainError(
        DomainErrorCode.entitlementExceeded,
        'Your ${_tier.name} plan allows $limit ${f.name}. '
        'Upgrade to add more.',
        context: {'feature': f.name, 'limit': limit, 'tier': _tier.name},
      );
    }
  }

  void requireFeature(Feature f) {
    if (!isEnabled(f)) {
      throw DomainError(
        DomainErrorCode.featureNotEnabled,
        '${f.name} is not available on the ${_tier.name} plan.',
        context: {'feature': f.name, 'tier': _tier.name},
      );
    }
  }

  void recordUsage(Feature f, int delta) {
    final key = '${_tenantContext.tenantId.value}:${f.name}';
    _usage[key] = (_usage[key] ?? 0) + delta;
  }
}
