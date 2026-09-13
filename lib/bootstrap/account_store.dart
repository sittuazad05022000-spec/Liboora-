/// Persistence for the account directory (`BC-18`).
///
/// **Why the account directory is not tenant-partitioned.**
///
/// `ADR-0003` makes an `Account` **global and cross-tenant**: *"One
/// registration per person. Switching libraries requires no
/// re-authentication."* `identifiers.dart` says the same of `AccountId` —
/// *"Global, cross-tenant."* So an account is deliberately **not** a
/// tenant-scoped row, and routing it through `TenantPartitionedStore` would be
/// wrong in two ways: it would refuse to answer before sign-in (when the
/// directory is exactly what authentication needs), and it would duplicate one
/// person's account per library, which is the model `ADR-0003` rejected.
///
/// Tenant isolation for accounts lives where the model puts it: in the
/// `roles` map, keyed by tenant. An account existing is global; an account
/// being *authorised* is per-tenant. This store persists the former and
/// preserves the latter byte-for-byte, so a role held at one library can never
/// become a role at another.
///
/// **Why `bootstrap/` and not `platform/data`.** Encoding an `Account` means
/// naming `AccessRole`, which lives in `platform/identity` (rank 4);
/// `platform/data` is rank 2, so importing it there would be an upward
/// dependency (law **L2**). `bootstrap/` is the composition layer and may
/// lawfully know both — the same reason `codecs.dart` and `session_store.dart`
/// live here.
///
/// ⛔ **This is not an authentication mechanism.** It stores no credential, no
/// OTP, no password and no token. An OTP challenge is deliberately *not*
/// persisted: it is short-lived by design (`challengeTtl`), and writing one to
/// disk would turn a five-minute secret into a durable one. Restoring an
/// account does not sign anyone in — it only makes the directory able to
/// answer "does this account still exist, and what roles does it hold?", which
/// is the question `SessionStore` must ask before honouring a session.
library;

import 'dart:convert';

import 'package:liboora_contracts/liboora_contracts.dart';

import '../platform/identity/identity.dart';

/// Namespace for account records in durable storage.
const String kAccountNamespace = 'accounts';

/// Reads and writes the global account directory.
final class AccountStore {
  const AccountStore(this._durable);

  final DurableKeyValueStore _durable;

  /// Persist [account], replacing any previous record for the same id.
  ///
  /// Keyed by `AccountId`, never by phone number. The id is the stable
  /// identity, and a phone-keyed store would make the key itself an
  /// enumeration surface.
  void save(Account account) =>
      _durable.write(kAccountNamespace, account.id.value, _encode(account));

  /// Persist every account in [accounts]. Used once, after seeding.
  void saveAll(Iterable<Account> accounts) {
    for (final a in accounts) {
      save(a);
    }
  }

  /// Every persisted account.
  ///
  /// A record that cannot be decoded is **skipped, not guessed**. One corrupt
  /// row must not stop the rest of the directory loading, and substituting a
  /// default would invent an account — or worse, invent its roles. The corrupt
  /// record is left in place rather than deleted: an account is not this
  /// store's to destroy, and silently removing one would erase the only trace
  /// that something went wrong. It simply does not load, so anything depending
  /// on it fails closed.
  ///
  /// Tenant-agnostic by design: the directory is global, and it is read at
  /// boot before any tenant scope exists.
  List<Account> restoreAll() {
    final out = <Account>[];
    for (final raw in _durable.readAll(kAccountNamespace).values) {
      try {
        out.add(_decode(raw));
      } catch (_) {
        continue;
      }
    }
    return out;
  }

  /// How many records are persisted, including any that fail to decode.
  ///
  /// Distinct from `restoreAll().length` on purpose: the caller needs to know
  /// whether the directory has *ever* been written, and a directory of only
  /// corrupt rows must not be mistaken for a first launch and re-seeded over.
  int get persistedCount => _durable.readAll(kAccountNamespace).length;

  // ── Serialisation ───────────────────────────────────────────────

  /// Schema version, so a future format change is detectable rather than
  /// silently misread. An unrecognised version is treated as corrupt.
  static const int _schemaVersion = 1;

  String _encode(Account a) => jsonEncode({
    'v': _schemaVersion,
    'id': a.id.value,
    'phone': a.phone,
    'displayName': a.displayName,
    'personId': a.personId.value,
    // tenantId -> [role names]. Roles are stored BY NAME, never by index: an
    // index would silently re-point every stored grant if a future value were
    // inserted into the middle of AccessRole — and a mis-pointed grant is a
    // privilege escalation, not a display bug.
    'roles': {
      for (final entry in a.roles.entries)
        entry.key: [for (final r in entry.value) r.name],
    },
  });

  /// Throws on any malformed input; [restoreAll] turns that into a skip.
  Account _decode(String raw) {
    final m = jsonDecode(raw) as Map<String, Object?>;
    if (m['v'] != _schemaVersion) {
      throw FormatException('Unsupported account schema: ${m['v']}');
    }

    final id = AccountId(m['id']! as String);
    if (!id.isValid) {
      throw const FormatException('Account record has no id.');
    }

    // ID-4 / SID-INV-1: exactly one identity per account, and the reference is
    // non-nullable. A record missing it fails to decode rather than producing
    // an Account the constructor would reject.
    final personId = PersonId(m['personId']! as String);
    if (!personId.isValid) {
      throw const FormatException('Account record has no PersonId.');
    }

    final rawRoles = m['roles']! as Map<String, Object?>;
    final roles = <String, Set<AccessRole>>{};
    for (final entry in rawRoles.entries) {
      final set = <AccessRole>{};
      for (final name in entry.value! as List<Object?>) {
        // An unrecognised role name is fatal to the whole record, not skipped.
        // Dropping one unknown role would silently DOWNGRADE an account's
        // authorization, and a partially-understood grant set is not a grant
        // set we may act on.
        set.add(
          AccessRole.values.firstWhere(
            (r) => r.name == name,
            orElse: () => throw FormatException('Unknown role: $name'),
          ),
        );
      }
      roles[entry.key] = set;
    }

    return Account(
      id: id,
      phone: m['phone']! as String,
      displayName: m['displayName']! as String,
      personId: personId,
      roles: roles,
    );
  }
}
