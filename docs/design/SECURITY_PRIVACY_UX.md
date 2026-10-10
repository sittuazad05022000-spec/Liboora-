<!-- LIBOORA Design Documentation Foundation | security and privacy UX — production-grade specification, repository-anchored II 2026-10-26 · replaces v0.1 generic gap register -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts. Where it disagrees with any ranked document, the ranked document wins.

# LIBOORA Security & Privacy UX

| Field | Value |
|---|---|
| Status | **SPECIFICATION** — concrete UX states/flows where repo evidence already settles them; gap-referenced `TO BE DECIDED` where it does not |
| Owner | Design Governance Owner *(register + interim rule — routing only; not the deciding office for the TO BE DECIDED items)* |
| Deciding offices | **Privacy Owner** (`Accepted` `ADR-0077`) · **Security Platform** (`ADR-0115` §8.1) · Product Owner · Founder/Product Authority · Governance Owner (version/source disputes) |
| Rank | **UNRANKED.** Carries no precedence over any ranked PRD, ADR, BC Map, `CONFIGURATION_GUIDE` or `DOCUMENTATION_BASELINE` entry |
| Companion | [`DESIGN_QA.md`](DESIGN_QA.md) §3 states S1–S12 + §5.4/§5.5 + §6 recovery · [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) · [`UX_ARCHITECTURE.md`](UX_ARCHITECTURE.md) · [`ACCESSIBILITY.md`](ACCESSIBILITY.md) — this document states security & privacy UX behaviour only where a ranked source settles it |
| Applies to V1 | Yes — all §4 behaviours bind V1 surfaces; `SPX-GAP-009` community privacy remains V2 (`PRD-021A` conflict `C-001`) |

---

## 1. What this document decides, defers, and does not invent

**Decides (§4):** the UX states, flows, disclosure boundaries, and recovery routes for security- and privacy-adjacent behaviour that the frozen AUTH/BCM/configuration records already settle — presented here as concrete, reviewable criteria, not as gap labels.

**Defers (§5):** wording that is a legal or security judgement — exact consent copy, privacy-notice text, and per-scenario failure-message phrasing — to the office that owns it. These rows remain `OPEN` and `TO BE DECIDED` until the owning office confers; a Figma screen is not the decision.

**Does not invent (§6 doctrine):** no data type is re-classified, no retention period is shortened or extended, no rate-limit/threshold is changed, and no Community privacy is designed while `C-001` is unresolved. The authoritative values live in the sources named in §3; this document contributes no new number.

## 2. Why some decisions cannot be taken by design

Three constraints, each from an existing governed record:

1. **Privacy Owner is a constituted office.** `Accepted` `ADR-0077` derives the office; every `SPX-GAP-00x` that touches consent vocabulary, minor comprehension, and PII display is `OPEN` until the owning office decides — routing is the complete and correct act until that decision.
2. **At-rest construction is unassigned, and audit retention is unbounded.** `ATT-GAP-006` ("the construction is Security Platform's") blocks Item 9b; `AUD-GAP-001` / `MP-NFR-10` leave audit-retention without a bounded value — a design mock of an encrypted state or a promised audit duration would be a security design, which `ADRs/IMPLEMENTATION_BLOCKER_REGISTER.md §0.4` forbids.
3. **The source chapter that governs most gaps is under the frozen v2.0 tree.** `DOCUMENTATION_BASELINE.md` names Authentication PRD **v3.0** as current, but `prd-v3/` holds only `00-Cover-and-Control.md`; the security/privacy chapter exists at `prd-v2/08-Security-and-Privacy.md`. `SPX-GAP-008` records this as a Governance Owner dispute. This section is cited, not reconstructed.

## 3. Authoritative sources that create the obligations

Cited, never restated as if owned here. Value cells are **read, not invented**.

