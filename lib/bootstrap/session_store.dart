/// Persistence for the signed-in session.
///
/// **Why this is separate from `TenantPartitionedStore`.**
///
/// Every other persisted thing in Liboora is tenant-scoped, so it goes through
/// `TenantPartitionedStore`, which refuses to answer without a tenant in scope.
/// A session cannot: it is the thing that *establishes* the tenant scope. Asking
/// a tenant-partitioned store to hold it would be circular — you would need the
/// tenant to read the record that tells you the tenant.
///
/// So this store talks to `DurableKeyValueStore` directly, under its own
/// namespace, with a single fixed key. That is not a hole in `X-13`: the record
/// is **device-local and singular**, not a tenant-scoped row set. It carries
/// the tenant *inside* it, and the first thing the caller does with a restored
/// session is enter that tenant's scope. Nothing tenant-scoped is read before
/// that happens.
///
/// **Why `bootstrap/` and not `platform/data`.** Encoding an `AuthSession`
/// means naming `AccessRole` and `Account`, which live in `platform/identity`
/// (rank 4). `platform/data` is rank 2, so importing them there would be an
/// upward dependency (law **L2**). `bootstrap/` is the composition layer and
/// may lawfully know both — the same reason `codecs.dart` lives here.
///
/// ⛔ **This is not an authentication shortcut.** Nothing here creates an
/// account, grants a role, or accepts a credential. It re-presents a session
/// that a completed OTP verification already issued, and it re-checks the
/// expiry boundaries and the account's current roles before doing so. A
/// restored session is strictly weaker than a fresh one: it can only ever be
/// rejected by the additional checks, never strengthened by them.
library;

import 'dart:convert';

import 'package:liboora_contracts/liboora_contracts.dart';

import '../platform/identity/identity.dart';

/// Namespace for the session record in durable storage.
const String kSessionNamespace = 'auth_session';

/// The one key inside that namespace.
///
/// Singular by design: this is *this device's* current session
/// (`AUTH-6.22` — sign-out terminates the current session only). Multi-session
/// management across devices is a server-side concern and is not modelled here.
const String kSessionKey = 'current';

/// Reads and writes the persisted session.
final class SessionStore {
  const SessionStore(this._durable);

  final DurableKeyValueStore _durable;

  /// Persist [session]. Replaces any previous record.
  void save(AuthSession session) =>
      _durable.write(kSessionNamespace, kSessionKey, _encode(session));

  /// Remove the persisted session.
  ///
  /// `AUTH-6.21` — termination must be *irreversible*, so sign-out deletes the
  /// record rather than flagging it. A flagged record is resumable by anything
  /// that later ignores the flag.
  void clear() => _durable.delete(kSessionNamespace, kSessionKey);

