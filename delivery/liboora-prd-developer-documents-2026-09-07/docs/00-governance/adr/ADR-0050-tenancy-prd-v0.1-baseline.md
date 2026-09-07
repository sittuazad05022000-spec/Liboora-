# ADR-0050 — Tenancy PRD v0.1 is the official baseline for `BC-19` Tenancy

| Field | Value |
|---|---|
| **ADR** | `ADR-0050` |
| **Status** | **Accepted** |
| **Date** | 2026-08-19 |
| **Deciders** | **Governance owner** (Stage 7 and the baseline, `PRD_LIFECYCLE.md` §6 L282) — exercised by direct conferral of the human principal of this engagement, §6 |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document's content.** Admits a new document to Rank 3. `MASTER_PRD.md` (Rank 1), the Bounded Context Map and Module Dependency Matrix (Rank 4) and `ARCHITECTURE_RULINGS.md` (Rank 5) are **unamended** |
| **Amended by** | — |
| **Baseline** | **`BASELINE-2026-08-19-A`** |
| **Closes** | [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md) **Stage 7** for `PRD-013`. Registry status `PLANNED` → **`FROZEN`**. Supersedes [`PRD-013_STAGE7_BLOCKER.md`](../../30-product/tenancy/PRD-013_STAGE7_BLOCKER.md) — §5 |
| **Does NOT close** | **`TEN-GAP-001` … `TEN-GAP-004`** — all four remain **OPEN**, each with its named owner (§4 item 7). Nor `PGA-08`, `H-1`, `D-013-01`, `D-013-02`, `GCP-05`/`06`/`09`, `BLK-01`/`TASK-D10` |
| **Related** | [`ADR-0020`](./ADR-0020-seat-management-prd-v1.0-baseline.md) (the freeze-mechanics precedent this ADR follows clause by clause) · [`ADR-0049`](./ADR-0049-revenue-finance-prd-v1.7-baseline.md) (the most recent freeze; the alignment-supplement precedent) · [`ADR-0013`](./ADR-0013-capability-context-ownership.md) (assigns `BC-19` to `PRD-013`; the two ownership rights) · `ADR-0047` §2.3 (a `DRAFT` PRD is *"Rank 3-registered, not Rank 3-holding"*) · Baseline §7 · `PRD_LIFECYCLE.md` L155–180 |

---

## 1. The question

[`PRD-013_TENANCY.md`](../../30-product/tenancy/PRD-013_TENANCY.md) has completed **Stages 1–6** of
`PRD_LIFECYCLE.md`. It carries **63 declared identifiers** across eight registers — **51 in force**, **12 retired** —
**13 acceptance criteria**, and a **30-task** implementation backlog claiming **34 of 34** obligations.

**Should `PRD-013` be admitted to the documentation baseline at Rank 3 as the authoritative specification for
`BC-19` Tenancy?**

Stage 7's gate is *"a row in [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §3 at an assigned
precedence rank."* Freeze here is **conferred, not claimed**. This ADR therefore exists **before** the baseline row
is written, per baseline §7 step 1.

---

## 2. Evidence — the artefacts, not the feelings

`PRD_LIFECYCLE.md` **L41–42**: *"A gate is not an opinion — if the artefact does not exist, the stage has not been
passed, however complete the work feels."*

| Stage | Gate | Artefact | State |
|---|---|---|---|
| **1** — Discovery | a context in the BC Map, not already owned in `PRD_REGISTRY.md` §6 | `BC-19` at BC Map **L128**; assigned to `PRD-013` by **`ADR-0013`**; `PRD_REGISTRY.md` **L447** records the contest **resolved** | ✅ **PASSED** |
| **2** — Draft | version/status header + registers declared up front with ranges | `PRD-013_TENANCY.md` §0.2, eight registers, every range contiguous **over the declared set** | ✅ **PASSED** |
| **3** — Architecture review | *"a written alignment record naming every conflict and its disposition"* | [`PRD-013_ARCHITECTURE_ALIGNMENT.md`](../../30-product/tenancy/PRD-013_ARCHITECTURE_ALIGNMENT.md) (`fcd99ff7…f97e` base) **jointly with** [`PRD-013_ARCHITECTURE_ALIGNMENT_SUPPLEMENT.md`](../../30-product/tenancy/PRD-013_ARCHITECTURE_ALIGNMENT_SUPPLEMENT.md) (`688239cb…ba9c`) | ✅ **ALIGNED — 5 PASS + 1 CONDITIONAL** (`H-1`) |
| **4** — Requirements review | conflicts closed or deferred **with a reason and an owner** | `PRD-013_TENANCY.md` changelog records four corrections applied (`RQ-1`…`RQ-4`); all four `TEN-GAP-*` name an owner | ✅ **PASSED** |
| **5** — Traceability | prefixes registered in `TRACEABILITY_MATRIX.md` §2, verified mechanically | §2I; `tool/docs_check/prd013_traceability.py`, `prd013_stage5.py`; **conferred** by [`PRD-013_STAGE5_CONFERRAL.md`](../../30-product/tenancy/PRD-013_STAGE5_CONFERRAL.md) | ✅ **exit 0**, both |
| **6** — Implementation tasks | an `IMPL-*` range allocated, every task tracing back to requirements | [`PRD-013_IMPLEMENTATION_TASKS.md`](../../40-implementation/tenancy/PRD-013_IMPLEMENTATION_TASKS.md), `IMPL-800`…`829`; **record** [`PRD-013_STAGE6_IMPLEMENTATION_TASKS.md`](../../30-product/tenancy/PRD-013_STAGE6_IMPLEMENTATION_TASKS.md) | ✅ **A — PASS**, 13/13 gates, `prd013_task_coverage.py` **exit 0** |

