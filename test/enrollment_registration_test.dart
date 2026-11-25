/// **BC-01 enrollment registration — the frozen `SM-3`/`SM-4` semantics.**
///
/// `ADR-0179` — age derives from the BC-10 identity through the `E-13` ACL;
/// the behaviors pinned here were authorized with Option C and are pinned so
/// they cannot silently regress:
///
///   * number allocated **after** validation, in the synchronous critical
///     section — a failure never consumes a number (`SM-3.5`);
///   * duplicate detection **by personId only** (`SM-3.11`/`SM-3.12`), the
///     duplicate response carries the existing id (`SM-3.13`);
///   * archived records are **restored, never duplicated** (`SM-3.14`), the
///     most-recently-archived is the target (`SM-3.14a`), restore is **TR-1
///     only** enforced in the use case (`SM-2.3`);
///   * idempotency is tenant-scoped (`SM-3.6`): same key + same person replays
///     the prior record and emits nothing; a key reused for a **different**
///     person is a typed conflict;
///   * a failed registration emits no `SM-EV-1` (`SM-3.7`);
///   * minor status derives from the E-13 DOB (`SM-4.5`), falls back to the
///     audited declaration (`SM-4.5a`), and fails safe (`SM-4.5b`).
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/domain/library/enrollment/enrollment.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  const tenant = TenantId('t_enroll');
  const branch = BranchId('b_enroll');

  Future<AppContainer> world({DateTime? pinnedAt}) async {
    final c = await AppContainer.boot();
    c.enterScope(tenant: tenant, branch: branch, actor: 'owner-1');
    if (pinnedAt != null) c.clock.pin(pinnedAt);
    return c;
  }

  final pinned = DateTime(2026, 3, 15, 9, 0);

  group('registration — happy paths and derivation', () {
    test(
      'an adult with a recorded DOB enrolls; the history opens with Active',
      () async {
        final c = await world(pinnedAt: pinned);
        final (personId, accountId) = c.provisionIdentityForEnrollment(
          phone: '9814400001',
          displayName: 'Regular Adult',
          dateOfBirth: DateTime(2000, 1, 1),
        );

        final s = await c.enrollStudent(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('k_enroll_1'),
          accountId: accountId,
          fullName: 'Regular Adult',
          phone: '9814400001',
          personId: personId,
        );

        expect(s.enrollmentNumber, 'STU0001');
        expect(s.status, EnrollmentStatus.active);
        expect(s.minorStatus, MinorStatus.adult);
        expect(s.requiresGuardian, isFalse);
        expect(s.registrationSource, RegistrationSource.staffAssisted);
        expect(s.ageDeclaration, isNull);
        expect(s.accountId, accountId);
        expect(s.personId, personId);
        expect(s.enrolledOn, DateTime(2026, 3, 15));
        expect(s.statusHistory, hasLength(1));
        expect(s.statusHistory.first.to, EnrollmentStatus.active);
        expect(s.statusHistory.first.actor, 'owner-1');
      },
    );

    test(
      'a minor is derived from the E-13 DOB, not from a stored copy',
      () async {
        final c = await world(pinnedAt: pinned);
        final (personId, accountId) = c.provisionIdentityForEnrollment(
          phone: '9814400002',
          displayName: 'Young Student',
          dateOfBirth: DateTime(2015, 1, 1), // 11 years old on the pinned day.
        );

        final s = await c.enrollStudent(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('k_enroll_2'),
          accountId: accountId,
          fullName: 'Young Student',
          phone: '9814400002',
          personId: personId,
          guardian: const GuardianLink(name: 'Guardian G', phone: '9814400999'),
        );

        expect(s.minorStatus, MinorStatus.minor);
        expect(s.requiresGuardian, isTrue);
        expect(
          s.ageDeclaration,
          isNull,
          reason: 'Evidence exists; no declaration is recorded.',
        );
      },
    );

    test(
      'without a DOB, the audited declaration decides — and is stored',
      () async {
        final c = await world(pinnedAt: pinned);
        final (personId, accountId) = c.provisionIdentityForEnrollment(
          phone: '9814400003',
          displayName: 'Declared Adult',
        );

        final s = await c.enrollStudent(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('k_enroll_3'),
          accountId: accountId,
          fullName: 'Declared Adult',
          phone: '9814400003',
          personId: personId,
          declaration: AgeDeclaration(
            isMinor: false,
            declaredBy: 'owner-1',
            declaredAt: DateTime(2026, 3, 15),
          ),
        );

        expect(s.minorStatus, MinorStatus.unknown);
        expect(s.requiresGuardian, isFalse);
        expect(s.ageDeclaration!.isMinor, isFalse);
        expect(s.ageDeclaration!.declaredBy, 'owner-1');
      },
    );

    test(
      'no DOB and no declaration refuses the enrollment (SM-4.5a)',
      () async {
        final c = await world(pinnedAt: pinned);
        final (personId, accountId) = c.provisionIdentityForEnrollment(
          phone: '9814400004',
          displayName: 'Undeclared Person',
        );

        expect(
          () => c.enrollStudent(
            actorRole: AccessRole.owner,
            idempotencyKey: const IdempotencyKey('k_enroll_4'),
            accountId: accountId,
            fullName: 'Undeclared Person',
            phone: '9814400004',
            personId: personId,
          ),
          throwsA(isA<DomainError>()),
        );
      },
    );
  });

  group('registration — failure emits nothing and consumes no number', () {
    test(
      'a refused registration emits no SM-EV-1 and burns no number',
      () async {
        final c = await world(pinnedAt: pinned);
        final (minorId, minorAccount) = c.provisionIdentityForEnrollment(
          phone: '9814400005',
          displayName: 'Guardianless Minor',
          dateOfBirth: DateTime(2015, 1, 1),
        );

        // Minor without a guardian — refused by the SM-4.5b fail-safe.
        await expectLater(
          c.enrollStudent(
            actorRole: AccessRole.owner,
            idempotencyKey: const IdempotencyKey('k_fail_1'),
            accountId: minorAccount,
            fullName: 'Guardianless Minor',
            phone: '9814400005',
            personId: minorId,
          ),
          throwsA(isA<DomainError>()),
        );
        expect(
          c.events.log.where(
            (e) => e.eventType == 'enrollment.StudentEnrolled',
          ),
          isEmpty,
        );

        // The next successful registration still takes STU0001 — the failed
        // attempt consumed nothing (SM-3.5).
        final (adultId, adultAccount) = c.provisionIdentityForEnrollment(
          phone: '9814400006',
          displayName: 'Later Adult',
          dateOfBirth: DateTime(2000, 1, 1),
        );
        final s = await c.enrollStudent(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('k_fail_2'),
          accountId: adultAccount,
          fullName: 'Later Adult',
          phone: '9814400006',
          personId: adultId,
        );
        expect(s.enrollmentNumber, 'STU0001');
      },
    );
  });

  group('registration — duplicates, replay and key misuse', () {
    Future<({AppContainer c, StudentRecord first, PersonId personId})>
    enrolled() async {
      final c = await world(pinnedAt: pinned);
      final (personId, accountId) = c.provisionIdentityForEnrollment(
        phone: '9814400007',
        displayName: 'Twice Person',
        dateOfBirth: DateTime(2000, 1, 1),
      );
      final first = await c.enrollStudent(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('k_dup_1'),
        accountId: accountId,
        fullName: 'Twice Person',
        phone: '9814400007',
        personId: personId,
      );
      return (c: c, first: first, personId: personId);
    }

    test(
      'a second enrollment of the same person carries the existing id',
      () async {
        final (:c, :first, :personId) = await enrolled();
        final (_, accountId2) = c.provisionIdentityForEnrollment(
          phone: '9814400008',
          displayName: 'Second Walk-in',
        );

        await expectLater(
          c.enrollStudent(
            actorRole: AccessRole.owner,
            idempotencyKey: const IdempotencyKey('k_dup_2'),
            accountId: accountId2,
            fullName: 'Second Walk-in',
            phone: '9814400008',
            personId: personId,
          ),
          throwsA(
            isA<DomainError>()
                .having((e) => e.code, 'code', DomainErrorCode.conflict)
                .having(
                  (e) => e.context['existingStudentRecordId'],
                  'existingStudentRecordId',
                  first.id.value,
                ),
          ),
        );
      },
    );

    test('a replay with the same key and person returns the prior record '
        'and emits nothing', () async {
      final (:c, :first, :personId) = await enrolled();
      final eventsBefore = c.events.log
          .where((e) => e.eventType == 'enrollment.StudentEnrolled')
          .length;

      final replay = await c.enrollStudent(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('k_dup_1'),
        accountId: first.accountId!,
        fullName: 'Twice Person',
        phone: '9814400007',
        personId: personId,
      );

      expect(replay.id, first.id);
      expect(
        c.events.log.where((e) => e.eventType == 'enrollment.StudentEnrolled'),
        hasLength(eventsBefore),
        reason: 'SM-3.6 — a replay emits no duplicate SM-EV-1.',
      );
    });

    test('a key reused for a different person is a conflict', () async {
      final (:c, first: _, personId: _) = await enrolled();
      final (otherPerson, otherAccount) = c.provisionIdentityForEnrollment(
        phone: '9814400009',
        displayName: 'Key Thief',
        dateOfBirth: DateTime(2000, 1, 1),
      );

      await expectLater(
        c.enrollStudent(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('k_dup_1'),
          accountId: otherAccount,
          fullName: 'Key Thief',
          phone: '9814400009',
          personId: otherPerson,
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
  });

  group('restore — SM-2.3 / SM-3.14', () {
    Future<({AppContainer c, StudentRecordId archivedId})>
    archivedWorld() async {
      final c = await world(pinnedAt: pinned);
      final (personId, accountId) = c.provisionIdentityForEnrollment(
        phone: '9814400010',
        displayName: 'Returning Person',
        dateOfBirth: DateTime(2000, 1, 1),
      );
      final s = await c.enrollStudent(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('k_restore_1'),
        accountId: accountId,
        fullName: 'Returning Person',
        phone: '9814400010',
        personId: personId,
      );
      c.students
          .byId(s.id)!
          .archive(
            outstandingBalance: Money.zero,
            actor: 'owner-1',
            at: DateTime(2026, 3, 1),
          );
      return (c: c, archivedId: s.id);
    }

    test(
      're-enrolling an archived person is refused with the restore target',
      () async {
        final (:c, :archivedId) = await archivedWorld();
        final (_, accountId2) = c.provisionIdentityForEnrollment(
          phone: '9814400011',
          displayName: 'Returning Again',
        );

        await expectLater(
          c.enrollStudent(
            actorRole: AccessRole.owner,
            idempotencyKey: const IdempotencyKey('k_restore_2'),
            accountId: accountId2,
            fullName: 'Returning Again',
            phone: '9814400011',
            personId: c.students.byId(archivedId)!.personId,
          ),
          throwsA(
            isA<DomainError>()
                .having((e) => e.code, 'code', DomainErrorCode.conflict)
                .having(
                  (e) => e.context['archivedStudentRecordId'],
                  'archivedStudentRecordId',
                  archivedId.value,
                )
                .having((e) => e.context['archivedCount'], 'archivedCount', 1),
          ),
        );
      },
    );

    test(
      'restore is TR-1 only — reception is refused, owner succeeds',
      () async {
        final (:c, :archivedId) = await archivedWorld();

        await expectLater(
          c.restoreStudent(
            actorRole: AccessRole.reception,
            studentId: archivedId,
          ),
          throwsA(isA<DomainError>()),
        );
        expect(c.students.byId(archivedId)!.status, EnrollmentStatus.archived);

        final restored = await c.restoreStudent(
          actorRole: AccessRole.owner,
          studentId: archivedId,
        );
        expect(restored.status, EnrollmentStatus.active);
        expect(restored.statusHistory.last.to, EnrollmentStatus.active);
        expect(
          c.events.log.where(
            (e) => e.eventType == 'enrollment.StudentStatusChanged',
          ),
          hasLength(1),
          reason: 'SM-2.12 — every transition emits SM-EV-2.',
        );
      },
    );
  });

  group('registration — the desk outcome boundary (ADR-0179 review fixes)', () {
    test(
      'a future DOB surfaces as a FailedOutcome — no SM-EV-1, no number burned',
      () async {
        final c = await world(pinnedAt: pinned);
        final outcome = await c.registerWalkIn(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('k_desk_future_1'),
          fullName: 'Time Traveller',
          phone: '9814400020',
          dateOfBirth: DateTime(2026, 3, 16), // One day after the pinned clock.
        );

        expect(outcome, isA<FailedOutcome>());
        expect((outcome as FailedOutcome).message, contains('future'));
        // The provisioning refusal happened before enrollment could run, so
        // the half-built state must be visible but inert: no account was
        // registered, no event was emitted.
        expect(
          c.auth.accounts.any((a) => a.phone == '9814400020'),
          isFalse,
          reason: 'An unprovisioned account must not exist.',
        );
        expect(
          c.events.log.where(
            (e) => e.eventType == 'enrollment.StudentEnrolled',
          ),
          isEmpty,
          reason: 'SM-3.7 — a refused registration emits nothing.',
        );

        // And the next valid registration still takes STU0001 (SM-3.5).
        final next = await c.registerWalkIn(
          actorRole: AccessRole.owner,
          idempotencyKey: const IdempotencyKey('k_desk_future_2'),
          fullName: 'Valid Walk In',
          phone: '9814400021',
          dateOfBirth: DateTime(2000, 1, 1),
        );
        expect(next, isA<EnrolledOutcome>());
        expect((next as EnrolledOutcome).enrollmentNumber, 'STU0001');
      },
    );

    test('a DOB captured for an existing identity without one is recorded — '
        'the evidence wins over the declaration', () async {
      final c = await world(pinnedAt: pinned);
      // The person signed up earlier (E-11) but never gave a DOB.
      final (existingPerson, _) = c.provisionIdentityForEnrollment(
        phone: '9814400022',
        displayName: 'Late Dater',
      );
      expect(c.identities.resolve(existingPerson)!.dateOfBirth, isNull);

      final outcome = await c.registerWalkIn(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('k_desk_dob_1'),
        fullName: 'Late Dater',
        phone: '9814400022',
        dateOfBirth: DateTime(2015, 1, 1), // 11 on the pinned day — minor.
        declaredMinor: false, // The contradicted assertion must lose.
        guardian: const GuardianLink(name: 'Guardian G', phone: '9814400999'),
      );

      expect(outcome, isA<EnrolledOutcome>());
      // First-wins: BC-10 now owns the captured DOB.
      expect(
        c.identities.resolve(existingPerson)!.dateOfBirth,
        DateTime(2015, 1, 1),
      );
      final student = c.students.byId(
        (outcome as EnrolledOutcome).studentRecordId,
      )!;
      expect(student.personId, existingPerson);
      // The DOB (evidence) decided — not the declaration.
      expect(student.minorStatus, MinorStatus.minor);
      expect(student.ageDeclaration, isNull);
      expect(student.requiresGuardian, isTrue);
    });

    test('a different DOB than an already-owned one refuses the registration '
        'as a FailedOutcome — first-wins, never an overwrite', () async {
      final c = await world(pinnedAt: pinned);
      final (existingPerson, _) = c.provisionIdentityForEnrollment(
        phone: '9814400023',
        displayName: 'Owned Dob',
        dateOfBirth: DateTime(2000, 1, 1),
      );

      final outcome = await c.registerWalkIn(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('k_desk_conflict_1'),
        fullName: 'Owned Dob',
        phone: '9814400023',
        dateOfBirth: DateTime(1999, 5, 5),
      );

      expect(outcome, isA<FailedOutcome>());
      expect((outcome as FailedOutcome).message, contains('already has'));
      expect(
        c.identities.resolve(existingPerson)!.dateOfBirth,
        DateTime(2000, 1, 1),
        reason: 'First-wins: the owned fact is untouched.',
      );
      expect(
        c.events.log.where((e) => e.eventType == 'enrollment.StudentEnrolled'),
        isEmpty,
      );
    });

    test('the same DOB for an already-owned one is a no-op replay — the desk '
        'reaches the duplicate answer', () async {
      final c = await world(pinnedAt: pinned);
      final (existingPerson, accountId) = c.provisionIdentityForEnrollment(
        phone: '9814400024',
        displayName: 'Replay Dob',
        dateOfBirth: DateTime(2000, 1, 1),
      );
      await c.enrollStudent(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('k_desk_replay_1'),
        accountId: accountId,
        fullName: 'Replay Dob',
        phone: '9814400024',
        personId: existingPerson,
      );

      final outcome = await c.registerWalkIn(
        actorRole: AccessRole.owner,
        idempotencyKey: const IdempotencyKey('k_desk_replay_2'),
        fullName: 'Replay Dob',
        phone: '9814400024',
        dateOfBirth: DateTime(2000, 1, 1),
      );

      // Provisioning replayed (no conflict), then the personId duplicate
      // check answered `SM-3.13` — the desk opens the existing record.
      expect(outcome, isA<DuplicateOutcome>());
      final dup = outcome as DuplicateOutcome;
      expect(
        c.students.byId(dup.existingStudentRecordId)!.personId,
        existingPerson,
      );
    });
  });
}
