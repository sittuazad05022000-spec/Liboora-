# LIBOORA — Product Implementation Roadmap

| Field | Value |
|---|---|
| **Document** | Product Implementation Roadmap — the order in which PRDs must be specified and built |
| **Version** | v1.0 |
| **Status** | Active |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04` |
| **Scope** | **PRD-level sequencing across the whole product.** Task-level sequencing stays in `IMPLEMENTATION_ROADMAP.md` |
| **Authority** | Derived and non-normative. Ordering follows the architecture; it does not decide it |

---

## 1. What this roadmap is, and how it differs from the one that already exists

[`IMPLEMENTATION_ROADMAP.md`](../../40-implementation/IMPLEMENTATION_ROADMAP.md) v1.2 sequences **tasks** —
`IMPL-014` … `IMPL-226` across nine phases. It is authoritative for that and is **not** superseded, duplicated or
contradicted here.

This document sits one level up. It sequences **PRDs**: which specification must exist before which other
specification can be written, and in what order the modules should be built once they do. The existing roadmap
answers *"what do I build next?"* for work that has a specification. This one answers *"what do we specify next?"*
for the **18 PRDs that do not exist**.

**It contains no estimates.** Following the existing roadmap's stated principle: *"Sequencing and readiness are
architectural facts; duration is a team fact."*

---

## 2. Ordering criteria, applied in this precedence

Request G names six dependency classes. They conflict, so the order in which they are applied matters and is
stated:

| # | Criterion | Why it ranks here |
|---|---|---|
| 1 | **Architectural** | A rank violation cannot be refactored away cheaply. Rank 7.5 exists because the alternative was dissolving a boundary |
| 2 | **Bounded context** | Ownership must be settled before requirements are written, or two PRDs claim one aggregate |
| 3 | **Data** | An identifier must have an owner before another context holds it. Retrofitting `tenantId` is *"a migration across every core table"* |
| 4 | **API** | A synchronous port must exist before a caller depends on it, or the caller re-implements it |
| 5 | **Security** | Deferring an authorisation owner means someone decides locally — `X-13` |
| 6 | **Business** | Business rules are reorderable. Everything above is not |

**Security ranks fifth by *sequence*, not by importance.** A security dependency deferred is a defect; a security
*decision* made in the wrong module is an architecture failure that outlives the release. Placing it fifth means
its *owner* is established by criteria 1–4 first — so that when the rule is written, there is exactly one lawful
place to put it.

---

## 3. Current position — verified, not assumed

| PRD | Specification | Implementation | Blocking issue |
|---|---|---|---|
| `PRD-000` Master | ✅ Frozen v1.7 | n/a | — |
| `PRD-001` Authentication | ✅ Frozen v2.0 | ⚠ **Partial** | `TASK-D10` **P0 release blocker**; `IMPL-020` SMS/DLT unstarted |
| `PRD-002` Library | ✅ Frozen v1.0 | ⛔ **0 of 23 tasks** | Nothing started |
| `PRD-003` Student Identity | ✅ Frozen v1.0 | ⚠ **Partial** | `IMPL-220` `SID-INT-*` unenforced → **unmet** per `SID-4.56` |
| `PRD-004` Student Management | 🟡 **`DRAFT` v1.1** — not frozen, not ranked | ⛔ **0 of 24 tasks** | Written 2026-08-04 (`11aae01`). Includes the Library Members Directory as chapter 5 (read composition). **Reviewed 2026-08-04 — verdict C**, then **corrected 2026-08-04**: all 3 blocking findings resolved with no ADR and no ranked-document change; 15 of 21 findings accepted, 3 rejected with evidence, 3 pre-existing/out-of-scope. Still **0 of 30 acceptance criteria executed**, and the correction changed architectural *interpretation*, so a **second independent review is required before freeze**. See [`PRD-004_CORRECTION_REPORT.md`](../../30-product/student-management/PRD-004_CORRECTION_REPORT.md) and [`PRD-004_INDEPENDENT_REVIEW_REPORT.md`](../../30-product/student-management/PRD-004_INDEPENDENT_REVIEW_REPORT.md) |
| `PRD-005` … `PRD-022` | ⛔ **Do not exist** | ⛔ | 18 missing, all V1 |

Quality gates at HEAD: format ✅ · analyze ✅ · tests ✅ 71 passing · **boundary checker exits 1 by design**
(9 `app → domain/library` findings, deliberately unwaived pending `TASK-D10`, per `ADR-0012` §3.4).

---

## 4. The sequence

### Wave 0 — Unblock the build that already exists

**Nothing below Wave 0 matters if the product cannot lawfully ship.** No new PRD is required here.

| Order | Work | PRD | Why first |
|---|---|---|---|
| 0.1 | **`IMPL-020` SMS provider + DLT registration** | `PRD-001` | **Longest external lead time in the programme** — multi-week, not under our control. Blocks authentication *and* `IT-1` staff invitations (`IMPL-112`) |
| 0.2 | **`TASK-D10` remove demo surfaces** | `PRD-001` | **P0 release blocker** under `MP-CON-11`. Also clears the 9 gate-3 findings and lets the boundary checker exit 0 |
| 0.3 | `IMPL-015`/`016` configuration validation | `PRD-001` | Gates `IMPL-127` |
| 0.4 | `IMPL-220` `SID-INT-*` enforcement | `PRD-003` | Unblocked. Until checked, 12 rules are **unmet**, not satisfied |

> **Start 0.1 today even though it is not the most interesting work.** It is the only item whose duration is set
> by an external party, and every day it is not started is a day added to the launch date directly.

### Wave 1 — Foundations that every other PRD references

Written first because **every** subsequent PRD references their identifiers and ownership.

| Order | PRD | Context | Criterion | Why here |
|---|---|---|---|---|
| 1.1 | **`PRD-013` Tenancy** | `BC-19` | Architectural, Data | *"Nothing multi-tenant works without it."* `MP-GBR-08` cannot be enforced against a tenant key no table carries. **`IMPL-100` is already a dependency of Phase 5 authorisation** — it is numbered in Phase 8 but does not run there |
| 1.2 | **`PRD-016` Audit Trail** | `BC-24` | Architectural | Append-only, *"no update or delete path exists in code"*. Retrofitting immutability is not possible — an audit trail that was ever mutable has no evidentiary value. `X-10` is currently **unimplemented** |
| 1.3 | **`PRD-014` Entitlement** | `BC-21` | API, Security | `E-17` is called **before** every aggregate mutation. Adding it later means auditing every write path |
| 1.4 | **`PRD-017` File & Media** | `BC-29` | API | `E-22`. Already consumed by `PRD-002` (`LIB-6.6`) and `PRD-003` (`SID-4.35`) — **two frozen PRDs depend on an unwritten one** |

**Why Tenancy precedes Audit.** An audit entry without a tenant key is a cross-tenant leak in the one store that
must never leak — `MP-RSK-01`, *"highest-severity failure class in the system"* (`X-13`).

> ✅ **Wave 1's entry gate is CLEARED as of 2026-08-04. All Wave 1 items may now start.**
>
> The gate was: `PRD-013` (`BC-19`) and `PRD-017` (`BC-29`) could not state their own scope while
> `Library_PRD_v1.md` — frozen, Rank 3 — declared both contexts as **owning contexts** in its header.
> [`ADR-0013`](../adr/ADR-0013-capability-context-ownership.md) settled it and its migration was executed: the
> header now separates the one context the Library PRD **owns** (`BC-06`) from the three it **consumes through
> ports**, and the PRD stands at **v1.1**. `PGA-11` is **closed** — `BC-19` → `PRD-013`, `BC-29` → `PRD-017`, and
> `BC-25` → the newly registered **`PRD-023`** per
> [`ADR-0017`](../adr/ADR-0017-bc-25-configuration-ownership.md).
>
> **Both PRDs can now be written without contradicting or silently narrowing a frozen document** — the outcome the
> gate existed to protect. `PRD-013`'s scope is the tenancy *capability*; the `TenantOrganisation` and
> `StaffAssignment` aggregates remain `PRD-002`'s (`ADR-0013` §5), so `PRD-013` must **not** claim them.
>
> **One item is added to Wave 1 by this resolution:** `PRD-023` Settings & Configuration
> (`platform/configuration`, rank 3). It belongs in Wave 1 for the same reason as the rest — `E-19` makes every
> context a consumer of `BC-25`, and the `LCFG-*` resolution semantics currently have no owning document.
>
> ⚠ **Wave 1 still carries a different, unrelated blocker.** `IMPL-020` (SMS provider / DLT registration) is P0
> with a multi-week external approval lead time and gates any OTP delivery. It is **not** affected by this
> resolution and should be started first regardless of PRD sequencing.

### Wave 2 — The core library product

Strictly ordered by the `E-01`…`E-10` core edges. Reordering these means inventing a state that the edge table
forbids.

| Order | PRD | Context | Depends on | The edge that fixes the position |
|---|---|---|---|---|
| 2.1 | **`PRD-004` Student Management** | `BC-01` | `PRD-003` (`E-13`), Wave 1 | `E-13` — completes the `IMPL-214` ACL, currently *"partly blocked"* because full `BC-01` does not exist |
| 2.2 | **`PRD-005` Membership** | `BC-02` | `PRD-004` | `E-01` — *"Membership may not exist without an active enrollment"* |
| 2.3 | **`PRD-006` Attendance** | `BC-03` | `PRD-005`, `BC-06` | `E-03` + `E-04` |
| 2.4 | **`PRD-007` Seat Management** | `BC-04` | `PRD-005`, `PRD-006` | `E-02`, `E-05`, `E-08` — Seating **owns occupancy**; Attendance only triggers it |
| 2.5 | **`PRD-008` Revenue & Finance** | `BC-05` | `PRD-005`, `PRD-004` | `E-07`, `E-09`, `E-10` |

> **`PRD-007` carries a concurrency invariant that must survive into its requirements.** The Bounded Context Map
> states it exactly: *"One active allocation per seat per time window (pessimistic lock / DB unique constraint —
> **never optimistic**)."* `MP-RSK-04` — double seat allocation — is High. A PRD that omits this leaves the
> mechanism to the implementer, and optimistic locking will look correct in every test written by the person who
> chose it.

### Wave 3 — Platform capabilities the core now needs

| Order | PRD | Context | Why after Wave 2 |
|---|---|---|---|
| 3.1 | **`PRD-015` Search Indexing** | `BC-23` | `E-21`. Needs `BC-01` and `BC-10` field sets to index. Also carries `PRD-002`'s public discovery projection |
| 3.2 | **`PRD-010` Notifications** | `BC-22` | `E-23`. Needs real facts to notify about. Domain emits *facts*, never *"send an SMS"* |
| 3.3 | **`PRD-018` Offline Sync** | `BC-30` | `E-24`. **Attendance defines the conflict policy; Sync executes it** — so `PRD-006` must exist first |
| 3.4 | **`PRD-019` Integration** | `BC-31` | `E-25`. Needs a first real outbound contract |

### Wave 4 — Safety, and the risk that is being carried

| Order | PRD | Context | Criterion | Note |
|---|---|---|---|---|
| 4.1 | **`PRD-020` Trust & Safety** | `BC-13` `[CORE]` | **Security, Business** | ⚠ See below |
| 4.2 | **`PRD-021` Social Graph & Messaging** | `BC-11`, `BC-12` | Business | `E-16` — Messaging must ask the graph; **block enforcement lives in the graph** |

> ⚠ **`PRD-020` is scheduled after the core product, and that is a decision with a cost.** `BC-13` is `[CORE]`
> *despite living in a Supporting platform* because *"on a minor-heavy product this is existential legal risk,
> not a commodity."* `MP-RSK-02` is **Critical**, and its stated mitigation is *"`BC-13` Trust & Safety at V1"*.
>
> The sequencing is nonetheless correct: T&S acts **on** other contexts via `EnforcementActionTaken` (`E-14`),
> so there must be something to act on. **The mitigating constraint is a gating rule, not an earlier date** —
> `PRD-021` must not ship before `PRD-020`. Shipping messaging between minors with no moderation case model is
> the precise scenario `MP-RSK-02` describes.
>
> **If `PRD-021` slips ahead of `PRD-020`, that is a release-blocking defect, not a schedule change.**

### Wave 5 — Read models, assistance, commerce

| Order | PRD | Context | Note |
|---|---|---|---|
| 5.1 | **`PRD-009` Analytics & Reports** | `BC-26` | Projections over Waves 2–3. **Unblocks dashboards** (modules 10–12), which are compositions and need no PRD |
| 5.2 | **`PRD-011` AI Super Assistant** | `BC-27` | `E-26` — retrieves through **permission-aware ports only**, never direct index or table access |
| 5.3 | **`PRD-022` SaaS Billing** | `BC-20` | Money **library → LIBOORA**. Never `BC-05` |
| 5.4 | **`PRD-012a` Security automation** / **`PRD-012b` Workflow** | SECURITY / `BC-28` | **Two documents, never one** — Master PRD §8 Correction 2 |

---

## 5. Critical path

```
IMPL-020 (SMS/DLT, external) ──► TASK-D10 ──► releasable authentication
        │
        └──► PRD-013 Tenancy ──► PRD-016 Audit ──► PRD-014 Entitlement
                                                          │
                                                          ▼
                    PRD-003 (done) ──► PRD-004 Student ──► PRD-005 Membership
                                                          │
                                          ┌───────────────┼───────────────┐
                                          ▼               ▼               ▼
                                    PRD-006 Attend   PRD-007 Seat   PRD-008 Finance
                                          │
                                          ▼
                                    PRD-018 Offline Sync
