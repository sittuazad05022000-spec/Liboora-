/// **Data Platform — R2**
///
/// Adapters for the `DurableKeyValueStore` port, plus the tenant-partitioned
/// store every repository is built on.
///
/// Domain code never sees these types — it depends only on the repository
/// interfaces each context declares. Swapping Hive for Firestore/Postgres is
/// an adapter change here, not a domain change.
///
/// **Why the codecs are not in this file.** Serialising a `StudentRecord`
/// requires importing `domain/library` (rank 8), and this module is rank 2.
/// Law **L4** — *"no capability may import a domain module, ever"* — forbids
/// it. The codecs therefore live in `bootstrap/`, the composition layer that
/// already lawfully knows both a port and its adapter. This module stays
/// entirely ignorant of what a row means, which is also what lets it persist
/// any aggregate without a change.
library;

import 'package:hive/hive.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

/// In-memory adapter for the durable port.
///
/// Not a stub: this is the correct adapter for tests and for any context with
/// no filesystem. It satisfies the whole contract except survival across a
/// process, which is exactly what a test wants.
final class InMemoryKeyValueStore implements DurableKeyValueStore {
  final Map<String, Map<String, String>> _namespaces = {};

  @override
  Map<String, String> readAll(String namespace) =>
      Map<String, String>.unmodifiable(
        _namespaces[namespace] ?? const <String, String>{},
      );

  @override
  void write(String namespace, String key, String value) =>
      _namespaces.putIfAbsent(namespace, () => <String, String>{})[key] = value;

  @override
  void delete(String namespace, String key) =>
      _namespaces[namespace]?.remove(key);
}

/// Hive-backed adapter — the durable one.
///
/// **Why a single box rather than one box per aggregate.** Hive boxes are
/// opened asynchronously, and the port is synchronous by design (see its
/// library note). One box opened once at boot keeps every subsequent write
/// synchronous. The `namespace` becomes part of the composite Hive key, so the
/// six aggregates remain cleanly separable without six open handles.
///
/// **Why the namespace is a key prefix and not a concern of the caller.** The
/// composite key is built here, in one expression, so no call site can
/// assemble a key incorrectly. Note that the tenant is *already* inside the
/// key by the time it arrives: `TenantPartitionedStore` composes it. This
/// adapter never reads `TenantContext`, which is what allows [readAll] to work
/// at boot when no tenant is in scope yet.
final class HiveKeyValueStore implements DurableKeyValueStore {
  HiveKeyValueStore(this._box);

  /// Opens the backing box. Called once, at the composition root.
  ///
  /// [boxName] is a parameter rather than a constant so a test can open an
  /// isolated box instead of colliding with the application's.
  static Future<HiveKeyValueStore> open(String boxName) async =>
      HiveKeyValueStore(await Hive.openBox<String>(boxName));

  final Box<String> _box;

  /// `<namespace>::<key>`. The separator is two colons so a single colon
  /// inside an identifier can never be mistaken for a namespace boundary.
  static String _composite(String namespace, String key) =>
      '$namespace::$key';

  static const String _separator = '::';

  @override
  Map<String, String> readAll(String namespace) {
    final prefix = '$namespace$_separator';
    final result = <String, String>{};
    for (final key in _box.keys) {
      if (key is! String || !key.startsWith(prefix)) continue;
      final value = _box.get(key);
      if (value != null) result[key.substring(prefix.length)] = value;
    }
    return result;
  }

  @override
  void write(String namespace, String key, String value) {
    // Deliberately not awaited. Hive applies the write to its in-memory view
    // synchronously and flushes to disk in the background, so a subsequent
    // read is already correct. Awaiting here would force every repository
    // `save` to become async and push a Future into the domain (law L3).
    _box.put(_composite(namespace, key), value);
  }

  @override
  void delete(String namespace, String key) =>
      _box.delete(_composite(namespace, key));
}

/// Tenant-partitioned key-value store.
///
/// Every key is namespaced by tenant *inside the store*, not by convention at
/// the call site. This makes forbidden edge X-13 (tenant-less key) structurally
/// impossible for anything built on top of it.
///
/// **Durability.** When a [durable] store and a [codec] are supplied, every
/// mutation is written through and [restore] repopulates the partitions at
/// boot. Without them the store behaves exactly as it always did, in memory
/// only — which keeps every existing test and any container that wants an
/// ephemeral world working unchanged.
final class TenantPartitionedStore<T> {
  TenantPartitionedStore(
    this._tenantContext, {
    DurableKeyValueStore? durable,
    String? namespace,
    StoreEncode<T>? encode,
    StoreDecode<T>? decode,
  }) : _durable = durable,
       _namespace = namespace,
       _encode = encode,
       _decode = decode {
    // A half-configured store would silently drop writes, which is worse than
    // not persisting at all because it looks durable. Fail at construction.
    final configured = [
      durable,
      namespace,
      encode,
      decode,
    ].where((x) => x != null);
    if (configured.isNotEmpty && configured.length != 4) {
      throw ArgumentError(
        'Durable persistence needs all of durable, namespace, encode and '
        'decode. Supplying some but not all would drop writes silently.',
      );
    }
  }

