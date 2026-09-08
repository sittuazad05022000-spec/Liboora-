# Implementation Blocker Register

| Field | Value |
|---|---|
| **Document** | Implementation Blocker Register — items that block release or block a gate, recorded but deliberately **not** implemented |
| **Version** | v1.3 |
| **Status** | Active |
| **Date** | 2026-09-08 |
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

---

## 11. Offline Attendance Sync authority audit — 2026-09-08

This is an **audit/register addendum only**. It does not create a PRD, amend a frozen PRD,
accept or modify an ADR, select a vendor, define a numeric policy, or authorise implementation.
The controlled source is the repository at `main`, re-verified against the current Git history.

### 11.1 `ADR-0114` verification

| Check | Repository evidence | Determination |
|---|---|---|
| Status and ratification | `docs/00-governance/adr/ADR-0114-offline-sync-is-a-capability-of-bc-03-attendance.md` header says **`Accepted`**. Commit `2040077` (`docs(adr-0114): Offline Sync is a BUSINESS capability of BC-03, EXECUTED by BC-30 — Q-1b`) records direct conferral of Architecture Owner authority. `ADR-INDEX.md` registers the ADR in the accepted count. | **ACCEPTED**; the earlier `PROPOSED` reading is superseded by current repository evidence. |
| Product decision | `PRD-018_STAGE1_DISCOVERY_PREPARATION.md` §8.1 records Product Owner **Option B**: Offline Sync is a capability of `BC-03` Attendance, Attendance-only, and `PRD-018` is not to be written. | **Option B recorded and executed through the accepted ADR.** |
| BC-30 disposition | `ADR-0114` D-1 and the accepted commit preserve `BC-30` as a bounded context and the execution mechanism; `BC-03` owns requirement, policy, acceptance criteria and scope. | **BC-30 remains; capability ownership and execution ownership are separate.** |
| `E-24` fate | `ADR-0114` records `Q-2`: `E-24` retained unchanged. | **Unchanged.** |
| Registry and index | `ADR-INDEX.md` has the `ADR-0114` row and mechanically re-derived counts. `PRD_REGISTRY.md` remains unchanged; `PRD-018` remains `PLANNED` because the registry vocabulary has no terminal value for this disposition. | **ADR index registered; PRD registry not changed.** |
| Attendance-only requirements | Frozen `PRD-006` already carries `ATT-PO-006`, `ATT-PO-011`…`014`, `ATT-NFR-012` and §27.1: Attendance defines the replay conflict policy; `BC-30` executes queue/replay. | **Existing Attendance-side requirements remain the placement; no PRD-006 edit is authorised.** |
| Git history | `2040077` is an ancestor of current `main` (`2970993`) and changed the ADR, ADR index, BC Map, baseline and Stage-1 preparation record in one governance commit. | **Acceptance and consequences are already persisted; no ADR correction is required here.** |

### 11.2 Offline Attendance Sync authority and dependency register

| Item | Status | Authority / evidence | Owner / next action |
|---|---|---|---|
| **7a — Retention** | **OPEN** — no authoritative retention number. Do not adopt “7 years financial / 2 years attendance”. | BC Map `Q-04` remains open; `ATT-GAP-005` rejects the unratified note; `MASTER_PRD MP-NFR-10` assigns retention enforcement to Security + Data Governance; `ADR-0051` records the retention gap as open. | Legal Counsel + Security/Data Governance decision; Architecture Owner to formalise through ADR. |
| **8b-residual — revoked/expired actor before replay** | **REQUIRES OWNER DECISION** — no authoritative queued-item disposition or audit-bearing treatment found. | `PRD-001` requires current-state authorisation and refusal when access is not allowed. Frozen `PRD-006` defines idempotency/correction preservation, but does not decide discard/reject versus an audit-bearing treatment for this residual. | Product Owner + BC-03 Domain Owner decision; ADR-first if frozen authority must change. |
| **Item 4 — Backend Runtime** | **BLOCKED** — `ADR-0115` is accepted in principle, but the deployment operator and server-side secret-custody owner remain unassigned follow-up gaps; no implementation is authorised. | `MASTER_PRD.md` L227 names BaaS only as a candidate and says it is not named in the EA; the accepted-in-principle ADR preserves that boundary. | Name the deployment operator and secret-custody/control owner through a follow-up governed act; do not select a vendor or implement from this register. |
| **Item 3 — Durable Queue** | **BLOCKED BY ITEM 4**. | No approved backend/runtime authority and no authorised durability model. | Wait for Item 4; no queue implementation or durability value. |
| **Item 9b — At-rest** | **BLOCKED BY ITEM 3**. | Storage and at-rest treatment depend on the durable-queue placement and authority; no security mechanism is invented. | Re-check after Item 3; no encryption/storage policy is selected here. |
| **Item 5 — Retry/Backoff** | **BLOCKED/OPEN**. | No authorised retry/backoff policy or numeric values. | Re-check after Item 4; no retry count, interval or backoff value is set. |
| **Item 7b — Queue Depth** | **BLOCKED BY ITEM 3**. | No queue durability/placement authority and no queue-depth NFR authority. | Re-check after Item 3; no queue limit is set. |
| **PRD-018** | **NO-PRD decision unchanged**. | Accepted `ADR-0114` records Attendance-only capability scope; `PRD-018` is not to be written and remains `PLANNED` in the registry. | Do not create or revive `PRD-018`. |
| **TASK-D10 / IMPL-020** | **UNTOUCHED**. | This audit does not modify either artifact or perform either implementation. | Keep untouched. |

