library;

// ─────────────────────────────────────────────────────────────────────────────
// NOTE: `kDemoChildPhone` is deleted here per ADR-0085 §5 ruling 4 ("do not
// infer the relationship from unrelated data").  The `AccessRole.parent`
// branch previously hard-coded this constant as the student looked up for
// every parent session — a precise instance of the forbidden inference.
//
// `subjectStudentId` now returns `null` for `AccessRole.parent` until
// D10-10 (Option B — real parent→student link via `studentAccountLinks`)
// is unblocked.  Until then: parent access to the student boundary is
// intentionally absent.  ADR-0085 §5 explicitly records this gap as
// "genuine" (it belongs to a future BC, not Identity or Enrollment).
// ─────────────────────────────────────────────────────────────────────────────

import 'package:liboora_contracts/liboora_contracts.dart';

import '../../platform/identity/identity.dart';
import '../shared/session.dart';

/// Resolves the student record a customer-facing session is *about*.
extension StudentSubject on SessionController {
  /// For a student, themselves; for a parent, their child. `null` for any
  /// other role — including staff, for whom the concept does not apply.
  ///
  /// ⚠ Parent access is currently `null` — blocked by D10-10 (Option B).
  /// `studentAccountLinks[accountPhone]` returns `null` for a parent because
  /// the seeder has no parent→student link entry (no parent Account to key
  /// from; inventing one would breach ADR-0085 §6).  Until D10-10 unblocks,
  /// `AccessRole.parent` has no subject in this boundary.
  StudentRecordId? get subjectStudentId {
    final phone = accountPhone;
    if (phone == null) return null;
    return switch (role) {
      AccessRole.student => container.studentAccountLinks[phone],
      AccessRole.parent => null, // D10-10 blocked — no real parent→student link
      AccessRole.owner || AccessRole.manager || AccessRole.reception => null,
    };
  }
}
