<!-- LIBOORA Design Documentation Foundation | design debt and deprecation register -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design Debt & Deprecation Register

| Field | Value |
|---|---|
| Status | ⚠️ **DEBT REGISTER** — records measured debt. ⛔ It resolves none of it |
| Owner | Design Governance Owner *(register)*; each row names its own deciding office |
| Rank | **UNRANKED.** Carries no precedence over any ranked document |
| Rule | A row states what is **measured**, who owns it, and what would trigger review. ⛔ It does not prescribe the fix |

## 1. Purpose

[`DESIGN_CHANGE_MANAGEMENT.md`](DESIGN_CHANGE_MANAGEMENT.md) governs how
design *changes*. Nothing governed how design **decays** — measured across
the sixteen foundation documents, the terms *debt*, *deprecated*, *sunset*
and *retire* occur **0** times. A design system without a deprecation record
accumulates components nobody may delete because nobody recorded that they
were superseded.

This register carries two kinds of entry:

* **Debt** — a known divergence between documented intent and observed
  reality.
* **Deprecation** — a design artifact, token or component deliberately
  superseded, retained so readers know it is no longer current.

⛔ **Recording debt is not authorising its repair.** Several rows below
require a Design System Owner or Founder/Product Authority decision, and
this document takes none of them.

## 2. Register

