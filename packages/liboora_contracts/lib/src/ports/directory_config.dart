/// Liboora Shared Kernel (R0) — `BC-25` Configuration port for Directory settings.
///
/// `IMPL-312`. The `SMCFG-1` and `SMCFG-2` values are defined by `PRD-004` §10.3 and
/// `PRD-023` Settings & Configuration. This port provides typed accessors; the fake
/// default implementation satisfies the requirements until `BC-25` Configuration is
/// fully implemented.
///
/// Per `LIB-16.2` pattern in `membership_config.dart`: *"building against the port with
/// a fake, never deferred"* — the port is declared here and an adapter carrying the
/// published defaults satisfies it until `BC-25` is implemented.
library;

/// Directory configuration port.
///
/// Reads through `E-19` (`BC-25` Configuration) from `PRD-023`.
abstract interface class DirectoryConfig {
  /// `SMCFG-1` — Directory default page size.
  ///
  /// LMD-10: Default page size **MUST** be `SMCFG-1`.
  /// Required setting value: 20 (range 5–50).
  int get pageSizeDefault;

  /// `SMCFG-2` — Directory maximum page size.
  ///
  /// LMD-10: A request exceeding the maximum **MUST** be clamped, not rejected.
  /// Required setting value: 50 (range 10–100).
  /// All page size requests are clamped to this value.
  int get pageSizeMax;
}

/// Adapter carrying the `PRD-004` §10.3 defaults verbatim.
///
/// Every value below is the **published default of a frozen requirement**, not
/// a choice made here. Overrides exist so a test can vary one value without
/// inventing a configuration source; production wiring replaces this adapter
/// when `BC-25` is implemented.
final class DefaultDirectoryConfig implements DirectoryConfig {
  const DefaultDirectoryConfig({
    this.pageSizeDefault = 20,
    this.pageSizeMax = 50,
  });

  @override
  final int pageSizeDefault;

  @override
  final int pageSizeMax;

  /// Clamps a requested page size to the allowed maximum per LMD-10.
  ///
  /// Per LMD-10: A request exceeding the maximum **MUST** be clamped, not rejected.
  /// Values within the valid range are passed through unchanged.
  /// Values below the minimum (5) are clamped to the minimum.
  int clampPageSize(int requested) {
    if (requested < 5) {
      return 5; // Minimum allowed per SMCFG-1 range (5–50)
    }
    return requested > pageSizeMax ? pageSizeMax : requested;
  }
}