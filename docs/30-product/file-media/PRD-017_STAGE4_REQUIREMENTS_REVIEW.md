# `PRD-017` File & Media v0.1 — Stage 4 Requirements Review Record

| Field | Value |
|---|---|
| **Stage** | **Stage 4 — Requirements Review** (`PRD_LIFECYCLE.md` L108–120) |
| **Subject** | [`PRD-017_FILE_AND_MEDIA.md`](PRD-017_FILE_AND_MEDIA.md) — `PRD-017`, `BC-29` File & Media, **v0.1 `DRAFT`** |
| **Gate** | *"conflicts closed or explicitly deferred **with a reason and an owner**"* |
| **Gate satisfied by** | §9. **5 defects closed by edit**, **8 items explicitly deferred**, every one with a reason **and** a named owner |
| **Predecessors** | ⚠ Stage 1 artefact **does not exist** (`FIL-GAP-008`) · [Stage 3 Alignment](PRD-017_ARCHITECTURE_ALIGNMENT.md) ✅ **PASS — CONDITIONAL** (6 of 6, 1 governance dependency open) |
| **PRD hash before review** | `880de96ea6667bba5bf3cb7eae4554629b6bf98348d39cfd00eaa9d3329ac2d6` — 130,636 chars |
| **PRD hash after review** | `202ccf5e5c24f4a7edd938f39c226c18bbae5d8ac6eaf55f93aea3e6fdf9705e` — 132,539 chars. **This review edited its subject; §1.2 states why, and §2 discloses the consequence** |
| **Reviewer role** | Requirements reviewer (`PRD_LIFECYCLE.md` §6). **No named holder exists** — `PGA-08` |
| **Date** | 2026-08-20 |
| **Mandate** | **Stage 4 only.** No ADR created · no identifier registered in any matrix · **no ranked document touched** · no registry or baseline update · no freeze · no application code. Stages 5–7 not started at the time of writing |
| **Verdict** | ✅ **PASS — 6 of 6 checks.** **5 genuine defects found and fixed** (§9.1), including **2 that this review's own repairs introduced** (§9.2) · 8 deferrals each with a reason and an owner · 6 candidate findings rejected with reasons (§10) · 2 defects in this review's own instruments disclosed (§11) |

> `PRD_LIFECYCLE.md` L41–42: *"A gate is not an opinion — if the artefact does not exist, the stage has not been
> passed, however complete the work feels."* This document is that artefact for Stage 4.

---

## 1. Method

### 1.1 The six lifecycle checks, quoted, and how each was decided

`PRD_LIFECYCLE.md` L108–120 fixes Stage 4. The checks are quoted verbatim so that a later reader can audit the
mapping rather than trust it.

| # | Check, as written in `PRD_LIFECYCLE.md` | Decided in | Result |
|---|---|---|---|
| 1 | *"Every requirement is testable"* | §3 | ✅ PASS — 0 vague terms, 0 requirements without a normative verb |
| 2 | *"Every exclusion states what must be impossible"* | §4 | ✅ PASS — 22 of 22 carry `MUST NOT`/`SHALL NOT` |
| 3 | *"Every configurable has a default and a range"* | §5 | ✅ PASS **on the register**, ⚠ **1 documented exception**, and a **prose contradiction fixed** |
| 4 | *"Every acceptance criterion maps to a requirement"* | §6 | ✅ PASS — 78 of 78 cite ≥1 defined identifier; 0 dangling |
| 5 | *"No requirement restates another PRD's"* | §7 | ✅ PASS — 0 positive ownership assertions over `PRD-021` territory |
| 6 | *"Business rules do not contradict Rank 1"* | §8 | ✅ PASS — and **1 internal contradiction between three PRD-017 rules found and fixed** |

Beyond the six, the review was also given **14 named adversarial categories** by the requesting authority:
ambiguity, contradictions, duplicate requirements, missing acceptance criteria, security, authorization, file
access, revocation, isolation, auditability, failure cases, student-to-student sharing V1 consistency, ownership
leakage into `PRD-021`, and untestable requirements. §12 maps all 14 to where each was decided, so that none is
silently skipped.

### 1.2 ⚠ This review **edited** its subject, and the repository precedent says it should not have

This is a deliberate, disclosed departure from precedent, not an oversight.

