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
made because the draft conflicted with a **higher-authority** document; each is stated with its reason in §35.
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
acceptance criteria in §33:

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
| **`Lock`** | An independent administrative flag suppressing *new* acquisition | A `SeatState` value. **Locked is not a status** — see §6.2 and §35 change **C-2** |
| **`Reservation`** | A time-bounded, expiring hold that blocks acquisition but confers no occupancy | An allocation; a booking |
| **`Booking`** | A **student-initiated** request that produces a reservation or an allocation per §12 | A reservation (a booking is the act; a reservation may be its result) |
| **`Assignment`** | A **staff-initiated** act creating or moving an allocation | A booking |
| **`Occupancy`** | Whether the holder of an allocation is **physically present**, derived from `BC-03` check-in/out | The allocation. A student may hold a seat and be absent. See §14 |
| **`Floor`** | A physical level of a branch — **owned by `BC-06` Library Policy / Library PRD `LIB-10.*`** | A seat container this module creates. See §35 change **C-1** |
| **`Zone`** | A named area within a floor — **owned by `BC-06`**, `LIB-11.1` | A "Room". See §4.1 and §35 change **C-1** |
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
> (`SEAT-FR-015`). Per `DOCUMENTATION_BASELINE.md` §4, *"a conflict is a defect — do not choose, raise it."*

### 3.2 Inbound contracts — what this module consumes

`SEAT-FR-008` — Every inbound dependency **MUST** be one of the following edges. BC Map §7 states: *"if an edge
is not in this table, it does not exist and adding it requires an ADR."* This module **MUST NOT** invent an edge.

| Edge | Upstream | Contract consumed | This module's obligation |
|---|---|---|---|
| **`E-02`** | `BC-02` Membership | `MembershipValidity{studentRecordId, validUntil, seatQuota}` read projection | **Reject** acquisition when invalid (`SEAT-BR-012`). Never recompute validity |
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

---

## 4. Spatial model — floors, zones, layouts

### 4.1 "Room" is realised as `Zone`

The source draft required *"multiple floors, multiple rooms, multiple layouts"* and *"every seat must belong to
exactly one room; every room must belong to a floor."* The platform already has that two-level container: Library
PRD `LIB-10.1` (`Floor` belongs to a `Branch`) and `LIB-11.1` (*"a `Zone` **MUST** belong to exactly one
`Floor`"*). The word "Room" appears **nowhere** in the BC Map, the Master PRD or the Library PRD.

`SEAT-FR-013` — The seat container hierarchy **MUST** be `Branch → Floor → Zone → Seat`. **`Zone` is the
realisation of the draft's "Room."** The requirement is preserved in full; only the term changes, to the one the
platform already owns.

`SEAT-FR-014` — A tenant-facing label for `Zone` **MAY** be configured as "Room", "Hall", "Section" or any other
tenant term (`SEAT-CFG-001`). The label is presentation only and **MUST NOT** create a second entity.

`SEAT-BR-003` — Every seat **MUST** belong to exactly one `Zone`. Every `Zone` **MUST** belong to exactly one
`Floor`. Every `Floor` **MUST** belong to exactly one `Branch`. No seat may be orphaned at any point, including
mid-import and mid-layout-edit.

`SEAT-FR-015` — This module **MUST NOT** create, rename, renumber, delete or set the status of a `Floor` or a
`Zone`. Those are `BC-06` operations governed by `LIB-10.*` and `LIB-11.*`. This module **reads** them.

`SEAT-FR-016` — Where a tenant has not configured any additional `Floor`, the module **MUST** operate against the
single default floor `LIB-10.1` guarantees (*"at least one"*) and **MUST** remain fully operable — per `LIB-16.2`,
a library that has changed nothing must be fully operable.

`SEAT-FR-017` — A `Zone` **MAY** carry descriptive attributes this module reads, including a premium indicator
(`LIB-11.3`). This module **MUST NOT** attach a price to a zone or to a seat (`LIB-11.4`, `LXC-7`).

`SEAT-FR-018` — Where a `Floor`'s declared capacity (`LIB-10.4`) and the seat count configured here differ, this
module **MUST** surface the difference and **MUST NOT** silently reconcile it, per `LIB-10.5`.

`SEAT-FR-019` — Setting a `Floor` or a `Zone` to an inactive status **MUST NOT** delete seats or destroy
allocations (`LIB-10.6`). It **MUST** suppress *new* acquisition on seats in that container, with existing
allocations preserved and visible.

### 4.2 Layouts

`SEAT-FR-020` — A tenant **MUST** be able to hold multiple layouts: at minimum one `SeatLayout` per `Zone`.

`SEAT-FR-021` — A `SeatLayout` **MUST** be independently versioned. Saving a layout **MUST** create a new version
and **MUST NOT** overwrite the previous one in place.

`SEAT-FR-022` — Exactly one layout version per `Zone` **MUST** be marked active. Reads resolve against the active
version.

---

## 5. Seat identity, structure and the layout editor

### 5.1 Seat identity

`SEAT-FR-023` — Every seat **MUST** carry an immutable, system-generated internal identifier that is **never**
derived from its seat number, its position, its zone or its category.

`SEAT-BR-004` — A seat's internal identifier **MUST NOT** change for any reason: not on renumbering, not on
recategorisation, not on moving between layout positions, not on zone reassignment, not on maintenance, not on
lock, not on import. **Every allocation, reservation, history row and audit entry references the internal
identifier, never the seat number.**

> **This single rule is what makes review area 7 answerable.** If history referenced "A1 in Zone 2", renaming the
> zone would silently rewrite history.

`SEAT-FR-024` — A seat **MUST** carry: internal identifier · seat number · `Zone` reference · seat category ·
seat type (`Fixed` | `Flexible`) · lock flag · maintenance record reference (nullable) · created and updated
audit stamps.

`SEAT-FR-025` — A seat **MUST NOT** store the current student, the current shift, the join date or the membership
expiry date as **seat** fields. Those are properties of the **allocation** (`SeatAllocation`), or of `BC-02`, and
are composed at read time.

> **The source draft's §5 listed "current student, current shift, join date, membership expiry date" as seat
> fields.** Storing membership expiry on a seat would make this module a second home for a `BC-02` value, which
> `PRD-004` `SM-2.4` forbids for the analogous case and which `MM-FR-025` shows is unsafe. **The information
> remains fully available on the seat card (§13)** — it is composed, not stored. Recorded as §35 change **C-3**.
> No capability is lost.

### 5.2 Seat numbering

`SEAT-BR-005` — A seat number **MUST** be unique within its `Zone`. Two seats in one zone with the same number
**MUST** be rejected at creation, at edit and at bulk import.

`SEAT-BR-006` — The **same** seat number **MUST** be permitted in a different `Zone`. "A1" on Floor 1 Zone A and
"A1" on Floor 2 Zone B are two distinct seats and **MUST NOT** be treated as a conflict.

`SEAT-FR-026` — A seat number **MUST** be non-empty, **MUST** be trimmed of leading and trailing whitespace before
uniqueness evaluation, and uniqueness **MUST** be evaluated case-insensitively. "a1" and "A1" in one zone are the
same seat number.

`SEAT-FR-027` — Renumbering a seat **MUST** be permitted while it holds an active allocation, **MUST** re-validate
`SEAT-BR-005`, and **MUST NOT** alter the internal identifier or the allocation (`SEAT-BR-004`).

### 5.3 The layout editor

`SEAT-FR-028` — Owner **MUST** be able to edit the layout. Manager **MUST** be able to edit the layout **only**
where the layout-edit permission has been granted (`SEAT-PO-016`); the grant is not implied by the Manager role.

`SEAT-FR-029` — The editor **MUST** support drag-and-drop seat positioning and seat rearrangement.

`SEAT-FR-030` — The editor **MUST** support adding a seat and removing a seat.

`SEAT-FR-031` — The editor **MUST** support placing non-seat layout elements: **walls, doors, tables and
pillars**.

`SEAT-FR-032` — Non-seat layout elements **MUST NOT** be allocatable, reservable, bookable, lockable, searchable
as seats, or counted in any occupancy or capacity metric. They carry no state and no identity beyond the layout.

`SEAT-FR-033` — The editor **MUST** support explicitly saving a layout, producing a new version (`SEAT-FR-021`).

`SEAT-BR-007` — Moving a seat's visual position **MUST NOT** change its internal identifier, its seat number, its
category, its type, its lock state, its maintenance state, its allocation, its reservation or any history row.
**A layout edit is a spatial change only.**

`SEAT-BR-008` — A layout edit **MUST NOT** orphan an active allocation — a BC Map §8 invariant for `BC-04`, stated
there as *"layout edits cannot orphan an active allocation."* Removing a seat that holds an active allocation or an
unexpired reservation **MUST** be rejected with a specific reason naming the blocking allocation. The operator
**MUST** release or transfer it first.

`SEAT-FR-034` — Layout edits **MUST** be validated before persistence: no duplicate seat number in the zone, no
seat outside the layout bounds, no seat removal that violates `SEAT-BR-008`. An invalid layout **MUST** be
rejected in whole with a specific reason and **MUST NOT** be partially saved.

`SEAT-FR-035` — An interactive **2D** layout is **mandatory** for V1. An interactive **3D** layout is **optional**
and **MAY** be enabled later. Enabling 3D **MUST NOT** require any change to the seat model, the allocation model,
or any requirement in this document; 3D is a rendering of the same `SeatLayout`.

---

## 6. Seat lifecycle — the deterministic state model

This section answers review area 1. The source draft said *"every seat must have exactly one current operational
status"*, listed four values, and then described locking and maintenance as further things that constrain the
seat. That is three overlapping models. The resolution is **one derived state** over **five independent facts**.

### 6.1 Five independent facts

`SEAT-FR-036` — A seat's behaviour **MUST** be determined by exactly five independent, separately stored facts:

| # | Fact | Type | Owner | Mutated by |
|---|---|---|---|---|
| F1 | **Existence and container active** | derived | this module + `BC-06` | seat create/delete; floor/zone status (`SEAT-FR-019`) |
| F2 | **Maintenance record** | nullable record | this module | maintenance start / end (§16) |
| F3 | **Lock flag** | boolean | this module | lock / unlock (§19) |
| F4 | **Active reservation** | nullable, time-bounded | this module | reserve / expire / cancel / convert (§15) |
| F5 | **Active allocation** | nullable | this module | assign / book / transfer / release (§§9–12) |

`SEAT-BR-009` — These five facts are **independent**. Setting one **MUST NOT** implicitly clear another. Every
transition in §6.4 is explicit.

### 6.2 `SeatState` is derived, not stored

`SEAT-FR-037` — `SeatState` **MUST** be derived from F1…F5 by this total function, evaluated in this order, first
match wins:

| Order | Condition | Derived `SeatState` |
|---|---|---|
| 1 | F2 maintenance record is active | **`Maintenance`** |
| 2 | F5 active allocation exists | **`Occupied`** |
| 3 | F4 active, unexpired reservation exists | **`Reserved`** |
| 4 | otherwise | **`Available`** |

`SEAT-BR-010` — `SeatState` **MUST NOT** be stored as an independently mutable value that code can set directly.
It is computed. A build in which `SeatState` can disagree with F1…F5 is defective.

> **Why this ordering is not arbitrary.** Maintenance outranks occupancy because a seat that is physically
> unusable is unusable regardless of paperwork — and because a maintenance start that silently destroyed an
> allocation would violate the draft's own §24 (*"existing assignments must not be silently destroyed"*).
> Occupancy outranks reservation because an allocation is a stronger claim than a hold. The function is **total**:
> every combination of F1…F5 yields exactly one state, so `SEAT-XC-001` is structurally impossible rather than
> merely prohibited.

`SEAT-FR-038` — **`Locked` is NOT a `SeatState` value.** F3 is an orthogonal flag that suppresses *acquisition*
while leaving the derived state unchanged. A locked available seat presents as `Available (locked)`; a locked
occupied seat presents as `Occupied (locked)`.

> **The draft asked for a lifecycle over five values including `Locked`.** Making `Locked` a fifth status would
> make the model non-deterministic: the draft's own §23 says *"an existing valid assignment is not automatically
> removed merely because the seat is locked"* — so a locked occupied seat would have to be both `Locked` and
> `Occupied`, contradicting *"exactly one current operational status."* An orthogonal flag preserves **both**
> draft requirements with no contradiction. This is §35 change **C-2**; every locking rule survives, in §19.

`SEAT-FR-039` — Every surface displaying a seat **MUST** display the derived `SeatState` **and** the lock flag
when set. A lock **MUST NOT** be invisible.

### 6.3 What the four statuses mean, normatively

`SEAT-FR-040` — **`Available`**: no active maintenance, no active allocation, no unexpired reservation.
Acquisition **MAY** proceed if, and only if, every gate in §8 passes.

`SEAT-FR-041` — **`Occupied`**: an active allocation exists. **`Occupied` means allocated, not physically
present.** Physical presence is `Occupancy` and is separately derived (§14).

`SEAT-FR-042` — **`Reserved`**: an unexpired reservation exists. The seat **MUST NOT** be acquired by any other
student. The holder holds no occupancy right until conversion (§12.3).

`SEAT-FR-043` — **`Maintenance`**: an active maintenance record exists. The seat **MUST NOT** be newly allocated,
booked, reserved or auto-assigned by anyone, **including Owner**. Owner's remedy is to end maintenance first
(`SEAT-BR-020`).

### 6.4 Valid and invalid transitions

`SEAT-FR-044` — The following transitions of the **derived** state are the complete set. Any transition not in
this table **MUST** be impossible.

| From | To | Trigger | Guard |
|---|---|---|---|
| `Available` | `Occupied` | assign · direct book · auto-assign · QR · transfer-in · bulk reassign | every §8 gate passes |
| `Available` | `Reserved` | reserve · book-with-hold · approved reservation | every §8 gate passes |
| `Available` | `Maintenance` | maintenance start | authorised actor |
| `Reserved` | `Occupied` | reservation conversion (§12.3) · staff override (`SEAT-FR-098`) | holder eligible at conversion time |
| `Reserved` | `Available` | expiry · auto-cancel · holder cancel · staff cancel · rejection | — |
| `Reserved` | `Maintenance` | maintenance start | authorised actor; reservation cancelled **explicitly** (`SEAT-BR-021`) |
| `Occupied` | `Available` | release · transfer-out · enrollment archival (§30 case 24) | authorised actor or lifecycle event |
| `Occupied` | `Maintenance` | maintenance start | authorised actor; **allocation NOT destroyed** (`SEAT-BR-022`) |
| `Maintenance` | `Available` | maintenance end, no surviving allocation | — |
| `Maintenance` | `Occupied` | maintenance end, allocation survived (`SEAT-BR-022`) | — |

`SEAT-FR-045` — These transitions are **invalid** and **MUST** be rejected with a specific, distinguishable
reason:

| Invalid transition | Rejection reason |
|---|---|
| `Occupied` → `Reserved` | A seat with an active allocation cannot be reserved for another student (`SEAT-BR-011`) |
| `Occupied` → `Occupied` (different student) | Requires explicit release or transfer; **never** an implicit overwrite (`SEAT-BR-016`) |
| `Reserved` → `Reserved` (different student) | A seat holds at most one active reservation (`SEAT-INV-004`) |
| `Maintenance` → `Occupied` via a **new** allocation | Maintenance blocks new allocation for every role (`SEAT-BR-020`) |
| `Maintenance` → `Reserved` | Maintenance blocks reservation for every role (`SEAT-BR-020`) |
| acquisition on a locked seat | Lock suppresses acquisition (`SEAT-BR-018`) |
| acquisition on a seat in an inactive floor or zone | Container inactive (`SEAT-FR-019`) |

`SEAT-XC-001` — A seat **MUST NOT** simultaneously present as more than one of `Available`, `Reserved`,
`Occupied`, `Maintenance`. Structurally guaranteed by `SEAT-FR-037`.

`SEAT-XC-002` — A stored, directly settable status value that can contradict F1…F5 **MUST NOT** exist.

---

## 7. The allocation model

### 7.1 `SeatAllocation`

`SEAT-FR-046` — A `SeatAllocation` **MUST** carry: allocation identifier · seat internal identifier ·
`StudentRecordId` · `tenantId` · allocation type (`Fixed` | `Flexible`) · time window (`validFrom`, `validUntil`) ·
shift reference (nullable) · origin (§7.3) · state (`Active` | `Released`) · created and released audit stamps with
actor and reason.

`SEAT-FR-047` — An allocation **MUST** reference the student by `StudentRecordId` only. It **MUST NOT** carry a
`PersonId` (no `BC-04` → `BC-10` edge exists; `E-13` belongs to `BC-01`) and **MUST NOT** carry a name.

`SEAT-BR-011` — **One active allocation per seat per time window.** This is the BC Map §8 invariant and Master PRD
`MP-GBR-17`. It **MUST** be enforced by a **database unique constraint plus a pessimistic row lock, never
optimistically**. `MP-GBR-17` states this in those words; BC Map §10.1 lists double seat allocation as a case
where eventual consistency is unacceptable because *"a physical-world conflict cannot be compensated."*

`SEAT-INV-001` — At most one `Active` `SeatAllocation` **MUST** exist for a given (seat, overlapping time window).
Enforced synchronously inside the aggregate **and** at the storage layer.

`SEAT-INV-002` — At most one `Active` `SeatAllocation` **MUST** exist for a given (`StudentRecordId`, overlapping
time window), unless the student's published `seatQuota` permits more (§7.2).

`SEAT-INV-003` — `validUntil` **MUST** be strictly greater than `validFrom`.

`SEAT-INV-004` — At most one unexpired `Reservation` **MUST** exist for a given seat.

`SEAT-INV-005` — At most one unexpired `Reservation` **MUST** exist for a given (`StudentRecordId`, seat) pair.

`SEAT-INV-006` — An allocation **MUST NOT** exist for a seat that does not exist, or for a seat whose zone or floor
has been deleted.

`SEAT-INV-007` — An allocation's `tenantId` **MUST** equal the seat's `tenantId` and the student's `tenantId`.

### 7.2 Second seats and `seatQuota`

`SEAT-FR-048` — Whether a student may hold more than one concurrent allocation **MUST** be determined by the
`seatQuota` published on the `E-02` `MembershipValidity` projection. This module **MUST NOT** define, compute or
override `seatQuota`.

`SEAT-BR-012` — A request that would give a student more concurrent active allocations than the published
`seatQuota` **MUST** be rejected with a reason naming the quota and the current count.

`SEAT-FR-049` — Where `seatQuota` is absent from the projection (it is `MAY`-optional per `MM-FR-009`), the module
**MUST** treat the effective quota as **1** (`SEAT-CFG-002`, default 1). It **MUST NOT** treat absence as
unlimited.

> **`MM-FR-025` is load-bearing here.** A plan's `seatQuota` change *"MUST NOT alter the `seatQuota` already
> published for an active membership"* — it takes effect on renewal. This module therefore reads the **published**
> value and never re-derives it from a plan. A student physically sitting in a seat cannot be evicted by an owner
> editing a plan. Edge cases 13 and 14 in §30 depend on this.

### 7.3 Origin — every allocation records how it came to exist

`SEAT-FR-050` — Every allocation **MUST** record its origin from this closed set: `StaffAssigned` ·
`StudentBooked` · `ReservationConverted` · `AutoAssigned` · `QrAssigned` · `Transferred` · `BulkReassigned` ·
`BulkImported`.

`SEAT-FR-051` — Origin **MUST** be immutable once written and **MUST** appear in the seat timeline (§23) and the
audit event (§24).

---

## 8. The acquisition gate — one evaluation order for every path

The source draft described assignment, booking, auto-assignment, QR assignment and reservation approval as five
features, each with its own list of checks. Five lists drift. This section replaces them with **one ordered gate**
that every acquisition path executes.

`SEAT-FR-052` — Every operation that creates or moves an allocation or creates a reservation — staff assignment,
student booking, reservation approval, reservation conversion, auto-assignment, QR assignment, transfer, bulk
reassignment, bulk import — **MUST** evaluate the following gates in exactly this order, and **MUST** stop at the
first failure.

| # | Gate | Failure reason returned | Authority |
|---|---|---|---|
| G1 | **Tenant context resolved** | request rejected, no data disclosed | `MP-GBR-06`, `E-18` |
| G2 | **Actor authorised** for the operation on this resource and scope | non-disclosing denial (§28.4) | `MP-GBR-20`…`22` |
| G3 | **Idempotency**: has this request key already been applied? | prior result replayed, **not** re-applied | §21.3 |
| G4 | **Entitlement** `check(tenantId, feature, delta)` | tenant limit reached | `E-17` |
| G5 | **Student exists** in this tenant | *not found* — identical to *no permission* under G2 | `MP-GBR-22` |
| G6 | **Enrollment status** permits seating | student suspended / archived | `SEAT-BR-013` |
| G7 | **Membership validity** from `E-02` | **membership invalid — seating blocks** | `MP-GBR-16`, `E-02` |
| G8 | **`seatQuota` not exceeded** | quota reached, with count | `SEAT-BR-012` |
| G9 | **Seat exists** in this tenant | seat not found | `SEAT-INV-006` |
| G10 | **Floor and zone active** | container inactive | `SEAT-FR-019` |
| G11 | **Not in maintenance** | seat under maintenance | `SEAT-BR-020` |
| G12 | **Not locked**, or actor holds the lock-override permission | seat locked | `SEAT-BR-018` |
| G13 | **Seat category eligibility** for this student | not eligible for this category | §17 |
| G14 | **Shift compatibility**, where the seat or allocation is shift-bounded | shift conflict | §16 |
| G15 | **No conflicting reservation** held by another student | seat reserved | `SEAT-BR-011` |
| G16 | **No conflicting allocation** — acquired under a pessimistic lock | seat already allocated | `SEAT-INV-001` |

`SEAT-BR-013` — G6: a student whose `EnrollmentStatus` is `Suspended` or `Archived` **MUST** be refused new
acquisition. `PRD-004` line 288 requires that on suspension *"`BC-04` Seating … MUST react by refusing new
seat…"*. Whether `Inactive` also blocks is **not decided here** — `PRD-004` `SM-GAP-3` records it as unspecified;
this module treats `Inactive` per `SEAT-CFG-003` (default: **blocks**) and records `SEAT-GAP-002`.

`SEAT-BR-014` — G7 is **absolute and applies to every role, including Owner.** `MP-GBR-16`: *"a student may not be
seated without a valid membership."* This module **MUST NOT** provide an override, a bypass, a force-assign or an
"assign anyway" affordance for G7.

> **This is the one gate no role can override, and it must be stated plainly** because the source draft's §21
> said *"the Owner can override reservations"* and its §8 said *"reception can assign any available seat."* Neither
> may reach through `MP-GBR-16`. Overriding a *reservation* (a `BC-04` fact) is permitted; overriding *membership
> validity* (a `BC-02` fact) is not.

`SEAT-BR-015` — G16 **MUST** be evaluated under a pessimistic lock held until the transaction commits.
A read-then-write check without a lock is defective even if it appears to work (`MP-GBR-17`).

`SEAT-FR-053` — Gate failures **MUST** be distinguishable from one another in the returned reason, except where
`MP-GBR-22` requires non-disclosure (G2 and G5 collapse to one indistinguishable outcome).

`SEAT-FR-054` — A gate failure **MUST NOT** partially mutate state. No allocation, reservation, history row or
event is produced by a rejected request.

`SEAT-XC-003` — An acquisition path that skips or reorders these gates **MUST NOT** exist.

`SEAT-XC-004` — An "override membership validity" capability **MUST NOT** exist in any role, any screen, any bulk
operation or any import.

---

## 9. Staff assignment, release and transfer

### 9.1 Assignment

`SEAT-FR-055` — Reception, Manager and Owner **MUST** be able to assign an available seat to a student
(`SEAT-PO-001`), subject to §8 in full.

`SEAT-FR-056` — Assignment **MUST** require the actor to select the student explicitly. The module **MUST NOT**
infer the student from context.

`SEAT-FR-057` — Assignment **MUST** record actor, timestamp, origin `StaffAssigned` and, where the seat was
previously held, the reason.

`SEAT-FR-058` — An assignment attempt on a seat that is `Occupied`, `Reserved` (by another) or under maintenance
**MUST** be rejected with the specific gate reason. It **MUST NOT** silently overwrite.

`SEAT-BR-016` — Reassigning an occupied seat to a different student **MUST** require two explicit steps: release
(or transfer) the existing allocation, then assign. A single-step overwrite **MUST NOT** exist, because it would
destroy an allocation without an actor's explicit acknowledgement.

### 9.2 Release

`SEAT-FR-059` — Reception, Manager and Owner **MUST** be able to release an allocation (`SEAT-PO-002`).

`SEAT-FR-060` — Release **MUST** require a reason from a configurable reason list (`SEAT-CFG-004`) or free text,
and **MUST** record actor and timestamp.

`SEAT-FR-061` — Release **MUST** close the allocation as `Released` and **MUST NOT** delete it. Allocation records
are append-only history (§23).

### 9.3 Transfer

`SEAT-FR-062` — Reception, Manager and Owner **MUST** be able to transfer a student from one seat to another
(`SEAT-PO-003`).

`SEAT-FR-063` — A transfer **MUST** be atomic in effect: either the student holds the new seat and no longer holds
the old, or nothing changed. A state in which the student holds both, or neither, **MUST NOT** be observable.

`SEAT-FR-064` — A transfer **MUST** evaluate §8 in full against the **destination** seat before releasing the
source.

`SEAT-FR-065` — A transfer **MUST** produce exactly one transfer-history row (§23.3) recording source seat,
destination seat, actor, timestamp and reason.

`SEAT-BR-017` — The number of transfers a single student may be given per calendar day **MUST** be bounded by
`maxTransfersPerDay`, consumed from `BC-06` through the `E-05` `SeatRules` port. This module **MUST NOT** define
its own limit, store a competing copy, or translate the value.

`SEAT-FR-066` — Exceeding `maxTransfersPerDay` **MUST** be rejected with a reason naming the limit and the count
already used. Whether a role may override the limit is `SEAT-CFG-005` (default: **Owner only**).

`SEAT-FR-067` — A transfer **MUST NOT** count against the limit when it is initiated by the system rather than by
a person — specifically maintenance-driven relocation (§16) and bulk reassignment (§19.3) — because the student
did not request it.

---

## 10. Seat-change requests

`SEAT-FR-068` — A student **MUST** be able to raise a seat-change request naming a desired seat, a desired
category, or no preference, with an optional reason.

`SEAT-FR-069` — A seat-change request **MUST NOT** create, move, reserve or hold any seat. It is a request record
only.

`SEAT-FR-070` — A request **MUST** have exactly one state from the closed set: `Pending` · `Approved` · `Rejected`
· `Cancelled` · `Expired`.

`SEAT-FR-071` — Reception, Manager and Owner **MUST** be able to approve or reject a request (`SEAT-PO-004`), with
a reason mandatory on rejection.

`SEAT-FR-072` — Approving a request **MUST** execute a transfer (§9.3) and **MUST** evaluate §8 in full at
**approval** time, not at request time. Approval of a request whose target has since become unavailable **MUST**
fail with the gate reason and **MUST** leave the request `Pending`.

`SEAT-FR-073` — A student **MUST** be able to cancel their own `Pending` request.

`SEAT-FR-074` — A student **MUST NOT** hold more than `SEAT-CFG-006` (default **1**) `Pending` requests at a time.

`SEAT-FR-075` — A `Pending` request **MUST** expire after `SEAT-CFG-007` (default **7 days**) and transition to
`Expired`.

---

## 11. Student self-booking

`SEAT-FR-076` — A student **MUST** be able to view seat availability and book a seat for themselves
(`SEAT-PO-005`), where self-booking is enabled for the tenant (`SEAT-CFG-008`, default **disabled**).

> **Default disabled is deliberate and is not a reduction in scope.** The draft required the capability; it did not
> require it to be on for every library. Many libraries allocate at the desk. `LIB-16.2` requires a library that
> has changed nothing to be fully operable — and staff assignment (§9) is that path. The feature is fully specified
> and fully available; a tenant switch decides whether students see it.

`SEAT-FR-077` — A student **MUST** be able to book **only for themselves**. The `self` scope
(`MP-GBR-21`) is the only scope a student holds for booking.

`SEAT-FR-078` — A student **MUST NOT** see, and **MUST NOT** be able to book on behalf of, another student.

`SEAT-FR-079` — Student-facing availability **MUST** show whether a seat can be acquired, and **MUST NOT** disclose
which student holds an occupied or reserved seat (§28.2).

### 11.1 Seat booking dates

`SEAT-FR-080` — A booking **MUST** carry an explicit date or date range (`validFrom`, `validUntil`). A booking with
no date **MUST NOT** exist.

`SEAT-FR-081` — A booking **MUST NOT** extend beyond the student's published membership `validUntil`. A request
that would do so **MUST** be rejected, or truncated to `validUntil` where `SEAT-CFG-009` is set to `truncate`
(default: **reject**).

`SEAT-FR-082` — A booking **MUST NOT** start in the past.

`SEAT-FR-083` — A booking **MUST NOT** start more than `reservationWindow` days ahead, consumed from `BC-06`
through `E-05`. This module **MUST NOT** define its own advance-booking window.

`SEAT-FR-084` — Overlapping bookings by the same student **MUST** be evaluated against `seatQuota` per
`SEAT-BR-012`, and against `SEAT-INV-002`.

---

## 12. Booking vs Reservation vs Assignment — the seven questions answered

This section answers review area 2. Each of the seven questions is answered with a deterministic rule, not a
description.

### 12.1 The distinction, stated once

`SEAT-FR-085` — **Booking** is the *student-initiated act*. **Assignment** is the *staff-initiated act*.
**Reservation** is a *time-bounded hold*, which either act may produce. **Allocation** is the *held right to the
seat*. A booking is not a reservation and a reservation is not an allocation.

### 12.2 Q1 and Q2 — does booking create an assignment immediately, or a reservation first?

`SEAT-FR-086` — The outcome of a student booking **MUST** be determined by one tenant configurable,
`SEAT-CFG-010` **Booking mode**, whose value set is closed:

| Mode | Behaviour | Default |
|---|---|---|
| **`Direct`** | The booking creates an **`Active` allocation immediately**. No reservation exists. | — |
| **`HoldThenConfirm`** | The booking creates a **`Reservation`** first; it becomes an allocation on conversion (§12.3). | — |
| **`ApprovalRequired`** | The booking creates a **`Pending` reservation request**; staff approval creates the reservation (§15.4). | **default** |

`SEAT-BR-018` — Booking mode **MUST** be a single tenant-level value. The module **MUST NOT** allow two modes to
be simultaneously effective for one tenant, because the resulting behaviour would not be predictable from
configuration.

> **Why this is one configurable and not three features.** The source draft simultaneously required *"students can
> book a seat"*, *"reservations expire"*, and *"reservation requests need approval"* — three different answers to
> the same question, with no rule choosing between them. All three are preserved here as the three legal values of
> one deterministic switch. **Nothing is dropped; the ambiguity is.** `ApprovalRequired` is the default because it
> is the only mode that cannot surprise a library that has not thought about the setting.

`SEAT-FR-087` — Whichever mode is in force, §8's gates **MUST** be evaluated at the moment the **allocation** is
created, and again at conversion if a reservation intervened (`SEAT-FR-091`).

### 12.3 Q3 — when does `Reserved` become `Occupied`?

`SEAT-FR-088` — A reservation **MUST** convert to an allocation on the **first** of these triggers to occur:

| # | Trigger | Notes |
|---|---|---|
| T1 | The reservation's `startsAt` is reached **and** `SEAT-CFG-011` conversion mode is `OnStart` | Time-driven |
| T2 | The holder is checked in by `BC-03` (`E-08` `StudentCheckedIn`) **and** conversion mode is `OnCheckIn` | Presence-driven. **Default** |
| T3 | Staff explicitly confirm the reservation (`SEAT-PO-006`) | Always available in every mode |

`SEAT-FR-089` — Conversion mode `SEAT-CFG-011` is a closed set: `OnStart` · `OnCheckIn` (default) · `StaffOnly`.

`SEAT-FR-090` — Conversion **MUST** be idempotent. A second conversion trigger for an already-converted
reservation **MUST** return the existing allocation and **MUST NOT** create a second one.

`SEAT-FR-091` — Conversion **MUST** re-evaluate gates G6, G7, G8, G11 and G12 of §8. A reservation created while a
membership was valid **MUST NOT** convert after the membership became invalid. `MP-GBR-16` is evaluated at the
moment of seating, not at the moment of holding.

> **This is the answer to edge case 3** (*"membership expires between booking and use"*) and it follows from
> `MP-GBR-16` rather than from a new invention: a reservation is a hold, not a right to be seated.

### 12.4 Q4 — what happens on expiry?

`SEAT-FR-092` — Every reservation **MUST** carry an explicit `expiresAt`. A reservation without an expiry **MUST
NOT** exist.

`SEAT-FR-093` — On reaching `expiresAt` without conversion, the reservation **MUST** transition to `Expired`, the
seat **MUST** return to `Available` (derived — F4 clears), and a `seating.SeatReleased`-family record **MUST**
appear in the timeline with origin `ReservationExpired`.

`SEAT-FR-094` — Expiry **MUST NOT** create an allocation, **MUST NOT** charge anything (this module holds no
money), and **MUST NOT** penalise the student beyond the no-show counter of `SEAT-FR-096`.

`SEAT-FR-095` — Expiry **MUST** be evaluated deterministically by elapsed time and **MUST NOT** depend on a
background job having run. A read of a seat whose reservation `expiresAt` has passed **MUST** present the seat as
`Available` even if no sweeper has executed.

> **This removes a whole class of bug.** If expiry were only applied by a scheduled job, the seat's state would
> depend on infrastructure timing — `MM-NFR-014` says *"a rule that cannot be checked SHALL be treated as unmet."*
> Deriving expiry at read time makes it checkable.

`SEAT-FR-096` — Consecutive expiries without conversion **MUST** be counted per student. On reaching
`SEAT-CFG-012` (default **3**), student self-booking **MUST** be suspended for that student for
`SEAT-CFG-013` (default **7 days**). Staff assignment remains available throughout — a no-show student is never
denied a seat at the desk.

### 12.5 Q5 — can a reserved seat be assigned manually?

`SEAT-FR-097` — A seat holding an unexpired reservation **MUST NOT** be assigned to a **different** student
without the reservation first being explicitly cancelled (`SEAT-PO-007`). The cancellation **MUST** record actor
and reason, and **MUST** emit a notification fact.

`SEAT-FR-098` — Staff **MUST** be able to assign the reserved seat to the **reservation holder** at any time; this
is conversion trigger T3 and is not an override.

### 12.6 Q6 — can a student reserve an occupied seat?

`SEAT-FR-099` — A student **MUST NOT** be able to reserve or book a seat that holds an active allocation for an
**overlapping** time window. `SEAT-BR-011` and gate G15/G16 reject it.

`SEAT-FR-100` — A student **MAY** book a seat for a **non-overlapping future window** where the existing allocation
ends before the requested `validFrom`, subject to `SEAT-FR-083`'s advance window. This is not a conflict; the
windows do not overlap.

`SEAT-FR-101` — A waiting list **MUST NOT** be implemented in V1 (`SEAT-XC-005`). It is classified **V2** in §34.

`SEAT-XC-005` — **Waiting lists, queues for a specific seat, and automatic promotion when a seat frees** are out of
scope. A queue is a scheduling feature with its own fairness rules, expiry semantics and notification surface; none
of that was requested, and a half-built queue is worse than none. A student who wants a taken seat raises a
seat-change request (§10).

### 12.7 Q7 — can staff override a reservation?

`SEAT-FR-102` — Owner and Manager **MUST** be able to cancel any reservation (`SEAT-PO-007`). Reception **MUST**
be able to cancel a reservation only where `SEAT-CFG-014` grants it (default: **not granted**).

`SEAT-BR-019` — A staff cancellation of a reservation **MUST** record actor, timestamp and mandatory reason, and
**MUST** emit a notification fact naming the affected student. A silent cancellation **MUST NOT** be possible.

`SEAT-XC-006` — Overriding a **reservation** is permitted to authorised roles. Overriding **membership validity**
is permitted to **no one** (`SEAT-BR-014`, `SEAT-XC-004`). These two must never be conflated in a UI as one
"override" action.

---

## 13. The seat card

`SEAT-FR-103` — Selecting a seat **MUST** present a seat card showing: seat number · zone and floor · category ·
type (`Fixed`/`Flexible`) · derived `SeatState` · lock flag when set · maintenance detail when in maintenance ·
current holder (staff view only) · shift · allocation `validFrom`/`validUntil` · membership status and expiry ·
occupancy (present / not present) · available actions.

`SEAT-FR-104` — The holder's name, membership status and membership expiry on the card **MUST** be **composed at
read time** from `BC-01` and the `E-02` projection. They **MUST NOT** be stored on the seat or the allocation
(`SEAT-FR-010`, `SEAT-FR-025`).

`SEAT-FR-105` — Composed values **MUST** be labelled with the projection's as-of time and **MUST NOT** be presented
as authoritative, in the manner `PRD-004` `LMD-23` requires for the same composition.

`SEAT-FR-106` — Where a composed value is unavailable (the upstream projection is unreachable), the card **MUST**
render with the value marked unavailable and **MUST NOT** fail, block or show a stale value as current.

`SEAT-FR-107` — The actions offered on the card **MUST** be exactly those the actor is authorised to perform
(§28). An action the actor cannot perform **MUST NOT** be shown as disabled with an explanatory reason that
discloses another student's data.

---

## 14. The Attendance boundary — occupancy without duplicate ownership

This section answers review area 6. `BC-03` Attendance is a **separate bounded context** and `PRD-006` is its PRD.
Attendance **MUST NOT** move into Seat Management. But BC Map `E-08` says *"**Seating is the occupancy owner**,
Attendance is the trigger"* — so the two concepts must coexist precisely.

### 14.1 The split

`SEAT-FR-108` — The following split **MUST** hold exactly:

| Concept | Owner | This module's role |
|---|---|---|
| A punch (check-in / check-out) | **`BC-03`** | Consumes as an event. **Never records, edits or verifies one** |
| Verification evidence (GPS / WiFi / QR) | **`BC-03`** | None |
| `AttendanceDay`, attendance correction | **`BC-03`** | None |
| Attendance totals, percentages, streaks | **`BC-03`** / `BC-26` | None |
| **Whether a seat is currently physically in use** | **this module** | **Owns.** Derived from `E-08` |
| **Live occupancy count per zone / floor / branch** | **this module** | **Owns** |
| **Seat utilisation over the current operating day** | **this module** | Owns as an operational count (§25) |

`SEAT-BR-020` — This module **MUST NOT** create, store, modify, delete or verify an attendance record. It holds a
derived occupancy flag on the allocation, which is **not** an attendance record and **MUST NOT** be used as one, or
exported as one.

`SEAT-XC-007` — An attendance punch, attendance correction, attendance total or verification evidence **MUST NOT**
be stored in this module.

`SEAT-XC-008` — This module **MUST NOT** be the source for any attendance report, attendance percentage or
attendance dispute.

### 14.2 How occupancy is derived

`SEAT-FR-109` — On `attendance.StudentCheckedIn` (`E-08`), the module **MUST** mark the student's active allocation
as physically occupied, and **MUST** increment the live occupancy count for the seat's zone, floor and branch.

`SEAT-FR-110` — On `attendance.StudentCheckedOut` (`E-08`), the module **MUST** clear the physically-occupied flag
and decrement the live occupancy counts.

`SEAT-FR-111` — `E-08` handling **MUST** be **idempotent** by event identifier. A redelivered check-in **MUST NOT**
double-count occupancy. BC Map §9 requires idempotent consumers; `MP-GBR-18` requires the punch itself to be
idempotent upstream.

`SEAT-FR-112` — Where a check-in arrives for a student who holds **no** active allocation, the module **MUST**
record the check-in as unseated occupancy for branch-level counts and **MUST NOT** create an allocation, **MUST
NOT** auto-assign a seat, and **MUST NOT** reject the check-in.

> **`E-03`/`E-02` asymmetry, preserved.** BC Map line 309 and `MP-GBR-16` are explicit: *"Seating blocks; Attendance
> records and flags — a paying student is never locked out at the door."* If a check-in without a seat were
> rejected here, this module would be blocking entry, which is `BC-03`'s decision and which the architecture
> forbids. `MM-BR-007` requires the asymmetry be preserved.

`SEAT-FR-113` — Where a check-in arrives whose event `tenantId` cannot be resolved, the handler **MUST fail
loudly** and **MUST NOT** default to any tenant (`MP-GBR-07`).

`SEAT-FR-114` — Occupancy **MUST** be reset at the start of each operating day, using the operating-day definition
consumed from `BC-06`. This module **MUST NOT** define what a day is.

`SEAT-FR-115` — A stale or missed `E-08` event **MUST NOT** corrupt the allocation. Occupancy is an advisory,
recomputable flag; the allocation is the authoritative fact.

`SEAT-FR-116` — Live occupancy counts **MUST** be recomputable from the current allocation set and the current
`BC-03` open-session set. A count that cannot be recomputed **MUST NOT** be treated as authoritative.

### 14.3 Public exposure is out of scope

`SEAT-XC-009` — Per-seat identity, per-seat state and live occupancy **MUST NOT** be exposed publicly in V1.
Library PRD `LIB-7.3` permits an **aggregate** count only; `LIB-24.2`, `LIB-14B.13` and `ARCHITECTURE_RULINGS.md`
§6 defer **Public Live Occupancy to V2 pending a privacy review**, with the ruling *"must not be invented."*

`SEAT-FR-117` — This module **MAY** publish an aggregate seat capacity and a coarse availability indicator for the
public profile, in the shape `LIB-7.3` and `LIB-14B.12` already define. It **MUST NOT** publish a precise live
count or any per-seat fact.

---

## 15. Reservations

`SEAT-FR-118` — A `Reservation` **MUST** carry: reservation identifier · seat internal identifier ·
`StudentRecordId` · `tenantId` · `startsAt` · `expiresAt` · state · origin · created audit stamp.

`SEAT-FR-119` — Reservation state **MUST** be exactly one of the closed set: `Pending` · `Active` · `Converted` ·
`Expired` · `Cancelled` · `Rejected`.

`SEAT-FR-120` — Reservation duration **MUST** default to `SEAT-CFG-015` (default **30 minutes**) and **MUST NOT**
exceed the `reservationWindow` consumed from `BC-06` via `E-05`.

`SEAT-FR-121` — A student **MUST NOT** hold more than `SEAT-CFG-016` (default **1**) active reservations at a time.

`SEAT-FR-122` — A student **MUST** be able to cancel their own active reservation, which **MUST** return the seat to
`Available` immediately.

### 15.1 Overlap

`SEAT-BR-021` — Two reservations for the same seat with overlapping windows **MUST NOT** both exist
(`SEAT-INV-004`). The second **MUST** be rejected under gate G15.

`SEAT-FR-123` — A reservation **MUST NOT** overlap an existing active allocation for the same seat
(`SEAT-FR-099`).

`SEAT-FR-124` — The same student booking the **same seat twice** for overlapping windows **MUST** be rejected by
`SEAT-INV-005`, and where the second request carries the same idempotency key it **MUST** be treated as a retry
(§21.3), returning the first reservation rather than an error.

### 15.2 Auto-cancellation

`SEAT-FR-125` — An active reservation **MUST** be auto-cancelled, with the seat returned to `Available`, when any
of the following becomes true — each is a specific, testable condition, not a discretionary judgement:

| # | Condition | Notification fact emitted |
|---|---|---|
| A1 | `expiresAt` reached without conversion | yes |
| A2 | The holder's membership becomes invalid before conversion | yes |
| A3 | The holder's enrollment becomes `Suspended` or `Archived` | yes |
| A4 | The seat enters maintenance | yes |
| A5 | The holder cancels | no (the holder acted) |
| A6 | Staff cancel (`SEAT-FR-102`) | yes |

`SEAT-FR-126` — Auto-cancellation **MUST** record which condition triggered it. "Cancelled" without a cause
**MUST NOT** be a possible timeline entry.

### 15.3 Reservation approval

`SEAT-FR-127` — Where booking mode is `ApprovalRequired`, a student booking **MUST** create a `Pending`
reservation that **MUST NOT** block the seat for other students.

> **A pending request must not hold the seat.** Otherwise an unapproved request would give a student the same
> exclusivity as an approved one, and a library could be silently blocked by a queue of pending requests. The hold
> begins at approval.

`SEAT-FR-128` — Reception, Manager and Owner **MUST** be able to approve or reject a pending reservation
(`SEAT-PO-008`), with a mandatory reason on rejection.

`SEAT-FR-129` — Approval **MUST** re-evaluate §8 in full. If the seat is no longer acquirable, approval **MUST**
fail with the gate reason and the request **MUST** remain `Pending`.

`SEAT-FR-130` — A `Pending` reservation **MUST** expire after `SEAT-CFG-007` and **MUST NOT** remain pending
indefinitely.

---

## 16. Fixed and Flexible seating, and shift integration

This section answers review area 3.

### 16.1 The two allocation types

`SEAT-FR-131` — A seat **MUST** carry a type from the closed set `Fixed` | `Flexible`. An allocation **MUST**
inherit the seat's type at creation and **MUST** record it, so that a later change to the seat's type does not
rewrite history.

`SEAT-FR-132` — **`Fixed`**: the seat is held by one student for the whole allocation window. It **MUST NOT** be
acquired by another student within that window, including outside the holder's shift.

`SEAT-FR-133` — **`Flexible`**: the seat **MAY** be held by different students in **non-overlapping** windows.
Overlap is still forbidden by `SEAT-INV-001`: flexible means *shareable across time*, never *shareable at the same
time*.

> **This is the distinction the source draft left implicit,** and it is the difference between a working invariant
> and a double-booked seat. "Flexible" does not weaken `MP-GBR-17`; it only means the time window is narrower.

`SEAT-FR-134` — Changing a seat from `Fixed` to `Flexible` **MUST NOT** alter, shorten or split any existing
allocation. The change applies to **future** allocations only.

`SEAT-FR-135` — Changing a seat from `Flexible` to `Fixed` **MUST** be rejected where more than one active
allocation exists for the seat in overlapping-day windows, with a reason naming the conflicting allocations. The
operator **MUST** release the surplus allocations first.

> **This asymmetry is deliberate.** Fixed→Flexible is always safe: it relaxes a constraint. Flexible→Fixed
> tightens one, so it can be invalid. Silently truncating a student's allocation to satisfy a configuration change
> would violate `SEAT-BR-022`'s principle that a state change never silently destroys an allocation.

### 16.2 Shift integration

`SEAT-FR-136` — A shift is a named time window whose **definitions are owned by `BC-06`** (Library PRD `LIB-16.4`:
*"Shift Configuration | Shift definitions | `BC-06`; consumed by `BC-02`, `BC-03`"*). This module **MUST** consume
shift definitions and **MUST NOT** define, create, edit or delete a shift.

`SEAT-FR-137` — A `Flexible` allocation **MUST** be shift-bounded: its window **MUST** align to a shift consumed
from `BC-06`.

`SEAT-FR-138` — A `Fixed` allocation **MAY** be shift-bounded or all-day.

`SEAT-BR-022` — Two allocations for the same `Flexible` seat in **different, non-overlapping** shifts **MUST** be
permitted. Two allocations in **overlapping** shifts **MUST** be rejected under `SEAT-INV-001`.

`SEAT-FR-139` — Where a student's shift changes (a `BC-02` membership fact, since the plan carries the shift — BC
Map line 203 gives *"Monthly Night Shift"* as a `MembershipPlan` example), this module **MUST**:

