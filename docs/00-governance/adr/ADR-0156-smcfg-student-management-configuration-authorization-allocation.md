# ADR-0156 — `SMCFG-*` Student Management configuration: tenant-scoped authorization for 5 parameters, `SMCFG-3` resolved as a DISTINCT parameter, `SMCFG-5` HELD

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-19 |
| **Rank** | 2 — Architecture Decision Record |
| **Bounded context** | `BC-25` Configuration *(owning)*; `BC-01` Student Management *(source)*; `BC-02` Membership *(adjacent, `SM-2`)* |
| **Supersedes** | ⛔ **NOTHING.** |
| **Superseded by** | — |
| **Authority instrument** | ⭐⭐ **Four decisions**, recorded verbatim at §2 — `SM-1` *(Product Owner + SECURITY PLATFORM)*, `SM-2` *(Architecture + Product)*, `SM-3` *(Product Owner)*, `SM-4` *(Architecture Owner)*. |
| **Decides** | ⭐ **6** of **7** `SMCFG-*` — **5** allocated, **1** (`SMCFG-3`) resolved as **distinct** and allocated |
| **Expressly does NOT decide** | ⛔ `SMCFG-5` · ⛔ `SEAT-CFG-*` · ⛔ `ICFG-*` · ⛔ 7 held `ATT-CFG-*` · ⛔ `CFG-10`/`CFG-12` · ⛔ `SCFG-2`/`SCFG-4` |

---

## 1. Context — ⭐⭐ why the `ADR-0154` / `ADR-0155` route does NOT reach this register

⚠️⚠️ **`SMCFG-*` IS NOT A REPEAT OF `SCFG-*`, AND THE PLATFORM-DEFAULT ROUTE WAS
REFUSED.** `ADR-0154` *(10 `CFG-*`)* and `ADR-0155` *(9 `SCFG-*`)* both rested on
the parameters being **`Platform default`** — sourced for `SCFG-*` from
**`SID-5.45`** *("SHALL be platform-wide")*.

⛔ **`SMCFG-*` is the opposite.** **`SM-8.1`** *(`PRD-004` **L849**)*:

> *"Every query and command **MUST** be **tenant-scoped** server-side; a
> tenant-less store access **MUST** be refused."*

⭐ That places the register in the **`Tenant`** band — the band in which
`AUTH-2.5`, `AUTH-7.13` and `AUTH-7.61` **ARE** engaged, unlike the
platform-level `CFG-*` *(`PRD-023` **L316**)* and `SCFG-*` *(`SID-4.49`)*.

⛔⛔ **Therefore: ⛔ no band inheritance, ⛔ no `WRITE = N/A` inheritance, ⛔ no
`PR-1`/`PR-2` read inheritance.** ⭐ Each was decided independently at §2.

### 1.1 The three gates found by audit

| Gate | Finding | Cleared by |
|---|---|---|
| **`SM-1`** | Band is `Tenant`, ⛔ not `Platform default` | §2.1 |
| **`SM-2`** | ⚠️ **`SMCFG-3` ↔ `MM-CFG-008`** both *"expiring-soon threshold"*; `MM-CFG-008` **already `AUTHORIZED` and DESIGNED** | §2.2 — ⭐ **DISTINCT**, see §2.2a |
| **`SM-3`** | ⚠️ **`SMCFG-5`'s definition is itself undecided** — `SM-GAP-2` | §2.3 — ⛔ **HELD** |

---

## 2. The decisions, recorded verbatim

### 2.1 ⭐⭐ `SM-1` — Product Owner + SECURITY PLATFORM

> For the uncontested tenant-scoped parameters:
> `SMCFG-1`, `SMCFG-2`, `SMCFG-4`, `SMCFG-6`, `SMCFG-7`
>
> Make an explicit authorization decision for `READ` and `WRITE`.
>
> Do **NOT** infer from `SM-8.1` alone.
>
> Determine whether authority belongs to:
> **A)** tenant roles `TR-n` · **B)** platform roles `PR-n` · **C)** both ·
> **D)** another explicitly authorized role set
>
> Use authoritative existing role/authorization evidence.

