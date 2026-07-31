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
}
