# `ATT-GAP-015` — Owner Decision Request

**To:** Product Owner · Architecture Owner (ARB) — the two owners named in `PRD-006` §32
**Source:** `PRD-006_ATT-GAP-015_DECISION_PACK.md` v1.0 — this page adds no new analysis
**Subject:** `PRD-006_ATTENDANCE-MANAGEMENT.md` v1.3 DRAFT · SHA-256 `93ab1c60d740c4e0…`
**Status:** `ATT-GAP-015` 🔴 **OPEN** · `ADR-0021` **Proposed** · **no option selected in this document**

---

## THE DECISION

> **Is Face Attendance V1, V3, or deferred?**
> ☐ **Face V1** ☐ **Face V3** ☐ **Defer**

---

## EVIDENCE AVAILABLE

| # | Finding | Bearing |
|---|---|---|
| 1 | **No Rank 1–5 document places Face in V1.** | V1 is **not** ratifiable from sources |
| 2 | **No Rank 1–5 document places Face in V3.** | V3 is **not** ratifiable from sources either |
| 3 | EA v2.1 L754 lists `Face Recognition (V3)` — **Rank 6, descriptive only**. Baseline §4: *"Update it to match 1–5; **never the reverse**."* | EA cannot *force* V3, but it is the **only** classifying statement in existence |
| 4 | The V1 position rests on the **authoring instruction** for `PRD-006` — not a document, not a Rank 1–5 source | No reviewable record behind V1 |
| 5 | The only two Rank 3 documents mentioning biometrics are **exclusion rows** — `Authentication_PRD_v2.md` L968 (*"not an authentication factor the platform can verify"*) and `Student_Identity_PRD_v1.md` `SXC-4` (*"biometric-adjacent"*, excluded from `BC-10`) | Both **disown** biometrics; neither assigns a class |
| 6 | Rank 1 `MASTER_PRD.md` L160 classifies **the module** `Attendance Management = V1` but enumerates **zero** attendance modes | Rank 1 does **not** decide this question |
| 7 | `PRD-006` has overridden EA version tags **5 times** (Corrections, Clock Skew, Late Entry, Early Exit, Policies/Reports) — but **each had a Rank 1–5 basis**, e.g. `MP-GBR-11` for Corrections. **Face has none** | Why Face alone was raised as a gap |
| 8 | `PRD-006` L840: *"A biometric template cannot be pseudonymised — **it is the identifier**."* Platform erasure (`ID-5`, `MP-GBR-04`) is *"**structurally inapplicable**"* | The material risk if V1 is chosen |

**Conclusion on evidence:** neither classification can be *discovered*. It must be **made and recorded**.

---

## CONSEQUENCES OF EACH OPTION

| | **Face V1** | **Face V3** | **Defer** |
|---|---|---|---|
| **EA v2.1 L754** | Must be **corrected** to `(V1)` under Baseline §4 | No change — EA already consistent | No change |
| **`LIB-16.2` breach** | **7** settings | **6** settings | **7** settings |
| **`PRD-006` freezable?** | ❌ No | ❌ **No — still six settings breach** | ❌ No |
| **Live V1 obligations created** | `ATT-GAP-012` (template ownership) + `ATT-GAP-014` (retention/erasure incl. **minors**) | None | None |
| **Parties who must be heard** | **Security Platform + Legal counsel** | — | — |
| **`ATT-FR-064` build block** | Stands — correct outcome | Stands — now consistent with the class | Stands |
| **§12 specification** | Retained | **Retained** — only the release class changes | Retained |
| **Critical path** | Hardest gap stays in V1 | Hardest gap leaves V1 | **`ATT-CFG-014` stays undecidable indefinitely** |

> **Neither ruling unblocks the freeze.** Ruling V3 removes the hardest of the seven — the one needing Legal
> counsel, a biometric template owner and an unselected engine. **Any claim that it makes `PRD-006` freezable
> would be false.**

---

## WHAT CHANGES UNDER EACH OPTION

**Configurables** — `ATT-CFG-014` is the **only** Face setting in the breach:

| ID | Setting | Under **V1** | Under **V3** |
|---|---|---|---|
| `ATT-CFG-014` | Face match confidence threshold | 🔴 **In the breach.** Blocked by `ATT-GAP-012` + `014` | ➡️ **Leaves V1 scope.** Breach 7 → 6 |
| `ATT-CFG-013` · `015` · `016` | Enrollment · Liveness · Mode enabled | Defaults exist — **unaffected** | Unaffected |
| `ATT-CFG-005` · `006` · `011` · `012` · `019` · `023` | Non-Face settings | Unaffected — still required for V1 | Unaffected — still required for V1 |

