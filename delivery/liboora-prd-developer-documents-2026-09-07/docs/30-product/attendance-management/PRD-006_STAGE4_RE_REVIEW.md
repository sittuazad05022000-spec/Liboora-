# `PRD-006` Attendance Management — Stage 4 Requirements **Re-Review**

| Field | Value |
|---|---|
| **Lifecycle stage** | **Stage 4 — Requirements Review** (`PRD_LIFECYCLE.md` L108–119) — **re-review** |
| **Subject** | `PRD-006_ATTENDANCE-MANAGEMENT.md` **v1.4 — DRAFT** |
| **Subject hash at this re-review** | `28965ddbb4480a50` (v1.4) |
| **Hash at the v1.0 re-review** | `93ab1c60d740c4e0` (**v1.3**) — **different document** |
| **Hash at the original review** | `600c59ecbbc9f92c28f36d98ebc01a8d7339c51e04b28990a5cd152bdd19980a` (**v1.2**) |
| **Why this exists** | `PRD-006_REQUIREMENTS_REVIEW.md` L14: *"A Stage 4 **re-review** remains for an independent reviewer"* — and, for **v1.1** of this file, because the §16.3 amendment moved the subject hash again |
| **Status of this file** | **Unranked.** A review record. Where it disagrees with the PRD, **the PRD is right and this file is a defect** |
| **Mandate** | Stage 4 only. **Read-only with respect to `PRD-006`** — this re-review modified no requirement, created no ADR, closed no gap and froze nothing |
| **Verdict** | ⚠️ **CONDITIONALLY PASSED** — **6 of 6 checks now PASS** (check 3 was 🔴 and is now ✅) · the **gate** remains ✅ **SATISFIED** · the verdict is **not** upgraded to an unconditional pass, and §4 records why |

> **Check 3 changed. The verdict did not.** This is the outcome `ADR-0021` §4.2 predicted in advance:
> *"Stage 3 and Stage 4 verdicts remain ⚠️ CONDITIONAL; the condition simply ceases to be **this** one."* Check 3
> failed at 7 of 24 configurables in v1.3 and now passes at **24 of 24**, measured from the v1.4 bytes. The
> verdict stays CONDITIONAL because the *gate*'s conditionality was never check 3 alone — **17 gaps remain
> explicitly deferred**, and §4 names the ones that hold the condition open. **A verdict is not upgraded because
> the one check that used to fail has stopped failing.**

---

## 1. Whether a re-review was required — the determination

Two facts settle it, and the second is decisive.

| Fact | Evidence |
|---|---|
| The Stage 4 record **says** one is outstanding | `PRD-006_REQUIREMENTS_REVIEW.md` L14, verbatim above |
| **The reviewed document no longer exists** | The review names subject hash `600c59ec…` (**v1.2**). The current file is `93ab1c60…` (**v1.3**) |

The correction record is explicit about the size of the change: **134 insertions, 28 deletions**, line count
2260 → **2366**, and the registers grew — `ATT-FR` 148 → **151**, `ATT-BR` 42 → **45**, `ATT-AC` 209 → **213**,
total 506 → **516**, obligation-bearing 279 → **285**.

**Ten new obligations have never been reviewed by any Stage 4 reviewer**: `ATT-FR-149`, `ATT-FR-150`,
`ATT-FR-151`, `ATT-BR-043`, `ATT-BR-044`, `ATT-BR-045`, and four new `ATT-AC-*`.

The correction record re-verified *counts and coverage* — and said so honestly — but drew the line itself:

> *"This review's verdict and findings below are **left exactly as issued**; the correction record is a separate
> artefact and **does not re-verdict this one**."*

**A re-review is therefore owed.** It is owed because the subject changed, not because the previous verdict was
unsatisfying.

### 1.1 What did *not* trigger it

Recorded so the trigger is not overstated. None of the following would have justified a re-review, and none is
relied on: the four documents created in Phases 2–4; the two `Proposed` ADRs; the Face V3 product decision (ARB
pending); or the Stage 5/6 gate runs. **No requirement changed in any of them.** The trigger is the v1.2 → v1.3
delta alone.

---

## 2. The six checks, re-measured from v1.3

| # | Check | Verdict | Method |
|---|---|---|---|
| 1 | Every requirement testable | ✅ **PASS** | §2.1 |
| 2 | Every exclusion states what must be **impossible** | ✅ **PASS** | §2.2 |
| 3 | Every configurable has a default **and** a range | 🔴 **FAIL** | §2.3 |
| 4 | Every acceptance criterion maps to a requirement | ✅ **PASS** | §2.4 |
| 5 | No requirement restates another PRD's | ✅ **PASS** | §2.5 |
| 6 | Business rules do not contradict Rank 1 | ✅ **PASS** | §2.6 |
| — | **The gate** — conflicts closed or explicitly deferred **with a reason and an owner** | ✅ **SATISFIED** | §3 |