| Source | Path / section | Status | Used in §4 |
|---|---|---|---|
| Auth PRD — Security & Privacy | `docs/30-product/authentication/prd-v2/08-Security-and-Privacy.md` — §8.3 session/device, §8.4 privacy principles, §8.5 sensitive-data protection, §8.6 threat scenarios (**9**), §8.8 privacy business rules | Frozen record (`PRD-002` v2.0) | §4.3–§4.6 |
| Auth PRD governance correction | `docs/30-product/authentication/PRD-V2-GOVERNANCE-NOTE.md` §§2–4 + `DOCUMENTATION_AUDIT-001` | Engineering record; §4 table **superseded by** `docs/20-configuration/CONFIGURATION_GUIDE.md` | §4.2–§4.7 |
| Operational configuration (normative) | `docs/20-configuration/CONFIGURATION_GUIDE.md` — `CFG-1`…`CFG-12` + `INV-1`…`INV-9` startup-validated invariants (`IMPL-015`) | Ranked operational authority | §4.2, §4.4–§4.6 |
| Bounded context invariants | `docs/10-architecture/BC-CONTEXTMAP*.md` `BC-18` (global `AccountId`, `ConsentRecord`, tenant-scoped role assignment, `MP-GBR-25/27/34`) + `BC-19` tenant isolation | Rank 4 | §4.1, §4.3, §4.5 |
| Privacy Owner role | `docs/00-governance/adr/ADR-0077-privacy-owner-role-derived-from-existing-rules.md` | `Accepted` | §5 all rows |
| Community safety/privacy | `docs/30-product/social-graph/PRD-021A_A6_COMMUNITY_SAFETY_PRIVACY_MODERATION_DRAFT_v0.1.md` — A6 | `DRAFT` — carries conflict `C-001` vs baseline | §5 `SPX-GAP-009` |
| `SEC-1` / `A-9` release | `docs/00-governance/SEC-1_A-9_IMPLEMENTATION_RELEASE_BC-18.md` | Unranked record, outside design authority | §4.4 `A-9` custody |
| Implementation blocker on construction/retention | `docs/40-implementation/IMPLEMENTATION_BLOCKER_REGISTER.md` §11.2 Items 7a/9b — `Q-04` (needs counsel), `ATT-GAP-006` | `OPEN` | §4.7, §5.008 |
| Audit-retention gap | `docs/40-implementation/TRACEABILITY_MATRIX.md:1086` — `AUD-GAP-001` / `AUD-CFG-*` ("no rank supplies a default or bound", `MP-NFR-10`) | `OPEN` | §4.7 |

---

## 4. Concrete UX states and flows (production-grade)

Every subsection applies the [`DESIGN_QA.md`](DESIGN_QA.md) §3 state matrix (S1–S12) and §6 recovery. A surface that shows a privacy/security state not named here is either `TO BE DECIDED` with its `SPX-GAP-*`, or out of scope.

### 4.1 Consent — request, granted, pending, withdrawn, expired

*BC-18: `ConsentRecord` is a global-account value object; minor guardian consent precedes social activation; `DPDP CFG-9` (24 h) bounds unverified personal data.*

- **States to show:** `NOT YET REQUESTED` → `PENDING` (minor awaiting guardian) → `GRANTED` (date/scope shown, withdrawable) → `WITHDRAWN` → `EXPIRED`. Each state discloses what data processing is allowed at this moment and what revocation does **not** undo (already-performed processing remains lawful); no mock consent dialog invents the legal copy — wording is `TO BE DECIDED` per `SPX-GAP-001`.
- **Withdrawing consent:** the action is explicit, requires confirmation, and returns to a named subsequent state (limited-capability or logged-out) — not to a silently degraded screen.
- **Minor path:** no activation gated on guardian consent may proceed without that consent; an indeterminate or future consent source is never auto-accepted (see `ACCESSIBILITY.md` §2 exception doctrine — no silent vacancy reassignment).

### 4.2 PII display, masking, and error disclosure

*AUTH §8.5 classifies sensitive data; `MP-GBR-34` forbids events carrying a mobile number; `MP-GBR-27` limits credential carriage to `BC-18`.*

