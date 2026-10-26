/// **IMPL-304 — E-11 Account Resolution Port Contract Test.**
///
/// Requirements:
/// - `SM-3.1`: Enrollment MUST NOT create an Account. It resolves an existing
///   `AccountId` through E-11.
/// - `ADR-0011`: AccountId/PesonId 1:1 atomicity.
/// - `E-11`: Sync port, AccountId resolution; stored, never mutated.
///
/// Related: `test/account_directory_test.dart` (persistence conformance)
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  group('E-11 Account Resolution Port', () {
    final accounts = <Account>[];
    late AccountResolutionImpl resolver;

    setUp(() {
      accounts.clear();
      resolver = AccountResolutionImpl(accounts);
    });

    test('resolves an existing AccountId to AccountInfo', () {
      final account = Account(
        id: AccountId('acc-001'),
        phone: '981000001',
        displayName: 'Test User 1',
        personId: PersonId('per-001'),
        roles: {
          't_alpha': {AccessRole.owner},
        },
      );
      accounts.add(account);

      final resolved = resolver.byId(account.id);

      expect(resolved, isNotNull);
      expect(resolved!.personId, account.personId);
      expect(
        resolved.rolesIn(TenantId('t_alpha')),
        contains('owner'),
      );
    });

    test('returns personId for account with no tenant roles', () {
      final account = Account(
        id: AccountId('acc-002'),
        phone: '981000002',
        displayName: 'Test User 2',
        personId: PersonId('per-002'),
        roles: const {},
      );
      accounts.add(account);

      final resolved = resolver.byId(account.id);

      expect(resolved, isNotNull);
      expect(resolved!.personId, account.personId);
      expect(resolved.rolesByTenant.isEmpty, isTrue);
    });

    test('returns null for a non-existent AccountId (fail-closed)', () {
      final result = resolver.byId(AccountId('acc-nonexistent'));

      expect(result, isNull, reason: 'Resolution must fail closed, not throw');
    });

    test('returns compatible AccountInfo for same account resolving twice', () {
      final account = Account(
        id: AccountId('acc-003'),
        phone: '981000003',
        displayName: 'Test User 3',
        personId: PersonId('per-003'),
        roles: {'t_beta': {AccessRole.reception}},
      );
      accounts.add(account);

      final first = resolver.byId(account.id);
      final second = resolver.byId(account.id);

      expect(first, isNotNull);
      expect(second, isNotNull);
      expect(first!.personId, equals(second!.personId));
      expect(first.rolesByTenant, equals(second.rolesByTenant));
    });
  });
}