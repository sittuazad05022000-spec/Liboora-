# `PRD-016` Stage 6 — Implementation Tasks Gate

| Field | Value |
|---|---|
| **Act** | 📐 **MEASUREMENT** — this document records what was counted. It confers nothing. The artefact it certifies is the task document, and the gate is the script |
| **Subject** | [`PRD-016_AUDIT_TRAIL.md`](PRD-016_AUDIT_TRAIL.md) v0.1 `DRAFT` |
| **Subject hash** | `281f15e8de65dde8c8b5a5e8edda71f8e34eff07c7abc411698fbfc0f6f339be` — **unchanged** by this stage |
| **Prior stage** | Stage 5 conferred by [`PRD-016_STAGE5_CONFERRAL.md`](PRD-016_STAGE5_CONFERRAL.md) · registered at [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) **v1.14 §2J** |
| **Artefact produced** | [`../../40-implementation/audit/PRD-016_IMPLEMENTATION_TASKS.md`](../../40-implementation/audit/PRD-016_IMPLEMENTATION_TASKS.md) (`a334d523…0eaf13`, 404 lines) |
| **Range allocated** | **`IMPL-900` … `IMPL-929`** — 30 tasks · `IMPL-930`…`999` declared growth reserve |
| **Gate script** | [`../../../tool/docs_check/prd016_task_coverage.py`](../../../tool/docs_check/prd016_task_coverage.py) (`e552cfb5…4f1112`) → **exit 0** |
| **Authority** | **Implementation Lead**, exercised by direct, explicit and unconditional conferral of the human principal (§0) |
| **Findings** | **0 CRITICAL · 0 HIGH · 0 MEDIUM · 0 LOW** — after **1 self-inflicted defect caught by the gate**, §3.2 |
| **Carried forward** | **3 code-vs-requirement contradictions** (`D-016-01`…`03`) scheduled, **not fixed** · **5** `AUD-GAP-*` still OPEN |
| **Reviewed at** | `0d5d1a7` |
| **Verdict** | ✅ **A — PASS** |
| **Stage** | 6 of 9. Stage 7 **not** entered by this document. ⛔ **0 of 18 acceptance criteria are proven.** |
| **Status of this record** | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md` |
| **Date** | 2026-08-19 |

---

## 0. Authority — stated, because Stage 6 has an owner

`PRD_LIFECYCLE.md` §6 assigns **Stages 6 and 8** to the **Implementation lead**. L283 records that *"Every PRD needs a
named owner. **None has one**"* (`PGA-08`), so there is no standing holder of that role for `PRD-016`.

The authority relied on here is the same form `PRD-008_STAGE4_CONFERRAL.md` established, `ADR-0033` §7.2 describes, and
`PRD-013_STAGE6_IMPLEMENTATION_TASKS.md` §0 used one stage earlier: direct, explicit and unconditional conferral by the
human principal, scoped to one act. The instruction was to develop `PRD-016` end-to-end *"strictly following the
repository's existing governance, roadmap and PRD lifecycle"* as *"a single consolidated workflow"*. **That instruction
is the authority, and it is the only authority claimed.**

**Scope: this act only.** `ADR-0033` §7.1 — *"A conferral for one act is not a standing licence."* It confers nothing
about Stage 7, which belongs to the Governance Owner, and it does **not** cure `PGA-08`: `PRD-016` still has no standing
named owner after this record exists.

---

## 1. What the gate required, and what exists

`PRD_LIFECYCLE.md` Stage 6, verbatim:

> **Gate:** an `IMPL-*` range allocated and a task document in which **every task traces back to requirements**.

Both halves exist. A range is allocated (**`IMPL-900` … `IMPL-929`**, 30 contiguous numbers) and a task document exists
in which **every one of 30 tasks traces back to requirements** — verified mechanically, not asserted. All four
allocation rules are met, each measured separately in §2.

**Two notes on the instructions this stage sits inside.**

**(a) `IMPL-*` allocation is explicitly required here.** The standing instruction not to register identifiers
prematurely applies except where the lifecycle explicitly requires it. Stage 6's gate **is** that explicit requirement;
this is the one stage at which allocation is not merely permitted but mandatory.

**(b) No file was modified that the gate did not require.** The gate requires a task document and a means of verifying
it. **Two files were created.** Nothing else was touched — not the PRD, not the matrix, not the registry, not the
baseline, not any earlier `PRD-016` record, not `PRD_LIFECYCLE.md`, not another module's backlog, and not one line under
`lib/`.

---

## 2. The gate clause by clause — measured

| ID | Clause | Rule | Measurement | Result |
|---|---|---|---|---|
| **`G1`** | An `IMPL-*` range is allocated | Gate, first half | `IMPL-900`…`IMPL-929`, 30 contiguous numbers; span has no internal gaps | ✅ |
| **`G2`** | A task document exists | Gate, second half | `PRD-016_IMPLEMENTATION_TASKS.md`, 404 lines, **30** task rows parsed from §5 | ✅ |
| **`G3`** | Every task traces back to requirements | Gate, the operative clause | 30 of 30 Requirements cells non-empty; **0** tasks cite no `AUD-*`; **0** cite an undefined identifier; **0** cite an `AUD-AC-*` or `AUD-GAP-*` as an obligation | ✅ |
| **`G4`** | Take the next free range; never reuse or reassign | Rule 1 | **451** distinct `IMPL-*` enumerated across `docs/ tool/ lib/ test/ packages/`. **0** tasks defined below `IMPL-900`, **0** inside `IMPL-830`…`899`, **0** duplicates, **0** outside the span | ✅ |
| **`G5`** | Leave the previous group room to grow contiguously | Rule 2 | `IMPL-800`…`829` is `PRD-013`'s and `IMPL-830`…`899` its **declared reserve**; starting at `900` leaves that reserve wholly intact. `IMPL-930`…`999` declared as **this** module's reserve for the 5 open `AUD-GAP-*` | ✅ |
| **`G6`** | Record `Priority`, `Blocks`, `Blocked by` per task | Rule 3 | 30 of 30 carry a valid `P1`/`P2`/`P3`; **47 edges**; `Blocks` and `Blocked by` agree in **both** directions with **0** disagreements; 0 unresolvable dependencies; 0 cycles; **1 root** (`IMPL-900`), **1 leaf** (`IMPL-929`) | ✅ |
| **`G7`** | Traceability table: group → requirements → invariants → acceptance | Rule 4 | §6 present, three waves, all four columns; the published **35 / 35 = 100.0%** is **recomputed** by the script and required to match | ✅ |
| **`G8`** | Published graph figures are true | Not in the rule — added because §7 publishes numbers | §7's `tasks 30 · edges 47 · cycles 0 · longest chain 7` all recomputed from the parsed graph and required to match | ✅ |

### 2.1 Reproducible

```
python3 tool/docs_check/prd016_task_coverage.py      → exit 0
python3 tool/docs_check/prd016_traceability.py       → exit 0   (Stage 5, unaffected)
python3 tool/docs_check/prd016_stage5.py             → exit 0   (Stage 5, unaffected)

