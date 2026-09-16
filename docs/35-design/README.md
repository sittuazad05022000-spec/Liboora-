<!-- LIBOORA Design Documentation | central Design Doc space -->

> This README defines where Design Docs live and how they are named. It is
> **documentation about documentation**. It does **not** amend product
> requirements, architecture decisions, bounded-context ownership,
> permissions, ranks, precedence or backend contracts, and it confers no
> authority that the governance layer has not already conferred.

# Liboora — Design Documentation (`docs/35-design/`)

| Field | Value |
|---|---|
| **Purpose** | The single home for new Liboora **Design Docs** |
| **Status** | `PROPOSED` — structure and conventions, pending Founder/Product Authority approval |
| **Rank** | **UNRANKED.** Carries no precedence over any ranked document |
| **Created at** | `9379676` |

---

## 1. Purpose

A **Design Doc** records *how* a feature will be built: the shape of the
solution, the options considered, the trade-offs taken, and the consequences.
It sits between a requirement (*what* and *why*) and the code (*the thing
itself*).

This directory exists so that a Design Doc has **one predictable location**
instead of being invented next to whichever file its author happened to be
editing.

**A Design Doc is not authority.** It is unranked. Where a Design Doc
disagrees with any ranked document — a PRD, an ADR, the Bounded Context Map,
the Module Dependency Matrix — **the ranked document wins and the Design Doc
is the defect.** This mirrors the framing `ADR-0131` applied to Technical
Specifications, which are *"governed but UNRANKED"* and *"lose any
disagreement with a ranked document by default."*

---

## 2. Structure

Organised by **bounded context / module**, so a reader who knows which part
of the product they are working on knows where to look.

```
docs/35-design/
├── README.md            ← this file
├── membership/          BC-02 Membership
├── student-management/  BC-01 Enrollment
├── attendance/          BC-03 Attendance
├── seat-management/     BC-04 Seating
├── fees-finance/        BC-05 Fee, and revenue/finance concerns
└── shared/              genuinely cross-cutting designs only
```

The subdirectories were created **empty by design**, and this README creates
no Design Doc: whether a feature needs one is a **feature-specific and
governance-specific judgement**, not something a directory layout decides.

New contexts get a new subdirectory when a Design Doc for them is actually
written — not pre-emptively.

⚠️ **One context directory now carries its own `README.md`, and it is an
index rather than a design.** ⭐ [`attendance/README.md`](attendance/README.md)
restates `DD-0003`'s status, readiness, app boundary, blockers and
constraints for a reader who opens the directory directly. ⛔ **It confers
nothing** and ⛔ creates no requirement, role, permission, surface or status;
⛔ where it and `DD-0003` disagree, **`DD-0003` wins and the index is the
defect.** ⛔ A context README is **not** required, and ⛔ its absence elsewhere
is **not** a defect — ⭐ §2's judgement rule above still governs.

### 2.1 When `shared/` is correct, and when it is not

`shared/` is for a design that genuinely spans contexts and cannot be
attributed to one owner — a cross-cutting concern, a convention applied
everywhere, a pattern several modules follow.

⛔ **`shared/` is not an "unsure" bucket.** A design that affects two contexts
usually still *belongs* to one of them. Filing it in `shared/` makes it
nobody's, and an unowned design document is one nobody maintains. If you
cannot name the owning context, that is a signal to resolve the ownership
question first — not to file the ambiguity.

---

## 2A. ⭐ Central Design Doc catalog

⭐⭐ **This section is the catalog of every Design Doc in the repository.** A
reader should be able to answer *"what feature-level design exists, and how
far has it travelled?"* from this one table.

⛔⛔ **It registers. It confers nothing.** ⛔ No status, approval, freeze,
rank or readiness is conferred, implied or claimed here. Each cell restates a
fact measured in the named source; where a cell and its source disagree,
**the source wins and this row is the defect.**

