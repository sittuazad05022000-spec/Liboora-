/// **Tenancy Platform — R4** (BC-19)
///
/// Owns the tenant record and the ambient tenant scope. Cycle-breaking
/// pattern §8.3: the *interface* lives in R0; the writable holder lives here
/// and is only mutated at the composition root.
///
/// **IMPL-800 (`TEN-FR-001`, `TEN-FR-003`) and IMPL-801 (`TEN-FR-004`).**
///
/// `Tenant` is the **only** aggregate root here, and this module owns **no
/// tenant-facing business record beyond it**. That is not a style preference:
/// `TEN-FR-003` forbids the second record and `TEN-FR-004` forbids the second
/// root, and Bounded Context Map §8 L381 lists `Tenant`'s value objects as
/// `TenantTier`, `Quota`, `ResidencyRegion`, `TenantLifecycleState` — with no
/// `Branch` among them.
///
/// **Why `Branch` is not here, and must not come back.** A `Branch` class
/// lived in this file from commit `a44ebb0` (written before `PRD-013`
/// existed) until `IMPL-801` removed it, carrying `name` and `address` — a
/// physical-location record. Bounded Context Map L210 assigns `Branch` to
/// **BC-06 Library Policy**, `PRD-002` L56 defines it, and `ADR-0050` §3.1
/// recorded the misplacement as code defect `D-013-01`, holding that
/// ownership *"is not in doubt"* and the fix is a Stage-8 act. It now lives
/// at `domain/library/policy` as a read record behind `BranchReader`.
///
/// ⛔ Re-adding it would be an upward dependency as well as a boundary
/// breach: this module is **rank 4** and `domain/library` is **rank 8**, so
/// naming that type here would violate law **L2** and the
/// `banned_imports: ["domain/**"]` rule below. `BranchId` is deliberately
/// still used — it is a **rank-0** contract (`liboora_contracts`), which is
/// why tenant context can carry a branch without this module knowing what a
/// branch *is*.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

enum TenantTier { starter, growth, pro }

/// The tenant (library organisation). BC-19's sole aggregate root.
///
/// `TEN-FR-004`: nothing else in this module is an aggregate root.
/// `TEN-FR-003`: it holds no other tenant-facing business record — in
/// particular no branch list. A caller that needs branch display data asks
/// BC-06 for it; see `BranchReader` in `domain/library/policy`.
final class Tenant {
  const Tenant({
    required this.id,
    required this.name,
    required this.tier,
    this.suspended = false,
  });

  final TenantId id;
  final String name;
  final TenantTier tier;
  final bool suspended;
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
