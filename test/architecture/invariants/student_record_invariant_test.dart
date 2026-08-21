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
///   * **guardian mandatory if age < 18**;
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
  DateTime? dateOfBirth,
  GuardianLink? guardian,
  PersonId? personId,
}) {
  return StudentRecord(
    id: const StudentRecordId('stu-001'),
    enrollmentNumber: 'EN-0001',
    fullName: fullName,
    phone: phone,
    email: email,
    dateOfBirth: dateOfBirth ?? DateTime.utc(2000, 6, 1),
    enrolledOn: _enrolledOn,
    guardian: guardian,
    personId: personId ?? const PersonId('per-001'),
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

  group('BC-01 StudentRecord — guardian mandatory under 18', () {
    test('a minor without a guardian is refused', () {
      expect(
        () => _build(dateOfBirth: DateTime.utc(2015, 6, 1)),
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
        dateOfBirth: DateTime.utc(2015, 6, 1),
        guardian: const GuardianLink(name: 'R. Sharma', phone: '+919800000000'),
      );
      expect(rec.guardian, isNotNull);
    });

    test('minority is evaluated as of the enrolment date, not "now"', () {
      // Born exactly 18 years before enrolment => NOT a minor on that date.
      final adultOnTheDay = _build(
        dateOfBirth: DateTime.utc(2008, 1, 15),
      );
      expect(adultOnTheDay.isMinorOn(_enrolledOn), isFalse);

      // One day short of 18 on the enrolment date => minor, guardian required.
      expect(
        () => _build(dateOfBirth: DateTime.utc(2008, 1, 16)),
        throwsA(isA<DomainError>()),
      );
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
        () => rec.archive(outstandingBalance: Money.rupees(500)),
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
      rec.archive(outstandingBalance: Money.zero);
      expect(rec.status, EnrollmentStatus.archived);
    });

    test('the balance is SUPPLIED, never read by this aggregate', () {
      // E-09 / L3: BC-01 does not reach into BC-05. The proof that it does not
      // is that `archive` cannot be called without the caller providing the
      // number — there is no no-arg overload to fall back on.
      final rec = _build();
      expect(
        () => rec.archive(outstandingBalance: Money.zero),
        returnsNormally,
      );
      expect(rec.status, EnrollmentStatus.archived);
    });
  });
}
