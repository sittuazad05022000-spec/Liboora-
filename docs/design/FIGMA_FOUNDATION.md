<!-- LIBOORA Design Documentation Foundation | 2026-09-09 | v0.2 2026-10-26 — production-grade rewrite; no token, decision, or rank invented -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts. Where it disagrees with any ranked document, the ranked document wins.

# LIBOORA Figma Foundation

| Field | Value |
|---|---|
| Status | PROPOSED — Figma operating model (the canonical file and its variable libraries are the implementation; approval lives in G2, not here) |
| Owner | Figma Design Owner (file publication, variable libraries, component promotion); Design System Owner approves system/token changes; Accessibility Owner reviews accessibility-sensitive components |
| Rank | **UNRANKED.** Carries no precedence over any ranked PRD, ADR, BC Map or [`DOCUMENTATION_BASELINE.md`](../00-governance/DOCUMENTATION_BASELINE.md) entry |
| Sources | [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) (APPROVED G2, 2026-10-01 — foundations §2 + §3 component contract) · [`RESPONSIVE_DESIGN.md`](RESPONSIVE_DESIGN.md) (APPROVED v0.1, `DDR-0004`/`DDR-0005`) · [`DDR-0034`](design-decisions/DDR-0034-cp-a-v1-device-profile-confirmed-by-technical-owner.md) (target class) · [`NFR_BUDGETS_V1.md`](NFR_BUDGETS_V1.md) · [`ACCESSIBILITY.md`](ACCESSIBILITY.md) (`DDR-0004` WCAG 2.1 AA) |
| Traceability | [`DESIGN_IMPLEMENTATION_TRACEABILITY.md`](DESIGN_IMPLEMENTATION_TRACEABILITY.md) (Figma → `theme.dart`/DIT inventory); Figma is the implementation mechanism, not the authority |

---

## 1. File structure

The canonical Figma file is structured so a ranked-document reviewer can reach the covered behaviour in one traverse. Until the Figma Design Owner publishes the canonical file, page names are **RECOMMENDED**; after publication, the file is canonical.