The dependency graph is therefore:

```text
Item 4 Backend Runtime ──► Item 3 Durable Queue ──► Item 9b At-rest ──► Item 7b Queue Depth
          │
          └──────────────► Item 5 Retry/Backoff

7a Retention                 (independent; OPEN)
8b-residual                 (independent; REQUIRES OWNER DECISION)
```

**Primary next authorised action:** complete the follow-up governed act for **Item 4 Backend Runtime** by naming the deployment operator and server-side secret-custody/control owner; do not infer either assignment from the Architecture Owner / ARB acceptance in principle. Until those assignments and any final runtime authority are recorded, Items 3, 9b, 7b and 5 remain blocked/open and no implementation action is authorised. The independent 7a and 8b-residual owner decisions remain separately routed.

| Version | Date | Change |
|---|---|---|
| v1.1 | 2026-09-08 | Added this repository-backed Offline Attendance Sync authority audit to the existing blocker register. Verified `ADR-0114` as **Accepted** from current file state and commit history; recorded the dependency statuses and owner routes without changing frozen PRDs, `PRD-018`, `TASK-D10` or `IMPL-020`. |

---

## 12. Item 4 — formal governance decision brief — 2026-09-08

This brief is **decision preparation only**. It confers no runtime authority, selects no
vendor, and does not change the Item 4 status: **BLOCKED**.

| Field | Decision-ready brief |
|---|---|
| **Decision Required** | Decide and record the authoritative V1 backend/sync runtime and its deployment locus for `BC-30` Offline Sync. The decision must state whether and where queue capture, durable storage, replay and server-side credentials execute; it must not treat a candidate as approved. |
| **Scope** | Runtime/deployment authority for the V1 Offline Sync execution mechanism only. `BC-03` retains Attendance capability requirements, conflict policy, acceptance criteria and scope under `ADR-0114`; product scope, retention, retry values, at-rest mechanism and queue-depth value are not decided by this brief. |
| **Current Authority Gap** | `MASTER_PRD.md` L227 says BaaS is **not named in the EA — candidate only**. `MP-CON-02` classifies the BaaS choice as a deployment decision, not an architecture decision. The EA is descriptive; `ADR-0100` confirms engine/runtime selection remains deployment-scoped; `ADR-0045` establishes that descriptive candidates do not ratify a provider. `ADR-0114` decides capability ownership/execution context, not runtime deployment. |
| **Decision Owner** | **Architecture Owner** for D1, as already routed by the read-only `IMPL-020` preparation record. The repository does not identify a separate standing deployment selector/operator; the accepted decision must name that deployment authority and distinguish it from Architecture Owner approval. |
| **Required ADR Contents** | Accepted ADR with: (1) one-act decision authority and scope; (2) the selected runtime/deployment locus, without pre-approval in this brief; (3) Architecture Owner versus deployment-authority boundary; (4) `BC-30` execution impact and `BC-03` ownership preservation; (5) Item 3/5/9b/7b dependency consequences; (6) security/secrets and operational accountability at the authority level, without inventing mechanisms; (7) required Rank-1 record update to `MASTER_PRD` only after ADR acceptance; and (8) explicit non-effects: no `PRD-018`, frozen PRD/ADR, `TASK-D10`, `IMPL-020` or implementation change. |
| **Downstream Impact** | Acceptance removes Item 3's and Item 5's direct dependency on the unresolved runtime decision, making both eligible for their own authority/design work; it does **not** resolve either automatically. Item 9b and Item 7b remain blocked behind Item 3. `BC-30` can then be aligned to the approved execution locus without changing `ADR-0114`'s capability ownership. |
| **What Remains Blocked** | Until the follow-up runtime/deployment assignments are recorded: **Item 4 remains BLOCKED**; Item 3 remains blocked by Item 4; Item 5 remains blocked/open with no retry values; Item 9b and Item 7b remain blocked through Item 3. 7a retention and 8b-residual remain independent owner decisions. |

**Required governance path:** Architecture Owner / ARB acceptance in principle → named deployment operator and secret-custody/control owner → final runtime/deployment authority record → any necessary Rank-1 `MASTER_PRD` correction → dependency re-check. This brief itself is not an implementation approval and must not be used to start implementation.

| Version | Date | Change |
|---|---|---|
| v1.2 | 2026-09-08 | Added the Item 4 formal decision brief. Records the exact decision scope, authority gap, owner, ADR contents and dependency consequences without selecting a runtime or changing any frozen/prohibited artifact. |
| v1.3 | 2026-09-08 | Recorded `ADR-0115` as **Accepted-in-principle/Execution-blocked** based on repository evidence. Preserved the Item 4 block and explicitly recorded the deployment operator and server-side secret-custody/control owner as unassigned follow-up gaps; no runtime/vendor or implementation change was made. |
