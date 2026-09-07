# `PRD-015` — **Stage 4 Requirements Review**

| Field | Value |
|---|---|
| **Document** | Stage-4 requirements-review **measurement** record for `PRD-015 Search Indexing` (`BC-23`) |
| **Version** | v1.0 |
| **Date** | 2026-09-05 |
| **Subject** | `PRD-015_SEARCH_INDEXING.md` — hash `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544`, **byte-unchanged by this review** |
| **Entered because** | ⭐ Stage 3 is **CONFERRED** at 16/16 — `PRD-015_STAGE3_CONFERRAL.md` §7 |
| **Result** | ⭐⭐ **All six Stage-4 checks PASS, mechanically measured.** ⛔ **0 requirements created, removed, merged or reworded** |
| **Verdict** | ⚠⚠ **MEASURED PASS — STAGE 4 *NOT* CONFERRED** |
| **Why not conferred** | ⛔⛔ **Conferral belongs to the *Requirements Reviewer* (`PRD_LIFECYCLE.md` §6 **L278**), and no conferral of that role for `PRD-015` exists.** Measured: the role occurs **0** times in `PRD_OWNERSHIP_MODEL.md`. See §6 — the `PRD-008` precedent |
| **Baseline** | ⛔ **No baseline re-issue.** `BASELINE-2026-09-03-A` stands |

---

## 1. Authority to enter Stage 4, and the limit of this record

⭐ `PRD_LIFECYCLE.md` §11 makes the stages sequential and Stage 7 non-skippable. Stage 4 is entered
**because and only because** Stage 3 is conferred.

| ⭐ What this record does | ⛔ What it does NOT do |
|---|---|
| Measures all six Stage-4 checks mechanically | ⛔ Does not confer Stage 4 |
| Publishes its instrument, its defects and its counts | ⛔ Does not create, remove, merge or reword any requirement |
| Names every OPEN / DEFER item and keeps it separate | ⛔ Does not convert a DEFER or OPEN item into a requirement |
| — | ⛔ Does not enter Stage 5, 6 or 7 |
| — | ⛔ Does not amend the subject, any frozen document, or any Rank 1–5 artefact |

⛔ **No conferral from `ADR-0102`, `ADR-0103` or `ADR-0104` is used here.** Each was scoped to one
act; ⭐ `ADR-0104`'s reviewer scope is *"`PRD-015` **Stage-3** review and conferral act, and nothing
else"*, which ⛔ **excludes Stage 4 expressly**. `ADR-0033` §7.1 — *"a conferral for one act is not a
standing licence."*

---

## 2. ⚠⚠ THE INSTRUMENT — AND THE TWO DEFECTS IT FOUND IN ITSELF

⭐⭐ **Recorded first, because a count produced by a broken instrument is worse than no count.**

### 2.1 Defect 1 — a truncated-number match reported phantom duplicates

The first census matched `` ^`SRCH-FR-(\d+)` `` and reported **duplicates at `FR-4`, `FR-12`,
`BR-1`, `INV-1/3/4/5`, `XC-16`** — and a register total of **45 FR** against a stated 42.

⛔ **The duplicates did not exist.** A probe for `` ^`SRCH-FR-4` `` returned **0 hits**, which is what
exposed it: the identifiers are written `SRCH-FR-042`, and the capture group was reading a
**prefix** of the number. ⭐ **The absurdity of a 0-hit "duplicate" is what caught it**; a plausible
result would have been believed.

### 2.2 Defect 2 — line-start matching counted CROSS-REFERENCES as definitions

Re-run with line numbers, three genuine collisions remained. Inspection of each site showed they are
**prose citations**, not second definitions:

| Site | Text | Verdict |
|---|---|---|
| **L298** | `` `SRCH-FR-004` — `BC-23` **MUST** populate every index from events on `E-21` only… `` | ⭐ **DEFINITION** |
| **L779** | `` `SRCH-FR-004` (events only) and `SRCH-INV-005` (rebuildable…) are operative. `` | ⛔ **CITATION** |
| **L206** | `` `SRCH-INV-001` — `BC-23` holds **no** source of truth… `` | ⭐ **DEFINITION** |
| **L667** | `` `SRCH-INV-001` (§5.2) established that `BC-23` holds no source of truth… `` | ⛔ **CITATION** |

⭐ **The distinguishing feature is the em-dash separator**, which every definition in this document
uses and no citation does. The corrected instrument requires it.

⚠ **`SRCH-INV-005` needed one further pass**: **L358** is the definition, **L798** a restatement
inside §21's prose that *also* uses an em-dash. It was resolved by **reading both sites**, not by
regex. ⭐ **This is why the census is published with its method: two of three instrument revisions
were driven by an answer that looked wrong.**

### 2.3 The corrected census

| Register | Definitions | Unique | Max | Contiguous from 001 | Duplicates |
|---|---|---|---|---|---|
| `SRCH-FR-*` | **42** | 42 | 042 | ✅ | ⛔ **0** |
| `SRCH-BR-*` | **14** | 14 | 014 | ✅ | ⛔ **0** |
| `SRCH-INV-*` | **6** | 6 | 006 | ✅ | ⛔ **0** |
| `SRCH-XC-*` | **16** | 16 | 016 | ✅ | ⛔ **0** |
| `SRCH-AC-*` | **78** | 78 | 078 | ✅ | ⛔ **0** |
| `SRCH-EVT-*` | **0** | — | — | — | ⭐ **EMPTY — see §4.4** |
| `SRCH-CFG-*` | **0** | — | — | — | ⭐ **EMPTY — see §4.3** |
| `SRCH-GAP-*` | **9** | 9 | 009 | ✅ | ⛔ **0** |

⭐ **Obligation-bearing total: 42 + 14 + 6 + 16 = 78.** ⭐ **Acceptance criteria: 78.**

---

## 3. ⭐⭐⭐ THE SIX STAGE-4 CHECKS

`PRD_LIFECYCLE.md` **L108-119** defines exactly six checks. Each is measured, not asserted.

| # | Check | Failure mode named by the lifecycle | Result |
|---|---|---|---|
| 1 | Every requirement **testable** | *"The system should be fast"* — unverifiable | ✅ **PASS** — §4.1 |
| 2 | Every exclusion states what must be **impossible** | *"An exclusion is not a deferral"* | ✅ **PASS** — §4.2 |
| 3 | Every **configurable** has a default and a range | *"Unbounded configuration is a specification hole"* | ✅ **PASS — vacuously** — §4.3 |
| 4 | Every **acceptance criterion maps to a requirement** | *"Orphan criterion"* | ✅ **PASS** — §4.5 |
| 5 | **No requirement restates another PRD's** | *"Two sources of truth"* | ✅ **PASS** — §4.6 |
| 6 | Business rules do not contradict **Rank 1** | *"Rank 1 wins; the PRD is wrong"* | ✅ **PASS** — §4.7 |

### ⭐ **6 of 6 PASS.**

⛔ **And the gate is not thereby satisfied**, because the lifecycle's Stage-4 gate has a second
element — *"conflicts closed or explicitly deferred **with a reason and an owner**"* (§5) — and a
**conferral** (§6).

---

## 4. The checks, measured

### 4.1 Check 1 — testability

⭐ Every one of the **78** obligation-bearing identifiers carries **exactly one** `SRCH-AC-*` in
**Given / When / Then** form, measured at **78 / 78**. A requirement with a GWT criterion is
testable by construction: the criterion states the observable.

⛔ **0** obligations were found in the unverifiable form the lifecycle names.

### 4.2 Check 2 — exclusions state impossibility

All **16** `SRCH-XC-*` were read. Each is framed as a prohibition on `BC-23`, not a postponement.
Two representative:

