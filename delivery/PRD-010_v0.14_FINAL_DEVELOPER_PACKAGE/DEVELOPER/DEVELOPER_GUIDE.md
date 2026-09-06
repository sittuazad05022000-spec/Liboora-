# Liboora — Developer Guide

| Field | Value |
|---|---|
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
| **Audience** | Engineers writing code in this repository |
| **Scope** | **How the system is built.** For process — branching, commits, review — see [`CONTRIBUTING.md`](./CONTRIBUTING.md) |
| **Relationship to `docs/`** | This guide is a **practical entry point**, not a specification. Where it and a document under `docs/` disagree, **`docs/` governs** |

**Read [`docs/40-implementation/DEVELOPER_HANDOFF.md`](./docs/40-implementation/DEVELOPER_HANDOFF.md) first.** It
orients you in about ten minutes and lists the mistakes most often made in authentication and Library Management.
This guide assumes you have.

---

## 1. Project architecture

Liboora is a **modular monolith**: one deployable, internally partitioned along domain-driven boundaries and
enforced by tooling. Not microservices — but not a ball of mud either, and the difference is mechanically checked.

### 1.1 Two facts that shape most decisions

1. **Tenant isolation is absolute.** One deployment serves many independent libraries. Data belonging to one must
   never be reachable from another. A tenant-less query on tenant data is **blocker severity**.
2. **There are no passwords.** Mobile number plus one-time code is the sole V1 factor. Not hashed, not optional, not
   "for admins." None.

### 1.2 Ranked layers

Every module has a **dependency rank**. Code may depend only on **strictly lower** ranks.

| Rank | Layer | Contents |
|---|---|---|
| **0** | `packages/liboora_contracts` | Shared kernel — identifiers, value objects, ports. **Imports nothing** |
| **1–7** | `lib/platform/**` | Capability platforms: infrastructure, data, security, configuration, observability, services, event, tenancy, identity, audit, search, communication, integration, business, workflow, ai, analytics |
| **7.5** | `lib/domain/person` | **Global Person Identity — a CORE bounded context** |
| **8** | `lib/domain/library`, `lib/domain/social` | Domain: enrollment, membership, attendance, seating, finance; social |
| **9** | `lib/app` | Presentation and role shells |

The authoritative rank table is [`tool/module_dependencies.yaml`](./tool/module_dependencies.yaml) — machine-readable
and read directly by the checker. The as-built graph is
[`docs/10-architecture/DEPENDENCY_GRAPH.md`](./docs/10-architecture/DEPENDENCY_GRAPH.md).

### 1.3 Why rank 7.5 exists

Person identity is **global and platform-owned**, but Library domain contexts must consume it. It therefore sits
above every capability platform and below every domain module. `7.5` parses as a float and orders correctly without
renumbering twenty-one other modules.

Do **not** add further fractional ranks casually — each one makes the scheme harder to reason about. See `RSK-08`.

### 1.4 The identity triad

Confusing these three is the single most expensive mistake available in this codebase.

| Identity | ID type | Owner | Scope |
|---|---|---|---|
| **Account** | `AccountId` | `BC-18` Identity & Access (rank 4) | Global — **credentials only** |
| **Person** | `PersonId` | `BC-10` Global Person Identity (rank 7.5) | Global — **1:1 mandatory** with Account |
| **Student Record** | `StudentRecordId` | `BC-01` Enrollment (rank 8) | **Per-tenant** — three libraries means three records |

One human enrolled at three libraries has **one** Account, **one** Person, and **three** Student Records.

`PersonId` is **never** supplied by a caller (`SID-3.5`). Identity is created in the **same transaction** as the
Account (`SID-4.11`). `StudentRecord.personId` is **non-nullable** (`SID-4.17`).

Authoritative: [`docs/30-product/student-identity/Student_Identity_PRD_v1.md`](./docs/30-product/student-identity/Student_Identity_PRD_v1.md)
and [`docs/00-governance/adr/ADR-0011-global-person-identity.md`](./docs/00-governance/adr/ADR-0011-global-person-identity.md).

---

## 2. Module boundaries

### 2.1 The five dependency laws