⭐⭐ **DETERMINATION: (A) TENANT ROLES `TR-n`**, on the authoritative evidence
at §2.1a. ⛔ **Not (B)**, ⛔ **not (C)**, ⛔ **not (D)**.

#### 2.1a ⭐ The authoritative evidence relied on

⭐ **`PRD-023` §9**, quoting **FROZEN `PRD-001` §2** verbatim:

| Role | Verbatim `PRD-001` §2 | `PRD-023` §9 consequence |
|---|---|---|
| **`TR-1` Owner** | *"Complete operational authority within the library: **configuration**, staff role assignment…"* | ⭐ *"**The only tenant role with unrestricted configuration write authority at its library**"* |
| **`TR-2` Manager** | *"**Cannot alter library-level commercial configuration.**"* | ⭐ *"A **partial writer** — the restriction is by **subject**, not by scope"* |
| **`TR-3` Reception** | *"**Cannot alter library configuration.**"* | ⛔ *"**Not a writer**"* |
| **`TR-4` / `TR-5`** | Own records / read-only | ⛔ **Not writers** |

⭐ This is the **same evidence base** `ADR-0151` used for the **9 `MM-CFG-*`**
and **13 `LCFG-*`** at `Tenant`/`Library` scope, and `ADR-0153` for the **17
`ATT-CFG-*`** at `Tenant`. ⭐⭐ **`SMCFG-*` is the fourth application of a
settled route — ⛔ not a new one.**

⛔ **Why NOT (B) or (C):** the owning source names `PR-1`/`PR-2` **ZERO** times,
and **`SM-8.1`** refuses a **tenant-less** access outright. ⛔ A platform-role
read of a tenant-scoped value is a **different question** and is ⛔ **not
decided here**.

### 2.2 ⭐⭐ `SM-2` — Architecture + Product

> Resolve: `SMCFG-3` ↔ `MM-CFG-008`
>
> Determine whether:
> **A)** they are the SAME conceptual parameter and one register entry should
> be retired/merged, **OR**
> **B)** they are genuinely TWO distinct parameters with separate authority.
>
> - Do not silently merge them.
> - Do not silently delete either inventory ID.
> - If merging changes the 104 inventory, explicitly document and reconcile
>   the inventory change before modifying anything.
> - Close `DD7-GAP-005` through the proper governance mechanism.

⭐⭐ **DETERMINATION: (B) — TWO DISTINCT REGISTER ENTRIES, ⛔ NOT MERGED, ⛔ NO
INVENTORY CHANGE.** ⚠️ **But they MUST resolve to ONE VALUE** — see §2.2a.

#### 2.2a ⭐⭐ The frozen text already settles this — it was READ, ⛔ not invented

⭐ **`MM-BR-026`** *(`PRD-005` **L1353**, FROZEN)*:

> *"`MM-CFG-008` **MUST** be the **single threshold** used by both `MM-EVT-006`
> and the expiring-memberships view, so the reminder and the list can never
> disagree."*

⭐⭐ And `PRD-005` **anticipates `PRD-004` explicitly**, at **L1356**:

> *"`PRD-004` `LMD-26` already requires its expiring-soon indicator's threshold
> to be **configurable rather than hard-coded**. **Sharing one configurable**
> keeps the Directory, the operational view and the notification consistent."*

⭐ And **`LMD-26`** *(`PRD-004` **L648**, FROZEN)*:

> *"An expiring-soon indicator **MUST** derive from the **`BC-02` projection**
> and its threshold **MUST** be `SMCFG-3`."*

⭐⭐ **Read together, the two frozen PRDs agree, and neither is bent:**

