# Changelog

All notable changes to Liboora are recorded here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the project aims to follow
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## Scope of this file — and what belongs elsewhere

This changelog records **product and repository history**. Three other logs exist deliberately, because collapsing
them loses information:

| Log | Records | When to use it |
|---|---|---|
| **`CHANGELOG.md`** (this file) | Product and repository changes, release-facing | A user, operator or integrator would notice |
| [`docs/10-architecture/ARCHITECTURE_CHANGELOG.md`](./docs/10-architecture/ARCHITECTURE_CHANGELOG.md) | **Structural** change: contexts, ownership, ranks, boundaries, enforcement | The shape of the system changed |
| [`docs/40-implementation/MIGRATION_LOG.md`](./docs/40-implementation/MIGRATION_LOG.md) | Migration execution — the gap between a decision and its landing | Code was moved to match a decision |
| `docs/00-governance/adr/` | **Why** a decision was made | Always, for a structural decision |

A structural change with no ADR is a defect, not an entry.

**No release has been tagged.** The project is pre-release: the documentation set is mature, the application code is
early. Entries below are grouped by date under `Unreleased` and reflect actual commits.

---

## [Unreleased]

### 2026-08-04 — Student Identity architecture migrated into code

#### Added

- **Global Person Identity as a core bounded context** (`BC-10`) at dependency rank **7.5** — `lib/domain/person/`.
  One Account maps to exactly one Person identity, created in the **same transaction** (`SID-4.11`).
- **`PersonIdentityFactory`** port in the rank-0 shared kernel
  (`packages/liboora_contracts/lib/src/ports/person_identity_factory.dart`), implemented by `PersonIdentityService`
  at rank 7.5 and bound at the composition root. This lets rank-4 identity create a rank-7.5 identity synchronously
  **without waiving any dependency law**.
- **`IMPL-014` architecture boundary checker** — `tool/check_module_boundaries.dart`, enforcing ten categories:
  dependency ranks, cross-context rules, forbidden dependencies, circular dependencies, same-rank violations, layer
  violations, illegal imports, ownership, boundary and architecture policy. Wired as pipeline gate 3; **fails CI on
  violation**.
- **14 governance tests** (`test/architecture/boundary_checker_test.dart`) covering the checker's own correctness —
  including that an exception missing its ADR halts it, an unparseable expiry halts it, and a self-edge exception
  cannot waive a real cycle.
- **14 Student Identity conformance tests** (`test/student_identity_conformance_test.dart`).
- **`ADR-0011`** Global Person Identity · **`ADR-0012`** V1 scaffold port-inversion debt, time-boxed with 12 dated
  exceptions across 4 removal waves.
- Documentation: Architecture Migration Report, Boundary Checker Design, Migration Checklist, Dependency Graph,
  Implementation Completion Report, Validation Report, Risk Report, Migration Log, Architecture Changelog,
  Implementation Status.

#### Changed

- **`Account.personId` is now non-nullable.** Identity creation is mandatory, not optional.
- **`StudentRecord.personId` is now non-nullable** (`SID-4.17`).
- **`GlobalStudentProfile` moved out of Social** into the Identity bounded context. Identity belongs to the
  platform; Social consumes it and stores no copies of identity fields (`SID-BR-11`).
- Repositories, services, aggregates, dependency injection, fixtures and seed data updated to the mandatory-identity
  model.
- `tool/module_dependencies.yaml` now lists all 22 modules with ranks and is **read by the checker** — previously it
  described rules nothing enforced.
- Dependency Matrix **v1.2**; Bounded Context Map **v1.4**; ADR index **12 accepted**.

#### Fixed

- **An import cycle in the composition root** (`lib/bootstrap/di.dart`), repaired in code by port inversion —
  law `L1` is never waivable, so no exception was sought.
- **Manifest defect `R-5`**: the dependency manifest referenced a `lib/contracts` path that never existed.
- **Ten stale status statements** across seven documents claiming the boundary checker did not exist. Superseded by a
  single authoritative record, `IMPLEMENTATION_STATUS.md`, rather than by rewriting frozen review artefacts.
