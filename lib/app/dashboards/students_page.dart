/// Student roster + detail sheet.
///
/// The detail sheet is a deliberate demonstration of context boundaries: the
/// name comes from Enrollment, the plan from Membership, the balance from Fee,
/// the seat from Seating, presence from Attendance. Five contexts, five reads,
/// zero shared tables.
library;

import 'package:flutter/material.dart';
import 'package:liboora_contracts/liboora_contracts.dart';
import 'package:provider/provider.dart';

import '../../domain/library/enrollment/enrollment.dart';
import '../../domain/library/fee/fee.dart';
import '../session.dart';
import '../theme.dart';
import '../widgets/common.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  String _query = '';
  String _filter = 'All';

  static const _filters = ['All', 'Inside', 'Dues', 'Expiring'];

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();

    var list = s.students;
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list
          .where(
            (st) =>
                st.fullName.toLowerCase().contains(q) ||
                st.phone.contains(q) ||
                st.enrollmentNumber.toLowerCase().contains(q),
          )
          .toList();
    }
    list = switch (_filter) {
      'Inside' => list.where((st) => s.isInsideNow(st.id)).toList(),
      'Dues' => list.where((st) => s.outstandingOf(st.id).isPositive).toList(),
      'Expiring' =>
        list.where((st) => s.expiringSoon.any((e) => e.id == st.id)).toList(),
      _ => list,
    };

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            LiblSpace.lg,
            LiblSpace.md,
            LiblSpace.lg,
            LiblSpace.sm,
          ),
          child: TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: const InputDecoration(
              hintText: 'Search name, phone or enrolment no.',
              prefixIcon: Icon(Icons.search, size: 20),
              contentPadding: EdgeInsets.symmetric(
                horizontal: LiblSpace.lg,
                vertical: LiblSpace.md,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: LiblSpace.lg),
            children: [
              for (final f in _filters)
                Padding(
                  padding: const EdgeInsets.only(right: LiblSpace.sm),
                  child: ChoiceChip(
                    label: Text(f, style: const TextStyle(fontSize: 12.5)),
                    selected: _filter == f,
                    onSelected: (_) => setState(() => _filter = f),
                    selectedColor: LiblColors.brand.withValues(alpha: 0.12),
                    side: BorderSide(
                      color: _filter == f
                          ? LiblColors.brand
                          : LiblColors.border,
                    ),
                    showCheckmark: false,
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: list.isEmpty
              ? const EmptyState(
                  icon: Icons.person_search_outlined,
                  title: 'No students match',
                  message: 'Try a different search or filter.',
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    LiblSpace.lg,
                    LiblSpace.sm,
                    LiblSpace.lg,
                    LiblSpace.xxl,
                  ),
                  itemCount: list.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: LiblSpace.sm),
                  itemBuilder: (_, i) => _StudentCard(student: list[i]),
                ),
        ),
      ],
    );
  }
}

