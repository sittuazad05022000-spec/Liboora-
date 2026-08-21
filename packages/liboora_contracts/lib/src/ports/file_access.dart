/// Liboora Shared Kernel (R0) — `files` port: the `E-22` boundary, executable.
///
/// Declared as `platform/services:files` at `tool/module_dependencies.yaml`
/// **L242**, and recorded there at **L649** as one of *"five service ports …
/// only the interfaces are missing"* (`ADR-0012`, the `B-7` shape). `ADR-0059`
/// extracts the interface.
///
/// **What this port is for.** Frozen `FIL-FR-006` reads:
///
/// > The module SHALL serve a caller only where the caller's bounded context
/// > appears in `E-22`'s consumer list as recorded in BC Map §7.3. A caller
/// > whose context is absent SHALL be refused.
///
/// `ADR-0055` closed the *architecture* half of `FIL-GAP-012` by adding `BC-12`
/// to that list; this file closes the *implementation* half by making the rule
/// **executable**. Before it existed, the rule was authorised and specified but
/// nothing refused anybody.
///
/// **What this port deliberately cannot do.** It has no widening surface — no
/// setter, no `allow()`, no constructor parameter for the consumer set. That is
/// how frozen `FIL-FR-007` (*"SHALL NOT widen `E-22`'s consumer list, and SHALL
/// NOT treat a port grant in `tool/module_dependencies.yaml` as authorising an
/// edge the BC Map does not record"*) is enforced by the **shape** of the API
/// rather than by a comment: a caller cannot widen what it cannot address.
library;

import '../errors/domain_error.dart';
import '../value_objects/identifiers.dart';

/// A bounded context, as the identifier the BC Map uses for it.
///
/// Deliberately a value object over the `BC-nn` token rather than an `enum` of
/// all 31 contexts: this port's business is *membership of one list*, and an
/// exhaustive enum would invite a `switch` that quietly acquires per-context
/// behaviour — which is how a boundary guard turns into a policy engine.
final class BoundedContextId {
  const BoundedContextId(this.value);

  final String value;

  @override
  bool operator ==(Object other) =>
      other is BoundedContextId && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}

/// `E-22`'s consumer list, transcribed from **BC Map L331** (v1.8).
///
/// ⚠ **This is a COPY of a Rank 4 register, not an independent decision.** The
/// authority is the map; if the two disagree, the map wins and this constant is
/// wrong. That is not left to discipline: an architecture test
/// (`e22_consumer_list_test.dart`) **parses `E-22`'s consumer cell out of the
/// BC Map** and asserts equality with this set, so neither can move alone.
///
/// Current membership and why each is here:
///
///  * `BC-01` Enrollment — original consumer.
///  * `BC-10` Global Person Identity — added by `ADR-0016` for `SID-4.35`
///    (the global profile photo). **Global-class**: this is why the port takes
///    no tenant identifier (see [FileAccess]).
///  * `BC-12` Messaging — added by `ADR-0055` for `FIL-FR-075`…`082`, V1
///    student-to-student sharing. It owns the `Message` that carries the
///    `FileRef`.
///  * `BC-14` Content Sharing — original consumer (V2 context).
///
/// ⛔ **`BC-11` Social Graph and `BC-13` Trust & Safety are absent BY DECISION,
/// not by omission.** `ADR-0055` §3 tested necessity per context: `BC-11`
/// answers eligibility as a boolean and never holds a `FileRef`; `BC-13`
/// reaches File & Media *outbound* over `E-14`. Adding either requires its own
/// ADR. This matters because `tool/module_dependencies.yaml` **L242** grants
/// the whole `domain/social` module the port — so the module-grained manifest
/// would admit all three, and this context-grained list is what refuses two of
/// them (`GCP-23`, disclosed and unrepaired).
const Set<String> e22ConsumerContexts = {'BC-01', 'BC-10', 'BC-12', 'BC-14'};

/// An eligibility decision made and recorded **elsewhere**.
///
/// `FIL-FR-076` requires the authorization decision to be **recorded, not
/// re-derived**. This is an opaque reference to the owning context's decision,
/// never a boolean this module could have computed: a second `canMessage`
/// evaluation could disagree with `BC-11`'s, which is the Matrix `X-13` hazard.
///
/// The value is opaque here on purpose. `FIL-XC-019` forbids this module from
/// storing or interpreting friendship, blocking or `canMessage` state, so the
/// port must be unable to read meaning out of it.
final class EligibilityDecisionRef {
  const EligibilityDecisionRef(this.value);

  final String value;

  @override
  bool operator ==(Object other) =>
      other is EligibilityDecisionRef && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'EligibilityDecisionRef($value)';
}

/// The `E-22` boundary.
///
/// **Tenancy — and why there is none here.** This port carries **no** tenant
/// identifier, and that is a requirement rather than an omission: `E-22`
/// already serves the **global-class** consumer `BC-10` (BC Map §11 makes
/// `BC-10` and `BC-11`…`BC-17` global, *"No `tenantId`"*, rule `ID-2`), so a
/// mandatory tenant parameter would be unsatisfiable for `BC-10` and would
/// breach frozen `TEN-FR-018` (*"Forbidden in global contexts"*). Tenant-scoped
/// callers inherit the ambient `TenantContext` exactly as they do everywhere
/// else. **No tenancy rule is created, relaxed, or invented here**
/// (`ADR-0059` §3.6).
///
/// **What this port refuses to know**, so ownership cannot drift into `BC-29`:
///
/// | Not accepted, not exposed | Owner | Rule |
/// |---|---|---|
/// | Friendship, blocking, `canMessage`, any eligibility evaluation | `BC-11` | `FIL-XC-019` |
/// | Message text, ordering, delivery/read receipts, conversation membership | `BC-12` | `FIL-XC-020` |
/// | Abuse reports, moderation verdicts, strikes, bans | `BC-13` | `FIL-XC-022` |
/// | Public sharing, anonymous sharing, share-by-link without a named recipient | — | `FIL-XC-021` |
abstract interface class FileAccess {
  /// Whether [context] may be served at all, per `FIL-FR-006`.
  ///
  /// A pure membership test against [e22ConsumerContexts]. Exposed so a caller
  /// can be refused *before* a request is built, and so the rule is directly
  /// testable rather than only observable through a thrown error.
  bool isPermittedConsumer(BoundedContextId context);

  /// Resolve a stored object for a caller in [context].
  ///
  /// Throws [DomainErrorCode.forbidden] when [context] is absent from
  /// `E-22`'s consumer list (`FIL-FR-006`).
  ///
  /// Returns `null` when the caller is permitted but the object is unknown.
  /// The distinction is deliberate and is the `FIL-FR-094` rule: an
  /// **unauthorised** caller learns nothing about existence, while a permitted
  /// caller asking for something absent gets `null` rather than an error that
  /// would confirm the storage layout.
  FileRef? resolve(BoundedContextId context, FileRef ref);

  /// Grant [recipient] read access to [ref] on the strength of an eligibility
  /// decision already made by its owner.
  ///
  /// [decision] is an opaque reference, never a boolean (`FIL-FR-076`).
  /// [recipient] is required and named — there is no overload without it,
  /// which is how `FIL-XC-021`'s prohibition on share-by-link without a named
  /// recipient is enforced by signature rather than by validation.
  ///
  /// Throws [DomainErrorCode.forbidden] when [context] is not a permitted
  /// consumer.
  void grantRead(
    BoundedContextId context,
    FileRef ref, {
    required PersonId recipient,
    required EligibilityDecisionRef decision,
  });
}
