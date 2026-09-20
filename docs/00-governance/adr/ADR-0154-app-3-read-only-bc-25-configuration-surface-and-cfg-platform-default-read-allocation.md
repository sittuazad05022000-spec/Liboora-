# ADR-0154 — **APP 3 may hold a READ-ONLY `BC-25` configuration surface**, and the ten resolvable `CFG-*` platform-default parameters receive a **READ allocation** to `PR-1` and `PR-2`

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-19 |
| **Date** | 2026-09-19 |
| **Deciders** | ⭐⭐ **Architecture Owner + SECURITY PLATFORM**, **jointly**, for the `ADR-0152` boundary supersession (**B1**) — ⭐ the *same pairing that decided `ADR-0152`* · ⭐ **SECURITY PLATFORM** for the `PR-2` data classification (**B2**) · ⭐ **Authorization (`BC-18` / `PRD-001`) Owner** for the `AP-2` sequencing determination (**B3**) · ⭐ **Product Owner** for the `READ` and commercial allocation. ⛔ Each under a **one-act conferral** of the human principal of this engagement, **reverting on completion** (`ADR-0033` §7.1: *"a conferral for one act is not a standing licence"*). ⚠️ **All offices exercised by one principal** — ⛔ **no independent review, ARB quorum or external Security audit is claimed** |
| **Authority instrument** | ⭐⭐ **Four decisions, each recorded verbatim below and each obtained *before* this ADR was written**: **B1** (§2.1) the narrow partial supersession · **B2** (§2.2) the `PR-2` classification · **B3** (§2.3) the `AP-2` sequencing · **PO** (§2.4) the `READ` + commercial allocation. ⛔ **No conferral is inferred, and no standalone conferral artifact is created** — the `ADR-0150` / `ADR-0151` / `ADR-0153` precedent |
| **Supersedes** | ⭐⭐ **[`ADR-0152`](./ADR-0152-secp-hro-005-is-a-governance-act-not-an-app-3-runtime-configuration-surface.md) §7 *(the "surface" limb ONLY)* and §8.5 — IN PART and IN EFFECT ONLY**, on the **`ADR-0130`** instrument (§4). ⛔⛔ **`ADR-0152` is byte-unchanged** (md5 `7fc60c7ff06a8fb6e47c17d88dec9071`) ⛔ **and remains `Accepted`** |
| **Successor to** | ⭐ **[`ADR-0151`](./ADR-0151-bc-25-configuration-authorization-allocation.md)** *(22)* and **[`ADR-0153`](./ADR-0153-att-cfg-attendance-configuration-authorization-allocation.md)** *(17)* — ⛔ **neither is amended, reopened or superseded.** `ADR-0151` §7: *"Each needs the same act, by the same route."* ⭐ **This is that act, for 10 more** |
| **Amends** | ⭐ **`DD-0007`** *(Unranked Design Doc — a **separate follow-up**, the `ADR-0152-F-1` precedent)* · ⭐ **this register's `ADR-INDEX`**. ⛔ **No Rank 1–5 document is amended.** ⛔ `PRD-001`, `PRD-023`, `PRD-012a` and every frozen PRD are **byte-unchanged** |
| **Baseline** | ⛔ **No baseline re-issue.** No Rank 1–3 document changes version (`DOCUMENTATION_BASELINE.md` §7 **rule 4**) |
| **Closes** | ⭐ **`DD-0007` Declaration 3 for 10 further parameters** — coverage **39 → 49 of 104** |
| **Does NOT close** | ⛔⛔ **`DD-0007` Declaration 3 as a whole — 55 of 104 remain unallocated** (§8) · ⛔ **`CFG-10`** and **`CFG-12`**, expressly **HELD** (§6) · ⛔ the **7** held `ATT-CFG-*` (`ADR-0153` §5) · ⛔ **`ICFG-1`…`10`** — ⭐ **expressly NOT batched with this decision** (§7) · ⛔ `CNF-GAP-001`…`008` · ⛔ `CNF-D-1`, `CNF-D-2`, `CNF-D-3` · ⛔ `DD7-GAP-003`, `DD7-GAP-013` · ⛔ `G-5` · ⛔ **APP 3 runtime implementation** (§5.4) |
| **Related** | `ADR-0130` *(the partial-supersession instrument this ADR reuses)* · `ADR-0136`, `ADR-0137`, `ADR-0138` *(the "IN PART and IN EFFECT ONLY" precedent chain)* · `ADR-0151`, `ADR-0153` *(preserved byte-unchanged)* · `ADR-0132` *(`AUTH-7.22` audited at zero)* · `ADR-0043` *("do not invent a new permission ID")* · `ADR-0017` *(`BC-25` ownership)* · `ADR-0053` *(`PRD-023` v0.1 baseline)* |

> ⭐⭐ **`AUTH-7.22` REMAINS CLOSED AT ZERO ENUMERATED PERMISSIONS.** ⛔ This ADR mints **no** permission
> identifier, **no** `PERM-*` token, **no** action class, **no** scope class, **no** role, **no** event, **no**
> aggregate, **no** BC Map row, **no** edge, **no** configuration identifier, and **no** entry in any `CNF-*`,
> `CFG-*` or other register.
> ⛔ **`ADR-0132` is NOT reopened, amended or superseded, and NONE of its §7 prerequisites is engaged.**

---

## 1. Context

### 1.1 ⭐ The deadlock this ADR resolves

`DD-0007` records **39 of 104** `BC-25` configuration parameters as authorized. Of the remaining **65**, the
**twelve `CFG-*` authentication parameters** were measured *(the `DD-0007` Phase 1 audit)* as the most tractable
subset: **two** of their four authorization dimensions are already settled by frozen text.