### 2.1 Figures computed from the PRD, not copied from the reports

All three gates were re-executed at **exit 0** immediately before this ADR was written.

```
python3 tool/docs_check/prd013_traceability.py   → exit 0
python3 tool/docs_check/prd013_stage5.py         → exit 0
python3 tool/docs_check/prd013_task_coverage.py  → exit 0
```

| Property | Value |
|---|---|
| Registers | **8** — `TEN-FR` · `TEN-BR` · `TEN-INV` · `TEN-EVT` · `TEN-XC` · `TEN-CFG` · `TEN-AC` · `TEN-GAP` |
| Identifiers **in force** | **51** — FR 18 · BR 2 · INV 2 · EVT 2 · XC 10 · CFG **0** · AC 13 · GAP 4 |
| Identifiers **retired** | **12** — `TEN-FR-012`/`016`/`017` · `TEN-BR-002`/`003` · `TEN-INV-003`/`004`/`005` · `TEN-CFG-001` · `TEN-AC-003`/`004`/`005` |
| Declared set | **63** = 51 + 12; every range contiguous over the declared set (Matrix §2D.2: *"Their numbers are **retained, not reused**"*) |
| Obligation-bearing | **34** = 18 FR + 2 BR + 2 INV + 10 XC + 2 EVT |
| Dangling references | **0** |
| Orphan criteria | **0** |
| Cross-module collisions | **0** in both directions |
| Implementation tasks | **30**, `IMPL-800`…`829`, three waves, 0 collisions with the 418 `IMPL-*` already allocated |
| Task → obligation coverage | **34/34 = 100.0%**, 0 cycles, 1 root (`IMPL-800`), 1 leaf (`IMPL-829`), critical path **9** |
| `TEN-CFG-*` | **Declared empty** — 1 identifier, retired. An empty register declared explicitly rather than omitted |
| `TEN-EVT-*` | **Closed at two** by `TEN-XC-009`, following the `MM-BR-035` / `SEAT-FR-206` precedent that an event register is explicitly closed rather than left open-ended |

### 2.2 The version, and why it is **not** moved

**`PRD-013` is admitted at v0.1.** This is the first v0.x document ever admitted to this baseline, and the
reasoning is stated at length because the alternative is more intuitive and is wrong.

`ADR-0020` §4 item 2 is the operative rule: *"**The version is preserved at v1.0.** Freeze confers status; it does
not renumber. `PRD-003` was admitted at v1.0, `PRD-004` at v1.2 and `PRD-005` at v1.4 — **each at the version that
was verified.**"* `ADR-0020` §5 rejects the contrary option explicitly: *"Renumber to v1.1 to mark the freeze |
Stage 7 confers status, not content."*

**The verified version of `PRD-013` is v0.1.** Every gate above measured v0.1 — the Stage 3 supplement, both Stage 5
checkers and the Stage 6 gate all ran against `688239cb…ba9c`, which is v0.1. Admitting it as anything else would
admit a version no gate has ever measured.