**Gaps:**

| Gap | Under **V1** | Under **V3** |
|---|---|---|
| `ATT-GAP-012` — biometric template ownership | **Live V1 blocker** | ➡️ Out of V1 — **deferred, not closed** |
| `ATT-GAP-014` — retention/erasure incl. minors (**Legal**) | **Live V1 blocker** | ➡️ Out of V1 — deferred |
| `ATT-GAP-013` — face-scoped | Live in V1 | ➡️ Out of V1 |
| `ATT-GAP-009` — face-scanner device lifecycle | **Structural impasse**: `BC-18` owns Device only for auth; `BC-08` Inventory is **V2** and cannot own a **V1** scanner | ➡️ **Impasse dissolves** — `BC-08` could own a **V3** scanner. Remains open on *"any future attendance hardware"* |
| `ATT-GAP-017` — the seven defaults | 7 settings | ⚠️ **Narrows to 6.** Remains **OPEN** |
| `ATT-GAP-006` · `008` · `010` · `011` | Unrelated to Face | **Unaffected** |

**Net under V3: 3 gaps leave the V1 path, 1 relieved, 1 narrows — 14 remain.**

---

## EXACT APPROVAL STATEMENT — sign **one**

**Option A — Face is V1**
> `ATT-GAP-015` — RULING. Face attendance (`ATTENDANCE_MODE_FACE`, `PRD-006` §12) is classified **V1**. EA v2.1 L754 `Face Recognition (V3)` is **incorrect** and MUST be corrected to `(V1)` under `DOCUMENTATION_BASELINE.md` §4. We accept that `ATT-GAP-012` and `ATT-GAP-014` become **live V1 obligations**, that `ATT-CFG-014` remains within the `LIB-16.2` breach, and that `ATT-FR-064` continues to block implementation until both gaps are answered by their named owners. We confirm Security Platform and Legal counsel have been consulted on that exposure. `ATT-GAP-015` is **CLOSED — resolved V1**.

**Option B — Face is V3**
> `ATT-GAP-015` — RULING. Face attendance (`ATTENDANCE_MODE_FACE`, `PRD-006` §12) is classified **V3**, consistent with EA v2.1 L754; the EA requires no correction. §12 remains **specified but out of V1 scope**; `ATT-FR-064`'s build block stands. `ATT-CFG-014` leaves the V1 configuration surface and the `LIB-16.2` breach reduces from **seven settings to six**. We confirm this does **not** clear the breach and does **not** make `PRD-006` freezable. `ATT-GAP-012`, `ATT-GAP-013` and `ATT-GAP-014` are **deferred to V3 — deferred, not closed**; `ATT-GAP-009` is relieved for the V1 path insofar as it concerns the face scanner. `ATT-GAP-015` is **CLOSED — resolved V3**.

**Option C — Defer**
> `ATT-GAP-015` — DEFERRED. No classification is made at this time. `ATT-GAP-015` remains **OPEN** with reason: ______________________ and review date: __________. We accept that `ATT-CFG-014` remains undecidable, that the `LIB-16.2` breach remains at **seven** settings, and that `PRD-006` remains **unfreezable** for as long as this is deferred.

---

## REQUIRED APPROVERS — both signatures required, on the same option

| Role | Why required (`PRD_OWNERSHIP_MODEL.md` §2.2) | Signature | Date |
|---|---|---|---|
| **Product Owner** | *"Decides whether a requirement is correct and **in scope**."* Release class **is** scope | ______________________ | __________ |
| **Architecture Owner (ARB)** | *"Decides ADR approval; **any Rank 1–5 document change**."* Ratifying a class needs a Rank 2 ADR; correcting Rank 6 EA is an architecture act | ______________________ | __________ |

**Consulted, not approving:** Security Platform *(Domain Owner, `PRD-012a`)* and Legal counsel — **material only if Option A** · Technical Owner — informed (`IMPL-630`…`639`, `IMPL-679`).

> *"**The Product Owner is not the default answer.**"* — `PRD_OWNERSHIP_MODEL.md` §2.2. A single signature does not carry this decision.

---

**After signature:** an ADR must be raised (`ADR-0013` pattern — **`ADR-0021` §3 explicitly declines this gap**), `PRD-006` §12.5 and §32 updated, EA corrected if Option A, `ATT-GAP-017` rescoped, and the gate scripts re-run. Sequence at Decision Pack §6.1. **None of it is performed by this request.**

**This document selects no option, closes no gap, creates no ADR and freezes nothing.**
