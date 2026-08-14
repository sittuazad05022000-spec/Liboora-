# ADR-0020 — Seat Management PRD v1.0 is the official baseline for `BC-04` Seating

| Field | Value |
|---|---|
| **Status** | **Accepted** |
| **Date** | 2026-08-04 |
| **Deciders** | Product owner (freeze authorisation); Principal Enterprise Architect; independent reviewer |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document.** Admits a new document to Rank 3. `MASTER_PRD.md`, the Bounded Context Map, the Module Dependency Matrix and `ARCHITECTURE_RULINGS.md` are **unamended** |
| **Amended by** | — |
| **Baseline** | `BASELINE-2026-08-04-E` |
| **Closes** | [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md) Stage 7 for `PRD-007`. Registry status `PLANNED` → `FROZEN` |
| **Does NOT close** | **`SEAT-GAP-001` … `SEAT-GAP-014`** — see §3. All fourteen remain open; each requires its own decision from its named owner. Nor does it close `BLK-01`/`TASK-D10`, `MM-GAP-010`, or the `PRD-006` occupancy dependency |
| **Related** | [`ADR-0019`](./ADR-0019-membership-management-prd-v1.4-baseline.md) (the `PRD-005` freeze precedent this ADR follows) · `ADR-0018` (`PRD-004`) · `ADR-0011` (`BC-10`) · `ADR-0012` (`TASK-D10` debt) · `ADR-0016` (`E-22`) · `AR-1` · BC Map §5, §7, §8, §9 · [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md) Stage 7 · [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §7 |

---

## 1. The question

[`PRD-SEAT-MANAGEMENT.md`](../../30-product/seat-management/PRD-SEAT-MANAGEMENT.md) (`PRD-007`) has completed
Stages 1–6 of [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md). It carries **683 identifiers** across ten
registers, **226 acceptance criteria**, and a **100-task** implementation backlog claiming **443 of 443**
obligations. Stage 4 returned **verdict A — PASS** with zero findings at every severity; Stage 5 returned **A —
PASS**; Stage 6 returned **A — PASS** on all eight gates.

**Should `PRD-007` be admitted to the documentation baseline at Rank 3 as the authoritative specification for
`BC-04` Seating?**

Stage 7's gate is *"a row in [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §3 at an assigned
precedence rank."* Freeze in this repository is **conferred, not claimed** — `PRD_REGISTRY.md` §2.1 records that
grepping each PRD for its own status *"would have marked all five specifications **not** frozen and been wrong about
every one of them."* This ADR therefore exists **before** the baseline row is written, per Baseline §7 step 1.

---

## 2. Evidence

### 2.1 Review history

| Stage | Gate | Record | Verdict |
|---|---|---|---|
| 3 | Architecture review | [`PRD-007_ARCHITECTURE_ALIGNMENT.md`](../../30-product/seat-management/PRD-007_ARCHITECTURE_ALIGNMENT.md) | Aligned |
| 4 | Requirements review | [`PRD-007_REQUIREMENTS_REVIEW.md`](../../30-product/seat-management/PRD-007_REQUIREMENTS_REVIEW.md) → four correction passes → [`PRD-007_STAGE4_FINAL_REVIEW.md`](../../30-product/seat-management/PRD-007_STAGE4_FINAL_REVIEW.md) | **A — PASS**, 0 CRITICAL · 0 HIGH · 0 MEDIUM · 0 LOW |
| 5 | Traceability | [`PRD-007_STAGE5_TRACEABILITY.md`](../../30-product/seat-management/PRD-007_STAGE5_TRACEABILITY.md) | **A — PASS** |
| 6 | Implementation tasks | [`PRD-007_STAGE6_IMPLEMENTATION_TASKS.md`](../../30-product/seat-management/PRD-007_STAGE6_IMPLEMENTATION_TASKS.md) | **A — PASS**, 8/8 gates |

The Stage 4 sequence is the strongest evidence here. The specification was reviewed, corrected, **re-reviewed twice**
(`PRD-007_STAGE4_REREVIEW.md`, `PRD-007_STAGE4_REREVIEW_2.md`), corrected comprehensively, and then re-reviewed a
**final, independent** time. That final pass **rejected eight candidate findings as false positives with evidence**
rather than accepting them to appear thorough. An independent gap verification
([`PRD-007_INDEPENDENT_GAP_VERIFICATION.md`](../../30-product/seat-management/PRD-007_INDEPENDENT_GAP_VERIFICATION.md))
was run separately against the fourteen open questions.

### 2.2 Stage gates 5 and 6 — satisfied mechanically, re-run immediately before acceptance

Both gates were re-executed at exit 0 immediately before this ADR was written. Figures are **computed from the PRD**,
not copied from the reports:

```
python3 tool/docs_check/prd007_traceability.py    → exit 0
python3 tool/docs_check/prd007_task_coverage.py   → exit 0
```

| Property | Value |
|---|---|
| Registers | **10** — `SEAT-FR` 304 · `SEAT-BR` 45 · `SEAT-INV` 14 · `SEAT-EVT` 4 · `SEAT-XC` 22 · `SEAT-PO` 24 · `SEAT-CFG` 18 · `SEAT-NFR` 12 · `SEAT-AC` 226 · `SEAT-GAP` 14 |
| Total identifiers | **683**, all contiguous, 0 duplicates |
| Obligation-bearing | 669 (total less 14 `SEAT-GAP-*`) |
| Criterion-verifiable obligations | **443** (less 226 `SEAT-AC-*`) |
| Dangling references | **0** |
| Orphan criteria | **0** |
| Cross-module collisions | **0** |
| `SEAT-FR-302` mandated coverage | **85/85 = 100.0%** across `SEAT-BR`/`SEAT-INV`/`SEAT-EVT`/`SEAT-XC` |
| Implementation tasks | **100**, `IMPL-500`…`IMPL-599`, ten waves, 0 collisions with five foreign ranges |
| Task → obligation coverage | **443/443 = 100.0%**, 0 cycles, 1 root, 1 leaf, critical path 18 |

**Four `SEAT-EVT-*` are closed at four** by `SEAT-FR-206`, following the `MM-BR-035` precedent that a domain-event
register must be explicitly closed rather than left open-ended.

### 2.3 Architectural conformance

`PRD-007` owns exactly **two aggregates** — `SeatAllocation` and `SeatLayout` (`SEAT-FR-006`) — matching BC Map §8
exactly, and binds one aggregate to one transaction (`SEAT-FR-007`). It **adds no integration edge**. It consumes
seven existing inbound edges (`E-01`, `E-02`, `E-05`, `E-08`, `E-17`, `E-18`, `E-19`) and publishes on three
outbound (`E-20`, `E-23`, plus capacity alerting), every one of them already declared in BC Map §7.

The boundary discipline that matters most is `X-13`: `BC-04` **consumes** authorisation decisions and never
evaluates, grants or caches one. `SEAT-BR-014` and `SEAT-XC-004` make gate `G7` — membership validity — overridable
by **no role including Owner**, which is the correct shape: the seating module does not get to decide that an invalid
membership is acceptable today.

No bounded context was created. The count remains **31**.

### 2.4 Money, attendance and notification stay outside `BC-04`

`BC-04` holds no money concept (`BC-05` Fee & Collection owns that), writes no attendance record (`BC-03` owns
check-in/out and `BC-04` derives occupancy from `E-08`), and dispatches no notification (`BC-22` owns delivery;
`BC-04` publishes facts on `E-23`). Audit is fire-and-forget on `E-20` — `BC-04` cannot mutate an audit entry, per
`X-10`.

### 2.5 Verification coverage is measured, and is not complete

Admitted at its measured value rather than rounded up, following the `ADR-0019` §2.5 precedent:

- **85/85 = 100.0%** of the four registers `SEAT-FR-302` mandates AC coverage for.
- **325/443 = 73.4%** of all obligations carry an AC citation. The shortfall is **deliberate and bounded**:
  `SEAT-FR-302` excludes `SEAT-FR`, `SEAT-NFR`, `SEAT-PO` and `SEAT-CFG` from its mandate, and the uncited members
  are **86 `SEAT-FR`, 5 `SEAT-NFR`, 18 `SEAT-PO`, 9 `SEAT-CFG`** — each named by the gate script's output rather
  than hidden.

Nothing in this ADR should be read as a claim that these 118 obligations are verified. Under `SEAT-NFR-011`, quoting
`SID-4.56`, *"a rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."*

---

## 3. The open items — investigated, not resolved

### 3.1 Fourteen `SEAT-GAP-*` remain open

`PRD-007` §0.3 states that `SEAT-GAP-*` *"are questions, not requirements, and must never be cited as verifiable."*
`SEAT-BR-045` adds that **no gap may be resolved by implementation choice**. Accordingly:

- All fourteen are **admitted OPEN**. Admission does not ratify, close or reinterpret any of them.
- The Stage 6 backlog assigns **no task** to any gap, and §8 of that document lists six tasks that must not be
  created precisely because they would close a gap by writing code.
- Each requires a decision from its named owner, recorded in
  [`PRD-007_INDEPENDENT_GAP_VERIFICATION.md`](../../30-product/seat-management/PRD-007_INDEPENDENT_GAP_VERIFICATION.md).

Admission is sound because `PRD-007`'s specified behaviour is **deterministic under every candidate resolution** of
all fourteen — the same test `ADR-0018` applied to `SM-GAP-10` and `ADR-0019` to `MM-GAP-001`.

### 3.2 `SEAT-GAP-009` and the `PRD-006` occupancy dependency

`BC-04` derives occupancy from `BC-03` Attendance over `E-08`. `PRD-006` Attendance Management is `PLANNED` and
unwritten. A seating module built today would hold allocations correctly and derive **no** live occupancy.

This is a **scheduling fact, not a specification defect**, and it does not block freeze: `SEAT-FR-108`…`117` specify
the boundary as a port, and the Stage 6 backlog builds every integration against ports with fakes (`IMPL-502`).
Recorded here so no reader mistakes a frozen specification for a working feature.

### 3.3 Inherited open items, not opened by this ADR

`BLK-01`/`TASK-D10` (nine unwaived `app → domain/library` edges, gate 3 red by design under `ADR-0012`, expiry
2026-10-31) · `IMPL-020` SMS/DLT · `IMPL-220` `SID-INT-*` unenforced · `MM-GAP-010` (systemic BC Map §9 vs §7
`BC-26` defect) · `GCP-05`/`GCP-06`. None is caused by `PRD-007` and none is resolved by it.

### 3.4 Three stale `IMPL-*` allocation tables, recorded and deliberately not fixed

`PRD_LIFECYCLE.md`'s Stage 6 range table and `STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` §1.1 both end at
`IMPL-227+ Unallocated`, predating `IMPL-300`–`323`, `IMPL-400`–`441` and now `IMPL-500`–`599`.

Following the `ADR-0018` §3.4 and `ADR-0019` §3.6 precedent that **independently verified bytes are preserved rather
than tidied**, these are recorded here for a post-freeze clarifying pass. The occupancy enumeration in
`PRD-007_IMPLEMENTATION_TASKS.md` §3.1 — not any table — is the authority on what is free.

### 3.5 `TRACEABILITY_MATRIX.md` and the task backlog are not modified

Stage 7's gate is a baseline row. Neither document is amended by this admission, preserving the bytes Stage 5 and
Stage 6 independently verified.

### 3.6 Two pre-existing governance defects corrected in the same commit, and logged rather than absorbed

Executing this admission required reading `DOCUMENTATION_BASELINE.md` §4 and `PRD_REGISTRY.md` §4.1 closely enough
to add a row to each. Both turned out to be **already wrong, before `PRD-007` touched them**:

| Defect | What was wrong | Recorded as |
|---|---|---|
| Baseline §4 and its Rank 2 row | §4 held **four** Rank 3 module baselines and said *"four"*, though `ADR-0019` had admitted `PRD-005` at Rank 3 under `-D`; the Rank 2 row still read *"`ADR-0001` … `ADR-0017`"* after `ADR-0018` and `ADR-0019` were accepted | **`GCP-07`**, baseline §6 |
| `PRD_REGISTRY.md` §4.1 prose | Read *"**None was ever written.** All nine are `PLANNED`"* directly above a table showing `PRD-004` and `PRD-005` **`FROZEN`** | **`GCP-08`**, baseline §6 |

Both are corrected here because leaving a table wrong while adding a row to it would produce a *worse* record than
either state alone. Both are **logged** because absorbing them would have made this admission look like it added
one row when it in fact repaired two omissions — and because they are the same defect class: **a derived statement
left behind by a change to the thing it describes**, three instances now counting `GCP-01`. Three instances in
three documents is an argument for a mechanical check, not for more diligence, and both entries say so.

**Neither defect ever misconferred a status.** `PRD-005`'s Rank 3 authority came from baseline §3.3 and the
`ADR-0019` acceptance; the registry's operative record is its table, which was correct throughout. Only prose and
one index table were stale.

### 3.7 Ten mis-targeted citations, found after the gates passed and left standing

Authoring the developer guide required following the §8 gate table's *Authority* column rule by rule. Ten citations in `PRD-007` **name a rule that exists but governs something else** — `SEAT-BR-018`, `SEAT-BR-020` and `SEAT-BR-022` were renumbered during a Stage 4 correction pass, and the pointer columns did not follow the prose.

| Location | Cites | Which actually defines | Intended |
|---|---|---|---|
| §8 gate table, **G11** *Not in maintenance* | `SEAT-BR-020` | attendance non-ownership | `SEAT-FR-043` / `SEAT-BR-026` |
| §8 gate table, **G12** *Not locked* | `SEAT-BR-018` | booking mode | `SEAT-BR-025` |
| §8 gate table, **G15** *No conflicting reservation* | `SEAT-BR-011` | one allocation per seat | `SEAT-INV-004` / `SEAT-FR-042` |
| §6.4 invalid transitions, 3 rows | `SEAT-BR-020`, `SEAT-BR-018` | as above | `SEAT-FR-043` / `SEAT-BR-027` / `SEAT-BR-025` |
| Four parentheticals (§6.3, §6.4, §16.1) | `SEAT-BR-020`, `SEAT-BR-022` | as above | `SEAT-BR-026` |

**Six further candidates were examined and rejected** — the same three identifiers are cited *correctly* in the attendance rows, the flexible-seat rows and `SEAT-AC-212`, which is exactly why the drift is hard to see.

**This changes no behaviour and invalidates no gate.** Every gate's required behaviour is stated in its own *Gate* and *Failure reason* columns and restated normatively in the owning chapter; only the pointers are wrong. **It is not fixed**, on the explicit authority of Stage 7: *"A frozen PRD is never silently modified. Not for an obvious correction, and not for one that is certainly right"* — the rule that leaves `PGA-01` and `PGA-02` standing. Recorded as **`GCP-09`** for one clarifying-wording pass under baseline §7, which needs a changelog entry and **no** ADR.

**It also exposes a real limit of this repository's gates, which is the more useful finding.** Stage 5 proves every cited identifier **exists**; Stage 6 proves every obligation is **claimed**. Neither compares a citation's *meaning* to the cited rule's *text*, and no script here does — so a document can be mechanically spotless and still send a reader to the wrong rule ten times. Admission proceeds because the defect is navigational, but it is admitted **with this known limitation stated**, not as an unqualified clean bill.

---

## 4. Decision

**`PRD-SEAT-MANAGEMENT.md` v1.0 is admitted to the documentation baseline at Rank 3 as the authoritative
specification for `BC-04` Seating.** `PRD-007` becomes **`FROZEN`**.

1. **Rank 3.** The **sixth** module baseline, joining Authentication (`BC-18`), Library Management, Student Identity
   (`BC-10`), Student Management (`BC-01`) and Membership Management (`BC-02`). The five existing Rank 3 module
   baselines do not overlap and this one does not either: `BC-04` Seating is governed by `PRD-007` alone.
2. **The version is preserved at v1.0.** Freeze confers status; it does not renumber. `PRD-003` was admitted at
   v1.0, `PRD-004` at v1.2 and `PRD-005` at v1.4 — each at the version that was verified.
3. **No requirement identifier is added, removed, renumbered or reworded.** All 683 identifiers, all 226 acceptance
   criteria, all four closed events and all fourteen gaps are unchanged. The PRD's **only** edits are its *Status*,
   *Baseline*, *Rank* and *Authorities applied* metadata rows plus one changelog entry — exactly the
   governance-required freeze metadata, and nothing else.
4. **No ranked document is amended.** `MASTER_PRD.md`, the BC Map, the Dependency Matrix and
   `ARCHITECTURE_RULINGS.md` are untouched. **No integration edge is added.** No global business rule changes. No
   dependency law gains an exception. No bounded context is created — still **31**.
5. **The baseline identifier becomes `BASELINE-2026-08-04-E`**, because a Rank 3 document entered the baseline
   (Baseline §7 step 4).
6. **Fourteen gaps are admitted OPEN and are not ratified.**
7. **`PRD-007` is `FROZEN`, not `VERIFIED`.** Implementation is entirely unstarted: **0 of 100 tasks** and **0 of
   226 acceptance criteria** are proven by a test.

---

## 5. Options considered

| Option | Rejected because |
|---|---|
| **Admit at Rank 3** *(chosen)* | Every gate passes mechanically; the specification is complete for `BC-04` and no ranked document needs amending |
| Add `Status: FROZEN` to the PRD and stop | Freeze would be **claimed, not conferred**. `PRD_REGISTRY.md` §2.1 records that a PRD-local status has been wrong about all five earlier specifications. A metadata row without a baseline row confers nothing |
| Hold freeze until `PRD-006` exists | Would make `BC-04`'s freeze hostage to an unwritten document. The `E-08` boundary is specified as a port and is deterministic; `PRD-005` was frozen with `PRD-006`/`PRD-007` still `PLANNED` on the other side of `E-02` |
| Hold freeze until the fourteen gaps close | Each gap belongs to a named owner outside `BC-04`; `PRD-007` is deterministic under every resolution. `ADR-0018` froze with 2 open and `ADR-0019` with 5 — resolving them here would be deciding another owner's question |
| Renumber to v1.1 to mark the freeze | Stage 7 confers status, not content. Three precedents admit at the verified version |
| Amend the three stale `IMPL-*` tables while here | Amending governance is not part of Stage 7, and tidying independently verified bytes destroys the evidence trail (`ADR-0019` §3.6) |
| Admit at Rank 4 or 5 | Wrong rank. `PRD-007` is a module PRD specifying a `[CORE]` bounded context, which is exactly what Rank 3 holds |

---

## 6. Consequences

### 6.1 Immediate

- `PRD-007` is Rank 3 and **binding** for everything inside `BC-04` Seating.
- **Any business-rule change now requires an ADR → version increment → changelog → baseline update, in that order.**
- `PRD_REGISTRY.md`: `FROZEN` 5 → **6**; `PLANNED` 18 → **17**; missing V1 18 → **17**.
- Rank 2 extends to **`ADR-0020`**.
- Baseline → **`BASELINE-2026-08-04-E`**.
- The **three `[CORE]` contexts of the Library cluster on the `E-01`/`E-02` chain** — `BC-01`, `BC-02`, `BC-04` — are
  now frozen, so `PRD-006` and `PRD-008` inherit settled contracts on every side they touch.

### 6.2 What does **not** change

- No requirement, API, event, payload, invariant, acceptance criterion, business rule, register, exclusion, protected
  operation, configurable or scope statement in any PRD.
- `MASTER_PRD.md`, BC Map, Dependency Matrix, `ARCHITECTURE_RULINGS.md`, `TRACEABILITY_MATRIX.md`,
  `PRD-007_IMPLEMENTATION_TASKS.md` — all unmodified.
- No edge, no context, no dependency-law exception.
- **No code.** Freeze authorises implementation to *begin*; it does not perform it. No API specification, database
  schema or migration was written either.

**One gate script was maintained.** `tool/docs_check/prd007_traceability.py` had its collision-scan `ALLOWED`
list widened by **four named files** — this ADR, `DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md` and
`ADR-INDEX.md` — because recording a freeze *requires* the governance layer to cite the register being admitted,
and the list was written at Stage 5, before that had ever happened. This is not an exemption invented here:
`tool/docs_check/prd005_traceability.py` L245–252 already enumerates the identical four files for `MM-*`, on the
reasoning that *"a citation is not a collision"*, and `ADR-0018` did the same for `SM-*` — `ADR-0019` cites `MM-*`
**80 times** legitimately. The list stays **enumerated file by file rather than widened to a directory**, so a
stray `SEAT-` in any other governance document still fails; the duplicate-definition and form checks that detect a
genuine collision are untouched; and `lib/`, `test/` and `tool/` scanning is unchanged. Both gates were re-run at
**exit 0** after the change. Recorded in `PRD-007_STAGE7_FREEZE.md` §6.4.

### 6.3 Carried forward

All fourteen `SEAT-GAP-*`; the 118 obligations without an AC citation (named in §2.5); `BLK-01`/`TASK-D10`;
`IMPL-020`; `IMPL-220`; `MM-GAP-010`; `GCP-05`/`GCP-06`; the three stale allocation tables (§3.4); the `PRD-006`
occupancy dependency (§3.2).

---

## 7. Compliance

| Requirement | Where satisfied |
|---|---|
| Baseline §7 step 1 — ADR **before** the change | This document, written and reviewed before any ranked document was touched |
| Baseline §7 step 2 — version + changelog in the same commit | `PRD-007` v1.0 preserved; changelog entry added in the same commit |
| Baseline §7 step 3 — declaration updated in the same commit | `DOCUMENTATION_BASELINE.md` §2.4, §3.3, §3.4, §4, §8 |
| Baseline §7 step 4 — baseline id changes on a Rank 1–3 change | `BASELINE-2026-08-04-D` → **`-E`** |
| `PRD_LIFECYCLE.md` Stage 7 — a row in §3 at an assigned rank | `DOCUMENTATION_BASELINE.md` §3.3, Rank 3 in §4 |
| `PRD_REGISTRY.md` §2.1 — status conferred, never self-declared | Conferred here; the PRD's status row **cites** this ADR rather than asserting freeze on its own authority |
| `SEAT-BR-045` — no gap closed by implementation choice | §3.1; zero tasks assigned to any gap |
| `SID-4.56` / `SEAT-NFR-011` — unchecked rules are unmet | §2.5 admits 73.4%, not 100%; §4.7 admits 0 of 226 AC proven |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created and **Accepted**. Admits `PRD-007` Seat Management v1.0 to Rank 3 as the authoritative specification for `BC-04` Seating — the **sixth** module baseline and the **third** `[CORE]` context of the Library cluster to be frozen. Written **before** any ranked document was touched, per Baseline §7 step 1. Admission rests on Stage 4 **A — PASS** (0/0/0/0 after four correction passes, two re-reviews and a final independent review that rejected eight false positives), Stage 5 **A — PASS**, and Stage 6 **A — PASS** (8/8 gates); the Stage 5 and Stage 6 gate scripts were **re-run at exit 0 immediately before acceptance** — 683 identifiers across ten registers, 0 dangling, 0 orphans, 0 collisions, `SEAT-FR-302` 85/85, and 100 tasks `IMPL-500`…`IMPL-599` claiming **443/443 = 100.0%** of obligations with 0 cycles. **Version preserved at v1.0** following the `PRD-003`-at-v1.0, `PRD-004`-at-v1.2 and `PRD-005`-at-v1.4 precedents. **No requirement identifier added, removed, renumbered or reworded**; the PRD's only edits are its *Status*, *Baseline*, *Rank* and *Authorities applied* metadata rows and one changelog entry. **No ranked document amended, no integration edge added, no bounded context created (still 31), no global business rule changed, no dependency law exception granted.** `TRACEABILITY_MATRIX.md` and `PRD-007_IMPLEMENTATION_TASKS.md` **deliberately not modified** — Stage 7's gate is a baseline row, and the three stale `IMPL-227+` tables are recorded in §3.4 for a post-freeze pass rather than tidied. **All fourteen `SEAT-GAP-*` admitted OPEN and not ratified**; `SEAT-BR-045` forbids closing any by implementation choice and the backlog assigns them no task. **Verification coverage admitted at its measured value** — 85/85 = 100.0% of the registers `SEAT-FR-302` mandates, but **325/443 = 73.4%** of all obligations, with the 86 `SEAT-FR`, 5 `SEAT-NFR`, 18 `SEAT-PO` and 9 `SEAT-CFG` shortfall named rather than hidden. Baseline → **`BASELINE-2026-08-04-E`** (§7 step 4). `PRD-007` is **`FROZEN`, not `VERIFIED`** — **0 of 100 tasks and 0 of 226 acceptance criteria** are proven by a test, and `SID-4.56` holds that a rule that cannot be checked is treated as unmet. |
