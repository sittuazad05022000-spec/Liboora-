# Contributing to Liboora

| Field | Value |
|---|---|
| **Version** | v1.1 |
| **Date** | 2026-11-22 |
| **Audience** | Anyone changing code, documentation or governance in this repository |
| **Read first** | [`docs/40-implementation/DEVELOPER_HANDOFF.md`](./docs/40-implementation/DEVELOPER_HANDOFF.md) — it orients you in about ten minutes |

This document covers **process**: how to branch, commit, review and merge. For *how the system is built* — module
boundaries, dependency laws, naming, error handling — see [`DEVELOPER_GUIDE.md`](./DEVELOPER_GUIDE.md).

---

## 1. The one rule that explains the others

**Documentation is the source of truth. Code conforms to documentation.**

When code and documentation disagree, the default resolution is to **change the code**. Changing the specification
is possible but is a product decision requiring the ADR process — not something done in passing while implementing.

A corollary worth stating plainly, from `SID-4.56`:

> A rule that cannot be checked SHALL be treated as unmet.

So a rule you cannot enforce mechanically is **not** satisfied by careful review. It is recorded as unmet. This is
why governance tooling exists and why silencing it is a serious matter.

---

## 1A. Delivery-First Principles

The following principles apply to **implementation work on FROZEN PRDs** (Stage 8 of `PRD_LIFECYCLE.md`). They do not replace or weaken any mandatory PRD lifecycle gate (Stages 1–7) or exit artefact.

| # | Principle | Governance Basis |
|---|---|---|
| 1 | Implementation is the default for sufficiently specified and authorized work | `IMPLEMENTATION_ROADMAP.md` dependency graph; `PRD_LIFECYCLE.md` Stage 8 |
| 2 | Do not create a new ADR for code that implements a frozen requirement without changing its text, scope, identifiers, or acceptance criteria | `PRD_LIFECYCLE.md` §4: any business-rule change requires ADR |
| 3 | Reuse existing approved ADRs and PRDs | `DOCUMENTATION_BASELINE.md` — 16 FROZEN PRDs, 118 Accepted ADRs |
| 4 | Do not repeat audits when valid evidence already exists | `ADR-INDEX.md` mechanical re-derivation; `CONTRIBUTING.md` §6.2 same-commit updates |
| 5 | Avoid unnecessary planning phases and repeated status reports | Stage 6A (Technical Specification) is **optional and non-blocking** per `PRD_LIFECYCLE.md` §7A.3 |
| 6 | Prefer small, testable implementation batches | `DEFINITION_OF_DONE.md` §7.1 Step 4: implement thinly, one aggregate/boundary at a time |
| 7 | Resolve straightforward blockers independently | `DEVELOPER_HANDOFF.md` §10: TASK-D10 step D10-4 (one line, no dependencies) |
| 8 | Report only material risks, decisions, and blockers | `CONTRIBUTING.md` §4.2: gate evidence, traceability links, boundary finding count |
| 9 | Keep documentation proportional to complexity and risk | `CONTRIBUTING.md` §6.2 specific update rules; `ADR-0079` §8.5 append-not-insert |
| 10 | Prioritize a working, testable MVP over unnecessary perfection | `DEFINITION_OF_DONE.md` §5 "Never done" table — 25 permanent exclusions never deferred |

**Scope:** These principles govern the 4-stage implementation workflow below. For new PRDs or amendments, the 9-stage `PRD_LIFECYCLE.md` (Stages 1–7) remains mandatory and non-skippable.

---

## 2. Branch naming

Branch from `main`. Use a type prefix, a short kebab-case description, and an issue or task ID where one exists.

```
<type>/<short-description>
<type>/<TASK-ID>-<short-description>
```

| Type | Use for | Example |
|---|---|---|
| `feat/` | New capability | `feat/IMPL-220-sid-int-enforcement` |
| `fix/` | Defect repair | `fix/tenant-scope-missing-on-seat-query` |
| `refactor/` | Structure change, no behaviour change | `refactor/extract-event-publisher-port` |
| `docs/` | Documentation only | `docs/adr-0013-branch-id` |
| `test/` | Tests only | `test/attendance-idempotency` |
| `chore/` | Tooling, dependencies, CI | `chore/pin-yaml-dependency` |
| `arch/` | Architecture or governance | `arch/wave-1-port-extraction` |

