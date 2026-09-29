<!-- LIBOORA Design Documentation | Design Decision Record | 2026-09-29 -->

> This document is design governance and documentation. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles,
> scopes or backend contracts.

# DDR-0030 — `DBT-005`: the type-scale token set (sizes / weights / line-heights) examined and **recorded OPEN** — no values ratified

| Field | Value |
|---|---|
| **Register** | ⭐ Filed under [`README.md`](README.md) §2 template and §4 filing rules · global identifier `DDR-0030` (`DDR-0029` is the last filed — *never reused, never reassigned*) |
| ⭐⭐ **Status** | ⭐⭐ **CONFIRMED / RECORDED** — open-decision determination · ⛔ **0 type-scale values ratified** · `DBT-005` stays **`PARTIALLY RESOLVED (by limb)`** |
| **Date** | 2026-09-29 (recording date = session date; no date invented beyond it) |
| ⭐⭐ **Owner** | ⭐⭐ **Design System Owner** *(role, never a personal name — `PRD_OWNERSHIP_MODEL` §7 rule 4)* — the owning office the register routes the type-token set to |
| ⭐⭐ **Approver / authority instrument** | ⭐ Recorded **verbatim in this header**, on the [`ADR-0147`](../../00-governance/adr/ADR-0147-twelve-dashboardmetrics-counters-certified-anl-obd-001-resolved.md) / `DDR-0026`…`DDR-0029` precedent *(operative authority = the principal's quoted instruction)*: *"Execute exactly ONE governance act: Create `DDR-0030` for the remaining OPEN limb of `DBT-005`: TYPE-SCALE TOKEN SET (typography sizes, weights, line-heights). … If the repository does **NOT** contain sufficient authoritative evidence, `DDR-0030` MUST explicitly record the type-scale as **OPEN/TBD** and **must NOT invent values**. Do NOT convert implementation values into governance decisions merely because they exist in code. Do NOT invent any design-token values."* |
| **Governing debt item** | ⭐⭐ **`DBT-005`** (`DESIGN_DEBT.md` L41) — the untokenised-values debt; this record addresses its **last open limb: the type-scale token set** |
| **Scope** | Decision: whether `DBT-005`'s type-scale token set (sizes / weights / line-heights) is **DECIDED** or **OPEN**. Outcome on measured evidence: **OPEN** |
| **Change class** | ⭐ **D2 — Design-system change** *(`DESIGN_CHANGE_MANAGEMENT.md` §1)*: an open-decision record + in-place register alignment. ⛔ **No D5 limb** — ⛔ no requirement, permission, BC ownership, backend or contract change |
| ⛔ **What this record does NOT do** | ⛔ Does **NOT** modify `lib/`, `test/` or `lib/app/shared/theme.dart` · ⛔ does **NOT** invent or ratify **any** type-scale value (sizes / weights / line-heights stay ⛔ `TO BE DECIDED`) · ⛔ does **NOT** convert implementation-only values (`theme.dart` ad-hoc `TextStyle`s) into a governance decision · ⛔ does **NOT** adopt the `LIBOORA_MASTER_DESIGN_SYSTEM.md` §4 *PROPOSED* numbers as decided · ⛔ does **NOT** implement, subset or package fonts · ⛔ does **NOT** touch `DBT-008` · ⛔ does **NOT** modify `DBT-001` (already `RESOLVED`), `DIT-001`, `DD-0009` or any unrelated DD · ⛔ does **NOT** authorise implementation · ⛔ **0 new identifiers** beyond next-free `DDR-0030` · ⛔ **no commit, no push** by this act |

---

## 1. The determination

> `DBT-005`'s remaining open limb is the **type-scale token set** (typography **sizes**,
> **weights**, **line-heights**), distinct from the **typeface family + licence already
> decided at `DDR-0029`** (`Noto Sans` + `Noto Sans Devanagari` / **SIL OFL** — ⛔ preserved
> here, not re-opened). The Design System Owner **examined the live repository** for
> authoritative scale values. **Measure: no source fixes them.** The set is therefore
> **recorded OPEN / `TO BE DECIDED`** and **no value is invented**.

