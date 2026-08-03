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

## Architecture

Liboora is a **modular monolith** built to domain-driven boundaries. Read these
before writing code — in this order:

1. [`docs/10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md`](docs/10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md) — 25 platforms, what exists and who owns it
2. [`docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md`](docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) — 31 bounded contexts, model boundaries
3. [`docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) — what the build will refuse
4. [`tool/module_dependencies.yaml`](tool/module_dependencies.yaml) — machine-readable rules for CI

## Structure

```
packages/liboora_contracts/   R0 shared kernel — imports NOTHING
lib/platform/                R2–R7 capability platforms
lib/domain/library/          R8 core domain — 6 bounded contexts
lib/domain/social/           R8 supporting domain
lib/app/                     R9 presentation & role shells
```

## Develop

```bash
flutter pub get
flutter analyze
flutter build web --release
```

## Documentation

The full specification set lives under [`docs/`](docs/) — start at
[`docs/README.md`](docs/README.md), which gives the precedence order and reading paths.

| Baseline | `docs/00-governance/DOCUMENTATION_BASELINE.md` — `BASELINE-2026-08-03` |
|---|---|
| Master PRD | `docs/30-product/MASTER_PRD.md` v1.6 |
| Authentication PRD | `docs/30-product/authentication/` v2.0 |
| Library PRD | `docs/30-product/library/` v1.0 |
| Decisions | `docs/00-governance/adr/` — `ADR-0001` … `ADR-0010` |
| Gates | `docs/40-implementation/DEFINITION_OF_DONE.md` v1.1 |

> **Status.** The documentation set is frozen and complete. The application code is
> early: authentication is scaffolded but unverified against PRD v2.0, and Library
> Management is not implemented. See `docs/README.md` for the honest current state.
