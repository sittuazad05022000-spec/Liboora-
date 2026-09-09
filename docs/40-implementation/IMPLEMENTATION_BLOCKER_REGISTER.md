# Implementation Blocker Register

| Field | Value |
|---|---|
| **Document** | Implementation Blocker Register — items that block release or block a gate, recorded but deliberately **not** implemented |
| **Version** | v1.14 |
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
| `BLK-02` | `IMPL-020` — SMS provider integration + DLT registration | **P0** | Code **+ multi-week external dependency** | **Every release** · `BLK-01` (except step `D10-4`) · `IT-1` staff invitations | ⚠ **OPEN — 1 of 3 limbs DISCHARGED.** ⭐ **Backend runtime SELECTED** by `Accepted` **`ADR-0124`** (Architecture Owner, one-act): `IMPL-020` §2.1 **Option A** — a managed **BaaS, `Supabase`**, hosting the OTP delivery adapter as an **adapter behind a port, never as a layer** (`MP-CON-03`, `MASTER_PRD` L271). ⛔ **STILL OPEN: (a) DLT template registration** — Rank 1 `MP-DEP-03`, **External**, *"the only item whose duration the team cannot compress"*; **(b) SMS provider selection** — ⭐ low urgency, `IMPL-020` §1.3 measures **PROVIDER DECISION 0** of 11 obligations. ⛔ **No implementation authority.** *(Prior status, correct until `ADR-0124`: "⬜ **OPEN — not started**".)* |
| `BLK-03` | `IMPL-220` — boundary enforcement of `SID-INT-1`…`SID-INT-12` | P0 | Code (checker categories) | Nothing ships-blocking; leaves 12 rules **unmet** per `SID-4.56` | ⚠ **OPEN — SPECIFICATION GAP CLOSED, implementation NOT done.** ⭐ `Accepted` **`ADR-0125`** (Architecture Owner + `BC-10` Domain Owner, one-act) records **`SID-DET-5`, `-6`, `-8`, `-9`, `-10`, `-11`** — the six rules that previously had no mechanical criterion. ⛔ **`BLK-03` IS NOT CLOSED and no rule is "satisfied"** — `SID-4.56` still counts **all twelve as unmet** until the checks *run*; ⭐ **a detection criterion is not a check**. ⚠ **TWO PREREQUISITE ARTIFACTS DO NOT YET EXIST** (`ADR-0125` §9.1): **A1** a per-context table/index name inventory (**Architecture Owner**) and **A2** a machine-readable index-field declaration for `domain/person` (**`BC-10` Domain Owner + Architecture Owner**) — so **`SID-DET-10` is well-defined but not yet executable**. ⚠ A separate labelling act would make `SID-INT-1`/`-2`/`-3`/`-4`/`-7` **independently identifiable** — they already fire but report under `ID-2`/`X-05`/`X-04`/`L2`. *(Prior status, correct until `ADR-0125`: "⬜ **OPEN — unblocked**".)* |
| `BLK-04` | `GCP-02` — branch protection cannot be enabled | — | GitHub plan + workflow structure | Nothing technically; leaves gates **advisory, not enforced** | ⬜ **OPEN — externally blocked** |
| `BLK-05` | `PRD-012a` not opened | — | Documentation (a PRD must be written) | Retirement of `PRD-012`; `PRD-012` remains unassignable | ⭐⭐ **CLOSED — STALE TEXT, THE WORK WAS ALREADY DONE.** ⛔ **This row was FALSE, not merely out of date.** Measured at `192a153`: **14** `PRD-012a*` files exist under `docs/30-product/security/`; `PRD_REGISTRY.md` **L250** records `PRD-012a` **`FROZEN`**; **L249** records `PRD-012` **`RETIRED` — 2026-08-21**, *"Retired **on the day `PRD-012a` was opened**"*; `DOCUMENTATION_BASELINE.md` **L198** carries it at **v0.8** as *"Authoritative — the Security Automation baseline"*; and `Accepted` **`ADR-0064`**'s `Closes` row states *"registry `PLANNED` → `FROZEN`; **retires `PRD-012`**"*. ⭐ The row's own closing condition — `PRD-012a` being **opened** — was therefore satisfied on **2026-08-21**, and this register simply never recorded it. ⛔ **No ADR was required and none was created:** this document is **Unranked** (§ header — *"Editable without an ADR"*), and the governing decision (`ADR-0064`) was **already Accepted**; nothing is decided here. *(Prior status, stale since 2026-08-21: "⬜ **OPEN — authorized, not executed**".)* |

**Five rows. `BLK-05` is now CLOSED, so FOUR remain — and only two of those are release blockers.** The
distinction matters. `BLK-01` and `BLK-02` stop a release. `BLK-03` and `BLK-04` weaken enforcement without
stopping anything, which makes them the more likely to be quietly forgotten.

⚠⚠ **`BLK-05` was CLOSED on 2026-09-08 as a stale-text correction, not as new work** — its condition had been
satisfied since **2026-08-21** and this register never recorded it. ⭐ **That is the more useful lesson than the
closure itself:** a blocker register that is only ever appended to will over-report, and an over-reported
blocker costs exactly as much attention as a real one. *(Prior text, retained verbatim and correct until
2026-08-21: "**Five rows, and only two of them are release blockers.** The distinction matters. `BLK-01` and
`BLK-02` stop a release. `BLK-03` and `BLK-04` weaken enforcement without stopping anything, which makes them
the more likely to be quietly forgotten. `BLK-05` is a documentation task that the Governance Closure Phase was
explicitly forbidden to execute.")*

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

⭐⭐ **CLOSED 2026-09-08 — and the honest finding is that this row was FALSE, not merely stale.** The split's
executing half was performed on **2026-08-21**: `PRD-012a` was authored as **8 Parts at v0.8** (**14** files
under `docs/30-product/security/`), admitted at **Rank 3** by `Accepted` **`ADR-0064`** — whose `Closes` row
reads *"registry `PLANNED` → `FROZEN`; **retires `PRD-012`**"* — and `PRD_REGISTRY.md` **L249** now records
`PRD-012` as **`RETIRED` — 2026-08-21**, *"Retired **on the day `PRD-012a` was opened**, exactly as §8 rule 1
… prescribes; **the number is NOT reused.**"*

⭐ **So §8 rule 1's condition was satisfied and this register never recorded it.** The closure below is a
**mechanical correction**, not new work, and **no ADR was created**: this document is **Unranked**
(*"Editable without an ADR"*) and the governing decision was already `Accepted`.

⚠ **One consequence is NOT claimed as closed.** `PRD-012`'s *unassignability* under the one-holder-per-role
rule is a separate finding recorded in `PRD_REGISTRY.md` §7 and `PRD_OWNERSHIP_MODEL.md`; ⛔ **this closure does
not touch it**, and `PRD-012b` (Workflow Orchestration, **V2**) remains **reserved and unwritten**.

⚠⚠ **A SECOND STALENESS IS DISCLOSED HERE RATHER THAN REPAIRED.** `PRD_GAP_ANALYSIS.md` still describes
**`PGA-06`** as *"**split CONFIRMED** 2026-08-04, **not yet executed**"* (**L44**) and as *"Confirmed only, not
executed — remains open"* (**L465**), across **7** separate statements (**L44**, **L302**, **L431**, **L449**,
**L465**, **L467**, **L481**). ⭐ On the evidence above, the *executing* half **did** occur on 2026-08-21.
⛔ **It is NOT repaired in this pass**, for two measured reasons: (1) it is a **different document** with its own
changelog discipline, and **8** line-citations point into it, so a multi-site edit risks shifting them; (2) the
`PGA-06` entry is **compound** — its *split* limb is executed, but its **`PRD-012b` (V2)** limb and the
**unassignability** finding are genuinely still open, so a blanket "closed" would be **as false as the current
text**. ⭐ Recorded as a **separate, smaller act** for the **Governance Owner**.