### 2.1 Check 1 — testability ✅ PASS

151 `ATT-FR-*` scanned for unverifiable constructions (*"should be fast"*, *"user-friendly"*, *"appropriate"*,
*"reasonable"*, *"as needed"*, *"etc."*). **Zero hits.**

The three new requirements were read individually, since a scan cannot judge them:

* **`ATT-FR-149`** — a mode whose required setting is unresolved and unconfigured **MUST NOT** be enableable.
  Testable: attempt to enable it and assert refusal.
* **`ATT-FR-150`** — no attendance may be recorded, accepted or rejected by evaluating a valueless setting.
  Testable: assert no record is produced on that path.
* **`ATT-FR-151`** — the Owner **MUST** be shown at configuration time that a setting has no platform default.
  Testable: assert the disclosure is present.

**All three are observable.** Notably, none of them invents a value — they specify behaviour *in the absence* of
one, which is why they mitigate `RQ-1` without resolving it.

### 2.2 Check 2 — exclusions state impossibility ✅ PASS

**22** `ATT-XC-*` definitions. All 22 carry `MUST NOT` / `SHALL NOT`.

One apparent exception was inspected rather than counted: **L2345** matches an `ATT-XC-010` pattern but is a §33
back-reference (*"`ATT-XC-010` (§7.1) is the binding rule"*), not a definition. The definition at **L492** reads
*"V1 **MUST NOT** define a seventh mode… and **MUST NOT** appear as a V1 mode, requirement, configurable, event or
acceptance criterion."* **A citation is not a definition** — the same principle the collision gate applies.

### 2.3 Check 3 — default and range ✅ **PASS** *(was 🔴 FAIL at v1.3)*

**24** configurables. **24** now carry both a documented default and a documented allowed domain. Measured by
parsing the §16.3 register rows from the v1.4 bytes, not by reading the amendment's own claim about itself:

| L | ID | Default | Allowed domain |
|---|---|---|---|
| 1159 | `ATT-CFG-005` | **30 seconds** | **15–120 seconds** |
| 1160 | `ATT-CFG-006` | **60 seconds** | **30–300 seconds** |
| 1165 | `ATT-CFG-011` | **50 metres** | **20–200 metres** |
| 1166 | `ATT-CFG-012` | **30 metres** | **5–100 metres** |
| 1168 | `ATT-CFG-014` | **Not in V1** — `D-3a`, Face = **V3** | **Not in V1** — §16.3a |
| 1173 | `ATT-CFG-019` | **0.90** | **0.80–1.00** |
| 1177 | `ATT-CFG-023` | **15 minutes** | **0–60 minutes** |

**24 of 24 pass; 0 fail.** Two independent measurements agree: a row-parse of the register returns **0** rows whose
cells contain *"unresolved"* or cite `ATT-GAP-017`, and a whole-file grep for the PRD's own former self-declaration
*"a live breach of `LIB-16.2`"* now returns **0 hits** — the sentence was removed because the condition it described
ended, not because the wording was softened.

> **A counting note, retained because the raw grep still misleads.** `grep -cE '^\| .*ATT-CFG-[0-9]{3}'` returns
> **30**. Six of those (L1139–1144) are a *mode → configurable* mapping table citing IDs defined at L1155+. Unique
> IDs: **24**, matching the register and the Stage 5 gate. **The discrepancy was resolved by inspection, not by
> preferring the number that agreed with the register.**

> **`ATT-CFG-014` now passes on a different basis from the other six, and the distinction is load-bearing.** The
> v1.0 re-review counted it *in* the breach, reasoning that *"ARB approval is pending, and a Stage 4 check measures
> the document as it stands."* **That reasoning is preserved and still correct** — what changed is what the document
> says. §16.3 now records `ATT-CFG-014` as **Not in V1**, with `ADR-0021` §4 Option D as the cited basis: where a
> setting is outside V1, no V1 default is owed. Check 3 therefore passes for `014` **because the register no longer
> asserts an unmet V1 obligation**, not because ARB has approved anything. **ARB approval of Face V3 remains
> ⏳ PENDING**, the architecture-owner half of `ATT-GAP-015` remains 🔴 **OPEN**, and if Face were brought back into
> V1 this row would owe a value again — which is exactly why `ATT-BR-043`, `ATT-FR-149`, `ATT-FR-150` and
> `ATT-FR-151` were **retained rather than retired** by the amendment.