| Aspect | Determination |
|---|---|
| **Conceptually** | ⭐ **ONE threshold** — both frozen PRDs say so, in terms *("**Sharing one configurable**"; "the **single threshold**")* |
| **As register entries** | ⭐ **TWO IDs, both retained** — `MM-CFG-008` *(`BC-02` owning)* and `SMCFG-3` *(`BC-01` consuming, via the **`BC-02` projection**)* |
| **Authority** | ⭐ **ONE**, already allocated — `ADR-0151` §2.3 on **`MM-CFG-008`** |
| **Inventory** | ⛔⛔ **UNCHANGED at 104** — ⛔ nothing merged, ⛔ nothing retired, ⛔ nothing deleted |

⛔⛔ **WHY MERGING WAS REFUSED.** ⭐ Merging would delete an inventory ID and move
the count to **103**, which the standing instruction forbids absent an express
inventory decision. ⭐ `LMD-26` also **binds the Directory to `SMCFG-3` by name**
in a **FROZEN** document — ⛔ retiring the ID would orphan a frozen `MUST`.

⭐⭐ **`SMCFG-3` is therefore a SOURCED ALIAS, not a second authority.** ⛔ It
gets **no independent write authority**; its value **derives** from
`MM-CFG-008` through the `BC-02` projection *(`LMD-26`)*, and `MM-BR-026`
guarantees they can never disagree.

⭐ **`DD7-GAP-005` is CLOSED by this section** — the relationship it called
*"unstated"* is now stated, and sourced to frozen text.

### 2.3 ⭐⭐ `SM-3` — Product Owner

> Resolve `SM-GAP-2` for `SMCFG-5`: *"enrollment-number format"*
>
> Determine the actual intended definition/default.
>
> If the Product Owner does not resolve the definition:
> **KEEP `SMCFG-5` HELD.**
>
> Do not allocate authority over an undefined parameter.

⭐⭐ **DETERMINATION: ⛔ HELD.** ⭐ **No resolution exists to record.**
**Measured across the repository: `SM-GAP-2` is OPEN in every document that
mentions it, and appears in ZERO ADRs.**

| Source | Wording |
|---|---|
| `PRD-004` **L1168** | ⛔ *"`SMCFG-5`'s default is a **placeholder pending a decision**"* |
| `PRD-004_TRACEABILITY` **L187** | ⛔ *"⚠ **placeholder** — see `SM-GAP-2`", "**undecided**"* |
| `PRD-004_INDEPENDENT_REVIEW` **L583** | ⛔ *"**Remain a gap**"* |
| `PRD-004_INDEPENDENT_REVIEW` **L595** | ⚠️ *"a configurable **should not publish a default** for a parameter the document says is [undecided]"* |
| `DD-0002` **L158** | ⛔ *"**no form**"* — the surface displays but does not configure |
| ADRs | ⛔ **ZERO** |

⛔⛔ **`SMCFG-5` IS HELD.** ⭐ Per the instruction's own terms, authority is
**not** allocated over an undefined parameter.

### 2.4 ⭐⭐ `SM-4` — Architecture Owner

> Explicitly determine `WRITE` treatment for **TENANT**-scoped `SMCFG`
> parameters.
>
> Do **NOT** reuse `ADR-0151` §3.5 merely because it says `N/A` for Platform
> Default.
>
> Determine whether `WRITE` is: `N/A` / not runtime-writable · `DENY` · or an
> explicitly authorized tenant-role `WRITE` allocation.
>
> Do not infer.

⭐⭐ **DETERMINATION: AN EXPLICITLY AUTHORIZED TENANT-ROLE `WRITE`
ALLOCATION** — ⛔ **NOT `N/A`**, ⛔ **NOT blanket `DENY`**.

⛔⛔ **`ADR-0151` §3.5 IS EXPRESSLY NOT REUSED.** ⭐ Its ⚪ `N/A` rests on
**`CNF-FR-020`**, which makes **platform-default** values *"**not writable** at
runtime **by any actor**"*. ⭐ `SMCFG-*` is **`Tenant`**-scoped, so
`CNF-FR-020` **does not reach it** — ⛔ there is no basis for `N/A` here, and
asserting one would be the derivation error this ADR exists to avoid.