- `SRCH-XC-001` — *"`BC-23` **MUST NOT** define, alter or restate any §14A field, eligibility rule or visibility rule."*
- `SRCH-XC-016` — *"⛔ `BC-23` **MUST NOT** allow a never-public value to be **inferred** from search behaviour."*

⭐ **Neither defers anything to a later version**; both state what must be impossible. ⛔ **0
exclusions were found to be disguised deferrals.**

### 4.3 Check 3 — configurables

⭐ **`SRCH-CFG-*` is EMPTY — 0 members — and the check passes VACUOUSLY, which is recorded as such
rather than as a pass on the merits.**

⚠ **Emptiness is verified real, not merely described:** `grep -cE 'SRCH-CFG-[0-9]'` → **0**. And it
is **correct** rather than an oversight: `ADR-0017` gives `BC-25` ownership of configuration
parameters, and `ADR-0099` §2.4 records that `LCFG-6` and `LCFG-12` are *"the shape `BC-25` carriage
actually takes for `BC-23`"* — i.e. `BC-23`'s configurables live in **another owner's register by
design**. ⭐ The `PRD-023` precedent is exact: that PRD *"owns configuration and owns no
configurable."*

⛔ **No `SRCH-CFG-*` identifier is minted by this review.**

### 4.4 ⭐ `SRCH-EVT-*` is EMPTY, and that is a finding worth stating

`grep -cE 'SRCH-EVT-[0-9]'` → **0**. ⭐ **Correct by construction:** `SRCH-FR-004` requires `BC-23`
to populate every index *"from events on `E-21` only"*, and `SRCH-INV-001` holds that `BC-23`
*"holds **no** source of truth."* A context that is purely a **projection consumer** publishes no
domain event. ⛔ **No event is invented to fill the register.**

### 4.5 Check 4 — acceptance-criterion mapping · ⭐⭐ measured 1:1, both directions

⭐ **This is the strongest result in the review, and it was computed both ways rather than once.**

| Measurement | Result |
|---|---|
| `SRCH-AC-*` definitions | **78**, unique, contiguous `001`–`078` |
| Distinct obligations cited in AC `Verifies` cells | **78** |
| Obligation universe (`FR`+`BR`+`INV`+`XC`) | **78** |
| ⛔ **UNCOVERED obligations** (an obligation with no AC) | ⭐ **0** |
| ⛔ **ORPHAN AC citations** (an AC citing a non-existent obligation) | ⭐ **0** |
| ⭐ **Coverage** | ⭐⭐ **78 / 78 = 100.0 %** |

⭐⭐ **The PRD's own claim at L997 — *"Every one of the 78 obligation-bearing identifiers has exactly
one acceptance criterion"* — is INDEPENDENTLY CONFIRMED, not accepted.** The census was derived from
the document's identifier definitions and the mapping from its `Verifies` parentheticals, then
cross-checked in the reverse direction.

⚠⚠ **What 100 % coverage does NOT mean, stated plainly.** It means **every obligation has a
criterion**. It does ⛔ **NOT** mean any criterion is **satisfied**: **0 of 78** are proven by a
passing test, because no implementation exists. ⭐ `SID-4.56`: *"a rule that cannot be checked SHALL
be treated as unmet."* Verification is Stage 5+, and this review claims none of it.

### 4.6 Check 5 — no requirement restates another PRD's

⭐ Measured: definitions of foreign identifier prefixes (`LIB-`, `TEN-`, `SEAT-`, `ATT-`, `MM-`,
`ENT-`, `AUD-`, `CNF-`) inside the subject → ⭐ **0**.

⭐⭐ **And the architecture check that matters is stronger than the lexical one:** `SRCH-XC-001`
**forbids** `BC-23` from restating any §14A field or rule, `SRCH-FR-017` makes eligibility a
**reference** to §14A.4/§14A.5 rather than a copy, and `AR-1`'s *"Discovery **references**, never
duplicates"* is the governing ruling. ⇒ The single-source-of-truth property is **specified**, not
merely absent-by-luck.

