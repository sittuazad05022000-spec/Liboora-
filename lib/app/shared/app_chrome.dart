/// Role-neutral presentation chrome, shared by every app boundary.
///
/// **Why this file exists.** Before the app-boundary split, one `HomeShell`
/// held the navigation set for all five tenant roles *and* the app bar, the
/// account sheet and the branch switcher. That single file was the thing that
/// made three separate apps impossible to extract: a student build could not
/// be produced without compiling reception's desk and the owner's revenue
/// destinations.
///
/// The split separates two genuinely different concerns:
///
///  * **What is navigable** — boundary-specific. It lives with the boundary
///    that owns it (`app/student`, `app/staff`, `app/platform_admin`), because
///    that is exactly the code a future extracted app would take with it.
///  * **What the frame looks like** — role-neutral, and lives here.
///
/// ⛔ **Nothing in this file may branch on a role.** A `switch` on
/// `AccessRole` here would silently rebuild the monolith this split exists to
/// dissolve, and the architecture test
/// `test/architecture/app_boundary_test.dart` fails the build if one appears.
/// Behaviour that legitimately differs by role is passed *in* as data — see
/// [AppDestination] and [showBranchSwitcher] — never decided here.
library;

import 'package:flutter/material.dart';

import 'theme.dart';

/// One navigable destination in a boundary's navigation set.
///
/// Boundaries construct these; this file only renders them. That inversion is
/// what keeps the chrome role-neutral: the frame never learns which role it is
/// drawing for.
final class AppDestination {
  const AppDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.page,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final Widget page;
}

/// The shared scaffold: app bar, indexed body, bottom navigation.
///
/// Every parameter that could vary by role is supplied by the caller, so the
/// widget itself holds no role knowledge and no role-dependent branch.
class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
    required this.destinations,
    required this.title,
    required this.subtitle,
    required this.accountInitial,
    required this.onAccountTap,
    this.trailing = const [],
  });

  /// The boundary's navigation set. Must be non-empty.
  final List<AppDestination> destinations;

  /// Primary app-bar line — the tenant name for tenant-scoped boundaries.
  final String title;

  /// Secondary app-bar line, e.g. branch and role label.
  final String subtitle;

  /// Single character shown in the account avatar.
  final String accountInitial;

  /// Opens the boundary's own account surface. The chrome does not know, and
  /// must not know, what that surface contains.
  final VoidCallback onAccountTap;

  /// Extra app-bar actions a boundary needs (offline indicator, etc.).
  final List<Widget> trailing;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final dests = widget.destinations;
    // Clamped rather than asserted: a boundary may legitimately shorten its
    // navigation set at runtime, and losing a tab must not crash the frame.
    final index = _index.clamp(0, dests.length - 1);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: LiblSpace.lg,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title, style: const TextStyle(fontSize: 15.5)),
            Text(
              widget.subtitle,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        actions: [
          ...widget.trailing,
          AccountAvatarButton(
            initial: widget.accountInitial,
            onTap: widget.onAccountTap,
          ),
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
}

/// The circular account button in the app bar.
class AccountAvatarButton extends StatelessWidget {
  const AccountAvatarButton({
    super.key,
    required this.initial,
    required this.onTap,
  });

  final String initial;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
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
            initial,
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

/// A branch row for an account sheet.
///
/// Whether a boundary offers branch switching at all is the boundary's
/// decision — `showBranchSwitcher` is passed by the caller. Rendering a row is
/// this file's.
class BranchOptionTile extends StatelessWidget {
  const BranchOptionTile({
    super.key,
    required this.name,
    required this.address,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final String address;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        size: 20,
        color: selected ? LiblColors.brand : LiblColors.textMuted,
      ),
      title: Text(name, style: const TextStyle(fontSize: 14)),
      subtitle: Text(
        address,
        style: const TextStyle(fontSize: 11.5),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}

/// Small uppercase section label used inside account sheets.
class SheetSectionLabel extends StatelessWidget {
  const SheetSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.7,
        color: LiblColors.textMuted,
      ),
    );
  }
}
