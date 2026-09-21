<!-- LIBOORA Design Documentation | Design Decision Records | 2026-09-19 -->

> This document is design governance and documentation. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles or
> backend contracts.

# DDR-0001 … DDR-0009 — Founder/Product Authority decisions

| Field | Value |
|---|---|
| **Register** | ⭐ Filed under [`design-decisions/README.md`](README.md) §2's **required template** and §4 filing rules |
| **Date** | 2026-09-19 |
| **Approver** | ⭐⭐ **Founder/Product Authority** *(`README.md` §1: *"Founder/Product Authority for product direction"*; `DESIGN_GOVERNANCE.md` §3 rule 6)* |
| **Source of the decisions** | ⭐ A **human decision instruction** answering [`LIBOORA_HUMAN_DECISION_SHEET.md`](../LIBOORA_HUMAN_DECISION_SHEET.md) |
| **Change class** | ⭐ **D2 — Design-system change** *(`DESIGN_CHANGE_MANAGEMENT.md` §1)*, except `DDR-0008` which is **D5** and `DDR-0002` which carries a **D5 limb** |
| ⛔ **What this file does NOT do** | ⛔ It does **not** edit `DESIGN_SYSTEM.md`, `ACCESSIBILITY.md` or `PERFORMANCE.md`. ⭐ Those amendments are **their owners' acts** *(`DESIGN_DEBT.md` rule 5)*. ⭐ This is the **decision record**; ⭐ the foundation edits are **`DDR-0010` onward**, ⛔ not taken here |

> ⭐⭐ **Recording discipline.** ⭐ Each record states the decision **as given**, ⛔ adds no
> requirement, ⛔ invents no permission, role or scope, and ⭐ marks status exactly as the
> authority's words support. ⚠️ **Where the instruction's condition had to be *tested*
> rather than assumed, the test and its result are recorded** *(`DDR-0008`)*.

---

## DDR-0001 — Colour tokens

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED** |
| **Date** | 2026-09-19 |
| **Owner** | Design System Owner |
| **Approver** | ⭐ Founder/Product Authority |
| **Scope** | Colour foundation — all apps |
| **Source references** | `LIBOORA_DESIGN_CLOSURE_PACK.md` D-1 · `LIBOORA_MASTER_DESIGN_SYSTEM.md` §3 · `lib/app/shared/theme.dart` · WCAG 2.1 SC 1.4.3, 1.4.11 |
| **Decision** | ⭐ **ACCEPT the proposed values:** `accent-ink` **`#92400E`** *(new — text/icons)* · `accent-fill` **`#F5A524`** *(retained — **fills only**, always paired with `textPrimary #14183A`)* · `text-muted` **`#5F6585`** *(replaces `#6B7194`)* · `border/decorative` **`#E3E6F0`** *(retained)* · `border/control` **`#7F87A6`** *(new)* · ⭐ **7 tokens unchanged**: `brand`, `brandDark`, `success`, `warning`, `danger`, `info`, `textPrimary` |
| **Alternatives** | ⛔ `#B45309` for `accent-ink` — **rejected**: byte-identical to the existing `warning` token, a semantic collision *(`DESIGN_GOVERNANCE.md` §3 rule 4)* · ⛔ single `border` token — **rejected**: `#E3E6F0` measures **1.17:1**, lawful for decorative dividers but failing WCAG 1.4.11's **3:1** for control boundaries |
| **Consequences** | ⭐ **Accessibility:** fixes **3 measured failures** *(`accent` 2.04, `text-muted` 4.48 on surface, white-on-amber 2.04)* · ⭐ **Experience:** amber becomes a celebration **fill** — streaks, milestones — instead of failing as small text · ⚠️ secondary text and control borders read **heavier** · ⭐ **Performance:** none · ⭐ **Governance:** ⛔ `theme.dart` is **not** thereby ratified — ⭐ the code must be **brought to** these values, ⛔ not the reverse |
| **Open questions** | ⭐ Amending `DESIGN_SYSTEM.md` §2 and closing **`DBT-001`** — **Design System Owner** |
| **Review trigger** | Any new surface colour; any WCAG version change; dark-mode introduction |

