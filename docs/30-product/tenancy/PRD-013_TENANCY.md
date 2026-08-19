# PRD-013 — Tenancy

| Field | Value |
|---|---|
| **PRD** | `PRD-013` |
| **Module** | Tenancy |
| **Version** | **v0.1** |
| **Status** | **DRAFT** |
| **Owning bounded context** | **`BC-19` Tenancy** `[GENERIC]` — Shared Core |
| **Product version** | **V1** |
| **Owned aggregate** | **`Tenant` — and only `Tenant`** |
| **Module path** | `platform/tenancy` (rank 4) |
| **Manifest port name** | `shared_core.tenant_context` |
| **Shared-kernel declaration** | `liboora_contracts` (R0) — `TenantContext` interface and read-only accessor |
| **Requirement prefix** | `TEN-` |
| **Lifecycle stage** | **Stage 2 — Draft.** Stages 3, 4, 5, 6, 7 **not started** |
| **Registry status** | `PLANNED` in [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) — **unchanged by this document** |
| **Aligned to** | Master PRD (Rank 1) · `ADR-0003`, `ADR-0012`, `ADR-0013`, `ADR-0016` (Rank 2) · Library PRD v1.1 **FROZEN**, Authentication PRD v2.0 **FROZEN** (Rank 3) · Bounded Context Map v1.5, Module Dependency Matrix v1.3 (Rank 4) · Architecture Rulings (Rank 5) |
| **Date** | 2026-08-19 |
| **Reviewed at** | `6837a7b8c53d7246d00a2c82058eac6c70763c38` |

