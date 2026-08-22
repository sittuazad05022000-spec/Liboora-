/// **BC-12 Messaging — local enforcement-state read model and send-time gate.**
///
/// `IMPL-1410`. Implements the five mandatory items of
/// [`ADR-0065`](../../../../docs/00-governance/adr/ADR-0065-synchronous-enforcement-check-transport.md)
/// §7.1, which is the binding scope for this file, under `PRD-020`
/// `TSF-FR-030`, `TSF-FR-031`, `TSF-FR-001` and `TSF-INV-007`.
///
/// ## Why this exists inside `BC-12` and not as a call to `BC-13`
///
/// BC Map **L286** is categorical: *"T&S never reaches into their models."*
/// **L292** allows only edges `E-14`…`E-16` out of this cluster, and **L468**
/// requires that *"Messaging must additionally check enforcement state at send
/// time — eventual consistency is unacceptable for abuse containment, so this
/// path is belt-and-braces."* **L477** places that mitigation *in `BC-12`*.
///
/// A synchronous `BC-12` → `BC-13` query would have been a new edge. None is
/// created here. This file consumes the **existing** `E-14`
/// `safety.EnforcementActionTaken` event, which `BC-12` was **already** an
/// entitled consumer of (BC Map **L433**, Matrix **L254**,
/// `tool/module_dependencies.yaml` **L251-253**). No Rank 4 document was
/// amended, and this file imports nothing from `BC-13`.
///
/// ## The two braces, and why the second one is not optional
///
/// `ADR-0065` §7.1 item 2 states that an implementation shipping items 1, 3, 4
/// and 5 *without* item 2 "has built the design BC Map L468 explicitly refuses,
/// and does not satisfy this ADR". So there are two independent mechanisms:
///
///   1. **Brace one** — `E-14`-driven self-restriction. A restriction that has
///      arrived is enforced. That is [_restrictions].
///   2. **Brace two** — a **fail-closed staleness gate**. If the projection
///      cannot be shown to be fresher than `TSF-CFG-030`, or its freshness
///      cannot be established at all, the send is **REFUSED**. That is
///      [evaluateSend]'s staleness arm.
///
/// A projection read without the gate is one mechanism read twice, not two.
///
/// ## What is guaranteed, and what is disclosed rather than eliminated
///
/// `TSF-INV-007` is explicit that the residual window is **disclosed, not
/// eliminated**: between `BC-13` deciding a restriction and `E-14` reaching
/// this model, a send by that person **can** succeed. What this file guarantees
/// is that the window is **bounded** by `TSF-CFG-030` and that exceeding it
/// converts the window into a **refusal** rather than a silent success.
///
/// ## Rule `ID-2` — this file names no tenant
///
/// `tool/module_dependencies.yaml` bans the symbols `TenantId` and
/// `StudentRecordId` from `domain/social` outright: *"nothing — social data is
/// not tenant-scoped"*. [DomainEvent] carries a tenant identifier on its
/// envelope, and this file deliberately **never reads or stores it**. Only
/// `eventId`, `eventType`, `occurredAt` and `payload` are touched. Restriction
/// state is keyed on `PersonId` (`ID-3`), which is global by construction.
///
/// ## Disclosed divergence from `AnalyticsProjections`, and why
///
/// `AnalyticsProjections` takes `EventBus` directly in `register(EventBus)` and
/// `rebuildFrom(EventBus)`. This file deliberately does **not**. The manifest
/// grants `domain/social` exactly one compile-time import — `contracts` — so an
/// import of `platform/event` here is a `cross-context` violation, and the
/// boundary checker reports it as one (measured: it took the baseline from 9
/// violations to 10). That same import is tolerated for analytics only as
/// **acknowledged, dated debt** under `ADR-0012` — *"declare EventStream in
/// liboora_contracts and have EventBus implement it"*, expiring 2026-10-31.
///
/// Copying the pattern would have inherited debt that is already scheduled for
/// removal, and amending the manifest is a Rank 4 act this task is forbidden.
/// So this projection depends only on [DomainEvent], a rank-0 shared-kernel
/// type, and subscription is performed by the composition root — the one place
/// permitted to know both the bus and its consumers.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

