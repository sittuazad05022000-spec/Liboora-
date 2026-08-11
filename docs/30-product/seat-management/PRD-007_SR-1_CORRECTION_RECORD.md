# `PRD-007` Seat Management — `SR-1` Targeted Correction Record

| Field | Value |
|---|---|
| **Document type** | Correction record — **validation artefact, not part of the specification** |
| **Subject** | [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) `PRD-007` v1.0 `DRAFT` |
| **Authorising review** | [`PRD-007_STAGE4_REREVIEW.md`](PRD-007_STAGE4_REREVIEW.md) — independent Stage 4 re-review, verdict **B**, finding `SR-1` **MEDIUM** |
| **Scope** | **`SR-1` only.** `SR-2`, `SR-3`, `SR-4`, `SR-5` deliberately untouched |
| **Corrected at** | `aab757c` |
| **Date** | 2026-08-10 |
| **PRD hash before** | `9c32cd4725187cb722d34a56b9fbf5ac7d1658e08f8ca309f8661018c6725c8a` |
| **PRD hash after** | `705323e94c88fc90a857723fde060ad5e01301a04c34a10a9e8a287be2ebf87c` |
| **Diff size** | **6 insertions, 4 deletions, 3 sites, 1 file** |
| **Line count** | 2840 → 2842 (+2) |
| **Registers** | **Unchanged** — no identifier created, deleted or renumbered |
| **Outcome** | `SR-1` **RESOLVED** — subject to independent re-review, which this record does not pre-empt |

---

## 0. The defect, as found

`PRD-007_STAGE4_REREVIEW.md` §3.2 found that the earlier `RQ-1` correction fixed the two sites the first Stage 4
review named (`SEAT-CFG-017`, `SEAT-FR-265`) and **missed a third**, 374 lines earlier:

> `SEAT-FR-212` — Threshold values are tenant configuration. Where none is configured, the module **MUST** default
> to **90%** of active seat capacity and **MUST** remain operable.

That is the exact proposition the `RQ-1` correction was commissioned to eliminate. It contradicted five statements
and breached one business rule:

| Contradicted | Which requires |
|---|---|
| `SEAT-CFG-017` | unset → *"no event is emitted and no value is substituted"* |
| `SEAT-FR-265` | unset → *"the **90%** figure **MUST NOT** be applied as a fallback"* |
| `SEAT-FR-241` | *"the module **MUST NOT** substitute a hard-coded value"* |
| `SEAT-FR-267` | *"Until confirmed, no threshold is set"* |
| `SEAT-AC-170` | unset + 100% occupancy → *"No `SEAT-EVT-004` is emitted"* |
| `SEAT-BR-037` | every configurable **MUST** have *"exactly one default"* |

Secondary defect: `SEAT-FR-212` carried **no acceptance criterion** — `grep` returned exactly one hit, its own
definition. That is how a contradictory `MUST` survived two prior passes.

---

## 1. The correction

Three edits. No identifier created, deleted or renumbered.

### 1.1 `SEAT-FR-212` — L1478–1481

**Before:**

> Threshold values are tenant configuration. Where none is configured, the module **MUST** default to **90%** of
> active seat capacity and **MUST** remain operable.

**After:**

> Threshold values are tenant configuration. Where a threshold **is** configured it is an integer 1–100 and
> `SEAT-FR-211`'s crossing rule applies to that value. Where none is configured no threshold exists:
> `SEAT-EVT-004` **MUST NOT** be emitted at any occupancy value, the **90%** figure **MUST NOT** be substituted as
> a fallback (`SEAT-CFG-017`, `SEAT-FR-241`, `SEAT-FR-265`), and the module **MUST** remain operable.

### 1.2 Business intent preserved, not merely retained

`SEAT-FR-212` carried **two** intents. Both survive:

| Original intent | Status |
|---|---|
| *"Threshold values are tenant configuration"* — the threshold is configuration, never hard-coded | **Preserved verbatim** as the opening sentence |
| *"**MUST** remain operable"* — `LIB-16.2`, *"a library that has changed nothing MUST be fully operable"* | **Preserved verbatim** as the closing clause. This is the load-bearing half: an unconfigured library still functions; it simply emits no threshold event |

Only the third clause — the 90% fallback — was replaced, because it was the defect. **No new threshold was
invented**, no value was chosen, and the configured limb now defers to `SEAT-FR-211` rather than restating it.

### 1.3 Acceptance criteria — citations added, no criterion invented

`SR-1` required the rule to be testable. Two existing rows already test exactly what corrected `SEAT-FR-212`
mandates, so the minimal honest fix was to add the back-reference rather than author a new AC:

| AC | Already tested | Citation added | Limb covered |
|---|---|---|---|
| `SEAT-AC-170` | *"No occupancy threshold configured / occupancy rises to 100% / No `SEAT-EVT-004` is emitted"* | `SEAT-FR-212` | **unset** limb |
| `SEAT-AC-169` | *"threshold at 90% / rises to 91% then 95% / emitted once, on the crossing"* | `SEAT-FR-211`, `SEAT-FR-212` | **configured** limb |

**Zero new acceptance criteria. The AC register remains at exactly 225**, so §0.3's declared range
`SEAT-AC-001 … SEAT-AC-225` needed no edit. `SEAT-FR-211` also gained its first AC citation as a side effect —
it was previously uncited.

Coverage delta, measured:

```
SEAT-FR-212 cited by AC:  0  ->  2   (SEAT-AC-169, SEAT-AC-170)
SEAT-FR-211 cited by AC:  0  ->  1   (SEAT-AC-169)
```

---

## 2. Verification

### 2.1 No contradictory 90% fallback statement remains

Exhaustive sweep. Six occurrences of `90%` survive; **every one is either a prohibition or explicitly
proposal-scoped.** None asserts a fallback.

| Line | Context | Reading |
|---|---|---|
| 1480 | `SEAT-FR-212` | *"**MUST NOT** be substituted as a fallback"* — **prohibition** |
| 1671 | `SEAT-FR-241` | *"default **90%**…"* then *"Where the threshold is unset… **MUST NOT** substitute a hard-coded value"* — proposal + prohibition. Preserve target, unchanged |
| 1858 | `SEAT-FR-265` | *"**MUST NOT** be applied as a fallback"* — **prohibition** |
| 1860 | `SEAT-FR-265` | *"**90%** becomes the applicable default only once… carried by the `E-05` contract"* — proposal-scoped |
| 1884 | `SEAT-CFG-017` | *"**90%** applies only once `E-05` carries the threshold"* — proposal-scoped |
| 2522 | `SEAT-AC-169` | *"threshold at its default 90%"* — a **configured** scenario, not a fallback. Known wording drift = `SR-4`, out of scope |

Targeted grep for `default to **90` / `defaults to 90` / `default 90% of active` → **no match.**

### 2.2 Mutual consistency of the seven named identifiers

| State | `FR-212` | `FR-265` | `CFG-017` | `FR-241` | `FR-267` | `AC-170` | `BR-037` | Agree? |
|---|---|---|---|---|---|---|---|---|
| **`unset`** | no event, no 90% substitution, still operable | no threshold, never emitted incl. 100%, no fallback | unset in V1, no event, no substitution | no event, no hard-coded value | no threshold set | 100% → no event | exactly one default, defined unset behaviour | ✅ **all seven** |
| **`1`** | configured → `FR-211` crossing on 1% | set 1–100 → threshold, crossing | domain `1–100` | configurable | silent (a value is set) | n/a | satisfied | ✅ |
| **`90`** | configured → crossing on 90% | crossing, once, re-arms (`FR-242`) | domain `1–100` | configurable | silent | n/a | satisfied | ✅ |
| **`100`** | configured → crossing on 100% | *"including 100%"* only when unset ⇒ no event; when set, crossing applies | domain upper bound | configurable | silent | 100% + unset → no event | satisfied | ✅ |

**All four states are now deterministic.** The `unset` state — the actual V1 state per `SEAT-GAP-005` — is
corroborated by six independent statements that agree, where previously one contradicted five.

`SEAT-BR-037` is now satisfied for `SEAT-CFG-017`: exactly one owner (`BC-06` via `E-05`), exactly one default
(unset in V1, explicitly stated), and a defined unset behaviour (no event, no substitution).

### 2.3 Registers and AC mappings — unchanged

| Register | Declared §0.3 | Measured after | Verdict |
|---|---|---|---|
| `SEAT-FR-*` | 001…304 | **304** | ✅ |
| `SEAT-BR-*` | 001…045 | **45** | ✅ |
| `SEAT-INV-*` | 001…014 | **14** | ✅ |
| `SEAT-EVT-*` | 001…004 | **4** | ✅ |
| `SEAT-XC-*` | 001…022 | **22** | ✅ |
| `SEAT-PO-*` | 001…024 | **24** | ✅ |
| `SEAT-CFG-*` | 001…018 | **18** | ✅ |
| `SEAT-NFR-*` | 001…012 | **12** | ✅ |
| `SEAT-AC-*` | 001…225 | **225** | ✅ |
| `SEAT-GAP-*` | 001…014 | **14** | ✅ |

Table rows confirm: **225 AC rows, 18 CFG rows.** No renumbering, no new identifier, §0.3 untouched.

### 2.4 Nothing deleted or weakened

