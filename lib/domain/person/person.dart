/// **BC-10 Global Person Identity — `[CORE]`, rank 7.5.**
///
/// The permanent identity of a human on the LIBOORA platform. Created in the
/// same transaction as the Account, `1:1` with it, and owned by the platform —
/// never by a library, and never by the social product (`ADR-0011`).
///
/// **What this module is not.** It was previously modelled as an opt-in social
/// persona living inside `domain/social`. `ADR-0011` rejected that: identity is
/// infrastructure for the whole education ecosystem, so it was moved here and
/// reclassified `[CORE]`. The falsifiable consequence is `SID-4.31` —
/// *deactivating, disabling or never launching the social product shall not
/// affect the existence, validity or usability of any Global Person Identity*.
/// Nothing in this file imports, mentions or requires `domain/social`.
///
/// **Rank 7.5 exists for one reason.** A `StudentRecord` in `domain/library`
/// (rank 8) holds a non-nullable `PersonId`. Rank 8 → 7.5 is strictly
/// downward, so law **L2** is satisfied literally and no cluster exception was
/// needed. Had this stayed at rank 8 it would have been a same-rank
/// cross-cluster dependency — forbidden.
///
/// **What this module must never be able to do.** It holds no `StudentRecordId`
/// and no `TenantId`, so it *cannot* answer "which libraries does this person
/// attend?" — that is a structural guarantee, not a policy (`SID-4.19`,
/// `SID-INV-6`, `SID-INV-8`). It holds no mobile number, because in a system
/// whose sole authentication factor is a mobile number, that field is a
/// credential and belongs only to `BC-18` (`ID-1`, `SID-4.13`, `SID-INV-5`).
library;

import 'package:liboora_contracts/liboora_contracts.dart';

/// The lifecycle status of an identity.
///
/// Status is the **only** thing a Platform Administrator may change (`SPO-8`);
/// profile *content* is never administratively editable (`SID-3.32`).
enum PersonIdentityStatus { active, suspended, archived, anonymised }

/// The Global Person Identity aggregate.
///
/// There is exactly **one** identity aggregate in this system. Any change that
/// would require a second one must be rejected (`SID-5.51`).
final class PersonIdentity {
  PersonIdentity({
    required this.personId,
    required this.accountId,
    required this.createdAt,
    required this.displayName,
    this.headline = '',
    this.examTrack = '',
    this.avatarRef,
    this.status = PersonIdentityStatus.active,
    this.dateOfBirth,
  }) {
    _assertInvariants();
  }

  /// Immutable for the lifetime of the identity and never reused — including
  /// after archival or anonymisation (`SID-INV-3`).
  final PersonId personId;

  /// The account this identity is `1:1` with (`SID-INV-1`). Held so the
  /// uniqueness constraint is expressible; it is not a credential.
  final AccountId accountId;

  /// `SID-3.7` — creation timestamp is recorded.
  final DateTime createdAt;

  String displayName;

  /// "CSE 3rd year · targeting GATE 2027"
  String headline;

  /// The exam a person is preparing for — the social product's primary
  /// grouping dimension, and meaningless inside the library domain.
  String examTrack;

  /// A `FileRef` only. Never bytes, never a raw storage path, never a URL.
  FileRef? avatarRef;

  /// The person's date of birth — **nullable, and never inferred**
  /// (`ADR-0179`, Option C: BC-10 is the authoritative DOB owner per
  /// `PRD-004` `SM-4.2`/`SM-4.5`; `SID-2.5` keeps it optional). Historical
  /// identities recorded before Option C hold `null` — that is an honest
  /// "unrecorded", never backfilled by guesswork.
  DateTime? dateOfBirth;

  PersonIdentityStatus status;

  /// Aggregated across every library the person has ever attended, from
  /// published attendance events — never by querying a tenant's tables.
  int lifetimeStudyMinutes = 0;

  Duration get lifetimeStudyTime => Duration(minutes: lifetimeStudyMinutes);

