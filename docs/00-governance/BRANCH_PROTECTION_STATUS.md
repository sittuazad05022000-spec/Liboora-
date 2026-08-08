# LIBOORA — Branch Protection Status

| Field | Value |
|---|---|
| **Document** | Verified status of merge-blocking enforcement on the `main` branch |
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
| **Status** | **NOT ENABLED — and not enableable on the current GitHub plan** |
| **Repository** | `https://github.com/sittuazad05022000-spec/Liboora-` (**private**) |
| **Precedence** | **Unranked.** Operational status record. Never outranks a PRD or an ADR |
| **Authority for the requirement** | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §10.4 — gates **3** and **4** are declared *"required status checks"* on the protected branch |

---

## 1. The claim this document makes

> ⛔ **Branch protection is NOT enabled on `main`. No status check blocks a merge or a push today.**

This is stated plainly because the alternative — asserting protection that does not exist — would be the exact
failure `SID-4.56` names: *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."*
The Dependency Matrix §10.4 **declares** gates 3 and 4 to be required status checks. That declaration is currently
**aspirational**, not operative.

---

## 2. Verification performed, 2026-08-04

Inspection was attempted, not assumed. `gh` is not installed in this environment, so the GitHub REST API was called
directly with the repository's stored credential.

| # | Probe | Result |
|---|---|---|
| 1 | `which gh` | **Not installed** — `command not found`. CLI route unavailable |
| 2 | `GET /repos/{owner}/{repo}` → `permissions` | `{admin: true, maintain: true, push: true, triage: true, pull: true}` — **admin rights confirmed**, so the failure below is not a permissions problem |
| 3 | `GET /repos/{owner}/{repo}/branches/main/protection` | **HTTP 403** — `"Upgrade to GitHub Pro or make this repository public to enable this feature."` |
| 4 | `GET /repos/{owner}/{repo}/rulesets` | **HTTP 403** — identical message. The modern *rulesets* route is blocked too |
| 5 | `GET /user` → `plan.name` | **`free`** |
| 6 | `GET /repos/{owner}/{repo}` → `private` | **`true`** |

### 2.1 The finding is a plan restriction, not a misconfiguration

Probes 3–6 together establish the cause precisely:

**private repository + GitHub Free plan ⇒ branch protection and rulesets are unavailable at the API *and* the UI.**

This distinction matters. The gap is **not** that someone forgot to tick a box — it is that **the box does not
exist on this plan**. No amount of configuration effort inside the current account will enable it. Reporting it as
"pending configuration" would misdirect whoever tries to fix it.

**Consequence:** `push -f` to `main` succeeds today, and a red gate 3 blocks nothing. The six §10.4 gates run and
report, but their result is **advisory**.

---

## 3. What *is* verified to exist

Enforcement is not absent; it is unenforced. The mechanism is fully built.

| Layer | Status | Evidence |
|---|---|---|
| Workflow file | ✅ **Exists** | `.github/workflows/architecture.yml`, 5,592 bytes |
| All six §10.4 gates, in order | ✅ **Present and correctly ordered** | Steps `1 · dart format` → `2 · flutter analyze` → `3 · boundary checker (L1–L5, X-10, X-13) — blocks merge` → `4 · architecture tests — blocks merge` → `5 · full test suite` → `6 · build verification` |
| Boundary checker | ✅ **12 of 12 categories** | `ADR-0014`; Matrix v1.3 |
| Architecture tests | ✅ **20 passing** | `flutter test test/architecture/` |

**So the checks exist and run. What is missing is only the *gate* — the instruction to GitHub that a failing check
must prevent a merge.**

### 3.1 A structural obstacle that survives the plan upgrade

All six gates run inside **one job**, named `§10.4 pipeline gates`. GitHub's required-status-checks mechanism
selects **job-level** contexts, not step-level ones. Therefore:

- Requiring *"architecture boundary gate"* and *"architecture tests"* as **two independently required checks** is
  **not possible with the current workflow shape**, regardless of plan. Only the single context
  `§10.4 pipeline gates` can be required.
- Requiring that one context does achieve the *effect* Matrix §10.4 wants — a failure at any gate fails the job and
  blocks the merge — but it cannot distinguish *which* gate failed at the protection layer, and it makes gates 5
  and 6 merge-blocking too, which §10.4 does **not** ask for.

This is recorded as **`GCP-02`** in §6. It is a real, currently-unfixed shortfall, not a technicality.

---

## 4. Exact manual configuration required

Neither step below can be performed from this environment.

### Step 1 — Remove the plan restriction *(mandatory prerequisite; requires the repository owner)*

Choose **one**:

| Option | Action | Cost | Note |
|---|---|---|---|
| **A** | Upgrade the account to **GitHub Pro** | Paid | Keeps the repository private. Recommended for a pre-release commercial product |
| **B** | Make the repository **public** | Free | ⚠ Publishes the entire specification set and source. A product decision, not a technical one — **must not** be taken to satisfy a CI requirement |
| **C** | Move the repository to a GitHub **Organization** on a plan that includes protected branches | Varies | Also improves the role separation `PRD_OWNERSHIP_MODEL.md` §2.2 describes |