### 4.7 Check 6 — business rules vs Rank 1

All **14** `SRCH-BR-*` were read against `MASTER_PRD.md`. ⛔ **0 contradictions.** Three alignments
worth recording:

| `SRCH-BR-*` | Rank 1 counterpart | Relation |
|---|---|---|
| `SRCH-BR-008` — normalization *"symmetric and total"* | `MP-CON-01` / `MP-CON-03` (vendor-neutral) | ⭐ consistent — the rule is engine-independent |
| `SRCH-BR-014` — *"exactly one ordering: relevance"* | `MP-GBR-08` tenant partitioning | ⭐ consistent — no cross-tenant ranking signal |
| `SRCH-BR-011` — no learned model | `MP-NFR-03` single ownership | ⭐ consistent |

⭐ **`MP-NFR-01`'s availability obligation is now satisfied for `BC-23`** at `99.9% monthly`
(`ADR-0102` §3.2), which removes the one Rank-1 obligation that previously had no `PRD-015`-side
answer.

---

## 5. ⭐ The gate's SECOND element — *"conflicts closed or explicitly deferred with a reason and an owner"*

⭐⭐ **Every open item carries both a reason and a named owner. Measured, item by item — and ⛔ none
is converted into a requirement.**

| # | Item | Reason it is open | ⭐ Owner |
|---|---|---|---|
| 1 | `SRCHPO-A11` — script-**selection** mechanism | Rule-set content; `ADR-0099` §2.3 routes it, evidence-bound | **Architecture Owner** |
| 2 | `SRE-GAP-001` — SLO / SLI / error budget | All authority tags the content **V2** (EA **L1921-1924**; `PRD-012a` **L200**) | **SRE / Observability** |
| 3 | `HD-2` rule content · `HD-3` Devanagari rule set · `HD-4` exception-set content | §16 forward note — *"a ruling can settle a MODEL without settling its CONTENT"* | **Architecture Owner** |
| 4 | `HD-7` · `HD-8` · `HD-11` · `HD-13` | Four **DEFER** rulings; ⛔ *"a DEFER closes nothing"* | per ruling |
| 5 | `P1` transport binding · `P7` latency reconciliation · `P7` throughput numeric | Recorded OPEN by `ADR-0100` itself | **Architecture Owner** / EA |
| 6 | `SRCH-GAP-001`…`009` | Nine registered gaps, each with an owner **in the PRD** — e.g. `GAP-002` → Architecture Owner, `GAP-007`/`GAP-009` → Product Owner | as registered |

⭐ **`SRCH-GAP-002` and `SRCH-GAP-007` are CLOSED** as of the Stage-3 conferral (18/18 and 7/7); the
remaining seven `SRCH-GAP-*` are **not Stage-4 checks** and remain registered OPEN with owners.

⛔⛔ **0 DEFER or OPEN items were converted into requirements, and 0 requirements were created to
reach the PASS.** The obligation count is **78 before and 78 after** this review.

---

## 6. ⛔⛔ MEASUREMENT IS NOT CONFERRAL — the exact remaining human act

⭐⭐ **This section follows `PRD-008_REQUIREMENTS_REVIEW.md` §5 deliberately, because that record
established the boundary for exactly this situation.**

| | |
|---|---|
| **Who may confer Stage 4** | The **Requirements Reviewer** — `PRD_LIFECYCLE.md` §6 **L278**: *"Requirements reviewer \| Stage 4"* |
| **Is that office defined?** | ⛔ **NO.** `grep -ci "requirements reviewer"` over `PRD_OWNERSHIP_MODEL.md` → ⭐ **0** |
| **Does a conferral exist for `PRD-015` Stage 4?** | ⛔ **NO** — 0 artefacts |
| **Why this record does not confer** | ⭐ The role is not held by the author of this pass. The repository's convention for exercising a role is an **explicit act** *"by direct conferral of the human principal"* (`ADR-0033` §7.2; `ADR-0032` §5.2; `ADR-0036` §8.2; and in this engagement `ADR-0102`, `ADR-0103`, `ADR-0104`) |
| **Consequence** | `PRD-015` stays **`DRAFT`**. `PRD_REGISTRY.md` unchanged. `DOCUMENTATION_BASELINE.md` unchanged. ⛔ **Stages 5, 6 and 7 remain unreached** |

