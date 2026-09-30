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

⚠️ **Every base-register row below remains partial or otherwise incomplete.**
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
| `DIT-003` | `NONE OBSERVED` | `NONE OBSERVED` | Sign-in surface | `lib/app/shared/login_screen.dart` | `test/widget_test.dart` — *"app renders the login screen on first frame"* | PARTIAL | UX Architecture Owner |
| `DIT-004` | `NONE OBSERVED` | `NONE OBSERVED` | Application chrome and branch switcher | `lib/app/shared/app_chrome.dart`, `lib/app/shared/account_sheet.dart` | `NONE OBSERVED` | PARTIAL | UX Architecture Owner |
| `DIT-005` | `NONE OBSERVED` | `SCREEN_ARCHITECTURE.md` §1 *"Operational dashboard"* — ⚠️ family only, no per-screen spec | Staff operational screens | `lib/app/staff/` — **7** screens (`ops_page`, `reception_desk`, `money_page`, `overview_page`, `seat_map_page`, `students_page`, `staff_app_shell`) | `NONE OBSERVED` | PARTIAL | UX Architecture Owner |
| `DIT-006` | `NONE OBSERVED` | `NONE OBSERVED` | Student and parent surfaces | `lib/app/student/` — **4** files (`student_dashboard`, `parent_dashboard`, `student_app_shell`, `student_subject`) | `NONE OBSERVED` | PARTIAL | UX Architecture Owner |
| `DIT-007` | `NONE OBSERVED` | [`ACCESSIBILITY.md`](ACCESSIBILITY.md) §2 — **9** required checks | All surfaces | `NONE OBSERVED` — measured: **0** occurrences of `Semantics`, `semanticsLabel`, `meetsGuideline` or `textScaleFactor` under `lib/` | `NONE OBSERVED` — **0** accessibility assertions under `test/` | **NOT STARTED** | Accessibility Owner |
| `DIT-008` | `NONE OBSERVED` | [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) §1 — Discover/Search, Library Profile, Availability, Shift/Seat, Booking outcome | **5** designed screen families | `NONE OBSERVED` — no discovery, profile, availability or booking screen exists under `lib/app/` | `NONE OBSERVED` | **NOT STARTED** | UX Architecture Owner |

### 4.1 What the register measures

| Measure | Value |
|---|---|
| Rows | **8** |
| `COMPLETE` | **0** |
| `PARTIAL` | **5** |
| `NOT STARTED` | **2** |
| `CONFLICT` | **1** |
| Base-register rows with a PRD requirement link | **0 of 8** |
| Including supplemental `DIT-009` | **1 of 9** rows have a PRD requirement link (`DIT-009` → `PRD-005` §20) |
| Base-register rows with any QA evidence | **1 of 8** |
| Supplemental `DIT-009` QA | 15 membership test files are listed as domain-level evidence; **0 surface tests** — not counted as surface QA |

⚠️ **The base register's 0/8 remains important.** The supplemental `DIT-009`
feature-level row is separate: its `PRD-005` §20 link is supported by the
frozen PRD and `DD-0001`, but it does not identify requirements for the other
eight base rows or discharge `DIT-OD-001`. Inventing those mappings would be
the untraceable design claim that [`PRD_DESIGN_TRACEABILITY.md`](PRD_DESIGN_TRACEABILITY.md)
§3 exists to reject.

### 4.2 ⭐ First feature-level design row

| Trace ID | PRD requirement | Design artifact | Surface | Implementation | QA evidence | Status | Owner |
|---|---|---|---|---|---|---|---|
| `DIT-009` | ⭐ **`PRD-005` §20 — 13 UI/UX rows** (`PRD-MEMBERSHIP-MANAGEMENT.md` L1436, FROZEN v1.4; source recorded by `DD-0001` §5) | ⭐ [`../35-design/membership/DD-0001-membership-management-surface-design.md`](../35-design/membership/DD-0001-membership-management-surface-design.md) | 13 `BC-02` membership surfaces `S-1`…`S-13`, 6 states each (`DD-0001` **v0.2**) | ⚠️ `IMPL-409`/`432`/`433`/`434`/`436` — **all 5 blocked** by `ADR-0012` §3.4 | 15 membership test files *(domain-level; ⛔ **0** surface tests)* | ⛔ **BLOCKED** | UX Architecture Owner |

