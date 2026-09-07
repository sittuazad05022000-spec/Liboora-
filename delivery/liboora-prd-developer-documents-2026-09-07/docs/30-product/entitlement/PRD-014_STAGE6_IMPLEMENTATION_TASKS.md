# `PRD-014` Stage 6 — Implementation Tasks Gate

| Field | Value |
|---|---|
| **Act** | 📐 **MEASUREMENT** — this document records what was counted. It confers nothing. The artefact it certifies is the task document, and the gate is the script |
| **Subject** | [`PRD-014_ENTITLEMENT.md`](PRD-014_ENTITLEMENT.md) v0.1 `DRAFT` — **BC-21 Entitlement** |
| **Subject hash** | `d4ca7e11352d009c84b3ed38f531e7ce73bb059549db0cd3cb2bacc25214c175` — **unchanged** by this stage |
| **Prior stage** | Stage 5 conferred by [`PRD-014_STAGE5_CONFERRAL.md`](PRD-014_STAGE5_CONFERRAL.md) · registered at [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) **v1.15 §2K** |
| **Artefact produced** | [`../../40-implementation/entitlement/PRD-014_IMPLEMENTATION_TASKS.md`](../../40-implementation/entitlement/PRD-014_IMPLEMENTATION_TASKS.md) (`bb74b5fa…f9090c`, 361 lines) |
| **Range allocated** | **`IMPL-1000` … `IMPL-1029`** — 30 tasks · `IMPL-1030`…`1099` declared growth reserve |
| **Gate script** | [`../../../tool/docs_check/prd014_task_coverage.py`](../../../tool/docs_check/prd014_task_coverage.py) (`13ec3b15…e4f380`, 412 lines) → **exit 0** |
| **Authority** | **Implementation Lead**, exercised by direct, explicit and unconditional conferral of the human principal (§0) |
| **Findings** | **0 CRITICAL · 0 HIGH · 0 MEDIUM · 0 LOW against the documents** — after **4 self-inflicted instrument defects caught by running the gate** (`S6-C-01`…`S6-C-04`, §3) |
| **Carried forward** | **6 code-vs-requirement contradictions** (`D-014-01`…`06`) scheduled, **not fixed** · **8** `ENT-GAP-*` still OPEN · `H-1` undetermined |
| **Reviewed at** | `0a52ed6` |
| **Verdict** | ✅ **A — PASS** |
| **Stage** | 6 of 9. Stage 7 **not** entered by this document. ⛔ **0 of 26 acceptance criteria are proven.** |
| **Status of this record** | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md` |
| **Date** | 2026-08-19 |

---

## 0. Authority — stated, because Stage 6 has an owner

`PRD_LIFECYCLE.md` §6 assigns **Stages 6 and 8** to the **Implementation lead**. L283 records that *"Every PRD needs a
named owner. **None has one**"* (`PGA-08`), so there is no standing holder of that role for `PRD-014`.

The authority relied on here is the same form `PRD-008_STAGE4_CONFERRAL.md` established, `ADR-0033` §7.2 describes, and
`PRD-013`/`PRD-016` used at this same stage: direct, explicit and unconditional conferral by the human principal, scoped
to one act. The instruction was to carry `PRD-014` through Stages 1–7 in *"one consolidated pass"*, following *"all
existing repository authority and ownership boundaries"*. **That instruction is the authority, and it is the only
authority claimed.**

**Scope: this act only.** `ADR-0033` §7.1 — *"A conferral for one act is not a standing licence."* It confers nothing
about Stage 7, which belongs to the Governance Owner, and it does **not** cure `PGA-08`: `PRD-014` still has no standing
named owner after this record exists.

---

## 1. What the gate required, and what exists

`PRD_LIFECYCLE.md` L137, Stage 6, verbatim:

> **Gate:** an `IMPL-*` range allocated and a task document in which **every task traces back to requirements**.

Two conjoined claims, both mechanical, so both were measured rather than read.

| Gate half | Artefact | State |
|---|---|---|
| An `IMPL-*` range allocated | `IMPL-1000`…`IMPL-1029`, established **by enumeration**, published in the task document header and §3 | ✅ |
| A task document in which every task traces back to requirements | `PRD-014_IMPLEMENTATION_TASKS.md`, 30 tasks, **54/54 = 100.0%** Class A coverage, 0 tasks citing a non-existent obligation | ✅ |

And the four allocation rules of L139–144:

| Rule | Requirement | How it was satisfied | State |
|---|---|---|---|
| 1 | Take the next free range; **never reuse or reassign a number** | Next free block computed from **489 distinct** `IMPL-\d+` identifiers actually present in `docs/ tool/ lib/ packages/ test/`; nothing below `IMPL-1000` claimed | ✅ |
| 2 | Leave the previous group room to grow contiguously | `IMPL-930`…`999` left **wholly** to `PRD-016` per `ADR-0051` L406; PRD-014 starts at `1000`, not `930` | ✅ |
| 3 | Record `Priority`, `Blocks`, `Blocked by` per task | All three cells present and non-empty on all 30 rows, asserted by check 7 | ✅ |
| 4 | A traceability table mapping task groups → requirements → invariants → acceptance | §6 of the task document, three wave rows | ✅ |

---

## 2. The gate clause by clause — measured

### 2.1 Reproducible

```
$ python3 tool/docs_check/prd014_task_coverage.py            # → exit 0
tasks allocated                          : 30
range                                    : IMPL-1000 .. IMPL-1029
Class A obligations in the PRD           : 54
obligations claimed by >=1 task          : 54
coverage                                 : 54 / 54 = 100.0%
tasks claiming a non-existent obligation : 0
D-014-* contradictions covered           : 6 of 6
criteria proven by a passing test        : 0 of 26  (no implementation)
```

The range was established by measurement, not by reading a table:

```
$ grep -rhoE 'IMPL-[0-9]+' docs/ tool/ lib/ packages/ test/ | sort -n -u | wc -l
489
$ ... | tail -12
... 921 922 923 924 925 926 927 928 929 930 999 1000
```

⚠ `IMPL-1000` **already occurred 5 times** before this stage. Each occurrence was opened and read; all five are
**boundary labels** of the form `| IMPL-1000 + | Unallocated | — |`, not allocations — `PRD-016_IMPLEMENTATION_TASKS.md:114`,
`PRD-016_STAGE6_IMPLEMENTATION_TASKS.md:124`, `PRD-014_STAGE1_DISCOVERY.md:483` and `:505`, `TRACEABILITY_MATRIX.md:1149`.
**Occurrence is not occupancy.** This is disclosed in the task document §3.1 rather than filtered out of the count,
because a reader re-running the command will see the same five hits and must be able to reconcile them.

### 2.2 Disclosed limits of this measurement

| What was **not** measured | Why |
|---|---|
| Whether any task is *correctly designed* | Stage 6 measures tracing, not solution quality. Stage 8 owns implementation |
| Whether the 30 tasks are *sufficient* to build BC-21 | Sufficiency is unprovable from documents; `IMPL-1030`…`1099` exists because it is expected to be insufficient |
| Whether any acceptance criterion **passes** | ⛔ **0 of 26.** No implementation exists and `platform/business` has **no test file at all** (`D-014-05`) |
| Whether the estimates or priorities are right | `Priority` presence is checked; priority *correctness* is a judgement no script can make |
| Whether `H-1` resolves for or against the module | Undetermined upstream; §2.1 of the task document records why no task depends on the answer |

---

## 3. The measurement caught four things, and all four were defects in my own instrument

The checker returned **exit 0 on its very first run**. That is a suspicious result for a new instrument, not a
reassuring one, so the code was read against its own docstring rather than trusted. Reading it exposed four defects.
**None was a defect in the task document or the PRD; all four were defects in the checker.** Every one is recorded here
because a corrected instrument that hides its correction is indistinguishable from one that never needed correcting.

### 3.1 `S6-C-01` — the cross-instrument check asserted existence and called it agreement

| Field | Value |
|---|---|
| **Severity** | **HIGH** (instrument) |
| **Evidence** | The docstring promised *"the Class A total here must equal the figure `prd014_traceability.py` computes independently"*. The code was `sibling = os.path.join(...)` then `if not os.path.isfile(sibling): fail(...)` — and nothing else. `grep -n 'sibling'` returned exactly **two** lines, both inside the existence test. |
| **Why it matters** | Asserting a file **exists** proves nothing about what it **computes**. The check would have passed unchanged had the two instruments disagreed outright — precisely the condition it was written to detect. This is the same vacuous-check class caught at Stage 5 as `S5-C-06`: a test that cannot fail is not a test. |
| **Owner** | Implementation Lead (this stage) |
| **Disposition** | **FIXED.** Check 9 now executes the sibling via `subprocess`, parses its Class A total, and fails on disagreement *"rather than picking a winner"*. Verified live: mutation **M2** produced `prd014_traceability.py exits 1; the Class A total cannot be cross-checked against a failing instrument`. |

### 3.2 `S6-C-02` — the harness claim was exempted without ever being verified

| Field | Value |
|---|---|
| **Severity** | **MEDIUM** (instrument) |
| **Evidence** | Check 6 exempts a task matching `re.search(r'All 26\|ENT-AC', discharges)` from the "claims no obligation" rule, so `IMPL-1029` legitimately reports `claims 0 obligation(s)`. The exemption is **correct** — `AC` is not in `CLASS_A = ['FR','BR','INV','XC']` — but the span it waves through was unchecked. Measured: the PRD defines **26** distinct `ENT-AC-*`; the task document names only the **2** endpoints. |
| **Why it matters** | A harness that silently narrowed to `ENT-AC-001`…`ENT-AC-020`, or a PRD that grew a 27th criterion, would have left criteria unowned while the row still read as a full range. |
| **Owner** | Implementation Lead (this stage) |
| **Disposition** | **FIXED** as new check 10, which recomputes `ENT-AC-*` from the PRD and compares it to the span the harness row claims. Verified live by **M1** (narrowed span → caught) and **M2** (27th criterion → caught). |

**A refinement worth recording, because it nearly became a false finding against the document.** The first version of
check 10 searched only the **Discharges** cell and reported *"IMPL-1029 claims the acceptance harness but names no
ENT-AC span"*. That reading was wrong: the span is stated in the **Task description** column of L234 (*"turns
`ENT-AC-001`…`ENT-AC-026` from prose into executing tests"*) while Discharges carries the summary form
`All 26 \`ENT-AC-*\``. **The document was right and my check was looking one column away.** Had I trusted the checker's
first complaint, I would have edited a correct document to satisfy a defective instrument. The check now searches the
whole row, because the whole row is the claim.

