/// Liboora — entry point.
///
/// Composition happens before the first frame, and a boot failure is rendered
/// rather than swallowed: if an invariant in the seeder throws, that is a real
/// architectural regression and it should be impossible to miss.
library;

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/liboora_app.dart';
import 'bootstrap/di.dart';
import 'bootstrap/seed.dart';
import 'platform/data/data.dart';

/// The application's durable box. One box, opened once — see [HiveKeyValueStore].
const String _boxName = 'liboora_v1';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const BootScreen());

  try {
    // Hive must be initialised before a box can be opened. On web this falls
    // through to IndexedDB; on Android it resolves the documents directory.
    await Hive.initFlutter();

    // Opening the box is the only asynchronous part of persistence.
    // Everything after it is synchronous, which is what keeps `Future` out of
    // the domain signatures (law L3) — see the DurableKeyValueStore port.
    //
    // The adapter is chosen inside `di.dart`, not here: the composition root
    // is the only place allowed to know both a port and its adapter, and
    // constructing one in this file would leave the port looking unwired.
    // This call says only *that* durability is wanted, and under which box.
    final durable = await AppContainer.openDurableStore(_boxName);

    // The composition root is the one place allowed to know both the wiring and
    // the demo seeder; injecting it here is what keeps `di.dart` free of a
    // dependency back on `seed.dart` (law L1 — see AppContainer.boot).
    //
    // The seeder is still passed unconditionally. `boot` runs it only when
    // restore found nothing, so a returning user's data is never overwritten
    // while a first-time user still gets a populated library.
    final container = await AppContainer.boot(
      seeder: seedDemoData,
      durable: durable,
    );
    runApp(LiboraaApp(container: container));
  } catch (error, stack) {
    debugPrint('Liboora boot failed: $error\n$stack');
    runApp(BootScreen(error: error));
  }
}
