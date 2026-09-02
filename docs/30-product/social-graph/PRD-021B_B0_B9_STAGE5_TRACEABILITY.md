# PRD-021B B0–B9 — Consolidated Stage 5 Traceability Review

| Field | Value |
|---|---|
| **Record** | `PRD-021B_B0_B9_STAGE5_TRACEABILITY.md` **v1.0** |
| **Stage** | **5 of 9 — Traceability** (`PRD_LIFECYCLE.md` **L121–133**) |
| **Subjects** | Ten documents in `docs/30-product/social-graph/` — `PRD-021B` Parts **B0–B9**, all `DRAFT`, all **Unranked** — **6,613 lines / 352,765 bytes**, sha256 per part at §15.1. ⛔ **All ten are byte-identical to the bytes Stage 3 and Stage 4 measured** |
| **Verdict** | ⭐ **PASS — 4 of 4 gate conjuncts**, satisfied by the `TRACEABILITY_MATRIX.md` **§2Q** registration written in this same commit. See §16 |
| **Registration** | `docs/40-implementation/TRACEABILITY_MATRIX.md` **§2Q** (matrix **v1.21 → v1.22**) |
| **Measured** | **113 registers · 1,300 identifiers · 113/113 contiguous from `001` · ZERO collisions in five directions** |
| **⛔ Not entered** | **Stage 6, freeze, implementation.** §17 refuses each explicitly and names the owner who could confer it |

---

## 1. The gate, quoted, and decomposed into testable conjuncts

`PRD_LIFECYCLE.md` **L123–124**, verbatim:

> **Gate:** the PRD's prefixes registered in [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md)
> §2 with counts and ranges, verified mechanically, **zero collisions**.

**L126–127**, verbatim:

> Mechanical means counted by a tool, not by reading. §2B records nine registers verified *"contiguous from 1 to
> its stated maximum"*.

**L129–133**, verbatim — the near miss that gives this stage its purpose:

> **The near-miss worth knowing about.** `PO-1`…`PO-12` are protected operations behind the **public library
> preview** — an anonymous read surface. `SPO-1`…`SPO-9` are protected operations on a **Global Person Identity**
> — authenticated writes. Two candidate prefixes were changed during authoring to prevent collisions, and the
> matrix notes that citing `PO-3` when `SPO-3` was meant *"would move a requirement from one bounded context to
> another."* This stage exists for that class of error, which no amount of careful reading reliably catches.

The gate is one sentence carrying **four separable obligations**. They are tested separately, because a review
that reports a single blended verdict cannot say *which* obligation failed:

| # | Conjunct | Where tested | Result |
|---|---|---|---|
| **1** | the prefixes are **registered in `TRACEABILITY_MATRIX.md` §2** | §2 (the pre-state), §16 | ⛔ **UNMET before this commit** → ✅ met by §2Q |
| **2** | **with counts and ranges** | §4, §2Q.0 | ✅ 113 registers, each with count, range, contiguity and next-free |
| **3** | **verified mechanically** | §4, §5, §15.2 | ✅ counted by five scripts, not by reading |
| **4** | **zero collisions** | §6 | ✅ zero in all five directions |

⚠ **Coverage is not one of the four.** §9 measures and publishes it anyway, at **53.4%**, because Stage 5 forbids
an *unmeasured or overstated* figure rather than a low one. See §9's refusal.

---

## 2. The decisive fact: before this commit, 1,300 identifiers were registered nowhere

The first conjunct is a question about the matrix, not about the subjects. It was measured before anything was
written, with its command published so a reader can reproduce it:

```
$ grep -c "PRD-021B" docs/40-implementation/TRACEABILITY_MATRIX.md
0
```

Ten further probes, one per stem, over the whole 2,728-line matrix:

| Stem | Part | Occurrences in matrix (pre-commit) |
|---|---|---|
| `XPA-` | B0 | **0** |
| `SGR-` | B1 | **0** |
| `SSF-` | B2 | **0** |
| `SDS-` | B3 | **0** |
| `DRK-` | B4 | **0** |
| `PYK-` | B5 | **0** |
| `GLS-` | B6 | **0** |
| `MSG-` | B7 | **0** |
| `RTM-` | B8 | **0** |
| `TPA-` | B9 | **0** |

⛔⛔ **So 1,300 identifiers across 113 registers were registered nowhere** — the exact condition Stage 5 exists to
prevent. The honest pre-registration answer to this gate was **BLOCKED on conjunct 1**, and it is recorded here as
such rather than skipped now that the registration exists. §16 states the resulting conditionality plainly.

---

## 3. Scope, and the two conventions every count in this record depends on

### 3.1 The ten subjects

| Part | Stem | File |
|---|---|---|
| B0 | `XPA-` | `PRD-021B_B0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md` |
| B1 | `SGR-` | `PRD-021B_B1_SOCIAL_GRAPH_DRAFT_v0.1.md` |
| B2 | `SSF-` | `PRD-021B_B2_SOCIAL_SAFETY_DRAFT_v0.1.md` |
| B3 | `SDS-` | `PRD-021B_B3_STUDENT_DISCOVERY_DRAFT_v0.1.md` |
| B4 | `DRK-` | `PRD-021B_B4_DISCOVERY_RANKING_DRAFT_v0.1.md` |
| B5 | `PYK-` | `PRD-021B_B5_STUDENT_RECOMMENDATIONS_DRAFT_v0.1.md` |
| B6 | `GLS-` | `PRD-021B_B6_DISCOVERY_SCOPE_DRAFT_v0.1.md` |
| B7 | `MSG-` | `PRD-021B_B7_MESSAGING_DRAFT_v0.1.md` |
| B8 | `RTM-` | `PRD-021B_B8_REALTIME_MEDIA_SAFETY_DRAFT_v0.1.md` |
| B9 | `TPA-` | `PRD-021B_B9_TECHNICAL_PRODUCTION_ARCHITECTURE_DRAFT_v0.1.md` |

### 3.2 Census convention — distinct-token occupancy

⚠ Every count in this record and in §2Q is taken by **distinct-token occupancy**, not by definition site. This is
not a preference; it is a defect avoidance adopted from **§2P.0**, which records its own reason:

> §2O.4 defect `I-1` records a census that counted definition rows and undercounted a live register by half,
> because members defined mid-sentence were invisible to it.

B0–B9 define register members in prose as well as in tables, so a definition-site census would have undercounted
here too.

### 3.3 Requirement classification — carried, not re-derived

Stage 4 settled which registers are normative. That determination is **reused unchanged**, per the instruction not
to reopen valid decisions:

- **Normative:** `FR` `BR` `INV` `XC` `SEC` `PRV` `API` `EVT` `DM` `IDX` `PERF` `CACHE` `EC` `SCOPE` `RM` `DEP`
  `BND` `PREC` `POL` `SUP` `SIG` `DET` `EVAL` `EXP` `FB` `FRQ` `PRS` `SRC` `DEF` `CFG` `PRIN` `GOAL`
- ⛔ **Not requirements:** `GAP` `FOD` `ACGAP` `FUT` `CONF` `DRIFT`

### 3.4 The coverage denominator, and a trap avoided

⚠⚠ **§8 and §9 use different denominators, and publishing either without its denominator would manufacture a false
number.** §8 counts distinct requirements cited by at least one AC across the **full normative pool** — **375**.
§9 measures coverage against **FR+BR only** — **365** — because that is §2P's published convention
(*"Normative requirements: 757 (`*-FR-*` 710 + `*-BR-*` 47)"*).

⛔ **375 ÷ 365 = 102.7%.** Had the two been combined by inattention, this record would have published a coverage
figure **above 100%** — a flattering number produced by accident rather than by measurement. Both figures are
therefore published with their denominators stated in the same sentence, everywhere they appear.

---

## 4. Conjuncts 2 and 3 — counts and ranges, verified mechanically

Measured by `/tmp/s5_census.py` over the ten subjects:

| Measure | Value |
|---|---|
| **Registers** | **113** |
| **Identifiers** | **1,300** |
| **Contiguous from `001`** | **113 of 113** |
| **Non-contiguous** | **0** |

⭐ **113 of 113 is a stronger result than the precedent it follows** — §2P registered **104 of 105**, its one
exception being A1's deliberately preserved unassigned number. B0–B9 have no such exception to preserve.

### 4.1 Registers and identifiers per part

| Part | Stem | Registers | Identifiers | FR | BR | AC |
|---|---|---|---|---|---|---|
| B0 | `XPA-` | 4 | 22 | 0 | 0 | 0 |
| B1 | `SGR-` | 14 | 183 | 27 | 18 | 30 |
| B2 | `SSF-` | 14 | 174 | 27 | 22 | 28 |
| B3 | `SDS-` | 14 | 161 | 17 | 19 | 32 |
| B4 | `DRK-` | 14 | 133 | 14 | 11 | 26 |
| B5 | `PYK-` | 16 | 135 | 6 | 5 | 24 |
| B6 | `GLS-` | 12 | 100 | 11 | 8 | 20 |
| B7 | `MSG-` | 10 | 137 | 33 | 17 | 30 |
| B8 | `RTM-` | 7 | 109 | 30 | 20 | 28 |
| B9 | `TPA-` | 8 | 146 | 31 | 49 | 24 |
| **Total** | — | **113** | **1,300** | **196** | **169** | **242** |

