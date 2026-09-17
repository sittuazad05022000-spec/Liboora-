<!-- LIBOORA Design Doc | DD-0004 | BC-04 Seat Management -->

> This document is design documentation. It does not amend product requirements,
> architecture decisions, bounded-context ownership, permissions, or backend
> contracts.
# `DD-0004` — Seat Management surface design

| Field | Value |
|---|---|
| **Design Doc** | `DD-0004` |
| **Version** | **v0.1** |
| **Status** | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** ⛔ This document does **not** claim its own status |
| **Rank** | ⛔⛔ **UNRANKED.** Where this disagrees with any ranked document, **the ranked document wins and this Design Doc is the defect** |
| **Bounded context** | **`BC-04` Seating** — `[CORE]`, Library Management domain, tenant-scoped |
| **Subject PRD** | `PRD-007` Seat Management — **`FROZEN` v1.1**, Rank 3, admitted by `ADR-0020` under `BASELINE-2026-08-04-E` |
| **Preceded by** | ⭐ The **BC-04 Seat Management Design Readiness Audit**, verdict **REQUIRED**, accepted by the Product Owner |
| **Owner** | UX Architecture Owner *(role, never a personal name)* |
| **External method** | UI/UX Pro Max skill — `nextlevelbuilder/ui-ux-pro-max-skill` @ **`15de38f`**, MIT. ⚠️ **Reference only, subordinate to every Liboora source** |
| **Purpose** | Specify the `BC-04` surfaces precisely enough that a Figma prototype can be built **without inventing UX** |
| **Verdict** | ⭐ **READY WITH EXPLICIT DESIGN GAPS** — §28 |

---

## 1. Document Control

### 1.1 What this document does

It specifies the **presentation and interaction behaviour** of the surfaces
`PRD-007` requires, at the fidelity a Figma author or a Flutter implementer
needs in order to build without guessing.

### 1.2 ⭐⭐ Why `BC-04` needs a Design Doc — and why an earlier instrument said it did not

⛔ `docs/35-design/README.md` recorded `seat-management/` as ⚪ **NOT REQUIRED**,
reasoning: *"All **8** UI occurrences in its PRD are **prohibitions**; a
prohibition fixes no surface to design."*

⭐⭐ **The accepted audit falsified that conclusion.** Re-measured:

| Prior claim | Measured | Verdict |
|---|---|---|
| "8 UI occurrences" | The literal word `UI` appears **1** time (`PRD-007` L832). The 8 came from `UI\|screen\|widget` matching 8 **lines** | ⚠️ **Mis-stated instrument** |
| "every one a prohibition" | ⭐ **True.** All 8 are genuine prohibitions | ✅ **Accurate** |
| ⛔ Therefore NOT REQUIRED | ⛔⛔ **Does not follow** — the instrument never examined the surfaces the PRD *mandates* | ⛔ **FALSIFIED** |

⭐⭐ **What the naive instrument missed — whole sections, by their own titles:**

| `PRD-007` §  | Title | Mandated surface content |
|---|---|---|
| ⭐⭐ **§13** | **"The seat card"** | `SEAT-FR-103` — a **14-field** card, 4 colour-named presence states |
| ⭐⭐ **§5.3** | **"The layout editor"** | `SEAT-FR-029` drag-and-drop · `SEAT-FR-031` walls/doors/tables/pillars · `SEAT-FR-035` **2D mandatory** |
| ⭐ §26.2 | "Smart filters" | **12** named presets, each an exact predicate |
| ⭐ §23.4 | "The seat timeline" | Staff **and** student-facing views |
| ⭐ §22.4 | "Work queues" | **5** named staff queues |

⭐ And `SEAT-NFR-005` states it outright: *"the seat map is **the module's primary
surface**."*

⭐⭐ **This is the third PRD for which the naive `UI`/`UX` grep was wrong**, after
`PRD-004` and `PRD-006`. ⚠️ The same stale claim also sits in `DD-0001` §1.1's
comparison table. ⛔ **This document does not edit `DD-0001`** — §22 records it.

### 1.3 What this document does NOT do

| ⛔ Not in scope | Owner |
|---|---|
| ⛔ Amending any `SEAT-*` requirement | `PRD-007` owner |
| ⛔ Resolving `SEAT-CONFLICT-001` *(the `E-27` transport)* | Architecture Owner |
| ⛔ Editing `DD-0001`, `DD-0002` or `DD-0003` | Design Owner |
| ⛔ Fixing `AIV-S01`…`AIV-S11` implementation deviations | Architecture + Domain Owner |
| ⛔ Creating a Figma file | Design Owner — §26 judges the gate **NOT OPEN** |
| ⛔ Ratifying an accessibility standard | Accessibility Owner |
| ⛔ Database schema, API shape, widget code | Specification / Implementation stages |

### 1.4 ⭐ Skill disposition — where UI/UX Pro Max was used, filtered, or refused

⛔⛔ **UI/UX Pro Max is unranked. It informs *how*; it never decides *what*.**

| # | Pro Max input | Disposition | Reason |
|---|---|---|---|
| 1 | Priority 1 **Accessibility CRITICAL** — contrast 4.5:1, aria-labels | ⭐ **USED as methodology** | ⛔ Cited as methodology, **not** as a Liboora requirement — `PRD-007` ratifies none (§16) |
| 2 | Priority 2 **Touch ≥44×44pt / 48dp Android** | ⭐ **USED, marked UNRATIFIED** | ⛔ No Liboora source fixes a touch-target value → §16.4 `DD4-TBD-004` |
| 3 | ⛔ *"Color is not the only indicator"* | ⭐⭐ **USED — and it converges with Liboora** | ⭐ `docs/design/ACCESSIBILITY.md` §2 states the same rule independently |
| 4 | Priority 9 *"Bottom nav ≤ 5"* | ⭐ **USED** | ⭐ Consistent with the measured 4-tab staff shell |
| 5 | Priority 10 ⛔ *"Relying on color alone"* anti-pattern | ⭐⭐ **USED** | ⭐ Directly engages `SEAT-FR-103`'s 🟢🔵🟠⚪ |
| 6 | `pro-rules.md` — safe areas, 4/8dp rhythm, no layout-shifting press states | ⭐ **USED** | ⭐ `LiblSpace` is already a 4/8 rhythm (4·8·12·16·24·32) |
| 7 | `pro-rules.md` — *"Tested on 375px and in landscape"* | ⚠️ **FILTERED** | ⭐ Liboora is **portrait-first Android**; landscape is not a Liboora requirement. ⛔ Recorded, not imported |
| 8 | `pro-rules.md` — dark-mode contrast parity *(5 checklist rows)* | ⚠️ **FILTERED — NOT APPLICABLE** | ⛔ Measured: `theme.dart` defines **one** light theme. ⛔ No dark mode exists → out of scope, not a defect |
| 9 | `flutter.csv` **52 rows** — const widgets, `RepaintBoundary`, dispose, `LayoutBuilder` | ⚠️ **USED WITH A VERSION CAVEAT** | ⛔⛔ Its `Applies To` column reads **`flutter 3.44.x`**; ⭐ Liboora is pinned at **3.35.4 / Dart 3.9.2**. Every code-shaped row is **version-checked, never copied** — §19.4 |
| 10 | `flutter.csv` #44 — `MediaQuery.textScalerOf` | ⚠️ **DEFERRED** | ⚠️ API availability at 3.35.4 **not verified by this document**; ⛔ no code claim made |
| 11 | `flutter.csv` #7/#8 — *"Prefer Riverpod"* | ⛔⛔ **REFUSED** | ⛔ Liboora uses **Provider** (`pubspec.yaml`, `provider: 6.1.5+1`). ⭐ A methodology reference **may not** re-architect state management |
| 12 | `ux-guidelines.csv` **119 rows** — `Platform` column, rows 1–2 = `Web` | ⚠️ **FILTERED to mobile** | ⭐ `pro-rules.md` itself warns its tables *"don't apply 1:1 to desktop web"*; the inverse also holds |
| 13 | Pro Max gamification / engagement patterns | ⛔⛔ **REFUSED** | ⛔ `SEAT-XC-018` bans rankings and trends; the brief bans gamification. ⭐ Two independent grounds |
| 14 | Pro Max *"scarcity / urgency"* conversion patterns | ⛔⛔ **REFUSED** | ⛔ `SEAT-FR-094`: expiry *"**MUST NOT** penalise the student beyond the no-show counter"* |

### 1.5 ⭐ Authority order applied in this document

```
Rank 1  MASTER_PRD
Rank 2  Accepted ADRs                 ADR-0020 · ADR-0032 · ADR-0033
Rank 3  Frozen PRDs                   PRD-007 v1.1 · PRD-006 v1.9 · PRD-001 v2.0
Rank 4  BC Map · Dependency Matrix · TRACEABILITY_MATRIX
Rank 5  ARCHITECTURE_RULINGS
Rank 6  Enterprise Architecture (descriptive)
──────  docs/design/*  design governance — RECOMMENDED, not ranked
──────  Design Docs  DD-0001 · DD-0002 · DD-0003 · THIS  — UNRANKED
──────  lib/ test/    EVIDENCE ONLY, never authority
──────  UI/UX Pro Max UNRANKED METHODOLOGY, overrides nothing
```

---

## 2. Executive Summary

⭐ `BC-04` answers one question: **who holds the right to which seat, and when.**

| Measure | Value | Source |
|---|---|---|
| Subject PRD | `PRD-007` **`FROZEN` v1.1**, **2891 lines** | `ADR-0020`, `ADR-0032` |
| Identifiers | ⭐ **683** across 10 registers | §0.3 |
| Surfaces specified here | ⭐⭐ **29** | §10 |
| Designable now | ⭐ **28 fully · 1 partial** *(`L2`, 3 of 4 presence states)* | §11 |
| Flows | ⭐ **14** | §12 |
| State axes | ⭐ **6 axes, 21 states** | §13 |
| Edge cases dispositioned | ⭐ **34 of 34** | §10E |
| Protected operations | ⭐ **24, closed** | `SEAT-FR-272` |
| ⛔⛔ APP 3 surfaces | ⛔⛔ **ZERO** | §5.6 |
| Blocking gaps | ⛔ **1** — `SEAT-BLOCK-001` | §23 |
| Open conflicts | ⛔ **3 preserved unresolved** | §22 |
| Implementation deviations | ⚠️ **11** — `AIV-S01`…`AIV-S11`, ⛔ none fixed | §21 |
| ⛔⛔ Tasks proven by test | ⛔⛔ **0 of 100** | `PRD-007` §37 |
| ⛔⛔ AC proven by test | ⛔⛔ **0 of 226** | `PRD-007` §37 |
| Figma gate | ⛔⛔ **NOT OPEN** | §26 |

⭐⭐ **The single most important design consequence of `PRD-007`** is
`SEAT-BR-043`: ⛔ **no rule may take a seated student's seat automatically**
except enrollment suspension and archival. ⭐ Every other adverse change
**retains and flags**. `SEAT-BR-042`: *"**Retain-and-flag is never
retain-and-forget.**"* ⭐ That is simultaneously the strongest anti-anxiety
guarantee in the repository **and** the reason five work queues exist.

---

## 3. Goals / Non-Goals

### 3.1 Goals — traced, not invented

⭐ `SEAT-FR-003` fixes ten objectives. Design goals derive from them:

| # | `PRD-007` objective | Design goal | Class |
|---|---|---|---|
| 1 | Complete digitisation | Every seat fact reachable from one surface (`L1`) | ⭐ **REQUIREMENT** |
| 3 | ⭐ Duplicate assignment **impossible, not unlikely** | Conflict is a *first-class* rejection state, never a silent overwrite | ⭐ **REQUIREMENT** |
| 4 | Real-time seat information | Convergence without manual refresh (`SEAT-NFR-006`) | ⭐ **REQUIREMENT** |
| 6 | ⭐ **Simple** student booking | ≤3 taps to a booking decision | ⚠️ **DESIGN DECISION** |
| 7 | Efficient staff assignment | Counter operations reachable in 1 tap from `L1` | ⚠️ **DESIGN DECISION** |
| 9 | Complete, retained history | Timeline is derived, never a write target | ⭐ **REQUIREMENT** |

### 3.2 ⛔ Non-goals — each with the authority that excludes it

| ⛔ Excluded | Authority |
|---|---|
| ⛔ Public live occupancy *(per-seat or busy/moderate/quiet)* | `SEAT-XC-020` — **V2** *"pending a privacy review"*, and *"must not be invented"* |
| ⛔ Occupancy trends, peak-hour, popularity ranking, dashboards, scheduled reports | `SEAT-XC-018` — owned by `BC-26` |
| ⛔⛔ **Any monetary value on any seat surface** | `SEAT-FR-279` — no fee, price, plan amount, due, discount or balance |
| ⛔⛔ *"Renew membership"* / *"Collect payment"* on a seat screen | `SEAT-XC-011` *(a deep link is permitted — §34.5 row 7)* |
| ⛔ Full-text / fuzzy / phonetic search, relevance ranking | `SEAT-XC-021` — owned by `BC-23` |
| ⛔ SMS, push, email, in-app inbox, templates, quiet hours | `SEAT-XC-016` — owned by `BC-22` |
| ⛔ Delivery state *("reminder sent", "SMS delivered")* on card/timeline/report | `SEAT-XC-017` |
| ⛔ Waiting list / queue / auto-promotion | `SEAT-XC-005` — **V2** |
| ⛔ Unattended scheduled auto-allocation | `SEAT-FR-185` — **V2** |
| ⛔ Seat-level pricing or premium surcharge | `SEAT-FR-144` — plan concern, `BC-02` |
| ⛔ Arbitrary boolean filter expressions | `SEAT-FR-260` — V1 is **AND-only** |
| ⛔ Per-seat / per-student / per-role config overrides | `SEAT-XC-022` — **V3** |
| ⛔ A module-owned audit store | `SEAT-FR-232` — `BC-24` owns it |
| ⛔⛔ RFID · Face Recognition · AI seat decisions | ⛔ **0 occurrences** in `PRD-007`. ⛔ Not invented here |
| ⛔⛔ Gamification · streaks · artificial scarcity | ⛔ Brief prohibition **and** `SEAT-XC-018` |

---

## 4. Authority & Source Hierarchy

### 4.1 Sources actually read for this document

| Rank | Document | Measured state |
|---|---|---|
| 2 | `ADR-0020` | ⭐ **Accepted** — confers `PRD-007`'s Rank 3 |
| 2 | `ADR-0032` | ⭐ **Accepted**, option `O-5` — widened `SEAT-FR-103` to 4 presence states |
| ⛔⛔ 2 | **`ADR-0033`** | ⭐ **Accepted**, option `O-C` — ⛔⛔ **WITHDREW edge `E-27`** |
| 3 | `PRD-007` | ⭐ **`FROZEN` v1.1**, 2891 lines, 683 identifiers |
| 3 | `PRD-006` | `FROZEN` v1.9 — the Attendance ↔ Seat contract |
| 3 | `PRD-001` Authentication v2.0 | `TR-1`…`TR-5` · `PR-1`/`PR-2` closed · `AUTH-2.5` |
| 4 | `LIBOORA_BOUNDED_CONTEXT_MAP.md` **v1.18** | ⭐ **26 edge rows measured**, `E-01`…`E-26` |
| 4 | `TRACEABILITY_MATRIX.md` §2E | ⚠️ **L309 stale** — says `PRD-007` is `DRAFT` v1.0 |
| — | `docs/design/ACCESSIBILITY.md` | ⚠️ **`RECOMMENDED`**, Target **TO BE DECIDED** |
| — | `DD-0001` / `DD-0002` / `DD-0003` | `PROPOSED`, unranked |
| 7 | `seating.dart` · `seat_allocation.dart` · `seat_map_page.dart` · `identity.dart` · `theme.dart` · `common.dart` | ⭐ Evidence only |
| ⛔ 8 | UI/UX Pro Max @ `15de38f` | ⛔ Unranked, MIT |

### 4.2 ⛔ Technical Specifications

⛔⛔ **No `TS-*` covers `BC-04`.** Measured: `TRACEABILITY_MATRIX.md` §2V
registers `TS-001` *(social graph)* and `TS-002` *(marketplace)* only.
⛔ **No `TS-004` is created, implied, authorised, allocated or reserved by this
document.**

---

## 5. App + Role Boundary

⭐⭐ **Designed against the FINAL three-app architecture from the beginning.**
⛔ This is not one mixed-role application awaiting a split.

### 5.1 Declaration 1 — Target App

| App | Seat surfaces | Roles |
|---|---|---|
| ⭐ **APP 1 — Student App** | **5** | `TR-4` Student · `TR-5` Parent |
| ⭐ **APP 2 — Library App** | **24** | `TR-1` Owner · `TR-2` Manager · `TR-3` Reception |
| ⛔⛔ **APP 3 — Platform Admin** | ⛔⛔ **0** | `PR-1` · `PR-2` |

### 5.2 Declaration 2 — Target Roles, by identifier

⭐ `SEAT-FR-268` consumes the platform model; ⛔ it invents no role:

> *"roles are `owner`, `manager`, `reception`, `student`, `parent`, plus
> Platform Support and Platform Administrator"*

| Role | `PRD-001` §2.4 | Code `AccessRole` |
|---|---|---|
| Owner | `TR-1` | `owner` |
| Manager | `TR-2` | `manager` |
| Reception | `TR-3` | `reception` |
| Student | `TR-4` | `student` |
| Parent | `TR-5` | `parent` |
| Platform Administrator | `PR-1` | ⛔ **absent from code** — §21 `AIV-S06` context |
| Platform Support | `PR-2` | ⛔ **absent from code** |

### 5.3 Declaration 3 — Permission scope source

⭐⭐ **`PRD-007` §28.2 — a closed 24-row Role × Action matrix.**
`SEAT-FR-272`: *"An operation not in this list **does not exist** in V1."*
⛔ **No permission in this document is inferred from UI convenience.**

### 5.4 Declaration 4 — Tenant / Library / Platform scope

⭐ `SEAT-FR-269`: the scope register is **closed** at `self`, `guardianOf`,
`tenantWide`. ⛔ This module **MUST NOT** add a scope. V1 grants are
`tenantWide` for staff, `self` for students.

⭐ Every surface in §11 is **tenant-confined** (§29, `SEAT-INV-009`/`010`,
`SEAT-FR-287`). ⛔ **No platform-level object appears on any seat surface.**

### 5.5 Declaration 5 — Cross-app / cross-feature dependencies

| ID | Dependency | Direction | Authority |
|---|---|---|---|
| ⭐⭐ **X-1** | **Presence composition on `L2`** — `BC-04` composes a `BC-03` presence fact at read time | APP 1 fact → APP 2 surface *(cross-**feature**, `BC-03` → `BC-04`)* | ⭐ `ADR-0032` `O-5`. ⛔⛔ **Transport is an OPEN CONFLICT** — §22.1 |
| **X-2** | Membership validity at gate `G7` | `BC-02` → `BC-04` | `E-02` read projection, `SEAT-FR-154` |
| **X-3** | Enrollment status at gate `G6` | `BC-01` → `BC-04` | `E-01` family, `SEAT-BR-013` |
| **X-4** | Occupancy trigger | `BC-03` → `BC-04` | ⭐ **`E-08`** — *"Seating is the occupancy owner, Attendance is the trigger"* |
| **X-5** | Seat rules, floors/zones, shifts | `BC-06` → `BC-04` | `E-05`, `SEAT-FR-266` |
| **X-6** | Student name for display | `BC-01` → `BC-04` | ⭐ `SEAT-FR-253` composed at read time, ⛔ never stored |
| **X-7** | `BC-04` contributes a seat column to the Library Member Directory | `BC-04` → `BC-01` read model | `PRD-007` §3.4; ⚠️ `SEAT-GAP-011` open |

### 5.6 ⭐⭐ APP 3 = 0 — proven from five independent sources

⛔ **Not asserted. Measured.**

| # | Source | Statement |
|---|---|---|
| ⭐⭐ 1 | **`SEAT-FR-273`** | *"**Platform Support MUST NOT hold any operation in the list above by default**"*; an unavoidable support action uses Authentication's time-boxed audited mechanism, and ⛔ *"this module **MUST NOT** implement a bypass of its own"* |
| ⭐ 2 | **§28.2 matrix columns** | Owner · Manager · Reception · Student — ⛔⛔ **there is no platform column at all** |
| ⭐ 3 | **`SEAT-FR-259`** | ⛔ Filter presets are tenant-scoped, *"**including presets created by Platform Support**"* |
| ⭐ 4 | **`AUTH-2.5`** | ⛔ *"Platform roles **MUST NOT** grant access to tenant business data"* |
| ⭐ 5 | **§29 Multi-tenancy** | `SEAT-INV-009`/`010`, `SEAT-FR-287` — every operation tenant-confined |

⭐⭐ **`SEAT-FR-273` is a stronger APP-3 exclusion than `PRD-006` supplied for
`DD-0003`** — it names the platform role *explicitly* and forbids the bypass,
where `ATT-FR-003` merely closed the role set at five tenant roles.

⭐ **Library Owner ≠ Platform Owner.** `TR-1` Owner is a **tenant** role holding
`tenantWide` scope inside one library. ⛔ `PR-1`/`PR-2` govern Liboora itself
and reach **no** seat.

### 5.7 ⚠️ `DSN-APP-GAP-001` — measured irrelevant to `BC-04`

⭐ README §2B.2 records that *"Platform Owner"* has **0 occurrences** in
`PRD-001`, `MASTER_PRD.md` or `PRD-012a` Part 2, and ⛔ forbids a Design Doc
from citing it as an authoritative role.

⭐⭐ **For `BC-04` the question never arises**: `SEAT-FR-268` closes the role set
and `SEAT-FR-273` excludes Platform Support from every operation **before** any
platform-vocabulary question is reachable. ⛔ This document cites
*"Platform Owner"* **nowhere** as a role identifier.

### 5.8 ⭐ §2B.4 assignment rules — discharged rule by rule

| Rule | Discharge |
|---|---|
| 1 · Every surface assigned to an app **and** a role | ⭐ **29/29** — §10, §11 |
| 2 · ⛔ MUST NOT mix role experiences for convenience | ⭐ APP 1 and APP 2 specified **separately**; `S1` is a *different surface* from `L1`, not a filtered view |
| 3 · Shared design only when genuinely cross-app | ⭐ **0 shared surfaces.** `P1` mirrors `S4` but is its own row with its own scope |
| 4 · ⛔ Permissions from PRD/ADR/Auth only | ⭐ All from §28.2; **0** widened |
| 5 · ⭐ Parent is a Student-App role | ⭐ `P1` sits in APP 1 — `SEAT-FR-274` |
| 6 · `TR-1`/`TR-2`/`TR-3` differences respected | ⭐⭐ **Not greyed-out afterthoughts** — §14.3 specifies *absent* vs *disabled*, and the **G**-grant case is designed explicitly |
| 7 · ⛔ Platform roles separated | ⭐ `SEAT-FR-273`, `AUTH-2.5` |

---

## 6. Expert Design Review

⛔ **Not decorative personas.** Each row names a decision that **changed**
because of that perspective, and where it changed nothing, says so.

| # | Perspective | Material effect on this design |
|---|---|---|
| 1 | **Senior Product Manager** | ⭐ Ruled that `SEAT-CFG-008` *(self-booking **default disabled**)* makes `S1`/`S2` a **conditional** surface pair, not a primary one. ⛔ Designing the student booking journey as the hero flow would misrepresent the default product |
| 2 | **Senior UX/UI Designer** | ⭐ Chose a **zone-sectioned vertical list of seat grids** over a free-canvas map for `L1` (§27.2) — the existing implementation's shape, and the only one that survives `SEAT-NFR-005`'s 50×100 bound on a phone |
| 3 | **Mobile UX Expert** | ⭐⭐ Separated `L1` *(read + acquire)* from `L3` *(structural edit)* as **different surfaces with different interaction models**. ⛔ A drag-to-move gesture inside a scrolling list would collide — §27.6 |
| 4 | **Flutter Design-System Expert** | ⭐ Mapped all 29 surfaces onto **6 existing components**; ⛔ **refused** to introduce a 3D/WebGL renderer; ⛔⛔ **prohibited `MeterBar`** on its owning PRD's own authority — §17.3 |
| 5 | **Accessibility Expert** | ⭐⭐ Found `SEAT-FR-103`'s four presence states are **colour-primary**, so the **text label is load-bearing** and must not be truncated — §16.5 |
| 6 | **Psychologist / Behavioural Science** | ⭐⭐ Identified that `SEAT-BR-043` already discharges seat-loss anxiety at the *requirement* level, so the design's job is to **make retention visible**, not to add reassurance copy — §7.2 |
| 7 | **Student Behaviour Researcher** | ⭐ Ruled the **no-show counter** (`SEAT-FR-277`) the highest blame-leak risk on any student surface, and constrained its framing — §7.4. ⚠️ **Validation required — no direct user research evidence available** |
| 8 | **Indian Market / Consumer UX** | ⭐ Confirmed `SEAT-CFG-001`'s tenant label *(Zone → "Hall"/"Room"/"Section")* must be honoured **everywhere**, not just on `L1` — §8.3 |
| 9 | **HCI / Cognitive Load** | ⭐⭐ Ruled the **12 filter presets** are the load-reducing mechanism and must be **surfaced, not buried** in an advanced panel — §11.19 |
| 10 | **Privacy & Trust** | ⭐⭐ Produced the §15 visibility matrix; established that `S1` is a **different data shape** from `L1` (`SEAT-FR-275`), not a permission filter over it |
| 11 | **QA / Edge-Case** | ⭐ Dispositioned all **34** cases (§10E); ⭐ flagged case **31** *(wrong-seat check-in)* as needing a surface that does **not** exist in `PRD-007`'s surface set — §23 `DD4-GAP-003` |
| 12 | **Low-End Android / Performance** | ⭐⭐ Ruled `L1` must render **progressively by zone** and ⛔ must not compute presence for off-screen seats — §19.2 |
| 13 | **UI/UX Pro Max Specialist** | ⭐ Applied its priority table; ⚠️ **filtered** landscape + dark-mode rules; ⛔⛔ **refused** its Riverpod guidance against Liboora's measured Provider dependency — §1.4 |

---

## 7. Student Psychology & Behaviour

⛔⛔ **No field research is claimed. None exists.** Every row is classified.

### 7.1 ⭐ The convergence finding

⭐⭐ **Every anti-dark-pattern constraint the brief demands is already
independently mandated or prohibited by frozen `PRD-007`.** Measured:

| Brief prohibition | `PRD-007` already forbids it | Class |
|---|---|---|
| ⛔ Gamification / streaks / rankings | `SEAT-XC-018` — popularity ranking, trends, cohorts all out of scope | ⭐ **REQUIREMENT** |
| ⛔ Guilt / shame | `SEAT-FR-094` — expiry *"**MUST NOT** penalise the student beyond the no-show counter"* | ⭐ **REQUIREMENT** |
| ⛔ Manipulative scarcity | `SEAT-XC-005` — ⭐ no waiting list in V1 **because** fairness rules do not exist yet | ⭐ **REQUIREMENT** |
| ⛔ Artificial urgency | `SEAT-FR-095` — expiry is **derived at read time**, not a countdown a job invents | ⭐ **REQUIREMENT** |
| ⛔ Coercive notifications | `SEAT-XC-016` — this module ⛔ **cannot** dispatch a message at all | ⭐ **REQUIREMENT** |
| ⛔ Addictive mechanics | `SEAT-FR-247` — ⛔ no pre-aggregated counter as a system of record | ⭐ **REQUIREMENT** |

⭐⭐ **Conclusion: the calm, trustworthy seat experience required overriding
nothing.** The same finding was recorded for `BC-03` in `DD-0003` §22.1.

### 7.2 ⭐⭐ Seat-loss anxiety and fear of losing a preferred seat

⭐⭐ **`SEAT-BR-043` is the strongest anti-anxiety rule measured in this
repository:**

> ⛔ *"No rule in this document **MUST** cause a seated student to lose their
> seat automatically except the two cases where a higher authority requires it:
> enrollment suspension and archival. **Every other adverse change MUST retain
> and flag.**"*

| Design consequence | Treatment | Class |
|---|---|---|
| ⭐ Retention must be **visible**, not merely true | `S4` states the allocation window explicitly and ⛔ never shows a bare "at risk" badge | ⚠️ **DESIGN DECISION** |
| ⭐ A flagged allocation is a **staff** work item, ⛔ not a student alarm | Flags render on `L24`; ⛔ **not** mirrored to `S4` as a warning | ⚠️ **DESIGN DECISION** — grounded in `SEAT-FR-217` *"It exists so a human acts"* |
| ⭐ Maintenance on an occupied seat | ⭐ `SEAT-FR-167` forces a **human** to choose Retain/Relocate/Release — *"The system does not choose"* | ⭐ **REQUIREMENT** |
| ⚠️ Preferred seat / zone | ⭐ `SEAT-FR-182` criterion 2 names *"the student's preferred zone, where they have recorded one"* — ⭐ **so preference IS PRD-supported**. ⚠️ But ⛔ **no surface for recording it is specified** → §23 `DD4-GAP-001` | ⭐ **REQUIREMENT** + ⛔ **GAP** |

### 7.3 ⭐ Cognitive load, decision fatigue, choice overload

| Dimension | Finding | Treatment | Class |
|---|---|---|---|
| ⭐⭐ **Choice overload** | `SEAT-NFR-005` bounds inventory at **50 floors × 100 zones**. ⛔ An unfiltered seat map is an unusable choice space | ⭐ `L19`'s **12 presets** are the primary entry to `L1`, not a secondary filter — §11.19 | ⭐ **REQUIREMENT** + ⚠️ **DESIGN DECISION** |
| ⭐ **Decision fatigue** | `SEAT-FR-182`'s 4 ordered criteria let staff **delegate** the choice | `L18` Auto-Assign is offered **beside** manual assign on `L5`, not hidden | ⚠️ **DESIGN DECISION** |
| ⭐ **Cognitive load — the `Occupied` trap** | ⭐⭐ `SEAT-FR-041`: *"`Occupied` means **allocated, not physically present**"* — ⚠️ a known comprehension trap; staff will read it as *"someone is sitting there"* | ⭐⭐ `L1`/`L2` render **allocation** and **presence** as two visually separate rows with distinct labels — §11.2 | ⚠️ **DESIGN DECISION** resolving a ⚠️ **VALIDATION HYPOTHESIS** |
| ⭐ **Locked is not a state** | `SEAT-FR-038`: a locked available seat presents as `Available (locked)` | Lock is a **badge over** a state chip, ⛔ never a fifth chip colour — §13.2 | ⭐ **REQUIREMENT** |

### 7.4 ⭐ Trust, predictability, perceived control, booking confidence

| Dimension | Authority | Treatment | Class |
|---|---|---|---|
| ⭐⭐ **Honesty about staleness** | `SEAT-FR-105` — composed values **labelled with as-of time**, ⛔ never presented as authoritative; `SEAT-FR-106` — unavailable values **marked unavailable**, ⛔ never shown stale-as-current | ⭐ Every composed field on `L2`/`S4` carries an as-of line — §11.2 | ⭐ **REQUIREMENT** |
| ⭐⭐ **Actionable failure** | `SEAT-NFR-010` — ⛔ *"'Assignment failed' **MUST NOT** be the whole of a rejection"*; must name the failing gate, the limit and the current value | ⭐ §12.1 specifies a **per-gate rejection message set** | ⭐ **REQUIREMENT** |
| ⭐ **Predictability of booking** | `SEAT-CFG-010`'s three modes produce **three different outcomes** from one tap | ⭐ `S2` states the outcome **before** submission — §11.26 | ⚠️ **DESIGN DECISION** |
| ⭐ **Perceived control** | `SEAT-FR-073` — a student may cancel their own pending request; `SEAT-FR-122` — and their own reservation | Cancel is a **primary** action on `S4`, ⛔ not buried | ⚠️ **DESIGN DECISION** |
| ⭐⭐ **Fairness perception** | ⭐ `SEAT-FR-096`: *"a no-show student is **never denied a seat at the desk**"* | ⭐ `S4`'s suspension notice **states the desk remains available** — §11.29 | ⭐ **REQUIREMENT** |
| ⚠️ **Blame framing** | ⛔⛔ `PRD-007` has **no** blame prohibition — unlike `PRD-006` §10A.4a/§10A.5, which states one **twice** | ⭐ `S4`'s no-show counter is rendered as a **neutral count with its threshold**, ⛔ never as a penalty or a character claim | ⚠️ **DESIGN DECISION** filling a measured source silence → §23 `DD4-TBD-008` |

### 7.5 ⭐ Error recovery, interruption recovery, notification fatigue

