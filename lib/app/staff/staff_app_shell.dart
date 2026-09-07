/// **STAFF APP BOUNDARY** — the future `liboora-staff-app`.
///
/// Roles: `TR-1` Owner, `TR-2` Manager, `TR-3` Reception (`PRD-001`
/// Authentication v2.0 §2.4). They are one boundary because they operate the
/// *same* library from the same premises, differing in authority rather than
/// in audience.
///
/// ⚠⚠ **`TR-1` Owner is the LIBRARY Owner — a tenant role.** Its scope is
/// *"Entire library"* (`PRD-001` §2.4). It is **not** a platform role and
/// carries no authority over Liboora itself. The platform roles `PR-1`
/// Platform Administrator and `PR-2` Platform Support are a **separate closed
/// set** (`PRD-001` §2.3, `SECP-FR-003`) and belong to
/// `lib/app/platform_admin/**`, never here. Conflating the two is the precise
/// mistake this boundary split exists to make structurally impossible.
///
/// **What extraction would take.** Everything under `lib/app/staff/**`, plus
/// `lib/app/shared/**`, plus the unchanged `platform/`, `domain/`,
/// `bootstrap/` and `packages/liboora_contracts`. ⛔ Nothing from
/// `lib/app/student/**` or `lib/app/platform_admin/**`.
///
/// ⛔ **This shell must never route a customer or platform role.** Defence in
/// depth sits behind it: the Policy Decision Point refuses the command anyway,
/// and a destination that is never built cannot be navigated to.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../platform/identity/identity.dart';
import '../shared/account_sheet.dart';
import '../shared/app_chrome.dart';
import '../shared/session.dart';
import '../shared/theme.dart';
import 'owner/ops_page.dart';
import 'reception/reception_desk.dart';
import 'shared/money_page.dart';
import 'shared/overview_page.dart';
import 'shared/seat_map_page.dart';
import 'shared/students_page.dart';

/// The roles this boundary owns. Declared as data so a test can assert the
/// three boundaries partition the tenant-role set without overlap.
const Set<AccessRole> kStaffAppRoles = {
  AccessRole.owner,
  AccessRole.manager,
  AccessRole.reception,
};

/// Roles that may switch branch.
///
/// Owner and Manager hold library-wide scope; Reception is scoped to the desk
/// it works at (`PRD-001` §2.4). Declared here — inside the boundary that owns
/// these roles — so the shared account sheet stays role-neutral.
const Set<AccessRole> kBranchSwitchingRoles = {
  AccessRole.owner,
  AccessRole.manager,
};

class StaffAppShell extends StatelessWidget {
  const StaffAppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();

    if (!kStaffAppRoles.contains(s.role)) {
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

  /// Navigation for the three staff roles.
  ///
  /// Reception physically cannot navigate to revenue because the destination is
  /// never built — defence in depth behind the Policy Decision Point, which
  /// would refuse the command anyway. Each set is byte-for-byte the set the
  /// pre-split `HomeShell` produced, so no behaviour changed here.
  List<AppDestination> _destinationsFor(AccessRole role) {
    switch (role) {
      case AccessRole.owner:
        return const [
          AppDestination(
            icon: Icons.insights_outlined,
            selectedIcon: Icons.insights,
            label: 'Overview',
            page: OverviewPage(),
          ),
          AppDestination(
            icon: Icons.people_outline,
            selectedIcon: Icons.people,
            label: 'Students',
            page: StudentsPage(),
          ),
          AppDestination(
            icon: Icons.grid_view_outlined,
            selectedIcon: Icons.grid_view,
            label: 'Seats',
            page: SeatMapPage(),
          ),
          AppDestination(
            icon: Icons.payments_outlined,
            selectedIcon: Icons.payments,
            label: 'Money',
            page: MoneyPage(),
          ),
          AppDestination(
            icon: Icons.tune_outlined,
            selectedIcon: Icons.tune,
            label: 'Ops',
            page: OpsPage(),
          ),
        ];
      case AccessRole.manager:
        return const [
          AppDestination(
            icon: Icons.insights_outlined,
            selectedIcon: Icons.insights,
            label: 'Overview',
            page: OverviewPage(),
          ),
          AppDestination(
            icon: Icons.people_outline,
            selectedIcon: Icons.people,
            label: 'Students',
            page: StudentsPage(),
          ),
          AppDestination(
            icon: Icons.grid_view_outlined,
            selectedIcon: Icons.grid_view,
            label: 'Seats',
            page: SeatMapPage(),
          ),
          AppDestination(
            icon: Icons.payments_outlined,
            selectedIcon: Icons.payments,
            label: 'Money',
            page: MoneyPage(),
          ),
        ];
      case AccessRole.reception:
        return const [
          AppDestination(
            icon: Icons.how_to_reg_outlined,
            selectedIcon: Icons.how_to_reg,
            label: 'Desk',
            page: ReceptionDesk(),
          ),
          AppDestination(
            icon: Icons.people_outline,
            selectedIcon: Icons.people,
            label: 'Students',
            page: StudentsPage(),
          ),
          AppDestination(
            icon: Icons.grid_view_outlined,
            selectedIcon: Icons.grid_view,
            label: 'Seats',
            page: SeatMapPage(),
          ),
        ];
      // Customer roles are not this boundary's to route. See the note in
      // StudentAppShell on why this is exhaustive rather than defaulted.
      case AccessRole.student:
      case AccessRole.parent:
        return const [];
    }
  }

  void _openAccount(BuildContext context, SessionController s) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => AccountSheet(
        session: s,
        showBranchSwitcher: kBranchSwitchingRoles.contains(s.role),
      ),
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
                'The ${role.label} role is not part of the staff app',
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
