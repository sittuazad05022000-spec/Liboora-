/// **IMPL-300 closeout — use-case population of the mandated `StudentRecord`
/// registration fields.**
///
/// The codec round-trip tests assert the serialised fields directly, and the
/// restart-survival test drives the real use case, but no test asserted the
/// VALUES a record produced by `EnrollStudent` carries. This closes that gap
/// for the three fields implemented under the verified audit scope:
///
///   * `tenantId` — the entered `TenantContext` tenant (`SM-2.2`, `SM-10.1`,
///     `SM-INV-8`);
///   * `registeredAt` — the Clock-port instant at record creation
///     (`SM-2.2`, `SM-10.1`);
///   * `registrationSource` — the closed-set value supplied by the caller
///     (`SM-3.8`), never inferred by the use case.
///
/// `enrolledOn` is asserted alongside deliberately: it must remain the
/// date-precision value the minor check consumes, independent of
/// `registeredAt` — neither field may derive from the other.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/seed.dart';
import 'package:liboora/domain/library/enrollment/enrollment.dart';
import 'package:liboora/platform/identity/identity.dart';

void main() {
  test('EnrollStudent populates tenantId, registeredAt and registrationSource '
      'from the enrollment context (SM-2.2 / SM-3.8)', () async {
    final c = await AppContainer.boot(seeder: seedDemoData);
    c.enterScope(tenant: kDemoTenant, branch: kDemoBranch);

    final pinned = DateTime.utc(2026, 10, 30, 14, 5);
    c.clock.pin(pinned);

    final personId = c.provisionIdentityForEnrollment(
      phone: '9811122299',
      displayName: 'Field Population',
    );
    final student = await c.enrollStudent(
      actorRole: AccessRole.reception,
      fullName: 'Field Population',
      phone: '9811122299',
      dateOfBirth: DateTime.utc(1998, 7, 21),
      personId: personId,
      registrationSource: RegistrationSource.staffAssisted,
    );

    // The tenant the record belongs to is the tenant in scope — the same
    // value the repository partitions by (SM-INV-8: exactly one, never null).
    expect(student.tenantId, kDemoTenant);

    // The registration instant is the pinned Clock value at record creation.
    expect(student.registeredAt, pinned);

    // SM-3.8 closed set — the caller-supplied value, stored as given.
    expect(student.registrationSource, RegistrationSource.staffAssisted);

    // enrolledOn keeps its independent date semantics (the minor check's
    // input); it is not the registration instant and must not drift.
    // `Clock.today()` yields local calendar midnight (clock.dart), not UTC.
    expect(student.enrolledOn, DateTime(2026, 10, 30));

    c.clock.unpin();
    c.leaveScope();
  });
}
