# ADR-0157 — `SEAT-CFG-*` Seat Management configuration: `TR-1`-only tenant authorization for 15 parameters, with `SEAT-CFG-005`/`014` and `SEAT-CFG-017` HELD

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-19 |
| **Rank** | 2 — Architecture Decision Record |
| **Bounded context** | `BC-25` Configuration *(owning)*; `BC-07` Seat Management *(source)*; `BC-06` *(adjacent, `SE-3`)* |
| **Supersedes** | ⛔ **NOTHING.** |
| **Superseded by** | — |
| **Authority instrument** | ⭐⭐ **Four decisions**, verbatim at §2 — `SE-1` *(Product Owner + SECURITY PLATFORM)*, `SE-2` *(Authorization Owner)*, `SE-3` *(Product Owner + `BC-06` Owner)*, `SE-4` *(Architecture Owner)*. |
| **Decides** | ⭐ **15** of **18** `SEAT-CFG-*` |
| **Expressly does NOT decide** | ⛔ `SEAT-CFG-005` · ⛔ `SEAT-CFG-014` · ⛔ `SEAT-CFG-017` · ⛔ `ICFG-*` · ⛔ 7 held `ATT-CFG-*` · ⛔ `CFG-10`/`CFG-12` · ⛔ `SCFG-2`/`SCFG-4` · ⛔ `SMCFG-5` |

---

## 1. Context — ⭐⭐ the register is NOT homogeneous, and was NOT batched

⚠️⚠️ **`SEAT-CFG-*` IS THE FIRST REGISTER IN THIS CHAIN THAT SPLITS FOUR WAYS.**
⛔ Auditing it as one batch would have been wrong on **three** counts.

| Class | IDs | Count | Treatment |
|---|---|---|---|
| **A — routine tenant** | `001`, `002`, `003`, `004`, `006`, `007`, `008`, `009`, `010`, `011`, `012`, `013`, `015`, `016`, `018` | **15** | ⭐ **ALLOCATED** — §2.5 |
| ⛔ **B — authorization-semantic** | **`005`**, **`014`** | **2** | ⛔ **HELD** — §2.2 |
| ⛔ **C — not `BC-25`-owned, value unset** | **`017`** | **1** | ⛔ **HELD** — §2.3 |
| ⚠️ **D — scope caveat** | *(cross-cutting)* | — | ⚠️ **`SEAT-XC-022`** — §2.4a |

⭐ **15 + 2 + 1 = 18.** ⛔ **No parameter is unaccounted.**

⛔⛔ **NEITHER THE `SCFG` NOR THE `SMCFG` ROUTE WAS CARRIED ACROSS.** ⭐ `SCFG`
was `Platform default`; `SMCFG` was `Tenant` **with `TR-1` + `TR-2`**. ⛔ This
register is `Tenant` **with `TR-1` ONLY** — see §2.1a. ⭐ Every dimension —
scope, `READ`, `WRITE`, commercial — was established **independently**.

---

## 2. The decisions, recorded verbatim

### 2.1 ⭐⭐ `SE-1` — Product Owner + SECURITY PLATFORM

> For the 15 routine Class-A parameters:
> `SEAT-CFG-001`, `002`, `003`, `004`, `006`, `007`, `008`, `009`, `010`,
> `011`, `012`, `013`, `015`, `016`, `018`
>
> Explicitly allocate Tenant-scope `READ` and `WRITE` authority.
>
> `READ`/`WRITE` role allocation must follow authoritative frozen SEAT evidence.
>
> Important: `SEAT-PO-021` says configuration owned by `BC-25` is Owner-only
> (`TR-1`). Therefore:
>
> `TR-1` = ALLOW for the applicable `BC-25` configuration operation.
> `TR-2` = **EXCLUDED** unless authoritative evidence explicitly permits it.
>
> Do **NOT** copy the `SMCFG` `TR-1` + `TR-2` allocation.
>
> No `TR-4`/`TR-5` authority unless explicit frozen evidence exists.

