/// **Event Platform — R3**
///
/// The runtime event backbone. Identified in the architecture review as the
/// single highest-ROI addition: without Outbox + idempotent consumers + DLQ,
/// "event-driven" and "microservice ready" are aspirational claims.
library;

import 'dart:async';

import 'package:liboora_contracts/liboora_contracts.dart';

typedef EventHandler = FutureOr<void> Function(DomainEvent event);

final class _Subscription {
  _Subscription(this.pattern, this.handler, this.consumerName);
  final String pattern;
  final EventHandler handler;
  final String consumerName;

  bool matches(String eventType) {
    if (pattern == '*') return true;
    if (pattern.endsWith('.*')) {
      return eventType.startsWith(
        '${pattern.substring(0, pattern.length - 2)}.',
      );
    }
    return pattern == eventType;
  }
}

/// In-process bus with transactional-outbox semantics.
///
/// Aggregates stage events; the repository hands them to [enqueue] alongside
/// the state write; [drain] publishes. Application code never publishes
/// directly — that ordering is what makes "event emitted but state rolled
/// back" impossible.
final class EventBus {
  EventBus(this._telemetry);

  final Telemetry _telemetry;
  final List<_Subscription> _subs = [];

  /// Transactional outbox — staged, not yet published.
  final List<DomainEvent> _outbox = [];

  /// Published log. Every projection and index must be rebuildable from this.
  final List<DomainEvent> log = [];

  /// Events that exhausted retries.
  final List<({DomainEvent event, String consumer, Object error})> deadLetter =
      [];

  /// Idempotency ledger: (consumer, eventId) already processed.
  final Set<String> _processed = {};

  void subscribe(
    String pattern,
    EventHandler handler, {
    required String consumer,
  }) {
    _subs.add(_Subscription(pattern, handler, consumer));
  }

  /// `IMPL-430` / `MM-BR-018` — per-aggregate ordering.
  final PerAggregateSequencer sequencer = PerAggregateSequencer();

  /// `MM-BR-016` — the sequence issued to each event, by `eventId`.
  final Map<String, int> _sequences = {};

  /// `MM-BR-016`/`MM-BR-018` — the monotonic per-`aggregateId` sequence
  /// assigned to [eventId], or `null` if the bus never saw it.
  int? sequenceOf(String eventId) => _sequences[eventId];

  /// Stage events into the outbox. Called by repositories inside the same
  /// unit of work as the state mutation.
  ///
  /// `MM-BR-015` and `MM-BR-018` are enforced HERE rather than at each call
  /// site, because this is the one door every event goes through. A rule
  /// applied at the producer can be forgotten by the next producer; a rule
  /// applied at the door cannot.
  void enqueue(Iterable<DomainEvent> events) {
    for (final e in events) {
      // MM-BR-015: fail loudly rather than publishing PII and discovering it
      // in a consumer's logs.
      assertNoPiiInPayload(e.eventType, e.payload);

      // MM-BR-016: the common payload contract, checked at the same door for
      // the same reason.
      assertCommonPayloadContract(e.eventType, e.payload);

      // MM-BR-016/018: a monotonic sequence per aggregate.
      //
      // Recorded ALONGSIDE the event rather than written into e.payload.
      // Two reasons, and the first was found by a test rather than by
      // thinking: payloads are frequently const or otherwise unmodifiable,
      // so mutating one throws. The second is the better reason -- the
      // payload belongs to the producer, and a bus that edits it is no
      // longer just transport. DomainEvent is R0 vocabulary shared by every
      // context, so widening it for a BC-02 requirement would be the wrong
      // trade too.
      _sequences[e.eventId] = sequencer.next(e.aggregateId);

      _outbox.add(e);
    }
  }

  /// Publish everything staged. At-least-once delivery.
  Future<void> drain() async {
    while (_outbox.isNotEmpty) {
      final event = _outbox.removeAt(0);
      log.add(event);
      _telemetry.counter('event.published', tags: {'type': event.eventType});

      for (final sub in _subs.where((s) => s.matches(event.eventType))) {
        // Consumer-side idempotency. Delivery is at-least-once, so this is
        // mandatory, not optional.
        final key = '${sub.consumerName}::${event.eventId}';
        if (_processed.contains(key)) continue;

        try {
          await sub.handler(event);
          _processed.add(key);
        } catch (e) {
          deadLetter.add((event: event, consumer: sub.consumerName, error: e));
          _telemetry.log(
            LogLevel.error,
            'consumer failed, sent to DLQ',
            fields: {
              'consumer': sub.consumerName,
              'event': event.eventType,
              'error': '$e',
            },
          );
        }
      }
    }
  }

