# `PRD-020` Trust & Safety — Stage 5 Traceability: **CONFERRAL**

| Field | Value |
|---|---|
| Document | `PRD-020_STAGE5_CONFERRAL.md` |
| Act | ⚖️ **CONFERRAL** — this document performs a governance act. It is not a measurement. |
| Conferred by | **Traceability Owner**, exercised by **direct, explicit and unconditional conferral of the human principal of this engagement** |
| Instruction (verbatim) | *"Continue PRD-020 Trust & Safety lifecycle advancement from the current repository state. **Do NOT create separate mini-tasks. Execute the entire next lawful critical-path sequence in one pass.** … Execute the next critical-path work in the correct lifecycle order: **Stage 5 traceability** → Stage 6 implementation/task documentation → required governance/ADR decisions → Stage 7 freeze readiness. … **Do the maximum lawful work in ONE pass.**"* |
| Authority basis | That instruction **is** the authority, and it is **the only authority claimed**. Same form as `PRD-013_STAGE5_CONFERRAL.md`, `PRD-016_STAGE5_CONFERRAL.md`, `PRD-008_STAGE4_CONFERRAL.md`, `ADR-0033` §7.2 and `ADR-0034` §7.2. |
| Scope | **This specific act only.** Not a standing licence (`ADR-0033` **L169**: *"A conferral for one act is not a standing licence."*) |
| Subject | `PRD-020_TRUST_AND_SAFETY.md` **v0.5 content under a v0.1 header, `DRAFT`, Unranked**, sha256 `685fb65af95668df9bce8757bcd7d04ec9838a56f8dd108652e80d7e7579497b`, **2,734 lines**, 226,262 bytes |
| Register | `TRACEABILITY_MATRIX.md` **v1.20** §2O (L1715, 157 lines), sha256 `bf16eb2de31d29945611ae04bf98c5bde7e2d627f1f959ec68ad096bc695cb80` |
| Instruments | `prd020_traceability.py` sha256 `ec7661e9…0c2da7c` · `prd020_stage5.py` sha256 `68e37bc7…650ac8c7` |
| Gate applied | `PRD_LIFECYCLE.md` **L122–137**: *"the PRD's prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified mechanically, **zero collisions**."* |
| Reviewed at | `940f78a47e9561709a9b674ee8c3b4a8d0107a04` |
| Status of this record | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md`. Admission is the Governance Owner's act, not this one. |
| Date | 2026-08-23 |
| **Verdict** | ✅ **STAGE 5 TRACEABILITY PASSED — gate satisfied mechanically by two independent, mutation-tested instruments, zero collisions in four directions. CONFERRED.** |

---

## 1. The gate, measured

`PRD_LIFECYCLE.md` L122–137 states four requirements. Each is measured, and the
instrument is named so that the measurement can be repeated.

| Requirement | Instrument | Measured | Verdict |
|---|---|---|---|
| Prefixes **registered** in `TRACEABILITY_MATRIX.md` §2 | `prd020_stage5.py` checks 1–2 | §2O exists at **L1715**; **9 of 9** registers hold a row | ✅ |
| **Counts** verified mechanically | `prd020_stage5.py` checks 2–3 | 9/9 counts reproduce the PRD body, recomputed by a parser that shares no code with §2O | ✅ |
| **Ranges** verified mechanically | `prd020_traceability.py` checks 1–3 | 9/9 maxima agree; all contiguous `001..max`; **0 phantoms** on all nine `max+1` probes | ✅ |
| **Zero collisions** | `prd020_stage5.py` check 5, four directions | (a) **0** · (b) **0** of 19 stems · (c) **0** near-miss · (d) **0** outward definitions | ✅ |

> *"Mechanical means counted by a tool, not by reading."* Every figure below is
> printed by a committed script. **No number in §2O was typed from analysis** —
> and §2O.4 records the two occasions in this very section where a number *was*
> typed from analysis and the instruments caught it.

### 1.1 The registers, as computed

| Register | Count | Range | Contiguous | Next free | Notes |
|---|---:|---|---|---|---|
| `TSF-FR-*` | 146 | `001`…`146` | ✅ | `147` | |
| `TSF-BR-*` | 41 | `001`…`041` | ✅ | `042` | |
| `TSF-XC-*` | 70 | `001`…`070` | ✅ | `071` | |
| `TSF-INV-*` | 21 | `001`…`021` | ✅ | `022` | |
| `TSF-EVT-*` | **2** | `001`…`002` | ⛔ **CLOSED** | ⛔ **none — ADR required** | BC Map **L432**/**L433** publish exactly two `BC-13` events; a third is a Rank 4 amendment (`TSF-GAP-004`) |
| `TSF-CFG-*` | 30 | `001`…`030` | ✅ | `031` | |
| `TSF-AC-*` | 62 | `001`…`062` | ✅ | `063` | |
| `TSF-GAP-*` | **16** | `001`…`016` | ✅ | `017` | ⚠ an earlier instrument said **8** — see §3 `I-1` |
| `TSF-RSK-*` | 12 | `001`…`012` | ✅ | `013` | |
| **Total** | **400** | | **9 of 9** | | **0 retired, 0 minted by this act** |

**400 is the subject's own §0.2 figure**, at L30–54, reached independently. The
instruments were not shown that table except in order to be able to contradict it.

### 1.2 Collisions, four directions

`PRD-016` measured three. A fourth was added here because `TSF-` is cited by
**12 files outside the subject** and an outward-citation count alone cannot tell
a citation from a definition.

| Direction | Result |
|---|---|
| **(a)** `TSF-` present in the matrix **before** this registration | **0** — measured with `grep -c 'TSF-'` at `940f78a`, published in the v1.20 changelog row. **400 identifiers were registered nowhere**: the exact condition Stage 5 exists to prevent |
| **(b)** Inward stem collision | **0** — **19** distinct prefix stems harvested from `docs/`: `AFIL ATT AUD CNF ENT FEE FIL ITG MM PROFIL SAAS SEAT SECP SID SM TEN TSF XCNF XFIL`. Containment tested **in both directions**; none contains or is contained by `TSF` |
| **(c)** Near-miss stems | **0** — `TS-`, `TSA-`, `TFS-`, `TNS-`, `TSFY-` all return no hits. This is the `PO-3`/`SPO-3` class the gate names |
| **(d)** `TSF-*` **defined** outside `PRD-020` | **0.** **12 files cite `TSF-*`; 28 distinct identifiers; 0 dangling.** Every one resolves to a definition `PRD-020` owns — the §2C.1 principle that *a citation is not a collision*. The gate resolves each hit against the defined set rather than allow-listing files, so a genuinely new outward **definition** still fails the run |

⚠ **`TSF-` was not the naive stem.** `TS-` collides with nothing today and was
rejected **before** measurement, on `PRD_LIFECYCLE.md` §5 rule 3's reasoning: a
two-letter stem in a repository already carrying `SM-`, `MM-`, `TEN-` and `SID-`
shifts the entire cost of a future collision onto whichever document arrives
second. The rejection is recorded so that it cannot later be mistaken for an
oversight.

---

## 2. Why the two instruments can disagree with each other

`TRACEABILITY_MATRIX.md` §2H.2 names the failure mode this pair exists to avoid:
*"a checker written in the same pass as the register it checks, by the same
author, verifies agreement with itself."*

| Instrument | Subject | Opens the matrix? | Strategy |
|---|---|---|---|
| `prd020_traceability.py` | `PRD-020` against **itself** — §0.2's declarations against the body | **No, never** | Distinct-token occupancy across the whole file, deduplicated per register |
| `prd020_stage5.py` | §2O against **the PRD body**, recomputed | Yes | Parses §2O's table cells, then recomputes from the PRD by an independent route and compares cell by cell |

`prd020_stage5.py` does not import from `prd020_traceability.py`. Both arrive at
**400**. That is evidence; agreement by one route repeated twice would not be.

### 2.1 Mutation-tested, because a gate that cannot fail is not a gate

Seven deliberate defects were injected and both instruments re-run. Every
mutation was reverted with `git checkout --` and **both documents verified
byte-identical by sha256 afterwards**.

| # | Mutation | `prd020_traceability.py` | `prd020_stage5.py` | Correct? |
|---|---|---|---|---|
| **M1** | §2O `TSF-FR-*` count `146` → `145` | pass | **fail** | ✅ matrix-only defect |
| **M2** | §2O total `400` → `399` | pass | **fail** | ✅ arithmetic recomputed, not trusted |
| **M3** | §2O deleted entirely | pass | **fail** | ✅ *"the absence IS the Stage 5 failure"* |
| **M4** | `TSF-EVT-*` next-free `none — ADR required` → `003` | pass | **fail** | ✅ closed-register rule; the `I-4` class, now permanently gated |
| **M5** | PRD contiguity broken (`TSF-RSK-012` → `099`) | **fail** | **fail** | ✅ PRD-internal defect, both own it |
| **M6** | A dangling `TSF-FR-*` citation — a number far past the register's maximum — injected into `ADR-0065`. ⚠ **The token is deliberately not reproduced here**; see `I-5` | **fail** | pass | ✅ outward-citation defect, first instrument only |
| **M7** | `TSF-AC-010`'s requirement citations stripped | **fail** | pass | ✅ subject-integrity defect, first instrument only |

All seven caught, each by the instrument that owns that class.

⚠ **M6 and M7 are the rows that matter for independence**: defects exist that
only the first catches, and defects exist that only the second catches. Had every
mutation been caught by both, that would evidence duplication rather than rigour.

⚠ **M4 was not a hypothetical.** It is a replay of a defect this section
actually committed (§3 `I-4`), converted into a standing gate. `prd020_stage5.py`
now fails any closed register that publishes a numeric next-free cell.

### 2.2 The instrument was proven able to fail before it was trusted

`prd020_stage5.py` was executed **before §2O existed** and exited **1** with
*"has no `## 2O.` section"*. It then failed twice more during authoring, each
time on a real defect (§3). A gate whose first observed behaviour is a pass has
not been shown to be a gate at all.

