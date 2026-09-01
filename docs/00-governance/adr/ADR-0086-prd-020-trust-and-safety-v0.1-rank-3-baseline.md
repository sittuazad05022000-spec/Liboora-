# `ADR-0086` — `PRD-020` Trust & Safety v0.1 admitted to the baseline at Rank 3

| Field | Value |
|---|---|
| **ADR** | `ADR-0086` |
| **Status** | **Accepted** |
| **Date** | 2026-09-01 |
| **Deciders** | **Governance owner** (Stage 7 and the baseline, `PRD_LIFECYCLE.md` §6 **L281**) — exercised by **direct conferral of the human principal** of this engagement, **scoped to this act**, in the form `ADR-0033` §7.2 records and `ADR-0049`…`ADR-0054`, `ADR-0064` and `ADR-0080` have each exercised. **No ARB quorum, attendee list, sign-off date or Security review is asserted** |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document's content.** Admits one document to Rank 3 and records the admission in `DOCUMENTATION_BASELINE.md` §3.3/§4/§6/§8 and `ADR-INDEX.md` |
| **Amended by** | Nothing |
| **Baseline** | **`BASELINE-2026-09-01-A`** — issued because a **Rank 3** document enters the baseline (`DOCUMENTATION_BASELINE.md` §7 rule 4). The date advances, so the suffix resets to `-A` |
| **Subject** | [`../../30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md`](../../30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md), **v0.1**, scoped to **`BC-13` Trust & Safety** |
| **Subject hash** | `685fb65af95668df9bce8757bcd7d04ec9838a56f8dd108652e80d7e7579497b` — **byte-unchanged by this ADR**, verified before and after |
| **⛔ What this ADR does NOT do** | Confers **no** `READY`, **no** `VERIFIED`, **no** Stage 8 entry. Closes **no** gap. Waives **no** prerequisite. Touches **no** file under `lib/`, `test/` or `tool/`. ⛔ **Does not confer Stage 7 on `PRD-021A`** — that is a different document and a different act |

---

## 1. Context

The conferral instructing this act reads, in its operative part:

> *"Acting as Governance Owner by direct conferral for this specific act: 1. Admit `PRD-020` to
> `DOCUMENTATION_BASELINE.md` at Rank 3, version v0.1, scoped to `BC-13`. 2. **Do not waive R-2 /
> Stage-6 requirements.** Keep any unresolved prerequisite explicitly disclosed."*

`PRD-020` was **Unranked** and absent from the baseline: `grep -c "PRD-020" DOCUMENTATION_BASELINE.md`
returned **0** at `dc23110`. `PRD_REGISTRY.md` **L320** records it `PLANNED`.

---

## 2. ⭐ R-2 is FALSIFIED, not waived — the prerequisite is genuinely met

`GOVERNANCE_DECISION_REQUEST_PRD-020-RANK.md` §4 raised **R-2**: *"no Stage 6 record exists."* The
conferral forbade waiving it. ⭐ **No waiver was needed, because R-2 was a measurement error and is
withdrawn.**

**How the error was made.** The prior pass ran `ls docs/40-implementation/ | grep 020` → **0**. That
command lists **top-level entries only**. `docs/40-implementation/` contains **13 module
subdirectories**, and the record lives in one of them.

**What is actually there:**

| Path | Size | Date |
|---|---|---|
| ⭐ `docs/40-implementation/trust-safety/PRD-020_IMPLEMENTATION_TASKS.md` | **34,934 B** | 2026-08-23 |
| `docs/40-implementation/trust-safety/PRD-020_IMPL-1410_IMPLEMENTATION_EVIDENCE.md` | 22,333 B | 2026-08-22 |

⚠ **A trap that made the error persuasive.** The *evidence* record's §7 table (**L219**) states
*"🟡 `IMPL-1400`…`1449` declared **inside** `PRD-020`; **no `PRD-020_IMPLEMENTATION_TASKS.md`
exists**"* — and that was **true when written on 2026-08-22**. The task document was created
**2026-08-23**, one day later. ⭐ **A stale true-when-written statement corroborated a false
measurement.** The lesson is the `PRD-020` L8/L16 lesson again: a derived statement is evidence about
the moment it was written, never about now.

### 2.1 Stage 6's gate tested clause by clause

`PRD_LIFECYCLE.md` §Stage 6: *"an `IMPL-*` range allocated and a task document in which **every task
traces back to requirements**"*, plus four allocation rules.