⭐ **A tenant `WRITE` therefore exists and had to be allocated**, on the
`PRD-023` §9 evidence at §2.1a.

---

## 2.5 ⭐⭐ The allocation — 6 parameters

⭐ **Scope = `Tenant`** *(`SM-8.1`)* · Legend: ✅ ALLOW · ⛔ DENY · per
`ADR-0151`'s legend.

| # | ID | Parameter | Default | Class | Commercial | `TR-1` W | `TR-2` W | `TR-3` W | `TR-1`/`TR-2`/`TR-3` R | Source |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | `SMCFG-1` | Directory default page size | 20 | Security | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ✅ | §10.3 **L1038** |
| 2 | `SMCFG-2` | Directory maximum page size | 50 | Security | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ✅ | §10.3 **L1039** |
| 3 | ⭐ `SMCFG-3` | Membership expiring-soon threshold | 7 days | Product | NOT COMMERCIAL | ⚠️ **derived** | ⚠️ **derived** | ⛔ | ✅ | §2.2a · `LMD-26` |
| 4 | `SMCFG-4` | Bulk operation record cap | 100 | Security | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ✅ | §10.3 **L1041** |
| 5 | `SMCFG-6` | Documents per student | 10 | Product | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ✅ | §10.3 **L1043** |
| 6 | `SMCFG-7` | Directory export row cap | 1000 | Security | NOT COMMERCIAL | ✅ | ✅ | ⛔ | ✅ | §10.3 **L1044** |
| — | ⛔ `SMCFG-5` | Enrollment number format | ⚠️ *placeholder* | Product | — | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | ⛔ **HELD** | §2.3 · `SM-GAP-2` |

⭐ **6 decided · ⛔ 1 HELD · 7 accounted for.**

⚠️⚠️ **`SMCFG-3`'s `WRITE` is ⚠️ DERIVED, ⛔ NOT INDEPENDENT** — the write lands
on **`MM-CFG-008`** *(already allocated by `ADR-0151` §2.3: `TR-1` ✅, `TR-2`
*existing model*, `TR-3` ⛔, `TR-3` R ✅)*, and propagates through the `BC-02`
projection *(`LMD-26`)*. ⛔ **No second write path is created**; `MM-BR-026`
would forbid one.

### 2.6 ⭐ `TR-2` holds `WRITE`, and that is CONSISTENT, not an expansion

⭐ `TR-2`'s only restriction is *"**Cannot alter library-level COMMERCIAL
configuration**"* — a restriction **by subject**, ⭐ which `PRD-023` §9 states
in terms *("the restriction is by **subject**, not by scope")*. ⭐ **All 6 are
`NOT COMMERCIAL`** *(§2.7)*, so ⛔ **the restriction is not triggered**, and
`TR-2` writes them under the **existing** model — exactly as `ADR-0151` records
*"existing model"* for the non-commercial `MM-CFG-*`. ⛔ **No new authority.**

### 2.7 ⭐ `NOT COMMERCIAL` — tested against `ADR-0151`'s own test

⭐ `ADR-0151` §2.2's test is whether *"`TR-2` cannot alter library-level
commercial configuration"* applies. ⭐ Its **COMMERCIAL** set is
`MM-CFG-001`/`007`/`009` and `LCFG-3` — **currency, payment windows, revenue
re-derivation**. ⭐ The 6 here are **page sizes, a record cap, a document count,
an export cap and a day threshold** — ⛔ **no price, currency, payment, invoice
or revenue semantic**. ⭐ **`NOT COMMERCIAL`**, and `PRD-004` §10.3 independently
classes them **Security** or **Product** — ⛔ never *Commercial*.

---

## 3. Invariants checked

