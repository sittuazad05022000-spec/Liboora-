# `PRD-007` Implementation Tasks — `IMPL-500` … `IMPL-599`

| Field | Value |
|---|---|
| **Document** | Implementation tasks for [`PRD-SEAT-MANAGEMENT.md`](../../30-product/seat-management/PRD-SEAT-MANAGEMENT.md) (`PRD-007`, `BC-04`) |
| **Version** | v1.0 |
| **Status** | Backlog record. **Not ranked**, therefore editable without an ADR |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04-D` |
| **Purpose** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 6** gate — allocate an `IMPL-*` range and record a task document in which every task traces back to requirements |
| **Implementation state** | ⛔ **NOTHING IN THIS DOCUMENT IS IMPLEMENTED.** Zero files under `lib/` were created or modified. No development has started |
| **Source of truth** | `PRD-007` v1.0. Where this file disagrees with it, **the PRD is right and this file is a defect** |
| **Stage** | Stage 6 of 9. `PRD-007` remains **`DRAFT`**; this document does **not** freeze it and does **not** advance the registry |

---

## 1. The one thing this document is not

It is **not** evidence of progress, and it is **not** a specification. One hundred well-formed task rows can read
like work completed; they are a plan for work **not** begun. Verified, not asserted:

```
git diff --stat 7b96c2b -- lib/   → (empty)     # zero application-code changes
git status --short                → only docs/40-implementation/seat-management/ and tool/docs_check/
```

`PRD-007` `SEAT-NFR-011` requires every requirement to be *"observable through a surface a tester can reach"*, and
`SEAT-NFR-011`'s authority `SID-4.56` states: *"a rule that cannot be checked SHALL be treated as unmet, not as
satisfied by intent."* The same standard applies to a task. Until its test exists and runs, the task is **not done**,
however complete its description reads here.

**What this document deliberately does not contain:** no schema, no SQL, no DDL, no API shape, no widget tree, no
class signature and no estimate. `PRD-007` §0.1 places all of those outside the PRD; expanding them here would be
writing the specification that Stage 6 does not authorise. Scope cells name **what** must be built and the
requirements that govern it, not **how**.

---

## 2. Stage 6 prerequisites — verified, not assumed

`PRD_LIFECYCLE.md` §2: *"A gate is not an opinion — if the artefact does not exist, the stage has not been passed,
however complete the work feels."* Stage 6 is entered only from a satisfied Stage 5.

| Prerequisite | Required artefact | State |
|---|---|---|
| **Stage 4 — Requirements Review** | Testable, uniquely identified, non-duplicating; conflicts closed or deferred with a reason and an owner | ✅ **Satisfied** — [`PRD-007_STAGE4_FINAL_REVIEW.md`](../../30-product/seat-management/PRD-007_STAGE4_FINAL_REVIEW.md), verdict **A — PASS**, 0 CRITICAL / 0 HIGH / 0 MEDIUM / 0 LOW |
| **Stage 5 — Traceability** | All `SEAT-*` prefixes registered in [`TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) §2 with counts and ranges, verified mechanically, zero collisions | ✅ **Satisfied** — §2E of the matrix (v1.6): ten registers, **683** identifiers, collisions **0** in both directions; [`PRD-007_STAGE5_TRACEABILITY.md`](../../30-product/seat-management/PRD-007_STAGE5_TRACEABILITY.md), verdict **A — PASS** |
| **Stage 6 — this document** | `IMPL-*` range allocated + every task traces to requirements | ✅ This file, mechanically checked by [`tool/docs_check/prd007_task_coverage.py`](../../../tool/docs_check/prd007_task_coverage.py) |
| **Stage 7 — Freeze** | A row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank | ⛔ **Not attempted here.** Out of scope for Stage 6 |

> **Stage 6 does not confer freeze.** Completing this gate makes `PRD-007` *eligible* for a Stage 7 proposal; it does
> not perform one, and this document creates no ADR and edits no registry. `PRD_LIFECYCLE.md` §7: *"No fast path.
> Stage 7 is not skippable."* `PRD_REGISTRY.md` still records `PRD-007` as **`PLANNED`** and is byte-identical.

---

## 3. `IMPL-*` allocation

### 3.1 Why this range — computed, not chosen

`PRD_LIFECYCLE.md` Stage 6 allocation rule 1: *"Take the next free range. **Never reuse or reassign a number** —
cross-references in commits, reviews and test names outlive the document."* Rule 2: *"Leave the previous group room to
grow contiguously."*

Every `IMPL-*` identifier in the repository was enumerated rather than read off a table:

```
grep -rhoE 'IMPL-[0-9]{3}' docs/ tool/ lib/ test/ | sort -u
→ 014-016 020-021 030-031 040-041 050-052 060-062 070-073 097
  100-115 120-128 199-217 220-227 299-324 399-442 499-500
→ 144 distinct numbers, highest token seen: IMPL-500
grep -rnoE 'IMPL-(5|6)[0-9][0-9]' docs/ tool/ lib/ test/
→ docs/40-implementation/membership-management/PRD-005_IMPLEMENTATION_TASKS.md:96
```

**The single `IMPL-500` occurrence is a declaration that the number is free, not a use of it.** That line reads
`| IMPL-500 + | Unallocated | — |` in `PRD-005`'s own allocation table. The boundary token was inspected at its
source rather than inferred from the maximum, because a maximum cannot distinguish an allocation from a marker.

**`IMPL-500` is therefore the allocation.** `IMPL-442` … `IMPL-499` is **not** taken: it is `PRD-005`'s declared
growth reserve, held for the same reason `IMPL-324` … `IMPL-399` is held for `PRD-004`. Skipping it is rule 2 applied
to the immediately preceding group.

### 3.2 The allocation table

| Range | Owner | Grouping |
|---|---|---|
| `IMPL-014` … `IMPL-073` | Authentication, platform, release readiness | [`IMPLEMENTATION_ROADMAP.md`](../IMPLEMENTATION_ROADMAP.md) |
| `IMPL-100` … `IMPL-127` | Library Management | [`LIBRARY_IMPLEMENTATION_TASKS.md`](../LIBRARY_IMPLEMENTATION_TASKS.md) |
| `IMPL-128` … `IMPL-199` | Reserved for Library Management growth | — |
| `IMPL-200` … `IMPL-226` | Student Identity | [`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md`](../STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md) |
| `IMPL-227` … `IMPL-299` | Reserved for Student Identity growth | — |
| `IMPL-300` … `IMPL-323` | Student Management (`PRD-004`, `BC-01`) | [`PRD-004_IMPLEMENTATION_TASKS.md`](../../30-product/student-management/PRD-004_IMPLEMENTATION_TASKS.md) |
| `IMPL-324` … `IMPL-399` | Reserved for Student Management growth — 11 open `SM-GAP-*` may require tasks | — |
| `IMPL-400` … `IMPL-441` | Membership Management (`PRD-005`, `BC-02`) | [`PRD-005_IMPLEMENTATION_TASKS.md`](../membership-management/PRD-005_IMPLEMENTATION_TASKS.md) |
| `IMPL-442` … `IMPL-499` | Reserved for Membership Management growth — 5 open `MM-GAP-*` may require tasks | — |
| **`IMPL-500` … `IMPL-509`** | **Wave 1 — Module boundary, spatial model, seat identity, layout** | This document |
| **`IMPL-510` … `IMPL-519`** | **Wave 2 — Derived seat state and the allocation model's invariants** | This document |
| **`IMPL-520` … `IMPL-529`** | **Wave 3 — The acquisition gate, assignment, release, transfer** | This document |
| **`IMPL-530` … `IMPL-539`** | **Wave 4 — Seat-change requests, self-booking, reservations** | This document |
| **`IMPL-540` … `IMPL-549`** | **Wave 5 — Reservation governance, seat types, categories, the Membership boundary** | This document |
| **`IMPL-550` … `IMPL-559`** | **Wave 6 — The Attendance boundary, locking, maintenance, bulk operations** | This document |
| **`IMPL-560` … `IMPL-569`** | **Wave 7 — Auto-assignment, QR, real-time, concurrency, idempotency, events** | This document |
| **`IMPL-570` … `IMPL-579`** | **Wave 8 — History, audit, protected operations, notification facts** | This document |
| **`IMPL-580` … `IMPL-589`** | **Wave 9 — Metrics, search, configuration, privacy, multi-tenancy** | This document |
| **`IMPL-590` … `IMPL-599`** | **Wave 10 — Edge rules, remaining invariants, NFRs, acceptance proof** | This document |
| `IMPL-600` + | Unallocated | — |

**100 tasks, `IMPL-500` … `IMPL-599`, contiguous with no gaps inside the allocated span.** Wave boundaries fall on
round tens so that a task added to a wave later does not force a renumber: rule 1 forbids reassignment, so slack must
be **planned rather than found**. Unlike `PRD-005`, this backlog holds **no growth reserve of its own** — the ten
waves consume the whole hundred, and `PRD-007`'s 14 open `SEAT-GAP-*` receive no tasks (§8), so a reserve would be
speculative. A future gap resolution takes `IMPL-600`+ under rule 1.

### 3.3 A known staleness, disclosed rather than corrected

`PRD_LIFECYCLE.md`'s Stage 6 range table ends `| IMPL-227+ | **Unallocated** |`, and
`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` §1.1 says the same. Both predate `PRD-004`'s `IMPL-300`…`323` and
`PRD-005`'s `IMPL-400`…`441`. **Three tables are now stale, not one.**

