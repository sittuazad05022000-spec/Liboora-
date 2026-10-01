<!-- LIBOORA Design Documentation Foundation | 2026-10-01 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Responsive Design

| Field | Value |
|---|---|
| Status | **APPROVED** — v0.1, 2026-10-01, **Responsive Design Owner**; recorded in [`RESPONSIVE_DESIGN_APPROVAL_RECORD_2026-10-01.md`](RESPONSIVE_DESIGN_APPROVAL_RECORD_2026-10-01.md) |
| Version | **v0.1** — assigned at approval; the prior draft of this artifact carried no version field |
| Owner | **Responsive Design Owner** (`DESIGN_OWNERSHIP.md` §1 — "Owns breakpoint behavior, layout adaptation, and device-mode rules"; approval route per `DESIGN_OWNERSHIP.md` §1; escalation to Design Governance Owner) |
| Authority | `DDR-0005` — **APPROVED** (breakpoint values, Founder/Product Authority, 2026-09-19) |
| Rule | This artifact carries the APPROVED `DDR-0005` classes and states layout-adaptation rules. The D-1 through D-4 decisions were approved by the Responsive Design Owner on 2026-10-01 (v0.1). No new breakpoint value is invented. |

## 1. Window size classes (APPROVED — `DDR-0005`)

Liboora is a Flutter/Android-first product; widths are measured in **dp**, using
**Material 3 window size classes** as the external citable standard. These values are
**APPROVED** — this document records them, it does not decide them.

| Class | Range | `DDR-0005` label | Layout outcome (per `DDR-0005` consequences) |
|---|---|---|---|
| Compact | **< 600dp** | compact | ⭐ **Single column is the primary design** — most students are < 600dp; ⛔ not a shrunken tablet layout |
| Medium | **600–904dp** | medium | **Single column** (two-pane only at ≥ 905dp per `DDR-0005`); gutter **`xl` = 24dp** (D-2, `DDR-0027` scale) |
| Expanded | **≥ 905dp** | expanded | **Two-pane** via the existing `LayoutBuilder` pattern; persistent navigation rail |

Rejection on record: CSS-pixel web breakpoints (375/768/1024/1440 px) are **not**
adopted; the conflict is preserved in `LIBOORA_UIUX_PRO_MAX_RULES.md` §6.

**Never, at any class:** horizontal scrolling of primary content · fixed pixel widths ·
disabling zoom. (`LIBOORA_MASTER_DESIGN_SYSTEM.md` §10.)

## 2. Layout adaptation rules per class

The per-class rules below restate `DDR-0005` consequences and `DDR-0004` density
resolutions. Decisions D-1 through D-4 are **APPROVED** by the Responsive Design Owner
(2026-10-01); `DDR-0004`/`DDR-0005` values and the `DDR-0027` scale are the governing
authority.

### 2.1 Compact (< 600dp)

| Item | Rule | Status |
|---|---|---|
| Columns | Single column only; gutter **`lg` = 16dp** | APPROVED — single column (`DDR-0005`); gutter D-2 (`DDR-0027` scale) |
| Navigation | Bottom navigation; category → detail **push** navigation | APPROVED (`DDR-0005`) |
| Density | 48dp touch targets apply; the dense 36px data row is **not** available on touch | APPROVED (`DDR-0004`: 36px only pointer-only ≥ 905dp) |
| Primary experience | The single-column student experience is the primary design; wider classes must never be treated as the source of truth and shrunk | APPROVED (`DDR-0005`) |

### 2.2 Medium (600–904dp)

| Item | Rule | Status |
|---|---|---|
| Columns | Single column; gutter **`xl` = 24dp** from the ratified `LiblSpace` scale (`DDR-0027`) | **APPROVED** — D-2 (`RESPONSIVE_DESIGN_APPROVAL_RECORD_2026-10-01.md`) |
| Two-pane | ⛔ **Not approved at medium — deviation rejected.** `DDR-0005` consequences: "Two-pane **only at ≥ 905dp**". The PROPOSED `LIBOORA_MASTER_DESIGN_SYSTEM.md` §10 "optional two-pane at 600–904dp" was **rejected** by the Responsive Design Owner (D-1); medium is single column. | **APPROVED** — D-1 (single-column per `DDR-0005`) |
| Navigation | Bottom navigation retained | APPROVED (`DDR-0005`) |
| Density | 36px dense rows **still unavailable** — pointer-only ≥ 905dp is the sole dense-row context | APPROVED (`DDR-0004`) |

### 2.3 Expanded (≥ 905dp)

| Item | Rule | Status |
|---|---|---|
| Columns | **Two-pane** via the existing `LayoutBuilder` pattern; persistent nav rail; gutter **`xxl` = 32dp** | APPROVED — two-pane (`DDR-0005`); gutter D-2 (`DDR-0027` scale) |
| Navigation | Persistent navigation rail replaces bottom navigation | APPROVED (`DDR-0005`) |
| Density | 36px dense data rows permitted **only** in this pointer-only context, with 48dp touch targets still applying wherever touch is used | APPROVED (`DDR-0004` consequence) |

## 3. Adaptation of foundation elements

No value below is new; each row states which APPROVED decision governs it. D-1 through
D-4 are APPROVED (Responsive Design Owner, 2026-10-01); `DDR-0004`/`DDR-0005` values and
the `DDR-0027` scale are the governing authority.