`PRD-023_STAGE4_REQUIREMENTS_REVIEW.md` §1.2 argues that a Stage 4 review must **not** edit the draft, because the
review's own header records a `sha256` of the subject; editing the subject invalidates that measurement and makes
the record describe a document that no longer exists. That review therefore recorded its two genuine defects
(`S4-D-01`, `S4-D-02`) as **DEFERRED** and left the draft untouched.

The requesting authority for `PRD-017` instructed the opposite in explicit terms: *"Fix only genuine PRD-017
defects. Do not modify unrelated frozen documents."* An instruction to **fix** cannot be discharged by deferring.

**Disposition.** The instruction was followed. The precedent's concern was real, so it is answered rather than
ignored:

1. **Both hashes are published** in the header — before (`880de96a…`) and after (`202ccf5e…`) — so the record is
   auditable in both directions rather than silently describing a superseded file.
2. **§2 discloses the downstream consequence**: the Stage 3 record's subject hash is now stale.
3. The precedent's narrower rule — *"a stale review is corrected by a dated re-run beside it, not by editing what
   it concluded"* — is honoured: **this document was not back-edited**, and the Stage 3 record was **not** back-edited
   either. Its staleness is disclosed, not repaired.

**The two positions differ on procedure, not on truth.** Both hold that a measurement must match what it measured.
`PRD-023` achieved that by freezing the subject; `PRD-017` achieves it by publishing both endpoints and naming what
went stale.

---

## 2. ⚠ Disclosure — the Stage 3 record's subject hash is now stale

[`PRD-017_ARCHITECTURE_ALIGNMENT.md`](PRD-017_ARCHITECTURE_ALIGNMENT.md) records, in its header, the subject hash
it measured:

```
85adb6fa85fa687743992fe377ffa7652af5b4a625107efb2c2e9031dd1cb44e
```

Because this review edited `PRD-017_FILE_AND_MEDIA.md`, that hash **no longer matches the file**. The current value
is `202ccf5e5c24f4a7edd938f39c226c18bbae5d8ac6eaf55f93aea3e6fdf9705e`.

| Field | Stage 3 record says | Actual now |
|---|---|---|
| Subject hash | `85adb6fa…cb44e` | `202ccf5e…9705e` |
| Subject size | 129,556 chars (at Stage 3) | 132,539 chars |
| Stage 3 conclusions affected | — | **None. See below.** |

**Why the Stage 3 conclusions still stand.** Stage 3 decided **boundary** questions: which context owns what, which
`E-*` edges exist, rank direction, tenant/global classification. This review changed **five things**, none of which
is a boundary fact:

- `FIL-FR-075` gained a **property** on a record `PRD-017` already owned (no new consumer, no new edge).
- `FIL-FR-076` **named** `BC-12` as the calling context — which is precisely what Stage 3 §3.3 concluded, so the
  edit moved the PRD **toward** the alignment record, not away from it.
- `FIL-FR-080` removed a phantom state from a state machine wholly internal to `BC-29`.
- `FIL-AC-063`, `FIL-AC-077` and `FIL-AC-078` are acceptance criteria, which assert no ownership.
- §8.5 and §14 prose corrections changed **counts and claims**, not obligations.

**0 edges added · 0 consumers added · 0 aggregates asserted · 0 ranks changed · 0 isolation classes changed.**

**Disposition: DISCLOSED, NOT REPAIRED.** The precedent for this exact situation is
`PRD-023_STAGE7_FREEZE.md` §3, which handles a changed subject hash with a before/after table and the principle
that *"the PRD hash changed, and that is disclosed rather than glossed."* Re-stamping the Stage 3 record with a new
hash would be **back-dating a measurement that was never taken**. Owner: **Architecture Owner**, at the next
Stage 3 re-run should one be required.

---

## 3. Check 1 — Every requirement is testable

### 3.1 Normative-verb census

Every `FIL-FR-*` was extracted at its definition site and tested for a normative verb (`SHALL` or `MUST`).

```
FR definitions captured .............. 82
FR without SHALL/MUST ................  0   PASS
```

A requirement with no normative verb is a description, not an obligation, and nothing can fail it.

### 3.2 Vague-adjective scan

