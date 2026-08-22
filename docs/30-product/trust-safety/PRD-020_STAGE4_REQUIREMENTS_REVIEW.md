# `PRD-020` Trust & Safety — Stage 4 Requirements Review Record

| Field | Value |
|---|---|
| **Stage** | **Stage 4 — Requirements Review** (`PRD_LIFECYCLE.md` L108–120) |
| **Subject** | [`PRD-020_TRUST_AND_SAFETY.md`](PRD-020_TRUST_AND_SAFETY.md) — **v0.1 header / v0.5 content, `DRAFT`** |
| **Gate** | *"conflicts closed or explicitly deferred **with a reason and an owner**"* |
| **Gate satisfied by** | §3 — every finding is deferred with a reason **and** a named owner; none is closed by edit |
| **Predecessor** | [Stage 3 Architecture Alignment](PRD-020_STAGE3_ARCHITECTURE_ALIGNMENT.md) ✅ **PASS — 6 of 6**, 2 governance dependencies open |
| **Subject sha256** | `4c719dbf7904a07a8619ab6459f0f8e39dd79a4d603d153b44b3e536b3bbd90b` — ⛔ **unchanged by this review** |
| **Reviewer role** | Requirements reviewer (`PRD_LIFECYCLE.md` §6). ⚠ **No named holder exists** — `PGA-08` |
| **Measured at** | `4509705` |
| **Date** | 2026-08-22 |
| **Mandate** | **Stage 4 only.** ⛔ No ADR · no matrix registration · no Rank 1–5 document touched · no registry/baseline update · no freeze · no code |
| **Verdict** | ⚠️ **CONDITIONALLY PASSED — 5 of 6 checks pass; 1 check FAILS.** Check 4 (*every acceptance criterion maps to a requirement*) fails on **32 of 62** criteria (§3.1, `RQ-1`). **6 findings**, all deferred with reason and owner. **3 candidate findings rejected** (§4). ⚠ **2 defects in this review's own instruments disclosed** (§5) |

> ⚠ **Why `CONDITIONALLY PASSED` and not `PASS`.** One mandated check genuinely fails. The
> honest verdict is therefore conditional, and the condition (`RQ-1`) is named. Repairing it
> would require **editing the subject**, which is the Product owner's act — and unlike
> `PRD-017`'s Stage 4, no authority has been conferred on this review to edit its subject.

---

## 1. Method

Every count below is produced by a script over the subject text, not by reading. The
instruments are described in §5, **including the two defects they exhibited**, because a
census whose method is unstated is not a measurement.

**Definition of "defined"**: a line that *begins* with the identifier — either a markdown
table row (`| \`TSF-FR-001\` | …`) or a prose definition (`` `TSF-BR-014` The case MUST … ``).
Both forms are used by the subject and both are legitimate.

---

## 2. The six mandated checks

| # | Check | Measured | Verdict |
|---|---|---|---|
| 1 | Every requirement testable | Normative language defined; requirements phrased **MUST**/**MUST NOT**/**MAY** with measurable predicates (e.g. `TSF-FR-001` *"p99 ≤ 50 ms, fail closed"*; `TSF-CFG-030` *"5 s at p99, hard ceiling 30 s"*). No instance of the *"should be fast"* failure pattern found | ✅ |
| 2 | Every exclusion states what must be **impossible** | **46** `TSF-XC-*` defined. Sampled throughout: `TSF-XC-002` (*does not own credentials/sessions/OTP*), `TSF-XC-016` (*MUST NOT read message bodies at rest*), `TSF-XC-017` (*does not introduce a fourth authorization scope*). Each states a prohibition, not a deferral | ✅ |
| 3 | Every configurable has a default and a range | **29** `TSF-CFG-*`. Detail-table rows carrying a *default* and a *range* column: **0 rows missing either** (measured). `TSF-CFG-030` = default **5 s**, ceiling **30 s**, ADR required to change | ✅ |
| 4 | **Every acceptance criterion maps to a requirement** | ⛔ **FAILS. 32 of 62** `TSF-AC-*` rows cite **no** `TSF-FR/BR/INV/XC/CFG` identifier. See `RQ-1` | ⛔ **FAIL** |
| 5 | No requirement restates another PRD's | The exclusion register is the mechanism, and it is used deliberately: `TSF-XC-002` defers credentials to `BC-18`/`PRD-001`; **L368–369** route credentials/sessions/roles/consent to `BC-18` and tenant records to `BC-19`; `TSF-XC-017` defers the scope register to `MP-GBR-21`. **No duplicated ownership found** | ✅ |
| 6 | Business rules do not contradict Rank 1 | `TSF-INV-015` binds action scope to `MP-GBR-21`'s **closed** register; `F-1` binds tenancy to `ID-2`; `TSF-XC-016` upholds the privacy posture. **No contradiction found.** ⚠ Convention note: Rank 1 risk ids `MP-GBR-08`/`MP-RSK-01` are not cited by name — recorded as `RQ-6`, not as a contradiction | ✅ |

