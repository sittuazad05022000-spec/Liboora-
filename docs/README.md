# Liboora — Documentation

| | |
|---|---|
| **Baseline** | **BASELINE-2026-08-04** — locked |
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
| [`adr/ADR-0001`](./00-governance/adr/ADR-0001-modular-monolith.md) … [`ADR-0011`](./00-governance/adr/ADR-0011-global-person-identity.md) | The **eleven** accepted decisions. **Binding.** All are short — read all eleven. `ADR-0011` is the only one that **amends** the Bounded Context Map's Identity Triad and a Master PRD global rule |
| [`DOCUMENTATION_AUDIT-001.md`](./00-governance/DOCUMENTATION_AUDIT-001.md) | The enterprise review that produced this baseline. 34 findings, plus the Library second pass (§6B) |

### 00-governance/prd-ecosystem

Management of the PRD set as a whole. **Navigational and administrative — no requirements live here.** Where any
of these disagrees with a PRD, the PRD is right.

| Document | Purpose |
|---|---|
| [`PRD_REGISTRY.md`](./00-governance/prd-ecosystem/PRD_REGISTRY.md) | **The register of record.** 23 PRDs — 4 exist, 19 planned. Status, version, contexts, dependencies, ADRs, tasks and freeze state for each |
| [`PRD_DEPENDENCY_GRAPH.md`](./00-governance/prd-ecosystem/PRD_DEPENDENCY_GRAPH.md) | Which PRD depends on which, and by what kind of dependency. 17 edges, no cycles |
| [`PRODUCT_IMPLEMENTATION_ROADMAP.md`](./00-governance/prd-ecosystem/PRODUCT_IMPLEMENTATION_ROADMAP.md) | The order PRDs should be **written and built**, Waves 0–5. Complements `40-implementation/IMPLEMENTATION_ROADMAP.md`, which sequences *tasks* |
| [`PRD_GAP_ANALYSIS.md`](./00-governance/prd-ecosystem/PRD_GAP_ANALYSIS.md) | 11 findings. Missing PRDs, one genuine ownership overlap (`PGA-11`), and **six cases where a new PRD would be the wrong answer** |
| [`PRD_OWNERSHIP_MODEL.md`](./00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md) | Who owns each PRD, as **four organizational roles** — never a personal name. All 23 assigned; closes `PGA-08` |
| [`PRD_LIFECYCLE.md`](./00-governance/prd-ecosystem/PRD_LIFECYCLE.md) | Discovery → Draft → Architecture Review → Requirements Review → Traceability → Tasks → **Freeze** → Implementation → Verification, with the exit gate for each |

## 10-architecture

