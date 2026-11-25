/// **Legacy DOB migration — the idempotent ownership transfer.**
///
/// `ADR-0179` §2 — every v1 student row carries the only DOB that exists for
/// its person, and `StudentRecord` v2 no longer stores one. The migration
/// transfers each recorded DOB to the owning `PersonIdentity` **through
/// BC-10's own write path**, exactly once.
///
/// Rules pinned here (each one is the authorization's own binding):
///
///   * **Preserve every verified value exactly** — day-for-day;
///   * **Never fabricate** — a row without a DOB is skipped; a person with no
///     identity is an **orphan**, reported and never guessed;
///   * **Idempotent** — a re-run transfers nothing (`alreadyOwned`);
///   * **Rollback** — raw student rows are never written or deleted here, so
///     the pre-migration state remains recoverable;
///   * **Undecodable rows are skipped**, never repaired.
library;

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/bootstrap/di.dart';
import 'package:liboora/bootstrap/dob_migration.dart';
import 'package:liboora/platform/data/data.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  Future<({AppContainer c, InMemoryKeyValueStore durable})> world() async {
    final durable = InMemoryKeyValueStore();
    final c = await AppContainer.boot(durable: durable);
    c.enterScope(tenant: const TenantId('t_mig'), branch: const BranchId('b'));
    return (c: c, durable: durable);
  }

  /// Writes a raw v1-format student row directly into the durable namespace —
  /// the exact shape the pre-Option-C codec produced, DOB included.
  void putRawV1Row(
    InMemoryKeyValueStore durable, {
    required String id,
    required String personId,
    String? dateOfBirth,
  }) {
    durable.write(
      'student_records',
      id,
      jsonEncode({
        'id': id,
        'enrollmentNumber': 'STU$id',
        'fullName': 'Legacy $id',
        'phone': '9813300000',
        'dateOfBirth': dateOfBirth,
        'enrolledOn': '2025-09-01T00:00:00.000',
        'personId': personId,
        'status': 'active',
      }),
    );
  }

  test('a v1 DOB is transferred to the owning identity, day-for-day', () async {
    final (:c, :durable) = await world();
    final (personId, _) = c.provisionIdentityForEnrollment(
      phone: '9813300001',
      displayName: 'Migrated Person',
    );
    putRawV1Row(
      durable,
      id: 'stu_legacy_1',
      personId: personId.value,
      dateOfBirth: '1997-04-11T00:00:00.000',
    );

    final report = migrateStudentDobToIdentities(
      durable: durable,
      identityService: c.identityService,
      identities: c.identities,
      recordActor: () => 'test',
    );

    expect(report.migrated, 1);
    expect(report.hasOrphans, isFalse);
    expect(c.identities.resolve(personId)!.dateOfBirth, DateTime(1997, 4, 11));
  });

  test('a re-run transfers nothing — the migration is idempotent', () async {
    final (:c, :durable) = await world();
    final (personId, _) = c.provisionIdentityForEnrollment(
      phone: '9813300002',
      displayName: 'Replay Migrated',
    );
    putRawV1Row(
      durable,
      id: 'stu_legacy_2',
      personId: personId.value,
      dateOfBirth: '1997-04-11T00:00:00.000',
    );
    migrateStudentDobToIdentities(
      durable: durable,
      identityService: c.identityService,
      identities: c.identities,
      recordActor: () => 'test',
    );

    final second = migrateStudentDobToIdentities(
      durable: durable,
      identityService: c.identityService,
      identities: c.identities,
      recordActor: () => 'test',
    );

    expect(second.migrated, 0);
    expect(second.alreadyOwned, 1);
  });

  test(
    'a person with no identity is an orphan — reported, never guessed',
    () async {
      final (:c, :durable) = await world();
      putRawV1Row(
        durable,
        id: 'stu_orphan_1',
        personId: 'per_missing',
        dateOfBirth: '1990-01-01T00:00:00.000',
      );

      final report = migrateStudentDobToIdentities(
        durable: durable,
        identityService: c.identityService,
        identities: c.identities,
        recordActor: () => 'test',
      );

      expect(report.orphans, ['per_missing']);
      expect(report.migrated, 0);
      // The raw row is untouched — the evidence stays on disk.
      expect(
        jsonDecode(durable.readAll('student_records')['stu_orphan_1']!),
        containsPair('dateOfBirth', '1990-01-01T00:00:00.000'),
      );
    },
  );

  test(
    'a row without a DOB is skipped, and counts as nothing transferred',
    () async {
      final (:c, :durable) = await world();
      final (personId, _) = c.provisionIdentityForEnrollment(
        phone: '9813300003',
        displayName: 'Undated Legacy',
      );
      putRawV1Row(durable, id: 'stu_legacy_3', personId: personId.value);

      final report = migrateStudentDobToIdentities(
        durable: durable,
        identityService: c.identityService,
        identities: c.identities,
        recordActor: () => 'test',
      );

      expect(report.rowsScanned, 1);
      expect(report.rowsWithDob, 0);
      expect(report.migrated, 0);
    },
  );

  test('an in-memory world has nothing to migrate', () async {
    final c = await AppContainer.boot();
    c.enterScope(tenant: const TenantId('t_mig'), branch: const BranchId('b'));
    final report = migrateStudentDobToIdentities(
      durable: null,
      identityService: c.identityService,
      identities: c.identities,
      recordActor: () => 'test',
    );
    expect(report.rowsScanned, 0);
    expect(report.migrated, 0);
  });

  test('an undecodable row is skipped, never repaired', () async {
    final (:c, :durable) = await world();
    durable.write('student_records', 'stu_broken', '{not json');

    final report = migrateStudentDobToIdentities(
      durable: durable,
      identityService: c.identityService,
      identities: c.identities,
      recordActor: () => 'test',
    );

    expect(report.migrated, 0);
    expect(
      durable.readAll('student_records')['stu_broken'],
      '{not json',
      reason: 'The row stays exactly as it was; only a verified value moves.',
    );
  });

  test(
    'the boot runs the migration — a restored v1 row lands on BC-10',
    () async {
      final durable = InMemoryKeyValueStore();
      final first = await AppContainer.boot(durable: durable);
      first.enterScope(
        tenant: const TenantId('t_mig'),
        branch: const BranchId('b'),
      );
      final (personId, _) = first.provisionIdentityForEnrollment(
        phone: '9813300004',
        displayName: 'Boot Migrated',
      );
      putRawV1Row(
        durable,
        id: 'stu_boot_1',
        personId: personId.value,
        dateOfBirth: '2001-08-20T00:00:00.000',
      );
      first.leaveScope();

      final second = await AppContainer.boot(durable: durable);
      second.enterScope(
        tenant: const TenantId('t_mig'),
        branch: const BranchId('b'),
      );
      expect(
        second.identities.resolve(personId)!.dateOfBirth,
        DateTime(2001, 8, 20),
      );
      // And the raw row still carries its DOB — preservation until verified.
      expect(
        jsonDecode(durable.readAll('student_records')['stu_boot_1']!),
        containsPair('dateOfBirth', '2001-08-20T00:00:00.000'),
      );
    },
  );
}
