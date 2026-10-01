<!-- LIBOORA Design Documentation Foundation | 2026-10-01 -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Responsive Design

| Field | Value |
|---|---|
| Status | **PROPOSED — drafted by AI; Responsive Design Owner approval not yet recorded** |
| Owner | **Responsive Design Owner** (`DESIGN_OWNERSHIP.md` §1 — "Owns breakpoint behavior, layout adaptation, and device-mode rules"; approval route per `DESIGN_OWNERSHIP.md` §1; escalation to Design Governance Owner) |
| Authority | `DDR-0005` — **APPROVED** (breakpoint values, Founder/Product Authority, 2026-09-19) |
| Rule | This artifact carries the APPROVED `DDR-0005` classes and states layout-adaptation rules. Where a rule is not fixed by an APPROVED decision it is marked **RECOMMENDED** and requires Responsive Design Owner approval. No new breakpoint value is invented. |

## 1. Window size classes (APPROVED — `DDR-0005`)

Liboora is a Flutter/Android-first product; widths are measured in **dp**, using
**Material 3 window size classes** as the external citable standard. These values are
**APPROVED** — this document records them, it does not decide them.

| Class | Range | `DDR-0005` label | Layout outcome (per `DDR-0005` consequences) |
|---|---|---|---|
| Compact | **< 600dp** | compact | ⭐ **Single column is the primary design** — most students are < 600dp; ⛔ not a shrunken tablet layout |
| Medium | **600–904dp** | medium | **Single column** (two-pane only at ≥ 905dp per `DDR-0005`); wider gutters RECOMMENDED from `DDR-0027` |
| Expanded | **≥ 905dp** | expanded | **Two-pane** via the existing `LayoutBuilder` pattern; persistent navigation rail |

Rejection on record: CSS-pixel web breakpoints (375/768/1024/1440 px) are **not**
adopted; the conflict is preserved in `LIBOORA_UIUX_PRO_MAX_RULES.md` §6.

**Never, at any class:** horizontal scrolling of primary content · fixed pixel widths ·
disabling zoom. (`LIBOORA_MASTER_DESIGN_SYSTEM.md` §10.)

## 2. Layout adaptation rules per class

The per-class rules below restate `DDR-0005` consequences and `DDR-0004` density
resolutions. Rows marked RECOMMENDED are authored guidance, not approved values.

### 2.1 Compact (< 600dp)

| Item | Rule | Status |
|---|---|---|
| Columns | Single column only | APPROVED (`DDR-0005`) |
| Navigation | Bottom navigation; category → detail **push** navigation | APPROVED (`DDR-0005`) |
| Density | 48dp touch targets apply; the dense 36px data row is **not** available on touch | APPROVED (`DDR-0004`: 36px only pointer-only ≥ 905dp) |
| Primary experience | The single-column student experience is the primary design; wider classes must never be treated as the source of truth and shrunk | APPROVED (`DDR-0005`) |

### 2.2 Medium (600–904dp)

| Item | Rule | Status |
|---|---|---|
| Columns | Single column; **wider gutters** from the ratified `LiblSpace` scale | Gutters RECOMMENDED from `DDR-0027` scale (`sm 8 · md 12 · lg 16 · xl 24 · xxl 32`) |
| Two-pane | ⛔ **Not approved at medium.** `DDR-0005` consequences: "Two-pane **only at ≥ 905dp**". The PROPOSED `LIBOORA_MASTER_DESIGN_SYSTEM.md` §10 "optional two-pane at 600–904dp" is a **deviation** from the APPROVED decision and is **not** adopted here; single column remains the rule at medium | APPROVED single-column (`DDR-0005`); medium two-pane = **RECOMMENDED deviation, owner decision required** |
| Navigation | Bottom navigation retained | APPROVED (`DDR-0005`) |
| Density | 36px dense rows **still unavailable** — pointer-only ≥ 905dp is the sole dense-row context | APPROVED (`DDR-0004`) |

### 2.3 Expanded (≥ 905dp)

| Item | Rule | Status |
|---|---|---|
| Columns | **Two-pane** via the existing `LayoutBuilder` pattern; persistent nav rail | APPROVED (`DDR-0005`) |
| Navigation | Persistent navigation rail replaces bottom navigation | APPROVED (`DDR-0005`) |
| Density | 36px dense data rows permitted **only** in this pointer-only context, with 48dp touch targets still applying wherever touch is used | APPROVED (`DDR-0004` consequence) |

## 3. Adaptation of foundation elements

No value below is new; each row states which APPROVED decision governs it, and what
remains RECOMMENDED guidance.