The obligation-bearing registers (`FIL-FR-*`, `FIL-BR-*`, `FIL-INV-*` — 110 identifiers) were scanned for 20 terms
that make an obligation unfalsifiable:

```
appropriate · reasonable · efficient · fast · robust · user-friendly · as needed · etc. · adequate
properly · sufficient · good · best-effort · if possible · where possible · generally · typically · usually
```

```
vague-term hits ...................... 0   PASS
```

### 3.3 The one requirement that is genuinely untestable, and why it is not a defect

`FIL-FR-046` obliges a **security review** of an isolation-key change. No criterion can assert that a human review
occurred, because the reviewer is not part of the system under test.

This is **not** repaired, and the reason is precedent rather than convenience. `PRD-014_ENTITLEMENT.md` **L555**
disposed of the identical shape for `ENT-FR-017`, recording that a criterion written there *"would test code this
PRD does not govern."* The obligation stands and is verified by governance.

⚠ The draft already states this at the end of §14.4. **Check 1 passes with the exception named in the document, not
hidden by this review.**

---

## 4. Check 2 — Every exclusion states what must be impossible

```
FIL-XC-* definitions ................. 22
carrying MUST NOT / SHALL NOT ........ 22   PASS
carrying neither .....................  0
```

An exclusion that merely says a thing is "out of scope" is a planning note. An exclusion that says the module
`MUST NOT` do it is an obligation that a boundary test can fail. All 22 are of the second kind.

⚠ **This check passing does not mean the exclusions are *covered*.** 17 of the 22 have no acceptance criterion, by
construction — see §6.3. The two facts are independent and the draft states both.

---

## 5. Check 3 — Every configurable has a default and a range

### 5.1 Register state

`FIL-FR-074` obliges *"a declared **default** and a declared **range**"* for every configurable this module
publishes. There are **9** (`FIL-CFG-001`…`FIL-CFG-009`).

| Result | Count |
|---|---|
| Satisfy `FIL-FR-074` | **8** |
| Do not | **1** — `FIL-CFG-006`, which carries a range but **no default** |

`FIL-CFG-006` is the retention period. The draft's §8.5 explains that no Rank 1–7 document fixes a retention
default, and inventing one would be this PRD legislating a data-retention policy it does not own. **Correct
disposition, already recorded as `FIL-GAP-008`.**

### 5.2 ⚠ Defect `S4-D-01` — the subsection contradicted itself, and this was fixed

The initial probe flagged **all nine** configurables. Investigation showed the probe was reading the table, which
legitimately does not repeat the word "default" per row — a **false positive on 8 of 9** (disclosed in §11).

But driving the false positive to root cause surfaced a **real** defect that a correct probe would have missed.
§8.5 **opened** by asserting:

> *"Nine values, each with a **default and a range** as `FIL-FR-074` requires…"*

…and then, **20 lines below in the same subsection**, disclosed:

> *"⚠ `FIL-CFG-006` is published with a declared range but **NO default**…"*

A subsection that claims all nine comply and then names an exception is **internally contradictory**, and a reader
who stops at the opening sentence is misinformed by the document itself.

**Fixed.** The opening now reads *"`FIL-FR-074` requires a declared **default and range** for each; **eight
satisfy it and one does not**"*, with the reason for naming the exception up front rather than in a footnote stated
inline.

> **What this defect teaches.** The contradiction was **not** between two documents, nor between a rule and a
> register — it was between the **summary of a table and the table itself**, 20 lines apart. No register check
> reads prose. This is the same failure mode as the count defects in §9.2, and it is the dominant defect class in
> this document.

---

## 6. Check 4 — Every acceptance criterion maps to a requirement

### 6.1 Forward coverage — every criterion cites a requirement

```
FIL-AC-* definitions ................. 78
citing >= 1 identifier ............... 78   PASS
orphan criteria (citing nothing) .....  0
citations to undefined identifiers ...  0   PASS
```

### 6.2 Reverse coverage — recomputed, not read from the draft

Coverage was recomputed from the `FIL-AC-*` citation sets rather than trusting the figure the draft publishes.

```
obligation-bearing identifiers (FR+BR+INV+XC) ... 132
covered by >= 1 criterion ....................... 94
coverage ........................................ 94/132 = 71.2%
uncovered ....................................... 38  (17 FIL-XC + 21 other)
```

