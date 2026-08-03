# Liboora — Documentation

| | |
|---|---|
| **Baseline** | **BASELINE-2026-08-03** — locked |
| **Product** | Multi-tenant SaaS for libraries and study halls in India |
| **Stack** | Flutter 3.35.4 / Dart 3.9.2 (version-locked) · modular monolith |

---

## Start here

**If you are a developer about to write code:** read
[`40-implementation/DEVELOPER_HANDOFF.md`](./40-implementation/DEVELOPER_HANDOFF.md) **first**. It orients you in
about ten minutes and lists the seven things most likely to be got wrong in authentication (§4) and the four most
likely to be got wrong in Library Management (§4A).

**If you need to know which document to believe:**
[`00-governance/DOCUMENTATION_BASELINE.md`](./00-governance/DOCUMENTATION_BASELINE.md) §4 gives the precedence
order.

---

## Structure

```
docs/
├── 00-governance/     Baseline declaration, ADRs, the audit record
├── 10-architecture/   Bounded contexts, dependency matrix, rulings, enterprise architecture
├── 20-configuration/  The thirty-five configurable parameters and their operating envelope
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
| [`adr/ADR-0001`](./00-governance/adr/ADR-0001-modular-monolith.md) … [`ADR-0010`](./00-governance/adr/ADR-0010-public-preview-anonymous-access.md) | The **ten** accepted decisions. **Binding.** All are short — read all ten |
| [`DOCUMENTATION_AUDIT-001.md`](./00-governance/DOCUMENTATION_AUDIT-001.md) | The enterprise review that produced this baseline. 34 findings, plus the Library second pass (§6B) |

## 10-architecture

| Document | Version | Purpose |
|---|---|---|
| [`LIBOORA_BOUNDED_CONTEXT_MAP.md`](./10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) | v1.2 | 31 bounded contexts, the Identity Triad, 26 integration edges, aggregates and invariants |
| [`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](./10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) | v1.0 | Dependency laws, ranks, allow-lists, 14 forbidden edges |
| [`ARCHITECTURE_RULINGS.md`](./10-architecture/ARCHITECTURE_RULINGS.md) | **v1.2** | `AR-1`…`AR-7`. Four promoted to ADRs; `AR-1`, `AR-3`, `AR-4` remain binding here. The `AR-4` invitation-security deferral is **lifted** |
| [`LIBOORA_ENTERPRISE_ARCHITECTURE.md`](./10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md) | v2.1 | The architecture tree. **Descriptive** — follows the PRDs, never leads them |

## 20-configuration

| Document | Purpose |
|---|---|
| [`CONFIGURATION_GUIDE.md`](./20-configuration/CONFIGURATION_GUIDE.md) | `CFG-1`…`CFG-12` · `LCFG-1`…`LCFG-13` · `ICFG-1`…`ICFG-10` — defaults, ranges, invariants `INV-1`…`INV-16`, environment profiles, observability. Every default anchored to a standard or a stated analysis |

## 30-product

| Document | Version | Status |
|---|---|---|
| [`MASTER_PRD.md`](./30-product/MASTER_PRD.md) | **v1.6** | **Platform-wide global rules. Outranks every module PRD** |
| [`authentication/Authentication_PRD_v2.md`](./30-product/authentication/Authentication_PRD_v2.md) | **v2.0** | **The authentication baseline.** 588 requirements, 11 chapters |
| [`authentication/prd-v2/`](./30-product/authentication/prd-v2/) | v2.0 | Chapter sources of the above |
| [`authentication/PRD-V2-GOVERNANCE-NOTE.md`](./30-product/authentication/PRD-V2-GOVERNANCE-NOTE.md) | v2.0 | Provenance. **Not part of the specification** |
| [`library/Library_PRD_v1.md`](./30-product/library/Library_PRD_v1.md) | **v1.0** | **The Library baseline.** §§1–25, ~130 requirements |
| [`library/14A-Library-Discovery-And-Enrollment.md`](./30-product/library/14A-Library-Discovery-And-Enrollment.md) | v1.0 | Discovery, enrollment, **the public field allow-list** |
| [`library/14B-Public-Library-Preview.md`](./30-product/library/14B-Public-Library-Preview.md) | **v1.0** | Anonymous preview, protected operations `PO-1`…`PO-12`, intent preservation |
| [`library/INVITATION_SECURITY_SPECIFICATION.md`](./30-product/library/INVITATION_SECURITY_SPECIFICATION.md) | **v1.0** | 71 requirements. Entropy, expiry, revocation, single use, validation, audit, rate limiting |
| [`library/LIBRARY_PRD_ALIGNMENT.md`](./30-product/library/LIBRARY_PRD_ALIGNMENT.md) | v1.0 | Validation record. **Not part of the specification** |