| # | Invariant | Source | Held? |
|---|---|---|---|
| 1 | Permission catalogue closed at zero | `AUTH-7.22` | ⭐ **YES** — **0** `PERM-*` |
| 2 | Library role register closed at five | `AUTH` ch.07 **L87** | ⭐ **YES** — only `TR-1`…`TR-3` named |
| 3 | Platform register untouched | `AUTH` ch.07 **L79** | ⭐ **YES** — ⛔ **0** `PR-n` authority created |
| 4 | `READ`/`WRITE` decided independently | `CNF-BR-010` | ⭐ **YES** — §2.1 and §2.4 are separate acts |
| 5 | `READ` implies no other action | `AUTH-7.24` | ⭐ **YES** |
| 6 | No role hierarchy | `AUTH-7.28` | ⭐ **YES** |
| 7 | Scope sourced, ⛔ not chosen | **`SM-8.1`** | ⭐ **YES** |
| 8 | ⛔ Platform-default `N/A` **NOT** reused | `SM-4`; `CNF-FR-020` | ⭐ **YES** — expressly refused, §2.4 |
| 9 | ⛔ Inventory unchanged | standing instruction | ⭐ **YES** — **104**, §2.2a |
| 10 | Frozen PRDs unmodified | `ADR-INDEX` | ⭐ **YES** — `PRD-004` `93322b23…`, `PRD-005` unchanged |
| 11 | ⛔ No silent merge / no silent delete | `SM-2` | ⭐ **YES** — both IDs retained |
| 12 | Held items ⛔ not advanced | `SM-3` | ⭐ **YES** — `SMCFG-5` untouched |
| 13 | ⛔ Nothing superseded | `ADR-INDEX` step 3 | ⭐ **YES** |
| 14 | `MM-CFG-008` authority unchanged | `ADR-0151` §2.3 | ⭐ **YES** — ⛔ not re-decided, only cited |

---

## 4. Decisions — `D-1` … `D-9`

| ID | Decision |
|---|---|
| **`D-1`** | ⭐ **5** parameters allocated at **`Tenant`** scope — `SMCFG-1`, `2`, `4`, `6`, `7`: **`WRITE` = `TR-1` ✅ + `TR-2` ✅**, **`TR-3` ⛔**; **`READ` = `TR-1` + `TR-2` + `TR-3` ✅**. |
| **`D-2`** | ⭐ Answer to `SM-1` is **(A) tenant roles `TR-n`** — ⛔ not `PR-n`, ⛔ not both. |
| **`D-3`** | ⭐ Scope **`Tenant`**, sourced from **`SM-8.1`**, ⛔ not chosen; ⛔ **`Platform default` is expressly refused**. |
| **`D-4`** | ⭐ Answer to `SM-2` is **(B) two distinct register entries** — ⛔ **not merged**, ⛔ **not retired**, ⭐ **inventory stays 104**; ⭐ but they resolve to **ONE value** via `MM-BR-026` + `LMD-26`. |
| **`D-5`** | ⭐ **`SMCFG-3` is a SOURCED ALIAS** of `MM-CFG-008` — ⭐ readable by `TR-1`/`TR-2`/`TR-3`; ⚠️ its `WRITE` is **derived**, landing on `MM-CFG-008` *(`ADR-0151` §2.3)*; ⛔ **no second write path**. |
| **`D-6`** | ⭐ **`DD7-GAP-005` is CLOSED** — the relationship is stated and sourced to frozen text. |
| **`D-7`** | ⛔ **`SMCFG-5` is HELD** — `SM-GAP-2` is open in **every** source and in **zero** ADRs (`SM-3`). |
| **`D-8`** | ⭐ Answer to `SM-4`: **an explicitly authorized tenant-role `WRITE`** — ⛔ **not `N/A`**, ⛔ **not blanket `DENY`**; ⛔ `ADR-0151` §3.5 **expressly not reused**. |
| **`D-9`** | ⭐ Coverage **58 / 104 → 64 / 104**; ⛔ **40** remain. ⚠️⚠️ **AUTHORIZED ≠ DESIGNED.** |

---

## 5. ⛔ What this ADR does NOT decide

