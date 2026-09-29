<!-- LIBOORA Design Documentation | Design Decision Record | 2026-09-29 -->

> This document is design governance and documentation. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles,
> scopes or backend contracts.

# DDR-0031 — `DBT-005`: typography **sizes** and **line-heights** ratified (from `LIBOORA_MASTER_DESIGN_SYSTEM` §4 PROPOSED); **weights recorded OPEN**

| Field | Value |
|---|---|
| **Register** | ⭐ Filed under [`README.md`](README.md) §2 template and §4 filing rules · global identifier `DDR-0031` (`DDR-0030` is the last filed — *never reused, never reassigned*) |
| ⭐⭐ **Status** | ⭐⭐ **CONFIRMED / CONFERRED** — Design System Owner decision recorded per the principal's conferral |
| **Date** | 2026-09-29 (recording date = session date of the conferral; no date invented beyond it) |
| ⭐⭐ **Owner** | ⭐⭐ **Design System Owner** *(role, never a personal name — `PRD_OWNERSHIP_MODEL` §7 rule 4)* |
| ⭐⭐ **Approver / authority instrument** | ⭐ Recorded **verbatim in this header**, on the [`ADR-0147`](../../00-governance/adr/ADR-0147-twelve-dashboardmetrics-counters-certified-anl-obd-001-resolved.md) / `DDR-0026`…`DDR-0030` precedent *(operative authority = the principal's quoted instruction)*: *"Design System Owner confers to `DDR-0031`: **RATIFY** the PROPOSED `LIBOORA_MASTER_DESIGN_SYSTEM.md` §4 typography values — base size 16px; scale 12 · 14 · 16 · 18 · 20 · 24 · 30; 12px minimum for non-essential metadata only; tabular-lining numerals for money/counts/seat numbers; line-heights 1.5 body / 1.25 headings — subject to `DDR-0004`'s 200% text-scale constraint and `DDR-0029`'s Noto Sans + Noto Sans Devanagari / SIL OFL decision. Typography **WEIGHTS must remain explicitly OPEN**. Do NOT invent, infer, or ratify any weight values."* |
| **Governing debt item** | ⭐⭐ **`DBT-005`** (`DESIGN_DEBT.md` L41) — this record ratifies the **sizes + line-heights** limbs; it **leaves the weights limb explicitly OPEN**, so `DBT-005` stays `PARTIALLY RESOLVED (by limb)` |
| **Scope** | Type-scale token set, split: **sizes + line-heights = RATIFIED**; **weights = OPEN (not decided, not invented)** |
| **Change class** | ⭐ **D2 — Design-system change** *(`DESIGN_CHANGE_MANAGEMENT.md` §1)*: ratifies two already-evidenced (PROPOSED) token groups + in-place register alignment. ⛔ **No D5 limb** — ⛔ no requirement, permission, BC ownership, backend or contract change |
| ⛔ **What this record does NOT do** | ⛔ Does **NOT** modify `lib/`, `test/` or `lib/app/shared/theme.dart` · ⛔ does **NOT** invent, infer, ratify or recommend **any weight value or weight ladder** (weights stay ⛔ `OPEN / TO BE DECIDED`) · ⛔ does **NOT** implement, subset or package fonts · ⛔ does **NOT** touch `DBT-008` · ⛔ does **NOT** close `DBT-005` (weights limb remains open) · ⛔ does **NOT** modify `DDR-0029`, `DBT-001` (RESOLVED), `DIT-001` or `DD-0009` · ⛔ does **NOT** authorise implementation · ⛔ **0 new identifiers** beyond next-free `DDR-0031` · ⛔ **no commit, no push** by this act |

---

## 1. The decision (by limb)

| Dimension | Decision | Status after this act | Governing record |
|---|---|---|---|
| **Sizes** | ⭐ **RATIFIED** — base **16px**; scale **12 · 14 · 16 · 18 · 20 · 24 · 30**; **12px minimum** (non-essential metadata only); **tabular-lining numerals** (money, counts, seat numbers) | ⭐ `DECIDED` | this record (`DDR-0031`), ratifying `LIBOORA_MASTER_DESIGN_SYSTEM` §4 L182–187 |
| **Line-heights** | ⭐ **RATIFIED** — **1.5** body · **1.25** headings | ⭐ `DECIDED` | this record (`DDR-0031`), ratifying §4 L183 |
| **Weights** | ⛔ **NOT decided. No value, no ladder, no inference.** | ⛔ **`OPEN / TO BE DECIDED`** | — *(none exists; a fresh Design System Owner decision is required to close it)* |
| **Typeface family** | ⭐ *(already)* | `DECIDED` — `Noto Sans` + `Noto Sans Devanagari` | [`DDR-0029`](DDR-0029-dbt-001-dbt-005-typeface-family-and-licence-decided.md) — **preserved, not re-decided** |
| **Licence** | ⭐ *(already)* | **SIL OFL** | `DDR-0029` — **preserved, not re-decided** |

⛔ **Because the weights limb remains `OPEN`, `DBT-005` is `PARTIALLY RESOLVED (by limb)` — NOT closed by this record.**

## 2. Provenance (exact; every ratified value is traceable — none invented)

| Ratified value | Source (path · line) | Pre-act status | Note |
|---|---|---|---|
| Base size **16px** (⛔ not the skill's raw 12px) | [`LIBOORA_MASTER_DESIGN_SYSTEM.md`](LIBOORA_MASTER_DESIGN_SYSTEM.md) §4 **L182** | `PROPOSED` (UNRANKED doc) | corroborated by `LIBOORA_UIUX_PRO_MAX_RULES.md` L97 ("Data-dense body 12–14px → ⭐ 16px base") |
| Scale **12 · 14 · 16 · 18 · 20 · 24 · 30** | §4 **L187** | `PROPOSED` | — |
| **12px** minimum, non-essential metadata only | §4 **L186** | `PROPOSED` | the §4 recorded conflict (skill "12–14px base") was *rejected as the base*; 12–14px survives only as metadata — rejection travels with the values |
| **Tabular-lining** numerals (money, counts, seat numbers) | §4 **L185** | `PROPOSED` | — |
| Line-height **1.5 body / 1.25 headings** | §4 **L183** | `PROPOSED` | ⚠️ single-source (no second corroborating doc) |

**⚠️ Authority chain:** the source is the **UNRANKED `LIBOORA_MASTER_DESIGN_SYSTEM.md`** marked `PROPOSED`. Its values are **proposals until this owner act**; `DDR-0031` is the instrument that elevates them to `DECIDED`. Ratification is lawful **only because** the Design System Owner conferred it (above). No value is invented — every figure is quoted from §4.

## 3. Authoritative constraints this decision is subject to (recorded, not re-decided)

- ⭐ **`DDR-0004`** (`APPROVED`): the scale **MUST survive 200% text scale** without loss of function. The ratified §4 "Text scaling" row (L189) states exactly this — so the ratification is **consistent with the authoritative constraint**, which governs if the two ever diverged.
- ⭐ **`DDR-0029`**: the ratified scale is built on the decided family `Noto Sans + Noto Sans Devanagari` / **SIL OFL** (the Devanagari companion must carry the same scale).
- ⛔ **No weight value is constrained here** — weights are open, so no weight constraint is asserted.

## 4. Design decision vs implementation (the distinction preserved)

- ⭐ **This record decides the *design* fact:** sizes + line-heights are now the decided type-token set (on the `DDR-0029` family).
- ⛔ **It does not perform implementation** — adding a `LiblText` token class, bundling/subsetting `Noto Sans Devanagari` (second-script size budget still governed by `DDR-0006`), or swapping `theme.dart` L49 `Roboto` remain **engineering-conformance work, ⛔ not authorized here**.
- ⛔ **It does not decide weights** — the weights limb is recorded `OPEN`; a later `DDR-0032` (or equivalent) is required to close it.

## 5. Consequences (executed in this act — in-place, no new identifiers)

| # | File | Alignment |
|---|---|---|
| 1 | `DESIGN_SYSTEM.md` §2 **Typography row** | now `DECIDED` across all type-scale dimensions **except weights**: sizes + line-heights `DECIDED (DDR-0031)`; family+licence `DECIDED (DDR-0029)`; **weights `TO BE DECIDED`** |
| 2 | `DESIGN_SYSTEM.md` §2.1 | item 1 re-stated: sizes + line-heights decided at `DDR-0031`; **only weights + the type-scale-token-set conformance remain open**; `DESIGN_DEBT.md` L41 re-pointed |
| 3 | `DESIGN_DEBT.md` L41 **`DBT-005`** status cell | stays **`⚠️ PARTIALLY RESOLVED (by limb)`**; the type-token-class limb re-worded: **sizes ⭐ `DDR-0031` · line-heights ⭐ `DDR-0031` · weights ⛔ OPEN**; **§2.1 measures: no arithmetic change** — `DBT-005` was already the single `PARTIALLY RESOLVED` row |
| 4 | `DESIGN_DEBT.md` §2.1 `Resolved` note | unchanged (`DBT-005` is not counted `Resolved`; its open limb is now specifically **weights**) |

## 6. Non-consequences (explicit)

- ⛔ **`lib/`, `test/`, `theme.dart` unmodified** — verified by `git diff`.
- ⛔ **0 weight values invented or ratified** — weights remain `TO BE DECIDED`.
- ⛔ **`DBT-005` NOT closed** — it stays `PARTIALLY RESOLVED (by limb)`; the open limb is **typography weights**.
- ⛔ **`DBT-008` untouched** — targeted owner act, not the broad foundation-approval act.
- ⛔ **`DBT-001` (RESOLVED), `DDR-0029`, `DIT-001`, `DD-0009` untouched.**
- ⛔ **The `Noto Sans + Noto Sans Devanagari` / `SIL OFL` decision of `DDR-0029` is preserved**, not re-decided.
- ⛔ **0 new identifiers** beyond next-free `DDR-0031`; **no commit, no push** performed by this act.

## 7. Changelog

| Version | Date | Change | Rationale |
|---|---|---|---|
| **v0.1** | 2026-09-29 | ⭐⭐ **Created and CONFIRMED / CONFERRED.** Design System Owner **ratifies** the `LIBOORA_MASTER_DESIGN_SYSTEM` §4 PROPOSED **sizes** (base 16px · 12–30 scale · 12px metadata floor · tabular numerals) and **line-heights** (1.5 body / 1.25 headings), subject to `DDR-0004` (200%) + `DDR-0029` (Noto family / SIL OFL). **Weights recorded `OPEN / TO BE DECIDED` — no value invented.** In-place amends at `DESIGN_SYSTEM.md` §2/§2.1 and `DESIGN_DEBT.md` L41 (§2.1 arithmetic unchanged; `DBT-005` stays `PARTIALLY RESOLVED (by limb)` with weights as the open limb). ⛔ 0 code · ⛔ 0 weight values · ⛔ `DBT-005`/`DBT-008`/`DDR-0029` untouched · ⛔ 0 commits by this act | The `DESIGN_DEBT.md` §3 rule 5 act: the two evidenced limbs close on the owner's ratification; the unevidenced limb (weights) is lawfully left open rather than filled by invention |