  /// The persisted session, or null when there is none or it is unusable.
  ///
  /// Returns null — never throws — for a corrupt, truncated or
  /// schema-mismatched record, and **clears** it on the way out. A device that
  /// somehow holds an unreadable session must land on the sign-in screen, not
  /// on a crash screen; and leaving the bad record in place would repeat the
  /// failure on every launch.
  ///
  /// [accounts] is the current account directory. The restored session is
  /// re-bound to the **live** account rather than to the account snapshot in
  /// the record, so a role that has since been revoked is not resurrected from
  /// storage (`AUTH-6.17` — renewal must revalidate that the account remains
  /// usable and the library remains accessible).
  AuthSession? restore({
    required List<Account> accounts,
    required DateTime now,
  }) {
    final raw = _durable.readAll(kSessionNamespace)[kSessionKey];
    if (raw == null) return null;

    final AuthSession candidate;
    try {
      candidate = _decode(raw);
    } catch (_) {
      clear();
      return null;
    }

    // ── Re-validate against live state ──────────────────────────────
    //
    // ⚠ ORDER MATTERS, and the intuitive order is WRONG. Checking expiry
    // first looks cheapest, but the decoded record carries only an account
    // *id* — its placeholder account holds no roles — so `isStaffAudience`
    // would read false and every staff session would be measured against the
    // 30-day MOBILE limits instead of the 30-minute staff limit. That is a
    // fail-OPEN bug: it grants a longer session than the specification allows.
    //
    // The account is therefore resolved FIRST, the session rebound to it, and
    // only then is expiry evaluated — against the account's real roles.

    // 1. The account must still exist. Matched by AccountId, never by phone
    //    number — a lookup by number is an enumeration oracle (F-02), and the
    //    id is the stable identity anyway.
    Account? live;
    for (final a in accounts) {
      if (a.id == candidate.account.id) {
        live = a;
        break;
      }
    }
    if (live == null) {
      clear();
      return null;
    }

    // 2. The account must STILL hold the role the session claims, in the
    //    session's tenant. This is what makes a revoked role take effect on
    //    the next launch instead of persisting until the session expires
    //    (`AUTH-6.17`).
    if (!live.rolesIn(candidate.tenantId).contains(candidate.activeRole)) {
      clear();
      return null;
    }

    // Built from the LIVE account, so a renamed or re-roled account is
    // reflected rather than restored stale.
    final rebound = AuthSession(
      id: candidate.id,
      account: live,
      tenantId: candidate.tenantId,
      branchId: candidate.branchId,
      activeRole: candidate.activeRole,
      startedAt: candidate.startedAt,
      lastActiveAt: candidate.lastActiveAt,
    );

    // 3. Expiry (`AUTH-6.18`, `AUTH-6.19`, `AC-6.6`) — evaluated on the
    //    rebound session, so the staff/mobile audience is decided by the
    //    account's actual roles rather than by an empty placeholder.
    if (rebound.isExpiredAt(now)) {
      clear();
      return null;
    }

    return rebound;
  }

  // ── Serialisation ───────────────────────────────────────────────

  /// Schema version, so a future format change is detectable rather than
  /// silently misread. An unrecognised version is treated as corrupt.
  static const int _schemaVersion = 1;

  String _encode(AuthSession s) => jsonEncode({
    'v': _schemaVersion,
    'sessionId': s.id.value,
    'accountId': s.account.id.value,
    'tenantId': s.tenantId.value,
    'branchId': s.branchId.value,
    'activeRole': s.activeRole.name,
    'startedAt': s.startedAt.toIso8601String(),
    'lastActiveAt': s.lastActiveAt.toIso8601String(),
  });

  /// Throws on any malformed input; [restore] turns that into a null.
  ///
  /// The account is reconstructed as a **minimal placeholder** carrying only
  /// the id, because [restore] immediately replaces it with the live account.
  /// Persisting the full account — phone, display name, every role — would
  /// duplicate the account directory on disk and create a second, staler
  /// source of truth for authorization data.
  AuthSession _decode(String raw) {
    final m = jsonDecode(raw) as Map<String, Object?>;
    if (m['v'] != _schemaVersion) {
      throw FormatException('Unsupported session schema: ${m['v']}');
    }

    final roleName = m['activeRole']! as String;
    final role = AccessRole.values.firstWhere(
      (r) => r.name == roleName,
      // A role that no longer exists in the enum cannot be honoured.
      orElse: () => throw FormatException('Unknown role: $roleName'),
    );

    final accountId = AccountId(m['accountId']! as String);
    if (!accountId.isValid) {
      throw const FormatException('Session record has no account id.');
    }

    return AuthSession(
      id: SessionId(m['sessionId']! as String),
      account: Account(
        id: accountId,
        phone: '',
        displayName: '',
        roles: const {},
        // Placeholder only — replaced by the live account in `restore`.
        personId: const PersonId('pending'),
      ),
      tenantId: TenantId(m['tenantId']! as String),
      branchId: BranchId(m['branchId']! as String),
      activeRole: role,
      startedAt: DateTime.parse(m['startedAt']! as String),
      lastActiveAt: DateTime.parse(m['lastActiveAt']! as String),
    );
  }
}