| DD ID | Feature / Bounded context | ⭐ App + Role(s) | PRD | Design Doc | DD status | Figma status | TS status | Readiness note |
|---|---|---|---|---|---|---|---|---|
| ⭐ **`DD-0001`** | **`BC-02` Membership Management** *(`membership/`)* | ⚠️ **Not declared** — written before §2B. §4.1 separates two audiences (staff + student), but ⛔ **no APP + ROLE BOUNDARY section exists** and ⛔ no boundary audit has been run (§2B.6) | [`PRD-005`](../30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md) — **`FROZEN` v1.4** (`ADR-0019`); designed from ⭐ **§20, 13 `MUST`/`MUST NOT` surface rows** | [`DD-0001-membership-management-surface-design.md`](membership/DD-0001-membership-management-surface-design.md) — **v0.2**, 13 surfaces `S-1`…`S-13` | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** **UNRANKED** | ⛔ **No Figma file exists.** The repository holds [`FIGMA_FOUNDATION.md`](../design/FIGMA_FOUNDATION.md) only, whose token names and values are themselves `TO BE DECIDED`. ⭐ `DD-0001` §19.1 judges prototyping **READY — with 2 labelled substitutions** (token values, reference width) | ⛔ **None.** ⛔ No `TS-*` covers `BC-02`: `docs/50-technical/` holds `TS-001` (`PRD-021B`) and `TS-002` (`PRD-021C`) only, and the central `TS-*` inventory ([`TRACEABILITY_MATRIX.md`](../40-implementation/TRACEABILITY_MATRIX.md) §2V) registers `TS-001` alone. ⭐ `DD-0001` §19.2: **NOT READY** — and ⛔ **no `TS-003` is created, implied or authorised** | ⛔ **Not implementable today.** All **5** `app`-module surface tasks (`IMPL-409`/`432`/`433`/`434`/`436`) are blocked by `ADR-0012` §3.4 — `DD-0001` §17.1. **12** gaps open (§18); surface test coverage measured **0** |
| ⭐ **`DD-0002`** | **`BC-01` Enrollment — Student Management** *(`student-management/`)*; ⭐ also Master PRD §8 **module 3** Library Member Directory as `PRD-004` §5's **read composition** | ⚠️ **Not declared** — written before §2B. §4.1 separates staff / `TR-4` own-only / `TR-5` denied and §14.3 assigns all **12** `SM-PO-*` by role, but ⛔ **no APP + ROLE BOUNDARY section exists** and ⛔ no boundary audit has been run (§2B.6) | [`PRD-004`](../30-product/student-management/Student_Management_PRD_v1.md) — **`FROZEN` v1.2** (`ADR-0018`); ⚠️ **no UI/UX chapter** — designed from ⭐ **§5's 35 `LMD-*` display requirements**, §8.2's closed **12×5** permission matrix and §9.2's **16** pre-specified edge cases | [`DD-0002-student-management-surface-design.md`](student-management/DD-0002-student-management-surface-design.md) — **v0.1a**, 14 surfaces `S-1`…`S-14` | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** **UNRANKED** | ⛔ **No Figma file exists** — same repository fact as `DD-0001`. ⭐ `DD-0002` §21.1 judges prototyping **READY WITH NON-BLOCKING GAPS**, with the **same 2** labelled substitutions (token values, reference width) | ⛔ **None.** ⛔ No `TS-*` covers `BC-01` — the inventory at [`TRACEABILITY_MATRIX.md`](../40-implementation/TRACEABILITY_MATRIX.md) §2V registers `TS-001` alone. ⭐ `DD-0002` §21.2: **NOT READY** — and ⛔ **no `TS-003` is created, implied, authorised, allocated or reserved** | ⭐⭐ **0 BLOCKING design gaps.** ⚠️ But ⛔ **not implementable today**: **2** `REQUIREMENT CONFLICT`s between the frozen PRD and shipped code (`GAP-011`, `GAP-012`), and the existing surface contributes **2** of the **9** live boundary violations, which `TASK-D10` does **not** clear (§17.1). **12** gaps (10 non-blocking + 2 conflicts); surface test coverage measured **0** |
| ⭐⭐ **`DD-0003`** | **`BC-03` Attendance** *(`attendance/`)* — aggregate `AttendanceDay`, ⭐ *one student-day, not one punch* | ⭐⭐ **DECLARED — the first Design Doc to carry one.** ⭐ **APP 1** Student App (`TR-4` Student · `TR-5` Parent) **+ APP 2** Library App (`TR-1` Owner · `TR-2` Manager · `TR-3` Reception). ⭐⭐ **APP 3 = 0 surfaces**, measured from `ATT-FR-003` (five **tenant** roles, ⛔ *"MUST NOT define, introduce, extend or infer any role"*), `ATT-FR-005` (closed 3-scope register) and `AUTH-2.5`. ⭐ §3 states all **five** §2B.3 declarations; ⭐ §4 runs the **13-check** App-Boundary QA | [`PRD-006`](../30-product/attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md) — **`FROZEN` v1.9, Rank 3** (`ADR-0034`, `BASELINE-2026-08-05-A`), 3216 lines, **525** identifiers; ⚠️ **no UI/UX chapter and 0 literal `UI`/`UX`/`screen`** — designed from ⭐ **§23.4a's 6 presence renderings**, ⭐ **§10A.1's 9-status vocabulary**, ⭐ §14.1's **4-row** state table, ⭐ §25's **19** signals + **4 mandated silences**, ⭐ §10A.10 *"The student experience"* and ⭐ **§30.20's `ATT-AC-214`…`222`** | [`DD-0003-attendance-surface-design.md`](attendance/DD-0003-attendance-surface-design.md) — **v0.1**, **32** surfaces `S-S1`…`S-S14` · `S-P1`…`S-P2` · `S-L1`…`S-L15` *(incl. ⭐ `S-L8a`)*; 17 flows, 26 states on **4 axes**, 34 edge cases | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** **UNRANKED** | ⛔⛔ **No Figma file exists** — same repository fact as `DD-0001`/`DD-0002`. ⭐ `DD-0003` §32 judges the gate ⛔ **NOT OPEN**, and ⛔ **not opened merely by this document existing**: **4 hard blockers** — ⚪ `DBT-001` token values · ⚪ the unratified accessibility standard · ⛔⛔ `ATT-GAP-002a` *(a Seat Card prototype would have to show states the system cannot compute, or silently omit 2 required renderings — **both wrong**)* · ⚪ `DD3-GAP-001`/`002` *(label authority)* | ⛔ **None.** ⛔ No `TS-*` covers `BC-03` — the inventory at [`TRACEABILITY_MATRIX.md`](../40-implementation/TRACEABILITY_MATRIX.md) §2V registers `TS-001` alone. ⛔ **No `TS-003` is created, implied, authorised, allocated or reserved** | ⭐ **READY WITH EXPLICIT DESIGN GAPS** — ⭐⭐ **23 of 32 surfaces designable now**; **48** requirement groups `COVERED`. ⛔ **3 BLOCKING gaps, each blocking only its named subset**: `ATT-GAP-002a` *(booked-shift input — `ADR-0029` **`Proposed`**; removes 3 statuses + 2 renderings + axis 2 of `ATT-AC-222`)* · `ATT-FR-064` *(Face)* · `ATT-FR-080` *(OCR)*. ⚠️ Also **12** non-blocking, ⚪ **6** `DD3-GAP-*`, ⚠️ **9** implementation deviations *(incl. ⛔ `AIV-05` — `AccessRole.student` holds **no** `recordAttendance`, so a student cannot self-attend in current code)*, ⛔ 1 inherited conflict `ATT-GAP-015`, ⚠️ 1 source defect `DD3-DEFECT-001`. ⛔⛔ **0 of 222 acceptance criteria proven by test**; surface test coverage measured **0** |

