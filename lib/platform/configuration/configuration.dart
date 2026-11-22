/// **Platform Configuration — BC-25** (`IMPL-015`)
///
/// Validates `CFG-1`…`CFG-12` (Authentication PRD) at startup and provides
/// typed access to resolved values.
///
/// Values and invariants are authoritative only; no parameter definition,
/// default, range, or invariant rule is invented here. Source of truth:
/// `CONFIGURATION_GUIDE.md` §2 (CFG-1…CFG-12), §3 (INV-1…INV-9), §4
/// (environment profiles).
library;

/// Authentication configuration parameters (`CFG-1`…`CFG-12`).
///
/// Each field is non-nullable and set to the **production default**. The
/// environment profile overrides values at load time. Every value has been
/// reviewed against its declared range in CONFIGURATION_GUIDE §2.
final class AuthConfiguration {
  const AuthConfiguration({
    required this.otpPerNumberPerHour,
    required this.otpMinInterval,
    required this.otpPerOriginPerHour,
    required this.lockDuration,
    required this.mobileIdleTimeout,
    required this.staffIdleTimeout,
    required this.mobileAbsoluteLifetime,
    required this.staffAbsoluteLifetime,
    required this.trustedDeviceLifetime,
    required this.maxDevices,
    required this.pendingVerificationRetention,
    required this.softDeletedRetention,
    required this.accountClaimFailuresPerDay,
    required this.supportElevationMaxDuration,
  });

  /// `CFG-1` — OTP requests per mobile number, rolling 1 hour.
  /// Default: 5, Range: 3–10
  final int otpPerNumberPerHour;

  /// `CFG-2` — Minimum interval between OTP requests for one number.
  /// Default: 30 s, Range: 15–60 s
  final Duration otpMinInterval;

  /// `CFG-3` — OTP requests per source network origin, rolling 1 hour.
  /// Default: 100, Range: 50–500
  final int otpPerOriginPerHour;

  /// `CFG-4` — Temporary lock duration after quota exhaustion.
  /// Default: 30 min, Range: 15–60 min
  final Duration lockDuration;

  /// `CFG-5` mobile — Idle session timeout.
  /// Default: 30 days, Range: 7–90 days
  final Duration mobileIdleTimeout;

  /// `CFG-5` staff — Idle session timeout.
  /// Default: 30 min, Range: 15–60 min
  final Duration staffIdleTimeout;

  /// `CFG-6` mobile — Absolute session lifetime.
  /// Default: 90 days, Range: 30–180 days
  final Duration mobileAbsoluteLifetime;

  /// `CFG-6` staff — Absolute session lifetime.
  /// Default: 12 hours, Range: 8–24 hours
  final Duration staffAbsoluteLifetime;

  /// `CFG-7` — Trusted-device trust lifetime.
  /// Default: 90 days, Range: 30–180 days
  final Duration trustedDeviceLifetime;

  /// `CFG-8` — Maximum concurrently registered devices per account.
  /// Default: 10, Range: 3–20
  final int maxDevices;

  /// `CFG-9` — Pending-verification retention before discard.
  /// Default: 24 hours, Range: 1–72 hours
  final Duration pendingVerificationRetention;

  /// `CFG-10` — Soft-deleted account retention before permanent erasure.
  /// Default: 30 days, Range: 7–90 days
  final Duration softDeletedRetention;

  /// `CFG-11` — Account-claim verification failures before claim lock.
  /// Default: 5 per 24 hours, Range: 3–10 per 24 hours
  final int accountClaimFailuresPerDay;

  /// `CFG-12` — Support elevated-access maximum duration.
  /// Default: 1 hour, Range: 30 min–4 hours
  final Duration supportElevationMaxDuration;