| Dimension | Decided? | Recorded state | Governing record |
|---|---|---|---|
| **Sizes** | ⛔ **NO** | **OPEN / `TO BE DECIDED`** | — (none exists) · this record (`DDR-0030`) |
| **Weights** | ⛔ **NO** | **OPEN / `TO BE DECIDED`** | — (none exists) · this record (`DDR-0030`) |
| **Line-heights** | ⛔ **NO** | **OPEN / `TO BE DECIDED`** | — (none exists) · this record (`DDR-0030`) |
| **Typeface family** | ⭐ YES *(already)* | `DECIDED` | [`DDR-0029`](DDR-0029-dbt-001-dbt-005-typeface-family-and-licence-decided.md) — **preserved, not re-decided** |
| **Licence** | ⭐ YES *(already)* | **SIL OFL** | [`DDR-0029`](DDR-0029-dbt-001-dbt-005-typeface-family-and-licence-decided.md) — **preserved, not re-decided** |

⛔ **Because all three scale dimensions are undecidable on current evidence, `DBT-005`
remains `PARTIALLY RESOLVED (by limb)` — it is NOT closed by this record.**

## 2. Evidence classification (measured; the decision rule applied)

The repository was searched across `docs/design/`, `docs/00-governance/`,
`docs/10-architecture/`, `docs/30-product/`, `lib/` and the decision records, classifying
every type-scale mention as **A** governance-decided / **B** implementation-only /
**C** candidate / **D** explicit-TBD:

| Class | Finding | Evidence (path · line) |
|---|---|---|
| **A — decided/ratified** | ⛔ **NONE.** No ADR/DDR/decision fixes sizes, weights or line-heights. Verified: `DDR-0001…0009` (colour `DDR-0001`, radius `DDR-0003`, accessibility *minimums* `DDR-0004`, breakpoints `DDR-0005`), `DDR-0028` (radius + elevation only), `DDR-0029` (family + licence only) — **0** type-scale sets | `design-decisions/` sweep = **0** APPROVED/`DECIDED` type-scale hits |
| **B — implementation only** | ⚠️ Ad-hoc, **not a scale, not ratifiable**: `fontSize 18 / w600` (L59) · `16 / w600` (L104) · `11.5 / w600` (L122) — ⛔ **no `LiblText` token class, ⛔ no line-height value anywhere** in `theme.dart`. Per the decision rule these are **not** converted into a decision | `lib/app/shared/theme.dart` L59, L104, L122; `grep "LiblText" lib/` = **0** |
| **C — candidates/examples** | ⚠️ All **`PROPOSED`** in a **`PROPOSED` / UNRANKED** master doc (⛔ not authority): 16px base · 1.5 body / 1.25 heading line-height · 12/14/16/18/20/24/30 scale · 12px floor | [`LIBOORA_MASTER_DESIGN_SYSTEM.md`](LIBOORA_MASTER_DESIGN_SYSTEM.md) §4, **L181–189** |
| **D — explicit `TO BE DECIDED`** | ⛔ Four sources **declare the values open**: "Exact family, weights, and type scale are **TO BE DECIDED**" · "font weight … **TO BE DECIDED**" · "Exact token names and values are **TO BE DECIDED** in the canonical Figma file" · "Type-scale values … **NOT decided here**" | [`VISUAL_LANGUAGE.md`](VISUAL_LANGUAGE.md) **L30** · [`PERFORMANCE.md`](PERFORMANCE.md) **L35** · [`FIGMA_FOUNDATION.md`](FIGMA_FOUNDATION.md) **L30** · [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) **L21** |

**Rule outcome:** Class A is **empty**; Class C is `PROPOSED`-only and is **contradicted**
by Class D; Class B is non-ratifiable. ⇒ **Insufficient authoritative evidence.** `DDR-0030`
therefore records the set **OPEN** and **invents nothing**. Every candidate value above is
traceable to its source; **none is adopted as a decision.**

