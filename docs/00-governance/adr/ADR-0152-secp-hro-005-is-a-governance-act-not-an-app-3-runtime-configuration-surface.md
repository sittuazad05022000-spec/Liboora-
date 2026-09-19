# ADR-0152 — **`SECP-HRO-005` is a governance / change-control act, NOT an APP 3 runtime configuration surface** — the `BC-25` platform-configuration boundary is fixed

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-19 |
| **Date** | 2026-09-19 |
| **Deciders** | **Architecture Owner** *(the boundary determination)* **and Security** *(`PRD-012a` subject-matter concurrence)*, **jointly**, each under a **one-act conferral** of the human principal of this engagement, ⛔ **reverting on completion** (`ADR-0033` §7.1: *"a conferral for one act is not a standing licence"*) |
| **Authority instrument** | ⭐⭐ **No new authority is exercised.** This ADR **reads** existing ranked text and **corrects a mis-ranking** made downstream. ⭐ The determinative facts — `PRD-012a` Part 2's self-declared **Unranked** status and its §0.2 exclusion of **UI** — were already published in the repository and are quoted verbatim at §4 |
| **Amends** | ⛔⛔ **NOTHING IS EDITED BY THIS ADR.** No file outside this one changes. ⛔ `DD-0007` is **not** modified — its correction is a **FOLLOW-UP** (§10), not part of this act |
| **Baseline** | ⛔ **No baseline re-issue.** No Rank 1–5 document changes here (`DOCUMENTATION_BASELINE.md` §7 **rule 4**) |
| **Closes** | ⭐⭐ **`DD7-GAP-001`** — resolved in favour of **Interpretation B** (§7) · ⭐⭐ **`DD7-GAP-002`** — closed as **moot**, ⛔ not answered (§8.2) |
| **Does NOT close** | ⛔ **`DD-0007` D5** — untouched; the cross-app dependency gap has a different cause (§8.4) · ⛔ `DD7-GAP-003`…`012` · ⛔ `CNF-GAP-001`…`008` · ⛔ `CNF-D-1`, `CNF-D-2`, `CNF-D-3` · ⛔ `SECP-GAP-014`, `SECP-GAP-015` |
| **Related** | `ADR-0151` *(the `BC-25` 22-parameter allocation — **preserved unchanged**)* · `ADR-0017` *(`BC-25` ownership; §3.2 exclusions)* · `ADR-0132` *(`AUTH-7.22` at zero)* · `ADR-0053` *(`PRD-023` v0.1 baseline)* · `ADR-0064` *(`PRD-012a` v0.8 baseline)* · `ADR-0033` §7.1 |

> ⭐⭐ **`AUTH-7.22` REMAINS CLOSED AT ZERO ENUMERATED PERMISSIONS.** ⛔ This ADR mints **no** permission
> identifier, **no** `PERM-*` token, **no** action class, **no** scope class, **no** role, **no** surface,
> **no** API, **no** event and **no** configuration identifier.
> ⛔ **`ADR-0132` is NOT reopened. `ADR-0151` is NOT amended. `DD-0007` is NOT edited. 0 lines of runtime code.**

---

## 1. Context

`DD-0007` (`BC-25` Configuration surface design, v0.1, `PROPOSED`, unranked) recorded
**Declaration 1 — Target App** as **`GAP`** and raised **`DD7-GAP-001`** on the ground that two
sources contradicted each other on whether the Platform Admin app (APP 3) has a runtime
configuration surface:

| Source cited by `DD-0007` §5.3 | Text |
|---|---|
| **`SECP-HRO-005`** — `PRD-012a` Part 2 **L232** | High-risk operation *"Change **platform configuration**"* · *"`PR-1` Scope; **`BC-25` owns the hierarchy**"* · Class **Platform-affecting** |
| **`CNF-FR-020`** — `PRD-023` | Scope 1 *"**SHALL NOT** be writable at runtime by any actor, **including a platform role**"* |

⛔ `DD-0007` §5.3 characterised this as **"Rank 3 vs Rank 3"** and concluded that
*"precedence cannot break a same-rank tie."*

⭐⭐ **That characterisation is wrong, and correcting it resolves the question outright.**

---

## 2. Problem

> **Does `SECP-HRO-005` *"Change platform configuration"* establish a runtime APP 3 / Platform Admin
> configuration surface, or is it a governance / change-control act that establishes no such surface?**

⛔ Neither answer is assumed. §5 and §6 state each interpretation with its own supporting and
contradictory evidence before §7 decides.

---

## 3. The distinctions this ADR refuses to collapse

⭐⭐ Four concepts are adjacent and are routinely conflated. **Keeping them apart is the whole of the
analysis**, and the brief is right that they are not automatically the same.

