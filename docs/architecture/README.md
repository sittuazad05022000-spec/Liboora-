# LIBORA — Architecture Documentation

This directory is the **source of truth** for LIBORA's enterprise architecture.

## Documents

| Document | Version | Purpose |
|---|---|---|
| [`LIBORA_ENTERPRISE_ARCHITECTURE.md`](./LIBORA_ENTERPRISE_ARCHITECTURE.md) | `v2.0` | Master architecture: full review, duplicate resolution matrix, principle validation, audit scores, and the complete 25-platform architecture tree |

## How to use this

- **Before adding any module** → check the *Duplicate Resolution Matrix* (§3) and the *Single Owner Rule* (§10.1). If the capability already has an owner, extend the owner — do not create a sibling.
- **Before starting a feature** → confirm its version tag (V1/V2/V3/Future) in the tree. V1 = launch-critical only.
- **Before changing structure** → follow the *Change Process* (§10.5): raise an ADR, verify ownership, bump the version header.
- **Multi-tenant work** → the six *Multi-Tenant Invariants* (§10.2) are non-negotiable.

## Open action items

1. **Diff the `[RECONSTRUCTED]` sections** against the canonical `v1.0` tree and merge any pre-existing nodes:
   `INTEGRATION PLATFORM` · `SECURITY PLATFORM` · `DEVOPS PLATFORM` · `QUALITY PLATFORM` · `INFRASTRUCTURE` · `PLATFORM SERVICES` (tail) · `DATA PLATFORM` (storage nodes) · `FUTURE ECOSYSTEM` (existing nodes)
2. **Produce the Bounded Context Map** — turns the tree into DDD context boundaries.
3. **Produce the Module Dependency Matrix** — makes §10.1 machine-enforceable via lint rules.
4. **Define the V1 Event Catalog** — the concrete first set of domain events for the Event Platform.

## Conventions

Version tag semantics, naming conventions and ownership rules are defined in
§10 *Governing Rules & Conventions* of the master document. Read that section before contributing.