#### 2.1a ⭐⭐ The `TR-2` exclusion was VERIFIED, ⛔ not accepted on trust

⭐ **`SEAT-PO-021`** *(`PRD-007` **L2005**, FROZEN)* — read column by column:

| Operation | **Owner** | **Manager** | **Reception** | **Student** |
|---|---|---|---|---|
| `SEAT-PO-021` — *"Change a module configurable owned by `BC-25` (§27)"* | ⭐ **Y** | ⛔ **—** | ⛔ **—** | ⛔ **—** |

⭐ Corroborated by **`SEAT-BR-039`** *(**L2018-2022**)*:

> *"Manager **MUST NOT** hold the **tenant-shaping** operations, which remain
> **Owner-only**: seat category definition (`SEAT-PO-019`), eligibility rules
> (`SEAT-PO-020`) and **configuration (`SEAT-PO-021`)**."*

⭐⭐ **`TR-2` IS THEREFORE EXCLUDED ON FROZEN EVIDENCE, ⛔ NOT MERELY BY
INSTRUCTION.** ⚠️⚠️ **This is a real divergence from `ADR-0156`**, where `TR-2`
held `WRITE` over `SMCFG-*`. ⭐ The difference is **sourced**: `PRD-004` carried
no equivalent Owner-only rule, whereas `PRD-007` states one in terms. ⛔ **The
`SMCFG` allocation was NOT copied.**

⛔ **`TR-4`/`TR-5`:** `SEAT-PO-021` marks both **—**, and no frozen text grants
either any configuration authority. ⛔ **No authority allocated.**

#### 2.1b ⭐⭐ `READ` was decided SEPARATELY, and is NARROWER than elsewhere

⚠️ **`PRD-007` defines no `READ` operation for configuration.** `SEAT-PO-024`
*(**L2008**)* covers *"the seat map, seat card, timeline and operational
metrics"* — ⛔ **not the configuration register**.

⭐ `READ` therefore rests on **`CNF-FR-081`** *(`PRD-023` **L1198**)*:

> *"A parameter the current actor may read but not write (`CNF-BR-010`)
> **SHALL** be presented as [read-only]"*

⭐ — the **same route** `ADR-0153` used for `TR-2`/`TR-3` on `ATT-CFG-*`.

⭐⭐ **BUT `CNF-FR-081` DOES NOT ITSELF GRANT A READ** — it prescribes how a read
**already held** must be *rendered*. ⛔ Since `PRD-007` grants **no** tenant
configuration read beyond the writer, ⭐ **`READ` is allocated to `TR-1` only**,
matching `WRITE`. ⛔ **`TR-2`/`TR-3` read is NOT allocated** — it would be
derivation, and `AUTH-7.24` forbids inferring one action from another.

### 2.2 ⭐⭐ `SE-2` — Authorization Owner

> `SEAT-CFG-005` and `SEAT-CFG-014` are authorization-semantic.
>
> Do **NOT** allocate them as ordinary configuration parameters.
>
> Decision: **HOLD** `SEAT-CFG-005` and `SEAT-CFG-014` pending explicit
> Authorization Owner determination, consistent with the `ATT-CFG-022`/`024`
> precedent.
>
> They must **NOT** be given role-capability authority by inference.

⭐ **VERIFIED — both parameters configure ROLE CAPABILITY itself:**

| ID | Frozen evidence |
|---|---|
| **`SEAT-CFG-005`** | **L1906** — *"**Override grant** — **which roles** beyond Owner may override a bounded staff limit"*, domain *"Subset of {Manager} added to Owner"* · **L2024** — *"Manager's lock override (`SEAT-PO-010`) is **conditional on `SEAT-CFG-005`**"* · `SEAT-PO-010` = **`C (SEAT-CFG-005)`** · `SEAT-AC-053` — *"only Owner may override by default"* |
| **`SEAT-CFG-014`** | **L1915** — *"Whether **Reception** may cancel another student's reservation"* · `SEAT-PO-007` = **`C (SEAT-CFG-014)`** · `SEAT-AC-080` — *"Denied"* where unset |

