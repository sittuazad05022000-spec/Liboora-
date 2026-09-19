# ADR-0151 — The **`BC-25` Configuration authorization allocation** is established for the **22-parameter `MM-CFG-*` / `LCFG-*` subset**, by **derived capability**

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-19 |
| **Date** | 2026-09-19 |
| **Deciders** | **Product Owner** *(the substantive allocation: the commercial classification of each parameter, the `TR-3` read decision, and the `TR-2` scope answer)* **and Authorization (`BC-18` / `PRD-001`) Owner** *(review and formalisation against the frozen authorization model)*, **jointly**, each under a **one-act conferral** of the human principal of this engagement, ⛔ **reverting on completion** (`ADR-0033` §7.1: *"a conferral for one act is not a standing licence"*) |
| **Authority instrument** | ⭐⭐ The Product Owner's decision, recorded **verbatim** at §2.2 and tabulated at §2.3 — the three already-resolved limbs (*"`TR-1` Owner: ALLOW WRITE at Tenant and Library scope"*; *"`TR-3` Reception: WRITE = DENY for all selected configuration parameters"*; *"No tenant role may WRITE at Platform Default scope"*), the **commercial classification of all 22**, the **`TR-3` READ** decision for all 22, and *"TR-2 commercial restriction at Tenant scope: **YES**"*. ⭐ The Authorization Owner conferral is recorded **in this ADR**, the instrument that exercises it — ⛔ **no standalone conferral artifact is created**, per the measured repository practice (**0** standalone conferral records) and the `ADR-0150` precedent |
| **Amends** | ⛔⛔ **NOTHING IS EDITED BY THIS ADR.** No file outside this one changes. It is **declaratory and constitutive**: it records a decision and allocates authority under mechanisms that already exist. ⛔ **`PRD-023` is NOT amended** — and it **could not be**, because `CNF-BR-008` forbids that module to hold a role×parameter table (§3.4) |
| **Baseline** | ⛔ **No baseline re-issue by this ADR.** No Rank 1–5 document changes here (`DOCUMENTATION_BASELINE.md` §7 **rule 4**) |
| **Closes** | ⭐ **`PO-CFG-A`** *(commercial classification of the 22)* · ⭐ **`PO-CFG-B`** *(`TR-3` read)* · ⭐ **`PO-CFG-C`** *(`TR-2` scope reach = YES)* · ⭐ **`PO-CFG-D`** *(`LCFG-*` scope evidence — closed for 12 of 13 and **disclosed as a conflict** for `LCFG-1`, §5)* |
| **Does NOT close** | ⛔ **`DD-0007` Declaration 3 for `BC-25` as a whole** — this allocation covers **22 of 104** parameters (§7) · ⛔ **`CNF-GAP-001`** *(aggregate ownership contested)* · ⛔ **`CNF-GAP-002`**, `003`, `004`, `005`, `006`, `007`, `008` · ⛔ the **UI Design System** and **`NFR Budgets (V1)`** absences (`PRD-023` §14.1) · ⛔ **`CNF-D-1`** and **`CNF-D-2`**, the two follow-ups this ADR *raises* (§6) |
| **Related** | `ADR-0150` *(the `BC-02` allocation — the pattern this ADR reuses; **preserved unchanged**)* · `ADR-0149` · `ADR-0132` *(`AUTH-7.22` audited at zero; derived capability the lawful route)* · `ADR-0043` *(**"do not invent a new permission ID"**)* · `ADR-0017` *(`BC-25` ownership; §3.1 item 6 — the `LCFG-*` definitions stay in `PRD-002`)* · `ADR-0053` *(`PRD-023` v0.1 baseline)* · `ADR-0033` §7.1 *(one-act conferral)* |

> ⭐⭐ **`AUTH-7.22` REMAINS CLOSED AT ZERO ENUMERATED PERMISSIONS.** ⛔ This ADR mints **no** permission
> identifier, **no** `PERM-*` token, **no** action class, **no** scope class, **no** role, **no** event, **no**
> aggregate, **no** BC Map row, **no** edge, **no** configuration identifier, and **no** entry in any `CNF-*`,
> `MM-CFG-*` or `LCFG-*` register.
> ⛔ **`ADR-0132` is NOT reopened, amended or superseded, and NONE of its §7 prerequisites is engaged.**
> ⛔ **0 lines of runtime code.**

---

## 1. Context

`PRD-023` (`FROZEN` v0.1, Rank 3) specifies the `BC-25` resolution machinery for **104** configurable parameters
owned by **eight** other FROZEN PRDs. Its §12 *"UI/UX requirements"* fixes seven surface obligations
(`CNF-FR-076`…`CNF-FR-082`), of which **`CNF-FR-081`** is the binding one for design:

> *"A parameter the current actor may read but not write (`CNF-BR-010`) **SHALL** be presented as **read-only**,
> not hidden and not presented as editable-then-refused."*

