<!-- LIBOORA Design Documentation Foundation | 2026-09-09 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design System

| Field | Value |
|---|---|
| Status | PROPOSED — foundation rules awaiting approval |
| Owner | Design System Owner |
| Implementation | Figma Foundation and approved engineering implementation |

## 1. System shape

The system is layered: foundations → tokens → primitives → components → patterns → screens. A component expresses interaction and state; it does not own a domain, record, permission, or backend contract.

## 2. Foundations

| Foundation | Decision status | Direction |
|---|---|---|
| Color | ⭐ **DECIDED** (`DDR-0001` `APPROVED`; aligned by [`DDR-0027`](design-decisions/DDR-0027-dbt-001-b1-liblspace-ratification-and-foundation-alignment.md)) | Semantic roles first: surface, text, border, action, focus, success, warning, danger, information. Never use color alone to communicate state. ⭐ **Decided values** (`DDR-0001` L35): *amended* — `accent-ink` `#92400E` (text/icons) · `accent-fill` `#F5A524` (fills only, paired with `textPrimary`) · `text-muted` `#5F6585` (replaces `#6B7194`) · `border/decorative` `#E3E6F0` · `border/control` `#7F87A6`; *unchanged* — `brand`, `brandDark`, `success`, `warning`, `danger`, `info`, `textPrimary`. ⚠️ **Documented as decided values, ⛔ NOT claimed implemented in `theme.dart`** — 3 conformance deltas (`accent-ink`, `text-muted`→`#5F6585`, `border/control`) are **separate implementation work** |
| Typography | ⭐ **DECIDED — requirement `APPROVED` (`DDR-0002`) · family + licence `DECIDED` (`DDR-0029`)** | Use a readable sans-serif family with clear numeral forms, hierarchy, and stable wrapping on small screens. ⭐ V1 **MUST** support Indic/Devanagari (`DDR-0002` requirement, `APPROVED`). ⭐ **Typeface family decided (`DDR-0029`):** `Noto Sans` (Latin) + `Noto Sans Devanagari` (Devanagari companion) · licence **SIL Open Font License (OFL)** — the candidate `DDR-0002` derived as the only one satisfying the pairing + Devanagari-coverage + open-licence criteria, confirmed by Design System Owner + Design Governance Owner. ⚠️ **Documented as decided, ⛔ NOT claimed implemented** — `theme.dart` L49 still reads `fontFamily: 'Roboto'`; bundling/subsetting the second script and adding a `LiblText` class are **separate implementation work**. ⛔ **Type-scale values (sizes / weights / line-heights) are NOT decided here** — no source independently decided them; they remain a separate open decision (⛔ not invented). |
| Spacing | ⭐ **RATIFIED** ([`DDR-0027`](design-decisions/DDR-0027-dbt-001-b1-liblspace-ratification-and-foundation-alignment.md) — Design System Owner) | ⭐ **Ratified `LiblSpace` scale (6 steps, adopts the shipped values — 0 implementation delta):** `xs` 4 · `sm` 8 · `md` 12 · `lg` 16 · `xl` 24 · `xxl` 32 *(evidence: `lib/app/shared/theme.dart` L29–35; values **recorded, not invented**)*. Consistent base scale and generous grouping. |
| Radius | ⭐ **DECIDED** (`DDR-0003` `APPROVED`; token class ratified by [`DDR-0028`](design-decisions/DDR-0028-dbt-005-radius-elevation-token-scales-decided.md)) | Moderate, consistent radii; avoid pill-shaped everything. ⭐ **Ratified `LiblRadius` scale (adopting `APPROVED` `DDR-0003` values — no new value invented):** `sm` **8** · `md` **12** · `lg` **16**; ⛔ **`14` and `18` RETIRED**; **pill reserved for status chips only**. ⚠️ **Documented as decided, ⛔ NOT claimed implemented** — the shipped `theme.dart` still carries `14`/`18` and has no `LiblRadius` class; that is **separate implementation-conformance work**. |
| Elevation | ⭐ **DECIDED** ([`DDR-0028`](design-decisions/DDR-0028-dbt-005-radius-elevation-token-scales-decided.md) — Design System Owner) | Small number of semantic levels for grouping and priority, not decoration. ⭐ **3-level semantic, decoration-free scale (decided from the repository's own `PROPOSED` master-system §7 + shipped flat-first posture):** `elev/0` **flat on canvas** *(default)* · `elev/1` **cards, raised rows** *(hairline border + one soft y-shadow)* · `elev/2` **sheets, dialogs, menus** *(transient overlays only)*. ⛔ **No `elev/3+`**; ⛔ no coloured / glowing / neon shadows. *Borders first, elevation second.* ⚠️ **Documented as decided, ⛔ not claimed implemented.** |
| Iconography | RECOMMENDED | Familiar, simple, legible icons with labels where ambiguity exists. |
| Illustration | CONFIRMED | About 10% premium 3D-style illustration; compress, lazy-load, and keep the functional UI 2D-first. |
| Motion | RECOMMENDED | Short, purposeful transitions with reduced-motion alternatives; no motion required to understand a task. |

### 2.1 ⚠️ Recorded finding — resolved by limb; one open decision + one open conformance item remain

`lib/app/shared/theme.dart` already defined a colour set (`LiblColors`, **12** constants) and a spacing scale (`LiblSpace`, **6** steps), and `theme.dart` (2026-09-07) predates this document (2026-09-09). The debt that this divergence created is recorded as [`DESIGN_DEBT.md`](DESIGN_DEBT.md) `DBT-001`. ⭐ **The colour and spacing limbs of `DBT-001` are now decided**: the colour row above is aligned to `APPROVED` `DDR-0001`, and the spacing scale is **ratified** by the Design System Owner's act at [`DDR-0027`](design-decisions/DDR-0027-dbt-001-b1-liblspace-ratification-and-foundation-alignment.md) — so the `TO BE DECIDED` state no longer applies to colour or spacing values. ⛔ **No silent fix**: both limbs were closed only by the owning office's decision (the `DESIGN_DEBT.md` §3 rule 5 act), never by side-effect editing.

⚠️ **Open items remain, deliberately preserved rather than smoothed over:**

1. ⭐ **Typography family + licence — now `DECIDED`** at [`DDR-0029`](design-decisions/DDR-0029-dbt-001-dbt-005-typeface-family-and-licence-decided.md) (`Noto Sans` + `Noto Sans Devanagari`, **SIL OFL**; requirement `APPROVED` at `DDR-0002`). ⛔ **Still open:** the **type-scale token set** (sizes / weights / line-heights) — examined by the Design System Owner at [`DDR-0030`](design-decisions/DDR-0030-dbt-005-type-scale-token-set-open-decision-recorded.md) and **recorded `OPEN / TO BE DECIDED`** (no source fixes the values; the master-system §4 numbers remain `PROPOSED`); ⛔ not invented here.
2. ⛔ **Implementation conformance + type scale token set — still open.** `theme.dart`'s shipped `text-muted` (`#6B7194`) is **not** `DDR-0001`'s decided `#5F6585`; `accent-ink` and `border/control` are decided but not yet present in code; the retired radii `14`/`18` and the missing `LiblRadius` class are the same kind of delta; and the decided typeface family (`DDR-0029`: `Noto Sans` + `Noto Sans Devanagari` / SIL OFL) is **not yet in code** (`theme.dart` L49 still reads `fontFamily: 'Roboto'`). These are **separate implementation work** that no design decision authorizes or defers. ⭐ **The radius and elevation token scales are DECIDED** — `LiblRadius` on `DDR-0003`'s `APPROVED` values and the 3-level elevation scale, ratified/decided by the Design System Owner at [`DDR-0028`](design-decisions/DDR-0028-dbt-005-radius-elevation-token-scales-decided.md). ⚠️ **The type-token-class limb of `DBT-005` is UNBLOCKED, ⛔ not closed** — the family + licence that gated it are now `DECIDED` at [`DDR-0029`](design-decisions/DDR-0029-dbt-001-dbt-005-typeface-family-and-licence-decided.md); the **scale token set** (sizes / weights / line-heights) is still an **independent open decision** no source has recorded. The residual divergence is recorded as `DBT-005` *(now **PARTIALLY RESOLVED by limb**)* in [`DESIGN_DEBT.md`](DESIGN_DEBT.md); the as-built inventory is recorded as `DIT-001` in [Design to Implementation Traceability](DESIGN_IMPLEMENTATION_TRACEABILITY.md), whose status is `CONFLICT`.

## 3. Component contract

Use [`templates/COMPONENT_SPEC_TEMPLATE.md`](templates/COMPONENT_SPEC_TEMPLATE.md), whose headings are exactly the eleven items below.

Every component specification records purpose, anatomy, variants, content rules, interaction states, responsive behavior, accessibility behavior, loading and error behavior, performance notes, and source trace links.

## 4. Required states

Every data-dependent or action-bearing component must specify loading, ready, empty, error, offline or stale-data behavior where applicable, disabled or unavailable behavior where applicable, focus, pressed, selected, and validation states. The state must not imply an unsupported capability.

## 5. Reuse and extension

Prefer existing components. Extend only when the new need is traceable and the Design System Owner records why composition or an existing variant is insufficient. A new pattern is not a new product capability.

## 6. System quality bar

The system must remain lightweight, accessible, localizable, responsive, inspectable in Figma, and implementable on low-end Android without heavy effects.