| Gate clause | Required by | Measured | Verdict |
|---|---|---|---|
| `IMPL-*` range allocated | gate | **`IMPL-1400`…`1449`**, 50 tasks, in the document's own title | ✅ |
| Task document exists | gate | 34,934 B, v1.0, 2026-08-23 | ✅ |
| **Every task traces to requirements** | gate | §10: *"**50 of 50 tasks trace back to requirements — all 50 by direct citation in their own row**"* | ✅ |
| Rule 1 — next free range, never reuse | §Stage 6 | §3.1 *"computed, not chosen"*, next-free by **three independent routes** | ✅ |
| Rule 2 — leave the previous group room | §Stage 6 | ⚠ **Satisfied for the predecessor**; see §2.2 | ⚠ |
| Rule 3 — `Priority`, `Blocks`, `Blocked by` per task | §Stage 6 | recorded for all 50 | ✅ |
| Rule 4 — traceability table | §Stage 6 | §5, §5.1 by wave, §5.2 the `T-n` bridge | ✅ |

Its own §10 verdict: ⭐ **"STAGE 6 SATISFIED ON ITS GATE AS WRITTEN."**

Its §2 independently verifies Stages 2, 3, 4 and 5 as prerequisites. The full chain is therefore
evidenced by records, not asserted:

| Stage | Record | Verdict |
|---|---|---|
| 3 | `PRD-020_STAGE3_ARCHITECTURE_ALIGNMENT.md` | ✅ PASS 6/6 |
| 4 | `PRD-020_STAGE4_REQUIREMENTS_REVIEW.md` v1.2 | ✅ PASS 6/6 |
| 4 (AC) | `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` | ⚠ **QUALIFIED PASS** — see §4 `D-2` |
| 5 | `PRD-020_STAGE5_CONFERRAL.md` · `TRACEABILITY_MATRIX.md` v1.20 §2O | ✅ CONFERRED, 400 identifiers, 0 collisions |
| ⭐ **6** | `PRD-020_IMPLEMENTATION_TASKS.md` v1.0 | ✅ **SATISFIED** |

⭐ **This is why the admission is lawful without waiving anything.** Had Stage 6 genuinely been absent,
this ADR could not have been written: the conferral forbade the waiver, and `PRD_LIFECYCLE.md` **L294**
forbids the skip.

### 2.2 ⚠ `PRD-020` has **no growth reserve** — carried as `D-1`, not cured

Rule 2 obliges an allocation to leave the **previous** group room. `PRD-020` did that. But **its own**
successor range is occupied: `IMPL-1450`…`1499` is `PRD-020`'s declared **V2 content reserve** (PRD
**L2434**), not a growth reserve, and `IMPL-1500`…`1569` is already `PRD-021A`'s.

The task document discloses this itself in **§3.4** — *"this module has no growth reserve, and that is
a disclosed defect, not an oversight."* ⭐ **Rule 2 is a duty owed to the NEXT allocator, and it was
discharged.** Being *boxed in* is a consequence of neighbours, not a breach. Carried as **`D-1`**.

---

## 3. Decision

1. ⭐ **`PRD-020_TRUST_AND_SAFETY.md` v0.1 is admitted to `DOCUMENTATION_BASELINE.md` at Rank 3**,
   scoped to **"Everything inside `BC-13` Trust & Safety"**.
2. **Rank 3 is derived, not chosen.** §4's table admits **13** module PRDs at Rank 3 and **no**
   module PRD at any other rank; ranks 1, 2, 4, 5, 6 and 7 are each occupied by a different document
   class. `PRD-020` owns exactly one bounded context (`BC-13`, PRD **L9**). Rank 3 is the reading of
   the table.
3. **Admitted at v0.1, not renumbered** — `ADR-0020` §4 item 2, *"Freeze confers status; it does not
   renumber."* The **seventh** v0.x admission.
4. **Baseline re-issued as `BASELINE-2026-09-01-A`** — §7 rule 4, a Rank 1–3 document entering.
5. ⛔ **The subject is not edited.** Its hash is anchored by **7** records; see §5.
6. ⛔ **Nothing else is conferred.** Not `READY`, not `VERIFIED`, not Stage 8 — and **not** Stage 7 for
   `PRD-021A`.

---

## 4. ⚠ Prerequisites carried OPEN and disclosed, per conferral clause 2