⭐⭐ **That requirement cannot be satisfied without a per-parameter, per-role authority statement — and no such
statement existed.** The absence was measured, not assumed:

| Measurement | Result |
|---|---|
| `PRD-023` holds a role×parameter table? | ⛔ **No — and it is FORBIDDEN to.** `CNF-BR-008`: *"This module **SHALL NOT** hold a table of which role may write which parameter"* |
| Authority delegated to the owning PRD? | ⭐ Yes — `CNF-BR-008`: *"determined by the parameter's **owning PRD**, at the **scope** of the write, by `BC-18`"* |
| Owning PRDs supply it? | ⛔ **No.** Word-anchored sweep of all 8 owning registers: **0** of 104 parameters carries a write-authority declaration. `PRD-005` §13.4's columns are `ID · Configurable · Default · Notes` — **no authority column** |
| `CONFIGURATION_GUIDE` `Owner` column supplies it? | ⛔ **No — wrong axis.** Guide §1 defines it as *"who **owns the decision to change it**"*, and its values are `Product` / `Security` / `Engineering`. Measured **0** occurrences of `TR-1`…`TR-5` in the entire guide |
| *"Commercial configuration"* defined as a closed set? | ⛔ **No.** Used as a criterion **19** times repository-wide; defined **0** times |

⭐ So the missing thing was a **decision**, not a reading. ⛔ Deriving it would have breached `AP-4` / `AUTH-7.7`
(*"No permission is derived from role naming, **hierarchy, seniority** or similarity"*) and `AUTH-7.28`
(*"Permissions **MUST NOT** form a hierarchy"*).

⭐⭐ **This ADR does not solve that by cleverer reading. It records an explicit Product Owner decision**, obtained
after the blockers were reported and refused resolution twice.

### 1.1 Why this subset, and why it is not arbitrary

⭐ The 22 parameters are **`MM-CFG-001`…`009`** (9) and **`LCFG-1`…`LCFG-13`** (13). They were selected as the
**smallest set that makes one configuration surface designable**, on the `ADR-0149` precedent — which allocated
**2 of 11** `MM-PO-*` operations before `ADR-0150` completed the set. ⛔ **Partial allocation is an established
lawful shape in this repository, not an expedient invented here.**

⚠️ **Identifier form, corrected by measurement.** The request under which this work was commissioned wrote
`LCFG-001…LCFG-013`. ⛔ That form does not exist: `LCFG-0\d\d` returns **0** occurrences repository-wide, while
`LCFG-1`…`LCFG-13` are all present. **This ADR uses the authoritative form throughout.**

---

## 2. The Product Owner decision

### 2.1 The three limbs already resolved from frozen text — accepted, not re-decided

⭐ These three were **derivable from frozen Rank-3 text** and were reported as already-resolved before the
Product Owner was asked for anything. The Product Owner **accepted** them; this ADR records the source so the
acceptance can be checked rather than trusted.

| # | Limb | Frozen source | Rank |
|---|---|---|---|
| **A-1** | **`TR-1` Owner = ALLOW WRITE at Tenant and Library scope** | `PRD-001` v2.0 **L594**: *"Complete operational authority within the library: **configuration**, staff role assignment and revocation…"* | 3 |
| **A-2** | **`TR-3` Reception = DENY WRITE on all 22** | `PRD-001` v2.0 **L612**: *"**Cannot alter library configuration.**"* — unqualified; ⛔ no subject carve-out | 3 |
| **A-3** | **No tenant role may WRITE at Platform Default scope** | `CNF-FR-020`: *"**SHALL NOT** be writable at runtime by any actor, **including a platform role**"*; `CNF-BR-009`; `AUTH-2.9`: *"No tenant role, including Owner, **MAY** confer any platform-level permission"* | 3 |

### 2.2 The Product Owner decision, verbatim

> *"**A. COMMERCIAL CLASSIFICATION** — For each of the 22 parameters, classify COMMERCIAL or NOT COMMERCIAL.
> Use the parameter's actual documented purpose/meaning. Do not infer from UI, role hierarchy, implementation, or
> parameter name alone. 'Commercial' here means whether `PRD-001`'s `TR-2` restriction 'Cannot alter
> library-level commercial configuration' applies to that parameter."*
>
> *"**COMMERCIAL:** `MM-CFG-001`, `MM-CFG-007`, `MM-CFG-009`, `LCFG-3`.
> **NOT COMMERCIAL:** all remaining `MM-CFG-002`…`006`, `MM-CFG-008`; `LCFG-1`, `2`, `4`…`13` except `LCFG-3`."*
>
> *"**B. TR-3 READ** — The existing rule is `TR-3` WRITE = DENY. **Read must be decided independently.**
> ALLOW: `MM-CFG-001`, `002`, `003`, `004`, `006`, `008`, `LCFG-1`, `2`, `3`, `4`, `5`, `9`, `10`.
> DENY: `MM-CFG-005`, `007`, `009`, `LCFG-6`, `7`, `8`, `11`, `12`, `13`."*
>
> *"**C. TR-2 SCOPE** — Does `TR-2`'s commercial-configuration restriction apply to Tenant scope as well as
> Library scope? **YES.** Therefore `TR-2` must not WRITE commercial configuration at Tenant or Library scope.
> Non-commercial configuration remains subject to the existing authorization model."*
>
> *"Do not create any new permission IDs. Do not modify `AUTH-7.22`. Do not modify frozen PRDs."*