| Dimension | Status before this ADR | Frozen authority |
|---|---|---|
| **WRITE** | ⭐ **SETTLED — no actor, no scope, ever** | `CNF-FR-020`, `CNF-AC-011`, `CNF-FR-028`, `BR-3.15` |
| **Scope** | ⭐ **SETTLED — Platform Default (scope 1)** | `PRD-023` **L316**, `CNF-FR-028`, `CONFIGURATION_GUIDE` §4 |
| **READ** | ⛔ **OPEN** — measured **0** statements | — |
| **Commercial** | ⛔ **OPEN** — measured **0** statements | — |

⭐ So only **two** dimensions needed a decision. ⚠️⚠️ **But the `READ` decision named `PR-1` and `PR-2`**, and
that collided with an `Accepted` Rank 2 ADR.

### 1.2 ⛔⛔ The collision, stated exactly

`PR-1` and `PR-2` are **APP 3** roles (`docs/35-design/README.md` §2B.1). A `READ` grant is only meaningful if
it is *rendered somewhere*. And `Accepted` `ADR-0152` §8.5 records:

> | **APP 3 — Platform Admin** | ⛔ **0 configuration surfaces** | ⭐⭐ **This ADR §7** |

⭐⭐ **The allocation could not lawfully be made until that boundary was addressed.** ⛔ It was **not** worked
around, ⛔ not reinterpreted, and ⛔ not quietly ignored. Four governance gates were opened, each measured for
existing evidence, and **each answered by its proper authority before this ADR was written**.

### 1.3 ⭐ The four gates, and how each was disposed

| Gate | Question | Disposition |
|---|---|---|
| **B1** | May `ADR-0152` §7/§8.5 be narrowly superseded to permit a **read-only** APP 3 surface? | ⭐ **APPROVED** — Architecture Owner + SECURITY PLATFORM (§2.1) |
| **B2** | Are `CFG-1`…`9`, `11` *"non-sensitive operational metadata"* for `PR-2`? | ⭐ **ALLOW** — SECURITY PLATFORM (§2.2) |
| **B3** | May `READ` be allocated **before** APP 3 runtime exists (`AP-2`/`AUTH-7.5`)? | ⭐ **ALLOW** — Authorization (`BC-18`) Owner (§2.3) |
| **B4** | Are partial-supersession mechanics defined? | ⭐⭐ **RESOLVED BY MEASUREMENT — no approval needed** (§4) |

⚠️⚠️ **`B4` was initially reported by this work-chain as *"no precedent — first ever"*. That was WRONG, and the
correction is recorded here rather than buried** — see §4.1.

---

## 2. The decisions, verbatim

### 2.1 ⭐⭐ **B1** — Architecture Owner + SECURITY PLATFORM, verbatim

> *"**B1 APPROVED.** Architecture Owner + SECURITY PLATFORM jointly APPROVE the narrow partial supersession
> described below.
>
> 1. `ADR-0152` §7 — **ONLY the "surface" limb** is superseded IN PART and IN EFFECT ONLY, following the
>    established `ADR-0130` precedent.
> 2. `ADR-0152` §8.5 is superseded **only to the extent necessary** to permit a READ-ONLY `BC-25` configuration
>    surface in APP 3.
> 3. APP 3 may expose **READ-ONLY** `BC-25` configuration information.
> 4. **§7 limb 3 remains fully in force: NO runtime write path to Scope 1 exists or may be built.**
> 5. No APP 3 write API, editable configuration control, override store, tenant override, or runtime mutation
>    path is authorized.
> 6. `ADR-0152` itself must remain **byte-unchanged and Accepted**.
> 7. `ADR-0152` §7 limbs 1, 2 and 4 and §8.1–§8.4 remain unchanged.
> 8. **No tenant-role authority changes.** `ADR-0151` and `ADR-0153` remain untouched.
> 9. No new role, action class, scope class, or `PERM-*` identifier.
> 10. **`CFG-10` and `CFG-12` remain HELD.**
> 11. **APP 3 runtime implementation is NOT authorized by this approval.**
> 12. `DD-0007` D5 must be re-evaluated as a **positive, explicitly declared cross-app dependency** during its
>     later amendment."*

### 2.2 ⭐ **B2** — SECURITY PLATFORM, verbatim

> *"**DECISION: ALLOW PR-2 READ.** Security Platform determines that `CFG-1`…`CFG-9` and `CFG-11` are classified
> as **NON-SENSITIVE OPERATIONAL METADATA** for `PR-2` Platform Support READ access.
>
> Therefore: `PR-2` READ = ALLOW · `PR-1` READ = ALLOW/in scope · **READ only** · No WRITE authority · No tenant
> override · **No access to authentication factors or session secrets** · No new role/action/scope/`PERM`
> identifier · **`CFG-10` and `CFG-12` remain HELD.**
>
> For the later `ICFG` audit, **do NOT automatically apply this decision** unless the governance evidence permits
> batching them. Treat `ICFG` separately and require the appropriate decision/evidence."*

⭐⭐ **This decision supplies what was measured as absent.** *"Non-sensitive operational metadata"* is `PR-2`'s
frozen scope ceiling (`PRD-001` §2.3) and had **4** occurrences repository-wide — ⛔ **all four being the ceiling
itself restated**, with **0 definitions** and **0 classification scheme**. ⭐ The classification of these ten
parameters against that ceiling was therefore a **determination**, ⛔ never a derivation.

### 2.3 ⭐ **B3** — Authorization (`BC-18`) Owner, verbatim

> *"**DECISION: ALLOW.** Under `AP-2` / `AUTH-7.5`, the approved READ-ONLY APP3 `BC-25` surface may receive its
> READ authorization allocation **before** the APP3 runtime implementation exists.
>
> Conditions: READ authorization only · No WRITE authority · No runtime mutation path · No tenant override ·
> **Authorization allocation does not itself authorize APP3 implementation** · Runtime implementation remains
> separately governed."*

