<!-- LIBOORA Design Doc | DD-0002 | BC-01 Enrollment (Student Management) -->

> This document is design documentation. It does not amend product requirements,
> architecture decisions, bounded-context ownership, permissions, or backend
> contracts.

# `DD-0002` — Student Management surface design

| Field | Value |
|---|---|
| **Design Doc** | `DD-0002` |
| **Version** | **v0.1a** — ⚠️ v0.1 plus one self-reported factual correction (§23) |
| **Status** | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** ⛔ This document does **not** claim its own status |
| **Rank** | ⛔⛔ **UNRANKED.** Where this disagrees with any ranked document, **the ranked document wins and this Design Doc is the defect** |
| **Bounded context** | **`BC-01` Enrollment** `[CORE]`, Library Management cluster, rank 8 |
| **Subject PRD** | [`PRD-004`](../../30-product/student-management/Student_Management_PRD_v1.md) Student Management — **`FROZEN` v1.2**, baselined by `ADR-0018` |
| **Also covers** | Master PRD §8 **module 3** — Library Member Directory, as `PRD-004` §5's **read composition** (⛔ not a bounded context, `AR-1`) |
| **Owner** | UX Architecture Owner *(role, never a personal name)* |
| **External method** | UI/UX Pro Max skill — `nextlevelbuilder/ui-ux-pro-max-skill` @ **`15de38f`**, MIT. ⚠️ **Reference only, subordinate to every Liboora source** |
| **Predecessor** | [`DD-0001`](../membership/DD-0001-membership-management-surface-design.md) `BC-02` Membership **v0.2** — ⭐ consistency obligations in §18 |
| **Readiness** | ⭐ **READY WITH EXPLICIT DESIGN GAPS** — §3, §20 |
| **Purpose** | Specify the Student Management surfaces precisely enough that a Figma prototype can be built **without inventing UX** |

---

## 1. Scope, authority and method

### 1.1 Why `BC-01` is designable — and the count that matters

⚠️ **`PRD-004` has no UI/UX chapter.** Literal `UI` occurrences: **0**.
Literal `UX`: **0**. On the naive test `DD-0001` §1.1 applied to the other
PRDs, `PRD-004` would read *"not designable"* — and
[`../README.md`](../README.md) §2A.3 currently records exactly that
(*"`student-management/` — **0**"*).

⭐⭐ **That measurement was correct about the section and wrong about the
content.** `PRD-004` §5 *Library Members Directory* is **31 `LMD-*`
requirements** (`LMD-1`…`LMD-31`, plus sub-lettered `LMD-15a`/`15b`/`24a`/
`24b` = **35** identifiers) governing a **screen**: pagination, search,
filters, sorting, member detail composition, status indicators, empty-vs-
unavailable, staleness labelling, bulk caps and export. It is a *display*
specification that never uses the word "UI".

| Surface-affecting evidence in `PRD-004` | Measured |
|---|---|
| `LMD-*` Directory requirements (§5) | ⭐ **35** identifiers |
| Occurrences of `list` | **20** |
| Occurrences of `search` | **16** |
| `filter` · `screen` · `display` · `surface` | 6 · 5 · 4 · 3 |
| `indicator` · `visible` · `sort` · `badge` · `render` | 2 · 3 · 2 · 1 · 1 |
| ⭐ Protected operations × roles matrix (§8.2) | ⭐ **12 × 5**, a **closed list** |
| ⭐ Pre-specified edge cases (§9.2) | ⭐ **16**, each with required behaviour |
| Business rules (§9.1) | **16** |
| `EnrollmentStatus` closed set (§2.2) | **4** values |
| Configurables affecting the screen (§10.3) | **7** `SMCFG-*` |
| ⛔ Proposed gaps carrying **no** authority (§10.6) | ⛔ **11** `SM-GAP-*` |

⭐ **`PRD-004` is, on permissions and edge cases, richer than `PRD-005`**:
`PRD-005` §20 gave 13 surface rows and §21 gave 30 edge cases, but no
role×operation matrix. `PRD-004` §8.2 supplies one, closed, with `TR-5`
Parent's two denials marked *interim*.

⛔ **The other four contexts are not re-opened by this finding.**
[`../README.md`](../README.md) §2A.3's discriminator — *a Design Doc can
only be written where a frozen PRD actually fixes surface requirements* —
is **unchanged**; what changed is the instrument. §2A.3 must be corrected
for `student-management/` only, and §21 records the correction owed.

### 1.2 ⚠️ How the external skill was used — and where it was overruled

The skill was run as a reference corpus, not copied. Consistent with
`DD-0001` §1.2, its **visual system was again not adopted** — that decision
is not re-litigated here. What it contributed this time is different,
because this context is dense-list and form work rather than money flow.

| Skill input | Disposition | Where applied |
|---|---|---|
| `content-jumping` — *"Reserve appropriate space … stable count slot for badges"* (Severity **High**) | ⭐ **ADOPTED** | §8.5, §9.2 `DualStatusRow`; directly serves `LMD-25`'s two badges without reflow |
| `loading-indicators` — *"avoid flashing for near-instant work … preserve layout, focus and accessible busy status"* | ⭐ **ADOPTED** | §7.2's three tiers (carried from `DD-0001` §7.2) |
| `form-error-placement` — inline per-field error + `aria-describedby`, ⛔ not summary-only (**High**) | ⭐ **ADOPTED** | §7.4, S-3/S-4/S-7 |
| `form-labels` / `input-labels` — ⛔ placeholder-only prohibited (**High**) | ⭐ **ADOPTED** — ⚠️ and it **contradicts the existing code** | §7.4; deviation `IDV-004` (§6.2) |
| `disabled-states` — *"Reduce opacity and change cursor"* | ⚠️ **ADOPTED WITH OVERRIDE** | ⛔ Insufficient alone: `SM-6.4`/`LMD-29` require the *reason*. §10.2 rule 4 |
| `confirmation-dialogs` — confirm before irreversible | ⭐ **ADOPTED** | S-9 archive, S-11 bulk |
| `color-only` — ⛔ never convey by colour alone (**High**) | ⭐ **ADOPTED** | §11 check 4; the existing `Pill` usage fails it (`IDV-002`) |
| `state-preservation` — restore scroll, filters, input on back | ⭐ **ADOPTED** | §7.7 interruption/recovery |
| `search-accessible` — top-bar search, recent/suggested queries | ⚠️ **PARTIALLY REJECTED** | Top placement adopted; ⛔ **recent-query history REJECTED** — it would persist a member-name trail on a shared reception device, against `SM-8.15` data minimisation. §14 |
| `large-dataset` — *"For 1000+ points aggregate or sample"* | ⛔ **REJECTED** | `LMD-9`/`LMD-10` mandate **pagination** at `SMCFG-1`/`2`; sampling a member roster would make counts wrong. §13 |
| `table-handling` — horizontal scroll wrapper | ⛔ **REJECTED** | Web-specific; ⛔ horizontal scroll is hostile on a phone. §12 uses stacked rows |
| Its `--design-system` output | ⛔⛔ **REJECTED**, as in `DD-0001` §1.2 | Marketing-conversion system; this is an operational staff tool |

### 1.3 ⛔ What this document does not do

⛔ It creates **no** requirement, permission, `PERM-*`, `SM-*`, `LMD-*`,
event, invariant, edge, port or configurable.
⛔ It does **not** resolve any of the **11** `SM-GAP-*` — including
`SM-GAP-5` (member tags/notes), which `PRD-004` §10.6 names as *"the
clearest violation of 'do not invent requirements'"*. ⛔ **No tag, note,
label or free-text annotation is designed anywhere in this document.**
⛔ It does **not** grant `TR-5` Parent access; `SM-8.4a`'s interim deny is
designed **as** a deny.
⛔ It does **not** ratify `LiblColors`/`LiblSpace` (`DBT-001`), invent
breakpoints (`DBT-002`), or choose an accessibility standard.
⛔ It does **not** modify code, tests, `PRD-004`, any ADR, or `DD-0001`.
⛔ It confers **nothing** toward a `TS-*` (§20.2).

### 1.4 Source authority

| Rank | Source | Used for |
|---|---|---|
| 3 | `PRD-004` **`FROZEN` v1.2** | ⭐ Every surface requirement. **0 invented** |
| 3 | `PRD-003` / `SID-2.7` | §5.4 composition authority; DOB optional (§2.2) |
| 4 | [BC Map](../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) **L209** | ⭐⭐ Dual state machines — the governing design constraint |
| 2 | `ADR-0018` | `PRD-004` baseline admission |
| 2 | `ADR-0011`, `ADR-0013`, `ADR-0016` | Identity triad, typed config, `E-22` |
| 2 | `ADR-0012` **§3.4** | ⭐⭐ The measured implementability blocker (§17.1) |
| 5 | `AR-1`, `AR-2` | Directory is a read composition; Auth owns registration |
| — | [`../../design/`](../../design/README.md) foundation | Visual direction, a11y, QA, debt registers |
| — | [`DD-0001`](../membership/DD-0001-membership-management-surface-design.md) **v0.2** | ⭐ Cross-feature consistency (§18) |
| — | `lib/` measured | Implementation deviations (§6), component inventory (§9) |
| ref | UI/UX Pro Max @ `15de38f` | Interaction/a11y/perf mechanics only |

---

## 2. Indian-student context applied

⛔ **No demographic claim is invented, and none of the below is a
requirement.** Each is a *design response* to a constraint recorded in
Liboora's own foundation or measured in this repository.

⚠️ **This context differs from `DD-0001`'s in one decisive way:** `BC-02`
surfaces are **mostly student-facing money**; `BC-01` surfaces are
**mostly staff-facing records about students**. The psychology therefore
shifts from *the student's anxiety about their own money* to *the
reception desk's speed under queue pressure* **plus** *the student's
dignity when their record is read aloud in front of them*.

| Reality | Recorded basis | Design response |
|---|---|---|
| **Reception desk works under a queue** | `PRD-004` §8.2 grants `TR-3` Reception list + detail + register; `reception_desk.dart` exists | S-1 search is the **first focusable** element; check-in reachable in **one** tap from a row (§10.2) |
| **Low-end Android, constrained devices** | `DESIGN_FOUNDATION.md` §4 — *"Low-end respect"* **CONFIRMED** | 2D-first; ⛔ no blur/parallax/WebGL. ⭐ **This context gets 0 3D assets** (§8.6) |
| **Slow / intermittent network** | `DESIGN_FOUNDATION.md` header — *"low/intermittent network aware"* | ⭐ `LMD-18` + `LMD-21` + `LMD-23` are already network-honesty rules; §7 specifies all three visibly |
| **A record is read out in front of the student** | `SM-PO-10` gates guardian contact + DOB behind `TR-1`/`TR-2`; `SM-8.13` audits the **read** | ⭐⭐ Sensitive fields are **collapsed by default** and require an explicit reveal (§14.2). ⛔ Not "hidden then auto-shown on hover" |
| **Minors enrol, and DOB is often absent** | ⭐ `SM-4.5a`/`SM-4.5b` — minor-status **`Unknown`**, fail-safe to minor | ⭐⭐ S-5 designs `Unknown` as a **first-class, self-explaining state** with a single staff action — ⛔ never an error, ⛔ never a silent default (§7.8) |
| **A student may have left and returned twice** | ⭐ `SM-3.14a`/`SM-3.14b` — multiple `Archived` records; restore targets the newest; count **MUST** be presented | S-4 states the count in words before restore (§7.9) |
| **The same person studies at two libraries** | `SM-3.15`, `SM-BR-1` | ⛔ No cross-tenant hint of any kind is drawn anywhere (§14.1) |
| **Interruption mid-registration** | Mobile reality; `SM-3.5` atomicity, `SM-3.6` idempotency | ⭐ Registration is resumable **as staff-entered draft input**, ⛔ never as a partial record — `SM-3.5` forbids partials (§7.7) |
| **Money anxiety appears here too** | `SM-2.9`/`SM-INV-4` — archive blocked by dues | ⭐ The block is stated as **"what to do"**, not as refusal (§7.4); amount reuses `DD-0001`'s `AmountBlock` (§18) |
| **Duration/date literacy varies** | `DD-0001` §2 — *"show days as stored"*; `SMCFG-3` = **7 days** default | Expiring-soon threshold is shown **as configured**, ⛔ never re-labelled "next week" |
| **English / Hinglish / local-language expansion** | `ACCESSIBILITY.md` §3 — write for translation; languages **`TO BE DECIDED`** | Copy slots sized **+40%**; ⛔ no text in images; ⛔ no concatenated fragments. ⛔ **No language named** |
| **Varying digital literacy** | `DESIGN_FOUNDATION.md` §4 — *"Clarity before decoration"* | One primary action per surface; ⭐ every irreversible action names its consequence **and** its blocker |
| **Motivation without manipulation** | Explicit instruction; §4 *"premium through hierarchy"* | ⛔⛔ **No attendance streaks, no badges, no leaderboards, no "you're falling behind"**. Attendance appears as **fact** only (§9.2 `AttendanceFactRow`) |

⚠️ **Deliberately NOT designed — all 11 `SM-GAP-*` accounted for:**

| `SM-GAP-*` | Subject | ⛔ Why no surface exists |
|---|---|---|
| `SM-GAP-1` | Retention period | ⛔ `ID-5` names no duration; retention messaging would state a legal position |
| `SM-GAP-2` | `enrollmentNumber` format | ⭐ S-6 **displays** the allocated number; ⛔ no format-configuration surface |
| ⭐ `SM-GAP-3` | Whether `Inactive` blocks seat allocation | ⭐⭐ **Directly affects S-8's copy.** `SM-2.14` fixes `Suspended`'s downstream effects; ⛔ `Inactive`'s are **unspecified**, so ⛔ S-8 states effects **only** for `Suspended` and ⛔ says nothing about seating for `Inactive` (§5.2) |
| `SM-GAP-4` | `TR-5` Parent access | ⭐ Designed as the **interim deny** `SM-8.4a` records (§4.1, §14.3) |
| ⛔ `SM-GAP-5` | Member tags / free-text notes | ⛔⛔ **No authoritative source anywhere.** ⛔ 0 surfaces, 0 fields, 0 affordances |
| `SM-GAP-6` | Emergency contact ≠ guardian | ⛔ `SID-2.8` names guardian contact only (§15) |
| `SM-GAP-7` | Member-to-member directory visibility | ⛔ No requirement defines the member-facing field set |
| `SM-GAP-8` | Bulk import validation | ⭐ `SM-3.8` names `Import` as a source; ⛔ no import specification exists |
| ⭐ `SM-GAP-9` | Attendance-percentage definition | ⭐⭐ **Stronger than the gap alone:** `PRD-006` (**`FROZEN` v1.9**, `ADR-0034`) declares percentages a **non-goal** at **`NG-6`** — *"Attendance reports, percentages, streaks, dashboards"* belong to **`BC-26` Analytics** — and **L2278** forbids `BC-03` becoming *"the source for any attendance percentage, streak"*. ⛔⛔ So ⛔ **no percentage, no `MeterBar`** (§9.1, `AttendanceFactRow`) |
| ⭐ `SM-GAP-10` | Whether DOB becomes **mandatory** at `BC-10` | ⭐ `SM-4.5c` forbids this module from requiring it. ⭐⭐ **S-5 is designed to be correct either way** — the three-case branch (§7.8) holds whether `PRD-003` keeps DOB optional or makes it mandatory |
| `SM-GAP-11` | `BC-26` as an `SM-EV-*` consumer | ⛔ A BC Map §8-vs-§7 tension; ⛔ no surface consequence (§6.3) |

