# Liboora

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

1. [`docs/architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md`](docs/architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md) — 25 platforms, what exists and who owns it
2. [`docs/architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md`](docs/architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) — 31 bounded contexts, model boundaries
3. [`docs/architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](docs/architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) — what the build will refuse
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
