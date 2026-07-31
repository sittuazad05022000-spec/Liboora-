/// Owner / Manager overview.
///
/// Every tile here reads an **event-derived projection** or a repository query
/// — never a hand-maintained counter. That is why the numbers cannot drift
/// from the ledger and attendance records that justify them.
library;

import 'package:flutter/material.dart';
import 'package:liboora_contracts/liboora_contracts.dart';
import 'package:provider/provider.dart';

import '../../platform/analytics/analytics.dart';
import '../session.dart';
import '../theme.dart';
import '../widgets/common.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final m = s.container.analytics.metricsFor(s.tenant.id);
    final seats = s.container.seatMap.summary();
    final outstanding = s.totalOutstanding;
    final collected = Money.paise(m.collectedTodayMinor);
    final raised = Money.paise(m.duesRaisedTodayMinor);

    final collectionRate = raised.minorUnits == 0
        ? 1.0
        : m.collectedTodayMinor / m.duesRaisedTodayMinor;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        LiblSpace.lg,
        LiblSpace.md,
        LiblSpace.lg,
        LiblSpace.xxl,
      ),
      children: [
        _Greeting(name: s.account?.displayName ?? ''),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: LiblSpace.md,
          crossAxisSpacing: LiblSpace.md,
          childAspectRatio: 1.42,
          children: [
            MetricTile(
              label: 'Inside now',
              value: '${m.insideNow}',
              sublabel: '${m.checkInsToday} check-ins today',
              icon: Icons.sensor_occupied,
              tint: LiblColors.success,
            ),
            MetricTile(
              label: 'Active students',
              value: '${s.students.length}',
              sublabel: '${s.expiringSoon.length} expiring this week',
              icon: Icons.people_alt_outlined,
            ),
            MetricTile(
              label: 'Collected today',
              value: collected.compact,
              sublabel: 'of ${raised.compact} raised',
              icon: Icons.trending_up,
              tint: LiblColors.info,
            ),
            MetricTile(
              label: 'Outstanding',
              value: outstanding.compact,
              sublabel: '${s.withOpenDues.length} students with dues',
              icon: Icons.warning_amber_rounded,
              tint: outstanding.isPositive
                  ? LiblColors.warning
                  : LiblColors.success,
            ),
          ],
        ),
        const SectionHeader(
          title: 'Seat occupancy',
          subtitle: 'Reserved allocations against physical capacity',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(LiblSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${seats.occupied}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, left: 3),
                      child: Text(
                        ' / ${seats.total} seats',
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: LiblColors.textMuted,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Pill(
                      '${seats.free} free',
                      color: seats.free == 0
                          ? LiblColors.danger
                          : LiblColors.success,
                    ),
                  ],
                ),
                const SizedBox(height: LiblSpace.md),
                MeterBar(
                  fraction: seats.total == 0 ? 0 : seats.occupied / seats.total,
                  color: LiblColors.brand,
                ),
                const SizedBox(height: LiblSpace.lg),
                const Divider(),
                const SizedBox(height: LiblSpace.md),
                Row(
                  children: [
                    _MiniStat(
                      label: 'Late entries',
                      value: '${m.lateEntriesToday}',
                      color: LiblColors.warning,
                    ),
                    _MiniStat(
                      label: 'Flagged',
                      value: '${m.flaggedEntriesToday}',
                      color: LiblColors.danger,
                    ),
                    _MiniStat(
                      label: 'Collection',
                      value: '${(collectionRate * 100).round()}%',
                      color: LiblColors.info,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SectionHeader(
          title: 'Needs attention',
          subtitle: 'Renewals due within 7 days',
        ),
        if (s.expiringSoon.isEmpty)
          const Card(
            child: EmptyState(
              icon: Icons.verified_outlined,
              title: 'Nothing expiring this week',
              message: 'Every active membership has more than 7 days left.',
            ),
          )
        else
          PanelCard(
            children: [
              for (final st in s.expiringSoon.take(5))
                ListTile(
                  leading: Monogram(st.fullName, size: 36),
                  title: Text(
                    st.fullName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${s.validityOf(st.id).planName} · '
                    '${s.validityOf(st.id).validUntil == null ? '—' : _daysLeft(s, st.id)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Pill(
                    s.outstandingOf(st.id).isPositive ? 'Dues' : 'Paid',
                    color: s.outstandingOf(st.id).isPositive
                        ? LiblColors.warning
                        : LiblColors.success,
                  ),
                ),
            ],
          ),
        const SectionHeader(
          title: 'Live activity',
          subtitle: 'Rebuilt from the published event log',
        ),
        _ActivityFeed(items: s.container.analytics.feed(limit: 12)),
      ],
    );
  }

  static String _daysLeft(SessionController s, StudentRecordId id) {
    final until = s.validityOf(id).validUntil;
    if (until == null) return '—';
    final d = until.difference(s.container.clock.today()).inDays;
    return d <= 0 ? 'expired' : '$d days left';
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final h = DateTime.now().hour;
    final part = h < 12
        ? 'Good morning'
        : (h < 17 ? 'Good afternoon' : 'Good evening');
    final first = name.split(' ').first;
    return Padding(
      padding: const EdgeInsets.only(top: LiblSpace.sm, bottom: LiblSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$part, $first',
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          const Text(
            "Here's how the hall is running today.",
            style: TextStyle(fontSize: 12.5, color: LiblColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: LiblColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _ActivityFeed extends StatelessWidget {
  const _ActivityFeed({required this.items});
  final List<ActivityItem> items;

  static const Map<String, (IconData, Color)> _kinds = {
    'enrollment': (Icons.person_add_alt, LiblColors.brand),
    'membership': (Icons.card_membership, LiblColors.info),
    'attendance': (Icons.login, LiblColors.success),
    'seating': (Icons.chair_alt_outlined, Color(0xFF7C3AED)),
    'fee': (Icons.currency_rupee, LiblColors.warning),
  };

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Card(
        child: EmptyState(
          icon: Icons.timeline_outlined,
          title: 'No activity yet',
          message: 'Events appear here the moment something happens.',
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: LiblSpace.sm),
        child: Column(
          children: [
            for (final item in items)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: LiblSpace.lg,
                  vertical: LiblSpace.sm,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      (_kinds[item.kind] ??
                              (Icons.circle, LiblColors.textMuted))
                          .$1,
                      size: 15,
                      color:
                          (_kinds[item.kind] ??
                                  (Icons.circle, LiblColors.textMuted))
                              .$2,
                    ),
                    const SizedBox(width: LiblSpace.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.headline,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            item.detail,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: LiblColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: LiblSpace.sm),
                    Text(
                      _hhmm(item.at),
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
      ),
    );
  }

  static String _hhmm(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}