**What this check does *not* now certify.** It certifies that every configurable has a default and a range. It does
**not** certify that the values are correct, that the modes they configure are buildable, or that the ranges are
mutually consistent across their full extent — the v1.4 changelog discloses that rotation `120 s` with validity
`30 s` violates `ATT-CFG-005`'s own predicate and is refused at write time by `LIB-16.3`. **A check that asked for
a default and a range got a default and a range. It asked for nothing more, and nothing more should be read into
its passing.**

### 2.4 Check 4 — every AC maps to a requirement ✅ PASS

Measured mechanically by `tool/docs_check/prd006_traceability.py` rather than by hand: **213 AC rows / 328
Verifies citations · dangling references 0 · orphan criteria 0.**

### 2.5 Check 5 — no restatement of another PRD ✅ PASS

The v1.3 additions were checked specifically, since restatement risk rises when text is added late.
**`ATT-BR-045`** — *"Neither module **SHALL** hold a shadow copy of the other's system of record"* — is a boundary
assertion **against** duplication, and `ATT-BR-044` performs a `LIB-16.2` compliance *check* without restating
`LIB-16.2` as an attendance requirement. Cross-register collision scan: **0 collisions outside the module.**

### 2.6 Check 6 — no contradiction of Rank 1 ✅ PASS

The single `contradict` hit (L1544) is a *prohibition* — derived figures **MUST NOT** be used to contradict the
attendance aggregate — not a contradiction.

`ATT-BR-045` and `ATT-FR-149`…`151` were tested against Rank 1 `MP-GBR-*`. **No conflict.** The `LIB-16.2` breach
is with **Rank 3**, not Rank 1, and check 6 concerns Rank 1.

---

## 3. The gate ✅ SATISFIED

`PRD_LIFECYCLE.md` L119: *"conflicts closed or explicitly deferred **with a reason and an owner**."*

**The gate is not the six checks.** A check may fail while the gate holds, provided the failure is deferred
properly — and, symmetrically, **a check may pass while the gate remains merely satisfied rather than unconditional.**

At v1.3 the gate held over check 3's failure because that failure was a *proper* deferral. At v1.4 the gate holds for
a stronger reason with respect to that one conflict: **it is closed, not deferred.**

| Requirement | v1.3 — deferred | **v1.4 — closed** |
|---|---|---|
| **Named** | `ATT-GAP-017`, §32 register | Same row, now ✅ **RESOLVED 2026-08-04** |
| **Reasoned** | *"No Rank 1–5 source"* | A Rank-independent source now exists: the gap's **own named owner** decided it |
| **Owned** | **Product owner** | Same owner, and the owner has **ruled** |
| **Not concealed** | L1188 called it *"a live breach"* | The sentence is **gone because the breach is gone** — grep returns 0 |
| **Not resolved by invention** | `ATT-BR-043` forbade substitution | Still in force. **No value was derived**; six candidate derivations were tested and rejected before the owner supplied the values |

**The gate holds. It does not hold *unconditionally*, and the distinction is the whole of §4.** `PRD_LIFECYCLE.md`
L119 asks that conflicts be *"closed or explicitly deferred with a reason and an owner"* — **17 conflicts are still
in the second category**, each with a named reason and a named owner. That is a satisfied gate, not an absent one.

---

## 4. Why the verdict is not upgraded

Stated plainly, because the instruction warns against exactly this:

**The v1.0 table is preserved below, with each row's current disposition, because the arguments were rejected on
reasoning that mostly still applies — and one of them has now been answered by a legitimate decision rather than
by argument.**

| Tempting argument | v1.0 disposition | **Current disposition** |
|---|---|---|
| *`ATT-FR-149`…`151` handle the configurables issue* | Rejected — they specify behaviour **in the absence** of a value | **Still rejected, and still relevant.** They never satisfied check 3; check 3 was satisfied by *values*. Those rules remain in force for `ATT-CFG-014` and for any future valueless setting |
| *Face is V3, so `ATT-CFG-014` shouldn't count* | Rejected — ARB approval **pending** | **Superseded on a narrower ground.** `014` no longer counts because §16.3 records it as *Not in V1* per `ADR-0021` §4 Option D. **ARB approval is still pending** — the argument was right to be rejected then and is not retroactively vindicated now |
| *Stage 5 and Stage 6 both PASS* | Rejected — different gates | **Still rejected.** Both re-run PASS at v1.4; neither tests whether a value is *correct*, and neither confers a Stage 4 verdict |
| *`ADR-0022`/`ADR-0023` now exist* | Rejected — both `Proposed` | **Still rejected, re-verified this run.** All three ADRs read *"Proposed — not binding"* at L5 |
| *Governance documents were produced* | Rejected — **none changed a requirement** | **Still rejected.** The §16.3 amendment changed requirements; the documents *about* it did not, and the amendment is credited to the **owner's decision**, not to the paperwork recording it |

