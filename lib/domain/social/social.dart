/// **Social domain (BC-10 Global Student Profile) — Separate Ways.**
///
/// This is a *stub that exists to hold a boundary open*, not a half-built
/// feature. The relationship between the Library domain and the Social domain
/// is **Separate Ways**: they share no database, no aggregate and no model.
///
/// The one permitted link is edge **E-13**, and it is deliberately narrow:
///
///   * A `StudentRecord` (BC-01) may carry a nullable `PersonId`.
///   * That link is created only by explicit student consent.
///   * Nothing in `lib/domain/library/` may `import` this file.
///   * Nothing here may import a library context.
///
/// If a future feature needs library data on a social screen, it travels as a
/// published event or through a BFF query — never as a Dart import. Losing
/// this boundary is how a "study-hall app" turns into a monolith that cannot
/// ship a social feature without a fee-module regression.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

/// Cross-tenant by design — the exact inverse of everything in the library
/// domain. A person's identity does not belong to whichever library they
/// happened to join.
final class GlobalStudentProfile {
  GlobalStudentProfile({
    required this.personId,
    required this.displayName,
    this.headline = '',
    this.examTrack = '',
    this.avatarRef,
  });

  final PersonId personId;
  String displayName;

  /// "CSE 3rd year · targeting GATE 2027"
  String headline;

  /// The exam a student is preparing for. The Social product's primary
  /// grouping dimension — and meaningless inside the library domain.
  String examTrack;

  FileRef? avatarRef;

  /// Aggregated across every library the person has ever attended. Computed
  /// from published attendance events, never by querying a tenant's tables.
  int lifetimeStudyMinutes = 0;

  Duration get lifetimeStudyTime => Duration(minutes: lifetimeStudyMinutes);
}

/// Placeholder port. Deliberately unimplemented in V1 — the interface is here
/// so the boundary is visible in code review long before the feature ships.
abstract interface class GlobalProfileReader {
  GlobalStudentProfile? byPersonId(PersonId id);
}

final class InMemoryGlobalProfileRepository implements GlobalProfileReader {
  final Map<String, GlobalStudentProfile> _profiles = {};

  @override
  GlobalStudentProfile? byPersonId(PersonId id) => _profiles[id.value];

  void save(GlobalStudentProfile p) => _profiles[p.personId.value] = p;

  int get count => _profiles.length;
}
