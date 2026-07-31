/// **Data Platform — R2**
///
/// In-memory adapter for the V1 scaffold. Domain code never sees this type —
/// it depends only on the repository interfaces each context declares.
/// Swapping to Firestore/Postgres is an adapter change, not a domain change.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

/// Tenant-partitioned key-value store.
///
/// Every key is namespaced by tenant *inside the store*, not by convention at
/// the call site. This makes forbidden edge X-13 (tenant-less key) structurally
/// impossible for anything built on top of it.
final class TenantPartitionedStore<T> {
  TenantPartitionedStore(this._tenantContext);

  final TenantContext _tenantContext;
  final Map<String, Map<String, T>> _partitions = {};

  Map<String, T> get _partition {
    // Throws TenantContextMissing if unset — fail loud, never default.
    final key = _tenantContext.tenantId.value;
    return _partitions.putIfAbsent(key, () => <String, T>{});
  }

  T? get(String id) => _partition[id];

  void put(String id, T value) => _partition[id] = value;

  void remove(String id) => _partition.remove(id);

  List<T> all() => _partition.values.toList(growable: false);

  List<T> where(bool Function(T) predicate) =>
      _partition.values.where(predicate).toList(growable: false);

  int get count => _partition.length;

  /// Test-only: total rows across all tenants. Used by the cross-tenant leak
  /// suite to assert that a tenant-scoped query never sees the global count.
  int get countAcrossAllTenants =>
      _partitions.values.fold(0, (sum, p) => sum + p.length);
}