⚠️⚠️ **Note for implementation:** ⭐ `theme.dart` currently holds `#6B7194` and has **no**
`accent-ink` or `border/control`. ⭐ Bringing code to these values is a **separate
engineering task**, ⛔ **not performed here.**

---

## DDR-0002 — Indic / Devanagari support and typeface strategy

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED** *(the requirement)* · ⛔ **TO BE DECIDED** *(the specific family)* |
| **Date** | 2026-09-19 |
| **Owner** | Design System Owner |
| **Approver** | ⭐ Founder/Product Authority |
| **Scope** | Typography foundation — all apps |
| **Source references** | `LIBOORA_HUMAN_DECISION_SHEET.md` D-2 · `MP-CON-12` *(India-first)* · `ACCESSIBILITY.md` §3 · `DESIGN_DEBT.md` `DBT-003` |
| **Decision** | ⭐⭐ **YES — V1 MUST support Indic/Devanagari student names.** ⭐ The font strategy **MUST guarantee proper Indic rendering.** ⭐ Consequently the shortlist reduces to a family with **matched Devanagari coverage**; ⭐ **Noto Sans + Noto Sans Devanagari** *(SIL OFL)* is the only candidate satisfying the pairing criterion **by construction**. ⛔ **The final family is NOT selected here** |
| **Alternatives** | ⛔ **Inter alone** — now **disqualified**: no Devanagari · ⚠️ **Inter + a separate Devanagari companion** — permitted **only** if x-height and weight are verified to match · ⚠️ **Lexend** — Devanagari coverage **unverified** |
| **Consequences** | ⭐⭐ **Experience:** removes the worst student-facing failure mode — a student seeing their own name as **tofu boxes (□□□)** on their personal dashboard · ⚠️ **Performance:** bundling a second script costs app size on low-end Android — ⭐ **mitigate by subsetting**; ⭐ the budget is governed by `DDR-0006` · ⭐ **Accessibility:** numeral disambiguation *(`0/O`, `1/l/I`)* remains a selection criterion for seat and enrollment numbers |
| ⚠️ **Open questions** | ⭐⭐ **A distinction this record preserves rather than blurs:** ⭐ this decision is about **SCRIPT RENDERING** — displaying a name as it was entered. ⛔ It is **NOT** a decision to **localize the UI** into Hindi. ⭐ `ACCESSIBILITY.md` §3 still reads *"Exact supported languages are **TO BE DECIDED**"*, and **`DBT-003`** records **0** occurrences of `flutter_localizations` / `intl` / `AppLocalizations`. ⛔ **Both remain open and are NOT closed by this record.** *(Owners: **Product Owner** for languages; **Technical Owner** for the i18n stack.)* · ⭐ Final family + licence review — **Design System Owner** + **Design Governance Owner** |
| **Review trigger** | Family selection; any additional script *(Tamil, Bengali, Telugu…)*; any UI-localization decision |

---

## DDR-0003 — Radius scale

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED** |
| **Date** | 2026-09-19 · **Owner** Design System Owner · **Approver** ⭐ Founder/Product Authority |
| **Scope** | Shape foundation — all apps |
| **Source references** | `LIBOORA_DESIGN_CLOSURE_PACK.md` D-3 · `lib/app/shared/theme.dart` *(7 `BorderRadius.circular()` calls, 3 values)* · `DESIGN_DEBT.md` `DBT-005` |
| **Decision** | ⭐ **ACCEPT `sm` = 8 · `md` = 12 · `lg` = 16.** ⛔ **Retire 14 and 18.** ⭐ Pill reserved for **status chips only** |
| **Alternatives** | ⛔ Retain 14/18 — rejected: single-use near-duplicates with **no documented rationale** · ⛔ Adopt a 4-step scale — rejected: unnecessary |
| **Consequences** | ⭐ Consistency lets layered 2.5D cards read as **one** system · ⭐ Affects **2** call sites · ⭐ Performance/accessibility: **none** · ⭐ Enables a `LiblRadius` class, ⛔ which does not yet exist |
| **Open questions** | ⭐ Authoring `LiblRadius` and closing **`DBT-005`** — **Design System Owner** → Technical Owner |
| **Review trigger** | Any new component needing a radius outside 8/12/16 |

