# ADR-0155 — `SCFG-*` Student Identity configuration: authorization allocation for the 9 routine parameters, with `SCFG-2` and `SCFG-4` HELD

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-19 |
| **Rank** | 2 — Architecture Decision Record |
| **Bounded context** | `BC-25` Configuration *(owning)*; `BC-11` Student Identity *(source)* |
| **Supersedes** | ⛔ **NOTHING.** This ADR supersedes no decision, in whole or in part. |
| **Superseded by** | — |
| **Authority instrument** | ⭐⭐ **Four authoritative decisions**, recorded verbatim at §2 — `S-1` *(Product Owner + SECURITY PLATFORM)*, `S-2` *(Privacy Owner)*, `S-3` *(Authorization Owner)*, `S-4` *(Architecture Owner)*. |
| **Follows** | `ADR-0151` *(the allocation route)* · `ADR-0153` *(`ATT-CFG-*`)* · `ADR-0154` *(`CFG-*`, the Platform Default precedent)* |
| **Decides** | ⭐ **9** of **11** `SCFG-*` parameters |
| **Expressly does NOT decide** | ⛔ `SCFG-2` · ⛔ `SCFG-4` · ⛔ `SMCFG-*` · ⛔ `SEAT-CFG-*` · ⛔ `ICFG-*` · ⛔ the 7 held `ATT-CFG-*` · ⛔ `CFG-10` / `CFG-12` |

---

## 1. Context

⭐ `DD-0007` reached **49 / 104** authorized parameters under `ADR-0151` **(22)**,
`ADR-0153` **(17)** and `ADR-0154` **(10)**. ⛔ **55** remained
`NOT YET AUTHORIZED`, of which **11** are the `SCFG-*` register.

⭐⭐ **The `SCFG-*` register is owned by `Student_Identity_PRD_v1` §5.5**
*(Status: **Official — declared baseline**, v1.0)*, which defines
`SCFG-1`…`SCFG-11` contiguously and states, at **`SID-5.45`**:

> *"Every value above **SHALL** be platform-wide. None **SHALL** be
> organisation-configurable, because this module is not organisation-scoped."*

⚠️⚠️ **THE AUDIT FOUND A REAL GAP, AND IT WAS REPORTED RATHER THAN CLOSED BY
INFERENCE.** ⭐ Scope was already settled by `SID-5.45` — **`Platform default`**,
the *same band* `ADR-0154` had just acted on. ⛔ **But the owning source contains
`PR-1`/`PR-2` exactly ZERO times**; it names only `TR-1`…`TR-5`. ⛔ Reading the
`ADR-0154` allocation across on the strength of a shared band would have been
**derivation, not decision**, barred by **`CNF-BR-010`** and **`AUTH-7.24`**
(*"Read MUST NOT imply any other action"*).

⭐⭐ **A band is not a decision.** The four decisions at §2 were therefore
**sought and obtained**, not assumed.

### 1.1 The four gates, and how each was cleared

| Gate | Question | Cleared by |
|---|---|---|
| **S-1** | May the 9 routine parameters be allocated `READ`? | ⭐ **Product Owner + SECURITY PLATFORM** — §2.1 |
| **S-2** | Is `SCFG-4` *(retention)* DPDP-adjacent like `CFG-10`? | ⭐ **Privacy Owner** — §2.2 — ⛔ **HELD** |
| **S-3** | Who is `SCFG-2`'s undefined *"review"* authority? | ⭐ **Authorization Owner** — §2.3 — ⛔ **HELD** |
| **S-4** | Is `WRITE` ⚪ `N/A` or ⛔ `DENY`? | ⭐ **Architecture Owner** — §2.4 — ⚪ **`N/A`** |

---

## 2. The decisions, recorded verbatim

⛔⛔ **NOTHING IN THIS ADR IS INFERRED. Each decision is reproduced as given.**

### 2.1 ⭐⭐ `S-1` — Product Owner + SECURITY PLATFORM

