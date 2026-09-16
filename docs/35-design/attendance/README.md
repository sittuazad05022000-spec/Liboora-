<!-- LIBOORA | docs/35-design/attendance/ | BC-03 Attendance — directory index -->

> ⛔⛔ **This file is a directory index, not a Design Doc.** ⛔ It creates no
> requirement, permission, role, surface, status or readiness. ⭐ Every fact
> below is **restated** from
> [`DD-0003`](DD-0003-attendance-surface-design.md); ⛔ where this file and
> `DD-0003` disagree, **`DD-0003` wins and this file is the defect.**

# `BC-03` Attendance — design directory

⭐ **Single source of truth:**
[**`DD-0003-attendance-surface-design.md`**](DD-0003-attendance-surface-design.md)

---

## 1. Overview

⭐ `BC-03` Attendance owns the **verified record of physical presence** —
check-in, optional check-out, the method used, the evidence gathered, and the
full history of any correction — for a student, in a tenant, on a day.
⭐ Aggregate: **`AttendanceDay`** — *one student-day, **not** one punch*.

⭐ `DD-0003` specifies the Attendance surfaces precisely enough that a Figma
prototype could be built **without inventing UX**, across the two
applications that carry attendance experience.

| Measure | Value *(`DD-0003` §8–§12)* |
|---|---|
| Surfaces | **32** — ⭐ **23 designable now**, 9 blocked |
| Flows | **17** — 13 designable |
| States | **26**, across **4 independent axes** |
| Edge cases | **34** |
| Distinguishable failure signals | **19** |
| ⭐ **Mandated silences** | **4** — situations that **MUST NOT** notify |
| Status vocabulary | **9** *(Product-Owner-fixed)* |
| Seat Card renderings | **6** — ⭐ 4 buildable |

---

## 2. Document

| Field | Value |
|---|---|
| **Design Doc** | ⭐ [`DD-0003-attendance-surface-design.md`](DD-0003-attendance-surface-design.md) |
| **Path** | `docs/35-design/attendance/DD-0003-attendance-surface-design.md` |
| **Version** | **v0.1** — 35 sections |
| **Subject PRD** | [`PRD-006`](../../30-product/attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md) Attendance Management — **`FROZEN` v1.9, Rank 3**, admitted by **`ADR-0034`** (`Accepted`) under `BASELINE-2026-08-05-A` |
| **Registered in** | ⭐ [`../README.md`](../README.md) §2A central catalog |

---

## 3. Status

| Field | Value |
|---|---|
| **Status** | ⛔ **`PROPOSED`** |
| **Approved?** | ⛔ **NOT APPROVED** |
| **Frozen?** | ⛔ **NOT FROZEN** |
| **Rank** | ⛔⛔ **UNRANKED** |

⛔ **`DD-0003` does not claim its own status.** ⭐ Where it disagrees with any
ranked document, **the ranked document wins and the Design Doc is the
defect.**

⛔ **It authorises nothing** — ⛔ not implementation, ⛔ not a `TS-*`
*(no `TS-003` is created, implied, authorised, allocated or reserved)*, ⛔ not
Figma, ⛔ not a code change, ⛔ not any PRD/ADR amendment, and ⛔ it closes no
gap.

---

## 4. Readiness

# ⭐⭐ READY WITH EXPLICIT DESIGN GAPS

| Why not `READY` | Why not `NOT READY` |
|---|---|
| ⛔ **3 blocking gaps** and ⚪ 6 TBDs are real; `ATT-GAP-002a` alone removes **5 states** | ⭐ **48** requirement groups are `COVERED` and ⭐ **23 of 32 surfaces are designable today** — calling the whole feature `NOT READY` would be **factually false** |

⭐⭐ **The three blockers each block only their own named subset.** ⛔ None
blocks the Design Doc — which is the separability `PRD-006` §13E itself
endorses.

---

## 5. ⭐⭐ Final three-app boundary

⭐ Declared in full at `DD-0003` **§3**; App-Boundary QA verdict at **§4**.

| App | Roles | Attendance surfaces |
|---|---|---|
| ⭐ **APP 1 — Student App** | `TR-4` **Student** · `TR-5` **Parent** | **16** |
| ⭐ **APP 2 — Library App** | `TR-1` **Owner** · `TR-2` **Manager** · `TR-3` **Reception** | **16** |
| ⛔⛔ **APP 3 — Platform Admin App** | ⛔ *(none)* | ⭐⭐ **0 — ZERO Attendance surfaces** |

