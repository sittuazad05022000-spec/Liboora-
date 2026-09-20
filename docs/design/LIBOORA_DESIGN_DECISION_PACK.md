<!-- LIBOORA Design Documentation | Decision Pack | 2026-09-19 -->

> Design documentation. ⛔ Does **not** amend PRDs, ADRs, permissions, roles, app
> boundaries, BC ownership or backend contracts.

# LIBOORA Design Decision Pack — 10-expert review

| Field | Value |
|---|---|
| **Status** | ⛔⛔ **PROPOSED** · ⛔ **0 approvals recorded** |
| **Companion** | [`LIBOORA_MASTER_DESIGN_SYSTEM.md`](LIBOORA_MASTER_DESIGN_SYSTEM.md) · [`LIBOORA_UIUX_PRO_MAX_RULES.md`](LIBOORA_UIUX_PRO_MAX_RULES.md) |
| **Approval authority** | ⭐ **Founder/Product Authority** *(`DESIGN_GOVERNANCE.md` L9–L10)* |
| **Method** | Repository evidence **first**; UI/UX Pro Max `15de38f` as **design intelligence only** |

---

## 1. The ten expert conclusions

### 1 · UX Architect
⭐ **Liboora is three task-shaped products, not one app with role switches.** The
**3-app boundary is INHERITED** and load-bearing: APP 1 serves a student checking a seat;
APP 2 serves a reception desk under queue pressure; APP 3 is a **read-only** platform
view. ⛔ **Merging them would create exactly the mixed-role UI the brief forbids.**
⭐ **Conclusion:** navigation, density and tone must diverge **per app**; components stay
shared.

### 2 · Product Designer
⭐ The product's job is **throughput under pressure**. The measured screens
*(reception desk 362 lines, students 487, student dashboard 549)* confirm list-and-detail
work, ⛔ not browsing. ⭐ **Conclusion:** optimise the **check-in path** and the **money
path**; everything else is secondary. ⚠️ ⛔ **Money must never appear on seat surfaces** —
`SEAT-FR-279` forbids it in terms, and the code already complies *(0 monetary references
in `seat_map_page.dart`)*.

### 3 · UI / Visual Designer
⭐ **The indigo is right; the amber is being misused.** `#2D3E8F` measures **9.56:1** on
white — serious and institution-appropriate. ⚠️⚠️ **`#F5A524` measures 2.04:1** — it
cannot carry text, and **white on amber is unusable**. ⭐ **Conclusion:** keep indigo,
**split amber into `accent-fill` (fills, paired with dark ink at 8.42:1) and `accent-ink`
(a darkened variant, TBD)**.

### 4 · Design System Architect
⚠️⚠️ **The system's real defect is not missing values — it is missing *authority*.**
`DESIGN_SYSTEM.md` exists with 24 sibling documents; the tokens are marked
**"TO BE DECIDED"** while `theme.dart` already defines 12 colours and 6 spacing steps.
⭐ **Conclusion:** adopt **Primitive → Semantic → Component** layering and give the Design
System Owner a **one-session ratification**. ⛔ **I must not transcribe the code values
myself — `DESIGN_DEBT.md` rule 5 names that exact act as forbidden.**