> **APPROVE:**
>
> For the 9 routine parameters:
> `SCFG-1`, `SCFG-3`, `SCFG-5`, `SCFG-6`, `SCFG-7`, `SCFG-8`, `SCFG-9`,
> `SCFG-10`, `SCFG-11`
>
> `READ` = `PR-1` + `PR-2`
>
> Scope = Platform Default.
> `WRITE` = `N/A` / not runtime-writable.
> Commercial = `NOT COMMERCIAL` unless separate authoritative evidence
> requires otherwise.
>
> This is an explicit allocation decision and must **NOT** be treated as
> inferred merely from the Platform Default band.
>
> No tenant-role `READ` or `WRITE` authority is created.
> No new role/action/scope/`PERM` identifier.

### 2.2 ⭐⭐ `S-2` — Privacy Owner

> **DECISION:**
>
> `SCFG-4` (Username-history retention, 24 months) remains **HELD**,
> together with `CFG-10`, pending Privacy Owner determination.
>
> Do **NOT** allocate `READ`/`WRITE` authority for `SCFG-4` yet.

### 2.3 ⭐⭐ `S-3` — Authorization Owner

> **DECISION:**
>
> For `SCFG-2`, the undefined *"review"* authority must be explicitly
> resolved by the Authorization Owner.
>
> Do **NOT** infer the reviewer from `TR-1`/`TR-2`/`PR-1`/`PR-2` naming,
> ownership, hierarchy, or UI visibility.
>
> If the Authorization Owner cannot identify an authoritative role,
> keep `SCFG-2` **HELD**.

### 2.4 ⭐⭐ `S-4` — Architecture Owner

> **DECISION:**
>
> `WRITE` for the Platform Default `SCFG` parameters is `N/A` / not
> runtime-writable, consistent with the Platform Default treatment
> and `ADR-0151` §3.5.
>
> This is **NOT** a `DENY` allocation and must not be represented as a
> runtime permission.

---

## 2.5 ⭐⭐ The allocation — 9 parameters

⭐ **`READ` = `PR-1` Platform Administrator + `PR-2` Platform Support** ·
**Scope = `Platform default`** · **`NOT COMMERCIAL`** · ⚪ **`WRITE` = `N/A`**

| # | ID | Parameter | Default | Scope | Commercial | `READ` `PR-1` | `READ` `PR-2` | `WRITE` `PR-1` | `WRITE` `PR-2` | Source |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | `SCFG-1` | Username length | 3–30 characters | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⚪ **N/A** | ⚪ **N/A** | §5.5 **L1335** |
| 2 | `SCFG-3` | Username rename cooldown | 30 days | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⚪ **N/A** | ⚪ **N/A** | §5.5 **L1337** |
| 3 | `SCFG-5` | Released-username hold period | 90 days | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⚪ **N/A** | ⚪ **N/A** | §5.5 **L1339** |
| 4 | `SCFG-6` | Bio maximum length | 300 characters | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⚪ **N/A** | ⚪ **N/A** | §5.5 **L1340** |
| 5 | `SCFG-7` | Global Profile Photo maximum size | 5 MB | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⚪ **N/A** | ⚪ **N/A** | §5.5 **L1341** |
| 6 | `SCFG-8` | Global Profile Photo accepted formats | JPEG, PNG, WebP | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⚪ **N/A** | ⚪ **N/A** | §5.5 **L1342** |
| 7 | `SCFG-9` | Per-contributor composition timeout | 1,500 ms | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⚪ **N/A** | ⚪ **N/A** | §5.5 **L1343** |
| 8 | `SCFG-10` | Public-profile view rate limit | 60 / min / account | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⚪ **N/A** | ⚪ **N/A** | §5.5 **L1344** |
| 9 | `SCFG-11` | Username availability-check rate limit | 30 / min / account | `Platform default` | NOT COMMERCIAL | ✅ | ✅ | ⚪ **N/A** | ⚪ **N/A** | §5.5 **L1345** |
| — | ⛔ `SCFG-2` | Reserved-username list | Platform-managed | `Platform default` | — | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | §2.3 `S-3` |
| — | ⛔ `SCFG-4` | Username-history retention | 24 months | `Platform default` | — | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | §2.2 `S-2` |