| Dimension | Authority | Treatment | Class |
|---|---|---|---|
| ⭐ **Interruption recovery** | `SEAT-FR-201`/`203` — idempotency key; a retry produces *"exactly one allocation, one history row, one audit event"* | ⭐ Every mutating surface is **safely re-submittable**; §12 specifies interruption recovery per flow | ⭐ **REQUIREMENT** + ⚠️ **DESIGN DECISION** on how it is *communicated* |
| ⭐ **Error recovery** | `SEAT-FR-196` — the losing attempt gets a conflict reason and *"its client **MUST** be able to retry against fresh state"* | ⭐ Conflict surfaces offer **Refresh & retry**, ⛔ never a blind retry | ⭐ **REQUIREMENT** |
| ⭐⭐ **Notification fatigue** | ⭐⭐ Structurally impossible here: `SEAT-XC-016` removes dispatch entirely, and `SEAT-FR-243` states this module ⛔ *"**MUST NOT** carry a per-student 'notify on seat change' preference"* | ⛔ **No notification surface is designed** — §20.3 | ⭐ **REQUIREMENT** |
| ⭐ **Autonomy** | `SEAT-FR-077` — a student books **only for themselves** | ⛔ No "book for a friend" affordance exists | ⭐ **REQUIREMENT** |

### 7.6 ⚠️ Behavioural hypotheses — explicitly NOT requirements

⛔⛔ **None of these is a product requirement. None may be cited as one.**

| ID | Hypothesis | Status |
|---|---|---|
| `DD4-HYP-001` | Students prefer a consistent seat across sessions, so a **changed** seat is more distressing than an **unavailable** one | ⚠️ **VALIDATION REQUIRED — no direct user research evidence available** |
| `DD4-HYP-002` | A zone-sectioned list is easier to scan on a phone than a pan-and-zoom canvas | ⚠️ **VALIDATION REQUIRED** |
| `DD4-HYP-003` | Staff read "Occupied" as physical presence unless the surface separates the two axes | ⚠️ **VALIDATION REQUIRED** |
| `DD4-HYP-004` | The no-show counter is read as a penalty unless its threshold and the desk fallback are shown together | ⚠️ **VALIDATION REQUIRED** |
| `DD4-HYP-005` | Presets are used more than free filtering when both are equally reachable | ⚠️ **VALIDATION REQUIRED** |

---

## 8. Indian Market UX

⛔⛔ **This section describes an operating environment, not a population.**
⛔ No claim is made about Indian students as people.

### 8.1 ⭐ Conditions already answered by `PRD-007`

| # | Condition | Authority | Class |
|---|---|---|---|
| 1 | ⭐⭐ **Many libraries allocate at the desk** | `SEAT-CFG-008` — self-booking **default disabled**; ⭐ *"Many libraries allocate at the desk"*; `LIB-16.2` requires an unconfigured library to be fully operable | ⭐ **REQUIREMENT** |
| 2 | ⭐ **A library that has not thought about settings must not be surprised** | `SEAT-CFG-010` default `ApprovalRequired` — ⭐ *"the only mode that cannot surprise a library that has not thought about the setting"* | ⭐ **REQUIREMENT** |
| 3 | ⭐⭐ **Local vocabulary** — "Hall", "Room", "Section" | `SEAT-CFG-001` + `SEAT-FR-014` — ⭐ presentation only, ⛔ creates no second entity | ⭐ **REQUIREMENT** |
| 4 | ⭐ **Seat numbers are spoken aloud** | `SEAT-FR-026` case-insensitive + whitespace-trimmed; ⭐ `SEAT-FR-255` **natural** ordering so *seat 2 precedes seat 10* | ⭐ **REQUIREMENT** |
| 5 | ⭐ **The desk path always survives** | `SEAT-FR-096` — staff assignment available throughout a self-booking suspension | ⭐ **REQUIREMENT** |
| 6 | ⭐⭐ **No money on a seat surface** | `SEAT-FR-279`, `SEAT-XC-011` | ⭐ **REQUIREMENT** |
| 7 | ⭐ **Same number in different halls is normal** | `SEAT-BR-006` — "A1" on Floor 1 Zone A and Floor 2 Zone B are **distinct**, ⛔ not a conflict | ⭐ **REQUIREMENT** |

### 8.2 ⭐ Conditions the design must answer because the source is silent

| # | Condition | Source state | Treatment | Class |
|---|---|---|---|---|
| 8 | **Budget / low-end Android** | ⭐ `SEAT-NFR-005` bounds inventory and forbids non-linear degradation — ⛔ but names **no device class** | ⭐ §19 — progressive zone render, ⛔ no WebGL, ⛔ no 3D | ⚠️ **DESIGN DECISION** |
| 9 | **Slow / unstable network, mobile-data sensitivity** | ⭐ `SEAT-FR-194` real-time is *"an optimisation, never the source of truth"*; ⛔⛔ **`offline` has 0 occurrences in `PRD-007`**, and `ADR-0114` scopes `BC-30` **to Attendance only** | ⭐ Reads degrade **visibly** (`SEAT-FR-106`); ⛔ **no offline write, no local queue designed** | ⚠️ **DESIGN DECISION** + ⛔ `DD4-TBD-007` |
| 10 | **One-handed use, portrait, small screens** | ⛔ **0 occurrences** | ⭐ Primary actions in the lower two-thirds; ⭐ `L1` scrolls vertically | ⚠️ **DESIGN DECISION** |
| 11 | **Low-light reading halls** | ⛔ 0 occurrences in `PRD-007`. ⭐ But `theme.dart` **already states the intent**: *"Deep indigo — trust, focus, 'study'. Reads well in the low light of a basement reading hall, **which is where this app is actually used**"* | ⭐ Existing `LiblColors.brand` retained; ⛔ no new palette invented | ⭐ **IMPLEMENTATION EVIDENCE** + ⚠️ **DESIGN DECISION** |
| 12 | **Varying digital literacy** | ⛔ 0 occurrences | ⭐ Every state carries a **text label**, ⛔ never colour alone (§16.5); ⭐ actions use verbs, not icons alone | ⚠️ **DESIGN DECISION** |
| 13 | **Quick entry/exit, long sessions** | ⭐ `SEAT-BR-038` gives Reception the counter operations | ⭐ `L5`/`L6`/`L7` reachable in ≤2 taps from `L1` | ⚠️ **DESIGN DECISION** |
| 14 | **English / Hinglish / local-language expansion** | ⭐ `docs/design/ACCESSIBILITY.md` §3: *"Write for translation, dynamic text length… Exact supported languages are **TO BE DECIDED**"* | ⭐ ⛔ No fixed-width label containers; state chips size to content | ⚠️ **DESIGN DECISION**, ⛔ language set **TBD** |

### 8.3 ⭐ The tenant-label rule, applied everywhere

⭐ `SEAT-CFG-001` is not a one-screen setting. ⭐ Every surface in §11 that names
a `Zone` renders **the tenant's configured label**, and `L1`'s section headers,
`L2`'s location line, `L19`'s filters and `L23`'s own config screen all honour
it. ⛔ **"Zone" is never hard-coded in copy.** ⚠️ **DESIGN DECISION** discharging
a ⭐ **REQUIREMENT**.

---

## 9. Information Architecture

### 9.1 ⭐ APP 2 — Library App

⭐ Measured: `staff_app_shell.dart` already carries a **"Seats"** tab pointing at
`SeatMapPage` for **three** roles (L110, L143, L170). ⭐ The IA below preserves
that entry point rather than inventing a new one.

```
APP 2 — LIBRARY APP  (bottom nav, ≤5 tabs — existing shell)
│
└── Seats  ← existing tab, 3 roles
    │
    ├── L1   SEAT MAP  ⭐ primary surface (SEAT-NFR-005)
    │   ├── header: counts + zone count           L1
    │   ├── zone section → seat grid → seat tap  → L2  SEAT CARD
    │   ├── preset bar                           → L19 SEARCH + PRESETS
    │   └── overflow ▾
    │        ├── L18  Auto-assign
    │        ├── L16  Bulk import / export      (TR-1 · TR-2)
    │        ├── L17  Bulk reassign             (TR-1 · TR-2)
    │        └── L3   Layout editor             (TR-1 · TR-2 with G grant)
    │
    ├── L2   SEAT CARD  (bottom sheet from L1)
    │   ├── L5   Assign            L6   Release        L7   Transfer
    │   ├── L12  Lock / unlock     L13  Lock override
    │   ├── L14  Maintenance       L15  Report maintenance
    │   ├── L10  Confirm reservation   L11  Cancel reservation
    │   └── L20  Seat timeline
    │
    ├── L24  WORK QUEUES  (5 queues)
    │   ├── Pending requests   → L8   Decide seat-change
    │   ├── Pending reservations → L9  Approve / reject
    │   ├── Maintenance reports → L14 Start / end
    │   ├── Eligibility review
    │   └── Expiry-flagged
    │
    └── L23  MODULE CONFIGURATION  (TR-1 only)
        ├── 18 SEAT-CFG rows
        ├── L21  Categories
        ├── L22  Category eligibility
        └── L4   Seat create / renumber / deactivate
```

### 9.2 ⭐ APP 1 — Student App

```
APP 1 — STUDENT APP
│
├── TR-4 STUDENT
│   ├── S4  MY SEAT  ⭐ the default seat surface
│   │   ├── current allocation + window
│   │   ├── my reservations            → cancel  (SEAT-FR-122)
│   │   ├── my seat-change requests    → cancel  (SEAT-FR-073)
│   │   ├── my allocation / transfer history     (SEAT-FR-277)
│   │   └── my no-show count                     (SEAT-FR-277)
│   ├── S1  AVAILABILITY   ⚠️ only when SEAT-CFG-008 enabled
│   │   └── → S2  BOOK SEAT
│   └── S3  RAISE SEAT-CHANGE REQUEST
│
└── TR-5 PARENT
    └── P1  SEAT (read-only)  ⭐ mirrors S4's data, ⛔ zero actions
```

### 9.3 ⛔ APP 3 — Platform Admin App

```
APP 3 — PLATFORM ADMIN APP
└── ⛔⛔ (empty — 0 Seat Management surfaces; §5.6)
```

⭐ Consistent with `lib/app/platform_admin/README.md`, which exists to hold that
boundary open *"reserved, deliberately empty."*

### 9.4 ⭐ No-wizard rule

⛔ **No surface in this document is designed as a multi-step wizard**, with two
exceptions that `PRD-007` itself forces:

| Exception | Authority |
|---|---|
| ⭐ `L14` maintenance-on-occupied-seat | `SEAT-FR-167` — the actor **MUST** choose one of exactly three dispositions |
| ⭐ `F3` reassign an occupied seat | `SEAT-BR-016` — **two explicit steps**; ⛔ *"A single-step overwrite **MUST NOT** exist"* |

⭐ In both cases the step count is a **requirement**, not a UX preference.

---

## 10. Surface Inventory

### 10.1 ⭐ The 29 surfaces

⛔ Every row traces to a `SEAT-*` identifier. ⛔ **0 invented, 0 merged, 0 removed.**

#### APP 2 — Library App · counter & map operations (20)

| ID | Surface | App | Roles | Scope | Authority | Status |
|---|---|---|---|---|---|---|
| `L1` | ⭐⭐ **Seat map** | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | `SEAT-PO-024`, `SEAT-NFR-005` | ⭐ **DESIGNABLE** |
| `L2` | ⭐⭐ **Seat card** *(14 fields)* | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | **`SEAT-FR-103`** | ⚠️ **PARTIAL** — 3 of 4 presence states |
| `L3` | ⭐⭐ **Layout editor** | 2 | `TR-1` · `TR-2`**G** | `tenantWide` | `SEAT-FR-028`…`035`, `SEAT-PO-016` | ⭐ **DESIGNABLE** |
| `L4` | Seat create / renumber / deactivate | 2 | `TR-1` · `TR-2`**G** | `tenantWide` | `SEAT-PO-018`, §5.2 | ⭐ **DESIGNABLE** |
| `L5` | Assign seat | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | `SEAT-PO-001`, `SEAT-FR-055`/`056` | ⭐ **DESIGNABLE** |
| `L6` | Release allocation | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | `SEAT-PO-002`, `SEAT-FR-059`…`061` | ⭐ **DESIGNABLE** |
| `L7` | Transfer | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | `SEAT-PO-003`, `SEAT-FR-062`…`067` | ⭐ **DESIGNABLE** |
| `L8` | Seat-change request decision | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | `SEAT-PO-004`, `SEAT-FR-071`/`072` | ⭐ **DESIGNABLE** |
| `L9` | Reservation approve / reject | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | `SEAT-PO-008`, `SEAT-FR-128` | ⭐ **DESIGNABLE** |
| `L10` | Reservation confirm *(trigger T3)* | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | `SEAT-PO-006`, `SEAT-FR-088` | ⭐ **DESIGNABLE** |
| `L11` | Cancel another's reservation | 2 | `TR-1`·`TR-2`·`TR-3`**C** | `tenantWide` | `SEAT-PO-007`, `SEAT-CFG-014` | ⭐ **DESIGNABLE** |
| `L12` | Lock / unlock | 2 | `TR-1`·`TR-2` | `tenantWide` | `SEAT-PO-009`, `SEAT-FR-158`/`159` | ⭐ **DESIGNABLE** |
| `L13` | Lock override | 2 | `TR-1` · `TR-2`**C** | `tenantWide` | `SEAT-PO-010`, `SEAT-FR-162` | ⭐ **DESIGNABLE** |
| `L14` | ⭐ Maintenance + **3-disposition** | 2 | `TR-1`·`TR-2` | `tenantWide` | `SEAT-PO-011`, `SEAT-FR-164`…`168` | ⭐ **DESIGNABLE** |
| `L15` | Report maintenance need | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | `SEAT-PO-012`, `SEAT-FR-166` | ⭐ **DESIGNABLE** |
| `L16` | Bulk import / export | 2 | `TR-1`·`TR-2` | `tenantWide` | `SEAT-PO-013`/`014`, `SEAT-FR-171`…`175` | ⭐ **DESIGNABLE** |
| `L17` | Bulk reassign | 2 | `TR-1`·`TR-2` | `tenantWide` | `SEAT-PO-015`, `SEAT-FR-176`/`177` | ⭐ **DESIGNABLE** |
| `L18` | Auto-assign *(staff-invoked)* | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | `SEAT-PO-017`, `SEAT-FR-180`…`185` | ⭐ **DESIGNABLE** |
| `L19` | ⭐ Search + **12 presets** | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | `SEAT-FR-251`…`262` | ⭐ **DESIGNABLE** |
| `L20` | Seat timeline *(staff)* | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | `SEAT-FR-227`…`231` | ⭐ **DESIGNABLE** |

#### APP 2 — Owner-only structural & configuration (3)

| ID | Surface | App | Roles | Scope | Authority | Status |
|---|---|---|---|---|---|---|
| `L21` | Category management | 2 | ⭐ **`TR-1` only** | `tenantWide` | `SEAT-PO-019`, `SEAT-FR-142`…`146` | ⭐ **DESIGNABLE** |
| `L22` | Category eligibility rule | 2 | ⭐ **`TR-1` only** | `tenantWide` | `SEAT-PO-020`, `SEAT-FR-147`…`150` | ⭐ **DESIGNABLE** |
| `L23` | Module configuration *(18 rows)* | 2 | ⭐ **`TR-1` only** | `tenantWide` | `SEAT-PO-021`, §27.1 | ⭐ **DESIGNABLE** |

#### APP 2 — Work queues (1 surface, 5 queues)

| ID | Surface | App | Roles | Scope | Authority | Status |
|---|---|---|---|---|---|---|
| `L24` | ⭐ Work queues *(5)* | 2 | `TR-1`·`TR-2`·`TR-3` | `tenantWide` | `SEAT-FR-216`/`217` | ⭐ **DESIGNABLE** |

#### APP 1 — Student App (4) and Parent (1)

| ID | Surface | App | Roles | Scope | Authority | Status |
|---|---|---|---|---|---|---|
| `S1` | Availability *(privacy-shaped)* | 1 | `TR-4` | ⭐ `self` | `SEAT-FR-076`/`079`/`275`/`276` | ⭐ **DESIGNABLE** *(conditional on `SEAT-CFG-008`)* |
| `S2` | Book a seat *(3 modes)* | 1 | `TR-4` | ⭐ `self` | `SEAT-PO-005`, `SEAT-CFG-010` | ⭐ **DESIGNABLE** |
| `S3` | Raise seat-change request | 1 | `TR-4` | ⭐ `self` | `SEAT-PO-022`, `SEAT-FR-068`…`075` | ⭐ **DESIGNABLE** |
| `S4` | ⭐ My seat · reservations · history · no-show | 1 | `TR-4` | ⭐ `self` | **`SEAT-FR-277`**, `SEAT-FR-230` | ⭐ **DESIGNABLE** |
| `P1` | ⭐ Parent read-only mirror | 1 | `TR-5` | ⭐ `guardianOf` | `SEAT-FR-274` | ⭐ **DESIGNABLE** |

### 10.2 ⭐ Totals

| Measure | Count |
|---|---|
| Total surfaces | ⭐⭐ **29** |
| APP 1 | **5** *(4 student + 1 parent)* |
| APP 2 | **24** |
| ⛔⛔ APP 3 | ⛔⛔ **0** |
| Fully designable | ⭐ **28** |
| Partially designable | ⚠️ **1** — `L2` |
| ⛔ Blocked entirely | ⭐ **0** |

### 10.3 ⭐ Conditional and grant-gated surfaces

| ID | Condition | Authority | Design consequence |
|---|---|---|---|
| `S1`, `S2` | ⭐ `SEAT-CFG-008` **default disabled** | `SEAT-FR-076` | ⭐ When disabled the surfaces are **ABSENT**, ⛔ not disabled — §14.4 |
| `L3`, `L4` | ⭐ `TR-2` needs an **explicit G grant** *"the role alone does not imply"* | `SEAT-FR-028`, `SEAT-BR-039` | ⭐ Entry point absent for an ungranted Manager — §14.4 |
| `L11` | ⭐ `TR-3` conditional on `SEAT-CFG-014` *(default **not granted**)* | `SEAT-FR-102` | ⭐ Action absent for Reception unless granted |
| `L13` | ⭐ `TR-2` conditional on `SEAT-CFG-005` *(default **Owner only**)* | `SEAT-FR-162` | ⭐ Action absent for an ungranted Manager |

### 10.4 ⭐ 29 surfaces ← 24 protected operations: the mapping is not 1:1, and why

⛔ A reader could reasonably ask why 24 closed operations yield 29 surfaces.
⭐ Measured reconciliation:

| Cause | Detail |
|---|---|
| ⭐ `SEAT-PO-024` is **one** operation covering **four** read surfaces | *"View the seat map, seat card, timeline and operational metrics"* → `L1`, `L2`, `L20`, plus the `S4`/`P1` read scope |
| ⭐ `SEAT-PO-013`/`014` are two operations on **one** surface | `L16` — import and export share a screen |
| ⭐ `SEAT-PO-018` also covers `L4` | Seat create/renumber/deactivate, *"same grant as `SEAT-PO-016`"* |
| ⭐ `L19` and `L24` are **read models**, not protected operations | `SEAT-FR-257`, `SEAT-FR-216` — ⭐ *"a read model over existing state, not a new aggregate"* |
| ⭐ `SEAT-PO-023` covers two cancel paths on **one** surface | `S4` — cancel own request **and** own reservation |

### 10.5 ⭐ Surface-count arithmetic, stated so it is checkable

```
APP 2 counter & map   20   L1 … L20
APP 2 owner-only       3   L21, L22, L23
APP 2 work queues      1   L24
APP 1 student          4   S1, S2, S3, S4
APP 1 parent           1   P1
                      ──
TOTAL                 29
```

### 10E. ⭐⭐ 34 Edge Cases — every one dispositioned

⭐ `PRD-007` §30 already audited all 34 **deterministically**. ⛔ This document
adds no resolution; it assigns a **design disposition** to each.

⭐ Dispositions: **DESIGNED** · **BLOCKED** · **TBD** ·
**EXISTING IMPLEMENTATION DEVIATION** · **NOT APPLICABLE**

| # | Case | Outcome per `PRD-007` | Surface | Flow | Disposition | Design treatment |
|---|---|---|---|---|---|---|
| 1 | Two staff assign the same seat at the same instant | Exactly one succeeds; DB constraint **+ pessimistic lock**, ⛔ never optimistic — `SEAT-INV-001`, `SEAT-FR-197` | `L1`,`L5` | `F1`,`F2` | ⭐ **DESIGNED** | ⭐ Loser gets a **conflict state**, not a generic error; **Refresh & retry** offered (§12.2) |
| 2 | Student books while staff assign the same seat | Identical to case 1 — ⭐ *"there is no privileged path"* — `SEAT-FR-052` | `L1`,`S2` | `F1` | ⭐ **DESIGNED** | ⭐ Same conflict treatment on **both** apps — §12.6 |
| 3 | Membership expires between booking and use | ⛔ Reservation does **not** convert; `G7` re-evaluated **at conversion** — `SEAT-FR-091` | `S4`,`L10` | `F7` | ⭐ **DESIGNED** | ⭐ `S4` shows the reservation with a **non-blaming** membership reason; ⛔ no seat is promised |
| 4 | Membership expires while seated | ⛔ **Not** auto-released; flagged into the expiry queue — `SEAT-FR-155`, `SEAT-GAP-003` | `L24`,`S4` | — | ⭐ **DESIGNED** | ⭐ Appears on `L24` *Expiry-flagged*; ⛔ **no student-facing alarm** (§7.2) |
| 5 | Membership frozen while seated | ⭐ Seat is **held**; new acquisition refused — `SEAT-FR-156` | `L2` | `F1` | ⭐ **DESIGNED** *(inert)* | ⚠️ `SEAT-GAP-004` — the event may never fire in V1; ⛔ **no surface invented** |
| 6 | Student suspended while seated | ⭐ Existing allocation **released** — `SEAT-BR-013` | `L2`,`L20` | — | ⭐ **DESIGNED** | ⭐ Timeline records the cause; ⭐ one of only **two** authorised auto-releases |
| 7 | Status becomes `Inactive` while seated | ⭐ Configurable, default *blocks new, retains existing* — `SEAT-CFG-003` | `L23`,`L2` | `F1` | ⚠️ **TBD** | ⛔ `SEAT-GAP-002` open upstream; ⭐ `L23` exposes the switch, ⛔ the design does not pick |
| 8 | Student archived while seated | ⭐ Allocation released — archival is terminal | `L2`,`L20` | — | ⭐ **DESIGNED** | ⭐ Second authorised auto-release |
| 9 | `E-02` projection stale by seconds | ⭐ Proceeds; **<5 s is an accepted bounded risk** — `SEAT-NFR-002` | `L2` | `F1` | ⭐ **DESIGNED** | ⭐ As-of label on the membership field (`SEAT-FR-105`) |
| 10 | `E-02` projection unavailable | ⭐ Acquisition **fails closed**; reads continue, labelled stale — `SEAT-FR-152`/`153` | `L2`,`L5` | `F1` | ⭐ **DESIGNED** | ⭐ `L2` renders the field ⚪ **unavailable** (`SEAT-FR-106`); ⛔ assign is blocked with the `G7` reason |
| 11 | `seatQuota` 2, third seat requested | ⭐ Rejected, **naming quota and current count** — `SEAT-BR-012` | `L5`,`S2` | `F1` | ⭐ **DESIGNED** | ⭐ Message template in §12.1 `G8` |
| 12 | ⭐ One student, two concurrent requests for two seats | ⭐⭐ **Two locks** — the *student's allocation set*, not only the seat — `SEAT-FR-198` | `S2` | `F6` | ⭐ **DESIGNED** | ⭐ At most `seatQuota` succeed; loser gets the quota reason, ⛔ not a seat conflict |
| 13 | Owner lowers a plan's `seatQuota` below what a seated student holds | ⛔ Nothing released — `MM-FR-025` makes it effective **on renewal** | — | — | ⭐ **NOT APPLICABLE** to any seat surface | ⭐ No seat surface changes; correctly invisible here |
| 14 | Published `seatQuota` drops at renewal below held allocations | ⭐ Excess **flagged for staff decision**, ⛔ never auto-released — `SEAT-FR-300` | `L24` | — | ⭐ **DESIGNED** | ⭐ *Eligibility review* queue; ⛔ **a human chooses which seat is given up** |
| 15 | Seat's category changes under a sitting student | ⭐ Holder **keeps** the seat — `SEAT-FR-146` | `L21`,`L2` | — | ⭐ **DESIGNED** | ⭐ `L21` states this **before** saving — §11.21 |
| 16 | Eligibility rule changes; sitting student no longer qualifies | ⭐ Retained **and flagged** — `SEAT-BR-024` | `L22`,`L24` | — | ⭐ **DESIGNED** | ⭐ `L22` warns of queue volume before saving |
| 17 | Student's shift changes; fixed seat belongs to another shift | ⭐ Retained and flagged; ⛔ *"a shift change **never** auto-releases a seat"* — `SEAT-FR-139` | `L24` | — | ⭐ **DESIGNED** | ⭐ *Shift misalignment* queue |
| 18 | Seat locked while occupied | ⭐ Holder keeps it and may still release/transfer **out** — `SEAT-FR-160`/`161` | `L12`,`L2` | `F11` | ⭐ **DESIGNED** | ⭐⭐ `L2` still offers Release/Transfer — ⛔ *"Locking a seat must never trap a student in it"* |
| 19 | Maintenance started on an occupied seat | ⭐ Staff **MUST** choose Retain / Relocate / Release — *"The system does not choose"* — `SEAT-FR-167` | `L14` | `F10` | ⭐ **DESIGNED** | ⭐ A required 3-option step, ⛔ not a default-and-confirm — §11.14 |
| 20 | Bulk import fails on row 400 of 500 | ⭐ **No** row applied + per-row error report — `SEAT-BR-028` | `L16` | `F12` | ⭐ **DESIGNED** | ⭐ Error report is the **primary** result view — §11.16 |
| 21 | Same import file submitted twice | ⭐ Original result returned; ⛔ no duplicates — `SEAT-FR-173` | `L16` | `F12` | ⭐ **DESIGNED** | ⭐ Surface says *"already applied"*, ⛔ not *"success"* again |
| 22 | Bulk reassign includes one failing student | ⭐ Gate evaluated **per student per destination** — `SEAT-BR-029` | `L17` | — | ⭐ **DESIGNED** | ⭐ Per-row outcome list; ⛔ batch is not authorised as a whole |
| 23 | Network retry delivers one assignment twice | ⭐ Exactly one allocation, history row, audit fact, notification fact — `SEAT-BR-032` | all mutating | all | ⭐ **DESIGNED** | ⭐ Idempotent re-submit; ⛔ **no duplicate confirmation shown** |
| 24 | Duplicate request with **no** idempotency key | ⭐ Rejected by the invariants — `SEAT-FR-204` | all mutating | all | ⭐ **DESIGNED** | ⭐ Presents as a conflict, ⛔ never as a silent success |
| 25 | Seat renumbered after a student sat in it | ⭐ History still reads correctly — internal id never changes — `SEAT-BR-004` | `L4`,`L20` | — | ⭐ **DESIGNED** | ⭐ `L20` shows the number **as it was** at the time |
| 26 | Seat moved to a different position | ⭐ Nothing about identity/allocation/history changes — `SEAT-BR-007` | `L3` | — | ⭐ **DESIGNED** | ⭐ `L3` states *"position only"* |
| 27 | ⭐ Seat dragged into a **different zone** | ⛔⛔ **Refused** while allocated — a *container* change, not repositioning — `SEAT-FR-297` | `L3` | — | ⭐ **DESIGNED** | ⭐⭐ `L3` must make cross-zone drag **structurally impossible**, ⛔ not merely rejected after the gesture — §27.6 |
| 28 | Layout edit would delete a seat holding an allocation | ⛔ Refused — *"layout edits cannot orphan an active allocation"* — `SEAT-INV-006` | `L3` | — | ⭐ **DESIGNED** | ⭐ Rejection **names the blocking allocation** (`SEAT-BR-008`) |
| 29 | Floor/zone deactivated in `BC-06` while seats allocated | ⭐ Seats not deleted; allocations retained and flagged — `SEAT-FR-298` | `L1`,`L24` | — | ⭐ **DESIGNED** | ⭐ Zone section renders **inactive**; existing allocations stay **visible** |
| 30 | ⭐⭐ Student checks in with **no** seat | ⛔⛔ Check-in **never rejected**; recorded as unseated occupancy — `SEAT-FR-112` | `L1` | — | ⭐ **DESIGNED** | ⭐⭐ `L1` header shows *unseated present* as a **separate** count — ⛔ never as a seat |
| 31 | ⭐ Check-in on **someone else's** seat | ⭐ Record occupancy **and** the mismatch; surface to staff; ⛔ never auto-reassign — `SEAT-FR-299` | ⚠️ **none specified** | — | ⚠️ **TBD** | ⛔⛔ `PRD-007` requires *"**MUST** surface it to staff"* but ⭐ §22.4's queue list has **no mismatch queue** → §23 **`DD4-GAP-003`** |
| 32 | `E-08` arrives twice or out of order | ⭐ Idempotent; contradicting older event discarded — `SEAT-FR-113`/`205` | `L2` | — | ⭐ **DESIGNED** | ⭐ No visible flicker; presence composed at read time |
| 33 | Reservation expiry sweeper never ran | ⭐ Seat presents `Available` anyway — **derived at read time** — `SEAT-FR-095` | `L1`,`L2` | `F8` | ⭐ **DESIGNED** | ⛔ **No countdown timer is designed** — §7.1 anti-urgency |
| 34 | Student repeatedly reserves and never turns up | ⭐ After `SEAT-CFG-012` (3), self-booking suspended `SEAT-CFG-013` (7 d); ⭐ **desk remains available** | `S4` | `F8` | ⭐ **DESIGNED** | ⭐⭐ Neutral count + threshold + **desk fallback stated together** — §11.29 |

#### ⭐ Edge-case disposition totals

| Disposition | Count | Cases |
|---|---|---|
| ⭐ **DESIGNED** | **31** | 1–6, 8–12, 14–30, 32–34 |
| ⚠️ **TBD** | **2** | 7 *(`SEAT-GAP-002`)* · 31 *(`DD4-GAP-003`)* |
| ⭐ **NOT APPLICABLE** | **1** | 13 |
| ⛔ **BLOCKED** | **0** | — |
| ⚠️ **EXISTING IMPLEMENTATION DEVIATION** | **0** as a *disposition* | ⚠️ 11 deviations are recorded separately in §21 |
| **TOTAL** | ⭐⭐ **34** | ⭐ all accounted for |

---

## 11. Surface Specifications

⭐⭐ **A surface counts as COVERED only when its actual presentation and
interaction behaviour is specified.** Each of the 29 below carries all 21
required attributes.

⭐ **Shared conventions** applied to every surface, stated once to avoid 29
repetitions:

| Convention | Rule | Authority | Class |
|---|---|---|---|
| ⭐ Tenant confinement | Every read and write is confined to the caller's `tenantId` | `SEAT-FR-287`, §29 | ⭐ **REQUIREMENT** |
| ⭐ Tenant label | `Zone` renders the tenant's configured label everywhere | `SEAT-CFG-001`, `SEAT-FR-014` | ⭐ **REQUIREMENT** |
| ⭐ Natural ordering | Floor → Zone → **natural** seat number *(2 before 10)* | `SEAT-FR-255` | ⭐ **REQUIREMENT** |
| ⭐⭐ No money | ⛔ No fee, price, plan amount, due, discount or balance on **any** surface | `SEAT-FR-279` | ⭐ **REQUIREMENT** |
| ⭐⭐ No payment/renewal affordance | ⛔ No *"renew"* or *"collect"* control on **any** seat screen | `SEAT-XC-011` | ⭐ **REQUIREMENT** |
| ⭐ Actionable rejection | Every failure names the failing gate, the limit and the current value | `SEAT-NFR-010` | ⭐ **REQUIREMENT** |
| ⭐ As-of labelling | Every composed cross-context value carries its projection's as-of time | `SEAT-FR-105`, `SEAT-FR-246` | ⭐ **REQUIREMENT** |
| ⭐ Visible degradation | An unavailable composed value renders **marked unavailable**; ⛔ never stale-as-current, ⛔ never blocking | `SEAT-FR-106` | ⭐ **REQUIREMENT** |
| ⭐ Idempotent re-submit | Every mutating surface is safely re-submittable; ⛔ no duplicate confirmation | `SEAT-FR-201`, `SEAT-BR-032` | ⭐ **REQUIREMENT** |
| ⭐ Authorised actions only | Actions offered are **exactly** those the actor may perform | `SEAT-FR-107` | ⭐ **REQUIREMENT** |
| ⭐⭐ Non-disclosing denial | A `self`/`guardianOf` denial is **indistinguishable from not-found** | `SEAT-FR-281`/`282` | ⭐ **REQUIREMENT** |
| ⭐ Colour never alone | Every state carries a **text label**; colour is secondary | `docs/design/ACCESSIBILITY.md` §2 *(RECOMMENDED)* + Pro Max P10 | ⚠️ **DESIGN DECISION** |
| ⭐ Safe areas | Fixed headers and bottom action bars respect safe areas | Pro Max `pro-rules.md` *(methodology)* | ⚠️ **DESIGN DECISION** |
| ⭐ Spacing rhythm | `LiblSpace` — 4 · 8 · 12 · 16 · 24 · 32 | ⭐ **IMPLEMENTATION EVIDENCE** `theme.dart` | ⚠️ **DESIGN DECISION** |