⛔ **`SMCFG-5`** — **Product Owner**, via `SM-GAP-2`.
⛔ **Any `PR-1`/`PR-2` authority over tenant-scoped configuration** — a distinct question, ⛔ not reached.
⛔ **`MM-CFG-008`'s own allocation** — already `ADR-0151` §2.3; ⛔ **cited, not re-decided**.
⛔ **`SEAT-CFG-001`…`018`** — ⛔ **not audited**; scope must be established independently.
⛔ **`ICFG-1`…`10`**, ⛔ **7 `ATT-CFG-*`**, ⛔ **`CFG-10`/`CFG-12`**, ⛔ **`SCFG-2`/`SCFG-4`** — all still held.
⛔ **The 104 inventory** — ⛔ **unchanged**.
⛔ **`DD-0007` design-readiness** — ⛔ **D3 stays `PARTIAL`**.

---

## 6. Consequences for `DD-0007`

⭐ Coverage **58 → 64 / 104** *(**61.5%**)*. ⭐⭐ **The `AUTHORIZED` band moves
**35 → 41** — ⭐ **the first band movement since `ADR-0153`**, because these are
the **first tenant-scoped parameters authorized since**, and ⭐ **they carry a
real write path**. ⛔ The `PLATFORM DEFAULT` band is **unchanged at 23**.

⛔ **40 remain**: **10** `ICFG` + **1** `SMCFG` + **18** `SEAT-CFG` + **7**
`ATT-CFG` + **2** `CFG` + **2** `SCFG` = **40**. ⭐ **64 + 40 = 104.**

⚠️ **D5 is UNAFFECTED** — these are **APP 2** tenant parameters, ⛔ adding no
app and no cross-app edge. ⭐ **D4 gains 6 at `Tenant`.**

⛔⛔ **`DD-0007` DOES NOT BECOME DESIGN-READY.**

---

## 7. Obligations — `O-1` … `O-6`

| ID | Obligation | Owner |
|---|---|---|
| **`O-1`** | Resolve `SM-GAP-2`, then allocate **`SMCFG-5`** | **Product Owner** |
| **`O-2`** | Ensure the **`BC-02` projection** actually carries `MM-CFG-008` to the Directory *(`LMD-26`)* | **Technical Owner** |
| **`O-3`** | Audit **`SEAT-CFG-001`…`018`** — ⛔ establishing scope **independently** | **Product Owner** |
| **`O-4`** | Decide **`ICFG-1`…`10`** — ⛔ never batched | **Product Owner** + **SECURITY PLATFORM** |
| **`O-5`** | Design the tenant configuration surface for the 6 — ⛔ authorization is not design | **Design Owner** |
| **`O-6`** | Correct **`G-5`** in `ADR-0151` §1 | **Architecture Owner** |

---

## 8. Changelog

| Version | Date | Change |
|---|---|---|
| ⭐⭐ **1.0** | 2026-09-19 | ⭐⭐ **ACCEPTED.** ⭐ **5** `SMCFG-*` allocated at **`Tenant`** — `WRITE` = `TR-1` + `TR-2`, `TR-3` ⛔; `READ` = `TR-1`/`TR-2`/`TR-3`. ⭐ **`SMCFG-3` resolved as a DISTINCT entry and a SOURCED ALIAS** of `MM-CFG-008`; ⛔ **not merged**, ⛔ **inventory stays 104**; ⭐ **`DD7-GAP-005` CLOSED**. ⛔ **`SMCFG-5` HELD** *(`SM-GAP-2` open in every source, zero ADRs)*. ⛔⛔ **`ADR-0151` §3.5 `N/A` EXPRESSLY NOT REUSED** — `CNF-FR-020` does not reach `Tenant` scope. ⭐ Coverage **58 → 64 / 104**; `AUTHORIZED` band **35 → 41**. ⛔ Supersedes **nothing**. ⛔ **0** `PERM-*` · **0** roles/actions/scopes · **0** frozen edits · **0** runtime code. ⛔ **D3 still `PARTIAL`.** |