### 2.4 ⭐ **Product Owner** — the allocation, verbatim

> *"`CFG-1` … `CFG-9`, `CFG-11` | READ: `PR-1` + `PR-2` | Commercial: **NOT COMMERCIAL**"*
> *"`CFG-5` and `CFG-6` each remain **ONE inventory parameter**. The same READ decision applies to both mobile
> and staff value limbs. **Do not create new parameter IDs.**"*
> *"`CFG-8` = **NOT COMMERCIAL**."*
> *"**HELD:** `CFG-10` and `CFG-12` remain NOT AUTHORIZED. Do not allocate READ, WRITE, Commercial, or any other
> authority to them."*

### 2.5 ⭐⭐ The complete allocation — every parameter, every role, every action, every scope

⭐ **Scope class used: `Platform default`.** ⛔ It pre-exists at `PRD-023` §3.1 `CNF-FR-009`; ⛔ **no scope class
is created**.

| # | Parameter | Scope | Commercial | `PR-1` R | `PR-2` R | `TR-1`/`TR-2`/`TR-3` R | Any W | Source |
|---|---|---|---|:--:|:--:|:--:|:--:|---|
| 1 | `CFG-1` OTP requests per mobile number / hour | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ⚪ **N/A** | Guide §2 **L78** |
| 2 | `CFG-2` Min interval between OTP requests | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ⚪ **N/A** | Guide §2 **L99** |
| 3 | `CFG-3` OTP requests per network origin / hour | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ⚪ **N/A** | Guide §2 **L121** |
| 4 | `CFG-4` Temporary lock after quota exhaustion | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ⚪ **N/A** | Guide §2 **L152** |
| 5 | `CFG-5` Idle session timeout *(mobile + staff limbs)* | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ⚪ **N/A** | Guide §2 **L174** |
| 6 | `CFG-6` Absolute session lifetime *(mobile + staff limbs)* | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ⚪ **N/A** | Guide §2 **L199** |
| 7 | `CFG-7` Trusted-device trust lifetime | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ⚪ **N/A** | Guide §2 **L223** |
| 8 | `CFG-8` Max concurrent registered devices | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ⚪ **N/A** | Guide §2 **L244** |
| 9 | `CFG-9` Pending-verification retention | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ⚪ **N/A** | Guide §2 **L262** |
| 10 | `CFG-11` Account-claim failures before lock | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ⚪ **N/A** | Guide §2 **L301** |
| — | ⛔ **`CFG-10`** Soft-deleted account retention | ⛔ **HELD** | ⛔ **HELD** | ⛔ | ⛔ | ⛔ | ⚪ **N/A** | §6 |
| — | ⛔ **`CFG-12`** Platform Support elevated-access duration | ⛔ **HELD** | ⛔ **HELD** | ⛔ | ⛔ | ⛔ | ⚪ **N/A** | §6 |

⭐ **Totals verified mechanically: 10 allocated · 2 held · 12 total.** ⭐ `Platform default` **10** · NOT
COMMERCIAL **10** · `PR-1` READ ALLOW **10** · `PR-2` READ ALLOW **10** · tenant-role READ **0** · **WRITE ⚪ N/A
on all 12**.

### 2.6 ⭐⭐ Why every WRITE cell is ⚪ **N/A** and not ⛔ DENY

⭐ This follows the **`ADR-0151` §3.5** precedent exactly. `CNF-FR-020` makes scope 1 *"**SHALL NOT** be writable
at runtime by any actor, **including a platform role**"*. ⛔ There is therefore **no write decision to take** —
⭐ writing ⛔ DENY would imply a decision was made where the frozen model leaves no room for one.

⭐ **This applies to `PR-1` and `PR-2` exactly as it applies to `TR-1`.** ⛔ The B1 approval's limb 4 states the
same prohibition from the other direction, and both are recorded.

### 2.7 ⭐ `CFG-5` and `CFG-6` remain ONE parameter each

⚠️ Both carry **two value limbs** — `CFG-5` = *30 days (mobile) · 30 minutes (staff)*; `CFG-6` = *90 days
(mobile) · 12 hours (staff)*. ⚠️ `CONFIGURATION_GUIDE` §4's environment table lists them on **separate rows**
(`CFG-5 mobile`, `CFG-5 staff`), which could invite splitting them.

⛔⛔ **They are NOT split.** The Product Owner decision states *"each remain ONE inventory parameter… **Do not
create new parameter IDs**"*, and `PRD-023` §3.6 counts **`CFG-1`…`CFG-12` = 12**. ⭐ **The inventory stays at
104.** ⭐ One allocation row covers both limbs.

---

## 3. Authorization treatment

### 3.1 ⭐ Every invariant re-verified against this allocation