### 6.1 ⭐ The exact single act required

> **(i)** Confer the **Requirements Reviewer** office for the **`PRD-015` Stage-4 review and
> conferral act only** — the same one-act form used by `ADR-0102` / `ADR-0103` / `ADR-0104`, ⛔ with
> **no personal name** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4).
>
> **(ii)** That office then **adopts §2–§5 as the measurement, or re-measures independently**, and
> **confers Stage 4 — or withholds it.**

⛔ **Until that act exists, Stage 4 is NOT CONFERRED**, and by `PRD_LIFECYCLE.md` §11 Stages 5–7
cannot lawfully be entered.

⚠ **I did not self-appoint, and I did not read `ADR-0104` as extending here** — its scope is
*"Stage-3 review and conferral act, **and nothing else**."*

---

## 7. Validation performed

| # | Check | Result |
|---|---|---|
| 1 | Six Stage-4 checks individually measured | ✅ **6 / 6 PASS** |
| 2 | Instrument defects disclosed rather than smoothed | ✅ **2 disclosed** (§2.1, §2.2) |
| 3 | Register census recomputed, not inherited | ✅ 42 / 14 / 6 / 16 / 78 / 9 |
| 4 | AC ↔ obligation mapping computed **both** directions | ✅ **0 uncovered · 0 orphan · 78/78** |
| 5 | Requirements created, removed, merged or reworded | ⛔ **0** — count **78 → 78** |
| 6 | DEFER / OPEN items converted into requirements | ⛔ **0** |
| 7 | Every open item has a reason **and** an owner | ✅ **6 classes, all owned** |
| 8 | Subject byte-unchanged | ✅ `fe3093e6…c2c4544` |
| 9 | Verification claimed | ⛔ **0 of 78** criteria proven — `SID-4.56` |
| 10 | Stage 4 conferred by this record | ⛔ **NO** — §6 |
| 11 | Stages 5–7 entered | ⛔ **NO** |
| 12 | `IMPL-*` or code created | ⛔ **0 · 0** |

---

## 8. Verdict

