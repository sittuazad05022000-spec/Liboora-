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
/// ⭐ **Behaviour is unchanged.** Same lookups, `null` for staff roles and for
/// a parent with no link on record — the parent dashboard renders that state as
/// "No child linked". Only the *location* moved, from shared code into the
/// boundary that is the sole consumer.
library;

import 'package:liboora_contracts/liboora_contracts.dart';

import '../../platform/identity/identity.dart';
import '../shared/session.dart';

/// Resolves the student record a customer-facing session is *about*.
///
/// For a student, themselves; for a parent, the student they are linked to.
/// The link is explicit (stored, keyed by the session holder's own authenticated
/// phone) and never inferred — [kDemoChildPhone] was removed for exactly this
/// reason. `null` for any other role — including staff, for whom the concept
/// does not apply — and `null` for a parent with no link on record, which the
/// parent dashboard renders as "No child linked".
extension StudentSubject on SessionController {
  /// For a student, themselves; for a parent, their child. `null` for any
  /// other role — including staff, for whom the concept does not apply.
  StudentRecordId? get subjectStudentId {
    final phone = accountPhone;
    if (phone == null) return null;
    return switch (role) {
      AccessRole.student => container.studentAccountLinks[phone],
      AccessRole.parent => container.studentAccountLinks[phone],
      AccessRole.owner || AccessRole.manager || AccessRole.reception => null,
    };
  }
}