---

## DDR-0004 — Accessibility minimums

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED** |
| **Date** | 2026-09-19 · **Owner** Accessibility Owner · **Approver** ⭐ Founder/Product Authority |
| **Scope** | Accessibility floor — **all apps, no exceptions** |
| **Source references** | `LIBOORA_DESIGN_CLOSURE_PACK.md` D-4 · WCAG 2.1 SC 1.4.3 / 1.4.4 / 1.4.11 / 2.3.3 / 2.4.7 · UI/UX Pro Max `15de38f` *("44pt on iOS and **48dp on Android**")* · `ACCESSIBILITY.md` |
| **Decision** | ⭐ **ACCEPT:** **≥48×48dp** touch targets · **≥8dp** target spacing · **4.5:1** normal-text contrast · **3:1** large-text and non-text · **2dp** visible focus, **never removed** · functional at **200%** text scale · ⭐⭐ **every status carries icon + text**, ⛔ never colour alone · **reduced motion honoured** with a static final state |
| **Alternatives** | ⛔ **24 CSS px** *(WCAG 2.2 web target size)* — rejected: **web-only**; the skill itself warns *"Don't assume native 44pt or 48dp guidance defines web conformance"*, and the converse holds · ⛔ 44pt — iOS figure; Liboora is Android-first |
| **Consequences** | ⚠️⚠️ **The stated tradeoff is accepted:** 48dp costs vertical space ⇒ **fewer rows per screen**. ⭐ **Resolution: ≥48dp on touch; the denser 36px row is permitted only on pointer-only ≥905dp** · ⭐ **Measured driver for the icon+text rule:** `success` and `warning` have **identical luminance (5.02/4.73)** — ⭐ distinguishable by hue alone, ⛔ so colour can never carry status |
| **Open questions** | ⭐ Amending `ACCESSIBILITY.md` §2 to replace *"exact minimum values are TO BE DECIDED"* — **Accessibility Owner** |
| **Review trigger** | WCAG version change; any request for a sub-48dp control |

---

## DDR-0005 — Responsive breakpoints

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED** |
| **Date** | 2026-09-19 · **Owner** Responsive Design Owner · **Approver** ⭐ Founder/Product Authority |
| **Scope** | Layout foundation — all apps |
| **Source references** | `LIBOORA_DESIGN_CLOSURE_PACK.md` D-5 · Material 3 window size classes · `DESIGN_DEBT.md` `DBT-002` |
| **Decision** | ⭐ **ACCEPT: < 600dp** *(compact)* · **600–904dp** *(medium)* · **≥ 905dp** *(expanded)* |
| **Alternatives** | ⛔ **375/768/1024/1440 px** *(UI/UX Pro Max)* — rejected: **CSS pixels for web**; Liboora is Flutter/Android **dp**. ⭐ **CONFLICT recorded, LIBOORA preserved** *(`LIBOORA_UIUX_PRO_MAX_RULES.md` §6)* |
| **Consequences** | ⭐ Most students are **< 600dp** ⇒ ⭐⭐ **the single-column student experience is the primary design**, ⛔ not a shrunken tablet layout · ⭐ Two-pane only at **≥905dp**, via the existing `LayoutBuilder` pattern · ⭐ Prevents horizontal-scroll failures |
| **Open questions** | ⭐ A responsive artifact still does not exist — **`DBT-002`**, **Responsive Design Owner** |
| **Review trigger** | Material window-class revision; a new form factor |

---

## DDR-0006 — V1 performance target *(provisional)*

