> # ⛔ ARCHIVED — NOT AUTHORITATIVE
>
> **This document has no standing.** It is retained for historical record only and **must not be cited as
> authority, quoted in a specification, or used to guide implementation.**
>
> | | |
> |---|---|
> | **Archived** | 2026-08-02 |
> | **Superseded by** | [`Authentication PRD v2.0`](../../../30-product/authentication/Authentication_PRD_v2.md) |
> | **Authority** | [`ADR-0008`](../../../00-governance/adr/ADR-0008-authentication-prd-v2-baseline.md) · [`DOCUMENTATION_BASELINE.md`](../../../00-governance/DOCUMENTATION_BASELINE.md) |
>
> **Why archived: a v1-era closure record. Its subject matter is superseded by Authentication PRD v2.0 and the current defect position recorded in `00-governance/DOCUMENTATION_BASELINE.md` §6.**
>
> Defect `D-7` — *"the Authentication PRD is not present in this repository"* — is **CLOSED**. The specification
> now exists as Authentication PRD v2.0. Any statement below asserting that the specification is missing, empty,
> pending transfer, or unwritten **was true when written and is false now.**

---

# Liboora Authentication — GATE-1 Blocker Closure Record

**Artifact type:** Decision record. Not a chapter. Not a specification.
**Authority:** Lead Enterprise Architect · Principal Security Architect · Documentation Governor
**Scope:** the 14 GATE-1 blockers named in the final validation report, and nothing else.

## Governing constraints on this record

| # | Constraint | Held |
|---|---|---|
| C-1 | No new functional requirement, business rule, bounded context, user role or authentication method | ✅ |
| C-2 | No locked chapter rewritten, no identifier renumbered | ✅ |
| C-3 | No new conflict, amendment, assumption, open question or defect | ✅ |
| C-4 | Every ruling derives from an already-locked identifier; none is an independent decision | ✅ |
| C-5 | Only artifacts named in D-1…D-6 modified | ✅ |

Each ruling below states the **locked identifiers it derives from**. Where a ruling could not be derived, it would have been escalated as an Architecture Change Request. **No ACR was required.**

---

## 1. Assumption

### `AS-09` — **ACCEPTED**

Confirmed in place, unchanged, as recorded in its originating chapter. This record does not restate it, because restating an assumption is how an assumption quietly becomes a different assumption.

