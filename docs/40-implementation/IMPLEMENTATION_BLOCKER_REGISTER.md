# Implementation Blocker Register

| Field | Value |
|---|---|
| **Document** | Implementation Blocker Register — items that block release or block a gate, recorded but deliberately **not** implemented |
| **Version** | v1.6 |
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
| **Item 4 — Backend Runtime** | ⭐ **RESOLVED (authority + runtime)** — ⛔ **but NOT implementable.** `ADR-0115` is **Accepted** and its §8 **assigned both authority boundaries**: deployment locus → **INFRASTRUCTURE**, delivery onto it → **DEVOPS PLATFORM** (§8.2), server-side secret custody → **SECURITY PLATFORM** (§8.1). `ADR-0116` then selected the runtime: **V1 backend runtime = `Supabase`**. ⛔ **No implementation is authorised.** *(Prior text, correct until `ADR-0115` §8 and `ADR-0116`: "**BLOCKED** — `ADR-0115` is accepted in principle, but the deployment operator and server-side secret-custody owner remain unassigned follow-up gaps; no implementation is authorised.")* | `ADR-0115` §8.1/§8.2 (both owners named, under one-act conferrals); `ADR-0116` §1 (runtime selected by direct conferral of Architecture Owner authority from the human principal, the act `ADR-0115` §7 item 1 reported as missing). ⚠ `MASTER_PRD.md` **L227** still reads *"candidate only"* and is **byte-unchanged** — `ADR-0116` §6 routes any Rank-1 amendment to a **separate act requiring its own ADR**. | ⛔ **Do not implement, configure or add a dependency.** Implementation requires separately authorised work and must reach the runtime **only** through the abstract Data Layer (`MP-CON-03`), with no vendor name in domain code (`MP-CON-01`). Items 3 and 5 are now **eligible**, not resolved. |
| **Item 3 — Durable Queue** | ⛔ **OPEN — OFFICE NOW EXISTS, DECISION DOES NOT.** ⭐ `ADR-0117` constituted the **`EVENT platform`** office (one act) on 2026-09-08 — ⛔ **but expressly withheld the exercise (§4), so no durability model is authoritative.** *(Prior status, correct until `ADR-0117`: "⛔ OPEN — ELIGIBLE, NOT RESOLVED.")* *(Prior text, correct until `ADR-0116`: "**BLOCKED BY ITEM 4**" / "No approved backend/runtime authority and no authorised durability model" / "Wait for Item 4".)* | ✅ The runtime limb is no longer missing: `ADR-0116` selected **`Supabase`** and `ADR-0115` §8.2 names **INFRASTRUCTURE** as locus owner. ⛔ **But no durability model is authorised.** The *obligation* exists at Rank 1 — `MP-NFR-02` (*"at-least-once event delivery with idempotent consumers; DLQ depth is an SLO-monitored signal, not a silent bin"*) and `MP-ASM-03` — and idempotency is already specified by `ATT-INV-003` (`(studentRecordId, date, idempotencyKey)`). What is absent is a **decision**, and its Rank-1 accountable office is **`EVENT platform`** (`MP-NFR-02`). ⚠⚠ **That office is named at Rank 1 but constituted NOWHERE in `PRD_OWNERSHIP_MODEL.md`** — measured: 0 role-table row, 0 §13-style constitution. | ⛔ **Requires a one-act human-principal conferral constituting the `EVENT platform` office** (the `ADR-0102` / §13 route), then its own ADR. ⛔ No queue implementation, durability mechanism, guarantee, technology or value. `ATT-PO-011`: `BC-03` **MUST NOT** implement the queue. |
| **Item 9b — At-rest** | 🔒 **BLOCKED BEHIND ITEM 3 — unchanged by `ADR-0116`.** | Owner is **SECURITY PLATFORM** (`MP-NFR-05` *"secrets management, encryption"*; `ADR-0115` §8.1). ⚠ **A second, independent bar also stands:** `ATT-GAP-006` is **OPEN** — *"No Rank 1–5 source defines a cryptographic construction … the construction is Security Platform's. Inventing one here would be a security design, which §0.4 forbids."* So even if Item 3 landed, no at-rest mechanism could be written without that owner's act. | Re-check after Item 3; no encryption/storage policy is selected here. |
| **Item 5 — Retry/Backoff** | ⛔ **OPEN — ELIGIBLE, NOT RESOLVED.** Independent of Item 3. *(Prior text, correct until `ADR-0116`: "**BLOCKED/OPEN**" / "Re-check after Item 4".)* | ⛔ No authorised retry/backoff policy or numeric value exists. `PRD-006` **L2332** governs verbatim: *"No cooldown, frequency, quiet-hour rule, **retry count** or escalation ladder is stated for any row above, and **none may be invented**."* ⭐ **Precedent for the lawful route:** `ATT-GAP-017`'s seven valueless `ATT-CFG-*` settings were closed by **owner-supplied values** (`ADR-0021` framed them and expressly declined to decide), never by derivation. | ⛔ **Requires an owner decision supplying the values** (Architecture Owner + Product Owner), then its own ADR. ⛔ No retry count, interval, backoff, cooldown or jitter is set, derived or defaulted. |
| **Item 7b — Queue Depth** | 🔒 **BLOCKED BEHIND ITEM 3 — office now exists; act NOT YET EXERCISABLE.** ⭐ `ADR-0118` constituted the **`DATA / EVENT`** office (one act), ⚠ sequenced *"after the Item-3 durability model is authoritative"* — and it is not. *(Prior status, correct until `ADR-0118`: "🔒 BLOCKED BEHIND ITEM 3 — unchanged by `ADR-0116`.")* | Rank-1 backpressure obligation is `MP-NFR-04` (*"queues, partitioning, **backpressure**"*), whose accountable office is **`DATA / EVENT`**. ⚠⚠ **Like `EVENT platform`, `DATA` is named at Rank 1 but constituted NOWHERE in `PRD_OWNERSHIP_MODEL.md`** — measured. A depth limit is also meaningless before the queue it bounds exists (Item 3). | Re-check after Item 3; ⛔ no queue limit, high-water mark, shed policy or eviction rule is set. Requires the same office-constituting conferral as Item 3. |
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

