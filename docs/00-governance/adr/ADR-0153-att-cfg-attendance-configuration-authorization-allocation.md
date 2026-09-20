# ADR-0153 — The **`BC-25` Configuration authorization allocation** is extended to the **17 allocatable `ATT-CFG-*` attendance parameters**, by **derived capability**

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-19 |
| **Date** | 2026-09-19 |
| **Deciders** | **Product Owner** *(the substantive allocation: the `READ` decision, the commercial classification and the effective-resolution scope for all 17)* **and Authorization (`BC-18` / `PRD-001`) Owner** *(review and formalisation against the frozen authorization model)*, **jointly**, each under a **one-act conferral** of the human principal of this engagement, ⛔ **reverting on completion** (`ADR-0033` §7.1: *"a conferral for one act is not a standing licence"*) |
| **Authority instrument** | ⭐⭐ The Product Owner's decision, recorded **verbatim** at §2.2 and tabulated at §2.3: **`READ` = `TR-1` + `TR-2` + `TR-3`**, **Commercial = `NOT COMMERCIAL`**, **Scope = `Tenant`**, applied to **`ATT-CFG-001`…`012`** and **`ATT-CFG-017`…`021`**. ⭐ The Authorization Owner conferral is recorded **in this ADR**, the instrument that exercises it — ⛔ **no standalone conferral artifact is created**, per the `ADR-0150` / `ADR-0151` precedent |
| **Successor to** | ⭐⭐ **[`ADR-0151`](./ADR-0151-bc-25-configuration-authorization-allocation.md)** — ⛔ **which is NOT amended, reopened or superseded.** `ADR-0151` is `Accepted`; its §7 states it *"does not allocate the other 82 parameters… Each needs the same act, by the same route."* ⭐ **This is that act, for 17 of them** — the `ADR-0149` → `ADR-0150` succession shape, reused |
| **Amends** | ⛔⛔ **NOTHING IS EDITED BY THIS ADR.** No file outside this one changes. It is **declaratory and constitutive**: it records a decision and allocates authority under mechanisms that already exist. ⛔ **`PRD-006` is NOT amended** — its §16.3 `WRITE` allocation is **consumed as-is**, not restated as new authority. ⛔ **`PRD-023` is NOT amended** — `CNF-BR-008` forbids that module to hold a role×parameter table (`ADR-0151` §3.4) |
| **Baseline** | ⛔ **No baseline re-issue.** No Rank 1–5 document changes here (`DOCUMENTATION_BASELINE.md` §7 **rule 4**) |
| **Closes** | ⭐ **`DD-0007` Declaration 3 for 17 further parameters** — coverage **22 → 39 of 104** |
| **Does NOT close** | ⛔⛔ **`DD-0007` Declaration 3 as a whole** — **65 of 104 remain unallocated** (§7) · ⛔ the **7** held `ATT-CFG-*` (§5) · ⛔ **`CNF-GAP-002`** and **`CNF-GAP-007`**, both **OPEN** at **Stage 6** · ⛔ **`CNF-GAP-001`**, `003`, `004`, `005`, `006`, `008` · ⛔ **`CNF-D-1`**, **`CNF-D-2`**, **`CNF-D-3`** · ⛔ **`DD7-GAP-003`**, **`DD7-GAP-013`** · ⛔ **`G-5`** (§6) |
| **Related** | `ADR-0151` *(the 22-parameter allocation — the pattern this ADR reuses; **preserved byte-unchanged**)* · `ADR-0150` · `ADR-0149` · `ADR-0132` *(`AUTH-7.22` audited at zero; derived capability the lawful route)* · `ADR-0043` *(**"do not invent a new permission ID"**)* · `ADR-0034` *(`PRD-006` v1.9 baseline)* · `ADR-0021` *(attendance configurable defaults)* · `ADR-0017` *(`BC-25` ownership)* |

> ⭐⭐ **`AUTH-7.22` REMAINS CLOSED AT ZERO ENUMERATED PERMISSIONS.** ⛔ This ADR mints **no** permission
> identifier, **no** `PERM-*` token, **no** action class, **no** scope class, **no** role, **no** event, **no**
> aggregate, **no** BC Map row, **no** edge, **no** configuration identifier, and **no** entry in any `CNF-*`,
> `ATT-CFG-*` or other register.
> ⛔ **`ADR-0132` is NOT reopened, amended or superseded, and NONE of its §7 prerequisites is engaged.**
> ⛔ **`ADR-0151` and `ADR-0152` are BYTE-UNCHANGED.** ⛔ **`PRD-006` is BYTE-UNCHANGED.**
> ⛔ **0 lines of runtime code.**

---

## 1. Context

`ADR-0151` established the `BC-25` authorization allocation for **22 of 104** parameters and recorded, at its §7,
exactly what remained:

> *"⛔ **It does not allocate the other 82 parameters.** 104 − 22 = **82** remain without an operation×role source:
> `CFG-1`…`12` (`PRD-001`), `ICFG-1`…`10`, `SCFG-1`…`11`, `SMCFG-1`…`7`, `SEAT-CFG-001`…`018`,
> `ATT-CFG-001`…`024`. ⭐ **Each needs the same act, by the same route.**"*

⭐⭐ **This ADR performs that act for 17 of the 24 `ATT-CFG-*` parameters.** ⛔ It performs it for **no** other
register.

### 1.1 ⭐⭐ Why `ATT-CFG-*` is the tractable subset — and what was already present

⭐ `ATT-CFG-*` is the **only** one of the six remaining registers whose owning PRD already carries a
**per-parameter runtime `WRITE` role**. `PRD-006` **§16.3** *(FROZEN v1.9, Rank 3, `ADR-0034`)* publishes an
**Owner** column whose values are runtime roles:

| Evidence that the §16.3 `Owner` column is a **runtime role**, not a governance office | Source |
|---|---|
| ⭐ `ATT-AC-200` audits *"the **acting actor**"* on every configuration change | `PRD-006` **L2836** |
| ⭐ `ATT-AC-213` — a setting *"is **presented to the Owner**"* | `PRD-006` **L2848** |
| ⭐ `ATT-FR-003` — the module *"**MUST** use only the **five roles** defined in Master PRD §6"* | `PRD-006` **L258** |
| ⭐ `ATT-FR-033` — *"manageable by the **`owner` and `manager` roles**"*, Product Owner decision **`D-12`** | `PRD-006` **L735** |
| ⛔ **`Manager` is not a governance office** — `CONFIGURATION_GUIDE`'s `Owner` column holds only `Security` (9), `Configuration` (8), `Engineering`, `Legal`, `Product`; measured **0** `TR-n` in that guide | measured |

⚠️⚠️ **The two columns share a name and mean different things**, and the distinction was tested rather than
assumed. ⭐ `ADR-0151` §8 **`O-1`** rejected reading the `CONFIGURATION_GUIDE` `Owner` column as a role
allocation; ⛔ **that rejection is preserved in full and is not disturbed** — it concerned a *different column in
a different document*.

### 1.2 ⭐ What was still missing, and therefore what this ADR decides

⭐ `CNF-FR-081` requires a per-parameter, per-role authority statement. `PRD-006` §16.3 supplies **one of four**
dimensions. The other three were measured **absent**:

| Dimension | Present before this ADR? | Measurement |
|---|---|---|
| **`WRITE`** | ⭐⭐ **YES** — `TR-1` on all 24; **`TR-1` + `TR-2`** on `ATT-CFG-008` (`D-12`) | `PRD-006` §16.3 |
| **`READ`** | ⛔⛔ **NO — 0 of 24.** Word-anchored sweep for *"may read" / "read authority" / "readable by"* returns **0** | measured |
| **Commercial** | ⛔ **NO — 0 of 24** | measured |
| **Scope** | ⚠️ **3 of 24 only** — `ATT-CFG-008`, `010`, `011` | `ATT-FR-032`, `ATT-FR-041`, `ATT-FR-042` |

⛔ **Deriving `READ` from `WRITE` was not available**, and not merely as a matter of caution:

> ⭐⭐ **`CNF-BR-010`** *(FROZEN)* — *"Read authority **SHALL NOT** be assumed to follow write authority. A role
> that may read an effective value **MAY** be unable to write it, and the reverse **SHALL NOT** be inferred."*

⭐ Its own worked example is this situation: *"`TR-3` Reception cannot alter library configuration, **yet
Reception's screens plainly depend on resolved configuration to function**."* ⭐ And `ADR-0151` §2.2 limb B is
the empirical proof — there, `TR-3` `WRITE` was **DENY on all 22** while `READ` was **ALLOW on 13**; a
derivation would have been wrong on **13 of 22**.