**Rules:** lower-case, hyphen-separated, no personal names, no `final`/`final2`, and one logical change per branch.
Keep branches short-lived — a long branch drifts from the documentation baseline.

---

## 3. Commit message convention

Conventional Commits, with a scope and a body that explains **why**.

```
<type>(<scope>): <subject>

<body — why, not what>

Refs: <IDs>
```

| Element | Rule |
|---|---|
| `type` | `feat` · `fix` · `docs` · `refactor` · `test` · `chore` · `perf` · `arch` |
| `scope` | Module or area: `auth`, `enrollment`, `architecture`, `governance`, `identity`, `student-identity` |
| `subject` | Imperative mood, lower case, no trailing full stop, ≤ 72 characters |
| `body` | Wrapped at 100 characters. Explain the reasoning. The diff already shows what changed |
| `Refs:` | Governance IDs touched: `ADR-0011`, `SID-4.11`, `IMPL-014`, `AUTH-4.23`, `RSK-07` |

**Required in the body when applicable:**

- If a gate is intentionally left red, say so and say why.
- If a validation **failed** before you fixed it, record the failure. "It worked in the end" and "it worked all
  along" are different facts, and only one of them is true.
- If you touched an architectural boundary, cite the ADR that permits it.

Good:

```
fix(enrollment): reject seat query with no tenant in scope

A tenant-less query on tenant data is blocker severity, not a bug to
schedule: it is the mechanism by which one library could read another's
students. The store now throws rather than returning an unscoped result.

Refs: MP-GBR-01, SID-4.23
```

Bad: `fixed stuff` · `WIP` · `update` · `feat: changes as discussed`

**Never** commit a secret, a generated artefact under `build/`, or a commented-out block of code.

**Explicit authorization** (recorded in an Accepted ADR or conferred decision) is required for **governance changes only**: ADRs, PRD amendments, baseline updates, architecture exceptions. Ordinary implementation commits on FROZEN PRDs require gate evidence per §4.2, not separate authorization.

---

## 5. Code review process

### 5.1 Reviewer duties

Review in this order, because a passing test suite does not imply a legal structure:

| # | Check |
|---|---|
| 1 | **Does it conform to the documentation?** Not "is it clever" — does it match the spec |
| 2 | **Does it respect module boundaries?** Rank order, port mode, ownership. See `DEVELOPER_GUIDE.md` |
| 3 | **Is tenant scope enforced?** On every tenant-data path |
| 4 | **Are the tests falsifiable?** A test that cannot fail proves nothing |
| 5 | **Is the reasoning recorded?** Will someone understand *why* in six months |
| 6 | **Are claims verified?** "Tests pass" needs output, not assertion |

### 5.2 Expectations

| Party | Expectation |
|---|---|
| **Author** | Explain reasoning, not just mechanics. Respond to every comment. Do not force-push after review begins — add commits so reviewers can see what changed |
| **Reviewer** | Be specific and cite the rule or document. Distinguish blocking from advisory. Approve when correct, not when perfect |
| **Both** | Disagreement about a *rule* is resolved by an ADR, never by a workaround in the diff |

At least **one approval** is required. Changes to architecture, governance or dependency rules need review by an
architecture owner.

### 5.3 Merging

**Never force-push to `main`.** If `main` has moved, rebase your branch or merge `main` into it — unrelated history
is preserved, never overwritten. Squash trivial fixup commits; keep meaningful ones separate.

---

## 6. Documentation update rules

### 6.1 What must not be touched

| Category | Rule |
|---|---|
| **Frozen PRDs** under `docs/30-product/` | **Do not rewrite, reword or renumber.** A product change goes through the ADR process |
| **Accepted ADRs** | Immutable once accepted. Supersede with a new ADR; never edit the decision |
| **`docs/90-archive/`** | Historical. Never edited, never authoritative |

Requirement IDs (`SID-4.11`, `AUTH-4.23`, `MP-GBR-01`) are **permanent addresses.** Renumbering breaks every
citation across the repository.

### 6.2 What you must update

