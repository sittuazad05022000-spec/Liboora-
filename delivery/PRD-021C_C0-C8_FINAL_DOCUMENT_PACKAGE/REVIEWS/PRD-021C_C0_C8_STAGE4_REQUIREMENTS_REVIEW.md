# `PRD-021C` C0–C8 — Consolidated Stage 4 Requirements Review Record

| Field | Value |
|---|---|
| **Stage attempted** | **Stage 4 — Requirements Review** (`PRD_LIFECYCLE.md` **L108–L119**) |
| **Subject** | `PRD-021C` parts **C0, C1, C2, C3, C4, C5, C6, C7, C8**, reviewed as **one consolidated unit** |
| **Gate** | *"conflicts closed or explicitly deferred **with a reason and an owner**"* (**L119**) |
| **Predecessor** | Stage 3 ✅ **PASS — 6 of 6**, [`PRD-021C_C0_C8_STAGE3_ARCHITECTURE_ALIGNMENT.md`](PRD-021C_C0_C8_STAGE3_ARCHITECTURE_ALIGNMENT.md), delivered at `40b52b2` |
| **Measured at** | `40b52b23f3186dcd3a6dd0fa4f9dd4105fcb7428`, working tree clean |
| **Reviewer role** | Requirements reviewer (`PRD_LIFECYCLE.md` §6 **L278**). ⚠ **No named holder exists** — `PGA-08`, `PRD_LIFECYCLE.md` **L283**: *"Every PRD needs a named owner. **None has one**"* |
| **Authority claimed** | ⛔ **NONE beyond measurement.** This record is a **measurement**, not an approval, and not a conferral |
| **Subject hashes** | ⛔ **All nine byte-unchanged by this review** — verified before and after (§21) |
| **Verdict** | ⛔⛔ **STAGE 4 BLOCKED — 5 of 6 checks PASS; CHECK 4 FAILS on 64 of 123 acceptance criteria (52%).** Gate **L119 SATISFIED** (6 open decisions, 0 without a reason, 0 without an owner). ⛔ **NOT CONFERRED** — no Stage-4 conferral authority exists (§19) |
| **Stage 4** | ⛔ **NOT PASSED, NOT CONFERRED** |
| **Stage 5** | ⛔ **NOT ENTERED** |
| **Stage 6** | ⛔ **NOT ENTERED** — **0** `IMPL-*` allocated |
| **Freeze (Stage 7)** | ⛔ **NOT DONE** |
| **Implementation (Stage 8)** | ⛔ **NONE** — 0 lines of application code |
| **Date** | 2026-09-03 |

> ⛔ **This record does not make Stage 4 pass by interpretation.**
>
> ⛔ **Stage-3 PASS did not carry to Stage 4, and this record re-derived every count.**
> Stage 3 asks *"is this lawful against Ranks 1–5?"*; Stage 4 asks *"is this **buildable and
> verifiable** as written?"* The six checks share no overlap.
>
> ⛔ **No requirement was written to close any criterion.** `PRD-008_STAGE4_CONFERRAL.md` §4:
> *"The most corrupting way to pass a requirements review is to write the missing requirement."*
> **0 identifiers minted. 0 subject bytes changed. 0 owner decisions invented. 0 ADRs written.**
>
> ⭐ **The failing check is reported as failing.** `PRD_LIFECYCLE.md` **L41**: *"A gate is not an
> opinion — if the artefact does not exist, the stage has not been passed, however complete the
> work feels."*

---

## 1. Scope

### 1.1 What this record is

A **measurement** of `PRD-021C` parts C0–C8 against the six checks and the gate that
`PRD_LIFECYCLE.md` **L108–L119** defines for Stage 4, performed by re-deriving every figure
from the nine subjects' own bytes at `40b52b2`.

### 1.2 What this record is **NOT**

| Not done | Why |
|---|---|
| A conferral of Stage 4 | The **Requirements reviewer** role (**L278**) has **no named holder** — `PGA-08`. Conferral requires one. §19 |
| A repair of the Check-4 failure | The smallest lawful repair edits C1–C4's criterion rows. Those are **established parts**, and the repair is the **Product Owner's** act, not this record's. §9.5 |
| Creation of any requirement to cover a criterion | Forbidden. A fabricated register entry is worse than a disclosed gap |
| Creation of any `IMPL-*` task | `IMPL-*` allocation is **Stage 6** (**L135–L153**), not Stage 4. §2.2 |
| Any application code | Implementation is **Stage 8** (**L44–L54** table), not Stage 4. §2.2 |
| Any freeze, baseline admission or approval | Freeze is **Stage 7**; **L161**: *"Freeze is conferred, not claimed"* |
| Resolution of any open decision | `XPC-OD-004`, `005`, `006`, `008`, `009`, `010` remain **OPEN** with their named owners. §14 |
| Any new ADR, bounded context, integration edge or domain event | §15 |
| Any edit to a validator or fixture | ⛔ Manufacturing a PASS by changing the instrument is forbidden. §21 |
| Any cleanup of unrelated pre-existing defects | Disclosed, routed to owners, not repaired. §17 |

### 1.3 The gate, quoted verbatim

> **Gate:** conflicts closed or explicitly deferred **with a reason and an owner**.
>
> — `PRD_LIFECYCLE.md` **L119**

---

## 2. ⭐⭐ Lifecycle determination — what Stage 4 actually authorises

### 2.1 The definition, from the authority

`PRD_LIFECYCLE.md` §2 **L44–L54** enumerates nine stages. Stage 4 is **not** implementation:

| # | Stage | Registry status | Exit gate |
|---|---|---|---|
| 3 | Architecture Review | `IN_REVIEW` | Every boundary, edge and rank validated against the BC Map |
| **4** | **Requirements Review** | **`IN_REVIEW`** | **Every requirement uniquely identified, testable, non-duplicating** |
| 5 | Traceability | `APPROVED` | Prefixes registered in `TRACEABILITY_MATRIX.md`; zero collisions |
| 6 | Implementation Tasks | `APPROVED` | `IMPL-*` range allocated; every task traces to requirements |
| 7 | **Freeze** | **`FROZEN`** | Row in `DOCUMENTATION_BASELINE.md` §3 at a precedence rank |
| 8 | Implementation | `IMPLEMENTING` → `IMPLEMENTED` | All tasks closed |
| 9 | Verification | `VERIFIED` | Every acceptance criterion proven by a test |

