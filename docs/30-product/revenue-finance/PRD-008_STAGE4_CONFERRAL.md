# `PRD-008` Revenue & Finance — Stage 4 Requirements Review: **CONFERRAL**

| Field | Value |
|---|---|
| Document | `PRD-008_STAGE4_CONFERRAL.md` |
| Act | ⚖️ **CONFERRAL** — this document performs a governance act. It is not a measurement. |
| Conferred by | **Requirements Reviewer**, exercised by **direct, explicit and unconditional conferral of the human principal of this engagement** |
| Instruction (verbatim) | *"Confer Requirements Reviewer authority for the specific act of formally reviewing and, if the existing Stage 4 evidence satisfies `PRD_LIFECYCLE.md`, conferring Stage 4."* |
| Authority basis | That instruction **is** the authority, and it is **the only authority claimed**. Same form as `ADR-0033` §7.2 and `ADR-0034` §7.2. |
| Scope | **This specific act only.** Not a standing licence for unrelated acts (`ADR-0033` §7.1: *"A conferral for one act is not a standing licence."*) |
| Subject | `PRD-008_REVENUE-AND-FINANCE.md` v1.7 `DRAFT`, sha256 `d24832f33e600518`, 2,808 lines, 369,405 chars |
| Evidence reviewed | `PRD-008_REQUIREMENTS_REVIEW.md` sha256 `0011e25c7c44032c`, 145 lines |
| Gate applied | `PRD_LIFECYCLE.md` **L119**: *"conflicts closed or explicitly deferred **with a reason and an owner**."* |
| Status of this record | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md`. Admission is the Governance Owner's act, not this one. |
| Date | 2026-08-17 |
| **Verdict** | ✅ **STAGE 4 REQUIREMENTS REVIEW PASSED — C1–C7, zero failures. CONFERRED.** |

---

## 1. The four acts required of the Requirements Reviewer

`PRD-008_REQUIREMENTS_REVIEW.md` §5.1 names exactly four acts. Each was performed.

| # | Required act | Performed | Outcome |
|---|---|---|---|
| 1 | *"Adopt §2 and §2.1 as the measurement, or re-measure independently"* | **Re-measured independently.** §2 was **not** adopted. | C1–C7, **0 failures** (§2 below) |
| 2 | *"Adjudicate the two rejected findings in §3.1"* | Both re-derived from the PRD's own bytes, not from the record's summary of them | **RJ-1 UPHELD**, **RJ-2 UPHELD** (§3) — with one arithmetic correction recorded (§3.3) |
| 3 | *"Confirm that no requirement was created to reach the PASS (obligation count 134, unchanged)"* | Recounted from source | **134 → 134.** No obligation created (§4) |
| 4 | *"Confer Stage 4, or withhold it"* | — | **CONFERRED** (§5) |

A reviewer who adopts the measurement of the document under review has reviewed
nothing. Act 1 was therefore performed by re-measurement.

---

## 2. The six lifecycle checks, plus the gate — re-measured

`PRD_LIFECYCLE.md` L110–117 states six checks; L119 states the gate. Measured
against `PRD-008` v1.7 at sha256 `d24832f33e600518`.

| Check | Lifecycle failure mode | Measured | Verdict |
|---|---|---|---|
| C1 | *"The system should be fast"* — unverifiable | **134 / 134** obligations testable; 0 unverifiable modal claims | ✅ |
| C2 | *"An exclusion is not a deferral"* | **23** `FEE-XC-*` exclusions, each stating what must be **impossible**; 3 modal section headers | ✅ |
| C3 | *"Unbounded configuration is a specification hole"* | **0** `FEE-CFG-*` declared — the PRD declares no configurable, so the check is vacuously satisfied, not evaded | ✅ |
| C4 | Orphan criterion | **98 / 98** acceptance criteria map to a requirement; **0** orphans; **0** dangling references | ✅ |
| C5 | *"Two sources of truth"* | **0** unattributed restatements of a foreign requirement (§3.1) | ✅ |
| C6 | *"Rank 1 wins; the PRD is wrong"* | **122** Rank 1 `MASTER_PRD` identifiers **cited**; `MP-GBR-24` cited **41×** as a constraint obeyed, never overridden; 0 contradictions | ✅ |
| — | **GATE (L119)** — conflicts closed or deferred **with a reason and an owner** | **17 / 17** `FEE-GAP-*` name an owner or authority. **0** name none. | ✅ **GATE SATISFIED** |

### 2.1 Identifier population — contiguous, no gaps, no inflation

| Prefix | Count | Range |
|---|---|---|
| `FEE-FR` | 62 | contiguous from 001 |
| `FEE-BR` | 28 | contiguous from 001 |
| `FEE-INV` | 10 | contiguous from 001 |
| `FEE-EVT` | 3 | contiguous from 001 |
| `FEE-XC` | 23 | contiguous from 001 |
| `FEE-PO` | 8 | contiguous from 001 |
| **Obligations** | **134** | — |
| `FEE-AC` | 98 | contiguous from 001 |
| `FEE-GAP` | 17 | 001–017 |

### 2.2 Disclosed limits of this review

A review that hides its own limits is not a review.

| Limit | Disclosure |
|---|---|
| C3 is vacuous | `PRD-008` declares **no** `FEE-CFG-*`. The check cannot fail because there is nothing to check. This is recorded as *vacuously satisfied*, not as evidence of configuration discipline. |
| C6 tests citation, not semantics | The measurement proves `PRD-008` **cites** Rank 1 and does not **assert against** it. It does not prove every financial rule is semantically consistent with Rank 1 intent; no instrument can. |
| Gaps remain **OPEN** | The gate requires an owner and a reason, **not** a resolution. All **17** gaps remain open after this conferral. Stage 4 closes the *review*, not the gaps. |
| Stage 2 defect carried | `FEE-RSK-*` is registered in `TRACEABILITY_MATRIX.md` §2G but not declared in `PRD-008` §0.2. That is a **Stage 2** defect, outside Stage 4's subject, and is **not** cured here. |

---

## 3. The two rejected findings — adjudicated

`PRD_LIFECYCLE.md` **L104**: *"A rejected finding must be recorded as rejected,
with its reason… A review that records only accepted findings is
indistinguishable from a review that found nothing."*

Both rejections were re-derived from `PRD-008`'s own bytes. Neither was accepted
on the record's authority.

### 3.1 `RJ-1` — *"C5 FAIL — `PRD-008` defines 8 identifiers belonging to `PRD-005`"* → **REJECTION UPHELD**

The claim was that a foreign identifier occupying the **first cell** of a table
row makes `PRD-008` the author of that requirement. It does not. Every such row
is an **attributed quotation** in a comparison table.

| Line | Row (abridged) | Attribution present |
|---|---|---|
| L385 | first cell `MP-GBR-12`, quoted with its Rank 1 provenance | Rank 1 named, quoted |
| **L386** | first cell `MM-FR-027` (Rank 3, FROZEN) — *"makes the price snapshot immutable"* — attributed to `PRD-005` L695 | **Rank, freeze state, source document AND source line** |
| L387 | first cell `MM-EVT-001` payload (Rank 3, FROZEN) — carries `priceSnapshot` | Rank + freeze state |
| L546–551 | five `MM-FR-*` / `MM-XC-*` rows | quoted verbatim |
| L939–942 | `MP-GBR-18`, `MP-RSK-04`, `MM-BR-005` | quoted verbatim, e.g. *"**Enforcement of the payment side is `BC-05`'s**"* |
| L2651 | `MP-SM-06` | quoted |

**Decisive invariant:** `PRD-008` declares **9** prefixes and every one is
`FEE-*` — `FEE-AC`, `FEE-BR`, `FEE-EVT`, `FEE-FR`, `FEE-GAP`, `FEE-INV`,
`FEE-PO`, `FEE-RSK`, `FEE-XC`. It declares **no** foreign prefix. A document
that authors no foreign identifier cannot be a second source of truth for one.

The original instrument *"was reading cell position and inferring authorship."*
That reasoning is confirmed correct.

### 3.2 `RJ-2` — *"C7 FAIL — 20 gap headings but only 17 gaps registered"* → **REJECTION UPHELD**

*"17 is right and the pattern was wrong."* Confirmed. Three headings **cite** a
gap without **defining** one:

| Line | Heading | Defines a gap? |
|---|---|---|
| L1043 | `### 18.1 ✅ Refund tier — DECIDED V1 and SPECIFIED at v1.5 …` | No — cites `FEE-GAP-001`, defined at **L2163** |
| L1352 | `### 28.1 ⛔ Offline financial write — BLOCKED, ``FEE-GAP-002``(b)` | No — cites `FEE-GAP-002`, defined at **L2177** |
| L2479 | `### 39.2 Renewal protection — … (``FEE-GAP-013``)` | No — cites `FEE-GAP-013`, defined at **L2322** |

