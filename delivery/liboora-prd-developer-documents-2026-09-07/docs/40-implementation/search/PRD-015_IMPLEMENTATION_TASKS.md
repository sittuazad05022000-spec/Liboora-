# `PRD-015` Search Indexing — Implementation Tasks

| Field | Value |
|---|---|
| **Document** | `PRD-015_IMPLEMENTATION_TASKS.md` **v1.0** · 2026-09-05 |
| **Subject** | `PRD-015_SEARCH_INDEXING.md` — Search Indexing (`BC-23`), v0.1 `DRAFT` |
| **Subject hash** | `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` — **byte-unchanged** |
| **Stage** | **6 — Implementation Tasks** (`PRD_LIFECYCLE.md` **L135-153**) |
| **Range allocated** | ⭐ **`IMPL-1850` … `IMPL-1873`** — **24** tasks, contiguous, one row per number |
| **Growth reserve** | **`IMPL-1874`…`1899`** — declared reserve, ⛔ **NOT allocated and NOT used** |
| **Authority** | **Implementation lead** (`PRD_LIFECYCLE.md` **L280** — *"Implementation lead \| Stages 6 and 8"*), exercised on the **one-act conferral of the human principal** covering this closure loop. ⛔ **No personal name** (§7 rule 4); ⛔ **not a standing licence** (`ADR-0033` §7.1) |
| **Prior stages** | Stage 3 CONFERRED (16/16) · Stage 4 CONFERRED (6/6) · Stage 5 CONFERRED — `TRACEABILITY_MATRIX.md` **v1.24 §2S** |
| **Trace basis** | ⭐ **78 obligations · 78 acceptance criteria · 0 orphans** — re-measured from the subject, ⛔ not inherited |
| **Code written** | ⛔⛔ **NONE. 0 lines** under `lib/`, `test/`, `web/`, `android/`. ⭐ **Code is Stage 8**, not Stage 6 |
| **Status of this document** | **Unranked.** ⛔ Not admitted to `DOCUMENTATION_BASELINE.md`. Precedence: **none** |

---

## 0. The four allocation rules, and how each is satisfied

`PRD_LIFECYCLE.md` **L137-145** states them:

> 1. Take the next free range. **Never reuse or reassign a number.**
> 2. Leave the previous group room to grow contiguously.
> 3. Record `Priority`, `Blocks`, `Blocked by` per task.
> 4. Add a traceability table mapping task groups → requirements → invariants → acceptance.

### 0.1 ⭐⭐ Rule 1 — the range was MEASURED, not read from the lifecycle table

⚠⚠ **`PRD_LIFECYCLE.md` L147-153's allocation table is STALE and was NOT used.** It ends at
*"`IMPL-227`+ Unallocated"*, which has been false since `PRD-005`. The frontier was measured across
every tracked file instead, and ⭐ **the distinction that decided the number is between a USE and a
DECLARATION**:

| Measurement | Value |
|---|---|
| Distinct `IMPL-` numbers used as an **actual task row** (leading table cell) | **846** |
| ⭐ **Highest number used as a task row** | **`IMPL-1794`** |
| Numbers above 1794 appearing **anywhere** | `1800`, `1801`, `1849` |
| ⭐ Of those, numbers used as a **task row** | ⛔ **NONE** |

⚠ **A naïve census reports 1801 and would have started here at `IMPL-1802`. Reading those three
numbers at their lines shows none is a use:**

| Number | Where | What it actually is |
|---|---|---|
| `1800` | `PRD-021B_IMPLEMENTATION_TASKS.md` **L221** | a census row reading *"⭐ **0 — empty**"* — ⭐ **a declaration that the band is free, not a use** |
| `1801` | `PRD-021C_IMPLEMENTATION_TASKS.md` **L57** | prose explaining that a naïve census *"would have started this allocation at `IMPL-1801`"* |
| `1849` | `PRD-021C_IMPLEMENTATION_TASKS.md` **L9** | the **last number of `PRD-021C`'s declared growth reserve** |

