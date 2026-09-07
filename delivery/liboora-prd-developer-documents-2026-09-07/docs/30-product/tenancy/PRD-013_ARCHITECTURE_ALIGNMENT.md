# `PRD-013` Tenancy v0.1 — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L88–106) |
| **Subject** | [`PRD-013_TENANCY.md`](PRD-013_TENANCY.md) — `PRD-013`, `BC-19` Tenancy `[GENERIC]`, **V1**, **v0.1 `DRAFT`** |
| **Gate satisfied by** | This document — *"a written alignment record naming every conflict and its disposition"* |
| **Worked examples followed** | [`PRD-007_ARCHITECTURE_ALIGNMENT.md`](../seat-management/PRD-007_ARCHITECTURE_ALIGNMENT.md) · [`LIBRARY_PRD_ALIGNMENT.md`](../library/LIBRARY_PRD_ALIGNMENT.md) · [`STUDENT_IDENTITY_ALIGNMENT.md`](../student-identity/STUDENT_IDENTITY_ALIGNMENT.md) |
| **Reviewed at** | `65fbf698a481a0d98a2381b99cf924d582e19a6d` |
| **PRD hash at review** | `fcd99ff7dc6c2b4fc7f44e73cc468ffd178981c5a6cc2b6874fd7e6b19dff97e` — verified identical before and after |
| **Date** | 2026-08-19 |
| **Mandate** | **Stage 3 only.** No PRD modified, no ADR created or changed, no ranked document touched, no registry or baseline update, no identifier registered, no traceability checker, no freeze. Stages 4–7 not started |
| **Verdict** | ✅ **ALIGNED — 5 of 6 checks PASS, 1 CONDITIONAL.** 0 conflicts · 6 open/non-blocking items with named owners (§9) · **13 prior findings withdrawn as misreadings, each preserved with its reason (§11)** · 8 candidate findings rejected (§12) |

---

## 1. Method

Every finding below cites a document **on disk in this repository**, by path and line. Nothing is asserted from
conversation memory, and nothing is taken on trust from the PRD under review — each claim the PRD makes about a
ranked document was re-read at its source before this record was written.

Where the PRD text conflicts with a higher-precedence document, the precedence order in
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §4 decides which document is *wrong* —
**never which one to quietly ignore.** Per `MASTER_PRD.md` `MP-CON-08` L519: *"A disagreement is a **defect to be
raised**, not a choice to be made."*

### 1.1 Sources validated against

| # | Source | Path | Rank |
|---|---|---|---|
| 1 | Master PRD | `../MASTER_PRD.md` | **1** |
| 2 | ADRs — `ADR-0003`, `ADR-0012`, `ADR-0013`, `ADR-0016` | `../../00-governance/adr/` | **2** |
| 3 | Authentication PRD v2.0 — **FROZEN** | `../authentication/prd-v2/` | **3** |
| 4 | Library PRD v1.1 — **FROZEN** | `../library/Library_PRD_v1.md` | **3** |
| 5 | SaaS Billing `PRD-022` — **DRAFT v0.3, not frozen** | `../saas-billing/PRD-022_SAAS-BILLING.md` | **3** |
| 6 | Bounded Context Map v1.5 — §3, §4, §5, §7, §8, §9, §11 | `../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** |
| 7 | Module Dependency Matrix v1.3 — `L1`–`L5`, `X-13`, `ID-1`, §6.3, §8.3 | `../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **4** |
| 8 | Architecture Rulings | `../../10-architecture/ARCHITECTURE_RULINGS.md` | **5** |
| 9 | PRD Registry · PRD Lifecycle · Ownership Model · Roadmap · Documentation Baseline | `../../00-governance/` | — |

Ranks 6 (Enterprise Architecture) and 7 (Configuration Guide) are **not** Stage 3 authorities — the lifecycle scopes
this stage to *"Ranks 1–5"*. `DEPENDENCY_GRAPH.md` is **descriptive and unranked** by its own standing statement
(*"The Matrix is normative; this document is descriptive and may legitimately show violations"*) and is cited below
only for the rank-4 module-path fact, which the Matrix corroborates.

### 1.2 Classification scheme

| Class | Meaning |
|---|---|
| **PASS** | Verified compliant against the named authority |
| **CONDITIONAL** | Compliant as drafted, but resting on a documentation gap outside this PRD's control |
| **CONFLICT** | Two documents assert incompatible facts. Raised, never resolved here |
| **WITHDRAWN** | A finding raised in a prior review pass and later **disproven**. Preserved with its reason (§11) |
| **REJECTED FINDING** | A candidate finding examined and rejected, with its reason recorded (§12) |
| **OPEN / NON-BLOCKING** | A genuine absent decision, owned elsewhere, that does not block this stage |

### 1.3 A disclosure about this review's own history

This record is unusual among the repository's alignment records and the reader should know why. The Stage 3 review of
`PRD-013` ran across several passes. The first pass reported **two FAIL results and five blocking questions**. Of the
thirteen findings and corrections that pass produced against the architecture, **thirteen were subsequently
disproven** — not by a change to the repository, but by mechanical tests against the repository that the first pass
had not run: counting how many names in a table are aggregate roots, reading a table's column header before
interpreting one of its cells, and comparing two lists of value-object names directly instead of comparing prose
summaries of them.

They are preserved in §11 in full, with the test that refuted each. Deleting them would leave a record that appears
to have found almost nothing, and would hide the fact that **the earlier blocking verdict was wrong**. Per
`PRD_LIFECYCLE.md` L104: *"A review that records only accepted findings is indistinguishable from a review that found
nothing."* The same logic applies to a review that silently drops its own errors.

---

## 2. Check 1 — Context ownership is exclusive

**Authority:** BC Map §3 (Context Register). **Failure mode:** *"Two PRDs own one aggregate."*

### 2.1 The context claim

BC Map §3.3 L128 registers `BC-19`:

> `| **BC-19** | **Tenancy** | [GENERIC] | Shared Core | V1 | Owns the tenant (library organisation) record, tenant context propagation, tiers, residency, lifecycle. |`

`PRD_REGISTRY.md` L303 registers the claimant: `| PRD-013 | Tenancy | BC-19 | [GENERIC] | V1 | PLANNED |`.

### 2.2 The context was contested, and the contest is closed

