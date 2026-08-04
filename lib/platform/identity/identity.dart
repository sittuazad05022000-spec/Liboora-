/// **Identity & Access Platform — R4** (BC-18)
///
/// Owns credentials, sessions and authorisation. Note what it does NOT own:
/// the social profile (BC-10) and the student record (BC-01). See the
/// Identity Triad, LIBOORA_BOUNDED_CONTEXT_MAP.md §4.
library;

import 'dart:math' as math;

import 'package:liboora_contracts/liboora_contracts.dart';

/// Access roles. Distinct from `CommunityRole` (BC-15) — see the ubiquitous
/// language collision table.
enum AccessRole {
  owner('Owner'),
  manager('Manager'),
  reception('Reception'),
  student('Student'),
  parent('Parent');

  const AccessRole(this.label);
  final String label;
}

/// Credentials only. No profile data, no student data.
final class Account {
  const Account({
    required this.id,
    required this.phone,
    required this.displayName,
    required this.roles,
    required this.personId,
  });

  final AccountId id;
  final String phone;
  final String displayName;

  /// Tenant-scoped role assignments: tenantId -> roles held there.
  final Map<String, Set<AccessRole>> roles;

  /// The account's Global Person Identity (`BC-10`).
  ///
  /// **Non-nullable.** Exactly one exists per account, created in the same
  /// transaction as the account itself, and neither may exist without the other
  /// at any observable moment (`MP-GBR-02` as amended, `SID-INV-1`,
  /// `SID-INV-2`). This is not an opt-in social link — see `ADR-0011`.
  final PersonId personId;

  Set<AccessRole> rolesIn(TenantId tenant) => roles[tenant.value] ?? const {};
}

final class AuthSession {
  const AuthSession({
    required this.id,
    required this.account,
    required this.tenantId,
    required this.branchId,
    required this.activeRole,
    required this.startedAt,
  });

  /// Opaque, non-guessable (amendment A-8). Never a log or metric dimension.
  final SessionId id;
  final Account account;
  final TenantId tenantId;
  final BranchId branchId;
  final AccessRole activeRole;
  final DateTime startedAt;
}

/// Permissions, checked by the Policy Decision Point.
///
/// This catalogue is **closed**: it is not extensible by a tenant, by
/// configuration, or at a call site.
enum Permission {
  enrollStudent,
  viewStudent,
  createMembership,
  recordAttendance,
  assignSeat,
  collectFee,
  applyDiscount,
  viewRevenue,
  viewAllBranches,
  managePolicy;

  /// Typed catalogue identity (amendment A-8).
  PermissionId get id => PermissionId('perm.$name');
}

/// The **closed** scope register. Exactly three members; a scope qualifies
/// *which* resources a permission reaches, never *whether* it is held.
///
/// Fix for defect F-01: a permission granted without a scope is a permission
/// over every resource in the tenant, which is what `viewStudent` silently was
/// for `student` and `parent`.
enum AccessScope {
  /// The actor's own subject record, and nothing else.
  self,

  /// Subject records the actor is guardian to, and nothing else.
  guardianOf,

  /// Every subject record in the tenant, subject to the branch qualifier
  /// carried by [AuthSession.branchId] and `Permission.viewAllBranches`.
  tenantWide,
}

/// Centralised authorisation. Domain contexts call this port; they never
/// implement their own role checks.
final class PolicyDecisionPoint {
  const PolicyDecisionPoint();

