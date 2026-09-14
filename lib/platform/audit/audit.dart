/// **Audit Platform — R5** (BC-24)
///
/// Append-only by construction: this class exposes no update, delete or purge
/// method (forbidden edge X-10). A correction is a new entry, never an edit.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

final class AuditEntry {
  const AuditEntry({
    required this.id,
    required this.tenantId,
    required this.actor,
    required this.action,
    required this.target,
    required this.at,
    this.detail = const {},
  });

  final String id;
  final TenantId tenantId;
  final String actor;
  final String action;
  final String target;
  final DateTime at;
  final Map<String, Object?> detail;
}

final class AuditTrail {
  AuditTrail(this._idGen);

  final IdGenerator _idGen;
  final List<AuditEntry> _entries = [];

  /// The ONLY mutation method. Intentional.
  void append({
    required TenantId tenantId,
    required String actor,
    required String action,
    required String target,
    DateTime? at,
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
        detail: detail,
      ),
    );
  }

  List<AuditEntry> forTenant(TenantId t) =>
      _entries.where((e) => e.tenantId == t).toList();

  List<AuditEntry> recent([int n = 25]) =>
      _entries.reversed.take(n).toList(growable: false);

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