  void _assertInvariants() {
    if (!personId.isValid) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'A Global Person Identity requires a valid PersonId.',
      );
    }
    if (!accountId.isValid) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'A Global Person Identity requires the AccountId it belongs to.',
      );
    }
    // SID-3.9: partial profiles are never persisted.
    if (displayName.trim().isEmpty) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'A Global Person Identity requires a display name.',
      );
    }
    // ADR-0179: a DOB, when present, must be a real past date. A future DOB
    // is invalid input, never "a person not yet born".
    final dob = dateOfBirth;
    if (dob != null && dob.isAfter(DateTime.now())) {
      throw const DomainError(
        DomainErrorCode.validationFailed,
        'A date of birth cannot be in the future.',
      );
    }
  }

  /// `ID-5` / `SEV-16` — erasure anonymises the person here. It deliberately
  /// does **not** delete any `StudentRecord` financial or attendance history,
  /// which a library retains under legal basis. This asymmetry is the
  /// load-bearing reason the identity split is kept at all.
  void anonymise() {
    displayName = 'Removed user';
    headline = '';
    examTrack = '';
    avatarRef = null;
    // ADR-0179: the DOB is personal data owned here; erasure clears it
    // together with the rest of the profile content.
    dateOfBirth = null;
    status = PersonIdentityStatus.anonymised;
  }
}

/// Port declared BY this context (law L3). The adapter is wired at the
/// composition root.
abstract interface class PersonIdentityRepository {
  PersonIdentity? byPersonId(PersonId id);
  PersonIdentity? byAccountId(AccountId id);
  void save(PersonIdentity identity);
  int get count;
}

/// The `E-13` **Anti-Corruption Layer**, consumed by `domain/library`.
///
/// Deliberately narrower than the aggregate: it exposes only the core fields a
/// library legitimately needs for a `PersonId` a Student Record *already
/// holds* (`SPO-9`). It offers no listing, no search, and no way to ask which
/// organisations a person attends (`SID-4.19`).
///
/// `BC-01` never receives this module's domain types, and this module never
/// receives `BC-01`'s (`SID-4.18`).
abstract interface class IdentityDirectory {
  /// Non-mutating resolution of display fields. Returns null when no identity
  /// exists for [id], which callers must treat as "not resolvable", never as
  /// grounds to create one.
  IdentityCoreFields? resolve(PersonId id);
}

/// The flat, translated projection crossing the `E-13` ACL. Carries no
/// aggregate, no status history and no reference back into this module.
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

final class InMemoryPersonIdentityRepository
    implements PersonIdentityRepository, IdentityDirectory {
  InMemoryPersonIdentityRepository({DurableKeyValueStore? durable})
    : _durable = durable;

  final DurableKeyValueStore? _durable;

  /// Durable namespace for the global identity directory. Identity is global
  /// (`SID-4.49` — no tenant key), so keys are bare person ids, never
  /// tenant-scoped. Follows the `AccountStore` precedent.
  static const String durableNamespace = 'person_identities';

  final Map<String, PersonIdentity> _byPerson = {};
  final Map<String, PersonId> _accountIndex = {};

  @override
  PersonIdentity? byPersonId(PersonId id) => _byPerson[id.value];

  @override
  PersonIdentity? byAccountId(AccountId id) {
    final personId = _accountIndex[id.value];
    return personId == null ? null : _byPerson[personId.value];
  }

  @override
  void save(PersonIdentity identity) {
    // SID-INV-1: never two identities for one account. Enforced here because
    // "a rule that cannot be checked shall be treated as unmet" (SID-4.56).
    final existing = _accountIndex[identity.accountId.value];
    if (existing != null && existing != identity.personId) {
      throw DomainError(
        DomainErrorCode.conflict,
        'Account ${identity.accountId.value} already has a Global Person '
        'Identity. An account has exactly one, never two.',
        context: {'accountId': identity.accountId.value},
      );
    }
    _byPerson[identity.personId.value] = identity;
    _accountIndex[identity.accountId.value] = identity.personId;
    // ADR-0179 — write-through, so the identity (and its owned DOB) survives
    // restart. Identities were in-memory-only before Option C, which is why
    // restored accounts could point at vanished identities; this closes it.
    _durable?.write(
      durableNamespace,
      identity.personId.value,
      encodePersonIdentity(identity),
    );
  }

  @override
  int get count => _byPerson.length;

  /// Restores every persisted identity. Called once at boot, before the
  /// account directory is validated against it (`di.dart` ordering). A row
  /// that cannot be decoded is **skipped, not guessed** — the same semantics
  /// as `TenantPartitionedStore.restore`.
  int restoreAll() {
    final durable = _durable;
    if (durable == null) return 0;
    var restored = 0;
    for (final entry in durable.readAll(durableNamespace).entries) {
      try {
        final identity = decodePersonIdentity(entry.value);
        _byPerson[identity.personId.value] = identity;
        _accountIndex[identity.accountId.value] = identity.personId;
        restored++;
      } catch (_) {
        continue; // Skip the unreadable row; never fabricate one.
      }
    }
    return restored;
  }

  @override
  IdentityCoreFields? resolve(PersonId id) {
    final identity = _byPerson[id.value];
    if (identity == null) return null;
    return IdentityCoreFields(
      personId: identity.personId,
      displayName: identity.displayName,
      isActive: identity.status == PersonIdentityStatus.active,
      dateOfBirth: identity.dateOfBirth,
    );
  }
}