**The draft's published figure — 94/132 = 71.2% — matches the independent recomputation exactly.**

⚠ **Notably, the two criteria this review added did not change coverage.** `FIL-AC-077` and `FIL-AC-078` cite
`FIL-FR-075`, `FIL-FR-076`, `FIL-FR-080`, `FIL-BR-008` and `FIL-INV-010` — **all five were already covered** by
`FIL-AC-057`/`058`/`063`/`064` and `FIL-AC-071`. The new criteria add **depth** on already-covered requirements,
not **breadth**. This was verified rather than assumed, because the natural expectation — *"we added criteria, so
coverage rose"* — is wrong here, and had it been assumed, §14.3's figures would have been "corrected" into error.

### 6.3 The 38 uncovered, confirmed structural

| Kind | Count | Why uncovered |
|---|---|---|
| `FIL-XC-*` exclusions | **17** | Unfalsifiable by observation of this module |
| Definitional / structural / cited obligations | **21** | State where a rule *lives* (`FIL-FR-001`…`003`), or are enforced by another document |

The 21 were listed and each confirmed: `FIL-FR-001`, `002`, `003`, `006`, `007`, `009`, `010`, `012`, `024`, `032`,
`046`, `055`, `057`, `067`, `070`, `073`, `074`, `FIL-BR-001`, `FIL-BR-002`, `FIL-BR-013`, `FIL-INV-005`.

**This list matches §14.3's list exactly** — 0 wrongly listed, 0 wrongly omitted.

---

## 7. Check 5 — No requirement restates another PRD's, and no ownership leaks into `PRD-021`

This is the check the requesting authority weighted most heavily, because `PRD-017` gained student-to-student
sharing in V1 while `BC-11`/`BC-12`/`BC-13` remain owned by `PRD-021`.

### 7.1 The mechanical test

Leakage would appear as `PRD-017` **positively obliging itself** to hold social, messaging or moderation state. The
document was scanned for a positive obligation (`SHALL`/`MUST`, **not** followed by `NOT`) within 160 characters of
any of: `friendship`, `blocklist`, `conversation`, `message text`, `moderation`, `abuse report`, `strike`,
`canMessage`.

```
positive ownership assertions over PRD-021 territory ...... 0   PASS
```

### 7.2 Why zero is the correct result and not a blind spot

Every mention of `PRD-021` territory in `PRD-017` is in one of three shapes, all of which are *refusals* or
*citations* rather than claims:

| Shape | Example | Effect |
|---|---|---|
| Prohibition | `FIL-XC-019` — *"**MUST NOT** decide whether two people may exchange anything"* | Refuses eligibility to `BC-11` |
| Prohibition | `FIL-XC-020` — refuses message text, ordering, receipts, presence, membership to `BC-12` | Refuses messaging state |
| Prohibition | `FIL-XC-022` — refuses moderation verdicts to `BC-13` | Refuses moderation |
| Record-not-derive | `FIL-FR-076` — records the decision reference, `SHALL NOT` ask `BC-11` | Consumes without owning |

The boundary is therefore enforced **as testable prohibitions**, not as stated intent — which is what makes it
survivable at Stage 6, where a task list could otherwise quietly implement the forbidden thing.

### 7.3 ⚠ Defect `S4-D-03` — `FIL-FR-076` obliged a decision reference without naming who supplies it

Routed to this review by Stage 3 as accepted finding `S3-A-03`, on the ground that *"Stage 3 validates boundaries
and does not edit requirement text."*

As drafted, `FIL-FR-076` said eligibility *"**SHALL** be obtained from the calling context"* — passive voice with
**no named party**. An obligation with no obligated party cannot be assigned, and at Stage 6 it becomes a task
nobody owns.

**Fixed.** The requirement now states that the **calling context SHALL** have obtained the decision and **SHALL**
supply a reference; that the module **SHALL refuse** a request carrying none; and that for student-to-student
sharing the calling context is **`BC-12` Messaging** — the context `E-16` already positions to ask `BC-11` for
`canMessage(a, b)`.

⚠ **This edit is aligned with Stage 3, not independent of it.** Stage 3 §3.3 concluded on the evidence of BC Map
§8 aggregate rows **L377**/**L378**/**L379** that **`BC-12` alone** is the minimal sufficient consumer. Naming
`BC-12` here does not add a consumer — it makes the PRD say what the alignment record already proved.