**Primary next authorised action:** ⭐ **Item 4 is closed on both limbs** — `ADR-0115` §8 named the deployment-locus and secret-custody owners, and `ADR-0116` selected the V1 backend runtime (`Supabase`). ⛔ **No implementation action is authorised by either ADR.** The next authorised acts are the **separate, individually-conferred owner decisions** for **Item 3** (durable queue) and **Item 5** (retry/backoff) — both now **eligible, not resolved**, and `PRD-006` **L2332** still governs Item 5: *"none may be invented"*. Items 9b and 7b remain **blocked behind Item 3**. The independent **7a** and **8b-residual** owner decisions remain separately routed. ⚠ A Rank-1 `MASTER_PRD` L227 amendment is **NOT performed** and requires its own ADR (`ADR-0116` §6). *(Prior text, correct until `ADR-0115` §8 and `ADR-0116`: "complete the follow-up governed act for **Item 4 Backend Runtime** by naming the deployment operator and server-side secret-custody/control owner; do not infer either assignment from the Architecture Owner / ARB acceptance in principle. Until those assignments and any final runtime authority are recorded, Items 3, 9b, 7b and 5 remain blocked/open and no implementation action is authorised.")*

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
| **v1.6** | 2026-09-08 | ⭐⭐ **Two offices CONSTITUTED, nothing substantive decided.** `Accepted` **`ADR-0117`** constitutes **`EVENT platform`** (Rank-1 `MP-NFR-02`, `MASTER_PRD` L496) and `Accepted` **`ADR-0118`** constitutes **`DATA / EVENT`** (Rank-1 `MP-NFR-04`, L498), each **for one act only**, by direct human-principal conferral on the `ADR-0077`/`ADR-0080`/`ADR-0102` precedent. This discharges the **office-existence** limbs of §13.5 acts **1** and **2** — measured before the pass, both offices had **0** role-table rows and **0** §13-style constitutions. ⭐ **Two ADRs, not one omnibus** (`ADR-0033` §7.1; `ADR-0103`/`ADR-0104` precedent). ⛔⛔ **NEITHER DECIDES ANYTHING SUBSTANTIVE, AND THE STATUSES ARE NOT FORCED:** `ADR-0117` states **no** durability guarantee, mechanism, technology, medium, journal format, flush policy or ordering guarantee, so **Item 3 stays OPEN** — re-stated as *"office now exists, decision does not"*; `ADR-0118` states **no** depth limit, water mark, shed or eviction policy, and ⚠⚠ **its act is NOT YET EXERCISABLE** because its own conferral is sequenced *"after the Item-3 durability model is authoritative"* and that model does not exist — so **Item 7b stays BLOCKED behind Item 3**. ⚠ Unlike `ADR-0102`, which ratified a **pre-approved `99.9%`**, **no pre-approved value exists here**; each conferral **creates the capacity and withholds the exercise**. ⭐ §13.5 updated: acts 1 and 2 struck through as DONE and **two NEW acts 1a / 2a added** — *exercise* the constituted authorities, with 2a blocked until 1a lands. ⛔ **9b, 5, 7a and 8b-residual untouched.** ⛔ No standing authority; both offices **VACANT** outside their acts; no person named (`PRD_OWNERSHIP_MODEL.md` §7 rule 4). ⛔ `ADR-0115`, `ADR-0116`, `MASTER_PRD`, `PRD-006`, all frozen PRDs, BC Map, `E-24` and `DOCUMENTATION_BASELINE.md` **byte-unchanged**; `PRD-018` not created; **0** `IMPL-*`, **0** `SYNC-*`, **0** code/config files. |
| **v1.5** | 2026-09-08 | ⭐ **Post-`ADR-0116` complete blockers audit. Corrected ONLY the statements `ADR-0116` made stale; every prior text is retained verbatim in parentheses.** ⭐ **Items 3 and 5 re-stated from "BLOCKED" to ⛔ `OPEN — ELIGIBLE, NOT RESOLVED`** — the v1.4 changelog had disclosed this residual staleness and routed it to a separate act; **this is that act.** Item 3's row no longer claims *"No approved backend/runtime authority"* (false since `ADR-0116`) and Item 5's no longer says *"Re-check after Item 4"*. ⚠⚠ **THE AUDIT'S PRINCIPAL FINDING, AND IT IS A STOP:** Items 3 and 7b are accountable to the Rank-1 offices **`EVENT platform`** (`MP-NFR-02`) and **`DATA / EVENT`** (`MP-NFR-04`) — and **both are named at Rank 1 but constituted NOWHERE in `PRD_OWNERSHIP_MODEL.md`** (measured: 0 role-table rows, 0 §13-style constitutions). This is exactly the condition `ADR-0102` / §13 addressed for `SRE / Observability`, which was *"defined nowhere"* until constituted by explicit human-principal words. ⛔ **Those conferrals are therefore ABSENT and are NOT fabricated here.** ⭐ **Item 9b gains a SECOND independent bar, newly surfaced:** beyond its Item-3 dependency, `ATT-GAP-006` is **OPEN** — *"the construction is Security Platform's. Inventing one here would be a security design, which §0.4 forbids"* — so at-rest could not be written even if Item 3 landed. ⛔ **7a retention and 8b-residual are UNCHANGED and remain independent owner decisions** (see §13). ⭐ **`MASTER_PRD` L227 determined to need NO amendment (§13.3), on measured precedent rather than preference:** L232's Payments row has read *"candidate only"* since 2026-08-02 and `ADR-0046` (2026-08-16) selected Razorpay **without ever amending it**, so an unamended Rank-1 candidate cell beside an accepted vendor selection is an **already-ratified state**. ⛔ **NOTHING INVENTED:** no retry count, delay, backoff, queue limit, depth, retention period, encryption algorithm, storage format, schema or credential. ⛔ **NO IMPLEMENTATION AUTHORITY EXISTS OR IS RECORDED** — 0 code/config/dependency files touched; `PRD-006`, `MASTER_PRD`, `ADR-0114`/`0115`/`0116` and all frozen PRDs byte-unchanged; `PRD-018` still unwritten; 0 `SYNC-*`; 0 new `IMPL-*`. |
| v1.4 | 2026-09-08 | ⭐ **Corrected the two STALE Item-4 statements only** — the §11.2 `Item 4` row and the *Primary next authorised action* paragraph, both of which still said the deployment operator and server-side secret-custody owner *"remain unassigned follow-up gaps"*. `ADR-0115` §8 had already resolved both (locus → **INFRASTRUCTURE**, delivery → **DEVOPS PLATFORM**, secret custody → **SECURITY PLATFORM**), and `ADR-0116` then selected the runtime: **V1 backend runtime = `Supabase`**. Item 4 is therefore recorded **RESOLVED on both limbs**. ⭐ **Prior text of both statements is retained verbatim in parentheses**, not deleted. ⛔ **No implementation authority is recorded and none exists** — no Supabase implementation or configuration, no cloud resource, no schema, no dependency, no durable queue, queue depth, retry count, backoff, retention, encryption algorithm or secret format; `PRD-006` byte-unchanged; `PRD-018` still unwritten; **0** new `IMPL-*`/`SYNC-*` identifiers. ⚠⚠ **A RESIDUAL STALENESS IS DISCLOSED RATHER THAN SILENTLY FIXED:** the §11.2 **`Item 3`** row still reads *"**BLOCKED BY ITEM 4**"* / *"No approved backend/runtime authority"*, and the **`Item 5`** row still says *"Re-check after Item 4"* — both now inaccurate, since Items 3 and 5 are **eligible, not blocked** (`ADR-0115` §9, `ADR-0116` §7). ⛔ **They were deliberately NOT edited**, because the authorising instruction was expressly limited to *"only the stale Item-4 statements saying deployment operator and secret-custody owner are unassigned"* and adding *"do not invent any further authority"*; re-statusing Items 3 and 5 in this register would assert a dependency ruling outside the conferred act. **Routed as a separate act.** ⚠ The §12 decision brief is likewise left verbatim as a historical record of the pre-decision state. ⚠ `MASTER_PRD` **L227** is **byte-unchanged** and its Rank-1 amendment is **not** performed (`ADR-0116` §6). |
| v1.3 | 2026-09-08 | Recorded `ADR-0115` as **Accepted-in-principle/Execution-blocked** based on repository evidence. Preserved the Item 4 block and explicitly recorded the deployment operator and server-side secret-custody/control owner as unassigned follow-up gaps; no runtime/vendor or implementation change was made. |