  /// Every grant now carries the scope it is granted at. There is no way to
  /// express an unscoped grant, which is what made F-01 possible.
  static const Map<AccessRole, Map<Permission, AccessScope>> _grants = {
    AccessRole.owner: {
      Permission.enrollStudent: AccessScope.tenantWide,
      Permission.viewStudent: AccessScope.tenantWide,
      Permission.createMembership: AccessScope.tenantWide,
      Permission.recordAttendance: AccessScope.tenantWide,
      Permission.assignSeat: AccessScope.tenantWide,
      Permission.collectFee: AccessScope.tenantWide,
      Permission.applyDiscount: AccessScope.tenantWide,
      Permission.viewRevenue: AccessScope.tenantWide,
      Permission.viewAllBranches: AccessScope.tenantWide,
      Permission.managePolicy: AccessScope.tenantWide,
    },
    AccessRole.manager: {
      Permission.enrollStudent: AccessScope.tenantWide,
      Permission.viewStudent: AccessScope.tenantWide,
      Permission.createMembership: AccessScope.tenantWide,
      Permission.recordAttendance: AccessScope.tenantWide,
      Permission.assignSeat: AccessScope.tenantWide,
      Permission.collectFee: AccessScope.tenantWide,
      Permission.viewRevenue: AccessScope.tenantWide,
      Permission.managePolicy: AccessScope.tenantWide,
    },
    AccessRole.reception: {
      Permission.enrollStudent: AccessScope.tenantWide,
      Permission.viewStudent: AccessScope.tenantWide,
      Permission.createMembership: AccessScope.tenantWide,
      Permission.recordAttendance: AccessScope.tenantWide,
      Permission.assignSeat: AccessScope.tenantWide,
      Permission.collectFee: AccessScope.tenantWide,
    },
    // F-01: these two were `tenantWide` by omission.
    AccessRole.student: {Permission.viewStudent: AccessScope.self},
    AccessRole.parent: {Permission.viewStudent: AccessScope.guardianOf},
  };

  /// Capability only: is this permission held *at any scope*?
  ///
  /// Answering true here is necessary but never sufficient. Holding a
  /// capability is not holding access to a resource.
  bool allows(AccessRole role, Permission permission) =>
      _grants[role]?.containsKey(permission) ?? false;

  /// The scope a role holds a permission at, or null if it does not hold it.
  AccessScope? scopeOf(AccessRole role, Permission permission) =>
      _grants[role]?[permission];

  /// Resource-free check. Passes only for `tenantWide` grants.
  ///
  /// A `self` or `guardianOf` grant cannot be satisfied without naming a
  /// resource, so this method now refuses it instead of waving it through —
  /// and refuses it as `xNotFound`, never as `xDenied`, because a scoped
  /// denial must be indistinguishable from a non-existent resource.
  void require(AccessRole role, Permission permission) {
    final scope = scopeOf(role, permission);
    if (scope == null) {
      throw DomainError(
        DomainErrorCode.authzNoRoleGrantsPermission,
        '${role.label} is not permitted to ${permission.name}.',
        context: {'role': role.name, 'permission': permission.name},
      );
    }
    if (scope != AccessScope.tenantWide) {
      throw DomainError(
        DomainErrorCode.authzScopeOutsideSubject,
        '${role.label} holds ${permission.name} only at scope '
        '${scope.name}; a resource must be named.',
        context: {
          'role': role.name,
          'permission': permission.name,
          'scope': scope.name,
        },
      );
    }
  }

  /// Resource-bearing check — the only way a scoped grant can ever pass.
  ///
  /// [actorSubject] is the actor's own subject record; [guardianOf] is the set
  /// they are guardian to, resolved by the owning context at decision time and
  /// never cached here.
  void requireOn(
    AccessRole role,
    Permission permission, {
    required StudentRecordId resource,
    StudentRecordId? actorSubject,
    Set<StudentRecordId> guardianOf = const {},
  }) {
    final scope = scopeOf(role, permission);
    if (scope == null) {
      throw DomainError(
        DomainErrorCode.authzNoRoleGrantsPermission,
        '${role.label} is not permitted to ${permission.name}.',
        context: {'role': role.name, 'permission': permission.name},
      );
    }

    final reaches = switch (scope) {
      AccessScope.tenantWide => true,
      AccessScope.self => actorSubject != null && actorSubject == resource,
      AccessScope.guardianOf => guardianOf.contains(resource),
    };

    if (!reaches) {
      // Indistinguishable from not-found, by design.
      throw DomainError(
        DomainErrorCode.authzScopeOutsideSubject,
        'Resource not available.',
        context: {
          'role': role.name,
          'permission': permission.name,
          'scope': scope.name,
        },
      );
    }
  }
}

