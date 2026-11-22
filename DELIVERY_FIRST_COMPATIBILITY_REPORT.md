# Delivery-First Development Workflow — Conflict and Compatibility Report

**Date:** 2026-11-22
**Status:** Analysis only — no changes made
**Purpose:** Evaluate proposed policy against existing governance before any modification

---

## Executive Summary

The proposed Delivery-First workflow introduces 10 principles and a 4-stage standard feature workflow. **Most principles are compatible with existing governance when correctly interpreted.** Two principles create direct conflicts that must be resolved before adoption. Three principles require clarification to avoid inadvertently weakening mandatory gates.

---

## Existing Governance Baseline (Authoritative)

| Document | Role | Key Constraint |
|---|---|---|
| `DOCUMENTATION_BASELINE.md` | Declares authoritative documents & precedence | Rank 1–6 hierarchy; frozen PRDs never silently modified (§7) |
| `PRD_LIFECYCLE.md` | 9-stage PRD process with named exit gates | Stage 7 (Freeze) is **conferred, not claimed**; no fast path for urgent business (§7) |
| `DEFINITION_OF_DONE.md` v1.3 | 3 gates (Merge, Requirement Complete, Release) | Binding on all merges/releases; includes 8-step implementation workflow (§7.1) |
| `CONTRIBUTING.md` | Process: branch, commit, review, merge | 6 pipeline gates (format → analyze → boundary check → arch tests → all tests → build) |
| `ADR-INDEX.md` | 118 Accepted ADRs, binding on implementation | ADRs immutable once accepted; supersede requires new ADR |
| `IMPLEMENTATION_ROADMAP.md` | Phased task graph with explicit dependencies | Phase 0–2 are prerequisites for any releasable build |

---

## Principle-by-Principle Analysis

### ✅ **Compatible — Already Established Practice**

| Principle | Existing Equivalent | Evidence |
|---|---|---|
| 1. Implementation is default for sufficiently specified & authorized work | `PRD_LIFECYCLE.md` Stage 8: `IMPLEMENTING` on first task; `IMPLEMENTATION_ROADMAP.md` dependency ordering | Phase 0–2 tasks exist because they are sufficiently specified |
| 3. Reuse existing approved ADRs and PRDs | `CONTRIBUTING.md` §6.1: frozen PRDs & accepted ADRs immutable; `DEFINITION_OF_DONE.md` Gate 1: "Every behavioural change traces to a requirement" | Baseline declares 16 FROZEN PRDs; 118 Accepted ADRs |
| 4. Do not repeat audits when valid evidence exists | `DEFINITION_OF_DONE.md` §7.1: "Documentation updated in the same commit"; `DOCUMENTATION_BASELINE.md` §3.1: ADR count mechanically re-derived | ADR-INDEX re-derived mechanically 2026-09-11 |
| 6. Prefer small, testable implementation batches | `DEFINITION_OF_DONE.md` §7.1 Step 4: "Implement thinly: one authorized aggregate/boundary at a time" | `IMPLEMENTATION_ROADMAP.md` explicit task dependency graph |
| 7. Resolve straightforward blockers independently | `DEVELOPER_HANDOFF.md` §10: "Delete login_screen.dart:42... One line, no dependencies" | TASK-D10 step D10-4 explicitly decoupled from IMPL-020 |
| 9. Keep documentation proportional to complexity and risk | `CONTRIBUTING.md` §6.2: specific update rules per change type; `ADR-0079` §8.5 append-not-insert doctrine | Citation cost measured before/after every write |

### ⚠ **Compatible with Clarification Required**

