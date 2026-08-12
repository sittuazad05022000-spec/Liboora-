# `PRD-006` Attendance Management — Stage 7 Freeze-Readiness Review

| Field | Value |
|---|---|
| **Document** | Stage 7 **freeze-readiness review** for `PRD-006` Attendance Management / `BC-03` |
| **Type** | Review record. **Not a freeze**, not a baseline row, not an ADR, not part of any specification |
| **Subject** | [`PRD-006_ATTENDANCE-MANAGEMENT.md`](./PRD-006_ATTENDANCE-MANAGEMENT.md) **v1.3 — DRAFT** |
| **Subject hash** | `93ab1c60d740c4e0fe8c82828556491a3f43d77ed47cb7e2b43ef106464ab97b` (SHA-256, verified at review time) |
| **Governing gate** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §Stage 7, L155–180 |
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
| **Verdict** | 🚫 **BLOCKED — Stage 7 is NOT satisfied.** Not a FAIL of the subject's quality; a statement that the gate's required artefacts **do not exist**, and that this review was explicitly forbidden from creating them |
| **Authority** | **None.** This document confers no status, ranks nothing and admits nothing to any baseline |

---

## 1. Verdict

🚫 **BLOCKED.**

Stage 7's gate is one sentence, quoted verbatim from `PRD_LIFECYCLE.md` L159:

> **Gate:** a row in [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3 at an
> assigned precedence rank.

**That row does not exist.** `DOCUMENTATION_BASELINE.md` contains **zero** occurrences of
`attendance-management`, measured. The gate is therefore unsatisfied as a matter of fact, not of judgement.

The instruction that commissioned this review states **"Do NOT create the baseline row"**, **"Do NOT mark PRD-006
FROZEN"** and **"Do NOT create an ADR"**. Those three prohibitions remove the only three actions that could
satisfy the gate. **The correct outcome of this review was therefore determined before it began**, and saying so
is more useful than performing a review whose conclusion is structurally fixed and reporting it as a discovery.

> **BLOCKED is not FAIL, and the distinction is load-bearing.** A FAIL would mean `PRD-006` was examined against
> the freeze criteria and found defective. What actually holds is that **six of the seven substantive entry
> conditions pass** (§3), one carries a live Rank 3 breach (§4.1), and the gate artefact is absent because
> creating it was prohibited. Reporting that as FAIL would defame the subject; reporting it as PASS would be
> false. Neither word fits, which is why the third exists.

---

## 2. What Stage 7 actually requires, and why it cannot be self-certified

Three properties of this gate, each quoted rather than paraphrased, determine everything below.

**1. Freeze is conferred, not claimed** — `PRD_LIFECYCLE.md` L161:

> Freeze is **conferred, not claimed**. No PRD in this repository declares itself frozen.

So writing `Status: FROZEN` into `PRD-006` would **claim** freeze while conferring none.
`PRD_REGISTRY.md` §2.1 makes the same point from the other side, noting that the obvious implementation of a
registry — grepping each PRD for its own status — *"would have marked all five specifications **not** frozen and
been wrong about every one of them."*

**2. The ADR comes first** — baseline §7 step 1:

> A change to any Rank 1–5 document requires an ADR **before** the change.

`DOCUMENTATION_BASELINE.md` is itself the Rank 1 governance document. Adding a row to it *is* a change to a
Rank 1–5 document. So the required order is **ADR → baseline row → registry**, which is exactly the order
[`PRD-007_STAGE7_FREEZE.md`](../seat-management/PRD-007_STAGE7_FREEZE.md) §2 records having executed for `PRD-007`
(`ADR-0020` written and accepted *"before a single ranked byte moved"*).

**3. There is no fast path** — `PRD_LIFECYCLE.md` §7:

| Situation | Path |
|---|---|
| Urgent business need | **No fast path.** Stage 7 is not skippable |

**Consequence.** Satisfying Stage 7 for `PRD-006` requires, at minimum: a new ADR (the next free number is
**`ADR-0021`** — verified, `ADR-0020` is the highest present), a row in `DOCUMENTATION_BASELINE.md` §3.3 at
Rank 3, a `§4` precedence entry, an `ADR-INDEX.md` entry, and a `PRD_REGISTRY.md` status change. **All five are
forbidden by the instruction.** This review therefore stops at readiness.

---

## 3. Entry conditions — measured, not assumed

Every prior gate was **re-run or re-read at review time**. A freeze-readiness review that trusts a stale PASS is
assessing unknown material.

| # | Entry condition | Evidence | Result |
|---|---|---|---|
| 1 | Stage 3 Architecture Review exists | [`PRD-006_ARCHITECTURE_ALIGNMENT.md`](./PRD-006_ARCHITECTURE_ALIGNMENT.md) | ✅ Exists |
| 2 | Stage 4 Requirements Review exists | [`PRD-006_REQUIREMENTS_REVIEW.md`](./PRD-006_REQUIREMENTS_REVIEW.md) | ✅ Exists |
| 3 | Stage 4 reconciliation exists | [`PRD-006_STAGE4_FINDINGS_CORRECTION.md`](./PRD-006_STAGE4_FINDINGS_CORRECTION.md) | ✅ Exists |
| 4 | Stage 5 Traceability gate PASS | `tool/docs_check/prd006_traceability.py` → **exit 0** | ✅ PASS |
| 5 | Stage 6 Implementation Tasks gate PASS | `tool/docs_check/prd006_task_coverage.py` → **exit 0** | ✅ PASS |
| 6 | Open gaps each have a named owner | §32 register, Owner column — **19/19** | ✅ PASS |
| 7 | Subject unchanged since the reviews | SHA-256 + `git diff` | ✅ Unchanged |
| 8 | Stage 3 verdict is a **PASS** | ⚠️ **CONDITIONALLY ALIGNED**, 21/22 | ⚠️ **CONDITIONAL** |
| 9 | Stage 4 verdict is a **PASS** | ⚠️ **CONDITIONALLY PASSED**, 5/6 | ⚠️ **CONDITIONAL** |
| 10 | **Baseline row exists** | 0 occurrences of `attendance-management` in the baseline | 🚫 **ABSENT** |
| 11 | **Admitting ADR exists** | No `ADR-0021`; highest is `ADR-0020` | 🚫 **ABSENT** |

### 3.1 Figures recomputed from source at review time

| Measure | Value |
|---|---|
| `ATT-FR` · `ATT-BR` · `ATT-INV` · `ATT-EVT` | 151 · 45 · 12 · 4 |
| `ATT-XC` · `ATT-PO` · `ATT-CFG` · `ATT-NFR` | 21 · 14 · 24 · 14 |
| `ATT-AC` · `ATT-GAP` | **213** · 18 numbers / **21 rows** |
| **Total identifiers** | **516** |
| Obligation-bearing | **285** (516 − 213 AC − 18 GAP) |
| Implementation tasks | **80**, `IMPL-600` … `IMPL-679`, eight waves |
| Task coverage of obligations | **285 / 285 = 100.0%** |
| Task graph | 0 cycles · 1 root (`IMPL-600`) · 1 leaf (`IMPL-679`) · critical path 10 |
| **Obligations reachable only through a blocked task** | **43 of 285 (15.1%)** |
| Gap ledger | **2 resolved · 1 narrowed · 18 open** |

> **The 15.1% is reported because Stage 7 is where it would otherwise disappear.** Stage 6 coverage is
> 285/285 = 100.0%, and quoting only that figure at a freeze gate would be true and misleading in the same
> sentence. 43 obligations — the whole Face block, register-image/OCR, the valueless configurables and 13 of 14
> NFRs — are claimed by tasks that **cannot start** until a named owner answers a gap.

---

## 4. Conditional findings — carried forward as conditional

`PRD_LIFECYCLE.md` L104 states the governing principle for review records:

> **A rejected finding must be recorded as rejected, with its reason.** … A review that records only accepted
> findings is indistinguishable from a review that found nothing.

The same logic forbids upgrading a conditional verdict by restating it. **Both verdicts below are reproduced as
issued.**

| Stage | Record | Verdict **as issued** | Carried forward as |
|---|---|---|---|
| 3 | `PRD-006_ARCHITECTURE_ALIGNMENT.md` | ⚠️ **CONDITIONALLY ALIGNED — 21 of 22 checks PASS, 1 GAP-BEARING (Check 12)**. 0 architectural conflicts vs Ranks 1–5 · 1 internal documentation defect (`F-1`) · 20 open gaps · 6 findings rejected with reasons | ⚠️ **CONDITIONAL** — unchanged |
| 4 | `PRD-006_REQUIREMENTS_REVIEW.md` | ⚠️ **CONDITIONALLY PASSED** — 5 of 6 gate checks PASS · **1 FAILS**, carried as an explicit deferral with a named reason and owner · 8 findings | ⚠️ **CONDITIONAL** — unchanged |
| 4R | `PRD-006_STAGE4_FINDINGS_CORRECTION.md` | ⚠️ **CONDITIONALLY PASSED — unchanged.** *"The condition is `ATT-GAP-017`, and it is not mine to close"* | ⚠️ **CONDITIONAL** — unchanged |

**No verdict in this repository was rewritten by this review.** The `PRD-007` freeze record carries
**A — PASS** at Stages 4, 5, 6 and 7; that wording is **deliberately not reused here**, because `PRD-006` did not
earn it.

### 4.1 The condition that is a live Rank 3 breach

Stage 4 check 3 — *every configurable has a default and a range* — **FAILS**, and the PRD says so about itself
at L1188:

> Seven rows above carry **`ATT-GAP-017`** in the Default column instead of a value: `ATT-CFG-005`,
> `ATT-CFG-006`, `ATT-CFG-011`, `ATT-CFG-012`, `ATT-CFG-014`, `ATT-CFG-019` and `ATT-CFG-023`. **This is a live
> breach of `LIB-16.2`** (Rank 3, Library PRD: *"Every setting **MUST** have a documented default"*) and it is
> recorded as a breach rather than closed by choosing seven numbers.

Measured configurable coverage: **24/24 structurally complete · 17/24 with a concrete default and closed domain ·
7/24 with neither.**

**This is the single most consequential fact in this review.** A Rank 3 document (`Library_PRD_v1.md`) states a
**MUST** that `PRD-006` does not meet. Freezing `PRD-006` at Rank 3 would install a document that breaches a
peer-rank obligation *on the day it is conferred authority* — and, once frozen, correcting it would itself
require an ADR. The mitigation (`ATT-BR-043`/`ATT-BR-044`: no value **SHALL** be substituted, and operability is
independently demonstrated) makes the breach **safe to carry in a DRAFT**. It does not make it absent.

> **Why this is not resolved here.** Seven numbers — a QR rotation interval, a GPS radius, a face-match
> threshold, an OCR confidence bound, a correction window — would close the check in one edit. Each is a security
> or product decision assigned by the register to the **product owner**. Inventing them is precisely what §0.4
> forbids and what the instruction's *"Do NOT invent resolutions for open gaps"* repeats.

---

## 5. Open `ATT-GAP-*` items — 19 open, 19 owned, 0 silently resolved

**Measured over `PRD-006` §32.1's 21 rows, counting each row by the status in its own verdict cell:
2 RESOLVED · 1 NARROWED · 18 OPEN.** Unchanged since the Stage 4 reconciliation.

Every non-resolved gap has a **named owner** in the §32 register's *"Owner who must decide"* column — **19 of 19,
zero unowned**:

| Gap | Owner who must decide | Blocks |
|---|---|---|
| `ATT-GAP-003` | Architecture owner | Analytics consumption |
| `ATT-GAP-004` | Architecture owner | Fraud escalation |
| `ATT-GAP-005` | Legal counsel + architecture owner | Retention |
| `ATT-GAP-006` | Security Platform owner | Dynamic QR hardening |
| `ATT-GAP-007` | Architecture owner | Wi-Fi claims |
| `ATT-GAP-008` | Library PRD owner | GPS source |
| `ATT-GAP-008a` | Architecture owner | GPS assurance |
| `ATT-GAP-009` | Architecture owner | Scanner device lifecycle |
| `ATT-GAP-010` | Architecture owner — needs an ADR (BC Map §7) | Register-image storage |
| `ATT-GAP-011` | Architecture owner — needs an ADR | OCR/Vision ownership |
| `ATT-GAP-012` | Architecture owner + Security Platform | **Face mode entirely** |
| `ATT-GAP-013` | Architecture owner | **Face mode** — liveness |
| `ATT-GAP-014` | Legal counsel + Security Platform | **Face mode** — `ID-5` conflict |
| `ATT-GAP-015` | Product owner + architecture owner | Face V1/V3 scheduling |
| `ATT-GAP-016` | Legal counsel + architecture owner | Register-image retention |
| `ATT-GAP-016a` | Architecture owner | Offline Dynamic QR |
| `ATT-GAP-017` | Product owner | **7 configurable defaults — §4.1** |
| `ATT-GAP-017a` | Product owner + architecture owner | Latency/throughput targets |
| `ATT-GAP-018` | Product owner | *"At least one mode enabled"* |

**None is treated as resolved anywhere.** Verified mechanically: the Stage 6 backlog contains **0** tasks claiming
to resolve a gap, its §8 names **37 tasks that must not be created** — 20 of which would close a gap by writing
code — and all **19** non-resolved gaps are referenced there. `ATT-GAP-011` is carried as **NARROWED, not
resolved**: its direction is settled, its ownership is not.

**At least three gaps require an ADR before they can close** (`ATT-GAP-003`, `ATT-GAP-010`, `ATT-GAP-011`), and
`ATT-GAP-014` is recorded as a **conflict** with `ID-5` pseudonymisation rather than a void — a conflict cannot
be closed by a decision alone.

---

## 6. Was `PRD-006` silently changed after the reviews?

**No. Verified two independent ways.**

| Method | Result |
|---|---|
| SHA-256 of the PRD | `93ab1c60…464ab97b` — identical to the value recorded at Stages 5 and 6 |
| `git diff --stat b1552fb HEAD -- docs/30-product/attendance-management/` | **empty** — no change to the PRD *or any review artefact* since the Stage 4 reconciliation commit |

The last commits touching the product directory are the Stage 4 reconciliation (`b1552fb`) and its predecessors.
Stages 5 and 6 changed **only** `TRACEABILITY_MATRIX.md` §2F, the implementation backlog and two verification
tools — never the subject. This matters because `PRD_LIFECYCLE.md` L177 holds that *"a frozen PRD is never
silently modified"*; the discipline is being applied **before** freeze, where it is cheaper.

---

## 7. Documents that would require modification before freeze

The instruction asks whether any authoritative document requires modification. **Five do**, and none may be
touched under the stated prohibitions.

| # | Document | Rank | Required change | Status |
|---|---|---|---|---|
| B-1 | `docs/00-governance/adr/ADR-0021-*.md` | 2 | **Create** the admitting ADR — *"an ADR **before** the change"* | 🚫 Forbidden |
| B-2 | `DOCUMENTATION_BASELINE.md` §3.3 | 1 | **Add the gate row** at Rank 3 | 🚫 Forbidden |
| B-3 | `DOCUMENTATION_BASELINE.md` §4 | 1 | Confer precedence rank; Rank 3 → seven module baselines | 🚫 Forbidden |
| B-4 | `ADR-INDEX.md` | — | Index `ADR-0021` | 🚫 Forbidden |
| B-5 | `PRD_REGISTRY.md` L236 | — | Status → `FROZEN`; §7 counts | 🚫 Forbidden |

### 7.1 A registry defect this review found, and did not fix

`PRD_REGISTRY.md` **L236 records `PRD-006` as `PLANNED`.** The register's own closed vocabulary (§2) defines:

> | `PLANNED` | Named as needed. **No content, no owner assigned, no discovery started** |

`PRD-006` is a **2,366-line v1.3 DRAFT** with 516 identifiers that has passed Stages 3, 4, 5 and 6. It has had
content since commit `a22d67f`. **`PLANNED` is factually wrong today** — before any freeze is contemplated. By
the register's own vocabulary the accurate status is `APPROVED` (*"review complete, findings dispositioned"*) or
at minimum `DRAFT`.

**Not corrected here**, for two reasons: the instruction forbids modifying the Registry, and a status change is
exactly the kind of edit that should be made by the governance owner in the same commit as the ADR that
authorises it. **Recorded so it is not discovered later as a surprise.**

### 7.2 A contradiction inside `PRD-006`'s own header

`PRD-006` L10 states:

> *"a conditional verdict is not a pass, so **no stage is claimed passed** and Stages 5, 6 and 7 are unattempted."*

**Stages 5 and 6 have since been attempted and both gates pass at exit 0.** The sentence was true when written
and is **false now**. It is a metadata statement, not a requirement — but it is a false statement in the subject
of a freeze review, and freezing it would freeze the falsehood.

**Not corrected here.** Editing the subject during its own freeze-readiness review is precisely the silent
modification §6 exists to detect, and the fix belongs in the same commit as the ADR.

> **Both defects point the same way.** Neither is a reason to reject `PRD-006`; both are reasons the freeze
> cannot be a one-line edit. They are listed as **pre-freeze actions** (§8), not as blockers of quality.

---

## 8. Required pre-freeze actions

Ordered. Steps 1–2 are decisions this repository cannot make for itself; steps 3–8 follow baseline §7's sequence.

| # | Action | Owner | Blocking? |
|---|---|---|---|
| **1** | **Decide `ATT-GAP-017`** — seven configurable defaults, closing the live `LIB-16.2` breach (§4.1) | **Product owner** | 🔴 **Yes** — a Rank 3 **MUST** is unmet |
| **2** | Accept or explicitly defer the remaining **18** open gaps, each with its named owner (§5) | Per register | 🟡 Deferral acceptable if reasoned |
| **3** | Obtain an **independent Stage 4 re-review**, which the Stage 4 record itself says *"remains"* | Requirements reviewer | 🟡 Recommended |
| **4** | Correct `PRD-006`'s header claim that Stages 5–7 are unattempted (§7.2) | Product owner | 🟡 Metadata |
| **5** | Correct `PRD_REGISTRY.md` L236 `PLANNED` → accurate status (§7.1) | Governance owner | 🟡 Independent of freeze |
| **6** | Write **`ADR-0021`** admitting `PRD-006` — **before** any ranked byte moves | Architecture owner | 🔴 **Yes** — gate prerequisite |
| **7** | Add the **baseline row** at Rank 3, plus §4 precedence | Governance owner | 🔴 **Yes** — *this is the gate* |
| **8** | Update `ADR-INDEX.md` and `PRD_REGISTRY.md` in the same commit | Governance owner | 🔴 Yes — baseline §7 step 3 |

### 8.1 The one question this review cannot answer

**May a PRD be frozen on two CONDITIONAL verdicts?** `PRD_LIFECYCLE.md` does not say. Stage 7's gate names an
artefact and is silent on the grade of the verdicts preceding it. The only worked precedent, `PRD-007`, entered
Stage 7 with **A — PASS** at Stages 4, 5 and 6 and left it with **A — PASS** at Stage 7 — so it does not test the
question.

Reading the silence either way would be inventing governance:

- Treating CONDITIONAL as sufficient would make the word *conditional* decorative.
- Treating it as disqualifying would add an entry condition the lifecycle does not state.

**This is referred to the governance owner as an open question**, and is a further reason the verdict is
BLOCKED rather than FAIL. Independently of how it is answered, **the missing baseline row and ADR block Stage 7
on their own** — the question changes the reasoning, not the outcome.

---

## 9. What this review does **not** do

| Not done | Why |
|---|---|
| Freeze `PRD-006` | Forbidden; and freeze is **conferred by the baseline**, never by a review record |
| Create the baseline row | Forbidden — and it *is* the gate, so creating it would fabricate the pass |
| Create `ADR-0021` | Forbidden |
| Modify `PRD-006` | Forbidden; would also destroy §6's silent-change evidence |
| Modify `PRD-007`, Registry, BC Map, Dependency Matrix, ADRs, governance files | Forbidden — all verified byte-identical |
| Resolve, narrow or re-grade any `ATT-GAP-*` | Forbidden. 18 open, 1 narrowed, unchanged |
| Rewrite either CONDITIONAL verdict as PASS | `PRD_LIFECYCLE.md` L104 — a review that upgrades findings found nothing |
| Invent the seven missing defaults | §0.4; and it is the **product owner's** decision |
| Assign an owner to any gap | All 19 already have one; inventing one would be inventing a role |
| Claim Stage 7 can be satisfied by this document | It cannot. No review record confers freeze |

---

## 10. Verification of this review's own claims

| Claim | Method | Result |
|---|---|---|
| Baseline has no attendance row | `grep -c 'attendance-management' DOCUMENTATION_BASELINE.md` | **0** |
| No admitting ADR exists | `ls docs/00-governance/adr/` | highest is `ADR-0020` |
| Stage 5 gate passes | `prd006_traceability.py` | **exit 0** |
| Stage 6 gate passes | `prd006_task_coverage.py` | **exit 0**, 285/285 |
| PRD unchanged since reviews | SHA-256 + `git diff b1552fb HEAD` | hash matches · diff **empty** |
| 19/19 open gaps owned | Parsed §32 register Owner column | **0 unowned** |
| Gap ledger still 2/1/18 | Parsed §32.1 verdict cells over 21 rows | **2 · 1 · 18** |
| Registry says `PLANNED` | `sed -n '236p' PRD_REGISTRY.md` | confirmed |
| 7 configurables lack defaults | Stage 4 §5.6 + PRD L1187 | **17/24 · 7/24** |

> **One correction made during this review.** The gap-owner check first parsed `PRD-006` §32.1 and reported
> **six gaps with no owner** (`015`, `016`, `016a`, `017`, `017a`, `018`). That was a defect in the check, not in
> the PRD: §32.1 is a three-column *ledger* with no owner column, and the Stage 3 review's row for those six
> delegates with *"Per register"*. Re-reading the §32 **register**, which does carry an
> *"Owner who must decide"* column, returned **19 of 19 owned**. The first result is recorded because a
> freeze review that reported six unowned gaps would have raised a false blocker against the subject — and the
> asymmetry matters: a false blocker costs a decision cycle, while a missed one gets frozen in.

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created as the Stage 7 **freeze-readiness review** for `PRD-006` v1.3 DRAFT. Verdict **🚫 BLOCKED — Stage 7 not satisfied**: the gate is *"a row in `DOCUMENTATION_BASELINE.md` §3"* and that row does not exist (0 occurrences of `attendance-management`, measured), no admitting ADR exists (highest is `ADR-0020`), and creating either was forbidden. Records that **six of seven substantive entry conditions pass** — Stage 3, 4 and 4R artefacts exist; Stage 5 and Stage 6 gates re-run at **exit 0**; **19 of 19** open gaps have named owners; the subject is **byte-identical** since the Stage 4 reconciliation, verified by SHA-256 and an empty `git diff`. Both prior verdicts are carried forward **⚠️ CONDITIONAL as issued** and `PRD-007`'s **A — PASS** wording is deliberately not reused. Names the decisive substantive finding: **7 of 24 configurables have no default**, a **live breach of Rank 3 `LIB-16.2`**, which would be installed *at the moment authority is conferred* — mitigated by `ATT-BR-043`/`044` but not absent, and closable only by the **product owner** via `ATT-GAP-017`. Discloses two defects found and **deliberately not fixed**: `PRD_REGISTRY.md` L236 still reads `PLANNED` for a 2,366-line DRAFT that has passed four stages, which is wrong by the register's own vocabulary; and `PRD-006`'s own header claims *"Stages 5, 6 and 7 are unattempted"*, which was true when written and is now false. Refers one genuine ambiguity to the governance owner — **whether a PRD may be frozen on two CONDITIONAL verdicts**, on which `PRD_LIFECYCLE.md` is silent and the sole precedent (`PRD-007`, A—PASS throughout) is untested — noting the outcome is BLOCKED either way. Lists **8 required pre-freeze actions**, 4 of them blocking. **Nothing frozen, no baseline row, no ADR, no registry entry, no gap resolved, no verdict re-graded, no default invented, and no authoritative document modified** — all verified byte-identical. This document is **unranked and confers nothing**. |