---

## 8. Check 6 — Business rules do not contradict Rank 1 (and the internal contradiction that was found instead)

### 8.1 Rank 1 conformance

`FIL-BR-001`…`FIL-BR-017` were read against `MASTER_PRD.md`'s `MP-GBR-*`, `MP-NFR-*` and `MP-CON-*`.

```
contradictions against Rank 1 ........ 0   PASS
```

### 8.2 ⚠ Defect `S4-D-02` — a three-way state-machine contradiction internal to `PRD-017`

Check 6 asks about Rank 1. Running it surfaced something worse: a contradiction **among three `PRD-017` rules**,
which no cross-document check would ever have caught.

`FIL-FR-080` said soft-deleting an object *"**SHALL** suspend every grant on it."*

| Rule | What it says | Conflict with "suspend" |
|---|---|---|
| `FIL-INV-010` | A grant **MUST** be in exactly one state — `Active` or `Revoked` — and `Revoked` is **terminal** | `Suspended` is **not one of the two permitted states** |
| `FIL-BR-008` | Soft-delete is **reversible** within the retention window | If "suspend" meant `Revoked`, the grant could never come back — soft-delete would be **irreversible** for grants |

So `Suspended` was either **an undeclared third state** (violating `FIL-INV-010`) or **an irreversible one**
(violating `FIL-BR-008`). Both readings are defects, and the requirement did not say which was meant.

**Fixed — by removing the phantom state, not by declaring it.** The repair uses a mechanism the document already
had: `FIL-INV-009` makes a grant's readability follow the object. So:

> While the object is soft-deleted, every grant on it **SHALL** be unreadable **without any change to the grant's
> own state**; permanent deletion **SHALL** remove the grants. If the object is restored within `FIL-CFG-006`,
> grants still in `Active` **SHALL** become readable again and grants in `Revoked` **SHALL** remain unreadable.

**Why removal beats declaration.** Adding a third state would have obliged edits to `FIL-INV-010`, the §9 state
table, and every criterion asserting two-state discipline — turning a one-line defect into a structural change, to
model something the object's own lifecycle already expresses. **The smaller repair is the one that deletes the
contradiction rather than the one that accommodates it.**

`FIL-AC-063` was reworded to match, and `FIL-AC-078` was added so the **restore** path — previously asserted by no
criterion at all — is testable.

Residual `Suspended` occurrences in the document: **1**, inside the ⚠ correction note that quotes the removed text.
Verified mechanically.

---

## 9. Dispositions — the gate

The Stage 4 gate is *"conflicts closed or explicitly deferred **with a reason and an owner**."*

### 9.1 Defects found and **CLOSED BY EDIT**

| ID | Defect | Repair | Check |
|---|---|---|---|
| `S4-D-01` | §8.5 opened claiming all 9 configurables carry a default and range, then disclosed 20 lines later that `FIL-CFG-006` does not | Opening rewritten to *"eight satisfy it and one does not"*, exception named up front | 3 |
| `S4-D-02` | `FIL-FR-080`'s *"suspend every grant"* contradicted `FIL-INV-010` (two states, `Revoked` terminal) **and** `FIL-BR-008` (soft-delete reversible) | Phantom state removed; readability follows the object per `FIL-INV-009`; `FIL-AC-063` reworded; `FIL-AC-078` added | 6 |
| `S4-D-03` | `FIL-FR-076` obliged a decision reference in passive voice with **no named obligated party** | Calling context named as **`BC-12`**; refusal on a missing reference made explicit | 5 |
| `S4-D-04` | `FIL-FR-075` listed **five** grant properties and omitted the decision reference — while `FIL-FR-076` obliged **recording** one. An obligation to store a value the record need not carry is **unimplementable** | Reference added as a named property of the grant; `FIL-AC-057` updated to require it | 1 |
| `S4-D-05` | `FIL-AC-077`, added by **this review**, duplicated `FIL-AC-058` with an **identical citation set** | Rewritten to assert the untested **positive** half — that the supplied reference is recorded unchanged | 4 |

### 9.2 ⚠ Two of the five defects were **introduced by this review's own repairs**

This is stated plainly because it is the most useful finding in the record.

