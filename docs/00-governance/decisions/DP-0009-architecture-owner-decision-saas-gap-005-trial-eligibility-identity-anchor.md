# DP-0009 — Architecture Owner decision record: `SAAS-GAP-005` trial-eligibility identity anchor

| Field | Value |
|---|---|
| **Type** | ⭐ **Recorded Architecture Owner decision** — a decision *given by the Architecture Owner and recorded verbatim*; ⛔ NOT an ADR, NOT a publication amendment, NOT an identifier allocation |
| **Status** | ⭐ **DECIDED 2026-09-25** · ⚠ **PENDING PUBLICATION ACTS** — this record *decides*; the BC Map §8 single-cell publication (act (b)) and the `PRD-022`/`PRD-013` subject reconciliations (acts (c)/(d)) are **separate named acts** performed **after** this record, by the offices named below |
| **Gap decided (in fact, not yet in text)** | `SAAS-GAP-005` — *"Trial eligibility identity"* (`PRD-022` L760–768), the sole remaining V1 blocker (`SAAS-GAP-003`/`004` V2/DEFERRED · `SAAS-GAP-001`/`002`/`006`/`007` closed/resolved) |
| **Decision** | ⭐ **The trial-eligibility anchor is `TenantTrialState`, a new `BC-19` `Tenant`-aggregate member** — state-stable across Suspend/Archive/Restore, erasure-immune in V1, evaluated solely on the immutable `Tenant ID` (+ no fingerprinting/device/contact matching), published as a **BC Map §8 single-member invariant** by the `ADR-0096`-style single-cell append instrument |
| **Not closed** | ⛔ `SAAS-GAP-005` **remains OPEN in `PRD-022` §12** until the BC Map publication (act (b)) and the `PRD-022` subject amendment (act (c)) are performed · ⛔ `PRD-013` `TEN-GAP-003` (which is *"= `SAAS-GAP-005`"*, L435) remains OPEN until the cross-reference reconciliation (act (d)) · ⛔ V2-deferred `SAAS-GAP-003`/`004` untouched |
| **Baseline** | HEAD `b00ac58` · `origin/main` `6ebe0e6` · `PRD-022` at v0.4.5 blob (byte-identical before and after this record) · 0 `SAAS-*`/`SAAS-CFG-*` identifiers minted by this record |
| **Precedent followed** | `DP-0006`/`DP-0007`/`DP-0008` decision-record convention (verbatim conferral + verification + effect + reversion) · **publication instrument: `Accepted` `ADR-0096`** — *"by APPEND as new §17, the `ADR-0079` §8.5 Option A method that `ADR-0083` (§15) and `ADR-0085` (§16) both used"* (single-cell normative append, no line-citation invalidation) |

---

## 1. ⭐ The decision, recorded verbatim (Architecture Owner)

