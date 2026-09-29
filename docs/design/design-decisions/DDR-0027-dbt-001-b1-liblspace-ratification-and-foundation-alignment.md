<!-- LIBOORA Design Documentation | Design Decision Record | 2026-09-28 -->

> This document is design governance and documentation. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles,
> scopes or backend contracts.

# DDR-0027 — `DBT-001` B1: `LiblSpace` scale ratified and `DESIGN_SYSTEM.md` §2 colour/spacing rows aligned to the decided values

| Field | Value |
|---|---|
| **Register** | ⭐ Filed under [`README.md`](README.md) §2 template and §4 filing rules · global identifier `DDR-0027` (`DDR-0026` is the last filed — *never reused, never reassigned*) |
| ⭐⭐ **Status** | ⭐⭐ **CONFIRMED / CONFERRED** — Design System Owner decision recorded per the principal's conferral |
| **Date** | 2026-09-28 (recording date = session date of the conferral; no date invented beyond it) |
| ⭐⭐ **Owner** | ⭐⭐ **Design System Owner** *(role, never a personal name — `PRD_OWNERSHIP_MODEL` §7 rule 4)* |
| ⭐⭐ **Approver / authority instrument** | ⭐ Recorded **verbatim in this header**, on the [`ADR-0147`](../../00-governance/adr/ADR-0147-twelve-dashboardmetrics-counters-certified-anl-obd-001-resolved.md) / `DDR-0026` precedent *(whose cited owner-decision forms were themselves blank templates; the operative authority was the principal's quoted instruction)*: *"Design System Owner has now conferred Option B1 as recorded."* — Option B1 being the B1 remainder identified in the `DBT-001` owner-decision preparation: **Option B (amend-and-align), spacing limb closed by ratifying the shipped `LiblSpace` scale; colour limb cross-cited to the already-`APPROVED` `DDR-0001`; typography-family limb explicitly kept `OPEN` under `DDR-0002`** |
| **Scope** | `DBT-001` by limb: spacing limb (ratify `LiblSpace`), colour limb (align `DESIGN_SYSTEM.md` §2 to `DDR-0001`'s `APPROVED` values), typography-family limb (preserved `OPEN` under `DDR-0002`) |
| **Change class** | ⭐ **D2 — Design-system change** *(`DESIGN_CHANGE_MANAGEMENT.md` §1)*: a foundation ratification/alignment act. ⛔ **No D5 limb** — ⛔ no requirement, permission, BC ownership, backend or contract change |
| ⛔ **What this record does NOT do** | ⛔ Does **NOT** authorize any change to `lib/app/shared/theme.dart` — the spacing ratification **adopts the shipped values as the decided tokens**, and ⛔ any future colour implementation conformance (shipped `text-muted` `#6B7194` → `DDR-0001`'s `#5F6585`, plus `accent-ink`/`border/control` additions) remains **separate implementation work** that this record does not release · ⛔ does **NOT** close the typography-family limb (family remains `TO BE DECIDED` under `DDR-0002`) · ⛔ does **NOT** create a DD, PRD, ADR, dashboard PRD, or design surface · ⛔ creates **no** role, permission, `PERM-*`, aggregate or identifier · ⛔ does **NOT** authorize implementation, a PRD, an architecture decision, or a release *(`DESIGN_GOVERNANCE.md` §3 rule 5)* · ⛔ **no value is invented** — every number below is measured from `lib/app/shared/theme.dart` or cross-cited from `APPROVED` `DDR-0001` |

---

## 1. The decision

> `DBT-001` (`DESIGN_DEBT.md` L37, ⛔ OPEN) records the debt: `DESIGN_SYSTEM.md` §2
> declared colour and spacing token values `TO BE DECIDED` while `lib/app/shared/theme.dart`
> (2026-09-07) had already shipped a 12-constant colour set and a 6-step spacing scale, and
> the later foundation document (2026-09-09) still described the decision as unmade.
> `DESIGN_DEBT.md` §3 rule 5 (L84–89) bars closing the row by silent document edit: the
> closing act belongs to the owning office — **Design System Owner**.

The Design System Owner's **Option B1** closes the row **by limb**:

| Limb | Decision | Authority |
|---|---|---|
| **Colour** | ⭐ **RESOLVED — aligned, not re-decided.** `DESIGN_SYSTEM.md` §2 colour row is aligned to `APPROVED` `DDR-0001`'s values (the 5 amended + 7 unchanged tokens). No new colour decision is taken here | [`DDR-0001`](DDR-0001-to-0009-founder-product-authority-decisions.md) L25–38 (`APPROVED`, Design System Owner, 2026-09-19) |
| **Spacing** | ⭐ **RESOLVED — ratified.** The 6-step `LiblSpace` scale is ratified as the design token scale; `DESIGN_SYSTEM.md` §2 spacing row amended from `TO BE DECIDED` to the ratified values | This record (`DDR-0027`), the Design System Owner act the register owed |
| **Typography-family** | ⛔ **OPEN — explicitly preserved.** `DDR-0002` approved the Indic/Devanagari *requirement*; the specific family + licence remains `TO BE DECIDED`. This record **does not select a family** | [`DDR-0002`](DDR-0001-to-0009-founder-product-authority-decisions.md) L47–64 (`APPROVED (requirement) · TO BE DECIDED (family)`) |

## 2. The ratified spacing scale — `LiblSpace` (evidence: `lib/app/shared/theme.dart` L29–35)

| Step | Value | Source evidence |
|---|---|---|
| `xs` | **4** | `theme.dart` L30 |
| `sm` | **8** | `theme.dart` L31 |
| `md` | **12** | `theme.dart` L32 |
| `lg` | **16** | `theme.dart` L33 |
| `xl` | **24** | `theme.dart` L34 |
| `xxl` | **32** | `theme.dart` L35 |

⭐ **Ratification is adoption of the shipped scale as the decided scale.** Because the
ratified values equal the shipped ones, ⛔ **0 implementation change is required for the
spacing limb**. The register's review trigger ("a token change in either direction, or
approval of the design system foundation", `DESIGN_DEBT.md` L37) is met by this approval.

## 3. The colour alignment — cross-cited, not re-decided (`DDR-0001` L35, `APPROVED`)

| Token | Value | `DDR-0001` disposition | `theme.dart` as shipped | Implementation conformance |
|---|---|---|---|---|
| `accent-ink` | `#92400E` | ⭐ **NEW** (text/icons) | ⛔ not present | ⚠️ **separate implementation work** |
| `accent-fill` | `#F5A524` | ⭐ RETAINED (`accent`, fills only, paired with `textPrimary`) | `#F5A524` ✅ conforms | ⛔ none |
| `text-muted` | `#5F6585` | ⭐ **replaces `#6B7194`** | `#6B7194` ⛔ non-conforming | ⚠️ **separate implementation work** |
| `border/decorative` | `#E3E6F0` | ⭐ RETAINED | `#E3E6F0` ✅ conforms | ⛔ none |
| `border/control` | `#7F87A6` | ⭐ **NEW** | ⛔ not present | ⚠️ **separate implementation work** |
| ⭐ 7 unchanged | `brand`, `brandDark`, `success`, `warning`, `danger`, `info`, `textPrimary` | ⭐ UNCHANGED | conform | ⛔ none |

⚠️⚠️ **The alignment documents the decided values. It does not claim they are implemented.**
The three non-conforming deltas (`accent-ink` missing, `text-muted` at `#6B7194`,
`border/control` missing) are **carried as outstanding implementation work** — ⛔ not
performed by this governance act, ⛔ not authorized by it, and ⛔ not to be "fixed" by
editing `theme.dart` under cover of this record.

## 4. Relationship to `DBT-005` (stated explicitly, per the remediation requirement)

`DBT-005` (`DESIGN_DEBT.md` L41) indicts **radius, elevation and typography tokenisation** —
⛔ a different debt from `DBT-001`'s colour/spacing value debt. This record's spacing
**ratification** satisfies `DBT-001`'s spacing limb **only**. The *type-token-class*
absence (`DESIGN_SYSTEM.md` §2.1, `FIGMA_FOUNDATION.md` L30) remains inside `DBT-005`'s
scope, and the **typeface family** decision remains inside `DDR-0002`'s open limb. ⛔ No
`DBT-005` row is closed by this act.

## 5. Consequences (executed in this act — in-place, no new identifiers)

| # | File | Alignment |
|---|---|---|
| 1 | `docs/design/DESIGN_SYSTEM.md` §2 | Colour row → `DECIDED (DDR-0001)` with the 12-token inventory; Spacing row → `RATIFIED (DDR-0027)` with the 6-step scale; Typography row → `REQUIREMENT DECIDED (DDR-0002) · FAMILY TO BE DECIDED` (unchanged open limb) |
| 2 | `docs/design/DESIGN_SYSTEM.md` §2.1 | Finding re-stated: colour/spacing limbs **decided**; the open items are now exactly two — typeface family (`DDR-0002`) and the implementation-conformance deltas + `DBT-005` token classes |
| 3 | `docs/design/DESIGN_DEBT.md` L37 `DBT-001` | Status `⛔ OPEN` → **`PARTIALLY RESOLVED (by limb)`** with per-limb disposition recorded; §2.1 measures re-rolled: `OPEN 7 → 6`, `PARTIALLY RESOLVED (by limb) = 1 (DBT-001)`, `Resolved 0` (a partially-resolved row is not counted `Resolved` — rule 5) |

## 6. Non-consequences (explicit)

- ⛔ **`lib/app/shared/theme.dart` unmodified** — verified by `git diff` after this act.
- ⛔ No DD, no PRD, no ADR, no dashboard PRD, no design surface, no implementation task.
- ⛔ Typography family **not invented, not selected** — `DDR-0002`'s open limb untouched.
- ⛔ No role, permission, `PERM-*`, aggregate or identifier minted.
- ⛔ **No implementation authorization** (`DESIGN_GOVERNANCE.md` §3 rule 5).
- ⛔ `DBT-005` remains ⛔ OPEN; the colour-conformance deltas remain outstanding implementation work.
- ⛔ No commit, no push performed by this act.

## 7. Changelog

| Version | Date | Change | Rationale |
|---|---|---|---|
| **v0.1** | 2026-09-28 | ⭐⭐ **Created and CONFIRMED / CONFERRED in one act.** Design System Owner Option B1: spacing limb **ratified** (`LiblSpace` 4/8/12/16/24/32 — 0 implementation delta), colour limb **aligned** to `APPROVED` `DDR-0001` (5 amended + 7 unchanged tokens; 3 conformance deltas carried as separate implementation work), typography-family limb **preserved OPEN** under `DDR-0002`. In-place amends executed at `DESIGN_SYSTEM.md` §2/§2.1 and `DESIGN_DEBT.md` L37/§2.1 (by-limb status; measures re-rolled `OPEN 7 → 6`, `Resolved 0` preserved). ⛔ 0 new identifiers · ⛔ 0 code · ⛔ 0 commits by this act · ⛔ `DBT-005` untouched | The `DESIGN_DEBT.md` §3 rule 5 act the register owed: a row is closed (by limb) only when its owning office decides it — the principal conferral *"Design System Owner has now conferred Option B1 as recorded"* recorded verbatim per the `ADR-0147`/`DDR-0026` precedent |