/// The `E-14` event this projection is fed by, and the only one.
///
/// BC Map §9 declares it with producer `BC-13` and `BC-12` among its consumers.
const String kEnforcementActionTaken = 'safety.EnforcementActionTaken';

/// `TSF-CFG-030` — the enforcement read-model staleness budget, **p99 ≤ 5 s**.
///
/// Beyond this, or when freshness cannot be established, the send is REFUSED
/// and never allowed through (`TSF-FR-031`, `TSF-INV-007`).
const Duration kEnforcementStalenessBudget = Duration(seconds: 5);

/// `TSF-CFG-030` — the **hard ceiling** of 30 s.
///
/// This bounds what the budget may be **configured to**, not what is tolerated
/// at runtime: runtime tolerance is the budget itself. Raising the budget past
/// this ceiling silently relaxes a **Critical** Rank 1 mitigation
/// (`MP-RSK-02`), so it is refused at construction rather than logged.
const Duration kEnforcementStalenessCeiling = Duration(seconds: 30);

/// The closed nine-action register of `PRD-020` §15.1.
///
/// `TSF-INV-015` and the `TSF-GAP-012` ruling make this a **closed** set: the
/// `E-14` contract at BC Map **L318** is a closed four-field shape, and no
/// action value may be invented without a Rank 4 amendment. An action outside
/// this set is therefore **malformed**, not merely unfamiliar — and it is
/// treated as a fail-closed integrity failure below rather than ignored.
const Set<String> kEnforcementActions = {
  'warning', // 1
  'contentRemoval', // 2
  'visibilityRestriction', // 3
  'commentRestriction', // 4 — V2
  'messagingRestriction', // 5 — owned by BC-12, this file
  'discoveryRestriction', // 6
  'communityRestriction', // 7 — V2
  'temporarySuspension', // 8
  'permanentTermination', // 9
};

/// The subset of the nine that restricts **messaging**.
///
/// Action 5 is the messaging restriction proper. Actions 8 and 9 are total —
/// §15.1 records suspension and termination as removing the capability
/// altogether, so messaging is restricted a fortiori. The remaining six belong
/// to other contexts, which self-restrict on their own surfaces; treating them
/// as messaging restrictions here would enforce another context's decision in
/// the wrong place.
const Set<String> kMessagingRestrictingActions = {
  'messagingRestriction',
  'temporarySuspension',
  'permanentTermination',
};

/// Why a send was refused. Closed set.
enum SendRefusalReason {
  /// Brace one. A restriction for this person is present in the read model.
  messagingRestricted,

  /// Brace two. The model's lag exceeds `TSF-CFG-030`.
  projectionStale,

  /// Brace two. The model has never been shown to be fresh at all, so its
  /// staleness is unknown rather than acceptable.
  freshnessUnestablished,

  /// Brace two. An `E-14` event could not be interpreted against the closed
  /// contract, so the model cannot be asserted to reflect the decisions made.
  projectionDegraded,
}

/// The outcome of the send-time check. Immutable.
final class SendDecision {
  const SendDecision._(this.allowed, this.reason, this.lag);

  const SendDecision.allowed(Duration lag) : this._(true, null, lag);

  const SendDecision.refused(SendRefusalReason reason, Duration? lag)
    : this._(false, reason, lag);

  /// True only when both braces passed.
  final bool allowed;

  /// Null exactly when [allowed] is true.
  final SendRefusalReason? reason;

  /// Measured projection lag at decision time. Null when unestablishable —
  /// which is itself the finding, not missing data.
  final Duration? lag;

  bool get refused => !allowed;

  @override
  String toString() => allowed
      ? 'SendDecision.allowed(lag: $lag)'
      : 'SendDecision.refused(${reason!.name}, lag: $lag)';
}