/// Cryptographically secure adapter for [RandomSource].
///
/// Lives here, in the adapter layer, because the shared kernel may not import
/// `dart:math` (law L5). Never construct a challenge from anything else.
final class SecureRandomSource implements RandomSource {
  SecureRandomSource() : _random = math.Random.secure();

  final math.Random _random;

  @override
  int nextInt(int max) => _random.nextInt(max);
}

/// A pending possession challenge. Single-use, time-bounded, attempt-bounded.
final class _Challenge {
  _Challenge({required this.code, required this.expiresAt});

  final String code;
  final DateTime expiresAt;
  int attempts = 0;
}

/// Possession-of-number authentication.
///
/// This is a **stub adapter behind a port**, not a demo backdoor: real delivery
/// arrives via the Integration Platform without any change to callers.
///
/// Fix for defect F-02, in four parts:
///   1. the challenge is drawn from [RandomSource], never derived from the
///      subject (`phone.hashCode` was a public function of a public input);
///   2. it expires;
///   3. it has an attempt budget;
///   4. **requesting one is a uniform, non-informative act** — the caller
///      learns nothing about whether the number is registered.
final class AuthService {
  AuthService(
    this._accounts, {
    required Clock clock,
    required RandomSource random,
    required IdGenerator ids,
    required PersonIdentityFactory identities,
    this.challengePeekEnabled = false,
  }) : _clock = clock,
       _random = random,
       _ids = ids,
       _identities = identities;

  /// Adapter defaults. The normative bounds live in the locked challenge and
  /// lockout registers; these are the scaffold's configuration of them.
  static const Duration challengeTtl = Duration(minutes: 5);
  static const int maxVerifyAttempts = 5;
  static const int _codeDigits = 6; // TRAI DLT numeric template

  final List<Account> _accounts;
  final Clock _clock;
  final RandomSource _random;
  final IdGenerator _ids;

  /// Rank-0 port to `BC-10` Global Person Identity (`ADR-0011`).
  ///
  /// Held as an interface, never as a concrete type: this platform is rank 4
  /// and the implementation is rank 7.5, so a direct dependency would be upward
  /// (law **L2**) and a capability importing a domain module (law **L4**). The
  /// port inverts both.
  final PersonIdentityFactory _identities;

  /// Debug affordance for a scaffold with no SMS gateway. Must be false in any
  /// release wiring — a peek surface is a disclosure surface.
  final bool challengePeekEnabled;

  final Map<String, _Challenge> _issued = {};

  List<Account> get accounts => List.unmodifiable(_accounts);

  /// Register an account provisioned by an operator flow (reception enrolling a
  /// walk-in student), rather than by the account holder's own OTP.
  ///
  /// Deliberately **not** a lookup and deliberately **not** an upsert: it takes
  /// a fully-formed [Account] — which the type system now guarantees carries a
  /// [PersonId] — and adds it. It returns nothing, so it cannot be used to test
  /// whether a number is registered (which is why [_accountForPhone] is
  /// private). Callers must already hold the account, not merely a number.
  ///
  /// The account is unverified: it holds no role, so [issueSession] refuses it
  /// until the holder proves possession of the number themselves (`MP-GBR-25`).
  /// Re-registering an existing number is a no-op, keeping this idempotent
  /// against a double-submitted enrollment form.
  void registerProvisionedAccount(Account account) {
    if (_accountForPhone(account.phone) != null) return;
    _accounts.add(account);
  }

  /// Private on purpose: a public lookup by number is an enumeration oracle
  /// regardless of who calls it.
  Account? _accountForPhone(String phone) {
    for (final a in _accounts) {
      if (a.phone == phone) return a;
    }
    return null;
  }

  /// Issue a possession challenge.
  ///
  /// Returns nothing, and behaves identically whether or not the number is
  /// registered. There is deliberately no success/failure signal to read.
  void requestOtp(String phone) {
    final code = _generateCode();
    final challenge = _Challenge(
      code: code,
      expiresAt: _clock.now().add(challengeTtl),
    );

    // AR-7: there is no branch on registration status at all — not in the
    // response, and not in storage either. A registered and an unregistered
    // number consume the same work and leave the same internal state, so
    // neither the response, the timing, nor the memory profile discriminates.
    _issued[phone] = challenge;
  }

