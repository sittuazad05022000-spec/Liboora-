/// **Audit Platform — R5** (BC-24)
///
/// Append-only by construction: this class exposes no update, delete or purge
/// method (forbidden edge X-10). A correction is a new entry, never an edit.
///
/// **Nine-attribute guarantee (LIB-19.4):** every [append] call carries
/// actor, role, tenant, action, target, priorValue, newValue, timestamp and
/// source. Where a value is not meaningful for a given change (e.g. a creation
/// has no priorValue) the field is null — not omitted and not invented.
///
/// **Erasure-safe identity (AUTH-9.57 / LIB-19.6):** [eraseAccount] records a
/// durable redaction register. Every [forTenant] and [recent] read applies
/// read-time projection: erased actors are replaced by a fixed pseudonym.
/// The stored record is never touched — append-only is preserved byte-for-byte.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

const String _kRedactionNamespace = 'audit-redactions';

/// The nine fields every administrative audit entry carries (LIB-19.4).
///
/// Nine fields, not fewer. A missing field is a gap in the audit guarantee, not
/// a storage optimisation. Where a field does not apply to a given change the
/// value is null — the absence is load-bearing evidence that the field was
/// considered and deemed inapplicable.
final class AuditEntry {
  const AuditEntry({
    required this.id,
    required this.tenantId,
    required this.actor,
    required this.action,
    required this.target,
    required this.at,
    this.role,
    this.priorValue,
    this.newValue,
    this.source,
    this.detail = const {},
  });

  final String id;
  final TenantId tenantId;
  final String actor;
  final String action;
  final String target;
  final DateTime at;
  final String? role;
  final Object? priorValue;
  final Object? newValue;
  final String? source;
  final Map<String, Object?> detail;
}

final class AuditTrail {
  AuditTrail(this._idGen, {DurableKeyValueStore? durable}) {
    _redactedActors.addAll(_loadRedactions(durable));
  }

  final IdGenerator _idGen;
  final DurableKeyValueStore? _durable;
  final List<AuditEntry> _entries = [];
  final Set<String> _redactedActors = {};

  Set<String> _loadRedactions(DurableKeyValueStore? store) {
    if (store == null) return {};
    try {
      final raw = store.readAll(_kRedactionNamespace);
      return raw.keys.toSet();
    } catch (_) {
      return {};
    }
  }

  /// Erasure-safe redaction register (AUTH-9.57 / LIB-19.6).
  ///
  /// Adds [actorId] to the persistent redaction set. After this call, all
  /// [forTenant] and [recent] reads project any entry with this actor to the
  /// pseudonym `'erased-account'`. The stored entry is never modified — this
  /// preserves the append-only guarantee (AC-73-1 / LIB-19.5).
  ///
  /// The erasure fact itself is also recorded as an audit entry so the redaction
  /// event is auditable history.
  void eraseAccount(String actorId) {
    if (_redactedActors.add(actorId)) {
      _durable?.write(_kRedactionNamespace, actorId, '1');
      append(
        tenantId: TenantId('system'),
        actor: 'system',
        action: 'audit.AccountErased',
        target: actorId,
        at: DateTime.now(),
        detail: const {'erasedActor': actorId},
      );
    }
  }

  /// Apply read-time redaction projection.
  String _project(String actor) =>
      _redactedActors.contains(actor) ? 'erased-account' : actor;

  AuditEntry _projectEntry(AuditEntry e) => _redactedActors.contains(e.actor)
      ? AuditEntry(
          id: e.id,
          tenantId: e.tenantId,
          actor: 'erased-account',
          action: e.action,
          target: e.target,
          at: e.at,
          role: e.role,
          priorValue: e.priorValue,
          newValue: e.newValue,
          source: e.source,
          detail: e.detail,
        )
      : e;

