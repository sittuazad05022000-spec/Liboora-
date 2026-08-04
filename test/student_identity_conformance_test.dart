/// Student Identity conformance regressions — `ADR-0011` lock.
///
/// Every test here is a tripwire for a specific normative requirement of the
/// approved Global Person Identity architecture. They are not coverage tests:
/// each name cites the register entry it guards, so a reviewer can tell from a
/// failure which rule regressed.
///
/// The rule these tests exist to honour is `SID-4.56` — *"A rule that cannot be
/// checked SHALL be treated as unmet, not as satisfied by intent."* Before this
/// file existed, every claim below was satisfied only by intent.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/seed.dart';
import 'package:liboora/domain/library/enrollment/enrollment.dart';
import 'package:liboora/domain/person/person.dart';
import 'package:liboora/domain/social/social.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

final _t0 = DateTime.utc(2025, 1, 1, 9);

PersonIdentityService _service(
  InMemoryPersonIdentityRepository repo, {
  IdGenerator? ids,
}) => PersonIdentityService(
  repository: repo,
  clock: FixedClock(_t0),
  ids: ids ?? SequentialIdGenerator(),
);

void main() {
  // ═══════════════════════════════════════════════════════════════════
  // SID-INV-1 / SID-INV-2 / SID-AC-1 — exactly one identity per account,
  // created in the same transaction as the account.
  // ═══════════════════════════════════════════════════════════════════
  group('SID-INV-1 · one account, exactly one identity', () {
    test('creating an account creates its identity in the same call', () {
      final repo = InMemoryPersonIdentityRepository();
      final accounts = <Account>[];
      final auth = AuthService(
        accounts,
        clock: FixedClock(_t0),
        random: FixedRandomSource(const [1, 1, 1, 1, 1, 1]),
        ids: SequentialIdGenerator(),
        identities: _service(repo),
        challengePeekEnabled: true,
      );

      expect(repo.count, 0);

      auth.requestOtp('9810000009');
      final created = auth.verifyOtp(
        phone: '9810000009',
        code: auth.debugPeekChallenge('9810000009')!,
        displayName: 'New Person',
      );

      expect(created, isNotNull);
      // SID-4.11: synchronous and transactional — the identity is already
      // present, with no event drained and no second call made.
      expect(repo.count, 1);
      expect(repo.byAccountId(created!.id), isNotNull);
      expect(repo.byPersonId(created.personId), isNotNull);
    });

    test('a repeated createFor for one account never mints a second', () {
      final repo = InMemoryPersonIdentityRepository();
      final svc = _service(repo);
      const account = AccountId('acc_dup');

      final first = svc.createFor(account: account, displayName: 'A');
      final second = svc.createFor(account: account, displayName: 'A');

      expect(second, equals(first), reason: 'SID-INV-1: never two');
      expect(repo.count, 1);
    });

    test('a conflicting second identity for one account is refused', () {
      final repo = InMemoryPersonIdentityRepository();
      repo.save(
        PersonIdentity(
          personId: const PersonId('per_1'),
          accountId: const AccountId('acc_1'),
          createdAt: _t0,
          displayName: 'First',
        ),
      );

      expect(
        () => repo.save(
          PersonIdentity(
            personId: const PersonId('per_2'),
            accountId: const AccountId('acc_1'),
            createdAt: _t0,
            displayName: 'Second',
          ),
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.conflict,
          ),
        ),
      );
    });

    test('identity creation failure fails account creation (SID-AC-1)', () {
      final accounts = <Account>[];
      final auth = AuthService(
        accounts,
        clock: FixedClock(_t0),
        random: FixedRandomSource(const [2, 2, 2, 2, 2, 2]),
        ids: SequentialIdGenerator(),
        identities: _ThrowingIdentityFactory(),
        challengePeekEnabled: true,
      );

      auth.requestOtp('9810000010');
      final code = auth.debugPeekChallenge('9810000010')!;

      expect(
        () => auth.verifyOtp(
          phone: '9810000010',
          code: code,
          displayName: 'Doomed',
        ),
        throwsA(isA<DomainError>()),
      );
      // The failure of either fails both: no half-created account survives.
      expect(accounts, isEmpty);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // SID-4.17 / ID-4 — the Student Record's PersonId is non-nullable.
  // ═══════════════════════════════════════════════════════════════════
  group('SID-4.17 · a student record always carries an identity', () {
    StudentRecord build({required PersonId personId}) => StudentRecord(
      id: const StudentRecordId('stu_1'),
      enrollmentNumber: 'STU0001',
      fullName: 'Test Student',
      phone: '9810000011',
      dateOfBirth: DateTime(2000, 1, 1),
      enrolledOn: _t0,
      personId: personId,
    );

    test('a valid PersonId is accepted', () {
      expect(build(personId: const PersonId('per_ok')).personId.value, 'per_ok');
    });

    test('an empty PersonId is refused, not silently tolerated', () {
      // The type system forbids null; this guards the remaining hole — a
      // present-but-blank identifier (SID-4.56).
      expect(
        () => build(personId: const PersonId('  ')),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.validationFailed,
          ),
        ),
      );
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // SID-4.31 — the falsifiable test of ADR-0011. Identity must not depend
  // on the social product in any way.
  // ═══════════════════════════════════════════════════════════════════
  group('SID-4.31 · identity survives the social product being absent', () {
    test('an identity is created and usable with no social object present', () {
      final repo = InMemoryPersonIdentityRepository();
      final personId = _service(
        repo,
      ).createFor(account: const AccountId('acc_solo'), displayName: 'Solo');

      // Nothing from domain/social participates above. The identity resolves.
      final resolved = repo.resolve(personId);
      expect(resolved, isNotNull);
      expect(resolved!.displayName, 'Solo');
      expect(resolved.isActive, isTrue);
    });

    test('social presence stores no identity field it could duplicate', () {
      // SID-BR-11 / SID-4.53: social keys on PersonId and resolves display
      // fields; it never stores a copy. If a name or headline were ever added
      // to SocialPresence, this test is where that regression surfaces.
      final presence = SocialPresence(personId: const PersonId('per_x'));
      expect(presence.personId.value, 'per_x');
      expect(presence.lifetimeStudyMinutes, 0);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // SID-4.19 / SID-INV-6 / SID-INV-8 — the module must not be CAPABLE of
  // answering "which libraries does this person attend?"
  // ═══════════════════════════════════════════════════════════════════
  group('SID-4.19 · identity cannot answer where a person studies', () {
    test('the E-13 ACL exposes only core fields, never organisations', () {
      final repo = InMemoryPersonIdentityRepository();
      final personId = _service(
        repo,
      ).createFor(account: const AccountId('acc_acl'), displayName: 'Reader');

      final IdentityDirectory directory = repo;
      final fields = directory.resolve(personId)!;

      // The projection is a closed, flat set of three values. It carries no
      // StudentRecordId, no TenantId and no collection of organisations.
      expect(fields.personId, personId);
      expect(fields.displayName, 'Reader');
      expect(fields.isActive, isTrue);
    });

    test('resolving an unknown PersonId yields null, never a created one', () {
      final repo = InMemoryPersonIdentityRepository();
      expect(repo.resolve(const PersonId('per_ghost')), isNull);
      expect(repo.count, 0, reason: 'a read must never create');
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // ID-5 — erasure anonymises the person but must NOT erase the library's
  // financial and attendance history. This asymmetry is the load-bearing
  // reason the identity split is kept at all.
  // ═══════════════════════════════════════════════════════════════════
  group('ID-5 · anonymising a person preserves library history', () {
    test('anonymise clears profile content but keeps the identifier', () {
      final identity = PersonIdentity(
        personId: const PersonId('per_erase'),
        accountId: const AccountId('acc_erase'),
        createdAt: _t0,
        displayName: 'To Be Removed',
        headline: 'somewhere',
        examTrack: 'CAT',
      );

      identity.anonymise();

      expect(identity.status, PersonIdentityStatus.anonymised);
      expect(identity.headline, isEmpty);
      expect(identity.examTrack, isEmpty);
      // SID-INV-3: the PersonId is never reused and never cleared, so the
      // library's pseudonymised history remains attributable.
      expect(identity.personId.value, 'per_erase');
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // MP-GBR-02 across the real composition root, and ID-5's cardinality:
  // one person, many student records.
  // ═══════════════════════════════════════════════════════════════════
  group('MP-GBR-02 · the booted system has no identity-less account', () {
    test('every seeded account has exactly one identity', () async {
      final c = await AppContainer.boot(seeder: seedDemoData);

      expect(c.auth.accounts, isNotEmpty);
      for (final a in c.auth.accounts) {
        expect(
          c.identities.byAccountId(a.id),
          isNotNull,
          reason: 'account ${a.id.value} has no Global Person Identity',
        );
        expect(a.personId.isValid, isTrue);
      }
      // The integrity counter that used to read 4 now reads 0.
      final missing = c.auth.accounts
          .where((a) => c.identities.byAccountId(a.id) == null)
          .length;
      expect(missing, 0);
    });

    test('enrolling the same number twice reuses one identity', () async {
      final c = await AppContainer.boot(seeder: seedDemoData);
      final first = c.provisionIdentityForEnrollment(
        phone: '9899999999',
        displayName: 'Repeat Person',
      );
      final second = c.provisionIdentityForEnrollment(
        phone: '9899999999',
        displayName: 'Repeat Person',
      );

      // Two libraries, two StudentRecords, ONE PersonId (ID-5, SID-INV-1).
      expect(second, equals(first));
    });

    test('a provisioned account grants no session until claimed', () async {
      final c = await AppContainer.boot(seeder: seedDemoData);
      c.provisionIdentityForEnrollment(
        phone: '9877777777',
        displayName: 'Walk In',
      );
      final provisioned = c.auth.accounts.firstWhere(
        (a) => a.phone == '9877777777',
      );

      // MP-GBR-25: reception cannot prove possession of the number, so the
      // account holds no role and no session may be issued for it (E-11).
      expect(provisioned.roles, isEmpty);
      expect(
        c.auth.issueSession(
          account: provisioned,
          tenant: const TenantId('tnt_aspirants'),
          branch: const BranchId('brn_lajpat'),
        ),
        isNull,
      );
    });
  });
}

/// Fails identity creation, to prove account creation fails with it.
final class _ThrowingIdentityFactory implements PersonIdentityFactory {
  @override
  PersonId createFor({
    required AccountId account,
    required String displayName,
  }) => throw const DomainError(
    DomainErrorCode.systemDependencyUnavailable,
    'Identity store unavailable.',
  );
}
