/// Parent-facing screens.
///
/// A parent is a *different persona*, not a student with fewer buttons: they
/// care about "did my child actually go today and for how long", which is a
/// question no other role asks. V1 has no Family Access context, so the
/// parent↔child link is held in the session with that gap made explicit
/// rather than papered over with a wrong model.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../session.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ParentOverviewPage extends StatelessWidget {
  const ParentOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final id = s.subjectStudentId;
    if (id == null) {
      return const EmptyState(
        icon: Icons.family_restroom_outlined,
        title: 'No child linked',
        message:
            'Ask the library to link your number to your child\'s enrolment.',
      );
    }

    final child = s.studentById(id);
    final v = s.validityOf(id);
    final day = s.container.attendance.find(id, s.container.clock.today());
    final inside = day?.isOpen ?? false;
    final due = s.outstandingOf(id);
    final history = s.container.attendance.forStudent(id);

    final totalMinutes = history.fold<int>(
      0,
      (sum, d) => sum + d.timeInside.inMinutes,
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        LiblSpace.lg,
        LiblSpace.md,
        LiblSpace.lg,
        LiblSpace.xxl,
      ),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(LiblSpace.lg),
            child: Column(
              children: [
                Monogram(child?.fullName ?? '?', size: 62),
                const SizedBox(height: LiblSpace.md),
                Text(
                  child?.fullName ?? '—',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${s.tenant.name} · ${s.branchInfo.name}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: LiblColors.textMuted,
                  ),
                ),
                const SizedBox(height: LiblSpace.md),
                Pill(
                  inside ? 'In the library now' : 'Not in the library',
                  color: inside ? LiblColors.success : LiblColors.textMuted,
                  icon: inside
                      ? Icons.check_circle_outline
                      : Icons.circle_outlined,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: LiblSpace.md),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: LiblSpace.md,
          crossAxisSpacing: LiblSpace.md,
          childAspectRatio: 1.42,
          children: [
            MetricTile(
              label: 'Today',
              value: day == null
                  ? '—'
                  : '${day.timeInside.inHours}h ${day.timeInside.inMinutes % 60}m',
              sublabel: day?.firstEntry == null
                  ? 'Not checked in yet'
                  : 'Arrived ${_hhmm(day!.firstEntry!)}',
              icon: Icons.timer_outlined,
              tint: LiblColors.success,
            ),
            MetricTile(
              label: 'Days attended',
              value: '${history.length}',
              sublabel: '${(totalMinutes / 60).toStringAsFixed(1)}h total',
              icon: Icons.event_available_outlined,
            ),
            MetricTile(
              label: 'Plan',
              value: v.isValid ? 'Active' : 'Expired',
              sublabel: v.validUntil == null
                  ? v.planName
                  : 'until ${v.validUntil!.toIso8601String().substring(5, 10)}',
              icon: Icons.card_membership_outlined,
              tint: v.isValid ? LiblColors.info : LiblColors.danger,
            ),
            MetricTile(
              label: 'Fees',
              value: due.isPositive ? due.compact : 'Clear',
              sublabel: due.isPositive ? 'pending' : 'nothing outstanding',
              icon: Icons.payments_outlined,
              tint: due.isPositive ? LiblColors.warning : LiblColors.success,
            ),
          ],
        ),
        if (day?.lateEntry ?? false) ...[
          const SizedBox(height: LiblSpace.lg),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(LiblSpace.lg),
              child: Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    size: 20,
                    color: LiblColors.warning,
                  ),
                  const SizedBox(width: LiblSpace.md),
                  Expanded(
                    child: Text(
                      'Arrived after the usual start time today.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: LiblColors.textPrimary.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SectionHeader(
          title: 'A note on privacy',
          subtitle: 'What this screen deliberately does not show',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(LiblSpace.lg),
            child: Text(
              'You can see attendance, plan status and fees — the things a '
              'guardian is accountable for. You cannot see other students, '
              'staff notes, or anything from your child\'s wider Liboora '
              'profile. Those live in separate contexts with separate access '
              'rules.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.5,
                color: LiblColors.textMuted.withValues(alpha: 0.95),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static String _hhmm(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

class ParentAttendancePage extends StatelessWidget {
  const ParentAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final id = s.subjectStudentId;
    if (id == null) {
      return const EmptyState(icon: Icons.link_off, title: 'No child linked');
    }

    final history = s.container.attendance.forStudent(id).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        LiblSpace.lg,
        LiblSpace.md,
        LiblSpace.lg,
        LiblSpace.xxl,
      ),
      children: [
        const SectionHeader(
          title: 'Attendance record',
          subtitle: 'One row per day, corrections appended never edited',
        ),
        if (history.isEmpty)
          const Card(
            child: EmptyState(
              icon: Icons.event_busy_outlined,
              title: 'No attendance yet',
              message: 'Records appear the first time your child checks in.',
            ),
          )
        else
          PanelCard(
            children: [
              for (final d in history)
                ListTile(
                  dense: true,
                  leading: Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: LiblColors.brand.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      '${d.date.day}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: LiblColors.brand,
                      ),
                    ),
                  ),
                  title: Text(
                    d.date.toIso8601String().substring(0, 10),
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    d.firstEntry == null
                        ? 'No entry recorded'
                        : 'In ${_hhmm(d.firstEntry!)}'
                              '${d.lastExit == null ? ' · still inside' : ' · out ${_hhmm(d.lastExit!)}'}',
                    style: const TextStyle(fontSize: 11.5),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${d.timeInside.inHours}h ${d.timeInside.inMinutes % 60}m',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (d.lateEntry)
                        const Text(
                          'late',
                          style: TextStyle(
                            fontSize: 10,
                            color: LiblColors.warning,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
      ],
    );
  }

  static String _hhmm(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}
