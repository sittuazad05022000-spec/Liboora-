import 'package:flutter_test/flutter_test.dart';
import 'package:liboora/platform/configuration/configuration.dart';

void main() {
  group('AuthConfiguration.defaults', () {
    test('passes all INV-1…INV-9 checks', () {
      final violations = validateAuthInvariants(AuthConfiguration.defaults);
      expect(violations, isEmpty, reason: _formatViolations(violations));
    });
  });

  group('INV-1 — mobile idle < mobile absolute', () {
    test('fails when idle equals absolute', () {
      final cfg = _withMobileIdleAbsolute(30, 30);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-1');
    });

    test('fails when idle exceeds absolute', () {
      final cfg = _withMobileIdleAbsolute(60, 30);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-1');
    });

    test('passes when idle is strictly less', () {
      final cfg = _withMobileIdleAbsolute(29, 90);
      final violations = validateAuthInvariants(cfg);
      _expectNoViolation(violations, 'INV-1');
    });
  });

  group('INV-2 — staff idle < staff absolute', () {
    test('fails when idle equals absolute', () {
      final cfg = _withStaffIdleAbsolute(12, 12);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-2');
    });

    test('fails when idle exceeds absolute', () {
      final cfg = _withStaffIdleAbsolute(20, 12);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-2');
    });

    test('passes when idle is strictly less', () {
      final cfg = _withStaffIdleAbsolute(29, 30);
      final violations = validateAuthInvariants(cfg);
      _expectNoViolation(violations, 'INV-2');
    });
  });

  group('INV-3 — trusted device lifetime <= mobile absolute', () {
    test('fails when device trust exceeds mobile absolute', () {
      final cfg = _withTrustedDeviceAndMobileAbsolute(120, 90);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-3');
    });

    test('passes when device trust equals mobile absolute', () {
      final cfg = _withTrustedDeviceAndMobileAbsolute(90, 90);
      final violations = validateAuthInvariants(cfg);
      _expectNoViolation(violations, 'INV-3');
    });

    test('passes when device trust is less', () {
      final cfg = _withTrustedDeviceAndMobileAbsolute(60, 90);
      final violations = validateAuthInvariants(cfg);
      _expectNoViolation(violations, 'INV-3');
    });
  });

  group('INV-4 — CFG-2 × CFG-1 < CFG-4', () {
    test('fails when quota window equals lock duration', () {
      final cfg = _withOtpQuotaAndLock(30, 5, 150);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-4');
    });

    test('fails when quota window exceeds lock duration', () {
      final cfg = _withOtpQuotaAndLock(60, 10, 300);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-4');
    });

    test('passes when quota window is strictly less than lock', () {
      final cfg = _withOtpQuotaAndLock(30, 5, 1800);
      final violations = validateAuthInvariants(cfg);
      _expectNoViolation(violations, 'INV-4');
    });
  });

  group('INV-5 — CFG-3 > CFG-1', () {
    test('fails when origin limit equals per-number limit', () {
      final cfg = _withOriginAndPerNumber(5, 5);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-5');
    });

    test('fails when origin limit is less than per-number', () {
      final cfg = _withOriginAndPerNumber(3, 10);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-5');
    });

    test('passes when origin limit exceeds per-number', () {
      final cfg = _withOriginAndPerNumber(100, 5);
      final violations = validateAuthInvariants(cfg);
      _expectNoViolation(violations, 'INV-5');
    });
  });

  group('INV-6 — CFG-2 < 300 s OTP validity', () {
    test('fails when interval is 300 s', () {
      final cfg = _withMinInterval(300);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-6');
    });

    test('fails when interval exceeds 300 s', () {
      final cfg = _withMinInterval(400);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-6');
    });

    test('passes when interval is strictly less than 300 s', () {
      final cfg = _withMinInterval(299);
      final violations = validateAuthInvariants(cfg);
      _expectNoViolation(violations, 'INV-6');
    });
  });

  group('INV-7 — staff idle <= 30 min', () {
    test('fails when staff idle exceeds 30 min', () {
      final cfg = _withStaffIdle(Duration(minutes: 31));
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-7');
    });

    test('passes when staff idle equals 30 min', () {
      final cfg = _withStaffIdle(Duration(minutes: 30));
      final violations = validateAuthInvariants(cfg);
      _expectNoViolation(violations, 'INV-7');
    });

    test('passes when staff idle is under 30 min', () {
      final cfg = _withStaffIdle(Duration(minutes: 15));
      final violations = validateAuthInvariants(cfg);
      _expectNoViolation(violations, 'INV-7');
    });
  });

  group('INV-8 — staff absolute <= 24 h', () {
    test('fails when staff absolute exceeds 24 h', () {
      final cfg = _withStaffAbsolute(Duration(hours: 25));
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'INV-8');
    });

    test('passes when staff absolute equals 24 h', () {
      final cfg = _withStaffAbsolute(Duration(hours: 24));
      final violations = validateAuthInvariants(cfg);
      _expectNoViolation(violations, 'INV-8');
    });

    test('passes when staff absolute is under 24 h', () {
      final cfg = _withStaffAbsolute(Duration(hours: 12));
      final violations = validateAuthInvariants(cfg);
      _expectNoViolation(violations, 'INV-8');
    });
  });

  group('INV-9 — value ranges', () {
    test('fails CFG-1 below minimum (2)', () {
      final cfg = _withOtpPerNumber(2);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'CFG-1');
    });

    test('fails CFG-1 above maximum (11)', () {
      final cfg = _withOtpPerNumber(11);
      final violations = validateAuthInvariants(cfg);
      _expect(violations, 'CFG-1');
    });

    test('passes CFG-1 at boundaries (3 and 10)', () {
      expect(validateAuthInvariants(_withOtpPerNumber(3)), isEmpty);
      expect(validateAuthInvariants(_withOtpPerNumber(10)), isEmpty);
    });
  });

  group('ConfigurationError', () {
    test('toString lists all violations', () {
      final cfg = _withMobileIdleAbsolute(60, 30);
      final violations = validateAuthInvariants(cfg);
      final error = ConfigurationError(violations);
      final str = error.toString();
      expect(str, contains('INV-1'));
      expect(str, contains('mobile idle timeout'));
    });

    test('constructor accepts non-empty list', () {
      final violations = [
        const ConfigurationViolation('CFG-1', 'INV-9', 'out of range'),
      ];
      expect(ConfigurationError(violations).violations, hasLength(1));
    });
  });

  group('AuthConfiguration profiles', () {
    test('production defaults pass all invariants', () {
      final violations = validateAuthInvariants(AuthConfiguration.defaults);
      expect(violations, isEmpty, reason: _formatViolations(violations));
    });

    test('development profile passes all invariants', () {
      final violations = validateAuthInvariants(AuthConfiguration.development);
      expect(violations, isEmpty, reason: _formatViolations(violations));
    });

    test('staging profile passes all invariants', () {
      final violations = validateAuthInvariants(AuthConfiguration.staging);
      expect(violations, isEmpty, reason: _formatViolations(violations));
    });

    test('development profile uses dev overrides', () {
      final cfg = AuthConfiguration.development;
      expect(cfg.otpPerNumberPerHour, 20);
      expect(cfg.otpPerOriginPerHour, 1000);
      expect(cfg.staffIdleTimeout, Duration(hours: 8));
      expect(cfg.otpMinInterval, Duration.zero);
    });

    test('defaults use production values', () {
      final cfg = AuthConfiguration.defaults;
      expect(cfg.otpPerNumberPerHour, 5);
      expect(cfg.staffIdleTimeout, Duration(minutes: 30));
      expect(cfg.staffAbsoluteLifetime, Duration(hours: 12));
    });
  });
}