class _StudentCard extends StatelessWidget {
  const _StudentCard({required this.student});
  final StudentRecord student;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final inside = s.isInsideNow(student.id);
    final due = s.outstandingOf(student.id);
    final validity = s.validityOf(student.id);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => showStudentSheet(context, student),
        child: Padding(
          padding: const EdgeInsets.all(LiblSpace.md),
          child: Row(
            children: [
              Monogram(student.fullName, size: 42),
              const SizedBox(width: LiblSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.fullName,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${student.enrollmentNumber} · ${validity.planName}',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: LiblColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: LiblSpace.sm),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (inside)
                          const Pill(
                            'Inside',
                            color: LiblColors.success,
                            icon: Icons.circle,
                          )
                        else
                          const Pill('Away', color: LiblColors.textMuted),
                        if (!validity.isValid)
                          const Pill(
                            'No active plan',
                            color: LiblColors.danger,
                          ),
                        if (due.isPositive)
                          Pill(
                            '${due.formatted} due',
                            color: LiblColors.warning,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: LiblColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom sheet aggregating one student's view across five contexts.
void showStudentSheet(BuildContext context, StudentRecord student) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.82,
      maxChildSize: 0.95,
      builder: (ctx, controller) =>
          _StudentSheet(student: student, controller: controller),
    ),
  );
}

class _StudentSheet extends StatelessWidget {
  const _StudentSheet({required this.student, required this.controller});

  final StudentRecord student;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final validity = s.validityOf(student.id);
    final ledger = s.ledgerOf(student.id);
    final due = s.outstandingOf(student.id);
    final inside = s.isInsideNow(student.id);
    final day = s.container.attendance.find(
      student.id,
      s.container.clock.today(),
    );
    final activeAllocations = s.container.seatAllocations
        .forStudent(student.id)
        .where((a) => a.isActive)
        .toList();
    final allocation = activeAllocations.isEmpty
        ? null
        : activeAllocations.first;

    return ListView(
      controller: controller,
      padding: const EdgeInsets.all(LiblSpace.lg),
      children: [
        Row(
          children: [
            Monogram(student.fullName, size: 52),
            const SizedBox(width: LiblSpace.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.fullName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '+91 ${student.phone} · ${student.enrollmentNumber}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: LiblColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: LiblSpace.lg),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () async {
                  final msg = inside
                      ? await s.checkOut(student.id)
                      : await s.checkIn(student.id);
                  if (context.mounted) {
                    _toast(
                      context,
                      msg ?? (inside ? 'Checked out' : 'Checked in'),
                    );
                  }
                },
                icon: Icon(inside ? Icons.logout : Icons.login, size: 18),
                label: Text(inside ? 'Check out' : 'Check in'),
              ),
            ),
            const SizedBox(width: LiblSpace.sm),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: due.isPositive
                    ? () => _collectDialog(context, s, student.id, due)
                    : null,
                icon: const Icon(Icons.currency_rupee, size: 18),
                label: const Text('Collect'),
              ),
            ),
          ],
        ),
        const SectionHeader(title: 'Membership', subtitle: 'BC-02'),
        _kv('Plan', validity.planName),
        _kv('Status', validity.isValid ? 'Active' : 'Not active'),
        _kv(
          'Valid until',
          validity.validUntil == null
              ? '—'
              : validity.validUntil!.toIso8601String().substring(0, 10),
        ),
        _kv('Seats included', '${validity.seatQuota}'),
        const SectionHeader(title: 'Seat', subtitle: 'BC-04'),
        if (allocation == null)
          const Text(
            'No reserved seat.',
            style: TextStyle(fontSize: 13, color: LiblColors.textMuted),
          )
        else ...[
          _kv('Seat', allocation.seatLabel),
          _kv(
            'Allocated',
            allocation.allocatedOn.toIso8601String().substring(0, 10),
          ),
          _kv(
            'Until',
            allocation.window.end.toIso8601String().substring(0, 10),
          ),
        ],
        const SectionHeader(title: 'Today', subtitle: 'BC-03'),
        if (day == null)
          const Text(
            'No attendance recorded today.',
            style: TextStyle(fontSize: 13, color: LiblColors.textMuted),
          )
        else ...[
          _kv(
            'First entry',
            day.firstEntry == null ? '—' : _hhmm(day.firstEntry!),
          ),
          _kv('Last exit', day.lastExit == null ? '—' : _hhmm(day.lastExit!)),
          _kv(
            'Time inside',
            '${day.timeInside.inHours}h ${day.timeInside.inMinutes % 60}m',
          ),
          if (day.lateEntry) _kv('Flag', 'Late entry'),
        ],
        const SectionHeader(title: 'Fee ledger', subtitle: 'BC-05'),
        _kv('Raised', (ledger?.totalDue ?? Money.zero).formatted),
        _kv('Received', (ledger?.totalReceived ?? Money.zero).formatted),
        _kv('Balance', due.formatted, emphasise: due.isPositive),
        if (ledger != null && ledger.receipts.isNotEmpty) ...[
          const SizedBox(height: LiblSpace.md),
          for (final r in ledger.receipts.reversed.take(4))
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(
                    Icons.receipt_outlined,
                    size: 14,
                    color: LiblColors.textMuted,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      r.receiptNumber,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    '${r.mode.name} · ${r.amount.formatted}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
        const SizedBox(height: LiblSpace.xxl),
      ],
    );
  }

  static Widget _kv(String k, String v, {bool emphasise = false}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
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
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: emphasise ? LiblColors.warning : LiblColors.textPrimary,
          ),
        ),
      ],
    ),
  );

  static String _hhmm(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

void _toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
  );
}

Future<void> _collectDialog(
  BuildContext context,
  SessionController s,
  StudentRecordId id,
  Money due,
) async {
  var mode = PaymentMode.upi;
  final amount = TextEditingController(
    text: (due.minorUnits / 100).toStringAsFixed(0),
  );

  await showDialog<void>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setLocal) => AlertDialog(
        title: const Text('Collect payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixText: '₹ ',
                helperText: 'Balance ${due.formatted}',
              ),
            ),
            const SizedBox(height: LiblSpace.lg),
            Wrap(
              spacing: 6,
              children: [
                for (final m in PaymentMode.values)
                  ChoiceChip(
                    label: Text(m.name, style: const TextStyle(fontSize: 12)),
                    selected: mode == m,
                    showCheckmark: false,
                    onSelected: (_) => setLocal(() => mode = m),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(90, 42)),
            onPressed: () async {
              final rupees = int.tryParse(amount.text) ?? 0;
              Navigator.of(ctx).pop();
              final msg = await s.collect(id, Money.rupees(rupees), mode);
              if (context.mounted) {
                _toast(context, msg ?? 'Receipt issued for ₹$rupees');
              }
            },
            child: const Text('Collect'),
          ),
        ],
      ),
    ),
  );
}