| Law | Rule | Waivable? |
|---|---|---|
| **L1** | **Acyclic.** No import cycles | **Never.** No exception has been approved and none will be |
| **L2** | **Downward only.** Depend on strictly lower ranks. Same-rank is forbidden outside a declared cluster | By ADR, time-boxed |
| **L3** | Domain depends only on ports it declares | By ADR, time-boxed |
| **L4** | A capability never depends on a domain | By ADR, time-boxed |
| **L5** | **Contracts import nothing.** `liboora_contracts` has an empty `dependencies:` block — the compiler enforces this, not a lint | No |

### 2.2 Communication modes

The default mode is **port (`◇`)** unless a document says otherwise:

> Consumer declares an interface; provider implements it; DI wires it at the composition root. **Consumer imports no
> provider code.**

So **a compile-time import of another module is not permitted by default.** Only `liboora_contracts` may be imported
directly. This is why 37 findings existed before the boundary checker was built — they were genuine, not noise.

### 2.3 The pattern to copy: a rank-0 port

The hardest constraint in the system: `AuthService` (rank 4) must create a Person identity (rank 7.5) synchronously
in the same transaction. A rank-4 module cannot import rank 7.5 — that inverts `L2`.

Resolution, with **no law waived**:

```
packages/liboora_contracts (rank 0)
  abstract interface PersonIdentityFactory      ◄── declared here
        ▲                          ▲
        │ implements               │ depends on the interface
        │                          │
lib/domain/person (7.5)      lib/platform/identity (4)
  PersonIdentityService        AuthService
        ▲                          ▲
        └──────────┬───────────────┘
                   │ both bound at the composition root
            lib/bootstrap/di.dart (rank 9)
```

The interface lives **below both** parties. Rank 4 depends on rank 0; rank 7.5 depends on rank 0; only the
composition root knows both concretes. **When you need to cross a boundary, copy this pattern.**

### 2.4 Four cycle-breaking patterns — and there is no fifth

From Dependency Matrix §8: domain event inversion · **port inversion (callback)** · ambient context · command port
with re-validation. If none fits, you need an ADR — not a creative workaround.

### 2.5 Ownership rules

| Rule | Detail |
|---|---|
| Identity belongs to the **platform**, not to Social | Social must not store copies of identity fields (`SID-BR-11`) |
| Student Management **consumes** identity, never owns it | |
| Membership, Attendance, Seating and Finance stay keyed on `StudentRecordId` | **Never** re-keyed on `PersonId` (`SID-4.23`) |
| A module must not be *capable* of answering a question outside its context | Person cannot answer "which libraries does this person attend?" (`SID-4.19`) — not merely "does not", **cannot** |

---

## 3. Folder organisation

```
packages/liboora_contracts/     Rank 0 — shared kernel, imports nothing
  lib/src/value_objects/          Identifiers, value types
  lib/src/ports/                  Interfaces implemented by higher ranks
  lib/liboora_contracts.dart      Public barrel — the one legal direct import

lib/
  platform/                     Ranks 1–7 — capability platforms
    data/ security/ configuration/ observability/ services/
    event/ tenancy/ identity/ audit/ business/ analytics/
  domain/
    person/                     Rank 7.5 — Global Person Identity [CORE]
    library/                    Rank 8 — 6 bounded contexts
      enrollment/domain/          Aggregates, entities, value objects
    social/                     Rank 8 — supporting
  app/                          Rank 9 — presentation
    shell/ dashboards/ widgets/
  bootstrap/                    Composition root — DI and seeding
  main.dart                     Entry point

test/
  architecture/                 Governance tests — gate 4, blocks merge
  *_conformance_test.dart       Requirement conformance
  widget_test.dart

tool/
  check_module_boundaries.dart   IMPL-014 — the boundary checker
  module_dependencies.yaml       Machine-readable rules; the checker reads this

docs/                           Specifications — see docs/README.md
```

**Placement rule:** a file's directory determines its rank, and its rank determines what it may import. If a file
seems to need an illegal import, it is usually in the wrong directory — or needs a port (§2.3).

---

## 4. Coding standards

Baseline is `flutter_lints` via `analysis_options.yaml`. `flutter analyze` must report **No issues found**.