### ⭐ App-Boundary QA: **PASS**

⭐ 13 checks — **11 PASS · 0 GAP · 0 CONFLICT · 2 TO BE DECIDED.**

### ⭐⭐ Why APP 3 = 0 — measured, not assumed

⭐ Six independent sources, recorded at `DD-0003` §3.6:

| # | Source | Effect |
|---|---|---|
| 1 | `ATT-FR-003` | ⛔ *"MUST use only the **five roles**… MUST NOT define, introduce, extend or infer any role"* — ⭐ all five are **tenant** roles |
| 2 | `ATT-FR-005` | ⭐ Scope register closed at `self` / `guardianOf` / `tenantWide` — ⛔ **no platform scope exists to hold a surface** |
| 3 | `ATT-FR-118` | ⛔ No new RBAC, role, permission model or scope |
| 4 | `PRD-006` §19.2 | ⭐ **8 operations × 5 roles — ⛔ no platform role appears** |
| 5 | `PRD-001` **`AUTH-2.5`** | ⛔ *"Platform roles **MUST NOT** grant access to tenant business data"* — ⭐ and **attendance records ARE tenant business data** |
| 6 | `ATT-NFR-006`, §20 | ⭐ Tenant-isolated to the `X-13` standard |

⭐ **Parent (`TR-5`) is a role inside the Student App — ⛔ not a separate
application.**
⛔ **Library Owner (`TR-1`) ≠ "Platform Owner".** `TR-1` governs one tenant;
platform roles are `PR-1`/`PR-2` and hold **nothing** here. ⛔ *"Platform
Owner"* is **not** cited as an authoritative identifier
(`DSN-APP-GAP-001` — measured **irrelevant** to `BC-03`, `DD-0003` §3.7).

---

## 6. ⛔⛔ Current blockers — 3

| Blocker | Blocks | Owner |
|---|---|---|
| ⛔⛔ **`ATT-GAP-002a`** — `BC-03` has **no authorised input** carrying a student's **booked shift** | ⭐ 3 statuses *(`SCHEDULE MISMATCH` · `NO BOOKED SHIFT` · `SHIFT OVERSTAY`)* · 2 Seat Card renderings · the tolerance-window fact · **axis 2 of `ATT-AC-222`** · `ATT-AC-221` | ⭐ **Architecture Owner** — `ADR-0029` ⛔ **`Proposed`** |
| ⛔⛔ **`ATT-FR-064`** — Face **MUST NOT** be implemented until `ATT-GAP-012` **and** `ATT-GAP-014` are answered | ⭐ Mode 5 entirely — `S-S6`, `S-L15`, `F-5` | ⭐ Architecture + Security Platform + **Legal Counsel** |
| ⛔⛔ **`ATT-FR-080`** — the OCR/Vision workflow **MUST NOT** be implemented until `ATT-GAP-010` **and** `ATT-GAP-011` are answered | ⭐ `S-L3`, `S-L4`, `F-12`, `F-13` | ⭐ Architecture Owner |

⭐ Blocked subsets are **recorded, ⛔ not designed** — ⛔ no wireframe, no
component spec and no copy exists for them, so nothing has to be unwound when
an owner decides.

⭐ Also open and preserved: **12** non-blocking `ATT-GAP-*` · ⚪ **6**
`DD3-GAP-*` TBDs · ⚠️ **9** implementation deviations · ⛔ 1 inherited
conflict `ATT-GAP-015` · ⚠️ 1 source defect `DD3-DEFECT-001`
(`DD-0003` §30).

---

## 7. ⭐ Key design constraints

⭐ All restated from `PRD-006`. ⛔ **None is invented here.**

### 7.1 Mode independence

| Constraint | Source |
|---|---|
| ⛔⛔ **There is no `QR → GPS → Wi-Fi → Face` chain.** ⛔ No verification pipeline, chain or stepper | `ATT-XC-011`, §7.2 |
| ⭐ The **six** V1 modes are independent; **any one** is sufficient | `ATT-BR-004`/`005` |
| ⛔ One attendance **MUST NOT** require two methods | `ATT-BR-005` |
| ⭐ Modes 3/4 are **one mode with a compound condition** — ⛔ not two composed | `ATT-BR-006` |
| ⭐⭐ **Manual attendance is FIRST-CLASS** — ⛔ not a fallback, ⛔ not a degraded path, ⛔ needs no justification | `ATT-BR-023` |
| ⭐ A smartphone is **NOT** mandatory | `ATT-BR-008`, goal `G-6` |

