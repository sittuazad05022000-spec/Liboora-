/// **Tenancy Platform — R4** (BC-19)
///
/// Owns the tenant record and the ambient tenant scope. Cycle-breaking
/// pattern §8.3: the *interface* lives in R0; the writable holder lives here
/// and is only mutated at the composition root.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

enum TenantTier { starter, growth, pro }

final class Tenant {
  const Tenant({
    required this.id,
    required this.name,
    required this.tier,
    required this.branches,
    this.suspended = false,
  });

  final TenantId id;
  final String name;
  final TenantTier tier;
  final List<Branch> branches;
  final bool suspended;
}

final class Branch {
  const Branch({required this.id, required this.name, required this.address});

  final BranchId id;
  final String name;
  final String address;
}

/// Mutable holder. The setter is deliberately NOT exported through any barrel
/// consumed by domain code — only `bootstrap/` may call [enter].
final class MutableTenantContext implements TenantContext {
  TenantId? _tenantId;
  BranchId? _branchId;
  String? _actorId;
  String _correlationId = 'boot';

  void enter({
    required TenantId tenant,
    required BranchId branch,
    String? actor,
    required String correlationId,
  }) {
    _tenantId = tenant;
    _branchId = branch;
    _actorId = actor;
    _correlationId = correlationId;
  }

  void exit() {
    _tenantId = null;
    _branchId = null;
    _actorId = null;
  }

  @override
  TenantId get tenantId {
    final t = _tenantId;
    // Rule: never default. A silent default is how cross-tenant leaks happen.
    if (t == null) throw const TenantContextMissing();
    return t;
  }

  @override
  BranchId get branchId {
    final b = _branchId;
    if (b == null) throw const TenantContextMissing();
    return b;
  }

  @override
  String? get actorId => _actorId;

  @override
  bool get hasTenant => _tenantId != null;

  @override
  String get correlationId => _correlationId;
}
