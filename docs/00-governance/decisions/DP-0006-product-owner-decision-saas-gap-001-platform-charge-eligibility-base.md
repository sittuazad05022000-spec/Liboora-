# DP-0006 — Product Owner decision record: `SAAS-GAP-001` Platform Charge eligibility base

| Field | Value |
|---|---|
| **Type** | ⭐ **Recorded Product Owner decision** — a decision *given by the principal and recorded verbatim*; ⛔ NOT an ADR, NOT an amendment, NOT an authorization |
| **Status** | ⭐ **DECIDED 2026-09-25** · ⚠ **PENDING RECONCILIATION** — `PRD-022` §12 `SAAS-GAP-001` cell still reads OPEN; recording the decision *in the gap ledger* is a separate, named subject-amendment act (Product Owner), **not performed by this record** |
| **Gap closed (in fact, not yet in text)** | `SAAS-GAP-001` — *"Platform Charge eligibility base is undecided"* (`PRD-022` L198, L702–710) |
| **Not closed** | ⛔ `SAAS-GAP-002` (ranges + identifier allocation — *"a decision is not a specification"*) · ⛔ `SAAS-GAP-005` (trial-eligibility identity) · ⛔ `SAAS-GAP-007` (Feb 29–31) · ⛔ V2-deferred `SAAS-GAP-003`/`004` |
| **Baseline** | HEAD `8677cb5` · `origin/main` `6ebe0e6` |
| **PRD-022 byte-identity** | `sha256 0571a0e2…27f9` **unchanged by this record** — this document *records* a decision; it does *not amend* the subject |
| **Precedents followed** | `DP-0001`…`DP-0005` (`docs/00-governance/decisions/`) · `ADR-0039`/`ADR-0043` decision-record pattern (*"a decision is not a specification"* — `PRD-008` v1.4 header, the repository's own rule) |

---

## 1. ⭐ The decision, recorded verbatim (Product Owner)

> **`SAAS-GAP-001` is DECIDED: the Platform Charge applies to ALL confirmed `BC-05` collection fee types —
> the full existing confirmed-collection boundary of `BC-05`, without exception and without enumeration —
> subject to the fee-type taxonomy already decided by `Accepted` `ADR-0039` §4.**
>
> **The Platform Charge default rate remains 3% (L166), and the Platform Administrator (`PR-1`) may change
> the configured rate** (as `SAAS-FR-001` already requires).
>
> ⛔ **No fee type is invented, renamed, or redefined by this decision.** The eligibility base is *the
> boundary `BC-05` already owns*, not a new enumeration written from the outside.
> ⛔ **The minimum/maximum rate range is NOT decided here** — that is `SAAS-GAP-002`'s, a separate act.
> ⛔ **No V2 scope is entered; no permission, identifier, or configuration row is created.**

---

## 2. Verification against the repository (measured, not asserted)

| # | Claim | Measurement at HEAD `8677cb5` |
|---|---|---|
| 1 | The eligibility base exists as a decided taxonomy | `PRD-008` **L2214** (`FEE-GAP-004` block): *"✅ **DECIDED at v1.4 — RECORDED IN `ADR-0039` §4…** V1 fee types are **Membership Fee, Renewal Fee, Registration / Admission Fee, Other approved library fee** — all revenue — and **Security Deposit**, which is ⛔ **NOT revenue** but a **refundable liability**."* · `Accepted` `ADR-0039` (L6 of its file; `ADR-INDEX` L230: promoted `PROPOSED` → `ACCEPTED` in scope 2026-08-15, §3–§6 binding) |
| 2 | The decision does not reopen `FEE-GAP-004` | ⛔ This record *consumes* the decided taxonomy; it **adds no fee type and removes none**. `PRD-008` L2430 register row: taxonomy *"Supplies the **base** `PRD-022` `SAAS-GAP-001` needs, **without closing that gap**"* — the *supply* half was complete; the *consumption* half (this decision) is what moves the gap |
| 3 | "All confirmed collections within `BC-05`'s existing boundary" is well-defined | `SAAS-FR-002` (L169–170): accrual *"only from a **confirmed** student collection fact produced by `BC-05`"*; `SAAS-XC-004` (L127–128) bars accrual from unconfirmed/pending/failed/offline-recorded payments; `SAAS-BR-013` (L511–512): *channel is not an input* — cash and online collections accrue identically. The decision therefore adds **no new accrual path**; it only fixes *which confirmed facts* are in scope: **all of them, as `BC-05`'s boundary defines them** |
| 4 | No fee-type redefinition | `PRD-008` L373: the taxonomy is *"deliberately NOT written as an enumeration"* because `FEE-FR-006` requires a configurable value through `E-19` — a hard-coded list would *contradict* `PRD-008`'s own requirement. This decision honours that: it points at `BC-05`'s **existing confirmed-collection boundary**, it does **not** re-list the five `ADR-0039` types, and it **explicitly refuses** to invent an *"everything"* default (the `SAAS-GAP-001` block L710: *"What was NOT invented: No eligibility list, no fee-type enumeration, no default of 'everything'"* — the decision instead **binds to the boundary**, which is the taxonomy's own lawful home) |
| 5 | 3% default and `PR-1` mutability are already in the text | `SAAS-FR-001` (L166–167): *"platform-scoped configurable value with a default of **3%**"* · `SAAS-GAP-002` block and §11 table (L664): platform-level values changeable by `PR-1` *"via the authorised platform configuration mechanism"* · `SAAS-AC-005` (L672–673): library actors cannot alter platform-level values — the `PR-1` mutability claim is **consistent with existing text**, not an amendment |
| 6 | No V2 scope entered, no V2-adjacent act | `SAAS-GAP-003`/`004` remain **V2/DEFERRED** per `Accepted` `ADR-0130` §3/§4 (L728–739); this decision touches neither the rail nor the permission question; `Q-B31` untouched |
| 7 | No permissions/IDs/config rows | ⛔ **0** `PERM-*`, **0** `SAAS-*`, **0** `CFG-*`/`LCFG-*`/`ICFG-*` identifiers created (identifier allocation is `SAAS-GAP-002`'s second act, owned by `BC-25`/`PRD-023`); `AUTH-7.22`'s closed catalogue untouched |
| 8 | `PRD-022` / `PRD-008` unmodified | `PRD-022` blob `59f64d26…` (git) / `sha256 0571a0e2…` (byte) unchanged · `PRD-008` v1.7 **byte-unchanged** (the `ADR-0130`/`ADR-0134` disclosure: §6.1 divergence still stands, successor route still unperformed) |

---

## 3. Effect of the decision

### 3.1 What is now settled

| ID | Effect |
|---|---|
| `SAAS-GAP-001` (in fact) | **DECIDED** — the eligibility base is `BC-05`'s existing confirmed-collection boundary, consuming `ADR-0039` §4's decided taxonomy without restating it |
| `SAAS-FR-002` (L169) | *"confirmed"* now has a **closed base**: any confirmed `BC-05` collection fact |
| `SAAS-FR-007` (L232–234) | The §6.1/§7A viewing set is now **complete** — it displays *"total confirmed collections the charge was computed from"* over the decided base; its traceability cell (L873: *"UNTRACED — the display set depends on `SAAS-GAP-001` eligibility"*) becomes **traced on amendment** |
| `SAAS-BR-002`/`013` (§4/§7B load tests) | The **₹15-per-₹500** arithmetic applies to **all** confirmed collections — the §7B "identical totals, different mechanisms" test now runs over the decided base with **no residual eligibility question** |
| `SAAS-AC-006`/`007`/`024`/`025` | Testable over the decided base — *"a rate without a base computes nothing"* (L802) no longer applies: the base is now `BC-05`'s confirmed-collection boundary |

### 3.2 What is NOT settled (explicitly out of scope of this decision)

| ID | Status |
|---|---|
| `SAAS-GAP-002` | ⛔ **OPEN** — min/max **range** for rate / trial / due day, and the `BC-25`/`PRD-023` identifier-allocation act, remain separate (Product Owner for ranges; `BC-25` owner for the register act) |
| `SAAS-GAP-005` | ⛔ **OPEN** — trial-eligibility identity anchor (Architecture Owner + `PRD-001`) |
| `SAAS-GAP-007` | ⛔ **OPEN** — due-day 29–31 February behaviour (Product Owner + `BC-25` range); the 15th default is unaffected (L771–772) |
| `SAAS-GAP-003`/`004` | ⛔ **V2/DEFERRED** — *unchanged* by this decision |
| `FEE-GAP-004` | ⛔ Remains in its `ADR-0039`-recorded DECIDED state — **not reopened, not re-recorded, not re-enumerated** |

### 3.3 Reconciliation debt created by this decision (named, NOT performed)

1. **`PRD-022` §12 `SAAS-GAP-001` cell** (L702–710) still reads *"undecided"* — a **Product Owner subject-amendment act** must record the decision in the gap ledger and re-derive the *"5 block Stage 4"* count (L786 → 4). Separate act, ⛔ not performed by this record.
2. **`SAAS-FR-007` traceability cell** (L873) still reads *"UNTRACED — the display set depends on `SAAS-GAP-001`"* — the same subject-amendment act clears it.
3. **`PRD-008` L2430/L2458 register rows** carry the cross-module note *"one open product question now blocks **two** modules"* — a **`BC-05`-owner / Governance Owner** registry reconciliation, ⛔ not performed here.
4. **Stage-4 position** — this decision removes **one of the three V1-blocking gaps**; the clean-Stage-4-verdict position is unchanged until `SAAS-GAP-002` (both acts) and `SAAS-GAP-005` are also decided. ⛔ No Stage-4 verdict is recorded by this record.

---

## 4. Conferral and reversion

| Field | Value |
|---|---|
| **Deciding authority** | ⭐ **Product Owner**, single-act decision, recorded verbatim at §1 |
| **Scope** | ⭐ *"Only the `SAAS-GAP-001` eligibility-base decision"* — the four statements at §1, no more |
| ⛔ **Not claimed** | ⛔ No Architecture / Authorization / Governance / `BC-25` / `BC-05` office acted · ⛔ no independent review, quorum or sign-off claimed |
| ⛔ **Not reused** | ⛔ `ADR-0039`'s conferral (spent on the `FEE-GAP-004` taxonomy) · ⛔ `ADR-0130`'s joint conferral (spent on the V1/V2 re-scope) · ⛔ `ADR-0043`'s conferral (spent on `PRD-008`'s freeze blockers) |
| ⭐ **Reversion** | ⭐ Reverts on completion of this recording act (`ADR-0033` §7.1: *"a conferral for one act is not a standing licence"*). ⛔ The `SAAS-GAP-001` subject-amendment act, the `SAAS-GAP-002` range decision, the `BC-25` identifier-allocation act, the `SAAS-GAP-005` identity act, and any Stage-4 verdict **each require a NEW conferral or the competent office** |

---

*End of `DP-0006`. ⭐ **`SAAS-GAP-001` DECIDED IN FACT — `BC-05`'s boundary consumed, not enumerated; 3% default and `PR-1` mutability confirmed as already-required; no fee type invented; `SAAS-GAP-002` range and `SAAS-GAP-005` identity remain OPEN; V2/deferred items untouched.** `PRD-022` and `PRD-008` **byte-unchanged**. No commit, no amend, no push performed by this record.*