## 3. Design decision vs implementation (the distinction this record preserves)

- ⭐ **This record is a governance determination:** the type-scale token set is **not yet
  evidenced** in any authority instrument, so it **stays open**.
- ⛔ **It does not ratify Class C** (`LIBOORA_MASTER_DESIGN_SYSTEM.md` §4) — those are
  *proposals* in an UNRANKED document, and `VISUAL_LANGUAGE.md` L30 + `FIGMA_FOUNDATION.md`
  L30 still mark the values `TO BE DECIDED`.
- ⛔ **It does not perform implementation** — bundling/subsetting the Devanagari script,
  adding a `LiblText` class, or swapping `theme.dart` L49 `Roboto` are **engineering-conformance
  work, ⛔ not authorized here** (second-script size budget remains governed by `DDR-0006`).

## 4. Consequences (executed in this act — in-place, no new identifiers)

| # | File | Alignment |
|---|---|---|
| 1 | `DESIGN_DEBT.md` L41 **`DBT-005`** status cell | `⚠️ PARTIALLY RESOLVED (by limb)` **unchanged** (radius ⭐ `DDR-0003`+`DDR-0028` · elevation ⭐ `DDR-0028` · type-token class: family+licence ⭐ `DDR-0029`, **scale set ⛔ OPEN**); the scale-set limb's wording now cites `DDR-0030` as the record that examined it. **§2.1 measures: no arithmetic change** — `DBT-005` was already the single `PARTIALLY RESOLVED` row |
| 2 | `DESIGN_SYSTEM.md` §2.1 item 1 + item 2 | the open-item wording now points at `DDR-0030` (the scale set is **recorded open, not undecided-for-lack-of-record**); §2 Typography row **unchanged** (already "type-scale NOT decided here") |

## 5. Non-consequences (explicit)

- ⛔ **`lib/`, `test/`, `theme.dart` unmodified** — verified by `git diff`.
- ⛔ **0 type-scale values invented or ratified** — sizes / weights / line-heights remain `TO BE DECIDED`.
- ⛔ **`DBT-005` NOT closed** — it stays `PARTIALLY RESOLVED (by limb)`; the open limb is the **type-scale token set**.
- ⛔ **`DBT-008` untouched** — this is a targeted owner act, not the broad foundation-approval act.
- ⛔ **`DBT-001` (RESOLVED), `DIT-001`, `DD-0009` untouched** — out of this record's scope.
- ⛔ **The `Noto Sans + Noto Sans Devanagari` / `SIL OFL` decision of `DDR-0029` is preserved**, not re-decided.
- ⛔ **0 new identifiers** beyond next-free `DDR-0030`; **no commit, no push** performed by this act.

## 6. Changelog

| Version | Date | Change | Rationale |
|---|---|---|---|
| **v0.1** | 2026-09-29 | ⭐⭐ **Created and CONFIRMED / RECORDED.** Design System Owner examined the repository for type-scale values (sizes / weights / line-heights) and **recorded the set `OPEN / TO BE DECIDED`** — **0 values ratified**. Class A empty · Class B non-ratifiable · Class C `PROPOSED`-only · Class D explicit-TBD. In-place amends at `DESIGN_DEBT.md` L41 (scale-set limb now cites `DDR-0030`) and `DESIGN_SYSTEM.md` §2.1 items 1–2; `DBT-005` **stays** `PARTIALLY RESOLVED (by limb)`. ⛔ 0 code · ⛔ 0 invented values · ⛔ `DBT-001`/`DBT-008`/`DIT-001`/`DD-0009` untouched · ⛔ `DDR-0029` family/licence preserved | The `DESIGN_DEBT.md` §3 rule 5 + `DESIGN_FOUNDATION` discipline: a value that no authority has decided **must not be invented** by a design record. This act lawfully *closes the question of whether a decision exists* (answer: it does not) without fabricating one |