**Basis for confirmation — non-contradiction.** `AS-09` was reviewed against every identifier locked after it, specifically: `CON-1120`–`CON-1125` (credentials), `CON-1123` (enumeration resistance), `PERF-1104`–`PERF-1112` (challenge budgets and the trust-boundary split), `CFL-30` (delivery is not BC-18's to promise), and `THR-806` verdict `CONTAIN`. No locked identifier contradicts it, and no chapter after it relied on it being different.

**Standing review trigger.** The confirmation lapses, and `AS-09` returns to the register, if any of the following changes: the sole-factor decision (`CON-1120`), the delivery trust boundary (`CFL-30`), or the `THR-806` verdict. Reconfirmation is then a review-authority act, not an implementation act.

**Status:** ACCEPTED · GATE-1 cleared · no register entry added.

---

## 2. Open Questions

### `QA-13` — entitlement evaluation, fail-open versus fail-closed for mutations — **RESOLVED**

**Ruling: fail closed for entitlement-gated mutations. Fail-open is not available.**

**This is a derivation, not a decision.** Three locked identifiers already determine it:

1. `AVL-1114` — an unavailable or stale decision input is treated as **absent**, and *"an absent input may narrow a decision and may never widen it."*
2. `BCP-1135` — *"where a decision cannot be rendered correctly, it is refused."*
3. The fourth `AccessPolicy` guardrail, **non-escalation** (`CON-1143`) — an entitlement gate exists to narrow; a gate that opens when it cannot be evaluated has escalated.

An absent entitlement therefore narrows the mutation to refusal. No new rule is created; the ruling merely records which branch the locked rules already compel.

**Bounds carried, per `AVL-1109` — the ruling may not reach beyond the gate:**

| Path | Effect of entitlement unavailability |
|---|---|
| Authenticate / establish session | **None.** Entitlement is a non-authentication dependency (`AVL-1107`). |
| Validate session | **None.** |
| Render a non-entitlement authorization decision | **None.** |
| Read a resource | **None.** Reads are not gated. |
| Entitlement-gated **mutation** | **Refused.** |

**Refusal shape:** internal class `AUTHZ` (`ERR-1111`), code `authzEntitlementGateRefused`, external projection `xDenied` (`ERR-1130`) — because the caller already legitimately knows the resource exists. The refusal is **not** `xTemporaryFailure`: a gate refusal is a decision, not a transient condition, and presenting it as retriable would invite the caller to retry until the gate happened to be unreachable.

**No conflict with `SSP-4`.** `SSP-4` forbids failing closed **on a non-authentication dependency** — that is, it forbids letting BC-21 break authentication. It does not require that an entitlement-gated mutation proceed ungated. The table above is the boundary, and it is enforced by construction: `AuthService` takes no entitlement dependency, asserted by `test/authentication_conformance_test.dart › QA-13`.

**Applied in:** `packages/liboora_contracts/lib/src/errors/domain_error.dart`, `tool/module_dependencies.yaml` (assertion `ID-8` neighbourhood), regression tests.
**Status:** RESOLVED · GATE-1 cleared.

---

### `QA-24` — the notification-address port — **RESOLVED**

**Ruling: accept the port exactly as scoped by the already-approved resolution of `CFL-26`. No widening.**

Derived from: `CON-1177` (no event ever carries a mobile number), `NTF-1012`–`NTF-1017` (address resolved at delivery time), `CMP-1116` (capability sized exactly to purpose), `OBS-1104` (a number may not appear in any observability artifact).

**Port shape — closed:**

| Property | Ruling |
|---|---|
| Name | `platform/identity:notification_address` |
| Consumer | `platform/communication` (BC-22) only |
| Input | one `AccountId` + one declared delivery purpose |
| Output | one address, for one already-queued delivery |
| Timing | at delivery time, never at emission time |
| Listing / bulk / enumeration | forbidden |
| Existence testing | forbidden — an unresolvable address fails the delivery, never the emitting operation |
| Retention by caller | forbidden — no persist, cache, index or log |

**Applied in:** `tool/module_dependencies.yaml` — port declared on `platform/communication`, `provides_ports` on `platform/identity`, assertions `CM-1`, `CM-2`, `CM-3`, `ID-5`.
**Status:** RESOLVED · GATE-1 cleared.

---

## 3. Amendments — all APPLIED

| ID | Target artifact | What was applied | Verification |
|---|---|---|---|
| `A-1` | `domain_error.dart` | **36** BC-18 error codes appended (never interleaved — the enum is additive-only). Internal classes `ERR-1110`–`ERR-1116`. The pre-application estimate was ≈22; enumerating the locked conditions yields 36. No condition was invented and none was merged. | `A-7 · every code declares a class and an external outcome` |
| `A-2` | `module_dependencies.yaml` | `domain/library` may consume `iam.AccountVerified`, `iam.AccountStatusChanged`; gains `platform/identity:account_directory` (single-subject, no listing, no lookup by number) | declared `provides_ports` constraint |
| `A-3` | `module_dependencies.yaml` | `platform/identity:notification_address` on `platform/communication`; assertions `CM-1`–`CM-3` | see `QA-24` |
| `A-4` | `module_dependencies.yaml` | `emission_classes` block: Class D / A / T with transport and consumers; assertions `ID-1`, `ID-2`. The 36-fact register is **referenced, not duplicated** — duplicating it is how two registers drift. | assertions `ID-1`, `ID-2` |
| `A-5` | `module_dependencies.yaml` | Class A confined to `platform/audit`, stated as a boundary violation rather than a subscription choice; assertions `ID-3`, `AU-2` | assertions `ID-3`, `AU-2` |
| `A-6` | `module_dependencies.yaml` | `platform/analytics` gains `excluded_events: ["iam.*"]` — explicit, because `"*"` would otherwise silently subscribe it; assertion `AN-3` | assertion `AN-3` |
| `A-7` | `domain_error.dart` | `ExternalOutcome` (closed, 7 members) + `ErrorClass` + **exhaustive** `switch` projections. Adding a code cannot compile until its class and projection are declared — the structural guarantee A-7 required, replacing convention. | 6 tests in `A-7` group |
| `A-8` | `identifiers.dart` | `DeviceId`, `SessionId`, `InviteId`, `PermissionId` as `Identifier` subtypes. `SessionId` now carried by `AuthSession`; `PermissionId` exposed by the closed `Permission` catalogue, so neither is dead code. | 3 tests in `A-8` group |
| `A-9` | `module_dependencies.yaml` | `global.observability_plane`: classification ceiling `DC-2`, banned content list, banned/allowed metric dimensions, forbidden inferences, `is_authoritative_for: []`, 30-day retention, `severity: blocker`; assertion `ID-4` | declared block + assertion `ID-4` |

`exceptions:` remains **empty**. None of the nine is an exception to a law — each widens a declared allow-list or adds an assertion. A law exception would have required an ADR and an expiry; none was needed.

---

## 4. Defects — both REMOVED

### `F-01` — unscoped `viewStudent` for `student` and `parent` — **REMOVED**

Violated `RBD-12`, `AZ-704`, `THR-808.6`, `CON-1141`, `CON-1146`.

The grant table changed shape, not content: `Map<AccessRole, Set<Permission>>` → `Map<AccessRole, Map<Permission, AccessScope>>`. **There is now no way to express an unscoped grant** — which is the actual fix. The scope register is the locked closed set, implemented verbatim: `self`, `guardianOf`, `tenantWide`.

- `student` → `viewStudent` at `self`
- `parent` → `viewStudent` at `guardianOf`
- staff roles → `tenantWide`, unchanged

`require()` keeps its signature and all eight existing domain call sites compile untouched, but it now **refuses** a scoped grant presented without a resource — and refuses it as `authzScopeOutsideSubject` → `xNotFound`, never `xDenied`, per `CON-1146`. `requireOn()` is the only path by which a scoped grant can pass.

**Regressions:** 7 tests, including `every grant in the catalogue declares a scope` (loops the full catalogue, so a future unscoped grant fails CI) and `a scoped denial is indistinguishable from not-found`.

### `F-02` — enumeration oracle, derivable challenge, no TTL, no attempt budget — **REMOVED**

Violated `SC-305`–`SC-308`, `BR-514`, `THR-805.5`, `CON-1121`, `CON-1123`.

| Sub-defect | Correction |
|---|---|
| `requestOtp` returned `false` for unknown numbers | Returns **`void`**. There is no signal to read — the signature is the fix. |
| Oracle repeated at two higher layers | `SessionController.requestOtp` no longer sets an error; `login_screen._send()` no longer branches. The message *"No Liboora account is registered for this number."* is deleted. |
| Code = `phone.hashCode` | Drawn digit-by-digit from `RandomSource`; `SecureRandomSource` wraps `Random.secure()` and lives in the adapter layer because the shared kernel may not import `dart:math` (L5). The port is the one named by `X-09`'s own `banned_symbols` entry. |
| No TTL | `challengeTtl` enforced against the injected `Clock`. |
| No attempt limit | `maxVerifyAttempts` enforced per challenge; exhaustion discards the challenge, so the correct code stops working. |
| Debug peek was a public field | `lastIssuedOtp` removed. `debugPeekChallenge()` returns null unless the wiring sets `challengePeekEnabled`, which DI derives from `!dart.vm.product`. |

Adapter defaults (`challengeTtl` = 5 min, `maxVerifyAttempts` = 5, 6 numeric digits per TRAI DLT) are **configuration of** the locked bounds, not restatements of them. The normative values remain the locked registers'.

**Regressions:** 8 tests, including `the challenge is not a function of the subject` — which the old implementation could not have passed under any parameterisation.

---

## 5. Verification at time of closure

| Check | Result |
|---|---|
| `flutter analyze` | **No issues found** |
| `flutter test` | **All tests passed — 35/35** (9 pre-existing + 26 new) |
| `dart format .` | clean |
| Locked chapters modified | **0** |
| Identifiers renumbered | **0** |
| New conflicts / amendments / assumptions / open questions / defects | **0** |
| ACRs required | **0** |

## 6. Files modified

| File | Blockers closed |
|---|---|
| `packages/liboora_contracts/lib/src/errors/domain_error.dart` | `A-1`, `A-7`, `QA-13` |
| `packages/liboora_contracts/lib/src/value_objects/identifiers.dart` | `A-8` |
| `packages/liboora_contracts/lib/src/ports/random_source.dart` *(new)* | `F-02` |
| `packages/liboora_contracts/lib/liboora_contracts.dart` | `F-02` (export) |
| `tool/module_dependencies.yaml` | `A-2`…`A-6`, `A-9`, `QA-24` |
| `lib/platform/identity/identity.dart` | `F-01`, `F-02`, `A-8` |
| `lib/bootstrap/di.dart` | `F-02` (secure wiring) |
| `lib/app/session.dart` | `F-02` (oracle at controller) |
| `lib/app/shell/login_screen.dart` | `F-02` (oracle at UI) |
| `test/authentication_conformance_test.dart` *(new)* | `FAC-1142` regressions |
| `lib/app/dashboards/students_page.dart` | analyzer baseline restored to clean |
