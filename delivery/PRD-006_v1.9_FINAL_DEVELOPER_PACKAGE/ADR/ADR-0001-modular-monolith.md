# ADR-0001 — Modular monolith with a pure-Dart shared kernel

| Field | Value |
|---|---|
| **Status** | Accepted |
| **Date** | 2026-08-02 (records a decision taken at project inception) |
| **Deciders** | Principal Enterprise Architect, product owner |
| **Scope** | Whole platform |

## Context

Liboora is a multi-tenant SaaS platform for Indian libraries and study halls, built by a small team at
startup scale. The architecture must support 31 bounded contexts, 23 of them in V1, without incurring
the operational cost of 23 deployable services.

Two failure modes were considered. Microservices from day one would impose network boundaries,
distributed transactions, service discovery and independent deployment pipelines on a team that cannot
staff them — the classic distributed monolith. A conventional monolith with no internal boundaries would
allow arbitrary coupling, making later extraction impossible precisely when growth demands it.

## Decision

Build a **modular monolith** with compile-time-enforced module boundaries and a **pure-Dart shared
kernel** (`packages/liboora_contracts`) holding value objects, ports, domain events and the error
taxonomy.

Module boundaries are enforced by three mechanisms: a ten-rank dependency ordering, a per-module
allow-list, and fourteen explicitly forbidden edges (`X-01`…`X-14`). The shared kernel depends on
nothing but Dart itself — no Flutter, no platform, no module.

## Consequences

**Positive.** Boundaries are real and checkable rather than aspirational. A module can be extracted to a
service later by replacing its in-process port with a network adapter, with no change to its callers. A
single deployable artefact keeps operational cost at startup scale. The shared kernel being Flutter-free
means domain logic is testable without a widget harness.

**Negative.** Discipline must be enforced continuously or it decays. The enforcement tool
(`tool/check_module_boundaries.dart`) specified in Dependency Matrix §10.2 **does not yet exist**, so
today the boundaries are documentation rather than enforcement. This is tracked as `IMPL-014` and is a
genuine risk: every day it does not exist, violations can accumulate silently.

**Neutral.** In-process calls between modules are permitted where the dependency matrix allows them, so
the latency profile is that of a monolith, not a distributed system.

## Alternatives considered

| Alternative | Rejected because |
|---|---|
| Microservices from day one | Operational cost unaffordable at current team size; boundaries not yet stable enough to freeze into network contracts |
| Unstructured monolith | No mechanism to prevent coupling; extraction becomes impossible exactly when it becomes necessary |
| Shared kernel depending on Flutter | Would make every domain test require a widget harness and would prevent server-side reuse |

## References

`docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` · `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` · `tool/module_dependencies.yaml`
