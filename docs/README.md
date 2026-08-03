# Liboora — Documentation

| | |
|---|---|
| **Baseline** | **BASELINE-2026-08-02** — locked |
| **Product** | Multi-tenant SaaS for libraries and study halls in India |
| **Stack** | Flutter 3.35.4 / Dart 3.9.2 (version-locked) · modular monolith |

---

## Start here

**If you are a developer about to write code:** read
[`40-implementation/DEVELOPER_HANDOFF.md`](./40-implementation/DEVELOPER_HANDOFF.md) **first**. It orients you in
about ten minutes and lists the seven things most likely to be got wrong.

**If you need to know which document to believe:**
[`00-governance/DOCUMENTATION_BASELINE.md`](./00-governance/DOCUMENTATION_BASELINE.md) §4 gives the precedence
order.

---

## Structure

```
docs/
├── 00-governance/     Baseline declaration, ADRs, the audit record
├── 10-architecture/   Bounded contexts, dependency matrix, rulings, enterprise architecture
├── 20-configuration/  The twelve configurable parameters and their operating envelope
├── 30-product/        Master PRD and module PRDs
├── 40-implementation/ Handoff, roadmap, checklists, tasks, traceability
└── 90-archive/        Superseded documents — retained for history, NOT authoritative
```

Numbering is deliberate: **lower numbers govern higher ones.** Governance constrains architecture, architecture
constrains product, product constrains implementation.

---

## 00-governance

| Document | Purpose |
|---|---|
| [`DOCUMENTATION_BASELINE.md`](./00-governance/DOCUMENTATION_BASELINE.md) | **Which documents are authoritative, at which versions, in what precedence order.** Read before resolving any disagreement |
| [`adr/ADR-INDEX.md`](./00-governance/adr/ADR-INDEX.md) | Register of architecture decisions |
| [`adr/ADR-0001`](./00-governance/adr/ADR-0001-modular-monolith.md) … [`ADR-0008`](./00-governance/adr/ADR-0008-authentication-prd-v2-baseline.md) | The eight accepted decisions. **Binding.** All are short — read all eight |
| [`DOCUMENTATION_AUDIT-001.md`](./00-governance/DOCUMENTATION_AUDIT-001.md) | The enterprise review that produced this baseline. 34 findings |

## 10-architecture

| Document | Version | Purpose |
|---|---|---|
| [`LIBOORA_BOUNDED_CONTEXT_MAP.md`](./10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) | v1.2 | 31 bounded contexts, the Identity Triad, 26 integration edges, aggregates and invariants |
| [`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](./10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) | v1.0 | Dependency laws, ranks, allow-lists, 14 forbidden edges |
| [`ARCHITECTURE_RULINGS.md`](./10-architecture/ARCHITECTURE_RULINGS.md) | v1.1 | `AR-1`…`AR-7`. Four promoted to ADRs; `AR-1`, `AR-3`, `AR-4` remain binding here |
| [`LIBOORA_ENTERPRISE_ARCHITECTURE.md`](./10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md) | v2.1 | The architecture tree. **Descriptive** — follows the PRDs, never leads them |

## 20-configuration

| Document | Purpose |
|---|---|
| [`CONFIGURATION_GUIDE.md`](./20-configuration/CONFIGURATION_GUIDE.md) | `CFG-1`…`CFG-12` — defaults, ranges, invariants, environment profiles, observability. Every default anchored to a standard or a stated analysis |

## 30-product

| Document | Version | Status |
|---|---|---|
| [`MASTER_PRD.md`](./30-product/MASTER_PRD.md) | v1.4 | **Platform-wide global rules. Outranks every module PRD** |
| [`authentication/Authentication_PRD_v2.md`](./30-product/authentication/Authentication_PRD_v2.md) | **v2.0** | **The authentication baseline.** 588 requirements, 11 chapters |
| [`authentication/prd-v2/`](./30-product/authentication/prd-v2/) | v2.0 | Chapter sources of the above |
| [`authentication/PRD-V2-GOVERNANCE-NOTE.md`](./30-product/authentication/PRD-V2-GOVERNANCE-NOTE.md) | v2.0 | Provenance. **Not part of the specification** |
| [`library/`](./30-product/library/) | Incomplete | §14A only. **§§1–25 were never supplied** |

## 40-implementation

| Document | Purpose |
|---|---|
| [`DEVELOPER_HANDOFF.md`](./40-implementation/DEVELOPER_HANDOFF.md) | **Start here.** Orientation, traps, honest state of the codebase |
| [`IMPLEMENTATION_ROADMAP.md`](./40-implementation/IMPLEMENTATION_ROADMAP.md) | Eight phases, ordered by dependency. Critical path identified |
| [`AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md`](./40-implementation/AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md) | Keep open while coding. Twelve blocks plus anti-patterns |
| [`TASK-D10-remove-demo-surfaces.md`](./40-implementation/TASK-D10-remove-demo-surfaces.md) | **P0 release blocker.** Three demo surfaces across five files |
| [`DEFINITION_OF_DONE.md`](./40-implementation/DEFINITION_OF_DONE.md) | Three gates: merge, requirement, release |
| [`TRACEABILITY_MATRIX.md`](./40-implementation/TRACEABILITY_MATRIX.md) | 1,517 identifiers mapped to tasks and status |

## 90-archive

Superseded documents. **Every file carries an ⛔ ARCHIVED banner and has no authority.**

Retained because the history of defect `D-7` — a specification referenced everywhere and present nowhere — is
worth being able to read. Several archived documents assert that the Authentication specification is missing.
**Those statements were true when written and are false now.**

---

## Current state, honestly

| | |
|---|---|
| **Authentication specification** | ✅ Complete — 588 requirements, ready to implement |
| **Library specification** | ❌ §14A only; §§1–25 never supplied |
| **Invitation security spec** | ❌ Never written (`AR-4`). Six properties unspecified. **Do not invent** |
| **`flutter analyze`** | ✅ `No issues found!` |
| **`flutter test`** | ✅ 43 passing — but they predate v2.0 and do not evidence conformance |
| **Releasable?** | ❌ **No.** `TASK-D10` — three demo surfaces violate `MP-CON-11` |
| **Module boundaries** | ⚠️ Unenforced — `tool/check_module_boundaries.dart` does not exist (`IMPL-014`) |

Full gap list with priorities: [`DEVELOPER_HANDOFF.md`](./40-implementation/DEVELOPER_HANDOFF.md) §7.

---

## Rules for this documentation

1. **A conflict is a defect.** Do not resolve it in code — report it. Precedence tells you which document is
   *wrong*.
2. **Documentation changes ship in the same commit as the code.** A stale document is how this repository came
   to need a full audit.
3. **A structural decision needs an ADR before the code**, not after.
4. **If the specification is silent, raise it — do not decide it.** A guess made under delivery pressure becomes
   a permanent undocumented rule.
5. **Never cite an archived document as authority.**
