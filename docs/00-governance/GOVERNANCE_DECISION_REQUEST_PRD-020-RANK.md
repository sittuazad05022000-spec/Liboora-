# Governance Decision Request — `PRD-020` Trust & Safety baseline rank

| Field | Value |
|---|---|
| **Document type** | **Decision request.** ⛔ This document decides nothing and confers nothing |
| **Raised** | 2026-09-01, by the `PRD-021A` **Final Governance + Engineering Unblock** pass |
| **Raised under** | Instruction 2: *"Prepare and execute the valid owner decision for the `PRD-020` baseline rank; if the exact rank requires Governance Owner approval, present the recommended rank and **STOP** for explicit approval."* |
| **Decision required from** | ⛔ **Governance Owner** — `PRD_LIFECYCLE.md` **L281**: *"Governance owner \| Stage 7; the baseline"* |
| **Holder** | ⛔ **VACANT.** `ADR-0080` **L85**: *"It is constituted VACANT"* |
| **Status** | ⏳ **AWAITING EXPLICIT GOVERNANCE OWNER APPROVAL** |
| **Recommendation** | **Rank 3**, scoped to *"Everything inside `BC-13` Trust & Safety"* — **derived from the existing table, not invented.** See §2 |
| **⛔ What was NOT done** | No rank assigned · no baseline §3 row written · no §4 precedence row written · no lifecycle stage conferred · `DOCUMENTATION_BASELINE.md` **byte-unchanged**, sha256 `7e1c69f92363a5e5…` |

> ⛔ **This request does not make `PRD-020` ranked by presenting a recommendation.**
> A recommendation with an owner and a reason is the *input* to a decision. It is not the decision.

---

## 1. The exact question

> **Does the Governance Owner approve admitting `PRD-020` Trust & Safety to
> `DOCUMENTATION_BASELINE.md` §3 and §4 at Rank 3, scoped to `BC-13` Trust & Safety — and if so,
> at which version, and subject to which of the four residues in §4 being closed first?**

The question is deliberately narrow. It asks about a **rank and a scope**, both of which already have
an unambiguous precedent in the table being amended. It does **not** ask the Governance Owner to
approve a freeze, confer a lifecycle stage, or accept `PRD-020`'s contents.

---

## 2. ⭐ Why Rank 3 is *derived*, not invented

`DOCUMENTATION_BASELINE.md` **§4** was enumerated mechanically at **L236–L254**. Every module PRD in
it sits at **Rank 3**, each scoped to its own bounded context. There are **no exceptions** and **no
other rank is available** to a module PRD:

| Rank | Occupied by | Could `PRD-020` go here? |
|---|---|---|
| **1** | `MASTER_PRD.md` global rules only | ⛔ No — `PRD-020` is a module PRD, not a platform-wide rule set |
| **2** | Accepted ADRs only | ⛔ No — `PRD-020` is not an ADR |
| **3** | ⭐ **All 13 module PRDs**, each scoped to one context | ✅ **The only fitting rank** |
| **4** | BC Map · Module Dependency Matrix | ⛔ No — those are architecture registers |
| **5** | Architecture Rulings `AR-1`, `AR-3`, `AR-4` | ⛔ No |
| **6** | Enterprise Architecture — *"Descriptive only"* | ⛔ No — a PRD leads, it does not follow |
| **7** | Configuration Guide | ⛔ No |

**The 13 existing Rank 3 rows**, measured: Authentication `BC-18` · Library (Library Management) ·
Student Identity `BC-10` · Student Management `BC-01` · Membership `BC-02` · Seat Management `BC-04` ·
Attendance `BC-03` · Revenue & Finance `BC-05` · Tenancy `BC-19` · Audit Trail `BC-24` ·
Settings & Configuration `BC-25` · File & Media `BC-29` · Security Automation (SECURITY platform).

`PRD-020` owns **`BC-13` Trust & Safety** — stated in its own header **L9**, citing Bounded Context Map
**L117**. ⭐ **So the recommendation is a reading of the table, not a judgement about importance.**
Placing a fourteenth module PRD anywhere other than Rank 3 would be the act that invents something.

⚠ **Precision about what is and is not being recommended.** Rank 3 is recommended **as the rank, if
admission is approved**. Whether `PRD-020` should be admitted **at all, and at what version**, is a
separate question that only the Governance Owner may answer, and §4 lists four reasons it may
reasonably be answered *"not yet"*.

---

## 3. Measured readiness evidence