⭐⭐ **Limb B is the one that shows the decision was made rather than copied.** `CNF-BR-010` requires read to be
decided independently of write — *"Read authority **SHALL NOT** be assumed to follow write authority"* — and the
Product Owner did exactly that: `TR-3` write is **DENY on all 22**, yet read is **ALLOW on 13**. ⛔ A derivation
would have produced DENY on all 22 and would have been wrong.

### 2.3 The complete allocation — every parameter, every role, every action, every scope

⭐ **Action classes used: `Read`, `Update` only.** ⛔ Both pre-exist at `prd-v2/07` `AUTH-7.24`; **none is created.**
⭐ **Scope classes used: `Tenant`, `Library`, `Platform default`.** ⛔ All three pre-exist at `PRD-023` §3.1
`CNF-FR-009`; **none is created.**

Legend: **W** = Update (write) · **R** = Read · ✅ ALLOW · ⛔ DENY · ⚪ **N/A — not writable by anyone**
(`CNF-FR-020`)

| Parameter *(owning PRD)* | Scope | Commercial | `TR-1` W | `TR-2` W | `TR-3` W | `TR-3` R |
|---|---|---|---|---|---|---|
| `MM-CFG-001` Tenant default currency *(`PRD-005`)* | `Tenant` | ⭐ **COMMERCIAL** | ✅ | ⛔ | ⛔ | ✅ |
| `MM-CFG-002` Max staleness, cached enrollment state *(`PRD-005`)* | `Tenant` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ✅ |
| `MM-CFG-003` Max back-dating of `startDate` *(`PRD-005`)* | `Tenant` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ✅ |
| `MM-CFG-004` Max forward-dating of `startDate` *(`PRD-005`)* | `Tenant` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ✅ |
| `MM-CFG-005` Idempotency record retention *(`PRD-005`)* | `Tenant` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ⛔ |
| `MM-CFG-006` Tenant timezone *(`PRD-005`)* | `Tenant` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ✅ |
| `MM-CFG-007` `PendingPayment` auto-void window *(`PRD-005`)* | `Tenant` | ⭐ **COMMERCIAL** | ✅ | ⛔ | ⛔ | ⛔ |
| `MM-CFG-008` Expiring-soon threshold *(`PRD-005`)* | `Tenant` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ✅ |
| `MM-CFG-009` Re-derive whole term on delayed payment *(`PRD-005`)* | `Tenant` | ⭐ **COMMERCIAL** | ✅ | ⛔ | ⛔ | ⛔ |
| `LCFG-1` Time Zone *(`PRD-002`)* | ⚠️ `Tenant` **(§5 CONFLICT)** | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ✅ |
| `LCFG-2` Language *(`PRD-002`)* | `Library` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ✅ |
| `LCFG-3` Currency *(`PRD-002`)* | `Library` | ⭐ **COMMERCIAL** | ✅ | ⛔ | ⛔ | ✅ |
| `LCFG-4` Date Format *(`PRD-002`)* | `Library` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ✅ |
| `LCFG-5` Member Directory *(`PRD-002`)* | `Library` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ✅ |
| `LCFG-6` Discovery index propagation *(`PRD-002`)* | `Platform default` | NOT COMMERCIAL | ⚪ | ⚪ | ⚪ | ⛔ |
| `LCFG-7` Gallery images per branch *(`PRD-002`)* | `Library` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ⛔ |
| `LCFG-8` Facilities in reference list *(`PRD-002`)* | `Library` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ⛔ |
| `LCFG-9` Floors per branch *(`PRD-002`)* | `Library` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ✅ |
| `LCFG-10` Zones per floor *(`PRD-002`)* | `Library` | NOT COMMERCIAL | ✅ | *existing model* | ⛔ | ✅ |
| `LCFG-11` Preserved intent TTL *(`PRD-002`)* | `Platform default` | NOT COMMERCIAL | ⚪ | ⚪ | ⚪ | ⛔ |
| `LCFG-12` Public search page size *(`PRD-002`)* | `Platform default` | NOT COMMERCIAL | ⚪ | ⚪ | ⚪ | ⛔ |
| `LCFG-13` Public preview cache TTL *(`PRD-002`)* | `Platform default` | NOT COMMERCIAL | ⚪ | ⚪ | ⚪ | ⛔ |

**Mechanically verified totals — 22 parameters, no duplicates, no omissions:**

