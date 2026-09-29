<!-- LIBOORA Design Documentation | Design Decision Record | 2026-09-29 -->

> This document is design governance and documentation. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles,
> scopes or backend contracts.

# DDR-0029 — `DBT-001` / `DBT-005`: typeface family + licence decided (Noto Sans + Noto Sans Devanagari / SIL OFL)

| Field | Value |
|---|---|
| **Register** | ⭐ Filed under [`README.md`](README.md) §2 template and §4 filing rules · global identifier `DDR-0029` (`DDR-0028` is the last filed — *never reused, never reassigned*) |
| ⭐⭐ **Status** | ⭐⭐ **CONFIRMED / CONFERRED** — Design System Owner + Design Governance Owner decision recorded per the principal's conferral |
| **Date** | 2026-09-29 (recording date = session date of the conferral; no date invented beyond it) |
| ⭐⭐ **Owner** | ⭐⭐ **Design System Owner** *(family)* **+ Design Governance Owner** *(licence check)* — roles, never personal names (`PRD_OWNERSHIP_MODEL` §7 rule 4) |
| ⭐⭐ **Approver / authority instrument** | ⭐ Recorded **verbatim in this header**, on the [`ADR-0147`](../../00-governance/adr/ADR-0147-twelve-dashboardmetrics-counters-certified-anl-obd-001-resolved.md) / `DDR-0026` / `DDR-0027` / `DDR-0028` precedent *(operative authority = the principal's quoted instruction)*: *"The required owner conferral … is authoritative: **Design System Owner selects: Noto Sans + Noto Sans Devanagari.** **Design Governance Owner confirms: SIL Open Font License (OFL).** This exactly satisfies the open owner decision reserved by `DDR-0002`."* |
| **Scope** | Close the **`DBT-001` typography-family limb** and **remove the family-blocker** from the **`DBT-005` type-token-class limb** by recording the final typeface family + licence |
| **Change class** | ⭐ **D2 — Design-system change** *(`DESIGN_CHANGE_MANAGEMENT.md` §1)*: a typeface foundation decision + in-place document alignment. ⛔ **No D5 limb** — ⛔ no requirement, permission, BC ownership, backend or contract change |
| ⛔ **What this record does NOT do** | ⛔ Does **NOT** modify `lib/`, `test/` or `lib/app/shared/theme.dart` · ⛔ does **NOT** implement, subset or package fonts · ⛔ does **NOT** touch `DBT-008` · ⛔ does **NOT** create another DDR · ⛔ does **NOT** invent type-scale values (sizes / weights / line-heights) — no source independently decided them · ⛔ does **NOT** authorise implementation · ⛔ does **NOT** select the Indic/Devanagari *language scope* (that stays a Product-Owner act under `DBT-003`; `DDR-0002`'s script-rendering limb is pre-approved, its UI-localization limb remains open) · ⛔ does **NOT** claim the family is *implemented* — the shipped `theme.dart` L49 still reads `fontFamily: 'Roboto'` |

---

## 1. The decision

> The **typeface family + licence** open limb that `DDR-0002` reserved to
> "Design System Owner + Design Governance Owner" (its open-questions row, L60) is
> **now decided**:

| Item | Decision |
|---|---|
| **Typeface family (V1)** | ⭐ **`Noto Sans`** *(Latin) + **`Noto Sans Devanagari`** *(Devanagari companion)* — the only candidate satisfying `DDR-0002`'s pairing + Devanagari-coverage + open-licence criteria **by construction** |
| **Licence** | ⭐ **SIL Open Font License (OFL)** — open licence, satisfies `LIBOORA_HUMAN_DECISION_SHEET` D-2(b) "open licence *(OFL/Apache)*" |
| **Script-rendering scope** | ⭐ **Already `APPROVED`** at `DDR-0002` (V1 MUST support Indic/Devanagari student names) — this record **confirms** it; it does not re-open it |
| **Type-scale token set** | ⛔ **NOT decided here.** No source independently decided sizes / weights / line-heights — ⛔ **not invented** (`DESIGN_DEBT.md` §3 rule 5 discipline; `FIGMA_FOUNDATION.md` L30 "exact token names and values TO BE DECIDED") |

## 2. Evidence / traceability (exact)

| Claim | Source (path · line) |
|---|---|
| Requirement `APPROVED` (Indic/Devanagari MUST); family `TO BE DECIDED`; candidate `Noto Sans + Noto Sans Devanagari` *(SIL OFL)* "the only candidate satisfying the pairing criterion **by construction**" | [`DDR-0001-to-0009`](DDR-0001-to-0009-founder-product-authority-decisions.md) L49, L57 (`DDR-0002`) |
| "Final family + licence review — **Design System Owner** + **Design Governance Owner**" | `DDR-0001-to-0009` L60 (`DDR-0002` open-questions row) |
| D-2(a) Indic determination = **YES** (V1 supports Devanagari names); D-2(b) "Noto Sans + Noto Sans Devanagari if **YES**"; selection criteria "open licence *(OFL/Apache)* · matched Devanagari coverage"; owner route "(a) Product Owner → (b) Design System Owner *(family)*; licence check **Design Governance Owner**" | [`LIBOORA_HUMAN_DECISION_SHEET.md`](LIBOORA_HUMAN_DECISION_SHEET.md) **D-2** L170–212 |
| Family row `⛔ TO BE DECIDED` pre-act (candidate list `Inter` / `Plus Jakarta Sans` / `Noto Sans + Noto Sans Devanagari`; "Licence + script coverage decide it") | [`LIBOORA_MASTER_DESIGN_SYSTEM.md`](LIBOORA_MASTER_DESIGN_SYSTEM.md) L181, L498 |
| **No later record selected the family** — positive-selection sweep across `docs/design/` + `docs/00-governance/` = **0** hits (the only family mention is `DDR-0002`, which withheld it) | verified 2026-09-29 |
| Shipped code **pre-dates** this decision (`fontFamily: 'Roboto'`, no `LiblText` class) — so the act is a *decision*, not a conformance claim | `lib/app/shared/theme.dart` L49, L58, L104, L121 |

## 3. Design decision vs implementation (the distinction this record preserves)

- ⭐ **This record decides the *design* fact:** the V1 typeface family and its open licence.
- ⛔ **It does not perform *implementation*:** bundling/subsetting `Noto Sans Devanagari`, adding a `LiblText` token class, or swapping `theme.dart` L49's `Roboto` are **engineering-conformance work, ⛔ not authorized here** — release-only after a separate authorization (the second-script size budget is already governed by `DDR-0006`).
- ⛔ **It does not invent the type-scale token set** (sizes / weights / line-heights): that is a **separate open decision** the Design System Owner has not recorded anywhere; `DESIGN_DEBT.md` §3 rule 5 bars recording it by side-effect.

## 4. Consequences (executed in this act — in-place, no new identifiers)

| # | File | Alignment |
|---|---|---|
| 1 | `DESIGN_SYSTEM.md` §2 **Typography row** | `family still TO BE DECIDED` → **`family + licence DECIDED (DDR-0029)`**; open item = the type-scale token set only |
| 2 | `DESIGN_SYSTEM.md` §2.1 | item 1 (typography family) re-stated **decided**; item 2 type-token-class re-stated **family decided, scale set still open** |
| 3 | `DESIGN_DEBT.md` **`DBT-001`** (L37) | status `⚠️ PARTIALLY RESOLVED (by limb)` → **`⭐ RESOLVED`** (all 3 limbs: colour `DDR-0001` · spacing `DDR-0027` · typography-family `DDR-0029`) |
| 4 | `DESIGN_DEBT.md` **`DBT-005`** (L41) | stays **`⚠️ PARTIALLY RESOLVED (by limb)`** — radius `DDR-0003`+`DDR-0028` · elevation `DDR-0028` · **type-token class: family+licence now `DECIDED` (`DDR-0029`), scale token set ⛔ still undetermined** |
| 5 | `DESIGN_DEBT.md` **§2.1 measures** | re-rolled: `OPEN 5` · `PARTIALLY RESOLVED (by limb) 1 (005)` · `ACCEPTED, DOCUMENTED 1 (007)` · **`Resolved 1 (001)`** · `8 = 5+1+1+1` |

## 5. Non-consequences (explicit)

- ⛔ **`lib/`, `test/`, `theme.dart` unmodified** — verified by `git diff`.
- ⛔ **No font implementation, subsetting or packaging** performed or authorized.
- ⛔ **`DBT-008` untouched** — this is a targeted owner act, not the broad foundation-approval act.
- ⛔ **Type-scale token set NOT invented** — `DBT-005`'s type-token-class limb is **unblocked, not closed**.
- ⛔ **Indic/Devanagari UI-localization scope NOT decided** — stays under `DBT-003` (Product Owner) per `DDR-0002`.
- ⛔ **0 new identifiers** beyond next-free `DDR-0029`; **0 values invented** (family + licence = `DDR-0002`'s derived candidate; the *act* is the owners' confirmation).
- ⛔ **No commit, no push** performed by this act.

## 6. Changelog

| Version | Date | Change | Rationale |
|---|---|---|---|
| **v0.1** | 2026-09-29 | ⭐⭐ **Created and CONFIRMED / CONFERRED in one act.** Design System Owner **selects** typeface family `Noto Sans + Noto Sans Devanagari`; Design Governance Owner **confirms** licence **SIL OFL** — closing the `DBT-001` typography-family limb and unblocking the `DBT-005` type-token-class limb. In-place amends at `DESIGN_SYSTEM.md` §2/§2.1 and `DESIGN_DEBT.md` L37/L41/§2.1 (`DBT-001` → `RESOLVED`; `DBT-005` stays `PARTIALLY RESOLVED (by limb)`; measures re-rolled `Resolved 0 → 1`). ⛔ 0 code · ⛔ 0 font work · ⛔ type-scale token set **not** invented · ⛔ `DBT-008` untouched · ⛔ 0 commits by this act | The `DESIGN_DEBT.md` §3 rule 5 act the register owed: the row closes (by limb) only on the owning office's decision — principal conferral *"Design System Owner selects: Noto Sans + Noto Sans Devanagari; Design Governance Owner confirms: SIL Open Font License (OFL)"* recorded verbatim on the `ADR-0147` / `DDR-0026`–`DDR-0028` precedent |