grep -rhoE 'IMPL-[0-9]{3,4}' docs/ tool/ lib/ test/ packages/ | sort -u | wc -l   → 451
git status --short lib/ packages/ test/                                           → 0 lines
sha256sum docs/30-product/audit/PRD-016_AUDIT_TRAIL.md   → 281f15e8…f339be  (unchanged)
```

Gate output, in full:

```
range allocated                          : IMPL-900 .. IMPL-929
tasks parsed                             : 30
dependency edges                         : 47
roots / leaves                           : 1 / 1
longest chain                            : 7
Class A obligations defined by the PRD    : 35
obligations claimed by at least one task  : 35
coverage of obligations                  : 35 / 35 = 100.0%
acceptance criteria proven by a test      : 0  (no implementation)
PASS - ... PRD_LIFECYCLE.md Stage 6 gate SATISFIED.
```

### 2.2 Disclosed limits of this measurement

| Limit | Why it matters |
|---|---|
| **100% of obligations claimed is not 100% verified** | Every obligation has a task. **No task has been done.** The figure measures the completeness of a plan, not of an implementation |
| **⛔ 0 of 18 `AUD-AC-*` are proven** | `find test -iname '*audit*'` → **0**. Acceptance coverage in `TRACEABILITY_MATRIX.md` §2J remains **27/35 = 77.1%** and this stage did not change it |
| The script reads §5 only | By design (§3.1). A task row added outside §5 is invisible to the gate. §5's heading is asserted, so deleting it fails the run rather than silently emptying the task set |
| Requirement *wording* is not checked | The gate proves a task cites an obligation that exists; it cannot prove the task's scope actually discharges it. That judgement is human and is what Stage 9 re-tests |
| The 6 already-satisfied obligations are **satisfied, not proven** | §4.1 of the task document measures the scaffold. No test observes any of the six, which is why each still carries a task |
| The three code contradictions are **scheduled, not fixed** | A Stage 6 backlog may not edit `lib/`. `D-016-01`→`IMPL-922`, `D-016-02`→`IMPL-910`–`912`, `D-016-03`→`IMPL-913` |
| `PRD-013`'s tasks are unimplemented | `IMPL-800`…`829` exist on paper only, so `IMPL-920`/`921`/`923` carry a real sequencing dependency on another module's unstarted work |

---

## 3. The measurement caught two things — one about the repository, one about this document

### 3.1 The repository: `IMPL-900` was already present, and occurrence is not occupancy

The enumeration in the task document's §3.1 reports **451** distinct `IMPL-*` numbers with **highest 900** — that is,
the very number this backlog intended to take. Three readings were available:

1. `IMPL-900` is occupied; start at `IMPL-1000`.
2. `IMPL-900` is occupied; the enumeration is wrong; ignore it.
3. Open each occurrence and find out.

Only the third is admissible, and it settles the matter:

```
grep -rnE 'IMPL-9[0-9]{2}' docs/ tool/ lib/ test/ packages/   → 3 hits, 2 files
  PRD-013_IMPLEMENTATION_TASKS.md:114   | `IMPL-900` + | Unallocated | — |
  TRACEABILITY_MATRIX.md:999            §2J prose, "the next free block is IMPL-900+"
  TRACEABILITY_MATRIX.md:1469           §2J changelog, same statement
