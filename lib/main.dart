/// Liboora — entry point.
///
/// Composition happens before the first frame, and a boot failure is rendered
/// rather than swallowed: if an invariant in the seeder throws, that is a real
/// architectural regression and it should be impossible to miss.
library;

import 'package:flutter/material.dart';

import 'app/liboora_app.dart';
import 'bootstrap/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const BootScreen());

  try {
    final container = await AppContainer.boot();
    runApp(LiboraaApp(container: container));
  } catch (error, stack) {
    debugPrint('Liboora boot failed: $error\n$stack');
    runApp(BootScreen(error: error));
  }
}
