/// **Analytics semantic layer — `BC-26` Analytics Read Model, rank 7.**
///
/// This file is the **only** place in the codebase where a metric definition
/// may be constructed. That is not a style preference; it is the mechanical
/// form of two binding rules:
///
/// - Rank 1 `MP-GBR-36` — *"**No dashboard may define its own metric
///   formula.** All metrics come from the Metric (Semantic) Layer as Certified
///   Metrics."*
/// - Manifest assertion `AN-2` (`tool/module_dependencies.yaml` L325) —
///   *"no metric defined outside the semantic layer"*.
///
/// ## What this file implements
///
/// | Task | Obligation | Source |
/// |---|---|---|
/// | `IMPL-2000` | The `CertifiedMetric` value type carrying all nine fields | `ANL-FR-008` |
/// | `IMPL-2001` | A registry that **rejects at registration**, never publishes blanks | `ANL-FR-009` |
/// | `IMPL-2002` | The semantic-layer boundary — the sole definition site | `ANL-FR-001`, `AN-2`, `MP-GBR-36` |
///
/// ## What this file deliberately does NOT do
///
/// - It does **not** compute a metric **value**. It holds *definitions* only.
///   Values come from projections (`analytics.dart`), and `BC-26` *"owns no
///   domain fact"* (`PRD-009` §9).
/// - It does **not** define any metric other than `ProfileViews`, which is the
///   **only** `CertifiedMetric` defined anywhere in this repository, certified
///   by `Accepted` `ADR-0097` (Rank 2). Every other candidate named in
///   `PRD-009` is missing at least one of the nine fields, and `ANL-FR-009`
///   requires such a metric to be **rejected at registration, not published
///   with blanks**.
/// - It does **not** certify `UniqueViewers`. `ADR-0097` §5 rules it **NOT
///   certified**; rules `U1`–`U8` require it to be *omitted* — never zero,
///   never a placeholder, never blurred, never estimated from `ProfileViews`.
///   Its **absence from this registry** is the mechanical form of that ruling.
/// - It does **not** subscribe to any event, define a threshold, or read a
///   domain table. `banned_imports` forbids `domain/**` (`X-01`), and
///   `excluded_events: ["iam.*"]` with assertion `AN-3` forbids any
///   `iam.*`-derived metric.
///
/// ## Field-list divergence — disclosed, and resolved by rule
///
/// `PRD-009_STAGE6_IMPLEMENTATION_TASKS.md` `IMPL-2000` lists the nine fields
/// as `metricId`, `name`, `formula`, `unit`, `timeSemantics`, `accessScope`,
/// `sourceEvents`, `freshnessExpectation`, `version`.
///
/// The **FROZEN Rank-3 PRD** lists them differently. `ANL-FR-008` reads:
///
/// > Every Certified Metric **MUST** carry all nine fields: `metricId` ·
/// > `name` · `definition` · `sourceEvents[]` · `calculation` ·
/// > `owningContext` · `timeSemantics` · `freshnessExpectation` ·
/// > `accessScope`.
///
/// The lists agree on six names and differ on three: the gate record says
/// `formula`, `unit`, `version` where the PRD says `definition`, `calculation`,
/// `owningContext`.
///
/// `DOCUMENTATION_BASELINE.md` settles it — *"Where a gate record and the PRD
/// disagree, **the PRD governs**"* — and the `PRD-009` baseline row marks the
/// Stage-6 document *"Not part of the specification"*.
///
/// So the nine `ANL-FR-008` names are used. `version` is **also** carried, not
/// as a tenth member of the mandatory nine but because `ANL-FR-010`
/// independently requires definitions to be versioned and `ANL-FR-011`
/// requires every output to state the version used. `unit` is carried for the
/// same reason `ADR-0097` §3.1 publishes one. Neither is invented here.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

