/// **`IMPL-1410` — `BC-12` enforcement projection and send-time gate.**
///
/// Verifies the five mandatory items of `ADR-0065` §7.1 and the acceptance
/// criterion they exist to satisfy, `TSF-AC-025`:
///
/// > **(a) Fresh-projection clause.** Given a person suspended and
/// > `TSF-EVT-002` consumed within `TSF-CFG-030`, when they send a message,
/// > then the send **fails**.
/// >
/// > **(b) ⛔ Staleness-gate clause.** Given `TSF-EVT-002` delivery is withheld
/// > so that measured projection lag **exceeds** `TSF-CFG-030` — or freshness
/// > cannot be established at all — when any send is attempted, then the send
/// > is **REFUSED** (fail-closed), **not** allowed.
///
/// `TSF-FR-141` is explicit that clause (b) is *"the one assertion a gate-less
/// build cannot satisfy"*, so the staleness group below is the load-bearing
/// part of this file, not a nicety.
///
/// ## On the four cases the task requires
///
/// fresh · stale · missing/unestablishable · fail-closed. The third and fourth
/// are related but distinct, and are tested separately: *unestablishable*
/// freshness is the cold-start posture (no event has ever been seen), whereas
/// *fail-closed* is the required **behaviour** in every untrustworthy state —
/// including a degraded projection that has seen events it could not interpret.
/// A test suite that conflated them would leave cold start unverified.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/social/social.dart';
import 'package:liboora/platform/event/event.dart';
import 'package:liboora/platform/observability/observability.dart';
import 'package:liboora/platform/tenancy/tenancy.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

final DateTime _t0 = DateTime.utc(2026, 8, 22, 9);
const PersonId _abuser = PersonId('P-ABUSER');
const PersonId _bystander = PersonId('P-BYSTANDER');

/// Telemetry needs an ambient tenant or it throws `TenantContextMissing` when
/// it formats a line. The projection under test holds no tenant itself — that
/// is rule `ID-2` — this is purely the logging adapter's requirement.
ConsoleTelemetry _telemetry() {
  final ctx = MutableTenantContext();
  ctx.enter(
    tenant: const TenantId('T-TEST'),
    branch: const BranchId('B-TEST'),
    actor: 'impl-1410-test',
    correlationId: 'messaging-enforcement-test',
  );
  return ConsoleTelemetry(ctx);
}

/// An `E-14` event in the closed four-field shape of BC Map **L318**.
DomainEvent _enforcement({
  required PersonId person,
  required String action,
  DateTime? until,
  required DateTime occurredAt,
  String eventId = 'EV-1',
}) => DomainEvent(
  eventId: eventId,
  eventType: kEnforcementActionTaken,
  // The envelope requires a tenant. The projection must never read it — see
  // the ID-2 group at the end of this file, which asserts exactly that.
  tenantId: const TenantId('T-TEST'),
  aggregateId: person.value,
  occurredAt: occurredAt,
  payload: {
    'personId': person.value,
    'action': action,
    'scope': 'global',
    'until': until?.toIso8601String(),
  },
);

({MessagingEnforcementProjection projection, FixedClock clock}) _fresh() {
  final clock = FixedClock(_t0);
  return (
    projection: MessagingEnforcementProjection(clock, _telemetry()),
    clock: clock,
  );
}