⛔ Each would require requirements `PRD-004` does not contain. ⛔ Also **not
designed**: exam-schedule awareness, study-hour nudges, scholarship
messaging, referral mechanics, festival theming.

---

## 3. Readiness audit — `BC-01`

⭐ Verdict: **READY WITH EXPLICIT DESIGN GAPS.** ⛔ **0 BLOCKING** design
gaps. The one blocker in this context is an **implementation** blocker
(§17.1), which `../README.md` §5.1 rules *"is not a precondition"* of a
Design Doc.

| # | Area | Status | Basis |
|---|---|---|---|
| 1 | Product requirements | ⭐ **DONE** | `FROZEN` v1.2; 35 `LMD-*` + 12 `SM-PO-*` + 16 edge cases |
| 2 | Users / roles | ⭐⭐ **DONE** | §8.2 closed **12×5** matrix; ⛔ **0** roles introduced (`SM-XC-6`) |
| 3 | Primary flows | ⭐ **DONE** | 5 flows fixed by §3.2, §2.3, §3.3, §5, §6; specified §5 |
| 4 | IA / navigation | ⭐ **DONE** *(intra-context)* · ⚠️ **PARTIAL** *(app-level)* | §4; ⛔ top-level placement is `DD-0002-GAP-001`, same shape as `DD-0001-GAP-001` |
| 5 | Surface inventory | ⭐ **DONE** | **14** surfaces, §6 |
| 6 | Surface specs | ⭐ **DONE** *(behavioural)* · ⚠️ **PARTIAL** *(pixel)* | §6 + §7; ⛔ exact values blocked on `DBT-001`/`DBT-002` |
| 7 | States | ⭐ **DONE** | §7 — **7** state columns × 14 surfaces |
| 8 | Edge cases | ⭐⭐ **DONE** | §7.10 — **16 of 16** from §9.2 dispositioned |
| 9 | Permissions UX | ⭐⭐ **DONE** | §14.3 — all **12** `SM-PO-*` given a presentation rule |
| 10 | Components | ⭐ **DONE** | §9 — 7 existing + 7 new, ⭐ **5 reused from `DD-0001`** |
| 11 | Typography | ⚠️ **PARTIAL** | §8.3 roles/behaviour; ⛔ family/size values are `DBT-005` |
| 12 | Visual language | ⭐ **DONE** | §8 — bound to the **CONFIRMED** 2.5D direction |
| 13 | Motion | ⭐ **DONE** | §10 — 5 classes reused from `DD-0001` §10.1, ⛔ none added |
| 14 | Accessibility | ⚠️ **PARTIAL** | §11 — 9 checks per surface; ⛔ standard `TO BE DECIDED` (`DD-0002-GAP-003`) |
| 15 | Responsive | ⚠️ **PARTIAL** | §12 — behaviour specified; ⛔ breakpoint values `DBT-002` |
| 16 | Performance | ⭐ **DONE** | §13 |
| 17 | Security / privacy UX | ⭐ **DONE** *(read auditing + sensitive reveal)* · ⚠️ **PARTIAL** *(denial disclosure)* | §14; ⛔ denial wording is `SPX-GAP-001`-class → `DD-0002-GAP-005` |
| 18 | Content UX | ⭐ **DONE** | §15 — repository terminology only |
| 19 | Design QA | ⭐ **DONE** *(expectations)* | §16 — 12 blocking conditions |
| 20 | Engineering handoff | ⭐ **DONE** *(requirements)* · ⛔ **BLOCKED** *(readiness)* | §17 |
| 21 | Traceability | ⭐ **DONE** | §19 — **35 of 35** `LMD-*`, **12 of 12** `SM-PO-*`, **16 of 16** edge cases |

**DONE 14 · PARTIAL 6 · BLOCKED 0 outright · MISSING 0 · NOT APPLICABLE 1**
*(row 21's "NOT APPLICABLE" count is carried in §19's classification, not here)*

⚠️ The 6 `PARTIAL` rows are partial **only** where a product-wide decision
is outstanding — identical in kind to `DD-0001` §3. ⛔ Deciding any of them
here would set product policy from a feature artifact.

---
## 4. Information architecture

### 4.0 ⭐⭐ APP + ROLE BOUNDARY — Declaration 1 (Target App)

⚠️ **Added by the README §2B boundary audit.** This document was written
before README **§2B**, which **L314** binds *"from this point forward"*, and
**§2B.6** requires existing Design Docs to be **audited, not rewritten**. The
audit found Declarations 2–5 already stated and sourced *(§4.1, §14.3, §14.1,
§6.3)*; ⛔ **only Declaration 1's APP vocabulary was absent.** ⭐ **Nothing
below is new design** — every cell restates a fact already carried by this
document or by `PRD-004`, in the vocabulary §2B.3 mandates.

| App | In scope? | Roles | Code home | ⭐ Basis already in this document |
|---|---|---|---|---|
| ⭐ **APP 1 — Student App** | ⭐ **YES** | `TR-4` Student · `TR-5` Parent | `lib/app/student/{student,parent}/` | §4.1 — `TR-4` *"Own record only"* (`SM-PO-2` *"own only"*); ⭐⭐ `TR-5` receives a **designed absence**, specified at §14.3 |
| ⭐ **APP 2 — Library App** | ⭐ **YES** | `TR-1` Owner · `TR-2` Manager · `TR-3` Reception | `lib/app/staff/{owner,manager,reception}/` | §4.1 — entry via the Directory list (S-1), *"Many records, one tenant"*; per-role rules at §14.3 |
| ⛔⛔ **APP 3 — Platform Admin** | ⛔⛔ **NO — 0 surfaces** | ⛔ `PR-1` / `PR-2` — **0 surfaces** | — | §4.1 — *"**Platform Administrator is drawn nowhere**"*; `PRD-004` **`SM-8.4`** (**L857**): a Platform Administrator ⛔ *"**MUST NOT** have access to tenant student data by virtue of the role"* |

⭐ **This is not "all apps"** (§2B.3 Declaration 1): it is a **two-app** set,
each with a reason already sourced above, plus a **measured zero** for APP 3.

⛔⛔ **Library Owner ≠ Platform Owner.** `TR-1` Owner governs **one tenant**
and lives in `lib/app/staff/`; `PR-1`/`PR-2` govern **the platform** and live
in `lib/app/platform_admin/`, which
[`README.md`](../../../lib/app/platform_admin/README.md) **L1** holds open as
*"reserved, deliberately empty."* ⛔ *"Platform Owner"* is **not** cited as an
authoritative role identifier anywhere in this document — README §2B.2's
`DSN-APP-GAP-001` prohibition, measured **0** occurrences.

⭐ **`TR-5` Parent is an APP 1 role, ⛔ not an application** — README §2B.4
rule 5. ⚠️ Its V1 denial is **interim, not architectural**: `PRD-004`
**`SM-8.4a`** (**L880**) denies `SM-PO-2` and `SM-PO-10` and calls it *"an
**interim decision, not a resolution**"*, with **`SM-GAP-4`** left **OPEN**
(`PRD-004` **L1170**). ⛔ This document neither closes that gap nor designs a
Parent surface.

⭐ **Declarations 2–5 are not restated here** — they already exist and remain
the normative statements: **D2** Roles → **§4.1**; **D3** Permission Scope →
**§14.3**, derived *"only from `PRD-004` §8.2's closed matrix"* of **12**
protected operations; **D4** Tenant scope → **§14.1** (`SM-8.1`–`SM-8.3`, a
cross-tenant read *"**impossible**, not merely filtered"*); **D5** Cross-app
dependencies → **§6.3**, including the ⛔ navigate-out to `BC-02`
(`SM-6.8`) → `DD-0001` S-8.

⛔ **This subsection confers nothing.** ⛔ It creates no role, permission,
`SM-PO-*`, surface, scope or app; ⛔ it does not amend `PRD-004`, any ADR or
`AccessRole`; ⛔ it does not authorise implementing APP 3; and ⛔ it changes
**no** existing design decision in this document.

### 4.1 Two audiences, and the asymmetry that shapes everything

| | Staff (`TR-1`/`TR-2`/`TR-3`) | Student (`TR-4`) | Parent (`TR-5`) |
|---|---|---|---|
| Entry | Directory list (S-1) | ⭐ **Own record only** (`SM-PO-2` *"own only"*) | ⛔⛔ **No entry at all** |
| Primary question | *"Find this person and act."* | *"Is my record right?"* | — |
| Scope | Many records, one tenant | Exactly **one** record | — |
| Basis | §8.2 rows 1–12 | §8.2 `own only` cells | ⭐ `SM-8.4a` — **interim deny**, `SM-GAP-4` open |

⭐⭐ **`TR-5` Parent gets a designed *absence*, not a designed screen.**
`SM-8.4a` denies `SM-PO-2` and `SM-PO-10` in V1 and calls it *"an interim
decision, not a resolution"*. §14.3 therefore specifies what Parent sees
**instead** — a statement that the capability is not available in this
version, ⛔ never a permission error implying misuse, and ⛔ never a
"coming soon" promise (which would be a product commitment this document
cannot make).

⛔ **Platform Administrator is drawn nowhere.** `SM-8.4` denies access *"by
virtue of the role"*; elevation is explicit, audited and time-bounded and
belongs to `BC-18`'s surfaces, not this context's.

### 4.2 Hierarchy within the context

```
BC-01 Student Management
├── Directory  (S-1 list → S-2 search/filter → S-3 detail)   ← read composition, PRD-004 §5
├── Register   (S-4 duplicate/restore gate → S-5 minor-status → S-6 confirm)
├── Record ops (S-7 profile edit → S-8 status change → S-9 archive/restore)
├── Guardian   (S-10)
├── Documents  (S-11)
├── Bulk       (S-12 selection → S-13 per-record outcome)
└── History    (S-14, read from BC-24)
```

⭐ **The split is `PRD-004`'s own, not invented.** §5 is a *read
composition* that `LMD-28` forbids from writing; §6 *Student Operations*
holds the writes. Drawing them as one screen would invite exactly the
violation `LMD-28` prohibits, so the Directory **shows** and the record
operations **act**, and every action on a Directory row navigates into an
operation surface that re-checks authorisation.

⛔ **Top-level placement is not decided here** — `DD-0002-GAP-001`. The
existing app happens to place a students tab inside a staff shell
(`staff_app_shell.dart`), but that is an implementation fact, ⛔ not an
approved IA.

### 4.3 The one question each surface answers

| Surface | The single question |
|---|---|
| S-1 Directory list | *"Who is enrolled, and who needs attention?"* |
| S-2 Search & filter | *"Find this specific person."* |
| S-3 Member detail | *"Everything known about this person, and who owns each fact."* |
| S-4 Register — identity gate | *"Is this person already here?"* |
| S-5 Register — minor status | *"Do we need a guardian, and do we even know?"* |
| S-6 Register — confirm | *"Exactly what will be created."* |
| S-7 Profile edit | *"What may I change, and what may I not?"* |
| S-8 Status change | *"What will change, and why am I changing it?"* |
| S-9 Archive / restore | *"Is this reversible, and what blocks it?"* |
| S-10 Guardian | *"Who is responsible for this minor?"* |
| S-11 Documents | *"What is on file?"* |
| S-12 Bulk selection | *"How many, and is that within the cap?"* |
| S-13 Bulk outcome | *"Which ones worked, and which did not?"* |
| S-14 History | *"Who changed what, when, and why?"* |

---

## 5. User flows

⭐ Five flows. Each is fixed by `PRD-004`; ⛔ **no step invented.**

### 5.1 Registration *(§3.2 `SM-3.4`, 7 ordered steps)*

```
Staff opens Register (S-4)
  │
  ├─ identity resolved (AccountId → PersonId via E-13)      SM-3.1 / SM-3.3
  │     └─ ⛔ no account?  →  hand off to Authentication      AR-2, SM-3.1
  │
  ├─ duplicate check (personId ONLY, never name/phone)      SM-3.12
  │     ├─ Active record exists  → ⛔ REJECT, show existing  SM-3.11 / SM-3.13
  │     │                            record; offer "Open"
  │     └─ Archived record(s)    → ⭐ offer RESTORE + state  SM-3.14 / SM-3.14b
  │                                  the COUNT (newest wins)  SM-3.14a
  ├─ minor-status (S-5)                                     §4.2.1 three cases
  │     ├─ DOB present, <18   → guardian MANDATORY          case 1
  │     ├─ DOB present, ≥18   → guardian optional           case 2
  │     └─ ⭐ DOB ABSENT      → Unknown + staff declaration case 3 / SM-4.5a
  │                              ⭐ fail-safe: treat as minor  SM-4.5b
  ├─ validate → allocate enrollmentNumber → persist Active  SM-3.4 steps 4-6
  │     ⭐ atomic; ⛔ a failure consumes NO number           SM-3.5
  └─ confirm (S-6) → SM-EV-1 emitted                        SM-3.4 step 7
        ⛔ a FAILED registration emits NOTHING               SM-3.7
```

⭐⭐ **`SM-3.5`'s atomicity is a UX rule, not only a data rule.** Because a
failure must leave *no partial record*, the design **MUST NOT** present
registration as a multi-screen wizard that saves as it goes. S-4/S-5/S-6
are **stages of one uncommitted input set**; the commit happens once, at
S-6. `TwoStageProgress` (reused from `DD-0001` §9.2) makes that visible.

