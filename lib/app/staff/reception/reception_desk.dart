/// Reception desk — the highest-traffic screen in the product.
///
/// Optimised for one thing: a queue of students at 6am wanting to get to their
/// seat. Search, one tap, done. Check-in is idempotent, so a double tap is a
/// no-op rather than a duplicate punch, and an expired membership is *recorded
/// and flagged* rather than blocked (edge E-03) — never lock a paying student
/// out at the door over a stale projection.
library;

import 'package:flutter/material.dart';
import 'package:liboora_contracts/liboora_contracts.dart';
import 'package:provider/provider.dart';

import '../../../bootstrap/di.dart'
    show
        DuplicateOutcome,
        EnrolledOutcome,
        FailedOutcome,
        RestoreRequiredOutcome;
import '../../shared/session.dart';
import '../../shared/theme.dart';
import '../../shared/widgets/common.dart';
import '../shared/students_page.dart' show showStudentSheet;

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

  Future<void> _toggle(StudentEntry st) async {
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
        ? const <StudentEntry>[]
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
    final guardianName = TextEditingController();
    final guardianPhone = TextEditingController();
    // `ADR-0179` — a DOB is recorded only when it is truly known (BC-10
    // evidence). When it is not, the staff record an audited `SM-4.5a`
    // declaration instead; a year alone is never expanded into a fabricated
    // date.
    DateTime? dob;
    bool? declaredMinor;
    // `SM-3.6` — one key per dialog, generated before any submission so a
    // double-tap on Enroll replays to the same record instead of creating a
    // second one.
    final key = IdempotencyKey('enroll_${s.container.ids.next('enr')}');

    Future<void> submit(BuildContext ctx) async {
      final pickedDob = dob;
      final guardianRequired = pickedDob != null
          ? DateTime.now().year - pickedDob.year < 18
          : (declaredMinor ?? true); // `SM-4.5b` fail-safe mirrors the domain.
      final hasGuardian = guardianName.text.trim().isNotEmpty;
      if (guardianRequired && !hasGuardian) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
            content: Text(
              'A guardian is mandatory for minors, and whenever no age '
              'evidence exists (SM-4.5b).',
            ),
          ),
        );
        return;
      }
      final guardian = hasGuardian
          ? GuardianLink(
              name: guardianName.text.trim(),
              phone: guardianPhone.text.trim(),
            )
          : null;
      if (ctx.mounted) Navigator.of(ctx).pop();
      final outcome = await s.enroll(
        fullName: name.text.trim(),
        phone: phone.text.trim(),
        idempotencyKey: key,
        dateOfBirth: dob,
        declaredMinor: dob == null ? declaredMinor : null,
        guardian: guardian,
      );
      if (!mounted) return;
      switch (outcome) {
        case EnrolledOutcome(:final enrollmentNumber):
          _snack(
            '${name.text.trim()} enrolled as $enrollmentNumber',
            color: LiblColors.success,
          );
        case DuplicateOutcome(:final existingStudentRecordId, :final message):
          // `SM-3.13` — open the existing record, never retry.
          _snack(message, color: LiblColors.warning);
          final entry = s.container.studentDirectory.byId(
            existingStudentRecordId,
          );
          if (entry != null && context.mounted) {
            showStudentSheet(context, entry);
          }
        case RestoreRequiredOutcome(
          :final archivedStudentRecordId,
          :final archivedCount,
          :final message,
        ):
          // `SM-3.14` — restore is offered, never performed silently; the
          // authority check (TR-1) lives in the use case, not here.
          if (!context.mounted) return;
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Archived record found'),
              content: Text(
                '$message\n\nRestore the most recent one? '
                '($archivedCount archived record(s); restore is owner-only.)',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: const Text('Restore'),
                ),
              ],
            ),
          );
          if (confirmed != true || !mounted) return;
          final err = await s.restoreStudent(archivedStudentRecordId);
          if (!mounted) return;
          _snack(
            err ?? 'Record restored',
            color: err == null ? LiblColors.success : LiblColors.danger,
          );
        case FailedOutcome(:final message):
          _snack(message, color: LiblColors.danger);
      }
    }

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Enroll walk-in student'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Date of birth: '
                        '${dob == null ? 'not recorded' : '${dob!.day}/${dob!.month}/${dob!.year}'}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: ctx,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          // A future DOB is invalid input (BC-10 invariant) —
                          // the picker cannot produce one.
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setDialogState(() {
                            dob = picked;
                            declaredMinor = null;
                          });
                        }
                      },
                      child: const Text('Pick'),
                    ),
                    if (dob != null)
                      IconButton(
                        tooltip: 'Clear date of birth',
                        onPressed: () => setDialogState(() => dob = null),
                        icon: const Icon(Icons.clear, size: 20),
                      ),
                  ],
                ),
                if (dob == null)
                  DropdownButtonFormField<bool?>(
                    initialValue: declaredMinor,
                    decoration: const InputDecoration(
                      labelText: 'Age declaration (no DOB recorded)',
                      helperText: 'SM-4.5a — recorded against the actor',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: null,
                        child: Text('Not declared — treated as minor'),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text('Declared adult (18+)'),
                      ),
                      DropdownMenuItem(
                        value: true,
                        child: Text('Declared minor (under 18)'),
                      ),
                    ],
                    onChanged: (v) => setDialogState(() => declaredMinor = v),
                  ),
                const SizedBox(height: LiblSpace.md),
                TextField(
                  controller: guardianName,
                  decoration: const InputDecoration(
                    labelText: 'Guardian name (if applicable)',
                  ),
                ),
                const SizedBox(height: LiblSpace.md),
                TextField(
                  controller: guardianPhone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Guardian mobile (if applicable)',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size(90, 42)),
              onPressed: () => submit(ctx),
              child: const Text('Enroll'),
            ),
          ],
        ),
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

  final StudentEntry student;
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