### 3.3 `S6-C-03` — a reported count that was not a count of anything

| Field | Value |
|---|---|
| **Severity** | **LOW** (instrument), but a **reporting integrity** defect |
| **Evidence** | The summary line read `print(..., 0 if not problems else -1)`. Observed live during the `S6-C-02` failure: the report printed `tasks claiming a non-existent obligation : -1`. |
| **Why it matters** | The figure was inferred from whether *any* problem existed anywhere in the run, so an unrelated failure made the report assert a **negative number of tasks** — a value that is not a count of anything, printed in the same column as figures that are. A reader could reasonably cite it. |
| **Owner** | Implementation Lead (this stage) |
| **Disposition** | **FIXED.** Bad citations are now accumulated into `bad_citations` and the true length is printed. Verified by **M5**, which reports exactly `1`. |

### 3.4 `S6-C-04` — `fail()` does not exit, so a guard fell through into a crash

| Field | Value |
|---|---|
| **Severity** | **MEDIUM** (instrument) |
| **Evidence** | Mutation **M3** (harness claim removed) produced **no verdict line at all** — neither PASS nor FAIL — only `IndexError: list index out of range` at `harness[0]`. Root cause: `fail()` **records** a problem and returns; it does not terminate. The guard `if not harness: fail(...)` therefore fell straight through to `harness[0]`. A second instance of the same class was found two lines later, where `low`/`high` were dereferenced outside the `else` that binds them. |
| **Why it matters** | The run still exited 1, so a CI wrapper would have called it "caught". But a traceback is **not a diagnosis**: the reader loses the sentence that says what is wrong, which is the entire purpose of the gate. |
| **Owner** | Implementation Lead (this stage) |
| **Disposition** | **FIXED.** Both dependent blocks are now guarded. Re-verified: M3 now prints `no task claims the ENT-AC-* acceptance criteria; the 26 criteria would have no owner at all` and exits 1. |

