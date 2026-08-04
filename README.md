# Liboora

**Liboora – Smart Library Operating System**

Multi-tenant library & study-hall management platform.

Student enrollment · memberships · QR attendance · seat allocation · fee collection,
with role-based dashboards for **Owner**, **Manager**, **Reception**, **Student** and **Parent**.

| | |
|---|---|
| **App name** | Liboora |
| **Android package** | `com.liboora.app` |
| **Dart package** | `liboora` |
| **Flutter** | 3.35.4 (locked) |
| **Dart** | 3.9.2 (locked) |
| **License** | [MIT](./LICENSE) |

---

## Project overview

Liboora is a **multi-tenant SaaS platform for libraries and study halls in India.** One deployment serves many
independent library organisations: an owner, managers and reception staff run their venue; students and parents use
it.

Two facts shape almost every technical decision in this repository:

1. **Tenant isolation is absolute.** Data belonging to one library must never be reachable from another. A
   tenant-less query on tenant data is a **blocker-severity** defect, not a bug to schedule.
2. **Authentication is a mobile number and a one-time code.** There are no passwords anywhere — not hashed, not
   optional, not "for admins." None.

## Vision

Indian libraries and study halls are largely run on paper registers, WhatsApp and cash. Liboora replaces that with
one system that a reception desk can operate during a queue: enrol a student in under a minute, take attendance by
QR, allocate a seat without double-booking it, and collect fees with a record that survives an audit.

The long-term aim is a platform where a library's operational reality — seats, shifts, dues, attendance — is
accurate enough to be trusted for decisions, and where a student carries **one identity** across every library they
attend rather than being re-registered at each.

---

## Current status — read this before judging the code

