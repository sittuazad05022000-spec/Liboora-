/// **P1 session restore conformance.**
///
/// The behaviour under test: a user who signed in, closed the app and reopened
/// it must land on their dashboard rather than on the OTP screen — and *only*
/// when that is genuinely safe.
///
/// ## What "restart" means here
///
/// A new `SessionStore` (and, in the integration group, a new `AppContainer`)
/// over the **same** `DurableKeyValueStore`. That is what a process restart is
/// from the application's point of view, and it is stricter than reopening a
/// file because it also proves no state survived in a static or a singleton.
///
/// ## The security posture these tests defend
///
/// Restore must be **strictly weaker** than issuing a session. Every test that
/// asserts a successful restore is paired with one asserting a rejection, so a
/// change that makes restore more permissive fails here rather than in
/// production. Nothing in this file supplies a credential, an OTP or a demo
/// account — restore re-presents a session that a completed verification
/// already issued, and re-checks it against live state.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/seed.dart';
import 'package:liboora/bootstrap/session_store.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora/platform/identity/identity.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

final _t0 = DateTime.utc(2026, 4, 1, 9);

const _tenant = TenantId('t_alpha');
const _otherTenant = TenantId('t_beta');
const _branch = BranchId('b_main');

Account _account(
  String id,
  AccessRole role, {
  TenantId tenant = _tenant,
}) => Account(
  id: AccountId(id),
  phone: '98100000$id',
  displayName: 'User $id',
  personId: PersonId('per_$id'),
  roles: {
    tenant.value: {role},
  },
);

AuthSession _session(
  Account account, {
  AccessRole? role,
  DateTime? startedAt,
  DateTime? lastActiveAt,
  TenantId tenant = _tenant,
}) => AuthSession(
  id: const SessionId('sess_1'),
  account: account,
  tenantId: tenant,
  branchId: _branch,
  activeRole: role ?? account.rolesIn(tenant).first,
  startedAt: startedAt ?? _t0,
  lastActiveAt: lastActiveAt,
);

