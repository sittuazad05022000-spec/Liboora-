/// **Business Platform — R6** (BC-20 Subscription & Billing, BC-21 Entitlement)
///
/// Careful: the money here is **library → Liboora** (`SubscriptionCharge`).
/// Money from **student → library** is `FeePayment` and belongs to BC-05.
/// Two different domains that happen to share the word "payment".
library;

import 'package:liboora_contracts/liboora_contracts.dart';

enum Feature { students, seats, branches, aiInsights, advancedReports }

/// Business-owned tier vocabulary. ADR-0012 wave 1: the direct
/// `platform/business -> platform/tenancy` import existed only to name
/// tenancy's enum; that waiver lapsed 2026-10-31, so the tier is named here
/// and the composition root (or seed wiring) adapts tenancy's value.
enum PlanTier { starter, growth, pro }

/// One-method consumer port (ADR-0012 wave 1): resolves the tier a tenant is
/// registered at. Tenancy is never imported for it.
abstract interface class TenantTierSource {
  PlanTier tierOf(TenantId tenantId);
}

/// Default source: the registry `registerTenant` populates, so existing
/// bootstrap/seed call sites keep working unchanged.
final class RegisteredTierSource implements TenantTierSource {
  final Map<String, PlanTier> _tiers = {};

  void register(TenantId id, PlanTier tier) => _tiers[id.value] = tier;

  @override
  PlanTier tierOf(TenantId id) => _tiers[id.value] ?? PlanTier.starter;
}

/// Single source of truth for "is tenant T allowed to do X, and how much is
/// left". Consulted before every gated write.
///
/// Derived state only — rebuildable from Subscription events (X-11).
final class EntitlementService {
  EntitlementService(this._tenantContext, {TenantTierSource? tierSource})
    : _tierSource = tierSource ?? RegisteredTierSource();

  final TenantContext _tenantContext;
  final TenantTierSource _tierSource;
  final Map<String, int> _usage = {};

  static const Map<PlanTier, Map<Feature, int>> _limits = {
    PlanTier.starter: {
      Feature.students: 50,
      Feature.seats: 25,
      Feature.branches: 1,
    },
    PlanTier.growth: {
      Feature.students: 300,
      Feature.seats: 150,
      Feature.branches: 3,
    },
    PlanTier.pro: {
      Feature.students: -1,
      Feature.seats: -1,
      Feature.branches: -1,
    },
  };

  static const Map<PlanTier, Set<Feature>> _gates = {
    PlanTier.starter: {},
    PlanTier.growth: {Feature.advancedReports},
    PlanTier.pro: {Feature.advancedReports, Feature.aiInsights},
  };

  void registerTenant(TenantId id, PlanTier tier) {
    final source = _tierSource;
    if (source is! RegisteredTierSource) {
      throw StateError(
        'tier source is read-only; registering tiers is a '
        'composition-root concern',
      );
    }
    source.register(id, tier);
  }

  PlanTier get _tier => _tierSource.tierOf(_tenantContext.tenantId);

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