| # | Item | State | Owner |
|---|---|---|---|
| **`D-1`** | **No growth reserve** — `IMPL-1450`…`1499` is a V2 content reserve, `IMPL-1500`+ is `PRD-021A`'s | ⚠ **OPEN**, §2.2 | Implementation lead |
| **`D-2`** | **Stage 4 AC mapping is a QUALIFIED PASS** — 62/62 ACs cite a requirement, 0 unmapped, 0 orphans, but **31 of 32** orphans closed and the 32nd deferred with reason and owner. Its **L202** declines to call it *"a clean, unqualified PASS in the strongest sense"* | ⚠ **OPEN**, admitted at its true strength | Product Owner |
| **`D-3`** | ⭐ **The subject's header is STALE** — **L8** *"`DRAFT` — Stage 2"*, **L16** *"Stage 2 of 9 — Draft. Stages 3–9 **not started**"*, false against five stage records. **NOT repaired**; see §5 | ⚠ **OPEN** | Document owner |
| **`D-4`** | **Header/content version split** — header v0.1, content v0.5 (PRD **L2564**). Admitted at **v0.1**, the header token | ⚠ **OPEN** | Document owner |
| **`D-5`** | **All 16 `TSF-GAP-*` remain OPEN**, including the **implementation half of `TSF-GAP-003`**, which `TSF-BR-033` and §24.2 **L2046** make a bar to `READY`. `IMPL-1410` is built and tested but **not closed** | ⚠ **OPEN** | Architecture Owner |
| **`D-6`** | **0 of 62** acceptance criteria proven; task-level requirement coverage **15.0%**; acceptance coverage **76/187 = 40.6%**, the lowest in the repository, **published not flattered** | ⚠ **OPEN** | Implementation lead |
| **`D-7`** | `PRD_REGISTRY.md` **L320** reads `PLANNED`. **Not advanced here** — see §6 | ⚠ **OPEN** | Governance Owner |

⛔ **`FROZEN` is not `VERIFIED`.** `D-5` alone means `PRD-020` is admitted as **authoritative**, not as
**done**.

---

## 5. ⛔ Why the stale header was NOT repaired — conferral clause 3 applied

Clause 3: *"Repair the stale header **only if mechanically required and within the authorised scope**;
otherwise disclose it."* Both limbs were tested and **both fail**.

**(a) Not mechanically required.** Nothing in Stage 7's gate — *"a row in `DOCUMENTATION_BASELINE.md`
§3 at an assigned precedence rank"* — reads the subject's header. The rank is recorded in the baseline,
not in the PRD. The admission completes with the header untouched.

**(b) Not within the authorised scope, on a measured ground.** The subject's hash
`685fb65af95668df…` is **anchored by 7 records**:

`ADR-0082` · `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` · `PRD-020_STAGE5_CONFERRAL.md` ·
`PRD-020_BLOCKER_RESOLUTION_AUDIT.md` · `PRD-021A_STAGE7_BLOCKER.md` (**PROTECTED**,
`0e42f4a5457b14cf`) · `TRACEABILITY_MATRIX.md` · `PRD-020_IMPLEMENTATION_TASKS.md`

⭐ **Editing one character of the header would falsify all seven simultaneously** — including a
PROTECTED document and an `Accepted` ADR. This is the exact `PRD-012a` `SECP-FR-018` precedent, where a
marker was left in place *even though its condition was satisfied*, because removal would invalidate the
gate records anchored to the hash.

`PRD_LIFECYCLE.md` **L177** — *"A frozen PRD is never silently modified. Not for an obvious correction,
and not for one that is certainly right."* This correction is certainly right. It is still not made.

Carried as **`D-3`**.

---

## 6. ⛔ What this ADR does not license

| Refused act | Why |
|---|---|
| Advance `PRD_REGISTRY.md` **L320** off `PLANNED` | A registry status change is a separate act on a separate document; the conferral named the **baseline**. Carried as `D-7` |
| Repair the subject's header, version split, or any derived count | §5 |
| Close `TSF-GAP-003` or mark `IMPL-1410` complete | **Architecture Owner**; the `ADR-0065` conferral is spent (`ADR-0033` L169) |
| Consume `IMPL-1450`…`1499` | It is `PRD-020`'s declared V2 reserve |
| ⛔ **Confer Stage 7 on `PRD-021A`** | ⭐ **Different document, different act.** `PRD-021A` needs **its own** baseline §3 row; measured **0** |
| Name an SMS provider, or waive/silence the 9 `ADR-0012` violations | Conferral clause 6; `ADR-0012` **L181** *"Not waived"* |
| Create `integration_test/` | Conferral clause 6; **0** `Community`/`Group` classes exist |
| Repair `GCP-20` (the missing `PRD-014` §4 row) | A pre-existing defect of a different admission, carried by its own register row |