### 2.2 What follows, and what does not

| Question put to the document | Answer measured | Consequence for this turn |
|---|---|---|
| Does Stage 4 authorise **implementation-task creation**? | ⛔ **No.** `IMPL-*` allocation is the **Stage 6** exit gate (**L135–L153**) | **0** `IMPL-*` created |
| Does Stage 4 authorise **application code**? | ⛔ **No.** Implementation is **Stage 8** | **0** lines of code written |
| Does Stage 4 authorise **freeze or baseline admission**? | ⛔ **No.** That is **Stage 7**, and **L161**: *"Freeze is conferred, not claimed"* | **0** baseline rows |
| Does Stage 4 authorise **approval**? | ⛔ **No.** `APPROVED` first appears at **Stage 5** | Status stays `IN_REVIEW`-eligible only |
| Does Stage 4 require an **additional authorisation**? | ⚠ **Yes** — the reviewer role at **L278** has no holder (`PGA-08`) | ⛔ **Conferral withheld.** §19 |

> ⭐ **Stage-4 semantics were determined from the document, not from the name.** Had the name
> been taken at face value, this turn would have produced tasks and code that the lifecycle
> places four and five stages downstream.

---

## 3. Entry-gate verification (pre-Stage-4 state)

| Requirement | Measured | Result |
|---|---|---|
| HEAD contains `40b52b2` or a clean descendant | HEAD = `40b52b23f3186dcd3a6dd0fa4f9dd4105fcb7428`; `git merge-base --is-ancestor 40b52b2 HEAD` ✅ | ✅ |
| Working tree clean | `git status --short` → empty | ✅ |
| Branch | `main` | ✅ |
| Remote parity before work | `HEAD == github/main`; ahead/behind **0 0** | ✅ |
| Stage-3 record exists | 593 lines, PASS 6/6, committed `40b52b2` | ✅ |
| C0–C8 at ALIGNED / Stage 3 | Stage-3 record §14: **9 of 9 ALIGNED** | ✅ |
| No unexpected tree changes | Subject hashes identical to the Stage-3 record's §1 (§4) | ✅ |
| No unrelated branch movement | Only `main`; reflog contains `commit:` entries only | ✅ |
| No unexpected `IMPL-*` | `docs/40-implementation/` references to 021C: **0** | ✅ |
| No pre-existing Stage-4 artefact | `git ls-files \| grep -i 'PRD-021C.*STAGE4'` → **0** | ✅ |

⛔ **No unexpected state was found, so no repair was attempted or required.**

---

## 4. Subjects measured — nine parts, re-hashed

| Part | Lines | Identifiers | sha256 (first 12) | Registers |
|---|---|---|---|---|
| **C0** | 576 | **29** | `27722b18f3e2` | `XPC-CONF` 19 · `XPC-OD` 10 |
| **C1** | 354 | **46** | `8bdc774269ec` | FR 24 · XC 10 · AC 12 |
| **C2** | 457 | **60** | `1a5f42b2e689` | FR 32 · XC 12 · AC 16 |
| **C3** | 1018 | **83** | `3e194d433ff3` | FR 44 · XC 17 · AC 22 |
| **C4** | 576 | **68** | `60839e911d2d` | FR 36 · XC 14 · AC 18 |
| **C5** | 726 | **54** | `4327033aae82` | FR 18 · BR 8 · XC 16 · AC 12 |
| **C6** | 755 | **59** | `0bd6572931dc` | FR 22 · BR 9 · XC 14 · AC 14 |
| **C7** | 719 | **55** | `c90376fcaed9` | FR 18 · BR 9 · XC 15 · AC 13 |
| **C8** | 778 | **74** | `1cfbb5e6beb5` | FR 26 · BR 12 · XC 20 · AC 16 |
| **TOTAL** | **5,959** | **528** | — | FR **220** · BR **38** · XC **118** · AC **123** · XPC **29** |

⭐ **Every hash is identical to the Stage-3 record's §1 table.** The subjects were not touched
between Stage 3 and this review, and are not touched by it.
✅ **Every register is contiguous from `001`** — verified per family, per part, across all nine.

---

## 5. The six checks, plus the gate

| # | Check (**L110–L117**) | Stated failure mode | Result |
|---|---|---|---|
| 1 | Every requirement testable | *"The system should be fast" — unverifiable* | ✅ **PASS** — 258 of 258 FR/BR; **0** vague constructions. §6 |
| 2 | Every exclusion states what must be **impossible** | *"An exclusion is not a deferral"* | ✅ **PASS** — 118 of 118 XC; **0** phrased as deferrals. §7 |
| 3 | Every configurable has a default and a range | *"Unbounded configuration is a specification hole"* | ✅ **PASS, vacuously** — **0** `*-CFG-*` registers exist. §8 |
| 4 | **Every acceptance criterion maps to a requirement** | *"Orphan criterion"* | ⛔⛔ **FAIL — 64 of 123 (52%)**. §9 |
| 5 | No requirement restates another PRD's | *"Two sources of truth"* | ✅ **PASS** — **0** foreign-stem definitions; 110 cross-stem uses are all **citations**. §10 |
| 6 | Business rules do not contradict Rank 1 | *"Rank 1 wins; the PRD is wrong"* | ✅ **PASS** — 38 BR, **0** contradictions of `MASTER_PRD.md`. §11 |
| — | **GATE (L119)** | *"conflicts closed or explicitly deferred with a reason and an owner"* | ✅ **SATISFIED** — 6 open decisions, **0** without a reason, **0** without an owner. §12 |

### **5 of 6 checks pass. Check 4 fails. The gate passes.**

> ⭐ **The check matrix and the gate are separate instruments and are reported separately.**
> A satisfied L119 gate does **not** cure a failed check — precedent
> `PRD-021A_STAGE4_REQUIREMENTS_REVIEW_2026-08-31.md` **L98**: *"5 of 6 checks pass. Check 4
> fails. The gate passes."* That record recorded the failure as a **BLOCKER** and did not
> promote the stage. This record does the same.

