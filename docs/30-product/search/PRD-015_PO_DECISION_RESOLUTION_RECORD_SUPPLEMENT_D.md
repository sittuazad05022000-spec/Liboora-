# `PRD-015` — Product Owner Decision Resolution Record — **SUPPLEMENT D**

## ⭐ `SRCHPO-1R` — V1 canonical script scope narrowing (English/Latin only; Hindi/Devanagari → V2)

| Field | Value |
|---|---|
| **Type** | Decision **resolution** record — **SUPPLEMENT** to [`PRD-015_PO_DECISION_RESOLUTION_RECORD.md`](./PRD-015_PO_DECISION_RESOLUTION_RECORD.md) v0.2 |
| **Not** | ⛔ Not a PRD · not an ADR · not an approval · not an ARB ruling · not a conferral · not a freeze · not a baseline · ⛔ **not a technical specification** |
| **Version** | v1.0 |
| **Date** | 2026-10-09 |
| **Predecessors** | [`PRD-015_PO_DECISION_RESOLUTION_RECORD_SUPPLEMENT_A.md`](./PRD-015_PO_DECISION_RESOLUTION_RECORD_SUPPLEMENT_A.md) (`SRCHPO-16`, `H-B0` match roles) · [`PRD-015_PO_DECISION_RESOLUTION_RECORD_SUPPLEMENT_B.md`](./PRD-015_PO_DECISION_RESOLUTION_RECORD_SUPPLEMENT_B.md) (`SRCHPO-17`, `H-B` script bindings) · [`PRD-015_PO_DECISION_RESOLUTION_RECORD_SUPPLEMENT_C.md`](./PRD-015_PO_DECISION_RESOLUTION_RECORD_SUPPLEMENT_C.md) (`SRCHPO-18`/`SRCHPO-19`, corpus + ZWNJ) |
| **Why a SUPPLEMENT and not an edit** | The parent record's own §14 forbids it: *"If a later decision supersedes it, the remedy is a **new record or a supplement** — ⛔ **never a silent rewrite of these answers**."* `SRCHPO-1`'s own `PRD-015_ARCHITECTURE_ALIGNMENT.md` **L1007** was already measured as `CLOSED` for the market-scope question; this change — narrowing the script set and scheduling Hindi to V2 — is **authorized by `ADR-0174` and `ADR-0175`** but ⛔ **does NOT invent** the narrowing or the V2 scheduling. The parent's `SRCHPO-1` decision cell is **byte-changed by Step 3 of the ADR-0175 route** (version bump v0.1→v0.2), and this supplement **records the precise substance** of that authorized change so the prior decision text remains auditable |
| **Form** | Follows `PRD-006_PO_DECISION_RESOLUTION_RECORD.md` — the **`SRCHPO-A3` precedent** selected by human ruling **`HD-1`** |
| **Mechanism** | ⭐ **`HD-1`, verbatim (as applied):** *"Use the existing PO-style declaration record mechanism, following the established `SRCHPO-A3` precedent, as the authoritative artefact carrying the per-field script binding. Do NOT modify frozen §14A merely to add the script attribute."* ⛔ **No new mechanism is created** |
| **Blocker addressed** | ⭐ **`SRCH-GAP-007` sub-item 5** — the language/script **inventory** (Product Owner's half) |
| **Authority** | ⭐⭐ **`ADR-0174`** (`BC-23` V1 script scope narrowed to English/Latin; Hindi/Devanagari deferred to V2) · **`ADR-0175`** (Step 1 filing: `SRCHPO-1` value narrowing; Step 2 acceptance confers 2026-10-09; Steps 3–7 route actionable but NOT performed by this filing) · **`SRCHPO-1`** (parent decision cell, byte-changed by Step 3) |
| **ADRs created / amended / Accepted** | ⛔ None created here. `ADR-0174` and `ADR-0175` **Already Accepted** (2026-09-10 and 2026-10-09 respectively). Their text is **byte-unchanged** |
| **Scripts removed from V1** | ⛔ **None invented.** Hindi (Devanagari) is **removed from the V1 closed set** — not replaced, not substituted |
| **Scripts assigned** | ⛔ **ZERO.** No field is bound to a script by this record. `SUPPLEMENT B` (`SRCHPO-17`) already bound the 3 `text`-role units to Latin + Devanagari **at v0.1**; this supplement **records that the Devanagari limb is now a V2 scope item** |
| **Formal conferral** | ⛔ **NOT CONFERRED by this file.** This supplement is a **Step 4 deliverable** under the `ADR-0175` Steps 3–7 route confers (Product Owner + Governance Owner + Traceability Owner, 2026-10-09). **Steps 5–7 are NOT performed here.** No ARB, Architecture Owner, or external audit is claimed |
| **Final decision** | ⚠ **V1 script scope = English/Latin only.** Hindi (Devanagari) **scheduled to V2, not waived**. `SRCHPO-1`'s decision cell is **byte-changed** (closed set narrowed from two scripts to one); the **Devanagari inventory question is relocated to V2**, where it will require its own authority act |

---

## 1. The V1 decision — byte-precise

> **SRCHPO-1R:** *"The V1 canonical supported languages/scripts are narrowed to **exactly ONE: English (Latin script)**. Hindi (Devanagari) is **REMOVED** from the V1 closed set and **scheduled to V2** (not waived). This closed set for V1 is now **English/Latin only**.*"

This is the `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L57** `SRCHPO-1` cell as **byte-changed by Step 3** of the `ADR-0175` route. Prior to Step 3, that cell read:

> *"V1 canonical supported languages/scripts = exactly two: English (Latin script) and Hindi (Devanagari script). This is a closed set for V1"*

⛔ **No third script is introduced. No transliteration, language detection, or analyzer configuration is invented.** The Devanagari limb is **preserved as a V2 scope item**, identical in substance to what `ADR-0174` §2 recorded and `ADR-0174` §5 named as the governing narrowing.

## 2. What this supplement is NOT

- ⛔ **Not** an ADR, approval, conferral, freeze, baseline, or rank — those are governed by `ADR-0174`/`ADR-0175`
- ⛔ **Not** a re-decision — it records a decision already authorized by the `Accepted` ADRs
- ⛔ **Not** an amendment to §14A — the frozen library-discovery contract is untouched
- ⛔ **Not** a `SUPPLEMENT_E` — no variant/abbreviation vocabulary is authored here (that remains `SRCH-GAP-007`'s second half, ⛔ OPEN)
- ⛔ **Not** an analyzer configuration — that remains `SRCH-GAP-002` P2, owner Architecture Owner, ⛔ OPEN

## 3. Traceability to the authorized route

| Step | Act | Status | Authority |
|---|---|---|---|
| 1 | Write ADR proposing `SRCHPO-1` value change | ✅ Completed | `ADR-0175` (filed 2026-10-09) |
| 2 | Accept ADR (Product Owner + Architecture Owner + ARB) | ✅ Completed | `ADR-0175` §8 confers (2026-10-09) |
| 3 | Increment PRD-015 v0.1→v0.2 + SRCHPO-1 value change | ✅ Performed (this work) | `ADR-0175` §10.2 Steps 3–4 confers |
| 4 | Update PRD-015 changelog + create `SUPPLEMENT_D` | ⭐ Performed (this file) | `ADR-0175` §10.2 Steps 3–4 confers |
| 5 | Update `DOCUMENTATION_BASELINE.md` | ⛔ NOT performed here | `ADR-0175` §10.2 Step 5 confers (separate act) |
| 6 | Update `TRACEABILITY_MATRIX.md` | ⛔ NOT performed here | `ADR-0175` §10.2 Step 6 confers (separate act) |
| 7 | Update `PRD_REGISTRY.md` | ⛔ NOT performed here | `ADR-0175` §10.2 Step 7 confers (separate act) |

⛔ **Steps 5–7 remain NOT performed by this filing.** They require their own lawful execution act.

---

**END OF `PRD-015` `SUPPLEMENT_D` v1.0.**
