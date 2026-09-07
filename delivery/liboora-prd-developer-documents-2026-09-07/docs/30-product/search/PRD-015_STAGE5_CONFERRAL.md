# `PRD-015` Search Indexing — Stage 5 Traceability: **CONFERRAL**

| Field | Value |
|---|---|
| **Document** | `PRD-015_STAGE5_CONFERRAL.md` |
| **Subject** | `docs/30-product/search/PRD-015_SEARCH_INDEXING.md` — Search Indexing (`BC-23`), v0.1 `DRAFT` |
| **Stage** | **5 — Traceability** (`PRD_LIFECYCLE.md` **L121-133**) |
| **Verdict** | ✅ **GATE SATISFIED — Stage 5 CONFERRED** |
| **Subject hash at review** | `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` — **byte-unchanged** |
| **Registration** | `TRACEABILITY_MATRIX.md` **§2S**, matrix **v1.23 → v1.24** |
| **Gate scripts** | `tool/docs_check/prd015_traceability.py` (**exit 0**) · `tool/docs_check/prd015_stage5.py` (**exit 0**) |
| **Date** | 2026-09-05 |
| **Baseline** | ⛔ **No baseline re-issue.** `BASELINE-2026-09-03-A` stands — the matrix is unranked and `PRD-015` is `DRAFT` |

---

## 1. The gate, and what satisfies it

`PRD_LIFECYCLE.md` **L123-124** states the Stage-5 gate exactly:

> *"the PRD's prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified
> **mechanically**, **zero collisions**."*

And **L126**: *"Mechanical means counted by a tool, not by reading."*

| Gate element | Evidence | Result |
|---|---|---|
| Prefixes registered in §2 | **§2S**, eight registers | ✅ |
| Counts and ranges published | 42 / 14 / 6 / 16 / 78 / 9, all contiguous from `001` | ✅ |
| Verified **mechanically** | two committed scripts, both **exit 0** | ✅ |
| ⭐ **Zero collisions** | three directions, all **0** — §4 | ✅ |

---

## 2. The registration

| Register | Members | Range | Contiguous | Duplicates |
|---|---|---|---|---|
| `SRCH-FR-*` | **42** | `001`–`042` | ✅ | **0** |
| `SRCH-BR-*` | **14** | `001`–`014` | ✅ | **0** |
| `SRCH-INV-*` | **6** | `001`–`006` | ✅ | **0** |
| `SRCH-XC-*` | **16** | `001`–`016` | ✅ | **0** |
| `SRCH-AC-*` | **78** | `001`–`078` | ✅ | **0** |
| `SRCH-GAP-*` | **9** | `001`–`009` | ✅ | **0** |
| `SRCH-EVT-*` | ⭐ **0** | — | — | registered **EMPTY**, verified |
| `SRCH-CFG-*` | ⭐ **0** | — | — | registered **EMPTY**, verified |

⭐ **78 obligation-bearing · 165 total identifiers · 0 retired.**

⭐⭐ **Criterion coverage 78 / 78 = 100.0 %, computed in BOTH directions** — 0 uncovered obligations,
0 orphan criteria. ⚠⚠ **This certifies that every obligation HAS a criterion. ⛔ It certifies nothing
about satisfaction: 0 of 78 are proven by a passing test**, because no implementation exists
(`SID-4.56`).

---

## 3. Independence of the two instruments

§2H.2 of the matrix names the failure this pair exists to avoid: *"a checker written in the same pass
as the register it checks, by the same author, verifies agreement with itself."*

| | `prd015_traceability.py` | `prd015_stage5.py` |
|---|---|---|
| **Route** | classifies **LINES** by their own form | splits into **SECTIONS** at `## ` and `### `, then unions |
| **Definition test** | identifier + **em-dash** separator | identifier at line start **and** em-dash present anywhere on the line |
| **Extra checks** | AC↔obligation mapping in both directions; empty-register verification | three collision directions; comparison against the PRD's **self-published** total |
| **Imports the other?** | ⛔ **NO** | ⛔ **NO** |
| **Exit** | **0** | **0** |

⭐⭐ **Both reach 78 / 78 / 165 by different strategies.** That agreement is the evidence.