> ⭐⭐ **`PRD-015`'s requirements set PASSES all six Stage-4 checks on mechanical measurement:
> 78 obligation-bearing identifiers, 78 acceptance criteria, 100.0 % mapping in both directions,
> 0 duplicates, 0 orphans, 0 foreign restatements, 0 Rank-1 contradictions, and every open item
> carrying a reason and a named owner.**
>
> ⛔⛔ **STAGE 4 IS NOT CONFERRED.** Conferral is an act of the **Requirements Reviewer**, an office
> the repository does not define and has not conferred for `PRD-015`. ⭐ **Measurement is not
> conferral** — `PRD-008_REQUIREMENTS_REVIEW.md` §5.
>
> ⛔ `PRD-015` remains **`DRAFT` / `PLANNED`**, not frozen, ranked, baselined or verified. ⛔ Stages
> 5, 6 and 7 are **NOT** entered.

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-09-05 | ⭐⭐ Created. Stage-4 requirements-review **measurement** for `PRD-015`, entered because Stage 3 is CONFERRED at 16/16. **All six `PRD_LIFECYCLE.md` L108-119 checks PASS**, each measured rather than asserted: testability **78/78** GWT; **16/16** exclusions state impossibility rather than deferral; configurables **vacuously** — `SRCH-CFG-*` is **EMPTY (0)** and correctly so, since `ADR-0017`/`ADR-0099` §2.4 place `BC-23`'s carriage in `BC-25`'s `LCFG-*`, on the `PRD-023` *"owns configuration, owns no configurable"* precedent; AC mapping **78/78 both directions**; foreign-prefix definitions **0**, reinforced by `SRCH-XC-001`/`SRCH-FR-017`/`AR-1`; and **0** Rank-1 contradictions across all 14 `SRCH-BR-*`. ⭐ `SRCH-EVT-*` is also **EMPTY (0)** and correct by construction — `SRCH-FR-004` + `SRCH-INV-001` make `BC-23` a pure projection consumer, so ⛔ no event is invented to fill it. ⚠⚠ **TWO INSTRUMENT DEFECTS IN THIS REVIEW'S OWN CENSUS ARE DISCLOSED RATHER THAN SMOOTHED OVER, and both changed the answer: (1)** the first census reported **45 `SRCH-FR`** and duplicates at `FR-4`/`FR-12`/`BR-1`/`INV-1,3,4,5`/`XC-16` — the capture group was reading a **truncated prefix** of `SRCH-FR-042`-style numbers, exposed when a probe for `` `SRCH-FR-4` `` returned **0 hits**; ⭐ the absurdity of a 0-hit duplicate is what caught it. **(2)** Line-start matching counted **prose CROSS-REFERENCES as definitions** (L779 cites `SRCH-FR-004`; L667 cites `SRCH-INV-001`), fixed by requiring the em-dash separator every definition uses; ⚠ `SRCH-INV-005` needed a **third** pass and was resolved by **reading L358 and L798**, not by regex. ⭐ Corrected census: **42 FR · 14 BR · 6 INV · 16 XC · 78 AC · 9 GAP**, all unique and contiguous from 001, **0 duplicates**. ⭐⭐ The PRD's own **L997** claim of one criterion per obligation is **INDEPENDENTLY CONFIRMED, not accepted** — computed from its identifier definitions and `Verifies` parentheticals and cross-checked in reverse: **0 uncovered obligations, 0 orphan criteria, 78/78 = 100.0 %**. ⚠⚠ **What 100 % coverage does NOT mean is stated plainly: 0 of 78 criteria are PROVEN by a passing test** because no implementation exists (`SID-4.56` — *"a rule that cannot be checked SHALL be treated as unmet"*). ⛔ **0 requirements created, removed, merged or reworded — obligation count 78 before and 78 after**; ⛔ **0 DEFER/OPEN items converted into requirements**, with all six open classes carrying a **reason and a named owner** per the gate's second element (`SRCHPO-A11` → Architecture Owner · `SRE-GAP-001` → SRE/Observability, content **V2** · `HD-2`/`HD-3`/`HD-4` content → Architecture Owner · four **DEFER** rulings · `P1`/`P7` limbs → Architecture Owner/EA · seven remaining `SRCH-GAP-*` as registered). ⛔⛔ **STAGE 4 IS NOT CONFERRED:** conferral belongs to the **Requirements Reviewer** (`PRD_LIFECYCLE.md` §6 **L278**), an office measured at **0** occurrences in `PRD_OWNERSHIP_MODEL.md` with **0** conferrals for `PRD-015` — ⭐ *"measurement is not conferral"*, on the `PRD-008_REQUIREMENTS_REVIEW.md` §5 precedent. ⛔ `ADR-0104`'s reviewer conferral was **NOT** read as extending here; its scope is *"Stage-3 review and conferral act, **and nothing else**"* (`ADR-0033` §7.1). ⛔ **No self-appointment; no personal name.** ⛔ Subject **byte-unchanged** at `fe3093e6…c2c4544`; ⛔ no frozen document, Rank 1–5 artefact, registry row or baseline touched; ⛔ **Stages 5–7 NOT entered**; ⛔ **0** `IMPL-*` and **0** application-code files created. |
