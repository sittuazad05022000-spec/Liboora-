<!-- LIBOORA Design Doc | DD-0003 | BC-03 Attendance -->

> This document is design documentation. It does not amend product requirements,
> architecture decisions, bounded-context ownership, permissions, or backend
> contracts.

# `DD-0003` — Attendance surface design

| Field | Value |
|---|---|
| **Design Doc** | `DD-0003` |
| **Version** | **v0.1** |
| **Status** | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** ⛔ This document does **not** claim its own status |
| **Rank** | ⛔⛔ **UNRANKED.** Where this disagrees with any ranked document, **the ranked document wins and this Design Doc is the defect** |
| **Bounded context** | **`BC-03` Attendance** `[CORE]`, Library Management cluster, module rank **R8** |
| **Aggregate** | `AttendanceDay` — ⭐ **one student-day, not one punch** (`PRD-006` §2.3) |
| **Subject PRD** | [`PRD-006`](../../30-product/attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md) Attendance Management — **`FROZEN` v1.9**, **Rank 3**, admitted by **`ADR-0034`** (`Accepted`) under `BASELINE-2026-08-05-A` |
| **Owner** | UX Architecture Owner *(role, never a personal name)* |
| **External method** | UI/UX Pro Max skill — `nextlevelbuilder/ui-ux-pro-max-skill` @ **`15de38f`**, MIT. ⚠️ **Reference only, subordinate to every Liboora source** |
| **Predecessors** | [`DD-0001`](../membership/DD-0001-membership-management-surface-design.md) `BC-02` **v0.2** · [`DD-0002`](../student-management/DD-0002-student-management-surface-design.md) `BC-01` **v0.1a** — ⭐ consistency obligations in §28 |
| **⭐ App + Role boundary** | ⭐⭐ **APP 1 (Student App) + APP 2 (Library App). APP 3 = 0 surfaces.** Declared in full at **§3**; QA verdict at **§4** |
| **Readiness** | ⭐ **READY WITH EXPLICIT DESIGN GAPS** — §34 |
| **Purpose** | Specify the Attendance surfaces precisely enough that a Figma prototype can be built **without inventing UX** |

---

## 1. Purpose & Scope

### 1.1 What this document does

It specifies the **surfaces, flows, states, edge cases, copy rules and
component set** for `BC-03` Attendance, in both applications that carry
attendance experience, at a fidelity sufficient for a Figma prototype and a
Flutter implementation brief.

⭐⭐ **Every surface in this document traces to an `ATT-*` identifier in the
frozen `PRD-006`.** Where no requirement exists, this document says so and
records a gap — it does not fill the space with a preference.

### 1.2 ⭐⭐ Why `BC-03` is designable — the measurement, and the instrument that gets it wrong

⚠️ **`PRD-006` has no UI/UX chapter.** Literal occurrences measured across
all 3216 lines: `UI` = **0** · `UX` = **0** · `screen` = **0**.

⛔ **On the naive instrument — "count `UI`/`UX`" — Attendance would read
*"not designable"*.** That instrument was already corrected once, in
[`../README.md`](../README.md) §2A.3, when `PRD-004` scored 0 and turned out
to carry 35 display requirements. ⭐ **It gets Attendance wrong in the same
way, and more severely.**

⭐ What `PRD-006` actually contains, measured:

| Surface-bearing content | Count | Location |
|---|---|---|
| ⭐⭐ Sections **titled** for the Student App | **2** | §30.1 *"Student App — Fixed QR"*, §30.2 *"Student App — Dynamic QR"* |
| ⭐⭐ A section titled *"The student experience"* | **1**, nine numbered steps | §10A.10 L1216 |
| ⭐⭐ Named colour-coded display renderings | **6** | §23.4a L2164 |
| ⭐ Named status values (closed, owner-authorised) | **9** | §10A.1 L772 |
| ⭐ Outcomes that **MUST** be distinguishable | **19 rows** | §25 L2292 |
| ⭐⭐ Situations that **MUST** stay silent | **4 rows** | §25 |
| ⭐ A deterministic entry/exit state table | **4 rows** | §14.1 L1588 |
| ⭐ Normative worked examples | **7** | §10A.4a L1003 |
| ⭐ Acceptance criteria written in **display** terms | **9** (`ATT-AC-214`…`222`) | §30.20 L2850 |
| ⭐ A ratified **accessibility** obligation | **1** (`ATT-NFR-014`) | §27 |

⭐⭐⭐ **`PRD-006` is the most surface-prescriptive PRD in the repository, and
it contains zero instances of the word "UI".** The corrected instrument —
*does the frozen PRD fix surface requirements?* — returns an emphatic yes.

### 1.3 ⛔ What this document does NOT do

⛔ It does not amend `PRD-006`, any ADR, `AccessRole`, `Permission`, the BC
Map or any dependency record. ⛔ It creates no role, permission, scope, mode,
status value, event, edge, configurable or requirement. ⛔ It does not resolve
any `ATT-GAP-*`. ⛔ It does not decide token values (`DBT-001`), breakpoints
(`DBT-002`) or a product-wide accessibility standard — all three remain
owner-gated. ⛔ It does not claim any requirement is verified by test.
⛔ It does not start, scope or authorise Figma.

### 1.4 ⭐ Skill disposition — UI/UX Pro Max, applied and where refused

| # | Reference guidance | Disposition here |
|---|---|---|
| 1 | **#10 / #78 Loading states** — show feedback during async | ⭐ **ADOPTED** — §13. `ATT-FR-011` forces a server round-trip, so the wait is real |
| 2 | **#32 Loading buttons** — disable during async | ⭐ **ADOPTED** — §13.6 |
| 3 | **#33 Error feedback** — clear message near the problem | ⭐ **ADOPTED and outranked** — `ATT-BR-011` + `ATT-NFR-005` already require it *as product law* |
| 4 | **#34 / #83 Success confirmation** | ⭐ **ADOPTED with a PRD twist** — §19.4: a **duplicate** scan must show the **same** success, per `ATT-FR-019` |
| 5 | **#37 Colour only** — never convey by colour alone | ⭐ **ADOPTED and already satisfied** — §23.4a is colour **+ word** for all six renderings |
| 6 | **#44 Error announcement** — `role=alert` / live region | ⭐ **ADOPTED** — §21.4 |
| 7 | **#79 Empty states** — helpful message + action | ⭐ **ADOPTED** — §12.5, reusing `EmptyState` |
| 8 | **#80 Error recovery** — clear next steps | ⭐ **ADOPTED** — ⭐ `ATT-FR-059` already mandates routing a failure to *another enabled mode* |
| 9 | **#30 Active states** — immediate press feedback | ⭐ **ADOPTED** — §26, the 2.5D scan action |
| 10 | **#81 Progress indicators** — steps for multi-step flows | ⛔⛔ **REFUSED.** A step indicator would imply a **sequence of verifications** — the exact chain `ATT-XC-011` prohibits. ⛔ Attendance is **one** step, never "step 2 of 4" |
| 11 | **#12 Continuous animation** — loaders only | ⭐ **ADOPTED**, with §21.8's reduced-motion alternative for `PRESENCE CHECKING` |
| 12 | **#27 Haptic feedback** — for confirmations | ⚠️ **NOTED, not specified** — no PRD requirement; recorded as methodology in §26.5, ⛔ not as a design decision |
| 13 | **#98 Feedback loop** (thumbs up/down) | ⛔ **REFUSED** — an attendance fact is not a model output to rate; it would invite a student to dispute a record whose only lawful correction path is §18 staff correction |
| 14 | **Gamification / streak patterns** (general) | ⛔⛔ **PROHIBITED TWICE** — by your instruction **and** by `NG-6` + `ATT-FR-146`, which make streaks and percentages a **non-goal owned by `BC-26`** |

⭐ Item 10 is the substantive refusal: the most natural UX pattern for a
multi-condition check is the very architecture `PRD-006` §7.2 spends a page
forbidding.

### 1.5 Source authority order

1. **Rank 1** — `MASTER_PRD.md` global rules
2. **Rank 2** — `Accepted` ADRs (`ADR-0032`, `ADR-0033`, `ADR-0034`, `ADR-0012`)
3. **Rank 3** — ⭐ **`PRD-006` v1.9 `FROZEN` (the subject)**, `PRD-001` Authentication v2.0, `PRD-004`, `PRD-005`, `PRD-007`
4. **Rank 4** — BC Map v1.7, Module Dependency Matrix v1.3, `TRACEABILITY_MATRIX.md`
5. **Rank 5** — `ARCHITECTURE_RULINGS.md`
6. **Rank 6** — Enterprise Architecture v2.1 *(descriptive only)*
7. **Unranked** — `docs/35-design/README.md`, `DD-0001`, `DD-0002`, this document
8. ⛔ **Reference only** — UI/UX Pro Max is **methodology**, never Liboora authority

⚠️ **Existing Flutter code is evidence (class B), never authority.** Where
code and `PRD-006` disagree, the PRD wins and the code is the deviation —
recorded in §30.4, ⛔ never silently designed around.

---

## 2. Authority & Status

### 2.1 The subject PRD, measured

| Field | Value | Source |
|---|---|---|
| Document | `PRD-006_ATTENDANCE-MANAGEMENT.md`, **3216 lines** | measured |
| Version / status | **v1.9 — `FROZEN`** | header |
| Rank | **Rank 3** — authoritative for everything inside `BC-03` | header; `DOCUMENTATION_BASELINE.md` §3.3, §4 |
| Admitting ADR | **`ADR-0034`** — verified **`Accepted`** | `docs/00-governance/adr/` |
| Baseline | `BASELINE-2026-08-05-A` | header |
| Identifiers | **525** across 9 registers — `ATT-FR` 151 · `ATT-BR` 45 · `ATT-INV` 12 · `ATT-EVT` 4 · `ATT-XC` 21 · `ATT-PO` 14 · `ATT-CFG` 24 · `ATT-NFR` 14 · `ATT-AC` 222 · `ATT-GAP` 18 nos / 23 rows | §0.3 |
| ⛔ Test verification | ⛔⛔ **0 of 80 tasks and 0 of 222 acceptance criteria proven by a test** | header |
| Gap ledger | **4 resolved · 1 narrowed · 18 OPEN** | §32.1 |

### 2.2 ⭐ ADR status — every attendance ADR checked individually

| ADR | Subject | Status (verified at source) | ⭐ Consequence for design |
|---|---|---|---|
| **`ADR-0032`** | Attendance presence → Seating | ⭐ **`Accepted`**, option `O-5`, read edge **`E-27`** | ⭐ **4 of 6 Seat Card renderings become designable** — §18 |
| **`ADR-0033`** | `E-27` core-cluster allow-list | ⭐ **`Accepted`** | Transport is lawful |
| **`ADR-0034`** | `PRD-006` v1.9 baseline | ⭐ **`Accepted`** | ⭐ The freeze is real |
| `ADR-0012` | Module boundary debt | `Accepted` | §3.4 — the 9 `app → domain` sites are *"deliberately left failing"* → `DD3-GAP-006` |
| `ADR-0021` | Configurable defaults | ⛔ **`Proposed`** | ⛔ Binds nothing |
| `ADR-0022` | `BC-03` `FileRef` / `E-22` | ⛔ **`Proposed`** | ⛔ OCR stays blocked |
| `ADR-0023` | OCR/Vision ownership | ⛔ **`Proposed`** | ⛔ OCR stays blocked |
| `ADR-0024` | Wi-Fi presence session architecture | ⛔ **`Proposed`** | ⛔ 7th type not definable |
| `ADR-0025` | Wi-Fi presence ↔ attendance integration | ⛔ **`Proposed`** | ⛔ 7th type not definable |
| `ADR-0026` | Study Hours ownership | ⛔ **`Proposed`** | ⛔ No duration metric may be designed |
| `ADR-0027` | Authorized Wi-Fi network identity | ⛔ **`Proposed`** | ⛔ No spoof-resistance claim |
| `ADR-0028` | Android background presence detection | ⛔ **`Proposed`** — permission matrix is *"six columns of To be decided"* | ⛔ **No background promise may be designed** |
| ⛔⛔ **`ADR-0029`** | **Student shift visibility for attendance** | ⛔ **`Proposed`** | ⛔⛔ **`ATT-GAP-002a` — blocks 3 statuses + 2 renderings** |
| `ADR-0030` | Device↔account resolution | ⛔ **`Proposed`** | ⛔ 7th type not definable |
| `ADR-0031` | Presence tolerance configuration | ⛔ **`Proposed`** — no PO-approved range | ⛔ Tolerance is a product rule, not a configurable |

⭐ **3 `Accepted`, 11 `Proposed`.** Only the three `Accepted` ones are used
as authority here.

### 2.3 ⚠️ One internal contradiction in the subject PRD — reported, not resolved

⚠️⚠️ **`PRD-006` §0.1 (L31) states: *"This document is `DRAFT` and
unranked… It has not been architecture-reviewed (Stage 3), requirements-
reviewed (Stage 4), traced (Stage 5), given a task backlog (Stage 6) or
frozen (Stage 7)."*** ⛔ This contradicts its own header, which records
Stage 3 ✅, Stage 4 ✅, Stages 5/6 exit 0, and Stage 7 **FROZEN**.

| Reading | Assessment |
|---|---|
| §0.1 is right ⇒ the PRD is a draft | ⛔ **REJECTED** — the freeze is **conferred** by `ADR-0034` (`Accepted`) and `DOCUMENTATION_BASELINE.md` §3.3, neither of which §0.1 can override |
| The header is right ⇒ §0.1 is stale prose | ⭐ **ACCEPTED** — consistent with `ADR-0034`, the baseline declaration, and the header's own *"freeze is conferred, not claimed"* |

⭐ **Classified as a documentation defect in the subject PRD**, recorded as
`DD3-DEFECT-001` in §30.6. ⛔ **This Design Doc does not fix it** — amending a
`FROZEN` Rank 3 PRD is not a Design Doc's act. Routed to the **PRD-006
document owner**.

⭐ It changes nothing here: every requirement in this document is cited from
its own section, not from the status block.

### 2.4 This document's own status — stated plainly

| Claim | Value |
|---|---|
| Approved? | ⛔ **NO** |
| Frozen? | ⛔ **NO** |
| Ranked? | ⛔ **NO — UNRANKED** |
| Authorises implementation? | ⛔ **NO** |
| Authorises a `TS-*`? | ⛔⛔ **NO** — a `TS` enters Stage `6A` only on an ADR-borne conferral (`ADR-0131`); ⛔ no `TS-003` is created, implied, authorised, allocated or reserved |
| Authorises Figma? | ⛔ **NO** — §32 finds the gate **CLOSED** |

---

## 3. ⭐⭐ APP + ROLE BOUNDARY

⭐⭐⭐ **PRIMARY PRINCIPLE, applied: this feature is designed for its final
app boundary now.** ⛔ There is no mixed-role attendance UI here to be split
later.

Written to satisfy [`../README.md`](../README.md) **§2B.3**, which requires
all five declarations before a Design Doc may be called design-ready.

### 3.1 Declaration 1 — Target App

⭐ **APP 1 (Student App) + APP 2 (Library App)** — an explicit, justified
two-app set.

| App | In scope? | ⭐ Justification from source |
|---|---|---|
| ⭐ **APP 1 — Student App** | ⭐ **YES** | `PRD-006` §30.1 and §30.2 are **titled** *"Student App"*; §10A.10 is titled *"The student experience"*; §19.2 grants `student` *"Self attendance (modes 1–5)"* at scope `self` and `parent` *"View guarded students' attendance"* at `guardianOf` |
| ⭐ **APP 2 — Library App** | ⭐ **YES** | §19.2 grants `owner` configuration, `manager` operational actions, `reception`+`manager` manual entry / OCR verification / corrections — all at `tenantWide` |
| ⛔⛔ **APP 3 — Platform Admin App** | ⛔⛔ **NO — ZERO attendance surfaces** | See §3.6 — measured, not assumed |

⛔ **This is not "all apps".** It is two apps, each with a named,
independently sourced reason.

### 3.2 Declaration 2 — Target Role(s), by identifier

| Role ID | Role | App | ⭐ Source |
|---|---|---|---|
| `TR-4` | **Student** | ⭐ APP 1 | `PRD-001` §2.4 L614; `PRD-006` §4.1 |
| `TR-5` | **Parent** | ⭐ APP 1 *(a role, ⛔ **not** an app)* | `PRD-001` §2.4 L622; `PRD-006` `ATT-FR-004` |
| `TR-1` | **Library Owner** | ⭐ APP 2 | `PRD-001` §2.4 L590; `PRD-006` §19.2 |
| `TR-2` | **Library Manager** | ⭐ APP 2 | `PRD-001` §2.4 L598; `PRD-006` §19.2 |
| `TR-3` | **Reception Staff** | ⭐ APP 2 | `PRD-001` §2.4 L606; `PRD-006` §19.2 |
| `PR-1` / `PR-2` | Platform Administrator / Support | ⛔⛔ **NEITHER — 0 surfaces** | `PRD-001` §2.3 (*"Two exist. The set is closed"*); `AUTH-2.5` |

⛔ **No role is invented, extended or inferred** — `ATT-FR-003`: *"MUST use
only the five roles defined in Master PRD §6. It MUST NOT define, introduce,
extend or infer any role."*
⛔ ***"Library Owner" ≠ "Platform Owner".*** `TR-1` Owner governs **one
tenant** and lives in `lib/app/staff/`; `PR-1`/`PR-2` govern **the platform**
and live in `lib/app/platform_admin/`. ⛔ *"Platform Owner"* is **not** cited
as an authoritative identifier anywhere in this document — see §3.7.

### 3.3 Declaration 3 — Permission Scope

⭐ **Authoritative source: `PRD-006` §19.2 L1965 — an 8-operation table** —
plus the **closed** scope register `self` / `guardianOf` / `tenantWide`
(`ATT-FR-005`: ⛔ *"MUST NOT introduce a fourth scope"*).

⭐ The full matrix is at **§6.2**. ⛔ **No permission is widened, and no cell
is filled by UI convenience** (`ATT-FR-118`; `ATT-BR-001` — *holding a
permission is not being able to exercise it on a given record*).

### 3.4 Declaration 4 — Tenant / Library / Platform scope

⭐ **Every attendance surface in this document is TENANT-scoped. ⛔ No surface
carries platform scope.**

| Rule | Source |
|---|---|
| Attendance data **MUST** be tenant-isolated to the `X-13` standard | `ATT-NFR-006`, §20 |
| Wi-Fi configuration is tenant-scoped; one tenant's network **MUST NOT** validate another's attendance | `ATT-BR-017` |
| Staff **MUST NOT** record attendance for a student outside the active tenant | `ATT-BR-025` |
| Roles **MUST NOT** be inherited across tenants — *"a `reception` role at library A confers nothing at library B"* | `ATT-FR-121` (`AUTH-2.8`) |
| Face enrollment is tenant-scoped | `ATT-BR-021` |
| A cross-tenant QR **MUST** be rejected and ⛔ **MUST NOT** fall back to the scanner's tenant | `ATT-BR-010` |
| ⭐ An account with no role in the active tenant is treated *"exactly as an account with no access"* | `ATT-FR-120` (`AUTH-2.16`) |

### 3.5 Declaration 5 — Cross-App dependencies

⭐ **Three, all declared. ⛔ No undeclared jump between apps exists.**

| # | Dependency | Direction | ⛔ Why this is not a permission widening |
|---|---|---|---|
| **X-1** | A student's attendance fact appears on Library App operational reads and the reception desk | APP 1 fact → APP 2 surface | ⭐ `ATT-FR-145` authorises the operational read; `TR-1`/`TR-2` already hold `tenantWide`. ⛔ Nothing is granted to the student, and ⛔ `ATT-FR-147` bars the read from being presented as a certified metric |
| **X-2** | ⭐⭐ **Seat Card presence composition** — `BC-04` **pulls** presence at read time over **`E-27`** | APP 1 fact → APP 2 surface *(and cross-**feature**, `BC-03` → `BC-04`)* | ⭐ `ADR-0032` (`Accepted`, `O-5`). ⛔ Read-time composition only — `ATT-AC-219`: nothing *"obliges or permits a consumer to persist them"*. ⛔ No raw network datum crosses (`ATT-AC-218`). ⛔ The event surface stays closed at **four** (`ATT-AC-216`) |
| **X-3** | Parent reads the guarded student's attendance | within APP 1, a **different scope** | ⭐ `guardianOf` + `ATT-CFG-024`. ⛔ Read-only — `ATT-FR-119`: a parent *"MUST NOT create, correct or delete any attendance record"* |

### 3.6 ⭐⭐ APP 3 = ZERO attendance surfaces — measured, not assumed

⛔⛔ **This is a positive finding with six independent sources, not an
omission.**

| # | Evidence | Text / measurement |
|---|---|---|
| 1 | ⭐⭐ `ATT-FR-003` | *"This module **MUST** use only the **five roles** defined in Master PRD §6. It **MUST NOT** define, introduce, extend or infer any role"* — ⭐ the five are all **tenant** roles |
| 2 | ⭐ `ATT-FR-005` | Scope register closed at `self` / `guardianOf` / `tenantWide` — ⛔ **no platform scope exists to hold a platform surface** |
| 3 | ⭐ `ATT-FR-118` | ⛔ No new RBAC system, role, permission model or scope |
| 4 | ⭐⭐ `PRD-006` §19.2 | **8 operations × 5 roles. ⛔ No platform role appears in any row** |
| 5 | ⭐⭐ `PRD-001` `AUTH-2.5` | *"Platform roles **MUST NOT** grant access to tenant business data"* — ⭐ and **attendance records ARE tenant business data** (`ATT-NFR-006`, §20) |
| 6 | ⭐ `ATT-FR-121`, `ATT-NFR-006`, §20 | Tenant isolation to `X-13`; ⛔ no cross-tenant inheritance |

⭐ **Corroborating code evidence (class B, not authority):**
`lib/app/platform_admin/` is *"reserved, deliberately empty"*; `AccessRole`
holds **5 tenant values and no platform value**.

⭐⭐ **Therefore Attendance is a strictly TWO-APP feature.** ⛔ Creating a
platform-admin attendance surface would require inventing a role and a
scope — both expressly prohibited.

### 3.7 ⭐ `DSN-APP-GAP-001` — measured IRRELEVANT to this feature

⚠️ [`../README.md`](../README.md) §2B.2 records `DSN-APP-GAP-001`: the
standing instruction names *"Platform Owner / platform-level authority"* for
APP 3, but ⛔ **"Platform Owner" has 0 occurrences** in `PRD-001`,
`MASTER_PRD.md` or `PRD-012a` Part 2.

⭐⭐ **For Attendance the gap cannot bite, and this is measured rather than
waved away:** `ATT-FR-003` closes the role set at **five tenant roles**
*before* any platform question arises, and §19.2 grants **no** platform role
anything. ⭐ So the APP 3 role vocabulary — however it is later settled —
**has nothing to attach to in `BC-03`**.

⛔ **`DSN-APP-GAP-001` is neither resolved nor inherited here.** It remains
open with **Product Owner + Architecture Owner**, exactly as recorded. ⛔ This
document does not cite *"Platform Owner"* as an authoritative identifier.

### 3.8 ⭐ Separation rules — how §2B.4 is satisfied item by item

| §2B.4 rule | How this design satisfies it |
|---|---|
| 1. Every item assigned to an app **and** role | ⭐ §8 (32 surfaces), §9 (17 flows), §10 (26 states), §12 (34 edge cases) — ⛔ **0 unassigned**. Roll-up at §4.3 |
| 2. ⛔ No role mixing for convenience | ⭐ **Materially different UX documented separately**: the student's one-tap scan (§13) vs Reception's burst-optimised desk (§14.2) vs Owner configuration (§16). ⛔ They are not one screen |
| 3. Shared design only when genuinely cross-app | ⭐ Only **three** shared items, each justified in §3.5. ⛔ Convenience is never the reason |
| 4. ⛔ Permissions from PRD/ADR/Auth only | ⭐ §6.2 cites §19.2 cell by cell; ⚠️ 3 unlisted cells are recorded as `DD3-GAP-003`, ⛔ **not inferred** |
| 5. Parent is a Student-App **role** | ⭐ §15 — a role with its own scope, ⛔ not an app |
| 6. `TR-1`/`TR-2`/`TR-3` respected as different | ⭐⭐ §16.1: configuration is **`TR-1`-only**; **exactly one** setting is delegated to `TR-2` (`ATT-CFG-008`, `D-12`); `TR-3` gets **none**. ⛔ Not one screen with controls greyed by role |
| 7. ⛔ Platform stays separated | ⭐ §3.6 — zero platform surfaces, so `AUTH-2.5` cannot be violated |
| 8. Figma must preserve the boundaries | ⭐ §32.4 — ⛔ **separate prototype trees per app are mandatory**; ⛔ no one giant mixed prototype |

---

## 4. App-Boundary QA

⭐ Run per [`../README.md`](../README.md) **§2B.5**, whose verdict vocabulary
is `PASS` / `GAP` / `CONFLICT` / `TO BE DECIDED`. ⛔ A boundary `GAP` blocks
design-ready classification.

### 4.1 The thirteen checks