### 2A.1 How to read the `Figma status` and `TS status` columns

⛔ **Neither column is a plan, a schedule or a commitment.** Both report
**presence or absence of an artifact**, plus whatever readiness the Design
Doc itself has *recorded about its own inputs*. Neither authorises the
downstream artifact:

* A **Figma file** is produced under [`../design/FIGMA_FOUNDATION.md`](../design/FIGMA_FOUNDATION.md)
  and [`../design/DESIGN_ENGINEERING_HANDOFF.md`](../design/DESIGN_ENGINEERING_HANDOFF.md),
  not by a row in this table.
* A **`TS-*`** enters Stage `6A` only on an **ADR-borne conferral**
  (`ADR-0131`). ⛔ A Design Doc is **UNRANKED input, never authority**, so no
  entry here moves a TS one step closer to existing.

⚠️ ⛔ **Do not populate either column by inference.** If no artifact exists
and no source records its state, the cell reads **absent** — an invented
status is worse than an empty one.

### 2A.2 Maintaining this catalog

0. ⭐⭐ **The `App + Role(s)` cell is mandatory for every new row**, and it
   restates the Design Doc's own **APP + ROLE BOUNDARY** section (§2B.3).
   ⛔ A new row reading *"Not declared"* is a defect, not a status — the two
   existing rows carry it only because they predate §2B (§2B.6).