1. keep the existing allocation intact;
2. evaluate whether the allocation's window still aligns to the student's new shift;
3. where it does not, flag the allocation as **shift-misaligned** and emit a notification fact;
4. **NOT** automatically release, truncate or move the allocation.

`SEAT-FR-140` — A shift-misaligned allocation **MUST** appear in a staff work queue (§22.4) so a human resolves it.

> **Why not auto-release.** Auto-releasing a seat because a plan changed shift would evict a student from a seat
> they are sitting in, on the strength of an eventually-consistent projection whose staleness BC Map §10 bounds at
> < 5s but does not eliminate. The same reasoning produced `MM-FR-025`. Flagging is deterministic and safe;
> auto-eviction is neither.

`SEAT-FR-141` — Where a shift definition is **deleted or edited** in `BC-06`, existing allocations **MUST** retain
the shift reference they recorded and **MUST NOT** become invalid retroactively. `LIB-10.6`'s and `MP-GBR-19`'s
principle — *"policy changes are versioned with `effectiveFrom` and never retroactive"* — applies.

---

## 17. Seat categories and eligibility

This section answers review area 4.

### 17.1 Categories

`SEAT-FR-142` — A seat **MUST** carry exactly one category. Categories **MUST** be modelled as **data, not code
branches**; adding a category **MUST NOT** require a code change or a migration (`LIB-11.2`'s rule for the
analogous zone case).

`SEAT-FR-143` — Default categories **MUST** be provided: `Normal` · `Premium` · `VIP`. A tenant **MAY** define
additional categories.

`SEAT-FR-144` — A category **MUST NOT** carry a price, a fee or any monetary amount. Pricing that varies by seat
class is a **membership plan** concern owned by `BC-02` (`LIB-11.4`, `LXC-7`). A plan **MAY** reference a category
by identifier.

`SEAT-FR-145` — A category **MUST NOT** be deleted while any seat references it. It **MUST** be deactivatable
instead, which suppresses its use for new seats without altering existing seats.

`SEAT-FR-146` — Changing a **seat's** category **MUST NOT** release, alter or invalidate an existing allocation on
that seat. The holder keeps the seat; the category applies to future acquisition.

> **Answering "what happens if the category changes" directly.** Re-categorising a seat under a sitting student and
> then evicting them would be a physical-world conflict of exactly the kind BC Map §10.1 says cannot be
> compensated. The eviction does not happen. Edge case 15 in §30.

### 17.2 Eligibility

`SEAT-FR-147` — Whether a student may occupy a seat of a given category **MUST** be decided by an **eligibility
evaluation** performed by this module at gate G13, using inputs it does not own:

| Input | Owner | Consumed via |
|---|---|---|
| Membership plan identifier and its permitted seat categories | `BC-02` | `E-02` projection |
| `seatQuota` | `BC-02` / `BC-21` | `E-02` projection |
| Seat rules | `BC-06` | `E-05` port |
| Seat category | **this module** | — |
| Zone descriptive attributes (e.g. premium indicator) | `BC-06` | read |