### 5.2 Status change *(§2.3 transition table, 7 rows)*

```
S-3 detail  →  S-8 status change
  ├─ Active   → Inactive    TR-1/TR-2   ⭐ REASON REQUIRED
  ├─ Active   → Suspended   TR-1/TR-2   ⭐ REASON REQUIRED
  ├─ Inactive → Active      TR-1/TR-2   (no reason)
  ├─ Suspended→ Active      TR-1/TR-2   ⭐ REASON REQUIRED
  └─ ⛔ TR-3 Reception sees NO transition control at all   SM-PO-5 / SM-PO-6
        ⭐ effectiveFrom = now; ⛔ back-dating PROHIBITED    SM-2.11
```

⚠️ **`Suspended` has consequences this module does not own.** `SM-2.14`:
seating refuses new allocation, membership refuses new creation,
attendance **keeps recording and flags**. The design therefore **states
the downstream effect in words** on S-8 before confirming — ⛔ but attributes
it to the owning context and ⛔ never renders it as this module's
enforcement.

### 5.3 Archive and restore *(§2.3 rows 6–7, `TR-1` only)*

```
S-9  ├─ dues check via E-09                                  SM-2.9 / SM-INV-4
     │    └─ outstanding > 0 → ⛔ BLOCKED, and the surface
     │         states the amount + the unblocking action      §7.4
     ├─ Archive = SOFT state change; ⛔ history NOT deleted    SM-2.15
     ├─ Archived → Active is the ONLY exit                    SM-2.10
     └─ ⛔ Archived records absent from the default list       LMD-27
          ⭐ reachable ONLY via an explicit archived filter,
            available to TR-1 and TR-2                        LMD-27
```

⛔ **Legally compelled erasure is not designed here.** `SM-2.16` routes it
to `ID-5` and forbids this module from implementing a deletion pipeline;
drawing a "delete permanently" control would contradict `SM-BR-7`.

### 5.4 Directory read composition *(§5.3 `LMD-19`…`LMD-24b`)*

```
S-3 member detail composes SEVEN field groups, each under the
caller's OWN authorisation (LMD-20):

  identity core      BC-10  E-13   declared edge   STRONG
  enrollment record  BC-01  ——     owned           STRONG
  membership         BC-02  ——     SID-2.7 compose EVENTUAL ⚠ as-of label
  seat               BC-04  ——     SID-2.7 compose EVENTUAL ⚠ as-of label
  attendance summary BC-03  ——     SID-2.7 compose EVENTUAL ⚠ as-of label
  fee status         BC-05  ——     SID-2.7 compose EVENTUAL ⚠ as-of label
  documents          BC-29  E-22   declared edge   STRONG

  ⭐ Any ONE contributor unavailable → that SECTION renders
    unavailable; ⛔ the rest of the screen MUST still render.   LMD-21
  ⛔ A stale value MUST be labelled as-of and MUST NOT be
    presented as authoritative.                                LMD-23
```

⭐⭐ **This is the single most design-relevant rule in `PRD-004`**, and it
is why S-3 is specified as **seven independently-degrading sections**
rather than one card. §7.6 gives the per-section state model.

### 5.5 Bulk operation *(§5.6 `LMD-30`, `SM-BR-14`)*

```
S-12 selection  →  cap check at SMCFG-4 (default 100)
   ⭐ operations limited to STATUS CHANGE and EXPORT only        LMD-30
   ⛔ nothing else may be bulk — no bulk archive, no bulk delete
      │
S-13 per-record outcome
   ⭐ per-record results REQUIRED                                LMD-30
   ⛔ a partial failure MUST NOT roll back succeeded records
   ⛔⛔ and MUST NOT be reported as success                       SM-BR-14
```

⭐ **Export is `TR-1`-only** (`SM-PO-11`), audited (`SM-8.17`), row-capped
at `SMCFG-7` (1000) and field-minimised. The design shows the row count
and the field set **before** export, because `LMD-31` makes export subject
to per-field authorisation.

---

## 6. Existing UI + dependency audit

### 6.1 What already exists

