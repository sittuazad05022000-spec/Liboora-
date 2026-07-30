# LIBORA — Architecture Documentation

This directory is the **source of truth** for LIBORA's enterprise architecture.

## Documents

| Document | Version | Purpose |
|---|---|---|
| [`LIBORA_ENTERPRISE_ARCHITECTURE.md`](./LIBORA_ENTERPRISE_ARCHITECTURE.md) | `v2.0` | Master architecture: full review, duplicate resolution matrix, principle validation, audit scores, and the complete 25-platform architecture tree |
| [`LIBORA_BOUNDED_CONTEXT_MAP.md`](./LIBORA_BOUNDED_CONTEXT_MAP.md) | `v1.0` | DDD model boundaries: 31 bounded contexts, the Identity Triad, ubiquitous-language collisions, 26 integration edges, 17 aggregates with invariants, V1 event surface, extraction order |
| [`LIBORA_MODULE_DEPENDENCY_MATRIX.md`](./LIBORA_MODULE_DEPENDENCY_MATRIX.md) | `v1.0` | Enforceable code boundaries: 5 dependency laws, 10 ranks, the full dependency matrix, per-platform allow-lists, 14 forbidden edges, cycle-breaking patterns, 3-layer CI enforcement |
| [`../../tool/module_dependencies.yaml`](../../tool/module_dependencies.yaml) | `v1` | **Machine-readable** normative rules consumed by `tool/check_module_boundaries.dart` in CI |

### Reading order

**Tree** (what exists, who owns it) → **Context Map** (where the model boundaries are) → **Dependency Matrix** (what the compiler will refuse) → **YAML** (what CI checks).

## How to use this

- **Before adding any module** → check the *Duplicate Resolution Matrix* (§3) and the *Single Owner Rule* (§10.1). If the capability already has an owner, extend the owner — do not create a sibling.
- **Before starting a feature** → confirm its version tag (V1/V2/V3/Future) in the tree. V1 = launch-critical only.
- **Before naming a class** → check *Ubiquitous Language Collisions* (Context Map §5). `Student`, `Member`, `Payment`, `Plan`, `Invoice`, `Attendance`, `Session`, `Role` and `Library` are all ambiguous and have binding resolutions.
- **Before adding an import across modules** → check the matrix (§5) and the allow-lists (§6). Default is **deny**.
- **Before modelling a person** → read the *Identity Triad* (Context Map §4). `AccountId` ≠ `PersonId` ≠ `StudentRecordId`. Getting this wrong makes multi-library membership unimplementable.
- **Before changing structure** → follow the *Change Process* (§10.5): raise an ADR, verify ownership, bump the version header.
- **Multi-tenant work** → the six *Multi-Tenant Invariants* (§10.2) plus forbidden edge **X-13** (tenant-less cache/index keys) are non-negotiable.

## Open action items

1. **Diff the `[RECONSTRUCTED]` sections** against the canonical `v1.0` tree and merge any pre-existing nodes:
   `INTEGRATION PLATFORM` · `SECURITY PLATFORM` · `DEVOPS PLATFORM` · `QUALITY PLATFORM` · `INFRASTRUCTURE` · `PLATFORM SERVICES` (tail) · `DATA PLATFORM` (storage nodes) · `FUTURE ECOSYSTEM` (existing nodes)
2. ~~Produce the Bounded Context Map~~ — **done**, `LIBORA_BOUNDED_CONTEXT_MAP.md` v1.0
3. ~~Produce the Module Dependency Matrix~~ — **done**, `LIBORA_MODULE_DEPENDENCY_MATRIX.md` v1.0 + `tool/module_dependencies.yaml`
4. **Define the V1 Event Catalog** — Context Map §9 fixes the 30 V1 event *names, producers and consumers*. Still required: payload schemas, `schemaVersion` registry entries, and partition keys.
5. **Implement `tool/check_module_boundaries.dart`** — the fitness function specified in Dependency Matrix §10.2. Until it exists, the boundaries are documentation, not enforcement.
6. **Resolve the 7 open questions** in Context Map §13 as ADRs before the V1 implementation freeze. **Q-02 (`branchId` in the V1 schema) is the most urgent** — retrofitting it is a migration across every tenant-scoped table.
7. **Extract `libora_contracts` as a real Dart package** on day one (Dependency Matrix §9.3) — cheapest now, most painful later.

## Conventions

Version tag semantics, naming conventions and ownership rules are defined in
§10 *Governing Rules & Conventions* of the master document. Read that section before contributing.