**Until Step 1 is done, Step 2 is impossible and `main` remains unprotected.**

### Step 2 — Configure the protection rule

**GitHub UI:** `Settings` → `Branches` → `Add branch protection rule`

| Setting | Required value |
|---|---|
| Branch name pattern | `main` |
| ☑ Require a pull request before merging | Enabled |
| ☑ Require status checks to pass before merging | Enabled |
| ☑ Require branches to be up to date before merging | Enabled |
| **Required status check** | **`§10.4 pipeline gates`** — the only selectable context; see §3.1 |
| ☑ Do not allow bypassing the above settings | Enabled — including administrators |
| ☐ Allow force pushes | **Disabled** |
| ☐ Allow deletions | **Disabled** |

**Equivalent API call**, once the plan permits it:

```bash
curl -X PUT \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/repos/sittuazad05022000-spec/Liboora-/branches/main/protection \
  -d '{
    "required_status_checks": {
      "strict": true,
      "contexts": ["§10.4 pipeline gates"]
    },
    "enforce_admins": true,
    "required_pull_request_reviews": {
      "required_approving_review_count": 1,
      "dismiss_stale_reviews": true
    },
    "restrictions": null,
    "allow_force_pushes": false,
    "allow_deletions": false
  }'
```

### Step 3 — Split the workflow so gates 3 and 4 are separately requirable *(recommended, closes `GCP-02`)*

Refactor `.github/workflows/architecture.yml` into distinct jobs so each merge-blocking gate is its own
selectable context:

| Job name | Contains | Required? |
|---|---|---|
| `format-and-analyze` | Gates 1–2 | Optional |
| `boundary-gate` | **Gate 3** — `dart run tool/check_module_boundaries.dart` | ✅ **Required** |
| `architecture-tests` | **Gate 4** — `flutter test test/architecture/` | ✅ **Required** |
| `test-suite` | Gate 5 | Recommended |
| `build-verification` | Gate 6 | Recommended |

This matches Matrix §10.4 exactly, which names **only** gates 3 and 4 as merge-blocking.

---

## 5. ⚠ Gate 3 currently fails — and must NOT be made to pass to enable protection

**`dart run tool/check_module_boundaries.dart` exits 1 today**, reporting 9 `cross-context` findings on the
`app → domain/library` edge. This is **deliberate**: `ADR-0012` §3.4 declines to waive that edge because it is
already tracked by `TASK-D10`, a **P0 release blocker**, and waiving it would convert a tracked blocker into
untracked debt.

**Therefore, in the order things must happen:**

1. `TASK-D10` removes the demo surfaces → gate 3 goes green **legitimately**.
2. Branch protection is enabled.

**Enabling protection before step 1 would block every merge**, since the required check would fail on `main`
itself. And the temptation it creates must be named explicitly:

> ⛔ **Do not add an exception to `tool/module_dependencies.yaml` for `app -> domain/library` in order to turn
> gate 3 green.** That would satisfy the pipeline by disabling the check, which is precisely what `ADR-0012` §3.4
> forbids and what the checker's own output warns against: *"Architecture rules are normative. Fix the code, or
> amend `tool/module_dependencies.yaml` through an ADR — never silence the check."*

---

## 6. Findings recorded

| ID | Finding | Severity | Owner |
|---|---|---|---|
| **`GCP-02`** | Branch protection **cannot** be enabled: private repository on the **Free** plan blocks both the branch-protection and rulesets APIs (HTTP 403 on both). Admin rights are present, so this is a **plan** restriction. §10.4's *"required status checks"* are therefore **unmet** under `SID-4.56`. Compounded by a workflow shape that exposes only one job context, so gates 3 and 4 cannot be required independently even after an upgrade | **High** — no merge gate exists | Repository owner (plan); Technical Owner (workflow split) |

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created during the Governance Closure Phase. Status established by **six direct API probes**, not inferred. `gh` is unavailable in this environment, so the REST API was queried with the stored credential. **Branch protection is NOT enabled and cannot be enabled on the current plan** — `GET /branches/main/protection` and `GET /rulesets` both return **HTTP 403 "Upgrade to GitHub Pro or make this repository public"**, while `permissions.admin` is `true` and `plan.name` is `free`, which isolates the cause to the plan rather than to permissions or oversight. A second, independent shortfall was found: all six §10.4 gates run in a **single job**, so gates 3 and 4 cannot be required as separate status checks even after an upgrade — recorded as `GCP-02` with a job-splitting remedy in §4 Step 3. §5 records the sequencing constraint that gate 3 legitimately fails today pending `TASK-D10`, and states explicitly that adding a manifest exception to force it green is forbidden by `ADR-0012` §3.4. **No claim of enablement is made anywhere in this document.** |
