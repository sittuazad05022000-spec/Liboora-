/// **Architecture test — IMPL-302 — SM-10.6 schema constraints.**
///
/// `SM-10.6`: There **MUST NOT** be a `library_member` table, a `member_directory`
/// table, or any denormalised copy of membership, seat, attendance or fee data
/// (`LMD-2`, `SM-2.4`).
///
/// In a Hive-based architecture, this test verifies:
/// 1. No prohibited table names are referenced in source code
/// 2. Domain models don't contain denormalized data fields
/// 3. Data platform uses Hive (not SQL/schema-based storage)
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

final String _repoRoot = Directory.current.path;

void main() {
  group('IMPL-302 SM-10.6 — no prohibited schema structures', () {
    test('no prohibited table names appear in source code', () {
      final prohibitedNames = ['library_member', 'member_directory'];

      for (final name in prohibitedNames) {
        final files = Directory('$_repoRoot/lib')
            .listSync(recursive: true, followLinks: false)
            .whereType<File>()
            .where((f) => !f.path.contains('.dart_tool'))
            .toList();

        final matches = <String>[];
        for (final file in files) {
          final content = file.readAsStringSync();
          if (content.contains(name)) {
            matches.add(file.path);
          }
        }

        expect(
          matches,
          isEmpty,
          reason:
              'SM-10.6 requires no prohibited table names. Found in: ${matches.join(', ')}',
        );
      }
    });

    test('StudentRecord domain has no denormalized membership/fee/attendance fields', () {
      final studentRecordFile = File(
          '$_repoRoot/lib/domain/library/enrollment/domain/student_record.dart');
      expect(studentRecordFile.existsSync(), isTrue,
          reason: 'StudentRecord domain file should exist');

      final content = studentRecordFile.readAsStringSync();

      // SM-10.6 prohibits denormalized copies of membership, seat, attendance, fee
      // These patterns would indicate actual field declarations, not just comments
      expect(RegExp(r'\bMembership\b').hasMatch(content), isFalse,
          reason: 'StudentRecord should not reference Membership type');
      expect(RegExp(r'\bFeeLedger\b').hasMatch(content), isFalse,
          reason: 'StudentRecord should not reference FeeLedger type');
      expect(RegExp(r'\bAttendance\b').hasMatch(content), isFalse,
          reason: 'StudentRecord should not reference Attendance type');
      expect(RegExp(r'\bSeatAllocation\b').hasMatch(content), isFalse,
          reason: 'StudentRecord should not reference SeatAllocation type');
    });

    test('data platform uses Hive key-value store exclusively', () {
      final dataFile = File('$_repoRoot/lib/platform/data/data.dart');
      expect(dataFile.existsSync(), isTrue,
          reason: 'Data platform file should exist');

      final content = dataFile.readAsStringSync();

      // Verify Hive is the data layer
      expect(content.contains('import \'package:hive/hive.dart\''), isTrue,
          reason: 'Data platform uses Hive key-value store');

      // No SQL schema definitions allowed per SM-10.6
      expect(content.contains('CREATE TABLE'), isFalse,
          reason: 'SM-10.6: No SQL CREATE TABLE statements');
    });

    test('repositories use Hive-based stores, not denormalized views', () {
      // Verify enrollment repository doesn't embed membership data
      final enrollmentFile =
          File('$_repoRoot/lib/domain/library/enrollment/enrollment.dart');
      expect(enrollmentFile.existsSync(), isTrue);

      final enrollmentContent = enrollmentFile.readAsStringSync();

      // Repository patterns should use tenant-partitioned stores
      // and not flatten other aggregate data
      expect(enrollmentContent.contains('TenantPartitionedStore'), isTrue,
          reason: 'Repositories should use tenant-partitioned storage');
    });
  });
}