/// **Liboora Shared Kernel — R0**
///
/// Law L5: this package imports NOTHING. No Flutter, no third-party packages,
/// no `dart:io`, no `dart:ui`. It must compile in a pure-Dart server context
/// so the outbox publisher, migration tooling and test fixtures can all share
/// one definition of the domain language.
///
/// Enforced by the compiler (empty `dependencies:` in pubspec) rather than by
/// a lint rule that can be suppressed.
library;

// ── Value objects ────────────────────────────────────────────
export 'src/value_objects/identifiers.dart';
export 'src/value_objects/money.dart';
export 'src/value_objects/date_range.dart';

// ── Errors ───────────────────────────────────────────────────
export 'src/errors/domain_error.dart';

// ── Events ───────────────────────────────────────────────────
export 'src/events/domain_event.dart';

// ── Universal ports ──────────────────────────────────────────
export 'src/ports/clock.dart';
export 'src/ports/id_generator.dart';
export 'src/ports/random_source.dart';
export 'src/ports/telemetry.dart';
export 'src/ports/tenant_context.dart';
