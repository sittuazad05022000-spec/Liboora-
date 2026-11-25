/// **BC-10 DOB ownership — the write path, the invariant, the erasure.**
///
/// `ADR-0179` — the date of birth is personal data owned by BC-10
/// (`SM-4.2`, `SM-4.5`); `StudentRecord` stores no copy of it. This suite
/// pins the ownership rules on BC-10's only write path:
///
///   * **first-wins** — a different DOB than the recorded one is a conflict,
///     never a silent overwrite;
///   * **idempotent replay** — recording the *same* DOB again is a no-op;
///   * **a future DOB is invalid input**, measured against the injected clock
///     (`X-09` — the invariant lives on the clock-owning write path, never in
///     the aggregate constructor);
///   * **no identity, no DOB** — the write refuses rather than inventing a
///     person;
///   * **erasure clears the DOB** (`ID-5`/`SEV-16` — anonymise removes the
///     personal data the identity owns);
///   * **the owned DOB survives a restart** — an owned fact must be durable,
///     which is why the identity directory itself persists (`ADR-0179` §1.5).
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  group('BC-10 recordDateOfBirth — the single write path', () {
    test('records the DOB and the E-13 read returns it', () async {
      final c = await AppContainer.boot();
      c.enterScope(
        tenant: const TenantId('t_dob'),
        branch: const BranchId('b'),
      );
      final (personId, _) = c.provisionIdentityForEnrollment(
        phone: '9811100001',
        displayName: 'Dob Holder',
        dateOfBirth: DateTime(2000, 5, 17),
      );

      final core = c.identities.resolve(personId);
      expect(core, isNotNull);
      expect(core!.dateOfBirth, DateTime(2000, 5, 17));
      expect(core.displayName, 'Dob Holder');
    });

    test('recording the same DOB again is an idempotent no-op', () async {
      final c = await AppContainer.boot();
      c.enterScope(
        tenant: const TenantId('t_dob'),
        branch: const BranchId('b'),
      );
      final (personId, _) = c.provisionIdentityForEnrollment(
        phone: '9811100002',
        displayName: 'Replay Person',
        dateOfBirth: DateTime(1999, 2, 1),
      );

      expect(
        () => c.identityService.recordDateOfBirth(
          personId: personId,
          dateOfBirth: DateTime(1999, 2, 1),
          recordedBy: 'reception-2',
        ),
        returnsNormally,
      );
      expect(c.identities.resolve(personId)!.dateOfBirth, DateTime(1999, 2, 1));
    });

    test('a different DOB is a conflict, never a silent overwrite', () async {
      final c = await AppContainer.boot();
      c.enterScope(
        tenant: const TenantId('t_dob'),
        branch: const BranchId('b'),
      );
      final (personId, _) = c.provisionIdentityForEnrollment(
        phone: '9811100003',
        displayName: 'Conflict Person',
        dateOfBirth: DateTime(1999, 2, 1),
      );

      expect(
        () => c.identityService.recordDateOfBirth(
          personId: personId,
          dateOfBirth: DateTime(1998, 2, 1),
          recordedBy: 'reception-2',
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.conflict,
          ),
        ),
      );
      // First-wins: the original fact is untouched.
      expect(c.identities.resolve(personId)!.dateOfBirth, DateTime(1999, 2, 1));
    });

    test('a future DOB is invalid input, measured against the clock', () async {
      final c = await AppContainer.boot();
      c.enterScope(
        tenant: const TenantId('t_dob'),
        branch: const BranchId('b'),
      );
      final (personId, _) = c.provisionIdentityForEnrollment(
        phone: '9811100004',
        displayName: 'Not Yet Born',
      );
      final tomorrow = c.clock.today().add(const Duration(days: 1));

      expect(
        () => c.identityService.recordDateOfBirth(
          personId: personId,
          dateOfBirth: tomorrow,
          recordedBy: 'reception-2',
        ),
        throwsA(isA<DomainError>()),
      );
      expect(c.identities.resolve(personId)!.dateOfBirth, isNull);
    });

    test('a DOB cannot be recorded for a person with no identity', () async {
      final c = await AppContainer.boot();
      c.enterScope(
        tenant: const TenantId('t_dob'),
        branch: const BranchId('b'),
      );
      expect(
        () => c.identityService.recordDateOfBirth(
          personId: const PersonId('per_missing'),
          dateOfBirth: DateTime(1999, 2, 1),
          recordedBy: 'reception-2',
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.notFound,
          ),
        ),
      );
    });
  });

  group('BC-10 DOB — erasure and durability', () {
    test('anonymise clears the DOB with the rest of the profile', () async {
      final c = await AppContainer.boot();
      c.enterScope(
        tenant: const TenantId('t_dob'),
        branch: const BranchId('b'),
      );
      final (personId, _) = c.provisionIdentityForEnrollment(
        phone: '9811100005',
        displayName: 'Erased Person',
        dateOfBirth: DateTime(1990, 1, 31),
      );
      c.identities.byPersonId(personId)!.anonymise();

      final core = c.identities.resolve(personId);
      expect(
        core,
        isNotNull,
        reason: 'The identity still exists; it is anonymised, not deleted.',
      );
      expect(core!.isActive, isFalse);
      expect(
        core.dateOfBirth,
        isNull,
        reason:
            'ID-5/SEV-16 — erasure removes the personal data the '
            'identity owns, the DOB with it.',
      );
    });

    test(
      'the owned DOB survives a restart through the durable directory',
      () async {
        final durable = InMemoryKeyValueStore();
        final first = await AppContainer.boot(durable: durable);
        first.enterScope(
          tenant: const TenantId('t_dob'),
          branch: const BranchId('b'),
        );
        final (personId, _) = first.provisionIdentityForEnrollment(
          phone: '9811100006',
          displayName: 'Durable Person',
          dateOfBirth: DateTime(1996, 12, 3),
        );
        first.leaveScope();

        final second = await AppContainer.boot(durable: durable);
        second.enterScope(
          tenant: const TenantId('t_dob'),
          branch: const BranchId('b'),
        );
        final core = second.identities.resolve(personId);
        expect(core, isNotNull);
        expect(
          core!.dateOfBirth,
          DateTime(1996, 12, 3),
          reason: 'BC-10 owns the DOB; an owned fact must survive restart.',
        );
      },
    );
  });

  group('E-13 — the identity directory read capability', () {
    test('an unknown person resolves to null, never to a guess', () async {
      final c = await AppContainer.boot();
      c.enterScope(
        tenant: const TenantId('t_dob'),
        branch: const BranchId('b'),
      );
      expect(c.identities.resolve(const PersonId('per_nowhere')), isNull);
    });

    test(
      'an identity without a DOB reads as null, never as a default age',
      () async {
        final c = await AppContainer.boot();
        c.enterScope(
          tenant: const TenantId('t_dob'),
          branch: const BranchId('b'),
        );
        final (personId, _) = c.provisionIdentityForEnrollment(
          phone: '9811100007',
          displayName: 'Undated Person',
        );
        final core = c.identities.resolve(personId)!;
        expect(core.dateOfBirth, isNull);
        expect(core.isActive, isTrue);
      },
    );
  });
}