```

**The longest chain is not the one with the most documents.** It is `IMPL-020` — a multi-week external DLT
registration with a single-line dependency on nobody in the team.

**Parallelisable now, with no new specification:** `IMPL-220` (`SID-INT-*` enforcement), the `X-13` and `X-10`
checker categories, and the 23 open Library tasks — `PRD-002` is frozen and complete, so `IMPL-100`…`IMPL-127`
need no further specification work.

---

## 6. Sequencing rules that must not be broken

1. **`PRD-013` Tenancy before any new aggregate.** *"Every table created before it exists is a table that will
   need migrating."*
2. **`PRD-016` Audit before the first auditable action.** Immutability cannot be retrofitted.
3. **`PRD-020` T&S before `PRD-021` social.** A release-blocking constraint, not a preference.
4. **Identity creation with account creation.** `IMPL-203` lands with `IMPL-031`, never after — the amended
   `MP-GBR-02` provides no lawful intermediate state.
5. **Never split a `[CORE]` context across two PRDs**, and never merge two owners into one (`PRD-012`).
6. **Every new PRD gets its identifier prefix registered** in `TRACEABILITY_MATRIX.md` §2 **before** requirements
   are written — the `PO-n`/`SPO-n` near-collision is the worked example of what this prevents.

---

## 7. What this roadmap deliberately does not schedule

| Item | Why |
|---|---|
| `MP-FUT-01`…`05` — Global Student Network, School, College, Coaching, Hostel | EA §10.3: *"do not design for it now, only avoid blocking it."* `ADR-0011` already did the not-blocking part |
| `BC-07`…`BC-09`, `BC-14`, `BC-15`, `BC-28` | V2 |
| `BC-16`, `BC-17` | V3 |
| Reviews & Ratings | V2 — **no bounded context assigned**; assigning one is an architecture change requiring an ADR |
| Public Live Occupancy | V2 — deferred pending privacy review |
| Dashboards, Parent Portal, Member Directory | Compositions. They own no aggregate and need no PRD |

---

## 8. References

[`IMPLEMENTATION_ROADMAP.md`](../../40-implementation/IMPLEMENTATION_ROADMAP.md) ·
[`LIBRARY_IMPLEMENTATION_TASKS.md`](../../40-implementation/LIBRARY_IMPLEMENTATION_TASKS.md) ·
[`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md`](../../40-implementation/STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md) ·
[`IMPLEMENTATION_STATUS.md`](../../40-implementation/IMPLEMENTATION_STATUS.md) ·
[`MASTER_PRD.md`](../../30-product/MASTER_PRD.md) §32 ·
[`LIBOORA_BOUNDED_CONTEXT_MAP.md`](../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) §7 ·
[`PRD_REGISTRY.md`](./PRD_REGISTRY.md) ·
[`PRD_DEPENDENCY_GRAPH.md`](./PRD_DEPENDENCY_GRAPH.md) ·
[`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md)

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created. Six waves sequencing 18 unwritten PRDs plus the unblocking work for 3 frozen ones. Ordering derived from the Bounded Context Map §7 edges, Master PRD §32 version tags and the existing task roadmap — **no phase, task or priority in `IMPLEMENTATION_ROADMAP.md` was changed, renumbered or contradicted**. Records that `PRD-020` Trust & Safety is scheduled after the core product and states the gating rule that keeps `MP-RSK-02` mitigated (§4 Wave 4). No requirement created or modified; no PRD edited. |