| # | Check | Verdict | Evidence |
|---|---|---|---|
| 1 | Target App declared | ⭐ **PASS** | §3.1 — APP 1 + APP 2, justified; APP 3 measured zero |
| 2 | Target Roles declared by identifier | ⭐ **PASS** | §3.2 — `TR-1`…`TR-5`; ⛔ no `PR-n` |
| 3 | Permission Scope sourced | ⭐ **PASS** | §3.3, §6.2 — `PRD-006` §19.2 + closed scope register |
| 4 | Tenant / Library / Platform scope stated | ⭐ **PASS** | §3.4 — 7 sourced rules |
| 5 | Cross-App dependencies declared | ⭐ **PASS** | §3.5 — X-1, X-2, X-3 |
| 6 | Every surface/flow/state/action/edge assigned | ⭐ **PASS** | §4.3 — ⛔ **0 unassigned** |
| 7 | ⛔ No role mixing for convenience | ⭐ **PASS** | §3.8 rule 2 |
| 8 | `TR-1`/`TR-2`/`TR-3` differences respected | ⭐ **PASS** | §16.1 — Owner-only config, one delegated setting, `TR-3` none |
| 9 | Parent is a role, ⛔ not an app | ⭐ **PASS** | §15 |
| 10 | ⛔ Platform separated from tenant ops | ⭐ **PASS** | §3.6 — six sources |
| 11 | ⛔ No permission widened for UX | ⭐ **PASS** | §6.2; 3 unlisted cells → `DD3-GAP-003`, ⛔ not inferred |
| 12 | ⛔ *"Platform Owner"* not cited as authority | ⭐ **PASS** | §3.7 |
| 13 | Role-assignment ambiguities in the source | ⚪ **TO BE DECIDED** ×2 | `DD3-GAP-003` (Owner's manual/OCR/correction authority) · `DD3-GAP-004` (Fixed QR lifecycle actor) |

### 4.2 ⭐⭐ VERDICT: **PASS**

⭐ **11 PASS · 0 GAP · 0 CONFLICT · 2 TO BE DECIDED.**

⛔ **No boundary `GAP` exists**, so per §2B.5 nothing blocks design-ready
classification on boundary grounds. ⭐ The two ⚪ items are **role-assignment
questions about two specific staff actions** in the source PRD — ⛔ not
missing declarations. All five mandatory declarations are present and
sourced.

⚠️⚠️ **One classification stated openly rather than chosen quietly.** §2B.5
defines `CONFLICT` as *"a source-vs-source **or source-vs-code**
contradiction."* Read literally, **`AIV-05`** qualifies — `PRD-006` §19.2
grants `student` self-attendance, and `lib/platform/identity/identity.dart`
L258 grants the student role **only** `viewStudent`.

⭐ **It is classified as an implementation deviation, not a boundary
CONFLICT**, because the **rank law already decides the direction**:
`PRD-006` is Rank 3 and code is unranked, so there is nothing for an
authority to choose. ⭐ A `CONFLICT` verdict is reserved for contradictions
where **no rule decides**. ⛔ Both readings are recorded here so the
classification is auditable rather than convenient, and the deviation is
carried in full at §30.4.

### 4.3 ⭐ Assignment roll-up — ⛔ zero unassigned items

| Item class | Total | APP 1 `TR-4` | APP 1 `TR-5` | APP 2 `TR-1`/`TR-2`/`TR-3` | APP 3 | Unassigned |
|---|---|---|---|---|---|---|
| **Surfaces** | **32** | 14 | 2 | 16 | ⭐ **0** | ⭐ **0** |
| **Flows** | **17** | 9 | 1 | 7 | ⭐ **0** | ⭐ **0** |
| **States** | **26** | readable | readable *(gated)* | readable + workflow | ⭐ **0** | ⭐ **0** |
| **Edge cases** | **34** | 24 | 2 | 8 | ⭐ **0** | ⭐ **0** |
| **Actions** | — | self-attend, check-out | ⛔ **none** | manual, OCR verify, correct, configure, QR lifecycle | ⭐ **0** | ⭐ **0** |

---

## 5. User / Role Model

### 5.1 ⭐ Three audiences, and the asymmetry that shapes everything

| Audience | App | Primary question | ⭐ Design consequence |
|---|---|---|---|
| ⭐⭐ **Student (`TR-4`)** | APP 1 | *"Am I marked present, and if not, what do I do right now?"* | ⭐⭐ **The only audience with a WRITE action of their own** (`self` attendance, modes 1–5). Optimise for **speed and certainty in a queue** |
| **Parent (`TR-5`)** | APP 1 | *"Is my child at the library?"* | ⛔ **Read-only, ⛔ config-gated.** Optimise for **calm**, ⛔ never for monitoring pressure |
| **Library staff (`TR-1`/`TR-2`/`TR-3`)** | APP 2 | *"Get this queue through the door, and keep the record honest"* | ⭐ Optimise `TR-3` for **throughput**, `TR-2` for **worklists**, `TR-1` for **configuration with disclosure** |

⭐⭐ **The asymmetry:** in `DD-0002` the student was **read-only** on their own
record. ⭐ **Here the student acts** — `PRD-006` §19.2 row 7 grants *"Self
attendance (modes 1–5)"* at scope `self`. ⛔ This is a **legitimate
difference between two features**, not an inconsistency between Design Docs
(§28, check C-1).

### 5.2 ⭐ The five roles — taken, never invented

| Role | Enum | Master PRD §6 attendance capability *(quoted in `PRD-006` §4.1)* | Identity |
|---|---|---|---|
| **Library Owner** | `owner` | *"Complete business control"* — configures attendance modes | `AccountId` |
| **Manager** | `manager` | *"Daily operations management"* | `AccountId` |
| **Reception Staff** | `reception` | *"Student onboarding, **attendance**, memberships, seat allocation and support"* | `AccountId` |
| **Student** | `student` | *"**Attendance**, membership, profile, AI assistant, notifications and self-service"* | `AccountId` + `StudentRecordId` + optional `PersonId` |
| **Parent** | `parent` | *"**Attendance visibility**, fee updates and important notifications"* | `AccountId` with guardian role |

⭐ `ATT-FR-004` — parent access **MUST** be **read-only** and scoped to
guarded students only: ⭐ *"visibility is not mutation."*

### 5.3 Non-human actors — §4.2, and what they may not become

| Actor | Nature | ⛔ Design consequence |
|---|---|---|
| **Fixed QR display** | A passive printed/displayed artefact | ⛔ *"Owns nothing, decides nothing, **holds no secret**"* — so it renders as a **poster**, ⛔ never as a device with state |
| **Dynamic QR surface** | A display rendering a rotating code | ⛔ The decision is **server-side**; the display makes no claim about its own validity (`ATT-FR-022`) |
| **Face scanner** | Attendance hardware | ⛔ **Ownership unresolved — `ATT-GAP-009`**, *"a genuine V1 hole"* |
| **Student App** | The authenticated client | ⭐ *"Carries the `BC-18` session; **is not itself an actor**"* — so ⛔ no "app identity" may appear in any surface |

### 5.4 ⭐ What the student is NOT asked to do — a design boundary

⛔ **The student does not choose a verification mode.** `ATT-FR-009` makes
mode availability a **per-tenant Owner setting**. ⭐ A "choose your method"
picker would manufacture a decision the PRD assigns to `TR-1` — and would
add decision fatigue for no product benefit (§22, P-12).

⛔ **The student does not authenticate at the door.** `BC-18` has already
done it (`ATT-FR-117`); the QR carries only **context** (`ATT-BR-009`).
⭐ So ⛔ no login-like ceremony appears on any scan surface.

---

## 6. Permission & Scope Model

### 6.1 The two-part rule that governs every control

⭐ `ATT-BR-001` (`MP-GBR-20`) — *"Holding a permission is not the same as
being able to exercise it on a given record. Every attendance operation
**MUST** be evaluated against **both** the permission and its scope."*

⭐⭐ **Design consequence, stated once and applied throughout:** a control is
rendered only when **permission AND scope AND configuration** all permit it.
⛔ Where any one fails, the design prefers **absence over a disabled
control** — see §6.4.

### 6.2 ⭐⭐ Role × Action matrix — every cell from `PRD-006` §19.2

⛔ **Nothing in this table is inferred from UI convenience.**

| Action | `TR-1` Owner | `TR-2` Manager | `TR-3` Reception | `TR-4` Student | `TR-5` Parent | `PR-1`/`PR-2` | Scope | Evidence | ⭐ UX implication |
|---|---|---|---|---|---|---|---|---|---|
| Configure modes & values (§16) | ⭐ **ALLOW** | ⛔ DENY | ⛔ DENY | ⛔ DENY | ⛔ DENY | ⛔ **DENY** | `tenantWide` | §19.2 r1 | ⭐ An **Owner-only area** of APP 2 (`S-L8`) |
| Manage approved Wi-Fi (`ATT-CFG-008`) | ⭐ **ALLOW** | ⭐ **ALLOW** | ⛔ DENY | ⛔ DENY | ⛔ DENY | ⛔ **DENY** | `tenantWide` | §19.2 r2, **`D-12`** | ⭐⭐ The **only** delegated setting — ⛔ grants `TR-2` nothing else (`ATT-FR-118`) |
| Operational attendance actions | ⭐ ALLOW | ⭐ **ALLOW** | ⛔ DENY | ⛔ DENY | ⛔ DENY | ⛔ **DENY** | `tenantWide` | §19.2 r3 | Manager worklists (`S-L7`, `S-L11`) |
| Individual manual entry (§13A) | ⚪ **not listed** | ⭐ ALLOW | ⭐ **ALLOW** | ⛔ DENY | ⛔ DENY | ⛔ **DENY** | `tenantWide` | §19.2 r4 | ⭐ `TR-3`'s core action (`S-L2`) |
| OCR verification (§13C) | ⚪ **not listed** | ⭐ ALLOW | ⭐ ALLOW | ⛔ DENY | ⛔ DENY | ⛔ **DENY** | `tenantWide` | §19.2 r5 | ⛔ **Build-blocked** `ATT-FR-080` |
| Corrections (§18) | ⚪ **not listed** | ⭐ ALLOW | ⭐ ALLOW | ⛔ DENY | ⛔ **DENY** | ⛔ **DENY** | `tenantWide` | §19.2 r6, `ATT-CFG-022` | ⛔ Gated by a **config flag** ⇒ the control may be **absent entirely** |
| ⭐⭐ **Self attendance (modes 1–5)** | ⛔ DENY | ⛔ DENY | ⛔ DENY | ⭐⭐ **ALLOW** | ⛔ DENY | ⛔ **DENY** | ⭐ `self` | §19.2 r7 | ⭐⭐ **THE primary student action.** ⚠️ **Missing in code** — `AIV-05`, §30.4 |
| View own attendance | ⛔ DENY | ⛔ DENY | ⛔ DENY | ⭐ **ALLOW** | ⛔ DENY | ⛔ **DENY** | ⭐ `self` | §19.2 r8 | Own history only (`S-S9`) |
| View guarded student's attendance | ⛔ DENY | ⛔ DENY | ⛔ DENY | ⛔ DENY | ⭐ **ALLOW** | ⛔ **DENY** | ⭐ `guardianOf` | §19.2 r9, `ATT-CFG-024` | ⛔ **Read-only + config-gated** (`S-P1`, `S-P2`) |
| Create / correct / delete, as Parent | — | — | — | — | ⛔⛔ **DENY** | ⛔ DENY | — | ⭐ `ATT-FR-119` | ⛔⛔ **No parent write control may be rendered — not even disabled** (§15.3) |
| Any access with no role in the tenant | ⛔ | ⛔ | ⛔ | ⛔ | ⛔ | ⛔ | — | ⭐ `ATT-FR-120` | ⭐ *"exactly as an account with no access"* |
| Any **tenant business data** | — | — | — | — | — | ⛔⛔ **DENY** | — | ⭐⭐ `AUTH-2.5` + `ATT-FR-003` | ⭐⭐ **Attendance records ARE tenant business data** |

### 6.3 ⚪ The three `not listed` cells — `DD3-GAP-003`, preserved not resolved

⚠️ `PRD-006` §19.2 lists manual entry, OCR verification and corrections for
**`reception`, `manager`** and ⛔ **does not name `owner`**.

| Tempting reading | ⛔ Why refused |
|---|---|
| *"Owner has complete business control, so Owner holds them"* | ⛔ *"Complete business control"* is **Master PRD §6 prose**, ⛔ not a §19.2 grant. Reading a grant out of prose is exactly the widening §2B.4 rule 4 prohibits |
| *"Owner is absent, so Owner is denied"* | ⛔ Equally unsupported — the table's silence is silence, ⛔ not a deny |

⭐⭐ **Therefore the design renders Owner's manual-entry / OCR / correction
entry points as ⚪ TO BE DECIDED, and shows neither an allow nor a deny.**
→ **`DD3-GAP-003`**, **Product Owner + Architecture Owner** (§30.3).

⭐ Note this is a **deny-by-default posture in practice** — the control is not
rendered for `TR-1` until decided — which is the safe direction and matches
`SM-8.4a`/`AP-3`. ⛔ But the design does **not** record that as a decision.

### 6.4 ⭐ Absent vs disabled — a design rule derived from the permission model

⭐ Three sources make some attendance controls **legitimately non-existent**
rather than greyed:

| Situation | Rule | ⭐ Design |
|---|---|---|
| Parent write actions | ⛔ `ATT-FR-119` | ⭐⭐ **ABSENT.** A greyed "Correct" button tells a parent the power exists and is withheld — ⛔ it does not |
| Corrections when `ATT-CFG-022` = disabled | `ATT-CFG-022` | ⭐ **ABSENT** — the tenant has switched the capability off |
| Parent visibility when `ATT-CFG-024` = disabled | `ATT-CFG-024` | ⭐ **Explained state**, ⛔ not an error — `S-P2`, §15.4 |
| A mode disabled for the tenant | `ATT-FR-104`, `ATT-FR-030` | ⭐ **ABSENT from the student's surface**; ⛔ a displayed code must produce nothing |
| A student's own action, permission held | — | ⭐ **PRESENT and enabled** |

⛔ **Reduced to one sentence: a control the actor can never hold is absent; a
control temporarily unavailable is present and explained.**

---

## 7. Information Architecture

### 7.1 ⭐ One question per surface

⭐ Each surface answers exactly one question. ⛔ A surface that answers two is
a defect.

### 7.2 APP 1 — Student App hierarchy

```
STUDENT APP  (TR-4)
│
├── Today                                   S-S1   "Am I present right now?"
│     ├── [primary action] Mark attendance   S-S2/S-S3/S-S4/S-S5  (whichever ONE mode is enabled)
│     ├── Check out                          S-S8   (only when ATT-CFG-021 enabled)
│     └── Exit-not-verified notice           S-S10  (only when that state holds)
│
├── My attendance                            S-S9   "What is my record?"
│
├── [contextual] Why it didn't work           S-S7   "What happened, and what now?"
├── [contextual] Mode unavailable             S-S14  "Nothing is broken; use X"
├── [contextual] Location disclosure          S-S13  "Why is location being asked for?"
└── [contextual] Offline captured             S-S12  ⚪ copy TBD — DD3-GAP-005

STUDENT APP  (TR-5 Parent)
│
└── Attendance                                S-P1   "Is my child at the library?"
      └── Visibility off                      S-P2   explained state, NOT an error
```

⭐⭐ **`S-S1` is the app's attendance home and the two-axis card lives there**
(§11). ⛔ There is **no mode picker** in this tree (§5.4).

### 7.3 APP 2 — Library App hierarchy

```
LIBRARY APP
│
├── Reception desk           S-L1    TR-3 · TR-2      "Get this queue through the door"
│     └── Manual entry        S-L2    TR-3 · TR-2      first-class, never a fallback
│
├── Attendance operations    S-L11   TR-1 · TR-2      8 named operational reads
│     ├── Missed check-out    S-L7    TR-2 · TR-3      a worklist, not an error log
│     ├── Corrections         S-L5    TR-3 · TR-2      (ATT-CFG-022) · ⚪ TR-1 = DD3-GAP-003
│     └── Correction history  S-L6    authorised actor append-only, original + correction
│
├── Configuration           S-L8    ⭐ TR-1 ONLY      24 ATT-CFG rows
│     ├── Approved Wi-Fi      S-L8a   ⭐ TR-1 + TR-2    the ONE delegated setting (D-12)
│     ├── Fixed QR lifecycle  S-L9    ⚪ actor TBD      DD3-GAP-004
│     └── ⭐ QR limitation     S-L14   TR-1             MANDATED disclosure (ATT-BR-012)
│
├── Seat map → Seat Card    S-L12   TR-1 · TR-2 · TR-3   ⭐ CROSS-FEATURE (BC-04, E-27)
│
├── Dynamic QR display      S-L10   non-human surface  ⚠️ partial
│
├── ⛔ Register upload        S-L3    BUILD-BLOCKED     ATT-FR-080
├── ⛔ OCR review queue       S-L4    BUILD-BLOCKED     ATT-FR-080
├── ⛔ Unknown-device review  S-L13   BLOCKED           7th type not definable
└── ⛔ Face enrollment        S-L15   BUILD-BLOCKED     ATT-FR-064
```

### 7.4 ⛔ APP 3 — Platform Admin App

```
PLATFORM ADMIN APP
└── (no attendance surface exists)     ⛔ ATT-FR-003 · ATT-FR-005 · AUTH-2.5 — §3.6
```

### 7.5 ⭐ The navigation decision that follows from `ATT-XC-011`

⛔⛔ **Attendance is never a wizard.** Because `ATT-BR-005` guarantees one
mode per attendance and `ATT-XC-011` forbids a chain, the student's path is:

```
S-S1  →  [one action]  →  outcome
```

⛔ **No step indicator, no progress bar, no "step 2 of 4", no stepper.** ⭐ The
IA is flat by requirement, not by taste. *(This is why UI/UX Pro Max #81 is
refused — §1.4 item 10.)*

---

## 8. Surface Inventory — 32 surfaces

⭐ Every row declares **App · Role · Permission scope · Tenancy scope ·
Cross-app dependency**, per §2B.3. ⛔ Tenancy is `tenant` for **all 32** —
§3.4.

### 8.1 APP 1 — Student App · `TR-4` Student (14)

| ID | Surface | Question it answers | Perm scope | Cross-app | Status | Evidence |
|---|---|---|---|---|---|---|
| `S-S1` | ⭐⭐ **Attendance today / own status** | *"Am I present right now?"* | `self` | ⭐ X-1 *(fact flows to APP 2)* | ⭐ **DESIGNABLE** | `ATT-FR-081`, §19.2 r8 |
| `S-S2` | **Fixed QR scan** (mode 1) | *"Mark me present"* | `self` | — | ⭐ **DESIGNABLE** | `ATT-FR-010`, §30.1 |
| `S-S3` | **Dynamic QR scan** (mode 2) | same | `self` | — | ⭐ **DESIGNABLE** | `ATT-FR-021`, §30.2 |
| `S-S4` | **QR + Wi-Fi outcome** (mode 3) | same, one compound check | `self` | — | ⭐ **DESIGNABLE** | `ATT-FR-031`…`037` |
| `S-S5` | **QR + GPS outcome** (mode 4) | same, one compound check | `self` | — | ⭐ **DESIGNABLE** | `ATT-FR-040`…`048` |
| `S-S6` | Face capture (mode 5) | same | `self` | — | ⛔⛔ **PROHIBITED TO BUILD** | `ATT-FR-064` |
| `S-S7` | ⭐ **Scan-failure reason** | *"What happened, and what do I do now?"* | `self` | — | ⭐ **DESIGNABLE** | `ATT-FR-018`, `ATT-BR-011`, `ATT-NFR-005` |
| `S-S8` | **Check-out** | *"I'm leaving"* | `self` | ⭐ X-1 | ⭐ **DESIGNABLE, conditional** | `ATT-BR-029`, `ATT-CFG-021` |
| `S-S9` | **My attendance history** | *"What is my record?"* | `self` | — | ⭐ **DESIGNABLE** | §19.2 r8 |
| `S-S10` | ⭐ **Exit-not-verified notice** | *"Why does yesterday look unfinished?"* | `self` | — | ⭐ **DESIGNABLE** | §10A.5 — *"student MUST be informed"* |
| `S-S11` | Passive Wi-Fi presence status | *"Am I being tracked automatically?"* | `self` | — | ⚠️ **SPECIFIED, NOT DEFINABLE** | §7.1a |
| `S-S12` | Offline-capture indication | *"Did that save?"* | `self` | — | ⚠️ **AMBIGUOUS — copy TBD** | `E-24`; ⛔ `ATT-NFR-012` caps it → `DD3-GAP-005` |
| `S-S13` | ⭐ **Location disclosure** | *"Why is location being asked for?"* | `self` | — | ⭐ **DESIGNABLE** | §10A.12 — *"student MUST be informed"* |
| `S-S14` | **Mode unavailable / disabled** | *"Is it broken?"* — no | `self` | — | ⭐ **DESIGNABLE** | `ATT-FR-104`, `ATT-FR-030` |

### 8.2 APP 1 — Student App · `TR-5` Parent (2)

| ID | Surface | Question | Perm scope | Cross-app | Status | Evidence |
|---|---|---|---|---|---|---|
| `S-P1` | ⭐ **Guarded student's attendance — READ-ONLY** | *"Is my child at the library?"* | ⭐ `guardianOf` | ⭐ X-3 | ⭐ **DESIGNABLE** | `ATT-FR-004`, §19.2 r9, `ATT-CFG-024` |
| `S-P2` | **Visibility-disabled state** | *"Why can't I see this?"* | `guardianOf` | ⭐ X-3 | ⭐ **DESIGNABLE as a rule**; ⚪ copy TBD | `ATT-CFG-024` |

⛔⛔ **Zero parent write surfaces** — `ATT-FR-119`. ⛔ Not even disabled ones (§6.4).

### 8.3 APP 2 — Library App (16)

| ID | Surface | Role(s) | Perm scope | Cross-app | Status | Evidence |
|---|---|---|---|---|---|---|
| `S-L1` | ⭐ **Reception check-in / check-out desk** | `TR-3`, `TR-2` | `tenantWide` | ⭐ X-1 | ⭐ **DESIGNABLE** | `ATT-FR-081`, §19.2 r3/r4 |
| `S-L2` | ⭐⭐ **Individual manual entry (13A)** | `TR-3`, `TR-2` · ⚪ `TR-1` TBD | `tenantWide` | — | ⭐ **DESIGNABLE** | `ATT-FR-065`…`069`, §19.2 r4 |
| `S-L3` | Register-image upload (13B) | `TR-3`, `TR-2` | `tenantWide` | — | ⛔⛔ **PROHIBITED TO BUILD** | `ATT-FR-080` |
| `S-L4` | OCR review queue (13C) | `TR-3`, `TR-2` | `tenantWide` | — | ⛔⛔ **PROHIBITED TO BUILD** | `ATT-FR-080`, `ATT-INV-009` |
| `S-L5` | **Correction surface (§18)** | `TR-3`, `TR-2` · ⚪ `TR-1` TBD | `tenantWide` | — | ⭐ **DESIGNABLE, conditional** | `ATT-FR-110`…`115`, `ATT-CFG-022`/`023` |
| `S-L6` | ⭐ **Correction history** | authorised actor | `tenantWide` | — | ⭐ **DESIGNABLE** | `ATT-FR-116`, `ATT-INV-011` |
| `S-L7` | ⭐ **Missed-check-out worklist** | `TR-2`, `TR-3` | `tenantWide` | — | ⭐ **DESIGNABLE** | `ATT-FR-082`, `ATT-BR-030`/`031` |
| `S-L8` | ⭐⭐ **Mode & value configuration (§16)** | ⭐ **`TR-1` ONLY** | `tenantWide` | — | ⭐ **DESIGNABLE** | §19.2 r1, §16.3 (24 rows) |
| `S-L8a` | ⭐⭐ **Approved Wi-Fi networks** | ⭐ **`TR-1` + `TR-2`** | `tenantWide` | — | ⭐ **DESIGNABLE** | §19.2 r2, **`D-12`**, `ATT-CFG-008` |
| `S-L9` | Fixed-QR lifecycle (activate/replace/revoke/entrance) | ⚪ **actor TBD** | `tenantWide` | — | ⚠️ **AMBIGUOUS actor** | `ATT-FR-012`…`017` → `DD3-GAP-004` |
| `S-L10` | Dynamic QR display surface | non-human | n/a | — | ⚠️ **PARTIAL** | §4.2; `ATT-FR-025` |
| `S-L11` | ⭐ **Operational reads** (8 named facts) | `TR-1`, `TR-2` | `tenantWide` | — | ⭐ **DESIGNABLE** | `ATT-FR-145`; ⛔ `ATT-FR-147` |
| `S-L12` | ⭐⭐ **Seat Card presence composition** | `TR-1`, `TR-2`, `TR-3` | `tenantWide` | ⭐⭐ **X-2 (`E-27`)** | ⚠️ **4 of 6 renderings DESIGNABLE** | §23.4a, `ADR-0032`, `ATT-AC-214`…`222` |
| `S-L13` | Unknown-device review item | `TR-1`, `TR-2` | `tenantWide` | — | ⚠️ **BLOCKED with the 7th type** | §10A.3 |
| `S-L14` | ⭐⭐ **Owner Fixed-QR limitation disclosure** | ⭐ `TR-1` | `tenantWide` | — | ⭐ **DESIGNABLE — MANDATED** | ⭐ `ATT-BR-012`, `ATT-AC-013` |
| `S-L15` | Face enrollment / consent / withdrawal | `TR-3`, `TR-2` | `tenantWide` | — | ⛔⛔ **PROHIBITED TO BUILD** | `ATT-FR-064` |

### 8.4 ⭐ Roll-up

| Status | Count | Surfaces |
|---|---|---|
| ⭐ **DESIGNABLE NOW** | **23** | `S-S1`…`S-S5`, `S-S7`…`S-S10`, `S-S13`, `S-S14` *(11)* · `S-P1`, `S-P2` *(2)* · `S-L1`, `S-L2`, `S-L5`, `S-L6`, `S-L7`, `S-L8`, `S-L8a`, `S-L11`, `S-L14` *(9)* |
| ⚠️ **PARTIAL / AMBIGUOUS** | **4** | `S-S12` (copy TBD) · `S-L9` (actor TBD) · `S-L10` (partial) · `S-L12` (4 of 6) |
| ⚠️ **NOT DEFINABLE** (7th type) | **2** | `S-S11`, `S-L13` |
| ⛔⛔ **PROHIBITED TO BUILD** | **4** | `S-S6`, `S-L3`, `S-L4`, `S-L15` |
| **TOTAL** | **32** | ⛔ 0 unassigned |

⭐⭐ **23 of 32 surfaces are designable today.** ⛔ This is why the feature is
**not** `NOT READY`.

⚠️⚠️ **An arithmetic correction, disclosed rather than silently applied.**
⭐ A first pass of this document counted **31** surfaces and **15** in APP 2.
⛔ That was wrong: ⭐ **`S-L8a` is a separate surface, not a row inside
`S-L8`** — a position §16.1 argues explicitly, because folding the delegated
Wi-Fi setting into the Owner-only configuration screen would force either
exposing 23 forbidden rows to `TR-2` or greying them, ⛔ which §2B.4 rule 6
prohibits. ⭐ Counting it as part of `S-L8` therefore contradicted this
document's own reasoning. ⭐ The measured totals are **32 surfaces (14 + 2 +
16)** and **23 designable**, and they are corrected everywhere rather than
only here.

---

## 9. Flow Inventory — 17 flows

| ID | Flow | App · Role | Perm scope | Status | Evidence |
|---|---|---|---|---|---|
| `F-1` | ⭐ Arrival → Fixed QR scan → server validation → attendance | 1 · `TR-4` | `self` | ⭐ **DESIGNABLE** | `ATT-FR-010` (10 steps) |
| `F-2` | Dynamic QR scan → validity/replay check → attendance | 1 · `TR-4` | `self` | ⭐ **DESIGNABLE** | `ATT-FR-021` |
| `F-3` | QR + Wi-Fi — **one** compound mode | 1 · `TR-4` | `self` | ⭐ **DESIGNABLE** | `ATT-FR-031`, `ATT-BR-006` |
| `F-4` | QR + GPS — **one** compound mode | 1 · `TR-4` | `self` | ⭐ **DESIGNABLE** | `ATT-FR-040`, `ATT-BR-006` |
| `F-5` | Face scan → verification → attendance | 1 · `TR-4` | `self` | ⛔⛔ **PROHIBITED** | `ATT-FR-064` |
| `F-6` | ⭐⭐ Failure → distinguishable reason → retry **or another enabled mode** | 1 · `TR-4` | `self` | ⭐ **DESIGNABLE** | ⭐ `ATT-FR-059`, `ATT-NFR-005` |
| `F-7` | Check-out → presence closes | 1 · `TR-4` | `self` | ⭐ **DESIGNABLE, conditional** | `ATT-FR-081` r3, `ATT-CFG-021` |
| `F-8` | ⭐⭐ Duplicate scan → absorbed → **treated as success** | 1 · `TR-4` | `self` | ⭐ **DESIGNABLE** | `ATT-FR-019`, `ATT-INV-003` |
| `F-9` | Offline capture → queue → replay → idempotent absorb | 1 · `TR-4` | `self` | ⚠️ **PARTIAL — copy TBD** | `ATT-PO-011`…`013`; ⛔ **not** mode 2 (`ATT-PO-014`) |
| `F-10` | ⭐ Reception search → one tap → in / out | 2 · `TR-3` | `tenantWide` | ⭐ **DESIGNABLE** | `ATT-FR-081`, §19.2 r3 |
| `F-11` | ⭐ Manual entry: search → details → validate → punch | 2 · `TR-3`,`TR-2` | `tenantWide` | ⭐ **DESIGNABLE** | `ATT-FR-066` |
| `F-12` | Register image → OCR → match → present → verify → MANUAL | 2 · `TR-3`,`TR-2` | `tenantWide` | ⛔⛔ **PROHIBITED** | `ATT-FR-071` specified; `ATT-FR-080` blocks |
| `F-13` | OCR unresolved → `NEEDS_MANUAL_VERIFICATION` → resolve / reject | 2 · `TR-3`,`TR-2` | `tenantWide` | ⛔⛔ **PROHIBITED** | `ATT-FR-074`, `ATT-INV-009` |
| `F-14` | ⭐ Correction → append-only + actor + reason → `AttendanceCorrected` | 2 · `TR-3`,`TR-2` | `tenantWide` | ⭐ **DESIGNABLE** | `ATT-FR-110`…`113`, `ATT-INV-011` |
| `F-15` | ⭐ Configuration → validate → next-operation effect → audit | 2 · `TR-1` *(+`TR-2` for `CFG-008`)* | `tenantWide` | ⭐ **DESIGNABLE** | `ATT-FR-101`…`105` |
| `F-16` | Parent opens guarded student's attendance | 1 · `TR-5` | `guardianOf` | ⭐ **DESIGNABLE** | §19.2 r9, `ATT-CFG-024` |
| `F-17` | Wi-Fi Presence 9-step automatic journey | 1 · `TR-4` | `self` | ⚠️ **NOT DEFINABLE** | §10A.10, §7.1a |

⭐ **13 designable · 1 partial · 1 not definable · 2 prohibited.**

### 9.1 ⭐ `F-1` — the canonical student flow, drawn

```
  [ S-S1  Attendance today ]
            │
            │  ⭐ ONE action. ⛔ No mode picker (§5.4). ⛔ No step indicator (§7.5).
            ▼
  [ S-S2  Scan the library's fixed QR ]
            │
            ▼
   ⏳ server-side validation           ATT-FR-011 — ⛔ client result MUST NOT be trusted
      • QR active / known / not revoked
      • tenant match                    ATT-BR-010 — ⛔ never falls back
      • student context
      • membership (E-03)               ⭐ FLAG, never block  (ATT-NFR-009)
      • attendance rules (E-04)         → lateEntry
      • check-in / check-out state      ATT-FR-081
            │
      ┌─────┴──────────────────────────────────┐
      ▼                                        ▼
 ⭐ SUCCESS                              ⛔ REJECTED
 presence opens                          one of 7 specific reasons
 [ S-S1 shows PRESENT ]                  [ S-S7 reason + next step ]
      │                                        │
      │  ⭐ a repeat scan lands HERE TOO        ▼
      │     — same confirmation (F-8)     ⭐ "Try <other enabled mode>"  ATT-FR-059
      ▼                                        │  ⛔ or ask reception → S-L2 (manual is first-class)
 ⚠️ membership expired?  →  ⭐ advisory FLAG shown, attendance STANDS
```