/// The access scope a metric may be read under.
///
/// **This register is CLOSED and must not be extended.** Rank 1 `MP-GBR-21`:
/// *"The scope register is **closed**: `self`, `guardianOf`, `tenantWide`. No
/// fourth scope may be introduced **without an ADR**."* `ANL-INV-007` repeats
/// it for analytics specifically.
///
/// A fourth value added here would make a peer leaderboard expressible, which
/// `ANL-XC-004` requires to be **impossible** rather than merely forbidden.
enum MetricAccessScope {
  /// The subject's own data only — `ANL-FR-016`.
  self,

  /// A guardian's view of a guarded subject.
  ///
  /// Whether this scope extends to *derived analytics* is **undecided**:
  /// `ANL-OBD-004`, flagged **HIGH RISK**, states a decision is required
  /// *"before any guardian-facing analytic ships"*. The scope exists in the
  /// register; no metric here uses it.
  guardianOf,

  /// Tenant-wide — still tenant-scoped. `ANL-INV-006` makes a cross-tenant
  /// read impossible, and there is deliberately **no platform scope**.
  tenantWide,
}

/// The nine fields `ANL-FR-008` requires, plus the version `ANL-FR-010`
/// requires — `IMPL-2000`.
///
/// A `CertifiedMetric` is a **definition**, not a value. `Projection` and
/// `ReadModel` (BC Map L385) carry values; this carries meaning.
///
/// An instance cannot be created with a missing or blank field: the
/// constructor validates, so an invalid definition is unconstructable rather
/// than merely unregistrable. That applies `ANL-FR-009` one level earlier
/// than it demands, which is safe — the PRD requires rejection *at
/// registration*, and this rejects *before* it.
final class CertifiedMetric {
  /// Creates a certified metric definition, validating every field.
  ///
  /// Throws [DomainError] with [DomainErrorCode.validationFailed] if any
  /// field is missing or blank — `ANL-FR-009`.
  CertifiedMetric({
    required this.metricId,
    required this.name,
    required this.definition,
    required this.sourceEvents,
    required this.calculation,
    required this.owningContext,
    required this.timeSemantics,
    required this.freshnessExpectation,
    required this.accessScope,
    required this.version,
    required this.unit,
  }) {
    final List<String> missing = _missingFields(
      metricId: metricId,
      name: name,
      definition: definition,
      sourceEvents: sourceEvents,
      calculation: calculation,
      owningContext: owningContext,
      timeSemantics: timeSemantics,
      freshnessExpectation: freshnessExpectation,
      unit: unit,
      version: version,
    );
    if (missing.isNotEmpty) {
      throw DomainError(
        DomainErrorCode.validationFailed,
        'CertifiedMetric rejected: field(s) missing or blank '
        '${missing.join(", ")}. ANL-FR-009 requires rejection at '
        'registration, not publication with blanks.',
      );
    }
  }

  /// `ANL-FR-008` field 1 — the stable identifier.
  final String metricId;

  /// `ANL-FR-008` field 2 — the display name.
  ///
  /// The name is load-bearing, not cosmetic: `ANL-FR-007` requires that no
  /// metric name *"be able to imply a broader claim than its source
  /// supports"*, and `ANL-XC-001` makes it **impossible** for a V1 metric to
  /// be labelled as measuring learning, mastery, performance, intelligence or
  /// ability.
  final String name;

  /// `ANL-FR-008` field 3 — what the number means, in prose.
  final String definition;

  /// `ANL-FR-008` field 4 — the event types this metric derives from.
  ///
  /// Must be non-empty. A metric with no source is not derivable, and
  /// `MP-GBR-37` confines analytics to learning *"only from events"*.
  final List<String> sourceEvents;

  /// `ANL-FR-008` field 5 — the counting rule.
  final String calculation;

  /// `ANL-FR-008` field 6 — the context owning the definition.
  ///
  /// For every metric in this layer that is `BC-26`, the *"sole definitional
  /// authority"* (`ADR-0097` §3.1; BC Map L135/L385).
  final String owningContext;