⭐⭐ **The `SEAT-PO-*` legend makes this explicit**: **`C`** = *"permitted **only
where the named configurable grants it**"*. ⛔ **A `C` cell is an authorization
conditional, not a preference** — these two parameters **are** the grant.

⭐ **Consistent with `ADR-0153`**, which held `ATT-CFG-022` and `ATT-CFG-024` for
the **Authorization Owner** on exactly this ground. ⛔ **HELD.**

### 2.3 ⭐⭐ `SE-3` — Product Owner + `BC-06` Owner

> `SEAT-CFG-017` is owned by `BC-06` through `E-05`, not `BC-25`.
>
> Its V1 value is explicitly UNSET and `SEAT-GAP-005` remains open.
>
> Decision: **HOLD `SEAT-CFG-017`.**
>
> Do not allocate it under `BC-25`.
> Do not invent a `BC-06` permission or role allocation.
> Do not substitute a value.

⭐ **VERIFIED on three independent grounds**, `PRD-007` §27.1 **L1918**:

1. ⛔ **Owner is `BC-06` via `E-05`** — ⭐ the **only** one of 18 not owned by `BC-25`.
2. ⛔ **Value explicitly unset** — *"**Unset in V1** — no event is emitted and **no value is substituted**"*; **L1935** adds *"a **proposed** addition to the `E-05` contract"*.
3. ⛔ **`SEAT-GAP-005` is OPEN.**

⭐⭐ ⛔ **The 90% figure MUST NOT be applied as a fallback** — §27.1 preamble
says so in terms. ⛔ **No value substituted. HELD.**

### 2.4 ⭐⭐ `SE-4` — Architecture Owner

> Explicitly confirm `WRITE` treatment for the Tenant-scoped `SEAT-CFG`
> parameters.
>
> Do **NOT** reuse `ADR-0151` §3.5 `N/A` because that precedent is
> Platform-Default-specific.
>
> Also confirm the `SEAT-XC-022` scope caveat:
> - Normal `BC-25` configuration = Tenant scope.
> - Where `BC-06` owns a parameter, branch scope may apply.
> - Do not convert branch scope to Tenant scope by inference.

⭐⭐ **DETERMINATION: AN EXPLICITLY AUTHORIZED TENANT-ROLE `WRITE` TO `TR-1`
ONLY** — ⛔ **NOT ⚪ `N/A`**, ⛔ **NOT blanket `DENY`**.

⛔⛔ **`ADR-0151` §3.5 IS NOT REUSED.** ⭐ Its ⚪ `N/A` rests on **`CNF-FR-020`**,
binding only **platform-default** values; ⛔ it **does not reach `Tenant`
scope**. ⭐ `SEAT-PO-021` **positively grants** Owner a change operation, so a
runtime write demonstrably **exists** — ⛔ `N/A` would be false.

#### 2.4a ⚠️⚠️ The `SEAT-XC-022` caveat — honoured, ⛔ not flattened

⭐ **`SEAT-XC-022`** *(**L1946**, FROZEN)*:

> *"Every configurable above is **tenant-scoped, or branch-scoped where `BC-06`
> owns it**."*

⭐⭐ **The caveat has exactly ONE referent, and it is `SEAT-CFG-017`** — the sole
`BC-06`-owned entry *(§2.3)*, ⛔ **which is HELD**. ⭐ Therefore **all 15
allocated parameters are `Tenant`**, and ⛔ **no branch scope is converted to
Tenant by inference** — ⭐ the one parameter that could raise the question is
**not allocated at all**.

### 2.5 ⭐⭐ The allocation — 15 parameters

⭐ **Scope = `Tenant`** · **`WRITE` = `TR-1` ✅ only** · **`READ` = `TR-1` ✅
only** · **`NOT COMMERCIAL`** · Legend per `ADR-0151`.