### 9.2 ⭐⭐ `F-8` — the duplicate flow, and why it must look identical to success

⭐ `ATT-FR-019` + `ATT-INV-003`: a repeated scan **MUST NOT** create a second
check-in. The code comment at `attendance_day.dart:67` puts the product
intent plainly: *"Returns false when the punch was a duplicate — **the caller
treats that as success, not an error**."*

⭐⭐ **Design rule (§19.4):** the student sees the **same confirmation** for a
first and a repeat scan. ⛔ *"Already checked in"* framed as a warning would
punish a behaviour the system deliberately makes harmless — and in a 6 a.m.
queue a second tap is the most likely single interaction in the product.

### 9.3 ⭐ `F-10` — Reception, the burst path

```
  [ S-L1  Reception desk ]
     │   ⭐ ATT-NFR-002 — correctness MUST NOT degrade under 50+ burst
     │   ⭐ PRD §1.1 — "a queue at the door produces staff who wave people through"
     ▼
  search (name / phone / enrolment)
     ▼
  select student → ⭐ ONE TAP
     │
     ├── no open presence   → check IN    ATT-FR-081 r1
     ├── open presence      → check OUT   ATT-FR-081 r3   ⛔ only if ATT-CFG-021 enabled
     ├── open + check-in    → ⛔ DUPLICATE, rejected, existing unchanged   r2
     └── none + check-out   → ⛔ INVALID, no record                        r4
     ▼
  ⭐ result + student name, ⛔ never a bare "OK"
  ⚠️ membership invalid → ⭐ FLAG shown to staff, attendance still recorded  ATT-NFR-009
```

⚠️ **Design note on existing code:** `reception_desk.dart:48–51` implements
`wasInside ? checkOut : checkIn` — a **2-state toggle** over a **4-row**
table, which also assumes check-out is always enabled. ⛔ `ATT-BR-029`
requires rows 3–4 to be **unreachable** when `ATT-CFG-021` is disabled.
⭐ `S-L1` therefore specifies **four** outcomes and a **check-in-only** variant
(`AIV-07`, §30.4).

---

## 10. State Model — 26 states

⭐ Attendance has **four independent state axes**. ⛔ Collapsing them is the
central design error this section exists to prevent.

### 10.1 Axis A — the nine-status vocabulary (§10A.1, `D-10`…`D-16`, `D-20`)

| # | Status | Meaning | Evaluable today? |
|---|---|---|---|
| 1 | **`VERIFIED PRESENCE`** | Correct shift **and** verified presence inside the booked window | ⚠️ **Partly** — presence yes, *"inside the booked window"* ⛔ no |
| 2 | **`SCHEDULE MISMATCH`** | Verified presence outside the booked shift, **a booking existing** | ⛔⛔ **NO** — `ATT-GAP-002a` |
| 3 | **`SESSION ENDED`** | A qualifying exit event closed the session | ⭐ **YES** |
| 4 | **`INCOMPLETE / EXIT NOT VERIFIED`** | A proper exit cannot be reliably verified | ⭐ **YES** |
| 5 | **`UNKNOWN DEVICE / UNVERIFIED PRESENCE`** | A device/account cannot be identified | ⚠️ 7th type |
| 6 | **`VERIFIED MEMBER`** | An unknown person manually verified as a member | ⚠️ 7th type |
| 7 | **`UNVERIFIED — NO ATTENDANCE`** | An unknown person not verified | ⚠️ 7th type |
| 8 | **`NO BOOKED SHIFT / PRESENCE UNASSIGNED`** | Verified presence, **no booked shift** | ⛔⛔ **NO** — `ATT-GAP-002a` |
| 9 | **`SHIFT OVERSTAY / PRESENCE OUTSIDE BOOKED WINDOW`** | Presence beyond booked shift + tolerance | ⛔⛔ **NO** — `ATT-GAP-002a` |

