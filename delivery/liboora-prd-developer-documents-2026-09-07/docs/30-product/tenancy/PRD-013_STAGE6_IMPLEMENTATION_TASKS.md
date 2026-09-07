# `PRD-013` Stage 6 — Implementation Tasks Gate

| Field | Value |
|---|---|
| **Act** | 📐 **MEASUREMENT** — this document records what was counted. It confers nothing. The artefact it certifies is the task document, and the gate is the script |
| **Subject** | [`PRD-013_TENANCY.md`](PRD-013_TENANCY.md) v0.1 `DRAFT` |
| **Subject hash** | `688239cb28c96648addbed4d08081ed2821e867e5873a1f028ae3c49f0f1ba9c` — **unchanged** by this stage |
| **Baseline** | `BASELINE-2026-08-17-A` · Stage 5 conferred by [`PRD-013_STAGE5_CONFERRAL.md`](PRD-013_STAGE5_CONFERRAL.md) |
| **Artefact produced** | [`../../40-implementation/tenancy/PRD-013_IMPLEMENTATION_TASKS.md`](../../40-implementation/tenancy/PRD-013_IMPLEMENTATION_TASKS.md) (`cffa8349…95fe3`, 409 lines) |
| **Range allocated** | **`IMPL-800` … `IMPL-829`** — 30 tasks; `IMPL-830`…`899` declared as growth reserve |
| **Gate script** | [`tool/docs_check/prd013_task_coverage.py`](../../../tool/docs_check/prd013_task_coverage.py) (`0e2d5b39…75b4d`) → **exit 0** |
| **Authority** | **Implementation Lead**, exercised by direct, explicit and unconditional conferral of the human principal of this engagement (§0) |
| **Findings** | **0 CRITICAL · 0 HIGH · 0 MEDIUM · 0 LOW** — after 1 self-inflicted correction, §3.2 |
| **Carried forward** | **2 code-vs-requirement contradictions** (`D-013-01`, `D-013-02`) recorded, owners named, **not fixed** |
| **Verdict** | ✅ **A — PASS** |
| **Stage** | 6 of 9. Stage 7 **not** entered by this document. **0 of 13 acceptance criteria are proven.** |
| **Status of this record** | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md` |
| **Date** | 2026-08-19 |

---

## 0. Authority — stated, because Stage 6 has an owner

`PRD_LIFECYCLE.md` §6 assigns **Stages 6 and 8** to the **Implementation lead**. L283 records that *"Every PRD needs a
named owner. **None has one**"* (`PGA-08`), so there is no standing holder of that role for `PRD-013`.

The authority relied on here is the same form `PRD-008_STAGE4_CONFERRAL.md` established and `ADR-0033` §7.2 describes:
direct, explicit and unconditional conferral by the human principal, scoped to one act. The instruction was to
*"Stage 6 requirements/implementation readiness gate complete karo"* and to handle each stage's artefacts *"lifecycle ke
exact rules ke according"*. **That instruction is the authority, and it is the only authority claimed.**

**Scope: this act only.** `ADR-0033` §7.1 — *"A conferral for one act is not a standing licence."* It confers nothing
about Stage 7, which belongs to the Governance Owner, and it does **not** cure `PGA-08`: `PRD-013` still has no
standing named owner after this record exists.

---

## 1. What the gate required, and what exists

`PRD_LIFECYCLE.md` Stage 6, verbatim:

> **Gate:** an `IMPL-*` range allocated and a task document in which **every task traces back to requirements**.

Both halves exist. An `IMPL-*` range is allocated (**`IMPL-800` … `IMPL-829`**) and a task document exists in which
**every one of 30 tasks traces back to requirements** — verified mechanically, not asserted. All four allocation rules
are met, each measured separately in §2.

Two notes on the general instructions this stage sits inside:

**(a) `IMPL-*` allocation is explicitly required.** The standing instruction not to allocate `IMPL-*` identifiers
applies *"tabhi … jab lifecycle explicitly require kare"*. Stage 6's gate **is** that explicit requirement; this is the
one stage at which allocation is not merely permitted but mandatory.

**(b) No file was modified that the gate did not require.** The gate requires a task document and a means of verifying
it. Two files were created. **Nothing else was touched** — not the PRD, not the matrix, not the registry, not the
baseline, not the alignment record, not `PRD_LIFECYCLE.md`, not another module's backlog, and not one line under `lib/`.

---

## 2. The gate clause by clause — measured

| ID | Clause | Rule | Measurement | Result |
|---|---|---|---|---|
| **`G1`** | An `IMPL-*` range is allocated | Gate, first half | `IMPL-800`…`IMPL-829`, 30 contiguous numbers; span has no internal gaps | ✅ |
| **`G2`** | A task document exists | Gate, second half | `PRD-013_IMPLEMENTATION_TASKS.md`, 409 lines, 30 task rows parsed from §5 | ✅ |
| **`G3`** | Every task traces back to requirements | Gate, the operative clause | 30 of 30 Requirements cells non-empty; **0** tasks cite no `TEN-*` | ✅ |
| **`G4`** | Take the next free range; never reuse or reassign | Rule 1 | **418** distinct `IMPL-*` enumerated across `docs/ tool/ lib/ test/`; highest **799**; the whole `IMPL-8xx` decade returns **0** hits. 0 duplicates, 0 outside `800`–`829`, **0 numbers below 800** | ✅ |
| **`G5`** | Leave the previous group room to grow contiguously | Rule 2 | `IMPL-700`…`799` is `PRD-008`'s (`ADR-0049`, 83 tasks); starting at `800` leaves its decade band intact. `IMPL-830`…`899` declared as **this** module's reserve for the 4 open `TEN-GAP-*` | ✅ |
| **`G6`** | Record `Priority`, `Blocks`, `Blocked by` per task | Rule 3 | 30 of 30 carry a valid `P1`/`P2`/`P3`; **52 edges**; `Blocks` and `Blocked by` agree in **both** directions with **0** disagreements; 0 unresolvable dependencies; 0 cycles; 1 root, 1 leaf | ✅ |
| **`G7`** | Traceability table: group → requirements → invariants → acceptance | Rule 4 | §6 present, three waves, all four columns; published totals **recomputed** by the script and required to match | ✅ |
| **`G8`** | Obligation coverage | Implied by `G3` | **34 / 34 = 100.0%** obligation-bearing identifiers claimed by ≥1 task; **0** uncovered | ✅ |
| **`G9`** | No retired identifier is cited | Rule 1, extended | 12 retired `TEN-*` enumerated from §9; **0** appear in any Requirements cell | ✅ |
| **`G10`** | No open gap or criterion is cited as an obligation | `PRD-013` §0.3 discipline | **0** `TEN-GAP-*` and **0** `TEN-AC-*` in any Requirements cell. `TEN-CFG-*` is declared empty and cannot be claimed | ✅ |
| **`G11`** | No identifier is invented | Standing rule | Every cited `TEN-*` resolves to an in-force definition in `PRD-013`; **0** undefined citations, **0** malformed ranges | ✅ |
| **`G12`** | The subject is unmodified | Standing rule | `PRD-013` sha256 `688239cb…ba9c` before and after; matrix `c69ed488…800f` unchanged | ✅ |
| **`G13`** | No `ResidencyRegion` value is asserted | `TEN-GAP-001`, `ADR-0041` L214 | **0** candidate values named anywhere in the task document. `IMPL-808` implements immutability in a form testable with **no** enumeration in existence, per `TEN-AC-010` (*"whatever value is supplied"*) | ✅ |

### 2.1 Reproducible

```
python3 tool/docs_check/prd013_task_coverage.py     → exit 0

  tasks parsed        : 30  (IMPL-800..829)
  obligations         : 34 claimed / 34 in force  = 100.0%
  longest chain       : 9
  roots / leaves      : IMPL-800 / IMPL-829
