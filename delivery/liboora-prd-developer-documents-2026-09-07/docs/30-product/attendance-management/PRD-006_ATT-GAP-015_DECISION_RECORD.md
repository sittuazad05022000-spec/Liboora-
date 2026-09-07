# `ATT-GAP-015` — Decision Record: Face Attendance = **V3**

| Field | Value |
|---|---|
| **Document** | `ATT-GAP-015` Decision Record |
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
| **Decision** | **Face Attendance = V3** |
| **Product Owner** | ✅ **DECIDED — V3** (this record) · **re-affirmed 2026-08-04 as D-3a — FINAL on the product side** |
| **Architecture Owner / ARB** | ⏳ **PENDING — no approval evidence exists** (§2; re-searched 2026-08-04, all three ADRs still `Proposed`) |
| **`ATT-GAP-015` status** | 🔴 **OPEN — cannot close on one signature** (§3) |
| **Source** | `PRD-006_ATT-GAP-015_DECISION_PACK.md` v1.0 · `PRD-006_ATT-GAP-015_APPROVAL_REQUEST.md` — sole sources |
| **Subject** | `PRD-006_ATTENDANCE-MANAGEMENT.md` v1.3 DRAFT · SHA-256 `93ab1c60d740c4e0…` **unmodified** |

> **What this record is.** It documents the Product Owner's decision and the outstanding ARB requirement. It is
> the *"decision/approval record required to document this decision"* and nothing more. It does **not** amend
> `PRD-006`, does **not** raise or accept an ADR, does **not** modify the Registry or Baseline, does **not**
> resolve `ATT-GAP-017`, does **not** invent biometric architecture or any configurable value, and freezes
> nothing.

---

## 1. The decision as taken

**Product Owner ruling, recorded verbatim from Approval Request Option B:**

> `ATT-GAP-015` — RULING. Face attendance (`ATTENDANCE_MODE_FACE`, `PRD-006` §12) is classified **V3**,
> consistent with EA v2.1 L754; the EA requires no correction. §12 remains **specified but out of V1 scope**;
> `ATT-FR-064`'s build block stands. `ATT-CFG-014` leaves the V1 configuration surface and the `LIB-16.2`
> breach reduces from **seven settings to six**. We confirm this does **not** clear the breach and does **not**
> make `PRD-006` freezable. `ATT-GAP-012`, `ATT-GAP-013` and `ATT-GAP-014` are **deferred to V3 — deferred,
> not closed**; `ATT-GAP-009` is relieved for the V1 path insofar as it concerns the face scanner.
> `ATT-GAP-015` is **CLOSED — resolved V3**.

| Approver | Required because | Status |
|---|---|---|
| **Product Owner** | `PRD_OWNERSHIP_MODEL.md` §2.2 — *"Decides whether a requirement is correct and **in scope**."* Release class is scope | ✅ **DECIDED — Face = V3**, 2026-08-04 |
| **Architecture Owner (ARB)** | §2.2 — *"Decides ADR approval; **any Rank 1–5 document change**."* | ⏳ **PENDING** |

**The ruling requires no EA correction.** Option B is consistent with EA v2.1 L754 `Face Recognition (V3)` as
it already stands. `LIBOORA_ENTERPRISE_ARCHITECTURE.md` is unmodified — verified `5ef1d63a36f9bd2f`.

---

## 2. Architecture Owner / ARB approval — **PENDING**

Instruction 2 required ARB approval to be recorded as pending *"unless already explicitly evidenced."*
**A search was run to test for existing evidence. None exists.**

| Search | Result |
|---|---|
| `ARB` / `Architecture Review Board` / `Architecture Owner` intersected with `ATT-GAP-015` or `Face` | **No approval record.** Every hit names the Architecture Owner as a *required decider* or *blocked-on party* — none records a decision |
| `ATT-GAP-015` intersected with `closed` / `resolved` / `accepted` / `approved` / `ruling` / `signed` | **No closure record.** Hits are the unsigned templates in the Pack and Approval Request, plus `PRD-006_REQUIREMENTS_REVIEW.md` L742 which reads 🔴 **OPEN** |
| Signature lines in `PRD-006_ATT-GAP-015_APPROVAL_REQUEST.md` | **3 blank** — unsigned |
| ADRs in `docs/00-governance/adr/` | **22 files, unchanged.** No ADR records this ruling |

**Conclusion: ARB approval is ⏳ PENDING and is recorded as such.** The Product Owner's authority over scope
is not in question; what is outstanding is the second required signature and the Rank 2 instrument.