---

### 11.1 `L1` — Seat Map ⭐⭐ *(the module's primary surface)*

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` Owner · `TR-2` Manager · `TR-3` Reception |
| **Permission** | `SEAT-PO-024` *"View the seat map, seat card, timeline and operational metrics"* |
| **Scope** | `tenantWide` |
| **Purpose** | ⭐ The single authoritative operational view of seating — *"which seat exists, where it is, what state it is in, who holds it"* (`SEAT-FR-001`) |
| **Entry point** | ⭐ Existing **"Seats"** bottom-nav tab — `staff_app_shell.dart` L110/L143/L171 *(3 roles)*. ⛔ No new entry invented |

**Information hierarchy** — 4 tiers, top to bottom:

```
┌─ TIER 1 · OPERATIONAL SUMMARY ──────────────────────┐
│  Allocated 42 of 120            as of 10:04         │ ⭐ SEAT-FR-246
│  Occupied  31 of 120            as of 10:04         │ ⭐⭐ SEAT-FR-245 — TWO
│  ─────────────────────────────────────────────      │    DISTINCT FIGURES
│  Assignable 66 · Reserved 4 · Maintenance 2 ·       │ ⭐ SEAT-FR-244
│  Locked 6 · Unseated present 3                      │ ⭐ SEAT-FR-112 (case 30)
│  Branch name · 5 halls                              │ ⭐ SEAT-CFG-001 label
└─────────────────────────────────────────────────────┘
┌─ TIER 2 · PRESET BAR (horizontally scrollable) ─────┐
│ [Available now] [Allocated but absent] [Expiring…]  │ → L19
└─────────────────────────────────────────────────────┘
┌─ TIER 3 · ZONE SECTIONS (vertical list) ────────────┐
│  ▸ Hall A — Floor 1        18 of 24 allocated       │
│    ┌────┐┌────┐┌────┐┌────┐   seat chips, wrap      │
│    │ A1 ││ A2 ││ A3 ││ A4 │                         │
│    └────┘└────┘└────┘└────┘                         │
│  ▸ Hall B — Floor 1  ⚠ INACTIVE CONTAINER           │ ⭐ SEAT-FR-298 (case 29)
└─────────────────────────────────────────────────────┘
┌─ TIER 4 · LEGEND (state → label → colour) ──────────┐
└─────────────────────────────────────────────────────┘
```

⭐⭐ **Tier 1's two-figure rule is a requirement, not a layout choice.**
`SEAT-FR-245`: *"**Allocation rate and occupancy rate MUST be presented as two
distinct figures and MUST NOT be labelled interchangeably.** A seat allocated to
an absent student is allocated but not occupied."*

**Primary actions** · tap a seat → `L2` *(bottom sheet)* · tap a preset → `L19`
**Secondary actions** · overflow ▾ → `L18` Auto-assign · `L16` · `L17` · `L3` *(grant-gated, §10.3)*

**Components** — ⭐ all existing: `Card` · `SectionHeader` · `Pill` · `EmptyState` · `Wrap` of ⭐ **new** `SeatChip` (§17.4)

**States**

| State | Rendering |
|---|---|
| Loading | ⭐ **Progressive by zone** — Tier 1 skeleton, then each zone as it resolves (§19.2) |
| Empty layout | ⭐ Existing `EmptyState`: *"No seat layout for this hall"* + action → `L3` *(only if authorised)* |
| Error | Tier 1 marked unavailable; ⭐ zone list still renders from last good read (`SEAT-FR-106`) |
| Stale | ⭐ As-of time on Tier 1; ⛔ never hidden |
| Partial | ⭐ A zone that fails to resolve renders as a **named** failed section, ⛔ not omitted |

**Permission-denied behaviour** — ⭐ The tab itself is absent for a role without `SEAT-PO-024`. ⛔ No empty-shell screen.

**Privacy** — ⭐ Holder **name** appears on `L1` only in the chip's accessible name and only for staff. ⛔ No student sees `L1` — `S1` is a **different surface with a different data shape** (`SEAT-FR-275`).

**Accessibility** — ⭐ Every chip carries an accessible name of the form *"Seat A1, Hall A, allocated, locked"*. ⛔ Colour never alone. ⚠️ Chip hit area → `DD4-TBD-004`.

**Psychology** — ⭐⭐ Choice overload is the dominant risk (`SEAT-NFR-005` bounds inventory at 50×100). ⭐ Tier 2 presets are placed **above** the seat grid so the reduced set is reachable before the full set is scanned. ⚠️ **DESIGN DECISION** on ⚠️ `DD4-HYP-005`.

**Indian-market** — ⭐ Tenant label on every section header; ⭐ vertical scroll only *(one-handed)*; ⭐ ⛔ no pan/zoom canvas *(low-end Android, §27.2)*.

**2D / 2.5D / 3D** — ⭐ **2D** list and grid; ⭐ **2.5D** for the Tier 1 card and seat chips *(elevation only)*; ⛔ **no 3D** (§18.3).

**Cross-feature** — ⭐ **X-1** presence *(conflicted transport, §22.1)* · **X-4** `E-08` occupancy · **X-5** floors/zones from `BC-06`.

**Traceability** — `SEAT-PO-024` · `SEAT-FR-001` · `SEAT-FR-039` · `SEAT-FR-244`/`245`/`246` · `SEAT-FR-112` · `SEAT-FR-298` · `SEAT-NFR-005`/`006` · `SEAT-CFG-001`

**GAP / CONFLICT** — ⚠️ `AIV-S01` *(`MeterBar` present in current code — **prohibited**, §17.3)* · ⚠️ `AIV-S03` *(binary `isOccupied`)* · ⚠️ `AIV-S04` *(no lock concept)*

---

### 11.2 `L2` — Seat Card ⭐⭐ *(14 fields — the most contested surface)*

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · `TR-3` |
| **Permission** | `SEAT-PO-024`; actions gated individually by §28.2 |
| **Scope** | `tenantWide` |
| **Purpose** | ⭐ `SEAT-FR-103` — present everything known about one seat, and offer exactly the authorised actions |
| **Entry point** | Tap a seat on `L1`; also from `L19` results and `L24` queue rows |

#### ⭐⭐ The 14 fields — verbatim from `SEAT-FR-103`

> *"Selecting a seat **MUST** present a seat card showing: seat number · zone and
> floor · category · type (`Fixed`/`Flexible`) · derived `SeatState` · lock flag
> when set · maintenance detail when in maintenance · current holder (staff view
> only) · shift · allocation `validFrom`/`validUntil` · membership status and
> expiry · **student presence** · **shift-conformance badge when applicable** ·
> available actions."*

| # | Field | Tier | Source | Notes |
|---|---|---|---|---|
| 1 | Seat number | 1 | `SEAT-FR-024` | ⭐ The identity users speak aloud |
| 2 | Zone and floor | 1 | `SEAT-FR-013` | ⭐ Tenant label (`SEAT-CFG-001`) |
| 3 | Category | 1 | `SEAT-FR-142` | ⛔ **No price** (`SEAT-FR-144`) |
| 4 | Type `Fixed`/`Flexible` | 1 | `SEAT-FR-133` | |
| 5 | ⭐ Derived `SeatState` | 1 | `SEAT-FR-037` | ⭐ 4 values, **derived** |
| 6 | ⭐ Lock flag **when set** | 1 | `SEAT-FR-038`/`039` | ⭐⭐ Badge **over** the state, ⛔ never a 5th state |
| 7 | Maintenance detail when in maintenance | 2 | `SEAT-FR-165` | Reason mandatory |
| 8 | ⭐ Current holder — **staff view only** | 2 | `SEAT-FR-104` | ⭐ Composed at read time, ⛔ never stored |
| 9 | Shift | 2 | `SEAT-FR-137` | Consumed from `BC-06` |
| 10 | Allocation `validFrom`/`validUntil` | 2 | `SEAT-FR-046` | |
| 11 | ⭐ Membership status and expiry | 2 | `SEAT-FR-280` | ⭐⭐ **Exactly** validity state, `validUntil`, `seatQuota` — ⛔ *"Plan name, price, payment history and dues **MUST NOT** be composed"* |
| 12 | ⭐⭐ **Student presence** | 3 | **`SEAT-FR-103` as amended** | ⭐ **4 states** — §13.6 |
| 13 | ⭐⭐ **Shift-conformance badge** | 3 | `SEAT-FR-103` | ⭐⭐ **A SEPARATE FIELD ON A SECOND AXIS** |
| 14 | Available actions | 4 | `SEAT-FR-107` | ⭐ **Exactly** those authorised |

#### ⭐⭐ Information hierarchy — the two-axis rule made visual

```
┌──────────────────────────────────────────────────────────┐
│ TIER 1 · IDENTITY & STATE                                │
│   A-14        Hall A · Floor 1                           │  1,2
│   Premium · Fixed                                        │  3,4
│   🟦 Occupied        🔒 Locked                            │  5,6 ⭐ badge OVER
│                       "Damaged armrest — Owner, 09:12"    │  6 reason
├──────────────────────────────────────────────────────────┤
│ TIER 2 · ALLOCATION (who holds the RIGHT)                │
│   Holder    Priya S.            ⭐ staff view only        │  8
│   Shift     Morning 06:00–10:00                          │  9
│   Window    01 Sep 2026 → 30 Sep 2026                    │  10
│   Membership  Valid · expires 30 Sep      as of 10:04    │  11 ⭐ as-of
├──────────────────────────────────────────────────────────┤
│ TIER 3 · PRESENCE  ⭐⭐ A SEPARATE AXIS — NEVER MERGED     │
│   AXIS 1 — PRESENCE                                      │
│     🟢 Present          since 06:12                       │  12
│   ─────────────────────────────────────────────          │
│   AXIS 2 — SHIFT CONFORMANCE                             │
│     ⚠ Overstay — outside booked window                   │  13
├──────────────────────────────────────────────────────────┤
│ TIER 4 · ACTIONS (exactly those authorised)              │
│   [Release]  [Transfer]  [Lock]  [Maintenance]  [Timeline]│ 14
└──────────────────────────────────────────────────────────┘
```

⭐⭐ **Tier 2 vs Tier 3 separation is a requirement, not a layout preference.**
Three independent sources demand it:

| Source | Statement |
|---|---|
| ⭐⭐ `SEAT-FR-041` | *"**`Occupied` means allocated, not physically present.**"* |
| ⭐⭐ `SEAT-FR-103` as amended | *"allocation and presence **MUST remain two independent axes that are never collapsed into one field**"* |
| ⭐⭐ `SEAT-FR-103` axis 2 | *"The badge **MUST NOT** replace, recolour or suppress the presence indicator, and presence **MUST NOT** be downgraded because of overstay — presence and shift-conformance are two facts, and **one field cannot carry two facts**."* |

#### ⭐ Field 12 — the four presence states

| State | Label | Rendering | Availability |
|---|---|---|---|
| 🟢 | **Present** | + *"since HH:MM"* | ⭐ **DESIGNABLE** |
| 🔵 | **Attended · left** | — | ⛔⛔ **BLOCKED** — §23 `SEAT-BLOCK-001` |
| 🟠 | **Presence unverified** | incl. ⭐ **every** manually recorded attendance | ⭐ **DESIGNABLE** |
| ⚪ | **Not attended** | ⭐⭐ *"a **different fact** from `PRESENCE UNVERIFIED` and **MUST NOT** be merged with it"* | ⭐ **DESIGNABLE** |

⭐ **Treatment of the blocked state** — ⛔ The design does **not** omit it silently and does **not** substitute a computable stand-in. Tier 3 renders:

```
AXIS 1 — PRESENCE
  ⚪ Not attended today
     ⓘ Earlier-today attendance is not available for this seat
```

⭐ Rationale, measured: `DOCUMENTATION_BASELINE.md` **L170** records that
`ADR-0032` **L304** classifies `ATTENDED · LEFT` as **still BLOCKED**, because
`SEAT-BR-036` places period aggregation in `BC-26` and `SEAT-FR-114` **resets
occupancy daily** — so ⛔ `BC-04` cannot answer *"attended earlier today"* after
departure. ⚠️ **DESIGN DECISION** disclosing a ⛔ **BLOCKED** requirement.

**Primary actions** *(each an own surface)* — `L5` · `L6` · `L7` · `L10` · `L11` · `L12` · `L13` · `L14` · `L15` · `L20`

**States**

| State | Rendering |
|---|---|
| Loading | ⭐ Tiers 1–2 from `L1`'s data immediately; Tier 3 presence resolves **after** — ⛔ it must never block the card |
| Empty | ⭐ Not applicable — a card always has a seat. ⭐ An **unallocated** seat shows Tier 2 as *"No current allocation"* |
| Error | ⭐ Per-field: the failing field marked unavailable; ⛔ the card **must not fail** (`SEAT-FR-106`) |
| Stale | ⭐ As-of on fields 11 and 12 |
| Presence unavailable | ⭐ Axis 1 → ⚪ *"Presence unavailable"* with as-of; ⛔ **never inferred from silence** |

**Permission-denied** — ⭐ Field 8 *(holder)* is **absent** for any non-staff reader. ⭐ Unauthorised actions are **absent**, ⛔ not disabled — `SEAT-FR-107`: *"An action the actor cannot perform **MUST NOT** be shown as disabled with an explanatory reason that discloses another student's data."*

**Privacy** — ⭐ Field 11 limited to **validity state, `validUntil`, `seatQuota`** (`SEAT-FR-280`). ⛔ No `PersonId`, photo, contact, DOB or guardian detail (`SEAT-FR-278`). ⛔ No monetary value (`SEAT-FR-279`).

**Accessibility** — ⭐⭐ **The highest-risk surface.** Fields 5, 6, 12 and 13 are all colour-bearing. ⭐ Each carries a text label; ⭐ Axis 1 and Axis 2 are separate labelled groups so a screen reader cannot merge them. ⚠️ Contrast → `DD4-TBD-001`.

**Psychology** — ⭐⭐ Resolves `DD4-HYP-003` *(staff read "Occupied" as presence)* by labelling the tiers **"who holds the right"** vs **"presence"**. ⚠️ **DESIGN DECISION**.

**Indian-market** — ⭐ Bottom-sheet presentation keeps actions in thumb reach; ⭐ labels size to content for translation.

**2D / 2.5D / 3D** — ⭐ **2.5D** *(elevated sheet, `LiblColors.card` on `surface`)*; ⛔ no 3D.

**Cross-feature** — ⭐⭐ **X-1** presence composition — ⛔⛔ **transport is an OPEN CONFLICT (§22.1)** · **X-2** membership · **X-6** name composition.

**Traceability** — **`SEAT-FR-103`** · `SEAT-FR-104`/`105`/`106`/`107` · `SEAT-FR-041` · `SEAT-FR-038`/`039` · `SEAT-FR-278`/`279`/`280` · `ADR-0032` · `SEAT-AC-104`

**GAP / CONFLICT** — ⛔⛔ **`SEAT-CONFLICT-001`** *(§22.1)* · ⛔ `SEAT-BLOCK-001` *(field 12, state 🔵)* · ⚠️ `AIV-S03` · ⚠️ `DD4-TBD-001`

---

### 11.3 `L3` — Layout Editor ⭐⭐

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` Owner · ⭐ `TR-2` Manager **only with an explicit G grant** |
| **Permission** | `SEAT-PO-016` — `SEAT-FR-028`: *"the grant is **not implied** by the Manager role"* |
| **Scope** | `tenantWide` |
| **Purpose** | Edit spatial arrangement — positions and non-seat furniture (`SeatLayout`) |
| **Entry point** | `L1` overflow ▾ → *Edit layout*; ⭐ **absent** for an ungranted Manager and for Reception |

**Information hierarchy** — edit canvas per **zone** *(one `SeatLayout` per zone, `SEAT-FR-020`)*, with a palette and an explicit Save:

```
┌─ Hall A — Floor 1 · layout v4 (active)      [Save] ──┐  ⭐ SEAT-FR-021/022
│  ┌──────────────────────────────────────────────┐    │
│  │  ▨ wall   ▤ table   ⌷ door   ● pillar        │    │  ⭐ SEAT-FR-031
│  │  ┌──┐┌──┐   ▤▤▤▤   ┌──┐                      │    │
│  │  │A1││A2│           │A3│  ← drag to move     │    │  ⭐ SEAT-FR-029
│  │  └──┘└──┘           └──┘                     │    │
│  └──────────────────────────────────────────────┘    │
│  [+ Seat]  [+ Wall] [+ Door] [+ Table] [+ Pillar]    │  ⭐ SEAT-FR-030/031
└──────────────────────────────────────────────────────┘
```

**Primary actions** — drag-reposition *(within the zone only)* · add seat · remove seat · place wall/door/table/pillar · **Save → new version**

**Secondary** — discard · view version history

**Components** — ⭐ **new** `LayoutEditorCanvas` and `LayoutElementToken` (§17.4)

**States**

| State | Rendering |
|---|---|
| Loading | Canvas skeleton per zone |
| Empty | *"No seats in this hall yet"* + `[+ Seat]` |
| Error | ⭐ **Validation is whole-layout**: `SEAT-FR-034` — *"An invalid layout **MUST** be rejected **in whole** with a specific reason and **MUST NOT** be partially saved"* |
| Unsaved | ⭐ Explicit save required (`SEAT-FR-033`); ⛔ **no autosave** — autosave would create versions the operator did not intend |
| Rejected-removal | ⭐ `SEAT-BR-008` — rejection **names the blocking allocation**; offers Release *(`L6`)* or Transfer *(`L7`)* first |

**Permission-denied** — ⭐ Entry point **absent** without the grant. ⛔ Never a visible-but-disabled canvas.

**Privacy** — ⭐ The canvas shows seat **numbers and states only**. ⛔ **No holder identity on the editor** — a structural surface has no need for it. ⚠️ **DESIGN DECISION** consistent with `SEAT-FR-010`.

**Accessibility** — ⭐⭐ **`SEAT-FR-029`'s drag-and-drop is a requirement, but a drag-only interaction excludes switch and screen-reader users.** ⭐ Every drag has a **non-drag equivalent**: select seat → *Move* → directional nudge / pick target position. ⚠️ **DESIGN DECISION**, methodology-supported by Pro Max *"Dragging and swipe-only interactions have button/keyboard alternatives"*. ⛔ Not claimed as a Liboora requirement.

**Psychology** — ⭐ Perceived control: an explicit Save with a version number makes a structural change **reversible in understanding**, even though versions are append-only.

**Indian-market** — ⭐⭐ Editing a dense layout on a phone is the hardest interaction in this document. ⭐ `L3` is **zone-scoped**, never branch-wide, which bounds the canvas to a hall (§27.6).

**2D / 2.5D / 3D** — ⭐⭐ **2D, mandated**: `SEAT-FR-035` — *"An interactive **2D** layout is **mandatory** for V1."* ⭐ 3D is **optional** and ⛔ **not designed here** (§18.3).

**Cross-feature** — **X-5** floors/zones are read-only from `BC-06` (`SEAT-FR-015`).

**Traceability** — `SEAT-FR-028`…`035` · `SEAT-BR-007`/`008` · `SEAT-FR-297` · `SEAT-INV-006` · `SEAT-PO-016` · `SEAT-AC` §33.1

**GAP / CONFLICT** — ⚠️ `AIV-S10` *(no layout versioning in code)* · ⚠️ `AIV-S09` *(no `Floor` in code)* · ⚠️ `DD4-TBD-005`/`006`

---

### 11.4 `L4` — Seat Create / Renumber / Deactivate

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · ⭐ `TR-2` **with the same G grant as `L3`** |
| **Permission** | `SEAT-PO-018` — *"same grant as `SEAT-PO-016`"* |
| **Scope** | `tenantWide` |
| **Purpose** | Manage seat existence and identity |
| **Entry point** | `L23` → Seats; also `L3`'s `[+ Seat]` |
| **Hierarchy** | Form: seat number · zone · category · type `Fixed`/`Flexible` (`SEAT-FR-024`) |
| **Primary actions** | Create · Renumber · Deactivate |
| **Secondary** | — |
| **Components** | `PanelCard` · form fields · `Pill` |
| **States** | Loading · Empty *(no seats)* · ⭐ **Duplicate-number error** — `SEAT-BR-005`, evaluated **case-insensitively and whitespace-trimmed** (`SEAT-FR-026`) · ⭐ Same number in a different zone is **accepted**, ⛔ not a conflict (`SEAT-BR-006`) |
| **Permission-denied** | Entry absent without the grant |
| **Privacy** | ⛔ No student data on this surface at all |
| **Accessibility** | ⭐ Inline field-level errors; ⭐ error text names the conflicting zone |
| **Psychology** | ⭐ `SEAT-FR-027` permits renumbering **while allocated** — the form states that identity and allocation are unaffected (`SEAT-BR-004`), removing a reasonable fear |
| **Indian-market** | ⭐ Free-text seat numbers *("A1", "अ1", "12-B")*; ⛔ no numeric-only constraint invented |
| **Depth** | ⭐ **2D** form |
| **Cross-feature** | **X-5** zone must exist in `BC-06` (`SEAT-FR-174`) |
| **Traceability** | `SEAT-PO-018` · `SEAT-FR-023`…`027` · `SEAT-BR-004`/`005`/`006` |
| **GAP** | ⚠️ `AIV-S11` *(no category/type/shift fields on `Seat` in code)* |

---

### 11.5 `L5` — Assign Seat

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · `TR-3` |
| **Permission** | `SEAT-PO-001` |
| **Scope** | `tenantWide` |
| **Purpose** | Give an available seat to an explicitly chosen student |
| **Entry point** | `L2` → **Assign** *(on an `Available` seat)*; `L18` after auto-selection |

**Hierarchy** — ⭐ **Student selection is mandatory and explicit**: `SEAT-FR-056` — *"Assignment **MUST** require the actor to select the student explicitly. The module **MUST NOT** infer the student from context."*

```
┌─ Assign seat A-14 ──────────────────────────────────┐
│  Search student…                                    │
│  ○ Priya S.      Monthly Morning · valid to 30 Sep  │ ⭐ validity state only
│  ○ Rahul K.      ⚠ No active membership             │ ⭐ G7 will block
│  ─────────────────────────────────────────────      │
│  Window   01 Sep → 30 Sep  (defaults to membership) │
│                                    [Assign]         │
└─────────────────────────────────────────────────────┘
```

| Attribute | Specification |
|---|---|
| **Primary actions** | Select student → Assign |
| **Secondary** | ⭐ *Auto-assign instead* → `L18` *(reduces decision fatigue, §7.3)* |
| **Components** | `Monogram` · `ListTile` · `FilledButton` · bottom sheet |
| **States** | Loading *(student list)* · Empty *(no students)* · ⭐ **Gate rejection** — per-gate message (§12.1) · Conflict *(case 1)* · ⭐ **Idempotent re-submit** |
| **Permission-denied** | Action absent on `L2` |
| **Privacy** | ⭐ Shows **validity state and plan name only** for the *selected* student; ⛔ no dues, no amount (`SEAT-FR-279`). ⚠️ **Plan name** is shown because `AssignSeat` already surfaces it as evidence — ⚠️ but `SEAT-FR-280` limits *card* composition to validity/`validUntil`/`seatQuota`. ⭐ **Design decision: show validity state, not plan name**, to stay inside the narrower rule → §22.3 |
| **Accessibility** | ⭐ Radio semantics for selection; ⭐ the *"no active membership"* warning is text, ⛔ not colour alone |
| **Psychology** | ⭐⭐ `SEAT-BR-014` — `G7` is absolute for **every role including Owner**; ⛔ `SEAT-XC-004` forbids an *"assign anyway"* affordance. ⭐ The form therefore shows the block as a **fact about the membership**, not a permission the operator lacks |
| **Indian-market** | ⭐ Desk-first: this is the **default** acquisition path when `SEAT-CFG-008` is disabled |
| **Depth** | ⭐ **2.5D** sheet over `L1` |
| **Cross-feature** | **X-2** `G7` · **X-3** `G6` · **X-6** name |
| **Traceability** | `SEAT-PO-001` · `SEAT-FR-055`/`056`/`057`/`058` · `SEAT-BR-016` · `SEAT-BR-014` · `SEAT-XC-004` |
| **GAP** | ⚠️ `AIV-S02` *(current code assigns directly on tapping a free seat)* |

---