| ID | Class | Finding *(measured)* | Impact | Owning office | Review trigger | Status |
|---|---|---|---|---|---|---|
| `DBT-001` | **Debt — documentation vs code** | ⭐ **[`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §2 declared colour and spacing token values `TO BE DECIDED` while `lib/app/shared/theme.dart` already defined them**: `LiblColors` (**12** colour constants) and `LiblSpace` (**6** steps). Dates: `theme.dart` **2026-09-07**, design foundation **2026-09-09** — the documentation was the later artifact. ⭐ **Now decided by limb** (`DESIGN_DEBT.md` §3 rule 5 — closed only by the owning office's act, never a silent edit): **Colour limb** → ⭐ aligned to `APPROVED` `DDR-0001` (5 amended + 7 unchanged tokens) · **Spacing limb** → ⭐ **ratified** at [`DDR-0027`](design-decisions/DDR-0027-dbt-001-b1-liblspace-ratification-and-foundation-alignment.md) (Design System Owner; `LiblSpace` `xs 4 · sm 8 · md 12 · lg 16 · xl 24 · xxl 32` = the shipped values, 0 implementation delta) · ⭐ **Typography-family limb** → **decided** at [`DDR-0029`](design-decisions/DDR-0029-dbt-001-dbt-005-typeface-family-and-licence-decided.md) (`Noto Sans` + `Noto Sans Devanagari`, **SIL OFL**; requirement `APPROVED` at `DDR-0002`) — the type-token-class *scale set* was carried into `DBT-005` and remains an open decision there | Design documentation described as open a decision engineering had already shipped; now fully resolved: colour `DDR-0001` · spacing `DDR-0027` · typography-family `DDR-0029` (type-token-class scale set carried to `DBT-005`) | **Design System Owner** | A token change in either direction, or approval of the design system foundation *(all three limbs satisfied: spacing `DDR-0027`, colour `DDR-0001`, typography-family `DDR-0029`)* | ⭐ **RESOLVED** — Colour ⭐ `DDR-0001` · Spacing ⭐ `DDR-0027` · Typography-family ⭐ `DDR-0029` |
| `DBT-002` | **Debt — no owning document** | **Closed by the owning office's act.** [`DESIGN_OWNERSHIP.md`](DESIGN_OWNERSHIP.md) §1 constitutes a *Responsive Design Owner* who "owns breakpoint behaviour, layout adaptation, and device-mode rules". ⭐ **The responsive specification is APPROVED at [`RESPONSIVE_DESIGN.md`](RESPONSIVE_DESIGN.md)** (v0.1, 2026-10-01) — it carries `DDR-0005`'s **APPROVED** classes (`< 600dp` compact · `600–904dp` medium · `≥ 905dp` expanded) and `DDR-0004`'s APPROVED density rules, and records **D-1 (medium single-column; two-pane only at ≥ 905dp) through D-4 as approved by the Responsive Design Owner** · ⛔ **no breakpoint value differs from `DDR-0005`** · approval recorded in [`RESPONSIVE_DESIGN_APPROVAL_RECORD_2026-10-01.md`](RESPONSIVE_DESIGN_APPROVAL_RECORD_2026-10-01.md) | An approved responsive specification now exists; the `G3` handoff gate and [`DESIGN_QA.md`](DESIGN_QA.md) §5.5 can evaluate responsive evidence against it. ⛔ **G2 is not passed by this closure** | **Responsive Design Owner** | A new breakpoint value or form factor, or supersession of `RESPONSIVE_DESIGN.md` | ⭐ **CLOSED / RESOLVED** — `RESPONSIVE_DESIGN.md` v0.1 APPROVED (2026-10-01, Responsive Design Owner; D-1…D-4 recorded) |
| `DBT-003` | **Debt — partial coverage** | **Localization is one paragraph and unimplemented.** [`ACCESSIBILITY.md`](ACCESSIBILITY.md) §3 requires writing "for translation" and leaves supported languages `TO BE DECIDED`; measured: **0** occurrences of `flutter_localizations`, `intl` or `AppLocalizations` in `pubspec.yaml` or `lib/`. ⛔ No pluralisation, date/number, text-expansion or bidirectional rule exists | A translation obligation is stated, no mechanism exists, and no artifact defines what "written for translation" requires | Product Owner *(language scope)*, then **Design System Owner** *(text-expansion rules)* | Approval of any second language | ⛔ **OPEN** |
| `DBT-004` | **Debt — thin evidence base** | **The QA gate outweighs its evidence.** [`DESIGN_QA.md`](DESIGN_QA.md) §5.1–§5.7 specifies **7** check categories; measured: **1** `testWidgets` assertion exists in the entire repository (`test/widget_test.dart`, *"app renders the login screen on first frame"*), against **819** passing tests overall — i.e. ⛔ **the test suite is strong on domain rules and near-silent on UI behaviour** | A `G4` pass would rest on review judgement alone for every surface but one | **Design QA Owner**, with the engineering counterpart | Any surface entering `G4` | ⛔ **OPEN** |
| `DBT-005` | **Debt — untokenised values** | **Radius was used but not tokenised** (`theme.dart` carried **7** `BorderRadius.circular(...)` calls across **3** values `12`/`14`/`18` with ⛔ **no `LiblRadius` class**; elevation and typography shared the position). ⭐ **Now decided by limb** (`DESIGN_DEBT.md` §3 rule 5 — closed only by the owning office's act, never a silent edit): **Radius limb** → ⭐ **ratified** at [`DDR-0028`](design-decisions/DDR-0028-dbt-005-radius-elevation-token-scales-decided.md) on `APPROVED` `DDR-0003` values (`LiblRadius` = `sm 8 · md 12 · lg 16`; ⛔ `14`/`18` retired; pill = status chips only) · **Elevation limb** → ⭐ **decided** at `DDR-0028` (3-level semantic, decoration-free scale: `elev/0` flat default · `elev/1` hairline + one soft y-shadow · `elev/2` transient overlays; ⛔ no `elev/3+`, no coloured shadows) · ⭐ **Type-token-class limb** → **RESOLVED** — family + licence were decided by [`DDR-0029`](design-decisions/DDR-0029-dbt-001-dbt-005-typeface-family-and-licence-decided.md) (`Noto Sans` + `Noto Sans Devanagari` / **SIL OFL**); sizes + line-heights were decided by [`DDR-0031`](design-decisions/DDR-0031-dbt-005-typography-sizes-and-line-heights-ratified.md); weights were decided by [`DDR-0032`](design-decisions/DDR-0032-dbt-005-typography-weight-token-set-decided.md) (`400` Regular · `500` Medium · `600` SemiBold · `700` Bold; `800+` excluded from V1). The `LiblText` class and other implementation-conformance work remain separate engineering work and do **not** reopen `DBT-005` | Three unexplained radii will be copied forward as precedent; a Figma variable has nothing to map to — now mitigated: the scale is decided, code conformance remains separate implementation work | **Design System Owner** | Introduction of a radius, elevation or type token set *(radius + elevation satisfied by `DDR-0028`; type-token set fully decided: family+licence `DDR-0029`, sizes+line-heights `DDR-0031`, weights `DDR-0032`; implementation conformance remains separate)* | ⭐ **RESOLVED** — Radius ⭐ `DDR-0003`+`DDR-0028` · Elevation ⭐ `DDR-0028` · Type-token class: family+licence ⭐ `DDR-0029` · sizes+line-heights ⭐ `DDR-0031` · weights ⭐ `DDR-0032` (all five limbs decided); implementation conformance remains separate engineering work |
| `DBT-006` | **Debt — design/implementation divergence** | Founder/Product Authority **OPTION C** scope decision (2026-09-30) reconciled in `DESIGN_IMPLEMENTATION_TRACEABILITY.md` §8.1: Master PRD V1 modules/role compositions and frozen Library §§14A/14B, PRD-004/006/007 requirements support source-bounded journeys and compositions; Staff & Shift and Community are V2; unsupported observed files are explicitly deferred. PRD-021C component drafts are not treated as independent authority; frozen Library/Seat evidence bounds discovery/profile/seat behavior. DBT-006-related base DIT metrics: **3/8** PRD-linked; with supplemental DIT-009, **4/9** (DIT-003 is authentication and outside DBT-006) | Surface mapping and V1 disposition reconciliation are recorded. **G1 outcome: PASSED / CONFIRMED** — recorded 2026-10-01 in [`G1_EXPERIENCE_ARCHITECTURE_APPROVAL_RECORD_2026-10-01.md`](G1_EXPERIENCE_ARCHITECTURE_APPROVAL_RECORD_2026-10-01.md) by the UX Architecture Owner (with the Information Architecture Owner for IA/navigation). This gate act does not approve implementation, QA, G2–G5, or navigation labels | **UX Architecture Owner** and **PRD→Design Traceability Owner** for reconciliation (done); **G1 gate owner** recorded the separate gate act | Record the separate G1 owner act (done 2026-10-01); reopen the mapping only if superseding authoritative source evidence is provided | ⚠ **RECONCILED — G1 PASSED / CONFIRMED** (2026-10-01); no unresolved DBT-006 V1 surface mapping remains; navigation labels remain TO BE DECIDED (escalated to Founder/Product Authority) |
| `DBT-007` | **Debt — structural duplication** | **Two design directories exist.** `docs/design/` holds the foundation; [`../35-design/`](../35-design/README.md) holds per-feature Design Docs and contains **6** empty context directories and **0** Design Docs. Its own README §6 records the split as deliberate and explains that consolidating would break **16** documents' relative sibling links | A reader must know both exist. ⚠️ The risk is *low while documented and rising if undocumented* — which is why this row exists | **Design Documentation Owner** | Either directory gaining a document that plainly belongs in the other | ⚠️ **ACCEPTED, DOCUMENTED** — ⛔ not scheduled for repair |
| `DBT-008` | **Debt — surviving gate-limb status** | Earlier design decisions and artifact approvals do not imply gate passage. The surviving condition is explicit: `G0`–`G5` exist; `G0` is **PASSED / CONFIRMED** by [`G0_SOURCE_AUDIT_RECORD_2026-09-30.md`](G0_SOURCE_AUDIT_RECORD_2026-09-30.md), `G1` is **PASSED / CONFIRMED** by [`G1_EXPERIENCE_ARCHITECTURE_APPROVAL_RECORD_2026-10-01.md`](G1_EXPERIENCE_ARCHITECTURE_APPROVAL_RECORD_2026-10-01.md), `G2` is **PASSED / CONFIRMED** by [`G2_FOUNDATION_APPROVAL_RECORD_2026-10-01.md`](G2_FOUNDATION_APPROVAL_RECORD_2026-10-01.md), `G3` is **PASSED / CONFIRMED** by [`G3_HANDOFF_APPROVAL_RECORD_2026-10-01.md`](G3_HANDOFF_APPROVAL_RECORD_2026-10-01.md) *(G3 recorded-outcome limb updated by the G3 gate act, 2026-10-01; prior state retained: `G2` PASSED with `G3`–`G5` unrecorded)*, `G4` is **PASSED / CONFIRMED** by [`G4_DESIGN_QA_RECORD_2026-10-01.md`](G4_DESIGN_QA_RECORD_2026-10-01.md) *(G4 recorded-outcome limb updated by the G4 gate act, 2026-10-01; prior state retained: `G3` PASSED with `G4`–`G5` unrecorded)*, while `G5` remains unrecorded. `DDR-0033` clarifies/re-scopes this row to that gate-limb condition without passing any later gate; ⭐ **`G5` closure deferred to V2** at [`DDR-0035`](design-decisions/DDR-0035-g5-closure-deferred-to-v2-option-a.md) *(Option A, 2026-10-03 — routing only; `CP-B1`/M1 evidence remains pending/unverified; the `DDR-0002` V1 Indic/Devanagari requirement remains in force)*; ⭐ **`CP-B1`/M1 verification also deferred to V2** at [`DDR-0036`](design-decisions/DDR-0036-cp-b1-m1-verification-deferred-to-v2.md) *(2026-10-03 — routing only; no M1 result asserted; `DDR-0012` stays reserved-and-free; D5 = NO V1 SCOPE CUT)* | Final foundation/status closure requires evidence-backed outcomes for `G0`–`G5` and the applicable final authority act; `DESIGN_FOUNDATION.md` §8's completion rule remains unmet | **Design Governance Owner** for re-scope/process routing; **Founder/Product Authority** for final foundation/status authority | Recorded gate outcomes and final authority act | ⛔ **OPEN** — `G4` limb now recorded (2026-10-01); `G5` still unrecorded (deferred to V2 per `DDR-0035`, Option A; M1 verification deferred to V2 per `DDR-0036`); final authority act still pending |

| `DBT-009` | **Deprecation** | ⭐ **`DDR-0002` V1 requirement limb superseded-for-V1.** The `APPROVED` `DDR-0002` clause *(Indic/Devanagari student names MUST be supported in V1, guaranteed rendering — `DDR-0001-to-0009…md` §57)* is **SUPERSEDED-for-V1** by [`DDR-0037`](design-decisions/DDR-0037-ddr-0002-v1-indic-name-support-moved-to-v2.md) *(accepted 2026-10-07 under the recorded Founder/Product Authority one-act conferral; D5 = V1 SCOPE CUT, design layer). The historical `DDR-0002` record and its `D-2` / `MP-CON-12` provenance are **preserved, not rewritten**; the `DDR-0002` identifier is **never reused** (§3 rule 5). The Indic/Devanagari name-rendering duty is **scheduled to V2, not waived**. ⛔ The paired search-track limb supersession (`ADR-0174`) **remains a separate pending act** — `DBT-009` records the design-layer deprecation only | `DESIGN_DEBT.md` §3 rule 1 (add a Deprecation row naming the successor) + rule 5 (never reuse the retired identifier) | The owning office of `DDR-0002` records the supersession | Entry into V2 · any re-entry of Indic/Devanagari into the V1 contract | ⭐ **RECORDED** — deprecation row added 2026-10-07; successor = `DDR-0037`; `DDR-0002` byte-unchanged |
### 2.1 Register measures

| Measure | Value |
|---|---|
| Rows | **9** |
| `OPEN` | **3** (`003`, `004`, `008`) |
| `PARTIALLY RESOLVED (by limb)` | **0** — none; `005` fully `RESOLVED` via `DDR-0032` (weights decided) |
| `ACCEPTED, DOCUMENTED` | **1** (`DBT-007`) |
| `Resolved` | **3** (`001` — colour `DDR-0001` · spacing `DDR-0027` · typography-family `DDR-0029` · `002` — responsive artifact v0.1 APPROVED 2026-10-01 by Responsive Design Owner, D-1…D-4 recorded · `005` — radius `DDR-0003`+`DDR-0028` · elevation `DDR-0028` · family+licence `DDR-0029` · sizes+line-heights `DDR-0031` · weights `DDR-0032`) |
| Deprecations recorded | **1** — `DBT-009` *(superseded-for-V1 `DDR-0002` V1 Indic/Devanagari requirement limb; successor `DDR-0037`, accepted 2026-10-07; `DDR-0002` byte-unchanged; `D-2`/`MP-CON-12` provenance preserved)* |
| Owned by Design System Owner | **1** open (`003` in part); `001` `RESOLVED` via `DDR-0029`, `005` `RESOLVED` via `DDR-0032` |
| Requiring Founder/Product Authority | **2** (`006`, `008`) |

## 3. Deprecation procedure

⛔ **No artifact is deprecated by deletion.** To deprecate:

1. Add a row here with class **Deprecation**, naming the superseding
   artifact. A deprecation that names no successor is an unexplained
   removal.
2. Mark the artifact `SUPERSEDED` using the
   [`DESIGN_GOVERNANCE.md`](DESIGN_GOVERNANCE.md) §2 vocabulary, ⛔ not a
   second competing set.
3. Leave it readable. It records why current work looks as it does — the
   rule [`../35-design/README.md`](../35-design/README.md) §4 already states.
4. Record the change under
   [`DESIGN_CHANGE_MANAGEMENT.md`](DESIGN_CHANGE_MANAGEMENT.md) §4.
5. ⛔ **Never reuse the retired identifier.**

## 4. Filing rules

1. **A row states a measurement, not an opinion.** "The spacing feels
   inconsistent" is not a row; "`6` spacing steps defined in code, `0` in
   the design system document" is.
2. **Every row names an owning office** — a **role**, never a personal name.
3. **Every row carries a review trigger.** Debt with no trigger is never
   revisited.
4. **`DBT-*` identifiers are never reused or reassigned.**
5. **⛔ A row is never closed by editing the document it indicts** unless the
   owning office decided it. Silently "fixing" `DBT-001` by writing the
   code's token values into [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) would
   convert an engineering default into design authority without the Design
   System Owner's act — which is precisely the ratification this register
   must not perform.
