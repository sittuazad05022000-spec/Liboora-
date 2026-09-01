# `PRD-021A` A1–A8 Stage 6 — Implementation Tasks Gate

| Field | Value |
|---|---|
| **Act** | 📐 **MEASUREMENT** — this document records what was counted. It confers nothing. The artefact it certifies is the task document |
| **Subject** | `PRD-021A` Parts A1–A8, v0.1–v0.2 `DRAFT` |
| **A1 hash** | `4c6e0652f4ceb9ff…` — **unchanged** by this stage |
| **A4 hash** | `95af7e30a58cbc37…` — **unchanged** by this stage |
| **A8 hash** | `cf5670ad89c039e5…` — **unchanged** by this stage |
| **Prior stage** | Stage 5 registered at [`../../40-implementation/TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) **v1.21 §2P**, conferred at [`PRD-021A_STAGE5_CONFERRAL_2026-09-01.md`](PRD-021A_STAGE5_CONFERRAL_2026-09-01.md) |
| **Artefact produced** | [`../../40-implementation/social-graph/PRD-021A_IMPLEMENTATION_TASKS.md`](../../40-implementation/social-graph/PRD-021A_IMPLEMENTATION_TASKS.md) v1.0 |
| **Gate script** | [`../../../tool/docs_check/prd021a_task_coverage.py`](../../../tool/docs_check/prd021a_task_coverage.py) → **exit 0**, mutation-tested **6 ways, all exit 1** |
| **Range allocated** | **`IMPL-1500` … `IMPL-1569`** — 70 tasks · `IMPL-1570`…`1599` declared growth reserve |
| **Authority** | **Implementation lead**, exercised by direct, explicit and unconditional conferral of the human principal (§0) |
| **Findings** | **0 CRITICAL · 1 HIGH · 1 MEDIUM · 2 LOW** — all four *carried*, none introduced by this stage. Plus **four self-inflicted defects in the artefact, three caught by the gate and one caught only after it passed** (§3.2) |
| **Carried forward** | **`LCG-GAP-001`** and **`LCG-GAP-006`** OPEN · `LCG-AC-014` `UNWRITABLE` · `LCT-CONF-001` RAISED NOT RESOLVED · **551 of 757 requirements have no acceptance criterion** · **6 of 70 tasks unschedulable** |
| **Verdict** | **A — PASS.** Stage 6 of 9 is met |
| **Stage** | 6 of 9. Stage 7 **not** entered. `PRD-021A` remains `PLANNED`, Unranked and unfrozen |
| **Version** | v1.0 · 2026-09-01 |

---

## 0. Authority — stated, because Stage 6 has an owner

`PRD_LIFECYCLE.md` **L280** assigns **Stages 6 and 8** to the **Implementation lead**. L283 records
`PGA-08` — *"Every PRD needs a named owner. **None has one**"* — so there is no standing holder of
that role for `PRD-021A`.

⚠ **L280, not L279.** The inherited working note recorded the Implementation-lead row at L279; read
at its line it is **L280** (L279 is the Traceability-owner row) and the Governance-owner row is
**L281**. Both are corrected here rather than copied forward, on the standing principle that a token
is read at its line rather than counted.

The authority relied on here is the same form
[`../security/PRD-012a_STAGE6_IMPLEMENTATION_TASKS.md`](../security/PRD-012a_STAGE6_IMPLEMENTATION_TASKS.md) §0,
`PRD-013_STAGE6_IMPLEMENTATION_TASKS.md` §0 and `PRD-016_STAGE6_IMPLEMENTATION_TASKS.md` §0 used:
direct, explicit and unconditional conferral by the human principal, scoped to one act. The
instruction was: *"I explicitly authorize Stage 6 for PRD-021A A1–A8 only."* **That instruction is
the authority, and it is the only authority claimed.**

**Scope: this act only, and A1–A8 only.** `ADR-0033` §7.1 — *"A conferral for one act is not a
standing licence."* It confers nothing about **Stage 7, which belongs to the Governance Owner**
(`PRD_LIFECYCLE.md` **L281**), and it does not cure `PGA-08`: `PRD-021A` still has no standing named
owner after this record exists.

---

## 1. What the gate required, and what exists

`PRD_LIFECYCLE.md` **L135**, verbatim:

> **Gate:** an `IMPL-*` range allocated and a task document in which **every task traces back to
> requirements**.

Both halves exist. A range is allocated (**`IMPL-1500` … `IMPL-1569`**, 70 contiguous numbers) and a
task document exists in which **every one of 70 tasks traces back to requirements** — verified by
recomputation, not asserted. All four allocation rules are met, each measured separately in §2.

**Three notes on the instructions this stage sits inside.**

**(a) `IMPL-*` allocation is explicitly required here.** The standing instruction not to register
identifiers prematurely applies except where the lifecycle explicitly requires it. Stage 6's gate
**is** that explicit requirement; this is the one stage at which allocation is not merely permitted
but mandatory.

**(b) No file was modified that the gate did not require.** **Three files were created** — the task
document, the gate script, and this record. Nothing else was touched: not any of the eight PRD
Parts, **not the matrix**, not the registry, not the baseline, not `PRD_LIFECYCLE.md`, not
`tool/module_dependencies.yaml`, not another module's backlog, and not one line under `lib/` or
`test/`.

**(c) ⭐ The matrix is deliberately NOT edited, and the reason was measured rather than assumed.**
Every `## 2x` section of `TRACEABILITY_MATRIX.md` is an *identifier inventory* — Stage 5's subject —
and **no section of it registers an `IMPL-*` range**. `PRD-012a`'s Stage 6 record states the same at
its L61: nothing was touched *"not the matrix."* An `IMPL-*` range is declared in its own task
document and nowhere else, which `PRD-007`'s task document L460 puts as *"They are declared **here**
and nowhere else yet."* Adding a matrix section for a range would invent a registration duty the
lifecycle does not impose.

⚠ **The inherited working assumption for (c) was drawn from the wrong precedent and is corrected
here.** It read `PRD-020` — whose Stage 6 produced *no* `docs/30-product/` record — as the governing
precedent, and concluded no such record was needed. Measured across the repository, `PRD-020` is the
**exception**: `PRD-007`, `PRD-012a`, `PRD-013`, `PRD-014` and `PRD-016` all produce one, **five of
six**. `PRD-012a` is decisive because it is the only other **multi-part** PRD (Parts 1–8), the same
shape as A1–A8. *A single example is not a precedent; it was checked against the population before
being relied on.*

---

## 2. The gate clause by clause — measured

| ID | Clause | Rule | Measurement | Result |
|---|---|---|---|---|
| **`G1`** | An `IMPL-*` range is allocated | Gate, first half | `IMPL-1500`…`IMPL-1569`, **70** contiguous numbers parsed from §4; span has no internal gaps; **0** duplicates; each number carries **exactly one** row | ✅ |
| **`G2`** | A task document exists | Gate, second half | `PRD-021A_IMPLEMENTATION_TASKS.md` v1.0, **70** task rows parsed across **9** tables, **0** malformed rows, every row **6** columns | ✅ |
| **`G3`** | Every task traces back to requirements | Gate, the **operative** clause | **70 of 70** Requirements cells non-empty; **108** distinct cited `LC*` tokens, every one resolved against the **1,982** identifiers the eight subjects define — **minted = []**. **0** tasks cite an undefined identifier | ✅ |
| **`G4`** | Take the next free range; never reuse or reassign | Rule 1 | Next free established by **three independent routes** (§3.1 of the artefact): declared upstream at `PRD-020_IMPLEMENTATION_TASKS.md` **L79**, declared by `ADR-0082` L101/L347/L454, and **measured** — exactly **one** distinct `IMPL-15xx` token existed and every occurrence of it was *a declaration that the number is free*; the `IMPL-16xx` band returns **zero**. **0** numbers reused | ✅ |
| **`G5`** | Leave the previous group room to grow contiguously | Rule 2 | `IMPL-1450`…`1499` is **`PRD-020`'s** declared reserve and is **wholly intact — 0 rows claim it**. `IMPL-1570`…`1599` declared as **this** module's reserve (30) | ✅ |
| **`G6`** | Record `Priority`, `Blocks`, `Blocked by` per task | Rule 3 | **70 of 70** carry all three fields. ⚠ **6 carry `⛔` rather than a `P` number** — all of A4 — because `LCG-GAP-001` blocks its entire scope and *a priority implies schedulability*. Disclosed, not padded | ✅ **with a disclosed structural limit** |
| **`G7`** | Traceability table: group → requirements → invariants → acceptance | Rule 4 | §5 present, nine groups, all four columns populated. **233** `*-AC-*` mapped or accounted for; **0 proven** | ✅ |
| **`G8`** | Published figures are true | Not in the rule — added because the artefact publishes numbers | All figures recomputed from the parsed table and required to match: 1,982 identifiers · 757 requirements (710 FR + 47 BR) · 233 AC · coverage 40/757 = **5.3%** and 10/233 = **4.3%**, published at those figures rather than flattered | ✅ |
| **`G9`** | The gate could have failed | Not in the rule — added because a gate that only passes proves nothing | The instrument was **mutated six ways and exited 1 every time** (artefact §5.1.1). ⚠ One mutation attempt was **invalid** — it tested nothing and exited 0 — and is recorded rather than discarded | ✅ |

### 2.1 Reproducible

```
python3 tool/docs_check/prd021a_traceability.py    # exit 0 — 105 registers, 1982 identifiers
python3 tool/docs_check/prd021a_stage5.py          # exit 0 — 757 requirements, 233 AC
python3 tool/docs_check/prd021a_task_coverage.py   # exit 0 — 70/70 trace, 0 minted
```

The third instrument shares **no code** with the first two and its subject is **this stage's
artefact**, not the matrix. It computes the defined-identifier set from the eight subjects rather
than accepting any figure the task document publishes.

### 2.2 `G6`'s priority column carries `⛔` six times, and the gate passes anyway — why

Rule 3 requires that a Priority be **recorded**. It does not require that the recorded value be a
schedulable rank. Six tasks — `IMPL-1532`…`IMPL-1537`, the whole of A4 — sit behind `LCG-GAP-001`,
which A4 **L638** describes as *"OPEN — blocks everything."*

Writing `P3` on them would have satisfied a naive reading of rule 3 and **published a false claim**:
that the work can be scheduled. It cannot. The alternative considered and rejected was to omit A4
from the range entirely, which would have hidden an eighth of the module and made the range
non-contiguous. **The blocker is carried in the row instead**, and the gate's check 9 enforces that
every A4-owned task names it.

⚠ The instrument's first version failed `IMPL-1568`/`IMPL-1569` here, and **the instrument was
wrong, not the document** — see `K-8` in the artefact's §6.

---

## 3. Findings

### 3.1 Carried forward — none introduced by this stage

| ID | Severity | Finding | Owner |
|---|---|---|---|
| **`S6-1`** | **HIGH** | `LCG-GAP-001` OPEN — A4's scope is undefined, so **6 of 70 tasks are unschedulable** and `LCG-GAP-006` blocks group creation on top of it | Product Owner |
| **`S6-2`** | **MEDIUM** | **551 of 757 requirements have no acceptance criterion**, so no task can prove them. Inherited from §2P.2 | Product Owner |
| **`S6-3`** | **LOW** | `LCT-CONF-001` is **RAISED, NOT RESOLVED**; `IMPL-1556` is written to hold either way rather than pre-empt the decision | Architecture Owner |
| **`S6-4`** | **LOW** | `PRD_LIFECYCLE.md`'s range table still reads `IMPL-227+ "Unallocated"` and is **stale** — 500 distinct `IMPL` numbers exist. Correcting it is Rank 1 and requires an ADR **before** the change | Governance Owner |

`LCG-AC-014` is `UNWRITABLE` in the subject itself, so `IMPL-1537` can only ever discharge 17 of
A4's 18 criteria. Writing a criterion to fill it is a Product Owner act and is not performed.

### 3.2 Four self-inflicted defects in the artefact — and one the gate never saw

Recorded because *"a gate that only ever agrees with its author is not measuring anything."* Full
detail at the artefact's §6, `K-6`…`K-9`.

| ID | Defect | Caught by |
|---|---|---|
| **`I6-1`** (`K-6`) | ⛔⛔ The §7 row **disclosing** the two ADR-drift gap numbers **wrote them out**, so the gate reported this document as **MINTING** two identifiers no subject defines. Corrected to name both **by position**. ⭐ This is `J-1a` **recurring one stage later** — the identical failure shape, in a document written by an author who had just recorded `J-1a` | the gate |
| **`I6-2`** (`K-7`) | ⛔ The paragraph **prohibiting** implementation of A7's withdrawn events **reproduced a withdrawn event number**. A prohibition that reproduces the forbidden token defeats every `grep`-based check for it. Corrected to name the four **by event name** | the gate |
| **`I6-3`** (`K-8`) | The gate's A4 check conflated **A4-owned** with **any task touching A4**, and failed the two cross-part tasks. ✅ **The instrument was widened; the document was not weakened.** ⚠ The tempting fix — deleting `LCG-XC-001` from the two rows to pass — would have hidden a real cross-part obligation and was **refused** | the author, against the gate |
| **`I6-4`** (`K-9`) | ⛔ **The §6 defect table was malformed**: its header declared three columns and rows `K-5`…`K-8` supplied two, so a renderer would have silently dropped the Nature classification for exactly the four newest defects. ⚠⚠ **No checker in this repository validates table shape, and none of the three instruments would ever have reported it** — it was found by an escape-aware column-count sweep run *after* the gate had already exited 0. ⭐ **A passing gate is not a well-formed document** | a shape sweep, **after** the gate passed |

⚠ **`I6-4` is the most instructive of the four**, because the other three were found by an instrument
built for the purpose and this one was found only by looking at a property no instrument measures.
The gate's subject is identifier integrity; shape is a different property. Repaired by supplying the
four missing cells, **not** by reducing the header to two columns.

---

## 4. What this record does **not** confer

| It does not | Because |
|---|---|
| Enter Stage 7 | Stage 7's gate is **a row in `DOCUMENTATION_BASELINE.md` §3**, and *"freeze is conferred, not claimed"* |
| Freeze, rank, or mark `READY` | All three are Governance Owner acts. `PRD-021A` is absent from `DOCUMENTATION_BASELINE.md` §3 |
| Change the registry status | `PRD_REGISTRY.md` §11 still reads `PLANNED`. This stage writes nothing there |
| Register anything in the matrix | An `IMPL-*` range is declared in its task document and nowhere else — §1(c), measured |
| Close `LCG-GAP-001` or `LCG-GAP-006` | Both remain OPEN. A backlog schedules; it does not decide |
| Define A4's scope, roles or permissions | `PRD_REGISTRY.md` L744 — *"No role set is defined."* Inventing one is the act this stage most had opportunity to commit, and did not |
| Resolve `LCT-CONF-001` | It remains **RAISED**. `IMPL-1556` holds either outcome |
| Write `LCG-AC-014` | It is `UNWRITABLE` in the subject. Writing it is a Product Owner act |
| Reinstate any of A7's 4 withdrawn events | `SD-1` withdrew them; §5 rule 5 — *"Numbers are never reused, even after withdrawal."* **Cited by no task** |
| Consume `PRD-020`'s `IMPL-1450`…`1499` reserve | It belongs to the reserving document, and `PRD-020`'s Stage 5 preserves `IMPL-1450` deliberately as defect `I-2` |
| Prove any acceptance criterion | **0 of 233.** Stage 9 proves criteria; Stage 6 maps them |
| Authorise any code change | **Stage 8 is a separate stage** (`PRD_LIFECYCLE.md` **L182**). `git status --short lib/ test/` → **0 lines** |
| Correct `PRD_LIFECYCLE.md`'s stale range table | Rank 1. Baseline §7 rule 1 requires an ADR **before** the change |
| Extend or renumber any register | §5 rule 5 forbids reuse; **0 identifiers minted** |

⭐ **On "code and tests as required".** The authorising instruction included *"code/tests as
required"*, and the requirement was **measured rather than assumed**. Stage 6 (L135) and Stage 8
(L182) are different stages with different gates, and Stage 8's own rule states that *"a requirement
that cannot be implemented as written is a specification defect — raise an amendment, never silently
reinterpret it."* Three A1–A8 requirement families cannot be implemented as written today: A4's
scope is open, `communityId` is unresolvable while it is, and A7's event surface sits in an
unresolved conflict. **Writing code against them would be exactly the silent reinterpretation
Stage 8 forbids.** The repository's only code artefact, `IMPL-1410`, exists under an `ACCEPTED`
`ADR-0065` — not under a Stage 6 document. **Files created under `lib/` or `test/`: zero.**

---

## 5. Verdict

| Clause | Result |
|---|---|
| `G1` range allocated, contiguous | ✅ `IMPL-1500`…`1569`, 70 tasks, one row each |
| `G2` task document exists | ✅ v1.0, 70 rows across 9 tables, 0 malformed |
| `G3` **every task traces back to requirements** | ✅ 70/70, 108 tokens resolved, **minted = []** |
| `G4` next free range, nothing reused | ✅ established three ways, 0 reassigned |
| `G5` previous group's reserve intact | ✅ `IMPL-1450`…`1499` untouched, 0 rows |
| `G6` `Priority`, `Blocks`, `Blocked by` on every task | ✅ 70/70, with 6 `⛔` **and the reason published** |
| `G7` rule-4 traceability table | ✅ nine groups, four columns, 233 AC accounted, 0 proven |
| `G8` published figures true | ✅ recomputed, coverage published at 5.3% / 4.3% |
| `G9` the gate could have failed | ✅ 6 mutations, 6 exit 1; one invalid attempt disclosed |

**✅ A — PASS. Stage 6 of 9 is met.**

**Stage 7 is not entered.** Its gate is a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned
precedence rank, and that row does not exist. Whether it *should* is a Governance Owner decision,
not a measurement — and not this record's to make.

---

## 6. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-01 | Created. Records Stage 6 **PASS** for `PRD-021A` A1–A8 on nine measured clauses `G1`–`G9`. Certifies [`../../40-implementation/social-graph/PRD-021A_IMPLEMENTATION_TASKS.md`](../../40-implementation/social-graph/PRD-021A_IMPLEMENTATION_TASKS.md) v1.0, allocating **`IMPL-1500`…`IMPL-1569`** — 70 contiguous tasks plus reserve `IMPL-1570`…`1599` — with next-free established by **three independent routes**, leaving `PRD-020`'s reserve `IMPL-1450`…`1499` intact per rule 2. `G3`, the operative clause, verified as **70/70** tasks tracing, **108** distinct cited tokens all resolved against the **1,982** identifiers the eight subjects define, **minted = []**. Rule 3 verified **70/70**, with **6 priorities recorded as `⛔` rather than a `P` number** — all of A4 — because `LCG-GAP-001` blocks its scope and a priority would falsely imply schedulability; §2.2 records why padding them was refused. Coverage published at **40/757 = 5.3%** and **10/233 = 4.3%** rather than flattered, on the settled precedent that coverage is **not** in Stage 6's gate. `G9` added beyond the rule: the instrument was **mutated six ways and exited 1 every time**, and one **invalid** mutation attempt — which tested nothing and exited 0 — is disclosed rather than discarded. **§3.2 records four self-inflicted defects in the artefact**: `I6-1`/`I6-2`, where the rows *disclosing* forbidden tokens **reproduced** them (`I6-1` being `J-1a` recurring one stage later); `I6-3`, where **the instrument was widened rather than the document weakened** and the tempting citation-deleting fix was refused; and **`I6-4`, a malformed §6 table that no instrument in this repository would ever have caught**, found by a shape sweep *after* the gate had exited 0. **§1(c) corrects an inherited precedent error**: `PRD-020`'s absence of a Stage 6 record was read as the rule, but measured across the population it is the **exception — five of six modules produce one**, and `PRD-012a` (Parts 1–8) is the governing multi-part precedent. **The matrix is deliberately NOT edited**, measured: no `## 2x` section registers an `IMPL-*` range. **Confers nothing** — no Stage 7 entry, no freeze, no rank, no `READY`, no baseline row, no registry write, no gap closed, no A4 scope or role set defined, no `LCT-CONF-001` resolution, no `LCG-AC-014` written, no withdrawn event reinstated, no register extended or renumbered, no criterion proven, **no code written**. **Identifiers minted: ZERO.** Eight subject hashes unchanged: A1 `4c6e0652f4ceb9ff…`, A4 `95af7e30a58cbc37…`, A8 `cf5670ad89c039e5…`. `git status --short lib/ test/` → **0 lines**. |
