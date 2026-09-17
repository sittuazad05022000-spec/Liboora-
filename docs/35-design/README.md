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
├── fees-finance/       BC-05 Fee, and revenue/finance concerns
├── analytics/           BC-26 Analytics Read Model
└── shared/              genuinely cross-cutting designs only
```

⭐⭐ **`analytics/` is the SEVENTH context directory, and the FIRST added after
the original six.** ⭐ It was created **at the moment `DD-0006` was written**,
which is exactly what the paragraph below prescribes — ⛔ not pre-emptively, and
⛔ not by a rule change. ⛔ **No governance rule restricted the context set:**
measured, **0** matches for `closed list`, `only these`, `six context`,
`may not add` or `must not add` anywhere in this README.

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
| ⭐⭐ **`DD-0004`** | **`BC-04` Seat Management** *(`seat-management/`)* — ⭐ the seat map is, by `SEAT-NFR-005`, *"the module's **primary surface**"* | ⭐⭐ **DECLARED.** ⭐ **APP 1** Student App (`TR-4` Student · `TR-5` Parent) **+ APP 2** Library App (`TR-1` Owner · `TR-2` Manager · `TR-3` Reception). ⭐⭐ **APP 3 = 0 surfaces**, measured from **five** sources — the strongest being `SEAT-FR-273`: ⛔ *"Platform Support **MUST NOT** hold any operation… by default."* ⭐ §5 states all **five** §2B.3 declarations; ⭐ §5.7 runs the **13-check** App-Boundary QA | [`PRD-007`](../30-product/seat-management/PRD-SEAT-MANAGEMENT.md) — **`FROZEN` v1.1, Rank 3** (`ADR-0020`, `BASELINE-2026-08-04-E`), 2891 lines, **683** identifiers across 10 registers; ⚠️ **no UI/UX chapter and just 1 literal `UI`** — designed from ⭐⭐ **§13 *"The seat card"*** (`SEAT-FR-103`, a **14-field** card, amended by `ADR-0032` `O-5` to **4 presence states on a separate axis** from shift conformance), ⭐ **§5.3 *"The layout editor"***, ⭐ §8's **16-gate** acquisition gate `G1`…`G16`, ⭐ §22.4's **5 work queues**, ⭐ §26's search + **12 presets**, ⭐ §28.2's closed **24-row** permission matrix and ⭐ §30's **34** edge cases | [`DD-0004-seat-management-surface-design.md`](seat-management/DD-0004-seat-management-surface-design.md) — **v0.1**, **29** surfaces `L1`…`L24` · `S1`…`S4` · `P1`; 14 flows, 21 states on **6 axes**, 34 edge cases | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** **UNRANKED** | ⛔⛔ **No Figma file exists** — same repository fact as `DD-0001`/`DD-0002`/`DD-0003`. ⭐ `DD-0004` §26.7 judges the gate ⛔ **NOT OPEN**: **5 hard blockers** — ⚪ `DD4-TBD-001` token values *(8 state renderings + 2 badges unratified)* · ⚪ `DD4-TBD-002` ⛔ **`PRD-007` ratifies NO accessibility requirement** while `SEAT-FR-103` is **colour-primary** · ⛔⛔ `SEAT-CONFLICT-001` *(an `L2` provenance annotation would have to **name a withdrawn edge** or **silently omit** the source — **both wrong**)* · ⛔ `SEAT-BLOCK-001` *(a Seat Card would have to show a state the system **cannot compute**, or **omit** one `SEAT-FR-103` requires)* · ⛔ this document is `PROPOSED` | ⛔ **None.** ⛔ No `TS-*` covers `BC-04` — the inventory at [`TRACEABILITY_MATRIX.md`](../40-implementation/TRACEABILITY_MATRIX.md) §2V registers `TS-001` alone. ⛔ **No `TS-*` is created, implied, authorised, allocated or reserved** by this row | ⭐ **READY WITH EXPLICIT DESIGN GAPS** — **28 of 29** surfaces designable now. ⚠️ ⛔ **Not implementable as designed today**: **11** implementation deviations `AIV-S01`…`AIV-S11` are recorded and ⛔ **left unfixed** (incl. ⛔⛔ `MeterBar` at `seat_map_page.dart` L72, **prohibited** by `SEAT-FR-245` — allocation rate and occupancy rate are *two distinct figures*; and ⛔ a single `Permission.assignSeat` carrying **24** distinct operations). ⭐⭐ **3 open conflicts preserved UNRESOLVED** — `SEAT-CONFLICT-001`, `SEAT-CONFLICT-002`, `SEAT-BLOCK-001`. **1 blocking + 13 non-blocking** gaps; ⛔ **0 of 100 tasks and 0 of 226 AC proven by test** |
| ⭐⭐ **`DD-0005`** | **`BC-05` Fee & Collection** *(`fees-finance/`)* — ⭐ the `FeeLedger`, whose balance is by BC Map **L374** *"**never stored independently**"* | ⭐⭐ **DECLARED.** ⭐ **APP 1** Student App (`TR-4` Student · `TR-5` Parent) **+ APP 2** Library App (`TR-1` Owner · `TR-2` Manager · `TR-3` Reception). ⭐⭐ **APP 3 = 0 surfaces**, from three sources — **`FEE-XC-016`** bars *"**any** cross-tenant financial read, write, aggregate or export"*; §23's role table is **5 tenant roles** and ⛔ *"**MUST NOT** be extended"*; §42.7 states a Platform Admin UI in the same binary *"**still cannot reach** another tenant's financial records"* | [`PRD-008`](../30-product/revenue-finance/PRD-008_REVENUE-AND-FINANCE.md) — **`FROZEN` v1.7, Rank 3** (`ADR-0049`, `BASELINE-2026-08-17-A`), 2808 lines, **249** register entries / **134** obligation-bearing; ⚠️ **no UI/UX chapter** — designed from ⭐⭐ **§16.1 `FEE-FR-062`** *(MUST itemise, MUST NOT collapse)*, ⭐ **§19 `FEE-FR-046`** *(5 profile components)*, ⭐ **§14 `FEE-BR-015`** *(visible reconciliation queue)*, ⭐ §12 Invoices, ⭐ §16 Receipts, ⭐ §21 append-only history, ⭐ §23's **10-row** matrix, ⭐ §29's **9** states and ⭐ §34's **14** edge cases. ⛔⛔ **Governed for V1 payment method by Rank 2 `ADR-0130` — CASH ONLY** | [`DD-0005-fees-finance-surface-design.md`](fees-finance/DD-0005-fees-finance-surface-design.md) — **v0.1**, **16** surfaces `F1`…`F16` | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** **UNRANKED** | ⛔⛔ **No Figma file exists** — same repository fact as `DD-0001`…`DD-0004`. ⭐ `DD-0005` §24 judges the gate ⛔ **NOT OPEN**: **5 hard blockers** — ⚪ token values unratified · ⛔⛔ **`PRD-008` ratifies NO accessibility requirement** · ⛔⛔ `FEE-CONFLICT-001` *(a payment-capture prototype would have to show UPI/card per the FROZEN PRD, or omit them per the governing ADR — **both wrong without the substitution being approved**)* · ⛔ `FEE-GAP-005` *(no correction path)* · ⛔ this document is `PROPOSED` | ⛔ **None.** ⛔ No `TS-*` covers `BC-05` — the inventory at [`TRACEABILITY_MATRIX.md`](../40-implementation/TRACEABILITY_MATRIX.md) §2V registers `TS-001` alone. ⛔ Also measured: `docs/40-implementation/revenue-finance/` **does not exist** — Stage 5 and Stage 6 were never performed. ⛔ **No `TS-*` is created, implied, authorised, allocated or reserved** by this row | ⭐ **READY WITH EXPLICIT DESIGN GAPS** — **10 of 16** surfaces designable now. ⚠️ ⛔ **Not implementable as designed today**: **5** deviations `AIV-F01`…`AIV-F05` recorded and ⛔ **left unfixed** (incl. ⛔⛔ `PaymentMode` offering **5** modes when **only `cash`** is V1-lawful, and a hard-coded **20%** discount ceiling that `FEE-BR-018` expressly forbids). ⭐⭐ **2 conflicts preserved UNRESOLVED**; **1 blocking + 6 non-blocking** gaps; ⛔ **0** surface tests |
| ⭐⭐ **`DD-0006`** | **`BC-26` Analytics Read Model** *(`analytics/`)* — ⭐ owns *"the metric/semantic layer, read-model store, projections, reports, exports"* (BC Map **L135**) and ⛔⛔ **owns NO domain fact** | ⭐⭐ **DECLARED.** ⚠️ **APP 1** Student App — ⭐ `TR-4` Student **only**; ⛔⛔ **`TR-5` Parent EXCLUDED — 0 surfaces**, a deliberate divergence from `DD-0003`/`DD-0005` because **`ANL-OBD-004`** requires a decision *"**before any guardian-facing analytic ships**"*. ⭐ **APP 2** Library App (`TR-1` Owner · `TR-2` Manager · `TR-3` Reception). ⭐⭐ **APP 3 = 0 surfaces**, from four sources — the strongest being **`ANL-INV-006`**: *"a cross-tenant read is **impossible**"*, plus `ANL-INV-007`'s closed 3-scope register which contains ⛔ **no platform scope**. ⭐ §5 states all **five** §2B.3 declarations; ⚠️ §5.4 runs the **13-check** QA and reports **12 PASS · 1 GAP** — ⛔ **NOT rounded to 13/13**, because `PRD-009` carries **no closed permission matrix** (`ANL-OBD-003` **OPEN**) | [`PRD-009`](../30-product/analytics/PRD-009_ANALYTICS_AND_REPORTS.md) — **`FROZEN` v0.6, Rank 3** (`ADR-0113` **Accepted**, 2026-09-05; baseline **L217**), 1194 lines, **144** identifiers; ⚠️ **its own header still reads `DRAFT` and claims **`Authority / NONE`** as written in its own header** — ⭐ `PRD_REGISTRY.md` §2.1 governs: *"Freeze is **not self-declared**"*, so ⭐ **it IS frozen** *(the **second** occurrence of this pattern after `PRD-008`)*. Designed from ⭐⭐ **§15's 4-row screen table** `Today → Progress → Motivation → Detail`, ⭐⭐ **`ANL-FR-027`** *(`Status → Attention → Action → Analysis`, ⛔ "not a chart wall")*, ⭐⭐ **`ANL-FR-035`** *(plain-language summary **before any chart**)*, ⭐ **`ANL-FR-018`** *(⛔ "never a zero presented as a score")*, ⭐ §18–21's per-role metric sets, ⭐ `ANL-FR-041`/`-042`/`-043` **three ratified a11y requirements** and ⭐ §41–42's edge cases. ⛔⛔ **Governed for metrics by Rank 2 `ADR-0097`** — ⭐ `ProfileViews` is the **ONLY `CertifiedMetric` in the repository**; ⛔ `UniqueViewers` **expressly NOT certified** | [`DD-0006-analytics-and-reports-surface-design.md`](analytics/DD-0006-analytics-and-reports-surface-design.md) — **v0.1**, **11** surfaces `A1`…`A4` · `B1`…`B7`; 11 states *(⭐ **7** non-value)*, 6 visualizations, 1 certified metric + 13 uncertified candidates, ⛔ **0** report instances | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** **UNRANKED** | ⛔⛔ **No Figma file exists** — same repository fact as `DD-0001`…`DD-0005`. ⭐ `DD-0006` §23 judges the gate ⛔ **NOT OPEN**: **5 hard blockers** — ⛔⛔ `DD6-GAP-004` *(13 of 14 metrics lack at least one of the nine `ANL-FR-008` fields, so a prototype must show **invented numbers** or **empty states everywhere** — **both misrepresent the system**)* · ⛔⛔ `ANL-GAP-017` *(**`PRD-009` ratifies NO contrast or type-scale target**, while `ANL-FR-041` forbids colour-only meaning)* · ⛔⛔ `DD6-TBD-005` *(⛔ **no visual vocabulary for a restated value**, while `ANL-FR-052` requires restatement to be **visible**)* · ⛔⛔ `GAP-BCMAP-BC26-EDGES` *(10 of 11 surfaces depend on events whose edges BC Map §7 does **not** declare)* · ⚪ `DBT-001` token values. ⭐ §23.2 records that **`B7` alone** would clear two of them — ⛔ **and declines to open the gate on that basis** | ⛔ **None.** ⛔ No `TS-*` covers `BC-26` — the inventory at [`TRACEABILITY_MATRIX.md`](../40-implementation/TRACEABILITY_MATRIX.md) §2V registers `TS-001` alone. ⭐ Also measured: `PRD-009`'s Stage-6 range `IMPL-2000`…`2031` exists with ⛔ **8 of 32 tasks BLOCKED**. ⛔ **No `TS-*` is created, implied, authorised, allocated or reserved** by this row. ⚠️ §18.3 routes the charting approach to a **`TS-*` / Stage 6A** decision (`DD6-TBD-011`) and ⛔ **does not make it** | ⚠️ **DESIGNED WITH EXPLICIT BLOCKERS** — ⭐⭐ **only 1 of 11 surfaces designable now** *(`B7` Profile Views)*, ⚠️ 7 partial, ⛔ 3 blocked. ⭐⭐ **The cause is architectural, not editorial: F-1 — the semantic layer `MP-GBR-36` mandates does not exist**, so 7 surfaces can be drawn but ⛔ **not populated**. ⚠️ ⛔ **Not implementable as designed today**: **7** deviations `AIV-A01`…`AIV-A07` recorded and ⛔ **left unfixed** (incl. ⛔⛔ a stale module header reading *"R5 / **BC-22** Insights"* when the manifest declares **`rank: 7`** and `BC-26` is the owner; and ⛔⛔ **`_feed`/`_attendanceDays` NOT tenant-partitioned**, against `ANL-INV-006` and BC Map **L490**, so `distinctAttendanceDays()` returns a **cross-tenant** count). ⭐⭐ **2 conflicts preserved UNRESOLVED** — ⛔⛔ `ANL-AL-B1` *(**Rank-4 vs Rank-4** over `iam.*`; ⛔ precedence **cannot** break the tie)* · ⛔⛔ `GAP-BCMAP-BC26-EDGES` *(⭐ newly carried into the design layer from BC Map §17.4)*. ⛔ **25/25 `ANL-GAP-*`, F-1/F-2/F-3 and 9/9 `ANL-OBD-*` PRESERVED OPEN**; ⭐ **12/12 `ANL-XC-*` preserved**; **5** new gaps + **11** TBDs each with a named owner; ⛔ **0 of 17 AC proven** and ⛔ **0** surface tests |

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
`student-management/`, ⭐ `attendance/`, ⭐ `seat-management/` and ⭐
`fees-finance/`; it has been corrected rather than deleted.**

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
*UI/UX section*.

⚠️⚠️ **That last sentence once read *"⛔ The other four rows were re-measured
under the corrected instrument and are **unchanged**."* ⛔ It was false for
`seat-management/`, and is corrected rather than deleted** — see §2A.3a.
⛔⛔ **It was false for `fees-finance/` too** — see §2A.3b. ⭐ **Of the five
rows that sentence covered, two have since been falsified by audit**, which is
why no remaining `NOT REQUIRED` row should be read as settled.

| Context | Design Doc | Frozen PRD's surface requirements | Disposition |
|---|---|---|---|
| `membership/` | ⭐ [`DD-0001`](membership/DD-0001-membership-management-surface-design.md) **v0.2** | ⭐ **`PRD-005` §20 — 13 `MUST`/`MUST NOT` surface rows** | **WRITTEN** — see §2A |
| ⭐ `student-management/` | ⭐ [`DD-0002`](student-management/DD-0002-student-management-surface-design.md) **v0.1a** | ⭐⭐ **`PRD-004` §5 — 35 `LMD-*` display requirements** *(⛔ no UI/UX section; ⛔ 0 literal `UI`/`UX`)*, plus §8.2's closed **12×5** permission matrix and §9.2's **16** edge cases | **WRITTEN** — see §2A |
| ⭐ `attendance/` | ⭐ [`DD-0003`](attendance/DD-0003-attendance-surface-design.md) **v0.1** | ⭐⭐ **`PRD-006` §23.4a — 6 named presence renderings** *(🟢 PRESENT · 🟡 PRESENCE CHECKING · ⚪ NOT PRESENT · 🟡 OUTSIDE SHIFT WINDOW · 🔴 SHIFT OVERSTAY · 🟠 NO BOOKED SHIFT)*, a **MUST NOT collapse** rule and §30.20's `ATT-AC-214`…`222`; plus ⭐ §10A.1's **9-status vocabulary**, §14.1's **4-row** state table, §25's **19** distinguishable signals and **4 mandated silences**, and ⭐ §10A.10 *"The student experience"*. ⛔ **0** literal `UI`/`UX`/`screen` | ⭐⭐ **WRITTEN** — ⭐ the third case proving the corrected instrument: a PRD with **0** occurrences of *"UI"* was the **most** surface-prescriptive of the five. See §2A |
| ⭐ `seat-management/` | ⭐ [`DD-0004`](seat-management/DD-0004-seat-management-surface-design.md) **v0.1** | ⭐⭐ **`PRD-007` §13 *"The seat card"*** — `SEAT-FR-103`, a **14-field** card, amended by `ADR-0032` (`O-5`) to **4 presence states** (🟢 `PRESENT` · 🔵 `ATTENDED · LEFT` · 🟠 `PRESENCE UNVERIFIED` · ⚪ `NOT ATTENDED`) plus a **shift-conformance badge on a second axis** — ⛔ *"one field cannot carry two facts"*; plus ⭐ **§5.3 *"The layout editor"***, ⭐ §8's **16-gate** acquisition gate, ⭐ §22.4's **5 work queues**, ⭐ §26's search + **12 presets**, ⭐ §28.2's closed **24-row** matrix, ⭐ §30's **34** edge cases, and ⭐⭐ `SEAT-NFR-005` naming the seat map *"the module's **primary surface**"*. ⚠️ **1** literal `UI` | ⭐⭐ **WRITTEN** — ⚠️⚠️ **and this row's prior reading was WRONG.** It read *"**0** — 8 UI occurrences, ⛔ every one a prohibition"*; it is **corrected, not quietly replaced**. See §2A.3a |
| ⭐ `fees-finance/` | ⭐ [`DD-0005`](fees-finance/DD-0005-fees-finance-surface-design.md) **v0.1** | ⭐⭐ **`PRD-008` §16.1 `FEE-FR-062`** — *"each component… **MUST** be itemised separately and **MUST NOT** be collapsed into a single undifferentiated charge"*; ⭐ **§19 `FEE-FR-046`** — the profile **MUST** expose **5 named components**; ⭐ **§14 `FEE-BR-015`** — *"a **visible reconciliation queue MUST exist**… **deliberately not hidden behind a fake atomic button**"*; plus ⭐ §12 Invoices, ⭐ §16 Receipts, ⭐ §21 append-only history, ⭐ §23's **10-row** permission matrix, ⭐ §29's **9** states and ⭐ §34's **14** edge cases. Measured vocabulary: `receipt` **66** · `invoice` **44** · `list` **26** | ⭐⭐ **WRITTEN** — ⚠️⚠️ **and this row's prior reading was WRONG.** It read *"1 — `PRD-008` §42.7, ⛔ an express statement of **absence**"*; ⛔ §42.7 is a **client-architecture** note, not a statement of surface absence. **Corrected, not quietly replaced** — see §2A.3b |
| ⭐ `analytics/` | ⭐ [`DD-0006`](analytics/DD-0006-analytics-and-reports-surface-design.md) **v0.1** | ⭐⭐ **`PRD-009` §15 — a 4-row screen table** naming `Today → Progress → Motivation → Detail` with content **and source** per row; ⭐⭐ **`ANL-FR-027`** — management surfaces **MUST** follow `Status → Attention → Action → Analysis`, ⛔ *"not a chart wall"*; ⭐⭐ **`ANL-FR-035`** — *"Every screen **MUST** lead with a plain-language summary **before any chart**"*; ⭐ **`ANL-FR-018`** — *"never a zero presented as a score"*; ⭐ `ANL-FR-034` no horizontal scroll; ⭐ `ANL-FR-041`/`-042`/`-043` **three ratified accessibility requirements**; plus ⭐ §18–21's per-role metric sets and §41–42's edge cases | ⭐⭐ **WRITTEN** — ⭐ the **first context added beyond the original six**, per §2. ⚠️ ⛔ **This row was never `NOT REQUIRED`** — `analytics/` was simply **absent** from the table, which is a different defect: ⛔ the coverage table was **incomplete**, not wrong |
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

### 2A.3a ⭐⭐ Correction — `seat-management/` was misclassified, and why the instrument failed a **third** time

⛔⛔ **This subsection exists because two rows of this README were wrong.** It
is recorded, not erased: §2A.2 rule 3 forbids editing a status cell to match
an expectation, and the honest counterpart is that a **corrected** cell must
say what it previously claimed.

**What the two rows claimed**, until the accepted **BC-04 Seat Management
Design Readiness Audit** re-measured them:

* §2A.3 — *"**0** — 8 UI occurrences, ⛔ every one a prohibition"*
* §2A.4 — ⚪ **`NOT REQUIRED`**, basis *"All **8** UI occurrences in its PRD
  are **prohibitions**; ⛔ a prohibition fixes no surface to design"*

⭐⭐ **Both were false, and the count itself was an artifact of the tool:**

| Prior claim | ⭐ Measured in `PRD-007` | Verdict |
|---|---|---|
| *"8 UI occurrences"* | ⛔ The literal word `UI` occurs **once**. The "8" came from a `UI\|screen\|widget` pattern matching **8 lines**, not 8 UI requirements | ⛔ **Artifact of the instrument** |
| *"every one a prohibition"* | ⚠️ True of those 8 lines — ⛔ **and irrelevant**, because the instrument never looked at the surfaces the PRD **mandates** | ⛔ **True but non-probative** |
| *"a prohibition fixes no surface to design"* | ⭐ Sound as a rule; ⛔ **misapplied** — it was used to conclude absence from a sample that excluded the evidence | ⛔ **Non sequitur** |
| *"0 surface requirements"* | ⭐⭐ §13 is titled **"The seat card"** and §5.3 **"The layout editor"** — whole **mandated** sections. `SEAT-FR-103` fixes **14 fields**; `SEAT-NFR-005` calls the seat map *"the module's **primary surface**"* | ⛔⛔ **Contradicted by the source** |

⭐⭐⭐ **This is the THIRD consecutive failure of the same naive
`UI`/`UX`/`screen` instrument** — after `PRD-004` (§2A.3 above) and `PRD-006`.
⛔ Three failures in three attempts is not bad luck; the instrument is
**invalid** and is retired here.

⭐ **The corrected instrument searches the vocabulary a PRD actually uses for
surfaces.** Measured in `PRD-007`:

| Term | `map` | `layout` | `tab` | `view` | `list` | `search` | `surface` | `card` | `label` | `filter` | `editor` |
|---|---|---|---|---|---|---|---|---|---|---|---|
| **Count** | **77** | **75** | **70** | **52** | **44** | **27** | **23** | **21** | **21** | **22** | **10** |

⛔⛔ **Lesson recorded, not just the fix:** a **count of a word** is not a
measure of a requirement. ⭐ The `Frozen PRD's surface requirements` column
must cite **named sections and identifiers**, as all four WRITTEN rows now do.

