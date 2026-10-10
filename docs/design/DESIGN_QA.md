<!-- LIBOORA Design Documentation Foundation | 2026-09-09 | v0.2 2026-10-26 — production-quality rewrite; no requirement, decision, or rank invented -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts. Where it disagrees with any ranked document, the ranked document wins.

# LIBOORA Design QA

| Field | Value |
|---|---|
| Status | PROPOSED — design QA gate (criteria); approval authority is a **gate act**, not this document — G4 is recorded separately at [`G4_DESIGN_QA_RECORD_2026-10-01.md`](G4_DESIGN_QA_RECORD_2026-10-01.md) |
| Owner | Design QA Owner (criteria, evidence template, triage); G4 pass/fail is the gate owner's act per [`DESIGN_GOVERNANCE.md`](DESIGN_GOVERNANCE.md) |
| Result vocabulary | `APPROVED` · `RETURNED` · `TO BE DECIDED` · `CONFLICT` — same vocabulary as [`DESIGN_GOVERNANCE.md`](DESIGN_GOVERNANCE.md) §2; a surface is not `APPROVED` by passing a subset of checks |
| Rank | **UNRANKED.** Carries no precedence over any ranked PRD, ADR, BC Map, or [`DOCUMENTATION_BASELINE.md`](../00-governance/DOCUMENTATION_BASELINE.md) entry |
| Sources of truth | FROZEN library §§14A–14B, PRD-007 (seat), PRD-006/004/014/017/021C as applicable · [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) + DDR-0001…0034 · [`ACCESSIBILITY.md`](ACCESSIBILITY.md) (`DDR-0004` WCAG 2.1 AA) · [`RESPONSIVE_DESIGN.md`](RESPONSIVE_DESIGN.md) + [`DDR-0034-cp-a-v1-device-profile-confirmed-by-technical-owner.md`](design-decisions/DDR-0034-cp-a-v1-device-profile-confirmed-by-technical-owner.md) · [`NFR_BUDGETS_V1.md`](NFR_BUDGETS_V1.md) · [`SECURITY_PRIVACY_UX.md`](SECURITY_PRIVACY_UX.md) |
| Evidence record | [`templates/DESIGN_QA_EVIDENCE_TEMPLATE.md`](templates/DESIGN_QA_EVIDENCE_TEMPLATE.md) — one record per surface/review; cumulative reviews feed [`G4_QA_REVIEW_RECORDS_2026-10-01.md`](G4_QA_REVIEW_RECORDS_2026-10-01.md) |
| Debt register | [`DESIGN_DEBT.md`](DESIGN_DEBT.md) `DBT-004` (thin UI evidence: 1 `testWidgets`), `DBT-003`/`DBT-008` — this document states criteria; it does not claim the evidence exists |

---

## 1. What Design QA is and is not

* **Is:** the check that a designed surface can be handed to engineering, reviewed, and released without inventing product behaviour, violating a frozen source, or shipping an inaccessible or unrecoverable state. The checklist in §5 is applied per surface, not once per release.
* **Is not:** a product decision, a permission grant, an architecture waiver (`ADR-0012` §3.4 `app → domain/library` stays RED), a security/privacy approval, or an implementation test run. QA `APPROVED` does not pass gate `G4` by itself; the gate act does.
* **V1 scope:** public discovery/profile (Library §§14A–14B), authenticated seat booking (PRD-007), and the supporting account/shell surfaces implied by those flows. No V2 module (Staff & Shift, Community, fee collection via gateway) is in scope for a V1 QA `APPROVED`.

## 2. Surfaces under review

Each surface is named from [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) §1 and [`USER_FLOWS.md`](USER_FLOWS.md); a surface not listed there is not a QA subject until it is added to those documents.

| Family (per SCREEN_ARCHITECTURE) | V1 QA subjects |
|---|---|
| Discover / Search | Search, Nearby, Results |
| Library Profile (public allow-list only) | Library Profile (public projection; indistinguishable error for private/unavailable per `14B` `LIB-14B.22`–`.25`) |
| Availability | Public aggregate availability strip/card |
| Shift / Seat selection | Shift picker, Seat grid/list, Selection confirmation |
| Booking outcome | Success, hold-pending, approval-required, and the enumerated rejections (`SEAT-FR-085`–`.086`) |
| Shell / account | Navigation, library switcher, account/session affordance (no new permission) |