⭐⭐ **This is the first supplemental row in this register carrying a PRD
requirement link.** The eight-row base register remains **0/8** linked; including
this supplemental row, the combined count is **1/9**. ⛔ It does **not**
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
| `DIT-OD-001` | **Evidence inventory complete; authority mapping gap remains.** The base register has **0/8** PRD-linked rows; supplemental `DIT-009` makes **1/9**, without mapping the other base surfaces. The frozen requirement for each retained base surface must be identified by the PRD→Design Traceability Owner; do not infer mappings from filenames or implementation. | PRD→Design Traceability Owner | ⛔ OPEN — mappings not evidenced |
| `DIT-OD-002` | **Per-surface evidence register recorded in §8.1.** It inventories five proposed discovery/booking families, the inherited Operational Dashboard composition, Community, and 11 observed implementation screens. Exact authoritative V1 mapping is still absent for the UNRESOLVED rows; Community is DEFERRED to V2 per `MASTER_PRD.md` §32; the PRD-021A/021C source-status conflicts `C-001`/`C-002` are now RESOLVED by source precedence (`Accepted` ADR-0087 / ADR-0098), leaving only the per-surface V1 requirement mapping and traceability. | UX Architecture Owner with PRD→Design Traceability Owner; escalate source conflict to Founder/Product Authority | ⛔ OPEN — evidence inventory exists, per-surface scope/trace decisions remain incomplete |
| `DIT-OD-003` | **Accessibility evidence gap:** `DIT-007` records 0 occurrences of `Semantics`, `semanticsLabel`, `meetsGuideline`, or `textScaleFactor` under `lib/`, and 0 accessibility assertions under `test/`. Record implementation/QA evidence when supplied; do not infer compliance from the requirements document. | Accessibility Owner | ⛔ OPEN — evidence absent |
| `DIT-OD-004` | **Surface QA evidence gap:** the base register has evidence for **1/8** rows only; supplemental `DIT-009` lists 15 domain-level membership test files but **0 surface tests**. Apply [`DESIGN_QA.md`](DESIGN_QA.md) §2 criteria and attach surface-specific evidence before any row is marked `COMPLETE`. | Design QA Owner | ⛔ OPEN — evidence absent for remaining rows |

## 8. DBT-006 scope boundary and reconciliation requirement

**Founder/Product Authority decision — OPTION C (2026-09-30):** Neither the proposed
screen families nor the currently implemented staff/student screens is independently
authoritative for V1. Reconciliation must use approved/frozen V1 PRDs and the established
product role structure.

The implementation register must not infer authority from filenames or existing code.
For every retained surface, the PRD→Design and Design→Implementation rows must identify
an applicable V1 PRD, approved requirement, or established role/workflow. This includes
Student/Parent discovery-to-booking journeys and Reception, Manager, and Owner
operational workflows. Surfaces without that authority remain unresolved or deferred,
or are removed from V1 design scope.

This is a product-scope boundary, not implementation approval. Existing `DIT-005`,
`DIT-006`, and `DIT-008` observations remain evidence of the current divergence until
the UX Architecture Owner completes the reconciliation. `DIT-OD-002` therefore remains
OPEN (per-surface V1 requirement mapping not yet evidenced), and no G1 pass is implied.
The source-status resolutions `C-001` (ADR-0087) and `C-002` (ADR-0098) affect the
upstream requirement source only; they do not supply the per-surface mapping evidence
that `DIT-OD-001` / `DIT-OD-002` require, and they do not pass `G1` or close `DBT-008`.

### 8.1 Per-surface evidence status

The Option C boundary sets the reconciliation rule, but does not itself make any
surface approved. Statuses below remain `UNRESOLVED` where exact requirement mapping is
not recorded. Community is `DEFERRED` for V1 per `MASTER_PRD.md` §32 (Community is V2),
with the PRD-021A source-status conflict `C-001` now **RESOLVED by source
precedence** (`Accepted` ADR-0087, Rank 3, Stage 7 closed; see
`PRD_DESIGN_TRACEABILITY.md` §4). No implemented screen is promoted to V1 scope
by observation alone, and this resolution does **not** close `DIT-OD-001` /
`DIT-OD-002` or pass `G1` — the per-surface V1 requirement mapping remains open.