### 3.5 The gate was mutation-tested, not assumed to work

Seven mutations injected, **seven caught**, every document restored **byte-identical** afterwards.

| # | Mutation | Detected by | Result |
|---|---|---|---|
| M1 | Harness span narrowed `ENT-AC-026` → `020` | check 10 | ✅ `claims ENT-AC-001..ENT-AC-020 = 20 criteria, but the PRD defines 26` |
| M2 | 27th criterion added to the PRD | check 10 **+ check 9** | ✅ both fired; check 9's firing proves the `S6-C-01` fix is live |
| M3 | Harness claim removed from `IMPL-1029` | ownership guard | ✅ `the 26 criteria would have no owner at all` |
| M4 | Task row `IMPL-1015` deleted | checks 2, 5 | ✅ 4 problems: contiguity, count, `ENT-FR-009` unclaimed, coverage mismatch |
| M5 | `ENT-BR-001` → `ENT-BR-099` | check 4 | ✅ `cites ENT-BR-099, which is NOT defined in the PRD`; count reports `1` |
| M6 | `IMPL-1012` Priority cell emptied | check 7 | ✅ `has an empty Priority cell (allocation rule 3)` |
| M7 | Published figure → `53 / 54 = 98.1%` | check 5 | ✅ `published coverage 53 / 54 does not match the recomputation 54 / 54` |

Restoration verified: task document `bb74b5fa70c76eb1`, PRD `d4ca7e11352d009c` — **both identical to their pre-mutation
state**. The baselined `prd016_*` pair was re-run after every instrument edit and remains at exit 0, confirming my
changes to the PRD-014 checker did not disturb the frozen instruments.

### 3.6 Why 100% task coverage coexists with 94.4% acceptance coverage

