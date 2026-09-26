# DP-0008 — Configuration Owner decision record: `SAAS-GAP-002` D-4 — register home and identifier-allocation route

| Field | Value |
|---|---|
| **Type** | ⭐ **Recorded Configuration Owner decision** — a decision *given by the Configuration Owner and recorded verbatim*; ⛔ NOT an ADR, NOT a PRD amendment, NOT a guide amendment, NOT an identifier allocation |
| **Status** | ⭐ **DECIDED 2026-09-25** · ⚠ **PENDING AMENDMENT ACTS** — this record *selects the route*; the register declaration, parameter declaration, identifier allocation, and `SAAS-GAP-002` closure are **separate named acts** (a→b→c→d) performed **after** this record, by the offices named below |
| **Gap limb decided (in fact, not yet in text)** | `SAAS-GAP-002` **identifier-allocation limb (D-4)** — *"under which register are the parameter identifiers allocated?"* (`PRD-022` L713–721) |
| **Decision** | ⭐ **Route A selected: a new `SAAS-CFG-*` register declared by `PRD-022`**, with its three members (rate / trial / due-day) published up front with the `DP-0007`-decided ranges. ⛔ **`PRD-023`'s `CNF-CFG-*` register remains 0 (DECLARED EMPTY)** — no `PRD-023` amendment, no ADR |
| **Not closed** | ⛔ No identifier is allocated by this record — allocation is act **(c)**, the `CONFIGURATION_GUIDE.md` §5 amendment, performed *after* acts (a)/(b) · ⛔ `SAAS-GAP-002` D-4 limb **remains OPEN** in `PRD-022` §12 until act (d) · ⛔ `SAAS-GAP-005`/`006` untouched · ⛔ V2-deferred `SAAS-GAP-003`/`004` untouched |
| **Baseline** | HEAD `ac517f7` · `origin/main` `6ebe0e6` · `PRD-022` at v0.4.2 · `DP-0007` (ranges limb) already recorded |
| **Precedent followed** | ⭐ **`FIL-CFG-*` / `ADR-0057` pattern** — *"the owning PRD declares the register; the Configuration Owner governs placement/ranges; the guide allocates the identifiers"* · `DP-0006`/`DP-0007` decision-record convention (verbatim conferral + verification + effect + reversion) |

---

## 1. ⭐ The decision, recorded verbatim (Configuration Owner)

> **D-4 — Register home: ROUTE A is selected.** The three `PRD-022` SaaS-billing configurables are allocated
> under a **new `SAAS-CFG-*` register declared by `PRD-022`** — not under any existing `CFG-*` / `LCFG-*` /
> `ICFG-*` / `FIL-CFG-*` register (measured unfit at the D-4 investigation), and **not** under `PRD-023`'s
> `CNF-CFG-*` register (**remains 0, DECLARED EMPTY** — `PRD-023`'s "configure-itself" refusal, L122–129,
> is not the obstacle; the obstacle was the missing values, which `DP-0007` supplied).
>
> **Register members (3), published up front with `DP-0007`-decided ranges:**
> - **Platform Charge rate** — range **1%–5%**, default **3%**, platform-scoped, `PR-1`-mutable
> - **SaaS free-trial duration** — range **7–30 days**, default **14 days**, platform-scoped, `PR-1`-mutable
> - **Billing due day** — **closed set {10, 15, 25}**, default **the 15th**, platform-scoped, `PR-1`-mutable
>
> **⛔ No identifier is allocated by this record.** The `SAAS-CFG-*` member identifiers are created by **act (c)**
> — the `CONFIGURATION_GUIDE.md` §5 amendment — and **only after** the owning PRD has declared the register
> and the parameters. *A parameter that the owning PRD has not declared is not yet a configurable member, and
> the guide *"supplies values for what the specification has declared, and does not declare one into
> existence"* (`FIL-CFG-001`…`005` upload-timeout refusal, `CONFIGURATION_GUIDE.md` L719–723).*
>
> **⛔ No `PRD-023` amendment. No ADR.** The `FIL-CFG-*`/`ADR-0057` precedent used a *decision record
> authorizing a guide amendment*, not an ADR, and did not amend the frozen machinery document. This record
> follows that precedent: it **selects the route and authorizes the amendment acts**; it does not perform
> them, and it does not touch `PRD-023` (FROZEN, `BASELINE-2026-08-20-A`) or its `CNF-CFG-*`=0 register.
>
> **⛔ The Configuration Owner does not mint identifiers.** Per `CONFIGURATION_GUIDE.md` §5 L863 — *"Adding a
> parameter — a **PRD amendment** — the specification declares what is configurable, this guide does not"* —
> the **owning PRD** (`PRD-022`) must **first declare** the register and the three parameters; the guide then
> **allocates** the identifiers. The owner's act here is the **route decision + placement/range/scope fix**,
> not the allocation.

---

## 2. Verification against the repository (measured, not asserted)