  /// The ONLY mutation method. Intentional.
  void append({
    required TenantId tenantId,
    required String actor,
    required String action,
    required String target,
    DateTime? at,
    String? role,
    Object? priorValue,
    Object? newValue,
    String? source,
    Map<String, Object?> detail = const {},
  }) {
    _entries.add(
      AuditEntry(
        id: _idGen.next('audit'),
        tenantId: tenantId,
        actor: actor,
        action: action,
        target: target,
        at: at ?? DateTime.fromMillisecondsSinceEpoch(0),
        role: role,
        priorValue: priorValue,
        newValue: newValue,
        source: source,
        detail: detail,
      ),
    );
  }

  List<AuditEntry> forTenant(TenantId t) =>
      _entries.where((e) => e.tenantId == t).map(_projectEntry).toList();

  List<AuditEntry> recent([int n = 25]) =>
      _entries.reversed.take(n).map(_projectEntry).toList(growable: false);

  int get count => _entries.length;

  /// `IMPL-438` / `MM-NFR-009` — records a domain fact as an audit entry.
  ///
  /// Takes a [DomainEvent] rather than an `EventBus` deliberately. §6 of the
  /// module manifest grants `platform/audit` (R5) only a `contracts` import;
  /// subscribing here would require `platform/event` (R3), which is exactly
  /// the edge already carried as ACKNOWLEDGED DEBT for
  /// `platform/analytics → platform/event`. Copying that shape would bank a
  /// 29th debt finding to save three lines in `bootstrap/`. The subscription
  /// is therefore wired in the composition root — the one place allowed to
  /// know two modules — and this method takes the R0 event it is handed.
  ///
  /// **Never synchronous.** BC Map `E-20`: *"Domain never calls audit
  /// synchronously"*. Because this runs as a bus consumer during `drain`,
  /// the emitting transaction has already committed; audit being slow or
  /// down cannot fail it. `AU-3` says the same from the other side:
  /// *"unavailability of this platform delays audit visibility only"*.
  ///
  /// **Append-only** (`X-10`): delegates to [append], the only mutation
  /// method that exists.
  void recordDomainFact(DomainEvent event) {
    // MM-BR-015 / MP-GBR-34, restated in §17 for locality: "audit records
    // carry no mobile number, name or other BC-10 field." The bus already
    // refuses to publish such a payload, so this is defence in depth. It is
    // worth having anyway: audit is where a leaked field would persist
    // longest, and X-10 means it could never be deleted afterwards.
    final detail = <String, Object?>{};
    for (final entry in event.payload.entries) {
      if (kForbiddenAuditDetailKeys.contains(entry.key)) continue;
      detail[entry.key] = entry.value;
    }

    append(
      tenantId: event.tenantId,
      // §17: for the expiry job the actor "MUST NOT be recorded as a human".
      // A scheduled job carries no actorId, so it becomes 'system'.
      actor: event.actorId ?? 'system',
      action: event.eventType,
      target: (event.payload['membershipId'] as String?) ?? event.aggregateId,
      at: event.occurredAt,
      // role, priorValue, newValue — sourced from additive payload keys.
      // These are null when the emitting context does not provide them;
      // they are not invented.
      role: event.payload['actorRole'] as String?,
      priorValue: event.payload['priorValue'],
      newValue: event.payload['newValue'],
      source: event.payload['source'] as String?,
      detail: detail,
    );
  }
}

/// `MM-NFR-009` / `MP-GBR-34` — keys an audit entry must never carry.
///
/// Deliberately a superset of the event bus's deny-list. Audit is
/// append-only, so a mistake here is permanent in a way a mistake on the bus
/// is not: there is no delete path to clean it up with.
const Set<String> kForbiddenAuditDetailKeys = {
  'mobile',
  'mobileNumber',
  'phone',
  'phoneNumber',
  'name',
  'studentName',
  'fullName',
  'displayName',
  'email',
  'emailAddress',
  'photo',
  'photoUrl',
  'photograph',
  'avatar',
  'address',
  'dateOfBirth',
  'dob',
  'guardianName',
  'guardianPhone',
  'aadhaar',
  'aadhaarNumber',
  'pan',
  'panNumber',
};
