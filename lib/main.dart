/// Liboora — entry point.
///
/// Composition happens before the first frame, and a boot failure is rendered
/// rather than swallowed: if an invariant in the seeder throws, that is a real
/// architectural regression and it should be impossible to miss.
library;

import 'package:flutter/material.dart';

import 'app/liboora_app.dart';
import 'bootstrap/di.dart';
import 'bootstrap/seed.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const BootScreen());

  try {
    // The composition root is the one place allowed to know both the wiring and
    // the demo seeder; injecting it here is what keeps `di.dart` free of a
    // dependency back on `seed.dart` (law L1 — see AppContainer.boot).
    final container = await AppContainer.boot(seeder: seedDemoData);
    runApp(LiboraaApp(container: container));
  } catch (error, stack) {
    debugPrint('Liboora boot failed: $error\n$stack');
    runApp(BootScreen(error: error));
  }
}