| # | Concept | Example in this repository | Does it imply a runtime UI/API? |
|---|---|---|---|
| **1** | **Authorized in principle to govern a subject** | `PR-1` Scope — *"platform-level objects only — tenants as entities, **platform configuration**, platform role assignments"* (`PRD-001` v2.0 **L128**) | ⛔ **No** — it states an authority boundary, not a mechanism |
| **2** | **Governance / change-control procedure** | `CONFIGURATION_GUIDE.md` §5 — *"Value outside its declared range — **An ADR**"*; *"Adding a parameter — **A PRD amendment**"* | ⛔ **No** — the actor is a governance body, the artefact a document |
| **3** | **Deployment / configuration mechanism** | `CNF-FR-026` — an environment profile *"**SHALL** supply the value at scope **1 (platform default)**"*; `CNF-FR-029` — the active profile *"**SHALL** be supplied at deployment and **SHALL** be immutable for the lifetime of the process"* | ⛔ **No** — deployment-time, ⛔ explicitly **not** runtime |
| **4** | **Runtime product surface** | `DD-0007` `C-1`…`C-3`, APP 2, `TR-1`/`TR-2`/`TR-3` | ⭐ **Yes** — this is the only one of the four that is a surface |

⭐ **`SECP-HRO-005` must be assigned to exactly one of these.** ⛔ `DD-0007` §5.3 implicitly read it as
**4**; ⭐ §7 finds it is **2**, with **1** as its authority basis and **3** as its mechanism.

---

## 4. Evidence

### 4.1 ⭐⭐ The determinative fact — `PRD-012a` Part 2 is **UNRANKED**, by its own header

⭐ Measured at `docs/30-product/security/PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md`, header row
`Rank`, **verbatim**:

> *"**Unranked.** No `DOCUMENTATION_BASELINE.md` §3 row. **Not** Rank 3; **MUST NOT** be cited as
> authority against any ranked document."*

⭐ Corroborated across the whole `PRD-012a` set — **all 8 parts** carry the identical disclaimer
(Part 1 and Parts 2–8 measured). ⭐ The `Status` row reads **`DRAFT`** — *"`PRD_LIFECYCLE.md`
**Stage 2**"*.

⚠️⚠️ **So `DD-0007` §5.3's premise of a "Rank 3 vs Rank 3" deadlock is false.** `CNF-FR-020` sits in
`PRD-023`, which is **`FROZEN`, Rank 3** (`ADR-0053`, `BASELINE-2026-08-20-A`). `SECP-HRO-005` sits in
an **unranked `DRAFT`** that expressly forbids its own citation against a ranked document. ⛔ There is
**no tie to break**.

⚠️ **The `rank 2` in `PRD-012a`'s header is a *module* rank, not a document rank.** The header reads
*"Owning platform — SECURITY PLATFORM, rank **2**"* and *"Module path — `platform/security` (rank
**2**)"*. ⭐ That is the **module-dependency** rank used by `tool/check_module_boundaries.dart`,
⛔ **not** the `DOCUMENTATION_BASELINE.md` §3 precedence rank. ⭐ Conflating the two is precisely the
error this ADR corrects, and it is an easy one to make.

### 4.2 ⭐⭐ Part 2 excludes UI from its own scope — in terms

⭐ `PRD-012a` Part 2 **§0.2 *"What Part 2 does, and does not, do"***, right-hand column, **verbatim**:

> *"Specify tables, APIs, SQL, code, **UI**, cloud resources or cryptographic mechanisms"*

⭐⭐ **A document that expressly does not specify UI or APIs cannot be the source that creates a UI or
an API.** ⛔ Reading `SECP-HRO-005` as establishing an APP 3 panel would attribute to Part 2 the exact
output it disclaims.

### 4.3 ⭐ Part 2's reading rule — it never adds a rule of its own

⭐ §0.2, **verbatim**:

> *"⚠ **The single most important reading rule.** `PRD-001` v2.0 is **`FROZEN` and Rank 3**; this
> document is **unranked**. Where Part 2 appears to state an admin-security rule, it is either (a)
> **citing** `PRD-001` and adding a *verification* obligation, or (b) recording a **gap**. It never
> adds an authorisation or authentication rule of its own. `SECP-XC-006` and `SECP-XC-011` make that
> structural."*

⭐ Applied to `SECP-HRO-005`: its *"Already governed by"* column reads *"**`PR-1` Scope**; `BC-25`
owns the hierarchy"* — ⭐ i.e. it **cites** `PRD-001` L128 and **cites** `BC-25` ownership. ⛔ It
originates nothing.

### 4.4 ⭐ What the `SECP-HRO-*` register actually obliges

⭐ The register's own normative requirements are **audit and refusal**, ⛔ not surface creation:

| ID | Requirement | Owner |
|---|---|---|
| `SECP-FR-011` | Every `SECP-HRO-*` operation **MUST** emit an audit record naming actor, operation, target, scope, purpose, time | `BC-24` |
| `SECP-FR-012` | An operation meeting the §5.1 closure test but **absent** from the register **MUST** be refused | SECURITY + `BC-18` |
| `SECP-FR-013` | `SECP-HRO-001`/`002` **MUST** require two distinct accounts | `BC-18` |