void main() {
  // ═══════════════════════════════════════════════════════════════════
  // 1 — NO SESSION
  // ═══════════════════════════════════════════════════════════════════
  group('no session', () {
    test('empty storage restores nothing', () {
      final store = SessionStore(InMemoryKeyValueStore());
      expect(store.restore(accounts: const [], now: _t0), isNull);
    });

    test('a store with OTHER data but no session restores nothing', () {
      // Guards against a restore that keys off "storage is non-empty".
      final durable = InMemoryKeyValueStore()
        ..write('student_records', 't_alpha::sr_1', '{}');
      final store = SessionStore(durable);
      expect(
        store.restore(accounts: [_account('1', AccessRole.owner)], now: _t0),
        isNull,
      );
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 2 — VALID SESSION RESTORE + RESTART PERSISTENCE
  // ═══════════════════════════════════════════════════════════════════
  group('valid session restores across a restart', () {
    test('a saved staff session is restored by a NEW store instance', () {
      final durable = InMemoryKeyValueStore();
      final account = _account('1', AccessRole.owner);

      SessionStore(durable).save(_session(account));

      // The restart: a different SessionStore object, same storage.
      final restored = SessionStore(durable).restore(
        accounts: [account],
        now: _t0.add(const Duration(minutes: 5)),
      );

      expect(restored, isNotNull);
      expect(restored!.id, const SessionId('sess_1'));
      expect(restored.account.id, const AccountId('1'));
      expect(restored.tenantId, _tenant);
      expect(restored.branchId, _branch);
      expect(restored.activeRole, AccessRole.owner);
      expect(
        restored.startedAt,
        _t0,
        reason:
            'The absolute boundary is anchored to creation (AUTH-6.16), so '
            'startedAt must survive restore unchanged.',
      );
    });

    test('a mobile (student) session restores after 20 days', () {
      // Mobile idle is 30 days: a student visiting fortnightly must not be
      // signed out (CFG-5 rationale).
      final durable = InMemoryKeyValueStore();
      final account = _account('2', AccessRole.student);
      SessionStore(durable).save(_session(account));

      expect(
        SessionStore(durable).restore(
          accounts: [account],
          now: _t0.add(const Duration(days: 20)),
        ),
        isNotNull,
      );
    });

    test('the restored session carries the LIVE account, not the stored one',
        () {
      // The record persists only an account id, so a renamed account must come
      // back renamed rather than stale. This is also what makes a revoked role
      // take effect (AUTH-6.17).
      final durable = InMemoryKeyValueStore();
      final before = _account('3', AccessRole.manager);
      SessionStore(durable).save(_session(before));

      final renamed = Account(
        id: const AccountId('3'),
        phone: '9810000003',
        displayName: 'Renamed Manager',
        personId: const PersonId('per_3'),
        roles: const {
          't_alpha': {AccessRole.manager},
        },
      );

      final restored = SessionStore(
        durable,
      ).restore(accounts: [renamed], now: _t0);
      expect(restored!.account.displayName, 'Renamed Manager');
      expect(restored.account.phone, '9810000003');
    });

    test('the persisted record does not duplicate the account directory', () {
      // A second copy of phone/roles on disk would be a staler source of
      // truth for authorization data.
      final durable = InMemoryKeyValueStore();
      final account = _account('4', AccessRole.owner);
      SessionStore(durable).save(_session(account));

      final raw = durable.readAll(kSessionNamespace)[kSessionKey]!;
      expect(raw, contains('accountId'));
      expect(
        raw,
        isNot(contains('9810000004')),
        reason: 'The phone number must not be written into the session record.',
      );
      expect(raw, isNot(contains('User 4')));
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 3 — EXPIRED SESSIONS (CFG-5 / CFG-6, AUTH-6.18, AC-6.6)
  // ═══════════════════════════════════════════════════════════════════
  group('expired session is never restored', () {
    test('staff IDLE expiry at 30 minutes', () {
      final durable = InMemoryKeyValueStore();
      final account = _account('5', AccessRole.reception);
      SessionStore(durable).save(_session(account));

      // 29 minutes: still live.
      expect(
        SessionStore(durable).restore(
          accounts: [account],
          now: _t0.add(const Duration(minutes: 29)),
        ),
        isNotNull,
      );

      // Re-save, because a rejected restore clears the record.
      SessionStore(durable).save(_session(account));

      // Exactly 30 minutes: expired. The boundary is inclusive — a session is
      // refused AT the limit, not merely after it (AC-6.6).
      expect(
        SessionStore(durable).restore(
          accounts: [account],
          now: _t0.add(const Duration(minutes: 30)),
        ),
        isNull,
      );
    });

    test('staff ABSOLUTE expiry at 12 hours, even with recent activity', () {
      final durable = InMemoryKeyValueStore();
      final account = _account('6', AccessRole.owner);
      // Session created 12h ago but used one minute ago: idle is fine, the
      // absolute ceiling is not. This is the "whichever comes first" limb.
      SessionStore(durable).save(
        _session(
          account,
          startedAt: _t0,
          lastActiveAt: _t0.add(const Duration(hours: 11, minutes: 59)),
        ),
      );

      expect(
        SessionStore(durable).restore(
          accounts: [account],
          now: _t0.add(const Duration(hours: 12)),
        ),
        isNull,
        reason:
            'Activity must not extend the absolute boundary (AUTH-6.16) — '
            'otherwise a stolen session kept warm never dies.',
      );
    });

    test('mobile idle expiry at 30 days', () {
      final durable = InMemoryKeyValueStore();
      final account = _account('7', AccessRole.parent);
      SessionStore(durable).save(_session(account));

      expect(
        SessionStore(durable).restore(
          accounts: [account],
          now: _t0.add(const Duration(days: 30)),
        ),
        isNull,
      );
    });

    test('AUTH-6.19 — a dual-role account gets the SHORTER staff limits', () {
      // The attack this prevents: a staff member whose account also holds a
      // student role obtaining 30-day limits on a shared reception device.
      final dual = Account(
        id: const AccountId('8'),
        phone: '9810000008',
        displayName: 'Owner who is also a student',
        personId: const PersonId('per_8'),
        roles: const {
          't_alpha': {AccessRole.student, AccessRole.owner},
        },
      );
      final durable = InMemoryKeyValueStore();
      // Active role is the NON-staff one, which is the case a naive
      // implementation based on activeRole alone would get wrong.
      SessionStore(durable).save(_session(dual, role: AccessRole.student));

      expect(
        SessionStore(durable).restore(
          accounts: [dual],
          now: _t0.add(const Duration(hours: 1)),
        ),
        isNull,
        reason:
            'Holding ANY staff role must impose staff limits, whatever the '
            'active role is (AUTH-6.19).',
      );
    });

    test('an expired record is CLEARED, so it cannot fail repeatedly', () {
      final durable = InMemoryKeyValueStore();
      final account = _account('9', AccessRole.owner);
      SessionStore(durable).save(_session(account));

      SessionStore(durable).restore(
        accounts: [account],
        now: _t0.add(const Duration(days: 1)),
      );

      expect(durable.readAll(kSessionNamespace), isEmpty);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 4 — INVALID / CORRUPT / REVOKED
  // ═══════════════════════════════════════════════════════════════════
  group('invalid session is rejected without crashing', () {
    test('malformed JSON', () {
      final durable = InMemoryKeyValueStore()
        ..write(kSessionNamespace, kSessionKey, '{not json');
      expect(
        () => SessionStore(durable).restore(accounts: const [], now: _t0),
        returnsNormally,
      );
      expect(
        SessionStore(durable).restore(accounts: const [], now: _t0),
        isNull,
      );
    });

    test('valid JSON, missing required fields', () {
      final durable = InMemoryKeyValueStore()
        ..write(kSessionNamespace, kSessionKey, '{"v":1}');
      expect(
        SessionStore(durable).restore(accounts: const [], now: _t0),
        isNull,
      );
    });

    test('an unknown schema version is treated as corrupt, not guessed', () {
      final durable = InMemoryKeyValueStore()
        ..write(
          kSessionNamespace,
          kSessionKey,
          '{"v":999,"sessionId":"s","accountId":"1","tenantId":"t_alpha",'
              '"branchId":"b_main","activeRole":"owner",'
              '"startedAt":"2026-04-01T09:00:00.000Z",'
              '"lastActiveAt":"2026-04-01T09:00:00.000Z"}',
        );
      expect(
        SessionStore(durable).restore(
          accounts: [_account('1', AccessRole.owner)],
          now: _t0,
        ),
        isNull,
      );
    });

    test('a role that no longer exists in the enum', () {
      final durable = InMemoryKeyValueStore()
        ..write(
          kSessionNamespace,
          kSessionKey,
          '{"v":1,"sessionId":"s","accountId":"1","tenantId":"t_alpha",'
              '"branchId":"b_main","activeRole":"superadmin",'
              '"startedAt":"2026-04-01T09:00:00.000Z",'
              '"lastActiveAt":"2026-04-01T09:00:00.000Z"}',
        );
      expect(
        SessionStore(durable).restore(
          accounts: [_account('1', AccessRole.owner)],
          now: _t0,
        ),
        isNull,
        reason:
            'An unrecognised role must never be honoured — and never silently '
            'downgraded to a default role either.',
      );
    });

    test('a corrupt record is cleared on the way out', () {
      final durable = InMemoryKeyValueStore()
        ..write(kSessionNamespace, kSessionKey, 'garbage');
      SessionStore(durable).restore(accounts: const [], now: _t0);
      expect(durable.readAll(kSessionNamespace), isEmpty);
    });

    test('the account no longer exists', () {
      final durable = InMemoryKeyValueStore();
      SessionStore(durable).save(_session(_account('10', AccessRole.owner)));
      // Deleted account: the directory no longer lists it.
      expect(
        SessionStore(durable).restore(accounts: const [], now: _t0),
        isNull,
      );
    });

    test('the ROLE has been revoked since the session was issued', () {
      final durable = InMemoryKeyValueStore();
      SessionStore(durable).save(_session(_account('11', AccessRole.owner)));

      // Same account id, role removed in this tenant.
      final demoted = Account(
        id: const AccountId('11'),
        phone: '9810000011',
        displayName: 'Demoted',
        personId: const PersonId('per_11'),
        roles: const {},
      );

      expect(
        SessionStore(durable).restore(accounts: [demoted], now: _t0),
        isNull,
        reason:
            'A revoked role must take effect at next launch, not persist until '
            'the session expires (AUTH-6.17).',
      );
    });

    test('the role exists but in a DIFFERENT tenant', () {
      // The cross-tenant case: holding owner at t_beta must not restore a
      // t_alpha session.
      final durable = InMemoryKeyValueStore();
      SessionStore(durable).save(_session(_account('12', AccessRole.owner)));

      final elsewhere = _account(
        '12',
        AccessRole.owner,
        tenant: _otherTenant,
      );
      expect(
        SessionStore(durable).restore(accounts: [elsewhere], now: _t0),
        isNull,
      );
    });

    test('an empty account id is refused', () {
      final durable = InMemoryKeyValueStore()
        ..write(
          kSessionNamespace,
          kSessionKey,
          '{"v":1,"sessionId":"s","accountId":"","tenantId":"t_alpha",'
              '"branchId":"b_main","activeRole":"owner",'
              '"startedAt":"2026-04-01T09:00:00.000Z",'
              '"lastActiveAt":"2026-04-01T09:00:00.000Z"}',
        );
      expect(
        SessionStore(durable).restore(accounts: const [], now: _t0),
        isNull,
      );
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 5 — LOGOUT + RESTART
  // ═══════════════════════════════════════════════════════════════════
  group('logout', () {
    test('clear removes the record', () {
      final durable = InMemoryKeyValueStore();
      final store = SessionStore(durable);
      store.save(_session(_account('13', AccessRole.owner)));
      expect(durable.readAll(kSessionNamespace), isNotEmpty);

      store.clear();
      expect(durable.readAll(kSessionNamespace), isEmpty);
    });

    test('after logout, a restart restores NOTHING', () {
      final durable = InMemoryKeyValueStore();
      final account = _account('14', AccessRole.owner);
      SessionStore(durable)
        ..save(_session(account))
        ..clear();

      expect(
        SessionStore(durable).restore(accounts: [account], now: _t0),
        isNull,
        reason: 'AUTH-6.21 — a terminated session must not be resumable.',
      );
    });

    test('clear on an already-empty store is not an error', () {
      expect(() => SessionStore(InMemoryKeyValueStore()).clear(),
          returnsNormally);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 6 — TENANT / SESSION ISOLATION
  // ═══════════════════════════════════════════════════════════════════
  group('tenant isolation', () {
    test('the restored session names its own tenant, never a default', () {
      final durable = InMemoryKeyValueStore();
      final account = _account('15', AccessRole.owner, tenant: _otherTenant);
      SessionStore(durable).save(_session(account, tenant: _otherTenant));

      final restored = SessionStore(
        durable,
      ).restore(accounts: [account], now: _t0);
      expect(restored!.tenantId, _otherTenant);
    });

    test('the session record does not collide with tenant-scoped data', () {
      // The session lives in its OWN namespace, so it cannot be mistaken for
      // a tenant row nor picked up by TenantPartitionedStore.restore().
      final durable = InMemoryKeyValueStore();
      SessionStore(durable).save(_session(_account('16', AccessRole.owner)));

      expect(durable.readAll('student_records'), isEmpty);
      expect(durable.readAll('fee_ledgers'), isEmpty);
      expect(durable.readAll(kSessionNamespace).keys, [kSessionKey]);
    });

    test('only ONE session is persisted per device', () {
      // AUTH-6.22: this is the current session on this device. A second save
      // replaces the first rather than accumulating.
      final durable = InMemoryKeyValueStore();
      final store = SessionStore(durable);
      store.save(_session(_account('17', AccessRole.owner)));
      store.save(
        _session(_account('18', AccessRole.manager), tenant: _tenant),
      );

      expect(durable.readAll(kSessionNamespace).length, 1);
      final restored = store.restore(
        accounts: [_account('18', AccessRole.manager)],
        now: _t0,
      );
      expect(restored!.account.id, const AccountId('18'));
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 7 — EXPIRY MODEL ON AuthSession ITSELF
  // ═══════════════════════════════════════════════════════════════════
  group('AuthSession expiry model', () {
    test('lastActiveAt defaults to startedAt, never to "now"', () {
      // Defaulting to now would silently extend every session that omitted
      // the field.
      final s = _session(_account('19', AccessRole.owner));
      expect(s.lastActiveAt, s.startedAt);
    });

    test('staff and mobile audiences resolve correctly', () {
      expect(
        _session(_account('20', AccessRole.reception)).isStaffAudience,
        isTrue,
      );
      expect(
        _session(_account('21', AccessRole.student)).isStaffAudience,
        isFalse,
      );
      expect(
        _session(_account('22', AccessRole.parent)).isStaffAudience,
        isFalse,
      );
    });

    test('expiresAt is the EARLIER of the two boundaries', () {
      final staff = _session(_account('23', AccessRole.owner));
      expect(staff.expiresAt, _t0.add(kStaffIdle));

      // Kept active, so idle no longer binds and the absolute ceiling wins.
      final active = _session(
        _account('24', AccessRole.owner),
        lastActiveAt: _t0.add(const Duration(hours: 11, minutes: 45)),
      );
      expect(active.expiresAt, _t0.add(kStaffAbsolute));
    });

    test('touchedAt moves idle but NOT the absolute boundary', () {
      final s = _session(_account('25', AccessRole.owner));
      final later = _t0.add(const Duration(minutes: 20));
      final touched = s.touchedAt(later);

      expect(touched.lastActiveAt, later);
      expect(touched.startedAt, _t0, reason: 'AUTH-6.16.');
      expect(touched.id, s.id, reason: 'Renewal must not re-establish identity.');
      expect(touched.expiresAt, later.add(kStaffIdle));
    });

    test('the normative constants match the specification', () {
      // These are carried from CFG-5/CFG-6; a silent change here would weaken
      // a security control, so it is asserted rather than trusted.
      expect(kStaffIdle, const Duration(minutes: 30));
      expect(kStaffAbsolute, const Duration(hours: 12));
      expect(kMobileIdle, const Duration(days: 30));
      expect(kMobileAbsolute, const Duration(days: 90));
      expect(kStaffIdle < kStaffAbsolute, isTrue,
          reason: 'CFG-5 must be strictly less than CFG-6 or idle never fires.');
      expect(kMobileIdle < kMobileAbsolute, isTrue);
    });
  });

  // ═══════════════════════════════════════════════════════════════════
  // 8 — THROUGH THE REAL CONTAINER
  // ═══════════════════════════════════════════════════════════════════
  group('integration · through AppContainer', () {
    test('the container exposes a session store even without durability',
        () async {
      // Non-nullable field, so no call site needs a null check.
      final c = await AppContainer.boot(seeder: seedDemoData);
      expect(c.sessionStore, isNotNull);
      expect(
        c.sessionStore.restore(accounts: c.auth.accounts, now: _t0),
        isNull,
      );
    });

    test('a session saved in one container is restored by the next', () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );

      // Take a real seeded staff account rather than inventing one.
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

      // Restart.
      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );

      // ⭐ UPDATED: the account directory is now persisted, so this asserts
      // the real thing rather than the gap.
      //
      // When this test was written the directory was an in-memory list that
      // only the seeder populated, the seeder correctly did not run on a
      // second boot, and restore therefore refused. The note left here said:
      // *"if this ever becomes non-empty, account persistence has landed and
      // this test should assert a successful restore against
      // second.auth.accounts directly."* That is exactly what happened, and
      // this is that assertion.
      expect(
        second.auth.accounts,
        isNotEmpty,
        reason: 'The directory is restored from durable storage at boot.',
      );

      final restored = second.sessionStore.restore(
        // The container's OWN directory now — no longer borrowed from the
        // previous boot, which is what makes this genuinely end-to-end.
        accounts: second.auth.accounts,
        now: second.clock.now(),
      );
      expect(restored, isNotNull);
      expect(restored!.account.id, staff.id);
      expect(restored.tenantId, kDemoTenant);
      expect(restored.branchId, kDemoBranch);

      // The fail-closed path is still intact: given a directory that cannot
      // confirm the account, restore must refuse. Asserted on a freshly
      // written record, because a rejecting restore deliberately clears it.
      second.sessionStore.save(issued);
      expect(
        second.sessionStore.restore(
          accounts: const [],
          now: second.clock.now(),
        ),
        isNull,
        reason:
            'Restore must never trust the account snapshot inside its own '
            'record — an unconfirmable account is refused.',
      );
      expect(
        durable.readAll(kSessionNamespace),
        isEmpty,
        reason: 'A refused restore must also clear the record.',
      );
    });

    test('a restored session can immediately read tenant data', () async {
      // The real point of restoring: the user lands on a working dashboard.
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

      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      // Directory from the first boot — see the note in the test above on why
      // `second.auth.accounts` is empty.
      final restored = second.sessionStore.restore(
        accounts: first.auth.accounts,
        now: second.clock.now(),
      )!;

      // Before entering scope, reads must still fail loud.
      second.leaveScope();
      expect(() => second.students.all(), throwsA(isA<TenantContextMissing>()));

      second.enterScope(
        tenant: restored.tenantId,
        branch: restored.branchId,
      );
      expect(second.students.all(), isNotEmpty);
    });

    test('sign-out in one container leaves nothing for the next', () async {
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
      expect(
        second.sessionStore.restore(
          accounts: second.auth.accounts,
          now: second.clock.now(),
        ),
        isNull,
      );
    });

    test('restoring a session does NOT re-seed or disturb persisted data',
        () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      first.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      final studentCount = first.students.all().length;
      first.leaveScope();

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

      final second = await AppContainer.boot(
        seeder: seedDemoData,
        durable: durable,
      );
      second.enterScope(tenant: kDemoTenant, branch: kDemoBranch);
      expect(second.students.all().length, studentCount);
      second.leaveScope();
    });
  });
}
