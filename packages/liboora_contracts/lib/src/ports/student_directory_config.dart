/// Liboora Shared Kernel (R0) — `BC-25` Student Directory configuration port.
///
/// `IMPL-313`. The `LCFG-5` / `SMCFG-1` / `SMCFG-2` configurables that gate
/// the Member Directory (`LMD-4`…`LMD-7`), read through `E-19`
/// (`BC-25` Configuration) with **typed accessors, never raw string lookups**
/// (`LMD-6`, `ADR-0013`).
library;

/// The Member Directory configurables, as a typed surface.
///
/// `BC-25` Configuration is specified by `PRD-023` (FROZEN) but **has no
/// implementation** — `lib/platform/configuration/` implements only the
/// auth-config slice (`CFG-1`…`CFG-12`, `IMPL-015`), and `IMPL-1100`…`1129`
/// are unstarted. Exactly as `IMPL-407` did for the `MM-CFG-*` configurables,
/// the port is declared here at R0 and an adapter carrying the frozen
/// defaults satisfies it until `BC-25` covers library configuration.
///
/// **Why one surface carries `LCFG-5` and the `SMCFG-*` page sizes.** The
/// `PRD-004` traceability matrix records `SMCFG-1` as `LCFG-5`'s directory
/// page size, while `LCFG-5` itself is owned by the Library PRD
/// (`CNF-FR-052`) and the `SMCFG-*` values by `PRD-004` §10.3. One typed
/// surface carrying both keeps the two frozen sources' values structurally
/// consistent — two independently-resolved accessors could drift.
///
/// `LMD-4` — directory exposure **MUST** be gated by `LCFG-5`, whose default
/// is **Disabled** (`AP-3`, deny by default). `LMD-5` — disabling suppresses
/// exposure **without deleting** any record (`LIB-16.6`). `LMD-10` — default
/// page size `SMCFG-1`, maximum `SMCFG-2`; a request exceeding the maximum
/// **MUST** be clamped, not rejected.
abstract interface class StudentDirectoryConfig {
  /// `LCFG-5` — Member Directory exposure. Default **Disabled**.
  ///
  /// Library PRD §16.1: on/off, deny by default (`AP-3`); owned by the
  /// Library PRD (`CNF-FR-052`). While disabled the Directory is suppressed,
  /// not deleted (`LMD-5`, `LIB-16.6`).
  bool get memberDirectoryEnabled;

  /// `SMCFG-1` — default page size of the member list. Default 20 (5–50).
  ///
  /// `PRD-004` §10.3, served to `LMD-10`'s default-page-size limb.
  int get directoryDefaultPageSize;

  /// `SMCFG-2` — maximum page size of the member list. Default 50 (10–100).
  ///
  /// `PRD-004` §10.3, served to `LMD-10`'s clamp limb: a request above this
  /// is clamped, never rejected.
  int get directoryMaxPageSize;
}

/// Adapter carrying the frozen defaults verbatim: `LCFG-5` **Disabled**
/// (Library PRD §16.1), `SMCFG-1` = 20 and `SMCFG-2` = 50 (`PRD-004` §10.3).
///
/// Every value below is the **published default of a frozen requirement**, not
/// a choice made here. Overrides exist so a test can enable the directory or
/// vary one value without inventing a configuration source; production wiring
/// replaces this adapter wholesale once `BC-25` implements library
/// configuration.
final class DefaultStudentDirectoryConfig implements StudentDirectoryConfig {
  const DefaultStudentDirectoryConfig({
    this.memberDirectoryEnabled = false,
    this.directoryDefaultPageSize = 20,
    this.directoryMaxPageSize = 50,
  });

  @override
  final bool memberDirectoryEnabled;
  @override
  final int directoryDefaultPageSize;
  @override
  final int directoryMaxPageSize;
}
