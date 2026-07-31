/// Student-facing screens.
///
/// A student sees only their own record. That is enforced twice: the session
/// exposes exactly one `subjectStudentId`, and the Policy Decision Point grants
/// the student role nothing but `viewStudent`.
library;

import 'package:flutter/material.dart';
import 'package:liboora_contracts/liboora_contracts.dart';
import 'package:provider/provider.dart';

import '../../domain/library/membership/membership.dart';
import '../session.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// Shown when a role has no student record attached — a real state, not an error.
class _NoSubject extends StatelessWidget {
  const _NoSubject();

  @override
  Widget build(BuildContext context) => const EmptyState(
    icon: Icons.link_off,
    title: 'No student record linked',
    message: 'This account is not yet linked to an enrolment at this library.',
  );
}

class StudentTodayPage extends StatelessWidget {
  const StudentTodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final id = s.subjectStudentId;
    if (id == null) return const _NoSubject();

    final student = s.studentById(id);
    final v = s.validityOf(id);
    final day = s.container.attendance.find(id, s.container.clock.today());
    final inside = day?.isOpen ?? false;
    final allocations = s.container.seatAllocations
        .forStudent(id)
        .where((a) => a.isActive)
        .toList();
    final seatLabel = allocations.isEmpty ? null : allocations.first.seatLabel;
    final due = s.outstandingOf(id);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Monogram(student?.fullName ?? '?', size: 48),
                    const SizedBox(width: LiblSpace.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student?.fullName ?? '—',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${student?.enrollmentNumber ?? ''} · ${s.branchInfo.name}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: LiblColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Pill(
                      inside ? 'Inside' : 'Away',
                      color: inside ? LiblColors.success : LiblColors.textMuted,
                    ),
                  ],
                ),
                const Divider(height: LiblSpace.xl),
                Row(
                  children: [
                    _Stat(
                      label: 'Seat',
                      value: seatLabel ?? 'Floating',
                      icon: Icons.chair_alt_outlined,
                    ),
                    _Stat(
                      label: 'Today',
                      value: day == null
                          ? '—'
                          : '${day.timeInside.inHours}h ${day.timeInside.inMinutes % 60}m',
                      icon: Icons.timer_outlined,
                    ),
                    _Stat(
                      label: 'Plan ends',
                      value: v.validUntil == null
                          ? '—'
                          : '${v.validUntil!.difference(s.container.clock.today()).inDays}d',
                      icon: Icons.event_outlined,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (due.isPositive) ...[
          const SizedBox(height: LiblSpace.md),
          Card(
            child: Container(
              decoration: BoxDecoration(
                color: LiblColors.warning.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.all(LiblSpace.lg),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: LiblColors.warning,
                    size: 20,
                  ),
                  const SizedBox(width: LiblSpace.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${due.formatted} pending',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text(
                          'Please settle at the reception desk.',
                          style: TextStyle(
                            fontSize: 12,
                            color: LiblColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SectionHeader(
          title: "Today's punches",
          subtitle: 'Recorded at the desk',
        ),
        if (day == null || day.entries.isEmpty)
          const Card(
            child: EmptyState(
              icon: Icons.login_outlined,
              title: 'Not checked in yet',
              message: 'Scan the QR code at reception when you arrive.',
            ),
          )
        else
          PanelCard(
            children: [
              for (var i = 0; i < day.entries.length; i++)
                ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.login,
                    size: 18,
                    color: LiblColors.success,
                  ),
                  title: Text(
                    'Entry ${_hhmm(day.entries[i].at)}',
                    style: const TextStyle(fontSize: 13),
                  ),
                  subtitle: Text(
                    'via ${day.entries[i].method.name}'
                    '${day.entries[i].capturedOffline ? ' · captured offline' : ''}',
                    style: const TextStyle(fontSize: 11.5),
                  ),
                  trailing: i < day.exits.length
                      ? Text(
                          'out ${_hhmm(day.exits[i].at)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: LiblColors.textMuted,
                          ),
                        )
                      : const Pill('open', color: LiblColors.success),
                ),
            ],
          ),
        if (day?.lateEntry ?? false) ...[
          const SizedBox(height: LiblSpace.md),
          const Pill('Marked as a late entry today', color: LiblColors.warning),
        ],
      ],
    );
  }

  static String _hhmm(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

class StudentPlanPage extends StatelessWidget {
  const StudentPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final id = s.subjectStudentId;
    if (id == null) return const _NoSubject();

    final memberships = s.container.memberships.forStudent(id);
    final v = s.validityOf(id);
    final today = s.container.clock.today();

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        v.planName,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Pill(
                      v.isValid ? 'Active' : 'Inactive',
                      color: v.isValid ? LiblColors.success : LiblColors.danger,
                    ),
                  ],
                ),
                const SizedBox(height: LiblSpace.lg),
                if (v.validUntil != null) ...[
                  Text(
                    '${v.validUntil!.difference(today).inDays} days remaining',
                    style: const TextStyle(fontSize: 13.5),
                  ),
                  const SizedBox(height: LiblSpace.sm),
                  MeterBar(
                    fraction: _elapsedFraction(memberships, today),
                    color: v.validUntil!.difference(today).inDays <= 7
                        ? LiblColors.warning
                        : LiblColors.brand,
                  ),
                  const SizedBox(height: LiblSpace.sm),
                  Text(
                    'Valid until ${v.validUntil!.toIso8601String().substring(0, 10)}',
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: LiblColors.textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SectionHeader(title: 'History', subtitle: 'All terms on record'),
        if (memberships.isEmpty)
          const Card(
            child: EmptyState(
              icon: Icons.card_membership_outlined,
              title: 'No membership on record',
            ),
          )
        else
          PanelCard(
            children: [
              for (final m in memberships)
                ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.card_membership,
                    size: 18,
                    color: m.isValidOn(today)
                        ? LiblColors.success
                        : LiblColors.textMuted,
                  ),
                  title: Text(
                    m.plan.name,
                    style: const TextStyle(fontSize: 13.5),
                  ),
                  subtitle: Text(
                    '${m.term.start.toIso8601String().substring(0, 10)} → '
                    '${m.term.end.toIso8601String().substring(0, 10)}',
                    style: const TextStyle(fontSize: 11.5),
                  ),
                  trailing: Text(
                    m.plan.price.formatted,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        const SectionHeader(
          title: 'Available plans',
          subtitle: 'Ask at reception',
        ),
        PanelCard(
          children: [
            for (final p in s.container.plans)
              ListTile(
                dense: true,
                title: Text(p.name, style: const TextStyle(fontSize: 13.5)),
                subtitle: Text(
                  '${p.durationDays} days · '
                  '${p.seatQuota == 0 ? 'no reserved seat' : '${p.seatQuota} reserved seat'}',
                  style: const TextStyle(fontSize: 11.5),
                ),
                trailing: Text(
                  p.price.formatted,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  static double _elapsedFraction(List<Membership> memberships, DateTime today) {
    for (final m in memberships) {
      if (m.isValidOn(today)) {
        final total = m.term.lengthInDays;
        if (total == 0) return 1;
        return today.difference(m.term.start).inDays / total;
      }
    }
    return 0;
  }
}

class StudentFeesPage extends StatelessWidget {
  const StudentFeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final id = s.subjectStudentId;
    if (id == null) return const _NoSubject();

    final ledger = s.ledgerOf(id);
    final due = s.outstandingOf(id);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BALANCE',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.7,
                    color: LiblColors.textMuted,
                  ),
                ),
                const SizedBox(height: LiblSpace.sm),
                Text(
                  due.isPositive ? due.formatted : 'All clear',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: due.isPositive
                        ? LiblColors.warning
                        : LiblColors.success,
                  ),
                ),
                const SizedBox(height: LiblSpace.md),
                Text(
                  'Billed ${(ledger?.totalDue ?? Money.zero).formatted} · '
                  'paid ${(ledger?.totalReceived ?? Money.zero).formatted}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: LiblColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SectionHeader(
          title: 'Charges',
          subtitle: 'Raised against your account',
        ),
        if (ledger == null || ledger.dues.isEmpty)
          const Card(
            child: EmptyState(
              icon: Icons.receipt_outlined,
              title: 'No charges',
            ),
          )
        else
          PanelCard(
            children: [
              for (final d in ledger.dues.reversed)
                ListTile(
                  dense: true,
                  title: Text(
                    d.description,
                    style: const TextStyle(fontSize: 13.5),
                  ),
                  subtitle: Text(
                    'Due ${d.dueOn.toIso8601String().substring(0, 10)}'
                    '${d.discount.isZero ? '' : ' · discount ${d.discount.formatted}'}',
                    style: const TextStyle(fontSize: 11.5),
                  ),
                  trailing: Text(
                    d.netAmount.formatted,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        const SectionHeader(
          title: 'Receipts',
          subtitle: 'Immutable once issued',
        ),
        if (ledger == null || ledger.receipts.isEmpty)
          const Card(
            child: EmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'No receipts yet',
            ),
          )
        else
          PanelCard(
            children: [
              for (final r in ledger.receipts.reversed)
                ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.verified_outlined,
                    size: 18,
                    color: LiblColors.success,
                  ),
                  title: Text(
                    r.receiptNumber,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${r.receivedOn.toIso8601String().substring(0, 10)} · ${r.mode.name}',
                    style: const TextStyle(fontSize: 11.5),
                  ),
                  trailing: Text(
                    r.amount.formatted,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value, required this.icon});
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: LiblColors.textMuted),
          const SizedBox(height: 5),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
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