**This is an already-recorded condition, not a newly found conflict.** `PRD-004_IMPLEMENTATION_TASKS.md` §7 records it
in its own "not claimed" table, and `PRD-005_IMPLEMENTATION_TASKS.md` §3.3 records it again, stating the rule this
document follows: *"the occupancy enumeration in §3.1, not the table, is the authority on what is free."*

This document therefore treats those tables as **stale but harmless** and **does not edit them**. Amending
`PRD_LIFECYCLE.md` (governance, Rank-adjacent) or another backlog's allocation table is outside Stage 6 and is
explicitly forbidden for this work. Carried forward in §9 rather than fixed silently.

---

## 4. Blocking dependencies outside `PRD-007`

`PRD-007` cannot be fully implemented from its own backlog. `BC-04` Seating consumes **seven** inbound edges and is
the most heavily dependent module in the ecosystem. These constraints are **inherited, not introduced here**.

| Blocker | Effect on this backlog | Register |
|---|---|---|
| **`BLK-01`** / `TASK-D10` demo surfaces | **Gate 3 is red today** (9 `cross-context` violations; `ADR-0012` expiry 2026-10-31). Any PR in this backlog inherits a red gate 3 until `TASK-D10` lands. **The violations must not be waived to make it green** | [`IMPLEMENTATION_BLOCKER_REGISTER.md`](../IMPLEMENTATION_BLOCKER_REGISTER.md) |
| **`PRD-005`** `BC-02` — `IMPL-432` (`E-02` producer) | **`IMPL-548` cannot complete.** `SEAT-FR-151` fixes the consumed shape as `{studentRecordId, validUntil, seatQuota}`; `IMPL-432` builds the producer. `PRD-005` is **frozen** (v1.4) but **unimplemented** — zero `lib/` files exist. `IMPL-548` builds the consumer against a port with a fake | `PRD_REGISTRY.md`, `PRD-005_IMPLEMENTATION_TASKS.md` §4 |
| **`PRD-004`** `BC-01` — `IMPL-300`, `IMPL-301`, `IMPL-311` | **`IMPL-521` and `IMPL-528` cannot complete.** Gate G6 needs `EnrollmentStatus` over the `E-01` family; the seat card composes holder data from `BC-01` at read time (`SEAT-FR-104`). `PRD-004` is frozen (v1.2) and unimplemented | `PRD_REGISTRY.md` |
| **`PRD-006`** `BC-03` Attendance **`PLANNED`** | **`IMPL-551` has no upstream.** `E-08` `StudentCheckedIn`/`StudentCheckedOut` has no owning specification, yet this module is the **occupancy owner** (`SEAT-FR-108`). The consumer **MUST** be built against the port with a fake, never deferred | `PRD_REGISTRY.md` |
| **`PRD-006`** — `SEAT-GAP-009` | Whether `BC-03` needs to read this module's allocation to record *which seat* is **undecided**. `IMPL-550` builds the split as specified and adds no reverse edge | `PRD-007` §31 |
| **`BC-06`** Library Policy (`PRD-Library`) — `E-05` | `IMPL-527` (`maxTransfersPerDay`), `IMPL-533` (`reservationWindow`), `IMPL-544` (shift definitions), `IMPL-552` (operating day) and `IMPL-566` (occupancy threshold) all **conform** to `E-05` and define nothing. `SEAT-FR-267` records that the threshold is a **proposed** addition to a payload the BC Map fixes — `SEAT-GAP-005` | BC Map §7, `PRD-007` §27.2 |
| **`PRD-023`** `BC-25` Configuration unwritten | `IMPL-584` reads all **18** `SEAT-CFG-*` through `E-19`; the configuration PRD does not exist | `ADR-0017` |
| **`BC-18`** Authorisation, **`BC-21`** Entitlement, **`BC-19`** Tenancy | `IMPL-577` consumes `BC-18`'s decisions and never defines a role (`SEAT-FR-268`); `IMPL-520` calls `E-17` before mutation; `IMPL-589` takes `TenantContext` from `E-18`. All three are **ports** here, never implementations | BC Map §7 |
| **`BC-24`** Audit, **`BC-22`** Notification | `IMPL-576` emits over `E-20` fire-and-forget; `IMPL-579` emits facts over `E-23` and implements no dispatch | BC Map §7 |
| **`SEAT-GAP-001`** … **`SEAT-GAP-014`** | Fourteen open questions. **No task implements any of them** — see §8. `IMPL-593` exists to keep them open: `SEAT-BR-045` forbids resolving a gap by implementation choice | `PRD-007` §31 |

> **Consequence, stated rather than buried.** `BC-04` sits downstream of one frozen-but-unbuilt context (`BC-02`), one
> frozen-but-unbuilt upstream (`BC-01`), one `PLANNED` upstream (`BC-03`) and one unwritten configuration context
> (`BC-25`). **Waves 1–5 are largely buildable today**, because the spatial model, seat identity, derived state, the
> allocation invariants and the acquisition gate's *structure* are this module's own. The gate's *inputs* — G6, G7,
> G13 — and every integration in waves 6–8 are buildable **against ports with fakes**, which is exactly what
> `IMPL-502` exists to make possible. A seating module shipped before `PRD-006` would hold allocations but derive no
> occupancy. That is a scheduling fact, not a defect in this backlog.

---

## 5. The 100 tasks