---

## 6. Check 1 — every requirement testable ✅ PASS

### 6.1 Mechanical result

| Part | FR | BR | Definitions | Vague | No normative keyword |
|---|---|---|---|---|---|
| C1 | 24 | 0 | 24 | **0** | 0 |
| C2 | 32 | 0 | 32 | **0** | 0 |
| C3 | 44 | 0 | 44 | **0** | 0 |
| C4 | 36 | 0 | 36 | **0** | 0 |
| C5 | 18 | 8 | 26 | **0** | 5 |
| C6 | 22 | 9 | 31 | **0** | 5 |
| C7 | 18 | 9 | 27 | **0** | 0 |
| C8 | 26 | 12 | 38 | **0** | 9 |
| **TOTAL** | **220** | **38** | **258** | **0** | **19** |

⭐ **258 captured definitions == 220 declared FR + 38 declared BR.** The instrument's coverage
is exactly the declared register population, so a *"0 flagged"* verdict is not an artefact of
under-scanning. §17 records the four instrument corrections that were required to reach this.

### 6.2 The 19 definitions without a normative keyword — all legitimate

17 were classified mechanically as **PROHIBITION** (the obligation is carried by ⛔ plus
*"no"*/*"never"*/*"refused"*), **DELEGATION** (📤 — the rule belongs to a cited owner),
**MEASURED-ZERO** (the requirement records an absence) or **TABLE-CARRIED** (the modal sits in
a summary row). The 2 that resisted classification were **read**:

| Requirement | Site | Reading |
|---|---|---|
| `LDR-BR-002` | C6 **L273** | Interpretive scaffolding — *"`LDR-FR-002` and `LDR-FR-003` are **not new prohibitions**"*. The operative **MUST NOT** sits at C6 **L266** and **L269** |
| `LDR-BR-009` | C6 **L388** | A *"tempting counter-argument, recorded and rejected"*. Its operative prohibition is `LRR-FR-005` |

⭐ **Neither is untestable; both are commentary on requirements that are.**

---

## 7. Check 2 — every exclusion states what must be impossible ✅ PASS

### 7.1 Mechanical result

| Part | XC sites | Pure deferrals | Residual flags |
|---|---|---|---|
| C1 | 10 | **0** | 1 |
| C2 | 12 | **0** | 1 |
| C3 | 17 | **0** | 11 |
| C4 | 14 | **0** | 6 |
| C5 | 16 | **0** | 1 |
| C6 | 14 | **0** | 0 |
| C7 | 15 | **0** | 0 |
| C8 | 20 | **0** | 1 |
| **TOTAL** | **118** | **0** | **21** |

**All 118 exclusion definition sites were evaluated. Not one is phrased as a deferral.**

### 7.2 The 21 residual flags are instrument artefacts, resolved by reading

| Cause | Evidence | Parts |
|---|---|---|
| **Header-carried negation** — the negation lives in the column heading, invisible to a row-scoped scan | C3 **L755** and C4 **L406**: `\| ID \| C3 does **not** \| Authority \|` / `\| C4 does **not** \|`. C3 **L753** adds *"Each exclusion is a **boundary**, not a backlog item."* | C3, C4 |
| **Header-carried negation, second form** | C1 **L233**, C2 **L312**, C5 **L532**: `\| # \| Excluded \| Authority \|` | C1, C2, C5 |
| **Multi-line table row** — the ⛔ and the modal fall outside the scanned window | C1 `LMP-XC-001`, C1 `LMP-XC-005` | C1 |
| **Prose form** — C8's 20 exclusions are not table rows | C8 **L180**: `**\`LMT-XC-001\`** — ⛔ **No marketplace aggregate, entity, table or store is created.**` | C8 |

⭐ **Where a V2 feature is excluded, the exclusion states impossibility rather than schedule.**
C5 **L545**: *"⛔ **MUST NOT** display a verified-member…"* — not *"deferred to V2"*.

---

## 8. Check 3 — every configurable has a default and a range ✅ PASS (vacuously)

**`*-CFG-*` identifiers across C0–C8: 0.** No part of `PRD-021C` defines a configurable, so
the check has an empty subject and cannot fail. This is recorded as **vacuous PASS**, not as
strength.

Two requirements are configurable-*shaped*. Both are **delegations**, and both name the owner:

| Requirement | Site | Disposition |
|---|---|---|
| `LSB-FR-027` | C4 **L347** | Surfaces a lock timeout **owned by `BC-04`** and specified by `SEAT-FR-199` (FROZEN). C4 defines no value, default or range |
| `LMT-FR-019` | C8 **L450** | Mandates typed accessors over **`E-19`** (BC Map **L328**: *"no raw string lookups in domain code"*), and ⛔ *"No new configuration store or flag system"* |

⭐ **A delegated configurable is not an unbounded one.** The default and range exist in the
owning, frozen specification. Restating them here would have failed **Check 5**.

---

## 9. ⛔⛔ Check 4 — the Stage-4 BLOCKER

> *"Every acceptance criterion maps to a requirement | **Orphan criterion**"* — **L112**

### 9.1 Mechanical result

| Part | AC | Cite a requirement | **Orphaned** | AC form |
|---|---|---|---|---|
| **C1** | 12 | 1 | ⛔ **11** | GWT prose, no citation |
| **C2** | 16 | 1 | ⛔ **15** | GWT prose, no citation |
| **C3** | 22 | 1 | ⛔ **21** | GWT prose, no citation |
| **C4** | 18 | 1 | ⛔ **17** | GWT prose, no citation |
| C5 | 12 | **12** | ✅ 0 | `§9.0 Coverage map` table |
| C6 | 14 | **14** | ✅ 0 | Coverage map table |
| C7 | 13 | **13** | ✅ 0 | Coverage map table |
| C8 | 16 | **16** | ✅ 0 | Coverage map table |
| **TOTAL** | **123** | **59** | ⛔⛔ **64 (52%)** | — |

### 9.2 The failure is a **format** difference, not 64 unrelated defects

C5–C8 each open their acceptance section with an explicit coverage table. C5 **L563–L569**:

```
### §9.0 Coverage map — ⛔ no orphan requirement, ⛔ no orphan criterion

| Criterion | Exercises |
|---|---|
| `LRR-AC-001` | `LRR-FR-001`, `LRR-FR-002`, `LRR-XC-006` |
```

C1–C4 use uncited Given/When/Then blocks. C1 **L252–L256**:

```
`LMP-AC-001` — **Public surface requires no account**
> **Given** a client with no account, no session and no cookie
> **When** it requests the marketplace surface
> **Then** the surface returns successfully, and no authentication challenge is issued
```

⭐ **C1, C3 and C4 contain no coverage, "Exercises" or "maps to" section at all.** C1's §10 and
C4's §11 are *"Traceability to authority"* — they map **requirement groups to external
authorities** (`AR-1`, `LIB-DISC-001`, §14A.5), which is the **wrong direction and the wrong
subject** for this check. The gate asks whether a **criterion** points at a **requirement**.

### 9.3 The four criteria that do map, and why they are not evidence of coverage

| Criterion | Requirements cited |
|---|---|
| `LMP-AC-012` (C1 **L322**) | `LMP-FR-001`, `LMP-FR-007` |
| `LSD-AC-016` (C2 **L422**) | `LSD-FR-001`, `LSD-FR-009` |
| `LPP-AC-008` (C3 **L840**) | `LPP-FR-016` |
| `LSB-AC-018` (C4 **L539**) | `LSB-FR-001`, `LSB-FR-007` |

These four cite requirements **incidentally, inside their Then-clauses** — not through a
mapping construct. The pattern is 1 per part, at the end of each part's AC list.

### 9.4 Determination

| Field | Value |
|---|---|
| **Failed criterion** | Check 4 — *"Every acceptance criterion maps to a requirement"* |
| **Authoritative rule** | `PRD_LIFECYCLE.md` **L112**; stated failure mode *"Orphan criterion"* |
| **Affected parts** | **C1, C2, C3, C4** |
| **Affected identifiers** | `LMP-AC-001`…`011` · `LSD-AC-001`…`015` · `LPP-AC-001`…`007`, `009`…`022` · `LSB-AC-001`…`017` — **64 criteria** |
| **Unaffected** | **C5, C6, C7, C8** — 55 of 55 mapped ✅. **C0** holds no AC register |
| **Blocker** | ⛔ **YES.** 52% of criteria are orphans. The check's own failure mode is *"orphan criterion"*; this is that failure at scale |
| **Required owner** | **Product Owner** — the same owner as `PRD-020` `RQ-1` and `PRD-021A`'s Check-4 blocker, the same defect |
| **Required action** | Add an inline requirement citation to each of the 64 criterion rows, pointing at a **pre-existing** requirement. ⛔ **Mint nothing.** Where no requirement states the obligation, declare that criterion **UNMAPPED** with a reason and an owner — do **not** write the requirement |

### 9.5 ⭐ Why this record did not repair it

The repository has an established remedy for exactly this defect — a **separate mapping
instrument**, not a review that repairs its own subject:

- `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` exists to *"Close `RQ-1`, the sole failing check
  of the Stage 4 gate"*. It added 32 citations, minting **0** identifiers, citing
  `PRD-017_STAGE4_REQUIREMENTS_REVIEW` as its own precedent.
- `PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` did the same for A1–A8, repairing
  **233 of 233**, minting **0**.

⭐ **In both precedents the review recorded the FAIL, and a later, separately-authorised
instrument performed the repair.** `PRD-021A`'s review reported *"⛔⛔ FAIL — 211 of 232
(91%)"* and stated, at **L169**, *"Why I did not repair it"*. Three reasons apply identically
here:

1. **C1–C4 are established parts.** They were committed at `6ae3278`, aligned at Stage 3, and
   are byte-unchanged since. Editing them inside a review that is *measuring* them destroys
   the independence of the measurement.
2. **The repair is an owner's act.** `PRD-021A`'s own repair record was produced under a
   distinct mandate, and its result was adjudicated by a **separate conferral** artefact.
3. **The failure is disclosed, not hidden.** A reviewer who repairs the subject and then
   reports PASS has produced a record indistinguishable from one whose subject was already
   correct.

> ⛔ **Check 4 cannot be closed under L119 as an "explicit deferral".** L119 governs
> **conflicts**; Check 4 is a **check**, and the check matrix and the gate are separate
> instruments (§5). Reclassifying a failed check as a deferred conflict would be exactly the
> manufactured PASS this record is forbidden to produce.

---

## 10. Check 5 — no requirement restates another PRD's ✅ PASS

### 10.1 Foreign-stem **definitions**: 0

Every FR/BR/XC/AC definition site across C1–C8 was scanned for a definition minted into a
register that `PRD-021C` does not own. **Result: 0.** Each part defines only its own stem —
`LMP`, `LSD`, `LPP`, `LSB`, `LRR`, `LDR`, `LTS`, `LMT`.

### 10.2 Foreign-stem **references**: 110, all in citation position

| Stem | References | Owner |
|---|---|---|
| `SEAT-*` | 63 | `PRD-007` Seat Management (FROZEN) |
| `TSF-*` | 38 | `PRD-020` Trust & Safety |
| `LCF-*` | 5 | `PRD-021A` Library Community |
| `FIL-*` | 4 | `PRD-017` File & Media |

Sampled in context, every one sits in an **Authority** column, an exclusion's grounding, or a
delegation clause — never as a restated obligation. Representative sites:

- C4 **L408** — `LSB-XC-001`: *"Define `Booking`. It is defined at `PRD-SEAT-MANAGEMENT.md`
  **L153** and specified by `SEAT-FR-076`…`084`, all **FROZEN**"* — an explicit refusal to
  restate.
- C7 **L719** — `TSF-XC-034` invoked as **precedent** for a refusal, not as an adopted rule.

⭐ **Citation is the opposite of restatement.** The parts systematically name the owner instead
of duplicating the rule — `LMT-BR-001` (C8 **L124**) makes this a binding rule of the set:
*"C8 **SHALL NOT** convert an integration dependency into ownership… **SHALL** cite the owner's
identifier and **SHALL NOT** restate that capability's rules as its own."* `LTS-BR-001` and
`LDR-BR-001` state the same in C7 and C6.

