# Seat Management — Developer Guide

| Field | Value |
|---|---|
| **Document** | `PRD-007` Seat Management — developer guide |
| **Module** | **`BC-04` Seating** — `[CORE]`, Library Management domain |
| **Specification** | [`PRD-SEAT-MANAGEMENT.md`](../../30-product/seat-management/PRD-SEAT-MANAGEMENT.md) **v1.0**, **`FROZEN`** |
| **Backlog** | [`PRD-007_IMPLEMENTATION_TASKS.md`](./PRD-007_IMPLEMENTATION_TASKS.md) — 100 tasks, `IMPL-500`…`IMPL-599` |
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
| **Authority** | **Navigational and explanatory only. This document carries no requirement and no authority.** Where it disagrees with the frozen PRD, **the PRD is right and this guide is a defect** |
| **Status of the code** | **Nothing is implemented.** 0 of 100 tasks started · 0 of 226 acceptance criteria proven |

> **Read this after [`DEVELOPER_HANDOFF.md`](../DEVELOPER_HANDOFF.md), not instead of it.** That document's §4 lists
> the seven traps that apply to every module in this repository. This one adds the traps specific to seating.
>
> **This guide paraphrases. It never restates a rule as normative.** Every claim below carries the identifier it
> came from, so you can check it against the frozen text in one search. If you find a disagreement, the PRD wins —
> and the disagreement is a bug in this file.

---

## 1. What `BC-04` Seating is

A `[CORE]` bounded context that answers one question: **who holds the right to which seat, and when.**

It owns **exactly two aggregates** (`SEAT-FR-006`):

```
BC-04 Seating
├── SeatAllocation   the held right to a seat  (assignments, bookings, transfers)
└── SeatLayout       the spatial arrangement   (floors, zones, seats, layout versions)
```

**One aggregate per transaction** (`SEAT-FR-007`). A single command never mutates both.

### 1.1 What it owns that surprises people

| Concept | Owner | Why it lands here |
|---|---|---|
| **Whether a seat is physically in use right now** | **this module** | BC Map `E-08`: *"Seating is the occupancy owner, Attendance is the trigger"* |
| Live occupancy count per zone / floor | **this module** | Derived from `E-08` events |
| Seat utilisation across the operating day | **this module** | As an *operational count*, not analytics (§25) |

### 1.2 What it must never own

| Concept | Real owner | Rule |
|---|---|---|
| Attendance punches, verification evidence, `AttendanceDay`, corrections | `BC-03` Attendance | `SEAT-BR-020` |
| Attendance totals, percentages, streaks | `BC-03` / `BC-26` | §14.1 |
| Membership validity, plan→category mapping | `BC-02` Membership | `SEAT-BR-023` |
| Money, invoices, refunds | `BC-05` Fee & Collection | §1 scope |
| Authorisation decisions | `BC-18` / platform | `X-13` |
| The audit log | `BC-24` Audit Trail | `SEAT-BR-033`, `E-20` |
| Notification delivery | `BC-22` | §24 |

### 1.3 Boundaries — 7 in, 3 out, none new

Inbound: `E-01` enrollment status · `E-02` membership · `E-05` library policy · `E-08` attendance ·
`E-17` entitlement · `E-18` tenancy · `E-19` configuration.

Outbound: `E-20` audit (fire-and-forget) · `E-23` notification facts · capacity alerting.

**Do not add an edge.** BC Map §7 is the register of edges and its line 292 holds that an edge absent from that
table *does not exist*; adding one requires an ADR. The bounded-context count is **31** and this module does not
change it.

---

## 2. Read in this order

