# DP-0007 — Product Owner decision record: `SAAS-GAP-002` configurable ranges (rate / trial / due-day)

| Field | Value |
|---|---|
| **Type** | ⭐ **Recorded Product Owner decision** — a decision *given by the principal and recorded verbatim*; ⛔ NOT an ADR, NOT an amendment, NOT an authorization |
| **Status** | ⭐ **DECIDED 2026-09-25** · ⚠ **PENDING RECONCILIATION** — `PRD-022` §12 `SAAS-GAP-002` cell still reads OPEN; recording the decision *in the gap ledger* is a separate, named subject-amendment act, **not performed by this record** |
| **Gap decided (in fact, not yet in text)** | `SAAS-GAP-002` — *"Configurable ranges and parameter identifiers"* (`PRD-022` L713–721), **ranges limb only** |
| **Also decided by this act** | `SAAS-GAP-007` — *"A configured due day above 28 has no defined behaviour in February"* (`PRD-022` L763–772) — **RESOLVED BY ELIMINATION** through the closed due-day set `{10, 15, 25}`: every permitted day exists in February, so the 29/30/31 question has no remaining case |
| **Not closed** | ⛔ **D-4 identifier allocation** — the `BC-25`/`PRD-023` owner act (*"Adding a parameter — a PRD amendment"*, `CONFIGURATION_GUIDE.md` §5 L863) is **explicitly excluded** from this approval; ⛔ `SAAS-GAP-005` (trial-eligibility identity) · ⛔ V2-deferred `SAAS-GAP-003`/`004` |
| **Baseline** | HEAD `6d55fed` · `origin/main` `6ebe0e6` · `PRD-022` at v0.4.1 blob `f101a33…` (byte-identical before and after this record) |
| **Precedent followed** | `DP-0006` convention (verbatim conferral + verification table + effect + reversion) · `ADR-0039`/`ADR-0043` decision-record pattern · *"a decision is not a specification"* (`PRD-008` v1.4 header) — this record **decides**; the subject amendment **specifies** |

---

## 1. ⭐ The decisions, recorded verbatim (Product Owner)

> **D-1 — Platform Charge rate range:** the configurable range is **1%–5%**, with the existing default **3%**
> unchanged. Below 1% the charge is commercially negligible; above 5% the per-collection amount departs
> materially from the 3%-default arithmetic this document's §7B load tests work (`SAAS-BR-002`/`013`).
>
> **D-2 — Free-trial duration range:** the configurable range is **7–30 days**, with the existing default
> **14 days** unchanged. A 7-day floor keeps the trial a meaningful evaluation window; a 30-day ceiling caps
> the free-usage exposure to at most one calendar month's worth of trial tenancy.
>
> **D-3 — Billing due day:** the configurable set is **closed: {10, 15, 25}**, with the existing default
> **the 15th** unchanged. The set is **stated as closed** — 10, 15 and 25 are the only permitted values.
>
> **D-3 → `SAAS-GAP-007`: RESOLVED BY ELIMINATION.** Because the closed set contains **only days 10, 15 and
> 25**, and **all three occur in every month including February**, the question *"what happens when the
> configured day (29, 30, 31) does not occur in a month?"* has **no remaining case**. No February
> early-close or roll-forward rule is required or declared. ⚠ **The v0.3 enumeration *"changeable among
> 10/15/25"* is now the closed set itself** — the `PRD-022` §12.2 L804 caution (*"restricted the set without
> saying the set is closed"*) is discharged by this decision **stating the closure**.
>
> ⛔ **D-4 (identifier allocation) is NOT part of this approval.** No `CFG-*`/`LCFG-*`/`ICFG-*`/`SAAS-CFG-*`
> identifier is allocated here. Allocation is the **`BC-25`/`PRD-023` owner act**, sequenced *after* this
> record, via `CONFIGURATION_GUIDE.md` §5's PRD-amendment route. ⛔ No new role, permission, scope, event or
> aggregate is created. ⛔ No V2 scope is entered. ⛔ `SAAS-GAP-005` (trial identity) and `SAAS-GAP-003`/`004`
> (V2/DEFERRED) are untouched.

---

## 2. Verification against the repository (measured, not asserted)