| # | Invariant | Source | Verified |
|---|---|---|---|
| 1 | Permission catalogue stays closed at zero | `AUTH-7.22`, `ADR-0132` | ⭐ **YES** — **0** `PERM-*` minted; only the **withdrawn** `A1-PERM-PARTICIPATE` exists repo-wide |
| 2 | Roles are a closed set | `PRD-001` §2.3, §2.4; `SECP-FR-003` | ⭐ **YES** — `PR-1`, `PR-2` cited; ⛔ **0** created |
| 3 | Platform and tenant namespaces stay distinct | `PRD-001` Role Separation; `SECP-FR-014` | ⭐ **YES** — ⛔ no merged role; `PR-1`/`PR-2` allocated **separately** from `TR-n` |
| 4 | Every grant carries a scope | `AUTH-7.26` | ⭐ **YES** — every row carries `Platform default` |
| 5 | Read granted independently of every other action | `AUTH-7.24` | ⭐ **YES** — **READ only**; ⛔ no Create/Update/Delete/Approve/Export |
| 6 | Read is not inferred from write | `CNF-BR-010` | ⭐ **YES** — ⛔ WRITE is ⚪ N/A for all actors; READ was **decided**, not derived |
| 7 | No permission hierarchy | `AUTH-7.28` | ⭐ **YES** — `PR-1` and `PR-2` each granted **by name**, ⛔ neither inherits from the other |
| 8 | No derivation from role naming or seniority | `AP-4` / `AUTH-7.7` | ⭐ **YES** — the grant rests on **B2**, ⛔ not on *"Platform Administrator sounds senior"* |
| 9 | Deny by default | `AP-3` | ⭐ **YES** — `TR-1`…`TR-5` receive **nothing**; ⛔ silence is not a grant |
| 10 | Scope 1 not writable by any actor, including a platform role | `CNF-FR-020`, `CNF-AC-011` | ⭐ **YES** — **12 of 12** WRITE cells ⚪ N/A |
| 11 | No override storable where not tenant-settable | `CNF-FR-028` | ⭐ **YES** — ⛔ no tenant override authorized |
| 12 | Platform roles confer no tenant business data access | `AUTH-2.5`, `AUTH-7.13`, `AUTH-7.61` | ⭐ **YES** — see §3.2 |
| 13 | Tenant may not configure authentication | `BR-3.15` (`PRD-001` **L1048**) | ⭐ **YES** — ⛔ no tenant role receives anything |
| 14 | `PR-2` cannot reach factors or session secrets | `PRD-001` §2.3; `SECP` L165 | ⭐ **YES** — see §3.3 |

### 3.2 ⭐⭐ Why `AUTH-2.5` is not engaged — `CFG-*` are platform-level objects

> `AUTH-2.5` — *"Platform roles **MUST NOT** grant access to tenant business data."*

| Test | Finding |
|---|---|
| Owning PRD | `PRD-001` Authentication / `BC-18` — ⛔ not a tenant-owned register |
| Resolution scope | **Platform default (scope 1)** — `PRD-023` **L316**: *"`CFG-1`…`CFG-12` appear in the environment-profile table and are **not** Settings — **no library sets its own OTP quota**"* |
| Tenant override storable? | ⛔ **No** — `CNF-FR-028` |
| `PR-1` scope text | *"platform-level objects only — tenants as entities, **platform configuration**, platform role assignments"* (`PRD-001` §2.3) |

⭐⭐ **A `CFG-*` value is a platform-level object, not tenant business data.** ⭐ `AUTH-2.5`, `AUTH-7.13` and
`AUTH-7.61` are therefore **not engaged** — ⛔ and this is verified rather than asserted, because the same
conclusion would be wrong for a tenant-scoped register such as `ATT-CFG-*`.

### 3.3 ⭐ What `PR-2` reads, and what it still cannot

⭐ The **B2** decision is bounded, and the bound matters:

| `PR-2` may read | ⛔ `PR-2` still cannot |
|---|---|
| ⭐ The **configured threshold** — *"the OTP quota is 5 per hour"* | ⛔ **Authentication factors** — any OTP code, any Google token |
| ⭐ The **lockout duration** — *"30 minutes"* | ⛔ **Session secrets** — any token or session identifier |
| ⭐ The **session lifetime ceiling** | ⛔ Any **tenant business data** without elevation (`AUTH-2.5`) |
| ⭐ The **device limit** | ⛔ Any **write** to any scope (`CNF-FR-020`) |

⭐⭐ **The distinction is between a *policy value* and the *data the policy protects*.** ⭐ `PRD-001` §2.3's
`PR-2` prohibition names *"authentication **factors** or session **secrets**"* — ⛔ it does not name thresholds.
⭐ B2 determined the thresholds are non-sensitive operational metadata; ⛔ it changed nothing about factors.

### 3.4 ⭐ Why this is an *allocation*, not a *minting* — `ADR-0132` §7 stays closed

`ADR-0132` §7 fixes seven prerequisites for **minting** a permission identifier. ⛔ **None is engaged**, because
minting and allocating are different acts. ⭐ This ADR states **which existing role may perform which existing
action class at which existing scope class** — the `AP-8` policy-based model (role + tenant + action + resource),
which `ADR-0132` records as *"the derived-capability mechanism… already in active use"*. ⛔ **No name is coined.**

### 3.5 ⭐ Why this table is here and not in `PRD-023` or `PRD-001`

⭐ `CNF-BR-008` **forbids** `BC-25` to hold it: *"`BC-25` **SHALL NOT** hold a table of which role may write which
parameter."* ⛔ And `PRD-001` is **FROZEN v2.0**. ⭐ A Rank 2 ADR is therefore the only lawful home — the
identical reasoning `ADR-0151` §3.4 recorded.

---

## 4. ⭐⭐ The supersession — mechanics, and the precedent that supplies them

### 4.1 ⚠️⚠️ A prior finding of this work-chain is RETRACTED

⚠️⚠️ **Earlier packages in this chain stated that partial supersession had *"no precedent"* and would be the
repository's *"first ever"*, and recommended a Governance Owner ruling (`A-5`) to establish the mechanics. THAT
WAS WRONG.** ⭐ It was falsified by measuring the `Supersedes:` header row across all **133** ADR files, which
returns **five** genuine supersessions — ⛔ not zero.

⭐ **The error was trusting the `ADR-INDEX` Count cell** (*"0 superseded"*), which counts **whole-document**
supersessions, and reading it as though it counted **all** supersessions. ⭐ They are different measures.
⛔ The `A-5` gate is **withdrawn as unnecessary**, and this retraction is recorded rather than quietly dropped.

### 4.2 ⭐ The four worked precedents