| Page (RECOMMENDED until published) | What lives there | Governing reference |
|---|---|---|
| 00 Cover & Governance | Cover, status vocabulary (`DESIGN_GOVERNANCE.md` §2), rank note, owner roster, link to [`G2_FOUNDATION_APPROVAL_RECORD_2026-10-01.md`](G2_FOUNDATION_APPROVAL_RECORD_2026-10-01.md) | `DESIGN_GOVERNANCE.md` §2 |
| 01 Foundations | Colour, typography, spacing, radius, elevation, iconography, illustration + layer ratio, motion — each frame cites its deciding DDR | [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §2 (see §3 below) |
| 02 Responsive Foundations | Breakpoint frames + D-1…D-4, density rules, `DDR-0034` target-class performance posture | [`RESPONSIVE_DESIGN.md`](RESPONSIVE_DESIGN.md) v0.1; `DDR-0004`/`DDR-0005`/`DDR-0034` |
| 03 Accessibility Foundations | Contrast pairings, target sizes, text-growth at 200%, reduced-motion, focus-ring, non-colour cues, Devanagari fallback rule | [`ACCESSIBILITY.md`](ACCESSIBILITY.md) (APPROVED G2); `DDR-0004` |
| 04 Components | Published component library — each component follows §5 state contract and §4 variable bindings | [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §3 + `templates/COMPONENT_SPEC_TEMPLATE.md` §3 |
| 05 Patterns | Compositions owned by the same BC; no new domain ownership | [`UX_ARCHITECTURE.md`](UX_ARCHITECTURE.md) §3; `DESIGN_GOVERNANCE.md` §2 |
| 06 Screens — Library Discovery (V1) | Public discovery/profile, allow-list data only; states per §5 | Library §§14A–14B; [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) §1 |
| 07 Screens — Seat Booking (V1) | Availability → shift/seat → booking initiation/confirmation/failure | Frozen library/seat authority; [`USER_FLOWS.md`](USER_FLOWS.md) §1 |
| 08 Screens — Account / Session (V1) | Authentication entry, account sheet, session/device — no `BC-18` `ConsentRecord` copy invented | `ADR-0129` (V1 = Google Sign-In only); `docs/20-configuration/CONFIGURATION_GUIDE.md` `CFG-5…CFG-8` |
| 09 Community Exploration ( 취재 ) | Source-traceable exploration only — ⛔ not a spec; Community privacy/safety is `DRAFT` + conflict `C-001` | [`SECURITY_PRIVACY_UX.md`](SECURITY_PRIVACY_UX.md) `SPX-GAP-009` |
| 10 Handoff | Traceability row per handoff frame (see §7) | `DESIGN_DEBT.md` `DBT-006` source fidelity |
| 99 Archive | Superseded frames moved, not deleted — deprecation recorded in `DESIGN_DEBT.md` §3 |

## 2. Naming

Names are searchable before they are pretty. **Format:** `Foundation / Token / Category / Name` · `Component / Category / Name` · `Pattern / Journey / Name` · `Screen / Surface / State`. A name that implies a backend owner, a permission, or a `BC-*` ownership edge the source does not define is out of scope and must be renamed — the same rule that returns work in [`DESIGN_QA.md`](DESIGN_QA.md) §3 applies in Figma.

## 3. Variable & token foundations

This section is the Figma-side translation of [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §2. **Every value cited below is already decided or ratified at the named DDR** — where the document says "documented as decided, ⛔ NOT claimed implemented" (because `lib/app/shared/theme.dart` and `lib/main.dart`'s `fontFamily` `Roboto` still diverge), the Figma variable adopts the **decided** value and the gap is recorded in [`DESIGN_DEBT.md`](DESIGN_DEBT.md) `DBT-001`/`DBT-005`.

| Variable collection | Mode | Decided scale / values (cited, not invented) | Figma pairing rule | DDR |
|---|---|---|---|---|
| `color` | Semantic — `surface` · `text` · `border` · `action` · `focus` · `success` · `warning` · `danger` · `information` | `accent-ink #92400E` · `accent-fill #F5A524` (fills, paired with `textPrimary`) · `text-muted #5F6585` · `border/decorative #E3E6F0` · `border/control #7F87A6` · `brand`/`brandDark`/`success`/`warning`/`danger`/`info`/`textPrimary` unchanged | Never use colour alone to communicate state; contrast is AA at `DDR-0004` ratios (see §6) | `DDR-0001` APPROVED; `DDR-0027` §2.1 note 3 |
| `type.family` | `latin` · `devanagari` | **V1 MUST support Indic/Devanagari** (`DDR-0002` APPROVED): Latin `Noto Sans` + Devanagari `Noto Sans Devanagari`, licence **SIL OFL** | Figma `fontFamilyFallback` includes both faces; V1 type lint excludes any non-OFL face | `DDR-0002` + `DDR-0029` |
| `type.scale` | `size` · `lineHeight` · `weight` | Sizes **12 · 14 · 16(base) · 18 · 20 · 24 · 30** (12 px floor = non-essential metadata only) · tabular-lining numerals for money/counts/seats · line-heights **1.5 body / 1.25 headings** · weights **400 / 500 / 600 / 700** (⛔ 800+ excluded from V1) | Type components expose `weight` and `numeral` variants; a weight above 700 is not a V1 variant | `DDR-0031` (sizes/line-heights, ratified) · `DDR-0032` (weights, decided) |
| `space` | `xs…xxl` | `xs 4 · sm 8 · md 12 · lg 16 · xl 24 · xxl 32` (6-step `LiblSpace`, 0 implementation delta) | No new spacing value without a DDR; spacing is not a per-frame adjustment | `DDR-0027` (ratified, shipped values) |
| `radius` | `sm · md · lg` | `sm 8 · md 12 · lg 16`; ⛔ **`14`/`18` retired**; pill = status chips only | 14/18 must not appear as published tokens; legacy frames using them are marked for conformance | `DDR-0003` APPROVED; `DDR-0028` |
| `elevation` | `elev/0 · elev/1 · elev/2` | `0` flat default · `1` hairline + one soft y-shadow (cards) · `2` sheets/dialogs/menus (transient only); ⛔ no `elev/3+`, no coloured/neon shadows; borders first, elevation second | No fourth level; decoration-free | `DDR-0028` |
| `breakpoint` | `compact · medium · expanded` | `< 600dp` compact · `600–904dp` medium · `≥ 905dp` expanded; `D-1` medium stays single-column, two-pane only at ≥ 905dp | Each component frame records its responsive variant (see §6) | `DDR-0005` · `RESPONSIVE_DESIGN.md` v0.1 · `DDR-0004` density |
| `motion` | `duration` · `curve` | Short, purposeful transitions; reduced-motion alternative; no motion required to understand a task | Every motion token has a `reduced-motion: none` variant | [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §2 motion (RECOMMENDED) |

Implementation-conformance deltas (`accent-ink`, `text-muted` `#5F6585`, `border/control`, the `14`/`18` retirements, `Roboto`→`Noto` bundle/fallback + `LiblText`, `LiblRadius`) do not change Figma's adopted values — they remain design-decided, with `theme.dart` conformance as separate engineering work (`DIT-001` = `CONFLICT`).

## 4. Libraries and publication order

Publication order is foundations-must-exist-before-dependents, not a calendar promise:

1. **Foundations** (§3 frame + `§3` variable collections) publish first — nothing above them can be published with an unresolved `TO BE DECIDED` that would become a hard-coded literal.
2. **Breakpoints + type/accessibility foundations** next — components depend on the same tokens.
3. **Components** (§5) — after token/libraries are published and approved under [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §2; the Design System Owner's approval is recorded in the Figma file's version note, not by a document edit.
4. **Patterns** — after the composing components; a pattern does not introduce a new domain ownership or a V2 library feature gated by a source-blocked requirement.
5. **Screens** — after component + pattern dependencies are published; V1 screens precede Community-exploration frames (see §1 page 09 — exploración, not spec).

The Figma Design Owner controls publishing; the Design System Owner approves system/token changes; the Accessibility Owner reviews accessibility-sensitive components; and [`DESIGN_GOVERNANCE.md`](DESIGN_GOVERNANCE.md) §2's vocabulary (`APPROVED`/`RETURNED`/`CONFLICT`/`TO BE DECIDED`) is the publication gate.

## 5. Component anatomy

Every published component is an executed `DESIGN_SYSTEM.md` §3 component contract. The canonical headings come from `templates/COMPONENT_SPEC_TEMPLATE.md`; the checklist below is the Figma-side of that template.

- **States:** default · hover/focus where applicable · active/pressed · disabled/unavailable where applicable · selected · validation-state where applicable · loading/skeleton · empty · error · offline/stale where relevant. A `disabled` or `error` state must not invent a permission or a retrieval contract.
- **Responsive variants:** compact `< 600dp` · medium `600–904dp` (single-column) · expanded `≥ 905dp` (two-pane threshold D-1) where layout adapts — density follows `DDR-0004`'s padding/motion/text-density tolerances on the `DDR-0034` class (API 26 · 2 GB · 720×1600 · degraded 4G).
- **Content tails:** long and short text (incl. Devanagari fallback `DDR-0029` — `CP-B1`/`FA-GAP-003` remain `BLOCKED / UNVERIFIED` per `DEVANAGARI_RENDERING_PROBE.md` + `CP-B1_EQUIVALENT_TARGET_PROPOSED_ACCEPTANCE.md`); missing, overflow, truncation with readable fallback.
- **Accessibility annotations on the frame:** target size ≥ 48 dp / separation ≥ 8 dp (`DDR-0004`), focus order and ring, accessible name/role/state, non-colour cue (icon+label), 200% text-growth frame, and the `reduced-motion` variant. A component cannot be published without them.
- **Performance note:** the frame records that the primary task is not gated on a heavy illustration, a bulk payload, or a third-party font load — the general performance posture per [`PERFORMANCE.md`](PERFORMANCE.md) §1.

## 6. Variables and tokens — the "do not hard-code" rule (strengthened)

§3 already names the variable collections. The enforceable rule is: **if a semantic variable exists for colour, type, spacing, radius, elevation, breakpoint, or motion, that variable is used — the hard-coded literal is the exception, and it must be justified on the same frame.** The Figma variable library, not a page-specific fill panel, is the source of truth; an audit that `grep`s the frame library must not find a hard-coded `accent-ink` literal improvised on one screen while a token with the same intent sits in §3. The three known shop-vs-design deltas (`accent-ink`, `text-muted`, `border/control`) are not coexistence excuses — they are recorded once (`DESIGN_DEBT.md` `DBT-001`/`005` + `DIT-001`) and the Figma tables show the decided value only.

## 7. Figma → engineering handoff

A handoff frame is not a screenshot with a link — it is a **traceable, reviewable contract** that answers: "is this source-backed, and what remains open?" One traceability row per frame; the frame's link is the row's link.

| Row field | What the Figma frame must show (verbatim field names) |
|---|---|
| **Source-backed behaviour** | The frozen/Library/BC Map section that authorises the behaviour (e.g., Library §14A.4 `LIB-DISC-003`, `14B` `LIB-14B.07–.10`, BC-18 `ConsentRecord`, `MP-GBR-25/27/34`) — never a paraphrase without a section. Any behaviour without a section is marked `TO BE DECIDED` with its `SPX-GAP-*`/`DD7-GAP-*`/`DBT-*` row from [`SECURITY_PRIVACY_UX.md`](SECURITY_PRIVACY_UX.md) §5 or [`DESIGN_DEBT.md`](DESIGN_DEBT.md) §2. |
| **States shown** | The `DESIGN_QA.md` §3 state IDs that are actually framed (S1 empty, S2 loading, S3 populated, S4 at-limit, S5 network/service error, S6 not-found/unavailable, S7 not-eligible/rejected, S8 permission/session, S9 stale/offline, S10 filtered, S11 confirmation, S12 success-with-side-effects) — with the `N/A with reason` tag where a state is genuinely inapplicable. An omitted applicable state without `N/A with reason` is [`DESIGN_QA.md`](DESIGN_QA.md) §8 `RETURNED`. |
| **Responsive variants** | The three breakpoint frames (§5) or a one-line `N/A` with the `RESPONSIVE_DESIGN.md` D-rule that exempts the surface. |
| **Accessibility** | Target/contrast/text-growth/reduced-motion: the four checks from `ACCESSIBILITY.md` that the component claims, or `TO BE DECIDED` where `SPX-GAP-*` is unresolved — never an unreviewed pass. |
| **Performance** | The surface's performance posture per [`PERFORMANCE.md`](PERFORMANCE.md) §1 — the primary task is not gated on a heavy illustration, bulk payload, or third-party font load; per-surface notes go on the frame. |
| **Unresolved questions** | Each `TO BE DECIDED` carries its `DBT-*`/`SPX-GAP-*`/`DD7-GAP-*` identifier *on the frame* (not hidden in a comment), with its owning office (Privacy Owner, Security Platform, Founder/Product Authority, etc.). No question lives in a Figma comment without a design-document identifier on the canvas. |

Figma is the **implementation mechanism** for design artifacts, not the authority for PRDs, ADRs, or backend contracts. The traceability row, not the frame's visual completeness, determines whether engineering may build from the frame.

## 8. V1 scope — what may live in the canonical Figma file

V1 is discovery/profile (Library §§14A–14B) · authenticated student seat booking (`BC-04` / PRD-007) · account/session shell. `MP-CON-11`'s no-demo/no-guest limb and `TASK-D10` still gate any release build — a Figma frame must not invent a demo or guest path, and no Community privacy/safety surface (PRD-021A A6 + `C-001`) may be specced while the baseline conflict is unresolved (`SECURITY_PRIVACY_UX.md` `SPX-GAP-009`). Where `DEVANAGARI_RENDERING_PROBE.md` notes that rendering is `CP-B1`/`FA-GAP-003` `BLOCKED / UNVERIFIED` (no pass exists), a Figma frame that claims a passed Devanagari guarantee is out of scope.

---

*Reviewed against: `DESIGN_SYSTEM.md` (APPROVED G2; colour `DDR-0001` · type family `DDR-0029`/sizes `DDR-0031`/weights `DDR-0032` — V1 Indic requirement `DDR-0002` — spacing `DDR-0027` · radius `DDR-0003`/`DDR-0028` · elevation `DDR-0028` · illustration `DDR-0013`) · `RESPONSIVE_DESIGN.md` + `DDR-0005`/`DDR-0004`/`DDR-0034` · `DESIGN_GOVERNANCE.md` §2 · `DESIGN_QA.md` §3 S1–S12/§5.4/§5.5/§6/§8 · `DESIGN_DEBT.md` `DBT-001/002/005/006` · `DESIGN_IMPLEMENTATION_TRACEABILITY.md` · `ACCESSIBILITY.md` (WCAG 2.1 AA, `DDR-0004`) · `SECURITY_PRIVACY_UX.md` §5 · `PRD_OWNERSHIP_MODEL.md` · `PRD_DESIGN_TRACEABILITY.md` · no invented requirement, decision, token, or governance — V1 scope preserved.*
