# ADR-0173 — **LCG-GAP-005 value authority: group name bounds, description bounds, per-community group cap and per-group membership cap, platform-fixed for V1**

| Field | Value |
|---|---|
| **Status** | ⚠ **PROPOSED** — pending the **Product Owner** one-act conferral. ⛔ **No authority is claimed for acceptance.** ⛔ This ADR is **NOT self-accepted**, and the conferral is **NOT recorded here as performed** — §8 states it is **PENDING** |
| **Rank** | 2 — Architecture Decision Record |
| **Date prepared** | 2026-09-25 |
| **Bounded context** | ⭐ **`BC-15` Community & Groups** / `PRD-021A` Part **A4** *(the subject of this decision)* · **`BC-25` Configuration** *(resolution machinery, ⛔ byte-unchanged)* |
| **Supersedes** | ⛔ **NOTHING** |
| **Superseded by** | — |
| **Amends** | ⛔ **NOTHING** at filing time — ⭐ `PRD-023` is **byte-unchanged**; ⭐ A4's `LCG-GAP-005` register row is **not edited by this ADR** |
| **Closes** | ⚠ **`LCG-GAP-005`** *(name bounds, description bounds, group/membership caps — A4 §31 L685, OPEN)* — **closure is effective only upon `Accepted` status and the A4 amendment act; while `PROPOSED` the gap remains OPEN** |
| **Decides** | ⭐ **One question — the four value decisions recorded in `LCG-GAP-005` and nothing else.** ⛔ **Nothing else** |
| **Expressly does NOT decide** | ⛔ **no new roles** · ⛔ **no new permissions** · ⛔ **no new scopes** · ⛔ **no new identifiers** · ⛔ **no new events** · ⛔ **no new architecture contracts** · ⛔ **no `PRD-023` amendment** · ⛔ **no `LCG-DEC-005b` decision** *(group-name uniqueness per community remains separately OPEN)* · ⛔ `LCG-GAP-009` · ⛔ `LCG-GAP-011` · ⛔ `LCG-GAP-012` · ⛔ `LCG-GAP-013` · ⛔ `LCG-GAP-014` · ⛔ `LCG-DEC-006` restoration clause · ⛔ any Stage 8 entry · ⛔ any implementation · ⛔ any criterion recorded as passing |
| **Deciding authority** | ⭐ **Product Owner**, single office — ⚠ **conferral PENDING (§8)**; ⛔ no joint form, no ARB quorum, no independent review claimed |
| **Origin** | `PRD-021A` A4 v0.2 **L685** `LCG-GAP-005` *(OPEN)* · **L342–344** `LCG-FR-005` *(BLOCKED, shape only)* · **L641–642** `LCG-NFR-004` *(DEFERRED)* · **L670** `LCG-AC-017` *(DEFERRED, no value)* · **L263–264** field table *(bounds deferred to `BC-25`)* |

> ⭐⭐ **Identifier check, performed immediately before drafting and again before writing.**
> `ADR-0172` is the highest ADR file present. **`ADR-0173` measured 0 files on disk and
> 0 references anywhere in `docs/`.** ⛔ No identifier is reused, reserved or
> renumbered.

---

## 1. ⭐ Question

> ⭐ **What are the bounds and caps for `BC-15`'s `Group.name`, `Group.description`,
> per-community group count and per-group active membership count?**

The question arises because A4 declares the **shape** of every one of these and
**defers all four values**:

| Source | Text *(minimum necessary)* |
|---|---|
| A4 **L263** `name` field | *"Mandatory. ⏸ Bounds deferred to `BC-25` — `LCG-GAP-005`"* |
| A4 **L264** `description` field | *"Optional. ⏸ Bounds deferred — `LCG-GAP-005`"* |
| A4 **L342–344** `LCG-FR-005` | *"⏸ **BLOCKED.** A per-community cap on group count SHALL be enforced. The **value** is a `BC-25` concern (`PRD-023`); this part declares the shape and assigns no number. → `LCG-GAP-005`."* |
| A4 **L641–642** `LCG-NFR-004` | *"⏸ **DEFERRED.** Group-count and membership-count scale bounds are `BC-25` values — `LCG-GAP-005`."* |
| A4 **L670** `LCG-AC-017` | *"⏸ **DEFERRED** — no value, `LCG-GAP-005`"* |
| A4 **L685** `LCG-GAP-005` register row | *"Name bounds, description bounds, group/membership caps · `BC-25` / `PRD-023` · ⛔ **OPEN**"* |