/// The `SPO-1` creation service: *system only, atomically with account
/// creation*. No human actor may invoke this directly (`SID-4.11`).
///
/// This implements the rank-0 [PersonIdentityFactory] port so that `BC-18`
/// (rank 4) can trigger creation without depending upward on rank 7.5.
final class PersonIdentityService implements PersonIdentityFactory {
  PersonIdentityService({
    required PersonIdentityRepository repository,
    required Clock clock,
    required IdGenerator ids,
  }) : _repository = repository,
       _clock = clock,
       _ids = ids;

  final PersonIdentityRepository _repository;
  final Clock _clock;
  final IdGenerator _ids;

  @override
  PersonId createFor({
    required AccountId account,
    required String displayName,
  }) {
    // Idempotent by identity, not by accident: if this account already has an
    // identity, return it rather than minting a second one (SID-INV-1).
    final existing = _repository.byAccountId(account);
    if (existing != null) return existing.personId;

    // SID-3.5 — generated here, never supplied by a caller.
    final identity = PersonIdentity(
      personId: PersonId(_ids.next('per')),
      accountId: account,
      createdAt: _clock.now(),
      displayName: displayName,
    );
    _repository.save(identity);
    return identity.personId;
  }

  /// `ADR-0179` — records a date of birth against the identity. **BC-10 is
  /// the DOB owner**; this is the only sanctioned write path besides the boot
  /// migration. Callers are system-driven (the composition root's enrollment
  /// provisioning), with the acting staff member recorded as [recordedBy].
  ///
  /// Rules:
  ///  - the identity must exist — no identity is created here (`SPO-1`);
  ///  - a **different** DOB than the one already recorded is a conflict,
  ///    never a silent overwrite;
  ///  - the **same** DOB is a no-op, so provisioning replay stays idempotent;
  ///  - a future date is invalid input (`PersonIdentity` invariant).
  void recordDateOfBirth({
    required PersonId personId,
    required DateTime dateOfBirth,
    required String recordedBy,
  }) {
    final identity = _repository.byPersonId(personId);
    if (identity == null) {
      throw DomainError(
        DomainErrorCode.notFound,
        'No identity exists for ${personId.value}; a DOB cannot be recorded.',
        context: {'personId': personId.value},
      );
    }
    final existing = identity.dateOfBirth;
    if (existing != null) {
      if (_sameDay(existing, dateOfBirth)) return; // Idempotent replay.
      throw DomainError(
        DomainErrorCode.conflict,
        'Identity ${personId.value} already has a date of birth; a different '
        'one cannot be recorded over it.',
        context: {
          'personId': personId.value,
          'recordedBy': recordedBy,
        },
      );
    }
    identity.dateOfBirth = dateOfBirth;
    _repository.save(identity);
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