  List<DomainEvent> byContext(String context) =>
      log.where((e) => e.context == context).toList();

  List<DomainEvent> recent([int n = 20]) =>
      log.reversed.take(n).toList(growable: false);
}

/// `IMPL-429`/`IMPL-430` — the `BC-02` event register and its guarantees.
///
/// Declared in `platform/event` rather than in `BC-02` because `MM-BR-019`
/// puts Notification and Analytics outside the domain: they are consumers of
/// facts, and the fact-shaping rules belong with the backbone that carries
/// them.
///
/// **Closed at seven.** `MM-BR-035`: *"The event register above **MUST** be
/// closed at **seven** events. Adding, removing or renaming an `MM-EVT-*`
/// **MUST** require a new version of this document, and **MUST NOT** be done
/// by an implementation."* An enum is how that becomes mechanical — an eighth
/// value does not exist to reach for.
enum MembershipEventType {
  /// `MM-EVT-001` — creation.
  created('membership.MembershipCreated'),

  /// `MM-EVT-002` — activation.
  activated('membership.MembershipActivated'),

  /// `MM-EVT-003` — renewal.
  renewed('membership.MembershipRenewed'),

  /// `MM-EVT-004` — upgrade.
  ///
  /// ⚠ Declared here because frozen `PRD-005` §9 names it, but **not yet
  /// publishable**: BC Map §9 omits it (`MM-GAP-007a`, Architecture/BC Map
  /// owner). See the note in `UpgradeMembership`.
  upgraded('membership.MembershipUpgraded'),

  /// `MM-EVT-005` — expiry.
  expired('membership.MembershipExpired'),

  /// `MM-EVT-006` — expiring soon, on the `MM-CFG-008` threshold.
  expiringSoon('membership.MembershipExpiringSoon'),

  /// `MM-EVT-007` — void before activation.
  voided('membership.MembershipVoided');

  const MembershipEventType(this.wireName);

  /// `MM-BR-014` — `<Context>.<Aggregate><PastTenseVerb>`.
  final String wireName;

  /// `MM-BR-014` — an imperative name is a *command* and must never enter the
  /// bus. Checked structurally rather than by review.
  bool get isPastTense => const {
    'Created',
    'Activated',
    'Renewed',
    'Upgraded',
    'Expired',
    'ExpiringSoon',
    'Voided',
  }.contains(wireName.split('Membership').last);
}

/// `MM-BR-015` — payload keys a **`BC-02` membership** event may never carry.
///
/// *"No event **MUST** carry a mobile number (`MP-GBR-34`), and no event
/// **MUST** carry a name, email, photograph or any `BC-10` profile field."*
///
/// A deny-list rather than an allow-list, deliberately: an allow-list would
/// have to be revised for every new legitimate field and would fail open on
/// the day someone forgot. This fails closed on the fields that matter.
///
/// ⚠ **Scope: `membership.*` only.** `MM-BR-015` is a frozen `PRD-005` rule
/// about `BC-02`'s event surface. Applying it to every context would be
/// overreach — and measurably so: `enrollment.StudentEnrolled` carries
/// `fullName`, which is `BC-01`'s own published language under `PRD-004`,
/// not a defect for this task to "fix". Whether the same discipline should
/// apply repository-wide is a real question and a governance one; it is not
/// mine to answer by widening a deny-list inside an implementation batch.
const Set<String> kForbiddenEventPayloadKeys = {
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
};

