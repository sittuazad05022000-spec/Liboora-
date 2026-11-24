/// `ADR-0179` Option C — Phase 3: DOB ownership transfer at boot.
///
/// Before Option C, `StudentRecord` (BC-01) stored `dateOfBirth` — a
/// deviation from the frozen `SM-4.2`/`SM-4.5` that reserved DOB for BC-10.
/// Every v1 row therefore carries the only DOB that exists for its person.
/// This migration transfers each recorded DOB to the owning
/// `PersonIdentity`, exactly once, through BC-10's own write path.
///
/// Rules the authorization binds:
///  * **Preserve every verified value exactly** — the ISO string is parsed
///    and re-recorded day-for-day, nothing else.
///  * **Never fabricate** — a row without a DOB is skipped (nothing to
///    transfer); a person with no identity is counted as an orphan and
///    reported, never guessed at.
///  * **Idempotent** — the transfer happens only when the identity holds no
///    DOB; a re-run transfers nothing (`migrated == 0`).
///  * **Repeat-safe / rollback** — the raw student rows are never written or
///    deleted here; the old `dateOfBirth` keys stay on disk until a student
///    row is next saved in v2, so the pre-migration state is always
///    recoverable by simply not running this migration.
library;

import 'dart:convert';

import 'package:liboora_contracts/liboora_contracts.dart';

import '../domain/person/person.dart';

/// What the last migration run did, surfaced at boot so an operator can see
/// orphans instead of discovering them as mystery data later.
final class DobMigrationReport {
  DobMigrationReport({
    required this.rowsScanned,
    required this.rowsWithDob,
    required this.migrated,
    required this.alreadyOwned,
    required this.orphans,
  });

  final int rowsScanned;
  final int rowsWithDob;
  final int migrated;
  final int alreadyOwned;

  /// Student rows whose `personId` has no Global Person Identity. Their DOB
  /// is **not** guessed at; the affected personIds are listed.
  final List<String> orphans;

  bool get hasOrphans => orphans.isNotEmpty;

  @override
  String toString() =>
      'DobMigration(rows: $rowsScanned, withDob: $rowsWithDob, '
      'migrated: $migrated, alreadyOwned: $alreadyOwned, '
      'orphans: ${orphans.length}${hasOrphans ? ' ${orphans.take(5)}' : ''})';
}

/// The durable namespace of BC-01 student rows. Declared here so the
/// migration and the store construction in `di.dart` share one constant —
/// a namespace typed at two call sites is a silent data-loss bug the first
/// time the two disagree (the `di.dart` rule, kept honest).
const String kStudentRecordsDurableNamespace = 'student_records';

/// Runs the idempotent DOB transfer. Called from `AppContainer.boot` after
/// both the account/identity directory and the durable stores are restored.
DobMigrationReport migrateStudentDobToIdentities({
  required DurableKeyValueStore? durable,
  required PersonIdentityService identityService,
  required PersonIdentityRepository identities,
  required String Function() recordActor,
}) {
  final report = DobMigrationReport(
    rowsScanned: 0,
    rowsWithDob: 0,
    migrated: 0,
    alreadyOwned: 0,
    orphans: [],
  );
  final durableStore = durable;
  if (durableStore == null) return report; // In-memory world: nothing to migrate.

  for (final raw in durableStore
      .readAll(kStudentRecordsDurableNamespace)
      .values) {
    report.rowsScanned++;
    try {
      final row = jsonDecode(raw) as Map<String, Object?>;
      final dobRaw = row['dateOfBirth'];
      if (dobRaw == null) continue; // v2 row, or a legacy row with no DOB.
      report.rowsWithDob++;
      final personId = PersonId(row['personId']! as String);
      final identity = identities.byPersonId(personId);
      if (identity == null) {
        // Never guess a mapping. The row stays intact on disk; the report
        // surfaces the orphan for the operator.
        report.orphans.add(personId.value);
        continue;
      }
      if (identity.dateOfBirth != null) {
        report.alreadyOwned++;
        continue;
      }
      identityService.recordDateOfBirth(
        personId: personId,
        dateOfBirth: DateTime.parse(dobRaw as String),
        recordedBy: recordActor(),
      );
      report.migrated++;
    } catch (_) {
      continue; // Undecodable row: skipped, never fabricated (restore rule).
    }
  }
  return report;
}