> **This document confers no status.** It is a Stage 2 draft. Per
> [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L41–42: *"A gate is not an opinion — if
> the artefact does not exist, the stage has not been passed, however complete the work feels."* Nothing here is
> registered in [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md), no registry row has been
> altered, no baseline entry exists, and no architecture alignment record has been written.

---

## 0. How to read this document

### 0.1 Normative language

**MUST**, **MUST NOT**, **SHALL**, **SHALL NOT** are binding. **SHOULD** is a strong default that requires a
recorded reason to depart from. **MAY** is genuinely optional.

### 0.2 Identifier registers — the ranges as a promise

Per the Stage 2 gate: *"its identifier registers declared **up front** with ranges — as `Student_Identity_PRD_v1.md`
§0 does, publishing 'the ranges as a promise'."* Ranges are **contiguous**; a hole makes the published range false.

Three **distinct classes** of identifier are published below, and they are counted separately. A reader counting
"requirements" should use class A; the headline total is the sum of all three and is not a requirement count.

**Class A — normative requirements and exclusions.** Obligations this module must satisfy.

| Register | Range | Count | Section | Meaning |
|---|---|---:|---|---|
| `TEN-FR-001` … `TEN-FR-011` | contiguous | **11** | §1–§3 | Functional requirements |
| `TEN-FR-013` … `TEN-FR-015` | contiguous | **3** | §3 | Functional requirements (continued — `TEN-FR-012` retired, §9) |
| `TEN-FR-018` … `TEN-FR-021` | contiguous | **4** | §3, §6 | Functional requirements (continued — `TEN-FR-016`/`017` retired, §9) |
| `TEN-BR-001` | single | **1** | §4 | Business rules (`TEN-BR-002`/`003` retired, §9) |
| `TEN-BR-004` | single | **1** | §4 | Business rules |
| `TEN-INV-001` … `TEN-INV-002` | contiguous | **2** | §5 | Domain invariants — always true (`TEN-INV-003`…`005` retired, §9) |
| `TEN-EVT-001` … `TEN-EVT-002` | contiguous | **2** | §6 | Domain events — **closed at exactly two** |
| `TEN-XC-001` … `TEN-XC-010` | contiguous | **10** | §7 | Exclusions — what **MUST be impossible** |
| | | **34** | | **Class A total** |

**Class B — acceptance criteria.** Verification statements, not obligations. Each maps to at least one Class A
identifier.

| Register | Range | Count | Section | Meaning |
|---|---|---:|---|---|
| `TEN-AC-001` … `TEN-AC-002` | contiguous | **2** | §8 | Acceptance criteria (`TEN-AC-003`…`005` retired, §9) |
| `TEN-AC-006` … `TEN-AC-016` | contiguous | **11** | §8 | Acceptance criteria (continued) |
| | | **13** | | **Class B total** |

**Class C — open-gap records.** Absent decisions owned elsewhere. These are **not** requirements and impose no
obligation on this module.

| Register | Range | Count | Section | Meaning |
|---|---|---:|---|---|
| `TEN-GAP-001` … `TEN-GAP-004` | contiguous | **4** | §10 | Open gaps — absent decisions owned elsewhere |
| | | **4** | | **Class C total** |

**Totals: Class A 34 · Class B 13 · Class C 4 — 51 identifiers defined. 12 retired permanently and never reused
(§9).** `TEN-FR-021` and `TEN-AC-009`…`016` were added by the Stage 4 correction (changelog); no retired number was
reused to do it, and no in-force identifier was renumbered.

`TEN-CFG-*` is **declared empty.** Rank 7 [`CONFIGURATION_GUIDE.md`](../../20-configuration/CONFIGURATION_GUIDE.md)
contains no tenancy, tier or residency parameter. Publishing a configurable without a default and a range would be
the Stage 4 failure *"Unbounded configuration is a specification hole"*, so this module publishes none.
`TEN-CFG-001` is retired (§9).

### 0.3 What this module is — and the two ownership rights

`ADR-0013` §1.5 L132 draws the distinction this document depends on:

> *"**Context ownership** is the right to define the capability's contract, invariants and lifecycle. **Aggregate
> ownership** is the right to define a specific tenant-facing record that lives within it. They are different rights
> and may be held by different PRDs."*

`PRD-013` holds **context ownership of `BC-19`** and **aggregate ownership of `Tenant` only**. It does **not** hold
aggregate ownership of `TenantOrganisation` or `StaffAssignment` — those are `PRD-002`'s (§7, `TEN-XC-001`/`002`).

### 0.4 Three names that are not the same thing

A prior review conflated these. They are distinct artefacts at distinct ranks, and this document keeps them apart:

| Name | What it is | Authority |
|---|---|---|
| **`platform/tenancy`** | The **module path** at rank 4 | `DEPENDENCY_GRAPH.md` L39 — *"\| 4 \| platform/tenancy · platform/identity \| Capability \|"*; `ADR-0013` L103 |
| **`shared_core.tenant_context`** | The **manifest port name**, following the `<platform>.<port>` convention used by every entry in the port list (`data.repository`, `security.crypto`, `platform_services.time`, `identity.policy_decision`, `business.entitlement`) | Module Dependency Matrix L192 |
| **`liboora_contracts`** | The **R0 shared-kernel package** declaring the `TenantContext` *interface* and its read-only accessor, beside `Telemetry` and `Clock` | Matrix §6.3 L336 — *"port_interfaces: 'only ports of universal reach (TenantContext, Telemetry, Clock)'"* |

Declaring an interface in the shared kernel is **not** an ownership transfer. `BC-19` remains the owner of tenant
context; `liboora_contracts` is where the universally-reachable interface is declared so that a downward import is
not required. This is the `◇*` exception, Matrix legend L157: *"`◇*` = TenantContext read-only accessor from Shared
Core; permitted upward exception, see §8.3."*

---

## 1. Purpose

`BC-19` is the root of the platform's multi-tenancy. Rank 1 states it plainly:

> *"`BC-19` Tenancy | Tenant lifecycle, tiers, quotas, residency. **Nothing multi-tenant works without it.**"*
> — `MASTER_PRD.md` L190

Bounded Context Map §3.3 L128 registers the context:

> `| **BC-19** | **Tenancy** | [GENERIC] | Shared Core | V1 | Owns the tenant (library organisation) record, tenant context propagation, tiers, residency, lifecycle. |`

`TEN-FR-001` — The module **SHALL** own the `Tenant` aggregate as defined in Bounded Context Map §8 L381, and no
other aggregate.

`TEN-FR-002` — The module **SHALL** own the propagation of tenant context to every rank that reads it, via the
`shared_core.tenant_context` port and the `E-18` shared-kernel relationship.

`TEN-FR-003` — The module **SHALL NOT** own, define or store any tenant-facing business record beyond `Tenant`.

---

## 2. Aggregate and value objects

Bounded Context Map §8 L381, Rank 4, verbatim:

> `| BC-19 Tenancy | Tenant | TenantTier, Quota, ResidencyRegion, TenantLifecycleState | Tenant ID immutable; suspended tenant rejects all writes; residency region immutable after first write |`

| Element | Kind | Owned here? |
|---|---|---|
| `Tenant` | **Aggregate root** | ✅ **Yes** |
| `TenantTier` | Value object | ✅ Yes |
| `Quota` | Value object | ✅ Yes |
| `ResidencyRegion` | Value object | ✅ Yes — **value set unenumerated**, see `TEN-GAP-001` |
| `TenantLifecycleState` | Value object | ✅ Yes — **state machine cited, not restated**, see §5.1 |

`TEN-FR-004` — `Tenant` **SHALL** be the module's only aggregate root.

`TEN-FR-005` — `Tenant` **SHALL** carry `TenantTier`, `Quota`, `ResidencyRegion` and `TenantLifecycleState` as value
objects of the aggregate.

`TEN-FR-006` — `TenantTier` and `Quota` **SHALL** be inputs to entitlement derivation, never derived outputs.
Bounded Context Map §8 L383 assigns the derived outputs — `FeatureGate`, `UsageCounter`, `Limit` — to `BC-21`
Entitlement, whose invariant reads *"Derived state only — **never** hand-edited; recomputable from Subscription
events."* The two value-object sets are disjoint.

`TEN-FR-007` — The module **SHALL NOT** define, store or compute `FeatureGate`, `UsageCounter` or `Limit`.

`TEN-FR-008` — `TenantId` **SHALL** be the value object declared in `liboora_contracts` (R0), per Matrix §6.3 L333.

`TEN-FR-009` — The module **SHALL NOT** assume that `TenantTier` has been promoted to `liboora_contracts`. That
question is open and owned elsewhere — see `TEN-GAP-002`.

---

## 3. Tenant context — propagation and enforcement

### 3.1 The Rank 1 rules

`MASTER_PRD.md` L337–340, verbatim:

| ID | Rule |
|---|---|
| **`MP-GBR-06`** | *"Every request carries a resolved tenant context."* |
| **`MP-GBR-07`** | *"Every emitted domain event carries tenant context. A consumer that processes an event without establishing tenant context **fails loudly, never defaults**."* |
| **`MP-GBR-08`** | *"Every search index and vector namespace is tenant-partitioned. Every RAG retrieval is tenant-scoped **and** permission-aware."* |
| **`MP-GBR-09`** | *"A change to a cache key, index name or vector namespace is a **security-reviewable change**. Cross-tenant leakage via a capability context is the single highest-severity failure mode in the architecture."* |

### 3.2 Requirements derived from them

`TEN-FR-010` — Every request **MUST** carry a resolved tenant context before any tenant-scoped operation executes
(`MP-GBR-06`).

`TEN-FR-011` — Reading tenant context when it is unset **MUST** throw. It **MUST NOT** default to a tenant and
**MUST NOT** default to null. Matrix §8.3 L409: *"Reading it when unset **throws**; it never defaults to a tenant or
to null."*

`TEN-FR-013` — The `TenantContext` interface and its read-only accessor **SHALL** be declared in
`liboora_contracts` (R0). No setter **MAY** be exported beyond the composition root. Matrix §8.3 L408: *"Read-only
outside the edge — no setter is exported beyond the composition root."*

`TEN-FR-014` — Tenant context **MUST** be async-scoped, so that concurrent requests cannot observe each other's
tenant (Matrix §8.3 L411).

`TEN-FR-015` — Tenant context **MUST NOT** be passed as a domain method parameter. Bounded Context Map §7.3 L327
`E-18`: *"Ambient `TenantContext` | Propagated, **never passed as a parameter** through domain methods."* Matrix
§8.3 L410 gives the reason: *"that would leak infrastructure into the domain signature."*

`TEN-FR-018` — Every row of a tenant-scoped context **MUST** carry `tenant_id`; every row of a global context
**MUST NOT**. `MASTER_PRD.md` L398 states this as *"**Mandatory** for tenant-scoped contexts. **Forbidden** in
global contexts"*, and L400 records that *"'Where applicable' is now a decision rule, not a hedge."*

`TEN-FR-019` — Every search index, cache key and vector namespace touching tenant data **MUST** be
tenant-partitioned (`MP-GBR-08`, and Matrix `X-13` *"Cache/index/vector key without tenantId"*).

`TEN-FR-020` — A change to a cache key, index name or vector namespace **MUST** be treated as a security-reviewable
change (`MP-GBR-09`).

---

## 4. Business rules

`TEN-BR-001` — A suspended tenant rejects all writes. Bounded Context Map §8 L381 states this as an invariant of the
`Tenant` aggregate; `LIB-8.2` and `LBR-7` state the operational consequence at Rank 3.

`TEN-BR-004` — Tenant isolation is **structural**, and is additionally re-asserted at every authorisation decision.
`ADR-0003` records why both are required: *"**Tenant isolation must be enforced at every authorization decision
rather than at a data partition** … a continuous obligation, not a one-time structural guarantee."* This module
supplies the **context**; it does not make the decision (`TEN-XC-003`, `TEN-XC-010`).

---

## 5. Invariants

`TEN-INV-001` — `Tenant` ID **MUST** be immutable (Bounded Context Map §8 L381).

`TEN-INV-002` — `ResidencyRegion` **MUST** be immutable after first write (Bounded Context Map §8 L381). This
invariant holds **without** the value set being enumerated, and is stated here without asserting any region.

### 5.1 Lifecycle state machine — **cited, not restated**

The tenant lifecycle is **already specified** at Rank 3 in a **FROZEN** document. Restating it here would create the
Stage 4 failure *"Two sources of truth"*, so this document **cites** it and defines nothing.

**Authoritative source:** [`Library_PRD_v1.md`](../library/Library_PRD_v1.md) §8 — **FROZEN v1.1, Rank 3**:

| Cited requirement | Subject |
|---|---|
| `LIB-8.1` | A library **MUST NOT** be publicly discoverable in any state other than **Active** |
| `LIB-8.2` | A **Suspended** library **MUST NOT** perform any operational activity |
| `LIB-8.3` | Suspension **MUST** take effect immediately and globally, with no propagation window |
| `LIB-8.4` | Suspension **MUST NOT** delete, alter or invalidate any business record |
| `LIB-8.5` | `Archive` **MUST** be reversible via `Restore`; `Restore` returns the library to **Suspended**, never directly to **Active** |
| `LIB-8.6` | Every lifecycle transition **MUST** be audit logged with actor, timestamp, prior state, new state and reason |
| `LIB-8.7` | Only `TR-1` Owner or a Platform Administrator **MAY** initiate `Suspend`, `Archive` or `Restore` |
| `LIB-8.8` | Permanent deletion is **out of V1 scope**; `Archive` is the terminal state |

The binding of that state machine to `BC-19` is established by three independent sources, none of them this
document:

- `ARCHITECTURE_RULINGS.md` L44 (Rank 5): *"Library Name · Business Address · Map Location · **Library Status** ·
  Business Contact Information | `BC-19` Tenancy"*
- `Library_PRD_v1.md` L1091 (Rank 3, frozen): *"Library name, address, contact, **status**, tenant record | `BC-19`
  | **Owns**"*
- `REVIEW_14A.md` L392: *"Consistent with **`BC-19`'s `TenantLifecycleState`** and its invariant 'suspended tenant
  rejects all writes'."*

`TEN-FR-012` is **retired** (§9): it restated this state machine, which `LIB-8.1`…`LIB-8.8` already owns.

**This document defines no state, no transition and no state name.** `TenantLifecycleState` is owned as a value
object of `Tenant`; its permitted values and transitions are `LIB` §8's.

---

## 6. Event surface — **closed at exactly two**

Bounded Context Map §9 L435, Rank 4, verbatim:

> `| BC-19 | tenancy.TenantProvisioned / TenantSuspended | All, BC-21, BC-24 | Lifecycle gates |`

`TEN-EVT-001` — `tenancy.TenantProvisioned` — consumers: All, `BC-21`, `BC-24`.

`TEN-EVT-002` — `tenancy.TenantSuspended` — consumers: All, `BC-21`, `BC-24`.

**The register is closed at two.** No third event is published by this module.

`TEN-FR-021` — Both events **MUST** carry the full event envelope of Bounded Context Map §9.1 L449–450 — `eventId`,
`eventType`, `schemaVersion`, `occurredAt`, `tenantId`, `actorId`, `correlationId`, `causationId`, `aggregateId`,
`payload` — with a non-null `tenantId`, written via **Transactional Outbox** in the same DB transaction as the
aggregate mutation. Rank 4 §9.1 states that *"`tenantId` is mandatory on every domain event. A consumer that
processes an event without establishing tenant context must fail loudly, not default"*; Rank 1 `MP-GBR-07` states the
same obligation on the consuming side.

> **Authority note.** An earlier draft of this section cited `TEN-FR-019` for the envelope. That was wrong:
> `TEN-FR-019` governs **search index, cache key and vector namespace partitioning** (`MP-GBR-08`, `X-13`) and says
> nothing about event envelopes. The envelope obligation derives from Bounded Context Map §9.1 and `MP-GBR-07`, and
> is now carried by `TEN-FR-021` rather than left as unidentified normative prose.

### 6.1 No reinstatement event is invented

`LIB-8.5` makes suspension recoverable via `Restore`, and Authentication `XC-5.6` describes a session surviving
suspension. **No reinstatement event is registered in Bounded Context Map §9.** Adding one would require amending a
frozen Rank 4 document, which this PRD has no authority to do — Bounded Context Map §7 L292: *"If an edge is not in
this table, it **does not exist** and adding it requires an ADR."*

This module therefore **declines** to invent one. The consequence — that a consumer which cached a deny has no
published signal to re-allow — is recorded as `TEN-GAP-004`, unresolved, with the Architecture Owner named. It is
**not** silently fixed here.

`LEV-1`…`LEV-6` (`LibraryCreated`, `LibraryVerified`, `LibraryActivated`, `LibrarySuspended`, `LibraryArchived`,
`LibraryRestored`) belong to the **frozen** Library PRD's event surface and are **not** claimed by this module.

---

## 7. Exclusions — what **MUST be impossible**

Per the Stage 4 standard: *"Every exclusion states what must be **impossible**. An exclusion is not a deferral."*

| ID | Exclusion | Owner instead | Authority |
|---|---|---|---|
| `TEN-XC-001` | The module **MUST NOT** define, store, mutate or claim the **`TenantOrganisation`** aggregate. No code path in `platform/tenancy` may create or write it | **`PRD-002`** | `ADR-0013` L187, L220 — *"§5's aggregate column is normative: `TenantOrganisation` and `StaffAssignment` are `PRD-002`'s"*; Roadmap L109–110 — *"`PRD-013` must NOT claim them"* |
| `TEN-XC-002` | The module **MUST NOT** define, store, mutate or claim the **`StaffAssignment`** aggregate, nor any `LIB-6.x` field rule | **`PRD-002`** | `ADR-0013` L103, L187, L220 |
| `TEN-XC-003` | The module **MUST NOT** make, store or evaluate an **authorisation decision**. No role, permission, scope or policy is defined here | **`BC-18`** | Matrix `X-13`; Bounded Context Map §7.4 (Capability → Domain forbidden) |
| `TEN-XC-004` | The module **MUST NOT** store a **credential, password, OTP, session or device record** | **`BC-18`** | Bounded Context Map §4 `ID-1` L178 — *"No context outside BC-18 may store a password, OTP, session or credential"* |
| `TEN-XC-005` | The module **MUST NOT** define, store or compute **subscription or billing state** — `Subscription`, `SubscriptionInvoice`, `SubscriptionPlan`, `PaymentAttempt`, `DunningState` | **`BC-20`** | Bounded Context Map §8 L382; `PRD-022` L29 — *"`BC-20` owns `Subscription`; **nothing else may**"* |
| `TEN-XC-006` | The module **MUST NOT** define, store or compute **entitlement outputs** — `EntitlementSet`, `FeatureGate`, `UsageCounter`, `Limit` | **`BC-21`** | Bounded Context Map §8 L383 — *"Derived state only — **never** hand-edited"* |
| `TEN-XC-007` | **Cross-tenant access MUST be impossible.** No operation, query, cache, index or projection owned by this module may return, reference or infer data belonging to a tenant other than the resolved one | — | `MP-GBR-08`/`09`; Matrix `X-13`; `AUTH-5.36` — *"No operation performed under one active library MAY read, write, reference or infer data"* |
| `TEN-XC-008` | The module **MUST NOT** define, store or claim the **tenant lifecycle state machine**, its states or its transitions | **`PRD-002`**, `LIB-8.1`…`8.8` | §5.1 |
| `TEN-XC-009` | The module **MUST NOT** publish any domain event beyond the two registered in Bounded Context Map §9 L435 | — | Bounded Context Map §7 L292 |
| `TEN-XC-010` | The module **MUST NOT** produce, cache, alter or short-circuit an **authorisation outcome**. Supplying tenant context is not deciding access; a cached tenant context **MUST NOT** be relied upon as evidence that an authorisation still holds | **`BC-18`** | `ADR-0003` — *"Tenant isolation must be enforced at **every** authorization decision rather than at a data partition … a continuous obligation, not a one-time structural guarantee"*; `LIB-8.3` — *"A cached authorisation decision **MUST NOT** permit an operation in a library suspended a moment earlier"* |

---

## 8. Acceptance criteria

| ID | Criterion | Verifies |
|---|---|---|
| `TEN-AC-001` | A tenant-scoped operation attempted with no resolved tenant context is refused, and the refusal is an error — not a default tenant and not null | `TEN-FR-010`, `TEN-FR-011` |
| `TEN-AC-002` | Two concurrent requests for different tenants never observe each other's tenant context | `TEN-FR-014` |
| `TEN-AC-006` | A write attempted against a suspended tenant is rejected | `TEN-BR-001` |
| `TEN-AC-007` | Each of the two published events carries the full §9.1 envelope with a non-null `tenantId`, written via Transactional Outbox in the same transaction as the aggregate mutation; a consumer processing one without establishing tenant context fails loudly | `TEN-EVT-001`, `TEN-EVT-002`, `TEN-FR-021` |
| `TEN-AC-008` | An attempt to write `TenantOrganisation`, `StaffAssignment`, an authorisation outcome, a credential, or subscription state from within `platform/tenancy` fails — statically or at runtime | `TEN-XC-001`…`006`, `TEN-XC-010` |
| `TEN-AC-009` | An attempt to mutate the ID of an existing `Tenant` is rejected; the stored ID is unchanged after the attempt | `TEN-INV-001` |
| `TEN-AC-010` | A second write of `ResidencyRegion` on a `Tenant` that already carries one is rejected, **whatever value is supplied**. The criterion is satisfiable without any permitted value set existing (`TEN-GAP-001`) | `TEN-INV-002` |
| `TEN-AC-011` | A query, projection, cache read or index lookup issued under tenant A returns no row, reference or derived count belonging to tenant B. Attempting one is an error, not an empty result | `TEN-XC-007` |
| `TEN-AC-012` | No state name, transition or state-machine definition for the tenant lifecycle appears in `platform/tenancy`; the module's only lifecycle surface is the `TenantLifecycleState` value it stores | `TEN-XC-008` |
| `TEN-AC-013` | The set of domain event types published by `platform/tenancy` is exactly `{tenancy.TenantProvisioned, tenancy.TenantSuspended}`. Publishing any third type fails | `TEN-XC-009`, `TEN-EVT-001`, `TEN-EVT-002` |
| `TEN-AC-014` | Every persisted row of a tenant-scoped context owned by this module carries a non-null `tenant_id`; a global-context row carries no `tenant_id` column at all | `TEN-FR-018` |
| `TEN-AC-015` | Every cache key, index name and vector namespace emitted by this module contains the resolved `tenantId`. One constructed without it fails | `TEN-FR-019` |
| `TEN-AC-016` | A change to a cache key, index name or vector namespace in this module cannot be accepted without a recorded security review against `MP-GBR-09` | `TEN-FR-020` |

Every criterion above maps to a requirement in this document. There are **no orphan criteria** and **no dangling
citations**.

**Reverse coverage.** Of the 24 normative requirements (`TEN-FR-*`, `TEN-BR-*`, `TEN-INV-*`, `TEN-EVT-*`) and 10
exclusions, those still carrying no criterion are `TEN-FR-001`…`009`, `TEN-FR-013`, `TEN-FR-015` and `TEN-BR-004`.
Each is a **structural or ownership statement** verified by the module's shape rather than by a runtime assertion —
`TEN-FR-004`'s single aggregate root and `TEN-FR-007`'s absent entitlement types are observable in the type
inventory, and `TEN-BR-004` is discharged by `TEN-AC-008`/`TEN-AC-011` between them. `TEN-XC-002`…`006` are covered
collectively by `TEN-AC-008`'s range. This is recorded rather than left to be inferred.

---

## 9. Retired identifiers — permanently, never reused

`PRD_LIFECYCLE.md` Stage 6: *"**Never reuse or reassign a number.**"* This register applies that discipline to
requirement identifiers withdrawn during Stage 3 review. **Twelve identifiers are retired. None may be reused for
any future requirement.**

| Retired ID | Was | Retired because |
|---|---|---|
| `TEN-FR-012` | Tenant lifecycle state machine | Restated `LIB-8.1`…`LIB-8.8`, a **FROZEN** Rank 3 register. Stage 4 check 5 — *"Two sources of truth."* Cited in §5.1 instead |
| `TEN-FR-016` | Tenant-scoped operations resolve tenant from active context | Restated `AUTH-5.33` (frozen Rank 3) |
| `TEN-FR-017` | An operation naming a tenant explicitly is refused | Restated `XC-7.14` (frozen Rank 3) |
| `TEN-BR-002` | Tenant derived from context, never from caller | Restated `BR-5.20` (frozen Rank 3) |
| `TEN-BR-003` | *(withdrawn at Stage 3)* | Duplicated `TEN-BR-001`'s subject |
| `TEN-INV-003` | *(withdrawn at Stage 3)* | Asserted an invariant over an aggregate this module does not own (`TEN-XC-001`) |
| `TEN-INV-004` | *(withdrawn at Stage 3)* | Asserted an invariant over `StaffAssignment` (`TEN-XC-002`) |
| `TEN-INV-005` | *(withdrawn at Stage 3)* | Asserted a lifecycle invariant owned by `LIB` §8 |
| `TEN-CFG-001` | A tenancy configurable | Rank 7 `CONFIGURATION_GUIDE.md` defines no tenancy parameter. Publishing it would be unbounded configuration — Stage 4 check 3. `TEN-CFG-*` is declared **empty** |
| `TEN-AC-003` | *(withdrawn at Stage 3)* | Verified retired `TEN-FR-012` |
| `TEN-AC-004` | *(withdrawn at Stage 3)* | Verified retired `TEN-FR-016`/`017` |
| `TEN-AC-005` | *(withdrawn at Stage 3)* | Verified retired `TEN-INV-003`…`005` |

**Reinstated after review, and in force above:** `TEN-FR-005`…`009` and `TEN-FR-013`. Each had been retired on a
misreading of the repository — `TEN-FR-005`…`009` on the belief that `BC-19` could own no aggregate, and
`TEN-FR-013` on the belief that declaring `TenantContext` in `liboora_contracts` transferred ownership. Both beliefs
were disproven against Bounded Context Map §8 and Matrix §6.3 respectively. The reinstatements are recorded here so
the register's history is not silently rewritten.

---

## 10. Open gaps — absent decisions, owned elsewhere

None of the following is resolved by this document, and none is invented.

### `TEN-GAP-001` — `ResidencyRegion` value set is unenumerated

| Field | Value |
|---|---|
| **Gap** | `ResidencyRegion` is owned by `BC-19` as a value object of `Tenant` (Bounded Context Map §8 L381), but **its permitted values are enumerated nowhere in the repository** |
| **Measured** | Zero enumerations. `AUTH-11.37` (frozen Rank 3) says only *"Personal data MUST be held within **permitted jurisdictions**"* and names none. `ADR-0041` L214 **explicitly refuses** to name one: *"This ADR names no period, no statute and no jurisdiction rule — doing so would be inventing a financial/compliance rule"* |
| **Owner** | **SECURITY + DATA Governance** — `MASTER_PRD.md` `MP-NFR-10` L504, which assigns *"data residency"* to that function |
| **Instrument** | A compliance decision, taken with counsel. Not an architecture decision, and not this PRD's to make |
| **Invented here?** | **No.** No region, jurisdiction, statute or default is asserted anywhere in this document |
| **V1 behaviour** | `TEN-INV-002` holds under **any** resolution: the region is immutable after first write regardless of which values are eventually permitted. The module stores the value it is given and enumerates nothing |
| **Blocks Stage 2?** | **No** |

### `TEN-GAP-002` — `TenantTier` visibility to `platform/business`

`ADR-0012` L176 records the debt and its two options: *"Either promote `TenantTier` to `liboora_contracts` as shared
vocabulary (**an ownership change, so it needs its own ADR**) or have Business declare a one-method
`TenantTierSource` port"* — expiry **2026-10-31**. Owned by `TASK-D10` / `BLK-01`. **Unresolved.** This module
assumes neither option (`TEN-FR-009`). Ownership of `TenantTier` itself is not in question: Bounded Context Map §8
L381 assigns it to `BC-19`.

### `TEN-GAP-003` — Tenant deletion identity

`PRD-022` L650–651: *"deciding **which** identity survives a deletion — and whether a soft-deleted tenant is the
same tenant — depends on the tenant lifecycle and the `CFG-10` soft-delete retention that **`PRD-001` and `BC-25`
own, not this document**."* Routed by `PRD-022` L749 as `SAAS-GAP-005` to **Architecture Owner + `PRD-001`**.
**Unresolved, and not this PRD's to close.** `LIB-8.8` scopes permanent deletion out of V1; `MP-GBR-14` prefers soft
delete *"except where erasure is legally compelled."*

### `TEN-GAP-004` — No reinstatement event is published

Bounded Context Map §9 L435 registers exactly two `BC-19` events. `LIB-8.5` makes suspension recoverable and
Authentication `XC-5.6` assumes recovery, but **no reinstatement event exists** for a consumer that cached a deny to
observe. Owner: **Architecture Owner**. Instrument: an `ADR-0016`-style single-cell amendment to Bounded Context Map
§9, if one is wanted. **This module declines to invent the event** (§6.1) and publishes exactly the two registered.

### 10.1 Known defects recorded but **not** treated as resolved

| Item | Status | Owner |
|---|---|---|
| **`H-1`** — Bounded Context Map §7 has no capability→capability subsection. `BC-19`'s downstream edges and `BC-20`→`BC-21` are both published in §9 while absent from §7 | **Open, product-wide, pre-existing.** Not resolved here. This module's compliant posture is to **decline** any edge not in §7, never to invent one | **Architecture Owner** |
| **`H-2`** — `PRD_LIFECYCLE.md` L96 pairs the check *"No authorisation decided outside `BC-18`"* with `X-13`, which is the tenant-key rule | **Open.** Recorded, not silently substituted | **Governance Owner** |
| **`S3-F-14`** — the missing reinstatement signal | **Open** = `TEN-GAP-004` | **Architecture Owner** |
| **`ADR-0012` / `TASK-D10`** | **Open** = `TEN-GAP-002`, expiry 2026-10-31 | `TASK-D10` / `BLK-01` |
| **`SAAS-GAP-005`** | **Open** = `TEN-GAP-003` | **Architecture Owner + `PRD-001`** |

---

## 11. Consumed authority — what this module reads, and how

| Edge / port | Direction | Registered where |
|---|---|---|
| `E-18` — Ambient `TenantContext`, `SK` | All contexts → `BC-19` | Bounded Context Map §7.3 L327 |
| `shared_core.tenant_context` | Manifest port name | Matrix L192 |
| `◇*` read-only accessor from Shared Core | Permitted upward exception | Matrix legend L157, §8.3 |
| `liboora_contracts` (R0) | Shared-kernel declaration of the `TenantContext` interface, `TenantId` | Matrix §6.3 L333, L336 |
| `tenancy.TenantSuspended` | Consumed by the module manifest | Matrix L201 |

`TEN-FR-002` is satisfied through these declared mechanisms only. **No new edge is asserted.**

---

## 12. Lifecycle position

| Stage | Status |
|---|---|
| 1 — Discovery | **Passed** — `BC-19` identified in the Bounded Context Map and not already owned in `PRD_REGISTRY.md` §6 |
| 2 — Draft | **This document.** Version/status header present; identifier registers declared up front with contiguous ranges; normative language defined |
| 3 — Architecture Review | **Not started.** No alignment record exists |
| 4 — Requirements Review | **Not started** |
| 5 — Traceability | **Not started.** No `TEN-*` prefix is registered in `TRACEABILITY_MATRIX.md`; no checker exists |
| 6 — Implementation Tasks | **Not started.** No `IMPL-*` range is allocated or claimed |
| 7 — Freeze | **Not started.** No `DOCUMENTATION_BASELINE.md` row exists |
| 8 — Implementation | Not started |
| 9 — Verification | Not started |

Registry status remains **`PLANNED`**. Status is conferred by the lifecycle, never claimed by the document.

---

## Changelog

| Version | Date | Change |
|---|---|---|
| v0.1 | 2026-08-19 | Initial Stage 2 draft. Identifiers defined across 8 registers; `TEN-CFG-*` declared empty; 12 identifiers retired permanently; 4 open gaps recorded with named owners; lifecycle state machine cited to frozen `LIB-8.1`…`8.8` rather than restated; event surface closed at the two registered events with no reinstatement event invented |
| v0.1 | 2026-08-19 | **Stage 4 correction — four findings applied, no version increment.** `RQ-1`: `TEN-AC-006` no longer cites `TEN-INV-001`, which it could not verify — ID immutability is now verified by new `TEN-AC-009`. `RQ-2`: acceptance coverage added for `TEN-XC-007`/`008`/`009`, `TEN-FR-018`/`019`/`020` and `TEN-INV-002` via `TEN-AC-009`…`016`, and residual uncovered requirements are now listed explicitly with the reason. `RQ-3`: §6's incorrect citation of `TEN-FR-019` for the event envelope replaced by new `TEN-FR-021`, carrying the Bounded Context Map §9.1 / `MP-GBR-07` obligation that had been unidentified prose; the error is recorded in an authority note rather than silently overwritten. `RQ-4`: §0.2 now counts requirements, acceptance criteria and gap records as three separate classes (34 · 13 · 4 = 51). **No in-force identifier renumbered; no retired identifier reused; no frozen document restated; no residency value asserted; version and status held at v0.1 `DRAFT` per `PRD-007_CORRECTION_RECORD.md` §5.6 — *"bumping either would be a claim this correction does not earn."*** |