This is the one place where a naïve exclusivity check gives the wrong answer, so it is recorded explicitly.
`PRD_REGISTRY.md` L148 still carries, for `PRD-002`: *"⚠ **Contested** for `BC-19`, `BC-25`, `BC-29`"* — and
`Library_PRD_v1.md` L10 (Rank 3, **frozen**) declares its owning contexts as *"`BC-19` Tenancy · `BC-06` Library
Policy · …"*.

The contest is resolved, by a Rank 2 instrument:

| Evidence | Line |
|---|---|
| `\| BC-19 \| **PRD-013** \| **No** — resolved 2026-08-04 by ADR-0013 \|` | `PRD_REGISTRY.md` L447 |
| *"**Contested bounded contexts** \| **0** — … `BC-19` → `PRD-013` … by `ADR-0013`"* | `PRD_REGISTRY.md` L540 |
| *"`BC-19` Tenancy \| **PRD-013 Tenancy** \| platform/tenancy (rank 4) \| **Consumer.** Continues to own the TenantOrganisation and StaffAssignment **aggregates**…"* | `ADR-0013` L103 |

### 2.3 The aggregate split is the substance of this check

`ADR-0013` resolves the contest by **splitting context ownership from aggregate ownership**, and §1.5 L132 makes the
distinction normative:

> *"**Context ownership** is the right to define the capability's contract, invariants and lifecycle. **Aggregate
> ownership** is the right to define a specific tenant-facing record that lives within it. They are different rights
> and may be held by different PRDs."*

| Right | Holder |
|---|---|
| Context ownership of `BC-19` | **`PRD-013`** |
| Aggregate `Tenant` | **`PRD-013`** — BC Map §8 L381 |
| Aggregate `TenantOrganisation` | **`PRD-002`** — `ADR-0013` L187, L220 |
| Aggregate `StaffAssignment` | **`PRD-002`** — `ADR-0013` L187, L220 |

`ADR-0013` L220 states the risk this check exists to catch, and names its own mitigation: *"`PRD-013` over-reaches
into library organisation data on the strength of 'owning `BC-19`' | Medium | **§5's aggregate column is normative**:
`TenantOrganisation` and `StaffAssignment` are `PRD-002`'s."* `PRODUCT_IMPLEMENTATION_ROADMAP.md` L109–110 repeats it:
*"`PRD-013` must NOT claim them."*

### 2.4 Verified against the PRD as drafted

| Requirement | Effect |
|---|---|
| `TEN-FR-004` | *"`Tenant` **SHALL** be the module's only aggregate root"* |
| `TEN-FR-003` | *"**SHALL NOT** own, define or store any tenant-facing business record beyond `Tenant`"* |
| `TEN-XC-001` | `TenantOrganisation` — *"**MUST NOT** define, store, mutate or claim … No code path in `platform/tenancy` may create or write it"* → `PRD-002` |
| `TEN-XC-002` | `StaffAssignment` *"nor any `LIB-6.x` field rule"* → `PRD-002` |

The exclusions state what must be **impossible**, not what is deferred. The PRD's §2 table names `Tenant` as the
only aggregate root and marks the four value objects as belonging to it, matching BC Map §8 L381 cell-for-cell.

### 2.5 Result

> ✅ **PASS.** One context, one registered claimant, contest closed by `ADR-0013`. One aggregate root claimed
> (`Tenant`), and the two aggregates that belong to `PRD-002` are excluded by name with the *"impossible"* framing.
> **No aggregate is owned by two PRDs.**

---

## 3. Check 2 — Every integration edge exists in BC Map §7

**Authority:** BC Map §7. **Failure mode:** *"If an edge is not in this table, it does not exist"* — needs an ADR.

### 3.1 Mechanical comparison

Every `E-nn` token in the PRD, measured: **`E-18`, and only `E-18`.**

BC Map §7.3 L327:

> `| E-18 | All contexts | BC-19 Tenancy | SK | Ambient TenantContext | Propagated, never passed as a parameter through domain methods |`

Measured over §7's full extent (L290–363): `BC-19` appears **exactly once**, in the `E-18` row, as the **downstream**
party. The PRD's §11 declares exactly this edge plus the port and shared-kernel mechanisms that implement it, and
asserts no other.

### 3.2 The `SK` pattern is identified, not left dangling

`E-18`'s pattern is `SK` — Shared Kernel. BC Map §7.5 L356 registers exactly **two** shared kernels in the entire
product: *"`liboora_contracts`, `PersonId`/privacy VOs."* Of those two, `liboora_contracts` is the one that declares
`TenantContext` — Matrix §6.3 L336: *"port_interfaces: 'only ports of universal reach (**TenantContext**, Telemetry,
Clock)'."* The identification is therefore forced, not chosen.

### 3.3 The one place this check is conditional — `H-1`

`BC-19` is a capability context. Its **outbound** relationships to other capability contexts have nowhere to be
registered: §7's subsections are, measured, exactly **7.1 Core↔Core · 7.2 Core↔Supporting · 7.3 Domain→Capability ·
7.4 Capability→Domain (forbidden) · 7.5 Pattern Distribution**. There is **no capability→capability subsection.**

Yet BC Map §9 L435 publishes `BC-19`'s events to *"All, **BC-21**, **BC-24**"* — two capability contexts. Those
consumer relationships are published at §9 and unregistrable at §7.

**This is not a `PRD-013` defect.** The same measurement on the most load-bearing capability edge in billing:

> `| BC-20 | billing.EntitlementChanged | BC-21 | The only writer of entitlement inputs |` — BC Map §9 L437

`BC-20`→`BC-21` is **equally absent** from §7. The gap is a product-wide taxonomy hole in a frozen Rank 4 document,
recorded as `H-1` (§9), owned by the Architecture Owner, with `ADR-0016` as the amendment precedent.

**The PRD's posture is the compliant one:** `TEN-XC-009` forbids publishing any event beyond the two registered, and
§11 declares no edge that §7 does not contain. It **declines** rather than invents — the same choice
`PRD-007_ARCHITECTURE_ALIGNMENT.md` rejected finding `AR-R5` endorses.

### 3.4 Result

> ⚠️ **CONDITIONAL PASS.** 1 of 1 declared edge exists in §7; **0 edges invented.** The condition is `H-1`, a
> pre-existing product-wide §7 taxonomy gap affecting `BC-20` identically. No ADR is required *of this PRD*, because
> this PRD asserts no unregistered edge.

---

## 4. Check 3 — Rank direction is downward

**Authority:** Dependency Matrix `L2`. **Failure mode:** Illegal import.