---

## 3. Why `ATT-GAP-015` remains OPEN despite a Product Owner decision

`PRD-006` §32 L2175 names the owner as **"Product owner **+** architecture owner"** — a conjunction, not an
alternative. The ledger verdict at L2209 says the gap *"**cannot self-close**."*

Governance is explicit that one signature is insufficient here. `PRD_OWNERSHIP_MODEL.md` §2.2:

> *"**The Product Owner is not the default answer.** `ADR-0011`'s header records 'Deciders: Product owner
> (authoritative ruling); Principal Enterprise Architect; DDD reviewer' — three roles for one decision."*

Two things are therefore true at once, and both are recorded:

| | |
|---|---|
| **The product decision is made** | Face = V3. It is the Product Owner's to make, and it is recorded here |
| **The gap is not closed** | Closure needs the ARB signature and the Rank 2 ADR. `ATT-GAP-015` stays 🔴 **OPEN** in `PRD-006` §32 |

> **This distinction is not pedantry — it changes the arithmetic.** The Decision Pack's *"14 gaps remain"* figure
> assumed a **completed** ruling in which `ATT-GAP-015` itself closes. With ARB pending, nothing has yet left
> the register: **18 open gaps today, unchanged.** §4 reports both states so neither is mistaken for the other.

---

## 4. Recalculation — what Face V3 removes or narrows

**Two columns, deliberately.** *On ARB approval* is what the ruling delivers once complete; *Today* is the
measured state with ARB pending. Only the second is currently true.

### 4.1 Gaps

| Gap | Question | Owner | On ARB approval | **Today** |
|---|---|---|---|---|
| `ATT-GAP-012` | Who owns/stores the biometric template? *(storage sub-question already resolved negatively — `BC-03` has no `E-22` path)* | Architecture Owner + Security Platform | ➡️ **Out of V1** — deferred to V3, **not closed** | 🔴 OPEN |
| `ATT-GAP-013` | What liveness/anti-spoofing capability exists, and who provides it? *(no biometric liveness capability exists)* | Architecture Owner | ➡️ **Out of V1** — deferred to V3 | 🔴 OPEN |
| `ATT-GAP-014` | Biometric retention and erasure, **including minors** *(a conflict, not a void — `ID-5` pseudonymisation is structurally inapplicable)* | **Legal counsel** + Security Platform | ➡️ **Out of V1** — deferred to V3 | 🔴 OPEN |
| `ATT-GAP-009` | Who owns the face-scanner device lifecycle? | Architecture Owner | ⚠️ **Substantially relieved** — the impasse was that `BC-08` is V2 and could not own a **V1** scanner; it can own a **V3** one. **Remains open** on *"any future attendance hardware"* | 🔴 OPEN |
| `ATT-GAP-015` | Is Face V1 or V3? | Product + Architecture | ➡️ **CLOSES — resolved V3** | 🔴 **OPEN — ARB pending** |
| `ATT-GAP-017` | The seven configurable defaults | Product Owner | ⚠️ **Narrows to six.** **Remains OPEN** | 🔴 OPEN — **seven** |

**Unaffected — stated so the ruling is not read as delivering more than it does:**
`ATT-GAP-006` (cryptographic construction, Dynamic QR) · `ATT-GAP-008` (GPS centre ownership) ·
`ATT-GAP-010` / `ATT-GAP-011` (`FileRef` and OCR ownership — independently build-blocked by `ATT-FR-080`) ·
and the remaining register entries.

**Gap arithmetic:**

| State | Open gaps |
|---|---|
| **Today** — ARB pending, ledger measured | **18** |
| On ARB approval — 3 deferred to V3, `ATT-GAP-015` closes | **14** |

### 4.2 Configurables

| ID | Setting | On ARB approval | **Today** |
|---|---|---|---|
| `ATT-CFG-014` | Face match confidence threshold | ➡️ **Leaves the V1 configuration surface.** Breach 7 → 6 | 🔴 In the breach — **7 of 7** |
| `ATT-CFG-013` | Face enrollment required before use | Default **Enabled** — never in the breach | Unaffected |
| `ATT-CFG-015` | Face liveness required | Default **Enabled** — never in the breach | Unaffected |
| `ATT-CFG-016` | Face mode enabled | Default **Disabled** — never in the breach | Unaffected |
| `ATT-CFG-005` `006` `011` `012` `019` `023` | Non-Face settings | **Unaffected — still required for V1** | 🔴 Still in the breach |

