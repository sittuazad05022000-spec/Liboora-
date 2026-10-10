<!-- LIBOORA Design Documentation Foundation | 2026-10-01 -->

> This document is a G4 QA-evidence preparation record. It is ⛔ **not** a gate
> record: it passes no gate, records no verdict, and changes no status. `G4`
> remains `PROPOSED` at `DESIGN_GOVERNANCE.md` §4 L46; gate count remains
> **4 of 6**; `G5` and `DBT-008` are untouched by this document.

# G4 — Design QA Evidence Preparation

| Field | Value |
|---|---|
| **Purpose** | Honest per-category preparation of the five `G4` evidence areas (`DESIGN_GOVERNANCE.md` §4 L46: *"visual, interaction, accessibility, responsive, and constrained-network behavior"*) using repository-observed evidence only |
| **Rules applied** | `DESIGN_QA.md` §2 — permitted evidence: Figma review record, annotated screenshots, state matrix, accessibility review, asset report, implementation comparison; each record must identify **artifact version** and **reviewer role**. `DESIGN_QA.md` §1 six checklist categories. `templates/DESIGN_QA_EVIDENCE_TEMPLATE.md` (unfilled; "a completed form is not a pass") |
| **Observed-absence vocabulary** | `NONE OBSERVED` = absence **measured** in the repository · `NOT AVAILABLE` = evidence type **does not exist** in the repository (e.g. no Figma file, no screenshots, no asset report) · ⛔ no invented screenshots, measurements, tests, Figma files/URLs, dates, or reviewer sign-offs |
| **Artifacts version-pinned by this preparation** | `DD-0001` v0.2 · `DD-0002` v0.1a · `DD-0003` v0.1 · `DD-0004` v0.1 (each header) · `RESPONSIVE_DESIGN.md` v0.1 (APPROVED, 2026-10-01) · `DESIGN_SYSTEM.md` (APPROVED, G2 record) · `ACCESSIBILITY.md` L10 (WCAG 2.1 AA via `DDR-0004` APPROVED) · `DESIGN_QA_EVIDENCE_TEMPLATE.md` (unfilled) |

---

## 1. Visual

| Evidence type (`DESIGN_QA.md` §2) | State | Location / measurement |
|---|---|---|
| Design-system conformance basis | ⭐ PRESENT (design-side) | `DESIGN_SYSTEM.md` APPROVED (G2, 2026-10-01) · token scales RESOLVED at value level (`DESIGN_DEBT.md` §2 `DBT-001`/`DBT-005`: `DDR-0001`/`0027`/`0028`/`0029`/`0031`/`0032`); ⛔ code conformance remains separate engineering work |
| 2.5D ratio + allocation per surface | ⭐ PRESENT (documented) | `DD-0001` §8 · `DD-0002` §8 · `DD-0004` §16.5/§18.5 (visual-language prohibitions honoured); `VISUAL_LANGUAGE.md` foundation |
| Figma review record | ⛔ **NOT AVAILABLE** | No canonical Figma file exists in the repository (A5 branch (b), `DDR-0028` L18: "no canonical Figma file exists") |
| Annotated screenshots | ⛔ **NOT AVAILABLE** | No screenshot artifact anywhere in the repository |
| Asset report / exports | ⛔ **NOT AVAILABLE** | 0 asset-export/usage-rule traces in `DD-0001…0004` (G3-accepted §1 handoff-package gap) |
| Implementation comparison (visual) | ⛔ **NONE OBSERVED** | No visual QA comparison record; the `theme.dart` conformance of decided tokens is unproven engineering work |

## 2. Interaction

| Evidence type | State | Location / measurement |
|---|---|---|
| State matrices (permitted `DESIGN_QA.md` §2 type) | ⭐ PRESENT (design-side) | `DD-0001` §7.1 (all six states × 13 surfaces) · `DD-0002` §7.2 (7 states × 14 surfaces) · `DD-0003` §10 (26 states on four axes) · `DD-0004` §11/§26.3 (29 frames; `L2` seat card 3 of 4 presence states — documented PARTIAL, `SEAT-BLOCK-001`) |
| Interaction / motion rules | ⭐ PRESENT (documented) | `DD-0001` §10.2 · `DD-0002` §10 · `DD-0003` §22 · `DD-0004` §27.6 (L3 gesture conflict recorded) |
| Not-evaluable interaction states | ⛔ **NONE OBSERVED (documented)** | `DD-0003` §32.1 row 4: *"26 named; ⛔ 5 not evaluable (`ATT-GAP-002a`)"* — 3 statuses + 2 Seat Card renderings, owner = Architecture Owner (`ADR-0029` Proposed); `DD-0004` §23.2 `L2` 3-of-4 (`SEAT-BLOCK-001`, `ADR-0032` L304) |
| Interaction QA review record | ⛔ **NOT AVAILABLE** | No per-surface reviewer result record (template unfilled; no `APPROVED`/`RETURNED` QA result rows exist in the repository) |

## 3. Accessibility

