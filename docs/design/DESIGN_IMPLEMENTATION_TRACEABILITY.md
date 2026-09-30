<!-- LIBOORA Design Documentation Foundation | design to implementation traceability -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design to Implementation Traceability

| Field | Value |
|---|---|
| Status | PROPOSED — traceability **structure**; the register is deliberately near-empty |
| Owner | Design–Engineering Handoff Owner |
| Co-owner | PRD→Design Traceability Owner for the upstream link |
| Rank | **UNRANKED.** Carries no precedence over any ranked document |
| Rule | A row records **observed** artifacts. ⛔ An unobserved mapping is left blank, never guessed |

## 1. Why this document exists

[`PRD_DESIGN_TRACEABILITY.md`](PRD_DESIGN_TRACEABILITY.md) carries the
upstream half of the chain — requirement to design treatment. The downstream
half had **no home**: measured across the sixteen foundation documents,
there were **0** references to any `IMPL-*` task, **0** references to any
`lib/` path and **0** references to a Flutter widget or screen file.

[`DESIGN_ENGINEERING_HANDOFF.md`](DESIGN_ENGINEERING_HANDOFF.md) §1 already
requires a handoff package to carry "PRD traceability", and
[`DESIGN_QA.md`](DESIGN_QA.md) §1 already requires that "every new design
claim has a traceability row". Neither states **where the downstream row
lives**. This document is that place, and it adds no new obligation beyond
the two those documents already impose.

## 2. The chain

```
PRD requirement  →  Design artifact  →  Screen / flow / component  →  Implementation  →  QA evidence
   (Rank 3)          (UNRANKED)              (UNRANKED)               (IMPL-* / lib/…)     (test / review)
```

Each link answers a different question and none substitutes for another:

| Link | Question | Authoritative source |
|---|---|---|
| PRD requirement | What must be true of the product? | The frozen PRD. ⛔ Never restated here as if this document owned it |
| Design artifact | Which design document or Figma frame governs the surface? | `docs/design/` or [`../35-design/`](../35-design/README.md) |
| Screen / flow / component | Which named surface does it describe? | [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) §1, [`USER_FLOWS.md`](USER_FLOWS.md) |
| Implementation | Which task built it, and where does the code live? | `docs/40-implementation/` and the repository |
| QA evidence | What proves it behaves as designed? | A named test, or a dated review record |

## 3. Row completeness

A row is **complete** only with all five links plus an owner. Anything less
is **PARTIAL**, and partial is an acceptable, honest state.

| Field | Required | Rule |
|---|---|---|
| `Trace ID` | yes | `DIT-NNN`, sequential, never reused or reassigned |
| PRD requirement | yes | Requirement identifier and path, or `NONE OBSERVED` |
| Design artifact | yes | Repository path or Figma frame, or `NONE OBSERVED` |
| Surface | yes | Screen family, flow stage or component name |
| Implementation | yes | `IMPL-*` and/or `lib/…` path, or `NONE OBSERVED` |
| QA evidence | yes | Test path and name, or `NONE OBSERVED` |
| Status | yes | `COMPLETE` / `PARTIAL` / `NOT STARTED` / `CONFLICT` |
| Owner | yes | A design or engineering **role**, ⛔ never a personal name |

⛔ **`NONE OBSERVED` is a finding, not a failure, and never a placeholder for
a guess.** Writing a plausible-looking `IMPL-*` number into a row would make
this register actively harmful: a reader would trust a mapping nobody
verified.

## 4. Register