```

All three `PRD-013` gates run clean together:

```
python3 tool/docs_check/prd013_traceability.py      → exit 0   (Stage 5, PRD-internal)
python3 tool/docs_check/prd013_stage5.py           → exit 0   (Stage 5, matrix agreement)
python3 tool/docs_check/prd013_task_coverage.py    → exit 0   (Stage 6, task coverage)
```

### 2.2 Disclosed limits of this measurement

A review that hides its own limits is not a review.

| Limit | Why it is a limit, not a finding |
|---|---|
| **100% coverage means every obligation has a task, not that any obligation is met.** §4.1 of the task document measures 9 obligations as satisfied-but-untested, 23 as unstarted and 2 as actively contradicted | Coverage is a property of the *plan*. Reading 34/34 as progress is the misreading this row exists to prevent |
| **0 of 13 `TEN-AC-*` are proven.** `find test -iname '*tenan*'` returns nothing | Stage 6's gate says nothing about tests. Stage 8 does |
| **`TEN-CFG-*` is vacuously satisfied** — its one member is retired, so the "no configurable uncovered" check cannot fail | Recorded as vacuously satisfied, not as evidence of configuration discipline. Same disposition as the Stage 5 conferral's C3 row |
| **Five exclusion tasks are currently vacuous** — `TEN-XC-001`…`006` hold because the forbidden types are absent repo-wide, not because anything prevents their appearance | A structural test that would *keep* them absent is `IMPL-820`…`825`'s deliverable and does not exist |
| **The four `TEN-GAP-*` remain OPEN** | Stage 6's gate does not require resolving gaps. §8 of the task document lists the four tasks that would have closed them by implementation choice, so the omission is a visible decision |
| **`PGA-08` is not cured** | This record is a single conferred act, not the appointment of an owner |
| **The alignment record's hash is still stale** | Assessed in the Stage 5 conferral §4 as not requiring re-alignment; deliberately not rewritten. Routed to the Architecture Reviewer, unchanged by Stage 6 |
| **`dart run tool/check_module_boundaries.dart` exits 1** repo-wide on 9 pre-existing `app → domain/library` violations | Unrelated to `BC-19` and pre-existing. Not caused, not fixed, not concealed |

---

## 3. The measurement caught two things — one about the repository, one about this document

### 3.1 The repository: `BC-19` is partly implemented, and `PRD-013` does not know it

The `IMPL-*` enumeration was run against `docs/ tool/ lib/ test/`. Extending the same discipline to the module path
found **`lib/platform/tenancy/tenancy.dart`** — 85 lines, commit `a44ebb0`, written **before `PRD-013` existed**.

Measured obligation by obligation in the task document's §4.1: **9 satisfied but untested, 23 unstarted, 2
contradicted.** The two contradictions are recorded as findings against the **code**, not against the PRD:

| ID | Contradiction | Owner | Why not fixed here |
|---|---|---|---|
| **`D-013-01`** | `Branch` is declared in `platform/tenancy`, but Bounded Context Map L210 assigns `Branch` to **`BC-06`**. `TEN-FR-004` makes `Tenant` the module's only aggregate root; `TEN-FR-003` forbids owning any tenant-facing record beyond `Tenant` | **Architecture Reviewer** | Moving a type across a bounded-context boundary is an ownership change. `PRD_LIFECYCLE.md` Stage 7's table routes *"Ownership/boundary change"* to an **ADR**. Carried by `IMPL-801` |
| **`D-013-02`** | `MutableTenantContext` holds four plain mutable fields with no `Zone`, `runZoned` or async-local mechanism, contradicting `TEN-FR-014`. **`TEN-AC-002` is therefore currently false** | **Implementation Lead**, via `IMPL-813` | A Stage 6 backlog may not edit `lib/`. `IMPL-813` is P1 and on the critical path, which is the correct consequence |

**Why the code is wrong and the PRD is right.** `PRD-013` post-dates the scaffold and was reviewed against the
architecture at Stage 3, not against the code. `PRD-013` is the **Rank 3 requirement**; the scaffold is code that
preceded it. Amending `TEN-FR-014` to match a non-async implementation would be letting the implementation write the
requirement — and `PRD-013` is not even frozen yet, which makes the temptation cheaper and the error no smaller.

**Neither contradiction blocks Stage 6.** The gate asks whether every task traces to a requirement, not whether the
code already conforms. A backlog whose tasks are *already done* would be the surprising outcome; a backlog that
correctly identifies two defects is the gate working.

### 3.2 This document: one false claim, caught by running the check

A first draft of the task document asserted:

```
ls lib/platform/tenancy/          → does not exist
```

**That was false**, and it was written in the confident register of a verified fact. It was caught by executing the
command rather than re-reading the sentence. The correction is recorded in the task document's §1 and §12 rather than
quietly deleted, because a document that silently repairs its own false claims teaches a reader to trust the next one.

The gate script had the matching defect: its closing summary printed *"0 files under lib/ exist"*. Both are now
corrected, and the script names the scaffold and the two contradictions in its own output — so the next person to run
it is told about `D-013-01` and `D-013-02` without having to read this record.

**This is the fourth instrument defect in `PRD-013`'s lifecycle, and the fourth time the artefact under measurement was
correct while the measuring apparatus was not.** The other three are recorded in the Stage 5 conferral §3.2. A fifth
was found during this stage: the task parser initially read §3.2's *allocation* table as task rows, because those rows
also open with a backticked `IMPL-*`. The document was right; the scanner was wrong; the scanner is now scoped to §5.

### 3.3 The gate was mutation-tested, not assumed to work

A checker written in the same pass as the document it checks, by the same author, verifies agreement with itself unless
it is shown to fail on a defect. Seven were injected; **all seven were caught**, each by the check that owns that class:

| Mutation | Detected | By |
|---|---|---|
| `IMPL-817`'s Requirements cell emptied | ✅ exit 1 | `G3` — empty cell, plus `G8` orphaning `TEN-FR-020` |
| Retired `TEN-FR-016` cited by a task | ✅ exit 1 | `G9` |
| `TEN-XC-005`'s only claim removed | ✅ exit 1 | `G8`, plus the published-total recomputation |
| `IMPL-828`'s `Blocks` emptied | ✅ exit 1 | `G6` — the two directions disagree |
| `IMPL-826` renumbered to `IMPL-726` | ✅ exit 1 | `G4` — below range, collides with an allocation owned elsewhere |
| `TEN-GAP-001` cited as an obligation | ✅ exit 1 | `G10` |
| Cycle introduced (`IMPL-800` blocked by `IMPL-829`) | ✅ exit 1 | `G6` — cycle reported with the full 4-node path |
| *(clean document)* | exit **0** | — |

The task document was restored from backup after each mutation and verified byte-identical:
`cffa834955250848c63fba1ca63583f66cee803050488841543cb3680b995fe3`.

---

## 4. What this record does **not** do

| Not done | Actual state |
|---|---|
| Freeze `PRD-013` | **v0.1 `DRAFT`.** Freeze is conferred by a `DOCUMENTATION_BASELINE.md` §3 row, not by this file. Stage 7 not entered |
| Advance the registry | `PRD_REGISTRY.md` records `PRD-013` as **`PLANNED`**, sha256 `1ebb815e…` unchanged |
| Modify the matrix | `c69ed4882aec4b0433abfce8425f6ee8e36f47848be565cfcbde576bfd86800f` — unchanged. Stage 6's gate does not touch §2 |
| Modify the PRD | `688239cb…ba9c` — unchanged. Not even to correct the two contradictions `D-013-01`/`D-013-02` reveal |
| Modify the baseline | `1fa98a17…be10e` — unchanged |
| Fix `PRD_LIFECYCLE.md`'s stale `IMPL-227+` table | **Not edited.** `5031fcc9…da745` unchanged. Disclosed in the task document §3.3; amending governance is outside Stage 6 |
| Repair the stale alignment hash | **Not edited.** Assessed at Stage 5 as not requiring re-alignment; routed to the Architecture Reviewer |
| Write any code | **0 files** under `lib/` or `packages/` changed. `git status --short lib/ packages/` → empty |
| Resolve any gap | `TEN-GAP-001`…`004` remain **OPEN** |
| Cure `PGA-08` | Not cured |
| Claim Stage 7 authority | **Not claimed.** Stage 7 belongs to the Governance Owner and is assessed separately |

---

## 5. Verdict

✅ **A — PASS. Stage 6 gate satisfied.**

An `IMPL-*` range is allocated by measurement rather than from a table known to be stale, and a task document exists in
which all 30 tasks trace to in-force requirements — **34 / 34 obligations claimed**, 0 undefined, 0 retired, 0 gaps or
criteria miscited as obligations, 0 duplicates, 0 numbers below the range, 0 dependency disagreements, 0 cycles. All
four allocation rules are met and each was measured separately. The gate is a committed script that exits 0 and has
been shown to exit 1 on seven distinct injected defects.

**What passing means, precisely.** The plan is complete and mechanically consistent. **Nothing is built and nothing is
proven** — 0 of 13 acceptance criteria have a test, and the pre-existing scaffold contradicts two requirements. Stage 6
closes the *plan*, not the work, and not the gaps.

**Stage 7 is not entered by this record.** It requires a row in `DOCUMENTATION_BASELINE.md` §3 conferred by an ADR, and
that is the **Governance Owner's** act.

---

## 6. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created as the **Stage 6** review record for `PRD-013` v0.1 `DRAFT`. Verdict **A — PASS**, 0 findings, against a 13-clause gate table (`G1`…`G13`) covering the gate's two halves, all four allocation rules and six standing prohibitions. Range **`IMPL-800`…`IMPL-829`** allocated after enumerating 418 `IMPL-*` repo-wide and confirming the `IMPL-8xx` decade unreferenced — not from `PRD_LIFECYCLE.md`'s `IMPL-227+` table, which `ADR-0049` has shown to be wrong. Gate script mutation-tested with **7** injected defects, all caught; task document restored byte-identical. **Two contradictions between the pre-existing scaffold and `PRD-013` were found and recorded rather than fixed** — `D-013-01` (`Branch` ownership, routed to the Architecture Reviewer as an ADR-requiring boundary change) and `D-013-02` (`MutableTenantContext` not async-scoped, so `TEN-AC-002` is currently false, carried by `IMPL-813`). **One false claim in this stage's own first draft** — that `lib/platform/tenancy/` did not exist — is recorded in §3.2 rather than silently removed, together with the fifth instrument defect of this lifecycle (the task parser read §3.2's allocation table as task rows). **Nothing frozen, nothing registered, no ADR, no code, no gap resolved, `PGA-08` not cured; PRD, matrix, registry, baseline, lifecycle and alignment record all byte-identical.** |