| # | ID | Parameter | Default | `TR-1` W | `TR-2` W | `TR-3` W | `TR-1` R | `TR-2`/`TR-3` R | Source |
|---|---|---|---|---|---|---|---|---|---|
| 1 | `SEAT-CFG-001` | Tenant label for `Zone` | `"Zone"` | ✅ | ⛔ | ⛔ | ✅ | ⛔ **not allocated** | §27.1 · `SEAT-FR-014` |
| 2 | `SEAT-CFG-002` | Effective `seatQuota` when `E-02` omits it | 1 | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-FR-049` |
| 3 | `SEAT-CFG-003` | Whether `Inactive` blocks acquisition | blocks | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-BR-013` |
| 4 | `SEAT-CFG-004` | Release reason list | Empty list | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-FR-060` |
| 5 | `SEAT-CFG-006` | Max concurrent `Pending` seat-change requests | 1 | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-FR-074` |
| 6 | `SEAT-CFG-007` | Decision deadline for `Pending` expiry | 7 days | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 |
| 7 | `SEAT-CFG-008` | Student self-booking enabled | disabled | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-FR-076` |
| 8 | `SEAT-CFG-009` | Behaviour when window exceeds `validUntil` | `reject` | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-FR-081` |
| 9 | `SEAT-CFG-010` | Booking mode | `ApprovalRequired` | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-FR-086` |
| 10 | `SEAT-CFG-011` | Reservation → allocation trigger | `OnCheckIn` | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-FR-089` |
| 11 | `SEAT-CFG-012` | No-show count suspending self-booking | 3 | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-FR-096` |
| 12 | `SEAT-CFG-013` | Self-booking suspension duration | 7 days | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-FR-096` |
| 13 | `SEAT-CFG-015` | Default reservation hold duration | 30 minutes | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-FR-120` |
| 14 | `SEAT-CFG-016` | Max concurrent active reservations | 1 | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-FR-121` |
| 15 | `SEAT-CFG-018` | *Expiring soon* filter horizon | 7 days | ✅ | ⛔ | ⛔ | ✅ | ⛔ | §27.1 · `SEAT-FR-258` |
| — | ⛔ `SEAT-CFG-005` | **Override grant** | Owner only | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | §2.2 · `SE-2` |
| — | ⛔ `SEAT-CFG-014` | Reception may cancel reservation | not granted | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | §2.2 · `SE-2` |
| — | ⛔ `SEAT-CFG-017` | Occupancy % emitting `SEAT-EVT-004` | ⚠️ **unset** | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | §2.3 · `SE-3` |

⭐ **15 allocated · ⛔ 3 HELD · 18 accounted for.**

### 2.6 ⭐⭐ `NOT COMMERCIAL` — the strongest evidence in any register so far

⭐ **`SEAT-FR-279`** *(FROZEN, **L2057**)*:

> *"The module **MUST NOT** display or store **any monetary value**: no fee,
> price, plan amount, due…"*