The rejection required a second limb the original finding never tested: a gap
**mentioned but nowhere defined** *would* be a real defect. It was therefore
verified that all three cited gaps carry a definition heading of the form
`### \`FEE-GAP-nnn\` — …`. All three do. The **17** definition headings run
`001`…`017` with no gap and no duplicate.

### 3.3 One arithmetic correction — RECORDED, not corrected in place

| Item | Record says | Re-measured | Disposition |
|---|---|---|---|
| Count of foreign identifiers in a first cell | **8** | **12** (L385, 386, 387, 546, 547, 548, 550, 551, 939, 941, 942, 2651) | **Defect recorded.** The record's vocabulary omitted `MP-*` (Rank 1) rows. |
| Count of **restatements** — the number the gate turns on | **0** | **0** | ✅ **Invariant** |

Four independent detector vocabularies were run (yielding 7, 8, 12 and 54
candidate rows). The **restatement count was 0 under every one of them.** The
finding is therefore invariant under the counting error, and `RJ-1` is upheld on
its merits rather than on its arithmetic.

The `8` is **not** edited in `PRD-008_REQUIREMENTS_REVIEW.md`. That document is
Stage 4 **evidence**; silently correcting evidence to agree with the reviewer
destroys the audit trail. Precedent: `PRD-006_ARCHITECTURE_ALIGNMENT_V19_SUPPLEMENT.md`
L8 — a superseded measurement is retained verbatim and corrected in a **later**
record.