---

## 11. Check 6 — business rules do not contradict Rank 1 ✅ PASS

### 11.1 Subject

**38 business rules** — C5 8 · C6 9 · C7 9 · C8 12. C1–C4 declare **0** BR.

### 11.2 Result

**0 contradictions of `MASTER_PRD.md` (Rank 1).** Every one of the 38 is a **prohibition**, a
**delegation** (📤) or a **recorded refusal**. Not one asserts an ownership, an aggregate or a
context that Rank 1 assigns elsewhere.

The load-bearing rule quotes Rank 1 directly. C8 **L171–L174**, `LMT-BR-002`:

> The marketplace is a **read-composition over contexts that already own their data**.
> `MASTER_PRD.md` **L171**:
> `| 19 | Library Discovery & Enrollment | Composition over BC-19, BC-25, BC-29, BC-06, BC-02, BC-04, projected via BC-23 | *not a context* | V1 |`

### 11.3 The 15 ownership-claim-shaped lines, read

An instrument flagged 15 lines matching *"owns the"*, *"is a context"* and similar (C3 11,
C6 3, C5 1). **All 15 attribute ownership elsewhere or are prohibitions:**

- C3 **L12** — *"…`BC-04` Seating. **C3 owns the COMPOSITION only**."*
- C3 **L25** — *"`BC-26` Analytics Read Model — **owns** the metric/semantic layer"* — naming
  the correct Rank-1/Rank-4 owner.
- C6 **L17**, **L80**, **L713** — *"**C2** already owns the ordering surface"* — the measured
  reason C6 does **not** build a second one.
- C5 **L115** — *"authorising C5–C8 **forbids both** — ⛔ do NOT create a new bounded context"*.

⭐ **Naming an owner is the discharge of Check 6, not a breach of it.**

---

## 12. The L119 gate ✅ SATISFIED

| Open item | Reason recorded | Owner named |
|---|---|---|
| `XPC-OD-004` | *"Nothing in V1 — C4 excludes offline booking"* | **Architecture Owner** |
| `XPC-OD-005` | *"Nothing in V1 — V1 excludes the feature"* | **Privacy Owner** *(role constituted by `ADR-0077`; ⚠ holder VACANT — disclosed)* |
| `XPC-OD-006` | *"Nothing — precedence resolves it (`XPC-CONF-014`)"* | **Architecture Owner** |
| `XPC-OD-008` | Reviews & Ratings tiering; `Library_PRD_v1.md` **L1016** tiers at **V2** (FROZEN) | **Product Owner** with **Architecture Owner** |
| `XPC-OD-009` | `BC-23` keyword-stuffing defence unspecified | **Architecture Owner** with **`BC-23` owner** |
| `XPC-OD-010` | No repository owner exists for bot/scraping defence | **Architecture Owner** with **Security** reviewer |

**6 open decisions · 0 without a reason · 0 without an owner.** Gate **SATISFIED**.

⚠ `XPC-OD-005`'s owner **role** is named but its **holder is vacant**. This is disclosed, not
smoothed: the gate requires an owner, and `ADR-0077` constitutes one. Filling the seat is a
governance act outside this record.

---

## 13. Stage-3 invariant preservation

Every aligned decision from `40b52b2` was re-measured and is **unchanged**.

| Invariant | Measured | Result |
|---|---|---|
| Ownership boundaries | 0 ownership claims added; `LMT-BR-001`/`LTS-BR-001`/`LDR-BR-001` intact | ✅ |
| Dependency rules · authorised edges | 29 edges; `E-27` vacant; BC Map **L292** honoured | ✅ |
| BC boundaries | Context count **31**; **0** `BC-32` | ✅ |
| Event rules | **0** new events; BC Map §9 untouched | ✅ |
| Analytics ownership | `BC-26` sole authority; `UniqueViewers` **NOT CERTIFIED**; `CertifiedMetric` **reused**, not extended; C3 Profile Views intact | ✅ |
| Ranking ownership | `BC-23` intact; `LSD-XC-002` cited **8×** in C6; **0** second ranking system; **0** rating-based ranking. C6 **L266**/**L269** ⛔ **MUST NOT** re-order/re-rank | ✅ |
| Moderation / safety ownership | `BC-13` intact; `X-05` honoured; `LTS-BR-003` — *"No case/report/strike/ban is held by C7"* | ✅ |
| Booking / seat / membership ownership | `BC-04` / `BC-02` intact; C4's 14 exclusions refuse to define `Booking` or `Reservation` | ✅ |
| Library isolation · tenant scoping | `LTS-BR-006`, `LMT-BR-008` (`E-18` ambient tenant context) intact | ✅ |
| Authz ownership | `X-13` intact; `LMP-XC-007` ⛔ *"MUST NOT decide authorisation"* | ✅ |
| Lifecycle semantics | Stage 3 = ALIGNED; Stage 4 attempted and **BLOCKED**; nothing beyond | ✅ |

### 13.1 C5 — Reviews & Ratings remains **V2, not V1-authorised** ✅

`Library_PRD_v1.md` **L1016** (**FROZEN**, **Rank 3**) tiers the feature at **V2**;
`ARCHITECTURE_RULINGS.md` **L291** records *"Deferred — V2"* under *"do not invent"*. C5
preserves this: **0** star ratings, **0** written reviews, **0** verified-member indicators,
**0** review moderation, **0** spam protection are authorised. C5 **L545** — ⛔ *"**MUST NOT**
display a verified-member…"*; `LMP-XC-009` (C1) — ⛔ *"MUST NOT create a rating, review, star,
score or ranking-of-libraries entity"*.

### 13.2 C7 and C8 boundaries ✅

C7 preserves `BC-13` ownership, `X-05`, and the lawful app-shell route
(`tool/module_dependencies.yaml` **L507**/**L509**); **`TSF-GAP-009` remains OPEN**. C8 invents
**no** infrastructure, bounded context, event, analytics, ranking, safety or booking
ownership — `LMT-XC-001` (**L180**): *"⛔ **No marketplace aggregate, entity, table or store is
created.** The composition holds **nothing**; it reads."*

---

## 14. Open decisions and inherited gaps

