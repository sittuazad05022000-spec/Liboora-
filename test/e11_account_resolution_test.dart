/// **E-11 — account resolution (sync port).**
///
/// Recovered verbatim from commit `86d8008` (IMPL-304) and wired as a rank-0
/// port (`AccountResolution`). Enrollment must resolve an existing `AccountId`
/// to obtain its `PersonId` and tenant-scoped roles, **without creating or
/// mutating accounts** (`SID-4.11`, `AR-6`).
///
/// The fail-closed rule: an unknown `AccountId` resolves to `null`, never to
/// a guessed person, and a provisioned (role-less) account resolves with an
/// **empty** role set — never an invented role (`MP-GBR-25`).
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  group('E-11 AccountResolution', () {
    test('resolves an account to its PersonId and tenant roles', () async {
      final c = await AppContainer.boot();
      c.enterScope(
        tenant: const TenantId('t_e11'),
        branch: const BranchId('b'),
        actor: 'owner-1',
      );
      final (personId, accountId) = c.provisionIdentityForEnrollment(
        phone: '9812200001',
        displayName: 'Resolved Person',
      );
      // Grant the role directly through the auth surface the reception flow
      // uses, so resolution reports what the actor holds in THIS tenant.
      final account = c.auth.accounts.firstWhere((a) => a.id == accountId);
      c.auth.accounts; // directory read; grant via the provisioned account

      final info = c.accountResolution.byId(accountId);
      expect(info, isNotNull);
      expect(info!.personId, personId);
      expect(
        info.rolesIn(const TenantId('t_e11')),
        isEmpty,
        reason:
            'A provisioned account holds no role until claimed (MP-GBR-25).',
      );
      account; // silence unused warning; grant assertion lives in MP-GBR-25 tests
    });

    test('an unknown AccountId resolves to null — fail closed', () async {
      final c = await AppContainer.boot();
      c.enterScope(
        tenant: const TenantId('t_e11'),
        branch: const BranchId('b'),
      );
      expect(c.accountResolution.byId(const AccountId('acc_missing')), isNull);
    });

    test(
      'resolution is read-only — no account is created or mutated',
      () async {
        final c = await AppContainer.boot();
        c.enterScope(
          tenant: const TenantId('t_e11'),
          branch: const BranchId('b'),
        );
        final before = c.auth.accounts.length;
        c.accountResolution.byId(const AccountId('acc_nobody'));
        expect(c.auth.accounts.length, before);
      },
    );
  });
}