| Principle | Clarification Needed |
|---|---|
| 2. **Do not create a new ADR for ordinary implementation details** | **Risk:** "Ordinary" is undefined. `PRD_LIFECYCLE.md` §4: **Any business-rule change requires ADR → version increment → changelog → baseline update**. The current rule is: if it changes a requirement, business rule, ownership, or boundary — it needs an ADR. "Implementation detail" must not become a loophole for silent PRD modification. **Resolution:** Define "ordinary implementation detail" as *code that implements a requirement without changing its text, scope, or acceptance criteria*. Any change to a frozen PRD register (FR, BR, INV, EVT, XC, CFG, AC, GAP) requires ADR. |
| 5. **Avoid unnecessary planning phases and repeated status reports** | **Risk:** `PRD_LIFECYCLE.md` has 9 named stages with **named exit gates** (§2 table). "Unnecessary" must not mean "skip Stage 3 Architecture Review" or "skip Stage 5 Traceability". Stage 6A (Technical Specification) is explicitly **optional and non-blocking** (`PRD_LIFECYCLE.md` §7A.3) — this already supports the principle. **Resolution:** "Unnecessary planning" = stages already passed for the relevant PRD. Status reports = `IMPLEMENTATION_STATUS.md` updates (already required per `CONTRIBUTING.md` §6.2). Do not add new report types. |
| 8. **Report only material risks, decisions, and blockers** | **Risk:** `DEFINITION_OF_DONE.md` Gate 1 requires: "The commit references its IMPL-* / AUTH-* identifier" and "Affected documents updated in the same commit". `CONTRIBUTING.md` §4.2 requires: "Gate evidence: Paste gate output, including gate 3's finding count". **Resolution:** "Material" includes all gate evidence and traceability links. The report template in the proposal (§6 Delivery Reporting) should include: task ID, gates passed/failed with evidence, changed files, test results, remaining blockers. This matches existing PR requirements. |
| 10. **Prioritize working, testable MVP over unnecessary perfection** | **Risk:** `DEFINITION_OF_DONE.md` §5 "Never done" table has 25 permanent exclusions (passwords, demo accounts, OTP exposure, emergency bypass, tenant-less queries, cached authorization, etc.). "Unnecessary perfection" must not mean shipping with known `Never done` violations. **Resolution:** MVP means: all Gate 1 items pass, all Gate 2 acceptance criteria for claimed requirements verified, Gate 3 blockers (TASK-D10) closed. No `Never done` item may be deferred. |

### ❌ **Direct Conflict — Must Be Resolved**

| Principle | Conflict | Required Resolution |
|---|---|---|
| **Standard Feature Workflow — "Do not require separate approval for every stage unless an existing policy explicitly requires it"** | `PRD_LIFECYCLE.md` §2: **Each transition has a gate — a named artefact that must exist. If the artefact does not exist, the stage has not been passed.** Stage 3 → 4 → 5 → 6 → 7 each require a **conferral/approval artefact** (alignment record, traceability registration, task allocation, baseline row). `PRD_LIFECYCLE.md` §7: "Urgent business need — **No fast path. Stage 7 is not skippable**." | The 4-stage workflow (Understand → Implement → Verify → Close) **maps to implementation execution (Stage 8)**, not to PRD lifecycle stages. It **cannot replace** Stage 3–7 gates for new/amended PRDs. **Resolution:** Explicitly scope the 4-stage workflow to *implementation tasks on already-FROZEN PRDs* (Stages 8–9). For new PRDs or amendments, the 9-stage lifecycle remains mandatory. |
| **Scope Discipline — "Do not commit or push without explicit authorization"** | `CONTRIBUTING.md` §3: Conventional Commits with `Refs:` governance IDs. §4.3: Automatic rejection for "Status claimed as complete without evidence". **But:** No policy requires "explicit authorization to commit/push" for ordinary implementation tasks on frozen PRDs — only for governance acts (ADRs, PRD amendments, baseline changes). | **Resolution:** Change to: "Do not commit or push **governance changes** (ADRs, PRD amendments, baseline updates, architecture exceptions) without explicit authorization recorded in an accepted ADR or conferred decision. Ordinary implementation commits on frozen PRDs require gate evidence per `CONTRIBUTING.md` §4.2, not separate authorization." |

---

## Standard Feature Workflow Mapping

| Proposed Stage | Maps To | Gate Evidence Required |
|---|---|---|
| **1. Understand** | Read FROZEN PRD, Accepted ADRs, Implementation Tasks, Tests | Traceability link in PR description (`CONTRIBUTING.md` §4.2) |
| **2. Implement** | `DEFINITION_OF_DONE.md` §7.1 8-step workflow (Slice → Contract → Thin → Test) | `dart format`, `flutter analyze`, boundary checker, architecture tests — all pass |
| **3. Verify** | Gate 1 (Merge) + Gate 2 (Requirement Complete) | Full pipeline output pasted in PR; zero new boundary findings; acceptance criteria tests added |
| **4. Close** | `IMPLEMENTATION_STATUS.md` update + `TRACEABILITY_MATRIX.md` update (same commit) | Task marked closed; requirement → test mapping verified |