| Item | Status before | Status after | Action taken |
|---|---|---|---|
| `XPC-OD-004`, `005`, `006`, `008`, `009`, `010` | **OPEN** | ⛔ **OPEN, unchanged** | None. ⛔ 0 resolved |
| `TSF-GAP-009` | **OPEN** (inherited) | ⛔ **OPEN, unchanged** | ⛔ **Not re-minted.** Blocks the pre-existing `IMPL-1424` reference — *a pre-existing task reference, **not** created here* |
| `GAP-BCMAP-BC26-EDGES` | **OPEN** (inherited) | ⛔ **OPEN, unchanged** | ⛔ **Not re-minted** |

⛔ **No new gap identifier was minted by this review.** Findings are recorded in §16 as
findings, not as register entries.

---

## 15. Identifier, edge, context, event and ADR status

| Dimension | Baseline | Measured now | Delta |
|---|---|---|---|
| Identifiers (C0–C8) | 528 | **528** | **0** |
| Duplicate identifiers | 0 | **0** | 0 |
| Silent renumbering | — | **0** — every register contiguous from `001` | 0 |
| `XPC-OD` register | 10 (unused slot **011** must not be minted) | **10**; slot **011** **absent** ✅ | 0 |
| `LDR-FR` register | 22 (unused slot **023**) | **22**, contiguous ✅ | 0 |
| `LMT-FR` register | 26 (unused slot **027**) | **26**, contiguous ✅ | 0 |
| Reservation-token rendering | — | ⛔ **0** in this record — see the note below | 0 |
| Integration edges | 29 — `E-01`…`E-26`, `E-28`, `E-29`, `E-30` | **29** ✅ | 0 |
| `E-27` | Permanently vacant | ⛔ **Vacant** — 0 table rows ✅ | 0 |
| `E-31` | Unminted | ⛔ **Unminted** — 0 occurrences ✅ | 0 |
| Bounded contexts | 31 | **31**; `BC-32` **0** occurrences ✅ | 0 |
| Domain events | — | **0** new ✅ | 0 |
| ADRs | 85 | **85** ✅ | 0 |
| `ADR-0088` / `ADR-0089` / `ADR-0090` | Unwritten | ⛔ **Unwritten** — 0 files each ✅ | 0 |
| `IMPL-*` for 021C | 0 | **0** ✅ | 0 |

> ⭐ **Why the three unused register slots above are named by number and not spelled in full.**
> A `\b`-delimited identifier is greppable **regardless of the prose around it**. A record that
> spells an unminted slot while asserting it is unused causes every census whose glob matches
> that record's filename to count the slot as **minted** — the tail of the register appears to
> extend by one. This filename matches `PRD-021C_C[0-8]_*.md`. The defect has been observed
> **five** times in this engagement, twice inside review records asserting the opposite. It is
> avoided here by construction: **the slots are cited as numbers only, never as tokens.**
> Verified after writing — see §21.4.

⭐ **ADRs are counted with `git ls-files`, not `ls ADR-*.md`.** That glob captures
`ADR-INDEX.md` and returns a false **86**. Git truth: **85** at `6ae3278`, **85** now, **0**
changed.

---

## 16. Findings

### 16.1 Findings ACCEPTED

| # | Finding | Disposition |
|---|---|---|
| **S4-A-1** | ⛔⛔ **64 of 123 acceptance criteria in C1–C4 cite no requirement.** Check 4 fails | **BLOCKER.** Routed to the **Product Owner**. ⛔ Not repaired here — §9.5 |
| **S4-A-2** | C1, C3 and C4 contain **no** coverage/"Exercises" section; their §10/§11 map requirement **groups to authorities**, which is the inverse subject | Recorded as the **structural cause** of S4-A-1, not as a separate defect |
| **S4-A-3** | `XPC-OD-005`'s owner **role** exists (`ADR-0077`) but its **holder is VACANT** | Disclosed. Gate still satisfied — L119 requires an owner, and one is named |
| **S4-A-4** | The **Requirements reviewer** role (**L278**) has **no named holder** — `PGA-08` | ⛔ **Conferral withheld.** §19 |
| **S4-A-5** | ⚠ `LDR-FR-` slot **023** renders as a formed token at **C0 L128** and **C0 L576**, inside C0's own prose disclosing the defect | ⚠ **Carried, NOT repaired** (pre-existing at `6ae3278`; C6's own register measures 22 FR contiguous; C0 owns no `LDR-*`). Routed to the **Architecture Owner** |

### 16.2 Findings REJECTED — with reasons

`PRD_LIFECYCLE.md` **L104–L106**: *"A review that records only accepted findings is
indistinguishable from a review that found nothing."*