| Candidate | Rejected because |
|---|---|
| **Admit at v0.1** *(chosen)* | It is the version that was verified. `ADR-0020` §4 item 2, applied literally |
| Renumber v0.1 → v1.0 to mark the freeze | **This is the trap.** It is precisely the act `ADR-0020` §5 rejects. Worse, it would make the baseline cite a version string no gate measured |
| Require the Product Owner to release v0.1 → v1.0 **first** | This was my own earlier reading, recorded in `PRD-013_STAGE7_BLOCKER.md` §2, and it is **withdrawn as an invented rule** — §5 |
| Hold freeze until the number "looks frozen" | A version string is not a gate. `PRD_LIFECYCLE.md` L41: *"A gate is not an opinion"* |

**The apparent counter-evidence, measured and answered.** `grep -cE 'v0\.[0-9]'` on the baseline returns **0** — no
v0.x document has ever been admitted. That is a **fact about history, not a rule**: no repository document states a
minimum version for admission, and searching for one (`version numbering`, `version convention`,
`semantic version`) returns nothing across `docs/00-governance/`. The prior freezes were all of documents their
authors had already numbered ≥ v1.0 before Stage 7 began. **An absence of precedent is not a prohibition**, and
manufacturing a version increment to match a pattern would be inventing the arbitrary version this act is
forbidden to invent.

**What v0.1 does and does not mean after this ADR.** It means: the bytes admitted are the bytes verified. It does
**not** mean provisional, conditional or lesser authority — Rank 3 is conferred by the baseline row, not by the
version string. `PRD_REGISTRY.md` §2.1's rule that status is *"conferred, never self-declared"* cuts the same way
for version: the number records **what was measured**, and the baseline records **what authority it holds**.

### 2.3 Architectural conformance

`PRD-013` holds **context ownership of `BC-19`** and **aggregate ownership of `Tenant` only** — the two-rights
distinction `ADR-0013` §1.5 L132 draws. It matches BC Map §8 **L381** exactly and `TEN-FR-004` closes the aggregate
register at one root.

**It adds no integration edge.** One edge is declared and it exists in BC Map §7; **0** edges are invented.
`TEN-XC-009` forbids publishing any event beyond the two registered at BC Map §9 **L435**.

The boundary discipline that matters most here is **tenant isolation**, and the PRD is stricter than it needed to
be: `TEN-XC-007` makes cross-tenant access *"MUST be impossible"* across *"operation, query, cache, index or
projection"*, and `TEN-XC-010` forbids treating a cached tenant context as evidence that an authorisation still
holds. `X-13` and `ID-1` are upheld by `TEN-XC-003`/`004`/`010` and **neither is waived** — `PRD_LIFECYCLE.md` §7:
*"`X-13` and `ID-1` are never waived under time pressure."*

---

## 3. The two code findings — routed at the correct rank, and **not** fixed here

Both were found at Stage 6 while measuring `lib/platform/tenancy/tenancy.dart` (85 lines, commit **`a44ebb0`**,
authored **before** `PRD-013` existed). Both are recorded in the task document §4.1 and re-measured in the Stage 3
supplement §4.

### 3.1 `D-013-01` — `Branch` is declared in `platform/tenancy`

| Measurement | Result |
|---|---|
| `grep -n 'class Branch' lib/platform/tenancy/tenancy.dart` | **L28** — `final class Branch` |
| `grep -ic 'branch' docs/30-product/tenancy/PRD-013_TENANCY.md` | **0** |
| Who owns `Branch`? | **`BC-06` Library Policy**, per BC Map **L210** and **L375**; the PRD is **`PRD-002`** (`PRD_REGISTRY.md` **L446**), which claims it at §2 **L56** and **L182** as a `BC-06` aggregate |
| Is the term fixed at baseline level? | **Yes** — `DOCUMENTATION_BASELINE.md` §5: *"'Library' (unqualified) — **Ambiguous — do not use.** Say `TenantOrganisation` (the billing entity, `BC-19`) or `Branch` (the physical location with hours and seats, `BC-06`)"* |
| Is `PRD-002` frozen? | **Yes** — Rank 3, `Library_PRD_v1.md` v1.1 |

**This is a code defect, not a specification defect, and the distinction decides everything.** `PRD-013` contains
**zero** occurrences of the string `branch` at any casing. It therefore **cannot** be claiming another bounded
context's aggregate — and `TEN-FR-003` affirmatively **forbids** owning *"any tenant-facing business record beyond
`Tenant`"*, which is the rule the code violates.

**No ADR is required to establish ownership, because ownership is not in doubt.** `Branch` belongs to `BC-06` by
Rank 4 assignment, Rank 3 claim and a fixed baseline term — three independent sources agreeing. `PRD_LIFECYCLE.md`
Stage 7's table routes an *"Ownership or boundary change"* to an ADR; **no ownership change is proposed here.**
Writing an ADR to re-decide a settled question would manufacture a controversy in order to resolve it.

