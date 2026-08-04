# LIBOORA — Module Dependency Matrix

| Field | Value |
|---|---|
| **Document** | Module Dependency Matrix & Boundary Enforcement Rules |
| **Version** | v1.2 |
| **Status** | Draft for Architecture Review Board sign-off |
| **Derived from** | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` v2.0 (commit `aba0831`) |
| **Companion doc** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` v1.3 |
| **ADRs applied** | [`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md) — introduces **rank 7.5** for `BC-10` Global Person Identity and shrinks the Social cluster to `BC-11`…`BC-13`. **No dependency law gains an exception.** · [`ADR-0012`](../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md) — records 12 **dated** §11 exceptions for pre-existing §4 mode violations in the V1 scaffold. Adds no rule and relaxes none; `L1` is fixed in code, never waived |
| **Machine-readable source** | `module_dependencies.yaml` — **now consumed by `tool/check_module_boundaries.dart` (`IMPL-014`)**; §10.2's rules are enforced, not merely declared |
| **As-built graph** | [`DEPENDENCY_GRAPH.md`](./DEPENDENCY_GRAPH.md) — descriptive companion; this document remains normative |
| **Enforcement coverage** | **10 of 12** categories implemented. `X-13` tenant-key and `X-10` audit-mutation are **NOT** implemented and remain **unmet** (`SID-4.56`) |
| **Last Updated** | 2026-08-04 |

---

## Table of Contents

1. [Purpose](#1-purpose)
2. [The Five Dependency Laws](#2-the-five-dependency-laws)
3. [Dependency Ranks](#3-dependency-ranks)
4. [Communication Modes](#4-communication-modes)
5. [The Matrix](#5-the-matrix)
6. [Per-Platform Allow-Lists](#6-per-platform-allow-lists)
7. [Forbidden Edges](#7-forbidden-edges)
8. [Cycle-Breaking Patterns](#8-cycle-breaking-patterns)
9. [Flutter / Dart Package Layout](#9-flutter--dart-package-layout)
10. [Enforcement in CI](#10-enforcement-in-ci)
11. [Exception Process](#11-exception-process)

---

## 1. Purpose

The bounded context map defines *where* boundaries are. This document defines **what the compiler and CI will refuse to let you do**.

An architecture diagram that is not mechanically enforced degrades to fiction within two quarters. Every rule below is designed to be checkable by a script, not by a reviewer's memory. The intended end state:

> A pull request that violates a module boundary **fails the build**, with an error message naming the rule it broke and the ADR required to change it.

---

## 2. The Five Dependency Laws

| # | Law | Rationale |
|---|---|---|
| **L1 — Acyclic** | The module dependency graph must be a DAG. No cycles at any granularity: platform, module, or file. | Cycles make independent testing, independent deployment and independent reasoning impossible. This is the one law with zero exceptions. |
| **L2 — Downward only** | A module may depend only on modules of **strictly lower rank** (§3). Same-rank dependencies are forbidden except within a declared cluster. | Rank ordering is what makes the graph provably acyclic without inspecting it. |
| **L3 — Domain never depends on capability implementations** | Domain platforms depend on **ports** they declare themselves. Adapters are wired at composition root. Domain code contains no vendor name, no SDK import, no HTTP client, no SQL. | Hexagonal architecture. This is what makes the core domain testable in milliseconds and portable across infrastructure. |
| **L4 — Capability never depends on domain** | No capability, generic or platform module may import a domain module. Ever. Communication is via `liboora_contracts` events and registered ports. | This is the single rule that makes microservice extraction (§12 of context map) a deployment change rather than a rewrite. |
| **L5 — Contracts import nothing** | `liboora_contracts` — the shared kernel — depends on the Dart SDK and nothing else. No Flutter, no packages, no platform code. | A shared kernel that imports anything becomes a transitive backdoor around L2 and L4. |

**L1 is absolute. L2–L5 admit exceptions only through the ADR process in §11.**

---

## 3. Dependency Ranks

Lower rank = more stable, more depended-upon, fewer dependencies. A module at rank *n* may import ranks `0 … n-1` only.

| Rank | Platforms at this rank | Character |
|---|---|---|
| **R0** | `liboora_contracts` *(shared kernel)* | Value objects, event schemas, error taxonomy, port interfaces of universal reach. Imports nothing. |
| **R1** | INFRASTRUCTURE | Cloud, compute, network, regions. Mostly IaC, not Dart. No app code depends on it at compile time. |
| **R2** | DATA · SECURITY | Persistence primitives, migration, encryption, secrets, key management. |
| **R3** | CONFIGURATION · OBSERVABILITY · PLATFORM SERVICES · EVENT | Cross-cutting runtime substrate: config, logging/metrics/tracing, jobs, files, cache, sync, event bus. |
| **R4** | SHARED CORE · IDENTITY & ACCESS | Tenancy, tenant context, auth, RBAC/ABAC, policy decision point. |
| **R5** | AUDIT · SEARCH · COMMUNICATION · INTEGRATION | Generic capabilities consumed broadly, event-fed. |
| **R6** | BUSINESS *(Subscription + Entitlement)* · WORKFLOW · AI | Higher-order capabilities. Orchestrate and decide, own no domain aggregate. |
| **R7** | ANALYTICS | Read models and metrics. Consumes events from everything below. |
| **R7.5** | GLOBAL PERSON IDENTITY *(`BC-10`)* | **Platform identity.** Its own tier: below every domain module, above every capability platform. Owns `PersonId`, username, global profile, privacy. Organisation-neutral — no `tenantId`. Domain modules at R8 depend on it **downward**, which is what keeps `L2` intact (`ADR-0011`). |
| **R8** | LIBRARY MANAGEMENT · STUDENT NETWORK | **Domain.** Highest rank because it depends on the most. Nothing depends on it. |
| **R9** | API *(incl. BFF)* | Edge composition. Depends on domain + capabilities, is depended on by nobody. |
| **RX** | FOUNDATION · ARCHITECTURE GOVERNANCE · DEVOPS · QUALITY · FUTURE ECOSYSTEM | **Not in the runtime graph.** Docs, pipelines, tests, future work. Quality may import everything (it tests everything); nothing may import Quality. |

### 3.1 The counter-intuitive part

Newcomers expect "domain is at the bottom because it's most important." It is at the **top** (R8) because rank measures *dependency direction*, not importance.

The domain is the **most depended-upon in meaning** and the **least depended-upon in code**. That inversion is achieved by L3: the domain declares its own ports, and implementations are injected. So `LIBRARY MANAGEMENT` sits at R8 pointing downward at *interfaces*, while `AI PLATFORM` at R6 never points up at it.

### 3.2 Same-rank clusters

Two exceptions to L2, both declared and bounded:

| Cluster | Members | Allowed internal edges |
|---|---|---|
| **Core Library cluster** (within R8) | BC-01 Enrollment, BC-02 Membership, BC-03 Attendance, BC-04 Seating, BC-05 Fee, BC-06 Policy | Only the edges E-01…E-10 listed in the context map. Enforced as an explicit allow-list, not "anything within the cluster". |
| **Social cluster** (within R8) | BC-11 Graph, BC-12 Messaging, BC-13 Safety | Only edges E-14…E-16. **`BC-10` was removed from this cluster by `ADR-0011`** and is now a rank-7.5 platform identity, consumed by these contexts rather than clustered with them. |

**The two clusters may not reference each other** (Separate Ways). The single bridge is E-13 via ACL.

**Why `ADR-0011` needed a new rank rather than a third cluster.** Every library module needs to resolve a person's identity. Had `BC-10` stayed at R8, that would have been a same-rank dependency **across** two clusters that may not reference each other — the precise shape `X-05` prohibits. The alternatives were to declare a third cluster spanning both (which dissolves the Separate Ways boundary), to add a `L2` exception (there are none, by design), or to move the identity to a lower rank. The third was chosen: at R7.5 a rank-8 domain module depends on it **strictly downward**, so `L2` is satisfied literally and no exception is created. `L1`…`L5` therefore remain exception-free.

---

## 4. Communication Modes

Every allowed edge in §5 and §6 is annotated with **how** it may be traversed. The mode is as binding as the permission.

| Mode | Symbol | Meaning | Compile-time import allowed? |
|---|---|---|---|
| **Direct import** | `▪` | Consumer imports the provider's public API directly. Reserved for R0 contracts and stable low-rank primitives. | Yes — provider's `lib/<name>.dart` barrel only |
| **Port** | `◇` | Consumer declares an interface; provider (or an adapter) implements it; DI wires it at the composition root. Consumer imports **no** provider code. | **No** |
| **Event** | `⚡` | Asynchronous only, via EVENT PLATFORM, payload from `liboora_contracts`. Producer does not know consumers exist. | **No** |
| **Command API** | `⌘` | Caller invokes the provider's published command handler through a port. Provider re-validates all invariants. Used for capability → domain writes. | **No** |
| **Edge/HTTP** | `⇥` | Crosses a process boundary via API Platform. Client code only. | **No** |
| **Forbidden** | `✖` | No edge exists. | **No** |
| **Test-only** | `◷` | Permitted in `test/` and `integration_test/` sources exclusively. | Yes, in test sources |

**Default mode when unspecified is `◇` (port).** If a table cell says only "allowed", read it as port-based.

---

## 5. The Matrix

Rows = **consumer**. Columns = **provider**. Read as *"may the row import/depend on the column, and how."*

Columns are grouped by rank to keep the matrix legible. `—` = same module. `✖` = forbidden.

```
                          │ R0  │ R2      │ R3                  │ R4        │ R5              │ R6           │ R7  │ R8      │
CONSUMER ↓                │ CTR │ DAT SEC │ CFG OBS PSV EVT     │ SHC IAM   │ AUD SRC COM INT │ BUS WKF AI   │ ANL │ LIB GST │
──────────────────────────┼─────┼─────────┼─────────────────────┼───────────┼─────────────────┼──────────────┼─────┼─────────┤
R0  liboora_contracts      │  —  │  ✖   ✖  │  ✖   ✖   ✖   ✖      │  ✖    ✖   │  ✖   ✖   ✖   ✖  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
──────────────────────────┼─────┼─────────┼─────────────────────┼───────────┼─────────────────┼──────────────┼─────┼─────────┤
R2  DATA                  │  ▪  │  —   ◇  │  ✖   ◇   ✖   ⚡     │  ✖    ✖   │  ✖   ✖   ✖   ✖  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
R2  SECURITY              │  ▪  │  ◇   —  │  ✖   ◇   ✖   ⚡     │  ✖    ✖   │  ⚡  ✖   ✖   ✖  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
──────────────────────────┼─────┼─────────┼─────────────────────┼───────────┼─────────────────┼──────────────┼─────┼─────────┤
R3  CONFIGURATION         │  ▪  │  ◇   ◇  │  —   ◇   ✖   ⚡     │  ◇*   ✖   │  ⚡  ✖   ✖   ✖  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
R3  OBSERVABILITY         │  ▪  │  ✖   ✖  │  ◇   —   ✖   ✖      │  ◇*   ✖   │  ✖   ✖   ✖   ✖  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
R3  PLATFORM SERVICES     │  ▪  │  ◇   ◇  │  ◇   ◇   —   ⚡     │  ◇*   ✖   │  ⚡  ✖   ✖   ◇  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
R3  EVENT                 │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   —      │  ◇*   ✖   │  ⚡  ✖   ✖   ✖  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
──────────────────────────┼─────┼─────────┼─────────────────────┼───────────┼─────────────────┼──────────────┼─────┼─────────┤
R4  SHARED CORE (Tenancy) │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   ⚡     │  —    ✖   │  ⚡  ✖   ✖   ✖  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
R4  IDENTITY & ACCESS     │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   ⚡     │  ◇    —   │  ⚡  ⚡  ⚡  ◇  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
──────────────────────────┼─────┼─────────┼─────────────────────┼───────────┼─────────────────┼──────────────┼─────┼─────────┤
R5  AUDIT                 │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   ⚡     │  ◇    ◇   │  —   ◇   ✖   ✖  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
R5  SEARCH                │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   ⚡     │  ◇    ◇   │  ⚡  —   ✖   ✖  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
R5  COMMUNICATION         │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   ⚡     │  ◇    ◇   │  ⚡  ✖   —   ◇  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
R5  INTEGRATION           │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   ⚡     │  ◇    ◇   │  ⚡  ✖   ✖   —  │  ✖   ✖   ✖   │  ✖  │  ✖   ✖  │
──────────────────────────┼─────┼─────────┼─────────────────────┼───────────┼─────────────────┼──────────────┼─────┼─────────┤
R6  BUSINESS              │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   ⚡     │  ◇    ◇   │  ⚡  ✖   ⚡  ◇  │  —   ◇   ✖   │  ✖  │  ✖   ✖  │
R6  WORKFLOW              │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   ⚡     │  ◇    ◇   │  ⚡  ✖   ⚡  ◇  │  ◇   —   ◇   │  ✖  │  ⌘   ⌘  │
R6  AI                    │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   ⚡     │  ◇    ◇   │  ⚡  ◇   ⚡  ◇  │  ◇   ◇   —   │  ◇  │  ⌘   ⌘  │
──────────────────────────┼─────┼─────────┼─────────────────────┼───────────┼─────────────────┼──────────────┼─────┼─────────┤
R7  ANALYTICS             │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   ⚡     │  ◇    ◇   │  ⚡  ✖   ⚡  ✖  │  ✖   ✖   ✖   │  —  │  ✖   ✖  │
──────────────────────────┼─────┼─────────┼─────────────────────┼───────────┼─────────────────┼──────────────┼─────┼─────────┤
R8  LIBRARY MANAGEMENT    │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   ⚡     │  ◇    ◇   │  ⚡  ◇   ⚡  ✖  │  ◇   ◇   ◇   │  ◇  │  —   ✖  │
R8  GLOBAL STUDENT        │  ▪  │  ◇   ◇  │  ◇   ◇   ◇   ⚡     │  ◇    ◇   │  ⚡  ◇   ⚡  ✖  │  ◇   ◇   ◇   │  ◇  │  ✖   —  │
──────────────────────────┼─────┼─────────┼─────────────────────┼───────────┼─────────────────┼──────────────┼─────┼─────────┤
R9  API / BFF             │  ▪  │  ✖   ◇  │  ◇   ◇   ◇   ✖      │  ◇    ◇   │  ⚡  ◇   ✖   ✖  │  ◇   ◇   ◇   │  ◇  │  ◇   ◇  │
──────────────────────────┴─────┴─────────┴─────────────────────┴───────────┴─────────────────┴──────────────┴─────┴─────────┘

Legend:  ▪ direct import   ◇ port (no import)   ⚡ event only   ⌘ command API (re-validated)   ✖ forbidden
         ◇* = TenantContext read-only accessor from Shared Core; permitted upward exception, see §8.3
         —  = self
```

### 5.1 How to read three important cells

| Cell | Value | Meaning |
|---|---|---|
| `AI PLATFORM` → `LIBRARY MANAGEMENT` | `⌘` | AI **may cause** a domain change — but only by invoking a published command through a port, with the domain re-validating every invariant and a Human-in-the-Loop record required (context map §7.4 F-4). AI may **never import** domain code. |
| `ANALYTICS` → `LIBRARY MANAGEMENT` | `✖` | Analytics learns about the domain **only** through events. It has no read access to domain tables. This is what prevents report queries from degrading OLTP and what makes the read-model rebuildable. |
| `LIBRARY MANAGEMENT` → `INTEGRATION` | `✖` | The domain must not know that Razorpay, Twilio or FCM exist. It emits facts and calls ports. Integration is reached only via BUSINESS (payments) or COMMUNICATION (messaging). |

---

## 6. Per-Platform Allow-Lists

The matrix is the human-readable form. This section is the **normative form** — what the lint rule checks. Anything not listed is forbidden.

### 6.1 Domain platforms

```yaml
library_management:            # R8 — CORE DOMAIN
  rank: 8
  may_import:                  # compile-time imports permitted
    - liboora_contracts
  may_use_ports:               # interfaces declared BY library_management, implemented elsewhere
    - data.repository            # persistence port
    - security.crypto            # field encryption port
    - configuration.settings     # typed config accessor
    - observability.telemetry    # logging/metrics/tracing port
    - platform_services.files
    - platform_services.qr
    - platform_services.idempotency
    - platform_services.offline_sync
    - platform_services.time      # NEVER DateTime.now() in domain code
    - shared_core.tenant_context
    - identity.policy_decision    # authorisation check
    - search.indexer              # write-side index notification
    - business.entitlement        # limit check before mutation
    - business.payment_intent     # money rails
    - workflow.process_trigger
    - ai.assist                   # suggestion only, never authority
    - analytics.read_model        # query side for dashboards
  may_emit_events: [ enrollment.*, membership.*, attendance.*, seating.*, fee.*, policy.* ]
  may_consume_events: [ billing.EntitlementChanged, tenancy.TenantSuspended, safety.EnforcementActionTaken ]
  internal_edges_allowed: [ E-01, E-02, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10 ]
  forbidden:
    - integration.*             # no vendor knowledge
    - global_student.*          # Separate Ways
    - api.*                     # never call the edge
    - "package:http"            # no network client in domain
    - "package:firebase_*"      # no SDK in domain
    - "dart:io"

person_identity:               # R7.5 — CORE (ADR-0011)
  rank: 7.5
  may_import: [ liboora_contracts ]
  may_use_ports:
    - data.repository
    - security.crypto
    - configuration.settings
    - observability.telemetry
    - platform_services.files       # FileRef only — E-22
    - identity.policy_decision      # ask BC-18, never evaluate or cache
    - search.indexer
  may_emit_events: [ identity.Person* ]        # SEV-1…SEV-16, closed set
  may_consume_events:
    - iam.AccountErased
    - iam.MobileNumberChanged
    - iam.AccountSuspended
    - safety.EnforcementActionTaken            # restricts the public projection ONLY
  forbidden:
    - library_management.*      # X-05 — rank 7.5 may not import rank 8
    - student_network.*         # rank 7.5 may not import rank 8
    - api.*
    - shared_core.tenant_context   # NOT tenant-scoped by construction
    - "*.StudentRecordId"       # rule ID-2
    - "*.TenantId"              # rule ID-2 — nothing here is tenant-scoped
    - "*.mobileNumber"          # rule ID-1 — the number is a credential, held by BC-18

student_network:               # R8 — SUPPORTING (was `global_student`; BC-10 removed by ADR-0011)
  rank: 8
  may_import: [ liboora_contracts ]
  may_use_ports:
    - data.repository
    - security.crypto
    - configuration.settings
    - observability.telemetry
    - platform_services.files
    - platform_services.realtime
    - shared_core.tenant_context   # read-only; social data is NOT tenant-scoped, but requests are
    - identity.policy_decision
    - search.indexer
    - ai.assist
    - analytics.read_model
  may_emit_events: [ social.*, messaging.*, safety.* ]   # identity.Person* now belongs to person_identity
  may_consume_events: [ identity.Person*, safety.EnforcementActionTaken ]
  internal_edges_allowed: [ E-14, E-15, E-16 ]
  forbidden:
    - library_management.*      # Separate Ways — the only bridge is the ACL on E-13
    - "*.StudentRecordId"       # rule ID-2: must never receive a tenant-scoped student id
    - "*.TenantId"              # rule ID-2: social data is not tenant-scoped
```

### 6.2 Capability platforms (the L4 side)

```yaml
ai:                            # R6
  rank: 6
  may_import: [ liboora_contracts ]
  may_use_ports:
    - data.vector_store, data.repository
    - security.secrets, security.pii_redaction
    - configuration.settings, observability.telemetry
    - platform_services.cache, platform_services.rate_limiter
    - shared_core.tenant_context, identity.policy_decision
    - search.retrieval           # permission-aware retrieval ONLY
    - analytics.read_model
    - integration.model_provider # vendor abstraction
  may_command:                   # ⌘ — re-validated by the receiver
    - library_management.commands   # requires HITL approval record
    - global_student.commands       # requires HITL approval record
  may_consume_events: [ "*" ]     # AI may observe the whole event surface
  must_emit_events: [ ai.AgentRunCompleted, ai.AiActionApplied ]
  invariants_enforced_by_ci:
    - "every retrieval call passes tenantId AND actor permissions"
    - "no model call without passing through security.pii_redaction"
    - "no library_management or global_student import"

analytics:                     # R7
  rank: 7
  may_import: [ liboora_contracts ]
  may_use_ports: [ data.analytics_store, configuration.settings, observability.telemetry,
                   shared_core.tenant_context, identity.policy_decision ]
  may_consume_events: [ "*" ]
  forbidden:
    - library_management.*       # ✖ events only
    - global_student.*
    - data.oltp_repository       # must not read the transactional store
  invariants_enforced_by_ci:
    - "every projection has a documented rebuild path"
    - "no metric defined outside the semantic layer"

workflow:                      # R6
  rank: 6
  may_import: [ liboora_contracts ]
  may_use_ports: [ data.repository, configuration.settings, observability.telemetry,
                   platform_services.job_runtime, platform_services.idempotency,
                   shared_core.tenant_context, identity.policy_decision,
                   business.entitlement, integration.connector, ai.assist ]
  may_command: [ library_management.commands, global_student.commands ]
  may_consume_events: [ "*" ]
  invariants_enforced_by_ci:
    - "every saga step declares a compensating action"
    - "every process definition declares an idempotency key strategy"

audit:                         # R5
  rank: 5
  may_import: [ liboora_contracts ]
  may_consume_events: [ "*" ]
  forbidden: [ "*.update", "*.delete" ]   # append-only: no mutation path may exist in code
```

### 6.3 The shared kernel

```yaml
liboora_contracts:              # R0
  rank: 0
  may_import: [ "dart:core", "dart:async", "dart:convert", "dart:typed_data" ]
  forbidden:
    - "package:flutter/*"       # must be usable in a pure-Dart server context
    - "package:*"               # no third-party deps whatsoever
    - "dart:io"
    - "dart:ui"
  contains:
    - value_objects: [ TenantId, PersonId, AccountId, StudentRecordId, Money, DateRange,
                       BranchId, IdempotencyKey, FileRef ]
    - event_envelopes: "all domain event schemas + schemaVersion"
    - error_taxonomy: "DomainError hierarchy, error codes"
    - port_interfaces: "only ports of universal reach (TenantContext, Telemetry, Clock)"
  change_policy: "Architecture Review Board approval required. Additive only within a major version."
```

**Why `liboora_contracts` may not import Flutter:** the same event and value-object definitions must compile in a server/CLI context for the outbox publisher, migration tooling and test fixtures. One `package:flutter/material.dart` import in the shared kernel permanently couples the domain language to the UI framework.

---

## 7. Forbidden Edges

Each row is a specific edge that a reasonable engineer might add under deadline pressure. Named here so the refusal is a citation, not an opinion.

| # | Forbidden edge | Why it's tempting | Why it's fatal | Do this instead |
|---|---|---|---|---|
| **X-01** | `ANALYTICS → domain repository` | "Just query the students table for the report" | Couples read load to OLTP; makes the read model non-rebuildable; breaks extraction #4 | Consume events, build a projection |
| **X-02** | `AI → domain model classes` | "The agent needs the Student entity" | Makes AI undeployable separately and lets model changes break AI silently | Consume the event payload from `liboora_contracts` |
| **X-03** | `domain → INTEGRATION` | "Just call Razorpay from the payment service" | Vendor lock-in inside the core domain; untestable; breaks gateway abstraction | Call `business.payment_intent` port |
| **X-04** | `domain → COMMUNICATION` (sync) | "Send the SMS right after saving" | Couples a domain transaction to a third-party's availability; SMS failure rolls back a paid enrollment | Emit a fact event; Communication decides channel |
| **X-05** | `LIBRARY MANAGEMENT ↔ STUDENT NETWORK` *(`BC-11`…`BC-17`)* | "Show the student's friends on the reception screen" | Merges two tenancy models and two privacy regimes; a social outage takes down the paying product | The `PersonId` link via ACL (E-13) only. **`BC-10` is not the social side of this prohibition** — since `ADR-0011` it is a rank-7.5 platform identity that library modules may depend on downward. Depending on `BC-10` is legal; depending on `BC-11`…`BC-17` is not |
| **X-06** | `capability → API PLATFORM` | "Reuse the DTO from the API layer" | Inverts the dependency; the edge must be replaceable without touching capabilities | Define the contract in `liboora_contracts` |
| **X-07** | `any → any` bypassing EVENT for cross-context notification | "An event bus is overkill, I'll just call it" | Recreates the distributed monolith; loses replay, DLQ, audit and ordering guarantees | Use the outbox |
| **X-08** | `SEARCH → domain repository` for indexing | "Reindex by scanning the table" | Index and source silently diverge; breaks permission-aware indexing | Event-driven index + explicit `Index Backfill Job` |
| **X-09** | `domain → DateTime.now()` / `Uuid()` directly | Convenience | Untestable time-dependent invariants; attendance clock-skew bugs become unreproducible | `platform_services.time` and `id` ports |
| **X-10** | `AUDIT` with an update or delete method | "We need to fix a bad entry" | Destroys the evidentiary value of the entire audit trail | Append a correcting entry |
| **X-11** | `BC-21 Entitlement` written by anything except Billing events | "Just grant this customer the feature manually" | Entitlement stops being derivable; rebuild-from-events diverges; revenue leakage is unauditable | Emit a `billing.EntitlementChanged` override event with actor + reason |
| **X-12** | `liboora_contracts → anything` | "Just one small helper package" | Transitive backdoor around every other law | Put the helper in the consuming module |
| **X-13** | Cache/index/vector key without `tenantId` | Oversight, not intent | **Cross-tenant data leak — highest-severity failure class in the system** | Tenant-prefixed key factory; enforced by lint + Multi-Tenant Test Suite |
| **X-14** | `QUALITY → production code` in a non-test source set | Test helpers leaking into `lib/` | Ships test scaffolding and fixtures to production | Keep in `test/` or a `_test_support` dev dependency |

---

## 8. Cycle-Breaking Patterns

When a genuine bidirectional need appears, one of these four patterns applies. There is no fifth option, and "just import both ways" is never the answer.

### 8.1 Domain event inversion — for *"A must react to B and B must react to A"*

```
BEFORE (cycle):     Membership ──► Fee ──► Membership          ✖ L1 violation

AFTER:              Membership ──⚡MembershipRenewed──► [EVENT] ──► Fee
                    Fee        ──⚡FeePaymentReceived──► [EVENT] ──► Membership

Neither imports the other. Both import liboora_contracts.
```

This resolves E-07 / E-10 in the context map, which would otherwise be a cycle between BC-02 and BC-05.

### 8.2 Port inversion (callback) — for *"a low-rank module needs a high-rank decision"*

```
BEFORE:   PlatformServices.OfflineSync ──► Attendance (to resolve a conflict)   ✖ L2 violation

AFTER:    Attendance declares:      abstract class ConflictPolicy { Resolution resolve(...); }
          Attendance implements it and registers it at the composition root.
          OfflineSync depends on the interface, which lives in... 
             → liboora_contracts (if universal) or 
             → OfflineSync's own port file (if sync-specific).

Direction of dependency is now downward. The high-rank module supplies the policy;
the low-rank module executes it without knowing whose policy it is.
```

This is how E-24 works, and it is the general answer to "the framework needs to call my business rule."

### 8.3 Ambient context — for *"literally everything needs tenant and correlation id"*

`TenantContext` is needed at R2 (row-level security) and set at R9 (request edge). A downward import would violate L2.

**Resolution:** the `TenantContext` *interface* and its read-only accessor live in `liboora_contracts` (R0). The API edge *writes* it once per request via an async-scoped holder; every other rank only *reads* it. Marked `◇*` in the matrix.

**Constraints that make this safe rather than a global variable:**
- Read-only outside the edge — no setter is exported beyond the composition root.
- Reading it when unset **throws**; it never defaults to a tenant or to null.
- It is never passed as a domain method parameter (that would leak infrastructure into the domain signature).
- Async-scoped, so concurrent requests cannot observe each other's tenant.

The same pattern, and only this pattern, applies to `correlationId` and `actorId`.

### 8.4 Command port with re-validation — for *"a capability must change domain state"*

```
Workflow / AI  ──⌘──►  DomainCommandPort (declared in liboora_contracts)
                            │
                            └─► implemented by Library Management,
                                which re-validates EVERY invariant as if
                                the caller were hostile.

The capability holds no domain object, performs no validation of its own,
and receives a DomainError result it must handle. Trust is not transitive.
```

For AI specifically, this path additionally requires an `ApprovalRecord` (HITL) and produces an `ai.AiActionApplied` audit event. An AI-initiated write with no approval record is a build-breaking violation, not a runtime warning.

---

## 9. Flutter / Dart Package Layout

The rules above are only enforceable if the directory structure mirrors them. Two options were considered.

### 9.1 Chosen structure — single package, enforced folders (V1)

```
flutter_app/
├── lib/
│   ├── main.dart                       # composition root — the ONLY place adapters are wired
│   ├── bootstrap/
│   │   ├── di.dart                     # dependency injection registration
│   │   ├── env.dart
│   │   └── tenant_scope.dart           # ambient TenantContext writer (§8.3)
│   │
│   ├── contracts/                      # R0 — liboora_contracts (see 9.3 for extraction)
│   │   ├── value_objects/
│   │   ├── events/
│   │   ├── errors/
│   │   └── ports/
│   │
│   ├── platform/                       # R1–R7 capability platforms
│   │   ├── data/
│   │   ├── security/
│   │   ├── configuration/
│   │   ├── observability/
│   │   ├── services/                   # PLATFORM SERVICES
│   │   ├── event/
│   │   ├── tenancy/                    # SHARED CORE
│   │   ├── identity/
│   │   ├── audit/
│   │   ├── search/
│   │   ├── communication/
│   │   ├── integration/
│   │   ├── business/
│   │   ├── workflow/
│   │   ├── ai/
│   │   └── analytics/
│   │
│   ├── domain/                         # R8 — the two domain platforms
│   │   ├── library/
│   │   │   ├── enrollment/             # BC-01
│   │   │   ├── membership/             # BC-02
│   │   │   ├── attendance/             # BC-03
│   │   │   ├── seating/                # BC-04
│   │   │   ├── fee/                    # BC-05
│   │   │   └── policy/                 # BC-06
│   │   └── social/
│   │       ├── identity/               # BC-10
│   │       ├── graph/                  # BC-11
│   │       ├── messaging/              # BC-12
│   │       └── safety/                 # BC-13
│   │
│   └── app/                            # R9 — presentation & edge
│       ├── shell/                      # navigation, theme, role routing
│       ├── owner/  manager/  reception/  student/  parent/
│       └── shared_ui/                  # design system widgets only, no business logic
│
├── test/                               # mirrors lib/ exactly
├── tool/
│   ├── check_module_boundaries.dart    # the fitness function (§10)
│   └── module_dependencies.yaml        # machine-readable allow-list
└── docs/10-architecture/
```

### 9.2 Internal structure of every bounded context

Each context folder is internally hexagonal. This shape is mandatory and identical everywhere, so any engineer can navigate any context.

```
domain/library/attendance/
├── domain/                    # PURE. No Flutter, no packages, no IO.
│   ├── attendance_day.dart        # aggregate root
│   ├── punch.dart                 # entity
│   ├── verification_evidence.dart # value object
│   ├── attendance_errors.dart
│   └── ports/                     # interfaces this context REQUIRES
│       ├── attendance_repository.dart
│       ├── clock.dart
│       └── membership_validity_reader.dart
├── application/               # use cases / command handlers
│   ├── check_in_student.dart
│   ├── check_out_student.dart
│   └── correct_attendance.dart
├── infrastructure/            # adapters implementing the ports
│   ├── attendance_repository_impl.dart
│   └── membership_validity_reader_impl.dart
└── attendance.dart            # BARREL — the only file other modules may import
```

**The barrel file is the boundary.** A lint rule rejects any import that reaches past a barrel into `domain/`, `application/` or `infrastructure/` of another context. This is what makes "public API" a mechanical concept rather than a naming convention.

### 9.3 When to split into real packages

Folders rely on lint enforcement, which can be bypassed by disabling a rule. Real Dart packages rely on the compiler, which cannot. Split when any of these becomes true:

| Trigger | Action |
|---|---|
| Team size > 8 engineers | Extract `liboora_contracts` and `platform/*` into `packages/` with explicit `pubspec.yaml` deps |
| A boundary violation ships to production despite CI | Extract that specific boundary immediately — the lint was insufficient |
| First microservice extraction (context map §12) | The extracted context must already be a package |
| Build time > 4 minutes | Package boundaries enable incremental compilation |

**Recommendation:** extract `liboora_contracts` as a real package on **day one**, even at V1 with a small team. It is the load-bearing rule (L5), it is cheap to do at the start, and it is the most painful to retrofit.

---

## 10. Enforcement in CI

Three layers, in increasing strength.

### 10.1 Layer 1 — `analysis_options.yaml` (fast, catches the obvious)

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  language:
    strict-casts: true
    strict-raw-types: true
  errors:
    depend_on_referenced_packages: error
    implementation_imports: error        # blocks reaching into src/
    avoid_print: error                   # per environment coding standard
    unsafe_variance: error

linter:
  rules:
    - always_declare_return_types
    - avoid_dynamic_calls
    - prefer_const_constructors
    - unawaited_futures                  # silent event-publish failures are unacceptable
    - avoid_slow_async_io
```

### 10.2 Layer 2 — the boundary fitness function (`tool/check_module_boundaries.dart`)

A Dart script run in CI that parses every import in `lib/` and validates it against `module_dependencies.yaml`. Pseudocode of the checks it performs:

| Check | Rule enforced | Failure message |
|---|---|---|
| Rank comparison on every import | **L2** | `lib/platform/ai/x.dart imports domain/library/... — rank 6 may not import rank 8 (L4/X-02). See MODULE_DEPENDENCY_MATRIX §7.` |
| Cycle detection via DFS on the import graph | **L1** | `Cycle detected: fee → membership → fee. L1 has no exceptions.` |
| Barrel-only imports across contexts | §9.2 | `Import reaches past barrel into attendance/domain/. Import attendance.dart instead.` |
| `contracts/` import allow-list | **L5** | `liboora_contracts must not import package:flutter (X-12).` |
| Banned symbols in `domain/**` | **L3, X-09** | `DateTime.now() in domain code — use Clock port (X-09).` Also bans `http`, `firebase_*`, `dart:io`, `SharedPreferences`, `Hive`. |
| Banned ubiquitous-language terms in `contracts/` | Context map §5 | `Bare type name 'Student' is banned in contracts. Use StudentRecord or GlobalStudentProfile.` |
| Tenant key check | **X-13** | `Cache/index key built without tenantId — potential cross-tenant leak.` |
| Audit mutation check | **X-10** | `audit module exposes an update/delete method.` |
| AI write path check | **F-4** | `ai module invokes a domain command without an ApprovalRecord parameter.` |

```bash
# CI invocation
dart run tool/check_module_boundaries.dart --config tool/module_dependencies.yaml --strict
```

### 10.3 Layer 3 — architecture tests (`test/architecture/`)

Executable assertions that live with the code and fail like any other test:

| Test | Asserts |
|---|---|
| `no_capability_imports_domain_test.dart` | L4 across all 16 capability modules |
| `acyclic_graph_test.dart` | L1 |
| `every_aggregate_has_invariant_tests_test.dart` | Each of the 17 aggregates in context map §8 has a corresponding invariant test file |
| `every_event_has_schema_test.dart` | Each event in context map §9 exists in the registry with a `schemaVersion` |
| `every_projection_rebuildable_test.dart` | Each Analytics projection implements `rebuild()` |
| `tenant_isolation_test.dart` | Cross-tenant leak suite — queries as tenant A must never return tenant B rows, for every repository |
| `no_orphan_ports_test.dart` | Every declared port has exactly one registered implementation at the composition root |

### 10.4 Pipeline gate ordering

```
1. dart format --set-exit-if-changed .        ← fastest, fail first
2. flutter analyze                            ← Layer 1
3. dart run tool/check_module_boundaries.dart ← Layer 2  ◄── blocks merge
4. flutter test test/architecture/            ← Layer 3  ◄── blocks merge
5. flutter test                               ← unit + widget
6. flutter build web --release                ← build verification
```

Steps 3 and 4 are **required status checks** on the protected branch. A boundary violation cannot be merged with an approving review alone — it needs an ADR (§11).

---

## 11. Exception Process

| Step | Action |
|---|---|
| **1** | Attempt the four cycle-breaking patterns in §8 first. Most requested exceptions dissolve here. |
| **2** | If still needed, write an ADR in `docs/10-architecture/adr/` using `ADR-NNN-<slug>.md`. It must state: the edge requested, the law violated, why §8 patterns are insufficient, the blast radius, and **the removal plan with a date**. |
| **3** | Architecture Review Board approves or rejects. L1 (acyclic) is **never** approved. |
| **4** | On approval, add the edge to `module_dependencies.yaml` with `adr: ADR-NNN` and `expires: YYYY-MM-DD`. |
| **5** | CI fails after the expiry date if the exception still exists. Debt is time-boxed by the tooling, not by good intentions. |

```yaml
# Example approved exception in module_dependencies.yaml
exceptions:
  - from: platform/analytics
    to: platform/search
    mode: port
    reason: "Report full-text filter reuses search relevance during V1; native filter lands V2."
    adr: ADR-014
    expires: 2027-03-31
```

**Every exception carries an expiry.** This single mechanism is the difference between an architecture that degrades slowly and one that holds for ten years.

---

## 12. Summary Metrics

| Metric | Value |
|---|---|
| Platforms in runtime graph | 20 (5 are build/docs-time only) |
| Bounded contexts | 31 (23 in V1) |
| Ranks | 10 (R0–R9) |
| Allowed cross-platform edges | 26 (context map §7) |
| Named forbidden edges | 14 (§7) |
| Direct-import permissions | 1 (`liboora_contracts` only) |
| Same-rank clusters | 2 (Core Library `BC-01`…`BC-06`, Social `BC-11`…`BC-13`) |
| Cycle-breaking patterns | 4 |
| CI enforcement layers | 3 |
| Laws with zero exceptions | 1 (L1 — acyclic). `L2` retains exactly its two declared cluster exceptions — **`ADR-0011` added none**, which is why rank 7.5 exists |

**Ratio worth noting:** 26 allowed edges across 31 contexts, with exactly **one** permitted direct import. A dependency graph this sparse is what makes ten-year maintainability a structural property rather than a discipline problem.

---

## Changelog

| Version | Date | Change |
|---|---|---|
| **v1.2** | 2026-08-04 | **No rule in this document changed.** Recorded here because §10.2's fitness function was executed for the first time and this document's rules are now *enforced* rather than declared. `tool/check_module_boundaries.dart` (`IMPL-014`) implements **10 of the 12** specified enforcement categories; the **tenant-key (`X-13`)** and **audit-mutation (`X-10`)** checks are **NOT implemented** and, per `SID-4.56`, remain **unmet** — see [`BOUNDARY_CHECKER_DESIGN.md`](./BOUNDARY_CHECKER_DESIGN.md) §7. First run found 38 violations: one `L1` cycle (**fixed in code** via the §8.2 port-inversion pattern — `L1` is never waivable per §11 step 3) and 37 §4 mode violations, now governed by [`ADR-0012`](../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md) under the §11 exception process with 12 dated exceptions. §10.4 gate 3 currently **exits 1 by design** because the `app → domain/library` edge is deliberately unwaived pending `TASK-D10`. Defect `R-5` closed: the manifest's `contracts.path` pointed at `lib/contracts`, a directory that never existed, so law `L5` had been certified against an empty directory. As-built graph now documented separately in [`DEPENDENCY_GRAPH.md`](./DEPENDENCY_GRAPH.md). |
| **v1.1** | 2026-08-02 | Added rank **7.5** (`domain/person`) per [`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md), reclassifying `BC-10` Global Person Identity from `[SUPPORTING]` in the Social cluster to `[CORE]` between `platform/analytics` (7) and `domain/library` (8). Retro-recorded: this row was omitted when the change was made. |
| **v1.0** | 2026-07-30 | Initial dependency matrix. 5 laws, 10 ranks, 7 communication modes, full 20×20 matrix, per-platform allow-lists, 14 named forbidden edges, 4 cycle-breaking patterns, Flutter package layout, 3-layer CI enforcement with time-boxed exception process. |