1. A **new Design Doc adds exactly one row**, at the time the Design Doc is
   committed — not when it is planned.
2. `NNNN` comes from §3 and is **never reused**, so a row is never renumbered
   and never deleted; a `SUPERSEDED` Design Doc keeps its row and names its
   successor.
3. ⛔ **Never edit a status cell to match an expectation.** Status is
   conferred in the governing document and *restated* here. Correct the
   source, then the row.

### 2A.3 ⭐ Coverage — which contexts have a Design Doc, and why

⚠️ **§2's paragraph once read *"No Design Doc has been written for any
module"*. That was correct when written and is now false for `membership/`,
`student-management/` and ⭐ `attendance/`; it has been corrected rather than
deleted.**

The **discriminator is measured, not editorial**: a Design Doc can only be
written where a frozen PRD actually fixes surface requirements, because
inventing them is the untraceable design claim
[`../design/PRD_DESIGN_TRACEABILITY.md`](../design/PRD_DESIGN_TRACEABILITY.md)
§3 rejects.

⚠️⚠️ **The discriminator stands; the *instrument* was wrong once and is
corrected.** An earlier revision of this table scored each context by its
PRD's **UI/UX section**, and recorded `student-management/` as **0**. ⭐ That
was true of the *section* and false of the *content*: `PRD-004` has **no**
UI/UX chapter and **0** literal `UI`/`UX` occurrences, yet its §5 carries
**35** `LMD-*` requirements governing a screen — pagination, search,
filters, sorting, composition, status indicators, empty-vs-unavailable and
bulk caps. ⭐ **A PRD can fix surface requirements without a section named
for them**, so the column below now reads **surface requirements**, not
*UI/UX section*. ⛔ The other four rows were re-measured under the corrected
instrument and are **unchanged**.

| Context | Design Doc | Frozen PRD's surface requirements | Disposition |
|---|---|---|---|
| `membership/` | ⭐ [`DD-0001`](membership/DD-0001-membership-management-surface-design.md) **v0.2** | ⭐ **`PRD-005` §20 — 13 `MUST`/`MUST NOT` surface rows** | **WRITTEN** — see §2A |
| ⭐ `student-management/` | ⭐ [`DD-0002`](student-management/DD-0002-student-management-surface-design.md) **v0.1a** | ⭐⭐ **`PRD-004` §5 — 35 `LMD-*` display requirements** *(⛔ no UI/UX section; ⛔ 0 literal `UI`/`UX`)*, plus §8.2's closed **12×5** permission matrix and §9.2's **16** edge cases | **WRITTEN** — see §2A |
| ⭐ `attendance/` | ⭐ [`DD-0003`](attendance/DD-0003-attendance-surface-design.md) **v0.1** | ⭐⭐ **`PRD-006` §23.4a — 6 named presence renderings** *(🟢 PRESENT · 🟡 PRESENCE CHECKING · ⚪ NOT PRESENT · 🟡 OUTSIDE SHIFT WINDOW · 🔴 SHIFT OVERSTAY · 🟠 NO BOOKED SHIFT)*, a **MUST NOT collapse** rule and §30.20's `ATT-AC-214`…`222`; plus ⭐ §10A.1's **9-status vocabulary**, §14.1's **4-row** state table, §25's **19** distinguishable signals and **4 mandated silences**, and ⭐ §10A.10 *"The student experience"*. ⛔ **0** literal `UI`/`UX`/`screen` | ⭐⭐ **WRITTEN** — ⭐ the third case proving the corrected instrument: a PRD with **0** occurrences of *"UI"* was the **most** surface-prescriptive of the five. See §2A |
| `seat-management/` | — | **0** — 8 UI occurrences, ⛔ **every one a prohibition** | ⛔ Not written |
| `fees-finance/` | — | 1 — `PRD-008` §42.7, ⛔ an express statement of **absence** | ⛔ Not written |
| `shared/` | — | n/a | ⛔ Empty — see §2.1 |