---

## 3. Five defects, recorded — **all five in the instruments or in my own prose, none in the subject**

Recorded rather than quietly patched, because an instrument's failure history is
evidence about the instrument. **In none of the five was `PRD-020` wrong.**

| # | Defect | Consequence had it shipped |
|---|---|---|
| **`I-1`** | **Definition-row counting.** A census counting *definition rows* returned `TSF-GAP-*` = **8** against a subject declaring **16**, because **8 of the 16 gaps are defined mid-sentence** (`` `TSF-GAP-009` **OPEN** — no referral transport exists… ``) — a legitimate prose form the regex did not model. Re-measured by **distinct-token occupancy**: **16, contiguous**. ⛔ **Publishing 8 would have registered a false count for a live register.** ⚠ The identical blind spot is already recorded as `I-1` in `PRD-020_STAGE4_REQUIREMENTS_REVIEW.md` §5, where it falsely flagged `TSF-CFG-030` and `TSF-BR-030` as undefined — *a disclosed defect that recurs in a later instrument is evidence the disclosure was not read, including by its own author* |
| **`I-2`** | **`IMPL-1450` flagged as a phantom** by a `max+1` probe. Inspected at **L2434** it reads *"`IMPL-1450`…`1499` **reserved** for the V2 community work of §25"* — a range-boundary reservation that allocation **rule 2 positively requires**. **Rejected as a finding**, on the §2C.1 principle that a token must be read at its line, not counted. Had it been "fixed", a lawful growth reserve would have been deleted |
| **`I-3`** | **A hand-typed count beside contradicting evidence.** §2O.1 read *"**20** stems observed"* next to a list naming **19**. `prd020_stage5.py` recomputed 19 and failed the run. Corrected to 19 |
| **`I-5`** | ⛔⛔⛔ **`I-4` RECURRED IN THIS VERY DOCUMENT, in the table disclosing it.** §2.1's M6 row named the dangling token it had injected — writing a live phantom `TSF-FR-*` citation into the repository inside a record whose subject is phantom identifiers. `prd020_traceability.py` failed the conferral itself, as a dangling reference in `PRD-020_STAGE5_CONFERRAL.md`. **This is the fourth recorded instance of the self-referential phantom, the second within this Stage 5 work, and it was committed by an author who had just written `I-4` three paragraphs earlier and had also written the gate that caught it.** ⚠ The lesson is not that the author is careless — it is that *this defect is not preventable by intention*, which is exactly why it must be gated mechanically rather than warned about. Fixed by the `PRD-012a` Part 8 §1.3 remedy: M6 now describes the token's *position* without reproducing it |
| **`I-4`** | ⛔⛔ **A phantom identifier written by the table that declares its register closed.** The `TSF-EVT-*` "next free" cell read `003` — the arithmetic answer. A closed register has **no** next free member until an ADR says so. `prd020_traceability.py` failed it as a dangling reference. This is the **third** recorded instance of the self-referential phantom (§2N.3.1 records two for `PRD-012a`), **written by an author who had read that warning in the same file hours earlier.** Fixed in three places: the cell now states the governance answer; the disclosing prose describes the token's *position* without reproducing it (the `PRD-012a` Part 8 §1.3 remedy); and the rule is now **mechanically enforced** — see M4 |