`SEAT-BR-023` — This module **MUST NOT** define which plan grants which category. That mapping is a `BC-02` plan
attribute. This module **evaluates** the rule; it does not **author** it.

> **Library PRD `LIB-11.5` states this from the other side:** *"whether a seat in a zone may be assigned to a given
> student is decided by `BC-04` Seating using rules from `BC-06`. This module MUST NOT implement assignment logic."*
> The division is: `BC-04` decides, others supply inputs.

`SEAT-FR-148` — Where the `E-02` projection does not carry a permitted-category list, the module **MUST** treat
every category as permitted **except** those a tenant has marked as restricted. It **MUST NOT** silently deny all
categories, which would make seating impossible for every student.

`SEAT-FR-149` — An eligibility denial **MUST** state the category and the reason, and **MUST NOT** disclose another
student's plan or data.

### 17.3 What happens when eligibility changes — the five named cases

`SEAT-FR-150` — Eligibility is evaluated **at acquisition and at conversion**, never re-evaluated continuously
against existing allocations. The following table is normative and complete for the five cases the review named:

| Case | Effect on an **existing** allocation | Effect on **new** acquisition | Notification fact |
|---|---|---|---|
| Student becomes **ineligible** for the category | **Retained.** Flagged `eligibility-review` (§22.4) | Denied at G13 | yes |
| **Membership expires** | **Retained until released.** Release timing is **`BC-04`'s decision**, deferred pending `Q-01` — see `SEAT-GAP-003` | Denied at G7 | yes |
| **Seat category changes** | **Retained** (`SEAT-FR-146`) | Evaluated against the new category | no |
| **Plan changes** (any direction) | **Retained.** Re-evaluated only at next acquisition | Evaluated against the new plan | no |
| **Premium → Normal** downgrade | **Retained.** Flagged `eligibility-review` | Denied for premium seats at G13 | yes |
| **Normal → Premium** upgrade | **Retained.** No flag — the student is now *more* eligible | Premium seats become acquirable | no |

`SEAT-BR-024` — An existing allocation **MUST NOT** be automatically released, truncated or moved because an
eligibility input changed. It **MUST** be flagged for human resolution.

> **This is the single most important rule in this section** and it is why the module does not need a background
> eviction engine. `Q-01` — *"does an expired membership release the seat immediately, at end-of-day, or after a
> grace period?"* — is **open** (BC Map §13, Master PRD line 673) and jointly owned by *"Architecture + `BC-04`
> owner"* per `MM-GAP-001`. This PRD is **written to be correct under any resolution**: retention plus flagging is
> valid whether the answer turns out to be immediate, end-of-day or 24-hour grace, because the *release action*
> becomes a policy-driven trigger over an already-flagged allocation rather than a redesign. `SEAT-GAP-003` records
> it. `MM-FR-112` states this module's obligation from `BC-02`'s side: *"seat reclamation after expiry MUST be
> `BC-04`'s decision."*

---

## 18. Membership integration — consume, never recreate

This section answers review area 5.

`SEAT-FR-151` — Membership validity **MUST** be consumed exclusively from the `E-02` `MembershipValidity`
projection, whose shape is fixed as `{studentRecordId, validUntil, seatQuota}` by BC Map `E-02` and `MM-FR-070`.

`SEAT-XC-010` — This module **MUST NOT** compute, derive, infer, cache-as-authoritative or override membership
validity. It **MUST NOT** store a plan, a term, a freeze window, a membership status or a `validUntil` as its own
field.

`SEAT-FR-152` — Where the projection is **unavailable**, acquisition **MUST fail closed** — the request is rejected
with an explicit "membership validity unavailable" reason. It **MUST NOT** proceed on an assumption of validity.

> **Fail-closed here, and why it does not contradict `Q-03`.** BC Map `Q-03` says entitlement gates are
> *"per-gate policy; hard paid features fail-closed, soft limits fail-open."* Seating is a hard paid feature —
> `MP-GBR-16` makes membership a precondition of seating, so failing open would seat an unpaid student.

`SEAT-FR-153` — Reading an existing allocation, a seat card, a layout or an occupancy count **MUST NOT** fail when
the projection is unavailable. Only **acquisition** fails closed. Existing state remains readable
(`SEAT-FR-106`).

`SEAT-FR-154` — Projection staleness of up to **5 seconds** is an accepted, bounded risk, exactly as BC Map §10
states for this operation: *"stale membership projection is an accepted, bounded risk (< 5s)."* This module **MUST
NOT** attempt to eliminate it with a synchronous call into `BC-02`.

`SEAT-FR-155` — On `membership.MembershipExpired` (`MM-EVT-005`), this module **MUST** flag every affected active
allocation for release per `SEAT-BR-024`, and **MUST** auto-cancel any unexpired reservation per A2.

`SEAT-FR-156` — On `membership.MembershipFrozen`, this module **MUST** hold the allocation — neither release nor
convert — and **MUST** deny new acquisition for that student. On `Unfrozen`, acquisition **MUST** resume with no
manual step.

> **BC Map §9 names the purpose of the freeze events as *"Proration + seat hold"*.** `PRD-005` records that
> Membership Freeze itself is **V2** (`MM-GAP-010` and PRD-005 §§ discussing EA line 728/731). This requirement is
> therefore written so that it is **inert until `BC-02` emits the event** — it adds no V1 surface of its own and
> costs nothing if freeze never fires in V1. Recorded as `SEAT-GAP-004`.

`SEAT-FR-157` — This module **MUST NOT** publish to `BC-02`, call `BC-02`'s command API, or attempt to extend,
renew, freeze or expire a membership.

`SEAT-XC-011` — A "renew membership" or "collect payment" affordance **MUST NOT** exist on any seat screen. It
**MAY** deep-link to the module that owns it.

---

## 19. Locking, maintenance, bulk operations

### 19.1 Seat locking

`SEAT-FR-158` — Owner and Manager **MUST** be able to lock and unlock a seat (`SEAT-PO-009`). Reception **MUST
NOT** be able to lock or unlock a seat.

`SEAT-FR-159` — A lock **MUST** record actor, timestamp and a mandatory reason.

`SEAT-BR-025` — A lock **MUST** suppress **new acquisition only**: assignment, booking, reservation,
auto-assignment, QR assignment, transfer-in and bulk reassignment-in are all blocked at gate G12.

`SEAT-FR-160` — A lock **MUST NOT** release, alter, shorten or invalidate an existing allocation. A locked occupied
seat stays occupied by its holder until released explicitly.

`SEAT-FR-161` — A lock **MUST NOT** prevent release or transfer-**out** of the existing allocation. Locking a seat
must never trap a student in it.

`SEAT-FR-162` — Owner **MUST** be able to override a lock for a single assignment (`SEAT-PO-010`); the override
**MUST** be recorded with actor and reason. Manager override is `SEAT-CFG-005`-governed. Reception **MUST NOT**
override a lock.

`SEAT-FR-163` — A locked seat **MUST** be visibly marked as locked to every staff role, with its reason
(`SEAT-FR-039`), and **MUST** be presented to students as unavailable **without** disclosing the lock reason.

### 19.2 Maintenance workflow

`SEAT-FR-164` — Owner and Manager **MUST** be able to place a seat into maintenance and take it out
(`SEAT-PO-011`). Reception **MUST** be able to **report** a maintenance need (`SEAT-PO-012`) but **MUST NOT** start
or end maintenance.

`SEAT-FR-165` — A maintenance record **MUST** carry: identifier · seat reference · reason (mandatory) · reported-by ·
started-by · `startedAt` · expected end (optional) · `endedAt` (nullable) · ended-by · resolution note.

`SEAT-FR-166` — A maintenance report by Reception **MUST** create a `Reported` record that does **not** change the
seat's derived state. Only a `Started` record sets F2.

> **Two states, because a report is not a decision.** If a report immediately took a seat out of service, any staff
> member could remove capacity without authority. The report is visible in the work queue; a Manager or Owner acts.

`SEAT-BR-026` — Starting maintenance **MUST NOT** silently destroy an existing allocation. The allocation **MUST**
be preserved and the seat **MUST** present as `Maintenance` (F2 outranks F5 in `SEAT-FR-037`). On maintenance end,
the surviving allocation **MUST** be reinstated as the visible state.

`SEAT-FR-167` — Starting maintenance on a seat with an active allocation **MUST** require the actor to choose one of
exactly three explicit dispositions:

| Disposition | Effect |
|---|---|
| **Retain** | The allocation is preserved; the seat shows `Maintenance`. **Default** |
| **Relocate** | The module attempts a transfer (§9.3) to a comparable available seat; on failure, maintenance **MUST NOT** start |
| **Release** | The allocation is released with reason `maintenance`; requires confirmation |

`SEAT-FR-168` — A relocation performed under `Relocate` **MUST NOT** count against `maxTransfersPerDay`
(`SEAT-FR-067`).

`SEAT-BR-027` — Starting maintenance on a seat with an unexpired reservation **MUST** cancel that reservation
explicitly under condition A4, with a notification fact. It **MUST NOT** leave a reservation on a seat that cannot
be occupied.

`SEAT-FR-169` — A seat under maintenance **MUST** be excluded from availability counts, auto-assignment candidate
sets and student-facing availability, and **MUST** remain visible to staff with its maintenance reason.

`SEAT-FR-170` — Maintenance history **MUST** be retained per seat and **MUST** appear in the seat timeline (§23).

### 19.3 Bulk operations

`SEAT-FR-171` — Owner and Manager **MUST** be able to bulk-import seats from a file (`SEAT-PO-013`) and bulk-export
seats (`SEAT-PO-014`). Reception **MUST NOT** be able to do either.

`SEAT-FR-172` — A bulk import **MUST** be validated in full **before** any row is applied: zone existence, seat
number uniqueness within zone (`SEAT-BR-005`), category existence, type validity, row count against the entitlement
limit (`E-17`).

`SEAT-BR-028` — A bulk import **MUST** be **all-or-nothing**. Where any row fails validation, **no** row **MUST** be
applied, and the module **MUST** return a per-row error report identifying every failing row and its reason.

> **This answers edge case 20 (bulk partial failure) with a rule rather than a description.** A partially applied
> import leaves a tenant unable to tell what state their inventory is in — and a re-run then trips
> `SEAT-BR-005` on the rows that did apply. All-or-nothing plus a full error report is the only deterministic
> outcome. Where a tenant genuinely wants partial application they re-upload the corrected subset.

`SEAT-FR-173` — A bulk import **MUST** be idempotent by import key: re-submitting the same file with the same key
**MUST** return the original result and **MUST NOT** create duplicate seats.

`SEAT-FR-174` — A bulk import **MUST NOT** create, rename or delete a `Floor` or a `Zone` (`SEAT-FR-015`). Rows
referencing a non-existent container **MUST** fail validation.

`SEAT-FR-175` — A bulk export **MUST** contain only seat inventory and layout data. It **MUST NOT** contain student
names, contact details, membership data or attendance data (§28.3).

`SEAT-FR-176` — Owner and Manager **MUST** be able to bulk-reassign the allocations of a set of seats
(`SEAT-PO-015`) — for example when a zone is refurbished.

`SEAT-BR-029` — A bulk reassignment **MUST** evaluate §8 in full **per student, per destination seat**. It **MUST
NOT** apply a single authorisation or a single validity check to the batch.

`SEAT-FR-177` — A bulk reassignment **MUST** be all-or-nothing per `SEAT-BR-028`, and **MUST** produce one
transfer-history row per moved student (`SEAT-FR-065`).

`SEAT-FR-178` — Every bulk operation **MUST** emit a single audit event describing the operation, its actor, its
row count and its outcome, in addition to the per-entity events.

`SEAT-FR-179` — A bulk operation **MUST** be bounded by a sanity limit: no more than **2,000** rows per import and
**500** allocations per reassignment. Exceeding a bound **MUST** be rejected before validation begins, with the
bound stated in the error.

---

## 20. Automatic assignment and QR assignment

### 20.1 Automatic assignment

`SEAT-FR-180` — Staff **MUST** be able to request automatic assignment of a seat to a student
(`SEAT-PO-017`), which selects a candidate seat and then executes §9.1.

`SEAT-FR-181` — The candidate set **MUST** be exactly the seats for which every §8 gate passes for this student.
Auto-assignment **MUST NOT** bypass a single gate.

`SEAT-FR-182` — Candidate selection **MUST** be deterministic and **MUST** apply these criteria in exactly this
order:

| Order | Criterion |
|---|---|
| 1 | Seat category the student is eligible for, preferring the **lowest** eligible category so premium capacity is not consumed unnecessarily |
| 2 | The student's preferred zone, where they have recorded one |
| 3 | The zone of the student's most recent previous allocation |
| 4 | Lowest seat number within the chosen zone |

`SEAT-FR-183` — Where no candidate exists, auto-assignment **MUST** fail with a reason naming the most restrictive
gate that eliminated the last candidate. It **MUST NOT** return a seat the student cannot use and **MUST NOT**
create a reservation as a consolation.

`SEAT-FR-184` — Auto-assignment **MUST** record origin `AutoAssigned` and the criteria that selected the seat, so
that the choice is explainable after the fact.

`SEAT-FR-185` — Auto-assignment **MUST NOT** run unattended on a schedule in V1. It is a staff-invoked operation.
Unattended auto-allocation is classified **V2** in §34.

> **Determinism is the requirement here.** A selection algorithm that could return different seats for identical
> inputs cannot be tested, and `MM-NFR-014` says a rule that cannot be checked is treated as unmet. Stating the
> ordering makes `SEAT-AC-*` for auto-assignment writable.

### 20.2 QR-initiated assignment

`SEAT-FR-186` — A seat **MAY** carry a QR code that identifies the seat.

`SEAT-FR-187` — A seat QR code **MUST** encode the seat's internal identifier and its `tenantId`, and **MUST NOT**
encode a student identifier, a name, a session token or a credential.

`SEAT-FR-188` — Scanning a seat QR code **MUST** initiate an assignment request for the **authenticated scanning
actor's** context and **MUST** evaluate §8 in full. It **MUST NOT** assign a seat on the strength of the scan alone.

`SEAT-BR-030` — A QR scan **MUST NOT** authenticate anybody. Authentication is `BC-18`'s exclusively
(`MP-GBR-27`). An unauthenticated scan **MUST** result in an authentication prompt, never in an assignment.

`SEAT-FR-189` — A QR-initiated assignment by a **student** **MUST** be treated as a booking (§11) and is subject to
`SEAT-CFG-008` and the booking mode of `SEAT-CFG-010`.

`SEAT-FR-190` — A QR-initiated assignment by **staff** **MUST** require the student to be selected explicitly
(`SEAT-FR-056`).

`SEAT-FR-191` — Seat QR codes **MUST** be regenerable, and a regenerated code **MUST** invalidate the previous one.

`SEAT-XC-012` — A seat QR code **MUST NOT** be used as an attendance check-in mechanism by this module. QR
verification evidence for attendance belongs to `BC-03` (`SEAT-FR-108`). The two QR flows **MUST NOT** be merged.

> **This is a real risk, not a hypothetical one.** BC Map §8 lists `VerificationEvidence(GPS/WiFi/QR)` under
> `BC-03`. A single "scan the seat QR" button that both seated and marked attendance would put attendance
> recording inside `BC-04` and break `SEAT-XC-007`. A tenant **MAY** print both codes on one label; the flows stay
> separate.

---

## 21. Real-time sync, concurrency and idempotency

This section answers review area 10.

### 21.1 Real-time sync

`SEAT-FR-192` — Seat state changes **MUST** be reflected to connected staff surfaces in near-real-time, without a
manual refresh.

`SEAT-FR-193` — A real-time update **MUST** be tenant-scoped. A client **MUST NOT** receive an update for a seat
outside its resolved tenant context (`MP-GBR-06`).

`SEAT-FR-194` — Real-time delivery **MUST** be treated as an optimisation, never as the source of truth. A client
**MUST** be able to reconcile by re-reading, and a lost update **MUST NOT** produce a wrong decision — because
every acquisition re-evaluates §8 server-side under a lock (`SEAT-BR-015`).

`SEAT-FR-195` — Real-time payloads **MUST** carry only the seat's derived state, its lock flag and its occupancy
flag. They **MUST NOT** carry the holder's name or membership data (§28.2).

### 21.2 Concurrency

`SEAT-BR-031` — Two concurrent acquisition attempts on one seat **MUST** result in exactly one success and one
explicit, distinguishable failure. **A silent overwrite, a last-write-wins outcome, or two successful allocations
MUST NOT be possible.** Enforced by `SEAT-INV-001` plus `SEAT-BR-015`.

`SEAT-FR-196` — The losing attempt **MUST** receive a reason identifying the conflict, and its client **MUST** be
able to retry against fresh state.

`SEAT-FR-197` — Two concurrent transfers of the same student **MUST** result in exactly one success. The student's
allocation set **MUST NOT** be left inconsistent.

`SEAT-FR-198` — Two concurrent bookings by the same student for different seats **MUST** be evaluated against
`seatQuota` under a lock on the **student's** allocation set, so the quota cannot be exceeded by racing.

> **Two locks, not one, and this is easy to get wrong.** `SEAT-INV-001` needs a lock on the *seat*.
> `SEAT-INV-002` needs a lock on the *student's allocation set*. A build that locks only the seat allows one
> student to win two seats concurrently and exceed `seatQuota`.

`SEAT-FR-199` — Lock acquisition **MUST** have a bounded timeout, and a timeout **MUST** be reported as a retryable
failure, never as a success and never as a validity failure.

`SEAT-FR-200` — A concurrent maintenance-start and acquisition on one seat **MUST** resolve to exactly one
outcome; where maintenance wins, the acquisition **MUST** fail at G11.

### 21.3 Idempotency

`SEAT-FR-201` — Every state-changing operation **MUST** accept an idempotency key supplied by the caller.

`SEAT-BR-032` — A repeat request bearing an idempotency key already applied **MUST** return the **original
result** and **MUST NOT** apply the operation a second time. This is gate G3, evaluated before any mutation.

`SEAT-FR-202` — Idempotency keys **MUST** be scoped per tenant and per operation, and **MUST** be retained at least
**24 hours** — long enough to cover client retry behaviour. This retention is fixed, not configurable.

`SEAT-FR-203` — A network retry that reaches the server twice **MUST** produce exactly one allocation, one history
row, one audit event and one notification fact. **Duplicate history is a defect, not a cosmetic issue.**

`SEAT-FR-204` — A duplicate request submitted **without** an idempotency key **MUST** be rejected by the invariants
rather than accepted: `SEAT-INV-001` rejects the second allocation, `SEAT-INV-005` rejects the second reservation.
Absence of a key **MUST NOT** be a path to duplicate state.

`SEAT-FR-205` — `E-08` event handling **MUST** be idempotent by event identifier (`SEAT-FR-111`), and event
consumption **MUST** be idempotent for every subscribed event, per BC Map §9.

`SEAT-XC-013` — A "retry" that creates a second allocation, a second reservation or a second transfer row **MUST
NOT** be possible.

---

## 22. Domain events and work queues

### 22.1 The closed event set

`SEAT-FR-206` — This module's published domain events are **exactly** the following, fixed by BC Map §9. The set is
**closed**; adding an event requires an ADR.

| ID | Event | Emitted when | Consumers (BC Map §9) |
|---|---|---|---|
| `SEAT-EVT-001` | `seating.SeatAssigned` | An allocation becomes `Active`, from any origin | `BC-26`, `BC-24`, `BC-22` |
| `SEAT-EVT-002` | `seating.SeatReleased` | An allocation becomes `Released`, from any cause | `BC-26`, `BC-24`, `BC-22` |
| `SEAT-EVT-003` | `seating.SeatTransferred` | A transfer completes | `BC-26`, `BC-24`, `BC-22` |
| `SEAT-EVT-004` | `seating.OccupancyThresholdCrossed` | Live occupancy crosses a configured threshold | `BC-22`, `BC-26` |

`SEAT-FR-207` — Event names **MUST** follow BC Map §9's binding convention `<Context>.<Aggregate><PastTenseVerb>`.
An imperative name such as `SendSeatReminder` is a **command**, belongs to `BC-28` Workflow, and **MUST NOT** enter
the event bus as a domain event.

`SEAT-FR-208` — Every event **MUST** carry `tenantId`. A consumer that processes one without establishing tenant
context **MUST** fail loudly (`MP-GBR-07`).

`SEAT-FR-209` — Every event payload **MUST** carry `StudentRecordId` where a student is involved, and **MUST NOT**
carry a name, a contact detail or a `PersonId` (`MP-GBR-03`: *"`StudentRecordId` never leaves its tenant"* — the
event stays tenant-scoped, and no global context is a consumer).

`SEAT-FR-210` — Reservation creation, reservation expiry, lock, unlock, maintenance start and maintenance end
**MUST NOT** be published as new domain event types. They are recorded in the timeline (§23) and audit (§24), and
where a person must be told, they are emitted as notification facts (§24.2).

> **Why the event set stays at four.** BC Map §9 names exactly these four for `BC-04`, and line 292's principle —
> *"if an edge is not in this table, it does not exist"* — extends to the event surface, which §9 calls the seed of
> the Event Catalog with *"names, producers and consumers fixed here."* `PRD-005` set the same precedent by closing
> its event register at seven (`MM-BR-035`) rather than adding convenient ones. Internal facts do not need to be
> platform events to be recorded.

### 22.2 Threshold alerting

`SEAT-FR-211` — `SEAT-EVT-004` **MUST** be emitted when live occupancy for a branch, floor or zone crosses a
configured threshold, in either direction, and **MUST NOT** be emitted repeatedly while the value stays on one side
of it.

`SEAT-FR-212` — Threshold values are tenant configuration. Where none is configured, the module **MUST** default to
**90%** of active seat capacity and **MUST** remain operable.

### 22.3 Consumption

`SEAT-FR-213` — This module **MUST** subscribe to: `attendance.StudentCheckedIn` · `attendance.StudentCheckedOut` ·
`membership.MembershipCreated` · `membership.MembershipExpired` · `membership.MembershipFrozen` ·
`membership.MembershipUnfrozen` · `enrollment.StudentStatusChanged` · `policy.BranchPolicyChanged`.

`SEAT-FR-214` — Every subscription **MUST** be idempotent (`SEAT-FR-205`) and **MUST** tolerate out-of-order
delivery: an event that contradicts newer state **MUST** be discarded, not applied.

`SEAT-FR-215` — On `policy.BranchPolicyChanged`, the module **MUST** re-read `SeatRules` via `E-05` and **MUST NOT**
apply the new rules retroactively to allocations already created (`MP-GBR-19`).

### 22.4 Work queues

`SEAT-FR-216` — The module **MUST** maintain staff-visible work queues, each of which is a **read model over
existing state**, not a new aggregate:

| Queue | Contains | Created by |
|---|---|---|
| Eligibility review | Allocations flagged by `SEAT-BR-024` | membership / plan / category change |
| Shift misalignment | Allocations flagged by `SEAT-FR-139` | shift change |
| Maintenance reports | `Reported` maintenance records awaiting a decision | `SEAT-FR-166` |
| Pending requests | `Pending` seat-change and reservation requests | §§10, 15.3 |
| Expiry-flagged | Allocations whose membership has expired, awaiting `Q-01` policy | `SEAT-FR-155` |

`SEAT-FR-217` — A work queue **MUST NOT** perform an automatic action on its contents. It exists so a human acts.

## 23. History — five different things with five different owners

The source draft asked for a *seat timeline*, a *transfer history* and an *audit log* as three separate features,
and separately for *assignment history* and *reservation expiry records*. Reviewed together they are **five
distinct concerns**, only four of which belong to this module, and only three of which are stored here.

### 23.1 The five kinds, distinguished

| Kind | What it answers | Owner | Storage |
|---|---|---|---|
| **Allocation history** | *"Who has held this seat, and when?"* | **`BC-04`** | Stored here — the retained `SeatAllocation` records themselves |
| **Transfer history** | *"Which seat did this student move from, and to?"* | **`BC-04`** | **Derived** by walking allocation linkage — **not** a second log |
| **Reservation history** | *"Who reserved this seat, and how did the reservation end?"* | **`BC-04`** | Stored here — the retained `Reservation` records |
| **Seat timeline** | *"What happened to this seat, in order, across all five facts?"* | **`BC-04`** | **Derived read model** — a projection, never a system of record |
| **Audit log** | *"Who performed which privileged operation, provably and immutably?"* | **`BC-24` Audit Trail** | **Not stored here** — emitted via `E-20` |

`SEAT-BR-033` — These five **MUST NOT** be collapsed into one store. A change to a seat produces **at most one**
record of each applicable kind, and each kind has exactly one writer. A fact recorded only in the timeline is a
defect, because the timeline is rebuildable and therefore not evidence.

### 23.2 Allocation history

`SEAT-FR-218` — A `SeatAllocation` in state `Released` **MUST** be retained. The module **MUST NOT** provide any
operation that deletes an allocation record.

`SEAT-INV-008` — A `Released` allocation **MUST** be immutable. No field of it may be updated after release, with
the single exception of the transfer-successor linkage written atomically as part of the transfer itself
(`SEAT-FR-220`).

`SEAT-FR-219` — Allocation history is the **system of record** for *who sat where and when* inside this module.
Reports, timelines and analytics **MUST** derive from it, and **MUST NOT** derive from the audit trail.

`SEAT-BR-034` — A released allocation **MUST** retain the seat's **display number as it was at the moment of
release**, in addition to the seat's immutable internal identifier. §5 permits a seat to be renumbered; without a
recorded number-at-the-time, renumbering a seat silently rewrites every historical record that mentions it.

