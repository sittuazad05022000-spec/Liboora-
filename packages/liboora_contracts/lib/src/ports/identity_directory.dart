/// Liboora Shared Kernel (R0) — the `E-13` identity directory port.
///
/// Declared here (rank 0) because the manifest forbids `domain/library` from
/// importing `domain/person` (`ADR-0011`: *reach it by PORT, never by
/// import*). `domain/person` implements this interface; `BC-01` consumes it
/// through the rank-0 contracts barrel, the same inversion pattern as
/// [PersonIdentityFactory].
library;

import '../value_objects/identifiers.dart';

/// The `E-13` **Anti-Corruption Layer port**, consumed by `domain/library`.
///
/// Named with the `*Port` suffix per the wave-4 contracts convention
/// (`StudentDirectoryPort`, `AccountDirectoryPort`, …). Deliberately narrower
/// than the aggregate: it exposes only the core fields a library legitimately
/// needs for a `PersonId` a Student Record *already holds* (`SPO-9`). It
/// offers no listing, no search, and no way to ask which organisations a
/// person attends (`SID-4.19`).
///
/// `BC-01` never receives `domain/person`'s aggregate types, and that module
/// never receives `BC-01`'s (`SID-4.18`).
abstract interface class IdentityDirectoryPort {
  /// Non-mutating resolution of display fields. Returns null when no identity
  /// exists for [id], which callers must treat as "not resolvable", never as
  /// grounds to create one.
  IdentityCoreFields? resolve(PersonId id);
}

/// The flat, translated projection crossing the `E-13` ACL. Carries no
/// aggregate, no status history and no reference back into the identity
/// module.
final class IdentityCoreFields {
  const IdentityCoreFields({
    required this.personId,
    required this.displayName,
    required this.isActive,
    this.dateOfBirth,
  });

  final PersonId personId;
  final String displayName;
  final bool isActive;

  /// `ADR-0179` — the DOB as owned by BC-10, read through the `E-13` ACL
  /// (`PRD-004` `SM-4.5`: age derives from here, never from a stored copy).
  /// `null` is an explicit "absent/unknown" result (`SM-4.5a`), never a
  /// default age.
  final DateTime? dateOfBirth;
}