### 4.1 The law

Matrix L49: *"**L2 — Downward only.** A module may depend only on modules of **strictly lower rank** (§3). Same-rank
dependencies are forbidden except within a declared cluster."* L54: *"**L1 is absolute. L2–L5 admit exceptions only
through the ADR process in §11.**"*

### 4.2 The module's rank

Matrix §3 L67: `| **R4** | SHARED CORE · IDENTITY & ACCESS | Tenancy, tenant context, auth, RBAC/ABAC, policy decision point. |`

`DEPENDENCY_GRAPH.md` L39 corroborates the module path at rank 4: `| 4 | platform/tenancy · platform/identity | Capability | AuthService lives here |`. `ADR-0013` L103 assigns `platform/tenancy (rank 4)` to `PRD-013`.

### 4.3 The upward read is a *declared* exception, not a violation

`TenantContext` is written at the request edge (R9) and read at R2 for row-level security. A downward import would
violate `L2`. Matrix §8.3 L404–405 resolves this by design:

> *"**Resolution:** the `TenantContext` *interface* and its read-only accessor live in `liboora_contracts` (**R0**).
> The API edge *writes* it once per request via an async-scoped holder; every other rank only *reads* it. Marked
> `◇*` in the matrix."*

Matrix legend L157: *"`◇*` = TenantContext read-only accessor **from Shared Core**; permitted upward exception, see
§8.3."* `L2` is satisfied **by** the declared exception, not despite it — structurally the same situation as
`PRD-007`'s rejected finding `AR-R1`.

The four safety constraints at §8.3 L408–411 are each carried by a PRD requirement, which is what makes the exception
safe rather than a global variable:

| Matrix §8.3 constraint | PRD requirement |
|---|---|
| *"Read-only outside the edge — no setter is exported beyond the composition root"* | `TEN-FR-013` |
| *"Reading it when unset **throws**; it never defaults to a tenant or to null"* | `TEN-FR-011` |
| *"never passed as a domain method parameter"* | `TEN-FR-015` |
| *"Async-scoped, so concurrent requests cannot observe each other's tenant"* | `TEN-FR-014` |

### 4.4 The three names are one mechanism at three layers

A prior pass raised these as an inconsistency. They are not. Each is the correct name at its own layer, and the PRD
§0.4 keeps them distinct:

| Name | Layer | Authority |
|---|---|---|
| `platform/tenancy` | **Module path**, rank 4 | Matrix §3 L67; `DEPENDENCY_GRAPH.md` L39; `ADR-0013` L103 |
| `shared_core.tenant_context` | **Manifest port name**, following the `<platform>.<port>` convention shared by every entry in the list (`data.repository`, `security.crypto`, `platform_services.time`, `identity.policy_decision`, `business.entitlement`) | Matrix L192 |
| `liboora_contracts` | **R0 shared-kernel package** declaring the `TenantContext` interface | Matrix §6.3 L336 |

Declaring an interface in the shared kernel is **not** a transfer of ownership. `BC-19` remains the owner of tenant
context; R0 is merely where a universally-reachable interface must live for the upward read to be legal. The
prior finding that these conflicted is withdrawn as `S3-F-07` / `C-05` (§11).

### 4.5 `L4` is satisfied by abstention

`L4`: *"No capability, generic or platform module may import a domain module. **Ever.**"* The PRD names `BC-18`,
`BC-20`, `BC-21`, `BC-24` and `BC-25` only in **exclusions** and in its consumed-authority table — never as imports.
It claims no domain-context dependency at all.

### 4.6 Result

> ✅ **PASS.** Module at R4; the only upward read is the `◇*` exception **declared** at Matrix §8.3 and legend L157,
> with all four of its safety constraints carried into requirements. `L1`, `L2`, `L3`, `L4`, `L5` unviolated. No new
> exception requested.

---

## 5. Check 4 — No authorisation decided outside `BC-18`

**Authority:** `X-13` *(as cited by the lifecycle — see §5.1)*. **Failure mode:** *"A security defect that passes its own tests."*

### 5.1 The cited authority is the wrong rule, and that is recorded rather than fixed

`PRD_LIFECYCLE.md` L96 reads: `| No authorisation decided outside BC-18 | X-13 | A security defect that passes its own tests |`.

But Matrix L362 defines `X-13` as: `| **X-13** | Cache/index/vector key without tenantId | Oversight, not intent | **Cross-tenant data leak — highest-severity failure class in the system** | Tenant-prefixed key factory; enforced by lint + Multi-Tenant Test Suite |`.

