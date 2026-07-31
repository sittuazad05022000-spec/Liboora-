/// Reception desk — the highest-traffic screen in the product.
///
/// Optimised for one thing: a queue of students at 6am wanting to get to their
/// seat. Search, one tap, done. Check-in is idempotent, so a double tap is a
/// no-op rather than a duplicate punch, and an expired membership is *recorded
/// and flagged* rather than blocked (edge E-03) — never lock a paying student
/// out at the door over a stale projection.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/library/enrollment/enrollment.dart';
import '../session.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'students_page.dart' show showStudentSheet;

class ReceptionDesk extends StatefulWidget {
  const ReceptionDesk({super.key});

  @override
  State<ReceptionDesk> createState() => _ReceptionDeskState();
}

class _ReceptionDeskState extends State<ReceptionDesk> {
  final _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _snack(String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
      ),
    );
  }

  Future<void> _toggle(StudentRecord st) async {
    final s = context.read<SessionController>();
    final wasInside = s.isInsideNow(st.id);
    final validity = s.validityOf(st.id);

    final msg = wasInside ? await s.checkOut(st.id) : await s.checkIn(st.id);
    if (!mounted) return;

    if (msg != null) {
      _snack(msg, color: LiblColors.danger);
      return;
    }
    if (!wasInside && !validity.isValid) {
      _snack(
        '${st.fullName} checked in — membership expired, flagged for follow-up',
        color: LiblColors.warning,
      );
    } else {
      _snack(
        '${st.fullName} ${wasInside ? 'checked out' : 'checked in'}',
        color: LiblColors.success,
      );
    }
    setState(() => _query = '');
    _search.clear();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final all = s.students;
    final inside = all.where((st) => s.isInsideNow(st.id)).toList();

    final matches = _query.isEmpty
        ? const <StudentRecord>[]
        : all
              .where(
                (st) =>
                    st.fullName.toLowerCase().contains(_query.toLowerCase()) ||
                    st.phone.contains(_query) ||
                    st.enrollmentNumber.toLowerCase().contains(
                      _query.toLowerCase(),
                    ),
              )
              .take(6)
              .toList();

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(
            LiblSpace.lg,
            LiblSpace.md,
            LiblSpace.lg,
            96,
          ),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(LiblSpace.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${inside.length} inside now',
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '${all.length} enrolled at ${s.branchInfo.name}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: LiblColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!s.container.sync.online)
                          const Pill(
                            'Offline',
                            color: LiblColors.accent,
                            icon: Icons.cloud_off,
                          ),
                      ],
                    ),
                    const SizedBox(height: LiblSpace.lg),
                    TextField(
                      controller: _search,
                      onChanged: (v) => setState(() => _query = v),
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Scan or type name / phone',
                        prefixIcon: const Icon(Icons.qr_code_scanner, size: 20),
                        suffixIcon: _query.isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.close, size: 18),
                                onPressed: () {
                                  _search.clear();
                                  setState(() => _query = '');
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (matches.isNotEmpty) ...[
              const SectionHeader(
                title: 'Matches',
                subtitle: 'Tap to check in or out',
              ),
              PanelCard(
                children: [
                  for (final st in matches)
                    _DeskRow(
                      student: st,
                      inside: s.isInsideNow(st.id),
                      onTap: () => _toggle(st),
                      onOpen: () => showStudentSheet(context, st),
                    ),
                ],
              ),
            ],
            SectionHeader(
              title: 'Currently inside',
              subtitle: inside.isEmpty
                  ? 'The hall is empty'
                  : 'Tap a student to check them out',
            ),
            if (inside.isEmpty)
              const Card(
                child: EmptyState(
                  icon: Icons.meeting_room_outlined,
                  title: 'Nobody inside',
                  message: 'Check-ins will appear here as students arrive.',
                ),
              )
            else
              PanelCard(
                children: [
                  for (final st in inside)
                    _DeskRow(
                      student: st,
                      inside: true,
                      onTap: () => _toggle(st),
                      onOpen: () => showStudentSheet(context, st),
                    ),
                ],
              ),
          ],
        ),
        Positioned(
          right: LiblSpace.lg,
          bottom: LiblSpace.lg,
          child: FloatingActionButton.extended(
            backgroundColor: LiblColors.brand,
            foregroundColor: Colors.white,
            onPressed: () => _enrollDialog(context),
            icon: const Icon(Icons.person_add_alt_1),
            label: const Text('Walk-in'),
          ),
        ),
      ],
    );
  }

  Future<void> _enrollDialog(BuildContext context) async {
    final s = context.read<SessionController>();
    final name = TextEditingController();
    final phone = TextEditingController();
    final year = TextEditingController(text: '2002');

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enroll walk-in student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Full name'),
            ),
            const SizedBox(height: LiblSpace.md),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile',
                prefixText: '+91 ',
              ),
            ),
            const SizedBox(height: LiblSpace.md),
            TextField(
              controller: year,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Year of birth',
                helperText: 'A guardian is mandatory under 18',
              ),
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
              final y = int.tryParse(year.text) ?? 2002;
              final dob = DateTime(y, 6, 15);
              final minor = DateTime.now().year - y < 18;
              Navigator.of(ctx).pop();
              final msg = await s.enroll(
                fullName: name.text,
                phone: phone.text,
                dob: dob,
                guardian: minor
                    ? GuardianLink(
                        name: 'Guardian of ${name.text}',
                        phone: phone.text,
                      )
                    : null,
              );
              if (!mounted) return;
              _snack(
                msg ?? '${name.text} enrolled',
                color: msg == null ? LiblColors.success : LiblColors.danger,
              );
            },
            child: const Text('Enroll'),
          ),
        ],
      ),
    );
  }
}

class _DeskRow extends StatelessWidget {
  const _DeskRow({
    required this.student,
    required this.inside,
    required this.onTap,
    required this.onOpen,
  });

  final StudentRecord student;
  final bool inside;
  final VoidCallback onTap;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final v = s.validityOf(student.id);

    return ListTile(
      onTap: onTap,
      leading: Monogram(student.fullName, size: 40),
      title: Text(
        student.fullName,
        style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        children: [
          Text(
            student.enrollmentNumber,
            style: const TextStyle(fontSize: 11.5, color: LiblColors.textMuted),
          ),
          if (!v.isValid) ...[
            const SizedBox(width: 6),
            const Pill('Expired', color: LiblColors.danger),
          ],
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: (inside ? LiblColors.danger : LiblColors.success)
                  .withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text(
              inside ? 'OUT' : 'IN',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: inside ? LiblColors.danger : LiblColors.success,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, size: 18),
            color: LiblColors.textMuted,
            onPressed: onOpen,
          ),
        ],
      ),
    );
  }
}
