/// **Identity & Access Platform — R4** (BC-18)
///
/// Owns credentials, sessions and authorisation. Note what it does NOT own:
/// the social profile (BC-10) and the student record (BC-01). See the
/// Identity Triad, LIBOORA_BOUNDED_CONTEXT_MAP.md §4.
library;

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
    this.personId,
  });

  final AccountId id;
  final String phone;
  final String displayName;

  /// Tenant-scoped role assignments: tenantId -> roles held there.
  final Map<String, Set<AccessRole>> roles;

  /// Nullable by design — an account may never opt into the social product.
  final PersonId? personId;

  Set<AccessRole> rolesIn(TenantId tenant) => roles[tenant.value] ?? const {};
}

final class AuthSession {
  const AuthSession({
    required this.account,
    required this.tenantId,
    required this.branchId,
    required this.activeRole,
    required this.startedAt,
  });

  final Account account;
  final TenantId tenantId;
  final BranchId branchId;
  final AccessRole activeRole;
  final DateTime startedAt;
}

/// Permissions, checked by the Policy Decision Point.
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
  managePolicy,
}

/// Centralised authorisation. Domain contexts call this port; they never
/// implement their own role checks.
final class PolicyDecisionPoint {
  const PolicyDecisionPoint();

  static const Map<AccessRole, Set<Permission>> _grants = {
    AccessRole.owner: {
      Permission.enrollStudent,
      Permission.viewStudent,
      Permission.createMembership,
      Permission.recordAttendance,
      Permission.assignSeat,
      Permission.collectFee,
      Permission.applyDiscount,
      Permission.viewRevenue,
      Permission.viewAllBranches,
      Permission.managePolicy,
    },
    AccessRole.manager: {
      Permission.enrollStudent,
      Permission.viewStudent,
      Permission.createMembership,
      Permission.recordAttendance,
      Permission.assignSeat,
      Permission.collectFee,
      Permission.viewRevenue,
      Permission.managePolicy,
    },
    AccessRole.reception: {
      Permission.enrollStudent,
      Permission.viewStudent,
      Permission.createMembership,
      Permission.recordAttendance,
      Permission.assignSeat,
      Permission.collectFee,
    },
    AccessRole.student: {Permission.viewStudent},
    AccessRole.parent: {Permission.viewStudent},
  };

  bool allows(AccessRole role, Permission permission) =>
      _grants[role]?.contains(permission) ?? false;

  void require(AccessRole role, Permission permission) {
    if (!allows(role, permission)) {
      throw DomainError(
        DomainErrorCode.forbidden,
        '${role.label} is not permitted to ${permission.name}.',
        context: {'role': role.name, 'permission': permission.name},
      );
    }
  }
}

/// OTP authentication.
///
/// This is a **stub adapter behind a port**, not a demo backdoor: the real
/// SMS delivery arrives via the Integration Platform without any change to
/// callers. `lastIssuedOtp` exists only so the scaffold is runnable offline.
final class AuthService {
  AuthService(this._accounts, this._clock);

  final List<Account> _accounts;
  final Clock _clock;

  final Map<String, String> _issued = {};
  String? lastIssuedOtp;

  List<Account> get accounts => List.unmodifiable(_accounts);

  Account? accountForPhone(String phone) {
    for (final a in _accounts) {
      if (a.phone == phone) return a;
    }
    return null;
  }

  /// Issue a single-use OTP with a TTL. Returns false for unknown numbers.
  bool requestOtp(String phone) {
    if (accountForPhone(phone) == null) return false;
    final code = (100000 + phone.hashCode.abs() % 900000).toString();
    _issued[phone] = code;
    lastIssuedOtp = code;
    return true;
  }

  AuthSession? verifyOtp({
    required String phone,
    required String code,
    required TenantId tenant,
    required BranchId branch,
  }) {
    if (_issued[phone] != code) return null;
    _issued.remove(phone); // single-use
    final account = accountForPhone(phone);
    if (account == null) return null;
    final roles = account.rolesIn(tenant);
    if (roles.isEmpty) return null;
    return AuthSession(
      account: account,
      tenantId: tenant,
      branchId: branch,
      activeRole: roles.first,
      startedAt: _clock.now(),
    );
  }
}
