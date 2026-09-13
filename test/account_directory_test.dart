/// **Account directory persistence conformance.**
///
/// The blocker this closes: `SessionStore` persists an `AccountId`, but the
/// directory it must resolve that id against was an in-memory
/// `List<Account>`. After a real restart the list was empty, so a restored
/// session was always refused — correct fail-closed behaviour, but it meant
/// P1 session restore never actually completed.
///
/// ## Why accounts are not tenant-partitioned
///
/// `ADR-0003` makes an `Account` **global and cross-tenant** — *"One
/// registration per person. Switching libraries requires no
/// re-authentication."* Tenant isolation therefore lives in the `roles` map,
/// not in the storage key, and the tests below assert that distinction
/// directly: one account may be restored and hold a role at one library while
/// holding none at another.
///
/// ## Environment limitation, stated rather than worked around
///
/// These tests use `InMemoryKeyValueStore` as the durable adapter. `flutter
/// test` has no filesystem or IndexedDB, so `Hive.openBox` cannot run and a
/// genuine on-disk restart cannot be exercised here. What *is* exercised is
/// the full contract both adapters implement, and a "restart" means a **new
/// `AppContainer` over the same storage** — which is what a process restart is
/// from the application's point of view, and stricter than reopening a file
/// because it also proves no state survived in a static.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/account_store.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/seed.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

const _alpha = TenantId('t_alpha');
const _beta = TenantId('t_beta');

Account _account(
  String id, {
  Map<String, Set<AccessRole>> roles = const {},
  String? phone,
}) => Account(
  id: AccountId(id),
  phone: phone ?? '98100000$id',
  displayName: 'User $id',
  personId: PersonId('per_$id'),
  roles: roles,
);