**`ATT-CFG-014` is the only configurable this ruling touches.** It is not deleted, and no value is proposed for
it here or anywhere.

**Breach arithmetic:**

| State | Settings breaching `LIB-16.2` |
|---|---|
| **Today** — ARB pending | **7** — `005`, `006`, `011`, `012`, `014`, `019`, `023` |
| On ARB approval | **6** — `014` removed |

### 4.3 What the ruling does **not** change

| Unchanged | Why |
|---|---|
| `PRD-006` §12 | The Face mode **stays fully specified**. Only its release class changes |
| `ATT-FR-064` build block | Stands. Now consistent with the version class rather than an exception inside it |
| The `LIB-16.2` breach | Reduced by one setting on approval. **Still a live breach** |
| `ATT-GAP-017` | **NOT resolved.** Narrows to six settings on approval; remains OPEN |
| EA v2.1 L754 | No correction required — Option B is already consistent with it |
| `ADR-0021` | **Proposed**, untouched. Its §3 explicitly declines this gap |

---

## 5. What remains blocking Stage 7

**`PRD-006` is NOT freezable.** The Product Owner's ruling improves the critical path; it does not clear the
blocker. Reported in full at §7 of the report accompanying this record.

| # | Blocker | Status after this decision |
|---|---|---|
| **1** | **`LIB-16.2` live breach** — *"Every setting **MUST** have a documented default"* | 🔴 **7 settings today**, 6 on ARB approval. **Still breaching either way** |
| **2** | `ATT-GAP-017` | 🔴 **OPEN.** Narrows to six on approval; not resolved |
| **3** | **ARB signature on `ATT-GAP-015`** | ⏳ **PENDING** — a *new* item, created by this decision being one-sided |
| **4** | Rank 2 ADR recording the ruling | ⏳ **Not raised.** `ADR-0013` pattern; Architecture Owner's call |
| **5** | `ADR-0021` at **Proposed** | ⏳ Not binding until its deciders accept it |
| **6** | No baseline row in `DOCUMENTATION_BASELINE.md` §3 | 🔴 Stage 7's actual gate |
| **7** | `PRD_REGISTRY.md` L236 reads `PLANNED` | 🔴 Pre-existing defect, governance owner |

**The freeze path is unchanged in shape**: five of the six remaining settings must be documented by their
owners before `LIB-16.2` is satisfied, and only then can a baseline row be created.

---

## 6. Verification

| Claim | Method | Result |
|---|---|---|
| Ruling text matches Approval Request Option B | Character comparison | **Verbatim** |
| No ARB approval evidence exists | Two intersected repo-wide searches | **None found** — every hit names ARB as *required*, never as *having decided* |
| Approval Request unsigned | Signature-line scan | **3 blank lines** |
| No ADR records this ruling | `ls docs/00-governance/adr/` | **22 files** — unchanged, none created |
| `ATT-GAP-015` still OPEN in the subject | `PRD-006` L2209 | 🔴 *"OPEN — correctly framed, cannot self-close"* |
| Open-gap count today | `prd006_traceability.py` ledger | **21 rows — 2 resolved, 1 narrowed, 18 open** |
| Pack's "14 remain" reconciled | 18 − 3 deferred − `ATT-GAP-015` closing = 14 | **Valid only on ARB approval.** Today: 18 |
| `ATT-CFG-014` is the only Face setting in the breach | §16.3 L1167–1170 | `013` Enabled · `015` Enabled · `016` Disabled — only `014` cites `ATT-GAP-017` |
| `ATT-GAP-013` is Architecture Owner's | `PRD-006` L2173 | Confirmed |
| `ATT-GAP-014` is Legal counsel's | `PRD-006` L2174 | Confirmed |
| Option B needs no EA change | EA L754 already `(V3)` | Confirmed; EA `5ef1d63a36f9bd2f` unmodified |
| Subject unmodified | SHA-256 | `93ab1c60d740c4e0…` |
| Registry / Baseline unmodified | SHA-256 | `f8e71ce876c2b53b` · `42405be29d392e14` |
| `ADR-0021` unmodified | Header L5 | **Proposed** |
| Zero configurable values | Full-document scan | **0** thresholds, durations or distances |
| No biometric architecture invented | Full-document scan | No engine, template store, format, liveness method or retention rule appears |

---

## 7. What this record deliberately did not do