| # | Document | Why |
|---|---|---|
| 1 | [`DEVELOPER_HANDOFF.md`](../DEVELOPER_HANDOFF.md) §§1–5 | Repository-wide ground rules and the seven common traps |
| 2 | **This guide** §§3–5 | The seating-specific traps, before you read 2,851 lines |
| 3 | PRD §§0–3 | Identifier scheme, ubiquitous language, architectural position |
| 4 | **PRD §6 and §8** | The derived state model and the acquisition gate — **the two sections that decide most of the design** |
| 5 | PRD §12 | Booking vs Reservation vs Assignment vs Allocation |
| 6 | PRD §14 | The Attendance boundary |
| 7 | [`PRD-007_IMPLEMENTATION_TASKS.md`](./PRD-007_IMPLEMENTATION_TASKS.md) §§3–6 | Wave order and what each wave may claim |
| 8 | PRD §33 | The 226 acceptance criteria — **your definition of done** |
| 9 | [`PRD-007_STAGE7_FREEZE.md`](../../30-product/seat-management/PRD-007_STAGE7_FREEZE.md) §8A | **`GCP-09`** — ten citations that point at the wrong rule |

**Working on a specific area?**

| Area | Read |
|---|---|
| Any acquisition path | §8 in full, then §9 · §11 · §12 · §15 · §20 |
| Seat state, locking, maintenance | §6, then §19 |
| Occupancy | §14, then §25 |
| Concurrency | §21, then `SEAT-BR-015` and `SEAT-BR-031` |
| Anything at all | §29 multi-tenancy — it applies to every row you write |

---

## 3. The acquisition gate — the single most important thing in this module

`SEAT-FR-052`: **every** operation that creates or moves an allocation, or creates a reservation, evaluates
**sixteen gates in exactly this order and stops at the first failure.** Nine paths share it: staff assignment,
student booking, reservation approval, reservation conversion, auto-assignment, QR assignment, transfer, bulk
reassignment, bulk import.

```
G1  tenant context resolved         G9   seat exists in this tenant
G2  actor authorised                G10  floor and zone active
G3  idempotency — replay?           G11  not in maintenance
G4  entitlement check               G12  not locked (or actor may override)
G5  student exists                  G13  seat category eligibility
G6  enrollment status permits       G14  shift compatibility
G7  membership validity  ◄ absolute G15  no conflicting reservation
G8  seatQuota not exceeded          G16  no conflicting allocation ◄ under a lock
```

**Why one list and not nine.** The source draft described five features each with its own checks. Five lists drift.
If you implement a tenth path with its own checks, you have recreated the defect this section exists to remove —
and `SEAT-XC-003` says an acquisition path that skips or reorders these gates **must not exist**.

### 3.1 Order is behaviour, not style

- **G3 before G4.** A replayed request returns the prior result and must **not** consume entitlement twice.
- **G2 and G5 are indistinguishable to the caller.** *Not found* and *no permission* return the same thing, because
  distinguishing them tells an unauthorised caller that a student exists (`MP-GBR-22`).
- **G16 last, under a pessimistic lock held to commit** (`SEAT-BR-015`). A read-then-write check without a lock *is
  defective even when it appears to work*.
- **A failure mutates nothing** (`SEAT-FR-054`) — no allocation, no reservation, no history row, no event.

---

## 4. The seven things most likely to be got wrong

Read alongside `DEVELOPER_HANDOFF.md` §4. Each has tasks in the backlog.

### 1. Building an "assign anyway" override for G7 ⚠ severity: seats a student with no valid membership

`SEAT-BR-014`: G7 is **absolute and applies to every role, including Owner.** `SEAT-XC-004`: an override capability
**must not exist in any role, any screen, any bulk operation or any import.**

This will be *requested*, and it will be requested by someone senior, because the source draft said *"the Owner can
override reservations"* and *"reception can assign any available seat."* Both are true and neither reaches through
`MP-GBR-16`. The distinction to hold on to:

- Overriding a **reservation** — a `BC-04` fact — **is permitted** (`SEAT-FR-162`, `SEAT-PO-010`).
- Overriding **membership validity** — a `BC-02` fact — **is not**, by anyone.

A "force assign" button is not a feature request; it is a request to relocate `BC-02`'s invariant into `BC-04`,
where nothing can enforce it.

### 2. Storing `SeatState` ⚠ severity: a status column that silently disagrees with reality

`SEAT-FR-037`: `SeatState` is **derived** from five independent facts — container active, maintenance record, lock
flag, active reservation, active allocation — by a total function, first match wins:

```
maintenance active?  → Maintenance
active allocation?   → Occupied
unexpired reservation? → Reserved
otherwise            → Available
```