| Standard | Rule |
|---|---|
| **No `print`** | Use `debugPrint` guarded by `kDebugMode`, or `dart:developer` `log` |
| **No `withOpacity`** | Deprecated. Use `withValues(alpha: …)` |
| **Immutability by default** | `final` fields; `const` constructors where possible |
| **Non-nullable by default** | A nullable type must be justified. `?` is a claim that absence is meaningful |
| **No `!` without proof** | Prefer explicit handling. Null assertion on external data is a latent crash |
| **`required` over defaults** | For domain constructors — a silent default hides a missing decision |
| **Format before commit** | `dart format .` |
| **No TODOs in shipped code** | Track the work; do not leave a marker |

> **Formatting and lints interact.** Reformatting can *expose* a lint that an over-long line was hiding — this
> happened during the Student Identity migration. Always run `dart format` **then** `flutter analyze`, in that order.

---

## 5. Naming conventions

| Element | Convention | Example |
|---|---|---|
| Files, directories | `snake_case` | `student_record.dart` |
| Classes, enums, typedefs | `UpperCamelCase` | `PersonIdentityService` |
| Members, variables | `lowerCamelCase` | `studentRecordId` |
| Constants | `lowerCamelCase` | `maxSeatHoldMinutes` |
| Private | Leading underscore | `_resolveTenant` |
| Interfaces / ports | Role name, **no `I` prefix** | `PersonIdentityFactory` |
| Implementations | Concrete name — **not** `…Impl` | `HivePersonRepository` |
| Test names | The rule as a sentence | `'a seat cannot be double-booked'` |

**Domain names come from the specification.** If the PRD says *Student Record*, the class is `StudentRecord` — not
`Student`, not `Learner`. Requirement IDs are permanent addresses; the ubiquitous language is too.

---

## 6. Dependency rules

### 6.1 Adding a package

Adding a dependency is an architectural decision.

| Requirement | Detail |
|---|---|
| **Web-compatible** | Check the Platforms tab on pub.dev. Web preview must keep working |
| **Version-pinned** | Exact versions for governance-relevant tooling (e.g. `yaml: 3.1.3`) so results are reproducible |
| **Compatible with the lock** | Flutter 3.35.4 / Dart 3.9.2. **Never** upgrade the SDK to satisfy a package |
| **Placed at the right rank** | A domain module must not import an infrastructure package directly — wrap it behind a port |
| **Never in contracts** | `liboora_contracts` keeps an empty `dependencies:` block (`L5`) |

### 6.2 Direction, and how to check it

Dependencies point **downward**, from higher rank to lower. Before you push:

```bash
dart run tool/check_module_boundaries.dart
```

**Exit codes:** `0` clean · `1` violations found · `2` the configuration itself is unusable — a missing ADR
reference, an unparseable expiry, an unknown module. The checker **halts rather than passing** when it cannot
understand its own rules: it fails closed, like the rest of the system.

Gate 3 currently exits `1` **by design** — see `CONTRIBUTING.md` §4.1. Your change must not add findings.

---

## 7. Error handling

| Rule | Detail |
|---|---|
| **Fail closed** | On ambiguity, deny. An unknown tenant, an unparseable policy, a missing claim — refuse |
| **Invariants throw** | A domain invariant violation is not a return value. Throw a domain-specific error |
| **Never swallow** | `catch (_) {}` is prohibited. If recovery is genuine, comment why |
| **Translate at boundaries** | Infrastructure errors do not leak upward as-is. Map to domain meaning |
| **User-facing messages must help** | Show a real message and a retry path. A silent failure looks identical to a bug |
| **Refusals stay indistinguishable** | Authentication and claim refusals must not reveal whether an account exists (`AUTH-4.32`) |
| **Errors are specific** | `SeatAlreadyOccupied`, not `Exception('error')` — a test asserting a generic throw passes for the wrong reason |

### 7.1 The false green

A test asserting *"this throws"* passes if the code throws for an **unrelated** reason. Assert the **specific**
error type, and confirm a new negative test fails for the intended reason before trusting it.

---

## 8. Logging