⭐ `SECP-BR-004`, **verbatim**: *"the set below is **closed for V1**. An operation that is
platform-scoped, irreversible or tenant-affecting and is **not** listed **MUST** be treated as
high-risk by default and **MUST** be refused until it is added to this register by amendment.
**Silence is not permission.**"*

⭐⭐ **The register is a *control list*, not a *feature list*.** ⛔ Its function is to say *"if this
operation occurs, these controls apply"* — ⛔ not *"this operation has a screen"*. ⭐ §5.1 states the
purpose plainly: *"'Sensitive action' is unverifiable as a category — a test cannot prove a property
of an open-ended list."*

### 4.5 ⭐ The ranked prohibition, and where it routes the act instead

| Source | Rank | Text |
|---|---|---|
| **`CNF-FR-020`** | **3**, `FROZEN` | *"A default **SHALL NOT** be storable as an override at scope 1… and **SHALL NOT** be writable at runtime by any actor, **including a platform role**."* |
| **`CNF-AC-011`** | **3**, `FROZEN` | *"**No** API, role, actor, environment or maintenance path can write a value at scope 1 **at runtime**"* |
| **`CNF-BR-009`** | **3**, `FROZEN` | *"A tenant role **SHALL NOT** be capable of writing at scope 1 (platform default) or of affecting another tenant."* |
| **`AUTH-2.9`** | **3**, `FROZEN` | *"No tenant role, including Owner, **MAY** confer any platform-level permission."* |
| **`AUTH-2.5`** | **3**, `FROZEN` | *"Platform roles **MUST NOT** grant access to tenant business data."* |

⭐⭐ **`CNF-FR-020`'s own explanatory note names the alternative route** — **verbatim**:

> *"If a platform actor could write scope 1, `PRD-023` would hold an effective write path over all 104
> values owned by eight FROZEN PRDs — the ownership breach `ADR-0017` §3.2 forbids, achieved through a
> storage feature rather than a specification change. **`CONFIGURATION_GUIDE.md` §5 already routes
> default changes elsewhere: *"Value outside its declared range — an ADR."***"

⭐ `CONFIGURATION_GUIDE.md` §5 *Change control*, **verbatim**:

| Change | Requires |
|---|---|
| Value within its declared range | Owner approval, recorded in the deployment change log |
| Value outside its declared range | **An ADR.** The range is part of the reasoning, not a formality |
| Adding a parameter | **A PRD amendment** |
| Promoting a structural fact to configurable | **An ADR and a PRD amendment** |

⭐⭐ **Every route is a governance artefact. ⛔ None is a screen.**

### 4.6 ⭐⭐ Repository-wide measurement — no runtime platform-configuration surface exists anywhere

⭐ Measured across the whole repository *(all file types, excluding `.git`)*:

| Search term | Occurrences |
|---|---:|
| `SECP-HRO-005` | **9** — ⭐ **1** definition (`PRD-012a` Part 2 **L232**), **7** in `DD-0007` *(this open question)*, **1** in an archived `delivery/` snapshot of the same Part 2 file |
| `platform configuration panel` | ⛔ **0** |
| `platform configuration API` | ⛔ **0** |
| `runtime platform configuration` | ⛔ **0** |
| `platform role configuration` | ⛔ **0** |
| ADRs citing `SECP-HRO-005` | ⛔ **0** *(before this one)* |

⭐⭐ **In a repository of this density, a runtime platform-admin configuration surface would leave
traces.** ⛔ It leaves none.

### 4.7 ⭐ The APP 3 code home says implementation is not authorised

⭐ `lib/app/platform_admin/README.md` — **verbatim**:

- L1 — *"# PLATFORM ADMIN APP BOUNDARY — **reserved, deliberately empty**"*
- L6 — *"⛔ **Nothing here may be implemented until the governance decision in §3 is taken.**"*
- L122 — *"⛔ No `platform_admin` shell written, and **no implementation authorised**"*
- L142 — *"⛔ Steps 1–5 are **not authorised by this file**. It records what would be required; it
  confers…"*

⭐ `lib/app/platform_admin/{platform_admin,platform_owner,shared}/` are **empty reserved
directories** — measured. ⛔ Not evidence *for* a surface, and this ADR does **not** treat code as
authority (README §2B.4 rule 4); ⭐ it is recorded only because it **agrees** with the ranked text
rather than contradicting it.

### 4.8 ⭐ Part 2's own precedent for exactly this situation

⭐ `SECP-GAP-014` (`PRD-012a` Part 2) faces the identical structure — an unranked Part 2 statement
apparently extending a frozen Rank-3 `PRD-001` rule — and resolves it **conservatively**, **verbatim**:

> *"**Reading 2 is the conservative one and Part 2 does not assume Reading 1.** `SECP-FR-018` is
> therefore marked **`PENDING-AUTHORITY`**: it is specified and testable, and it **MUST NOT** be
> implemented until `BC-18`'s owner confirms the reading."*