⚠ **No value, default, range or character rule exists in any Rank 1–5 document for
any of the four.** This ADR records the Product Owner's decisions on exactly those four
values and nothing more.

---

## 2. ⭐⭐ Evidence — measured, not asserted

### 2.1 The four deferred cells, unchanged

| # | Source | Measurement at baseline `6ebe0e6` |
|---|---|---|
| **1** | A4 **L263** | `name` — ⏸ boundless, deferred to `BC-25` |
| **2** | A4 **L264** | `description` — ⏸ boundless, deferred to `BC-25` |
| **3** | A4 **L342–344** `LCG-FR-005` | ⏸ **BLOCKED** — *"declares the shape and assigns no number"* |
| **4** | A4 **L641–642** `LCG-NFR-004` | ⏸ **DEFERRED** — *"scale bounds are `BC-25` values"* |

### 2.2 `PRD-023` owns the machinery, not the value list — its refusal is discharged, not overridden

| # | Source | Measurement |
|---|---|---|
| **5** | `PRD-023` **L81** | `CNF-CFG-*` register — **0 values, DECLARED EMPTY** |
| **6** | `PRD-023` **L122–129** | *"a configuration module that configures itself would be its own first defect"* — *"To publish a `CNF-CFG-*` value, this document would have to invent a default and a range for a parameter no document at any rank bounds"* |
| **7** | `PRD-023` **L126** | *"Every one of the 104 configurables measured in this repository belongs to one of eight other PRDs"* |

⭐ **This ADR's value decisions are precisely the bounding authority that measurement 6
was conditioned on.** Once a value exists at the domain level, `BC-25`'s `E-19`/`LCFG-*`
resolution machinery binds it **without amending `PRD-023`**. The refusal stands for
*inventing* values; it does not bar *recording* values a Product Owner decision supplies.

### 2.3 No existing Rank 1–5 document conflicts with the proposed values

| Proposed value | Conflict check | Result |
|---|---|---|
| `Group.name` = 50 code points, allow-list | A4 L263 (deferred, no bound) · `LCG-FR-005` L342–344 (shape only) · BC Map L119/§15.5 (no capacity invariant) · `LCG-INV-005` L450 (storage, not scale) | ✅ No conflict |
| `Group.description` = 500 code points, free text | A4 L264 (deferred, no bound) | ✅ No conflict |
| 100 groups per community | `LCG-FR-005` L342–344 (no number) · BC Map L119 (no cap) · §15.5 aggregates (no numeric cap) | ✅ No conflict |
| 50 active memberships per group | `LCG-NFR-004` L641–642 (deferred, no number) | ✅ No conflict |
| Platform-fixed V1 (not tenant-configurable) | `PRD-023` §3 L377 (five-scope hierarchy: platform default → tenant → library → branch → user) · `CNF-FR-020` L465 (*"A default SHALL NOT be storable as an override at scope 1"*) · `CNF-BR-009` L1000 (*"A tenant role SHALL NOT be capable of writing at scope 1"*) | ✅ Compatible — a platform-fixed value is a scope-1 platform default with no override, which is exactly what the existing hierarchy enforces |

### 2.4 Precedent: `PRD-021B` B7 §B7.16 L680

| `MSG-CFG-001` | Max message body length | platform default | bounded | `BC-25` via `E-19` |

⭐ **The same pattern applies here:** a domain document declares a bounded parameter,
`BC-25`'s `E-19` resolution binds it, and `PRD-023` is **not amended**.

### 2.5 `LCG-DEC-005b` (name uniqueness per community) is separately OPEN

A4 §32 L710 — `LCG-DEC-005b` *"Whether group names must be **unique per community**"*
remains **OPEN**, Product Owner. ⛔ **This ADR does NOT decide, advance or close it.**
The character-set decision is independent of the uniqueness question: a name can be
validated against an allow-list without deciding whether two groups in the same
community may share a name.

---