⭐ **9 allocated · ⛔ 2 HELD · 11 accounted for. ⛔ No parameter is unaccounted.**

### 2.6 ⭐⭐ Why `WRITE` is ⚪ `N/A` and ⛔ NOT ⛔ `DENY`

⭐ Per `S-4` and the **`ADR-0151` §3.5** precedent, a **platform-default**
parameter is not runtime-writable *by construction* — so there is no runtime
write operation for a role to be denied. ⛔ **`DENY` would misrepresent `N/A` as
a runtime permission decision**, which `S-4` expressly forbids.

⭐⭐ **A `WRITE` authority is therefore neither consumed, derived nor implied
here** — consistent with `CNF-BR-010` and `ADR-0154` §2.6.

### 2.7 ⭐⭐ The `NOT COMMERCIAL` condition was TESTED, ⛔ not assumed

⚠️ `S-1` made `NOT COMMERCIAL` **conditional** — *"unless separate authoritative
evidence requires otherwise"*. ⭐ **The condition was measured, not waved
through.** The owning source yields **4** commercial-adjacent hits
*(**L124**, **L127**, **L470**, **L473**)*, and ⭐ **every one concerns a
DIFFERENT bounded context** — `BC-02` membership plans and `BC-05` finance —
**read into** a composed profile *(**L862**)*.

⭐ ⛔ **None of the 9 parameters is itself commercial**: a username length, a
cooldown, a hold period, a bio length, a photo size, a photo format list, a
timeout and two rate limits. ⭐ **The condition is satisfied on evidence**, and
the classification `NOT COMMERCIAL` stands.

---

## 3. Authorization treatment — the invariants checked

| # | Invariant | Source | Held? |
|---|---|---|---|
| 1 | Permission catalogue closed at zero | `AUTH-7.22`, `ADR-0132` | ⭐ **YES** — **0** `PERM-*` minted |
| 2 | Platform role register closed at two | `AUTH` ch.07 **L79** | ⭐ **YES** — only `PR-1`, `PR-2` used |
| 3 | Library role register closed at five | `AUTH` ch.07 **L87** | ⭐ **YES** — ⛔ **0** tenant-role authority created (`S-1`) |
| 4 | `READ` decided, ⛔ not derived | `CNF-BR-010` | ⭐ **YES** — §2.1 is an express decision |
| 5 | `READ` implies no other action | `AUTH-7.24` | ⭐ **YES** — `WRITE` untouched |
| 6 | No role hierarchy | `AUTH-7.28` | ⭐ **YES** — `PR-1` and `PR-2` named separately |
| 7 | `PR-2` bounded to non-sensitive operational metadata | `AUTH` ch.02 **L137** | ⭐ **YES** — see §3.3 |
| 8 | Platform-default `WRITE` is ⚪ `N/A` | `ADR-0151` §3.5 | ⭐ **YES** — `S-4` |
| 9 | Scope is sourced, ⛔ not chosen | **`SID-5.45`** | ⭐ **YES** — *"SHALL be platform-wide"* |
| 10 | No new role, action class, scope class or `PERM-*` | `S-1` | ⭐ **YES** — **0 / 0 / 0 / 0** |
| 11 | Frozen/baseline sources unmodified | `ADR-INDEX` process | ⭐ **YES** — `Student_Identity_PRD_v1` **byte-unchanged** |
| 12 | Invariants not weakened by configuration | `SID-5.41`, `SID-5.44` | ⭐ **YES** — see §3.4 |
| 13 | Held items ⛔ not advanced | `S-2`, `S-3` | ⭐ **YES** — `SCFG-2`, `SCFG-4` untouched |
| 14 | An ADR supersedes, it does not delete | `ADR-INDEX` step 3 | ⭐ **YES** — ⛔ **nothing superseded at all** |

### 3.2 ⭐ Why `AUTH-2.5` / `AUTH-7.13` / `AUTH-7.61` are NOT engaged

