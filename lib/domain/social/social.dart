/// **Social domain (BC-11 graph · BC-12 messaging · BC-13 safety) — rank 8.**
///
/// This is a *stub that exists to hold a boundary open*, not a half-built
/// feature. The relationship between the Library domain and the Social domain
/// is **Separate Ways** (`X-05`): they share no database, no aggregate and no
/// model.
///
/// **What changed, and why it matters.** This file previously *owned* the
/// global identity as `GlobalStudentProfile`. `ADR-0011` rejected that model:
/// identity is permanent platform infrastructure, not a social feature. The
/// aggregate moved to `lib/domain/person/` (`BC-10`, rank 7.5) and this module
/// became a **consumer** of it. The test of whether that move is real is
/// `SID-4.31` — disabling or never launching the social product must not affect
/// any Global Person Identity. That holds only because nothing in
/// `domain/person` refers to anything here.
///
/// **How this module learns about people.** By keying on `PersonId` (`ID-3`)
/// and consuming `identity.Person*` events. It may **not** import
/// `domain/person`: rank 8 cannot import rank 7.5's internals, and the shared
/// vocabulary it needs (`PersonId`) lives in the shared kernel instead.
///
/// Two prohibitions remain absolute:
///
///   * Nothing in `lib/domain/library/` may import this file, and nothing here
///     may import a library context (`X-05`).
///   * No `StudentRecordId` and no `TenantId` may ever enter this module
///     (`ID-2`) — social data is not tenant-scoped.
///
/// If a future feature needs library data on a social screen, it travels as a
/// published event or through a BFF query — never as a Dart import.
///
/// **`BC-12` enforcement (`IMPL-1410`).** `messaging/enforcement_projection.dart`
/// holds `BC-12`'s local enforcement read model and its fail-closed send-time
/// staleness gate, per `ADR-0065` §7.1. It is fed only by the existing `E-14`
/// `safety.EnforcementActionTaken` event and creates **no** `BC-12` → `BC-13`
/// edge. Exported here because cross-module imports must target this barrel.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

export 'messaging/enforcement_projection.dart';

/// A person's presence in the social graph, keyed on `PersonId` (`ID-3`).
///
/// Deliberately holds **no** name, photo or headline: those belong to the
/// identity (`BC-10`) and duplicating them here would reintroduce exactly the
/// duplication `SID-BR-11` forbids. Social contexts render identity fields by
/// resolving them, never by storing a copy (`SID-4.53`).
final class SocialPresence {
  SocialPresence({required this.personId});

  final PersonId personId;

  /// Aggregated from published attendance events, never by querying a tenant's
  /// tables. A projection, not a source of truth.
  int lifetimeStudyMinutes = 0;

  Duration get lifetimeStudyTime => Duration(minutes: lifetimeStudyMinutes);
}

/// Port declared BY this context (law L3).
abstract interface class SocialPresenceReader {
  SocialPresence? byPersonId(PersonId id);
}

final class InMemorySocialPresenceRepository implements SocialPresenceReader {
  final Map<String, SocialPresence> _presences = {};

  @override
  SocialPresence? byPersonId(PersonId id) => _presences[id.value];

  void save(SocialPresence p) => _presences[p.personId.value] = p;

  int get count => _presences.length;
}