  /// `ANL-FR-008` field 7 — the period semantics.
  ///
  /// `ANL-FR-055` requires the boundary rule to be declared per metric. No
  /// implicit or global default period exists: `ANL-CFG-007` was **withdrawn**
  /// precisely because a global setting *"would let a tenant contradict a
  /// certified definition"*.
  final String timeSemantics;

  /// `ANL-FR-008` field 8 — how fresh the value is expected to be.
  ///
  /// Stated **behaviourally**, not numerically. `ANL-GAP-020` records that no
  /// repository SLA number exists and `ANL-CFG-003`'s value is **owed to
  /// SRE**. A number invented here would be a requirement no authority set.
  final String freshnessExpectation;

  /// `ANL-FR-008` field 9 — who may read it, under the closed register.
  final MetricAccessScope accessScope;

  /// `ANL-FR-010` — the definition version.
  ///
  /// A calculation change **MUST** mint a new version rather than mutating
  /// this one, and `ANL-FR-011` requires every output to state the version it
  /// used. `ANL-INV-004` permits exactly one active definition per `metricId`
  /// per version.
  final int version;

  /// The unit of measure, as published in the metric's own definition.
  final String unit;

  /// The key `ANL-INV-004` makes unique: one definition per `metricId` per
  /// `version`.
  String get versionedKey => '$metricId@v$version';

  static List<String> _missingFields({
    required String metricId,
    required String name,
    required String definition,
    required List<String> sourceEvents,
    required String calculation,
    required String owningContext,
    required String timeSemantics,
    required String freshnessExpectation,
    required String unit,
    required int version,
  }) {
    final List<String> missing = <String>[];
    void requireText(String field, String value) {
      if (value.trim().isEmpty) missing.add(field);
    }

    requireText('metricId', metricId);
    requireText('name', name);
    requireText('definition', definition);
    requireText('calculation', calculation);
    requireText('owningContext', owningContext);
    requireText('timeSemantics', timeSemantics);
    requireText('freshnessExpectation', freshnessExpectation);
    requireText('unit', unit);
    if (sourceEvents.isEmpty ||
        sourceEvents.any((String e) => e.trim().isEmpty)) {
      missing.add('sourceEvents');
    }
    if (version < 1) missing.add('version');
    return missing;
  }

  @override
  String toString() => 'CertifiedMetric($versionedKey)';
}

/// The certified-metric registry — `IMPL-2001`.
///
/// `ANL-FR-009`: *"A metric missing any of the nine **MUST** be rejected at
/// registration, not published with blanks."* Rejection happens twice over —
/// [CertifiedMetric]'s constructor refuses to build an incomplete definition,
/// and [register] refuses a duplicate `metricId@version` per `ANL-INV-004`.
///
/// The registry is **definition lookup only**. It exposes no value, no count
/// and no aggregate, so it cannot become a second source of truth
/// (`MP-GBR-38`, `ANL-INV-001`).
final class CertifiedMetricRegistry {
  /// Creates an empty registry.
  ///
  /// Use [CertifiedMetricRegistry.withCertifiedMetrics] for the registry
  /// holding every metric certified by an `Accepted` ADR.
  CertifiedMetricRegistry();

  /// The registry as the repository's governance actually stands: exactly one
  /// certified metric.
  ///
  /// `ProfileViews` is *"the **FIRST** `CertifiedMetric` named anywhere in the
  /// repository"* (`ADR-0097`). It is still the **only** one. A second entry
  /// here requires a new `Accepted` ADR supplying all nine fields — that is
  /// not a code decision.
  factory CertifiedMetricRegistry.withCertifiedMetrics() {
    final CertifiedMetricRegistry registry = CertifiedMetricRegistry();
    registry.register(profileViews);
    return registry;
  }

  final Map<String, CertifiedMetric> _byVersionedKey =
      <String, CertifiedMetric>{};