---

## 13. Complete remaining-blockers audit — post-`ADR-0116` — 2026-09-08

**This section is an AUDIT RECORD. It confers no authority, selects no value and authorises no
implementation.** Recorded by APPEND so that no existing line of this register moves.

⛔ **Item 4 being RESOLVED does NOT resolve anything downstream.** Each item below was tested on its
own evidence, and most remain OPEN or BLOCKED. **Six of eight are not closable from existing authority.**

### 13.1 Per-item determination

| Item | Status | Existing authoritative requirement | Accountable office | Decision exists? | Extra one-act conferral required? | Implementation authorised? |
|---|---|---|---|---|---|---|
| **3 — Durable Queue** | ⛔ OPEN — eligible | `MP-NFR-02` at-least-once + idempotent consumers + DLQ; `MP-ASM-03`; `ATT-INV-003` idempotency key | **`EVENT platform`** (`MP-NFR-02`) | ❌ No | ⚠ **YES — the office is not constituted** | ⛔ No |
| **5 — Retry/Backoff** | ⛔ OPEN — eligible | `PRD-006` **L2332** — *"none may be invented"* | Architecture Owner + Product Owner | ❌ No | ⚠ **YES — values must be owner-supplied** | ⛔ No |
| **9b — Device at-rest** | 🔒 BLOCKED behind Item 3 | `MP-NFR-05` encryption; **`ATT-GAP-006` OPEN** | **SECURITY PLATFORM** | ❌ No | ⚠ YES, and Item 3 first | ⛔ No |
| **7b — Queue depth** | 🔒 BLOCKED behind Item 3 | `MP-NFR-04` backpressure | **`DATA / EVENT`** | ❌ No | ⚠ **YES — the office is not constituted** | ⛔ No |
| **7a — Retention** | ⛔ OPEN — independent | BC Map **`Q-04`** open; `ATT-GAP-005`; `MP-NFR-10` | **Legal counsel + Architecture Owner** (`MP-NFR-10`: SECURITY + DATA Governance) | ❌ No | ⚠ YES | ⛔ No |
| **8b-residual** | ⚠ REQUIRES OWNER DECISION — independent | `AUTH-8.38`, `BR-7.1`, `ATT-INV-008`, `ATT-FR-015` | **Product Owner + `BC-03` Domain Owner** | ⚠ **Partly — see §13.2** | ⚠ YES for the residue | ⛔ No |
| **7 — `MASTER_PRD` L227** | ✅ **NO AMENDMENT REQUIRED** | §13.3 | — | ✅ Yes, by precedent | ❌ **No** | n/a |
| **8 — Stale register text** | ✅ **CORRECTED in v1.5** | v1.4 changelog routing | Technical Owner | ✅ Yes | ❌ No | n/a |