| # | Claim | Measurement at HEAD `6d55fed` |
|---|---|---|
| 1 | **Defaults are unchanged, not re-decided** | `SAAS-FR-001` L166–167 (*"default of **3%**"*) · `SAAS-FR-017` L636–637 (*"default of **14 days**"*) · `SAAS-FR-022` L324–326 (*"default of the **15th**"*) — all three **byte-unchanged** by this record; the decision supplies the **range** around an **existing ratified default** (v0.3 conferral, §12.2 L797/L805/L806) |
| 2 | **The range limb of `SAAS-GAP-002` was the only missing element** | L718: *"No range, no default minimum or maximum, no `CFG-*`/`LCFG-*`/`ICFG-*` identifier"* · L654–656: *"No minimum or maximum configurable range is declared… Ranges are `SAAS-GAP-002`"* · `SAAS-FR-017`/`022` UNTRACED on this exact gap (L884, L889) — the decision **fills precisely that hole** |
| 3 | **D-3's closed set eliminates `SAAS-GAP-007` by construction** | `SAAS-GAP-007` block L764: *"If the due day is configurable across the full range 1–31, then days 29, 30 and 31 do not occur in every month…"* — the **condition of the gap is a configurable range reaching above 28**. The closed set {10, 15, 25} **never reaches 29**, so the gap's question has no input. L772 (the *"safe default"* note) confirms the 15th is unaffected; the v0.3 ratification's own note (L805: *"All of 10, 15 and 25 occur in **every month**, so the February problem cannot arise from this enumeration"*) is now **promoted from observation to the governing rule** by the closed-set statement |
| 4 | **No identifier invented** | ⛔ **0** `CFG-*`/`LCFG-*`/`ICFG-*`/`SAAS-CFG-*` identifiers created by this record · `PRD-023` (FROZEN, Rank 3, `BASELINE-2026-09-01-B`) **byte-unchanged** · its `CNF-CFG-*` register remains **0** by design (L81/L122) · `CONFIGURATION_GUIDE.md` (Rank 5) **byte-unchanged** — D-4's act is *named and routed*, not performed |
| 5 | **No other gap moved** | `SAAS-GAP-005` (trial identity — *"a duration is not an identity"*, L748/L806) **OPEN** · `SAAS-GAP-003`/`004` **V2/DEFERRED** per `Accepted` `ADR-0130` §3/§4, **unchanged** · `SAAS-GAP-006` closure (Stage 3 CONFERRED) **already recorded** in the alignment record — not re-claimed here |
| 6 | **Consistency with `CONFIGURATION_GUIDE.md` §5** | L859–861: *"Value within its declared range — Owner approval, recorded in the deployment change log"* · *"Value outside its declared range — An ADR. The range is part of the reasoning, not a formality."* — D-1/D-2/D-3 **declare** the ranges (Product Owner act, in a decision record); they do **not** move a value outside a declared range, so **no ADR is triggered by this decision**; the ranges become the declared ranges the §5 change-control table binds to |
| 7 | **PRD-022 byte-identity at this act** | `sha256` blob `f101a334…` at HEAD `6d55fed` **before = after** this record — the decision is *recorded*, not *applied* to the subject; the subject amendment is the **next, separate** act |

---

## 3. Effect of the decision

### 3.1 What is now settled

| ID | Effect |
|---|---|
| `SAAS-GAP-002` **ranges limb** (in fact) | **DECIDED** — rate 1%–5% · trial 7–30 days · due-day closed set {10, 15, 25}; all three with their existing ratified defaults unchanged |
| `SAAS-GAP-007` (in fact) | **RESOLVED BY ELIMINATION** — the closed due-day set makes the *"due day above 28"* case unreachable; no February semantics rule is required. **Distinct from D-4**: the *ranges* are decided (this record); the *identifiers* are not (D-4, `BC-25`/`PRD-023` act) |
| `SAAS-FR-017` / `SAAS-FR-022` | Their UNTRACED status (L884/L889: *"no range declared"*) is **discharged in fact** — the range now exists; the traceability-cell amendment is the subject-amendment act, **not performed by this record** |
| `SAAS-AC-006`/`024` | Gain their **bounds**: a configured rate outside 1%–5% is a value *outside its declared range* and therefore routes to the §5 *"An ADR"* path (L861) — the criteria are now bounded |
| Stage-4 check 3 (range limb, `PRD_LIFECYCLE.md` L114) | **Satisfied for all three configurables** — every configurable now has **a default and a range**; the subject's *"8 = 87.5%"* / *"7 = 89.1%"* untraced counts will move on the subject-amendment act |
| V1-blocking gap count | **4 → 2** on the subject-amendment act: `SAAS-GAP-002` (ranges limb closed; ⚠ identifier-allocation limb **D-4** remains — see §3.3) and `SAAS-GAP-007` **leave the blocking set**; `SAAS-GAP-005` and `SAAS-GAP-006` remain |