| Document | Version | Purpose |
|---|---|---|
| [`LIBOORA_BOUNDED_CONTEXT_MAP.md`](./10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) | **v1.3** | 31 bounded contexts, the Identity Triad, 26 integration edges, aggregates and invariants. §4 amended by `ADR-0011` |
| [`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](./10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) | **v1.1** | Dependency laws, ranks, allow-lists, 14 forbidden edges. Rank `R7.5` added by `ADR-0011` |
| [`ARCHITECTURE_RULINGS.md`](./10-architecture/ARCHITECTURE_RULINGS.md) | **v1.2** | `AR-1`…`AR-7`. Four promoted to ADRs; `AR-1`, `AR-3`, `AR-4` remain binding here. The `AR-4` invitation-security deferral is **lifted** |
| [`LIBOORA_ENTERPRISE_ARCHITECTURE.md`](./10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md) | v2.1 | The architecture tree. **Descriptive** — follows the PRDs, never leads them |

## 20-configuration

| Document | Purpose |
|---|---|
| [`CONFIGURATION_GUIDE.md`](./20-configuration/CONFIGURATION_GUIDE.md) | `CFG-1`…`CFG-12` · `LCFG-1`…`LCFG-13` · `ICFG-1`…`ICFG-10` — defaults, ranges, invariants `INV-1`…`INV-16`, environment profiles, observability. Every default anchored to a standard or a stated analysis. **`SCFG-1`…`SCFG-11` are specified in the Student Identity PRD §5.5 and not yet migrated here** |

## 30-product

| Document | Version | Status |
|---|---|---|
| [`MASTER_PRD.md`](./30-product/MASTER_PRD.md) | **v1.7** | **Platform-wide global rules. Outranks every module PRD.** `MP-GBR-02` amended by `ADR-0011` |
| [`authentication/Authentication_PRD_v2.md`](./30-product/authentication/Authentication_PRD_v2.md) | **v2.0** | **The authentication baseline.** 588 requirements, 11 chapters |
| [`authentication/prd-v2/`](./30-product/authentication/prd-v2/) | v2.0 | Chapter sources of the above |
| [`authentication/PRD-V2-GOVERNANCE-NOTE.md`](./30-product/authentication/PRD-V2-GOVERNANCE-NOTE.md) | v2.0 | Provenance. **Not part of the specification** |
| [`library/Library_PRD_v1.md`](./30-product/library/Library_PRD_v1.md) | **v1.0** | **The Library baseline.** §§1–25, ~130 requirements |
| [`library/14A-Library-Discovery-And-Enrollment.md`](./30-product/library/14A-Library-Discovery-And-Enrollment.md) | v1.0 | Discovery, enrollment, **the public field allow-list** |
| [`library/14B-Public-Library-Preview.md`](./30-product/library/14B-Public-Library-Preview.md) | **v1.0** | Anonymous preview, protected operations `PO-1`…`PO-12`, intent preservation |
| [`library/INVITATION_SECURITY_SPECIFICATION.md`](./30-product/library/INVITATION_SECURITY_SPECIFICATION.md) | **v1.0** | 71 requirements. Entropy, expiry, revocation, single use, validation, audit, rate limiting |
| [`library/LIBRARY_PRD_ALIGNMENT.md`](./30-product/library/LIBRARY_PRD_ALIGNMENT.md) | v1.0 | Validation record. **Not part of the specification** |
| [`student-identity/Student_Identity_PRD_v1.md`](./30-product/student-identity/Student_Identity_PRD_v1.md) | **v1.0** | **The Student Identity baseline.** Chapters 1–5, 226 requirements, nine registers |
| [`student-identity/README.md`](./30-product/student-identity/README.md) | v1.0 | Module index. Navigational — **not part of the specification** |
| [`student-identity/STUDENT_IDENTITY_ALIGNMENT.md`](./30-product/student-identity/STUDENT_IDENTITY_ALIGNMENT.md) | v1.0 | Validation record, `SC-1`…`SC-14`. **Not part of the specification** |

**"The Library PRD" means the four `library/` specification rows together**, never one alone. Most of its
security-relevant constraints are cross-references between them.

**"Student Identity" means `BC-10` Global Person Identity, and it is not a social feature.** It is `[CORE]`, it is
`1:1` with every authentication account, and it is the permanent identity for the whole education ecosystem —
libraries today, schools, colleges and coaching centres later. Student Network is only one of its consumers. If the
social product never ships, every identity still exists and still works (`SID-4.31`). Read `ADR-0011` before
touching anything in this module.

## 40-implementation

| Document | Purpose |
|---|---|
| [`DEVELOPER_HANDOFF.md`](./40-implementation/DEVELOPER_HANDOFF.md) | **Start here.** Orientation, traps, honest state of the codebase |
| [`IMPLEMENTATION_ROADMAP.md`](./40-implementation/IMPLEMENTATION_ROADMAP.md) | **Ten phases** (0–9), ordered by dependency. Critical path identified |
| [`AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md`](./40-implementation/AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md) | Keep open while coding. Twelve blocks plus anti-patterns |
| [`TASK-D10-remove-demo-surfaces.md`](./40-implementation/TASK-D10-remove-demo-surfaces.md) | **P0 release blocker.** Three demo surfaces across five files |
| [`DEFINITION_OF_DONE.md`](./40-implementation/DEFINITION_OF_DONE.md) | **v1.2.** Three gates: merge, requirement, release. Covers authentication, Library **and** Student Identity |
| [`LIBRARY_IMPLEMENTATION_TASKS.md`](./40-implementation/LIBRARY_IMPLEMENTATION_TASKS.md) | 23 open Library tasks, `IMPL-100`…`IMPL-127`, with acceptance criteria and per-task traps |
| [`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md`](./40-implementation/STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md) | 25 open Student Identity tasks, `IMPL-200`…`IMPL-226`. **Two are migrations of existing code** |
| [`TRACEABILITY_MATRIX.md`](./40-implementation/TRACEABILITY_MATRIX.md) | **v1.2.** ~2,282 identifiers mapped to tasks and status — 1,517 authentication, ~422 Library, **343 Student Identity** |

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
| **Student Identity specification** | ✅ Complete — Chapters 1–5, 343 identifiers, nine registers verified gap-free |
| **Authentication code** | ⚠️ Exists but **unverified** against v2.0 |
| **Library code** | ❌ **None.** 23 open tasks, `IMPL-100`…`IMPL-127` |
| **Student Identity code** | ⚠️ Exists and implements the **superseded** pre-`ADR-0011` model — nullable `personId`, identity owned by `domain/social`. 25 open tasks, `IMPL-200`…`IMPL-226`, two of them migrations |
| **`flutter analyze`** | ✅ `No issues found!` |
| **`flutter test`** | ✅ 43 passing — but they predate v2.0 and do not evidence conformance |
| **Releasable?** | ❌ **No.** `TASK-D10` — three demo surfaces violate `MP-CON-11` |
| **OTP delivery** | ❌ No SMS provider. `IMPL-020` — DLT registration is a **multi-week external** dependency; start it first |
| **Module boundaries** | ⚠️ Unenforced — `tool/check_module_boundaries.dart` does not exist (`IMPL-014`) |

**Both specifications are now complete, and that is not the same as progress.** Two long-standing documentation gaps
closed on 2026-08-03 — Library §§1–25 and the `AR-4` invitation security specification. What replaced them is
twenty-three open implementation tasks. A specification tells you the work is possible; it does not make the work
smaller.

**Read the three code rows carefully — they are three different problems.** Authentication code is *unverified*
against its specification. Library code is *absent*. Student Identity code *exists and is wrong*: it faithfully
implements the architecture as it stood before `ADR-0011`, which is the normal consequence of a decision landing
after a scaffold. All three can look like "not started" in a status column, and the remedies share nothing.

**One divergence is deliberate and should not be "fixed" on sight.** `tool/module_dependencies.yaml` already
declares `domain/person: 7.5` and has removed `identity` from `domain/social`. The code has not moved yet. The
manifest describes the decided architecture; the code describes the one it replaced. Reverting the manifest to
match the code would encode the superseded model as the target. Recorded in
[`TRACEABILITY_MATRIX.md`](./40-implementation/TRACEABILITY_MATRIX.md) §8A.

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