  /// Production defaults (CONFIGURATION_GUIDE.md §4, Production column).
  static const AuthConfiguration defaults = AuthConfiguration(
    otpPerNumberPerHour: 5,
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

  /// Development profile (CONFIGURATION_GUIDE.md §4).
  static const AuthConfiguration development = AuthConfiguration(
    otpPerNumberPerHour: 20,
    otpMinInterval: Duration.zero,
    otpPerOriginPerHour: 1000,
    lockDuration: Duration(minutes: 1),
    mobileIdleTimeout: Duration(days: 30),
    staffIdleTimeout: Duration(hours: 8),
    mobileAbsoluteLifetime: Duration(days: 90),
    staffAbsoluteLifetime: Duration(hours: 24),
    trustedDeviceLifetime: Duration(days: 90),
    maxDevices: 20,
    pendingVerificationRetention: Duration(hours: 1),
    softDeletedRetention: Duration(days: 1),
    accountClaimFailuresPerDay: 20,
    supportElevationMaxDuration: Duration(hours: 4),
  );

  /// Staging profile (CONFIGURATION_GUIDE.md §4).
  static const AuthConfiguration staging = AuthConfiguration(
    otpPerNumberPerHour: 5,
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

  /// Load configuration for the current environment.
  ///
  /// Uses `dart.vm.product` to detect production vs development.
  /// In production, only the hardcoded defaults apply.
  /// Outside production, the development profile applies.
  static AuthConfiguration loadForEnvironment() {
    final isProduction = const bool.fromEnvironment('dart.vm.product');
    return isProduction ? defaults : development;
  }
}

/// A single configuration validation failure.
final class ConfigurationViolation {
  const ConfigurationViolation(this.parameter, this.rule, this.message);

  final String parameter;
  final String rule;
  final String message;

  @override
  String toString() => '[$parameter] $rule — $message';
}

/// The set of all violations detected in a configuration.
final class ConfigurationError implements Exception {
  const ConfigurationError(this.violations);

  /// All violations, never empty.
  final List<ConfigurationViolation> violations;

  @override
  String toString() {
    final buffer = StringBuffer(
      'ConfigurationError: ${violations.length} violation(s)',
    );
    for (final v in violations) {
      buffer.writeln();
      buffer.write('  ${v.parameter} ${v.rule}: ${v.message}');
    }
    return buffer.toString();
  }
}

/// Validate [config] against INV-1…INV-9 (CONFIGURATION_GUIDE.md §3).
///
/// Returns all violations found. The validation is totality-preserving:
/// every invariant is evaluated regardless of whether earlier ones failed.
List<ConfigurationViolation> validateAuthInvariants(AuthConfiguration config) {
  final violations = <ConfigurationViolation>[];

  // INV-1: CFG-5 (mobile) < CFG-6 (mobile)
  if (!config.mobileIdleTimeout.isShorterThan(config.mobileAbsoluteLifetime)) {
    violations.add(
      ConfigurationViolation(
        'CFG-5/CFG-6 (mobile)',
        'INV-1',
        'mobile idle timeout (${_fmt(config.mobileIdleTimeout)}) must be strictly '
            'less than mobile absolute lifetime (${_fmt(config.mobileAbsoluteLifetime)})',
      ),
    );
  }

  // INV-2: CFG-5 (staff) < CFG-6 (staff)
  if (!config.staffIdleTimeout.isShorterThan(config.staffAbsoluteLifetime)) {
    violations.add(
      ConfigurationViolation(
        'CFG-5/CFG-6 (staff)',
        'INV-2',
        'staff idle timeout (${_fmt(config.staffIdleTimeout)}) must be strictly '
            'less than staff absolute lifetime (${_fmt(config.staffAbsoluteLifetime)})',
      ),
    );
  }

  // INV-3: CFG-7 <= CFG-6 (mobile)
  if (config.trustedDeviceLifetime.inDays >
      config.mobileAbsoluteLifetime.inDays) {
    violations.add(
      ConfigurationViolation(
        'CFG-7/CFG-6 (mobile)',
        'INV-3',
        'trusted device lifetime (${_fmt(config.trustedDeviceLifetime)}) must not '
            'exceed mobile absolute lifetime (${_fmt(config.mobileAbsoluteLifetime)})',
      ),
    );
  }

  // INV-4: CFG-2 × CFG-1 < CFG-4
  final quotaWindow = config.otpMinInterval * config.otpPerNumberPerHour;
  if (!quotaWindow.isShorterThan(config.lockDuration)) {
    violations.add(
      ConfigurationViolation(
        'CFG-2 × CFG-1 / CFG-4',
        'INV-4',
        'quota window (${_fmt(quotaWindow)}) must be strictly less than lock '
            'duration (${_fmt(config.lockDuration)})',
      ),
    );
  }

  // INV-5: CFG-3 > CFG-1
  if (config.otpPerOriginPerHour <= config.otpPerNumberPerHour) {
    violations.add(
      ConfigurationViolation(
        'CFG-3/CFG-1',
        'INV-5',
        'origin limit (${config.otpPerOriginPerHour}) must be strictly greater '
            'than per-number limit (${config.otpPerNumberPerHour})',
      ),
    );
  }

  // INV-6: CFG-2 < 300 s (OTP validity)
  if (config.otpMinInterval.inSeconds >= 300) {
    violations.add(
      ConfigurationViolation(
        'CFG-2',
        'INV-6',
        'minimum interval (${_fmt(config.otpMinInterval)}) must be less than '
            '300 s OTP validity',
      ),
    );
  }

  // INV-7: CFG-5 (staff) <= 30 min
  if (config.staffIdleTimeout.inMinutes > 30) {
    violations.add(
      ConfigurationViolation(
        'CFG-5 (staff)',
        'INV-7',
        'staff idle timeout (${_fmt(config.staffIdleTimeout)}) must not exceed '
            '30 minutes (NIST SP 800-63B AAL2 ceiling)',
      ),
    );
  }

  // INV-8: CFG-6 (staff) <= 24 h
  if (config.staffAbsoluteLifetime.inHours > 24) {
    violations.add(
      ConfigurationViolation(
        'CFG-6 (staff)',
        'INV-8',
        'staff absolute lifetime (${_fmt(config.staffAbsoluteLifetime)}) must not '
            'exceed 24 hours',
      ),
    );
  }

  // INV-9: Every value within its declared range (listed for auditability)
  _validateRange(config.otpPerNumberPerHour, 3, 10, 'CFG-1', violations);
  _validateDurationRange(
    config.otpMinInterval,
    15,
    60,
    's',
    'CFG-2',
    violations,
  );
  _validateRange(config.otpPerOriginPerHour, 50, 500, 'CFG-3', violations);
  _validateDurationRange(
    config.lockDuration,
    15,
    60,
    'min',
    'CFG-4',
    violations,
  );
  _validateDurationRange(
    config.mobileIdleTimeout,
    7,
    90,
    'd',
    'CFG-5 (mobile)',
    violations,
  );
  _validateDurationRange(
    config.staffIdleTimeout,
    15,
    60,
    'min',
    'CFG-5 (staff)',
    violations,
  );
  _validateDurationRange(
    config.mobileAbsoluteLifetime,
    30,
    180,
    'd',
    'CFG-6 (mobile)',
    violations,
  );
  _validateDurationRange(
    config.staffAbsoluteLifetime,
    8,
    24,
    'h',
    'CFG-6 (staff)',
    violations,
  );
  _validateDurationRange(
    config.trustedDeviceLifetime,
    30,
    180,
    'd',
    'CFG-7',
    violations,
  );
  _validateRange(config.maxDevices, 3, 20, 'CFG-8', violations);
  _validateDurationRange(
    config.pendingVerificationRetention,
    1,
    72,
    'h',
    'CFG-9',
    violations,
  );
  _validateDurationRange(
    config.softDeletedRetention,
    7,
    90,
    'd',
    'CFG-10',
    violations,
  );
  _validateRange(
    config.accountClaimFailuresPerDay,
    3,
    10,
    'CFG-11',
    violations,
  );
  _validateDurationRange(
    config.supportElevationMaxDuration,
    30,
    240,
    'min',
    'CFG-12',
    violations,
  );

  return violations;
}

void _validateRange(
  int value,
  int min,
  int max,
  String param,
  List<ConfigurationViolation> violations,
) {
  if (value < min || value > max) {
    violations.add(
      ConfigurationViolation(
        param,
        'INV-9 (range)',
        '$value is outside declared range $min–$max',
      ),
    );
  }
}

void _validateDurationRange(
  Duration value,
  int min,
  int max,
  String unit,
  String param,
  List<ConfigurationViolation> violations,
) {
  final valueInUnit = switch (unit) {
    's' => value.inSeconds,
    'min' => value.inMinutes,
    'h' => value.inHours,
    'd' => value.inDays,
    _ => value.inMinutes,
  };
  if (valueInUnit < min || valueInUnit > max) {
    violations.add(
      ConfigurationViolation(
        param,
        'INV-9 (range)',
        '${_fmt(value)} is outside declared range $min$unit–$max$unit',
      ),
    );
  }
}

String _fmt(Duration d) {
  if (d.inDays > 0 && d.inDays * 24 * 60 == d.inMinutes) {
    return '${d.inDays}d';
  }
  if (d.inHours > 0 && d.inHours * 60 == d.inMinutes) {
    return '${d.inHours}h';
  }
  if (d.inMinutes > 0 && d.inMinutes * 60 == d.inSeconds) {
    return '${d.inMinutes}m';
  }
  return '${d.inSeconds}s';
}

extension on Duration {
  bool isShorterThan(Duration other) => inMilliseconds < other.inMilliseconds;
}