**Identifier census (mechanical):** **400** distinct `TSF-*` referenced · **387** defined ·
9 registers. Register contiguity is **not** clean — see `RQ-3`.

---

## 3. Findings — each deferred with a reason and an owner

| # | Finding | Severity | Reason for deferral | **Owner** |
|---|---|---|---|---|
| **`RQ-1`** | ⛔ **32 of 62 acceptance criteria cite no requirement.** Measured: `TSF-AC-001`…`007`, `009`…`012`, `015`…`017`, `019` and 18 more. The mapping that *does* exist runs **goal → AC** (e.g. `G-1` → `TSF-AC-001`…`008` at **L173**), which is the inverse direction to the one the gate requires | **HIGH** — this is the failing check | Repair requires **editing the subject** to add requirement citations to 32 rows. ⭐ The subject already schedules this work itself: **`IMPL-1449`** is *"Full `TSF-AC-001`…`062` traceability sweep"* (**L2536**), so the defect is **known and owned**, not undiscovered | **Product owner** (content), executed via `IMPL-1449` under the **Implementation lead** |
| **`RQ-2`** | **6 identifiers are defined twice as table rows**, in a summary table and again in a detail table: `TSF-FR-001` (L186, L649) · `TSF-FR-083` (L1301, L1868) · `TSF-XC-016` (L214, L722) · `TSF-CFG-002` (L1126, L1655) · `TSF-CFG-003` (L1127, L1656) · `TSF-CFG-004` (L1128, L1657) | **LOW** | ⭐ **All six were compared verbatim and are CONSISTENT restatements, not contradictions** — e.g. `TSF-FR-001` reads *"MUST answer within 50 ms at p99 and MUST fail closed"* at L186 and *"p99 ≤ 50 ms, fail closed"* at L649. The defect is **maintenance risk** (two sites to keep in sync), not a specification hole. Not worth an unauthorised edit to a 225 kB draft | **Product owner** |
| **`RQ-3`** | **Register contiguity is broken in 5 of 9 registers**, contrary to Stage 2 rule 3 (*"Ranges are contiguous. A gap makes the published range false"*): `TSF-FR` 119 defined across 1..146 (**27** gaps) · `TSF-XC` 46 across 1..70 (**24**) · `TSF-BR` 13 across 21..40 (**7**) · `TSF-GAP` (**3**) · `TSF-INV` (**3**) | **MEDIUM** | ⚠ **Genuinely ambiguous, and not this review's call.** The gaps are consistent with deliberate **V1 scope reduction** — `TSF-GAP-012` and `TSF-GAP-015` were *"resolved by scope reduction, recorded not deleted"*, and `IMPL-1412` is recorded **withdrawn** (**L2067**). Under `PRD_LIFECYCLE.md` §5 rule 5 withdrawn numbers are **never reused**, so gaps may be *correct*. Deciding whether each gap is a withdrawal or an omission requires the authoring intent | **Product owner** |
| **`RQ-4`** | `TSF-AC-*` count is **62**, but §30.5 and `IMPL-1449` speak of `TSF-AC-001`…**`062`** while the evidence record cites *"~128"* criteria elsewhere in the ecosystem | **LOW** | Recorded so the figure is not silently inconsistent between records. **62** is the measured count in the subject | **Product owner** |
| **`RQ-5`** | **2 governance dependencies inherited from Stage 3** remain open: `TSF-GAP-003` implementation half and `TSF-GAP-014` (age-band accessor) | **HIGH** for release, **not** for Stage 4 | Stage 4 reviews requirement quality, not governance closure. Both are correctly disclosed by the subject | **Architecture Owner** (`ADR-0074`) · **`BC-18` owner with `BC-13` owner** |
| **`RQ-6`** | Rank 1 risk identifiers `MP-GBR-08` and `MP-RSK-01` are **not cited by name** anywhere in the subject, although the substance they govern (tenant scoping) is specified thoroughly under `F-1` / `ID-2` / `TSF-INV-015` | **LOW** | A citation-convention question. The **substance passes** Stage 3 check 6; adding citations is a wording edit to a draft | **Product owner** |