These are **different measurements** and conflating them would let a real gap hide behind a full-looking number.

| Figure | Published in | Measures |
|---|---|---|
| **54 / 54 = 100.0%** | This stage's task document | Obligations **claimed by at least one task** |
| **51 / 54 = 94.4%** | The PRD §10.1, registered in matrix §2K | Obligations **carrying an acceptance criterion** |

`ENT-FR-017`, `ENT-FR-018` and `ENT-FR-026` have **no criterion** yet are each claimed by a task (`IMPL-1023`,
`IMPL-1021`, `IMPL-1028`). A task can implement an obligation whose *proof* is blocked on an open decision — `Q-03` and
`Q-06` are still OPEN and no value may be invented for them. Both numbers are correct; neither substitutes for the other.

---

## 4. What this record does **not** do

| Not done | Why |
|---|---|
| Confer `FROZEN` | Stage 7 only, via `DOCUMENTATION_BASELINE.md` §3. *"Freeze is conferred, not claimed"* |
| Set the registry to `APPROVED` | Owed, not performed. `PRD_REGISTRY.md` L304 still reads `PLANNED`; the Stage 7 act will correct it |
| Rank this record | Unranked. It is a measurement, not an authority |
| Amend `PRD_LIFECYCLE.md`'s stale `IMPL-227+` table | A Rank 1 change requires an ADR **first**. Disclosed in task document §3.3 — now for the **fourth** consecutive backlog — and left intact |
| Amend matrix §2J.1's false `FR-*` location claim (`S5-F-01`) | Baselined prose. *"A stale review is corrected by a dated re-run beside it, not by editing what it concluded"* |
| Fix `D-014-01`…`06` | Stage 8 owns code. `lib/`, `packages/`, `test/` were not touched: `git status --short` → **0 lines** |
| Resolve `H-1`, `Q-03`, `Q-06`, or any `ENT-GAP-*` | Upstream decisions. Inventing one is forbidden |
| Write, run or repair any Flutter test | ⛔ 0 of 26 criteria proven; `IMPL-1029` is the task that will change that, at Stage 8 |
| Modify the PRD | Hash verified identical before and after: `d4ca7e11…c175` |

---

## 5. Verdict

**✅ A — PASS.** Stage 6 gate **SATISFIED**.

An `IMPL-*` range is allocated by measurement rather than by trusting a stale table; it is contiguous, claims nothing
outside itself, and reuses no number. A task document exists in which all 30 tasks carry `Priority`, `Blocked by` and
`Blocks`; every cited obligation exists in the PRD; every one of the **54** Class A obligations is claimed by at least
one task; the published coverage figure reproduces independently; all **6** recorded code contradictions are scheduled;
and a §6 table maps waves → requirements → invariants → acceptance.

Four instrument defects were found and fixed, seven mutations were caught, and **no document was changed to make a
checker pass** — once, the checker was changed because it was wrong about a document that was right.

**Stage 7 readiness: READY**, with the following carried openly into it: registry status `APPROVED` is **owed, not
performed**; `PGA-08` is **not cured**; ⛔ **0 of 26** acceptance criteria are proven; `H-1` is undetermined; `D-014-01`…`06`
and eight `ENT-GAP-*` remain open. Stage 7 belongs to the **Governance Owner** and requires **`ADR-0052` before** any
baseline edit, per `DOCUMENTATION_BASELINE.md` §7 rule 1.

---

## 6. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created as the **Stage 6** gate record for `PRD-014` v0.1 `DRAFT`. Certifies `IMPL-1000`…`IMPL-1029` (30 tasks, 3 waves) and the task document `bb74b5fa…f9090c`, with `prd014_task_coverage.py` (`13ec3b15…e4f380`) at **exit 0**. Range established by enumerating **489** distinct `IMPL-\d+` identifiers; the **5** pre-existing `IMPL-1000` occurrences shown to be boundary labels and **disclosed, not filtered**. Coverage **54/54 = 100.0%**, 0 bad citations, **6 of 6** `D-014-*` scheduled, ⛔ **0 of 26** criteria proven. Records **four self-inflicted instrument defects caught by running the gate** — `S6-C-01` (existence mistaken for agreement), `S6-C-02` (unverified harness span, plus the near-miss where the checker was wrong and the document right), `S6-C-03` (a reported `-1` that counted nothing), `S6-C-04` (`fail()` does not exit, so a guard crashed instead of diagnosing) — all **fixed in the instrument, none by editing a document**. Mutation-tested **7/7** with both documents restored byte-identical. Explains why 100% **task** coverage coexists with 94.4% **acceptance** coverage. **No code, PRD, ADR, registry or baseline change**; PRD hash unchanged; the stale Rank 1 `IMPL-227+` table and `S5-F-01` disclosed and left intact |