⭐ **A conferral for one act is not a standing licence** — `ADR-0033` §7.1. This authority is spent on
`PRD-020`'s admission.

---

## 7. Consequences

**Positive.** `BC-13` Trust & Safety gains an authoritative Rank 3 specification. The **fifteenth**
Rank 3 module baseline. `PRD-021A`'s audit named *"an admission ADR for `PRD-020`"* as the next
governance action for the `PRD-020` dependency; that action is now taken.

**Negative / carried.** Seven items `D-1`…`D-7` remain OPEN. A Rank 3 document now carries a header
that contradicts its own status — visible, disclosed, and unrepairable without a second act.

⭐ **`PRD-021A` is NOT unblocked by this ADR.** Its Stage 7 gate is its **own** baseline §3 row, still
absent. See §8.

---

## 8. `PRD-021A` Stage 7 — measured at this commit

| Prerequisite | Measured | Verdict |
|---|---|---|
| `PRD-021A` row in baseline §3 | **0** — the single `grep` hit is **L139**, the **Rank 6 EA** row, which *ends* *"`PRD-021A` remains **NOT READY / NOT FROZEN**"* | ⛔ **UNMET** |
| `LCF-AC-035` / `LCF-AC-036` verifiable | **0** `Community`/`Group` classes in `lib/`; `integration_test/` absent | ⛔ UNMET |
| `TASK-D10` §7 / the 9 violations | `MP-DEP-03` Type **`External`**; **0** provider packages | ⛔ UNMET |
| `LCG-GAP-001`, `LCG-GAP-006`, `LCF-GAP-011` + 15 more | all OPEN (`ADR-0081` §3, predicates measured TRUE) | ⛔ UNMET |

⛔ **Stage 7 is NOT conferred on `PRD-021A`. Stage 8 is NOT entered.**

---

## 9. Integrity

| Surface | State |
|---|---|
| `PRD-020_TRUST_AND_SAFETY.md` | ✅ **byte-unchanged** — `685fb65af95668df…` before and after |
| `PRD_LIFECYCLE.md` | ✅ unchanged — `5031fcc97a95980e` |
| `PRD-021A_STAGE7_BLOCKER.md` | ✅ unchanged — `0e42f4a5457b14cf` |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | ✅ unchanged — v1.10, 847 lines |
| All Stage 3/4/5/6 records | ✅ unchanged |
| `lib/`, `test/`, `tool/` | ✅ **0 lines** changed |
| Historical / dated review records | ✅ **0 modified** |

**Identifiers minted: 0. Gaps closed: 0. Waivers written: 0. Requirements changed: 0. Events: 0.
Edges: 0. Vendors named: 0.**

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-01 | Created and **Accepted** by direct Governance Owner conferral scoped to this act. Admits `PRD-020` v0.1 to Rank 3 for `BC-13` and issues **`BASELINE-2026-09-01-A`**. ⭐ **`R-2` is FALSIFIED rather than waived** — the Stage 6 record exists at `docs/40-implementation/trust-safety/PRD-020_IMPLEMENTATION_TASKS.md` (34,934 B, v1.0, 2026-08-23, verdict *"STAGE 6 SATISFIED ON ITS GATE AS WRITTEN"*, 50/50 tasks tracing); the prior *"no Stage 6"* finding came from `ls \| grep` missing a **subdirectory**, and was corroborated by a **stale true-when-written** line in the 2026-08-22 evidence record. Seven prerequisites `D-1`…`D-7` carried **OPEN and disclosed**, per conferral clause 2. The **stale header was NOT repaired** (clause 3): not mechanically required, and its hash is anchored by **7** records including a PROTECTED document and an `Accepted` ADR. ⛔ Confers **no** `READY`, **no** `VERIFIED`, **no** registry advance, and ⛔ **no Stage 7 for `PRD-021A`**, whose own baseline row remains measured at **0**. |
