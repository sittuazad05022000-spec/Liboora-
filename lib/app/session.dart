/// UI-layer session state.
///
/// Holds the signed-in session and, critically, owns the **tenant scope**:
/// scope is entered on sign-in and left on sign-out. Every repository read
/// below this point is therefore tenant-partitioned by construction, and any
/// screen that somehow renders while signed out fails loudly with
/// `TenantContextMissing` instead of quietly showing another library's data.
library;

import 'package:flutter/foundation.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

import '../bootstrap/di.dart';
import '../bootstrap/seed.dart';
import '../domain/library/enrollment/enrollment.dart';
import '../domain/library/fee/fee.dart';
import '../domain/library/membership/membership.dart';
import '../platform/identity/identity.dart';
import '../platform/tenancy/tenancy.dart';

/// Phone of the student this demo parent account is guardian to.
///
/// V1 has no Family Access context — the parent↔student link is a genuine gap
/// (it belongs in a future BC, not in Identity and not in Enrollment). Hard-
/// coding it here keeps the gap visible instead of inventing a wrong model.
const String kDemoChildPhone = '9810000004';

final class SessionController extends ChangeNotifier {
  SessionController(this.container);

  final AppContainer container;

  AuthSession? _session;
  BranchId _branch = kDemoBranch;
  String? _otpHint;
  String? _error;

  AuthSession? get session => _session;
  bool get isSignedIn => _session != null;
  String? get otpHint => _otpHint;
  String? get error => _error;

  Account? get account => _session?.account;
  AccessRole get role => _session?.activeRole ?? AccessRole.student;
  BranchId get branch => _branch;

  Tenant get tenant => container.tenantById(_session?.tenantId ?? kDemoTenant);
  Branch get branchInfo => tenant.branches.firstWhere(
    (b) => b.id == _branch,
    orElse: () => tenant.branches.first,
  );

  /// The student record this session is *about* — for a student, themselves;
  /// for a parent, their child. Null for staff roles.
  StudentRecordId? get subjectStudentId {
    final acc = _session?.account;
    if (acc == null) return null;
    return switch (role) {
      AccessRole.student => container.studentAccountLinks[acc.phone],
      AccessRole.parent => container.studentAccountLinks[kDemoChildPhone],
      _ => null,
    };
  }

  // ── Auth ────────────────────────────────────────────────────────

  bool requestOtp(String phone) {
    _error = null;
    final ok = container.auth.requestOtp(phone.trim());
    if (!ok) {
      _error = 'No Liboora account is registered for this number.';
      _otpHint = null;
    } else {
      // Visible only because there is no SMS gateway wired in the scaffold.
      _otpHint = container.auth.lastIssuedOtp;
    }
    notifyListeners();
    return ok;
  }

  bool verifyOtp({required String phone, required String code}) {
    _error = null;
    final s = container.auth.verifyOtp(
      phone: phone.trim(),
      code: code.trim(),
      tenant: kDemoTenant,
      branch: _branch,
    );
    if (s == null) {
      _error = 'That code did not match. Request a new one.';
      notifyListeners();
      return false;
    }
    _session = s;
    _otpHint = null;

    // Enter the tenant scope for the lifetime of the session.
    container.enterScope(
      tenant: s.tenantId,
      branch: s.branchId,
      actor: s.account.displayName,
    );
    notifyListeners();
    return true;
  }

  void signOut() {
    _session = null;
    _otpHint = null;
    _error = null;
    container.leaveScope();
    notifyListeners();
  }

  void switchBranch(BranchId id) {
    _branch = id;
    final s = _session;
    if (s != null) {
      container.enterScope(
        tenant: s.tenantId,
        branch: id,
        actor: s.account.displayName,
      );
    }
    notifyListeners();
  }

  // ── Queries the dashboards need ─────────────────────────────────

  List<StudentRecord> get students =>
      container.students.all()
        ..sort((a, b) => a.fullName.compareTo(b.fullName));

  StudentRecord? studentById(StudentRecordId id) => container.students.byId(id);

  String nameOf(StudentRecordId id) =>
      container.students.byId(id)?.fullName ?? id.value;

  MembershipValidity validityOf(StudentRecordId id) =>
      container.membershipValidity.forStudent(id, container.clock.today());

  FeeLedger? ledgerOf(StudentRecordId id) => container.ledgers.forStudent(id);

  Money outstandingOf(StudentRecordId id) =>
      container.outstanding.forStudent(id);

  Money get totalOutstanding =>
      container.ledgers.all().fold(Money.zero, (sum, l) => sum + l.balance);

  List<StudentRecord> get expiringSoon {
    final today = container.clock.today();
    return students
        .where((s) {
          final ms = container.memberships.forStudent(s.id);
          return ms.any((m) => m.expiringSoon(today, within: 7));
        })
        .toList(growable: false);
  }

  List<StudentRecord> get withOpenDues => students
      .where((s) => container.outstanding.hasOpenDues(s.id))
      .toList(growable: false);

  bool isInsideNow(StudentRecordId id) {
    final day = container.attendance.find(id, container.clock.today());
    return day?.isOpen ?? false;
  }

  // ── Commands ────────────────────────────────────────────────────

  /// Wraps a use case so every failure becomes an operator-readable message
  /// rather than a red screen. `DomainError` is a business outcome, not a bug.
  Future<String?> run(Future<void> Function() action) async {
    try {
      await action();
      notifyListeners();
      return null;
    } on DomainError catch (e) {
      notifyListeners();
      return e.message;
    } catch (e) {
      notifyListeners();
      return 'Something went wrong: $e';
    }
  }

  Future<String?> checkIn(StudentRecordId id) => run(() async {
    await container.checkIn(actorRole: role, studentId: id);
  });

  Future<String?> checkOut(StudentRecordId id) => run(() async {
    await container.checkOut(actorRole: role, studentId: id);
  });

  Future<String?> collect(StudentRecordId id, Money amount, PaymentMode mode) =>
      run(() async {
        await container.collectFee(
          actorRole: role,
          studentId: id,
          amount: amount,
          mode: mode,
        );
      });

  Future<String?> assignSeat(StudentRecordId id, String seatId) =>
      run(() async {
        await container.assignSeat(
          actorRole: role,
          studentId: id,
          seatId: seatId,
        );
      });

  Future<String?> releaseSeat(String allocationId) => run(() async {
    await container.releaseSeat(actorRole: role, allocationId: allocationId);
  });

  Future<String?> enroll({
    required String fullName,
    required String phone,
    required DateTime dob,
    GuardianLink? guardian,
  }) => run(() async {
    await container.enrollStudent(
      actorRole: role,
      fullName: fullName,
      phone: phone,
      dateOfBirth: dob,
      guardian: guardian,
    );
  });

  void toggleOffline() {
    container.sync.online = !container.sync.online;
    notifyListeners();
  }

  Future<void> flushSync() async {
    await container.sync.flush();
    notifyListeners();
  }
}
