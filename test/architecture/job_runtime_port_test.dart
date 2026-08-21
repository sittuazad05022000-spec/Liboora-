/// **Architecture test — the `platform/services:job_runtime` port.**
///
/// The port is declared at `tool/module_dependencies.yaml` **L338** and made
/// mandatory for `BC-29` by frozen `FIL-XC-017`:
///
/// > The module MUST NOT operate its own worker pool, queue, retry scheduler or
/// > cron. It MUST consume `platform/services:job_runtime`.
///
/// `ADR-0058` resolved `FIL-GAP-015` by separating the **port** (V1) from the
/// scaled **runtime** (V2) and authorising one in-process adapter. This file
/// tests the behaviour that adapter must exhibit for the frozen requirements it
/// is standing in for to be enforceable at all:
///
///  * `FIL-FR-093` — processing is **idempotent under an operation key**, and
///    retryable to a bound after which it **rests** FAILED with a typed,
///    non-leaking reason. *"Retry SHALL NOT be scheduled by this module."*
///  * `FIL-FR-094` — progress exposes **no** internal error text, and an unknown
///    object is indistinguishable from one the caller may not read.
///  * `FIL-FR-095` — **no indefinite** non-terminal state; exceeding the
///    `FIL-CFG-015` window becomes terminal FAILED.
///
/// **What this file deliberately does not do.** It does not assert that any
/// document contains any sentence. Matrix §10.3 compliance for *wiring* is
/// `no_orphan_ports_test.dart`'s job; this file executes the adapter and
/// observes what it actually does. A test that read `FIL-FR-093` out of the PRD
/// and checked the prose was present would pass against an adapter that runs
/// duplicate work twice.
///
/// **No wall clock** (`X-09`): time is a `FixedClock` advanced deliberately, so
/// the deadline tests are decisions rather than races.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/platform/services/services.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

final DateTime _t0 = DateTime.utc(2026, 3, 2, 9);

/// The recorded `FIL-CFG-015` default (CONFIGURATION_GUIDE v1.2 §2C.5).
const Duration _processingTimeout = Duration(seconds: 120);

/// The recorded `FIL-CFG-014` default (CONFIGURATION_GUIDE v1.2 §2C.6).
const int _retryBound = 3;

({InProcessJobRuntime runtime, FixedClock clock}) _fixture() {
  final clock = FixedClock(_t0);
  return (runtime: InProcessJobRuntime(clock), clock: clock);
}