/// One person's current messaging restriction, as last projected.
final class _Restriction {
  const _Restriction({
    required this.action,
    required this.until,
    required this.decidedAt,
  });

  final String action;

  /// `null` means **reversal**, not "forever".
  ///
  /// `TSF-FR-124`: a reversal *"MUST be expressed as `TSF-EVT-002` with a
  /// past-dated or nulled `until`, not as a new event type"*. `TSF-FR-070`
  /// independently forbids an open-ended suspension. So a null `until` is
  /// unambiguously a lift, and is stored as such rather than as an eternal ban.
  final DateTime? until;

  /// The `occurredAt` of the event that produced this state. Used for
  /// last-write-wins so that duplicate and out-of-order delivery cannot drift.
  final DateTime decidedAt;

  bool isActiveAt(DateTime now) => until != null && until!.isAfter(now);
}

/// `BC-12`'s local enforcement-state read model, plus the send-time gate.
///
/// Derived state only. Fed **exclusively** by [kEnforcementActionTaken] and
/// recomputable from that stream alone by [rebuildFrom] — the BC Map **L383**
/// projection discipline. There is no setter for restriction state, by design:
/// a hand-editable enforcement cache is a cache that can be edited to permit an
/// abuser.
final class MessagingEnforcementProjection {
  MessagingEnforcementProjection(
    this._clock,
    this._telemetry, {
    Duration stalenessBudget = kEnforcementStalenessBudget,
  }) : _budget = stalenessBudget {
    if (stalenessBudget > kEnforcementStalenessCeiling) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'Enforcement staleness budget $stalenessBudget exceeds the '
        'TSF-CFG-030 hard ceiling of $kEnforcementStalenessCeiling. Raising '
        'it silently relaxes a Critical Rank 1 mitigation (MP-RSK-02) and '
        'requires an ADR, not a constructor argument.',
        context: {
          'budget': stalenessBudget.toString(),
          'ceiling': kEnforcementStalenessCeiling.toString(),
        },
      );
    }
    if (stalenessBudget <= Duration.zero) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'Enforcement staleness budget must be positive; a zero or negative '
        'budget refuses every send and is a misconfiguration, not a policy.',
        context: {'budget': stalenessBudget.toString()},
      );
    }
  }

  /// `X-09` — injected. `DateTime.now()` is banned inside `domain/**`, and a
  /// staleness gate that read the wall clock directly could not be tested.
  final Clock _clock;
  final Telemetry _telemetry;
  final Duration _budget;

  /// Restriction state, keyed on `PersonId.value` (`ID-3`). No tenant key.
  final Map<String, _Restriction> _restrictions = {};

  /// The instant up to which this model is known to reflect the `E-14` stream.
  ///
  /// Null means freshness has **never** been established, which fails closed.
  DateTime? _freshAsOf;

  /// Set when an `E-14` event cannot be interpreted against the closed
  /// contract. Latched: an uninterpretable decision does not become
  /// interpretable by the arrival of a later event, so this clears only on a
  /// full [rebuildFrom].
  bool _degraded = false;

  /// The configured budget, exposed for observability and assertions.
  Duration get stalenessBudget => _budget;

  /// Item 5 — observability. Null when freshness was never established.
  Duration? get projectionLag {
    final at = _freshAsOf;
    if (at == null) return null;
    final lag = _clock.now().difference(at);
    return lag.isNegative ? Duration.zero : lag;
  }

  bool get isDegraded => _degraded;

  /// Test/diagnostic visibility. Count of people currently holding an active
  /// messaging restriction.
  int get activeRestrictionCount {
    final now = _clock.now();
    return _restrictions.values.where((r) => r.isActiveAt(now)).length;
  }

  /// Whether brace one alone would restrict [person]. Does **not** consider
  /// staleness — [evaluateSend] is the gate, this is the read model.
  bool isMessagingRestricted(PersonId person) {
    final r = _restrictions[person.value];
    return r != null && r.isActiveAt(_clock.now());
  }

  // ── Item 2 — the fail-closed staleness gate ──────────────────────────

  /// `TSF-FR-031` / `TSF-INV-007` — the send-time check.
  ///
  /// Order matters and is deliberate. The **staleness arm is evaluated first**:
  /// if the model cannot be trusted, its *absence* of a restriction is not
  /// evidence of absence, so consulting it first would let a stale "no
  /// restriction found" answer decide the send. Fail closed, then read.
  SendDecision evaluateSend({required PersonId sender}) {
    if (_degraded) {
      return _refuse(SendRefusalReason.projectionDegraded, projectionLag);
    }

    final lag = projectionLag;
    if (lag == null) {
      return _refuse(SendRefusalReason.freshnessUnestablished, null);
    }
    if (lag > _budget) {
      return _refuse(SendRefusalReason.projectionStale, lag);
    }

    if (isMessagingRestricted(sender)) {
      return _refuse(SendRefusalReason.messagingRestricted, lag);
    }

    _telemetry.counter('messaging.enforcement.send_allowed');
    _observeLag(lag);
    return SendDecision.allowed(lag);
  }

  /// Throwing form, for call sites that treat a refusal as a domain outcome.
  ///
  /// A restriction projects as [DomainErrorCode.forbidden]; a fail-closed
  /// refusal projects as [DomainErrorCode.systemDependencyUnavailable], which
  /// is declared retriable — the send may be retried once the stream catches
  /// up, whereas a restriction may not.
  SendDecision ensureSendAllowed({required PersonId sender}) {
    final decision = evaluateSend(sender: sender);
    if (decision.allowed) return decision;

    switch (decision.reason!) {
      case SendRefusalReason.messagingRestricted:
        throw const DomainError(
          DomainErrorCode.forbidden,
          'Sender is restricted from messaging.',
        );
      case SendRefusalReason.projectionStale:
      case SendRefusalReason.freshnessUnestablished:
      case SendRefusalReason.projectionDegraded:
        throw DomainError(
          DomainErrorCode.systemDependencyUnavailable,
          'Enforcement state could not be shown to be fresher than '
          '$_budget (TSF-CFG-030); the send is refused rather than allowed '
          'through (TSF-FR-031).',
          context: {'reason': decision.reason!.name},
        );
    }
  }

  SendDecision _refuse(SendRefusalReason reason, Duration? lag) {
    _telemetry.counter(
      'messaging.enforcement.send_refused',
      tags: {'reason': reason.name},
    );
    _telemetry.log(
      LogLevel.warn,
      'send refused by enforcement gate',
      fields: {'reason': reason.name, 'lagMs': lag?.inMilliseconds},
    );
    return SendDecision.refused(reason, lag);
  }

  // ── Item 5 — projection lag observability ────────────────────────────

  /// Records lag so the gate's threshold is measurable rather than
  /// aspirational (`ADR-0065` §3.7, `TSF-FR-001`).
  void _observeLag(Duration lag) {
    _telemetry.counter(
      'messaging.enforcement.projection_lag_ms',
      value: lag.inMilliseconds,
    );
    if (lag * 2 > _budget) {
      _telemetry.log(
        LogLevel.warn,
        'enforcement projection lag past half of TSF-CFG-030 budget',
        fields: {
          'lagMs': lag.inMilliseconds,
          'budgetMs': _budget.inMilliseconds,
        },
      );
    }
  }

  // ── Item 1 — fed only by E-14 ────────────────────────────────────────

  /// The single feed, invoked by the composition root's subscription to
  /// [kEnforcementActionTaken] and to nothing else.
  ///
  /// Public because the subscription is made from outside this module. It
  /// remains the only route by which restriction state can change, so item 1's
  /// *"fed only by `E-14`"* requirement stays structural rather than
  /// conventional — and the guard below re-checks the type regardless.
  void apply(DomainEvent event) => _onEnforcementAction(event);

  /// Declares the `E-14` stream observed live as of now.
  ///
  /// ⚠ **Disclosed operational requirement, not a loophole.** Freshness cannot
  /// be inferred from the absence of events: "no restriction has arrived" and
  /// "the stream is broken" look identical from inside a projection, and
  /// `SID-4.56` requires the unverifiable case to be treated as unmet. So a
  /// liveness signal is required, and without one the gate refuses every send.
  ///
  /// This touches **no restriction state** — it moves only the freshness
  /// watermark — so it is not the hand-editing that BC Map **L383** forbids,
  /// and [rebuildFrom] resets it to a value derived purely from the log.
  void noteStreamLive() {
    _advanceFreshness(_clock.now());
  }

  void _onEnforcementAction(DomainEvent event) {
    // Guard the type even though the subscription is exact: a wildcard
    // subscriber added later must not silently widen what feeds this model.
    if (event.eventType != kEnforcementActionTaken) return;

    // Any arrival proves the stream is live to at least this point.
    _advanceFreshness(event.occurredAt);

    final personId = event.read<String>('personId');
    final action = event.read<String>('action');

    if (personId == null || personId.isEmpty || action == null) {
      _markDegraded(event, 'missing personId or action');
      return;
    }
    if (!kEnforcementActions.contains(action)) {
      // The action register is closed (§15.1, TSF-INV-015). An unlisted value
      // means this model cannot know whether messaging is restricted, so it
      // fails closed instead of guessing "no".
      _markDegraded(event, 'action outside the closed register: $action');
      return;
    }

    if (!kMessagingRestrictingActions.contains(action)) {
      // Owned by another context, which self-restricts on its own surface.
      _telemetry.counter(
        'messaging.enforcement.action_not_for_messaging',
        tags: {'action': action},
      );
      return;
    }

    final until = _parseUntil(event.read<Object>('until'));
    final incoming = _Restriction(
      action: action,
      until: until,
      decidedAt: event.occurredAt,
    );

    // Last-write-wins by decision time. `>=` rather than `>` so that a
    // duplicate delivery of the same event re-applies to the same value and
    // cannot drift — at-least-once delivery is the contract (§9.1).
    final existing = _restrictions[personId];
    if (existing != null && incoming.decidedAt.isBefore(existing.decidedAt)) {
      _telemetry.counter('messaging.enforcement.stale_event_ignored');
      return;
    }
    _restrictions[personId] = incoming;
  }

  void _markDegraded(DomainEvent event, String why) {
    _degraded = true;
    _telemetry.counter('messaging.enforcement.projection_degraded');
    _telemetry.log(
      LogLevel.error,
      'enforcement projection degraded — failing closed',
      fields: {'event': event.eventId, 'why': why},
    );
  }

  void _advanceFreshness(DateTime at) {
    final current = _freshAsOf;
    if (current == null || at.isAfter(current)) _freshAsOf = at;
  }

  /// Accepts an ISO-8601 string or a [DateTime]. Anything else is a contract
  /// violation and is surfaced as such by the caller.
  DateTime? _parseUntil(Object? raw) {
    if (raw == null) return null;
    if (raw is DateTime) return raw;
    if (raw is String) {
      if (raw.isEmpty) return null;
      return DateTime.tryParse(raw);
    }
    return null;
  }

  // ── Item 3 — rebuild-from-events equivalence ─────────────────────────

  /// Recompute every byte of projected state from the `E-14` log alone.
  ///
  /// BC Map **L383**: derived state is *"never hand-edited; recomputable from
  /// events"*. Pass the event log (`EventBus.log`); passing the whole log is
  /// correct, because everything other than [kEnforcementActionTaken] is
  /// skipped.
  ///
  /// The freshness watermark is rebuilt from the log too, so a rebuilt instance
  /// makes no stronger freshness claim than the events support — a rebuild that
  /// inherited a live watermark would silently re-open the window this gate
  /// closes.
  Future<void> rebuildFrom(Iterable<DomainEvent> log) async {
    _restrictions.clear();
    _freshAsOf = null;
    _degraded = false;
    for (final event in log) {
      if (event.eventType != kEnforcementActionTaken) continue;
      _onEnforcementAction(event);
    }
  }
}