⭐ Those rules govern **library-scoped** authority. **`SID-5.45`** places every
`SCFG-*` **platform-wide** and expressly says *"**None SHALL be
organisation-configurable**"*, and **`SID-4.49`** adds that the module
*"**SHALL NOT** consume `TenantContext`"*. ⭐ The parameters are therefore
**platform-level objects**, exactly as `PRD-023` **L316** establishes for the
`CFG-*`. ⛔ **The library-scope rules are not engaged, and are not weakened.**

### 3.3 ⭐ The `PR-2` ceiling

⭐ `PR-2` is bounded to *"non-sensitive operational metadata"*. ⭐ **SECURITY
PLATFORM is the office competent to apply that ceiling**, and it did so — in
`ADR-0154` §2.2 for the `CFG-*`, and again in **`S-1`** here. ⭐ The 9 are
length limits, timeouts, formats and rate limits — **operational thresholds**.
⚠️⚠️ ⭐ **And the two candidates that were NOT plainly non-sensitive were the
two HELD** — a **retention period** (`SCFG-4`, `S-2`) and a
**review-authority gap** (`SCFG-2`, `S-3`). ⭐ The ceiling was applied, ⛔ not
bypassed.

### 3.4 ⭐⭐ `SID-5.41` / `SID-5.44` are WRITE-constraints, and are NOT breached

⭐ **`SID-5.44`** — *"No configuration value **SHALL** be able to **change** the
default privacy mode, alter the allow-list, disable an audit event, or **set**
`SCFG-5` to 0 in production"* — and **`SID-5.41`** — *"`SID-INV-1`…`14`
**SHALL NOT be weakened by** a configuration value"* — are, on their face,
constraints on **changing values**.

⭐ A **read-only** allocation changes no value. ⛔ **Neither rule is breached,
weakened or reinterpreted.** ⚠️⚠️ ⛔ **AND THAT REASONING IS NOT USED TO IMPLY
AN ALLOCATION** — the allocation rests solely on the express decision at §2.1.
⭐ This mirrors the `PRD-023` scope-1 analysis in `ADR-0154`.

---

## 4. Supersession

⛔⛔ **THIS ADR SUPERSEDES NOTHING — in whole or in part.**

⭐ Unlike `ADR-0154`, no prior decision stands in the way: the `SCFG-*`
parameters were **`NOT YET AUTHORIZED`**, an absence rather than a contrary
decision. ⭐ `ADR-0151` §7 **anticipated** this act — *"Each needs the same act,
by the same route"* — so this ADR **completes** `ADR-0151`, ⛔ it does not
displace it.

⭐ Accordingly the `ADR-INDEX` **Count cell is NOT incremented**, and ⛔ no
`Superseded by` header is added to any document.

---

## 5. Decisions — `D-1` … `D-8`

| ID | Decision |
|---|---|
| **`D-1`** | ⭐ **9** `SCFG-*` parameters are allocated **`READ` = `PR-1` + `PR-2`** — `SCFG-1`, `3`, `5`, `6`, `7`, `8`, `9`, `10`, `11`. |
| **`D-2`** | ⭐ Scope = **`Platform default`**, sourced from **`SID-5.45`**, ⛔ not chosen. |
| **`D-3`** | ⭐ Classification = **`NOT COMMERCIAL`**, the `S-1` condition having been **tested** at §2.7. |
| **`D-4`** | ⚪ **`WRITE` = `N/A`** for all 11, ⛔ **NOT `DENY`**, ⛔ and not a runtime permission (`S-4`). |
| **`D-5`** | ⛔ **`SCFG-4` is HELD** with `CFG-10`, pending **Privacy Owner** determination (`S-2`). |
| **`D-6`** | ⛔ **`SCFG-2` is HELD** pending **Authorization Owner** identification of the *"review"* authority; ⛔ the reviewer **MUST NOT** be inferred from naming, ownership, hierarchy or UI visibility (`S-3`). |
| **`D-7`** | ⚠️⚠️ **AUTHORIZED ≠ DESIGNED.** ⛔ No surface is designed here. The 9 join surface **`C-5`**'s authorized-not-designed population. |
| **`D-8`** | ⭐ Authorization coverage moves **49 / 104 → 58 / 104**; ⛔ **46** remain `NOT YET AUTHORIZED`. |

---

## 6. ⛔ What this ADR does NOT decide