| Field | Value |
|---|---|
| **Status** | ⚠️⚠️ **PROPOSED — provisional target, ⛔ NOT an approved device profile** |
| **Date** | 2026-09-19 · **Owner** Design Performance Owner · **Approver** ⛔ **PENDING — Technical Owner** |
| **Scope** | Performance floor — all apps |
| **Source references** | `LIBOORA_HUMAN_DECISION_SHEET.md` D-6 · `MP-CON-12` · `PERFORMANCE.md` L8 · `MASTER_PRD` L663 · `MP-DEP-08` |
| **Decision** | ⭐⭐ **The inferred profile — Android 8.0 (API 26) / 2 GB RAM / 720×1600 / intermittent 3G — is ⛔ EXPRESSLY NOT APPROVED AS FACT.** ⭐ It is adopted **only as a conservative performance target** for design work, ⛔ **until the Technical Owner confirms the official V1 device profile** |
| **Alternatives** | ⛔ Approving the inference as fact — **rejected by the authority**, ⭐ correctly: it was an inference from `MP-CON-12`'s India-first posture, ⛔ **not a repository fact** · ⛔ Proceeding with no target — rejected: the 2.5D/3D budget would be unenforceable |
| **Consequences** | ⭐⭐ **Design may proceed** against a conservative target · ⛔⛔ **No numeric SLO may be published as authoritative** — `NFR Budgets (V1)` still does not exist *(`DD7-GAP-009` remains **OPEN**)* · ⭐ `DDR-0010`'s 2.5D/3D budget is **validated against this provisional target only** · ⚠️ If the confirmed profile is **weaker**, the 3D budget must shrink; ⭐ if **stronger**, it may grow |
| **Open questions** | ⭐⭐ **Confirm the official V1 device profile — Technical Owner** · ⭐ Then create **`NFR Budgets (V1)`** with numeric SLOs — **Governance Owner + Design Performance Owner** |
| **Review trigger** | ⭐ Technical Owner confirmation; any measured frame drop on the target class |

---

## DDR-0007 — Dark mode

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED** |
| **Date** | 2026-09-19 · **Owner** Design Vision Owner · **Approver** ⭐ Founder/Product Authority |
| **Scope** | Theming — all apps |
| **Source references** | `LIBOORA_DESIGN_CLOSURE_PACK.md` D-7 · `LIBOORA_MASTER_DESIGN_SYSTEM.md` §3.3 |
| **Decision** | ⭐ **Dark mode is NOT in V1.** ⭐⭐ **The architecture MUST remain extensible for future dark mode** |
| **Alternatives** | ⛔ Ship dark mode in V1 — rejected: no source requires it; cost now exceeds value · ⛔ Ignore dark mode entirely — **rejected by the authority**: extensibility is required |
| **Consequences** | ⭐⭐ **The extensibility clause is binding and has a concrete meaning:** ⛔ **no raw hex may be written in a component** — ⭐ every colour resolves through a **semantic token** *(`LIBOORA_MASTER_DESIGN_SYSTEM.md` §3.3)*, so a later dark theme is a **remap, not a rewrite** · ⚠️ **Honest cost:** students study at night and will notice the absence · ⭐ Meanwhile 200% scaling and 4.5:1 contrast serve low-vision users |
| **Open questions** | ⭐ Dark-mode palette derivation — **deferred**, Design System Owner |
| **Review trigger** | ⭐ Any request for dark mode; ⭐⭐ **any raw hex found in a component — that breaches the extensibility clause** |

---

