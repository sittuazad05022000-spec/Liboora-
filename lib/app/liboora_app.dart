/// Application root.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bootstrap/di.dart';
import 'session.dart';
import 'shell/home_shell.dart';
import 'shell/login_screen.dart';
import 'theme.dart';

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
    return signedIn ? const HomeShell() : const LoginScreen();
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