Diffed `aab757c` → working tree: **exactly 3 sites differ**, all intended.

| Property | Before | After | Reading |
|---|---|---|---|
| `**MUST**` | 369 | **368** | −1: the fallback *mandate* was removed |
| `**MUST NOT**` | 223 | **225** | +2: replaced by two *prohibitions* |
| Net normative force | — | — | **Strengthened.** A permissive default became two explicit bans |
| Capability removed | — | **none** | The threshold remains configurable; only the silent 90% substitution is gone |
| `**MUST** remain operable` | present | **present** | `LIB-16.2` obligation intact |
| Status / version | v1.0 `DRAFT` | **v1.0 `DRAFT`** | Correctly not bumped — unfrozen document |

### 2.5 Stage 3 / Stage 4 regression

| Surface | Expected | Measured | Verdict |
|---|---|---|---|
| Edges cited | 13, 0 invented | **13, identical set** | ✅ |
| `E-05` payload | unchanged; threshold still *"Proposed"* | **unchanged** | ✅ |
| Section headings | 136 | **136** | ✅ |
| `tenantId` occurrences | 17 | **17** (identical to before) | ✅ |
| `SEAT-GAP-001` | open, untouched | **3 mentions, untouched** | ✅ |
| `SEAT-GAP-003` | open, untouched | **5 mentions, untouched** | ✅ |
| `SEAT-GAP-005` | open | **untouched** | ✅ |
| Orphan ACs | 0 | **0 / 225** | ✅ |
| Dangling citations | 0 | **0** | ✅ |

No security, tenancy, authorisation or edge-contract text was touched.

---

## 3. Correction to the earlier record

[`PRD-007_CORRECTION_RECORD.md`](PRD-007_CORRECTION_RECORD.md) recorded `RQ-1` as **RESOLVED** and asserted in its
§1.4 that *"No state is now ambiguous, and no two statements in the PRD disagree about any of the four."*

**That claim was wrong**, and the re-review disproved it. It was true of the six statements that record examined
and false of the document, because `SEAT-FR-212` was never inspected. The earlier record's `RQ-1` status should be
read as **PARTIALLY RESOLVED**, completed by this record. Its other conclusions — the `RQ-2` deferral reasoning,
the `RQ-3` partial-coverage disclosure, and its diff accounting — were independently verified as accurate.

The methodological lesson is recorded plainly: **a targeted correction scoped to the sites a review names will
miss sibling sites the review did not name.** The fix was to sweep the whole document for the offending
proposition, which is what §2.1 above now does.

---

## 4. What remains open — not touched by this correction

| ID | Severity | Status |
|---|---|---|
| `SR-2` | LOW | **Open** — `SEAT-FR-272` closed-list closure untested |
| `SR-3` | LOW | **Open** — `SEAT-NFR-009` max-row-count limb unbounded, lock limb unobservable |
| `SR-4` | LOW | **Open** — `SEAT-AC-169` says *"its default 90%"*; 90% is now a proposal. Deliberately not corrected: it is a preserve target and outside `SR-1` |
| `SR-5` | LOW | **Open** — `SEAT-EVT-001`/`004` cited only in *Then*, never *Verifies* |
| `RQ-2` | LOW | **Open, deferred** with reason and owner |
| `SEAT-GAP-001` / `SEAT-GAP-003` | — | **Open by instruction. Not resolved.** |

---

## 5. Readiness — and what this record does not claim

`SR-1`'s contradiction is eliminated and the rule is now testable through two existing criteria. All four
configurable states are deterministic, corroborated by six agreeing statements.

**I do not declare Stage 4 PASS.** The previous correction record claimed a resolution that did not survive
independent scrutiny, and the appropriate response to that is less self-certification, not more. Four LOW findings
remain open, and `SEAT-GAP-001`/`SEAT-GAP-003` are open by instruction.

**The PRD is ready to be submitted for a fresh independent Stage 4 re-review. That reviewer, not the author of
this correction, determines the verdict.**

---

## 6. What this correction did not do

- Did not rewrite or restructure the PRD
- Did not delete or weaken any requirement, capability or exclusion — normative force was **strengthened**
- Did not renumber any identifier, or create one
- Did not create a new acceptance criterion
- Did not create an ADR, Specification, API spec, DB schema or code
- Did not begin Stage 5, 6 or 7 — no traceability registration, no `IMPL-*` allocation, no freeze
- Did not modify any architecture, governance or frozen document
- Did not resolve `SEAT-GAP-001` or `SEAT-GAP-003`
- Did not address `SR-2`, `SR-3`, `SR-4` or `SR-5`
- Did not change the PRD's status, version or rank
- Did not declare a Stage 4 PASS