> *(Prior text, retained verbatim and correct until 2026-08-21:)* The split of `PRD-012` into `PRD-012a`
> (Security Automation) and `PRD-012b` (Workflow Orchestration, V2) is **confirmed and authorized**. It is
> **not executed**, because executing it means writing `PRD-012a` — and `PRD_REGISTRY.md` §8 rule 1 ties
> `PRD-012`'s retirement to `PRD-012a` being *opened*. **Confirmation is not execution.** `PGA-06` is recorded
> as *confirmed, execution pending* rather than closed, because marking it closed would fabricate progress that
> no document supports.

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
| **8b-residual — revoked/expired actor before replay** | ⭐⭐ **RESOLVED.** ⛔ **RESOLVED IS NOT IMPLEMENTABLE.** Closed by `Accepted` **`ADR-0123`** (Product Owner + `BC-03` Domain Owner, one-act): **`EVT-AUTHZ-1`** the **original capture timestamp remains the attendance time**; **`EVT-AUTHZ-2`** replay/sync, Wi-Fi connection, Presence observation and retry time **MUST NOT** replace or rewrite it; **`EVT-AUTHZ-3`** a later Presence observation or attendance attempt **MUST NOT automatically create a duplicate** where a valid attendance exists; **`EVT-AUTHZ-4`** **no silent discard** when the actor is unauthorized at replay; **`EVT-AUTHZ-5`** **retain as an audit-bearing rejected mutation and surface for explicit/manual resolution**; **`EVT-AUTHZ-6`** this constitutes the explicit resolution/disposal path for `EVT-PERS-1`, `EVT-DEPTH-2` and `EVT-RETRY-3` **only to the extent necessary for this exact scenario**. ⭐⭐ **This is candidate 3 — *refuse but retain as an audit-bearing rejection*** — ⛔ candidates 1, 2 and 4 were **not** selected. ⭐ Verified to **SATISFY** `ADR-0119` **D-4** on a **different trigger** from `EVT-RETRY-3` (authorization refusal, which retrying cannot cure), to be **consistent** with `ADR-0120` `EVT-PERS-1` and `ADR-0121` `EVT-DEPTH-1`/`-2`, and to **CONFIRM** frozen `ATT-FR-088`/`ATT-FR-089`/`ATT-INV-003`/`ATT-FR-019` rather than add to them. ⭐ Authorization authority **preserved unweakened** — `PRD-001` refuses the **operation**; `ADR-0123` governs the **queued data** after that refusal. ⚠ The **general** disposal route (non-authorization causes) and **where** the rejected-mutation record lives remain **undefined and disclosed** (`ADR-0123` §3.2). *(Prior status, correct until `ADR-0123`: "**REQUIRES OWNER DECISION** — no authoritative queued-item disposition or audit-bearing treatment found.")* | `PRD-001` requires current-state authorisation and refusal when access is not allowed. Frozen `PRD-006` defines idempotency/correction preservation, but does not decide discard/reject versus an audit-bearing treatment for this residual. | Product Owner + BC-03 Domain Owner decision; ADR-first if frozen authority must change. ⭐ **The decision was CONFERRED and is now recorded in `ADR-0123`** — ⛔ no frozen authority changed, `PRD-006` byte-unchanged. |
| **Item 4 — Backend Runtime** | ⭐ **RESOLVED (authority + runtime)** — ⛔ **but NOT implementable.** `ADR-0115` is **Accepted** and its §8 **assigned both authority boundaries**: deployment locus → **INFRASTRUCTURE**, delivery onto it → **DEVOPS PLATFORM** (§8.2), server-side secret custody → **SECURITY PLATFORM** (§8.1). `ADR-0116` then selected the runtime: **V1 backend runtime = `Supabase`**. ⛔ **No implementation is authorised.** *(Prior text, correct until `ADR-0115` §8 and `ADR-0116`: "**BLOCKED** — `ADR-0115` is accepted in principle, but the deployment operator and server-side secret-custody owner remain unassigned follow-up gaps; no implementation is authorised.")* | `ADR-0115` §8.1/§8.2 (both owners named, under one-act conferrals); `ADR-0116` §1 (runtime selected by direct conferral of Architecture Owner authority from the human principal, the act `ADR-0115` §7 item 1 reported as missing). ⚠ `MASTER_PRD.md` **L227** still reads *"candidate only"* and is **byte-unchanged** — `ADR-0116` §6 routes any Rank-1 amendment to a **separate act requiring its own ADR**. | ⛔ **Do not implement, configure or add a dependency.** Implementation requires separately authorised work and must reach the runtime **only** through the abstract Data Layer (`MP-CON-03`), with no vendor name in domain code (`MP-CON-01`). Items 3 and 5 are now **eligible**, not resolved. |
| **Item 3 — Durable Queue** | ⭐⭐ **RESOLVED — both limbs authoritative.** ⛔ **RESOLVED IS NOT IMPLEMENTABLE — no implementation authority exists.** Persistence limb closed by `Accepted` **`ADR-0120`** (`EVT-GAP-001` **CLOSED**), which records **`EVT-PERS-1`** verbatim: *"A captured offline attendance mutation MUST be durably persisted at capture and MUST survive process death, force-stop and device reboot until it is either replayed or explicitly disposed of."* ⚠ Its *"explicitly disposed of"* limb is **undefined** — substantially the **8b-residual** question, **not** pre-judged. *(Prior status, correct until `ADR-0120`: "⚠ PARTIALLY CLOSED — replay semantics RATIFIED; persistence limb OPEN as `EVT-GAP-001`.")* ⭐ `ADR-0119` (the `EVENT platform` office's exercise of the `ADR-0117` act) ratified four properties, each quoted from binding authority: **D-1** at-least-once + idempotent absorption, **D-2** the `(studentRecordId, date, idempotencyKey)` key, **D-3** ordering by the platform time port, **D-4** no silent discard. ⛔ **NOT fully resolved** — `EVT-GAP-001` leaves client-side **persistence across process death / reboot** and the storage medium **UNSPECIFIED**. *(Prior status, correct until `ADR-0119`: "⛔ OPEN — OFFICE NOW EXISTS, DECISION DOES NOT.")* ⭐ `ADR-0117` constituted the **`EVENT platform`** office (one act) on 2026-09-08 — ⛔ **but expressly withheld the exercise (§4), so no durability model is authoritative.** *(Prior status, correct until `ADR-0117`: "⛔ OPEN — ELIGIBLE, NOT RESOLVED.")* *(Prior text, correct until `ADR-0116`: "**BLOCKED BY ITEM 4**" / "No approved backend/runtime authority and no authorised durability model" / "Wait for Item 4".)* | ✅ The runtime limb is no longer missing: `ADR-0116` selected **`Supabase`** and `ADR-0115` §8.2 names **INFRASTRUCTURE** as locus owner. ⛔ **But no durability model is authorised.** The *obligation* exists at Rank 1 — `MP-NFR-02` (*"at-least-once event delivery with idempotent consumers; DLQ depth is an SLO-monitored signal, not a silent bin"*) and `MP-ASM-03` — and idempotency is already specified by `ATT-INV-003` (`(studentRecordId, date, idempotencyKey)`). What is absent is a **decision**, and its Rank-1 accountable office is **`EVENT platform`** (`MP-NFR-02`). ⚠⚠ **That office is named at Rank 1 but constituted NOWHERE in `PRD_OWNERSHIP_MODEL.md`** — measured: 0 role-table row, 0 §13-style constitution. | ⛔ **Requires a one-act human-principal conferral constituting the `EVENT platform` office** (the `ADR-0102` / §13 route), then its own ADR. ⛔ No queue implementation, durability mechanism, guarantee, technology or value. `ATT-PO-011`: `BC-03` **MUST NOT** implement the queue. |
| **Item 9b — At-rest** | ⛔ **OPEN — ELIGIBLE, NOT RESOLVED.** ⭐ `ADR-0120` closed `EVT-GAP-001`, so **Item 3 no longer blocks it** and `EVT-PERS-1` gives it a subject. ⛔ **But `ATT-GAP-006` remains OPEN**: *"the construction is Security Platform's. Inventing one here would be a security design, which §0.4 forbids."* *(Prior status: "🔒 BLOCKED — now behind `EVT-GAP-001` as well.")* ⚠ `ADR-0119` leaves the persistence medium unspecified, so **there is nothing agreed to protect at rest**; this is in addition to the pre-existing bar. *(Prior status: "🔒 BLOCKED BEHIND ITEM 3 — unchanged by `ADR-0116`.")* | Owner is **SECURITY PLATFORM** (`MP-NFR-05` *"secrets management, encryption"*; `ADR-0115` §8.1). ⚠ **A second, independent bar also stands:** `ATT-GAP-006` is **OPEN** — *"No Rank 1–5 source defines a cryptographic construction … the construction is Security Platform's. Inventing one here would be a security design, which §0.4 forbids."* So even if Item 3 landed, no at-rest mechanism could be written without that owner's act. | Re-check after Item 3; no encryption/storage policy is selected here. |
| **Item 5 — Retry/Backoff** | ⭐⭐ **RESOLVED.** ⛔ **RESOLVED IS NOT IMPLEMENTABLE.** Closed by `Accepted` **`ADR-0122`** (Architecture Owner + Product Owner, one-act): **`EVT-RETRY-1`** limit = **5 attempts**; **`EVT-RETRY-2`** backoff = **exponential 1, 2, 4, 8, 16 minutes**; **`EVT-RETRY-3`** on exhaustion **retain as terminal-failed and surface for explicit/manual resolution, with no silent discard**; **`EVT-RETRY-4`** the **original attendance capture timestamp is preserved** — replay time **MUST NOT** replace it. ⭐ Verified to **SATISFY** `ADR-0119` **D-4** (which was a prohibition without a mechanism) and to be **consistent** with `ADR-0120` `EVT-PERS-1` and `ADR-0121` `EVT-DEPTH-1`/`-2`. ⚠ Its *"explicit/manual resolution"* limb is **undefined** — the **8b-residual** question, **not** pre-judged. *(Prior status, correct until `ADR-0122`: "⛔ OPEN — ELIGIBLE, NOT RESOLVED. Independent of Item 3.")* *(Prior text, correct until `ADR-0116`: "**BLOCKED/OPEN**" / "Re-check after Item 4".)* | ⛔ No authorised retry/backoff policy or numeric value exists. `PRD-006` **L2332** governs verbatim: *"No cooldown, frequency, quiet-hour rule, **retry count** or escalation ladder is stated for any row above, and **none may be invented**."* ⭐ **Precedent for the lawful route:** `ATT-GAP-017`'s seven valueless `ATT-CFG-*` settings were closed by **owner-supplied values** (`ADR-0021` framed them and expressly declined to decide), never by derivation. | ⛔ **Requires an owner decision supplying the values** (Architecture Owner + Product Owner), then its own ADR. ⛔ No retry count, interval, backoff, cooldown or jitter is set, derived or defaulted. |
| **Item 7b — Queue Depth** | ⭐⭐ **RESOLVED.** ⛔ **RESOLVED IS NOT IMPLEMENTABLE.** Closed by `Accepted` **`ADR-0121`**, the first and only exercise of `ADR-0118`'s act: **`EVT-DEPTH-1`** — bound = **500 queued offline attendance mutations per device**; **`EVT-DEPTH-2`** — on reaching it the system **MUST block new offline captures while preserving all already-captured queued mutations until replay or explicitly authorized disposal**. ⭐ Verified **consistent** with `ADR-0119` **D-4** (*no silent discard*) and `ADR-0120` **`EVT-PERS-1`** — block-and-preserve, never discard. ⚠ Its *"explicitly authorized disposal"* limb is **undefined** — the **8b-residual** question, **not** pre-judged. *(Prior status, correct until `ADR-0121`: "🔒 BLOCKED — office exists, act UNSPENT, and NO VALUE EXISTS TO RATIFY.")* ⛔ `ADR-0119` §5.1 measured **0** queue-depth limits, water marks, shed policies or eviction rules for `BC-30` in any Rank 1–5 document: `MP-NFR-04` supplies the **obligation** and no value, and the EA's nearest line — *"Realtime Scaling & Backpressure"* — is tagged **V3** and concerns the **realtime engine**, not the V1 offline queue (Rank 6, descriptive). Exercising `ADR-0118`'s act now would **invent a number**, so it was not exercised and **remains available**. *(Prior status: "🔒 BLOCKED BEHIND ITEM 3 — office now exists; act NOT YET EXERCISABLE.")* ⭐ `ADR-0118` constituted the **`DATA / EVENT`** office (one act), ⚠ sequenced *"after the Item-3 durability model is authoritative"* — and it is not. *(Prior status, correct until `ADR-0118`: "🔒 BLOCKED BEHIND ITEM 3 — unchanged by `ADR-0116`.")* | Rank-1 backpressure obligation is `MP-NFR-04` (*"queues, partitioning, **backpressure**"*), whose accountable office is **`DATA / EVENT`**. ⚠⚠ **Like `EVENT platform`, `DATA` is named at Rank 1 but constituted NOWHERE in `PRD_OWNERSHIP_MODEL.md`** — measured. A depth limit is also meaningless before the queue it bounds exists (Item 3). | Re-check after Item 3; ⛔ no queue limit, high-water mark, shed policy or eviction rule is set. Requires the same office-constituting conferral as Item 3. |
| **PRD-018** | **NO-PRD decision unchanged**. | Accepted `ADR-0114` records Attendance-only capability scope; `PRD-018` is not to be written and remains `PLANNED` in the registry. | Do not create or revive `PRD-018`. |
| **TASK-D10 / IMPL-020** | **UNTOUCHED**. | This audit does not modify either artifact or perform either implementation. | Keep untouched. |

The dependency graph is therefore:

```text
Item 4 Backend Runtime ──► Item 3 Durable Queue ──► Item 9b At-rest ──► Item 7b Queue Depth
          │
          └──────────────► Item 5 Retry/Backoff

7a Retention                 (independent; OPEN)
8b-residual                 (independent; RESOLVED -- ADR-0123)
```

**Primary next authorised action:** ⭐⭐ **ALL FIVE Offline-Sync owner decisions are now RESOLVED** — Item 4 (`ADR-0115` §8, `ADR-0116`), Item 3 (`ADR-0119`, `ADR-0120`), Item 7b (`ADR-0121`), Item 5 (`ADR-0122`) and **8b-residual (`ADR-0123`)**. ⛔⛔ **AND NOT ONE OF THEM IS IMPLEMENTABLE — no implementation authority exists or is recorded by any of them.** The remaining authorised acts are the **two separate, individually-conferred owner decisions** that stay open: **Item 9b** at-rest construction — barred by **OPEN `ATT-GAP-006`**, owner **SECURITY PLATFORM** — and **Item 7a** retention period — `Q-04` open, owner **Legal counsel + Architecture Owner**, and ⭐ a retention *disposition* (now recorded) is **not** a retention *period*. ⚠ Three residues are **disclosed, not resolved**: (1) the **general** disposal/resolution route beyond `ADR-0123`'s scoped scenario; (2) **where** an audit-bearing rejected mutation lives, given `ATT-FR-130` vs `ATT-FR-129`/`E-20`; (3) a Rank-1 `MASTER_PRD` **L227** amendment is **NOT performed** and would require its own ADR (`ADR-0116` §6). *(Prior text, correct until `ADR-0123`: "⭐ **Item 4 is closed on both limbs** — `ADR-0115` §8 named the deployment-locus and secret-custody owners, and `ADR-0116` selected the V1 backend runtime (`Supabase`). ⛔ **No implementation action is authorised by either ADR.** The next authorised acts are the **separate, individually-conferred owner decisions** for **Item 3** (durable queue) and **Item 5** (retry/backoff) — both now **eligible, not resolved**, and `PRD-006` **L2332** still governs Item 5: *"none may be invented"*. Items 9b and 7b remain **blocked behind Item 3**. The independent **7a** and **8b-residual** owner decisions remain separately routed. ⚠ A Rank-1 `MASTER_PRD` L227 amendment is **NOT performed** and requires its own ADR (`ADR-0116` §6). *(Prior text, correct until `ADR-0115` §8 and `ADR-0116`: "complete the follow-up governed act for **Item 4 Backend Runtime** by naming the deployment operator and server-side secret-custody/control owner; do not infer either assignment from the Architecture Owner / ARB acceptance in principle. Until those assignments and any final runtime authority are recorded, Items 3, 9b, 7b and 5 remain blocked/open and no implementation action is authorised.")*")*

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
| **What Remains Blocked** | ⭐⭐ **Only TWO items remain: Item 9b** at-rest construction — barred by **OPEN `ATT-GAP-006`** (*"the construction is Security Platform's"*), owner **SECURITY PLATFORM** — and **Item 7a** retention period — `Q-04` open, owner **Legal counsel + Architecture Owner**. ⛔⛔ **AND EVERY RESOLVED ITEM REMAINS UNIMPLEMENTABLE** — Items 4, 3, 7b, 5 and 8b-residual are each **governance-resolved with NO implementation authority**. ⚠ **This row was ALREADY STALE in four limbs before this act, and the staleness is disclosed rather than silently overwritten:** Item 4 ceased to be blocked at `ADR-0115` §8 / `ADR-0116`, Item 3 at `ADR-0119`/`ADR-0120`, Item 7b at `ADR-0121`, and Item 5 at `ADR-0122`; the 8b-residual limb is the one this act closes (`ADR-0123`). *(Prior text, retained verbatim and correct until `ADR-0115` §8: "Until the follow-up runtime/deployment assignments are recorded: **Item 4 remains BLOCKED**; Item 3 remains blocked by Item 4; Item 5 remains blocked/open with no retry values; Item 9b and Item 7b remain blocked through Item 3. 7a retention and 8b-residual remain independent owner decisions.")* |

**Required governance path:** Architecture Owner / ARB acceptance in principle → named deployment operator and secret-custody/control owner → final runtime/deployment authority record → any necessary Rank-1 `MASTER_PRD` correction → dependency re-check. This brief itself is not an implementation approval and must not be used to start implementation.

| Version | Date | Change |
|---|---|---|
| v1.2 | 2026-09-08 | Added the Item 4 formal decision brief. Records the exact decision scope, authority gap, owner, ADR contents and dependency consequences without selecting a runtime or changing any frozen/prohibited artifact. |
| **v1.14** | 2026-09-08 | ⭐⭐ **`BLK-05` CLOSED — and it was closed by MEASUREMENT, not by work.** A full re-audit of every active blocker found that **`BLK-05`'s row was FALSE rather than merely stale**: its closing condition (`PRD-012a` being *opened*) was satisfied on **2026-08-21**, and this register never recorded it. Evidence, all measured at `192a153`: **14** `PRD-012a*` files exist; `PRD_REGISTRY.md` **L250** records `PRD-012a` **`FROZEN`**; **L249** records `PRD-012` **`RETIRED` — 2026-08-21**; `DOCUMENTATION_BASELINE.md` **L198** carries it at **v0.8** as the *"Authoritative … Security Automation baseline"*; and `Accepted` **`ADR-0064`**'s `Closes` row states *"retires `PRD-012`"*. ⛔ **No ADR created and none required** — this register is **Unranked** (*"Editable without an ADR"*) and the governing decision was already `Accepted`; ⭐ **nothing was decided here, only recorded**. ⚠ **Two consequences are expressly NOT claimed:** `PRD-012`'s *unassignability* under the one-holder-per-role rule is untouched, and **`PRD-012b`** (**V2**) remains **reserved and unwritten**. ⭐⭐ **THE OTHER FOUR BLOCKERS WERE RE-AUDITED AND ALL REMAIN LEGITIMATELY OPEN — none was force-closed:** **`BLK-01`** is hard-blocked because the debug peek *"cannot be removed until a real delivery path exists"* and **no delivery path exists** (measured: `otpHint` ×6, `challengePeekEnabled` ×4, `debugPeekChallenge` ×2, `kDemoChildPhone` ×2 still in `lib/`; and ⭐ `D10-1..3` are **already done** — `_seededAccounts` and `SEEDED ACCOUNTS` both **0**); **`BLK-02`** waits on **DLT registration**, which Rank-1 `MP-DEP-03` classifies **External** — every DLT reference in `docs/` is an unchecked requirement, so it is **not registered** — plus an SMS-provider selection that ⛔ **must not be invented**; **`BLK-03`** has its detection criteria (`ADR-0125`) but ⛔ **`ADR-0125` records "Implementation authorised: **No**"**, and its two prerequisite artifacts **A1**/**A2** still do not exist, so `SID-DET-10` remains **not executable**; **`BLK-04`** is a **GitHub Free-plan** restriction (HTTP 403 on both the branch-protection and rulesets APIs) — **commercial, not technical**. **Item 9b** stays blocked by **OPEN `ATT-GAP-006`** (⛔ Security Platform design must not be invented) and **Item 7a** by **open `Q-04`** (⛔ no retention period may be invented). ⛔ **0** code, config, dependency, checker, manifest or frozen-PRD changes; **0** ADRs created; `ADR-0119`…`ADR-0125` **byte-unchanged**; `BASELINE-2026-09-03-A` stands. |
| **v1.13** | 2026-09-08 | ⭐⭐ **`BLK-03`'s SPECIFICATION GAP IS CLOSED — and `BLK-03` itself is deliberately NOT closed.** `Accepted` **`ADR-0125`**, decided **jointly** by the **Architecture Owner + `BC-10` Domain Owner** under a **new** one-act conferral that **expires on recording** (⛔ **no prior conferral reused**), records **`SID-DET-5`, `SID-DET-6`, `SID-DET-8`, `SID-DET-9`, `SID-DET-10`, `SID-DET-11`** — for each rule: the artifact inspected, what is a violation, what is compliance, the evidence required, what must **NOT** be flagged, and the method class. ⭐ **Two offices, because the act has two limbs**: detection *method* is Architecture's (`PRD_OWNERSHIP_MODEL` **L85**) and *faithfulness to the `BC-10` rule* is the Domain Owner's (**L84**) — the `ADR-0011` precedent. ⭐⭐ **THE METHOD WAS `ADR-0014`'S, QUOTED AND FOLLOWED:** *"The fix was to **read the manifest that already existed**, not to add a rule or to soften one."* Each criterion derives from quoted existing authority — `SID-INV-5` + the manifest's already-declared `observability_plane.banned_content`; Rank-1 **`MP-GBR-26`** + the manifest comment that **already** reads *never cache*; `SID-4.44` + BC Map **`E-20`**; `SID-4.6` + the manifest's **existing eight-port allow-list** under `default_decision: deny`; `SID-4.39` + the **two field sets already enumerated verbatim** at **L379–386**/**L393–397**; `SID-4.9` + `AR-1` + the `IdentityCoreFields` worked example. ⭐⭐⭐ **THE HARDEST PROBLEM — `SID-INT-8`'s "synchronously" — WAS SOLVED WITHOUT REDEFINING IT:** `E-20` declares the *only* audit path and declares it an **event**, so any *reference* to `platform/audit` from domain code is necessarily off-path and absence-of-reference is a **sufficient structural proxy** — the identical reasoning `ADR-0014` used for `X-10` (*"it needs no call-graph"*). ⛔⛔ **NO `SID-INT` RULE CHANGED, NARROWED OR REINTERPRETED** — `Student_Identity_PRD_v1.md` **byte-unchanged**, §4.16's `Detection` column **not rewritten**, **0** `SID-*` identifiers minted; `SID-DET-*` are **ADR-local citation labels**, not PRD requirements, and **not** added to the traceability matrix. ⭐⭐ **FOUR CRITERIA ARE NARROWER THAN THEIR RULES AND EACH SAYS SO** — misleading field names (`-5`), contracts-bound calls (`-8`), string-literal table names (`-9`), primitive-only composites (`-11`); ⛔ **in every case the residue stays under `SID-4.56` and the rule is NOT narrowed to match the check**. ⚠⚠ **TWO PREREQUISITE ARTIFACTS RECORDED, OWNED, ROUTED — AND NOT CREATED:** **A1** per-context table/index name inventory (**Architecture Owner**; measured: exists **nowhere**) and **A2** machine-readable index-field declaration for `domain/person` (**`BC-10` Domain Owner + Architecture Owner**; measured: **0** index declarations in `lib/` or `packages/`), so **`SID-DET-10` is well-defined but NOT YET EXECUTABLE**; ⛔ whether either needs its own ADR is **explicitly left UNDETERMINED**, that being an Architecture Owner act outside the conferral. ⚠ **A separate smaller act is identified and NOT performed:** `SID-INT-1`/`-2`/`-3`/`-4`/`-7` **already fire** (`-3`/`-4` **probe-verified**) but report under `ID-2`/`X-05`/`X-04`/`L2`, so making them **independently identifiable** remains a manifest/checker labelling act. ⛔⛔ **NOTHING IMPLEMENTED:** no checker implementation or edit, no manifest edit, no dependency, no application/domain code, no artifact creation, and no provider, backend-runtime, DLT, authentication or retention decision. ⛔ `ADR-0125` **amends nothing** — `Student_Identity_PRD_v1.md`, `MASTER_PRD`, BC Map, Dependency Matrix, `ARCHITECTURE_RULINGS`, EA, **`tool/module_dependencies.yaml`**, **`tool/check_module_boundaries.dart`**, `DOCUMENTATION_BASELINE`, `PRD_OWNERSHIP_MODEL`, **`ADR-0014`**, `ADR-0011`, ⛔ **`ADR-0119`…`ADR-0124`**, `IMPL-220` and `TASK-D10` all **byte-unchanged**; §7 rules 1–4 all unmet, **no version bump** of any ranked document, **`BASELINE-2026-09-03-A` stands**. ⛔ No standing authority; no person named; **0** `IMPL-*`, **0** code/config/dependency files. ⛔ `BLK-01`, `BLK-02`, `BLK-04`, `BLK-05`, Items 7a and 9b **untouched**. |
| **v1.12** | 2026-09-08 | ⭐⭐ **`BLK-02`'s BACKEND-RUNTIME LIMB IS DISCHARGED — and `BLK-02` itself is deliberately NOT closed.** `Accepted` **`ADR-0124`**, decided by the **Architecture Owner** under a **new** one-act conferral (⛔ **no prior conferral reused**), selects `IMPL-020` §2.1 **Option A** — a managed **BaaS, `Supabase`** — as the **V1 AUTHENTICATION backend runtime**, hosting the OTP delivery adapter as an **adapter behind a port, never as a layer**. ⭐ This is the *"exact authority action"* `IMPL-020` §2.1 routed upward (*"it is the Architecture Owner's to take"*) and §6 refused to take (*"Selects no backend. Supabase is not chosen"*) — the **`ADR-0045` → `ADR-0046`** STOP-then-conferral shape. ⭐⭐ **FIVE PRECONDITIONS MEASURED BEFORE WRITING:** `BLK-02` still *"OPEN — not started"*; runtime still **unselected**; **no** later ADR had resolved it; **`ADR-0124` free**; `IMPL-020` §2.1 options still **current**. ⭐⭐⭐ **THE CENTRAL TRAP WAS TESTED AND REFUSED:** a Supabase selection already existed — **`ADR-0116`** — but it is **`BC-30` Offline-Sync-scoped**, lists **`IMPL-020`** under `Does NOT amend`, and its §2.2 cites `IMPL-020` **L185/L280** as **non-selections**; and **`ADR-0123` §7.1's** *"Backend runtime ✅ RESOLVED"* refers to **Item 4 (`BC-30`)**, a different blocker in **§11.2**, not `BLK-02` in **§2**. ⛔ Treating either as an authentication decision would be the inference `ADR-0045` §2.1 / `ATT-GAP-005` forbid. ⭐⭐ **THE TWO REJECTIONS ARE ASYMMETRIC:** **Option C** (direct-from-client) is ⛔ **REFUSED on five independent authorities, four FROZEN or Rank 1** — `AUTH-3.12`, `X-03` (**forbidden edge**), Matrix **L167**, `MP-CON-01`, and the checklist's **L58–L60** (*"**`D-10` happened exactly this way**"*), so it would **reconstruct the `D-10` defect by design**; **Option B** (dedicated backend) is ⚠ **NOT SELECTED but expressly NOT REFUSED** — **lawful**, and ⭐ `MP-CON-03` exists precisely so it stays reachable, so A **preserves B rather than foreclosing it**. ⚠⚠ **`MP-RSK-05` (BaaS lock-in, rated High) is ACKNOWLEDGED, NOT DISMISSED** and is **not closed**. ⚠⚠ **`BLK-02` REMAINS P0/OPEN** on two limbs — **DLT registration** (External) and **SMS provider** — and ⚠ **`BLK-01`/`TASK-D10` is NOT unblocked**, because the peek *"cannot be removed until a real delivery path exists"* and ⭐ **a runtime is not a delivery path**. ⭐ **Narrowly unblocked:** `IMPL-020`'s four *"⚠ BACKEND DECISION"* items now have the premise item 9 said they lacked (*"'server logs' presumes a server; **none is approved**"*) — ⛔ **not answered**. ⛔⛔ **NOTHING ELSE AUTHORISED:** no SMS provider, DLT registration, template, sender ID, `AERR-*`, cloud account/project/region, schema, dependency, SDK, port, module, manifest block, edge, secret format, credential or vault configuration; ⚠ **`ADR-0115` §8.1/§8.2's SECURITY-PLATFORM and INFRASTRUCTURE/DEVOPS assignments are `BC-30`-scoped and are NOT widened to authentication**; `IMPL-020` **Gaps A and B stay OPEN**. ⛔ `ADR-0124` **amends nothing** — `MASTER_PRD` (incl. **L227**, **L271**), **FROZEN `PRD-001`/`PRD-006`/`PRD-012a`**, all frozen PRDs, BC Map, Dependency Matrix, EA, `DOCUMENTATION_BASELINE`, `PRD_OWNERSHIP_MODEL`, `ADR-0045`, `ADR-0046`, `ADR-0114`…`ADR-0116`, ⛔ **`ADR-0119`…`ADR-0123`**, **`TASK-D10`** and `tool/module_dependencies.yaml` all **byte-unchanged**; §7 rules 1–4 all unmet, **no version bump** of any ranked document, **`BASELINE-2026-09-03-A` stands**. ⚠ Rank-1 **L227** **NOT amended**, on the `ADR-0046`/**L232** precedent; routed separately and **not asserted to be required**. ⛔ No standing authority; office VACANT; no person named; **0** `IMPL-*`, **0** code/config/dependency/infrastructure files. ⛔ Items 9b, 7a, `BLK-01`, `BLK-03`, `BLK-04` **untouched**. |
| **v1.11** | 2026-09-08 | ⭐⭐⭐ **ITEM 8b-RESIDUAL IS RESOLVED — the LAST of the five Offline-Sync owner decisions, and the whole chain (Items 4, 3, 7b, 5, 8b-residual) is now discharged at the GOVERNANCE level.** `Accepted` **`ADR-0123`**, decided by **Product Owner + `BC-03` Domain Owner** under a **new** one-act conferral (⛔ **no prior conferral reused** — `ADR-0117`'s and `ADR-0118`'s were spent by `ADR-0119`/`ADR-0121`; `ADR-0120` and `ADR-0122` each received their own), records **`EVT-AUTHZ-1`** *the original capture timestamp remains the attendance time*, **`EVT-AUTHZ-2`** *replay/sync, Wi-Fi connection, Presence observation and retry time MUST NOT replace or rewrite it*, **`EVT-AUTHZ-3`** *a later Presence observation or attendance attempt MUST NOT automatically create a duplicate where a valid attendance exists*, **`EVT-AUTHZ-4`** *no silent discard when the actor is unauthorized at replay*, **`EVT-AUTHZ-5`** *retain as an audit-bearing rejected mutation and surface for explicit/manual resolution*, **`EVT-AUTHZ-6`** *this constitutes the explicit resolution/disposal path for `EVT-PERS-1`, `EVT-DEPTH-2` and `EVT-RETRY-3` only to the extent necessary for this exact scenario* — **all VERBATIM**, mechanically verified. ⭐ **Exactly the two offices the preceding audit named**, and exactly the two `PRD_OWNERSHIP_MODEL.md` **L163** assigns to `PRD-006`/`BC-03` (**L83** business intent, **L84** domain correctness/invariants). ⭐⭐ **This is the audit's candidate 3 — *refuse but retain as an audit-bearing rejection*** — plus two limbs the audit had not separated (timestamp, no-duplicate); ⛔ candidates 1, 2 and 4 were **not** selected, and ⚠ `ADR-0123` §2.1 records that **`EVT-AUTHZ-1`/`-2` are NOT candidate 1 in disguise** — they fix *which instant* is the attendance time for an **admitted** mutation and do **not** make an unauthorized actor's mutation admissible. ⭐⭐ **SEVEN COHERENCE TESTS RUN BEFORE RECORDING:** **(i)** `EVT-AUTHZ-4`/`-5` **SATISFY** `ADR-0119` **D-4** on **both** limbs (vanish prohibition **and** observable signal) — ⚠ on a **different trigger** from `EVT-RETRY-3`'s retry exhaustion, since **retrying cannot cure unauthorization**, so `ADR-0122` is **neither duplicated nor amended**; **(ii)** ⭐⭐ **the highest-risk test — `EVT-AUTHZ-1`/`-2` against FROZEN `ATT-FR-088`** — resolved by measuring that `ATT-FR-088`/`X-09` fix a timestamp's **SOURCE** (platform time port, never the client) while `EVT-AUTHZ-1` fixes **WHICH INSTANT** is the attendance time; ⛔ **no device-clock authority is created**, and `PRD-006` **L2433–2435** (*“a queued loss is an observed loss whenever it arrives”*) with **`ATT-FR-089`** (*“in force at the moment it was recorded”*) **CORROBORATE** the arrival-time-is-not-event-time principle at Rank 3; **(iii)** `EVT-AUTHZ-1`/`-2` are a **consistent superset** of `EVT-RETRY-4`, widening the barred-instant list from `{replay, retry}` to four — ⛔ `EVT-RETRY-4` **not amended**; **(iv)** **`EVT-AUTHZ-3` CONFIRMS** frozen `ATT-INV-003`, `ATT-FR-019`, `ATT-INV-004`, `ATT-PO-012` and `PRD-006` **L2430–2431**, ⛔ with **no** key, comparison, merge or conflict algorithm stated and `ATT-PO-013` preserved; **(v)** ⭐⭐ **authorization authority preserved UNWEAKENED** — `AUTH-8.38`, `BR-7.1`, `AUTH-6.74`, `XC-6.4`…`XC-6.7` all hold, because FROZEN `PRD-001` refuses the **operation** while this ADR governs the **queued data** after that refusal; the mutation is **rejected, not admitted**; **(vi)** the *audit-bearing* limb is consistent with `ATT-FR-129`/`E-20`, `ATT-FR-132`, `ATT-FR-133`, `AUTH-10.4`, and ⭐ **`ATT-BR-011`** (*“a failure MUST NOT be silent”*) **corroborates `EVT-AUTHZ-4` at Rank 3 independently of `MP-NFR-02`**; **(vii)** ⚠ **the capacity interaction is RECORDED, not glossed** — retained rejected mutations occupy slots and count toward the **500/device** bound, after which `EVT-DEPTH-2` blocks new captures, so a revoked actor's device can accumulate toward the bound and only the `EVT-AUTHZ-5` route relieves it. ⭐ **`ATT-INV-008` NOT stretched:** the audit had measured via **`ATT-AC-119`** that a queued item is not yet a *stored* fact; ⛔ this ADR **neither asserts nor denies** that and makes it **moot by retaining the item regardless**. ⚠⚠ **WHAT REMAINS UNDEFINED IS DISCLOSED (`ADR-0123` §3.2):** the **general** disposal route (non-authorization causes such as ordinary retry exhaustion or depth-bound preservation); **who** may perform the *“explicit/manual resolution”*, what it offers and whether it may end in destruction; and ⛔ **where** the rejected-mutation record lives — because `ATT-FR-130` forbids `BC-03` creating an attendance-specific audit store while `ATT-FR-129`/`E-20` route audit facts to `BC-24`, and resolving that is an architecture/ownership act outside this conferral. ⭐ §13.5 act **6** struck through as DONE. ⛔⛔ **RESOLVED IS NOT IMPLEMENTABLE:** ⛔ no attendance, Presence, authorization, retention, storage or implementation rule beyond the six statements — tested category by category — and specifically no storage technology, database, queue product, schema, encryption, retention period, **retry change**, **queue-depth change**, cloud resource, **Supabase** configuration, **`PRD-018`** or application implementation; ⭐ **a retention *disposition* is NOT a retention *period***, so **Item 7a stays OPEN** (`Q-04`); **Item 9b** stays OPEN behind **`ATT-GAP-006`**. ⛔ **No `ATT-CFG-*` or any `ATT-*` row created** — a register row would be a Rank-3 change to a **FROZEN** PRD. ⛔ `ADR-0123` **amends nothing**; ⛔ **`PRD-006` byte-unchanged, as the conferral expressly forbade touching it**, and `PRD-001`, `PRD-016`, `MASTER_PRD`, BC Map (incl. `E-20`, `E-24`), Dependency Matrix, `PRD_OWNERSHIP_MODEL`, `DOCUMENTATION_BASELINE`, **`ADR-0030`** (whose `Proposed` §6A had **named this exact gap** and declined to decide it), `ADR-0036`, `ADR-0114`…`ADR-0122` and `tool/module_dependencies.yaml` all **byte-unchanged**; §7 rules 1–4 all unmet, **no version bump** of any ranked document, **`BASELINE-2026-09-03-A` stands**. ⛔ No standing authority; both offices revert; no person named; **0** `IMPL-*`, **0** `SYNC-*`, **0** code/config files. |
| **v1.10** | 2026-09-08 | ⭐⭐⭐ **ITEM 5 IS RESOLVED.** `Accepted` **`ADR-0122`**, decided by **Architecture Owner + Product Owner** under a **new** one-act conferral (⛔ **no prior conferral reused** — `ADR-0117`'s and `ADR-0118`'s were spent by `ADR-0119`/`ADR-0121`), records **`EVT-RETRY-1`** *5 attempts*, **`EVT-RETRY-2`** *exponential 1, 2, 4, 8, 16 minutes*, **`EVT-RETRY-3`** *retain as terminal-failed and surface for explicit/manual resolution, no silent discard*, and **`EVT-RETRY-4`** *preserve the original attendance capture timestamp; replay time MUST NOT replace it* — **all VERBATIM**, mechanically verified. ⭐ **Two offices jointly**, because the decision has a **mechanism** limb (Architecture, `PRD_OWNERSHIP_MODEL` **L85**) and a **disposition** limb (Product, **L83**) — the `ADR-0011` *"three roles for one decision"* precedent. ⭐ **The value could only be SUPPLIED, never derived:** a six-sweep audit measured **0** authoritative retry values and rejected four near-misses **by scope** — `FIL-CFG-014` (`BC-29`), `NTF-CFG-004` (`BC-22`), BC Map §9.1's qualitative row (no count/delay; does not reach `BC-30`), and `ADR-0028` C-3 (which **forbids** invention and is only `Proposed`); `PRD-006` **L2332** is honoured because the values are **conferred, not invented**. ⭐⭐ **SIX COHERENCE TESTS RUN BEFORE RECORDING:** **(i)** `EVT-RETRY-3` **SATISFIES** `ADR-0119` **D-4** rather than merely avoiding it — D-4 was a prohibition **without** a mechanism, and this supplies the disposition **without amending it**; **(ii)** **consistent with `ADR-0120` `EVT-PERS-1`** — a retry limit could have been misread as a third, implicit termination, and `EVT-RETRY-3` **forecloses** it (exhaustion ⇒ **retention, not disposal**); **(iii)** ⚠ **a real interaction with `ADR-0121` is RECORDED, not glossed** — retained terminal-failed items keep occupying slots and count toward the **500/device** bound, after which `EVT-DEPTH-2` blocks new captures; a **coherent consequence** of *"no silent discard"*, since the alternative frees capacity by dropping data; **(iv)** **`EVT-RETRY-4` CONFIRMS frozen `ATT-FR-088`** and `PRD-006` **L2433–2436** — a restatement where the frozen rule is easiest to breach, **not** a new rule; **(v)** ⚠ **`ATT-NFR-003` does NOT bar these values** — it binds *"this document"* (`PRD-006`, **byte-unchanged**) and bars **latency/throughput/percentile** figures, which a **backoff interval is not**; **`ATT-GAP-017a` stays OPEN**; **(vi)** **0** value collisions, and the **5-minute presence grace** is a different subject and owner — **no presence rule altered**. ⚠⚠ **ONE LIMB UNDEFINED AND DISCLOSED:** *"explicit/manual resolution"* is **not defined, implied or pre-judged** — the **THIRD** ADR to terminate on the undefined disposal/resolution route (after `EVT-PERS-1`, `EVT-DEPTH-2`), substantially **8b-residual**, now **load-bearing for three ADRs**; retention after exhaustion is **unconditional**, so the gap makes the guarantee **stronger, never weaker**. ⭐ §13.5 act **3** struck through as DONE. ⛔⛔ **RESOLVED IS NOT IMPLEMENTABLE:** no storage technology, database, queue product, schema, encryption, retention, cloud resource, **Supabase configuration** or application implementation; ⛔ **conflict-resolution semantics, queue depth (500/device), the persistence guarantee and at-rest protection are ALL untouched**, as the conferral required; ⭐ **a retry schedule is NOT a retention period**, so **Item 7a stays OPEN**; **Item 9b** stays OPEN-eligible behind **`ATT-GAP-006`**. ⛔ **No `ATT-CFG-*` row created** — a configurable would be a Rank-3 register change to a FROZEN PRD, so the values are **fixed by the ADR, not configured**. ⛔ `ADR-0122` **amends nothing**; `PRD-006`, BC Map, `MASTER_PRD`, `CONFIGURATION_GUIDE`, `ADR-0114`…`ADR-0121`, `DOCUMENTATION_BASELINE` and `tool/module_dependencies.yaml` **byte-unchanged**; §7 rules 1–4 all unmet, **no version bump**, **`BASELINE-2026-09-03-A` stands**. ⛔ No standing authority; no person named; `PRD-018` not created; **0** `IMPL-*`, **0** `SYNC-*`, **0** code/config files. |
| **v1.9** | 2026-09-08 | ⭐⭐⭐ **ITEM 7b IS RESOLVED, and with it the whole Item 4 → Item 3 → 9b/7b Offline-Sync dependency chain is discharged at the GOVERNANCE level.** `Accepted` **`ADR-0121`** is the **first and only** exercise of the act `ADR-0118` conferred and withheld (⛔ **no conferral reused** — `ADR-0119` §5.1 and `ADR-0120` §6.1 both left it **unspent** because **0** values existed to ratify; the office is now **VACANT**). ⭐ Records **`EVT-DEPTH-1`** — bound = **500 queued offline attendance mutations per device** — and **`EVT-DEPTH-2`** — *"on reaching the bound the system MUST block new offline captures while preserving all already-captured queued mutations until replay or explicitly authorized disposal"* — **both VERBATIM**, owner-supplied, mechanically verified; **not substituted, weakened, strengthened, rounded or reinterpreted**. ⭐⭐ **FOUR COHERENCE TESTS RUN BEFORE RECORDING, because a value contradicting frozen authority would be worse than leaving 7b open:** **(i)** `EVT-DEPTH-2` is **CONSISTENT** with `ADR-0119` **D-4** (*"no silent discard"*) and `ADR-0120` **`EVT-PERS-1`** — the real risk, since any **shed/drop/evict** policy would have **collided with two Accepted ADRs**, whereas **block-and-preserve resolves that tension instead of creating it**; **(ii)** *"per device"* is a **counting scope on `BC-30`'s queue, NOT per-device attendance** — `PRD-006` **L853** forbids the latter, and `ATT-AC-152`/`AttendanceDay` are untouched; **(iii)** `ATT-PO-001`'s *"never blocks"* is measured (**L307**, **L225**) as **`E-03` MEMBERSHIP-scoped**, so blocking on a **capacity** condition does not breach it; **(iv)** `MP-ASM-03`/`ATT-NFR-012` satisfied — a ceiling **promises less, not more**. ⭐ **0** conflicting uses of `500`. ⚠⚠ **ONE LIMB UNDEFINED AND DISCLOSED:** *"explicitly authorized disposal"* is **not defined, implied or pre-judged** — substantially **8b-residual**, now **load-bearing for two ADRs**; retention stays **unconditional until** a terminating event, so the gap makes the guarantee **stronger, never weaker**. ⭐ §13.5 act **2a** struck through as DONE. ⛔⛔ **RESOLVED IS NOT IMPLEMENTABLE:** no storage technology, database, queue product, schema, flush policy, acknowledgement protocol, encryption, retry/backoff, retention, cloud resource, **Supabase configuration** or application implementation; ⭐ **blocking is NOT a retry policy** and ⭐ **a depth bound is NOT a retention period**, so **Items 5 and 7a stay OPEN**; **Item 9b** stays OPEN-eligible behind **`ATT-GAP-006`**. ⛔ **No `ATT-CFG-*` row created** — a configurable would be a Rank-3 register change to a FROZEN PRD. ⛔ `ADR-0121` **amends nothing**; **BC Map and `PRD-006` byte-unchanged**; §7 rules 1–4 all unmet, **no version bump**, **`BASELINE-2026-09-03-A` stands**. ⛔ No standing authority; no person named; `PRD-018` not created; **0** `IMPL-*`, **0** `SYNC-*`, **0** code/config files. |
| **v1.8** | 2026-09-08 | ⭐⭐⭐ **ITEM 3 IS RESOLVED. `EVT-GAP-001` CLOSED by `Accepted` `ADR-0120`**, under a **NEW** one-act `EVENT platform` conferral from the human principal (⛔ **`ADR-0117` NOT reused** — spent by `ADR-0119`, which recorded the office VACANT; the office is VACANT again after this act). ⭐ **`EVT-PERS-1` recorded VERBATIM** as stated: *"A captured offline attendance mutation MUST be durably persisted at capture and MUST survive process death, force-stop and device reboot until it is either replayed or explicitly disposed of."* ⛔ **Not substituted, weakened, strengthened, paraphrased or reinterpreted** — mechanically verified against the conferring words. ⚠ **The same sentence was REFUSED one turn earlier** when offered prefixed *"IF explicitly confirmed"*, on the `ADR-0045` §2.1 / `ATT-GAP-005` discipline that a conditional candidate is not a confirmation; it is acted on now because it was **stated as a decision**. ⚠⚠ **A PRIOR AUDIT CONCLUSION OF MINE WAS CORRECTED, NOT QUIETLY DROPPED** (`ADR-0120` §4.1): I had reported this needed **new Rank-4 BC Map content** plus a **separate Architecture Owner** conferral — **re-audited, false.** `ADR-0058`, `ADR-0047`, `ADR-0063`, `ADR-0061` and `ADR-0119` all record substantive obligations with `Amends: Nothing`, and **`ADR-0058` attached a V1 obligation to a PORT** while **`E-24` L333 already declares `BC-30`'s Sync port** — a `BC-30` aggregate declaration was **surplus, not a prerequisite**, so the path shortened from **two acts to one**. ⛔⛔ **BC MAP BYTE-UNCHANGED** — `DOCUMENTATION_BASELINE.md` §7 rules 1–4 each tested and **all unmet**; **no version bump anywhere**; **`BASELINE-2026-09-03-A` stands**. ⚠ Cost disclosed: a BC-Map-only reader will not find `EVT-PERS-1`; mirroring it is **neither performed nor required**. ⭐ **Item 9b moves BLOCKED → OPEN-eligible** (Item 3 no longer blocks it, and `EVT-PERS-1` gives it a subject) — ⛔ but still barred by **OPEN `ATT-GAP-006`**. ⛔⛔ **Item 7b NOT unlocked and `ADR-0118`'s act remains UNSPENT** — closing `EVT-GAP-001` creates no depth value and **0** exist to ratify. ⛔ **Items 5, 7a and 8b-residual untouched**; ⚠ 8b-residual is now **visibly adjacent**, since `EVT-PERS-1`'s *"explicitly disposed of"* limb is deliberately **undefined**. ⭐ §13.5 act **1b** struck through as DONE. ⛔⛔ **RESOLVED IS NOT IMPLEMENTABLE:** no storage technology, database, queue product, schema, flush policy, acknowledgement protocol, encryption, retry/backoff, queue depth, retention, cloud resource, **Supabase configuration** or application implementation is authorised; ⚠ `ADR-0116`'s Supabase selection is a **server-side runtime** choice, **not** a client-side mechanism; ⭐ **durability is not retention** (BC Map §18.4), so `Q-04`/`ATT-GAP-005` are untouched. ⛔ No standing authority; no person named. ⛔ `PRD-006`, `PRD-001`, `MASTER_PRD`, BC Map, Dependency Matrix, `PRD_OWNERSHIP_MODEL`, `DOCUMENTATION_BASELINE`, `ADR-0114`…`ADR-0119` **byte-unchanged**; `PRD-018` not created; **0** `IMPL-*`, **0** `SYNC-*`, **0** code/config/dependency files. |
| **v1.7** | 2026-09-08 | ⭐⭐ **`EVENT platform` EXERCISED its act; Item 3 PARTIALLY closed; every other item preserved at its measured status.** `Accepted` **`ADR-0119`** ratifies the `BC-30` durability model as **four properties each quoted from binding authority** — **D-1** at-least-once with idempotent absorption and **D-3** ordering by the platform time port from **FROZEN** `PRD-006` **L2430–2431**/**L2436**; **D-2** the `(studentRecordId, date, idempotencyKey)` key from `ATT-INV-003`/`ATT-FR-090`…`095`; **D-4** *"no silent discard"* from **Rank-1** `MP-NFR-02`. ⭐ **Ratification, not authorship** (`ADR-0109`/`ADR-0102` model) — **D-1 and D-3 are precisely what an implementer would otherwise have guessed, and both were already law.** ⛔ **NOTHING INVENTED:** no storage, medium, database, queue technology, schema, flush or acknowledgement semantic; `ADR-0116`'s `Supabase` selection is **not** read as implying any local durability property. ⚠⚠ **`EVT-GAP-001` OPENED, so ITEM 3 IS NOT FULLY CLOSED** — the client-side **persistence** limb (survival across process death / force-stop / reboot) and the storage medium are **UNSPECIFIED**: swept for `durable/survive/persist/restart/fsync/WAL` with **0** Rank 1–5 hits attaching such a guarantee to `BC-30`, and **BC Map §9.1 does not supply it**, being scoped by its own **L442** preamble to *"every event above"* while **`BC-30` appears in no §9 event row** and **`E-24` is a `CF` Sync port, not an event edge** — the same scoping the BC Map's **§18.4** applied when `BCM-22-INV-1` had to state durability separately for `BC-22`. ⚠ A counter-argument from `G-1` + `MP-ASM-03` was **tested and rejected as insufficient** (`G-1` governs the stored record, not the client queue). ⛔⛔ **ITEM 7b NOT unlocked and `ADR-0118`'s act deliberately NOT exercised** — measured **0** queue-depth values to ratify; `MP-NFR-04` gives the obligation and no value, and the EA's *"Realtime Scaling & Backpressure"* is **V3** and about the realtime engine. Exercising it would have invented a number, so **the act remains unspent and available**. ⭐ **Item 9b gains a further bar** — nothing agreed to protect at rest until `EVT-GAP-001` closes. ⛔ **Items 5, 7a and 8b-residual untouched**; `D-4` is expressly **not** a retry policy. ⭐ §13.5 updated: act **1a** struck through as DONE-in-part, **new act 1b** added for `EVT-GAP-001` (⚠ needs a **NEW** conferral — `ADR-0117`'s is now spent), act **2a** re-stated as requiring an **owner-supplied value**. ⛔ No standing authority; `EVENT platform` **VACANT** after its act; no person named. ⛔ `ADR-0119` **amends nothing**; `PRD-006`, BC Map (incl. §9.1, `E-24`), `MASTER_PRD`, `ADR-0114`…`ADR-0118`, `DOCUMENTATION_BASELINE` byte-unchanged; `PRD-018` not created; **0** `IMPL-*`, **0** `SYNC-*`, **0** code/config files. |
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
| **8b-residual** | ⭐⭐ **RESOLVED — `ADR-0123`** *(prior: ⚠ REQUIRES OWNER DECISION — independent)* | `AUTH-8.38`, `BR-7.1`, `ATT-INV-008`, `ATT-FR-015` — **all preserved unweakened**; plus `ATT-FR-088`, `ATT-FR-089`, `ATT-INV-003`, `ATT-FR-019`, `ATT-BR-011`, `ATT-FR-129`/`E-20` | **Product Owner + `BC-03` Domain Owner** — ⭐ **conferred and exercised, act SPENT** | ✅ **Yes — `EVT-AUTHZ-1`…`-6`** | ⛔ No longer required | ⛔ No |
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
| ~~1a~~ | ~~**EXERCISE the `EVENT platform` one-act authority**~~ — ✅ **DONE 2026-09-08 by `Accepted` `ADR-0119`**: replay semantics **RATIFIED** from binding authority (D-1…D-4). ⚠ **Partially only** — `EVT-GAP-001` opened. **Superseded by act 1b below.** | `EVENT platform` (act now spent; office VACANT) |
| ~~1b~~ | ~~**`EVT-GAP-001`: specify the `BC-30` client-side PERSISTENCE guarantee**~~ — ✅✅ **DONE 2026-09-08 by `Accepted` `ADR-0120`** under a **NEW** one-act `EVENT platform` conferral (⛔ `ADR-0117` not reused; it was spent). ⭐ **`EVT-GAP-001` CLOSED → ITEM 3 RESOLVED.** ⚠ The feared Architecture-Owner/Rank-4 prerequisite was **re-audited and found NOT to apply** (`ADR-0120` §4.1): `ADR-0058` attached a V1 obligation to a **port**, and `E-24` already declares `BC-30`'s Sync port — so the BC Map is **byte-unchanged** and the path shortened from two acts to one. *(Original text of this act:)* specify the persistence guarantee (survival across process death / force-stop / reboot) and its storage medium. ⚠ If it is to be recorded as a **Rank-4 invariant** on the `BCM-22-INV-1` model, that is **new Rank-4 content** requiring an **ADR-before-change** (`DOCUMENTATION_BASELINE.md` §7 rule 1) and the **Architecture Owner** — `PRD_OWNERSHIP_MODEL.md` §14 excludes boundaries/ranks from the `EVENT platform` office. ⛔ **Requires a NEW one-act conferral** — `ADR-0117`'s is spent | **Human principal** → `EVENT platform` and/or **Architecture Owner** |
| 2 | ~~**Constitute the `DATA / EVENT` office for one act**~~ — ✅ **DONE 2026-09-08 by `Accepted` `ADR-0118`** (office constituted; `PRD_OWNERSHIP_MODEL.md` §15). ⛔ **No queue-depth value is decided**, and ⚠⚠ **the act is NOT YET EXERCISABLE** — its own conferral is sequenced *"after the Item-3 durability model is authoritative"*, and that model does not exist. **Superseded by act 2a below.** | Human principal |
| ~~2a~~ | ~~**EXERCISE the `DATA / EVENT` one-act authority**~~ — ✅✅ **DONE 2026-09-08 by `Accepted` `ADR-0121`**; the value was **owner-supplied**, as required, and the act is now **SPENT** (office VACANT). ⭐ **ITEM 7b RESOLVED.** *(Original text:)* decide and record the queue-: decide and record the queue-depth / backpressure bound. ⛔ **Requires an OWNER-SUPPLIED VALUE, not a ratification** — `ADR-0119` §5.1 measured **0** candidate values in the repository. ⚠ Also still behind `EVT-GAP-001` | **`DATA / EVENT`** (constituted, `ADR-0118`) + **value supplier** |
| ~~3~~ | ~~**Supply the retry/backoff values** (Item 5)~~ — ✅✅ **DONE 2026-09-08 by `Accepted` `ADR-0122`**; the values were **owner-supplied**, as `PRD-006` L2332 required, following the `ATT-GAP-017`/`ADR-0021` precedent. ⭐ **ITEM 5 RESOLVED.** ⛔ No implementation authorised. | Architecture Owner + Product Owner (act spent) |
| 4 | **Decide the at-rest construction** (Item 9b) — `ATT-GAP-006`. Item 3 first | SECURITY PLATFORM |
| 5 | **Ratify a retention period** (7a) — `Q-04` is open in the authoritative document; `ATT-GAP-005` bars promoting its unratified note | Legal counsel + Architecture Owner |
| ~~6~~ | ~~**Decide the queued-mutation disposition on revoked/expired access** (8b-residual)~~ — ✅✅ **DONE 2026-09-08 by `Accepted` `ADR-0123`**; the treatment was **owner-conferred**, not derived, and the act is now **SPENT**. ⭐ **ITEM 8b-residual RESOLVED** — candidate 3 (*refuse but retain as an audit-bearing rejection*) selected, plus the timestamp and no-duplicate limbs. ⛔ No implementation authorised; ⚠ the **general** disposal route stays undefined (`ADR-0123` §3.2). | Product Owner + `BC-03` Domain Owner (act spent) |

⛔ **Every act above is ONE ACT ONLY and NONE is a standing licence** (`ADR-0033` §7.1). ⛔ No holder is
appointed and no personal name is recorded (`PRD_OWNERSHIP_MODEL.md` §7 rule 4).