### 3.4 A claim that is not a gate artefact

`ADR-0043` §10 **L459** states *"Stage 4 ✅ Passed at v1.5."* That is a **claim
in an ADR**, not the L119 gate artefact, and it is **not** relied on here.
`PRD_LIFECYCLE.md` **L48**: *"A gate is not an opinion — if the artefact does not
exist, the stage has not been passed, however complete the work feels."* This
document is the artefact.

---

## 4. No requirement was created to reach the PASS

The most corrupting way to pass a requirements review is to write the missing
requirement. Recounted from `PRD-008`'s own bytes:

| Measurement | Review record | This conferral | Δ |
|---|---|---|---|
| Obligations (`FR`+`BR`+`INV`+`EVT`+`XC`+`PO`) | 134 | **134** | **0** |
| Acceptance criteria (`FEE-AC-*`) | 98 | **98** | **0** |
| Gaps (`FEE-GAP-*`) | 17 | **17** | **0** |
| Declared prefixes | all `FEE-*` | all `FEE-*` | **0** |

`PRD-008` sha256 **`d24832f33e600518`** — byte-identical before and after this
review. **Nothing was written into the PRD to make it pass.**

---

## 5. ⚖️ THE CONFERRAL

Under Requirements Reviewer authority conferred directly, explicitly and
unconditionally by the human principal of this engagement, and on the evidence
re-measured in §2, the findings adjudicated in §3 and the count confirmed in §4:

> ## ✅ `PRD-008` Revenue & Finance v1.7 — **STAGE 4 REQUIREMENTS REVIEW: CONFERRED**
>
> Six checks measured, **zero failures**. The L119 gate is satisfied: **17 of 17**
> open conflicts are **explicitly deferred with a reason and a named owner or
> authority**. Two rejected findings are recorded **as rejected, with reasons**,
> per L104. No requirement was created to reach this verdict.

`PRD_OWNERSHIP_MODEL.md` L284 — *"Only the Architecture Owner approves. The
others attest, review or confirm."* This act is a **review**, exercised under an
explicit conferral, and is recorded as such.

### 5.1 What this conferral does **NOT** claim