// ── Helpers ─────────────────────────────────────────────────────────────────

String _formatViolations(List<ConfigurationViolation> violations) =>
    violations.map((v) => '${v.parameter} ${v.rule}: ${v.message}').join('; ');

void _expect(List<ConfigurationViolation> violations, String rule) {
  expect(
    violations.any((v) => v.rule == rule),
    isTrue,
    reason:
        'Expected $rule violation but got none. '
        'Violations: ${_formatViolations(violations)}',
  );
}

void _expectNoViolation(List<ConfigurationViolation> violations, String rule) {
  expect(
    violations.any((v) => v.rule == rule),
    isFalse,
    reason:
        'Unexpected $rule violation. '
        'Violations: ${_formatViolations(violations)}',
  );
}

AuthConfiguration _withMobileIdleAbsolute(int idleDays, int absoluteDays) {
  return AuthConfiguration(
    otpPerNumberPerHour: 5,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: idleDays),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: absoluteDays),
    staffAbsoluteLifetime: Duration(hours: 12),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withStaffIdleAbsolute(int idleHours, int absoluteHours) {
  return AuthConfiguration(
    otpPerNumberPerHour: 5,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(hours: idleHours),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: absoluteHours),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withTrustedDeviceAndMobileAbsolute(
  int deviceDays,
  int mobileAbsoluteDays,
) {
  return AuthConfiguration(
    otpPerNumberPerHour: 5,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: mobileAbsoluteDays),
    staffAbsoluteLifetime: Duration(hours: 12),
    trustedDeviceLifetime: Duration(days: deviceDays),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withOtpQuotaAndLock(
  int intervalSeconds,
  int perNumber,
  int lockSeconds,
) {
  return AuthConfiguration(
    otpPerNumberPerHour: perNumber,
    otpMinInterval: Duration(seconds: intervalSeconds),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(seconds: lockSeconds),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: 12),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withOriginAndPerNumber(int origin, int perNumber) {
  return AuthConfiguration(
    otpPerNumberPerHour: perNumber,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: origin,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: 12),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withMinInterval(int seconds) {
  return AuthConfiguration(
    otpPerNumberPerHour: 5,
    otpMinInterval: Duration(seconds: seconds),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: 12),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withStaffIdle(Duration idle) {
  return AuthConfiguration(
    otpPerNumberPerHour: 5,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: idle,
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: 24),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withStaffAbsolute(Duration absolute) {
  return AuthConfiguration(
    otpPerNumberPerHour: 5,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: absolute,
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withOtpPerNumber(int n) {
  return AuthConfiguration(
    otpPerNumberPerHour: n,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: 12),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

void _expectNoViolation(List<ConfigurationViolation> violations, String rule) {
  expect(
    violations.any((v) => v.rule == rule),
    isFalse,
    reason:
        'Unexpected violation of $rule. Violations: ${_formatViolations(violations)}',
  );
}

/// Build a config with only mobileIdleTimeout and mobileAbsoluteLifetime changed.
AuthConfiguration _withMobileIdleAbsolute(int idleDays, int absoluteDays) {
  return AuthConfiguration(
    otpPerNumberPerHour: 5,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: idleDays),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: absoluteDays),
    staffAbsoluteLifetime: Duration(hours: 12),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withStaffIdleAbsolute(int idleHours, int absoluteHours) {
  return AuthConfiguration(
    otpPerNumberPerHour: 5,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(hours: idleHours),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: absoluteHours),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withTrustedDeviceAndMobileAbsolute(
  int deviceDays,
  int mobileAbsoluteDays,
) {
  return AuthConfiguration(
    otpPerNumberPerHour: 5,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: mobileAbsoluteDays),
    staffAbsoluteLifetime: Duration(hours: 12),
    trustedDeviceLifetime: Duration(days: deviceDays),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withOtpQuotaAndLock(
  int intervalSeconds,
  int perNumber,
  int lockSeconds,
) {
  return AuthConfiguration(
    otpPerNumberPerHour: perNumber,
    otpMinInterval: Duration(seconds: intervalSeconds),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(seconds: lockSeconds),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: 12),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withOriginAndPerNumber(int origin, int perNumber) {
  return AuthConfiguration(
    otpPerNumberPerHour: perNumber,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: origin,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: 12),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withMinInterval(int seconds) {
  return AuthConfiguration(
    otpPerNumberPerHour: 5,
    otpMinInterval: Duration(seconds: seconds),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: 12),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withStaffIdle(Duration idle) {
  return AuthConfiguration(
    otpPerNumberPerHour: 5,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: idle,
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: 24),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withStaffAbsolute(Duration absolute) {
  return AuthConfiguration(
    otpPerNumberPerHour: 5,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: absolute,
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}

AuthConfiguration _withOtpPerNumber(int n) {
  return AuthConfiguration(
    otpPerNumberPerHour: n,
    otpMinInterval: Duration(seconds: 30),
    otpPerOriginPerHour: 100,
    lockDuration: Duration(minutes: 30),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(minutes: 30),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: 12),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 10,
    pendingVerificationRetention: Duration(hours: 24),
    softDeletedRetention: Duration(days: 30),
    accountClaimFailuresPerDay: 5,
    supportElevationMaxDuration: Duration(hours: 1),
  );
}