- **`S4-D-04`** existed only because `S4-D-03`'s repair strengthened *"record that reference"* into a hard
  obligation — against a record definition that had no field for it. **Sharpening one requirement created a
  contradiction with a neighbouring one.**
- **`S4-D-05`** was a duplicate criterion **written by this review**, and it was caught only because duplicate
  detection was re-run **after** the repairs rather than before.

The detector that caught `S4-D-05` compared **citation sets**, not wording. Wording comparison scored the pair at
**0.55** — below any sane threshold, because the two criteria are genuine paraphrases. Citation-set comparison
scored it as an **exact collision**:

```
['FIL-AC-058', 'FIL-AC-077'] -> ('FIL-FR-076', 'FIL-XC-019')
```

> **The rule this establishes.** *A review that repairs a requirement must re-run its full check suite over its own
> additions.* The party that writes a fix is the party least able to see that the fix restates something, and
> paraphrase defeats textual similarity. **Two criteria that cite exactly the same requirements are testing the
> same thing, whatever they sound like.**

After the repair: **0 citation-set collisions, 0 near-duplicate pairs above 0.70.**

### 9.3 Items explicitly **DEFERRED**, each with a reason and an owner

| ID | Item | Reason not fixed here | Owner |
|---|---|---|---|
| `S4-F-02` | `FIL-GAP-012` — `E-22` does not list `BC-12`; the V1 sharing requirement is fully specified but **not servable** | Widening a Rank 4 edge requires an accepted ADR (BC Map **L292**). A Stage 4 record is unranked and confers nothing | **Architecture Owner** (Stage 7) |
| `S4-F-03` | `FIL-GAP-001` — `BC-29` owns no BC Map §8 aggregate row | Asserting one amends a Rank 4 frozen document without an ADR | **Architecture Owner** |
| `S4-F-04` | `FIL-CFG-006` has no default | No Rank 1–7 document fixes a retention default; inventing one legislates policy this PRD does not own | **Product + Legal** |
| `S4-F-05` | `FIL-FR-046` untestable (human security review) | Precedent `PRD-014` **L555**: a criterion here would test what this PRD does not govern | **SECURITY** |
| `S4-F-06` | `FIL-GAP-005` — virus scan/thumbnails V1 at Ranks 3/4, **V2** in the EA (Rank 6) | Resolved by *precedence*, not judgement. Editing a Rank 6 descriptive document is not a Stage 4 act | **Architecture Owner** |
| `S4-F-07` | `FIL-GAP-010` — `platform/services` has no manifest module block, so the boundary is **unenforced** | Editing a Rank 5 manifest requires an ADR | **Architecture Owner** |
| `S4-F-08` | `FIL-GAP-004` — the audit path cannot exist because `BC-29` publishes no event | Minting an event asserts a path **L292** says does not exist | **Architecture Owner** |
| `S4-F-09` | Stage 3 record's subject hash now stale (§2) | Re-stamping it would back-date a measurement never taken | **Architecture Owner** |

**5 closed by edit · 8 deferred with a reason and a named owner · 0 closed by assertion. Gate satisfied.**

### 9.4 What this review did **NOT** find

Stated explicitly, because — in the words of the Stage 3 record — *a review that records only accepted findings is
indistinguishable from a review that found nothing.* Each of the following was **searched for and measured at
zero**:

```
vague / unfalsifiable wording in obligations ............. 0
requirements with no normative verb ...................... 0
exclusions without a prohibition verb .................... 0
acceptance criteria citing nothing ....................... 0
acceptance criteria citing an undefined identifier ....... 0
duplicate identifier definitions ......................... 0
dangling identifier citations ............................ 0
gaps in any of the 8 register ranges ..................... 0
near-duplicate requirement pairs above 0.70 .............. 0  (after S4-D-05 repair)
citation-set collisions among criteria ................... 0  (after S4-D-05 repair)
positive ownership assertions over PRD-021 territory ..... 0
business rules contradicting Rank 1 ...................... 0
V1/V2 contradictions on the sharing scope ................ 0
requirements missing an acceptance criterion (new) ....... 0
declared-vs-measured register mismatches ................. 0  (after §9.1 count repairs)
```

---

## 10. Candidate findings recorded as **REJECTED**, with reasons