**Disposition: carried as a code task.** `IMPL-801` bears it. Moving the type is a Stage 8 act.

### 3.2 `D-013-02` — `MutableTenantContext` is not async-scoped

| Measurement | Result |
|---|---|
| `grep -cE 'Zone\|runZoned\|AsyncLocal' lib/platform/tenancy/tenancy.dart` | **0** |
| Implementation shape | Four plain mutable fields (`_tenantId`, `_branchId`, `_actorId`, `_correlationId`) with `enter()`/`exit()` |
| Who may call `enter`? | `lib/bootstrap/di.dart` only — L9, *"the only file allowed to call `MutableTenantContext.enter`"*; instantiated L204 |
| The requirement | `TEN-FR-014` — *"Tenant context **MUST** be async-scoped, so that concurrent requests cannot observe each other's"* |
| The criterion | `TEN-AC-002` — *"Two concurrent requests for different tenants never observe each other's tenant context"* → therefore **currently false of the code** |
| Tests covering it | **0** — `find test -iname '*tenan*'` is empty |

**The direction of the conflict is decided by rank, not by preference.** `PRD-013` is the Rank 3 requirement and
post-dates the scaffold; the scaffold is code. Where they disagree the **code** is wrong. Amending `TEN-FR-014` to
match a non-async implementation would be letting the implementation write the requirement, and would **weaken a
tenant-isolation safeguard** that `MP-RSK-01` classifies **Critical**. It is not done.

**Disposition: carried as a code task, correctly bound.** `IMPL-813` bears it — *"Async-scoped tenant context, so
concurrent requests cannot observe each other's"* — with `TEN-FR-014` in its Requirements column, `TEN-AC-002` as
its test requirement, `IMPL-810` as its blocker and `IMPL-829` (the acceptance harness) blocked on it. It is **P1
on the critical path**, which is the correct consequence. Verified by `prd013_task_coverage.py` at exit 0, which
independently proves `TEN-FR-014` is claimed by exactly this task.

**No code is changed by this ADR.** Freeze authorises implementation to *begin*; it does not perform it.
`git status --short lib/ packages/ test/` returns **0 lines**.

### 3.3 Why two contradictions do not block the freeze

Because freeze is a statement about **the specification's authority**, not about the code's conformance. That is
`ADR-0020` §4 item 7 exactly — `PRD-007` was frozen with **0 of 100** tasks and **0 of 226** criteria proven — and
`ADR-0049` §5 restates it: *"`FROZEN` does **not** mean `VERIFIED`."*

Indeed the two findings are an argument **for** freezing rather than against. Until `PRD-013` is Rank 3, the code
and the requirement are two opinions. Once it is Rank 3, the code is measurably wrong against a binding rule, which
is the state in which it gets fixed.

### 3.4 The alignment record's stale hash — supplemented, never overwritten

The base Stage 3 record cites `fcd99ff7…f97e`; the PRD is now `688239cb…ba9c` after the four Stage 4 corrections
(9 identifiers added, 0 removed, 0 renumbered).

**A verdict measured against superseded bytes cannot be relied on alone** (`ADR-0049` §2.1). So
`PRD-013_ARCHITECTURE_ALIGNMENT_SUPPLEMENT.md` re-measures all six Stage 3 checks against the current bytes and
returns **✅ ALIGNED — 5 PASS + 1 CONDITIONAL**, with **0 new conflicts and 0 dispositions reversed**. Both records
are admitted **together** by §4 item 3, so the baseline is the index.

**The historical hash is deliberately preserved.** Editing a Stage 3 record to cite a document Stage 3 never read
would make the record claim a review that did not happen. `alignment_record_freshness.py` will continue to exit 1;
that consequence is **disclosed and left visible**, exactly as `ADR-0042` left the `MP-CON-08` v2.1 drift visible.
The checker does not know about `PRD-013` at all (`grep -c '013\|tenancy'` → **0**) and is **not** modified here —
teaching a gate about a document in the same act that admits the document would let the act mark its own homework.

---

## 4. The decision

1. **`PRD-013_TENANCY.md` v0.1 is admitted to `DOCUMENTATION_BASELINE.md` §3.3 at Rank 3** as the authoritative
   specification for **`BC-19` Tenancy**. The **eighth** module baseline.