⛔ Derivation would also have breached **`AP-4` / `AUTH-7.7`** (*"No permission is derived from role naming,
**hierarchy, seniority** or similarity"*) and **`AUTH-7.28`** (*"Permissions **MUST NOT** form a hierarchy"*).

⭐⭐ **So the missing thing was a decision, not a reading. This ADR records one.**

---

## 2. The Product Owner decision

### 2.1 ⭐ The limb already resolved from frozen text — consumed, not re-decided

⭐⭐ **`WRITE` is NOT decided by this ADR.** It is taken **as-is** from `PRD-006` §16.3:

| `WRITE` allocation | Parameters | Source |
|---|---|---|
| **`TR-1`** *(Owner)* | `ATT-CFG-001`…`007`, `009`…`012`, `017`…`021` — **16 of the 17** | §16.3 `Owner` column |
| ⭐ **`TR-1` + `TR-2`** *(Owner + Manager)* | **`ATT-CFG-008`** only | §16.3 + `ATT-FR-033` + `ATT-AC-133`, Product Owner decision **`D-12`** |
| ⛔ **`TR-3`** *(Reception)* | ⛔ **NONE** — Reception holds **no** `WRITE` on any `ATT-CFG-*` | §16.3, measured |

⛔ **This ADR does not widen, narrow, restate or re-decide any of it.**

### 2.2 The Product Owner decision, verbatim

> *"Treat the Product Owner's final decision for the currently allocatable `ATT-CFG` parameters as:*
> *`READ` = `TR-1` + `TR-2` + `TR-3`*
> *Commercial = `NOT COMMERCIAL`*
> *Scope = `TENANT`*
>
> *Apply this to: `ATT-CFG-001` through `ATT-CFG-012` and `ATT-CFG-017` through `ATT-CFG-021`.*
> *This is **17 parameters** total.*
>
> *`ATT-CFG-008` already has Scope=Tenant and must remain unchanged.*
>
> *Keep these seven parameters on **HOLD** with no `READ`/Commercial/Scope allocation: `ATT-CFG-013`,
> `ATT-CFG-014`, `ATT-CFG-015`, `ATT-CFG-016`, `ATT-CFG-022`, `ATT-CFG-023`, `ATT-CFG-024`.*
>
> *Do not modify `ATT-CFG` `WRITE` authority. Do not modify `PRD-006`. Do not modify `AUTH-7.22`. Do not modify
> `ADR-0151`. Do not create permission IDs. Do not create runtime code."*

⚠️⚠️ **The scope limb was corrected by the Product Owner before this act, and the correction is recorded rather
than hidden.** ⭐ An earlier formulation proposed **`Scope = Library`** for these parameters. ⛔ That was
**reported as a conflict and NOT applied**, because three frozen `MUST` requirements say *per tenant*
(§3.2). ⭐ The Product Owner then decided **`Tenant`**, which is consistent with all three. ⛔ **No frozen text
was bent to fit a decision**, and no decision was silently rewritten.

### 2.3 The complete allocation — every parameter, every role, every action, every scope

⭐ **Action classes used: `Read`, `Update` only.** ⛔ Both pre-exist at `prd-v2/07` `AUTH-7.24`; **none is created.**
⭐ **Scope class used: `Tenant` only.** ⛔ It pre-exists at `PRD-023` §3.1 `CNF-FR-009` (scope 2); **none is created.**
⭐ **Roles used: `TR-1`, `TR-2`, `TR-3` only.** ⛔ All pre-exist at `PRD-001` v2.0 §2.4; **none is created.**

Legend: **W** = Update (write) · **R** = Read · ✅ ALLOW · ⛔ DENY
⭐ **W columns are `PRD-006` §16.3 restated for completeness — ⛔ NOT decided here.**

| # | Parameter *(`PRD-006`)* | Scope | Commercial | `TR-1` W | `TR-2` W | `TR-3` W | `TR-1` R | `TR-2` R | `TR-3` R |
|---:|---|---|---|:--:|:--:|:--:|:--:|:--:|:--:|
| 1 | `ATT-CFG-001` Fixed QR enabled | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 2 | `ATT-CFG-002` Dynamic QR enabled | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 3 | `ATT-CFG-003` Fixed QR + Wi-Fi enabled | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 4 | `ATT-CFG-004` Fixed QR + GPS enabled | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 5 | `ATT-CFG-005` Dynamic QR rotation interval | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 6 | `ATT-CFG-006` Dynamic QR validity window | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 7 | `ATT-CFG-007` Dynamic QR single-use per student-day | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 8 | ⭐ `ATT-CFG-008` Approved Wi-Fi network(s) | ⭐ `Tenant` *(pre-existing)* | NOT COMMERCIAL | ✅ | ⭐ **✅** *(`D-12`)* | ⛔ | ✅ | ✅ | ✅ |
| 9 | `ATT-CFG-009` Wi-Fi verification strictness | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 10 | `ATT-CFG-010` Library coordinates | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 11 | `ATT-CFG-011` GPS acceptance radius | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 12 | `ATT-CFG-012` Minimum acceptable location accuracy | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 13 | `ATT-CFG-017` Manual mode enabled | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 14 | `ATT-CFG-018` Register-image workflow enabled | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 15 | `ATT-CFG-019` OCR high-confidence threshold | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 16 | `ATT-CFG-020` Unattended creation of high-confidence OCR entries | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |
| 17 | `ATT-CFG-021` Check-out tracking enabled | `Tenant` | NOT COMMERCIAL | ✅ | ⛔ | ⛔ | ✅ | ✅ | ✅ |

⭐ **Count: exactly 17.** ⛔ `ATT-CFG-013`, `014`, `015`, `016`, `022`, `023`, `024` appear **nowhere** in this
table and receive **no** allocation of any kind.

### 2.4 ⭐ Why `TR-2` W is ⛔ DENY on 16, and what that is NOT

⚠️ **`TR-2` `WRITE` = ⛔ on 16 of 17 is NOT a decision of this ADR, and NOT a new restriction.** ⭐ It is the
**measured content of `PRD-006` §16.3**, whose `Owner` column names `Owner` alone on those rows. ⭐ The single
exception, `ATT-CFG-008`, is where `PRD-006` itself adds `Manager` under `D-12`.

⛔ **The `TR-2` commercial restriction is NOT the operative reason here** — all 17 are `NOT COMMERCIAL`, so
`PRD-001` §2.4 **L635**'s *"excluding commercial configuration"* limb ⛔ **does not bite on any of them**. ⭐ The
`TR-2` `WRITE` position rests solely on §16.3's role column, and ⛔ this ADR neither widens nor narrows it.

### 2.5 ⭐⭐ `TR-3` reads what it cannot write — the `CNF-FR-081` case, stated

⭐ `TR-3` Reception receives **`READ` ✅ on all 17** and **`WRITE` ⛔ on all 17**. ⛔ That asymmetry is not an
oversight; ⭐ it is the exact configuration `CNF-FR-081` legislates for:

> *"A parameter the current actor may read but not write (`CNF-BR-010`) **SHALL** be presented as **read-only**,
> not hidden and not presented as editable-then-refused."*

⭐ **Design consequence, stated so it is not re-derived later:** for all 17, a `TR-3` surface renders the row
**read-only** — ⛔ **not** absent. ⚠️ This is the **opposite** of `DD-0007` §8.2's deny-read treatment of
`MM-CFG-007`/`009`, and the difference is principled: there, `AC-7.8` **denies Reception the read** because the
parameters are financial, so the row must be **ABSENT**; here the Product Owner has **granted** the read, so
`CNF-FR-081` requires it **visible and read-only**. ⛔ Neither rule is weakened.

---

## 3. Authorization treatment

### 3.1 Every invariant re-verified against this allocation

| Rule | Requirement | Verdict |
|---|---|---|
| **`AUTH-7.22`** | Permission catalogue closed at **zero** | ⭐ **PRESERVED** — ⛔ 0 `PERM-*` minted; allocation ≠ minting (§3.4) |
| **`AUTH-7.24`** | Each action class granted independently; *"Read **MUST NOT** imply any other action"* | ⭐ **SATISFIED** — `Read` and `Update` allocated separately per parameter |
| **`AUTH-7.28`** | Permissions **MUST NOT** form a hierarchy | ⭐ **SATISFIED** — ⛔ no parameter's grant implies another's; the 17 rows are independent |
| **`AP-4` / `AUTH-7.7`** | No permission derived from naming, hierarchy or seniority | ⭐ **SATISFIED** — the `READ` grant is a **recorded decision** (§2.2), ⛔ not a derivation from `TR-1` > `TR-2` > `TR-3` |
| **`AUTH-7.29`** | Scopes narrow, never widen | ⭐ **NOT ENGAGED** — a single scope (`Tenant`) for all 17; ⛔ no scope pair to narrow or widen |
| **`CNF-BR-010`** | Read decided independently of write | ⭐⭐ **SATISFIED, and visibly so** — `TR-2`/`TR-3` receive `READ` ✅ where `WRITE` is ⛔ on 16 of 17 |
| **`CNF-BR-007`** | A change takes effect only for resolutions after it commits | ⭐ **UNAFFECTED** |
| **`CNF-BR-008`** | `BC-25` **SHALL NOT** hold a role×parameter table | ⭐ **RESPECTED** — this table lives at Rank 2, ⛔ not in `PRD-023` |
| **`CNF-FR-009`** | Five scopes, structural | ⭐ **RESPECTED** — `Tenant` is scope 2; ⛔ no scope added, removed or reordered |
| **`CNF-FR-081`** | Read-not-write renders read-only | ⭐ **SATISFIED** — §2.5 |
| **`ATT-FR-005`** | Attendance permission scope ∈ {`self`, `guardianOf`, `tenantWide`}; ⛔ no fourth scope | ⭐ **NOT ENGAGED** — §3.3 |
| **`ATT-FR-118`** | ⛔ No new RBAC system, role, permission model or scope | ⭐ **SATISFIED** — ⛔ 0 created |
| **`ATT-FR-003`** | Only the five Master PRD §6 roles | ⭐ **SATISFIED** — `TR-1`/`TR-2`/`TR-3` are three of them |
| **`ATT-BR-017`**, **`ATT-FR-121`** | Tenant isolation; roles not inherited across tenants | ⭐ **PRESERVED** — `Tenant` scope is isolation-consistent |

### 3.2 ⭐⭐ Why `Tenant` and not `Library` — three frozen `MUST` requirements

⭐ Three parameters in this set carry an **explicit frozen scope statement**, and **all three say per tenant**:

| Parameter | Frozen requirement | Line |
|---|---|---|
| `ATT-CFG-008` | **`ATT-FR-032`** — *"The approved network(s) **MUST** be configurable **per tenant**"* | **L734** |
| `ATT-CFG-010` | **`ATT-FR-041`** — *"**Library coordinates** **MUST** be configurable **per tenant**"* | **L1329** |
| `ATT-CFG-011` | **`ATT-FR-042`** — *"An acceptance radius **MUST** be configurable **per tenant**"* | **L1330** |

⭐ Corroborated by **`ATT-AC-135`** (**L2751**) and, for the whole register, **`ATT-AC-200`** (**L2836**):
*"Every configuration change is audited with the acting actor and is **tenant-resolvable"* — cited against
**`ATT-CFG-001`…`ATT-CFG-024`**.

⚠️⚠️ **`ATT-CFG-010` is the instructive case and is recorded deliberately.** Its name contains the word
*"Library"*, ⛔ **and the frozen requirement governing it says per tenant.** ⭐ A name is not a scope
declaration. ⛔ Had `Library` been applied, this ADR would have contradicted `ATT-FR-041` in mandatory language.

⭐ Further measurement supporting `Tenant`: `PRD-006` contains **0** occurrences of `libraryId`, **8** of
`tenantWide`, and **0** parameters scoped per library. ⚠️ Its single *"per-library"* phrase (**L1280**, `D-21`,
Location Verification) ⛔ **names no `ATT-CFG` identifier** and is therefore not a scope declaration for any of
them.

### 3.3 ⭐ Two different "scopes", and why `ATT-FR-005` is not engaged

⚠️ `PRD-006` §19.2 marks the operation *"Configure attendance modes and values (§16)"* as **`tenantWide`**, and
`ATT-FR-005` closes the **attendance permission** scope register at `self` / `guardianOf` / `tenantWide`.

⭐⭐ **That is a different axis from this allocation's `Scope` column**, and the two are deliberately not
conflated:

| | Register | Values | Governs |
|---|---|---|---|
| **Permission scope** | `ATT-FR-005` | `self` · `guardianOf` · `tenantWide` | ⭐ **Which records an actor may reach** |
| **Resolution scope** | `CNF-FR-009` | Platform default · **Tenant** · Library · Branch · User | ⭐ **Where a configuration value resolves** |

⛔ **`Tenant` here is `CNF-FR-009` scope 2, ⛔ not a fourth `ATT-FR-005` scope.** ⭐ `ATT-FR-005`'s prohibition on
a fourth scope is therefore **untouched**, and ⭐ the `tenantWide` operation scope was **not** converted into a
resolution scope — it is corroborating context only.

### 3.4 ⭐ Why this is an *allocation*, not a *minting* — `ADR-0132` §7 stays closed

⭐ This ADR states **who may act on an existing parameter**. ⛔ It does **not** create a permission object, an
identifier, or an entry in any catalogue. `AUTH-7.22`'s catalogue is **closed at zero** and ⭐ **remains closed
at zero after this ADR**. ⛔ `ADR-0132` §7's prerequisites for *minting* are therefore **not engaged**, exactly
as `ADR-0151` §3.6 reasoned for its own 22. ⭐ `ADR-0043` **L177** — *"Do not invent a new permission ID"* — is
honoured: ⛔ **0 invented**.

### 3.5 ⭐ Why this table is here and not in `PRD-006` or `PRD-023`

⛔ **`PRD-023` cannot hold it** — `CNF-BR-008`: *"This module **SHALL NOT** hold a table of which role may write
which parameter."*
⛔ **`PRD-006` is not amended to hold it** — it is **FROZEN v1.9** at Rank 3 under `ADR-0034`, and amending a
frozen PRD to accommodate a downstream decision is the defect `PRD_LIFECYCLE` Stage 8 exists to prevent. ⭐ The
`ADR-0150` shape *(amend the owning PRD)* is **deliberately not reused here**, for that reason.
⭐ **Rank 2 is therefore the only lawful home**, precisely as `ADR-0151` §3.4 concluded for its own 22.

---

## 4. What is NOT created

| Category | Count | Note |
|---|---:|---|
| `PERM-*` identifiers | ⛔ **0** | `AUTH-7.22` closed at zero; `ADR-0043` L177 |
| New roles | ⛔ **0** | `TR-1`/`TR-2`/`TR-3` pre-exist — `PRD-001` v2.0 §2.4 |
| New action classes | ⛔ **0** | `Read`/`Update` pre-exist — `AUTH-7.24` |
| New scope classes | ⛔ **0** | `Tenant` pre-exists — `CNF-FR-009` scope 2 |
| New configuration parameters | ⛔ **0** | Register stays **24**; inventory stays **104** |
| Permission hierarchies | ⛔ **0** | `AUTH-7.28` |
| Events, aggregates, BC Map rows, edges | ⛔ **0** | |
| Frozen documents modified | ⛔ **0** | `PRD-006`, `PRD-023`, `PRD-001` byte-unchanged |
| Accepted ADRs modified | ⛔ **0** | `ADR-0151`, `ADR-0152`, `ADR-0132`, `ADR-0043` byte-unchanged |
| Lines of runtime code | ⛔ **0** | |

---

## 5. ⛔⛔ The seven held parameters — NOT allocated, and why

⛔⛔ **`ATT-CFG-013`, `014`, `015`, `016`, `022`, `023`, `024` receive NO `READ`, NO commercial classification
and NO scope.** ⭐ They remain **`NOT YET AUTHORIZED`**.

| Parameter | Reason held | Required authority |
|---|---|---|
| **`ATT-CFG-013`** Face enrollment required | ⚠️ Face family — V1/V3 boundary unresolved | Product Owner + Security Owner |
| **`ATT-CFG-014`** Face match confidence threshold | ⛔⛔ **Not in V1** — §16.3 Default and Allowed-domain both read *"Not in V1"*; Face = **V3** (`D-3a`). ⚠️ `ADR-0021` **L7**/**L200**: *"**security input required** for `ATT-CFG-014`"* | Product Owner + **Security Owner** |
| **`ATT-CFG-015`** Face liveness required | ⚠️ Face family — V1/V3 boundary unresolved | Product Owner + Security Owner |
| **`ATT-CFG-016`** Face mode enabled | ⚠️ Face family; ⛔ blocked by `ATT-FR-064` | Product Owner + Security Owner |
| **`ATT-CFG-022`** Staff correction permitted | ⛔⛔ **AUTHORIZATION-SEMANTIC.** §19.2 **L1980**: *"Corrections (§18) \| `reception`, `manager` — **subject to `ATT-CFG-022`**"*. ⭐ A `TR-1` write would switch off a `TR-2`/`TR-3` capability — ⚠️ engages **`AUTH-7.28`** | **Authorization (`BC-18`) Owner** + Product Owner |
| **`ATT-CFG-023`** Correction window | ⚠️ Time-bounds the capability `ATT-CFG-022` gates; ⛔ deciding them apart could permit corrections while setting the window to 0 | **Held with `ATT-CFG-022`** |
| **`ATT-CFG-024`** Parent attendance visibility | ⛔⛔ **AUTHORIZATION-SEMANTIC and CROSS-APP.** §19.2 **L1983**: *"View guarded students' attendance \| `parent` — **subject to `ATT-CFG-024`**"*. ⭐ A `TR-1` (APP 2) write gates a **`TR-5`** (APP 1) capability | **Authorization Owner** + Product Owner |

⭐⭐ **The existence of a `WRITE` role in §16.3 was NOT treated as sufficient authority to allocate these
seven.** ⛔ All seven carry `WRITE` = `Owner` in §16.3, exactly like the 17 — ⭐ and they are held anyway,
because `WRITE` is one dimension of four and because three of them decide *other roles' authority*.

---

## 6. ⚠️⚠️ `G-5` — a measurement in `ADR-0151` §1 that this ADR does NOT correct

⚠️ `ADR-0151` §1 records: *"Word-anchored sweep of all 8 owning registers: **0** of 104 parameters carries a
write-authority declaration."*

⛔ **That measurement is inaccurate.** `PRD-006` §16.3's `Owner` column is a per-parameter runtime `WRITE`
declaration for **`ATT-CFG-001`…`024`**, with `ATT-CFG-008` additionally naming `Manager` — so the true figure
is **24 of 104**, not 0.

⛔⛔ **This ADR does NOT correct it, and deliberately so:**

1. ⛔ `ADR-0151` is **`Accepted`**. Correcting a stated measurement inside an Accepted Rank 2 ADR is an
   **Architecture Owner** act, ⛔ not a Product Owner one, and ⛔ not within this conferral.
2. ⭐ **`ADR-0151`'s decision does not depend on it.** Its 22 parameters are `MM-CFG-*` and `LCFG-*`, whose
   owning registers genuinely carry **no** write-authority column — ⭐ the measurement is wrong as a *global*
   statement while remaining correct for the set `ADR-0151` actually allocated. ⛔ **No conclusion of
   `ADR-0151` is disturbed**, and ⛔ it is **not** reopened.
3. ⭐ Recording the defect openly is the lawful response; ⛔ silently editing around it is not.

⭐ **Carried as `G-5`, owner: Architecture Owner.** ⛔ Not closed here.

---

## 7. What this ADR does NOT decide

⛔ **It does not allocate the remaining 65 of 104 parameters.** 104 − 22 (`ADR-0151`) − 17 (this ADR) = **65**:
`CFG-1`…`12` (`PRD-001`), `ICFG-1`…`10`, `SCFG-1`…`11`, `SMCFG-1`…`7`, `SEAT-CFG-001`…`018`, and the **7** held
`ATT-CFG-*`. ⭐ Each needs the same act, by the same route.

⛔ **It does not make `BC-25` design-ready, and does not authorise `DD-0007`.** It advances Declaration 3 from
**22/104** to **39/104**; ⛔ **D3 remains `PARTIAL`** and `DD-0007` remains **NOT design-ready**.

⛔ **It does not close `CNF-GAP-002` or `CNF-GAP-007`** — both remain **OPEN** at **Stage 6**, Technical Owner.
⛔ **It does not amend `PRD-006`, `PRD-023`, `PRD-001` or `CONFIGURATION_GUIDE.md`.**
⛔ **It does not define *"commercial configuration"* as a general closed set** — it classifies **these 17** and
nothing else, exactly as `ADR-0151` §7 confined itself to its 22.
⛔ **It does not resolve `DD7-GAP-003`** *(whether `BC-25` owns a configuration surface at all, or each owning
module renders its own)*. ⚠️ `DD-0003` `S-L8` renders these 24 as a **`BC-06`** surface; ⭐ that question is
untouched, and this ADR allocates **authority**, ⛔ not a surface.
⛔ **It does not resolve `DD7-GAP-013`** *(the manifest cannot express per-app port granularity)*.
⛔ **It does not correct `G-5`** (§6).
⛔ **It creates no design artifact and authorises no implementation.** ⚠️ In particular, `ATT-CFG-018`'s
operational use remains blocked by **`ATT-FR-080`**, and `ATT-CFG-016` by **`ATT-FR-064`** — ⛔ allocating
authority over a parameter does **not** implement or unblock the workflow it configures.

---

## 8. Options considered and rejected

| # | Option | Why rejected |
|---|---|---|
| **O-1** | Amend `ADR-0151` to add these 17 | ⛔ It is **`Accepted`**. `ADR-0151` §7 anticipated successors — *"Each needs the same act"* — and the `ADR-0149` → `ADR-0150` chain is the established succession shape. ⛔ Amending an Accepted ADR to extend its scope would rewrite a decision rather than make a new one |
| **O-2** | Derive `READ` from the §16.3 `WRITE` column | ⛔⛔ **`CNF-BR-010`** forbids it in terms. ⭐ `ADR-0151` §2.2 limb B demonstrates the derivation would be wrong: `TR-3` write DENY on 22, read ALLOW on 13 |
| **O-3** | Apply **`Scope = Library`**, as first proposed | ⛔⛔ **Contradicts three frozen `MUST` requirements** — `ATT-FR-032`, `ATT-FR-041`, `ATT-FR-042` (§3.2). ⭐ Reported as a conflict and returned to the Product Owner, who decided `Tenant` |
| **O-4** | Read §19.2's `tenantWide` as the resolution scope | ⛔ **Wrong axis** — `ATT-FR-005` permission scopes and `CNF-FR-009` resolution scopes are different registers (§3.3). ⭐ The `Tenant` decision rests on `ATT-FR-032`/`041`/`042`, ⛔ not on `tenantWide` |
| **O-5** | Amend `PRD-006` §16.3 to carry the full matrix | ⛔ **FROZEN v1.9** at Rank 3 (`ADR-0034`). ⛔ Amending a frozen PRD to fit a downstream decision is precisely what `PRD_LIFECYCLE` Stage 8 governs, and the instruction forbade it |
| **O-6** | Mint `PERM-*` identifiers for the 17 | ⛔ **`AUTH-7.22`** closed at zero; **`ADR-0043` L177**; **`ADR-0132`** §7 prerequisites unmet. ⭐ Unnecessary — allocation does not require minting (§3.4) |
| **O-7** | Allocate all **24** `ATT-CFG-*` in one act | ⛔ Would require deciding the **4** Face parameters across an unresolved V1/V3 boundary and the **3** authorization-semantic parameters without the Authorization Owner — ⭐ the invention this ADR exists to avoid |
| **O-8** | Correct `ADR-0151` §1's *"0 of 104"* in passing | ⛔ **Architecture Owner's act**, not this conferral's (§6). ⭐ Carried as `G-5` |

---

## 9. Execution

⭐⭐ **This ADR is self-executing at Rank 2 and requires no downstream amendment.**

⛔ **There is no `PRD-023` amendment step** — `CNF-BR-008` forbids the table's presence there (§3.5).
⛔ **There is no `PRD-006` amendment step** — it is FROZEN, and this ADR changes **no parameter definition**,
default, range or validation rule; ⭐ only who may act on one.

⚠️ **Consequently `PRD_LIFECYCLE.md` §4 is NOT engaged** — no frozen PRD changes version, so ⛔ no
`DOCUMENTATION_BASELINE` re-issue, ⛔ no `TRACEABILITY_MATRIX` re-measurement, ⛔ no `PRD_REGISTRY` advance.
⭐ **Same posture as `ADR-0151` §9**, and for the same reason: manufacturing those updates would record a change
that did not occur.

⭐ **`DD-0007` cites this ADR as the Declaration 3 source for these 17 parameters**, alongside `ADR-0151` for
its 22. ⭐ That `DD-0007` amendment is the **only** downstream documentation change, and it is an **Unranked**
design document.

---

## 10. Number allocation

⭐ **`ADR-0153` is allocated by measurement, not by assumption.** Highest file on disk: **`ADR-0152`**.
`ADR-0153` was probed repository-wide before authoring: **0** occurrences in `docs/`, and **0** files named
`ADR-0153`. `ADR-INDEX` **L206**'s rule *"Never reuse a number"* is satisfied. ⛔ No number is reserved for
future use by this act.

---

## 11. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-19 | ⭐⭐ **Created and `Accepted`. The `BC-25` Configuration authorization allocation is extended to 17 `ATT-CFG-*` parameters** — `ATT-CFG-001`…`012` and `ATT-CFG-017`…`021` — under a **joint Product Owner + Authorization Owner** one-act conferral. ⭐⭐ **The allocation: `READ` = `TR-1` + `TR-2` + `TR-3`; Commercial = `NOT COMMERCIAL`; Scope = `Tenant`** — for all 17. ⭐ **`WRITE` is CONSUMED, not decided** — taken as-is from FROZEN `PRD-006` §16.3 (`TR-1` on 16; **`TR-1` + `TR-2` on `ATT-CFG-008`** per `D-12`), and ⛔ **not widened, narrowed or restated as new authority**. ⭐⭐ **`READ` was DECIDED, ⛔ NOT DERIVED** — `CNF-BR-010` forbids inferring read from write, and the result is visibly independent: `TR-2`/`TR-3` hold `READ` where `WRITE` is denied on **16 of 17**, which `CNF-FR-081` renders **read-only** (§2.5). ⚠️⚠️ **A first formulation proposed `Scope = Library`; it was REPORTED AS A CONFLICT AND NOT APPLIED**, because `ATT-FR-032`, **`ATT-FR-041`** and **`ATT-FR-042`** each say *"**MUST** be configurable **per tenant**"* — ⭐ including for `ATT-CFG-010` *"Library coordinates"*, whose **name is not a scope declaration** (§3.2). ⭐ The Product Owner then decided **`Tenant`**, consistent with all three; ⛔ **no frozen text was bent to fit a decision**. ⛔⛔ **SEVEN PARAMETERS ARE HELD AND RECEIVE NOTHING** — `ATT-CFG-013`/`015`/`016` and **`014`** *(Face, V1/V3 boundary; `ADR-0021` requires **security input** for `014`)*, plus **`022`**, **`023`**, **`024`** *(**authorization-semantic** — `022` gates `TR-2`/`TR-3` correction rights and `024` gates `TR-5` parent visibility, per §19.2 **L1980**/**L1983**; both need the **Authorization Owner**)*. ⭐ **The existence of a `WRITE` role was NOT treated as sufficient to allocate them.** ⭐ Declaration 3 coverage **22/104 → 39/104**; ⛔ **D3 remains `PARTIAL`** and ⛔ **`DD-0007` remains NOT design-ready**. ⚠️⚠️ **`G-5` is DISCLOSED AND NOT CORRECTED** — `ADR-0151` §1's *"0 of 104 parameters carries a write-authority declaration"* is inaccurate *(the true figure is **24 of 104**, these very parameters)*, ⛔ but correcting an `Accepted` Rank 2 ADR is an **Architecture Owner** act outside this conferral, and ⛔ **no conclusion of `ADR-0151` is disturbed** (§6). ⛔⛔ **PRESERVED BYTE-UNCHANGED:** `ADR-0151` · `ADR-0152` · `ADR-0132` · `ADR-0043` · `PRD-006` · `PRD-023` · `PRD-001` · `AUTH-7.22` *(catalogue still **zero**)* · `CONFIGURATION_GUIDE.md` · the **104**-parameter inventory · the **24**-entry `ATT-CFG-*` register. ⛔ **0 `PERM-*` · 0 roles · 0 action classes · 0 scope classes · 0 parameters · 0 permission hierarchies · 0 frozen documents modified · 0 baseline re-issue · 0 lines of runtime code.** ⛔ **`CNF-GAP-002` and `CNF-GAP-007` remain OPEN at Stage 6**; ⛔ `DD7-GAP-003` and `DD7-GAP-013` untouched. |