⭐⭐ **Their absence is NOT a defect, and an empty subdirectory is NOT a
missing Design Doc.** Two rules already settle this and neither is relaxed
here:

* ⛔ **A feature does not automatically require a Design Doc.** §5.1 —
  *"It is not a precondition of implementation."* No governance rule requires
  a Design Doc before code.
* ⛔ **The directory layout decides nothing.** The subdirectories were created
  empty by design (§2); whether a feature needs a Design Doc is a
  **feature-specific and governance-specific judgement**.

A Design Doc becomes writable for those contexts when their PRD gains surface
requirements — or when a named product office supplies them. ⛔ Until then,
writing one would manufacture the appearance of progress, which §5.1 forbids.

### 2A.4 Design roadmap

⛔⛔ **This is a status record, not a plan or a commitment.** ⛔ No schedule,
order or obligation is created, and ⛔ **`NOT REQUIRED` is a legitimate
terminal state** — §2A.3 and §5.1 both hold that a feature does **not**
automatically require a Design Doc.

| Context | Status | Basis |
|---|---|---|
| `membership/` | ⭐ **COMPLETE** | `DD-0001` **v0.2** — Figma-ready with 2 labelled substitutions |
| ⭐ `student-management/` | ⭐ **COMPLETE** | `DD-0002` **v0.1a** — 0 BLOCKING design gaps; ⚠️ 2 `REQUIREMENT CONFLICT`s escalated |
| ⭐ `attendance/` | ⭐ **COMPLETE** | ⭐⭐ **Audited, then designed.** `DD-0003` **v0.1** — ⭐ **READY WITH EXPLICIT DESIGN GAPS**: **32** surfaces (⭐ **23 designable now**), 17 flows, 26 states on **4 axes**, 34 edge cases, 19 failure signals, 4 mandated silences. ⭐ **3 BLOCKING gaps, each blocking only its named subset** — `ATT-GAP-002a` (booked-shift input, `ADR-0029` `Proposed`) · `ATT-FR-064` (Face) · `ATT-FR-080` (OCR). ⭐ Source measured **`FROZEN` v1.9, Rank 3, 3216 lines**, `ADR-0034` under `BASELINE-2026-08-05-A`, **525** identifiers. ⚠️ **A prior revision of this row was WRONG and is corrected rather than quietly replaced:** it read *"`PRD-006` is **unwritten** (`SM-GAP-9` records this)"* — ⛔ `SM-GAP-9` says no such thing; it records that the *attendance-percentage **formula*** has no owner |
| `seat-management/` | ⚪ **NOT REQUIRED** *(on current evidence)* | ⭐ All **8** UI occurrences in its PRD are **prohibitions**; ⛔ a prohibition fixes no surface to design |
| `fees-finance/` | ⚪ **NOT REQUIRED** *(on current evidence)* | ⭐ `PRD-008` §42.7 is an express statement of **absence** |
| `shared/` | ⚪ **NOT REQUIRED** | ⭐ By §2.1 — cross-cutting designs only; ⛔ not an "unsure" bucket |

⚠️ **No context is marked `IN PROGRESS` or `BLOCKED`**, because ⛔ neither
is true of any context today. ⭐ Those values exist for when they are.

⚠️ **`NOT REQUIRED` is provisional on evidence, not permanent.** Should a
PRD later gain surface requirements, the row changes — which is exactly
what happened to `student-management/` (§2A.3).

---

## 2B. ⭐⭐ MANDATORY — the three-app boundary

⭐⭐⭐ **This section is BINDING on every Design Doc written from this point
forward.** It is a **standing product-owner instruction**, recorded here
because this README is the one file every Design Doc author reads.

⛔⛔ **PRIMARY PRINCIPLE — design the feature for its final app boundary
now.** ⛔ **Do NOT design one mixed-role application and plan to split the
apps later.**

### 2B.1 The three apps