| # | Claim | Measurement at HEAD `ac517f7` |
|---|---|---|
| 1 | **No existing register fits** (Route B excluded) | `CONFIGURATION_GUIDE.md` L8: `CFG-1`…`12` (Authentication) · `LCFG-1`…`13` (Library) · `ICFG-1`…`10` (Invitation) · `FIL-CFG-001`…`015` (`PRD-017` §8.5) — **none holds a SaaS-billing parameter**. `PRD-023` L311 (`CNF-FR-002`): a parameter is a Setting *"only where **its owning PRD** declares it tenant-changeable"* — none of the four is `PRD-022`'s owning register. `PRD-022` §0.2 L57–61: *"Allocating identifiers in those closed registers is the **owning PRD's act, not this one's**"* |
| 2 | **`CNF-CFG-*` stays 0 (Route B′ excluded)** | `PRD-023` L81: `CNF-CFG-` **0**, **DECLARED EMPTY** · L122: *"a configuration module that configures itself would be its own first defect"* · L129: publishing a value *"would have to invent a default and a range for a parameter no document at any rank bounds"* — the **second clause is now discharged** (`DP-0007` supplied the values), but the **first clause (the module does not own domain parameters) stands**: the values belong to `BC-20`/`PRD-022`, not to `PRD-023`. `CNF-CFG-*` is **not** the home; a *new `SAAS-CFG-*` register* is |
| 3 | **The `FIL-CFG-*`/`ADR-0057` precedent supports Route A** | `PRD-017` §8.5 **declares** all fifteen `FIL-CFG-*` slots *in its own PRD* (the owning-PRD-declares-its-register pattern) · `Accepted` `ADR-0057` (Product Owner values · **Configuration Owner** register placement/ranges/invariants · *"Amends `CONFIGURATION_GUIDE.md` → v1.2 (new §2C register…)"*) **amends the guide, not `PRD-017`** (byte-identical). ⭐ The transferable pattern: **owning PRD declares → Configuration Owner governs → guide allocates** |
| 4 | **No ADR / no `PRD-023` amendment required** | `PRD-023` is **FROZEN** (`BASELINE-2026-08-20-A`, `ADR-0053`); amending a FROZEN document requires a separate `PRD_LIFECYCLE.md` §4 successor-act with its own conferral — **not triggered here**, because the new `SAAS-CFG-*` register is **declared by `PRD-022`** (a DRAFT, not frozen) and **admitted to `PRD-023`'s resolution machinery by reference** (`ADR-0017` L132: *"PRD-023 owns the resolution machinery, not the value list"*). The `FIL-CFG-*` precedent **did not amend `PRD-017`'s frozen machinery** either — it amended the **guide** |
| 5 | **The three values are already decided (no re-decision)** | `DP-0007` L1: rate **1%–5%** (default 3%) · trial **7–30 days** (default 14 days) · due-day **closed set {10, 15, 25}** (default the 15th). This record **consumes** those values; it **does not re-decide or re-invent them** |
| 6 | **`PRD-022` byte-identity at this act** | `PRD-022` (v0.4.2 blob `f101a33…`) **unchanged** by this record — the decision is *recorded*, not *applied* to the subject; acts (a)–(d) are the amendment sequence that follows |

---

## 3. Effect of the decision

### 3.1 What is now settled (by this record)
- **The register home is Route A** — a new `SAAS-CFG-*` register, **declared by `PRD-022`**, admitted to `PRD-023`'s resolution machinery by reference.
- **The register's published range = 3 members**, each with its `DP-0007`-decided range/default/scope:
  - `SAAS-CFG-*` (1) — Platform Charge rate · 1%–5% · default 3% · platform · `PR-1`
  - `SAAS-CFG-*` (2) — SaaS free-trial duration · 7–30 days · default 14 days · platform · `PR-1`
  - `SAAS-CFG-*` (3) — Billing due day · closed set {10, 15, 25} · default the 15th · platform · `PR-1`
- **The amendment sequence is authorized** (a→b→c→d, §4 below).
- ⛔ **`PRD-023` `CNF-CFG-*` remains 0** — no `PRD-023` amendment; ⛔ **no ADR** (the `ADR-0057`-pattern decision record + guide amendment is the precedent, not an ADR); ⛔ **no identifier is minted by this record**.

### 3.2 What is NOT settled (explicitly out of scope of this record)
| Item | Status |
|---|---|
| **The register declaration itself** (act **a**) | ⛔ **Not performed** — a `PRD-022` amendment, separate named act |
| **The parameter declaration** (act **b**) | ⛔ **Not performed** — a `PRD-022` amendment, separate named act |
| **The identifier allocation** (act **c**) | ⛔ **Not performed** — a `CONFIGURATION_GUIDE.md` §5 amendment, separate named act; **the identifiers do not yet exist** |
| **The `SAAS-GAP-002` D-4 closure** (act **d**) | ⛔ **Not performed** — a `PRD-022` §12 subject-amendment, separate named act |
| `SAAS-GAP-005` / `SAAS-GAP-006` | ⛔ **Untouched** — remain OPEN (V1-blocking) |
| `SAAS-GAP-003` / `SAAS-GAP-004` | ⛔ **Untouched** — V2/DEFERRED per `Accepted` `ADR-0130` |

