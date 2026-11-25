/// **`BC-01` Enrollment — aggregate `StudentRecord` invariant tests.**
///
/// Required by `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.3 row 3, via
/// `every_aggregate_has_invariant_tests_test.dart`.
///
/// The invariants asserted here are the ones the Bounded Context Map §8 row for
/// `BC-01` declares *"enforced synchronously inside the boundary"*:
///
///   * unique `(tenant, enrollmentNumber)` — a repository-level rule, exercised
///     by `tenant_isolation_test.dart` rather than here, because uniqueness is a
///     property of the store and not of a single instance;
///   * **at least one contactable channel**;
///   * **guardian mandatory if age < 18** — expressed through `minorStatus`
///     since `ADR-0179`: the aggregate never stores a DOB (`SM-4.2`), so the
///     fail-safe works off the resolved status (`SM-4.5b`) and the derived
///     status itself is exercised in the enrollment registration tests;
///   * **cannot Archive with open dues** (checked via the `E-09` pre-condition,
///     i.e. the balance is *supplied* by `BC-05`, never read directly).
///
/// A fifth invariant lives in the code and is asserted too: `personId` must be
/// valid (`ID-4` / `SID-4.17`). It is not in the §8 cell, and that asymmetry is
/// deliberate — the map lists the *business* invariants, while the identity
/// reference is structural.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/domain/library/enrollment/enrollment.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

/// A fixed clock date so "is this student a minor" never depends on the day the
/// suite runs. `X-09` forbids `DateTime.now()` in domain code; a test that used
/// it would be asserting a different rule every morning.
final DateTime _enrolledOn = DateTime.utc(2026, 1, 15);

StudentRecord _build({
  String fullName = 'Aarav Sharma',
  String phone = '+919812345678',
  String? email,
  MinorStatus minorStatus = MinorStatus.adult,
  AgeDeclaration? declaration,
  GuardianLink? guardian,
  PersonId? personId,
  EnrollmentStatus status = EnrollmentStatus.active,
}) {
  return StudentRecord(
    id: const StudentRecordId('stu-001'),
    enrollmentNumber: 'EN-0001',
    fullName: fullName,
    phone: phone,
    email: email,
    enrolledOn: _enrolledOn,
    guardian: guardian,
    personId: personId ?? const PersonId('per-001'),
    minorStatus: minorStatus,
    ageDeclaration: declaration,
    status: status,
    statusHistory: [
      StudentStatusChange(to: status, at: _enrolledOn, actor: 'test'),
    ],
  );
}