| Element | Adaptation rule | Governed by |
|---|---|---|
| **Navigation** | Compact: bottom nav + push · Medium: bottom nav, **single column** (two-pane only at ≥ 905dp per `DDR-0005`; the medium two-pane deviation was **rejected** by the Responsive Design Owner, D-1) · Expanded: rail + two-pane | `DDR-0005` (APPROVED); **APPROVED D-1** |
| **Grid / columns** | Column count is the only structural variable: 1 → 1 → 2-pane rail layout (APPROVED by `DDR-0005`: two-pane only at ≥ 905dp; the optional medium-class two-pane is **rejected**, D-1). No per-surface column grids are defined here; surfaces state their own panes in screen specs. | `DDR-0005` (APPROVED); **APPROVED D-1** |
| **Spacing** | Gutter mapping is **APPROVED** (D-2, `DDR-0027` scale): **Compact < 600dp → `lg` = 16dp · Medium 600–904dp → `xl` = 24dp · Expanded ≥ 905dp → `xxl` = 32dp**. Wider classes step up one scale level. Group spacing remains drawn from the ratified 6-step scale. The PROPOSED `space/5 = 20` step is **not** used here. | `DDR-0027` (ratified scale); **APPROVED D-2** |
| **Typography** | Type scale is class-invariant (base 16px; 12–30 scale; 12px non-essential metadata only; tabular-lining numerals; line-heights 1.5 body / 1.25 headings; weights 400–700). Layouts at **every** class must survive **200%** text scale without loss of function; narrow-width survival is tested at Compact. No size or weight changes per class. | `DDR-0029` / `DDR-0031` / `DDR-0032` (APPROVED/RATIFIED/DECIDED); `DDR-0004` 200% rule (APPROVED) |
| **Components** | Component **structure and required states are class-invariant** (APPROVED D-4); responsive differences are limited to **layout placement, stacking, pane membership, and gutter/spacing adaptation**. 48×48dp touch targets and ≥8dp target spacing hold at **all** classes. | `DDR-0004` (APPROVED); **APPROVED D-4** |
| **Motion** | Class changes must not rely on animation to communicate structure; reduced motion renders the static final state at every class. | `DDR-0004` reduced-motion rule (APPROVED) |

## 4. Major-surface adaptation

Class behavior for the surfaces named in the current screen families
(`SCREEN_ARCHITECTURE.md` §1). ⛔ This table defines layout **placement** only — it
approves no surface, field, or behavior; each surface's own traceability row governs.

| Surface | Compact < 600dp | Medium 600–904dp | Expanded ≥ 905dp |
|---|---|---|---|
| Discover / Search (public) | Single-column results | Single-column results, gutter `xl` 24dp | List column + result detail pane (two-pane) |
| Library Profile (public) | Single column, push navigation | Single column | Detail pane beside navigation |
| Availability (public aggregate / private seat read) | Single column; aggregate indicator only, as bounded by `LIB-14B.11`–`.14` | Same, gutter `xl` 24dp | Same; pointer-only dense rows permitted for seat tables |
| Shift / Seat selection (protected) | Single column | **Single column** (two-pane only at ≥ 905dp; medium deviation rejected, D-1) | Two-pane list/detail |
| Booking outcome (protected) | Single column | Single column | Detail pane beside navigation |
| Operational dashboard (Owner/Manager/Reception compositions) | Single column; metric cards stack | Single column, gutter `xl` 24dp | Rail + two-pane metric/detail layout; dense rows pointer-only |
| Student / Parent dashboards | Single column | Single column | Detail pane beside navigation |

⚠️ **Not covered:** surfaces deferred from V1 (`DESIGN_IMPLEMENTATION_TRACEABILITY.md`
§8.1) have no adaptation rule here; Community is V2.

## 5. Device modes

- Liboora targets **Android dp** devices. Foldable, tablet, and large-phone modes are
  governed by the same three window classes — ⛔ no per-form-factor mode is invented here.
- Device capabilities and network behavior are **not** assumed by this document
  (`DESIGN_OWNERSHIP.md`: "Cannot assume device capabilities or network behavior not
  sourced"). Constrained-network and low-end behavior are specified by
  [`PERFORMANCE.md`](PERFORMANCE.md) §3, not by class.

## 6. Status, approval, and open items

| Item | Value |
|---|---|
| This artifact | ⭐ **APPROVED** — v0.1, 2026-10-01, **Responsive Design Owner** (record: [`RESPONSIVE_DESIGN_APPROVAL_RECORD_2026-10-01.md`](RESPONSIVE_DESIGN_APPROVAL_RECORD_2026-10-01.md)). It carries `DDR-0005`'s APPROVED classes and `DDR-0004`'s APPROVED density rules, and records D-1 through D-4 as approved by the Responsive Design Owner. |
| `DBT-002` | ⭐ **RESOLVED / CLOSED.** The Responsive Design Owner's approval act (recorded 2026-10-01) satisfies the closure reserved to the owning office by `DESIGN_DEBT.md` §3 rule 5. |
| Open items | **None within DBT-002 scope.** Future per-surface pane documentation, where needed, belongs to the individual screen specifications under `DESIGN_CHANGE_MANAGEMENT.md` D3 and is outside this closure. |
| G2 | ⛔ **G2 is not passed** by this approval. G2 approval is a separate owner act (`DESIGN_GOVERNANCE.md` §4). This record does **not** constitute G1/G2, Design System, Accessibility, UX Architecture, or Founder/Product Authority approval, nor application/code approval. |

## 7. Change control

- Supersession or amendment of this document follows [`DESIGN_CHANGE_MANAGEMENT.md`](DESIGN_CHANGE_MANAGEMENT.md) §1 (D2 design-system change path).
- A Material 3 window-class revision or a new form factor is the `DDR-0005` review trigger.