A review that cannot name its surface family is out of scope and is `RETURNED`.

## 3. Required state matrix — every surface is reviewed in each row that applies

A surface that omits a row without a recorded `TO BE DECIDED` or `NOT APPLICABLE — reason` is `RETURNED`. "Happy path only" is not evidence.

| # | State | What QA checks | Source / note |
|---|---|---|---|
| S1 | Empty / zero-data | Empty copy, illustration restraint (`DESIGN_FOUNDATION.md` DDR-0013 70/25/5), primary CTA, no dead controls | `DESIGN_FOUNDATION.md` · `DESIGN_SYSTEM.md` |
| S2 | Loading / skeleton | Skeleton or progress that preserves layout; no layout shift that moves the primary action | `PERFORMANCE.md` §1 asset rules |
| S3 | Populated (1, few, many) | Single result, short list, long list (overflow/scroll), count formatting | IA — one canonical place per concept |
| S4 | Full / at-limit | Max-length names (Devanagari — see `DEVANAGARI_RENDERING_PROBE.md` + `DDR-0034` target class), max seats/shifts, truncation/wrap rules; no clipping at `Noto Sans` + `Noto Sans Devanagari` `DDR-0029` | `DDR-0029`, `DDR-0031`–`0032`, `DBT-003` |
| S5 | Error — network / service | Named error (network unavailable, service unavailable, timeout), retry action, what is retryable; no silent failure | PRD-007 rejection vocabulary; `PERFORMANCE.md` slow-network posture |
| S6 | Error — not found / unavailable | Library/profile not found and private-library responses are **indistinguishable** (`LIB-14B.22`–`.25`); seat no longer available / hold expired | Library §§14A–14B anti-enumeration |
| S7 | Error — not eligible / rejected | Eligibility, shift/seat rejection, tenant-disabled booking, quota/hold rejections per `SEAT-FR-076`–`.086` | PRD-007 only — no invented rejection |
| S8 | Permission-denied / session | Signed-out, session-expired, staff-gated action attempted as student; recovery is sign-in or contact, not a bypass | `MP-CON-11` no-demo/guest, `TASK-D10` gate 3 |
| S9 | Stale / offline / degraded | Cached/optimistic availability clearly marked stale; offline banner; no claim of live occupancy or exact free count (public surface never shows per-seat identity / exact free count) | `SCREEN_ARCHITECTURE.md` availability guardrail · `PERFORMANCE.md` §1 stale-data posture |
| S10 | Partial / permission-filtered | Filtered-out results explained; unavailable fields omitted without gap or "coming soon" (per allow-list) | Library §14A.5 allow-list |
| S11 | Confirmation / destructive | Booking confirmation and cancellation/leave confirmations where applicable; destructive action requires explicit confirm | `SECURITY_PRIVACY_UX.md` restraint — no invented destructive auth |
| S12 | Success with side-effects | What changed (booking created/held), where to find it, next action, undo/adjust where source defines it | `USER_FLOWS.md` §1 completion |

## 4. Edge cases and invariants QA must verify

* **String reality:** Devanagari names at line-height/weight extremes (`DDR-0031`/`0032`), mixed Latin+Devanagari, LTR ordering, and the configured `fontFamilyFallback`; any rendering claim cites [`DEVANAGARI_RENDERING_PROBE.md`](DEVANAGARI_RENDERING_PROBE.md) or is `TO BE DECIDED`.
* **Number reality:** single seat, full block, tenant default booking `disabled`, hold window expiry (`PRD-007`  `SEAT-FR` equivalents), concurrent holds leading to rejection.
* **Data reality:** 0 libraries, 1 library, 100 libraries; 0 shifts, many shifts; library with no public seat data — no "0 available" claim on the public projection.
* **View reality:** compact `< 600dp` single-column, medium `600–904dp` single-column, expanded `≥ 905dp` two-pane only at the threshold (`RESPONSIVE_DESIGN.md` + `DDR-0005`); density/placement tolerates content growth.
* **Network/device reality:** first meaningful content without remote image, degraded 4G/intermittent, offline snapshot, and low-end target class `API 26 · ~2 GB · 720×1600` (`DDR-0034`); no primary task waits on a large illustration, animation, blur layer, or high-bandwidth media (`PERFORMANCE.md` §1).
* **Security invariants never shown as "design":** a profile surface that prints a credential-bearing field, a public surface that reveals exact occupancy/per-seat identity/attendance-derived state, or an error that leaks existence — these are `CONFLICT`, not `APPROVED` with a note.