  /// Debug-only retrieval of the issued code. Returns null unless the wiring
  /// explicitly enabled it, and null for an unissued number either way.
  String? debugPeekChallenge(String phone) =>
      challengePeekEnabled ? _issued[phone]?.code : null;

  /// **Stage 1 — Authentication only** (AR-6).
  ///
  /// Verifies possession of the number and, on the *first* successful
  /// verification, creates the [Account] (AR-2, Bounded Context Map §4:
  /// *"Created on first successful OTP"*).
  ///
  /// Deliberately takes **no tenant and no branch**: a tenant parameter on an
  /// authentication call would merge Authentication with Authorization, which
  /// AR-6 forbids. Roles, and therefore sessions, are a separate stage —
  /// see [issueSession].
  ///
  /// [displayName] is the name the **Registration flow collected before OTP
  /// verification** (AR-5). It is used only when an account must be created.
  /// An existing account's display name is never rewritten here: profile
  /// mutation is not an Authentication concern.
  ///
  /// Returns null when the challenge is absent, expired or exhausted, when the
  /// code does not match, or when creation is required and no usable collected
  /// name was supplied.
  Account? verifyOtp({
    required String phone,
    required String code,
    String? displayName,
  }) {
    final challenge = _issued[phone];
    if (challenge == null) return null;

    if (!_clock.now().isBefore(challenge.expiresAt)) {
      _issued.remove(phone);
      return null;
    }

    challenge.attempts++;
    if (challenge.attempts > maxVerifyAttempts) {
      _issued.remove(phone);
      return null;
    }

    if (challenge.code != code) return null;

    _issued.remove(phone); // single-use

    final existing = _accountForPhone(phone);
    if (existing != null) return existing;

    // First successful verification for this number: create the Account.
    //
    // AR-5 prohibits an empty string, the mobile number, a placeholder and an
    // auto-generated name. Nothing is generated or derived here — absent a
    // usable collected name, no account is created.
    final name = displayName?.trim() ?? '';
    if (name.isEmpty || name == phone.trim()) return null;

    final accountId = AccountId(_ids.next('acc'));

    // ADR-0011 / SID-4.11 — the Global Person Identity is created here,
    // SYNCHRONOUSLY, in the same unit of work as the account. It is
    // deliberately NOT event-driven: an event would open a window in which an
    // account exists without an identity, which the 1:1 invariant forbids
    // (SID-INV-2). If identity creation throws, no account is added — the
    // failure of either fails both (SID-AC-1).
    final personId = _identities.createFor(
      account: accountId,
      displayName: name,
    );

    final created = Account(
      id: accountId,
      phone: phone,
      displayName: name,
      personId: personId,
      // AR-6: an Account may exist before any tenant role exists. Roles are
      // assigned by Authorization after Membership Processing.
      roles: const {},
    );
    _accounts.add(created);
    return created;
  }

  /// **Stage 2 — Session issuance** (AR-6).
  ///
  /// Separate from authentication by ruling: *"Session issuance shall occur
  /// only after the required authorization context exists."* Returns null while
  /// the account holds no role in [tenant] — an authenticated account with no
  /// tenant role is a legitimate state, not a failure.
  ///
  /// Takes an already-verified [Account], never a phone number, so it cannot be
  /// used as an existence oracle.
  AuthSession? issueSession({
    required Account account,
    required TenantId tenant,
    required BranchId branch,
  }) {
    final roles = account.rolesIn(tenant);
    if (roles.isEmpty) return null;

    return AuthSession(
      id: SessionId(_ids.next('sess')),
      account: account,
      tenantId: tenant,
      branchId: branch,
      activeRole: roles.first,
      startedAt: _clock.now(),
    );
  }

  String _generateCode() {
    final buffer = StringBuffer();
    for (var i = 0; i < _codeDigits; i++) {
      buffer.write(_random.nextInt(10));
    }
    return buffer.toString();
  }
}
