library;

import 'package:flutter_test/flutter_test.dart';
import 'package:liboora_contracts/liboora_contracts.dart';

void main() {
  group('DirectoryConfig', () {
    group('DefaultDirectoryConfig', () {
      test('default page size is 20 (SMCFG-1)', () {
        const config = DefaultDirectoryConfig();
        expect(config.pageSizeDefault, 20);
        expect(config.pageSizeMax, 50);
      });

      test('clampPageSize clamps oversized requests (LMD-10)', () {
        const config = DefaultDirectoryConfig();

        // Within bounds
        expect(config.clampPageSize(5), 5); // minimum
        expect(config.clampPageSize(20), 20); // default
        expect(config.clampPageSize(50), 50); // maximum

        // Oversized - should clamp
        expect(config.clampPageSize(100), 50); // clamped from 100 to 50
        expect(config.clampPageSize(75), 50); // clamped from 75 to 50
        expect(config.clampPageSize(51), 50); // just over limit

        // Below minimum - passed through unchanged (no explicit requirement to modify)
        expect(config.clampPageSize(1), 1);
        expect(config.clampPageSize(0), 0);
        expect(config.clampPageSize(-1), -1);
      });

      test('clampPageSize handles values below minimum unchanged', () {
        const config = DefaultDirectoryConfig();

        // Per LMD-10: only maximum is clamped; below-minimum behavior is unspecified
        expect(config.clampPageSize(1), 1);
        expect(config.clampPageSize(0), 0);
        expect(config.clampPageSize(-5), -5);
      });

      test('clampPageSize accepts boundary values exactly', () {
        const config = DefaultDirectoryConfig();

        // SMCFG-1 range: 5–50
        expect(config.clampPageSize(5), 5); // minimum allowed
        expect(config.clampPageSize(50), 50); // maximum allowed
      });
    });
  });
}