⛔ **`SCFG-2`** — reviewer undefined; **Authorization Owner** (`S-3`).
⛔ **`SCFG-4`** — retention, DPDP-adjacent; **Privacy Owner** (`S-2`).
⛔ **`CFG-10`** and **`CFG-12`** — still held from `ADR-0154`.
⛔ **`ICFG-1`…`10`** — ⛔ **expressly not batched**; needs its own Product Owner **and** SECURITY PLATFORM decisions (`ADR-0154` §7).
⛔ **`SMCFG-1`…`7`** and **`SEAT-CFG-001`…`018`** — not audited here.
⛔ **7 `ATT-CFG-*`** — still held from `ADR-0153`.
⛔ **Any `WRITE` authority**, for any parameter, at any scope.
⛔ **Any tenant-role authority** — `S-1` is explicit that none is created.
⛔ **`DD-0007` design-readiness** — ⛔ **D3 remains `PARTIAL`**.
⛔ **`G-5`** — the `ADR-0151` §1 inaccuracy remains an **Architecture Owner** item.

---

## 7. Consequences for `DD-0007`

⭐ Coverage **49 → 58 / 104** *(**55.8%**)*. ⭐ The **`Platform default`** band
moves **14 → 23**; ⛔ the `Tenant` and `Library` bands are **unchanged at 35**.

⛔ **46 remain** `NOT YET AUTHORIZED`, reconciling as:
**10** `ICFG-*` + **7** `SMCFG-*` + **18** `SEAT-CFG-*` + **7** `ATT-CFG-*` +
**2** `CFG-*` *(`10`, `12`)* + **2** `SCFG-*` *(`2`, `4`)* = **46**.
⭐ **58 + 46 = 104.** ⛔ **104 / 104 is NOT claimed.**

⚠️⚠️ ⛔ **`DD-0007` DOES NOT BECOME DESIGN-READY.** D3 stays **`PARTIAL`**; the
**4** Figma blockers stand; surface **`C-5`** remains **authorized but not
designed**.

⭐ **D1 and D5 are UNAFFECTED** — the `SCFG-*` are `Platform default`, read by
the same `PR-1`/`PR-2` in the same **APP 3** read-only surface already declared
at `DD-0007` §5.4.5. ⛔ **No new app, and no new cross-app edge, is introduced.**

---

## 8. Obligations — `O-1` … `O-7`

| ID | Obligation | Owner |
|---|---|---|
| **`O-1`** | Resolve **`SCFG-2`**'s *"review"* authority, or keep it HELD | **Authorization Owner** |
| **`O-2`** | Determine **`SCFG-4`** with **`CFG-10`** as one retention question | **Privacy Owner** |
| **`O-3`** | Design surface **`C-5`** to cover the 9 — ⛔ authorization is not design | **Design Owner** |
| **`O-4`** | Audit **`SMCFG-1`…`7`** by the same route | **Product Owner** |
| **`O-5`** | Audit **`SEAT-CFG-001`…`018`** by the same route | **Product Owner** |
| **`O-6`** | Decide **`ICFG-1`…`10`** — ⛔ never batched implicitly | **Product Owner** + **SECURITY PLATFORM** |
| **`O-7`** | Correct **`G-5`** in `ADR-0151` §1 | **Architecture Owner** |

---

## 9. Changelog

| Version | Date | Change |
|---|---|---|
| ⭐⭐ **1.0** | 2026-09-19 | ⭐⭐ **ACCEPTED.** ⭐ **9** `SCFG-*` allocated **`READ` = `PR-1` + `PR-2`**, **`Platform default`**, **`NOT COMMERCIAL`**, ⚪ **`WRITE` = `N/A`**. ⛔ **`SCFG-2`** and **`SCFG-4`** **HELD**. ⭐ Coverage **49 → 58 / 104**. ⛔ Supersedes **nothing**. ⛔ **0** `PERM-*` · **0** roles/actions/scopes · **0** frozen edits · **0** runtime code. ⚠️ **AUTHORIZED ≠ DESIGNED.** ⛔ **D3 still `PARTIAL`.** |