## 3. ⭐⭐ Decision — the five Product Owner value decisions

| # | Value | Decision |
|---|---|---|
| **1** | `Group.name` maximum length | **50 Unicode code points** — not UTF-8 bytes, not UTF-16 code units |
| **2** | `Group.name` allowed characters (allow-list, deny-by-default) | **Unicode category `L*`** (`Ll`, `Lu`, `Lt`, `Lm`, `Lo`) · **Unicode category `Nd`** (decimal digits) · **ASCII space `U+0020`** · **exactly these 7 punctuation characters: `-` `_` `.` `&` `'` `(` `)`** |
| **3** | `Group.name` validation rules | **Rejection-only allow-list:** any character outside the allow-list **SHALL cause validation rejection**. ⛔ **No stripping, no substitution, no normalization** — characters are neither silently removed, replaced, nor Unicode-normalised (NFC/NFD/NFKC/NFKD) before validation. The name **SHALL contain at least one** allowed character that is **not** `U+0020`. **Leading or trailing `U+0020` SHALL be rejected.** **Consecutive internal `U+0020` are permitted**; no internal-space run-length cap is imposed (no existing repository rule conflicts — measured §2.3) |
| **4** | `Group.description` maximum length | **500 Unicode code points.** ⛔ **Otherwise free text** — no allow-list applies to `description`; no character-set restriction beyond the length cap is imposed |
| **5** | Maximum `Group` count per `Community` | **100** |
| **6** | Maximum **`ACTIVE`** `GroupMembership` count per `Group` | **50** — counting memberships in state `ACTIVE` only; `REVOKED` memberships are not counted against the cap |

**V1 classification:** decisions 5 and 6 are **platform-fixed for V1** — a scope-1
platform default in `PRD-023`'s five-scope hierarchy. ⛔ **NOT tenant-configurable in
V1**: no tenant, library, branch or user override is authorised. ⛔ **No decision is
made about V2 or later.**

---

## 4. ⭐ Effect

⛔ **None while `PROPOSED`.** While this ADR is at `PROPOSED` status:

- `LCG-GAP-005` **remains OPEN** (A4 L685)
- `LCG-FR-005` **remains BLOCKED** (A4 L342–344)
- `LCG-NFR-004` **remains DEFERRED** (A4 L641–642)
- `LCG-AC-017` **remains DEFERRED** (A4 L670)
- A4 field table L263/L264 **remain deferred**
- `IMPL-1532`–`1537` **remain BLOCKED** on `LCG-GAP-005`/`009`/`013`
- No document is amended

**Upon `Accepted` status** (the A4 amendment act is a **separate** Product Owner act,
recorded in the same commit per `PRD_REGISTRY.md` §8 rule 3):

- A4 §3.1 L263/L264 field-table bounds are stated, citing this ADR
- A4 `LCG-FR-005` L342–344 unblocked with cap = 100
- A4 `LCG-NFR-004` L641–642 unblocked: group-count scale bound = 100; membership-count scale bound = 50
- A4 `LCG-AC-017` L670 → ✅ **WRITABLE** — *"Given the group cap (100) is reached, creation SHALL be rejected"* — ⚠ **NOT recorded as passing**
- A4 §31 `LCG-GAP-005` row L685 → ✅ **CLOSED** by this ADR
- `PRD_REGISTRY.md` §11.3 L745 open-gap count moves 6 → 5 (Governance Owner, same commit)
- `PRD-021A_IMPLEMENTATION_TASKS.md` L270–275/L357 blocker lists drop `LCG-GAP-005` (retaining `009`/`013`)

---

## 5. ⚠️ Unresolved conditions — ⛔ preserved, NOT resolved