`SEAT-BR-010`: it **must not** be stored as an independently mutable value code can set. `SEAT-XC-002`: a stored,
directly settable status that can contradict the five facts **must not exist**.

A `status` column is the obvious design and it is wrong here. The moment one exists, some path will set it directly,
and a seat will read `Available` while holding an allocation. Note also `SEAT-BR-009`: the five facts are
**independent** — setting one must never implicitly clear another. Every transition in §6.4 is explicit.

**Maintenance outranks occupancy** deliberately: a physically unusable seat is unusable regardless of paperwork.

### 3. Recording attendance ⚠ severity: duplicates a bounded context

`SEAT-BR-020`: this module **must not create, store, modify, delete or verify an attendance record.** It consumes
`E-08` and derives occupancy.

The trap is shaped like a convenience: you need occupancy, `E-08` is not there yet, so you add a `checkedInAt`
column "temporarily". You now own attendance in two contexts with no rule reconciling them.

**Occupancy is yours. The punch is not.** And note `SEAT-FR-115`-family behaviour: a check-in from a student with no
allocation is **never rejected** — attendance is not gated on seating.

### 4. Collapsing the five histories into one log ⚠ severity: destroys audit evidence

§23 distinguishes five concerns with five owners:

| Kind | Owner | Storage |
|---|---|---|
| Allocation history | `BC-04` | Stored — the retained `SeatAllocation` records |
| Transfer history | `BC-04` | **Derived** by walking allocation linkage — not a second log |
| Reservation history | `BC-04` | Stored — the retained `Reservation` records |
| Seat timeline | `BC-04` | **Derived projection** — never a system of record |
| **Audit log** | **`BC-24`** | **Not stored here** — emitted via `E-20` |

`SEAT-BR-033`: they **must not** be collapsed. *A fact recorded only in the timeline is a defect, because the
timeline is rebuildable and therefore not evidence.* One `seat_events` table looks like good normalisation and
quietly makes the audit trail mutable by the module it is supposed to audit.

### 5. Treating real-time sync as truth ⚠ severity: two students in one seat

`SEAT-FR-194`: real-time delivery is an **optimisation, never the source of truth**. A lost update must not produce
a wrong decision, because every acquisition re-evaluates §8 server-side under a lock.

If the client decides a seat is free from its socket state and the server trusts that, you have moved G16 to the
client. `SEAT-BR-031`: two concurrent attempts yield **exactly one success and one distinguishable failure** — a
silent overwrite or last-write-wins is defective. Also `SEAT-FR-195`: payloads carry derived state, lock flag and
occupancy flag **only** — never the holder's name or membership data.

### 6. Passing `tenantId` as a parameter ⚠ severity: unenforceable isolation

`SEAT-FR-288`: tenant context comes from the **ambient `TenantContext`** of `E-18` and **must not** be passed
through domain methods. `SEAT-INV-009`: a query that *could* execute without a tenant predicate **must not exist**.
`SEAT-FR-289`: where context cannot be resolved, the operation **fails loudly**.

A `tenantId` parameter is only enforceable by everyone remembering it. `SEAT-FR-287` requires it on every seat,
floor and zone reference, layout version, category, allocation, reservation, maintenance record, lock, occupancy
fact, filter preset **and idempotency key** — an idempotency key without a tenant is a cross-tenant replay.

### 7. Resolving a `SEAT-GAP-*` in code ⚠ severity: makes an undecided question permanent

`SEAT-BR-045`: **no gap may be resolved by implementation choice.** PRD §0.3: gaps *"are questions, not
requirements, and must never be cited as verifiable."*

Fourteen are open. The backlog assigns them **no task** and names six tempting tasks that must not be created. When
you reach one, you are blocked by governance, not by difficulty: it needs a decision from its owner and — now that
the PRD is frozen — an ADR if the answer changes a business rule.

---

## 5. Vocabulary that is easy to get wrong

`SEAT-FR-085`, and worth learning before writing a class name:

| Term | What it is |
|---|---|
| **Booking** | the *student-initiated act* |
| **Assignment** | the *staff-initiated act* |
| **Reservation** | a *time-bounded hold* — either act may produce one |
| **Allocation** | the *held right to the seat* |