### 0.2 ⭐⭐⭐ Rule 2 — the previous group's reserve is CLEARED, not consumed

⚠⚠ **This is the decisive constraint, and it moved the start number by 56.**
`PRD-021C_IMPLEMENTATION_TASKS.md` **L9** declares:

> **Growth reserve** — **`IMPL-1794`…`1849`** — declared reserve, ⛔ **NOT allocated and NOT used**

⭐ Rule 2 requires leaving the previous group room to grow **contiguously**, so this allocation
**clears the whole reserve** and starts above it. ⛔ **`IMPL-1794`…`1849` is NOT TOUCHED.**

| Band | Disposition |
|---|---|
| `IMPL-1750`…`1793` | ⛔ **NOT TOUCHED** — allocated to `PRD-021C` C0–C8, 44 tasks |
| `IMPL-1794`…`1849` | ⛔ **NOT TOUCHED** — `PRD-021C`'s **declared growth reserve** (56 numbers) |
| ⭐ **`IMPL-1850`…`1873`** | ✅ **Allocated here** — **24** tasks, contiguous, one row each |
| ⭐ **`IMPL-1874`…`1899`** | ✅ **Growth reserve** — **26**, declared and ⛔ **not allocated**. `PRD-015` carries **9 OPEN `SRCH-GAP-*`** plus six Stage-3 residual items; when any closes it will need tasks, and they must be contiguous with these |
| `IMPL-1900`+ | Unallocated — measured empty. ⚠ **This row is a declaration that the numbers are free, not a use of them** |

### 0.3 Rule 3 — every task row records `Priority`, `Blocks`, `Blocked by`

⭐ Satisfied for all 24 rows in §2. ⚠ **`Blocks` / `Blocked by` are derived from the subject's own
section sequence**, which is the only dependency evidence the repository supplies. ⛔ **No dependency
graph, sprint plan, estimate or team assignment is invented.**

### 0.4 Rule 4 / ⭐ THE STAGE 6 GATE — every task traces back to requirements

`PRD_LIFECYCLE.md` **L135**: the gate is *"an `IMPL-*` range allocated and a task document in which
**every task traces back to requirements**."*

| Measurement | Value |
|---|---|
| Tasks | **24** |
| Tasks citing ≥ 1 obligation the subject actually defines | ⭐ **24 / 24** |
| ⛔ **Orphan tasks** (citing nothing, or citing a non-existent identifier) | ⭐ **0** |
| Distinct obligations cited across all tasks | ⭐ **78 / 78 = 100.0 %** |
| Distinct acceptance criteria cited | ⭐ **78 / 78** |
| ⛔ Identifiers **minted** by this document | ⭐ **0** |

---

## 1. ⛔⛔ What this document does NOT do — stated before the tasks

| # | ⛔ Not done |
|---|---|
| 1 | ⛔ **No application code.** `git status --short lib/ test/ web/ android/` → **0** lines. ⭐ Code is **Stage 8** |
| 2 | ⛔ **No API, endpoint, route, schema, table or payload** is designed |
| 3 | ⛔ **No event is defined** — `SRCH-EVT-*` is EMPTY and stays EMPTY; `BC-23` is a pure projection consumer |
| 4 | ⛔ **No analyzer, tokenizer, stemmer, engine or vendor** is named — `ADR-0099` §2.1 reserves that to the Architecture Owner |
| 5 | ⛔ **No threshold, edit distance, prefix length, page size, timeout, SLO or SLI** is invented — `HD-7`, `HD-8`, `P4`, `SRE-GAP-001` remain OPEN |
| 6 | ⛔ **No UI, screen, widget or interaction** is specified |
| 7 | ⛔ **No `SRCH-GAP-*` is resolved.** All **9** remain OPEN — ⭐ **and no task is created that would resolve one**, because `SRCH-BR-*` forbids closing a gap by implementation choice |
| 8 | ⛔ **No requirement, criterion or identifier is created, removed, merged or reworded** — the subject is byte-unchanged |
| 9 | ⛔ **No freeze, baseline, rank or registry change** — Stage 7 |
| 10 | ⛔ **No verification claimed** — **0 of 78** criteria proven |