> **A — Trial-consumed fact.** The trial-eligibility anchor is **`TenantTrialState`** — a new member of the
> `BC-19` `Tenant` aggregate recording that this `Tenant ID` has **consumed its one platform trial**.
> ⛔ **No `SAAS-*` or `SAAS-CFG-*` identifier is minted** — the `SAAS-*` register belongs to `PRD-022`'s
> requirement surface; `TenantTrialState` is a **tenant-domain fact**, and a `SAAS-`-prefixed identifier for a
> `BC-19` fact would cross the module's prefix boundary.
>
> **B — Ownership.** `TenantTrialState` belongs to the **`BC-19` `Tenant` aggregate** — **not** `BC-20`
> (whose `Subscription` aggregate is about money, not tenant-identity persistence) and **not** `BC-25`
> (configuration resolution, not domain facts). The *identity* the question anchors is `BC-19`'s: the
> BC Map §8 invariant *"Tenant ID immutable"* already makes a V1 *"recreation"* a **state transition of the
> same `Tenant ID`**, so the fact anchoring to that identity is owned where the identity is owned.
>
> **C — Survival.** `TenantTrialState = CONSUMED` **survives all four states, without reset or refund:**
> - **Suspend** — survives, unchanged (`LIB-8.4`: *"Suspension MUST NOT delete, alter or invalidate any
>   business record"* — trial consumption *is* a business record).
> - **Archive** — survives, unchanged (`LIB-8.8`: `Archive` is the terminal V1 state; an archived tenant
>   that consumed a trial still reads `CONSUMED` — the trial is not refunded on archive).
> - **Restore** — survives, **without reset** (`LIB-8.5`: `Restore` returns the tenant to *Suspended*, never
>   directly to Active; the trial state is not reset by restore — a restored tenant does not regain a trial).
> - **`CFG-10` account-erasure window** — `CFG-10` is an **account-level** (Authentication `BC-18`) retention
>   parameter, not a `BC-19` tenant-domain fact; **permanent deletion is out of V1 scope** (`LIB-8.8`), so
>   there is **no V1 erasure path that reaches the `Tenant` aggregate**. `TenantTrialState` is therefore
>   **erasure-immune in V1 by construction**. ⚠ **True tenant erasure / new-`Tenant-ID` behaviour is
>   explicitly OUTSIDE this V1 decision** — if a permanent tenant-deletion path is ever introduced in V2, the
>   survival of `TenantTrialState` across *true* erasure is a **V2 decision, not a V1 gap**, and this record
>   does not pre-empt it.
>
> **D — Identity evaluation.** Trial eligibility is evaluated **solely** on the **immutable `Tenant ID` +
> `TenantTrialState`**: *"Given a library whose `Tenant ID` = T and `TenantTrialState(T)` = CONSUMED,
> deletion and re-creation under the same `Tenant ID` T yields a library whose trial eligibility is
> refused."* ⛔ **No fingerprinting. No device matching. No contact matching. No account-recovery matching.**
> A V1 delete/archive → restore/recreation flow **does not create a new tenant identity**; the same
> `Tenant ID` retains its consumed trial state. This makes `SAAS-AC-003` *"A library that has consumed a
> trial and is then deleted and recreated does not receive a second trial"* **directly testable** — the
> test sets up a `Tenant ID` with `TenantTrialState = CONSUMED`, runs the delete→recreate state path, and
> asserts the trial is refused.
>
> **E — Publication.** The rule publishes as a **new `BC-19` `Tenant`-aggregate member `TenantTrialState`
> in the BC Map §8 register**, by the **`ADR-0096`-style single-cell append instrument** (a single-cell
> normative append to BC Map §8 L381, the `ADR-0083` §15 / `ADR-0085` §16 / `ADR-0096` §17 method —
> **appended, not inserted**, so **no line-citation is invalidated**). ⛔ **The `PRD-013` §4 successor
> route is NOT used** — the owner selected the lighter single-cell instrument. ⛔ `PRD-022` **only
> consumes/references** the published rule and reconciles `SAAS-GAP-005`; it **must not define the `BC-19`
> rule** (the gap's own `Measured` line, L765: *"Tenant lifecycle is not `BC-20`'s aggregate"*).

---

## 2. Verification against the repository (measured, not asserted)

| # | Claim | Measurement at HEAD `b00ac58` |
|---|---|---|
| 1 | **The tenant *identity* is already owned by `BC-19`** | BC Map §8 **L381**: `BC-19` `Tenant` aggregate, published members `TenantTier`/`Quota`/`ResidencyRegion`/`TenantLifecycleState`; invariant *"**Tenant ID immutable**; suspended tenant rejects all writes; residency region immutable after first write"*. A fifth lifecycle-state member (`TenantTrialState`) is the **convention-consistent** home — not a new aggregate, not a new edge |
| 2 | **`BC-20` is the wrong owner (money ≠ identity)** | BC Map §8 **L382**: `BC-20` `Subscription`/`SubscriptionInvoice` aggregates — *"One active subscription per tenant; payment idempotent by gateway reference; invoice immutable once finalised"* — a **billing** aggregate, not an identity-persistence aggregate. `SAAS-GAP-005` block **L765**: *"Tenant lifecycle is not `BC-20`'s aggregate"* — the gap *itself* already states the ownership direction the decision confirms |
| 3 | **The four C-states are governed by frozen rules** | `LIB-8.4` (frozen): *"Suspension MUST NOT delete, alter or invalidate any business record"* · `LIB-8.5` (frozen): *"Archive MUST be reversible via Restore; Restore returns the library to Suspended, never directly to Active"* · `LIB-8.8` (frozen): *"Permanent deletion is out of V1 scope; Archive is the terminal state"* — the survival matrix **C is compelled by these frozen rules, not invented** |
| 4 | **The `CFG-10` erasure window does not reach the `Tenant` aggregate in V1** | `Authentication_PRD_v2.md` **L80**: `CFG-10` = *"Soft-deleted account retention before permanent erasure"* (30 days) — an **account-level** (`BC-18`/Authentication) parameter. `LIB-8.8` (frozen): permanent deletion **out of V1 scope**. ⛔ No V1 path erases the `BC-19 Tenant` aggregate → `TenantTrialState` is erasure-immune in V1 **by construction**, not by a new retention rule |
| 5 | **No fingerprinting/device/contact matching is introduced** | `SAAS-GAP-005` **"What was NOT invented"** line (**L768**): *"No identity rule, no fingerprinting, no device or contact-based matching — the last of which would also be a privacy decision this document may not take."* The decision's clause D **honours this**: evaluation is a **direct read of the tenant fact**, not an identity inference |
| 6 | **The publication instrument is the lighter `ADR-0096` route, not a `PRD-013` §4 successor** | `Accepted` `ADR-0096` header: *"Amends `LIBOORA_BOUNDED_CONTEXT_MAP.md` (Rank 4) — by **APPEND as new §17**, the `ADR-0079` §8.5 Option A method that `ADR-0083` (§15) and `ADR-0085` (§16) both used. ⛔ §7 is NOT edited… Executed, see §8."* ⭐ This is the **single-cell normative append** instrument the owner selected for act (b) — a BC Map §8 single-member invariant, **appended not inserted** |
| 7 | **`PRD-022` is the consumer, not the definer** | `SAAS-GAP-005` block **L765** (*"depends on the tenant lifecycle that `PRD-001` and `BC-25` own, not this document"*) + **L768** (*"Recorded as `SAAS-GAP-005` rather than resolved by asserting a rule about identity that another module owns"*). The decision **E** confirms: `PRD-022` reconciles `SAAS-GAP-005` by *referencing* the published `TenantTrialState` rule; it does **not** define the `BC-19` rule |
| 8 | **No `SAAS-*` identifier is minted** | The `SAAS-*` register (`PRD-022` §0.2, 105 identifiers) is **untouched** — `TenantTrialState` is a `BC-19`-owned fact published in the BC Map §8 register, not a `SAAS-*` identifier. ⛔ **0 `SAAS-CFG-*`/`SAAS-*` identifiers created by this record** |
| 9 | **`PRD-013` `TEN-GAP-003` is the same open question, closed together** | `PRD-013` **L412–418** (`TEN-GAP-003` — Tenant deletion identity): *"`PRD-022` L650–651: 'deciding which identity survives a deletion…' Routed by `PRD-022` L749 as `SAAS-GAP-005`… **Unresolved, and not this PRD's to close."*** · **L435** (§10.1): *"`SAAS-GAP-005` | **Open** = `TEN-GAP-003` | **Architecture Owner + `PRD-001`"**.* ⭐ The decision **E**'s publication closes **both** to the *same* published rule — the act (d) reconciliation records that `TEN-GAP-003` is *"= `SAAS-GAP-005`"* and both leave the open set together |

---

## 3. Effect of the decision

### 3.1 What is now settled (by this record)
- **The fact name, its owner, its survival matrix, its identity-evaluation rule, and its publication instrument are DECIDED** (clauses A–E, §1).
- **`SAAS-AC-003` is now testable** — the *"deleted and recreated does not receive a second trial"* criterion has a **named, owned, persistent** anchor (`Tenant ID` + `TenantTrialState`) and **no identity-inference dependency**.
- **The V1 boundary is explicit** — true tenant erasure / new-`Tenant-ID` behaviour is **out of this decision** (clause C's V2 note); the V2 owner is not pre-empted.

### 3.2 What is NOT settled (explicitly out of scope of this record)
| Item | Status |
|---|---|
| **The BC Map §8 single-cell publication** (act **b**) | ⛔ **Not performed** — this record *decides*; the single-cell append to BC Map §8 L381 (adding `TenantTrialState` as a `Tenant`-aggregate member + its survival invariant) is a **separate named act** by the Architecture Owner / BC Map owner, using the `ADR-0096` instrument |
| **The `PRD-022` subject amendment** (act **c**) | ⛔ **Not performed** — `SAAS-GAP-005`'s §12 cell → **CLOSED** (citing the published `TenantTrialState` rule) · `SAAS-FR-018`/`SAAS-AC-003`/`SAAS-BR-009` gain the **named-fact reference** · traceability moves **59/64 → 61/64 = 95.3%** · V1-blocking count **1 → 0** — all a **separate named `PRD-022` subject-amendment act** |
| **The `PRD-013` `TEN-GAP-003` cross-reference reconciliation** (act **d**) | ⛔ **Not performed** — `PRD-013` L412–418/L435 records that `TEN-GAP-003` *"= `SAAS-GAP-005`"*; the reconciliation is a **separate named `PRD-013` owner act** |
| `SAAS-GAP-003`/`004` | ⛔ **V2/DEFERRED, unchanged** (`Accepted` `ADR-0130` §3/§4) |
| `SAAS-GAP-001`/`002`/`006`/`007` | ⛔ **Already closed/resolved, untouched** by this record |
| **Any V2 true-erasure survival rule** | ⛔ **Out of scope** — clause C's V2 note defers it to the V2 owner; this record does not pre-empt it |

### 3.3 Blocker impact
- **Until acts (b)+(c) complete:** `SAAS-GAP-005` **still blocks Stage 4 + Freeze** (its §12 `Blocks` row: *"Stage 4 ✅ · Freeze ✅"*); V1-blocking count = **1** (`SAAS-GAP-005`).
- **After act (c):** V1-blocking count → **0**; `SAAS-AC-003`/`SAAS-BR-009` become traced (59→61/64 = 95.3%); `SAAS-GAP-005` leaves the V1-blocking set **entirely** (all limbs: fact name, owner, survival, identity, publication — all decided and published).
- ⚠ `SAAS-GAP-006`'s *"Stage 3 not performed"* cell was in fact **CLOSED** by the Stage 3 CONFERRED alignment record — its §12.1 row is *preserved as recorded*; the count-0 figure is the *conservative* one that does **not** re-claim that closure here.

---

## 4. ⭐ Required publication & reconciliation sequence (authorized by this record; each a SEPARATE named act)

| # | Act | Office | Prerequisite | What it does (⛔ what it does NOT do) |
|---|---|---|---|---|
| **b** | **BC Map §8 single-cell publication** — append `TenantTrialState` as a new `Tenant`-aggregate member + its survival invariant, by the `ADR-0096` single-cell instrument (*appended, not inserted*; no line-citation invalidated) | **Architecture Owner / BC Map owner** | This record (DP-0009) | ⛔ Does **not** edit BC Map §7 · does **not** add a new edge (`E-*`) · does **not** change the 31-context / 28/29-edge count · does **not** amend `PRD-013` |
| **c** | **`PRD-022` subject amendment** — `SAAS-GAP-005` §12 cell → **CLOSED** citing the published `TenantTrialState` rule · `SAAS-FR-018`/`SAAS-AC-003`/`SAAS-BR-009` gain the **named-fact reference** · traceability **59→61/64 = 95.3%** · V1-blocking count **1→0** · version/changelog/footer | **Product/Governance Owner** (subject-amendment act) | (b) | ⛔ Does **not** define the `BC-19` rule (that is (b)'s) · does **not** mint any `SAAS-*` identifier · does **not** move `SAAS-GAP-003`/`004`/`005`-closed/`006`/`007` |
| **d** | **`PRD-013` `TEN-GAP-003` cross-reference reconciliation** — L412–418/L435 records that `TEN-GAP-003` *"= `SAAS-GAP-005`"* and both leave the open set together against the *same* published `TenantTrialState` rule | **`PRD-013` owner** (subject-amendment act) | (b) + (c) | ⛔ Does **not** re-decide the identity anchor · does **not** amend `LIB-8.x` (frozen) · does **not** touch `SAAS-GAP-003`/`004` |

> **Ordering is load-bearing:** (c) and (d) *reference* the rule that (b) *publishes* — the subject amendments
> cannot close `SAAS-GAP-005`/`TEN-GAP-003` against a rule that is not yet published in the BC Map §8 register.
> This is the same *"owning document publishes, consuming document references"* discipline as the `FIL-CFG-*`/
> `ADR-0057` and `SAAS-CFG-*`/`DP-0008` precedents.

---

## 5. Verification criteria (for the follow-up acts, measured not claimed)

- [ ] The published `TenantTrialState` fact is **named, owned** (`BC-19`), and its **survival invariant** is
      stated for **all four C-states** (Suspend / Archive / Restore / `CFG-10` window) in the **BC Map §8**
      register cell.
- [ ] `SAAS-AC-003` is **testable** without any identity heuristic — the test reads `Tenant ID` +
      `TenantTrialState` and asserts trial refusal for a *same-`Tenant-ID`* delete→recreate path.
- [ ] `SAAS-GAP-005` **and** `PRD-013` `TEN-GAP-003` both read **CLOSED** against the **same** published
      `TenantTrialState` rule (act (d) records the *"= `SAAS-GAP-005`"* equivalence).
- [ ] **No `SAAS-*`/`SAAS-CFG-*` identifier was minted** (the `SAAS-*` register count is **unchanged at 105**).
- [ ] **No BC Map edge** (`E-*`) was added and **no context** (still **31**) / **no aggregate** beyond the
      single `TenantTrialState` member was changed (BC Map §8 single-cell instrument, `ADR-0096` precedent).
- [ ] `PRD-023` (FROZEN, `CNF-CFG-*` = 0) · `PRD-001` · `PRD-008` · `MASTER_PRD` · `CONFIGURATION_GUIDE.md`
      are **byte-unchanged** by acts (b)/(c)/(d).
- [ ] The **V2 true-erasure survival question** is **recorded as out of V1 scope** (clause C's V2 note) and
      **not** answered by any V1 document.

---

## 6. Conferral and reversion

| Field | Value |
|---|---|
| **Deciding authority** | ⭐ **Architecture Owner** (decision + publication routing), single-act conferral, recorded verbatim at §1 |
| **Scope** | ⭐ *"Only the `SAAS-GAP-005` trial-eligibility identity-anchor decisions A–E"* — the fact name · `BC-19` ownership · the four-state survival matrix · the identity-evaluation rule · the `ADR-0096`-instrument publication, **nothing more** |
| ⛔ **Not claimed** | ⛔ No Product / Configuration / Authorization / Governance / `BC-05` office acted for this decision · ⛔ no independent review, quorum or sign-off claimed |
| ⛔ **Not reused** | ⛔ `DP-0008`'s Configuration-Owner route decision (the `SAAS-CFG-*` register — *"a decision is not a specification"*, and a tenant-identity decision is not a configuration-value decision) · ⛔ `ADR-0096`'s conferral (the `E-30`/Profile-View edge — consumed here *only as the publication instrument*, not re-decided) · ⛔ `ADR-0130`'s joint conferral (the V1/V2 re-scope) |
| ⭐ **Reversion** | ⭐ Reverts on completion of this recording act (`ADR-0033` §7.1: *"a conferral for one act is not a standing licence"*). ⛔ The BC Map publication (b), the `PRD-022` subject amendment (c), the `PRD-013` `TEN-GAP-003` reconciliation (d), and any **V2** true-erasure survival decision **each require a NEW conferral or the competent office** |

---

*End of `DP-0009`. ⭐ **`SAAS-GAP-005` DECIDED IN FACT — `TenantTrialState`, a `BC-19` `Tenant`-aggregate member, state-stable across Suspend/Archive/Restore, erasure-immune in V1, evaluated solely on the immutable `Tenant ID` (no fingerprinting/device/contact matching), published as a BC Map §8 single-member invariant by the `ADR-0096` single-cell append instrument.** ⛔ **No `SAAS-*`/`SAAS-CFG-*` identifier minted.** ⛔ **The rule is NOT yet published in the BC Map (act b), and `SAAS-GAP-005`/`TEN-GAP-003` are NOT yet reconciled closed (acts c/d)** — this record *decides*; the publication and reconciliation are the separate named acts that follow. `PRD-022` (v0.4.5), `PRD-013`, `PRD-001`, `PRD-008`, `MASTER_PRD`, `CONFIGURATION_GUIDE.md` and the BC Map **byte-unchanged** by this record. `SAAS-GAP-003`/`004` **V2/DEFERRED, untouched**. No commit, no amend, no push performed by this record.*