⭐ Reinforced by **`SEAT-FR-144`** *("A category **MUST NOT** carry a price, a fee
or any monetary amount")*, **`SEAT-XC-011`** *("A 'collect payment' affordance
**MUST NOT** exist on any seat screen")* and **L224** *(`BC-05` edge: *"**None.**
No edge exists"*)*.

⭐⭐ **`NOT COMMERCIAL` is not merely satisfied here — it is MANDATED.** ⛔ A
commercial `SEAT-CFG-*` would breach a frozen `MUST NOT`.

---

## 3. Invariants checked

| # | Invariant | Source | Held? |
|---|---|---|---|
| 1 | Permission catalogue closed at zero | `AUTH-7.22` | ⭐ **YES** — **0** `PERM-*` |
| 2 | Library role register closed at five | `AUTH` ch.07 **L87** | ⭐ **YES** — only `TR-1` allocated |
| 3 | Platform register untouched | `AUTH` ch.07 **L79** | ⭐ **YES** — ⛔ **0** `PR-n` authority |
| 4 | `READ`/`WRITE` decided independently | `CNF-BR-010` | ⭐ **YES** — §2.1a and §2.1b are separate acts |
| 5 | `READ` implies no other action | `AUTH-7.24` | ⭐ **YES** — ⛔ `TR-2`/`TR-3` read **not** inferred |
| 6 | No role hierarchy | `AUTH-7.28` | ⭐ **YES** |
| 7 | Scope sourced | `SEAT-XC-022` | ⭐ **YES** — §2.4a |
| 8 | ⛔ Platform-default `N/A` **NOT** reused | `SE-4` | ⭐ **YES** — §2.4 |
| 9 | ⛔ Branch scope **not** flattened | `SEAT-XC-022` | ⭐ **YES** — its sole referent is **HELD** |
| 10 | ⛔ `SMCFG` allocation **not** copied | `SE-1` | ⭐ **YES** — `TR-2` excluded on `SEAT-PO-021` |
| 11 | Frozen `PRD-007` unmodified | `ADR-INDEX` | ⭐ **YES** — md5 `03a8ba0a…` |
| 12 | ⛔ Authorization-semantic **not** allocated | `SE-2`; `ADR-0153` precedent | ⭐ **YES** |
| 13 | ⛔ No value substituted for an unset parameter | `SE-3`; §27.1 | ⭐ **YES** — ⛔ 90% **not** applied |
| 14 | ⛔ Nothing superseded | `ADR-INDEX` step 3 | ⭐ **YES** |
| 15 | ⛔ Inventory unchanged | standing instruction | ⭐ **YES** — **104** |

---

## 4. Decisions — `D-1` … `D-9`

| ID | Decision |
|---|---|
| **`D-1`** | ⭐ **15** parameters allocated at **`Tenant`**: **`WRITE` = `TR-1` ✅ ONLY**; ⛔ `TR-2`, `TR-3`, `TR-4`, `TR-5` **DENY**. |
| **`D-2`** | ⭐ **`READ` = `TR-1` ✅ ONLY** — ⛔ `TR-2`/`TR-3` read is **NOT allocated**; `CNF-FR-081` prescribes *rendering*, ⛔ it does not *grant* (§2.1b). |
| **`D-3`** | ⭐ **`TR-2` EXCLUDED on frozen evidence** — `SEAT-PO-021` **—**, `SEAT-BR-039` *"Owner-only"*. ⛔ **The `ADR-0156` `TR-1`+`TR-2` allocation was NOT copied.** |
| **`D-4`** | ⭐ **`NOT COMMERCIAL`** — **mandated** by `SEAT-FR-279` (§2.6). |
| **`D-5`** | ⭐ **`WRITE` is a real tenant write**, ⛔ not ⚪ `N/A`, ⛔ not blanket `DENY`; ⛔ `ADR-0151` §3.5 **expressly not reused** (`SE-4`). |
| **`D-6`** | ⛔ **`SEAT-CFG-005` and `SEAT-CFG-014` are HELD** — **authorization-semantic** (`C` cells in `SEAT-PO-007`/`010`); **Authorization Owner**, per the `ATT-CFG-022`/`024` precedent. |
| **`D-7`** | ⛔ **`SEAT-CFG-017` is HELD** — `BC-06`-owned, value **unset**, `SEAT-GAP-005` open; ⛔ **no value substituted**, ⛔ no `BC-06` role invented. |
| **`D-8`** | ⚠️ **`SEAT-XC-022`'s branch-scope caveat is preserved** — its **sole** referent `SEAT-CFG-017` is **HELD**; ⛔ **no branch scope converted to `Tenant`**. |
| **`D-9`** | ⭐ Coverage **64 / 104 → 79 / 104**; ⛔ **25** remain. ⚠️⚠️ **AUTHORIZED ≠ DESIGNED.** |

---

## 5. ⛔ What this ADR does NOT decide

⛔ **`SEAT-CFG-005`/`014`** — **Authorization Owner**.
⛔ **`SEAT-CFG-017`** — **Product Owner** + **`BC-06` Owner**; `SEAT-GAP-005`.
⛔ **`TR-2`/`TR-3` READ over `SEAT-CFG-*`** — ⛔ a distinct question, ⛔ **not reached**.
⛔ **Any `PR-1`/`PR-2` authority over tenant configuration.**
⛔ **`ICFG-1`…`10`** · ⛔ **7 `ATT-CFG-*`** · ⛔ **`CFG-10`/`CFG-12`** · ⛔ **`SCFG-2`/`SCFG-4`** · ⛔ **`SMCFG-5`**.
⛔ **The 104 inventory** — ⛔ **unchanged**.
⛔ **`DD-0007` design-readiness** — ⛔ **D3 stays `PARTIAL`**.

---

## 6. Consequences for `DD-0007`

⭐ Coverage **64 → 79 / 104** *(**76.0%**)*. ⭐ `AUTHORIZED` band **41 → 56**;
⛔ `PLATFORM DEFAULT` unchanged at **23**.

⛔ **25 remain**: **10** `ICFG` + **7** `ATT-CFG` + **3** `SEAT-CFG` + **2**
`CFG` + **2** `SCFG` + **1** `SMCFG` = **25**. ⭐ **79 + 25 = 104.**

⚠️ **D5 UNAFFECTED** — **APP 2** tenant parameters; ⛔ no app, no cross-app edge.
⭐ **D4 gains 15 at `Tenant`.**

⛔⛔ **`DD-0007` DOES NOT BECOME DESIGN-READY.**

---

## 7. Obligations — `O-1` … `O-6`

| ID | Obligation | Owner |
|---|---|---|
| **`O-1`** | Determine **`SEAT-CFG-005`** and **`SEAT-CFG-014`** — with `ATT-CFG-022`/`024` as one authorization question | **Authorization Owner** |
| **`O-2`** | Resolve **`SEAT-GAP-005`** / the `E-05` contract, then **`SEAT-CFG-017`** | **Product Owner** + **`BC-06` Owner** |
| **`O-3`** | Decide whether `TR-2`/`TR-3` hold **READ** over `SEAT-CFG-*` | **Product Owner** + **SECURITY PLATFORM** |
| **`O-4`** | Decide **`ICFG-1`…`10`** — ⛔ never batched | **Product Owner** + **SECURITY PLATFORM** |
| **`O-5`** | Design the tenant configuration surface — ⛔ authorization is not design | **Design Owner** |
| **`O-6`** | Correct **`G-5`** in `ADR-0151` §1 | **Architecture Owner** |

---

## 8. Changelog

| Version | Date | Change |
|---|---|---|
| ⭐⭐ **1.0** | 2026-09-19 | ⭐⭐ **ACCEPTED.** ⭐ **15** `SEAT-CFG-*` allocated at **`Tenant`** — **`WRITE` = `TR-1` ONLY**, **`READ` = `TR-1` ONLY**, **`NOT COMMERCIAL`** *(mandated by `SEAT-FR-279`)*. ⭐⭐ **`TR-2` EXCLUDED on frozen evidence** — `SEAT-PO-021` **—**, `SEAT-BR-039` *"Owner-only"*; ⛔ **the `ADR-0156` `TR-1`+`TR-2` allocation was NOT copied**. ⛔⛔ **3 HELD** — **`005`**/**`014`** *(authorization-semantic, `C` cells; **Authorization Owner**, `ATT-CFG-022`/`024` precedent)* and **`017`** *(`BC-06`-owned, **unset**, `SEAT-GAP-005` open; ⛔ **90% NOT substituted**)*. ⛔ `ADR-0151` §3.5 ⚪`N/A` **not reused**. ⚠️ `SEAT-XC-022` branch caveat **preserved** — its sole referent is HELD. ⭐ Coverage **64 → 79 / 104**. ⛔ Supersedes **nothing**. ⛔ **0** `PERM-*` · **0** roles/actions/scopes · **0** frozen edits · **0** runtime code. ⛔ **D3 still `PARTIAL`.** |