### 2A.3b ⭐⭐ Correction — `fees-finance/` was misclassified, and the instrument failed a **fourth** time

⛔⛔ **This subsection exists because two more rows of this README were wrong.** Same discipline as §2A.3a: recorded, not erased.

**What the two rows claimed**, until the accepted **BC-05 Fees & Finance Design Readiness Audit** re-measured them:

* §2A.3 — *"1 — `PRD-008` §42.7, ⛔ an express statement of **absence**"*
* §2A.4 — ⚪ **`NOT REQUIRED`**, basis *"`PRD-008` §42.7 is an express statement of **absence**"*

⭐⭐ **Both rested on a misreading of a single section:**

| Prior claim | ⭐ Measured in `PRD-008` | Verdict |
|---|---|---|
| *"§42.7 is an express statement of **absence**"* | ⛔ §42.7 is titled ***"One app, six UIs — no effect on this register, recorded so the absence is deliberate"***. The *"absence"* is of **`BC-05` obligations arising from the client-architecture decision** — ⛔ **not** an absence of surfaces | ⛔⛔ **Misread** |
| *"1 [surface requirement]"* | ⭐⭐ **§16.1 `FEE-FR-062`** mandates itemisation and forbids collapsing; **§19 `FEE-FR-046`** fixes **5** profile components; **§14 `FEE-BR-015`** requires a *"**visible** reconciliation queue"* | ⛔ **Contradicted by the source** |
| *(implicit)* the PRD is not frozen | ⭐ **`FROZEN` v1.7** — `ADR-0049` **Accepted**, `DOCUMENTATION_BASELINE.md` **L176**. ⚠️ The PRD's own Version field still reads *"DRAFT"*, but `PRD_REGISTRY.md` §2.1 governs: *"Freeze is **not self-declared**"* | ⭐ **Frozen** |