## DDR-0008 — `C-4` Change history removed from V1

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED** — ⭐ **condition tested and satisfied** |
| **Date** | 2026-09-19 · **Owner** UX Architecture Owner · **Approver** ⭐ Founder/Product Authority |
| **Change class** | ⚠️ **D5-adjacent** — ⭐ but it **removes** a design surface, ⛔ **allocates nothing** |
| **Scope** | `DD-0007` surface `C-4` — **APP 2** |
| **Source references** | `LIBOORA_HUMAN_DECISION_SHEET.md` D-8 · `DD-0007` §21, `DD7-GAP-008` · `CNF-FR-060` · `CNF-BR-006` · `CNF-AC-044` · `CNF-XC-010` · `AUTH-10.23` · `AUD-FR-014`/`015`/`016` · `AUD-XC-005` |
| **Decision** | ⭐ **REMOVE `C-4` from V1**, the instruction's condition being *"unless an authorized requirement explicitly requires a BC-25 audit-reading surface."* |
| ⭐⭐ **The condition, TESTED — ⛔ not assumed** | ⭐ Measured across `PRD-023`: **`CNF-FR-060`** requires a write to ***emit*** an audit fact — ⛔ **it does not require reading one** · **`CNF-BR-006`** is expressly ***a subtraction***: *"Configuration history **SHALL** be reconstructible from the audit trail. The module **SHALL NOT** maintain a second, independent version history of its own"* · **`CNF-AC-044`** confirms *"no second version history exists in this module"* · **`CNF-XC-010`** bars `BC-25` from a query surface · ⭐⭐ **Grep for a requirement mandating a history/change-log/audit-view SURFACE returned ZERO.** ⭐ **Condition satisfied: no authorized requirement requires it** |
| **Alternatives** | ⛔ Allocate a reader — ⭐ **not available to design**, and the evidence shows the gap is real: **`AUTH-10.23`** says *"A **library** MUST be able to view audit"* — ⭐⭐ **a TENANT, not a ROLE** — while **`AUD-XC-005`** forbids the audit module from evaluating authorisation · ⛔ Infer `TR-1` Owner *"because Owner sees everything"* — **REFUSED**: derivation from seniority, barred by **`AUTH-7.28`** and **`AP-4`** |
| **Consequences** | ⭐⭐ **`DD7-GAP-008` is discharged for V1 — ⛔ without allocating any authority** · ⭐ `DD-0007` surfaces drop **4 → 3** *(`C-1`, `C-2`, `C-3`)* plus `C-5` · ⭐ Configuration history remains **reconstructible from the audit trail** per `CNF-BR-006`, ⛔ just not surfaced in `BC-25` · ⭐ Student UX: **none** — `C-4` is a staff surface · ⚠️⚠️ **This record does NOT edit `DD-0007`** — ⭐ that is the **UX Architecture Owner's** act |
| **Open questions** | ⭐ Reflecting the removal in `DD-0007` — **UX Architecture Owner** · ⭐ If a future authorized requirement mandates the surface, **`C-4` returns and the reader question reopens** |
| **Review trigger** | ⭐⭐ Any new authorized requirement for a `BC-25` audit-reading surface |

---

## DDR-0009 — Adoption of the direction and the Master Design System

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED** |
| **Date** | 2026-09-19 · **Owner** Design Governance Owner · **Approver** ⭐⭐ **Founder/Product Authority** |
| **Scope** | Whole design system and visual direction |
| **Source references** | `LIBOORA_MASTER_DESIGN_SYSTEM.md` · `LIBOORA_DESIGN_DECISION_PACK.md` · `LIBOORA_UIUX_PRO_MAX_RULES.md` · `LIBOORA_HUMAN_DECISION_SHEET.md` |
| **Decision** | ⭐ **ACCEPT the proposed decision as Founder/Product Authority.** ⭐ The direction is **"Calm Premium Study Space"** — see **`DDR-0010`** |
| **Alternatives** | ⛔ Piecemeal adoption — rejected: D-1/D-3/D-4/D-5/D-7 interlock · ⛔ Reject — not taken |
| **Consequences** | ⭐⭐ The design system moves from **PROPOSED** to **APPROVED in its decided parts** · ⚠️ ⛔ **`DDR-0002` (family) and `DDR-0006` (device profile) remain open** — ⭐ the system is **approved with two named holes**, ⛔ not wholly closed · ⭐ Approval of design ⛔ **does not** approve a PRD, architecture decision, implementation or release *(`DESIGN_GOVERNANCE.md` §3 rule 5)* |
| **Open questions** | ⭐ Amending the foundation documents to reflect `DDR-0001`…`0009` — their respective owners |
| **Review trigger** | Any change to an approved foundation |