### 1.1 ⭐ The six tasks that were TEMPTING and were NOT created

⚠⚠ **Named explicitly, on the `PRD-007`/`ADR-0020` precedent, so a later reader can see they were
considered and refused rather than overlooked.**

| ⛔ Not created | Why it must not exist |
|---|---|
| *"Select and configure the search analyzer"* | ⛔ `ADR-0099` §2.1 — the configuration is **Architecture-Owner governed** and OPEN at §2.3. A task cannot pre-empt it |
| *"Implement the Devanagari normalization rules"* | ⛔ `HD-2`/`HD-3` are **MODEL CLOSED · CONTENT OPEN**. There is no rule set to implement |
| *"Set the typo tolerance edit-distance bound"* | ⛔ `HD-7` is a **DEFER**. ⭐ *"A DEFER closes nothing"* |
| *"Define the `BC-23` search API"* | ⛔ `SRCH-FR-*` specifies **behaviour**, not transport; `ADR-0100` leaves the **`P1` transport-binding limb OPEN** |
| *"Define SLIs and the error budget for search availability"* | ⛔ `SRE-GAP-001`; every authority tags SLO/SLI content **V2** |
| *"Resolve the script-selection rule for dual-script fields"* | ⛔ `SRCHPO-A11` — Architecture-Owned and expressly left OPEN by `ADR-0103` §4 |

---

## 2. ⭐ The 24 tasks

⭐ **Grouped by the subject's own section structure**, which is the only grouping the repository
supplies. Each row cites the obligations that section defines and their acceptance criteria.

