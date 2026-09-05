# `PRD-015` — Product Owner Decision Resolution Record — **SUPPLEMENT C**

## ⭐ `H-C` — the V1 operational corpus definition **and** the `ZWNJ` corpus fact

| Field | Value |
|---|---|
| **Type** | Decision **resolution** record — **SUPPLEMENT** to `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` v1.0 |
| **Version** | v1.0 |
| **Date** | 2026-09-05 |
| **Predecessors** | `SUPPLEMENT_A` (`SRCHPO-16`, `H-B0` match roles) · `SUPPLEMENT_B` (`SRCHPO-17`, `H-B` script bindings) |
| **Why a SUPPLEMENT and not an edit** | The parent record's §14: *"the remedy is a **new record or a supplement** — ⛔ **never a silent rewrite of these answers**."* Supplements A and B were created on that ground; this record follows it |
| **Form** | Follows `PRD-006_PO_DECISION_RESOLUTION_RECORD.md` — the **`SRCHPO-A3` precedent** selected by human ruling **`HD-1`** |
| **Blocker addressed** | ⭐ **`H-C` ONLY** — both conjuncts, in **one** decision |
| **Conjuncts recorded** | **2 of 2** |
| **Final decision** | ⚠ **STAGE 3 REMAINS CONDITIONAL / NOT CONFERRED** — see §6 |

---

## 1. The decision as given

⭐⭐ **Both conjuncts arrived in a single Product Owner act, which is what `ADR-0100` L203 and
`ADR-0101` `D-10` jointly required.** Part XVII established they are **not separable**.

### `SRCHPO-18` — (A) the V1 operational corpus definition

> **The `PRD-015` V1 operational corpus is the actual V1 production/public library metadata corpus
> designated for operational indexing by `PRD-015`. Fixtures, examples, templates, and test-only data
> are not automatically included unless explicitly designated.**

### `SRCHPO-19` — (B) the `ZWNJ` corpus fact

> **V1's Devanagari corpus does not contain authoritative `ZWNJ`-distinguished names.**

⭐ **`SRCHPO-19` is a statement of product fact, not an inference.** It is the one thing the
repository could never supply, because the repository is not the corpus.

### 1.1 ⭐ What changed from the reviewed proposal, and what did not

⚠ **The adopted conjunct (A) is NOT byte-identical to the definition Part XIX §165 reviewed, and the
difference is recorded rather than glossed.**

| | Part XIX §165 proposal | ⭐ As adopted (`SRCHPO-18`) |
|---|---|---|
| Corpus scope | *"the actual V1 production/public library metadata corpus designated for operational indexing by `PRD-015`"* | ⭐ **identical** |
| Exclusion | *"Fixtures, examples, templates, and test-only data are **not automatically included**."* | ⭐ **plus** *"**unless explicitly designated**"* |

⭐⭐ **The added clause makes the definition strictly better, and it is worth saying why.** *"Not
automatically included"* left it ambiguous whether such data could **ever** enter the corpus. The
adopted wording resolves that: it can, but **only by express designation** — which converts a silent
default into an **auditable act**. That is the same discipline `SRCH-FR-017` applies to field
eligibility (*"indexable only where its owning contract declares it so"*), so the shape is
**precedented, not novel**.

---

## 2. ⭐ What each conjunct closes

| Conjunct | Closes | Authority discharged |
|---|---|---|
| **(A)** `SRCHPO-18` | ⭐ `ADR-0100` **L203** — the V1 operational corpus definition | Gate condition **9** |
| **(B)** `SRCHPO-19` | ⭐ `ADR-0101` **`D-10`** — the `ZWNJ` (`U+200C`) / Devanagari residue | Gate condition **10** |

### 2.1 ⭐⭐ How `SRCHPO-19` closes `D-10` **without** inventing a Unicode rule

⚠⚠ **This is the section that must be exactly right, because `ADR-0101` `D-10` refused this question
on measured evidence and expressly named the way it must *not* be answered.**

`ADR-0101` **L188-198** published a falsifiability list — *"What would close it"* — of three routes:

| # | Route | Status |
|---|---|---|
| 1 | A Devanagari orthographic authority (Unicode Ch. 12.1 / CLDR tailoring) | ⛔ **NOT USED** — and ⭐ `HD-3` §4.3 bars treating Unicode as product authority anyway |
| 2 | ⭐ **A Product Owner ruling that Liboora's V1 Devanagari corpus does not contain `ZWNJ`-distinguished names, making the question non-arising for V1** | ✅ ⭐⭐⭐ **THIS IS THE ROUTE TAKEN** — `SRCHPO-19` matches limb 2 in substance and in scope |
| 3 | A Devanagari test corpus exercising `SRCH-AC-024` | ⛔ **NOT USED** — *"which currently does not exist"* |

⭐⭐⭐ **`D-10` is therefore closed on its own published terms, by the exact route it nominated, by the
office it nominated.** ⛔ **No Unicode rule is invented, extended or asserted.** ⛔ **No statement
about `ZWJ` is stretched to cover `ZWNJ`** — which `D-10` called *"inventing a Unicode rule"*.

### 2.2 ⚠ The precise scope of `SRCHPO-19` — stated so it is not over-read

| ⭐ What it establishes | ⛔ What it does NOT establish |
|---|---|
| For **V1**, the `ZWNJ`-before-virama question is **non-arising** in Liboora's corpus | ⛔ That `ZWNJ` is orthographically insignificant **in Devanagari generally** — that is a Unicode question and remains unanswered |
| `N6`'s removal of `ZWNJ` cannot destroy an authoritative V1 name distinction | ⛔ That the same holds for **V2** or any later corpus |
| ⭐ `SRCH-AC-024` has no V1 counter-example to satisfy | ⛔ That a Devanagari test corpus now exists — it still does not |

⚠ **If the V1 corpus later acquires `ZWNJ`-distinguished names, `SRCHPO-19` is falsified and `D-10`
re-opens.** ⭐ That is a **feature** of recording it as a corpus fact rather than a Unicode rule, and
`SRCHPO-18`'s *"unless explicitly designated"* is precisely the hook by which such a change would
become visible.

---

## 3. What this record authorises — and does not

### 3.1 ✅ Authorised

| # | Authorised |
|---|---|
| 1 | The V1 operational corpus has an **authoritative definition** (`SRCHPO-18`) |
| 2 | The `ZWNJ` corpus fact is **established as a fact** (`SRCHPO-19`) |
| 3 | `ADR-0100` **L203** and `ADR-0101` **`D-10`** are **discharged** |
| 4 | Gate conditions **9** and **10** close; ⭐ consequentially **5** and **7** — see §6 |
| 5 | ⭐ `SRCH-GAP-007` sub-item `FU-19`, which was BLOCKED on `H-C`, is unblocked |

### 3.2 ⛔ NOT authorised

| # | ⛔ Not authorised |
|---|---|
| 1 | ⛔ **No Unicode rule** is created, extended or asserted — `ZWNJ`'s general Devanagari significance stays unanswered |
| 2 | ⛔ **No `N1`–`N6` disposition table**, analyzer, tokenizer or stemmer |
| 3 | ⛔ **`SRCHPO-A11`** — the script-selection mechanism for a two-member binding — remains **OPEN** |
| 4 | ⛔ **No SLO, SLI, error budget, threshold or measurement** — `SRE-GAP-001` remains **OPEN** |
| 5 | ⛔ **No `P4` value**, edit-distance bound or prefix length; ⛔ `HD-7`, `HD-8`, `HD-11`, `HD-13` remain DEFERRED/OPEN |
| 6 | ⛔ **No `P7` latency platform reconciliation**, ⛔ no `P7` throughput numeric, ⛔ no `P8-C` verifiability |
| 7 | ⛔ **No Devanagari test corpus** is claimed to exist |
| 8 | ⛔ **No third language or script value** |
| 9 | ⛔ **No freeze, baseline, rank or Stage-3 conferral** — ⛔ **Stages 4–7 not entered** |
| 10 | ⛔ **No `IMPL-*` task** and **no code** |

---

## 4. `H-C` gate — re-run