⚠️ **Base-register rows record traceability, not implementation or QA approval.**
The proposed screen inventory contains **7** items ([`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md)
§1): **5** proposed discovery/booking families (Discover/Search, Library
Profile, Availability, Shift/Seat selection, Booking outcome), one inherited
Operational Dashboard composition, and one Community surface marked
`TO BE DECIDED`. The shipped application separately contains **11** observed
staff/student operational screens. These inventories were produced
independently; no complete design-to-code link is implied.

Rows are recorded for the implemented surfaces because they are **observable
facts** that a future design pass will need. Recording them does not approve
them, and does not assert that any of them was designed.

| Trace ID | PRD requirement | Design artifact | Surface | Implementation | QA evidence | Status | Owner |
|---|---|---|---|---|---|---|---|
| `DIT-001` | `NONE OBSERVED` | `NONE OBSERVED` — ⚠️ `DESIGN_SYSTEM.md` §2 declares these values `TO BE DECIDED` while the code defines them; see [`DESIGN_DEBT.md`](DESIGN_DEBT.md) `DBT-001` | Design tokens — colour and spacing | `lib/app/shared/theme.dart` — `LiblColors` (**12** colour constants), `LiblSpace` (**6** spacing steps) | `NONE OBSERVED` | **CONFLICT** | Design System Owner |
| `DIT-002` | `NONE OBSERVED` | `NONE OBSERVED` | Shared component set | `lib/app/shared/widgets/common.dart` — **7** widgets: `MetricTile`, `SectionHeader`, `Pill`, `Monogram`, `EmptyState`, `PanelCard`, `MeterBar` | `NONE OBSERVED` | PARTIAL | Component Architecture Owner |
| `DIT-003` | `PRD-001` — Authentication, V1 (Master PRD §8 module 1) | `SCREEN_ARCHITECTURE.md` §2 (shared entry/recovery anatomy) | Sign-in surface | `lib/app/shared/login_screen.dart` | `test/widget_test.dart` — *"app renders the login screen on first frame"* | PARTIAL | UX Architecture Owner |
| `DIT-004` | `NONE OBSERVED` | `NONE OBSERVED` | Application chrome and branch switcher | `lib/app/shared/app_chrome.dart`, `lib/app/shared/account_sheet.dart` | `NONE OBSERVED` | PARTIAL | UX Architecture Owner |
| `DIT-005` | `MASTER_PRD.md` §8 modules 7, 8, 9, 10–12 (V1 role/module authority); `PRD-SEAT-MANAGEMENT.md` `SEAT-FR-004`, `055`, `059`, `062` (frozen V1 seat operations); `PRD-006` attendance requirements; `PRD-008` `FEE-FR-022`, `053`–`055` (Revenue & Finance is V1 but source remains DRAFT; not freeze authority) | `SCREEN_ARCHITECTURE.md` §1; `USER_FLOWS.md` §2 | Staff operational inventory; see §8.1 dispositions before treating any named file as retained | `lib/app/staff/` — **7** observed screens | `NONE OBSERVED` | PARTIAL | UX Architecture Owner |
| `DIT-006` | `MASTER_PRD.md` §8 modules 3–5 (V1); frozen `Student_Management_PRD_v1.md` §5 `LMD-1`–`LMD-31`, `SM-*` requirements; Parent Portal is a V1 composition over `BC-01`, `BC-03`, `BC-05` | `SCREEN_ARCHITECTURE.md` §1; `INFORMATION_ARCHITECTURE.md` §2; `USER_FLOWS.md` §2 | Student/parent inventory; see §8.1 dispositions; module-level authority does not approve unspecified dashboard content | `lib/app/student/` — **4** observed files | `NONE OBSERVED` | PARTIAL | UX Architecture Owner |
| `DIT-007` | `NONE OBSERVED` | [`ACCESSIBILITY.md`](ACCESSIBILITY.md) §2 — **9** required checks | All surfaces | `NONE OBSERVED` — measured: **0** occurrences of `Semantics`, `semanticsLabel`, `meetsGuideline` or `textScaleFactor` under `lib/` | `NONE OBSERVED` — **0** accessibility assertions under `test/` | **NOT STARTED** | Accessibility Owner |
| `DIT-008` | Frozen `Library_PRD_v1.md` §§14A.3–14A.5 and `14B-Public-Library-Preview.md` `LIB-14B.2`, `.7`–`.14` (public discovery/profile and aggregate-only public seat facts); frozen `PRD-SEAT-MANAGEMENT.md` `SEAT-FR-004`, `.076`–`.086` (private student self-booking, default-disabled); `MASTER_PRD.md` §8 module 19 | [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) §1; `USER_FLOWS.md` §1; `INFORMATION_ARCHITECTURE.md` §2 | Five designed families: Discover/Search, Library Profile, Availability, Shift/Seat, Booking outcome | `NONE OBSERVED` — no discovery/profile/booking screen exists under `lib/app/` | `NONE OBSERVED` | **NOT STARTED** | UX Architecture Owner |

### 4.1 What the register measures

| Measure | Value |
|---|---|
| Rows | **8** |
| `COMPLETE` | **0** |
| `PARTIAL` | **5** |
| `NOT STARTED` | **2** |
| `CONFLICT` | **1** |
| Base-register rows with a PRD requirement link | **4 of 8** (`DIT-003`, `DIT-005`, `DIT-006`, `DIT-008`) |
| Including supplemental `DIT-009` | **5 of 9** rows have a PRD requirement link (`DIT-009` → `PRD-005` §20) |
| Base-register rows with any QA evidence | **1 of 8** |
| Supplemental `DIT-009` QA | 15 membership test files are listed as domain-level evidence; **0 surface tests** — not counted as surface QA |

The four linked rows cite the existing V1 sources at module/requirement scope;
they do not imply every observed file or design state is retained. Rows without
a supported upstream source remain `NONE OBSERVED`. Supplemental `DIT-009`
is distinct and does not authorize the unrelated dashboard inventory.

### 4.2 ⭐ First feature-level design row

| Trace ID | PRD requirement | Design artifact | Surface | Implementation | QA evidence | Status | Owner |
|---|---|---|---|---|---|---|---|
| `DIT-009` | ⭐ **`PRD-005` §20 — 13 UI/UX rows** (`PRD-MEMBERSHIP-MANAGEMENT.md` L1436, FROZEN v1.4; source recorded by `DD-0001` §5) | ⭐ [`../35-design/membership/DD-0001-membership-management-surface-design.md`](../35-design/membership/DD-0001-membership-management-surface-design.md) | 13 `BC-02` membership surfaces `S-1`…`S-13`, 6 states each (`DD-0001` **v0.2**) | ⚠️ `IMPL-409`/`432`/`433`/`434`/`436` — **all 5 blocked** by `ADR-0012` §3.4 | 15 membership test files *(domain-level; ⛔ **0** surface tests)* | ⛔ **BLOCKED** | UX Architecture Owner |

⭐⭐ The base register has **4/8** linked rows; including this supplemental row,
the combined count is **5/9**. ⛔ It does **not**
discharge `DIT-OD-001`, whose scope is the base register.

⚠️ It is `BLOCKED` rather than `PARTIAL` for a measured reason — **every**
`app`-module task in `PRD-005`'s register is one of the five `ADR-0012` §3.4
blocked tasks, so no membership surface is implementable as designed today.
See `DD-0001` §5.1.

## 5. Governing constraint — the `app` boundary

Any design that proposes a screen reading domain data directly must respect
a rule this register cannot waive.

`tool/module_dependencies.yaml` declares `domain/library` under the `app`
module's `ports:`, **not** its `imports:`. An `app` file importing a domain
barrel is therefore a boundary violation, and
`tool/check_module_boundaries.dart` reports exactly **9** such pre-existing
findings. `DOCUMENTATION_BASELINE.md` records that this gate "**exits 1 by
design**" and "**must not** be silenced".

⛔ **Design cannot resolve this and must not design around it silently.** A
surface needing data not currently projected to `app` is an **engineering
seam question** for the Architecture Owner, routed through
[`DESIGN_ENGINEERING_HANDOFF.md`](DESIGN_ENGINEERING_HANDOFF.md) §3 — not a
design decision.

## 6. Filing rules

1. **One row per traceable surface**, not per commit.
2. **Add the row at handoff**, when the implementation link becomes real —
   not when the design is drafted.
3. **Cite paths, not prose.** A row saying "the dashboard" is not traceable.
4. **A row is never deleted.** A superseded row is restatused and left
   readable, for the reason [`../35-design/README.md`](../35-design/README.md)
   §4 gives: the record of why something looks the way it does outlives the
   work.
5. **A `CONFLICT` row is escalated, not resolved here** — see
   [`DESIGN_CHANGE_MANAGEMENT.md`](DESIGN_CHANGE_MANAGEMENT.md) §1 class
   `D4`.
6. **⛔ Never infer a link from a filename.** `seat_map_page.dart` existing
   does not mean the Shift/Seat screen family was implemented as designed;
   `DIT-005` and `DIT-008` are deliberately separate rows for that reason.

## 7. Open items

| ID | Item | Owner | Status |
|---|---|---|---|
| `DIT-OD-001` | **Authority mapping completed at the level supported by existing artifacts** in §8.1: the four supported base links are recorded and unsupported inventory items are explicitly deferred. Draft PRD requirements are not represented as approved authority. | PRD→Design Traceability Owner | ✅ CLOSED — base rows linked where supported; unsupported surfaces dispositioned |
| `DIT-OD-002` | **V1 surface reconciliation recorded in §8.1.** Master PRD, frozen Library/Student/Seat sources and registered role compositions define retained scope; Staff & Shift and Community are V2; unsupported observed screens are deferred. | UX Architecture Owner with PRD→Design Traceability Owner | ✅ CLOSED — all listed surfaces mapped or explicitly deferred |
| `DIT-OD-003` | **Accessibility evidence gap:** `DIT-007` records 0 occurrences of `Semantics`, `semanticsLabel`, `meetsGuideline`, or `textScaleFactor` under `lib/`, and 0 accessibility assertions under `test/`. Record implementation/QA evidence when supplied; do not infer compliance from the requirements document. | Accessibility Owner | ⛔ OPEN — evidence absent |
| `DIT-OD-004` | **Surface QA evidence gap:** the base register has evidence for **1/8** rows only; supplemental `DIT-009` lists 15 domain-level membership test files but **0 surface tests**. Apply [`DESIGN_QA.md`](DESIGN_QA.md) §2 criteria and attach surface-specific evidence before any row is marked `COMPLETE`. | Design QA Owner | ⛔ OPEN — evidence absent for remaining rows |

## 8. DBT-006 scope boundary and reconciliation requirement

**Founder/Product Authority decision — OPTION C (2026-09-30):** Neither the proposed
screen families nor the currently implemented staff/student screens is independently
authoritative for V1. Reconciliation uses approved/frozen V1 PRDs and the established
product role structure, as mapped below.

The implementation register must not infer authority from filenames or existing code.
For every retained surface, the PRD→Design and Design→Implementation rows must identify
an applicable V1 PRD, approved requirement, or established role/workflow. This includes
Student/Parent discovery-to-booking journeys and Reception, Manager, and Owner
operational workflows. Surfaces without that authority remain unresolved or deferred,
or are removed from V1 design scope.

This is a product-scope boundary, not implementation approval. The mapping below
resolves the documentation reconciliation only; it does not approve implementation,
QA, or constitute the separate G1 gate-owner act.

### 8.1 Per-surface evidence status

`RETAINED — SOURCE-BOUNDED` means the V1 surface/workflow exists in authoritative
scope; it does not approve every state, field, permission, implementation file, or
screen composition. `DEFERRED` means no V1 surface is authorized. The PRD-021A
status conflict is immaterial to V1 disposition because Master PRD §5.2 / MP-SCOPE-04
explicitly place Community in V2.

| Surface | Authority evidence (not automatic approval) | Status | Required trace / G1 impact |
|---|---|---|---|
| Discover/Search | `MASTER_PRD.md` §8 module 19; frozen Library PRD §14A.3–.4; `14B` §§14B.2–.4; discovery contract `Library_PRD_v1.md` §14A | **RETAINED — SOURCE-BOUNDED** | Public search/location discovery; do not inherit draft-only C2 states or ranking behavior |
| Library Profile | `MASTER_PRD.md` §8 module 19; frozen Library PRD §14A.5 and 14B.7–.10; protected/public field boundary | **RETAINED — SOURCE-BOUNDED** | Only the §14A.5 allow-list and `14B` projection/ownership rules |
| Availability | Frozen `PRD-SEAT-MANAGEMENT.md` `SEAT-FR-076`, `.079`; frozen `14B` `LIB-14B.11`–`.14` | **RETAINED — SOURCE-BOUNDED** | Student private availability may follow PRD-007; public exposure is aggregate/coarse only; live occupancy V2 |
| Shift/Seat selection | Frozen `PRD-SEAT-MANAGEMENT.md` `SEAT-FR-004`, `.076`–`.086`; `MASTER_PRD.md` §8 module 7 | **RETAINED — SOURCE-BOUNDED** | Student self-booking, tenant setting default disabled; no public per-seat state |
| Booking outcome | Frozen `PRD-SEAT-MANAGEMENT.md` §§11–12 (`SEAT-FR-076`–`.086`); frozen Library PRD 14A.3/14B.27 `PO-4` | **RETAINED — SOURCE-BOUNDED** | Outcomes only from the owning BC-04 booking modes/results; no new states from draft C4 |
| Operational Dashboard — Owner | `MASTER_PRD.md` §8 module 10; composition over read models | **RETAINED — COMPOSITION ONLY** | V1 family exists; do not infer per-widget requirements from the family listing |
| Operational Dashboard — Manager | `MASTER_PRD.md` §8 module 11; composition over read models | **RETAINED — COMPOSITION ONLY** | V1 family exists; role permissions remain in authoritative access requirements |
| Operational Dashboard — Reception | `MASTER_PRD.md` §8 module 12; frozen PRD-007 staff operations; PRD-006 attendance; PRD-008 finance requirements (PRD-008 itself remains DRAFT) | **RETAINED — COMPOSITION ONLY** | Composition only; do not imply all finance requirements are frozen or approve a widget set |
| Community | `MASTER_PRD.md` §5.2 `MP-SCOPE-04` and §8 V2 roadmap | **DEFERRED — V2** | PRD-021A status conflict cannot override explicit V2 scope; no V1 community surface |
| `ops_page.dart` | No exact V1 screen/workflow mapping evidenced by named role/module source | **DEFERRED — unsupported screen** | Keep as observed implementation only; no V1 design authorization |
| `reception_desk.dart` | Reception Dashboard V1 composition; frozen PRD-007 `SEAT-FR-055`, `.059`, `.062`; PRD-006 attendance; PRD-008 `FEE-FR-022` (draft requirements not freeze authority) | **RETAINED — SOURCE-BOUNDED** | Map only named Reception workflows; no blanket approval of file contents |
| `money_page.dart` | Master PRD §8 module 9; PRD-008 `FEE-FR-022`, `.053`–`.055` | **RETAINED — SOURCE-BOUNDED / PRD-008 DRAFT** | Finance is in V1; exact behaviors remain governed by PRD-008's actual lifecycle status, not promoted here |
| `overview_page.dart` | No source maps this implementation screen to a named role composition | **DEFERRED — unsupported screen** | V1 dashboard family does not establish this file's role or content |
| `seat_map_page.dart` | Master PRD §8 module 7; frozen PRD-007 `SEAT-FR-004`, `.039`, `.055`–`.079` | **RETAINED — SOURCE-BOUNDED** | Seat operations and visibility only as specified by PRD-007; filename alone is not proof of conformance |
| `students_page.dart` | Master PRD §8 module 4; frozen `Student_Management_PRD_v1.md` `SM-*`; `LMD-*` if member directory composition | **RETAINED — SOURCE-BOUNDED** | Student/member operations only within PRD-004 scope |
| `staff_app_shell.dart` | `MASTER_PRD.md` §5.2 `MP-SCOPE-01` places Staff & Shift in V2 | **DEFERRED — V2 shell** | Does not authorize V1 routes; V1 screens retain separate mappings above |
| `parent_dashboard.dart` | `MASTER_PRD.md` §8 module 5; composition over BC-01, BC-03, BC-05; guarded-student access constrained by frozen PRD-004 / `FEE-FR-055` | **RETAINED — COMPOSITION ONLY** | Only source-backed guardian/student facts; no additional guardian scope inferred |
| `student_dashboard.dart` | `MASTER_PRD.md` §8 module 4; frozen PRD-004; personal Dashboard is protected operation `LIB-14B.27` `PO-6` | **RETAINED — SOURCE-BOUNDED** | Only authenticated student's source-backed Student Management facts/actions |
| `student_app_shell.dart` | No exact shell-specific V1 requirement or destination mapping observed | **DEFERRED — unsupported shell** | Does not promote any route to V1 |
| `student_subject.dart` | No exact V1 requirement/source mapping observed | **DEFERRED — unsupported screen** | No V1 subject surface inferred from file observation |

`DIT-009` remains a separate supplemental membership feature row linked to frozen
`PRD-005` §20 and `DD-0001`. Its listed implementation tasks are blocked by `ADR-0012`
§3.4; the listed membership tests are domain-level, with zero surface tests. It does
not resolve V1 scope for the operational screen inventory.