| Not done | Why |
|---|---|
| Close `ATT-GAP-015` | ARB signature outstanding; §32 names **both** owners (§3) |
| Modify `PRD-006` §12.5 or §32 | Instruction 3 limits this to the decision/approval record. Step 2 of Pack §6.1 belongs to the `PRD-006` owner **after** ARB approval |
| Raise or accept an ADR | Instruction: do not create or accept an ADR. Architecture Owner's call |
| Mark `ADR-0021` Accepted | Not this decision's instrument; its §3 declines this gap |
| Resolve `ATT-GAP-017` | Instruction 7. It narrows to six **on approval**; it does not resolve |
| Invent values for `005`, `006`, `011`, `012`, `019`, `023` | Instruction 8. `ATT-BR-043` forbids substitution |
| Invent biometric architecture, thresholds, retention rules | Instruction 5. `ATT-GAP-012`/`013`/`014` are **deferred, not answered** |
| Close `ATT-GAP-009`, `012`, `013`, `014` | Deferral moves a question out of the V1 path; it does not answer it |
| Modify Registry or Baseline | Instruction 9 |
| Freeze `PRD-006` | Instruction 6. §5 lists seven outstanding blockers |
| Correct EA v2.1 | Option B requires no correction |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-04 | **Product Owner re-affirmed the V3 ruling as decision D-5/D-3a** in the final freeze instruction: *"D-3a = APPROVED → Face Attendance = V3."* §1's ruling is therefore **final on the product side** and is preserved byte-identical — re-affirmation, not re-decision. **ARB approval remains ⏳ PENDING** and a third search this run again found **no approval evidence**: `ADR-0021`, `ADR-0022` and `ADR-0023` all still read `Status | **Proposed** — not binding`, and the Approval Request's signature lines are still blank. **`ATT-GAP-015` therefore stays 🔴 OPEN** — L2175's owner column is a conjunction and L2209 states the gap *"cannot self-close"*, so one final signature of two does not close it. Recorded the consequence for `ATT-CFG-014` as **the setting leaving the V1 configuration surface**, on `ADR-0021` §4 Option D's principle *"The settings cease to exist in V1, so **no default is owed**"* — which moves `ATT-GAP-017` from **14 required answers to 12** and the `LIB-16.2` sentence-1 breach from **four settings to three**. Recorded, without acting on it, that `ADR-0021` §4.2 states Stage 3 and Stage 4 verdicts **remain ⚠️ CONDITIONAL** even once values arrive — *"the condition simply ceases to be *this* one, so §5 still applies"* — so the D-9 governance question is not dissolved by any product decision. **No ARB approval invented, no ADR accepted or created, no configurable value supplied, no biometric architecture invented, `PRD-006` byte-identical at `93ab1c60d740c4e0`, and `ADR-0021`, `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md` and EA v2.1 all unchanged.** |
| **v1.0** | 2026-08-04 | Records the **Product Owner's ruling that Face Attendance = V3**, verbatim from Approval Request Option B. Records **Architecture Owner / ARB approval as ⏳ PENDING** after two repo-wide searches found **no approval evidence** — every ARB hit names the role as a *required decider*, never as having decided; the Approval Request's three signature lines are blank; no ADR exists. Records that **`ATT-GAP-015` therefore remains 🔴 OPEN**, because `PRD-006` §32 names *"Product owner **+** architecture owner"* conjunctively and the ledger states the gap *"cannot self-close"*. **Corrects a reading of the Decision Pack's "14 gaps remain" figure**: that number assumed a completed ruling in which `ATT-GAP-015` itself closes, so with ARB pending the measured count is **18 open, unchanged** — both states are reported side by side throughout §4 so neither is mistaken for the other. Recalculates the effect of the ruling: on ARB approval `ATT-GAP-012`, `ATT-GAP-013` and `ATT-GAP-014` leave the V1 path (**deferred, not closed**), `ATT-GAP-009`'s structural impasse is relieved because `BC-08` Inventory is V2 and can own a **V3** scanner though not a V1 one, `ATT-GAP-017` narrows from seven settings to six, and `ATT-CFG-014` leaves the V1 configuration surface — while `ATT-CFG-013`, `015` and `016` were never in the breach and `ATT-CFG-005`, `006`, `011`, `012`, `019`, `023` are untouched. States plainly that **`PRD-006` is not freezable**, listing seven outstanding Stage 7 blockers including a **new** one created by this decision being one-sided: the outstanding ARB signature. **No value is proposed for any configurable, no biometric architecture is invented, `ATT-GAP-017` is not resolved, no ADR is created or accepted, and `PRD-006`, `ADR-0021`, `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md` and EA v2.1 are all byte-identical.** |