**Critical:** This workflow **only applies when the PRD is already FROZEN** (Stage 7 complete). For Draft/In-Review PRDs, the 9-stage lifecycle governs.

---

## Safety Boundary Compatibility

| Proposed Boundary | Existing Equivalent | Status |
|---|---|---|
| Explicit human authorization where required | `PRD_LIFECYCLE.md` Stage 7: Freeze **conferred by baseline row**, not self-declared; ADRs accepted by conferral | ✅ Compatible |
| Security and privacy requirements | `DEFINITION_OF_DONE.md` §5: 25 "Never done" items including `MP-GBR-25`, `MP-CON-11`, `AUTH-11.53/54` | ✅ Compatible |
| Tenant isolation and access control | `MP-GBR-08`, `X-13`, `DEFINITION_OF_DONE.md` Gate 1: "Every tenant-scoped query carries a tenant key" | ✅ Compatible |
| Data integrity and financial correctness | `PRD-008` FROZEN: `FEE-INV-002/005/009`, `MP-GBR-12/18/24` | ✅ Compatible |
| Approved architectural boundaries | `ADR-0001` Modular monolith; `ADR-0012` boundary checker merge gate; `tool/module_dependencies.yaml` | ✅ Compatible |
| Required tests and release gates | `CONTRIBUTING.md` §4.1: 6 pipeline gates; `DEFINITION_OF_DONE.md` Gate 3 release checklist | ✅ Compatible |
| Existing governance restrictions | `CONTRIBUTING.md` §6.1: Frozen PRDs & Accepted ADRs immutable | ✅ Compatible |

---

## Recommended Policy Changes

### 1. Amend Principle 2
**From:** "Do not create a new ADR for ordinary implementation details."
**To:** "Do not create a new ADR for code that implements a frozen requirement without changing its text, scope, identifiers, or acceptance criteria. Any change to a FROZEN PRD register (FR/BR/INV/EVT/XC/CFG/AC/GAP) or to an Accepted ADR's decision text requires an ADR."

### 2. Scope the 4-Stage Workflow
Add explicit preamble: **"This workflow applies to implementation tasks (Stage 8) against FROZEN PRDs. For new PRDs or amendments, the 9-stage PRD Lifecycle (§2–§7) remains mandatory and non-skippable."**

### 3. Amend Scope Discipline Rule
**From:** "Do not commit or push without explicit authorization."
**To:** "Do not commit or push **governance changes** (ADRs, PRD amendments, baseline updates, architecture exceptions) without explicit authorization recorded in an accepted ADR or conferred decision. Ordinary implementation commits on frozen PRDs require gate evidence per `CONTRIBUTING.md` §4.2."

### 4. Align Delivery Reporting with Existing PR Requirements
The proposed report template (§6) should explicitly require:
- Pipeline gate output (all 6 gates from `CONTRIBUTING.md` §4.1)
- Boundary checker finding count (must not increase)
- Traceability matrix updates (requirement → test mapping)
- `IMPLEMENTATION_STATUS.md` task state change

---

## Files That Would Need Change (If Approved)

| File | Change Type | Risk |
|---|---|---|
| `CONTRIBUTING.md` | Add Delivery-First preamble; clarify 4-stage workflow scope; amend "explicit authorization" rule | Low — process document |
| `DEFINITION_OF_DONE.md` | Add reference to Delivery-First principles in §1 Purpose | Low — additive only |
| `IMPLEMENTATION_ROADMAP.md` | No change needed — already embodies dependency-ordered, small-batch delivery | None |
| `DEVELOPER_HANDOFF.md` | No change needed — already orientates to "implementation first" | None |

**No frozen PRD, Accepted ADR, or baseline document would be modified.**

---

## Conclusion

The Delivery-First principles are **largely already embedded** in Liboora's existing governance. The conflicts are **terminological and scoping**, not substantive. With the four recommended amendments, the policy can be adopted as a **clarifying overlay** on existing process — reducing perceived overhead without weakening any mandatory gate.

**Recommendation:** Approve the four amendments, then update `CONTRIBUTING.md` and `DEFINITION_OF_DONE.md` as the smallest safe repository change. Do not create a new standalone policy document — embed in existing process docs.