---

## 4. ⭐⭐ Collision safety — and the hazard here is GENUINE

| Direction | Test | Result |
|---|---|---|
| **Inward** | `[A-Za-z0-9]-SRCH-` | ⭐ **0** |
| **Reverse** | `(?<=[A-Za-z0-9])SRCH-` | ⭐ **0** |
| **Bare form** | `\bSRCH-\d+\b` | ⭐ **0** |

⚠⚠ **Unlike §2L's, this reverse hazard is not manufactured — it is real.** `SRCHPO-1`…`19`,
`SRCHPO-A1`…`A12`, `SRCHPO-X1`…`X17`, `SRCHPO-C1`/`C2`, `SRCHAO-F5` and `SRCHAO-HB1` — **60+
decision-register identifiers** — all begin with the four characters `SRCH`. ⭐ **A loose `SRCH` scan
would sweep every one of them into a PRD inventory and report a phantom count.** The anchored regex
published in §2S requires the `-` and one of the eight sub-registers; it matches **0** of them.

---

## 5. ⭐⭐⭐ Mutation testing — 7 injected, 7 caught, and TWO HARNESS DEFECTS DISCLOSED

⚠ **A gate that cannot fail is not a gate.** Both scripts were run **before** §2S existed and both
exited **1** — *"has no section 2S heading — the gate is the registration, not the intention to
register"* — while still computing 78 / 78.

| # | Injected defect | Caught by |
|---|---|---|
| **M1** | §2S deleted entirely | ⭐ **both** |
| **M2** | §2S.1's `SRCH-XC-*` row renamed away | **both** |
| **M3** | every `SRCH-CFG-*` removed from the §2S body — the EMPTY register de-registered | **both** |
| **M4** | obligation total corrupted `78 → 77` inside §2S | **both** |
| **M5** | PRD contiguity break — `SRCH-BR-007` definition removed | **both** |
| **M6** | a member minted into the EMPTY `SRCH-CFG-*` register — the precise Stage-5 prohibition | **both** |
| **M7** | orphan criterion — an AC made to cite `SRCH-FR-999` | `prd015_traceability.py` |

⭐ **M7 is caught by one instrument only, and that is by design**: the AC↔obligation mapping is
`prd015_traceability.py`'s responsibility, and §3 records the division. The pair's purpose is
**independent agreement on the totals**, not duplicated checks.

### 5.1 ⚠⚠ Two INSTRUMENT/HARNESS defects, disclosed rather than smoothed over

**Defect A — a probe that could not fail.** M1 was initially **MISSED** by both scripts: the
existence check was the bare substring `"2S."`, and the v1.24 changelog row *itself* cites
*"§2S.4"*, so the substring **survived deletion of the very section it was meant to detect**. ⭐ Fixed
to an anchored heading probe `^## 2S\.`; M1 is now caught by both.

**Defect B — masked register probes.** M2 and M3 were initially **MISSED** for a related reason: the
register checks searched the **whole matrix file**, and the changelog row names every register in
prose. ⭐ Fixed by scoping every register check to the **§2S section body**; both are now caught.

⚠ **A THIRD miss was a defect in the MUTATION HARNESS, not in the gates**, and is recorded so the
distinction is not lost: M3's first attempt renamed only §2S.1's *table row*, while `SRCH-CFG-*`
also appears in §2S.3's justification table — still inside §2S, so the gate was **correct** to pass.
Re-run against **all** occurrences in the body, both scripts fail loudly. ⭐ **The gates were right
and the test was wrong**, which is why the mutation was driven to root cause rather than believed in
either direction.

### 5.2 ⭐ Restoration verified

Both documents were restored **byte-identical after every mutation**, verified by `sha256`:
subject `fe3093e6…c2c4544`, matrix re-hashed and compared after each of the seven injections.
⛔ **No PRD content was changed to make a checker pass.**

---

## 6. ⚠ `SRCH-INV-005` — one lawful restatement, reported not failed

Both scripts report: **1 definition at L358** (§11 *Index lifecycle*), **1 restatement at L798**
(§34 *Rebuild and recovery*).