`X-13` is the **tenant-key** rule. It is the correct authority for check 6, and it is cited for check 6 as well
(L98). The authorisation-placement rule is carried by BC Map §3.3 L127 (`BC-18` *"Owns … roles, permissions, policy
decisions"*), §7.4 `F-1`–`F-3`, and Matrix's `identity.policy_decision` port.

This is recorded as `H-2` (§9) for the Governance Owner. **It is not silently substituted**, and the check is run
against the rule the lifecycle evidently intends, with that substitution disclosed here rather than assumed.

### 5.2 The module decides nothing

Measured: the PRD contains **zero** statements in which the module decides, grants or evaluates access. Authorisation
appears only as exclusions.

| Requirement | Effect |
|---|---|
| `TEN-XC-003` | *"**MUST NOT** make, store or evaluate an **authorisation decision**. No role, permission, scope or policy is defined here"* → `BC-18` |
| `TEN-XC-010` | *"**MUST NOT** produce, cache, alter or short-circuit an **authorisation outcome**. Supplying tenant context is not deciding access; a cached tenant context **MUST NOT** be relied upon as evidence that an authorisation still holds"* → `BC-18` |
| `TEN-BR-004` | Isolation is structural **and** re-asserted at every authorisation decision — *"This module supplies the **context**; it does not make the decision"* |
| `TEN-AC-008` | An attempt to write an authorisation outcome from within `platform/tenancy` fails, statically or at runtime |

### 5.3 `TEN-XC-010` is stronger than the rule requires, and deliberately so

`ADR-0003` (Accepted, Rank 2) records the negative consequence of the hybrid tenancy model:

> *"**Tenant isolation must be enforced at every authorization decision rather than at a data partition** … a
> continuous obligation, not a one-time structural guarantee — hence `EV-26` alerting on every cross-tenant attempt
> with no threshold."*

The failure mode `ADR-0003` implies is subtle: a module that legitimately supplies tenant context could **cache** it
and thereby let a stale context stand in for a live authorisation. `LIB-8.3` (Rank 3, frozen) names the same hazard
from the other side: *"A cached authorisation decision **MUST NOT** permit an operation in a library suspended a
moment earlier."*

`TEN-XC-010` closes it explicitly. No cited rule required this exclusion to be written; it is a volunteered
constraint on the module's own most plausible security failure, and it is the strongest single line in the draft.

### 5.4 Result

> ✅ **PASS**, over a mis-cited authority recorded as `H-2`. The module decides no authorisation, defines no role,
> permission, scope or policy, and additionally forbids **caching or short-circuiting** an outcome it never produces.

---

## 6. Check 5 — No credential, OTP or session outside `BC-18`

**Authority:** `ID-1`. **Failure mode:** Prohibited.

### 6.1 The rule

BC Map §4.1 L178: `| **ID-1** | No context outside BC-18 may store a password, OTP, session or credential. | Security review + schema scan in CI |`

### 6.2 Exhaustive scan

Every occurrence of `credential`, `OTP` or `session` in the PRD, measured — three lines, and none of them stores
anything:

| Line | Occurrence | Character |
|---|---|---|
| 264 | *"Authentication `XC-5.6` describes a session surviving suspension"* | A **citation** of frozen `AUTH` behaviour, in the rationale for declining to invent an event |
| 287 | `TEN-XC-004` — *"**MUST NOT** store a credential, password, OTP, session or device record"* | An **exclusion**, quoting `ID-1` as its authority |
| 305 | `TEN-AC-008` — an attempt to write a credential from `platform/tenancy` fails | An **acceptance criterion** proving the exclusion |

The PRD's `Tenant` aggregate carries `TenantTier`, `Quota`, `ResidencyRegion`, `TenantLifecycleState` — matching BC
Map §8 L381 exactly. None is a credential class.

### 6.3 The mobile-number trap is not entered

Matrix L235 identifies the credential class the repository worries about most: `- "*.mobileNumber"  # rule ID-1`.
`Library_PRD_v1.md` L214/L235 (`LIB-6.4`) establishes that a *business* Mobile Number is a different thing from a
credential. The PRD stores **neither** — it claims no contact field at all, because contact fields belong to
`TenantOrganisation`, which `TEN-XC-001` excludes.

### 6.4 Result

> ✅ **PASS.** Recorded as a pass **with its reason**, not assumed. Zero credential, password, OTP, session or device
> storage. `ID-1` satisfied, and the `*.mobileNumber` class avoided as a consequence of `TEN-XC-001`.

---

## 7. Check 6 — Tenant scoping is correct

**Authority:** `MP-GBR-08`, `X-13`. **Failure mode:** Cross-tenant leak — `MP-RSK-01`, **Critical**.

### 7.1 The Rank 1 rules and their carriage

`MASTER_PRD.md` L337–340, each mapped to a requirement:

| Rank 1 rule | Verbatim | Carried by |
|---|---|---|
| `MP-GBR-06` | *"Every request carries a resolved tenant context."* | `TEN-FR-010` |
| `MP-GBR-07` | *"A consumer that processes an event without establishing tenant context **fails loudly, never defaults**."* | `TEN-FR-011`, `TEN-AC-007` |
| `MP-GBR-08` | *"Every search index and vector namespace is tenant-partitioned."* | `TEN-FR-019` |
| `MP-GBR-09` | *"A change to a cache key, index name or vector namespace is a **security-reviewable change**."* | `TEN-FR-020` |

`MASTER_PRD.md` L398's schema rule — `tenant_id` *"**Mandatory** for tenant-scoped contexts. **Forbidden** in global
contexts"*, which L400 stresses is *"a decision rule, not a hedge"* — is carried verbatim in intent by `TEN-FR-018`.

### 7.2 `X-13` and the four-band model

Matrix `X-13` forbids a cache, index or vector key without `tenantId`; `TEN-FR-019` and `TEN-FR-020` carry it, and
`TEN-XC-007` states the consequence as an impossibility: *"**Cross-tenant access MUST be impossible.** No operation,
query, cache, index or projection owned by this module may return, reference or infer data belonging to a tenant
other than the resolved one."* This aligns with frozen `AUTH-5.36`: *"No operation performed under one active library
MAY read, write, reference or infer data."*

BC Map §11 L488 places `BC-19` in the fourth band: *"**BC-19→31 Capability | Tenant-aware.** Carry and propagate
`tenantId`, own no tenant data of record."* The PRD is consistent with this: it propagates context (`TEN-FR-002`) and
owns the `Tenant` record — which is the tenant's own identity, not the tenant's *business* data of record. That
reading is forced, not chosen: **six** contexts in the L488 band own §8 aggregates (`Tenant`, `Subscription`,
`SubscriptionInvoice`, `EntitlementSet`, `AuditEntry`, `Projection`, `AgentRun`), and `PRD_REGISTRY.md` L326
registers `PRD-022` as owning `Subscription`. A reading of L488 that forbade aggregates outright would void six rows
of a frozen Rank 4 register. The prior finding to the contrary is withdrawn as `S3-F-02`/`S3-F-03` (§11).

### 7.3 Fail-loudly is specified as a throw, not a log

`TEN-FR-011` requires that reading unset context **throws** — *"It **MUST NOT** default to a tenant and **MUST NOT**
default to null"* — matching Matrix §8.3 L409. `TEN-AC-001` proves it: a tenant-scoped operation with no resolved
context is refused, *"and the refusal is an error — not a default tenant and not null."* This is the shape
`MP-GBR-07` demands and the shape `MP-RSK-01` (Critical) exists to prevent.

### 7.4 The event envelope carries the tenant

Both claimed events are subject to BC Map §9.1 L449–450: the envelope includes `tenantId`, written via
**Transactional Outbox** in the same transaction as the aggregate mutation, and *"`tenantId` is mandatory on every
domain event. A consumer that processes an event without establishing tenant context must fail loudly, not default."*
`TEN-AC-007` asserts exactly this for both events.

### 7.5 Result

> ✅ **PASS.** All four `MP-GBR-06`…`09` rules carried into requirements; `X-13` carried; cross-tenant access framed
> as **impossible** rather than merely forbidden; fail-loudly specified as a throw. No index or namespace is created
> by this module, so `MP-GBR-08`'s index clause is additionally satisfied by abstention.

---

## 8. Ownership, lifecycle and event-surface findings recorded explicitly

The instruction for this record requires these seven facts be stated on the record. Each is verified against the
on-disk PRD and its authority.

| # | Fact | Verified against |
|---|---|---|
| 1 | **`Tenant` is `PRD-013`'s only aggregate root.** | `TEN-FR-004`; BC Map §8 L381 |
| 2 | **`TenantOrganisation` and `StaffAssignment` belong to `PRD-002`** and are excluded by `TEN-XC-001`/`TEN-XC-002` with the *"impossible"* framing. | `ADR-0013` L187, L220; Roadmap L109–110 |
| 3 | **Library lifecycle states are cited from frozen `LIB-8.1`…`LIB-8.8`, not duplicated.** The PRD §5.1 reproduces the eight requirement *identifiers and subjects* as a citation table and defines **no state, no transition and no state name**. `TEN-FR-012`, which had restated the machine, is retired. `TEN-XC-008` forbids claiming it. | `Library_PRD_v1.md` §8 (frozen v1.1); PRD §5.1, §9 |
| 4 | **Only `tenancy.TenantProvisioned` and `tenancy.TenantSuspended` are claimed.** `TEN-EVT-001`/`002`, register closed at two; `TEN-XC-009` forbids a third. `LEV-1`…`LEV-6` are the frozen Library PRD's and are not claimed. | BC Map §9 L435; PRD §6 |
| 5 | **No reinstatement event is invented.** Measured: zero occurrences of `TenantReinstated`, `TenantReactivated`, `TenantResumed`, `TenantUnsuspended`, `tenancy.TenantRestored`, `tenancy.TenantActivated`. The consequence is recorded as `TEN-GAP-004` / `S3-F-14`, unresolved, Architecture Owner named. | PRD §6.1, §10 |
| 6 | **Module path, manifest port name and shared-kernel declaration are three layer-specific names for one mechanism** — not three competing claims. | §4.4 above; PRD §0.4 |
| 7 | **`PRD-013` does not make authorisation decisions.** | §5 above; `TEN-XC-003`, `TEN-XC-010` |

### 8.1 The state machine's binding to `BC-19` rests on three independent sources

Because fact 3 is the single most consequential alignment decision in this draft — it is what keeps the PRD out of
Stage 4's *"Two sources of truth"* failure — the binding is recorded with all three of its supports, none of which is
this PRD:

| Source | Rank | Statement |
|---|---|---|
| `ARCHITECTURE_RULINGS.md` L44 | 5 | *"Library Name · Business Address · Map Location · **Library Status** · Business Contact Information \| `BC-19` Tenancy"* |
| `Library_PRD_v1.md` L1091 | 3, **frozen** | *"Library name, address, contact, **status**, tenant record \| `BC-19` \| **Owns**"* |
| `REVIEW_14A.md` L392 | — | *"Consistent with **`BC-19`'s `TenantLifecycleState`** and its invariant 'suspended tenant rejects all writes'"* |

`Library_PRD_v1.md` L1085 (`LIB-26.1`) states the consumption rule the PRD obeys: *"This table is the authoritative
answer to 'who owns this field?'. Where a field is needed by this module but owned elsewhere, it is **read through a
projection** and **never stored here**."*

---

## 9. Open, non-blocking items — each with a named owner

None is resolved by this record, and none is invented.

| ID | Item | Owner | Instrument | Blocks Stage 3? |
|---|---|---|---|---|
| **`H-1`** | BC Map §7 has no capability→capability subsection. `BC-19`'s published consumers (§9 L435: *"All, BC-21, BC-24"*) and `BC-20`→`BC-21` (§9 L437) are both unregistrable at §7 | **Architecture Owner** | `ADR-0016`-style single-cell amendment, if wanted | **No** — product-wide, pre-existing; this PRD declines rather than invents (§3.3) |
| **`H-2`** | `PRD_LIFECYCLE.md` L96 cites `X-13` for *"No authorisation decided outside `BC-18`"*; `X-13` is the tenant-key rule (Matrix L362) | **Governance Owner** | Editorial correction to a governance document | **No** — recorded, not substituted (§5.1) |
| **`S3-F-14`** | BC Map §9 publishes no reinstatement/restoration event for `BC-19`, while the frozen lifecycle is **recoverable** (`LIB-8.5` `Restore`; `AUTH` `XC-5.6` session survives suspension). A consumer that cached a deny has no published signal to re-allow | **Architecture Owner** | `ADR-0016`-style §9 amendment | **No** — `TEN-XC-009` + PRD §6.1 decline to invent one; recorded as `TEN-GAP-004` |
| **`ADR-0012` / `TASK-D10`** | `TenantTier` visibility to `platform/business`: *"Either promote `TenantTier` to `liboora_contracts` … (**an ownership change, so it needs its own ADR**) or have Business declare a one-method `TenantTierSource` port"* — expiry **2026-10-31** | `TASK-D10` / `BLK-01` | Existing ADR debt | **No** — `TEN-FR-009` assumes **neither** option. Ownership of `TenantTier` is not in question (BC Map §8 L381) |
| **`SAAS-GAP-005`** | Tenant deletion identity — *"which identity survives a deletion … depends on … the `CFG-10` soft-delete retention that **`PRD-001` and `BC-25` own, not this document**"* (`PRD-022` L650–651); routed at L749 to *"**ARCHITECTURE OWNER + `PRD-001`**"* | **Architecture Owner + `PRD-001` / `BC-25`** | Existing routed gap | **No — and explicitly not a `PRD-013` blocker.** Recorded as `TEN-GAP-003` |
| **`TEN-GAP-001`** | `ResidencyRegion` value set is **unenumerated anywhere in the repository**. `AUTH-11.37` says only *"within **permitted jurisdictions**"* and names none; `ADR-0041` L214 **explicitly refuses** to name one | **SECURITY + DATA Governance** (`MASTER_PRD.md` `MP-NFR-10` L504) | A compliance decision taken with counsel | **No** |

### 9.1 Why `TEN-GAP-001` does not block, and what was deliberately not done

**No residency-region value is invented in the PRD or in this record.** The PRD was measured against a candidate set
of country, economic-area, city and cloud-region tokens; the count was **zero for every one of them**. The candidate
tokens are deliberately **not reproduced here**, so that this review does not become the first document in the
repository to put a residency value in writing — the same restraint `ADR-0041` L214 exercises when it declines to
*"name a period, a statute or a jurisdiction rule."*

`TEN-INV-002` — *"`ResidencyRegion` **MUST** be immutable after first write"* — is taken verbatim from BC Map §8 L381
and holds under **any** eventual enumeration. The module stores the value it is given and enumerates nothing. This
meets the standard `ADR-0019` §3.3 set for `MM-GAP-001`, and which
`PRD-007_ARCHITECTURE_ALIGNMENT.md` §8.3 L436–437 then applied to `SEAT-GAP-003` and carried through Stage 3 *and*
through freeze: V1 behaviour must be *"correct under either resolution."*

The precedent is exact. `PRD-007` passed Stage 3 with **13 open gaps**, one of them an unresolved Rank 1 open
question, on the reasoning: *"`SEAT-GAP-003` is **neither resolved nor invented here** … both carry a
**recommendation, not a decision**."* Inventing a region here would be the failure `PRD-007` rejected as `AR-R3`:
*"Adopting it would silently amend a Rank 1 register."*

---

## 10. Conflicts found at Stage 3

**None.**

Zero CONFLICT findings against Ranks 1–5 arose from checks 1–6. The six items in §9 are an absent decision
(`TEN-GAP-001`), three documentation defects in ranked documents that affect other PRDs identically (`H-1`, `H-2`,
`S3-F-14`), and two gaps already routed to other owners (`ADR-0012`/`TASK-D10`, `SAAS-GAP-005`).

This is a materially different result from the first review pass, which reported two FAILs and five blocking
questions. §11 explains, item by item, why.

---

## 11. Withdrawn findings — preserved, with the test that refuted each

These thirteen findings were raised against the architecture in earlier Stage 3 passes and are **withdrawn**. They
are preserved because deleting them would misrepresent both the review and the repository: **in every case the
repository was correct and the finding was a misreading of it.**

| ID | The finding as originally raised | The mechanical test that refuted it | Class of error |
|---|---|---|---|
| **`S3-F-01`** | *"BC Map §5's `BC-19` row names `TenantOrganisation` as the aggregate, contradicting §8's `Tenant`. Two names for one aggregate."* | Extracted all **8** binding-resolution names from §5 and tested each against §8's aggregate-root column. Only **1 of 8** (`StudentRecord`) is an aggregate root; `MembershipHolder`, `FeeDue`, `AuthSession`, `Seat`, `TenantOrganisation`, `AnalyticalReport`, `StudentProfile` are not. §5 is a **ubiquitous-language disambiguation register** — the ambiguous word in the `BC-19` row is *"Library"*, resolved as `TenantOrganisation` (BC-19) vs `Branch` (BC-06). It was never an aggregate register, so there is nothing for §8 to contradict | Read a register's purpose from one row instead of testing it across all rows |
| **`S3-F-02`** | *"`MASTER_PRD.md` L333 places `BC-19`–`BC-31` in a band that **'own no tenant data of record'**, so `PRD-013` may own no aggregate at all — the PRD has no lawful subject."* | Enumerated every §8 aggregate belonging to a context in that band: `Tenant` (BC-19), `Subscription` + `SubscriptionInvoice` (BC-20), `EntitlementSet` (BC-21), `AuditEntry` (BC-24), `Projection` (BC-26), `AgentRun` (BC-27). **Six contexts, seven aggregates.** Reading L333 as an absolute prohibition would void six rows of a frozen Rank 4 register, including `Subscription`, which `PRD_REGISTRY.md` L326 registers `PRD-022` as owning. L333 scopes to the **tenant's business** data of record | Read a scoping clause as an absolute prohibition without testing the consequence |
| **`S3-F-03`** | *"Consequential on `S3-F-02`: every `TEN-*` requirement that presumes an owned aggregate is unfounded."* | Parent withdrawn; the consequence falls with it. `TEN-FR-005`…`009` reinstated | Inherited from parent |
| **`S3-F-06`** | *"`E-18`'s pattern is `SK` (Shared Kernel), but the BC Map never says **which** shared kernel — the edge is dangling."* | BC Map §7.5 L356 registers exactly **two** shared kernels product-wide: *"`liboora_contracts`, `PersonId`/privacy VOs."* Of the two, `liboora_contracts` is the one declaring `TenantContext` (Matrix §6.3 L336). The identification is forced. One mechanism named in three vocabularies at three ranks | Treated a cross-reference as absent without searching for the register that closes it |
| **`S3-F-07`** | *"The PRD's port `shared_core.tenant_context` conflicts with the module path `platform/tenancy` — the module cannot have two identities."* | Matrix's port list follows `<platform>.<port>` in **every** entry: `data.repository`, `security.crypto`, `configuration.settings`, `platform_services.files`, `identity.policy_decision`, `business.entitlement`, `shared_core.tenant_context`. These are **port names**. `platform/tenancy` is the **module path** at rank 4 (Matrix §3 L67; `DEPENDENCY_GRAPH.md` L39). Both correct, different kinds of name | Compared two identifiers without establishing what kind of identifier each was |
| **`Q-013-05`** | Open question on shared-kernel placement | Resolved from the same §7.5 L356 / §6.3 L336 evidence as `S3-F-06` | Superseded |
| **`Q-013-07`** | *"Does declaring `TenantContext` in `liboora_contracts` transfer ownership of tenant context out of `BC-19`? `TEN-FR-013` may be unfounded."* | Matrix §6.3 L336 places `TenantContext` beside `Telemetry` (OBSERVABILITY) and `Clock` (PLATFORM SERVICES) — neither of which is owned by `liboora_contracts` either. The shared kernel is where universally-reachable **interfaces** are declared, per §8.3's stated resolution. **`TEN-FR-013` reinstated** | Confused the declaration site of an interface with ownership of the capability |
| **`D-1`** | *"The `TenantLifecycleState` value set is undefined; suspension is terminal as published, contradicting `AUTH` `XC-5.6`. **ARB decision + ADR required.**"* | Searched for the *concept* rather than invented names. `Library_PRD_v1.md` §8 (Rank 3, **FROZEN**) enumerates **six states** — Draft, Pending Verification, Verified, Active, Suspended, Archived — with `LIB-8.1`…`LIB-8.8`, and `LIB-8.5` makes `Archive` reversible via `Restore`. Suspension is **not** terminal, so `XC-5.6` never conflicted. Bound to `BC-19` by `RULINGS` L44, `LIB` L1091 and `REVIEW_14A` L392 | **Measured for identifier names I had invented** (`TenantReinstated`, `TenantTerminated`…) and read their absence as the concept's absence |
| **`D-2(b)`** | *"`MP-NFR-10` L504 assigns data residency to **SECURITY + DATA Governance** while BC Map L128/L381 assigns it to `BC-19`. A Rank 1↔Rank 4 ownership conflict with **no reconciling reading**. Governance Owner decision required."* | Read the table's header. `MASTER_PRD.md` L491: *"each now carries an obligation and **an owner**."* All **12 of 12** owner cells name a **function** — `SRE / OBSERVABILITY`, `EVENT platform`, **`ARCHITECTURE GOVERNANCE`**, `DATA / EVENT`, `SECURITY`, `UI Design System`, `Per-platform`, `OBSERVABILITY`, `SECURITY + DATA Governance`, `Business platform`, `SRE`. Function accountability for an NFR posture is not aggregate ownership — precisely `ADR-0013` L132's distinction | **Interpreted a table cell without reading its column header** |
| **`D-2(c)`** | *"The EA marks residency **V3** (L329, L572, L2304) while BC Map marks `BC-19` **V1** — a version conflict."* | The EA is **Rank 6, descriptive only**; `PRD_LIFECYCLE.md` scopes Stage 3 to *"Ranks 1–5"*. `PRD-007_ARCHITECTURE_ALIGNMENT.md` rejected this exact class as `AR-R6`: *"A descriptive document trailing normative ones is not a conflict"* | **Cited a rank the stage excludes** |
| **`D-3`** | *"`Quota` and `TenantTier` are contested between `BC-19` (§8 L381) and `BC-21` (§3 L130 'single source of truth for limits and gates'). **ARB + ADR required**, per `ADR-0012` L176."* | Compared the two §8 value-object lists directly: `BC-19` = `TenantTier`, `Quota`, `ResidencyRegion`, `TenantLifecycleState`; `BC-21` = `FeatureGate`, `UsageCounter`, `Limit`. **Disjoint — zero overlap.** `\bQuota\b` occurs **once** in the entire BC Map (L381). `BC-21`'s invariant — *"Derived state only — **never** hand-edited; recomputable from Subscription events"* — makes it the derived answer, not the input. `ADR-0012` L176 is a *scaffold-visibility* question whose second option needs no ownership change | **Compared prose summaries of two registers instead of the register contents** |
| **`C-02`** | Correction requiring amendment of a Rank 1 self-contradiction | Withheld correctly at the time, and now withdrawn as unnecessary: the contradiction it addressed was `D-2(b)`, which does not exist. `MP-CON-08`: *"A disagreement is a **defect to be raised**, not a choice to be made"* | Dependent on a withdrawn finding |
| **`C-05`** | Correction renaming the port to match the module path | Reversed. Revision A was correct; the two names are correct at different layers (§4.4) | Dependent on `S3-F-07` |

### 11.1 Findings and corrections from earlier passes that stand

| ID | Disposition |
|---|---|
| `S3-F-04` / `S3-F-05` | **Downgraded, not withdrawn.** Merged into `H-1` (§9) — real, but product-wide and pre-existing, affecting `BC-20`→`BC-21` identically |
| `S3-F-08` | Merged into `H-1` |
| `S3-F-09` | **Stands** — the `X-13` mis-citation, now `H-2` (§9, §5.1) |
| `S3-F-10`…`S3-F-13` | **Applied** in the draft as corrections `C-04`, `C-06`…`C-12`: exclusions restated as impossibilities, `TEN-CFG-*` emptied, duplications retired, `TEN-XC-010` added |
| `C-01`, `C-04`, `C-06`…`C-12` | **Applied** and visible in the on-disk PRD |
| `C-03` | **Withheld, correctly.** Would have required inventing a §7 edge; BC Map L292 requires an ADR, and declining is compliant |
| `C-13` | **Withheld at the time** (a Stage 3 gate artefact could not be produced by the draft author mid-Stage-2). **Discharged by this document** |
| `S3-R-01`…`S3-R-06` | Prior rejected findings, carried forward into §12 below |

### 11.2 Retired identifiers — verified as retired, not reused

The PRD §9 retires **12** identifiers permanently. Verified mechanically at review: each of `TEN-FR-012`,
`TEN-FR-016`, `TEN-FR-017`, `TEN-BR-002`, `TEN-BR-003`, `TEN-INV-003`, `TEN-INV-004`, `TEN-INV-005`, `TEN-CFG-001`,
`TEN-AC-003`, `TEN-AC-004`, `TEN-AC-005` appears **only** inside the §9 ledger (document lines 319–330) and has
**zero** requirement-definition sites. In-force acceptance criteria are `TEN-AC-001`, `002`, `006`, `007`, `008` —
the retired three do not reappear. This applies `PRD_LIFECYCLE.md` Stage 6's discipline: *"**Never reuse or reassign
a number.**"*

Six identifiers were **reinstated** after the withdrawals above: `TEN-FR-005`…`009` (on `S3-F-02` falling) and
`TEN-FR-013` (on `Q-013-07` falling). The PRD §9 records the reinstatements rather than silently restoring them.

---

## 12. Rejected findings — recorded as rejected, with reasons

`PRD_LIFECYCLE.md` Stage 3: *"A rejected finding must be recorded as rejected, with its reason … A review that
records only accepted findings is indistinguishable from a review that found nothing."*

| # | Candidate finding | Rejected because |
|---|---|---|
| `AL-R1` | *"`PRD-002`'s registry row still says `BC-19` is **⚠ Contested**, so check 1 fails on exclusivity."* | `PRD_REGISTRY.md` L447 and L540 both record the contest **resolved 2026-08-04 by `ADR-0013`**, and set contested contexts to **0**. L148's warning marker is a historical annotation in a different table, not a live claim. A Rank 2 ADR settles it |
| `AL-R2` | *"`Library_PRD_v1.md` L10 (frozen, Rank 3) declares `BC-19` among its owning contexts — a Rank 2 vs Rank 3 conflict."* | `ADR-0013` was issued **precisely** to resolve this, and does so without contradiction by splitting context from aggregate ownership (L132). `PRD-002` retains the `TenantOrganisation`/`StaffAssignment` **aggregates** (L187) — which is what its L10 claim substantively rests on. `ADR-0013` §2.1 L118–120: *"It does **not** change any aggregate's location, name or invariant"* |
| `AL-R3` | *"The PRD should publish a reinstatement event so cached denies can be cleared, since `LIB-8.5` makes `Restore` real."* | BC Map §9 registers exactly two `BC-19` events, and §7 L292 requires an ADR to add an edge: *"If an edge is not in this table, it **does not exist**."* Inventing the event would be a Stage 3 failure dressed as a fix. Declining and recording `S3-F-14`/`TEN-GAP-004` is the compliant choice — the `AR-R5` precedent |
| `AL-R4` | *"`ResidencyRegion` should be enumerated as India-first, since the product is India-first."* | Inventing a legal rule. `ADR-0041` L214 refuses this explicitly: *"This ADR names no period, no statute and no jurisdiction rule — doing so would be inventing a financial/compliance rule."* Frozen `AUTH` §11 L150 names no jurisdiction either. Owner is `SECURITY + DATA Governance`. `AR-R3` precedent |
| `AL-R5` | *"The PRD restates the lifecycle by listing `LIB-8.1`…`LIB-8.8` in §5.1, so it duplicates a frozen PRD after all."* | Opened §5.1 rather than trusting the shape. It lists **identifiers and subjects as a citation table**, defines no state name, no transition and no rule text, and explicitly records `TEN-FR-012` as retired *because* it had restated the machine. A citation with a back-pointer is the pattern `TRACEABILITY_MATRIX.md` §2F.2 calls an *index*, not a definition site |
| `AL-R6` | *"`platform/tenancy` reading `TenantContext` from R0 is an upward dependency and breaches `L2`."* | Matrix §8.3 declares this exact resolution and the legend marks it `◇*` — *"permitted upward exception."* `L2` is satisfied **by** the declared exception. Structurally identical to `PRD-007`'s `AR-R1` (Core Library cluster) |
| `AL-R7` | *"The EA's `Tenant Tiers & Quotas (V2)` versus BC Map's `BC-19` V1 should be raised as a scope conflict."* | The EA is Rank 6, descriptive, and outside Stage 3's Rank 1–5 scope. `AR-R6` precedent. Correction, if any, belongs to the EA owner |
| `AL-R8` | *"`PRD-013` should be moved to `DRAFT` in `PRD_REGISTRY.md` and given a baseline row as part of passing Stage 3."* | Registry status and baseline rows are conferred at **Stage 7** by an admission ADR — freeze is *"conferred, not claimed"*. Doing it here would perform Stage 7 work inside Stage 3. `AR-R7` precedent. Registry status remains `PLANNED` |

---

## 13. Containment audit

| Check | Result |
|---|---|
| `PRD-013_TENANCY.md` modified | **No** — SHA-256 `fcd99ff7…f97e` identical before and after |
| PRD status / version changed | **No** — remains **v0.1 `DRAFT`** |
| PRD frozen | **No** |
| Any other PRD modified | **No** |
| BC Map · Master PRD · Rulings · Dependency Matrix · EA modified | **No** |
| Library PRD · Authentication PRD · `PRD-022` modified | **No** |
| `PRD_REGISTRY.md` · `DOCUMENTATION_BASELINE.md` · `PRD_LIFECYCLE.md` modified | **No** |
| Registry status changed | **No** — `PRD-013` remains `PLANNED` |
| ADR created or modified | **No** |
| `TRACEABILITY_MATRIX.md` touched (Stage 5) | **No** |
| `TEN-*` identifiers registered anywhere | **0** |
| Traceability checker created | **No** |
| Integration edge or domain event invented | **No** — both declined |
| Residency region value invented | **No** — zero occurrences measured |
| Existing gap resolved by this record | **No** — all six §9 items remain open with named owners |
| Stage 4 / 5 / 6 / 7 started | **No** |
| Commits · pushes made by this review | **0 / 0** |
| Files added | **1** — this document |

This record is a **historical validation record and is not part of the specification**, following
`DOCUMENTATION_BASELINE.md` §3.3's treatment of `LIBRARY_PRD_ALIGNMENT.md` (L153), `STUDENT_IDENTITY_ALIGNMENT.md`
(L157), `PRD-004_ALIGNMENT_REPORT.md` (L160) and `PRD-007_ARCHITECTURE_ALIGNMENT.md`. **It confers no status.**

---

## 14. Verdict

> ## ✅ **ALIGNED — Stage 3 PASS (1 check conditional)**

| # | Check | Authority | Result |
|---|---|---|---|
| 1 | Context ownership is exclusive | BC Map §3 | ✅ **PASS** — one claimant, contest closed by `ADR-0013`; `Tenant` only |
| 2 | Every integration edge exists in §7 | BC Map §7 | ⚠️ **CONDITIONAL** — 1/1 declared, **0 invented**; condition is `H-1`, product-wide |
| 3 | Rank direction is downward | Matrix `L2` | ✅ **PASS** — R4; sole upward read is the declared `◇*` exception |
| 4 | No authorisation decided outside `BC-18` | `X-13` *(mis-cited — `H-2`)* | ✅ **PASS** — recorded over a mis-cited authority, not silently substituted |
| 5 | No credential, OTP or session outside `BC-18` | `ID-1` | ✅ **PASS** — recorded **with its reason**, not assumed |
| 6 | Tenant scoping correct | `MP-GBR-08`, `X-13` | ✅ **PASS** — all four Rank 1 rules carried; cross-tenant access framed as impossible |

**0 conflicts.** **6 open items, none blocking**, each with a named owner. **13 prior findings withdrawn as
misreadings of the repository, every one preserved with the test that refuted it.** **8 candidate findings rejected**,
each with its reason recorded.

Three places where the draft is stronger than the rules require, all volunteered rather than mandated:
`TEN-XC-010` forecloses the module's most plausible security failure — a cached tenant context standing in for a live
authorisation — which no cited rule demanded; the lifecycle is **cited** to a frozen PRD rather than restated, keeping
a single source of truth; and the event register is **closed at two** with the missing reinstatement signal recorded
as a gap rather than quietly invented.

The honest counterweight: this PRD's Stage 3 history contains thirteen findings that were wrong, and the earlier
blocking verdict was wrong with them. What survives is small, real, and owned elsewhere — **nobody has yet written
down where a tenant's data may legally live.**

**Next stage:** Stage 4 — Requirements Review. **Not started.**

**Per the mandate, no PRD was modified, no ADR was created, no ranked or governance document was touched, no
identifier was registered, no gap was resolved, no traceability checker was written, and Stages 4, 5, 6 and 7 were
not started. Stage 3 is complete and stops here.**