`SEAT-FR-220` — A transfer (§9.3) **MUST** write, atomically with the release and the new allocation, a
bidirectional linkage: the released allocation records the successor allocation identifier and the new allocation
records the predecessor allocation identifier.

`SEAT-FR-221` — Transfer history **MUST** be produced by walking that linkage. The module **MUST NOT** maintain a
separate transfer log, because two records of the same fact can disagree and there is then no rule for which wins.

`SEAT-FR-222` — The transfer chain **MUST NOT** be breakable by any later operation, including layout edit, seat
renumber, zone reassignment, category change and seat deactivation.

`SEAT-FR-223` — Where an allocation ended for a reason other than transfer, the released allocation **MUST** carry
a release reason from this closed set: `StaffReleased` · `StudentReleased` · `Transferred` · `WindowElapsed` ·
`MembershipEnded` · `StudentStatusChanged` · `MaintenanceRelocation` · `BulkReassigned` · `SeatDecommissioned`.

`SEAT-FR-224` — A release **MUST NOT** be recorded without a reason. Where an actor-supplied reason is required by
§9, the free-text reason is stored **in addition to**, never instead of, the closed-set code.

### 23.3 Reservation history

`SEAT-FR-225` — A `Reservation` that has reached a terminal state **MUST** be retained with its terminal state, its
terminal reason from the closed set of §15.4, and the identifier of the allocation it converted into where
`SEAT-FR-091`'s conversion occurred.

`SEAT-FR-226` — Reservation history **MUST** record the **derived** expiry outcome (§12, `SEAT-FR-095`) when the
reservation is first observed as expired, so that the record does not depend on when a reader looked.

### 23.4 The seat timeline

`SEAT-FR-227` — The module **MUST** provide, for a single seat, a chronologically ordered timeline composed from
the five independent facts of §6: allocation events, reservation events, lock events, maintenance events and
occupancy events.

`SEAT-FR-228` — The timeline **MUST** be fully rebuildable from data the module already stores. It **MUST NOT** be
the sole record of any fact, and the module **MUST NOT** write to the timeline anything that does not exist in an
underlying record.

`SEAT-FR-229` — Timeline entries **MUST** be ordered by the recorded time of the underlying fact, not by insertion
order, and entries with an identical timestamp **MUST** be ordered by a deterministic tiebreak so that two readers
see the same sequence.

`SEAT-FR-230` — The module **MUST** provide a student-facing view of the same data restricted to the requesting
student's own allocations and reservations, resolved under the `self` scope (§28). A student **MUST NOT** see any
other student's entry in a seat's timeline (§28.2).

`SEAT-FR-231` — A layout version (§4) **MUST** be retained for as long as any allocation whose window overlaps that
version's effective period is retained, so a historical allocation can be rendered against the layout that was in
effect. This is the `SeatLayout` versioning requirement of §4 stated as a retention obligation.

### 23.5 Audit — emitted, not owned

`SEAT-FR-232` — The module **MUST NOT** implement its own immutable audit store. `BC-24` Audit Trail owns
*"the immutable append-only record of who did what"* (BC Map §4) and its `AuditEntry` aggregate is
*"append-only, no update or delete path exists in code"* (BC Map §8).

`SEAT-FR-233` — Audit facts **MUST** be emitted over `E-20` — *"event (fire-and-forget, outbox-backed); domain never
calls audit synchronously."* A failure to record audit **MUST NOT** fail or roll back a seat operation, and the
outbox **MUST** guarantee eventual delivery.

`SEAT-FR-234` — Every operation in the closed protected-operation list of §28 **MUST** emit exactly one audit fact
carrying: `tenantId` · actor identifier and role · operation identifier (`SEAT-PO-n`) · target seat and/or
allocation identifier · timestamp · outcome (permitted / denied) · the changed fields with before and after values
where the operation mutates state · the reason code and free text where §23.2 requires one.

`SEAT-FR-235` — An audit fact **MUST NOT** carry a student name, contact detail, `PersonId`, or any membership or
financial value. It carries `StudentRecordId` only (`SEAT-FR-047`, `MP-GBR-03`).

