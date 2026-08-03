# LIBOORA — Architecture Documentation

This directory holds LIBOORA's architecture documentation.

> **Precedence.** These documents are **not** the top of the authority chain. Under
> [`DOCUMENTATION_BASELINE.md`](../00-governance/DOCUMENTATION_BASELINE.md) §4 the order is: Master PRD global
> rules → Accepted ADRs → Authentication PRD v2.0 → Bounded Context Map and Dependency Matrix → Architecture
> Rulings → **Enterprise Architecture (descriptive only)** → Configuration Guide.
>
> The Enterprise Architecture document **follows** the PRDs. Where it disagrees with one, the EA is wrong and is
> corrected — never the reverse. Five such conflicts were found and fixed in EA v2.1.

## Documents

| Document | Version | Purpose |
|---|---|---|
| [`LIBOORA_ENTERPRISE_ARCHITECTURE.md`](./LIBOORA_ENTERPRISE_ARCHITECTURE.md) | `v2.1` | Master architecture: full review, duplicate resolution matrix, principle validation, audit scores, and the complete 25-platform architecture tree |
| [`LIBOORA_BOUNDED_CONTEXT_MAP.md`](./LIBOORA_BOUNDED_CONTEXT_MAP.md) | `v1.2` | DDD model boundaries: 31 bounded contexts, the Identity Triad, ubiquitous-language collisions, 26 integration edges, 17 aggregates with invariants, V1 event surface, extraction order |
| [`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](./LIBOORA_MODULE_DEPENDENCY_MATRIX.md) | `v1.0` | Enforceable code boundaries: 5 dependency laws, 10 ranks, the full dependency matrix, per-platform allow-lists, 14 forbidden edges, cycle-breaking patterns, 3-layer CI enforcement |
| [`../../tool/module_dependencies.yaml`](../../tool/module_dependencies.yaml) | `v1` | **Machine-readable** normative rules. ⚠ Its consumer `tool/check_module_boundaries.dart` **does not exist** — see Open action items |
| [`ARCHITECTURE_RULINGS.md`](./ARCHITECTURE_RULINGS.md) | `v1.1` | Approved rulings `AR-1`…`AR-7`. **Four are promoted to ADRs** (`AR-2`→`ADR-0005`, `AR-5`→`ADR-0006`, `AR-6`→`ADR-0004`, `AR-7`→`ADR-0007`). `AR-1`, `AR-3`, `AR-4` remain here and are binding |
| [`../00-governance/adr/ADR-INDEX.md`](../00-governance/adr/ADR-INDEX.md) | Active | **The register of record for architecture decisions.** `ADR-0001`…`ADR-0008` |

### Designations

| Governance role | Designated document | Ruling |
|---|---|---|
| **Architecture decisions** | [`../00-governance/adr/`](../00-governance/adr/) | **The ADR set now exists.** Governance task `R-3` is closed. `ARCHITECTURE_RULINGS.md` is no longer the interim register; it is retained for `AR-1`, `AR-3`, `AR-4`, which stay binding. |
| **System Architecture** | [`LIBOORA_ENTERPRISE_ARCHITECTURE.md`](./LIBOORA_ENTERPRISE_ARCHITECTURE.md) | **R-1**, ruled by the product owner. This document **is** the project's authoritative System Architecture for all architecture validation, traceability, implementation review and consistency checking. No separately-named "System Architecture" file exists, and none is required. The absence of one is **not** a blocker. |

### Reading order

**Tree** (what exists, who owns it) → **Context Map** (where the model boundaries are) → **Dependency Matrix** (what the compiler will refuse) → **YAML** (what CI checks).

## How to use this

- **Before adding any module** → check the *Duplicate Resolution Matrix* (§3) and the *Single Owner Rule* (§10.1). If the capability already has an owner, extend the owner — do not create a sibling.
- **Before starting a feature** → confirm its version tag (V1/V2/V3/Future) in the tree. V1 = launch-critical only.
- **Before naming a class** → check *Ubiquitous Language Collisions* (Context Map §5). `Student`, `Member`, `Payment`, `Plan`, `Invoice`, `Attendance`, `Session`, `Role` and `Library` are all ambiguous and have binding resolutions.
- **Before adding an import across modules** → check the matrix (§5) and the allow-lists (§6). Default is **deny**.
- **Before modelling a person** → read the *Identity Triad* (Context Map §4). `AccountId` ≠ `PersonId` ≠ `StudentRecordId`. Getting this wrong makes multi-library membership unimplementable.
- **Before changing structure** → follow the *Change Process* (§10.5): raise an ADR, verify ownership, bump the version header. Record it in [`../00-governance/adr/`](../00-governance/adr/) — the ADR set now exists and is the register of record.
- **Before adding a product surface** → check whether it is a **context** or a **composition**. Dashboards, the Parent Portal and Library Discovery & Enrollment (`AR-1`) are compositions: they own no aggregate and no invariant.
- **Multi-tenant work** → the six *Multi-Tenant Invariants* (§10.2) plus forbidden edge **X-13** (tenant-less cache/index keys) are non-negotiable.

## Open action items

1. **Diff the `[RECONSTRUCTED]` sections** against the canonical `v1.0` tree and merge any pre-existing nodes:
   `INTEGRATION PLATFORM` · `SECURITY PLATFORM` · `DEVOPS PLATFORM` · `QUALITY PLATFORM` · `INFRASTRUCTURE` · `PLATFORM SERVICES` (tail) · `DATA PLATFORM` (storage nodes) · `FUTURE ECOSYSTEM` (existing nodes)
2. ~~Produce the Bounded Context Map~~ — **done**, `LIBOORA_BOUNDED_CONTEXT_MAP.md` v1.2
3. ~~Produce the Module Dependency Matrix~~ — **done**, `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` v1.0 + `tool/module_dependencies.yaml`
3b. ~~Produce a formal ADR set (governance task `R-3`)~~ — **done**, [`../00-governance/adr/`](../00-governance/adr/), `ADR-0001`…`ADR-0008`
4. **Define the V1 Event Catalog** — Context Map §9 fixes the 30 V1 event *names, producers and consumers*. Still required: payload schemas, `schemaVersion` registry entries, and partition keys.
5. **Implement `tool/check_module_boundaries.dart`** — the fitness function specified in Dependency Matrix §10.2. **It does not exist.** Until it does, the boundaries are documentation, not enforcement. Tracked as **`IMPL-014`, priority P1**, in [`../40-implementation/IMPLEMENTATION_ROADMAP.md`](../40-implementation/IMPLEMENTATION_ROADMAP.md) §3.
6. **Resolve the 7 open questions** in Context Map §13 as ADRs before the V1 implementation freeze. **Q-02 (`branchId` in the V1 schema) is the most urgent** — retrofitting it is a migration across every tenant-scoped table.
7. **Extract `liboora_contracts` as a real Dart package** on day one (Dependency Matrix §9.3) — cheapest now, most painful later.

## Conventions

Version tag semantics, naming conventions and ownership rules are defined in
§10 *Governing Rules & Conventions* of the master document. Read that section before contributing.
