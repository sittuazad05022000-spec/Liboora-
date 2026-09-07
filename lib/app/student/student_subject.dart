/// Subject resolution for the **student app boundary**.
///
/// **Why this is not in `app/shared`.** "Which student record is this session
/// about?" has an answer only for `TR-4` Student and `TR-5` Parent — the two
/// roles this boundary owns. For staff roles the question is meaningless: they
/// operate on many students, not one subject.
///
/// It previously lived on `SessionController` in `app/shared`, where it forced
/// a `switch (role)` naming `AccessRole.student` and `AccessRole.parent` into
/// role-neutral shared code. That is a small leak with a large consequence: it
/// meant the shared session object could not be compiled for a staff-only or
/// platform-only app without carrying customer-role knowledge with it. The
/// architecture test `app_boundary_test.dart` caught it, which is what the test
/// is for.
///
/// ⭐ **Behaviour is unchanged.** Same lookups, same `null` for staff roles,
/// same demo-guardian constant. Only the *location* moved, from shared code
/// into the boundary that is the sole consumer.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

import '../../platform/identity/identity.dart';
import '../shared/session.dart';

/// Phone of the student this demo parent account is guardian to.
///
/// V1 has no Family Access context — the parent↔student link is a genuine gap
/// (it belongs in a future BC, not in Identity and not in Enrollment). Hard-
/// coding it here keeps the gap visible instead of inventing a wrong model.
///
/// ⚠ Moved verbatim from `app/shared/session.dart`. It is a **student-boundary**
/// concern, so it belongs here; the gap it documents is untouched and still
/// open.
const String kDemoChildPhone = '9810000004';

/// Resolves the student record a customer-facing session is *about*.
extension StudentSubject on SessionController {
  /// For a student, themselves; for a parent, their child. `null` for any
  /// other role — including staff, for whom the concept does not apply.
  StudentRecordId? get subjectStudentId {
    final phone = accountPhone;
    if (phone == null) return null;
    return switch (role) {
      AccessRole.student => container.studentAccountLinks[phone],
      AccessRole.parent => container.studentAccountLinks[kDemoChildPhone],
      AccessRole.owner || AccessRole.manager || AccessRole.reception => null,
    };
  }
}