  /// Registers a definition.
  ///
  /// Throws [DomainError] with [DomainErrorCode.conflict] if a definition is
  /// already registered for the same `metricId` at the same `version`
  /// (`ANL-INV-004`). An incomplete definition cannot reach this method: it
  /// fails in the constructor (`ANL-FR-009`).
  void register(CertifiedMetric metric) {
    if (_byVersionedKey.containsKey(metric.versionedKey)) {
      throw DomainError(
        DomainErrorCode.conflict,
        'CertifiedMetric ${metric.versionedKey} is already registered. '
        'ANL-INV-004 permits exactly one active definition per metricId per '
        'version; ANL-FR-010 requires a calculation change to mint a new '
        'version rather than mutate this one.',
      );
    }
    _byVersionedKey[metric.versionedKey] = metric;
  }

  /// Looks up a definition by `metricId` and `version`.
  ///
  /// Returns `null` when no such definition exists. A caller receiving `null`
  /// **MUST NOT** render a value: `ANL-FR-001` requires every analytic output
  /// to resolve to a Certified Metric, so an unresolved metric is an absence
  /// to be surfaced, never a zero to be displayed (`ANL-FR-018`,
  /// `ANL-INV-008`).
  CertifiedMetric? lookup(String metricId, {required int version}) =>
      _byVersionedKey['$metricId@v$version'];

  /// Whether a definition is registered for `metricId` at any version.
  bool isCertified(String metricId) =>
      _byVersionedKey.values.any((CertifiedMetric m) => m.metricId == metricId);

  /// Every registered definition — for catalogue display, and for the
  /// architecture test that makes `AN-2` executable.
  List<CertifiedMetric> get all =>
      List<CertifiedMetric>.unmodifiable(_byVersionedKey.values);

  /// The number of registered definitions.
  int get length => _byVersionedKey.length;

  // ══════════════════════════════════════════════════════════════════
  // The certified metrics. ONE entry, transcribed — not authored — from
  // `Accepted` `ADR-0097` §3.
  // ══════════════════════════════════════════════════════════════════