⚠ **B0 mints 0 FR and 0 BR and this is not an omission.** B0 is the cross-part architecture and open-decisions
part; its four registers are `XPA-ACGAP-*` (3), `XPA-BND-*` (6), `XPA-DEP-*` (6) and `XPA-PREC-*` (7). It
allocates and constrains rather than requiring — see §11.1, where B0 §2 is identified as the **ownership
allocation instrument** for the whole set.

### 4.2 Grand register totals

`AC` 242 · `FR` 196 · `BR` 169 · `XC` 156 · `EC` 86 · `SEC` 51 · `API` 42 · `PRV` 36 · `SCOPE` 31 · `GAP` 30 ·
`CFG` 29 · `DM` 28 · `PERF` 21 · `CACHE` 20 · `INV` 20 · `EVT` 15 · `IDX` 10 · `SIG` 10 · `PRIN` 9 · `POL` 8 ·
`SUP` 8 · `FUT` 8 · `PREC` 7 · `PRS` 7 · `SRC` 7 · `BND` 6 · `DEP` 6 · `DET` 6 · `EXP` 6 · `FB` 6 · `FRQ` 6 ·
`DEF` 6 · `EVAL` 5 · `GOAL` 4 · `ACGAP` 3.

**FR 196 + BR 169 = 365 normative requirements. 242 acceptance criteria.**

⚠ The per-register counts, ranges, contiguity flags and next-free cells for all **113** registers are published
**once**, in `TRACEABILITY_MATRIX.md` **§2Q.0**, and are not duplicated here. See §14.1 for why.

---

## 5. Phantom probe — is any register cited one past its maximum?

The `max+1` probe is the mechanical form of the question *"does a citation exist for an identifier nobody minted?"*
It was run against **every one of the 113 registers**:

| Probe | Registers tested | Hits |
|---|---|---|
| `STEM-REG-{max+1}` cited anywhere in B0–B9 | **113** | **0** |

**0 phantoms.** No part cites one past any register's ceiling.

---

## 6. Conjunct 4 — zero collisions, measured in five directions

Five directions, following §2O.1 as extended by §2P.1 for a multi-document subject:

| Dir | Question | Measured | Result |
|---|---|---|---|
| **(a)** | Is any of the ten stems already present in the matrix? | 10 probes over 2,728 lines | **0** — see §2 |
| **(b)** | Does any stem collide with a foreign stem already in use? | **465 files** scanned, **42** distinct stems observed, **32** foreign, containment-tested **both ways** | **0 collide** |
| **(c)** | Does a near-miss variant of any stem resolve to something? | **20** probes | **0**, each with a control — §6.1 |
| **(d)** | Does any part cite a foreign token that resolves nowhere? | **89** distinct foreign tokens | **0 unresolved** — §7 |
| **(e)** | Does any part cite a **sibling's** identifier the sibling never minted? | **196** cross-part citations | **0** |

⭐ Direction **(e)** is the one a single-document subject cannot fail. Ten documents that cite one another 196 times
can fail by citing a sibling identifier that does not exist; all 196 were resolved against the owning part's
occupancy set.

The 32 foreign stems observed in direction (b): `A1` `AFIL` `ATT` `AUD` `CNF` `ENT` `FEE` `FIL` `INV` `ITG` `LCF`
`LCG` `LCM` `LCN` `LCO` `LCR` `LCS` `LCT` `LIB` `MM` `PROFIL` `SAAS` `SEAT` `SEC` `SECP` `SID` `SM` `TEN` `TSF`
`XCNF` `XFIL` `XPB`. **Containment collisions in both directions: 0.**

### 6.1 The falsifiability control — because a negative that cannot go positive proves nothing

§2P.1 records the rule as `J-4`: fourteen unfalsifiable zeroes were published before a control was added. Every
zero in direction (c) is therefore published **beside the control that proves the probe fires**:

| Near-miss probe | Hits | Control (real stem, same probe shape) | Control hits |
|---|---|---|---|
| `XP-` | 0 | `XPA-` | **26** |
| `SG-` | 0 | `SGR-` | **343** |
| `SS-` | 0 | `SSF-` | **306** |
| `SD-` | 0 | `SDS-` | **361** |
| `DR-` | 0 | `DRK-` | **324** |
| `PY-` | 0 | `PYK-` | **305** |
| `GL-` | 0 | `GLS-` | **226** |
| `MS-` | 0 | `MSG-` | **347** |
| `RT-` | 0 | `RTM-` | **303** |
| `TP-` | 0 | `TPA-` | **260** |
| `XPAS-` `SGRS-` `SSFS-` `SDSS-` `DRKS-` `PYKS-` `GLSS-` `MSGS-` `RTMS-` `TPAS-` | **all 0** | (as above) | — |

Twenty probes, twenty zeroes, ten controls all firing.

### 6.2 ⭐ The `XPA-` / `XPB-` near miss — this stage's own `PO-3`/`SPO-3`

The direction (c) probes were built to catch exactly the shape the gate's own near-miss note describes, and here
they caught one:

| Test | Result |
|---|---|
| `XPA-[A-Z]{2,6}-\d{3}` matched against `XPB-CONF-001` | **False** |
| `XPB-[A-Z]{2,6}-\d{3}` matched against `XPA-PREC-001` | **False** |
| Containment collisions, both directions | **0** |
| ⚠ bare substring `'XP'` matched against `XPA-PREC-001` **and** `XPB-CONF-001` | **True, True** |

The two families are **disjoint in shape, verified both ways**, so this is recorded as a **clean measurement plus a
standing obligation**, not a clean bill:

> ⚠ **Any checker touching this family MUST anchor on `XPA-` with the hyphen — never on `XPA` and never on `XP`.**

This is the `LCFG-`/`LCF-` hazard of §2P in a second instance. The substantive finding about `XPB-` — that it is an
**eleventh stem no part owns** — is at §12.1.

---

## 7. Direction (d) — foreign citation resolution

**89 distinct foreign tokens are cited by B0–B9. All 89 resolve to a definition owned by another document. 0 are
unresolved.**

| Foreign stem | Distinct tokens cited | Resolved | Unresolved |
|---|---|---|---|
| `FEE-` | 1 | 1 | **0** |
| `FIL-` | 18 | 18 | **0** |
| `LCM-` | 8 | 8 | **0** |
| `LCN-` | 2 | 2 | **0** |
| `LCR-` | 8 | 8 | **0** |
| `MM-` | 4 | 4 | **0** |
| `TSF-` | 31 | 31 | **0** |
| `XPB-` | 17 | 17 | **0** |
| **Total** | **89** | **89** | **0** |

### 7.1 The 15 declaration-shaped foreign lines — all read at source, all citations