### 4.1 Why the verdict stays CONDITIONAL now that all six checks pass

This is the question this version of the file exists to answer, and the answer is **not** "because a reviewer is
being conservative."

| Reason | Evidence |
|---|---|
| **It was predicted, in writing, before the amendment** | `ADR-0021` §4.2: *"Stage 3 and Stage 4 verdicts remain ⚠️ CONDITIONAL; the condition simply ceases to be **this** one."* |
| **17 gaps remain explicitly deferred** | §32.1 ledger, re-measured by the Stage 5 gate this run: **3 resolved, 1 narrowed, 17 open** |
| **The load-bearing ones are architecture-owned** | `ATT-GAP-007` (network identity), `ATT-GAP-008a` (mock location), `ATT-GAP-012`/`014` (Face build), `ATT-GAP-010`/`011` (register image), and the **ARB half** of `ATT-GAP-015` |
| **A requirement still blocks its own build** | `ATT-FR-080` is **not lifted** by this amendment and was never within its scope |
| **11 implementation tasks remain blocked** | Stage 6, re-run this session: `IMPL-667` cleared, **11** still ⛔, each naming its gap |
| **The verdict is not the reviewer's to upgrade beyond the gate** | An unconditional Stage 4 pass would assert there is nothing left deferred. **There are 17 things left deferred.** |

**No finding from any earlier review was reopened, and no new finding is raised.** One finding — check 3 — was
**closed by its named owner**, which is the only mechanism by which a finding of that kind was ever going to close.

---

## 5. What this re-review did not do

| Not done | Why |
|---|---|
| Upgrade the verdict to an unconditional pass | §4.1. **17 gaps remain explicitly deferred**, and `ADR-0021` §4.2 predicted precisely this |
| Downgrade it | Nothing regressed. Check 3 improved; every other check held |
| Propose, derive or adjust a default or range | The six values and six ranges are quoted **as decided by their owner**. This file originates none, and **narrowed none** |
| Close any remaining gap | `ATT-GAP-017` was closed **by its owner in the PRD**, not here. The other 17 remain 🔴 OPEN and are untouched |
| Modify `PRD-006` | This re-review made **no** change to the PRD. The hash moved because of the **amendment**, which is a separate act by a different authority |
| Re-verdict the v1.0 re-review or the v1.2 review | Both stand as issued against the documents they examined. §4 records v1.0's reasoning **and preserves it** rather than overwriting it |
| Accept an ADR, or claim ARB / PEA / reviewer approval | All three ADRs remain `Proposed`; **zero approvals are asserted anywhere in this file** |
| Confer Stage 7 or freeze anything | Stage 7's gate is a `DOCUMENTATION_BASELINE.md` §3 row at an assigned rank. Measured **0** rows this run |

---

## 6. Verification

**Every row below was re-measured in this run against the v1.4 bytes. None is carried forward.**

