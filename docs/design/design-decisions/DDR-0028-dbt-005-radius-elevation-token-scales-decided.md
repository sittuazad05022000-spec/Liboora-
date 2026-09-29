<!-- LIBOORA Design Documentation | Design Decision Record | 2026-09-29 -->

> This document is design governance and documentation. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles,
> scopes or backend contracts.

# DDR-0028 — `DBT-005` by-limb act: radius token scale ratified (adopting `DDR-0003` values) and elevation scale decided

| Field | Value |
|---|---|
| **Register** | ⭐ Filed under [`README.md`](README.md) §2 template and §4 filing rules · global identifier `DDR-0028` (`DDR-0027` is the last filed — *never reused, never reassigned*) |
| ⭐⭐ **Status** | ⭐⭐ **CONFIRMED / CONFERRED** — Design System Owner decision recorded per the principal's conferral |
| **Date** | 2026-09-29 (recording date = session date of the conferral; no date invented beyond it) |
| ⭐⭐ **Owner** | ⭐⭐ **Design System Owner** *(role, never a personal name — `PRD_OWNERSHIP_MODEL` §7 rule 4)* |
| ⭐⭐ **Approver / authority instrument** | ⭐ Recorded **verbatim in this header**, on the [`ADR-0147`](../../00-governance/adr/ADR-0147-twelve-dashboardmetrics-counters-certified-anl-obd-001-resolved.md) / `DDR-0026` / `DDR-0027` precedent *(operative authority = the principal's quoted instruction)*: *"On the basis of Sonnet's verified DBT-005 audit, execute EXACTLY ONE governance act in the repository. … Record the Design System Owner act in DDR-0028: (1) RADIUS — adopt/ratify the token class sm = 8, md = 12, lg = 16, source: existing approved DDR-0003; retire 14/18 as implementation-conformance; pill = status chips only. (2) ELEVATION — decide a small semantic decoration-free scale from existing repository conventions. (3) amend `DESIGN_SYSTEM.md` §2 radius + elevation rows. (4) update `DBT-005` to by-limb status — type-token class stays OPEN under `DDR-0002`. No `theme.dart` edits. No new DD/PRD/ADR. Do not mark `DBT-005` fully RESOLVED."* |
| **Scope** | `DBT-005` by limb: radius limb (ratify the token class on `DDR-0003`'s approved values), elevation limb (decide the small semantic scale), type-token-class limb (**preserved `OPEN`** — gated on `DDR-0002`'s family decision) |
| **Change class** | ⭐ **D2 — Design-system change** *(`DESIGN_CHANGE_MANAGEMENT.md` §1)*: a foundation token-scale decision + in-place document alignment. ⛔ **No D5 limb** — ⛔ no requirement, permission, BC ownership, backend or contract change |
| ⛔ **What this record does NOT do** | ⛔ Does **NOT** modify `lib/app/shared/theme.dart` or any implementation file — the retired radii (`14`, `18`) and the missing `LiblRadius` class are **implementation-conformance work, ⛔ not performed or released here** · ⛔ does **NOT** close the type-token-class limb (the typeface family remains `TO BE DECIDED` under `DDR-0002`; the type-token class is ⛔ **not** decided by this record) · ⛔ does **NOT** create a DD, PRD, ADR, dashboard PRD, or design surface · ⛔ creates **no** role, permission, `PERM-*`, aggregate or identifier · ⛔ **no elevation/radius value is invented** — radius adopts `APPROVED` `DDR-0003` verbatim; elevation adopts the repository's own proposed 3-level scale as evidence · ⛔ **no Figma claim** — no canonical Figma file exists in the repository; `FIGMA_FOUNDATION.md` L30 remains a TO-BE-DECIDED-locally-in-Figma note, untouched · ⛔ does **NOT** authorize implementation, a PRD, an architecture decision, or a release *(`DESIGN_GOVERNANCE.md` §3 rule 5)* |

---

## 1. The decision (by limb)

> `DBT-005` (`DESIGN_DEBT.md` L41, ⛔ OPEN) records the debt: radius is used but not
> tokenised — `theme.dart` carries **7** `BorderRadius.circular(...)` calls across **3**
> values (`12`, `14`, `18`) with **no `LiblRadius` class**; ⚠️ elevation and typography
> share the position ("no token class exists for either"). The closing act belongs to the
> owning office — **Design System Owner** (`DESIGN_DEBT.md` §3 rule 5).

| Limb | Decision | Authority |
|---|---|---|
| **Radius** | ⭐ **RESOLVED — ratify the token class on the already-`APPROVED` values.** `LiblRadius` = `sm` **8** · `md` **12** · `lg` **16**; ⛔ **`14` and `18` RETIRED**; **pill reserved for status chips only**. No new radius value is invented — every figure is `DDR-0003`'s | [`DDR-0003`](DDR-0001-to-0009-founder-product-authority-decisions.md) L65–73 (`APPROVED`, 2026-09-19) · this record (`DDR-0028`) |
| **Elevation** | ⭐ **RESOLVED — a 3-level semantic, decoration-free scale decided from the repository's own evidence.** `elev/0` **flat on canvas** *(default — most surfaces)* · `elev/1` **cards, raised rows** *(hairline border **+** one soft y-shadow)* · `elev/2` **sheets, dialogs, menus** *(transient overlays only)*. ⛔ **No `elev/3+`.** ⛔ No coloured, glowing or neon shadows. *Borders first, elevation second* | This record (`DDR-0028`); evidence at §2 below |
| **Type-token class** | ⛔ **OPEN — explicitly preserved.** The typeface family is still `TO BE DECIDED` under `DDR-0002` *(requirement `APPROVED`, family not selected)*; a type token class **cannot** be decided against an undecided family. ⛔ **Not closed by this act** | [`DDR-0002`](DDR-0001-to-0009-founder-product-authority-decisions.md) L47–64 · `DBT-001`'s open typography limb (L37, "carried into `DBT-005`") |

## 2. The elevation decision — repository evidence (values NOT invented)

The scale above is **not an arbitrary choice**; it is the repository's own proposed
elevation treatment, adopted by the Design System Owner:

| Evidence | Location |
|---|---|
| ⭐ **The 3-level scale itself** — `elev/0` flat default · `elev/1` cards/raised rows (hairline border + one soft y-shadow) · `elev/2` sheets/dialogs/menus (transient overlays only) · "No `elev/3+`. No coloured, glowing or neon shadows" | [`LIBOORA_MASTER_DESIGN_SYSTEM.md`](../LIBOORA_MASTER_DESIGN_SYSTEM.md) **§7 "Elevation — PROPOSED"** L232–244 |
| ⭐ **"Borders first, elevation second"** — depth principle | `LIBOORA_MASTER_DESIGN_SYSTEM.md` §2 depth row **L104** |
| ⭐ **Shipped behaviour agrees** — flat defaults (`elevation: 0` at `theme.dart` L56 card, L67) with a **single** raised surface (`elevation: 8` at L120) — i.e. the code already uses a minimal, flat-first elevation posture consistent with a 3-level semantic scale | `lib/app/shared/theme.dart` L56, L67, L120 |
| ⭐ **The governing direction** — "Small number of semantic levels for grouping and priority, not decoration" | [`DESIGN_SYSTEM.md`](../DESIGN_SYSTEM.md) §2 Elevation row (pre-amendment, L24) |
| ⛔ **0 elevation decision existed before this record** — `grep -i "elevation.*APPROVED\|APPROVED.*elevation"` across `design-decisions/` → 0 hits | verified 2026-09-29 |

⚠️ The master document is `PROPOSED` / UNRANKED; this record is the Design System
Owner's act **deciding** that scale, which is the register's own review trigger
("Introduction of a radius, elevation or type token set", `DESIGN_DEBT.md` L41).
Adopting 3 levels is the minimal, decoration-free reading of every source above —
**no `elev/3+`, no shadow-colour tokens, no invented complexity**.

## 3. Implementation boundary (explicit)

- ⛔ **`theme.dart` NOT modified.** The current code (L70 `14`, L76 `18`, L86/90/94/105/113 `12`; L56/67 `elevation: 0`, L120 `elevation: 8`) is **as-built evidence**, not a decision record.
- ⚠️ **Outstanding implementation work (carried, ⛔ not authorized here):** retire the `14`/`18` radii in favour of `sm 8 / md 12 / lg 16`; introduce the `LiblRadius` token class; align the single raised surface to the decided `elev/1` semantics. This is a **D2 conformance task** owned by the engineering counterpart, release-only after a separate authorization.
- ⛔ **No Figma claim** — no canonical Figma file exists in the repository; `FIGMA_FOUNDATION.md` L30's "TO BE DECIDED in the canonical Figma file" is untouched by this act.

## 4. Consequences (executed in this act — in-place, no new identifiers)

| # | File | Alignment |
|---|---|---|
| 1 | `DESIGN_SYSTEM.md` §2 **Radius row** | `RECOMMENDED` → `DECIDED (DDR-0003 + DDR-0028)` with `sm 8 · md 12 · lg 16`, `14`/`18` retired, pill = status chips only, `LiblRadius` class marked as outstanding conformance |
| 2 | `DESIGN_SYSTEM.md` §2 **Elevation row** | `RECOMMENDED` → `DECIDED (DDR-0028)` with the `elev/0` · `elev/1` · `elev/2` scale |
| 3 | `DESIGN_SYSTEM.md` §2.1 | Open-item 2 restated: radius + elevation token scales now **decided** (D2 conformance of the code remains open); the **type-token class stays `OPEN`** under `DDR-0002` |
| 4 | `DESIGN_DEBT.md` L41 **`DBT-005`** | Status `⛔ OPEN` → **`⚠️ PARTIALLY RESOLVED (by limb)`** — Radius ⭐ `DDR-0003`+`DDR-0028` · Elevation ⭐ `DDR-0028` · ⛔ Type-token class **OPEN** (`DDR-0002` family TBD); §2.1 measures re-rolled (`OPEN 6 → 5`, `PARTIALLY RESOLVED (by limb) 1 → 2`, `Resolved 0` preserved) |

## 5. Non-consequences (explicit)

- ⛔ **No `theme.dart` / no code, no test, no UI, no PRD, no DD, no ADR touched.**
- ⛔ **Type-token class NOT closed** — `DDR-0002`'s family limb untouched; `DBT-005` is **not** marked fully `Resolved`.
- ⛔ **`DBT-008` untouched** — this is a targeted owner act, not the broad foundation-approval act.
- ⛔ **0 new identifiers** beyond the next-free `DDR-0028`; **0 values invented** (radius = `DDR-0003`; elevation = the repository's own proposed scale).
- ⛔ **No commit, no push** performed by this act.

## 6. Changelog

| Version | Date | Change | Rationale |
|---|---|---|---|
| **v0.1** | 2026-09-29 | ⭐⭐ **Created and CONFIRMED / CONFERRED in one act.** Design System Owner: radius token class **ratified** on `APPROVED` `DDR-0003` values (`sm 8 / md 12 / lg 16`; `14`/`18` retired; pill = status chips only), elevation **3-level semantic scale decided** from the repository's own `PROPOSED` master-system §7 + shipped flat-first code posture (`elev/0` flat default · `elev/1` hairline + one soft y-shadow · `elev/2` transient overlays; ⛔ no `elev/3+`, no coloured shadows), type-token-class limb **preserved `OPEN`** under `DDR-0002`. In-place amends at `DESIGN_SYSTEM.md` §2/§2.1 and `DESIGN_DEBT.md` L41/§2.1 (by-limb status; measures re-rolled `OPEN 6 → 5`, `PARTIALLY RESOLVED (by limb) 1 → 2`, `Resolved 0` preserved). ⛔ 0 code · ⛔ 0 commits by this act · ⛔ `theme.dart` unmodified · ⛔ no Figma claim | The `DESIGN_DEBT.md` §3 rule 5 act the register owed: the row closes (by limb) only on the owning office's decision — principal conferral recorded verbatim on the `ADR-0147` / `DDR-0026` / `DDR-0027` precedent |