⭐ **`RQ-1` is the finding that matters, and the reason is worth stating.** An acceptance
criterion that cites no requirement cannot be shown to *verify* anything: at Stage 9 the
question *"which requirement is now proven?"* has no mechanical answer for 32 of 62 rows.
The subject is not naive about this — it allocated `IMPL-1449` for exactly this sweep — but
until that sweep runs, the Stage 4 check fails, and this record says so rather than rounding
up to `PASS`.

---

## 4. Candidate findings RAISED and REJECTED

| # | Candidate | Why rejected |
|---|---|---|
| **R-1** | *"**13** identifiers are referenced but never defined, including `TSF-CFG-030` and `TSF-BR-030` — 13 dangling references."* | ⛔ **REJECTED — instrument defect, not a subject defect.** `TSF-CFG-030` *is* defined (its introduction is recorded at **L55**: *"v0.5 adds exactly one identifier — `TSF-CFG-030`"*) and `TSF-BR-030` is cited normatively at **L1498**/**L2224**. My first census only recognised line-initial definitions and so missed identifiers defined mid-sentence. Disclosed as instrument defect **I-1** in §5 |
| **R-2** | *"**33** identifiers are defined twice — widespread duplication."* | ⛔ **REJECTED as stated — over-count.** Re-measured by line distance: **17** of the 33 are a table row followed within ≤ 8 lines by its own prose elaboration, which is the subject's normal and legitimate house style. Only the **6** row+row pairs at distances of 389–567 lines are genuine duplicate definitions, and those are `RQ-2`. Disclosed as instrument defect **I-2** in §5 |
| **R-3** | *"`TSF-GAP-012` (`TIGHTEN_RATE_LIMITS`) was resolved without an ADR — a governance breach."* | ⛔ **REJECTED.** **L1154** is explicit: *"RESOLVED IN v0.3 BY V1 SCOPE REDUCTION, NOT BY AN ADR"*, and **L1173** records it as *"Resolved by scope reduction. Recorded, not deleted, so that V2 inherits the analysis."* **Removing** something from V1 scope is a Product owner act and needs no ADR; it is *adding* a boundary-crossing capability that needs one. Treating a scope reduction as requiring an ADR would invert the rule |

---

## 5. ⚠ Defects in this review's own instruments, disclosed

| # | Defect | Effect | Correction |
|---|---|---|---|
| **I-1** | The first census recognised a definition only when the identifier began the line, missing prose definitions embedded mid-sentence | Reported **101** "undefined" identifiers, then **13** after a partial fix. Both figures were **wrong** | Definition rule widened to row-initial **and** prose-initial. The residual 13 were then individually inspected and found defined; the finding was **withdrawn** (R-1) |
| **I-2** | The widened census counted a table row and its adjacent prose elaboration as two competing definitions | Reported **33** duplicates | Re-measured with a line-distance test; adjacent pairs (≤ 8 lines) reclassified as house style. **6** genuine duplicates remain (`RQ-2`) |

⚠ **Both instrument defects over-reported defects in the subject.** Publishing them matters:
had `RQ-1`'s 32 orphan criteria been reported alongside 101 phantom dangling references and
33 phantom duplicates, a reader would reasonably have discounted all three. The one real
finding is more credible for the two false ones being retracted by name.

---

## 6. What this record does NOT do

| Act not performed | Owner |
|---|---|
| Edit the subject to repair `RQ-1`, `RQ-2`, `RQ-3` or `RQ-6` | **Product owner** — no editing authority was conferred on this review |
| Close any `TSF-GAP-*` | **Architecture Owner** |
| Register `TSF-` in `TRACEABILITY_MATRIX.md` | **Traceability owner** (Stage 5) |
| Freeze, rank, or update registry/baseline | **Governance owner** (Stage 7) |
| Create an ADR | **Architecture Owner** — next lawful number `ADR-0074` |

⛔ **Consequence for Stage 7, stated here so it is not discovered later:** a Stage 4 verdict
of `CONDITIONALLY PASSED` with an unresolved **HIGH** finding means the Stage 4 gate is
**not cleanly passed**. `RQ-1` is a freeze prerequisite, not a post-freeze cleanup.

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| 1.0 | 2026-08-22 | Created. Stage 4 gate artefact: 5 of 6 checks pass, check 4 **fails** on 32 of 62 acceptance criteria (`RQ-1`). 6 findings deferred with reason and owner; 3 candidates rejected; 2 instrument defects disclosed. **Subject unmodified.** |