| Task | Scope — subject section | Requirements / invariants / exclusions | Acceptance | Priority | Blocks | Blocked by |
|---|---|---|---|---|---|---|
| `IMPL-1850` | 3. Scope — and the exact boundary against frozen §14A | `SRCH-XC-001`, `SRCH-XC-002` | `SRCH-AC-063`, `SRCH-AC-064` | P1 | `IMPL-1851` | — |
| `IMPL-1851` | 4. Non-goals (V1) | `SRCH-XC-003`, `SRCH-XC-004`, `SRCH-XC-005`, `SRCH-XC-006`, `SRCH-XC-007` | `SRCH-AC-065`, `SRCH-AC-066`, `SRCH-AC-067`, `SRCH-AC-068`, `SRCH-AC-069` | P1 | `IMPL-1852` | `IMPL-1850` |
| `IMPL-1852` | 5. `BC-23` ownership | `SRCH-BR-001`, `SRCH-BR-002`, `SRCH-INV-001`, `SRCH-XC-008`, `SRCH-XC-009` | `SRCH-AC-043`, `SRCH-AC-044`, `SRCH-AC-057`, `SRCH-AC-070`, `SRCH-AC-071` | P1 | `IMPL-1853` | `IMPL-1851` |
| `IMPL-1853` | 6. Search consumers | `SRCH-BR-003`, `SRCH-FR-001`, `SRCH-FR-002`, `SRCH-XC-010` | `SRCH-AC-045`, `SRCH-AC-001`, `SRCH-AC-002`, `SRCH-AC-072` | P1 | `IMPL-1854` | `IMPL-1852` |
| `IMPL-1854` | 7. Searchable entities and documents | `SRCH-FR-003`, `SRCH-INV-002`, `SRCH-XC-011` | `SRCH-AC-003`, `SRCH-AC-058`, `SRCH-AC-073` | P1 | `IMPL-1855` | `IMPL-1853` |
| `IMPL-1855` | 8. Source-of-truth model | `SRCH-FR-004`, `SRCH-FR-005`, `SRCH-INV-003`, `SRCH-XC-012` | `SRCH-AC-004`, `SRCH-AC-005`, `SRCH-AC-059`, `SRCH-AC-074` | P1 | `IMPL-1856` | `IMPL-1854` |
| `IMPL-1856` | 9. Index classes | `SRCH-BR-004`, `SRCH-FR-006`, `SRCH-FR-007`, `SRCH-INV-004`, `SRCH-XC-013` | `SRCH-AC-046`, `SRCH-AC-006`, `SRCH-AC-007`, `SRCH-AC-060`, `SRCH-AC-075` | P1 | `IMPL-1857` | `IMPL-1855` |
| `IMPL-1857` | 10. ⭐⭐ Reusability — the architectural principle | `SRCH-BR-005`, `SRCH-FR-008`, `SRCH-FR-009`, `SRCH-XC-014` | `SRCH-AC-047`, `SRCH-AC-008`, `SRCH-AC-009`, `SRCH-AC-076` | P1 | `IMPL-1858` | `IMPL-1856` |
| `IMPL-1858` | 11. Index lifecycle | `SRCH-BR-006`, `SRCH-FR-010`, `SRCH-FR-011`, `SRCH-FR-012`, `SRCH-FR-013`, `SRCH-FR-014`, `SRCH-INV-005` | `SRCH-AC-048`, `SRCH-AC-010`, `SRCH-AC-011`, `SRCH-AC-012`, `SRCH-AC-013`, `SRCH-AC-014`, `SRCH-AC-061` | P2 | `IMPL-1859` | `IMPL-1857` |
| `IMPL-1859` | 12. Data projection rules | `SRCH-FR-015`, `SRCH-FR-016`, `SRCH-XC-015` | `SRCH-AC-015`, `SRCH-AC-016`, `SRCH-AC-077` | P2 | `IMPL-1860` | `IMPL-1858` |
| `IMPL-1860` | 13. Field eligibility | `SRCH-BR-007`, `SRCH-FR-017`, `SRCH-FR-018`, `SRCH-INV-006` | `SRCH-AC-049`, `SRCH-AC-017`, `SRCH-AC-018`, `SRCH-AC-062` | P2 | `IMPL-1861` | `IMPL-1859` |
| `IMPL-1861` | 14. Public vs private search data | `SRCH-FR-019`, `SRCH-FR-020`, `SRCH-XC-016` | `SRCH-AC-019`, `SRCH-AC-020`, `SRCH-AC-078` | P2 | `IMPL-1862` | `IMPL-1860` |
| `IMPL-1862` | 15. Query model | `SRCH-FR-021`, `SRCH-FR-022` | `SRCH-AC-021`, `SRCH-AC-022` | P2 | `IMPL-1863` | `IMPL-1861` |
| `IMPL-1863` | 16. Query normalization | `SRCH-BR-008`, `SRCH-FR-023`, `SRCH-FR-024` | `SRCH-AC-050`, `SRCH-AC-023`, `SRCH-AC-024` | P2 | `IMPL-1864` | `IMPL-1862` |
| `IMPL-1864` | 17. ⭐⭐⭐ Flexible / tolerant search — the reusable capability | `SRCH-BR-009`, `SRCH-FR-025`, `SRCH-FR-026`, `SRCH-FR-027` | `SRCH-AC-051`, `SRCH-AC-025`, `SRCH-AC-026`, `SRCH-AC-027` | P2 | `IMPL-1865` | `IMPL-1863` |
| `IMPL-1865` | 18. Exact matching — T1 | `SRCH-FR-028` | `SRCH-AC-028` | P2 | `IMPL-1866` | `IMPL-1864` |
| `IMPL-1866` | 19. Partial and token matching — T2 | `SRCH-BR-010`, `SRCH-FR-029`, `SRCH-FR-030` | `SRCH-AC-052`, `SRCH-AC-029`, `SRCH-AC-030` | P3 | `IMPL-1867` | `IMPL-1865` |
| `IMPL-1867` | 20. Similar word forms and equivalent variations — T3 | `SRCH-BR-011`, `SRCH-FR-031`, `SRCH-FR-032` | `SRCH-AC-053`, `SRCH-AC-031`, `SRCH-AC-032` | P3 | `IMPL-1868` | `IMPL-1866` |
| `IMPL-1868` | 21. Typo and misspelling handling — T3 | `SRCH-BR-012`, `SRCH-FR-033` | `SRCH-AC-054`, `SRCH-AC-033` | P3 | `IMPL-1869` | `IMPL-1867` |
| `IMPL-1869` | 22. Relevance model | `SRCH-BR-013`, `SRCH-FR-034`, `SRCH-FR-035`, `SRCH-FR-036` | `SRCH-AC-055`, `SRCH-AC-034`, `SRCH-AC-035`, `SRCH-AC-036` | P3 | `IMPL-1870` | `IMPL-1868` |
| `IMPL-1870` | 23. Filtering | `SRCH-FR-037`, `SRCH-FR-038` | `SRCH-AC-037`, `SRCH-AC-038` | P3 | `IMPL-1871` | `IMPL-1869` |
| `IMPL-1871` | 24. Sorting | `SRCH-BR-014` | `SRCH-AC-056` | P3 | `IMPL-1872` | `IMPL-1870` |
| `IMPL-1872` | 25. Pagination | `SRCH-FR-039`, `SRCH-FR-040` | `SRCH-AC-039`, `SRCH-AC-040` | P3 | `IMPL-1873` | `IMPL-1871` |
| `IMPL-1873` | 26. Empty result handling | `SRCH-FR-041`, `SRCH-FR-042` | `SRCH-AC-041`, `SRCH-AC-042` | P3 | — | `IMPL-1872` |
---

