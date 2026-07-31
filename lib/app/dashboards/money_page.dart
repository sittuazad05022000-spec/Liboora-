/// Collections view.
///
/// Note what this page does NOT show: Liboora's own subscription invoice to
/// this library. That is `SubscriptionCharge` (BC-20), a different money
/// domain, and mixing the two on one screen is how the two get conflated in
/// code six months later.
library;

import 'package:flutter/material.dart';
import 'package:liboora_contracts/liboora_contracts.dart';
import 'package:provider/provider.dart';

import '../../domain/library/fee/fee.dart';
import '../session.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'students_page.dart' show showStudentSheet;

class MoneyPage extends StatelessWidget {
  const MoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final m = s.container.analytics.metricsFor(s.tenant.id);
    final collectedToday = Money.paise(m.collectedTodayMinor);
    final outstanding = s.totalOutstanding;

    final ledgers = s.container.ledgers.all();
    final raisedAll = ledgers.fold(Money.zero, (sum, l) => sum + l.totalDue);
    final receivedAll = ledgers.fold(
      Money.zero,
      (sum, l) => sum + l.totalReceived,
    );

    final receipts = <Receipt>[for (final l in ledgers) ...l.receipts]
      ..sort((a, b) => b.receivedOn.compareTo(a.receivedOn));

    final debtors = s.withOpenDues.toList()
      ..sort(
        (a, b) => s
            .outstandingOf(b.id)
            .minorUnits
            .compareTo(s.outstandingOf(a.id).minorUnits),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'COLLECTED TODAY',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.7,
                    color: LiblColors.textMuted,
                  ),
                ),
                const SizedBox(height: LiblSpace.sm),
                Text(
                  collectedToday.formatted,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: LiblSpace.lg),
                const Divider(),
                const SizedBox(height: LiblSpace.md),
                _row('Total raised (all time)', raisedAll.formatted),
                _row('Total received', receivedAll.formatted),
                _row(
                  'Outstanding',
                  outstanding.formatted,
                  color: outstanding.isPositive
                      ? LiblColors.warning
                      : LiblColors.success,
                ),
                const SizedBox(height: LiblSpace.md),
                MeterBar(
                  fraction: raisedAll.minorUnits == 0
                      ? 1
                      : receivedAll.minorUnits / raisedAll.minorUnits,
                  color: LiblColors.success,
                ),
                const SizedBox(height: LiblSpace.sm),
                Text(
                  raisedAll.minorUnits == 0
                      ? 'Nothing raised yet'
                      : '${(receivedAll.minorUnits / raisedAll.minorUnits * 100).round()}% of billed fees recovered',
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: LiblColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
        SectionHeader(
          title: 'Open dues',
          subtitle: '${debtors.length} students · tap to collect',
        ),
        if (debtors.isEmpty)
          const Card(
            child: EmptyState(
              icon: Icons.task_alt,
              title: 'Everything collected',
              message: 'No student carries an outstanding balance.',
            ),
          )
        else
          PanelCard(
            children: [
              for (final st in debtors)
                ListTile(
                  leading: Monogram(st.fullName, size: 38),
                  title: Text(
                    st.fullName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${s.validityOf(st.id).planName} · ${st.enrollmentNumber}',
                    style: const TextStyle(fontSize: 11.5),
                  ),
                  trailing: Text(
                    s.outstandingOf(st.id).formatted,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: LiblColors.warning,
                    ),
                  ),
                  onTap: () => showStudentSheet(context, st),
                ),
            ],
          ),
        const SectionHeader(
          title: 'Recent receipts',
          subtitle: 'Immutable once issued',
        ),
        if (receipts.isEmpty)
          const Card(
            child: EmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'No receipts yet',
            ),
          )
        else
          PanelCard(
            children: [
              for (final r in receipts.take(10))
                ListTile(
                  dense: true,
                  leading: Container(
                    width: 34,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: LiblColors.success.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Icon(
                      Icons.currency_rupee,
                      size: 15,
                      color: LiblColors.success,
                    ),
                  ),
                  title: Text(
                    r.receiptNumber,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${r.mode.name} · ${_hhmm(r.receivedOn)} · by ${r.collectedBy}',
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

  static Widget _row(String k, String v, {Color? color}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: Text(
            k,
            style: const TextStyle(fontSize: 13, color: LiblColors.textMuted),
          ),
        ),
        Text(
          v,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: color ?? LiblColors.textPrimary,
          ),
        ),
      ],
    ),
  );

  static String _hhmm(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}