2. **Stage 7 Freeze is CONFERRED.** `PRD_REGISTRY.md` status `PLANNED` → **`FROZEN`**.
3. **Four validation records are admitted with it** — the base alignment record, the Stage 3 supplement, the
   Stage 5 conferral and the Stage 6 record — as **validation records, not part of the specification**, on the
   `ADR-0049` §4 item 3 precedent.
4. **The version is preserved at v0.1.** Freeze confers status, not content — §2.2.
5. **No requirement identifier is added, removed, renumbered or reworded.** All 63 declared identifiers, all 12
   retirements, all 13 criteria, the two closed events and the four gaps are **unchanged**. The PRD's **only** edits
   are its *Status*, *Baseline*, *Rank* and *Authorities applied* metadata rows, its **§12 lifecycle-position
   table**, and one changelog entry — §4.1.
6. **No ranked document's content is amended.** `MASTER_PRD.md`, the BC Map, the Dependency Matrix and
   `ARCHITECTURE_RULINGS.md` are untouched. **No integration edge is added.** No global business rule changes. No
   dependency law gains an exception. No bounded context is created — still **31**.
7. **All four `TEN-GAP-*` are admitted OPEN and are not ratified.** `ADR-0020` §4 item 6. Each retains its named
   owner: `TEN-GAP-001` (`ResidencyRegion` value set), `002` (`TenantTier` visibility), `003` (deletion identity),
   `004` (no reinstatement event).
8. **The baseline identifier becomes `BASELINE-2026-08-19-A`**, because a Rank 3 document entered the baseline
   (baseline §7 step 4).
9. **`PRD-013` is `FROZEN`, not `VERIFIED`.** **0 of 30** tasks and **0 of 13** acceptance criteria are proven by a
   test. `SID-4.56`: *"A rule that cannot be checked SHALL be treated as unmet."*
10. **`PRD-013_IMPLEMENTATION_TASKS.md` is NOT admitted to the baseline.** It is a backlog record — unranked and
    editable without an ADR — exactly as `PRD-006`'s and `PRD-008`'s task documents are (`ADR-0049` §4 item 6).

### 4.1 Why §12 may be corrected, and by what authority

`PRD-013` §12 is a **Lifecycle position** table asserting *"Stage 3 — **Not started**"*, *"Stage 4 — **Not
started**"*, *"Stage 5 — **Not started**"*, *"Stage 6 — **Not started**"*. All four statements are **false** against
the artefacts in §2. Leaving them would make the baseline contradict the repository at the moment of admission —
and baseline §7 step 3 states the standard: *"**A baseline that does not match the repository is worse than no
baseline.**"*

**Three independent authorities permit the correction.**

| Authority | What it licenses |
|---|---|
| `ADR-0020` §4 item 3 | Freeze may edit the PRD's *Status*, *Baseline*, *Rank* and *Authorities applied* **metadata rows** plus one changelog entry. §12 is **derived lifecycle metadata** of exactly that kind — it records conferred stage verdicts, and §12's own closing line says so: *"Status is conferred by the lifecycle, never claimed by the document."* Correcting it applies the sentence it already contains |
| `PRD_LIFECYCLE.md` Stage 7 post-freeze table | *"Typo, formatting, broken link → **Nothing. Fix it**"*, and *"Clarifying wording with no change in meaning → **Changelog entry**"*. A stage-status cell that contradicts a conferred verdict is a stale derived statement, not a business rule. **No business rule, requirement, exclusion or identifier is touched** |
| `PRD-019` §6 precedent | The only other PRD with a lifecycle-position section **maintains it as stages pass**, and does so *"measured against the gates, not claimed"*. Its Stage 4 row **quotes the superseded v0.3 verdict rather than overwriting it** — the discipline followed here |

**The correction is made in the freeze commit, not before it, and not silently.** It is disclosed in this ADR, in
the PRD's changelog entry, and in `PRD-013_STAGE7_FREEZE.md`. Prior verdicts are **quoted, not erased**, per the
`PRD-019` §6 practice.

**What is deliberately *not* done to §12:** Stages 8 and 9 remain **Not started**. This ADR does not begin
implementation, and a freeze record that quietly advanced them would claim work that has not happened.

---

## 5. `PRD-013_STAGE7_BLOCKER.md` is superseded, and its error is named rather than deleted

That record returned ⛔ **BLOCKED — 2 blockers**. Both are now answered, and one of them was **my own invented
rule**. Recording that plainly matters more than the outcome.