⭐ A restatement in a later topical section is **not** a register collision — `PRD-023` does the same
with `CNF-INV-001`…`004`. ⚠ It is reported **by line number** anyway, because an undisclosed
restatement is indistinguishable from an accidental second definition, and a restatement that later
**drifts** from its definition is a real defect this output makes visible.

⛔ **The subject was NOT edited to remove it.** It is hash-locked across the Stage-3 and Stage-4
conferrals; changing a byte would invalidate both measurements.

---

## 7. Authority, and the boundary of this conferral

| | |
|---|---|
| **Who may confer Stage 5** | The **traceability owner** — `PRD_LIFECYCLE.md` §6 **L279** |
| **Authority exercised** | ⭐ The **one-act conferral of the human principal** covering this closure loop, in the identical form `PRD-008_STAGE4_CONFERRAL.md`, `PRD-013_STAGE5_CONFERRAL.md`, `PRD-014_STAGE5_CONFERRAL.md` and `PRD-016_STAGE5_CONFERRAL.md` used, and which `ADR-0102`/`ADR-0103`/`ADR-0104` used in this engagement |
| **Scope** | ⛔ **This act only** — `ADR-0033` §7.1: *"A conferral for one act is not a standing licence"* |
| **Holder** | ⛔ **No personal name is recorded** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 |
| ⚠ **`PGA-08`** | ⚠ **Standing repository gap, NOT cured.** `PRD-015` still has **no named owner**, exactly as `PRD-014_STAGE5_CONFERRAL.md` §3 records for its own subject |

### 7.1 ⛔ What this conferral does NOT do

| # | ⛔ Not conferred |
|---|---|
| 1 | ⛔ **No `IMPL-*` range allocated** — Stage 6. `docs/40-implementation/search/` **does not exist** |
| 2 | ⛔ **No freeze** — Stage 7. `DOCUMENTATION_BASELINE.md` §3 holds **no** row admitting `PRD-015` |
| 3 | ⛔ **No verification** — registered is not verified; **0 of 78** criteria proven |
| 4 | ⛔ **No registry status change** — `PRD_REGISTRY.md` **L315** stays `DRAFT` / `PLANNED` |
| 5 | ⛔ **All 9 `SRCH-GAP-*` remain OPEN** — registration is not resolution |
| 6 | ⛔ `SRCHPO-A11` · `SRE-GAP-001` (content **V2**) · `HD-2`/`HD-3`/`HD-4` content · four **DEFER** rulings · `P1`/`P7` limbs — all **OPEN** |
| 7 | ⛔ **No application code** |

---

## 8. Validation performed

| # | Check | Result |
|---|---|---|
| 1 | Prefixes registered in matrix §2 | ✅ **§2S**, 8 registers |
| 2 | Counts and ranges published | ✅ contiguous from `001`, **0** duplicates |
| 3 | Verified mechanically by a committed tool | ✅ **two**, both **exit 0** |
| 4 | Zero collisions, three directions | ✅ **0 / 0 / 0** |
| 5 | Two instruments independent, neither importing the other | ✅ different strategies, same totals |
| 6 | Both scripts fail when the registration is absent | ✅ **exit 1** before §2S existed |
| 7 | Mutation tested | ✅ **7 injected, 7 caught** |
| 8 | Instrument defects disclosed | ✅ **2 disclosed** (§5.1) + 1 harness defect |
| 9 | Documents restored byte-identical after every mutation | ✅ `sha256`-verified |
| 10 | Subject byte-unchanged | ✅ `fe3093e6…c2c4544` |
| 11 | Empty registers verified empty, no number burned | ✅ **0** members, **0** burned |
| 12 | `IMPL-*` / code created | ⛔ **0 · 0** |

---

## 9. Verdict

