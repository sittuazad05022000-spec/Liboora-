/// Liboora Shared Kernel (R0) — Durable key-value store port.
///
/// **Why this port exists.**
///
/// `TenantPartitionedStore` held every row in a `Map`, so all tenant data and
/// the signed-in session were lost on every restart. The store's own doc
/// comment always anticipated the fix — *"swapping to Firestore/Postgres is an
/// adapter change, not a domain change"* — but no seam existed to swap
/// anything into.
///
/// This is that seam, and it deliberately sits at rank 0 for the same reason
/// [Clock] and [TenantContext] do: rank 2 needs durability, the technology
/// choice belongs to the composition root, and an interface in the shared
/// kernel is what lets both be true without an upward import (law **L2**).
///
/// **Why the API is synchronous.**
///
/// The repositories above this are synchronous (`StudentRepository.save`
/// returns `void`), and making them async to accommodate storage would push a
/// `Future` into every domain signature and every widget build — infrastructure
/// leaking into the domain, which law **L3** forbids. Instead the adapter is
/// expected to be *opened* asynchronously once at boot, after which reads are
/// served from an already-loaded structure and writes are flushed by the
/// adapter. Durability becomes a boot concern rather than a call-site concern.
///
/// **Why keys are namespaced, not tenant-prefixed by the caller.**
///
/// This port takes a `namespace` and a `key` and never interprets either.
/// Composing the tenant into the key is the job of `TenantPartitionedStore`,
/// which does it *inside* the store — the remedy forbidden edge `X-13`
/// actually prescribes. A caller that had to remember to prefix would be one
/// forgotten prefix away from a cross-tenant leak.
library;

/// Flat, synchronous key-value persistence for already-serialised rows.
///
/// Contract:
///   * Values are opaque strings. The store never parses them, so it can never
///     disagree with the domain about what a row means.
///   * [readAll] returns every key in [namespace], across **all** tenants. It
///     is called at boot, before any tenant scope exists, and therefore must
///     not depend on ambient tenant state.
///   * [write] and [delete] MUST be durable by the time the process exits
///     normally. An adapter that buffers indefinitely has not implemented this
///     interface.
///   * Implementations MUST NOT throw for a missing key — absence is a normal
///     result, returned as an empty map.
abstract interface class DurableKeyValueStore {
  /// Every persisted entry in [namespace], keyed exactly as written.
  ///
  /// Tenant-agnostic by design: restore happens before sign-in, so requiring a
  /// tenant here would make restoring impossible.
  Map<String, String> readAll(String namespace);

  /// Persist [value] under [key] within [namespace], replacing any prior value.
  void write(String namespace, String key, String value);

  /// Remove [key] from [namespace]. A missing key is not an error.
  void delete(String namespace, String key);
}
