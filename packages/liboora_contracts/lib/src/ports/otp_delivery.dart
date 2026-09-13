/// Liboora Shared Kernel (R0) — OTP delivery port.
///
/// **Why this port exists.**
///
/// `AuthService` could always *generate* a possession challenge, but nothing in
/// the scaffold ever *delivered* one. The consequence was not a missing feature
/// but a broken critical journey: a release build asked the user for a 6-digit
/// code that existed only inside the process, so `_BoundaryGate` — and with it
/// every staff and student screen — was unreachable.
///
/// The delivery mechanism is an **external dependency** (`IMPL-020`: TRAI DLT
/// registration is a multi-week procurement, not a coding task). That is
/// precisely the situation a port is for: the seam is declared now, at rank 0,
/// so when the gateway arrives it is wired at the composition root and no
/// caller changes.
///
/// **What this port deliberately does NOT do.**
///
/// It is not a bypass. It carries no affordance for reading a code back, and no
/// implementation here may create, seed or authorise an account. `MP-CON-11`
/// forbids demo and guest accounts in any release build, and `MP-GBR-25` makes
/// possession of the number the sole V1 factor — a code the user did not
/// actually receive is not a factor, whoever displays it.
///
/// **Why delivery status is a property of the system, not of a number.**
///
/// [OtpDeliveryChannel.isConfigured] asks whether *this deployment* can deliver
/// at all. It never takes a phone number, so it cannot discriminate a
/// registered number from an unregistered one. That is what keeps defect
/// `F-02` fixed: the answer is identical for every subject, which is the same
/// uniformity property `AuthService.requestOtp` achieves by returning `void`.
library;

/// Transport that carries a possession challenge to its subject.
///
/// Contract:
///   * [deliver] is **fire-and-forget by design**. It returns nothing, so a
///     caller cannot learn from it whether the number is registered, reachable
///     or even well-formed (`F-02`).
///   * [deliver] MUST NOT throw for a business condition. An unreachable
///     number is not an authentication outcome, and a thrown exception would
///     become an observable difference between subjects.
///   * [isConfigured] MUST NOT depend on any subject — see the library note.
///   * An implementation MUST NOT expose the delivered code back to the
///     application through any surface on this interface.
abstract interface class OtpDeliveryChannel {
  /// Whether this deployment can deliver a challenge to anyone at all.
  ///
  /// Uniform across subjects by contract. Intended for an honest
  /// "sign-in is unavailable" state, never for a per-number probe.
  bool get isConfigured;

  /// Stable identifier for diagnostics and telemetry. Never shown as proof
  /// that a particular message was sent.
  String get channelName;

  /// Hand [code] to the transport for [phone]. Returns nothing (`F-02`).
  void deliver({required String phone, required String code});
}

/// The honest default: no transport is wired.
///
/// Chosen as the **default** deliberately. A deployment that forgot to
/// configure delivery now reports that it cannot sign anyone in, instead of
/// silently issuing challenges into a void and leaving the user at a code
/// field that can never be satisfied. Failing loud beats failing quiet.
///
/// It accepts and drops the code rather than throwing, because throwing would
/// make the request path observably different from a configured deployment's.
final class UnconfiguredOtpDelivery implements OtpDeliveryChannel {
  const UnconfiguredOtpDelivery();

  @override
  bool get isConfigured => false;

  @override
  String get channelName => 'unconfigured';

  @override
  void deliver({required String phone, required String code}) {
    // Intentionally empty. See the class note: dropping is uniform, throwing
    // is not.
  }
}

/// Development transport that writes the challenge to an injected sink.
///
/// **Why [enabled] is a constructor argument rather than two separate
/// adapters.** Selecting between a console transport and a null transport with
/// a ternary at the composition root constructs *two* adapters for one port,
/// which `no_orphan_ports_test` rejects: whichever one a consumer receives then
/// depends on wiring order, and the two drift apart. One adapter that knows
/// whether it is switched on keeps the registration singular and the choice
/// explicit.
///
/// ⛔ **This is not a sign-in bypass.** No account is created, no role is
/// granted and no code is returned to the application — it is a transport that
/// terminates in a developer's console instead of a handset. `MP-CON-11`
/// (no demo or guest accounts) and `MP-GBR-25` (possession of the number is the
/// sole factor) are both untouched.
///
/// When [enabled] is false it reports itself unconfigured and delivers
/// nothing, which is the correct release posture until `IMPL-020` lands.
final class DebugConsoleOtpDelivery implements OtpDeliveryChannel {
  DebugConsoleOtpDelivery({required this.enabled, required this.sink});

  /// Whether this deployment may write challenges to [sink]. Expected to be
  /// `false` wherever `dart.vm.product` is true.
  final bool enabled;

  final void Function(String message) sink;

  @override
  bool get isConfigured => enabled;

  @override
  String get channelName => enabled ? 'debug-console' : 'unconfigured';

  @override
  void deliver({required String phone, required String code}) {
    // Dropping rather than throwing when disabled: a thrown exception would
    // make the request path observably different from a configured
    // deployment's, which is a timing and error-shape oracle (F-02).
    if (!enabled) return;
    sink('[OTP] $phone -> $code');
  }
}