> ⭐⭐⭐ **`PRD-015`'s eight `SRCH-*` registers are REGISTERED in `TRACEABILITY_MATRIX.md` §2S with
> counts and ranges, verified mechanically by two independent committed instruments at exit 0, with
> zero collisions in three directions and 7 of 7 injected defects caught. Stage 5 is CONFERRED.**
>
> ⛔ **Stage 6 and Stage 7 are NOT entered.** ⛔ `PRD-015` remains **`DRAFT` / `PLANNED`** — not
> frozen, ranked, baselined or verified. ⛔ The items at §7.1 remain OPEN and are not closed or
> waived by this conferral.

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-09-05 | ⭐⭐⭐ Created. **Stage 5 CONFERRED** for `PRD-015` on the `PRD_LIFECYCLE.md` **L123-124** gate — *"prefixes registered … with counts and ranges, verified **mechanically**, **zero collisions**"*. Registration at `TRACEABILITY_MATRIX.md` **§2S**, matrix **v1.23 → v1.24**: eight registers, **165 identifiers**, **78** obligation-bearing (42 `FR` + 14 `BR` + 6 `INV` + 16 `XC`) plus **78** `AC` and **9** `GAP`, **0 retired**, all contiguous from `001`, **0 duplicate definitions**. ⭐⭐ **Criterion coverage 78/78 = 100.0 %, computed in BOTH directions** (0 uncovered, 0 orphan) — ⚠⚠ and published for exactly what it is: every obligation **has** a criterion, while **0 of 78 are PROVEN** (`SID-4.56`). ⭐ Two registers registered **AS EMPTY** and verified so — `SRCH-EVT-*` because `SRCH-FR-004` + `SRCH-INV-001` make `BC-23` a **pure projection consumer**, `SRCH-CFG-*` because `ADR-0017`/`ADR-0099` §2.4 place its carriage in `BC-25`'s `LCFG-*` — with ⛔ **no number burned in either**. ⭐⭐ **Two independent committed instruments**, `prd015_traceability.py` (line-form route, plus the AC↔obligation mapping both ways) and `prd015_stage5.py` (section-scoped route, plus three collision directions and the PRD's self-published total), **neither importing the other**, both **exit 0**, both reaching **78 / 78 / 165** by different strategies. ⚠⚠ **The reverse collision hazard for this prefix is GENUINE, not manufactured:** 60+ `SRCHPO-*`/`SRCHAO-*` decision identifiers begin with the characters `SRCH`, so a loose scan reports a phantom count; the anchored regex matches **0** of them. ⭐⭐⭐ **Mutation tested: 7 injected, 7 caught** — §2S deleted · an obligation register de-registered · the EMPTY `SRCH-CFG-*` de-registered · the obligation total corrupted 78→77 · a PRD contiguity break · a member minted into an EMPTY register (the precise Stage-5 prohibition) · an orphan criterion. ⚠⚠ **TWO INSTRUMENT DEFECTS ARE DISCLOSED, both of which had made a check unable to fail:** the existence probe was the bare substring *"2S."*, which **survived deletion of the section** because the changelog row cites *"§2S.4"* — fixed to an anchored `^## 2S\.`; and the register probes searched the **whole file**, which the changelog row masked — fixed by scoping to the **§2S section body**. ⚠ **A THIRD miss was a HARNESS defect, not a gate blind spot**, and is recorded to preserve the distinction: M3's first attempt renamed only §2S.1's table row while `SRCH-CFG-*` also appears in §2S.3, so the gate was **correct** to pass; re-run against all occurrences, both scripts fail loudly. ⭐ **The gates were right and the test was wrong.** Both documents restored **byte-identical after every mutation**, `sha256`-verified; ⛔ **no PRD content was changed to make a checker pass**. ⚠ `SRCH-INV-005`'s **lawful restatement** (defined L358 §11, restated L798 §34) is **reported by line number rather than failed**, on the `PRD-023` `CNF-INV-*` precedent. ⛔ **Subject byte-unchanged at `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544`** across Stages 3, 4 and 5. **Authority: the one-act conferral of the human principal**, in the form `PRD-008`/`PRD-013`/`PRD-014`/`PRD-016` used; ⛔ **no personal name** (§7 rule 4); ⛔ **not a standing licence** (`ADR-0033` §7.1); ⚠ **`PGA-08` is NOT cured** — `PRD-015` still has no named owner. **Stage 5 ONLY:** ⛔ no `IMPL-*` allocated, ⛔ no freeze, ⛔ no verification, ⛔ no registry change, ⛔ all 9 `SRCH-GAP-*` and the six Stage-3 residual items remain **OPEN**, ⛔ **0** application-code files. |
