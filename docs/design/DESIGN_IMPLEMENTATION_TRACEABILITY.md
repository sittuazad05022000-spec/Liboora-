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

⚠️ **Every row below is `PARTIAL`, and that is the measured truth rather
than an omission.** The repository contains an implemented Flutter
application *and* a design foundation that were produced independently: the
design documents name **7** screen families
([`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) §1) built around library
discovery and booking, while the shipped application implements staff and
student operations. **No design artifact in this repository was written
against the screens that exist**, so no row can honestly claim a complete
design-to-code link yet.

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
| Rows with a PRD requirement link | **0** |
| Rows with any QA evidence | **1** of 8 |

⚠️ **The `0` in "rows with a PRD requirement link" is the most important
number here.** It is not laziness: establishing which frozen requirement
governs an already-built screen is a **product judgement** belonging to the
PRD→Design Traceability Owner, and inventing the mapping would be the
untraceable design claim that [`PRD_DESIGN_TRACEABILITY.md`](PRD_DESIGN_TRACEABILITY.md)
§3 exists to reject.

### 4.2 ⭐ First feature-level design row

| Trace ID | PRD requirement | Design artifact | Surface | Implementation | QA evidence | Status | Owner |
|---|---|---|---|---|---|---|---|
| `DIT-009` | ⭐ **`PRD-005` §20 — 13 UI/UX rows** (`FROZEN` v1.4) | ⭐ [`../35-design/membership/DD-0001-membership-management-surface-design.md`](../35-design/membership/DD-0001-membership-management-surface-design.md) | 13 `BC-02` membership surfaces `S-1`…`S-13`, 6 states each (`DD-0001` **v0.2**) | ⚠️ `IMPL-409`/`432`/`433`/`434`/`436` — **all 5 blocked** by `ADR-0012` §3.4 | 15 membership test files *(domain-level; ⛔ **0** surface tests)* | ⛔ **BLOCKED** | UX Architecture Owner |

⭐⭐ **This is the first row in this register carrying a PRD requirement
link**, which `DIT-OD-001` recorded as measured at **0**. ⛔ It does **not**
discharge `DIT-OD-001`: one of nine rows now carries an upstream link, and
the other eight still do not.

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
| `DIT-OD-001` | **0 of 8** rows carry a PRD requirement link. Which frozen requirements govern the implemented staff/student surfaces? | PRD→Design Traceability Owner | ⛔ OPEN |
| `DIT-OD-002` | The **5** designed screen families in `SCREEN_ARCHITECTURE.md` §1 have no implementation; the **11** implemented screens have no design artifact. Which direction reconciles? | Founder/Product Authority, with UX Architecture Owner | ⛔ OPEN — ⚠️ a **product scope** question, not a documentation one |
| `DIT-OD-003` | `DIT-007`: accessibility is fully specified and **measurably unimplemented** (0 semantics, 0 assertions) | Accessibility Owner | ⛔ OPEN |
| `DIT-OD-004` | QA evidence exists for **1 of 8** rows. What evidence does [`DESIGN_QA.md`](DESIGN_QA.md) §2 require before a row may read `COMPLETE`? | Design QA Owner | ⛔ OPEN |