| Area | State |
|---|---|
| **Documentation** | Mature. `BASELINE-2026-08-04`, 89 documents, 12 accepted ADRs |
| **Architecture** | Defined and now **mechanically enforced** — `tool/check_module_boundaries.dart` |
| **Authentication** | Scaffolded; Account created on first successful OTP. Not fully verified against PRD v2.0 |
| **Student Identity** | Architecture migrated into code (`ADR-0011`); identity is mandatory and platform-owned |
| **Library Management** | Specified, largely **not implemented** |
| **Persistence** | In-memory. A real schema migration is still owed |
| **Boundary gate** | **Exits 1 by design** — see [Testing](#testing-commands) |

Authoritative status lives in
[`docs/40-implementation/IMPLEMENTATION_STATUS.md`](./docs/40-implementation/IMPLEMENTATION_STATUS.md). Where any
other document disagrees about what is implemented, that one wins.

---

## Architecture overview

Liboora is a **modular monolith**: one deployable, internally partitioned along domain-driven boundaries, with the
boundaries enforced by tooling rather than by good intentions.

Every module has a **dependency rank** and may depend only on **strictly lower** ranks.

| Rank | Layer | Contents |
|---|---|---|
| **0** | `packages/liboora_contracts` | Shared kernel — identifiers, value objects, ports. **Imports nothing** |
| **1–7** | `lib/platform/**` | Capability platforms — data, security, tenancy, identity, event, audit, business, analytics, … |
| **7.5** | `lib/domain/person` | **Global Person Identity — a CORE bounded context** |
| **8** | `lib/domain/library`, `lib/domain/social` | Domain — enrollment, membership, attendance, seating, finance; social |
| **9** | `lib/app` | Presentation and role shells |

### The five dependency laws

| Law | Rule |
|---|---|
| **L1** | **Acyclic.** No import cycles — **never waivable** |
| **L2** | **Downward only.** Strictly lower ranks; same-rank forbidden outside a declared cluster |
| **L3** | Domain depends only on ports it declares |
| **L4** | A capability never depends on a domain |
| **L5** | **Contracts import nothing** — enforced by the compiler, via an empty `dependencies:` block |

The default communication mode is a **port**: the consumer declares an interface, the provider implements it, and DI
wires it at the composition root. A direct compile-time import of another module is **not** permitted — only
`liboora_contracts` may be imported directly.

### The identity triad

Confusing these three is the most expensive mistake available in this codebase.

| Identity | ID type | Owner | Scope |
|---|---|---|---|
| **Account** | `AccountId` | `BC-18` Identity & Access (rank 4) | Global — credentials only |
| **Person** | `PersonId` | `BC-10` Global Person Identity (rank 7.5) | Global — **1:1 mandatory** with Account |
| **Student Record** | `StudentRecordId` | `BC-01` Enrollment (rank 8) | **Per-tenant** |

One human enrolled at three libraries has **one** Account, **one** Person, and **three** Student Records.

Read these before writing code, in this order:

1. [`docs/10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md`](docs/10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md) — 25 platforms, what exists and who owns it
2. [`docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md`](docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) — 31 bounded contexts, model boundaries
3. [`docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) — what the build will refuse
4. [`docs/10-architecture/DEPENDENCY_GRAPH.md`](docs/10-architecture/DEPENDENCY_GRAPH.md) — the graph **as built**, including current debt
5. [`tool/module_dependencies.yaml`](tool/module_dependencies.yaml) — machine-readable rules, read directly by CI

---

## Repository structure

```
packages/liboora_contracts/   Rank 0 shared kernel — imports NOTHING
lib/
  platform/                   Ranks 1–7 capability platforms
  domain/person/              Rank 7.5 Global Person Identity [CORE]
  domain/library/             Rank 8 core domain — 6 bounded contexts
  domain/social/              Rank 8 supporting domain
  app/                        Rank 9 presentation & role shells
  bootstrap/                  Composition root — DI and seeding
test/
  architecture/               Governance tests — blocks merge
tool/
  check_module_boundaries.dart  IMPL-014 boundary checker
  module_dependencies.yaml      Machine-readable dependency rules
docs/                         Specifications — see docs/README.md
```

### Folder structure in detail

| Path | Rank | Rule |
|---|---|---|
| `packages/liboora_contracts/lib/src/value_objects/` | 0 | Identifiers and value types |
| `packages/liboora_contracts/lib/src/ports/` | 0 | Interfaces implemented by higher ranks |
| `lib/platform/<capability>/` | 1–7 | One directory per capability platform |
| `lib/domain/person/` | 7.5 | Global identity — platform-owned, never Social-owned |
| `lib/domain/library/<context>/domain/` | 8 | Aggregates, entities, value objects per bounded context |
| `lib/app/{shell,dashboards,widgets}/` | 9 | Presentation only — no business rules |
| `lib/bootstrap/` | 9 | The **only** place that knows concrete implementations |

**A file's directory determines its rank, and its rank determines what it may import.** If a file seems to need an
illegal import, it is usually in the wrong directory — or needs a port.

---

## Documentation index

The full specification set lives under [`docs/`](docs/) — start at [`docs/README.md`](docs/README.md), which gives
the precedence order and reading paths. Numbering is deliberate: **lower numbers govern higher ones.**

| Directory | Contents | Files |
|---|---|---|
| [`docs/00-governance/`](docs/00-governance/) | Baseline declaration, ADRs, audit record | 15 |
| [`docs/10-architecture/`](docs/10-architecture/) | Bounded contexts, dependency matrix, graph, rulings | 8 |
| [`docs/20-configuration/`](docs/20-configuration/) | The 35 configurable parameters and their envelope | 1 |
| [`docs/30-product/`](docs/30-product/) | Master PRD and module PRDs | 26 |
| [`docs/40-implementation/`](docs/40-implementation/) | Handoff, roadmap, checklists, tasks, traceability | 16 |
| [`docs/90-archive/`](docs/90-archive/) | Superseded — retained for history, **not authoritative** | 22 |

**Key documents:**

| Document | Purpose |
|---|---|
| [`docs/40-implementation/DEVELOPER_HANDOFF.md`](docs/40-implementation/DEVELOPER_HANDOFF.md) | **Read first.** Orients you in ten minutes |
| `docs/00-governance/DOCUMENTATION_BASELINE.md` | Which document wins — precedence order, §4 |
| [`docs/40-implementation/IMPLEMENTATION_STATUS.md`](docs/40-implementation/IMPLEMENTATION_STATUS.md) | **Authoritative** implementation status |
| [`docs/10-architecture/BOUNDARY_CHECKER_DESIGN.md`](docs/10-architecture/BOUNDARY_CHECKER_DESIGN.md) | How enforcement works |
| [`docs/10-architecture/ARCHITECTURE_CHANGELOG.md`](docs/10-architecture/ARCHITECTURE_CHANGELOG.md) | Structural change history |
| [`docs/40-implementation/TRACEABILITY_MATRIX.md`](docs/40-implementation/TRACEABILITY_MATRIX.md) | Requirement → implementation coverage |

### PRD index

| PRD | Version | Location |
|---|---|---|
| **Master PRD** | v1.7 | [`docs/30-product/MASTER_PRD.md`](docs/30-product/MASTER_PRD.md) |
| **Authentication** | v2.0 | [`docs/30-product/authentication/`](docs/30-product/authentication/) — 11 chapters |
| **Library** | v1.0 | [`docs/30-product/library/`](docs/30-product/library/) |
| **Student Identity & Profile** | v1.0 | [`docs/30-product/student-identity/Student_Identity_PRD_v1.md`](docs/30-product/student-identity/Student_Identity_PRD_v1.md) — 226 requirement IDs |
| **Decisions** | `ADR-0001` … `ADR-0012` | [`docs/00-governance/adr/`](docs/00-governance/adr/) |
| **Gates** | v1.2 | [`docs/40-implementation/DEFINITION_OF_DONE.md`](docs/40-implementation/DEFINITION_OF_DONE.md) |

> **PRDs are frozen.** Do not rewrite, reword or renumber them. Requirement IDs such as `SID-4.11` and `AUTH-4.23`
> are permanent addresses cited across the repository. A product change goes through the ADR process.

---

## Setup instructions

**Prerequisites:** Flutter **3.35.4** and Dart **3.9.2** — both version-locked. Do not upgrade the SDK to satisfy a
package; pick a compatible package instead.

```bash
git clone https://github.com/sittuazad05022000-spec/Liboora-.git
cd Liboora-

flutter pub get                                 # resolve dependencies
flutter test                                    # expect 71 passing
dart run tool/check_module_boundaries.dart       # expect exit 1 — see Testing
flutter build web --release                      # build for preview
```

To preview locally:

```bash
flutter build web --release
python3 -m http.server 5060 --directory build/web --bind 0.0.0.0
```

---

## Tech stack

| Layer | Choice | Version | Why |
|---|---|---|---|
| **Framework** | Flutter | 3.35.4 (locked) | One codebase for Android and web preview |
| **Language** | Dart | 3.9.2 (locked) | Sound null safety carries domain invariants into the type system |
| **Shared kernel** | `liboora_contracts` | path package | A real package, so the **compiler** enforces law `L5` |
| **State management** | `provider` | 6.1.5+1 | Sufficient; no code generation |
| **Local persistence** | `hive` · `hive_flutter` | 2.2.3 · 1.1.0 | Document store for complex objects |
| **Preferences** | `shared_preferences` | 2.5.3 | Key-value settings |
| **Governance tooling** | `yaml` | 3.1.3 (exact) | Read by the boundary checker; pinned for reproducibility |
| **Lints** | `flutter_lints` | ^5.0.0 | Baseline standards |

Every dependency must support **web**, since web preview is the primary demonstration path.

---

## Development workflow

1. Read the requirement and note its ID.
2. Branch from `main` — see [Branch strategy](#branch-strategy).
3. Implement to the specification. **If the specification seems wrong, stop** — that is an ADR, not an
   implementation choice.
4. Add falsifiable tests.
5. Run the gates in order (below).
6. Update documentation **in the same commit**.
7. Open a PR with gate evidence.

Full process: [`CONTRIBUTING.md`](./CONTRIBUTING.md). Technical conventions: [`DEVELOPER_GUIDE.md`](./DEVELOPER_GUIDE.md).

### Branch strategy

`main` is the single long-lived branch and is always releasable-in-principle. There are no release branches yet.

```
<type>/<short-description>
<type>/<TASK-ID>-<short-description>
```

`feat/` · `fix/` · `refactor/` · `docs/` · `test/` · `chore/` · `arch/`

**Never force-push `main`.** If the remote has moved, rebase or merge — unrelated history is preserved, never
overwritten.

### Coding standards

| Standard | Rule |
|---|---|
| **No `print`** | `debugPrint` under `kDebugMode`, or `dart:developer` `log` |
| **No `withOpacity`** | Deprecated — use `withValues(alpha: …)` |
| **Immutable by default** | `final` fields, `const` constructors |
| **Non-nullable by default** | `?` is a claim that absence is meaningful — justify it |
| **Fail closed** | On ambiguity, deny |
| **No TODOs in shipped code** | Track the work instead |
| **`dart format` before commit** | Then `flutter analyze` — reformatting can expose a masked lint |

### Contribution process

1. Read [`CONTRIBUTING.md`](./CONTRIBUTING.md) and [`CODE_OF_CONDUCT.md`](./CODE_OF_CONDUCT.md).
2. Branch, implement, test, document.
3. Run all gates; **findings must not increase**.
4. Open a PR: what, **why**, governance IDs, gate output.
5. One approval minimum; architecture changes need an architecture owner.
6. Rebase rather than merging `main` in.

Vulnerabilities follow [`SECURITY.md`](./SECURITY.md) — **never** a public issue.

---

## Build commands

```bash
flutter pub get                      # resolve dependencies
dart format .                        # format
flutter analyze                      # static analysis — expect "No issues found!"
flutter build web --release           # web build
flutter build apk --release           # Android APK
flutter build appbundle --release     # Play Store bundle
```

## Testing commands

Run the gates **in this order** — an earlier gate feeds the later one:

```bash
dart format .                                  # 1
flutter analyze                                # 2
dart run tool/check_module_boundaries.dart     # 3 ◄ blocks merge
flutter test test/architecture/                # 4 ◄ blocks merge
flutter test                                   # 5 — expect 71 passing
flutter build web --release                     # 6
```

> ### Gate 3 exits 1 on purpose — do not "fix" it
>
> The boundary checker currently reports **9 violations** (`app → domain/library`) and **28 acknowledged debt
> findings** across 12 edges. The 9 are deliberately **not** waived: they live in demo surfaces that `TASK-D10`
> deletes, and waiving them would create an exception for code already scheduled for removal.
>
> The baseline before enforcement existed was **38 violations in 2 categories**. Your change must **not add
> findings**. Do not add a manifest exception to make this green — see
> [`ADR-0012`](docs/00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md) and
> [`IMPLEMENTATION_STATUS.md`](docs/40-implementation/IMPLEMENTATION_STATUS.md) §4.

**Exit codes:** `0` clean · `1` violations · `2` the configuration itself is unusable (missing ADR, unparseable
expiry, unknown module). The checker **halts rather than passing** when it cannot understand its own rules.

---

## Future modules

Specified or planned, not yet implemented. Ordering follows
[`docs/40-implementation/IMPLEMENTATION_ROADMAP.md`](docs/40-implementation/IMPLEMENTATION_ROADMAP.md).

| Module | State | Notes |
|---|---|---|
| **Library Management** | Specified, not implemented | 6 bounded contexts — enrollment, membership, attendance, seating, finance, reception |
| **SMS / DLT integration** | `IMPL-020`, **P0** | Real OTP delivery. Currently stubbed |
| **`SID-INT-*` enforcement** | `IMPL-220`, unblocked | Extends the checker to the twelve Student Identity integration rules |
| **`X-13` tenant-key check** | **Not implemented** | Per `SID-4.56`, recorded as **unmet**. Should precede any persistent datastore |
| **`X-10` audit-mutation check** | **Not implemented** | Recorded as **unmet** |
| **Persistent datastore** | Deferred | In-memory today; a real schema migration is owed |
| **Parent portal** | Specified | Role shell exists |
| **Reporting & analytics** | Platform exists at rank 7 | Projections only |
| **Search** | Platform declared at rank 5 | Not built |
| **Demo-surface removal** | `TASK-D10`, **P0 release blocker** | Also clears the 9 remaining gate-3 findings |

---

## Project documents

| Document | Purpose |
|---|---|
| [`CONTRIBUTING.md`](./CONTRIBUTING.md) | Branching, commits, PRs, review, testing requirements |
| [`DEVELOPER_GUIDE.md`](./DEVELOPER_GUIDE.md) | Architecture, boundaries, naming, error handling, logging |
| [`CHANGELOG.md`](./CHANGELOG.md) | Product and repository history |
| [`SECURITY.md`](./SECURITY.md) | Vulnerability reporting, secrets, authentication rules |
| [`CODE_OF_CONDUCT.md`](./CODE_OF_CONDUCT.md) | Community and technical conduct |
| [`LICENSE`](./LICENSE) | MIT |

---

## License

MIT — see [`LICENSE`](./LICENSE).

> **A closing note on honesty.** This README states that a gate is red, that two specified checks are unimplemented,
> and that Library Management is not built. That is deliberate. Per `SID-4.56` — *a rule that cannot be checked SHALL
> be treated as unmet* — an unverified claim is a defect in the shared record, and a reader who discovers a red gate
> unaided will assume it is broken and silence it.