| Blocker as recorded | Disposition |
|---|---|
| **1.** *"v0.1 `DRAFT` must be released to a version by the Product Owner before freeze"* | ⛔ **WITHDRAWN — not a repository rule.** It rested on the measured fact that **0** v0.x documents have ever been admitted, and treated that absence as a prohibition. It is the opposite of the actual rule: `ADR-0020` §4 item 2 admits *"each at the version that was verified"* and §5 **rejects** renumbering at freeze. My blocker would have required the very act the governing precedent forbids. See §2.2 |
| **2.** *"§12's four false rows must be corrected, but only through an authorized mechanism"* | ✅ **RESOLVED — the mechanism exists and is exercised.** `ADR-0020` §4 item 3 plus the `PRD-019` §6 precedent, executed under §4.1 of this ADR |

**Why the error is worth a section.** The blocker record was careful, cited its evidence, and was still wrong —
because it inferred a rule from a pattern instead of reading the precedent that governs the act. That is the same
failure class this project has logged four times in its own measuring instruments (`SR-01`, and the three checker
defects at `PRD-013_STAGE5_CONFERRAL.md` §3.2), and once already in `ADR-0049` §6.1, where an instrument reported
Stage 6 unreachable and *"had that instrument been trusted, Stage 6 would have been reported permanently
unreachable and this freeze wrongly refused."* **The identical thing nearly happened here.**

**The file is not deleted.** It is marked superseded by this ADR and retained, on the `ADR-0034` / base-alignment
precedent that a superseded verdict is *"retained beside the new one, not overwritten"*.

---

## 6. The authority basis, stated plainly

`PRD_LIFECYCLE.md` §6 **L282** assigns **Stage 7 and the baseline** to the **governance owner**. **L283** records
that *"Every PRD needs a named owner. **None has one**"* — `PGA-08`.

The authority exercised here is a **direct, explicit and unconditional conferral by the human principal of this
engagement**, quoted verbatim:

> *"PRD-013 Tenancy ko Stage 7 Freeze tak end-to-end complete karo. … Freeze tabhi confer karo jab every
> prerequisite genuinely PASS ho. Agar koi prerequisite unresolved rahe to Stage 7 PASS mat karo; exact blocker
> report karo."*

**That instruction is the authority, and it is the only authority claimed.** Same form as `ADR-0033` §7.2,
`ADR-0034` §7.2 and `ADR-0049` §6. **`PGA-08` is not cured** by this ADR; per `ADR-0033` §7.1, *"A conferral for one
act is not a standing licence."*

### 6.1 The condition attached to the grant, and how it was tested

The grant was conditional on *"every prerequisite genuinely PASS."* Each was measured, not assumed (§2). The
instruction also required that the version question be handled *"according to existing repository precedent"* and
that no *"arbitrary version"* be invented — which is what forced §2.2's re-examination and exposed my own blocker
as the invented rule.

**What was NOT asserted.** No ARB meeting was held, minuted or attended. No quorum, attendee list or sign-off date
is claimed. No Product Owner act is asserted, because none is required: the version is **preserved**, not moved, so
there is nothing for a content owner to release.

---

## 7. What acceptance does **NOT** license

| Not licensed | Why |
|---|---|
| `FROZEN` does **not** mean `VERIFIED` | Stages 8–9. **0 of 30** tasks, **0 of 13** criteria proven. No test matching `*tenan*` exists |
| Does **not** start Stage 8 | Freeze authorises implementation to *begin*. It does not begin it. **No file under `lib/`, `packages/` or `test/` is touched** |
| Does **not** fix `D-013-01` or `D-013-02` | §3. Both routed to `IMPL-801` and `IMPL-813`. Moving a type across a context boundary and introducing async scoping are code acts |
| Does **not** close any `TEN-GAP-*` | Four remain OPEN with named owners. `ADR-0020` §4 item 6 |
| Does **not** decide the `ResidencyRegion` value set, `TenantTier` visibility, deletion identity or a reinstatement event | `TEN-GAP-001`…`004`. Each needs its named owner's ruling. **None is asserted** |
| Does **not** resolve `H-1` | The BC Map §7 capability→capability taxonomy hole, affecting `BC-20`→`BC-21` identically. Architecture Owner's. Carried |
| Does **not** cure `PGA-08` | No named individual owner is appointed. §6 |
| Does **not** modify the alignment record or its hash | §3.4. `alignment_record_freshness.py` still exits 1, disclosed |
| Does **not** modify any gate under `tool/` | No checker's `ALLOWED` list is widened. The `TEN-*` outward scan already resolves defined identifiers as citations, so governance documents citing them do not collide — verified at exit 0 **after** these edits |
| Does **not** promote any `PROPOSED` ADR | `ADR-0021`…`0031`, `0038`, `0041` all stay `PROPOSED`. Count **13**, unchanged |
| Does **not** fix the 9 `ADR-0012` boundary violations | `dart run tool/check_module_boundaries.dart` exits 1 with 9 violations + 28 acknowledged findings — **pre-existing**, unrelated, clears with `TASK-D10` |
| Does **not** grant a standing licence | `ADR-0033` §7.1 |