| Superseding | Target | Form | Target md5 *(verified)* | Target status |
|---|---|---|---|---|
| ⭐⭐ **`ADR-0130`** | `ADR-0046` | **SUBSTANTIVE** — *"superseded **for its V1 limb only**"* | `7ea5d4be…` | ⭐ **ACCEPTED** |
| `ADR-0136` | `ADR-0131` §9.3 | *"IN PART and IN EFFECT ONLY"* — clauses of fact | `a9933a9f…` | ⭐ **Accepted** |
| `ADR-0137` | `ADR-0133` | *"…in exactly **three** places"* | `996664eb…` | ⭐ **Accepted** |
| `ADR-0138` | `ADR-0137` | *"…in exactly **five** places"* | `577d0c75…` | ⭐ **Accepted** |

⭐⭐ **`ADR-0130` is the controlling precedent**, because it is the only one that superseded a **substantive
decision** rather than a clause of fact. Its §5 records:

> *"`ADR-0046` is **NOT edited**… Its file remains byte-unchanged and its historical traceability is fully
> preserved… That decision is superseded because **its subject has been removed from V1 scope**, not because it
> was wrong when made."*

⭐ **The established mechanics, all four verified:** ⛔ the target is **never edited** · ⭐ the target **retains
`Accepted`** · ⭐ the `ADR-INDEX` Count cell is **not** incremented for a partial · ⭐ the superseded scope is
enumerated **place by place**, and what **stands** is enumerated explicitly.

### 4.3 ⛔⛔ The exact supersession scope — two places, and NO other

⛔ **`ADR-0152` is superseded IN PART and IN EFFECT ONLY, in exactly two places:**

**(a) §7, the numbered decision paragraph**, which reads:

> *"`SECP-HRO-005` "Change platform configuration" is a GOVERNANCE / CHANGE-CONTROL ACT. ⛔ It does NOT establish
> an APP 3 / Platform Admin runtime configuration **surface, API or write path**."*

⭐ Superseded **as to the word "surface" ONLY**, and **only** to the extent of a **read-only** surface.
⭐⭐ **"API" and "write path" STAND, unamended and authoritative.** ⭐⭐ **The statement that `SECP-HRO-005` is a
governance / change-control act STANDS and is TRUE** — ⛔ this ADR does not reclassify `SECP-HRO-005` at all.

**(b) §8.5, one table row**, which reads:

> `| **APP 3 — Platform Admin** | ⛔ **0 configuration surfaces** | ⭐⭐ **This ADR §7** |`

⭐ Superseded **as to the count only**, which becomes **0 *writable* configuration surfaces**.
⭐⭐ **The APP 1 and APP 2 rows of §8.5 STAND unamended**, as does the sentence beneath it — *"⛔ No role, action
class or scope class is created, widened or narrowed. `PR-1` and `PR-2` retain their `PRD-001` §2.3 definitions
exactly"* — which ⭐ **this ADR also satisfies**.

### 4.4 ⭐⭐ What in `ADR-0152` STANDS — authoritative and unamended

✅ **§7 limb 1** — *"`PR-1` is authorized **in principle** to govern platform configuration"* — ⭐ **this ADR
relies on it**
✅ **§7 limb 2** — the governance route (`CONFIGURATION_GUIDE` §5, `CNF-FR-026`)
✅⭐⭐ **§7 limb 3** — *"**No runtime write path to scope 1 exists or may be built**"* — ⛔ **PRESERVED IN FULL,
and re-stated as `D-4` of this ADR**
✅ **§7 limb 4** — `SECP-HRO-005` retains full force (`SECP-FR-011` audit, `SECP-BR-004` closure)
✅ **§8.1** `DD7-GAP-001` CLOSED · **§8.2** `DD7-GAP-002` CLOSED AS MOOT ⛔ not answered · **§8.3** D1 reasoning ·
**§8.4** D5 untouched by `ADR-0152`
✅ **§8.6** `BC-25` ownership boundary · **§1–§6** the entire mis-ranking analysis · **§9–§12**

⭐⭐ **`ADR-0152`'s reasoning was correct. What changed is the scope of one noun.** ⛔ This ADR reverses no other
decision.

### 4.5 ⛔ `ADR-0152` immutability