⛔⛔ **Rows 8 and 9 are STORED values, not derived labels**, and ⛔ **MUST NOT**
be folded into row 1 (*"would certify presence against a shift nobody
booked"*) or row 2 (*"would tell a student they missed a booking that never
existed"*). ⭐ Both placements are expressly prohibited.

⛔ **This design renames, merges, collapses and removes NONE of the nine.**
⚠️ Whether a *student-facing label* may differ from the *stored value* is
`DD3-GAP-001` / `DD3-GAP-002` — §19.2.

### 10.2 Axis B — entry/exit (`ATT-FR-081`, 4 states)

| # | Current state | Operation | Outcome | ⭐ Design |
|---|---|---|---|---|
| 1 | No open presence | Check-in | ⭐ Recorded, presence opens | Success confirmation |
| 2 | Open presence | Check-in | ⭐⭐ **Duplicate — rejected, existing unchanged** | ⭐ **Same confirmation as row 1** (§9.2) |
| 3 | Open presence | Check-out | Recorded, presence closes | Confirmation with time inside |
| 4 | No open presence | Check-out | ⛔ **Invalid — rejected, no record** | ⭐ Specific reason, ⛔ never a generic error |

⭐ `ATT-BR-029` — where `ATT-CFG-021` is disabled, ⛔ **rows 3–4 MUST be
unreachable**, and a check-in-only day is *"a complete, valid record — not an
error state."* ⭐ So `S-S1` must render a check-in-only day as **complete**,
⛔ never as "missing check-out".

### 10.3 Axis C — Seat Card renderings (§23.4a, 6)

| Rendering | §10A state | Buildable? | Source |
|---|---|---|---|
| 🟢 **PRESENT** *(+ "Presence Since")* | `VERIFIED PRESENCE`, session open | ⭐ **YES** | `ADR-0032` |
| 🟡 **PRESENCE CHECKING** | inside the 5-minute grace — ⛔ **not yet an exit** | ⭐ **YES** | §10A.4 |
| ⚪ **NOT PRESENT** | no open verified presence | ⭐ **YES** | — |
| 🟠 **NO BOOKED SHIFT / PRESENCE UNASSIGNED** | §10A.1 row 8 | ⛔ **NO** | `ATT-GAP-002a` |
| 🟡 **OUTSIDE SHIFT WINDOW** | inside tolerance, outside booked shift | ⛔ **NO** | `ATT-GAP-002a` |
| 🔴 **SHIFT OVERSTAY** | §10A.1 row 9 | ⛔ **NO** | `ATT-GAP-002a` |

⭐ Plus two further renderings named in §30.20: 🟠 **`PRESENCE UNVERIFIED`**
(manual attendance — `ATT-AC-214`: ⛔ *"never as 🟢 PRESENT"*) and ⚪
**`NOT ATTENDED`** (`ATT-AC-215`: ⛔ *"never merged"* with the former).
⚠️ Whether these are the same vocabulary as §10A.1 is `DD3-GAP-002`.

⚠️⚠️ **Note the colour collision: two renderings are both 🟡.** ⭐ They are
distinguished **only** by their words ⇒ ⭐ the label is load-bearing, not
decorative (§21.3).

### 10.4 Axis D — record flags and workflow (7)

| State | Meaning | ⭐ Design |
|---|---|---|
| `membershipValidAtEntry` = false | Membership stale/invalid at entry | ⭐⭐ **An advisory FLAG. ⛔ NEVER blocks** (`ATT-NFR-009`) — §19.6 |
| `lateEntry` = true | Late per `E-04` policy | ⭐ A neutral fact. ⛔ Never framed as misconduct |
| `capturedOffline` = true | Punch captured offline | ⚠️ Copy TBD — `DD3-GAP-005` |
| **missed check-out** | Presence open past the `E-04` boundary | ⭐ **A recorded fact** (`ATT-FR-082`); ⛔ never auto-completed (`ATT-BR-030`); ⛔ never retracts the check-in (`ATT-BR-031`) |
| `NEEDS_MANUAL_VERIFICATION` | OCR could not resolve an entry | ⛔ **BLOCKED** (`ATT-FR-080`) |
| ⭐ *Wi-Fi-based exit detected* | An observed loss qualified as the configured exit | ⛔⛔ **MUST NOT** be displayed identically to ↓ |
| ⭐ *Physically verified exit* | A human act — check-out, manual, §18 correction | ⭐ §10A.4a: the two ⛔ *"MUST NOT be conflated, merged, **displayed identically**, or stored as the same value"* |

### 10.5 ⭐ State roll-up

**9 (axis A) + 4 (axis B) + 6 (axis C) + 7 (axis D) = 26 states.**

| Evaluability | Count | Note |
|---|---|---|
| ⭐ Evaluable and designable today | **18** | All of axis B; 2 of axis A; 3 of axis C; 6 of axis D |
| ⛔ **MISSING INPUT** — `ATT-GAP-002a` | **5** | Axis A rows 2, 8, 9 · axis C 🟡 OUTSIDE SHIFT WINDOW, 🔴 SHIFT OVERSTAY |
| ⚠️ Not definable (7th type) | **3** | Axis A rows 5, 6, 7 |

---

## 11. ⭐⭐ Two-Axis Attendance Model

⭐⭐⭐ **This section exists because of one acceptance criterion, and it is the
single most consequential design constraint in `PRD-006`.**

### 11.1 The requirement, quoted

⭐ **`ATT-AC-221`/`222` (§30.20 L2850):**
> *"Presence and shift-conformance are two axes and are never collapsed into
> one. A student verified present beyond the booked window plus tolerance is
> reported as **present** *and* as **outside the booked window**; the overstay
> fact **MUST NOT** suppress, downgrade or recolour the presence fact, and the
> presence fact **MUST NOT** conceal the overstay."*

### 11.2 ⛔ What this prohibits

| Tempting design | ⛔ Verdict |
|---|---|
| One badge whose colour encodes both axes | ⛔⛔ **PROHIBITED** — recolouring presence by conformance is named explicitly |
| Overstay "wins" and shows 🔴 instead of 🟢 | ⛔ **PROHIBITED** — that *suppresses* the presence fact |
| Presence "wins" and overstay is hidden | ⛔ **PROHIBITED** — that *conceals* the overstay |
| A single `Pill('Inside'/'Away')` | ⛔⛔ **PROHIBITED** — it collapses both axes, **and** `ATT-AC-215` separately forbids merging `NOT ATTENDED` with `PRESENCE UNVERIFIED`. ⚠️ This is what ships today (`AIV-09`, §30.4) |

⭐⭐ **A genuinely simpler single-indicator design is prohibited, not merely
imprecise.** ⭐ This is the one place where *"make it simpler"* must yield to
the PRD — and the reason is sound: a student told only *"outside window"*
does not know whether they are counted present.

### 11.3 ⭐ The design: two rows, never one

```
┌──────────────────────────────────────────────┐
│  ⭐ TwoAxisAttendanceStatusCard               │   2.5D  (§26.2)
│                                              │
│  AXIS 1 — PRESENCE            ⭐ always shown │
│  🟢  Present                                  │
│      Since 06:12  (Asia/Kolkata)              │   ⭐ ATT-NFR-011 timezone-explicit
│  ──────────────────────────────────────────   │   ⭐ a visible separator: two facts
│  AXIS 2 — SHIFT CONFORMANCE                   │
│  ⚪  Not available for this library            │   ⭐ ATT-GAP-002a — §11.5
│                                              │
└──────────────────────────────────────────────┘
```

⭐ **Rules:**
1. ⭐ Axis 1 is **always** rendered when an attendance fact exists.
2. ⭐ Axis 2 occupies its **own row**, with its own icon and its own words.
3. ⛔ Axis 2 **MUST NOT** alter axis 1's colour, icon, weight or prominence.
4. ⭐ Both axes carry **colour + word** — ⛔ never colour alone (`#37`, §21.3).
5. ⭐ The separator is **structural**, so the card reads as *two facts*,
   ⛔ not one compound verdict.

### 11.4 ⭐ The matrix the card must render

| Presence (axis 1) | Conformance (axis 2) | Rendering | Evaluable? |
|---|---|---|---|
| 🟢 Present | inside booked shift | 🟢 Present **+** ⭐ *"Within your booked shift"* | ⛔ **NO** — `ATT-GAP-002a` |
| 🟢 Present | in tolerance window | 🟢 Present **+** 🟡 *"Shift time has ended"* | ⛔ **NO** |
| 🟢 Present | past tolerance (overstay) | ⭐⭐ 🟢 Present **+** 🔴 *"Outside your booked window"* | ⛔ **NO** |
| 🟢 Present | no booking exists | 🟢 Present **+** 🟠 *"No booked shift"* | ⛔ **NO** |
| 🟢 Present | ⭐ **unknown** | ⭐ 🟢 Present **+** ⚪ *"Not available"* | ⭐ **YES — today's state** |
| 🟡 Presence checking | any | 🟡 Checking **+** axis 2 unchanged | ⭐ **YES** |
| ⚪ Not present | n/a | ⚪ Not present **+** axis 2 suppressed *(no presence to conform)* | ⭐ **YES** |
| 🟠 Presence unverified *(manual)* | any | ⭐ 🟠 Unverified **+** axis 2 as available | ⭐ **YES** — `ATT-AC-214` |

### 11.5 ⭐⭐ How axis 2 behaves while `ATT-GAP-002a` is open — the honest design

⛔ `BC-03` has **no authorised input** carrying a student's booked shift
(§10A.7; `ADR-0029` `Proposed`). ⭐ Three options were considered:

| Option | ⛔ Verdict |
|---|---|
| **A** — Omit axis 2 entirely until the gap closes | ⛔ **REJECTED** — the card would silently become single-axis, and re-adding a row later is the *"design first, separate later"* failure the primary principle forbids |
| **B** — Substitute **branch opening hours** from `E-04` | ⛔⛔ **REJECTED, and expressly prohibited.** §10A.7: *"Branch hours are not a booking, and they MUST NOT be substituted for one."* A library open 06:00–22:00 with a student booked 06:00–10:00 would report `VERIFIED PRESENCE` for a 19:00 arrival — *"precisely the case the rule exists to catch"* |
| ⭐ **C** — Render axis 2 as an explicit **⚪ "Not available for this library"** | ⭐⭐ **ADOPTED** — the two-axis structure is preserved, ⛔ nothing is fabricated, and closing `ATT-GAP-002a` fills a row that already exists |

⭐ Option C is the design decision; ⛔ the gap itself stays open and
unresolved (§30.1).

### 11.6 ⚠️ Copy for the unavailable axis — ⚪ TBD, and why

⭐ The *structure* of option C is decided. ⛔ The **student-facing wording** is
not, and this document declines to fix it:

| Candidate | Risk |
|---|---|
| *"Not available for this library"* | ⚠️ Reads as a library defect |
| *"Shift check not set up yet"* | ⚠️ Implies a pending action the student cannot take |
| *"—"* | ⛔ Violates `ATT-BR-011`'s spirit: an unexplained blank is *"nothing happened"* |

→ **`DD3-GAP-001`**, **Product Owner**. ⭐ The design ships the **row**, ⛔ not
the sentence.

---

## 12. Edge Cases — 34 cases

⭐ Every case carries **App · Role** and a design disposition. ⛔ None is
invented: all 34 come from `PRD-006`.

### 12.1 §10A.4a worked examples — normative, 7 cases

⭐ `PRD-006` calls these *"normative, and each is a case a reader might
otherwise resolve differently."* Shift 06:00–10:00, tolerance 30 min, grace
5 min.

| # | Observations | Required outcome | App · Role | Design disposition |
|---|---|---|---|---|
| `E-1` | connect 05:50 · disconnect 10:10 | Presence allowed; ⭐ **Study Hours = 4 h exactly** — the 10 min before and after count **nothing** | 1 · `TR-4` | ⛔ **BLOCKED** — needs booked shift |
| `E-2` | 06:00 · 07:00 off · 08:00 on · 10:00 off | ⭐⭐ **07:00 is NOT the exit.** 10:00 is the final qualifying disconnect. ⭐ One attendance record, **never two** | 1 · `TR-4` | ⚠️ 7th type |
| `E-3` | 06:00 · 09:20 off · 09:23 on | ⭐ Reconnect inside grace ⇒ **SAME session**, ⛔ no exit, ⛔ no new record, ⛔ no double count | 1 · `TR-4` | ⭐ **Design: 🟡 PRESENCE CHECKING then silent return to 🟢** — §20.3 mandates **no alert** |
| `E-4` | 06:00 · 09:20 off · no reconnect | `SESSION ENDED` *if* the Wi-Fi exit rule qualifies; else `INCOMPLETE`. ⛔⛔ *"Under no circumstance is 'the student physically exited at 09:20' asserted"* | 1 · `TR-4` | ⭐ **Design: `S-S10`** — §19.5 |
| `E-5` | No booked shift · Wi-Fi verified | 🟠 `NO BOOKED SHIFT / PRESENCE UNASSIGNED`. ⛔ **Not** `VERIFIED PRESENCE` | 1 · `TR-4` | ⛔ **BLOCKED** — `ATT-GAP-002a` |
| `E-6` | Shift 06:00–10:00 · connected 19:00 | ⛔ **Not** normal presence — row 9 or row 2 per precedence | 1 · `TR-4` | ⛔ **BLOCKED** |
| `E-7` | Phone A 06:00–08:00 · Phone B 06:30–10:00 | ⭐⭐ **ONE** session · union **06:00–10:00 = 4 h** — ⛔ not 2 sessions, ⛔ not 6 h, ⛔ not 8 h. ⛔ No grace begins at 08:00 | 1 · `TR-4` | ⚠️ 7th type |

### 12.2 §10A.2 multi-device — 6 cases

| # | Situation | Required outcome | Design |
|---|---|---|---|
| `E-8` | Phone A **and** B verified | ⭐ **ONE** `VERIFIED PRESENCE` | ⚠️ 7th type. ⛔ The card **never** shows two sessions |
| `E-9` | A disconnects, B remains | Continue the **SAME** session | ⚠️ 7th type |
| `E-10` | B disconnects, A remains | Continue the **SAME** session | ⚠️ 7th type |
| `E-11` | **All** devices lose presence | ⭐ Grace starts — ⛔ the session does **not** end at this instant | ⚠️ 7th type ⇒ 🟡 CHECKING |
| `E-12` | Any device reconnects within 5 min | ⭐ **SAME** session; ⛔ no reset, ⛔ no double count | ⚠️ 7th type |
| `E-13` | No device for **> 5 min** | `SESSION ENDED` | ⚠️ 7th type |

⭐⭐ **`T0` is the LATEST loss across all devices, never the first** — ⛔ so no
surface may imply a "primary device".

### 12.3 ⭐⭐ Android platform — 4 cases, and the blame prohibition

| # | Platform event | What happens | ⛔ What MUST NOT happen | ⭐ Design |
|---|---|---|---|---|
| `E-14` | **Force-stop** by the user | Background execution stops; ⛔ **no presence claim for the unobserved period** | ⛔ A fabricated disconnect · ⛔ a fabricated exit · ⛔ `SESSION ENDED` | ⭐ `INCOMPLETE` → `S-S10` |
| `E-15` | **OEM battery restriction** | Observations delayed, batched or dropped | ⛔⛔ **Fabricated presence.** ⛔ *"MUST NOT be reported as student misconduct"* | ⭐ Neutral copy, §19.5 |
| `E-16` | **Device reboot** | Callbacks not re-registered until the app runs | ⛔ Inferring an exit at the reboot instant | ⭐ `INCOMPLETE` |
| `E-17` | **Permission revoked** mid-session | Verification can no longer be performed | ⛔ Continuing to assert presence · ⛔ asserting an exit | ⭐ Distinguishable, ⛔ never silent |

⭐⭐⭐ **All four are governed by one prohibition, stated twice in the PRD
(§10A.4a, §10A.5):** ⛔ *"Force-stop, reboot, permission revocation and OEM
restriction **MUST NOT** be presented as fraud, as a rule violation, or as
the student's fault."* ⭐ §19.5 turns this into copy rules.

### 12.4 Concurrency, sequence, tenancy — 8 cases

| # | Case | Rule | Design |
|---|---|---|---|
| `E-18` | Concurrent check-ins, one student | ⭐ Exactly **one** open presence | `ATT-FR-084` — ⛔ no double confirmation |
| `E-19` | Concurrent check-outs | Exactly **one** closed presence | `ATT-FR-085` |
| `E-20` | Concurrent check-in **and** check-out | ⭐ A **deterministic** final state | `ATT-FR-086` |
| `E-21` | Invalid sequence | ⭐ Rejected with a specific reason; ⛔ **no partial apply**, ⛔ **no intermediate state** | `ATT-FR-087` — ⛔ never a half-finished card |
| `E-22` | Unknown QR | Rejected, specific reason | `ATT-FR-018` |
| `E-23` | Revoked QR | ⭐ Stops producing attendance **immediately** | `ATT-FR-016` |
| `E-24` | Inactive (never activated) QR | No attendance | `ATT-FR-013` |
| `E-25` | ⭐⭐ QR bound to tenant A, scanned by a tenant-B student | ⭐ Rejected, and ⛔⛔ **MUST NOT fall back to the scanning student's tenant** | `ATT-BR-010` — ⛔ **no "did you mean your library?" affordance** |

### 12.5 Dynamic QR, clock, config, degradation — 9 cases

| # | Case | Rule | Design |
|---|---|---|---|
| `E-26` | Expired dynamic code | ⭐ *"expired"* — ⛔ **distinct from** *"invalid"* | `ATT-FR-026` — two different copies (§19.3) |
| `E-27` | Code already consumed | ⛔ No second attendance for that student-day | `ATT-FR-027` |
| `E-28` | 20 students scan the same code concurrently | ⭐ Each outcome **independent**; ⛔ one student's result never depends on another's | `ATT-FR-028`, `ATT-BR-014` |
| `E-29` | Clock skew / manipulated client clock | ⭐ **Server evaluation is authoritative** | `ATT-BR-015`, `ATT-FR-029` |
| `E-30` | **Zero modes enabled** | ⭐ **PERMITTED** — ⛔ no *"at least one mode"* rule may be enforced | `ATT-FR-106`, `ATT-GAP-018` — ⭐ `S-S14` must handle it as a real state, ⛔ not an error |
| `E-31` | Membership stale / unavailable | ⭐⭐ **Record and FLAG** — ⛔ never block | `ATT-NFR-009` |
| `E-32` | `BC-04` unavailable | ⭐ Module stays functional; occupancy advisory | `ATT-NFR-008` — ⭐ `S-L12` degrades **visibly** (`SEAT-FR-106`) |
| `E-33` | ⛔ **Offline Dynamic QR** | ⛔⛔ **Undefined — MUST NOT be promised** | `ATT-PO-014`, `ATT-GAP-016a`, `ATT-NFR-012` |
| `E-34` | Face: multiple faces / two above threshold | ⛔ **MUST NOT guess** — fail distinguishably / treat as ambiguous | `ATT-FR-057`/`058` — ⛔ **PROHIBITED TO BUILD** |

### 12.6 ⭐ Empty vs unavailable vs not-yet — three states never merged

⭐ Following `DD-0002` §7.3's rule and `ATT-AC-215`'s explicit prohibition:

| State | Meaning | ⭐ Copy intent | Component |
|---|---|---|---|
| ⚪ **NOT ATTENDED** | ⭐ A true empty: no attendance today | *"No attendance recorded today"* | `EmptyState` |
| 🟠 **PRESENCE UNVERIFIED** | ⭐ Attendance exists but was not verified *(e.g. manual)* | Neutral, ⛔ never suspicious | `Pill` |
| ⚪ **UNAVAILABLE** | ⭐ The system cannot answer *(dependency down, axis 2 blocked)* | *"Can't check right now"* | `PanelCard` degraded |

⛔⛔ **`ATT-AC-215`: *"⚪ `NOT ATTENDED` and 🟠 `PRESENCE UNVERIFIED` are never
merged… no code path maps one onto the other."*** ⚠️ Today's
`Pill('Inside'/'Away')` merges them (`AIV-09`).

---

## 13. Scan & Verification UX

### 13.1 ⛔⛔ The anti-chain rule — stated first because it shapes everything

⭐ `ATT-XC-011` + `ATT-BR-004`/`005`/`006`, and `PRD-006` §7.2's own words:

> ⛔ *"There is no normal flow `QR → GPS → Wi-Fi → Face → Attendance`. This
> sentence is written explicitly because the alternative reading is the one an
> engineer reaches for naturally… That design is prohibited here."*

| ⛔ Prohibited | ⭐ Required instead |
|---|---|
| A verification pipeline / chain / sequence | ⭐ **One** mode, ⛔ one step |
| A step indicator or stepper (`#81`) | ⭐ A single action with a single outcome |
| Requiring two methods for one attendance | ⛔ **`ATT-BR-005` forbids it** |
| Treating modes 3/4 as "QR **plus** a step" | ⭐ **`ATT-BR-006`**: one mode, a **compound condition** |
| A "choose your verification" picker | ⭐ Mode availability is `TR-1`'s setting (`ATT-FR-009`) |

⭐⭐ **Design consequence for modes 3 and 4:** the student sees **one** action
(*"Mark attendance"*) and **one** outcome. ⛔ The Wi-Fi or GPS part is never
presented as a second stage — though its **failure reason** must still be
distinguishable (§13.5).

### 13.2 ⭐ `AttendanceScanSurface` — the one student action

```
┌────────────────────────────────────────────┐
│  ⭐ AttendanceScanSurface        2.5D (§26.2)│
│                                            │
│         ┌──────────────────────┐            │
│         │   [ camera viewport ] │            │
│         │                      │            │
│         └──────────────────────┘            │
│                                            │
│      ⭐ Point at the library's code          │
│                                            │
│  ──────────────────────────────────────    │
│  ⭐ Can't scan?   →  Ask at reception        │
│      ⭐ ATT-BR-008/023 — manual is a MODE,   │
│         ⛔ not a fallback                    │
└────────────────────────────────────────────┘
```

⭐ **Rules:**
1. ⭐ **One** primary affordance. ⛔ No mode tabs, ⛔ no stepper.
2. ⭐⭐ The *"Ask at reception"* escape is **always** present — `ATT-BR-008`
   guarantees a student need not have a working phone, and `ATT-FR-059`
   requires a failure to route somewhere real.
3. ⛔ **No claim of security** appears here — `ATT-FR-039`/`050`/`ATT-BR-042`
   forbid presenting any mode as spoof-resistant.
4. ⛔ No latency promise, ⛔ no "usually takes 2 seconds" — `ATT-NFR-003`.

⚠️ **Existing-code note:** there is **no** QR/camera/scanner dependency in
`pubspec.yaml` and **no** scanning widget in `lib/`; the one QR icon
(`reception_desk.dart:147`) is a decorative text-field prefix. ⭐ So
`AttendanceScanSurface` is genuinely **new** (`AIV-08`, §27.3).

### 13.3 ⭐ The loading state — required, and honest

⭐ `ATT-FR-011`/`022`: ⛔ **every** validation is server-side and a
client-side result *"MUST NOT be trusted as the decision."*

| Requirement | ⭐ Design |
|---|---|
| The wait is real and unavoidable | ⭐ Show a **determinate-looking but unquantified** progress state (`#10`, `#78`) |
| ⛔ No latency figure may be stated | ⛔ **No countdown, no percentage, no ETA** — `ATT-NFR-003`, `ATT-GAP-017a` |
| ⛔ Optimistic confirmation is **unsafe** | ⛔⛔ **PROHIBITED** — the client cannot know the outcome |
| Double submission | ⭐ Disable the action while in flight (`#32`) — ⛔ though `ATT-FR-019` makes a duplicate harmless anyway |
| Layout stability | ⭐ Reserve the outcome area so the card does not jump (`#75` spirit) |

### 13.4 ⭐ Per-mode student experience

| Mode | Student sees | Action | ⭐ Success | Design status |
|---|---|---|---|---|
| **1 Fixed QR** | A printed/displayed wall code | ⭐ One scan | ⭐ Presence opens; ⭐ **a repeat scan shows the same confirmation** | ⭐ **DESIGNABLE** |
| **2 Dynamic QR** | A rotating on-screen code | One scan | Same | ⭐ **DESIGNABLE** |
| **3 QR + Wi-Fi** | ⭐ **One** action, ⛔ not two | One scan | Same | ⭐ **DESIGNABLE** |
| **4 QR + GPS** | ⭐ **One** action | One scan *(+ OS permission, §13.7)* | Same | ⭐ **DESIGNABLE** |
| **5 Face** | A scanner | Present face | — | ⛔⛔ **PROHIBITED — `ATT-FR-064`** |
| **6 Manual** | ⭐ **Nothing — staff record it** | ⭐ **None** | Staff confirms | ⭐ **DESIGNABLE** (§14) |

### 13.5 ⭐⭐ The 19 distinguishable failure signals — `FailureReasonSheet`

⭐ `ATT-BR-011`: ⛔ *"A failure **MUST NOT** be silent… 'nothing happened' is
not an acceptable result of a scan."*
⭐ `ATT-NFR-005`: ⛔ *"A generic failure is a **defect**."*

| # | Reason | Mode | ⭐ Next step the student is offered | Requirement |
|---|---|---|---|---|
| 1 | Unknown code | 1,3,4 | ⭐ *"Ask at reception"* | `ATT-FR-018` |
| 2 | Revoked code | 1,3,4 | *"This code is no longer in use — ask at reception"* | `ATT-FR-016`/`018` |
| 3 | Inactive code | 1,3,4 | Same | `ATT-FR-013` |
| 4 | ⭐ Code belongs to another library | 1,3,4 | ⭐ *"This code is for a different library"* — ⛔ **no fallback offered** | ⭐ `ATT-BR-010` |
| 5 | Mode disabled for this library | all | ⭐ *"Your library uses a different method"* → `S-S14` | `ATT-FR-104` |
| 6 | No authenticated session | all | Re-authenticate *(`BC-18`'s surface, ⛔ not this one)* | `ATT-FR-018` |
| 7 | No student record in this tenant | all | ⭐ *"Ask reception to link your enrolment"* | `ATT-FR-018` |
| 8 | ⭐ **Expired** dynamic code | 2 | ⭐ *"That code has changed — scan the new one"* | ⭐ `ATT-FR-026` |
| 9 | ⭐ **Invalid** dynamic code | 2 | ⛔ **Distinct copy from #8** | ⭐ `ATT-FR-026` |
| 10 | Code already used | 2 | *"Already recorded"* ⇒ ⭐ treat as success (§9.2) | `ATT-FR-027` |
| 11 | ⭐ **Wi-Fi unavailable** on the device | 3 | ⭐ *"Turn on Wi-Fi, or ask at reception"* | ⭐ `ATT-FR-034` |
| 12 | ⭐ **Network not approved** | 3 | ⛔ **Distinct from #11** — *"Connect to the library network"* | ⭐ `ATT-FR-035` |
| 13 | Location unavailable | 4 | *"Can't get your location — ask at reception"* | `ATT-FR-043` |
| 14 | ⭐⭐ **Location permission denied** | 4 | ⭐ *"Attendance needs location for this method"* + how to allow. ⛔⛔ **MUST NOT be reported as a system error** | ⭐ `ATT-FR-044` |
| 15 | Location inaccurate | 4 | *"Your location isn't precise enough right now"* | `ATT-FR-045` |
| 16 | Outside the library area | 4 | *"You appear to be outside the library"* | `ATT-FR-046` |
| 17 | Failed face match | 5 | *"Use another method"* → `ATT-FR-059` | ⛔ blocked |
| 18 | Ambiguous / multiple faces | 5 | ⛔ **Never a guess** | ⛔ blocked |
| 19 | Duplicate / invalid sequence | all | ⭐ #10 as success; invalid check-out gets its own reason | `ATT-FR-081` r2/r4 |

⭐⭐ **Three pairs must never share a copy string:** #8≠#9 (`ATT-FR-026`),
#11≠#12 (`ATT-FR-034`/`035`), #14≠any generic error (`ATT-FR-044`).
⛔ **And #16 must not be worded as an accusation** — `ATT-BR-042` plus the
blame prohibition; *"You appear to be outside"* ⛔ not *"You are not at the
library."*

### 13.6 ⛔ No silent downgrade — a state that must be visible

⭐ `ATT-FR-036`/`047`: a failed Wi-Fi or GPS condition ⛔ **MUST NOT** create
an attendance record and ⛔ **MUST NOT** silently downgrade to plain Fixed QR.

⭐⭐ **Design rule:** where mode 3 or 4 fails its condition, the student sees a
**failure** (#11–#16), ⛔ **never** a success that quietly used a weaker
method. ⛔ This is the single most tempting "helpful" shortcut in the whole
feature, and it is prohibited twice.

### 13.7 ⭐ `S-S13` — location disclosure, and what it may not claim

⭐ §10A.12 (`D-21`): Location Verification is **optional, default OFF**, and
⭐ *"the student **MUST** be informed appropriately."*

| ⭐ May say | ⛔ MUST NOT say |
|---|---|
| ⭐ *"This library checks you're on site when you mark attendance"* | ⛔ *"We track your location"* — false; it is a point-in-time check |
| ⭐ *"You can still mark attendance another way"* (`ATT-BR-008`) | ⛔ *"Location is required"* — ⛔ `ATT-FR-044`, and §10A.12: a denial *"MUST NOT destroy all attendance capability"* |
| ⭐ *"Location is not used to identify you"* (`ATT-XC-016`) | ⛔ *"This prevents proxy attendance"* — ⛔ `ATT-FR-050`, `ATT-BR-042` |

⛔ **No Android permission is asserted as a fact** — §10A.12 leaves that to
`ADR-0027` (`Proposed`). ⭐ So the disclosure describes a **product
behaviour**, ⛔ never an OS permission list.

---

## 14. Manual Attendance UX

### 14.1 ⭐⭐ First-class, not a fallback — and the design must show it

⭐ `ATT-BR-023`: manual attendance is ⛔ *"not a temporary fallback, not a
degraded path, and not an exception requiring justification."*
⭐ `ATT-BR-008` + goal **G-6**: a student ⛔ **MUST NOT** be required to have a
smartphone.

| ⛔ Prohibited framing | ⭐ Required framing |
|---|---|
| ⛔ "Fallback", "manual override", "exception" | ⭐ *"Record attendance"* — a normal action |
| ⛔ Hidden behind an "advanced" or overflow menu | ⭐ **A primary action on `S-L1`** |
| ⛔ Requiring a typed justification | ⛔ `ATT-BR-023` — ⛔ no justification field |
| ⛔ A visual "degraded" treatment | ⭐ The **same** visual weight as a scan-produced record |

⭐⭐ **`ATT-NFR-014` makes this an accessibility obligation, not a preference:**
⛔ *"Accessibility of attendance surfaces **MUST NOT** be worse for the Manual
mode than for the app modes; the students served by Manual are those least
served by devices."* → §21.1.

### 14.2 ⭐ `S-L1` Reception desk — the burst-optimised surface

⭐ Design target from `PRD-006` §1.1 and `G-4`: **50+ students in a few
minutes**, because ⛔ *"a queue at the door produces staff who wave people
through — which converts a correct system into an unused one."*

```
┌──────────────────────────────────────────────────┐
│  Reception                    ⭐ 23 inside now    │  ← ATT-FR-145 operational read
│  ┌────────────────────────────────────────────┐  │     ⛔ NOT a certified metric (147)
│  │ 🔍  Search name / phone / enrolment         │  │
│  └────────────────────────────────────────────┘  │
│                                                  │
│  ⭐ Results — ONE TAP per student                 │
│  ┌────────────────────────────────────────────┐  │
│  │ ⭐ Aarav Kumar    ENR-1042        [  IN  ]   │  │  ← no open presence  → r1
│  ├────────────────────────────────────────────┤  │
│  │ ⭐ Priya Sharma   ENR-0988        [ OUT  ]   │  │  ← open presence     → r3
│  │    ⚠️ Plan expired — ⭐ attendance still allowed │  ← ATT-NFR-009 FLAG, never block
│  └────────────────────────────────────────────┘  │
│                                                  │
│  ⭐ Currently inside  (23)                        │
│  … list …                                        │
└──────────────────────────────────────────────────┘
```

⭐ **Rules:**
1. ⭐ **One tap** per student — ⛔ no confirmation dialog (idempotency makes a
   double tap harmless, §22 P-8).
2. ⭐⭐ **Four outcomes**, not two (`ATT-FR-081`); and where `ATT-CFG-021` is
   disabled the `OUT` affordance ⛔ **does not exist** (`ATT-BR-029`).
3. ⭐ Confirmation always names the **student** — ⛔ never a bare *"Done"*.
4. ⭐ An expired plan renders as an **advisory flag beside the action**, ⛔ never
   as a blocker (`ATT-NFR-009`).
5. ⛔ **No revenue or fee figure appears here** — reception's scope is
   attendance; ⛔ exposing business data would exceed §19.2's grant.

### 14.3 ⭐ `S-L2` Individual manual entry — `ATT-FR-066`'s four steps

```
search / select student  →  enter details  →  validate authorisation
                                            →  validate duplicate & sequence
                                            →  create the punch
```

| Field | Requirement | ⭐ Design |
|---|---|---|
| Student | ⭐ Resolved against the **authoritative** directory | ⭐ `ATT-FR-073` — ⛔ `BC-03` keeps **no** student directory ⇒ reuse `DD-0002`'s search pattern (§28 C-4) |
| Date | Required | Explicit, ⛔ never implied |
| Check-in time | Required | ⭐ Timezone-explicit (`ATT-NFR-011`) |
| Check-out time | Where applicable | ⛔ Absent when `ATT-CFG-021` disabled |
| Method | ⭐ **`MANUAL`, permanently** | ⛔ `ATT-BR-024` — a manual entry ⛔ *"MUST NOT silently become a QR… record"* ⇒ ⭐ **the method is displayed, never editable** |
| Acting staff | ⭐ Recorded | `ATT-FR-067`, `ATT-FR-069` audit |
| ⛔ Justification | ⛔ **NOT a field** | ⛔ `ATT-BR-023` — manual needs no excuse |

⛔ **Tenant guard:** `ATT-BR-025` — ⛔ staff **MUST NOT** record attendance for
a student outside the active tenant ⇒ ⭐ out-of-tenant students ⛔ **do not
appear in search results at all**.

### 14.4 ⛔⛔ `S-L3` / `S-L4` — the OCR workflow is PROHIBITED TO BUILD

⭐ `ATT-FR-080`: ⛔ *"Until `ATT-GAP-010` and `ATT-GAP-011` are answered by
their named owners, the OCR/Vision workflow **MUST NOT** be implemented."*

| What this document does | What it ⛔ does NOT do |
|---|---|
| ⭐ Records the surfaces (`S-L3`, `S-L4`) and flows (`F-12`, `F-13`) as **specified but prohibited** | ⛔ **No wireframe, no component spec, no copy** is produced for them |
| ⭐ Records the requirement set (`ATT-FR-070`…`079`, `ATT-INV-009`, `ATT-BR-026`…`028`) | ⛔ **No design decision** is taken that would need revisiting |
| ⭐ Names `OCRReviewQueue` as a **BLOCKED** component (§27.4) | ⛔ It is **not** designed |

⭐⭐ **§13E's own reasoning is why this split is correct:** *"The two manual
workflows are deliberately separable. 13A needs nothing that does not already
exist. 13B needs two edges that do not exist."* ⭐ So `S-L2` ships and `S-L3`
waits — ⛔ and turning the blocked workflow into a buildable design would
manufacture exactly the false readiness §13E avoids.

⚠️ **Note for whoever closes the gaps:** `ATT-FR-078`'s audit chain is
**unconditional within the workflow** — ⛔ *"if the answers do not permit the
full chain to be retained, **the workflow does not ship** — the chain is not
the part that gets dropped."*

---

## 15. Parent Read-Only UX

### 15.1 ⭐ The grant, exactly as written

⭐ `ATT-FR-004`: parent access **MUST** be **read-only**, scoped to guarded
students only — ⭐ *"Master PRD §6 grants 'attendance visibility' — **visibility
is not mutation**."*
⭐ §19.2 r9: `parent` · *View guarded students' attendance* · scope
`guardianOf` · ⭐ **subject to `ATT-CFG-024`**.

### 15.2 ⭐ `S-P1` — calm by design

```
┌────────────────────────────────────────────┐
│  ⭐ Aarav's attendance                      │
│                                            │
│  ⭐ 🟢 In the library now                   │  ← plain, factual
│      Since 06:12  (Asia/Kolkata)            │  ← ATT-NFR-011
│                                            │
│  ⭐ Today                                   │
│  ┌──────────────────────────────────────┐  │
│  │ In 06:12   ·   still inside           │  │  ⛔ no total, no %, no streak
│  └──────────────────────────────────────┘  │
│                                            │
│  ⭐ Recent days                             │
│  │ Mon  in 06:05  out 10:02               │
│  │ Sun  in 06:20  ⚠️ exit not verified     │  ← neutral (§19.5)
│                                            │
│  ⭐ You can see attendance, plan status and  │  ← scope disclosure
│     fees. ⛔ You cannot change records.      │     (§15.5)
└────────────────────────────────────────────┘
```

### 15.3 ⛔⛔ Zero write affordances — absent, not disabled

⭐ `ATT-FR-119`: a parent ⛔ *"MUST NOT create, correct or delete any
attendance record."*

⭐⭐ **Design rule (from §6.4):** parent write controls are **ABSENT**, ⛔ not
greyed. ⭐ A disabled *"Correct"* button tells a parent the power exists and is
being withheld from them — ⛔ it does not exist for them at all. ⭐ This also
removes a source of friction and of misplaced blame toward the student.

### 15.4 ⭐ `S-P2` — visibility disabled by the Owner

⭐ `ATT-CFG-024` *Parent attendance visibility* · Owner · default **Enabled** ·
boolean.

| ⭐ Required behaviour | Rationale |
|---|---|
| ⭐ An **explained state**, ⛔ not an error, ⛔ not an empty list | ⭐ A library's configuration choice is not a fault, and ⛔ an unexplained blank violates `ATT-BR-011`'s spirit |
| ⭐ Names **who** decided *(the library)*, ⛔ not the student | ⛔ Implying the student hid it would be blame-shifting |
| ⛔ **No** "request access" action | ⛔ No requirement authorises such a flow — ⛔ inventing one would invent a permission |
| ⚪ Exact copy | ⚪ **TBD — `DD3-GAP-001`** |

### 15.5 ⭐ Scope disclosure — reuse, not invention

⚠️ **Existing code already does this well:** `parent_dashboard.dart:167`
reads *"You can see attendance, plan status and fees — the things a…"*
(`AIV-12`).

⭐ **Disposition:** ⭐ adopted as a **pattern** because it reduces surveillance
perception (§22 P-11/P-13) — ⛔ but recorded honestly as **evidence class B**,
since ⛔ **no `ATT-*` requirement mandates a scope disclosure to the parent.**
⛔ It is therefore design reasoning, ⛔ not a requirement, and it is listed in
§31 as a QA expectation rather than a blocking condition.

### 15.6 ⛔⛔ What the parent surface must never contain

| ⛔ Prohibited | Source |
|---|---|
| ⛔ Attendance **percentage** | ⛔⛔ `NG-6`, `ATT-FR-146` — owned by `BC-26` |
| ⛔ **Streaks** or consecutive-day counts | ⛔⛔ `NG-6` |
| ⛔ Weekly/monthly **totals** or Study-Hours aggregates | ⛔⛔ `NG-6`, `ATT-FR-146` |
| ⛔ A **`MeterBar`** or any progress-toward-target visual | ⛔⛔ §27.2 — `NG-6` + `PRD-006` L2278 |
| ⛔ Comparison to other students | ⛔ No requirement; ⛔ pure dark pattern |
| ⛔ Notification pressure ("Aarav hasn't arrived yet") | ⛔⛔ §20.3 — ⛔ not a `PRD-006` signal; ⛔ inventing a cadence is forbidden |

⚠️⚠️ **A live deviation is recorded here, not designed around:**
`parent_dashboard.dart:43`/`:109` sums `timeInside` across history and labels
it *"Days attended"* — ⛔ that is **aggregation**, which `NG-6` and
`ATT-FR-146` assign to `BC-26`, and `ATT-FR-147` bars presenting an
operational read as a certified figure. ⭐ `S-P1` above shows **per-day facts
only**. → `AIV-10`, §30.4.

---

## 16. Configuration UX

### 16.1 ⭐⭐ Role separation — the design's clearest `TR-1`/`TR-2`/`TR-3` distinction

⭐ This is how §2B.4 **rule 6** is satisfied in practice, ⛔ rather than by
greying controls:

| Surface | `TR-1` Owner | `TR-2` Manager | `TR-3` Reception | Source |
|---|---|---|---|---|
| `S-L8` **all 24 `ATT-CFG` rows** | ⭐ **VISIBLE** | ⛔ **NOT IN NAVIGATION** | ⛔ **NOT IN NAVIGATION** | §19.2 r1 |
| `S-L8a` **approved Wi-Fi only** | ⭐ **VISIBLE** | ⭐ **VISIBLE** | ⛔ **NOT IN NAVIGATION** | §19.2 r2, **`D-12`** |

⭐⭐ **`S-L8a` is a genuinely separate surface, not a row inside `S-L8`.**
⛔ Placing it inside the Owner-only configuration screen would force either
(a) exposing 23 forbidden rows to `TR-2`, or (b) greying 23 rows — which is
the *"one screen with controls greyed out by role"* pattern §2B.4 rule 6
prohibits. ⭐ Two surfaces, two audiences.

⛔ **And `D-12` grants `TR-2` nothing else** — `ATT-FR-033`: *"This grants
`manager` no other permission"*; `ATT-FR-118` forbids defining one.

### 16.2 ⭐ `S-L8` — the configuration surface

⭐ 24 rows from §16.3, each with owner, default, allowed domain, validation,
effect timing and auditability.

| ⭐ Required behaviour | Requirement |
|---|---|
| ⭐ Validate **before** persistence; ⛔ never partially apply | `ATT-FR-101` (`LIB-16.3`) |
| ⭐ An invalid value is rejected **with a specific reason**, and ⭐ the **previous value remains in force** | `ATT-FR-102` — ⛔ never silently blanked |
| ⭐⭐ A change takes effect **from the next attendance operation** | `ATT-FR-103` — ⛔ **MUST NOT** retroactively alter any existing record (`MP-GBR-19`) |
| ⭐ Disabling a mode stops new attendance immediately, and ⛔ **MUST NOT** delete, invalidate or retract attendance already recorded through it | `ATT-FR-104` |
| ⭐ Every change emits an audit fact carrying the actor | `ATT-FR-105`, `ATT-FR-038` |
| ⭐ **Zero modes enabled is PERMITTED** | `ATT-FR-106`, `ATT-GAP-018` — ⛔ no *"at least one"* rule may be enforced or implied by the UI |

⭐⭐ **Design consequence of `ATT-FR-103`/`104`:** the surface must state
*"applies from the next check-in"* and ⭐ **reassure that history is
untouched**. ⛔ An Owner who fears disabling a mode will delete records will
not configure the product correctly.

⭐ **Dependency rows need dependent affordances:** `ATT-CFG-003` requires
`ATT-CFG-008` set; `ATT-CFG-004` requires `ATT-CFG-010`. ⭐ Where the
prerequisite is empty the mode ⛔ **cannot enable** — so the design shows the
prerequisite **inline**, ⛔ not as a post-hoc rejection.

### 16.3 ⭐⭐ `S-L14` — the mandated Fixed-QR limitation disclosure

⭐⭐ **This is the only surface in the entire feature whose *copy* is
mandated by a business rule.**

⭐ `ATT-BR-012`: Fixed QR is long-lived and reusable, *"so a photograph of it
will scan. **Fixed QR alone therefore does not prove the student was
physically present**… This limitation **MUST** be stated to the Owner at
configuration time (§16) and **MUST NOT** be described as fraud-proof."*
⭐ Verified by `ATT-AC-013`.

```
┌──────────────────────────────────────────────────┐
│  Fixed QR                            [ ● enabled ]│
│                                                  │
│  ⭐⭐ Before you enable this                       │
│  ⭐ A fixed code can be photographed and shared.   │
│     It proves a signed-in student's app sent your │
│     library's code — ⛔ not that they were here.   │
│                                                  │
│  ⭐ If you need a presence signal, Fixed QR + Wi-Fi│
│     or Fixed QR + GPS add one.                    │
│     ⛔ Neither is spoof-resistant.  ATT-FR-039/050 │
└──────────────────────────────────────────────────┘
```

⭐ **Rules:**
1. ⭐ Shown **at configuration time**, ⛔ not buried in help.
2. ⛔ **MUST NOT** be described as fraud-proof (`ATT-BR-012`).
3. ⭐ `ATT-BR-042`: *"where a protection is bounded, the bound **MUST** be
   stated wherever the control is offered"* ⇒ ⭐ the same treatment applies to
   modes 3 and 4, whose bounds are `ATT-GAP-007` and `ATT-GAP-008a`.
4. ⛔ **No mode anywhere may be presented as spoofing-resistant** while those
   gaps are open.

### 16.4 ⭐ `S-L9` Fixed-QR lifecycle — ⚪ actor TBD

⭐ `ATT-FR-012`…`017` mandate the **capability**: per-tenant generation,
explicit activation, entrance association, replacement (⛔ without
invalidating recorded attendance), revocation (⭐ effective immediately), and
an audit fact on each.

⚠️⚠️ **But `PRD-006` §19.2 contains no row for QR lifecycle management.** ⭐ The
capability is required and ⛔ **its actor is unassigned**.

| Tempting inference | ⛔ Why refused |
|---|---|
| *"It's configuration, so `TR-1`"* | ⚠️ Plausible — ⛔ but §19.2's configuration row is *"Configure attendance modes and values (§16)"*, and QR lifecycle is §8.3, ⛔ not §16 |
| *"Reception handles the door, so `TR-3`"* | ⛔ Unsupported by any row |

⭐⭐ **Therefore the surface is specified structurally and its navigation
placement is left ⚪ TO BE DECIDED** → **`DD3-GAP-004`**, **Product Owner +
Architecture Owner**. ⛔ No actor is assigned by this design.

### 16.5 ⭐ `S-L11` — operational reads, and the metric line they must not cross

⭐ `ATT-FR-145` permits **eight** named operational facts: students currently
inside · check-ins today · check-outs today · attendance by mode · failed
attempts · manual entries · OCR entries requiring verification · active modes.

| ⭐ Permitted | ⛔ Prohibited |
|---|---|
| ⭐ *"23 inside now"* as an **operational read** | ⛔ Any **percentage** (`NG-6`, `ATT-FR-146`) |
| ⭐ *"41 check-ins today"* | ⛔ Any **streak** |
| ⭐ *"7 manual entries"* | ⛔ Weekly/monthly **aggregation** |
| ⭐ Counts by mode | ⛔ A **certified metric** framing (`ATT-FR-147`) |
| — | ⛔⛔ A **`MeterBar`** or progress-toward-target visual (§27.2) |
| — | ⛔ Any claim that contradicts `BC-26` (`ATT-FR-147`) |

⭐⭐ **`MetricTile` is reused, deliberately without a target.** ⭐ It shows a
count and a label; ⛔ it shows no goal, no bar and no comparison — because
*"students currently inside"* is an **attendance fact**, while *"which seats
are physically in use"* is `BC-04`'s **occupancy fact** (§23.1). ⭐ They
usually agree and are ⛔ **not the same statement**.

⚠️ **Deliberately NOT added to this surface:** *verified session duration.*
⭐ §10A.6 records an open ARB question on whether duration is an operational
fact or a `BC-26` metric, and ⛔ *"`ATT-FR-145`'s list is deliberately left
unamended. Adding session duration to it would silently pre-empt the
ruling."* ⭐ This design does not add it either.

---

## 17. Correction & Missed Check-out UX

### 17.1 ⭐ `S-L5` — corrections, append-only and visible

⭐ `ATT-INV-011`: a correction **MUST** be **append-only**, carrying the
acting actor **and** a reason; ⛔ *"No correction path **SHALL** overwrite or
delete the corrected value."*
⭐ `ATT-BR-040` (`MP-GBR-11`): ⛔ *"Attendance **MUST NOT** be silently
manipulable. Corrections exist; **invisible corrections do not**."*

| ⭐ Required behaviour | Requirement |
|---|---|
| ⭐ Reason is **mandatory** | `ATT-INV-011` — ⛔ no save without it |
| ⭐ Acting actor recorded and shown | `ATT-INV-011` |
| ⭐⭐ The **original value stays visible** | ⛔ `ATT-INV-011` — the UI ⛔ **never** replaces the old value with the new |
| ⭐ **Method is immutable** | ⛔ `ATT-FR-112` — *"Correcting a timestamp does not convert a Manual entry into a QR entry"* ⇒ ⭐ the method field is **read-only** in this surface |
| ⭐ Outside the correction window ⇒ ⭐ rejected **with a specific reason** | `ATT-FR-115`, `ATT-CFG-023` *(default 15 min, range 0–60)* |
| ⭐ The surface may not exist at all | `ATT-CFG-022` — ⛔ absent, not disabled (§6.4) |
| ⭐ Emits `attendance.AttendanceCorrected` | `ATT-FR-111` (`ATT-EVT-003`) |

⭐ **Design consequence of the window:** because `ATT-CFG-023` can be as low
as 0 minutes, the surface must handle *"corrections are not available for
this record"* as a **normal, explained state** — ⛔ not an error.

### 17.2 ⭐ `S-L6` `AttendanceCorrectionHistory` — original **and** correction

⭐ `ATT-FR-114`: correcting a missed check-out **MUST** be possible, and ⭐ *"the
resulting record **MUST** show **both** the original missed state and the
correction."*
⭐ `ATT-FR-116`: the **full** history must be retrievable by an authorised
actor.

```
┌──────────────────────────────────────────────────┐
│  ⭐ Aarav Kumar · 12 Aug 2026                     │
│                                                  │
│  ⭐ As recorded                                   │
│  │ In  06:12  (Asia/Kolkata)                     │  ← ATT-NFR-011
│  │ Out  —     ⚠️ missed check-out                 │  ← original state PRESERVED
│  │ Method  MANUAL        ⛔ immutable  ATT-FR-112 │
│                                                  │
│  ⭐ Corrections  (append-only)                    │
│  │ 12 Aug 10:40 · R. Nair                        │
│  │   Out → 10:05                                 │
│  │   ⭐ Reason: "student left, staff forgot to tap"│
│  ────────────────────────────────────────────────│
│  ⛔ Nothing here can be edited or removed.        │  ← ATT-BR-040
└──────────────────────────────────────────────────┘
```

⭐⭐ **The two-block structure is required, not stylistic:** *As recorded*
never changes; *Corrections* only grows. ⛔ A design that showed the corrected
value in place would violate `ATT-INV-011` and make the record *"silently
manipulable"*.

⚠️ **Existing-code note:** `recordCorrection(actor, reason)` stores
`'actor: reason'` in a `List<String>` — ⭐ append-only ✅, actor ✅, reason ✅,
⛔ but **no timestamp, no original value, no window check**. ⭐ Insufficient for
`ATT-FR-114`/`115`/`116` (`AIV-13`, §30.4).

### 17.3 ⭐ `S-L7` `MissedCheckoutWorklist` — a worklist, ⛔ not an error log

⭐ `ATT-FR-082`: where check-out is enabled and a presence stays open past the
`E-04` boundary, the day **MUST** be marked as having a **missed check-out**.

| ⭐ Required | ⛔ Prohibited |
|---|---|
| ⭐ A **recorded fact**, correctable under §18 | ⛔ **Auto-completion with an invented timestamp** — `ATT-BR-030` |
| ⭐ The check-in **stands** | ⛔ Deleting, invalidating or retracting it — `ATT-BR-031` |
| ⭐ Nothing is emitted downstream | ⛔⛔ A **fabricated** `StudentCheckedOut` — `ATT-FR-083` |
| ⭐ Neutral framing toward the student | ⛔ Fault, fraud or rule-violation framing (§19.5) |

⭐⭐ **Why the design must resist an "auto-close all" bulk action** — and this
is the strongest available reason: ⭐ `ATT-FR-083`'s own rationale is that
Seating derives live occupancy from `E-08`, so ⛔ *"a fabricated check-out
would silently free a seat that is still occupied… **Fabricating one is worse
than missing one**."*

⭐ The worklist therefore offers **per-record correction** with a required
reason (§17.1) — ⛔ never a blanket close.

⭐⭐ **Six prohibited inferred end times, from §10A.5** — ⛔ **none** may appear
as a default, a suggestion or a placeholder in the correction field:
⛔ the scheduled shift end · ⛔ midnight or any day boundary · ⛔ the app-close
time · ⛔ the phone shutdown/battery-exhaustion time · ⛔ the last known network
event · ⛔ *"any other arbitrary end time"*.

⭐ The staff member **types** the time they know. ⛔ The system suggests
nothing.

### 17.4 ⭐⭐ The exit-fact distinction — two facts, never one field

⭐ §10A.4a: ⛔ *"These **MUST NOT** be conflated, merged, **displayed
identically**, or stored as the same value."*

| Fact | ⭐ What it is | ⛔ What it is not | ⭐ Design treatment |
|---|---|---|---|
| **Attendance exit event** | The configured exit the product recognises | ⛔ Not a physical observation | Labelled as *recorded exit* |
| **Verified presence end** | The end of the measured verified interval | ⛔ **Not a claim the student then left** | ⭐ Shown as an interval end, ⛔ never as "left at" |
| **Physical exit certainty** | Only ever a human act — check-out, manual, §18 correction | ⛔ **Never** derived from a network event | ⭐ The only one that may read *"checked out"* |

⭐⭐ **`PRD-006` retracted its own error here and the design honours the
retraction:** §10A.5 records that an earlier review inferred a session
*"whose verified presence ends"* at the last event, and ⛔ names that the
forbidden slide. ⭐ So *"last seen 09:20"* ⛔ **MUST NOT** be rendered as
*"left at 09:20"*.

---

## 18. Seat Card Cross-Feature UX

### 18.1 ⭐ Ownership — what this design may and may not specify

⭐ `S-L12` is a **`BC-04` Seating surface** that **composes** a `BC-03`
presence fact over read edge **`E-27`** (`ADR-0032`, `Accepted`, option
`O-5`).

| ⭐ This document specifies | ⛔ This document does NOT specify |
|---|---|
| ⭐ How the **presence** dimension should read | ⛔ The **seat** dimension — `BC-04`/`PRD-007` owns it |
| ⭐ Which renderings are evaluable today | ⛔ Seat map layout, zones or allocation UX |
| ⭐ The prohibitions that bind the presence fact | ⛔ Any change to `SEAT-FR-*` |

⛔ **`PRD-007` is `FROZEN` Rank 3.** ⭐ Where this section and `PRD-007`
disagree, `PRD-007` wins.

### 18.2 ⭐ What the frozen contract already guarantees

⭐ Checked, ⛔ not assumed — §23.4a records these as *already law on the other
side of the boundary*:

| Guarantee | Source |
|---|---|
| ⭐⭐ *"`Occupied` means **allocated**, not physically present"* | `SEAT-FR-041` |
| ⭐ The card shows **both** derived `SeatState` **and** `occupancy` | `SEAT-FR-103` — widened to **4** presence states by `ADR-0032` |
| ⭐ Cross-context values are composed **at read time**, labelled with an as-of time, and ⛔ **never stored on the seat** | `SEAT-FR-104`/`105` |
| ⭐ The card **degrades visibly** rather than failing or showing a stale value as current | `SEAT-FR-106` |
| ⭐ Occupancy is **advisory and recomputable**, ⛔ never authoritative | `SEAT-FR-115`/`116` |

⭐⭐ **So the "do not overwrite seat status with attendance status" requirement
needs nothing added on either side** — §23.4a records that it *"is already
guaranteed by a frozen Rank 3 document."*

### 18.3 ⭐ The six renderings — 4 designable, 2 blocked

| Rendering | ⭐ Design | Buildable? |
|---|---|---|
| 🟢 **PRESENT** + *"Presence Since"* | ⭐ Green + word + timestamp *(timezone-explicit)* | ⭐ **YES** |
| 🟡 **PRESENCE CHECKING** | ⭐ Amber + word; ⭐⭐ **reassuring, ⛔ never alarming** — §18.5 | ⭐ **YES** |
| ⚪ **NOT PRESENT** | Neutral + word | ⭐ **YES** |
| 🟠 **PRESENCE UNVERIFIED** *(manual)* | ⭐ Orange + word — `ATT-AC-214`: ⛔ **never 🟢** | ⭐ **YES** |
| 🟡 **OUTSIDE SHIFT WINDOW** | *(specified)* | ⛔ **NO** — `ATT-GAP-002a` |
| 🔴 **SHIFT OVERSTAY** | *(specified)* | ⛔ **NO** — `ATT-GAP-002a` |

⭐ Plus ⚪ **NOT ATTENDED**, which `ATT-AC-215` requires to be ⛔ **never
merged** with 🟠 `PRESENCE UNVERIFIED`.

### 18.4 ⛔⛔ Five prohibitions the Seat Card design must honour

| # | ⛔ Prohibited | Source |
|---|---|---|
| 1 | ⛔⛔ The Seat Card reading **raw Wi-Fi data** | §23.4a; `ATT-BR-045`, `SEAT-BR-020`, BC Map L292 |
| 2 | ⛔ Inferring `PRESENCE CHECKING` from the **absence** of a recent event | §23.4a — *"the 'last known network event' fabrication §10A.5 prohibits, relocated to another context"* |
| 3 | ⛔⛔ Overloading `StudentCheckedOut` to mean *"entered grace"* | §23.4a; `ATT-AC-217` — it would emit *"a check-out that did not happen"* |
| 4 | ⛔ Any **SSID, BSSID, MAC, signal strength** in the composed facts | ⭐ `ATT-AC-218` |
| 5 | ⛔ A consumer **persisting** the composed presence | ⭐ `ATT-AC-219`; `SEAT-FR-104`/`105` |

⭐ **And the fixed direction of flow, which the design must not shortcut:**

```
Wi-Fi observation → Attendance verification → student presence
                  → existing Seat/Occupancy contract → Seat Card
```

### 18.5 ⭐⭐ 🟡 `PRESENCE CHECKING` — the most UX-significant rendering

⭐ It exists so that a brief network drop is ⛔ **not** shown as an exit
(§10A.4a row 4; §20.3 row 1 forbids alerting on it).

| ⭐ Required reading | ⛔ Prohibited reading |
|---|---|
| ⭐ *"Checking"* — a transient, expected condition | ⛔ *"Lost"*, *"Disconnected"*, *"Error"* |
| ⭐ Presence is **still held** | ⛔ Implying the student has left |
| ⭐ Resolves silently back to 🟢 | ⛔ A notification on recovery — §20.3 |
| ⭐ A **static** alternative under reduced motion | §21.8 |

⭐⭐ **`ATT-AC-216` is load-bearing here:** entering grace, crossing the booked
shift end and crossing tolerance each publish ⛔ **no event at all** — ⭐ so the
card's amber state is a **read-time composition**, ⛔ never a pushed update.
⭐ The design must therefore not promise live push refresh.

### 18.6 ⭐ Degradation — `SEAT-FR-106` + `ATT-NFR-008`

⭐ `ATT-NFR-008`: the attendance module stays functional when `BC-04` is
unavailable. ⭐ `SEAT-FR-106`: the card degrades **visibly**.

⭐ **Design:** where the presence composition cannot be performed, the card
shows the **seat** dimension and marks the **presence** dimension ⚪
*"unavailable"*, with its as-of time. ⛔ It ⛔ **MUST NOT** show a stale
presence as current, and ⛔ **MUST NOT** fall back to 🟢 or ⚪ `NOT PRESENT` —
both would assert a fact.

⚠️ **Existing-code note:** `seat_map_page.dart:146` uses a **binary**
`occupancy.isOccupied`, while `SEAT-FR-103` was widened to **four** presence
states by `ADR-0032`/`PRD-007` v1.1. ⭐ This is `BC-04`'s surface, so it is
**reported, not designed here** (`AIV-16`, §30.4).

---

## 19. Copy / Content Rules

### 19.1 ⭐ The five rules that govern every string

| # | Rule | Source |
|---|---|---|
| 1 | ⭐⭐ **Never silent.** *"'Nothing happened' is not an acceptable result of a scan"* | `ATT-BR-011` |
| 2 | ⭐⭐ **Never generic.** *"A generic failure is a defect"* | `ATT-NFR-005` |
| 3 | ⭐⭐ **Never blaming.** ⛔ Not fraud, not a rule violation, not the student's fault | §10A.4a, §10A.5 *(stated twice)* |
| 4 | ⭐ **Never overstating.** Where a protection is bounded, ⭐ the bound is stated wherever the control is offered | `ATT-BR-042` |
| 5 | ⭐ **Always timezone-explicit** | `ATT-NFR-011` (`LIB-12.4`) |

### 19.2 ⚠️⚠️ Status values vs student-facing labels — ⚪ the honest TBD

⭐ §10A.1's nine statuses are a **Product-Owner-fixed vocabulary** (`D-10`…
`D-16`, `D-20`), and ⛔ this document renames, merges, collapses and removes
**none** of them.

⚠️ **But are they *display strings*?** ⭐ Two measured observations:

| Observation | Implication |
|---|---|
| ⭐ §23.4a and §30.20 use **different** strings — `PRESENCE UNVERIFIED`, `NOT ATTENDED` — for Seat Card renderings | ⭐ Suggests a **display layer distinct from the stored vocabulary** |
| ⭐ `PRD-006` nowhere requires a raw status string to be shown **to a student** | ⭐ Suggests the constraint governs the **value**, ⛔ not the label |
| ⚠️ `SCHEDULE MISMATCH`, `PRESENCE UNASSIGNED` are **system terms** | ⚠️ A student with varying digital literacy (§23 I-8) may not parse them |

⭐⭐ **This document does NOT decide it.** ⛔ Choosing either way would either
invent student copy over a PO-fixed vocabulary, or force system terms onto a
student surface on an inference.

→ **`DD3-GAP-001`** *(may a Design Doc specify student-facing labels?)* and
**`DD3-GAP-002`** *(is §30.20's vocabulary a second display layer?)*, both
**Product Owner**. ⭐ Every surface in this document therefore specifies the
**state, structure and tone**, ⛔ and marks the exact sentence as ⚪ TBD.

### 19.3 ⭐ The distinguishability pairs — ⛔ never the same string

| Pair | Requirement |
|---|---|
| ⭐ *"expired"* ≠ *"invalid"* | ⭐ `ATT-FR-026` — *"a distinguishable 'expired' reason, **separate from** 'invalid'"* |
| ⭐ *"Wi-Fi unavailable"* ≠ *"network not approved"* | `ATT-FR-034` / `ATT-FR-035` |
| ⭐ *"permission denied"* ≠ any generic/system error | ⛔ `ATT-FR-044` — *"**MUST NOT** be reported as a system error"* |
| ⭐ *"location unavailable"* ≠ *"inaccurate"* ≠ *"outside area"* | `ATT-FR-043`/`045`/`046` |
| ⭐ *"failed match"* ≠ *"ambiguous match"* | `ATT-FR-056` / `ATT-FR-057`/`058` |
| ⭐ ⚪ `NOT ATTENDED` ≠ 🟠 `PRESENCE UNVERIFIED` | ⭐⭐ `ATT-AC-215` — *"never merged… no code path maps one onto the other"* |
| ⭐ *Wi-Fi-based exit* ≠ *physically verified exit* | ⭐ §10A.4a — ⛔ *"MUST NOT be… displayed identically"* |

### 19.4 ⭐⭐ Confirmation copy — and the duplicate that must look identical

| Event | ⭐ Copy intent |
|---|---|
| First successful check-in | ⭐ *"You're marked present"* + time *(timezone-explicit)* |
| ⭐⭐ **Repeat scan (duplicate)** | ⭐⭐ **The same confirmation.** ⛔ Not *"already checked in"* as a warning, ⛔ not an error tone |
| Check-out | *"Checked out"* + time inside |
| Invalid check-out (`r4`) | ⭐ A specific reason, ⛔ never a generic failure |

⭐ **Why:** `ATT-FR-019` + `ATT-INV-003` make a repeat harmless, and the
domain code itself records *"the caller treats that as success, not an
error."* ⭐ In a 6 a.m. queue a second tap is the most likely single
interaction in the product — ⛔ punishing it would be punishing correct
behaviour.

### 19.5 ⭐⭐ The blame-free register — the four platform outcomes

⭐ `PRD-006` states the prohibition **twice**. ⭐ Applied:

| Situation | ⭐ Required tone | ⛔ Prohibited |
|---|---|---|
| Exit could not be verified | ⭐ *"We couldn't confirm when you left"* | ⛔ *"You did not check out"* · ⛔ *"You forgot to…"* |
| Force-stopped app | ⭐ *"Attendance wasn't being recorded for a while"* | ⛔ *"You closed the app"* · ⛔ any fraud implication |
| OEM battery restriction | ⭐ *"Your phone paused this in the background"* | ⛔⛔ Misconduct framing — ⛔ *"MUST NOT be reported as student misconduct"* |
| Permission revoked | ⭐ *"This method needs permission to work"* | ⛔ *"You revoked…"* |

⭐⭐ **The grammatical rule that operationalises the prohibition:** ⭐ use the
**first-person plural for system limits** (*"we couldn't confirm"*) and
⛔ **avoid second-person for failures** (*"you didn't…"*). ⭐ The student
**MUST** still be informed — §10A.5 requires it — ⛔ but as a **fact**, ⛔ never
as an accusation.

### 19.6 ⭐⭐ The membership flag — an advisory, never a refusal

⭐ `ATT-NFR-009`: where membership validity is stale or unavailable,
attendance **MUST** still be recordable and **MUST** be **flagged rather than
blocked**.
⭐ The domain code carries the intent verbatim: *"Never lock a paying student
out at the door over a stale projection."*

| ⭐ Required | ⛔ Prohibited |
|---|---|
| ⭐ An advisory flag **alongside** a successful attendance | ⛔ A blocking dialog |
| ⭐ Staff-facing: *"Plan expired"* beside the action that still works | ⛔ A disabled check-in control |
| ⭐ Student-facing: a fee/plan notice that ⛔ does **not** imply attendance failed | ⛔ Framing the flag as an attendance error |

### 19.7 ⛔ Words this feature may never use

| ⛔ Forbidden | Why |
|---|---|
| ⛔ *"streak"*, *"percentage"*, *"attendance rate"*, *"goal"*, *"target"* | ⛔⛔ `NG-6`, `ATT-FR-146` — `BC-26`'s, and a **non-goal** |
| ⛔ *"secure"*, *"tamper-proof"*, *"spoof-proof"*, *"fraud-proof"* | ⛔ `ATT-BR-012`, `ATT-FR-039`, `ATT-FR-050`, `ATT-BR-042` |
| ⛔ *"verified identity"*, *"we know it's you"* | ⛔ `ATT-XC-014`, `ATT-XC-016`, `ATT-XC-018` — ⛔ Wi-Fi/GPS/Face are **not** identity |
| ⛔ *"we track you"*, *"monitoring"* | ⛔ `ATT-AC-218`; §22 P-11/P-13 |
| ⛔ *"fallback"*, *"manual override"*, *"exception"* for Manual | ⛔ `ATT-BR-023` — Manual is **first-class** |
| ⛔ *"left at HH:MM"* for a network-derived end | ⛔ §10A.5, §17.4 |
| ⛔ *"required"* for location | ⛔ §10A.12 — optional, default OFF |
| ⛔ *"within 2 seconds"* or any timing promise | ⛔ `ATT-NFR-003`, `ATT-GAP-017a` |
| ⛔ *"works offline"* for Dynamic QR | ⛔ `ATT-PO-014`, `ATT-NFR-012` |

---

## 20. Notification Rules

### 20.1 ⭐⭐ What `BC-03` may and may not do

⭐ `ATT-FR-148`: this module **MUST** emit notification-relevant occurrences
as **facts** via `E-23`, and ⛔ **MUST NOT** select a channel, render a
template, apply quiet hours or dispatch a message (`X-04`, `LIB-16.5`).

| ⭐ This design specifies | ⛔ This design must NOT specify |
|---|---|
| ⭐ **Which outcomes must be distinguishable** | ⛔ Channel (push / SMS / email) — `BC-22`'s |
| ⭐ **Who** the recipient is, where the PRD names them | ⛔ Template or rendering |
| ⭐ **Tone and content intent** | ⛔ Quiet hours |
| ⭐ Which situations must stay **silent** | ⛔⛔ **Frequency, cooldown, retry count, escalation ladder** — ⛔ *"none may be invented"* |

### 20.2 ⭐ The 19 signals and their recipients

| Signal group | ⭐ Recipient | Design status |
|---|---|---|
| 12 mode / sequence failures *(§13.5 #1–#19)* | ⭐⭐ *"the actor who caused them"* | ⭐ **DESIGNABLE** |
| `SCHEDULE MISMATCH` | student · Owner · Manager | ⛔ **BLOCKED** — `ATT-GAP-002a` |
| `UNKNOWN DEVICE` | ⭐ Owner/Manager **review item** — ⛔ **no student notification** | ⚠️ 7th type |
| ⭐ `INCOMPLETE / EXIT NOT VERIFIED` | ⭐ **student informed** | ⭐ **DESIGNABLE** — `S-S10` |
| Tolerance window entered | student **and** staff — ⭐ a **window fact**, ⛔ not a status change | ⛔ **BLOCKED** |
| `SHIFT OVERSTAY` | student · Owner · Manager | ⛔ **BLOCKED** |
| `NO BOOKED SHIFT` | ⭐ an **auditable review** item | ⛔ **BLOCKED** |
| Location unavailable / denied | actor — ⛔ never a silent downgrade | ⭐ **DESIGNABLE** |
| Wi-Fi exit vs physical exit | ⭐ the reader — the two **MUST** be distinguishable | ⚠️ 7th type |

⭐⭐ **The recipient rule is a design finding in itself:** failures go to
*"the actor who caused them"* — ⭐ so a student's failed scan is ⛔ **not** a
staff alert, and `UNKNOWN DEVICE` is ⛔ **not** a student alert *(there is no
identified student to notify)*.

### 20.3 ⭐⭐ The four mandated silences

⭐ `PRD-006` §25 names four situations as **explicitly NOT
notification-worthy**, ⭐ *"because an over-alerting product is a failure mode
of its own"*:

| # | Situation | ⭐ Required behaviour |
|---|---|---|
| 1 | A reconnect **within** the 5-minute grace *(`E-3`)* | ⭐⭐ **NO alert.** *"Nothing happened that concerns the student — same session, no exit, no lost time"* |
| 2 | An ordinary short Wi-Fi loss inside the grace | ⭐⭐ **NO alarmist notification.** *"A dropped radio is not an incident"* |
| 3 | Presence in the 05:30–06:00 early-arrival window | ⭐ **No alert required** — the presence is simply not counted |
| 4 | An observation gap later filled by reconciliation | ⭐⭐ **NO retrospective alarm** — *"the gap was a platform artefact, not a student act"* |

⭐⭐⭐ **These four are as binding as the 19 signals.** ⛔ A design that "helpfully"
surfaces a brief disconnect violates a frozen requirement — and it is exactly
the anxiety-manufacturing pattern §22 P-3 warns against.

### 20.4 ⛔⛔ What may never be invented

| ⛔ Prohibited | Source |
|---|---|
| ⛔ Notification **frequency** | ⛔ *"none may be invented"* — §25 |
| ⛔ **Cooldown** | ⛔ §25 |
| ⛔ **Quiet-hour** rule | ⛔ `X-04`, `LIB-16.5` — `BC-22`'s |
| ⛔ **Retry count** | ⛔ §25 |
| ⛔ **Escalation ladder** | ⛔ §25 — the PO *"withheld every interval explicitly"* |
| ⛔ A *"you haven't arrived yet"* nudge | ⛔ Not a `PRD-006` signal at all — ⛔ inventing it is both a requirement violation and a dark pattern |

⭐⭐ **Honest assessment: the notification surface is, by requirement, the
least pressuring part of this product** — and the PRD's design risk is
**under**-notifying, ⛔ not over-notifying. ⭐ It accepts that trade
deliberately, and this design does not second-guess it.

---

## 21. Accessibility

### 21.1 ⭐⭐ One RATIFIED requirement — and it is Attendance-specific

⭐⭐⭐ **`ATT-NFR-014` (§27):** ⛔ *"Accessibility of attendance surfaces **MUST
NOT** be worse for the Manual mode than for the app modes; **the students
served by Manual are those least served by devices**."*

⭐⭐ **This is the first ratified accessibility obligation encountered in any
audited Liboora PRD**, and it is binding.

| ⭐ Design consequence | Applies to |
|---|---|
| ⭐ `S-L2` manual entry gets **equal or better** treatment than `S-S2` scan | `S-L2` vs `S-S2`…`S-S5` |
| ⛔ Manual ⛔ **MUST NOT** be a smaller, denser or lower-contrast surface | `S-L2` |
| ⛔ Manual ⛔ **MUST NOT** need more steps than a scan | `F-11` vs `F-1` |
| ⛔ Manual ⛔ **MUST NOT** be buried in an overflow menu | §14.1 |
| ⭐ Manual's confirmation is **as clear** as a scan's | §19.4 |

⭐ **A correction to an assumption this document could have inherited:** it is
⛔ **not** true that "no accessibility requirement exists" for this feature.
⭐ `ATT-NFR-014` is ratified, narrow and binding.

### 21.2 ⛔ What remains unratified — ⛔ and is NOT invented here

⭐ Following `DD-0001`/`DD-0002`'s disposition exactly:

| Item | Status | ⛔ Why not decided here |
|---|---|---|
| A **product-wide** accessibility standard | ⛔ **UNRATIFIED** | ⛔ No Liboora source ratifies WCAG or any level. ⛔ Inventing one would bind the whole product from an unranked document |
| Contrast ratios | ⚪ **TBD** | ⛔ `DBT-001` leaves `LiblColors` values unratified |
| Touch-target minimums | ⭐ **Methodology only** | ⭐ UI/UX Pro Max guidance; ⛔ **not** a ratified product requirement — §21.7 |
| Type scale | ⚪ **TBD** | ⛔ `DBT-001` |

### 21.3 ⭐⭐ Colour + text, never colour alone

⭐ **`PRD-006` already satisfies this, and the design must not undo it.**
§23.4a names every rendering with **both** a colour and a word — 🟢 PRESENT,
🟡 PRESENCE CHECKING, ⚪ NOT PRESENT, 🟡 OUTSIDE SHIFT WINDOW, 🔴 SHIFT
OVERSTAY, 🟠 NO BOOKED SHIFT.

⚠️⚠️ **And there is a colour collision that makes the label load-bearing:**

| Rendering | Colour | Distinguished by |
|---|---|---|
| 🟡 **PRESENCE CHECKING** | amber | ⭐⭐ **the word only** |
| 🟡 **OUTSIDE SHIFT WINDOW** | amber | ⭐⭐ **the word only** |

⭐⭐ **Therefore the text is not decoration and ⛔ MUST NOT be truncated,
abbreviated, or dropped at small sizes** — two different states would become
indistinguishable. ⭐ This satisfies UI/UX Pro Max `#37` and is **required**
by the PRD's own vocabulary, ⛔ not merely recommended.

### 21.4 ⭐ Error announcement

⭐ `ATT-NFR-005` + `ATT-BR-011` require distinguishable, non-silent failures.
⭐ Mapped to methodology `#44`:

| ⭐ Design | Rationale |
|---|---|
| ⭐ Failure reasons are announced assertively *(live region / `role=alert` equivalent)* | ⭐ A silent visual-only failure would be silent **for a screen-reader user**, violating `ATT-BR-011` for that user |
| ⭐ Each of the 19 reasons announces its **own** text | ⭐ `ATT-NFR-005` — a shared announcement is a generic failure |
| ⭐ Success is also announced | `#34` |

### 21.5 ⭐ Semantic state meaning — two distinct announcements

⭐ `ATT-AC-215` requires ⚪ `NOT ATTENDED` and 🟠 `PRESENCE UNVERIFIED` never
to be merged. ⭐⭐ **Design consequence for assistive technology: they must
produce two *different* announcements**, ⛔ not one shared "no attendance"
string. ⭐ The same applies to the two 🟡 states (§21.3).

⭐ The two-axis card (§11) announces **both axes**, in order: presence first,
conformance second — ⛔ never a single merged sentence, which would collapse
the axes for a screen-reader user while preserving them visually.

### 21.6 ⭐ Disabled vs absent — an accessibility consequence, not just a rule

⭐ From §6.4: a control the actor can **never** hold is **absent**.

⭐⭐ **Why this matters for assistive technology:** a disabled control is still
announced, so a parent using a screen reader would hear a *"Correct
attendance, dimmed"* control that ⛔ `ATT-FR-119` says they may never use.
⭐ Absence is the accessible choice **and** the correct one.

### 21.7 ⭐ Touch targets — methodology, ⛔ not a ratified requirement

⚠️ ⛔ **No Liboora source ratifies a touch-target size.** ⭐ Recorded as
methodology because the 6 a.m. burst (`G-4`) makes it materially important:
⭐ `S-L1`'s one-tap IN/OUT control is the highest-frequency target in the
product, and ⭐ a mis-tap there costs queue time.

⛔ **No number is stated here.** → carried with `DBT-001`/`DBT-002` in §30.2.

### 21.8 ⭐ Reduced motion — the one state that needs an alternative

⭐ 🟡 **`PRESENCE CHECKING`** is the only attendance state with a natural
"pending" animation.

| ⭐ Required | Rationale |
|---|---|
| ⭐ A **static** variant conveying the same meaning | ⭐ Motion must not be the **only** carrier of a state — the same logic as `#37` for colour |
| ⭐ Under reduced motion: amber + the word, ⛔ no pulse | Methodology `#12` |
| ⛔ ⛔ The **state must remain distinguishable** without motion | ⭐ `ATT-NFR-005` |

⭐ The five motion specs from `DD-0001` §10 are reused (§26.4), ⛔ not
re-derived.

### 21.9 ⭐ Accessibility checklist — 9 items

| # | Check | Status |
|---|---|---|
| 1 | ⭐ Manual mode ≥ app modes | ⭐ **RATIFIED REQUIREMENT** — `ATT-NFR-014` |
| 2 | ⭐ Colour + text for every state | ⭐ **SATISFIED** by the PRD's vocabulary; ⛔ must not be undone |
| 3 | ⭐ The two 🟡 states distinguishable by text | ⭐ **REQUIRED** — §21.3 |
| 4 | ⭐ Each of 19 failures announces its own reason | ⭐ **REQUIRED** — `ATT-NFR-005` |
| 5 | ⭐ ⚪ `NOT ATTENDED` ≠ 🟠 `PRESENCE UNVERIFIED` in speech | ⭐ **REQUIRED** — `ATT-AC-215` |
| 6 | ⭐ Two-axis card announces both axes | ⭐ **REQUIRED** — `ATT-AC-222` |
| 7 | ⭐ Absent, not disabled, where never permitted | ⭐ **REQUIRED** — `ATT-FR-119` |
| 8 | ⭐ Reduced-motion alternative for 🟡 CHECKING | ⭐ **DESIGN DECISION** |
| 9 | Contrast / type / touch targets | ⚪ **TBD** — `DBT-001`, `DBT-002` |

---

## 22. Psychology / Behavioral UX

⛔⛔ **EVIDENCE CLASS DECLARED UP FRONT.** Per §29.6's discipline, every row
below is classified:
**A** = authoritative requirement · **B** = existing implementation evidence ·
**C** = UI/UX Pro Max methodology · **D** = psychology/behavioural analysis ·
**E** = unvalidated UX hypothesis · **F** = open product decision.

⛔⛔ **NO STUDENT RESEARCH EXISTS IN THIS REPOSITORY, AND NONE IS CLAIMED.**
⛔ Nothing below is presented as a research finding.

### 22.1 ⭐⭐ The convergence finding — stated first because it is the headline

⭐⭐⭐ **Every anti-dark-pattern constraint the design brief demands is
*independently* mandated or prohibited by frozen `PRD-006`.** ⭐ Six for six:

| Dark pattern | Brief | ⭐ `PRD-006` | Class |
|---|---|---|---|
| ⛔ Streak pressure | ⛔ Never | ⭐⭐ **`NG-6` + `ATT-FR-146`** — streaks are a **non-goal**, owned by `BC-26` | **A** |
| ⛔ Guilt / shame / blame | ⛔ Never | ⭐⭐ §10A.4a + §10A.5 — ⛔ *"MUST NOT be presented… as the student's fault"* **(stated twice)** | **A** |
| ⛔ Artificial urgency | ⛔ Never | ⭐ §25 — ⛔ *"NO alarmist notification. A dropped radio is not an incident"* | **A** |
| ⛔ Manipulative notifications | ⛔ Never | ⭐ `ATT-FR-148` — **facts only**; ⛔ no invented cadence | **A** |
| ⛔ Fear framing | ⛔ Never | ⭐ `ATT-BR-042` — ⛔ no overstated control | **A** |
| ⛔ Surveillance UX | ⛔ Never | ⭐ `ATT-AC-218` — ⛔ no raw network datum leaves the module | **A** |

⭐⭐ **Consequence: the calm, trustworthy, non-manipulative experience requires
overriding NOTHING.** ⛔ Not one requirement had to be bent, softened or
reinterpreted to satisfy the behavioural brief.

### 22.2 ⭐ The thirteen behavioural dimensions

| # | Dimension | Finding | ⭐ Design response | Class |
|---|---|---|---|---|
| **P-1** | **Cognitive load** | ⭐ Minimal by construction — `ATT-BR-005` caps the student at **one** method. ⚠️ The real load is the **9-status system vocabulary**, ⛔ not the scan | ⭐ §7.5 flat IA; ⚪ labels → `DD3-GAP-001` | **D** *(on A)* |
| **P-2** | **Uncertainty reduction** | ⭐⭐ `ATT-BR-011` + `ATT-NFR-005` are, in effect, **ratified anti-uncertainty requirements** | ⭐ §13.5's 19 distinct reasons | **D** *(on A)* |
| **P-3** | **Anxiety** | ⭐⭐ The highest-anxiety state is `INCOMPLETE / EXIT NOT VERIFIED`: the student **did nothing wrong** and **cannot fix it** | ⭐ §19.5's blame-free register; ⭐ `S-S10` explains ⛔ without accusing | **D** |
| **P-4** | **Perceived control** | ⚠️ The 7th type **structurally reduces** it — attendance happens *to* the student (§10A.10 steps 6–7). ⭐ Mitigation is **visibility**, ⛔ not a new action | ⛔ **Currently moot** — the type is not definable | **D + E** |
| **P-5** | **Error frustration** | ⭐⭐ `ATT-FR-059` is the strongest anti-frustration requirement in the PRD: a failure **MUST** be reportable *"so the student can be served by another enabled mode"* | ⭐ `F-6`; ⭐ the always-present *"Ask at reception"* escape (§13.2) | **A** |
| **P-6** | **Waiting psychology** | ⭐ The wait is **real** (`ATT-FR-011` server-side) and ⛔ **unquantifiable** (`ATT-NFR-003`) | ⭐ §13.3 — ⭐ progress feedback, ⛔ no ETA, ⛔ no optimistic UI | **C + D** *(on A)* |
| **P-7** | **Confirmation clarity** | ⭐⭐ `ATT-FR-019` makes duplicates **succeed** ⇒ ⭐ first and repeat scans must confirm **identically** | ⭐ §19.4 | **D** *(on A)* |
| **P-8** | **Accidental / repeated actions** | ⭐ Idempotency (`ATT-FR-090`…`095`) makes them harmless ⇒ ⭐⭐ **no confirmation dialog is needed** before a scan or a reception tap | ⭐ §14.2 rule 1 — ⛔ adding one would add friction for a risk that does not exist | **D** *(on A)* |
| **P-9** | **Interruption recovery** | ⭐⭐ Fully specified: §10A.4's grace is *"a predicate over recorded observations"*, ⛔ never a timer; ⭐ recovery within grace is **silent by requirement** | ⭐ §18.5's reassuring 🟡; ⭐ §20.3 row 1's mandated silence | **A** |
| **P-10** | **Notification pressure** | ⭐⭐ **Structurally prevented** — `ATT-FR-148` limits `BC-03` to facts; §25's four rows forbid alarm; ⛔ no cadence may be invented | ⭐ §20.3, §20.4 | **A** |
| **P-11** | **Privacy perception** | ⚠️⚠️ **The genuine risk area.** ⭐ `ATT-AC-218`'s guarantee is strong but ⛔ **invisible to the student** | ⭐ §24.5 — ⛔ and the disclosure gap is recorded, ⛔ not invented away | **D + E** |
| **P-12** | **Decision fatigue** | ⭐ ⛔ **Not a risk** — mode availability is the **Owner's** choice (`ATT-FR-009`) | ⛔ §5.4 — ⛔ a "choose your method" picker would **manufacture** a decision the PRD assigns elsewhere | **D** *(on A)* |
| **P-13** | **Surveillance feeling** | ⚠️ §10A.2's *"Device-level observations MAY exist for audit"* is honest but latent. ⭐ `ATT-XC-014` forbids Wi-Fi = identity | ⭐ §24.5's honest framing — *"the library network confirms you're here"*, ⛔ never *"we can see your device"* | **D + E** |

### 22.3 ⭐ The seven questions, answered per major student interaction

⭐ Asked of `F-1` (scan), `F-6` (failure), `F-8` (duplicate) and `S-S10`
(exit not verified):

| # | Question | Scan `F-1` | Failure `F-6` | Duplicate `F-8` | `S-S10` |
|---|---|---|---|---|---|
| 1 | Understands what happened? | ⭐ **YES** | ⭐ **YES** — 1 of 19 specific reasons | ⭐ **YES** | ⭐ **YES** |
| 2 | Knows what to do next? | ⭐ **YES** — nothing | ⭐⭐ **YES** — `ATT-FR-059` names another mode | ⭐ **YES** — nothing | ⚠️ **PARTLY** — ⛔ **nothing they *can* do**; ⭐ the design says so honestly rather than implying an action |
| 3 | Feels in control? | ⭐ **YES** | ⭐ **YES** | ⭐ **YES** | ⚠️ **REDUCED** — ⭐ mitigated by explaining the **cause** (platform, ⛔ not them) |
| 4 | Uncertainty reduced? | ⭐ **YES** | ⭐ **YES** | ⭐ **YES** | ⭐ **YES** |
| 5 | Unnecessary anxiety avoided? | ⭐ **YES** | ⭐ **YES** | ⭐⭐ **YES** — ⛔ **only if the duplicate is not framed as a warning** | ⭐ **YES** — by the blame prohibition |
| 6 | Faster than alternatives? | ⭐⭐ **YES** — one tap vs a paper register | ⭐ **YES** | ⭐ **YES** | n/a |
| 7 | Feedback clear without noise? | ⭐ **YES** | ⭐ **YES** | ⭐ **YES** | ⭐⭐ **YES** — ⛔ and §20.3 keeps the *non*-events silent |

### 22.4 ⭐ Motivation without manipulation

⭐⭐ **`NG-6` removes the entire conventional motivation toolkit** — no
percentages, no streaks, no dashboards, no totals. ⭐ What remains is
legitimate and sufficient:

| ⭐ Permitted motivator | Why it is legitimate |
|---|---|
| ⭐ **Speed** — attendance takes one tap | ⭐ `G-4`; a product that is fast gets used |
| ⭐ **Certainty** — the student always knows their state | ⭐ `ATT-BR-011`, `ATT-NFR-005` |
| ⭐ **Fairness** — a no-phone student is served equally | ⭐ `ATT-BR-008`, `ATT-NFR-014` |
| ⭐ **Honesty** — the product never overstates what it knows | ⭐ `ATT-BR-042`, §10A.8 |
| ⛔ Rewards, badges, streaks, leaderboards, progress bars | ⛔⛔ **PROHIBITED** — `NG-6`, `ATT-FR-146`, §27.2 |

⭐ **Class D observation:** trust is the motivator this feature can actually
build, because the PRD spends more text on *not overclaiming* than on any
other single topic.

---

## 23. Indian Student UX

⛔⛔ **CLASS D + E THROUGHOUT. ⛔ No field research exists in this repository,
and none is claimed.** ⭐ Where a row rests on a requirement it is marked **A**.

### 23.1 ⭐ Priority order, applied

⭐ **CLARITY > DECORATION · SPEED > ANIMATION · TRUST > TRICKS · USABILITY >
NOVELTY · CONTROL > CONFUSION**

⭐ Applied concretely: ⭐ §26 allocates **0** surfaces to 3D · ⭐ §13.3 forbids an
invented ETA · ⭐ §19.7 bans eight classes of overclaiming word · ⭐ §7.5
forbids a wizard · ⭐ §11 keeps two axes visible even though one badge would
look cleaner.

### 23.2 ⭐ The ten conditions

| # | Condition | Finding | ⭐ Design response | Class |
|---|---|---|---|---|
| **I-1** | **Android-first, low-end devices** | ⭐⭐ **Anticipated by the PRD itself** — §10A.10 names force-stop, OEM battery restriction, reboot and permission revocation as **expected platform outcomes**, ⛔ not misconduct. ⭐ `ADR-0028`'s matrix is *"six columns of To be decided"* | ⛔ **No background promise is designed** (§25.4); ⭐ §12.3's four cases get neutral copy | **A + D** |
| **I-2** | **Slow / lossy network** | ⭐ `ATT-FR-011`/`022` force a **server round-trip** ⇒ ⛔ optimistic UI is **unsafe**, not merely imprecise | ⭐ §13.3 — visible progress, ⛔ no ETA, ⛔ no fake success | **A + C** |
| **I-3** | **Temporary connectivity loss** | ⭐ Offline capture authorised via `E-24` for modes 1, 3, 4, 5, 6 — ⛔ **NOT** mode 2 (`ATT-PO-014`) | ⭐ `S-S12`; ⛔ ⚪ copy TBD — `DD3-GAP-005` | **A** |
| **I-4** | **Burst traffic at opening** | ⭐⭐ The PRD's own framing: ⛔ *"a queue at the door produces staff who wave people through — which converts a correct system into an unused one"* | ⭐ §14.2's one-tap desk; ⛔ no confirmation dialogs (P-8) | **A + B** |
| **I-5** | **One-handed operation** | ⚠️ ⛔ No requirement | ⭐ Methodology only: ⭐ the single primary action sits in the lower half of `S-S1`. ⛔ No measurement stated | **C + E** |
| **I-6** | **Varying digital literacy** | ⭐ `ATT-BR-008` + Manual mode is the **product's** answer. ⚠️⚠️ The design risk is the **status vocabulary** — `SCHEDULE MISMATCH`, `PRESENCE UNASSIGNED` are system terms | ⭐ §19.2 records the question honestly → ⚪ `DD3-GAP-001`/`002`; ⛔ **no relabelling is performed** | **A + D + F** |
| **I-7** | **Low-light reading halls** | ⚠️ ⛔ No requirement; ⛔ `DBT-001` leaves colour values unratified ⇒ ⛔ **contrast cannot be decided here** | ⭐ Noted as a `DBT-001` input, ⛔ not a decision | **E + F** |
| **I-8** | **English / Hinglish / local-language expansion** | ⚠️ ⛔ **No localisation requirement exists anywhere in `PRD-006`.** ⭐ `ATT-NFR-011`'s timezone-explicitness is the only locale-adjacent rule | ⭐ Design consequence recorded: ⭐ copy slots must tolerate **length growth**, and ⭐ §21.3's labels ⛔ **must not be truncated** — which localisation pressure would otherwise force | **A + E** |
| **I-9** | **No-smartphone students** | ⭐⭐ **First-class by requirement** (`ATT-BR-008`, `G-6`) **and accessibility-protected** (`ATT-NFR-014`) — ⭐ a stronger commitment than most products make | ⭐ §14.1's framing rules; ⭐ §21.1's parity obligation | **A** |
| **I-10** | **Students who want it to "just work"** | ⭐ The 7th type (§10A) *is* that intent — ⛔ **and it is the one capability that is not definable** | ⭐ The buildable answer today is **one tap**, which is close | **A + D** |

### 23.3 ⭐⭐ The most actionable finding — and it is a question, not a preference

⭐⭐ **`I-6` is the sharpest tension in this document:** the students least
served by system vocabulary are exactly the students Manual mode exists to
serve, ⛔ yet §10A.1's status names are a Product-Owner-fixed vocabulary.

⭐ **Evidence that the two layers are separable** *(measured, ⛔ not assumed)*:
⭐ §23.4a and §30.20 already use **different** display strings
(`PRESENCE UNVERIFIED`, `NOT ATTENDED`) from §10A.1's stored values.

⛔⛔ **This document does not resolve it.** ⭐ It ships the **structure and
tone**; ⛔ the sentences stay ⚪ TBD → `DD3-GAP-001`, `DD3-GAP-002`.

---

## 24. Security & Privacy UX

### 24.1 ⭐ The four-way distinction the UI must preserve

⭐ `PRD-006` §19.1 keeps five concepts separate. ⭐ The design consequence is
that ⛔ **no surface may blur them**:

| Concept | Owner | ⭐ What the UI may say |
|---|---|---|
| **Authentication** | `BC-18` | ⛔ Nothing — already done before the scan |
| **Student identity** | `BC-01` / `BC-10` | ⭐ The student's own name/enrolment |
| **Attendance method** | ⭐ **`BC-03`** | ⭐ *"Recorded by QR / by reception"* |
| **Environment verification** | ⭐ **`BC-03`** | ⭐ *"On the library network"* — ⛔ never *"identity confirmed"* |
| **Attendance record** | ⭐ **`BC-03`** | ⭐ The presence fact |

⭐ `ATT-BR-041` — ⛔ the module **MUST NOT** claim QR = authentication, GPS =
identity, Wi-Fi = identity, OCR = authentication, or Face = a new
authentication framework.

### 24.2 ⛔⛔ The three claims the product never makes

⭐ §10A.8, extended by a fourth in §10A.4a:

| # | ⛔ Never claimed | Why |
|---|---|---|
| 1 | ⛔ *"Same Wi-Fi name means this is the library"* | A network name is trivially reproducible — `ATT-GAP-007` |
| 2 | ⛔ *"Wi-Fi alone proves the student's identity"* | ⛔ `ATT-XC-014` — two students on one network are indistinguishable |
| 3 | ⛔ *"Wi-Fi verification prevents attendance sharing"* | ⛔ `ATT-XC-014` — *"a false security claim"* |
| 4 | ⛔ *"A Wi-Fi exit proves the student physically left"* | ⛔ §10A.4a, §17.4 |

⭐⭐ **And `ATT-BR-042` turns these into a positive copy obligation:** where a
control is bounded, ⭐ *"the bound **MUST** be stated wherever the control is
offered"* — which is why `S-L14` exists (§16.3).

### 24.3 ⭐ No secrets, anywhere

| Rule | Requirement |
|---|---|
| ⛔ No password, OTP, session token, credential, `AccountId`, `PersonId` or `StudentRecordId` in a QR | ⭐ `ATT-XC-012`, verified by `ATT-AC-009` |
| ⛔ No credential/key in any record, evidence object, event payload, audit fact or log line | ⭐ `ATT-FR-123` (`ID-1`) |
| ⛔ No biometric template in evidence | ⭐ `ATT-XC-008` |

⭐ **Design consequence:** a fixed QR renders as a **poster**, ⛔ not as a
secret to be protected — and the surface must not imply it is sensitive
(which would be a false security claim in the other direction).

### 24.4 ⭐⭐ Consent and withdrawal — Face, and why it stays blocked

⭐ `ATT-FR-053`: enrollment **MUST** require **recorded consent before any
biometric capture**.
⭐ `ATT-BR-022`: a student **MUST** be able to withdraw, and ⛔ withdrawal
**MUST NOT** delete their attendance history.

⛔⛔ **`ATT-FR-064` blocks the build outright**, and §12.4a row 7 records why
this is a **conflict, not a gap**: ⭐ `ID-5`/`MP-GBR-04` promise erasure by
**pseudonymisation**, which is ⛔ *"structurally inapplicable"* to a template
that **is** the identifier.

⭐ **Therefore `S-L15` is recorded and ⛔ not designed** (§8.3). ⭐ Designing a
consent flow for data the platform cannot lawfully promise to erase would
manufacture readiness on a **legal** question owned by **Legal Counsel**.

### 24.5 ⭐⭐ Privacy perception — the one gap the requirements leave open

⚠️ **Measured asymmetry:**

| ⭐ Guaranteed by requirement | ⚠️ Disclosed to the student? |
|---|---|
| ⭐ `ATT-AC-218` — ⛔ no SSID, BSSID, MAC or signal strength crosses the boundary | ⛔ **Not required anywhere** |
| ⭐ `ATT-XC-014` — Wi-Fi is not identity | ⛔ **Not required anywhere** |
| ⭐ §10A.2 — device-level observations may exist for audit | ⛔ **Not required anywhere** |
| ⭐ §10A.12 — Location Verification | ⭐⭐ **REQUIRED** — *"the student **MUST** be informed"* |

⭐⭐ **So exactly one privacy disclosure is mandated, and it is the narrowest
one.** ⭐ The design provides `S-S13` for it (§13.7).

⚠️ **Class D/E assessment, recorded ⛔ not acted on:** a student who is told
nothing about Wi-Fi presence may assume **more** monitoring than occurs —
`ATT-AC-218`'s protection is strong but **invisible**. ⭐ An honest framing
would be *"the library network confirms you're here"*, ⛔ never *"we can see
your device"*.

⛔⛔ **But this document does not add a disclosure requirement**, for two
reasons: ⛔ no `ATT-*` requirement authorises one, and ⛔ the **Privacy Owner
role is VACANT** (`SPX-GAP-*`, carried from `DD-0001`/`DD-0002`), so ⛔ no
privacy copy can be ratified. → recorded in §30.2 as non-blocking.

### 24.6 ⭐ Audit visibility — corrections can never be invisible

⭐ `ATT-BR-040` (`MP-GBR-11`): ⛔ *"Attendance **MUST NOT** be silently
manipulable. Corrections exist; **invisible corrections do not**."*

⭐ **Design consequence:** §17.2's two-block history is a **security UX
feature**, ⛔ not a convenience — it is what makes a mis-attributed attendance
investigable.

### 24.7 ⭐ Tenant isolation as a UX rule

| ⭐ Design rule | Requirement |
|---|---|
| ⭐ Out-of-tenant students ⛔ **never appear in staff search** | `ATT-BR-025` |
| ⭐ A cross-tenant QR is rejected with ⛔ **no fallback affordance** | ⛔ `ATT-BR-010` — ⛔ no *"did you mean your library?"* |
| ⭐ A role at library A confers **nothing** at library B | `ATT-FR-121` (`AUTH-2.8`) |
| ⭐ An account with no role sees **no access**, ⛔ not an empty list | `ATT-FR-120` (`AUTH-2.16`) |

---

## 25. Performance / Offline UX

### 25.1 ⛔⛔ No latency figure — the hardest constraint on this section

⭐ `ATT-NFR-003`: this document **MUST NOT** state a latency figure,
throughput number or percentile target — ⭐ *"an invented number becomes a
false acceptance criterion"* — `ATT-GAP-017a` **OPEN** (Product +
Architecture Owner).

| ⛔ Prohibited in any surface | ⭐ Permitted |
|---|---|
| ⛔ *"Usually takes 2 seconds"* | ⭐ An unquantified progress state |
| ⛔ A countdown or percentage | ⭐ *"Checking…"* |
| ⛔ A timeout figure shown to a user | ⭐ A retry affordance |
| ⛔ Any performance promise in copy | ⭐ Actual speed, unadvertised |

### 25.2 ⭐ What performance IS required

| Requirement | ⭐ Design consequence |
|---|---|
| ⭐ `ATT-NFR-002` — correctness under **50+ burst**; ⛔ **MUST NOT** degrade with concurrency | ⭐ `S-L1` is the burst surface: ⭐ one tap, ⛔ no dialog, ⛔ no multi-step |
| ⭐ `ATT-NFR-001` — contention confined to **one student-day** | ⭐ One student's slow result ⛔ never blocks another's (`ATT-FR-028`) |
| ⭐ `ATT-NFR-007` — ⛔ no synchronous dependency on `BC-22`/`BC-24`/`BC-26` | ⭐ Attendance confirms ⛔ **without** waiting for a notification to send |
| ⭐ `ATT-NFR-008` — functional when `BC-04` unavailable | ⭐ §18.6's visible degradation |
| ⭐ `ATT-NFR-009` — functional when `E-03` stale | ⭐ §19.6's advisory flag |

⭐⭐ **`ATT-NFR-007` is a real UX win:** the student's confirmation must ⛔ not
wait on notification dispatch. ⭐ The fact is recorded, the confirmation
appears, and the notification travels separately.

### 25.3 ⭐ Offline behaviour — authorised, and bounded

⭐ `E-24` exists (`BC-03 → BC-30`); `MP-ASM-03` assumes intermittent
connectivity; EA lists *Offline Attendance Capture (V1)*.

| Mode | Offline capture | Source |
|---|---|---|
| 1 Fixed QR | ⭐ Authorised via `E-24` | `ATT-PO-011`…`013` |
| ⛔ **2 Dynamic QR** | ⛔⛔ **UNDEFINED — MUST NOT be promised** | ⛔ `ATT-PO-014`, `ATT-GAP-016a`, `ATT-NFR-012` |
| 3 QR + Wi-Fi | ⭐ Authorised | `ATT-PO-011` |
| 4 QR + GPS | ⭐ Authorised | `ATT-PO-011` |
| 5 Face | ⛔ Blocked anyway | `ATT-FR-064` |
| 6 Manual | ⭐ Authorised | `ATT-PO-011` |

⭐ **Replay rules the design must not contradict:** ⭐ a replayed punch is
**absorbed by idempotency**, ⛔ never applied twice (`ATT-PO-012`); ⛔ it
**MUST NOT** overwrite a correction made while offline (`ATT-PO-013`);
⛔ late arrival **MUST NOT** fabricate a disconnect that was never observed.

⚠️⚠️ **`S-S12`'s copy is ⚪ TBD, and the reason is a real constraint:** ⛔
`ATT-NFR-012` forbids promising offline behaviour *beyond what `E-24`
authorises*, and mode 2 is excluded. ⭐ So a generic *"works offline"* badge
would be **false for at least one mode**. → **`DD3-GAP-005`**, **Product
Owner**.

### 25.4 ⛔⛔ No background-execution promise

⭐ §10A.10 states as **fact**, ⛔ not caveat: *"Android background execution is
**NOT** guaranteed on every device."*

| ⛔ Prohibited | Source |
|---|---|
| ⛔ A **periodic-check interval** in copy or design | ⛔ `D-14` — *"Do not invent the periodic-check interval"* |
| ⛔ Implying **punctual** background updates | ⛔⛔ *"`WorkManager`'s guarantee is EVENTUAL, never PUNCTUAL"* |
| ⛔ A **polling loop** or Wi-Fi scanning | ⛔ *"`WifiManager.startScan()` is throttled… and is not used"* |
| ⛔ A **mandatory foreground service** / persistent notification | ⛔ *"not required"* — `ADR-0028`'s question, ⛔ not this document's |
| ⛔ Any **OS permission** asserted as a fact | ⛔ `ATT-FR-044` is the **only** OS-permission line, and it concerns mode 4 |

⭐⭐ **Design consequence:** the 🟡 `PRESENCE CHECKING` state is a
**read-time composition**, ⛔ never a pushed live update (`ATT-AC-216` —
entering grace publishes **no event at all**). ⭐ So the design must not
promise a card that refreshes itself the instant state changes.

### 25.5 ⭐ Low-end device considerations — methodology, declared as such

| ⭐ Design choice | Rationale | Class |
|---|---|---|
| ⭐ **0 surfaces use 3D** | ⭐ §26.3 — cost on low-end Android with no requirement to justify it | **C + D** |
| ⭐ 2.5D limited to **4** elements | ⭐ §26.2 — elevation and shadow are cheap; ⛔ parallax and depth stacks are not | **C** |
| ⭐ Reuse existing widgets | ⭐ §27.1 — ⛔ no new rendering paths | **C + B** |
| ⭐ Lists paginate rather than load whole histories | ⭐ Methodology `#47`; ⛔ no PRD requirement | **C** |
| ⭐ Static alternative for the one animated state | ⭐ §21.8 | **C** |

⚠️ **Honest note:** ⛔ **no measured device-performance data exists in this
repository**, so ⛔ none of the above is presented as a benchmark.

---

## 26. 2D / 2.5D / 3D Allocation

### 26.1 ⭐ 2D — the default, and the majority

⭐ **All dense, operational, form-bearing and historical surfaces are 2D.**

| Surfaces | Count |
|---|---|
| `S-S7` failure reasons · `S-S9` history · `S-S10` notice · `S-S13` disclosure · `S-S14` unavailable · `S-S12` offline | 6 |
| `S-P1` parent view · `S-P2` disabled state | 2 |
| `S-L1` desk lists · `S-L2` manual form · `S-L5` correction form · `S-L6` history · `S-L7` worklist · `S-L8` config · `S-L8a` Wi-Fi config · `S-L9` QR lifecycle · `S-L11` reads · `S-L14` disclosure | 10 |
| ⭐ **Total 2D** | ⭐ **18** |

⭐ Consistent with `DD-0002`'s allocation, where forms, lists and
administrative operations are 2D.

### 26.2 ⭐ 2.5D — exactly four, each justified

| # | Element | ⭐ Why 2.5D | Requirement anchor |
|---|---|---|---|
| 1 | ⭐⭐ **`AttendanceScanSurface`** (`S-S2`…`S-S5`) | ⭐ The **primary action** of the entire Student App — it must be unmistakably the thing to tap | ⭐ `G-4` speed; `ATT-BR-005` one action |
| 2 | ⭐⭐ **`TwoAxisAttendanceStatusCard`** (`S-S1`) | ⭐ The **status card** a student opens the app to read | ⭐ `ATT-AC-222` |
| 3 | ⭐ **Reception one-tap row** (`S-L1`) | ⭐ An **operational card + primary action** in the burst path | ⭐ `ATT-NFR-002` |
| 4 | ⭐ **Confirmation state** (scan + desk) | ⭐ **Important feedback** — `ATT-BR-011` forbids a silent or weak outcome | ⭐ `ATT-BR-011` |

⛔ **2.5D means elevation, subtle shadow and layered surface only** — ⭐ as
already established by `DD-0001`/`DD-0002`. ⛔ It does not mean parallax,
perspective transforms or depth stacks.

### 26.3 ⛔⛔ 3D — ZERO, and the reasoning is recorded

⭐ **Allocation: 0 surfaces, 0 elements.**

| Candidate considered | ⛔ Verdict |
|---|---|
| A 3D seat-map / hall visualisation | ⛔ **REJECTED** — ⭐ it is `BC-04`'s surface (§18.1), and ⛔ presence is *critical attendance information* which the brief bars from 3D |
| A 3D scan animation | ⛔ **REJECTED** — ⭐ `G-4` speed and I-1 low-end devices; ⛔ decoration on the hot path |
| A 3D presence indicator | ⛔⛔ **REJECTED** — ⛔ **critical information**; ⭐ and `ATT-AC-222`'s two-axis rule needs **legibility**, not depth |

⭐⭐ **Recorded honestly:** `DD-0002` allocated **0** to 3D as well.
⭐ Attendance has **less** justification than Student Management, not more —
its hot path is a 6 a.m. queue on low-end Android. ⛔ **No new visual language
is invented here.**

### 26.4 ⭐ Motion — reused from `DD-0001` §10, ⛔ not re-derived

| Need | ⭐ Source |
|---|---|
| Scan → loading transition | ⭐ `DD-0001` §10 spec |
| Loading → confirmation | ⭐ `DD-0001` §10 spec |
| Failure sheet entry | ⭐ `DD-0001` §10 spec |
| 🟡 `PRESENCE CHECKING` pulse | ⭐ `DD-0001` §10 spec + ⭐ §21.8's **static alternative** |
| List/worklist item transitions | ⭐ `DD-0001` §10 spec |

⛔ **No new motion token is created.** ⛔ And no duration is stated — ⭐ per
methodology `#8`, durations belong to shared motion tokens, which ⛔ `DBT-001`
leaves unratified.

### 26.5 ⚠️ Haptics — noted, ⛔ not specified

⚠️ Methodology `#27` suggests haptic confirmation for important actions. ⭐ The
scan confirmation is a plausible candidate. ⛔ **No requirement exists**, and
⛔ over-use is explicitly a methodology anti-pattern ⇒ ⭐ recorded as
**methodology**, ⛔ not as a design decision.

---

## 27. Components & Design System

### 27.1 ⭐ Existing components reused — 6 of 7

⭐ From `lib/app/shared/widgets/common.dart`:

| Component | ⭐ Reuse in Attendance | Classification |
|---|---|---|
| ⭐ **`PanelCard`** | Section containers; ⭐ degraded-state container (§18.6) | ⭐ **EXISTING — REUSABLE** |
| ⭐ **`Pill`** | Presence/conformance state chips *(⛔ two Pills, never one — §11.3)* | ⭐ **EXISTING — REUSABLE** |
| ⭐ **`EmptyState`** | ⚪ `NOT ATTENDED`; empty worklist; `S-P2` | ⭐ **EXISTING — REUSABLE** |
| ⭐ **`MetricTile`** | `S-L11` operational reads — ⛔ **without any target or bar** (§16.5) | ⭐ **EXISTING — REUSABLE** |
| ⭐ **`SectionHeader`** | Surface sectioning throughout | ⭐ **EXISTING — REUSABLE** |
| ⭐ **`Monogram`** | Student identification on `S-L1`, `S-L2` | ⭐ **EXISTING — REUSABLE** |

### 27.2 ⛔⛔ `MeterBar` — PROHIBITED for Attendance

⭐⭐ **The seventh existing widget is `MeterBar`, and it ⛔ MUST NOT be used
anywhere in this feature.**

| Source | Text |
|---|---|
| ⭐⭐ **`NG-6`** | ⛔ *"Attendance reports, **percentages, streaks**, dashboards, Study Hours totals and weekly/monthly aggregation"* → `BC-26` |
| ⭐⭐ **`ATT-FR-146`** | ⛔ *"**MUST NOT**… become the source for any attendance **percentage, streak or dashboard**"* |
| ⭐ **`PRD-006` L2278** | ⛔ `BC-03` must not be the source of any percentage or streak |
| ⭐ **`ATT-FR-147`** | ⛔ Operational reads **MUST NOT** be presented as certified metrics |

⭐⭐ **This prohibition is now stronger than in `DD-0001`/`DD-0002`, where it
rested on a general concern.** ⭐ Here it rests on the subject PRD's **own
non-goal** — a `MeterBar` on an attendance surface would be a **requirement
violation**, ⛔ not a style disagreement.

### 27.3 ⭐ New components proposed — 5, each justified

| # | Component | ⭐ Why existing widgets are insufficient | Token/DS approval | Status |
|---|---|---|---|---|
| 1 | ⭐⭐ **`TwoAxisAttendanceStatusCard`** | ⭐ `ATT-AC-222` requires **two never-collapsed axes** with independent colour/word. ⛔ A single `Pill` **structurally cannot** express it — and today's `Pill('Inside'/'Away')` is the live violation | ⭐ **REQUIRED** — 2 state colour sets, separator | ⭐ **PROPOSED** |
| 2 | ⭐⭐ **`AttendanceScanSurface`** | ⭐ No scan affordance exists — ⛔ **0** QR/camera dependencies in `pubspec.yaml`, ⛔ **0** scanner widgets in `lib/` | ⭐ **REQUIRED** — 2.5D elevation, viewport framing | ⭐ **PROPOSED** |
| 3 | ⭐⭐ **`FailureReasonSheet`** | ⭐ **19** distinguishable reasons, each with its own next step (`ATT-NFR-005`). ⛔ A `SnackBar` cannot carry a reason **and** an action **and** be announced | ⭐ **REQUIRED** — sheet elevation, alert semantics | ⭐ **PROPOSED** |
| 4 | ⭐ **`AttendanceCorrectionHistory`** | ⭐ `ATT-FR-114` requires **original AND correction** visible; `ATT-INV-011` requires append-only. ⛔ No existing widget shows an immutable block plus a growing log | ⚠️ Probably not — composes `PanelCard` | ⭐ **PROPOSED** |
| 5 | ⭐ **`MissedCheckoutWorklist`** | ⭐ A per-record actionable list where ⛔ **bulk action is prohibited** (§17.3) | ⚠️ Probably not — composes existing list patterns | ⭐ **PROPOSED** |

### 27.4 ⛔ Blocked component — recorded, ⛔ not designed

| Component | Status | Reason |
|---|---|---|
| ⛔⛔ **`OCRReviewQueue`** | ⛔ **BLOCKED — NOT DESIGNED** | ⛔ `ATT-FR-080`; `ATT-GAP-010` + `ATT-GAP-011` OPEN. ⭐ Named so it is not forgotten; ⛔ **no spec, no wireframe, no tokens** |

### 27.5 ⚠️ Token dependency — `DBT-001`, unchanged and unresolved

⭐ `lib/app/shared/theme.dart` provides `LiblColors` (12) and `LiblSpace` (6)
as **implementation reference**, ⛔ not ratified design tokens.

| Need | Status |
|---|---|
| ⭐ 4 state colours *(🟢 present · 🟡 checking · ⚪ not present · 🟠 unverified)* | ⚪ **TBD — `DBT-001`** |
| ⭐ 2 blocked state colours *(🟡 outside window · 🔴 overstay)* | ⚪ **TBD** + ⛔ blocked by `ATT-GAP-002a` |
| Elevation values for 2.5D | ⚪ **TBD — `DBT-001`** |
| Motion durations | ⚪ **TBD — `DBT-001`** |
| Breakpoints | ⚪ **TBD — `DBT-002`** |

⛔⛔ **No token value is invented in this document.** ⭐ The design specifies
**which** semantic colours are needed and **what they must distinguish** —
⛔ never their hex values.

⚠️ **One measured risk for `DBT-001`'s owner:** §23.4a uses 🟡 for **two**
different states (§21.3). ⭐ Whoever ratifies the palette must decide whether
they share one amber or need two — ⛔ and this document does not decide it.

---

## 28. Cross-Feature Consistency

⭐ Checked against `DD-0001`, `DD-0002`, `BC-04`, Authentication/Identity, the
shared widgets and the existing visual language. ⛔ **None of those documents
is modified.** ⭐ Only genuine inconsistencies are reported.

| # | Against | Finding | Verdict |
|---|---|---|---|
| **C-1** | ⭐ **`DD-0002` §4.1** — staff / `TR-4` own-only / `TR-5` denied | ⭐⭐ Attendance differs **legitimately**: `TR-4` has a **write** action here (self-attendance) that Student Management denies, and `TR-5` is **granted** read here but **denied** there (`SM-8.4a` interim deny) | ⭐ **CONSISTENT** — different features, different ratified grants. ⛔ **Not** an inconsistency |
| **C-2** | `DD-0002` §7.2 — 7-state matrix | ⭐ Attendance needs a **larger** model: 26 states on **four** axes | ⭐ **CONSISTENT** — additive, ⛔ not contradictory |
| **C-3** | `DD-0001` §10 — five motion specs | ⭐ Reused verbatim (§26.4) | ⭐ **CONSISTENT** |
| **C-4** | `DD-0002`'s student search pattern | ⭐ Reused by `S-L2` manual entry — ⭐ and required to be, since `ATT-FR-073` forbids `BC-03` keeping its own directory | ⭐ **CONSISTENT** — ⭐ a genuine reuse win |
| **C-5** | `DD-0001`/`DD-0002` depth allocation *(12/2/0 in `DD-0002`)* | ⭐ Attendance: **18 / 4 / 0**. ⛔ Same rule, ⛔ same zero for 3D | ⭐ **CONSISTENT** |
| **C-6** | ⭐ `common.dart` — 7 widgets | ⭐ 6 reused; ⛔⛔ **`MeterBar` excluded** — and here on the subject PRD's **own** `NG-6` | ⭐ **CONSISTENT** — ⭐ and the exclusion now rests on **stronger** authority than in either predecessor |
| **C-7** | ⭐ `DD-0002` §14's `SM-PO-*` presentation rules | ⚠️ Attendance has **no analogue**: `ATT-PO-*` are **ports**, ⛔ **not** protected operations | ⚠️ **DIFFERENT STRUCTURE, ⛔ not an inconsistency** — ⭐ flagged so `ATT-PO` is never misread as `SM-PO` |
| **C-8** | ⭐⭐ `AccessRole` enum *(5 values)* | ⭐ Matches `ATT-FR-003`'s five roles exactly | ⭐ **CONSISTENT** |
| **C-9** | ⛔⛔ `Permission.recordAttendance` grants | ⛔ `student` lacks it; ⭐ §19.2 r7 grants it | ⛔⛔ **GENUINE INCONSISTENCY** — `AIV-05`, §30.4. ⭐ Rank law decides: PRD wins |
| **C-10** | ⭐ `PRD-007` Seat Management | ⭐ `SEAT-FR-041`/`103`/`104`/`105`/`106`/`115`/`116` all **support** the two-dimension design; `ADR-0032` widened `SEAT-FR-103` to 4 states | ⭐ **CONSISTENT** |
| **C-11** | `seat_map_page.dart` binary `isOccupied` | ⚠️ Code lags the widened contract | ⚠️ **`BC-04`'s surface** — ⭐ reported (`AIV-16`), ⛔ not designed here |
| **C-12** | ⭐ `docs/35-design/README.md` §2A catalog | ⚠️ The `attendance/` rows read *"Not written"* and *"NOT YET AUDITED"* — ⭐ now factually stale | ⚠️ **INDEX UPDATE REQUIRED** — §33.3 |
| **C-13** | ⭐ `docs/design/DESIGN_IMPLEMENTATION_TRACEABILITY.md` | ⚠️ `DIT-009` covers `DD-0001`; ⛔ **no attendance row exists** | ⚠️ **TRACEABILITY GAP** — §29.5 |
| **C-14** | ⚠️ `DD-0001` / `DD-0002` boundary sections | ⛔ Neither carries an **APP + ROLE BOUNDARY** section — ⭐ both were written before §2B | ⚠️ ⭐ Per **§2B.6**: ⛔ *"audit, do not rewrite"* — ⛔ **no verdict claimed** for them here, in either direction |
| **C-15** | ⭐ `ADR-0012` §3.4 | ⭐ The nine `app → domain/library` sites are *"deliberately left failing"* | ⭐ **CONSISTENT** — ⭐ and Attendance surfaces will need the same port discipline → `DD3-GAP-006` |

⭐⭐ **Only two genuine inconsistencies exist: `C-9` (an implementation
deviation the rank law already resolves) and `C-12`/`C-13` (index and
traceability records this document's own creation makes stale).** ⭐ Everything
else is either consistent or a legitimate feature-level difference.

---

## 29. Requirement Traceability

### 29.1 ⛔⛔ No test verification is claimed

⭐⭐ **`PRD-006`'s own header records: 0 of 80 tasks and 0 of 222 acceptance
criteria are proven by a test.** ⭐ `ATT-NFR-010` adds that *"a rule that
cannot be checked **MUST** be treated as unmet."*

⛔ **Therefore no row below claims verification.** ⭐ The `Design Status`
column reports **design coverage only**.
⭐ Measured separately: `test/widget_test.dart` contains **1** `testWidgets`
repo-wide ⇒ ⭐ **attendance surface test coverage = 0**.

### 29.2 ⭐ Status vocabulary

| Status | Meaning |
|---|---|
| ⭐ **COVERED** | A surface, flow and state exist in this document and are designable now |
| ⚠️ **PARTIALLY COVERED** | Designed, but one dimension is blocked or ⚪ TBD |
| ⛔ **MISSING INPUT** | Specified by the PRD; ⛔ **no authorised data path exists** |
| ⚠️ **AMBIGUOUS** | The source does not determine an actor, label or promise |
| ⛔ **CONFLICT** | Sources or source-vs-code contradict |
| ⛔⛔ **PROHIBITED TO BUILD** | A requirement forbids implementation |

### 29.3 ⭐⭐ The traceability matrix

| Requirement | UX implication | Surface | Flow / State | App | Role | Perm scope | Evidence | Design Status |
|---|---|---|---|---|---|---|---|---|
| `ATT-FR-010` | 10-step server-validated scan | `S-S2` | `F-1` / axis B r1–2 | 1 | `TR-4` | `self` | §8.2 L589 | ⭐ **COVERED** |
| `ATT-FR-011` | ⛔ No optimistic UI | `S-S2`…`S-S5` | `F-1`…`F-4` | 1 | `TR-4` | `self` | L607 | ⭐ **COVERED** — §13.3 |
| `ATT-FR-012`…`017` | QR lifecycle capability | `S-L9` | `F-15`-adjacent | 2 | ⚪ **TBD** | `tenantWide` | §8.3 | ⚠️ **AMBIGUOUS** — `DD3-GAP-004` |
| `ATT-FR-018` | 7 distinguishable rejections | `S-S7` | `F-6` | 1 | `TR-4` | `self` | §8.4 | ⭐ **COVERED** — §13.5 |
| `ATT-FR-019` | ⭐⭐ Duplicate = success | `S-S1`,`S-S2` | `F-8` / axis B r2 | 1 | `TR-4` | `self` | §8.5 | ⭐ **COVERED** — §19.4 |
| `ATT-BR-010` | ⛔ Cross-tenant, no fallback | `S-S7` | `F-6` / `E-25` | 1 | `TR-4` | `self` | §8.3 | ⭐ **COVERED** — §24.7 |
| `ATT-BR-011` | ⛔ No silent failure | `S-S7` | `F-6` | 1 | `TR-4` | `self` | §8.4 | ⭐ **COVERED** — §19.1 |
| `ATT-BR-012` | ⭐⭐ Owner disclosure at config time | `S-L14` | `F-15` | 2 | `TR-1` | `tenantWide` | §8.5, `ATT-AC-013` | ⭐ **COVERED** — §16.3 |
| `ATT-FR-021`…`030` | Dynamic QR behaviour | `S-S3` | `F-2` | 1 | `TR-4` | `self` | §9.2/9.3 | ⭐ **COVERED** |
| `ATT-FR-026` | ⭐ "expired" ≠ "invalid" | `S-S7` | `F-6` / `E-26` | 1 | `TR-4` | `self` | §9.3 | ⭐ **COVERED** — §19.3 |
| `ATT-BR-013` | Mode independence (1 vs 2) | `S-L8` | `F-15` | 2 | `TR-1` | `tenantWide` | §9.1 | ⭐ **COVERED** |
| `ATT-FR-031`…`037` | Mode 3 compound | `S-S4` | `F-3` | 1 | `TR-4` | `self` | §10.2/10.3 | ⭐ **COVERED** |
| `ATT-FR-033` | ⭐ Wi-Fi config `TR-1`+`TR-2` | `S-L8a` | `F-15` | 2 | `TR-1`,`TR-2` | `tenantWide` | **`D-12`** | ⭐ **COVERED** — §16.1 |
| `ATT-FR-034`/`035` | 2 distinct network reasons | `S-S7` | `F-6` | 1 | `TR-4` | `self` | §10.3 | ⭐ **COVERED** — §13.5 #11/#12 |
| `ATT-FR-036`/`047` | ⛔⛔ No silent downgrade | `S-S4`,`S-S5` | `F-3`,`F-4` | 1 | `TR-4` | `self` | §10.3/§11.3 | ⭐ **COVERED** — §13.6 |
| `ATT-FR-039`/`050` | ⛔ No spoof-resistance claim | `S-L14` | `F-15` | 2 | `TR-1` | `tenantWide` | §10.4/§11.4 | ⭐ **COVERED** — §16.3, §19.7 |
| `ATT-FR-040`…`048` | Mode 4 compound | `S-S5` | `F-4` | 1 | `TR-4` | `self` | §11.2/11.3 | ⭐ **COVERED** |
| `ATT-FR-044` | ⭐⭐ Denial ≠ system error | `S-S7` | `F-6` | 1 | `TR-4` | `self` | §11.3 | ⭐ **COVERED** — §13.5 #14 |
| §10A.1 rows 1,3,4 | 3 evaluable statuses | `S-S1`,`S-L12` | axis A | 1+2 | all | both | §10A.1 | ⚠️ **PARTIALLY COVERED** |
| §10A.1 rows 2,8,9 | 3 shift-relative statuses | `S-S1`,`S-L12` | axis A | 1+2 | all | both | §10A.7/7b | ⛔⛔ **MISSING INPUT** — `ATT-GAP-002a` |
| §10A.1 rows 5,6,7 | 3 unknown-device statuses | `S-L13` | — | 2 | `TR-1`,`TR-2` | `tenantWide` | §10A.3 | ⚠️ **PARTIALLY COVERED** — 7th type |
| §10A.4 | 5-min grace, ⛔ not a timer | `S-S1`,`S-L12` | `E-3`,`E-11`,`E-12` | 1+2 | all | both | §10A.4 | ⭐ **COVERED** — §18.5 |
| §10A.4a | ⭐ Exit precedence, 6 rows | `S-S10` | `E-1`…`E-7` | 1 | `TR-4` | `self` | §10A.4a | ⚠️ **PARTIALLY COVERED** |
| §10A.5 | ⛔⛔ Never fabricate an exit | `S-S10`,`S-L7` | axis D | 1+2 | all | both | §10A.5 | ⭐ **COVERED** — §17.3, §19.5 |
| §10A.12 | ⭐ Location optional, inform | `S-S13` | `F-4` | 1 | `TR-4` | `self` | `D-21` | ⭐ **COVERED** — §13.7 |
| `ATT-FR-051`…`064` | Face mode | `S-S6`,`S-L15` | `F-5` | 1+2 | `TR-4`/staff | both | §12 | ⛔⛔ **PROHIBITED TO BUILD** |
| `ATT-BR-008`/`023` | ⭐⭐ Manual first-class | `S-L2` | `F-11` | 2 | `TR-3`,`TR-2` | `tenantWide` | §7.3/§13 | ⭐ **COVERED** — §14.1 |
| `ATT-FR-065`…`069` | Individual manual entry | `S-L2` | `F-11` | 2 | `TR-3`,`TR-2` | `tenantWide` | §13A | ⭐ **COVERED** — §14.3 |
| `ATT-BR-024` | Method permanent | `S-L2`,`S-L5` | `F-11`,`F-14` | 2 | `TR-3`,`TR-2` | `tenantWide` | §13A | ⭐ **COVERED** — read-only field |
| `ATT-BR-025` | ⛔ Tenant guard on search | `S-L2` | `F-11` | 2 | `TR-3`,`TR-2` | `tenantWide` | §13A | ⭐ **COVERED** — §24.7 |
| `ATT-FR-070`…`079` | OCR workflow | `S-L3`,`S-L4` | `F-12`,`F-13` | 2 | `TR-3`,`TR-2` | `tenantWide` | §13B–13D | ⛔⛔ **PROHIBITED TO BUILD** |
| `ATT-FR-081` | ⭐ 4-row state table | `S-S1`,`S-S8`,`S-L1` | axis B | 1+2 | `TR-4`,`TR-3` | both | §14.1 | ⭐ **COVERED** — §10.2 |
| `ATT-BR-029` | ⛔ r3/r4 unreachable when off | `S-S8`,`S-L1` | `F-7` | 1+2 | `TR-4`,`TR-3` | both | §14.2 | ⭐ **COVERED** — §14.2 rule 2 |
| `ATT-FR-082` | Missed check-out state | `S-L7` | axis D | 2 | `TR-2`,`TR-3` | `tenantWide` | §14.3 | ⭐ **COVERED** — §17.3 |
| `ATT-BR-030`/`031` | ⛔ No auto-complete, ⛔ no retract | `S-L7` | axis D | 2 | `TR-2`,`TR-3` | `tenantWide` | §14.3 | ⭐ **COVERED** — §17.3 |
| `ATT-FR-083` | ⛔ No fabricated event | `S-L7`,`S-L12` | axis D | 2 | staff | `tenantWide` | §14.3 | ⭐ **COVERED** — §17.3, §18.4 |
| `ATT-FR-084`…`087` | Concurrency determinism | all | `E-18`…`E-21` | 1+2 | all | both | §14.4/14.5 | ⭐ **COVERED** — §12.4 |
| `ATT-NFR-011` | ⭐ Timezone-explicit | all | all | 1+2 | all | both | §27 | ⭐ **COVERED** — §19.1 r5 |
| `ATT-FR-101`…`106` | Config behaviour | `S-L8` | `F-15` | 2 | `TR-1` | `tenantWide` | §16.4/16.5 | ⭐ **COVERED** — §16.2 |
| `ATT-FR-106` | ⭐ Zero modes permitted | `S-S14`,`S-L8` | `E-30` | 1+2 | all | both | §16.5 | ⭐ **COVERED** |
| `ATT-FR-110`…`116` | Corrections | `S-L5`,`S-L6` | `F-14` | 2 | `TR-3`,`TR-2` | `tenantWide` | §18 | ⭐ **COVERED** — §17.1/17.2 |
| `ATT-FR-114` | ⭐⭐ Show **both** states | `S-L6` | `F-14` | 2 | authorised | `tenantWide` | §18 | ⭐ **COVERED** — §17.2 |
| `ATT-INV-011`/`ATT-BR-040` | ⛔ Append-only, ⛔ never invisible | `S-L5`,`S-L6` | `F-14` | 2 | `TR-3`,`TR-2` | `tenantWide` | §18 | ⭐ **COVERED** — §24.6 |
| ⚪ Owner's manual/OCR/correction rights | 3 unlisted §19.2 cells | `S-L2`,`S-L5` | `F-11`,`F-14` | 2 | ⚪ **TBD** | `tenantWide` | §19.2 | ⚠️ **AMBIGUOUS** — `DD3-GAP-003` |
| `ATT-FR-004`/`119` | ⭐ Parent read-only | `S-P1` | `F-16` | 1 | `TR-5` | `guardianOf` | §4.1, §19.2 | ⭐ **COVERED** — §15 |
| `ATT-CFG-024` | Parent visibility switch | `S-P2` | `F-16` | 1 | `TR-5` | `guardianOf` | §16.3 | ⭐ **COVERED** — §15.4 |
| `ATT-FR-117`/`118` | ⛔ No RBAC invention | all | all | 1+2 | all | both | §19.2 | ⭐ **COVERED** — §6 |
| `ATT-FR-120`/`121` | ⛔ No role ⇒ no access; ⛔ no inheritance | all | all | 1+2 | all | both | §19.2 | ⭐ **COVERED** — §24.7 |
| `ATT-FR-123`/`ATT-XC-012` | ⛔ No secrets | `S-S2` | `F-1` | 1 | `TR-4` | `self` | §19.4, §8.1 | ⭐ **COVERED** — §24.3 |
| `ATT-BR-041`/`042` | ⛔ No identity/overstated claim | all | all | 1+2 | all | both | §19.1/19.3 | ⭐ **COVERED** — §24.1/24.2 |
| `ATT-FR-145` | 8 operational reads | `S-L11` | — | 2 | `TR-1`,`TR-2` | `tenantWide` | §24 | ⭐ **COVERED** — §16.5 |
| ⛔ `ATT-FR-146`/`147`/`NG-6` | ⛔⛔ No metric, %, streak, dashboard | all | all | 1+2 | all | both | §2.2, §24 | ⭐ **COVERED** — §27.2, §19.7 |
| `ATT-FR-148` + §25 | 19 signals, ⛔ facts only | all | all | 1+2 | all | both | §25 | ⚠️ **PARTIALLY COVERED** — 5 blocked |
| §25's 4 silences | ⭐⭐ Mandated silence | `S-S1`,`S-L12` | `E-3` | 1+2 | all | both | §25 | ⭐ **COVERED** — §20.3 |
| `ATT-NFR-002` | 50+ burst correctness | `S-L1` | `F-10` | 2 | `TR-3` | `tenantWide` | §27 | ⭐ **COVERED** — §14.2 |
| ⛔ `ATT-NFR-003` | ⛔ No latency figure | all | all | 1+2 | all | both | §27 | ⭐ **COVERED** — §25.1 |
| `ATT-NFR-005` | ⭐ Distinguishable reasons | `S-S7` | `F-6` | 1 | `TR-4` | `self` | §27 | ⭐ **COVERED** — §13.5 |
| `ATT-NFR-008`/`009` | ⭐ Degrade / flag not block | `S-L12`,`S-S1` | `E-31`,`E-32` | 1+2 | all | both | §27 | ⭐ **COVERED** — §18.6, §19.6 |
| ⭐ `ATT-NFR-014` | ⭐⭐ Manual accessibility parity | `S-L2` | `F-11` | 2 | `TR-3` | `tenantWide` | §27 | ⭐ **COVERED** — §21.1 |
| `ATT-PO-011`…`013` | Offline replay policy | `S-S12` | `F-9` | 1 | `TR-4` | `self` | §27.1 | ⚠️ **PARTIALLY COVERED** — `DD3-GAP-005` |
| ⛔ `ATT-PO-014` | ⛔⛔ No offline Dynamic QR promise | `S-S12` | `E-33` | 1 | `TR-4` | `self` | §27.1 | ⭐ **COVERED** — §25.3 |
| §23.4a | 6 Seat Card renderings | `S-L12` | axis C | 2 | `TR-1`,`TR-2`,`TR-3` | `tenantWide` | `ADR-0032` | ⚠️ **PARTIALLY COVERED** — 4 of 6 |
| `ATT-AC-214` | ⭐ Manual ⛔ never 🟢 | `S-L12` | axis C | 2 | staff | `tenantWide` | §30.20 | ⭐ **COVERED** — §18.3 |
| `ATT-AC-215` | ⭐⭐ ⛔ Never merge 2 empties | `S-S1`,`S-L12` | axis C | 1+2 | all | both | §30.20 | ⭐ **COVERED** — §12.6, §21.5 |
| `ATT-AC-216`/`217` | ⛔ No 5th event; ⛔ no fake check-out | `S-L12` | axis C | 2 | staff | `tenantWide` | §30.20 | ⭐ **COVERED** — §18.4/18.5 |
| `ATT-AC-218` | ⛔⛔ No raw network datum | `S-L12` | axis C | 2 | staff | `tenantWide` | §30.20 | ⭐ **COVERED** — §24.5 |
| `ATT-AC-219`/`220` | ⛔ No stored copy; ⛔ no fabrication | `S-L12` | axis C | 2 | staff | `tenantWide` | §30.20 | ⭐ **COVERED** — §18.4 |
| `ATT-AC-221` | Tolerance arithmetic | `S-S1` | axis A | 1 | `TR-4` | `self` | §30.20 | ⛔ **MISSING INPUT** — `ATT-GAP-002a` |
| ⭐⭐ `ATT-AC-222` | ⭐⭐⭐ **Two axes, ⛔ never collapsed** | `S-S1`,`S-L12` | §11 | 1+2 | all | both | §30.20 | ⚠️ **PARTIALLY COVERED** — ⭐ structure designed, ⛔ axis 2 blocked |

### 29.4 ⭐ Coverage roll-up

| Design Status | Requirement groups | Note |
|---|---|---|
| ⭐ **COVERED** | **48** | Designable now |
| ⚠️ **PARTIALLY COVERED** | **8** | One dimension blocked or ⚪ TBD |
| ⛔ **MISSING INPUT** | **3** | ⛔ All three are `ATT-GAP-002a` |
| ⚠️ **AMBIGUOUS** | **2** | `DD3-GAP-003`, `DD3-GAP-004` |
| ⛔⛔ **PROHIBITED TO BUILD** | **2** | Face (`ATT-FR-064`), OCR (`ATT-FR-080`) |
| ⛔ **CONFLICT** | **0** | ⭐ *(`ATT-GAP-015` is inherited and moot — §30.5)* |

⭐ **Inventory coverage:** ⭐ 32/32 surfaces · 17/17 flows · 26/26 states ·
34/34 edge cases · 19/19 failure signals · 4/4 mandated silences · 9/9
statuses · 6/6 Seat Card renderings — ⭐ **all enumerated and dispositioned**.

### 29.5 ⚠️ Traceability gaps — recorded, ⛔ not filled

| # | Gap | ⛔ Why not filled here |
|---|---|---|
| **T-1** | ⛔ **No attendance row in `docs/design/DESIGN_IMPLEMENTATION_TRACEABILITY.md`** *(`DIT-009` covers `DD-0001` only)* | ⭐ Adding one is arguably in scope for the index update; ⛔ but `DIT` rows in the existing pattern reference **surface-to-`IMPL`** mappings, and ⛔ **no `IMPL-*` tasks are recorded for attendance surfaces** — so a row would have nothing to point at. → §33.3 |
| **T-2** | ⛔ No `TS-*` covers `BC-03` | ⛔ A `TS` needs an ADR-borne conferral (`ADR-0131`); ⛔ **no `TS-003` is created, implied, authorised, allocated or reserved** |
| **T-3** | ⛔ 0 attendance surface tests | ⭐ Measured: 1 `testWidgets` repo-wide. ⭐ Reported as a fact |

---

## 30. Gap Register

⛔⛔ **EVERY GAP BELOW IS PRESERVED, ⛔ NOT RESOLVED.** ⛔ This document decides
none of them.

### 30.1 ⛔⛔ BLOCKING — 3, each blocking only its named subset

| ID | Gap | ⛔ Blocks | Owner | Evidence |
|---|---|---|---|---|
| ⛔⛔ **`ATT-GAP-002a`** | ⛔ `BC-03` has **no authorised input** carrying a student's booked shift | ⭐ **3 statuses** *(axis A rows 2, 8, 9)* · **2 Seat Card renderings** · the tolerance-window fact · **axis 2 of `ATT-AC-222`** · `ATT-AC-221` | ⭐ **Architecture Owner** — `ADR-0029` ⛔ **`Proposed`** | §10A.7, §10A.7b, §32.1 |
| ⛔⛔ **`ATT-FR-064`** | ⛔ Face **MUST NOT** be implemented until `ATT-GAP-012` **and** `ATT-GAP-014` are answered | ⭐ Mode 5 entirely: `S-S6`, `S-L15`, `F-5` | ⭐ Architecture + Security Platform + **Legal Counsel** | §12.4, §12.4a row 7 |
| ⛔⛔ **`ATT-FR-080`** | ⛔ OCR/Vision **MUST NOT** be implemented until `ATT-GAP-010` **and** `ATT-GAP-011` are answered | ⭐ `S-L3`, `S-L4`, `F-12`, `F-13` | ⭐ Architecture Owner | §13E |

⭐⭐⭐ **CRITICAL DISTINCTION, and it is the basis of §34's verdict: all three
are build blocks on NAMED SUBSETS. ⛔ None blocks this Design Doc.** ⭐ Modes 1,
2, 3, 4 and 6(13A), entry/exit, corrections, configuration, the parent view
and 14 of the 19 failure signals are **fully specified and designable today**
— ⭐ which is exactly the separability `PRD-006` §13E itself endorses.

### 30.2 ⚠️ NON-BLOCKING — 12

| ID | Gap | Owner | ⭐ Design consequence here |
|---|---|---|---|
| `ATT-GAP-003` | Is `BC-26` a consumer of `attendance.*`? | Architecture Owner | ⭐ Reinforces §27.2 — ⛔ no metric surface may be designed |
| `ATT-GAP-004` | Is `BC-13` a consumer of `FraudSignalDetected`? ⭐ *"no authorised path in either direction"* | Architecture Owner | ⛔ No fraud-escalation surface is designed |
| `ATT-GAP-005` | Attendance retention after archival | Legal Counsel + Architecture | ⛔ No retention copy is written |
| `ATT-GAP-006` | Dynamic-QR cryptographic construction | Security Platform | ⛔ `S-S3` specifies behaviour only |
| `ATT-GAP-007` | Network identification / spoof detection | Architecture Owner | ⭐ Forces §16.3's bound statement |
| `ATT-GAP-008` / `008a` | GPS centre ownership; mock-location detection | Library PRD Owner / Architecture | ⭐ Forces the same bound statement |
| `ATT-GAP-009` | Attendance-hardware lifecycle owner — ⭐ *"a genuine V1 hole"* | Architecture Owner | ⛔ No device-management surface is designed |
| `ATT-GAP-016` | Register-image retention *(third-party handwriting)* | Legal Counsel | ⛔ Compounds the OCR block |
| `ATT-GAP-016a` | Offline Dynamic QR undefined | Architecture Owner | ⭐ → `DD3-GAP-005` copy problem |
| `ATT-GAP-017a` | Latency / throughput targets | Product + Architecture | ⭐ Forces §25.1's prohibition |
| `ATT-GAP-018` | *"At least one mode enabled"* unauthorised | Product Owner | ⭐ `S-S14` must handle zero modes (`E-30`) |
| ⚠️ `DBT-001` / `DBT-002` · ⚠️ accessibility standard · ⚠️ `SPX-GAP-*` *(**Privacy Owner VACANT**)* | Tokens, breakpoints, a11y standard, privacy copy | ⭐ Design/Product Owners | ⭐ §21.2, §24.5, §27.5 — ⛔ all left ⚪ TBD |

### 30.3 ⚪ TO BE DECIDED — 6, newly surfaced by the audit and carried here

| ID | Question | Owner | ⭐ What this document does instead |
|---|---|---|---|
| ⚪ **`DD3-GAP-001`** | ⭐ May a Design Doc specify **student-facing labels** for statuses whose stored values `D-20` fixed? | **Product Owner** | ⭐ Specifies **state, structure and tone**; ⛔ leaves the sentence blank — §19.2, §11.6 |
| ⚪ **`DD3-GAP-002`** | ⭐ Is §30.20's vocabulary *(`PRESENCE UNVERIFIED`, `NOT ATTENDED`)* a **second display layer** over §10A.1? | **Product Owner** | ⭐ Records both vocabularies, ⛔ merges neither — §10.3, §19.2 |
| ⚪ **`DD3-GAP-003`** | ⚠️ Does `TR-1` Owner hold **manual entry / OCR verification / corrections**? ⛔ §19.2 names only `reception, manager` | **Product + Architecture Owner** | ⛔ Renders neither an allow nor a deny for `TR-1` — §6.3 |
| ⚪ **`DD3-GAP-004`** | ⚠️ **Which role manages the Fixed-QR lifecycle?** ⛔ §19.2 has no row for it | **Product + Architecture Owner** | ⭐ Specifies `S-L9` structurally; ⛔ assigns no actor — §16.4 |
| ⚪ **`DD3-GAP-005`** | ⚠️ What may a student be **told** about offline capture, given `ATT-NFR-012` caps the promise and mode 2 is excluded? | **Product Owner** | ⭐ `S-S12` exists; ⛔ its copy is blank — §25.3 |
| ⚪ **`DD3-GAP-006`** | ⚠️ Attendance app surfaces need `domain/library/attendance`, which `app` declares under ⭐ **`ports:` not `imports:`** *(manifest L529+)*. ⛔ No port adapter exists; ⭐ 9 violations are *"deliberately left failing"* | **Architecture Owner** | ⭐ Recorded; ⛔ no import path is designed or recommended — §31.4. ⭐ Same class as `DD-0002-GAP-010` |

### 30.4 ⚠️ Implementation deviations — ⛔ NOT gaps, because the rank law decides them

⭐⭐ **`PRD-006` is Rank 3; code is unranked. ⭐ So these are deviations in the
code, ⛔ not undecided questions.** ⛔ This document designs to the **PRD**.

| ID | Deviation | Measured at | ⭐ Correct per PRD |
|---|---|---|---|
| ⚠️⚠️ **`AIV-04`** | ⛔ `enum VerificationMethod { qr, gps, wifi, manual }` — **4 values** | `attendance_day.dart:11` | ⭐ **6 modes** (`ATT-FR-007`). ⛔ 4 values cannot distinguish Fixed from Dynamic QR, and `gps`/`wifi` read as *conditions* — the composition `ATT-BR-006` forbids |
| ⚠️⚠️⚠️ **`AIV-05`** | ⛔⛔ `AccessRole.student` holds **only** `viewStudent` — ⛔ **no `recordAttendance`** | `identity.dart:258` | ⭐⭐ §19.2 r7 grants `student` *"Self attendance (modes 1–5)"* at `self`. ⛔ **In current code a student cannot self-attend at all** |
| ⚠️ **`AIV-07`** | 2-state toggle over a 4-row table; assumes check-out always enabled | `reception_desk.dart:48–51` | ⭐ 4 outcomes (`ATT-FR-081`); ⛔ r3/r4 unreachable when `ATT-CFG-021` off |
| ⚠️ **`AIV-08`** | A QR icon that cannot scan *(decorative prefix)* | `reception_desk.dart:147` | ⭐ A real scan surface, or ⛔ no scan affordance |
| ⚠️⚠️ **`AIV-09`** | ⛔ `Pill('Inside'/'Away')` — collapses both axes **and** merges two empties | `student_dashboard.dart:90` | ⭐⭐ `ATT-AC-222` two axes; ⭐ `ATT-AC-215` ⛔ never merge |
| ⚠️⚠️ **`AIV-10`** | ⛔ Sums `timeInside` across history, labels it *"Days attended"* | `parent_dashboard.dart:43`,`:109` | ⛔⛔ **Aggregation is `BC-26`'s** — `NG-6`, `ATT-FR-146`, `ATT-FR-147` |
| ⚠️ **`AIV-13`** | Correction stores `'actor: reason'`; ⛔ no timestamp, ⛔ no original value, ⛔ no window check | `attendance_day.dart:100` | ⭐ `ATT-FR-114`/`115`/`116` |
| ⚠️ **`AIV-14`** | ⛔ No `missedCheckOut` flag exists | `attendance_day.dart` | ⭐ `ATT-FR-082` |
| ⚠️ **`AIV-16`** | Binary `occupancy.isOccupied` | `seat_map_page.dart:146` | ⭐ `SEAT-FR-103` widened to 4 states — ⚠️ **`BC-04`'s surface** |

⛔⛔ **No code was modified.** ⭐ Routed to **Architecture + Domain Owner**.

### 30.5 ⛔ Inherited conflict — 1

| ID | Conflict | Status |
|---|---|---|
| ⛔ **`ATT-GAP-015`** | Is Face attendance **V1** or **V3**? ⭐ EA v2.1 lists `Face Recognition (V3)` but is ⛔ **Rank 6, descriptive only**; ⛔ **no Rank 1–5 document places Face in V1** either | ⛔ **OPEN** — Product + Architecture Owner. ⭐ *"Currently **moot in effect**"* — `ATT-FR-064` blocks the build regardless |

### 30.6 ⚠️ One defect found in the subject PRD — reported, ⛔ not fixed

| ID | Defect | Disposition |
|---|---|---|
| ⚠️ **`DD3-DEFECT-001`** | ⛔ `PRD-006` **§0.1 (L31)** states the document is *"`DRAFT` and unranked"* and has passed no stage beyond 2 — ⛔ contradicting its own header (FROZEN v1.9, Rank 3, `ADR-0034`) | ⭐ **Stale prose surviving a version bump.** ⭐ The freeze is **conferred** by `ADR-0034` + `DOCUMENTATION_BASELINE.md` §3.3, so ⭐ the header is right and §0.1 is the defect. ⛔ **Not fixed here** — amending a FROZEN Rank 3 PRD is not a Design Doc's act. → **PRD-006 document owner** |

### 30.7 ⛔ What is deliberately NOT recorded as a gap

⭐ Design preferences ⛔ **must not** be laundered into the product gap ledger:

⛔ low-light contrast · ⛔ one-handed reach · ⛔ localisation · ⛔ haptics ·
⛔ touch-target size · ⛔ a "choose your mode" picker · ⛔ live push refresh of
the presence card.

⭐ Each is **class C or E** and belongs in this document's own reasoning
(§21.7, §23.2, §25.4, §26.5) — ⛔ **not** in `ATT-GAP-*` or `DD3-GAP-*`.

---

## 31. Design QA

### 31.1 ⭐⭐ Blocking QA conditions — 14

⛔ A build failing **any** of these does not conform to `PRD-006`.

| # | Condition | Requirement |
|---|---|---|
| 1 | ⭐⭐ Presence and shift-conformance render as **two** never-collapsed axes | ⭐ `ATT-AC-222` |
| 2 | ⭐⭐ ⚪ `NOT ATTENDED` and 🟠 `PRESENCE UNVERIFIED` are **never** merged, visually **or in speech** | ⭐ `ATT-AC-215`, §21.5 |
| 3 | ⭐ A manually recorded attendance renders 🟠, ⛔ **never** 🟢 | ⭐ `ATT-AC-214` |
| 4 | ⭐⭐ **No** surface shows a verification **chain, pipeline or stepper** | ⭐ `ATT-XC-011`, §13.1 |
| 5 | ⭐ **No** attendance requires two modes | ⭐ `ATT-BR-005` |
| 6 | ⭐⭐ A duplicate scan shows the **same confirmation** as a first scan | ⭐ `ATT-FR-019`, §19.4 |
| 7 | ⭐ **No** failure is silent, and ⭐ each of the 19 reasons is distinguishable | ⭐ `ATT-BR-011`, `ATT-NFR-005` |
| 8 | ⭐ *"expired"*≠*"invalid"* · *"Wi-Fi unavailable"*≠*"not approved"* · *"permission denied"*≠generic error | ⭐ `ATT-FR-026`/`034`/`035`/`044` |
| 9 | ⭐ **No** silent downgrade to a weaker mode | ⭐ `ATT-FR-036`/`047` |
| 10 | ⭐⭐ **No** surface presents any mode as spoof-resistant, and ⭐ `S-L14` states the Fixed-QR bound at configuration time | ⭐ `ATT-BR-012`, `ATT-FR-039`/`050`, `ATT-AC-013` |
| 11 | ⭐⭐ **No** platform outcome is framed as fraud, rule violation or the student's fault | ⭐ §10A.4a, §10A.5 |
| 12 | ⭐⭐ **No** percentage, streak, total, dashboard or `MeterBar` appears on any attendance surface | ⭐ `NG-6`, `ATT-FR-146`/`147`, §27.2 |
| 13 | ⭐⭐ The **four mandated silences** are silent | ⭐ §25's non-notification table, §20.3 |
| 14 | ⭐ A correction shows **both** original and correction; ⭐ method is immutable; ⭐ nothing is editable | ⭐ `ATT-FR-112`/`114`, `ATT-INV-011`, `ATT-BR-040` |

### 31.2 ⭐ Non-blocking QA expectations — 8

| # | Expectation | Basis |
|---|---|---|
| 1 | Manual entry is at least as accessible as a scan | ⭐ `ATT-NFR-014` *(ratified — but unmeasurable without `DBT-001`)* |
| 2 | The two 🟡 labels are never truncated | ⭐ §21.3 |
| 3 | 🟡 CHECKING has a static reduced-motion variant | ⭐ §21.8 |
| 4 | Parent write controls are **absent**, ⛔ not disabled | ⭐ `ATT-FR-119`, §6.4 |
| 5 | Out-of-tenant students never appear in search | ⭐ `ATT-BR-025` |
| 6 | Cross-tenant QR offers **no** fallback | ⭐ `ATT-BR-010` |
| 7 | Parent scope disclosure is present | ⚠️ **Class B pattern** — ⛔ no requirement mandates it (§15.5) |
| 8 | No latency figure appears anywhere | ⭐ `ATT-NFR-003` |

### 31.3 ⛔ What QA cannot verify today

| Item | ⛔ Why |
|---|---|
| ⛔ 5 blocked states | ⛔ `ATT-GAP-002a` — ⛔ not evaluable |
| ⛔ Face and OCR surfaces | ⛔ `ATT-FR-064`, `ATT-FR-080` |
| ⛔ Contrast / touch targets / type | ⚪ `DBT-001`, `DBT-002` |
| ⛔ Any of the 222 acceptance criteria | ⛔⛔ **0 are proven by test** — §29.1 |

### 31.4 ⚠️ Engineering handoff — the measured constraint

⭐ **Boundary baseline, measured this session:**
⛔ `FAIL — 9 violation(s) in 1 category(ies)` + `ACKNOWLEDGED DEBT — 28
finding(s) across 12 edge(s)` — ⭐ **unchanged**.

| Finding | Detail |
|---|---|
| ⭐⭐ `app` declares `domain/library` under **`ports:`**, ⛔ **not `imports:`** | ⭐ `tool/module_dependencies.yaml` L529+ ⇒ ⛔ an `app` file importing a domain barrel **is a violation** |
| ⭐ `ADR-0012` §3.4 | ⭐ The nine sites are *"not waived"*, *"deliberately left failing"* |
| ⚠️ Consequence for Attendance | ⭐ The new student surfaces need attendance domain data ⇒ ⛔ **a port adapter is required and does not exist** → ⚪ `DD3-GAP-006` |

⛔⛔ **This document recommends no import path and designs no adapter.**
⭐ Routed to **Architecture Owner**.

---

## 32. Figma Readiness

### 32.1 ⛔⛔ VERDICT: the Figma gate is **NOT OPEN**

⭐⭐ **And it does NOT open merely because `DD-0003` now exists.**

| # | Condition | Status |
|---|---|---|
| 1 | ⭐ Required Design Docs complete | ⚠️ `membership/` ✅ · `student-management/` ✅ · ⭐ `attendance/` ✅ *(this document)* · ⚠️ **`seat-management/` and `fees-finance/` NOT AUDITED** |
| 2 | Required surfaces enumerated | ⭐ **YES** — 31 |
| 3 | Required flows enumerated | ⭐ **YES** — 17 |
| 4 | Required states enumerated | ⚠️ **PARTIAL** — 26 named; ⛔ **5 not evaluable** (`ATT-GAP-002a`) |
| 5 | App / role boundaries | ⭐ **YES** — §4 **PASS** |
| 6 | ⛔ Blocking gaps closed | ⛔⛔ **NO** — 3 open with Architecture / Security / **Legal** |
| 7 | ⛔ Accessibility definition | ⚠️ **PARTIAL** — ⭐ `ATT-NFR-014` ratified; ⛔ the **product-wide standard is unratified** |
| 8 | ⛔ Component / token decisions | ⛔⛔ **NO** — ⚪ `DBT-001`, `DBT-002` owner-gated; ⭐ 5 new components `PROPOSED` |
| 9 | ⛔ Unresolved product decisions | ⛔ **NO** — ⚪ 6 `DD3-GAP-*`; ⛔ `ADR-0021`…`0031` all **`Proposed`** |
| 10 | Traceability | ⚠️ **PARTIAL** — ⛔ no `DIT` attendance row (§29.5 T-1) |

### 32.2 ⛔ The four hard blockers, independent of this document

| # | Blocker | Owner |
|---|---|---|
| 1 | ⚪ **`DBT-001` token values** — ⛔ a prototype cannot render 4 state colours without them | Design Owner |
| 2 | ⚪ **The accessibility standard** — ⛔ unratified | Product/Design Owner |
| 3 | ⛔⛔ **`ATT-GAP-002a`** — ⭐ a Seat Card prototype would have to either show states the system cannot compute, or silently omit 2 renderings `PRD-006` requires. ⛔ **Both are wrong** | Architecture Owner |
| 4 | ⚪ **`DD3-GAP-001`/`002`** — ⛔ a prototype needs **sentences**, and the label authority is undecided | Product Owner |

### 32.3 ⭐ What a prototype COULD cover if the gate opened

⭐ **23 of 32 surfaces** (§8.4), ⭐ 13 of 17 flows, ⭐ 18 of 26 states, and ⭐ the
two labelled substitutions `DD-0001`/`DD-0002` already use *(token values,
reference width)*.

### 32.4 ⭐⭐ When Figma does begin — the boundary obligation

⭐ Per §2B.4 rule 8: ⛔ **no one giant mixed-role prototype.**

| ⭐ Required | ⛔ Prohibited |
|---|---|
| ⭐ **Separate prototype trees**: APP 1 Student · APP 1 Parent · APP 2 Library | ⛔ One file mixing all roles |
| ⭐ APP 3 tree: ⭐⭐ **does not exist** | ⛔ A platform-admin attendance frame |
| ⭐ `S-L8` *(Owner-only)* and `S-L8a` *(Owner+Manager)* as **distinct** frames | ⛔ One config frame with rows greyed by role |
| ⭐ Blocked surfaces **absent** from the prototype | ⛔ Mocking Face or OCR screens |

⛔⛔ **No Figma file, frame, page or link is created, scoped or authorised by
this document.**

---

## 33. Open Questions

### 33.1 ⭐ Owner-gated, ⛔ not this document's

| # | Question | Owner |
|---|---|---|
| 1 | ⛔⛔ `ATT-GAP-002a` — how does `BC-03` obtain a booked shift? | ⭐ Architecture Owner (`ADR-0029`) |
| 2 | ⛔ `ATT-GAP-012`/`014` — biometric ownership and retention | ⭐ Architecture + Security Platform + **Legal Counsel** |
| 3 | ⛔ `ATT-GAP-010`/`011` — `FileRef` path and OCR capability ownership | ⭐ Architecture Owner |
| 4 | ⚪ `DD3-GAP-001`…`006` | ⭐ Product / Architecture Owner — §30.3 |
| 5 | ⚪ `DBT-001`, `DBT-002`, the accessibility standard | ⭐ Design / Product Owner |
| 6 | ⚠️ `SPX-GAP-*` — ⛔ **Privacy Owner VACANT** | ⭐ Product Owner |
| 7 | ⚠️ `DD3-DEFECT-001` — `PRD-006` §0.1's stale *"DRAFT"* prose | ⭐ PRD-006 document owner |
| 8 | ⚠️ `AIV-04`, `AIV-05` and 7 further deviations | ⭐ Architecture + Domain Owner |
| 9 | ⚠️ `DSN-APP-GAP-001` — *"Platform Owner"* vocabulary | ⭐ Product + Architecture Owner *(⭐ measured **irrelevant** to `BC-03` — §3.7)* |
| 10 | ⚠️ §10A.6's ARB question — is verified session duration an operational fact or a `BC-26` metric? | ⭐ **ARB** (`ADR-0026` frames, ⛔ does not decide) |

### 33.2 ⭐ Review triggers — when this document must be revisited

| Trigger | ⭐ Effect on `DD-0003` |
|---|---|
| ⭐ `ADR-0029` decided ⇒ `ATT-GAP-002a` closed | ⭐⭐ **§11's axis 2 gains 4 real renderings**; 3 statuses and 2 Seat Card states become designable; §30.1 shrinks |
| `ATT-GAP-012`+`014` answered | ⭐ `S-S6`, `S-L15`, `F-5` become designable — §24.4 |
| `ATT-GAP-010`+`011` answered | ⭐ `S-L3`, `S-L4`, `F-12`, `F-13` and `OCRReviewQueue` become designable |
| ⭐ The 7th type becomes definable (§7.1a) | ⭐ `S-S11`, `S-L13`, `F-17` and 9 multi-device edge cases become designable |
| `DBT-001` ratified | ⭐ §27.5's ⚪ TBDs close; ⭐ Figma blocker 1 clears |
| ⚪ `DD3-GAP-001`/`002` decided | ⭐ Every ⚪ copy slot can be filled |
| ⭐ `PRD-006` amended | ⭐ Re-audit — ⛔ this document is unranked and yields |

### 33.3 ⚠️ Index updates this document's creation requires

⭐ Per the repository's Design Doc rules
([`../README.md`](../README.md) §2A.2), the catalog must register every
Design Doc. ⭐ Two rows are now factually stale:

| Record | Current text | ⭐ Required |
|---|---|---|
| ⭐ `README.md` §2A catalog | ⛔ Contains no `DD-0003` row | ⭐ A row with **App + Role(s)**, PRD, DD status, Figma status, TS status, readiness |
| ⭐ `README.md` §2A.3 `attendance/` row | ⛔ *"Not written"* | ⭐ **WRITTEN** |
| ⭐ `README.md` §2A.4 roadmap row | ⛔ *"NOT YET AUDITED"* | ⭐ **COMPLETE** |
| ⚠️ `docs/design/DESIGN_IMPLEMENTATION_TRACEABILITY.md` | ⛔ No attendance row | ⚠️ ⛔ **Left alone** — §29.5 T-1: `DIT` rows map surfaces to `IMPL-*`, and ⛔ **no attendance `IMPL-*` tasks exist** to point at |

⛔ **No other file is touched.**

---

## 34. Final Design Readiness Verdict

# ⭐⭐ READY WITH EXPLICIT DESIGN GAPS

### 34.1 ⭐ The verdict, tested against its own criteria

| Test | Result |
|---|---|
| Is the authority real? | ⭐ **YES** — `FROZEN` v1.9, **Rank 3**, `ADR-0034` **`Accepted`**, `BASELINE-2026-08-05-A` |
| Is there a designable surface set? | ⭐⭐ **YES** — 32 surfaces, 17 flows, 26 states, 34 edge cases, 19 signals, 4 silences, 9 statuses, 6 renderings |
| Are the app/role boundaries declared? | ⭐ **YES** — §3's five declarations; §4 **PASS**, ⛔ 0 GAP, ⛔ 0 CONFLICT |
| Are there **zero** blocking gaps? | ⛔ **NO** — 3 exist |
| Do they block the **whole** feature? | ⭐⭐ **NO** — ⭐ they block 3 named subsets; ⭐ **23 of 32 surfaces are designable now** |
| Would waiting be correct? | ⛔ **NO** — ⭐ the blocking owners are Architecture, Security Platform and **Legal Counsel**, ⛔ none of whom waits on a Design Doc. ⭐ `PRD-006` §13E itself endorses shipping the unblocked half |

⛔ **Not `READY`** — ⭐ 3 blocking gaps and 6 ⚪ TBDs are real, and
`ATT-GAP-002a` alone removes 5 states.
⛔ **Not `NOT READY`** — ⭐ that would be **factually false**: 48 requirement
groups are **COVERED**, and this is the most surface-prescriptive PRD in the
repository.

### 34.2 ⭐⭐ Designable NOW — 23 surfaces

| App · Role | Surfaces |
|---|---|
| ⭐ **APP 1 `TR-4`** *(11)* | `S-S1` two-axis status · `S-S2` Fixed QR · `S-S3` Dynamic QR · `S-S4` QR+Wi-Fi · `S-S5` QR+GPS · `S-S7` failure reasons · `S-S8` check-out · `S-S9` history · `S-S10` exit-not-verified · `S-S13` location disclosure · `S-S14` mode unavailable |
| ⭐ **APP 1 `TR-5`** *(2)* | `S-P1` read-only view · `S-P2` visibility-disabled |
| ⭐ **APP 2** *(9)* | `S-L1` reception desk · `S-L2` manual entry · `S-L5` corrections · `S-L6` correction history · `S-L7` missed-check-out worklist · `S-L8` config *(`TR-1`)* · ⭐ `S-L8a` Wi-Fi config *(`TR-1`+`TR-2`)* · `S-L11` operational reads · `S-L14` Owner disclosure |
| ⛔ **APP 3** | ⭐⭐ **0 — by measurement, §3.6** |

### 34.3 ⛔ Blocked — 9 surfaces, each with a named owner

| Surface | ⛔ Blocker | Owner |
|---|---|---|
| ⛔ `S-S6`, `S-L15` | `ATT-FR-064` *(Face)* | Architecture + Security + **Legal** |
| ⛔ `S-L3`, `S-L4` | `ATT-FR-080` *(OCR)* | Architecture Owner |
| ⚠️ `S-S11`, `S-L13` | §7.1a *(7th type not definable)* | Architecture Owner |
| ⚠️ `S-L12` *(2 of 6 renderings)* | `ATT-GAP-002a` | Architecture Owner |
| ⚠️ `S-S12` | ⚪ `DD3-GAP-005` | Product Owner |
| ⚠️ `S-L9` | ⚪ `DD3-GAP-004` | Product + Architecture Owner |
| ⚠️ `S-L10` | ⚠️ Partial — ⛔ no display-surface rules in `PRD-006` | — |

### 34.4 ⭐⭐ The three findings that matter most

1. ⭐⭐⭐ **The student-first brief and frozen `PRD-006` agree six-for-six.**
   Streaks are a **non-goal** (`NG-6`); blame is **forbidden twice**
   (§10A.4a, §10A.5); alarmism is **prohibited** (4 mandated silences);
   over-claiming is **prohibited** (`ATT-BR-042`); raw network data
   **cannot leave the module** (`ATT-AC-218`); no-smartphone students are
   **first-class and accessibility-protected** (`ATT-BR-008` +
   `ATT-NFR-014`). ⭐ **Nothing had to be bent to design a calm, trustworthy
   experience.**

2. ⭐⭐⭐ **Attendance is a strictly two-app feature, and that is measured.**
   `ATT-FR-003` closes the role set at **five tenant roles**; `ATT-FR-118`
   forbids adding one; `AUTH-2.5` bars platform roles from tenant business
   data — and ⭐ **attendance records are tenant business data**. ⭐ So
   **APP 3 = 0 surfaces**, and `DSN-APP-GAP-001` is **irrelevant here**
   rather than inherited.

3. ⚠️⚠️ **The one requirement that forbids the simplest design is
   `ATT-AC-222`.** Presence and shift-conformance may **never** collapse into
   one indicator — ⛔ so a single badge is **prohibited, not merely
   imprecise**. ⚠️ Today's `Pill('Inside'/'Away')` collapses both axes **and**
   merges two empties (`ATT-AC-215`). ⭐ And the second axis is **currently
   not computable** — `ATT-GAP-002a`, `ADR-0029` `Proposed`, **Architecture
   Owner**. ⭐ §11.5 therefore renders axis 2 as an explicit ⚪ *"not
   available"* row rather than ⛔ omitting it or ⛔ substituting branch hours.

### 34.5 ⛔ What this document does not authorise

⛔ Implementation · ⛔ a `TS-*` · ⛔ Figma · ⛔ any code change · ⛔ any PRD/ADR
amendment · ⛔ closing any gap · ⛔ a platform-admin surface · ⛔ Face ·
⛔ OCR · ⛔ the 7th type.

---

## 35. Changelog

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09 | ⭐ Initial issue. 34 sections. ⭐ Written **after** the read-only design-readiness audit of `BC-03`, and ⭐ the **first** Design Doc to carry an **APP + ROLE BOUNDARY** section (§3) and an **App-Boundary QA verdict** (§4) under `../README.md` §2B. ⭐ Records 32 surfaces, 17 flows, 26 states across **4 axes**, 34 edge cases, 19 failure signals, 4 mandated silences, 5 new components, 3 blocking gaps, 12 non-blocking gaps, 6 ⚪ TBDs, 9 implementation deviations, 1 inherited conflict and ⚠️ **1 defect in the subject PRD** (`DD3-DEFECT-001`). ⭐ Verdict **READY WITH EXPLICIT DESIGN GAPS**; ⛔ Figma gate **NOT OPEN**. ⚠️ **Includes one self-caught arithmetic correction, disclosed at §8.4:** a first pass counted **31** surfaces / **15** in APP 2; ⭐ the measured totals are **32 / 16** because ⭐ `S-L8a` is a separate surface, as §16.1 argues |
