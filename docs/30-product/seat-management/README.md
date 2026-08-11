# Seat Management — Module Index

**Owning context:** `BC-04` Seating — `[CORE]`, Library Management domain, tenant-scoped
**Specification:** `PRD-007` Seat Management — [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) **v1.0**
**Status:** 🔵 **`FROZEN` v1.0 — Stage 7.** Admitted to the documentation baseline at **Rank 3** by
[`ADR-0020`](../../00-governance/adr/ADR-0020-seat-management-prd-v1.0-baseline.md) under `BASELINE-2026-08-04-E`
**Reviewed:** Stage 4 verdict **A — PASS** (0/0/0/0, after four correction passes and two re-reviews) ·
Stage 5 **A** · Stage 6 **A** · Stage 7 **A**
**Implemented:** **Nothing.** 0 of 100 tasks · 0 of 226 acceptance criteria proven

> **This is a navigation index only. It carries no requirement and no authority.**
> Where this page and `PRD-007` disagree, `PRD-007` governs. Where `PRD-007` and a ranked document
> disagree, the ranked document governs ([`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §4).

> **`FROZEN` is not `VERIFIED`.** The specification is settled; the software does not exist. `SEAT-NFR-011`,
> quoting `SID-4.56`, holds that *a rule that cannot be checked shall be treated as unmet* — so nothing here
> claims `BC-04` works.

---

## What this module is

`BC-04` answers one question: **who holds the right to which seat, and when.** It owns exactly two aggregates
(`SEAT-FR-006`), and one command never mutates both (`SEAT-FR-007`).

```
BC-04 Seating  — [CORE], rank 10                         ← THIS MODULE
├── SeatAllocation    the held right to a seat
└── SeatLayout        floors · zones · seats · layout versions

consumes ─────────────────────────────────────────────────────────────────
  BC-01 Enrollment  (E-01)  enrollment status permits seating   → gate G6
  BC-02 Membership  (E-02)  membership validity                 → gate G7 ◄ no override
  BC-03 Attendance  (E-08)  the punch — "Seating is the occupancy owner,
                             Attendance is the trigger"     ⚠ PRD-006 PLANNED
  BC-06 Library Policy (E-05) · BC-21 Entitlement (E-17)
  BC-19 Tenancy     (E-18)  ambient TenantContext             → gate G1
  BC-25 Configuration (E-19)

publishes ────────────────────────────────────────────────────────────────
  BC-24 Audit Trail (E-20, fire-and-forget) · BC-22 Notification facts (E-23)
  BC-22 capacity alerting · BC-26 Analytics
```

**Seven inbound edges, three outbound, none new.** The bounded-context count remains **31**. An edge absent from
BC Map §7 *does not exist* and adding one requires an ADR.

**`Occupancy` and `Occupied` are different things.** `Occupancy` is physical presence, derived from `E-08`;
`Occupied` is a derived `SeatState` meaning an allocation exists. A seat can be `Occupied` with nobody in it.

## The two ideas that decide most of the design

**One acquisition gate, sixteen checks, one order** (`SEAT-FR-052`). All nine acquisition paths — staff assignment,
student booking, reservation approval, reservation conversion, auto-assignment, QR assignment, transfer, bulk
reassignment, bulk import — evaluate `G1`…`G16` in exactly that order and stop at the first failure. **`G7`
membership validity is overridable by no role, including Owner** (`SEAT-BR-014`, `SEAT-XC-004`); `G16` runs under a
pessimistic lock held to commit (`SEAT-BR-015`).

**`SeatState` is derived, never stored** (`SEAT-FR-037`) — from five independent facts, first match wins:
maintenance → `Maintenance`, allocation → `Occupied`, unexpired reservation → `Reserved`, else `Available`. A
stored, directly settable status that can contradict those facts **must not exist** (`SEAT-XC-002`).

---

## Documents

| Document | Purpose |
|---|---|
| [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) | **The specification. `FROZEN` v1.0, Rank 3.** 36 chapters, 683 identifiers, 226 acceptance criteria |
| [`PRD-007_DEVELOPER_GUIDE.md`](../../40-implementation/seat-management/PRD-007_DEVELOPER_GUIDE.md) | **Start here if you are writing code.** The seven traps most likely to be got wrong, read order, honest state |
| [`PRD-007_IMPLEMENTATION_TASKS.md`](../../40-implementation/seat-management/PRD-007_IMPLEMENTATION_TASKS.md) | The backlog — 100 tasks, `IMPL-500`…`IMPL-599`, ten waves. **A backlog record, not a ranked document** |
| [`PRD-007_STAGE7_FREEZE.md`](PRD-007_STAGE7_FREEZE.md) | **Stage 7 gate record.** What was frozen, what changed, and `GCP-09` |
| [`PRD-007_STAGE6_IMPLEMENTATION_TASKS.md`](PRD-007_STAGE6_IMPLEMENTATION_TASKS.md) | Stage 6 gate record — verdict **A**, 8 gates, 8/8 negative tests |
| [`PRD-007_STAGE5_TRACEABILITY.md`](PRD-007_STAGE5_TRACEABILITY.md) | Stage 5 gate record — verdict **A** |
| [`PRD-007_STAGE4_FINAL_REVIEW.md`](PRD-007_STAGE4_FINAL_REVIEW.md) | Stage 4 gate record — verdict **A**, 0/0/0/0, eight candidate findings rejected with evidence |
| [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) | Repository-wide traceability. `SEAT-*` prefixes registered in §2E |

### Review and correction history

Nine further records, retained as validation evidence rather than merged, because each documents *what was wrong and
how it was decided* — the reasoning is the value:

| Document | What it records |
|---|---|
| [`PRD-007_REQUIREMENTS_REVIEW.md`](PRD-007_REQUIREMENTS_REVIEW.md) | First full requirements review |
| [`PRD-007_ARCHITECTURE_ALIGNMENT.md`](PRD-007_ARCHITECTURE_ALIGNMENT.md) | Alignment against BC Map, Dependency Matrix and rulings |
| [`PRD-007_INDEPENDENT_GAP_VERIFICATION.md`](PRD-007_INDEPENDENT_GAP_VERIFICATION.md) | Independent verification of the gap register |
| [`PRD-007_STAGE4_REREVIEW.md`](PRD-007_STAGE4_REREVIEW.md) · [`PRD-007_STAGE4_REREVIEW_2.md`](PRD-007_STAGE4_REREVIEW_2.md) | Two adversarial re-reviews |
| [`PRD-007_STAGE4_FINDINGS_CORRECTION.md`](PRD-007_STAGE4_FINDINGS_CORRECTION.md) · [`PRD-007_STAGE4_COMPREHENSIVE_CORRECTION.md`](PRD-007_STAGE4_COMPREHENSIVE_CORRECTION.md) | Correction rounds |
| [`PRD-007_CORRECTION_RECORD.md`](PRD-007_CORRECTION_RECORD.md) · [`PRD-007_SR-1_CORRECTION_RECORD.md`](PRD-007_SR-1_CORRECTION_RECORD.md) | Per-finding correction records |

---

## Chapter map

| §§ | Content |
|---|---|
| 0 | Document control · identifier registers · relationship to the source draft |
| 1–3 | Purpose and scope · ubiquitous language · architectural position |
| **4–7** | Spatial model · seat identity and the layout editor · **the derived state model** · the allocation model |
| **8** | **The acquisition gate — `G1`…`G16`, one order for every path** |
| 9–13 | Staff assignment, release, transfer · seat-change requests · student self-booking · **booking vs reservation vs assignment** · the seat card |
| **14** | **The Attendance boundary — occupancy without duplicate ownership** |
| 15–20 | Reservations · fixed and flexible seating and shifts · categories and eligibility · membership integration · locking, maintenance, bulk operations · automatic and QR assignment |
| 21–22 | Real-time sync, concurrency and idempotency · domain events and work queues |
| 23–26 | **History — five kinds, five owners** · notifications (facts only) · operational metrics · search and filters |
| 27–29 | Configuration register · roles, protected operations and privacy · multi-tenancy |
| 30–32 | Edge case audit · **gap register** · non-functional requirements |
| **33** | **Acceptance criteria — all 226, grouped §33.1…§33.13** |
| 34–37 | V1 scope classification · change log against the source draft · completeness checklist · document change history |

---

## Registers

| Register | Range | Meaning | Closed? |
|---|---|---|---|
| `SEAT-FR-*` | `001`…**`304`** | Functional requirement | No |
| `SEAT-BR-*` | `001`…**`045`** | Business rule, cross-cutting and testable | No |
| `SEAT-INV-*` | `001`…**`014`** | Domain invariant, enforced synchronously inside the aggregate | No |
| `SEAT-EVT-*` | `001`…**`004`** | Domain event | **Yes** — closed at four by `SEAT-FR-206`, fixed by BC Map §9 |
| `SEAT-XC-*` | `001`…**`022`** | Exclusion — must be impossible, or out of scope | No |
| `SEAT-PO-*` | `001`…**`024`** | Protected operation | **Yes** — closed list |
| `SEAT-CFG-*` | `001`…**`018`** | Configurable, with an owner and a default | No |
| `SEAT-NFR-*` | `001`…**`012`** | Non-functional requirement | No |
| `SEAT-AC-*` | `001`…**`226`** | Acceptance criterion | No |
| `SEAT-GAP-*` | `001`…**`014`** | **Open question — NOT a requirement.** Must never be cited as verifiable (§0.3) | No — all 14 **OPEN** |

**683 identifiers.** Ranges are contiguous; numbers are never reused. The prefix is `SEAT-*` and not `SM-*` because
`SM-*` belongs to `PRD-004`, which is frozen — on collision the **new** prefix changes, never the existing one
(`PRD_LIFECYCLE.md` §5 rule 3).

**Of 443 criterion-verifiable obligations, 100 tasks claim 443 (100.0%) but acceptance criteria cite 325 (73.4%).**
The four registers `SEAT-FR-302` mandates are fully covered at 85/85; the 118-obligation shortfall is 86 `SEAT-FR`,
5 `SEAT-NFR`, 18 `SEAT-PO`, 9 `SEAT-CFG`, named rather than rounded away.

---

## Declared edges this module uses

| Edge | Direction | Purpose |
|---|---|---|
| `E-01` | in ← `BC-01` Enrollment | Enrollment status permits seating — gate `G6` (`SEAT-BR-013`) |
| `E-02` | in ← `BC-02` Membership | Membership validity — gate `G7`, **no role may override** |
| `E-05` | in ← `BC-06` Library Policy | Policy inputs |
| `E-08` | in ← `BC-03` Attendance | The punch. **Seating owns occupancy; Attendance is the trigger** |
| `E-17` | in ← `BC-21` Entitlement | `check(tenantId, feature, delta)` — gate `G4` |
| `E-18` | in ← `BC-19` Tenancy | Ambient `TenantContext` — gate `G1`; **never a method parameter** |
| `E-19` | in ← `BC-25` Configuration | Tenant configurables |
| `E-20` | out → `BC-24` Audit Trail | Privileged-operation audit, fire-and-forget. **The audit log is not stored here** |
| `E-23` | out → `BC-22` Notification Delivery | Notification **facts only** — never rendered messages |
| — | out → `BC-22` | Capacity alerting |

**If an edge is not in the Map's §7 table, it does not exist.** `X-13` also applies: this module *consumes*
authorisation and never evaluates, grants or caches it.

---

## Current state, honestly

- **No seating code exists.** 0 of 100 tasks started, 0 of 226 acceptance criteria proven by a test.
- **The specification is frozen at Rank 3.** Any business-rule change now requires **an ADR before the change**,
  then a version increment, a changelog entry and a baseline update — in that order.
- **`PRD-006` Attendance is still `PLANNED`.** Occupancy is derived from `E-08`, so a seating module built today
  would hold allocations correctly and derive **no live occupancy**. `PRD-007` is the first frozen PRD in this
  repository whose own dependency is unwritten. Recorded as `SEAT-GAP-009`; build the boundary as a port
  (`SEAT-FR-108`…`117`) and do not fake the punch.
- **All fourteen `SEAT-GAP-*` are OPEN and were not ratified by freeze.** `SEAT-BR-045` forbids resolving any of
  them by implementation choice; the backlog assigns them no task and names six tempting tasks that must not be
  created.
- **118 obligations carry no acceptance criterion.** Implementing one means writing the first check of it.
- **Ten citations in the PRD point at the wrong rule** — `GCP-09`, disclosed and **deliberately unfixed** because a
  frozen PRD is never silently modified. Three of the ten are in the §8 gate table, the most-read table in the
  document. **Read [`PRD-007_STAGE7_FREEZE.md`](PRD-007_STAGE7_FREEZE.md) §8A before following an *Authority*
  pointer**, and do not search-and-replace: the same identifiers are cited correctly six times elsewhere.
- **Pipeline gate 3 is already RED** repository-wide, on 9 pre-existing `app → domain/library` violations. These are
  **not waived.** `ADR-0012` §3.4 deliberately withholds a waiver because the sites are already tracked by
  **`TASK-D10`** (`BLK-01`), a **P0 release blocker**, and waiving them *"would convert a tracked release blocker
  into untracked debt."* The red gate is the intended signal that `TASK-D10` is not done, and it **stays red until
  `TASK-D10` is completed** — there is no expiry date to wait out, unlike the 12 dated exceptions in the same ADR.
  **Pre-existing and unrelated to `PRD-007`**: all nine date to the original scaffold commit and none was
  introduced by this module. Do not waive it, do not silence the checker, and do not add a tenth violation.

---

## Related

| Link | Why |
|---|---|
| [`DEVELOPER_HANDOFF.md`](../../40-implementation/DEVELOPER_HANDOFF.md) | Repository-wide onboarding and the seven common traps — read before the module guide |
| [`ADR-0020`](../../00-governance/adr/ADR-0020-seat-management-prd-v1.0-baseline.md) | The decision that froze this PRD and what it explicitly does **not** close |
| [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) | §3.3 holds the gate row; §4 the precedence rank; §6 `GCP-09` |
| [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) | The nine stages, and what may change in a frozen document |
| [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) | §2.1 — why status is conferred and never read off a PRD |
| [`MASTER_PRD.md`](../MASTER_PRD.md) | Rank 1. `MP-GBR-16` is the rule behind gate `G7` |
| [`membership-management/`](../membership-management/) · [`student-management/`](../student-management/) | The two frozen upstream modules on the `E-01`/`E-02` chain |