| # | `H-C` condition | Before | ⭐ After |
|---|---|---|---|
| 1 | Conjunct (A) — corpus definition supplied | ⛔ **0 facts** | ✅ **`SRCHPO-18`** |
| 2 | Conjunct (B) — `ZWNJ` corpus fact supplied | ⛔ **0 facts** | ✅ **`SRCHPO-19`** |
| 3 | Both in **one** Product Owner decision | ⛔ | ✅ **YES** |
| 4 | (B) not inferred from absence of evidence | — | ✅ **stated as fact**, ⛔ not inferred |
| 5 | ⛔ No Unicode rule invented | — | ✅ **route 2 of `D-10`'s own list** |
| 6 | Recorded through the lawful carrier (`HD-1` / `SRCHPO-A3`) | ⛔ | ✅ **this supplement** |
| 7 | Recorded without amending a frozen document | — | ✅ **0 frozen bytes** |

### ⭐⭐⭐ `H-C` — ✅ **CLOSED**

---

## 5. Findings register — this supplement

| ID | Finding | Status |
|---|---|---|
| **`SRCHPO-18`** | The V1 operational corpus definition | ✅ **ADOPTED** |
| **`SRCHPO-19`** | V1's Devanagari corpus does not contain authoritative `ZWNJ`-distinguished names | ✅ **ADOPTED** |
| **`SRCHPO-A12`** | ⭐⭐ The adopted (A) adds *"unless explicitly designated"* to the reviewed proposal, converting a silent default into an **auditable designation act** — the same discipline `SRCH-FR-017` applies to field eligibility | ✅ **ACCEPTED — an improvement, recorded as a delta** |
| **`SRCHPO-X17`** | ⛔ *"`SRCHPO-19` settles whether `ZWNJ` is orthographically significant in Devanagari"* | ⛔ **REJECTED** — it is a **corpus fact**, scope V1 only; the Unicode question is untouched (§2.2) |

**Tally: 2 adopted · 1 accepted finding · 1 rejected.**

---

## 6. ⚠⚠ Consequences — and why Stage 3 still is not conferred BY THIS RECORD

⭐ **`H-C` was the last outstanding human *decision*.** Its closure moves four gate conditions:
**9**, **10**, and consequentially **5** and **7**.

⛔ **But two conditions remain, and this record closes neither:**

| Condition | State | Why this record cannot close it |
|---|---|---|
| **6** — `SRCH-GAP-002` fully closed | ⛔ **OPEN** | ⚠ Its remaining limbs are **parameters**, not decisions: limb **7** and **17c** PARTIAL, plus `FU-20`'s 14-value limb. ⭐ `HD-7`, `HD-8`, `HD-11`, `HD-13` are **DEFER** rulings, and ⛔ *"a DEFER closes nothing"* |
| **15** — formal Stage-3 conferral | ⛔ **NOT PERFORMED** | ⭐ It is an act of the **designated reviewer** (`ADR-0104`), ⛔ not of the Product Owner. It is now *performable*, and its outcome is **not** pre-judged here |

⭐⭐ **This record therefore does exactly what it can and refuses to do more.** It supplies the two
facts, closes `H-C`, and leaves the review and the parameter completeness of `SRCH-GAP-002` to their
own owners. ⛔ **Rule `X3`: a gap closes on all limbs, not a majority.**

---

## 7. Validation performed