### 11.6 `L6` — Release Allocation

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · `TR-3` |
| **Permission** | `SEAT-PO-002` |
| **Scope** | `tenantWide` |
| **Purpose** | Close an allocation, preserving it as history |
| **Entry point** | `L2` → **Release** |
| **Hierarchy** | ⭐ **Reason is mandatory** — `SEAT-FR-060`: from `SEAT-CFG-004`'s configured list **or** free text |
| **Primary actions** | Choose reason → Release |
| **Secondary** | ⭐ *Transfer instead* → `L7` *(the non-destructive alternative, offered deliberately)* |
| **Components** | `AlertDialog` · reason chips + text field |
| **States** | Loading · ⭐ **Already released** — conflict, ⛔ not a silent success (`SEAT-FR-061`) · Error · Idempotent re-submit |
| **Permission-denied** | Action absent |
| **Privacy** | ⭐ Holder name shown to staff only |
| **Accessibility** | ⭐ Destructive action uses `LiblColors.danger` **plus** the word *"Release"*; ⛔ colour alone insufficient |
| **Psychology** | ⭐⭐ Release is the only routine **seat-removing** action a human performs. ⭐ Offering *Transfer instead* as a peer action reframes it from *"take the seat away"* to *"move or close"*. ⚠️ **DESIGN DECISION** |
| **Indian-market** | ⭐ Reason list is tenant-configurable, so local vocabulary is possible (`SEAT-CFG-004`) |
| **Depth** | ⭐ **2D** dialog |
| **Cross-feature** | ⭐ Emits `SEAT-EVT-002` → `BC-22`/`BC-26`; ⛔ this module dispatches nothing (§20) |
| **Traceability** | `SEAT-PO-002` · `SEAT-FR-059`/`060`/`061` · `SEAT-CFG-004` · `SEAT-EVT-002` |
| **GAP** | ⚠️ `AIV-S07` *(`releaseSeat` gated by `assignSeat` in code — cannot express Reception's boundary)* |

---

### 11.7 `L7` — Transfer

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · `TR-3` |
| **Permission** | `SEAT-PO-003` |
| **Scope** | `tenantWide` |
| **Purpose** | Move a student from one seat to another, **atomically** |
| **Entry point** | `L2` → **Transfer**; `L8` on approving a request |
| **Hierarchy** | Source *(fixed)* → destination picker → reason |
| **Primary actions** | Choose destination → Transfer |
| **Secondary** | — |
| **Components** | Destination picker reusing `L1`'s zone sections filtered to assignable |
| **States** | Loading · ⭐ **No eligible destination** — ⛔ never a partial state · ⭐ **Transfer-limit reached** — `SEAT-FR-066`: reason **names the limit and the count used** · Conflict · Idempotent |
| **Permission-denied** | Action absent |
| **Privacy** | ⭐ Destination picker shows **assignability only**, ⛔ not who holds other seats *(consistent with `SEAT-FR-275`'s principle, applied here as a design decision)* |
| **Accessibility** | ⭐ Destination list is a labelled single-select |
| **Psychology** | ⭐⭐ `SEAT-FR-063` — *"either the student holds the new seat and no longer holds the old, or nothing changed. A state in which the student holds **both, or neither**, **MUST NOT** be observable."* ⭐ The surface therefore shows **one** outcome, never an intermediate — which is precisely what prevents the "did I lose my seat?" anxiety |
| **Indian-market** | ⭐ `maxTransfersPerDay` comes from `BC-06` per branch (`SEAT-BR-017`); ⛔ the design invents no limit |
| **Depth** | ⭐ **2.5D** |
| **Cross-feature** | ⭐ Gate evaluated in full against the **destination** *before* releasing the source (`SEAT-FR-064`) · **X-5** limit from `E-05` |
| **Traceability** | `SEAT-PO-003` · `SEAT-FR-062`…`067` · `SEAT-BR-017` · `SEAT-EVT-003` |
| **GAP** | ⚠️ `AIV-S06` *(no distinct transfer permission in code)* |

---

### 11.8 `L8` — Seat-Change Request Decision

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · `TR-3` |
| **Permission** | `SEAT-PO-004` |
| **Scope** | `tenantWide` |
| **Purpose** | Approve or reject a student's seat-change request |
| **Entry point** | `L24` → *Pending requests* |
| **Hierarchy** | Request detail *(student, current seat, desired seat / category / no preference, optional reason)* → decision |
| **Primary actions** | Approve *(→ executes `L7`)* · Reject *(reason **mandatory**, `SEAT-FR-071`)* |
| **Secondary** | Open `L2` for either seat |
| **Components** | `PanelCard` · `Pill` for request state |
| **States** | Loading · Empty queue · ⭐⭐ **Approval-time gate failure** — `SEAT-FR-072`: the gate runs **at approval, not at request**, and on failure the request ⭐ **stays `Pending`** with the gate reason · Expired *(`SEAT-CFG-007`, 7 d)* |
| **Permission-denied** | Queue absent |
| **Privacy** | ⭐ One student's request at a time; ⛔ no other student's data in the decision view |
| **Accessibility** | ⭐ Reject requires a reason — inline validation, ⛔ not a silent no-op |
| **Psychology** | ⭐⭐ *"Approval of a request whose target has since become unavailable **MUST** fail with the gate reason and **MUST** leave the request `Pending`"* — ⭐ the design surfaces this as *"could not approve yet"*, ⛔ **not** as a rejection. That distinction protects the student from a decision nobody made |
| **Indian-market** | ⭐ `ApprovalRequired` is the **default** booking mode, so this queue is the common path, not an exception |
| **Depth** | ⭐ **2D** list, **2.5D** detail card |
| **Cross-feature** | ⭐ Approval executes `F5` Transfer |
| **Traceability** | `SEAT-PO-004` · `SEAT-FR-068`…`075` · `SEAT-CFG-006`/`007` |
| **GAP** | ⚠️ `AIV-S06` |

---

### 11.9 `L9` — Reservation Approve / Reject

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · `TR-3` |
| **Permission** | `SEAT-PO-008` |
| **Scope** | `tenantWide` |
| **Purpose** | Decide a `Pending` reservation request created under `ApprovalRequired` |
| **Entry point** | `L24` → *Pending reservations* |
| **Hierarchy** | Student · requested seat · window · shift → decision |
| **Primary actions** | Approve *(creates the reservation)* · Reject *(reason mandatory)* |
| **Secondary** | Open `L2` |
| **Components** | As `L8` |
| **States** | Loading · Empty · ⭐ Expired after `SEAT-CFG-007` *(default 7 days)* · Gate failure at approval |
| **Permission-denied** | Queue absent |
| **Privacy** | One student per decision view |
| **Accessibility** | As `L8` |
| **Psychology** | ⭐ A pending reservation confers **no right** (`SEAT-FR-042` — *"The holder holds no occupancy right until conversion"*). ⭐ The surface therefore never uses the word *"confirmed"* before conversion |
| **Indian-market** | ⭐ Default-path queue |
| **Depth** | ⭐ **2D** / **2.5D** |
| **Cross-feature** | → `F7` conversion |
| **Traceability** | `SEAT-PO-008` · `SEAT-FR-128`…`130` · `SEAT-CFG-007` |
| **GAP** | ⚠️ `AIV-S06` |

---

### 11.10 `L10` — Reservation Confirm *(trigger T3)*

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · `TR-3` |
| **Permission** | `SEAT-PO-006` |
| **Scope** | `tenantWide` |
| **Purpose** | ⭐ Staff-driven conversion of a reservation into an allocation — `T3`, *"Always available in every mode"* (`SEAT-FR-088`) |
| **Entry point** | `L2` on a `Reserved` seat → **Confirm** |
| **Hierarchy** | Reservation summary → Confirm |
| **Primary actions** | Confirm |
| **Secondary** | Cancel reservation → `L11` |
| **Components** | `AlertDialog` |
| **States** | Loading · ⭐ **Already converted** — returns the existing allocation, ⛔ never a second one (`SEAT-FR-090`) · ⭐ **Gate failure**: `SEAT-FR-091` re-evaluates `G6`, `G7`, `G8`, `G11`, `G12` **at conversion** · Expired |
| **Permission-denied** | Action absent |
| **Privacy** | Holder shown to staff only |
| **Accessibility** | Confirm is a labelled primary action |
| **Psychology** | ⭐⭐ Edge case 3: a reservation created while the membership was valid ⛔ **must not** convert after it lapses. ⭐ The dialog states the membership reason plainly — ⛔ it is not framed as the student having done something wrong (§7.4) |
| **Indian-market** | ⭐ Desk conversion is the realistic path where students arrive without phones |
| **Depth** | ⭐ **2D** dialog |
| **Cross-feature** | ⭐ `T2` conversion is driven by `E-08` check-in — **X-4** |
| **Traceability** | `SEAT-PO-006` · `SEAT-FR-088`…`091` · `SEAT-CFG-011` |
| **GAP** | ⚠️ `AIV-S06` |

---

### 11.11 `L11` — Cancel Another Student's Reservation

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · ⭐ `TR-3` **only where `SEAT-CFG-014` grants it** *(default **not granted**)* |
| **Permission** | `SEAT-PO-007` |
| **Scope** | `tenantWide` |
| **Purpose** | Staff override of a reservation held by another student |
| **Entry point** | `L2` on a `Reserved` seat → **Cancel reservation** |
| **Hierarchy** | Reservation summary → reason → confirm |
| **Primary actions** | Cancel *(reason recorded)* |
| **Secondary** | Confirm instead → `L10` |
| **Components** | `AlertDialog` |
| **States** | Loading · Already expired *(no-op, stated)* · Error · Idempotent |
| **Permission-denied** | ⭐ Action **absent** for an ungranted Reception |
| **Privacy** | Holder shown to staff only |
| **Accessibility** | Destructive styling **plus** the word *"Cancel reservation"* |
| **Psychology** | ⭐⭐ `SEAT-XC-006` draws the line the design must respect: *"Overriding a **reservation** is permitted to authorised roles. Overriding **membership validity** is permitted to **no one**."* ⭐ So this surface exists, ⛔ while an *"assign anyway"* never can |
| **Indian-market** | ⭐ Default-not-granted protects a walk-in-heavy library from a well-meaning counter override |
| **Depth** | ⭐ **2D** dialog |
| **Cross-feature** | — |
| **Traceability** | `SEAT-PO-007` · `SEAT-FR-102` · `SEAT-CFG-014` · `SEAT-XC-006` |
| **GAP** | ⚠️ `AIV-S06` |

---

### 11.12 `L12` — Lock / Unlock

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` — ⛔ **Reception MUST NOT** (`SEAT-FR-158`) |
| **Permission** | `SEAT-PO-009` |
| **Scope** | `tenantWide` |
| **Purpose** | Suppress **new acquisition only**, without disturbing the holder |
| **Entry point** | `L2` → **Lock** / **Unlock** |
| **Hierarchy** | ⭐ **Reason mandatory** (`SEAT-FR-159`: actor, timestamp, reason) |
| **Primary actions** | Lock *(with reason)* · Unlock |
| **Secondary** | — |
| **Components** | `AlertDialog` · reason field |
| **States** | Loading · Already locked/unlocked *(stated, idempotent)* · Error |
| **Permission-denied** | ⭐ Action **absent** for Reception |
| **Privacy** | ⭐⭐ **Asymmetric by requirement** — `SEAT-FR-163`: a locked seat is *"visibly marked as locked to **every staff role**, **with its reason**"*, and *"presented to **students as unavailable without disclosing the lock reason**"* |
| **Accessibility** | ⭐ 🔒 icon **plus** the word *"Locked"*; ⭐ `SEAT-FR-039`: *"A lock **MUST NOT** be invisible"* |
| **Psychology** | ⭐⭐ The most reassuring rule on this surface is `SEAT-FR-161`: a lock ⛔ *"**MUST NOT** prevent release or transfer-**out**… Locking a seat must never trap a student in it."* ⭐ `L2` therefore keeps Release/Transfer enabled on a locked occupied seat — §10E case 18 |
| **Indian-market** | ⭐ Reason is free text, so local justifications are possible |
| **Depth** | ⭐ **2D** dialog |
| **Cross-feature** | — |
| **Traceability** | `SEAT-PO-009` · `SEAT-FR-158`…`163` · `SEAT-BR-025` · `SEAT-FR-038`/`039` |
| **GAP** | ⛔ `AIV-S04` *(**no lock concept exists in `lib/` at all** — §21)* |

---

### 11.13 `L13` — Lock Override

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · ⭐ `TR-2` **only where `SEAT-CFG-005` grants it** *(default **Owner only**)* · ⛔ **Reception never** |
| **Permission** | `SEAT-PO-010` |
| **Scope** | `tenantWide` |
| **Purpose** | ⭐ Override a lock **for a single assignment** (`SEAT-FR-162`) |
| **Entry point** | Appears **inside** `L5`'s gate rejection at `G12`, ⛔ not as a standalone menu item |
| **Hierarchy** | Rejection reason → *"Override lock for this assignment"* → reason → proceed |
| **Primary actions** | Override *(reason recorded)* |
| **Secondary** | Unlock instead → `L12` |
| **Components** | Inline escalation within `L5`'s sheet |
| **States** | Loading · ⭐ **Not permitted** — for an ungranted Manager the override is **absent**, and the `G12` rejection stands alone |
| **Permission-denied** | Absent |
| **Privacy** | ⛔ No student data added |
| **Accessibility** | Labelled secondary action inside an error region |
| **Psychology** | ⭐⭐ Placing the override **inside the rejection** rather than in a menu means it is only ever seen by someone who has already met the blocking reason. ⚠️ **DESIGN DECISION** — it prevents override becoming a habit |
| **Indian-market** | ⭐ Single-assignment scope prevents a counter from silently disabling a lock policy |
| **Depth** | ⭐ **2D** |
| **Cross-feature** | `G12` of `F1` |
| **Traceability** | `SEAT-PO-010` · `SEAT-FR-162` · `SEAT-CFG-005` |
| **GAP** | ⛔ `AIV-S04` · ⚠️ `AIV-S06` |

---

### 11.14 `L14` — Maintenance + Disposition ⭐

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` — ⛔ **Reception may report only** (`L15`) |
| **Permission** | `SEAT-PO-011` |
| **Scope** | `tenantWide` |
| **Purpose** | Take a seat out of service and return it |
| **Entry point** | `L2` → **Maintenance**; `L24` → *Maintenance reports* |

**Hierarchy** — ⭐⭐ **On an occupied seat the three-option step is MANDATORY.**
`SEAT-FR-167`: *"Starting maintenance on a seat with an active allocation
**MUST** require the actor to choose one of exactly three explicit
dispositions."*

```
┌─ Start maintenance — A-14 ───────────────────────────┐
│  Reason *  [Damaged armrest                       ]  │ ⭐ SEAT-FR-165
│  Expected end (optional)  [ ____ ]                   │
│  ────────────────────────────────────────────────    │
│  ⚠ Priya S. holds this seat. Choose what happens:    │
│                                                       │
│  ◉ Retain    Allocation preserved; seat shows        │ ⭐ DEFAULT
│              Maintenance                              │
│  ○ Relocate  Attempt transfer to a comparable seat.   │
│              ⚠ If it fails, maintenance does NOT start│ ⭐ SEAT-FR-167
│  ○ Release   Allocation released, reason maintenance  │ ⭐ needs confirmation
│                                       [Start]         │
└──────────────────────────────────────────────────────┘
```

| Attribute | Specification |
|---|---|
| **Primary actions** | Start *(with disposition)* · End *(resolution note)* |
| **Secondary** | — |
| **Components** | `PanelCard` · radio group · text fields |
| **States** | Loading · ⭐ **Relocate failed → maintenance NOT started** *(a distinct, named outcome)* · ⭐ **Unexpired reservation present** → `SEAT-BR-027`: it is **explicitly cancelled** with a notification fact, ⛔ never silently left · ⭐ On end: `SEAT-BR-026` — a surviving allocation is **reinstated as the visible state** |
| **Permission-denied** | ⭐ Action absent for Reception; ⭐ *Report* offered instead → `L15` |
| **Privacy** | Holder shown to staff only |
| **Accessibility** | ⭐ Radio group with full text labels; ⭐ the Relocate warning is text |
| **Psychology** | ⭐⭐ *"The system does not choose"* is the design's governing sentence here. ⭐ **Retain is the default** because it is the non-destructive option, and `SEAT-BR-043` makes retention the norm. ⭐ Release requires an extra confirmation because it is the only branch that takes a seat away |
| **Indian-market** | ⭐ Expected-end is **optional** (`SEAT-FR-165`) — a small library may not know |
| **Depth** | ⭐ **2D** form, **2.5D** card |
| **Cross-feature** | ⭐ Relocate runs `F5`; ⭐ `SEAT-FR-168` — the relocation ⛔ **does not** count against `maxTransfersPerDay` |
| **Traceability** | `SEAT-PO-011` · `SEAT-FR-164`…`170` · `SEAT-BR-026`/`027` · `SEAT-FR-043` |
| **GAP** | ⛔ `AIV-S05` *(**no maintenance concept in `lib/`** — §21)* |

---

### 11.15 `L15` — Report Maintenance Need

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · ⭐ **`TR-3` Reception** |
| **Permission** | `SEAT-PO-012` |
| **Scope** | `tenantWide` |
| **Purpose** | ⭐ Record a need **without** changing seat state — `SEAT-FR-166` |
| **Entry point** | `L2` → **Report issue** |
| **Hierarchy** | Reason *(mandatory)* → submit |
| **Primary actions** | Report |
| **Secondary** | — |
| **Components** | `AlertDialog` · text field |
| **States** | Loading · ⭐ **Submitted → appears in `L24`**, ⛔ seat state **unchanged** · Error |
| **Permission-denied** | Absent |
| **Privacy** | ⛔ No student data |
| **Accessibility** | Labelled field with inline validation |
| **Psychology** | ⭐⭐ `PRD-007`'s own rationale is the design rationale: *"**a report is not a decision.** If a report immediately took a seat out of service, any staff member could remove capacity without authority."* ⭐ The confirmation therefore says *"Reported — a manager will decide"*, ⛔ never *"Seat taken out of service"* |
| **Indian-market** | ⭐ Lets a counter operator act on a real-world problem without holding authority |
| **Depth** | ⭐ **2D** dialog |
| **Cross-feature** | → `L24` *Maintenance reports* |
| **Traceability** | `SEAT-PO-012` · `SEAT-FR-164`/`166` |
| **GAP** | ⛔ `AIV-S05` |

---

### 11.16 `L16` — Bulk Import / Export

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` — ⛔ **Reception MUST NOT** (`SEAT-FR-171`) |
| **Permission** | `SEAT-PO-013` import · `SEAT-PO-014` export |
| **Scope** | `tenantWide` |
| **Purpose** | Load or extract seat inventory |
| **Entry point** | `L1` overflow ▾ → *Bulk*; also `L23` |

**Hierarchy** — ⭐ **The error report is the primary result view**, not a footnote:

```
┌─ Import seats ───────────────────────────────────────┐
│  [Choose file]    max 2,000 rows                     │ ⭐ SEAT-FR-179
│  ────────────────────────────────────────────────    │
│  ⛔ NOT APPLIED — 3 of 500 rows failed validation     │ ⭐⭐ SEAT-BR-028
│     all-or-nothing                                   │
│  Row 400  A1     duplicate seat number in Hall A     │ ⭐ SEAT-BR-005
│  Row 412  —      zone "Hall Z" does not exist        │ ⭐ SEAT-FR-174
│  Row 488  C7     unknown category                    │
│                        [Download report] [Re-upload] │
└──────────────────────────────────────────────────────┘
```

| Attribute | Specification |
|---|---|
| **Primary actions** | Choose file → validate → apply · Export |
| **Secondary** | Download error report |
| **Components** | `PanelCard` · row-error list |
| **States** | Loading · ⭐⭐ **All-or-nothing failure** with per-row reasons (`SEAT-BR-028`) · ⭐ **Row bound exceeded** — rejected **before validation begins**, with the bound stated (`SEAT-FR-179`) · ⭐ **Duplicate submission** — *"already applied"*, original result returned (`SEAT-FR-173`) · ⭐ Entitlement limit reached at `G4` |
| **Permission-denied** | ⭐ Absent for Reception, students and guardians (`SEAT-FR-286`) |
| **Privacy** | ⭐⭐ `SEAT-FR-175`/`284` — export contains **seat inventory and layout only**; ⛔ **no names, contacts, membership beyond validity/`validUntil`, or monetary value**; ⭐ students identified by `StudentRecordId` and admission number only. ⭐ `SEAT-FR-285` — **every export is audited with filter criteria and row count** |
| **Accessibility** | ⭐ Error list is a semantic list with row numbers; ⛔ not a colour-coded grid |
| **Psychology** | ⭐⭐ `PRD-007`'s rationale: *"A partially applied import leaves a tenant unable to tell what state their inventory is in."* ⭐ The surface states **NOT APPLIED** first, so there is no ambiguity about whether anything changed |
| **Indian-market** | ⭐ File import is how an existing paper register gets digitised — the realistic onboarding path |
| **Depth** | ⭐ **2D** |
| **Cross-feature** | `G4` entitlement via `E-17` |
| **Traceability** | `SEAT-PO-013`/`014` · `SEAT-FR-171`…`175` · `SEAT-BR-028` · `SEAT-FR-179`/`284`/`285`/`286` · `SEAT-NFR-009` |
| **GAP** | ⚠️ `AIV-S06` *(no bulk permission in code)* |

---

### 11.17 `L17` — Bulk Reassign

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` |
| **Permission** | `SEAT-PO-015` |
| **Scope** | `tenantWide` |
| **Purpose** | ⭐ Move a set of allocations — *"for example when a zone is refurbished"* |
| **Entry point** | `L1` overflow ▾ → *Bulk reassign* |
| **Hierarchy** | Source selection → destination mapping → **per-row outcome** |
| **Primary actions** | Preview → Apply |
| **Secondary** | — |
| **Components** | `PanelCard` · mapping list |
| **States** | Loading · ⭐⭐ **Per-student gate evaluation** — `SEAT-BR-029`: the gate runs *"per student, per destination seat"*; ⛔ *"**MUST NOT** apply a single authorisation or a single validity check to the batch"* · ⭐ All-or-nothing apply (`SEAT-FR-177`) · ⭐ 500-allocation bound (`SEAT-FR-179`) |
| **Permission-denied** | Absent for Reception |
| **Privacy** | ⭐ Holder names visible to staff only; ⛔ no monetary or membership detail beyond validity |
| **Accessibility** | ⭐ Per-row outcome is text *(succeeded / reason)*, ⛔ not an icon column alone |
| **Psychology** | ⭐ Preview-before-apply gives perceived control over a high-blast-radius operation |
| **Indian-market** | ⭐ Refurbishment and hall re-planning are common; ⭐ `SEAT-FR-168`-style exemption applies — `SEAT-FR-067`: a **system**-initiated move ⛔ does not count against the student's transfer limit |
| **Depth** | ⭐ **2D** |
| **Cross-feature** | Runs `F5` per row |
| **Traceability** | `SEAT-PO-015` · `SEAT-FR-176`…`179` · `SEAT-BR-029` · `SEAT-FR-067` · `SEAT-NFR-009` |
| **GAP** | ⚠️ `AIV-S06` |

---

### 11.18 `L18` — Auto-Assign *(staff-invoked)*

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · `TR-3` |
| **Permission** | `SEAT-PO-017` |
| **Scope** | `tenantWide` |
| **Purpose** | Let the module select a candidate seat, then execute `L5` |
| **Entry point** | `L5` → *Auto-assign instead*; `L1` overflow ▾ |
| **Hierarchy** | ⭐ Student → **explain the selection** → confirm |

⭐⭐ **The four ordered criteria are shown, not hidden** — `SEAT-FR-184`
requires the criteria that selected the seat be recorded *"so that the choice is
explainable after the fact"*; ⭐ the design surfaces them **before** the fact too:

```
┌─ Auto-assign for Priya S. ───────────────────────────┐
│  Selected  A-07   Hall A · Floor 1 · Normal          │
│  Because:                                            │
│   1 lowest eligible category (Normal)                │ ⭐ SEAT-FR-182
│   2 preferred hall: Hall A                           │
│   3 most recent previous hall: Hall A                │
│   4 lowest seat number available: A-07               │
│                          [Assign]  [Choose manually] │
└──────────────────────────────────────────────────────┘
```

| Attribute | Specification |
|---|---|
| **Primary actions** | Assign · Choose manually → `L5` |
| **Secondary** | — |
| **Components** | `PanelCard` · ordered criteria list |
| **States** | Loading · ⭐⭐ **No candidate** — `SEAT-FR-183`: fails *"with a reason naming the most restrictive gate that eliminated the last candidate"*; ⛔ *"**MUST NOT** return a seat the student cannot use and **MUST NOT** create a reservation as a consolation"* · Conflict |
| **Permission-denied** | Absent |
| **Privacy** | ⭐ One student at a time |
| **Accessibility** | ⭐ The criteria list is an ordered list, ⛔ not a paragraph |
| **Psychology** | ⭐⭐ Directly addresses decision fatigue (§7.3) **and** trust: ⭐ an unexplained automatic choice erodes confidence, so the criteria are visible. ⚠️ **DESIGN DECISION** grounded in `SEAT-FR-184` |
| **Indian-market** | ⭐ Fast desk path at peak entry times |
| **Depth** | ⭐ **2.5D** sheet |
| **Cross-feature** | ⭐ Candidate set is *"exactly the seats for which **every** §8 gate passes"* (`SEAT-FR-181`) |
| **Traceability** | `SEAT-PO-017` · `SEAT-FR-180`…`185` |
| **GAP** | ⭐ **`DD4-GAP-001`** — criterion 2 cites *"the student's preferred zone, where they have recorded one"*, ⛔ **but no surface for recording a preference is specified anywhere in `PRD-007`** (§23) |

---

### 11.19 `L19` — Search + 12 Filter Presets ⭐

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · `TR-3` |
| **Permission** | ⭐ A **read model** (`SEAT-FR-257`), reachable under `SEAT-PO-024` |
| **Scope** | `tenantWide` |
| **Purpose** | ⭐⭐ The primary load-reducing entry into a 50×100-bounded inventory |
| **Entry point** | `L1` Tier 2 preset bar; search field in `L1`'s app bar |

#### ⭐ The 12 presets — verbatim predicates from `SEAT-FR-258`

| # | Preset | Predicate |
|---|---|---|
| 1 | Available now | `SeatState` = `Available` **and** not locked **and** no open maintenance |
| 2 | Unallocated | Active seat with no `Active` allocation whose window contains now |
| 3 | ⭐ Allocated but absent | `Active` allocation contains now **and** occupancy fact is *absent* |
| 4 | ⭐ Occupied without allocation | Occupancy *present* **and** no `Active` allocation contains now |
| 5 | Expiring soon | `validUntil` within `SEAT-CFG-018` *(default **7** days)* |
| 6 | Eligibility flagged | Flagged by `SEAT-BR-024` |
| 7 | Shift misaligned | Flagged by `SEAT-FR-139` |
| 8 | Membership expired | `E-02` shows expiry, awaiting `Q-01` (`SEAT-FR-155`) |
| 9 | Under maintenance | Open maintenance record in any state |
| 10 | Locked | Active lock, regardless of allocation |
| 11 | Reserved | Unexpired reservation |
| 12 | Never allocated | Active seat with no allocation record in its history |

⭐⭐ Presets 3 and 4 are the **two-axis rule made operational** — they are exactly
the two ways allocation and presence can disagree.

| Attribute | Specification |
|---|---|
| **Primary actions** | Apply preset · free filter · search by seat number / student |
| **Secondary** | ⭐ Save a named preset *(tenant-scoped, `SEAT-FR-259`)* |
| **Components** | Chip row · `SectionHeader` · result list reusing `SeatChip` |
| **States** | Loading · ⭐ **No results** — states the predicate that returned nothing, ⛔ not a bare *"no results"* · ⭐ **Paginated** when unbounded, *"stable under concurrent mutation"* (`SEAT-FR-261`) · Error |
| **Permission-denied** | ⭐⭐ `SEAT-FR-254` — a result the caller may not see is **ABSENT, not redacted**, and *"the total count **MUST** reflect only the permitted set — a count that reveals hidden rows is a disclosure"* |
| **Privacy** | ⭐⭐ `SEAT-FR-256` — ⛔ *"Search **MUST NOT** be the mechanism by which an unauthorised caller enumerates students"*; a search by an identifier the caller may not resolve returns **not-found** |
| **Accessibility** | ⭐ Presets are a labelled, horizontally scrollable chip group with selected state announced |
| **Psychology** | ⭐⭐ **The HCI perspective's decisive contribution** (§6 row 9): presets are **surfaced on `L1`**, not buried behind an *Advanced filters* affordance. ⚠️ **DESIGN DECISION** on ⚠️ `DD4-HYP-005` |
| **Indian-market** | ⭐ `SEAT-FR-255`'s natural ordering matters most here — a list of 100 seats sorted lexically is unusable |
| **Depth** | ⭐ **2D** |
| **Cross-feature** | ⛔ `SEAT-XC-021` — ⛔ **no `BC-23` index, no full-text, no fuzzy matching** |
| **Traceability** | `SEAT-FR-251`…`262` · `SEAT-CFG-018` · `SEAT-XC-021` · `SEAT-AC-183` |
| **GAP** | — |

---

### 11.20 `L20` — Seat Timeline *(staff)*

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · `TR-3` |
| **Permission** | `SEAT-PO-024` |
| **Scope** | `tenantWide` |
| **Purpose** | ⭐ One seat's chronology, composed from the **five independent facts** (`SEAT-FR-227`) |
| **Entry point** | `L2` → **Timeline** |
| **Hierarchy** | Reverse-chronological entries, each typed: allocation · reservation · lock · maintenance · occupancy |
| **Primary actions** | ⛔ **None — read-only.** `SEAT-FR-228`: the timeline *"**MUST NOT** be the sole record of any fact"* |
| **Secondary** | Filter by fact type |
| **Components** | `SectionHeader` · timeline list · `Pill` |
| **States** | Loading · Empty *(new seat)* · Error · ⭐ **Deterministic ordering** — by recorded time of the underlying fact, with a deterministic tiebreak *"so that two readers see the same sequence"* (`SEAT-FR-229`) |
| **Permission-denied** | Absent |
| **Privacy** | ⭐ Staff view shows holder identity; ⭐ the **student-facing** timeline is `S4` and is restricted to the requesting student's own rows (`SEAT-FR-230`) |
| **Accessibility** | ⭐ Semantic list; each entry states date, actor role and fact type in text |
| **Psychology** | ⭐⭐ Trust: `SEAT-XC-014` makes every row **append-only for every role including Owner**. ⭐ The surface says so — *"History cannot be edited"* — which is what makes a dispute answerable |
| **Indian-market** | ⭐ Renumbering safety is visible: `SEAT-BR-004`/`034` mean an old entry shows the seat number **as it was** — §10E case 25 |
| **Depth** | ⭐ **2D** |
| **Cross-feature** | ⛔⛔ `SEAT-FR-237` — ⛔ **the timeline MUST NOT read `BC-24`'s audit store** |
| **Traceability** | `SEAT-FR-227`…`231` · `SEAT-XC-014` · `SEAT-FR-237` |
| **GAP** | ⚠️ `AIV-S10` *(no layout versioning, so `SEAT-FR-231`'s historical rendering is not currently possible)* |

---

### 11.21 `L21` — Category Management

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · ⭐⭐ **`TR-1` Owner ONLY** |
| **Permission** | `SEAT-PO-019` |
| **Scope** | `tenantWide` |
| **Purpose** | Define seat classes — ⭐ *"modelled as **data, not code branches**"* (`SEAT-FR-142`) |
| **Entry point** | `L23` → Categories |
| **Hierarchy** | List *(defaults `Normal` · `Premium` · `VIP`, `SEAT-FR-143`)* → create / edit / deactivate |
| **Primary actions** | Create · Edit · ⭐ **Deactivate** *(never delete while referenced — `SEAT-FR-145`)* |
| **Secondary** | → `L22` eligibility |
| **Components** | `PanelCard` · list · form |
| **States** | Loading · Empty · ⭐ **Delete attempt blocked** — offers Deactivate instead, which *"suppresses its use for new seats without altering existing seats"* |
| **Permission-denied** | ⭐ Absent for Manager and Reception |
| **Privacy** | ⛔ No student data |
| **Accessibility** | ⭐ Active/inactive state in text |
| **Psychology** | ⭐⭐ `SEAT-FR-146` — re-categorising a seat ⛔ **must not** release the holder. ⭐ The edit form **states this before saving**, because an Owner could reasonably fear the opposite. ⭐ `PRD-007`'s own words: *"The eviction does not happen"* — §10E case 15 |
| **Indian-market** | ⭐ Tenant-defined categories beyond the three defaults; ⛔ **no price field** (`SEAT-FR-144`) |
| **Depth** | ⭐ **2D** |
| **Cross-feature** | ⭐ A `BC-02` plan **may reference a category by identifier** — ⛔ but pricing stays in the plan |
| **Traceability** | `SEAT-PO-019` · `SEAT-FR-142`…`146` |
| **GAP** | ⚠️ `AIV-S11` *(no category on `Seat` in code)* |

---

### 11.22 `L22` — Category Eligibility Rule

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · ⭐⭐ **`TR-1` Owner ONLY** |
| **Permission** | `SEAT-PO-020` |
| **Scope** | `tenantWide` |
| **Purpose** | Set which students may occupy which category — ⭐ evaluated at gate `G13` |
| **Entry point** | `L21` → Eligibility |
| **Hierarchy** | ⭐ **Inputs are shown with their owners**, because this module *evaluates* but does not *author* the plan→category mapping (`SEAT-BR-023`) |

```
┌─ Eligibility — Premium ──────────────────────────────┐
│  Evaluated at acquisition and conversion only         │ ⭐ SEAT-FR-150
│  ⓘ This library evaluates the rule. Which PLAN grants │ ⭐⭐ SEAT-BR-023
│    which category is a membership-plan attribute.     │
│  ────────────────────────────────────────────────    │
│  Restricted categories  [ Premium ] [ VIP ]           │ ⭐ SEAT-FR-148
│  ⚠ Changing this flags existing allocations for       │ ⭐ SEAT-BR-024
│    review. Nothing is released.                       │
└──────────────────────────────────────────────────────┘
```

| Attribute | Specification |
|---|---|
| **Primary actions** | Set restricted categories → Save |
| **Secondary** | → `L24` eligibility queue |
| **Components** | `PanelCard` · chip multi-select |
| **States** | Loading · ⭐⭐ **Absent permitted-category list** → `SEAT-FR-148`: treat **every** category as permitted except those marked restricted; ⛔ *"**MUST NOT** silently deny all categories, which would make seating impossible for every student"* · ⭐ Save warns of queue volume |
| **Permission-denied** | Absent |
| **Privacy** | ⭐ `SEAT-FR-149` — an eligibility denial *"**MUST** state the category and the reason, and **MUST NOT** disclose another student's plan or data"* |
| **Accessibility** | ⭐ Multi-select with announced selected state |
| **Psychology** | ⭐⭐ The warning is the design's whole job here: `SEAT-BR-024` — *"An existing allocation **MUST NOT** be automatically released, truncated or moved because an eligibility input changed."* ⭐ Saying so prevents an Owner from fearing a mass eviction |
| **Indian-market** | ⭐ Fail-open default keeps a library operable if upstream data is thin |
| **Depth** | ⭐ **2D** |
| **Cross-feature** | ⭐ Inputs from `E-02` *(plan, `seatQuota`)* and `E-05` *(seat rules)* |
| **Traceability** | `SEAT-PO-020` · `SEAT-FR-147`…`150` · `SEAT-BR-023`/`024` |
| **GAP** | ⚠️ `AIV-S11` |

---

### 11.23 `L23` — Module Configuration *(18 rows)*

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · ⭐⭐ **`TR-1` Owner ONLY** |
| **Permission** | `SEAT-PO-021` |
| **Scope** | `tenantWide` |
| **Purpose** | The 18 `SEAT-CFG-*` rows, each with one owner and one default |
| **Entry point** | Settings → Seating |

**Hierarchy** — grouped by what the setting *does*, with ⭐ **`BC-06`-owned values shown read-only**:

| Group | Rows |
|---|---|
| Vocabulary | `SEAT-CFG-001` zone label |
| Acquisition | `002` quota fallback · `003` `Inactive` blocks · `009` window-exceeds-membership |
| Student self-service | ⭐ `008` self-booking *(default **disabled**)* · `010` booking mode · `011` conversion trigger · `012`/`013` no-show |
| Reservations | `015` hold duration · `016` max concurrent · `014` Reception may cancel |
| Requests | `006` max pending · `007` decision deadline |
| Staff limits | `005` override grant · `004` release reasons |
| Filters | `018` expiring-soon horizon |
| ⭐ Read-only, owned by `BC-06` | `017` occupancy threshold · `maxTransfersPerDay` · `reservationWindow` · floors/zones · shifts |

| Attribute | Specification |
|---|---|
| **Primary actions** | Change a value |
| **Secondary** | → `L21` · `L22` · `L4` |
| **Components** | `PanelCard` · switches · selects · duration fields |
| **States** | Loading · ⭐⭐ **`SEAT-CFG-017` unset** — the surface must state *"No threshold set — no alert is emitted at any occupancy"*; ⛔ **the 90% figure MUST NOT be shown as an active default** (`SEAT-FR-241`, `SEAT-FR-265`) · ⭐ Every row shows its **default** and its **value domain** |
| **Permission-denied** | Absent for Manager and Reception |
| **Privacy** | ⛔ No student data |
| **Accessibility** | ⭐ Each control labelled with its effect, ⛔ not its identifier |
| **Psychology** | ⭐⭐ `SEAT-FR-264` — a config change ⛔ *"**MUST NOT** apply retroactively"*. ⭐ The surface states *"Applies to new allocations only"*, which removes the fear that flipping a switch rewrites live arrangements |
| **Indian-market** | ⭐⭐ Defaults are the product for most libraries — `LIB-16.2` requires an unconfigured library to be fully operable, so this surface must be **optional to visit** |
| **Depth** | ⭐ **2D** |
| **Cross-feature** | ⭐ `E-19` typed accessors; ⛔ `BC-06` values ⛔ **not** read from `BC-25` (`SEAT-FR-263`) |
| **Traceability** | `SEAT-PO-021` · §27.1 all 18 rows · `SEAT-FR-263`…`267` · `SEAT-FR-301` · `SEAT-XC-022` |
| **GAP** | ⚠️ `SEAT-GAP-005` *(threshold not yet carried by `E-05`)* · ⚠️ `SEAT-GAP-002` *(case 7)* |

---

### 11.24 `L24` — Work Queues ⭐ *(5 queues)*

| Attribute | Specification |
|---|---|
| **App / Roles** | **APP 2** · `TR-1` · `TR-2` · `TR-3` |
| **Permission** | ⭐ A **read model over existing state** (`SEAT-FR-216`), ⛔ not a new aggregate |
| **Scope** | `tenantWide` |
| **Purpose** | ⭐⭐ The surface that makes *"retain-and-flag"* actionable |
| **Entry point** | Seats tab → **Queues** |

#### ⭐ The five queues — verbatim from `SEAT-FR-216`

| Queue | Contains | Created by | Leads to |
|---|---|---|---|
| Eligibility review | Allocations flagged by `SEAT-BR-024` | membership / plan / category change | `L2`, `L6`, `L7` |
| Shift misalignment | Allocations flagged by `SEAT-FR-139` | shift change | `L2`, `L7` |
| Maintenance reports | `Reported` records awaiting a decision | `SEAT-FR-166` | `L14` |
| Pending requests | `Pending` seat-change **and** reservation requests | §§10, 15.3 | `L8`, `L9` |
| Expiry-flagged | Allocations whose membership expired, awaiting `Q-01` | `SEAT-FR-155` | `L2`, `L6` |

| Attribute | Specification |
|---|---|
| **Primary actions** | Open an item → its decision surface |
| **Secondary** | Sort, filter within a queue |
| **Components** | Tab bar *(5)* · `SectionHeader` · list · `Pill` |
| **States** | Loading · ⭐ Empty *per queue* with a **neutral** message · Error · ⭐ Count badges per queue |
| **Permission-denied** | Absent |
| **Privacy** | ⭐ Staff-only; ⛔ never mirrored to `S4`/`P1` (§7.2) |
| **Accessibility** | ⭐ Tab semantics with counts announced; ⛔ count is not colour-only |
| **Psychology** | ⭐⭐ `SEAT-FR-217` is the design's hard boundary: ⛔ *"A work queue **MUST NOT** perform an automatic action on its contents. **It exists so a human acts.**"* ⭐ So there is ⛔ **no *"Resolve all"* affordance** — a bulk-resolve control would defeat the requirement's purpose |
| **Indian-market** | ⭐ A single queues surface suits one manager covering several halls |
| **Depth** | ⭐ **2D** lists |
| **Cross-feature** | ⭐ `SEAT-FR-240` — where a fact has **no event carrier in V1**, it *"**MUST**"* appear here; ⛔ *"a new event type **MUST NOT** be invented to carry it"* |
| **Traceability** | `SEAT-FR-216`/`217` · `SEAT-FR-240` · `SEAT-BR-024` · `SEAT-FR-139`/`155`/`166`/`300` |
| **GAP** | ⭐ **`DD4-GAP-003`** — ⛔⛔ `SEAT-FR-299` requires a **wrong-seat check-in mismatch** be *"surfaced to staff"*, but ⛔ **§22.4's queue list contains no mismatch queue** (§23) |

---

### 11.25 `S1` — Student Availability ⭐ *(a different surface, not a filtered `L1`)*

| Attribute | Specification |
|---|---|
| **App / Roles** | ⭐ **APP 1** · `TR-4` Student |
| **Permission** | Implied by `SEAT-PO-005`; ⭐ **conditional on `SEAT-CFG-008`** *(default **disabled**)* |
| **Scope** | ⭐ `self` |
| **Purpose** | ⭐ `SEAT-FR-076` — let a student *"view seat availability and book a seat for themselves"* |
| **Entry point** | Student app → Seat → *Find a seat* — ⭐ **absent entirely when `SEAT-CFG-008` is disabled** |

**Hierarchy** — ⭐⭐ **This is NOT `L1` with fields hidden. It is a different data
shape, mandated by `SEAT-FR-275`:**

> ⭐⭐ *"The seat map presented to a student shows, per seat: **the seat number, its
> derived assignability, its category, and whether it is their own seat.** It
> **MUST NOT** show another student's identifier, name, initials, photograph,
> membership state, shift, attendance state or occupancy state."*

```
┌─ Find a seat ────────────────────────────────────────┐
│  Hall A — Floor 1                                    │ ⭐ tenant label
│  ┌────┐┌────┐┌────┐┌────┐                            │
│  │ A1 ││ A2 ││ A3 ││ A4 │   ✓ = can be booked        │ ⭐ assignability ONLY
│  │ ✓  ││ ✓  ││ ─  ││YOURS│  ─ = unavailable          │ ⭐ SEAT-FR-275
│  └────┘└────┘└────┘└────┘                            │
│  Normal · Premium (not eligible)                     │ ⭐ category shown
│                                                       │
│  ⓘ Unavailable seats show no reason.                  │ ⭐⭐ SEAT-FR-163
└──────────────────────────────────────────────────────┘
```

| Attribute | Specification |
|---|---|
| **Primary actions** | Select an available seat → `S2` |
| **Secondary** | ⭐ Aggregate counts **only where the tenant enables them** (`SEAT-FR-276`) |
| **Components** | ⭐ **new** `StudentSeatChip` — a deliberately *reduced* variant (§17.4) |
| **States** | Loading · ⭐ **Feature disabled** → the entry point is **ABSENT** · Empty · Error · ⭐ Stale |
| **Permission-denied** | ⭐ Surface absent; ⛔ never an explanatory screen naming a policy |
| **Privacy** | ⭐⭐ **The most privacy-constrained surface in the document.** ⛔ **No holder identity, no membership state, no shift, no attendance state, no occupancy** for any seat but their own (`SEAT-FR-275`/`276`). ⭐ `SEAT-FR-276`'s reason: *"per-seat occupancy discloses another person's physical presence in real time"* |
| **Accessibility** | ⭐ ✓ / ─ are **labelled** *("can be booked" / "unavailable")*, ⛔ never shape or colour alone |
| **Psychology** | ⭐⭐ **Anti-scarcity by design.** ⛔ No *"only 2 left!"*, ⛔ no countdown, ⛔ no heat map. ⭐ `SEAT-XC-005` removed the waiting list precisely because fairness rules do not exist yet — the surface therefore ⛔ never implies competition |
| **Indian-market** | ⭐ Vertical zone list; ⭐ ⛔ no pan/zoom; ⭐ tenant label; ⭐ low data — assignability is a single flag per seat |
| **Depth** | ⭐ **2D** grid; ⭐ **2.5D** for the student's own seat chip only |
| **Cross-feature** | ⛔ **No presence data reaches this surface at all** — `SEAT-FR-276` |
| **Traceability** | `SEAT-FR-076`/`078`/`079` · **`SEAT-FR-275`/`276`** · `SEAT-FR-163` · `SEAT-CFG-008` |
| **GAP** | ⛔ `AIV-S08` *(student holds **no** seat permission in code)* |

---

### 11.26 `S2` — Book a Seat ⭐ *(three modes, one surface)*

| Attribute | Specification |
|---|---|
| **App / Roles** | ⭐ **APP 1** · `TR-4` Student |
| **Permission** | `SEAT-PO-005` — ⭐ *"Book a seat for **oneself**"*, `C` on `SEAT-CFG-008` |
| **Scope** | ⭐ `self` — `SEAT-FR-077`: *"the only scope a student holds for booking"* |
| **Purpose** | Create a booking whose outcome depends on `SEAT-CFG-010` |
| **Entry point** | `S1` → select a seat |

**Hierarchy** — ⭐⭐ **The outcome is stated BEFORE submission**, because one tap
produces three different results:

| `SEAT-CFG-010` | What the button says | What happens |
|---|---|---|
| `Direct` | **Book this seat** | ⭐ An `Active` allocation **immediately** |
| `HoldThenConfirm` | **Hold this seat** | ⭐ A `Reservation` first; converts per `SEAT-CFG-011` |
| ⭐ `ApprovalRequired` *(**default**)* | **Request this seat** | ⭐ A `Pending` request; **staff decide** |

```
┌─ Request seat A-02 ──────────────────────────────────┐
│  Hall A · Floor 1 · Normal                           │
│  From  [01 Sep 2026]   To  [30 Sep 2026]             │ ⭐ SEAT-FR-080 mandatory
│  ⓘ Cannot start in the past                          │ ⭐ SEAT-FR-082
│  ⓘ Cannot extend past your membership (30 Sep)       │ ⭐ SEAT-FR-081
│  ────────────────────────────────────────────────    │
│  This library reviews requests. A staff member will  │ ⭐⭐ outcome stated
│  decide. Requesting does not hold the seat.          │ ⭐ SEAT-FR-069
│                                       [Request]      │
└──────────────────────────────────────────────────────┘
```

| Attribute | Specification |
|---|---|
| **Primary actions** | Submit *(label varies by mode)* |
| **Secondary** | Back to `S1` |
| **Components** | `PanelCard` · date fields · `FilledButton` |
| **States** | Loading · ⭐ **Gate rejection** per §12.1 · ⭐ **Window exceeds membership** → reject **or** truncate per `SEAT-CFG-009` *(default **reject**)* · ⭐ **Past start rejected** · ⭐ **Beyond `reservationWindow`** rejected *(`SEAT-FR-083` — consumed from `BC-06`; ⛔ this module defines no window)* · ⭐ **Quota exceeded** *(names quota + count)* · ⭐ **Self-booking suspended** → see `S4` · Conflict *(case 2)* · Idempotent |
| **Permission-denied** | Surface absent |
| **Privacy** | ⭐ Own data only; ⛔ no other student referenced even in a conflict message |
| **Accessibility** | ⭐ Date fields labelled; ⭐ constraint hints are persistent text, ⛔ not tooltips |
| **Psychology** | ⭐⭐ **Booking confidence** is the whole design problem here. ⭐ `SEAT-FR-069` — *"A seat-change request **MUST NOT** create, move, reserve or hold any seat"* — so the surface says *"Requesting does not hold the seat"* **up front**. ⛔ Implying a hold and then not delivering one would be the dark pattern this avoids |
| **Indian-market** | ⭐ `ApprovalRequired` default means the honest message is the common one |
| **Depth** | ⭐ **2D** form |
| **Cross-feature** | **X-2** `G7` membership · **X-5** `reservationWindow` from `BC-06` |
| **Traceability** | `SEAT-PO-005` · `SEAT-FR-076`…`084` · `SEAT-FR-086`/`087` · `SEAT-CFG-008`/`009`/`010` |
| **GAP** | ⛔ `AIV-S08` |

---

### 11.27 `S3` — Raise Seat-Change Request

| Attribute | Specification |
|---|---|
| **App / Roles** | ⭐ **APP 1** · `TR-4` Student |
| **Permission** | `SEAT-PO-022` — ⭐ `Y (self)`, **unconditional** *(⛔ not gated by `SEAT-CFG-008`)* |
| **Scope** | ⭐ `self` |
| **Purpose** | ⭐ `SEAT-FR-068` — request a **desired seat**, a **desired category**, or **no preference**, with an optional reason |
| **Entry point** | `S4` → *Request a different seat* |
| **Hierarchy** | Three request shapes → optional reason → submit |
| **Primary actions** | Submit request |
| **Secondary** | — |
| **Components** | `PanelCard` · radio group *(seat / category / no preference)* · optional text |
| **States** | Loading · ⭐ **Max pending reached** — `SEAT-CFG-006` *(default **1**)*, ⭐ naming the existing request · ⭐ Submitted → `Pending`, expires after `SEAT-CFG-007` *(default **7 days**)* · Error · Idempotent |
| **Permission-denied** | ⛔ Not applicable — every student holds `SEAT-PO-022` |
| **Privacy** | ⭐⭐ *"Desired seat"* selection reuses `S1`'s reduced shape — ⛔ **a student must not learn who holds the seat they want** (`SEAT-FR-275`) |
| **Accessibility** | ⭐ *"No preference"* is a **first-class** option, ⛔ not an empty state |
| **Psychology** | ⭐⭐ **Autonomy without false promise.** ⭐ `SEAT-FR-069` is restated on the surface: a request holds nothing. ⭐ And *"no preference"* being offered means a student who simply wants *a different seat* need not research alternatives — reducing decision fatigue for the least-informed user |
| **Indian-market** | ⭐ Optional free-text reason permits local language |
| **Depth** | ⭐ **2D** |
| **Cross-feature** | → `L24` → `L8` |
| **Traceability** | `SEAT-PO-022` · `SEAT-FR-068`…`075` · `SEAT-CFG-006`/`007` |
| **GAP** | ⛔ `AIV-S08` |

---

### 11.28 `S4` — My Seat · Reservations · History · No-Show ⭐

| Attribute | Specification |
|---|---|
| **App / Roles** | ⭐ **APP 1** · `TR-4` Student |
| **Permission** | ⭐ `SEAT-FR-277` — the student's own read set; cancels under `SEAT-PO-023` |
| **Scope** | ⭐ `self` |
| **Purpose** | ⭐⭐ The **default** student seat surface — everything a student may see about their own seating |
| **Entry point** | Student app → Seat *(always present, ⛔ not gated by `SEAT-CFG-008`)* |

**Hierarchy** — ⭐ `SEAT-FR-277` fixes the content exactly: *"their current
allocation and its window, their own reservations, their own seat-change
requests and their outcomes, their own allocation and transfer history, and
their own no-show count."*

```
┌─ MY SEAT ────────────────────────────────────────────┐
│  A-14        Hall A · Floor 1 · Normal · Fixed       │ ⭐ own seat
│  Yours from 01 Sep 2026 to 30 Sep 2026               │ ⭐ window
│  Morning shift 06:00–10:00                           │
│                       [Request a different seat] → S3│
├──────────────────────────────────────────────────────┤
│  MY RESERVATIONS                                     │
│  B-03  held until 10:30      [Cancel]                │ ⭐ SEAT-FR-122
├──────────────────────────────────────────────────────┤
│  MY REQUESTS                                         │
│  → Premium · Pending · expires 23 Sep   [Cancel]     │ ⭐ SEAT-FR-073
│  → A-09    · Rejected · "seat reassigned"            │ ⭐ outcome shown
├──────────────────────────────────────────────────────┤
│  MY HISTORY                                          │
│  A-09 → A-14   transferred   12 Aug                  │ ⭐ SEAT-FR-277
│  A-09          allocated     01 Aug                  │
├──────────────────────────────────────────────────────┤
│  BOOKINGS NOT USED                          2 of 3   │ ⭐⭐ neutral framing
│  After 3, self-booking pauses for 7 days.            │ ⭐ threshold stated
│  ⓘ You can always be given a seat at the desk.       │ ⭐⭐ SEAT-FR-096
└──────────────────────────────────────────────────────┘
```

| Attribute | Specification |
|---|---|
| **Primary actions** | Cancel own reservation · Cancel own pending request · → `S3` |
| **Secondary** | → `S1` *(when `SEAT-CFG-008` enabled)* |
| **Components** | `PanelCard` ×5 · `SectionHeader` · `Pill` |
| **States** | Loading · ⭐ **No seat** — *"No reserved seat"*, ⛔ neutral, ⛔ **not** *"you have no seat!"* · Error · Stale · ⭐ **Self-booking suspended** — states the remaining duration **and** the desk fallback |
| **Permission-denied** | ⛔ Not applicable — always own-scope |
| **Privacy** | ⭐⭐ Own data only. ⛔ **No other student appears anywhere**, including in a rejection reason (`SEAT-FR-149`) |
| **Accessibility** | ⭐ Five labelled regions; ⭐ the no-show count is text with its threshold, ⛔ not a gauge |
| **Psychology** | ⭐⭐⭐ **The single most carefully framed element in this document is the no-show counter.** ⚠️ `PRD-007` has **no blame prohibition** *(unlike `PRD-006`, which states one twice)*, so the design supplies the framing: ⭐ labelled **"Bookings not used"**, ⛔ not *"No-shows"* or *"Missed"*; ⭐ shown as **2 of 3** with the threshold; ⭐ and the **desk fallback stated in the same block**, because `SEAT-FR-096` guarantees it. ⛔ **No streak, no score, no penalty language, no comparison to other students.** ⚠️ **DESIGN DECISION** on ⚠️ `DD4-HYP-004`, ⛔ not a requirement |
| **Indian-market** | ⭐⭐ The desk-fallback line is the most important sentence for a student with an unreliable phone or data connection |
| **Depth** | ⭐ **2.5D** own-seat card; ⭐ **2D** lists |
| **Cross-feature** | ⛔ **No presence axis on `S4`** — ⭐ presence is `BC-03`'s student surface (`DD-0003`), ⛔ and `SEAT-FR-276` bars per-seat occupancy here |
| **Traceability** | **`SEAT-FR-277`** · `SEAT-FR-230` · `SEAT-PO-023` · `SEAT-FR-073`/`122` · `SEAT-FR-096` · `SEAT-CFG-012`/`013` |
| **GAP** | ⛔ `AIV-S08` · ⚠️ `DD4-TBD-008` *(blame framing has no ratified source)* |

---

### 11.29 `P1` — Parent Read-Only Seat Mirror ⭐

| Attribute | Specification |
|---|---|
| **App / Roles** | ⭐ **APP 1** · `TR-5` Parent — ⭐⭐ **a role in the Student App, NOT a separate app** |
| **Permission** | ⭐ `SEAT-FR-274` — ⛔ *"**Parent/Guardian holds no operation** in the list above"* |
| **Scope** | ⭐ `guardianOf` |
| **Purpose** | Let a guardian see their student's seating |
| **Entry point** | Parent app → Seat |

**Hierarchy** — ⭐⭐ **Exactly `S4`'s content, bounded by requirement:**

> ⭐ *"A guardian **MAY** read the seat information of a student they are guardian
> of, under the `guardianOf` scope, **restricted to exactly what `SEAT-FR-277`
> permits the student to see about themselves**. Guardians **MUST NOT** book,
> request, release or cancel."*

| Attribute | Specification |
|---|---|
| **Primary actions** | ⛔⛔ **NONE.** Zero write actions by requirement |
| **Secondary** | Switch between guardianed students *(where more than one)* |
| **Components** | Same as `S4`, ⭐ with **every action control absent** |
| **States** | Loading · No seat *(neutral)* · Error · Stale · ⭐ Suspension **visible but not actionable** |
| **Permission-denied** | ⭐ Surface absent for a non-guardian; ⭐⭐ a `guardianOf` denial is **indistinguishable from not-found** (`SEAT-FR-281`) |
| **Privacy** | ⭐⭐ **Scope-bounded twice**: `guardianOf` limits *which* student, and `SEAT-FR-277` limits *what* about them. ⛔ No other student, no staff-only field, ⛔ no holder identity of any other seat |
| **Accessibility** | ⭐ Read-only regions announced as such; ⛔ no disabled buttons *(which would imply a withheld capability)* |
| **Psychology** | ⭐⭐ **Trust through symmetry.** The parent sees **exactly** what the student sees — ⛔ no more *(which would breach the student's privacy)* and ⛔ no less *(which would look like concealment)*. ⭐ `SEAT-FR-274`'s *"restricted to exactly what `SEAT-FR-277` permits"* makes that a requirement, not a courtesy |
| **Indian-market** | ⭐⭐ Guardian oversight is a real expectation in Indian study-library culture; ⭐ the read-only boundary respects it **without** transferring the student's autonomy — ⭐ consistent with `SEAT-FR-077`'s *"only for themselves"* |
| **Depth** | ⭐ **2.5D** / **2D**, identical to `S4` |
| **Cross-feature** | ⭐ `guardianOf` resolution is `BC-18`'s; ⛔ this module invents no relationship model |
| **Traceability** | **`SEAT-FR-274`** · `SEAT-FR-277` · `SEAT-FR-281`/`282` · `AUTH` §2.4 `TR-5` |
| **GAP** | ⚠️ `AIV-S08`-adjacent — ⭐ measured: `parent_dashboard.dart` contains **0** occurrences of "seat", so `P1` is **entirely unbuilt** |

---

### 11.30 ⭐ Coverage confirmation

| Group | IDs | Count |
|---|---|---|
| APP 2 counter & map | `L1`…`L20` | **20** |
| APP 2 owner-only | `L21`, `L22`, `L23` | **3** |
| APP 2 work queues | `L24` | **1** |
| APP 1 student | `S1`, `S2`, `S3`, `S4` | **4** |
| APP 1 parent | `P1` | **1** |
| ⛔ APP 3 | — | ⛔⛔ **0** |
| **TOTAL SPECIFIED** | | ⭐⭐ **29 of 29** |

⭐ Each carries: ID · name · app · roles · permission scope · tenant scope ·
purpose · entry point · hierarchy · primary actions · secondary actions ·
components · states · loading/empty/error/stale · permission-denied · privacy ·
accessibility · psychology · Indian-market · depth · cross-feature ·
traceability · GAP/TBD/CONFLICT.

---

## 12. Flow Specifications

⭐ **14 flows.** Each states: entry → preconditions → actor → steps → validation
→ success → failure → recovery → interruption recovery → permission handling →
feedback → audit.

### 12.1 `F1` — The Acquisition Gate ⭐⭐ *(the flow every other acquisition runs)*

⭐ `SEAT-FR-052`: **eight** acquisition paths evaluate **one** ordered gate and
*"**MUST** stop at the first failure."*

| Attribute | Specification |
|---|---|
| **Entry** | Any of: `L5` · `L7` · `L8` approve · `L9` approve · `L10` convert · `L17` · `L18` · `S2` |
| **Preconditions** | An authenticated actor in a resolved tenant |
| **Actor** | `TR-1`/`TR-2`/`TR-3` *(staff paths)* or `TR-4` *(student booking)* |
| **Audit** | ⭐ Every protected operation emits **exactly one** audit fact incl. outcome permitted/denied (`SEAT-FR-234`); ⭐ **denials are audited too** (`SEAT-FR-236`) |

**Steps, validation and the message set** — ⭐ `SEAT-NFR-010` requires each
failure to name the gate, the limit and the current value:

| Gate | Check | Surface message | Authority |
|---|---|---|---|
| `G1` | Tenant resolved | ⭐ Request rejected, ⛔ **no data disclosed** | `MP-GBR-06` |
| `G2` | Actor authorised | ⭐⭐ **Non-disclosing** — identical to `G5` | `MP-GBR-20`…`22` |
| `G3` | Idempotency | ⭐ *"Already applied"* — prior result replayed, ⛔ **not re-applied** | §21.3 |
| `G4` | Entitlement | *"This library's seat limit is reached"* | `E-17` |
| `G5` | Student exists | ⭐⭐ **Identical to `G2`** — *not found* | `MP-GBR-22` |
| `G6` | Enrollment permits | *"This student is suspended"* / *"archived"* | `SEAT-BR-013` |
| ⭐⭐ `G7` | **Membership validity** | ⭐ *"An active membership is required before a seat can be reserved"* — ⛔⛔ **no override control anywhere** | `MP-GBR-16`, `SEAT-BR-014`, `SEAT-XC-004` |
| `G8` | `seatQuota` | ⭐ *"Holds 2 of 2 allowed seats"* — **names quota and count** | `SEAT-BR-012` |
| `G9` | Seat exists | *"Seat not found"* | `SEAT-INV-006` |
| `G10` | Floor/zone active | *"Hall B is not currently in use"* | `SEAT-FR-019` |
| `G11` | Not in maintenance | ⭐ *"Under maintenance — end maintenance first"* *(`SEAT-BR-020` blocks **every** role incl. Owner)* | `SEAT-FR-043` |
| `G12` | Not locked | ⭐ *"Seat locked — <reason>"*; ⭐ **override offered inline only if authorised** (`L13`) | `SEAT-BR-018` |
| `G13` | Category eligibility | ⭐ *"Not eligible for Premium"* — ⛔ **must not disclose another student's plan** | `SEAT-FR-149` |
| `G14` | Shift compatibility | *"Shift conflict — Morning vs Evening"* | §16 of `PRD-007` |
| `G15` | No conflicting reservation | *"Reserved by another student until 10:30"* | `SEAT-BR-011` |
| `G16` | No conflicting allocation | ⭐ *"Already allocated"* — acquired **under a pessimistic lock** | `SEAT-INV-001` |

| Attribute | Specification |
|---|---|
| **Success** | Allocation *(or reservation)* created; origin recorded from the closed 8-value set (`SEAT-FR-050`) |
| **Failure** | ⭐ Stops at the **first** gate; ⛔ `SEAT-FR-054` — *"A gate failure **MUST NOT** partially mutate state"* |
| **Recovery** | ⭐ Per-gate: `G7`→ deep-link to membership *(permitted, §34.5 row 7)*; `G11`→ `L14`; `G12`→ `L13`/`L12`; `G16`→ **Refresh & retry** |
| **Interruption recovery** | ⭐ Idempotency key makes re-submission safe; `G3` replays the original result |
| **Permission handling** | ⭐⭐ `G2` runs **before** the gate continues, so *"an unauthorised caller learns nothing about seat availability from the shape of the failure"* (`SEAT-FR-271`) |
| **Feedback** | ⭐ `SEAT-FR-053` — gate failures are **distinguishable**, except `G2`/`G5` which **collapse to one** outcome |

⛔⛔ **Design prohibition carried from `SEAT-XC-003`:** ⛔ *"An acquisition path
that skips or reorders these gates **MUST NOT** exist."* ⭐ So no surface in §11
offers a shortcut, a "quick assign", or a bypass.

### 12.2 `F2` — Staff Assignment

Entry `L2`→Assign · Precondition seat `Available` · Actor `TR-1`/`TR-2`/`TR-3`.
⭐ Steps: **explicit student selection** (`SEAT-FR-056`) → window → run `F1` →
record origin `StaffAssigned` + actor + timestamp (`SEAT-FR-057`).
Success → `L1` refreshes; feedback names seat and student.
Failure → per-gate message. Conflict *(case 1)* → **Refresh & retry**.
⭐ Interruption → safe re-submit. Audit → one fact, `SEAT-PO-001`.

### 12.3 `F3` — Reassign an Occupied Seat ⭐⭐ *(two steps by requirement)*

⛔⛔ `SEAT-BR-016`: *"Reassigning an occupied seat to a different student
**MUST** require two explicit steps: release (or transfer) the existing
allocation, then assign. **A single-step overwrite MUST NOT exist**, because it
would destroy an allocation without an actor's explicit acknowledgement."*

| Attribute | Specification |
|---|---|
| **Steps** | ⭐ **1.** `L6` Release *(with reason)* **or** `L7` Transfer → **2.** `L5` Assign — ⛔ **two separate confirmations** |
| **Validation** | `SEAT-FR-058` — an assign attempt on an occupied seat is **rejected with the gate reason**; ⛔ *"**MUST NOT** silently overwrite"* |
| **Failure** | ⭐ If step 1 succeeds and step 2 fails, the seat is `Available` and the outcome is **stated plainly** — ⛔ the design must not imply the original holder still has it |
| **Recovery** | ⭐ Step 2 is retryable; ⭐ the released allocation remains in history (`SEAT-FR-061`) |
| **Interruption** | ⭐⭐ **The riskiest interruption in the document.** ⭐ Because step 1 is atomic and audited, an interruption between steps leaves a **clean, explainable** state: seat free, release reason recorded |
| **Feedback** | ⭐ After step 1: *"A-14 released — now available"*; ⛔ **not** *"ready to reassign"*, which would imply a hold |
| **Audit** | Two facts: `SEAT-PO-002` then `SEAT-PO-001` |

### 12.4 `F4` — Release

Entry `L2`→Release · Precondition active allocation · Actor `TR-1`/`TR-2`/`TR-3`.
⭐ Steps: **mandatory reason** from `SEAT-CFG-004` or free text → confirm.
⭐ Validation: allocation must be `Active` — releasing twice is a **conflict**, ⛔ not a silent success.
⭐ Success → status `Released`, ⛔ **never deleted** (`SEAT-FR-061`); emits `SEAT-EVT-002`. Audit `SEAT-PO-002`.
⭐ Recovery: ⛔ **none — release is not undoable**; the design therefore offers *Transfer instead* **before** the confirm (§11.6).

### 12.5 `F5` — Transfer

Entry `L2`→Transfer, `L8` approve, `L14` Relocate, `L17` · Actor `TR-1`/`TR-2`/`TR-3`.
⭐ Steps: destination → **run `F1` in full against the destination** (`SEAT-FR-064`) → **then** release the source.
⭐⭐ Validation: `SEAT-FR-063` — atomic in effect; ⛔ *"A state in which the student holds **both, or neither**, **MUST NOT** be observable."*
⭐ Limit: `maxTransfersPerDay` from `BC-06`; ⭐ `SEAT-FR-067` — **system**-initiated moves *(maintenance relocation, bulk reassign)* ⛔ **do not count**.
⭐ Success → exactly **one** transfer-history row (`SEAT-FR-065`); emits `SEAT-EVT-003`.
Failure → destination gate reason; ⭐ **source untouched**.
⭐ Interruption → the atomicity requirement means there is no partial state to recover from.

### 12.6 `F6` — Student Booking ⭐ *(three outcomes)*

Entry `S1`→`S2` · ⭐ Precondition `SEAT-CFG-008` **enabled** *(default disabled)* · Actor `TR-4`, scope `self`.

| Step | Detail |
|---|---|
| 1 | ⭐ Window **mandatory** (`SEAT-FR-080`) — ⛔ *"A booking with no date **MUST NOT** exist"* |
| 2 | ⭐ Not in the past (`SEAT-FR-082`); ⭐ not beyond `reservationWindow` from `BC-06` (`SEAT-FR-083`) |
| 3 | ⭐ Not beyond membership `validUntil` — **reject** *(default)* or **truncate** per `SEAT-CFG-009` |
| 4 | ⭐ Run `F1`; ⭐⭐ `SEAT-FR-198` locks the **student's allocation set**, not just the seat |
| 5 | ⭐ Outcome per `SEAT-CFG-010` — allocation · reservation · pending request |

⭐ Success: the surface states **which** outcome occurred, using the same wording it promised pre-submission.
Failure: gate message; ⭐ **self-booking suspended** → `S4` with the desk fallback.
⭐ Interruption: idempotent; ⛔ **no double booking** (`SEAT-FR-203`).
⭐ Feedback: ⛔ **never** *"confirmed"* for a reservation (`SEAT-FR-042`).

### 12.7 `F7` — Reservation Conversion ⭐ *(three triggers)*

⭐ `SEAT-FR-088` — converts on the **first** trigger to occur:

| # | Trigger | Driver |
|---|---|---|
| `T1` | `startsAt` reached **and** mode `OnStart` | Time |
| ⭐ `T2` | Holder checked in by `BC-03` **and** mode `OnCheckIn` *(**default**)* | ⭐ **`E-08`** — cross-feature |
| `T3` | Staff confirm via `L10` | ⭐ *"Always available in every mode"* |

⭐⭐ Validation: `SEAT-FR-091` re-evaluates `G6`, `G7`, `G8`, `G11`, `G12` **at
conversion** — *"`MP-GBR-16` is evaluated at the moment of seating, not at the
moment of holding."*
⭐ Idempotent: `SEAT-FR-090` — a second trigger returns the existing allocation, ⛔ never a second one.
⭐ Failure: the reservation stays; `S4` shows the reason **without blame** (§7.4).
⭐ Audit: `SEAT-PO-006` for `T3`.

### 12.8 `F8` — Expiry + No-Show Suspension

⭐ Steps: `expiresAt` reached without conversion → `Expired` → F4 clears → ⭐ seat presents `Available` **derived at read time** (`SEAT-FR-095`), ⛔ **not** dependent on a sweeper.
⭐ Timeline gets an entry with origin `ReservationExpired`.
⭐⭐ `SEAT-FR-094`: ⛔ expiry *"**MUST NOT** create an allocation, **MUST NOT** charge anything… and **MUST NOT** penalise the student beyond the no-show counter."*
⭐ After `SEAT-CFG-012` *(3)* consecutive expiries → self-booking suspended for `SEAT-CFG-013` *(7 days)*.
⭐⭐ **Recovery is guaranteed**: `SEAT-FR-096` — *"Staff assignment remains available throughout — a no-show student is **never denied a seat at the desk**."*
⛔ **No design element implies a countdown, a penalty or a warning streak** (§7.1).

### 12.9 `F9` — Seat-Change Request Lifecycle

Entry `S3` · Actor `TR-4` raise, `TR-1`/`TR-2`/`TR-3` decide.
⭐ States, closed set (`SEAT-FR-070`): `Pending` · `Approved` · `Rejected` · `Cancelled` · `Expired`.
⭐ `SEAT-FR-069` — ⛔ the request *"**MUST NOT** create, move, reserve or hold any seat. It is a request record only."*
⭐ Max `SEAT-CFG-006` *(1)* pending; expires after `SEAT-CFG-007` *(7 days)*.
⭐⭐ Approval runs `F1` **at approval time**; on failure the request ⭐ **stays `Pending`** (`SEAT-FR-072`) — ⛔ **not** rejected.
⭐ The student may cancel their own pending request (`SEAT-FR-073`).

### 12.10 `F10` — Maintenance Workflow

⭐ Two-stage by requirement: **Report** *(`TR-3` permitted; `SEAT-FR-166` — ⛔ does **not** change seat state)* → **Decide** *(`TR-1`/`TR-2` only)*.
⭐⭐ On an occupied seat: the **3-disposition** step (`SEAT-FR-167`) — Retain *(default)* / Relocate / Release.
⭐ Relocate failure → ⛔ **maintenance does not start**.
⭐ Unexpired reservation → `SEAT-BR-027` cancels it **explicitly** with a notification fact.
⭐ On end: `SEAT-BR-026` reinstates a surviving allocation as the visible state.
⭐ Recovery: an open maintenance record is always endable from `L14`.

### 12.11 `F11` — Lock / Unlock / Override

⭐ Lock *(`TR-1`/`TR-2`)* requires a **reason** (`SEAT-FR-159`).
⭐⭐ Effect is narrow: `SEAT-BR-025` — suppresses **new acquisition only**.
⭐⭐ `SEAT-FR-160`/`161` — ⛔ does **not** release, alter or shorten an allocation, and ⛔ does **not** prevent release or transfer-**out**.
⭐ Visibility asymmetry: `SEAT-FR-163` — staff see the reason; ⛔ students see *unavailable* **without** it.
⭐ Override *(`L13`)* is **per single assignment**, recorded with actor and reason.

### 12.12 `F12` — Bulk Import

⭐ Validate **in full before any row applies** (`SEAT-FR-172`): zone existence · number uniqueness · category · type · entitlement row count.
⭐⭐ `SEAT-BR-028` — **all-or-nothing** + a **per-row error report**.
⭐ Bound **2,000** rows, rejected **before** validation begins (`SEAT-FR-179`).
⭐ Idempotent by import key — re-submission returns the original result (`SEAT-FR-173`).
⛔ `SEAT-FR-174` — ⛔ **must not** create, rename or delete a floor or zone.
⭐ Audit: one operation-level fact with row count (`SEAT-FR-178`).

### 12.13 `F13` — Auto-Assignment

⭐ Staff-invoked only — ⛔ `SEAT-FR-185`: *"**MUST NOT** run unattended on a schedule in V1."*
⭐ Candidate set = *"exactly the seats for which **every** §8 gate passes"* (`SEAT-FR-181`) — ⛔ *"**MUST NOT** bypass a single gate."*
⭐ Four ordered criteria (`SEAT-FR-182`), surfaced on `L18`.
⭐⭐ No candidate → fails naming *"the most restrictive gate that eliminated the last candidate"*; ⛔ **must not** return an unusable seat and ⛔ **must not** create a consolation reservation.
⭐ Records origin `AutoAssigned` **and the criteria** (`SEAT-FR-184`).

### 12.14 `F14` — QR-Initiated Assignment

| Step | Detail |
|---|---|
| 1 | ⭐ Scan a seat QR encoding **seat internal id + `tenantId` only** (`SEAT-FR-187`) — ⛔ no student id, name, session token or credential |
| 2 | ⭐⭐ **If unauthenticated → an authentication prompt, never an assignment** (`SEAT-BR-030`: *"A QR scan **MUST NOT** authenticate anybody"*) |
| 3 | ⭐ Actor context selects the path: ⭐ **student** → treated as a booking `F6`, subject to `SEAT-CFG-008` and `SEAT-CFG-010` (`SEAT-FR-189`); ⭐ **staff** → **explicit student selection required** (`SEAT-FR-190`) |
| 4 | ⭐ Run `F1` **in full** — ⛔ *"**MUST NOT** assign a seat on the strength of the scan alone"* (`SEAT-FR-188`) |

⛔⛔ **`SEAT-XC-012` — the seat QR MUST NOT record attendance.** ⭐ `PRD-007`'s own
warning: *"A single 'scan the seat QR' button that both seated **and** marked
attendance would put attendance recording inside `BC-04`."* ⭐ A tenant **may**
print both codes on one label; ⛔ **the flows stay separate** — and this document
designs ⛔ **no combined scan surface**.
⭐ Regeneration invalidates the previous code (`SEAT-FR-191`).

### 12.15 ⭐ Flow coverage

| Flow | Covered | Flow | Covered |
|---|---|---|---|
| `F1` Acquisition gate | ⭐ §12.1 | `F8` Expiry + no-show | ⭐ §12.8 |
| `F2` Staff assignment | ⭐ §12.2 | `F9` Seat-change request | ⭐ §12.9 |
| `F3` Reassign occupied | ⭐ §12.3 | `F10` Maintenance | ⭐ §12.10 |
| `F4` Release | ⭐ §12.4 | `F11` Lock/unlock/override | ⭐ §12.11 |
| `F5` Transfer | ⭐ §12.5 | `F12` Bulk import | ⭐ §12.12 |
| `F6` Student booking | ⭐ §12.6 | `F13` Auto-assignment | ⭐ §12.13 |
| `F7` Reservation conversion | ⭐ §12.7 | `F14` QR-initiated | ⭐ §12.14 |

⭐⭐ **14 of 14 covered.**

---

## 13. State Model

⭐ **6 axes, 21 states.** ⛔ No axis merged; ⛔ no state renamed.

### 13.1 ⭐⭐ Axis A — Derived `SeatState` (4)

⭐ `SEAT-FR-037` — a **total function** over five independent facts, evaluated in
order, **first match wins**:

| Order | Condition | State | Chip |
|---|---|---|---|
| 1 | F2 maintenance active | **`Maintenance`** | 🔧 *Maintenance* |
| 2 | F5 active allocation | ⭐ **`Occupied`** | 🟦 *Occupied* |
| 3 | F4 unexpired reservation | **`Reserved`** | 🟨 *Reserved* |
| 4 | otherwise | **`Available`** | 🟩 *Available* |

| Rule | Design consequence |
|---|---|
| ⭐⭐ `SEAT-BR-010` — ⛔ *"`SeatState` **MUST NOT** be stored as an independently mutable value"*; *"A build in which `SeatState` can disagree with F1…F5 is **defective**"* | ⭐⭐ **No surface offers a "set status" control. ⛔ There is no state picker anywhere in §11** |
| ⭐ `SEAT-XC-001` — ⛔ never two states at once, *"structurally guaranteed"* | ⭐ One chip per seat, always |
| ⭐ `SEAT-FR-041` — *"`Occupied` means **allocated**, not physically present"* | ⭐⭐ `L2` Tier 2 vs Tier 3 (§11.2) |
| ⭐ `SEAT-FR-043` — `Maintenance` blocks new allocation *"by anyone, **including Owner**"* | ⭐ `G11` has ⛔ **no override control** |

### 13.2 ⭐⭐ Axis B — Lock (2) — ⛔ NOT a `SeatState`

⭐⭐ `SEAT-FR-038`: **"`Locked` is NOT a `SeatState` value."** F3 is *"an
orthogonal flag that suppresses acquisition while leaving the derived state
unchanged. A locked available seat presents as `Available (locked)`; a locked
occupied seat presents as `Occupied (locked)`."*

| State | Rendering |
|---|---|
| `unlocked` | ⭐ nothing rendered |
| `locked` | ⭐⭐ **A 🔒 badge composed OVER the Axis-A chip** — ⛔ never a fifth chip colour, ⛔ never replacing the state |

⭐ `SEAT-FR-039`: ⛔ *"A lock **MUST NOT** be invisible."* ⭐ The badge is therefore
mandatory on **every** surface showing a seat — `L1`, `L2`, `L19`, `L20` — and on
`S1` it renders as plain *unavailable* **without** the reason (`SEAT-FR-163`).

⚠️ **Why `PRD-007` rejected `Locked` as a state, preserved here because it
explains the design:** *"a locked occupied seat would have to be both `Locked`
and `Occupied`, contradicting 'exactly one current operational status'."*

### 13.3 Axis C — Allocation status (4)

`Active` · `Released` · `Transferred` · `Expired` — ⭐ append-only; ⛔ `SEAT-XC-014`
forbids edit or delete **for every role including Owner**.

### 13.4 Axis D — Request state (5) — closed

⭐ `SEAT-FR-070`: `Pending` · `Approved` · `Rejected` · `Cancelled` · `Expired`.
⭐ Rendered on `S4`, `P1`, `L8`, `L24`. ⭐ `Rejected` **always carries its reason**
(`SEAT-FR-071`).

### 13.5 Axis E — Maintenance (2)

⭐ `SEAT-FR-166`: `Reported` *(⛔ **does not** change the seat's derived state)* ·
`Started` *(sets F2)*.
⭐⭐ The design consequence is the whole of §11.15: *"a report is not a decision."*

### 13.6 ⭐⭐ Axis F — Presence (4) — a SEPARATE axis

⭐ Amended into `SEAT-FR-103` by `ADR-0032` option `O-5`:

| State | Label | Availability |
|---|---|---|
| 🟢 `PRESENT` | *Present* + *"since HH:MM"* | ⭐ **DESIGNABLE** |
| 🔵 `ATTENDED · LEFT` | *Attended · left* | ⛔⛔ **BLOCKED** — `SEAT-BLOCK-001` |
| 🟠 `PRESENCE UNVERIFIED` | *Presence unverified* — ⭐ incl. **every** manual attendance | ⭐ **DESIGNABLE** |
| ⚪ `NOT ATTENDED` | *Not attended* | ⭐ **DESIGNABLE** |

⛔⛔ **Two merges are PROHIBITED, not merely discouraged:**

| Prohibited merge | Authority |
|---|---|
| ⛔⛔ ⚪ `NOT ATTENDED` merged with 🟠 `PRESENCE UNVERIFIED` | ⭐ `SEAT-FR-103`: *"This is a **different fact** from `PRESENCE UNVERIFIED` and **MUST NOT** be merged with it"* |
| ⛔⛔ Presence merged with shift-conformance | ⭐ `SEAT-FR-103`: *"presence and shift-conformance are two facts, and **one field cannot carry two facts**"* |

### 13.7 ⭐ Shift conformance — the second axis of the pair

| Rendering | Rule |
|---|---|
| *(no badge)* | Within the booked window |
| ⚠ **Overstay** | ⭐⭐ Renders **alongside** 🟢 `PRESENT` — the badge ⛔ *"**MUST NOT** replace, recolour or suppress the presence indicator, and presence **MUST NOT** be downgraded because of overstay"* |

⚠️ **Note on axis counting, disclosed rather than silently renumbered.** ⭐ This
document presents shift-conformance as a **distinct rendering axis** on `L2`,
while ⭐ **counting it inside `SEAT-FR-103`'s presence field** for the totals
below — because that is how the accepted audit counted it *(21 states across 6
axes)*. ⭐ **No state is added or removed**; only the presentation grouping is
finer.

### 13.8 ⭐ State totals

| Axis | States | Count |
|---|---|---|
| A · Derived `SeatState` | `Maintenance`·`Occupied`·`Reserved`·`Available` | **4** |
| B · Lock | `locked`·`unlocked` | **2** |
| C · Allocation | `Active`·`Released`·`Transferred`·`Expired` | **4** |
| D · Request | `Pending`·`Approved`·`Rejected`·`Cancelled`·`Expired` | **5** |
| E · Maintenance | `Reported`·`Started` | **2** |
| F · Presence | 🟢·🔵·🟠·⚪ | **4** |
| **TOTAL** | | ⭐⭐ **21 across 6 axes** |

### 13.9 ⭐ Transition rendering

⭐ `SEAT-FR-044` fixes the **complete** set of valid derived-state transitions and
`SEAT-FR-045` the invalid ones, each with a **distinguishable rejection reason**.
⭐ The design renders each rejection using `SEAT-FR-045`'s own wording:

| Invalid transition | Surface message |
|---|---|
| `Occupied` → `Reserved` | *"A seat with an active allocation cannot be reserved for another student"* |
| `Occupied` → `Occupied` *(different student)* | ⭐ *"Requires explicit release or transfer"* — ⛔ **never an implicit overwrite** |
| `Reserved` → `Reserved` *(different student)* | *"A seat holds at most one active reservation"* |
| `Maintenance` → `Occupied` via a **new** allocation | ⭐ *"Maintenance blocks new allocation for every role"* |
| `Maintenance` → `Reserved` | *"Maintenance blocks reservation for every role"* |
| Acquisition on a locked seat | *"Lock suppresses acquisition"* |
| Acquisition in an inactive container | *"Container inactive"* |

---

## 14. Permission UX

### 14.1 ⭐ The model is consumed, never invented

⭐ `SEAT-FR-268` consumes `MP-GBR-20`…`23` and `PRD-001` v2.0.
⛔ `SEAT-FR-269` — ⛔ **no scope may be added**; the register is closed at `self`,
`guardianOf`, `tenantWide`.
⛔ `SEAT-FR-270` — ⛔ this module **must not** create, invite, elevate or revoke a
role.

### 14.2 ⭐⭐ Role × Surface matrix — derived strictly from `PRD-007` §28.2

⭐ **Y** permitted · **—** denied · **C** conditional on the named configurable ·
**G** requires an explicit grant the role alone does not imply

| Surface | `SEAT-PO` | `TR-1` | `TR-2` | `TR-3` | `TR-4` | `TR-5` | `PR-1`/`PR-2` |
|---|---|---|---|---|---|---|---|
| `L1` map | `024` | Y | Y | Y | — | — | ⛔ **—** |
| `L2` card | `024` | Y | Y | Y | — | — | ⛔ **—** |
| `L3` layout | `016` | Y | **G** | — | — | — | ⛔ **—** |
| `L4` seat structure | `018` | Y | **G** | — | — | — | ⛔ **—** |
| `L5` assign | `001` | Y | Y | Y | — | — | ⛔ **—** |
| `L6` release | `002` | Y | Y | Y | — | — | ⛔ **—** |
| `L7` transfer | `003` | Y | Y | Y | — | — | ⛔ **—** |
| `L8` decide request | `004` | Y | Y | Y | — | — | ⛔ **—** |
| `L9` decide reservation | `008` | Y | Y | Y | — | — | ⛔ **—** |
| `L10` confirm reservation | `006` | Y | Y | Y | — | — | ⛔ **—** |
| `L11` cancel other's reservation | `007` | Y | Y | **C** `CFG-014` | — | — | ⛔ **—** |
| `L12` lock / unlock | `009` | Y | Y | ⛔ **—** | — | — | ⛔ **—** |
| `L13` lock override | `010` | Y | **C** `CFG-005` | ⛔ **—** | — | — | ⛔ **—** |
| `L14` maintenance | `011` | Y | Y | ⛔ **—** | — | — | ⛔ **—** |
| `L15` report maintenance | `012` | Y | Y | ⭐ **Y** | — | — | ⛔ **—** |
| `L16` bulk import / export | `013`/`014` | Y | Y | ⛔ **—** | — | — | ⛔ **—** |
| `L17` bulk reassign | `015` | Y | Y | ⛔ **—** | — | — | ⛔ **—** |
| `L18` auto-assign | `017` | Y | Y | Y | — | — | ⛔ **—** |
| `L19` search / presets | *(read model)* | Y | Y | Y | — | — | ⛔ **—** |
| `L20` timeline | `024` | Y | Y | Y | — | — | ⛔ **—** |
| `L21` categories | `019` | ⭐ **Y** | ⛔ **—** | ⛔ **—** | — | — | ⛔ **—** |
| `L22` eligibility | `020` | ⭐ **Y** | ⛔ **—** | ⛔ **—** | — | — | ⛔ **—** |
| `L23` configuration | `021` | ⭐ **Y** | ⛔ **—** | ⛔ **—** | — | — | ⛔ **—** |
| `L24` work queues | *(read model)* | Y | Y | Y | — | — | ⛔ **—** |
| `S1` availability | — | — | — | — | **C** `CFG-008` | — | ⛔ **—** |
| `S2` book | `005` | — | — | — | **C** `CFG-008` | ⛔ **—** | ⛔ **—** |
| `S3` raise request | `022` | — | — | — | ⭐ **Y** `self` | ⛔ **—** | ⛔ **—** |
| `S4` my seat | `023` + `FR-277` | — | — | — | ⭐ **Y** `self` | — | ⛔ **—** |
| `P1` parent mirror | `FR-274` | — | — | — | — | ⭐ **read only** `guardianOf` | ⛔ **—** |

⭐⭐ **The `PR-1`/`PR-2` column is dashes throughout** — that is `SEAT-FR-273`
rendered as design, ⛔ not an omission.

⚠️ **One honest note on `L5`/`L6`/`L7`'s Owner column.** ⭐ §28.2 grants Owner
every counter operation, so **Y** is correct — ⛔ but `SEAT-BR-040` reminds the
design that *"No role, **including Owner**"* may override `G7`, create a second
allocation on one seat in one window, edit history, or act outside its tenant.
⭐ Those four are **capability ceilings**, not permission rows.

### 14.3 ⭐ The three tiers, and why the design must respect them

| Tier | Rule | Design consequence |
|---|---|---|
| ⭐ **Reception = counter only** | `SEAT-BR-038` — 9 operations; ⛔ *"**MUST NOT** hold any **structural** operation"* | ⭐ `L3`, `L4`, `L12`, `L13`, `L14`, `L16`, `L17`, `L21`, `L22`, `L23` are **absent** from Reception's navigation |
| ⭐ **Manager = intermediate** | `SEAT-BR-039` — locking, maintenance, bulk; ⛔ **not** tenant-shaping; ⭐ layout + seat structure **only under a G grant** | ⭐ `L3`/`L4` entry points are **conditional**; `L21`/`L22`/`L23` **absent** |
| ⭐ **Owner = tenant-shaping** | Categories, eligibility, configuration | ⭐ `L21`/`L22`/`L23` are Owner-only screens |

⛔⛔ **README §2B.4 rule 6 discharged:** the design does ⛔ **not** *"render one
screen and grey controls out by role as an afterthought."* ⭐ The three roles get
**different navigable surface sets**, computed from §28.2.

### 14.4 ⭐⭐ Absent vs disabled — the decision rule

| Situation | Treatment | Authority |
|---|---|---|
| ⭐ Role never holds the operation | ⭐⭐ **ABSENT** — no entry point, no menu item | `SEAT-FR-107` |
| ⭐ Role holds it conditionally and the condition is unmet *(`C` / `G`)* | ⭐⭐ **ABSENT** | ⭐ `SEAT-FR-107` — ⛔ a disabled control *"with an explanatory reason"* risks disclosure |
| ⭐ Feature disabled tenant-wide *(`SEAT-CFG-008`)* | ⭐ **ABSENT** | `SEAT-FR-076` |
| ⭐ Actor holds it but a **gate** blocks this instance | ⭐ **PRESENT, with the gate reason** | `SEAT-NFR-010` |

⭐⭐ **The distinction matters:** a *permission* absence must not be explained *(it
could disclose policy or another student's data)*; a *gate* failure **must** be
explained *(`SEAT-NFR-010` requires it)*.

### 14.5 ⭐⭐ Non-disclosing denial

| Rule | Design |
|---|---|
| ⭐ `SEAT-FR-281` — a `self`/`guardianOf` denial is **indistinguishable from not-found** | ⭐ `S1`/`S4`/`P1` return the same *not found* shape for an unauthorised target and a non-existent one |
| ⭐⭐ `SEAT-FR-282` — ⛔ must not disclose through *"message text, status code, **response time**, or the presence or absence of a field"* | ⭐⭐ ⛔ **No optimistic skeleton** that reveals a record exists before authorisation resolves |
| ⭐ `SEAT-FR-283` | ⭐ The denial **is** audited; ⛔ non-disclosure applies to the caller, **never to the audit trail** |
| ⭐⭐ `SEAT-FR-254` | ⭐ Filtered-out rows are **ABSENT, not redacted**, and counts reflect **only** the permitted set |

### 14.6 ⭐⭐ `G7` — the gate no UI may soften

⛔⛔ `SEAT-BR-014`: *"G7 is **absolute and applies to every role, including
Owner**… This module **MUST NOT** provide an override, a bypass, a force-assign
or an 'assign anyway' affordance."*
⛔ `SEAT-XC-004`: such a capability *"**MUST NOT** exist in any role, **any
screen**, any bulk operation or any import."*

⭐⭐ **Design consequence, stated absolutely:** ⛔ **No surface in §11 contains an
override for `G7`.**
⭐ `L13` overrides a **lock** (`G12`), which `SEAT-XC-006` expressly permits —
⭐ and the design keeps the two cases **visually and verbally distinct** so an
operator cannot mistake one for the other.

---

## 15. Privacy

### 15.1 ⭐⭐ Data visibility matrix

⛔⛔ **Never assume that because staff can see something, a student or parent
can.**

| Data | `TR-4` Student | `TR-5` Parent | `TR-3` Reception | `TR-2` Manager | `TR-1` Owner | `PR-1`/`PR-2` | Authority |
|---|---|---|---|---|---|---|---|
| Own seat number + window | ⭐ **YES** | ⭐ YES *(guardianOf)* | YES | YES | YES | ⛔ **NO** | `SEAT-FR-277`/`274` |
| Own reservations | ⭐ YES | ⭐ YES | YES | YES | YES | ⛔ NO | `SEAT-FR-277` |
| Own requests + outcomes | ⭐ YES | ⭐ YES | YES | YES | YES | ⛔ NO | `SEAT-FR-277` |
| Own allocation / transfer history | ⭐ YES | ⭐ YES | YES | YES | YES | ⛔ NO | `SEAT-FR-277` |
| Own no-show count | ⭐ YES | ⭐ YES | YES | YES | YES | ⛔ NO | `SEAT-FR-277` |
| ⛔⛔ **Another student's identity on any seat** | ⛔⛔ **NO** | ⛔⛔ **NO** | ⭐ YES | YES | YES | ⛔ NO | ⭐⭐ `SEAT-FR-275` |
| ⛔⛔ **Another student's per-seat occupancy** | ⛔⛔ **NO** | ⛔⛔ **NO** | ⭐ YES | YES | YES | ⛔ NO | ⭐⭐ `SEAT-FR-276` |
| Another student's membership state / shift | ⛔ NO | ⛔ NO | ⭐ YES | YES | YES | ⛔ NO | `SEAT-FR-275` |
| Seat assignability *(own view)* | ⭐ YES | ⭐ YES | YES | YES | YES | ⛔ NO | `SEAT-FR-275` |
| Seat category | ⭐ YES | ⭐ YES | YES | YES | YES | ⛔ NO | `SEAT-FR-275` |
| ⭐ Lock **reason** | ⛔⛔ **NO** | ⛔ NO | ⭐ YES | YES | YES | ⛔ NO | ⭐⭐ `SEAT-FR-163` |
| Maintenance reason | ⛔ NO | ⛔ NO | ⭐ YES | YES | YES | ⛔ NO | `SEAT-FR-169` |
| Aggregate counts | ⚠️ **tenant-enabled** | ⚠️ tenant-enabled | YES | YES | YES | ⛔ NO | `SEAT-FR-276` |
| Operational metrics *(11)* | ⛔ NO | ⛔ NO | ⭐ YES | YES | YES | ⛔ NO | `SEAT-PO-024` |
| Work queues | ⛔ NO | ⛔ NO | ⭐ YES | YES | YES | ⛔ NO | `SEAT-FR-216` |
| Bulk export | ⛔⛔ NO | ⛔⛔ NO | ⛔⛔ **NO** | YES | YES | ⛔ NO | ⭐ `SEAT-FR-286` |
| ⛔⛔ **Any monetary value** | ⛔⛔ NO | ⛔⛔ NO | ⛔⛔ NO | ⛔⛔ NO | ⛔⛔ **NO** | ⛔ NO | ⭐⭐ `SEAT-FR-279` |
| ⛔ `PersonId` / photo / contact / DOB / guardian detail | ⛔ NO | ⛔ NO | ⛔ NO | ⛔ NO | ⛔ **NO** | ⛔ NO | ⭐ `SEAT-FR-278` |
| ⛔⛔ **Public live occupancy** | ⛔ NO | ⛔ NO | ⛔ NO | ⛔ NO | ⛔ NO | ⛔ NO | ⭐ `SEAT-XC-020` — **V2** |

⭐⭐ **Two rows constrain every role including Owner** — ⛔ **no monetary value**
(`SEAT-FR-279`) and ⛔ **no stored personal attribute** (`SEAT-FR-278`). ⭐ Those
are not permission questions; they are things the module **does not hold**.

### 15.2 ⭐⭐ Why `S1` is a separate surface, not a filtered `L1`

⭐⭐ `SEAT-FR-275` enumerates **four** fields a student may see per seat: *seat
number · derived assignability · category · whether it is their own*.
⭐ `L1` carries substantially more. ⛔⛔ **Building `S1` as `L1` with conditional
hiding would put prohibited data one rendering bug away from disclosure.**
⚠️ **DESIGN DECISION** — §6 row 10.

### 15.3 ⭐ Export privacy

⭐ `SEAT-FR-284` — confined to the caller's tenant; students identified by
`StudentRecordId` **and admission number only**; ⛔ **no name, contact, monetary
value, or membership field beyond validity state and `validUntil`**.
⭐ `SEAT-FR-285` — **every** export audited with **filter criteria and row
count**, *"because an export is the highest-volume disclosure the module
permits."*
⛔ `SEAT-FR-286` — ⛔ **unavailable to Reception, students and guardians in any
form.**

### 15.4 ⭐ Privacy properties that are structural, not configurable

| Property | Authority |
|---|---|
| ⭐ The module holds ⛔ **no** student personal attribute — only `StudentRecordId` | `SEAT-FR-278`, `SEAT-FR-010` |
| ⭐ Names are **composed at read time**, ⛔ never stored or indexed | `SEAT-FR-253` |
| ⭐ Realtime payloads carry **only** derived state, lock flag, occupancy flag | `SEAT-FR-195` |
| ⭐ Audit facts carry ⛔ **no** name, contact, `PersonId`, membership or financial value | `SEAT-FR-235` |
| ⭐⭐ ⛔ **No configurable may weaken any of the above** | `SEAT-FR-301` — *"A configurable that can switch off a `MUST` is a defect"* |

---

## 16. Accessibility

### 16.1 ⛔⛔ Ratified status — stated honestly

| Class | Finding |
|---|---|
| ⛔⛔ **RATIFIED by `PRD-007`** | ⛔⛔ **NONE.** Measured: `accessib*`, `WCAG`, `screen reader`, `contrast`, `colour-blind`, `touch target`, `font size`, `reduced motion`, `keyboard` — ⛔ **0 occurrences each** |
| ⚠️ **RECOMMENDED** | ⭐ `docs/design/ACCESSIBILITY.md` — ⚠️ its own header reads *Status: **RECOMMENDED** — accessibility foundation **pending formal approval and validation***; ⚠️ *Target: **TO BE DECIDED*** |
| ⭐ **METHODOLOGY** | UI/UX Pro Max priority 1 *(contrast 4.5:1, aria-labels)* and priority 2 *(44×44pt / 48dp)* — ⛔ **unranked, confers nothing** |
| ⚠️ **TBD** | `DD4-TBD-001`…`005` — §23 |

⛔⛔ **This document does NOT claim that any accessibility guideline is formally
ratified for `BC-04`.**
⚠️ It is a **regression against `PRD-006`**, which carries `ATT-NFR-014` — the
only ratified a11y obligation found in any Liboora PRD. ⭐ Recorded; ⛔ not fixed.

### 16.2 ⭐ Near-accessibility requirements that DO exist in `PRD-007`

⭐ Genuine `MUST`s with accessibility effect, though the PRD never uses the word:

| Requirement | Effect |
|---|---|
| ⭐⭐ `SEAT-FR-039` | ⛔ *"A lock **MUST NOT** be invisible"* — a **perceivability** requirement |
| ⭐ `SEAT-FR-163` | A locked seat is *"**visibly** marked as locked to every staff role, **with its reason**"* |
| ⭐ `SEAT-FR-169` | Maintenance seats *"**MUST** remain visible to staff with its maintenance reason"* |
| ⭐⭐ `SEAT-FR-106` | An unavailable value renders **marked unavailable** — ⛔ never silently blank |
| ⭐⭐ `SEAT-NFR-010` | ⛔ *"'Assignment failed' **MUST NOT** be the whole of a rejection"* — an **error-comprehension** requirement |
| ⭐ `SEAT-FR-045` | Rejections are **distinguishable** from one another |
| ⭐ `SEAT-FR-255` | ⭐ **Natural ordering** — *seat 2 precedes seat 10* — a genuine cognitive-accessibility win |

### 16.3 ⭐ Checks applied from the RECOMMENDED foundation

⭐ From `docs/design/ACCESSIBILITY.md` §2, applied as **design decisions** — ⛔ not
as ratified requirements:

| Check | Applied |
|---|---|
| ⭐⭐ *"Color is never the only carrier of status, error, selection, or availability"* | ⭐ **Every** state in §13 carries a text label; `S1`'s ✓/─ are labelled |
| *"Focus is visible, ordered, persistent through state change"* | ⭐ `L1`'s zone sections and `L24`'s tabs preserve focus across refresh |
| *"Text and controls remain understandable at increased text size and narrow widths"* | ⭐ ⛔ No fixed-width label containers; chips size to content |
| *"Labels describe the action or content; icon-only controls require a clear accessible name"* | ⭐ `SeatChip` carries *"Seat A1, Hall A, allocated, locked"* |
| *"Errors identify the problem and the next safe recovery action without exposing internal identifiers"* | ⭐ §12.1's message set names gates in **human terms**, ⛔ never as `G7` |
| *"Loading, empty, offline, stale and unavailable states are perceivable without motion"* | ⭐ All specified per surface in §11 |
| *"Reduced motion removes nonessential transitions"* | ⚠️ `DD4-TBD-005` |
| ⚠️ *"Touch targets… exact minimum values are **TO BE DECIDED**"* | ⚠️ `DD4-TBD-004` — ⛔ **this document does not fix a number** |

⚠️ **Measured implementation note, quoted from that file:** *"**0** occurrences
of `Semantics`, `semanticsLabel`, `meetsGuideline` or `textScaleFactor` under
`lib/`, and **0** accessibility assertions under `test/`… recorded as
`DIT-007`."* ⛔ So none of the above is implemented anywhere today.

### 16.4 ⚠️ Unratified accessibility values — ⛔ NOT presented as approved

| ID | Item | Status |
|---|---|---|
| `DD4-TBD-001` | Contrast ratios for 4 `SeatState` chips, 4 presence states, lock badge, overstay badge | ⚠️ **UNRATIFIED** — Design Owner |
| `DD4-TBD-002` | ⭐ The accessibility **standard** itself | ⚠️ *"TO BE DECIDED"* — Accessibility Owner |
| `DD4-TBD-003` | Screen-reader semantics for a **2D spatial seat map** | ⚠️ **TBD** |
| `DD4-TBD-004` | ⭐ Touch-target size on a dense grid vs `SEAT-NFR-005`'s 50×100 bound | ⚠️ **UNRATIFIED DESIGN VALUE / VALIDATION REQUIRED** |
| `DD4-TBD-005` | Reduced-motion behaviour for `L3` drag | ⚠️ **TBD** |

### 16.5 ⭐⭐ The colour-dependence finding

⭐⭐ **Measured risk:** `SEAT-FR-103` names four presence states **by colour**
(🟢🔵🟠⚪), adds a ⚠ badge, and `SEAT-FR-037` yields four more chip states.
⛔⛔ **Colour is the only distinguishing property `PRD-007` supplies.**

| Consequence | Treatment |
|---|---|
| ⭐⭐ The **text label is load-bearing** | ⛔⛔ **It must never be truncated, abbreviated or replaced by a dot** |
| ⭐ Two amber-family states coexist *(🟠 unverified, ⚠ overstay)* | ⭐ They live on **different axes** and are **separately labelled** — §11.2 Tier 3 |
| ⭐ Structurally the same risk as `DD-0003` §21.3's 🟡🟡 collision | ⭐ Cross-referenced; ⛔ not re-decided here |

### 16.6 ⭐ Drag alternative for `L3`

⭐⭐ `SEAT-FR-029` **requires** drag-and-drop. ⛔ A drag-only interaction excludes
switch and screen-reader users. ⭐ The design therefore pairs **every** drag with
a select-then-move alternative (§11.3).
⚠️ **DESIGN DECISION**, methodology-supported by Pro Max *("Dragging and
swipe-only interactions have button/keyboard alternatives")*; ⛔ **not** claimed
as a Liboora requirement.

---

## 17. Design System / Components

### 17.1 ⭐ Existing tokens — used, ⛔ not invented

⭐ Measured from `lib/app/shared/theme.dart`:

| Token group | Values | Use |
|---|---|---|
| `LiblColors.brand` / `brandDark` | `#2D3E8F` / `#1B2761` | ⭐ Deep indigo — the file's own note: *"Reads well in the **low light of a basement reading hall, which is where this app is actually used**"* |
| `accent` | `#F5A524` | Attention |
| `success` / `warning` / `danger` / `info` | `#15803D` / `#B45309` / `#B91C1C` / `#0E7490` | State families |
| `surface` / `card` / `border` | `#F7F8FC` / white / `#E3E6F0` | ⭐ 2.5D elevation |
| `textPrimary` / `textMuted` | `#14183A` / `#6B7194` | Type |
| `LiblSpace` | **4 · 8 · 12 · 16 · 24 · 32** | ⭐ Already a 4/8dp rhythm |
| Card radius | **14** | `CardThemeData` |
| Dialog radius | **18** | `DialogThemeData` |
| Font family | `Roboto`, Material 3 | `buildLiblTheme()` |

⛔⛔ **No token value is invented in this document.**

### 17.2 ⚠️ Unratified token needs — ⛔ declared as placeholders

| Need | Status |
|---|---|
| ⚠️ Distinct colours for **4** `SeatState` chips | ⚠️ **UNRATIFIED / PLACEHOLDER.** ⭐ `LiblColors` has no 4-value state family; `success`/`warning`/`danger`/`info` are **semantic**, ⛔ not seat-state tokens → `DD4-TBD-001` |
| ⚠️ **4** presence-state colours | ⚠️ **UNRATIFIED / PLACEHOLDER** — `SEAT-FR-103` names **colours**, ⛔ not hex values |
| ⚠️ Lock-badge and overstay-badge treatment | ⚠️ **UNRATIFIED / PLACEHOLDER** |
| ⚠️ Motion durations | ⭐ **REUSED** from `DD-0001` where applicable; ⛔ **no new value invented here** |

⛔⛔ **None of the above is presented as an approved product token.**

### 17.3 ⭐ Reused components — and one prohibition

⭐ Measured from `lib/app/shared/widgets/common.dart` — **7** components exist:

| Component | Reused for | Verdict |
|---|---|---|
| `MetricTile` | `L1` Tier 1 figures | ⭐ **REUSE** |
| `SectionHeader` | `L1` zones · `L19` · `L20` · `S4` | ⭐ **REUSE** |
| `Pill` | state chips · request states | ⭐ **REUSE** |
| `Monogram` | `L5` student picker | ⭐ **REUSE** |
| `EmptyState` | `L1` empty layout · `L24` empty queues | ⭐ **REUSE** |
| `PanelCard` | `L14` · `L16` · `L21`…`L23` · `S4` | ⭐ **REUSE** |
| ⛔⛔ **`MeterBar`** | ⛔⛔ **PROHIBITED — see below** | ⛔⛔ **MUST NOT BE USED** |

#### ⛔⛔ `MeterBar` is prohibited on `BC-04` surfaces — on `PRD-007`'s own authority

| Source | Statement |
|---|---|
| ⭐ `SEAT-XC-018` | ⛔ Occupancy **trends**, averages, ranking, comparison, time-series → **`BC-26`** |
| ⭐⭐ `SEAT-FR-245` | ⛔ Allocation rate and occupancy rate *"**MUST** be presented as **two distinct figures** and **MUST NOT** be labelled interchangeably"* |
| ⭐ `SEAT-XC-019` | ⛔ *"**MUST NOT** define a metric that `BC-26` also defines"* |
| ⭐ `SEAT-FR-247` | ⛔ *"**MUST NOT** maintain a pre-aggregated counter as a system of record"* |

⭐⭐ **Measured deviation:** `seat_map_page.dart:72` currently renders
`MeterBar(fraction: summary.occupied / summary.total)` — ⛔ **a single bar
conflating exactly the two figures `SEAT-FR-245` requires be kept distinct**, and
labelled *"reserved"* while computed from `isOccupied`. ⚠️ Recorded as
`AIV-S01`; ⛔ **not fixed here**.

⭐ **This is the same prohibition `DD-0003` §27 recorded for `BC-03` under `NG-6`
— and here it lands on its owning PRD.**

### 17.4 ⭐ New components proposed — 4

| # | Component | Purpose | Why existing are insufficient | States / variants | Surfaces | Approval |
|---|---|---|---|---|---|---|
| 1 | ⭐ **`SeatChip`** | One seat in a grid | ⭐ `Pill` is text-only and cannot carry **state + lock badge + power/corner affordance + accessible name** in a two-line square | 4 `SeatState` × locked/unlocked × own/other × selected/unselected | `L1`, `L19`, `L7` picker | ⛔ **PROPOSED** — Design Owner |
| 2 | ⭐⭐ **`TwoAxisPresenceBlock`** | Renders presence **and** conformance as **two labelled axes** | ⭐⭐ **No existing component can express two independent axes without collapsing them** — and `SEAT-FR-103` **prohibits** collapsing | axis 1: 4 states *(1 blocked)* · axis 2: none / overstay · unavailable | `L2` only | ⛔ **PROPOSED** |
| 3 | ⭐ **`StudentSeatChip`** | Deliberately **reduced** seat token | ⭐⭐ Reusing `SeatChip` with fields hidden would put `SEAT-FR-275`-prohibited data one bug from disclosure (§15.2) | bookable / unavailable / yours | `S1`, `S3` | ⛔ **PROPOSED** |
| 4 | ⭐ **`LayoutEditorCanvas`** + `LayoutElementToken` | Drag-positioning + walls/doors/tables/pillars | ⭐ Nothing in `common.dart` supports positioned editing | seat / wall / door / table / pillar; dragging / selected / invalid | `L3` | ⛔ **PROPOSED** |

⛔⛔ **All four are `PROPOSED`. ⛔ None is approved. ⛔ None is implemented.**

### 17.5 ⭐ Consistency with DD-0001 / DD-0002 / DD-0003

| Aspect | Consistent? |
|---|---|
| Token source | ⭐ **YES** — all four DDs use `LiblColors`/`LiblSpace` and invent nothing |
| 2.5D discipline | ⭐ **YES** — cards and primary interactions only |
| `MeterBar` prohibition | ⭐⭐ **YES** — `DD-0003` prohibited it under `NG-6`; ⭐ this document prohibits it under `SEAT-FR-245`/`SEAT-XC-018` |
| Motion | ⭐ **YES** — reused; ⛔ no new durations |
| Header / control-table format | ⭐ **YES** — same structure as `DD-0001`…`DD-0003` |
| Status discipline | ⭐ **YES** — `PROPOSED`, `UNRANKED`, ⛔ claims no authority |

---

## 18. 2D / 2.5D / 3D Strategy

### 18.1 ⭐⭐ `PRD-007` legislates depth directly — the only audited PRD that does

> ⭐⭐ **`SEAT-FR-035`** — *"An interactive **2D** layout is **mandatory** for V1.
> An interactive **3D** layout is **optional** and **MAY** be enabled later.
> Enabling 3D **MUST NOT** require any change to the seat model, the allocation
> model, or any requirement in this document; **3D is a rendering of the same
> `SeatLayout`**."*

⭐ Reinforced by `SEAT-FR-005` *(3D's absence limits nothing)* and `PRD-007` §34.4
*(3D-as-required = **Future**, *"a product decision, not a correction"*)*.

### 18.2 ⭐ Assignment

| Depth | Surfaces | Count | Rationale |
|---|---|---|---|
| ⭐ **2D** | `L1` lists · `L3` canvas · `L4` · `L6` · `L8`…`L17` · `L19` · `L20` · `L21`…`L24` · `S2` · `S3` | **24** | ⭐ `SEAT-FR-035` **mandates 2D**; ⭐ `SEAT-NFR-005` requires usability at max inventory |
| ⭐ **2.5D** | `L1` Tier 1 card · `L2` sheet · `L5` sheet · `L18` sheet · `S1`/`S4` own-seat card | **5** | ⭐ Elevation and shadow **only** — depth as **affordance**, ⛔ not spectacle |
| ⛔⛔ **3D** | ⛔⛔ **NONE** | ⛔⛔ **0** | §18.3 |

### 18.3 ⛔⛔ Why 3D is zero — reasoned, not assumed

| # | Reason |
|---|---|
| 1 | ⭐ `SEAT-FR-035` makes 3D **optional**, ⛔ not required. ⭐ A Design Doc that added a 3D requirement would **exceed its authority** |
| 2 | ⭐ `PRD-007` §34.4 classifies *"3D layout as a required capability"* as **Future** — *"making it mandatory is a product decision, not a correction"* |
| 3 | ⭐⭐ `SEAT-NFR-005` requires performance ⛔ **not to degrade non-linearly** at 50 floors × 100 zones. ⛔ A 3D hall renderer on low-end Android contradicts that |
| 4 | ⭐⭐ `DD-0003` §26 **already REJECTED a 3D seat map** — ⭐ this document **confirms that from the owning PRD's own text**, rather than re-deciding it |
| 5 | ⭐ The brief: ⛔ *"never introduce it merely because it looks premium"* — honoured |

⭐ **If 3D is later enabled, `SEAT-FR-035` guarantees it needs no model change** —
so ⛔ nothing here blocks it, and ⛔ nothing here anticipates it.

### 18.4 ⭐ Cross-document depth consistency

| Design Doc | 2D / 2.5D / 3D |
|---|---|
| `DD-0003` Attendance | 18 / 4 / **0** |
| ⭐ **`DD-0004` Seat Management** | ⭐ **24 / 5 / 0** |

### 18.5 ⛔ Visual-language prohibitions honoured

| ⛔ Avoided | Why |
|---|---|
| ⛔ Excessive gradients | ⭐ `theme.dart` uses flat fills + 1px borders; ⛔ no gradient exists to extend |
| ⛔ Excessive animation | ⭐ §19.2 — ⛔ no animation on grid state change |
| ⛔ Heavy 3D / WebGL | ⭐ §18.3 — ⛔ zero 3D surfaces |
| ⛔ Visual clutter | ⭐ `L2`'s four tiers; ⭐ `L1`'s presets reduce before the grid is scanned |
| ⛔ Childish gamification | ⭐ §7.1 — prohibited by `SEAT-XC-018` **and** the brief |
| ⛔ Performance-heavy effects | ⭐ §19.2 |

---

## 19. Performance

### 19.1 ⭐ The authoritative constraint — and the figure this document must NOT state

⭐⭐ `SEAT-NFR-005`: *"The seat map **MUST** remain usable at the maximum inventory
the platform permits, which `LCFG-9` and `LCFG-10` bound at **50 floors × 100
zones** per branch. Performance **MUST NOT** degrade non-linearly with seat
count, **because the seat map is the module's primary surface**."*

⛔⛔ `SEAT-NFR-004`: ⛔ *"This document **MUST NOT** state a latency or
availability figure of its own."*
⭐⭐ **So this Design Doc states none either.** ⛔ No millisecond target, no FPS
figure, no budget. ⚠️ Any such number would be an **UNRATIFIED DESIGN VALUE** —
and inventing one would contradict the PRD it serves.

### 19.2 ⭐ Design decisions for low-end Android

| Decision | Rationale | Class |
|---|---|---|
| ⭐⭐ `L1` renders **progressively by zone** | ⛔ A single 5,000-seat build would block first paint | ⚠️ **DESIGN DECISION** |
| ⭐⭐ Presence is **not composed for off-screen seats** | ⭐ `SEAT-FR-104` composes at read time; ⛔ composing for invisible rows is waste | ⚠️ **DESIGN DECISION** |
| ⭐ `L2` Tier 3 resolves **after** Tiers 1–2 | ⭐ The card must never block on a cross-context read (`SEAT-FR-106`) | ⚠️ **DESIGN DECISION** |
| ⭐⭐ ⛔ **No pan/zoom canvas on `L1`** | ⭐ A zone-sectioned list reuses list virtualisation; ⛔ a free canvas does not | ⚠️ **DESIGN DECISION** on ⚠️ `DD4-HYP-002` |
| ⭐ `L3`'s canvas is **zone-scoped** | ⛔ Never branch-wide — bounds widget count to one hall | ⚠️ **DESIGN DECISION** |
| ⭐ Derived state computed at read time | ⭐ `SEAT-NFR-012` accepts this as *"a deliberate trade"* | ⭐ **REQUIREMENT** |
| ⭐ ⛔ **No WebGL / 3D for routine operations** | §18.3 | ⚠️ **DESIGN DECISION** |
| ⭐ ⛔ **No animation on state change in a grid** | ⛔ Animating hundreds of chips is the classic low-end stall | ⚠️ **DESIGN DECISION** |
| ⭐ Stable layouts — press states ⛔ must not shift bounds | ⭐ Pro Max *(methodology)*: *"Stable Interaction States"* | ⚠️ **DESIGN DECISION** |
| ⭐ Bulk operations bounded at **2,000** / **500** rows | ⭐ `SEAT-FR-179` — ⛔ rejected **before** validation begins | ⭐ **REQUIREMENT** |
| ⭐⭐ A bulk operation ⛔ **must not lock** seats it is not writing | ⭐ `SEAT-NFR-009` — *"counter operations take precedence — a library cannot stop serving students because an import is running"* | ⭐ **REQUIREMENT** |

### 19.3 ⭐ Realtime and reconciliation

⭐ `SEAT-NFR-006` — state *"**MUST** converge for all connected staff clients
without a manual refresh"*, and a client that missed updates *"**MUST** be able
to resynchronise **from current state** rather than by replaying a stream, since
`SeatState` is derived and therefore always recomputable."*
⭐ `SEAT-FR-194` — realtime is *"an optimisation, **never** the source of truth"*.
⭐ `SEAT-FR-195` — payloads carry **only** derived state, lock flag and occupancy
flag; ⛔ **never** holder name or membership data.
⭐ `SEAT-FR-193` — every update is **tenant-scoped**.

### 19.4 ⚠️ Flutter version handling — ⛔ the mismatch is not swept aside

| Fact | Measured |
|---|---|
| ⭐ Liboora's Flutter / Dart | **3.35.4** / **3.9.2** |
| ⭐ Liboora's state management | **Provider** `6.1.5+1` |
| ⛔⛔ Pro Max `flutter.csv` `Applies To` | ⛔⛔ **`flutter 3.44.x (current stable line)`**, verified `2026-08-13` |

| Row | Disposition |
|---|---|
| #39 const widgets · #40 minimal rebuild scope · #41 `RepaintBoundary` · #14 avoid deep nesting | ⭐ **USED** — version-independent principles |
| #25 handle loading **and** error states | ⭐ **USED** — matches §11's per-surface state discipline |
| #43 `Semantics` widget | ⭐ **USED as methodology**, ⛔ not as a Liboora requirement |
| ⚠️ #44 `MediaQuery.textScalerOf` | ⚠️ **DEFERRED** — API availability at 3.35.4 ⛔ **not verified by this document**; ⛔ no code claim made |
| ⛔⛔ #7 / #8 *"Prefer Riverpod"* | ⛔⛔ **REFUSED** — Liboora uses Provider. ⭐ A methodology reference **may not re-architect** state management |

⛔⛔ **No code-shaped Pro Max row is presented as applicable to Liboora without
this filter.**

---

## 20. Cross-Feature Consistency

### 20.1 ⭐ Checks against every named source

| # | Compared with | Verdict | Detail |
|---|---|---|---|
| C-1 | **`DD-0001` Membership** | ⭐ **CONSISTENT** | `SEAT-FR-154` consumes `E-02` read-only; ⭐ `MM-FR-025`'s quota-on-renewal rule is honoured by `SEAT-FR-300`'s retain-and-flag |
| C-2 | **`DD-0002` Student Management** | ⭐ **CONSISTENT** | `SEAT-FR-010`/`278` hold `StudentRecordId` only, per `SM-2.4`; ⭐ `SEAT-FR-253` composes names at read time |
| C-3 | ⭐⭐ **`DD-0003` Attendance** | ⭐ **CONSISTENT on substance** | ⭐ `DD-0003` §18 correctly scoped itself to the **presence** dimension and left the **seat** dimension to `BC-04`; ⭐ its `AIV-16` *(binary `isOccupied`)* is confirmed here as `AIV-S03` |
| ⛔⛔ C-4 | ⛔⛔ **`DD-0003` on transport** | ⛔⛔ **CONFLICT — `SEAT-CONFLICT-002`** | §22.2 |
| C-5 | **`PRD-006` Attendance** | ⭐ **CONSISTENT** | ⭐ Both sides state the split identically; ⭐ `SEAT-FR-041` and `ATT-AC-222`'s two-axis rule **agree** |
| C-6 | **`PRD-001` Authentication v2.0** | ⭐ **CONSISTENT** | `SEAT-FR-268`/`269` consume `TR-1`…`TR-5` and the closed 3-scope register; ⛔ invent nothing |
| C-7 | ⛔⛔ **BC Map v1.18 / Dependency Matrix** | ⛔⛔ **CONFLICT — `SEAT-CONFLICT-001`** | §22.1 |
| C-8 | ⭐ **`MeterBar` prohibition** | ⭐ **CONSISTENT** | ⭐ `DD-0003` prohibited it under `NG-6`; ⭐ this document under `SEAT-FR-245` — ⭐ **its owning authority** |
| C-9 | **`ADR-0020`** | ⭐ **CONSISTENT** | Confers `PRD-007`'s Rank 3; ⭐ this document treats it as authoritative |
| C-10 | **`ADR-0032`** | ⭐ **CONSISTENT on substance** | ⭐ Option `O-5` read-time composition and the 4 presence states are honoured; ⛔ **only its transport is conflicted** |
| ⛔ C-11 | ⛔ **`ADR-0033`** | ⭐ **CONSISTENT — and it is the reason for `SEAT-CONFLICT-001`** | ⭐ `ADR-0033` **withdrew** `E-27`; ⛔ `PRD-007` L867 still cites it |
| ⚠️ C-12 | ⚠️ **`TRACEABILITY_MATRIX.md` §2E** | ⚠️ **STALE** | ⚠️ L309 records `PRD-007` as *"v1.0, **`DRAFT`**"*; ⭐ measured **`FROZEN` v1.1** → §22.3 |
| ⚠️ C-13 | ⚠️ **`DD-0001` §1.1 comparison table** | ⚠️ **STALE** | ⚠️ It records `PRD-007` as *"8, all prohibitions"* — the instrument §1.2 falsifies. ⛔ **`DD-0001` is NOT edited** → §22.3 |
| ⚠️ C-14 | ⚠️ **`docs/35-design/README.md` §2A.3/§2A.4** | ⚠️ **STALE — corrected by this pass** | ⭐ The ⚪ NOT REQUIRED row is superseded; §24 records the README update |
| C-15 | **`docs/design/*` governance** | ⭐ **CONSISTENT** | ⭐ `ACCESSIBILITY.md` treated as **RECOMMENDED**, ⛔ not ratified (§16.1) |

### 20.2 ⭐⭐ Attendance ↔ Seat — the boundary restated for design

⭐⭐ **The two concepts are NOT collapsed, and both PRDs say so independently.**

| Concept | Owner | `BC-04`'s role on these surfaces |
|---|---|---|
| A punch, verification evidence, `AttendanceDay`, corrections, totals | ⭐ **`BC-03`** | ⛔ **None.** `SEAT-FR-108` — *"**Never** records, edits or verifies one"* |
| ⭐ Whether a seat is physically in use | ⭐ **`BC-04`** | ⭐ **Owns** — derived from `E-08` |
| ⭐ Live occupancy per zone / floor / branch | ⭐ **`BC-04`** | ⭐ **Owns** — `L1` Tier 1 |

⭐ Design consequences already applied: ⭐ `L2`'s Tier 2/Tier 3 split ·
⭐ `L1`'s *"unseated present"* count *(`SEAT-FR-112`, case 30)* ·
⭐ `L19`'s presets 3 and 4 *(the two ways the axes can disagree)* ·
⛔ **no presence on `S4`/`P1`** *(`SEAT-FR-276`)* ·
⛔ **no combined QR scan surface** *(`SEAT-XC-012`)*.

### 20.3 ⛔ Notifications — why no surface is designed

⭐ `SEAT-XC-016` removes message dispatch entirely; ⭐ `SEAT-XC-017` forbids
delivery state on the card, timeline or any report; ⭐ `SEAT-FR-243` states this
module ⛔ *"**MUST NOT** carry a per-student 'notify on seat change'
preference"*.
⭐⭐ **So notification fatigue is structurally impossible here, and ⛔ no
notification surface, preference screen or delivery indicator appears in §11.**
⭐ `SEAT-FR-240` — facts without an event carrier surface in `L24` instead.

---

## 21. Implementation Evidence

⛔⛔ **CODE IS NOT PRODUCT AUTHORITY.** ⛔ Nothing below is fixed by this document.
⭐ **DESIGNED BEHAVIOUR** and **CURRENT IMPLEMENTATION** are kept strictly apart.

### 21.1 ⭐ The 11 deviations — preserved from the accepted audit

| ID | ⭐ DESIGNED BEHAVIOUR *(requirement)* | ⚠️ CURRENT IMPLEMENTATION | Authority | Class | Impact |
|---|---|---|---|---|---|
| ⛔⛔ **`AIV-S01`** | ⭐ Allocation rate and occupancy rate as **two distinct figures**; ⛔ no widget defining a `BC-26` metric | ⛔⛔ `seat_map_page.dart:72` **`MeterBar(occupied/total)`** — one bar, labelled *"reserved"*, computed from `isOccupied` | `SEAT-FR-245`, `SEAT-XC-018`/`019` | ⛔ **PROHIBITED WIDGET** | §17.3 — `L1` |
| ⛔⛔ **`AIV-S02`** | ⭐ Reassign requires **two explicit steps** | ⛔ `seat_map_page.dart:146`/`185` — tapping a free seat opens assign directly; binary occupied/free | `SEAT-BR-016` | ⛔ **INCONSISTENT** | `L5`, `F3` |
| ⛔⛔ **`AIV-S03`** | ⭐ **4** derived states | ⛔ `SeatOccupancy.isOccupied` = `allocation != null` — **2** states | `SEAT-FR-037`, `SEAT-XC-001` | ⛔ **MISSING** | ⛔ `Reserved` and `Maintenance` **unrepresentable** |
| ⛔⛔ **`AIV-S04`** | ⭐ Lock flag, **always visible** | ⛔⛔ **No lock concept anywhere in `lib/`** | `SEAT-FR-038`/`039` | ⛔ **MISSING** | `L12`, `L13` |
| ⛔ **`AIV-S05`** | ⭐ Maintenance workflow with 3 dispositions | ⛔ **0** occurrences of maintenance in `lib/` | `SEAT-FR-164`…`170` | ⛔ **MISSING** | `L14`, `L15` |
| ⛔⛔ **`AIV-S06`** | ⭐ **24** closed protected operations | ⛔ `Permission` enum holds **one** seat permission: `assignSeat` | `SEAT-FR-272` | ⛔ **MISSING** | ⛔ Lock / maintenance / bulk / layout / category **cannot be authorised distinctly** |
| ⚠️ **`AIV-S07`** | ⭐ Reception holds ⛔ **no** structural operation | ⚠️ `identity.dart:254` `reception: {assignSeat: tenantWide}`; and `assignSeat` also gates `ReleaseSeat` | `SEAT-BR-038` | ⚠️ **INCONSISTENT** | §14.3 unenforceable in code |
| ⛔ **`AIV-S08`** | ⭐ Student holds `SEAT-PO-005`/`022`/`023` | ⛔ `identity.dart:258` `student: {viewStudent: self}` — ⛔ **no seat permission at all** | `SEAT-PO-005` | ⛔ **INCONSISTENT** | ⭐ `S1`…`S4` unbuildable as specified. ⭐ Structurally identical to `DD-0003`'s `AIV-05` |
| ⛔ **`AIV-S09`** | ⭐ `Branch → Floor → Zone → Seat` | ⛔ `Seat.zone` is a bare `String`; ⛔ **no `Floor`** | `SEAT-FR-013`, `SEAT-BR-003` | ⛔ **MISSING** | ⛔ Multi-floor unrepresentable |
| ⛔ **`AIV-S10`** | ⭐ Versioned layouts, one active per zone | ⛔ `SeatLayout` has no version and no active flag; `addSeat` mutates in place | `SEAT-FR-021`/`022`/`231` | ⛔ **MISSING** | `L3`, `L20` |
| ⛔ **`AIV-S11`** | ⭐ Seat carries category · type · lock · maintenance ref | ⛔ None exist. ⚠️ `hasPowerSocket`/`isCorner` are ⛔ **not in `SEAT-FR-024`** | `SEAT-FR-024` | ⛔ **MISSING** | ⛔ Gate `G13` inevaluable |

⛔⛔ **None of the eleven is fixed, patched or worked around by this document.**

### 21.2 ⭐ What IS consistent — said explicitly, because fairness cuts both ways

| Area | Finding |
|---|---|
| ⭐⭐ The core invariant | `SeatAllocation.assertSeatFree` correctly enforces the overlap rule **inside the aggregate** with a half-open range, exactly as `SEAT-INV-001` + `SEAT-NFR-001` require |
| ⭐ Test coverage of that invariant | ⭐ **17 tests** in `test/architecture/invariants/seat_allocation_invariant_test.dart` — ⭐ genuine coverage |
| ⭐ `G7` behaviour | ⭐ `AssignSeat` correctly **blocks** on invalid membership, matching `MP-GBR-16` and the `E-02`/`E-03` asymmetry |
| ⭐ Quota behaviour | ⭐ `AssignSeat` rejects when held ≥ `seatQuota`, naming both figures — matching `SEAT-BR-012` |
| ⭐ Append-only release | ⭐ `SeatAllocation.release()` sets status and reason; ⛔ **never deletes** — matching `SEAT-FR-061` |

### 21.3 ⛔⛔ Test status — stated plainly

| Measure | Value |
|---|---|
| ⛔⛔ Implementation tasks proven by test | ⛔⛔ **0 of 100** |
| ⛔⛔ Acceptance criteria proven by test | ⛔⛔ **0 of 226** |
| ⛔ Tests citing any `SEAT-*` identifier | ⛔ **0** — measured |
| ⭐ Seat aggregate tests that exist | ⭐ **17**, ⛔ traced to no `SEAT-AC-*` |
| ⛔⛔ Surface / widget tests | ⛔⛔ **0** — repo-wide there is **1** `testWidgets` |

⛔⛔ **This document was written by INSPECTION. `flutter test` was NOT run for it.
⛔ No test result is claimed, and ⛔ nothing here asserts that `BC-04` works.**
⭐ `SEAT-NFR-011`, quoting `SID-4.56`: *"a rule that cannot be checked SHALL be
treated as unmet."*

---

## 22. Open Conflicts

⛔⛔ **NONE of these is resolved here.** ⭐ Both readings, the authority level, the
affected surfaces and the owner are recorded. ⛔ **No choice is made on UX
preference.**

### 22.1 ⛔⛔ `SEAT-CONFLICT-001` — `E-27` is cited by a FROZEN PRD but does not exist

**Measured mechanically, this pass:**

```
$ grep -c "^| E-[0-9]" LIBOORA_BOUNDED_CONTEXT_MAP.md
26
$ grep -o "^| E-[0-9]*" ... | sort -V
E-01 … E-26        ⛔ NO E-27 ROW EXISTS
```

| # | Reading | Source | Rank |
|---|---|---|---|
| ⭐ **A** | ⭐⭐ **`E-27` is withdrawn and permanently vacant.** Presence composition is carried by frozen `SEAT-FR-104`'s own read-time pattern | ⭐ `ADR-0033` **Accepted**, option `O-C` · ⭐ BC Map **v1.18** header: *"`E-27` **still permanently vacant**"* · ⭐ `DOCUMENTATION_BASELINE.md` L137 · ⭐ `PRD-006` v1.9 header: *"the **net edge set is unchanged** at `E-01`…`E-26`"* | ⭐ **Rank 2 + Rank 4** |
| ⛔ **B** | ⛔⛔ *"Presence arrives over **`E-27`** (BC Map §7.1) **and over nothing else**"* | ⛔⛔ **`PRD-007` L867** *(and L2888's changelog: *"solely over new edge `E-27`"*)* | ⛔ **Rank 3 — FROZEN** |

⭐⭐ **`ADR-0033` §5 step 3 expressly required this repair** — *"Update `PRD-006`
§23.4a and `SEAT-FR-103`'s amendment note to cite the composition pattern
instead of `E-27`."* ⭐ `PRD-006` **was** updated. ⛔⛔ **`PRD-007` was not.**

| Attribute | Value |
|---|---|
| **Affected surfaces** | ⭐ `L2` *(field 12, the presence axis)*; indirectly `L1` Tier 1's occupancy figure |
| **Affected flows** | ⭐ None directly — ⭐ `F7`'s `T2` trigger rides `E-08`, ⛔ **not** `E-27` |
| **Classification** | ⛔⛔ **CONFLICT** |
| **Owner** | ⭐ **Architecture Owner + `PRD-007` owner** |
| **Design impact** | ⭐⭐ **NONE on the rendering.** ⭐ `ADR-0033` §6 states *"`O-5` survives intact — **only its transport documentation changes**"*, and §3 proves frozen `SEAT-FR-104` already performs an **edgeless `BC-01` read**. ⭐ So the four presence states, read-time composition, the no-store rule and the no-raw-Wi-Fi rule are **all unaffected** |

⛔⛔ **What this document does NOT do:**
⛔ It does **not** pick reading A or B. ⛔ It does **not** amend `PRD-007`.
⛔ It does **not** invent a replacement transport edge, a new edge number, or a
port name. ⛔ **`E-28`…`E-34` are not borrowed, and no `E-35` is proposed.**
⭐ §11.2 therefore cites `ADR-0032`'s **option `O-5` and the read-time
composition pattern** — ⭐ the part both readings agree on — and names the
conflict rather than resolving it.

### 22.2 ⛔⛔ `SEAT-CONFLICT-002` — stale `E-27` citations inside `DD-0003`

⭐⭐ **Reported against prior design work rather than left to be discovered.**

| `DD-0003` line | Claim | Verdict |
|---|---|---|
| L139 | `ADR-0032` … *"read edge **`E-27`**"* | ⚠️ **Historically true, now stale** |
| ⛔⛔ **L140** | `ADR-0033` → ⛔⛔ *"**Transport is lawful**"* | ⛔⛔ **WRONG** — `ADR-0033` **withdrew** the transport; ⛔ it did not bless it |
| L266 | `X-2` … *"pulls presence at read time over **`E-27`**"* | ⛔ Stale |
| L553 · L635 · L1609 | `E-27` cited as the live mechanism | ⛔ Stale |
| ⚠️ L1009 | ⚠️ `E-27` used as an **edge-case identifier** in an unrelated table | ⚠️ **Identifier collision** |

| Attribute | Value |
|---|---|
| **Classification** | ⛔ **CONFLICT** *(documentation integrity)* |
| **Owner** | ⭐ **Design Owner** |
| **What survives** | ⭐ `DD-0003`'s **substance** is intact — read-time composition, 4 presence states, no stored copy, no raw Wi-Fi, event surface closed at four |
| **What is defective** | ⛔ **6 citations name a withdrawn edge**, and ⛔ **one mis-states an Accepted ADR's holding** |
| ⛔⛔ **Action taken here** | ⛔⛔ **NONE — `DD-0003` is NOT modified.** ⭐ The brief forbids it, and §2B.6 rule 13 says audit, don't auto-rewrite |

### 22.3 ⚠️ `SEAT-CONFLICT-003` — stale status citations *(3 sites)*

| Location | Says | Measured | Owner |
|---|---|---|---|
| ⚠️ `TRACEABILITY_MATRIX.md` **L309** | `PRD-007` *"v1.0, **`DRAFT`**"* | ⛔ **`FROZEN` v1.1** | Governance Owner |
| ⚠️ `docs/30-product/seat-management/README.md` L4 | *"**v1.0**"* | ⛔ **v1.1** | `PRD-007` owner |
| ⚠️ `PRD-007` §3.4 | `PRD-006` *"**PLANNED**"* | ⛔ **`FROZEN` v1.9** | `PRD-007` owner |
| ⚠️ `DD-0001` §1.1 | `PRD-007` *"**8**, all prohibitions"* | ⛔ Instrument falsified — §1.2 | Design Owner |

⚠️ **Classification: documentation drift.** ⛔ **No requirement is affected**, and
⛔ **none of the four files is edited by this document.**

### 22.4 ⭐ Conflict-safety re-check — what was tested and found clean

⭐ Per the brief's §25, ⭐ **all** relevant sources were re-checked for further
conflicts. ⭐ Found **clean**:

| Pair tested | Result |
|---|---|
| `SEAT-FR-041` vs `ATT-AC-222`'s two-axis rule | ⭐ **AGREE** |
| `SEAT-FR-108` vs `PRD-006` §14-equivalent split | ⭐ **AGREE** |
| `SEAT-FR-268` vs `PRD-001` §2.3/§2.4 role sets | ⭐ **AGREE** |
| `SEAT-FR-269` vs `MP-GBR-21`'s closed scope register | ⭐ **AGREE** |
| `SEAT-FR-273` vs `AUTH-2.5` | ⭐ **AGREE** — mutually reinforcing |
| `SEAT-EVT-001`…`004` vs BC Map §9 | ⭐ **AGREE** — closed at four |
| `SEAT-XC-012` vs `ATT` QR ownership | ⭐ **AGREE** — flows separate |
| ⚠️ `SEAT-GAP-001` *(`Floor` ownership: BC Map §8 vs `LIB-10.*`)* | ⚠️ **PRE-EXISTING, still OPEN** — ⭐ `PRD-007` §3.1 already raises it and is *"written to be correct under either resolution"*; ⛔ **not resolved here** |

---

## 23. Design Gaps / TBDs

### 23.1 ⛔ Blocking gap — 1

| ID | What it blocks | Why | Owner |
|---|---|---|---|
| ⛔⛔ **`SEAT-BLOCK-001`** *(inherited)* | ⭐ **Exactly ONE of 4 presence states: 🔵 `ATTENDED · LEFT`** — i.e. **one field of one surface** (`L2`) | ⭐⭐ Measured from `DOCUMENTATION_BASELINE.md` **L170**: *"`ADR-0032` **L304** records `ATTENDED · LEFT` as still **BLOCKED**"* — because ⭐ `SEAT-BR-036` puts period aggregation in `BC-26` and ⭐ `SEAT-FR-114` **resets occupancy daily**, so ⛔ `BC-04` cannot answer *"attended earlier today"* after departure | ⭐ **Architecture Owner** |

⭐⭐ **It blocks a single field, not the feature.** ⭐ The other 3 presence states
and all 28 remaining surfaces are unaffected.

### 23.2 ⭐ Non-blocking gaps — 13 of `PRD-007`'s 14

⭐ `PRD-007` §31 measured each one's V1 effect itself. ⛔ **None is resolved here.**

| ID | Question | V1 effect *(the PRD's own measure)* | Surface |
|---|---|---|---|
| `SEAT-GAP-001` | ⭐ `Floor` ownership conflict — BC Map §8 vs `LIB-10.*` | ⭐ **None** — `SEAT-FR-015` reads, never creates | `L1`, `L3` |
| `SEAT-GAP-002` | Does `Inactive` enrollment block acquisition? | **None** — `SEAT-CFG-003` defaults to *blocks* | `L23`, `G6` |
| `SEAT-GAP-003` | ⭐ **`Q-01`** — when does expiry release the seat? | ⭐ **Bounded** — flag + queue; ⛔ no automatic release ships | `L24` |
| `SEAT-GAP-004` | Membership-freeze routing | **None** — `SEAT-FR-156` inert | `L2` |
| `SEAT-GAP-005` | Occupancy threshold in `E-05` | ⭐ **None** — ⛔ no event at **any** occupancy while unset, incl. 100% | `L23` |
| `SEAT-GAP-006` | Floor/zone-scoped permissions | **None** — `MP-GBR-21` closes the register | §14 |
| `SEAT-GAP-007` | One QR label, two flows? | **None** — `SEAT-XC-012` keeps them separate | `F14` |
| `SEAT-GAP-008` | Operating-day source for occupancy reset | **Low** — read path unnamed in the edge table | `L1` |
| `SEAT-GAP-009` | Does `BC-03` need to read allocation? | ⭐ **None in V1** — ⛔ expressly **not** closed by any `BC-03`→`BC-04` mechanism *(opposite direction)* | — |
| `SEAT-GAP-010` | Release reasons in the event payload | **None** | `L6` |
| `SEAT-GAP-011` | Directory seat column: allocation or occupancy? | **Low** — `SEAT-FR-245` keeps them distinct | **X-7** |
| `SEAT-GAP-012` | A governance citation that does not resolve | **None** | — |
| `SEAT-GAP-013` | Allocation-history retention | **None** — nothing deleted in V1 | `L20` |

⭐ **`SEAT-BR-045`**: ⛔ *"No gap above **MUST** be resolved by implementation
choice… the correct action is to escalate it, not to pick a behaviour."*
⭐ **This document escalates and does not pick.**

### 23.3 ⭐ Design-layer gaps discovered by this document — 3

| ID | Gap | Evidence | Owner |
|---|---|---|---|
| ⭐ **`DD4-GAP-001`** | ⭐⭐ `SEAT-FR-182` criterion 2 cites *"the student's **preferred zone**, where they have recorded one"* — ⛔ **but `PRD-007` specifies no surface, field or flow for recording a preference** | ⭐ Measured: `SEAT-FR-182` is the only occurrence of *preferred*; ⛔ no `SEAT-PO-*` covers setting it; ⛔ no `SEAT-CFG-*` holds it | ⭐ **Product Owner** |
| ⭐ **`DD4-GAP-002`** | ⚠️ `SEAT-FR-016` requires operation against *"the single default floor"* where none is configured — ⛔ but the **student** surfaces `S1`/`S3` have no stated behaviour when a tenant has exactly one unnamed hall | ⭐ `SEAT-FR-016` addresses module operability, ⛔ not student presentation | ⭐ **Product Owner** |
| ⭐⭐ **`DD4-GAP-003`** | ⛔⛔ `SEAT-FR-299` requires a **wrong-seat check-in mismatch** be *"**surfaced to staff**"* — ⛔ **but §22.4's work-queue list contains no mismatch queue**, and no other surface is named | ⭐ Measured: `SEAT-FR-216` lists **5** queues; ⛔ none is *mismatch*. ⭐ Edge case **31** is therefore **TBD** (§10E) | ⭐ **Product Owner + Architecture Owner** |

⛔⛔ **All three are recorded as gaps. ⛔ None is filled by invention.**
⚠️ In particular, ⛔ **this document does not add a sixth work queue** — ⭐ doing
so would extend a closed list `SEAT-FR-216` fixes.

### 23.4 ⚠️ Design TBDs — 8

| ID | Question | Owner |
|---|---|---|
| `DD4-TBD-001` | Token values for 4 state chips + 4 presence states + 2 badges | Design Owner |
| `DD4-TBD-002` | ⭐ The accessibility standard — *"TO BE DECIDED"* | Accessibility Owner |
| `DD4-TBD-003` | Screen-reader semantics for a **2D spatial** seat map | Design Owner |
| `DD4-TBD-004` | ⭐ Touch-target size on a dense grid | Design Owner |
| `DD4-TBD-005` | Reduced-motion behaviour for `L3` drag | Design Owner |
| `DD4-TBD-006` | Rendering of walls / doors / tables / pillars *(`SEAT-FR-031`)* | Design Owner |
| `DD4-TBD-007` | ⭐ Offline / degraded behaviour — ⛔ `offline` has **0** occurrences in `PRD-007`, and `ADR-0114` scopes `BC-30` **to Attendance only** | Architecture Owner |
| `DD4-TBD-008` | ⭐ Blame-free framing for the no-show counter — ⛔ no ratified source | Product Owner |

### 23.5 ⚠️ Validation hypotheses — 5, ⛔ NOT requirements

⭐ `DD4-HYP-001`…`005` — §7.6. ⛔⛔ **Each is marked *"Validation required — no
direct user research evidence available."*** ⛔ **None may be cited as a
requirement.**

---

## 24. Traceability

### 24.1 ⭐ Requirement → surface → flow matrix

| `PRD-007` area | Key identifiers | Surfaces | Flows | Coverage |
|---|---|---|---|---|
| §1 Purpose & scope | `SEAT-FR-001`…`005` | `L1` | — | ⭐ **COVERED** |
| §2 Ubiquitous language | `SEAT-BR-001` | all | all | ⭐ **COVERED** — §11 conventions |
| §3 Architectural position | `SEAT-FR-006`…`012` | — | — | ⭐ **COVERED** — §5.5 |
| §4 Spatial model | `SEAT-FR-013`…`022`, `SEAT-BR-003` | `L1`, `L3`, `L4` | — | ⭐ **COVERED** |
| §5 Identity + layout editor | `SEAT-FR-023`…`035`, `SEAT-BR-004`…`008` | `L3`, `L4` | — | ⭐ **COVERED** |
| §6 Lifecycle | `SEAT-FR-036`…`045`, `SEAT-BR-009`/`010`, `SEAT-XC-001`/`002` | `L1`, `L2` | — | ⭐ **COVERED** — §13.1 |
| §7 Allocation model | `SEAT-FR-046`…`051`, `SEAT-INV-001`…`007` | `L2`, `L20` | `F1` | ⭐ **COVERED** |
| §8 Acquisition gate | ⭐ `SEAT-FR-052`…`054`, `SEAT-BR-013`/`014`/`015`, `SEAT-XC-003`/`004` | all acquisition | ⭐ `F1` | ⭐ **COVERED** — §12.1 |
| §9 Assign / release / transfer | `SEAT-FR-055`…`067`, `SEAT-BR-016`/`017` | `L5`, `L6`, `L7` | `F2`…`F5` | ⭐ **COVERED** |
| §10 Seat-change requests | `SEAT-FR-068`…`075` | `L8`, `S3` | `F9` | ⭐ **COVERED** |
| §11 Self-booking | `SEAT-FR-076`…`084` | `S1`, `S2` | `F6` | ⭐ **COVERED** |
| §12 Booking / reservation / assignment | `SEAT-FR-086`…`102`, `SEAT-CFG-010`/`011` | `S2`, `L10`, `L11` | `F6`, `F7`, `F8` | ⭐ **COVERED** |
| ⭐⭐ §13 The seat card | ⭐⭐ **`SEAT-FR-103`**…`107` | ⭐ `L2` | — | ⚠️ **PARTIALLY COVERED** — 3 of 4 presence states |
| §14 Attendance boundary | `SEAT-FR-108`…`117`, `SEAT-BR-020`, `SEAT-XC-007`…`009` | `L1`, `L2` | — | ⭐ **COVERED** — §20.2 |
| §15 Reservations | `SEAT-FR-118`…`132`, `SEAT-CFG-015`/`016` | `L9`, `L10`, `S4` | `F7`, `F8` | ⭐ **COVERED** |
| §16 Fixed / flexible + shifts | `SEAT-FR-133`…`141`, `SEAT-BR-022` | `L2`, `L24` | `G14` | ⭐ **COVERED** |
| §17 Categories + eligibility | `SEAT-FR-142`…`150`, `SEAT-BR-023`/`024` | `L21`, `L22` | `G13` | ⭐ **COVERED** |
| §18 Membership integration | `SEAT-FR-151`…`157`, `SEAT-XC-010`/`011` | `L2`, `L24` | `G7` | ⭐ **COVERED** |
| §19 Lock / maintenance / bulk | `SEAT-FR-158`…`179`, `SEAT-BR-025`…`029` | `L12`…`L17` | `F10`, `F11`, `F12` | ⭐ **COVERED** |
| §20 Auto + QR | `SEAT-FR-180`…`191`, `SEAT-BR-030`, `SEAT-XC-012` | `L18` | `F13`, `F14` | ⭐ **COVERED** |
| §21 Realtime / concurrency / idempotency | `SEAT-FR-192`…`205`, `SEAT-BR-031`/`032`, `SEAT-XC-013` | all | all | ⭐ **COVERED** — §19.3 |
| §22 Events + work queues | `SEAT-FR-206`…`217`, `SEAT-EVT-001`…`004` | `L24` | — | ⭐ **COVERED** |
| §23 History + audit | `SEAT-FR-218`…`237`, `SEAT-XC-014`/`015` | `L20`, `S4` | all | ⭐ **COVERED** |
| §24 Notifications | `SEAT-FR-238`…`243`, `SEAT-XC-016`/`017`, `SEAT-BR-035` | ⛔ **none by design** | — | ⭐ **COVERED** — §20.3 |
| §25 Operational metrics | ⭐ `SEAT-FR-244`…`250`, `SEAT-XC-018`…`020` | `L1` Tier 1 | — | ⭐ **COVERED** — §17.3 |
| §26 Search + filters | `SEAT-FR-251`…`262`, `SEAT-XC-021` | `L19` | — | ⭐ **COVERED** |
| §27 Configuration | `SEAT-FR-263`…`267`, `SEAT-CFG-001`…`018`, `SEAT-FR-301`, `SEAT-XC-022` | `L23` | — | ⭐ **COVERED** |
| §28 Permissions + privacy | ⭐⭐ `SEAT-FR-268`…`286`, `SEAT-PO-001`…`024`, `SEAT-BR-038`…`040` | all | all | ⭐ **COVERED** — §14, §15 |
| §29 Multi-tenancy | `SEAT-FR-287`…`296`, `SEAT-INV-009`/`010` | all | all | ⭐ **COVERED** |
| §30 Edge cases | ⭐ 34 cases, `SEAT-FR-297`…`300`, `SEAT-BR-041`…`044` | various | various | ⭐ **COVERED** — §10E |
| §31 Gap register | `SEAT-GAP-001`…`014`, `SEAT-BR-045` | various | — | ⭐ **PRESERVED** — §23.2 |
| §32 NFRs | `SEAT-NFR-001`…`012` | all | all | ⭐ **COVERED** — §19 |
| §33 Acceptance criteria | `SEAT-AC-001`…`226` | — | — | ⛔⛔ **0 proven by test** |

### 24.2 ⭐ Coverage totals

| Measure | Value |
|---|---|
| Requirement areas | ⭐ **33** |
| ⭐ `COVERED` | ⭐ **31** |
| ⚠️ `PARTIALLY COVERED` | ⚠️ **1** — §13, the seat card |
| ⭐ `PRESERVED` *(gaps, not designed)* | **1** — §31 |
| ⛔⛔ Acceptance criteria proven by test | ⛔⛔ **0 of 226** |

### 24.3 ⭐⭐ Statement-class discipline

⭐ Every significant statement in this document is classified as exactly one of:

| Class | Meaning | Example |
|---|---|---|
| ⭐ **REQUIREMENT** | A `PRD-007`/ADR/Auth `MUST` | ⭐ *"`Locked` is NOT a `SeatState`"* — `SEAT-FR-038` |
| ⚠️ **DESIGN DECISION** | ⭐ **How** a requirement is met | ⭐ *"Presets sit above the grid on `L1`"* |
| ⚠️ **DESIGN PRINCIPLE** | A consistency rule across surfaces | ⭐ *"Colour never alone"* |
| ⚠️ **DESIGN ASSUMPTION** | ⭐ Stated, ⛔ unverified | ⭐ *"A vertical list suits one-handed use"* |
| ⚠️ **VALIDATION HYPOTHESIS** | ⛔ Needs research that does not exist | ⭐ `DD4-HYP-001`…`005` |
| ⭐ **IMPLEMENTATION EVIDENCE** | ⛔ What code does, ⛔ never authority | ⭐ `AIV-S01`…`S11` |
| ⛔ **OPEN CONFLICT** | ⛔ Two sources disagree | ⭐ `SEAT-CONFLICT-001`…`003` |
| ⚠️ **TBD** | Undecided, with an owner | ⭐ `DD4-TBD-001`…`008` |

⛔⛔ **No UX recommendation in this document is presented as a product
requirement.** ⭐ A design decision may explain **how** a requirement is met;
⛔ it never changes **what** the requirement means.

### 24.4 ⛔ Identifier integrity

⭐ Every `SEAT-*`, `ADR-*`, `AUTH-*`, `DD-*` and `E-*` identifier cited in this
document was **read from its source file during this pass**.
⛔⛔ **No identifier is fabricated.**
⭐ Identifiers **created** by this document are prefixed `DD4-` *(`DD4-GAP-*`,
`DD4-TBD-*`, `DD4-HYP-*`)* or are the audit's own `AIV-S*`,
`SEAT-CONFLICT-*` and `SEAT-BLOCK-001` — ⛔ **none occupies a `SEAT-*` number.**

---

## 25. Validation Plan

### 25.1 ⭐⭐ Design-decision validation matrix

| Decision | Source | Design treatment | Evidence status |
|---|---|---|---|
| Two-axis presence/conformance on `L2` | ⭐ `SEAT-FR-103` | Tier 3, two labelled axes | ⭐ **Authoritative** |
| Allocation and occupancy as two figures | ⭐ `SEAT-FR-245` | `L1` Tier 1, two rows | ⭐ **Authoritative** |
| Lock as a badge, ⛔ not a state | ⭐ `SEAT-FR-038` | Badge over chip | ⭐ **Authoritative** |
| 2D mandatory, ⛔ 3D zero | ⭐ `SEAT-FR-035` | §18 | ⭐ **Authoritative** |
| ⛔ `MeterBar` prohibited | ⭐ `SEAT-FR-245`, `SEAT-XC-018` | §17.3 | ⭐ **Authoritative** |
| Reassign in two steps | ⭐ `SEAT-BR-016` | `F3` | ⭐ **Authoritative** |
| 3-disposition maintenance step | ⭐ `SEAT-FR-167` | `L14` | ⭐ **Authoritative** |
| `S1` as a separate reduced surface | ⭐ `SEAT-FR-275` | §15.2 | ⭐ **Authoritative** |
| Parent read-only mirror | ⭐ `SEAT-FR-274` | `P1` | ⭐ **Authoritative** |
| ⛔ No `G7` override anywhere | ⭐ `SEAT-BR-014`, `SEAT-XC-004` | §14.6 | ⭐ **Authoritative** |
| Absent-not-disabled for permissions | ⭐ `SEAT-FR-107` | §14.4 | ⭐ **Authoritative** |
| Presets surfaced on `L1` | ⭐ `SEAT-FR-258` *(the 12 exist)* | `L19` placement | ⚠️ **Hypothesis** — `DD4-HYP-005` |
| Zone-sectioned list, ⛔ no pan/zoom | ⭐ `SEAT-NFR-005` bounds inventory | §27.2 | ⚠️ **Hypothesis** — `DD4-HYP-002` |
| *"Bookings not used"* framing | ⛔ **No ratified source** | `S4` | ⚠️ **Hypothesis** — `DD4-HYP-004`, `DD4-TBD-008` |
| Tier labels *"who holds the right"* vs *"presence"* | ⭐ `SEAT-FR-041` distinction | `L2` | ⚠️ **Hypothesis** — `DD4-HYP-003` |
| Auto-assign criteria shown pre-decision | ⭐ `SEAT-FR-184` requires post-hoc recording | `L18` | ⚠️ **Design decision** extending a requirement |
| Progressive zone rendering | ⭐ `SEAT-NFR-005` non-linearity bar | §19.2 | ⚠️ **Design decision** |
| Drag alternative on `L3` | ⛔ No Liboora source | §16.6 | ⚠️ **Design decision**, methodology-supported |
| One-handed / low-light choices | ⛔ No Liboora source; ⭐ `theme.dart` comment | §8.2 | ⚠️ **Assumption + evidence** |

⛔⛔ **Validation required — no direct user research evidence available** for
every row marked ⚠️ **Hypothesis**. ⛔ **No fake evidence is created.**

### 25.2 ⭐ What validation would look like — ⛔ NOT a claim that it happened

| # | Hypothesis | Proposed method |
|---|---|---|
| 1 | `DD4-HYP-001` seat-change distress | Interviews with students who have changed seats |
| 2 | `DD4-HYP-002` list vs canvas | Task test on a low-end Android with a 100-seat hall |
| 3 | `DD4-HYP-003` `Occupied` misread | Comprehension test with Reception staff |
| 4 | `DD4-HYP-004` no-show framing | Framing A/B with the threshold and fallback present vs absent |
| 5 | `DD4-HYP-005` preset usage | Instrumented preference measurement |

⭐ Also required before implementation: ⚠️ `DD4-TBD-001`…`008` decided by their
named owners; ⛔ and `SEAT-CONFLICT-001` dispositioned by the Architecture Owner.

---

## 26. Figma Readiness

### 26.1 ⭐ Frame / screen inventory — 29

⭐ One Figma frame per surface in §11, grouped:
⭐ **APP 2 · Map & card** — `L1`, `L2` ·
⭐ **APP 2 · Counter** — `L5`…`L11`, `L18` ·
⭐ **APP 2 · Control** — `L12`…`L17` ·
⭐ **APP 2 · Structure** — `L3`, `L4`, `L21`, `L22`, `L23` ·
⭐ **APP 2 · Read** — `L19`, `L20`, `L24` ·
⭐ **APP 1** — `S1`, `S2`, `S3`, `S4`, `P1`.

### 26.2 ⭐ Component inventory

⭐ **6 reused** *(`MetricTile`, `SectionHeader`, `Pill`, `Monogram`, `EmptyState`, `PanelCard`)* ·
⭐ **4 new proposed** *(`SeatChip`, `TwoAxisPresenceBlock`, `StudentSeatChip`, `LayoutEditorCanvas`)* ·
⛔⛔ **1 prohibited** *(`MeterBar`)*.

### 26.3 ⭐ State variants to draw

⭐ 4 `SeatState` × lock 2 · ⭐ 4 presence *(1 **blocked**, drawn as the
"not available" substitution)* · ⭐ overstay badge · ⭐ 4 allocation · ⭐ 5 request
· ⭐ 2 maintenance · ⭐ plus per-surface loading / empty / error / stale /
permission-denied.

### 26.4 ⭐ Prototype connections

⭐ `L1`→`L2`→{`L5`,`L6`,`L7`,`L10`,`L11`,`L12`,`L13`,`L14`,`L15`,`L20`} ·
⭐ `L1`→`L19` · `L1`→{`L3`,`L16`,`L17`,`L18`} · ⭐ `L24`→{`L8`,`L9`,`L14`} ·
⭐ `L23`→{`L21`,`L22`,`L4`} · ⭐ `S4`→`S3`, `S4`→`S1`→`S2` · ⭐ `P1` terminal.

### 26.5 ⭐ Annotations each frame must carry

⭐ Surface ID · app · roles · permission · scope · the `SEAT-*` identifiers ·
⚠️ **every unratified token marked `PLACEHOLDER`** · ⛔ the `SEAT-BLOCK-001`
substitution labelled as a **blocked state**, not a designed one.

### 26.6 ⭐ Per-surface Figma classification

| Class | Count | Surfaces |
|---|---|---|
| ⭐ **Figma-ready** | **27** | `L1`, `L3`…`L24`, `S1`…`S4`, `P1` |
| ⚠️ **Figma-ready with explicit substitution** | **1** | ⭐ **`L2`** — 🔵 `ATTENDED · LEFT` drawn as the ⚪ *"not available for this seat"* substitution, ⭐ **labelled as blocked** |
| ⛔ **Blocked** | **0** | — |

⚠️ **Note:** 27 + 1 = 28. ⭐ `L2` appears once in the substitution row; the
remaining count excludes it. ⭐ **Total = 29.**

### 26.7 ⛔⛔ Figma gate verdict — **NOT OPEN**

⛔⛔ **No Figma file exists** — measured, the same repository fact as for
`DD-0001`/`DD-0002`/`DD-0003`.
⛔⛔ **And the gate is NOT opened merely by this document existing.**

| # | Hard blocker | Owner |
|---|---|---|
| 1 | ⚠️ **`DD4-TBD-001`** — ⛔ **no ratified token values** for 8 state renderings + 2 badges. ⭐ A prototype would either invent colours or ship greys | Design Owner |
| 2 | ⚠️⚠️ **`DD4-TBD-002`** — ⛔⛔ **`PRD-007` ratifies NO accessibility requirement**, and ⭐ `SEAT-FR-103` is **colour-primary**. ⭐ `docs/design/ACCESSIBILITY.md` is *"**RECOMMENDED**… Target **TO BE DECIDED**"* | Accessibility Owner |
| 3 | ⛔⛔ **`SEAT-CONFLICT-001`** — ⭐ a `L2` prototype annotated with its data source would have to **name a withdrawn edge** or **silently omit the provenance**. ⛔ **Both are wrong** | Architecture Owner |
| 4 | ⛔ **`SEAT-BLOCK-001`** — ⭐ a Seat Card prototype must either show a state the system **cannot compute**, or **omit** one `SEAT-FR-103` requires. ⛔ **Both are wrong** without the substitution being approved | Architecture Owner |
| 5 | ⛔ **This document is `PROPOSED`, not approved** | Product Owner |

⛔⛔ **This document creates no Figma file, no frame, no component library and no
prototype.**

---

## 27. Mobile Seat-Map Behaviour

⛔⛔ **No numeric dimension or breakpoint is invented.** ⚠️ Where a number would be
needed it is marked **UNRATIFIED DESIGN VALUE / VALIDATION REQUIRED**.

### 27.1 ⭐ Portrait mobile, small screens

⭐ `L1` is **vertically scrolling** with zone sections; ⭐ Tier 1 summary, Tier 2
presets, Tier 3 grids, Tier 4 legend.
⭐ Primary actions open as **bottom sheets** *(thumb reach)*.
⚠️ **Exact grid column count per width: UNRATIFIED DESIGN VALUE** — ⭐ chips
`Wrap` to available width rather than assuming a column count.

### 27.2 ⭐⭐ Dense layouts — why a list, not a canvas

| Consideration | Decision |
|---|---|
| ⭐ `SEAT-NFR-005` bounds inventory at **50 floors × 100 zones** | ⭐ A single interactive canvas over that space is not usable on a phone |
| ⭐ Existing implementation already groups by zone *(`seat_map_page.dart:34`)* | ⭐ **IMPLEMENTATION EVIDENCE** that the shape is workable |
| ⭐ List virtualisation | ⭐ Reused; ⛔ a free canvas forfeits it |

⚠️ **DESIGN DECISION** on ⚠️ `DD4-HYP-002`. ⛔ **Not a requirement.**

### 27.3 ⭐ Zoom / pan — where it applies and where it does not

| Surface | Zoom / pan |
|---|---|
| ⭐ `L1` Seat map | ⛔⛔ **NO.** ⭐ Vertical scroll only — §27.2 |
| ⭐ `L3` Layout editor | ⭐ **YES, required by the task** — ⭐ but **zone-scoped**, so the canvas is one hall. ⚠️ Zoom bounds: **UNRATIFIED DESIGN VALUE** |
| ⭐ `S1` Availability | ⛔ **NO** — same shape as `L1` |

### 27.4 ⭐ Seat selection and selected-seat focus

⭐ Single tap selects and opens `L2` *(`L1`)* or selects for booking *(`S1`)*.
⭐ Selected state is **visually distinct and announced**; ⛔ never colour-only.
⭐ `L3` uses **select-then-act**, ⛔ not tap-to-move, so a tap never
re-positions a seat by accident.

### 27.5 ⭐ Accidental taps and nearby seats

| Risk | Mitigation | Class |
|---|---|---|
| ⭐ Adjacent chips in a dense grid | ⚠️ **Hit-area minimum: `DD4-TBD-004`** — ⛔ this document fixes no number | ⚠️ **TBD** |
| ⭐⭐ Accidental **destructive** action | ⭐ Release requires a **mandatory reason** (`SEAT-FR-060`) and Maintenance-Release needs **confirmation** (`SEAT-FR-167`) — ⭐ both are requirement-level protections | ⭐ **REQUIREMENT** |
| ⭐ Accidental assign | ⭐ `SEAT-FR-056` forces **explicit student selection** — ⛔ a stray tap cannot assign | ⭐ **REQUIREMENT** |
| ⭐ Press feedback that shifts layout | ⛔ Prohibited — §19.2 | ⚠️ **DESIGN DECISION** |

### 27.6 ⭐⭐ Scrolling vs map interaction — the `L3` gesture conflict

⭐⭐ **Measured problem:** `SEAT-FR-029` requires drag-to-reposition, and a
scrolling parent competes for the same gesture.

| Decision | Rationale |
|---|---|
| ⭐ `L3` is a **separate surface** from `L1`, ⛔ not an edit mode inside it | ⭐ Prevents drag/scroll collision entirely — §6 row 3 |
| ⭐ `L3` uses **explicit select-then-drag** | ⭐ A long-press-to-arm gesture makes the drag intentional |
| ⭐⭐ **Cross-zone drag is structurally impossible** | ⭐ `SEAT-FR-297` makes a zone change a **container** operation that ⛔ **must be refused** while allocated — ⭐ so the canvas offers no cross-zone target at all, ⛔ rather than rejecting the gesture after the fact |
| ⭐ Non-drag alternative always present | §16.6 |

### 27.7 ⭐ Loading · stale · empty · error recovery

| State | `L1` | `L3` | `S1` |
|---|---|---|---|
| Loading | ⭐ Progressive by zone | Canvas skeleton | Progressive by zone |
| Stale | ⭐ As-of on Tier 1 (`SEAT-FR-246`) | Version label | As-of |
| Empty | ⭐ `EmptyState` + `L3` action *(if authorised)* | *"No seats in this hall yet"* | Neutral empty |
| Error | ⭐ Tier 1 unavailable; ⭐ zones still render (`SEAT-FR-106`) | ⭐ Whole-layout rejection with the reason (`SEAT-FR-034`) | Marked unavailable |
| Recovery | ⭐ **Refresh & retry**; ⭐ resynchronise **from current state** (`SEAT-NFR-006`) | Discard or fix-and-save | Refresh |

---

## 28. Final Readiness Verdict

> ## ⭐⭐ **READY WITH EXPLICIT DESIGN GAPS**

### 28.1 ⭐ Why not `NOT READY`

| Test | Result |
|---|---|
| Are the surfaces enumerable from authority? | ⭐ **YES** — 29, each traced |
| Are the flows specified? | ⭐ **YES** — 14 of 14 |
| Are the states fixed by the source? | ⭐ **YES** — 21 across 6 axes |
| Are the edge cases dispositioned? | ⭐ **YES** — 34 of 34 |
| Are permissions authoritative? | ⭐ **YES** — a closed 24-row matrix |
| Is the app boundary determinate? | ⭐ **YES** — APP 3 = 0, from 5 sources |
| Can most of it be designed now? | ⭐ **YES** — **28 of 29** surfaces fully |

### 28.2 ⭐ Why not `READY`

| Blocker | Scope |
|---|---|
| ⛔ `SEAT-BLOCK-001` | ⭐ **1 field of 1 surface** |
| ⛔⛔ `SEAT-CONFLICT-001` | ⭐ `L2`'s provenance annotation |
| ⚠️ `DD4-TBD-001`/`002` | ⭐ Token values + the a11y standard |
| ⚠️ `DD4-GAP-001`/`002`/`003` | ⭐ 3 measured source silences |

### 28.3 ⛔⛔ What this document does NOT claim

| ⛔ Not claimed | Why |
|---|---|
| ⛔⛔ **APPROVED** | ⭐ Status is `PROPOSED`; ⛔ no approval exists |
| ⛔⛔ **FROZEN** | ⭐ Design Docs are **UNRANKED**; ⛔ freeze is conferred, not claimed |
| ⛔⛔ **CONFLICT-FREE** | ⛔ **3 open conflicts** — §22 |
| ⛔⛔ **FULLY IMPLEMENTATION-READY** | ⛔ 11 deviations · 1 blocking gap · 8 TBDs · 0 of 226 AC tested |
| ⛔⛔ **TESTED** | ⛔ Written by **inspection**; `flutter test` **not run** for it |
| ⛔ **Figma-open** | ⛔ 5 hard blockers — §26.7 |

---

## 29. Changelog

| Version | Date | Change |
|---|---|---|
| ⭐ **v0.1** | 2026-09-16 | **Created.** First Design Doc for `BC-04` Seating, written after the **BC-04 Seat Management Design Readiness Audit** returned **REQUIRED** and was accepted by the Product Owner. ⭐⭐ **Records that `docs/35-design/README.md`'s prior ⚪ NOT REQUIRED classification rested on a mis-stated instrument** — the literal word `UI` occurs **once** in `PRD-007`, while §13 *"The seat card"* and §5.3 *"The layout editor"* are **whole mandated surface sections** (§1.2). ⭐ Specifies **29** surfaces *(24 APP 2 · 5 APP 1 · ⛔ **0** APP 3)*, **14** flows, **21** states across **6** axes, **34** dispositioned edge cases, a **24-row** Role × Surface matrix and a **20-row** privacy visibility matrix. ⭐ Declares all five §2B.3 boundary items and runs a **13-check** App-Boundary QA. ⭐⭐ **Preserves rather than resolves:** ⛔ `SEAT-CONFLICT-001` *(`PRD-007` L867 cites withdrawn `E-27`; `ADR-0033` **Accepted** withdrew it; BC Map measures **26** edges `E-01`…`E-26`)* · ⛔ `SEAT-CONFLICT-002` *(6 stale `E-27` citations in `DD-0003`, incl. L140's wrong "Transport is lawful")* · ⚠️ `SEAT-CONFLICT-003` *(4 stale status citations)* · ⛔ `SEAT-BLOCK-001` *(🔵 `ATTENDED · LEFT`)* · ⭐ **13** `SEAT-GAP-*` · ⭐ **3** new `DD4-GAP-*` · ⚠️ **8** `DD4-TBD-*` · ⚠️ **5** `DD4-HYP-*` · ⚠️ **11** `AIV-S*` deviations. ⛔⛔ **`MeterBar` prohibited** on its owning PRD's own authority (`SEAT-FR-245`, `SEAT-XC-018`). ⭐ 2D/2.5D/3D = **24/5/0**. ⭐ UI/UX Pro Max used as **unranked methodology only** — ⛔ its Riverpod guidance **refused** against Liboora's measured Provider dependency, ⛔ its landscape and dark-mode rules **filtered out**, ⛔ its `flutter 3.44.x` rows **version-gated** against Liboora's **3.35.4**. ⛔⛔ **No PRD, ADR, architecture document, TS, source file, test or existing Design Doc was modified.** ⛔ **No Figma created.** ⛔ **0 of 100 tasks and 0 of 226 acceptance criteria proven by test.** Verdict ⭐ **READY WITH EXPLICIT DESIGN GAPS**; Figma gate ⛔⛔ **NOT OPEN** |

---

<!-- End of DD-0004 -->