  /// `ProfileViews` — the only `CertifiedMetric` in this repository.
  ///
  /// Every field below is transcribed from `ADR-0097` §3, `Accepted` at
  /// Rank 2. **Nothing here is invented, paraphrased into a new rule, or
  /// extended.**
  ///
  /// Properties worth reading before rendering it:
  ///
  /// - It is an **impression count**, not a visitor count. §3.3 performs **no
  ///   viewer-level deduplication** — *"The same visitor rendering the same
  ///   profile ten times contributes **ten**"* — because `ADR-0096` §4.2
  ///   excludes all viewer identity from the payload. §3.4 `B5` further
  ///   **counts the owner's own visits**.
  /// - §4.3 therefore fixes the label: it **MUST** be presented as *views*,
  ///   and **MUST NOT** be called visitors, people, unique visitors, users,
  ///   viewers, reach or audience.
  /// - §3.5 `T5` certifies **one** comparison window and no other. Daily,
  ///   monthly, quarterly, all-time, year-over-year and custom ranges are
  ///   **not certified**.
  /// - §3.1 makes it **owner/admin only, never public**, and `P6` requires
  ///   tenant context on every read.
  static final CertifiedMetric profileViews = CertifiedMetric(
    metricId: 'ProfileViews',
    name: 'Profile views',
    // ADR-0097 §3.1.
    definition:
        'The count of tenancy.LibraryProfileViewed facts attributed to a '
        'single library, over a single BC-26-defined period, after the '
        'exclusions in ADR-0097 section 3.3 and 3.4 are applied. It is the '
        'number of times a library public profile was rendered, not the '
        'number of people who rendered it.',
    // ADR-0097 §3.1 sole input, arriving over edge E-30 (ADR-0096).
    sourceEvents: const <String>['tenancy.LibraryProfileViewed'],
    // ADR-0097 §3.2 counting rule, §3.3 duplicate handling, §3.4 bot rules.
    calculation:
        'One qualifying tenancy.LibraryProfileViewed fact increments the '
        'count by exactly one. Counts events, not viewers, sessions or '
        'devices. Attribution is to the library named as the subject of the '
        'fact and MUST NOT be aggregated across libraries. No viewer-level '
        'deduplication is performed: the same visitor rendering the same '
        'profile ten times contributes ten. Transport duplicates redelivered '
        'under the at-least-once contract MUST NOT be counted, which is '
        'event-identity idempotency and not viewer deduplication. A request '
        'that does not result in a successfully rendered public profile MUST '
        'NOT produce a countable fact. Non-human traffic MUST be excluded to '
        'the extent BC-26 can identify it without viewer identity; the '
        'classification method is deliberately unspecified (B4) and MUST NOT '
        'identify, fingerprint or profile viewers (B3). The library owner own '
        'visits are counted (B5).',
    // BC Map L135/L385; ADR-0097 §3.1 sole definitional authority.
    owningContext: 'BC-26 Analytics Read Model',
    // ADR-0097 §3.5 T1, T3, T4, T5.
    timeSemantics:
        'A rolling 7-day window, compared against the immediately preceding, '
        'non-overlapping 7-day window. This is the only certified comparison '
        '(T1). The period MUST be labelled explicitly wherever the trend is '
        'rendered, and a trend without a stated period MUST NOT be rendered '
        '(T3). Where the prior window has insufficient data the trend MUST be '
        'omitted, never rendered as zero per cent, a dash, no change, new or '
        'coming soon (T4); the count may still render. No other period is '
        'certified: daily, monthly, quarterly, all-time, year-over-year and '
        'custom ranges are NOT certified by ADR-0097 (T5).',
    // ADR-0097 §4.2 — behaviour, not a number. ANL-CFG-003's value is owed.
    freshnessExpectation:
        'Where BC-26 is unavailable or the value cannot be resolved, the '
        'readout MUST mark itself temporarily unavailable and MUST NOT render '
        'zero, a stale value of unknown age, or an inferred value, and MUST '
        'NOT fail the host surface. No numeric freshness threshold is '
        'certified: ANL-CFG-003 is owed to SRE (ANL-GAP-020).',
    // ADR-0097 §3.1 audience; §3.6 P5/P6.
    accessScope: MetricAccessScope.tenantWide,
    version: 1,
    // ADR-0097 §3.1 unit row.
    unit: 'A dimensionless non-negative integer count of events',
  );

  // UniqueViewers IS DELIBERATELY ABSENT.
  //
  // ADR-0097 section 5.1 rules: "UniqueViewers is NOT a CertifiedMetric. It
  // has no authoritative definition. It MUST NOT be rendered."
  //
  // Its absence here is the mechanical form of rules U1-U8:
  //   U1 the field MUST be omitted
  //   U2 MUST NOT be rendered as zero
  //   U3 MUST NOT be rendered as unknown, a dash, n/a or any placeholder
  //   U4 MUST NOT be rendered as "coming soon" or any forward promise
  //   U5 MUST NOT be rendered disabled, greyed, blurred, locked, teaser or
  //      upsell
  //   U6 MUST NOT be approximated, estimated, modelled or inferred from
  //      ProfileViews or any other signal
  //   U7 callers MUST NOT compute uniqueness, deduplicate by identifier,
  //      fingerprint a device or infer distinctness
  //   U8 it remains CONDITIONAL, not forbidden forever: should BC-26 one day
  //      publish it under a definition that does not require viewer identity,
  //      it becomes admissible. This file does NOT authorise or predict that
  //      definition.
  //
  // It is not computable from the certified input: ADR-0096 section 4.2
  // excludes all viewer identity, device identifiers and fingerprints from
  // tenancy.LibraryProfileViewed. Adding a stub, placeholder or "unsupported"
  // entry would render the metric's existence as a fact, which section 5.3
  // treats as the same defect as rendering its value.
}