**A booking is not a reservation, and a reservation is not an allocation.**

What a booking produces is a **tenant configurable**, `SEAT-CFG-010` (`SEAT-BR-018`), with a closed value set:
`Direct` → allocation immediately · `HoldThenConfirm` → reservation first · `ApprovalRequired` → pending request
(**default**). One value per tenant; two modes must never be simultaneously effective.

Also distinguish: **`Occupancy`** is physical presence, derived from `E-08`; **`Occupied`** is a derived `SeatState`
meaning an allocation exists. A seat can be `Occupied` with nobody in it.

---

## 6. Working the backlog

100 tasks, `IMPL-500`…`IMPL-599`, in ten waves. Start at **`IMPL-500`** — it is the single root, and the graph has
one leaf (`IMPL-599`, the harness proving all 226 criteria) and a critical path of 18.

**Wave order is not a suggestion.** Each wave's *Requirements claimed* column is what that wave may legitimately
close; claiming a requirement in an earlier wave than the backlog allows means claiming it without its
prerequisites. Priorities: 64 P1 · 32 P2 · 4 P3.

**Before you open a pull request** — `DEFINITION_OF_DONE.md` v1.2 and the six pipeline gates in Dependency Matrix
§10.4, two of which block merge:

```
1  dart format
2  flutter analyze
3  dart run tool/check_module_boundaries.dart   ◄ blocks merge
4  flutter test test/architecture/              ◄ blocks merge
5  flutter test
6  flutter build web --release
```

> **Gate 3 is already RED** on 9 pre-existing `app → domain/library` violations, waived to 2026-10-31 by `ADR-0012`
> (`BLK-01` / `TASK-D10`). It is not your change that broke it — and do not add a tenth violation on the grounds
> that it is red anyway.

**Do not put a `SEAT-*` identifier in a `tool/`, `lib/` or `test/` path or filename.** The Stage 5 gate forbids
identifier leakage outside the specification directory and the traceability matrix. Cite identifiers in comments
and test names, not in file paths.

---

## 7. Current state, honestly

- **No seating code exists.** 0 of 100 tasks started; 0 of 226 acceptance criteria proven by a test.
- **The specification is frozen**, so the design questions it answers are settled. Any change to a business rule
  now needs an **ADR before the change**, then a version increment, changelog and baseline update, in that order.
- **`PRD-006` Attendance does not exist yet.** It is still `PLANNED`. Because occupancy is derived from `E-08`, a
  seating module built today would hold allocations correctly and derive **no live occupancy**. Build the boundary
  as a port (`SEAT-FR-108`…`117`) and do not fake the punch. Recorded as `SEAT-GAP-009`.
- **Fourteen `SEAT-GAP-*` decisions are open.** They are not yours to close.
- **118 of 443 obligations carry no acceptance criterion** — 86 `SEAT-FR`, 5 `SEAT-NFR`, 18 `SEAT-PO`, 9
  `SEAT-CFG`. The four registers `SEAT-FR-302` mandates are fully covered (85/85); overall coverage is
  **325/443 = 73.4%**. Where you implement an uncovered obligation, you are writing the first check of it, and
  `SEAT-NFR-011` — quoting `SID-4.56` — holds that *a rule that cannot be checked shall be treated as unmet*.
- **Ten citations in the PRD point at the wrong rule** (`GCP-09`, disclosed and deliberately unfixed). Three are in
  the §8 gate table you will read most often. See §8 below **before** you follow an *Authority* pointer.

---

## 8. `GCP-09` — do not trust these ten pointers

Found while writing this guide, **after** every gate had passed. `SEAT-BR-018`, `SEAT-BR-020` and `SEAT-BR-022` were
renumbered in a Stage 4 correction pass; the prose moved and these pointer columns did not. **The rules themselves
are correct and unambiguous — only the cross-references are wrong.**