### 7.2 ⭐⭐ The two-axis rule — the sharpest constraint

⭐ **`ATT-AC-222`:** presence and shift-conformance are **two axes** and are
⛔ **never collapsed into one**. A student present beyond the booked window is
reported **present** *and* **outside the booked window**; ⛔ the overstay
**MUST NOT** suppress, downgrade or recolour the presence fact, and ⛔ the
presence fact **MUST NOT** conceal the overstay.

⭐⭐ **A single badge is therefore prohibited, not merely imprecise.**
⚠️ And axis 2 is **currently not computable** — `ATT-GAP-002a`. ⭐ `DD-0003`
§11.5 renders it as an explicit ⚪ *"not available"* row rather than ⛔ omitting
it or ⛔ substituting branch opening hours *(which §10A.7 expressly forbids)*.

### 7.3 Feedback and failure

| Constraint | Source |
|---|---|
| ⭐⭐ A **duplicate scan is treated as SUCCESS** — ⛔ never a warning | `ATT-FR-019`, `ATT-INV-003` |
| ⛔⛔ **No silent failure** — *"'nothing happened' is not an acceptable result of a scan"* | `ATT-BR-011` |
| ⭐ Every rejection carries a **specific, distinguishable** reason — *"a generic failure is a defect"* | `ATT-NFR-005` |
| ⭐ *"expired"* ≠ *"invalid"* | `ATT-FR-026` |
| ⭐ *"network unavailable"* ≠ *"network not approved"* | `ATT-FR-034`/`035` |
| ⭐ *"permission denied"* ⛔ **MUST NOT** be reported as a system error | `ATT-FR-044` |
| ⛔⛔ **No silent downgrade** to a weaker mode | `ATT-FR-036`/`047` |
| ⛔ ⚪ `NOT ATTENDED` and 🟠 `PRESENCE UNVERIFIED` are **never merged** | `ATT-AC-215` |

### 7.4 Honesty about what the product knows

| Constraint | Source |
|---|---|
| ⛔ Face **MUST NEVER** guess — multiple/ambiguous matches fail distinguishably | `ATT-FR-057`/`058` |
| ⛔ Face is **NOT** authentication | `ATT-XC-018` |
| ⛔ Wi-Fi is **NOT** identity, and ⛔ **MUST NOT** be claimed to prevent sharing | `ATT-XC-014` |
| ⛔ GPS is **NOT** identity | `ATT-XC-016` |
| ⛔⛔ **No mode may be presented as spoof-resistant** | `ATT-FR-039`/`050`, `ATT-BR-042` |
| ⛔ No raw **SSID / BSSID / MAC / signal strength** crosses the module boundary | `ATT-AC-218` |
| ⭐⭐ The **Fixed-QR limitation MUST be disclosed to the Owner at configuration time** | `ATT-BR-012`, `ATT-AC-013` |
| ⛔ Offline **Dynamic QR MUST NOT be promised** | `ATT-PO-014`, `ATT-NFR-012` |

### 7.5 Record integrity

| Constraint | Source |
|---|---|
| ⭐ A missed check-out is a **recorded fact** | `ATT-FR-082` |
| ⛔⛔ ⛔ **Never auto-complete** it with an invented timestamp, and ⛔ **never retract** the check-in | `ATT-BR-030`/`031` |
| ⛔ Never emit a **fabricated** check-out — *"fabricating one is worse than missing one"* | `ATT-FR-083` |
| ⭐ Corrections are **append-only** and show **original + correction** | `ATT-INV-011`, `ATT-FR-114` |
| ⛔ *"Corrections exist; **invisible corrections do not**"* | `ATT-BR-040` |
| ⭐ A correction **MUST NOT** change the recorded method | `ATT-FR-112` |
| ⭐⭐ An expired membership is **FLAGGED, ⛔ never used to block** attendance | `ATT-NFR-009` |
| ⭐ Every timestamp is **timezone-explicit** | `ATT-NFR-011` |