## 3. Traceability roll-up — task groups → requirements → invariants → acceptance

⭐ Rule 4's mandated table, aggregated by register:

| Register | Members | Cited by a task | Uncited | Criteria cited |
|---|---|---|---|---|
| `SRCH-FR-*` | **42** | ⭐ **42** | ⛔ **0** | 42 |
| `SRCH-BR-*` | **14** | ⭐ **14** | ⛔ **0** | 14 |
| `SRCH-INV-*` | **6** | ⭐ **6** | ⛔ **0** | 6 |
| `SRCH-XC-*` | **16** | ⭐ **16** | ⛔ **0** | 16 |
| **Total** | **78** | ⭐ **78** | ⛔ **0** | ⭐ **78** |

⭐⭐ **Every invariant is claimed by a task, and every exclusion too.** ⚠ **An exclusion task is a
task to make something impossible and to test that it is** — `SRCH-XC-*` states prohibitions, and
`PRD_LIFECYCLE.md` L112 holds that *"an exclusion is not a deferral."* ⛔ Their acceptance criteria
are nonetheless **unfalsifiable by observation alone**, which is why Stage 5 recorded 0 of 78 proven.

---

## 4. ⚠ Nine `SRCH-GAP-*` carry NO task, deliberately

| Gap | Owner | Why no task |
|---|---|---|
| `SRCH-GAP-001` … `SRCH-GAP-009` | as registered in the subject (Architecture Owner / Product Owner) | ⛔ **A task cannot resolve a gap.** Allocating one would resolve an open question by implementation choice, which is the defect `ADR-0020` §3 names for `SEAT-GAP-*`: the backlog *"assigns them no task and names six tempting tasks that must not be created for exactly that reason"* |

⭐ `SRCH-GAP-002` and `SRCH-GAP-007` **are** closed — by the Stage-3 conferral, not by a task. The
remaining **seven** stay OPEN.

---

## 5. Validation performed

| # | Check | Result |
|---|---|---|
| 1 | Range measured, not read from the stale lifecycle table | ✅ frontier `IMPL-1794` by task-row rule |
| 2 | Previous group's declared reserve cleared, not consumed | ✅ `1794`…`1849` **NOT TOUCHED** |
| 3 | Allocation contiguous, one row per number | ✅ `1850`…`1873`, **24 / 24** |
| 4 | No number reused anywhere in the repository | ✅ band measured **empty** before allocation |
| 5 | `Priority`, `Blocks`, `Blocked by` on every row | ✅ **24 / 24** |
| 6 | Every task traces to ≥ 1 defined obligation | ✅ **24 / 24**, ⛔ **0 orphans** |
| 7 | Every obligation claimed by a task | ✅ **78 / 78** |
| 8 | Identifiers minted by this document | ⛔ **0** |
| 9 | Tempting-but-unlawful tasks named and refused | ✅ **6** (§1.1) |
| 10 | Gaps assigned a task | ⛔ **0** — §4 |
| 11 | Subject byte-unchanged | ✅ `fe3093e6…c2c4544` |
| 12 | Application code written | ⛔⛔ **0 lines** — code is **Stage 8** |
| 13 | Freeze / baseline / rank / registry changed | ⛔ **0** |