  final TenantContext _tenantContext;
  final Map<String, Map<String, T>> _partitions = {};

  final DurableKeyValueStore? _durable;
  final String? _namespace;
  final StoreEncode<T>? _encode;
  final StoreDecode<T>? _decode;

  /// True when this store writes through to durable storage.
  bool get isDurable => _durable != null;

  Map<String, T> get _partition {
    // Throws TenantContextMissing if unset — fail loud, never default.
    final key = _tenantContext.tenantId.value;
    return _partitions.putIfAbsent(key, () => <String, T>{});
  }

  /// The durable key: tenant first, so a prefix scan is a tenant scan.
  ///
  /// Reads `tenantId` through the same getter as [_partition], so writing to
  /// durable storage with no tenant in scope throws `TenantContextMissing`
  /// exactly like an in-memory write does. Durability does not open a
  /// side-channel around the tenant guard.
  String _durableKey(String id) => '${_tenantContext.tenantId.value}::$id';

  T? get(String id) => _partition[id];

  void put(String id, T value) {
    _partition[id] = value;
    final durable = _durable;
    final encode = _encode;
    if (durable != null && encode != null) {
      durable.write(_namespace!, _durableKey(id), encode(value));
    }
  }

  void remove(String id) {
    _partition.remove(id);
    final durable = _durable;
    if (durable != null) durable.delete(_namespace!, _durableKey(id));
  }

  List<T> all() => _partition.values.toList(growable: false);

  List<T> where(bool Function(T) predicate) =>
      _partition.values.where(predicate).toList(growable: false);

  int get count => _partition.length;

  /// Test-only: total rows across all tenants. Used by the cross-tenant leak
  /// suite to assert that a tenant-scoped query never sees the global count.
  int get countAcrossAllTenants =>
      _partitions.values.fold(0, (sum, p) => sum + p.length);

  /// Repopulate every tenant partition from durable storage.
  ///
  /// Called once at boot, **before** any tenant scope is entered — which is
  /// why it reads through [DurableKeyValueStore.readAll] (tenant-agnostic)
  /// rather than through [_partition]. Requiring a tenant here would make
  /// restore impossible, since the tenant is only known after sign-in.
  ///
  /// A row that cannot be decoded is **skipped, not guessed**. One corrupt
  /// value must not prevent the rest of a library's data from loading, and
  /// substituting a default would invent business data.
  ///
  /// Returns the number of rows restored, so the caller can decide whether to
  /// seed rather than having to ask a second question.
  int restore() {
    final durable = _durable;
    final decode = _decode;
    if (durable == null || decode == null) return 0;

    var restored = 0;
    for (final entry in durable.readAll(_namespace!).entries) {
      final split = entry.key.indexOf('::');
      if (split <= 0) continue; // Not a tenant-scoped key; ignore.
      final tenant = entry.key.substring(0, split);
      final id = entry.key.substring(split + 2);
      if (id.isEmpty) continue;

      final T value;
      try {
        value = decode(entry.value);
      } catch (_) {
        continue; // Skip the unreadable row; never fabricate one.
      }
      _partitions.putIfAbsent(tenant, () => <String, T>{})[id] = value;
      restored++;
    }
    return restored;
  }
}

/// Translates one aggregate to and from the opaque string the durable store
/// holds.
///
/// **Deliberately function types, not an interface.** Six aggregates need six
/// translations, and an `abstract interface class StoreCodec<T>` would declare
/// a *port* with six adapters registered at the composition root — which
/// `no_orphan_ports_test` correctly rejects as ambiguous registration, because
/// its scan strips generics and cannot tell `StoreCodec<StudentRecord>` from
/// `StoreCodec<Membership>`.
///
/// The rule is right and the design was wrong: a store does not need an
/// object with two methods, it needs two functions. Expressing that directly
/// removes the ambiguity instead of waiving it, and the implementations still
/// live in `bootstrap/` because naming a domain type here would breach law L4.
typedef StoreEncode<T> = String Function(T value);
typedef StoreDecode<T> = T Function(String raw);