| App | Roles | Scope | Code home *(already reserved)* |
|---|---|---|---|
| ⭐ **APP 1 — Student App** | `TR-4` **Student** · `TR-5` **Parent** | One student's own data, within one tenant | `lib/app/student/{student,parent}/` |
| ⭐ **APP 2 — Library App** | `TR-1` **Owner** · `TR-2` **Manager** · `TR-3` **Reception** | One library / tenant's operations | `lib/app/staff/{owner,manager,reception}/` |
| ⭐ **APP 3 — Platform Admin App** | `PR-1` **Platform Administrator** · `PR-2` **Platform Support** *(and platform-level authority where applicable)* | ⛔ **Platform-level objects ONLY** | `lib/app/platform_admin/{platform_owner,platform_admin}/` |

⭐⭐ **This boundary is not newly invented by this section — it is already
structural in the repository.** Measured: `lib/app/` contains exactly
`student/`, `staff/`, `platform_admin/` and `shared/`, with the role
subdirectories above already present, and
[`lib/app/platform_admin/README.md`](../../lib/app/platform_admin/README.md)
exists specifically to hold that boundary open *"reserved, deliberately
empty."*

### 2B.2 Authority for the roles — ⛔ never invent one

| Claim | Source | Verified |
|---|---|---|
| `TR-1`…`TR-5` are the tenant roles | [`PRD-001` Authentication **v2.0**](../30-product/authentication/Authentication_PRD_v2.md) §2.4 | ⭐ **YES** — `TR-1` Owner, `TR-2` Manager, `TR-3` Reception, `TR-4` Student, `TR-5` Parent |
| `PR-1`, `PR-2` are the platform roles, **closed** | `PRD-001` **§2.3** | ⭐ **YES** — *"Platform roles govern Liboora itself. **Two exist. The set is closed.**"* |
| ⭐⭐ Platform access does **NOT** imply tenant data access | `PRD-001` **`AUTH-2.5`** | ⭐ **YES** — *"Platform roles **MUST NOT** grant access to tenant business data"*; obtained *"only"* via time-bounded elevation |
| The platform-role set may not be widened | `PRD-012a` Part 2 `SECP-FR-003`, `SECP-XC-012` | ⭐ Recorded in `platform_admin/README.md` §1 |
| Code role enum | `AccessRole` (`lib/platform/identity/identity.dart`) | ⚠️ **5 tenant values only** — `owner`, `manager`, `reception`, `student`, `parent`; ⛔ **no platform value exists** |

⚠️⚠️ **ONE DISCREPANCY IS RECORDED RATHER THAN RESOLVED.** The standing
instruction names *"Platform Owner / platform-level authority"* for APP 3.
⛔ **"Platform Owner" has 0 occurrences** in `PRD-001`, `MASTER_PRD.md` or
`PRD-012a` Part 2 — a fact `platform_admin/README.md` §1 already measured
and records. ⭐ **Both statements are preserved:** the **app boundary** is
binding as instructed, and the **role vocabulary** for APP 3 remains
`PR-1`/`PR-2` until a named authority establishes otherwise. ⛔ A Design
Doc **MUST NOT** cite *"Platform Owner"* as an authoritative role
identifier, and ⛔ **MUST NOT** invent one. → `DSN-APP-GAP-001`, **Product
Owner + Architecture Owner**.

### 2B.3 ⭐ What every new Design Doc MUST declare

⭐ A Design Doc is **not design-ready** until it carries an
**"APP + ROLE BOUNDARY"** section stating all five:

| # | Declaration | ⛔ Not acceptable |
|---|---|---|
| 1 | **Target App** — APP 1, APP 2, APP 3, or an explicit, justified set | ⛔ "all apps" without justification |
| 2 | **Target Role(s)** — by identifier (`TR-n` / `PR-n`) | ⛔ "staff", "admin", "user" |
| 3 | **Permission Scope** — the authoritative operation×role source | ⛔ An invented or widened permission |
| 4 | **Tenant / Library / Platform scope** | ⛔ Silence on scope |
| 5 | **Cross-App dependencies**, if any | ⛔ An undeclared jump between apps |

### 2B.4 ⭐ Assignment and separation rules

1. ⭐ **Every** screen, flow, state, action and edge case is assigned to an
   app **and** a role. ⛔ An unassigned surface is a defect.
2. ⛔⛔ **MUST NOT mix role experiences for convenience.** Where apps need
   materially different UX, document them **separately within** the feature
   design.
3. ⭐ **Shared design is permitted only when genuinely cross-app *and* the
   same UX is appropriate.** ⛔ Convenience is not a justification.
