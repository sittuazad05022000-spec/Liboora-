/// IMPL-433 — opaque server-side cursor registry for `MM-FR-115` pagination.
///
/// This is the corrective fix for the earlier raw-membership-ID cursor, which
/// failed `PG-1`/`PG-2`/`PG-3` (the boundary map §15.3, admitted by `ADR-0083`
/// §4.5, ruling AO-2): a raw ID on the wire is not opaque (PG-1), lets a client
/// construct or manipulate the cursor (PG-2), and exposes database identifiers
/// and ordering keys to the wire (PG-3).
///
/// The pattern is exactly the one `BC-01` Enrollment already uses in
/// `lib/domain/library/enrollment/enrollment.dart` (:86, :201-220): a
/// crypto-strong random token mints an opaque handle that never leaves the
/// server except as an unforgeable string, and the registry is the only place
/// that knows what it points at.
///
/// Each token is bound, server-side, to:
///   * the tenant that issued it — a cursor minted under one tenant is
///     rejected, loudly, if a different tenant ever presents it;
///   * the anchor membership id the next page resumes after;
///   * a canonical fingerprint of the list query (kind + every applied filter)
///     so a cursor is only valid for the same filtered view it was issued for.
///
/// `PG-4` is preserved: an unknown, malformed, cross-tenant or cross-filter
/// token is a [DomainError], never a silent reset.
///
/// ⛔ Lifecycle: as written, one entry is added per issued cursor and is never
/// removed while this registry lives — mirroring the enrollment pattern, which
/// keeps its entries for the container's lifetime. There is deliberately **no
/// TTL, expiry or cleanup policy**: no authoritative convention exists for
/// cursor retirement in this codebase, and inventing one would be a governance
/// decision, not an implementation detail. This is reported as an open
/// question rather than silently resolved.
library;

import 'dart:convert';
import 'dart:math';

import 'package:liboora_contracts/liboora_contracts.dart';

/// A server-side handle that resolves an opaque cursor token back to the
/// tenant scope, anchor membership and query fingerprint it was issued for.
final class MembershipCursorRegistry {
  MembershipCursorRegistry();

  static final Random _secureRandom = Random.secure();

  /// token → entry. Instance-scoped, never shared; entries live for the
  /// lifetime of this registry (see file doc: no TTL/cleanup by design).
  final Map<String, _CursorEntry> _registry = {};

  /// Mint a fresh opaque cursor token for [tenant] resuming at [anchorId]
  /// under the canonical [fingerprint] of the issuing query.
  ///
  /// 32 cryptographically random bytes, base64url-encoded (44 chars incl.
  /// `==` padding), carrying no tenant id, membership id or ordering key on
  /// the wire (`PG-1`/`PG-3`).
  String issue({
    required TenantId tenant,
    required String anchorId,
    required String fingerprint,
  }) {
    final opaque = base64UrlEncode(
      List<int>.generate(32, (_) => _secureRandom.nextInt(256)),
    );
    _registry[opaque] = _CursorEntry(
      tenantId: tenant.value,
      anchorId: anchorId,
      fingerprint: fingerprint,
    );
    return opaque;
  }

  /// Resolve [token] against the current [tenant] and the canonical
  /// [fingerprint] of the query the caller is about to run.
  ///
  /// Returns the anchor membership id to resume after. Throws
  /// `DomainError(validationFailed, 'Invalid cursor.')` when the token is
  /// unknown, was issued under a different tenant, or was issued for a
  /// different query — never a silent reset (`PG-4`).
  String resolve({
    required String token,
    required TenantId tenant,
    required String fingerprint,
  }) {
    final entry = _registry[token];
    if (entry == null ||
        entry.tenantId != tenant.value ||
        entry.fingerprint != fingerprint) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'Invalid cursor.',
      );
    }
    return entry.anchorId;
  }
}

final class _CursorEntry {
  const _CursorEntry({
    required this.tenantId,
    required this.anchorId,
    required this.fingerprint,
  });
  final String tenantId;
  final String anchorId;
  final String fingerprint;
}