| Stage | Record on disk | Verdict as written |
|---|---|---|
| **Stage 3** — Architecture alignment | `PRD-020_STAGE3_ARCHITECTURE_ALIGNMENT.md` | ✅ **PASS** |
| **Stage 4** — Requirements review | `PRD-020_STAGE4_REQUIREMENTS_REVIEW.md` | ✅ **PASS** |
| **Stage 4** — AC/requirement mapping | `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` | ⚠ **QUALIFIED PASS** — 62/62 ACs cite a requirement, 0 unmapped, 0 orphans; **31 of 32** orphans closed and the 32nd **explicitly deferred with a reason (§4) and an owner (Product Owner)**, which the gate's own wording permits. ⭐ The record itself refuses to call this *"a clean, unqualified PASS in the strongest sense"* |
| **Stage 5** — Traceability | `PRD-020_STAGE5_CONFERRAL.md` | ✅ **CONFERRED** — *"gate satisfied mechanically by two independent, mutation-tested instruments, zero collisions in four directions"* |
| **Stage 6** — Implementation tasks | ⛔ **NO RECORD EXISTS** — `ls docs/40-implementation/ \| grep 020` → **0** | ⛔ **NOT STARTED** |
| **Stage 7** — Freeze | ⛔ no record | ⛔ **NOT STARTED** |

---

## 4. ⚠ Four residues the Governance Owner must weigh — disclosed, not minimised