⭐⭐⭐ **This is the FOURTH consecutive failure of a naive reading** — after `PRD-004`, `PRD-006`, `PRD-007` (§2A.3a) and now `PRD-008`. ⚠️ The failure mode has **shifted**: §2A.3a's was a bad *word count*; this one is a **single section read out of context**. ⛔ The lesson generalises — **a one-line citation is not a measurement**.

⭐ Measured surface vocabulary in `PRD-008`:

| Term | `receipt` | `invoice` | `report` | `list` | `dashboard` | `card` | `label` |
|---|---|---|---|---|---|---|---|
| **Count** | **66** | **44** | **40** | **26** | **17** | **12** | **10** |

⛔⛔ **A scope caveat that must not be lost.** `DD-0005` is **narrower** than the raw counts imply: `FEE-XC-012`/`013` **disown** metric definition and reporting stores to **`BC-26`**, and Rank 2 **`ADR-0130`** removes UPI, card, online payment and the gateway from V1. ⭐ **Correcting a `NOT REQUIRED` row does not enlarge V1.**

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
| ⭐ `seat-management/` | ⭐ **COMPLETE** | ⭐⭐ **Audited, then designed.** `DD-0004` **v0.1** — ⭐ **READY WITH EXPLICIT DESIGN GAPS**: **29** surfaces `L1`…`L24` · `S1`…`S4` · `P1` (⭐ **28 designable now**), 14 flows, 21 states on **6 axes**, 34 edge cases dispositioned, a closed **24-row** permission matrix and a **20-row** privacy matrix. ⭐ Source measured **`FROZEN` v1.1, Rank 3, 2891 lines**, `ADR-0020` under `BASELINE-2026-08-04-E`, **683** identifiers. ⭐⭐ **3 open conflicts preserved UNRESOLVED** — ⛔⛔ `SEAT-CONFLICT-001` *(the frozen PRD cites edge **`E-27`**, which `ADR-0033` **withdrew**; the BC Map measures **26** edges, `E-01`…`E-26`)* · ⛔ `SEAT-CONFLICT-002` *(**6 stale `E-27` citations in `DD-0003`**, self-reported)* · ⛔ `SEAT-BLOCK-001` *(🔵 `ATTENDED · LEFT` is **blocked**)*. ⚠️⚠️ **A prior revision of this row was WRONG and is corrected rather than quietly replaced:** it read ⚪ *"**NOT REQUIRED** — all **8** UI occurrences in its PRD are prohibitions"*. ⛔ The literal word `UI` occurs **once**, and §13 *"The seat card"* and §5.3 *"The layout editor"* are **mandated** sections — see §2A.3a |
| ⭐ `fees-finance/` | ⭐ **COMPLETE** | ⭐⭐ **Audited, then designed.** `DD-0005` **v0.1** — ⭐ **READY WITH EXPLICIT DESIGN GAPS**: **16** surfaces (⭐ **10 designable now**), 9 states across 5 machines, 14 edge cases, a **10-row** permission matrix. ⭐ Source measured **`FROZEN` v1.7, Rank 3, 2808 lines**, `ADR-0049` under `BASELINE-2026-08-17-A`, **249** register entries / **134** obligation-bearing / **17** gaps. ⭐⭐ **2 open conflicts preserved UNRESOLVED** — ⛔⛔ `FEE-CONFLICT-001` *(Rank 2 `ADR-0130` makes student payment **CASH ONLY** in V1; `PRD-008` §6.1 **L209**–**L214** still list UPI, card, online, verification and webhook reconciliation as V1 — **superseded in effect**, `PRD-008 v1.8` successor **determined but NOT executed**)* · ⛔ `FEE-CONFLICT-002` *(`ADR-0046`/`ADR-0047` retain **stale V1 limbs** naming a V1 gateway provider and webhook contract)*. ⚠️⚠️ **A prior revision of this row was WRONG and is corrected rather than quietly replaced:** it read ⚪ *"**NOT REQUIRED** — `PRD-008` §42.7 is an express statement of **absence**"* — ⛔ §42.7 is titled *"One app, six UIs — **no effect on this register**"* and concerns **client architecture**, ⛔ not surface absence — see §2A.3b |
| ⭐ `analytics/` | ⭐ **COMPLETE** | ⭐⭐ **Audited, then scope-checked, then designed.** `DD-0006` **v0.1** — ⚠️ **DESIGNED WITH EXPLICIT BLOCKERS**: **11** surfaces `A1`…`A4` · `B1`…`B7` (⭐ **1 designable now**, ⚠️ 7 partial, ⛔ 3 blocked), **11** states (⭐ **7** of them non-value, ⛔ **none may render zero**), **6** visualizations (⛔ 8 rejected), **1** certified metric + ⚠️ **13** uncertified candidates, ⛔ **0** report instances. ⭐ Source measured **`FROZEN` v0.6, Rank 3**, `ADR-0113` **Accepted**, **144** identifiers. ⭐⭐ **Governed for metrics by Rank 2 `ADR-0097`** — ⭐ `ProfileViews` is the **ONLY `CertifiedMetric` in the repository** and ⛔ `UniqueViewers` is **expressly NOT certified**, which is why exactly **one** surface is designable. ⭐⭐ **2 open conflicts preserved UNRESOLVED** — ⛔⛔ `ANL-AL-B1` *(a **Rank-4 vs Rank-4** `iam.*` routing conflict; BC Map **L434** routes it, the manifest **L315–316** excludes it, ⛔ precedence cannot break the tie)* · ⛔⛔ `GAP-BCMAP-BC26-EDGES` *(BC Map §9 records `BC-26` as consumer of ~**20** events for which §7 declares **no edge** — ⭐ measured by the BC Map itself at §17.4 and newly carried into the design layer)*. ⛔⛔ **`TR-5` Parent EXCLUDED — 0 surfaces**, a deliberate divergence from `DD-0003`/`DD-0005` because `ANL-OBD-004` requires a decision *"before any guardian-facing analytic ships"*. ⚠️ **App-Boundary QA reported as 12/13 with 1 GAP, ⛔ NOT rounded to 13/13** — ⛔ `PRD-009` carries **no closed permission matrix** (`ANL-OBD-003`). ⛔ **25/25 gaps, F-1/F-2/F-3 and 9/9 open decisions PRESERVED OPEN** |
| `shared/` | ⚪ **NOT REQUIRED** | ⭐ By §2.1 — cross-cutting designs only; ⛔ not an "unsure" bucket |