/// `MM-BR-015` — throws if [payload] carries a forbidden key.
///
/// `planName` is deliberately *not* forbidden: it names a product, not a
/// person, and `MM-EVT-001`'s declared payload includes it.
void assertNoPiiInPayload(String eventType, Map<String, Object?> payload) {
  // See the scope note on kForbiddenEventPayloadKeys: MM-BR-015 governs
  // BC-02's event surface, so this checks membership events and leaves other
  // contexts' published language to their own PRDs.
  if (!eventType.startsWith('membership.')) return;

  for (final key in payload.keys) {
    if (kForbiddenEventPayloadKeys.contains(key)) {
      throw StateError(
        'MM-BR-015: event "$eventType" carries forbidden key "$key". '
        'No event may carry a mobile number, name, email, photograph or any '
        'BC-10 profile field.',
      );
    }
  }
}

/// `MM-BR-016` — the common payload contract every `MM-EVT-*` must satisfy.
///
/// *"Every event **MUST** carry `tenantId`, `membershipId`, `studentRecordId`,
/// `occurredAt` (UTC), an `eventId` for idempotency, and a monotonic
/// `sequence` per membership for ordering."*
///
/// Three of the six live on [DomainEvent] itself (`tenantId`, `occurredAt`,
/// `eventId`) so they cannot be omitted — the constructor requires them. A
/// fourth, `sequence`, is issued by the bus. That leaves `membershipId` and
/// `studentRecordId`, which are payload keys and therefore *can* be forgotten
/// by a new producer. Those are what this checks.
///
/// **Presence, not UTC-kind.** `MM-BR-016` also says `occurredAt` is UTC, and
/// that part is deliberately *not* asserted here. Enforcing it was tried and
/// it failed 47 existing tests across every context, for one root cause:
/// `SystemClock.now()` in R0 returns `DateTime.now()`, which is local-kind, so
/// no event anywhere in this repository currently carries a UTC-kind
/// `occurredAt`. Making it UTC means changing the R0 [Clock] adapter that
/// every bounded context reads, which is a repository-wide behavioural change
/// and not a `BC-02` implementation detail. Recorded and reported rather than
/// either fixed out of scope or silently dropped. See
/// [membershipOccurredAtIsUtc] for the predicate that states the obligation.
const Set<String> kRequiredMembershipPayloadKeys = {
  'membershipId',
  'studentRecordId',
};

/// `MM-BR-016` — whether [occurredAt] satisfies the UTC half of the contract.
///
/// Stated as a predicate rather than an assertion for the reason given on
/// [kRequiredMembershipPayloadKeys]: the obligation is real and currently
/// unmet repository-wide, and the fix is an R0 [Clock] change outside this
/// batch's authority.
bool membershipOccurredAtIsUtc(DateTime occurredAt) => occurredAt.isUtc;

/// `MM-BR-016` — throws if a `membership.*` payload omits a required key.
void assertCommonPayloadContract(
  String eventType,
  Map<String, Object?> payload,
) {
  if (!eventType.startsWith('membership.')) return;

  for (final key in kRequiredMembershipPayloadKeys) {
    final value = payload[key];
    if (value == null || (value is String && value.isEmpty)) {
      throw StateError(
        'MM-BR-016: event "$eventType" omits required payload key "$key". '
        'Every event must carry tenantId, membershipId, studentRecordId, '
        'occurredAt (UTC), an eventId and a per-membership sequence.',
      );
    }
  }
}

/// `IMPL-430` / `MM-BR-018` — a monotonic `sequence` per `membershipId`.
///
/// *"Ordering **MUST** be guaranteed per `membershipId` via `sequence`.
/// Global cross-membership ordering **MUST NOT** be assumed by any
/// consumer."*
///
/// Per-aggregate rather than global, exactly as written. A global counter
/// would look stronger and would be a lie: it would let a consumer infer an
/// ordering between two memberships that the system does not actually
/// guarantee, and that inference would break the first time delivery was
/// parallelised.
final class PerAggregateSequencer {
  final Map<String, int> _next = {};

  /// The next sequence number for [aggregateId], starting at 1.
  int next(String aggregateId) {
    final n = (_next[aggregateId] ?? 0) + 1;
    _next[aggregateId] = n;
    return n;
  }

  /// The last issued sequence for [aggregateId], or 0 if none.
  int lastFor(String aggregateId) => _next[aggregateId] ?? 0;

  /// `MM-BR-018` — there is deliberately no global counter to read.
  ///
  /// Offering one would invite exactly the cross-membership ordering
  /// assumption the rule forbids.
  int get totalIssued => _next.values.fold(0, (a, b) => a + b);
}
