# `PRD-007` Stage 6 Review

| Field | Value |
|---|---|
| **Document** | `PRD-007` Stage 6 review — Implementation Tasks |
| **Subject** | [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) v1.0 `DRAFT` |
| **Baseline** | `7b96c2ba3d843f4c29492aaa9719a1d1b91042f3` (Stage 5, verdict A) |
| **Subject hash** | `05dc6fb2fccfd7296d52960e86899e73ad08090ea77cea908dcee3fd38f7b943` — unchanged |
| **Artefact produced** | [`PRD-007_IMPLEMENTATION_TASKS.md`](../../40-implementation/seat-management/PRD-007_IMPLEMENTATION_TASKS.md) |
| **Gate script** | `tool/docs_check/prd007_task_coverage.py` → exit 0 |
| **Findings** | **0 CRITICAL · 0 HIGH · 0 MEDIUM · 0 LOW** |
| **Rejected false positives** | 5 |
| **Verdict** | **A — PASS** |
| **Stage** | 6 of 9. Stage 7 **not** entered. `PRD-007` remains `DRAFT` and unfrozen. |
| **Date** | 2026-08-04 |

---

## 1. Verdict

**A — PASS.**

Stage 6's gate is satisfied: an `IMPL-*` range is allocated (`IMPL-500` … `IMPL-599`), and a task document exists in
which **every one of 100 tasks traces back to requirements** — verified mechanically, not asserted. All four
allocation rules are met. Every Stage 4 and Stage 5 invariant was recalculated from the PRD and reproduced exactly.

This verdict is **not** a freeze, a registry advance, or authorisation to write code.

---

## 2. Stage 6 definition — quoted from governance