**R-1 — ⭐ `PRD-020`'s own header contradicts its own stage records, and the header is STALE.**
`PRD-020_TRUST_AND_SAFETY.md` **L8** reads *"`DRAFT` — Stage 2"* and **L16** reads *"Stage 2 of 9 —
Draft. Stages 3–9 **not started**"*. That is **false against four records on disk**. The header was
written before the stage work and never updated — the *derived-statement* defect class this repository
already tracks as `GCP-01`/`07`/`08`/`11`/`12`/`15`/`16`/`17`/`18`/`19`.
⛔ **It is NOT repaired here.** Editing a Rank 3 PRD's status field is precisely the silent amendment
`PRD_LIFECYCLE.md` **L177** forbids (*"A frozen PRD is never silently modified. Not for an obvious
correction, and not for one that is certainly right"*), and doing it as a side effect of a rank request
would be worse. **Repairing it is part of the admission act, and belongs to the Governance Owner.**

**R-2 — Stage 6 does not exist.** No implementation-task record for `PRD-020` exists anywhere.
`PRD_LIFECYCLE.md` **L280** assigns Stages 6 and 8 to the **Implementation lead**, not to Governance.
Every one of the 13 admitted Rank 3 PRDs passed through Stage 6 before admission.

**R-3 — the registry still reads `PLANNED`.** `PRD_REGISTRY.md` **L320** carries `PRD-020` as
`PLANNED`, and **L546** counts it among the **7** `PLANNED` PRDs. Admission must move that cell in the
same commit, per baseline **§7 rule 3**.

**R-4 — admission would move the baseline identifier.** `DOCUMENTATION_BASELINE.md` **§7 rule 4**:
*"The baseline identifier changes only when a Rank 1–3 document changes version."* A Rank 3 admission
is exactly that trigger, so the header identifier and §8 changelog must both advance in the same
commit. ⭐ This is why the act cannot be split: **§3 row + §4 row + identifier + changelog + registry
cell are one atomic Governance act**, and an ADR must precede it (**§7 rule 1**).

---

## 5. What the Governance Owner is being asked to do

| # | Act | Who may perform it |
|---|---|---|
| 1 | Rule on whether `PRD-020` is admitted, and at which version | ⛔ **Governance Owner only** |
| 2 | If admitted: write the **ADR first** (baseline §7 rule 1) | ⛔ **Governance Owner only** |
| 3 | Add the `DOCUMENTATION_BASELINE.md` **§3** row and the **§4** Rank 3 precedence row | ⛔ **Governance Owner only** |
| 4 | Advance the baseline identifier and §8 changelog (§7 rule 4) | ⛔ **Governance Owner only** |
| 5 | Update `PRD_REGISTRY.md` **L320** off `PLANNED` and re-derive **L546** | ⛔ **Governance Owner only** |
| 6 | Repair `PRD-020`'s stale header (R-1) as part of the admission | ⛔ **Governance Owner only** |
| 7 | Decide whether **R-2** (no Stage 6) must be closed **before** admission | ⛔ **Governance Owner only** |

---

## 6. ⛔ What this request explicitly does not claim

- ⛔ Does **not** assign, imply, default or reserve a rank for `PRD-020`.
- ⛔ Does **not** write, draft or stage any `DOCUMENTATION_BASELINE.md` row.
- ⛔ Does **not** confer Stage 6, Stage 7 or any other lifecycle stage on `PRD-020`.
- ⛔ Does **not** repair `PRD-020`'s stale header, its registry row, or any derived count.
- ⛔ Does **not** assert that `PRD-020` is ready — **R-2 alone is a substantive reason to refuse**.
- ⛔ Does **not** unblock `PRD-021A`. `PRD-021A`'s Stage 7 gate is its **own** baseline §3 row, which
  is a separate Governance act on a separate document, still **absent** (measured: **0** rows).

---

## 7. ⭐ How this request can lawfully be answered while the office is VACANT

⚠ **Added 2026-09-01, by append.** §1–§6 are unchanged. This section was added because the original
request named the blocker (**VACANT**) without naming the repository's own remedy, which is a
deficiency in the request, not a new decision. **Nothing here decides anything.**

### 7.1 The vacancy is not terminal — it has a documented, exercised remedy

`ADR-0080` §2.2 rule 2 constitutes the Governance Owner office **VACANT**, and `PRD_OWNERSHIP_MODEL.md`
rule **7.4** forbids ever recording a personal name in it. Those two facts together mean the office can
**never** be filled by writing a name into a document — so if a vacant office were an absolute bar, Stage 7
would be permanently unperformable, and `PRD_LIFECYCLE.md` **L294** (*"No fast path. Stage 7 is not
skippable"*) would make every PRD permanently unfreezable.

⭐ **The repository has already resolved this, eight times.** The mechanism is **direct, explicit conferral
by the human principal of this engagement, scoped to a single act**, recorded in the ADR's `Deciders` row.

| ADR | Act performed under conferral | Status |
|---|---|---|
| `ADR-0049` | Revenue baseline | Accepted |
| `ADR-0050` | Tenancy baseline | Accepted |
| `ADR-0051` | Audit Trail baseline | Accepted |
| `ADR-0052` | Entitlement baseline | Accepted |
| ⭐ `ADR-0053` | **Admitted `PRD-023` to Rank 3** — the closest precedent to this request | Accepted |
| `ADR-0054` | Froze `PRD-017` | Accepted |
| `ADR-0064` | Baselined `PRD-012a` | Accepted |
| `ADR-0080` | Constituted this very office | Accepted |

`ADR-0053` **L8** states the form exactly:

> *"**Governance owner** (Stage 7 and the baseline, `PRD_LIFECYCLE.md` §6 L282) — exercised by direct
> conferral of the human principal of this engagement, scoped to this act"*

and `ADR-0053` §6 states the authority plainly: *"**That instruction is the authority, and it is the only
authority claimed.**"*

### 7.2 ⛔ Why a generic instruction is NOT such a conferral

`ADR-0033` §7.1 — *"**A conferral for one act is not a standing licence**"* — cuts **both** ways, and the
limiting direction is the one that binds here. A conferral must be **specific to the act**. Therefore:

| Not a conferral | Why |
|---|---|
| *"Continue"* / *"proceed"* / *"go ahead"* | Names no act, no rank, no document, no version. `ADR-0053` §6 requires the instruction itself to be the authority; an instruction that specifies nothing authorises nothing |
| Silence, or absence of objection | Confers nothing; no precedent treats non-response as approval |
| A conferral given for a **different** act | `ADR-0033` §7.1 — the eight ADRs above each carry their **own** conferral; none inherits another's |
| This document recommending Rank 3 | ⛔ A recommendation is not a decision. §6 already disclaims it |

⚠ **Recorded plainly:** during the pass that produced this section, the instruction *"Continue"* was given.
It was **measured against this test and refused as a conferral** — it names no act. No rank was assigned,
no row written, and this section is the only change made.

### 7.3 ⭐ The exact wording that WOULD unblock this request

The Governance Owner's decision can be given in one sentence. To admit `PRD-020`, the conferral must name
**the act, the document, the rank and the version**, for example:

> *"Acting as Governance Owner by direct conferral for this act: admit `PRD-020` to the documentation
> baseline at **Rank 3**, scoped to `BC-13`, at version **v0.1**, and write the required ADR, the
> `DOCUMENTATION_BASELINE.md` §3 and §4 rows, and the baseline identifier advance. Residue **R-2** (no
> Stage 6 record) is [waived for admission / must be closed first]. Residue **R-1** (`PRD-020`'s stale
> header at L8/L16) is [repaired as part of the admission / left disclosed]."*

⛔ **Refusal is an equally valid and complete answer**, and **R-2 alone is a substantive ground for it**
(§6). A refusal needs no remedy from this document; it simply closes the request.

### 7.4 ⛔ What §7 does not do

- ⛔ Does **not** confer, self-confer, assume, infer or imply Governance Owner authority.
- ⛔ Does **not** treat the eight precedents as authority for **this** act — each was scoped to its own.
- ⛔ Does **not** appoint anyone, name any person, or fill the office. `ADR-0080` §2.2 rule 2 stands.
- ⛔ Does **not** change the recommendation, the residues, or any measurement in §1–§6.
- ⛔ Does **not** narrow the Governance Owner's options — §7.3's wording is an illustration, not a form
  that must be used, and refusal remains fully available.