| # | Condition | Owning office |
|---|---|---|
| **1** | ⭐ **The A4 in-place amendment** — recording the five values in A4's own §3.1/§5.1/§30/§31 cells, moving `LCG-GAP-005` to CLOSED · ⭐ **Product Owner** *(amendment act, separate from this ADR)* |
| **2** | ⭐ **`PRD_REGISTRY.md` §11.3 L745 open-gap count 6 → 5** · **Governance Owner** *(registry reconciliation, same commit as the A4 amendment)* |
| **3** | ⭐ **`PRD-021A_IMPLEMENTATION_TASKS.md` blocker-list reconciliation** · **Governance Owner** |
| **4** | ⭐ **`BC-25`/Architecture Owner confirmation** that `E-19`/`LCFG-*` resolution binds the published values without a `PRD-023` amendment (frozen bytes intact; `CNF-CFG-*` register stays 0) |
| **5** | ⛔ **`LCG-DEC-005b`** — group-name uniqueness per community — **separately OPEN**, Product Owner — **NOT decided by this ADR** |
| **6** | ⛔ **`LCG-GAP-009`** (erasure contract) · **`LCG-GAP-011`** · **`LCG-GAP-012`** · **`LCG-GAP-013`** (audit sink) · **`LCG-GAP-014`** — **all remain OPEN; not touched by this ADR** |
| **7** | ⛔ **`LCF-GAP-011`** (`integration_test/` absent) — Stage 8 item, not touched |
| **8** | ⛔ **Stage 8 NOT entered.** 0 of 70 `IMPL-*` tasks executed. 0 criteria proven. `READY`/`IMPLEMENTING`/`VERIFIED` refused |

---

## 6. ⭐ Authority and conferral boundary

| Field | Value |
|---|---|
| **Deciding authority** | ⭐ **Product Owner**, single office |
| **Conferral status** | ⚠ **PENDING** — the Product Owner one-act conferral is **NOT recorded here as performed** |
| ⛔ **No authority claimed** | ⛔ **No independent review claimed.** ⛔ Not Architecture Owner, Governance Owner, Security Owner, Privacy Owner, Design Documentation Owner, UX Architecture Owner, Technical Owner, or Founder/Product Authority for the **acceptance** act |
| ⛔ **Not self-accepted** | ⛔ This ADR is **PROPOSED**, deliberately not self-accepted — `ADR-INDEX` L72/`ADR-0035` precedent: *"PROPOSED, deliberately not self-accepted"* |
| ⛔ **Not reused** | ⛔ `ADR-0085`'s conferral *(spent on §2/§3)* · ⛔ `ADR-0172`'s conferral *(spent on `LCG-AC-014` positive path)* · ⛔ `ADR-0087`'s conferral *(spent on the Rank 3 baseline)* |
| ⭐ **Precedent** | ⭐ `ADR-0172` §8 — single-act Product Owner conferral, recorded verbatim in the ADR's own §8, reverts on completion |

---

## 7. ⛔ What this ADR does NOT do

- ⛔ **No `PRD-023` amendment.** `PRD-023` is FROZEN at Rank 3 (`BASELINE-2026-09-01-B`). Its `CNF-CFG-*` register remains **0**. Its bytes are **unchanged**. The values are absorbed through `BC-25`'s existing `E-19`/`LCFG-*` resolution machinery, not through a `CNF-CFG-*` row.
- ⛔ **No Stage 8 entry.** 0 of 70 `IMPL-*` tasks executed. 0 criteria proven.
- ⛔ **No implementation.** No file under `lib/`, `test/`, `tool/`, `packages/` or `web/` touched.
- ⛔ **No criterion recorded as passing.** `LCG-AC-017` moves to WRITABLE, not PASSING.
- ⛔ **No `LCG-DEC-005b` decision.** Group-name uniqueness per community remains separately OPEN.
- ⛔ **No closure of `LCG-GAP-009`/`011`/`012`/`013`/`014`.** These remain OPEN.
- ⛔ **No new roles, permissions, scopes, identifiers, events or architecture contracts.**
- ⛔ **No `BC-25` amendment.** No new edge. No baseline re-issue.
- ⛔ **No value for V2.** Decisions 5–6 are platform-fixed **for V1 only**.

---

## 8. ⭐⭐ Conferral — PENDING