| Element | Adaptation rule | Governed by |
|---|---|---|
| **Navigation** | Compact: bottom nav + push · Medium: bottom nav, optional list/detail two-pane · Expanded: rail + two-pane | `DDR-0005` (APPROVED) |
| **Grid / columns** | Column count is the only structural variable: 1 → 1 → 2-pane rail layout (APPROVED by `DDR-0005`: two-pane only at ≥ 905dp). The optional medium-class two-pane is a RECOMMENDED deviation (§2.2), not an approved layout. No per-surface column grids are defined here; surfaces state their own panes in screen specs. | `DDR-0005` (APPROVED); medium two-pane RECOMMENDED deviation; per-surface panes RECOMMENDED in screen specs |
| **Spacing** | Gutter and group spacing always drawn from the ratified 6-step scale (`xs 4 · sm 8 · md 12 · lg 16 · xl 24 · xxl 32`); wider classes may step up one scale level for gutters. The PROPOSED `space/5 = 20` step is **not** used here — it is an open PROPOSED addition and this artifact does not adopt it. | `DDR-0027` (ratified scale); gutter step-up RECOMMENDED |
| **Typography** | Type scale is class-invariant (base 16px; 12–30 scale; 12px non-essential metadata only; tabular-lining numerals; line-heights 1.5 body / 1.25 headings; weights 400–700). Layouts at **every** class must survive **200%** text scale without loss of function; narrow-width survival is tested at Compact. No size or weight changes per class. | `DDR-0029` / `DDR-0031` / `DDR-0032` (APPROVED/RATIFIED/DECIDED); `DDR-0004` 200% rule (APPROVED) |
| **Components** | Component **structure** is class-invariant; only layout placement (stacking, pane membership, gutter) changes per class. Required component states (loading/empty/error/offline per `DESIGN_SYSTEM.md` §4) are unaffected by class. 48×48dp targets and ≥8dp target spacing hold at **all** classes. | `DDR-0004` (APPROVED); `DESIGN_SYSTEM.md` §4 (PROPOSED foundation) |
| **Motion** | Class changes must not rely on animation to communicate structure; reduced motion renders the static final state at every class. | `DDR-0004` reduced-motion rule (APPROVED) |

## 4. Major-surface adaptation

Class behavior for the surfaces named in the current screen families
(`SCREEN_ARCHITECTURE.md` §1). ⛔ This table defines layout **placement** only — it
approves no surface, field, or behavior; each surface's own traceability row governs.

| Surface | Compact < 600dp | Medium 600–904dp | Expanded ≥ 905dp |
|---|---|---|---|
| Discover / Search (public) | Single-column results | Single-column results, wider gutters | List column + result detail pane (two-pane) |
| Library Profile (public) | Single column, push navigation | Single column | Detail pane beside navigation |
| Availability (public aggregate / private seat read) | Single column; aggregate indicator only, as bounded by `LIB-14B.11`–`.14` | Same, wider gutters | Same; pointer-only dense rows permitted for seat tables |
| Shift / Seat selection (protected) | Single column | Single column (two-pane RECOMMENDED at medium pending owner decision) | Two-pane list/detail |
| Booking outcome (protected) | Single column | Single column | Detail pane beside navigation |
| Operational dashboard (Owner/Manager/Reception compositions) | Single column; metric cards stack | Single column with wider gutters | Rail + two-pane metric/detail layout; dense rows pointer-only |
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
| This artifact | ⭐ **PROPOSED — drafted by AI on 2026-10-01.** It carries `DDR-0005`'s APPROVED classes and `DDR-0004`'s APPROVED density rules. RECOMMENDED rows are new authored guidance. **Responsive Design Owner approval is not recorded** and is required before this document is cited as the responsive specification (`DESIGN_OWNERSHIP.md` §3 — approval must name artifact, version, status, approver role, date, and unresolved conditions). |
| `DBT-002` | ⛔ **Still OPEN.** This artifact supplies the missing responsive specification, but `DESIGN_DEBT.md` §3 rule 5 reserves closing the debt to the owning office's act, and the row itself states breakpoints are a design decision deliberately not invented here. The Responsive Design Owner's approval act is the closure. |
| Open items | 1) Responsive Design Owner approval of §2–§4 RECOMMENDED rows · 2) gutter step-up (§3) · 3) two-pane optionality scope for list/detail surfaces (§2.2). None of these may be closed by editing this document without the owner's act. |
| G2 | ⛔ **G2 is not passed** by this artifact. G2 approval is a separate owner act (`DESIGN_GOVERNANCE.md` §4). |

## 7. Change control

- Supersession or amendment of this document follows [`DESIGN_CHANGE_MANAGEMENT.md`](DESIGN_CHANGE_MANAGEMENT.md) §1 (D2 design-system change path).
- A Material 3 window-class revision or a new form factor is the `DDR-0005` review trigger.
