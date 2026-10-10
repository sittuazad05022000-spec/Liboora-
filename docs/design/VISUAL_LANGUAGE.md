<!-- LIBOORA Design Documentation Foundation | 2026-09-09 | v0.2 2026-10-26 — production-grade rewrite; no requirement, decision, token, or rank invented -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts. Where it disagrees with any ranked document, the ranked document wins.

# LIBOORA Visual Language

| Field | Value |
|---|---|
| Status | PROPOSED — visual language for approval (criteria document; approval lives at G2, not here) |
| Owner | UI/Visual Design Owner |
| Rank | **UNRANKED.** Carries no precedence over any ranked PRD, ADR, BC Map or [`DOCUMENTATION_BASELINE.md`](../00-governance/DOCUMENTATION_BASELINE.md) entry |
| Sources | [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) (APPROVED G2 — §2 foundations + §3 component contract) · [`FIGMA_FOUNDATION.md`](FIGMA_FOUNDATION.md) §3 variable collections · [`DESIGN_QA.md`](DESIGN_QA.md) §3 states S1–S12 + §6 recovery · [`ACCESSIBILITY.md`](ACCESSIBILITY.md) (`DDR-0004` WCAG 2.1 AA) — this document's visual criteria are the UX-side reading of the same decided foundations |
| V1 scope | Library discovery (public, §§14A–14B) · student seat booking (`BC-04` / PRD-007) · account/session shell. Community is V2 (`C-001`); premium effects are bounded by §2 regardless of V1/V2 |

---

## 1. Visual ratio

The ratio is a **visual decision, not a measurement requirement** (as stated in v0.1). Its enforcement lives in the handoff checklist, not in a pixel counter.

- **About 70% clean 2D** (v0.1, unchanged): typography, surfaces, cards, lists, controls and direct information hierarchy carry the interface. The 2D layer is the default enforcement posture for every surface.
- **About 25% subtle depth** *(canonical — reconciled at `DDR-0013`; prior `20%` retained)*: restrained elevation, grouped surfaces, and soft but readable separation. Depth emphasises relationship and priority, not ornament. See §5 for the decided elevation scale.
- **About ≤5% premium 3D-style illustration** *(canonical — `DDR-0013`; prior `~10%` retained)*: selected brand, onboarding, or empty-state moments only — the four permitted 3D moments per `DDR-0010` are unchanged, and a 2D fallback is mandatory where an illustration is used.

**Status: CONFIRMED direction (v0.1, unchanged); exact frame mix is RECOMMENDED and judged at handoff (`DESIGN_QA.md` §8 `RETURNED`).**

## 2. Premium without weight

Premium is expressed through **proportion, whitespace, typographic confidence, image quality, alignment stability, and calm feedback** — the same posture that `PERFORMANCE.md` §1 uses to forbid gating the primary task on heavy assets. No premium effect depends on animation, and no essential state depends on a 3D illustration.

- **Do not use** WebGL, heavy 3D scenes, pervasive glass, or animated premium treatments to manufacture the feel.
- **Use** generous spacing within the `LiblSpace` scale (`DDR-0027`: `xs 4 · sm 8 · md 12 · lg 16 · xl 24 · xxl 32`), tabular-lining numerals for aligned data (`DDR-0031`), and the modest radius set (`DDR-0028`: `8`·`12`·`16` only) to carry proportion. The premium signal is restraint, not decoration.

**Status: CONFIRMED exclusions (v0.1, unchanged).**

## 3. Color