void main() {
  group('BC-01 StudentRecord — contactable channel', () {
    test('an adult with a phone and no email is valid', () {
      expect(_build().phone, isNotEmpty);
    });

    test('an adult with an email and no phone is valid', () {
      expect(_build(phone: '', email: 'aarav@example.com').email, isNotNull);
    });

    test('neither phone nor email is refused', () {
      // BC Map §8 BC-01: "at least one contactable channel".
      expect(
        () => _build(phone: '', email: null),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.contactChannelRequired,
          ),
        ),
      );
    });

    test('whitespace is not a contact channel', () {
      // A rule that accepts "   " is a rule that is not enforced.
      expect(
        () => _build(phone: '   ', email: '  '),
        throwsA(isA<DomainError>()),
      );
    });
  });

  group('BC-01 StudentRecord — guardian mandatory under 18 (SM-4.5b)', () {
    test('a minor without a guardian is refused', () {
      expect(
        () => _build(minorStatus: MinorStatus.minor),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.guardianRequiredForMinor,
          ),
        ),
      );
    });

    test('a minor with a guardian is accepted', () {
      final rec = _build(
        minorStatus: MinorStatus.minor,
        guardian: const GuardianLink(name: 'R. Sharma', phone: '+919800000000'),
      );
      expect(rec.guardian, isNotNull);
      expect(rec.requiresGuardian, isTrue);
    });

    test('an unknown status with a minor declaration requires a guardian', () {
      // `SM-4.5a` — the declaration is the recorded assertion; the fail-safe
      // follows it. A record declared-minor without a guardian cannot exist.
      expect(
        () => _build(
          minorStatus: MinorStatus.unknown,
          declaration: AgeDeclaration(
            isMinor: true,
            declaredBy: 'reception-1',
            declaredAt: _enrolledOn,
          ),
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.guardianRequiredForMinor,
          ),
        ),
      );
    });

    test('an unknown status declared adult needs no guardian', () {
      final rec = _build(
        minorStatus: MinorStatus.unknown,
        declaration: AgeDeclaration(
          isMinor: false,
          declaredBy: 'reception-1',
          declaredAt: _enrolledOn,
        ),
      );
      expect(rec.requiresGuardian, isFalse);
    });

    test('an unknown status with no declaration fails safe to minor', () {
      // `SM-4.5b` — when age cannot be checked the student is treated as a
      // minor, never as an adult: the record cannot exist without a guardian.
      expect(
        () => _build(minorStatus: MinorStatus.unknown),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.guardianRequiredForMinor,
          ),
        ),
      );
    });

    test('an adult needs no guardian', () {
      expect(_build(minorStatus: MinorStatus.adult).requiresGuardian, isFalse);
    });
  });

  group('BC-01 StudentRecord — identity reference (ID-4 / SID-4.17)', () {
    test('an invalid PersonId is refused', () {
      expect(
        () => _build(personId: const PersonId('')),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.validationFailed,
          ),
        ),
      );
    });

    test('a blank name is refused', () {
      expect(() => _build(fullName: '  '), throwsA(isA<DomainError>()));
    });
  });

  group('BC-01 StudentRecord — cannot archive with open dues (E-09)', () {
    test('archiving with a positive balance is refused', () {
      final rec = _build();
      expect(
        () => rec.archive(
          outstandingBalance: Money.rupees(500),
          actor: 'test',
          at: _enrolledOn,
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.cannotArchiveWithOpenDues,
          ),
        ),
      );
      // The refusal must leave the aggregate unchanged — a half-applied
      // transition is worse than a refused one.
      expect(rec.status, EnrollmentStatus.active);
    });

    test('archiving with a zero balance succeeds', () {
      final rec = _build();
      rec.archive(
        outstandingBalance: Money.zero,
        actor: 'test',
        at: _enrolledOn,
      );
      expect(rec.status, EnrollmentStatus.archived);
    });

    test('the balance is SUPPLIED, never read by this aggregate', () {
      // E-09 / L3: BC-01 does not reach into BC-05. The proof that it does not
      // is that `archive` cannot be called without the caller providing the
      // number — there is no no-arg overload to fall back on.
      final rec = _build();
      expect(
        () => rec.archive(
          outstandingBalance: Money.zero,
          actor: 'test',
          at: _enrolledOn,
        ),
        returnsNormally,
      );
      expect(rec.status, EnrollmentStatus.archived);
    });
  });

  group('BC-01 StudentRecord — status history (SM-2.13)', () {
    test(
      'every transition appends an audited entry; history is append-only',
      () {
        final rec = _build();
        rec.suspend(actor: 'owner-1', at: _enrolledOn, reason: 'fee default');
        rec.reactivate(actor: 'owner-1', at: _enrolledOn, reason: 'paid');
        expect(rec.statusHistory, hasLength(3));
        expect(rec.statusHistory.map((c) => c.to.name).toList(), [
          'active',
          'suspended',
          'active',
        ]);
        // Append-only: the first entry is still the registration itself.
        expect(rec.statusHistory.first.to, EnrollmentStatus.active);
      },
    );

    test('restore is refused unless the record is archived', () {
      final rec = _build();
      expect(
        () => rec.restore(actor: 'owner-1', at: _enrolledOn),
        throwsA(isA<DomainError>()),
      );
      expect(rec.status, EnrollmentStatus.active);
    });
  });
}