| # | Check | Result |
|---|---|---|
| 1 | Carrier is the `HD-1` / `SRCHPO-A3` mechanism | ✅ ⛔ 0 new mechanisms |
| 2 | Parent record unmodified | ✅ `76b469cc…38643bd6` |
| 3 | Supplements A and B unmodified | ✅ `cmp`-verified |
| 4 | Subject `PRD-015_SEARCH_INDEXING.md` unmodified | ✅ `fe3093e6…c2c4544` |
| 5 | Frozen §14A / §14B / `Library_PRD_v1.md` / `MASTER_PRD.md` unmodified | ✅ |
| 6 | (B) matches `D-10`'s own falsifiability route 2 | ✅ **in substance and scope** |
| 7 | Unicode rule invented | ⛔ **0** |
| 8 | Devanagari test corpus claimed to exist | ⛔ **NO** |
| 9 | SLO / SLI / error budget / threshold invented | ⛔ **0** |
| 10 | `SRCHPO-*` ID collision check before minting | ✅ `18`, `19`, `A12`, `X17` → **0 hits each** |
| 11 | Delta from the reviewed proposal disclosed | ✅ `SRCHPO-A12` |
| 12 | Stage-3 conferral performed by this record | ⛔ **NO** — §6 |
| 13 | Code / `IMPL-*` / freeze / baseline / rank | ⛔ **0** of each |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-09-05 | ⭐⭐⭐ Created. Records the **single lawful `H-C` Product Owner decision, both conjuncts together** as `ADR-0100` **L203** and `ADR-0101` **`D-10`** jointly required and as Part XVII held non-separable: **`SRCHPO-18`** — the V1 operational corpus is *"the actual V1 production/public library metadata corpus designated for operational indexing by `PRD-015`; fixtures, examples, templates and test-only data are not automatically included **unless explicitly designated**"* — and **`SRCHPO-19`** — *"V1's Devanagari corpus does not contain authoritative `ZWNJ`-distinguished names."* ⭐⭐⭐ **`D-10` is closed on its OWN PUBLISHED TERMS:** `ADR-0101` **L188-198** listed three closing routes and `SRCHPO-19` is **route 2** — *"a Product Owner ruling that Liboora's V1 Devanagari corpus does not contain `ZWNJ`-distinguished names, making the question non-arising for V1"* — by the office that list nominated. ⛔ **Route 1 (Unicode Ch. 12.1 / CLDR) and route 3 (a Devanagari test corpus) were NOT used**, the former also barred by `HD-3` §4.3, the latter *"currently does not exist"*; ⛔ **no Unicode rule is invented, extended or asserted, and no `ZWJ` statement is stretched to cover `ZWNJ`.** ⚠ **`SRCHPO-19`'s scope is stated so it cannot be over-read (§2.2, `SRCHPO-X17` REJECTED):** it is a **V1 corpus fact**, ⛔ **not** a ruling that `ZWNJ` is orthographically insignificant in Devanagari generally, ⛔ not a V2 statement, and ⛔ not a claim that a test corpus exists — and if the V1 corpus later acquires such names, `SRCHPO-19` is **falsified and `D-10` re-opens**. ⭐ **The delta from the reviewed proposal is disclosed rather than glossed (`SRCHPO-A12`):** the adopted (A) adds *"unless explicitly designated"*, converting a silent default into an **auditable designation act** — the same discipline `SRCH-FR-017` applies to field eligibility. ✅ Closes gate conditions **9** and **10**, consequentially **5** and **7**, and unblocks `SRCH-GAP-007` sub-item **`FU-19`**. ⛔⛔ **This record does NOT confer Stage 3**, and two conditions remain outside its competence: **6** (`SRCH-GAP-002` — remaining limbs are **parameters, not decisions**: limbs 7 and 17c PARTIAL plus `FU-20`'s 14-value limb, with `HD-7`/`HD-8`/`HD-11`/`HD-13` being **DEFER** rulings and *"a DEFER closes nothing"*) and **15** (the conferral, an act of the **designated reviewer** under `ADR-0104`, whose outcome is expressly **not pre-judged here**). ⛔ **`SRCHPO-A11`** (script-selection mechanism) and ⛔ **`SRE-GAP-001`** (SLO/SLI/error budget, all authority **V2**) remain **OPEN**. ⛔ 0 frozen bytes, 0 Unicode rules, 0 SLIs, 0 thresholds, 0 new owners, 0 ADRs, 0 code, 0 `IMPL-*`, 0 freeze/baseline/rank; ⛔ **Stages 4–7 not entered.** ⚠ **STAGE 3 REMAINS CONDITIONAL / NOT CONFERRED by this record.** |

### 8.1 ⭐ This record's own amendment rule

This record states what was decided **on the date it was decided**. If a later decision supersedes
it, the remedy is a **new record or a further supplement** — ⛔ **never a silent rewrite of these
answers**, on the identical ground the parent record states at its §14 and Supplements A and B
restate: *a decision record that changes its own answers cannot be distinguished from one that never
had them.*