### 3.3 Blocker impact
- **Until act (d) completes:** `SAAS-GAP-002` D-4 limb **still blocks Stage 4 + Freeze**; V1-blocking count = **3** (`SAAS-GAP-002`-D4 · `SAAS-GAP-005` · `SAAS-GAP-006`).
- **After act (d):** count → **2** (`SAAS-GAP-005` · `SAAS-GAP-006`); `SAAS-GAP-003`/`004` remain V2/DEFERRED.
- ⚠ `SAAS-GAP-006`'s *"Stage 3 not performed"* cell was in fact **CLOSED** by the CONFERRED Stage-3 alignment record — its §12.1 row is *preserved as recorded*; the count-2 figure is conservative and includes it.

---

## 4. ⭐ Required amendment sequence (authorized by this record; each a SEPARATE named act)

| # | Act | Office | Prerequisite | What it does (⛔ what it does NOT do) |
|---|---|---|---|---|
| **a** | **Register establishment** — `PRD-022` amendment *declaring* the `SAAS-CFG-*` register, published up front with range (3 members) per `PRD_LIFECYCLE.md` L82 rule 2–3 | **`PRD-022` owning office**, under this Configuration Owner Route-A decision | This record | ⛔ Does **not** allocate identifiers; does **not** declare the parameters yet |
| **b** | **Parameter declaration** — `PRD-022` amendment declaring the three configurables as `SAAS-CFG-*` members, each with its `DP-0007` range/default/scope | **`PRD-022` owning office** | (a) | ⛔ Does **not** allocate identifiers; the values come from `DP-0007`, not from this act |
| **c** | **Identifier allocation** — `CONFIGURATION_GUIDE.md` §5 amendment allocating the three `SAAS-CFG-*` identifiers, each with default + range + owner (`PR-1`) | **Configuration Owner / guide owner** | (b) | ⛔ Only *after* the owning PRD has declared the register **and** the parameters — *"the specification declares what is configurable, this guide does not"* (L863) |
| **d** | **`SAAS-GAP-002` D-4 closure** — `PRD-022` §12 subject amendment recording the identifier-allocation limb **CLOSED** at `SAAS-CFG-*` | **Product/Governance Owner** (subject-amendment act) | (c) | ⛔ Records the closure; does **not** re-open or move `SAAS-GAP-003`/`004`/`005`/`006` |

> **Ordering is load-bearing:** (c) *cannot* precede (a)+(b) — the guide allocates identifiers for parameters the
> owning PRD has *declared*, not for parameters it has not. This is the exact `FIL-CFG-001`…`005`
> upload-timeout discipline (`CONFIGURATION_GUIDE.md` L719–723: *"Supplying a value for an undeclared parameter
> would be this guide declaring one into existence"*).

---

## 5. Conferral and reversion

| Field | Value |
|---|---|
| **Deciding authority** | ⭐ **Configuration Owner** (`BC-25`/`PRD-023` office), single-act decision, recorded verbatim at §1 |
| **Scope** | ⭐ *"Only the D-4 register-home and route decision for `SAAS-GAP-002`"* — Route A selection + the register's published 3-member range/scope + authorization of the (a)→(d) sequence, **nothing more** |
| ⛔ **Not claimed** | ⛔ No Product / Architecture / Authorization / Governance / `BC-05` office acted for this decision · ⛔ no independent review, quorum or sign-off claimed |
| ⛔ **Not reused** | ⛔ `DP-0007`'s decision act (the `SAAS-GAP-002` ranges — *"a decision is not a specification"*, and a route decision is not a value decision) · ⛔ `ADR-0057`'s conferral (the `FIL-CFG-*` placement — consumed by that precedent, not standing) · ⛔ `ADR-0130`'s joint conferral (the V1/V2 re-scope) |
| ⭐ **Reversion** | ⭐ Reverts on completion of this recording act (`ADR-0033` §7.1: *"a conferral for one act is not a standing licence"*). ⛔ The four amendment acts **(a)–(d)** each require **their own named office act**, sequenced per §4 — **this record authorizes the route; it does not perform any amendment** |

---

*End of `DP-0008`. ⭐ **D-4 ROUTE A SELECTED — new `SAAS-CFG-*` register declared by `PRD-022`** (3 members: rate 1–5%/3% · trial 7–30d/14d · due-day {10,15,25}/15th, all platform-scoped, `PR-1`-mutable). ⛔ **`PRD-023` `CNF-CFG-*` remains 0** — no `PRD-023` amendment, no ADR. ⛔ **0 identifiers allocated by this record** — allocation is act (c), the guide amendment, performed *after* acts (a)/(b). ⛔ **`SAAS-GAP-002` D-4 limb still OPEN** in `PRD-022` §12 until act (d). `PRD-022` (v0.4.2), `PRD-023` (FROZEN), `PRD-008`, `MASTER_PRD`, `CONFIGURATION_GUIDE.md` **byte-unchanged**. `SAAS-GAP-003`/`004`/`005`/`006` **untouched**. No commit, no amend, no push performed by this record.*