- **A mis-citation in the migration plan**: the account-claim flow was attributed to edge `E-11` (which is
  *`AccountId` resolution on login*). Corrected to `AUTH-4.23`…`AUTH-4.28`.
- A lint in the boundary checker exposed by reformatting, where an over-long line had masked
  `curly_braces_in_flow_control_structures`.
- **Two changelog rows never written**: rank 7.5 in the Dependency Matrix and the `ADR-0011` amendments in the
  Context Map. Retro-added and labelled as such.

#### Known issues

- **Pipeline gate 3 exits 1 by design.** Nine `app → domain/library` findings are deliberately **not** waived: they
  live in demo surfaces that `TASK-D10` deletes, and waiving them would create an exception for code already
  scheduled for removal. Baseline before this work was 38 violations in 2 categories.
- **`X-13` tenant-key and `X-10` audit-mutation checks are not implemented.** Per `SID-4.56` — *a rule that cannot be
  checked SHALL be treated as unmet* — both are recorded as unmet, not assumed satisfied.
- Persistence is in-memory; a real schema migration is still owed.

### 2026-08-04 — Student Identity specification

#### Added

- **Student Identity & Profile PRD v1.0** — `docs/30-product/student-identity/Student_Identity_PRD_v1.md`,
  1,439 lines, 226 requirement IDs, five chapters plus document control.
- Student Identity alignment and reconciliation record.

### 2026-08-03 — Library specification and repository history

#### Added

- **Library PRD v1.0** review closeout: module baseline frozen, `U-4` and `AR-4` closed.
- **Invitation security specification** (`ADR-0009`) — all six required properties.
- Enterprise architecture review: production-ready developer documentation pack.
- **Authentication PRD v2.0** — complete eleven-chapter specification.

#### Changed

- Unrelated GitHub repository history **merged** into the local documentation history. Deliberately merged, **not**
  force-overwritten: 22 commits preserved on both sides.

### 2026-08-02 — Authentication specification and account creation

#### Added

- Authentication module completion package: architecture, implementation and verification.
- Architectural rulings `AR-1`…`AR-7`; `ACN-001` and `ACR-002` raised; `IVR-001` validated.
- **Master PRD v1.1**, aligned to Enterprise Architecture v2.0.
- `LIBOORA_ENTERPRISE_ARCHITECTURE.md` designated the authoritative System Architecture (`R-1`).
- Library PRD §14A captured verbatim.

#### Changed

- **An Account is created on first successful OTP**; session issuance split from account creation.

#### Fixed

- `IVR-001` §6.2 and `RK-5` corrections on `widget_test.dart`.

### 2026-08-01 — Authentication v1.0 lock

#### Added

- `D-7` custody shell: eleven chapter transfer slots, index and report shell.

#### Fixed

- All **14 `GATE-1` blockers** cleared for v1.0 lock.

### 2026-07-31 — Scaffold

#### Added

- **Liboora modular monolith scaffold**: 6 bounded contexts, 8 capability platforms, a running app shell.

#### Fixed

- App name corrected to **Liboora** (double `o`); Android package `com.liboora.app`.

### 2026-07-30 — Architecture baseline

#### Added

- **Enterprise Architecture v2.0** master document.
- **Bounded Context Map v1.0** and **Module Dependency Matrix v1.0**.

---

## Conventions for this file

| Rule | Detail |
|---|---|
| **Newest first** | Both sections and entries |
| **Group by type** | `Added` · `Changed` · `Deprecated` · `Removed` · `Fixed` · `Security` · `Known issues` |
| **Write for the reader, not the committer** | Describe the effect, not the diff |
| **Cite governance IDs** | `SID-4.11`, `ADR-0011`, `AUTH-4.23` — they are permanent addresses |
| **Record known issues honestly** | A deliberately red gate belongs here. A reader who discovers it themselves will assume it is broken and "fix" it |
| **Update in the same commit** | A changelog written later is a changelog that was wrong in between |

Add a `Security` section for any change with security impact, and follow [`SECURITY.md`](./SECURITY.md) for
vulnerabilities — **never** describe an unfixed vulnerability here.

---

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Initialised from the current repository state — 26 commits from 2026-07-30 to 2026-08-04. Scope boundaries against the architecture changelog and migration log stated explicitly |
