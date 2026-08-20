# PRD-023 — Settings & Configuration

| Field | Value |
|---|---|
| **PRD** | `PRD-023` |
| **Module** | Settings & Configuration |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** — [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 2 (Draft)**. Stages 3–7 not yet run. **This document confers no status on itself** |
| **Owning bounded context** | **`BC-25` Configuration** `[GENERIC]` — **FOUNDATIONAL** band (BC Map **L271**) |
| **Product version** | **V1** — Master PRD §8 **module 18** (Rank 1), BC Map **L134** (Rank 4), `ADR-0017` §3 (Rank 2) |
| **Owned aggregate** | **UNRESOLVED — see §1.4 and `CNF-GAP-001`.** `Library_PRD_v1.md` **L188** (FROZEN, Rank 3) names `LibrarySettings`; BC Map §8 lists **17** aggregates and `BC-25` is not among them. Stage 3's to settle |
| **Module path** | `platform/configuration` (**rank 3**) |
| **Manifest port name** | `platform/configuration:settings` — **7 declared consumers, 0 providers** (`CNF-GAP-002`) |
| **Integration edge** | **`E-19`** — BC Map **L328**: *"All contexts → `BC-25` Configuration \| `CF` \| Sync port \| Typed config accessors; no raw string lookups in domain code"* |
| **Requirement prefix** | **`CNF-`** — selected by measurement, [`PRD-023_STAGE1_DISCOVERY.md`](PRD-023_STAGE1_DISCOVERY.md) §6 |
| **Lifecycle stage** | **Stage 2 — Draft.** Stage 1 **PASS** (`PRD-023_STAGE1_DISCOVERY.md` §10) |
| **Governing authority** | [`ADR-0017`](../../00-governance/adr/ADR-0017-bc-25-configuration-ownership.md) — **`ACCEPTED`** 2026-08-04, `BASELINE-2026-08-04-B`. §3.3: *"It **registers** a document; it does not write one."* **This document is that write** |
| **Registry status** | **`PLANNED`** in [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) §4.3 **L327**. Not changed by this document |
| **Rank** | **None yet.** Rank 3 is conferred by [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3.3/§4 at Stage 7, **not claimed here** |
| **Baseline** | Written against **`BASELINE-2026-08-19-C`** |
| **Date** | 2026-08-20 |

> **Scope is not negotiated by this document.** It was fixed on 2026-08-04 by `ADR-0017` §3.1 —
> *"Scope is fixed **now** so the registration is not an open-ended reservation"* — and §3.2 fixed the exclusions.
> This document specifies **within** those six items and **outside** those exclusions. Where a reader expects a
> configuration concern that is absent here, §15 names its owner.
>
> **`ADR-0017` §3.2, verbatim, and binding on every line below:** *"No `LIB-*`, `LCFG-*`, `SID-*`, `SCFG-*` or
> `ICFG-*` requirement moves into it. **This ADR moves no requirement.**"* Neither does this PRD.

---

## 0. Registers, conventions and what is deliberately absent

### 0.1 Normative language

| Term | Meaning in this document |
|---|---|
| **SHALL** / **MUST** | An obligation. Its absence is a defect |
| **SHALL NOT** / **MUST NOT** | A prohibition. Something that must be **impossible**, not merely undone |
| **SHOULD** | A recommendation. Departure requires a recorded reason |
| **MAY** | Permission. No obligation either way |
| *cited* | A statement whose authority lives elsewhere. Reproduced for navigation, **not** made true here |

Every obligation carries an identifier. There are no unnumbered requirements.

### 0.2 Identifier registers — declared up front, with ranges

`PRD_LIFECYCLE.md` L79–86 requires registers published *"up front, with ranges"*, and L82 rule 3 requires ranges
**contiguous**, because *"a gap makes the published range false"*. The ranges below are a promise: **no `CNF-`
identifier outside them exists in this document, and every identifier inside them is defined exactly once.**

**Class A — obligation-bearing registers**

| Prefix | Meaning | Count | Range | Contiguous? |
|---|---|---:|---|---|
| `CNF-FR-` | Functional requirement | **67** | `CNF-FR-001` … `CNF-FR-067` | Yes |
| `CNF-BR-` | Business rule | **12** | `CNF-BR-001` … `CNF-BR-012` | Yes |
| `CNF-INV-` | Invariant — always true | **8** | `CNF-INV-001` … `CNF-INV-008` | Yes |
| `CNF-EVT-` | Domain event published by this context | **0** | **DECLARED EMPTY** — §0.3 | n/a |
| `CNF-XC-` | Exclusion — a prohibition with a named owner elsewhere | **16** | `CNF-XC-001` … `CNF-XC-016` | Yes |

**Class B — supporting registers**

| Prefix | Meaning | Count | Range | Contiguous? |
|---|---|---:|---|---|
| `CNF-AC-` | Acceptance criterion | **45** | `CNF-AC-001` … `CNF-AC-045` | Yes |
| `CNF-CFG-` | Configurable parameter published **by this module** | **0** | **DECLARED EMPTY** — §0.3 | n/a |

**Class C — finding register**

| Prefix | Meaning | Count | Range | Contiguous? |
|---|---|---:|---|---|
| `CNF-GAP-` | Open gap this PRD records but cannot close | **8** | `CNF-GAP-001` … `CNF-GAP-008` | Yes |

**Totals: 156 identifiers across 8 registers, of which 2 are empty. 103 are obligation-bearing. None is
retired; none has ever been issued before.**

The last claim is mechanical. Before this document existed,
`grep -rhoE '\bCNF-[A-Z0-9-]+' docs/ tool/ lib/ packages/ test/ | sort -u | wc -l` returned **0**, and the reverse
hazard scan `grep -rnoE '.CNF-[A-Z]'` returned **empty** — Stage 1 measurements `M-01` and `M-02`. Four other
candidate prefixes were tested and rejected; `CONF-` (3 occurrences), `CFG-` (12) and `SC-` (16) were **occupied**,
and `SET-` was free but rejected on ambiguity risk (Stage 1 §6, `R-02`).

### 0.3 Two registers are deliberately EMPTY — and the second is the more interesting

**`CNF-EVT-` is empty because `BC-25` publishes no event.**

BC Map §9 was read in full. It enumerates **14 producing contexts** — `BC-01`…`BC-06`, `BC-10`…`BC-13`, `BC-18`,
`BC-19`, `BC-20`, `BC-27` — and **`BC-25` is not one of them**. A grep of §9 for
`configuration\.|config\.|settings\.|flag\.` returns **0**. `BC-25`'s only appearance in BC Map §7 is **`E-19`**,
which is a **synchronous port**, not an event edge. BC Map §7 L292 rules that an edge not in the table does not
exist.

This is the fourth consecutive platform PRD to declare an event register empty for a measured reason — `PRD-013`
(`TEN-CFG-*`), `PRD-016` (`AUD-EVT-*`), `PRD-014` (`ENT-EVT-*`), and now this one. **`CNF-FR-051`** states the
prohibition positively, so the emptiness is enforceable rather than incidental, and **`CNF-FR-052`** routes the
audit obligation through the edge that already exists.

**`CNF-CFG-` is empty because a configuration module that configures itself would be its own first defect.**

This deserves stating plainly, because the irony is the argument. `PRD-023` owns the **machinery** by which a value
is declared, defaulted, ranged, inherited and resolved. It owns **no value** — `ADR-0017` §3.1 item 6: *"`PRD-023`
owns the resolution machinery, **not the value list**."* Every one of the **104** configurables measured in this
repository belongs to one of **eight other PRDs**, all FROZEN (§3.6).

To publish a `CNF-CFG-*` value, this document would have to invent a default and a range for a parameter no
document at any rank bounds — the Stage 4 failure *"unbounded configuration is a specification hole"*, and exactly
the risk `ADR-0017` §5.3 pre-registers as *"`PRD-023` grows to absorb entitlement or security scope"* in its most
seductive form. The tempting candidates were considered and refused:

| Tempting `CNF-CFG-*` candidate | Why refused |
|---|---|
| Configuration cache TTL | EA places `Config Cache` at **V2** (L518). `LCFG-13` already bounds a preview cache and belongs to `PRD-002`. Inventing a second cache bound at Rank 3 would create a competing owner |
| Resolution timeout for `E-19` | `E-19` is a **synchronous in-process port** (§4.2), not a network call. A timeout would imply an architecture this document does not specify |
| Hot-reload interval | `Runtime Configuration` is **V2** throughout the EA tree (L515–521). Out of V1 scope |
| Maximum override depth | The hierarchy has **exactly five** levels, fixed by `ADR-0017` §3.1 item 1. A fixed structure is not a configurable — `CONFIGURATION_GUIDE.md` §1 *"What is NOT configurable"* |

> An empty register that names its reason is a finding. An empty register that says nothing is an omission.

### 0.4 Citation discipline — four near-misses that would misattribute a requirement

| Risk | Correct usage |
|---|---|
| `INV-n` vs `CNF-INV-n` | `INV-1`…`INV-16` are **platform invariants** in `CONFIGURATION_GUIDE.md` §3, registered at `TRACEABILITY_MATRIX.md` L82. `INV-SEC-*` and `INV-XC-*` also exist. `CNF-INV-*` is a **distinct register**. Any scan must be anchored (`\bCNF-INV-`); a naive `grep 'INV-'` over-counts. **This matters more here than in any other PRD, because `INV-1`…`INV-16` are this module's subject matter** |
| *Setting* vs *Configuration* | Not synonyms in this document. §2 fixes both. A reader who treats them as interchangeable will mis-assign `CNF-FR-001`…`CNF-FR-011` |
| `CFG-017` | **Does not exist as a register member.** It is an in-prose abbreviation of `SEAT-CFG-017` at three locations in `PRD-007`'s review records. `PRD-001`'s register closes at `CFG-12`. Stage 1 §4.6 |
| A flag vs an entitlement | `ADR-0017` §3.1 item 2: *"a flag says **is this on**; an entitlement says **is this paid for**."* `PRD-014` `ENT-BR-004` states the same boundary from the other side and is **FROZEN**. §6 |

### 0.5 What this document deliberately does **not** restate

Restatement creates a second source of truth, which `PRD_LIFECYCLE.md` L118 names a Stage 4 failure. The rule
followed here is the one `TRACEABILITY_MATRIX.md` L209–210 already established: *"`SMCFG-1` is **cited rather than
duplicated** — `SMCFG-1` **is** `LCFG-5`, consumed through `E-19`."*

| Subject | Owner | This document's posture |
|---|---|---|
| The **104 configurable values** and every default, range and rationale | 8 PRDs, all **FROZEN** (§3.6) | **Cited, never restated.** `CNF-XC-001` |
| `LCFG-1`…`LCFG-13` definitions | `PRD-002` — §16.1 (**1–10**) and §14B.9 (**11–13**) | Cited. `CNF-XC-002` |
| `INV-1`…`INV-16` **statements** | `CONFIGURATION_GUIDE.md` §3 (Rank 7) | Cited. This module owns their **enforcement** (§5), not their text. `CNF-XC-003` |
| Tenant lifecycle, `TenantContext`, tiers, residency | `BC-19` / `PRD-013` (**FROZEN**) | Consumed via `E-18`. `CNF-XC-004` |
| Entitlement gates, quotas, `check(tenantId, feature, delta)` | `BC-21` / `PRD-014` (**FROZEN**) | Cited. `CNF-XC-005` |
| Authorisation decisions, roles, sessions, credentials | `BC-18` | Consumed via `policy_decision`. `CNF-XC-006` |
| Secret **material**, key management, rotation | **SECURITY** platform | `CNF-XC-007`, `CNF-XC-008` |
| `LibraryBranding` **aggregate**; image **bytes** | `PRD-002`; `BC-29` / `PRD-017` | `CNF-XC-009`, `CNF-XC-010` |
| `BranchPolicy`, working hours, holidays, attendance and seat rules | `BC-06` | `CNF-XC-011` |
| Audit persistence, retention, query | `BC-24` / `PRD-016` (**FROZEN**) | Emitted to via `E-20`. `CNF-XC-012` |
| The event delivery contract — outbox, at-least-once, envelope, ordering, replay | BC Map **§9.1** (Rank 4) | **Cited, not reproduced.** Vacuous here: `CNF-EVT-*` is empty |
| Environment profile **values** (dev/staging/production) | `CONFIGURATION_GUIDE.md` §4 (Rank 7) | Cited. This module owns the **precedence** of an environment profile against a tenant override (§3.5) |
| Tenant partitioning as a platform rule | `MP-GBR-06`…`MP-GBR-09` (Rank 1) | Cited. This module's obligations are §10 |

---

## 1. Purpose and scope

### 1.1 Purpose

`BC-25` Configuration owns the answer to one question, asked by every other context: **given a key, whose value
applies here, and what is it?**

BC Map **L134**, verbatim:

```
| **BC-25** | **Configuration** | `[GENERIC]` | Configuration | V1 | Owns settings hierarchy, feature flags,
branding values, secret *references*. |
```

Four nouns, and the first is the load-bearing one. A *hierarchy* is not a store. Any context can hold a key–value
table; what `BC-25` owns is the **resolution** of a key across five scopes into exactly one effective value, and
the **typed contract** through which that value reaches domain code without a string.

### 1.2 Why this PRD exists

Not because a gap was noticed. Because a Rank 2 decision instructed it, and the instruction has been outstanding
since 2026-08-04.

`ADR-0017` §3.3, verbatim: *"It **registers** a document; it does not write one. `PRD-023` is `PLANNED`."*
This document discharges that registration. Three independent facts make it overdue rather than optional:

| Fact | Evidence |
|---|---|
| **`E-19` binds every context and is specified in one table cell.** 35 references across `docs/` cite the constraint; **none specifies it** | Stage 1 `M-21`; BC Map L328 |
| **Seven modules declare a dependency on a port no module provides** | Stage 1 `M-08`/`M-09`; `tool/module_dependencies.yaml` L108, 182, 240, 280, 309, 336, 513 |
| **A FROZEN PRD names `PRD-023` as co-owner of an open High-severity gap** | `PRD-014` `ENT-GAP-002` L580, owner *"Governance Owner and `BC-25` / `PRD-023`"* |

`SID-4.56` decides the significance of the first: *"A rule that cannot be checked SHALL be treated as **unmet**."*
`E-19` is currently unmet in every context that cites it — including four FROZEN PRDs that assert compliance with
it (`PRD-004` `LMD-6`, `PRD-005` §13.4, `PRD-007` `SEAT-FR-263`, `PRD-006` L233). They are not wrong; they are
conforming to a contract that has never been written down. Writing it is this document's central obligation.

### 1.3 Scope band — foundational, and what that forbids

BC Map **L271** places `BC-25` in a three-member band:

```
║  FOUNDATIONAL  ·  BC-18 Identity & Access   ·   BC-19 Tenancy   ·   BC-25 Configuration
║  Every context depends on these three. They depend on nothing above them.
```

The second sentence is a prohibition, and it is the tightest constraint in this document. `platform/configuration`
is **rank 3**; `platform/tenancy` and `platform/identity` are both **rank 4**, above it.

**The prohibition is real, but the mechanism is not the rank comparison — and stating it as one would be wrong.**
The rank law is checked on **imports only**: `tool/check_module_boundaries.dart` §1 declares *"Rank ordering — a
module may import only strictly lower ranks (L2)"*, and `_checkRankOrdering` takes the file's **import list** as its
only input. Ports are deliberately outside it, because a port is *"an interface declared by consumer, implemented
elsewhere, DI-wired (**NO import**)"* (manifest MODES). Two measurements confirm that reading the rank table alone
would mislead:

| Measurement | Result | Consequence for this document |
|---|---|---|
| `platform/identity` (rank 4) declares `platform/tenancy:tenant_context` (rank 4) as a **port** | Present, unflagged | A **same-rank** port is lawful when declared. Rank alone forbids nothing here |
| Matrix §8.3 L403 — *"`TenantContext` is needed at **R2**… the `TenantContext` **interface** and its read-only accessor live in `liboora_contracts` (**R0**)"* | R0 interface | Reading tenant context is **not** an upward dependency for anyone, at any rank |

So the honest basis for §9 and §10 is **the manifest's closed-world rule, not arithmetic**:

- `default_decision: deny` — *"anything not listed is forbidden."*
- `platform/identity` publishes `policy_decision` with an explicit consumer list:
  `[domain/library, domain/social, platform/ai, platform/analytics, platform/workflow]`. **`platform/configuration`
  is not on it.** An authorisation call from this module is therefore forbidden by omission, mechanically, today —
  which is a far stronger guarantee than a rank inequality would have given.
- BC Map **L271** independently forbids this band from depending on anything above it.

**`CNF-XC-006`** rests on those three facts. What follows for §9 and §10 is unchanged in substance: permission
enforcement is a **caller obligation discharged at the boundary**, and scope identifiers are **inputs**
(`CNF-FR-012`). What changes is the reason. Tenant scoping is specified as an explicit argument not because
ambient context is unreachable — Matrix §8.3 shows it is reachable from R0 — but because a five-scope resolution
cannot be driven by a one-scope ambient (§3.1, §10.2).

> A further measurement, recorded rather than repaired: **`platform/configuration` has no module block in
> `tool/module_dependencies.yaml` at all.** It appears only as a rank and as a port consumed by seven others. Under
> `default_decision: deny` an undeclared module can declare no dependency lawfully, so the module cannot be built
> until the block exists. That is a Stage 6 obligation, recorded as **`CNF-GAP-007`**, not a defect in the manifest.

### 1.4 The aggregate question — carried forward unresolved, on purpose

Stage 1 `F-01` recorded a genuine conflict between two ranks:

| Rank | Document | Statement |
|---|---|---|
| **3** | `Library_PRD_v1.md` **L188** (FROZEN v1.1) | `| **LibrarySettings** | BC-25 | Settings hierarchy and feature flags |` |
| **4** | BC Map **§8** | **17 aggregate rows**, enumerated in full. **`BC-25` is not among them** |

This document **does not settle it**, and every requirement below is written so that it does not need to.
No `CNF-FR-*` asserts an aggregate name; §3 specifies resolution over a *scope hierarchy* without naming a root
entity. `PRD_LIFECYCLE.md` §6 assigns architecture judgements to the **architecture reviewer** at Stage 3, and
`PRD-019`'s failure is the precedent for why that matters: six of six checks aligned, verdict **NOT CONFERRED**,
because the wrong role authored the record.

Recorded as **`CNF-GAP-001`**. Stage 3 must dispose of it in one of exactly three ways: confirm `LibrarySettings`
as the aggregate; rule that `BC-25` owns no §8-sense aggregate and that its ownership is contractual; or raise a
Rank 3 ↔ Rank 4 defect to the governance owner.

### 1.5 Module identity

| Property | Value | Authority |
|---|---|---|
| Module | `platform/configuration` | `tool/module_dependencies.yaml` L31 |
| Rank | **3** | yaml L31 — below `platform/tenancy` (4) and `platform/identity` (4) |
| Declared port | `platform/configuration:settings` | yaml L108, 182, 240, 280, 309, 336, 513 |
| Declared consumers | **7** | Same |
| Declared providers | **0** | `provides_ports` blocks exist only at yaml L188 and L442 |
| Module block in the manifest | **Absent** | As are those of 8 of 17 platform modules — so the absence is *true but not distinguishing* (Stage 1 `F-09`) |
| Code on disk | **None.** `find lib packages -iname "*config*" -o -iname "*setting*"` → **0 files** | Stage 1 `M-12` |

**Everything in this document is greenfield.** Nothing may be recorded at Stage 6 as satisfied-in-place.

---

## 2. Settings and Configuration are not the same thing

The Stage 2 mandate names *"Settings vs Configuration terminology"* first. The repository already uses both words,
at four different ranks, and mostly consistently — but never with the distinction stated. Stating it is a
requirement because the two have **different actors, different change paths and different blast radii**, and a
reader who conflates them will mis-assign roughly a third of this document.

### 2.1 The distinction, fixed

**`CNF-FR-001`** — This document **SHALL** use the following two terms with the following distinct meanings, and
**SHALL NOT** use them interchangeably:

| Term | Definition | Actor | Changed by | Blast radius |
|---|---|---|---|---|
| **Setting** | A value a **tenant-facing actor** may change for their own scope, within a range the specification fixed | `TR-1` Owner, `TR-2` Manager (§9) | A product action, at runtime, audited | One tenant, library or branch |
| **Configuration** | The **whole machinery** — the register of what is settable, the declared defaults, the ranges, the five-scope hierarchy, the resolution algorithm, the typed accessors, and the deployment-time values | Operator, deployer, specification author | A deployment, or a **PRD amendment** | The platform |

**`CNF-FR-002`** — Every **Setting** **SHALL** be a member of the Configuration register. The converse **SHALL
NOT** hold: a configuration parameter is a Setting **only** where its owning PRD declares it tenant-changeable.

The repository already draws this line and this requirement only names it. `CONFIGURATION_GUIDE.md` §4:
*"`LCFG-1`…`LCFG-5` and `LCFG-7`…`LCFG-10` are **per-library settings, not per-environment**. They are set by each
library **through `BC-25`**."* Those nine are Settings. `CFG-1`…`CFG-12` appear in the environment-profile table
and are **not** Settings — no library sets its own OTP quota. Both are Configuration.

**`CNF-FR-003`** — A parameter's classification as Setting or not-Setting **SHALL** be declared by its **owning
PRD**, not by this module. This module **SHALL** carry the declaration and enforce it; it **SHALL NOT** originate
it.

> **Why `CNF-FR-003` is a prohibition and not a convenience.** `CONFIGURATION_GUIDE.md` §5 already assigns the
> right: *"**Adding a parameter** — a PRD amendment. **The specification declares what is configurable, this guide
> does not.**"* If `PRD-023` could promote a value to tenant-settable, it could hand a tenant control over a
> parameter its owning PRD deliberately kept platform-wide — and `SID-5.45` says of the Student Identity register
> *"Every value above **SHALL** be platform-wide."* One line in this module could void that sentence. So it cannot.

### 2.2 Three words that are not synonyms either

**`CNF-FR-004`** — This document **SHALL** distinguish the following, which the repository's prose sometimes runs
together:

| Term | Meaning here | Not to be confused with |
|---|---|---|
| **Default** | The value that applies when no scope has set anything. Declared by the owning PRD, non-negotiable at runtime | An *override* set at the platform-default scope, which is a resolution outcome, not a declaration |
| **Override** | A value stored at a scope, displacing what would otherwise be inherited | A default. An override can be removed; a default cannot |
| **Effective value** | The single value resolution produces for a given key in a given context | Either of the above. It is **derived**, never stored (`CNF-INV-004`) |

**`CNF-FR-005`** — The term *effective value* **SHALL** refer only to the output of the resolution algorithm in
§3.3, and the module **SHALL NOT** expose any read surface that returns a stored override as though it were an
effective value (`CNF-AC-011`).

### 2.3 What this module calls a key

**`CNF-FR-006`** — Every configurable parameter **SHALL** be addressed by a **stable identifier owned by its
declaring PRD** — `CFG-5`, `LCFG-6`, `SEAT-CFG-017`, and so on — and that identifier **SHALL** be the sole
canonical name of the parameter across the platform.

**`CNF-FR-007`** — The module **SHALL NOT** mint a second naming scheme, alias, namespace or numeric key for a
parameter that already has a declared identifier.

> **`CNF-FR-007` prevents the failure `PRD-014` `ENT-FR-019` prevented in its own domain** — *"the module **SHALL**
> use it rather than introduce a parallel one."* The repository has 104 configurables under **eight** prefixes
> (§3.6). A `BC-25`-local key space would make that nine, and the ninth would be the only one no PRD owns.

**`CNF-FR-008`** — A parameter identifier **SHALL** be treated as permanent. Retirement follows the register
convention of its owning PRD; **a retired identifier SHALL NOT be reused** by this module for any purpose,
including as a storage key (`CNF-BR-011`).

### 2.4 Terminology this document refuses to introduce

| Refused term | Why |
|---|---|
| *Feature toggle* | EA L530 lists `Feature Toggles` as a **V2** node distinct from `Feature Flags`. This document specifies flags only (§6) and will not import a V2 distinction it cannot define |
| *Kill switch* | EA L520, **V3** |
| *Experiment* / *variant* / *targeting rule* | EA L534–535, **V3**. Introducing the vocabulary would invite the scope creep `ADR-0017` §5.3 pre-registers |
| *Config template* | EA L511, **V2** |
| *Secret* (unqualified) | Ambiguous between reference and material, and the boundary is the whole point of §7. This document says **secret reference** or **secret material**, never *secret* alone |

---

## 3. The settings hierarchy and effective-value resolution

This is `ADR-0017` §3.1 item 1, and the largest single obligation in the document. The item, verbatim:

> *"1. The **settings hierarchy** and its precedence order — platform default → tenant → library → branch → user."*

### 3.1 The five scopes

**`CNF-FR-009`** — The settings hierarchy **SHALL** consist of exactly **five** scopes, in the following
precedence order from weakest to strongest:

| # | Scope | Identified by | Populated today | Authority |
|---:|---|---|---|---|
| 1 | **Platform default** | The parameter's declared default | ✔ All 104 parameters | Each owning PRD's register |
| 2 | **Tenant** | `tenantId` | ✔ e.g. `MM-CFG-001`, `MM-CFG-006`; `LIB-16.1` *"resolvable per tenant"* | `PRD-005` §13.4; `PRD-002` `LIB-16.1` |
| 3 | **Library** | Library identity within the tenant | ✔ 9 of the 13 `LCFG-*` | `CONFIGURATION_GUIDE.md` §4 |
| 4 | **Branch** | `branchId` | **Named, never specified** | `LIB-2.2`, `LIB-9.2`: *"Every branch-scoped record **MUST** carry `branchId`"* |
| 5 | **User** | Account identity | **Empty** | — |

**`CNF-FR-010`** — The number of scopes and their order **SHALL** be structural, not configurable. No parameter,
deployment, tenant or role **SHALL** be able to add a scope, remove one, or reorder the precedence.

> This follows `CONFIGURATION_GUIDE.md` §1's *"What is NOT configurable"* discipline and `Library_PRD_v1.md`
> §16.1's rule — *"Values are **configurable**; their **ranges and invariants are not**."* A reorderable
> precedence chain would make every effective value a function of configuration about configuration, which is
> unauditable.

**`CNF-FR-011`** — Scopes 4 (branch) and 5 (user) **SHALL** be **structurally present and functionally
unpopulated** in V1. The resolution algorithm **SHALL** traverse them; no parameter is declared at them.

> **`CNF-FR-011` is deliberately the shape it is, and the alternative was rejected.** Stage 1 `R-10` refused to
> invent a user-scoped configurable to populate level 5, because `SID-5.45` runs the other way — *"Every value
> above **SHALL** be platform-wide"* — and Stage 4 requires every configurable to carry a default and a range.
> But omitting the two levels from the algorithm was equally wrong: `ADR-0017` §3.1 fixes **five**, and
> `LIB-2.2` records that adding `branchId` later *"is a migration across every tenant-scoped table."* The
> traversal is therefore built once and stays empty until a PRD declares a value at those scopes. Recorded as
> **`CNF-GAP-003`**.

### 3.2 Scope is not authorisation, and is not tenancy

**`CNF-FR-012`** — A scope identifier **SHALL** be an **input** to resolution, supplied by the caller. The module
**SHALL NOT** derive, infer, look up or default any scope identifier.

**`CNF-FR-013`** — Resolution **SHALL NOT** be attempted with an unresolved tenant scope. A read whose tenant
scope is absent **SHALL** fail (§10, `CNF-FR-064`).

> Both requirements follow from §1.3, but **not** from a rank inequality — §1.3 records why that argument does not
> hold. Ambient `TenantContext` is reachable from `liboora_contracts` (R0) by every rank, so availability is not
> the constraint. The constraint is arity: resolution takes **five** scope identifiers (§3.1) and an ambient
> carries **one**. Four of the five would still have to be arguments, so a hybrid signature would be strictly worse
> than a uniform one — it would hide one input and declare four. `PRD-013` `TEN-FR-015` forbids passing tenant
> context as a **domain method** parameter; this is a **platform port**, not a domain method, and `PRD-014`
> `ENT-FR-014` establishes the precedent directly: *"`tenantId` **SHALL** be an explicit argument of `check`, not
> an ambient value."* §10.2 states the full argument, including why this does not weaken `MP-GBR-06`.

### 3.3 The resolution algorithm

**`CNF-FR-014`** — For a given parameter identifier and a given set of scope identifiers, resolution **SHALL**
produce **exactly one** effective value, by selecting the value stored at the **strongest scope at which an
override exists**, and the declared default where none exists.

**`CNF-FR-015`** — Resolution **SHALL** be **total**: every parameter in the register **SHALL** resolve to a value
for every valid scope combination. There **SHALL** be no input for which resolution yields nothing.

**`CNF-FR-016`** — Resolution **SHALL** be **deterministic**: the same parameter and the same scope identifiers,
against the same stored state, **SHALL** yield the same effective value.

**`CNF-FR-017`** — Resolution **SHALL NOT** merge, combine, average or otherwise blend values from two scopes.
A stronger scope's override **SHALL** displace a weaker one entirely.

> **`CNF-FR-017` forecloses a real design temptation.** For a scalar (`LCFG-1` Time Zone) displacement is
> obvious. For a *collection* — `LCFG-8` Facilities, a reference list — "inherit the tenant list and add two at
> branch level" is a plausible-sounding feature. It is refused: a merged collection has no single owning scope,
> so no reader can answer *"who set this?"*, and audit (§8) becomes unattributable. EA lists
> `Bulk Configuration` at **V3** (L512); a merge semantics is that conversation, not this one.

**`CNF-FR-018`** — The module **SHALL** expose, for any resolved value, the **scope at which it was resolved**.
A caller **SHALL** be able to distinguish an inherited value from an explicitly-set one without inspecting
storage.

> **Why `CNF-FR-018` is a requirement and not a nicety.** `LIB-16.2` requires that *"a library that has changed
> nothing **MUST** be fully operable."* That guarantee is only testable if "has changed nothing" is
> observable — and it is exactly what a settings UI must render to avoid showing an inherited value as though the
> library had chosen it (§12).

**`CNF-FR-019`** — Removing an override **SHALL** be a distinct operation from setting a value, and **SHALL**
restore inheritance from the next weaker scope. It **SHALL NOT** be expressible as setting the value to the
inherited value.

> Those two produce identical effective values today and diverge the moment the weaker scope changes. Conflating
> them would silently pin a value that the tenant believed it had left to inherit.

**`CNF-FR-020`** — A default **SHALL NOT** be storable as an override at scope 1. The platform-default scope
**SHALL** be the parameter's declared default as published by its owning PRD, and **SHALL NOT** be writable at
runtime by any actor, including a platform role.

> **`CNF-FR-020` is the strongest prohibition in §3**, and it is what keeps `CNF-XC-001` enforceable. If a
> platform actor could write scope 1, `PRD-023` would hold an effective write path over all 104 values owned by
> eight FROZEN PRDs — the ownership breach `ADR-0017` §3.2 forbids, achieved through a storage feature rather
> than a specification change. `CONFIGURATION_GUIDE.md` §5 already routes default changes elsewhere:
> *"Value outside its declared range — **an ADR**."*

### 3.4 Validation

**`CNF-FR-021`** — Every write **SHALL** be validated against the parameter's declared **type** and **range**
before persistence, and an invalid write **SHALL** be rejected.

**`CNF-FR-022`** — A rejected write **SHALL** state a specific reason identifying the parameter and the
constraint violated. A generic failure **SHALL NOT** be sufficient.

**`CNF-FR-023`** — A rejected write **SHALL NOT** be partially applied. Where a write covers several parameters,
either all are persisted or none is.

> `CNF-FR-021`…`CNF-FR-023` are the mechanism for `LIB-16.3`, which is FROZEN Rank 3 and states the obligation
> without saying who discharges it: *"Every setting change **MUST** be validated before persistence. An invalid
> value **MUST** be rejected with a specific reason, and **MUST NOT** be partially applied."* This document does
> not restate that requirement — it specifies the machinery that makes it true, for every register, not only
> `LCFG-*`.

**`CNF-FR-024`** — A parameter **SHALL NOT** be registrable without both a declared **default** and a declared
**range or enumerated domain**. The module **SHALL** refuse to serve a parameter that lacks either.

> This is `PRD_LIFECYCLE.md`'s Stage 4 check — *"every configurable has a default and a range"* — implemented as
> a runtime refusal rather than a review comment. Under `SID-4.56` a rule that cannot be checked is unmet; this
> makes it checkable at the only point where it matters.

**`CNF-FR-025`** — Validation **SHALL** be applied identically to writes originating from a product action, a
deployment, a migration, a support path and a test fixture. There **SHALL** be no path that bypasses it.

### 3.5 Environment profiles against tenant overrides

`CONFIGURATION_GUIDE.md` §4 publishes development, staging and production values for 30 parameters, and §4's own
note carves out nine `LCFG-*` as *"per-library settings, not per-environment"*. The interaction of the two axes is
unspecified anywhere in the repository, and it must be, because both can supply a value for the same key.

**`CNF-FR-026`** — An environment profile **SHALL** supply the value at scope **1 (platform default)** for the
deployed environment, and **SHALL NOT** constitute a sixth scope.

**`CNF-FR-027`** — Where a parameter is declared tenant-settable, a tenant override **SHALL** take precedence over
the environment profile value, because the environment profile occupies the weakest scope.

**`CNF-FR-028`** — Where a parameter is **not** declared tenant-settable (`CNF-FR-003`), no override **SHALL** be
storable at any scope, and the environment profile value **SHALL** be the effective value unconditionally.

> **`CNF-FR-028` is what makes `CFG-1`…`CFG-12` safe.** Those are authentication controls. If the hierarchy
> allowed a tenant override on an unsettable parameter, a library could raise its own OTP quota — and
> `CONFIGURATION_GUIDE.md` §4 rule 2 is explicit that development relaxations *"must never disable a control,
> never bypass OTP"*, which no environment-level rule can enforce if a runtime scope can override it anyway.

**`CNF-FR-029`** — The module **SHALL NOT** select, derive or infer the active environment. The active profile
**SHALL** be supplied at deployment and **SHALL** be immutable for the lifetime of the process.

### 3.6 The 104 values this module resolves and does not own

Measured word-anchored across `docs/`, Stage 1 `M-16`. Every owning PRD is **FROZEN**.

| Register | Count | Owning PRD | Status | Definition site |
|---|---:|---|---|---|
| `CFG-1` … `CFG-12` | **12** | `PRD-001` Authentication | FROZEN v2.0 | `CONFIGURATION_GUIDE.md` §2 |
| `LCFG-1` … `LCFG-13` | **13** | `PRD-002` Library | FROZEN v1.1 | **§16.1 (1–10) and §14B.9 (11–13)** |
| `ICFG-1` … `ICFG-10` | **10** | Invitation Security Spec | Rank 3 | `CONFIGURATION_GUIDE.md` §2B |
| `SCFG-1` … `SCFG-11` | **11** | `PRD-003` Student Identity | FROZEN v1.0 | §5.5 |
| `SMCFG-1` … `SMCFG-7` | **7** | `PRD-004` Student Management | FROZEN v1.2 | §10.3 |
| `MM-CFG-001` … `MM-CFG-009` | **9** | `PRD-005` Membership | FROZEN v1.4 | §13.4 |
| `SEAT-CFG-001` … `SEAT-CFG-018` | **18** | `PRD-007` Seat | FROZEN v1.0 | §27.1 |
| `ATT-CFG-001` … `ATT-CFG-024` | **24** | `PRD-006` Attendance | FROZEN v1.9 | Its own register |
| `TEN-CFG-*` | **0** | `PRD-013` | FROZEN | **Declared empty**; `TEN-CFG-001` retired |
| `AUD-CFG-*` | **0** | `PRD-016` | FROZEN | **Declared empty** |
| `ENT-CFG-*` | **0** | `PRD-014` | FROZEN | **Declared empty** |
| **Total** | **104** | **8 owning PRDs** | **all FROZEN** | |

**`CNF-XC-001`** — The module **MUST NOT** define, change, re-range, re-default, rename, retire or reclassify any
of the 104 parameters above, or any parameter added to those registers in future. *Owner: each register's PRD.*
*(`ADR-0017` §3.2: "This ADR moves no requirement." `CONFIGURATION_GUIDE.md` §5: "Adding a parameter — a PRD
amendment.")*

**`CNF-XC-002`** — The module **MUST NOT** hold, restate or relocate the `LCFG-1`…`LCFG-13` definitions.
*Owner: **`PRD-002`**.* *(`ADR-0017` §3.1 item 6, verbatim: "The `LCFG-1`…`LCFG-13` definitions stay in the Library
PRD; `PRD-023` owns the resolution machinery, **not the value list**." Note the two definition sites — §16.1
covers `LCFG-1`…`LCFG-10`, §14B.9 covers `LCFG-11`…`LCFG-13`.)*

**`CNF-FR-030`** — The module **SHALL** serve a parameter only where an owning PRD has declared it. A parameter
present in storage but absent from the register **SHALL NOT** be served, and its presence **SHALL** be reported as
a defect (`CNF-AC-018`).

> **`CNF-FR-030` is the anti-drift requirement.** Without it, configuration becomes the one place in the platform
> where state can exist that no specification describes — and it would be undetectable, because a key–value store
> answers every question you ask it.

---

## 4. The `E-19` typed-accessor contract

`ADR-0017` §3.1 item 5: *"The **`E-19` typed-accessor contract** — the mechanism enforcing *no raw string lookups
in domain code*."*

This is the section the repository has been waiting for. Stage 1 `M-21` measured **35** references to typed
configuration, typed accessors or raw string lookups across `docs/` — **every one cites the constraint, none
specifies it**. Four FROZEN PRDs assert conformance to it (`PRD-004` `LMD-6`, `PRD-005` §13.4, `PRD-007`
`SEAT-FR-263`, `PRD-006` L233), and `PRD-003` `SID-4.47` states it as its own requirement. Under `SID-4.56` —
*"A rule that cannot be checked SHALL be treated as unmet"* — all five are currently unmet, through no fault of
their own.

### 4.1 The edge, verbatim

BC Map **§7.3 L328**:

```
| E-19 | All contexts | BC-25 Configuration | `CF` | Sync port | Typed config accessors; no raw string
lookups in domain code |
```

Four facts are fixed by that cell and are not this document's to change: the **direction** (all contexts → `BC-25`),
the **relationship** (`CF`, conformist — the consumer conforms, it does not translate), the **mode**
(**synchronous port**, not an event), and the **constraint** (typed accessors; no raw string lookups in domain
code).

### 4.2 The port

**`CNF-FR-031`** — The module **SHALL** expose its read surface as the registered port
**`platform/configuration:settings`**, and **SHALL NOT** rename it. *(Declared by 7 consumers in
`tool/module_dependencies.yaml`; renaming it would break every one.)*

**`CNF-FR-032`** — The port **SHALL** be **synchronous**. The module **SHALL NOT** require a caller to await an
event, a subscription or a background refresh in order to obtain an effective value. *(BC Map L328, "Sync port".)*

**`CNF-FR-033`** — The port **SHALL** be the **sole** means by which any context obtains a configuration value.
No context **SHALL** read configuration storage directly, and no configuration value **SHALL** reach a context by
any other route.

**`CNF-FR-034`** — The port's relationship to its consumers **SHALL** be **conformist**: consumers accept the
contract as published. The module **SHALL NOT** provide a per-consumer variant, adapter or translation layer.
*(BC Map L328, `CF`.)*

### 4.3 What "typed" means — stated, because nothing else states it

**`CNF-FR-035`** — An accessor **SHALL** be typed in the sense that all four of the following hold. A surface
satisfying fewer than four **SHALL NOT** be described as a typed accessor:

| # | Property | Consequence if absent |
|---:|---|---|
| 1 | The **parameter is named in the accessor's identity**, not passed as a value | A caller can construct a key at runtime, and no scan can enumerate what is read |
| 2 | The **return type is the parameter's declared type**, not a string, a dynamic, a map or a nullable of them | Every call site re-implements parsing, and they will diverge |
| 3 | **Absence is not representable in the return type.** Resolution is total (`CNF-FR-015`), so there is no null case for the caller to handle | A nullable return invites `?? someDefault` at the call site — a second, invisible default |
| 4 | A **misspelled or non-existent parameter fails before execution**, not at the moment of the read | The failure surfaces in production, on the least-travelled path |

> **Property 3 is the one most likely to be lost in implementation, and it is the one that matters most.**
> A nullable return is the mechanism by which a hard-won default in a FROZEN PRD gets quietly replaced by whatever
> the developer typed after `??`. `LIB-16.2` guarantees that *"a library that has changed nothing **MUST** be
> fully operable"* — a guarantee owned by `PRD-002` and dischargeable only if this module never hands a caller the
> opportunity to supply its own fallback.

**`CNF-FR-036`** — The module **SHALL NOT** expose any accessor that takes a parameter identifier as a runtime
string, including as an enum-of-strings, a constant reference or a builder argument.

**`CNF-FR-037`** — The module **SHALL NOT** expose a generic read surface — no `get(key)`, no `getAll()`, no map,
no dictionary, no iteration over the register — to any domain or app context.

> **`CNF-FR-036` and `CNF-FR-037` together are the entire content of *"no raw string lookups in domain code."***
> The prohibition is usually read as a coding rule for consumers. It is not enforceable that way: the only
> reliable way to prevent a string lookup is for **no string-taking surface to exist**. This is the same design
> logic `PRD-016` used for immutability — `AUD-XC-001` forbids the *method from existing* rather than forbidding
> its use — and the boundary checker enforces it by name.

**`CNF-FR-038`** — The typed surface **SHALL** be declared such that the set of parameters a module reads is
**statically enumerable** from its source, without executing it.

> This is what makes `CNF-AC-020` and the Stage 6 verification possible at all. A configuration dependency that
> can only be discovered by running the program is not a dependency any architecture test can check.

### 4.4 Where the interface is declared

**`CNF-FR-039`** — The typed accessor interface **SHALL** be declared in the rank-0 shared kernel
(`liboora_contracts`), so that a consumer at any rank depends on the contract rather than on this module.

**`CNF-FR-040`** — Declaring the interface in the shared kernel **SHALL NOT** constitute a transfer of ownership.
`BC-25` remains the owner of the contract and its semantics.

> The precedent is exact and is worth naming, because it is the only reason `CNF-FR-039` does not break a law.
> `PRD-013` §0.4 records the identical arrangement for `TenantContext`: *"Declaring an interface in the shared
> kernel is **not** an ownership transfer… this is why neither `L2` nor `L4` needed an exception."* Matrix §6.3
> L336 already limits the kernel to *"only ports of universal reach (TenantContext, Telemetry, Clock)"* — and
> `E-19` is by construction of universal reach, since its source column reads *"All contexts."* Whether the kernel
> list should be extended to name it is a Rank 4 question, recorded as **`CNF-GAP-004`** rather than assumed.

**`CNF-FR-041`** — The module **SHALL** be bound to the port at the composition root. No consumer **SHALL** import
`platform/configuration`.

> Currently **nothing** binds it: 7 consumers, 0 providers (`CNF-GAP-002`). `tool/module_dependencies.yaml`'s
> header sets `default_decision: deny`, so the manifest is not wrong — the implementation is absent.

### 4.5 Failure modes, stated so they can be tested

**`CNF-FR-042`** — A read of a parameter absent from the register **SHALL** fail. It **SHALL NOT** return a null,
an empty value, a zero, or a type default.

**`CNF-FR-043`** — A read attempted before the register is loaded and validated **SHALL** fail. It **SHALL NOT**
return a partially-loaded view. *(§5, `CNF-FR-047`.)*

**`CNF-FR-044`** — A stored value that fails to satisfy its declared type or range at read time **SHALL** fail
loudly. It **SHALL NOT** be silently coerced, clamped or replaced by the default.

> **`CNF-FR-044` deliberately refuses the forgiving behaviour.** Falling back to the default on a corrupt stored
> value is the friendlier implementation and the wrong one: the system would run correctly-looking while a
> tenant's chosen value was being ignored, indefinitely, with no signal. `CONFIGURATION_GUIDE.md` §3 already sets
> the house posture — *"A violation is a fatal configuration error — fail fast and loudly. A silently inconsistent
> security configuration is worse than a wrong one, because nobody notices."*

**`CNF-FR-045`** — A failure in this module **SHALL NOT** be recoverable by substituting a value. There **SHALL**
be no degraded mode in which configuration serves best-effort values.

> **This is where `PRD-023` diverges from `PRD-014` on purpose, and the divergence should be visible.**
> `PRD-014` `ENT-FR-018` leaves the fail-open/fail-closed disposition of an entitlement check *per feature, to a
> configured value*. Configuration cannot take the same shape: a configurable fail-open policy for the
> configuration subsystem would have to be resolved by the subsystem that is failing. The recursion is not an
> implementation inconvenience; it is why this requirement is absolute and `ENT-FR-018` is not.

**`CNF-FR-046`** — A read **SHALL NOT** be satisfied from a cache whose contents were resolved under different
scope identifiers. *(`MP-GBR-09`; §10.)*

---

## 5. Invariant enforcement — `INV-1` … `INV-16`

`CONFIGURATION_GUIDE.md` §3 publishes sixteen cross-parameter invariants and states the obligation:
*"These must be **validated at application startup**. A violation is a fatal configuration error."*
It does not say **who** validates them. Seven of them (`INV-10`…`INV-16`) **cross register boundaries** — the
guide's own observation: *"Changing an authentication parameter can therefore invalidate a library configuration…
It is a reason the validation must be mechanical."*

No single owning PRD can discharge a cross-register invariant, because none of them can see both registers. This
module can see all of them. That is why enforcement lands here.

**`CNF-XC-003`** — The module **MUST NOT** author, amend, weaken or reinterpret the **statement** of any
`INV-1`…`INV-16`. *Owner: **`CONFIGURATION_GUIDE.md` §3** (Rank 7) and, for each parameter it references, that
parameter's owning PRD.*

**`CNF-FR-047`** — The module **SHALL** validate every declared cross-parameter invariant at application startup,
**before** serving any read.

**`CNF-FR-048`** — Where any invariant is violated, startup **SHALL** fail. The module **SHALL NOT** start in a
degraded mode, **SHALL NOT** disable the failing invariant, and **SHALL NOT** serve reads.

**`CNF-FR-049`** — Startup validation **SHALL** report **all** violations, not only the first.

> Verbatim from the guide: *"Startup validation must report **all** violations, not just the first — an operator
> fixing a configuration should see the complete list once."* Reproduced as a requirement because it is an
> obligation on this module's implementation, not on the guide's readers.

**`CNF-FR-050`** — Startup validation **SHALL** cover the invariant set as published, in **every** environment
including development, and **SHALL NOT** be relaxed by an environment profile.

> The guide's §4 rule 4 states the same: *"`INV-1` … `INV-16` are validated in every environment, including
> development. Relaxed values must still be internally consistent."* Note what this does **not** say: the
> *values* are relaxed in development, the *invariants* are not.

**`CNF-INV-001`** — No read **SHALL** be servable while any declared cross-parameter invariant is unsatisfied.

**`CNF-INV-002`** — The set of invariants enforced **SHALL** equal the set published at Rank 7. Neither a subset
nor a superset is conformant.

> **`CNF-INV-002` exists because the repository already contains the failure it prevents.** Stage 1 `F-11`
> measured `IMPL-015` in `IMPLEMENTATION_ROADMAP.md` naming **`INV-1`…`INV-9`**, while the guide publishes
> **`INV-1`…`INV-16`** — and the seven omitted are precisely the **cross-register** ones, the only ones no other
> module could possibly enforce. This document does **not** edit the roadmap (Stage 1 `R-08` discipline);
> `CNF-INV-002` makes the shortfall detectable, and **`CNF-GAP-005`** records it with its owner.

---

## 6. Feature flags

`ADR-0017` §3.1 item 2: *"**Feature flags** — definition, evaluation, rollout, and the boundary against `BC-21`
Entitlement (a flag says *is this on*; an entitlement says *is this paid for*)."*

This is the one item of the six whose boundary a **FROZEN** PRD has already drawn from the other side, and the two
statements match exactly. `PRD-014` `ENT-XC-008` (L485): *"The module **MUST NOT** define, evaluate or roll out a
feature flag. *Owner: **`BC-25`***."* Three verbs — define, evaluate, roll out — identical to `ADR-0017`'s three.
Nothing here is being negotiated; it is being accepted.

### 6.1 A flag is a configuration parameter, not a new kind of thing

**`CNF-FR-051`** — A feature flag **SHALL** be a configuration parameter whose declared type is boolean, resolved
through the hierarchy of §3 and read through the typed surface of §4. It **SHALL NOT** have a separate register, a
separate store, a separate resolution path or a separate accessor style.

> **This is the single most important scope decision in the document.** The alternative — a flag subsystem — is
> what `ADR-0017` §5.3 pre-registers as the **Medium** risk *"`PRD-023` grows to absorb entitlement or security
> scope"*, and it is how a foundational module becomes a platform-within-a-platform. Everything a V1 flag needs,
> §3 and §4 already provide: a default, a range (`true`/`false`), five scopes of override, validation, audit and
> a typed read. The user instruction is explicit — *"Keep the scope foundational. Do NOT turn `PRD-023` into a
> generic 'everything configurable' system"* — and honouring it here means **subtracting** a subsystem, not
> designing one.

**`CNF-FR-052`** — A flag **SHALL** be declared by the PRD that owns the behaviour it gates, in that PRD's own
configurable register. This module **SHALL NOT** originate a flag.

> `LCFG-5` Member Directory is the worked example already in the repository, and it is a flag in everything but
> name: default **Disabled**, range on/off, owned by `PRD-002`, consumed by `PRD-004` as `SMCFG-1` — *"`SMCFG-1`
> **is** `LCFG-5`, consumed through `E-19`"* (`TRACEABILITY_MATRIX.md` L209–210). `LMD-6` requires it read through
> the typed accessor. `PRD-023` supplies the accessor and the resolution; it does not own the flag.

**`CNF-FR-053`** — Flag **evaluation** **SHALL** be identical to effective-value resolution (§3.3). There
**SHALL** be no flag-specific evaluation semantics, no rule engine, no predicate language and no targeting
expression.

**`CNF-FR-054`** — Flag **rollout** in V1 **SHALL** consist of setting the flag's override at a scope. The module
**SHALL NOT** implement percentage rollout, cohort targeting, staged release, experiment assignment or variant
selection.

> Every one of those is a **V3** node in the EA tree — `Progressive Rollout`, `Targeting Rules`, `A/B Experiments`
> (L533–535). EA is **Rank 6, descriptive only** and cannot mint a requirement (Stage 1 `R-05`), but where it and
> the V1 scope agree that something is later, there is no reading under which it is now. `ADR-0017` §3.1 item 2
> says *"rollout"*; scope-targeted rollout is rollout. It is the minimum that satisfies the word, and the maximum
> the V1 band supports.

### 6.2 The boundary against `BC-21` Entitlement

**`CNF-BR-001`** — A flag **SHALL** answer only *is this on?* It **SHALL NOT** answer *is this paid for?*,
*is there quota left?*, or *is this permitted?*

**`CNF-BR-002`** — A flag being **on** **SHALL NOT** confer an entitlement, and an entitlement being present
**SHALL NOT** turn a flag on. The two are independent inputs.

> `PRD-014` `ENT-BR-004` states the same proposition from the entitlement side and is **FROZEN**: *"A feature flag
> being on does **not** confer entitlement."* `ENT-AC-024` verifies it there. `CNF-BR-002` is the reciprocal
> obligation, so that neither side relies on the other's discipline.

**`CNF-BR-003`** — Where a capability is both flagged and entitled, **both** **SHALL** be satisfied for it to be
available. The module **SHALL NOT** substitute a flag check for an entitlement check, and **SHALL NOT** consult
`BC-21`.

**`CNF-XC-004`** — The module **MUST NOT** define, store, compute or evaluate `EntitlementSet`, `FeatureGate`,
`UsageCounter`, `Limit`, `SeatQuota` or any subscription state. *Owner: **`BC-21`** / `PRD-014` (FROZEN);
**`BC-20`** for subscription state.* *(`ENT-XC-008`'s reciprocal; BC Map L130, L382, L383.)*

**`CNF-XC-005`** — The module **MUST NOT** call `business.entitlement`, or consult entitlement state by any route,
in order to resolve a value. *(§1.3 — `platform/business` is rank 6, above this module's rank 3; the call would be
an upward dependency as well as a boundary breach.)*

**`CNF-XC-006`** — The module **MUST NOT** make, cache, store or evaluate an authorisation decision. Refusing a
write because a caller's declared role is insufficient (§9) is a **caller-boundary obligation discharged by
`BC-18`**, not a decision made here. *Owner: **`BC-18`**.* *(`platform/identity` is rank 4; §1.3.)*

### 6.3 Flags and the values they must not become

**`CNF-BR-004`** — A flag **SHALL NOT** be used to disable a control, bypass authentication, weaken an invariant,
or make a never-public field public.

> This is not this document's rule; it is four FROZEN documents' rule, and this module is where it becomes
> enforceable. `SID-4.48`: *"No configuration value **SHALL** be capable of making a never-public field public,
> disabling an audit event, weakening `SID-INV-1`…`SID-INV-14`, or making Public the default privacy mode."*
> `SID-AC-8` verifies it. `PRD-001` L959 and `PRD-003` L400 both state that a named guarantee holds regardless of
> *"any configuration value, feature flag or deployment setting."* `CONFIGURATION_GUIDE.md` §4 rule 2 adds that no
> environment profile can override `MP-CON-11`. `CNF-BR-004` makes the union of those a property of the
> **mechanism**, so no future parameter can quietly acquire the power.

**`CNF-BR-005`** — A flag **SHALL NOT** gate an audit emission. *(`SID-4.48`; `PRD-016` `AUD-FR-003` — each
context decides what is auditable, and this module cannot switch it off.)*

---

## 7. Branding values and secret references

Two of `ADR-0017` §3.1's six items, both narrow, both defined more by what they exclude than by what they contain.

### 7.1 Branding — values only

`ADR-0017` §3.1 item 3, verbatim: *"**Branding values** — the values only. The *images* remain `FileRef`s issued
by `BC-29`, and **`LibraryBranding` as an aggregate stays with `PRD-002`** per `ADR-0013` §5."*

**`CNF-FR-055`** — Branding **values** — colour, name text, display strings, and the like — **SHALL** be
configuration parameters resolved through §3 and read through §4, on the same terms as any other parameter.

**`CNF-FR-056`** — A branding **image** **SHALL** be represented in configuration only as a `FileRef` issued by
`BC-29`. The module **SHALL NOT** store, transform, thumbnail, validate, sign or serve image bytes.

**`CNF-XC-007`** — The module **MUST NOT** own, define or hold the `LibraryBranding` aggregate. *Owner:
**`PRD-002`**, per `ADR-0013` §5.*

**`CNF-XC-008`** — The module **MUST NOT** perform upload, virus scan, thumbnailing, signed-URL issuance or storage
abstraction. *Owner: **`BC-29`** / `PRD-017`.* *(BC Map L136.)*

> **`PRD-023` sits on neither side of a split that has already happened.** `Library_PRD_v1.md` L190 marks
> `LibraryBranding` *"Split"*: the aggregate is `PRD-002`'s, the bytes are `BC-29`'s. What is left for `BC-25` is
> the *resolution obligation* — that a branding value obeys the same five-scope precedence as everything else, so
> a branch can differ from its library without a second mechanism. That is a real obligation and a small one, and
> stating it small is the point.

### 7.2 Secret references — references only

`ADR-0017` §3.1 item 4, verbatim: *"**Secret references** — references only. Never secret material; that is
`SECURITY`."*

**`CNF-FR-057`** — A parameter whose value identifies secret material **SHALL** hold only a **reference** — an
opaque identifier resolvable by the SECURITY platform. The reference **SHALL** be a first-class typed value, not a
string convention.

**`CNF-FR-058`** — The module **SHALL NOT** resolve a reference to its material, and **SHALL NOT** possess a
credential capable of doing so.

**`CNF-FR-059`** — A secret reference **SHALL NOT** be emitted in a log, a telemetry attribute, an error message,
an audit payload or a diagnostic surface where the corresponding parameter is marked sensitive by its owning PRD.

**`CNF-XC-009`** — The module **MUST NOT** store, cache, transit, decrypt, rotate, generate or expire secret
material, a credential, a password, an OTP, a session token, a device trust marker or key material. *Owner:
**SECURITY** platform; **`BC-18`** for credentials and sessions.*

> EA L71 and L132 record the re-homing that fixed this: *"`Secrets Management` re-homed to Security Platform;
> **Config retains `Secret Reference Resolution` only**."* `ADR-0017` §4 option **C3** — folding `BC-25` into
> SECURITY — was **rejected** for the reciprocal reason: *"`BC-25` holds *references*; SECURITY holds material.
> Merging them would put branding colours and feature flags behind a security boundary."* The boundary is
> deliberate in both directions.

**`CNF-GAP-006`** — EA places `Secret Reference Resolution` at **V2** (L526) and `Feature Flags` at **V2** (L529),
while `ADR-0017` §3.1 assigns both to `PRD-023`, which is **V1** at three ranks. *Owner: architecture reviewer.*
**Raised, not resolved** — precedence would settle it (EA is Rank 6, *"Descriptive only. Update it to match 1–5;
never the reverse"*), but `DOCUMENTATION_BASELINE.md` §4 rules that *"A conflict is a defect. If you find one,
**do not choose** — raise it."* Stage 1 `F-02`.

---

## 8. Change history and audit

The Stage 2 mandate names *"audit/history"* and *"configuration changes"*. Both are obligations on this module;
neither makes it an audit system.

**`CNF-FR-060`** — Every write — setting an override, changing one, or removing one (`CNF-FR-019`) — **SHALL**
emit an audit fact identifying the parameter, the scope, the actor, the previous value, the new value and the
server time.

**`CNF-FR-061`** — The audit fact **SHALL** be emitted through **`E-20`** to `BC-24`. The module **SHALL NOT**
persist its own audit store, retention policy or query surface.

> BC Map §7.3 `E-20`: *"All contexts → `BC-24` Audit Trail | Event (fire-and-forget, outbox-backed)."* This is the
> edge every context already has, and it is why **`CNF-EVT-*` is empty**: the audit obligation discharges through
> an existing edge, not through a new configuration event. Stage 1 `R-06` rejected minting
> `configuration.SettingChanged` for exactly this reason — BC Map §7 L292 rules that an edge not in the table does
> not exist.

**`CNF-FR-062`** — Removing an override **SHALL** be auditable as its own action, distinguishable from setting a
value. *(The `CNF-FR-019` distinction, carried into the record.)*

**`CNF-FR-063`** — A failed or rejected write **SHALL** be observable (§11). Whether a rejected write is an audit
fact is **`BC-24`**'s and the emitting context's to decide, not this module's.

> `PRD-016` `AUD-FR-003` is explicit: *"The module **SHALL NOT** decide *what* is auditable in another bounded
> context."* The mirror obligation is that this module does not decide it either, in the other direction — so
> `CNF-FR-063` states the observability requirement and stops.

**`CNF-XC-010`** — The module **MUST NOT** store, update, delete, retain, expire or query audit entries, and
**MUST NOT** become a system of record for a configuration change. *Owner: **`BC-24`** / `PRD-016` (FROZEN).*

**`CNF-BR-006`** — Configuration history **SHALL** be reconstructible from the audit trail. The module **SHALL
NOT** maintain a second, independent version history of its own.

> **`CNF-BR-006` is a subtraction, and the reason is `PRD-016`'s own.** A settings-history feature is the obvious
> thing to build, and it would create a parallel record of the same facts — with a mutable store, in a module with
> no append-only guarantee, competing with an aggregate whose defining property is that *"Append-only, no update
> or delete path exists in code"* (BC Map §8, `AuditEntry`). Two histories that can disagree are worse than one.

**`CNF-BR-007`** — A configuration change **SHALL** take effect only for resolutions performed after it commits.
The module **SHALL NOT** retroactively alter a value already resolved.

> Not a novel rule — `BC-06`'s `BranchPolicy` invariant already establishes the house position that *"policy
> changes are versioned with `effectiveFrom` (**never retroactive** — historical attendance must remain judgeable
> under the rules that were live at the time)"* (BC Map §8). `CNF-BR-007` is the same discipline for
> configuration, and it is what keeps an audit record meaningful. **It does not import `effectiveFrom`** —
> scheduled future-dated configuration is not in V1 scope and is not specified here.

---