| Surface | Authority evidence (not automatic approval) | Status | Required trace / G1 impact |
|---|---|---|---|
| Discover/Search | Master PRD lists Search as a V1 essential; C-002 source-status resolved by `Accepted` ADR-0098 (Rank 3, Stage 7 `PASS`) | **UNRESOLVED** | Source-status resolved; exact per-surface requirement mapping still required (`DIT-OD-002`); G1 blocker |
| Library Profile | PRD-021C C3 is inside the `FROZEN` / `BASELINED` Rank 3 C0–C8 package (`Accepted` ADR-0098); C-002 source-status resolved | **UNRESOLVED** | Map permitted profile fields to the authoritative requirement (`DIT-OD-002`); G1 blocker |
| Availability | PRD-007 freeze records and BC-04 remain the higher-order seat authority; C4 sits inside the `FROZEN` / `BASELINED` Rank 3 C0–C8 package (`Accepted` ADR-0098); C-002 source-status resolved | **UNRESOLVED** | Map each claim/state to the exact seat requirement (`DIT-OD-002`); G1 blocker |
| Shift/Seat selection | PRD-007 is cited as authority; implementation filename is not proof of designed equivalence | **UNRESOLVED** | Link states to exact requirement; G1 blocker |
| Booking outcome | Existing booking authority is referenced in `USER_FLOWS.md`; exact state-to-requirement mapping absent | **UNRESOLVED** | Identify authoritative requirement for each outcome state; G1 blocker |
| Operational Dashboard | Master PRD lists Owner, Manager, Reception dashboards as V1 compositions; SCREEN_ARCHITECTURE calls the family inherited | **UNRESOLVED per role/screen** | Map each retained role surface to exact V1 requirement; G1 blocker |
| Community | Master PRD §32 places Community in V2; C-001 source-status resolved by `Accepted` ADR-0087 (Rank 3, Stage 7 closed); deferral now rests on V2 scope, not source-status | **DEFERRED from V1** | No V1 public/community behavior or permission inferred; per-surface mapping open (`DIT-OD-001`/`DIT-OD-002`) |
| `ops_page.dart` | Master PRD role/module descriptions are candidate context only | **UNRESOLVED** | Map actual workflow to exact V1 requirement or defer/remove; G1 blocker |
| `reception_desk.dart` | Master PRD describes Reception responsibilities but does not establish this file's requirements | **UNRESOLVED** | Map actual workflows to exact V1 requirement; G1 blocker |
| `money_page.dart` | Revenue & Finance V1 / PRD-008 are candidate sources | **UNRESOLVED** | Map actual behaviors to exact PRD-008 requirements; G1 blocker |
| `overview_page.dart` | V1 dashboards exist as compositions in Master PRD; this screen's role is not established | **UNRESOLVED** | Establish role/content source; G1 blocker |
| `seat_map_page.dart` | Seat Management V1 / PRD-007 are candidate sources | **UNRESOLVED** | Do not infer equivalence; map exact behavior; G1 blocker |
| `students_page.dart` | Student Management V1 / PRD-004 are candidate sources | **UNRESOLVED** | Map operations to exact frozen requirement; G1 blocker |
| `staff_app_shell.dart` | Master PRD lists Staff & Shift as V2; shell may host V1 routes, not verified | **UNRESOLVED** | Map each route separately; do not infer scope from shell; G1 blocker |
| `parent_dashboard.dart` | Master PRD lists Parent Portal as V1 composition | **UNRESOLVED** | Map displayed facts/actions to exact requirement and guardian scope; G1 blocker |
| `student_dashboard.dart` | Student Management is V1; this alone does not authorize all dashboard content | **UNRESOLVED** | Map each displayed fact/action to exact requirement; G1 blocker |
| `student_app_shell.dart` | No shell-specific V1 requirement mapped in register | **UNRESOLVED** | Map each route to a V1 source or defer/remove; G1 blocker |
| `student_subject.dart` | No exact authoritative screen mapping recorded | **UNRESOLVED** | Identify applicable requirement or leave deferred/unresolved; G1 blocker |

`DIT-009` remains a separate supplemental membership feature row linked to frozen
`PRD-005` §20 and `DD-0001`. Its listed implementation tasks are blocked by `ADR-0012`
§3.4; the listed membership tests are domain-level, with zero surface tests. It does
not resolve V1 scope for the operational screen inventory.