| Dimension | Count |
|---|---:|
| **Scope — `Tenant`** | **10** *(`MM-CFG-001`…`009` + `LCFG-1`)* |
| **Scope — `Library`** | **8** *(`LCFG-2`, `3`, `4`, `5`, `7`, `8`, `9`, `10`)* |
| **Scope — `Platform default`** | **4** *(`LCFG-6`, `11`, `12`, `13`)* |
| **COMMERCIAL** | **4** |
| **NOT COMMERCIAL** | **18** |
| **`TR-3` READ ALLOW** | **13** |
| **`TR-3` READ DENY** | **9** |
| **TOTAL** | **22** |

⭐ `Tenant` 10 + `Library` 8 + `Platform default` 4 = **22**. COMMERCIAL 4 + NOT COMMERCIAL 18 = **22**.
READ ALLOW 13 + DENY 9 = **22**. ⭐ The READ partition is **exhaustive and disjoint** against the parameter set.

### 2.4 ⭐ Why *"existing model"* is written where `TR-2` is not denied

⛔ **This ADR does NOT grant `TR-2` write on the 18 non-commercial parameters.** The Product Owner's words are
*"Non-commercial configuration **remains subject to the existing authorization model**"* — which is a statement
that **this act does not disturb** that question, not a grant.

⚠️ Writing ✅ in those cells would have been an **invention**: `PRD-001`'s `TR-2` row states a *restriction*
(*"Cannot alter library-level commercial configuration"*) and a positive scope (*"Operational only… Entire
library, excluding commercial configuration"*), and turning the absence of a prohibition into an affirmative
grant is precisely the deny-by-default breach `AP-3` and README §2B.4 rule 4 forbid. ⭐ **The cell is therefore
`*existing model*` — neither ALLOW nor DENY — and any surface must resolve `TR-2` through `BC-18` at request
time, not from this table.**

---

## 3. Authorization treatment

### 3.1 Every invariant re-verified against this allocation

| # | Invariant | Source | Verified |
|---|---|---|---|
| 1 | Permission catalogue closed at **zero** enumerated permissions | `AUTH-7.22` | ⭐ **YES** — 0 `PERM-*` minted; `prd-v2/07` byte-unchanged |
| 2 | No permission from naming, hierarchy or seniority | `AP-4` / `AUTH-7.7` | ⭐ **YES** — every cell traces to an explicit decision or a frozen sentence; ⛔ no *"and above"* reading |
| 3 | Permissions **MUST NOT** form a hierarchy | `AUTH-7.28` | ⭐ **YES** — `TR-1` ALLOW does **not** imply `TR-2`; `TR-2` DENY does **not** imply `TR-3` DENY. Each stated independently |
| 4 | Every grant carries a scope | `AUTH-7.26` | ⭐ **YES** — every row carries `Tenant`, `Library` or `Platform default` |
| 5 | Scopes narrow, never widen | `AUTH-7.29` | ⭐ **YES** — and it is **load-bearing** here: it is the reason `TR-2`'s restriction reaches Tenant scope (§3.2) |
| 6 | Action classes granted independently | `AUTH-7.24` / `AUTH-7.25` | ⭐ **YES** — `Read` and `Update` decided separately for `TR-3`, per `CNF-BR-010` |
| 7 | Deny by default | `AP-3` | ⭐ **YES** — §2.4; unstated is **not** granted |
| 8 | Reception denied financial permissions **regardless of other roles** | `AC-7.8` | ⭐ **YES** — §3.3 |
| 9 | Platform-default scope not writable at runtime by any actor | `CNF-FR-020` | ⭐ **YES** — 4 parameters marked ⚪, §3.5 |
| 10 | No tenant role confers platform-level permission | `AUTH-2.9` / `CNF-BR-009` | ⭐ **YES** — §3.5 |
| 11 | `BC-25` holds no role×parameter table | `CNF-BR-008` | ⭐ **YES** — the table lives **here**, at Rank 2, §3.4 |
| 12 | `BC-25` defines no role or role authority | `CNF-XC-014` | ⭐ **YES** — `PRD-023` untouched |
| 13 | `BC-25` does not re-define the 104 parameters | `CNF-XC-001` / `CNF-XC-002` | ⭐ **YES** — every parameter **cited**, none defined, re-ranged or re-defaulted |
| 14 | `LCFG-*` definitions stay in `PRD-002` | `ADR-0017` §3.1 item 6 | ⭐ **YES** — `Library_PRD_v1.md` byte-unchanged |
| 15 | Do not invent a new permission ID | `ADR-0043` **L177** | ⭐ **YES** — 0 created |

### 3.2 ⭐⭐ Why `TR-2`'s restriction reaches **Tenant** scope — the reasoning, not just the answer

`PRD-001` phrases the restriction as *"Cannot alter **library-level** commercial configuration"*, yet all nine
`MM-CFG-*` resolve at **scope 2 (Tenant)** (`PRD-023` §3.1). ⚠️ A literal reading of *"library-level"* could be
argued to leave Tenant scope untouched.

⛔ **That reading is unlawful, and the Product Owner's YES is the only coherent answer:**

1. ⭐⭐ **`AUTH-7.29` — *"Scopes MUST narrow, never widen."*** Answering NO would give `TR-2` authority at the
   **broader** scope (Tenant) that it is denied at the **narrower** one (Library). That is a widening, and it is
   exactly the direction the rule forbids.
2. ⭐ **It would make the restriction evadable by scope selection** — a Manager blocked from `LCFG-3` at Library
   scope could achieve the same effect via `MM-CFG-001` at Tenant scope. A restriction defeated by choosing a
   different scope is not a restriction.
3. ⭐ **`prd-v2/02` L200 states the scope limb without qualification** — *"Operational only… Entire library,
   **excluding commercial configuration**"*. The exclusion is on subject matter, not on scope level.

⚠️ **This is recorded as reasoning in support of a decision the Product Owner made, ⛔ not as a derivation
substituting for one.** The question was put, and it was answered.

### 3.3 ⭐ `TR-3` read on the two payment parameters — DENIED, and why that is `AC-7.8` and not caution

`MM-CFG-007` and `MM-CFG-009` are **READ DENY**, not merely write-deny.

`AC-7.8`, verbatim: *"A Reception holder is denied financial permissions **regardless of other roles held
anywhere**."* `prd-v2/02` **L177** independently denies `TR-3` *"revenue and financial data"*.

⭐ `MM-CFG-007` governs the window in which an unpaid sale is auto-voided; `MM-CFG-009` governs whether a
delayed payment re-derives the whole paid term. ⛔ Both are financial data. Granting read would be the **soft
breach** `ADR-0150` §4.1 expressly refused for `MM-PO-008` — upholding `AC-7.8` *literally* rather than
qualifying it — and this ADR applies the same standard rather than a laxer one.

⭐⭐ **By contrast, `MM-CFG-001` / `LCFG-3` Currency is COMMERCIAL for write but READ = ALLOW.** The desk must
render amounts in the correct denomination to serve a person. ⛔ Currency is a *denomination*, not a revenue
figure, so `AC-7.8` is not engaged by reading it. ⭐ This asymmetry is exactly what `CNF-BR-010` exists to
permit, and it is what makes `CNF-FR-081`'s read-only rendering meaningful rather than vacuous.

### 3.4 ⭐⭐ Why this table is here and not in `PRD-023` — a structural requirement, not a preference

⛔ **`PRD-023` could not host this allocation even if amended.** `CNF-BR-008`: *"This module **SHALL NOT** hold a
table of which role may write which parameter."* `CNF-XC-014`: *"The module **MUST NOT** define, amend, extend,
interpret or store the definition of any role, nor the authority attached to one."*

⭐ So the lawful home is a **Rank 2 ADR**, which is what this is. ⭐⭐ **This is a genuine structural difference
from `ADR-0150`**, whose allocation *was* executed into Rank 3 (`PRD-005` §16.3b) because `PRD-005` has no
equivalent prohibition. ⛔ **No `PRD-023` amendment follows from this ADR** — see §7.

### 3.5 ⭐⭐ The four Platform-default parameters receive **no** effective tenant-role write authority

`LCFG-6`, `LCFG-11`, `LCFG-12` and `LCFG-13` resolve at **scope 1**. `CNF-FR-020` makes scope 1
*"**SHALL NOT** be writable at runtime by any actor, **including a platform role**"*.

⛔ **Therefore `TR-1`'s ALLOW does not reach them.** Their write cells are ⚪ **N/A**, not ✅.

⚠️⚠️ **Stating this explicitly matters.** The Product Owner's limb A-1 reads *"`TR-1` Owner: ALLOW WRITE at
Tenant and Library scope"* — and these four are at **neither**. Writing ✅ for `TR-1` across all 22 would have
appeared to grant a write that `CNF-FR-020` and `AUTH-2.9` forbid. ⭐ **4 of 22 therefore need no role decision
at all**, and the allocation is *narrower* than a careless transcription would have produced.

⭐ Their `TR-3` READ = DENY is retained as a **read** decision, which is unaffected by write immutability.

### 3.6 ⭐ Why this is an *allocation*, not a *minting* — `ADR-0132` §7 stays closed

`ADR-0132` §7 fixes seven prerequisites for **minting** a permission identifier. ⛔ **None is engaged**, because
minting and allocating are different acts:

| Minting *(`ADR-0132` §7)* | Allocating *(this ADR)* |
|---|---|
| Creates a **new named permission** in a catalogue | ⛔ Creates nothing; names **no** identifier |
| Requires prerequisite 7's hard gate on `ADR-0043` §5.1 | ⛔ Not reached — nothing is named |
| Changes the size of the permission catalogue | ⛔ Catalogue stays at **zero** (`AUTH-7.22`) |
| — | ⭐ States which **existing role** may exercise an **existing action** on an **existing parameter** at an **existing scope**, evaluated by `BC-18` at request time and **stored nowhere** |

⭐ This is the identical distinction `ADR-0150` §3.3 drew, applied to a second bounded context. ⛔ The result is
the same: `AUTH-7.22` remains closed at zero.

---

## 4. What is NOT created

⛔ **0** `PERM-*` identifiers · ⛔ **0** new action classes *(only `Read`, `Update` — both pre-existing)* ·
⛔ **0** new scope classes *(only `Tenant`, `Library`, `Platform default` — all pre-existing)* · ⛔ **0** new roles
*(only `TR-1`, `TR-2`, `TR-3` — all `PRD-001` v2.0)* · ⛔ **0** new configuration parameters — the registers stay
at `MM-CFG-001`…`009` (**9**) and `LCFG-1`…`LCFG-13` (**13**) · ⛔ **0** new `CNF-*` identifiers · ⛔ **0** events,
aggregates, edges or BC Map rows · ⛔ **0** lines of runtime code.

⭐ **A closed classification vocabulary is used, not invented:** `COMMERCIAL` / `NOT COMMERCIAL` are the two
values `PRD-001`'s `TR-2` restriction already implies. ⛔ No third value, no severity, no tier.

---

## 5. ⚠️⚠️ `LCFG-1` — a Rank 3 vs Rank 7 CONFLICT, disclosed and NOT silently resolved

⛔⛔ **Two authoritative sources contradict each other on the scope of `LCFG-1` Time Zone.**

| Source | Rank | Text, verbatim |
|---|---|---|
| `Library_PRD_v1.md` **`LIB-16.8`** (L705) | **Rank 3**, `FROZEN` | *"Time Zone **MUST** be a single **tenant-wide** value in V1, and **MUST** be applied to every time-bearing operational rule (`LIB-12.4`)."* |
| `CONFIGURATION_GUIDE.md` §4 (**L829**) | **Rank 7** | *"`LCFG-1`…`LCFG-5` and `LCFG-7`…`LCFG-10` are **per-library settings**, not per-environment. They are set by each library through `BC-25`."* |

⚠️ These are **not reconcilable by reading**: if the timezone is *"a single tenant-wide value"*, a library cannot
set its own; if *"set by each library"*, it is not tenant-wide.

⭐ **Precedence decides the effective value and the ADR says so openly.** Rank 3 outranks Rank 7, and the guide's
own header concedes it is *"Subordinate to the PRDs… it cannot change the envelope."* `LIB-12.4` corroborates
(*"All times **MUST** be stored with an explicit time zone (`LCFG-1`)"* applied to **every** time-bearing rule —
coherent only if one value governs the tenant). ⭐ **Effective scope of `LCFG-1` = `Tenant`.**

⛔⛔ **What this ADR does NOT do:** it does **not** edit `Library_PRD_v1.md`, does **not** edit
`CONFIGURATION_GUIDE.md`, and does **not** declare the guide's sentence void. It **applies precedence for the
purposes of this allocation** and **raises the conflict** for its owner. `DOCUMENTATION_BASELINE.md` §4:
*"A conflict is a defect… do not choose — raise it."*

⭐ **The allocation is unaffected either way.** `LCFG-1` is **NOT COMMERCIAL** and **`TR-3` READ = ALLOW** under
both readings; only the scope label differs, and `TR-1` holds write at **both** Tenant and Library scope
(limb A-1). ⚠️ **This is why the conflict does not block: it changes no cell of the authorization matrix.**

---

## 6. Two follow-ups this ADR raises and does NOT close

| ID | Item | Owner / instrument |
|---|---|---|
| ⭐ **`CNF-D-1`** | **Ratify the `LCFG-1` scope conflict** (§5). Confirm `Tenant` per Rank-3 `LIB-16.8` and record that `CONFIGURATION_GUIDE` L829 is **superseded in effect** for `LCFG-1` only | **Architecture Owner** — a Rank 2 ADR. ⛔ **Not** an in-place guide edit: a Rank 7 document cannot resolve a conflict with Rank 3 by amending itself |
| ⭐ **`CNF-D-2`** | **`PRD-023` §3.1 records *"✔ 9 of the 13 `LCFG-*`"* at scope 3.** With `LCFG-1` displaced to Tenant, the lawful count is **8**. The cited source (`CONFIGURATION_GUIDE` §4 L829) *does* name nine — so the cell was faithful to its source and the source is what conflicts | **Product Owner + Architecture Owner** — a `PRD-023` v0.2 successor amendment under `PRD_LIFECYCLE.md` §4. ⛔ **NON-BLOCKING** for this allocation |

⚠️ **`CNF-D-1` and `CNF-D-2` are raised here, not resolved here.** ⛔ Neither is a `CNF-GAP-*`: that register is
closed at **8** in `FROZEN` `PRD-023` and this ADR extends it by nothing.

⭐⭐ **A correction is recorded rather than buried.** An earlier pass in this chain reported that
`PRD-023` §3.1's *"9 of 13"* claim was **unsupported** and called it a latent defect. ⛔ **That finding was
wrong**: the supporting sentence exists at `CONFIGURATION_GUIDE.md` **L829**, inside §4 exactly where `PRD-023`
cites it. The earlier probe read only the §4 *table* and missed the prose note beneath it. ⭐ The defect was in
the instrument, not the document — and the real issue is the narrower `LIB-16.8` conflict recorded at §5.

---

## 7. What this ADR does NOT decide

⛔ **It does not allocate the other 82 parameters.** 104 − 22 = **82** remain without an operation×role source:
`CFG-1`…`12` (`PRD-001`), `ICFG-1`…`10`, `SCFG-1`…`11`, `SMCFG-1`…`7`, `SEAT-CFG-001`…`018`,
`ATT-CFG-001`…`024`. ⭐ Each needs the same act, by the same route.

⛔ **It does not make `BC-25` design-ready as a whole, and does not authorise `DD-0007`.** It closes
Declaration 3 **for the 22-parameter subset only**. `DD-0007`'s remaining declarations — **1** (Target App) and
**5** (Cross-App dependencies) — are untouched by this ADR and were both `GAP` at last measurement.

⛔ **It does not amend `PRD-023`, `PRD-002`, `PRD-005`, `PRD-001` or `CONFIGURATION_GUIDE.md`.**
⛔ **It does not resolve the `TR-2` position on the 18 non-commercial parameters** (§2.4).
⛔ **It does not define *"commercial configuration"* as a general closed set** — it classifies **these 22** and
nothing else.
⛔ **It does not reopen `ADR-0149`, `ADR-0150`, `PRD-005` v1.6 or `DD-0001`.**
⛔ **It creates no design artifact and authorises no implementation.**

---

## 8. Options considered and rejected

| # | Option | Why rejected |
|---|---|---|
| **O-1** | Read the `CONFIGURATION_GUIDE` `Owner` column (`Product`/`Security`) as the role allocation | ⛔ **Wrong axis.** Guide §1: *"who **owns the decision to change it**"* — a governance office. **0** occurrences of `TR-1`…`TR-5` in the guide. Reading `Security` as a runtime role would invent one |
| **O-2** | Derive `TR-2` from *"cannot exceed Owner permissions"* by subtraction | ⛔ **`AUTH-7.28`** bars permission hierarchies; **`AP-4`** bars derivation from seniority. Subtraction from `TR-1` is a hierarchy by another name |
| **O-3** | Grant `TR-3` read wherever write is denied but the desk plausibly needs it | ⛔ Inference from **UI necessity**, which README §2B.4 rule 4 forbids and `CNF-BR-010` makes a separate decision. The Product Owner decided it explicitly instead |
| **O-4** | Amend `PRD-023` to carry the matrix, as `ADR-0150` amended `PRD-005` | ⛔ **Forbidden by `CNF-BR-008` and `CNF-XC-014`** (§3.4). The `ADR-0150` shape is unavailable here for a structural reason |
| **O-5** | Mint `PERM-*` identifiers for the 22 parameters | ⛔ **`AUTH-7.22`** is closed at zero; **`ADR-0043` L177** *"Do not invent a new permission ID"*; **`ADR-0132`** §7's prerequisites are not met. ⭐ Unnecessary — allocation does not require minting (§3.6) |
| **O-6** | Resolve the `LCFG-1` conflict by editing `CONFIGURATION_GUIDE` L829 | ⛔ A Rank 7 document cannot settle a conflict with Rank 3 by amending itself, and `DOCUMENTATION_BASELINE` §4 forbids choosing. Raised as `CNF-D-1` (§6) |
| **O-7** | Allocate all 104 parameters in one act | ⛔ Would require classifying 82 parameters across 7 further owning PRDs with **no** Product Owner decision in hand — the invention this ADR exists to avoid |

---

## 9. Execution

⭐⭐ **This ADR is self-executing at Rank 2 and requires no downstream amendment.**

⛔ **There is no `PRD-023` amendment step**, because `CNF-BR-008` forbids the table's presence there (§3.4).
⛔ **There is no `PRD-002` or `PRD-005` amendment step**, because `CNF-XC-001` / `CNF-XC-002` and `ADR-0017`
§3.1 item 6 reserve those registers to their owners and this ADR changes **no parameter definition** — only who
may act on one.

⚠️ **Consequently `PRD_LIFECYCLE.md` §4 is NOT engaged** — no frozen PRD changes version, so ⛔ no
`DOCUMENTATION_BASELINE` re-issue, ⛔ no `TRACEABILITY_MATRIX` re-measurement, ⛔ no `PRD_REGISTRY` advance.
⭐ **This is a real difference from the `ADR-0149`/`ADR-0150` chain and it is stated rather than left to
inference:** those ADRs moved Rank 3 text and therefore moved four governance artifacts; this one does not, and
manufacturing those updates would record a change that did not occur.

⭐ Any future `DD-0007` cites **this ADR** as the Declaration 3 source for the 22 parameters.

---

## 10. Number allocation

⭐ **`ADR-0151` is allocated by measurement, not by assumption.** Highest file on disk: **`ADR-0150`**.
`ADR-0151` was probed repository-wide before authoring: **0** occurrences in `docs/`, and **0** files named
`ADR-0151`. `ADR-INDEX` **L206**'s rule *"Never reuse a number"* is satisfied. ⛔ No number is reserved for
future use by this act.

---

## 11. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-19 | ⭐⭐ **Created and `Accepted`. The `BC-25` Configuration authorization allocation is established for the 22-parameter `MM-CFG-001`…`009` / `LCFG-1`…`LCFG-13` subset** — decided explicitly by the **Product Owner**, formalised by the **Authorization (`BC-18`) Owner**, both under one-act conferrals ⛔ **reverting on completion**. ⭐⭐ **The allocation is DECIDED, not derived:** measured **0 of 104** parameters carried any write-authority declaration, *"commercial configuration"* is used as a criterion **19** times and defined **0** times, and the `CONFIGURATION_GUIDE` `Owner` column was **rejected as the wrong axis** (**0** `TR-n` occurrences in that document). ⭐⭐ **`TR-3` READ was decided INDEPENDENTLY of WRITE, as `CNF-BR-010` requires** — write **DENY on all 22**, read **ALLOW on 13** — ⛔ a derivation would have produced DENY on 22 and been wrong. ⭐ **Totals verified mechanically: `Tenant` 10 · `Library` 8 · `Platform default` 4 = 22; COMMERCIAL 4 / NOT COMMERCIAL 18; `TR-3` READ ALLOW 13 / DENY 9**; the read partition is exhaustive and disjoint. ⭐⭐ **The four Platform-default parameters receive NO effective tenant-role write authority** (§3.5) — `CNF-FR-020` makes scope 1 unwritable *"by any actor, including a platform role"*, so `LCFG-6`/`11`/`12`/`13` are ⚪ **N/A**, ⛔ **not** ✅; the allocation is **narrower** than a careless transcription would have produced. ⭐ **`TR-2` is NOT granted the 18 non-commercial parameters** (§2.4) — *"remains subject to the existing authorization model"* is recorded as **`*existing model*`**, ⛔ neither ALLOW nor DENY, because converting the absence of a prohibition into a grant would breach `AP-3`. ⭐ **`TR-2`'s commercial restriction reaches Tenant scope** (§3.2) — answering otherwise would **widen** authority at the broader scope, inverting `AUTH-7.29`. ⭐ **`MM-CFG-007`/`009` READ DENIED under `AC-7.8` read literally**, on the `ADR-0150` §4.1 standard; ⭐ yet Currency is **COMMERCIAL for write, ALLOW for read** — the `CNF-BR-010` asymmetry that makes `CNF-FR-081` meaningful. ⚠️⚠️ **A Rank 3 vs Rank 7 CONFLICT on `LCFG-1` is DISCLOSED, NOT SILENTLY RESOLVED** (§5): `LIB-16.8` *"a single tenant-wide value"* vs `CONFIGURATION_GUIDE` L829 *"per-library settings"*. Precedence gives `Tenant`; ⛔ **neither document is edited**, and the conflict is raised as **`CNF-D-1`** (Architecture Owner) with **`CNF-D-2`** recording that `PRD-023` §3.1's *"9 of 13"* is lawfully **8**. ⭐ **The conflict blocks nothing** — it changes no cell of the matrix. ⭐⭐ **A PRIOR FINDING OF THIS WORK CHAIN IS RETRACTED** (§6): the claim that *"9 of 13"* was unsupported was **wrong** — the sentence exists at `CONFIGURATION_GUIDE` **L829**; the earlier probe read only the §4 table and missed the prose note. ⭐ **The table lives at Rank 2 because `CNF-BR-008` FORBIDS `PRD-023` to hold it** (§3.4) — ⛔ a structural divergence from `ADR-0150`, which is why ⛔ **no PRD amendment, no `PRD_LIFECYCLE` §4 step, no baseline re-issue, no matrix re-measurement and no registry advance follow** (§9). ⛔⛔ **`AUTH-7.22` closed at ZERO; 0 `PERM-*`; no action, scope or role vocabulary created; `ADR-0132` §7 NOT engaged** (§3.6 — allocation ≠ minting). ⛔ **`ADR-0149`, `ADR-0150`, `PRD-005` v1.6 and `DD-0001` untouched.** ⛔ **22 of 104 allocated — 82 remain, and `DD-0007` is NOT authorised** (§7). ⛔ **NOTHING IS EDITED BY THIS ADR. 0 lines of code.** ⭐ Number allocated by measurement (§10). |