### 13.2 ⚠ Items 3 and 7b — the audit's principal STOP

`MP-NFR-02` assigns reliability to **`EVENT platform`** and `MP-NFR-04` assigns backpressure to
**`DATA / EVENT`**. Both are **Rank 1** assignments. Measured against `PRD_OWNERSHIP_MODEL.md`:
**neither office has a role-table row, and neither has a §13-style constitution.**

⭐ This is precisely the condition `ADR-0102` and §13 met for `SRE / Observability`, which §13.1 records
was **"defined nowhere"** despite three Rank-1 obligations naming it, and which required *"direct
conferral from the human principal"* to act even once. ⛔ **The same is therefore true here, and the
conferrals are ABSENT.** They are **not fabricated**, and Items 3 and 7b are **not** marked resolved.

⚠ **The distinction that matters:** Item 3's *obligation* is already Rank-1 law and its *idempotency*
half is already specified (`ATT-INV-003`). What is missing is a **durability decision** and an **office
constituted to make it**. Recording the obligation as though it were the decision would be the exact
error `ADR-0045` §2 refused.

### 13.3 ⭐ Item 7 — `MASTER_PRD` L227 needs no amendment, on measured precedent

`MASTER_PRD.md` **L227** still reads *"**Not named in EA** — candidate only"* after `ADR-0116` selected
`Supabase`. Tested against the nearest precedent rather than assumed:

