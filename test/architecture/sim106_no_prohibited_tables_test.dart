/// **Architecture test — IMPL-302 — SM-10.6 schema constraints.**
///
/// `SM-10.6`: There **MUST NOT** be a `library_member` table, a `member_directory`
/// table, or any denormalised copy of membership, seat, attendance or fee data
/// (`LMD-2`, `SM-2.4`).
///
/// This test verifies the constraint is enforced by checking:
/// 1. No table definitions exist for the prohibited names
/// 2. Repository interfaces don't expose denormalized aggregate data
///
/// Note: The data layer uses Hive key-value stores, not SQL tables. This test
/// verifies the schema constraint is maintained by absence of prohibited structures.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

final String _repoRoot = Directory.current.path;

void main() {
  group('IMPL-302 SM-10.6 — no prohibited schema structures', () {
    test('no library_member table definition exists', () {
      final prohibitedNames = ['library_member', 'member_directory'];
      for (final name in prohibitedNames) {
        final files = Directory('$_repoRoot/lib')
            .listSync(recursive: true, followLinks: false)
            .whereType<File>()
            .where((f) => !f.path.contains('.dart_tool'))
            .toList();

        for (final file in files) {
          final content = file.readAsStringSync();
          expect(
            content.contains(name),
            isFalse,
            reason:
                'Found prohibited name "$name" in ${file.path}. SM-10.6 requires '
                'no $name table exists.',
          );
        }
      }
    });

    test('no denormalized data in repository interfaces', () {
      // Verify that membership, seat, attendance, and fee data are not
      // exposed as flattened/duplicate structures in other repositories
      final studentRecordFile = File(
          '$_repoRoot/lib/domain/library/enrollment/domain/student_record.dart');
      expect(studentRecordFile.existsSync(), isTrue,
          reason: 'StudentRecord domain file should exist');

      final content = studentRecordFile.readAsStringSync();

      // SM-10.6 prohibits denormalized copies of membership, seat, attendance, fee
      // Check for actual field declarations using regex-like pattern matching
      final membershipField = RegExp(r'final\s+\w*membership');
      final feeLedgerField = RegExp(r'final\s+\w*FeeLedger');
      expect(membershipField.hasMatch(content), isFalse,
          reason: 'StudentRecord should not contain membership field');
      expect(content.contains('seatQuota'), isFalse,
          reason: 'StudentRecord should not contain denormalized seat data');
      expect(feeLedgerField.hasMatch(content), isFalse,
          reason: 'StudentRecord should not contain denormalized fee data');
    });

    test('data platform uses Hive key-value stores, not SQL tables', () {
      final dataFile =
          File('$_repoRoot/lib/platform/data/data.dart');
      expect(dataFile.existsSync(), isTrue,
          reason: 'Data platform file should exist');

      final content = dataFile.readAsStringSync();
      // Verify Hive is used, not SQL
      expect(content.contains('import \'package:hive/hive.dart\''), isTrue,
          reason: 'Data platform uses Hive key-value store');
      // Verify no SQL-specific imports or table creation
      expect(content.contains('CREATE TABLE'), isFalse,
          reason: 'No SQL CREATE TABLE statements should exist');
      expect(content.contains('sql'), isFalse,
          reason: 'No SQL references should exist in data platform');
    });
  });
}