## 5. QA checklist (per surface — all rows apply unless N/A is justified)

### 5.1 Source and scope
- [ ] Source family is one of §2 and cites the governing frozen section (`14A.x`/`14B.x`/`SEAT-FR-*`) and PRD version — no invented requirement.
- [ ] No frozen PRD, ADR, BC owner, permission, or architecture edge/contract is changed, invented, or waived; any new design claim has a traceability row or explicit `TO BE DECIDED`.
- [ ] The surface does not duplicate behaviour owned by another surface (search, marketplace, seat, membership, analytics, booking — traceable via [`DESIGN_IMPLEMENTATION_TRACEABILITY.md`](DESIGN_IMPLEMENTATION_TRACEABILITY.md)).

### 5.2 UX, IA, and required journey
- [ ] Entry point, current context (library/tenant/shift scope where applicable), primary action, completion, failure, recovery, and return path are all visible or reachable.
- [ ] Library discovery ordering is `Search or Nearby → Results → Library Profile → Availability → Shift/Seat → Booking Outcome` where applicable (`USER_FLOWS.md` §1); deviations are justified and do not create a second booking path.
- [ ] No step invents a role, permission, or backend transition not owned by its BC.

### 5.3 Visual and component
- [ ] `70% clean 2D · 25% subtle depth · ≤5% premium 3D` ratio and its stated exclusions are respected (`DESIGN_FOUNDATION.md` via `DDR-0013`).
- [ ] Tokens used are decided: colour (`DDR-0001`), spacing (`DDR-0027`), radius/elevation (`DDR-0028`), type family/licence (`DDR-0029`), sizes/line-heights (`DDR-0031`), weights (`DDR-0032`). Any delta to `theme.dart` is named as implementation conformance and does not make this document approve it.
- [ ] Every interactive component shows its required states (default, hover/focus where applicable, active/pressed, disabled, error, loading, empty) and the focus ring meets the adopted contrast.

### 5.4 Accessibility — WCAG 2.1 AA via `DDR-0004`, detailed at [`ACCESSIBILITY.md`](ACCESSIBILITY.md)
- [ ] Contrast: text `≥ 4.5:1` (large text `≥ 3:1`), UI component boundaries meet AA, focus indicator meets contrast and is not colour-only.
- [ ] Text scaling: layout remains usable at 200% text scale and at narrow viewport; no content is clipped or unreachable.
- [ ] Focus: visible, ordered, persistent through state change (S2/S5/S9), not trapped without a source-backed reason; escape/return is reachable by keyboard, switch, and screen reader.
- [ ] Naming: every action-bearing surface has an accessible name, role, and state; live regions announce `S5/S6/S7/S9/S12` transitions without duplicating success.
- [ ] Input: touch target `≥ 48dp` with `≥ 8dp` separation (`DDR-0004`); keyboard/switch/screen-reader and touch paths exist for every essential action.
- [ ] Non-colour communication: success/warning/danger/information never rely on colour alone (icon/label/pattern accompanies `DESIGN_SYSTEM.md` §2 semantic roles).
- [ ] Motion: reduced-motion alternative exists; no essential information depends on animation or timed transition.
- [ ] Any accessibility exception cites `ACCESSIBILITY.md` §2 exception procedure with **owner + expiry/review date**; undocumented exceptions are `RETURNED`.