A minting test (*is a foreign token in a row's leading cell or at line start?*) returned **15** candidate lines.
⛔ A count alone would have produced a false finding of foreign minting in eight files. **All 15 were read at their
line**, per §2C.1's principle that a token must be read where it sits:

| # | Location | Token | Read at source — what it actually is |
|---|---|---|---|
| 1 | B2 **L353** | `TSF-XC-021` | Quotes `PRD-020`'s exclusion **verbatim** as inherited authority. Citation |
| 2 | B5 **L249** | `TSF-FR-023` | Quotes FROZEN `PRD-020` **verbatim** as the governing rule. Citation |
| 3 | B7 **L620** | `LCN-FR-019` | Probe-table row recording it as **`VOID`** at A7 **L459**. Citation of a withdrawal |
| 4–9 | B7 **L882–887** | `XPB-CONF-006/010/011/014/015/016` | §B7.19 disposition table, header `\| ID \| Item \| Disposition \| Owner \|`. Citation |
| 10–14 | B8 **L762–766** | `XPB-CONF-007/008/009/013/017` | Same disposition-table form. Citation |
| 15 | B9 **L934** | `XPB-CONF-012` | Same disposition-table form. Citation |

**Genuine foreign minting: 0.** Every one of the 15 is a citation or a disposition row whose subject is defined
elsewhere. The `XPB-CONF-*` rows are the reason §12.1 exists — they cite a family, and the family has no owner.

---

## 8. Mapping direction — AC → requirement

| Measure | Value |
|---|---|
| **Total acceptance criteria** | **242** |
| **Requirement-backed (valid citation)** | **242** |
| ⛔ **Orphan ACs (no requirement cited)** | **0** |
| ⛔ **Gap-backed ACs (citing a `*-GAP-*` as if normative)** | **0** |
| ⛔ **Dangling own-stem citations** | **0** |
| ⛔ **Duplicate GWT triples** | **0** |
| Distinct requirements cited by ≥1 AC (**full normative pool**) | **375** |

Per part, all with zero orphans:

| Part | ACs | Orphans |
|---|---|---|
| B1 | 30 | 0 |
| B2 | 28 | 0 |
| B3 | 32 | 0 |
| B4 | 26 | 0 |
| B5 | 24 | 0 |
| B6 | 20 | 0 |
| B7 | 30 | 0 |
| B8 | 28 | 0 |
| B9 | 24 | 0 |
| **Total** | **242** | **0** |

### 8.1 The AC form split — why a table-only probe would report 82 malformed ACs

⚠ The ten subjects use **two** acceptance-criterion forms, and an instrument modelling only one declares the other
broken:

| Form | Parts | ACs | Shape |
|---|---|---|---|
| **Table** | B0–B6 | **160** | 5-column `\| ID \| Given \| When \| Then \| Requirement \|` |
| **Prose** | B7, B8, B9 | **82** | inline `**Given**` / `**when**` / `**then**` with a parenthesised citation |

Both forms were parsed. A table-only probe would have reported **82 malformed ACs** — a false finding about a
third of the set. Neither form is a defect; the split is recorded so the next instrument does not rediscover it.

⚠ `SSF-AC-028` (B2 **L563**) is prefixed by `⛔` in its ID cell. This is an **instrument** hazard, recorded at
§15.3 as `I5-4`'s sibling in Stage 4's ledger (`I4-4`), not a subject defect — the AC is well-formed and
requirement-backed.

---

## 9. ⭐⭐ Reverse direction — orphan requirements, and the coverage figure

§8 measures whether every AC has a requirement. That is the flattering direction, and it returns a perfect
242/242. The **reverse** question — does every requirement have an AC? — was measured separately, because a review
that reports only the first direction reports only the half that passes.

| Measure | Value |
|---|---|
| **FR+BR universe (distinct tokens)** | **365** |
| **COVERED — cited by ≥1 AC** | **195** |
| ⚠⚠ **UNCOVERED — orphan requirements** | **170** |
| **Coverage** | **195 / 365 = 53.4%** |
| Foreign FR/BR cited by an AC | **0** |

### 9.1 Per part

| Part | FR+BR | Covered | Uncovered | Coverage |
|---|---|---|---|---|
| B0 | 0 | — | — | *mints no FR/BR* |
| B1 | 45 | 22 | 23 | 48.9% |
| B2 | 49 | 24 | 25 | 49.0% |
| B3 | 36 | 17 | 19 | 47.2% |
| B4 | 25 | 12 | 13 | 48.0% |
| **B5** | **11** | **2** | **9** | ⚠ **18.2%** |
| B6 | 19 | 13 | 6 | 68.4% |
| B7 | 50 | 34 | 16 | 68.0% |
| B8 | 50 | 35 | 15 | 70.0% |
| B9 | 80 | 36 | 44 | 45.0% |
| **Total** | **365** | **195** | **170** | **53.4%** |

### 9.2 Where 53.4% sits on this matrix's published ladder

§2C **94.6%** · §2E **73.4%** · §2M **71.2%** · §2D **60.1%** · **B0–B9 53.4%** · §2O **40.6%** · §2P **27.2%**.

It is neither the highest nor the lowest ever registered. It is registered **at its measured value**.

### 9.3 B5 at 18.2% — diagnosed, not repaired

B5 mints **6 FR + 5 BR = 11** normative requirements against **24** ACs. Its ACs overwhelmingly bind to
`PYK-POL-*`, `PYK-PRS-*`, `PYK-SRC-*`, `PYK-FB-*` and `PYK-FRQ-*` — registers the FR+BR denominator excludes **by
construction**. So B5's low figure is a property of the denominator meeting an unusually policy-shaped part, not
evidence of missing acceptance work.

⛔ **The denominator was NOT widened to fix it.** Widening it to the full normative pool would raise every figure
in §9.1 without a single AC being written. *Changing a denominator to move a number is the same act as minting
criteria to move it.*

### 9.4 ⛔ The 170 criteria are NOT minted, and the refusal is the finding

The obvious remedy — mint an AC for each of the 170 uncovered requirements — was available and is refused, on four
independent grounds:

1. **It falsifies this record and §2Q.** The AC register goes **242 → 412**, breaking every count in §4, §8 and
   §2Q.0 in the same commit that publishes them.
2. **It is not this reviewer's act.** Authoring acceptance criteria is a **Product Owner** act. Stage 5 registers
   identifiers; it does not write requirements.
3. **The gate does not ask for it.** Coverage is not among the four conjuncts of §1.
4. **Precedent forbids it by name.** §2O.2: *"minting identifiers to move a percentage is the same act at larger
   scale."* §2P refused **551** on the same reasoning at 27.2%.

The 170 are left as **existing open work**, visible at their measured value, owned by the Product Owner.

---

## 10. Duplicate mappings — 11 multi-AC requirements, 0 defects

A requirement carried by more than one AC is a *candidate* duplicate mapping. There are **11**, maximum **3** ACs
on any one requirement. Each was inspected:

| Requirement | ACs | Verdict |
|---|---|---|
| `DRK-BR-003` | `DRK-AC-011`, `DRK-AC-012` | Distinct Given clauses — lawful |
| `GLS-BR-008` | `GLS-AC-007`, `GLS-AC-020` | Distinct Given clauses — lawful |
| `GLS-FR-003` | `GLS-AC-002`, `GLS-AC-003` | Distinct Given clauses — lawful |
| `MSG-BR-004` | `MSG-AC-005`, `MSG-AC-013` | Distinct Given clauses — lawful |
| `MSG-FR-006` | `MSG-AC-008`, `MSG-AC-010`, `MSG-AC-011` | Three surfaces of one rule — lawful |
| `MSG-FR-032` | `MSG-AC-010`, `MSG-AC-011`, `MSG-AC-012` | Three surfaces of one rule — lawful |
| `RTM-BR-002` | `RTM-AC-001`, `RTM-AC-003` | Distinct Given clauses — lawful |
| `RTM-FR-003` | `RTM-AC-004`, `RTM-AC-005` | Distinct Given clauses — lawful |
| `RTM-FR-016` | `RTM-AC-006`, `RTM-AC-023` | Distinct Given clauses — lawful |
| ⭐ `SGR-BR-014` | `SGR-AC-016` **+ `SDS-AC-007`** | **The only cross-part instance** — read in full at §10.1 |
| `SSF-FR-018` | `SSF-AC-014`, `SSF-AC-015` | Distinct Given clauses — lawful |

**Duplicate-mapping defects: 0.** Multiple ACs on one requirement is not duplication; identical ACs would be, and
§8 measures **0 duplicate GWT triples**.

### 10.1 `SGR-BR-014` — the cross-part mapping, read at source

This is the only requirement carried by an AC in a **different part**, so it is the only one that could hide an
ownership defect. It was read at all four sites:

| Site | Line | What it says |
|---|---|---|
| **B1** | **L324** | ⭐ Mints it: *"`SGR-BR-014` — **Membership expiry MUST NOT sever a friendship.**"* |
| **B1** | **L677** | `SGR-EC-014` — the edge case for the same rule |
| **B1** | **L730** | `SGR-AC-016` — B1's own acceptance criterion |
| **B3** | **L294** | Cites it **as B1's**: *"⛔ their **friendships persist** (`SGR-BR-014`)"* |
| **B3** | **L510** | `SDS-AC-007` cites `SDS-BR-009` **and** `SGR-BR-014` |

**Verdict: lawful.** One rule, two surfaces, one owner. B1 mints and owns it; B3 cites it as B1's and adds an AC
covering the discovery surface where the same rule must hold. B3 does not restate, weaken or re-own it. This is
correct cross-part traceability, and the reverse defect — B3 silently re-minting the rule under `SDS-BR-*` — is
exactly what direction (e) and §7 test for and did not find.

---

## 11. Trace legs 3–8

### 11.1 Leg 3 — BC / context ownership

| Measure | Value |
|---|---|
| BCs defined in `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **31** (`BC-01`…`BC-31`) |
| Union of BCs cited by B0–B9 | **24** |
| ⛔ Unresolved (cited but not in the BC Map) | **0** |
| ⛔ BCs minted by B0–B9 | **0** |
| ⛔ **Ownership conflicts** | **0** |

Per part: B0 15 · B1 12 · B2 9 · B3 9 · B4 12 · B5 12 · B6 11 · B7 13 · B8 15 · B9 17.

⚠⚠ **The first ownership-conflict measurement was rejected as unfalsifiable.** A probe for `| Owner |` table rows
found only **6** rows across ten documents and reported 0 conflicts — a zero produced by a probe that had almost
nothing to look at, the §2P `J-4` class. Recorded as `I5-2` at §15.3.

Re-measured against the **actual allocation instrument**: **B0 §2** (`L70–130`), a capability matrix whose `Owner`
column is single-valued and whose B1/B2/B3 columns carry ✅ owns / ▶ consumes / ⛔ must not touch. This instrument
*could* have produced a conflict — two parts marked ✅ on one capability row.

> **0 rows assign ✅ to more than one part.** B0 §2.1 allocates entity ownership; §2.2 allocates API ownership.

⭐ **B7 L34 is the affirmative case**: it **declines** to confer ownership that `BC-12` already holds under FROZEN
`PRD-020` §10 **L633–634**. A part refusing to take ownership it was not given is the behaviour this leg exists to
confirm.

### 11.2 Leg 4 — upstream authority

| Authority | Defined | Distinct cited by B0–B9 | Unresolved |
|---|---|---|---|
| `MP-*` (`MASTER_PRD.md`, Rank 1) | **125** | **3** | **0** |
| `AR-*` (`ARCHITECTURE_RULINGS.md`) | **7** | **2** | **0** |

`MP-*` citations per part: B4 1 · B5 1 · B6 3 · B7 1 · B8 1.

### 11.3 Leg 5 — integration edges

| Measure | Value |
|---|---|
| `E-*` edges defined in the BC Map | **29** |
| Union cited by B0–B9 | **16** |
| ⛔ Unresolved | **0** |
| ⛔ **Edges created by B0–B9** | **0** |

Union: `E-01` `E-02` `E-12` `E-13` `E-14` `E-15` `E-16` `E-19` `E-20` `E-21` `E-22` `E-23` `E-26` `E-27` `E-28`
`E-29`. Per part: B0 9 · B1 8 · B2 4 · B3 5 · B4 4 · B5 4 · B6 5 · B7 11 · B8 9 · B9 13.

⭐ **`E-27` — all 8 occurrences read at source, and every one ASSERTS VACANCY.** A count would have reported eight
uses of an edge; read at their lines, none of them uses it:

| Part | Lines | Context |
|---|---|---|
| B7 | **L220** (`MSG-XC-004`), **L253**, **L903** | Records that `E-27` carries nothing for messaging |
| B8 | **L236** (`RTM-XC-002`) | Same, for realtime/media |
| B9 | **L211**, **L269** (`TPA-FR-001`), **L769**, **L840** | Same, for the production architecture |

Asserting an edge is vacant is the opposite of creating one. **0 edges created.**

### 11.4 Leg 6 — events, data, signals

| Register | Total | Distribution |
|---|---|---|
| `EVT` | **15** | B1 8 · B2 6 · B7 1 |
| `DM` | **28** | B1 12 · B2 10 · B3 6 |
| `SIG` | **10** | B4 10 |
| `IDX` | **10** | B3 10 |

⛔ **No new events.** Every `*-EVT-*` describes an event the BC Map already publishes; `SGR-EVT-002` explicitly
**prohibits** minting one.

### 11.5 Leg 7 — scope and wave

| Register / token | Value |
|---|---|
| `SCOPE` | **31** — B1 8 · B2 6 · B3 3 · B4 5 · B5 5 · B6 4 |
| `FUT` | **8** — B6 8 |
| `V1` occurrences | **177** |
| `V2` occurrences | **117** |
| `V3` occurrences | **29** |
| `"Wave 1"` / `"Wave 2"` / `"Wave 3"` | **0 / 0 / 0** |

⚠ The parts speak in **V-numbers, never in "Wave n"**. Recorded because a wave-scoped query phrased in the
governance vocabulary returns nothing from these ten documents and would look like absent scope allocation.

### 11.6 Leg 8 — exclusions

`XC` total **156**: B0 0 · B1 14 · B2 16 · B3 16 · B4 16 · B5 18 · B6 14 · B7 22 · B8 23 · B9 17.

⚠ B0's 0 is consistent with §4.1 — B0 allocates rather than excludes.

---

## 12. OPEN items — reviewed honestly, none invented, none closed

`PRD_LIFECYCLE.md` **L104–106** governs the shape of this section:

> **A rejected finding must be recorded as rejected, with its reason.** … A review that records only accepted
> findings is indistinguishable from a review that found nothing.

Accepted findings are here; rejected ones at §15.4.

### 12.1 ⭐⭐ `S5-F-1` — the eleventh stem, `XPB-`, which no part owns

**This is the one new finding of this review, and the near-miss probes of §6 are what surfaced it.**

| Measure | `XPA-` (B0's own stem) | `XPB-` |
|---|---|---|
| Strict identifier occurrences (`STEM-[A-Z]{2,6}-\d{3}`) | **26** | **257** |
| Bare stem literal occurrences | **40** | **259** |
| Distinct identifiers | **22** | **19** |
| Files containing it | 8 | **14** |
| **Owning subject** | **B0** | ⛔ **NONE** |

⚠ The two count pairs differ by **rule, not by scope** — verified identical across `docs/`, `docs/+tool/` and all
tracked files. Both are published with their rule; see `I5-5` at §15.3.

The `XPB-` family holds **19 identifiers, both registers contiguous**:

- `XPB-CONF-001`…`XPB-CONF-017` — **17**, contiguous. Cross-part conflicts, **6 still OPEN**
- `XPB-DRIFT-001`…`XPB-DRIFT-002` — **2**, contiguous. Both **OPEN**

Minted across **14 files**: `PRD-021B_B0_B9_STAGE4_REQUIREMENTS_REVIEW.md` 43 · B7 30 ·
`PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` 27 · **`PRD_REGISTRY.md` 23** · B9 22 · B8 21 ·
**`ADR-0091` 20** · B4 17 · `PRD-021B_B7_B8_B9_CROSS_PART_AUDIT.md` 16 · B5 13 ·
`PRD-021B_B4_B5_B6_CROSS_PART_AUDIT.md` 9 · `PRD-021B_B4_B5_B6_STAGE3_ARCHITECTURE_ALIGNMENT.md` 7 ·
**`ADR-INDEX.md` 7** · B6 4.

⛔⛔ **The defect: `XPB-` is cited by a Governance-tier register (`PRD_REGISTRY.md`) and by an accepted ADR
(`ADR-0091`), it carries six OPEN owner decisions, and its authoritative enumeration lives in a REVIEW RECORD** —
`PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` **§7.1 L354** — **not in any PRD.** A review record is evidence
about a subject; it is not a subject. So the family that carries six live owner decisions has no owning document
and no register.

⛔ **It is deliberately NOT registered in §2Q.** §2Q's subject is B0–B9, and `XPB-` is not B0's stem — B0's is
`XPA-`, measured at 26 occurrences against `XPB-`'s 257, roughly a factor of ten. Registering another document's
family inside this one's registration would be **registration without a subject**, and would assert an ownership
this review has no authority to confer.

| Field | Value |
|---|---|
| **Finding** | `S5-F-1` |
| **Status** | **OPEN — raised, not resolved** |
| **Owner** | **Governance Owner** |
| **Act required** | Either allocate `XPB-` to an owning document with its own registration, or record its enumeration in a document that can own it |
| ⛔ **Not done here** | No stem allocated, no register created, no ADR minted, no §2Q row written for it |

### 12.2 Pre-existing OPEN items — carried forward unchanged

⛔ **Not one of these is closed, narrowed or reworded by this review.**

| Item | Substance | Owner | Status |
|---|---|---|---|
| `XPB-CONF-011` | Help → Message routing | Product + Architecture | **OPEN** |
| `XPB-CONF-013` | `FIL-GAP-013` confinement | Product Owner | **OPEN** |
| `XPB-CONF-014` | Read receipts | Architecture + Product | **OPEN** |
| `XPB-CONF-015` | Configurable retention | Product Owner | **OPEN** |
| `XPB-CONF-016` | Message deletion | Product Owner | **OPEN** |
| `XPB-CONF-017` | Presence / typing indicators | Architecture + Product | **OPEN** |
| `XPB-DRIFT-001` | EA wave drift (`ADR-0091` §7) | Architecture Owner | **OPEN** |
| `XPB-DRIFT-002` | `PRD_LIFECYCLE.md` **L96** mis-cites `X-13` | Governance Owner | **OPEN** |
| `FOD-1` | B0 **L296** | Architecture Owner | **OPEN** |
| `FOD-2` | B0 **L307** | Architecture Owner | **OPEN** |
| `FOD-3` | B0 **L318** | Architecture Owner | **OPEN** |
| `FOD-4` | B0 **L329–345** | — | ✅ **DISCHARGED by B0 itself** — *"Blocks B1/B2/B3 authoring? ⛔ No"*, *"Blocks later implementation? ⛔ No"* |
| `C-1` | B3 **L177–179** — `SDS-FR-003` cites `E-22` wrongly | Product Owner | **OPEN — recorded, NOT applied** |
| `C-2` | B3 **L154–162** — `SDS-FR-002` relabels FROZEN `PRD-020` §8.3. ⛔ `PRD-020` MUST NOT be edited | Architecture Owner | **OPEN — recorded, NOT applied** |
| `C-3` | B0 **L240** — chain link 2 incomplete authority | Architecture Owner | **OPEN — recorded, NOT applied** |
| `MSG-GAP-002` | `PRD-021` is still **`PLANNED`** (`PRD_REGISTRY.md` §4.2 **L321**) while B0–B9 accumulate as drafts | Governance Owner | **OPEN** |

⚠ `C-1`, `C-2` and `C-3` (`PRD-021B_STAGE3_RESOLUTION_AND_RE_REVIEW.md` §5 **L127–141**) are **citation defects,
not requirement defects**. None affects a count in §4 or §2Q, and none is a Stage 5 blocker.

⚠ `MSG-GAP-002` names a live governance fact and is **not** a Stage 5 blocker: the gate asks whether prefixes are
registered with counts and ranges, not what status the parent PRD holds.

### 12.3 Gaps — and the three census rules that produce three different numbers

| Measure | Value |
|---|---|
| **Own-stem distinct gap identifiers** | **30** |
| Foreign gap tokens cited as identifiers | **2** — `FIL-GAP-013`, `TSF-GAP-003` |
| Foreign gap token appearing **only inside a filename** | **1** — `LCF-GAP-012` (B8 **L225**, in `PRD-021A_LCF-GAP-012_DECISION_RECORD.md`) |
| ⛔ Declaration rows with no reason | **0** |
| ⛔ Declaration rows with no owner | **0** |
| *"Blocks authoring?"* = ⛔ No | **32 of 32** |

Per owning stem: B0 0 · B1 3 · B2 3 · B3 3 · B4 5 · B5 5 · B6 3 · B7 2 · B8 2 · B9 4 = **30**, summing exactly.

⚠⚠ **Row counts under three different rules, all three published with their rule:**

| Rule | Count |
|---|---|
| Rows mentioning **any** `*-GAP-*` token | **97** |
| Rows mentioning an **own-stem** gap token | **84** |
| **Declaration rows** (gap token in a table's leading cell) | **30** |
| Stage 4's rule — *"gap table rows across the nine gap registers"* (**L1009**) | **56** |

⭐ **All four are correct for their rule, and none contradicts another.** Publishing any one of them bare would
misdescribe the register. The rule now travels with every number. See `I5-1` at §15.3 — this is the fifth
appearance in this repository of the census-rule defect class.

⛔ **The `LCF-GAP-012` classification matters**: a naive foreign-gap probe reports **3** foreign gap tokens. Read at
source, one of the three is a fragment of a **filename**, not a citation of an identifier. The honest count of
foreign gap *citations* is **2**.

---

## 13. ⭐ `LCM-FR-013` — explicitly verified, explicitly NOT applied

The instruction was to verify `LCM-FR-013` and not silently apply it. Measured per part, and the neighbouring
`LCM-FR-012` measured alongside it — a column Stage 4 did not take:

| Part | `LCM-FR-013` | `LCM-FR-012` | All `LCM-` tokens |
|---|---|---|---|
| B0 | **0** | **0** | 4 |
| B1 | **0** | **0** | 10 |
| B2 | **0** | **0** | 6 |
| B3 | **0** | **0** | 15 |
| B4 | **0** | **0** | 1 |
| B5 | **0** | **0** | 0 |
| B6 | **0** | **0** | 0 |
| B7 | **0** | **0** | 0 |
| B8 | **0** | **0** | 0 |
| B9 | **0** | **0** | 0 |
| **Total** | **0 of 10** | **0 of 10** | **36** |

The `LCM-*` identifiers B0–B9 **do** cite — all 8 distinct, all resolved, 36 citations:

`LCM-RM-006` 8 · `LCM-RM-025` 7 · `LCM-RM-021` 7 · `LCM-RM-023` 6 · `LCM-API-013` 4 · `LCM-RM-001` 2 ·
`LCM-XC-001` 1 · `LCM-RM-017` 1.

Source read verbatim at `PRD-021A_A1_LIBRARY_COMMUNITY_FOUNDATION_DRAFT_v0.2.md` **L225**.

| Determination | Result |
|---|---|
| Is `LCM-FR-013` cited by any of B0–B9? | ⛔ **No — 0 occurrences in all ten** |
| Does any count in §4 or §2Q depend on it? | ⛔ **No** |
| Was it applied, inherited or silently assumed? | ⛔ **No** |
| Is its absence a Stage 5 blocker? | ⛔ **No** — the gate concerns prefix registration, and `LCM-` is A1's stem, registered at §2P |

⚠ **`LCM-FR-012` returning 0 as well is worth recording**: it means the zero at `LCM-FR-013` is not a suspicious
single-token gap in an otherwise-cited run, but part of a family B0–B9 simply cite through `LCM-RM-*` and
`LCM-API-*` instead.

---

## 14. Lawfulness of the matrix edit — measured, not assumed

§2Q writes into `TRACEABILITY_MATRIX.md`. Whether that is lawful without an ADR was **measured three ways**,
because the matrix's own self-description is not sufficient evidence about its rank:

| # | Check | Measurement | Finding |
|---|---|---|---|
| **1** | The matrix's self-declaration | Header **L9**: *"this matrix is **unranked** — it confers nothing"* | Unranked (self-reported) |
| **2** | Is it in `DOCUMENTATION_BASELINE.md` **§4**'s Rank 1–6 precedence table? | `grep -c` over §4 | ⛔ **0 occurrences — absent** |
| **3** | Where **is** it listed? | **L216**, inside **§3.4** *Configuration and implementation* | `\| 40-implementation/TRACEABILITY_MATRIX.md \| **v1.1** \| Requirement → artefact mapping \|` |

`PRD_LIFECYCLE.md` **L164** quotes baseline §7:

> *"A change to any Rank 1–5 document requires an ADR **before** the change."*

Since the matrix holds **no Rank 1–5 row**, L164 **does not reach it**. ⛔ **No ADR is required for §2Q, and none
is minted.**

⛔⛔ **Had §4 listed the matrix at any rank, this review would have STOPPED** and returned registration to the
Governance Owner rather than performing it. The check was run first, and the answer is what authorised the edit.

⚠ The `Baseline` field is deliberately **left at `BASELINE-2026-08-04-D`**. Baseline §7 rule 4 moves the identifier
only on a **Rank 1–3** version change; this matrix is unranked, so no re-issue is due. This follows §2G, §2O and
§2P, all of which left it standing.

### 14.1 Artifact shape — why there are two files and one census

`DOCUMENTATION_BASELINE.md` **L199** settles the question directly:

> ⚠ **Stage 5 has no separate conferral file, and its absence is not a hole**: the gate is *"prefixes registered in
> `TRACEABILITY_MATRIX.md` §2 … verified mechanically"*, and **§2N is that registration** — the record and the gate
> are the same artefact.

So:

- **§2Q is mandatory** — it *is* the gate. Without it, conjunct 1 fails and no record can substitute.
- **This record carries what does not belong in a register** — the gate decomposition, the readings at source, the
  rejected findings, the instrument defects, the refusals.

⛔ **The 1,300-identifier per-register census is published ONCE, in §2Q.0, and cited from here.** Duplicating 113
register rows into two files would create a `GCP-15` defect — *"a derived statement left behind by a change to the
thing it describes"* — **in the same commit that publishes it**, since any later correction to one copy would
strand the other.

---

## 15. Evidence

### 15.1 Subject hashes — all ten byte-identical to Stage 3 and Stage 4

| Part | Lines | Bytes | sha256 |
|---|---|---|---|
| B0 | 393 | 21,735 | `69dae44e5c8f99fa2fcae71d60f88fac7032ba116d9ba04280752f3c2ec94954` |
| B1 | 773 | 35,883 | `503c804504f2d04e315c0cf3c99d89e6465eaa1ef668e42e938db65db7532816` |
| B2 | 589 | 27,202 | `7339862f8cf9fc1174686126f3f49f441316f910352b37e0300f64b90c7963af` |
| B3 | 565 | 28,079 | `a3ccec3de060144efb932cdf7869c83c21b9a423d70854c6960017946953b533` |
| B4 | 601 | 36,490 | `429ed76f94042e8988391f6add4dad04ab0ed8afb931750bdc6012e969e2d0cd` |
| B5 | 533 | 31,864 | `2c8f1c3dba8840c18488d81b3e7397af54b05b301b8b73fba59453c375ebe5bc` |
| B6 | 426 | 24,316 | `1c481c6ae7557568d80e0a7156667d9132ef1a05ba812caa9be82e296f31137b` |
| B7 | 940 | 53,311 | `01e2a7fad860abe2a01398a6ac288f73e6532e9d69fcdee1ff99b7af4afc9b4a` |
| B8 | 810 | 45,340 | `a075ba341baa90037d0290c096f4bf886d9b622410c042f13791042f88506f22` |
| B9 | 983 | 48,545 | `21561f8b53af7602b0f04182645a75c6fff57226af61359f241054ace2d383a5` |
| **Total** | **6,613** | **352,765** | — |

⚠ **The 6,613 / 6,603 line-count disclosure.** Stage 3 and Stage 4 recorded **6,603**. This record measures
**6,613** because it counts a file's trailing newline as terminating a line; the earlier convention did not.
**The sha256 values are identical**, which is the fact that matters: the bytes have not changed. Both conventions
are published rather than one silently replacing the other.

### 15.2 Instruments

Five scripts, run over the ten subjects and the matrix:

| Instrument | What it measures |
|---|---|
| `s5_census.py` | Distinct-token occupancy: 113 registers, counts, ranges, contiguity, next-free, hashes |
| `s5_collide.py` | Five-direction collision test, `max+1` phantom probes, cross-part direction (e) |
| `s5_nearmiss.py` | Direction (c) 20 near-miss probes **with controls**; direction (b) 465-file stem harvest, both-way containment; direction (a) matrix pre-count |
| `s5_foreign.py` | Foreign citation resolution and the foreign-minting test |
| `s5_trace.py` / `s5_reverse.py` / `s5_multi.py` / `s5_legs.py` / `s5_own.py` | AC→requirement; requirement→AC and coverage; multi-AC list; trace legs 3–8; ownership conflicts |

⚠ **These are NOT committed to `tool/docs_check/`, and that is a deliberate refusal.** Everything in
`tool/docs_check/` runs in the repository's standing sweep, so adding a script there changes the pass/fail
baseline for every future commit. Committing five new checkers in the same commit that registers §2Q would make
this review's own verdict depend on instruments this review wrote and nobody has reviewed. Adding a standing
checker is a **Governance Owner** act; the measurements are published with their rules and their controls so any
reader can reproduce them independently.

### 15.3 ⚠ Instrument defects found in this review's own instruments — five

| # | Defect | How it was caught | Correction |
|---|---|---|---|
| `I5-1` | Gap-row census returned **57** against Stage 4's **56** | A/B against the Stage 4 record | Re-measured under **four** explicit rules — 97 / 84 / 30 / 56 — each published with its rule (§12.3). This is **§2O.4 `I-1` in a third form** |
| `I5-2` | Ownership probe found **6** `\| Owner \|` rows and declared 0 conflicts — **an unfalsifiable zero** | Recognised as the **§2P `J-4`** class: *a negative that cannot go positive proves nothing* | Re-ran against **B0 §2**, the actual allocation instrument, which *could* have produced a conflict. 0 rows assign ✅ twice (§11.1) |
| `I5-3` | Row window reported **16** capability rows against a heading declaring **15** | Cross-read against B0's own heading | **The subject was right and the instrument wrong.** Recorded rather than quietly adjusted |
| `I5-4` | A shell `\|\| echo 0` fallback **doubled** the `LCM-FR-013` output | Output inspection | Counts were correct, presentation was not. Re-ran per file cleanly — and gained the `LCM-FR-012` column the first pass lacked (§13) |
| `I5-5` | `XPA-`/`XPB-` reported as **26 / 257** in one pass and **40 / 259** in another | A/B across three scopes | ⚠ **Not a scope difference — a RULE difference**, identical in `docs/`, `docs/+tool/` and all tracked files. **26/257 = strict identifier shape; 40/259 = bare stem literal.** Both published with their rule (§12.1). **The fifth appearance of the `I5-1` class in this repository** |

⛔ **Subject defects found by these instruments: 0.** Five instrument defects, zero subject defects — the same
ratio §2M, §2N and §2O reached independently. `I5-1` and `I5-5` are the *same class*, caught twice in one review,
by an author who had read §2O.4 `I-1` before starting. That recurrence is the argument for publishing the rule
beside every count.

### 15.4 Rejected findings — nine, each with its reason

`PRD_LIFECYCLE.md` **L104–106** requires these. Each was a candidate finding that measurement or reading defeated:

| # | Candidate finding | Why REJECTED |
|---|---|---|
| `S5-R-1` | *"B0–B9 mint 15 foreign identifiers"* | All 15 lines **read at source** — 12 are `XPB-CONF-*` disposition rows, 3 are verbatim citations of `TSF-*`/`LCN-*` authority. **0 genuine minting** (§7.1) |
| `S5-R-2` | *"82 acceptance criteria are malformed"* | Artefact of a **table-only** probe. B7/B8/B9 use a lawful prose GWT form. Both parsed; 242/242 valid (§8.1) |
| `S5-R-3` | *"B0 is defective — it mints 0 FR and 0 BR"* | B0 is the **allocation** part. Its four registers allocate boundaries, dependencies and precedence. Requiring FR/BR of it would misread its role (§4.1, §11.1) |
| `S5-R-4` | *"`SGR-BR-014` is duplicated across B1 and B3"* | **Read at four sites.** B1 mints and owns; B3 cites it **as B1's** and adds a discovery-surface AC. One rule, two surfaces, one owner (§10.1) |
| `S5-R-5` | *"B0–B9 use edge `E-27` 8 times"* | **All 8 read at source.** Every one **asserts the edge is vacant**. 0 edges used, 0 created (§11.3) |
| `S5-R-6` | *"Wave allocation is missing — 0 occurrences of 'Wave 1/2/3'"* | The parts allocate scope in **V-numbers** (V1 177 · V2 117 · V3 29). A vocabulary mismatch, not absent scope (§11.5) |
| `S5-R-7` | *"3 foreign gap tokens are cited"* | One of the three, `LCF-GAP-012`, appears **only inside a filename** (B8 **L225**). True count of foreign gap citations: **2** (§12.3) |
| `S5-R-8` | *"Coverage is 375/365 = 102.7%"* | **Denominator error.** 375 spans the full normative pool; 365 is FR+BR only. Correct coverage: **195/365 = 53.4%** (§3.4, §9) |
| `S5-R-9` | *"`XPB-` collides with `XPA-`"* | Shape-disjoint, **verified both ways**, containment collisions **0**. The real finding is different and larger: `XPB-` has **no owner** (`S5-F-1`, §12.1). ⚠ Bare `'XP'` matches both — recorded as a standing obligation (§6.2) |

---

## 16. Determination

| Conjunct | Requirement | Measured | Verdict |
|---|---|---|---|
| **1** | Prefixes **registered in `TRACEABILITY_MATRIX.md` §2** | 10 stems, 113 registers, 1,300 identifiers registered at **§2Q** | ✅ **PASS** |
| **2** | **With counts and ranges** | All 113 registers carry count, range, contiguity and next-free in §2Q.0 | ✅ **PASS** |
| **3** | **Verified mechanically** | Five scripts; **0** counts taken by reading; controls published for every zero | ✅ **PASS** |
| **4** | **Zero collisions** | **0** in all five directions; **0** phantoms across 113 `max+1` probes; **0** unresolved foreign; **0** dangling cross-part | ✅ **PASS** |

# ⭐ VERDICT: PASS — 4 of 4

**Blocking gaps: NONE.**

⚠⚠ **The conditionality is stated plainly, because it is the whole substance of conjunct 1.** Before this commit
the answer was **BLOCKED**: `grep -c "PRD-021B"` over the matrix returned **0**, so 1,300 identifiers were
registered nowhere. **This PASS is conferred by the §2Q registration written in this same commit and holds only
if §2Q is present.** If §2Q were reverted, this record's verdict would revert with it — which is the correct
coupling, since `DOCUMENTATION_BASELINE.md` **L199** makes the registration and the gate the same artefact.

**Non-blocking items carried forward, none closed here:** `S5-F-1` (new — `XPB-` unowned) · 6 OPEN `XPB-CONF-*` ·
2 OPEN `XPB-DRIFT-*` · 3 OPEN `FOD-*` · `C-1`/`C-2`/`C-3` · 32 gaps · `MSG-GAP-002` · **170 uncovered
requirements at 53.4% coverage**.

---

## 17. ⛔ What this review does NOT do

| # | Not done | Who could do it |
|---|---|---|
| 1 | **Stage 6 — NOT ENTERED.** No `IMPL-*` range allocated, no task document, no task-to-requirement mapping | Governance Owner, per `PRD_LIFECYCLE.md` **L135+** |
| 2 | **Freeze — NOT DONE.** No part is frozen; freeze is *conferred, not claimed* (**L161–164**) | Governance Owner, by ADR |
| 3 | **Implementation — NOT DONE.** 0 lines under `lib/`, `test/`, `web/` | — |
| 4 | **No rank conferred.** All ten remain **Unranked**; `PRD-021` remains **`PLANNED`** | Governance Owner |
| 5 | **No status move.** §2P.4 item 7: a status move *"is an amendment act requiring amendment authority, **not a side effect**"* | Governance Owner |
| 6 | **No gap closed.** All 30 own-stem + 2 foreign gaps stand exactly as their subjects left them | Named owner per gap |
| 7 | **No owner decision closed or invented.** 6 `XPB-CONF-*` and 2 `XPB-DRIFT-*` remain OPEN | Product / Architecture / Governance Owner |
| 8 | **No new BC, event, integration edge or API.** 24 BCs cited of 31 defined, 16 edges of 29, **0 created** | Architecture Owner, by ADR |
| 9 | **No `IMPL-*` identifier written anywhere** | Governance Owner |
| 10 | **No requirement, AC or register changed.** ⛔ Identifiers minted: **0**. All ten subjects **byte-unchanged** (§15.1) | Product Owner |
| 11 | **No frozen PRD, accepted ADR, BC Map or lifecycle document modified.** `PRD-020`, `PRD-017`, `ADR-0091`, the BC Map, `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md` and `MASTER_PRD.md` are all byte-unchanged | — |
| 12 | **`LCM-FR-013` NOT applied** — verified absent (0 of 10) and left absent (§13) | Product Owner |
| 13 | **`XPB-` NOT registered.** Registering another document's family would be registration without a subject (§12.1) | Governance Owner |
| 14 | **No ADR minted.** §14 measures that none is required for an unranked document | Governance Owner |

---

## 18. Files changed by this commit

| File | Change |
|---|---|
| `docs/30-product/social-graph/PRD-021B_B0_B9_STAGE5_TRACEABILITY.md` | **NEW** — this record |
| `docs/40-implementation/TRACEABILITY_MATRIX.md` | **§2Q added**; `Version` **v1.21 → v1.22**; `Date` row extended; §11 change-history row added. ⛔ §2 through §2P **byte-unchanged**; `Baseline` **unchanged** |

**Verified unchanged:** all ten B0–B9 subjects (hashes at §15.1) · `PRD_LIFECYCLE.md` · `DOCUMENTATION_BASELINE.md`
· `MASTER_PRD.md` · `LIBOORA_BOUNDED_CONTEXT_MAP.md` · `ARCHITECTURE_RULINGS.md` · `PRD_REGISTRY.md` · all ADR
files including `ADR-0091` · FROZEN `PRD-020` · FROZEN `PRD-017` · all Stage 3 and Stage 4 records · everything
under `tool/`, `lib/`, `test/`, `web/`.

---

## 19. Commit

| Field | Value |
|---|---|
| **Artifact** | `docs/30-product/social-graph/PRD-021B_B0_B9_STAGE5_TRACEABILITY.md` |
| **Registration** | `docs/40-implementation/TRACEABILITY_MATRIX.md` **§2Q** |
| **Commit SHA** | `9c7fd18` — *see §19.1* |
| **Remote** | `github` → `https://github.com/sittuazad05022000-spec/Liboora-.git` |
| **Branch** | `main` |

### 19.1 The two-commit disposition, disclosed in advance

A record cannot contain the SHA of the commit that creates it. Two dispositions were available:

1. Leave the field as a placeholder — leaves a **`GCP-15`** derived-statement defect permanently in the record.
2. Commit the record, measure the SHA, write it back in a **second commit**.

⛔ **Amending or rebasing the first commit is excluded** — the delivery constraint forbids amend, rebase and
force-push. Disposition **2** is used: the SHA in the table above is the **first** commit (record + §2Q), written
back by a second commit whose only change is that cell. Both commits are pushed to `github main`.

---

## 20. Validation performed

| Check | Result |
|---|---|
| `docs_check` sweep, before | **25 PASS / 6 FAIL** (pre-existing baseline) |
| `docs_check` sweep, after | **25 PASS / 6 FAIL** — unchanged; no new failure introduced |
| Failing set, before and after | Identical: `alignment_record_freshness.py`, `prd004_traceability.py`, `prd005_traceability.py`, `prd006_traceability.py`, `prd007_traceability.py`, `prd020_stage5.py` |
| `git diff` reviewed | 2 files, both in the allowed change set |
| Frozen PRDs / accepted ADRs / BC Map / lifecycle touched | **0** |
| `IMPL-*` identifiers written | **0** |
| New BCs / events / edges / APIs | **0** |
| Ten subject sha256 re-verified after the change | **All 10 identical** to §15.1 |
| Files under `lib/`, `test/`, `web/`, `tool/` changed | **0** |

### 20.1 ⚠ The `prd020_stage5.py` delta, disclosed in advance

`prd020_stage5.py` **fails before this commit and fails after it**, on two pre-existing problems. This commit is
expected to **enlarge both numbers**, and the enlargement is disclosed rather than suppressed:

- *"`TSF-` appears in **1** §2\* line(s) outside §2O"* — §2Q cites `TSF-` in its foreign-token section, so this
  count **rises**.
- *"`TSF-*` defined outside `PRD-020`"* — a **4**-entry file list. This record cites `TSF-*` tokens, so the list
  **grows** by this file.

Both are artefacts of the checker's **leading-cell heuristic** (`prd020_stage5.py` **L295–312**), which cannot
distinguish a citation from a definition — the same limitation §2C.1 addresses by requiring a token be read at its
line. §7 of this record resolves all **31** distinct `TSF-*` tokens B0–B9 cite to definitions `PRD-020` owns:
**0 unresolved, 0 collisions**.

⛔ **Two cheaper alternatives were available and are refused:**

1. **Delete the evidence rows** that mention `TSF-` — would remove true measurements to quiet a checker.
2. **Edit `prd020_stage5.py`** — it is the instrument that judges a *neighbouring* registration, and editing the
   checker that judges your own work is **§2H.2's named failure**. It is also outside this review's change set.

---

## 21. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-02 | **Consolidated Stage 5 Traceability Review for `PRD-021B` B0–B9 — verdict ✅ PASS, 4 of 4 gate conjuncts.** The gate (`PRD_LIFECYCLE.md` **L121–133**) is decomposed into four separately-tested conjuncts rather than blended into one verdict. ⛔⛔ **The decisive pre-state is published with its command: `grep -c "PRD-021B"` over `TRACEABILITY_MATRIX.md` returned 0, and all ten stems returned 0 individually — 1,300 identifiers across 113 registers were registered NOWHERE, so the honest pre-registration answer was BLOCKED on conjunct 1.** Satisfied by **§2Q**, written in this same commit; the conditionality is stated in §16 rather than presented as an unconditional pass. **113 registers · 1,300 identifiers · 113 of 113 contiguous** from `001` — stronger than §2P's 104/105. **FR 196 + BR 169 = 365 normative requirements · 242 acceptance criteria.** ⭐ **Matrix editing was established LAWFUL by three independent measurements, not by trusting the matrix's own header**: its self-declaration as *"unranked"*, its **absence** from `DOCUMENTATION_BASELINE.md` §4's Rank 1–6 table (`grep -c` → **0**), and its presence instead at **L216 in §3.4**. `PRD_LIFECYCLE.md` **L164**'s ADR-before-change rule reaches only Rank 1–5, so **no ADR is required and none is minted**; ⛔ **had §4 listed it at any rank, this review would have STOPPED and returned registration to the Governance Owner.** **ZERO COLLISIONS IN FIVE DIRECTIONS** — (a) 10 stems, 0 in the matrix; (b) **465 files**, 42 stems observed, **32 foreign**, containment-tested **both ways**, **0 collide**; (c) **20 near-miss probes, all 0, each published beside the control that proves it fires** (`XPA-` 26 · `SGR-` 343 · `SSF-` 306 · `SDS-` 361 · `DRK-` 324 · `PYK-` 305 · `GLS-` 226 · `MSG-` 347 · `RTM-` 303 · `TPA-` 260), on §2P's `J-4` rule that *a negative that cannot go positive proves nothing*; (d) **89 distinct foreign tokens, 0 unresolved**; (e) **196 cross-part sibling citations, 0 citing an unminted sibling** — the direction a single-document subject structurally cannot fail. **113 `max+1` phantom probes → 0 phantoms.** ⭐⭐ **NEW FINDING `S5-F-1` — the ELEVENTH STEM, `XPB-`, which NO PART OWNS.** B0's stem is `XPA-` (26 strict occurrences); `XPB-` has **257** — roughly ten times — carrying **19 identifiers** (`XPB-CONF-001`…`017` + `XPB-DRIFT-001`…`002`, both registers contiguous) minted across **14 files including `PRD_REGISTRY.md` (23) and accepted `ADR-0091` (20)**, of which **six `XPB-CONF-*` are still OPEN owner decisions** — and its authoritative enumeration lives in a **REVIEW RECORD**, `PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` **§7.1 L354**, not in any PRD. ⛔ **Deliberately NOT registered in §2Q** — §2Q's subject is B0–B9, and registering another document's family would be *registration without a subject*; routed to the **Governance Owner** instead. ⚠ **The `XPA-`/`XPB-` near miss is this stage's own `PO-3`/`SPO-3`**: shape-disjoint verified **both ways** (containment collisions **0**), **but bare `'XP'` matches BOTH** — recorded as a standing obligation (*any checker touching this family must anchor on `XPA-` with the hyphen, never on `XPA` or `XP`*) rather than as a clean bill, following §2P's `LCFG-` precedent. ⚠⚠ **BOTH TRACE DIRECTIONS MEASURED, INCLUDING THE UNFLATTERING ONE.** Forward: **242 ACs, 242 requirement-backed, 0 orphan ACs, 0 gap-backed, 0 dangling, 0 duplicate GWT triples**. Reverse: **195 of 365 FR+BR covered = 53.4%, with 170 ORPHAN REQUIREMENTS** — published at its measured value, between §2D's 60.1% and §2O's 40.6% on this matrix's ladder. ⛔⛔ **A DENOMINATOR TRAP WAS CAUGHT BEFORE PUBLICATION**: §8's **375** distinct requirements cited spans the full normative pool while §9's **365** is FR+BR only — combining them yields **102.7%**, a coverage figure above 100% manufactured by accident. Both figures now carry their denominator in the same sentence, everywhere they appear. **B5's 18.2% is diagnosed, not repaired** — its ACs bind to `POL`/`PRS`/`SRC`/`FB`/`FRQ`, registers the FR+BR denominator excludes by construction; ⛔ **the denominator was NOT widened, because changing a denominator to move a number is the same act as minting criteria to move it.** ⛔ **The 170 criteria are NOT minted** — it would take the register **242 → 412** and falsify every count in §4 and §2Q.0 in the same commit that publishes them, it is a **Product Owner** act, coverage is **not** among the gate's four conjuncts, and §2O.2 names the act: *"minting identifiers to move a percentage is the same act at larger scale."* **ALL SIX REMAINING TRACE LEGS MEASURED** — BC ownership (**24 of 31** cited, 0 unresolved, 0 minted, **0 ownership conflicts**, with **B7 L34** declining ownership `BC-12` already holds under FROZEN `PRD-020` §10 **L633–634**); upstream authority (`MP-*` **3 of 125**, `AR-*` **2 of 7**, 0 unresolved); edges (**16 of 29** cited, **0 created**, and **all 8 `E-27` occurrences read at source and found to ASSERT VACANCY**); events/data/signals (`EVT` 15 · `DM` 28 · `SIG` 10 · `IDX` 10, **0 new events**, `SGR-EVT-002` prohibiting minting); scope/wave (`SCOPE` 31 · `FUT` 8 · V1 177 / V2 117 / V3 29, **"Wave n" = 0** — a vocabulary mismatch, not absent scope); exclusions (`XC` **156**). **11 multi-AC requirements inspected, 0 duplicate-mapping defects**, including the only cross-part instance **`SGR-BR-014`** — read at four sites (B1 **L324** mints, **L677**, **L730**; B3 **L294** cites it *as B1's*, **L510** `SDS-AC-007`) and determined **lawful: one rule, two surfaces, one owner**. ⭐ **`LCM-FR-013` EXPLICITLY VERIFIED AND EXPLICITLY NOT APPLIED — 0 occurrences in ALL TEN parts — and `LCM-FR-012` measured alongside it is ALSO 0 of 10**, a column Stage 4 did not take, which shows the zero is not a suspicious single-token gap; the 8 `LCM-*` tokens B0–B9 **do** cite (36 citations, `LCM-RM-006` 8 · `LCM-RM-025` 7 · `LCM-RM-021` 7 · `LCM-RM-023` 6 · `LCM-API-013` 4 · `LCM-RM-001` 2 · `LCM-XC-001` 1 · `LCM-RM-017` 1) all resolve, source read verbatim at A1 **L225**. ⚠⚠ **FIVE INSTRUMENT DEFECTS SELF-CAUGHT AND ZERO SUBJECT DEFECTS — and TWO of the five are the SAME CLASS, caught twice in one review by an author who had read §2O.4 `I-1` before starting.** **`I5-1`**: a gap-row census returned **57** against Stage 4's **56**, re-measured under **four** explicit rules (**97** any-mention / **84** own-stem rows / **30** declaration rows / **56** Stage 4's rule) — all four correct for their rule, and the rule now travels with every number. **`I5-5`**: `XPA-`/`XPB-` reported as **26/257** in one pass and **40/259** in another, ⚠ **not a scope difference but a RULE difference** — identical across `docs/`, `docs/+tool/` and all tracked files — **strict identifier shape vs bare stem literal**; both published. **`I5-2`**: the ownership probe found only **6** `\| Owner \|` rows across ten documents and declared 0 conflicts — **an unfalsifiable zero, the §2P `J-4` class** — re-run against **B0 §2**'s capability matrix, the actual allocation instrument, which *could* have produced a conflict: **0 rows assign ✅ to more than one part.** **`I5-3`**: a row window reported **16** capability rows against a heading declaring **15** — **the subject was right and the instrument wrong**, recorded rather than quietly adjusted. **`I5-4`**: a shell `\|\| echo 0` fallback doubled the `LCM-FR-013` output; counts correct, presentation not — re-run cleanly, gaining the `LCM-FR-012` column. ⚠ **NINE REJECTED FINDINGS are published with their reasons** (`S5-R-1`…`S5-R-9`), per **L104–106**: *"a review that records only accepted findings is indistinguishable from a review that found nothing."* Rejected were 15 apparent foreign mintings (**all read at source** — 12 `XPB-CONF-*` disposition rows, 3 verbatim authority citations, **0 genuine minting**), 82 apparently malformed ACs (**a table-only probe meeting a lawful prose GWT form** — B0–B6 use a 5-column table for 160, B7/B8/B9 prose for 82), B0's zero FR/BR (**it is the allocation part**), `SGR-BR-014` as duplication, eight `E-27` uses (**all eight assert vacancy**), absent wave allocation (**V-numbers, not "Wave n"**), three foreign gap tokens (**`LCF-GAP-012` is a FILENAME fragment, not a citation — true count 2**), 102.7% coverage (**the denominator error**), and an `XPA-`/`XPB-` collision (**shape-disjoint both ways; the real finding is that `XPB-` has no owner**). ⚠ **The five instruments are deliberately NOT committed to `tool/docs_check/`** — everything there runs in the standing sweep, so committing five new checkers in the same commit that registers §2Q would make this review's verdict depend on instruments it wrote and nobody reviewed; adding a standing checker is a **Governance Owner** act, so the measurements are published with their rules and controls for independent reproduction instead. ⚠ **The `prd020_stage5.py` delta is disclosed IN ADVANCE, not suppressed**: it fails before and after on two pre-existing problems, and both will **enlarge** (its *"§2\* line(s) outside §2O"* count and its 4-entry file list), artefacts of its **leading-cell heuristic** at **L295–312** which cannot tell a citation from a definition; ⛔ **two cheaper alternatives are refused by name** — deleting true evidence rows, and editing the checker that judges a neighbouring registration (**§2H.2's named failure**, and outside this review's change set). ⚠ **The artifact shape is resolved by reasoning from `DOCUMENTATION_BASELINE.md` L199** (*"Stage 5 has no separate conferral file … the record and the gate are the same artefact"*): **§2Q is the gate and is mandatory**, this record carries what does not belong in a register, and ⛔ **the 1,300-identifier census is published ONCE, in §2Q.0, and cited from here** — duplicating 113 register rows into two files would create a **`GCP-15`** derived-statement defect in the same commit that published it. ⚠ **The 6,613 / 6,603 line-count difference is DISCLOSED, not normalised**: Stage 3 and Stage 4 recorded 6,603 under a different trailing-newline convention, **the sha256 values are identical**, and both conventions are published. ⛔ **All ten subjects are BYTE-UNCHANGED** — sha256 per part at §15.1, identical before and after and identical to what Stage 3 and Stage 4 measured; **6,613 lines / 352,765 bytes**. **Identifiers minted: ZERO. Requirements changed: ZERO. Acceptance criteria changed: ZERO. Registers extended: ZERO. Gaps closed: ZERO. Owner decisions closed: ZERO. BCs, events, edges and APIs created: ZERO. `IMPL-*` written: ZERO. ADRs minted: ZERO.** ⛔ **Stage 6 NOT ENTERED, freeze NOT DONE, implementation NOT DONE** — §17 refuses each of **14** items explicitly and names the owner who could confer it. **All 30 own-stem gaps + 2 foreign gap citations stand exactly as their subjects left them** (0 without a reason, 0 without an owner, 32 of 32 *"Blocks authoring?"* = ⛔ No), and **all OPEN items are carried forward unchanged**: 6 `XPB-CONF-*`, 2 `XPB-DRIFT-*`, 3 `FOD-*` (with **`FOD-4` recorded as DISCHARGED BY B0 ITSELF** at **L329–345**, not by this review), `C-1`/`C-2`/`C-3` (*recorded, NOT applied* — citation defects, not requirement defects, and ⛔ `PRD-020` MUST NOT be edited for `C-2`), and **`MSG-GAP-002`**, which names the live fact that `PRD-021` is still **`PLANNED`** at `PRD_REGISTRY.md` §4.2 **L321** while B0–B9 accumulate as drafts — a **Governance Owner** matter and **not** a Stage 5 blocker. **`PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, `MASTER_PRD.md`, `LIBOORA_BOUNDED_CONTEXT_MAP.md`, `ARCHITECTURE_RULINGS.md`, `PRD_REGISTRY.md`, all ADR files including `ADR-0091`, FROZEN `PRD-020`, FROZEN `PRD-017` and all Stage 3/Stage 4 records are byte-unchanged**, as are §2 through §2P of the matrix and its `Baseline` field (**no re-issue due** — §7 rule 4 moves the identifier only on a Rank 1–3 version change, and this matrix is unranked). **No file under `lib/`, `test/`, `web/` or `tool/` was touched — 0 lines.** |
