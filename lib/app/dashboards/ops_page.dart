/// Operations & architecture instrumentation (Owner only).
///
/// This page exists because the guarantees in the architecture documents are
/// worthless if nobody can see them working. Everything here is live: the real
/// outbox log, the real dead-letter queue, the real entitlement counters, the
/// real audit trail, and a live proof of tenant partitioning.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../platform/business/business.dart';
import '../session.dart';
import '../theme.dart';
import '../widgets/common.dart';

class OpsPage extends StatelessWidget {
  const OpsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final c = s.container;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        LiblSpace.lg,
        LiblSpace.md,
        LiblSpace.lg,
        LiblSpace.xxl,
      ),
      children: [
        const SectionHeader(
          title: 'Plan & entitlement',
          subtitle: 'Checked before every gated write, not after',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(LiblSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        s.tenant.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Pill(
                      s.tenant.tier.name.toUpperCase(),
                      color: LiblColors.accent,
                    ),
                  ],
                ),
                const SizedBox(height: LiblSpace.lg),
                for (final f in [
                  Feature.students,
                  Feature.seats,
                  Feature.branches,
                ])
                  _EntitlementRow(feature: f),
                const Divider(height: LiblSpace.xl),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final f in [
                      Feature.advancedReports,
                      Feature.aiInsights,
                    ])
                      Pill(
                        f.name,
                        color: c.entitlements.isEnabled(f)
                            ? LiblColors.success
                            : LiblColors.textMuted,
                        icon: c.entitlements.isEnabled(f)
                            ? Icons.check
                            : Icons.lock_outline,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SectionHeader(
          title: 'Offline queue',
          subtitle: 'Mutations captured without signal, replayed idempotently',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(LiblSpace.lg),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      c.sync.online
                          ? Icons.cloud_done_outlined
                          : Icons.cloud_off,
                      size: 18,
                      color: c.sync.online
                          ? LiblColors.success
                          : LiblColors.accent,
                    ),
                    const SizedBox(width: LiblSpace.sm),
                    Expanded(
                      child: Text(
                        c.sync.online
                            ? 'Online'
                            : 'Offline — capturing locally',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '${c.sync.pendingCount} pending',
                      style: const TextStyle(
                        fontSize: 12,
                        color: LiblColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: LiblSpace.md),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: s.toggleOffline,
                        child: Text(c.sync.online ? 'Go offline' : 'Go online'),
                      ),
                    ),
                    const SizedBox(width: LiblSpace.sm),
                    Expanded(
                      child: FilledButton(
                        onPressed: c.sync.pendingCount == 0
                            ? null
                            : s.flushSync,
                        child: const Text('Flush queue'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SectionHeader(
          title: 'Event log',
          subtitle:
              '${c.events.log.length} published · every projection '
              'rebuildable from this',
          trailing: TextButton(
            onPressed: () async {
              await c.analytics.rebuildFrom(c.events);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Projections rebuilt from the event log'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('Replay'),
          ),
        ),
        PanelCard(
          children: [
            for (final e in c.events.recent(14))
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: LiblSpace.lg,
                  vertical: 7,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: LiblColors.brand,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: LiblSpace.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.eventType,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text(
                            'agg ${e.aggregateId} · v${e.schemaVersion}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: LiblColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _hhmm(e.occurredAt),
                      style: const TextStyle(
                        fontSize: 11,
                        color: LiblColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SectionHeader(
          title: 'Dead letter queue',
          subtitle: c.events.deadLetter.isEmpty
              ? 'Empty — no consumer has failed'
              : '${c.events.deadLetter.length} events need attention',
        ),
        if (c.events.deadLetter.isEmpty)
          const Card(
            child: EmptyState(
              icon: Icons.verified_user_outlined,
              title: 'DLQ empty',
              message:
                  'Failed consumers land here instead of silently vanishing.',
            ),
          )
        else
          PanelCard(
            children: [
              for (final d in c.events.deadLetter)
                ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.error_outline,
                    color: LiblColors.danger,
                    size: 20,
                  ),
                  title: Text(
                    d.event.eventType,
                    style: const TextStyle(fontSize: 12.5),
                  ),
                  subtitle: Text(
                    '${d.consumer}: ${d.error}',
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
            ],
          ),
        SectionHeader(
          title: 'Audit trail',
          subtitle: '${c.audit.count} entries · append-only by construction',
        ),
        if (c.audit.count == 0)
          const Card(
            child: EmptyState(
              icon: Icons.history,
              title: 'No audit entries yet',
            ),
          )
        else
          PanelCard(
            children: [
              for (final a in c.audit.recent(8))
                ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.lock_clock,
                    size: 18,
                    color: LiblColors.textMuted,
                  ),
                  title: Text(
                    '${a.action} → ${a.target}',
                    style: const TextStyle(fontSize: 12.5),
                  ),
                  subtitle: Text(
                    '${a.actor} · ${_hhmm(a.at)}',
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
            ],
          ),
        const SectionHeader(
          title: 'Tenant isolation',
          subtitle: 'Live proof, not a promise',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(LiblSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This scope sees ${c.students.all().length} students.',
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: LiblSpace.xs),
                Text(
                  'Two tenants are seeded in the same process. Every store is '
                  'partitioned by tenant internally, and a store asked for data '
                  'with no tenant in scope throws instead of guessing. '
                  '${s.tenant.name} can never observe the other tenant\'s rows.',
                  style: const TextStyle(
                    fontSize: 12,
                    color: LiblColors.textMuted,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: LiblSpace.md),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final t in c.tenants)
                      Pill(
                        t.name,
                        color: t.id == s.tenant.id
                            ? LiblColors.brand
                            : LiblColors.textMuted,
                        icon: t.id == s.tenant.id
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static String _hhmm(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

class _EntitlementRow extends StatelessWidget {
  const _EntitlementRow({required this.feature});
  final Feature feature;

  @override
  Widget build(BuildContext context) {
    final c = context.watch<SessionController>().container;
    final limit = c.entitlements.limitFor(feature);
    final used = c.entitlements.usageOf(feature);
    final unlimited = limit < 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: LiblSpace.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  feature.name,
                  style: const TextStyle(fontSize: 12.5),
                ),
              ),
              Text(
                unlimited ? '$used / ∞' : '$used / $limit',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          MeterBar(
            height: 5,
            fraction: unlimited ? 0.08 : (limit == 0 ? 0 : used / limit),
            color: unlimited
                ? LiblColors.info
                : (used / (limit == 0 ? 1 : limit) > 0.85
                      ? LiblColors.warning
                      : LiblColors.brand),
          ),
        ],
      ),
    );
  }
}