| Measurement | Result |
|---|---|
| `MASTER_PRD` **L232** (Payments row) | Reads *"**Not named in EA** — candidate only"* — **today, at HEAD** |
| `ADR-0046` — *"The V1 payment gateway provider is **Razorpay**"* | **`ACCEPTED`**, committed `4006f0f`, 2026-08-16 |
| Has L232 been amended since? | ❌ **No.** `git log -L232,232` shows its only commit is `218142a`, **2026-08-02** — *before* `ADR-0046` |
| `ADR-0046` `Does NOT amend` row | Lists **`MASTER_PRD.md` (Rank 1)** explicitly |

⭐ **So an unamended Rank-1 *"candidate only"* cell sitting beside an `Accepted` vendor selection is an
ALREADY-RATIFIED STATE in this repository** — sustained for over three weeks across many governance
passes — **not a defect `ADR-0116` created.** `MASTER_PRD` §10's preamble supplies the reason: vendors
are *"recorded as candidate implementations behind ports"*, so the cell describes the **abstraction
contract**, and the ADR records the **selection**. They are not in conflict.

⛔ **No Rank-1 amendment is performed and none is asserted to be required.** Should a future authority
decide otherwise, `DOCUMENTATION_BASELINE.md` §7 rule 1 requires **an ADR before the change**, plus
rule 2 (version + changelog in the same commit) and rule 4 (a new baseline identifier, L227 being
Rank 1). **Owner: Architecture Owner + Governance Owner. Requires its own conferral.**

### 13.4 Item 8b-residual — what is settled and what is not