⛔ **No byte of `ADR-0152` is edited.** Required md5, verified **before and after** this act:
**`7fc60c7ff06a8fb6e47c17d88dec9071`**. ⭐ Its `Status` remains **`Accepted`** — ⛔ **not** restatused, ⛔ not
reopened, ⛔ not deprecated. ⭐ `ADR-INDEX` **Process step 2** (*"Never edit an Accepted ADR's decision text —
supersede it with a new ADR"*) and **step 3** (*"An ADR supersedes; it does not delete"*) are both satisfied.

---

## 5. The decisions of this ADR

| # | Decision |
|---|---|
| **`D-1`** | ⭐⭐ **`ADR-0152` §7 (the "surface" limb) and §8.5 are SUPERSEDED IN PART and IN EFFECT ONLY**, in exactly the two places enumerated at §4.3 and **in no other**. ⛔ `ADR-0152` is byte-unchanged and remains `Accepted`. |
| **`D-2`** | ⭐⭐ **APP 3 MAY hold a READ-ONLY `BC-25` configuration surface** for `PR-1` Platform Administrator and `PR-2` Platform Support. |
| **`D-3`** | ⭐⭐ **`CFG-1`…`CFG-9` and `CFG-11` receive `READ` = `PR-1` + `PR-2`, Commercial = `NOT COMMERCIAL`, Scope = `Platform default`** (§2.5). |
| **`D-4`** | ⛔⛔ **NO WRITE AUTHORITY IS CREATED FOR ANY ACTOR AT ANY SCOPE.** `ADR-0152` §7 limb 3 stands in full: *"No runtime write path to scope 1 exists or may be built."* ⛔ No APP 3 write API, editable control, override store, tenant override or runtime mutation path is authorized. All **12** WRITE cells are ⚪ **N/A**. |
| **`D-5`** | ⛔ **NO TENANT-ROLE AUTHORITY IS CREATED, CHANGED OR IMPLIED.** `TR-1`…`TR-5` receive **nothing** on these ten. ⛔ `ADR-0151` and `ADR-0153` are **byte-unchanged**. |
| **`D-6`** | ⛔⛔ **`CFG-10` and `CFG-12` REMAIN HELD** — no READ, no WRITE, no commercial classification, no scope (§6). |
| **`D-7`** | ⭐ **`READ` allocation may precede APP 3 runtime implementation** (B3). ⛔ **This ADR does NOT authorize APP 3 implementation**; `lib/app/platform_admin/README.md` §3 is unaffected and that work remains separately governed. |
| **`D-8`** | ⛔⛔ **`ICFG-1`…`ICFG-10` ARE EXPRESSLY NOT DECIDED** by this ADR, and the B2 classification **MUST NOT** be extended to them by analogy (§7). |
| **`D-9`** | ⭐ **`DD-0007` D5's "measured NEGATIVE" is VOID** and must be re-declared as a **positive, explicitly declared, one-directional cross-app dependency** at the `DD-0007` amendment (§9). |

---

## 6. ⛔⛔ The two held parameters — NOT allocated, and why

⛔⛔ **`CFG-10` and `CFG-12` receive NO `READ`, NO commercial classification and NO scope.** ⭐ They remain
**`NOT YET AUTHORIZED`**.

| Parameter | Reason held | Required authority |
|---|---|---|
| ⛔ **`CFG-10`** Soft-deleted account retention *(30 d)* | ⚠️ **DPDP erasure obligation.** Guide §2: *"short enough to remain **defensible as erasure under DPDP**"*; *"Above 90 days: difficult to defend as honouring an erasure request."* Owner of record: **Legal + Security** | **Legal + Security** |
| ⛔ **`CFG-12`** Platform Support elevated-access max duration *(1 h)* | ⛔⛔ **AUTHORIZATION-SEMANTIC.** It bounds **`PR-2`'s own elevation ceiling** (`AUTH-7.19`, `XC-2.5`, `XC-7.11`). ⚠️ A `PR-2` read of the parameter governing `PR-2`'s own privilege is **self-referential**. Owner of record: **Security + Legal** | **Authorization Owner + Security + Legal** |

⭐⭐ **`CFG-12` is the sharper hold, and it is held even though B2 allowed the other ten.** ⭐ It is the **only**
one of the twelve that governs a **platform role's own authority** — the same pattern `ADR-0153` §5 held for
`ATT-CFG-022`/`024`. ⛔ **Being adjacent to ten allowed parameters is not a reason to allow it.**

---

## 7. ⛔⛔ `ICFG-1`…`ICFG-10` — expressly NOT batched

⭐ The `ICFG` register was audited during this work-chain and found **structurally similar** to `CFG`:

| Dimension | `ICFG` finding | Evidence |
|---|---|---|
| Scope | **Platform default** | ⭐ **10 of 10** in `CONFIGURATION_GUIDE` §4 env-profile table (**L806**–**L815**); ⛔ the §4 *"per-library settings"* carve-out at **L829** names **only** `LCFG-1`…`5`, `7`…`10` |
| WRITE | None storable | `CNF-FR-028`; ⛔ owning spec declares *"tenant-settable"* **0** times |
| READ | ⛔ **OPEN** | ⛔ **0** statements |
| Commercial | ⛔ **OPEN** | ⛔ **0** statements |

⚠️⚠️ **Similarity is not authority, and the B2 decision says so expressly**: *"For the later `ICFG` audit, **do
NOT automatically apply this decision** unless the governance evidence permits batching them. Treat `ICFG`
separately and require the appropriate decision/evidence."*

⛔⛔ **`ICFG-1`…`ICFG-10` therefore remain `NOT YET AUTHORIZED`.** ⭐ They require their own Product Owner
`READ`/commercial decision and their own SECURITY PLATFORM classification — ⚠️ the latter being especially
pointed, since `INVITATION_SECURITY_SPECIFICATION` §11 states *"**Every parameter in this register is
security-owned.**"*

---

## 8. What this ADR does NOT decide

| # | ⛔ Not decided |
|---|---|
| 1 | ⛔⛔ **The other 55 unallocated parameters** — `ICFG` 10 · `SCFG` 11 · `SMCFG` 7 · `SEAT-CFG` 18 · held `ATT-CFG` 7 · held `CFG` 2 = **55** |
| 2 | ⛔ **`DD-0007` design-readiness.** ⭐ Authorization ≠ design. D3 moves to **49 / 104** and stays **`PARTIAL`** |
| 3 | ⛔ **Whether `BC-25` owns a configuration surface at all** — `DD7-GAP-003`, still **OPEN** |
| 4 | ⛔ **APP 3 implementation** — expressly excluded by B1 limb 11 and B3 |
| 5 | ⛔ **What the APP 3 read-only surface looks like** — a **design** question for the `DD-0007` amendment, ⛔ not an authorization question |
| 6 | ⛔ **`CNF-GAP-001`…`008`**, all unchanged; **`CNF-GAP-002`** and **`CNF-GAP-007`** remain **OPEN at Stage 6** |
| 7 | ⛔ **`CNF-D-1`, `CNF-D-2`, `CNF-D-3`** · ⛔ **`DD7-GAP-013`** · ⛔ **`G-5`** *(an `ADR-0151` §1 measurement error, disclosed by `ADR-0153` §6 — **Architecture Owner**)* |
| 8 | ⛔ **`DD7-GAP-002`'s definitional residue** — *"platform configuration"* still has **0** definitions as a parameter set. ⚠️ `ADR-0152` §8.2 warned it *"returns"* if a future act needs the set enumerated; ⭐ **this act does not enumerate it** — it names **ten specific parameters by identifier** |

---

## 9. ⭐ Consequences for `DD-0007` — routed, not performed here

⛔⛔ **This ADR does NOT edit `DD-0007`.** ⭐ A Design Doc's verdict is a statement *in* the Design Doc; ⛔ an ADR
that silently changed it would invert `docs/35-design/README.md` §5.1 — the identical reasoning `ADR-0152` §8.3
recorded when it routed its own amendment as `ADR-0152-F-1`.

| Declaration | Now | After the amendment |
|---|---|---|
| **D1** Target App | *"APP 2… ⛔ APP 3 = 0 `BC-25` runtime configuration surfaces"* | ⭐ **APP 2** *(read + write)* **+ APP 3** *(read-only)* — a **justified set**, which README §2B.3 D1 expressly permits |
| **D3** Permission Scope | ⚠️ PARTIAL — 39 / 104 | ⚠️ **PARTIAL — 49 / 104.** ⛔ Still not PASS |
| **D5** Cross-App | *"NONE — a measured NEGATIVE"* | ⭐⭐ **ONE, DECLARED** — positive, sourced, one-directional, read-only |
| **§5.5** check 7 | PASS — APP 3 = 0 surfaces | ⭐ **PASS, restated** — separation held by read-only + `AUTH-2.5` |
| **`DD7-AC-020`** | *"⛔ No APP 3 surface, platform-admin API or platform write path exists"* | ⚠️ **SPLIT** — ⭐ the **API** and **write-path** clauses stand; the surface clause is amended |

⚠️⚠️ **D5 cannot keep its current form.** Its PASS rested on *"every authorized surface is APP 2, therefore no
jump between apps is possible"* — ⛔ a premise this ADR falsifies **by construction**. ⭐ README §2B.3 asks for
cross-app dependencies *"**if any**"* and names the failure mode as *"an **undeclared** jump between apps"*;
⭐ **a declared dependency satisfies it**, ⛔ a concealed one does not.

---

## 10. Options considered and rejected

| # | Option | Disposition |
|---|---|---|
| **O-1** | Read `ADR-0152` §7 as already permitting a read-only surface *("it only forbids write paths")* | ⛔ **REJECTED.** §7 reads *"surface, API or write path"* — **disjunctive**; §8.5 says *"0 configuration surfaces"* **unqualified**. ⭐ Reading around it would be reinterpretation, not governance |
| **O-2** | Edit `ADR-0152` in place | ⛔⛔ **PROHIBITED** — `ADR-INDEX` Process step 2 |
| **O-3** | Supersede `ADR-0152` **entirely** | ⛔ **REJECTED** — grossly over-broad. ⭐ Its mis-ranking analysis, its `DD7-GAP-001`/`002` closures and its write-path prohibition are all **correct and needed** |
| **O-4** | Allocate `READ` to `TR-1`/`TR-2`/`TR-3` instead, avoiding APP 3 | ⛔ **REJECTED** — would **invent** a Product Owner decision. ⭐ The PO named `PR-1` + `PR-2` |
| **O-5** | Allocate to `PR-1` only, holding `PR-2` | ⛔ **NOT TAKEN** — it was the lawful fallback had B2 denied; ⭐ **B2 allowed**, so the fallback is unnecessary |
| **O-6** | Batch `ICFG` into this act on structural similarity | ⛔⛔ **REJECTED** — B2 expressly forbids it (§7) |
| **O-7** | Allocate all 12 `CFG`, including `CFG-10`/`CFG-12` | ⛔ **REJECTED** — DPDP and authorization-semantic holds (§6) |
| **O-8** | Wait for APP 3 implementation before allocating | ⛔ **NOT TAKEN** — B3 determined allocation may precede implementation. ⚠️ Had B3 denied, this ADR would have stopped at `D-1`/`D-2` |
| **O-9** | Seek a Governance Owner ruling on supersession mechanics first | ⛔ **WITHDRAWN AS UNNECESSARY** — measurement found **four** worked precedents (§4.1) |

---

## 11. Execution

⛔ **No `PRD_LIFECYCLE` §4 step, no baseline re-issue, no matrix re-measurement and no registry advance follows**
— ⛔ **no Rank 1–5 document changes.** ⭐ The only files this act touches are **this ADR**, **`ADR-INDEX.md`**
and, as a routed follow-up in the same commit, **`DD-0007`**.

| Action | Status |
|---|---|
| Create this ADR | ⭐ **DONE** |
| Register in `ADR-INDEX` end-of-file addendum | ⭐ **DONE** — ⛔ Count cell's *"0 superseded"* **unchanged** (a partial supersession is not a whole-document one — §4.2) |
| Amend `DD-0007` | ⭐ **Routed as `ADR-0154-F-1`**, executed in the same commit |
| ⛔ Edit `ADR-0152` | ⛔ **NOT DONE — PROHIBITED** |
| ⛔ Edit `ADR-0151` / `ADR-0153` / any frozen PRD | ⛔ **NOT DONE** |
| ⛔ Authorize APP 3 implementation | ⛔ **NOT DONE** |

---

## 12. Number allocation

⭐ Allocated **by measurement**, per `ADR-0138` §3.4: before writing, `ADR-0154` returned **0 files** and **0**
textual occurrences repository-wide. ⭐ `ADR-INDEX` Process step 2 — *"Never reuse a number"* — is satisfied.
⛔ `ADR-0145` remains free and is **not** consumed here.

---

## 13. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-19 | ⭐⭐ **Created and `Accepted`. APP 3 may hold a READ-ONLY `BC-25` configuration surface, and the ten resolvable `CFG-*` parameters are allocated `READ` = `PR-1` + `PR-2`, `NOT COMMERCIAL`, Scope = `Platform default`** — coverage **39 → 49 of 104**. ⭐⭐ **FOUR GOVERNANCE GATES WERE OPENED AND EACH WAS ANSWERED BY ITS PROPER AUTHORITY BEFORE THIS ADR WAS WRITTEN** — **B1** Architecture Owner + SECURITY PLATFORM *(the same pairing that decided `ADR-0152`)*, **B2** SECURITY PLATFORM, **B3** Authorization (`BC-18`) Owner, **B4** resolved by measurement; ⛔ **none was inferred**, and each is recorded **verbatim** at §2. ⭐⭐ **THE SUPERSESSION IS NARROW AND ENUMERATED: exactly TWO places** (§4.3) — `ADR-0152` §7's word *"surface"* and §8.5's one table row — ⛔ **and in no other**; ⭐⭐ **§7's "API" and "write path" limbs STAND**, ⭐⭐ **limb 3 — *"No runtime write path to scope 1 exists or may be built"* — is PRESERVED IN FULL and re-stated as `D-4`**, and §7 limbs 1/2/4 plus §8.1–§8.4 stand unamended (§4.4). ⛔⛔ **`ADR-0152` IS BYTE-UNCHANGED** (md5 `7fc60c7ff06a8fb6e47c17d88dec9071`) ⛔ **and REMAINS `Accepted`** — ⛔ not restatused, not reopened, not deprecated. ⚠️⚠️ **A PRIOR FINDING OF THIS WORK-CHAIN IS RETRACTED** (§4.1): it claimed partial supersession had *"no precedent"* and would be the *"first ever"* — ⛔ **wrong**; measuring the `Supersedes:` row across **133** ADRs returns **four** worked precedents, of which ⭐⭐ **`ADR-0130`** *(`ADR-0046` superseded *"for its V1 limb only"*)* is **substantive and controlling**. ⭐ The error was reading the index's *"0 superseded"* Count cell — which counts **whole-document** supersessions — as though it counted all; ⭐ consequently the proposed **`A-5` Governance Owner gate is WITHDRAWN as unnecessary**. ⭐⭐ **`READ` WAS DECIDED, ⛔ NOT DERIVED FROM WRITE** (`CNF-BR-010`) — ⛔ **all 12 WRITE cells are ⚪ N/A, not DENY**, on the **`ADR-0151` §3.5** precedent, because `CNF-FR-020` leaves **no write decision to take** *"by any actor, including a platform role"*. ⭐⭐ **`AUTH-2.5` IS NOT ENGAGED, AND THAT WAS TESTED RATHER THAN ASSUMED** (§3.2): `CFG-*` resolve at **scope 1**, `PRD-023` **L316** records *"no library sets its own OTP quota"*, and `PR-1`'s frozen scope expressly names *"platform configuration"* — ⭐ so these are **platform-level objects**, ⛔ not tenant business data; ⚠️ the same conclusion would be **wrong** for a tenant-scoped register such as `ATT-CFG-*`. ⭐ **`PR-2`'s bound is stated positively** (§3.3): it may read a **threshold**, ⛔ never an **authentication factor or session secret** — ⭐ the `PRD-001` §2.3 prohibition names factors, not policy values. ⭐ **`CFG-5`/`CFG-6` remain ONE parameter each** despite two value limbs and two §4 table rows (§2.7) — ⛔ **0 new identifiers**, inventory stays **104**. ⛔⛔ **`CFG-10` AND `CFG-12` REMAIN HELD** (§6) — `CFG-10` on DPDP erasure *(Legal + Security)*; ⭐⭐ **`CFG-12` because it bounds `PR-2`'s OWN elevation ceiling** (`AUTH-7.19`) and a `PR-2` read of it is **self-referential** — the `ATT-CFG-022`/`024` pattern; ⛔ **adjacency to ten allowed parameters is not a reason to allow it**. ⛔⛔ **`ICFG-1`…`ICFG-10` ARE EXPRESSLY NOT BATCHED** (§7) — ⭐ measured **structurally identical** *(10/10 in the §4 environment table; `tenant-settable` declared **0** times)*, ⚠️ **but B2 forbids extension by analogy**, and `INVITATION_SECURITY_SPECIFICATION` §11 records *"every parameter in this register is security-owned"*. ⭐ **9 options considered and rejected** (§10), including reading `ADR-0152` §7 as already permitting this *(`O-1` — ⛔ rejected: the text is disjunctive)* and allocating to tenant roles to sidestep APP 3 *(`O-4` — ⛔ rejected: would invent a PO decision)*. ⚠️⚠️ **`DD-0007` D5's "measured NEGATIVE" IS VOID** and must be re-declared **positive, sourced and one-directional** (`D-9`, §9) — ⛔ its premise is falsified **by construction**, and ⛔ no wording preserves it. ⛔ **`DD-0007` IS NOT EDITED BY THIS ADR** — routed as **`ADR-0154-F-1`**, the `ADR-0152-F-1` precedent, because an ADR silently editing a Design Doc inverts README §5.1. ⛔⛔ **D3 STAYS `PARTIAL` — 49 / 104; 55 REMAIN; `DD-0007` IS NOT DESIGN-READY.** ⛔ **APP 3 IMPLEMENTATION IS NOT AUTHORIZED** (B1 limb 11, B3) — `lib/app/platform_admin/README.md` §3 unaffected. ⛔⛔ **`AUTH-7.22` closed at ZERO · 0 `PERM-*` · 0 roles · 0 action classes · 0 scope classes · 0 edges · 0 ports · `ADR-0132` §7 NOT engaged · `ADR-0151`, `ADR-0153`, `PRD-001`, `PRD-023`, `PRD-012a` and every frozen PRD byte-unchanged · 0 lines of runtime code.** ⭐ Number allocated by measurement (§12). |
