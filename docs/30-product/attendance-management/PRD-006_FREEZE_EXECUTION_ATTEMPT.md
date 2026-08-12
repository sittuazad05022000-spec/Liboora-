# `PRD-006` Attendance Management — Freeze Execution Attempt

| Field | Value |
|---|---|
| **Document** | Record of an attempted execution of the full freeze workflow against `PRD-006` / `BC-03` |
| **Type** | Execution record. **Not a freeze, not a baseline row, not an ADR, not a decision.** Unranked; confers nothing |
| **Subject** | [`PRD-006_ATTENDANCE-MANAGEMENT.md`](./PRD-006_ATTENDANCE-MANAGEMENT.md) **v1.3 — DRAFT**, hash `93ab1c60d740c4e0…` — **unmodified** |
| **Authorising input** | [`PRD-006_CONSOLIDATED_DECISION_PACKAGE.md`](./PRD-006_CONSOLIDATED_DECISION_PACKAGE.md) v1.0 — treated as the source of truth for approvals, as instructed |
| **Outcome** | 🔴 **FREEZE NOT EXECUTED.** Every one of the eight instructed steps is gated on an approval that does not exist in the repository |
| **Steps executed** | **4 of 8** — those that are unconditional (gate re-runs, ADR inspection, arithmetic re-check) |
| **Steps not executed** | **4 of 8** — every step whose precondition is an approval, value or signature |
| **Version** | v1.0 · 2026-08-04 |

---

## 1. What was instructed, and what each step's precondition actually is

The instruction is written conditionally throughout — *"ARB approval available ho to record/process karo"*,
*"explicitly provided decisions/values hi apply karo"*, *"required approvals milne par"*, *"sirf sab freeze
conditions PASS hone par"*. **Each conditional was evaluated against the repository. None is satisfied.**

| # | Instructed step | Precondition | Precondition met? | Executed? |
|---|---|---|---|---|
| **1** | Block D — Face V3; record ARB approval if available | An ARB approval exists | 🔴 **No** | ⬜ Not executed |
| **2** | Block A — apply PO's *explicitly provided* values for `011`, `012`, `023` | PO has provided values | 🔴 **No** | ⬜ Not executed |
| **3** | Block B — apply Security Platform's *explicitly approved* ranges for `005`, `006` | Security Platform has approved a range | 🔴 **No** | ⬜ Not executed |
| **4** | Block C — apply `019` value *after* OCR architecture approval | `ADR-0022` + `ADR-0023` Accepted | 🔴 **No** — both Proposed | ⬜ Not executed |
| **5** | Inspect Proposed ADRs; complete workflow *if approvals received* | An approval received | 🔴 **No** | ✅ **Inspected** — §3 |
| **6** | Update PRD, ledger, registries, index, baseline *after approved decisions* | An approved decision exists | 🔴 **No** | ⬜ Not executed |
| **7** | Re-run Stage 4 → 5 → 6 → 7 gates independently | **None — unconditional** | ✅ n/a | ✅ **Executed** — §4 |
| **8** | Freeze *only if* all conditions PASS | All Stage 7 conditions pass | 🔴 **No** | ⬜ Not executed |

**Steps 5 and 7 were unconditional and were performed. Steps 1, 2, 3, 4, 6 and 8 were not, because performing
them would have required inventing the very thing the instruction forbids inventing.**

---

## 2. Approval state — measured, not assumed

Four independent mechanical searches were run against the current tree.

| Measurement | Command | Result |
|---|---|---|
| Approval checkboxes ticked in the consolidated package | `grep -c '☑\|\[x\]\|\[X\]'` across `attendance-management/` | **0** |
| Unticked checkboxes remaining | `grep -c '☐'` in the package | **24** |
| Signature lines filled | Inspection of all 5 signature tables | **0** |
| Any numeric value assigned to `005`/`006`/`011`/`012`/`019`/`023` | Regex for `= n`, `default: n`, `set to n`, `n seconds/minutes/metres/hours/days` across `docs/` | **0 matches** |
| Authoritative value in `docs/20-configuration/` | Concept search for all six settings | **None** |
| `ADR-0021` / `ADR-0022` / `ADR-0023` status | `grep '^\| \*\*Status\*\*'` | **Proposed · Proposed · Proposed** |

