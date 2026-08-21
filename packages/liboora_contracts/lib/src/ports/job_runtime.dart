/// Liboora Shared Kernel (R0) — Job Runtime port.
///
/// Declared as `platform/services:job_runtime` at `tool/module_dependencies.yaml`
/// **L338**. The interface did not exist, which is the `B-7` / `ADR-0012` shape:
/// *"five service ports are already declared … only the interfaces are missing"*,
/// remedy *"extract the interfaces"*.
///
/// **Why this port exists at V1 while the EA places Job Runtime at V2.**
/// `ADR-0058` measured the EA's own children of *"Job Runtime (V2)"* — Background
/// Jobs, Worker Pools, Queue Management, Retry & Backoff, Job Observability — and
/// found that every one of them is scaled **infrastructure**, and none of them is
/// the **port**. Frozen `FIL-XC-017` forbids `BC-29` from *operating* a pool, a
/// queue, a retry scheduler or a cron and requires it to *consume* this port. So
/// the V1 obligation is that this contract exist; the V2 obligation is that a
/// scaled runtime implement it.
///
/// **What a consumer may NOT do.** Schedule its own retries. `FIL-FR-093` states
/// *"Retry SHALL NOT be scheduled by this module."* A caller therefore submits a
/// retry *budget* and a *deadline* and never decides when an attempt happens.
library;

/// Idempotency key for a unit of deferred work.
///
/// `FIL-FR-093` requires processing to be idempotent **under an operation key**:
/// a repeated or retried attempt for the same object and profile must not produce
/// a second stored derivative, a second audit fact, or a different result.
///
/// The guarantee lives in this **contract** rather than in each caller, so it
/// cannot be lost by a careless consumer and the V2 runtime inherits it.
final class JobKey {
  const JobKey(this.value);

  final String value;

  @override
  bool operator ==(Object other) => other is JobKey && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'JobKey($value)';
}

/// Terminal and non-terminal states of a submitted job.
///
/// Deliberately **not** the same enum as a File & Media object lifecycle
/// (`RECEIVED → VALIDATING → PROCESSING → READY | FAILED`, `FIL-FR-092`). A job
/// is the *mechanism*; the object lifecycle is the *domain fact*. Fusing them
/// would put media semantics into a platform port and hand `BC-29` state it does
/// not own.
enum JobState {
  /// Accepted, not yet started.
  pending,

  /// An attempt is executing.
  running,

  /// Completed successfully. Terminal.
  succeeded,

  /// Attempts exhausted, or the deadline expired. Terminal.
  failed,
}

/// Outcome of a submitted job, observable by the consumer.
///
/// Carries no storage path, no worker identity and no internal error text —
/// `FIL-FR-094` forbids exposing any of those through progress, because a
/// progress surface that confirms existence is an enumeration oracle.
final class JobOutcome {
  const JobOutcome({
    required this.key,
    required this.state,
    required this.attempts,
    this.reasonCode,
  });

  final JobKey key;
  final JobState state;

  /// Attempts consumed, including the first. Never exceeds the submitted budget.
  final int attempts;

  /// A **typed, non-leaking** reason. `FIL-FR-093` and `FIL-FR-095` both require
  /// the failure reason to be typed and non-leaking, so this is a stable code and
  /// never an exception message.
  final String? reasonCode;

  bool get isTerminal =>
      state == JobState.succeeded || state == JobState.failed;
}

/// Deferred execution as a dependency.
///
/// **Tenancy.** This port carries **no** tenant identifier. Work inherits the
/// ambient `TenantContext` of its submission scope, so no tenancy rule is created
/// here and no global identity context (BC Map §11: `BC-10`, `BC-11`…`BC-17`)
/// can receive one through this surface.
abstract interface class JobRuntime {
  /// Submit work to run **off the caller's request path**.
  ///
  /// `retryBudget` is the **total** attempts permitted, including the first — the
  /// consumer supplies the bound (for media processing, `FIL-CFG-014`) and the
  /// runtime owns the loop. `deadline` bounds the whole job; on expiry the
  /// runtime moves it to [JobState.failed], which is what makes
  /// `FIL-FR-095`'s "no indefinite non-terminal state" enforceable.
  ///
  /// Submitting an already-known [JobKey] **must not** run the work twice.
  Future<void> submit(
    JobKey key,
    Future<void> Function() work, {
    required int retryBudget,
    required Duration deadline,
  });

  /// The current outcome, or `null` if this runtime has never seen [key].
  ///
  /// Returning `null` rather than throwing keeps `FIL-FR-094`'s rule intact: a
  /// caller who may not read an object must not be able to distinguish "not
  /// permitted" from "does not exist".
  JobOutcome? outcome(JobKey key);
}
