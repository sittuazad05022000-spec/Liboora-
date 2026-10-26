/// **Architecture test — IMPL-309 — SM-AC-27 FileRef-only storage.**
///
/// `SM-4.9` — Every document **MUST** be stored as a `FileRef` issued by
/// `BC-29` through `E-22` (`SM-INV-10`).
/// `SM-4.10` — This module **MUST NOT** store bytes, a raw storage path or a
/// signed URL.
///
/// `SM-AC-27`: Documents are `FileRef`s; **no byte or path is stored** (schema
/// scan).
///
/// A byte- or path-based reference would be a direct transport leak: the domain
/// must never hold the bytes, the filesystem path, or a signed URL.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

final String _repoRoot = Directory.current.path;

/// Forbidden transport representations that would violate `SM-4.10`. These are
/// the exact storage leaks the requirement forbids:
///   * byte arrays / `Uint8List` / binary buffers
///   * raw filesystem paths (`/var/...`)
///   * cloud storage paths (`/bucket/...`)
///   * signed URLs (`?signature=` / signed-token patterns)
///   * file extensions interpreted as payload containers (`base64`, `blob`)
const List<String> _forbiddenRepresentations = [
  // bytes and binary payloads
  'Uint8List',
  'ByteData',
  'List<int>',
  'base64',
  'blob',
  'getBytes',
  'readAsBytes',
  'toBytes',
  // raw filesystem paths
  '/tmp/',
  '/var/',
  '/home/',
  r'C:\\',
  '/mnt/',
  // cloud object paths and signed URLs
  '.amazonaws.com',
  'cloudfront.net',
  'blob.core.windows.net',
  '?signature=',
  'signature=',
  'X-Amz-Signature',
  'x-ms',
  // URL-like payloads that would be stored as document content
  'https://',
  'http://',
];

void main() {
  group('IMPL-309 SM-AC-27 — FileRef-only storage (no bytes/path)', () {
    test('domain student record carries no byte/path payload fields', () {
      final studentRecordFile = File(
          '$_repoRoot/lib/domain/library/enrollment/domain/student_record.dart');
      expect(studentRecordFile.existsSync(), isTrue,
          reason: 'StudentRecord domain file should exist');

      final content = studentRecordFile.readAsStringSync();

      // The only document field is a typed reference.
      expect(content.contains('photoRef'), isTrue,
          reason: 'StudentRecord must hold a photo reference');

      // Verify the reference is a FileRef (typed reference), not raw bytes or
      // a path. This is the actual contract — a FileRef is an Identifier,
      // never a payload.
      expect(content.contains('FileRef'), isTrue,
          reason: 'Photo must be a FileRef per SM-4.9');

      for (final forbidden in _forbiddenRepresentations) {
        expect(
          content.contains(forbidden),
          isFalse,
          reason:
              'SM-4.10 forbids $forbidden in the student record domain model. '
              'Document bytes/path would be a transport leak.',
        );
      }
    });

    test('enrollment repository uses tenant-partitioned store, never bytes', () {
      final enrollmentFile =
          File('$_repoRoot/lib/domain/library/enrollment/enrollment.dart');
      expect(enrollmentFile.existsSync(), isTrue,
          reason: 'Enrollment repository file should exist');

      final content = enrollmentFile.readAsStringSync();

      expect(
        content.contains('TenantPartitionedStore'),
        isTrue,
        reason:
            'Enrollment repository must use tenant-partitioned storage per X-13',
      );

      for (final forbidden in _forbiddenRepresentations) {
        expect(
          content.contains(forbidden),
          isFalse,
          reason:
              'SM-4.10 forbids $forbidden in the enrollment repository. '
              'Document bytes/path would be a transport leak.',
        );
      }
    });

    test('codecs serialize FileRef as opaque value only', () {
      final codecsFile = File('$_repoRoot/lib/bootstrap/codecs.dart');
      expect(codecsFile.existsSync(), isTrue,
          reason: 'Codecs file should exist');

      final content = codecsFile.readAsStringSync();

      // photoRef is serialized as a string reference, not decoded from bytes.
      expect(content.contains("photoRef"), isTrue,
          reason: 'photoRef must be serialized');

      expect(
        content.contains('photoRef: m[\'photoRef\'] == null ? null : FileRef('),
        isTrue,
        reason:
            'photoRef round-trips as a FileRef reference; bytes must never be decoded',
      );

      for (final forbidden in _forbiddenRepresentations) {
        expect(
          content.contains(forbidden),
          isFalse,
          reason:
              'SM-4.10 forbids $forbidden in the serialization layer. '
              'Document bytes/path would be a transport leak.',
        );
      }
    });

    test('FileRef is a typed reference (Identifier), never a payload', () {
      final identifiersFile =
          File('$_repoRoot/packages/liboora_contracts/lib/src/value_objects/identifiers.dart');
      expect(identifiersFile.existsSync(), isTrue,
          reason: 'Value objects file should exist');

      final content = identifiersFile.readAsStringSync();

      // Find the FileRef definition.
      final start = content.indexOf('// The domain holds this');
      final end = content.indexOf('}', start + start);
      final refSection = content.substring(start, end + 1);

      expect(content.contains('FileRef extends Identifier'), isTrue,
          reason: 'FileRef must extend Identifier (typed reference)');

      // FileRef carries no payload fields — no bytes, path or URL field.
      expect(refSection.contains('Uint8List'), isFalse,
          reason: 'FileRef must not carry bytes');
      expect(refSection.contains('path'), isFalse,
          reason: 'FileRef must not carry a path');
      expect(refSection.contains('url'), isFalse,
          reason: 'FileRef must not carry a URL');

      for (final forbidden in _forbiddenRepresentations) {
        expect(
          refSection.contains(forbidden),
          isFalse,
          reason:
              'FileRef must not carry $forbidden. A reference is opaque by construction.',
        );
      }
    });

    test('domain has no denormalized document bytes in any aggregate', () {
      final libDir = Directory('$_repoRoot/lib/domain');
      final files = libDir
          .listSync(recursive: true, followLinks: false)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .where((f) => !f.path.contains('invariants'))
          .toList();

      expect(
        files,
        isNotEmpty,
        reason: 'Should scan at least one domain file for document fields',
      );

      for (final file in files) {
        final content = file.readAsStringSync();

        for (final forbidden in _forbiddenRepresentations) {
          // These are declaration-level patterns; a `contains` on a string
          // literal or variable name still flags the leak pattern we forbid.
          if (content.contains(forbidden)) {
            fail(
              'SM-4.10: $forbidden found in domain file ${file.path}. '
              'Document bytes/path must never enter the domain.',
            );
          }
        }
      }
    });
  });
}