✅ **SETTLED, and preserved unchanged:** replay is a **fresh authorization decision**; revoked or
expired access **cannot be silently carried forward**. `AUTH-8.38` — *"A session MUST NOT carry
authorization; authorization MUST be evaluated at the moment of each decision"* — with `BR-7.1`,
`AC-7.1`, `AUTH-6.57`, `AUTH-5.23` (all FROZEN `PRD-001`).

✅ **ALSO SETTLED:** already-**stored** facts are safe. `ATT-INV-008` — *"No stored attendance fact
**SHALL** be destructively updated or deleted"* (`ATT-AC-149`), and `ATT-FR-015` makes revocation
**forward-acting**. ⚠ `ATT-FR-016` is **QR-scoped, not actor-scoped**, and is **not** stretched here.

⛔ **THE RESIDUE IS UNRESOLVED AND IS NOT INVENTED:** what becomes of a **legitimately captured**
offline mutation whose actor's access is revoked or expired **before** replay. Measured: a repository
sweep for a queued-item disposition on revoked access returns **ZERO** authority. The three candidate
dispositions — admit as a historical fact, refuse and discard, or refuse-and-retain-as-an-audit-bearing
rejection — are **materially different product decisions**, and choosing among them here would invent
policy. **Owner: Product Owner + `BC-03` Domain Owner. Requires their decision, then its own ADR.**

### 13.5 Required acts, stated exactly — ⛔ NONE has occurred

⛔ **The following are the REQUIRED acts. No claim is made that any took place.** Next free ADR
identifier, derived mechanically: **`ADR-0117`** (104 files, highest identifier `ADR-0115`→`ADR-0116`;
`ADR-0117` has 0 files and 0 references). ⛔ **No ADR is created until the authority exists.**

| # | Act required | From whom |
|---|---|---|
| 1 | ~~**Constitute the `EVENT platform` office for one act**~~ — ✅ **DONE 2026-09-08 by `Accepted` `ADR-0117`** (office constituted; `PRD_OWNERSHIP_MODEL.md` §14). ⛔ **The durability model itself is STILL NOT DECIDED** — `ADR-0117` §4 withheld the exercise, so **Item 3 remains OPEN**. **Superseded by act 1a below.** | Human principal |
| **1a** | ⭐ **NEW — EXERCISE the `EVENT platform` one-act authority**: decide and record the `BC-30` Offline Sync durable-queue durability model. ⛔ No pre-approved value exists in the repository, so the model must be **supplied**, not derived. Requires its own governance record | **`EVENT platform`** (constituted, `ADR-0117`) |
| 2 | ~~**Constitute the `DATA / EVENT` office for one act**~~ — ✅ **DONE 2026-09-08 by `Accepted` `ADR-0118`** (office constituted; `PRD_OWNERSHIP_MODEL.md` §15). ⛔ **No queue-depth value is decided**, and ⚠⚠ **the act is NOT YET EXERCISABLE** — its own conferral is sequenced *"after the Item-3 durability model is authoritative"*, and that model does not exist. **Superseded by act 2a below.** | Human principal |
| **2a** | ⭐ **NEW — EXERCISE the `DATA / EVENT` one-act authority**: decide and record the queue-depth / backpressure bound. ⚠ **BLOCKED until act 1a lands** — a bound on a queue with no agreed durability model would be a number with no referent | **`DATA / EVENT`** (constituted, `ADR-0118`) |
| 3 | **Supply the retry/backoff values** (Item 5) — `PRD-006` L2332 forbids invention; the `ATT-GAP-017` precedent is owner-supplied values | Architecture Owner + Product Owner |
| 4 | **Decide the at-rest construction** (Item 9b) — `ATT-GAP-006`. Item 3 first | SECURITY PLATFORM |
| 5 | **Ratify a retention period** (7a) — `Q-04` is open in the authoritative document; `ATT-GAP-005` bars promoting its unratified note | Legal counsel + Architecture Owner |
| 6 | **Decide the queued-mutation disposition on revoked/expired access** (8b-residual) | Product Owner + `BC-03` Domain Owner |

⛔ **Every act above is ONE ACT ONLY and NONE is a standing licence** (`ADR-0033` §7.1). ⛔ No holder is
appointed and no personal name is recorded (`PRD_OWNERSHIP_MODEL.md` §7 rule 4).