⭐⭐ **Part 2 itself holds that where it appears to exceed a ranked document, the ranked document
governs and Part 2 waits.** ⭐ This ADR applies Part 2's own stated method to `SECP-HRO-005`.

---

## 5. Interpretation A — `SECP-HRO-005` IS an APP 3 runtime configuration surface

### 5.1 Supporting evidence

| # | Evidence | Weight |
|---|---|---|
| A-1 | `SECP-HRO-005` names an **operation** — *"**Change** platform configuration"* — and *change* is an active verb implying an actor performing it | ⚠️ Moderate on its face |
| A-2 | Its *"Already governed by"* cell cites *"**`PR-1` Scope**"*, and `PRD-001` v2.0 **L128** does place *"platform configuration"* inside `PR-1`'s scope | ⭐ Strong for **authority**, ⛔ silent on **mechanism** |
| A-3 | `PRD-001` **L127** gives `PR-1` the Purpose *"**manage platform configuration**"* | ⭐ Same — authority, not surface |
| A-4 | The register's class column marks it *"**Platform-affecting**"*, implying a real effect | ⚠️ Weak — a governance act is also platform-affecting |
| A-5 | `SECP-FR-011` requires an **audit record** for every `SECP-HRO-*` operation, which implies the operation is performable | ⚠️ Weak — governance acts are auditable too; `CNF-FR-060` audits *configuration* writes separately |

### 5.2 Contradictory evidence

| # | Evidence | Weight |
|---|---|---|
| A-x1 | ⛔⛔ **`PRD-012a` Part 2 is Unranked and *"MUST NOT be cited as authority against any ranked document"*** — §4.1 | ⭐⭐ **Decisive** |
| A-x2 | ⛔⛔ **Part 2 §0.2 excludes *"APIs… **UI**"* from what it specifies** — §4.2 | ⭐⭐ **Decisive** |
| A-x3 | ⛔ **`CNF-FR-020` / `CNF-AC-011`** (Rank 3, FROZEN) forbid a runtime scope-1 write *"by any actor, **including a platform role**"* — §4.5 | ⭐⭐ Strong |
| A-x4 | ⛔ **0** occurrences of any platform-configuration panel, API or runtime surface repo-wide — §4.6 | ⭐ Strong |
| A-x5 | ⛔ Part 2 *"never adds an authorisation… rule of its own"*; `SECP-HRO-005` **cites**, it does not originate — §4.3 | ⭐ Strong |
| A-x6 | ⛔ The APP 3 code home records *"no implementation authorised"* — §4.7 | ⚠️ Corroborative only |

### 5.3 Consequences **if** Interpretation A were adopted

⛔ It would put an unranked `DRAFT` above a `FROZEN` Rank-3 PRD, breaching
`DOCUMENTATION_BASELINE.md` §3 precedence and Part 2's own header. ⛔ It would create an APP 3
surface with **undefined contents** (*"platform configuration"* is nowhere defined as a parameter
set — §8.2). ⛔ It would require a write path that `CNF-AC-011` makes **untestable-by-construction**
*("No API, role, actor, environment or maintenance path can write a value at scope 1 at runtime")*.
⛔ And it would contradict `lib/app/platform_admin/README.md`'s recorded non-authorisation.

---

## 6. Interpretation B — `SECP-HRO-005` is a governance / change-control act

### 6.1 Supporting evidence

| # | Evidence | Weight |
|---|---|---|
| B-1 | ⭐⭐ **Part 2 is Unranked, `DRAFT`, and forbids its own use against ranked text** — §4.1 | ⭐⭐ **Decisive** |
| B-2 | ⭐⭐ **Part 2 §0.2 expressly does not specify UI or APIs** — §4.2 | ⭐⭐ **Decisive** |
| B-3 | ⭐⭐ **`CONFIGURATION_GUIDE.md` §5 already routes every category of default change to an ADR and/or a PRD amendment** — §4.5 | ⭐⭐ Strong — ⭐ it supplies the *positive* mechanism, so the act is not left homeless |
| B-4 | ⭐ **`CNF-FR-020`'s own note points at that route** — *"`CONFIGURATION_GUIDE.md` §5 **already routes default changes elsewhere**"* | ⭐⭐ Strong — the frozen PRD anticipates precisely this question |
| B-5 | ⭐ **`CNF-FR-026`/`CNF-FR-029`** make the platform-default value a **deployment-time** input, *"immutable for the lifetime of the process"* — §3 concept 3 | ⭐ Strong |
| B-6 | ⭐ The `SECP-HRO-*` register's obligations are **audit and refusal**, i.e. a control list — §4.4 | ⭐ Strong |
| B-7 | ⭐ Part 2's own `SECP-GAP-014` adopts the conservative reading in the identical structure — §4.8 | ⭐ Strong — method precedent |
| B-8 | ⭐ **0** repo-wide traces of a platform-configuration runtime surface — §4.6 | ⭐ Strong |

