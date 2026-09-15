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

import '../../bootstrap/di.dart';
import '../../bootstrap/seed.dart';
import '../../domain/library/enrollment/enrollment.dart';
import '../../domain/library/fee/fee.dart';
import '../../domain/library/membership/membership.dart';
import '../../platform/identity/identity.dart';
import '../../platform/tenancy/tenancy.dart';

final class SessionController extends ChangeNotifier {
  /// Builds the controller and **restores any persisted session** (P1).
  ///
  /// Restore happens in the constructor, synchronously, rather than in an
  /// `initState` or a `Future`. That is deliberate: by the time the first
  /// frame is built the answer is already known, so a returning user never
  /// sees the sign-in screen flash before being replaced by their dashboard.
  /// The durable adapter was already opened at boot, so nothing here needs to
  /// await anything.
  SessionController(this.container) {
    _restorePersistedSession();
  }

  final AppContainer container;

  AuthSession? _session;
  Account? _verifiedAccount;
  BranchId _branch = kDemoBranch;
  String? _otpHint;
  String? _error;

  /// Re-establish a session persisted by a previous run, if it is still valid.
  ///
  /// Every rejection path is silent and lands on the sign-in screen: a device
  /// with no session, an expired one, a revoked role or an unreadable record
  /// are all simply "not signed in". `SessionStore.restore` clears the record
  /// in the rejecting cases, so a bad record cannot fail repeatedly.
  ///
  /// ⛔ This grants nothing. `SessionStore` re-checks the `CFG-5`/`CFG-6`
  /// expiry boundaries and re-reads the account's *current* roles before
  /// returning anything, so a restored session is strictly weaker than the one
  /// that was issued — never stronger.
  void _restorePersistedSession() {
    final restored = container.sessionStore.restore(
      accounts: container.auth.accounts,
      now: container.clock.now(),
    );
    if (restored == null) return;

    _session = restored;
    _branch = restored.branchId;

    // The same scope entry sign-in performs. Without it every repository read
    // on the first frame would throw TenantContextMissing.
    container.enterScope(
      tenant: restored.tenantId,
      branch: restored.branchId,
      actor: restored.account.displayName,
    );

    // Activity refreshes the idle boundary only (AUTH-6.16: the absolute
    // boundary cannot move). Persisted immediately, so closing the app without
    // further interaction does not lose the fact that it was opened.
    _session = restored.touchedAt(container.clock.now());
    container.sessionStore.save(_session!);
  }

  AuthSession? get session => _session;

  /// Whether a session is live **right now**.
  ///
  /// Re-tests the `CFG-5`/`CFG-6` boundaries on every read rather than
  /// trusting `_session != null`. Without this, only a *restart* enforced
  /// expiry: a reception tablet left open past its 30-minute idle limit would
  /// stay signed in for the rest of the day, which is the exact scenario
  /// `DOCUMENTATION_AUDIT-001` `R-C` corrected the value for.
  ///
  /// Expiry is evaluated lazily on read instead of by a timer: a timer that
  /// fires while the app is backgrounded is unreliable, and one that fires
  /// while it is foregrounded would still need this check to be correct.
  bool get isSignedIn {
    final s = _session;
    if (s == null) return false;
    if (s.isExpiredAt(container.clock.now())) {
      // Terminate for real, not just report false — otherwise the tenant
      // scope would stay entered behind an apparently signed-out UI.
      _expireSession();
      return false;
    }
    return true;
  }

  /// Ends an expired session (`AUTH-6.18`, `AUTH-6.20`).
  ///
  /// Deliberately does **not** call `notifyListeners`: this runs during a
  /// `build` via `isSignedIn`, and notifying mid-build would throw. The read
  /// that triggered it already returns the correct value, so the frame being
  /// built is right; nothing stale is shown.
  void _expireSession() {
    _session = null;
    _verifiedAccount = null;
    _otpHint = null;
    container.sessionStore.clear();
    container.leaveScope();
  }

  String? get otpHint => _otpHint;
  String? get error => _error;

  /// Whether this deployment can deliver a possession challenge at all.
  ///
  /// Asks about the *system*, never about a number, so it discloses nothing
  /// about who is registered (`F-02`). The sign-in surface uses it to say
  /// plainly that sign-in is unavailable, rather than collecting a number and
  /// then asking for a code that no transport will ever send (`IMPL-020`).
  bool get canSignIn => container.auth.canDeliverChallenges;

  /// An account that passed OTP verification but holds no role in this tenant,
  /// so no session could be issued (AR-6). This is a legitimate state, not a
  /// failure: role assignment happens in Membership Processing, after
  /// authentication. Null whenever a session exists or none was attempted.
  Account? get verifiedAccount => _verifiedAccount;

  /// True when the number is verified and the account exists, but the tenant
  /// role required for session issuance does not exist yet.
  bool get awaitingAuthorization =>
      _session == null && _verifiedAccount != null;

  Account? get account => _session?.account;

  /// The active role, or the least-privileged role when signed out.
  ///
  /// The default is taken from `kLeastPrivilegedRole` rather than named
  /// here, so this role-neutral shared class does not need to know which
  /// concrete roles exist. Behaviour is unchanged: that constant is
  /// `AccessRole.student`, exactly the previous default.
  AccessRole get role => _session?.activeRole ?? kLeastPrivilegedRole;
  BranchId get branch => _branch;