```

All three are **boundary labels declaring the number free**. None assigns work to it. Taking `IMPL-900` is therefore
exactly what rule 1's *"take the next free range"* instructs.

**Reading 1 would have been the expensive mistake, and it is the one a careless tool produces.** A string-counting
scanner reports `900` as present; obeying it would have stranded the whole `IMPL-9xx` decade and left the repository
with a permanent unexplained hole. The occurrence is therefore **disclosed in §3.1 of the task document rather than
filtered out of the enumeration**, so that a later reader re-deriving the decision meets the same three hits and the
same reasoning instead of a number that appears from nowhere.

The gate encodes the distinction rather than trusting the prose: it tests for a task **defined** below the allocated
floor, not for a string that mentions one.

### 3.2 This document: one false row, caught by running the check

The task document's first version **failed its own gate**, with 23 messages. The root cause was a single defect:
`IMPL-929`'s row carried **7 cells where every other row carries 8** — the harness blocks nothing, and its empty
**Blocks** cell had been omitted rather than dashed.

The cascade is worth recording, because it shows what one malformed row does to every downstream count:

```
task row has 7 cells, expected 8: `IMPL-929`
allocated span is IMPL-900..IMPL-928, expected IMPL-900..IMPL-929
gap inside the allocated span: IMPL-929
IMPL-905 Blocks IMPL-929, which is not a task here          (× 17 tasks)
expected exactly 1 leaf, found 0
section 7 publishes tasks 30; recomputed 29
section 7 publishes longest chain 7; recomputed 6
```

**The document claimed 30 tasks and a 7-task critical path; the graph actually held 29 and 6.** Those two figures were
written in §7 by hand before the script existed, and they were *wrong* — not by a large margin, and not in a way any
amount of re-reading would reliably have caught. Nineteen of the twenty-three messages were consequences, not causes;
the fix was one em-dash.

**This is the second time in `PRD-016`'s lifecycle that the instrument corrected the author.** The difference from
Stage 5 matters and is stated plainly: at Stage 5 the three defects were in the **checkers** and the PRD was right, so
no document was edited. Here the defect was in the **document** and the checker was right, so the document was
corrected. The rule is the same in both directions — *find out which one is wrong before changing either* — and
`PRD-013_STAGE5_CONFERRAL.md` §3.2's standard still holds: **no requirement was weakened and no figure was adjusted to
make a script pass.** A missing table cell was supplied and the published figures then reproduced on their own.

### 3.3 The gate was mutation-tested, not assumed to work

`PRD-013_STAGE5_CONFERRAL.md` §3.1: *"a gate that cannot fail is not a gate."* **Eleven** defects were injected one at
a time, each restored before the next:

| # | Injected defect | Gate |
|---|---|---|
| M1 | A Requirements cell emptied | ✅ caught — *"has an EMPTY Requirements cell"* |
| M2 | `AUD-AC-004` cited as an obligation | ✅ caught — *"cites … as an OBLIGATION"* |
| M3 | Citation changed to undefined `AUD-XC-099` | ✅ caught — *"which PRD-016 does not define"* **and** the orphaned obligation reported |
| M4 | `Blocks` / `Blocked by` symmetry broken | ✅ caught — *"the two directions disagree"* |
| M5 | A `Priority` cell blanked | ✅ caught — *"has Priority ''"* |
| M6 | §6's published total drifted 35→34 | ✅ caught — *"section 6 publishes 34 obligations; the PRD defines 35"* |
| M7 | §7's published edge count drifted 47→52 | ✅ caught — *"section 7 publishes edges 52; recomputed 47"* |
| M8 | A task renumbered `IMPL-928`→`IMPL-828` | ✅ caught — floor breach **and** `PRD-013` reserve intrusion |
| M9 | A terminal task dropped from `IMPL-929`'s edge list | ✅ caught — *"omits otherwise-terminal task(s)"* |
| M10 | An obligation left with no claiming task | ✅ caught — *"claimed by NO task"* |
| M11 | A cycle attempted through the harness | ✅ caught — asymmetry detected before the cycle could form |

**11 injected, 11 caught.** The document was then re-hashed to `a334d523…0eaf13` — **byte-identical** to its
pre-mutation state — and the gate re-run to exit 0.

⚠ **One honest correction to this table.** M3's first attempt reported *pass*, and the tempting conclusion was that the
checker had a blind spot. It did not: the `sed` pattern had failed to match, so **no mutation was applied and the
document was unmodified** — a pass was the correct answer to the question actually asked. The mutation was rewritten to
target the right line and was then caught, twice over. **A mutation test that silently fails to mutate reports the
gate as weak when the harness was weak**, which is the same class of error as trusting a scanner's occupancy count in
§3.1, and it is recorded rather than quietly re-run.

---

## 4. What this record does **not** do

| Not done | Actual state |
|---|---|
| Implement anything | **0 `lib/` files changed.** `git status --short lib/ packages/ test/` → 0 lines |
| Prove any criterion | ⛔ **0 of 18** `AUD-AC-*` bound to a passing test |
| Improve acceptance coverage | **27/35 = 77.1%** in `TRACEABILITY_MATRIX.md` §2J, unchanged. The 35/35 figure is a *different* measurement — obligations claimed by a task |
| Fix `D-016-01`/`02`/`03` | **Scheduled** to `IMPL-922`, `IMPL-910`–`912`, `IMPL-913`. `lib/platform/audit/audit.dart` byte-unchanged since `a44ebb0` |
| Close any gap | **`AUD-GAP-001`…`005` all OPEN.** The task document §8 names the five tasks that would have closed them, and forbids each |
| Issue an `AUD-CFG-*` or `AUD-EVT-*` | **Both registers still empty.** No retention period, legal hold, jurisdiction, event or configurable invented |
| Enter Stage 7 | **Not entered.** `DOCUMENTATION_BASELINE.md` §3 has no row admitting `PRD-016`, which is the only place freeze can be conferred |
| Change the PRD | `281f15e8…f339be` — unchanged, still **v0.1 `DRAFT`** |
| Change the registry | `PRD_REGISTRY.md` §4.2 still records `PRD-016` as **`PLANNED`**, byte-identical |
| Amend `PRD_LIFECYCLE.md`'s stale `IMPL-227+` table | **Not edited.** Disclosed in the task document §3.3; a Rank 1 change needs an ADR *before* the change |
| Cure `PGA-08` | **Not cured.** Authority here is per-act conferral, not an owner appointment |
| Repair the four pre-existing exit-1 checkers | **Not repaired.** They fail for their own recorded reasons, none of them `BC-24`'s |
| Modify any earlier `PRD-016` record | Stage 1, 3, 4 and 5 records and both Stage 5 checkers **byte-unchanged**; both still exit 0 |

---

## 5. Verdict

✅ **A — PASS.** Both halves of the Stage 6 gate exist and all four allocation rules are satisfied, measured by a
committed script rather than by reading:

- **`IMPL-900` … `IMPL-929`** allocated contiguously, taken after enumerating **451** distinct `IMPL-*` and opening
  every `IMPL-9xx` occurrence to establish that none of them assigns work;
- **30 tasks**, each tracing to at least one `AUD-*` obligation `PRD-016` actually defines, with **0** undefined
  citations and **0** `AUD-AC-*`/`AUD-GAP-*` claimed as obligations;
- **35 / 35 = 100.0%** of Class A obligations claimed, recomputed from the PRD, not from the backlog;
- `Priority`, `Blocks`, `Blocked by` on every task, **47 edges** mutually consistent in both directions, acyclic,
  **1 root, 1 leaf**, harness edge list **derived**;
- the rule-4 traceability table present with all four columns and its published figures reproduced;
- **11 mutations injected, 11 caught**, document restored byte-identical.

**What this does not confer:** not Stage 7, not freeze, not verification, not implementation. **5** gaps remain open,
**3** code contradictions stand unrepaired, acceptance coverage is **77.1%**, and **0 of 18** criteria are proven by a
passing test. A plan in which every obligation has a task is a complete plan, not a completed one.

**Stage 6 of 9. Stage 7 may now be entered.**

---

## 6. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created as the **Stage 6** gate record for `PRD-016` v0.1 `DRAFT`. Certifies `PRD-016_IMPLEMENTATION_TASKS.md` (`a334d523…0eaf13`, 404 lines) allocating **`IMPL-900` … `IMPL-929`** — 30 tasks in 3 waves plus `IMPL-930`…`999` reserved for the five open `AUD-GAP-*` — and the committed gate `prd016_task_coverage.py` (`e552cfb5…4f1112`), the **third** independent `PRD-016` checker, importing neither Stage 5 script. All eight clauses measured ✅. ⚠ **§3.1 records that `IMPL-900` already occurred in the repository three times**; each occurrence was opened and shown to be an *"Unallocated"* **boundary label**, so occurrence is not occupancy and taking the number obeys rule 1 rather than breaching it — the hits are **disclosed rather than filtered**, because obeying a string-counting scanner would have stranded the whole `IMPL-9xx` decade. ⚠ **§3.2 records that the task document FAILED its own gate on first run with 23 messages**, all cascading from one defect: `IMPL-929`'s row had **7 cells instead of 8**, and the consequence was that the document's hand-written *"30 tasks, longest chain 7"* was actually **29 and 6**. The document was corrected — one em-dash — after which the published figures reproduced unaided; **no requirement was weakened and no figure adjusted to make the script pass**. This is the mirror image of Stage 5, where three defects were in the *checkers* and the PRD was right; the rule applied in both directions is *find out which one is wrong before changing either*. ⚠ **§3.3 records 11 mutations injected and 11 caught**, document restored **byte-identical**, **including an honest note that M3's first attempt reported a false pass because the `sed` never matched** — a mutation harness that silently fails to mutate slanders the gate, and that is recorded rather than quietly re-run. **Nothing implemented: 0 `lib/` files changed; no schema, SQL, DDL, migration, API shape, class signature, field list, storage engine, index, estimate or sprint assignment; no fifth `AuditEntry` value object; no retention period, legal-hold mechanism, support-access list, `EVT-*` member name, event, integration edge or configuration value invented; `AUD-GAP-001`…`005` all OPEN; `D-016-01`…`03` scheduled, not repaired; `AUD-EVT-*` and `AUD-CFG-*` still empty; acceptance coverage still 27/35 = 77.1% with 0 of 18 criteria proven; the PRD unchanged at `281f15e8…f339be` and still v0.1 `DRAFT`; `TRACEABILITY_MATRIX.md`, `PRD_REGISTRY.md`, `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, all 50 ADRs, all four earlier `PRD-016` records, both Stage 5 checkers and all 14 pre-existing scripts untouched; no ADR, no baseline row, no freeze, no commit and no push.** |