**Conclusion: no approval, signature, value or ADR acceptance has entered the repository.** The consolidated
decision package is in exactly the state it was created in — a correctly-formed request awaiting four
signatures.

### 2.1 The two branches, and which one applies

The instruction anticipates both outcomes explicitly:

> *"Values, approvals, signatures ya ADR acceptance invent mat karo. Missing human decision ho to usse guess mat
> karo; consolidated decision package mein ONE remaining blocker list maintain karo."*

**The second branch applies.** Executing steps 1–4 would have required fabricating between four and seven
approvals. Executing steps 6 and 8 would have required writing a Rank 3 baseline row on the strength of them.

---

## 3. Step 5 — ADR inspection performed; no acceptance was authorised

| ADR | Subject | Deciders named | Status | Acceptance possible today? |
|---|---|---|---|---|
| `ADR-0021` | Defaults and ranges for the configurables | **Product owner** (D-1) · **Governance owner** (D-2) · Architecture owner (acceptance) | **Proposed** | 🔴 No — no decider has signed; §4 options A–D all unselected |
| `ADR-0022` | May `BC-03` hold a `FileRef` from `BC-29`? | **Architecture owner (ARB)** | **Proposed** | 🔴 No — §4 options A–D all unselected |
| `ADR-0023` | Who owns OCR/Vision? | **Architecture owner (ARB)** | **Proposed** | 🔴 No — §4 options A–D all unselected |

`ADR-INDEX.md` defines the status: **Proposed** = *"Under consideration; **not binding**."*
Process step 1: *"A decision that changes structure, ownership, a boundary, or a platform-wide rule requires an
ADR **before** implementation."* An ADR whose options are unselected records no decision to implement.

**No ADR was accepted.** Marking one Accepted without a decider's selection would be fabricating authority —
prohibited by the instruction and by `ADR-INDEX.md`'s own vocabulary.

---

## 4. Step 7 — all four gates re-run independently

### 4.1 Stage 4 — re-review trigger test

| Test | Result |
|---|---|
| Commits touching `PRD-006_ATTENDANCE-MANAGEMENT.md` since `93fa81f` (the last re-review) | **0** |
| Hash at re-review time vs now | `93ab1c60d740c4e0…` — **identical** |

**No Stage 4 re-review is triggered.** The standing verdict ⚠️ **CONDITIONALLY PASSED** stands. Check 3
(*"every configurable has a default and a range"*) still **FAILS at 7 of 24**; the Stage 4 **gate** —
*"conflicts closed or explicitly deferred with a reason and an owner"* — remains **satisfied**.

### 4.2 Stage 5 — traceability gate: ✅ **PASS**, exit 0

Counts recomputed by the script, not read from prose:

| Register | Count | Range |
|---|---|---|
| `ATT-FR` | **151** | `001`…`151` |
| `ATT-BR` | **45** | `001`…`045` |
| `ATT-INV` | **12** | `001`…`012` |
| `ATT-EVT` | **4** | `001`…`004` |
| `ATT-XC` | **21** | `001`…`021` |
| `ATT-PO` | **14** | `001`…`014` |
| `ATT-CFG` | **24** | `001`…`024` |
| `ATT-NFR` | **14** | `001`…`014` |
| `ATT-AC` | **213** | `001`…`213` |
| `ATT-GAP` | **18** (+3 suffixed) | `001`…`018` |

**Total 516** · obligation-bearing **285** · occurrences **1262** across 519 distinct · AC rows / Verifies
**213 / 328** · dangling **0** · orphan **0** · `ATT-NFR-010` **285/285 = 100.0%** · ledger 21 rows —
2 resolved, 1 narrowed, **18 open** · collisions **0**.