### 5 · Accessibility Expert
⭐ **Three measured failures, not opinions:** `accent` **2.04:1** ⛔ · `textMuted`
**4.48:1 on surface** ⛔ · white-on-amber **2.04:1** ⛔. ⭐ **Conclusion:** adopt
**48dp** targets *(Android — the skill's own guidance, ⛔ not the web-only 24px figure)*,
**4.5:1** text, **2dp** visible focus, **200%** text scale, and ⭐⭐ **icon + text for every
status**. ⚠️ **`ACCESSIBILITY.md` L26 still says "TO BE DECIDED" — only the Accessibility
Owner can change that.**

### 6 · Responsive Design Expert
⭐ **Breakpoints must be justified, not copied.** ⭐ **Conclusion:** **< 600dp**,
**600–904dp**, **≥ 905dp** — the **Material 3 window size classes**, an external citable
standard appropriate to a Flutter/Android product. ⚠️ **CONFLICT:** the skill's
`375/768/1024/1440px` web checklist is ⛔ **not adopted** — those are CSS pixels.
**LIBOORA/Flutter preserved.**

### 7 · Mobile Performance Expert
⛔⛔ **Glassmorphism must be rejected outright.** The skill's own metadata rates it
`accessibility risk:conditional` and it requires **10–20px backdrop blur** — a per-frame
GPU cost on the ₹8,000 Android phone that is the stated target. ⭐ **Conclusion:** flat +
hairline + one shadow level; ⭐ **skeletons that reserve exact space** *(CLS)*; ⭐
virtualised lists; ⭐ **offline with an explicit staleness stamp**. ⛔ Numeric SLOs stay
**TO BE DECIDED** — they belong to the absent `NFR Budgets (V1)`.

### 8 · Information Architect
⭐ **Every number must carry its scope.** An unqualified "42" on a dashboard is a defect —
42 *what*, *where*, *when*? ⭐ **Conclusion:** dashboards are **worklists**, KPI cards
**3–5 max**, each stating tenant/branch/period. ⭐ Defer grouping and labels to
`INFORMATION_ARCHITECTURE.md`.

### 9 · Figma / Handoff Expert
⭐ `FIGMA_FOUNDATION.md` already fixes file structure, naming, libraries, component
anatomy, variables and handoff. ⭐ **Conclusion:** ⛔ **do not invent a second Figma
model** — add only the page list and bind Figma Variables to the §3–§9 tokens **once
ratified**. ⛔ **No Figma file is created in this phase.**

### 10 · Design QA & Governance Expert
⭐⭐ **The decisive finding of this review:** ⛔ **three of the four `DD-0007` Figma
blockers are not governance blockers at all** — they are design-ownership decisions.
⭐⭐ **Even authorizing all 19 held BC-25 parameters would not make `DD-0007`
design-ready.** ⭐ **Conclusion:** four owner decisions — tokens, a11y minimums,
breakpoints, `C-4`'s reader — unblock more than the entire BC-25 chain. ⭐ And every
screen must declare **App + Role + Scope + Permission source + Cross-app dependency**;
⛔⛔ **UI visibility is never evidence of authorization** *(`AP-3`)*.

---

## 2. Consolidated design direction

⭐⭐ **"Calm Operational Density"** — `data-dense-dashboard` structure *(the skill's
retried result: `performance cost:low`, `accessibility risk:low`)*, **softened** for a
mixed-literacy, glare-lit, shared-device Indian context:

- ⭐ **16px base type** *(⛔ not the style's 12–14px)* · tabular numerals for all figures
- ⭐ Flat surfaces, hairline borders, **one** soft elevation
- ⭐ Indigo `#2D3E8F` as the trust anchor; amber **split** into fill vs ink
- ⭐ **48dp** touch targets inside dense layouts
- ⭐ Status = **icon + text**, always
- ⭐ Offline and stale data shown **honestly**

---

## 3. Major decisions proposed

| # | Decision | Status |
|---|---|---|
| 1 | ⛔ **REJECT Glassmorphism**; adopt `data-dense-dashboard` softened | ⭐ PROPOSED |
| 2 | ⭐ **KEEP indigo `#2D3E8F`** *(9.56:1)* | ⭐ PROPOSED |
| 3 | ⚠️ **SPLIT amber** → `accent-fill` + `accent-ink` *(TBD)* | ⭐ PROPOSED |
| 4 | ⚠️ **DARKEN `textMuted`** until ≥4.5:1 **on surface** | ⭐ PROPOSED |
| 5 | ⭐ 4px spacing base; ⭐ **add `space/5`=20, `space/12`=48** | ⭐ PROPOSED |
| 6 | ⭐ Radius **8/12/16**; ⛔ **retire 14 and 18** | ⭐ PROPOSED |
| 7 | ⭐ **Three** elevation levels only | ⭐ PROPOSED |
| 8 | ⭐ **48dp** Android touch target | ⭐ PROPOSED |
| 9 | ⭐ **600 / 905dp** Material window classes | ⭐ PROPOSED |
| 10 | ⭐ Base **16px**, min 12px, **200%** scaling | ⭐ PROPOSED |
| 11 | ⭐ Motion 150/200/300ms; ⛔ no loops; reduced-motion honoured | ⭐ PROPOSED |
| 12 | ⭐ **Nine** mandatory component states incl. `read-only` | ⭐ PROPOSED |
| 13 | ⭐ Tokens via Flutter **`ThemeExtension`** | ⭐ PROPOSED |

---

## 4. Conflicts recorded — ⭐ LIBOORA preserved in every case

| # | Conflict | Resolution |
|---|---|---|
| **C-1** | ⚠️⚠️ Skill's `--design-system` returned **Glassmorphism + marketing hero** | ⛔ **REJECTED** — wrong product class, blur cost, brief forbids it, `risk:conditional`. ⭐ Retried per the skill's own contract |
| **C-2** | ⚠️ Skill breakpoints **375/768/1024/1440 px** | ⛔ **NOT ADOPTED** — CSS pixels; ⭐ **Material dp window classes** used |
| **C-3** | ⚠️ Skill's `data-dense` prescribes **12–14px** type | ⛔ **NOT ADOPTED as base** — ⭐ 16px; 12–14px survives as metadata only |
| **C-4** | ⚠️⚠️ **`theme.dart` defines tokens the design system calls "TO BE DECIDED"** *(`DBT-001`)* | ⛔ **NOT resolved here** — ⭐ `DESIGN_DEBT` rule 5 reserves it to the **Design System Owner** |
| **C-5** | ⚠️ Skill's touch guidance offers **44pt / 48dp / 24px** | ⭐ **48dp** — Android-first; ⭐ the skill itself warns the web figure is not native conformance |
| **C-6** | ⚠️ Radius **14** and **18** exist in code with no rationale *(`DBT-005`)* | ⭐ **PROPOSED** for retirement — ⛔ owner decides |

---

## 5. Open decisions

⛔ **9 open**, each with a named office — see `LIBOORA_MASTER_DESIGN_SYSTEM.md` §24.
⭐ The four that unblock the Figma gate: **tokens** *(Design System Owner)*, **a11y
minimums** *(Accessibility Owner)*, **breakpoints** *(Responsive Design Owner)*,
**`C-4` reader** *(Authorization Owner + `PRD-016` Owner)*.

---

## 6. Decisions requiring human approval

⛔⛔ **Every decision in this pack.** ⭐ `DESIGN_GOVERNANCE.md` L10: *"AI authors and
reviews; **AI is not final business authority**."* ⭐ Nothing here is self-approving, and
⛔ **no `DD7-GAP-*` is closed by this pack.**

---

## 7. Next implementation sequence

| Step | Act | Owner | Unblocks |
|---|---|---|---|
| **1** | ⭐ Ratify or amend **§3–§9 tokens** *(one session)* | **Design System Owner** | `DD7-GAP-007`, `DBT-001`, `DBT-005` |
| **2** | ⭐ Adopt **a11y minimums** | **Accessibility Owner** | Half of `DD7-GAP-009` |
| **3** | ⭐ Adopt **breakpoints** | **Responsive Design Owner** | Half of `DD7-GAP-009` |
| **4** | ⭐ Create **`NFR Budgets (V1)`** with numeric SLOs | **Governance + Design Performance Owner** | Closes `DD7-GAP-009` |
| **5** | ⭐ Decide **`C-4`'s reader**, or drop `C-4` | **Authorization Owner + `PRD-016` Owner** | `DD7-GAP-008` |
| **6** | ⭐ Then: component specs → Figma → `C-1`/`C-2`/`C-3`/`C-5` design | Design System + UX Owners | The Figma gate |

⭐⭐ **Steps 1–3 are a single working session and clear three of the four Figma blockers.**
⛔ **None of them requires any of the 19 held BC-25 parameters.**

---

*End. ⛔⛔ **PROPOSED — NOT APPROVED.***
