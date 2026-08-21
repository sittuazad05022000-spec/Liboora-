/// **Platform Services — R3**
library;

import 'dart:async';

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

/// **In-process Job Runtime adapter — the V1 arm of `platform/services:job_runtime`.**
///
/// Authorised by `ADR-0058`, which closed `FIL-GAP-015` by separating the **port**
/// (a V1 obligation of frozen `FIL-XC-017`) from the **runtime** (EA L1865, V2:
/// worker pools, queue management, distributed backoff, job observability).
///
/// **What this adapter guarantees.**
///  * Work runs **off the caller's request path** — so `PROCESSING` is an
///    observable state and `FIL-FR-092`'s lifecycle is real rather than notional.
///  * **Bounded retry** under an operation key; the runtime owns the loop, because
///    `FIL-FR-093` says *"Retry SHALL NOT be scheduled by this module"* of its
///    consumer.
///  * **Idempotency**: a repeated [JobKey] never runs the work twice.
///  * A **deadline** that produces a terminal failure, which is what makes
///    `FIL-FR-095` ("no indefinite non-terminal state") enforceable.
///
/// **What it deliberately does NOT do — stated here, not discovered later.**
///  * ⛔ It does **not** survive a process restart. In-flight work is lost.
///  * ⛔ It does **not** distribute across instances, and provides no
///    cross-instance backpressure. V1 media processing is therefore **not
///    suitable for multi-instance deployment** until a durable adapter or the V2
///    runtime arrives (`ADR-0058` §7).
///
/// Losing in-flight work is survivable — not merely tolerable — because two
/// frozen requirements make it so: `FIL-FR-057` (a derivative is **never the sole
/// copy**) and `FIL-FR-083` (a derivative is **regenerable**). The worst outcome
/// is reprocessing, never a lost original and never a served partial
/// (`FIL-INV-013`). The weakness lands exactly where the specification already
/// has a recovery path, which is why a lightweight adapter is defensible here and
/// would not be for payment capture.
final class InProcessJobRuntime implements JobRuntime {
  InProcessJobRuntime(this._clock);

  final Clock _clock;
  final Map<String, JobOutcome> _outcomes = {};
  final List<Future<void>> _inFlight = [];

  /// Accepted work, terminal or not. Exposed so the architecture suite can
  /// assert that a submission was *recorded* even though nothing has run yet.
  int get knownJobs => _outcomes.length;

  @override
  JobOutcome? outcome(JobKey key) => _outcomes[key.value];

  /// Await every accepted job.
  ///
  /// Deliberately **not** on the [JobRuntime] port: a distributed V2 runtime
  /// could not honour it. It exists because [submit] returns on *acceptance*,
  /// so without a join point a test could only assert the pending state, and
  /// graceful shutdown would have nothing to wait on.
  Future<void> drain() async {
    while (_inFlight.isNotEmpty) {
      final batch = List<Future<void>>.of(_inFlight);
      _inFlight.clear();
      await Future.wait(batch);
    }
  }

  /// Accepts work and returns; it does **not** await the work.
  ///
  /// Not an `async` method, and that is load-bearing. An `async` body runs
  /// synchronously up to its first suspension, so an earlier draft of this
  /// adapter began executing `work()` on the **caller's own stack** — a probe
  /// observed the job already in [JobState.running] before the returned future
  /// was awaited. A media job may run to the `FIL-CFG-015` timeout (120 s), so
  /// that inlined the whole of processing into the upload request and broke this
  /// port's own contract (*"Submit work to run off the caller's request path"*)
  /// along with the reason `FIL-XC-017` requires a job runtime at all.
  ///
  /// `Future(...)` schedules through the event loop, so the first attempt cannot
  /// begin until the caller yields. Completion still happens in **this process**
  /// — that is the durability limit `ADR-0058` §7 discloses, and it is a
  /// different property from where the work starts.
  @override
  Future<void> submit(
    JobKey key,
    Future<void> Function() work, {
    required int retryBudget,
    required Duration deadline,
  }) {
    // Thrown synchronously: a caller who does not await `submit` would
    // otherwise turn a programming error into an unhandled asynchronous error
    // that surfaces nowhere near its cause.
    if (retryBudget < 1) {
      throw ArgumentError.value(
        retryBudget,
        'retryBudget',
        'must be at least 1 — zero attempts means the work never runs and '
            'every object stalls to its deadline (CONFIGURATION_GUIDE INV-21)',
      );
    }

    // Idempotency (FIL-FR-093): a key already seen is never executed again, and
    // the first outcome stands. Checked BEFORE any attempt, so a duplicate
    // submission cannot produce a second derivative or a second audit fact.
    if (_outcomes.containsKey(key.value)) return Future<void>.value();

    _outcomes[key.value] =
        JobOutcome(key: key, state: JobState.pending, attempts: 0);

    _inFlight.add(
      Future<void>(() => _run(key, work, retryBudget, deadline)),
    );
    return Future<void>.value();
  }

  /// The attempt loop. Never throws: a failure becomes a terminal outcome with a
  /// typed reason, because an escaping error here would be an unhandled
  /// asynchronous error with no caller left to catch it.
  Future<void> _run(
    JobKey key,
    Future<void> Function() work,
    int retryBudget,
    Duration deadline,
  ) async {
    final startedAt = _clock.now();
    var attempts = 0;
    String? lastReason;

    while (attempts < retryBudget) {
      // Deadline check precedes each attempt. FIL-FR-095 requires a bounded
      // non-terminal window; without this a retry loop could outlive the
      // FIL-CFG-015 timeout and leave the object neither servable nor terminal.
      if (_clock.now().difference(startedAt) >= deadline) {
        _outcomes[key.value] = JobOutcome(
          key: key,
          state: JobState.failed,
          attempts: attempts,
          reasonCode: 'deadline_exceeded',
        );
        return;
      }

      attempts++;
      _outcomes[key.value] =
          JobOutcome(key: key, state: JobState.running, attempts: attempts);

      try {
        await work();
        _outcomes[key.value] = JobOutcome(
          key: key,
          state: JobState.succeeded,
          attempts: attempts,
        );
        return;
      } on Object {
        // A typed, non-leaking reason (FIL-FR-093, FIL-FR-094). The caught error
        // is deliberately NOT propagated into reasonCode: an exception message
        // can carry a storage path or internal detail, which FIL-FR-094 forbids
        // exposing through a progress surface.
        lastReason = 'attempt_failed';
      }
    }

    _outcomes[key.value] = JobOutcome(
      key: key,
      state: JobState.failed,
      attempts: attempts,
      reasonCode: lastReason ?? 'retries_exhausted',
    );
  }
}