| # | Apparent finding | Why REJECTED |
|---|---|---|
| **S4-R-1** | *"60 of 258 requirements are untestable"* | ⛔ **Instrument defect.** The first Check-1 regex assumed table rows; requirements are prose blocks (`` `ID` — text ``), and C7/C8 bold the identifier. A *"0 flagged"* verdict at 23% coverage would have been a **false PASS**. Corrected to 258 |
| **S4-R-2** | *"318 requirement definitions exist against 258 declared"* | ⛔ **Instrument over-correction.** The second pass counted citation and summary tables (C1 **L334**, C3 **L968**, C7 **L469**) as definitions. Excluding `\|`-prefixed rows yields exactly **258** |
| **S4-R-3** | *"C3's entire exclusion block fails Check 2"* | ⛔ **Header-carried negation.** The impossibility lives in the column heading `\| ID \| C3 does **not** \| Authority \|` (**L755**), invisible to a row-scoped scan. Same at C4 **L406** |
| **S4-R-4** | *"C1/C2/C5 exclusions state no impossibility"* | ⛔ Same cause, second form — `\| # \| Excluded \| Authority \|` (C1 **L233**, C2 **L312**, C5 **L532**) |
| **S4-R-5** | *"C8 declares 0 exclusions"* | ⛔ **Form difference.** C8's 20 exclusions are **prose**, not table rows (**L180**). Table-row counts alone give 118 − 20 = 98, understating the subject |
| **S4-R-6** | *"19 requirements carry no normative obligation"* | ⛔ **17 auto-classified** as prohibition/delegation/measured-zero/table-carried; the remaining 2 **read** as commentary on requirements that do carry **MUST NOT** (§6.2) |
| **S4-R-7** | *"15 lines claim ownership, contradicting Rank 1"* | ⛔ **Read, not counted.** All 15 attribute ownership **elsewhere** or are prohibitions (§11.3) |
| **S4-R-8** | *"110 cross-PRD references are restatements — Check 5 fails"* | ⛔ **Citation ≠ restatement.** 0 foreign-stem **definitions**; all 110 sit in authority/delegation position, and `LMT-BR-001` makes non-restatement a binding rule (§10) |
| **S4-R-9** | *"The BC Map declares 0 integration edges"* | ⛔ **Instrument defect.** §7 edge rows are **unbackticked** (`\| E-01 \| BC-01 …`). A backtick-requiring regex returns 0. Correct count: 26 in §7 + `E-28`, `E-29` (§15.1) + `E-30` (§17) = **29** |
| **S4-R-10** | *"`E-27` exists — 30 distinct `E-nn` identifiers are present"* | ⛔ **Naming a rule to obey it is not breaking it.** All 17 `E-27` occurrences declare its vacancy — **L648**: *"⛔ `E-27` IS NOT REUSED AND IS PERMANENTLY VACANT"*; **L652**: *"A reader who finds no `E-27` has found the correct state."* **0** table rows |
| **S4-R-11** | *"All six open decisions lack owners"* | ⛔ **Instrument defect** — the row regex required `**`-wrapped identifiers, which C0's §6 does not use. Read directly: **6 of 6** carry a reason and an owner (§12) |
| **S4-R-12** | *"86 ADRs exist against a baseline of 85 — one was added"* | ⛔ **Glob artefact.** `ls ADR-*.md` captures `ADR-INDEX.md`. Git truth: **85** then, **85** now, **0** changed |
| **S4-R-13** | *"C5–C8 line counts are 727/756/720/779, not 726/755/719/778"* | ⛔ **Convention artefact.** Python `split('\n')` counts the trailing newline; `wc -l` does not. `wc -l` is the repository's figure |

⭐ **Nine of the thirteen rejected findings were produced by my own instruments.** Each was
dismissed by **reading the source**, not by re-running until the number agreed. A reviewer who
reaches a verdict by re-running an instrument until it cooperates has reviewed nothing.

---

## 17. Instrument defects disclosed

| # | Instrument | Defect | Effect if undetected |
|---|---|---|---|
| **I-1** | Check 1 requirement extractor | Assumed table rows; missed prose definitions and bolded identifiers | **False PASS** at 23% coverage |
| **I-2** | Check 1, second revision | Counted citation/summary tables as definitions | Inflated the subject to 318 |
| **I-3** | Check 2 exclusion scanner | Row-scoped; blind to header-carried negation and prose-form exclusions | 21 false failures |
| **I-4** | Check 4 AC scanner | Format-agnostic; would have reported the C1–C4 gap as 64 unrelated defects rather than one structural cause | Misattributed a single defect as 64 |
| **I-5** | Edge counter | Required backticks the BC Map's §7 does not use | **0** edges — would have contradicted a verified invariant |
| **I-6** | Open-decision scanner | Required `**`-wrapping absent from C0 §6 | **0** owners — a false gate FAIL |
| **I-7** | ADR counter | `ls ADR-*.md` captures `ADR-INDEX.md` | False +1 ADR |

⭐ **Every instrument defect made the subject look either worse or better than it is; both
directions are disclosed.** I-1 and I-7 flattered or falsely accused; I-3, I-5 and I-6
produced false failures. None was resolved by adjusting the subject.

---

## 18. Repository defects carried, not repaired

