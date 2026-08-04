# Contributing to Liboora

| Field | Value |
|---|---|
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
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

---

## 4. Pull request rules

### 4.1 Before opening

Run the pipeline gates **in this order**. The order matters: an earlier gate feeds the later one — reformatting can
expose a lint that an over-long line was hiding.

```bash
dart format .                                  # 1
flutter analyze                                # 2
dart run tool/check_module_boundaries.dart     # 3 ◄ blocks merge
flutter test test/architecture/                # 4 ◄ blocks merge
flutter test                                   # 5
flutter build web --release                    # 6
```

> **Gate 3 currently exits 1 by design.** Nine `app → domain/library` findings are deliberately **not** waived:
> they live in demo surfaces that `TASK-D10` deletes, and waiving them would create an exception for code already
> scheduled for removal. Compare your output to the documented baseline in
> [`docs/40-implementation/IMPLEMENTATION_STATUS.md`](./docs/40-implementation/IMPLEMENTATION_STATUS.md) §4.
> **Your change must not add findings.** Do not "fix" this gate by adding an exception.

### 4.2 PR requirements

| Requirement | Detail |
|---|---|
| **Title** | Same convention as the commit subject |
| **Description** | What changed, **why**, and which governance IDs it touches |
| **Scope** | One logical change. Split unrelated work |
| **Traceability** | Link the requirement, task or ADR. A change with no traceable driver needs justification |
| **Gate evidence** | Paste gate output, including gate 3's finding count |
| **No new findings** | Boundary checker findings must not increase |
| **Documentation** | Updated per §6 |
| **No merge commits from `main`** | Rebase to keep history readable |

### 4.3 Automatic rejection

- A governance check disabled, weakened, or its output suppressed
- A new dependency-manifest exception without an accepted ADR and an expiry date
- A frozen PRD modified — see §6.1
- A secret, keystore, or `google-services.json` added
- `TODO`, `FIXME` or a placeholder left in shipped code
- Status claimed as complete without evidence

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
| v1.0 | 2026-08-04 | Created. Branch naming, commit convention, PR and review rules, documentation update rules including the frozen-PRD prohibition and the §11 exception process, and testing requirements |