4. ⛔⛔ **Permissions come from PRD / ADR / Auth sources only.** ⛔ Never
   widen a permission to make a flow easier — that is the
   `SM-8.4a`/`AP-3` deny-by-default rule, applied to design.
5. ⭐ **Parent (`TR-5`) is a Student-App role with its own scope.** ⛔ Parent
   is **NOT** a separate application.
6. ⭐ **`TR-1`/`TR-2`/`TR-3` are Library-App roles with different
   permissions**, and the design **MUST** respect the differences —
   ⛔ not render one screen and grey controls out by role as an afterthought.
7. ⛔⛔ **Platform roles stay separated from tenant operations** — `AUTH-2.5`.
   ⛔ Platform access **MUST NOT** be assumed to confer tenant
   business-data access.
8. ⭐ **Future Figma prototypes MUST preserve these boundaries.** ⛔ No one
   giant mixed-role prototype to be split later.

### 2B.5 ⭐ App-Boundary QA check — required before design-ready

⭐ Every Design Doc classifies itself, with evidence:

| Verdict | Meaning |
|---|---|
| ⭐ **PASS** | App, roles, permission scope, tenancy scope and cross-app dependencies all declared and sourced |
| ⚠️ **GAP** | A declaration is missing or unsourced; ⛔ the Design Doc is **not** design-ready until closed or classified |
| ⛔ **CONFLICT** | A source-vs-source or source-vs-code contradiction. ⛔ Record and escalate; ⛔ **do not resolve by choosing** |
| ⚪ **TO BE DECIDED** | A named authority must decide. ⛔ Inventing an answer is prohibited |

### 2B.6 ⚠️ Existing Design Docs — audit, do not rewrite

⛔⛔ **`DD-0001` and `DD-0002` are NOT rewritten automatically.** Per the
standing instruction, existing docs are **audited** and updated **only**
where the boundary audit finds a **real conflict or missing information**.

⭐ A first-pass reading, recorded without acting on it: both already
separate audiences — `DD-0001` §4.1 (two audiences) and `DD-0002` §4.1
(staff vs `TR-4` own-only vs `TR-5` denied) — and `DD-0002` §14.3 assigns a
presentation rule to all **12** protected operations by role. ⛔ **No
boundary audit has been run on either**, so ⛔ **no verdict is claimed here**
for them, in either direction.

### 2B.7 Scope of this rule

⭐ Applies to **ALL future Design Docs** — ⛔ not only Membership, Student
Management, Attendance, Seat Management and Fees & Finance.

⛔⛔ **This section confers nothing else.** ⛔ It creates no role, no
permission, no `PERM-*`, no app, no edge, no requirement; ⛔ it does not
amend `PRD-001`, any ADR, or `AccessRole`; and ⛔ it does not authorise
implementing APP 3, which `platform_admin/README.md` §3 leaves governed.

---

## 3. Naming

```
DD-NNNN-short-kebab-title.md
```

* `DD-` is the Design Doc prefix. Measured **free** when this README was
  written: **0** occurrences of `DD-NNNN` repository-wide. ⭐ Now allocated:
  **`DD-0001`**, **`DD-0002`**, **`DD-0003`** — so ⭐ **the next Design Doc is
  `DD-0004`**.
* `NNNN` is a stable, zero-padded, repository-wide sequential number. It is
  **never reused and never reassigned**, for the same reason `IMPL-*` numbers
  are not: cross-references in commits, reviews and test names outlive the
  document.
* The number is global, not per-directory, so moving a Design Doc between
  subdirectories does not renumber it.

Example: `docs/35-design/membership/DD-0001-renewal-term-calculation.md`

⚠️ `DD-*` is **distinct from `DDR-*`**. A **Design Decision Record**
(`DDR-*`) is a single durable design *choice*, registered under
[`../design/design-decisions/README.md`](../design/design-decisions/README.md).
A Design Doc is the broader *design of a feature* and may cite several DDRs.
Do not use one prefix for the other.

---

## 4. Status

Every Design Doc carries a `Status` field in its header table, using the
vocabulary already established by
[`../design/DESIGN_GOVERNANCE.md`](../design/DESIGN_GOVERNANCE.md) §2 rather
than a second competing set:

| Status | Meaning |
|---|---|
| `PROPOSED` | Written, awaiting approval. The default for a new Design Doc |
| `APPROVED` | Accepted by the applicable authority |
| `SUPERSEDED` | Replaced by a later Design Doc, which it must name |
| `TO BE DECIDED` | Blocked on a decision by a named authority |
| `CONFLICT` | Sources disagree. Preserve both facts and escalate; **do not edit the source** |

A Design Doc that is implemented does **not** become "done" and get deleted.
It is a record of why the code looks the way it does, and it stays readable.

---

## 5. Relationship to PRD / ADR / TS / IMPL

Each of these answers a different question, and none substitutes for another.

| Document | Answers | Rank | Location |
|---|---|---|---|
| **PRD** (`PRD-nnn`) | *What* the product must do, and why | Ranked (3 for module PRDs) | `docs/30-product/` |
| **ADR** (`ADR-nnnn`) | A binding decision on boundaries, ranks, edges, precedence | Ranked (2) | `docs/00-governance/adr/` |
| **TS** (`TS-*`) | The technical contract — API, schema, interface shape | **Unranked** (`ADR-0131`) | `docs/50-technical/` |
| **Design Doc** (`DD-*`) | *How* a feature will be built; options and trade-offs | **Unranked** | **`docs/35-design/`** |
| **IMPL task** (`IMPL-nnn`) | The unit of work, and the test that proves it | Unranked backlog | `docs/40-implementation/` |

### 5.1 What a Design Doc must not do

⛔ **It cannot change a requirement.** A requirement that cannot be
implemented as written is a **specification defect** — raise an amendment
(`PRD_LIFECYCLE.md` Stage 8), never silently reinterpret it in a Design Doc.

⛔ **It cannot substitute for an ADR.** A boundary, rank, edge or ownership
change is the **Architecture Owner's** to accept
(`PRD_OWNERSHIP_MODEL.md` §2.2). Recording such a change in a Design Doc does
not authorise it, and a Design Doc that reads like an ADR is an ADR that
skipped its gate.

⛔ **It cannot confer freeze, approval or baseline status.** Those are
conferred, not claimed.

⛔ **It is not a precondition of implementation.** No governance rule requires
a Design Doc before code. Stage 6A already establishes the precedent that an
inserted document stage is *"OPTIONAL and NON-BLOCKING"* and that its absence
is *"NOT a defect, NOT a blocker and NOT a regression"* (`ADR-0131` §4.3).
The same applies here. Do not treat a missing Design Doc as a blocker, and do
not write one to manufacture the appearance of progress.

---

## 6. Relationship to `docs/design/`

Both directories exist, deliberately, and they hold different things.

| | `docs/design/` | `docs/35-design/` |
|---|---|---|
| **Holds** | Design *foundation* — the design system, visual language, UX and screen architecture, accessibility, design governance, ownership, QA, DDR register | Per-feature **Design Docs** |
| **Scope** | ⭐ **Product-wide** and durable | ⭐ **Feature-level** — one feature, one context |
| **Organised by** | Concern | Bounded context |
| **Catalog** | [`../design/README.md`](../design/README.md) §coverage map | ⭐ **§2A of this file** |

⭐ **They are not duplicates and neither supersedes the other.** A Design Doc
in `docs/35-design/` *consumes* the foundation in `docs/design/` — it cites
the design system, it does not restate it, and it must not fork it. ⛔ A
document that applies product-wide belongs in `docs/design/`; ⛔ a document
about one feature's surfaces belongs here.

**`docs/design/` was deliberately left where it is.** Its 16 foundation
documents cross-link each other as **relative siblings**
(`](DESIGN_SYSTEM.md)`, `](design-decisions/README.md)`), so distributing
them across per-context subdirectories would break every one of those links
while gaining nothing: they are not per-context documents, and there is no
context to file them under. They were also measured to have **0 inbound
references** from anywhere outside their own directory, so no reader is
currently routed through a path this change could have invalidated either
way.

Moving them was considered and **rejected**: the instruction to move existing
Design Docs applies *"ONLY if doing so does not violate existing
governance/reference rules"*, and breaking sixteen documents' internal
navigation to satisfy a directory shape is a worse outcome than two
well-labelled directories.

If the design foundation should later be consolidated here, that is a
deliberate migration with link rewriting — not a side effect of creating this
space.