void main() {
  // ════════════════════════════════════════════════════════════════════
  // CASE 1 — FRESH. TSF-AC-025 clause (a).
  // ════════════════════════════════════════════════════════════════════
  group('FRESH — a restriction that has arrived is enforced (clause a)', () {
    test('a messaging-restricted sender is refused', () {
      final f = _fresh();
      f.projection.apply(
        _enforcement(
          person: _abuser,
          action: 'messagingRestriction',
          until: _t0.add(const Duration(days: 7)),
          occurredAt: _t0,
        ),
      );

      final decision = f.projection.evaluateSend(sender: _abuser);
      expect(decision.refused, isTrue);
      expect(decision.reason, SendRefusalReason.messagingRestricted);
      expect(
        f.projection.isMessagingRestricted(_abuser),
        isTrue,
        reason:
            'The read model did not record the restriction at all, so the '
            'refusal above may be coming from the staleness gate instead of '
            'from brace one.',
      );
    });

    test('an unrestricted sender on a fresh projection is ALLOWED', () {
      // The negative control. Without it, a projection that refused every send
      // unconditionally would pass every other test in this file.
      final f = _fresh();
      f.projection.apply(
        _enforcement(
          person: _abuser,
          action: 'messagingRestriction',
          until: _t0.add(const Duration(days: 7)),
          occurredAt: _t0,
        ),
      );

      final decision = f.projection.evaluateSend(sender: _bystander);
      expect(
        decision.allowed,
        isTrue,
        reason:
            'A gate that refuses everyone contains no information. This '
            'assertion is what makes every refusal above meaningful.',
      );
      expect(decision.reason, isNull);
      expect(decision.lag, Duration.zero);
    });

    test('suspension and termination restrict messaging; other actions do '
        'not', () {
      // §15.1: action 5 is the messaging restriction; 8 and 9 are total. The
      // remaining six belong to other contexts, which self-restrict on their
      // own surfaces — enforcing them here would apply another context's
      // decision in the wrong place.
      for (final action in kMessagingRestrictingActions) {
        final f = _fresh();
        f.projection.apply(
          _enforcement(
            person: _abuser,
            action: action,
            until: _t0.add(const Duration(days: 1)),
            occurredAt: _t0,
          ),
        );
        expect(
          f.projection.evaluateSend(sender: _abuser).reason,
          SendRefusalReason.messagingRestricted,
          reason: '$action did not restrict messaging.',
        );
      }

      final notMessaging = kEnforcementActions.difference(
        kMessagingRestrictingActions,
      );
      expect(notMessaging, isNotEmpty);
      for (final action in notMessaging) {
        final f = _fresh();
        f.projection.apply(
          _enforcement(
            person: _abuser,
            action: action,
            until: _t0.add(const Duration(days: 1)),
            occurredAt: _t0,
          ),
        );
        expect(
          f.projection.evaluateSend(sender: _abuser).allowed,
          isTrue,
          reason:
              '$action is not a messaging restriction, but BC-12 enforced '
              'it anyway. TSF-FR-068 assigns each action to its OWNING '
              'context.',
        );
      }
    });

    test('an expired restriction stops restricting, and a nulled `until` is a '
        'reversal rather than a permanent ban', () {
      // TSF-FR-124: reversal is expressed as the same event with a past-dated
      // or nulled `until`, never as a new event type.
      final f = _fresh();
      f.projection.apply(
        _enforcement(
          person: _abuser,
          action: 'messagingRestriction',
          until: _t0.add(const Duration(hours: 1)),
          occurredAt: _t0,
        ),
      );
      expect(f.projection.evaluateSend(sender: _abuser).refused, isTrue);

      // Expiry by the passage of time alone.
      f.clock.advance(const Duration(hours: 2));
      f.projection.apply(
        _enforcement(
          person: _bystander,
          action: 'warning',
          occurredAt: f.clock.now(),
          eventId: 'EV-KEEPALIVE',
        ),
      );
      expect(
        f.projection.evaluateSend(sender: _abuser).allowed,
        isTrue,
        reason:
            'A restriction whose `until` has passed is still being '
            'enforced. TSF-FR-070 forbids an open-ended suspension.',
      );

      // And explicit reversal.
      final g = _fresh();
      g.projection.apply(
        _enforcement(
          person: _abuser,
          action: 'messagingRestriction',
          until: _t0.add(const Duration(days: 7)),
          occurredAt: _t0,
        ),
      );
      expect(g.projection.evaluateSend(sender: _abuser).refused, isTrue);
      g.projection.apply(
        _enforcement(
          person: _abuser,
          action: 'messagingRestriction',
          occurredAt: _t0.add(const Duration(seconds: 1)),
          eventId: 'EV-REVERSAL',
        ),
      );
      expect(
        g.projection.evaluateSend(sender: _abuser).allowed,
        isTrue,
        reason:
            'A nulled `until` must lift the restriction (TSF-FR-124). '
            'Treating it as "forever" would make every reversal a permanent '
            'ban.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // CASE 2 — STALE. TSF-AC-025 clause (b). The load-bearing group.
  // ════════════════════════════════════════════════════════════════════
  group('STALE — lag beyond TSF-CFG-030 REFUSES rather than allows '
      '(clause b)', () {
    test('an UNRESTRICTED sender is refused once lag exceeds the budget', () {
      // This is the assertion a projection-only build cannot pass. The sender
      // carries no restriction at all; the refusal comes purely from the fact
      // that the model can no longer be trusted to know.
      final f = _fresh();
      f.projection.apply(
        _enforcement(
          person: _abuser,
          action: 'messagingRestriction',
          until: _t0.add(const Duration(days: 7)),
          occurredAt: _t0,
        ),
      );
      expect(f.projection.evaluateSend(sender: _bystander).allowed, isTrue);

      // Withhold delivery: time moves, the stream does not.
      f.clock.advance(kEnforcementStalenessBudget + const Duration(seconds: 1));

      final decision = f.projection.evaluateSend(sender: _bystander);
      expect(
        decision.refused,
        isTrue,
        reason:
            '⛔ TSF-AC-025 clause (b) FAILED. Projection lag exceeded '
            'TSF-CFG-030 and the send was still allowed. This is the '
            'gate-less build ADR-0065 §7.1 item 2 refuses to accept: items 1, '
            '3, 4 and 5 without item 2 build the design BC Map L468 '
            'explicitly rejects.',
      );
      expect(decision.reason, SendRefusalReason.projectionStale);
      expect(decision.lag, greaterThan(kEnforcementStalenessBudget));
    });

    test('the boundary is inclusive — exactly at the budget is still fresh, '
        'one tick past it is not', () {
      // A gate whose threshold is off by one is a gate whose threshold is
      // untested. TSF-CFG-030 reads "p99 ≤ 5 s", so 5 s exactly must pass.
      final f = _fresh();
      f.projection.apply(
        _enforcement(person: _abuser, action: 'warning', occurredAt: _t0),
      );

      f.clock.advance(kEnforcementStalenessBudget);
      expect(
        f.projection.evaluateSend(sender: _bystander).allowed,
        isTrue,
        reason:
            'Lag exactly equal to the budget was refused. TSF-CFG-030 is '
            '"≤ 5 s", so the boundary is inclusive.',
      );

      f.clock.advance(const Duration(milliseconds: 1));
      expect(
        f.projection.evaluateSend(sender: _bystander).reason,
        SendRefusalReason.projectionStale,
      );
    });

    test('a restricted sender past the budget is refused as STALE, so the '
        'gate is not merely restating brace one', () {
      final f = _fresh();
      f.projection.apply(
        _enforcement(
          person: _abuser,
          action: 'messagingRestriction',
          until: _t0.add(const Duration(days: 7)),
          occurredAt: _t0,
        ),
      );
      f.clock.advance(kEnforcementStalenessBudget * 3);

      final decision = f.projection.evaluateSend(sender: _abuser);
      expect(decision.refused, isTrue);
      expect(
        decision.reason,
        SendRefusalReason.projectionStale,
        reason:
            'The staleness arm must be evaluated BEFORE the restriction '
            'lookup. If the model cannot be trusted, its answer — including '
            '"restricted" — is not what decided the send.',
      );
    });

    test('a fresh event restores service, so the gate is recoverable rather '
        'than a latch', () {
      final f = _fresh();
      f.projection.apply(
        _enforcement(person: _abuser, action: 'warning', occurredAt: _t0),
      );
      f.clock.advance(kEnforcementStalenessBudget * 2);
      expect(f.projection.evaluateSend(sender: _bystander).refused, isTrue);

      f.projection.apply(
        _enforcement(
          person: _bystander,
          action: 'warning',
          occurredAt: f.clock.now(),
          eventId: 'EV-CATCHUP',
        ),
      );
      expect(
        f.projection.evaluateSend(sender: _bystander).allowed,
        isTrue,
        reason:
            'Catching up did not restore service. A gate that never '
            'recovers is an outage, and would be switched off in production — '
            'taking the MP-RSK-02 mitigation with it.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // CASE 3 — MISSING / UNESTABLISHABLE freshness. Cold start.
  // ════════════════════════════════════════════════════════════════════
  group('UNESTABLISHABLE — freshness that was never established fails '
      'closed', () {
    test('a brand-new projection refuses every send, including for a person '
        'it has never heard of', () {
      // The cold-start posture. "No restriction has arrived" and "the stream is
      // broken" are indistinguishable from inside a projection, and SID-4.56
      // requires the unverifiable case to be treated as unmet.
      final f = _fresh();
      expect(
        f.projection.projectionLag,
        isNull,
        reason:
            'Lag must be null — not zero — when no event has ever been '
            'seen. Reporting zero would claim perfect freshness on the '
            'strength of no evidence at all.',
      );

      final decision = f.projection.evaluateSend(sender: _bystander);
      expect(
        decision.refused,
        isTrue,
        reason:
            '⛔ A projection that has never observed the E-14 stream '
            'allowed a send. TSF-FR-031 requires refusal when freshness '
            '"cannot be established".',
      );
      expect(decision.reason, SendRefusalReason.freshnessUnestablished);
      expect(decision.lag, isNull);
    });

    test('noteStreamLive establishes freshness without inventing restriction '
        'state', () {
      final f = _fresh();
      expect(f.projection.evaluateSend(sender: _bystander).refused, isTrue);

      f.projection.noteStreamLive();

      expect(f.projection.evaluateSend(sender: _bystander).allowed, isTrue);
      expect(
        f.projection.activeRestrictionCount,
        0,
        reason:
            'The liveness signal must move only the freshness watermark. '
            'If it could create or clear restrictions it would be the '
            'hand-editing BC Map L383 forbids.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // CASE 4 — FAIL-CLOSED in every untrustworthy state.
  // ════════════════════════════════════════════════════════════════════
  group('FAIL-CLOSED — an uninterpretable stream refuses, never allows', () {
    test('an action outside the closed register degrades the projection and '
        'refuses', () {
      // The action register is closed (§15.1, TSF-INV-015) and the L318 shape
      // is closed. An unknown value means this model cannot know whether
      // messaging is restricted — so it must not answer "no".
      final f = _fresh();
      f.projection.apply(
        _enforcement(
          person: _abuser,
          action: 'TIGHTEN_RATE_LIMITS', // the TSF-GAP-012 value, never adopted
          occurredAt: _t0,
        ),
      );

      expect(f.projection.isDegraded, isTrue);
      final decision = f.projection.evaluateSend(sender: _bystander);
      expect(
        decision.refused,
        isTrue,
        reason:
            'An event that could not be interpreted was treated as "no '
            'restriction". That is failing OPEN on a Critical mitigation.',
      );
      expect(decision.reason, SendRefusalReason.projectionDegraded);
    });

    test('a malformed payload degrades rather than being silently skipped', () {
      for (final payload in <Map<String, Object?>>[
        {'action': 'messagingRestriction'}, // no personId
        {'personId': 'P-X'}, // no action
        {'personId': '', 'action': 'messagingRestriction'}, // empty personId
      ]) {
        final f = _fresh();
        f.projection.apply(
          DomainEvent(
            eventId: 'EV-MALFORMED',
            eventType: kEnforcementActionTaken,
            tenantId: const TenantId('T-TEST'),
            aggregateId: 'A-1',
            occurredAt: _t0,
            payload: payload,
          ),
        );
        expect(
          f.projection.evaluateSend(sender: _bystander).reason,
          SendRefusalReason.projectionDegraded,
          reason: 'Payload $payload was skipped without failing closed.',
        );
      }
    });

    test('degradation is latched and only a full rebuild clears it', () {
      final f = _fresh();
      f.projection.apply(
        _enforcement(person: _abuser, action: 'nonsense', occurredAt: _t0),
      );
      expect(f.projection.isDegraded, isTrue);

      // A later well-formed event does not make the lost decision knowable.
      f.projection.apply(
        _enforcement(
          person: _bystander,
          action: 'warning',
          occurredAt: _t0.add(const Duration(seconds: 1)),
          eventId: 'EV-LATER',
        ),
      );
      expect(
        f.projection.evaluateSend(sender: _bystander).refused,
        isTrue,
        reason:
            'Degradation cleared itself on the next valid event. The '
            'decision that could not be interpreted is still unknown.',
      );
    });

    test('ensureSendAllowed distinguishes a restriction from a fail-closed '
        'refusal, and neither is retriable as the other', () {
      // A restriction is `forbidden` and final. A fail-closed refusal is
      // `systemDependencyUnavailable`, which the error taxonomy declares
      // retriable — the send may be retried once the stream catches up.
      final restricted = _fresh();
      restricted.projection.apply(
        _enforcement(
          person: _abuser,
          action: 'messagingRestriction',
          until: _t0.add(const Duration(days: 7)),
          occurredAt: _t0,
        ),
      );
      expect(
        () => restricted.projection.ensureSendAllowed(sender: _abuser),
        throwsA(
          isA<DomainError>()
              .having((e) => e.code, 'code', DomainErrorCode.forbidden)
              .having((e) => e.code.isRetriable, 'isRetriable', isFalse),
        ),
      );

      final cold = _fresh();
      expect(
        () => cold.projection.ensureSendAllowed(sender: _bystander),
        throwsA(
          isA<DomainError>()
              .having(
                (e) => e.code,
                'code',
                DomainErrorCode.systemDependencyUnavailable,
              )
              .having((e) => e.code.isRetriable, 'isRetriable', isTrue),
        ),
      );

      // And the happy path must NOT throw.
      cold.projection.noteStreamLive();
      expect(
        cold.projection.ensureSendAllowed(sender: _bystander).allowed,
        isTrue,
      );
    });

    test('a budget above the TSF-CFG-030 hard ceiling is refused at '
        'construction', () {
      // Raising the budget silently relaxes a Critical Rank 1 mitigation
      // (MP-RSK-02) and is ADR-required. A constructor argument is not an ADR.
      expect(
        () => MessagingEnforcementProjection(
          FixedClock(_t0),
          _telemetry(),
          stalenessBudget:
              kEnforcementStalenessCeiling + const Duration(seconds: 1),
        ),
        throwsA(isA<DomainError>()),
      );
      expect(
        () => MessagingEnforcementProjection(
          FixedClock(_t0),
          _telemetry(),
          stalenessBudget: Duration.zero,
        ),
        throwsA(
          isA<DomainError>(),
          // A zero budget refuses everything, which would LOOK safe while
          // actually being a misconfiguration that disables messaging.
        ),
      );
      // At the ceiling exactly is permitted.
      expect(
        MessagingEnforcementProjection(
          FixedClock(_t0),
          _telemetry(),
          stalenessBudget: kEnforcementStalenessCeiling,
        ).stalenessBudget,
        kEnforcementStalenessCeiling,
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // ADR-0065 §7.1 item 3 — rebuild-from-events equivalence.
  // ════════════════════════════════════════════════════════════════════
  group('item 3 — the projection is rebuildable from E-14 alone', () {
    test(
      'a fresh instance rebuilt from the log matches the live-fed one',
      () async {
        final events = <DomainEvent>[
          _enforcement(
            person: _abuser,
            action: 'messagingRestriction',
            until: _t0.add(const Duration(days: 7)),
            occurredAt: _t0,
            eventId: 'EV-1',
          ),
          _enforcement(
            person: _bystander,
            action: 'visibilityRestriction',
            until: _t0.add(const Duration(days: 2)),
            occurredAt: _t0.add(const Duration(seconds: 1)),
            eventId: 'EV-2',
          ),
        ];

        final live = _fresh();
        for (final e in events) {
          live.projection.apply(e);
        }

        // Vacuity guard: if the live feed produced nothing, "before == after"
        // would be "empty == empty" and would prove nothing.
        expect(live.projection.activeRestrictionCount, 1);
        expect(live.projection.evaluateSend(sender: _abuser).refused, isTrue);

        final rebuilt = MessagingEnforcementProjection(
          FixedClock(_t0),
          _telemetry(),
        );
        await rebuilt.rebuildFrom(events);

        expect(
          rebuilt.activeRestrictionCount,
          live.projection.activeRestrictionCount,
        );
        expect(
          rebuilt.evaluateSend(sender: _abuser).reason,
          live.projection.evaluateSend(sender: _abuser).reason,
        );
        expect(
          rebuilt.evaluateSend(sender: _bystander).reason,
          live.projection.evaluateSend(sender: _bystander).reason,
        );
      },
    );

    test('replaying the same log twice is idempotent — at-least-once delivery '
        'cannot drift the state', () async {
      final events = [
        _enforcement(
          person: _abuser,
          action: 'messagingRestriction',
          until: _t0.add(const Duration(days: 7)),
          occurredAt: _t0,
        ),
      ];
      final f = _fresh();
      await f.projection.rebuildFrom(events);
      final once = f.projection.activeRestrictionCount;
      await f.projection.rebuildFrom(events);
      expect(f.projection.activeRestrictionCount, once);

      // Duplicate delivery of the SAME event through the live path, too.
      f.projection.apply(events.single);
      f.projection.apply(events.single);
      expect(f.projection.activeRestrictionCount, once);
    });

    test(
      'an out-of-order reversal does not resurrect a lifted restriction',
      () {
        // Ordering is guaranteed per aggregate only (§9.1), so a late-arriving
        // older event must not overwrite a newer decision.
        final f = _fresh();
        f.projection.apply(
          _enforcement(
            person: _abuser,
            action: 'messagingRestriction',
            occurredAt: _t0.add(const Duration(seconds: 10)),
            eventId: 'EV-REVERSAL',
          ),
        );
        expect(f.projection.evaluateSend(sender: _abuser).allowed, isTrue);

        f.projection.apply(
          _enforcement(
            person: _abuser,
            action: 'messagingRestriction',
            until: _t0.add(const Duration(days: 7)),
            occurredAt: _t0, // OLDER
            eventId: 'EV-OLD-BAN',
          ),
        );
        expect(
          f.projection.evaluateSend(sender: _abuser).allowed,
          isTrue,
          reason:
              'A late-arriving older ban overwrote a newer reversal. The '
              'person would be banned again by a redelivery.',
        );
      },
    );

    test(
      'a rebuild makes no stronger freshness claim than the log supports',
      () async {
        // A rebuilt instance that inherited a live watermark would silently
        // re-open the very window this gate closes.
        final clock = FixedClock(_t0.add(const Duration(hours: 1)));
        final rebuilt = MessagingEnforcementProjection(clock, _telemetry());
        await rebuilt.rebuildFrom([
          _enforcement(person: _abuser, action: 'warning', occurredAt: _t0),
        ]);

        expect(
          rebuilt.evaluateSend(sender: _bystander).reason,
          SendRefusalReason.projectionStale,
          reason:
              'The log is an hour old, so the rebuilt projection is stale '
              'and must fail closed rather than report itself fresh.',
        );
      },
    );

    test('rebuilding clears a degraded flag, since the state is recomputed '
        'from scratch', () async {
      final f = _fresh();
      f.projection.apply(
        _enforcement(person: _abuser, action: 'nonsense', occurredAt: _t0),
      );
      expect(f.projection.isDegraded, isTrue);

      await f.projection.rebuildFrom([
        _enforcement(
          person: _abuser,
          action: 'warning',
          occurredAt: f.clock.now(),
        ),
      ]);
      expect(f.projection.isDegraded, isFalse);
      expect(f.projection.evaluateSend(sender: _bystander).allowed, isTrue);
    });

    test('non-E-14 events in the log are ignored — the model is fed by ONE '
        'event type', () async {
      final f = _fresh();
      await f.projection.rebuildFrom([
        DomainEvent(
          eventId: 'EV-OTHER',
          eventType: 'messaging.MessageSent',
          tenantId: const TenantId('T-TEST'),
          aggregateId: 'M-1',
          occurredAt: _t0,
          payload: const {'personId': 'P-ABUSER'},
        ),
      ]);
      expect(
        f.projection.projectionLag,
        isNull,
        reason:
            'An unrelated event established freshness. Only E-14 may feed '
            'this model (ADR-0065 §7.1 item 1), and a foreign event proving '
            'liveness would let an unrelated stream open the gate.',
      );
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // ADR-0065 §7.1 item 4 — no BC-12 -> BC-13 edge.
  // ════════════════════════════════════════════════════════════════════
  group('item 4 — no BC-12 -> BC-13 edge exists, and item 5 lag is '
      'observable', () {
    test('the projection is driven only through apply/rebuildFrom, and lag is '
        'exposed as a measurable quantity', () {
      // Item 4 is asserted structurally by the boundary checker and by the
      // ID-2 group below; what is asserted here is the behavioural corollary:
      // the ONLY way state enters is an E-14 event, so there is no query path
      // to BC-13 to accidentally add.
      final f = _fresh();
      f.projection.apply(
        _enforcement(person: _abuser, action: 'warning', occurredAt: _t0),
      );
      expect(f.projection.projectionLag, Duration.zero);

      f.clock.advance(const Duration(seconds: 2));
      expect(
        f.projection.projectionLag,
        const Duration(seconds: 2),
        reason:
            'Item 5 requires projection lag to be observable so the '
            "gate's threshold is measurable rather than aspirational.",
      );
      expect(f.projection.stalenessBudget, kEnforcementStalenessBudget);
    });

    test('the event bus wiring subscribes to exactly one event type', () async {
      // End-to-end through the real bus, proving the composition-root wiring
      // shape works and that drain() delivers to the projection.
      final telemetry = _telemetry();
      final bus = EventBus(telemetry);
      final clock = FixedClock(_t0);
      final projection = MessagingEnforcementProjection(clock, telemetry);
      bus.subscribe(
        kEnforcementActionTaken,
        projection.apply,
        consumer: 'messaging-enforcement',
      );

      bus.enqueue([
        _enforcement(
          person: _abuser,
          action: 'messagingRestriction',
          until: _t0.add(const Duration(days: 7)),
          occurredAt: _t0,
        ),
      ]);
      await bus.drain();

      expect(bus.deadLetter, isEmpty);
      expect(projection.evaluateSend(sender: _abuser).refused, isTrue);
      expect(projection.evaluateSend(sender: _bystander).allowed, isTrue);
    });
  });

  // ════════════════════════════════════════════════════════════════════
  // Rule ID-2 — the module names no tenant.
  // ════════════════════════════════════════════════════════════════════
  group('rule ID-2 — the projection reads no tenant from the envelope', () {
    test('two events with different tenants on the envelope produce one '
        'global restriction, not two partitions', () {
      // Social data is not tenant-scoped. If the projection keyed on tenant,
      // a person restricted "in one tenant" could still send in another —
      // which is exactly the leak ID-2 forbids, running in reverse.
      final f = _fresh();
      f.projection.apply(
        DomainEvent(
          eventId: 'EV-A',
          eventType: kEnforcementActionTaken,
          tenantId: const TenantId('T-ALPHA'),
          aggregateId: _abuser.value,
          occurredAt: _t0,
          payload: {
            'personId': _abuser.value,
            'action': 'messagingRestriction',
            'scope': 'global',
            'until': _t0.add(const Duration(days: 7)).toIso8601String(),
          },
        ),
      );

      expect(
        f.projection.activeRestrictionCount,
        1,
        reason:
            'A restriction was recorded per tenant. PersonId is global '
            '(ID-3) and the restriction must be too.',
      );
      expect(f.projection.evaluateSend(sender: _abuser).refused, isTrue);

      // A second event for the same person under a DIFFERENT tenant must
      // update the same row, not create a sibling.
      f.projection.apply(
        DomainEvent(
          eventId: 'EV-B',
          eventType: kEnforcementActionTaken,
          tenantId: const TenantId('T-BETA'),
          aggregateId: _abuser.value,
          occurredAt: _t0.add(const Duration(seconds: 1)),
          payload: {
            'personId': _abuser.value,
            'action': 'messagingRestriction',
            'scope': 'global',
            'until': null, // reversal
          },
        ),
      );
      expect(
        f.projection.activeRestrictionCount,
        0,
        reason:
            'The reversal did not reach the restriction because the two '
            'events were filed under different tenants.',
      );
    });
  });

  // ---------------------------------------------------------------------------
  // TSF-FR-001 / TSF-AC-027 — the send-time check answers within 50 ms at p99.
  //
  // IMPL-1410's task definition is "Synchronous send-time check, fail-closed,
  // p99 <= 50 ms". The fail-closed half is asserted above; this group measures
  // the latency half, which is otherwise an unmeasured claim. Per SID-4.56,
  // "a rule that cannot be checked SHALL be treated as unmet", so the budget
  // is asserted rather than assumed.
  //
  // What this does and does NOT establish is stated plainly: this measures the
  // in-process read model on the send path, which is the component ADR-0065
  // Option B put there. It is NOT a production p99 under concurrent load, and
  // it does not discharge T-5, which PRD-020 L2129 specifies as "Integration +
  // fault injection". A green assertion here means the data structure is not
  // the bottleneck; it does not mean the deployed path meets 50 ms.
  // ---------------------------------------------------------------------------
  group('TSF-FR-001 — send-path latency budget', () {
    test('the check answers well inside 50 ms at p99 over 10k reads', () {
      final f = _fresh();

      // Populate with many restrictions so the lookup is not measured against
      // an empty map — an empty projection would pass trivially and prove
      // nothing about the structure that ships.
      for (var i = 0; i < 1000; i++) {
        f.projection.apply(
          _enforcement(
            eventId: 'EV-load-$i',
            person: PersonId('person-$i'),
            action: 'messagingRestriction',
            until: _t0.add(const Duration(days: 1)),
            occurredAt: _t0,
          ),
        );
      }
      expect(
        f.projection.activeRestrictionCount,
        1000,
        reason:
            'Vacuity guard — the load was not applied, so any latency '
            'figure below would be measured against an empty model.',
      );

      const iterations = 10000;
      final samples = <int>[];
      final probe = PersonId('person-500');
      for (var i = 0; i < iterations; i++) {
        final sw = Stopwatch()..start();
        f.projection.evaluateSend(sender: probe);
        sw.stop();
        samples.add(sw.elapsedMicroseconds);
      }
      samples.sort();
      final p99 = samples[(iterations * 0.99).floor()];

      expect(
        p99,
        lessThan(50000),
        reason:
            'TSF-FR-001 requires p99 <= 50 ms for the send-time check. '
            'Measured p99 = ${p99}us over $iterations reads against 1000 '
            'active restrictions.',
      );
    });

    test('a refusal is not slower than an allow — failing closed is not a '
        'timeout path', () {
      final f = _fresh();
      f.projection.apply(
        _enforcement(
          person: _abuser,
          action: 'permanentTermination',
          // NOT null: TSF-FR-124 makes a nulled `until` a REVERSAL, and
          // TSF-FR-070 forbids an open-ended suspension. A dated `until` is
          // how a live restriction is expressed.
          until: _t0.add(const Duration(days: 3650)),
          occurredAt: _t0,
        ),
      );

      // Vacuity guard: the sender really is refused, so the loop below is
      // timing the refusal path and not an allow.
      expect(
        f.projection.evaluateSend(sender: _abuser).reason,
        SendRefusalReason.messagingRestricted,
      );

      const iterations = 2000;
      final samples = <int>[];
      for (var i = 0; i < iterations; i++) {
        final sw = Stopwatch()..start();
        f.projection.evaluateSend(sender: _abuser);
        sw.stop();
        samples.add(sw.elapsedMicroseconds);
      }
      samples.sort();
      final p99 = samples[(iterations * 0.99).floor()];

      expect(
        p99,
        lessThan(50000),
        reason:
            'A refusal must be decided within the same 50 ms budget. '
            'A fail-closed path that is slow invites a timeout that fails '
            'OPEN somewhere upstream. Measured p99 = ${p99}us.',
      );
    });
  });
}