| If you change | Update |
|---|---|
| Structure — contexts, ownership, ranks, boundaries | [`docs/10-architecture/ARCHITECTURE_CHANGELOG.md`](./docs/10-architecture/ARCHITECTURE_CHANGELOG.md) and the relevant matrix or map, with a version row |
| Anything with an implementation status | [`docs/40-implementation/IMPLEMENTATION_STATUS.md`](./docs/40-implementation/IMPLEMENTATION_STATUS.md) — **the authoritative status record** |
| A dependency rule | `tool/module_dependencies.yaml` **and** the Dependency Matrix, plus an ADR if adding an exception |
| A task's state | The relevant `*_IMPLEMENTATION_TASKS.md` |
| A user-visible change | [`CHANGELOG.md`](./CHANGELOG.md) |
| Requirement coverage | [`docs/40-implementation/TRACEABILITY_MATRIX.md`](./docs/40-implementation/TRACEABILITY_MATRIX.md) |

**In the same commit as the change.** Documentation updated later is documentation that was wrong in between —
Phase 5 validation of the Student Identity migration found ten stale statements across seven documents that had all
been true when written.

### 6.3 Adding an architecture exception

Exceptions are time-boxed by tooling, not by good intentions. Per the Dependency Matrix §11:

1. Attempt the four cycle-breaking patterns in Matrix §8 first.
2. If none suffices, write an ADR: the edge, the law, why §8 was insufficient, the blast radius, and a **dated
   removal plan**.
3. Get architecture-owner approval. **Law `L1` (acyclic) is never waivable** — no exception has ever been approved,
   and none will be.
4. Add it to `tool/module_dependencies.yaml` with `adr:` and `expires:`.
5. CI fails after the expiry date if the exception still exists.

An exception missing its ADR, or with an unparseable expiry, **halts** the checker (exit 2) rather than passing.

---

## 7. Testing requirements

### 7.1 What each change owes

| Change | Required tests |
|---|---|
| New domain behaviour | Unit tests for the rule **and** its violation. Both paths |
| A documented invariant | A **falsifiable** test that fails if the invariant is removed |
| Bug fix | A regression test that fails before the fix and passes after. Confirm it fails first |
| Architecture rule | A test under `test/architecture/` |
| Boundary or DI change | `flutter test test/architecture/` must pass |
| UI change | A widget test for the state transition, not for pixels |

### 7.2 Standards

| Standard | Detail |
|---|---|
| **Falsifiability** | A test that passes against a deliberately broken implementation is worse than no test — it certifies nothing while implying safety |
| **Name the rule** | `'a seat cannot be double-booked'`, not `'test seat 2'` |
| **Test behaviour, not implementation** | Refactoring should not break a correct test |
| **Deterministic** | No wall-clock dependence, no ordering dependence, no network |
| **Tenant isolation** | Any tenant-data feature needs a cross-tenant negative test |
| **Verify before claiming** | Run it. A test suite that "should pass" often does not |

### 7.3 Beware the false green

A test asserting *"this throws"* passes if the code throws for an **unrelated** reason — a typo, a missing binding,
a null. When asserting a failure, assert the **specific** error, and confirm the test fails for the right reason by
temporarily breaking the intended behaviour.

Current suite: **71 tests** — run `flutter test` for the live count. It must not decrease.

---

## 8. Getting started

```bash
git clone https://github.com/sittuazad05022000-spec/Liboora-.git
cd Liboora-
flutter pub get
flutter test
dart run tool/check_module_boundaries.dart   # expect exit 1 — read §4.1
```

Then read [`docs/40-implementation/DEVELOPER_HANDOFF.md`](./docs/40-implementation/DEVELOPER_HANDOFF.md), and
[`DEVELOPER_GUIDE.md`](./DEVELOPER_GUIDE.md) before your first commit.

By contributing you agree your contributions are licensed under the [MIT License](./LICENSE), and to abide by the
[Code of Conduct](./CODE_OF_CONDUCT.md).

---

| Version | Date | Change |
|---|---|---|
| v1.1 | 2026-11-22 | Added Delivery-First principles (§1A) and 4-stage workflow for FROZEN PRD implementation (§4.0); clarified explicit authorization scope for governance changes vs implementation commits; no existing gate weakened |
| v1.0 | 2026-08-04 | Created. Branch naming, commit convention, PR and review rules, documentation update rules including the frozen-PRD prohibition and the §11 exception process, and testing requirements |
