/// Application root and **composition root for the app boundaries**.
///
/// While Liboora ships as one binary, this file is the single place that
/// selects which app boundary a signed-in session belongs to. It is
/// deliberately the *only* such place, and it is deliberately thin.
///
/// ⭐ **What it does:** maps a signed-in role to exactly one boundary shell.
/// ⛔ **What it does not do:** hold navigation, destinations, dashboards or
/// presentation state for any boundary. Those live inside the boundary that
/// owns them, because that is the code a future extracted app takes with it.
///
/// **The future extraction.** Each of `liboora-student-app`,
/// `liboora-staff-app` and `liboora-platform-admin` replaces [_BoundaryGate]
/// with a direct reference to its own shell and drops the other boundaries
/// from its build. Nothing in `platform/`, `domain/`, `bootstrap/` or
/// `packages/liboora_contracts` changes — which is the whole objective.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bootstrap/di.dart';
import '../platform/identity/identity.dart';
import 'shared/login_screen.dart';
import 'shared/session.dart';
import 'shared/theme.dart';
import 'staff/staff_app_shell.dart';
import 'student/student_app_shell.dart';

class LiboraaApp extends StatelessWidget {
  const LiboraaApp({super.key, required this.container});

  final AppContainer container;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SessionController>(
      create: (_) => SessionController(container),
      child: MaterialApp(
        title: 'Liboora',
        debugShowCheckedModeBanner: false,
        theme: buildLiblTheme(),
        home: const _Gate(),
      ),
    );
  }
}

class _Gate extends StatelessWidget {
  const _Gate();

  @override
  Widget build(BuildContext context) {
    final signedIn = context.select<SessionController, bool>(
      (s) => s.isSignedIn,
    );
    return signedIn ? const _BoundaryGate() : const LoginScreen();
  }
}

/// Routes a signed-in session to the one app boundary that owns its role.
///
/// This is the composition-root dispatch the target architecture calls for. It
/// is a **two-line-per-boundary mapping and nothing else** — the anti-pattern
/// it replaces was a single shell that held all five roles' navigation sets,
/// which made a per-app build impossible.
///
/// ⛔ **`AccessRole` carries TENANT roles only** (`PRD-001` §2.4: `TR-1`…`TR-5`).
/// The platform roles `PR-1` Platform Administrator and `PR-2` Platform Support
/// are a **separate closed set** (`PRD-001` §2.3) and are **not** represented
/// in this enum, so no platform boundary can be dispatched to yet. That is
/// correct and intentional: see `app/platform_admin/README.md` §3 for the
/// governance decision that is required first, and which this code does not
/// pre-empt.
class _BoundaryGate extends StatelessWidget {
  const _BoundaryGate();

  @override
  Widget build(BuildContext context) {
    final role = context.select<SessionController, AccessRole>((s) => s.role);

    // Exhaustive over AccessRole with no `default`: if a role is ever added to
    // the enum, this switch fails to compile and forces a deliberate decision
    // about which boundary owns it, rather than silently defaulting it into a
    // customer or staff app.
    switch (role) {
      case AccessRole.student:
      case AccessRole.parent:
        return const StudentAppShell();
      case AccessRole.owner:
      case AccessRole.manager:
      case AccessRole.reception:
        return const StaffAppShell();
    }
  }
}

/// Shown while the container boots and seeds.
class BootScreen extends StatelessWidget {
  const BootScreen({super.key, this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildLiblTheme(),
      home: Scaffold(
        backgroundColor: LiblColors.brand,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(LiblSpace.xxl),
            child: error == null
                ? const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Liboora',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: LiblSpace.xl),
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(height: LiblSpace.lg),
                      const Text(
                        'Liboora could not start',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: LiblSpace.sm),
                      Text(
                        '$error',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