**No PRD content was changed to make an instrument pass.** Where an instrument
and the document disagreed, the document was re-read and the instrument
corrected — the direction `PRD-013_STAGE5_CONFERRAL.md` §3.2 records as correct.
`PRD-020_TRUST_AND_SAFETY.md` re-hashes to `685fb65a…497b`, **byte-unchanged
since `940f78a`**.

---

## 4. ⚠⚠ The disclosure that distinguishes this conferral from every predecessor

**Acceptance coverage is 40.6% — the lowest ever registered in this matrix — and
it is registered at that figure rather than repaired to a flattering one.**

| Measure | Value |
|---|---|
| Normative requirements (`TSF-FR-*` + `TSF-BR-*`) | **187** |
| Covered by at least one of three binding routes | **76** |
| **Uncovered** | **111** — 83 `TSF-FR-*`, 28 `TSF-BR-*` |
| **Coverage** | **76 / 187 = 40.6%** |
| Acceptance criteria defined | 62 |
| Criteria named in a §30 task row | 32 of 62 |
| Distinct requirements cited by AC rows | 75 |

**Sub-100% precedent was measured before being relied upon**, not assumed:

| Section | Subject | Registered coverage |
|---|---|---|
| §2C | — | 94.6% |
| §2E | `PRD-007` | **73.4%** |
| §2M | `PRD-017` | **71.2%** |
| §2D | `PRD-005` | **60.1%** |
| §2F | `PRD-006` | corrected a false *"100%"* against a true **49.1%** |