⭐ Measured: **`lib/app/staff/shared/students_page.dart`, 487 lines** — a
roster list plus a five-context detail sheet. ⭐⭐ **This is the first
Liboora Design Doc whose subject already has a substantial implementation**
(`DD-0001`'s `BC-02` had only incidental renders), so this section carries
real weight.

⛔ **Citing it is not approving it.** It was built with **no design
artifact** — the same condition `DD-0001-GAP-009` records.

### 6.2 Classified differences — measured, not impressions

| ID | Observation | `PRD-004` rule | Class |
|---|---|---|---|
| `IDV-001` | Detail sheet composes identity + membership + seat + attendance + fee in **one sheet**, each under its own `SectionHeader` labelled with its BC | ⭐ `LMD-19` requires exactly this composition | ⭐ **MATCH** |
| `IDV-002` | Status shown as **conditional `Pill`s** — `Inside`/`Away`, `No active plan`, `₹X due` | ⛔⛔ `LMD-25` requires `EnrollmentStatus` **and** `MembershipStatus` as **two independent indicators**; `EnrollmentStatus` is ⛔ **never rendered at all**, and *"No active plan"* is a membership-derived label standing in for both | ⛔⛔ **IMPLEMENTATION DEVIATION** — high |
| `IDV-003` | `_kv('Status', validity.isValid ? 'Active' : 'Not active')` under *Membership* | ⛔ `SM-2.7` — `Active` is an **`EnrollmentStatus`** word. Using it for membership validity collapses the two vocabularies BC Map **L209** separates | ⛔ **IMPLEMENTATION DEVIATION** — high |
| `IDV-004` | Search field is **placeholder-only** (`hintText: 'Search name, phone or enrolment no.'`), no visible label | Skill `form-labels` **High**; `ACCESSIBILITY.md` §2 | ⚠️ **DESIGN GAP** *(a11y; not a `PRD-004` violation)* |
| `IDV-005` | Filters are `All / Inside / Dues / Expiring` | ⛔ `LMD-15` fixes a **closed** filter set: `EnrollmentStatus`, membership status, expiry window, shift, seat assigned/unassigned, fee status, registration date range, guardian-required. ⛔ `Inside` is **attendance presence** — ⛔ **not in `LMD-15`**; ⛔ `EnrollmentStatus` and `archived` filters are **absent** (`LMD-27`) | ⛔ **IMPLEMENTATION DEVIATION** |
| `IDV-006` | Filtering and search run **client-side in the widget** over `s.students` | ⛔⛔ `LMD-8` tenant scope **server-side before any filter**; ⛔ `LMD-12` search **MUST** be served by `BC-23` via `E-21`; ⛔ `LMD-9` list **MUST** be paginated | ⛔⛔ **IMPLEMENTATION DEVIATION** — highest |
| `IDV-007` | ⛔ **No pagination**; the full list renders | ⛔ `LMD-9` — *"An unbounded list **MUST NOT** be returned"*; `LMD-10` `SMCFG-1`/`2` | ⛔ **IMPLEMENTATION DEVIATION** |
| `IDV-008` | Empty state is a single `EmptyState` — *"No students match"* | ⛔ `LMD-18` — an **empty result MUST be distinguishable from an unavailable projection** | ⛔ **IMPLEMENTATION DEVIATION** |
| `IDV-009` | ⛔ **No as-of labelling anywhere**, though membership/seat/attendance/fee are all eventually-consistent compositions | ⛔ `LMD-23`, `LMD-15a` *"**MUST** be labelled with the projection's as-of time"* | ⛔ **IMPLEMENTATION DEVIATION** |
| `IDV-010` | A `Collect payment` dialog offers `PaymentMode.values` incl. **UPI** and writes via `s.collect(...)` | ⛔⛔ `LMD-28` — *"The Directory **MUST NOT** perform any write itself."* ⚠️ Also contradicts `DD-0001` §2 / `ADR-0130` (**V1 cash only**) | ⛔⛔ **IMPLEMENTATION DEVIATION** — highest |
| `IDV-011` | `Check in` / `Check out` write attendance from this surface | ⛔ `LMD-28` again; `BC-03` owns attendance | ⛔ **IMPLEMENTATION DEVIATION** |
| `IDV-012` | `StudentRecord.dateOfBirth` is **non-nullable `required`**, and `_assertInvariants()` throws when `isMinorOn(enrolledOn) && guardian == null` | ⛔⛔ `SM-4.5a` — DOB is **optional at `BC-10`**; the module **MUST NOT** infer an age and **MUST** record minor-status **`Unknown`**. A non-nullable DOB makes case 3 **unrepresentable** | ⛔⛔ **REQUIREMENT CONFLICT** — domain model vs frozen PRD |
| `IDV-013` | `StudentRecord` stores `fullName`, `phone`, `email`, `dateOfBirth` locally | ⛔⛔ `SM-4.2` — Full Name, DOB, Email are **`BC-10`-owned** and read through `E-13`; this module **MUST NOT** store them | ⛔⛔ **REQUIREMENT CONFLICT** |
| `IDV-014` | ⛔ `students_page.dart:13` and `:14` import `domain/library` barrels directly | ⛔⛔ `app` declares `domain/library` under **`ports:`** (manifest **L534**), ⛔ not `imports:` — **2 of the 9** boundary violations | ⛔⛔ **IMPLEMENTATION DEVIATION** — architectural |
| `IDV-015` | ⛔ **0** surface tests for this context (**1** `testWidgets` repo-wide, in `test/widget_test.dart`) | `DESIGN_QA.md`; §16 | ⚠️ **DESIGN GAP** *(QA coverage)* |

**MATCH 1 · IMPLEMENTATION DEVIATION 10 · REQUIREMENT CONFLICT 2 ·
DESIGN GAP 2 · UNKNOWN 0**

⛔⛔ **This document changes none of it.** `IDV-012` and `IDV-013` are
**`REQUIREMENT CONFLICT`** — a frozen Rank-3 PRD versus shipped code — and
resolving either is an **Architecture/Domain Owner** act requiring its own
decision, ⛔ **not a design edit and not a code edit made here**. They are
escalated as `DD-0002-GAP-011` and `DD-0002-GAP-012`.

⚠️ **The honest reading of this table:** the existing screen is a
*demonstration of context boundaries* (its own doc-comment says so) that
predates `PRD-004`'s freeze. ⛔ It is **not** an implementation of `PRD-004`
§5, and this design should not be judged against it — nor it against this.

### 6.3 Confirmed dependencies — and their UX consequence

⭐ Only edges/compositions `PRD-004` §5.4 and §7.1 actually declare.

| Context | Mechanism | Consistency | ⭐ UX/navigation consequence |
|---|---|---|---|
| ⭐ **`BC-02` Membership** | `SID-2.7` composition *(read)* + `E-01` *(events)* | **Eventual** | ⭐⭐ **Two badges, never merged** (`LMD-3`/`LMD-25`); expiry from the `BC-02` projection only (`LMD-16`); ⛔ renewal **navigates out** to `BC-02` (`SM-6.8`) → `DD-0001` S-8. **As-of label required** |
| **`BC-04` Seating** | `SID-2.7` composition | **Eventual** | S-3 seat section; ⛔ no seat action here. `Suspended` ⇒ `BC-04` refuses new allocation (`SM-2.14`) — stated, ⛔ not enforced |
| **`BC-03` Attendance** | `SID-2.7` composition | **Eventual** | ⭐ Attendance as **fact only** (§2); ⛔⛔ **no percentage is drawn** — `SM-GAP-9` leaves the formula unowned **and** `PRD-006` **`NG-6`** makes percentages a **non-goal** owned by `BC-26` (§9.1). ⚠️ `PRD-006` is **`FROZEN` v1.9**, so ⛔ this is a **prohibition**, not an absence |
| **`BC-05` Fee** | `SID-2.7` composition + `E-09` *(dues assertion)* | **Eventual** *(read)* / authoritative *(archive gate)* | ⭐ Blocks archive (`SM-2.9`); ⛔ **no collection control** on this surface (`LMD-28`, vs `IDV-010`) |
| **`BC-10` Person Identity** | `E-13` **declared edge**, ACL | **Strong, read-time** | ⭐ Name/DOB/gender/global photo are **read-only here**; an edit attempt **MUST** be refused *with a pointer to `BC-10`* (`SM-6.4`) — ⛔ never silently ignored (§7.4) |
| **`BC-18` Identity & Access** | `E-11`; authorisation | Request-time | ⭐ **Every** control's visibility and enablement is a `BC-18` decision (`SM-8.6`); ⛔ this module evaluates none |
| **`BC-23` Search** | `E-21` | Index-lagged | ⭐ Search is **`BC-23`'s**, permission-aware (`LMD-13`); ⛔ **MUST NOT** leak an unauthorised field via ranking or **highlighting** (`LMD-14`) — §14.4 |
| **`BC-29` File & Media** | `E-22` **declared edge** | **Strong, read-time** | S-11 documents; ⭐ a `BC-29` outage degrades **documents only** (`SM-4.12`) |
| **`BC-24` Audit** | `E-20` | Append-only | ⭐ S-14 history is **read from `BC-24`** (`SM-6.6`); ⛔ no parallel store |
| **`BC-25` Configuration** | `E-19` typed accessor | — | ⭐ All **7** `SMCFG-*` incl. `LCFG-5` gating (`LMD-6`); ⛔ no raw string lookup |

⛔ **Forbidden by §7.3 and therefore absent from every surface:** any
direct `BC-01` → `BC-26` analytics link (`SM-GAP-11` — BC Map §8 names it,
§7 declares no edge, and **that tension is the architecture owner's**).

---
## 7. Surface design and states

### 7.1 Surface inventory — 14 surfaces, every one traced

⭐ Every row cites its `PRD-004` source. ⛔ **0 requirements invented.**

| # | Surface | `PRD-004` source | Design | Depth |
|---|---|---|---|---|
| **S-1** | Directory list | `LMD-1`, `LMD-8`–`LMD-11`, `LMD-27` | 2D dense rows, single column, **paginated** at `SMCFG-1`. ⛔ `Archived` absent by default. Highest information density in the context | 2D |
| **S-2** | Search & filter | `LMD-12`–`LMD-17`, `LMD-15a`/`b` | Search field **top, first focus**. Filters as a sheet, ⭐ **grouped into `Authoritative` vs `Best-effort`** because `LMD-15a` makes the distinction normative. Sort exposes its **tie-breaker** (`LMD-17`) | 2D |
| **S-3** | Member detail | `LMD-19`–`LMD-24b` | ⭐⭐ **Seven independently-degrading sections**, each naming its owning context. 2.5D header card + 2D sections | 2.5D + 2D |
| **S-4** | Register — identity gate | `SM-3.1`–`SM-3.3`, `SM-3.11`–`SM-3.14b` | 2D. Duplicate ⇒ ⛔ reject + **"Open existing"** (`SM-3.13`); archived ⇒ ⭐ restore + **state the count** (`SM-3.14b`) | 2D |
| **S-5** | Register — minor status | ⭐ `SM-4.4`, `SM-4.5`–`SM-4.5c`, §4.2.1 | ⭐⭐ **Three explicit cases**, never a silent branch. `Unknown` ⇒ staff **age declaration**, fail-safe to minor (§7.8) | 2D |
| **S-6** | Register — confirm | `SM-3.4`–`SM-3.7` | 2.5D review card: exactly what will be created. ⭐ One commit point. ⛔ No number consumed on failure | 2.5D |
| **S-7** | Profile edit | `SM-4.1`–`SM-4.3`, `SM-6.2`, `SM-6.4` | 2D form. ⭐⭐ `BC-10`-owned fields rendered **read-only with a pointer to `BC-10`**, disclosed **at the field, pre-submit** | 2D |
| **S-8** | Status change | `SM-2.5`–`SM-2.13`, `SM-PO-5`/`6` | 2D. ⭐ Reason **required** on 3 of 4 transitions; downstream effects stated in words. ⛔ No back-dating control exists | 2D |
| **S-9** | Archive / restore | `SM-2.9`, `SM-2.10`, `SM-2.15`, `SM-PO-7`/`8` | 2D + confirm. ⭐ Dues block states amount **and** the unblocking action. ⛔ "Delete" is absent by design | 2D |
| **S-10** | Guardian | `SM-4.4`–`SM-4.8` | 2D form. ⭐ Mandatory-vs-optional is driven by S-5's case, ⛔ never by a free toggle. ⛔ No consent record (`SM-4.8` — `BC-18` owns it) | 2D |
| **S-11** | Documents | `SM-4.9`–`SM-4.12`, `SMCFG-6` | 2D list, cap **10** shown. ⭐ Per-request authorisation (`SM-4.11`); `BC-29` outage degrades **this section only** | 2D |
| **S-12** | Bulk selection | `LMD-30`, `SMCFG-4` | 2D. ⭐ Only **status change** and **export**. Count vs cap always visible; ⭐ **stable count slot** (skill `content-jumping`) | 2D |
| **S-13** | Bulk outcome | ⭐ `LMD-30`, `SM-BR-14` | 2D per-record result list. ⛔⛔ **Never** summarised as success when any record failed | 2D |
| **S-14** | History | `SM-6.5`, `SM-6.6`, `SM-8.11` | 2D chronological list: actor, role, timestamp, reason. ⭐ Read from `BC-24`; ⛔ append-only, no edit affordance | 2D |

⭐ **14 surfaces; ⛔ 0 beyond `PRD-004`.** ⛔ **No surface exists for:**
member tags/notes (`SM-GAP-5`), bulk import (`SM-GAP-8`), retention
settings (`SM-GAP-1`), member-to-member directory (`SM-GAP-7`),
`enrollmentNumber` format configuration (`SM-GAP-2`), or a Parent portal
(`SM-GAP-4`).

### 7.2 State matrix — 7 states × 14 surfaces

⚠️ **Seven columns, not six.** `DD-0001` §7.1 used six; `PRD-004` forces a
seventh — ⭐ **`Unavailable`**, which `LMD-18` requires to be
*distinguishable from* `Empty`, and `LMD-21` requires to be **sectional**
rather than whole-screen.

| Surface | Loading | Empty | **Unavailable** | Error | Success | Permission | Stale/offline |
|---|---|---|---|---|---|---|---|
| S-1 list | skeleton ×5 | ⭐ two distinct | ⭐ **per-list banner + retry** | typed + retry | — | ⛔ `LCFG-5` off ⇒ suppressed | as-of banner |
| S-2 search/filter | inline spinner in field | *"no match"* ≠ *"no data"* | ⭐ **`BC-23` down ⇒ search disabled, list still browsable** | typed | — | filter set narrows by role | ⚠ index-lag notice |
| S-3 detail | ⭐ **per-section skeletons** | section-level empty | ⭐⭐ **per-section**, 7 independent | per-section typed | — | ⭐ sensitive sections withheld | ⭐ per-section as-of |
| S-4 identity gate | resolving spinner | n/a | `E-13`/`E-11` down ⇒ ⛔ **block registration** | ⭐ duplicate = **not** an error, it is an outcome | — | `SM-PO-3` | ⛔ block |
| S-5 minor status | DOB fetch | n/a | ⭐ DOB unreadable ⇒ **`Unknown` path**, not failure | inline | — | staff-only declaration | ⛔ block |
| S-6 confirm | committing | n/a | n/a | ⭐ typed, field-named | ⭐ proportionate: record + number | `SM-PO-3` | ⛔ block submit |
| S-7 profile edit | field skeletons | n/a | `BC-10` down ⇒ ⭐ those fields unavailable, local fields still editable | inline + summary | quiet confirm | ⭐ field-level (`SM-6.2`) | ⛔ block submit |
| S-8 status change | — | n/a | `BC-05`/`BC-02` down ⇒ state so | inline | confirm + new status | ⛔ hidden for `TR-3` | ⛔ block submit |
| S-9 archive/restore | dues check | n/a | ⭐ dues **unknown** ⇒ ⛔⛔ **MUST NOT** archive (`SID-4.56`) | ⭐ dues block ≠ error | confirm, reversible-path named | ⛔ `TR-1` only | ⛔ block |
| S-10 guardian | — | *"no guardian on file"* | n/a | inline | quiet confirm | `SM-PO-4` | ⛔ block submit |
| S-11 documents | thumb skeletons | *"nothing on file"* | ⭐ `BC-29` down ⇒ **section only** (`SM-4.12`) | per-document | attach confirm | ⭐ `TR-3` = **view only** | list stale ok |
| S-12 bulk select | — | *"none selected"* | n/a | ⭐ cap exceeded = **clamp notice**, not rejection | — | `SM-PO-12` | ⛔ block |
| S-13 bulk outcome | ⭐ **progressive per-record** | n/a | n/a | ⭐⭐ per-record, partial ≠ success | ⭐ only if **all** succeeded | — | n/a |
| S-14 history | skeleton ×3 | *"no changes recorded"* | `BC-24` down ⇒ ⭐ section unavailable | typed | — | ⭐ sensitive reads visible per role | as-of |

### 7.3 Empty vs Unavailable — the distinction `LMD-18` mandates

⭐⭐ **Three outcomes, three different screens.** Collapsing any two is a
`LMD-18` violation:

| Outcome | What the user must conclude | Design |
|---|---|---|
| **Empty — no data exists** | *"Nobody is enrolled yet."* | `EmptyState` + the register action. ⭐ Only on an **unfiltered** list |
| **Empty — no match** | *"My filter is too narrow."* | ⭐ Distinct copy + **"clear filters"**. ⛔ **MUST NOT** offer "register" here — the person may already exist |
| ⭐ **Unavailable** | *"The system could not answer."* | ⭐⭐ **Retry**, and ⛔ **MUST NOT** say "no students" — that would assert a fact the system does not know (`SID-4.56`) |

### 7.4 Error — two-layer, plus the three `PRD-004` non-errors

Carried from `DD-0001` §7.4: field-level message **and** a summary;
typed reason, ⛔ never *"Something went wrong"*, ⛔ never an internal
identifier. ⭐ `PRD-004` adds three outcomes that **must not be styled as
errors**:

| Outcome | Rule | Presentation |
|---|---|---|
| ⭐ **Duplicate found** | `SM-3.13` — return the existing id *"so staff can open the record rather than retry"* | ⭐⭐ A **successful finding**: the existing person, with **"Open record"** as primary. ⛔ Not red, ⛔ not a failure |
| ⭐ **Archived record exists** | `SM-3.14`, `SM-3.14b` | Offer **restore**; ⭐ state the count of archived records plainly |
| ⭐ **Archive blocked by dues** | `SM-2.9` | ⭐ States the **amount** and the next action. ⛔ Not *"cannot archive"* alone |
| ⭐ **`BC-10` field edit refused** | `SM-6.4` — *"rejected with a pointer to `BC-10``, not silently ignored"* | ⭐⭐ Disclosed **at the field before submit**, naming where the field is owned. ⛔ A disabled input with no reason is **non-compliant** |

### 7.5 Loading — three tiers *(reused verbatim from `DD-0001` §7.2)*

⛔ No new timing threshold is invented, and ⛔ none is stated numerically —
the skill's own `loading-indicators` rule rejects *"one timing threshold
for every operation"*. Tier by **expected wait**: near-instant ⇒ no
indicator; short ⇒ skeleton reserving **exact** height; long ⇒ explained
progress with accessible busy status.

### 7.6 Sectional degradation — S-3's seven-section contract

⭐⭐ Per `LMD-21`, each of S-3's seven sections independently occupies
exactly one of: `loading` · `ready` · `empty` · `unavailable` ·
`stale (as-of labelled)` · `withheld (permission)`.

⛔⛔ **Prohibited:** one failed contributor blanking the screen; a
`—`/`0`/`N/A` placeholder standing in for `unavailable` (that asserts a
value); an as-of label omitted on any of the four eventual sections
(`LMD-23`).

### 7.7 Interruption and recovery

| Situation | Design | Basis |
|---|---|---|
| Back out of S-1 → return | ⭐ Restore scroll, filters, **and** the query | Skill `state-preservation`; `LMD-11` cursor |
| Registration interrupted at S-5 | ⭐ Input retained **as staff-entered draft input**; ⛔⛔ **no record, no `enrollmentNumber`, no event** | ⭐ `SM-3.5`, `SM-3.7` |
| Retry after a timeout | ⭐ Same idempotency key ⇒ ⛔ no duplicate record | `SM-3.6` |
| Bulk interrupted mid-run | ⭐ S-13 shows completed + pending; ⛔ succeeded records **not** rolled back | ⭐ `LMD-30` |
| Sensitive panel open, app backgrounded | ⭐ Re-collapse on resume; ⛔ never persist the revealed state | §14.2, `SM-8.13` |

⛔ **Draft input is never called "saved".** `SM-3.5` makes a partial record
impossible, so language implying persistence would be false.

### 7.8 ⭐⭐ The `Unknown` minor-status state — the design problem unique to `BC-01`

`SM-4.5a`/`SM-4.5b` create a state with no analogue in `DD-0001`: the
system **cannot know** whether the student is a minor, must **not guess**,
and must behave **protectively** meanwhile.

| Requirement | Design consequence |
|---|---|
| ⛔ **MUST NOT** infer, default or assume an age | ⛔ No pre-filled age, ⛔ no "18+" checkbox pre-ticked, ⛔ no silent adult default |
| ⛔ **MUST NOT** treat `SM-INV-3` as satisfied | ⛔ The surface **MUST NOT** present the record as complete |
| ⭐ **MUST** record minor-status **`Unknown`** | ⭐⭐ `Unknown` is a **named, visible, self-explaining** value — ⛔ never blank, ⛔ never `—` |
| ⭐ **MUST** require a staff **age declaration** before leaving `Pending` | ⭐ One explicit staff action, labelled as an **attestation** with named consequence; ⭐ audited with actor + timestamp (`SM-8.13`) |
| ⭐ **Fail-safe:** treat as minor — guardian required, `ID-6` capability closed | ⭐ S-10 becomes **mandatory**; the closure is **stated**, ⛔ not silently applied |
| ⚠️ *"a **fail-safe**, not a legal determination"* (`SM-4.5b`) | ⭐⭐ Copy **MUST NOT** state or imply that the student *is* a minor. It states what the **system is doing and why** |

⭐ **Psychologically this is the highest-risk copy in the context.** An
adult student told *"you are a minor"* by a form is both wrong and
insulting. The declaration therefore reads as *the library confirming a
fact it does not yet hold*, ⛔ never as an accusation, ⛔ never as blame for
a missing field the student never chose to omit.

### 7.9 Multiple archived records — `SM-3.14a`/`SM-3.14b`

⭐ Restore targets the **most recently archived** (`archivedAt` desc, id
ordinal as tie-break) and the surface **MUST** present the **count** of
archived records and ⛔ **MUST NOT** silently discard the others.

⭐ Design: a single sentence stating how many archived records exist and
which one will be restored (by its archive date), before the action. ⛔ A
picker is **not** designed — `SM-3.14a` makes the target deterministic, so
offering a choice would contradict the requirement.

### 7.10 ⭐ All 16 `PRD-004` §9.2 edge cases — dispositioned

| # | Edge case | Surface + state |
|---|---|---|
| 1 | Same identity, multiple libraries | S-4 proceeds normally; ⛔ **0** cross-tenant hint (§14.1) |
| 2 | Duplicate registration | S-4 ⭐ *finding*, not error (§7.4) |
| 3 | Archived person re-registers | S-4 restore + count (§7.9) |
| 4 | Concurrent registration | S-6 typed conflict; ⛔ no partial record (§7.7) |
| 5 | Expired membership | ⭐⭐ S-1/S-3 **two badges** — `EnrollmentStatus` `Active` beside `MembershipStatus` `Expired` |
| 6 | Suspended member | S-8 states downstream effects; attendance still records |
| 7 | Deleted/disabled Account | S-3 identity section per `ID-5`; ⛔ no deletion control |
| 8 | Missing external reference | ⭐ S-3 **sectional** `unavailable` (§7.6) |
| 9 | Stale projection | ⭐ as-of label on all 4 eventual sections |
| 10 | Failed integration | Retry; ⛔ no duplicate effect shown |
| 11 | Library transfer | ⛔⛔ **No transfer control designed** — `SM-6.7` makes it archive + independent registration |
| 12 | Membership renewal | ⭐ Navigates **out** to `BC-02` → `DD-0001` S-8 |
| 13 | Conflicting updates | S-7 optimistic-concurrency notice; ⛔ no silent lost update |
| 14 | Unauthorized access | ⭐⭐ Fail closed; ⛔ **MUST NOT** reveal whether the record exists (§14.5) |
| 15 | Bulk partial failure | ⭐ S-13 per-record; ⛔ never "success" |
| 16 | `LCFG-5` disabled | ⭐ Directory **suppressed**; ⛔ copy **MUST NOT** imply data was deleted (`LMD-5`) |

⭐ **16 of 16 covered.** ⛔ 0 unaddressed.

---
## 8. Visual language — 2D / 2.5D / 3D

### 8.1 The governing rule

`DESIGN_FOUNDATION.md` §4 is **CONFIRMED**: *"lightweight premium 2.5D:
about 70% clean 2D, 20% subtle depth, 10% premium 3D-style illustration"*,
and *"premium through hierarchy, spacing, typography, illustration
restraint, and trustworthy state communication — not through visual
weight."*

⭐⭐ **`BC-01` sits at the 2D end of that band, deliberately.** This is the
densest, highest-frequency, most operational context in the product — a
reception desk clearing a queue. Depth here costs scan speed.

### 8.2 Allocation across the 14 surfaces

| Depth | Surfaces | Share | Why |
|---|---|---|---|
| **2D** | S-1, S-2, S-4, S-5, S-7, S-8, S-9, S-10, S-11, S-12, S-13, S-14 | ⭐ **12 of 14 (~86%)** | Dense lists, forms and tabular truth. ⛔ Depth on a paginated roster adds cost with no comprehension gain |
| **2.5D** | S-3 *(header card)*, S-6 *(review card)* | **2 of 14 (~14%)** | ⭐ Exactly the two moments needing grouping and focus: *"this is the person"* and *"this is what will be created"* |
| ⛔ **3D** | ⛔ **none** | ⭐⭐ **0 of 14** | See §8.6 |

⚠️ **This is more 2D than the CONFIRMED 70/20/10 band.** That is a
**deliberate, recorded departure**, permitted because the band is a
product-wide default and `DESIGN_FOUNDATION.md` §4 classes *"Clarity
before decoration"* as `RECOMMENDED` — a strong default *"departed from
only with a recorded reason"*. ⭐ The reason is recorded here and routed to
the Design System Owner as `DD-0002-GAP-008`; ⛔ it is **not** self-approved.

### 8.3 Typography — roles, not values

⛔ **No family, size, weight or line-height value is stated.** They are
`DBT-005`, undecided. What this document fixes is **role and behaviour**:

| Role | Behaviour |
|---|---|
| Person name | ⭐ The strongest element in every row and header. ⛔ Never truncated mid-name where wrapping is possible |
| `enrollmentNumber` | ⭐ **Tabular/monospaced figures** — scanned in columns and read aloud digit by digit |
| Status labels | ⭐ Identical treatment for both badges (`LMD-25`); ⛔ **MUST NOT** differ in size or weight, or one reads as subordinate |
| Section owner labels | Quiet, secondary; present on all 7 of S-3's sections |
| As-of timestamps | ⭐ Quietest tier — ⛔ must be **present** (`LMD-23`) without competing with the value |
| Dates | ⭐ One format product-wide; ⛔ **MUST NOT** mix `2026-08-04` with `4 Aug 2026` across surfaces |
| Money | ⭐ Reuses `DD-0001`'s `AmountBlock` treatment (§18) |

⭐ **All copy slots sized for +40% expansion** (§2). ⛔ No text baked into
any image.

### 8.4 Colour — semantic roles only

⛔ **No hex value is ratified.** `LiblColors` is an **implementation
reference** (`DBT-001`), ⛔ not an approved token set.

| Role | Use | ⛔ Constraint |
|---|---|---|
| Neutral text | The default for nearly everything | ⭐ Most of this context is **uncoloured** |
| Attention | Dues, expiring-soon | ⛔ **MUST** pair with icon **and** text (§11 check 4) |
| Negative | `Suspended`, blocked archive, failed bulk rows | ⛔ **MUST NOT** be the only signal |
| Positive | Succeeded bulk rows, confirmations | ⭐ Used sparingly; ⛔ no celebration |
| Muted / unavailable | ⭐ `unavailable` sections, `Unknown` minor-status | ⛔ **MUST NOT** look like disabled-by-permission (§14.3) |

⭐⭐ **`Archived` is presented as neutral-muted, never negative.** `SM-2.15`
makes archive a **soft, reversible** state and `SM-BR-7` prefers it;
colouring it as failure would misrepresent a normal lifecycle outcome.

### 8.5 Depth rules for 2.5D

⭐ Depth expresses **grouping and focus**, never decoration. Applied only
to S-3's header card and S-6's review card.

⛔ **Prohibited throughout:** blur, parallax, WebGL, animated gradients,
shadow used to imply importance where hierarchy already does, and
⭐ **any depth on a scrolling list row** — 60 fps on low-end Android
(§13) and skill `transform-performance`.

⭐ **Badges reserve a stable slot** (skill `content-jumping`, Severity
High): a row whose second status badge arrives late **MUST NOT** reflow the
row. This is a direct design consequence of `LMD-25`'s two indicators.

### 8.6 ⛔⛔ 3D — zero assets in this context, and why

`DD-0001` §8.6 allowed **exactly one** static 3D asset, for the empty
state of a first-run membership list. ⭐ **`BC-01` gets none**, on three
measured grounds:

1. ⭐ **No comparable onboarding moment exists.** A library with zero
   students is at `BC-01`'s empty state for minutes, ⛔ not the repeated
   first-run surface `DD-0001`'s asset served.
2. ⭐ **Every candidate location is a queue-pressure surface.** S-1's empty
   state is reached by staff mid-task; an illustration delays the
   register action.
3. ⛔ **`DESIGN_FOUNDATION.md` §4 confines 3D to *"selected explanatory or
   brand moments"***. ⛔ *"The roster is empty"* is neither.

⛔ **No mascot, no character, no gamified illustration anywhere** — this
context contains minors' records, and playful treatment of a safeguarding
surface would be inappropriate as well as off-brand.

---

## 9. Components

### 9.1 Existing — reuse before extension

`DESIGN_SYSTEM.md` §5: prefer existing; extension requires the Design
System Owner to record why composition is insufficient.

| Component | Observed at | Use in `BC-01` |
|---|---|---|
| `PanelCard` | `lib/app/shared/widgets/common.dart` | 2.5D container for S-3 header, S-6 review |
| `SectionHeader` | same | ⭐ All **7** S-3 sections and S-14 |
| `Pill` | same | ⭐ Status labels — ⛔ **only** inside `DualStatusRow`, never standalone (`LMD-25`) |
| `EmptyState` | same | §7.3's empties — ⭐ **two distinct instances**, not one |
| `MetricTile` | same | Bulk count vs cap (S-12) |
| `Monogram` | same | Person identity in S-1 rows and S-3 header |
| `MeterBar` | same | ⛔ **NOT USED** — see below |

⛔⛔ **`MeterBar` is deliberately unused in this context.** The only
plausible use is an attendance percentage, and ⭐⭐ **two independent
authorities forbid it here**: ⛔ `SM-GAP-9` records that **no owner has
defined the formula**, and ⛔⛔ `PRD-006` (**`FROZEN` v1.9**) makes
percentages an express **non-goal** at **`NG-6`**, assigning *"reports,
percentages, streaks, dashboards"* to **`BC-26` Analytics**, with **L2278**
forbidding `BC-03` from becoming *"the source for any attendance
percentage, streak"*. Rendering a progress bar here would fabricate
precision **and** claim a metric another context owns.

⚠️ **A prior revision of this paragraph said `PRD-006` was *"unwritten"*.
That was wrong** — it is frozen at **v1.9**, **Rank 3**, **3216 lines**
(`ADR-0034`). ⭐ The conclusion is unchanged and now rests on the
requirement that actually exists.

⛔ **Citing these components is not approving them** — they were built
without a design artifact (`DD-0001-GAP-009`, unchanged).

### 9.2 New components — 7, each justified

⭐ **5 of 12 needed components are reused from `DD-0001` §9.2** rather than
duplicated (§18). These 7 are new:

| Component | Purpose | Why composition is insufficient | States |
|---|---|---|---|
| ⭐⭐ `DualStatusRow` | `EnrollmentStatus` + `MembershipStatus` (S-1, S-3) | ⭐⭐ **Already specified in `DD-0001` §9.2 for `MM-FR-076`; `LMD-3`/`LMD-25` require the identical prohibition here.** ⛔ **Not a new component — a *shared* one.** Listed here because `BC-01` is its densest consumer and adds the **stable-slot** and **as-of** obligations | both-known · one-unknown · one-stale · loading |
| `SectionalPanel` | S-3's 7 independently-degrading sections | ⭐⭐ `LMD-21`+`LMD-23` require per-section degradation **with an owner label and an as-of stamp**. A generic card cannot carry `unavailable`-vs-`empty`-vs-`stale` as distinct states, and repeating the logic 7× guarantees one section forgets | loading · ready · empty · **unavailable** · stale · withheld |
| `AsOfLabel` | The staleness stamp (4 sections of S-3, S-1, S-14) | ⭐ `LMD-23` makes as-of labelling **mandatory where it affects a decision**. Encapsulation means no surface can render an eventual value without one | as-of · live · unknown |
| ⭐ `MinorStatusDeclaration` | S-5's three-case minor status | ⭐⭐ `SM-4.5a`/`4.5b` demand a named `Unknown`, a staff attestation, an audited action and fail-safe copy that ⛔ **must not** assert minority. No existing pattern carries an attestation | known-minor · known-adult · **unknown-pending** · declared |
| `OwnedFieldNotice` | S-7's `BC-10` read-only fields | ⭐ `SM-6.4` requires refusal *"with a pointer to `BC-10`"*, ⛔ never silent. A disabled `TextField` cannot state **why** or **where** | editable · owned-elsewhere · unavailable |
| `PerRecordOutcomeList` | S-13 bulk results | ⭐⭐ `LMD-30`+`SM-BR-14` require per-record outcomes and forbid reporting partial as success. A generic list would allow a summary banner — the exact prohibited behaviour | running · all-succeeded · **partial** · all-failed |
| `AttendanceFactRow` | S-3's attendance section | ⭐ Must show attendance **without a percentage** (`SM-GAP-9`) and without motivational framing (§2). Existing tiles imply a rate | ready · empty · unavailable · stale |

⛔ **Every new component needs Design System Owner approval**
(`DESIGN_SYSTEM.md` §5) — ⛔ this document does not grant it.

### 9.3 Component contract

All 7 must satisfy `DESIGN_SYSTEM.md` §3's eleven items, using
[`../../design/templates/COMPONENT_SPEC_TEMPLATE.md`](../../design/templates/COMPONENT_SPEC_TEMPLATE.md).
⚠️ Their token sections cannot be completed until `DBT-001` is decided.

---

## 10. Interaction and motion

### 10.1 Motion classes — reused, not extended

⭐⭐ **`DD-0001` §10.1's five motion classes are adopted unchanged, and
⛔ no sixth class is introduced.** Inventing a parallel vocabulary for a
second context would fragment the product's motion language — exactly the
outcome a shared design foundation exists to prevent.

⭐ Every class respects reduced-motion (§11 check 8). ⛔ No motion carries
information that is not also available statically.

### 10.2 Interaction rules

1. ⭐ **One primary action per surface.** S-1's is search; S-3's is the
   highest-authorised operation available to that role.
2. ⭐ **Search is the first focusable element on S-1** — queue pressure
   (§2). Skill `search-accessible`; ⛔ but **no recent-query history**
   (§14.4).
3. ⛔ **Visibility never implies permission** (`LMD-29`). A control the
   caller may not use is either **absent** or **disabled with a reason** —
   ⛔ never enabled-then-refused.
4. ⭐ **A disabled control always states why.** Skill `disabled-states` is
   insufficient alone: `SM-6.4` and `LMD-29` require the reason.
5. ⭐ **Irreversible and delegated actions confirm** (skill
   `confirmation-dialogs`): archive (S-9), bulk (S-12), export (S-12).
6. ⛔ **No destructive action is a swipe.** Archive is `TR-1`-only and
   dues-gated; a swipe would put it one accidental gesture away.
7. ⭐ **Every list row's tap target meets the platform minimum**
   (§11 check 3) — ⛔ exact value deferred to the chosen standard.
8. ⭐ **Double-submit is impossible** (skill `loading-buttons`): S-6, S-8,
   S-9 and S-12 disable their control while in flight, reinforcing
   `SM-3.6` idempotency in the UI layer.

---

## 11. Accessibility

⛔⛔ **The standard is `TO BE DECIDED`** — `ACCESSIBILITY.md` L10, and
⛔ this document does **not** choose one (`DD-0002-GAP-003`). ⭐ The nine
checks below are `DD-0001` §11's, applied to this context's 14 surfaces;
⛔ no numeric threshold is invented.

| # | Check | `BC-01` application |
|---|---|---|
| 1 | Every control has an accessible name | ⭐ Includes S-1's search field — ⛔ currently placeholder-only (`IDV-004`) |
| 2 | Focus order follows reading order | ⭐ S-2's filter sheet returns focus to the triggering control on dismiss |
| 3 | Touch targets meet the platform minimum | ⭐ Dense S-1 rows are the binding constraint; ⛔ density **MUST NOT** win |
| 4 | ⭐ Information is never conveyed by colour alone | ⭐⭐ Both badges carry **text**; dues carry an icon **and** a label. ⛔ `IDV-002`'s colour-only pills fail this |
| 5 | Contrast is sufficient | ⛔ Unverifiable until `DBT-001` ratifies values |
| 6 | Text scales without loss of function | ⭐ S-1 rows **MUST** reflow, ⛔ not truncate the person's name |
| 7 | Errors are announced, not only shown | ⭐ S-13's per-record outcomes announce progressively; ⛔ not one final alert |
| 8 | Motion respects reduced-motion | Per §10.1 |
| 9 | ⭐ State changes are announced | ⭐⭐ `unavailable`, `stale` and `withheld` **MUST** be announced — otherwise a screen-reader user cannot distinguish them, and `LMD-18` becomes visual-only |

⭐⭐ **Check 9 is strengthened for this context** over `DD-0001`, because
`LMD-18`'s empty-vs-unavailable distinction is meaningless if it is
rendered only visually. ⛔ Measured baseline: **1** `testWidgets`
repo-wide, so ⛔ **none of these nine is currently verified by any test**
(`IDV-015`).

---

## 12. Responsive behaviour

⛔⛔ **No breakpoint value is invented** — `DBT-002`, and
[`../README.md`](../README.md)-governed foundation assigns breakpoints to
no owning document. ⭐ What is specified is **adaptation behaviour**:

| Surface | Narrow *(primary)* | Wider |
|---|---|---|
| S-1 list | ⭐ Single column, stacked rows, ⛔ **never a horizontal-scroll table** | More fields per row **before** a second column |
| S-2 filters | Full-height sheet | May become a persistent panel |
| S-3 detail | ⭐ 7 sections stacked, vertical | Sections may pair side-by-side — ⛔ order **MUST** be preserved |
| S-4–S-6 register | One stage per screen | May co-present stages — ⛔ but **one commit point** remains (§5.1) |
| S-12/S-13 bulk | Stacked rows | Denser rows |

⛔ **The skill's `table-handling` rule (horizontal scroll) is rejected**
(§1.2): a horizontally scrolling member roster on a phone hides the very
columns `LMD-25` requires to be seen together.

⭐ **Design and prototype at one narrow phone width, labelled *reference
width*** — carried from `DD-0001` §19.1. ⛔ **Do not invent a tablet
breakpoint.**

---

## 13. Performance

⭐ Bound to `DESIGN_FOUNDATION.md` §4's **CONFIRMED** *"Low-end respect"*.

| Constraint | Design consequence |
|---|---|
| ⭐ 60 fps scroll on low-end Android | ⛔ No depth, shadow or blur on S-1 rows (§8.5); ⛔ no per-row animation |
| ⭐ `LMD-9`/`LMD-10` pagination | ⭐ Page size **`SMCFG-1` = 20** default, max **`SMCFG-2` = 50**; ⛔ an exceeded request is **clamped, not rejected** (`LMD-10`) — the surface says so |
| ⛔ Skill `large-dataset` sampling **REJECTED** | ⭐ Pagination is mandated; sampling a roster would make counts wrong (§1.2) |
| ⭐ `LMD-11` cursor stability | ⛔ **Only for authoritative filters** (`LMD-15b`); ⭐ a best-effort filter **MAY** shift a row between pages and the surface **discloses** it rather than concealing it |
| Skeletons | ⭐ Reserve **exact** final height — skill `content-jumping` (High) |
| Images | ⭐ `photoRef` thumbnails sized to display; ⛔ never full-size. Skill `image-optimization` |
| ⭐ 7 parallel compositions on S-3 | ⭐⭐ Render **progressively** per section (`LMD-21`); ⛔ **MUST NOT** wait for the slowest contributor before showing anything |

---
## 14. Security and privacy UX

⭐⭐ **This is the most security-loaded Design Doc so far**, because
`PRD-004` §8 is a full chapter: tenant isolation, a closed 12×5 permission
matrix, read auditing and data minimisation.

### 14.1 Tenant isolation is a UX obligation too

`SM-8.1`–`SM-8.3`: every query is tenant-scoped server-side, and a
cross-tenant read **MUST** be *impossible, not merely filtered*.

⛔⛔ **Design consequence:** ⛔ **no surface shows, hints at, counts or
implies any record outside the current tenant** — no *"this person is
enrolled at 2 other libraries"*, no cross-tenant duplicate warning, no
global search affordance. ⭐ `SM-3.15`/`SM-BR-1` make multi-library
enrolment normal and `ID-2` keeps `StudentRecordId` inside its tenant, so
such a hint would leak another library's roster.

### 14.2 ⭐ Sensitive data — reveal, don't expose

`SM-PO-10` gates *guardian contact and DOB* to `TR-1`/`TR-2` (and `TR-4`
own-only), and ⭐⭐ `SM-8.13` requires the **read itself** to be audited.

| Rule | Design |
|---|---|
| ⭐ Reads are audited (`SM-8.13`, `SM-8.10`) | ⭐⭐ Sensitive fields **collapsed by default**; an explicit reveal is the auditable event. ⛔ Auto-expanding would generate audit entries the user never intended — and would expose the field to whoever is standing at the desk (§2) |
| ⛔ No hover-reveal | ⛔ Hover is not an intent signal, and ⛔ does not exist on touch |
| ⭐ Re-collapse on resume | §7.7 |
| ⭐ The user is told the read is recorded | ⭐ A quiet, factual note at the reveal control. ⛔ Not a warning, ⛔ not a deterrent — staff have a legitimate need |

⚠️ **The exact disclosure wording is not settled here** —
`SECURITY_PRIVACY_UX.md`'s open gaps own it, and the Privacy Owner seat is
**VACANT**. → `DD-0002-GAP-005`.

### 14.3 ⭐ All 12 protected operations — presentation rule each

⭐ Derived **only** from `PRD-004` §8.2's closed matrix. ⛔ No permission
invented, ⛔ none widened.

| Op | Operation | Presentation rule |
|---|---|---|
| `SM-PO-1` | View member list | ⭐ `TR-3` sees S-1; ⛔ `TR-4`/`TR-5` have **no entry point at all** (§4.1) |
| `SM-PO-2` | View member detail | ⭐ `TR-4` sees **only their own** — ⛔ so no list, no navigation to another record; ⛔ `TR-5` **denied** (interim) |
| `SM-PO-3` | Register student | ⭐ `TR-4` self-enrol is gated by Library Discovery (`SM-3.10`) — ⛔ **not designed here** |
| `SM-PO-4` | Update profile | ⭐ `TR-4` edits an **own subset** ⇒ non-editable fields use `OwnedFieldNotice`, ⛔ never a silent read-only |
| `SM-PO-5` | → `Inactive`/`Suspended` | ⛔ **Absent** for `TR-3` — ⛔ not greyed. A reception user should not learn the control exists |
| `SM-PO-6` | Reactivate | As `SM-PO-5` |
| `SM-PO-7` | Archive | ⭐ `TR-1` **only**; ⛔ absent for everyone else |
| `SM-PO-8` | Restore | ⭐ `TR-1` only; reachable **only** via the archived filter (`LMD-27`) |
| `SM-PO-9` | Documents | ⭐ `TR-3` = **view only** ⇒ ⛔ no attach/remove affordance rendered |
| `SM-PO-10` | Sensitive data | ⭐ §14.2's reveal; ⛔ absent for `TR-3` |
| `SM-PO-11` | Export | ⭐ `TR-1` only; ⭐ shows row count **and** field set first (`LMD-31`) |
| `SM-PO-12` | Bulk status change | ⭐ `TR-1`/`TR-2`; ⛔ selection UI not rendered for `TR-3` |

⭐⭐ **Absent vs disabled is decided per row, not globally.** The rule
applied: **absent** when the operation's existence is itself
role-inappropriate (`SM-PO-5`–`SM-PO-8`, `SM-PO-11`); **disabled with a
reason** when the user legitimately expects it and needs to know why
(field-level edits under `SM-PO-4`, archive blocked by dues). ⛔ Neither is
a permission decision — `BC-18` decides (`SM-8.6`); this is only *how the
decision is shown*.

⚠️ **`TR-5` Parent's denial copy is deliberately unresolved** (§4.1): the
capability does not exist in V1, ⛔ it is not a permission failure, and
⛔ this document will not promise a future. → `DD-0002-GAP-006`.

### 14.4 Search must not leak through ranking or highlighting

⭐⭐ `LMD-14` — matching **MUST NOT** leak an unauthorised field *"through
result ranking or highlighting"*.

⛔ **Design consequences:** ⛔ **never highlight a match in a field the
caller may not see**; ⛔ never show a *"matched on guardian phone"*
attribution; ⛔ never let result **order** imply a hidden match. ⭐ And
⛔ **no recent/suggested query history** (rejecting the skill's
`search-accessible` second limb, §1.2) — a query trail on a shared
reception device is a member-name leak and contradicts `SM-8.15`.

### 14.5 Anti-enumeration

⭐ `SM-8.9` — an unauthorised access **MUST** fail closed, be audited, and
⛔ **MUST NOT reveal whether the record exists**.

⛔ **Design consequence:** *"Not found"* and *"not permitted"* **MUST** be
**indistinguishable** on this surface. ⚠️ This is a deliberate,
uncomfortable UX cost: a legitimate user with a typo gets an unhelpful
message. ⛔ It is **not** a design defect to be smoothed — `SM-8.9` makes
the ambiguity the requirement.

### 14.6 Data minimisation

⭐ `SM-8.15` — ⛔ no field is collected that no requirement uses. ⭐ The
design adds **0** fields, and ⛔ **no member tags or notes** exist
anywhere (`SM-GAP-5`, §1.3).

---

## 15. Content UX

⭐ Repository terminology only. ⛔ No product word is invented.

| Use | ⛔ Do not use |
|---|---|
| ⭐ `EnrollmentStatus`: **Active · Inactive · Suspended · Archived** | ⛔ `Expired`, ⛔ `Prospective`, ⛔ `Registered` (`SM-2.5`, `SM-2.6`, `SM-2.7`) |
| ⭐ `MembershipStatus`: **Valid · Expired · Frozen** (`BC-02`'s words) | ⛔ **`Active`** for membership — that is `IDV-003`'s defect |
| ⭐ **Enrolment / enrolled** for `BC-01`; **membership** for `BC-02` | ⛔ Using them interchangeably |
| ⭐ **Archived** | ⛔ *Deleted*, ⛔ *Removed* — `SM-2.15` makes it soft and reversible |
| ⭐ **Guardian** | ⛔ *Emergency contact* — a distinct, **unsourced** field (`SM-GAP-6`) |
| ⭐ **Minor status: Unknown** | ⛔ *"Age not provided"* (blames the student), ⛔ *"Assumed minor"* (asserts a fact) |
| ⭐ **Enrolment number** | ⛔ *Student ID*, ⛔ *Roll number* |
| ⭐ **Member** *(only inside the Directory)* | ⛔ Elsewhere — `LMD-1`/`AR-1`: there is **no `LibraryMember` aggregate** |

⭐ **Copy principles:** state the fact, then the next safe action; name the
owner of a value the user cannot change; ⛔ never blame the user for a
missing field; ⛔ never use urgency, guilt or shame (§2); size every slot
for **+40%** expansion; ⛔ no concatenated sentence fragments.

⚠️ **Unresolved content conflict:** `PRD-004` uses *"enrollment"*
(US spelling) as an identifier stem while `MASTER_PRD` prose uses
*"enrolment"* in places. ⛔ Identifiers **MUST NOT** change. ⭐ Recorded as
`DD-0002-GAP-009` for the Content Owner; ⛔ **not decided here**.

---

## 16. Design QA expectations

⭐ Per [`../../design/DESIGN_QA.md`](../../design/DESIGN_QA.md), using
[`../../design/templates/DESIGN_QA_EVIDENCE_TEMPLATE.md`](../../design/templates/DESIGN_QA_EVIDENCE_TEMPLATE.md).
⭐ **12 blocking conditions.** A build failing any one is **not**
`BC-01`-design-conformant:

| # | Blocking condition | Basis |
|---|---|---|
| 1 | ⭐⭐ A single merged status badge appears anywhere | ⛔ `LMD-3`, `LMD-25` |
| 2 | The word `Active` is used for a **membership** state | ⛔ `SM-2.7` |
| 3 | An empty result is indistinguishable from an unavailable projection | ⛔ `LMD-18` |
| 4 | An eventual value renders **without** an as-of label | ⛔ `LMD-23` |
| 5 | One unavailable contributor blanks S-3 instead of its section | ⛔ `LMD-21` |
| 6 | The list renders unpaginated, or ignores `SMCFG-1`/`2` | ⛔ `LMD-9`, `LMD-10` |
| 7 | A filter outside `LMD-15`'s closed set is offered | ⛔ `LMD-15` |
| 8 | `Archived` records appear in the default list | ⛔ `LMD-27` |
| 9 | ⭐ The Directory performs **any** write | ⛔⛔ `LMD-28` |
| 10 | A partial bulk result is summarised as success | ⛔⛔ `LMD-30`, `SM-BR-14` |
| 11 | ⭐ Minor-status `Unknown` renders blank, as `—`, or as an error | ⛔ `SM-4.5a` |
| 12 | A `BC-10`-owned field is silently read-only, with no pointer | ⛔ `SM-6.4` |

⛔ **Measured QA baseline: 0.** **1** `testWidgets` exists repo-wide, so
⛔ **none of the 12 is currently enforced by a test** (`IDV-015`). ⭐ Each
is written to be **mechanically checkable** so it can become one.

---

## 17. Engineering handoff

### 17.1 ⭐⭐ The measured blocker

| Fact | Measurement |
|---|---|
| `app`-module tasks in `PRD-004` §10.7 | ⭐ **7** — `IMPL-312`, `313`, `314`, `315`, `317`, `318`, `319` |
| ⭐ How `app` may reach `domain/library` | ⭐⭐ **`ports:`** (manifest **L534**) — ⛔ **never `imports:`** |
| Current boundary state | ⛔ **`FAIL — 9 violation(s) in 1 category(ies)`** |
| ⭐ Of which, this context's surface | ⭐⭐ **2** — `students_page.dart:13` and `:14` (`IDV-014`) |
| `ADR-0012` §3.4 | ⛔ *"deliberately left failing"* — *"not waived"* |
| ⚠️ `TASK-D10` | ⭐ Measured to delete **demo credentials** in `login_screen.dart`/`session.dart` — ⛔ **it does not touch `students_page.dart`** |

⭐⭐ **Therefore the honest statement is narrower than `DD-0001`'s.**
`DD-0001` §17.1 found all 5 of `PRD-005`'s `app` tasks blocked by a single
seam. Here: ⭐ the **7** `app` tasks are **specifiable through the declared
port** and are ⛔ **not individually recorded as blocked anywhere**; but
⭐⭐ **the existing surface that would host them contributes 2 of the 9
live violations, and `TASK-D10` will not remove them** — so building on
`students_page.dart` as it stands would extend an un-waived violation.

⛔ **This document does not resolve that.** Whether the port adapter is
declared, or the surface is rebuilt, is an **Architecture Owner** act →
`DD-0002-GAP-010`.

### 17.2 Handoff package requirements

⭐ Per [`../../design/DESIGN_ENGINEERING_HANDOFF.md`](../../design/DESIGN_ENGINEERING_HANDOFF.md):
14 surface specs via
[`../../design/templates/SCREEN_SPEC_TEMPLATE.md`](../../design/templates/SCREEN_SPEC_TEMPLATE.md);
7 component specs; the §7.2 state matrix; the §19 traceability table; the
§16 QA conditions.

### 17.3 ⛔ Not handoff-ready — and why

⛔ Token values (`DBT-001`), breakpoints (`DBT-002`), type values
(`DBT-005`) and the accessibility standard (`DD-0002-GAP-003`) are all
undecided, so ⛔ **no pixel-exact spec can be produced**. ⭐ Behavioural
handoff is complete.

### 17.4 Flutter-specific notes

⭐ Non-binding engineering observations, ⛔ not requirements:

* `SectionalPanel`'s six states suit a sealed-class state union per
  section, ⛔ not nullable fields — a null cannot distinguish `empty` from
  `unavailable`, which is `LMD-18` in code.
* ⭐ S-1 must use a lazily-built, paginated list; ⛔ never a `Column` of all
  records.
* ⭐ Wrap S-1 rows in `RepaintBoundary` — 60 fps on low-end Android (§13).
* ⭐ `DualStatusRow` needs a fixed-extent slot so a late second badge does
  not reflow (§8.5).
* ⛔ `Pill` **MUST NOT** be used standalone for status anywhere in this
  context — that is how `IDV-002` arose.

---
## 18. Cross-feature consistency with `DD-0001`

⭐⭐ **`BC-01` and `BC-02` meet on the same screen.** `PRD-004` §5.4
composes `BC-02`'s plan/status/expiry into S-3, so an inconsistency
between the two Design Docs would be visible to the user in one glance.

| Concern | `DD-0001` (`BC-02`) | `DD-0002` (`BC-01`) | Consistent? |
|---|---|---|---|
| ⭐⭐ Dual status, never merged | S-6 + `DualStatusRow`, on `MM-FR-076` | S-1/S-3 + `DualStatusRow`, on `LMD-3`/`LMD-25` | ⭐⭐ **YES — same component, two independent authorities** |
| Validity never client-derived | `ValidityStatement`, on `MM-FR-066` | ⭐ Reused; `LMD-16` forbids local expiry computation | ⭐ **YES** |
| Money presentation | `AmountBlock` | ⭐ Reused for dues in S-3/S-9 | ⭐ **YES** |
| Pre-commit disclosure | `ReviewCard` (3 flows) | ⭐ Reused for S-6 | ⭐ **YES** |
| Two-stage commit | `TwoStageProgress` | ⭐ Reused for S-4→S-6 (`SM-3.5`) | ⭐ **YES** |
| Staleness | `StaleDataBanner` | ⚠️ **Extended** — `AsOfLabel` is per-**field/section**, not per-screen, because `LMD-23` attaches to the value | ⚠️ **COMPATIBLE, NOT IDENTICAL** — recorded, see below |
| Motion vocabulary | 5 classes | ⭐ Same 5, ⛔ none added | ⭐ **YES** |
| Loading tiers | 3 tiers | ⭐ Same 3 | ⭐ **YES** |
| 3D allocation | ⭐ Exactly **1** asset | ⭐ **0** assets, reasoned (§8.6) | ⭐ **YES** — same rule, different outcome |
| State count | 6 states | ⚠️ **7** — adds `Unavailable` per `LMD-18`/`LMD-21` | ⚠️ **SUPERSET, NOT CONFLICT** |
| Renewal ownership | `BC-02` owns it (S-8) | ⭐ Navigates **out** (`SM-6.8`) | ⭐ **YES — no duplication** |
| ⚠️ Payment | `ADR-0130` — **V1 cash only**, `BC-05`/`BC-02` own collection | ⛔⛔ **No collection control** (`LMD-28`) | ⭐ **YES in design** — ⚠️ but ⛔ `IDV-010` (existing code offers UPI here) **contradicts both** |

⭐ **Two deliberate divergences, both recorded rather than smoothed:**

1. ⭐ **`AsOfLabel` is finer-grained than `StaleDataBanner`.** `BC-02`'s
   staleness is whole-screen (one module's data); `BC-01`'s is per-section
   (**four** eventually-consistent contributors, `LMD-21`). ⛔ Forcing one
   banner would violate `LMD-23`'s per-value obligation; ⛔ forcing
   per-field onto `BC-02` would add noise with no requirement behind it.
   → Design System Owner as `DD-0002-GAP-007`.
2. ⭐ **Seven states vs six.** ⛔ Not a conflict: `Unavailable` is
   *additional*, and `DD-0001`'s six remain valid for `BC-02`. ⚠️ If the
   product later wants one state vocabulary, that is a foundation
   decision, ⛔ not a unilateral edit to either Design Doc.

⛔ **`DD-0001` is not modified by this document.** Both divergences are
recorded here and routed; ⛔ rewriting `DD-0001` to match would be exactly
the silent rewrite §1.3 forbids.

---

## 19. Design coverage matrix — PRD → Flow → Surface → State → Component → QA

### 19.1 The `LMD-*` Directory register — all 35

| `LMD-*` | Flow | Surface | State | Component | QA | Status |
|---|---|---|---|---|---|---|
| `LMD-1`, `LMD-2` | 5.4 | S-1, S-3 | ready | — | §16.9 | ⭐ **COVERED** |
| `LMD-3` | 5.4 | S-1, S-3 | both-known | ⭐ `DualStatusRow` | ⭐ §16.1 | ⭐ **COVERED** |
| `LMD-4`, `LMD-5` | — | S-1 | ⭐ suppressed | — | §7.10 case 16 | ⭐ **COVERED** |
| `LMD-6` | — | — | — | — | — | ⚪ **NOT APPLICABLE** — typed-accessor mechanics, ⛔ no surface |
| `LMD-7` | — | S-1 | permission | — | §14.1 | ⭐ **COVERED** |
| `LMD-8` | 5.4 | S-1 | ready | — | §16.6 | ⭐ **COVERED** *(server-side; design honours it by ⛔ never filtering client-side)* |
| `LMD-9`, `LMD-10`, `LMD-11` | 5.4 | S-1 | ready/loading | — | §16.6 | ⭐ **COVERED** |
| `LMD-12`, `LMD-13` | 5.4 | S-2 | ready/unavailable | — | §14.4 | ⭐ **COVERED** |
| ⭐ `LMD-14` | 5.4 | S-2 | ready | — | ⭐ §14.4 | ⭐ **COVERED** |
| `LMD-15`, `LMD-15a`, `LMD-15b` | 5.4 | S-2 | ready | — | ⭐ §16.7 | ⭐ **COVERED** *(⭐ filters grouped authoritative vs best-effort)* |
| `LMD-16` | 5.4 | S-1, S-3 | ready | `AsOfLabel` | §16.4 | ⭐ **COVERED** |
| `LMD-17` | 5.4 | S-2 | ready | — | — | ⭐ **COVERED** *(⭐ tie-breaker exposed)* |
| ⭐⭐ `LMD-18` | 5.4 | S-1, S-2 | ⭐ empty ≠ unavailable | `EmptyState` ×2 | ⭐ §16.3 | ⭐ **COVERED** |
| `LMD-19`, `LMD-20` | 5.4 | S-3 | ready/withheld | `SectionalPanel` | §16.5 | ⭐ **COVERED** |
| ⭐⭐ `LMD-21` | 5.4 | S-3 | ⭐ per-section | `SectionalPanel` | ⭐ §16.5 | ⭐ **COVERED** |
| `LMD-22`, `LMD-24`, `LMD-24a`, `LMD-24b` | — | — | — | — | — | ⚪ **NOT APPLICABLE** — layering/authority rules; ⛔ no surface. §17.4 notes them for engineering |
| ⭐ `LMD-23` | 5.4 | S-1, S-3, S-14 | ⭐ stale | ⭐ `AsOfLabel` | ⭐ §16.4 | ⭐ **COVERED** |
| ⭐⭐ `LMD-25` | 5.4 | S-1, S-3 | both-known | ⭐ `DualStatusRow` | ⭐ §16.1 | ⭐ **COVERED** |
| `LMD-26` | 5.4 | S-1, S-3 | ready | `AsOfLabel` | — | ⭐ **COVERED** *(⭐ `SMCFG-3` shown as configured)* |
| `LMD-27` | 5.3 | S-1, S-2 | ready | — | ⭐ §16.8 | ⭐ **COVERED** |
| ⭐⭐ `LMD-28` | 5.4 | S-1, S-3 | ready | — | ⭐⭐ §16.9 | ⭐ **COVERED** *(⚠️ `IDV-010`/`IDV-011` violate it today)* |
| `LMD-29` | — | all | permission | — | §14.3 | ⭐ **COVERED** |
| ⭐ `LMD-30` | 5.5 | S-12, S-13 | ⭐ partial | ⭐ `PerRecordOutcomeList` | ⭐ §16.10 | ⭐ **COVERED** |
| `LMD-31` | 5.5 | S-12 | ready | — | §14.3 | ⭐ **COVERED** |

⭐ **35 of 35 dispositioned — 30 COVERED · 5 NOT APPLICABLE · ⛔ 0 DESIGN
GAP · ⛔ 0 BLOCKED.**

### 19.2 Lifecycle, registration, profile and operations requirements

| Requirement group | Flow | Surface | Status |
|---|---|---|---|
| `SM-2.5`–`SM-2.7` closed status set | 5.2 | S-1, S-3, S-8 | ⭐ **COVERED** — §15 vocabulary |
| `SM-2.8`–`SM-2.13` transitions | 5.2 | S-8 | ⭐ **COVERED** — reason required; ⛔ no back-dating control |
| `SM-2.14` `Suspended` effects | 5.2 | S-8 | ⭐ **COVERED** — stated, ⛔ not enforced here |
| `SM-2.15`, `SM-2.16` archive/erasure | 5.3 | S-9 | ⭐ **COVERED** *(erasure ⚪ **NOT APPLICABLE** — `ID-5` owns it)* |
| `SM-3.1`–`SM-3.10` registration | 5.1 | S-4, S-6 | ⭐ **COVERED** |
| `SM-3.11`–`SM-3.14b` duplicate/restore | 5.1 | S-4 | ⭐ **COVERED** — §7.4, §7.9 |
| `SM-3.15`–`SM-3.17` concurrency | 5.1 | S-6 | ⭐ **COVERED** |
| `SM-4.1`–`SM-4.3` field ownership | — | S-7 | ⭐ **COVERED** — `OwnedFieldNotice` |
| ⭐ `SM-4.4`–`SM-4.5c` minor status | 5.1 | S-5, S-10 | ⭐⭐ **COVERED** — §7.8 |
| `SM-4.6`–`SM-4.8` guardian | 5.1 | S-10 | ⭐ **COVERED** *(consent ⚪ **NOT APPLICABLE** — `BC-18`)* |
| `SM-4.9`–`SM-4.12` documents | — | S-11 | ⭐ **COVERED** |
| `SM-6.1`–`SM-6.8` operations | 5.2, 5.3 | S-3, S-7, S-8, S-14 | ⭐ **COVERED** |
| `SM-8.1`–`SM-8.4` isolation | — | all | ⭐ **COVERED** — §14.1 |
| ⭐ `SM-8.4a`, `SM-PO-1`–`SM-PO-12` | — | all | ⭐⭐ **COVERED** — §14.3, **12 of 12** |
| `SM-8.9` anti-enumeration | — | S-1, S-3 | ⭐ **COVERED** — §14.5 |
| `SM-8.10`–`SM-8.14` audit | — | S-3, S-14 | ⭐ **COVERED** — §14.2 reveal-as-audit-event |
| `SM-8.15`–`SM-8.17` privacy | — | S-12 | ⭐ **COVERED** — §14.6 |
| `SM-BR-1`–`SM-BR-16` | various | various | ⭐ **COVERED** — **16 of 16** |
| `SM-INV-1`–`SM-INV-11` | — | — | ⚪ **NOT APPLICABLE** — domain invariants; ⭐ `SM-INV-3` surfaces via S-5 |
| `SM-EV-1`–`SM-EV-10` | — | — | ⚪ **NOT APPLICABLE** — events, ⛔ not surfaces |
| `SM-XC-1`–`SM-XC-14` exclusions | — | — | ⭐ **COVERED negatively** — ⛔ no surface exists for any excluded capability |
| `SM-AC-1`–`SM-AC-32` | — | — | ⚪ **NOT APPLICABLE** — acceptance criteria for implementation |
| `SMCFG-1`–`SMCFG-7` | — | S-1, S-11, S-12 | ⭐ **COVERED** — shown as configured, ⛔ never hard-coded in copy |
| ⛔ `SM-GAP-1`–`SM-GAP-11` | — | — | ⛔⛔ **EXCLUDED BY DESIGN — all 11 individually dispositioned in §2.** ⭐ `SM-GAP-3` and `SM-GAP-10` shape S-8 and S-5 *negatively* (the design is correct either way); ⛔ the other nine get **0** surfaces |

### 19.3 Coverage summary

| Classification | Count | Notes |
|---|---|---|
| ⭐ **COVERED** | **30** `LMD-*` + **19** requirement groups | Every one traced to surface + state + QA |
| ⚪ **NOT APPLICABLE** | **5** `LMD-*` + **5** groups | Layering, events, invariants, criteria, typed-config mechanics — ⛔ correctly have no surface |
| ⚠️ **DESIGN GAP** | ⭐ **0** against `PRD-004` | The **12** `DD-0002-GAP-*` are product/foundation decisions, ⛔ not uncovered requirements |
| ⛔ **BLOCKED** | ⭐ **0** design-blocked | ⚠️ **1 implementation** concern — §17.1 |

⭐⭐ **No `PRD-004` surface requirement is uncovered, and ⛔ no surface
exists without a `PRD-004` source.**

### 19.4 Per-surface handoff summary

| Surface | Entry | Exit | Primary action | Secondary | Dependencies | Figma-ready |
|---|---|---|---|---|---|---|
| S-1 | Staff shell | S-2, S-3, S-4 | Search | Filter, register | `BC-23`, `BC-02`, `BC-25` | ⭐ **YES** |
| S-2 | S-1 | S-1 *(applied)* | Apply | Clear | `BC-23` | ⭐ **YES** |
| S-3 | S-1 | S-7…S-11, S-14, ⭐ `BC-02` | Highest-authorised op | View history | ⭐ All 7 contributors | ⭐ **YES** |
| S-4 | S-1 | S-5, or existing record | Continue | Open existing, restore | `BC-18`, `BC-10` | ⭐ **YES** |
| S-5 | S-4 | S-6, S-10 | Declare / continue | Back | `BC-10` | ⭐ **YES** |
| S-6 | S-5 | S-3 | ⭐ Create *(one commit)* | Back | `BC-01` | ⭐ **YES** |
| S-7 | S-3 | S-3 | Save | Cancel | `BC-10`, `BC-18` | ⭐ **YES** |
| S-8 | S-3 | S-3 | Change status | Cancel | `BC-02`, `BC-04`, `BC-03` | ⭐ **YES** |
| S-9 | S-3 | S-1 / S-3 | Archive / restore | Cancel | ⭐ `BC-05` *(`E-09`)* | ⭐ **YES** |
| S-10 | S-3, S-5 | back | Save guardian | Cancel | ⭐ `BC-18` *(`ID-6`)* | ⭐ **YES** |
| S-11 | S-3 | S-3 | Attach | Remove, view | `BC-29` *(`E-22`)* | ⭐ **YES** |
| S-12 | S-1 | S-13 | Apply / export | Cancel | `BC-18`, `BC-25` | ⭐ **YES** |
| S-13 | S-12 | S-1 | Done | Retry failed | — | ⭐ **YES** |
| S-14 | S-3 | S-3 | — *(read-only)* | — | `BC-24` *(`E-20`)* | ⭐ **YES** |

⭐ **14 of 14 Figma-ready**, subject to §20.1's two labelled substitutions.

---
## 20. Gap register — `DD-0002-GAP-001` … `012`

⛔⛔ **These are not requirements.** Each is a decision this document
**refuses to invent**, recorded so nobody implements a fabricated answer.

| ID | Gap | Class | Owning office | Why it is not decided here |
|---|---|---|---|---|
| `DD-0002-GAP-001` | Top-level placement of Student Management in app navigation | ⚠️ **NON-BLOCKING** | UX Architecture Owner | ⛔ App-level IA is product-wide; the current staff-shell tab is an implementation fact, ⛔ not an approved IA |
| `DD-0002-GAP-002` | Token values — colour, spacing, radius, elevation | ⚠️ **NON-BLOCKING** | ⭐ Design System Owner | ⭐ **`DBT-001`.** ⛔ `theme.dart`'s values are an implementation reference; writing them here would ratify them (`DESIGN_DEBT.md` §4 rule 5) |
| `DD-0002-GAP-003` | Accessibility standard and its numeric thresholds | ⚠️ **NON-BLOCKING** | Accessibility Owner | ⛔ `ACCESSIBILITY.md` L10 is `TO BE DECIDED`; §11's nine checks apply regardless of which standard is chosen |
| `DD-0002-GAP-004` | Responsive breakpoint values | ⚠️ **NON-BLOCKING** | Responsive Design Owner | ⭐ **`DBT-002`** — no owning document exists |
| `DD-0002-GAP-005` | Exact wording disclosing that a sensitive read is audited | ⚠️ **NON-BLOCKING** | ⛔ Privacy Owner — **seat VACANT** | ⭐ `SM-8.13` requires the audit; ⛔ the *disclosure* wording is a privacy-communication decision |
| `DD-0002-GAP-006` | What `TR-5` Parent is shown instead of member detail | ⚠️ **NON-BLOCKING** | Product Owner | ⭐ `SM-8.4a` is an **interim deny** and `SM-GAP-4` is open; ⛔ any wording would imply a roadmap |
| `DD-0002-GAP-007` | Whether `AsOfLabel` (per-section) and `StaleDataBanner` (per-screen) should be unified | ⚠️ **NON-BLOCKING** | ⭐ Design System Owner | ⭐ §18 divergence 1 — both are requirement-driven; unification is a foundation call |
| `DD-0002-GAP-008` | Whether `BC-01`'s ~86% 2D allocation is an accepted departure from the 70/20/10 band | ⚠️ **NON-BLOCKING** | ⭐ Design System Owner | ⭐ §8.2 records the reason; ⛔ the departure is **not self-approved** |
| `DD-0002-GAP-009` | *"enrollment"* vs *"enrolment"* in user-facing copy | ⚠️ **NON-BLOCKING** | Content Owner | ⛔ Identifiers **MUST NOT** change; only copy is in scope |
| ⭐ `DD-0002-GAP-010` | How the **7** `app` tasks reach `domain/library` — port adapter, or rebuild `students_page.dart` | ⚠️ **NON-BLOCKING** *(for design)* | ⭐⭐ Architecture Owner | ⭐ §17.1. ⛔ The manifest declares a **port**; ⛔ no adapter exists; ⛔ `TASK-D10` does not clear this surface's 2 violations |
| ⛔⛔ `DD-0002-GAP-011` | ⭐ `StudentRecord.dateOfBirth` is non-nullable, making `SM-4.5a`'s `Unknown` case **unrepresentable** | ⛔⛔ **REQUIREMENT CONFLICT** | ⭐⭐ Architecture + Domain Owner | ⭐ `IDV-012`. ⛔ A frozen Rank-3 PRD versus shipped code. ⛔ **Not a design defect and not fixable by design** |
| ⛔⛔ `DD-0002-GAP-012` | ⭐ `StudentRecord` stores `fullName`/`phone`/`email`/`dateOfBirth`, which `SM-4.2` assigns to `BC-10` | ⛔⛔ **REQUIREMENT CONFLICT** | ⭐⭐ Architecture + Domain Owner | ⭐ `IDV-013`. ⛔ Same class as above |

⭐⭐ **BLOCKING: 0 · NON-BLOCKING: 10 · REQUIREMENT CONFLICT: 2 ·
TO-BE-DECIDED: 0.**

⚠️ **Why the two conflicts are not BLOCKING for *this document*.** They
block **implementation**, not design: every surface here is specified
against the **frozen PRD**, which is the higher authority. ⭐ A design that
matched the code instead would be the defect. ⛔ But they **must** be
resolved before `BC-01` surfaces are built, and ⛔ neither is resolvable
by a designer.

---

## 21. Readiness verdict

⚠️ Judged against usability, psychology, accessibility, performance,
consistency, requirements and feasibility — ⛔ **not** against
attractiveness.

### 21.1 Figma prototyping — ⭐ **READY WITH NON-BLOCKING GAPS**

A prototype can be built without inventing UX: **14** surfaces, **7**
states each, **5** flows with branch conditions, **14** component mappings,
**12** permission presentation rules, motion classes with purpose, and an
explicit 2D/2.5D/3D allocation.

⚠️ **Two substitutions the prototyper must make explicitly, not silently**
— ⭐ identical to `DD-0001` §19.1, so ⛔ no new licence is created:

| Missing | Instruction |
|---|---|
| Token values (`GAP-002`) | ⭐ Use `theme.dart`'s **observed** values as a **labelled placeholder**. ⛔ Do **not** present them as approved tokens |
| Breakpoints (`GAP-004`) | ⭐ Prototype at **one** narrow phone width, labelled *reference width*. ⛔ Do **not** invent a tablet breakpoint |

⛔ **Prototype nothing from:** `SM-GAP-5` (tags/notes), `SM-GAP-8`
(import), `SM-GAP-9` (attendance percentage), `SM-GAP-7` (member-to-member
directory), `SM-GAP-1` (retention), `SM-GAP-6` (emergency contact),
`DD-0002-GAP-006` (Parent copy). ⭐ And ⛔ **do not prototype an `Inactive`
seating consequence** — `SM-GAP-3` leaves it unspecified (§2).

⭐⭐ **Why this is `READY WITH NON-BLOCKING GAPS` and not `READY`:** the 10
non-blocking gaps do not stop a prototype, but a prototype built today
carries **two labelled placeholders**, and calling that unqualified
`READY` would overstate it.

### 21.2 Technical Specification — ⚠️ **NOT READY, and a TS is not blocked by this**

A `TS-*` for `BC-01` would satisfy `E-1` (PRD frozen, `ADR-0018`), `E-2`
(Stage 3 passed), `E-3` (ADRs identifiable: `ADR-0011`/`0013`/`0016`/
`0018`) and `E-4`'s second limb (**11** `SM-GAP-*` registered with
owners). ⛔ **But this Design Doc confers nothing toward it**: Stage `6A`
requires an **ADR-borne conferral**, and a Design Doc is ⛔ **UNRANKED
input, never authority**. ⛔⛔ **No `TS-003` is created, implied,
authorised, allocated or reserved.**

### 21.3 Definition-of-Done check

| Criterion | Met? |
|---|---|
| Relevant PRD requirements classified | ⭐ **YES** — 35/35 `LMD-*`, 12/12 `SM-PO-*`, 16/16 edge cases, 16/16 `SM-BR-*` |
| Primary flows mapped | ⭐ **YES** — 5 |
| Important surfaces inventoried | ⭐ **YES** — 14 |
| Applicable states defined | ⭐ **YES** — 7 × 14 |
| Dependencies documented | ⭐ **YES** — 10 contexts, §6.3 |
| Components mapped | ⭐ **YES** — 7 existing + 7 new, ⭐ 5 reused from `DD-0001` |
| Gaps classified | ⭐ **YES** — 12, each with class + owner |
| Traceability complete | ⭐ **YES** — §19 |
| Design QA criteria exist | ⭐ **YES** — 12 blocking conditions |
| ⭐ **No BLOCKING design issue remains** | ⭐⭐ **YES — 0 BLOCKING** |

### 21.4 Honest weaknesses

1. ⛔ **Unvalidated with real users.** No usability testing of the
   reception-desk flow, no research artifact. Every §2 row is a *reasoned
   response to a recorded constraint*, ⛔ **not** a validated finding.
2. ⛔ **Accessibility unverifiable** while the standard is undecided — and
   the codebase baseline is measurably **1** widget test repo-wide.
3. ⛔⛔ **Two requirement conflicts stand between this design and any
   implementation** (`GAP-011`, `GAP-012`), and ⛔ neither is mine to
   resolve.
4. ⚠️ **The existing surface diverges from `PRD-004` in 10 measured ways**
   (§6.2). ⭐ Recorded, ⛔ not fixed, ⛔ not silently designed around.
5. ⚠️ **`LMD-8`/`LMD-12`'s server-side obligations are honoured only
   negatively** in design — by ⛔ never filtering or searching
   client-side. ⭐ Whether the backend satisfies them is outside a Design
   Doc's reach.
6. ⚠️ **§8.2's ~86% 2D departs from the CONFIRMED band.** Reasoned and
   routed (`GAP-008`), but ⛔ **not approved**.
7. ⚠️ **`AsOfLabel` extends `DD-0001`'s staleness pattern** rather than
   matching it (§18). Recorded as `GAP-007`; a reviewer may legitimately
   prefer unification.

---

## 22. Review triggers

⭐ This document **MUST** be revisited when any of the following occurs.
⛔ It does **not** update itself.

| Trigger | Effect |
|---|---|
| `PRD-004` is amended past v1.2 | Re-verify §19; every `LMD-*`/`SM-*` citation re-measured |
| ⭐ Any `SM-GAP-*` is resolved | ⭐ A resolved `SM-GAP-5`/`7`/`8`/`9` may **add surfaces** that ⛔ deliberately do not exist today |
| `DBT-001` tokens ratified | §8.3/§8.4 become specifiable; §21.1's substitution 1 closes |
| `DBT-002` breakpoints decided | §12 becomes specifiable; substitution 2 closes |
| Accessibility standard chosen | §11 becomes verifiable |
| ⭐ `GAP-011`/`GAP-012` resolved | ⭐⭐ May change S-5 and S-7 materially — the `Unknown` path depends on a nullable DOB existing |
| ⭐ `ADR-0012` §3.4 / `GAP-010` resolved | §17.1 is re-measured; `app` surface work becomes buildable |
| `DD-0001` is revised | §18 re-checked in both directions |
| `TR-5` Parent authorisation defined (`SM-GAP-4`) | §4.1 and §14.3 gain a real surface |
| A `TS-*` is admitted for `BC-01` | §21.2 re-stated |

---

## 23. Changelog

| Version | Change |
|---|---|
| **v0.1** | ⭐ Created. Readiness audited across **21** areas (**DONE 14 · PARTIAL 6 · BLOCKED 0**) and classified ⭐ **READY WITH EXPLICIT DESIGN GAPS**. ⭐⭐ Established that `PRD-004` **is** designable despite **0** literal `UI`/`UX` occurrences, on **35** `LMD-*` display requirements, a closed **12×5** permission matrix and **16** pre-specified edge cases — correcting [`../README.md`](../README.md) §2A.3's *"**0**"* entry for this context only. **14** surfaces `S-1`…`S-14`; **7** states each *(adds `Unavailable` over `DD-0001`'s six, per `LMD-18`/`LMD-21`)*; **5** flows; **7** existing + **7** new components with ⭐ **5 reused from `DD-0001`**; ⭐ **0** 3D assets, reasoned; **12** Design QA blocking conditions; **12** gaps — ⭐⭐ **0 BLOCKING**, **10** non-blocking, **2** `REQUIREMENT CONFLICT` escalated to Architecture + Domain Owner. Existing implementation audited: **1 MATCH · 10 IMPLEMENTATION DEVIATION · 2 REQUIREMENT CONFLICT · 2 DESIGN GAP**. ⛔ **Nothing invented:** 0 requirements, 0 tokens, 0 breakpoints, 0 accessibility thresholds, 0 permissions, 0 surfaces beyond `PRD-004`, and ⛔ **0 surfaces for any of the 11 `SM-GAP-*`**. ⛔ No PRD, ADR, architecture document, TS, code, test or `DD-0001` modified |
| **v0.1a** | ⚠️⚠️ **Factual correction, self-reported.** v0.1 stated in two places that **`PRD-006` is *"unwritten"***, citing `SM-GAP-9`. ⛔ **Both statements were false and the citation was over-read.** ⭐ Measured: `PRD-006_ATTENDANCE-MANAGEMENT.md` is **`FROZEN` v1.9**, **Rank 3**, **3216 lines**, admitted by **`ADR-0034`** under `BASELINE-2026-08-05-A`, carrying **525** identifiers. ⭐ `SM-GAP-9` says only that the attendance-**percentage formula** has no owner — ⛔ **not** that the PRD is absent. ⭐⭐ **The design conclusion is UNCHANGED and now rests on stronger authority**: `PRD-006` **`NG-6`** makes *"reports, percentages, streaks, dashboards"* an express **non-goal** owned by **`BC-26` Analytics**, and **L2278** forbids `BC-03` becoming *"the source for any attendance percentage, streak"* — so ⛔ **no percentage and no `MeterBar`** is a **prohibition**, not an absence. §2, §6.3 and §9.1 corrected; ⛔ **no surface, state, component, flow, gap or coverage classification changed.** ⛔ Nothing else in this document is affected, and ⛔ no PRD, ADR, code or test was modified |
