# `PRD-013` Tenancy — Stage 5 Traceability: **CONFERRAL**

| Field | Value |
|---|---|
| Document | `PRD-013_STAGE5_CONFERRAL.md` |
| Act | ⚖️ **CONFERRAL** — this document performs a governance act. It is not a measurement. |
| Conferred by | **Traceability Owner**, exercised by **direct, explicit and unconditional conferral of the human principal of this engagement** |
| Instruction (verbatim) | *"Traceability owner/lifecycle authority verify karo. Required checker(s) create/verify karo. TRACEABILITY_MATRIX registrations ko checker se independently validate karo. Counts, ranges, retired IDs, collisions, dangling references and PRD↔matrix agreement verify karo. Stage 5 PASS tabhi declare karo jab lifecycle gate genuinely satisfy ho."* |
| Authority basis | That instruction **is** the authority, and it is **the only authority claimed**. Same form as `PRD-008_STAGE4_CONFERRAL.md`, `ADR-0033` §7.2 and `ADR-0034` §7.2. |
| Scope | **This specific act only.** Not a standing licence (`ADR-0033` §7.1: *"A conferral for one act is not a standing licence."*) |
| Subject | `PRD-013_TENANCY.md` **v0.1 `DRAFT`**, sha256 `688239cb28c96648addbed4d08081ed2821e867e5873a1f028ae3c49f0f1ba9c`, 472 lines |
| Register | `TRACEABILITY_MATRIX.md` **v1.13** §2I, sha256 `c69ed4882aec4b0433abfce8425f6ee8e36f47848be565cfcbde576bfd86800f` |
| Gate applied | `PRD_LIFECYCLE.md` **L122–127**: *"the PRD's prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified mechanically, **zero collisions**."* |
| Status of this record | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md`. Admission is the Governance Owner's act, not this one. |
| Date | 2026-08-19 |
| **Verdict** | ✅ **STAGE 5 TRACEABILITY PASSED — gate satisfied mechanically, zero collisions. CONFERRED.** |

---

## 1. What was blocking, and what changed

The previous pass registered `PRD-013` in the matrix but **withheld** the stage,
for two stated reasons. Both are now discharged, and neither was discharged by
argument.

| # | Reason Stage 5 was withheld | Status now |
|---|---|---|
| **1** | **No role holder.** `PRD_LIFECYCLE.md` §6 assigns Stage 5 to the **Traceability owner**; L283 records *"Every PRD needs a named owner. None has one"* (`PGA-08`). Self-conferral was refused. | **DISCHARGED by conferral.** The principal's instruction above confers the role for this act, in the identical form `PRD-008_STAGE4_CONFERRAL.md` used. `PGA-08` is a **standing repository gap and is not cured here** — this conferral is per-act, not a general owner appointment. |
| **2** | **No committed gate script.** Stage 5 demands counts *"verified **mechanically**"*, and *"a number computed once is not a number verified mechanically on every commit."* The figures came from a one-off script. | **DISCHARGED by construction.** Two checkers now exist under `tool/docs_check/`, are committed, and re-run on every invocation. |

⚠ **Reason 2 could have been discharged dishonestly**, by writing one script
that both computes and blesses the register. §2H.2 names that failure exactly:
*"a checker written in the same pass as the register it checks, by the same
author, verifies agreement with itself."* The mitigation is structural, not a
promise — see §3.

---

## 2. The gate, measured

`PRD_LIFECYCLE.md` L122–127 states four requirements. Each is measured, and the
instrument is named so the measurement can be repeated.

| Requirement | Instrument | Measured | Verdict |
|---|---|---|---|
| Prefixes **registered** in `TRACEABILITY_MATRIX.md` §2 | `prd013_stage5.py` check 1 | §2I exists; **8 of 8** registers hold a row | ✅ |
| **Counts** verified mechanically | `prd013_stage5.py` check 2 | 8/8 in-force counts and 8/8 declared counts reproduce the PRD body | ✅ |
| **Ranges** verified mechanically | checks 2–3 | 8/8 range maxima agree; 8/8 contiguous `1..max` over the **declared** set | ✅ |
| **Zero collisions** | check 4, both directions | inward **0**, outward **0**, substring hazard **0** | ✅ |

### 2.1 The registers, as computed

| Register | In force | Retired | Declared | Range | Contiguous |
|---|---:|---:|---:|---|---|
| `TEN-FR-*` | 18 | 3 | 21 | `001`–`021` | ✅ |
| `TEN-BR-*` | 2 | 2 | 4 | `001`–`004` | ✅ |
| `TEN-INV-*` | 2 | 3 | 5 | `001`–`005` | ✅ |
| `TEN-EVT-*` | 2 | 0 | 2 | `001`–`002` | ✅ |
| `TEN-XC-*` | 10 | 0 | 10 | `001`–`010` | ✅ |
| `TEN-CFG-*` | **0** | 1 | 1 | `001` | ✅ declared empty |
| `TEN-AC-*` | 13 | 3 | 16 | `001`–`016` | ✅ |
| `TEN-GAP-*` | 4 | 0 | 4 | `001`–`004` | ✅ |
| **Total** | **51** | **12** | **63** | | `51 + 12 = 63` |

Contiguity is judged over the **declared** set — in force ∪ retired — per
`TRACEABILITY_MATRIX.md` §2D.2: *"Contiguity is judged over the declared set."*
Five registers carry retirement holes and would fail a naive in-force test.
That is the matrix's own rule, not an exemption invented for this module.

### 2.2 Collisions, both directions

| Direction | Result |
|---|---|
| `TEN-*` **defined** outside `docs/30-product/tenancy/` | **0** — every `.md` under `docs/` walked |
| `TEN-*` **cited** outside | resolved against the defined set, **not** counted as failures (§2C.1: *"A citation is not a collision"*) |
| Inward stem collision | **0** — no foreign register in the matrix holds a `TEN-` stem |
| Substring hazard (`PO-n`/`SPO-n` class) | **0** — `TEN-FR-021` is not reachable by a bare `FR-021` search |

### 2.3 Disclosed limits of this conferral

A conferral that hides its own limits is not a conferral.

| Limit | Disclosure |
|---|---|
| **Coverage is 64.7%, not 100%** | 22 of 34 obligations carry a `TEN-AC-*`. The 12 uncovered are **named** in `PRD-013` §8 and printed by `prd013_traceability.py` on every run. Stage 5's gate is **registration**, not coverage — Stage 4 already assessed the shortfall and rated the equivalent LOW for `PRD-007`. This conferral does **not** certify coverage. |
| **0 of 13 criteria pass** | No implementation exists. `FROZEN` would not be `VERIFIED`, and registered is not verified. |
| `TEN-CFG-*` is **empty** | Vacuously satisfied, not evidence of configuration discipline — the `PRD-008` C3 disclosure. Rank 7 defines no tenancy parameter, so publishing one would be the unbounded-configuration hole. |
| Gaps remain **OPEN** | All 4 `TEN-GAP-*` are open after this conferral. Stage 5 closes the *registration*, not the gaps. |
| `PGA-08` **not cured** | The repository still has no standing named owner for any PRD. This is a per-act conferral. |
| Alignment record hash is **stale** | `PRD-013_ARCHITECTURE_ALIGNMENT.md` cites `fcd99ff7…f97e`, the pre-Stage-4 hash. Historically correct; assessed in §4 rather than silently repaired. |

---

## 3. Why the two checkers can disagree with each other

The `PRD-008` pattern is two scripts, neither subsuming the other.

| Script | Subject | Opens the matrix? |
|---|---|---|
| `prd013_traceability.py` | `PRD-013` against **itself** — §0.2's declarations against the body | **No, never** |
| `prd013_stage5.py` | §2I against **the PRD body**, recomputed independently | Yes |

`prd013_stage5.py` does **not** import from `prd013_traceability.py`. Both
recompute the register from source, so a bug in one does not propagate into the
other. That is what makes the second a check rather than an echo.

### 3.1 The checkers were mutation-tested, because a gate that cannot fail is not a gate

Five deliberate defects were injected and both scripts re-run. Results:

| Mutation | `prd013_traceability.py` | `prd013_stage5.py` | Correct? |
|---|---|---|---|
| Matrix in-force count `18` → `17` | pass | **fail** | ✅ matrix-only defect |
| Retired `TEN-FR-016` redefined in force | **fail** | **fail** | ✅ PRD-internal defect |
| §2I deleted entirely | pass | **fail** | ✅ *"the absence IS the Stage 5 failure"* |
| Contiguity broken (`TEN-XC-005` → `095`) | **fail** | **fail** | ✅ |
| Matrix total `51` → `50` | pass | **fail** | ✅ |

All five caught, each by the script that owns that class of defect. Both files
were restored byte-identical afterwards (verified by sha256).

### 3.2 Three defects the mutation testing found **in the checkers themselves**

Recorded rather than quietly patched, because a tool's failure history is
evidence about the tool.

| # | Defect | Consequence had it shipped |
|---|---|---|
| **1** | The reuse check computed in-force as *(all definitions − retired)*, so a reused retired number was **subtracted by the very set that should have flagged it**. Mutation 2 passed a check designed to catch it. | The one prohibition `PRD_LIFECYCLE.md` states absolutely — *"Never reuse or reassign a number"* — would have had **no enforcement at all**. Fixed by excluding §9 first, so a retired number in the remaining text is unambiguously a live redefinition. |
| **2** | §0.2's count parser read column 2 and assumed one row per register. `PRD-013` splits `TEN-FR` across three rows because retirements interrupt it. | Six false "not declared in §0.2" failures against a correct PRD. Fixed by summing rows and reading column 3. |
| **3** | Lines opening *"`TEN-FR-012` is **retired** (§9)"* matched the definition rule. | Two false reuse findings — the PRD's own honesty reported as a violation. Fixed with an explicit retirement-note guard. |

In all three the **PRD was right and the instrument was wrong**. No PRD content
was changed to make a checker pass.

---

## 4. The alignment record's stale hash — assessed, not rewritten

`PRD-013_ARCHITECTURE_ALIGNMENT.md` records the PRD hash reviewed at Stage 3 as
`fcd99ff7…f97e`. The PRD is now `688239cb…ba9c` after the Stage 4 corrections.

**Does Stage 5 require re-alignment? No.** Stage 5's gate is registration in the
matrix. Nothing in L122–127 references the alignment record.

**Does the drift require a Stage 3 re-run? Assessed: no.** The Stage 4
corrections were measured against the six Stage 3 checks:

| Stage 4 correction | Touches a Stage 3 concern? |
|---|---|
| `RQ-1` — `TEN-AC-006` stops citing `TEN-INV-001` | No. An acceptance-criterion mapping, not a boundary or ownership claim |
| `RQ-2` — `TEN-AC-009`…`016` added | No. New criteria verifying **existing** obligations; no new obligation, no new edge |
| `RQ-3` — `TEN-FR-021` carries the envelope obligation | **Reviewed.** Adds an identifier, but its content is the BC Map §9.1 envelope and `MP-GBR-07`, both of which Stage 3 already recorded as consumed authority. It moves unidentified prose under an identifier; it asserts nothing new |
| `RQ-4` — §0.2 split into three classes | No. Presentation of counts |

**No aggregate changed. No exclusion was withdrawn. No edge was added. No
`ResidencyRegion` value was asserted.** So the Stage 3 verdict still holds over
the corrected document, and the citation of the older hash is **accurate history**
— it records what Stage 3 actually read.

**Deliberately not done:** the hash in the alignment record is **not** updated.
Editing a Stage 3 record to cite a document Stage 3 never saw would make the
record claim a review that did not happen. That is the silent-amendment failure
`PRD_LIFECYCLE.md` L177 forbids. The consequence — `alignment_record_freshness`
flagging it — is **disclosed and left visible**, exactly as `ADR-0042` left the
`MP-CON-08` v2.1 drift visible and routed it as `Q-A6`.

**Routed:** re-confirmation of Stage 3 against `688239cb…ba9c` is an
**Architecture Reviewer** act. It is **not** performed here and **not** required
by Stage 5.

---

## 5. Reproducible commands

```
python3 tool/docs_check/prd013_traceability.py   # exit 0 = PRD-013 agrees with itself
python3 tool/docs_check/prd013_stage5.py         # exit 0 = the matrix agrees with PRD-013
sha256sum docs/30-product/tenancy/PRD-013_TENANCY.md
sha256sum docs/40-implementation/TRACEABILITY_MATRIX.md
```

Both exit **0** at the hashes in this record's header.

---

## 6. Verdict

✅ **STAGE 5 CONFERRED.** The gate is satisfied on its own terms: prefixes
registered in §2 with counts and ranges, verified mechanically by two committed
and mutation-tested checkers, zero collisions in both directions.

**What this does not confer:** not Stage 6, not freeze, not verification. 4 gaps
remain open, coverage is 64.7%, and 0 criteria are proven by a passing test.

**Stage 5 of 9. Stage 6 may now be entered.**