### 4.3 Stage 6 — task coverage gate: ✅ **PASS**, exit 0

`ATT-FR` 151/151 · `ATT-BR` 45/45 · `ATT-INV` 12/12 · `ATT-EVT` 4/4 · `ATT-XC` 21/21 · `ATT-PO` 14/14 ·
`ATT-CFG` 24/24 · `ATT-NFR` 14/14 — **TOTAL 285/285 = 100.0%**.
80 tasks `IMPL-600`…`679` · 0 duplicates · 0 cycles · **12 BLOCKED** · **0 BLOCKED without a named gap**.

### 4.4 Stage 7 — the gate itself: 🔴 **UNSATISFIED**

`PRD_LIFECYCLE.md` L159:

> **Gate:** a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank.

| Measurement | Result |
|---|---|
| `grep -c 'attendance-management' DOCUMENTATION_BASELINE.md` | **0** |

**The row does not exist, in any form.** The gate is unsatisfied as a matter of fact, not of judgement.

---

## 5. `LIB-16.2` compliance — arithmetic recomputed from source

Computed by field-extracting the Default column of §16.3 rather than by reading any prior figure:

```
awk -F'|' '/^\| `ATT-CFG-/ {if ($5 ~ /ATT-GAP-017/) c++} END {print c+0}'   →  7
awk -F'|' '/^\| `ATT-CFG-/ && NF>8 {c++} END {print c+0}'                    → 24
```

| Metric | Value |
|---|---|
| Configurables total | **24** |
| Default column carries `ATT-GAP-017` instead of a value | **7** |
| With a concrete default and closed domain | **17** |
| **Default coverage** | **17 / 24 = 70.8%** |
| **Range coverage** | **17 / 24 = 70.8%** — the same seven lack both |
| `LIB-16.2` sentence 1 — *"Every setting MUST have a documented default"* | 🔴 **BREACHED** |
| `LIB-16.2` sentence 2 — *"A library that has changed nothing MUST be fully operable"* | ✅ **SATISFIED IN FACT** (`ATT-BR-044`) |

**Unchanged from the last measurement, because nothing that could change it has occurred.** The figure is
**17/24**, not 24/24.

---

## 6. Stage 7 freeze conditions — fresh audit

| # | Condition | State |
|---|---|---|
| 1 | Stage 3 valid | ✅ ⚠️ CONDITIONALLY ALIGNED, 0 architectural conflicts |
| 2 | Stage 4 valid | ✅ ⚠️ CONDITIONALLY PASSED against v1.3; no re-review triggered |
| 3 | Stage 5 PASS | ✅ exit 0 |
| 4 | Stage 6 PASS | ✅ exit 0, 285/285 |
| 5 | **Required human approvals complete** | 🔴 **NO — 0 of 7** |
| 6 | **Required ADRs accepted** | 🔴 **NO — 0 of 3** |
| 7 | **No live Rank 1–5 contradiction** | 🔴 **NO — `LIB-16.2` breach at 7 of 24** |
| 8 | **No freeze-blocking unresolved gap** | 🔴 **NO — `ATT-GAP-017`** |
| 9 | PRD header truthful | 🟡 PARTIAL — L11 stale, disclosed |
| 10 | Registry truthful | 🟡 PARTIAL — L236 `PLANNED`, pre-existing |
| 11 | ADR-INDEX truthful | 🟡 PARTIAL — *"0 proposed"* now stale by three |
| 12 | `DOCUMENTATION_BASELINE` truthful | ✅ Truthful by omission — it records no row, and there is none |
| 13 | **Admitting ADR exists** | 🔴 **NO** |

**4 pass · 3 partial · 6 fail.** Item 13 and the missing baseline row are the gate itself.

**Step 8 therefore did not execute**, per its own precondition: *"sirf sab freeze conditions PASS hone par."*

---

## 7. THE ONE REMAINING BLOCKER LIST

As instructed — one list, not several. **Every item is a human decision. None can be resolved by analysis.**

| # | Decision | Owner | Status | Blocks | What is needed |
|---|---|---|---|---|---|
| **1** | Face V3 — architecture ratification | **Architecture Owner (ARB)** | ⏳ PENDING | `ATT-GAP-015`; narrows breach 7→6 | Sign **Block D**. **Zero prerequisites** |
| **2** | `ATT-CFG-011` GPS acceptance radius | **Product Owner** | ⏳ PENDING | `ATT-GAP-017`; also an internal `ATT-FR-042` breach | Sign **A-1** — pick route (a)/(b)/(c)/(d) |
| **3** | `ATT-CFG-012` Minimum location accuracy | **Product Owner** | ⏳ PENDING | `ATT-GAP-017` | Sign **A-2** — route (a)/(b)/(c)/(d)/(f) |
| **4** | `ATT-CFG-023` Correction window | **Product Owner** | ⏳ PENDING | `ATT-GAP-017` | Sign **A-3**. Route (b) closes it **without a number** |
| **5** | `ATT-CFG-005` QR rotation interval | **Product Owner + Security Platform** | ⏳ PENDING | `ATT-GAP-017` | Sign **B-1**. Security supplies the range |
| **6** | `ATT-CFG-006` QR validity window | **Product Owner + Security Platform** | ⏳ PENDING | `ATT-GAP-017` | Sign **B-2**. §16.3 requires `006` ≥ `005` |
| **7** | `ATT-GAP-010` + `ATT-GAP-011` — OCR architecture | **Architecture Owner (ARB)** | ⏳ PENDING | `ATT-CFG-019` | Sign **C-1**; select an option in `ADR-0022` and `ADR-0023` |
| **8** | `ATT-CFG-019` OCR confidence threshold | **Product Owner** | 🔴 BLOCKED | `ATT-GAP-017` | **Item 7 first.** Route (d) — descope — signable today without it |
| **9** | Accept `ADR-0021` | Product + Architecture Owners | 🔴 BLOCKED | Freeze | Items 2–6 first |
| **10** | Confirm a CONDITIONAL Stage 3/4 verdict permits Stage 7 | **Governance Owner** | ⏳ PENDING | Freeze | Confirm `ADR-0021` §5 D-2. **No precedent exists** |
| **11** | Admitting ADR + Rank 3 baseline row | **Governance Owner** | 🔴 BLOCKED | Freeze | Everything above. **This act *is* the freeze** |

### 7.1 The critical path, shortest first

**Item 1** is the only decision with **zero prerequisites** and the largest single effect: it closes
`ATT-GAP-015`, defers `ATT-GAP-012`/`013`/`014` to V3, removes `ATT-CFG-014` from the V1 surface, and takes the
breach from **7 → 6** without anyone supplying a value.

**Items 2, 3, 4** are signable today by one owner with no external input. Together with item 1 they take the
breach to **7 → 3**.

**Item 8 route (d)** is signable today without item 7.

**Minimum path to clearing `LIB-16.2`:** items 1–8. **Minimum path to freeze:** items 1–11.

---

## 8. Verification — every claim recomputed

| # | Claim | Method | Result |
|---|---|---|---|
| 1 | Working tree clean; HEAD `9860abb` | `git status --porcelain` | ✅ 0 |
| 2 | 0 approvals ticked | `grep -c '☑\|\[x\]\|\[X\]'` | ✅ **0** |
| 3 | 24 checkboxes remain unticked | `grep -c '☐'` | ✅ **24** |
| 4 | 0 values assigned to the six | Regex across `docs/` | ✅ **0 matches** |
| 5 | 3 ADRs, all Proposed | `grep '^\| \*\*Status\*\*'` | ✅ 3 of 3 |
| 6 | No Stage 4 trigger | `git log 93fa81f..HEAD -- <subject>` | ✅ **0 commits** |
| 7 | Stage 5 PASS | `prd006_traceability.py` | ✅ exit 0, 516 / 285 |
| 8 | Stage 6 PASS | `prd006_task_coverage.py` | ✅ exit 0, 285/285 |
| 9 | No baseline row | `grep -c 'attendance-management'` | ✅ **0** |
| 10 | 7 of 24 lack a default | `awk` field extraction | ✅ **7 / 24** |
| 11 | Subject unmodified | `sha256sum` | ✅ `93ab1c60d740c4e0…` |
| 12 | 7 protected documents unmodified | `sha256sum` | ✅ 7 of 7 identical |
| 13 | No gate script modified | `git status` | ✅ 0 under `tool/` |
| 14 | No Dart source touched | `git status` | ✅ 0 under `lib/`, `test/` |
| 15 | Nothing pushed | No push executed | ✅ Local only |

---

## 9. What this execution deliberately did not do

| Not done | Why |
|---|---|
| Record an ARB approval | None exists. Recording one would fabricate authority |
| Apply a value to any of the six | None was provided. `ATT-BR-043` forbids substitution; §0.4 forbids resolution by implementation choice |
| Accept `ADR-0021`, `0022` or `0023` | No decider selected an option. **Proposed** means *not binding* |
| Update `PRD-006`, the gap ledger, the registry, `ADR-INDEX` or the baseline | Step 6's precondition is *"approved decisions ke baad"*. There are none |
| Add a Rank 3 baseline row | Baseline §7 step 1 requires an accepted ADR **before** the change |
| Mark `PRD-006` FROZEN | Freeze is **conferred, not claimed** — `PRD_LIFECYCLE.md` L161. Writing the word confers nothing |
| Weaken any gate | No script touched; the new artefact caused no collision |
| Create a second decision pack | One consolidated package exists and is complete. §7 maintains the single blocker list inside it |
| Push to GitHub | Prohibited |

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created. Records an attempted execution of the eight-step freeze workflow. **Four steps executed, four not.** Evaluated every conditional in the instruction against the repository and found none satisfied: **0** approval checkboxes ticked out of 24, **0** signature lines filled of 5, **0** numeric values assigned to any of the six configurables by any document, **0** authoritative values in `docs/20-configuration/`, and all three ADRs still **Proposed**. Inspected `ADR-0021`, `ADR-0022` and `ADR-0023` and accepted none — every §4 options list is unselected, and `ADR-INDEX.md` defines Proposed as *"under consideration; not binding"*. Re-ran all four gates independently: **Stage 4** — no re-review triggered (0 commits touched the subject since `93fa81f`, hash identical), verdict ⚠️ CONDITIONALLY PASSED unchanged and not upgraded; **Stage 5** — exit 0, 516 identifiers, 285 obligation-bearing, 0 dangling, 0 orphan, 0 collisions; **Stage 6** — exit 0, 285/285 = 100.0%, 12 BLOCKED, 0 blocked without a named gap; **Stage 7** — `grep -c 'attendance-management'` in the baseline returns **0**, so the gate is unsatisfied as a matter of fact. Recomputed `LIB-16.2` arithmetic by field-extracting the Default column with `awk` rather than reading any prior figure: **7 of 24** settings carry `ATT-GAP-017`, giving **17/24 = 70.8%** default and range coverage; sentence 1 breached, sentence 2 satisfied in fact. Audited all 13 Stage 7 conditions — **4 pass, 3 partial, 6 fail** — and did not execute step 8. Maintains **ONE** remaining blocker list of 11 human decisions with owner, status and required action, and identifies the critical path: Block D has zero prerequisites and the largest single effect. **No approval, value, signature or ADR acceptance was invented; no gap was closed; no gate was weakened; `PRD-006` and all seven protected governance documents are byte-identical; no code was written; nothing was pushed.** |