| Defect | Why not repaired |
|---|---|
| `LDR-FR-` slot **023** renders as a token at C0 **L128**/**L576** (S4-A-5) | Pre-existing and committed at `6ae3278`. Repairing it would edit a **settled cross-part authority** to flatter a checker. Routed to the **Architecture Owner** |
| The 6 pre-existing doc-check failures (§21) | ⛔ *"Do not modify validators or fixtures to manufacture PASS."* Unrelated to `PRD-021C` |
| `PGA-08` — no PRD has a named owner | A governance act, not a review's |

⛔ **No unrelated pre-existing defect was cleaned up.**

---

## 19. Determination

### 19.1 Two independent bars, either sufficient

| Bar | Status |
|---|---|
| **Evidence** — the six checks | ⛔ **NOT MET.** Check 4 fails on 64 of 123 criteria (§9) |
| **Authority** — conferral of Stage 4 | ⛔ **NOT MET.** The **Requirements reviewer** role (**L278**) has no named holder — `PGA-08`; no conferral was granted for this work |

> ### ⛔⛔ **DETERMINATION: STAGE 4 IS NOT PASSED AND NOT CONFERRED.**
>
> **`STAGE-4 EVIDENCE — BLOCKED AT CHECK 4; CONFERRAL WITHHELD.`**

- **Stage-3 conferral does not imply Stage-4 authority** (`PRD-008_STAGE4_CONFERRAL.md`).
- `PRD_LIFECYCLE.md` **L272**: *"Roles, not people — the repository names no individuals, and
  this document does not invent any."* This record invents none.
- ⭐ **A complete evidence set does not confer a stage — and this evidence set is not complete.**
  Precedent `PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` §11: *"That is **evidence**,
  not authority."* Here, both are absent.

### 19.2 What this record does **NOT** confer

| Claim | Status |
|---|---|
| **Stage 4 passed** | ⛔ **NO** — 5 of 6; Check 4 fails |
| **Stage 4 conferred** | ⛔ **NO** — no authority exists |
| **Stage 5 (Traceability)** | ⛔ **NOT ENTERED** — 0 prefixes registered in `TRACEABILITY_MATRIX.md` |
| **Stage 6 (Implementation Tasks)** | ⛔ **NOT ENTERED** — **0** `IMPL-*` allocated |
| **Stage 7 (Freeze)** | ⛔ **NOT DONE** — 0 rows in `DOCUMENTATION_BASELINE.md` §3 |
| **Stage 8 (Implementation)** | ⛔ **NONE** — 0 lines of application code |
| **Stage 9 (Verification)** | ⛔ **NONE** — **0 of 123** acceptance criteria proven by a test |
| **`APPROVED`** | ⛔ **NO** — first available at Stage 5 |
| **`FROZEN` / `BASELINED`** | ⛔ **NO** — Rank 3 admission ⛔ **NOT CONFERRED** |
| **Rank admission** | ⛔ **NONE.** This record is **unranked** |
| Closure of any open decision | ⛔ **NONE** — 6 remain OPEN |
| Any new ADR | ⛔ **NONE** — 85 before, 85 after |
| Any new bounded context, edge or event | ⛔ **NONE** |
| Any C0–C8 subject byte changed | ⛔ **NONE** — nine hashes identical (§4, §21) |

⭐ **ALIGNED / STAGE 3 ≠ STAGE 4 ≠ IMPLEMENTED ≠ APPROVED ≠ FROZEN ≠ BASELINED.**
C0–C8 stand exactly where `40b52b2` left them: **ALIGNED at Stage 3**, `DRAFT`, unranked.

### 19.3 Path forward — the smallest lawful sequence

1. **Product Owner** adds requirement citations to the 64 C1–C4 criterion rows, minting **0**
   identifiers, via a separate mapping instrument on the `PRD-020` / `PRD-021A` pattern.
2. Check 4 re-measured to **123 of 123**.
3. **Requirements reviewer** authority conferred by a named holder, curing `PGA-08` for that
   act, and Stage 4 conferred **or withheld** on the re-measured evidence.

⛔ **Steps 1–3 are not performed by this record.** Steps 2 and 3 are impossible until step 1
is done by its owner.

---

## 20. Files

### 20.1 Files changed by this review

| File | Change |
|---|---|
| `docs/30-product/library-marketplace/PRD-021C_C0_C8_STAGE4_REQUIREMENTS_REVIEW.md` | **Created** — this record |

**Total: 1 file created, 0 modified, 0 deleted.**

### 20.2 Files explicitly **NOT** changed

⛔ C0, C1, C2, C3, C4, C5, C6, C7, C8 — all nine byte-unchanged, hashes verified before and
after · ⛔ `PRD-021C_C0_C8_STAGE3_ARCHITECTURE_ALIGNMENT.md` · ⛔ `MASTER_PRD.md` (Rank 1) ·
⛔ `LIBOORA_BOUNDED_CONTEXT_MAP.md`, `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`,
`ARCHITECTURE_RULINGS.md` (Rank 4) · ⛔ `Library_PRD_v1.md` and every FROZEN PRD (Rank 3) ·
⛔ `PRD_REGISTRY.md`, `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, `TRACEABILITY_MATRIX.md`
· ⛔ all **85** ADRs · ⛔ `tool/module_dependencies.yaml` · ⛔ every `tool/docs_check/*.py`
validator and fixture · ⛔ `docs/40-implementation/` · ⛔ all unrelated PRDs ·
⛔ **`lib/`, `test/`, `web/`, `android/`, `ios/`, `.github/` — 0 files, 0 lines.**

---

## 21. Verification record

### 21.1 Doc-check suite

```
TOTAL=31 PASS=25 FAIL=6
FAILING: alignment_record_freshness.py prd004_traceability.py prd005_traceability.py
         prd006_traceability.py prd007_traceability.py prd020_stage5.py
```

**Identical to the baseline: 31/25/6, the same six scripts. 0 new failures, 0 regressions.**
All six are **pre-existing** and unrelated to `PRD-021C`. ⛔ **No validator or fixture was
modified.**

⚠ `alignment_record_freshness.py` enumerates only the `PRD-008` and `PRD-019` record chains, so
this record neither satisfies nor worsens it. Its docstring: *"A stale review is corrected by a
dated re-run beside it, not by editing what it concluded."*

### 21.2 Subject integrity

Nine sha256 values re-computed after writing this record: **all identical to §4 and to the
Stage-3 record's §1.** ⛔ 0 subject bytes changed.

### 21.3 Structural invariants

528 identifiers ✅ · every register contiguous ✅ · 29 edges ✅ · `E-27` vacant ✅ · `E-31`
unminted ✅ · 31 contexts, `BC-32` absent ✅ · 0 new events ✅ · 85 ADRs ✅ · `ADR-0088`,
`ADR-0089`, `ADR-0090` unwritten ✅ · 0 `IMPL-*` ✅ · 0 `*-CFG-*` ✅.

### 21.4 Register-tail extension guard

This filename matches the `PRD-021C_C[0-8]_*.md` census glob. Every identifier family
referenced by this record was cross-checked against the nine subjects' own registers to confirm
that **no family's tail is extended by this record's prose**. Guard result: **CLEAN**.

### 21.5 False-claim guard

Scanned for `STAGE 4 PASS`, `CONFERRED`, `APPROVED`, `FROZEN`, `BASELINED`,
`implementation complete`. Every occurrence is inside a ⛔ prohibition, a *"does NOT"* list, or
a citation of another document's status.

---

## 22. Change history

| Version | Date | Change | Lifecycle effect |
|---|---|---|---|
| **v1.0** | 2026-09-03 | Consolidated Stage-4 requirements review of `PRD-021C` **C0–C8** at base commit `40b52b2`. Stage-4 semantics first determined from `PRD_LIFECYCLE.md` **L108–L119** — **Requirements Review**, ⛔ **not** implementation. Six checks re-derived over 528 identifiers: **PASS 1, 2, 3, 5, 6**; ⛔⛔ **FAIL Check 4** on 64 of 123 acceptance criteria (C1–C4). Gate **L119 SATISFIED** — 6 open decisions, 0 without a reason or owner. 5 findings accepted, **13 rejected with reasons**, **7 instrument defects** and **3 carried repository defects** disclosed. 0 identifiers minted · 0 subject bytes changed · 0 edges · 0 events · 0 contexts · 0 ADRs · 0 `IMPL-*` · 0 lines of code | ⛔ **STAGE 4 NOT PASSED, NOT CONFERRED.** C0–C8 remain **ALIGNED / Stage 3**, `DRAFT`, unranked. ⛔ Not approved, not frozen, not baselined, not implemented, not verified |