Stage 6 was **not** inferred from naming. The authoritative definition is
[`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L135–150, quoted verbatim:

> ### Stage 6 — Implementation Tasks
>
> **Gate:** an `IMPL-*` range allocated and a task document in which **every task traces back to requirements**.
>
> Allocation rules:
> 1. Take the next free range. **Never reuse or reassign a number** — cross-references in commits, reviews and test
>    names outlive the document.
> 2. Leave the previous group room to grow contiguously. Student Identity starts at `IMPL-200`, not `IMPL-128`, so
>    Library Management can extend.
> 3. Record `Priority`, `Blocks`, `Blocked by` per task.
> 4. Add a traceability table mapping task groups → requirements → invariants → acceptance.

Three consequences govern this review:

**(a) Stage 6 is an artefact-producing gate, not a review of the PRD.** Stages 4 and 5 reviewed the specification.
Stage 6 produces a backlog. Its exit criterion is a property of the *new* document, not a re-litigation of the PRD.

**(b) `IMPL-*` allocation is explicitly required.** The general instruction not to allocate `IMPL-*` identifiers is
conditioned on *"unless Stage 6 governance explicitly requires it"* — and the gate's first clause is precisely that
requirement. The same applies to producing a task document.

**(c) Stage 6 does not confer freeze.** Stage 7 is separately defined at L155 as *"a row in
`DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank."* No such row was added. Nothing was frozen, and
`PRD_REGISTRY.md` still records `PRD-007` as `PLANNED`.

A more specific procedure than the lifecycle text exists in the form of a **completed precedent**:
[`PRD-005_IMPLEMENTATION_TASKS.md`](../../40-implementation/membership-management/PRD-005_IMPLEMENTATION_TASKS.md)
(443 lines, 12 sections) and its gate `tool/docs_check/prd005_task_coverage.py` (309 lines). Both were read in full
and followed — document structure, 8-column table shape, obligation-denominator rule, exit-gate section, and the
practice of disclosing authoring defects the tool caught.

---

## 3. Scope

**In scope.** Allocating a free `IMPL-*` range; authoring the `PRD-007` task backlog; a re-runnable gate script;
recomputing Stage 4/5 invariants; verifying repository integrity.

**Out of scope and not done.** No PRD text, requirement, identifier or acceptance criterion was altered. No API
specification, database schema, DDL, SQL, implementation specification, widget tree, class signature, estimate,
deployment configuration or line of Dart was written. No development started. Stage 7 not entered. No ADR created.
`TRACEABILITY_MATRIX.md`, `MASTER_PRD.md`, `PRD_REGISTRY.md`, `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, every
ADR, every architecture document, and every other PRD and backlog are byte-identical to baseline.

**Baseline confirmation.** An auto-backup commit `438d9aa` fired during an interrupt, capturing the in-progress gate
script. Because `github/main` was still at `7b96c2b`, the commit was undone with `git reset --soft 7b96c2b` followed
by `git reset`, restoring the required baseline exactly and returning the script to untracked working state. HEAD was
re-verified as `7b96c2b` and the PRD hash re-verified as `05dc6fb2…` before any file was written.

---

## 4. Gate results

The repository's actual Stage 6 gates, not invented ones. Clause 1 and clause 2 are the gate sentence; rules 1–4 are
the allocation rules quoted in §2.

| # | Gate (source) | Requirement | Measured | Result |
|---|---|---|---|---|
| G1 | Gate clause 1 | An `IMPL-*` range allocated | `IMPL-500` … `IMPL-599`, 100 contiguous numbers | ✅ PASS |
| G2 | Gate clause 2 | A task document exists | `docs/40-implementation/seat-management/PRD-007_IMPLEMENTATION_TASKS.md`, 519 lines, 12 sections | ✅ PASS |
| G3 | Gate clause 2 | **Every task traces back to requirements** | 100/100 tasks carry a non-empty Requirements cell; 0 tasks untraced | ✅ PASS |
| G4 | Rule 1 | Next free range; never reuse or reassign | 144 `IMPL-*` enumerated repo-wide; 0 duplicates; 0 outside range; 0 collisions with the 5 foreign ranges | ✅ PASS |
| G5 | Rule 2 | Leave the previous group room to grow | `IMPL-442`–`499` skipped as `PRD-005`'s declared reserve; allocation starts at `IMPL-500` | ✅ PASS |
| G6 | Rule 3 | Record `Priority`, `Blocks`, `Blocked by` per task | 0 blank Priority; 0 unresolvable `Blocked by`; 0 `Blocks`/`Blocked by` disagreements; 0 self-dependencies | ✅ PASS |
| G7 | Rule 4 | Traceability table: groups → requirements → invariants → acceptance | §6, 10 wave rows, 4 columns as mandated | ✅ PASS |
| G8 | Derived from G3 | Every cited requirement exists; no `SEAT-GAP-*` cited as an obligation | 0 undefined citations; 0 GAP citations; 0 malformed ranges | ✅ PASS |

**All 8 gates PASS.** `python3 tool/docs_check/prd007_task_coverage.py` → **exit 0**.

Coverage in the reverse direction — every obligation claimed by at least one task — is not literally demanded by the
gate sentence, which is one-directional. It was measured anyway, at **443/443 = 100.0%**, and made a failure
condition of the gate script so the property cannot silently regress.

---

## 5. Mechanical verification

Every figure below was recalculated from `PRD-SEAT-MANAGEMENT.md` in this stage. **No figure was copied from the
Stage 4 or Stage 5 report.** Three independent code paths were used — the Stage 5 gate, a separate
obligation-mapping script, and the task generator's own register read — and all three agreed.

### 5.1 Stage 5 invariants, recalculated

| Property | Expected (Stage 5) | Measured now | Result |
|---|---|---|---|
| Registers | 10 | 10 | ✅ |
| `SEAT-FR` | 304 | 304 | ✅ |
| `SEAT-BR` | 45 | 45 | ✅ |
| `SEAT-INV` | 14 | 14 | ✅ |
| `SEAT-EVT` | 4 | 4 | ✅ |
| `SEAT-XC` | 22 | 22 | ✅ |
| `SEAT-PO` | 24 | 24 | ✅ |
| `SEAT-CFG` | 18 | 18 | ✅ |
| `SEAT-NFR` | 12 | 12 | ✅ |
| `SEAT-AC` | 226 | 226 | ✅ |
| `SEAT-GAP` | 14 | 14 | ✅ |
| Total identifiers | 683 | 683 | ✅ |
| Dangling references | 0 | 0 | ✅ |
| Orphan criteria | 0 | 0 | ✅ |
| `SEAT-FR-302` rule-register coverage | 85/85 | 85/85 | ✅ |
| Cross-module collisions | 0 | 0 | ✅ |
| Stage 5 gate exit code | 0 | 0 | ✅ |

### 5.2 Allocation, computed not chosen

| Property | Method | Measured | Result |
|---|---|---|---|
| Distinct `IMPL-*` in repository | `grep -rhoE 'IMPL-[0-9]{3}' docs/ tool/ lib/ test/ \| sort -u` | 144 | ✅ |
| Highest token present | same enumeration | `IMPL-500` | ✅ |
| Is `IMPL-500` occupied? | opened the **only** hit, `PRD-005_IMPLEMENTATION_TASKS.md:96` | `\| IMPL-500 + \| Unallocated \| — \|` — a marker declaring the number free, **not a use** | ✅ free |
| `IMPL-442`–`499` | `PRD-005` §3.2 declares it that backlog's growth reserve | skipped under rule 2 | ✅ |
| Allocated range | next free contiguous hundred | `IMPL-500` … `IMPL-599` | ✅ |
| Contiguity | generator asserts `ids == range(500, 600)` | 100 numbers, no gaps | ✅ |

A maximum cannot distinguish an allocation from an "unallocated" marker; the source line can. This is why the token
was inspected rather than the enumeration's ceiling trusted.

### 5.3 Obligation denominator, recomputed

| Step | Value |
|---|---|
| Total identifiers | 683 |
| less `SEAT-AC-*` — *verified by* a task's test, not *built* by a task | − 226 |
| less `SEAT-GAP-*` — open questions; §0.3: *"must never be cited as verifiable"* | − 14 |
| **Obligations a task can claim** | **443** |

The same rule `PRD-005` applied (333 − 97 − 13 = 223), so the denominator is precedent-consistent rather than
convenient. `SEAT-BR-045` (no gap may be resolved by implementation choice) makes excluding GAPs mandatory, not
optional — which is why the gate script treats a `SEAT-GAP-*` in a Requirements cell as a hard failure.

### 5.4 Task graph

| Property | Expected (doc §11) | Measured | Result |
|---|---|---|---|
| Tasks parsed | 100 | 100 | ✅ |
| Unique IDs | 100 | 100 | ✅ |
| Duplicates | 0 | 0 | ✅ |
| Outside `IMPL-500`–`599` | 0 | 0 | ✅ |
| Foreign-range collisions | 0 | 0 | ✅ |
| Tasks with no requirement | 0 | 0 | ✅ |
| Undefined citations | 0 | 0 | ✅ |
| Malformed ranges | 0 | 0 | ✅ |
| Unresolvable dependencies | 0 | 0 | ✅ |
| Blank Priority | 0 | 0 | ✅ |
| `Blocks`/`Blocked by` disagreements | 0 | 0 | ✅ |
| Dependency cycles | 0 | 0 | ✅ |
| Longest chain | 18 | 18 | ✅ |
| Roots / leaves | 1 / 1 | 1 `IMPL-500` / 1 `IMPL-599` | ✅ |
| Priority split | 64 P1 / 32 P2 / 4 P3 | 64 / 32 / 4 | ✅ |

### 5.5 Obligation coverage by register

| Register | Claimed / defined | Result |
|---|---|---|
| `SEAT-FR` | 304 / 304 | ✅ |
| `SEAT-BR` | 45 / 45 | ✅ |
| `SEAT-INV` | 14 / 14 | ✅ |
| `SEAT-EVT` | 4 / 4 | ✅ |
| `SEAT-XC` | 22 / 22 | ✅ |
| `SEAT-PO` | 24 / 24 | ✅ |
| `SEAT-CFG` | 18 / 18 | ✅ |
| `SEAT-NFR` | 12 / 12 | ✅ |
| **TOTAL** | **443 / 443 = 100.0%** | ✅ |

### 5.6 Negative testing of the gate script

`SEAT-NFR-011`, quoting `SID-4.56`, requires that *"a rule that cannot be checked SHALL be treated as unmet, not as
satisfied by intent."* An exit-0 gate is evidence only if it can also fail. Eight defects were injected one at a
time, each reverted, with the document hash re-verified as `e2a47d3d…` and the PRD hash as `05dc6fb2…` after every
revert.

| # | Injected defect | Detected | Message |
|---|---|---|---|
| N1 | Blank Requirements cell on `IMPL-533` | exit 1 | `Tasks with NO requirement : 1 ['IMPL-533']` |
| N2 | Citation to undefined `SEAT-FR-999` | exit 1 | `Citations to undefined IDs : 1 ['IMPL-534 -> SEAT-FR-999']` |
| N3 | `SEAT-GAP-009` cited as an obligation | exit 1 | `1 ['IMPL-535 -> SEAT-GAP-009 (GAP cited as an obligation)']` |
| N4 | Duplicate `IMPL-535` | exit 1 | `Duplicate IMPL IDs : 1 ['IMPL-535']` + self-dependency + cycle |
| N5 | Out-of-range/foreign `IMPL-450` | exit 1 | `Outside range : 1` **and** `Colliding with another backlog : 1` |
| N6 | Blanked Priority on `IMPL-538` | exit 1 | `Tasks with no Priority : 1 ['IMPL-538']` |
| N7 | Dropped a `Blocks` entry on `IMPL-500` | exit 1 | `Blocks/Blocked-by disagreements : 1` |
| N8 | Injected cycle `IMPL-501` ← `IMPL-504` | exit 1 | `Dependency cycles : 1 ['IMPL-501']` |

**8/8 detected, each with precise attribution.** The gate re-ran clean on the restored document (exit 0). The script
is therefore a checker, not a rubber stamp.

---

## 6. Findings

**0 CRITICAL · 0 HIGH · 0 MEDIUM · 0 LOW.**

No finding is raised against `PRD-007`. Stage 4 closed its requirement defects (verdict A, 0/0/0/0) and Stage 5 closed
its traceability defects (verdict A); this stage re-verified both and reproduced every invariant. The Stage 6 artefact
passes its own gate on all 8 clauses.

### 6.1 One defect found and corrected during authoring — in my own work, not the PRD

Disclosed under the `PRD-005` §12 precedent of recording authoring defects the tool caught.

**Defect.** The first generator run reported **29 leaves**. Investigation showed `IMPL-599` — the acceptance harness
that must prove all 226 `SEAT-AC-*` — did not transitively depend on `IMPL-589` (multi-tenancy), although
`SEAT-AC-185`–`208` require exactly that work. A hand-written `Blocked by` list had omitted it.

**Correction.** Rather than patch one edge, the harness's dependency set was replaced with a *rule* computed from the
graph — "blocked by every otherwise-terminal task" — guarded by an assertion. Re-run: 1 root, 1 leaf, 0 cycles, chain
18. A hand-written list can be wrong again; a derived one cannot drift silently. Recorded in the task document's §7
and §12.

### 6.2 One regression found and corrected in the gate script

**Observation.** After the task document was assembled, `prd007_traceability.py` (the Stage 5 gate) began exiting **1**
where it had exited 0 at baseline:

```
FAIL — 1 problem(s):
  * SEAT-* found in tool/: ['tool/docs_check/prd007_task_coverage.py:21:SEAT-FR-9', ...]
```

**Cause.** The Stage 5 gate forbids `SEAT-*` identifier literals anywhere under `tool/`, `lib/` or `test/`
(L284–289), self-exempting only its own filename. My new gate script contained three *illustrative* `SEAT-FR-0nn`
examples in docstring comments. `PRD-005`'s equivalent script never hit this because `prd005_traceability.py` has no
such check — the precedent could not warn me.

**Correction.** The three comments were reworded to describe the range forms without numerals. The regex logic and
every behaviour are unchanged; the eight negative tests and the exit-0 run above were all performed on the corrected
script. **The Stage 5 invariant was preserved by fixing my new file, not by relaxing the older gate** — weakening
`prd007_traceability.py` to accommodate my script would have been exactly the "modify the check to make the stage
pass" move the instruction forbids. Both gates now exit 0.

### 6.3 Disclosed, deliberately not corrected: three stale allocation tables

`PRD_LIFECYCLE.md`'s Stage 6 range table ends `| IMPL-227+ | **Unallocated** |`, and
`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` §1.1 says the same. Both predate `PRD-004`'s `IMPL-300`–`323` and
`PRD-005`'s `IMPL-400`–`441`. With this document's `IMPL-500`–`599`, **three tables are now stale, not one.**

This is **not a new finding.** `PRD-004`'s backlog records it, and `PRD-005` §3.3 records it again while stating the
governing rule: *"the occupancy enumeration in §3.1, not the table, is the authority on what is free."* That
precedent also states that amending governance or another backlog's allocation table *"is outside Stage 6 and is
explicitly forbidden."*

The staleness is therefore **disclosed in the task document's §3.3 and §9 and left uncorrected**. It is harmless
because allocation was computed from repository occupancy, not read from any table.

### 6.4 Rejected false positives

Candidates considered and rejected with reasons, so they are not silently dropped.

| # | Candidate | Rejected because |
|---|---|---|
| FP-1 | "`IMPL-500` is the enumeration's maximum, so the range must start at `IMPL-501`." | The single occurrence is `PRD-005` §3.2's `\| IMPL-500 + \| Unallocated \| — \|` marker — a declaration that the number is free. A marker is not an allocation. Verified by reading the source line, not the maximum. |
| FP-2 | "Overall AC coverage is 325/443 = 73.4%, so Stage 6 coverage is incomplete." | Two different measurements. 73.4% is Stage 5's *AC-citation* coverage of obligations, deliberately partial: `SEAT-FR-302` mandates AC coverage only for BR/INV/EVT/XC, measured 85/85. Stage 6 measures *task* coverage of obligations: 443/443. Conflating them would invent a gate. |
| FP-3 | "`SEAT-AC-*` and `SEAT-GAP-*` are unclaimed by any task — 240 gaps." | Excluded by design and by the PRD's own words. An AC is verified by a task's test, not built by a task; §0.3 forbids citing a GAP as verifiable and `SEAT-BR-045` forbids resolving one by implementation choice. Same denominator rule `PRD-005` used. |
| FP-4 | "Waves 3 and 4 both claim acceptance band `SEAT-AC-028`–`035`, so the §6 mapping double-counts." | A legitimate overlap: the band spans obligations defined across both waves' sections. It is disclosed in §6 and §9 rather than hidden, and it does not affect the obligation denominator, which is computed per identifier. |
| FP-5 | "`check_module_boundaries.dart` is RED and `prd004_traceability.py` exits 1, so the repository gates fail." | Both are pre-existing, owned and unrelated: 9 unwaived `app → domain/library` edges under `TASK-D10`/`BLK-01` (`ADR-0012`, expiry 2026-10-31), and two untraced `SM-10.7`/`SM-10.8` in `PRD-004`. Neither is caused by, nor in scope for, Stage 6. Importing another document's known debt as a finding here would be an other-PRD improvement. |

---

## 7. PRD integrity

| Check | Result |
|---|---|
| `PRD-SEAT-MANAGEMENT.md` SHA-256 | `05dc6fb2fccfd7296d52960e86899e73ad08090ea77cea908dcee3fd38f7b943` — **identical to Stage 4 and Stage 5** |
| `git diff 7b96c2b -- PRD-SEAT-MANAGEMENT.md` | empty |
| Requirements altered | none |
| Requirement wording altered | none |
| Identifiers added, removed or renumbered | none |
| Acceptance criteria altered | none — all 226 intact |
| `SEAT-GAP-*` resolved or reinterpreted | none — all 14 remain open |
| Version / status | v1.0 `DRAFT` — unchanged, unfrozen |
| `IMPL-*` occurrences inside the PRD | 0 — the backlog references the PRD, never the reverse |

No requirement was weakened to make a task fit. Where a task's scope was awkward, the task was reshaped.

---

## 8. Repository integrity

| Path | Expected | Result |
|---|---|---|
| `docs/30-product/seat-management/PRD-SEAT-MANAGEMENT.md` | byte-identical | ✅ `05dc6fb2…` |
| `docs/40-implementation/TRACEABILITY_MATRIX.md` | byte-identical (Stage 6 does not touch registries; `PRD-005`'s Stage 6 changed none) | ✅ `bc7fd9e7…` |
| `docs/30-product/MASTER_PRD.md` | byte-identical | ✅ `5c31a336…` |
| `docs/00-governance/prd-ecosystem/PRD_LIFECYCLE.md` | unmodified — stale table disclosed, not edited | ✅ |
| `docs/00-governance/prd-ecosystem/PRD_REGISTRY.md` | unmodified — `PRD-007` still `PLANNED` | ✅ |
| `docs/00-governance/DOCUMENTATION_BASELINE.md` | unmodified — no §3 row added, no rank assigned | ✅ |
| All ADRs, all `docs/10-architecture/` | unmodified | ✅ |
| All other PRDs and backlogs, incl. `PRD-004`/`PRD-005` allocation tables | unmodified | ✅ |
| `lib/`, `test/`, `pubspec.yaml` | unmodified — nothing implemented | ✅ |
| `git diff --stat 7b96c2b -- docs/ lib/ test/ tool/ pubspec.yaml` | empty (additions only) | ✅ |

Two additions, zero modifications:

```
A  docs/40-implementation/seat-management/PRD-007_IMPLEMENTATION_TASKS.md
A  tool/docs_check/prd007_task_coverage.py
A  docs/30-product/seat-management/PRD-007_STAGE6_IMPLEMENTATION_TASKS.md  (this report)
```

Temporary scripts were kept in `/tmp/s6/`, outside the repository, and deleted before commit.

---

## 9. Delivery

| Artefact | Path | Hash / size |
|---|---|---|
| Task backlog (the Stage 6 gate artefact) | `docs/40-implementation/seat-management/PRD-007_IMPLEMENTATION_TASKS.md` | `e2a47d3d…`, 519 lines |
| Re-runnable gate | `tool/docs_check/prd007_task_coverage.py` | 13 573 bytes |
| This review | `docs/30-product/seat-management/PRD-007_STAGE6_IMPLEMENTATION_TASKS.md` | — |

Backlog contents: 12 sections. §1 what the document is not · §2 prerequisites verified · §3 allocation with the
occupancy enumeration and the staleness disclosure · §4 ten blocking dependencies outside `PRD-007` · §5 the 100 tasks
in 10 waves, 8 columns · §6 rule-4 traceability plus per-register totals · §7 the 18-task critical path, derived ·
§8 nineteen tasks that **must not** be created · §9 fourteen things the document does not claim · §10 definition of
done · §11 the exit gate and its failure conditions · §12 change history.

Re-run at any time:

```
python3 tool/docs_check/prd007_task_coverage.py     → exit 0
python3 tool/docs_check/prd007_traceability.py      → exit 0   (Stage 5, unchanged)
```

---

## 10. Final decision

**Verdict A — PASS.** Stage 6 is complete for `PRD-007` v1.0.

Both clauses of the gate are satisfied and all four allocation rules are met: `IMPL-500` … `IMPL-599` allocated from
computed occupancy, and a task document in which every one of 100 tasks traces back to requirements — 0 untraced, 0
undefined citations, 0 GAPs cited as obligations, 443/443 obligations claimed, `Blocks` and `Blocked by` mutually
consistent, 0 cycles, and a gate proven to fail against 8 injected defects. Every Stage 4 and Stage 5 invariant was
recalculated from the PRD and reproduced. `PRD-007` is byte-identical to its Stage 5 baseline.

**Stage 6 confers no freeze.** `PRD-007` remains v1.0 `DRAFT`, `PRD_REGISTRY.md` still records it as `PLANNED`, and no
row was added to `DOCUMENTATION_BASELINE.md` §3. Nothing is implemented: no schema, SQL, DDL, API shape, widget tree,
class signature, estimate, deployment configuration or Dart code was produced, and zero `lib/` files changed.

**Work stops here.** Stage 7 (Freeze) is a separate gate and is not authorised by this review.

### Carried forward, unchanged and owned elsewhere

`SEAT-GAP-001`…`014` open (no task may close one — §8) · 5 `SEAT-NFR` / 18 `SEAT-PO` / 9 `SEAT-CFG` without ACs,
outside `SEAT-FR-302`'s mandate · `PRD-006` `E-08` and `PRD-005` `E-02` projections required before waves 5–6 can be
completed against real adapters · `TASK-D10`/`BLK-01` (9 unwaived `app → domain/library` edges, `ADR-0012` expiry
2026-10-31) · `prd004_traceability.py` exit 1 (`SM-10.7`, `SM-10.8`) · three stale `IMPL-227+` allocation tables,
disclosed in §6.3.

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Stage 6 review of `PRD-007` v1.0 at baseline `7b96c2b`. Verdict **A — PASS**, 8/8 gates. Located the authoritative Stage 6 definition in `PRD_LIFECYCLE.md` L135–150 and followed the completed `PRD-005` precedent read in full. Allocated `IMPL-500`…`IMPL-599` from a repo-wide enumeration of 144 `IMPL-*`, proving `IMPL-500` free by inspecting its single token at source rather than trusting the maximum. Recalculated every Stage 4/5 invariant by three independent code paths — 683 identifiers, 443 obligations, 0 dangling, 0 orphans, `SEAT-FR-302` 85/85, 0 collisions, Stage 5 gate exit 0. Produced a 100-task backlog with 443/443 = 100.0% obligation coverage and a gate script negative-tested against 8 injected defects, 8/8 detected. Disclosed one authoring defect I found and fixed (the `IMPL-599` ancestry gap, now graph-derived), one regression I introduced and fixed in the correct direction (`SEAT-*` literals leaking into `tool/`, fixed in my new script rather than by weakening the Stage 5 gate), and three stale allocation tables left uncorrected as governance-out-of-scope. Rejected 5 false positives with reasons. `PRD-007` byte-identical at `05dc6fb2…`; `TRACEABILITY_MATRIX.md`, `MASTER_PRD.md`, `PRD_REGISTRY.md`, `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, all ADRs, all architecture documents, all other backlogs and `lib/` unmodified. No freeze, no registry advance, no ADR, no specification, no code. |
