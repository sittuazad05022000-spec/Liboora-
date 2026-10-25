/// SM-10.2 (b) — tenant-scoped partial uniqueness of `(tenant, person_id)`.
///
/// `PRD-004` §10.2 requires that a person has at most ONE non-archived
/// `StudentRecord` per tenant (`SM-INV-6`). This is the application-layer half
/// of the constraint — the durable half is exercised by the storage
/// architecture, which is deliberately not selected here. The guard lives in
/// `EnrollStudent`, where the duplicate check must precede any mutation.
///
/// The interesting cases are the partial-uniqueness edges, not the happy path:
///  * re-enrolling the same person in the SAME tenant is rejected;
///  * re-enrolling the SAME person in a DIFFERENT tenant is allowed (ID-5 —
///    one human, many student records, one per library);
///  * an ARCHIVED record does NOT block re-enrolment (the "partial" in partial
///    unique).
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/seed.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  // ═══════════════════════════════════════════════════════════════════
  // SM-10.2 (b) — same person, same tenant: refused.
  // ═══════════════════════════════════════════════════════════════════
  group('SM-10.2 (b) · one non-archived record per (tenant, person)', () {
    test('enrolling the same person twice in one tenant is refused', () async {
      final c = await AppContainer.boot(seeder: seedDemoData);
      c.enterScope(tenant: kDemoTenant, branch: kDemoBranch);

      final personId = c.provisionIdentityForEnrollment(
        phone: '9811122233',
        displayName: 'Same Person',
      );
      await c.enrollStudent(
        actorRole: AccessRole.reception,
        fullName: 'Same Person',
        phone: '9811122233',
        dateOfBirth: DateTime.utc(1998, 7, 21),
        personId: personId,
      );

      expect(
        () => c.enrollStudent(
          actorRole: AccessRole.reception,
          fullName: 'Same Person Again',
          phone: '9811122244',
          dateOfBirth: DateTime.utc(1998, 7, 21),
          personId: personId,
        ),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.personAlreadyEnrolled,
          ),
        ),
      );
      c.leaveScope();
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // ID-5 — the same person at two libraries: allowed.
  // ═══════════════════════════════════════════════════════════════════
  group('SM-10.2 (b) · partial uniqueness is tenant-scoped (ID-5)', () {
    test('the same person enrolls at a second tenant without conflict', () async {
      final c = await AppContainer.boot(seeder: seedDemoData);
      c.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      final personId = c.provisionIdentityForEnrollment(
        phone: '9811122255',
        displayName: 'Two Libraries',
      );
      await c.enrollStudent(
        actorRole: AccessRole.owner,
        fullName: 'Two Libraries',
        phone: '9811122255',
        dateOfBirth: DateTime.utc(1995, 3, 3),
        personId: personId,
      );
      c.leaveScope();

      // A second library — the same person gets a SECOND StudentRecord with
      // the SAME PersonId. This is the asymmetry ID-5 depends on.
      c.enterScope(tenant: kOtherTenant, branch: kOtherBranch);
      final second = await c.enrollStudent(
        actorRole: AccessRole.owner,
        fullName: 'Two Libraries',
        phone: '9811122266',
        dateOfBirth: DateTime.utc(1995, 3, 3),
        personId: personId,
      );
      expect(second.personId, personId);
      c.leaveScope();
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // The "partial" in partial unique — an archived record does not block
  // re-enrolment.
  // ═══════════════════════════════════════════════════════════════════
  group('SM-10.2 (b) · archived records do not block re-enrolment', () {
    test('a re-enrolment after archive succeeds', () async {
      final c = await AppContainer.boot(seeder: seedDemoData);
      c.enterScope(tenant: kDemoTenant, branch: kDemoBranch);

      final personId = c.provisionIdentityForEnrollment(
        phone: '9811122288',
        displayName: 'Returning Student',
      );
      final first = await c.enrollStudent(
        actorRole: AccessRole.reception,
        fullName: 'Returning Student',
        phone: '9811122288',
        dateOfBirth: DateTime.utc(1997, 5, 5),
        personId: personId,
      );
      first.archive(outstandingBalance: Money.zero);
      c.students.save(first);

      // The archived record must not block a fresh enrolment (SM-10.2 (b)
      // partial unique: WHERE status <> 'Archived').
      final second = await c.enrollStudent(
        actorRole: AccessRole.reception,
        fullName: 'Returning Student',
        phone: '9811122288',
        dateOfBirth: DateTime.utc(1997, 5, 5),
        personId: personId,
      );
      expect(second.id, isNot(first.id));
      c.leaveScope();
    });
  });
}