---

## 8. Three pre-existing governance defects found while executing this admission, corrected and **logged**

Executing this admission required reading baseline §4, §8 and `PRD_REGISTRY.md` §7 closely enough to add a row to
each. All three were **already wrong before `PRD-013` touched them** — the same pattern `ADR-0020` §3.6 recorded,
where *"leaving a table wrong while adding a row to it would produce a worse record than either state alone."*

| Defect | What was wrong | Recorded as |
|---|---|---|
| Baseline **header L5** | Declared **`BASELINE-2026-08-05-A`** while §8's latest row is **`BASELINE-2026-08-17-A`** (`ADR-0049`). The `PRD-008` freeze updated §8 and not the header | **`GCP-15`**, baseline §6 |
| Baseline **§4** | Rank 2 read *"`ADR-0001` … `ADR-0020`, `ADR-0032`, `ADR-0033`, `ADR-0034`"* after `ADR-0035`…`0037`, `0039`, `0040`, `0042`…`0049` were accepted; and the Rank 3 list held **seven** module baselines, omitting **`PRD-008` v1.7**, though §3.3 carries its row | **`GCP-16`**, baseline §6 |
| `PRD_REGISTRY.md` **§7** | Counted `PRD-008` under **`DRAFT`** with `FROZEN` at **7**, though `ADR-0049` conferred its freeze on 2026-08-17 | **`GCP-17`**, baseline §6 |

They are **logged** because absorbing them would make this admission look like it added one row when it in fact
repaired three omissions — and because they are one defect class: **a derived statement left behind by a change to
the thing it describes**, now **seven** instances counting `GCP-01`, `GCP-07`, `GCP-08`, `GCP-11`. Seven instances
in four documents is an argument for a mechanical check, not for more diligence.

**None of them ever misconferred a status.** `PRD-008`'s Rank 3 authority came from baseline §3.3 and the
`ADR-0049` acceptance, both correct throughout. Only derived prose and index tables were stale.

---

## 9. Options considered

| Option | Rejected because |
|---|---|
| **Admit at Rank 3, version preserved at v0.1** *(chosen)* | Every gate passes mechanically; the specification is complete for `BC-19`; no ranked document needs amending; v0.1 is the version that was verified |
| Renumber v0.1 → v1.0 as part of the freeze | `ADR-0020` §5 rejects exactly this: *"Stage 7 confers status, not content."* It would also cite a version no gate measured |
| Block until a Product Owner releases the version | The blocker I raised and have withdrawn. §2.2, §5. It infers a rule from an absence of precedent |
| Hold freeze until `D-013-01`/`D-013-02` are fixed in code | Inverts the lifecycle. Stage 8 follows Stage 7; `ADR-0020` froze `PRD-007` with **0 of 100** tasks done. And until the PRD is Rank 3 there is no binding rule for the code to be wrong against |
| Fix `D-013-02` in `lib/` while here | A Stage 7 act has no authority to implement, and the instruction forbade it. `ADR-0020` §6.2: *"**No code.**"* |
| Write an ADR deciding `Branch`'s owner | Ownership is settled by three agreeing sources (§3.1). Manufacturing a controversy to resolve it would invent authority, not exercise it |
| Amend `TEN-FR-014` to match the non-async code | Would let the implementation write the requirement and **weaken** a Critical tenant-isolation safeguard. Explicitly forbidden by the instruction |
| Rewrite the alignment record's hash | Would make a Stage 3 record claim a review that did not happen — `PRD_LIFECYCLE.md` L177 |
| Leave §12's four false rows standing | Baseline §7 step 3: *"A baseline that does not match the repository is worse than no baseline"* |
| Hold freeze until the four gaps close | Each belongs to a named owner outside `BC-19`. `ADR-0018` froze with 2 open, `ADR-0019` with 5, `ADR-0020` with 14, `ADR-0049` with 17 |
| Admit at Rank 4 or 5 | Wrong rank. A module PRD specifying a bounded context is what Rank 3 holds |

---

## 10. Consequences

### 10.1 Immediate

