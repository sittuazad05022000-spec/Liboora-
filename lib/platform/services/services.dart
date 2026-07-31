/// **Platform Services — R3**
library;

import 'package:liboora_contracts/liboora_contracts.dart';

/// At-most-once execution across retries, offline replay and double taps.
///
/// Required by attendance check-in (a student tapping twice must not create
/// two punches) and payment capture (charging twice is unrecoverable trust
/// damage).
final class IdempotencyService {
  IdempotencyService(this._tenantContext);

  final TenantContext _tenantContext;
  final Map<String, Object?> _results = {};

  String _key(IdempotencyKey k) =>
      '${_tenantContext.tenantId.value}::${k.value}';

  bool seen(IdempotencyKey k) => _results.containsKey(_key(k));

  T? recall<T>(IdempotencyKey k) => _results[_key(k)] as T?;

  void remember<T>(IdempotencyKey k, T result) => _results[_key(k)] = result;
}

enum SyncState { synced, queued, conflicted }

final class QueuedMutation {
  QueuedMutation({
    required this.id,
    required this.description,
    required this.queuedAt,
    this.state = SyncState.queued,
  });

  final String id;
  final String description;
  final DateTime queuedAt;
  SyncState state;
}

/// Offline-first mutation queue.
///
/// Non-negotiable for an attendance app used in library basements with no
/// signal. The conflict *policy* is owned by the domain (Attendance); this
/// service only executes it — cycle-breaking pattern §8.2.
final class OfflineSyncEngine {
  final List<QueuedMutation> queue = [];
  bool online = true;

  void enqueue(QueuedMutation m) => queue.add(m);

  int get pendingCount =>
      queue.where((m) => m.state == SyncState.queued).length;

  Future<int> flush() async {
    if (!online) return 0;
    var flushed = 0;
    for (final m in queue.where((m) => m.state == SyncState.queued)) {
      m.state = SyncState.synced;
      flushed++;
    }
    return flushed;
  }
}