- **Decision:** semantic roles first — every colour resolves to a **decided** semantic role (`surface` · `text` · `border` · `action` · `focus` · `success` · `warning` · `danger` · `information`) per [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §2 · `DDR-0001` (APPROVED). Decided values: `accent-ink #92400E` (text/icons) · `accent-fill #F5A524` (fills, paired with `textPrimary`) · `text-muted #5F6585` (replacing the shipped `#6B7194`) · `border/decorative #E3E6F0` · `border/control #7F87A6`; `brand`/`brandDark`/`success`/`warning`/`danger`/`info`/`textPrimary` unchanged. **Never use colour alone to communicate state**; every semantic pairing carries a non-colour cue (icon, label, or contrast step) at the frame level (`ACCESSIBILITY.md` + `DDR-0004` 4.5:1 text / 3:1 large).
- **Guidance:** the focus ring and error/success cues are paired with visible focus and semantic iconography — the "non-colour state" rule in this section is enforced at [`DESIGN_QA.md`](DESIGN_QA.md) §5.4, not asserted as a visual preference here.
- **Implementation note:** `accent-ink`, `text-muted #5F6585`, and `border/control` remain design-decided with as-built conformance recorded as `DIT-001 CONFLICT` — the decided values are not downgraded because `theme.dart` still diverges (`DESIGN_DEBT.md` `DBT-001`/`DBT-005`).

## 4. Typography

- **Decision (requirement `APPROVED`, family + scale decided):**
  - Requirement: **V1 MUST support Indic/Devanagari** (`DDR-0002` APPROVED).
  - Family + licence **DECIDED** (`DDR-0029`): `Noto Sans` (Latin) + `Noto Sans Devanagari` (companion), licence **SIL Open Font License (OFL)** — the only candidate satisfying the pairing + coverage + open-licence criteria (Design System + Governance Owner).
  - Sizes + line-heights **RATIFIED** (`DDR-0031`, ratifying the `PROPOSED` master-system §4 values, subject to `DDR-0004`'s 200% text-growth): base **16px** · scale **12 · 14 · 16 · 18 · 20 · 24 · 30** (12px floor = non-essential metadata only) · **tabular-lining numerals** (money, counts, seat numbers) · line-heights **1.5 body / 1.25 headings**.
  - Weights **DECIDED** (`DDR-0032`): `400` Regular · `500` Medium · `600` SemiBold · `700` Bold; ⛔ **`800+` excluded from the V1 type-token system** (fresh owner decision; Noto cross-face matching remains an externally unverified conformance prerequisite).
- **Guidance:** avoid compressed display faces for operational data — operational content uses tabular `Noto` at `400`–`600` (bold `700` for headings/emphasis only); headings carry `1.25`, body carries `1.5`. A weight above 700 is not a visible V1 variant.
- **Implementation note:** `theme.dart` L49 still reads `fontFamily: 'Roboto'` — `Noto` bundle/subsetting + `fontFamilyFallback` + `LiblText` is **separate implementation-conformance work**; `CP-B1`/`FA-GAP-003` Devanagari rendering remains `BLOCKED / UNVERIFIED`.

## 5. Depth — surfaces and elevation

- **Decision (elevation scale DECIDED):** **3 semantic levels, decoration-free** (`DDR-0028` · [`FIGMA_FOUNDATION.md`](FIGMA_FOUNDATION.md) §3 variable collection `elevation`):
  - `elev/0` **flat on canvas** — default.
  - `elev/1` **cards, raised rows** — hairline border + one soft y-shadow.
  - `elev/2` **sheets, dialogs, menus** — transient overlays only.
  - ⛔ No `elev/3+`; ⛔ no coloured/glowing/neon shadows; **borders first, elevation second.**
- **Guidance:** elevation communicates **relationship and priority** (a card groups its content; a dialog rises above the page); it never creates a false affordance. A surface that looks pressed or selectable because of depth alone misuses this scale and is returned at handoff.

## 6. Spacing, radius, and layout rhythm

- **Decision (spacing RATIFIED, radius scales DECIDED):** `LiblSpace` **6 steps** `xs 4 · sm 8 · md 12 · lg 16 · xl 24 · xxl 32` (`DDR-0027`, ratified — 0 implementation delta) and `LiblRadius` **three radii** `sm 8 · md 12 · lg 16` (`DDR-0003` APPROVED; `DDR-0028` — **`14`/`18` RETIRED**, pill = status chips only) are the only values a surface may use. No new spacing or radius value is introduced without a DDR.
- **Guidance:** generous `xl`/`xxl` grouping and the modest radius palette together carry the "premium without weight" posture from §2; a frame that relies on a bespoke spacing or a retired radius is a handoff defect, not a style variance.

## 7. Illustration and iconography

- **Illustration:** ≤5% premium 3D-style illustration per §1 (`DDR-0013` · `DDR-0010`'s four permitted moments + mandatory 2D fallback). Share illustrations across empty-state surfaces; never gate task completion on an illustration.
- **Iconography:** simple, legible icons with labels where meaning is not universal; an icon that carries state uses the §3 semantic role + its paired non-colour cue ([`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §2).

## 8. Motion

Short, purposeful transitions that explain change and preserve orientation; **reduced-motion alternative is required** — no essential state may depend on animation, and the `reduced-motion` variant is a first-class state (see [`DESIGN_QA.md`](DESIGN_QA.md) §5.4 accessibility). Motion is the only item in this section that remains **RECOMMENDED** until a DDR ratifies a duration/curve token set.

## 9. States and responsive visual behaviour

- **Required visual states (tested at handoff):** every data-dependent or action-bearing surface specifies **loading → ready → empty → error → offline/stale → disabled/unavailable**, plus **focus/pressed/selected/validation** where applicable ([`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §4; [`DESIGN_QA.md`](DESIGN_QA.md) §3 S1–S12). A state that implies an unsupported `BC-*` ownership or capability is out of scope.
- **Responsive note:** compact `< 600dp` · medium `600–904dp` (single-column, two-pane only at `≥ 905dp`) + density tolerances on the `DDR-0034` class are specified at [`RESPONSIVE_DESIGN.md`](RESPONSIVE_DESIGN.md) — a component's visual density is judged there, not in this section.

---

*Reviewed against: `DESIGN_SYSTEM.md` (APPROVED G2; §2 colour `DDR-0001` — `accent-ink`/`accent-fill`/`text-muted`/`border/*` + spacing ratified `DDR-0027` · type requirement `DDR-0002` + family `DDR-0029`/sizes `DDR-0031`/weights `DDR-0032` incl. `800+` excluded · radius `DDR-0003`/`DDR-0028` · elevation `DDR-0028` · illustration `DDR-0013`; debt `DIT-001 CONFLICT`) · `DESIGN_IMPLEMENTATION_TRACEABILITY.md` — no invented requirement, decision, token, component, measurement, or governance — V1 scope preserved as library discovery + seat-booking + shell.*
