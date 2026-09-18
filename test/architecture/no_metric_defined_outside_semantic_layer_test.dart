/// **`IMPL-2028` — `AN-2` made executable.**
///
/// `tool/module_dependencies.yaml` L325 declares, for `platform/analytics`:
///
/// > `AN-2` — *"no metric defined outside the semantic layer"*
///
/// That assertion is the mechanically testable form of Rank 1 `MP-GBR-36`:
///
/// > *"**No dashboard may define its own metric formula.** All metrics come
/// > from the Metric (Semantic) Layer as Certified Metrics."*
///
/// `PRD-009` §8.4.1 calls `AN-2` *"the most consequential discovery"* of its
/// Stage-3 review, because it turns **F-1** from a prose argument into a
/// breach of a declared assertion — *"and so testable"*. Until this file
/// existed, nothing tested it. `ANL-AC-001` is the acceptance criterion.
///
/// ## What this file asserts, and why each assertion is the right shape
///
/// A naive reading of `AN-2` would grep for the word "metric" outside one
/// directory and fail on comments. That would be a spelling test. The
/// properties that actually matter are:
///
/// 1. A semantic layer **exists** — F-1's subject.
/// 2. `CertifiedMetric` is **constructible only with all nine fields**
///    (`ANL-FR-008`), and an incomplete definition is **rejected**, not
///    published with blanks (`ANL-FR-009`).
/// 3. The registry admits **exactly one** definition per `metricId` per
///    `version` (`ANL-INV-004`).
/// 4. `ProfileViews` is registered and its nine fields match `ADR-0097` §3.
/// 5. `UniqueViewers` is **absent** — `ADR-0097` §5 rules it NOT certified,
///    and rules `U1`–`U8` require omission rather than any placeholder.
/// 6. ⭐ **The one structural assertion:** the projection store
///    (`analytics.dart`) — which is *not* the semantic layer — declares **no
///    metric definition**. It holds counters whose meaning comes from
///    elsewhere, which is exactly what `AN-2` requires of a non-semantic-layer
///    file.
///
/// ## What this file deliberately does NOT assert
///
/// It does **not** assert that the 13 uncertified candidate metrics named in
/// `PRD-009` are certified, because they are not: each is missing at least one
/// of the nine fields, and `DD6-GAP-004` records that. A test demanding their
/// presence would be demanding invented definitions.
///
/// It does **not** assert that `analytics.dart`'s counters have been migrated
/// onto Certified Metrics. That is `IMPL-2005`, which is **not in this task's
/// scope**, so the migration is measured and reported rather than required.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/platform/analytics/dashboard_metrics_catalog.dart';
import 'package:liboora/platform/analytics/semantic_layer.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const String _manifestPath = 'tool/module_dependencies.yaml';
const String _semanticLayerPath = 'lib/platform/analytics/semantic_layer.dart';
const String _projectionPath = 'lib/platform/analytics/analytics.dart';