| Rule | Detail |
|---|---|
| **Never `print`** | `debugPrint` under `kDebugMode`, or `dart:developer` `log` with a `name:` |
| **Never log a secret** | No OTP, no session token, no full mobile number. Ever |
| **Minimise personal data** | Never log identity fields next to identifiers |
| **Include tenant context** | For tenant-scoped operations, but never another tenant's data |
| **Audit is not logging** | Audit records are domain facts, immutable, written through the audit platform |
| **Logs are not a substitute for tests** | A log tells you it broke afterwards; a test stops it |

---

## 9. Documentation workflow

**Documentation is the source of truth. Code conforms to it.**

| Step | Action |
|---|---|
| 1 | Read the requirement. Cite its ID in the commit |
| 2 | Implement to the specification. If the spec seems wrong, **stop** — that is an ADR, not an implementation choice |
| 3 | Update status in [`docs/40-implementation/IMPLEMENTATION_STATUS.md`](./docs/40-implementation/IMPLEMENTATION_STATUS.md) — the authoritative record |
| 4 | Record structural changes in [`docs/10-architecture/ARCHITECTURE_CHANGELOG.md`](./docs/10-architecture/ARCHITECTURE_CHANGELOG.md) with a version row |
| 5 | Add a user-visible entry to [`CHANGELOG.md`](./CHANGELOG.md) |
| 6 | **Same commit.** Documentation updated later was wrong in between |

**Never** rewrite a frozen PRD, edit an accepted ADR, renumber a requirement ID, or edit `docs/90-archive/`. See
`CONTRIBUTING.md` §6.

---

## 10. Git workflow

```bash
git checkout main && git pull                    # start current
git checkout -b feat/TASK-123-short-description

dart format .                                   # gates, in order
flutter analyze
dart run tool/check_module_boundaries.dart       # compare findings to baseline
flutter test test/architecture/
flutter test

git add -p                                       # review your own diff
git commit                                       # Conventional Commits + Refs:
git push -u origin feat/TASK-123-short-description
```

| Rule | Detail |
|---|---|
| **Never force-push `main`** | If the remote moved, rebase or merge. Unrelated history is preserved, never overwritten |
| **Measure before pushing** | `git rev-list --count origin/main..HEAD` and the reverse. A fast-forward needs no rewrite |
| **Verify a push independently** | `git push` exit 0 is the pushing side's own claim. Confirm with `git ls-remote`, which does not cache |
| **Rebase, don't merge `main` in** | Keeps history readable |
| **Small commits, real messages** | Each commit should build |

---

## 11. Where to look when stuck

| Question | Document |
|---|---|
| What is this product? | [`docs/40-implementation/DEVELOPER_HANDOFF.md`](./docs/40-implementation/DEVELOPER_HANDOFF.md) |
| Which document wins? | `docs/00-governance/DOCUMENTATION_BASELINE.md` §4 |
| What may depend on what? | [`docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](./docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) |
| What does the graph look like now? | [`docs/10-architecture/DEPENDENCY_GRAPH.md`](./docs/10-architecture/DEPENDENCY_GRAPH.md) |
| Where are the model boundaries? | [`docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md`](./docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) |
| Why is the boundary gate red? | [`docs/40-implementation/IMPLEMENTATION_STATUS.md`](./docs/40-implementation/IMPLEMENTATION_STATUS.md) §4 |
| How does the checker work? | [`docs/10-architecture/BOUNDARY_CHECKER_DESIGN.md`](./docs/10-architecture/BOUNDARY_CHECKER_DESIGN.md) |
| What is actually implemented? | `IMPLEMENTATION_STATUS.md` — **not** the roadmap, which describes intent |
| Why was this decided? | `docs/00-governance/adr/` — `ADR-0001` … `ADR-0012` |

**A closing note.** Two specified checks — `X-13` tenant-key and `X-10` audit-mutation — are **not implemented**.
Per `SID-4.56`, *a rule that cannot be checked SHALL be treated as unmet*: they are recorded as unmet, not assumed
satisfied. If you rely on either, know that only review stands behind it today.

---

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created. Architecture, module boundaries and the five laws, folder organisation, coding standards, naming, dependency rules, error handling, logging, documentation workflow and Git workflow |