Stage 5's gate is *"prefixes registered … with counts and ranges, verified
mechanically, zero collisions"*. **Coverage is not in it.** What the gate forbids
is an *unmeasured or overstated* figure — the `PRD-006` v1.0 error.

⚠⚠ **The obvious fix was available and is refused, and the refusal is the
finding.** Minting 111 `TSF-AC-*` would take the register 62 → 173, falsify every
count in §2O, and satisfy a gate nobody applied — while repeating **at larger
scale** the precise error Stage 4 caught in this same module days earlier, where a
new `TSF-FR-*` was nearly minted for `TSF-AC-010` before **`TSF-FR-099` was found
already stating the obligation** (`PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` §4,
a **retracted** finding). *A fix that moves a percentage by creating identifiers
is not a fix; it is the defect Stage 5 registers against.*

The 111 are **named by register** in §2O.2 and routed to `SID-4.56` and
`IMPL-1449`. **This conferral does not certify coverage.**

---

## 5. Disclosed limits of this conferral

A conferral that hides its own limits is not a conferral.

| Limit | Disclosure |
|---|---|
| **Coverage is 40.6%** | §4. Registration, not coverage, is the gate. Not certified here |
| **0 of 62 criteria proven** | `IMPL-1410` is built and tested, but no acceptance criterion is discharged by a passing test that names it. **Registered is not verified** |
| **All 16 `TSF-GAP-*` remain OPEN** | Stage 5 closes the *registration*, not the gaps. This includes the **implementation half of `TSF-GAP-003`**, which `TSF-BR-033` and §24.2 **L2046** make a bar to `READY` |
| `TSF-EVT-*` is **CLOSED, not empty** | Two members exist. Its closure is an external fact from BC Map **L432**/**L433**, not evidence of event discipline. Extending it is a **Rank 4 amendment requiring an ADR** |
| **Subject header says v0.1, content is v0.5** | ⚠ **Published, not normalised.** Amending the subject's version field is a **document-owner act** and is not performed here |
| `PRD-020` is **`PLANNED`** | `PRD_REGISTRY.md` **L320**. This conferral does **not** move it to `DRAFT`; **L317** rules that editing that row is *"an amendment act requiring amendment authority"* |
| **Unranked** | `DOCUMENTATION_BASELINE.md` contains **0** occurrences of `PRD-020`. Admission is the Governance Owner's act |
| **No baseline re-issue** | §7 rule 4 moves the baseline identifier only on a **Rank 1–3** version change. This matrix is unranked, so it confers nothing; the `Baseline` field still reads `BASELINE-2026-08-04-D`, on the §2G precedent |
| `PGA-08` **not cured** | The repository still has no standing named owner for any PRD. This is a **per-act** conferral |
| Stage 3 and Stage 4 verdicts | Both **PASS 6/6**, recorded in their own artefacts. This record confers **Stage 5 only** and upgrades neither |

---

## 6. Reproducible commands

```
python3 tool/docs_check/prd020_traceability.py   # exit 0 = PRD-020 agrees with itself
python3 tool/docs_check/prd020_stage5.py         # exit 0 = the matrix agrees with PRD-020
sha256sum docs/30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md
sha256sum docs/40-implementation/TRACEABILITY_MATRIX.md
git status --short lib/ packages/ test/          # expect 0 lines
```

Both exit **0** at the hashes in this record's header.

---

## 7. Containment audit

| Question | Answer |
|---|---|
| Implementation code modified? | **No** — `git status --short lib/ packages/ test/` returns **0 lines** |
| `PRD-020_TRUST_AND_SAFETY.md` modified? | **No** — `685fb65a…497b`, byte-unchanged since `940f78a` |
| Stage 3 / Stage 4 records modified? | **No** — all three byte-unchanged |
| Existing matrix sections modified? | **No** — §2 through §2N byte-unchanged; the diff is an insertion at L1715 plus the header Version field and one changelog row |
| Pre-existing gate scripts modified? | **No** — every prior `tool/docs_check/*.py` byte-unchanged |
| Pre-existing failing checkers repaired? | **No** — the known exit-1 checkers remain failing for their own recorded reasons |
| Any ADR, `PRD_REGISTRY.md` or `DOCUMENTATION_BASELINE.md` modified? | **No** — all **65** ADR files byte-unchanged |
| BC Map, Module Dependency Matrix, `module_dependencies.yaml` modified? | **No** |
| Any identifier minted, retired or renumbered? | **No** — **0 minted**, 0 retired, 400 in force |
| `IMPL-*` range allocated? | **No** — that is Stage 6 |
| `TSF-GAP-003` closed? | **No** — the implementation half requires an **Architecture Owner** ADR that does not exist |
| Freeze or `READY` claimed? | **No** — §24.2 **L2046** forbids it while `TSF-GAP-003` stands |
| Baseline identifier re-issued? | **No** |

---

## 8. Verdict

✅ **STAGE 5 CONFERRED.** The gate is satisfied on its own terms: the `TSF-*`
prefix stem is registered in `TRACEABILITY_MATRIX.md` §2O with counts and ranges
for all nine registers, verified mechanically by two committed instruments that
neither share code nor import one another and that were mutation-tested against
seven injected defects, with zero collisions in four directions.

**What this does not confer:** not Stage 6, not rank, not freeze, not `READY`,
not verification, and not coverage. **16** gaps remain open, coverage is
**40.6%**, **0 of 62** criteria are proven by a passing test that names them, and
`PRD-020` remains **`PLANNED`** and **Unranked**.

**Stage 5 of 9. Stage 6 may now be entered.**

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| 1.0 | 2026-08-23 | Created. Stage 5 gate conferred: 9 registers, **400** identifiers, all contiguous, 0 phantoms, 0 dangling, zero collisions in four directions. Seven mutations injected and caught; both documents restored byte-identical. **Five defects disclosed — `I-1` through `I-5` — all in the instruments or in the registering author's own prose, none in the subject.** ⛔⛔ **`I-5` is a recurrence of `I-4` inside the very table disclosing `I-4`**, caught by this record's own instrument; the conferral failed its own gate once before passing. ⚠⚠ Coverage registered at its true **40.6%**, the lowest in this matrix, with the 111 uncovered obligations named rather than papered over by minting identifiers. **Subject byte-unchanged. 0 identifiers minted.** |
