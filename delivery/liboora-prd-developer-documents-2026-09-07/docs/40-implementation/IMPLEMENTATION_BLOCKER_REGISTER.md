# Implementation Blocker Register

| Field | Value |
|---|---|
| **Document** | Implementation Blocker Register — items that block release or block a gate, recorded but deliberately **not** implemented |
| **Version** | v1.0 |
| **Status** | Active |
| **Date** | 2026-08-04 |
| **Created by** | Governance Closure Phase, item 7 |
| **Rank** | **Unranked** — not listed in `DOCUMENTATION_BASELINE.md` §4. Editable without an ADR |
| **Governing principle** | `SID-4.56` — *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent"* |

---

## 1. Why this document exists, and what it deliberately does not do

The Governance Closure Phase was instructed to **record** `TASK-D10` and `IMPL-020` as blockers and **not to
implement them** unless implementation was required for validation. It was not required: neither item is needed to
run any of the nine validation checks, and both were confirmed to be code changes, not documentation changes.

**Nothing in this register has been implemented. No file under `lib/` was modified by the Governance Closure
Phase.** This document is a record, not a change.

It exists because the two P0 blockers were, before now, discoverable only by reading nine other documents and
assembling the picture. That is how a P0 blocker reaches a release branch: not because anybody decided to ship it,
but because no single document said *"this is what stops you shipping."*

> **This register does not create new information.** Both items were already specified — `TASK-D10` in a dedicated
> 261-line task document, `IMPL-020` in `IMPLEMENTATION_ROADMAP.md` §4. This register does not restate their
> requirements and does not supersede them. It states **what they block, what they depend on, and what may not
> proceed until they are done.**

---

## 2. The register

| ID | Title | Priority | Nature | Blocks | Status |
|---|---|---|---|---|---|
| `BLK-01` | `TASK-D10` — remove demo and debug authentication surfaces | **P0** | Code (production) | **Every release** · Matrix §10.4 **gate 3** | ⬜ **OPEN — not started** |
| `BLK-02` | `IMPL-020` — SMS provider integration + DLT registration | **P0** | Code **+ multi-week external dependency** | **Every release** · `BLK-01` (except step `D10-4`) · `IT-1` staff invitations | ⬜ **OPEN — not started** |
| `BLK-03` | `IMPL-220` — boundary enforcement of `SID-INT-1`…`SID-INT-12` | P0 | Code (checker categories) | Nothing ships-blocking; leaves 12 rules **unmet** per `SID-4.56` | ⬜ **OPEN — unblocked** |
| `BLK-04` | `GCP-02` — branch protection cannot be enabled | — | GitHub plan + workflow structure | Nothing technically; leaves gates **advisory, not enforced** | ⬜ **OPEN — externally blocked** |
| `BLK-05` | `PRD-012a` not opened | — | Documentation (a PRD must be written) | Retirement of `PRD-012`; `PRD-012` remains unassignable | ⬜ **OPEN — authorized, not executed** |

**Five rows, and only two of them are release blockers.** The distinction matters. `BLK-01` and `BLK-02` stop a
release. `BLK-03` and `BLK-04` weaken enforcement without stopping anything, which makes them the more likely to
be quietly forgotten. `BLK-05` is a documentation task that the Governance Closure Phase was explicitly forbidden
to execute.

---

## 3. `BLK-01` — `TASK-D10`, remove demo and debug authentication surfaces

| | |
|---|---|
| **Full specification** | [`TASK-D10-remove-demo-surfaces.md`](./TASK-D10-remove-demo-surfaces.md) — 261 lines, 10 steps, 10 acceptance criteria |
| **Violates** | `MP-CON-11` (Master PRD line 521), `AUTH-11.73` |
| **Scope** | Three surfaces across five files |
| **Depends on** | `BLK-02` — **except step `D10-4`, which depends on nothing** |
| **Blocks** | Every release build, **and** Matrix §10.4 gate 3 |

### 3.1 Why this is the item that keeps gate 3 red

The boundary checker currently exits 1:

```
FAIL — 9 violation(s) in 1 category(ies).
■ cross-context (9)
□ ACKNOWLEDGED DEBT — 28 finding(s) across 12 edge(s), each covered by a dated ADR (§11).
```

**All nine blocking violations are `app -> domain/library` imports, and they exist because the demo surfaces
exist.** `ADR-0012` §3.4 deliberately refused to waive this edge, and
`test/architecture/boundary_checker_test.dart` contains a test named *"app -> domain/library is deliberately NOT
waived"* whose only purpose is to fail if somebody adds that waiver later.

> ⚠ **The nine violations must not be waived to make the gate green.** The waiver is the failure mode this
> architecture was built to prevent, and there is a passing test standing in front of it. Gate 3 turns green when
> `TASK-D10` is done — not before, and not by any other route.

### 3.2 The ordering trap

`TASK-D10` §7 records that the seeded-accounts panel is *the only way to sign in*, because no SMS provider is
wired. Deleting it before `BLK-02` lands produces an application nobody can enter — and the pressure to reinstate
the bypass *"temporarily"* is exactly how these surfaces survive to production.

**Therefore `BLK-01` cannot complete before `BLK-02`.** One exception: **step `D10-4`** deletes the OTP auto-fill
line only, depends on nothing, and closes an authentication bypass. It should be done immediately and separately.

### 3.3 Not done here, and why

Implementing `BLK-01` would mean editing `lib/app/session.dart` and four other production files, removing the only
sign-in path, in a phase whose mandate was governance closure. It was neither required for validation nor
authorized. **Recorded, not implemented.**

---

## 4. `BLK-02` — `IMPL-020`, SMS provider and DLT registration

| | |
|---|---|
| **Full specification** | [`IMPLEMENTATION_ROADMAP.md`](./IMPLEMENTATION_ROADMAP.md) §4, six numbered requirements |
| **Reference** | `MP-DEP-03`, Authentication PRD v2.0 Chapter 8, `AUTH-11.51` |
| **Depends on** | `IMPL-016` |
| **Blocks** | `BLK-01` · authentication end-to-end · `IT-1` staff invitations (`IMPL-112`) |

### 4.1 Why this is first in the programme even though nothing points at it

**`IMPL-020` has the longest lead time in the entire programme, and most of that time is not ours.** Indian TRAI
DLT registration of a transactional SMS template is a multi-week external approval process. Every other P0 item
can be started and finished by the team; this one is largely waiting.

It sits on **two** critical paths:

```
IMPL-016 ──► IMPL-020 (SMS/DLT, external) ──► TASK-D10 ──► releasable authentication
                     └──────────────────────► IMPL-112 (IT-1 staff invitation)
```

The second path is easy to miss. An `IT-1` staff invitation is **delivered by SMS**, so the Library module's staff
onboarding also waits on this item — which is why `docs/30-product/library/README.md` names it on that module's
critical path.

### 4.2 The requirement that decides whether this actually closes anything

`IMPLEMENTATION_ROADMAP.md` §4 requirement 4:

> *"Development sink writes the code to **server logs only**, never to any client response."*

**If the development sink returns the OTP to the client, `TASK-D10` has been recreated under a new name** and
`BLK-01` cannot honestly be closed. This is the single acceptance criterion most likely to be quietly relaxed for
developer convenience.

### 4.3 Not done here, and why

`IMPL-020` requires an external commercial registration with a third party under Indian telecom regulation. It is
not implementable inside this environment at all, let alone within a documentation-governance phase.
**Recorded, not implemented.**

---

## 5. `BLK-03` — `IMPL-220`, `SID-INT-*` boundary enforcement

| | |
|---|---|
| **Reference** | `Student_Identity_PRD_v1.md` `SID-INT-1` … `SID-INT-12` |
| **Previously blocked by** | `IMPL-014` — **that blocker is gone**; the checker exists and runs |
| **Blocks** | Nothing ships-blocking. Leaves **12 integration rules review-verified only** |

`IMPL-220`'s status changed as a *side effect* of the Student Identity migration: it was blocked because the
boundary checker did not exist, and the checker now exists with twelve implemented categories
(`ADR-0014`). `IMPL-220` is therefore **available to implement and not implemented.**