### 6.2 Contradictory evidence

| # | Evidence | Honest weight |
|---|---|---|
| B-x1 | ⚠️ *"**Change** platform configuration"* reads naturally as an operation someone performs in a product | ⚠️ **Real but not authoritative** — a Product Owner approving an ADR also *changes platform configuration* |
| B-x2 | ⚠️ `PR-1`'s Purpose says *"**manage** platform configuration"*, which could be read as an in-product capability | ⚠️ Answered by §3 concept **1** — authority ≠ mechanism |
| B-x3 | ⚠️ Interpretation B leaves `PR-1` with a scope item it exercises **outside** the product | ⚠️ **Accepted and recorded** — ⭐ that is what `CONFIGURATION_GUIDE.md` §5 describes, and ⛔ nothing requires every scope item to have a screen |

### 6.3 Consequences **if** Interpretation B is adopted

⭐ Every ranked document remains satisfied, ⛔ with **no** exception granted. ⭐ `PR-1`'s scope is
preserved intact — it governs platform configuration **through the governance route**
(`CONFIGURATION_GUIDE.md` §5) and **through deployment** (`CNF-FR-026`). ⭐ `CNF-FR-020`,
`CNF-AC-011`, `CNF-BR-009`, `AUTH-2.9` and `AUTH-2.5` all hold **literally**. ⛔ No surface, API,
role or permission is created.

---

## 7. Decision

# ⭐⭐ **INTERPRETATION B**

⭐⭐ **`SECP-HRO-005` *"Change platform configuration"* is a GOVERNANCE / CHANGE-CONTROL ACT.
⛔ It does NOT establish an APP 3 / Platform Admin runtime configuration surface, API or write path.**

⭐ Precisely:

1. ⭐ **`PR-1` is authorized in principle** to govern platform configuration — `PRD-001` v2.0
   **L127**/**L128**, Rank 3, `FROZEN`. ⛔ **This ADR does not narrow that authority.**
2. ⭐ **That authority is exercised through the governance route**, not a product surface —
   `CONFIGURATION_GUIDE.md` §5 *(ADR and/or PRD amendment)* and, for the deployed value,
   `CNF-FR-026`/`CNF-FR-029` at **deployment time**.
3. ⛔ **No runtime write path to scope 1 exists or may be built** — `CNF-FR-020`, `CNF-AC-011`,
   `CNF-BR-009`, `AUTH-2.9`.
4. ⭐ **`SECP-HRO-005` retains full force as a control obligation**: when such a change occurs, the
   `SECP-FR-011` audit record and the `SECP-BR-004` closure discipline apply. ⛔ It is **not**
   weakened, deleted or reclassified by this ADR.

### 7.1 ⭐ Why the decision is authoritative, and why it is not a preference

⭐⭐ **It is settled by ordinary precedence, not by judgement.** `DOCUMENTATION_BASELINE.md` §3 ranks
documents; `PRD-023` is **Rank 3, `FROZEN`**; `PRD-012a` Part 2 is **Unranked, `DRAFT`** and states
in its own header that it *"**MUST NOT** be cited as authority against any ranked document."*

⛔ **There was never a same-rank tie.** ⭐ The apparent deadlock in `DD-0007` §5.3 arose from reading
`PRD-012a`'s **module rank 2** as a document precedence rank (§4.1). ⭐ Once the ranks are measured
correctly, `CNF-FR-020` governs and the question answers itself.

⚠️⚠️ **And the decision is not reached by asking which is easier to implement.** ⭐ The
implementation-convenience argument runs the *other* way: an APP 3 panel is the feature-richer
outcome. ⛔ It is rejected because the evidence rejects it.

### 7.2 ⛔ What this decision expressly does NOT say

⛔ It does **not** say `PR-1` lacks authority over platform configuration — §7 item 1.
⛔ It does **not** delete, weaken or reclassify `SECP-HRO-005` — §7 item 4.
⛔ It does **not** decide whether APP 3 has surfaces for **other** subjects (`SECP-HRO-001`…`004`,
`006`…`012`) — ⭐ each is a distinct question this ADR does not reach.
⛔ It does **not** authorise any APP 3 implementation — `lib/app/platform_admin/README.md` §3 governs
that separately.
⛔ It does **not** define *"platform configuration"* as a parameter set — §8.2.

---

## 8. Consequences

### 8.1 ⭐⭐ `DD7-GAP-001` — **CLOSED**

⭐ Resolved in favour of **Interpretation B** (§7). ⭐ The gap was stated as *"`SECP-HRO-005` vs
`CNF-FR-020` — Rank 3 vs Rank 3… precedence cannot break a same-rank tie."* ⛔ The premise was
false: **`PRD-012a` Part 2 is Unranked** (§4.1), so ⭐ precedence resolves it cleanly.

### 8.2 ⭐⭐ `DD7-GAP-002` — **CLOSED AS MOOT, ⛔ NOT ANSWERED**

⭐ The gap read: *"'Platform configuration' is not a defined parameter set — 23 uses repo-wide, 0
definitions. **Even if APP 3 has a surface**, its contents are undetermined."*

⭐⭐ **Its stated precondition — *"even if APP 3 has a surface"* — is now settled in the negative.**
⛔ With no APP 3 configuration surface, there is **no surface whose contents need defining**, and the
gap has no remaining consequence for `DD-0007`.

⚠️⚠️ **CLOSED-AS-MOOT is not CLOSED-AS-ANSWERED, and the distinction is preserved deliberately.**
⛔ *"Platform configuration"* **still has 0 definitions** as a parameter set — measured, unchanged by
this ADR. ⭐ If any future act needs that set enumerated *(for example, to scope a governance
change-control register)*, the definitional question **returns**, and it is recorded here as
**`ADR-0152-F-2`** (§10) rather than buried.

### 8.3 ⭐ `DD-0007` Declaration 1 — the blocker is removed; ⛔ the verdict is NOT changed by this ADR

⭐ With `DD7-GAP-001` closed and `DD7-GAP-002` moot, the evidentiary obstacle to Declaration 1 is
gone. ⭐ On the evidence now settled, D1 resolves to:

> **APP 2 — Library App** *(`TR-1`, `TR-2`, `TR-3`)* · ⛔ **APP 1 = 0 surfaces** · ⛔ **APP 3 = 0
> configuration surfaces**

⛔⛔ **But this ADR does NOT edit `DD-0007`, and D1 remains `GAP` in the document until that edit is
made.** ⭐ A Design Doc's verdict is a statement *in* the Design Doc; ⛔ an ADR that silently changed
it would be the *"Design Doc that reads like an ADR"* inversion README §5.1 warns against, run
backwards. ⭐ The amendment is **`ADR-0152-F-1`** (§10).

⭐ Consequentially, **App-Boundary QA check 7** *(platform roles separated, `AUTH-2.5`)* becomes
satisfiable at the same amendment: ⛔ APP 3 holds **0** configuration surfaces, and `AUTH-2.5` is
untouched.

### 8.4 ⛔ `DD-0007` Declaration 5 — **UNCHANGED, still `GAP`**

⛔⛔ **This ADR does not touch D5, and it would be wrong to claim it does.** ⭐ D5's causes are
entirely different and remain open:

| Cause | Status |
|---|---|
| `CNF-GAP-002` — *"Seven modules declare a dependency on a port **no module provides**"* (7 consumers / 0 providers), severity **High** | ⛔ **OPEN**, Stage 6 |
| `CNF-GAP-007` — `platform/configuration` has **no module block** in `tool/module_dependencies.yaml` | ⛔ **OPEN**, Stage 6 |
| `E-19` declares *"All contexts"*, which is a **bounded-context** statement, ⛔ not an app-boundary one | ⛔ Unchanged |
| The `app` module (rank 9) declares `platform/configuration:settings` at the **app root**, not per app | ⛔ Unchanged |

⭐ **`DD-0007` therefore remains NOT design-ready even after this ADR** — one of its two `GAP`
declarations survives. ⛔ Anyone reading this ADR as unblocking `DD-0007` outright would be wrong.

### 8.5 ⭐ APP + ROLE BOUNDARY

| App | Configuration surfaces | Basis |
|---|---|---|
| **APP 1 — Student App** | ⛔ **0** | `ADR-0151` allocates no `TR-4`/`TR-5` read or write; `AP-3` |
| **APP 2 — Library App** | ⭐ `TR-1`, `TR-2`, `TR-3` | `ADR-0151` §2.3 |
| **APP 3 — Platform Admin** | ⛔ **0 configuration surfaces** | ⭐⭐ **This ADR §7** |

⛔ **No role, action class or scope class is created, widened or narrowed.** ⭐ `PR-1` and `PR-2`
retain their `PRD-001` §2.3 definitions exactly.

### 8.6 ⭐ `BC-25` ownership / surface boundary

⭐ `BC-25` continues to **own the resolution machinery** (`ADR-0017` §3.1 item 6 — *"`PRD-023` owns
the resolution machinery, **not the value list**"*). ⭐ Scope 1 remains **read-only at runtime for
every actor**, sourced from each owning PRD's declared default and, per environment, from
`CONFIGURATION_GUIDE.md` §4 via `CNF-FR-026`. ⛔ `ADR-0151`'s 22-parameter allocation is **untouched**;
⛔ its §3.5 *(the four platform-default parameters receive no effective tenant-role write authority)*
is **reinforced**, not altered.

---

## 9. Open questions — ⛔ NOT resolved here

| ID | Question | Owner |
|---|---|---|
| ⛔ `DD7-GAP-003` | Does `BC-25` own a configuration surface at all, or does each owning module render its own? *(The `DD-0003` `S-L8` pattern.)* | Product Owner + UX Architecture Owner |
| ⛔ `DD7-GAP-008` | `C-4` change-history has no authorized reader | Authorization Owner + `PRD-016` Owner |
| ⛔ `DD7-GAP-011` | No concurrency / staleness rule for configuration writes | Architecture Owner + `PRD-023` Owner |
| ⛔ `DD7-GAP-004`, `005`, `006`, `007`, `009`, `010`, `012` | As recorded in `DD-0007` §22 | As recorded |
| ⛔ `CNF-GAP-001`…`008` | As recorded in `PRD-023` §14 | As recorded |
| ⛔ `CNF-D-1`, `CNF-D-2` | `LCFG-1` Rank 3 vs Rank 7; `PRD-023` §3.1 *"9 of 13"* | `ADR-0151` §6 |
| ⛔ `CNF-D-3` | `PRD-023` §3.6 cites `PRD-005` v1.4; repository is at v1.6 | `DD-0007` §22 |
| ⛔ `SECP-GAP-014`, `SECP-GAP-015` | `PRD-012a` Part 2's own open items | Product Owner + `BC-18` |

---

## 10. Follow-up actions — ⛔ identified only, NOT performed

| ID | Action | Owner | Instrument |
|---|---|---|---|
| ⭐ **`ADR-0152-F-1`** | **Amend `DD-0007`**: §5.3 correct the *"Rank 3 vs Rank 3"* characterisation to record `PRD-012a` Part 2 as **Unranked**; set **D1 = PASS** (APP 2; APP 1 = 0; APP 3 = 0 configuration surfaces) citing this ADR; mark `DD7-GAP-001` **CLOSED** and `DD7-GAP-002` **CLOSED AS MOOT**; update §5.5 check 7, §22, §25 blocker 1, §26 and the changelog. ⚠️ **D5 stays `GAP`** | UX Architecture Owner | `DD-0007` **v0.2** amendment |
| ⚠️ **`ADR-0152-F-2`** | If a future act requires *"platform configuration"* as an **enumerated set**, the definitional question returns (§8.2) | Product Owner + Architecture Owner | Rank 2 ADR or `PRD-023` amendment |
| ⚠️ **`ADR-0152-F-3`** | Consider whether `PRD-012a` Part 2's `SECP-HRO-005` row should **cite** this ADR in its *"Already governed by"* column at its next amendment. ⛔ **Not done here** — Part 2 is a `DRAFT` owned by SECURITY, and this ADR edits nothing | SECURITY + `PRD-012a` Owner | `PRD-012a` amendment |

⛔ **`ADR-0152-F-*` are follow-up labels carrying no authority.** ⛔ They are not added to any closed
register; `DD7-GAP-*` stays at **12** in `DD-0007` and `SECP-GAP-*` is untouched.

---

## 11. Traceability

| Claim | Source | Rank |
|---|---|---|
| `SECP-HRO-005` text and register | `PRD-012a` Part 2 **L232**; `SECP-BR-004` | ⛔ **Unranked** |
| Part 2 is Unranked, `DRAFT`, not citable against ranked text | `PRD-012a` Part 2 header rows `Rank`, `Status` | ⛔ Unranked |
| Part 2 does not specify UI or APIs | `PRD-012a` Part 2 **§0.2** | ⛔ Unranked |
| Part 2 never adds a rule of its own | `PRD-012a` Part 2 **§0.2** reading rule; `SECP-XC-006`, `SECP-XC-011` | ⛔ Unranked |
| `SECP-HRO-*` obligations are audit/refusal | `SECP-FR-011`, `SECP-FR-012`, `SECP-FR-013` | ⛔ Unranked |
| Conservative-reading precedent | `SECP-GAP-014` | ⛔ Unranked |
| Scope 1 not writable at runtime by any actor | **`CNF-FR-020`**, **`CNF-AC-011`** | ⭐ **3, FROZEN** |
| Tenant roles cannot write scope 1 | **`CNF-BR-009`** | ⭐ **3, FROZEN** |
| Environment profile supplies scope 1 at deployment, immutable per process | `CNF-FR-026`, `CNF-FR-029` | ⭐ **3, FROZEN** |
| `PR-1` scope includes platform configuration | `PRD-001` v2.0 **L127**, **L128** | ⭐ **3, FROZEN** |
| Platform roles grant no tenant business data | `AUTH-2.5` | ⭐ **3, FROZEN** |
| No tenant role confers platform permission | `AUTH-2.9` | ⭐ **3, FROZEN** |
| Default changes route to ADR / PRD amendment | `CONFIGURATION_GUIDE.md` **§5** | 7 |
| `BC-25` owns machinery, not the value list | `ADR-0017` §3.1 item 6, §3.2 | ⭐ **2** |
| 22-parameter allocation, platform-default vacuity | `ADR-0151` §2.3, §3.5 | ⭐ **2** |
| Document precedence ladder | `DOCUMENTATION_BASELINE.md` §3 | — |
| Design Doc cannot substitute for an ADR | `docs/35-design/README.md` §5.1 | — |
| APP 3 implementation not authorised | `lib/app/platform_admin/README.md` L6, L122, L142 | ⚠️ Corroborative only |

---

## 12. Number allocation

⭐ **`ADR-0152` is allocated by measurement, not by assumption.** Highest file on disk: **`ADR-0151`**.
`ADR-0152` was probed repository-wide before authoring: **0** occurrences in `docs/`, **0** files
named `ADR-0152`, and **0** uncommitted ADRs in the working tree. `ADR-INDEX` **L206**'s rule
*"Never reuse a number"* is satisfied. ⛔ No number is reserved for future use by this act.

---

## 13. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-19 | ⭐⭐ **Created and `Accepted`. The `BC-25` platform-configuration boundary is fixed: `SECP-HRO-005` is a GOVERNANCE / CHANGE-CONTROL ACT and establishes NO APP 3 runtime configuration surface, API or write path** (§7, Interpretation B). ⭐⭐ **THE DECISION RESTED ON A MIS-RANKING, AND CORRECTING IT DISSOLVED THE DEADLOCK:** `DD-0007` §5.3 recorded *"Rank 3 vs Rank 3 — precedence cannot break a same-rank tie"*, but ⛔ **`PRD-012a` Part 2 is `Unranked` and `DRAFT` by its own header**, which states *"**Not** Rank 3; **MUST NOT** be cited as authority against any ranked document"* — ⭐ measured identically across **all 8 parts**. ⚠️ The error was reading `PRD-012a`'s **module rank 2** (`platform/security`) as a **document precedence rank**; ⭐ they are different ladders. ⭐⭐ **A SECOND INDEPENDENT GROUND STANDS ALONE:** Part 2 **§0.2** expressly excludes *"tables, APIs, SQL, code, **UI**, cloud resources or cryptographic mechanisms"* from what it specifies — ⛔ **a document that does not specify UI cannot create one.** ⭐ **BOTH INTERPRETATIONS WERE STATED WITH THEIR OWN SUPPORTING *AND* CONTRADICTORY EVIDENCE** (§5, §6) before deciding, and ⚠️ **three genuine points against the chosen reading are recorded rather than suppressed** (§6.2) — including that *"change"* reads naturally as a product operation, and that `PR-1` is left with a scope item exercised **outside** the product. ⭐ **That last point is answered positively, not waved away:** `CONFIGURATION_GUIDE.md` **§5** already routes every category of default change to *"**An ADR**"* and/or *"**A PRD amendment**"*, and ⭐⭐ **`CNF-FR-020`'s own explanatory note points at exactly that route** — the frozen PRD anticipated this question. ⭐ **Four adjacent concepts are held apart and not collapsed** (§3): authority-in-principle · governance procedure · deployment mechanism · runtime product surface. ⛔ **`SECP-HRO-005` IS NOT WEAKENED, DELETED OR RECLASSIFIED** — it retains full force as a control obligation under `SECP-FR-011` audit and `SECP-BR-004` closure (§7 item 4); ⛔ and `PR-1`'s authority over platform configuration is **preserved intact** (§7 item 1). ⭐ **Repository-wide measurement found 0 occurrences** of *platform configuration panel*, *platform configuration API*, *runtime platform configuration* or *platform role configuration*, and **0** prior ADRs citing `SECP-HRO-005` (§4.6). ⭐⭐ **`DD7-GAP-001` CLOSED** (§8.1). ⭐⭐ **`DD7-GAP-002` CLOSED AS MOOT — ⛔ EXPLICITLY NOT ANSWERED** (§8.2): its stated precondition *"even if APP 3 has a surface"* is settled in the negative, ⛔ but *"platform configuration"* **still has 0 definitions as a parameter set**, and the definitional question is preserved as `ADR-0152-F-2` rather than buried. ⛔⛔ **`DD-0007` IS NOT EDITED BY THIS ADR AND D1 REMAINS `GAP` IN THE DOCUMENT** (§8.3) — a verdict is a statement *in* the Design Doc, and changing it silently from an ADR would invert README §5.1; the amendment is routed as **`ADR-0152-F-1`**. ⛔⛔ **`DD-0007` D5 IS UNCHANGED AND STILL `GAP`** (§8.4) — its causes are `CNF-GAP-002` *(7 consumers / 0 providers, **High**)*, `CNF-GAP-007`, `E-19`'s bounded-context wording and the app-root port declaration, ⭐ **none of which this ADR touches** — so ⛔ **`DD-0007` remains NOT design-ready**. ⛔⛔ **`AUTH-7.22` closed at ZERO · 0 `PERM-*` · 0 roles · 0 action classes · 0 scope classes · 0 surfaces · 0 APIs · `ADR-0132` not reopened · `ADR-0151` untouched · `DD-0007` untouched · 0 frozen documents modified · 0 lines of runtime code.** ⛔ **NOTHING IS EDITED BY THIS ADR.** ⭐ Number allocated by measurement (§12). |