**"The Library PRD" means the first four rows together**, never one alone. Most of its security-relevant constraints
are cross-references between them.

## 40-implementation

| Document | Purpose |
|---|---|
| [`DEVELOPER_HANDOFF.md`](./40-implementation/DEVELOPER_HANDOFF.md) | **Start here.** Orientation, traps, honest state of the codebase |
| [`IMPLEMENTATION_ROADMAP.md`](./40-implementation/IMPLEMENTATION_ROADMAP.md) | Eight phases, ordered by dependency. Critical path identified |
| [`AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md`](./40-implementation/AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md) | Keep open while coding. Twelve blocks plus anti-patterns |
| [`TASK-D10-remove-demo-surfaces.md`](./40-implementation/TASK-D10-remove-demo-surfaces.md) | **P0 release blocker.** Three demo surfaces across five files |
| [`DEFINITION_OF_DONE.md`](./40-implementation/DEFINITION_OF_DONE.md) | Three gates: merge, requirement, release |
| [`LIBRARY_IMPLEMENTATION_TASKS.md`](./40-implementation/LIBRARY_IMPLEMENTATION_TASKS.md) | 23 open Library tasks, `IMPL-100`…`IMPL-127`, with acceptance criteria and per-task traps |
| [`TRACEABILITY_MATRIX.md`](./40-implementation/TRACEABILITY_MATRIX.md) | ~1,939 identifiers mapped to tasks and status — 1,517 authentication, ~422 Library |

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
| **Library specification** | ✅ Complete — §§1–25 + §14A + §14B + invitation security, ~422 identifiers |
| **Authentication code** | ⚠️ Exists but **unverified** against v2.0 |
| **Library code** | ❌ **None.** 23 open tasks, `IMPL-100`…`IMPL-127` |
| **`flutter analyze`** | ✅ `No issues found!` |
| **`flutter test`** | ✅ 43 passing — but they predate v2.0 and do not evidence conformance |
| **Releasable?** | ❌ **No.** `TASK-D10` — three demo surfaces violate `MP-CON-11` |
| **OTP delivery** | ❌ No SMS provider. `IMPL-020` — DLT registration is a **multi-week external** dependency; start it first |
| **Module boundaries** | ⚠️ Unenforced — `tool/check_module_boundaries.dart` does not exist (`IMPL-014`) |

**Both specifications are now complete, and that is not the same as progress.** Two long-standing documentation gaps
closed on 2026-08-03 — Library §§1–25 and the `AR-4` invitation security specification. What replaced them is
twenty-three open implementation tasks. A specification tells you the work is possible; it does not make the work
smaller.

**Read the two code rows carefully.** Authentication code is *unverified*; Library code is *absent*. Both appear as
"not started" in the traceability matrix, and only one of them has something to inspect.

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
6. **An exclusion register is not a gap.** `XC-*`, `LXC-*` and `INV-XC-*` list things that must be **impossible**.
   Finding yourself implementing one means you have found a requirements conflict, not a missing feature.