### 5.5 Responsive and performance — [`RESPONSIVE_DESIGN.md`](RESPONSIVE_DESIGN.md) · [`NFR_BUDGETS_V1.md`](NFR_BUDGETS_V1.md) · `DDR-0034`
- [ ] All three responsive classes are shown where layout changes: `< 600dp` compact, `600–904dp` medium, `≥ 905dp` expanded; `D-1` medium single-column / two-pane-only-at-≥905dp holds.
- [ ] Performance treatment respects the five V1 hard ceilings **measured against the `DDR-0034` target class** (do not re-state numbers here — cite `NFR_BUDGETS_V1.md` §1 by row); a treatment that violates a ceiling is `RETURNED`, not waived.
- [ ] Degraded behaviours are designed: long content, slow network, offline/stale (§3 S9), missing asset, low-end device — primary task remains reachable (§4 view/network reality).

### 5.6 Handoff
- [ ] Figma artifact is canonical, versioned, and linked (frame/page URL + version/date); the reviewed artifact version is the version recorded in evidence.
- [ ] Tokens/variables map to decided values; any Figma variable with no decided token is `TO BE DECIDED`.
- [ ] Open questions and unresolved decisions are visible on the frame (not hidden in comments) and cite their `DBT-*`/`DD7-GAP-*`/`SPX-GAP-*` row.

### 5.7 Security and privacy restraint — [`SECURITY_PRIVACY_UX.md`](SECURITY_PRIVACY_UX.md)
- [ ] No security or privacy behaviour is depicted that no frozen source defines; any such behaviour is `TO BE DECIDED` and cites its `SPX-GAP-*` row — this is a **restraint check, not a new requirement**.
- [ ] No credential, token, or `sub`/email-as-identity is displayed, logged, or inferable from the design.

## 6. Error, recovery, and return — the minimum every flow demonstrates

| Situation | Required outcome | Recovery / return |
|---|---|---|
| Network/service failure (S5) | Named error with retry that actually retries the owning operation | Retry, cancel, and return to the prior stable context without data loss |
| Not found / unavailable (S6) | Single indistinguishable response for private and non-existent (library); seat-unavailable with reason drawn from source | Back to results/profile or seat list; no dead end |
| Not eligible / rejected (S7) | Reason code from source, no invented policy wording | Corrective action or alternative path as source defines; no alternative booking claim |
| Permission / session (S8) | Signed-out/expired state with sign-in CTA (Google Sign-In per `ADR-0129`/Auth v3.0 for V1) | Return to entry after sign-in; no demo/seeded bypass (`TASK-D10`, `MP-CON-11`) |
| Stale / offline (S9) | Stale marker + last-known timestamp or "unavailable offline"; never live occupancy | Clear offline banner; retry when online; no stale booking claim |

## 7. Test strategy — thin evidence acknowledged, review judgement prescribed

* **Authoritative debt:** `DBT-004` measures **1** `testWidgets` assertion repository-wide; the **819**-test suite tests domain rules, not UI. QA therefore rests primarily on **review judgement** and must be honest about it: any surface with no `testWidgets`/screenshot evidence is recorded as `NONE OBSERVED`, not `PASS`.
* **Required evidence mix per surface:** (a) annotated Figma/screenshot showing states S1–S12 as applicable (or explicit N/A with reason); (b) accessibility review notes per §5.4; (c) responsive frames per §5.5; (d) where a `testWidgets` exists, its file/line and what it asserts — never "tests exist".
* **No gate inflation:** a review record that claims UI test coverage where `DBT-004` still measures `1` is `CONFLICT` and is `RETURNED`.
* **Implementation comparison (when a build exists):** Figma-vs-build side-by-side for token mapping deltas (`accent-ink`, `text-muted`, `border/control` per `DESIGN_SYSTEM.md` §2) — deltas are implementation work, not grounds to claim the design was wrong.
* **Devanagari/script rendering:** separate from general QA — governed by [`DEVANAGARI_RENDERING_PROBE.md`](DEVANAGARI_RENDERING_PROBE.md) against the `DDR-0034` class; a general QA `APPROVED` does not imply a script rendering pass.

## 8. Acceptance criteria — when a surface is `APPROVED`

A surface is `APPROVED` iff **all** of the following hold; any other outcome is `RETURNED` (fixable) or `CONFLICT` (requires a ranked source to change):