**Under `SID-4.56`, each of `SID-INT-1`…`SID-INT-12` is currently *unmet*, not satisfied.** They are enforced by
code review, and code review is not a check. This is recorded as debt rather than reported as compliance
precisely because the governing principle forbids the more flattering reading.

> This is the honest cost of `SID-4.56`. Twelve rules that are almost certainly being followed must still be
> reported as unmet, because nothing fails if they stop being followed.

---

## 6. `BLK-04` — `GCP-02`, branch protection not enabled

| | |
|---|---|
| **Full status** | [`../00-governance/BRANCH_PROTECTION_STATUS.md`](../00-governance/BRANCH_PROTECTION_STATUS.md) |
| **Cause 1** | Private repository on the GitHub **Free** plan — `HTTP 403` on both `/protection` and `/rulesets` |
| **Cause 2** | All six §10.4 gates run in **one** workflow job, so gates 3 and 4 cannot be required independently |
| **Blocks** | Nothing technically. The gates run but **cannot be enforced** |

**This is not a misconfiguration and cannot be fixed by trying harder.** `permissions.admin` is `true`; the API
returns *"Upgrade to GitHub Pro or make this repository public to enable this feature."* The setting does not
exist on this plan.

Cause 2 is independent and survives a plan upgrade: even with GitHub Pro, `.github/workflows/architecture.yml`
exposes a single job (`§10.4 pipeline gates`) covering all six steps, so *"require the architecture boundary
gate"* cannot be expressed as a required status check until the job is split.

**Consequence to state plainly: the Matrix §10.4 claim that gates 3 and 4 *"block merge"* is currently true of
intent and false of mechanism.** Nothing stops a merge today.

---

## 7. `BLK-05` — `PRD-012a` not opened

| | |
|---|---|
| **Authorized by** | `MASTER_PRD.md` §8 *Correction 2* (Rank 1) |
| **Recorded in** | `PRD_REGISTRY.md` §4.1, §4.3 · `PRD_OWNERSHIP_MODEL.md` lines 170–171 |
| **Blocks** | Retirement of `PRD-012`; `PRD-012` remains the one PRD with no assignable owner |

The split of `PRD-012` into `PRD-012a` (Security Automation) and `PRD-012b` (Workflow Orchestration, V2) is
**confirmed and authorized**. It is **not executed**, because executing it means writing `PRD-012a` — and
`PRD_REGISTRY.md` §8 rule 1 ties `PRD-012`'s retirement to `PRD-012a` being *opened*.

> **Confirmation is not execution.** `PGA-06` is recorded as *confirmed, execution pending* rather than closed,
> because marking it closed would fabricate progress that no document supports.

---

## 8. What this register does **not** claim

| Claim not made | Why it would be false |
|---|---|
| "Gate 3 is passing" | It exits 1, with 9 legitimate unwaived violations |
| "Branch protection is enabled" | `HTTP 403` — unavailable on this plan |
| "`SID-INT-*` rules are enforced" | Review-verified only ⇒ **unmet** per `SID-4.56` |
| "`TASK-D10` is partially done" | Zero of ten steps are complete, including `D10-4` |
| "`PRD-012` is retired" | It is not, and its number is never reused |
| "These blockers were addressed" | They were **recorded**. Nothing under `lib/` changed |

---

## 9. Release readiness — the one-line answer

**The repository cannot produce a releasable build.** `BLK-01` and `BLK-02` are both P0, both open, both
unstarted, and `BLK-01` depends on `BLK-02`, which depends on a multi-week external approval that has not been
started.

**Start `BLK-02`'s DLT registration first.** It is the only item whose duration the team cannot compress.

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created by the Governance Closure Phase, item 7. Records `TASK-D10` and `IMPL-020` as required, plus `IMPL-220`, `GCP-02` and the unopened `PRD-012a` found during the same phase. **Records only — no implementation, no change under `lib/`.** Consolidates blockers that were previously discoverable only across nine separate documents. |
