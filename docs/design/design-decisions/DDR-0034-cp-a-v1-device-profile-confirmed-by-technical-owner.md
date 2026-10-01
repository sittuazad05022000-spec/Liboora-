<!-- LIBOORA Design Documentation | Design Decision Record | 2026-10-01 -->

> This document is design governance and documentation. ⛔ It does **not** amend
> product requirements, architecture decisions, bounded-context ownership,
> permissions, roles, scopes or backend contracts.

# DDR-0034 — `CP-A` / `FA-GAP-009`: V1 device profile confirmed by the Technical Owner

| Field | Value |
|---|---|
| **Register** | ⭐ Filed under [`README.md`](README.md) §2 template and §4 filing rules · global identifier `DDR-0034` (`DDR-0033` is the last filed — *never reused, never reassigned*; identifier verified free: 0 occurrences repository-wide at filing) |
| ⭐ **Status** | ⭐ **ACCEPTED** — Technical Owner decision recorded per the §2 template (decision status **ACCEPTED**) |
| **Date** | **2026-10-01** (recording date = session date of the acceptance; no date invented beyond it) |
| ⭐ **Owner** | ⭐ **Design Performance Owner** *(author of the provisional target, `DDR-0006`)* — role, never personal name |
| ⭐ **Approver / authority instrument** | ⭐ **Technical Owner** — office constituted at `PRD_OWNERSHIP_MODEL.md` §2.2 L86 (*"Implementation, `IMPL-*` tasks, traceability…"*) · authority per `LIBOORA_DESIGN_APPROVAL_ACTION_PLAN.md` §4.1 row 2 ("*Authorized owner: ⭐⭐ Technical Owner*") and `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` `CP-A` field 1 · ⛔ **not** the Design Performance Owner, who *"Cannot set backend SLOs or claim measured performance"* (`DESIGN_OWNERSHIP.md` §1) |
| **Scope** | ⭐ **V1 device / performance profile only** — the official V1 target device profile. ⛔ No numeric SLOs, no `NFR Budgets`, no implementation, no code change |
| **Source references** | `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md` `CP-A` *(PRIORITY A)* + §A.4 measured as-built floor · `LIBOORA_DESIGN_APPROVAL_ACTION_PLAN.md` §4.1 `FA-GAP-009` (*"What would make it ready: a Technical Owner statement naming minSdkVersion, a reference device class (RAM + resolution) and a network assumption. Nothing more."*) · `LIBOORA_HUMAN_DECISION_SHEET.md` D-6 *(item 7 device-profile decision)* · `DDR-0006` *(provisional target, its PENDING approver slot)* · `MP-CON-12` *(India-first, network-unreliable environment)* · `PERFORMANCE.md` L10 |
| **Decision** | ⭐ **The official V1 target device profile is ACCEPTED as follows (Technical Owner, 2026-10-01):** (1) **Minimum supported Android: Android 8.0 / API 26** · (2) **Reference low-end device class: 2 GB RAM + 720×1600 display** · (3) **Network assumption: intermittent / degraded mobile connectivity, primarily 4G; slow or temporarily unavailable conditions are supported only where documented offline / degraded-network behavior permits.** ⛔ These three values are the accepted decision; ⛔ nothing else is decided by this record |
| **Alternatives** | Per `CP-A` field 4 (⛔ no preference expressed by the design pack): ⭐ option (ii) **raise the floor** — the Technical Owner selected **API 26** (the design-inferred level), ⛔ **not** option (i) ratify the as-built floor (API 24 / Android 7.0, measured at `android/app/build.gradle.kts:27` → Flutter default `'24'` — `CP-A` §A.4: *"API 24 is not proposed as the answer"*). ⛔ The build currently **permits** Android 7.0; raising the floor to API 26 is a **separate engineering act** (⛔ **not performed by this record**; no `minSdkVersion`, `pubspec.yaml` or code change is made or authorized here) |
| **Distinction from `DDR-0006` (explicit)** | ⭐ `DDR-0006`'s provisional cluster (Android 8.0 / API 26 · 2 GB · 720×1600 · *intermittent 3G*) was recorded *"⛔ EXPRESSLY NOT APPROVED AS FACT"* — it is **history, not evidence** for this record. ⭐ The values (1) and (2) above **match** the `DDR-0006` inference numerically but are accepted **only** by the Technical Owner's 2026-10-01 statement · ⛔ the accepted network assumption is **primarily 4G**, which **differs** from `DDR-0006`'s provisional *"intermittent 3G"* — the provisional 3G figure is **not** carried forward and must not be cited as the accepted value |
| **Consequences** | ⭐ `CP-A` / `FA-GAP-009` closure condition satisfied — the *"a Technical Owner statement naming minSdkVersion, a reference device class and a network assumption"* test (`APPROVAL_ACTION_PLAN.md` §4.1) is met by this record · ⭐ `NFR Budgets (V1)` (`FA-GAP-010`) now has a target class to govern numeric SLOs — ⛔ **its creation remains a separate act (not performed here)** · ⭐ The `CP-B1` Devanagari guarantee probe is now **executable against the confirmed class (API 26)** — ⛔ **the probe itself is a separate act (not performed here)** · ⭐ The ≤5% 3D budget (`DDR-0006` consequence row) is validated against the confirmed class, not against a provisional target · ⚠ The as-built floor (API 24) is **weaker** than the confirmed profile (API 26) — design work may proceed against the confirmed profile; aligning the build to API 26 is an engineering follow-up ⛔ out of scope · ⛔ No numeric SLO is published by this record |
| **Open questions** | ⭐ `NFR Budgets (V1)` with numeric SLOs — **Governance Owner + Design Performance Owner** (`FA-GAP-010`, remains **⛔ OPEN** — this record unblocks it but does not close it) · ⭐ `CP-B1` Devanagari guarantee probe on the confirmed class — **Design System Owner + Technical Owner** (remains **⛔ OPEN** — this record does not close it) · ⚠ Build-floor alignment (as-built API 24 vs confirmed API 26) — **Technical Owner / Engineering**, separate act · ⛔ The provisional `DDR-0006` cluster stays in the register as history, re-pointed by reference to this record |
| **Review trigger** | Any change to the confirmed profile · measured frame drop on the target class · supersession of this record by a newer Technical Owner decision |

---

## What this record does NOT do

- ⛔ Does **NOT** close `CP-B1` — the Devanagari guarantee probe is still unperformed.
- ⛔ Does **NOT** close `FA-GAP-010` — `NFR Budgets (V1)` does not exist; its creation is a separate Governance + Design Performance Owner act.
- ⛔ Does **NOT** create, approve or commission `NFR Budgets (V1)` — no numeric SLOs are published by this record.
- ⛔ Does **NOT** modify `minSdkVersion`, `android/app/build.gradle.kts`, `pubspec.yaml`, `lib/`, `test/` or any application code.
- ⛔ Does **NOT** use `DDR-0006`'s historical *"intermittent 3G"* cluster as the accepted network value — the accepted assumption is **primarily 4G**.
- ⛔ Does **NOT** invent any value, requirement, approval, date or decision beyond the Technical Owner's accepted statement; the three values above are recorded **exactly as accepted**.

## Change-control note

Per `DESIGN_CHANGE_MANAGEMENT.md` §4: decision ID `DDR-0034`, artifact (V1 device / performance profile), decision status **ACCEPTED**, owner (Design Performance Owner), approver role (Technical Owner), decision date **2026-10-01**, source references per the table above, unresolved follow-ups per *Open questions*.
