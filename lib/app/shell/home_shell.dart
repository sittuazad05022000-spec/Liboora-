/// Role-aware shell.
///
/// The navigation set is derived from the signed-in role, not from a flag on a
/// user record. Reception physically cannot navigate to revenue, because the
/// destination is never built — defence in depth behind the Policy Decision
/// Point, which would refuse the command anyway.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../platform/identity/identity.dart';
import '../../platform/tenancy/tenancy.dart';
import '../dashboards/money_page.dart';
import '../dashboards/ops_page.dart';
import '../dashboards/overview_page.dart';
import '../dashboards/parent_dashboard.dart';
import '../dashboards/reception_desk.dart';
import '../dashboards/seat_map_page.dart';
import '../dashboards/student_dashboard.dart';
import '../dashboards/students_page.dart';
import '../session.dart';
import '../theme.dart';

final class _Dest {
  const _Dest(this.icon, this.selectedIcon, this.label, this.page);
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final Widget page;
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  List<_Dest> _destinationsFor(AccessRole role) {
    switch (role) {
      case AccessRole.owner:
        return const [
          _Dest(
            Icons.insights_outlined,
            Icons.insights,
            'Overview',
            OverviewPage(),
          ),
          _Dest(Icons.people_outline, Icons.people, 'Students', StudentsPage()),
          _Dest(
            Icons.grid_view_outlined,
            Icons.grid_view,
            'Seats',
            SeatMapPage(),
          ),
          _Dest(Icons.payments_outlined, Icons.payments, 'Money', MoneyPage()),
          _Dest(Icons.tune_outlined, Icons.tune, 'Ops', OpsPage()),
        ];
      case AccessRole.manager:
        return const [
          _Dest(
            Icons.insights_outlined,
            Icons.insights,
            'Overview',
            OverviewPage(),
          ),
          _Dest(Icons.people_outline, Icons.people, 'Students', StudentsPage()),
          _Dest(
            Icons.grid_view_outlined,
            Icons.grid_view,
            'Seats',
            SeatMapPage(),
          ),
          _Dest(Icons.payments_outlined, Icons.payments, 'Money', MoneyPage()),
        ];
      case AccessRole.reception:
        return const [
          _Dest(
            Icons.how_to_reg_outlined,
            Icons.how_to_reg,
            'Desk',
            ReceptionDesk(),
          ),
          _Dest(Icons.people_outline, Icons.people, 'Students', StudentsPage()),
          _Dest(
            Icons.grid_view_outlined,
            Icons.grid_view,
            'Seats',
            SeatMapPage(),
          ),
        ];
      case AccessRole.student:
        return const [
          _Dest(Icons.today_outlined, Icons.today, 'Today', StudentTodayPage()),
          _Dest(
            Icons.card_membership_outlined,
            Icons.card_membership,
            'Plan',
            StudentPlanPage(),
          ),
          _Dest(
            Icons.receipt_long_outlined,
            Icons.receipt_long,
            'Fees',
            StudentFeesPage(),
          ),
        ];
      case AccessRole.parent:
        return const [
          _Dest(
            Icons.family_restroom_outlined,
            Icons.family_restroom,
            'Child',
            ParentOverviewPage(),
          ),
          _Dest(
            Icons.event_available_outlined,
            Icons.event_available,
            'Attendance',
            ParentAttendancePage(),
          ),
          _Dest(
            Icons.receipt_long_outlined,
            Icons.receipt_long,
            'Fees',
            StudentFeesPage(),
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SessionController>();
    final dests = _destinationsFor(s.role);
    final index = _index.clamp(0, dests.length - 1);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: LiblSpace.lg,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(s.tenant.name, style: const TextStyle(fontSize: 15.5)),
            Text(
              '${s.branchInfo.name} · ${s.role.label}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        actions: [
          if (!s.container.sync.online)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: IconButton(
                tooltip: 'Offline — mutations are queued',
                icon: const Icon(Icons.cloud_off, color: LiblColors.accent),
                onPressed: () => _showBranchAndAccount(context, s),
              ),
            ),
          _AccountButton(session: s),
          const SizedBox(width: LiblSpace.sm),
        ],
      ),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: index,
          children: [for (final d in dests) d.page],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          for (final d in dests)
            NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.selectedIcon, color: LiblColors.brand),
              label: d.label,
            ),
        ],
      ),
    );
  }

  void _showBranchAndAccount(BuildContext context, SessionController s) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => _AccountSheet(session: s),
    );
  }
}

class _AccountButton extends StatelessWidget {
  const _AccountButton({required this.session});
  final SessionController session;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => showModalBottomSheet<void>(
        context: context,
        builder: (_) => _AccountSheet(session: session),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Text(
            (session.account?.displayName ?? '?').substring(0, 1).toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _AccountSheet extends StatelessWidget {
  const _AccountSheet({required this.session});
  final SessionController session;

  @override
  Widget build(BuildContext context) {
    final s = session;
    final canSwitchBranch =
        s.role == AccessRole.owner || s.role == AccessRole.manager;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(LiblSpace.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: LiblColors.brand.withValues(alpha: 0.12),
                child: Text(
                  (s.account?.displayName ?? '?').substring(0, 1),
                  style: const TextStyle(
                    color: LiblColors.brand,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              title: Text(
                s.account?.displayName ?? '—',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text('+91 ${s.account?.phone ?? ''} · ${s.role.label}'),
            ),
            const Divider(height: LiblSpace.xl),
            if (canSwitchBranch) ...[
              const Text(
                'BRANCH',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.7,
                  color: LiblColors.textMuted,
                ),
              ),
              const SizedBox(height: LiblSpace.sm),
              for (final Branch b in s.tenant.branches)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: Icon(
                    b.id == s.branch
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    size: 20,
                    color: b.id == s.branch
                        ? LiblColors.brand
                        : LiblColors.textMuted,
                  ),
                  title: Text(b.name, style: const TextStyle(fontSize: 14)),
                  subtitle: Text(
                    b.address,
                    style: const TextStyle(fontSize: 11.5),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    s.switchBranch(b.id);
                    Navigator.of(context).pop();
                  },
                ),
              const Divider(height: LiblSpace.xl),
            ],
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              value: !s.container.sync.online,
              title: const Text(
                'Simulate offline',
                style: TextStyle(fontSize: 14),
              ),
              subtitle: Text(
                s.container.sync.online
                    ? 'Mutations commit immediately'
                    : '${s.container.sync.pendingCount} queued for replay',
                style: const TextStyle(fontSize: 11.5),
              ),
              onChanged: (_) => s.toggleOffline(),
            ),
            const SizedBox(height: LiblSpace.sm),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                s.signOut();
              },
              icon: const Icon(Icons.logout, size: 18),
              label: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