void main() {
  // ═══════════════════════════════════════════════════════════════════
  // 1 — ROUND TRIP
  // ═══════════════════════════════════════════════════════════════════
  group('account records round-trip', () {
    test('every field survives, asserted field by field', () {
      final durable = InMemoryKeyValueStore();
      AccountStore(durable).save(
        _account(
          '1',
          phone: '9811100001',
          roles: const {
            't_alpha': {AccessRole.owner, AccessRole.manager},
            't_beta': {AccessRole.student},
          },
        ),
      );

      final restored = AccountStore(durable).restoreAll();
      expect(restored.length, 1);
      final a = restored.single;
      expect(a.id, const AccountId('1'));
      expect(a.phone, '9811100001');
      expect(a.displayName, 'User 1');
      expect(a.personId, const PersonId('per_1'));
      expect(a.rolesIn(_alpha), {AccessRole.owner, AccessRole.manager});
      expect(a.rolesIn(_beta), {AccessRole.student});
    });

    test('an account with NO roles round-trips as role-less', () {
      // The AR-6 state: authenticated, no tenant role yet. It must not gain
      // one by passing through storage.
      final durable = InMemoryKeyValueStore();
      AccountStore(durable).save(_account('2'));
      final a = AccountStore(durable).restoreAll().single;
      expect(a.roles, isEmpty);
      expect(a.rolesIn(_alpha), isEmpty);
    });

    test('roles are stored by NAME, not by enum index', () {
      // An index would silently re-point every stored grant if a future value
      // were inserted into the middle of AccessRole — a privilege escalation,
      // not a display bug.
      final durable = InMemoryKeyValueStore();
      AccountStore(durable).save(
        _account(
          '3',
          roles: const {
            't_alpha': {AccessRole.reception},
          },
        ),
      );
      final raw = durable.readAll(kAccountNamespace)['3']!;
      expect(raw, contains('reception'));
      expect(raw, isNot(contains('"roles":{"t_alpha":[2]')));
    });

    test('saving the same id twice replaces rather than duplicates', () {
      final durable = InMemoryKeyValueStore();
      final store = AccountStore(durable)
        ..save(_account('4'))
        ..save(
          _account(
            '4',
            roles: const {
              't_alpha': {AccessRole.owner},
            },
          ),
        );
      expect(store.restoreAll().length, 1);
      expect(store.restoreAll().single.rolesIn(_alpha), {AccessRole.owner});
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 2 — CORRUPT RECORDS FAIL SAFELY
  // ═══════════════════════════════════════════════════════════════════
  group('invalid records fail safely', () {
    test('malformed JSON is skipped, not crashed on', () {
      final durable = InMemoryKeyValueStore()
        ..write(kAccountNamespace, 'bad', '{not json')
        ..write(kAccountNamespace, 'good', '');
      AccountStore(durable).save(_account('ok'));

      final restored = AccountStore(durable).restoreAll();
      expect(restored.map((a) => a.id.value), ['ok']);
    });

    test('an unknown schema version is treated as corrupt', () {
      final durable = InMemoryKeyValueStore()
        ..write(
          kAccountNamespace,
          'x',
          '{"v":99,"id":"x","phone":"p","displayName":"d",'
              '"personId":"per_x","roles":{}}',
        );
      expect(AccountStore(durable).restoreAll(), isEmpty);
    });

    test('an UNKNOWN ROLE fails the whole record, never partially', () {
      // Dropping one unrecognised role would silently DOWNGRADE the account's
      // authorization. A partially-understood grant set is not one we may act
      // on, so the record is refused entirely.
      final durable = InMemoryKeyValueStore()
        ..write(
          kAccountNamespace,
          'x',
          '{"v":1,"id":"x","phone":"p","displayName":"d","personId":"per_x",'
              '"roles":{"t_alpha":["owner","superadmin"]}}',
        );
      expect(
        AccountStore(durable).restoreAll(),
        isEmpty,
        reason:
            'An account must not load with a silently reduced role set — that '
            'is a security decision made by a parse error.',
      );
    });

    test('a record missing its PersonId is refused (ID-4 / SID-INV-1)', () {
      final durable = InMemoryKeyValueStore()
        ..write(
          kAccountNamespace,
          'x',
          '{"v":1,"id":"x","phone":"p","displayName":"d","personId":"",'
              '"roles":{}}',
        );
      expect(AccountStore(durable).restoreAll(), isEmpty);
    });

    test('a record with an empty id is refused', () {
      final durable = InMemoryKeyValueStore()
        ..write(
          kAccountNamespace,
          'x',
          '{"v":1,"id":"","phone":"p","displayName":"d","personId":"per_x",'
              '"roles":{}}',
        );
      expect(AccountStore(durable).restoreAll(), isEmpty);
    });

    test('a corrupt record is PRESERVED, not deleted', () {
      // An account is not this store's to destroy, and deleting the record
      // would erase the only evidence of the corruption.
      final durable = InMemoryKeyValueStore()
        ..write(kAccountNamespace, 'bad', 'garbage');
      AccountStore(durable).restoreAll();
      expect(durable.readAll(kAccountNamespace).containsKey('bad'), isTrue);
    });

    test('persistedCount counts records, restoreAll counts USABLE ones', () {
      // The distinction the seeder guard depends on.
      final durable = InMemoryKeyValueStore()
        ..write(kAccountNamespace, 'bad', 'garbage');
      final store = AccountStore(durable);
      expect(store.persistedCount, 1);
      expect(store.restoreAll(), isEmpty);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 3 — TENANT ISOLATION
  // ═══════════════════════════════════════════════════════════════════
  group('tenant isolation', () {
    test('a role at one library is NOT a role at another', () {
      final durable = InMemoryKeyValueStore();
      AccountStore(durable).save(
        _account(
          '5',
          roles: const {
            't_alpha': {AccessRole.owner},
          },
        ),
      );
      final a = AccountStore(durable).restoreAll().single;

      expect(a.rolesIn(_alpha), {AccessRole.owner});
      expect(
        a.rolesIn(_beta),
        isEmpty,
        reason:
            'Restoring must not widen a grant across tenants. This is the '
            'isolation ADR-0003 places in the roles map.',
      );
    });

    test('a restored account cannot be authorised in the wrong tenant',
        () async {
      // The end-to-end consequence: issueSession must refuse a tenant the
      // account holds no role in, even after restore.
      final durable = InMemoryKeyValueStore();
      AccountStore(durable).save(
        _account(
          '6',
          roles: const {
            't_alpha': {AccessRole.owner},
          },
        ),
      );

      final c = await AppContainer.boot(durable: durable);
      final a = c.auth.accounts.single;

      expect(
        c.auth.issueSession(
          account: a,
          tenant: _alpha,
          branch: const BranchId('b'),
        ),
        isNotNull,
      );
      expect(
        c.auth.issueSession(
          account: a,
          tenant: _beta,
          branch: const BranchId('b'),
        ),
        isNull,
        reason: 'No role in t_beta means no session in t_beta.',
      );
    });

    test('accounts do not collide with tenant-scoped namespaces', () {
      final durable = InMemoryKeyValueStore();
      AccountStore(durable).save(_account('7'));
      expect(durable.readAll('student_records'), isEmpty);
      expect(durable.readAll('auth_session'), isEmpty);
      expect(durable.readAll(kAccountNamespace).keys, ['7']);
    });

    test('the directory is readable with NO tenant in scope', () {
      // It must be: the directory is an input to authentication, which happens
      // before any tenant is known.
      final durable = InMemoryKeyValueStore();
      AccountStore(durable).save(_account('8'));
      expect(AccountStore(durable).restoreAll, returnsNormally);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 4 — FIRST BOOT, PERSISTENCE, RESTART
  // ═══════════════════════════════════════════════════════════════════
  group('boot behaviour', () {
    test('first boot seeds accounts AND persists them', () async {
      final durable = InMemoryKeyValueStore();
      final c = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );

      expect(c.auth.accounts, isNotEmpty, reason: 'Seeder produced no accounts.');
      expect(
        durable.readAll(kAccountNamespace).length,
        c.auth.accounts.length,
        reason: 'Every seeded account must be written through.',
      );
    });

    test('RESTART restores the directory without re-seeding', () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      final seededIds = first.auth.accounts.map((a) => a.id.value).toSet();
      final seededCount = seededIds.length;

      // The restart.
      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );

      expect(
        second.auth.accounts.map((a) => a.id.value).toSet(),
        seededIds,
        reason: 'The same accounts, by id, must come back.',
      );
      expect(
        second.auth.accounts.length,
        seededCount,
        reason:
            'Equal counts prove the seeder did not run again — duplicates '
            'would breach the 1:1 account/identity invariant.',
      );
    });

    test('account ID lookup works after restart', () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      final target = first.auth.accounts.firstWhere(
        (a) => a.rolesIn(kDemoTenant).any(kStaffRoles.contains),
      );

      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      final found = second.auth.accounts.where((a) => a.id == target.id);

      expect(found, hasLength(1));
      expect(found.single.displayName, target.displayName);
      expect(found.single.phone, target.phone);
      expect(
        found.single.rolesIn(kDemoTenant),
        target.rolesIn(kDemoTenant),
        reason: 'Roles are the authorization source and must survive exactly.',
      );
    });

    test('seeded roles survive across three boots unchanged', () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      final before = {
        for (final a in first.auth.accounts)
          a.id.value: a.rolesIn(kDemoTenant).map((r) => r.name).toSet(),
      };

      await AppContainer.boot(seeder: seedDemoData, durable: durable);
      final third = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );

      final after = {
        for (final a in third.auth.accounts)
          a.id.value: a.rolesIn(kDemoTenant).map((r) => r.name).toSet(),
      };
      expect(after, before);
    });

    test('a PERSISTED account is not overwritten by seeding', () async {
      // The pre-existing account holds a role the demo seeder never assigns to
      // that id, so a re-seed would be visible.
      final durable = InMemoryKeyValueStore();
      AccountStore(durable).save(
        _account(
          'acc_owner',
          phone: '9999999999',
          roles: const {
            'tnt_aspirants': {AccessRole.reception},
          },
        ),
      );

      final c = await AppContainer.boot(seeder: seedDemoData, durable: durable);

      expect(
        c.auth.accounts.length,
        1,
        reason: 'The seeder must not run when the directory holds accounts.',
      );
      final a = c.auth.accounts.single;
      expect(a.phone, '9999999999');
      expect(a.rolesIn(kDemoTenant), {AccessRole.reception});
    });

    test('a directory of only CORRUPT records is not seeded over', () async {
      // Fails closed: the damaged records — the only evidence of the problem —
      // are preserved rather than replaced by demo data.
      final durable = InMemoryKeyValueStore()
        ..write(kAccountNamespace, 'bad', 'garbage');

      final c = await AppContainer.boot(seeder: seedDemoData, durable: durable);

      expect(c.auth.accounts, isEmpty);
      expect(durable.readAll(kAccountNamespace).containsKey('bad'), isTrue);
    });

    test('with NO durable store the old behaviour is unchanged', () async {
      // Regression guard for every pre-existing test, which boots without
      // durability.
      final c = await AppContainer.boot(seeder: seedDemoData);
      expect(c.auth.accounts, isNotEmpty);
      expect(c.accountStore.persistedCount, greaterThan(0));
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 5 — RUNTIME WRITE PATHS
  // ═══════════════════════════════════════════════════════════════════
  group('accounts created at runtime are persisted', () {
    test('an account provisioned at reception survives a restart', () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      final before = first.auth.accounts.length;

      first.provisionIdentityForEnrollment(
        phone: '9812345678',
        displayName: 'Walk In',
      );
      expect(first.auth.accounts.length, before + 1);

      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      expect(
        second.auth.accounts.any((a) => a.phone == '9812345678'),
        isTrue,
        reason:
            'A walk-in provisioned at the desk must still exist tomorrow, or '
            'the E-11 claim flow is broken.',
      );
    });

    test('a provisioned account is persisted with NO roles', () async {
      // MP-GBR-25: it grants nothing until the holder proves possession of the
      // number themselves. Storage must not invent a role.
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      first.provisionIdentityForEnrollment(
        phone: '9812345679',
        displayName: 'Role Less',
      );

      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      final a = second.auth.accounts.firstWhere(
        (x) => x.phone == '9812345679',
      );
      expect(a.roles, isEmpty);
      expect(
        second.auth.issueSession(
          account: a,
          tenant: kDemoTenant,
          branch: kDemoBranch,
        ),
        isNull,
        reason: 'A restored role-less account must still get no session.',
      );
    });

    test('NO OTP challenge is ever written to storage', () async {
      final durable = InMemoryKeyValueStore();
      final c = await AppContainer.boot(seeder: seedDemoData, durable: durable);
      c.auth.requestOtp('9810000001');

      // A short-lived secret must not become a durable one.
      final code = c.auth.debugPeekChallenge('9810000001');
      expect(code, isNotNull, reason: 'Peek is enabled outside product builds.');
      for (final ns in [kAccountNamespace, 'auth_session']) {
        for (final value in durable.readAll(ns).values) {
          expect(value.contains(code!), isFalse);
        }
      }
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 6 — END TO END: the chain P1 could not previously complete.
  // ═══════════════════════════════════════════════════════════════════
  group('E2E · account restore -> session restore -> authenticated', () {
    test('a real session survives a restart now that accounts persist',
        () async {
      final durable = InMemoryKeyValueStore();

      // ── Boot 1: sign in and persist ──
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      final staff = first.auth.accounts.firstWhere(
        (a) => a.rolesIn(kDemoTenant).any(kStaffRoles.contains),
      );
      final issued = first.auth.issueSession(
        account: staff,
        tenant: kDemoTenant,
        branch: kDemoBranch,
      );
      expect(issued, isNotNull);
      first.sessionStore.save(issued!);

      // ── Boot 2: the restart ──
      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );

      // The directory is populated from storage — the step that was missing.
      expect(
        second.auth.accounts,
        isNotEmpty,
        reason: 'This was empty before account persistence, blocking restore.',
      );

      // And the session now resolves against the CONTAINER'S OWN directory,
      // not one borrowed from the previous boot.
      final restored = second.sessionStore.restore(
        accounts: second.auth.accounts,
        now: second.clock.now(),
      );
      expect(restored, isNotNull);
      expect(restored!.account.id, staff.id);
      expect(restored.tenantId, kDemoTenant);
      expect(restored.branchId, kDemoBranch);
      expect(restored.activeRole, issued.activeRole);

      // Authenticated state is genuinely usable: enter the restored scope and
      // read tenant data.
      second.enterScope(
        tenant: restored.tenantId,
        branch: restored.branchId,
      );
      expect(second.students.all(), isNotEmpty);
      second.leaveScope();
    });

    test('logout then restart stays UNAUTHENTICATED', () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      final staff = first.auth.accounts.firstWhere(
        (a) => a.rolesIn(kDemoTenant).any(kStaffRoles.contains),
      );
      first.sessionStore
        ..save(
          first.auth.issueSession(
            account: staff,
            tenant: kDemoTenant,
            branch: kDemoBranch,
          )!,
        )
        ..clear();

      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );

      // The directory is restored — and that must NOT be enough to sign in.
      expect(second.auth.accounts, isNotEmpty);
      expect(
        second.sessionStore.restore(
          accounts: second.auth.accounts,
          now: second.clock.now(),
        ),
        isNull,
        reason:
            'Account persistence must not resurrect a signed-out session. A '
            'restored directory is not a credential.',
      );
    });

    test('an EXPIRED session is still refused after account restore',
        () async {
      // Guards against account persistence accidentally weakening expiry.
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      final staff = first.auth.accounts.firstWhere(
        (a) => a.rolesIn(kDemoTenant).any(kStaffRoles.contains),
      );
      final issued = first.auth.issueSession(
        account: staff,
        tenant: kDemoTenant,
        branch: kDemoBranch,
      )!;
      first.sessionStore.save(issued);

      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      expect(
        second.sessionStore.restore(
          accounts: second.auth.accounts,
          // Well past the 12-hour staff absolute boundary.
          now: issued.startedAt.add(const Duration(hours: 13)),
        ),
        isNull,
      );
    });

    test('a session whose role was revoked between boots is refused',
        () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      final staff = first.auth.accounts.firstWhere(
        (a) => a.rolesIn(kDemoTenant).any(kStaffRoles.contains),
      );
      first.sessionStore.save(
        first.auth.issueSession(
          account: staff,
          tenant: kDemoTenant,
          branch: kDemoBranch,
        )!,
      );

      // Revoke the role directly in storage — what an admin action would do.
      AccountStore(durable).save(
        Account(
          id: staff.id,
          phone: staff.phone,
          displayName: staff.displayName,
          personId: staff.personId,
          roles: const {},
        ),
      );

      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      expect(
        second.sessionStore.restore(
          accounts: second.auth.accounts,
          now: second.clock.now(),
        ),
        isNull,
        reason:
            'The live persisted account is the authorization source — a '
            'revoked role must take effect at next launch.',
      );
    });
  });
}