---

## DDR-0010 — Student visual direction: "Calm Premium Study Space"

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED** — ⚠️ **with one CONFLICT open** *(see below)* |
| **Date** | 2026-09-19 · **Owner** Design Vision Owner + UX Architecture Owner · **Approver** ⭐ Founder/Product Authority |
| **Scope** | Visual direction — **APP 1** primarily; hierarchy binds all apps |
| **Source references** | `LIBOORA_HUMAN_DECISION_SHEET.md` Part 1 · `VISUAL_LANGUAGE.md` *(CONFIRMED "lightweight premium 2.5D", "~70% clean 2D")* · `DESIGN_SYSTEM.md` §2 *(CONFIRMED "~10% premium 3D-style illustration")* |
| **Decision** | ⭐ **ACCEPT "Calm Premium Study Space."** ⭐ Layer budget: **70% 2D** information layer · **25% 2.5D** personality layer · **≤5%** lightweight 3D. ⭐⭐ **3D is limited to meaningful moments and MUST always have a complete 2D fallback.** ⭐ **Student App:** premium, warm, personal, modern, memorable. ⭐ **Library/Admin apps:** calm, fast, information-dense. ⛔⛔ **The product MUST NOT feel like a children's game** |
| ⚠️⚠️ **CONFLICT — open, ⛔ NOT silently resolved** | ⭐⭐ **`DESIGN_SYSTEM.md` §2 states ~10% 3D (already CONFIRMED); this record states ≤5%.** ⛔ **Neither value is overwritten here**, per the authority's express instruction. ⭐ **Both stand recorded until the authorized design owner reconciles them.** ⭐ Note for the reconciler: **≤5% is the stricter figure**, so working to it breaches neither — ⛔ but that is a **containment observation, not a resolution**. **Owner: Design System Owner** *(with Design Vision Owner)*. ⭐ Filed as **class D4 — source conflict** *(`DESIGN_CHANGE_MANAGEMENT.md` §1)* |
| **The four permitted 3D moments** | ⭐ **(1)** seat / library visualisation → 2D floor plan fallback · **(2)** student hero object → flat illustration · **(3)** study-space representation in onboarding → static image · **(4)** selected empty states → flat illustration. ⛔ **Everywhere else: 0% 3D** |
| **Alternatives** | ⛔ Full-screen 3D / WebGL-style scenes · ⛔ constant parallax · ⛔ heavy blur · ⛔ gamified children's UI · ⛔ generic admin dashboard — **all rejected** |
| **Consequences** | ⭐ Student App gains a distinct personality **within one design system** · ⛔⛔ **Delight never overrides** accessibility *(`DDR-0004`)*, performance *(`DDR-0006`)*, information hierarchy, governance, requirements, the **3-app boundary**, or role/permission rules · ⭐ Concretely: ⛔ a streak animation may not delay the attendance fact · ⛔ a 3D seat may not be the **only** way to pick a seat · ⛔⛔ **no celebratory surface may imply an entitlement the student does not hold** · ⚠️ The ≤5% budget is validated against **`DDR-0006`'s provisional target only** |
| **Open questions** | ⚠️ **The 5% vs 10% reconciliation** — Design System Owner · ⭐ 3D asset production pipeline and weight budget — Design Performance Owner *(gated on `DDR-0006`)* |
| **Review trigger** | ⭐ Confirmation of the V1 device profile; any measured frame drop; any proposal to add a fifth 3D moment |

---

## DDR-0011 — AI Study Coach: reserved space only

