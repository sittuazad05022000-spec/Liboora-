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
| [`LIBOORA_BOUNDED_CONTEXT_MAP.md`](./LIBOORA_BOUNDED_CONTEXT_MAP.md) | `v1.3` | DDD model boundaries: 31 bounded contexts, the Identity Triad, ubiquitous-language collisions, 26 integration edges, 17 aggregates with invariants, V1 event surface, extraction order. **§4 Identity Triad amended by `ADR-0011`** — `BC-10` is `1:1` with the account, `[CORE]`, rank 7.5; `ID-4`'s `PersonId` is now non-nullable |
| [`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](./LIBOORA_MODULE_DEPENDENCY_MATRIX.md) | `v1.1` | Enforceable code boundaries: 5 dependency laws, **11 ranks** (`R7.5` added by `ADR-0011`), the full dependency matrix, per-platform allow-lists, 14 forbidden edges, cycle-breaking patterns, 3-layer CI enforcement |
| [`../../tool/module_dependencies.yaml`](../../tool/module_dependencies.yaml) | `v1` | **Machine-readable** normative rules, including the `domain/person: 7.5` tier. ✅ **Its consumer `tool/check_module_boundaries.dart` now EXISTS and runs** as Dependency Matrix §10.4 gate 3 (`IMPL-014`, implemented 2026-08-04). ✅ It now also **matches the code**: `GlobalStudentProfile` was relocated to `lib/domain/person/` as `PersonIdentity` in commit `a22fd7e`, and the checker reports **0 findings** naming `domain/person`. Defect `R-5` closed — `contracts.path` had pointed at `lib/contracts`, which never existed. See [`../40-implementation/IMPLEMENTATION_STATUS.md`](../40-implementation/IMPLEMENTATION_STATUS.md) |
| [`ARCHITECTURE_RULINGS.md`](./ARCHITECTURE_RULINGS.md) | `v1.2` | Approved rulings `AR-1`…`AR-7`. **Four are promoted to ADRs** (`AR-2`→`ADR-0005`, `AR-5`→`ADR-0006`, `AR-6`→`ADR-0004`, `AR-7`→`ADR-0007`). `AR-1`, `AR-3`, `AR-4` remain here and are binding. The `AR-4` invitation-security deferral is **lifted** — see `ADR-0009` |
| [`../00-governance/adr/ADR-INDEX.md`](../00-governance/adr/ADR-INDEX.md) | Active | **The register of record for architecture decisions.** `ADR-0001`…**`ADR-0011`** |

### Designations

| Governance role | Designated document | Ruling |
|---|---|---|
| **Architecture decisions** | [`../00-governance/adr/`](../00-governance/adr/) | **The ADR set now exists.** Governance task `R-3` is closed. `ARCHITECTURE_RULINGS.md` is no longer the interim register; it is retained for `AR-1`, `AR-3`, `AR-4`, which stay binding. `AR-3` and `AR-4` each now have a companion ADR — `ADR-0010` and `ADR-0009` — recording the *mechanism* the ruling implied, without restating or re-scoping the ruling itself. |
| **System Architecture** | [`LIBOORA_ENTERPRISE_ARCHITECTURE.md`](./LIBOORA_ENTERPRISE_ARCHITECTURE.md) | **R-1**, ruled by the product owner. This document **is** the project's authoritative System Architecture for all architecture validation, traceability, implementation review and consistency checking. No separately-named "System Architecture" file exists, and none is required. The absence of one is **not** a blocker. |

### Reading order

**Tree** (what exists, who owns it) → **Context Map** (where the model boundaries are) → **Dependency Matrix** (what the compiler will refuse) → **YAML** (what CI checks).

## How to use this

- **Before adding any module** → check the *Duplicate Resolution Matrix* (§3) and the *Single Owner Rule* (§10.1). If the capability already has an owner, extend the owner — do not create a sibling.
- **Before starting a feature** → confirm its version tag (V1/V2/V3/Future) in the tree. V1 = launch-critical only.
- **Before naming a class** → check *Ubiquitous Language Collisions* (Context Map §5). `Student`, `Member`, `Payment`, `Plan`, `Invoice`, `Attendance`, `Session`, `Role` and `Library` are all ambiguous and have binding resolutions.
- **Before adding an import across modules** → check the matrix (§5) and the allow-lists (§6). Default is **deny**.
- **Before modelling a person** → read the *Identity Triad* (Context Map §4) **and `ADR-0011`**. `AccountId` ≠ `PersonId` ≠ `StudentRecordId`. Getting this wrong makes multi-library membership unimplementable. Two things changed on 2026-08-04 and older code still reflects the old model: **`PersonId` is now mandatory and `1:1` with `AccountId`**, created in the same transaction, and the `PersonId` held by a Student Record is **non-nullable**. `PersonId` is *not* a social-product identifier — `BC-10` is `[CORE]` and ships whether or not the social product ever does.
- **Before assuming the three-way split can be collapsed** → read `ID-5`. Account erasure anonymises the Person but **must not** delete Student Record financial or attendance history. That single rule is why `StudentRecordId` survives a decision that made the other two `1:1`, and why Membership, Attendance, Seating and Finance must never be re-keyed on `PersonId` (`SID-4.23`).
- **Before changing structure** → follow the *Change Process* (§10.5): raise an ADR, verify ownership, bump the version header. Record it in [`../00-governance/adr/`](../00-governance/adr/) — the ADR set now exists and is the register of record.
- **Before adding a product surface** → check whether it is a **context** or a **composition**. Dashboards, the Parent Portal and Library Discovery & Enrollment (`AR-1`) are compositions: they own no aggregate and no invariant.
- **Multi-tenant work** → the six *Multi-Tenant Invariants* (§10.2) plus forbidden edge **X-13** (tenant-less cache/index keys) are non-negotiable.

## Open action items

1. **Diff the `[RECONSTRUCTED]` sections** against the canonical `v1.0` tree and merge any pre-existing nodes:
   `INTEGRATION PLATFORM` · `SECURITY PLATFORM` · `DEVOPS PLATFORM` · `QUALITY PLATFORM` · `INFRASTRUCTURE` · `PLATFORM SERVICES` (tail) · `DATA PLATFORM` (storage nodes) · `FUTURE ECOSYSTEM` (existing nodes)
2. ~~Produce the Bounded Context Map~~ — **done**, `LIBOORA_BOUNDED_CONTEXT_MAP.md` v1.4
3. ~~Produce the Module Dependency Matrix~~ — **done**, `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` v1.2 + `tool/module_dependencies.yaml`, now **enforced** by `tool/check_module_boundaries.dart`. As-built graph: [`DEPENDENCY_GRAPH.md`](./DEPENDENCY_GRAPH.md)
3b. ~~Produce a formal ADR set (governance task `R-3`)~~ — **done**, [`../00-governance/adr/`](../00-governance/adr/), `ADR-0001`…`ADR-0012`
3c. ~~Write the invitation security specification deferred by `AR-4`~~ — **done 2026-08-03**, [`../30-product/library/INVITATION_SECURITY_SPECIFICATION.md`](../30-product/library/INVITATION_SECURITY_SPECIFICATION.md) + `ADR-0009`. All six deferred properties — expiry, revocation, single use, entropy, validation, audit logging — are specified. The deferral said *"do not invent"*; it was lifted only after Library PRD §§1–25 arrived and confirmed which invitation forms actually exist.
4. **Define the V1 Event Catalog** — Context Map §9 fixes the 30 V1 event *names, producers and consumers*. Still required: payload schemas, `schemaVersion` registry entries, and partition keys.
5. ~~**Implement `tool/check_module_boundaries.dart`**~~ — **done 2026-08-04**, `IMPL-014`. 1 054 lines implementing **10 of the 12** categories specified in Dependency Matrix §10.2, wired as §10.4 gate 3 and verified by 14 tests of its own. First run found **38 violations**: one `L1` cycle (**fixed in code** — `L1` is never waivable) and 37 §4 mode violations, now governed by [`../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md`](../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md) under 12 **dated** §11 exceptions. The rank-7.5 banned-symbol rules are enforced and **clean**: 0 findings name `domain/person`. ⚠ **Two specified checks remain unimplemented** — tenant-key (`X-13`) and audit-mutation (`X-10`) — and by `SID-4.56` they are therefore **unmet**; ten green categories must not be read as full coverage. ⚠ Gate 3 currently **exits 1 by design**: nine `app -> domain/library` findings are deliberately unwaived because `TASK-D10` (P0) already owns them. See [`BOUNDARY_CHECKER_DESIGN.md`](./BOUNDARY_CHECKER_DESIGN.md) and [`DEPENDENCY_GRAPH.md`](./DEPENDENCY_GRAPH.md).
6. **Resolve the remaining open questions** in Context Map §13 as ADRs before the V1 implementation freeze. **Q-02 (`branchId` in the V1 schema) is the most urgent** — retrofitting it is a migration across every tenant-scoped table. `Q-02` is now **answered in the Library PRD** (`LIB-9.4`, task `IMPL-100`): model `branchId` from the first migration, default one branch, multi-branch ships in **V3**. It still needs promoting to an ADR. ~~`Q-05` (is Global Student available to a person with no enrollment?)~~ — **closed 2026-08-04 by `ADR-0011`**: yes, necessarily; the identity exists from account creation, so the question can no longer arise. The recommendation recorded against it — *"yes, but with a reduced trust tier until enrolled"* — was **not adopted**, because a trust tier is an authorisation concern owned by `BC-18` and evaluating one inside `BC-10` would violate `X-13`.
7. **Extract `liboora_contracts` as a real Dart package** on day one (Dependency Matrix §9.3) — cheapest now, most painful later.

## Conventions

Version tag semantics, naming conventions and ownership rules are defined in
§10 *Governing Rules & Conventions* of the master document. Read that section before contributing.