| Evidence type | State | Location / measurement |
|---|---|---|
| Design standard | ⭐ PRESENT | `ACCESSIBILITY.md` L10 — WCAG 2.1 AA via `DDR-0004` `APPROVED` 2026-09-19 (contrast 4.5:1 / 3:1; ≥48×48dp targets; ≥8dp spacing; functional at 200% text scale). ⚠ The **legal** compliance standard remains `TO BE DECIDED` (outside design authority; Founder/Product Authority confirms scope) |
| 9-check accessibility requirements | ⭐ PRESENT (documented) | `ACCESSIBILITY.md` §2 · `DD-0001` §11 · `DD-0002` §11 · `DD-0003` §21 (9-item checklist §21.9) · `DD-0004` §16 |
| Implementation a11y measurements | ⛔ **NONE OBSERVED (measured)** | `DIT-007` / `DIT-OD-003` (DIT L168): **0** occurrences of `Semantics`, `semanticsLabel`, `meetsGuideline`, or `textScaleFactor` under `lib/`; **0** accessibility assertions under `test/` |
| Accessibility review record | ⛔ **NOT AVAILABLE** | No reviewer record; `DIT-OD-003` ⛔ OPEN, accepted as G4 carry-forward at G3 (`DIT` §7.2 L194) — ⛔ remains OPEN by this document |
| `PRD-007` ratification gap | ⛔ **NONE OBSERVED (documented)** | `DD-0004` §26.7 item 2: `PRD-007` ratifies **no** accessibility requirement while `SEAT-FR-103` is colour-primary — recorded, not cured here |

## 4. Responsive

| Evidence type | State | Location / measurement |
|---|---|---|
| Responsive specification | ⭐ PRESENT + APPROVED | `RESPONSIVE_DESIGN.md` **v0.1 APPROVED** 2026-10-01 (Responsive Design Owner; `RESPONSIVE_DESIGN_APPROVAL_RECORD_2026-10-01.md`); `DBT-002` CLOSED / RESOLVED (`DESIGN_DEBT.md` L38) — the row itself records that G3 may evaluate responsive evidence against it |
| Breakpoint classes | ⭐ PRESENT | `DDR-0005` (`< 600dp` compact · `600–904dp` medium · `≥ 905dp` expanded), `D-1…D-4` recorded in `RESPONSIVE_DESIGN.md` |
| Per-DD device behaviour | ⭐ PRESENT (documented) | `DD-0001` §12 · `DD-0002` §12 · `DD-0003` §12.2 (multi-device 6 cases) + §25.5 (low-end device) · `DD-0004` §27 (mobile seat-map behaviour) |
| Annotated screenshots / responsive QA review | ⛔ **NOT AVAILABLE** | No visual responsive-evidence artifact exists in the repository |

## 5. Constrained-network / loading / error / offline / stale

| Evidence type | State | Location / measurement |
|---|---|---|
| Loading / empty / error / offline / stale state documentation | ⭐ PRESENT (documented) | `DD-0001` §7.2 (loading, 3 tiers) · §7.4 (error, two-layer) · §7.5 (offline — money boundary) · `DD-0002` §7.4/§7.5 · `DD-0003` §13.3 (loading, honest) · §25.3 (offline, authorised and bounded) · §25.5 (low-end device) · `DD-0004` §27.7 (loading · stale · empty · error recovery) |
| Performance guidance | ⚠ PRESENT at RECOMMENDED level | `PERFORMANCE.md` — `RECOMMENDED`; **numeric budgets `TO BE DECIDED`** (Design Performance Owner, with Engineering input) |
| Constrained-network QA evidence | ⛔ **NOT AVAILABLE** | No slow-network/offline review record; no surface tests for these states |
| Automated evidence | ⛔ **NONE OBSERVED (measured)** | Single UI-relevant assertion repository-wide: `test/widget_test.dart` *"app renders the login screen on first frame"* (one `testWidgets`; covers sign-in surface only — `DIT-003`). `DESIGN_QA.md` §2 / `DBT-004` (L40): the **819**-test passing suite tests domain rules, ⛔ **not UI evidence** — must not be cited as surface QA |
| Membership surface tests | ⛔ **NONE OBSERVED (measured)** | `DIT-009`: 15 membership test files listed as domain-level; **0 surface tests** (`DIT-OD-004`, DIT L169 — ⛔ remains OPEN by this document) |

## 6. Open-item status carried unchanged

| Item | Status after this preparation | Note |
|---|---|---|
| `DIT-OD-003` | ⛔ **OPEN** — G4 carry-forward (a11y evidence absent: 0 `lib/` occurrences, 0 `test/` assertions) | DIT L168/L194; closure is G4's act, not this document's |
| `DIT-OD-004` | ⛔ **OPEN** — G4 carry-forward (surface QA evidence for 7/8 base rows absent) | DIT L169/L195 |
| `DBT-004` | ⛔ **OPEN** — *"A G4 pass would rest on review judgement alone for every surface but one; trigger: any surface entering G4"* | `DESIGN_DEBT.md` L40 |
| `DBT-008` | ⛔ **OPEN** — G4 limb unrecorded; G5 unrecorded; final authority act pending | `DESIGN_DEBT.md` L44 (unchanged by this document) |
| `G4` gate | **`PROPOSED`** — gate count **4 of 6** | `DESIGN_GOVERNANCE.md` §4 L46/L49 (unchanged) |
| `DD-0001…0004` | All **`PROPOSED`** | headers untouched |

## 7. What this preparation is and is NOT

- ⭐ **Is:** a per-category inventory of (a) evidence that exists in the repository and may be attached to G4 QA records, and (b) the measured/typed absence of the rest, labelled `NONE OBSERVED` / `NOT AVAILABLE` per `DESIGN_QA.md` §2 and §3 disclosure practice.
- ⛔ **Is not:** a G4 verdict, a G4 gate record, a filled QA result record (the template stays unfilled), a status change, or a closure of `DIT-OD-003/004` or `DBT-004`.
- ⛔ No Figma file, frame, page, link, screenshot, measurement, test, PRD link, owner approval, date or authority is invented by this document; the only reviewer-role slot it fills is the **named role** `Design QA Owner` (per `DESIGN_GOVERNANCE.md` §4 L46) — no individual sign-off is claimed.
- Evidence for `G5` (change governance: version, impact, decision record, approvals) is out of scope here and remains unrecorded.