Column meanings, fixed once. **Requirements** cites the `SEAT-*` obligations the task must satisfy — this is the
Stage 6 gate and no cell may be empty. **Blocked by** and **Blocks** record allocation rule 3's two directions and are
checked against each other mechanically. **Priority** is `P1` (nothing else can proceed without it), `P2` (needed for
a coherent V1) or `P3` (required by the PRD but not on any other task's path).

`SEAT-AC-*` do not appear in Requirements cells. An acceptance criterion is **verified by** a task's test, not
**implemented by** a task; §6 maps them separately, and `IMPL-599` is the task that proves the whole set of 226 runs.
`SEAT-GAP-*` do not appear either: `PRD-007` §0.3 states they *"are questions, not requirements, and must never be
cited as verifiable."*

### 5.1 Wave 1 — Module boundary, spatial model, seat identity, layout (`IMPL-500` … `IMPL-509`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-500` | Bounded-context skeleton for `BC-04` Seating and the sole-authority boundary — the module, its public surface, and the seven things it owns versus the eight it consumes | `domain/library` | P1 | — | `IMPL-501`, `IMPL-502`, `IMPL-503` | `SEAT-FR-001`–`SEAT-FR-005`, `SEAT-BR-001` | Structural: no membership-validity, attendance-record, money, notification-dispatch or authorisation type is representable in this module |
| `IMPL-501` | The two owned aggregates `SeatAllocation` and `SeatLayout`, and the one-aggregate-one-transaction boundary | `domain/library` | P1 | `IMPL-500` | `IMPL-504`, `IMPL-505`, `IMPL-506`, `IMPL-512` | `SEAT-FR-006`, `SEAT-FR-007` | A single operation cannot transactionally mutate `SeatAllocation` and `SeatLayout` together — compile-level, not convention |
| `IMPL-502` | The seven inbound edges as ports, and the closed inbound edge set | `domain/library` | P1 | `IMPL-500` | `IMPL-504`, `IMPL-584`, `IMPL-586` | `SEAT-FR-008`–`SEAT-FR-010` | An eighth inbound edge is not constructible; no foreign table read; no student name, photo, contact, guardian, fee or attendance total storable |
| `IMPL-503` | Outbound edges limited to `E-20`, `E-23` and the §22 domain events | `domain/library` | P1 | `IMPL-500` | `IMPL-565` | `SEAT-FR-011`, `SEAT-FR-012`, `SEAT-BR-002` | No synchronous `BC-24` call; no send instruction to `BC-22`; a ninth outbound edge fails the build |
| `IMPL-504` | The `Branch → Floor → Zone → Seat` hierarchy with floors and zones read-only, including the capacity-disagreement surface and the inactive-container rule | `domain/library` | P1 | `IMPL-501`, `IMPL-502` | `IMPL-506`, `IMPL-518` | `SEAT-FR-013`–`SEAT-FR-019`, `SEAT-BR-003` | No create/rename/renumber/delete/status path for `Floor` or `Zone` exists; a capacity mismatch is surfaced and never silently reconciled |
| `IMPL-505` | Independently versioned `SeatLayout` with exactly one active version per zone | `domain/library` | P1 | `IMPL-501` | `IMPL-508` | `SEAT-FR-020`–`SEAT-FR-022` | Saving creates a new version and never overwrites in place; reads resolve against the single active version |
| `IMPL-506` | Seat identity and the seat field set, with the internal identifier immutable and never derived | `domain/library` | P1 | `IMPL-501`, `IMPL-504` | `IMPL-507`, `IMPL-510`, `IMPL-512`, `IMPL-545` | `SEAT-FR-023`–`SEAT-FR-025`, `SEAT-BR-004` | The identifier survives renumber, zone move and category change; no current-student, current-shift, join-date or expiry field is a seat field |
| `IMPL-507` | Seat numbering — per-zone uniqueness, trimming, case-insensitivity, and renumbering while allocated | `domain/library` | P1 | `IMPL-506` | `IMPL-508`, `IMPL-557` | `SEAT-FR-026`, `SEAT-FR-027`, `SEAT-BR-005`, `SEAT-BR-006` | "a1" and "A1" collide in one zone; the same number is accepted in a different zone; renumbering leaves identifier and allocation untouched |
| `IMPL-508` | The 2D layout editor — positioning, add/remove, non-seat elements, explicit save and pre-persistence validation | `app` | P2 | `IMPL-505`, `IMPL-507` | `IMPL-509` | `SEAT-FR-028`–`SEAT-FR-035`, `SEAT-BR-007` | A wall, door, table or pillar is not allocatable, reservable, lockable, searchable-as-seat or counted; absent 3D limits nothing |
| `IMPL-509` | The layout-edit safety rule — an edit may not orphan an active allocation | `domain/library` | P1 | `IMPL-508`, `IMPL-512` | `IMPL-599` | `SEAT-BR-008` | Removing a seat that holds an active allocation is rejected, not cascaded |


### 5.2 Wave 2 — Derived seat state and the allocation model's invariants (`IMPL-510` … `IMPL-519`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-510` | The five independent, separately stored facts F1…F5 that determine seat behaviour | `domain/library` | P1 | `IMPL-506` | `IMPL-511` | `SEAT-FR-036`, `SEAT-BR-009` | Setting one fact does not implicitly clear another — each of the five is independently settable and independently observable |
| `IMPL-511` | `SeatState` as a derived total function over F1…F5, with `Locked` orthogonal and never invisible | `domain/library` | P1 | `IMPL-510` | `IMPL-513`, `IMPL-514`, `IMPL-528`, `IMPL-554`, `IMPL-555`, `IMPL-562` | `SEAT-FR-037`–`SEAT-FR-039`, `SEAT-BR-010` | No stored settable status exists; a locked available seat presents as available-and-locked; every surface shows state plus the lock flag |
| `IMPL-512` | `SeatAllocation` aggregate root, its field set, and reference by `StudentRecordId` only | `domain/library` | P1 | `IMPL-501`, `IMPL-506` | `IMPL-509`, `IMPL-515`, `IMPL-516`, `IMPL-517`, `IMPL-518`, `IMPL-519`, `IMPL-528`, `IMPL-529`, `IMPL-530`, `IMPL-543`, `IMPL-550`, `IMPL-554`, `IMPL-565`, `IMPL-569` | `SEAT-FR-046`, `SEAT-FR-047`, `SEAT-BR-011` | No `PersonId` and no name is representable on an allocation; origin, window, type and audit stamps are all present |
| `IMPL-513` | The four derived status meanings, normatively — including `Occupied` meaning allocated, not present | `domain/library` | P1 | `IMPL-511` | `IMPL-514` | `SEAT-FR-040`–`SEAT-FR-043` | A seat in maintenance is unacquirable by every role including Owner; `Reserved` confers no occupancy right |
| `IMPL-514` | The complete valid-transition table and the rejected invalid set | `domain/library` | P1 | `IMPL-511`, `IMPL-513` | `IMPL-599` | `SEAT-FR-044`, `SEAT-FR-045`, `SEAT-XC-001`, `SEAT-XC-002` | A transition absent from the table is impossible, not merely unused; a seat cannot present as two states at once |
| `IMPL-515` | Seat-side allocation invariants — one active allocation per seat per overlapping window, and a positive window | `platform/data` | P1 | `IMPL-512` | `IMPL-516`, `IMPL-520`, `IMPL-563`, `IMPL-564`, `IMPL-591` | `SEAT-INV-001`, `SEAT-INV-003` | Enforced by a database unique constraint plus a pessimistic row lock; concurrent attempts yield exactly one row, decided by the constraint |
| `IMPL-516` | Student-side quota — `seatQuota` consumed from `E-02`, never defined or overridden here, absence meaning one | `domain/library` | P1 | `IMPL-512`, `IMPL-515` | `IMPL-520`, `IMPL-533`, `IMPL-548`, `IMPL-590` | `SEAT-FR-048`, `SEAT-FR-049`, `SEAT-BR-012`, `SEAT-INV-002` | Absence of `seatQuota` resolves to 1 and never to unlimited; a rejection names the quota and the current count |
| `IMPL-517` | Reservation uniqueness invariants — per seat and per (student, seat) | `platform/data` | P1 | `IMPL-512` | `IMPL-520`, `IMPL-535`, `IMPL-564`, `IMPL-591` | `SEAT-INV-004`, `SEAT-INV-005` | At most one unexpired reservation per seat, and per student-seat pair, enforced at the storage layer |
| `IMPL-518` | Referential and tenant invariants on allocation | `platform/data` | P1 | `IMPL-504`, `IMPL-512` | `IMPL-520`, `IMPL-557`, `IMPL-589`, `IMPL-591` | `SEAT-INV-006`, `SEAT-INV-007` | No allocation for a non-existent seat or a deleted container; the allocation, seat and student `tenantId` must agree |
| `IMPL-519` | Allocation origin — the closed eight-value set, immutable once written | `domain/library` | P1 | `IMPL-512` | `IMPL-599` | `SEAT-FR-050`, `SEAT-FR-051` | A ninth origin is unrepresentable; origin appears in the timeline and the audit fact and cannot be edited |


### 5.3 Wave 3 — The acquisition gate, assignment, release, transfer (`IMPL-520` … `IMPL-529`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-520` | The single ordered acquisition gate G1…G16, executed by every path that creates or moves an allocation or creates a reservation | `domain/library` | P1 | `IMPL-515`, `IMPL-516`, `IMPL-517`, `IMPL-518` | `IMPL-521`, `IMPL-522`, `IMPL-523`, `IMPL-524`, `IMPL-532`, `IMPL-537`, `IMPL-546`, `IMPL-560`, `IMPL-561`, `IMPL-577` | `SEAT-FR-052` | All nine acquisition paths execute the same ordered gate and stop at the first failure — order is asserted, not assumed |
| `IMPL-521` | G6 enrollment status and G7 membership validity — the gate no role may override | `domain/library` | P1 | `IMPL-520` | `IMPL-548` | `SEAT-BR-013`, `SEAT-BR-014`, `SEAT-XC-004` | No override, bypass, force-assign or "assign anyway" affordance exists for G7 in any role, screen, bulk operation or import |
| `IMPL-522` | G16 evaluated under a pessimistic lock held to commit | `platform/data` | P1 | `IMPL-520` | `IMPL-563` | `SEAT-BR-015` | A read-then-write check without a lock fails the test even where it appears to work single-threaded |
| `IMPL-523` | Gate-failure semantics — distinguishable reasons, non-disclosing collapse of G2/G5, and no partial mutation | `domain/library` | P1 | `IMPL-520` | `IMPL-524`, `IMPL-597` | `SEAT-FR-053`, `SEAT-FR-054`, `SEAT-XC-003` | A rejected request produces no allocation, reservation, history row or event; a path that skips or reorders gates is not constructible |
| `IMPL-524` | Staff assignment, with the student selected explicitly and the two-step rule for an occupied seat | `app` | P1 | `IMPL-520`, `IMPL-523` | `IMPL-525`, `IMPL-526`, `IMPL-560` | `SEAT-FR-055`–`SEAT-FR-058`, `SEAT-BR-016` | Assignment never infers the student from context and never silently overwrites an occupied, reserved or under-maintenance seat |
| `IMPL-525` | Release with a mandatory reason, closing but never deleting the allocation | `app` | P1 | `IMPL-524` | `IMPL-526`, `IMPL-572` | `SEAT-FR-059`–`SEAT-FR-061` | No delete path exists; release records actor, timestamp and a reason from `SEAT-CFG-004` or free text |
| `IMPL-526` | Transfer — atomic in effect, destination gated before source release | `domain/library` | P1 | `IMPL-524`, `IMPL-525` | `IMPL-527`, `IMPL-531`, `IMPL-556`, `IMPL-563` | `SEAT-FR-062`–`SEAT-FR-064` | No state exists in which the student holds both seats or neither; the destination is fully gated before the source is released |
| `IMPL-527` | Transfer history and the per-day transfer bound consumed from `BC-06` | `domain/library` | P1 | `IMPL-526` | `IMPL-558`, `IMPL-571` | `SEAT-FR-065`–`SEAT-FR-067`, `SEAT-BR-017` | Exactly one transfer row per transfer; system-initiated relocation and bulk reassignment do not count against the limit |
| `IMPL-528` | The seat card, with holder data composed at read time and never stored | `app` | P2 | `IMPL-511`, `IMPL-512` | `IMPL-587` | `SEAT-FR-103`–`SEAT-FR-107` | The card renders with a value marked unavailable rather than failing or showing a stale value as current; unauthorised actions are absent, not disabled-with-reason |
| `IMPL-529` | The Booking / Reservation / Assignment / Allocation vocabulary fixed once, so the four are not conflated downstream | `domain/library` | P2 | `IMPL-512` | `IMPL-599` | `SEAT-FR-085` | Terminology test: each of the four concepts is a distinct type or field, not an alias of another |


### 5.4 Wave 4 — Seat-change requests, self-booking, reservations (`IMPL-530` … `IMPL-539`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-530` | The seat-change request record, which holds no seat | `domain/library` | P2 | `IMPL-512` | `IMPL-531` | `SEAT-FR-068`–`SEAT-FR-070` | A request creates, moves, reserves and holds nothing; its state is one of the closed five |
| `IMPL-531` | Request decisions — approve, reject, cancel, concurrency limit and expiry, gated at approval time | `app` | P2 | `IMPL-526`, `IMPL-530` | `IMPL-599` | `SEAT-FR-071`–`SEAT-FR-075` | Approval re-evaluates §8 at approval time and fails when the target has since become unavailable; a rejection carries a mandatory reason |
| `IMPL-532` | Student self-booking behind the tenant switch, under the `self` scope only | `app` | P2 | `IMPL-520` | `IMPL-533`, `IMPL-561` | `SEAT-FR-076`–`SEAT-FR-079` | A student cannot see or book for another student; availability never discloses who holds an occupied or reserved seat |
| `IMPL-533` | Booking dates — explicit window, membership ceiling, no past start, advance window from `BC-06` | `domain/library` | P1 | `IMPL-516`, `IMPL-532` | `IMPL-534` | `SEAT-FR-080`–`SEAT-FR-084` | A dateless booking is unrepresentable; a window beyond membership `validUntil` is rejected or truncated per `SEAT-CFG-009`, never silently extended |
| `IMPL-534` | Booking mode as a single tenant-level value from a closed set | `domain/library` | P1 | `IMPL-533` | `IMPL-535` | `SEAT-FR-086`, `SEAT-FR-087`, `SEAT-BR-018` | Two modes cannot be in force at once; gates are evaluated at allocation creation and again at conversion |
| `IMPL-535` | The `Reservation` record — closed state set, default duration, per-student limit and self-cancellation | `domain/library` | P1 | `IMPL-517`, `IMPL-534` | `IMPL-536`, `IMPL-537`, `IMPL-538`, `IMPL-539`, `IMPL-540`, `IMPL-541` | `SEAT-FR-118`–`SEAT-FR-122` | A reservation without `expiresAt` is unrepresentable; self-cancellation returns the seat to available immediately |
| `IMPL-536` | Reservation overlap rejection, including the same-student same-seat case and its idempotent retry | `domain/library` | P1 | `IMPL-535` | `IMPL-542` | `SEAT-FR-123`, `SEAT-FR-124`, `SEAT-BR-021` | Two overlapping reservations for one seat cannot both exist; a repeat with the same idempotency key is a retry, not a second reservation |
| `IMPL-537` | Reservation → allocation conversion — first trigger wins, idempotent, with gates re-evaluated | `domain/library` | P1 | `IMPL-520`, `IMPL-535` | `IMPL-599` | `SEAT-FR-088`–`SEAT-FR-091` | A second trigger returns the existing allocation; a reservation created while valid does not convert after membership became invalid |
| `IMPL-538` | Reservation expiry derived from elapsed time, with the consecutive no-show counter and self-booking suspension | `domain/library` | P1 | `IMPL-535` | `IMPL-539`, `IMPL-573`, `IMPL-597` | `SEAT-FR-092`–`SEAT-FR-096` | A read of a seat whose `expiresAt` has passed presents it as available even when no job has run; expiry charges nothing |
| `IMPL-539` | Reservation auto-cancellation with a recorded cause | `domain/library` | P2 | `IMPL-535`, `IMPL-538` | `IMPL-541` | `SEAT-FR-125`, `SEAT-FR-126` | "Cancelled" with no cause is not a producible timeline entry; each of the named trigger conditions is separately tested |


### 5.5 Wave 5 — Reservation governance, seat types, categories, the Membership boundary (`IMPL-540` … `IMPL-549`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-540` | Approval-required reservations — `Pending` that blocks nobody, with approval re-gated and bounded pendency | `app` | P2 | `IMPL-535` | `IMPL-599` | `SEAT-FR-127`–`SEAT-FR-130` | A pending reservation does not block the seat for others; a failed approval leaves the request `Pending` with the gate reason |
| `IMPL-541` | Reserved-seat handling — holder conversion by staff, explicit cancellation before reassignment, and who may cancel | `app` | P2 | `IMPL-535`, `IMPL-539` | `IMPL-599` | `SEAT-FR-097`, `SEAT-FR-098`, `SEAT-FR-102`, `SEAT-BR-019`, `SEAT-XC-006` | Assigning the holder is conversion, not override; Reception cancels only where granted; a staff cancellation records actor, time and reason |
| `IMPL-542` | The absent waiting list and the permitted non-overlapping future booking | `domain/library` | P2 | `IMPL-536` | `IMPL-599` | `SEAT-FR-099`–`SEAT-FR-101`, `SEAT-XC-005` | No queue, no waiting list and no automatic promotion path exists — proven as an absence; a non-overlapping future window is accepted |
| `IMPL-543` | `Fixed` and `Flexible` seat types, with the type recorded on the allocation and type changes non-retroactive | `domain/library` | P1 | `IMPL-512` | `IMPL-544` | `SEAT-FR-131`–`SEAT-FR-135` | Flexible means shareable across non-overlapping windows, never concurrently; `Flexible → Fixed` is rejected while overlapping-day allocations exist |
| `IMPL-544` | Shift integration — definitions consumed from `BC-06`, never defined here, with misalignment queued for a human | `domain/library` | P2 | `IMPL-543` | `IMPL-568` | `SEAT-FR-136`–`SEAT-FR-141`, `SEAT-BR-022` | A deleted or edited `BC-06` shift does not retroactively invalidate a recorded allocation; two non-overlapping shifts on one flexible seat are permitted |
| `IMPL-545` | Seat categories as data, deactivatable but not deletable while referenced, and carrying no money | `domain/library` | P2 | `IMPL-506` | `IMPL-546` | `SEAT-FR-142`–`SEAT-FR-146` | Adding a category requires no code change; no price, fee or amount field exists on a category; a seat category change does not touch an existing allocation |
| `IMPL-546` | Category eligibility evaluated at gate G13 from consumed inputs only | `domain/library` | P1 | `IMPL-520`, `IMPL-545` | `IMPL-547` | `SEAT-FR-147`–`SEAT-FR-149`, `SEAT-BR-023` | This module never defines which plan grants which category; a denial names the category without disclosing another student's plan |
| `IMPL-547` | The five named eligibility-change cases, evaluated at acquisition and conversion only | `domain/library` | P2 | `IMPL-546` | `IMPL-599` | `SEAT-FR-150`, `SEAT-BR-024` | An existing allocation is never automatically released, truncated or moved because eligibility changed; the normative table is exhaustive |
| `IMPL-548` | Membership validity consumed exclusively from `E-02`, failing closed on acquisition and open on read | `domain/library` | P1 | `IMPL-516`, `IMPL-521` | `IMPL-549`, `IMPL-594` | `SEAT-FR-151`–`SEAT-FR-154`, `SEAT-XC-010` | Acquisition fails closed with an explicit reason when the projection is unavailable; reading a card, layout or occupancy count still succeeds |
| `IMPL-549` | Membership lifecycle events consumed without any write-back to `BC-02` | `domain/library` | P1 | `IMPL-548` | `IMPL-599` | `SEAT-FR-155`–`SEAT-FR-157`, `SEAT-XC-011` | No publish, command call, extend, renew, freeze or expire path to `BC-02` exists; no renew or collect-payment affordance appears on a seat screen |


### 5.6 Wave 6 — The Attendance boundary, locking, maintenance, bulk operations (`IMPL-550` … `IMPL-559`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-550` | The Attendance split — this module owns occupancy, `BC-03` owns attendance | `domain/library` | P1 | `IMPL-512` | `IMPL-551` | `SEAT-FR-108`, `SEAT-BR-020`, `SEAT-XC-007`, `SEAT-XC-008` | No attendance punch, correction, total or verification evidence is storable; this module is not a source for any attendance report or percentage |
| `IMPL-551` | Occupancy derived from `E-08`, idempotent by event id, with unseated occupancy and loud tenant failure | `platform/event` | P1 | `IMPL-550` | `IMPL-552`, `IMPL-567`, `IMPL-596` | `SEAT-FR-109`–`SEAT-FR-113` | A redelivered check-in does not double-count; a check-in with an unresolvable `tenantId` fails loudly and defaults to no tenant |
| `IMPL-552` | Operating-day occupancy reset, recomputability, and allocation integrity under missed events | `domain/library` | P1 | `IMPL-551` | `IMPL-553`, `IMPL-566`, `IMPL-568`, `IMPL-580`, `IMPL-590` | `SEAT-FR-114`–`SEAT-FR-116` | A count that cannot be recomputed from current allocations and open sessions is not presentable; a stale or missed event never corrupts the allocation |
| `IMPL-553` | Public exposure limited to an aggregate indicator; per-seat state stays private in V1 | `app` | P3 | `IMPL-552` | `IMPL-599` | `SEAT-FR-117`, `SEAT-XC-009` | No per-seat identity, per-seat state or live per-seat occupancy is reachable from any public surface |
| `IMPL-554` | Seat locking — suppresses new acquisition only, never traps a student | `app` | P2 | `IMPL-511`, `IMPL-512` | `IMPL-599` | `SEAT-FR-158`–`SEAT-FR-163`, `SEAT-BR-025` | A lock never releases, shortens or invalidates an allocation and never blocks release or transfer-out; students see unavailable without the reason |
| `IMPL-555` | Maintenance records — the `Reported` state that changes nothing, and the `Started` state that sets F2 | `app` | P2 | `IMPL-511` | `IMPL-556` | `SEAT-FR-164`–`SEAT-FR-166`, `SEAT-BR-026` | A Reception report does not change derived state; only a started record sets the maintenance fact |
| `IMPL-556` | The three explicit maintenance dispositions, exclusion from availability, and retained history | `app` | P2 | `IMPL-526`, `IMPL-555` | `IMPL-590` | `SEAT-FR-167`–`SEAT-FR-170`, `SEAT-BR-027` | Starting maintenance never silently destroys an allocation; a relocation under `Relocate` does not count against the transfer limit |
| `IMPL-557` | Bulk import — validated in full before any row applies, all-or-nothing, idempotent by import key | `app` | P2 | `IMPL-507`, `IMPL-518` | `IMPL-558` | `SEAT-FR-171`–`SEAT-FR-174`, `SEAT-BR-028` | One invalid row applies no rows; resubmitting the same key returns the original result; a row cannot create a `Floor` or `Zone` |
| `IMPL-558` | Bulk export confined to inventory, and bulk reassignment gated per student per destination | `app` | P2 | `IMPL-527`, `IMPL-557` | `IMPL-559` | `SEAT-FR-175`–`SEAT-FR-177` | An export contains no student name, contact, membership or attendance data; a reassignment produces one transfer row per moved student |
| `IMPL-559` | Bulk audit summary and the hard row bounds | `app` | P3 | `IMPL-558` | `IMPL-596` | `SEAT-FR-178`, `SEAT-FR-179`, `SEAT-BR-029` | Every bulk operation emits one operation-level audit fact in addition to per-entity events; 2,001 import rows and 501 reassignments are rejected before any work |


### 5.7 Wave 7 — Auto-assignment, QR, real-time, concurrency, idempotency, events (`IMPL-560` … `IMPL-569`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-560` | Staff-invoked automatic assignment — deterministic, fully gated, explainable, never scheduled | `app` | P2 | `IMPL-520`, `IMPL-524` | `IMPL-599` | `SEAT-FR-180`–`SEAT-FR-185` | The candidate set is exactly the fully-gated set; ordering criteria are applied in the stated order; failure names the most restrictive gate |
| `IMPL-561` | Seat QR codes — identify a seat, authenticate nobody, and are not an attendance mechanism | `app` | P2 | `IMPL-520`, `IMPL-532` | `IMPL-599` | `SEAT-FR-186`–`SEAT-FR-191`, `SEAT-BR-030`, `SEAT-XC-012` | A QR payload carries no student id, name, token or credential; a scan never authenticates; regeneration invalidates the previous code |
| `IMPL-562` | Real-time seat state as a tenant-scoped optimisation, never the source of truth | `platform/event` | P2 | `IMPL-511` | `IMPL-595` | `SEAT-FR-192`–`SEAT-FR-195` | A client never receives an out-of-tenant update; a lost update is recoverable by re-read; payloads carry no holder name or membership data |
| `IMPL-563` | The concurrency outcomes — exactly one winner, bounded lock timeout, and a retryable timeout that is never a validity failure | `domain/library` | P1 | `IMPL-515`, `IMPL-522`, `IMPL-526` | `IMPL-594` | `SEAT-FR-196`–`SEAT-FR-200`, `SEAT-BR-031` | Concurrent acquisitions, concurrent transfers, concurrent quota-bound bookings and a maintenance/acquisition race each resolve to one outcome under real concurrent execution |
| `IMPL-564` | Idempotency — caller-supplied keys, 24-hour retention, and invariant-backed rejection when a key is absent | `platform/data` | P1 | `IMPL-515`, `IMPL-517` | `IMPL-599` | `SEAT-FR-201`–`SEAT-FR-205`, `SEAT-BR-032`, `SEAT-XC-013` | A double-delivered request produces one allocation, one history row, one audit fact and one notification fact; no retry path creates a second row |
| `IMPL-565` | The closed four-event register with its naming convention and payload contract | `platform/event` | P1 | `IMPL-503`, `IMPL-512` | `IMPL-566`, `IMPL-567`, `IMPL-576`, `IMPL-579` | `SEAT-FR-206`–`SEAT-FR-210`, `SEAT-EVT-001`–`SEAT-EVT-004` | A fifth event type fails the build; no imperative name is accepted; no name, contact or `PersonId` appears in any payload; every event carries `tenantId` |
| `IMPL-566` | Occupancy threshold alerting emitted on a crossing only, with the threshold owned by `BC-06` | `platform/event` | P2 | `IMPL-552`, `IMPL-565` | `IMPL-599` | `SEAT-FR-211`, `SEAT-FR-212` | A busy branch above the threshold produces one event per crossing, not one per change; the threshold is never locally defined or overridden |
| `IMPL-567` | The subscription set — idempotent, out-of-order tolerant, and non-retroactive on policy change | `platform/event` | P1 | `IMPL-551`, `IMPL-565` | `IMPL-599` | `SEAT-FR-213`–`SEAT-FR-215` | An event contradicting newer state is discarded rather than applied; new `SeatRules` do not apply retroactively to existing allocations |
| `IMPL-568` | Staff work queues as read models over existing state that act on nothing | `app` | P2 | `IMPL-544`, `IMPL-552` | `IMPL-579` | `SEAT-FR-216`, `SEAT-FR-217` | No queue performs an automatic action on its contents; each queue is rebuildable from state and is not a new aggregate |
| `IMPL-569` | The five kinds of history kept distinct, never collapsed into one store | `domain/library` | P1 | `IMPL-512` | `IMPL-570`, `IMPL-574` | `SEAT-BR-033` | One change to a seat produces at most one row in each of the five, and the five are separately queryable |


### 5.8 Wave 8 — History, audit, protected operations, notification facts (`IMPL-570` … `IMPL-579`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-570` | Allocation history as the append-only system of record, with released allocations immutable | `platform/data` | P1 | `IMPL-569` | `IMPL-571`, `IMPL-572`, `IMPL-573`, `IMPL-574`, `IMPL-580` | `SEAT-FR-218`, `SEAT-FR-219`, `SEAT-INV-008` | No operation deletes an allocation; no field of a released allocation is updatable; reports derive from history rather than duplicating it |
| `IMPL-571` | The bidirectional transfer linkage, walked rather than logged, and unbreakable by any later operation | `domain/library` | P1 | `IMPL-527`, `IMPL-570` | `IMPL-599` | `SEAT-FR-220`–`SEAT-FR-222` | Layout edit, renumber, zone reassignment, category change and seat deactivation each leave the chain intact; no separate transfer log exists |
| `IMPL-572` | The closed release-reason set, with free text stored in addition to and never instead of it | `domain/library` | P1 | `IMPL-525`, `IMPL-570` | `IMPL-599` | `SEAT-FR-223`, `SEAT-FR-224`, `SEAT-BR-034` | A release without a reason is unrepresentable; a released allocation retains the display number as it was at release |
| `IMPL-573` | Reservation history retained with its terminal state and its derived expiry outcome | `domain/library` | P2 | `IMPL-538`, `IMPL-570` | `IMPL-599` | `SEAT-FR-225`, `SEAT-FR-226` | The record does not depend on a job having run to be correct at the moment expiry is first observed |
| `IMPL-574` | The seat timeline composed from the five facts, rebuildable and never a sole record | `app` | P2 | `IMPL-569`, `IMPL-570` | `IMPL-575` | `SEAT-FR-227`–`SEAT-FR-229` | Ordering is by recorded fact time and is deterministic for identical timestamps; no fact is written only to the timeline |
| `IMPL-575` | The student-facing own-history view and layout-version retention for historical allocations | `app` | P3 | `IMPL-574` | `IMPL-599` | `SEAT-FR-230`, `SEAT-FR-231` | A student sees only their own allocations and reservations under `self`; a historical allocation still resolves its layout version |
| `IMPL-576` | Audit emitted over `E-20`, fire-and-forget, one fact per protected operation | `platform/audit` | P2 | `IMPL-565`, `IMPL-577` | `IMPL-578` | `SEAT-FR-232`–`SEAT-FR-234` | No local immutable audit store exists; a failed audit emission never fails the operation; audit is never on the critical path |
| `IMPL-577` | The closed protected-operation list, authorised before the gate runs, with Platform Support and guardians holding none of it | `app` | P1 | `IMPL-520` | `IMPL-576`, `IMPL-582`, `IMPL-587` | `SEAT-FR-271`–`SEAT-FR-274`, `SEAT-BR-038`–`SEAT-BR-040`, `SEAT-PO-001`–`SEAT-PO-024` | Per-operation matrix; authorisation precedes any read or mutation so an unauthorised caller learns nothing about availability; a 25th operation does not exist |
| `IMPL-578` | Audit payload minimisation, audited denials, and no read-back dependency on `BC-24` | `platform/audit` | P2 | `IMPL-576` | `IMPL-596` | `SEAT-FR-235`–`SEAT-FR-237`, `SEAT-XC-014`, `SEAT-XC-015` | No name, contact, `PersonId`, membership or financial value in an audit fact; no screen, report, timeline or history reads the audit store; no edit or delete path for a history record exists |
| `IMPL-579` | Notification facts only — no dispatch, no delivery state, no command-shaped event, with unmapped facts surfaced in a work queue | `platform/event` | P2 | `IMPL-565`, `IMPL-568` | `IMPL-599` | `SEAT-FR-238`–`SEAT-FR-243`, `SEAT-BR-035`, `SEAT-XC-016`, `SEAT-XC-017` | No SMS, push, email, in-app, template or retry path exists; "reminder sent" is not storable or displayable; no fact is silently dropped |


### 5.9 Wave 9 — Metrics, search, configuration, privacy, multi-tenancy (`IMPL-580` … `IMPL-589`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-580` | Operational metrics computed from current state at read time, with allocation and occupancy rates kept distinct | `app` | P2 | `IMPL-552`, `IMPL-570` | `IMPL-581`, `IMPL-595` | `SEAT-FR-244`–`SEAT-FR-247`, `SEAT-BR-036` | The two rates are never labelled interchangeably; every figure carries an as-of time; no pre-aggregated counter is a system of record |
| `IMPL-581` | The analytics boundary — trends, cohorts, retention and public live occupancy all out of scope | `app` | P2 | `IMPL-580` | `IMPL-599` | `SEAT-FR-248`–`SEAT-FR-250`, `SEAT-XC-018`–`SEAT-XC-020` | No warehouse, trend series or historical analytical model exists; no metric duplicates a `BC-26` definition; public live occupancy is absent |
| `IMPL-582` | Seat and student search, scoped by tenant and role, deterministic, and never an enumeration channel | `app` | P2 | `IMPL-577` | `IMPL-583` | `SEAT-FR-251`–`SEAT-FR-256` | An identical query, state and caller yields an identically ordered result; an exact-identifier search the caller may not resolve is indistinguishable from not-found; no student name is stored or indexed |
| `IMPL-583` | Named filter presets as criteria without actions, tenant-scoped, conjunctive and paginated | `app` | P3 | `IMPL-582` | `IMPL-588` | `SEAT-FR-257`–`SEAT-FR-262`, `SEAT-XC-021` | Applying a preset mutates nothing; each named preset is an exact testable predicate; no full-text, fuzzy, phonetic or relevance-ranked path exists |
| `IMPL-584` | The eighteen configurables read through `E-19` typed accessors, with defaults applied and no retroactive effect | `platform/services` | P1 | `IMPL-502` | `IMPL-585` | `SEAT-FR-263`–`SEAT-FR-265`, `SEAT-BR-037`, `SEAT-CFG-001`–`SEAT-CFG-018` | No raw string lookup in domain code; an unset configurable resolves to its stated default and never to unlimited; a change does not alter existing allocations, reservations or requests |
| `IMPL-585` | The configuration boundary — `BC-06` values conformed to, not configured, and no configurable that can disable a rule | `platform/services` | P1 | `IMPL-584` | `IMPL-599` | `SEAT-FR-266`, `SEAT-FR-267`, `SEAT-FR-301`, `SEAT-XC-022` | No competing local copy of a `SeatRules` value exists; no configurable can disable a §7 invariant, a §8 gate step, `SEAT-BR-014` or a tenancy rule; no per-seat, per-student or per-role override exists |
| `IMPL-586` | The consumed authorisation model — no framework, no scope value, no role administration here | `app` | P1 | `IMPL-502` | `IMPL-589` | `SEAT-FR-268`–`SEAT-FR-270` | No role, scope value, invitation, elevation or revocation path is definable in this module |
| `IMPL-587` | Privacy and non-disclosure — no personal attribute, no monetary value, and the exact `E-02` payload as the only composed membership data | `app` | P1 | `IMPL-528`, `IMPL-577` | `IMPL-588` | `SEAT-FR-275`–`SEAT-FR-280` | A student cannot learn who holds any other seat; no fee, price, plan amount, due, discount or balance is displayable or storable anywhere in this module |
| `IMPL-588` | Non-disclosing denial and export privacy | `app` | P1 | `IMPL-583`, `IMPL-587` | `IMPL-599` | `SEAT-FR-281`–`SEAT-FR-286` | A denial is indistinguishable from not-found through message, status, timing and field presence, yet is still audited; export is unavailable to Reception, students and guardians |
| `IMPL-589` | Multi-tenancy — every row tenant-keyed, ambient context, loud failure, and cross-tenant references treated as not-found | `platform/tenancy` | P1 | `IMPL-518`, `IMPL-586` | `IMPL-599` | `SEAT-FR-287`–`SEAT-FR-296`, `SEAT-INV-009`–`SEAT-INV-011` | `tenantId` is not accepted as a domain-method parameter; an unfiltered query is a check-time failure; a suspended tenant rejects every write; a cross-tenant identifier is not detectable as existing |


### 5.10 Wave 10 — Edge rules, remaining invariants, NFRs, acceptance proof (`IMPL-590` … `IMPL-599`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-590` | The four edge-audit rules added because the audit found a gap — container moves, inactive containers, wrong-seat check-in, quota shrink | `domain/library` | P1 | `IMPL-516`, `IMPL-552`, `IMPL-556` | `IMPL-592` | `SEAT-FR-297`–`SEAT-FR-300` | A container move is refused while allocated; an inactive container retains and flags allocations; a wrong-seat check-in is recorded and flagged without moving anyone; a quota shrink flags rather than evicts |
| `IMPL-591` | The three remaining structural invariants — zone/floor containment, no simultaneous allocation-and-reservation, and referential integrity of every seat-bound record | `platform/data` | P1 | `IMPL-515`, `IMPL-517`, `IMPL-518` | `IMPL-599` | `SEAT-INV-012`–`SEAT-INV-014` | Each is enforced at the storage layer and proven by an attempted violation, not by inspection |
| `IMPL-592` | The conflict-resolution rules — operation priority, retention-with-flagging, no automatic loss of a seat, and higher authority wins | `domain/library` | P1 | `IMPL-590` | `IMPL-593` | `SEAT-BR-041`–`SEAT-BR-044` | Where two rules could both apply, the priority order decides deterministically; retention and flagging both happen rather than one replacing the other |
| `IMPL-593` | Gap discipline — no open `SEAT-GAP-*` is closed by an implementation choice | `domain/library` | P1 | `IMPL-592` | `IMPL-598` | `SEAT-BR-045` | Each of the fourteen open gaps is either behind a configurable with a declared default or raised at build time; none is silently decided in code |
| `IMPL-594` | The consistency profile — strong on the seat, bounded-stale on membership, fast enough not to dominate acquisition | `domain/library` | P1 | `IMPL-548`, `IMPL-563` | `IMPL-599` | `SEAT-NFR-001`–`SEAT-NFR-003` | Seat acquisition is strongly consistent; membership staleness is bounded at 5 seconds and measured, not assumed |
| `IMPL-595` | No local latency or availability figures, seat-map scale, and real-time convergence | `app` | P2 | `IMPL-562`, `IMPL-580` | `IMPL-599` | `SEAT-NFR-004`–`SEAT-NFR-006` | No latency or availability number originates in this module; the seat map stays usable at the maximum permitted inventory; all connected staff clients converge without a manual refresh |
| `IMPL-596` | Robustness — duplicate and out-of-order `E-08`, audit off the critical path, and bulk operations atomic at the bound | `platform/event` | P1 | `IMPL-551`, `IMPL-559`, `IMPL-578` | `IMPL-599` | `SEAT-NFR-007`–`SEAT-NFR-009` | Duplicate and reordered delivery produce no wrong count; a bulk operation completes or fails as a unit at the maximum row count |
| `IMPL-597` | Observability — actionable rejection reasons, a reachable surface for every requirement, and derived reads that do not depend on a job | `app` | P1 | `IMPL-523`, `IMPL-538` | `IMPL-599` | `SEAT-NFR-010`–`SEAT-NFR-012` | Every rejection names the failing gate step and the offending value; state, expiry and metrics are correct when no background job has run |
| `IMPL-598` | The coverage mandate made structural — every rule cited by a criterion, absence-only requirements proven by absence, and no capability lost from the source draft | `test` | P1 | `IMPL-593` | `IMPL-599` | `SEAT-FR-302`–`SEAT-FR-304` | A `SEAT-BR-*`, `SEAT-INV-*`, `SEAT-EVT-*` or `SEAT-XC-*` with no citing criterion fails the run; each absence-only requirement is proven by a negative test |
| `IMPL-599` | Acceptance harness — all 226 `SEAT-AC-*` bound to named executable tests | `test` | P1 | `IMPL-509`, `IMPL-514`, `IMPL-519`, `IMPL-529`, `IMPL-531`, `IMPL-537`, `IMPL-540`, `IMPL-541`, `IMPL-542`, `IMPL-547`, `IMPL-549`, `IMPL-553`, `IMPL-554`, `IMPL-560`, `IMPL-561`, `IMPL-564`, `IMPL-566`, `IMPL-567`, `IMPL-571`, `IMPL-572`, `IMPL-573`, `IMPL-575`, `IMPL-579`, `IMPL-581`, `IMPL-585`, `IMPL-588`, `IMPL-589`, `IMPL-591`, `IMPL-594`, `IMPL-595`, `IMPL-596`, `IMPL-597`, `IMPL-598` | — | `SEAT-FR-302`, `SEAT-NFR-011` | Every `SEAT-AC-*` maps to at least one named, running test; an unbound criterion fails the run |

---

## 6. Traceability — task group → requirements → invariants → acceptance

Allocation rule 4 requires this table. Coverage figures are produced by
`tool/docs_check/prd007_task_coverage.py`, not counted by hand.

| Wave | Tasks | Requirements claimed | Invariants enforced | Acceptance criteria proven |
|---|---|---|---|---|
| **1** Boundary, spatial model, identity, layout | `IMPL-500`–`509` | `SEAT-FR-001`–`035`, `SEAT-BR-001`–`008` | — *(the container and identity rules precede the allocation invariants)* | `SEAT-AC-001`–`016` (spatial model, seat identity, layout editor) |
| **2** Derived state and allocation invariants | `IMPL-510`–`519` | `SEAT-FR-036`–`051`, `SEAT-BR-009`–`012`, `SEAT-XC-001`, `SEAT-XC-002` | `SEAT-INV-001`–`007` | `SEAT-AC-017`–`043` (lifecycle, derived state, allocation, quota, invariants) |
| **3** Acquisition gate, assignment, transfer | `IMPL-520`–`529` | `SEAT-FR-052`–`067`, `SEAT-FR-085`, `SEAT-FR-103`–`107`, `SEAT-BR-013`–`017`, `SEAT-XC-003`, `SEAT-XC-004` | *(re-proves `SEAT-INV-001` under the pessimistic lock — `IMPL-522`)* | `SEAT-AC-028`–`035`, `SEAT-AC-044`–`054` (gate order, assignment, release, transfer) |
| **4** Requests, self-booking, reservations | `IMPL-530`–`539` | `SEAT-FR-068`–`084`, `SEAT-FR-086`–`096`, `SEAT-FR-118`–`126`, `SEAT-BR-018`, `SEAT-BR-021` | *(re-proves `SEAT-INV-004`, `SEAT-INV-005` on the reservation paths)* | `SEAT-AC-055`–`083` (seat-change requests, self-booking, reservations) |
| **5** Reservation governance, types, categories, Membership boundary | `IMPL-540`–`549` | `SEAT-FR-097`–`102`, `SEAT-FR-127`–`157`, `SEAT-BR-019`, `SEAT-BR-022`–`024`, `SEAT-XC-005`, `SEAT-XC-006`, `SEAT-XC-010`, `SEAT-XC-011` | *(none new — the Membership boundary is a consumption rule, not an aggregate invariant)* | `SEAT-AC-084`–`097` (Fixed/Flexible, shifts, categories, eligibility), `SEAT-AC-098`–`105` (Membership boundary) |
| **6** Attendance boundary, locking, maintenance, bulk | `IMPL-550`–`559` | `SEAT-FR-108`–`117`, `SEAT-FR-158`–`179`, `SEAT-BR-020`, `SEAT-BR-025`–`029`, `SEAT-XC-007`–`009` | — | `SEAT-AC-106`–`113` (Attendance boundary), `SEAT-AC-114`–`131` (locking, maintenance, bulk) |
| **7** Auto-assign, QR, real-time, concurrency, events | `IMPL-560`–`569` | `SEAT-FR-180`–`217`, `SEAT-BR-030`–`033`, all four `SEAT-EVT-*`, `SEAT-XC-012`, `SEAT-XC-013` | — *(events publish the result of an invariant; they carry none)* | `SEAT-AC-132`–`152` (auto-assignment, QR, real-time, idempotency) |
| **8** History, audit, protected operations, notifications | `IMPL-570`–`579` | `SEAT-FR-218`–`243`, `SEAT-FR-271`–`274`, `SEAT-BR-034`, `SEAT-BR-035`, `SEAT-BR-038`–`040`, all 24 `SEAT-PO-*`, `SEAT-XC-014`–`017` | `SEAT-INV-008` | `SEAT-AC-153`–`184` (history, audit, notifications) |
| **9** Metrics, search, configuration, privacy, tenancy | `IMPL-580`–`589` | `SEAT-FR-244`–`270`, `SEAT-FR-275`–`296`, `SEAT-FR-301`, `SEAT-BR-036`, `SEAT-BR-037`, all 18 `SEAT-CFG-*`, `SEAT-XC-018`–`022` | `SEAT-INV-009`–`011` | `SEAT-AC-185`–`208` (configuration, permissions, multi-tenancy), plus the metrics and search criteria of `SEAT-AC-153`–`184` |
| **10** Edge rules, remaining invariants, NFRs, acceptance | `IMPL-590`–`599` | `SEAT-FR-297`–`300`, `SEAT-FR-302`–`304`, `SEAT-BR-041`–`045`, all 12 `SEAT-NFR-*` | `SEAT-INV-012`–`014` | `SEAT-AC-209`–`226` (governing rules, remaining invariants, remaining exclusions) — and, through `IMPL-599`, all **226** |

**Mechanically verified totals:**

| Register | Claimed / defined |
|---|---|
| `SEAT-FR` | **304 / 304** |
| `SEAT-BR` | **45 / 45** |
| `SEAT-INV` | **14 / 14** |
| `SEAT-EVT` | **4 / 4** |
| `SEAT-XC` | **22 / 22** |
| `SEAT-PO` | **24 / 24** |
| `SEAT-CFG` | **18 / 18** |
| `SEAT-NFR` | **12 / 12** |
| **TOTAL obligations** | **443 / 443 = 100.0%** |

> **Why `SEAT-AC-*` and `SEAT-GAP-*` are outside that denominator, stated rather than assumed.** A `SEAT-AC-*` is a
> criterion *verified by* a task's test, not a thing a task *builds*; `IMPL-599` is the task that proves all 226 are
> bound to running tests. A `SEAT-GAP-*` is an **open question** — `PRD-007` §0.3 states they *"are questions, not
> requirements, and must never be cited as verifiable"*, and `SEAT-BR-045` forbids resolving one by implementation
> choice. Counting either would inflate coverage while making it mean less. `PRD-007`'s **683** identifiers minus
> **226** `SEAT-AC-*` minus **14** `SEAT-GAP-*` = **443**, the figure above. This is the same denominator rule
> `PRD-005` used (333 − 97 − 13 = 223), applied to a larger register rather than reinvented.

**The acceptance-criteria column is an allocation, not a proof.** `SEAT-AC-*` are grouped to the wave whose behaviour
they exercise, following `PRD-007`'s own §33.1–§33.13 sectioning, so an implementer knows which criteria their wave
should make pass. Two waves legitimately share a band where the PRD's own criteria span both — `SEAT-AC-028`–`035`
appear against waves 2 and 3 because the acquisition gate's criteria test invariants defined in wave 2. The binding of
each individual criterion to a named test is `IMPL-599`'s deliverable and is **not** claimed as done here.

---

## 7. Critical path — computed, not asserted

Derived from the `Blocked by` column by the same script that checks it, so the claim is reproducible:

```
500 → 501 → 504 → 506 → 512 → 515 → 516 → 520 → 523
    → 524 → 525 → 526 → 556 → 590 → 592 → 593 → 598 → 599
```

**Longest chain: 18 of 100 tasks.** Graph facts, also computed: **0 cycles**; exactly **one root** (`IMPL-500`);
exactly **one leaf** (`IMPL-599`). Priorities: **64 × P1, 32 × P2, 4 × P3**.

**`IMPL-500` is the only root, and that is a property of this module rather than a modelling choice.** `PRD-005` had
two roots because its configurables could be read before its aggregate existed. Here every path runs through the
bounded-context boundary, because `SEAT-FR-001`/`SEAT-FR-002` make the ownership split — seven things owned, eight
consumed — the precondition for everything else. Even `IMPL-584` (the 18 configurables) depends on `IMPL-502`, since
`SEAT-FR-263` requires configuration to arrive through the `E-19` port rather than by direct lookup.

**`IMPL-599` is blocked by every otherwise-terminal task, and that list is derived, not typed.** The harness binds all
226 criteria, so it cannot begin until each task nothing else depends on has landed. Computing the edge set from the
graph caught a real defect during authoring: a hand-written dependency list left `IMPL-589` (multi-tenancy) outside the
harness's ancestry while `SEAT-AC-185`–`208` require exactly that work.

**Do not start `IMPL-580`, `IMPL-582` or `IMPL-583` early to show visible progress.** Metrics, search and filter
presets are the parts a stakeholder can see, and they sit late for a reason: `SEAT-FR-247` forbids a pre-aggregated
counter as a system of record, so a metric built before `IMPL-570` (allocation history) has nothing correct to read,
and the shortcut is to keep a running counter — which `SEAT-BR-036` and `SEAT-FR-247` both forbid.

**`IMPL-522` and `IMPL-515` must not be merged into one task.** `SEAT-BR-011` requires the seat invariant to be held
by *"a database unique constraint plus a pessimistic row lock, never optimistically."* Those are two mechanisms with
two distinct failure modes: a constraint without a lock still admits the lost-update window that gate G16 exists to
close, and a lock without a constraint fails the moment a second process bypasses the gate. `IMPL-563` is the task
whose test exercises both together under real concurrency.

---

## 8. Tasks that must **not** be created

| Tempting task | Why it must not exist |
|---|---|
| "Add a `Floor` management screen" | `SEAT-FR-015`, `SEAT-GAP-001`. `Floor` ownership is a **live conflict** between BC Map §8 and `LIB-10.*`; this module reads floors and never creates, renames or deletes one. Building the screen would decide the conflict |
| "Add an 'assign anyway' override for an invalid membership" | **`SEAT-BR-014`**, `SEAT-BR-040`, `SEAT-XC-004`. The one gate no role including Owner may override. `MP-GBR-16` is absolute |
| "Implement a waiting list / seat queue" | `SEAT-XC-005`, `SEAT-FR-101`. Classified **V2** in §34. Any automatic promotion path is the violation |
| "Store the seat's current student on the seat row" | `SEAT-FR-025`. Current student, shift, join date and expiry are properties of the **allocation**, not the seat. This is the denormalisation that makes `SEAT-INV-001` unenforceable |
| "Add a settable `SeatState` column for performance" | `SEAT-BR-010`, `SEAT-XC-002`. State is **derived** from F1…F5 by a total function; a stored settable value can contradict the facts |
| "Cache membership validity locally so acquisition survives an outage" | `SEAT-XC-010`, `SEAT-FR-152`. Acquisition **fails closed**. A cache-tolerant read that assumes still-valid is the revenue-leak failure mode `MP-GBR-16` exists to prevent |
| "Compute the student's `seatQuota` from their plan" | `SEAT-FR-048`, `SEAT-XC-010`. The **published** projection value is authoritative; `MM-FR-025` means a plan edit must not evict a seated student |
| "Record attendance when a seat QR is scanned" | `SEAT-XC-012`, `SEAT-BR-030`, `SEAT-GAP-007`. A seat QR authenticates nobody and is not an attendance mechanism. Whether it is the same physical artefact is an **open question** |
| "Store a price or premium fee on a Premium/VIP category" | `SEAT-FR-144`, `SEAT-FR-279`, `LIB-11.4`, `LXC-7`. Seat-class pricing is a `BC-02` **plan** concern; `BC-05` owns every amount |
| "Build an occupancy trend chart" | `SEAT-XC-018`, `SEAT-FR-248`, `SEAT-BR-036`. The boundary is **time**: current-state figures are operational, series are `BC-26`'s. A warehouse here is the `OWN-4` failure |
| "Expose live per-seat occupancy on the public profile" | `SEAT-XC-009`, `SEAT-XC-020`, `SEAT-GAP-014`. Deferred to **V2** by `ARCHITECTURE_RULINGS.md` §6 and `LIB-24.2`; per-seat occupancy discloses a person's physical presence |
| "Add a fifth domain event for reservation created / lock / maintenance" | `SEAT-FR-206`, `SEAT-FR-210`. The register is **closed at four** by BC Map §9; adding one requires an ADR, not an implementation |
| "Emit `SeatReminderRequested` so notifications fire" | `SEAT-BR-035`, `SEAT-FR-207`. A command-shaped event. `BC-22` decides channel and recipient; this module emits **facts** |
| "Store 'reminder sent' against the reservation" | `SEAT-XC-017`. Delivery state belongs to `BC-22` and must not be stored or displayed here |
| "Define a `SeatManager` role, or a zone-scoped permission" | `SEAT-FR-268`, `SEAT-FR-269`, `SEAT-GAP-006`. `BC-18` owns the authorisation model and `MP-GBR-21` closes the scope register. A floor- or zone-scoped grant needs an ADR |
| "Add a per-seat configuration override" | `SEAT-XC-022`, `SEAT-FR-301`. Every configurable is tenant-level, and none may disable an invariant, a gate step or a tenancy rule |
| "Implement a 24-hour grace period after membership expiry" | `SEAT-GAP-003`, `SEAT-FR-155`. BC Map `Q-01` is an **open question** — whether an expired membership releases the seat immediately, at end of day, or after a grace period is undecided. `IMPL-590` flags; it does not evict |
| "Build a full-text seat and student search" | `SEAT-XC-021`, `SEAT-FR-262`. Fuzzy, phonetic and relevance-ranked search are out of scope; a branch-bounded exact query is adequate and is this module's own |
| "Waive the 9 cross-context violations to green gate 3" | `BLK-01`. Real debt owned by `TASK-D10`, `ADR-0012` expiry 2026-10-31 |

**Nineteen tasks a competent engineer might reasonably add, each mapped to the rule it would break.** They are listed
so that their absence is visible as a **decision** rather than an oversight — the same reason `PRD-005`'s backlog
lists fourteen and `PRD-004`'s lists six. Six of them would additionally close an open `SEAT-GAP-*` by writing code,
which `SEAT-BR-045` forbids in those words.

---

## 9. What this document does **not** claim

| Not claimed | Actual state |
|---|---|
| That any task is started | **Zero.** No `lib/` file created or modified |
| That `PRD-007` is frozen | It is **`DRAFT`**. Stage 6 makes it *eligible* for a Stage 7 proposal and nothing more |
| That the registry was updated | `PRD_REGISTRY.md` still records `PRD-007` as **`PLANNED`** and is **byte-identical**. Status is conferred by admission to the baseline, never self-declared |
| That the traceability matrix was updated | `TRACEABILITY_MATRIX.md` is **byte-identical**. Stage 5 registered the prefixes; Stage 6's gate names no registry edit, and `PRD-005`'s Stage 6 made none |
| That an ADR was created | **None.** No ranked document changed, so `DOCUMENTATION_BASELINE.md` §7 is not triggered |
| That estimates exist | **None is given.** No sizing was requested; inventing one would be noise |
| That 100 tasks complete `BC-04` | They cover `PRD-007` v1.0's **443 obligations**. The **14 open `SEAT-GAP-*`** remain undecided and unimplemented |
| That the 226 `SEAT-AC-*` are bound to tests | They are **allocated to waves** in §6. Binding each to a named test is `IMPL-599`'s deliverable |
| That the wave→`SEAT-AC-*` mapping is exhaustive per wave | It follows `PRD-007` §33's own sectioning. Two bands are shared between waves where the PRD's criteria span both, and that is stated in §6 rather than hidden |
| That `IMPL-500`…`599` are in the roadmap register | They are declared **here** and nowhere else yet. `IMPLEMENTATION_ROADMAP.md` and `PRD_LIFECYCLE.md`'s Stage 6 table still end at `IMPL-227+` — the same staleness `PRD-004` §7 and `PRD-005` §3.3 record. **Not corrected here** (§3.3) |
| That gate 3 will be green | It is **red** and stays red until `TASK-D10`/`BLK-01` |
| That the upstreams exist | `PRD-004` and `PRD-005` are frozen but **unimplemented**; `PRD-006` and `PRD-023` are `PLANNED`/unwritten. See §4 |
| That module paths are architecture decisions | The `Module` column reuses the **existing** rank map of `DEPENDENCY_GRAPH.md` §44. No new module is proposed and no directory is created |

---

## 10. Definition of done — applies to every task

A task is done when **all** hold. Items 3 and 4 block merge (`TRACEABILITY_MATRIX.md` §10.4).

1. `dart format --set-exit-if-changed .` → exit 0
2. `flutter analyze` → `No issues found!`
3. `dart run tool/check_module_boundaries.dart` → **no new violation** (the 9 existing `TASK-D10` violations are pre-existing and **must not be waived**)
4. `flutter test test/architecture/` → all pass
5. `flutter test` → all pass, **including the task's own new test**
6. The `SEAT-*` requirements in the task's Requirements cell are each asserted by at least one test
7. No frozen document modified; no integration edge used beyond the seven inbound of `SEAT-FR-008` and the three outbound of `SEAT-FR-011`
8. `python3 tool/docs_check/prd007_task_coverage.py` → exit 0 *(if the task row itself changed)*

> **Item 6 is the one that is usually skipped.** A task can pass items 1–5 while asserting nothing about its
> requirements. `SEAT-NFR-011` and `SID-4.56` treat such a requirement as **unmet**, not as satisfied by intent.

> **Item 7 has a second edge here that it did not have for `PRD-005`.** `SEAT-FR-008` closes the inbound edge set at
> seven and `SEAT-FR-009` forbids reading another context's tables. A task that reaches into a `BC-01`, `BC-02` or
> `BC-03` table to avoid building a port passes items 1–5 and violates the ownership boundary that `SEAT-BR-002`
> makes a defect.

---

## 11. Stage 6 exit gate — re-runnable

```
python3 tool/docs_check/prd007_task_coverage.py     → exit 0
```

The gate fails if any of the following becomes true: a task has an empty **Requirements** cell; a task cites a
`SEAT-*` identifier `PRD-007` does not define; a task cites a `SEAT-GAP-*` as an obligation; an `IMPL-*` is
duplicated, falls outside `IMPL-500`…`599`, or collides with `IMPL-014`–`073` / `100`–`127` / `200`–`226` /
`300`–`323` / `400`–`499`; a **Blocked by** entry names no known task; a **Priority** cell is blank; **Blocks** and
**Blocked by** disagree for a local pair; the dependency graph acquires a cycle; or any of the **443** obligations
loses its last claiming task.

Current result — **PASS**:

```
Tasks parsed 100 · unique 100 · duplicates 0 · out of range 0 · foreign collisions 0
Tasks with no requirement 0 · undefined citations 0 · malformed ranges 0
Unresolvable dependencies 0 · missing Priority 0 · Blocks/Blocked-by disagreements 0
Cycles 0 · longest chain 18 · roots 1 · leaves 1
Coverage 443/443 = 100.0%
```

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created as the **Stage 6** gate artefact for `PRD-007` v1.0. Allocated **`IMPL-500` … `IMPL-599`** — 100 tasks in 10 waves — after enumerating every `IMPL-*` in the repository (144 distinct numbers) rather than reading `PRD_LIFECYCLE.md`'s stale `IMPL-227+` table, and after inspecting the single `IMPL-500` token at its source to confirm it is `PRD-005` §3.2's *"Unallocated"* marker rather than a use. Skipped `IMPL-442`–`499`, `PRD-005`'s declared growth reserve, per allocation rule 2. Records `Priority`, `Blocks` and `Blocked by` per task (rule 3) and the group→requirement→invariant→acceptance table (rule 4). Coverage is **computed, not asserted**: `tool/docs_check/prd007_task_coverage.py` proves **443/443 = 100.0%** of obligations claimed, 0 undefined citations, 0 `SEAT-GAP-*` cited as obligations, 0 duplicate or out-of-range IDs, 0 collisions with the five foreign ranges, 0 cycles, `Blocks`/`Blocked by` mutually consistent, 1 root and 1 leaf; the 18-task critical path is derived from the graph. One defect the derivation caught during authoring was fixed rather than argued away: a hand-written `Blocked by` list for `IMPL-599` left `IMPL-589` (multi-tenancy) outside the acceptance harness's ancestry although `SEAT-AC-185`–`208` require it, so the harness's edge set is now computed from the graph as "every otherwise-terminal task". Lists **19 tasks that must not be created**, each mapped to the rule it would break, six of which would close an open `SEAT-GAP-*` by writing code. **Nothing is implemented: zero `lib/` files changed, no estimates invented, no specification written, no schema, SQL, DDL, API shape, widget tree or class signature; `PRD-007` unmodified and still `DRAFT`; `TRACEABILITY_MATRIX.md`, `PRD_REGISTRY.md`, `PRD_LIFECYCLE.md`, `PRD-004`'s and `PRD-005`'s backlogs and allocation tables all untouched; no registry entry, no ADR, and no freeze.** |
