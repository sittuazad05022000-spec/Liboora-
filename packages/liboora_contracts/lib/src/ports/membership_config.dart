/// Liboora Shared Kernel (R0) — `BC-02` Membership configuration port.
///
/// `IMPL-407`. The nine `MM-CFG-*` configurables of FROZEN `PRD-005` v1.4
/// §13.4, read through `E-19` (`BC-25` Configuration) with **typed
/// accessors, never raw string lookups**.
library;

/// The nine `MM-CFG-*` values, as a typed surface.
///
/// `BC-25` Configuration is specified by `PRD-023` (FROZEN) but **has no
/// implementation** — `lib/platform/` contains no configuration module, and
/// `IMPL-1100`…`1129` are unstarted. The task document requires exactly this
/// situation to be handled by building *"against the port with a fake, never
/// deferred"*, so the port is declared here at R0 and an adapter carrying the
/// §13.4 defaults satisfies it until `BC-25` exists.
///
/// Declared as one port rather than nine, because `MM-BR-026` requires
/// `MM-CFG-008` to be the **single** threshold shared by `MM-EVT-006` and the
/// expiring-memberships view: two independently-resolved accessors that
/// happen to return the same number would pass a naive test and still break
/// the rule. One source makes the shared value structural.
abstract interface class MembershipConfig {
  /// `MM-CFG-001` — tenant default currency. Default `INR`.
  String get defaultCurrency;

  /// `MM-CFG-002` — max staleness of cached enrollment state. Default 5s.
  Duration get maxEnrollmentStaleness;

  /// `MM-CFG-003` — max back-dating of `startDate`, in days. Default 7.
  int get maxBackdateDays;

  /// `MM-CFG-004` — max forward-dating of `startDate`, in days. Default 90.
  int get maxForwardDateDays;

  /// `MM-CFG-005` — idempotency record retention. Default 30 days.
  Duration get idempotencyRetention;

  /// `MM-CFG-006` — tenant timezone. Default `Asia/Kolkata`.
  ///
  /// An IANA zone name. `MM-FR-061` requires all term arithmetic to use this,
  /// never the server's and never the client's.
  String get tenantTimezone;

  /// `MM-CFG-007` — `PendingPayment` auto-void window. Default 7 days.
  Duration get pendingPaymentVoidWindow;

  /// `MM-CFG-008` — expiring-soon threshold, in days. Default 7.
  ///
  /// `MM-BR-026`: the single value behind both `MM-EVT-006` and the expiring
  /// view. Read it here; never re-declare a second threshold.
  int get expiringSoonDays;

  /// `MM-CFG-009` — re-derive the whole term from the activation date on
  /// delayed payment. Default `false`.
  bool get reDeriveTermOnDelayedActivation;
}

/// Adapter carrying the `PRD-005` §13.4 defaults verbatim.
///
/// Every value below is the **published default of a frozen requirement**, not
/// a choice made here. Overrides exist so a test can vary one value without
/// inventing a configuration source; production wiring replaces this adapter
/// wholesale once `BC-25` is implemented.
final class DefaultMembershipConfig implements MembershipConfig {
  const DefaultMembershipConfig({
    this.defaultCurrency = 'INR',
    this.maxEnrollmentStaleness = const Duration(seconds: 5),
    this.maxBackdateDays = 7,
    this.maxForwardDateDays = 90,
    this.idempotencyRetention = const Duration(days: 30),
    this.tenantTimezone = 'Asia/Kolkata',
    this.pendingPaymentVoidWindow = const Duration(days: 7),
    this.expiringSoonDays = 7,
    this.reDeriveTermOnDelayedActivation = false,
  });

  @override
  final String defaultCurrency;
  @override
  final Duration maxEnrollmentStaleness;
  @override
  final int maxBackdateDays;
  @override
  final int maxForwardDateDays;
  @override
  final Duration idempotencyRetention;
  @override
  final String tenantTimezone;
  @override
  final Duration pendingPaymentVoidWindow;
  @override
  final int expiringSoonDays;
  @override
  final bool reDeriveTermOnDelayedActivation;
}