- `PRD-013` is **Rank 3** and **binding** for everything inside `BC-19` Tenancy.
- **Any business-rule change now requires an ADR → version increment → changelog → baseline update, in that order.**
- `PRD_REGISTRY.md`: `PLANNED` 13 → **12**; `FROZEN` → **9** measured (7 declared + `PRD-008` per `GCP-17` + `PRD-013`).
- Rank 2 extends to **`ADR-0050`**. ADR counts: **37 accepted · 13 proposed · 50 files** — **re-derived by
  measurement, not incremented**.
- Baseline → **`BASELINE-2026-08-19-A`**.
- **The foundational tier gains its first frozen specification.** BC Map L271 groups `BC-18` Identity & Access,
  `BC-19` Tenancy and `BC-25` Configuration as `FOUNDATIONAL`; `BC-18` is frozen and `BC-19` now joins it, so the
  tenant-partitioning contract every other context depends on is settled.
- **`D-013-01` and `D-013-02` become measurable code defects against a binding rule**, which is the state in which
  they get fixed.

### 10.2 What does **not** change

- No requirement, event, payload, invariant, acceptance criterion, business rule, register, exclusion or scope
  statement in any PRD — including `PRD-013`'s own.
- `MASTER_PRD.md`, BC Map, Dependency Matrix, `ARCHITECTURE_RULINGS.md`, `TRACEABILITY_MATRIX.md`,
  `PRD-013_IMPLEMENTATION_TASKS.md`, `PRD-013_ARCHITECTURE_ALIGNMENT.md` — **all unmodified**.
- No edge, no context, no dependency-law exception.
- **No code.** No gate script under `tool/`.

### 10.3 Carried forward

All four `TEN-GAP-*`; `D-013-01`; `D-013-02`; `H-1`; the 0-of-13 untested criteria; `PGA-08`; `GCP-05`/`06`/`09`;
the new `GCP-15`/`16`/`17`; `BLK-01`/`TASK-D10`; the 9 `app → domain/library` violations; the stale `IMPL-227`+ row
in `PRD_LIFECYCLE.md` (a Rank 2 edit needing its own governance act).

---

## 11. Compliance

| Requirement | Where satisfied |
|---|---|
| Baseline §7 step 1 — ADR **before** the change | This document, written before any ranked document was touched |
| Baseline §7 step 2 — version + changelog in the same commit | `PRD-013` v0.1 **preserved**; changelog entry added in the same commit |
| Baseline §7 step 3 — declaration updated in the same commit | `DOCUMENTATION_BASELINE.md` header, §3.3, §4, §6, §8 |
| Baseline §7 step 4 — identifier changes on a Rank 1–3 change | `BASELINE-2026-08-17-A` → **`BASELINE-2026-08-19-A`** |
| `PRD_LIFECYCLE.md` Stage 7 — a row in §3 at an assigned rank | `DOCUMENTATION_BASELINE.md` §3.3, Rank 3 in §4 |
| `PRD_REGISTRY.md` §2.1 — status conferred, never self-declared | Conferred here; the PRD's status row **cites** this ADR rather than asserting freeze on its own authority |
| `ADR-0020` §4 item 2 — admit at the verified version | v0.1 preserved. §2.2 |
| `ADR-0020` §4 item 3 — only freeze metadata edited | §4 item 5; §4.1 states the §12 authority explicitly rather than assuming it |
| `X-13` / `ID-1` never waived | `TEN-XC-003`/`004`/`010`. Neither waived; §2.3 |
| `SID-4.56` — unchecked rules are unmet | §4 item 9 admits **0 of 13** criteria proven, and **0 of 30** tasks |
| Stage 8 not entered | §7. No file under `lib/`, `packages/` or `test/` modified; `git status --short` on all three returns 0 lines |

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created and **Accepted**. Admits `PRD-013_TENANCY.md` **v0.1** to Rank 3 as the authoritative specification for `BC-19` Tenancy — the **eighth** module baseline and the **first** `FOUNDATIONAL`-tier product specification frozen. **The first v0.x document admitted to this baseline**, at the version that was verified, per `ADR-0020` §4 item 2 — and §2.2 records why renumbering it would have been the error. Withdraws the Product-Owner-version blocker in `PRD-013_STAGE7_BLOCKER.md` as an **invented rule** (§5). Routes `D-013-01` and `D-013-02` as **code** defects against a correct specification (§3). Admits four `TEN-GAP-*` **OPEN**. Logs three pre-existing governance defects as `GCP-15`/`16`/`17` rather than absorbing them (§8). Written **before** any ranked document was touched, per baseline §7 step 1 |