| Field | Value |
|---|---|
| **Form** | ⭐ **SINGLE-ACT** conferral of the **Product Owner** office, from the human principal — **PENDING** |
| **Scope** | ⭐ *"only for the `LCG-GAP-005` value decisions"* — the five decisions in §3: `Group.name` max 50 code points + 7-character allow-list + rejection-only validation; `Group.description` max 500 code points, free text; 100 groups per community; 50 active memberships per group; items 5–6 platform-fixed V1, NOT tenant-configurable |
| ⛔ **Not claimed** | ⛔ No independent review claimed. ⛔ Not Architecture Owner, Governance Owner, Security Owner, Privacy Owner or any other office for the acceptance act |
| ⛔ **Not reused** | ⛔ `ADR-0085`'s conferral · ⛔ `ADR-0172`'s conferral · ⛔ `ADR-0087`'s conferral |
| ⭐ **Reversion** | ⭐ Reverts on completion of the conferral act. ⛔ **Amending A4 to record the values, registering this ADR in `ADR-INDEX`, or resolving any other `LCG-GAP-*` requires a NEW conferral or the competent office** |

### 8.1 ⭐ The required human conferral — PENDING, NOT RECORDED

> ⚠ **The following conferral text is REQUIRED from the human principal. It is PENDING.
> No conferral is recorded here as performed. The agent has not conferred, self-accepted
> or paraphrased this act. The human principal must provide the conferral text verbatim
> for it to be recorded in §8.1, at which point this ADR's status moves to `Accepted`
> in the same commit.**
>
> The required conferral must:
>
> 1. **Name the office**: *"I confer: the Product Owner office"*
> 2. **Name the scope**: *"for the single act of deciding the five `LCG-GAP-005` value
>    decisions in `PRD-021A` A4: (1) `Group.name` maximum 50 Unicode code points,
>    allow-list `L*`/`Nd`/`U+0020`/7 punctuation characters, rejection-only, no
>    normalization, min 1 non-space char, no leading/trailing spaces, consecutive
>    internal spaces permitted; (2) `Group.description` maximum 500 Unicode code points,
>    free text; (3) maximum 100 groups per community; (4) maximum 50 active memberships
>    per group; (5) items 3–4 platform-fixed V1, NOT tenant-configurable. `LCG-DEC-005b`
>    is NOT decided. No new roles, permissions, scopes, identifiers, events or
>    architecture contracts are created. `PRD-023` is not amended. Stage 8 is not
>    entered. No criterion is recorded as passing."*
> 3. **State the reversion**: *"This is a single Product Owner decision act. The conferral
>    reverts on completion. No independent review is claimed."*

⚠ **All three elements must be present in the human principal's verbatim text before
§8.1 can be completed and this ADR moved to `Accepted`.**

---

## 9. ⭐ Closure conditions for `LCG-GAP-005`

`LCG-GAP-005` is **CLOSED** when **all five** of the following are true — measured, not claimed:

1. **`ADR-0173` is `Accepted`** — the §8.1 conferral is recorded verbatim by the human principal and the ADR status is `Accepted` in the same commit
2. **A4 in-place amendment performed** (Product Owner, `PRD_LIFECYCLE.md` §5): §3.1 L263/L264 field-table bounds stated · `LCG-FR-005` L342–344 unblocked · `LCG-NFR-004` L641–642 unblocked · `LCG-AC-017` L670 → WRITABLE · §31 `LCG-GAP-005` row L685 → CLOSED, citing `ADR-0173`
3. **`PRD_REGISTRY.md` §11.3 L745** open-gap count 6 → 5, `LCG-GAP-005` removed from the open list (Governance Owner, same commit, §8 rule 3)
4. **`PRD-021A_IMPLEMENTATION_TASKS.md`** L270–275/L357 blocker lists drop `LCG-GAP-005` (retaining `009`/`013`)
5. **`PRD-023` byte-identity confirmed** — `git diff` of `docs/30-product/configuration/PRD-023_SETTINGS_AND_CONFIGURATION.md` returns **0 changed bytes**; `CNF-CFG-*` register remains **0**

⛔ **Closure does NOT:** move Stage 8 · confer `READY`/`IMPLEMENTING`/`VERIFIED` · write
any code · record any criterion as passing · close `LCG-GAP-009`/`011`/`012`/`013`/`014` ·
close `LCG-DEC-005b`

---

*This ADR is **PROPOSED**. It is not binding. `LCG-GAP-005` remains **OPEN**. No file
under `lib/`, `test/`, `tool/`, `packages/` or `web/` is touched. Stage 8 is NOT
entered. `PRD-023` is byte-unchanged. The §8.1 conferral is PENDING the human
principal's verbatim act.*
