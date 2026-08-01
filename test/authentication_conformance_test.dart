/// Authentication conformance regressions — v1.0 lock candidate.
///
/// Every test here fails if a closed blocker reopens. They are not coverage
/// tests; each one is the tripwire named in FAC-1142 for a specific defect or
/// amendment, so a reviewer can read the test name and know which register
/// entry it guards.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

/// A fixed instant so nothing here depends on a wall clock (X-09).
final _t0 = DateTime.utc(2025, 1, 1, 9);

AuthService _service({
  required List<Account> accounts,
  required FixedClock clock,
  List<int> random = const [1, 2, 3, 4, 5, 6],
  bool peek = true,
}) => AuthService(
  accounts,
  clock: clock,
  random: FixedRandomSource(random),
  ids: SequentialIdGenerator(),
  challengePeekEnabled: peek,
);

Account _account(String phone, TenantId tenant, AccessRole role) => Account(
  id: AccountId('acc_$phone'),
  phone: phone,
  displayName: 'Test $phone',
  roles: {
    tenant.value: {role},
  },
);

void main() {
  const tenant = TenantId('t_demo');
  const branch = BranchId('b_main');
  const known = '9810000001';
  const unknown = '9990000000';

  // ═══════════════════════════════════════════════════════════════════
  // DEFECT F-01 — a permission with no scope is a permission over
  // everything. These tests fail if the closed scope register is bypassed.
  // ═══════════════════════════════════════════════════════════════════
  group('F-01 · authorization is scope-bearing', () {
    const pdp = PolicyDecisionPoint();
    const mine = StudentRecordId('sr_self');
    const myChild = StudentRecordId('sr_child');
    const stranger = StudentRecordId('sr_stranger');

    test('every grant in the catalogue declares a scope', () {
      for (final role in AccessRole.values) {
        for (final perm in Permission.values) {
          if (pdp.allows(role, perm)) {
            expect(
              pdp.scopeOf(role, perm),
              isNotNull,
              reason: 'F-01: ${role.name}/${perm.name} is granted unscoped',
            );
          }
        }
      }
    });

    test('student and parent hold viewStudent at a narrowing scope only', () {
      expect(
        pdp.scopeOf(AccessRole.student, Permission.viewStudent),
        AccessScope.self,
      );
      expect(
        pdp.scopeOf(AccessRole.parent, Permission.viewStudent),
        AccessScope.guardianOf,
      );
      expect(
        pdp.scopeOf(AccessRole.reception, Permission.viewStudent),
        AccessScope.tenantWide,
      );
    });

    test('a scoped grant cannot be exercised without naming a resource', () {
      // This is the exact call that used to succeed and read any student.
      expect(
        () => pdp.require(AccessRole.student, Permission.viewStudent),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.authzScopeOutsideSubject,
          ),
        ),
      );
      expect(
        () => pdp.require(AccessRole.parent, Permission.viewStudent),
        throwsA(isA<DomainError>()),
      );
    });

    test('self scope reaches the actor only', () {
      pdp.requireOn(
        AccessRole.student,
        Permission.viewStudent,
        resource: mine,
        actorSubject: mine,
      );
      expect(
        () => pdp.requireOn(
          AccessRole.student,
          Permission.viewStudent,
          resource: stranger,
          actorSubject: mine,
        ),
        throwsA(isA<DomainError>()),
      );
    });

    test('guardianOf scope reaches the guarded set only', () {
      pdp.requireOn(
        AccessRole.parent,
        Permission.viewStudent,
        resource: myChild,
        guardianOf: {myChild},
      );
      expect(
        () => pdp.requireOn(
          AccessRole.parent,
          Permission.viewStudent,
          resource: stranger,
          guardianOf: {myChild},
        ),
        throwsA(isA<DomainError>()),
      );
    });

    test('a scoped denial is indistinguishable from not-found', () {
      // CON-1146 / SBR-887 / SBR-888. If this ever projects xDenied, the
      // response has become an existence oracle.
      try {
        pdp.requireOn(
          AccessRole.student,
          Permission.viewStudent,
          resource: stranger,
          actorSubject: mine,
        );
        fail('expected refusal');
      } on DomainError catch (e) {
        expect(e.externalOutcome, ExternalOutcome.xNotFound);
      }
    });

    test('staff decisions are unchanged by the fix', () {
      pdp.require(AccessRole.owner, Permission.viewRevenue);
      pdp.require(AccessRole.reception, Permission.enrollStudent);
      expect(
        () => pdp.require(AccessRole.reception, Permission.viewRevenue),
        throwsA(
          isA<DomainError>().having(
            (e) => e.code,
            'code',
            DomainErrorCode.authzNoRoleGrantsPermission,
          ),
        ),
      );
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // DEFECT F-02 — enumeration oracle, derivable challenge, no TTL,
  // no attempt budget.
  // ═══════════════════════════════════════════════════════════════════
  group('F-02 · challenge issuance is uniform and unpredictable', () {
    test('requesting a challenge returns nothing to branch on', () {
      final clock = FixedClock(_t0);
      final svc = _service(
        accounts: [_account(known, tenant, AccessRole.student)],
        clock: clock,
      );
      // The signature itself is the fix: there is no boolean to leak.
      expect(svc.requestOtp, isA<void Function(String)>());
      svc.requestOtp(known);
      svc.requestOtp(unknown);
    });

    test('an unknown number yields no usable challenge and no signal', () {
      final clock = FixedClock(_t0);
      final svc = _service(
        accounts: [_account(known, tenant, AccessRole.student)],
        clock: clock,
      );
      svc.requestOtp(unknown);
      expect(svc.debugPeekChallenge(unknown), isNull);
      expect(
        svc.verifyOtp(
          phone: unknown,
          code: '123456',
          tenant: tenant,
          branch: branch,
        ),
        isNull,
      );
    });

    test('the challenge is not a function of the subject', () {
      final clock = FixedClock(_t0);
      // Same number, different randomness -> different code. The old
      // implementation returned phone.hashCode-derived digits, so this was
      // impossible to satisfy.
      final a = _service(
        accounts: [_account(known, tenant, AccessRole.student)],
        clock: clock,
        random: const [1, 1, 1, 1, 1, 1],
      )..requestOtp(known);
      final b = _service(
        accounts: [_account(known, tenant, AccessRole.student)],
        clock: clock,
        random: const [2, 2, 2, 2, 2, 2],
      )..requestOtp(known);

      expect(a.debugPeekChallenge(known), isNot(b.debugPeekChallenge(known)));
      expect(a.debugPeekChallenge(known), hasLength(6));
      expect(
        int.tryParse(a.debugPeekChallenge(known)!),
        isNotNull,
        reason: 'TRAI DLT templates are numeric',
      );
    });

    test('the challenge expires', () {
      final clock = FixedClock(_t0);
      final svc = _service(
        accounts: [_account(known, tenant, AccessRole.student)],
        clock: clock,
      );
      svc.requestOtp(known);
      final code = svc.debugPeekChallenge(known)!;

      clock.advance(AuthService.challengeTtl + const Duration(seconds: 1));
      expect(
        svc.verifyOtp(phone: known, code: code, tenant: tenant, branch: branch),
        isNull,
      );
    });

    test('the challenge has an attempt budget', () {
      final clock = FixedClock(_t0);
      final svc = _service(
        accounts: [_account(known, tenant, AccessRole.student)],
        clock: clock,
      );
      svc.requestOtp(known);
      final code = svc.debugPeekChallenge(known)!;

      for (var i = 0; i < AuthService.maxVerifyAttempts + 1; i++) {
        svc.verifyOtp(
          phone: known,
          code: '000000',
          tenant: tenant,
          branch: branch,
        );
      }
      // Budget exhausted: the correct code no longer helps.
      expect(
        svc.verifyOtp(phone: known, code: code, tenant: tenant, branch: branch),
        isNull,
      );
    });

    test('the challenge is single-use', () {
      final clock = FixedClock(_t0);
      final svc = _service(
        accounts: [_account(known, tenant, AccessRole.student)],
        clock: clock,
      );
      svc.requestOtp(known);
      final code = svc.debugPeekChallenge(known)!;

      final first = svc.verifyOtp(
        phone: known,
        code: code,
        tenant: tenant,
        branch: branch,
      );
      expect(first, isNotNull);
      expect(
        svc.verifyOtp(phone: known, code: code, tenant: tenant, branch: branch),
        isNull,
      );
    });

    test('the peek surface is off unless explicitly enabled', () {
      final clock = FixedClock(_t0);
      final svc = _service(
        accounts: [_account(known, tenant, AccessRole.student)],
        clock: clock,
        peek: false,
      );
      svc.requestOtp(known);
      expect(svc.debugPeekChallenge(known), isNull);
    });

    test('a session carries an opaque identity', () {
      final clock = FixedClock(_t0);
      final svc = _service(
        accounts: [_account(known, tenant, AccessRole.student)],
        clock: clock,
      );
      svc.requestOtp(known);
      final session = svc.verifyOtp(
        phone: known,
        code: svc.debugPeekChallenge(known)!,
        tenant: tenant,
        branch: branch,
      );
      expect(session!.id, isA<SessionId>());
      expect(session.id.value, isNot(contains(known)));
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // AMENDMENT A-7 — the external projection is a declared property, and
  // it is lossy on purpose.
  // ═══════════════════════════════════════════════════════════════════
  group('A-7 · error projection', () {
    test('every code declares a class and an external outcome', () {
      for (final code in DomainErrorCode.values) {
        expect(code.errorClass, isNotNull, reason: code.name);
        expect(code.externalOutcome, isNotNull, reason: code.name);
      }
    });

    test('every authentication condition projects identically', () {
      final authCodes = DomainErrorCode.values.where(
        (c) => c.errorClass == ErrorClass.auth,
      );
      expect(authCodes, isNotEmpty);
      for (final code in authCodes) {
        expect(
          code.externalOutcome,
          ExternalOutcome.xUniformAuth,
          reason: '${code.name} leaks an authentication distinction',
        );
      }
    });

    test('every session condition projects identically', () {
      final sessionCodes = DomainErrorCode.values.where(
        (c) => c.errorClass == ErrorClass.session,
      );
      expect(sessionCodes, isNotEmpty);
      for (final code in sessionCodes) {
        expect(code.externalOutcome, ExternalOutcome.xSessionInvalid);
      }
    });

    test('scope refusal and erasure never disclose existence', () {
      expect(
        DomainErrorCode.authzScopeOutsideSubject.externalOutcome,
        ExternalOutcome.xNotFound,
      );
      expect(
        DomainErrorCode.lifecycleAccountErased.externalOutcome,
        ExternalOutcome.xNotFound,
      );
    });

    test('only system conditions are retriable', () {
      for (final code in DomainErrorCode.values) {
        expect(
          code.isRetriable,
          code.errorClass == ErrorClass.system,
          reason: code.name,
        );
      }
    });

    test('the external outcome set stays closed at seven members', () {
      expect(ExternalOutcome.values, hasLength(7));
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // AMENDMENT A-8 — the four identities are typed, so they cannot be
  // interchanged or degraded to String at a boundary.
  // ═══════════════════════════════════════════════════════════════════
  group('A-8 · identity types', () {
    test('the new identifiers exist and are distinct types', () {
      const device = DeviceId('dev_1');
      const session = SessionId('sess_1');
      const invite = InviteId('inv_1');
      const permission = PermissionId('perm.viewStudent');

      expect(device, isA<Identifier>());
      expect(session, isA<Identifier>());
      expect(invite, isA<Identifier>());
      expect(permission, isA<Identifier>());
    });

    test('same value, different type, never equal', () {
      expect(const DeviceId('x') == const SessionId('x'), isFalse);
      expect(const AccountId('x') == const SessionId('x'), isFalse);
      expect(const InviteId('x') == const PermissionId('x'), isFalse);
    });

    test('the closed permission catalogue is typed', () {
      for (final p in Permission.values) {
        expect(p.id, isA<PermissionId>());
        expect(p.id.value, startsWith('perm.'));
      }
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // QA-13 — entitlement absence narrows; it never widens, and it never
  // reaches the authentication or session path.
  // ═══════════════════════════════════════════════════════════════════
  group('QA-13 · entitlement gate', () {
    test('the refusal is a distinct, non-widening authorization code', () {
      expect(
        DomainErrorCode.authzEntitlementGateRefused.errorClass,
        ErrorClass.authz,
      );
      expect(
        DomainErrorCode.authzEntitlementGateRefused.externalOutcome,
        ExternalOutcome.xDenied,
      );
      expect(
        DomainErrorCode.authzEntitlementGateRefused.isRetriable,
        isFalse,
        reason: 'a gate refusal is not a transient system condition',
      );
    });

    test('authentication succeeds with no entitlement input at all', () {
      final clock = FixedClock(_t0);
      final svc = _service(
        accounts: [_account(known, tenant, AccessRole.student)],
        clock: clock,
      );
      svc.requestOtp(known);
      // AuthService takes no entitlement dependency, by construction.
      expect(
        svc.verifyOtp(
          phone: known,
          code: svc.debugPeekChallenge(known)!,
          tenant: tenant,
          branch: branch,
        ),
        isNotNull,
      );
    });
  });
}
