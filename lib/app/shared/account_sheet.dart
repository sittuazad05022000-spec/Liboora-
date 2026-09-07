/// Role-neutral account sheet.
///
/// Identity, offline simulation and sign-out are the same act for every role,
/// so they are shared. Branch switching is *not* the same for every role — it
/// is an owner/manager capability — so this widget does not decide it. The
/// caller passes [showBranchSwitcher], and the boundary that owns the roles
/// decides its value.
///
/// ⛔ No role branch may appear here. See `app_chrome.dart` for why, and
/// `test/architecture/app_boundary_test.dart` for the check that enforces it.
library;

import 'package:flutter/material.dart';

import 'app_chrome.dart';
import 'session.dart';
import 'theme.dart';

class AccountSheet extends StatelessWidget {
  const AccountSheet({
    super.key,
    required this.session,
    required this.showBranchSwitcher,
  });

  final SessionController session;

  /// Supplied by the boundary. This widget never derives it from a role.
  final bool showBranchSwitcher;

  @override
  Widget build(BuildContext context) {
    final s = session;

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
            if (showBranchSwitcher) ...[
              const SheetSectionLabel('BRANCH'),
              const SizedBox(height: LiblSpace.sm),
              for (final b in s.tenant.branches)
                BranchOptionTile(
                  name: b.name,
                  address: b.address,
                  selected: b.id == s.branch,
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

/// The offline indicator, shown by a boundary that wants it in its app bar.
class OfflineIndicator extends StatelessWidget {
  const OfflineIndicator({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: IconButton(
        tooltip: 'Offline — mutations are queued',
        icon: const Icon(Icons.cloud_off, color: LiblColors.accent),
        onPressed: onTap,
      ),
    );
  }
}