| Where | Cites | Which actually defines | Read instead |
|---|---|---|---|
| §8 gate table **G11** *Not in maintenance* | `SEAT-BR-020` | attendance non-ownership | `SEAT-FR-043`, `SEAT-BR-026` |
| §8 gate table **G12** *Not locked* | `SEAT-BR-018` | booking mode | **`SEAT-BR-025`** |
| §8 gate table **G15** *No conflicting reservation* | `SEAT-BR-011` | one **allocation** per seat | `SEAT-INV-004`, `SEAT-FR-042` |
| §6.4 invalid transitions — 3 rows | `SEAT-BR-020`, `SEAT-BR-018` | as above | `SEAT-FR-043`, `SEAT-BR-027`, `SEAT-BR-025` |
| §6.3, §6.4, §16.1 — 4 parentheticals | `SEAT-BR-020`, `SEAT-BR-022` | attendance; flexible-shift sharing | **`SEAT-BR-026`** |

**Do not "fix" these.** A frozen PRD is never silently modified — `PRD_LIFECYCLE.md` Stage 7, *"not for an obvious
correction, and not for one that is certainly right."* It needs a clarifying-wording pass with a changelog entry,
owned by the `BC-04` specification owner.

**And do not search-and-replace.** All three identifiers are cited **correctly** elsewhere — `SEAT-AC-212` for
booking mode, the attendance rows for `SEAT-BR-020`, the flexible-seat rows for `SEAT-BR-022`. Six such citations
were checked and confirmed correct. A blanket replace would introduce six defects while fixing ten.

Full analysis: [`PRD-007_STAGE7_FREEZE.md`](../../30-product/seat-management/PRD-007_STAGE7_FREEZE.md) §8A.

---

## 9. When documents disagree

Precedence, from `DOCUMENTATION_BASELINE.md` §4 — **higher rank wins, always**:

```
Rank 1  MASTER_PRD.md, DOCUMENTATION_BASELINE.md
Rank 2  ADRs  (incl. ADR-0020, which froze this PRD)
Rank 3  PRD-SEAT-MANAGEMENT.md  ◄ this module's specification
Rank 4  Bounded Context Map, Module Dependency Matrix
Rank 5  ARCHITECTURE_RULINGS.md
        ── everything below this line is navigational ──
        this guide · the task backlog · the module README · gate records
```

So: if this guide contradicts the PRD, **the PRD wins**. If the PRD contradicts the Master PRD or an ADR, **they
win** — and the contradiction is a finding to raise, not a decision for you to make in code. Do not resolve a
conflict between two ranked documents by choosing one in an implementation; that is how `GCP-05`, `GCP-06` and
`MM-GAP-010` came to exist, and each is waiting on an ADR.

---

## 10. References

[`PRD-SEAT-MANAGEMENT.md`](../../30-product/seat-management/PRD-SEAT-MANAGEMENT.md) ·
[`PRD-007_IMPLEMENTATION_TASKS.md`](./PRD-007_IMPLEMENTATION_TASKS.md) ·
[`PRD-007_STAGE7_FREEZE.md`](../../30-product/seat-management/PRD-007_STAGE7_FREEZE.md) ·
[`seat-management/README.md`](../../30-product/seat-management/README.md) ·
[`DEVELOPER_HANDOFF.md`](../DEVELOPER_HANDOFF.md) ·
[`TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) ·
[`ADR-0020`](../../00-governance/adr/ADR-0020-seat-management-prd-v1.0-baseline.md) ·
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) ·
[`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md)

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created at Stage 7 from the frozen `PRD-SEAT-MANAGEMENT.md` v1.0, as the first per-module developer guide in this repository — following the `DEVELOPER_HANDOFF.md` §4A precedent of a per-module trap list rather than duplicating it. **Explanatory only: no requirement is created, restated as normative, or reinterpreted**, and every claim carries the identifier it derives from so it can be checked against the frozen text. Contains **no code, no API specification, no database schema and no migration** — deliberately, because the PRD specifies behaviour and a guide that invented an interface would be inventing requirements at Rank *below* the specification. Records the module's honest state: **0 of 100 tasks, 0 of 226 acceptance criteria**, `PRD-006` still `PLANNED` so occupancy cannot be derived, 118 obligations without a criterion, and **`GCP-09`'s ten mis-targeted citations** — with an explicit warning not to fix them in a frozen document and not to search-and-replace them, since the same three identifiers are cited correctly six times elsewhere. |