⚠️ **No context is marked `IN PROGRESS` or `BLOCKED`**, because ⛔ neither
is true of any context today. ⭐ Those values exist for when they are.

⚠️ **`NOT REQUIRED` is provisional on evidence, not permanent.** Should a
PRD later gain surface requirements, the row changes — which is exactly
what happened to `student-management/` (§2A.3).

⚠️⚠️ ⭐ **And `seat-management/` shows the sharper case: the row can change
without the PRD changing at all.** ⛔ `PRD-007` has been `FROZEN` v1.1
throughout; ⭐ only the **measurement** was wrong (§2A.3a). ⛔⛔ **So a
`NOT REQUIRED` row is never evidence that a Design Doc is unnecessary — it is
only evidence of what the last measurement found.** The **one** remaining
`NOT REQUIRED` *(on current evidence)* row, `fees-finance/`, has **not** been
re-audited under the corrected instrument and ⛔ **must not be read as
settled**.

⭐⭐ **That warning was then tested, and it was right.** `fees-finance/` **was**
re-audited, and the row changed — §2A.3b. ⛔⛔ **Two of the three original
`NOT REQUIRED` rows have now been falsified by audit** (`seat-management/`,
`fees-finance/`). ⭐ The **one** remaining *(on current evidence)* row is now
`shared/`’s sibling case only; ⛔ `shared/`’s §2.1 basis is a **rule**, not a
measurement, so it does not carry the same risk — but ⛔ **no `NOT REQUIRED`
row anywhere should be cited as evidence that a Design Doc is unnecessary.**

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
  **`DD-0001`**, **`DD-0002`**, **`DD-0003`**, **`DD-0004`**, **`DD-0005`**,
  **`DD-0006`** — so ⭐ **the next Design Doc is `DD-0007`**.
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