| Field | Value |
|---|---|
| **Status** | ⭐ **APPROVED** |
| **Date** | 2026-09-19 · **Owner** UX Architecture Owner · **Approver** ⭐ Founder/Product Authority |
| **Scope** | **APP 1** student dashboard — layout reservation |
| **Source references** | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1074** *(`AI Study Coach (V1)`)* · `MASTER_PRD` **L427**, **`MP-GBR-29`…`32`** · `PRD_REGISTRY` **L248** *(`PRD-011` · `BC-27` · V1 · **`PLANNED`**)* |
| **Decision** | ⭐ **Reserve the visual space only.** ⛔⛔ **Do NOT implement AI Coach behaviour until its authorized PRD exists** |
| ⭐ **What "reserve" means, precisely** | ⭐ **Permitted:** hold a dashboard position and its visual weight so a later addition is not a redesign · ⛔⛔ **Forbidden:** any prompt, chat affordance, suggestion copy, placeholder text, "coming soon" badge, or AI iconography. ⭐ **Until `PRD-011` exists, the slot renders NOTHING** |
| **Alternatives** | ⛔ Design coach surfaces now — rejected: ⭐ `PRD-011` is **`PLANNED`**, so ⛔ there are **no written requirements** and designing them would invent product behaviour · ⛔ Ignore the slot — rejected: retrofitting would force a dashboard redesign |
| **Consequences** | ⭐ The dashboard is future-proof at **zero** governance cost · ⭐⭐ **When `PRD-011` arrives, two rules already bind the design:** **`MP-GBR-31`** — AI-initiated domain writes require a **Human-in-the-Loop approval record** and an AI Action Log entry, *"**No exceptions in V1**"* · **`MP-GBR-32`** — **PII is redacted before egress to any model**; retrieval is tenant- and permission-filtered, *"asserted per query, not assumed"* · ⛔ **`MP-GBR-29`** — AI may **never** import or query a domain context directly |
| **Open questions** | ⭐ **`PRD-011` must be written** — **Product Owner** *(⛔ outside design authority)* |
| **Review trigger** | ⭐⭐ `PRD-011` reaching an authorized status |

---

## Register summary

| DDR | Subject | Status |
|---|---|---|
| `DDR-0001` | Colour tokens | ⭐ **APPROVED** |
| `DDR-0002` | Indic/Devanagari + typeface | ⭐ **APPROVED** *(requirement)* · ⛔ **TBD** *(family)* |
| `DDR-0003` | Radius 8/12/16 | ⭐ **APPROVED** |
| `DDR-0004` | Accessibility minimums | ⭐ **APPROVED** |
| `DDR-0005` | Breakpoints 600/905dp | ⭐ **APPROVED** |
| `DDR-0006` | V1 performance target | ⚠️ **PROVISIONAL** — ⛔ pending Technical Owner |
| `DDR-0007` | Dark mode out of V1 | ⭐ **APPROVED** |
| `DDR-0008` | `C-4` removed from V1 | ⭐ **APPROVED** *(condition tested)* |
| `DDR-0009` | System adoption | ⭐ **APPROVED** |
| `DDR-0010` | "Calm Premium Study Space" | ⭐ **APPROVED** · ⚠️ **1 CONFLICT open** |
| `DDR-0011` | AI Coach — space only | ⭐ **APPROVED** |

⭐ **9 approved · 1 provisional · 1 conflict open · 2 open holes** *(family, device profile)*.

---

## ⛔ What this record does **not** do

⛔ **0** PRDs, ADRs, permissions, `PERM-*`, roles, scopes, app boundaries, BC ownership or
backend contracts changed · ⛔ **0** foundation documents edited *(`DESIGN_SYSTEM.md`,
`ACCESSIBILITY.md`, `PERFORMANCE.md`, `VISUAL_LANGUAGE.md`, `DESIGN_DEBT.md` all
byte-unchanged)* · ⛔ **0** `DD-0007` edits · ⛔ **0** code · ⛔ **0** Figma · ⛔ no commit,
no push.

⭐⭐ **The foundation amendments that follow from these decisions are their owners' acts,
⛔ not this record's** — `DESIGN_DEBT.md` rule 5.