`SEAT-FR-236` — A **denied** protected operation **MUST** be audited (`SEAT-FR-234`'s outcome field) even though the
denial is presented to the caller non-disclosingly (§28.4).

`SEAT-FR-237` — The module **MUST NOT** read `BC-24`'s store in order to render any of its own screens, reports,
timelines or histories. A read dependency on audit would make audit load-bearing for operations, which `E-20`'s
fire-and-forget direction forbids.

`SEAT-XC-014` — No operation to edit or delete an allocation record, a reservation record, a maintenance record, a
timeline entry or an audit fact **MUST** exist, for any role including Owner.

`SEAT-XC-015` — Audit retention, legal hold, purge, export and tamper-evidence are **out of scope**. `BC-24` owns
them. The module **MUST NOT** define a retention period for audit facts, and **MUST NOT** define its own retention
period for allocation history — platform data retention governs.

> **Why this section exists in this shape.** The draft's audit-log requirement, taken literally, would have put an
> immutable who-did-what store inside `BC-04`, duplicating `BC-24` and creating two sources of truth for privileged
> actions — exactly the *"duplicate platform audit storage"* the review instruction prohibits. Nothing was removed:
> every audit capability the draft asked for is still required, and `SEAT-FR-234` specifies the payload precisely
> enough to be tested. What changed is **where the bytes live**.

---

## 24. Notifications — facts only

`SEAT-FR-238` — The module **MUST NOT** implement message dispatch. `BC-22` Notification Delivery owns *"channel
selection, templates, deduplication, quiet hours, delivery guarantees, consent/unsubscribe"* (BC Map §4), reached
over `E-23`, whose direction is *"domain emits **facts**, never 'send an SMS'."*

`SEAT-XC-016` — SMS, push, email, in-app inbox, WhatsApp, template authoring, template variables, localisation of
messages, quiet-hours windows, send-rate limits, retry policy, deduplication windows, consent capture and
unsubscribe handling are **out of scope**.

`SEAT-XC-017` — Delivery state **MUST NOT** be stored or displayed by this module. *"Reminder sent"*, *"SMS
delivered"* and *"notification failed"* **MUST NOT** appear on the seat card, the seat timeline or any seat report.
A staff member who needs delivery evidence uses `BC-22`'s surface.

`SEAT-BR-035` — The module **MUST NOT** emit a command-shaped event. `SeatReminderRequested`, `NotifyStudent` and
`SendSeatExpiryEmail` are all defects. Only the four facts of §22 leave this module.

### 24.1 Which notifiable facts exist, and what carries them

`SEAT-FR-239` — Notification-relevant facts **MUST** be carried as follows, with no additional event type:

| Fact | Carrier | Notes |
|---|---|---|
| A seat was assigned to a student | `SEAT-EVT-001` `seating.SeatAssigned` | BC Map §9 routes it to `BC-22` |
| A seat was released | `SEAT-EVT-002` `seating.SeatReleased` | |
| A student was moved to a different seat | `SEAT-EVT-003` `seating.SeatTransferred` | |
| Occupancy crossed a configured threshold | `SEAT-EVT-004` `seating.OccupancyThresholdCrossed` | BC Map §9: *"capacity alerting"* |
| A reservation is approaching expiry | **No event in V1** — work queue (§22.4) | Proactive expiry reminders classified **V2** in §34 |
| A seat-change request is awaiting a decision | **No event in V1** — work queue | |
| Maintenance was reported | **No event in V1** — work queue | |
| An allocation was flagged for eligibility or shift review | **No event in V1** — work queue | |

`SEAT-FR-240` — Where a fact has no event carrier in V1, the module **MUST** surface it in the corresponding staff
work queue of §22.4. It **MUST NOT** be silently dropped, and a new event type **MUST NOT** be invented to carry it
(`SEAT-FR-210`; BC Map §7: *"if an edge is not in this table, it does not exist and adding it requires an ADR"*).

`SEAT-FR-241` — The occupancy threshold that triggers `SEAT-EVT-004` **MUST** be configurable
(`SEAT-CFG-017`, owner `BC-06` via `E-05`, default **90%** of the branch's active seat count). Where the threshold
is unset, no threshold event is emitted; the module **MUST NOT** substitute a hard-coded value.

`SEAT-FR-242` — `SEAT-EVT-004` **MUST** be emitted on a **crossing**, not on every occupancy change while above the
threshold, so that a busy branch does not produce one event per check-in. Re-crossing downward re-arms it.

`SEAT-FR-243` — Whether a student, a parent or a staff member is notified about any of these facts, and by which
channel, is decided entirely by `BC-22` and by notification preferences this module does not read. The module
**MUST NOT** carry a per-student *"notify on seat change"* preference.

> **Preserving the draft.** The draft's notification requirements — student notified on assignment, on transfer, on
> reservation expiry; staff notified on capacity — are all preserved. Three of the four already have an event that
> BC Map §9 routes to `BC-22`. The fourth, reservation-expiry reminders, has no `BC-04` event and cannot be given
> one without an ADR, so it is carried by a work queue in V1 and classified V2 in §34. This is a scoping change, not
> a removal.

---
## 25. Operational metrics — counts, not analytics

The source draft asked for *"seat occupancy analytics"*, *"utilisation reports"* and *"peak-hour analysis"*. Two of
those three belong to `BC-26` Analytics Read Model, which owns *"the metric/semantic layer, read-model store,
projections, reports, exports"* (BC Map §4) and whose `Projection` aggregate is *"fully rebuildable from the event
log; no projection is a system of record"* (BC Map §8). What belongs here is the **live operational count**, because
BC Map `E-08` makes this module *"the occupancy owner."*

### 25.1 The dividing line

`SEAT-BR-036` — The boundary is **time**, not presentation. A figure computed from **current state** is an
operational metric and belongs here. A figure computed by **aggregating over a period**, comparing periods, or
retaining a series is analytics and belongs to `BC-26`.

`SEAT-FR-244` — The module **MUST** provide these operational metrics, each computed from current state at read time
and each scoped to a tenant and a branch, and optionally to a floor, a zone, a shift or a seat category:

| Metric | Definition |
|---|---|
| Total seats | Count of seats that exist |
| Active seats | Total seats minus deactivated seats |
| Assignable seats | Active seats minus seats under `Maintenance` and minus locked seats |
| Allocated seats | Seats with an `Active` allocation whose window contains now |
| Unallocated seats | Assignable seats minus allocated seats |
| Reserved seats | Seats with an unexpired `Reservation` |
| Occupied seats | Seats whose occupancy fact (F5, §6) is currently *present* |
| Under maintenance | Seats with an open maintenance record |
| Locked seats | Seats with an active lock |
| Live occupancy rate | Occupied seats ÷ active seats, expressed as a percentage |
| Allocation rate | Allocated seats ÷ active seats, expressed as a percentage |

`SEAT-FR-245` — **Allocation rate and occupancy rate MUST be presented as two distinct figures and MUST NOT be
labelled interchangeably.** A seat allocated to an absent student is allocated but not occupied. Conflating them
produces a number that is wrong in one of the two senses no matter how it is read (§2, §14).

`SEAT-FR-246` — Every operational metric **MUST** be accompanied by its as-of time. Where any input is a projection
(membership validity, attendance-derived occupancy), the figure **MUST** be labelled with the projection's as-of
time, per `LMD-23`'s precedent.

`SEAT-FR-247` — Operational metrics **MUST** be derivable by a single query over current state. The module **MUST
NOT** maintain a pre-aggregated counter as a system of record, because a counter can drift from the rows it counts
and there is then no rule for which is true.

### 25.2 What is explicitly not here

`SEAT-XC-018` — The following are **out of scope** and belong to `BC-26`: occupancy trends over time · peak-hour and
peak-day analysis · average occupancy duration · seat popularity ranking · month-over-month or year-over-year
comparison · retained time-series or snapshot history · cohort analysis · forecasting · dashboards composed of
multiple modules · scheduled report generation · report subscriptions · analytical CSV/PDF exports · a semantic or
metric definition layer.

`SEAT-XC-019` — The module **MUST NOT** define a metric that `BC-26` also defines. Where a figure is needed both
operationally and analytically, this module publishes the underlying facts (§22) and `BC-26` defines the metric.
Two definitions of *"utilisation"* in two modules is a defect, not a convenience.

`SEAT-FR-248` — Historical and analytical occupancy questions **MUST** be answerable, but by `BC-26` consuming
`SEAT-EVT-001`…`004` and the retained allocation history of §23.2 — not by this module growing a warehouse. BC Map
§9 already routes all four `BC-04` events to `BC-26`.

`SEAT-FR-249` — `OccupancySnapshot` (BC Map §8, an entity of this context) **MUST** be understood as the current
occupancy state of a branch, not as a retained series. Where a retained series is required, it is `BC-26`'s
projection built from this module's events.

> **Nothing was dropped.** The draft's *"live occupancy"*, *"occupancy analytics"* and *"utilisation"* requirements
> are all satisfied: live occupancy by `SEAT-FR-244`, analytics by `SEAT-FR-248` through the events this module
> already emits. What changed is that this module does not become a second reporting engine — the review
> instruction's *"Seat Management must not become an Analytics module."*

### 25.3 Public exposure

`SEAT-FR-250` — Per-seat identity, per-seat state and live per-seat occupancy **MUST NOT** be exposed publicly in
V1. `LIB-7.3` requires public seat capacity to be *"an aggregate count"*; the Library PRD states per-seat identity,
per-seat status and live occupancy *"MUST NOT be public in V1."*

`SEAT-XC-020` — **Public live occupancy is deferred to V2** by `ARCHITECTURE_RULINGS.md` §6, `LIB-24.2` and
`LIB-14B.13`, *"pending a privacy review."* It **MUST NOT** be invented here. A tenant-configurable
*"busy / moderate / quiet"* public indicator is **V2**, classified in §34.

---

## 26. Search and smart filters

### 26.1 What is searchable

`SEAT-FR-251` — The module **MUST** support finding a seat by: seat display number · zone · floor · seat category ·
derived `SeatState` (§6) · allocation type (`Fixed` | `Flexible`) · shift · lock state · open maintenance ·
allocated / unallocated.

`SEAT-FR-252` — The module **MUST** support finding a student's seat by `StudentRecordId`, by admission or enrolment
number where the caller is authorised to resolve one, and by student name.

`SEAT-FR-253` — Where search is by student **name**, the module **MUST** resolve the name through the authoritative
read surface of the owning context and **MUST NOT** store a student name on any seat, allocation or index of its
own (`SEAT-FR-047`, `SM-2.4`). This module holds `StudentRecordId`; the name is composed at read time (§13).

`SEAT-FR-254` — Search results **MUST** be confined to the caller's `tenantId` (§29) and further confined to the
seats and students the caller's role and scope permit (§28). A result the caller may not see **MUST** be absent, not
redacted, and the total count **MUST** reflect only the permitted set — a count that reveals hidden rows is a
disclosure (`MP-GBR-22`).

`SEAT-FR-255` — Search **MUST** be deterministic: identical query, identical state and identical caller **MUST**
yield an identically ordered result. Default ordering is floor, then zone, then a natural (not lexical) ordering of
seat display number, so that seat 2 precedes seat 10.

`SEAT-FR-256` — Search **MUST NOT** be the mechanism by which an unauthorised caller enumerates students. A search
by an exact identifier the caller is not permitted to resolve **MUST** return not-found, indistinguishable from a
genuine absence (§28.4).

### 26.2 Smart filters

`SEAT-FR-257` — The module **MUST** provide named saved filter presets. A preset is a stored set of filter
criteria — it **MUST NOT** carry an action, and applying a preset **MUST NOT** mutate any seat or allocation.

`SEAT-FR-258` — The following presets **MUST** be available, each defined as an exact predicate over state already
specified, so that each is testable:

| Preset | Predicate |
|---|---|
| Available now | `SeatState` = `Available` **and** not locked **and** no open maintenance |
| Unallocated | Active seat with no `Active` allocation whose window contains now |
| Allocated but absent | `Active` allocation contains now **and** occupancy fact is *absent* |
| Occupied without allocation | Occupancy fact is *present* **and** no `Active` allocation contains now (§14) |
| Expiring soon | `Active` allocation whose `validUntil` falls within `SEAT-CFG-018` (default **7** days) |
| Eligibility flagged | Allocation flagged by `SEAT-BR-024` |
| Shift misaligned | Allocation flagged by `SEAT-FR-139` |
| Membership expired | Allocation whose `E-02` projection shows expiry, awaiting `Q-01` policy (`SEAT-FR-155`) |
| Under maintenance | Open maintenance record in any state |
| Locked | Active lock, regardless of allocation |
| Reserved | Unexpired reservation |
| Never allocated | Active seat with no allocation record in its history |

`SEAT-FR-259` — A filter preset **MUST** be tenant-scoped and **MUST NOT** be shared across tenants, including
presets created by Platform Support.

`SEAT-FR-260` — Filter criteria **MUST** combine conjunctively (AND) in V1. Arbitrary boolean expression building is
**V2** (§34). This is a deliberate limit: a query language is a feature with its own surface, and the draft did not
ask for one.

`SEAT-FR-261` — A filter that would produce an unbounded result **MUST** be paginated, and pagination **MUST** be
stable under concurrent mutation to the extent that one row is not returned on two pages of a single traversal.

`SEAT-XC-021` — Full-text search, fuzzy matching, phonetic matching, relevance ranking and search-index
administration are **out of scope**. `BC-23` Search Indexing owns indexing, and `E-21` does not list `BC-04` as a
producer — so this module **MUST NOT** publish to the search index in V1, and **MUST NOT** be given an edge to it
without an ADR.

`SEAT-FR-262` — Seat search **MUST** therefore be served by this module's own queries over its own state. This is
adequate because a result set is bounded by a branch's seat count, which `LCFG-9` and `LCFG-10` bound at 50 floors
× 100 zones.

---
## 27. Configuration register

`SEAT-BR-037` — Every configurable in this module **MUST** have exactly one owner, exactly one default, and a
defined behaviour when unset. A configurable without a default is a defect, because `LIB-16.2` requires that
*"a library that has changed nothing MUST be fully operable."*

`SEAT-FR-263` — Configuration **MUST** be read through `BC-25` Configuration's typed accessors over `E-19` — *"typed
config accessors; no raw string lookups in domain code."* Where the owner column below names `BC-06`, the value
arrives instead over `E-05` as part of `SeatRules`, and this module **MUST NOT** read it from `BC-25` directly.

`SEAT-FR-264` — A change to any configurable **MUST NOT** apply retroactively to allocations, reservations or
requests already created (`MP-GBR-19`: *"policy changes versioned with `effectiveFrom`, never retroactive"*). An
allocation created under the old value remains valid under the old value until it ends.

`SEAT-FR-265` — Where a configurable is unset and the table below states a default, the default **MUST** apply. The
module **MUST NOT** treat an unset configurable as *unlimited*, *permitted* or *disabled* except where the default
column says so explicitly.

### 27.1 The register

| ID | Configurable | Owner | Default | Value domain | Defined at |
|---|---|---|---|---|---|
| `SEAT-CFG-001` | Tenant label for `Zone` | `BC-25` | `"Zone"` | Non-empty string, presentation only | §4, `SEAT-FR-014` |
| `SEAT-CFG-002` | Effective `seatQuota` when the `E-02` projection omits it | `BC-25` | **1** | Positive integer | §7.2, `SEAT-FR-049` |
| `SEAT-CFG-003` | Whether `EnrollmentStatus` `Inactive` blocks acquisition | `BC-25` | **blocks** | `blocks` \| `permits` | §8, `SEAT-BR-013` |
| `SEAT-CFG-004` | Release reason list (free text is always permitted as well) | `BC-25` | Empty list | List of strings | §9.2, `SEAT-FR-060` |
| `SEAT-CFG-005` | **Override grant** — which roles beyond Owner may override a bounded staff limit: the transfer-per-day limit (`SEAT-FR-066`) and a seat lock (`SEAT-FR-162`) | `BC-25` | **Owner only** | Subset of {Manager} added to Owner | §9.3, §19.1 |
| `SEAT-CFG-006` | Maximum concurrent `Pending` seat-change requests per student | `BC-25` | **1** | Positive integer | §10, `SEAT-FR-074` |
| `SEAT-CFG-007` | Decision deadline after which a `Pending` seat-change request or `Pending` reservation expires | `BC-25` | **7 days** | Duration, 1 day … 90 days | §10 `SEAT-FR-075`; §15.4 `SEAT-FR-130` |
| `SEAT-CFG-008` | Student self-booking enabled | `BC-25` | **disabled** | Boolean | §11, `SEAT-FR-076` |
| `SEAT-CFG-009` | Behaviour when a requested window exceeds membership `validUntil` | `BC-25` | **`reject`** | `reject` \| `truncate` | §11.1, `SEAT-FR-081` |
| `SEAT-CFG-010` | Booking mode | `BC-25` | **`ApprovalRequired`** | `Direct` \| `HoldThenConfirm` \| `ApprovalRequired` | §12.2, `SEAT-FR-086` |
| `SEAT-CFG-011` | Reservation → allocation conversion trigger | `BC-25` | **`OnCheckIn`** | `OnStart` \| `OnCheckIn` \| `StaffOnly` | §12.3, `SEAT-FR-089` |
| `SEAT-CFG-012` | Consecutive no-show count that suspends self-booking | `BC-25` | **3** | Positive integer | §12.4, `SEAT-FR-096` |
| `SEAT-CFG-013` | Self-booking suspension duration once `SEAT-CFG-012` is reached | `BC-25` | **7 days** | Duration, 1 day … 365 days | §12.4, `SEAT-FR-096` |
| `SEAT-CFG-014` | Whether **Reception** may cancel another student's reservation | `BC-25` | **not granted** | Boolean | §12.7, `SEAT-FR-102` |
| `SEAT-CFG-015` | Default reservation hold duration | `BC-25` | **30 minutes** | Duration, 5 minutes … `reservationWindow` | §15, `SEAT-FR-120` |
| `SEAT-CFG-016` | Maximum concurrent active reservations per student | `BC-25` | **1** | Positive integer | §15, `SEAT-FR-121` |
| `SEAT-CFG-017` | Occupancy percentage that emits `SEAT-EVT-004` | **`BC-06`** via `E-05` | **90%** | Integer 1–100, or unset | §24.1, `SEAT-FR-241` |
| `SEAT-CFG-018` | *Expiring soon* filter horizon | `BC-25` | **7 days** | Duration, 1 day … 90 days | §26.2, `SEAT-FR-258` |

### 27.2 Values owned by `BC-06`, consumed not configured

`SEAT-FR-266` — The following are **not** this module's configurables. They arrive over `E-05` as `SeatRules` and
`E-05` is a **Conformist** edge: this module conforms and **MUST NOT** define its own copy, translate the value,
cache it indefinitely, or offer a local override.

| Value | Source | Used by |
|---|---|---|
| `maxTransfersPerDay` | `BC-06` via `E-05` — named in the BC Map contract | §9.3, `SEAT-BR-017` |
| `reservationWindow` | `BC-06` via `E-05` — named in the BC Map contract | §15, upper bound on `SEAT-CFG-015` |
| Occupancy threshold (`SEAT-CFG-017`) | **Proposed** addition to `SeatRules` | §24.1, `SEAT-FR-241` |
| Floor and Zone records, and their active state | `BC-06` — `LIB-10.*`, `LIB-11.*` | §4, `SEAT-FR-015` |
| Shift definitions | `BC-06` — `LIB-16.4` | §16 |

`SEAT-FR-267` — The occupancy threshold is a **proposed** addition to the `E-05` contract. Because `E-05`'s payload
is fixed by the BC Map, that addition **MUST** be confirmed at Stage 3 before implementation; it is recorded as
`SEAT-GAP-005`. Until confirmed, no threshold is set and `SEAT-FR-241`'s unset behaviour applies — no event is
emitted, and no hard-coded value is substituted.

### 27.3 What configuration may never do

`SEAT-FR-301` — No configurable in this register **MUST** be able to disable an invariant of §7, a gate step of §8,
the membership requirement of `SEAT-BR-014`, the tenancy rules of §29, or an audit emission of §23.5. A configurable
that can switch off a `MUST` is a defect.

`SEAT-XC-022` — Per-seat, per-student and per-role configuration overrides are **out of scope**. Every configurable
above is tenant-scoped, or branch-scoped where `BC-06` owns it. Per-seat policy is **V3** (§34).

---

## 28. Role permissions, protected operations and privacy

### 28.1 The authorisation model is consumed, not invented

`SEAT-FR-268` — This module **MUST NOT** define an authorisation framework. It consumes the platform model already
fixed by Master PRD `MP-GBR-20`…`23` and Authentication PRD v2.0: roles are `owner`, `manager`, `reception`,
`student`, `parent`, plus Platform Support and Platform Administrator; permissions are **scope-bearing**; and the
scope register is **closed** at `self`, `guardianOf` and `tenantWide`.

`SEAT-FR-269` — This module **MUST NOT** add a scope value. `MP-GBR-21` closes that register. A need for a
floor-scoped or zone-scoped grant would require an ADR and is recorded as `SEAT-GAP-006`; V1 grants are `tenantWide`
for staff roles and `self` for students.

`SEAT-FR-270` — Tenant role assignment, invitation and revocation are owned by Authentication (`AR-4`, `BR-2.9`
*"all invite-only"*). This module **MUST NOT** create, invite, elevate or revoke a role.

`SEAT-FR-271` — Every operation below **MUST** be authorised **before** the acquisition gate of §8 runs, so that an
unauthorised caller learns nothing about seat availability from the shape of the failure.

### 28.2 The closed protected-operation list

`SEAT-FR-272` — The following list of protected operations is **closed**. An operation not in this list does not
exist in V1, and adding one requires an amendment to this PRD.

Legend: **Y** permitted · **—** denied · **C** permitted only where the named configurable grants it.

`SEAT-PO-*` numbers below are those already cited by §§5–20. They are **not** renumbered here, because a register
number is a promise once written (`PRD_LIFECYCLE.md` §5 rule 5). The list is ordered by identifier, not by workflow.

Legend: **Y** permitted · **—** denied · **C** conditional on the named configurable · **G** requires an explicit
grant that the role alone does not imply.

| ID | Operation | Owner | Manager | Reception | Student | Defined at |
|---|---|---|---|---|---|---|
| `SEAT-PO-001` | Assign a seat to a student | Y | Y | Y | — | `SEAT-FR-055` |
| `SEAT-PO-002` | Release an allocation | Y | Y | Y | — | `SEAT-FR-059` |
| `SEAT-PO-003` | Transfer a student between seats | Y | Y | Y | — | `SEAT-FR-062` |
| `SEAT-PO-004` | Approve or reject a seat-change request | Y | Y | Y | — | `SEAT-FR-071` |
| `SEAT-PO-005` | Book a seat for oneself | — | — | — | C (`SEAT-CFG-008`) | `SEAT-FR-076` |
| `SEAT-PO-006` | Confirm a reservation into an allocation (trigger T3) | Y | Y | Y | — | `SEAT-FR-088` |
| `SEAT-PO-007` | Cancel another student's reservation | Y | Y | C (`SEAT-CFG-014`) | — | `SEAT-FR-102` |
| `SEAT-PO-008` | Approve or reject a `Pending` reservation | Y | Y | Y | — | `SEAT-FR-128` |
| `SEAT-PO-009` | Lock or unlock a seat | Y | Y | — | — | `SEAT-FR-158` |
| `SEAT-PO-010` | Override a lock for a single assignment | Y | C (`SEAT-CFG-005`) | — | — | `SEAT-FR-162` |
| `SEAT-PO-011` | Start or end maintenance | Y | Y | — | — | `SEAT-FR-164` |
| `SEAT-PO-012` | Report a maintenance need | Y | Y | Y | — | `SEAT-FR-164` |
| `SEAT-PO-013` | Bulk-import seats | Y | Y | — | — | `SEAT-FR-171` |
| `SEAT-PO-014` | Bulk-export seats | Y | Y | — | — | `SEAT-FR-171` |
| `SEAT-PO-015` | Bulk-reassign allocations | Y | Y | — | — | `SEAT-FR-176` |
| `SEAT-PO-016` | Create, edit or publish a layout version | Y | **G** | — | — | `SEAT-FR-028` |
| `SEAT-PO-017` | Run staff-invoked auto-assignment | Y | Y | Y | — | `SEAT-FR-180` |
| `SEAT-PO-018` | Create, renumber or deactivate a seat | Y | **G** | — | — | §5.2, same grant as `SEAT-PO-016` |
| `SEAT-PO-019` | Create, edit or deactivate a seat category | Y | — | — | — | §17.1 |
| `SEAT-PO-020` | Set or change a category's eligibility rule | Y | — | — | — | §17.2 |
| `SEAT-PO-021` | Change a module configurable owned by `BC-25` (§27) | Y | — | — | — | §27 |
| `SEAT-PO-022` | Raise a seat-change request | — | — | — | Y (`self`) | `SEAT-FR-068` |
| `SEAT-PO-023` | Cancel one's own `Pending` request or active reservation | — | — | — | Y (`self`) | `SEAT-FR-073`, `SEAT-FR-122` |
| `SEAT-PO-024` | View the seat map, seat card, timeline and operational metrics | Y | Y | Y | `self` only | §13, §23.4, §25 |

`SEAT-BR-038` — Reception **MUST** hold the day-to-day counter operations — `SEAT-PO-001` assign, `SEAT-PO-002`
release, `SEAT-PO-003` transfer, `SEAT-PO-004` decide requests, `SEAT-PO-006` confirm, `SEAT-PO-008` approve
reservations, `SEAT-PO-012` report maintenance, `SEAT-PO-017` auto-assign, `SEAT-PO-024` view — because Master PRD
§6 defines the role as covering *"student onboarding, attendance, memberships, seat allocation and support."*
Reception **MUST NOT** hold any **structural** operation: layout editing, seat creation or renumbering, category and
eligibility definition, bulk import, bulk export, bulk reassignment, locking, lock override, starting or ending
maintenance, or configuration.

`SEAT-BR-039` — Manager permissions **MUST** include *"attendance and seating oversight"* per Authentication PRD
`TR-2`, which is why Manager holds locking (`SEAT-PO-009`), maintenance control (`SEAT-PO-011`) and the bulk
operations (`SEAT-PO-013`…`015`). Manager **MUST NOT** hold the **tenant-shaping** operations, which remain
Owner-only: seat category definition (`SEAT-PO-019`), eligibility rules (`SEAT-PO-020`) and configuration
(`SEAT-PO-021`). Layout editing (`SEAT-PO-016`) and seat structure (`SEAT-PO-018`) sit between the two: Manager may
hold them, but only under an explicit grant that the role alone does not imply (`SEAT-FR-028`). Manager's lock
override (`SEAT-PO-010`) is conditional on `SEAT-CFG-005`.

`SEAT-BR-040` — No role, including Owner, **MUST** be able to override the membership requirement of gate step G7
(`SEAT-BR-014`), create a second active allocation on one seat in one window (`SEAT-INV-001`), edit or delete a
history record (`SEAT-XC-014`), or act outside its own tenant (§29).

`SEAT-FR-273` — Platform Support **MUST NOT** hold any operation in the list above by default. Where a support
action is unavoidable it is performed under the platform's existing time-boxed, audited support-access mechanism
owned by Authentication, and this module **MUST NOT** implement a bypass of its own.

`SEAT-FR-274` — **Parent/Guardian** holds no operation in the list above. A guardian **MAY** read the seat
information of a student they are guardian of, under the `guardianOf` scope, restricted to exactly what
`SEAT-FR-277` permits the student to see about themselves. Guardians **MUST NOT** book, request, release or cancel.

### 28.3 Privacy and non-disclosure

`SEAT-FR-275` — A student **MUST NOT** be able to learn which student occupies or is allocated to any seat other
than their own. The seat map presented to a student shows, per seat: the seat number, its derived assignability, its
category, and whether it is their own seat. It **MUST NOT** show another student's identifier, name, initials,
photograph, membership state, shift, attendance state or occupancy state.

`SEAT-FR-276` — Occupancy at per-seat granularity **MUST NOT** be visible to a student for any seat other than their
own, because per-seat occupancy discloses another person's physical presence in real time. Aggregate counts (§25)
**MAY** be shown to a student where the tenant enables it, since they identify no one.

`SEAT-FR-277` — A student **MUST** be able to see, for themselves: their current allocation and its window, their
own reservations, their own seat-change requests and their outcomes, their own allocation and transfer history, and
their own no-show count.

`SEAT-FR-278` — The module **MUST NOT** store, cache or index any student personal attribute. It holds
`StudentRecordId` and never a name, photograph, contact detail, date of birth, guardian detail, `PersonId` or
`AccountId` (`SEAT-FR-047`, `SM-2.4`, `MP-GBR-03`).

`SEAT-FR-279` — The module **MUST NOT** display or store any monetary value: no fee, price, plan amount, due,
discount or balance may appear on a seat, an allocation, a seat card, a report or an export. `LXC-7` puts no money in
the library module; Authentication `BR-2.12` denies Reception *"revenue and financial data in all circumstances"*,
and a seat surface visible to Reception is therefore an unacceptable place for it.

`SEAT-FR-280` — Where the seat card composes membership data (§13), it **MUST** be limited to validity state,
`validUntil` and `seatQuota` — the exact `E-02` payload. Plan name, price, payment history and dues **MUST NOT** be
composed, even where a caller would be authorised to see them elsewhere.

### 28.4 Non-disclosing denial

`SEAT-FR-281` — A denial on a `self` or `guardianOf` scope **MUST** be indistinguishable from not-found
(`MP-GBR-22`). A student querying another student's seat receives the same response as a student querying a seat
that does not exist.

`SEAT-FR-282` — A denial **MUST NOT** disclose, through message text, status code, response time or the presence or
absence of a field, whether the target exists, whether the target belongs to another tenant, or whether the caller
would have been permitted had a different scope applied.

`SEAT-FR-283` — A denial **MUST** still be audited under `SEAT-FR-236`. Non-disclosure applies to the caller, never
to the audit trail.

### 28.5 Export privacy

`SEAT-FR-284` — A bulk export (`SEAT-PO-014`) **MUST** be confined to the caller's tenant, **MUST** identify students
by `StudentRecordId` and admission number only, and **MUST NOT** contain a name, contact detail, monetary value or
any membership field beyond validity state and `validUntil`.

`SEAT-FR-285` — Every export **MUST** be audited as a protected operation with its filter criteria and row count
recorded, because an export is the highest-volume disclosure the module permits.

`SEAT-FR-286` — Export **MUST NOT** be available to Reception, to students or to guardians in any form
(`SEAT-PO-014`, `SEAT-FR-171`).

---
## 29. Multi-tenancy

`SEAT-FR-287` — Every seat, floor reference, zone reference, layout version, seat category, `SeatAllocation`,
`Reservation`, maintenance record, lock, occupancy fact, filter preset and idempotency key **MUST** carry a
`tenantId`. `MASTER_PRD` §16 is explicit that *"tenant-scoped rows must carry it or the isolation guarantee is
unenforceable"* — *"where applicable"* is a decision rule, not a hedge.

`SEAT-FR-288` — Tenant context **MUST** be obtained from the ambient `TenantContext` of `E-18` (`BC-19` Tenancy) and
**MUST NOT** be passed as a parameter through domain methods, per `E-18`'s stated mechanism.

`SEAT-INV-009` — Every query and every mutation **MUST** be filtered by the resolved `tenantId`. A query that could
execute without a tenant predicate **MUST NOT** exist in this module.

`SEAT-INV-010` — A `SeatAllocation` **MUST NOT** reference a seat, a student, a category, a shift or a zone belonging
to a different tenant. This restates `SEAT-INV-007` as an isolation obligation rather than a consistency one.

`SEAT-FR-289` — Where tenant context cannot be resolved, the operation **MUST fail loudly**. The module **MUST NOT**
default to a tenant, infer one from the target row, or fall back to a *"no tenant"* mode (`MP-GBR-06`,
`MP-GBR-07`: *"a consumer that processes an event without establishing tenant context **fails loudly, never
defaults**"*).

`SEAT-FR-290` — Every event this module emits **MUST** carry tenant context (`MP-GBR-07`), and every event it
consumes **MUST** be rejected where tenant context is absent — not processed with a guess.

`SEAT-FR-291` — `StudentRecordId` **MUST NOT** appear in any cross-tenant surface, global index, global cache key or
global event emitted by this module (`MP-GBR-03`).

`SEAT-FR-292` — A seat display number **MUST** be unique only within its zone within its tenant. Two tenants
**MUST** be able to use the same seat numbers, floor names and zone names without interference.

`SEAT-FR-293` — Filter presets (§26.2), configuration values (§27) and seat categories (§17) **MUST** be
tenant-scoped. No default category, preset or layout **MUST** be shared across tenants as a mutable row.

`SEAT-FR-294` — A cross-tenant reference **MUST** be treated as not-found, not as forbidden (§28.4). A caller
**MUST NOT** be able to detect that a seat identifier exists in another tenant.

`SEAT-FR-295` — Entitlement checks **MUST** be made through `E-17` `check(tenantId, feature, delta)` **before** the
aggregate mutates, for seat creation, bulk import and any operation that grows counted inventory. This module
**MUST NOT** implement its own seat-count limit, because `BC-21` Entitlement is *"the single source of truth for
limits and gates."*

`SEAT-FR-296` — Seat inventory limits are a **hard, counted** entitlement, so the `E-17` gate **MUST** fail
**closed** on timeout, per `Q-03`'s recommendation that *"hard paid features fail-closed."* Acquisition of an
existing seat is not an entitlement-counted operation and **MUST NOT** be blocked by an entitlement timeout.

`SEAT-INV-011` — A suspended tenant **MUST** reject every write in this module, consistent with `BC-19`'s invariant
that *"suspended tenant rejects all writes."* Reads of existing allocations remain permitted so that a library can
still see who is seated.

---
## 30. Edge case audit

Every case below was tested against the rules written in §§4–29. The **Outcome** column states what the module does,
deterministically. The **Rule** column names the requirement that produces it. Where no existing rule produced a
determinate answer, a rule was added and is marked **new**; where the answer depends on a decision this module may
not make, the case is marked **gap** and points to `SEAT-GAP-*`.

Case numbering follows the review instruction's list, so that cases already cited by number in §§7, 12, 17 and 19
(**3**, **13**, **14**, **15**, **20**) keep those numbers.

| # | Case | Outcome | Rule |
|---|---|---|---|
| 1 | Two staff assign the same seat at the same instant | Exactly one succeeds; the other is rejected naming the seat as taken. Enforced by a DB unique constraint **plus** a pessimistic row lock, never optimistically | `SEAT-INV-001`, `SEAT-BR-011`, `SEAT-FR-197` |
| 2 | A student books a seat while staff assign the same seat | Identical to case 1 — both paths run the same gate and take the same lock; there is no privileged path | `SEAT-FR-052`, `SEAT-FR-197` |
| 3 | Membership expires between booking and use | The reservation does **not** convert. G7 is re-evaluated at conversion, not at booking | `SEAT-FR-091`, `SEAT-BR-014` |
| 4 | Membership expires while the student is seated | The allocation is **not** auto-released. It is flagged and enters the expiry work queue. Release timing awaits the `Q-01` grace decision | `SEAT-FR-155`, `SEAT-GAP-003` |
| 5 | Membership is frozen while the student is seated | The seat is **held**, not released. BC Map §9 calls this *"proration + seat hold"*. New acquisition is refused while frozen | `SEAT-FR-156` **new** |
| 6 | Student is suspended while seated | New acquisition is refused immediately; the existing allocation is released, because `PRD-004` line 288 and BC Map §9 (*"suspension cascades to seat release"*) require it | `SEAT-BR-013`, `SEAT-FR-154` |
| 7 | Student status becomes `Inactive` while seated | **Configurable**, defaulting to *blocks new acquisition, retains the existing allocation*. `PRD-004` `SM-GAP-3` leaves this unspecified upstream | `SEAT-CFG-003`, `SEAT-GAP-002` **gap** |
| 8 | Student is archived while seated | The allocation is released; archival is terminal and stronger than suspension | `SEAT-BR-013`, `SEAT-FR-154` |
| 9 | The `E-02` membership projection is stale by a few seconds | Acquisition proceeds on the projection. A staleness of under 5 seconds is an **accepted, bounded risk** recorded in BC Map §10 — not a defect to be engineered away | `SEAT-FR-154` |
| 10 | The `E-02` projection is unavailable | Acquisition **fails closed** — no seat is granted without a positive validity answer. Reads of existing state continue and are labelled stale | `SEAT-FR-152`, `SEAT-FR-153`, `SEAT-BR-014` |
| 11 | A student's `seatQuota` is 2 and they request a third seat | Rejected, naming the quota and the current count | `SEAT-BR-012`, `SEAT-INV-002` |
| 12 | A student holds one seat and requests a second concurrently, twice at once | At most `seatQuota` succeed. The student's allocation set is locked, not only the seat — locking the seat alone lets two requests for two different seats both win | `SEAT-FR-198` |
| 13 | The Owner reduces a plan's `seatQuota` below what a seated student already holds | Nothing is released. `MM-FR-025` makes the change effective on renewal only; the published quota is what this module reads | `SEAT-FR-048`, `SEAT-FR-049` |
| 14 | A student's published `seatQuota` drops at renewal below their held allocations | Excess allocations are **flagged for staff decision**, never auto-released. A human chooses which seat is given up | `SEAT-FR-300` **new**, `MM-GAP-005` |
| 15 | A seat's category changes under a sitting student | The holder keeps the seat. The new category governs future acquisition only | `SEAT-FR-146` |
| 16 | A category's eligibility rule changes and a sitting student no longer qualifies | The allocation is retained and flagged into the eligibility work queue | `SEAT-BR-024`, `SEAT-FR-150` |
| 17 | A student's shift changes and their fixed seat belongs to another shift | The allocation is retained and flagged. A shift change **never** auto-releases a seat | `SEAT-FR-139`, `SEAT-BR-022` |
| 18 | A seat is locked while occupied | The holder keeps the seat and may still release or transfer **out**. Only new acquisition is suppressed | `SEAT-FR-160`, `SEAT-FR-161`, `SEAT-BR-025` |
| 19 | A seat goes into maintenance while occupied | Staff **MUST** choose a disposition — Retain, Relocate or Release. The system does not choose | `SEAT-FR-167`, `SEAT-FR-168` |
| 20 | A bulk import fails on row 400 of 500 | **No** row is applied, and a per-row error report is returned. All-or-nothing | `SEAT-BR-028`, `SEAT-FR-172` |
| 21 | The same bulk import file is submitted twice | The original result is returned; no duplicate seats are created | `SEAT-FR-173` |
| 22 | A bulk reassignment includes one student who fails the gate | That student's move fails; the gate is evaluated **per student per destination**, and the batch is not authorised as a whole | `SEAT-BR-029` |
| 23 | A network retry causes one assignment request to arrive twice | Exactly one allocation, one history row, one audit fact and one notification fact. The idempotency key makes the second call return the first result | `SEAT-BR-032`, `SEAT-FR-203` |
| 24 | A duplicate request arrives with **no** idempotency key | It is rejected by the invariants, not silently accepted. The invariant is the backstop; the key is the optimisation | `SEAT-FR-204` |
| 25 | A seat is renumbered after a student has sat in it | History still reads correctly, because the internal identifier never changes and each released allocation retains the number as it was | `SEAT-BR-004`, `SEAT-BR-034` |
| 26 | A seat is moved to a different position in the layout editor | Nothing about identity, allocation, category or history changes. Position is presentation | `SEAT-BR-007`, `SEAT-BR-004` |
| 27 | A seat is dragged into a different zone | This is **not** a move — it is a change of container, which is a structural operation, and it **MUST** be refused while an active allocation exists | `SEAT-FR-297` **new** |
| 28 | A layout is edited so that a seat holding an active allocation would be deleted | Refused. BC Map §8: *"layout edits cannot orphan an active allocation"* | `SEAT-INV-006`, `SEAT-FR-033` |
| 29 | A floor or zone is deactivated in `BC-06` while seats on it are allocated | Seats are **not** deleted (`LIB-10.6`). Existing allocations are retained and flagged; new acquisition on that container is refused | `SEAT-FR-298` **new** |
| 30 | A student checks in without any seat allocation | Check-in is **never** rejected. Occupancy is recorded against the branch, and the seatless presence appears in a staff view | `SEAT-FR-112`, `SEAT-BR-020` |
| 31 | A student checks in while sitting in a seat allocated to someone else | Both facts are recorded — the occupancy and the mismatch — and the case is surfaced to staff. The module does not silently reassign the seat | `SEAT-FR-299` **new** |
| 32 | A check-in event arrives twice, or out of order | Occupancy handling is idempotent, and an event contradicting newer state is discarded rather than applied | `SEAT-FR-113`, `SEAT-FR-214` |
| 33 | A reservation's expiry sweeper has not run | The seat presents as `Available` regardless, because expiry is derived at read time, not written by a job | `SEAT-FR-095` |
| 34 | A student repeatedly reserves and never turns up | After `SEAT-CFG-012` consecutive no-shows, self-booking is suspended for `SEAT-CFG-013`. Staff assignment at the desk remains available throughout | `SEAT-FR-096` |

### 30.1 Rules added because the audit found a gap

The four cases below had **no determinate answer** in §§4–29. Each is resolved here with a rule, rather than left to
implementation choice.

`SEAT-FR-297` — Moving a seat to a **different `Zone` or `Floor`** is a change of container, not a change of
position, and **MUST** be refused while the seat holds an active allocation or an unexpired reservation. Where the
seat is free, the change **MUST** re-validate seat-number uniqueness in the destination zone (`SEAT-BR-005`) and
**MUST NOT** alter the seat's internal identifier or its retained history. *(Answers case 27. Distinguished from
`SEAT-FR-024`, which permits free repositioning **within** a container, and from `SEAT-FR-027`, which permits
renumbering.)*

`SEAT-FR-298` — Where a `Floor` or `Zone` becomes inactive in `BC-06` while seats in it hold active allocations, the
allocations **MUST** be retained, **MUST** be flagged into a work queue for staff decision, and new acquisition on
that container **MUST** be refused (`SEAT-FR-019`, gate G10). The module **MUST NOT** mass-release allocations in
response to a container status change. *(Answers case 29. `LIB-10.6` forbids deleting the seats; this states what
happens to the people in them.)*

`SEAT-FR-299` — Where an `E-08` check-in identifies a student who is **not** the holder of the seat they are recorded
against, the module **MUST** record the occupancy fact, **MUST** record the mismatch, **MUST** surface it to staff,
and **MUST NOT** reassign, release or alter any allocation automatically. *(Answers case 31. A physical
mis-seating is a human problem; silently rewriting the allocation would destroy the evidence that it happened.)*

`SEAT-FR-300` — Where a student's **published** `seatQuota` falls below the number of active allocations they hold —
which `MM-FR-025` permits only at renewal — every allocation **MUST** be retained and the excess **MUST** be flagged
for staff decision. The module **MUST NOT** choose which seat to release. *(Answers case 14, and is the seating-side
counterpart of the open `MM-GAP-005`.)*

`SEAT-INV-012` — A seat **MUST** belong to exactly one `Zone` at any time, and its `Zone` **MUST** belong to exactly
one `Floor` (`LIB-11.1`).

`SEAT-INV-013` — A seat **MUST NOT** hold an active allocation and an unexpired reservation for the **same** time
window on behalf of **different** students.

`SEAT-INV-014` — An allocation, a reservation, a lock and a maintenance record **MUST** each reference a seat that
exists in the same tenant. A dangling reference **MUST NOT** be representable.

### 30.2 Operation priority

`SEAT-BR-041` — Where two rules in this document could both apply to one operation, the **operation priority order**
is: tenancy (§29) → authorisation (§28) → idempotency (§21) → the acquisition gate in its stated order G1…G16 (§8) →
invariants (§7) → side effects (events, audit, notification facts). A later step **MUST NOT** be reached if an
earlier one fails, and no step **MUST** be skipped for any role.

`SEAT-BR-042` — Where a rule retains an allocation and another flags it, both **MUST** happen: retention is the
state change and flagging is the work-queue entry. **Retain-and-flag is never retain-and-forget.**

`SEAT-BR-043` — No rule in this document **MUST** cause a seated student to lose their seat automatically except the
two cases where a higher authority requires it: enrollment suspension and archival (case 6, case 8). Every other
adverse change **MUST** retain and flag.

`SEAT-BR-044` — Where this document and a higher-authority document disagree, the higher authority governs and the
disagreement **MUST** be recorded in §31 as a gap rather than resolved here. `DOCUMENTATION_BASELINE.md` §4:
*"a conflict is a defect. If you find one, do not choose — raise it."*

---
## 31. Gap register — open questions and recorded conflicts

`SEAT-GAP-*` entries are **questions, not requirements**. None is verifiable and none may be cited as an acceptance
criterion. Each records something this module may not decide alone, per `DOCUMENTATION_BASELINE.md` §4:
*"a conflict is a defect. If you find one, do not choose — raise it."*

| ID | Question or conflict | Why this module cannot settle it | Owner | Effect on V1 |
|---|---|---|---|---|
| `SEAT-GAP-001` | **`Floor` ownership conflict.** BC Map §8 lists `Floor` among `BC-04`'s entities. Library PRD `LIB-10.*` and `LIB-11.*` define `Floor` and `Zone` as `BC-06` records with their own rules, and `LIB-11.5` says assignment is `BC-04`'s but the container is not | Two authorities disagree. BC Map is Rank 4; Library PRD is Rank 3, so the Library PRD is higher — but the BC Map is the aggregate register | Architecture | **None.** `SEAT-FR-015` makes this module *read* containers and never create them, which is correct under either resolution |
| `SEAT-GAP-002` | Does `EnrollmentStatus` `Inactive` block seat acquisition? | `PRD-004` `SM-GAP-3` records it as **unspecified upstream**. This module must not decide another context's status semantics | `BC-01` owner + Architecture | **None.** `SEAT-CFG-003` defaults to *blocks*, the safe reading |
| `SEAT-GAP-003` | **`Q-01`** — does an expired membership release the seat immediately, at end of day, or after a grace period? | Master PRD L673 and BC Map §13 both list `Q-01` as **Open**. `MM-GAP-001` assigns it to *"Architecture + `BC-04` owner"* | Architecture + this module | **Bounded.** `SEAT-FR-155` flags and queues; no automatic release happens, so no wrong behaviour is shipped |
| `SEAT-GAP-004` | Membership **freeze** is V2 per `MM-GAP-010`, but BC Map §9 routes `MembershipFrozen` to `BC-04` today | The event may never fire in V1 | `BC-02` owner | **None.** `SEAT-FR-156` is inert until the event exists and adds no V1 surface |
| `SEAT-GAP-005` | Adding an occupancy threshold to the `E-05` `SeatRules` payload | `E-05`'s contract is fixed by the BC Map; BC Map §7 says an edge not in the table does not exist and changing one requires an ADR | Architecture | **None.** `SEAT-FR-241` emits nothing while unset |
| `SEAT-GAP-006` | Should a floor-scoped or zone-scoped permission exist for large branches? | `MP-GBR-21` **closes** the scope register at `self`, `guardianOf`, `tenantWide`. Adding a scope is a platform decision | Architecture + Authentication | **None.** V1 grants are `tenantWide` for staff |
| `SEAT-GAP-007` | Is the seat QR code the same physical artefact as the attendance QR code? | `BC-03` owns attendance QR. This module owns seat QR. A tenant may print both on one label, but the semantics must not merge | `BC-03` owner + this module | **None.** `SEAT-XC-007` keeps the flows separate |
| `SEAT-GAP-008` | Where should the *operating day* boundary come from for occupancy reset? | `BC-06` owns branch hours (`E-04` names `openTime`/`closeTime` for Attendance, not for Seating) | `BC-06` owner + Architecture | **Low.** `SEAT-FR-114` consumes it from `BC-06`; the read path is unnamed in the edge table |
| `SEAT-GAP-009` | Does `BC-03` Attendance need to read this module's allocation to record *which seat* a student sat in? | No `BC-04` → `BC-03` edge exists, and `E-08` runs the other way. If Attendance needs the seat, an edge is required | Architecture | **None in V1.** §14's split has Attendance record presence, this module record seat occupancy |
| `SEAT-GAP-010` | Should `seating.SeatReleased` distinguish release reasons in its payload for `BC-26`? | Event payloads are part of the published contract | Architecture + `BC-26` owner | **None.** `SEAT-FR-223`'s reason is retained locally regardless |
| `SEAT-GAP-011` | Whether the Library Member Directory's seat column (`PRD-004` L606) should show allocation or occupancy | `PRD-004` `LMD-24b` forbids `BC-01` becoming authoritative over seat assignment, but does not say which of the two figures it composes | `BC-01` owner | **Low.** `SEAT-FR-245` makes the two figures distinct and separately requestable |
| `SEAT-GAP-012` | `PRD-005` §25.3 cites a *"`PRD_REGISTRY.md` §5 procedure"* for prefix adoption. No such section exists in `PRD_REGISTRY.md` | A governance citation is imprecise. This task may not modify governance documents | Governance | **None.** The reproducible procedure is the grep-absence check, performed and evidenced in §0.3 |
| `SEAT-GAP-013` | Retention period for released allocation history | Platform data retention is not this module's to define, and `SEAT-XC-015` defers it | Platform / legal | **None.** Nothing is deleted in V1 |
| `SEAT-GAP-014` | Whether a *"busy / moderate / quiet"* public occupancy indicator satisfies the deferred privacy review | `ARCHITECTURE_RULINGS.md` §6 defers public live occupancy to **V2** *"pending a privacy review"* and says it *"must not be invented"* | Architecture + privacy review | **None.** `SEAT-XC-020` excludes it from V1 |

`SEAT-BR-045` — No gap above **MUST** be resolved by implementation choice. Where a gap blocks a decision at build
time, the correct action is to escalate it, not to pick a behaviour. `MM-NFR-014` applies: *"a rule that cannot be
checked SHALL be treated as unmet, not as satisfied by intent."*

---

## 32. Non-functional requirements

`SEAT-NFR-001` — Seat acquisition **MUST** be **strongly consistent** on the seat. BC Map §10 records the required
mechanism as *"DB unique constraint on (seat, window) + pessimistic lock"* and §10.1 lists double seat allocation as
a case where eventual consistency is unacceptable. Eventual consistency on the seat **MUST NOT** be substituted for
any reason, including performance.

`SEAT-NFR-002` — Membership validity **MUST** be read as an eventually consistent projection, with staleness bounded
at **5 seconds** (`SEAT-FR-154`, BC Map §10). This module **MUST NOT** convert that read into a synchronous call
into `BC-02`.

`SEAT-NFR-003` — The membership validity check **MUST** be fast enough not to dominate the seat-assignment path,
consistent with `MM-NFR-011`, which states that obligation from the publishing side.

`SEAT-NFR-004` — This document **MUST NOT** state a latency or availability figure of its own. Platform
non-functional targets are set once, centrally; a second figure in a module PRD creates a conflict with no resolution
rule. Where a figure is needed it is the platform's, and `LIB-20.1` is the precedent for not restating it.

`SEAT-NFR-005` — The seat map **MUST** remain usable at the maximum inventory the platform permits, which `LCFG-9`
and `LCFG-10` bound at 50 floors × 100 zones per branch. Performance **MUST NOT** degrade non-linearly with seat
count, because the seat map is the module's primary surface.

`SEAT-NFR-006` — Real-time seat state **MUST** converge for all connected staff clients without a manual refresh
(§21). A client that has missed updates **MUST** be able to resynchronise from current state rather than by replaying
a stream, since `SeatState` is derived (§6) and therefore always recomputable.

`SEAT-NFR-007` — Occupancy handling **MUST** tolerate duplicate and out-of-order `E-08` delivery without producing a
wrong count (`SEAT-FR-113`, `SEAT-FR-214`). At-least-once delivery is assumed; exactly-once is not.

`SEAT-NFR-008` — Audit emission **MUST NOT** be on the critical path of a seat operation (`SEAT-FR-233`,
`E-20` fire-and-forget), and **MUST** be delivered eventually by the outbox rather than dropped on failure.

`SEAT-NFR-009` — Bulk operations **MUST** complete or fail as a unit (`SEAT-BR-028`) at the maximum row count the
entitlement permits, and **MUST NOT** hold a lock for the duration of a large batch in a way that blocks counter
operations. Where the two conflict, counter operations take precedence — a library cannot stop serving students
because an import is running.

`SEAT-NFR-010` — Every rejection **MUST** carry a reason precise enough to be acted on: the failing gate step, the
limit and the current value where a limit is involved. *"Assignment failed"* **MUST NOT** be the whole of a rejection
(`SEAT-FR-054`).

`SEAT-NFR-011` — Every requirement in this document **MUST** be observable through a surface a tester can reach:
module state, a module read model, or an emitted event. A requirement whose only evidence is internal is untestable
and, per `MM-NFR-014`, **MUST** be treated as unmet.

`SEAT-NFR-012` — Deriving `SeatState` (§6), reservation expiry (§12) and operational metrics (§25) at read time
**MUST** be cheap enough to be done on every read. This is a deliberate trade: the module accepts read-time
computation in exchange for never having a stored status that can disagree with the facts beneath it.

---
## 33. Acceptance criteria

Every criterion below is deterministic: a fixed precondition, a single action, and one observable outcome. The
**Verifies** column names the requirement each criterion tests, so a reader can go from any requirement to its test
and back. Per `SEAT-NFR-011`, every criterion is observable through module state, a module read model or an emitted
event — nothing here depends on inspecting internals.

Criteria are written against the module's behaviour, not against a screen layout, so a change of user interface does
not invalidate them.

### 33.1 Spatial model, seat identity and the layout editor

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-001` | A tenant with one branch and no additional floors configured | Seats are created | They attach to the single default floor and its default zone, and creation succeeds | `SEAT-FR-016` |
| `SEAT-AC-002` | A zone `A` on floor 1 containing seat `A1` | A second seat numbered `A1` is created in zone `A` | Creation is rejected, naming the duplicate number and the zone | `SEAT-BR-005` |
| `SEAT-AC-003` | Seat `A1` exists in floor 1 zone `A` | Seat `A1` is created in floor 2 zone `B` | Creation succeeds; the two seats are distinct with distinct internal identifiers | `SEAT-BR-006` |
| `SEAT-AC-004` | A seat number is submitted as `" A1 "` | The seat is created | The stored number is `A1`, and a later `A1` in the same zone is rejected as a duplicate | `SEAT-FR-026` |
| `SEAT-AC-005` | Seat `S` holds an active allocation | `S` is renumbered from `A1` to `B7` | Renumbering succeeds, the allocation is unchanged, and `S`'s internal identifier is unchanged | `SEAT-FR-027`, `SEAT-BR-004` |
| `SEAT-AC-006` | Seat `S` holds an active allocation, a lock, and a maintenance record | `S` is dragged to a new position and the layout is saved | Identifier, number, category, type, lock state, maintenance state, allocation, reservation and every history row are unchanged | `SEAT-BR-007` |
| `SEAT-AC-007` | A layout containing seat `S` with an active allocation | An edit is submitted that deletes `S` | The edit is rejected; no allocation is orphaned | `SEAT-BR-008` |
| `SEAT-AC-008` | A tenant configures the zone label as `"Room"` | A staff member views any seat surface | The container is labelled `Room` throughout, and the underlying container is still a `Zone` with unchanged behaviour | `SEAT-FR-014` |
| `SEAT-AC-009` | A `Floor` exists in `BC-06` | This module attempts to rename it | No such operation is available; the attempt cannot be expressed through this module | `SEAT-FR-015` |
| `SEAT-AC-010` | A floor declares capacity 50 and 60 seats are configured in it | The floor is viewed | Both figures are shown as distinct labelled values; neither is silently corrected and no error blocks operation | `SEAT-FR-018` |
| `SEAT-AC-011` | A zone contains 20 seats, 5 with active allocations | The zone is set inactive in `BC-06` | No seat is deleted and no allocation is destroyed | `SEAT-FR-019` |
| `SEAT-AC-012` | A zone has an active layout version `v3` | A layout edit is saved | A new version `v4` becomes active, `v3` is retained, and exactly one version is active | `SEAT-FR-021`, `SEAT-FR-022` |
| `SEAT-AC-013` | A layout containing a wall, a door, a table and a pillar | A student attempts to book the table | The table is not offered and cannot be addressed by any allocation, reservation, lock or search operation | `SEAT-FR-032` |
| `SEAT-AC-014` | A Manager without a layout-edit grant | The Manager opens the layout editor | Editing is denied; the layout is readable | `SEAT-FR-028`, `SEAT-PO-016` |
| `SEAT-AC-015` | A tenant with no 3D layout configured | Every seat operation in this document is exercised | All succeed; no requirement is unsatisfiable for want of 3D | `SEAT-FR-035`, `SEAT-FR-005` |
| `SEAT-AC-016` | A layout edit placing two seats at the same coordinates | The edit is saved | The edit is rejected before persistence with a reason naming the collision | `SEAT-FR-034` |

### 33.2 Seat lifecycle and derived state

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-017` | A seat with no maintenance, no allocation and no unexpired reservation | Its state is read | `Available` | `SEAT-FR-037`, `SEAT-FR-040` |
| `SEAT-AC-018` | A seat with an active allocation and an active maintenance record | Its state is read | `Maintenance` — maintenance outranks occupancy | `SEAT-FR-037` |
| `SEAT-AC-019` | A seat with an active allocation and an unexpired reservation held by the same student | Its state is read | `Occupied` — occupancy outranks reservation | `SEAT-FR-037` |
| `SEAT-AC-020` | A seat with an active allocation whose holder has not checked in | Its state is read | `Occupied`, with the physically-occupied indicator false | `SEAT-FR-041` |
| `SEAT-AC-021` | An available seat is locked | Its state is read | `Available`, with the lock flag set — `Locked` is never returned as a state value | `SEAT-FR-038`, `SEAT-XC-001` |
| `SEAT-AC-022` | A locked available seat | An acquisition is attempted | It is refused at gate step G12, naming the lock | `SEAT-BR-025` |
| `SEAT-AC-023` | Any seat at any time | Its state is read twice with no intervening fact change | The same value is returned both times, and no code path exists that sets the state directly | `SEAT-BR-010`, `SEAT-XC-002` |
| `SEAT-AC-024` | A seat under maintenance | A booking, reservation, assignment or auto-assignment is attempted | Every one is rejected with the maintenance reason | `SEAT-FR-043`, `SEAT-FR-169` |
| `SEAT-AC-025` | A seat whose five facts are set so that maintenance is active | Maintenance ends | The state recomputes from the remaining facts; no fact was implicitly cleared by the maintenance change | `SEAT-BR-009` |
| `SEAT-AC-026` | A seat displayed on a staff surface with a lock set | The surface is rendered | Both the derived state and the lock flag with its reason are shown | `SEAT-FR-039` |
| `SEAT-AC-027` | An `Occupied` seat | A transition to `Available` is attempted without a release | The transition is rejected with a distinguishable reason | `SEAT-FR-045` |

### 33.3 The acquisition gate

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-028` | Any of staff assignment, student booking, reservation creation, reservation conversion, auto-assignment, QR assignment, bulk reassignment or seat-change approval | The operation runs | The same ordered gate G1…G16 is evaluated, in the same order | `SEAT-FR-052`, `SEAT-XC-003` |
| `SEAT-AC-029` | A student whose `EnrollmentStatus` is `Suspended` | Staff attempt to assign a seat | Rejected at G6, naming enrollment status | `SEAT-BR-013` |
| `SEAT-AC-030` | A student with no valid membership, and an actor holding the Owner role | Owner attempts to assign a seat | Rejected at G7. No override affordance exists for any role | `SEAT-BR-014`, `SEAT-XC-004` |
| `SEAT-AC-031` | A gate step fails | The response is returned | It names the failing step, and where a limit is involved, the limit and the current value | `SEAT-FR-053`, `SEAT-NFR-010` |
| `SEAT-AC-032` | A gate step fails midway through evaluation | The transaction ends | No allocation, reservation, history row, counter change or event is produced | `SEAT-FR-054` |
| `SEAT-AC-033` | A student whose `EnrollmentStatus` is `Inactive`, with `SEAT-CFG-003` unset | Staff attempt to assign a seat | Rejected — the default is *blocks* | `SEAT-CFG-003`, `SEAT-GAP-002` |
| `SEAT-AC-034` | A seat in a zone that has become inactive | An acquisition is attempted | Rejected at G10, naming the inactive container | `SEAT-FR-298` |
| `SEAT-AC-035` | Two acquisition attempts on one seat arriving concurrently | Both run | Exactly one succeeds; the other is rejected at G16 under a pessimistic lock, never by an optimistic retry | `SEAT-BR-015`, `SEAT-BR-031` |

### 33.4 Allocation, quota and invariants

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-036` | A seat with an active allocation for window `W` | A second active allocation for a window overlapping `W` is attempted | Rejected by a database constraint under a pessimistic lock, not by an application-level read-then-write check | `SEAT-INV-001`, `SEAT-BR-011` |
| `SEAT-AC-037` | An allocation is created | Its stored fields are inspected | It carries `StudentRecordId`, and carries no `PersonId`, name, contact detail or monetary value | `SEAT-FR-047`, `SEAT-FR-010` |
| `SEAT-AC-038` | A student with published `seatQuota` 1 holding one active allocation | A second overlapping allocation is attempted | Rejected, naming the quota and the current count | `SEAT-BR-012`, `SEAT-INV-002` |
| `SEAT-AC-039` | An `E-02` projection that omits `seatQuota`, with `SEAT-CFG-002` unset | An allocation is attempted | The effective quota is 1 | `SEAT-FR-049` |
| `SEAT-AC-040` | An allocation with `validFrom` equal to `validUntil` | It is submitted | Rejected — the window must be strictly positive | `SEAT-INV-003` |
| `SEAT-AC-041` | An allocation created by each of the eight origins in turn | Each is inspected | Each records its origin from the closed set, the origin is immutable, and it appears in the timeline and the audit fact | `SEAT-FR-050`, `SEAT-FR-051` |
| `SEAT-AC-042` | An allocation whose seat belongs to tenant `T1` | The allocation is written with tenant `T2` | Rejected; tenant identifiers must agree | `SEAT-INV-007`, `SEAT-INV-010` |
| `SEAT-AC-043` | A seat holding an active allocation for window `W` | An unexpired reservation for the same seat and same window `W` is attempted | Rejected | `SEAT-INV-013` |

### 33.5 Staff assignment, release and transfer

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-044` | A Reception user and an available seat | A student is selected and assigned | The allocation is created with origin `StaffAssigned`, recording actor and timestamp | `SEAT-FR-055`, `SEAT-FR-057` |
| `SEAT-AC-045` | A Reception user assigning a seat | The student is not explicitly selected | The operation cannot proceed; the module does not infer a student | `SEAT-FR-056` |
| `SEAT-AC-046` | Seat `S` occupied by student `X` | Staff attempt to assign `S` to student `Y` in one step | Rejected; two explicit steps — release or transfer, then assign — are required | `SEAT-BR-016`, `SEAT-FR-058` |
| `SEAT-AC-047` | An active allocation | It is released | Its state becomes `Released`, it is retained, and no delete operation exists for it | `SEAT-FR-061`, `SEAT-XC-014` |
| `SEAT-AC-048` | An active allocation | Release is submitted with no reason | Rejected; a reason is mandatory | `SEAT-FR-060`, `SEAT-FR-224` |
| `SEAT-AC-049` | Student `X` on seat `S1`, destination seat `S2` available | A transfer is executed | `X` holds `S2` and no longer holds `S1`; both effects are committed together or neither is | `SEAT-FR-063` |
| `SEAT-AC-050` | Student `X` on seat `S1`, destination `S2` under maintenance | A transfer to `S2` is attempted | Rejected before `S1` is released; `X` still holds `S1` | `SEAT-FR-064` |
| `SEAT-AC-051` | `maxTransfersPerDay` is 2 and student `X` has had 2 transfers today | A third staff-initiated transfer is attempted | Rejected, naming the limit and the count already used | `SEAT-BR-017`, `SEAT-FR-066` |
| `SEAT-AC-052` | `maxTransfersPerDay` is reached for student `X` | A relocation is performed under a maintenance `Relocate` disposition | It succeeds and does not count against the limit | `SEAT-FR-067`, `SEAT-FR-168` |
| `SEAT-AC-053` | `maxTransfersPerDay` is reached, `SEAT-CFG-005` unset | A Manager attempts to override the limit | Denied; only Owner may override by default | `SEAT-CFG-005` |
| `SEAT-AC-054` | A completed transfer | The two allocation records are inspected | Exactly one transfer linkage exists, bidirectional, written atomically with the release and the new allocation | `SEAT-FR-065`, `SEAT-FR-220` |

### 33.6 Seat-change requests, self-booking and reservations

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-055` | A student holding a seat | A seat-change request is raised | A request record is created in state `Pending`, and no seat is created, moved, reserved or held | `SEAT-FR-068`, `SEAT-FR-069` |
| `SEAT-AC-056` | A student with one `Pending` request and `SEAT-CFG-006` at its default | A second request is raised | Rejected, naming the limit | `SEAT-FR-074`, `SEAT-CFG-006` |
| `SEAT-AC-057` | A `Pending` request whose desired seat has since been taken | Staff approve the request | Approval fails, re-evaluating the full gate at approval time and naming the failing step | `SEAT-FR-072`, `SEAT-FR-129` |
| `SEAT-AC-058` | A `Pending` request older than `SEAT-CFG-007` | Its state is read | `Expired` | `SEAT-FR-075` |
| `SEAT-AC-059` | A student with a `Pending` request | The student cancels it | It becomes `Cancelled`; the student cannot cancel another student's request | `SEAT-FR-073`, `SEAT-FR-077` |
| `SEAT-AC-060` | Self-booking with `SEAT-CFG-008` unset | A student attempts to book | Denied — self-booking is disabled by default | `SEAT-FR-076`, `SEAT-CFG-008` |
| `SEAT-AC-061` | Self-booking enabled | A student submits a booking with no date | Rejected; an explicit `validFrom` and `validUntil` are required | `SEAT-FR-080` |
| `SEAT-AC-062` | A student whose membership `validUntil` is 30 June, `SEAT-CFG-009` unset | A booking to 15 July is submitted | Rejected — the default is `reject`, not silent truncation | `SEAT-FR-081`, `SEAT-CFG-009` |
| `SEAT-AC-063` | Self-booking enabled | A booking starting yesterday is submitted | Rejected | `SEAT-FR-082` |
| `SEAT-AC-064` | `reservationWindow` from `E-05` is 7 days | A booking starting in 30 days is submitted | Rejected, naming the window | `SEAT-FR-083` |
| `SEAT-AC-065` | Booking mode unset | A student books an available seat | A `Pending` reservation is created requiring approval — `ApprovalRequired` is the default | `SEAT-FR-086`, `SEAT-CFG-010` |
| `SEAT-AC-066` | Booking mode `Direct` | A student books an available seat | An allocation is created directly with origin `StudentBooked`, the full gate having been evaluated at creation | `SEAT-FR-086`, `SEAT-FR-087` |
| `SEAT-AC-067` | A `Pending` reservation | Its seat's state is read | The seat is not held by the pending reservation; another student may still acquire it | `SEAT-FR-127` |
| `SEAT-AC-068` | Conversion mode unset and a student with an active reservation | The student checks in | The reservation converts to an allocation — `OnCheckIn` is the default | `SEAT-FR-089`, `SEAT-CFG-011` |
| `SEAT-AC-069` | A reservation created while the membership was valid, which then expired | Conversion is triggered | Conversion fails, re-evaluating gate steps G6, G7, G8, G11 and G12 | `SEAT-FR-091` |
| `SEAT-AC-070` | An already-converted reservation | A second conversion trigger fires | The second trigger has no effect and produces no second allocation | `SEAT-FR-090` |
| `SEAT-AC-071` | A reservation submitted without `expiresAt` | It is created | Rejected; no reservation may exist without an expiry | `SEAT-FR-092` |
| `SEAT-AC-072` | A reservation whose `expiresAt` has passed, with no background job having run | Its state is read | `Expired`, and the seat reads as `Available` | `SEAT-FR-093`, `SEAT-FR-095` |
| `SEAT-AC-073` | A reservation expires | The outcome is inspected | No allocation is created, no monetary effect occurs, and the reservation is retained with its terminal state | `SEAT-FR-094`, `SEAT-FR-225` |
| `SEAT-AC-074` | A student with 2 consecutive expiries, `SEAT-CFG-012` at default 3 | A third reservation expires unconverted | Self-booking is suspended for `SEAT-CFG-013`, default 7 days | `SEAT-FR-096` |
| `SEAT-AC-075` | Seat `S` holds an unexpired reservation for student `X` | Staff attempt to assign `S` to student `Y` | Rejected unless the reservation is first cancelled | `SEAT-FR-097` |
| `SEAT-AC-076` | Seat `S` holds an unexpired reservation for student `X` | Staff assign `S` to `X` | It succeeds as conversion, not as a competing allocation | `SEAT-FR-098` |
| `SEAT-AC-077` | Seat `S` has an allocation ending 30 June | A student books `S` from 1 July | Accepted — non-overlapping future windows are permitted | `SEAT-FR-100` |
| `SEAT-AC-078` | An unavailable seat | A student attempts to join a queue for it | No waiting-list affordance exists | `SEAT-FR-101`, `SEAT-XC-005` |
| `SEAT-AC-079` | A student with `SEAT-CFG-016` at default 1 holding one active reservation | A second reservation is attempted | Rejected | `SEAT-FR-121` |
| `SEAT-AC-080` | A Reception user with `SEAT-CFG-014` unset | Reception attempts to cancel another student's reservation | Denied | `SEAT-FR-102`, `SEAT-CFG-014` |
| `SEAT-AC-081` | An active reservation | Staff cancel it | Actor, timestamp and a mandatory reason are recorded, and the seat returns to `Available` | `SEAT-BR-019` |
| `SEAT-AC-082` | An active reservation whose student is then suspended | The reservation is read | It is auto-cancelled with the triggering condition recorded | `SEAT-FR-125`, `SEAT-FR-126` |
| `SEAT-AC-083` | A student books the same seat twice for overlapping windows | The second booking is submitted | Rejected | `SEAT-FR-124`, `SEAT-INV-005` |

### 33.7 Fixed and Flexible, shifts, categories and eligibility

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-084` | A `Fixed` seat with an allocation for the day | A second student attempts to acquire it for a non-overlapping shift the same day | Rejected — `Fixed` is held for the whole window | `SEAT-FR-132` |
| `SEAT-AC-085` | A `Flexible` seat with a morning-shift allocation | A second student acquires it for the evening shift | Accepted; both allocations coexist | `SEAT-FR-133`, `SEAT-BR-022` |
| `SEAT-AC-086` | A `Flexible` seat with a morning-shift allocation | A second student attempts the same morning shift | Rejected | `SEAT-BR-022`, `SEAT-INV-001` |
| `SEAT-AC-087` | A `Fixed` seat with an active allocation | The seat is changed to `Flexible` | The change succeeds and the allocation is unaltered, unshortened and unsplit | `SEAT-FR-134` |
| `SEAT-AC-088` | A `Flexible` seat with two overlapping-day allocations in different shifts | The seat is changed to `Fixed` | Rejected, naming the conflicting allocations | `SEAT-FR-135` |
| `SEAT-AC-089` | A student on a shift-bounded `Flexible` allocation | The student's shift changes in `BC-02` | The allocation is retained and flagged for staff review; it is never automatically released | `SEAT-FR-139`, `SEAT-FR-140`, `SEAT-BR-043` |
| `SEAT-AC-090` | An allocation referencing shift `Morning` | `Morning` is deleted in `BC-06` | The allocation retains the shift reference and is flagged; it is not released | `SEAT-FR-141` |
| `SEAT-AC-091` | A tenant defining a new seat category | The category is added | It is added as data with no code change, and seats may reference it | `SEAT-FR-142`, `SEAT-FR-143` |
| `SEAT-AC-092` | A category referenced by at least one seat | Deletion is attempted | Rejected; deactivation is offered instead, and existing seats keep the category | `SEAT-FR-145` |
| `SEAT-AC-093` | A seat with an active allocation | Its category changes from `Normal` to `Premium` | The allocation is retained, unaltered and not invalidated | `SEAT-FR-146`, `SEAT-BR-024` |
| `SEAT-AC-094` | An `E-02` projection carrying no permitted-category list | A student acquires a `VIP` seat | Permitted — an absent list means no restriction | `SEAT-FR-148` |
| `SEAT-AC-095` | A student whose plan does not permit `Premium` | A `Premium` seat is attempted | Rejected, stating the category and the reason, and disclosing nothing about any other student | `SEAT-FR-147`, `SEAT-FR-149` |
| `SEAT-AC-096` | A student holding a `Premium` seat whose plan changes to one without `Premium` | The change is processed | The allocation is retained and flagged; eligibility is not re-evaluated continuously | `SEAT-FR-150`, `SEAT-BR-042` |
| `SEAT-AC-097` | Any seat category | Its stored fields are inspected | No price, fee or monetary amount is present | `SEAT-FR-144`, `SEAT-FR-279` |

### 33.8 The Membership and Attendance boundaries

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-098` | Any point in the module | Membership validity is needed | It is read from the `E-02` projection only; no local computation, derivation or override exists | `SEAT-FR-151`, `SEAT-XC-010` |
| `SEAT-AC-099` | The `E-02` projection is unreachable | An acquisition is attempted | It fails closed, with an explicit reason distinguishing unavailability from invalidity | `SEAT-FR-152` |
| `SEAT-AC-100` | The `E-02` projection is unreachable | A seat card, layout, allocation or occupancy count is read | The read succeeds, with the composed membership fields marked unavailable | `SEAT-FR-153`, `SEAT-FR-106` |
| `SEAT-AC-101` | A membership renewed 3 seconds ago, projection not yet updated | An acquisition is attempted | The stale result is accepted as a bounded risk within 5 seconds and is not treated as a defect | `SEAT-FR-154`, `SEAT-NFR-002` |
| `SEAT-AC-102` | An active allocation whose membership expires | `MembershipExpired` is consumed | The allocation is flagged and queued for staff; it is not released, per the open `Q-01` | `SEAT-FR-155`, `SEAT-GAP-003` |
| `SEAT-AC-103` | An active allocation | `MembershipFrozen` is consumed | The allocation is held — neither released nor converted | `SEAT-FR-156` |
| `SEAT-AC-104` | Any seat screen | It is rendered | No renew, pay or collect affordance exists, and no monetary value is shown | `SEAT-XC-011`, `SEAT-FR-279` |
| `SEAT-AC-105` | This module and `BC-02` | Any operation runs | No publication, command call or write to `BC-02` occurs | `SEAT-FR-157` |
| `SEAT-AC-106` | A student with an active allocation | `StudentCheckedIn` arrives | The allocation is marked physically occupied and the live count increments; no attendance record is created | `SEAT-FR-109`, `SEAT-BR-020` |
| `SEAT-AC-107` | A student with **no** active allocation | `StudentCheckedIn` arrives | The check-in is recorded as unseated occupancy and is **never rejected**; `BC-03` remains authoritative | `SEAT-FR-112` |
| `SEAT-AC-108` | A check-in already processed | The same event is redelivered | The count is unchanged — handling is idempotent by event identifier | `SEAT-FR-111`, `SEAT-FR-205` |
| `SEAT-AC-109` | A check-in whose `tenantId` cannot be resolved | The handler runs | It fails loudly and processes nothing; it never defaults to a tenant | `SEAT-FR-113`, `SEAT-FR-289` |
| `SEAT-AC-110` | Occupancy accumulated during a day | The operating day rolls over per `BC-06` | Occupancy resets; allocations are unaffected | `SEAT-FR-114` |
| `SEAT-AC-111` | A missed or stale `E-08` event | Occupancy is recomputed | It converges from the current allocation set and `BC-03` open sessions; no allocation was corrupted | `SEAT-FR-115`, `SEAT-FR-116`, `SEAT-NFR-006` |
| `SEAT-AC-112` | Any attendance question — a total, a percentage, a correction or a dispute | It is asked of this module | This module is not the source; no attendance record, correction or verification evidence is stored here | `SEAT-XC-007`, `SEAT-XC-008` |
| `SEAT-AC-113` | A check-in identifying a student who is not the holder of the seat scanned | The event is processed | Both facts are recorded, the discrepancy is flagged for staff, and neither allocation nor attendance is silently altered | `SEAT-FR-299` |

### 33.9 Locking, maintenance and bulk operations

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-114` | A Reception user | Locking a seat is attempted | Denied; Reception holds no lock operation | `SEAT-FR-158`, `SEAT-PO-009` |
| `SEAT-AC-115` | A lock is submitted with no reason | It is applied | Rejected; a reason is mandatory | `SEAT-FR-159` |
| `SEAT-AC-116` | An occupied seat | It is locked | The allocation is unchanged, unshortened and valid; the holder keeps the seat | `SEAT-FR-160` |
| `SEAT-AC-117` | A locked occupied seat | Release or transfer-out of the existing allocation is attempted | It succeeds — a lock never traps a student | `SEAT-FR-161` |
| `SEAT-AC-118` | A locked seat and an Owner | Owner overrides the lock for one assignment | The assignment succeeds and the override is recorded with actor, timestamp and reason | `SEAT-FR-162`, `SEAT-PO-010` |
| `SEAT-AC-119` | A locked seat | A student views availability | The seat is not offered, and the lock reason is not disclosed to the student | `SEAT-FR-163`, `SEAT-FR-079` |
| `SEAT-AC-120` | A Reception user | A seat fault is reported | A `Reported` maintenance record is created and the seat's derived state does **not** become `Maintenance` | `SEAT-FR-166`, `SEAT-PO-012` |
| `SEAT-AC-121` | A seat with an active allocation | Maintenance is started | The actor must choose Retain, Relocate or Release; the system does not choose, and nothing is silently destroyed | `SEAT-FR-167`, `SEAT-BR-026` |
| `SEAT-AC-122` | A seat with an unexpired reservation | Maintenance is started | The reservation is cancelled with the cause recorded | `SEAT-BR-027`, `SEAT-FR-126` |
| `SEAT-AC-123` | A seat under maintenance | Availability counts, auto-assignment candidates and student availability are computed | The seat is excluded from all three | `SEAT-FR-169` |
| `SEAT-AC-124` | Maintenance has started and ended twice on a seat | The seat timeline is read | Both maintenance episodes appear in order | `SEAT-FR-170`, `SEAT-FR-227` |
| `SEAT-AC-125` | An import file of 100 rows where row 57 has a duplicate seat number | The import is submitted | No row is applied, and the response names row 57 and the reason | `SEAT-BR-028`, `SEAT-FR-172` |
| `SEAT-AC-126` | An import file referencing a zone that does not exist | It is submitted | Rejected; the import creates no `Floor` and no `Zone` | `SEAT-FR-174` |
| `SEAT-AC-127` | An import already applied under key `K` | The same file is submitted again with key `K` | No duplicate seat is created | `SEAT-FR-173` |
| `SEAT-AC-128` | An import of 2,001 rows | It is submitted | Rejected, naming the limit | `SEAT-FR-179` |
| `SEAT-AC-129` | A completed export | Its contents are inspected | Seat inventory and layout only — no student identifier, no membership data, no monetary value | `SEAT-FR-175`, `SEAT-FR-284` |
| `SEAT-AC-130` | A bulk reassignment of 10 seats where student 4 has no valid membership | It is submitted | No reassignment is applied; the gate ran per student per destination seat | `SEAT-BR-029`, `SEAT-FR-177` |
| `SEAT-AC-131` | Any completed bulk operation | Audit is inspected | Exactly one audit fact describes the operation, its actor, its scope and its row count | `SEAT-FR-178`, `SEAT-FR-285` |

### 33.10 Auto-assignment, QR, real-time and idempotency

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-132` | A student and a set of seats | Auto-assignment runs twice against identical state | It selects the same seat both times, applying the four criteria in the defined order | `SEAT-FR-182` |
| `SEAT-AC-133` | A student with no valid membership | Auto-assignment is requested | It fails; the candidate set is exactly the seats passing every gate step, so no gate is bypassed | `SEAT-FR-181`, `SEAT-XC-003` |
| `SEAT-AC-134` | No seat passes the gate for a student | Auto-assignment runs | It fails with a reason naming the most restrictive failing criterion | `SEAT-FR-183` |
| `SEAT-AC-135` | A tenant with auto-assignment available | Time passes with no staff action | No allocation is created — auto-assignment never runs unattended in V1 | `SEAT-FR-185` |
| `SEAT-AC-136` | A successful auto-assignment | The allocation is inspected | Origin is `AutoAssigned` and the selecting criteria are recorded | `SEAT-FR-184` |
| `SEAT-AC-137` | An unauthenticated party scans a seat QR code | The scan is processed | Nothing is assigned; the scan authenticates nobody | `SEAT-BR-030`, `SEAT-FR-187` |
| `SEAT-AC-138` | An authenticated student scans a seat QR code | The scan is processed | It is treated as a booking, subject to `SEAT-CFG-008` and the full gate | `SEAT-FR-189` |
| `SEAT-AC-139` | Authenticated staff scan a seat QR code | The scan is processed | The student must be selected explicitly; no student is inferred | `SEAT-FR-190`, `SEAT-FR-056` |
| `SEAT-AC-140` | A seat QR code is regenerated | The previous code is scanned | It is rejected as invalid | `SEAT-FR-191` |
| `SEAT-AC-141` | A student scans a seat QR code intending to record attendance | The scan is processed | No attendance record is created by this module | `SEAT-XC-012` |
| `SEAT-AC-142` | Two staff surfaces viewing one zone | A seat is assigned on the first | The second reflects the change without a manual refresh | `SEAT-FR-192`, `SEAT-NFR-006` |
| `SEAT-AC-143` | A real-time subscription for tenant `T1` | A seat changes in tenant `T2` | No update is delivered to the `T1` subscriber | `SEAT-FR-193`, `SEAT-INV-009` |
| `SEAT-AC-144` | A real-time payload | It is inspected | It carries derived state, lock flag and occupancy indicator only — no student identity | `SEAT-FR-195`, `SEAT-FR-276` |
| `SEAT-AC-145` | A client that missed real-time messages | It acts on its stale view | The authoritative check at the server rejects the invalid action; real-time was never the source of truth | `SEAT-FR-194` |
| `SEAT-AC-146` | Two concurrent transfers of the same student | Both run | Exactly one succeeds; the student never holds two seats in violation of quota | `SEAT-FR-197`, `SEAT-INV-002` |
| `SEAT-AC-147` | A lock cannot be acquired within the bounded timeout | The operation ends | It is reported as retryable, not as a permanent failure | `SEAT-FR-199` |
| `SEAT-AC-148` | A concurrent maintenance-start and acquisition on one seat | Both run | Exactly one outcome holds, and the seat is never both acquired and under maintenance for the same window | `SEAT-FR-200`, `SEAT-XC-001` |
| `SEAT-AC-149` | A request with idempotency key `K` that has already been processed | It is submitted again | Exactly one allocation, one history row and one event exist | `SEAT-FR-201`, `SEAT-FR-203`, `SEAT-BR-032` |
| `SEAT-AC-150` | A duplicate request submitted with **no** idempotency key | It is submitted | It is rejected by the invariants, not silently accepted | `SEAT-FR-204` |
| `SEAT-AC-151` | An idempotency key used in tenant `T1` | The same key value is used in tenant `T2` | Both operations proceed independently; keys are scoped per tenant and per operation | `SEAT-FR-202` |
| `SEAT-AC-152` | A retry that reaches the server twice | Both arrive | No second allocation, reservation or transfer row is created | `SEAT-XC-013` |

### 33.11 History, audit, notifications, metrics and search

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-153` | A released allocation | An edit or delete is attempted by any role including Owner | No such operation exists | `SEAT-INV-008`, `SEAT-XC-014` |
| `SEAT-AC-154` | Seat `A1` is released and later renumbered to `B7` | The released allocation is read | It shows `A1`, the number as at release | `SEAT-BR-034` |
| `SEAT-AC-155` | A chain of three transfers | Transfer history is read | It is produced by walking the allocation linkage; no separate transfer log exists that could disagree | `SEAT-FR-221`, `SEAT-BR-033` |
| `SEAT-AC-156` | A transfer chain, then a layout edit, a renumber and a category change | The chain is read | It is intact and unbroken | `SEAT-FR-222` |
| `SEAT-AC-157` | An allocation ended other than by transfer | It is read | It carries a release reason from the closed nine-value set | `SEAT-FR-223` |
| `SEAT-AC-158` | A seat with allocations, reservations, locks and maintenance episodes | Its timeline is read | All appear in one chronological order by recorded fact time, rebuildable from stored data with no separate write path | `SEAT-FR-227`, `SEAT-FR-228`, `SEAT-FR-229` |
| `SEAT-AC-159` | A student views their own history | The view is rendered | It is restricted to their own allocations and reveals no other student | `SEAT-FR-230`, `SEAT-FR-275` |
| `SEAT-AC-160` | Any protected operation completes | Audit is inspected | Exactly one audit fact was emitted over `E-20`, asynchronously, and the operation did not wait for it | `SEAT-FR-233`, `SEAT-FR-234`, `SEAT-NFR-008` |
| `SEAT-AC-161` | A protected operation is **denied** | Audit is inspected | The denial is audited even though the caller's response discloses nothing | `SEAT-FR-236`, `SEAT-FR-283` |
| `SEAT-AC-162` | An audit fact | Its payload is inspected | No student name, contact detail, `PersonId` or membership amount is present | `SEAT-FR-235` |
| `SEAT-AC-163` | Any module screen or report | It is rendered | `BC-24`'s store was not read to produce it | `SEAT-FR-237` |
| `SEAT-AC-164` | Audit emission fails transiently | The operation completes | The operation succeeds and the audit fact is delivered eventually by the outbox, not dropped | `SEAT-NFR-008` |
| `SEAT-AC-165` | Any notifiable seat fact | The module acts | No SMS, push, email or template is produced, and no delivery state is stored or displayed | `SEAT-FR-238`, `SEAT-XC-016`, `SEAT-XC-017` |
| `SEAT-AC-166` | The full set of events this module emits | It is enumerated | It is exactly the four of `SEAT-EVT-001`…`004`; no command-shaped event exists | `SEAT-FR-206`, `SEAT-BR-035` |
| `SEAT-AC-167` | Any emitted event | Its payload is inspected | It carries `tenantId` and, where a student is involved, `StudentRecordId` — never a name, contact detail or `PersonId` | `SEAT-FR-208`, `SEAT-FR-209` |
| `SEAT-AC-168` | A lock, unlock, maintenance start, maintenance end, reservation creation or reservation expiry | It occurs | No domain event is emitted, and the fact appears in the corresponding work queue | `SEAT-FR-210`, `SEAT-FR-240` |
| `SEAT-AC-169` | Occupancy at 88% with the threshold at its default 90% | Occupancy rises to 91% and then to 95% | `SEAT-EVT-004` is emitted once, on the crossing, not on every change while above | `SEAT-FR-242`, `SEAT-CFG-017` |
| `SEAT-AC-170` | No occupancy threshold configured | Occupancy rises to 100% | No `SEAT-EVT-004` is emitted | `SEAT-FR-241`, `SEAT-GAP-005` |
| `SEAT-AC-171` | A work queue containing flagged allocations | Time passes with no staff action | Nothing is released, converted or altered — a queue never acts | `SEAT-FR-217` |
| `SEAT-AC-172` | `policy.BranchPolicyChanged` is consumed | Existing allocations are inspected | `SeatRules` are re-read and no existing allocation, reservation or counted transfer is retroactively re-evaluated | `SEAT-FR-215`, `SEAT-FR-264` |
| `SEAT-AC-173` | A zone with 100 seats, 70 allocated, 40 holders checked in | Metrics are read | Allocation rate and occupancy rate are two distinct labelled figures, 70% and 40%, never conflated into one | `SEAT-FR-245` |
| `SEAT-AC-174` | Any operational metric | It is read | It carries an as-of time and is computed from current state by a single query | `SEAT-FR-246`, `SEAT-FR-247` |
| `SEAT-AC-175` | A request for an occupancy trend, a peak hour or a forecast | It is made of this module | It is not served here; `BC-26` answers it from the emitted events | `SEAT-XC-018`, `SEAT-FR-248` |
| `SEAT-AC-176` | An unauthenticated public visitor | The public library profile is viewed | No per-seat identity, per-seat state or live per-seat occupancy is exposed | `SEAT-FR-250`, `SEAT-XC-009`, `SEAT-XC-020` |
| `SEAT-AC-177` | A search by seat number, zone, floor, category, type and state in turn | Each is run | Each returns the matching seats, confined to the caller's tenant and permitted scope | `SEAT-FR-251`, `SEAT-FR-254` |
| `SEAT-AC-178` | A search for a student's seat by `StudentRecordId` | It is run | The current allocation is returned | `SEAT-FR-252` |
| `SEAT-AC-179` | A search by student **name** | It is run | The name is resolved through the authoritative upstream context; no name is stored or indexed here | `SEAT-FR-253`, `SEAT-FR-278` |
| `SEAT-AC-180` | An identical query, state and caller | It is run twice | The same ordered result is returned both times | `SEAT-FR-255`, `SEAT-FR-261` |
| `SEAT-AC-181` | A student issuing a seat search | It is run | It cannot be used to enumerate other students | `SEAT-FR-256`, `SEAT-FR-275` |
| `SEAT-AC-182` | Each of the twelve filter presets in turn | It is applied | Each resolves to its published predicate over existing state, with no new stored field | `SEAT-FR-257`, `SEAT-FR-258` |
| `SEAT-AC-183` | A filter preset saved in tenant `T1` | Tenant `T2` lists presets | It is not visible | `SEAT-FR-259`, `SEAT-FR-293` |
| `SEAT-AC-184` | A fuzzy, phonetic or relevance-ranked seat search | It is attempted | It is not offered; `BC-04` is not a search-index producer | `SEAT-XC-021`, `SEAT-FR-262` |

### 33.12 Configuration, permissions and multi-tenancy

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-185` | Every configurable in §27.1 | The register is inspected | Each has exactly one owner, exactly one default and one defining requirement | `SEAT-BR-037` |
| `SEAT-AC-186` | A configurable that is unset | An operation reads it | The published default applies; no operation fails for want of configuration | `SEAT-FR-265`, `SEAT-NFR-005` |
| `SEAT-AC-187` | A tenant that has configured nothing | Every operation in this document is exercised | All behave per their published defaults, satisfying `LIB-16.2` | `SEAT-FR-265` |
| `SEAT-AC-188` | Configuration is read | The mechanism is inspected | It uses `BC-25` typed accessors over `E-19`; no raw string lookup exists | `SEAT-FR-263` |
| `SEAT-AC-189` | An allocation created under a 3-transfer limit | The limit is reduced to 1 | The existing allocation and its already-counted transfers are unaffected | `SEAT-FR-264` |
| `SEAT-AC-190` | Any configurable value | It is set to any permitted value | No invariant of §7, no gate step of §8 and no `MUST` in this document is disabled | `SEAT-FR-301`, `SEAT-XC-022` |
| `SEAT-AC-191` | `maxTransfersPerDay` and `reservationWindow` | Their source is inspected | Both arrive over `E-05` from `BC-06` and are not tenant settings of this module | `SEAT-FR-266` |
| `SEAT-AC-192` | The set of protected operations | It is enumerated | It is exactly the 24 of §28.2; an operation not listed does not exist | `SEAT-FR-272` |
| `SEAT-AC-193` | Every protected operation | It is invoked | Authorisation is evaluated **before** the acquisition gate, so an unauthorised caller learns nothing about seat or membership state | `SEAT-FR-271`, `SEAT-FR-282` |
| `SEAT-AC-194` | A Reception user | Any revenue, fee, price or financial figure is sought on a seat surface | None exists anywhere in the module for any role | `SEAT-BR-038`, `SEAT-FR-279` |
| `SEAT-AC-195` | Any role including Owner | An attempt is made to override gate step G7, `SEAT-INV-001`, a history record or tenant isolation | Every attempt is denied; no such affordance exists | `SEAT-BR-040`, `SEAT-BR-014` |
| `SEAT-AC-196` | A Platform Support actor | The protected-operation list is evaluated | No operation is held by default | `SEAT-FR-273` |
| `SEAT-AC-197` | A parent or guardian | Any protected operation is attempted | All are denied; the guardian may read their own student's seat information only | `SEAT-FR-274` |
| `SEAT-AC-198` | The module's stored fields, caches and indexes | They are inspected | No student name, photograph, contact detail, guardian data, fee or attendance record is present | `SEAT-FR-010`, `SEAT-FR-278` |
| `SEAT-AC-199` | A student requesting a seat resource belonging to another student | The request is made | The denial is indistinguishable from not-found in message, status code and the absence of any existence signal | `SEAT-FR-281`, `SEAT-FR-282` |
| `SEAT-AC-200` | An export attempted by Reception, a student or a guardian | It is requested | Denied in every form | `SEAT-FR-286` |
| `SEAT-AC-201` | Every seat, layout version, category, allocation, reservation, lock, maintenance record and filter preset | Its row is inspected | Each carries `tenantId` | `SEAT-FR-287` |
| `SEAT-AC-202` | Any query or mutation | It is executed | It is filtered by the resolved `tenantId`; an unfiltered query cannot be expressed | `SEAT-INV-009` |
| `SEAT-AC-203` | Tenant context cannot be resolved | An operation is attempted | It fails loudly; no default or fallback tenant is used | `SEAT-FR-289`, `SEAT-FR-290` |
| `SEAT-AC-204` | A caller in tenant `T1` referencing a seat in tenant `T2` | The request is made | It is treated as not-found, not as forbidden | `SEAT-FR-294`, `SEAT-INV-010` |
| `SEAT-AC-205` | Tenant `T1` and tenant `T2` each with a seat numbered `A1` | Both are read | Both exist independently with no collision | `SEAT-FR-292` |
| `SEAT-AC-206` | A tenant at its seat-inventory entitlement limit | A further seat is created | Rejected via `E-17`, checked **before** the aggregate mutates, failing closed | `SEAT-FR-295`, `SEAT-FR-296` |
| `SEAT-AC-207` | A suspended tenant | Any write in this module is attempted | Every write is rejected; reads behave per `BC-19` | `SEAT-INV-011` |
| `SEAT-AC-208` | Any global index, cross-tenant surface or global cache key | It is inspected | No `StudentRecordId` appears in it | `SEAT-FR-291` |

### 33.13 Governing rules, remaining invariants and remaining exclusions

These criteria exist so that the coverage promise of `SEAT-FR-302` is true rather than aspirational. Each covers a
rule whose subject is the document's own consistency, a structural invariant, or an exclusion whose evidence is an
absence.

| ID | Given | When | Then | Verifies |
|---|---|---|---|---|
| `SEAT-AC-209` | Any requirement, event payload or user-facing label in the module | Its terminology is inspected | It uses the §2 vocabulary; a bare "Seat", "Status", "Room" or "Shift" in a cross-context contract is treated as a defect | `SEAT-BR-001` |
| `SEAT-AC-210` | A proposed requirement that would duplicate a responsibility in the §3 ownership table | It is raised | It is recorded as a defect and raised, not implemented | `SEAT-BR-002`, `SEAT-BR-044` |
| `SEAT-AC-211` | A seat at any moment, including mid-import and mid-layout-edit | Its containers are inspected | It belongs to exactly one `Zone`, that `Zone` to exactly one `Floor`, that `Floor` to exactly one `Branch`; no orphan is representable at any point | `SEAT-BR-003`, `SEAT-INV-012` |
| `SEAT-AC-212` | A tenant with booking mode set | The effective configuration is inspected | Exactly one mode is in force; two modes cannot be simultaneously effective | `SEAT-BR-018` |
| `SEAT-AC-213` | A seat with an unexpired reservation | A second reservation for an overlapping window is attempted | Rejected under gate G15 | `SEAT-BR-021`, `SEAT-INV-004` |
| `SEAT-AC-214` | An allocation referencing a seat, zone or floor that does not exist | It is written | Rejected; a dangling reference is not representable | `SEAT-INV-006`, `SEAT-INV-014` |
| `SEAT-AC-215` | The module's rule set | It is inspected for plan-to-category mappings | The module evaluates the rule and authors none; the mapping lives in `BC-02` | `SEAT-BR-023`, `SEAT-FR-147` |
| `SEAT-AC-216` | A figure computed by aggregating over a period, comparing periods or retaining a series | It is requested of this module | It is not served here; only current-state figures are | `SEAT-BR-036`, `SEAT-XC-018` |
| `SEAT-AC-217` | A figure needed both operationally and analytically | Both are produced | This module publishes the facts and `BC-26` defines the metric; no metric is defined twice | `SEAT-XC-019` |
| `SEAT-AC-218` | A Manager | Locking, maintenance control and bulk operations are attempted | All are permitted, matching the seating-oversight remit | `SEAT-BR-039`, `SEAT-PO-011`, `SEAT-PO-013` |
| `SEAT-AC-219` | An operation to which tenancy, authorisation, idempotency, the gate, invariants and side effects all apply | It is executed | They are evaluated in exactly that order, so an unauthorised caller in the wrong tenant learns nothing | `SEAT-BR-041`, `SEAT-FR-271` |
| `SEAT-AC-220` | A conflict between this document and a higher-authority document | It is discovered | It is recorded in §31 as a gap; it is not resolved in this document | `SEAT-BR-044`, `SEAT-FR-302` |
| `SEAT-AC-221` | A gap in §31 that blocks a build-time decision | Implementation reaches it | It is escalated; no behaviour is picked to unblock it | `SEAT-BR-045` |
| `SEAT-AC-222` | A user interface offering an override | It is inspected | Reservation override and membership override are never presented as one action, and no membership override exists | `SEAT-XC-006`, `SEAT-XC-004` |
| `SEAT-AC-223` | Audit retention, legal hold, purge or tamper-evidence | It is sought in this module | None is defined here; `BC-24` owns them | `SEAT-XC-015` |
| `SEAT-AC-224` | An allocation is released | `SEAT-EVT-002` is inspected | It is emitted exactly once, carrying tenant context and the release reason available to its consumers | `SEAT-EVT-002`, `SEAT-FR-223` |
| `SEAT-AC-225` | A transfer completes | `SEAT-EVT-003` is inspected | It is emitted exactly once for the transfer, not once per allocation row | `SEAT-EVT-003`, `SEAT-FR-065` |

### 33.14 Coverage statement

`SEAT-FR-302` — Every `SEAT-BR-*`, `SEAT-INV-*`, `SEAT-EVT-*` and `SEAT-XC-*` identifier in this document **MUST** be
cited by at least one `SEAT-AC-*` criterion. A rule with no criterion is, per `MM-NFR-014`, *"a rule that cannot be
checked"* and **SHALL** be treated as unmet.

`SEAT-FR-303` — Where a `SEAT-FR-*` requirement is a statement of ownership or exclusion whose only observable
consequence is the **absence** of a capability, the absence itself **MUST** be the criterion, as in `SEAT-AC-009`,
`SEAT-AC-104` and `SEAT-AC-112`. An unobservable requirement **MUST NOT** be published (`SEAT-NFR-011`).

---
## 34. V1 scope classification

Every change this review makes to the source draft is classified below. The categories are those the review asked
for. Nothing appears in this document that is not classified here, and nothing classified **V2**, **V3**, **Future**
or **Not recommended** carries a requirement identifier anywhere in this document — a deferred feature that still had
requirements would be V1 by the back door.

### 34.1 Required V1 corrections

Each of these fixes something in the draft that would have shipped a defect. None adds a feature.

| # | Correction | Why it was required | Where |
|---|---|---|---|
| 1 | `Room` realised as the existing `Zone`, with a configurable tenant label | "Room" appears nowhere in the BC Map, Master PRD or Library PRD. Creating a fourth container would have created a second spatial hierarchy the rest of the platform cannot address | §4.1, `SEAT-FR-013`, `SEAT-FR-014` |
| 2 | `Locked` removed from the status set; made an orthogonal flag | Five statuses where one is a modifier of the other four makes `Occupied + Locked` unrepresentable, so locking an occupied seat would have had to release its student | §6, `SEAT-FR-038` |
| 3 | `SeatState` derived from five stored facts rather than stored | A stored status can disagree with the facts beneath it, and there is then no rule for which wins | §6, `SEAT-BR-010`, `SEAT-XC-002` |
| 4 | Booking, reservation and assignment separated, with one closed configurable deciding the outcome | The draft used the three terms interchangeably. The seven review questions cannot be answered while they are one concept | §12, `SEAT-CFG-010` |
| 5 | Membership expiry, current student, current shift and join date removed from the seat record | Storing a `BC-02` value on a seat makes this module a second home for it. `MM-FR-025` shows why that is unsafe. The data remains fully visible, composed at read time | §5.1, §13, `SEAT-FR-025` |
| 6 | One ordered acquisition gate for all eight acquisition paths | The draft stated eligibility rules per feature, which permits one path to omit a check another applies | §8, `SEAT-FR-052` |
| 7 | Audit realised as emission over `E-20`, not a module-owned immutable store | `BC-24` owns *"the immutable append-only record of who did what"*. A second store would be a second answer to the same question | §23.5, `SEAT-FR-232` |
| 8 | Transfer history derived from bidirectional allocation linkage, not a separate log | Two records of one fact can disagree, and no rule would say which wins | §23.3, `SEAT-FR-221` |
| 9 | Notifications reduced to facts; the event set closed at four | `BC-22` owns channels, templates, quiet hours and delivery. BC Map §9 fixes this module's events at four | §24, `SEAT-FR-206`, `SEAT-BR-035` |
| 10 | Analytics reduced to current-state counts, with the boundary set at *time* | `BC-26` owns the metric layer. Without a testable boundary, "occupancy analytics" grows into a second analytics module | §25, `SEAT-BR-036` |
| 11 | Allocation rate and occupancy rate separated into two labelled figures | Conflating them yields a number that is wrong in one sense whichever way it is read | `SEAT-FR-245` |
| 12 | Public live occupancy deferred, with the aggregate indicator retained | `ARCHITECTURE_RULINGS.md` §6 and `LIB-24.2` defer it to V2 pending a privacy review | `SEAT-XC-020`, `SEAT-FR-117` |
| 13 | `Floor` and `Zone` made read-only here; creation and naming left to `BC-06` | `LIB-10.*` and `LIB-11.*` own them. `LIB-11.5` says assignment is this module's and the container is not | `SEAT-FR-015` |
| 14 | Shift definitions consumed from `BC-06`, never authored | `LIB-16.4` assigns shift configuration to `BC-06` | §16.3, `SEAT-FR-136` |
| 15 | Seat QR separated from attendance QR | A seat QR that records attendance would make this module an attendance writer, which `BC-03` owns | `SEAT-XC-012` |
| 16 | Zone or floor change of a seat treated as a container change, not repositioning | The draft's free repositioning would silently move a seated student between containers | `SEAT-FR-297` |
| 17 | Retain-and-flag adopted wherever an upstream fact invalidates a live allocation | Automatic release of a seated student on an upstream change is a physical-world eviction that cannot be compensated | `SEAT-BR-042`, `SEAT-BR-043` |

### 34.2 Existing V1 requirement clarifications

These were already in the draft. The review made them deterministic; it did not add or remove capability.

| # | Requirement | What was ambiguous | Now |
|---|---|---|---|
| 1 | Reservation expiry | *"expires after a period"* | Explicit `expiresAt`, derived at read time, no background job required (`SEAT-FR-092`, `SEAT-FR-095`) |
| 2 | Auto-cancellation | *"cancelled when appropriate"* | Six named conditions, cause recorded (`SEAT-FR-125`, `SEAT-FR-126`) |
| 3 | Max transfers per day | limit stated, source unstated | Owned by `BC-06` over `E-05`, override grant named, system moves excluded (`SEAT-BR-017`, `SEAT-FR-067`) |
| 4 | Eligibility | *"based on membership"* | Evaluated at acquisition and conversion only; absent list means permit; five change cases tabulated (`SEAT-FR-147`…`150`) |
| 5 | Auto assignment | *"assigns a suitable seat"* | Four ordered criteria, deterministic, staff-invoked (`SEAT-FR-182`, `SEAT-FR-185`) |
| 6 | Bulk import | *"validates rows"* | Validated in full before any row applies; all-or-nothing; idempotent by key (`SEAT-BR-028`, `SEAT-FR-173`) |
| 7 | Maintenance on an occupied seat | unstated | Three explicit dispositions chosen by a human (`SEAT-FR-167`) |
| 8 | Real-time sync | *"updates in real time"* | An optimisation, never the source of truth; tenant-scoped; identity-free payload (`SEAT-FR-194`, `SEAT-FR-195`) |
| 9 | Seat timeline | *"shows history"* | A derived read model over five existing stores, with no write path of its own (`SEAT-FR-227`, `SEAT-FR-228`) |
| 10 | Smart filters | *"useful filters"* | Twelve presets, each an exact predicate over existing state (`SEAT-FR-258`) |
| 11 | Search by student | *"search by student name"* | Name resolved upstream at query time; no name stored or indexed here (`SEAT-FR-253`) |
| 12 | Owner configuration | a list of settings | Eighteen configurables, each with one owner, one default and one defining requirement (§27.1) |
| 13 | Role permissions | four prose lists | Twenty-four protected operations in one closed table (§28.2) |
| 14 | Seat booking dates | *"booking dates"* | Mandatory explicit window, no past start, bounded by `reservationWindow` and membership `validUntil` (§11.1) |
| 15 | Fixed vs flexible | *"flexible seats are shared"* | Shared only in non-overlapping windows; change of type in both directions specified (`SEAT-FR-133`…`135`) |
| 16 | Concurrency | *"handle conflicts"* | Database constraint plus pessimistic lock, never optimistic; two lock ordering specified (`SEAT-BR-011`, `SEAT-FR-198`) |

### 34.3 V2 — deliberately not in this document

None of these carries a requirement identifier here.

| # | Feature | Why not V1 |
|---|---|---|
| 1 | Waiting list for an unavailable seat | A queue needs fairness, notification and expiry rules of its own, and every one of them depends on `BC-22`, which V1 does not integrate for reminders (`SEAT-FR-101`, `SEAT-XC-005`) |
| 2 | Unattended scheduled auto-allocation | Automatic seating without a human in the loop can evict or misplace at scale; V1 keeps auto-assignment staff-invoked (`SEAT-FR-185`) |
| 3 | Proactive reservation-expiry reminders | Requires a notification carrier this module is not permitted to invent; BC Map §9 fixes the event set at four (`SEAT-FR-240`, `SEAT-GAP-005`) |
| 4 | Public live occupancy, per-seat or as a busy/moderate/quiet indicator | Deferred by `ARCHITECTURE_RULINGS.md` §6 and `LIB-24.2` pending a privacy review, and *"must not be invented"* (`SEAT-XC-020`, `SEAT-GAP-014`) |
| 5 | Arbitrary boolean filter expressions | V1 is AND-only; a general expression builder is a query-language feature, not a seating feature (`SEAT-FR-260`) |
| 6 | Membership freeze handling as a live workflow | Freeze itself is V2 per `MM-GAP-010`; `SEAT-FR-156` is inert until the event exists (`SEAT-GAP-004`) |
| 7 | Seat-level pricing or premium surcharge | Money is `BC-05`'s and plan pricing is `BC-02`'s; `LIB-11.4` places zone pricing in the plan (`SEAT-FR-144`) |
| 8 | Floor-scoped or zone-scoped staff permissions | `MP-GBR-21` closes the scope register; adding a scope is a platform decision (`SEAT-FR-269`, `SEAT-GAP-006`) |

### 34.4 V3 and Future

| # | Feature | Category | Why |
|---|---|---|---|
| 1 | Per-seat or per-student policy overrides | V3 | Every configurable in V1 is tenant-level. Per-entity overrides multiply the state space and make a denial hard to explain (`SEAT-XC-022`) |
| 2 | 3D layout as a required capability | Future | Optional in V1 by `SEAT-FR-035`; making it mandatory is a product decision, not a correction |
| 3 | Seat recommendation based on a student's history | Future | Requires behavioural analytics `BC-26` does not yet publish |
| 4 | Cross-branch seat search and allocation | Future | Requires a branch-spanning availability model no context currently owns |

### 34.5 Not recommended

| # | Suggestion | Why not |
|---|---|---|
| 1 | An override that permits seating without a valid membership | `MP-GBR-16` and `SEAT-BR-014` make G7 absolute for every role. An override would contradict a Rank 1 global rule |
| 2 | A module-owned immutable audit store | Duplicates `BC-24`; two append-only records of one action can disagree |
| 3 | A stored `SeatState` column for query performance | Reintroduces the contradiction §6 removes. `SEAT-NFR-012` accepts read-time derivation as the deliberate trade |
| 4 | Optimistic concurrency on allocation | `MP-GBR-17` and BC Map §10.1 forbid it: double allocation is *"a physical-world conflict that cannot be compensated"* |
| 5 | Deleting a seat, allocation or history row | Append-only is required for history to be answerable at all (`SEAT-XC-014`) |
| 6 | Storing the student's name on the seat for display speed | `SEAT-FR-010` and `MP-GBR-03` forbid it; the seat card composes it |
| 7 | Letting this module extend or renew a membership from a seat screen | `SEAT-FR-157` forbids writing to `BC-02`; a deep link is permitted |
| 8 | An occupancy trend chart in this module | `BC-26` owns it, and `SEAT-XC-019` forbids defining a metric twice |

---

## 35. Change log against the source draft

Five substantive changes were made to the draft's stated design. Each is recorded with its reason, as the review
required. Everything else in the draft was preserved, clarified or reorganised, not changed.

**C-1 — "Room" is realised as the existing `Zone`, with a configurable label.**
The draft introduced `Room` as a container between `Floor` and `Seat`. The term appears nowhere in the BC Map, the
Master PRD or the Library PRD, while `Zone` is already defined there with exactly that role (`LIB-11.1`: *"a `Zone`
MUST belong to exactly one `Floor`"*). Inventing a fourth container would have created a spatial hierarchy no other
context can address, and would have required this module to own containers `LIB-11.5` assigns elsewhere. **No
capability is lost:** a tenant that wants the word "Room" configures it (`SEAT-FR-014`) and every draft requirement
about rooms is satisfied by zones.

**C-2 — `Locked` is not a seat status.**
The draft listed four statuses and also described locking as a state. Modelling `Locked` as a fifth status makes
`Occupied + Locked` unrepresentable, which would force locking an occupied seat to release its student — the opposite
of the draft's intent. It is now an orthogonal flag that suppresses acquisition only (`SEAT-FR-038`,
`SEAT-BR-025`), and `SEAT-FR-161` guarantees a lock can never trap a student. **No capability is lost.**

**C-3 — Membership expiry, current student, current shift and join date are not seat fields.**
The draft listed them on the seat record. Storing a `BC-02` value on a seat makes this module a second home for it;
`PRD-004` `SM-2.4` forbids the analogous case, and `MM-FR-025` shows that a copied quota diverges from its source.
All four remain fully visible on the seat card, composed at read time from the authoritative context and labelled
with an as-of time (§13, `SEAT-FR-104`, `SEAT-FR-105`). **No capability is lost; the data is read, not owned.**

**C-4 — Booking, reservation and assignment are three distinct concepts governed by one configurable.**
The draft used the words interchangeably, which left the seven review questions unanswerable and would have produced
different behaviour on different screens. They are now defined separately (`SEAT-FR-085`), and the outcome of a
student booking is decided by a single closed-valued tenant setting, `SEAT-CFG-010`, with `ApprovalRequired` as the
default (`SEAT-FR-086`). Every behaviour the draft described is reachable through one of the three modes. **No
capability is lost; the ambiguity is.**

**C-5 — Public live occupancy is deferred to V2 by existing ruling.**
The draft implied a public availability view. `ARCHITECTURE_RULINGS.md` §6, `LIB-24.2` and `LIB-14B.13` defer public
live occupancy to V2 pending a privacy review and state it *"must not be invented"*. This document therefore excludes
it (`SEAT-XC-020`) while retaining `LIB-7.3`'s aggregate seat capacity and permitting a coarse aggregate indicator
for the public profile (`SEAT-FR-117`). Staff-facing live occupancy — the operational capability the draft actually
needed — is fully specified (§25). **The deferral is a higher-authority decision this document records rather than
overrides**, and the residual question is `SEAT-GAP-014`.

---
## 36. Completeness checklist — every original V1 capability

This section exists to answer one question mechanically: **was any capability in the source draft dropped?** Each row
names a capability from the draft and the requirement that carries it in this document. A row with no requirement
would be a dropped capability; there are none.

Where the realisation differs from the draft's wording, the **Note** column says how, and every such difference is one
of the five changes in §35 or a clarification in §34.2.

| # | Original V1 capability | Carried by | Note |
|---|---|---|---|
| 1 | 2D layout management, mandatory | `SEAT-FR-035` | Unchanged |
| 2 | 3D layout, optional | `SEAT-FR-035`, `SEAT-FR-005` | Optional; its absence limits nothing |
| 3 | Floors | `SEAT-FR-013`, `SEAT-FR-016`…`019` | Read from `BC-06`; C-1 |
| 4 | Rooms | `SEAT-FR-013`, `SEAT-FR-014` | Realised as `Zone` with a configurable label; C-1 |
| 5 | Drag-and-drop layout editor | `SEAT-FR-029`, `SEAT-FR-030` | Unchanged |
| 6 | Walls, doors, tables, pillars | `SEAT-FR-031`, `SEAT-FR-032` | Unchanged; non-allocatable |
| 7 | Layout versioning and save | `SEAT-FR-021`, `SEAT-FR-022`, `SEAT-FR-033` | Unchanged |
| 8 | Unique seat identifiers | `SEAT-FR-023`, `SEAT-BR-004`, `SEAT-BR-005` | Internal identity separated from display number |
| 9 | Four seat statuses | `SEAT-FR-037`, `SEAT-FR-040`…`043` | All four retained; derived, not stored; C-2, C-3 |
| 10 | Seat assignment by reception | `SEAT-FR-055`, `SEAT-PO-001` | Unchanged |
| 11 | Seat release | `SEAT-FR-059`…`061`, `SEAT-PO-002` | Unchanged |
| 12 | Seat transfer | `SEAT-FR-062`…`067`, `SEAT-PO-003` | Unchanged |
| 13 | Seat change requests | `SEAT-FR-068`…`075`, `SEAT-PO-004` | Unchanged |
| 14 | Owner controls | §28.2, `SEAT-PO-001`…`024` | All retained in the closed table |
| 15 | Manager controls | `SEAT-BR-039`, §28.2 | Retained; bounded per Authentication `TR-2` |
| 16 | Reception controls | `SEAT-BR-038`, §28.2 | Retained; no financial data per `BR-2.12` |
| 17 | Student controls | `SEAT-FR-076`…`079`, `SEAT-FR-277` | Retained; `self` scope only |
| 18 | Seat card | `SEAT-FR-103`…`107` | All fields retained; membership composed not stored; C-3 |
| 19 | Student self-booking | `SEAT-FR-076`…`084`, `SEAT-PO-005` | Retained; disabled by default |
| 20 | Seat booking dates | §11.1, `SEAT-FR-080`…`083` | Retained and made mandatory and bounded |
| 21 | Fixed seats | `SEAT-FR-131`, `SEAT-FR-132` | Unchanged |
| 22 | Flexible seats | `SEAT-FR-133`, `SEAT-BR-022` | Unchanged |
| 23 | Shift integration | §16.3, `SEAT-FR-136`…`141` | Retained; definitions consumed from `BC-06` per `LIB-16.4` |
| 24 | Seat categories | `SEAT-FR-142`…`146` | Retained; no money on a category |
| 25 | Eligibility rules | `SEAT-FR-147`…`150`, `SEAT-BR-023` | Retained; evaluated here, authored in `BC-02` |
| 26 | Membership-based access | `SEAT-BR-014` (G7), §18 | Retained and made absolute |
| 27 | Membership integration | §18, `SEAT-FR-151`…`157` | Retained; consumed via `E-02`, never recreated |
| 28 | Seat reservation | §15, `SEAT-FR-118`…`130` | Unchanged |
| 29 | Reservation expiry | `SEAT-FR-092`…`095` | Retained; explicit and read-time derived |
| 30 | Reservation auto-cancel | `SEAT-FR-125`, `SEAT-FR-126` | Retained; six named conditions |
| 31 | Reservation approval workflow | `SEAT-FR-127`…`130`, `SEAT-PO-008` | Unchanged |
| 32 | Automatic assignment | `SEAT-FR-180`…`185`, `SEAT-PO-017` | Retained; deterministic and staff-invoked |
| 33 | QR-based assignment | `SEAT-FR-186`…`191` | Retained; separated from attendance QR |
| 34 | Seat locking | `SEAT-FR-158`…`163`, `SEAT-PO-009` | Retained as an orthogonal flag; C-2 |
| 35 | Maintenance mode | `SEAT-FR-164`…`170`, `SEAT-PO-011` | Unchanged |
| 36 | Maintenance workflow | `SEAT-FR-166`…`168`, `SEAT-BR-026` | Retained; three explicit dispositions |
| 37 | Bulk import | `SEAT-FR-171`…`174`, `SEAT-PO-013` | Retained; all-or-nothing and idempotent |
| 38 | Bulk export | `SEAT-FR-175`, `SEAT-PO-014` | Retained; inventory only |
| 39 | Bulk reassignment | `SEAT-FR-176`, `SEAT-BR-029`, `SEAT-PO-015` | Retained; gate per student per seat |
| 40 | Search by seat | `SEAT-FR-251` | Unchanged |
| 41 | Search by student | `SEAT-FR-252`, `SEAT-FR-253` | Retained; names resolved upstream |
| 42 | Smart filters | `SEAT-FR-257`, `SEAT-FR-258` | Retained; twelve exact predicates |
| 43 | Real-time sync | `SEAT-FR-192`…`195` | Retained; advisory, never authoritative |
| 44 | Live occupancy | §14.3, `SEAT-FR-109`…`117` | Retained; staff-facing. Public view is V2 by ruling; C-5 |
| 45 | Occupancy analytics | §25, `SEAT-FR-244`…`249` | Current-state counts retained here; period analytics belong to `BC-26` |
| 46 | Seat timeline | `SEAT-FR-227`…`231` | Retained as a derived read model |
| 47 | Transfer history | `SEAT-FR-220`…`222` | Retained; derived from allocation linkage |
| 48 | Assignment history | `SEAT-FR-218`, `SEAT-FR-219`, `SEAT-BR-034` | Retained; append-only |
| 49 | Notifications | §24, `SEAT-FR-239` | Facts retained; delivery is `BC-22`'s |
| 50 | Owner configuration | §27.1, eighteen configurables | Retained; each with one owner and one default |
| 51 | Max transfers per day | `SEAT-BR-017`, `SEAT-FR-066`, `SEAT-FR-067` | Retained; owned by `BC-06` |
| 52 | Audit log | §23.5, `SEAT-FR-232`…`237` | Every fact retained; storage is `BC-24`'s |
| 53 | Role permissions, all four roles | §28.2, `SEAT-BR-038`…`040` | All four retained in one closed table |
| 54 | Concurrency safety | §21, `SEAT-BR-011`, `SEAT-BR-031` | Retained; pessimistic, never optimistic |
| 55 | Operation priority rules | `SEAT-BR-041` | Retained as an explicit order |
| 56 | Configuration behaviour | `SEAT-FR-263`…`265`, `SEAT-FR-301` | Retained; never retroactive, never disables a `MUST` |
| 57 | Success criteria | `SEAT-FR-003`, §33 | Realised as 225 acceptance criteria |
| 58 | Out of scope / product boundary | §3.2, twenty-two `SEAT-XC-*` | Retained and made explicit per context |

### 36.1 The eighteen original business rules

The draft's `BR-001`…`BR-018` are carried as follows. None was dropped; several were split because one draft rule
combined two testable statements.

| Draft rule | Carried by |
|---|---|
| `BR-001` one active allocation per seat | `SEAT-BR-011`, `SEAT-INV-001` |
| `BR-002` valid membership required | `SEAT-BR-014` (G7), `SEAT-FR-151` |
| `BR-003` seat number unique | `SEAT-BR-005`, `SEAT-BR-006` |
| `BR-004` status transitions | `SEAT-FR-044`, `SEAT-FR-045` |
| `BR-005` fixed vs flexible sharing | `SEAT-FR-132`, `SEAT-FR-133`, `SEAT-BR-022` |
| `BR-006` reservation expiry | `SEAT-FR-092`…`095` |
| `BR-007` eligibility by category | `SEAT-FR-147`, `SEAT-FR-150` |
| `BR-008` transfer limit | `SEAT-BR-017`, `SEAT-FR-066` |
| `BR-009` maintenance blocks allocation | `SEAT-FR-043`, `SEAT-FR-169` |
| `BR-010` lock blocks allocation | `SEAT-BR-025`, `SEAT-FR-160`, `SEAT-FR-161` |
| `BR-011` release requires reason | `SEAT-FR-060`, `SEAT-FR-224` |
| `BR-012` history immutable | `SEAT-INV-008`, `SEAT-XC-014` |
| `BR-013` bulk operations atomic | `SEAT-BR-028`, `SEAT-FR-177` |
| `BR-014` suspension releases seat | `SEAT-BR-013`, `SEAT-BR-043`, `SEAT-FR-125` |
| `BR-015` one reservation per student | `SEAT-FR-121`, `SEAT-INV-005` |
| `BR-016` layout edit safety | `SEAT-BR-008`, `SEAT-FR-034` |
| `BR-017` audit every change | `SEAT-FR-234`, `SEAT-FR-236` |
| `BR-018` tenant isolation | `SEAT-INV-009`, `SEAT-INV-010`, `SEAT-FR-287` |

### 36.2 Verdict on completeness

`SEAT-FR-304` — No capability present in the source draft has been removed from this document. Where a capability's
**realisation** changed, the change is one of the five in §35, each justified by a higher-authority document, and the
capability itself survives. Where a capability was **deferred**, the deferral is an existing platform ruling recorded
in §34.3, not a decision taken here.

---