- **Visible by default — never:** full mobile number, one-time code, session token, recovery code, or any credential-bearing field. Public or semi-public surfaces (Library profile §14A.5 allow-list) never print a credential even when the signed-in actor also holds it — the allow-list is the display model (`ACCESSIBILITY.md` §2's "no internal identifier in an error" extends to all surfaces).
- **Masking when needed:** an account/verification surface that must show identity shows at most a masked hint where the owning BC explicitly permits it (e.g., `•••1234`), and never re-derives identity from a hint; the governing rule is the BC, not the Figma choice.
- **Error messages never leak existence:** a non-discoverable/private record is not confirmed by an error; the tenant-existence error is the same whether the tenant does not exist or is merely non-visible to the caller. The same restraint governs non-existent-library responses (see §4.5 S6).

### 4.3 Authentication & rate-limit feedback

*`CFG-1` (5 / number / h), `CFG-2` (30 s between requests), `CFG-3` (100 / origin / h), `CFG-4` (30 min hard lock on quota exhaustion) + §8.6 threat scenarios; `INV-*` startup validation (`IMPL-015`).*

- **Request throttling states:** `AVAILABLE` → `NEXT REQUEST IN Xs` (countdown from `CFG-2`) → `RATE LIMIT — try again in Xm` (with a non-numeric explanation, not the exact counter value). `CFG-3` exhaustion explains per-origin volume without exposing a bypass ("many requests from this network").
- **Hard lock:** on `CFG-4` the lock is shown as "temporarily unavailable — try again in ~Xm" with a safe secondary action (contact support via an existing capability, not a shadow flow). No countdown precision that assists enumeration.
- **Verification attempts:** `AUTH-3.12`-equivalent behaviour — 5 verification attempts, 5 min code validity, single-use challenges — is never surfaced with a remaining-attempts number in a way that helps an attacker; generic "incorrect or expired" phrasing is used, and detailed diagnostics are server-log only.
- **Failure disclosure budget per §8.6:** an over-informative failure message is itself an attack surface (SIM-swap, interception, session-hijack). The UI discloses the next usable action, not the diagnosis; where wording is security-relevant, it is `TO BE DECIDED` with `SPX-GAP-004`.

### 4.4 Session, device, and secure-logout UX

*`CFG-5` idle timeout **30 min (staff)** / 30 d mobile; `CFG-6` absolute **12 h (staff)** / 90 d mobile; `CFG-7` device trust **90 days**; `CFG-8` max **10** devices; `CFG-12` support elevation **≤ 1 h**; nesting invariants `INV-5` (trust ≤ mobile session), `INV-1`–`4` on windows.*

- **Session states to show:** `ACTIVE` (remaining-session hint where helpful) → `EXPIRING SOON` → `EXPIRED / SIGNED OUT` → re-authentication. Staff absolute expiry at 12 h is communicated as a shift-bound session, not a "remember me" extension.
- **Device states:** `CURRENT DEVICE` → `TRUSTED` (with trust-expiry derived from `CFG-7`, never outliving `CFG-6` per `INV-5`) → `UNTRUSTED`. A revoked or untrusted device that still holds a local session is forced to re-authenticate — the UI does not present the revoked device as signed-in.
- **Secure logout:** an explicit, single-action logout is reachable from `S8`; a forced-logout state names its cause ("signed out elsewhere / session expired") and routes to re-authentication without preserving a signed-in frame.
- **Custody note on `A-9`:** the CSS/secret-custody office (`ADR-0115` §8.1) is already resolved to **SECURITY PLATFORM**; this section states states, not the construction (`ATT-GAP-006`).

### 4.5 Permission-denied, consent-gated, and tenant-isolation

*`PolicyDecisionPoint` role model in code; `SCREEN_ARCHITECTURE.md` §1 permission-denied state; `BC-19` tenant isolation (tested in `test/widget_test.dart`).*

- **Three callers for one screen:** the trial matrix is `PERMITTED` · `PERMISSION-DENIED` · `CONSENT-GATED` (the minor-guardian `ConsentRecord` requirement blocks social activation independently of roles). Consent and permission are not interchangeable — a consented path may still be denied by role, and vice versa.
- **Deny-vs-hide is a security choice, not a visual preference.** Whether a denied capability is hidden or shown as disabled discloses different information; the choice is recorded as `OPEN` with `SPX-GAP-006` until Security Platform decides — neither option is the default.
- **Tenant ambiguity is forbidden:** `account_sheet.dart`'s active-tenant affordance must make the acting tenant **unambiguous before** any write-capable action. Any action whose tenant scope is not displayed is a nearest-neighbour fault: the user acting in the wrong tenant is a cross-tenant event even without malice (`SCREEN_ARCHITECTURE.md` §1, `BC-19` invariants) — recorded with `SPX-GAP-007`.

### 4.6 Data minimisation, deletion, and accountability

*`CFG-9` (pending-verification 24 h), `CFG-10` (soft-delete 30 d); `DPDP`-derived but not a legal rewrite here.*

- **Pending-verification expiry:** a verification pending beyond **24 hours** is `EXPIRED` — the account is unverified and any unverified personal data is not retained indefinitely (`SPX-GAP-003`). The UI names the state and the next action (re-verify), not the internal schedule.
- **Account deletion / soft-delete:** `WITHDRAWN`/`DELETED` → a **30-day** residual window is communicated as "your account and personal data will be removed within 30 days; some traces may persist for lawful retention" — without promising a named audit-retention period that `AUD-GAP-001` has not bounded. Where audit retention / legal hold is relevant, the disclosure is `TO BE DECIDED` (Legal + Security/Data Governance).
- **Accountability:** the `TODO(audit)` / `TODO(privacy-review)` handlers that still sit on the stubbed student-management hooks are not shipped as a design answer and must not be drawn as such; any trace that looks like an audit entry is a backend decision, not a Figma one.

### 4.7 Resilience and unimplemented-spec handling

*`PRD-V2-GOVERNANCE-NOTE` §7: most of Chapters 6/7/9/10/11 describe required behaviour with no corresponding code; some `TODO` handlers carry an audit concern — §3 above, and `AUD-GAP-001`.*

- **Degraded/flaky states:** a surface whose backend/capability is specified but stubbed shows `UNAVAILABLE / NOT YET AVAILABLE` with a non-retriable, non-promise explanation — not a spinning retry loop, and not a mock success.
- **Error → recovery mapping:** every `SPX`-adjacent error maps to one recovery route (retry with backoff, constrained re-verify, constrained device re-trust, safe contact) — never to an indefinite loop and never to a client-side recovery that bypasses the owning BC.

## 5. Retained gap register — what remains TO BE DECIDED

All nine identifiers are **never reused or reassigned**; a `CLOSED` row requires the named office's act (§6). §4's concrete states do not close these rows — they name what may be designed and what must remain marked.

| ID | Gap | Source obligation | Owning office | Status |
|---|---|---|---|---|
| `SPX-GAP-001` | **Consent copy remains open.** `ConsentRecord` structure and minor-guardian consent-before-activation are given, but ⛔ **no privacy-approved consent copy exists.** §4.1's state machine is reviewable; the wording is not | BC Map §8 `BC-18` invariants | **Privacy Owner** *(⚠️ VACANT)* + Product Owner | ⛔ OPEN |
| `SPX-GAP-002` | **Minor-facing comprehension remains open.** A minor-comprehsible consent/data-minimisation posture is still not decided beyond §4.1's guardian gate; guardians' visibility into a minor's data has no settled surface | BC Map `BC-18`; `ADR-0077` — minor-inclusive flows | **Privacy Owner** *(⚠️ VACANT)* | ⛔ OPEN |
| `SPX-GAP-003` | **PII display vocabulary outside the allow-list remains open.** §4.2 settles masking/error leakage for V1; ⛔ **any field beyond the §14A.5 allow-list and the masked hint remains undecided** until Privacy Owner decides the display model — a broader PII surface is not implied by §4.2 | Auth PRD `prd-v2` §8.5 | **Privacy Owner** *(⚠️ VACANT)* + Security Platform | ⛔ OPEN |
| `SPX-GAP-004` | **Per-scenario failure wording remains open.** §4.3 settles rate/throttling/lock states and the "action, not diagnosis" rule, but ⛔ **per-threat wording for §8.6's 9 scenarios (SIM-swap, lost device, OTP interception, session hijack, replay, insider misuse, etc.) is undecided** — an over-informative Figma message is itself an attack surface | Auth PRD `prd-v2` §8.6 | **Security Platform** + Product Owner | ⛔ OPEN |
| `SPX-GAP-005` | **Session/device copy remains open.** §4.4 settles the state machine from `CFG-5…CFG-8`; ⛔ **session-/device-surface copy remains TO BE DECIDED** (a wording question routed alongside the construction ownership) | Auth PRD `prd-v2` §8.3; `CFG-5`…`CFG-8` | UX Architecture Owner, **conditional on** Security Platform | ⛔ OPEN — state machine concrete, copy deferred |
| `SPX-GAP-006` | **Hide-vs-disable for denied capabilities remains open.** §4.5 settles the 3-caller trial and the tenant-isolation invariant, but ⛔ **whether a denied capability is hidden or shown-disabled remains undecided — the choice is security-relevant** (it discloses different information) | `SCREEN_ARCHITECTURE.md` §1; `PolicyDecisionPoint` | Security Platform + UX Architecture Owner | ⛔ OPEN |
| `SPX-GAP-007` | **Active-tenant affordance is not yet a shipped surface.** §4.5 makes the invariant unambiguous-before-write, but ⛔ **no tenant affordance surface is yet detailed in Figma** — `account_sheet.dart` exists in code; its design treatment does not | BC Map `BC-19`; `test/widget_test.dart` tenant-isolation group | Security Platform + UX Architecture Owner | ⛔ OPEN — invariant concrete, surface deferred |
| `SPX-GAP-008` | **Source-version ambiguity.** The chapter this document cites exists only under `prd-v2/` while the baseline names **v3.0**. ⛔ **Not repaired here:** reconciling a frozen chapter is a Governance Owner act | `DOCUMENTATION_BASELINE.md` | **Governance Owner** | ⛔ OPEN |
| `SPX-GAP-009` | **Community privacy is blocked upstream.** `PRD-021A` A6 safety/privacy/moderation is `DRAFT`; its status carries conflict `C-001`. ⛔ **No community privacy UX may be designed** until governance reconciles that record | `PRD_DESIGN_TRACEABILITY.md` §4 `C-001` | Governance Owner → Founder/Product Authority | ⛔ OPEN — ⚠️ **blocked, not merely unassigned** |

### 5.1 Register measures

| Measure | Value |
|---|---|
| Gaps recorded | **9** — all retained, no identifier reused |
| Resolved by §4's concrete states | **0** rows closed — §4 narrows scope, it does not invent a legal/security answer |
| Partially concrete (invariant/state settled; copy/surface still OPEN) | **5** (`003`, `005`, `006`, `007` + `001` in part) |
| Blocked on the **VACANT** Privacy Owner | **3** (`001`, `002`, `003`) |
| Requiring Security Platform | **4** (`003`, `004`, `006`, `007`) |
| Blocked upstream by `C-001` | **1** (`009`) |
| Governance-owned | **1** (`008`) |
| Audit-retention unbounded beyond this document | `AUD-GAP-001` — `MP-NFR-10` / `Q-04`; no `AUD-CFG-*` is supplied here |

## 6. Interim design rule (unchanged in force, restated with scope)

**Until §5's gaps are resolved by the owning office, one rule applies — a restraint, not a specification:**

⛔ **A design artifact must not depict a security or privacy behaviour that no source defines.** Drawing a consent dialog, a masked field, a community-privacy toggle, or a failure message phrasing creates the appearance of a settled requirement and is itself an attack surface when wording leaks information. Where a surface needs such behaviour, the artifact marks it `TO BE DECIDED`, cites the `SPX-GAP-*` row, and proceeds no further — then it shows the **nearest concrete fallback** from §4 (the state, the recovery route, the associated `DESIGN_QA` S-state) without inventing the missing wording.

This follows [`DESIGN_QA.md`](DESIGN_QA.md) §3's S-matrix and §9's `RETURNED` vs `CONFLICT` distinction, and [`DESIGN_FOUNDATION.md`](DESIGN_FOUNDATION.md) §4 — design "may not create a new capability or ownership boundary."

## 7. Filing rules

1. **One gap per row**, each citing a source path.
2. **Never close a row by designing the answer** — closure needs the named office's act (`DDR-*` or an upstream `ADR-*`/`CONFIGURATION_GUIDE`/`BC Map` amendment).
3. **A vacant office is recorded as vacant**, never silently reassigned. Overstating who can decide is the fabrication design documentation deliberately avoids.
4. **`SPX-GAP-*` identifiers are never reused or reassigned.** `001`–`009` persist; `010` would be next.
5. **If a source changes**, restatus the row; ⛔ do not edit the frozen/draft source — [`DESIGN_CHANGE_MANAGEMENT.md`](DESIGN_CHANGE_MANAGEMENT.md) §3.
6. **Cite the source, not this document**, when a reviewer asks "who said so?" — the path in §3 is the authority.

---

*Reviewed against: AUTH/PRD `prd-v2/08-Security-and-Privacy.md` · `PRD-V2-GOVERNANCE-NOTE.md` §§3–4 + `DOCUMENTATION_AUDIT-001` → `CONFIGURATION_GUIDE.md CFG-*` · BC Map `BC-18`/`BC-19` · `ADR-0077` · `ADR-0115` §8.1 · `PRD-021A_A6` + `PRD_DESIGN_TRACEABILITY.md` §4 `C-001` · `IMPLEMENTATION_BLOCKER_REGISTER.md` §11.2 `Q-04`/`ATT-GAP-006` · `TRACEABILITY_MATRIX:1086` `AUD-GAP-001` · `docs/20-configuration/CONFIGURATION_GUIDE.md` · design: `DESIGN_QA`, `SCREEN_ARCHITECTURE`, `UX_ARCHITECTURE`, `ACCESSIBILITY`, `DESIGN_DEBT DBT-006`.*