| Claim | Method | Result |
|---|---|---|
| Subject differs from the document the v1.0 re-review examined | `sha256sum \| cut -c1-16` | `28965ddbb4480a50` ≠ `93ab1c60d740c4e0` ✅ |
| 24 configurables, **0** now valueless | register row-parse of L1150–1185 | **24 / 0** ✅ |
| The PRD no longer self-declares a `LIB-16.2` breach | `grep "live breach"` | **0 hits** ✅ |
| 21 exclusions, every one carrying a prohibition verb | per-ID scan for `MUST NOT` / `SHALL NOT` | **21 / 21, 0 without** ✅ |
| 0 orphan criteria, 0 dangling references | `prd006_traceability.py` | **exit 0, PASS** ✅ |
| 0 cross-register collisions | same | **0** ✅ |
| Registers unchanged by the amendment | same | `ATT-AC` **213**, total **516**, obligation-bearing **285** ✅ |
| Gap ledger arithmetic self-consistent | same | **3 resolved / 1 narrowed / 17 open** ✅ |
| Obligation coverage unaffected | `prd006_task_coverage.py` | **285/285 = 100.0%**, exit 0 ✅ |
| Blocked tasks reduced by exactly one | same | **12 → 11**, `IMPL-667` cleared ✅ |
| Only one `contradict` hit, and it is a prohibition | `grep contradict` | **1 hit, L1583, `MUST NOT`** ✅ |
| **Zero values originated by this file** | this file contains values only as **quotations** of §16.3 | **none originated** ✅ |
| **Zero approvals asserted by this file** | ADR statuses re-read at L5 of each | all three **`Proposed`** ✅ |

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-04 | **Stage 4 re-run, re-triggered by the subject document changing.** The §16.3 amendment moved `PRD-006` from `93ab1c60d740c4e0` (v1.3) to **`28965ddbb4480a50` (v1.4)**, so the document this file reviewed **no longer exists** — the same test that established a re-review was owed at v1.0. All six checks were **re-measured from the v1.4 bytes**, not carried forward. **Check 3 moves 🔴 FAIL → ✅ PASS at 24 of 24 configurables**, verified two independent ways: a register row-parse returns **0** rows containing *"unresolved"* or citing `ATT-GAP-017`, and a grep for the PRD's own former self-declaration *"a live breach of `LIB-16.2`"* returns **0 hits**. Checks 1, 2, 4, 5 and 6 re-measured and **all still PASS** — 21 exclusions all carrying a prohibition verb, 1 `contradict` hit which is itself a `MUST NOT`, 0 dangling, 0 orphan, 0 collisions. **`ATT-CFG-014` now passes on a narrower ground than the other six, and the distinction is recorded rather than blurred**: it passes because §16.3 records it as *Not in V1* per `ADR-0021` §4 Option D, **not** because ARB has approved Face V3 — **ARB approval remains ⏳ PENDING and the architecture-owner half of `ATT-GAP-015` remains 🔴 OPEN**. The v1.0 reasoning that counted `014` *in* the breach is **preserved as correct for the document it examined** rather than overwritten. **The verdict is NOT upgraded to an unconditional pass**, and §4.1 gives six measured reasons: `ADR-0021` §4.2 predicted this exact outcome in writing (*"the condition simply ceases to be **this** one"*); **17 gaps remain explicitly deferred**; the load-bearing ones are architecture-owned (`ATT-GAP-007`, `008a`, `010`/`011`, `012`/`014`, ARB half of `015`); `ATT-FR-080` is not lifted; **11** implementation tasks remain blocked; and an unconditional pass would assert nothing is deferred when 17 things are. §3 records that the gate now holds over check 3 for a **stronger** reason than at v1.3 — the conflict is **closed, not deferred** — while remaining a *satisfied* rather than *unconditional* gate. §4's v1.0 argument table is **preserved with current dispositions** rather than replaced. §5 and §6 rewritten: §6's thirteen verification rows were **all re-measured this run**. **This file originated no value — the six defaults and six ranges appear only as quotations of §16.3 as decided by the Product Owner; it narrowed no approved range, accepted no ADR, asserted no ARB, PEA, reviewer or Security Platform approval, closed no gap, modified `PRD-006` not at all, and conferred no rank and no freeze.** |
| **v1.0** | 2026-08-04 | Created as the **independent Stage 4 re-review** the original review left outstanding at L14. Establishes first that a re-review was genuinely **owed** — the v1.2 review names subject hash `600c59ec…` while the current file is `93ab1c60…`, so **the reviewed document no longer exists** and ten obligations added by the correction pass (`ATT-FR-149`…`151`, `ATT-BR-043`…`045`, four `ATT-AC-*`) have never been examined by any Stage 4 reviewer. Records what did **not** trigger it, so the trigger is not overstated. Re-measures all six checks from the current bytes: **5 PASS, check 3 FAILS at 7 of 24 configurables**, gate **SATISFIED**. Resolves a raw-grep discrepancy of 30 vs 24 CFG rows **by inspection** — six rows at L1139–1144 are a mode-mapping table citing IDs defined later — and an apparent 22nd exclusion without a prohibition verb, which proved to be a §33 back-reference to `ATT-XC-010`, whose definition at L492 does carry **MUST NOT**. Counts `ATT-CFG-014` in the breach **because ARB approval of Face V3 is pending** and a check measures the document as it stands, giving **seven**, not six. **Verdict ⚠️ CONDITIONALLY PASSED, established independently rather than inherited**, and §4 records five tempting arguments for upgrading it and rejects each — most importantly that `ATT-FR-149`…`151` specify behaviour *in the absence* of a value and so do not satisfy a check that asks for a default and a range. **No value proposed, no gap closed, no finding reopened, `PRD-006` unmodified, nothing frozen.** |