| # | Candidate | Why rejected |
|---|---|---|
| `R4-1` | Add criteria for the 17 uncovered `FIL-XC-*` to reach 100% coverage | A criterion asserting that something *never* happens is unfalsifiable. `PRD-023` published **67.3%** rather than rounding to 100%; inflating coverage with unfalsifiable criteria is **worse than the honest figure** |
| `R4-2` | Give `FIL-CFG-006` a default so Check 3 passes cleanly | Would make this PRD legislate a retention policy it does not own. **A check made to pass by inventing a fact is not a passing check** |
| `R4-3` | Widen `E-22` to include `BC-12` so the sharing requirement becomes servable | Requires an accepted ADR (**L292**). A Stage 4 record is unranked. Deferred to `S4-F-02` |
| `R4-4` | Mint an `FIL-EVT-*` so the audit obligation has a mechanism | `BC-29` is a producer in **0** BC Map §9 rows. Minting one asserts a path the map says does not exist |
| `R4-5` | Remove `FIL-FR-046` since it is untestable | The obligation is real; only its *test* is impossible. `PRD-014` **L555** is the precedent for keeping it |
| `R4-6` | Correct `PRD_DEPENDENCY_GRAPH.md` **L113**'s stale *"`PRD-002` owns `BC-29`"* | Repairing an unrelated register is not a Stage 4 act, and the instruction was to *not modify unrelated documents* |

---

## 11. ⚠ Defects in **this review's own instruments**

Disclosed because an undisclosed instrument defect is indistinguishable from a finding.

| # | Defect | Effect | Resolution |
|---|---|---|---|
| `I-1` | The Check 3 probe flagged **all 9** configurables as lacking a default | **8 false positives.** The probe searched per-requirement prose; the register legitimately declares defaults in a table | Probe result discarded; the register was read directly. ⚠ **Driving the false positive to root cause is what found the real defect `S4-D-01`** — a false positive is worth investigating, not dismissing |
| `I-2` | The first census regex matched only prose-style definitions (`` `ID` — ``) and returned **0** for `FIL-CFG-*` and `FIL-GAP-*`, which are **table rows** | Would have reported a spurious `FAIL` on two registers, and a total of **210** instead of 232 | Pattern extended to both definition shapes. ⚠ **The document was correct and the tool was wrong** — the same failure mode as the bold-wrapped-row defect found at Stage 2. **When a check disagrees with a document, the check is the first suspect** |

---

## 12. The 14 requested adversarial categories, mapped

| # | Category | Decided in | Result |
|---|---|---|---|
| 1 | Ambiguity | §3.2 | ✅ 0 vague terms |
| 2 | Contradictions | §5.2, §8.2 | ⚠ **2 found, both fixed** (`S4-D-01`, `S4-D-02`) |
| 3 | Duplicate requirements | §9.2 | ⚠ **1 found, fixed** (`S4-D-05`); 0 remain |
| 4 | Missing acceptance criteria | §6.1 | ✅ 0 among new requirements; 38 structural, listed |
| 5 | Security | §7, §8 | ✅ fail-closed scanning, existence non-disclosure, no RLS invented |
| 6 | Authorization | §7.3 | ⚠ **1 found, fixed** (`S4-D-03`) — obligated party now named |
| 7 | File access | §6, §7.2 | ✅ signed-URL-only; 22 criteria touch access |
| 8 | Revocation | §8.2 | ✅ 4 criteria; terminal-state discipline verified |
| 9 | Isolation | §7.2 | ✅ 11 criteria; global-class per frozen `TEN-FR-018` |
| 10 | Auditability | §9.3 | ✅ 7 criteria; ⚠ mechanism gap deferred (`S4-F-08`) |
| 11 | Failure cases | §3, §4 | ✅ 21 criteria assert refusal/not-found/unavailability |
| 12 | Student sharing V1 consistency | §7, §8 | ✅ 0 V1/V2 contradictions; 20 criteria |
| 13 | Ownership leakage into `PRD-021` | §7.1 | ✅ **0** positive assertions |
| 14 | Untestable requirements | §3.1, §3.3 | ✅ 0 without a verb; 1 named exception with precedent |

---

## 13. What this record deliberately does **not** do

