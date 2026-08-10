# Seat Management — Product Requirements Document

| Field | Value |
|---|---|
| **PRD** | `PRD-007` |
| **Module** | Seat Management (Master PRD §8 module **7**) |
| **Bounded context** | **`BC-04` Seating** — `[CORE]`, Library Management domain |
| **Aggregates owned** | `SeatAllocation` · `SeatLayout` *(BC Map §8)* |
| **Version** | **v1.0** |
| **Status** | **`DRAFT`** — [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 2**. Not architecture-reviewed, not traceability-registered, **not frozen** |
| **Date** | 2026-08-04 |
| **Release** | **V1** |
| **Baseline** | Written against `BASELINE-2026-08-04-D` |
| **Rank** | Rank 3 (module PRD) — **claimed on freeze, not now** |
| **Identifier prefix** | **`SEAT-*`** — see §0.3 |
| **Consumes** | `BC-02` Membership (`E-02`) · `BC-03` Attendance (`E-08`) · `BC-06` Library Policy (`E-05`) · `BC-01` Enrollment (`E-01`-family status event) · `BC-21` Entitlement (`E-17`) · `BC-19` Tenancy (`E-18`) · `BC-25` Configuration (`E-19`) |
| **Publishes to** | `BC-24` Audit Trail (`E-20`) · `BC-22` Notification Delivery (`E-23`) · `BC-26` Analytics · `BC-22` capacity alerting |
| **Authorities applied** | Master PRD v1.7 (Rank 1) · `ADR-0011`, `ADR-0016` (Rank 2) · Library PRD v1.0, Authentication PRD v2.0, `PRD-004` v1.2 **FROZEN**, `PRD-005` v1.4 **FROZEN** (Rank 3) · BC Map (Rank 4) · `ARCHITECTURE_RULINGS.md` `AR-1`…`AR-7` (Rank 5) |

---

## 0. Document control

### 0.1 What this document is

This PRD states **product behaviour and business rules** for `BC-04` Seating. It is the improved,
architecture-aligned successor to the Seat Management v1.0 draft supplied by the product owner.

It does **not** define — and must not be read as defining — a database schema, SQL migration, API URL,
framework choice, Flutter widget, backend code or infrastructure. Those belong to the Specification and
Implementation stages (Lifecycle Stages 7→8). This constraint is the source draft's §43, retained verbatim in
intent.

### 0.2 Normative language

Per [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) Stage 2 rule 4, this document
defines its normative vocabulary.

| Term | Meaning |
|---|---|
| **MUST** / **MUST NOT** | An absolute requirement. A build that violates it is defective. |
| **SHOULD** / **SHOULD NOT** | A strong recommendation. Deviation requires a recorded reason. |
| **MAY** | Genuinely optional, or configurable. Where **MAY** expresses configurability, the configurable is registered in §27 with a `SEAT-CFG-*` identifier and a default. |
| *(no keyword)* | Explanatory prose. Creates no requirement. Quoted blocks marked `>` are rationale and are **not** normative. |

**On vague wording.** The source draft used *"where permitted by policy"*, *"according to configured rules"*,
*"where applicable"* and *"may automatically"* in fourteen places. Every one has been resolved into either (a) a
deterministic rule, or (b) a named `SEAT-CFG-*` configurable with a default. Where a decision genuinely does not
belong to this module, the owning context is named. **No requirement in this document is left to interpretation
at implementation time.** This satisfies the review instruction on business-rule quality.

### 0.3 Identifier registers — declared up front, ranges published as a promise

**Prefix decision, and why it is not `SM-*`.** The source draft asked for `SM-FR-001`, `SM-BR-001`,
`SM-INV-001`, `SM-AC-001`, `SM-NFR-001`. **`SM-*` is already owned by `PRD-004` Student Management, which is
`FROZEN` at Rank 3.** A repository-wide scan measured existing `SM-*` definitions:

| Existing register | Owner | Measured occurrences in `docs/**` |
|---|---|---|
| `SM-AC-*`, `SM-BR-*`, `SM-EV-*`, `SM-GAP-*`, `SM-INV-*`, `SM-PO-*`, `SM-XC-*` | **`PRD-004`, FROZEN** | 250 · 64 · 180 · 281 · 110 · 50 · 69 |

Adopting `SM-*` would violate `PRD_LIFECYCLE.md` §5 rule 1 (*"unique across the whole platform"*), §5 rule 3
(*"on collision, change the **new** prefix, never the existing one"*) and the review instruction *"do not create
duplicate IDs"*. The draft itself said *"first inspect the repository's existing requirement-ID conventions"* —
this is the result of that inspection. **`SEAT-*` was verified absent from `docs/**` (0 occurrences) before
adoption**, by the same grep-absence procedure `PRD-005` §25.3 used for `MM-*`.

| Register | Meaning | Range |
|---|---|---|
| `SEAT-FR-n` | Functional requirement | `SEAT-FR-001` … `SEAT-FR-262` |
| `SEAT-BR-n` | Business rule (cross-cutting, testable) | `SEAT-BR-001` … `SEAT-BR-044` |
| `SEAT-INV-n` | Domain invariant, enforced **synchronously inside the aggregate** | `SEAT-INV-001` … `SEAT-INV-014` |
| `SEAT-EVT-n` | Domain event — **closed set**, fixed by BC Map §9 | `SEAT-EVT-001` … `SEAT-EVT-004` |
| `SEAT-XC-n` | Exclusion — must be impossible or is out of scope | `SEAT-XC-001` … `SEAT-XC-022` |
| `SEAT-PO-n` | Protected operation — **closed list** | `SEAT-PO-001` … `SEAT-PO-024` |
| `SEAT-CFG-n` | Configurable, with an owner and a default | `SEAT-CFG-001` … `SEAT-CFG-016` |
| `SEAT-NFR-n` | Non-functional requirement | `SEAT-NFR-001` … `SEAT-NFR-012` |
| `SEAT-AC-n` | Acceptance criterion | `SEAT-AC-001` … `SEAT-AC-118` |
| `SEAT-GAP-n` | **Proposed gap / open question — NOT a requirement** | `SEAT-GAP-001` … `SEAT-GAP-014` |

Ranges are contiguous. Numbers are never reused. `SEAT-GAP-*` identifiers are **questions, not requirements**,
and must never be cited as verifiable.

### 0.4 Relationship to the source draft

The source draft's 46 sections are preserved in substance. §40 of this document maps every one of the 45
capabilities on the product owner's do-not-drop checklist to the requirement that carries it. Five changes were
made because the draft conflicted with a **higher-authority** document; each is stated with its reason in §39.
**No requirement was removed to simplify.**

---

## 1. Purpose, objectives and scope

### 1.1 Purpose

Seat Management provides the **single authoritative operational view of library seating**: which seat exists,
where it is, what state it is in, who holds it, and what happened to it. It digitises seat allocation so that no
seat is allocated twice, no allocation is invisible, and no allocation is unexplainable after the fact.

`SEAT-FR-001` — This module **MUST** be the sole authority for seat existence, seat spatial arrangement, seat
operational state, seat allocation, seat transfer, seat reservation and seat occupancy within a tenant.

`SEAT-FR-002` — This module **MUST NOT** own student identity, student profile, membership validity, attendance
records, money, notification delivery, authentication or authorisation mechanisms. Each is consumed through the
contract named in §3.

### 1.2 Objectives

`SEAT-FR-003` — The module **MUST** satisfy these ten objectives, each of which is measurable through the
acceptance criteria in §36:

| # | Objective | Proven by |
|---|---|---|
| 1 | Complete digitisation of seat management | §§4–5, §40 |
| 2 | Reduced manual allocation | §17 auto-assignment, §18 QR |
| 3 | Duplicate assignment is **impossible**, not merely unlikely | `SEAT-INV-001`, §21 |
| 4 | Real-time seat and occupancy information | §20 |
| 5 | Multiple floors, zones and layouts | §4 |
| 6 | Simple student booking | §11 |
| 7 | Efficient staff assignment and transfer | §§9–10 |
| 8 | Owner occupancy visibility | §25 |
| 9 | Complete, retained history and auditability | §§23–24 |
| 10 | Configurable policy without weakening any invariant | §27 |

### 1.3 V1 scope

`SEAT-FR-004` — V1 scope is exactly: spatial model (floors, zones, layout) · seat creation and configuration ·
seat operational state · allocation · transfer · reservation · student self-booking · seat-change requests ·
fixed and flexible seating · seat categories · seat eligibility evaluation · seat locking · maintenance
workflow · automatic assignment · QR-initiated assignment · search and filters · seat timeline · operational
occupancy metrics · notification event emission · audit event emission · configuration · bulk seat
import/export · bulk reassignment · 2D interactive layout.

`SEAT-FR-005` — 3D layout is **optional** and, when absent, its absence **MUST NOT** limit any other requirement
in this document. See `SEAT-FR-035`.

---

## 2. Ubiquitous language

Terminology is fixed here because the BC Map §5 register makes ubiquitous language a **compile-time constraint**,
not documentation. Five of these distinctions are the ones the source draft blurred.

| Term | Definition in this module | Must not be confused with |
|---|---|---|
| **`Seat`** | A physical numbered position in a layout, owned by this module | **`SeatQuota`** — an allowance count in a membership plan, owned by `BC-21` Entitlement / published by `BC-02` (BC Map line 211, `MM-FR-014`) |
| **`SeatAllocation`** | The aggregate representing one seat held by one student over one time window. **The transaction boundary.** | The seat itself; a reservation; an attendance punch |
| **`SeatLayout`** | The aggregate representing spatial arrangement — positions and non-seat furniture | The seat inventory; `Floor`; `Zone` |
| **`SeatState`** | The **derived** operational state a seat presents: `Available`, `Reserved`, `Occupied`, `Maintenance` | `Lock` (an independent flag) and the four contributing facts. See §6 |
| **`Lock`** | An independent administrative flag suppressing *new* acquisition | A `SeatState` value. **Locked is not a status** — see §6.2 and §39 change **C-2** |
| **`Reservation`** | A time-bounded, expiring hold that blocks acquisition but confers no occupancy | An allocation; a booking |
| **`Booking`** | A **student-initiated** request that produces a reservation or an allocation per §12 | A reservation (a booking is the act; a reservation may be its result) |
| **`Assignment`** | A **staff-initiated** act creating or moving an allocation | A booking |
| **`Occupancy`** | Whether the holder of an allocation is **physically present**, derived from `BC-03` check-in/out | The allocation. A student may hold a seat and be absent. See §14 |
| **`Floor`** | A physical level of a branch — **owned by `BC-06` Library Policy / Library PRD `LIB-10.*`** | A seat container this module creates. See §39 change **C-1** |
| **`Zone`** | A named area within a floor — **owned by `BC-06`**, `LIB-11.1` | A "Room". See §4.1 and §39 change **C-1** |
| **`Shift`** | A named time window; **`Shift` definitions are owned by `BC-06`** (`LIB-16.4`) | A seat attribute this module defines |
| **`SeatCategory`** | A classification of a seat (Normal / Premium / VIP or tenant-defined) | `Zone`. A zone is spatial; a category is a class of seat |

`SEAT-BR-001` — This module **MUST** use these terms with these meanings in every requirement, event payload and
user-facing label. A bare "Seat", "Status", "Room" or "Shift" in a cross-context contract is a defect.

---

## 3. Architectural position

### 3.1 What this module owns

`SEAT-FR-006` — This module owns exactly two aggregates, as fixed by BC Map §8: **`SeatAllocation`** and
**`SeatLayout`**. Its key entities and value objects are `Seat`, `SeatCategory`, `Reservation`, `MaintenanceRecord`,
`OccupancySnapshot`.

`SEAT-FR-007` — The aggregate is the transaction boundary. One aggregate, one transaction, **no exceptions**
(BC Map §8). A single operation **MUST NOT** transactionally mutate `SeatAllocation` and `SeatLayout` together.

> **BC Map §8 lists `Floor` among `BC-04`'s entities.** Library PRD `LIB-10.1`…`LIB-10.6` and `LIB-11.1`…`LIB-11.5`
> define `Floor` and `Zone` as `BC-06` records with their own uniqueness, capacity and status rules, and BC Map
> §8 gives `BC-06` the `BranchPolicy` aggregate. Two Rank-3/Rank-4 documents therefore disagree about who owns
> `Floor`. This is **not resolved by this PRD** — it is recorded as `SEAT-GAP-001` and this document is written
> to be correct under either resolution: it **reads** floors and zones and **never creates or renames them**
> (`SEAT-FR-026`). Per `DOCUMENTATION_BASELINE.md` §4, *"a conflict is a defect — do not choose, raise it."*

### 3.2 Inbound contracts — what this module consumes

`SEAT-FR-008` — Every inbound dependency **MUST** be one of the following edges. BC Map §7 states: *"if an edge
is not in this table, it does not exist and adding it requires an ADR."* This module **MUST NOT** invent an edge.

| Edge | Upstream | Contract consumed | This module's obligation |
|---|---|---|---|
| **`E-02`** | `BC-02` Membership | `MembershipValidity{studentRecordId, validUntil, seatQuota}` read projection | **Reject** acquisition when invalid (`SEAT-BR-010`). Never recompute validity |
| **`E-05`** | `BC-06` Library Policy | `SeatRules{maxTransfersPerDay, reservationWindow}` sync port | **Conform** — consume as given, do not translate, do not store a competing copy |
| **`E-08`** | `BC-03` Attendance | `StudentCheckedIn` / `StudentCheckedOut` events | Update live occupancy. **This module is the occupancy owner; Attendance is the trigger** |
| **`E-01` family** | `BC-01` Enrollment | `enrollment.StudentStatusChanged` | React to suspension by refusing new acquisition (`SEAT-BR-013`) |
| **`E-17`** | `BC-21` Entitlement | `check(tenantId, feature, delta)` | Call **before** the aggregate mutates |
| **`E-18`** | `BC-19` Tenancy | Ambient `TenantContext` | Propagated, **never** passed as a domain-method parameter |
| **`E-19`** | `BC-25` Configuration | Typed config accessors | No raw string lookups in domain code |

`SEAT-FR-009` — This module **MUST NOT** read another context's tables. It reads published read projections and
sync ports only.

`SEAT-FR-010` — This module **MUST NOT** hold, copy or cache a student's name, photograph, contact details,
guardian data, fee balance or attendance total. It holds a `StudentRecordId` reference and composes display data
at read time from the owning context, in the manner `PRD-004` `SID-2.7` / `LMD-24b` prescribes.

### 3.3 Outbound contracts — what this module publishes

`SEAT-FR-011` — Outbound integration **MUST** be limited to `E-20` (Audit, fire-and-forget, outbox-backed),
`E-23` (Notification, facts only) and the domain events of §22, whose consumers are fixed by BC Map §9.

`SEAT-FR-012` — This module **MUST NOT** call `BC-24` Audit synchronously (BC Map `E-20`), and **MUST NOT**
instruct `BC-22` to send anything (`E-23`, `F-1`…`F-3`).

### 3.4 Ownership boundary — the ten-context review

| Context | Owns | This module's relationship | This module **MUST NOT** |
|---|---|---|---|
| `BC-01` Enrollment — Student Management (`PRD-004`) | `StudentRecord`, `EnrollmentStatus`, student profile | Reads `StudentRecordId` and enrollment status | Store a name, contact, photo or profile field (`SM-2.4`) |
| `BC-10` Global Person Identity (`PRD-Student Identity`) | `PersonId`, public profile, username, privacy mode | **No edge exists.** `E-13` is the only bridge and it belongs to `BC-01` | Reference a `PersonId`, or display a public profile |
| `BC-01` read composition — Library Member Directory | The member-list read model | Is a **contributor**: publishes a `BC-04` public read model containing current seat, shift and zone (`PRD-004` line 606) | Become authoritative over the Directory, or read it |
| `BC-02` Membership (`PRD-005`, FROZEN) | Membership lifecycle, validity, `seatQuota` | Consumes `E-02`; **blocks** on invalid | Recompute validity, decide expiry grace, or alter `seatQuota` |
| **`BC-04` Seating — this module** | Seat lifecycle, layout, allocation, reservation, transfer, occupancy | — | — |
| `BC-03` Attendance (`PRD-006`, PLANNED) | `AttendanceDay`, punches, verification evidence, corrections | Consumes `E-08` to derive occupancy | Record, correct, verify or store attendance (§14) |
| `BC-05` Fee & Collection — Revenue & Finance | `FeeLedger`, receipts, refunds, `Money` | **None.** No edge exists | Hold a price, a fee, an amount or a currency |
| `BC-22` Notification Delivery | Channel selection, template, quiet hours, dispatch | Emits facts via `E-23` | Implement SMS, push, email, template or retry (§24) |
| `BC-26` Analytics Read Model | Analytical reports, trends, cohorts, retention | Serves **operational counts over current state** only (§25) | Build a warehouse, a trend series or a historical analytical model |
| `BC-18` Identity & Access — Authentication | `Account`, `AccessRole`, session, permission evaluation | **Consumes** the existing RBAC + scope model | Invent an authorization framework, define a role, or store a credential |

`SEAT-BR-002` — This module **MUST NOT** duplicate the responsibility of any context in the table above. A
requirement that would do so is a defect and **MUST** be raised, not implemented.