  Tenant get tenant => container.tenantById(_session?.tenantId ?? kDemoTenant);

  /// Display facts about the active branch.
  ///
  /// Read from **BC-06** through [BranchReader], not from `Tenant`: `IMPL-801`
  /// removed `Branch` from `platform/tenancy` (defect `D-013-01`), and
  /// Bounded Context Map L210 owns branches in BC-06.
  ///
  /// The previous implementation fell back to the tenant's first branch when
  /// the active id was unknown. That fallback is preserved deliberately —
  /// dropping it would turn an unknown branch into a thrown
  /// [DomainError] on a screen that merely wants a label, which is a
  /// behaviour change this task is not authorised to make.
  BranchView get branchInfo {
    final all = container.branchViews();
    for (final b in all) {
      if (b.id == _branch) return b;
    }
    return all.first;
  }

  /// Every branch, for the switcher. Ordered by name by the reader.
  List<BranchView> get branchOptions => container.branchViews();

  /// The signed-in account's own phone, or null when signed out.
  ///
  /// Exposed so a boundary can resolve its own subject without this class
  /// needing to know what "subject" means for that boundary's roles.
  String? get accountPhone => _session?.account.phone;

  // ── Auth ────────────────────────────────────────────────────────

  /// Request a possession challenge.
  ///
  /// Deliberately returns nothing and sets no error (F-02): the UI must not be
  /// able to tell a registered number from an unregistered one. The former
  /// "No Liboora account is registered for this number." message was the
  /// enumeration oracle, one layer up from the service.
  void requestOtp(String phone) {
    _error = null;
    _verifiedAccount = null;
    container.auth.requestOtp(phone.trim());
    // Null unless this is a debug wiring. Under AR-7 a challenge now exists for
    // every requested number, so this hint is uniform too — it no longer
    // discriminates registered from unregistered.
    _otpHint = container.auth.debugPeekChallenge(phone.trim());
    notifyListeners();
  }

  /// Verify the challenge and, if authorization allows, sign in.
  ///
  /// Two stages by ruling AR-6 — authentication first, session issuance second.
  /// Returns true only when a session was actually issued.
  ///
  /// [displayName] is the name Registration collected **before** OTP
  /// verification (AR-5). It is consumed only when the account does not exist
  /// yet; for an existing account it is ignored, which is what keeps this call
  /// uniform for registered and unregistered numbers.
  bool verifyOtp({
    required String phone,
    required String code,
    String? displayName,
  }) {
    _error = null;
    _verifiedAccount = null;

    // Stage 1 — Authentication. Yields the verified account, creating it on a
    // first successful verification.
    final account = container.auth.verifyOtp(
      phone: phone.trim(),
      code: code.trim(),
      displayName: displayName?.trim(),
    );
    if (account == null) {
      _error = 'That code did not match. Request a new one.';
      notifyListeners();
      return false;
    }

    // Stage 2 — Session issuance. Only once the authorization context exists.
    final s = container.auth.issueSession(
      account: account,
      tenant: kDemoTenant,
      branch: _branch,
    );
    if (s == null) {
      // Authenticated, account exists, no tenant role yet. Reported as the
      // distinct state it is, never as an authentication failure — collapsing
      // the two would breach the requirement that a successful verification be
      // distinguishable from a failed one.
      _verifiedAccount = account;
      _otpHint = null;
      _error =
          'Number verified. This account is not a member of any library yet.';
      notifyListeners();
      return false;
    }

    _session = s;
    _otpHint = null;

    // Persist so the next launch can restore it (P1). Written only after a
    // session was actually ISSUED — never after mere OTP verification, which
    // grants no authorization (AR-6).
    container.sessionStore.save(s);

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
    _verifiedAccount = null;
    _otpHint = null;
    _error = null;

    // AUTH-6.21 — termination must be immediate and IRREVERSIBLE, so the
    // record is deleted rather than flagged. This is what stops the next
    // launch from silently signing the user back in.
    container.sessionStore.clear();

    // AUTH-6.23 — sign-out must clear the active tenant context and retain no
    // authorization state.
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
      // Re-persist, so a restart reopens the branch the user was actually in
      // rather than the one they signed in to. Switching library is a
      // session-SCOPE change, never a re-authentication (ADR-0004), so the
      // session id and its absolute boundary are untouched.
      _session = AuthSession(
        id: s.id,
        account: s.account,
        tenantId: s.tenantId,
        branchId: id,
        activeRole: s.activeRole,
        startedAt: s.startedAt,
        lastActiveAt: container.clock.now(),
      );
      container.sessionStore.save(_session!);
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

  /// Enroll a walk-in student at the reception desk.
  ///
  /// **Where the `PersonId` comes from.** Every student has an Account
  /// (`MP-GBR-01`) and every Account has exactly one Global Person Identity
  /// created with it (`MP-GBR-02`), so enrollment never invents an identity —
  /// it resolves the one that already exists, or provisions the account that
  /// was missing and takes the identity minted alongside it.
  ///
  /// Reception cannot complete an OTP on the student's behalf (`MP-GBR-25` —
  /// possession of the number is the sole factor), so the account created here
  /// is **unverified and role-less**: it is a record awaiting the student's own
  /// first sign-in, which is exactly the `E-11` claim flow. It grants nothing.
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
      personId: container.provisionIdentityForEnrollment(
        phone: phone.trim(),
        displayName: fullName.trim(),
      ),
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
