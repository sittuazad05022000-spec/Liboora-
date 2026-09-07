/// **STUDENT APP BOUNDARY** — the future `liboora-student-app`.
///
/// Roles: `TR-4` Student and `TR-5` Parent (`PRD-001` Authentication v2.0
/// §2.4). They are one boundary because they are one *audience*: a parent's
/// screens are a guardian's view of the same student record, scoped by
/// `guardianOf` rather than `self` (`MP-GBR-21`'s closed scope register).
///
/// **What extraction would take.** Everything under `lib/app/student/**`, plus
/// `lib/app/shared/**`, plus the unchanged `platform/`, `domain/`,
/// `bootstrap/` and `packages/liboora_contracts`. ⛔ Nothing from
/// `lib/app/staff/**` or `lib/app/platform_admin/**` — that independence is the
/// point of the split, and `test/architecture/app_boundary_test.dart` enforces
/// it as a build failure rather than a convention.
///
/// ⛔ **This shell must never route a staff or platform role.** It handles the
/// two roles it owns and treats everything else as an explicit, visible
/// unsupported state — see [_UnsupportedRole]. It does not fall through to a
/// staff screen, and it does not silently show an empty frame.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../platform/identity/identity.dart';
import '../shared/account_sheet.dart';
import '../shared/app_chrome.dart';
import '../shared/session.dart';
import '../shared/theme.dart';
import 'parent/parent_dashboard.dart';
import 'student/student_dashboard.dart';

/// The roles this boundary owns. Declared as data so a test can assert the
/// three boundaries partition the tenant-role set without overlap.
const Set<AccessRole> kStudentAppRoles = {
  AccessRole.student,
  AccessRole.parent,
};

class StudentAppShell extends StatelessWidget {
  const StudentAppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();

    if (!kStudentAppRoles.contains(s.role)) {
      // Reached only by a composition-root error. Made loud on purpose: a
      // silent fallback here is how a staff surface leaks into a customer app.
      return _UnsupportedRole(role: s.role);
    }

    return AppScaffold(
      destinations: _destinationsFor(s.role),
      title: s.tenant.name,
      subtitle: '${s.branchInfo.name} · ${s.role.label}',
      accountInitial: (s.account?.displayName ?? '?')
          .substring(0, 1)
          .toUpperCase(),
      trailing: [
        if (!s.container.sync.online)
          OfflineIndicator(onTap: () => _openAccount(context, s)),
      ],
      onAccountTap: () => _openAccount(context, s),
    );
  }

  /// Navigation for the two customer-facing roles.
  ///
  /// `StudentFeesPage` appears in both sets deliberately: fee visibility is the
  /// same read for a student and for their guardian, and duplicating the screen
  /// to give each role its own copy would duplicate presentation logic for no
  /// behavioural difference. This preserves the pre-split behaviour exactly.
  List<AppDestination> _destinationsFor(AccessRole role) {
    switch (role) {
      case AccessRole.student:
        return const [
          AppDestination(
            icon: Icons.today_outlined,
            selectedIcon: Icons.today,
            label: 'Today',
            page: StudentTodayPage(),
          ),
          AppDestination(
            icon: Icons.card_membership_outlined,
            selectedIcon: Icons.card_membership,
            label: 'Plan',
            page: StudentPlanPage(),
          ),
          AppDestination(
            icon: Icons.receipt_long_outlined,
            selectedIcon: Icons.receipt_long,
            label: 'Fees',
            page: StudentFeesPage(),
          ),
        ];
      case AccessRole.parent:
        return const [
          AppDestination(
            icon: Icons.family_restroom_outlined,
            selectedIcon: Icons.family_restroom,
            label: 'Child',
            page: ParentOverviewPage(),
          ),
          AppDestination(
            icon: Icons.event_available_outlined,
            selectedIcon: Icons.event_available,
            label: 'Attendance',
            page: ParentAttendancePage(),
          ),
          AppDestination(
            icon: Icons.receipt_long_outlined,
            selectedIcon: Icons.receipt_long,
            label: 'Fees',
            page: StudentFeesPage(),
          ),
        ];
      // Staff roles are not this boundary's to route. Returning an empty set is
      // unreachable in practice because `build` refuses first; it exists so the
      // switch stays exhaustive without a `default` that could silently absorb
      // a role added to the enum later.
      case AccessRole.owner:
      case AccessRole.manager:
      case AccessRole.reception:
        return const [];
    }
  }

  void _openAccount(BuildContext context, SessionController s) {
    showModalBottomSheet<void>(
      context: context,
      // Customer roles hold no branch-switching capability, so the switcher is
      // not offered. This is a boundary decision stated here, not a role test
      // hidden inside the shared sheet. Pre-split behaviour was identical:
      // `canSwitchBranch` was false for student and parent.
      builder: (_) => AccountSheet(session: s, showBranchSwitcher: false),
    );
  }
}

class _UnsupportedRole extends StatelessWidget {
  const _UnsupportedRole({required this.role});

  final AccessRole role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(LiblSpace.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.block, size: 40, color: LiblColors.textMuted),
              const SizedBox(height: LiblSpace.lg),
              Text(
                'The ${role.label} role is not part of the student app',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