1. Every applicable state in §3 is shown or is N/A with a written reason; no applicable state is quietly omitted.
2. Edge cases in §4 that apply to the surface are shown or are N/A with reason; the invariants are not violated.
3. Checklist §5 is met row-for-row (or N/A justified); each accessibility check in §5.4 is met or has a documented owner+expiry exception.
4. Responsive classes + performance ceilings (§5.5) are evidenced against `NFR_BUDGETS_V1.md` and the `DDR-0034` target class.
5. Security/privacy restraint (§5.7) holds — no gap row is depicted as a feature.
6. Handoff (§5.6) is complete and versioned; evidence is recorded via [`templates/DESIGN_QA_EVIDENCE_TEMPLATE.md`](templates/DESIGN_QA_EVIDENCE_TEMPLATE.md) with artifact version and reviewer role.
7. Evidence honesty (§7) holds — `NONE OBSERVED` where applicable, no inflated test claim.

## 9. Blocking conditions — `RETURNED` vs `CONFLICT`

* **`RETURNED` (fix within design):** unresolved but design-owned issue — missing critical state, inaccessible essential action, duplicate behaviour, performance treatment that violates the foundation, unsupported capability claim that can be removed or marked `TO BE DECIDED`.
* **`CONFLICT` (cannot be fixed within design):** the fix would require changing a frozen PRD section, an ADR, BC ownership, a permission, an `SPX-GAP-*` security/privacy behaviour, or an architecture edge/contract. A `CONFLICT` is routed via [`DESIGN_CHANGE_MANAGEMENT.md`](DESIGN_CHANGE_MANAGEMENT.md) and [`DESIGN_GOVERNANCE.md`](DESIGN_GOVERNANCE.md); it is not resolved by editing the design file.

## 10. Evidence

QA evidence is a Figma review record, annotated screenshots, a state matrix (§3), an accessibility review (§5.4), an asset/performance note (§5.5), or an implementation comparison (§7). Every record identifies **artifact version and reviewer role** and is filed via [`templates/DESIGN_QA_EVIDENCE_TEMPLATE.md`](templates/DESIGN_QA_EVIDENCE_TEMPLATE.md).

> ⚠️ **Evidence availability is thin, and this stronger checklist outweighs it.** `DBT-004` still measures **1** `testWidgets` repository-wide — see that row before assuming automated UI evidence exists. The **819**-test strength is in domain rules, not UI.

## 11. Relationship to other records

* **G4:** this document states the **criteria**; `G4` is the **outcome** at [`G4_DESIGN_QA_RECORD_2026-10-01.md`](G4_DESIGN_QA_RECORD_2026-10-01.md) and its cumulative evidence at [`G4_QA_REVIEW_RECORDS_2026-10-01.md`](G4_QA_REVIEW_RECORDS_2026-10-01.md).
* **Gates G0–G5 / closure pack / dashboard:** criteria here do not imply any gate is passed; see [`LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md`](LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md) §13 + [`LIBOORA_OWNER_CLOSURE_DASHBOARD.md`](LIBOORA_OWNER_CLOSURE_DASHBOARD.md) + [`DESIGN_DEBT.md`](DESIGN_DEBT.md) `DBT-008` for gate-limb status (G0–G4 `PASSED/CONFIRMED`, G5 + final authority still pending).
* **Debt and deprecation:** QA findings that are debt (divergence) or deprecation (supersession) are filed in [`DESIGN_DEBT.md`](DESIGN_DEBT.md) — QA does not deprecate by deletion.

---

*Reviewed against: `ACCESSIBILITY.md` (WCAG 2.1 AA via DDR-0004) · `DESIGN_SYSTEM.md` (70/25/5, token decisions) · `DESIGN_FOUNDATION.md` · `FIGMA_FOUNDATION.md` · `INFORMATION_ARCHITECTURE.md` · `RESPONSIVE_DESIGN.md` + DDR-0034 · `NFR_BUDGETS_V1.md` · `PERFORMANCE.md` · `SECURITY_PRIVACY_UX.md` · `SCREEN_ARCHITECTURE.md` · `USER_FLOWS.md` · `UX_ARCHITECTURE.md` · `VISUAL_LANGUAGE.md` · `DESIGN_GOVERNANCE.md` · `DESIGN_CHANGE_MANAGEMENT.md` · `DESIGN_DEBT.md` · templates.*