---

## 6. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-09-05 | ⭐⭐ **Stage 6 task document created for `PRD-015`.** Range **`IMPL-1850`…`1873`** — **24** tasks, contiguous, one row per number — with **`IMPL-1874`…`1899`** declared as growth reserve and ⛔ **not allocated**. ⭐⭐⭐ **The range was MEASURED, not read from `PRD_LIFECYCLE.md` L147-153, whose table is STALE** (it ends at *"`IMPL-227`+ Unallocated"*). The frontier was computed across every tracked file by the **task-row rule** — a number counts as used only when it appears as a leading table cell — giving **846** used numbers and a highest of **`IMPL-1794`**. ⚠ **A naïve census reports `1801` and would have started at `IMPL-1802`; all three numbers above the frontier were read at their lines and NONE is a use:** `1800` is a `PRD-021B` census row reading *"0 — empty"*, `1801` is `PRD-021C` prose about this exact hazard, and `1849` is the last number of `PRD-021C`'s reserve. ⭐⭐⭐ **Rule 2 moved the start number by 56:** `PRD-021C` **L9** declares `IMPL-1794`…`1849` a growth reserve, so this allocation **clears it entirely** rather than consuming it — ⛔ **`1794`…`1849` NOT TOUCHED**, as are `PRD-021C`'s allocated `1750`…`1793`. ⭐ **THE STAGE 6 GATE IS SATISFIED AND MEASURED:** *"every task traces back to requirements"* — **24 / 24** tasks cite at least one obligation the subject actually defines, ⛔ **0 orphan tasks**, **78 / 78 = 100.0 %** of obligations claimed, **78 / 78** acceptance criteria cited, and ⛔ **0 identifiers minted**. Tasks are grouped by the subject's **own 24 sections**, the only grouping the repository supplies; `Blocks`/`Blocked by` are derived from that section sequence, and ⛔ **no dependency graph, sprint plan, estimate or team assignment is invented**. ⚠⚠ **SIX TEMPTING TASKS ARE NAMED AND REFUSED (§1.1)**, on the `PRD-007`/`ADR-0020` precedent — analyzer selection (`ADR-0099` §2.1 Architecture-Owned), Devanagari normalization rules (`HD-2`/`HD-3` content OPEN), the typo edit-distance bound (`HD-7` is a **DEFER** and *"a DEFER closes nothing"*), a `BC-23` search API (`ADR-0100` leaves the `P1` transport limb OPEN), SLIs and the error budget (`SRE-GAP-001`, all authority **V2**), and the dual-script selection rule (`SRCHPO-A11`, left OPEN by `ADR-0103` §4). ⚠ **All nine `SRCH-GAP-*` carry NO task deliberately** — a task cannot resolve a gap, the defect `ADR-0020` §3 names. ⛔⛔ **NO APPLICATION CODE: 0 lines** under `lib/`, `test/`, `web/`, `android/` — ⭐ **code is Stage 8**, and Stage 6 is task derivation, not permission to bypass the lifecycle. ⛔ **0** APIs, events, schemas, thresholds, vendors, algorithms or UI behaviours specified. ⛔ Subject **byte-unchanged** at `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544`; ⛔ no freeze, baseline, rank or registry change; ⛔ `PRD-015` remains **`DRAFT` / `PLANNED`**, **not verified** — **0 of 78** criteria proven. **This document is unranked and confers nothing.** |