void main() {
  group('AN-2 — no metric defined outside the semantic layer', () {
    test('the manifest still declares AN-2 (the assertion under test)', () {
      final File manifest = File(_manifestPath);
      expect(
        manifest.existsSync(),
        isTrue,
        reason: 'The module manifest must exist for AN-2 to be declared.',
      );
      final String text = manifest.readAsStringSync();
      expect(
        text,
        contains('no metric defined outside the semantic layer'),
        reason:
            'AN-2 is the assertion this file makes executable. If its wording '
            'changed, this test must be revisited rather than silenced.',
      );
    });

    test('a semantic layer exists — the subject of F-1', () {
      expect(
        File(_semanticLayerPath).existsSync(),
        isTrue,
        reason:
            'MP-GBR-36 requires a Metric (Semantic) Layer. Its absence was '
            'F-1, recorded HIGH RISK as ANL-GAP-001.',
      );
    });

    test(
      'the projection store defines no metric — it is not the semantic layer',
      () {
        final String projection = File(_projectionPath).readAsStringSync();

        // The projection may hold counters; it may not hold definitions.
        // A definition is a CertifiedMetric construction, so the structural
        // test is that the projection neither imports nor constructs one.
        expect(
          projection.contains('semantic_layer.dart'),
          isFalse,
          reason:
              'analytics.dart is the projection store, not the semantic '
              'layer. If it ever needs a definition it must take the '
              'metric-catalogue read port (IMPL-2007), not build one.',
        );
        expect(
          projection.contains('CertifiedMetric('),
          isFalse,
          reason:
              'AN-2: no metric may be defined outside the semantic layer. A '
              'CertifiedMetric construction here would be that breach.',
        );
      },
    );
  });

  group('ANL-FR-008 / ANL-FR-009 — nine fields, rejected not blanked', () {
    test('a complete definition carries all nine fields plus version', () {
      final CertifiedMetric m = CertifiedMetricRegistry.profileViews;

      expect(m.metricId, isNotEmpty);
      expect(m.name, isNotEmpty);
      expect(m.definition, isNotEmpty);
      expect(m.sourceEvents, isNotEmpty);
      expect(m.calculation, isNotEmpty);
      expect(m.owningContext, isNotEmpty);
      expect(m.timeSemantics, isNotEmpty);
      expect(m.freshnessExpectation, isNotEmpty);
      expect(m.accessScope, isA<MetricAccessScope>());
      expect(m.version, greaterThanOrEqualTo(1));
    });

    test('a blank field is REJECTED, not published as a blank', () {
      // ANL-FR-009: "A metric missing any of the nine MUST be rejected at
      // registration, not published with blanks."
      expect(
        () => CertifiedMetric(
          metricId: 'Incomplete',
          name: 'Incomplete',
          definition: '', // the missing field
          sourceEvents: const <String>['some.Event'],
          calculation: 'count',
          owningContext: 'BC-26 Analytics Read Model',
          timeSemantics: 'rolling 7 days',
          freshnessExpectation: 'behavioural',
          accessScope: MetricAccessScope.tenantWide,
          version: 1,
          unit: 'count',
        ),
        throwsA(
          isA<DomainError>().having(
            (DomainError e) => e.code,
            'code',
            DomainErrorCode.validationFailed,
          ),
        ),
        reason: 'ANL-FR-009 requires rejection, never a published blank.',
      );
    });

    test('an empty sourceEvents list is REJECTED', () {
      // MP-GBR-37 confines analytics to learning "only from events", so a
      // metric with no source is not derivable.
      expect(
        () => CertifiedMetric(
          metricId: 'Sourceless',
          name: 'Sourceless',
          definition: 'has no source',
          sourceEvents: const <String>[],
          calculation: 'count',
          owningContext: 'BC-26 Analytics Read Model',
          timeSemantics: 'rolling 7 days',
          freshnessExpectation: 'behavioural',
          accessScope: MetricAccessScope.tenantWide,
          version: 1,
          unit: 'count',
        ),
        throwsA(isA<DomainError>()),
      );
    });
  });

  group('ANL-INV-004 — one active definition per metricId per version', () {
    test('a duplicate metricId at the same version is REJECTED', () {
      final CertifiedMetricRegistry registry =
          CertifiedMetricRegistry.withCertifiedMetrics();
      expect(
        () => registry.register(CertifiedMetricRegistry.profileViews),
        throwsA(
          isA<DomainError>().having(
            (DomainError e) => e.code,
            'code',
            DomainErrorCode.conflict,
          ),
        ),
        reason:
            'ANL-INV-004 permits exactly one active definition per metricId '
            'per version; ANL-FR-010 requires a new version, never a '
            'mutation.',
      );
    });

    test('lookup resolves by metricId AND version — ANL-FR-011', () {
      final CertifiedMetricRegistry registry =
          CertifiedMetricRegistry.withCertifiedMetrics();
      expect(registry.lookup('ProfileViews', version: 1), isNotNull);
      expect(
        registry.lookup('ProfileViews', version: 2),
        isNull,
        reason: 'No v2 definition has been certified by any ADR.',
      );
    });

    test('an unresolved metric returns null — never a zero', () {
      final CertifiedMetricRegistry registry =
          CertifiedMetricRegistry.withCertifiedMetrics();
      expect(
        registry.lookup('StudyConsistency', version: 1),
        isNull,
        reason:
            'ANL-FR-001 requires every output to resolve to a Certified '
            'Metric. An unresolved metric is an absence to surface, not a '
            'zero to display (ANL-FR-018, ANL-INV-008).',
      );
    });
  });

  group('ADR-0097 — ProfileViews certified, UniqueViewers NOT', () {
    test('exactly THIRTEEN metrics are certified repository-wide', () {
      final CertifiedMetricRegistry registry =
          CertifiedMetricRegistry.withCertifiedMetrics();
      expect(
        registry.length,
        13,
        reason:
            'The registry is a register of Accepted ADRs, not a code '
            'decision. Exactly two ADRs have certified metrics: ADR-0097 '
            '(ProfileViews, the first) and ADR-0147 (the 12 DashboardMetrics '
            'counters, Accepted 2026-09-18, resolving ANL-OBD-001). A '
            'fourteenth entry requires a further Accepted ADR supplying all '
            'nine ANL-FR-008 fields — ANL-FR-009 forbids publishing with '
            'blanks.',
      );
      // ADR-0097 — the one metric certified before ADR-0147.
      expect(registry.isCertified('ProfileViews'), isTrue);
      // ADR-0147 §3.2 — the twelve, named exactly as the ADR names them.
      // Pinned as a literal set so that adding a metric in code without an
      // ADR fails here, and so that renaming one is caught rather than
      // silently absorbed by a count.
      expect(
        registry.all.map((CertifiedMetric m) => m.metricId).toSet(),
        <String>{
          'ProfileViews',
          'StudentsEnrolled',
          'MembershipsCreated',
          'CheckInsToday',
          'CheckOutsToday',
          'LateEntriesToday',
          'FlaggedEntriesToday',
          'SeatsAssigned',
          'SeatsReleased',
          'CollectedTodayMinor',
          'DuesRaisedTodayMinor',
          'SeatsOccupied',
          'InsideNow',
        },
      );
    });

    test('ADR-0147 certifies exactly twelve, all owned by BC-26', () {
      final CertifiedMetricRegistry registry =
          CertifiedMetricRegistry.withCertifiedMetrics();
      expect(
        DashboardMetricsCatalog.all.length,
        12,
        reason:
            'ADR-0147 §3.2 certifies twelve counters and closes ANL-OBD-001 '
            'for those twelve ONLY. A thirteenth counter is outside the '
            'conferral.',
      );
      for (final CertifiedMetric m in DashboardMetricsCatalog.all) {
        expect(
          registry.isCertified(m.metricId),
          isTrue,
          reason:
              '${m.metricId} is certified by ADR-0147 but absent from the '
              'registry, so DashboardMetrics would read an uncertified '
              'number — the defect IMPL-2005 exists to remove.',
        );
        // ADR-0147 §3.0 — BC-26 is the sole definitional authority for all
        // twelve, per SEAT-XC-019 ("BC-04 publishes the facts, BC-26 defines
        // the metric") applied generally.
        expect(m.owningContext, contains('BC-26'));
        // §3.4 — all twelve are tenantWide. guardianOf is barred while
        // ANL-OBD-004 is OPEN; self is meaningless for a tenant aggregate.
        expect(m.accessScope, MetricAccessScope.tenantWide);
      }
    });

    test('ProfileViews fields match ADR-0097 §3', () {
      final CertifiedMetric m = CertifiedMetricRegistry.profileViews;

      // §3.1 sole input, arriving over E-30.
      expect(m.sourceEvents, <String>['tenancy.LibraryProfileViewed']);
      // §3.1 owning context — sole definitional authority.
      expect(m.owningContext, contains('BC-26'));
      // §3.5 T1 — the only certified comparison.
      expect(m.timeSemantics, contains('rolling 7-day'));
      expect(m.timeSemantics, contains('non-overlapping'));
      // §3.5 T5 — no other period is certified.
      expect(m.timeSemantics, contains('NOT certified'));
      // §3.3 — an impression count, no viewer-level deduplication.
      expect(m.calculation, contains('No viewer-level'));
      // §3.4 B5 — the owner's own visits are counted.
      expect(m.calculation, contains('owner own visits are counted'));
      // §3.1 audience — tenant-scoped, never public.
      expect(m.accessScope, MetricAccessScope.tenantWide);
    });

    test('UniqueViewers is ABSENT — U1 omission, not a placeholder', () {
      final CertifiedMetricRegistry registry =
          CertifiedMetricRegistry.withCertifiedMetrics();

      expect(
        registry.isCertified('UniqueViewers'),
        isFalse,
        reason:
            'ADR-0097 §5.1: UniqueViewers is NOT a CertifiedMetric, has no '
            'authoritative definition, and MUST NOT be rendered.',
      );
      expect(
        registry.lookup('UniqueViewers', version: 1),
        isNull,
        reason:
            'U1 requires omission. U2-U5 forbid zero, placeholder, "coming '
            'soon" and any disabled/blurred/teaser treatment — an entry here '
            'would render its existence as a fact, which §5.3 treats as the '
            'same defect as rendering its value.',
      );
      expect(
        registry.all.any(
          (CertifiedMetric m) => m.metricId.toLowerCase().contains('unique'),
        ),
        isFalse,
        reason: 'U6: it must not be approximated, modelled or inferred.',
      );
    });

    test('no iam.*-derived metric exists — AN-3, ANL-XC-012', () {
      final CertifiedMetricRegistry registry =
          CertifiedMetricRegistry.withCertifiedMetrics();
      for (final CertifiedMetric m in registry.all) {
        for (final String event in m.sourceEvents) {
          expect(
            event.startsWith('iam.'),
            isFalse,
            reason:
                'ANL-XC-012 and manifest AN-3 forbid deriving any projection, '
                'metric or dimension from an iam.* fact. ANL-AL-B1 (a live '
                'Rank-4 vs Rank-4 conflict) remains OPEN, and this is the '
                'safe side.',
          );
        }
      }
    });

    test('the closed scope register has exactly three values — MP-GBR-21', () {
      expect(
        MetricAccessScope.values.length,
        3,
        reason:
            'MP-GBR-21: "The scope register is closed: self, guardianOf, '
            'tenantWide. No fourth scope may be introduced without an ADR." A '
            'fourth value would make a peer leaderboard expressible, which '
            'ANL-XC-004 requires to be impossible.',
      );
    });
  });
}