### 7.6 ⛔ Non-goals and prohibitions

| Constraint | Source |
|---|---|
| ⛔⛔ **No streaks. No percentages. No dashboards. No totals.** Owned by `BC-26` | ⭐ **`NG-6`**, `ATT-FR-146`/`147` |
| ⛔⛔ **`MeterBar` MUST NOT be used** on any attendance surface | ⭐ `NG-6` + `PRD-006` L2278 |
| ⛔ No **latency** figure may be invented | `ATT-NFR-003`, `ATT-GAP-017a` |
| ⛔ No **polling loop**, and ⛔ no punctual `WorkManager` promise — *"the guarantee is EVENTUAL, never PUNCTUAL"* | §10A.10 |
| ⛔⛔ **No guilt, shame, blame, fear or artificial urgency.** Force-stop, reboot, permission revocation and OEM restriction ⛔ **MUST NOT** be presented as fraud, as a rule violation, or as the student's fault | ⭐ §10A.4a, §10A.5 *(stated twice)* |
| ⭐⭐ The **4 mandated silences remain silent** | §25 |
| ⛔ No notification **cadence, cooldown or escalation** may be invented | `ATT-FR-148`, `X-04`, `LIB-16.5` |

### 7.7 ⭐ Accessibility

⭐⭐ **`ATT-NFR-014` is a ratified, binding, Attendance-specific
requirement** — ⛔ *"Accessibility of attendance surfaces **MUST NOT** be
worse for the Manual mode than for the app modes; the students served by
Manual are those least served by devices."*

⛔ **A product-wide accessibility standard remains unratified, and
`DD-0003` does not invent one.**

---

## 8. ⛔ Figma readiness

# ⛔⛔ NOT OPEN

⭐⭐ **And the gate does NOT open merely because `DD-0003` exists.** ⭐ Four hard
blockers (`DD-0003` §32.2):

| # | Blocker | Owner |
|---|---|---|
| 1 | ⚪ `DBT-001` token values — ⛔ a prototype cannot render the 4 state colours without them | Design Owner |
| 2 | ⚪ The unratified accessibility standard | Product / Design Owner |
| 3 | ⛔⛔ `ATT-GAP-002a` — ⭐ a Seat Card prototype would have to show states the system cannot compute, or silently omit 2 required renderings; ⛔ **both are wrong** | Architecture Owner |
| 4 | ⚪ `DD3-GAP-001`/`002` — ⛔ a prototype needs sentences, and the label authority is undecided | Product Owner |

⭐ When the gate does open, `DD-0003` §32.4 requires **separate prototype
trees per app**; ⛔ no one giant mixed-role prototype, and ⛔ **no APP 3 tree**.

---

## 9. Reference

| Document | Purpose |
|---|---|
| ⭐ [`DD-0003-attendance-surface-design.md`](DD-0003-attendance-surface-design.md) | ⭐⭐ **The Design Doc — source of truth for everything above** |
| [`../README.md`](../README.md) | Design documentation index · §2A catalog · ⭐ **§2B the mandatory three-app boundary** |
| [`PRD-006`](../../30-product/attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md) | ⭐ The authoritative product requirements — **`FROZEN` v1.9, Rank 3** |
| [`PRD-001`](../../30-product/authentication/Authentication_PRD_v2.md) | Role authority — §2.3 platform roles, §2.4 tenant roles, `AUTH-2.5` |
| [`DD-0001`](../membership/DD-0001-membership-management-surface-design.md) | `BC-02` Membership — consistency obligations at `DD-0003` §28 |
| [`DD-0002`](../student-management/DD-0002-student-management-surface-design.md) | `BC-01` Student Management — consistency obligations at `DD-0003` §28 |

---

## 10. ⛔ What this file is not

⛔ It is **not** a Design Doc · ⛔ not a substitute for reading `DD-0003` ·
⛔ not authority for any requirement, role, permission, surface or status ·
⛔ not a plan, schedule or commitment · ⛔ not a claim that anything is
approved, frozen, ranked, tested or implementable.

⭐ **`PRD-006` has 0 of 80 tasks and 0 of 222 acceptance criteria proven by a
test**, and measured attendance surface test coverage is **0**. ⛔ Nothing here
claims otherwise.