- It does **not** create an ADR, and it does **not** widen `E-22`.
- It does **not** register any `FIL-*` prefix in `TRACEABILITY_MATRIX.md` — that is Stage 5.
- It does **not** allocate an `IMPL-*` range — that is Stage 6.
- It does **not** confer rank, status or baseline — that is Stage 7, and *"freeze is conferred, not claimed."*
- It does **not** modify any Rank 1–5 document, any frozen PRD, or any file outside
  `docs/30-product/file-media/`.
- It does **not** close `FIL-GAP-012`. **The V1 sharing requirement remains specified-but-not-servable**, and no
  later stage may report otherwise.
- It does **not** re-stamp the Stage 3 record's hash.

**0 ADRs · 0 edges · 0 ranked documents touched · 0 frozen documents touched · 13 `FIL-GAP-*` still OPEN.**

---

## 14. Verdict

### **STAGE 4 VERDICT: ✅ PASS — 6 of 6 checks**

| Check | Result |
|---|---|
| 1 — Every requirement testable | ✅ PASS (1 named exception, precedent-backed) |
| 2 — Exclusions state impossibility | ✅ PASS 22/22 |
| 3 — Configurables have default + range | ✅ PASS 8/9 + 1 documented exception; **contradiction fixed** |
| 4 — Criteria map to requirements | ✅ PASS 78/78 |
| 5 — No restatement of another PRD | ✅ PASS 0 leakage; **1 defect fixed** |
| 6 — Business rules vs Rank 1 | ✅ PASS 0; **1 internal contradiction fixed** |

**Gate:** *"conflicts closed or explicitly deferred with a reason and an owner"* — **satisfied**: 5 closed by edit,
8 deferred with reasons and named owners.

⚠ **PASS is not a claim that `PRD-017` is implementable.** `FIL-GAP-012` remains open: the sharing capability is
fully specified and **cannot be served** until `E-22` admits `BC-12`, which requires an accepted ADR. Stage 5 must
**not** report architecture alignment as clean, and Stage 7 must carry the gap into the freeze record.

---

## 15. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-20 | **Created at Stage 4.** Subject `PRD-017_FILE_AND_MEDIA.md` reviewed against the six `PRD_LIFECYCLE.md` L108–120 checks and the 14 requested adversarial categories. **Verdict PASS — 6 of 6.** **5 genuine defects found and closed by edit** — §8.5's self-contradiction (`S4-D-01`), `FIL-FR-080`'s phantom `Suspended` state conflicting with `FIL-INV-010` **and** `FIL-BR-008` (`S4-D-02`), `FIL-FR-076`'s unnamed obligated party (`S4-D-03`), `FIL-FR-075`'s missing decision-reference property that made `FIL-FR-076` unimplementable (`S4-D-04`), and a duplicate criterion **this review itself wrote** (`S4-D-05`). ⚠ **Two of the five were introduced by this review's own repairs**, which is disclosed rather than smoothed over, and establishes the rule that **a review must re-run its full suite over its own additions**. `FIL-AC-063` reworded; `FIL-AC-077` and `FIL-AC-078` added; `FIL-AC-057` extended; §0.2 re-declared 76 → **78**; three stale prose counts corrected (232 identifiers, 78 criteria, 17 exclusions). **8 items deferred, each with a reason and a named owner.** **6 candidate findings rejected with reasons**, including three that would have made a check pass by inventing a fact. **2 defects in this review's own instruments disclosed** — a Check 3 probe with 8 false positives, whose investigation nonetheless found the real defect, and a census regex that under-counted two registers by 22 identifiers and would have blamed the document for the tool's error. ⚠ **This review edited its subject, departing from `PRD-023`'s Stage 4 precedent** on the authority's explicit instruction to fix defects; both subject hashes are published and **the resulting staleness of the Stage 3 record's hash is disclosed in §2, not repaired**. Verified after edits: **232 identifiers, 0 duplicates, 0 dangling, 8 contiguous ranges, declared == measured on all 8 registers, coverage 94/132 = 71.2% independently recomputed and matching the draft, 0 citation-set collisions, 0 ownership leakage.** **0 ADRs, 0 edges, 0 ranked documents, 0 frozen documents, 13 `FIL-GAP-*` still OPEN.** `PRD-017` remains **`DRAFT`**; this record confers nothing |