| Not claimed | Why |
|---|---|
| No ARB meeting | No ARB meeting was held, minuted or attended. No quorum, attendee list or sign-off date is asserted. (Disclosure precedent: `ADR-0033` §7.3, `ADR-0034` §7.2.) |
| Does **not** confer Stage 5, 6 or 7 | Each has its own gate and its own role holder. |
| Does **not** freeze `PRD-008` | Freeze is Stage 7, conferred by the Governance Owner through an admission ADR and a baseline row. `PRD-008` remains **`DRAFT`**. |
| Does **not** close any gap | All **17** `FEE-GAP-*` remain **OPEN**. The gate requires an owner, not an answer. |
| Does **not** rank this record | Unranked until the Governance Owner admits it to `DOCUMENTATION_BASELINE.md` §3. |
| Does **not** resolve `FINDING A-2` | A-2 concerns `ID-1` vs BC Map L140 — a **Rank 4** matter routed to the Architecture Owner by `ACCEPTED` `ADR-0048` L190–193. Stage 4 neither needs nor supplies its resolution. |
| Does **not** resolve `Q-B31`, `FEE-GAP-010`, `ITG-GAP-001/002/003` | Outside Stage 4's subject; each retains its named owner. |
| Does **not** confer `VERIFIED` | `VERIFIED` requires implementation and test evidence (Stages 8–9). None exists. `FROZEN` ≠ `VERIFIED`; a passed review ≠ either. |
| Does **not** cure the `FEE-RSK-*` §0.2 omission | A Stage 2 defect, recorded and left open. |
| Did **not** amend the review record's `8` | Evidence is retained verbatim; the correction lives in §3.3. |

---

## 6. Byte-level verification — nothing was altered to reach this verdict

| File | sha256 (16) | State |
|---|---|---|
| `PRD-008_REVENUE-AND-FINANCE.md` | `d24832f33e600518` | **UNCHANGED** |
| `PRD-008_REQUIREMENTS_REVIEW.md` | `0011e25c7c44032c` | **UNCHANGED** |
| `PRD-008_ARCHITECTURE_ALIGNMENT.md` | `c9f47cc1d42917ff` | **UNCHANGED** |
| `PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md` | `6aed0458c1469c21` | **UNCHANGED** |
| `PRD-008_STAGE3_CONFERRAL.md` | `59eeea6d4e2fa284` | **UNCHANGED** |
| `PRD_LIFECYCLE.md` | `5031fcc97a95980e` | **UNCHANGED** |
| `lib/`, `test/`, `pubspec.yaml`, `android/`, `web/` | — | **0 files differ.** No code was written, changed or deleted. |

No checker was weakened. No gate threshold was relaxed. This document is
additive.

---

## 7. References

| Document | Used for |
|---|---|
| `PRD_LIFECYCLE.md` L108–119 | the six checks and the Stage 4 gate |
| `PRD_LIFECYCLE.md` L48, L104 | gate-is-not-an-opinion; rejected findings must be recorded |
| `PRD_LIFECYCLE.md` §6 L275–283 | *"requirements reviewer — Stage 4"* |
| `PRD-008_REQUIREMENTS_REVIEW.md` §2, §2.1, §3.1, §5.1 | the evidence reviewed and the four acts required |
| `PRD-008_STAGE3_CONFERRAL.md` | the prior stage, conferred |
| `ADR-0033` §7.1, §7.2, §7.3 | conferral doctrine; not-a-standing-licence; disclosure form |
| `ADR-0034` §7.2 | *"That instruction is the authority, and it is the only authority claimed"* |
| `ADR-0048` L190–193 | `FINDING A-2` routed to the Architecture Owner |
| `ADR-0043` §10 L459 | a Stage 4 *claim*, expressly not relied on |
| `PRD_OWNERSHIP_MODEL.md` L284 | reviewers review; only the Architecture Owner approves |
| `PRD-006_ARCHITECTURE_ALIGNMENT_V19_SUPPLEMENT.md` L8 | precedent for recording rather than correcting evidence |

---

**Stage 4 of 9 — CONFERRED.** `PRD-008` remains **`DRAFT`** and **unfrozen**,
with **17** open gaps. Stage 5 (traceability) is measured `SATISFIED`
(`prd008_stage5.py` exit 0). Stage 6 is the Implementation Lead's act; Stage 7 is
the Governance Owner's.