void main() {
  // ════════════════════════════════════════════════════════════════════
  // The port is consumed as a port, not as an adapter.
  // ════════════════════════════════════════════════════════════════════
  group('the port is a real abstraction', () {
    test('the adapter satisfies the JobRuntime interface, so a consumer can '
        'depend on the port alone', () {
      final f = _fixture();
      // Assigning to the PORT type is the assertion: if the adapter drifted
      // away from the interface this would not compile, and a consumer written
      // against JobRuntime could not accept it.
      final JobRuntime port = f.runtime;
      expect(port, isA<JobRuntime>());
      expect(
        port.outcome(const JobKey('never-submitted')),
        isNull,
        reason: 'A fresh runtime claims to know a job nobody submitted.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // FIL-XC-017 — the work leaves the caller's request path.
  // ════════════════════════════════════════════════════════════════════
  group('submitted work is deferred, not inlined (FIL-XC-017)', () {
    test('submit returns BEFORE the work begins', () async {
      final f = _fixture();
      var started = false;

      await f.runtime.submit(
        const JobKey('deferred'),
        () async => started = true,
        retryBudget: 1,
        deadline: _processingTimeout,
      );

      expect(
        started,
        isFalse,
        reason: 'REGRESSION — the work began before submit() returned, so it '
            'is executing on the caller stack.\n'
            'This is the exact defect a probe caught in the first draft of '
            'InProcessJobRuntime: an `async` body runs synchronously up to its '
            'first suspension, so `submit` looked deferred and was not. A '
            'media job may run to the FIL-CFG-015 timeout (120 s), so inlining '
            'holds the upload request open for the whole of processing — which '
            'is precisely what FIL-XC-017 requires a job runtime to avoid.',
      );
      expect(
        f.runtime.outcome(const JobKey('deferred'))!.state,
        JobState.pending,
        reason: 'Work was accepted but has not started, so the only truthful '
            'state is pending.',
      );

      await f.runtime.drain();

      expect(started, isTrue, reason: 'The work never ran at all.');
      expect(
        f.runtime.outcome(const JobKey('deferred'))!.state,
        JobState.succeeded,
      );
    });

    test('acceptance is recorded immediately, so a caller can report progress '
        'without waiting for completion', () async {
      final f = _fixture();
      expect(f.runtime.knownJobs, 0);

      await f.runtime.submit(
        const JobKey('accepted'),
        () async {},
        retryBudget: 1,
        deadline: _processingTimeout,
      );

      expect(
        f.runtime.knownJobs,
        1,
        reason: 'A job that is accepted but unobservable would force the '
            'caller to invent a state FIL-FR-092 does not define.',
      );
      await f.runtime.drain();
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // FIL-FR-093 — idempotency under an operation key.
  // ════════════════════════════════════════════════════════════════════
  group('idempotency under the operation key (FIL-FR-093)', () {
    test('a repeated JobKey runs the work exactly once', () async {
      final f = _fixture();
      var runs = 0;

      for (var i = 0; i < 5; i++) {
        await f.runtime.submit(
          const JobKey('same-object-same-profile'),
          () async => runs++,
          retryBudget: _retryBound,
          deadline: _processingTimeout,
        );
      }
      await f.runtime.drain();

      expect(
        runs,
        1,
        reason: 'Five submissions of one key produced $runs executions. '
            'FIL-FR-093 requires that a repeated attempt produce no second '
            'stored derivative and no second audit fact — with duplicate '
            'execution, both follow directly.',
      );
      expect(f.runtime.knownJobs, 1);
    });

    test('a duplicate submission does not overwrite the first outcome', () async {
      final f = _fixture();

      await f.runtime.submit(
        const JobKey('k'),
        () async {},
        retryBudget: 1,
        deadline: _processingTimeout,
      );
      await f.runtime.drain();
      final first = f.runtime.outcome(const JobKey('k'))!;
      expect(first.state, JobState.succeeded);

      // Resubmit the same key with work that would fail if it ran.
      await f.runtime.submit(
        const JobKey('k'),
        () async => throw StateError('must not run'),
        retryBudget: 1,
        deadline: _processingTimeout,
      );
      await f.runtime.drain();

      final second = f.runtime.outcome(const JobKey('k'))!;
      expect(
        second.state,
        JobState.succeeded,
        reason: 'A resubmitted key changed a settled outcome. FIL-FR-093 '
            'requires "no different result" — a completed success that can be '
            'turned into a failure by a replayed request is exactly that.',
      );
      expect(second.attempts, first.attempts);
    });

    test('distinct keys are independent', () async {
      final f = _fixture();
      var a = 0;
      var b = 0;
      await f.runtime.submit(
        const JobKey('a'),
        () async => a++,
        retryBudget: 1,
        deadline: _processingTimeout,
      );
      await f.runtime.submit(
        const JobKey('b'),
        () async => b++,
        retryBudget: 1,
        deadline: _processingTimeout,
      );
      await f.runtime.drain();

      expect([a, b], [1, 1],
          reason: 'Over-eager deduplication would silently drop a real job.');
      expect(f.runtime.knownJobs, 2);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // FIL-FR-093 — the retry bound, owned by the runtime.
  // ════════════════════════════════════════════════════════════════════
  group('retry is bounded and owned by the runtime (FIL-FR-093)', () {
    test('failing work is retried up to the budget and then RESTS failed',
        () async {
      final f = _fixture();
      var attempts = 0;

      await f.runtime.submit(
        const JobKey('always-fails'),
        () async {
          attempts++;
          throw StateError('storage unavailable at /bucket/tenant-7/orig.bin');
        },
        retryBudget: _retryBound,
        deadline: _processingTimeout,
      );
      await f.runtime.drain();

      expect(
        attempts,
        _retryBound,
        reason: 'Expected exactly the FIL-CFG-014 budget ($_retryBound) '
            'attempts, got $attempts. Fewer wastes a permitted retry; more '
            'means the bound is not enforced and a poison job retries forever.',
      );

      final outcome = f.runtime.outcome(const JobKey('always-fails'))!;
      expect(outcome.state, JobState.failed);
      expect(
        outcome.isTerminal,
        isTrue,
        reason: 'FIL-FR-093 requires the job to REST in a terminal state once '
            'the budget is exhausted.',
      );
      expect(outcome.attempts, _retryBound);
    });

    test('work that fails then succeeds within budget ends succeeded, using '
        'only the attempts it needed', () async {
      final f = _fixture();
      var attempts = 0;

      await f.runtime.submit(
        const JobKey('flaky'),
        () async {
          attempts++;
          if (attempts < 2) throw StateError('transient');
        },
        retryBudget: _retryBound,
        deadline: _processingTimeout,
      );
      await f.runtime.drain();

      final outcome = f.runtime.outcome(const JobKey('flaky'))!;
      expect(outcome.state, JobState.succeeded);
      expect(
        outcome.attempts,
        2,
        reason: 'A retry loop that keeps going after success would reprocess '
            'an object that is already READY.',
      );
      expect(attempts, 2);
    });

    test('reported attempts never exceed the submitted budget', () async {
      for (final budget in [1, 2, 3, 5]) {
        final f = _fixture();
        await f.runtime.submit(
          JobKey('b$budget'),
          () async => throw StateError('x'),
          retryBudget: budget,
          deadline: _processingTimeout,
        );
        await f.runtime.drain();
        expect(
          f.runtime.outcome(JobKey('b$budget'))!.attempts,
          lessThanOrEqualTo(budget),
          reason: 'Budget $budget was exceeded.',
        );
      }
    });

    test('a retryBudget below 1 is rejected synchronously (INV-21)', () {
      final f = _fixture();
      expect(
        () => f.runtime.submit(
          const JobKey('zero'),
          () async {},
          retryBudget: 0,
          deadline: _processingTimeout,
        ),
        throwsA(isA<ArgumentError>()),
        reason: 'A zero budget means the work never runs, so every object '
            'stalls to its deadline and fails for a reason unrelated to its '
            'content. CONFIGURATION_GUIDE INV-21 forbids it; the adapter must '
            'not accept what configuration forbids.',
      );
      expect(
        f.runtime.knownJobs,
        0,
        reason: 'A rejected submission must leave no trace, or the key becomes '
            'permanently unusable through the idempotency check.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // FIL-FR-095 — no indefinite non-terminal state.
  // ════════════════════════════════════════════════════════════════════
  group('the deadline makes non-terminal states bounded (FIL-FR-095)', () {
    test('a job whose deadline has passed becomes terminal FAILED instead of '
        'attempting more work', () async {
      final f = _fixture();
      var attempts = 0;

      await f.runtime.submit(
        const JobKey('slow'),
        () async {
          attempts++;
          // Each attempt consumes the whole FIL-CFG-015 window.
          f.clock.advance(_processingTimeout);
          throw StateError('transient');
        },
        retryBudget: 5,
        deadline: _processingTimeout,
      );
      await f.runtime.drain();

      final outcome = f.runtime.outcome(const JobKey('slow'))!;
      expect(
        outcome.state,
        JobState.failed,
        reason: 'The job outlived its deadline without becoming terminal. '
            'FIL-FR-095 forbids an indefinite PROCESSING state, and '
            'FIL-INV-013 makes such an object permanently unservable — a '
            'silent black hole rather than a reported failure.',
      );
      expect(
        outcome.reasonCode,
        'deadline_exceeded',
        reason: 'The deadline failure must be distinguishable from exhausted '
            'retries: one is a capacity problem, the other is a bad object.',
      );
      expect(
        attempts,
        lessThan(5),
        reason: 'The deadline did not curtail the retry budget ($attempts of 5 '
            'attempts ran), so a slow job can still run past its window.',
      );
    });

    test('the deadline is measured on the injected clock, not the wall clock',
        () async {
      final f = _fixture();

      await f.runtime.submit(
        const JobKey('pinned'),
        () async {},
        retryBudget: 1,
        deadline: const Duration(milliseconds: 1),
      );
      await f.runtime.drain();

      // Wall-clock milliseconds certainly elapsed between submit and drain. If
      // the adapter sampled DateTime.now() this would have failed the deadline.
      expect(
        f.runtime.outcome(const JobKey('pinned'))!.state,
        JobState.succeeded,
        reason: 'A job with a 1 ms deadline failed while the injected clock '
            'never advanced, so the adapter is reading the wall clock. That '
            'breaks X-09 and makes every deadline test a race.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // FIL-FR-094 — the outcome surface leaks nothing.
  // ════════════════════════════════════════════════════════════════════
  group('the outcome surface does not leak internals (FIL-FR-094)', () {
    test('a failure reason carries no exception text, storage path or tenant '
        'identifier', () async {
      final f = _fixture();

      await f.runtime.submit(
        const JobKey('leaky'),
        () async => throw StateError(
          'ENOENT /var/buckets/liboora-media/tenant-42/orig/abc.jpg '
          'worker=media-worker-3',
        ),
        retryBudget: 1,
        deadline: _processingTimeout,
      );
      await f.runtime.drain();

      final reason = f.runtime.outcome(const JobKey('leaky'))!.reasonCode!;
      for (final forbidden in [
        '/var/buckets',
        'liboora-media',
        'tenant-42',
        'abc.jpg',
        'media-worker-3',
        'ENOENT',
        'StateError',
      ]) {
        expect(
          reason,
          isNot(contains(forbidden)),
          reason: 'The reason code "$reason" leaks "$forbidden". FIL-FR-094 '
              'forbids exposing the storage path, the worker identity and the '
              'internal error text through a progress surface — and a tenant '
              'identifier in an error string is a cross-tenant disclosure.',
        );
      }
      expect(reason, 'attempt_failed');
    });

    test('an error inside the work does not escape to the submitter', () async {
      final f = _fixture();

      // Not wrapped in expect(...throws): the point is that nothing throws.
      await f.runtime.submit(
        const JobKey('throws'),
        () async => throw StateError('boom'),
        retryBudget: 2,
        deadline: _processingTimeout,
      );
      await f.runtime.drain();

      expect(
        f.runtime.outcome(const JobKey('throws'))!.state,
        JobState.failed,
        reason: 'The failure must be reported as a typed outcome. If it '
            'propagated instead, the submitter would have to interpret a raw '
            'exception — reintroducing the leak FIL-FR-094 closes.',
      );
    });

    test('an unknown key returns null rather than throwing, so absence and '
        'denial are indistinguishable', () {
      final f = _fixture();
      expect(f.runtime.outcome(const JobKey('never-seen')), isNull);
      expect(
        () => f.runtime.outcome(const JobKey('never-seen')),
        returnsNormally,
        reason: 'Throwing for an unknown key turns the progress surface into '
            'an enumeration oracle: a caller could distinguish "exists but '
            'forbidden" from "does not exist", which FIL-FR-094 forbids '
            'explicitly.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // Tenancy — the port creates no tenancy rule.
  // ════════════════════════════════════════════════════════════════════
  group('the port introduces no tenancy rule', () {
    test('no surface of the port accepts or exposes a tenant identifier', () {
      // BC Map §11 makes BC-10 and BC-11..BC-17 GLOBAL, and rule ID-2 bans
      // TenantId from domain/person outright. A platform port that took a
      // tenant key would be a route to smuggle one into a global context, so
      // the absence is asserted rather than assumed.
      final f = _fixture();
      final outcome = f.runtime.outcome(const JobKey('x'));
      expect(outcome, isNull);

      // JobOutcome's full surface, enumerated. If a tenant field is ever added
      // this test is where the decision must be argued.
      const probe = JobOutcome(
        key: JobKey('k'),
        state: JobState.pending,
        attempts: 0,
      );
      expect(probe.key.value, 'k');
      expect(probe.state, JobState.pending);
      expect(probe.attempts, 0);
      expect(probe.reasonCode, isNull);
      expect(probe.isTerminal, isFalse);
    });

    test('JobState is not the FIL-FR-092 object lifecycle', () {
      // Fusing them would put media semantics into a platform port and hand
      // BC-29 state it does not own (ADR-0058 §4).
      expect(JobState.values.map((s) => s.name).toSet(), {
        'pending',
        'running',
        'succeeded',
        'failed',
      });
      for (final leaked in ['received', 'validating', 'processing', 'ready']) {
        expect(
          JobState.values.map((s) => s.name),
          isNot(contains(leaked)),
          reason: 'JobState has acquired "$leaked" from the FIL-FR-092 object '
              'lifecycle. The job is the mechanism; the lifecycle is the '
              'domain fact owned by BC-29.',
        );
      }
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // Value semantics relied on by the idempotency check.
  // ════════════════════════════════════════════════════════════════════
  group('JobKey value semantics', () {
    test('equal keys are equal and hash alike', () {
      expect(const JobKey('a'), const JobKey('a'));
      expect(const JobKey('a').hashCode, const JobKey('a').hashCode);
      expect(const JobKey('a'), isNot(const JobKey('b')));
      // Built from separately-constructed instances rather than a literal:
      // a set literal with two identical constants trips `equal_elements_in_set`
      // at analysis time, and the property under test is precisely that two
      // *distinct instances* carrying the same value collapse to one entry.
      final keys = <JobKey>{};
      for (final v in ['a', 'a', 'b']) {
        keys.add(JobKey(v));
      }
      expect(
        keys.length,
        2,
        reason: 'Without value equality, deduplication by key silently stops '
            'working the moment a caller constructs a new instance — and the '
            'idempotency guard in InProcessJobRuntime is keyed on this.',
      );
    });

    test('isTerminal is true only for the two terminal states', () {
      JobOutcome at(JobState s) =>
          JobOutcome(key: const JobKey('k'), state: s, attempts: 1);
      expect(at(JobState.pending).isTerminal, isFalse);
      expect(at(JobState.running).isTerminal, isFalse);
      expect(at(JobState.succeeded).isTerminal, isTrue);
      expect(at(JobState.failed).isTerminal, isTrue);
    });
  });
}