### 3.2 What is NOT settled (explicitly out of scope)

| ID | Status |
|---|---|
| **D-4 identifier allocation** (`SAAS-GAP-002`'s second limb) | ⛔ **OPEN, separate office** — *"Adding a parameter — a **PRD amendment**"* (`CONFIGURATION_GUIDE.md` §5 L863) + the register-creation/allocation decision (*which* register: `CFG-*`/`LCFG-*`/`ICFG-*`, or a new `SAAS-CFG-*` — the owner's call, **not this record's**). Owner: **`BC-25`/`PRD-023` owner**. ⛔ No identifier is named, minted or reserved by this record |
| `SAAS-GAP-005` | ⛔ **OPEN** — trial-eligibility **identity** anchor (Architecture Owner + `PRD-001`); *"a duration is not an identity"* (L806) — D-2's range does not touch it |
| `SAAS-GAP-003`/`004` | ⛔ **V2/DEFERRED, unchanged** — `Accepted` `ADR-0130` §3/§4; *deferral is not closure* |

### 3.3 Reconciliation debt created (named, NOT performed by this record)

1. **`PRD-022` §12 `SAAS-GAP-002` cell** (L713–721) — Status row to record the ranges DECIDED; the cell **retains its identifier-allocation question** (D-4) — the gap therefore **splits**: ranges limb CLOSED (this record), identifier limb **stays OPEN on D-4** (⚠ this is why the §12.1 count moves 4 → 2 only if D-4 is treated as `SAAS-GAP-002`'s remaining open limb, or the count moves 4 → 3 if the cell keeps both limbs — the subject-amendment act must **measure and record which**, not assume).
2. **`PRD-022` §12 `SAAS-GAP-007` cell** (L763–772) — Status row to record RESOLVED BY ELIMINATION via the closed set.
3. **`SAAS-FR-017`/`022` traceability rows** (L884/L889) — UNTRACED → TRACED, with the range criterion named; **recomputed** coverage total (the subject amendment must *count*, not carry forward).
4. **§12.1 count sentence** (L787) + **header L13** + **footer** — V1-blocking count re-derivation.
5. ⛔ `SAAS-GAP-003`/`004`/`005`/`006` cells **byte-unchanged**.

---

## 4. Conferral and reversion

| Field | Value |
|---|---|
| **Deciding authority** | ⭐ **Product Owner**, single-act decision, recorded verbatim at §1 |
| **Scope** | ⭐ *"Only the `SAAS-GAP-002` ranges-limb decisions D-1/D-2/D-3 and the D-3 → `SAAS-GAP-007` elimination"* — the three ranges + the closed-set statement + the February-elimination consequence, **nothing more** |
| ⛔ **Not claimed** | ⛔ No Architecture / Authorization / `BC-25` / `BC-05` office acted · ⛔ no independent review, quorum or sign-off claimed |
| ⛔ **Not reused** | ⛔ `ADR-0039`'s conferral (the `FEE-GAP-004` taxonomy) · ⛔ `DP-0006`'s decision act (the `SAAS-GAP-001` eligibility base — *"a decision is not a specification"* in the reverse direction as well: DP-0006 **did not** decide ranges, and this record **does not** decide identifiers) · ⛔ `ADR-0130`'s joint conferral (the V1/V2 re-scope) |
| ⭐ **Reversion** | ⭐ Reverts on completion of this recording act (`ADR-0033` §7.1: *"a conferral for one act is not a standing licence"*). ⛔ The `PRD-022` subject-amendment act, the **D-4 identifier-allocation act** (`BC-25`/`PRD-023` owner), the `SAAS-GAP-005` identity act, and any Stage-4 verdict **each require a NEW conferral or the competent office** |

---

*End of `DP-0007`. ⭐ **`SAAS-GAP-002` ranges limb DECIDED IN FACT — rate 1%–5% (default 3%); trial 7–30 days (default 14 days); due-day closed set {10, 15, 25} (default 15th, set stated CLOSED).** ⭐ **`SAAS-GAP-007` RESOLVED BY ELIMINATION** — no 29/30/31 case remains. ⛔ **D-4 (identifier allocation) remains the `BC-25`/`PRD-023` owner act — 0 identifiers invented here.** `PRD-022` (blob `f101a33…`), `PRD-023`, `PRD-008` and `CONFIGURATION_GUIDE.md` **byte-unchanged**. `SAAS-GAP-003`/`004`/`005`/`006` **untouched**. No commit, no amend, no push performed by this record.*
