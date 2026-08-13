# Attendance Management — Product Requirements Document

| Field | Value |
|---|---|
| **PRD** | **`PRD-006`** — the number [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) line 236 allocates to Attendance Management / `BC-03`. *Reconciled from a drafting-time `PRD-008` on 2026-08-04; see `ATT-GAP-001` (**RESOLVED**) and [`PRD-006_NUMBERING_RECONCILIATION.md`](./PRD-006_NUMBERING_RECONCILIATION.md)* |
| **Module** | Attendance Management (Master PRD §8 module **8**) |
| **Bounded context** | **`BC-03` Attendance** — `[CORE]`, Library Management domain |
| **Aggregate owned** | `AttendanceDay` *(BC Map §8 — one student-day, **not** one punch)* |
| **Version** | **v1.3 — DRAFT** |
| **Status** | **`DRAFT`** — [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md). **Not frozen, not ranked, not admitted to any baseline.** Stage 3 architecture alignment and Stage 4 requirements review have both been *performed* and both returned **⚠️ CONDITIONAL**; a conditional verdict is not a pass, so **no stage is claimed passed** and Stages 5, 6 and 7 are unattempted. See [`PRD-006_ARCHITECTURE_ALIGNMENT.md`](./PRD-006_ARCHITECTURE_ALIGNMENT.md), [`PRD-006_REQUIREMENTS_REVIEW.md`](./PRD-006_REQUIREMENTS_REVIEW.md) and [`PRD-006_STAGE4_FINDINGS_CORRECTION.md`](./PRD-006_STAGE4_FINDINGS_CORRECTION.md). No ADR has been raised and none is claimed |
| **Date** | 2026-08-04 |
| **Release** | **V1** |
| **Baseline** | Written against `BASELINE-2026-08-04-E`. **Not admitted to it** |
| **Rank** | **Unranked.** A module PRD becomes Rank 3 only when [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3 confers it. This document claims no authority |
| **Identifier prefix** | **`ATT-*`** — see §0.3. Verified collision-free against `docs/**` before use |
| **Consumes** | `BC-02` Membership (`E-03`) · `BC-06` Library Policy (`E-04`) · `BC-21` Entitlement (`E-17`) · `BC-19` Tenancy (`E-18`) · `BC-25` Configuration (`E-19`) · `BC-30` Offline Sync (`E-24`) |
| **Publishes to** | `BC-04` Seating (`E-08`) · `BC-24` Audit Trail (`E-20`) · `BC-22` Notification Delivery (`E-23`) |
| **Authorities applied** | Master PRD v1.7 (Rank 1) · `ADR-0001`, `ADR-0011`, `ADR-0012`, `ADR-0017` (Rank 2) · Authentication PRD v2.0, Library PRD v1.1, `PRD-003` v1.0, `PRD-004` v1.2 **FROZEN**, `PRD-005` v1.4 **FROZEN**, `PRD-007` v1.0 **FROZEN** (Rank 3) · BC Map v1.5, Module Dependency Matrix v1.3 (Rank 4) · `ARCHITECTURE_RULINGS.md` v1.2 (Rank 5) · Enterprise Architecture v2.1 (Rank 6, **descriptive only**) |

---

## 0. Document Control

### 0.1 Purpose and standing

This document specifies the **product behaviour and business rules** of Attendance Management, the V1 product module
owning bounded context **`BC-03` Attendance**.

It is **not** an implementation specification. It contains no API surface, no database schema, no table, column,
index, migration, SQL, wire format, cryptographic construction or class design. Where a reader wants one of those,
the absence is deliberate and is not an omission to be filled in by an implementer.

**This document is `DRAFT` and unranked.** It has passed Stage 2 of the lifecycle and no stage beyond it. It has
not been architecture-reviewed (Stage 3), requirements-reviewed (Stage 4), traced (Stage 5), given a task backlog
(Stage 6) or frozen (Stage 7). Nothing here is authoritative until a baseline declaration says so.

### 0.2 Normative language

| Term | Meaning |
|---|---|
| **MUST** / **MUST NOT** | An absolute requirement. A build that does not satisfy it does not conform |
| **SHALL** | Synonym of **MUST**. Used where the sentence reads better |
| **SHOULD** | A strong recommendation. A deviation requires a recorded reason |
| **MAY** | Genuinely optional. Neither choice is a defect |

A statement without one of these words is **explanatory prose** and carries no obligation. Explanatory prose in
this document is used to record *why* a rule exists, so a later reader does not "fix" it.

### 0.3 Identifier registers — declared up front as a promise

Stage 2 requires the registers to be published before the content is written. These are those ranges. Every one is
contiguous; a gap would make the published range false.

| Register | Range | Count | Meaning |
|---|---|---|---|
| **`ATT-FR-*`** | `ATT-FR-001` … `ATT-FR-151` | **151** | Functional requirements — what the module does |
| **`ATT-BR-*`** | `ATT-BR-001` … `ATT-BR-045` | **45** | Business rules — decisions the domain enforces |
| **`ATT-INV-*`** | `ATT-INV-001` … `ATT-INV-012` | **12** | Invariants — must hold at every observable moment |
| **`ATT-EVT-*`** | `ATT-EVT-001` … `ATT-EVT-004` | **4** | Events this module publishes |
| **`ATT-XC-*`** | `ATT-XC-001` … `ATT-XC-021` | **21** | Exclusions — what this module must never do |
| **`ATT-PO-*`** | `ATT-PO-001` … `ATT-PO-014` | **14** | Ports — what it consumes, and from whom |
| **`ATT-CFG-*`** | `ATT-CFG-001` … `ATT-CFG-024` | **24** | Configurable values |
| **`ATT-NFR-*`** | `ATT-NFR-001` … `ATT-NFR-014` | **14** | Non-functional requirements |
| **`ATT-AC-*`** | `ATT-AC-001` … `ATT-AC-214` | **214** | Acceptance criteria |
| **`ATT-GAP-*`** | `ATT-GAP-001` … `ATT-GAP-018`, plus the suffixed successors `ATT-GAP-008a`, `ATT-GAP-016a`, `ATT-GAP-017a` | **18 numbers / 21 rows** | **Open questions. NOT requirements** |

**Total: 516 identifiers** — **285 obligation-bearing** (`ATT-FR`, `ATT-BR`, `ATT-INV`, `ATT-EVT`, `ATT-XC`,
`ATT-PO`, `ATT-CFG`, `ATT-NFR`), **213 acceptance criteria**, and **18 gap numbers carrying 21 rows**. Acceptance
criteria are counted separately from obligations because a criterion *verifies* an obligation rather than
imposing one; §31 measures obligations against criteria and would be circular if criteria were counted as
obligations.

> **These totals were 506 / 279 / 209 in v1.0…v1.2.** They rose in **v1.3** because the Stage 4 requirements
> review recorded eight findings and six of them were closed by *writing what was missing*, not by relaxing a
> claim: `ATT-FR-149`, `ATT-FR-150`, `ATT-FR-151`, `ATT-BR-043`, `ATT-BR-044`, `ATT-BR-045` and
> `ATT-AC-210`…`ATT-AC-213`. **No identifier was renumbered, withdrawn or reused, and no gap changed status.**
> See §34 and `PRD-006_STAGE4_FINDINGS_CORRECTION.md`.

**On the three suffixed gap numbers.** `ATT-GAP-008a`, `ATT-GAP-016a` and `ATT-GAP-017a` are declared here rather
than discovered later. A suffixed successor records a question that emerged *from* its parent question and would
be misleading under a fresh number, and it follows the precedent already carried in this repository by
`MM-GAP-006a`, `MM-GAP-007a` and `MM-GAP-010a` in the frozen `PRD-005`. The numeric range `001…018` remains
contiguous; the suffixes are additions to declared numbers, never a break in the sequence.

**Collision procedure, executed before writing.** `PRD_LIFECYCLE.md` Stage 2 rule 2 requires the prefix to be
chosen against the collision procedure *before* writing. A search of `docs/**` for `ATT-[A-Z]+-[0-9]+` and for any
`ATT-` token returned **zero matches**. `ATT-*` is therefore free and is used. No alternative prefix was needed.

**Identifiers are never reused.** A withdrawn requirement leaves its number retired, following the same rule as
ADRs, `IMPL-*` tasks and PRD numbers — cross-references outlive documents.

### 0.4 What a `GAP` is, and what it is not

`ATT-GAP-*` entries are **questions addressed to a named owner**. They are not requirements, they are not
deferred requirements, and they may not be satisfied by an implementer choosing an answer.

> **A gap resolved by implementation choice is not resolved — it is an undocumented architecture decision made by
> whoever happened to write the code first.** Every gap in §32 names the authority that must decide it. If a build
> needs an answer before that authority has given one, the build is blocked; it is not licensed to invent one.

This mirrors `SEAT-BR-045` in the frozen `PRD-007`, which forbids exactly this.

### 0.5 Reading order

1. **§3 Bounded Context Ownership** — who owns what. Read this before anything else.
2. **§5 Architecture & Dependency Boundary** — the edges, and the ones that do not exist.
3. **§7 Attendance Modes** — the six V1 modes and their independence.
4. **§32 Open Questions** — eighteen things this document deliberately does not decide.

---

## 1. Vision & Problem

### 1.1 The problem

A library owner needs to know, reliably and without argument, **who was physically present, when, and on what
evidence**. Today that question is answered by a paper register, which is slow at the door, trivially falsified,
impossible to aggregate, and unusable as the basis for a fee or occupancy decision.

Three properties make this harder than it first appears.

**Entry is bursty.** Fifty students arrive within a few minutes of opening. A mechanism that is correct but slow
produces a queue at the door, and a queue at the door produces staff who wave people through — which converts a
correct system into an unused one.

**Students are not uniform.** Some have a smartphone, some do not. Some can use a camera, some cannot. A design
that assumes every student carries a working phone excludes the students most likely to need a library.

**Presence is money-adjacent.** Attendance feeds occupancy (`BC-04`) and is retained as a business record
(`ID-5`). A record that can be silently altered is worthless as evidence, so corrections must exist but must never
be invisible.

### 1.2 The product intent

Attendance Management records a **verified fact of physical presence** — a check-in, an optional check-out, the
method used, the evidence gathered, and the full history of any correction — for a student, in a tenant, on a day.

It offers **six independent V1 attendance modes** so that a library can match its own door, its own hardware and
its own students, and so that no student is locked out for lacking a device.

### 1.3 What this module refuses to be

It is **not** an authentication system (§4, §19). It is **not** an occupancy system (§23). It is **not** an
analytics system (§24). It is **not** a device-management system (§17). It is **not** a second student directory
(§15). Each refusal is stated as an exclusion in §29 and is testable.

---

## 2. Goals & Non-Goals

### 2.1 Goals

| # | Goal | Why it is a goal |
|---|---|---|
| **G-1** | Record presence as a durable, correctable, auditable fact | The business record `ID-5` retains |
| **G-2** | Offer six independent attendance modes, any one of which is sufficient | §1.1 — students are not uniform |
| **G-3** | Never require a student to complete two methods for one attendance | Product decision, §7.2 |
| **G-4** | Work at the speed of a real door — 50+ students in a burst | §1.1 — a slow system is an unused system |
| **G-5** | Make duplicate and replayed attendance impossible, not merely unlikely | `MP-GBR-18` idempotency |
| **G-6** | Serve students without a smartphone as first-class users | Manual attendance is a **mode**, not a fallback |
| **G-7** | Keep every attendance-owned fact inside its tenant | `X-13`, `ID-2` |
| **G-8** | Own attendance, and only attendance | Single Owner Rule |

### 2.2 Non-goals for V1

| # | Non-goal | Where it lives instead |
|---|---|---|
| **NG-1** | Authenticating a person | `BC-18` Identity & Access |
| **NG-2** | Deciding whether a role may act | `BC-18` — `X-13` forbids deciding it here |
| **NG-3** | Owning live seat occupancy | `BC-04` Seating owns it (`E-08`) |
| **NG-4** | Owning membership validity | `BC-02` Membership (`E-03`) |
| **NG-5** | Owning operating hours, holidays, grace periods | `BC-06` Library Policy (`E-04`) |
| **NG-6** | Attendance reports, percentages, streaks, dashboards | `BC-26` Analytics Read Model |
| **NG-7** | Staff attendance | `BC-07` Staff & Shift, **V2** — a different aggregate entirely |
| **NG-8** | Visitor / non-student entry | `BC-09` Visitor, **V2** |
| **NG-9** | RFID, NFC, BLE attendance | **Future / V3** — §12, and not specified here |
| **NG-10** | A generic verification-layer framework | Explicitly rejected — §7.2 |

### 2.3 The `AttendanceDay` sizing decision, inherited not invented

BC Map §8.1 states the aggregate is **`AttendanceDay`, not `AttendancePunch`**, because the invariants that matter
— check-out after check-in, one open session, idempotent punch — are all day-scoped. This document adopts that
decision unchanged. It is recorded here so no reader treats a punch as the transaction boundary.

---

## 3. Bounded Context Ownership

### 3.1 The context

**`BC-03` Attendance**, `[CORE]`, Library Management platform, **V1**. BC Map §3.1 defines its responsibility as:
*"Owns the verified record of physical presence: check-in, check-out, verification method, fraud controls,
corrections."* This document specifies that sentence and adds nothing to it.

Module rank **R8** (Library Management domain). Under Dependency Matrix `L2`, it may import ranks `0…7.5` only.

### 3.2 What Attendance owns

`ATT-FR-001` — This module **MUST** be the sole owner of the `AttendanceDay` aggregate and of every attendance
fact within it.

| Owned | Detail |
|---|---|
| `AttendanceDay` | The aggregate root: one student, one tenant, one date |
| `Punch` | A check-in or check-out entity within the day |
| `AttendanceMethod` | Which of the six modes produced the punch |
| `VerificationEvidence` | What was verified at the moment of the punch |
| `CorrectionRecord` | The append-only history of every alteration |
| Duplicate / idempotency semantics | The rule that makes a repeated punch harmless |
| Attendance lifecycle | Open presence, closed presence, missed check-out |
| Attendance corrections | Who changed what, when, and why |
| Manual-entry workflow state | Including the OCR verification state of §13 |

### 3.3 What Attendance must not own

`ATT-FR-002` — This module **MUST NOT** own student identity, student profile, membership validity, seat
allocation, live occupancy, operating-hours policy, credentials, sessions, roles, permissions, tenant records,
configuration storage, the audit store, notification delivery, analytics metrics, or generic device lifecycle.

| Concept | Authoritative owner | Attendance's relationship |
|---|---|---|
| `StudentRecord`, profile, enrollment status | **`BC-01`** Enrollment (`PRD-004`, FROZEN) | Holds a `StudentRecordId` reference only |
| `PersonId`, global profile | **`BC-10`** Global Person Identity (`PRD-003`) | Does not hold, does not resolve |
| Membership validity | **`BC-02`** Membership (`PRD-005`, FROZEN) | Consumes the `E-03` projection; **flags, never blocks** |
| Seat allocation, layout, **live occupancy** | **`BC-04`** Seating (`PRD-007`, FROZEN) | Publishes `E-08`; owns none of it |
| Working hours, holidays, grace, late policy | **`BC-06`** Library Policy | Consumes `E-04`; conforms, does not translate |
| Credentials, sessions, OTP, roles, permissions | **`BC-18`** Identity & Access | Consumes decisions; makes none |
| Tenant record and context | **`BC-19`** Tenancy | Ambient `TenantContext` (`E-18`) |
| Entitlement / limits | **`BC-21`** Entitlement | Calls `check()` before mutating (`E-17`) |
| Notification channel, template, dispatch | **`BC-22`** Notification Delivery | Emits facts (`E-23`); never sends |
| Audit store | **`BC-24`** Audit Trail | Emits (`E-20`); never stores |
| Settings storage, feature flags | **`BC-25`** Configuration | Reads typed accessors (`E-19`) |
| Metrics, reports, projections | **`BC-26`** Analytics Read Model | Publishes events; owns no metric |
| Offline queue, replay, conflict execution | **`BC-30`** Offline Sync | Defines the policy (`E-24`); does not execute it |
| Staff attendance | **`BC-07`** Staff & Shift (V2) | Unrelated aggregate — see §3.4 |

### 3.4 The language collision, recorded

BC Map §5 records that **"Attendance"** resolves to two different models: `BC-03` is *a student's verified physical
presence*; `BC-07` is *a staff member's shift presence*. The map's ruling is `StudentAttendance` vs
`StaffAttendance`, **"Never a shared table."**

`ATT-XC-001` — This module **MUST NOT** record, store, correct or represent **staff** attendance. A staff member's
presence is `BC-07`, V2, and is out of scope at every level including the data model.

### 3.5 Single Owner Rule

`ATT-INV-001` — No aggregate owned by another bounded context **SHALL** be created, mutated or deleted by this
module, under any mode, by any actor, through any path.

---

## 4. Actors & Roles

### 4.1 Roles — taken from Master PRD §6, not invented

`ATT-FR-003` — This module **MUST** use only the five roles defined in Master PRD §6. It **MUST NOT** define,
introduce, extend or infer any role.

| Role | Enum | Attendance-relevant capability (Master PRD §6 wording) | Identity |
|---|---|---|---|
| **Library Owner** | `owner` | *"Complete business control"* — configures attendance modes | `AccountId` |
| **Manager** | `manager` | *"Daily operations management"* | `AccountId` |
| **Reception Staff** | `reception` | *"Student onboarding, **attendance**, memberships, seat allocation and support"* | `AccountId` |
| **Student** | `student` | *"**Attendance**, membership, profile, AI assistant, notifications and self-service"* | `AccountId` + `StudentRecordId` + optional `PersonId` |
| **Parent** | `parent` | *"**Attendance visibility**, fee updates and important notifications"* | `AccountId` with guardian role |

`ATT-FR-004` — Parent access to attendance **MUST** be **read-only** and **MUST** be scoped to the guarded
students only. Master PRD §6 grants *"attendance visibility"* — visibility is not mutation.

`ATT-FR-005` — The scope of every attendance permission **MUST** be one of the closed register `self`,
`guardianOf`, `tenantWide` (`MP-GBR-21`). This module **MUST NOT** introduce a fourth scope.

`ATT-BR-001` — Holding a permission is not the same as being able to exercise it on a given record
(`MP-GBR-20`). Every attendance operation **MUST** be evaluated against both the permission and its scope.

### 4.2 Non-human actors

| Actor | Nature | Note |
|---|---|---|
| **Fixed QR display** | A passive printed or displayed artefact | Owns nothing, decides nothing, holds no secret |
| **Dynamic QR surface** | A display rendering a rotating code | Same — the decision is server-side |
| **Face scanner** | Attendance hardware | **Ownership of the device lifecycle is unresolved — `ATT-GAP-009`** |
| **Student App** | The authenticated LIBOORA client | Carries the `BC-18` session; is not itself an actor |

---

## 5. Architecture & Dependency Boundary

### 5.1 Architecture style — confirmed, not assumed

`ADR-0001` establishes the **Modular Monolith**. Dependency Matrix §3 defines the rank ladder and `L2` (a module
at rank *n* imports ranks `0…n-1` only). `BC-03` sits at **R8**. This document adopts that architecture; it
proposes no service, no process boundary and no deployment change.

`ATT-XC-002` — This module **MUST NOT** be specified, designed or built as a separate service, process or
deployable unit. It is a module inside the monolith (`ADR-0001`).

### 5.2 Inbound edges — consumed

Every edge below is quoted from **BC Map §7**. BC Map §7 states: *"If an edge is not in this table, it **does not
exist** and adding it requires an ADR."* No edge in this document is new.

| Port | Edge | From | Pattern | Mechanism | What is consumed | Authority |
|---|---|---|---|---|---|---|
| `ATT-PO-001` | **`E-03`** | `BC-02` Membership | `C/S` + `PL` | Read projection | `MembershipValidity` — Attendance **records and flags**, never blocks | BC Map §7.1 |
| `ATT-PO-002` | **`E-04`** | `BC-06` Library Policy | `CF` | Sync port | `AttendanceRules{openTime, closeTime, graceMinutes, lateEntryPolicy}` — conform, do not translate | BC Map §7.1 |
| `ATT-PO-003` | **`E-17`** | `BC-21` Entitlement | `CF` | Sync port | `check(tenantId, feature, delta)` **before** the aggregate mutates | BC Map §7.3 |
| `ATT-PO-004` | **`E-18`** | `BC-19` Tenancy | `SK` | Ambient context | `TenantContext`, propagated — never a domain method parameter | BC Map §7.3 |
| `ATT-PO-005` | **`E-19`** | `BC-25` Configuration | `CF` | Sync port | Typed config accessors; no raw string lookups | BC Map §7.3 |
| `ATT-PO-006` | **`E-24`** | `BC-30` Offline Sync | `CF` | Sync port | Attendance **defines** the conflict-resolution policy; Sync **executes** it | BC Map §7.3 |

`ATT-PO-007` — Identity resolution. The authenticated actor **MUST** arrive from the `BC-18` session established
before the attendance operation. This module **MUST NOT** authenticate.

> **On `ATT-PO-007` and `E-11` — `ATT-GAP-002` is now RESOLVED from existing governance (§32.1).** BC Map `E-11`
> is `BC-18 → BC-01`, not `BC-18 → BC-03`. Attendance therefore does not hold an `E-11`-style resolution edge of
> its own; it receives an already-authenticated context from the application layer. **Frozen `PRD-007` (Rank 3,
> admitted by `ADR-0020`) establishes exactly this pattern for a sibling Core context**: its §3 context table
> lists `BC-18` as a context it *"**Consumes** — the existing RBAC + scope model"* with **no `E-` edge**, and
> `SEAT-BR-030` states *"A QR scan **MUST NOT** authenticate anybody. Authentication is `BC-18`'s exclusively."*
> A Core context consuming an already-established session without its own inbound identity edge is therefore a
> **frozen, ratified pattern**, not an unauthorised assumption. The original wording below is retained because it
> records why the question was asked; the answer is that the map does not need to state
> where that context is composed for `BC-03`.

### 5.3 Outbound edges — published

| Port | Edge | To | Pattern | Mechanism | What is published | Authority |
|---|---|---|---|---|---|---|
| `ATT-PO-008` | **`E-08`** | `BC-04` Seating | `PL` | Event | `StudentCheckedIn` / `StudentCheckedOut` → Seating updates live occupancy. **Seating is the occupancy owner; Attendance is the trigger** | BC Map §7.1 |
| `ATT-PO-009` | **`E-20`** | `BC-24` Audit Trail | `PL` | Event, fire-and-forget, outbox-backed | Audit facts. **Never called synchronously** | BC Map §7.3 |
| `ATT-PO-010` | **`E-23`** | `BC-22` Notification Delivery | `PL` | Event | Facts only — never *"send an SMS"* | BC Map §7.3 |

### 5.4 Edges that do NOT exist — the honest part

BC Map §9 names `BC-26` Analytics a primary consumer of three `attendance.*` events, and names `BC-13` a consumer
of a fourth. **BC Map §7 declares no `BC-03 → BC-26` edge and no `BC-03 → BC-13` edge.** Under §7's own rule those
edges do not exist.

`ATT-XC-003` — This module **MUST NOT** create, assume or rely on a direct integration edge to `BC-26` Analytics
or `BC-13` Trust & Safety. They are recorded as **`ATT-GAP-003`** (`BC-26`) and **`ATT-GAP-004`** (`BC-13`), not
resolved.

> **This is the systemic defect `MM-GAP-010` already records**, admitted in `BASELINE-2026-08-04-D`: BC Map §9
> names `BC-26` a consumer for eleven producing contexts while §7 declares an inbound edge from only one. `BC-03`
> is one of the ten affected. This document **inherits** that gap rather than inventing a resolution — and
> `PRD-005`, frozen, took exactly the same position (*"`BC-26` is deliberately not listed"*).

`ATT-XC-004` — This module **MUST NOT** consume `BC-29` File & Media. `E-22`'s consumer list is `BC-01`, `BC-10`,
`BC-14` — amended by `ADR-0016` and **not** including `BC-03`. This blocks the register-image workflow of §13B and
is recorded as **`ATT-GAP-010`**.

`ATT-XC-005` — This module **MUST NOT** consume `BC-27` AI Assistance. No `BC-03 → BC-27` edge exists in BC Map
§7, and none is required — see the direction ruling immediately below. What remains unresolved is recorded as
**`ATT-GAP-011`**.

> **The OCR/Vision direction was inverted, and existing governance settles it. `ATT-GAP-011` is now PARTIALLY
> RESOLVED (§32.1).** The first draft of this document asked for a `BC-03 → BC-27` edge. **BC Map §7.4 shows that
> such an edge would be architecturally backwards.** §7.4 rule **`F-1`**: *"**No capability context may import,
> reference, or query a domain context.** Not AI, not Analytics, not Search, not Notification, not Workflow, not
> Audit."* Rule **`F-3`**: *"Where a capability must *cause* a domain change (e.g. Workflow expiring a membership,
> AI applying a suggestion), it does so by **invoking the domain's public command API** through a registered port
> — with the domain re-validating every invariant. **The capability is an untrusted caller.**"* Rule **`F-4`**:
> *"AI-initiated domain writes additionally require a **Human-in-the-Loop approval record** (`BC-27`) and produce
> an `AI Action Log` entry (`BC-24`). **No exceptions in V1.**"* Master PRD `MP-GBR-29`…`MP-GBR-32` restate all
> four at **Rank 1**.
>
> **Three consequences follow, and none of them is invented here:**
>
> 1. **`BC-03` must not call `BC-27`.** An OCR request modelled as `BC-03 → BC-27` would make Attendance depend on
>    a capability; `F-3`'s direction is the reverse. **`ATT-XC-005` is therefore correct and is strengthened, not
>    relaxed.** The absence of a `BC-03 → BC-27` edge in §7 is not a defect to be closed by an ADR — it is the
>    intended state.
> 2. **`BC-03`'s command API is the only legitimate entry point**, with `BC-03` re-validating every invariant and
>    treating the caller as untrusted (`F-3`). Every §13B record therefore passes the same `ATT-INV-*` set as a
>    §13A record. This is already what §15 and §18 require of *all* writes; no new mechanism appears.
> 3. **`F-4`'s Human-in-the-Loop approval record is already this document's §13C rule.** `ATT-INV-009` forbids any
>    attendance record from an unresolved OCR result, and `NEEDS_MANUAL_VERIFICATION` requires a named staff actor
>    to confirm before a record exists. **The staff verification step IS the `F-4` approval.** It was written as a
>    product safeguard and turns out to satisfy a Rank 1 / Rank 4 architectural mandate — which is why §13C is
>    preserved verbatim and is now additionally load-bearing.
>
> **What `F-3`/`F-4` do NOT settle, and what therefore keeps `ATT-GAP-011` open.** They establish the *direction*
> and the *approval requirement* for an AI-initiated domain write. They do **not** name an OCR/Vision capability.
> BC-27's charter (BC Map L136) is *"prompts, agents, RAG retrieval, memory, guardrails, PII redaction,
> human-in-the-loop, model routing"* — **no vision, no OCR, no image ingestion**. A repository-wide search for
> `OCR`, `computer vision`, `document AI` and `image recognition` across `docs/**` returns **zero** capability
> nodes, including in Enterprise Architecture v2.1's AI Platform tree. **No context owns OCR.** Assigning it to
> `BC-27` would be inventing a capability, which §0.4 forbids. `ATT-GAP-011` is therefore **narrowed** from *"who
> owns OCR and what edge is needed"* to a single question with no edge component: **which context owns an
> OCR/Vision capability, given that `F-1`/`F-3` already fix how it must reach `BC-03` once it exists?**

`ATT-XC-006` — This module **MUST NOT** consume `BC-23` Search Indexing (`E-21` consumers are `BC-01`, `BC-10`),
`BC-31` Integration (`X-03`), or any Student Network context `BC-11`…`BC-17` (`X-05`).

### 5.5 Dependency laws observed

| Law | Statement | How this document observes it |
|---|---|---|
| **`L2`** | Rank *n* imports `0…n-1` only | Every consumed port is at rank ≤ 7.5; no upward import |
| **`L3`** | Domain declares ports, implementations injected | `E-24` conflict policy is *declared* here, *executed* by `BC-30` |
| **Cluster rule** | Core Library cluster may use only `E-01`…`E-10` | This module uses `E-03`, `E-04`, `E-08` — all inside the allow-list |
| **`X-01`** | No analytics → domain repository | §24 exposes facts; analytics builds its own projection |
| **`X-04`** | No synchronous domain → communication | `ATT-PO-010` is an event, never a send |
| **`X-05`** | No Library ↔ Student Network | Not referenced anywhere in this document |
| **`X-07`** | No cross-context call bypassing the event backbone | `E-08`, `E-20`, `E-23` are events via outbox |
| **`X-09`** | No `DateTime.now()` in the domain | §14.6 — every timestamp arrives through the time port |
| **`X-13`** | No cache/index key without `tenantId` | §20 |

`ATT-XC-007` — This module **MUST NOT** read from, write to, or query the database, table or store of any other
bounded context. Cross-context data arrives only through the ports in §5.2.

---

## 6. Attendance Domain Model

Product-level concepts only. No storage design, no schema, no field types.

### 6.1 Concepts

| Concept | Definition | Explicitly not |
|---|---|---|
| **`AttendanceDay`** | **The aggregate root and transaction boundary.** One student, one tenant, one calendar date | A punch; a session; a report row |
| **`Punch`** | A single recorded event of entry or exit within the day | The aggregate; an independent record |
| **`AttendanceMethod`** | Which of the six V1 modes produced the punch | A verification framework; a chain of methods |
| **`AttendanceStatus`** | The state of the day: no presence, open presence, closed presence | A membership status; an eligibility verdict |
| **`CheckIn`** | The punch opening a presence | Authentication; seat assignment |
| **`CheckOut`** | The punch closing an open presence | A requirement — see `ATT-BR-018` |
| **`VerificationEvidence`** | What was verified at punch time, and its outcome | Identity; a credential; a secret |
| **`VerificationResult`** | The pass/fail decision of that verification | An authentication result |
| **`CorrectionRecord`** | An append-only entry recording an alteration, its actor and reason | An edit; an overwrite |
| **`ManualVerificationState`** | The state of an OCR-detected entry awaiting staff confirmation | An attendance record |

`ATT-BR-002` — `VerificationEvidence` recorded on a punch **MUST** describe **what was verified**, not **who the
person is**. Identity is `BC-01`/`BC-10`/`BC-18`. Evidence is the outcome of a mode's check.

`ATT-XC-008` — `VerificationEvidence` **MUST NOT** contain a password, OTP, session token, credential, secret,
key, biometric template, or raw facial image.

### 6.2 Invariants — enforced synchronously inside the aggregate

These four are quoted from **BC Map §8** and are adopted unchanged.

`ATT-INV-002` — **Check-out cannot precede check-in.**

`ATT-INV-003` — A punch **MUST** be **idempotent by `(studentRecordId, date, idempotencyKey)`** (`MP-GBR-18`).

`ATT-INV-004` — There **MUST** be **no more than one open session per student** at any moment.

`ATT-INV-005` — Corrections **MUST** be **append-only, with actor and reason** (`MP-GBR-11`).

Added by this document, consistent with the above:

`ATT-INV-006` — Every `AttendanceDay` **MUST** carry exactly one `tenantId`, and every punch within it **MUST**
belong to that tenant.

`ATT-INV-007` — Every punch **MUST** record exactly one `AttendanceMethod` from the six V1 modes.

`ATT-INV-008` — No stored attendance fact **SHALL** be destructively updated or deleted. The correction record is
the only mutation path, and it appends.

### 6.3 Aggregate boundary

`ATT-BR-003` — One `AttendanceDay`, one database transaction. A single operation **MUST NOT** mutate two
`AttendanceDay` aggregates transactionally.

`ATT-FR-006` — Where an operation affects many students (the bulk register workflow, §13B), it **MUST** be
decomposed into one independent transaction per `AttendanceDay`, each independently idempotent, each independently
failable without rolling back the others.

`ATT-XC-009` — This module **MUST NOT** use a distributed transaction, a two-phase commit or a cross-aggregate
lock to record attendance.

---

## 7. Attendance Modes

### 7.1 The six V1 modes — the closed set

`ATT-FR-007` — V1 **MUST** support exactly these six attendance modes, and no others.

| # | Mode identifier | Short name | What it verifies |
|---|---|---|---|
| 1 | **`ATTENDANCE_MODE_FIXED_QR`** | Fixed QR | A static library-context code was scanned by an authenticated app |
| 2 | **`ATTENDANCE_MODE_DYNAMIC_QR`** | Dynamic QR | A currently-valid rotating code was scanned by an authenticated app |
| 3 | **`ATTENDANCE_MODE_FIXED_QR_WIFI`** | Fixed QR + Wi-Fi | The above, plus the device is on an approved network |
| 4 | **`ATTENDANCE_MODE_FIXED_QR_GPS`** | Fixed QR + GPS | The above, plus the device is inside the configured radius |
| 5 | **`ATTENDANCE_MODE_FACE`** | Face | A face was matched against an enrolled student |
| 6 | **`ATTENDANCE_MODE_MANUAL`** | Manual | Authorised staff recorded the presence |

`ATT-XC-010` — V1 **MUST NOT** define a seventh mode. RFID, NFC and BLE are **Future/V3** (§12, §33) and **MUST
NOT** appear as a V1 mode, requirement, configurable, event or acceptance criterion.

### 7.2 Mode independence — the central product rule

`ATT-BR-004` — The six modes are **independent attendance methods**. Each one, on its own, is sufficient to
produce an `AttendanceRecord`.

`ATT-BR-005` — Where a tenant has several modes enabled, a student **MUST** be able to use **any one** enabled
mode. The system **MUST NOT** require a student to complete two or more methods for a single attendance.

`ATT-XC-011` — This module **MUST NOT** implement a generic verification-layer architecture, a verification
pipeline, a verification chain, or any construct in which one attendance requires a sequence of methods.

> **There is no normal flow `QR → GPS → Wi-Fi → Face → Attendance`.** This sentence is written explicitly because
> the alternative reading is the one an engineer reaches for naturally: six "verification steps" behind one
> pluggable interface, composed at runtime. That design is prohibited here. It would make every student pay the
> cost of every enabled mode, and it would silently make a smartphone mandatory the first time a tenant enabled
> two modes.
>
> Concretely, with all six enabled: student A uses Fixed QR; B uses Dynamic QR; C uses Fixed QR + Wi-Fi; D uses
> Fixed QR + GPS; E uses Face; F is recorded by reception as Manual. Six students, six modes, one attendance each.

`ATT-BR-006` — Modes 3 and 4 are **single modes with a compound condition**, not two modes composed. Fixed QR +
Wi-Fi is one mode whose check has two parts. It is **not** `ATTENDANCE_MODE_FIXED_QR` with a Wi-Fi step attached.

`ATT-BR-007` — A Wi-Fi condition **MUST** apply **only** to `ATTENDANCE_MODE_FIXED_QR_WIFI`. A GPS condition
**MUST** apply **only** to `ATTENDANCE_MODE_FIXED_QR_GPS`. Neither **SHALL** be applied to Fixed QR, Dynamic QR,
Face or Manual.

`ATT-FR-008` — The `AttendanceMethod` recorded on a punch **MUST** be the mode actually used, and **MUST NOT** be
rewritten to a different mode afterwards by any process. A Manual entry never becomes a QR entry.

### 7.3 Mode availability is per tenant

`ATT-FR-009` — Each of the six modes **MUST** be independently enableable and disableable per tenant (§16).

`ATT-BR-008` — A student **MUST NOT** be required to have a smartphone in order to attend. If the tenant's
students include people without a device, Manual (§13) is the mode that serves them, and it is a **first-class
mode**, not a degraded path.

---

## 8. Fixed QR

**Mode `ATTENDANCE_MODE_FIXED_QR`.**

### 8.1 What the QR is, and is not

`ATT-BR-009` — A fixed attendance QR **identifies the library / attendance context**. It **MUST NOT** be treated
as authentication, identity or a credential.

`ATT-XC-012` — A fixed attendance QR **MUST NOT** contain, encode or reference a password, OTP, session token,
authentication credential, authentication secret, `AccountId`, `PersonId` or `StudentRecordId`.

> **Why this is stated three ways.** A QR that authenticates is a QR that can be photographed and shared. The
> authenticated actor comes from the `BC-18` session in the app; the QR supplies only the context being attended.
> `ID-1` already forbids any context outside `BC-18` from storing a credential — this is that rule applied to an
> artefact stuck to a wall.

### 8.2 The flow

`ATT-FR-010` — The Fixed QR flow **MUST** be:

```
Authenticated LIBOORA Student App  (BC-18 session already established)
  → authenticated student context (StudentRecordId within TenantContext)
  → scan fixed library QR
  → validate the QR (active, known, not revoked)
  → validate tenant match
  → validate student context
  → consult membership validity (E-03) — flag, never block
  → apply attendance rules (E-04)
  → validate check-in / check-out state
  → create or extend the AttendanceDay
```

`ATT-FR-011` — Every validation in `ATT-FR-010` **MUST** be performed **server-side**. A client-side result
**MUST NOT** be trusted as the decision.

### 8.3 Lifecycle of a fixed QR

| Requirement | Rule |
|---|---|
| `ATT-FR-012` | A fixed QR **MUST** be generated per tenant and **MUST** be bound to exactly one tenant |
| `ATT-FR-013` | A fixed QR **MUST** be explicitly activated before it can produce attendance |
| `ATT-FR-014` | A fixed QR **MUST** be associable with an entrance or display point, so a tenant with two doors can tell them apart |
| `ATT-FR-015` | A fixed QR **MUST** be replaceable; replacement **MUST NOT** invalidate any attendance already recorded through the previous code |
| `ATT-FR-016` | A fixed QR **MUST** be revocable; a revoked code **MUST** stop producing attendance immediately |
| `ATT-FR-017` | Activation, replacement and revocation **MUST** each emit an audit fact (`E-20`) |
| `ATT-BR-010` | A fixed QR presented for a tenant other than its bound tenant **MUST** be rejected. It **MUST NOT** fall back to the scanning student's tenant |

### 8.4 Failure behaviour

`ATT-FR-018` — Each of the following **MUST** be rejected, **MUST NOT** create an attendance record, and **MUST**
return a specific reason to the student: unknown QR · revoked QR · inactive QR · QR bound to another tenant ·
mode disabled for the tenant · no authenticated session · authenticated actor holds no `StudentRecordId` in the
tenant.

`ATT-BR-011` — A failure **MUST NOT** be silent. The student **MUST** receive a distinguishable outcome; "nothing
happened" is not an acceptable result of a scan.

### 8.5 Duplicate, replay and concurrency

`ATT-FR-019` — A repeated scan of the same fixed QR by the same student within the same `AttendanceDay` **MUST**
be resolved by the idempotency rule (`ATT-INV-003`) and **MUST NOT** create a second check-in.

`ATT-FR-020` — Concurrent scans by the same student **MUST** result in exactly one state transition. The
aggregate boundary (`ATT-BR-003`) is the serialisation point.

`ATT-BR-012` — A fixed QR is by design long-lived and reusable, so a photograph of it will scan. **Fixed QR alone
therefore does not prove the student was physically present** — it proves an authenticated student's app
submitted the library's context code. Tenants requiring a presence signal have modes 3 and 4. This limitation
**MUST** be stated to the Owner at configuration time (§16) and **MUST NOT** be described as fraud-proof.

---

## 9. Dynamic QR

**Mode `ATTENDANCE_MODE_DYNAMIC_QR`.**

### 9.1 Independence

`ATT-BR-013` — Dynamic QR **MUST** be independent of Fixed QR. Enabling one **MUST NOT** enable, disable, alter or
imply the other. A tenant **MAY** run both, and a student then uses whichever is displayed.

### 9.2 The flow

`ATT-FR-021` — The Dynamic QR flow **MUST** be:

```
Authenticated Student App
  → scan the currently displayed dynamic QR
  → server-side validation of the code
  → validity-window / expiry check
  → replay check
  → attendance validation (as §8.2 from membership onward)
  → create or extend the AttendanceDay
```

`ATT-FR-022` — Expiry and replay validation **MUST** be performed server-side. The displayed code's own claim
about its validity **MUST NOT** be trusted.

### 9.3 Deterministic rules

| Requirement | Rule |
|---|---|
| `ATT-FR-023` | A dynamic code **MUST** be generated per tenant and bound to that tenant |
| `ATT-FR-024` | A dynamic code **MUST** have a bounded validity window, after which it is expired |
| `ATT-FR-025` | A dynamic code **MUST** rotate on a configured interval (`ATT-CFG-005`) |
| `ATT-FR-026` | An expired code **MUST** be rejected with a distinguishable "expired" reason, separate from "invalid" |
| `ATT-FR-027` | A code already consumed **MUST NOT** produce a second attendance for the same student-day |
| `ATT-BR-014` | Reuse of a still-valid code by a **different** student **MUST** be evaluated independently for that student. The code is a context token, not a per-student ticket |
| `ATT-FR-028` | Concurrent scans of the same code by many students **MUST** each be processed independently; one student's outcome **MUST NOT** depend on another's |
| `ATT-FR-029` | Timestamp evaluation **MUST** use the server-side time port, never client-supplied time (`X-09`) |
| `ATT-FR-030` | When the mode is disabled, a dynamic code **MUST NOT** produce attendance, even if displayed |

`ATT-BR-015` — Clock skew between the display surface, the student device and the server **MUST NOT** be resolved
by trusting the client. Where skew makes a code's validity ambiguous, the server's evaluation is authoritative.

> **Clock Skew Handling is listed V2** in Enterprise Architecture v2.1's attendance tree. `ATT-BR-015` does not
> specify a skew-correction mechanism — it states which clock wins, which is a V1 necessity for a rotating code.
> A skew *correction* algorithm remains out of V1 scope.

### 9.4 Cryptography — deliberately not specified

`ATT-XC-013` — This document **MUST NOT** specify a cryptographic construction, signing algorithm, key length,
token format, key-rotation mechanism or key-storage design for dynamic codes.

Secrets and key management belong to the **Security Platform** (EA §3 duplicate-resolution: *"Secrets Management
→ re-homed to Security Platform; Config Platform keeps Secret Reference Resolution only"*). No Rank 1–5 document
specifies how a dynamic attendance code is constructed or verified.

**Recorded as `ATT-GAP-006`.** Until it is answered, `ATT-FR-021`…`ATT-FR-030` state the *behaviour* required of a
dynamic code; they do not license an implementer to invent the construction.

---

## 10. Fixed QR + Wi-Fi

**Mode `ATTENDANCE_MODE_FIXED_QR_WIFI`.**

### 10.1 What Wi-Fi is

`ATT-BR-016` — Wi-Fi verification is an **environment verification** condition. It contributes evidence that the
device was on an approved network at punch time.

`ATT-XC-014` — Wi-Fi **MUST NOT** be described, recorded or used as identity, authentication, or proof that a
specific person was present. This module **MUST NOT** claim that Wi-Fi verification alone prevents attendance
sharing.

> **Why the prohibition is explicit.** Two students on the same network are indistinguishable to a network check.
> Wi-Fi raises the cost of remote attendance; it does not make proxy attendance impossible. Documenting it as
> anti-proxy would be a false security claim, and `MP-GBR-11`'s spirit — attendance cannot be *silently*
> manipulated — is not served by a control that is believed to do more than it does.

### 10.2 The flow

`ATT-FR-031` — The flow **MUST** be: authenticated Student App → Fixed QR scan → Wi-Fi verification → attendance
validation → `AttendanceDay`. Both parts of the condition **MUST** pass for the mode to succeed.

### 10.3 Configuration and behaviour

| Requirement | Rule |
|---|---|
| `ATT-FR-032` | The approved network(s) **MUST** be configurable per tenant (`ATT-CFG-008`) |
| `ATT-FR-033` | The configuration **MUST** be owned by the Owner role and stored through `BC-25` (`E-19`) |
| `ATT-FR-034` | Where Wi-Fi is unavailable on the device, the mode **MUST** fail with a distinguishable "network unavailable" reason |
| `ATT-FR-035` | Where the device is on a network that is not approved, the mode **MUST** fail with a distinguishable "network not approved" reason |
| `ATT-FR-036` | A failure of the Wi-Fi condition **MUST NOT** create an attendance record, and **MUST NOT** silently downgrade to `ATTENDANCE_MODE_FIXED_QR` |
| `ATT-FR-037` | The verification outcome **MUST** be recorded as `VerificationEvidence` on the punch |
| `ATT-FR-038` | Wi-Fi configuration changes **MUST** emit an audit fact (`E-20`) |
| `ATT-BR-017` | Wi-Fi configuration **MUST** be tenant-scoped; one tenant's approved network **MUST NOT** validate another tenant's attendance |

### 10.4 What is unresolved

`ATT-XC-015` — This document **MUST NOT** specify how a network is technically identified or how a spoofed
network would be detected. No Rank 1–5 document defines a network-verification mechanism, and
untrusted/spoofed-network handling is therefore **not** specified — **`ATT-GAP-007`**.

`ATT-FR-039` — Until `ATT-GAP-007` is answered, this mode **MUST NOT** be presented to an Owner as
spoofing-resistant.

---

## 11. Fixed QR + GPS

**Mode `ATTENDANCE_MODE_FIXED_QR_GPS`.**

### 11.1 What GPS is

`ATT-BR-018` — Location verification is an **environment verification** mechanism. It is **not** identity.

`ATT-XC-016` — GPS **MUST NOT** be described, recorded or used as identity or authentication.

### 11.2 The flow

`ATT-FR-040` — The flow **MUST** be: authenticated Student App → Fixed QR scan → location verification →
attendance validation → `AttendanceDay`.

### 11.3 Configuration and behaviour

| Requirement | Rule |
|---|---|
| `ATT-FR-041` | Library coordinates **MUST** be configurable per tenant (`ATT-CFG-010`) |
| `ATT-FR-042` | An acceptance radius **MUST** be configurable per tenant (`ATT-CFG-011`) with a default and a bounded allowed range |
| `ATT-FR-043` | Where location is unavailable, the mode **MUST** fail with a distinguishable "location unavailable" reason |
| `ATT-FR-044` | Where the OS location permission is denied, the mode **MUST** fail with a distinguishable "permission denied" reason, and **MUST NOT** be reported as a system error |
| `ATT-FR-045` | Where reported accuracy is worse than the configured threshold (`ATT-CFG-012`), the mode **MUST** fail with a distinguishable "location inaccurate" reason |
| `ATT-FR-046` | Where the reported position is outside the radius, the mode **MUST** fail with a distinguishable "outside library area" reason |
| `ATT-FR-047` | A GPS failure **MUST NOT** create an attendance record and **MUST NOT** silently downgrade to `ATTENDANCE_MODE_FIXED_QR` |
| `ATT-FR-048` | The verification outcome **MUST** be recorded as `VerificationEvidence` |
| `ATT-FR-049` | Coordinate and radius changes **MUST** emit an audit fact (`E-20`) |
| `ATT-BR-019` | GPS configuration **MUST** be tenant-scoped |

**Coordinate representation.** Library PRD `LIB-6.5` requires Map Location to be *"geocoded coordinates"*, owned by
the Library module. `ATT-FR-041` configures an **attendance** radius centre; where a tenant has already recorded a
map location, whether the two are the same value is **`ATT-GAP-008`** — this document does not merge them and does
not duplicate ownership.

### 11.4 Mock location — not specified

`ATT-XC-017` — This document **MUST NOT** specify mock-location detection. No Rank 1–5 document authorises or
defines it, and the platform capability required is not architecturally owned — **`ATT-GAP-008a`**.

`ATT-FR-050` — Until `ATT-GAP-008a` is answered, this mode **MUST NOT** be presented to an Owner as
location-spoofing-resistant.

---

## 12. Face Verification

**Mode `ATTENDANCE_MODE_FACE`.**

### 12.1 Independence

`ATT-BR-020` — Face is an **independent attendance path**. It **MUST NOT** require RFID, QR, GPS or Wi-Fi.

`ATT-FR-051` — The flow **MUST** be: face scanner → identity verification → attendance validation →
`AttendanceDay`.

`ATT-XC-018` — Face verification **MUST NOT** be specified, described or implemented as an authentication method,
an authentication factor, or a new authentication framework. It identifies a student for the purpose of creating
an attendance fact. Authentication remains `BC-18` (`AUTH-1.1`, `ID-1`).

> **The Authentication PRD is explicit on the adjacent point.** Its rejected-methods table lists *"Biometric
> login — device-local convenience, not an authentication factor the platform can verify."* Face here produces
> **attendance evidence**, never a session.

### 12.2 Product requirements

| Requirement | Rule |
|---|---|
| `ATT-FR-052` | A student **MUST** be explicitly enrolled into face verification before it can produce attendance for them |
| `ATT-FR-053` | Enrollment **MUST** require recorded consent before any biometric capture |
| `ATT-FR-054` | A match **MUST** resolve to exactly one enrolled `StudentRecordId` within the tenant |
| `ATT-FR-055` | A match below the configured confidence threshold (`ATT-CFG-014`) **MUST** be treated as **no match** |
| `ATT-FR-056` | An unknown face **MUST** be rejected and **MUST NOT** create an attendance record |
| `ATT-FR-057` | Where multiple faces are detected, the system **MUST NOT** guess. It **MUST** fail with a distinguishable reason |
| `ATT-FR-058` | Where two enrolled students match above threshold, the result **MUST** be treated as ambiguous and rejected |
| `ATT-FR-059` | A failed match **MUST** be reportable to staff so the student can be served by another enabled mode |
| `ATT-FR-060` | Face verification **MUST** be subject to the same duplicate and idempotency rules as every other mode |
| `ATT-FR-061` | Face verification **MUST** support both check-in and check-out where the tenant uses check-out |
| `ATT-FR-062` | Face enrollment, re-enrollment, deletion and configuration change **MUST** each emit an audit fact (`E-20`) |
| `ATT-BR-021` | Face enrollment data **MUST** be tenant-scoped. A student enrolled at one library **MUST NOT** be matchable at another |
| `ATT-BR-022` | A student **MUST** be able to withdraw from face verification, and withdrawal **MUST NOT** delete their attendance history |

### 12.3 Liveness

`ATT-FR-063` — Where the scanner platform provides a liveness/anti-spoofing signal, its outcome **MUST** be
recorded as `VerificationEvidence`, and a failed liveness result **MUST** prevent attendance.

`ATT-XC-019` — This document **MUST NOT** specify a liveness algorithm, an anti-spoofing technique or a detection
threshold beyond the configurable confidence value. No Rank 1–5 document defines one — **`ATT-GAP-013`**.

### 12.4 Biometric data — the largest unresolved area

`ATT-XC-020` — This document **MUST NOT** specify biometric storage design, template format, encryption scheme,
retention period or deletion mechanism, and **MUST NOT** assume permanent retention of raw facial images or
templates.

The repository contains **no biometric architecture**. The only adjacent statement is `SXC-4` in `PRD-003`, which
classifies a Library Identification Photo as an *"organisation-scoped biometric-adjacent asset"* owned by `BC-01`
— **not** by `BC-03`, and not a face template.

Four separate questions are unresolved and are recorded as gaps, not answered:

| Question | Gap |
|---|---|
| Which context **owns** biometric enrollment data? | **`ATT-GAP-012`** |
| Where is it **stored**, given `BC-03` has no `E-22` edge to `BC-29`? | **`ATT-GAP-012`** |
| What is the **retention period**, and what is the legal basis? | **`ATT-GAP-014`** |
| What is the **deletion** obligation on withdrawal or `ID-5` erasure? | **`ATT-GAP-014`** |

#### 12.4a Biometric boundary — the seven dimensions, audited against authoritative sources

The re-audit required each of seven dimensions to be *architecturally resolved where existing governance permits*.
The honest result is **two resolved, five unresolvable without an owner's decision**. Each row states the source
consulted and, where nothing was found, says so rather than filling the cell.

| # | Dimension | Verdict | Authoritative basis, or the absence of one |
|---|---|---|---|
| 1 | **Ownership** | ❌ **UNRESOLVED — `ATT-GAP-012`** | No context in BC Map §3 claims biometrics. `BC-18`'s aggregate set is `Account` · `AccessPolicy` with entities `Credential`, `AuthSession`, `Device`, `ConsentRecord` (BC Map L380) — **no biometric template**. Authentication PRD v2.0 (Rank 3) L968 excludes **Biometric login** outright: *"Device-local convenience, not an authentication factor the platform can verify."* `BC-01` owns a *Library Identification Photo* (`SM-4.3`), which `SXC-4` calls *"organisation-scoped biometric-adjacent asset"* — **adjacent is not a template**, and `BC-01` ≠ `BC-03`. **No source assigns an owner. This document must not appoint one.** |
| 2 | **Processing** | ⚠️ **DIRECTION SETTLED ONLY** | If matching is ever performed by a capability, BC Map §7.4 `F-1`/`F-3` fix the direction exactly as for OCR (§5.4): the capability is an untrusted caller into `BC-03`'s command API, never the reverse. **This settles *how*, not *who*.** No vision/matching capability exists in `docs/**` — the same void as `ATT-GAP-011`. |
| 3 | **Enrollment** | ❌ **UNRESOLVED — `ATT-GAP-012`** | Enrollment writes a durable biometric record. With no owner (row 1) and no storage path (row 5), there is no context authorised to hold it. Note `ID-6` and BC Map L380 require **guardian consent before social activation for a minor** — the only consent gate in the repository, owned by `BC-18`, and **not** written for biometrics. Whether it extends to biometric enrollment of a minor is exactly the kind of question `§0.4` forbids this document from answering. |
| 4 | **Liveness** | ❌ **UNRESOLVED — `ATT-GAP-013`** | A repository-wide search for `liveness` and `anti-spoof` returns only **infrastructure** hits — EA L1984 `Readiness & Liveness (V2)` is a health-probe node, not biometric liveness. **No biometric liveness capability exists.** `ATT-XC-019` stands. |
| 5 | **Storage** | ✅ **RESOLVED — negatively, and this is a real answer** | `E-22`'s consumer list is `BC-01`, `BC-10`, `BC-14` (BC Map L331, amended by `ADR-0016`). `BC-03` is absent, and BC Map L292 rules that an unlisted edge *"does not exist."* **`BC-03` therefore has no authorised byte-storage path of any kind** — this is settled, not open. It is the same finding as `ATT-GAP-010` and it applies to templates as forcefully as to register images. The consequence is definite: **a template cannot be stored by `BC-03` today.** |
| 6 | **Privacy / PII** | ✅ **RESOLVED — constraints are binding and already apply** | `MP-GBR-32` (Rank 1): *"**PII is redacted before egress to any model.** Retrieval is tenant- and permission-filtered — asserted per query, not assumed."* Rule `F-4` and `MP-GBR-31` add the mandatory approval record. **These bind any future biometric design without further decision.** What they do *not* do is authorise collection — a constraint on handling is not a licence to collect. |
| 7 | **Retention / deletion** | ❌ **UNRESOLVED — `ATT-GAP-014`** | `ID-5` and `MP-GBR-04` require that erasure delete the `Account`, anonymise the `Person`, and **retain** attendance history *"under legal basis and pseudonymised."* **A biometric template cannot be pseudonymised — it *is* the identifier.** `ID-5`'s mechanism is therefore not merely silent on biometrics, it is **structurally inapplicable** to them. BC Map `Q-04` is separately open on attendance retention generally. Legal counsel must decide; no engineer may. |
| 8 | **Device boundary** | ❌ **UNRESOLVED — `ATT-GAP-009`** | `BC-18` owns `Device` (BC Map L380) but in the *authentication* sense — credentials and sessions. `BC-08` Inventory owns *"books, furniture, **devices**, consumables"* (L103) but is **V2**, so it cannot own a V1 face scanner's lifecycle. **A V1 gap between two contexts, neither of which can take it.** §17 and `ATT-XC-021` stand. |

> **Row 7 is the strongest finding in this section, and it hardens `ATT-FR-064` rather than relaxing it.** The
> re-audit was asked to resolve biometrics wherever governance allows. On retention it establishes something
> sharper than "no rule exists": the platform's *existing* erasure guarantee is **incompatible in principle** with
> holding a face template, because the anonymisation `ID-5` promises cannot be performed on data whose entire
> purpose is to identify a person. That is not a gap to be filled with a duration in days — it is a conflict a
> decision-maker must confront. `ATT-FR-064`'s outright build block is therefore **confirmed as correct**, and is
> now supported by a Rank 1 rule rather than only by the absence of one.

`ATT-FR-064` — Until `ATT-GAP-012` and `ATT-GAP-014` are both answered by their named owners, face verification
**MUST NOT** be implemented. The mode is specified; it is **not** authorised to be built.

> **This is the one mode this document blocks outright.** Enrolling biometric data for minors with no owner, no
> retention rule and no deletion path is a legal exposure, not a scheduling detail. `BC-13` Trust & Safety is
> classified `[CORE]` for precisely this class of risk, and Master PRD `MP-GBR-04`/`ID-5` already constrain
> erasure in ways a biometric template would interact with.

### 12.5 Face Recognition is V3 in the Enterprise Architecture — an unresolved conflict

Enterprise Architecture v2.1's attendance tree lists **`Face Recognition (V3)`**. The authoring instruction for
this document specifies Face as a **V1** mode. EA is **Rank 6, descriptive only** — Baseline §4: *"Update it to
match 1–5; never the reverse"* — so it does not outrank a product decision.

But no Rank 1–5 document places Face in V1 either. This is recorded as **`ATT-GAP-015`** and is **not** silently
resolved in either direction.

---

## 13. Manual Attendance

**Mode `ATTENDANCE_MODE_MANUAL`. A first-class V1 mode.**

`ATT-BR-023` — Manual attendance **MUST** be treated as a first-class mode, not a temporary fallback, not a
degraded path, and not an exception requiring justification. It exists for students who have no smartphone, have
no other enabled mode, cannot use QR, cannot use Face, need reception assistance, or are recorded through a
physical register.

### 13A. Individual manual entry

`ATT-FR-065` — Authorised staff **MUST** be able to record attendance for one student directly.

`ATT-FR-066` — The flow **MUST** be: search/select student → enter attendance details → validate authorisation →
validate duplicate and sequence rules → create the `AttendanceDay` punch.

`ATT-FR-067` — A manual record **MUST** preserve: the `StudentRecordId` reference · the attendance date · the
check-in timestamp · the check-out timestamp where applicable · `AttendanceMethod = MANUAL` · the acting staff
reference · `source = MANUAL_STAFF_ENTRY` · the creation timestamp · the correction state · the audit reference.

`ATT-BR-024` — A manual entry **MUST NOT** silently become a QR, Dynamic QR, Face, RFID or automated attendance
record. The recorded method and source are permanent facts about how the record came to exist.

`ATT-FR-068` — Manual entry **MUST** be subject to the same duplicate, sequence and idempotency rules as every
other mode (§14, §15).

`ATT-FR-069` — Every manual entry **MUST** emit an audit fact (`E-20`) identifying the acting staff member.

`ATT-BR-025` — Staff **MUST NOT** be able to record manual attendance for a student outside the active tenant.

### 13B. Physical register image → OCR/Vision

`ATT-FR-070` — The module **MUST** support a second manual workflow for high-volume physical-register capture.

`ATT-FR-071` — The workflow **MUST** be:

```
students write entries in the physical register
  → staff captures/uploads the register image
  → OCR/Vision processing attempts to detect entries
  → the system matches detected information to authoritative student records
  → high-confidence entries are PRESENTED for attendance creation
  → unresolved entries are NOT silently accepted
  → staff manually verifies unresolved entries
  → verified entries become MANUAL attendance records
```

`ATT-BR-026` — This workflow is a **data-capture assistance mechanism**. It is **not** authentication, **not**
student-identity ownership, **not** an attendance mode separate from Manual, and **not** a replacement for staff
verification when detection or matching fails.

`ATT-FR-072` — Every record produced by this workflow **MUST** carry `AttendanceMethod = MANUAL`. The workflow
**MUST NOT** introduce a seventh mode.

`ATT-FR-073` — Matching **MUST** resolve against authoritative student records obtained through the proper
boundary. This module **MUST NOT** maintain its own student directory for matching purposes.

### 13C. OCR/Vision failure behaviour

`ATT-FR-074` — Where OCR/Vision cannot detect an entry, cannot read the relevant text, cannot confidently match a
student, detects ambiguous or multiple possible students, or produces incomplete information, the entry **MUST**
enter the deterministic state **`NEEDS_MANUAL_VERIFICATION`**.

`ATT-INV-009` — An attendance record **MUST NOT** be created solely from an unresolved OCR result. An entry in
`NEEDS_MANUAL_VERIFICATION` **SHALL NOT** become an `AttendanceDay` punch until an authorised staff member
confirms it.

`ATT-FR-075` — Authorised staff **MUST** be able to: review the source image · inspect the detected information ·
select the correct student · correct the detected values · confirm the attendance · reject an invalid entry.

`ATT-FR-076` — A rejected entry **MUST NOT** create an attendance record, and the rejection **MUST** be auditable.

`ATT-BR-027` — Confidence **MUST NOT** be self-certifying. A detection the system believes is high-confidence but
which matches no authoritative student record **MUST** enter `NEEDS_MANUAL_VERIFICATION`, not be created.

`ATT-FR-077` — The confidence threshold above which an entry is presented as high-confidence **MUST** be
configurable (`ATT-CFG-019`).

`ATT-BR-028` — Even a high-confidence entry **MUST** be **presented for** creation, not created autonomously,
unless the Owner has explicitly enabled unattended creation (`ATT-CFG-020`), whose default is **disabled**.

### 13D. Register image audit

`ATT-FR-078` — Where this workflow operates at all, the audit relationship **MUST** be retained between: the
uploaded register image · the OCR/Vision result · the matched student · the staff verification · the final Manual
`AttendanceRecord` · the correction history. **This obligation is unconditional within the workflow.** The
workflow itself is build-blocked by `ATT-FR-080` until `ATT-GAP-010` and `ATT-GAP-011` are answered; if the
answers do not permit the full chain to be retained, **the workflow does not ship** — the chain is not the part
that gets dropped. An audit trail that breaks at the image is what makes a mis-attributed attendance
uninvestigable, which is the specific harm §13D exists to prevent.

`ATT-FR-079` — This module **MUST NOT** create an attendance-specific audit store or an attendance-specific file
store. It uses `E-20` for audit and, where authorised, the platform's storage architecture.

### 13E. What blocks this workflow today

Prerequisites are missing, and this document records them rather than inventing them. **The second row below was
re-audited against BC Map §7.4 and its framing was wrong; the corrected form is shown.**

| Missing | Consequence | Gap | Status after re-audit |
|---|---|---|---|
| **No `BC-03` → `BC-29` File & Media edge.** `E-22`'s consumer list is `BC-01`, `BC-10`, `BC-14` (amended by `ADR-0016`) | Attendance has no authorised way to hold a register image as a `FileRef` | **`ATT-GAP-010`** | **OPEN — needs an ADR.** A precedent exists and is named in §32.1 |
| ~~No `BC-03` → `BC-27` AI Assistance edge~~ → **no context owns an OCR/Vision capability anywhere in `docs/**`** | There is no authorised processor for the image. **The missing edge was never the real blocker** — BC Map §7.4 `F-1`/`F-3` forbid that direction, so its absence is correct | **`ATT-GAP-011`** | **NARROWED** — direction and approval settled by `F-3`/`F-4` (§5.4); capability ownership still unowned |
| **No retention or storage-ownership rule** for register images | Unknown how long an image of many students' handwriting may be kept | **`ATT-GAP-016`** | **OPEN — legal counsel.** Note this image contains *third-party* handwriting, not only the uploader's |

`ATT-FR-080` — Until `ATT-GAP-010` and `ATT-GAP-011` are answered by their named owners, the OCR/Vision workflow
**MUST NOT** be implemented. §13A individual manual entry is **unaffected** and remains fully specified and
buildable.

> **What the §7.4 finding changes, and what it does not.** It removes a false prerequisite: this document no
> longer asks anyone to add a `BC-03` → `BC-27` edge, and an ADR that added one would be wrong. It also confirms
> that §13C's staff-verification step is the `F-4` Human-in-the-Loop approval record rather than merely a product
> nicety. **It does not unblock the workflow.** `ATT-FR-080` stands unchanged, because an approval mechanism with
> no processor to approve is still not buildable, and because `ATT-GAP-010` — where the image bytes may legally
> live — is untouched by §7.4.

> **The two manual workflows are deliberately separable.** 13A needs nothing that does not already exist. 13B needs
> two edges that do not exist. Specifying them together, then blocking only the second, is what lets a team ship
> manual attendance for students without smartphones — goal **G-6** — without waiting for an AI architecture
> decision.

---

## 14. Entry / Exit

### 14.1 The deterministic state table

`ATT-FR-081` — Check-in and check-out **MUST** be resolved by this table, and by no other logic.

| # | Current state | Operation | Outcome |
|---|---|---|---|
| 1 | No open presence | Check-in | **Check-in recorded.** Presence opens |
| 2 | Open presence exists | Check-in | **Duplicate check-in.** Rejected; the existing presence is unchanged |
| 3 | Open presence exists | Check-out | **Check-out recorded** where the tenant uses check-out. Presence closes |
| 4 | No open presence | Check-out | **Invalid check-out.** Rejected; no record created |

`ATT-INV-010` — At most one presence **SHALL** be open for one student in one tenant at one time —
`ATT-INV-004` **applied at the operation level and scoped to the tenant**, which is a narrowing, not a
restatement. BC Map §8 states *"no more than one open session per student"*; because `ID-2` makes
`StudentRecordId` per-tenant, *"one student"* there is already one student **record**, and a person enrolled at
two libraries is two records. `ATT-INV-010` says so explicitly so that neither invariant is later deleted as a
duplicate of the other: **`ATT-INV-004` is the aggregate invariant, `ATT-INV-010` is the operation-level rule
that enforces it, and the tenant qualifier is load-bearing** — one person **MAY** hold an open presence at two
different libraries at the same time, and that is not a violation.

### 14.2 Check-out is optional at tenant level

`ATT-BR-029` — A tenant **MAY** operate without check-out (`ATT-CFG-021`). Where check-out is disabled, rows 3 and
4 of `ATT-FR-081` **MUST NOT** be reachable, and a day with only a check-in is a complete, valid record — not an
error state.

### 14.3 Missed check-out

`ATT-FR-082` — Where check-out is enabled and a presence remains open past the boundary defined by
`AttendanceRules` (`E-04`), the day **MUST** be marked as having a **missed check-out**.

`ATT-BR-030` — A missed check-out **MUST NOT** be auto-completed with an invented timestamp. It is a recorded
fact, correctable by staff under §18.

`ATT-BR-031` — A missed check-out **MUST NOT** delete, invalidate or retract the check-in.

`ATT-FR-083` — The module **MUST** publish `StudentCheckedOut` (`E-08`) only for an actual check-out. A missed
check-out **MUST NOT** emit a fabricated check-out event.

> **`ATT-FR-083` protects `BC-04`.** Seating derives live occupancy from `E-08`. A fabricated check-out would
> silently free a seat that is still occupied, and `SEAT-FR-115` in the frozen `PRD-007` already treats occupancy
> as advisory precisely because events can be missed. Fabricating one is worse than missing one.

### 14.4 Concurrency

`ATT-FR-084` — Concurrent check-ins for one student **MUST** result in exactly one open presence.

`ATT-FR-085` — Concurrent check-outs for one student **MUST** result in exactly one closed presence.

`ATT-FR-086` — A concurrent check-in and check-out for one student **MUST** resolve to a deterministic final
state; the aggregate boundary is the serialisation point (`ATT-BR-003`).

### 14.5 Invalid sequences

`ATT-FR-087` — An operation producing an invalid sequence **MUST** be rejected with a specific reason, **MUST
NOT** partially apply, and **MUST NOT** leave the day in an intermediate state.

### 14.6 Time

`ATT-FR-088` — Every attendance timestamp **MUST** be obtained from the platform time port, never from
`DateTime.now()` in the domain and never from the client (`X-09`).

`ATT-FR-089` — Attendance **MUST** be evaluated against the `AttendanceRules` in force **at the moment it was
recorded**. A later policy change **MUST NOT** retroactively reclassify an existing record (`LIB-12.8`,
`MP-GBR-19`).

`ATT-BR-032` — Times **MUST** be handled with the tenant's explicit time zone (`LIB-12.4`) and **MUST NOT** rely
on server local time.

### 14.7 No second presence system

`ATT-BR-033` — This module **MUST NOT** create a second presence, occupancy or "currently inside" system of
record beyond the `AttendanceDay` aggregate. Live seat occupancy is `BC-04`'s (§23).

---

## 15. Duplicate & Concurrency Prevention

### 15.1 Idempotency

`ATT-FR-090` — Every attendance-creating operation **MUST** be idempotent by
**`(studentRecordId, date, idempotencyKey)`** (`MP-GBR-18`, BC Map §8).

`ATT-FR-091` — A retried operation carrying the same idempotency key **MUST** return the original outcome and
**MUST NOT** create a second punch.

`ATT-BR-034` — Idempotency **MUST** be enforced inside the aggregate boundary, not by a pre-check followed by a
write. A check-then-write is not idempotency under concurrency.

`ATT-FR-092` — The idempotency key **MUST** be tenant-scoped (`X-13`).

### 15.2 Duplicate prevention across modes

`ATT-FR-093` — Duplicate prevention **MUST** apply across modes. A student who checks in by Fixed QR and is then
also entered manually **MUST NOT** produce two open presences; the second operation resolves as a duplicate
check-in (`ATT-FR-081` row 2).

`ATT-BR-035` — The mode does not create a separate namespace. Presence is a property of the student-day, not of
the method.

### 15.3 Replay

`ATT-FR-094` — A replayed Dynamic QR code **MUST NOT** produce a second attendance (§9.3).

`ATT-FR-095` — A replayed request at the transport level **MUST** be absorbed by idempotency (`ATT-FR-090`).

### 15.4 High-volume behaviour

`ATT-FR-096` — The module **MUST** support 50+ students entering rapidly, concurrent Fixed QR scans,
concurrent Dynamic QR scans, multiple face attempts, rapid manual entries and bulk register capture — without
violating any invariant in §6.2.

`ATT-BR-036` — Throughput **MUST NOT** be achieved by relaxing an invariant, batching writes across aggregates, or
deferring duplicate detection.

`ATT-NFR-001` — Contention **MUST** be confined to one student-day. Two different students checking in
concurrently **MUST NOT** contend with each other.

> **This is the design consequence of the `AttendanceDay` aggregate.** Fifty students arriving at once are fifty
> independent aggregates and fifty independent transactions. A shared "today's attendance" row would serialise the
> entire door.

---

## 16. Owner Configuration

### 16.1 Ownership of configuration

`ATT-FR-097` — All attendance configuration **MUST** be stored through **`BC-25` Configuration** (`E-19`) and
**MUST** be resolvable per tenant (`LIB-16.1`).

`ATT-FR-098` — This module **MUST NOT** implement a configuration store, a settings hierarchy or a feature-flag
system. `ADR-0017` assigns `BC-25` to `PRD-023`.

`ATT-BR-037` — The Library module stores *"Attendance Method"* as **a selection whose behaviour is owned here**
(`LIB-16.4`, and the §16 table row *"Attendance Method | The selection | `BC-03` Attendance"*). This module owns
the **behaviour**; it does not own the **setting record**.

### 16.2 Independent mode switches

`ATT-FR-099` — The Owner **MUST** be able to independently enable and disable each of the six V1 modes.

| Configurable | Mode |
|---|---|
| `ATT-CFG-001` | Fixed QR |
| `ATT-CFG-002` | Dynamic QR |
| `ATT-CFG-003` | Fixed QR + Wi-Fi |
| `ATT-CFG-004` | Fixed QR + GPS |
| `ATT-CFG-016` | Face |
| `ATT-CFG-017` | Manual |

`ATT-FR-100` — RFID **MUST NOT** appear as a V1 configurable mode.

### 16.3 The configurable register

Every entry carries owner, default, allowed domain, validation, failure behaviour, effective behaviour and audit —
as required by §0.3 and `LIB-16.2`/`LIB-16.3`.

| ID | Configurable | Owner | Default | Allowed domain | Validation | Failure behaviour | Effective behaviour | Audit |
|---|---|---|---|---|---|---|---|---|
| `ATT-CFG-001` | Fixed QR enabled | Owner | **Disabled** | `true` / `false` | Boolean | Reject invalid; retain previous | Next operation | Yes |
| `ATT-CFG-002` | Dynamic QR enabled | Owner | **Disabled** | `true` / `false` | Boolean | Reject; retain previous | Next operation | Yes |
| `ATT-CFG-003` | Fixed QR + Wi-Fi enabled | Owner | **Disabled** | `true` / `false` | Boolean; requires `ATT-CFG-008` set | Reject; retain previous | Next operation | Yes |
| `ATT-CFG-004` | Fixed QR + GPS enabled | Owner | **Disabled** | `true` / `false` | Boolean; requires `ATT-CFG-010` set | Reject; retain previous | Next operation | Yes |
| `ATT-CFG-005` | Dynamic QR rotation interval | Owner | **30 seconds** | **15–120 seconds** | Must be > 0 and ≤ validity window | Reject | Next code generated | Yes |
| `ATT-CFG-006` | Dynamic QR validity window | Owner | **60 seconds** | **30–300 seconds** | Must be ≥ rotation interval | Reject | Next code generated | Yes |
| `ATT-CFG-007` | Dynamic QR single-use per student-day | Owner | **Enabled** | `true` / `false` | Boolean | Reject | Next scan | Yes |
| `ATT-CFG-008` | Approved Wi-Fi network(s) | Owner | **Empty** | Tenant-scoped list | Non-empty when `ATT-CFG-003` enabled | Reject; mode cannot enable | Next scan | Yes |
| `ATT-CFG-009` | Wi-Fi verification required strictness | Owner | **Strict** | `strict` only in V1 | Enum | Reject | Next scan | Yes |
| `ATT-CFG-010` | Library coordinates | Owner | **Unset** | Valid geocoded coordinates | Required when `ATT-CFG-004` enabled | Reject; mode cannot enable | Next scan | Yes |
| `ATT-CFG-011` | GPS acceptance radius | Owner | **50 metres** | **20–200 metres** | Must be > 0 and within bound | Reject | Next scan | Yes |
| `ATT-CFG-012` | Minimum acceptable location accuracy | Owner | **30 metres** | **5–100 metres** | Must be > 0 | Reject | Next scan | Yes |
| `ATT-CFG-013` | Face enrollment required before use | Owner | **Enabled** | `true` only in V1 | Boolean | Reject | Immediate | Yes |
| `ATT-CFG-014` | Face match confidence threshold | Owner | **Not in V1** — `D-3a`, Face = **V3** | **Not in V1** — §16.3a | Within bound | Reject | Next scan | Yes |
| `ATT-CFG-015` | Face liveness required | Owner | **Enabled** | `true` / `false` | Boolean; only where the scanner supports it | Reject | Next scan | Yes |
| `ATT-CFG-016` | Face mode enabled | Owner | **Disabled** | `true` / `false` | Boolean; blocked by `ATT-FR-064` | Reject | Next operation | Yes |
| `ATT-CFG-017` | Manual mode enabled | Owner | **Enabled** | `true` / `false` | Boolean | Reject | Next operation | Yes |
| `ATT-CFG-018` | Register-image workflow enabled | Owner | **Disabled** | `true` / `false` | Boolean; blocked by `ATT-FR-080` | Reject | Next upload | Yes |
| `ATT-CFG-019` | OCR high-confidence threshold | Owner | **0.90** | **0.80–1.00** | Within bound | Reject | Next processing run | Yes |
| `ATT-CFG-020` | Unattended creation of high-confidence OCR entries | Owner | **Disabled** | `true` / `false` | Boolean | Reject | Next processing run | Yes |
| `ATT-CFG-021` | Check-out tracking enabled | Owner | **Enabled** | `true` / `false` | Boolean | Reject | Next operation | Yes |
| `ATT-CFG-022` | Staff correction permitted | Owner | **Enabled** | `true` / `false` | Boolean | Reject | Next correction | Yes |
| `ATT-CFG-023` | Correction window | Owner | **15 minutes** | **0–60 minutes** | Must be ≥ 0 | Reject | Next correction | Yes |
| `ATT-CFG-024` | Parent attendance visibility | Owner | **Enabled** | `true` / `false` | Boolean | Reject | Next read | Yes |

`ATT-BR-038` — Every default above is **Disabled** for a mode unless the mode requires nothing that does not
already exist. Manual (`ATT-CFG-017`) defaults **Enabled** because it needs no device, no edge and no unresolved
decision — and because `LIB-16.2` requires that *"a library that has changed nothing MUST be fully operable."* A
tenant that configures nothing can still take attendance, by reception, on day one.

#### 16.3a The seven settings that once had no default — `ATT-GAP-017`, **RESOLVED**

Seven rows above once carried **`ATT-GAP-017`** in the Default column instead of a value: `ATT-CFG-005`,
`ATT-CFG-006`, `ATT-CFG-011`, `ATT-CFG-012`, `ATT-CFG-014`, `ATT-CFG-019` and `ATT-CFG-023`. That was **a live
breach of `LIB-16.2`** (Rank 3, Library PRD: *"Every setting **MUST** have a documented default"*), and it was
recorded as a breach rather than closed by choosing seven numbers, because no Rank 1–5 document stated any of these
values and a rotation interval, a GPS radius or a face-match threshold invented by a PRD author is a security and
product decision made by whoever wrote the document first — which §0.4 forbids and which `ATT-GAP-017` assigned to
the **product owner**.

**`ATT-GAP-017` has now been answered by that owner, in full.** Six of the seven belong to V1 and each now carries
**both** an authoritative default **and** an authoritative allowed range, decided by the Product Owner and recorded
in [`PRD-006_ATT-GAP-017_PO_VALUE_DECISION_RECORD.md`](./PRD-006_ATT-GAP-017_PO_VALUE_DECISION_RECORD.md) §1, §8,
§13 and §14:

| ID | Default | Allowed range | Decision record |
|---|---|---|---|
| `ATT-CFG-005` | **30 seconds** | **15–120 seconds** | §13.1, §14.1 |
| `ATT-CFG-006` | **60 seconds** | **30–300 seconds** | §13.1, §14.1 |
| `ATT-CFG-011` | **50 metres** | **20–200 metres** | §1, §8 |
| `ATT-CFG-012` | **30 metres** | **5–100 metres** | §1, §8 |
| `ATT-CFG-019` | **0.90** | **0.80–1.00** | §13.1, §14.1 |
| `ATT-CFG-023` | **15 minutes** | **0–60 minutes** | §1, §8 |

The seventh, **`ATT-CFG-014`** (face match confidence threshold), owes no V1 value: decision **D-3a** places Face
verification in **V3** (see §33.2 and `ATT-GAP-015`), so the setting is not part of the V1 configuration surface
and no V1 default or range is owed for it. **This is not an unresolved default; it is a setting that does not exist
in V1.**

**Every value above was verified against its own validation rule in the same table**, and the two Dynamic QR
settings were additionally checked for **mutual** satisfaction, since each of their rules references the other:
rotation `30 s` ≤ validity `60 s`, so a code survives exactly two rotation periods. Across the full ranges the two
are not unconditionally compatible — rotation `120 s` with validity `30 s` would violate *"≤ validity window"* —
and that combination is **rejected before persistence** by the rule already stated in the row, per `LIB-16.3` and
`ATT-NFR-005`. No range was narrowed and no cross-setting constraint was invented to pre-empt it; the decision
record discloses the observation at §14.3.

**Both sentences of `LIB-16.2` are now satisfied, and the second is no longer satisfied merely latently.** The
rules below are retained unchanged. They are what made the absence of a value deterministic while the gap was
open, and they remain the governing behaviour for any setting that has no value — including `ATT-CFG-014` if Face
is ever brought forward without its threshold being decided, and any future configurable added without one. **They
were never a substitute for the values, and the values do not make them redundant.**

`ATT-BR-043` — A configurable whose Default column names an unresolved gap has **no default value, and no value
**SHALL** be substituted for it** — not zero, not a framework default, not a value copied from another tenant,
another mode, another product or an example in this document. An implementation that supplies one has resolved
`ATT-GAP-017` by implementation choice, which §0.4 forbids.

`ATT-FR-149` — Where a mode's operation requires a setting whose default is unresolved and the Owner has not
supplied a value, that mode **MUST NOT** be enableable, and the attempt to enable it **MUST** be rejected with a
specific reason naming the missing setting (`ATT-NFR-005`). The mode **MUST NOT** enable itself with an assumed
value, and **MUST NOT** enable in a degraded or partially-validated form.

`ATT-FR-150` — No attendance **MUST** ever be recorded, accepted or rejected by evaluating a setting that has no
value. Where such an evaluation would be required, the operation **MUST** fail closed (`ATT-FR-127`'s rule,
applied to configuration rather than tenancy) rather than proceed on a substituted value.

`ATT-BR-044` — **`LIB-16.2`'s operability requirement is met, and here is the check.** It is met on two
independent grounds, and it was met on the first of them even while `ATT-GAP-017` was open. **First, by
reachability:** each of the seven belongs to a capability that is **off by default**, so none is reachable in a
tenant that has configured nothing — `ATT-CFG-005`/`006` require Dynamic QR (`ATT-CFG-002` — **Disabled**);
`ATT-CFG-011`/`012` require Fixed QR + GPS (`ATT-CFG-004` — **Disabled**); `ATT-CFG-014` requires Face
(`ATT-CFG-016` — **Disabled**, and `ATT-FR-064` blocks the build outright); `ATT-CFG-019` requires the
register-image workflow (`ATT-CFG-018` — **Disabled**, and `ATT-FR-080` blocks the build outright); and
`ATT-CFG-023` is optional by construction — `ATT-FR-115` applies only *"where a correction window is configured"*,
so its absence means no window is enforced, which is a defined behaviour rather than a missing one. **A tenant on
day one uses Manual, which has a concrete default and no unresolved setting.** **Second, and now decisively, by
value:** every V1 setting among the seven carries an authoritative default and allowed range (§16.3a), so enabling
its mode no longer requires the Owner to supply a value this document declined to invent. `ATT-CFG-014` is out of
V1. The operability requirement is therefore satisfied **without relying on latency**, and the reachability
argument is retained because it is what governs any future configurable that arrives without a default.

`ATT-FR-151` — The Owner **MUST** be shown, at configuration time, that a setting has no platform default and
requires an explicit value before its mode can operate. A blank field **MUST NOT** be presented as though it
carried a default.

> **What resolved `ATT-GAP-017`, and what did not.** Every rule above is about *the absence of a value*, and not
> one of them supplies a value. They did not resolve the gap and were never recorded as having done so. **The gap
> was resolved by its named owner deciding the values** — the Product Owner, per L2178's owner column, whose
> rulings are transcribed at §16.3a and recorded in full in
> [`PRD-006_ATT-GAP-017_PO_VALUE_DECISION_RECORD.md`](./PRD-006_ATT-GAP-017_PO_VALUE_DECISION_RECORD.md).
> **The rules remain in force and are not spent.** They continue to govern `ATT-CFG-014` should Face be brought
> forward without its threshold decided, and any configurable added later without a default. Their purpose was
> that a specification hole should never be a trap; their continuing purpose is that a future one never becomes
> one either.
>
> **What is still open.** Values were the whole of `ATT-GAP-017` and none of anything else. Dynamic QR's
> cryptographic construction remains blocked by `ATT-GAP-006`; the register-image workflow remains build-blocked
> by `ATT-FR-080` pending `ATT-GAP-010` **and** `ATT-GAP-011`; Face remains blocked by `ATT-GAP-012`/`014` and is
> **V3** by D-3a; mode 3's anti-spoof claims remain blocked by `ATT-GAP-007` and mode 4's by `ATT-GAP-008a`.
> **Having a value is not having a mode.**

### 16.4 Configuration behaviour

`ATT-FR-101` — A configuration change **MUST** be validated before persistence and **MUST NOT** be partially
applied (`LIB-16.3`).

`ATT-FR-102` — An invalid value **MUST** be rejected with a specific reason and the previous value **MUST** remain
in force.

`ATT-FR-103` — A configuration change **MUST** take effect from the **next** attendance operation and **MUST NOT**
retroactively alter any existing record (`MP-GBR-19`).

`ATT-FR-104` — Disabling a mode **MUST** immediately stop that mode producing new attendance, and **MUST NOT**
delete, invalidate or retract attendance already recorded through it.

`ATT-FR-105` — Every configuration change **MUST** emit an audit fact (`E-20`) carrying the actor.

### 16.5 The at-least-one-mode question

`ATT-FR-106` — This document **MUST NOT** enforce an "at least one mode must be enabled" rule.

No Rank 1–5 document authorises such a constraint, and its consequence is non-trivial: it would prevent an Owner
from temporarily disabling everything during a closure. Recorded as **`ATT-GAP-018`**.

> Note that the **defaults** make the degenerate state unreachable by accident — Manual is enabled by default — so
> a tenant reaches "no modes enabled" only by deliberately disabling the last one.

---

## 17. Device / Scanner Boundary

`ATT-FR-107` — This module **MUST** own the **meaning of an attendance scan**: what a scan asserts, whether it is
valid, and what record it produces.

`ATT-XC-021` — This module **MUST NOT** create a Device Management bounded context, own generic device lifecycle,
or specify device provisioning, pairing, firmware, health monitoring or inventory.

`ATT-BR-039` — `BC-18`'s `Device` entity is an **authentication device** (a session-bearing client). It is **not**
an attendance scanner. This module **MUST NOT** conflate the two or store attendance-hardware records inside
`BC-18`'s model.

### 17.1 What is unresolved

The repository defines **no owner for attendance hardware**. `BC-08` Inventory *"owns books, furniture, devices,
consumables"* but is **`[SUPPORTING]`, V2**. `BC-18` owns authentication devices only.

`ATT-FR-108` — Until an owner is designated, this module **MUST NOT** assume it owns a face scanner, a QR display
point or any future attendance hardware. Recorded as **`ATT-GAP-009`**.

`ATT-FR-109` — Where a scanner association is required for Face verification, that association **MUST** be
tenant-scoped, and its ownership question remains `ATT-GAP-009`.

---

## 18. Corrections

`ATT-FR-110` — Authorised staff **MUST** be able to correct an attendance record.

`ATT-INV-011` — A correction **MUST** be **append-only** and **MUST** carry the acting actor and a reason
(`MP-GBR-11`, BC Map §8). No correction path **SHALL** overwrite or delete the corrected value.

`ATT-FR-111` — A correction **MUST** emit **`attendance.AttendanceCorrected`** (`ATT-EVT-003`).

`ATT-FR-112` — A correction **MUST NOT** change the recorded `AttendanceMethod` of the original punch. Correcting
a timestamp does not convert a Manual entry into a QR entry (`ATT-BR-024`).

`ATT-FR-113` — A correction **MUST** be subject to the same authorisation and tenant rules as creation.

`ATT-FR-114` — Correction of a missed check-out **MUST** be possible, and the resulting record **MUST** show both
the original missed state and the correction.

`ATT-FR-115` — Where a correction window is configured (`ATT-CFG-023`), a correction outside it **MUST** be
rejected with a specific reason.

`ATT-BR-040` — Attendance **MUST NOT** be silently manipulable (`MP-GBR-11`). Corrections exist; invisible
corrections do not.

`ATT-FR-116` — The full correction history of a record **MUST** be retrievable by an authorised actor.

---

## 19. Security & Authorization

### 19.1 The four-way distinction

This module keeps five concepts separate, and each of the four boundaries below is load-bearing.

| Concept | Owner | What it answers |
|---|---|---|
| **Authentication** | `BC-18` | *Who is this account?* |
| **Student identity** | `BC-01` (`StudentRecordId`) / `BC-10` (`PersonId`) | *Which student, in which tenant?* |
| **Attendance method** | **`BC-03`** | *By what means was this attendance produced?* |
| **Environment verification** | **`BC-03`** | *Was the device on the network / in the area?* |
| **Attendance record** | **`BC-03`** | *What presence fact is now true?* |

`ATT-BR-041` — This module **MUST NOT** claim, document or implement any of: QR = authentication · GPS = identity
· Wi-Fi = identity · OCR = authentication · OCR = definitive identity without verification · Face = a new
authentication framework.

### 19.2 Authorization

`ATT-FR-117` — Every attendance operation **MUST** be authorised by `BC-18`. This module **MUST NOT** evaluate,
grant, cache or infer an authorisation decision (`X-13`).

`ATT-FR-118` — This module **MUST NOT** define a new RBAC system, a new role, a new permission model or a new
scope.

| Operation | Role(s) | Scope |
|---|---|---|
| Configure attendance modes and values (§16) | `owner` | `tenantWide` |
| Operational attendance actions | `manager` | `tenantWide` |
| Individual manual entry (§13A) | `reception`, `manager` | `tenantWide` |
| OCR verification (§13C) | `reception`, `manager` | `tenantWide` |
| Corrections (§18) | `reception`, `manager` — subject to `ATT-CFG-022` | `tenantWide` |
| Self attendance (modes 1–5) | `student` | `self` |
| View own attendance | `student` | `self` |
| View guarded students' attendance | `parent` — subject to `ATT-CFG-024` | `guardianOf` |

`ATT-FR-119` — A `parent` **MUST NOT** create, correct or delete any attendance record. Master PRD §6 grants
*visibility*.

`ATT-FR-120` — An account holding no role in the active tenant **MUST** be treated exactly as an account with no
access (`AUTH-2.16`).

`ATT-FR-121` — Roles **MUST NOT** be inherited across tenants (`AUTH-2.8`). A `reception` role at library A
confers nothing at library B.

### 19.3 V1 anti-cheating protections

| Protection | Requirement | Applies to |
|---|---|---|
| Duplicate prevention | `ATT-FR-090`…`ATT-FR-093` | All six modes |
| Replay prevention | `ATT-FR-094`, `ATT-FR-095` | Dynamic QR, transport |
| Expiry | `ATT-FR-024`, `ATT-FR-026` | Dynamic QR |
| Server-side validation | `ATT-FR-011`, `ATT-FR-022` | All modes |
| Timestamp validation | `ATT-FR-088`, `ATT-FR-029` | All modes |
| Authorization | `ATT-FR-117` | All operations |
| Tenant isolation | §20 | Everything |
| Idempotency | `ATT-FR-090` | All modes |
| Concurrency protection | `ATT-FR-084`…`ATT-FR-086` | All modes |
| Face liveness | `ATT-FR-063` — **only where the platform supports it** | Face |
| GPS validation | §11 — **GPS mode only** | Mode 4 |
| Wi-Fi validation | §10 — **Wi-Fi mode only** | Mode 3 |
| OCR uncertainty → manual verification | `ATT-INV-009` | Register workflow |

`ATT-FR-122` — A detected fraud signal **MUST** be recordable and **MUST** emit `attendance.FraudSignalDetected`
(`ATT-EVT-004`) where the event's consumers are reachable — see §22.3 on the unresolved consumer question.

`ATT-BR-042` — This module **MUST NOT** overstate a control. Where a protection is bounded (Fixed QR
`ATT-BR-012`, Wi-Fi `ATT-XC-014`, GPS `ATT-FR-050`), the bound **MUST** be stated wherever the control is offered.

### 19.4 No secrets

`ATT-FR-123` — No attendance record, evidence object, event payload, audit fact or log line **MUST** contain a
password, OTP, session token, credential or key (`ID-1`).

---

## 20. Multi-Tenancy

`ATT-INV-012` — Every attendance-owned fact and configuration **MUST** be tenant-scoped. No exception exists.

`ATT-FR-124` — The following **MUST** each carry and be partitioned by `tenantId`:

`AttendanceDay` · punches · verification evidence · corrections · fixed QR configuration · dynamic QR context ·
Wi-Fi configuration · GPS configuration · face configuration and enrollment · scanner association · OCR/manual
workflow records · emitted events · idempotency keys · caches · projections · exports · audit references.

`ATT-FR-125` — `StudentRecordId` **MUST NOT** cross a tenant boundary (`ID-2`).

`ATT-FR-126` — No cache, index or key **MUST** be constructed without `tenantId` (`X-13`).

`ATT-FR-127` — Where tenant context is missing, ambiguous or unresolved, the operation **MUST** **fail closed**.
It **MUST NOT** default to a tenant, infer one, or use the last-known tenant.

`ATT-FR-128` — A suspended tenant **MUST** reject attendance writes (BC Map §8, `Tenant` invariant).

> **`X-13` is described in the Dependency Matrix as the "highest-severity failure class in the system."** For
> attendance the concrete failure is a student's presence appearing at a library they never attended.

---

## 21. Audit

`ATT-FR-129` — Audit facts **MUST** be emitted to **`BC-24` Audit Trail** via **`E-20`**, as fire-and-forget
outbox-backed events. The domain **MUST NOT** call audit synchronously (BC Map §7.3).

`ATT-FR-130` — This module **MUST NOT** create an attendance-specific audit store (`X-10`: audit has no update or
delete path).

`ATT-FR-131` — The following **MUST** each produce an audit fact:

configuration changes (§16) · fixed QR activation, replacement and revocation · dynamic QR configuration changes ·
face enrollment, withdrawal and configuration change · every manual attendance entry · every OCR verification
decision, including rejection · every attendance correction · failed and suspicious attempts where supported ·
device/scanner configuration where this module owns the action.

`ATT-FR-132` — Every audit fact **MUST** carry the acting actor and the tenant of record.

`ATT-FR-133` — No audit fact **MUST** contain an authentication secret (`ATT-FR-123`).

---

## 22. Events & Integrations

### 22.1 Published events — exactly the four in BC Map §9

`ATT-FR-134` — This module **MUST** publish only the events below. It **MUST NOT** invent an event name, a
producer or a consumer.

| ID | Event | Consumers per BC Map §9 | Purpose | Tenant | Idempotency | Payload boundary | Prohibited |
|---|---|---|---|---|---|---|---|
| `ATT-EVT-001` | **`attendance.StudentCheckedIn`** | `BC-04`, `BC-26`, `BC-22` | Occupancy, parent notification | Required | By event identifier | `StudentRecordId`, tenant, timestamp, method, day reference | Credentials · evidence internals · biometric data · profile · membership detail |
| `ATT-EVT-002` | **`attendance.StudentCheckedOut`** | `BC-04`, `BC-26` | Occupancy release | Required | By event identifier | Same shape | Same |
| `ATT-EVT-003` | **`attendance.AttendanceCorrected`** | `BC-24`, `BC-26` | Audit + restated metrics | Required | By event identifier | Correction reference, actor, reason | Same |
| `ATT-EVT-004` | **`attendance.FraudSignalDetected`** | `BC-24`, `BC-13`, `BC-22` | Anti-proxy enforcement | Required | By event identifier | Signal type, tenant, day reference | Same, plus raw evidence payloads |

`ATT-FR-135` — Event names **MUST** follow the binding convention `<Context>.<Aggregate><PastTenseVerb>` (BC Map
§9). An imperative name is a command and **MUST NOT** enter the event bus.

`ATT-FR-136` — Event consumption by `BC-04` **MUST** be idempotent-safe from the producer's side: a redelivered
event **MUST NOT** represent a new fact.

### 22.2 Consumed integrations

Listed in §5.2. No integration is consumed that is not in that table.

### 22.3 The unresolved consumer problem

BC Map §9 lists `BC-26` as a consumer of `ATT-EVT-001`, `002` and `003`, `BC-22` as a consumer of `ATT-EVT-001`
and `004`, and `BC-13` as a consumer of `ATT-EVT-004`. BC Map §7 declares a `BC-03` → `BC-22` edge (`E-23`) — but
**no** `BC-03` → `BC-26` edge and **no** `BC-03` → `BC-13` edge.

`ATT-FR-137` — This module **MUST** publish these four events as facts to the event backbone. It **MUST NOT**
assert a direct edge to `BC-26` or `BC-13`, and **MUST NOT** be built to depend on either consuming them.

Recorded as **`ATT-GAP-003`** (`BC-26`) and **`ATT-GAP-004`** (`BC-13`). `ATT-GAP-003` is an instance of the
systemic `MM-GAP-010`.

---

## 23. Seat Management Integration

`PRD-007` is **FROZEN** at v1.0. This section is written to be compatible with it and changes nothing in it.

### 23.1 The ownership split, agreed on both sides

| Concept | Owner | The other module |
|---|---|---|
| Attendance records, check-in/out, verification, correction, method | **`BC-03`** — this module | `PRD-007` `SEAT-BR-020`: *"MUST NOT create, store, modify, delete or verify an attendance record"* |
| Seat allocation, layout, seat state, physical seating | **`BC-04`** | This module owns none of it |
| **Live occupancy** | **`BC-04`** | BC Map `E-08`: *"Seating is the occupancy owner, Attendance is the trigger"* |

`ATT-FR-138` — This module **MUST NOT** create, modify, delete or read a `SeatAllocation` or `SeatLayout`.

`ATT-FR-139` — This module **MUST NOT** directly mutate any `BC-04` state. Its only contact is the `E-08` event.

`ATT-FR-140` — This module **MUST NOT** own, compute or publish live occupancy, occupancy counts, or "currently
inside" as an authoritative seating fact. §24 exposes attendance-derived operational facts only, which are not
seat occupancy.

### 23.2 Reciprocity with the frozen document

`PRD-007` `SEAT-FR-109`/`110` consume `attendance.StudentCheckedIn`/`CheckedOut` to set a physically-occupied flag;
`SEAT-FR-111` requires idempotent handling by event identifier; `SEAT-FR-115` treats a stale or missed event as
non-corrupting because occupancy is advisory.

`ATT-FR-141` — This module **MUST** publish `ATT-EVT-001` and `ATT-EVT-002` with a stable event identifier so
`SEAT-FR-111`'s idempotency is achievable.

`ATT-FR-142` — This module **MUST NOT** rely on `BC-04` having processed an event. Attendance is complete when the
`AttendanceDay` is committed, regardless of occupancy propagation.

`ATT-FR-143` — This module **MUST NOT** emit a check-out event that did not occur (`ATT-FR-083`), because
`BC-04` will free a seat on it.

### 23.3 The QR flows must not merge

`PRD-007` `SEAT-XC-012` states a seat QR **MUST NOT** be used as an attendance check-in mechanism, and that the two
QR flows **MUST NOT** be merged.

`ATT-FR-144` — An attendance QR (§8, §9) **MUST NOT** be used to assign, transfer or release a seat, and a seat QR
**MUST NOT** produce attendance. The two artefacts are separate and **MUST NOT** be unified into one scan.

### 23.4 No second attendance system

The prohibition runs in both directions across this boundary, and both halves already exist. `PRD-007`
`SEAT-BR-020` forbids `BC-04` from creating, storing, modifying, deleting or verifying an attendance record. The
reciprocal obligation on this side is `ATT-BR-033` (§14.7): this module **MUST NOT** create a second presence,
occupancy or *"currently inside"* system of record beyond the `AttendanceDay` aggregate, and `ATT-FR-140` forbids
it owning, computing or publishing live occupancy as an authoritative seating fact.

`ATT-BR-045` — Neither module **SHALL** hold a shadow copy of the other's system of record. Attendance is the sole
source of attendance facts; Seating is the sole source of occupancy facts (`E-08`: *"Seating is the occupancy
owner, Attendance is the trigger"*). Where the two disagree — a missed or stale event — `SEAT-FR-115` makes
occupancy advisory and non-corrupting; **the attendance record is never reconciled backwards from occupancy.**

---

## 24. Operational Data

`ATT-FR-145` — This module **MAY** expose operational facts derived from its own aggregate, where the architecture
permits: students currently inside · check-ins today · check-outs today · attendance by mode · failed attempts ·
manual entries · OCR entries requiring verification · active modes.

`ATT-FR-146` — This module **MUST NOT** own analytics. It **MUST NOT** define a metric, compute a certified
figure, build a read model, produce a report, or become the source for any attendance percentage, streak or
dashboard. `BC-26` Analytics Read Model owns the metric/semantic layer.

`ATT-FR-147` — Operational facts exposed under `ATT-FR-145` **MUST** be described as operational reads of the
attendance aggregate, **MUST NOT** be presented as certified metrics, and **MUST NOT** be used to contradict
`BC-26`.

> **"Students currently inside" is deliberately ambiguous between two owners**, and the ambiguity is resolved by
> naming: this module can report *how many open presences exist*, which is an attendance fact. `BC-04` owns
> *which seats are physically in use*, which is an occupancy fact. They will usually agree and are not the same
> statement (§23.1).

---

## 25. Notifications / Failure Signals

`ATT-FR-148` — This module **MUST** emit notification-relevant occurrences as **facts** via `E-23`, and **MUST
NOT** select a channel, render a template, apply quiet hours or dispatch a message (`X-04`, `LIB-16.5`).

The following outcomes **MUST** be distinguishable to the actor who caused them, as product-level failure signals:

| Outcome | Mode(s) | Requirement |
|---|---|---|
| Invalid QR | 1, 3, 4 | `ATT-FR-018` |
| Expired Dynamic QR | 2 | `ATT-FR-026` |
| Invalid / unapproved Wi-Fi | 3 | `ATT-FR-035` |
| Wi-Fi unavailable | 3 | `ATT-FR-034` |
| Outside GPS radius | 4 | `ATT-FR-046` |
| Location unavailable / denied / inaccurate | 4 | `ATT-FR-043`…`045` |
| Failed face match | 5 | `ATT-FR-056` |
| Ambiguous face match | 5 | `ATT-FR-057`, `ATT-FR-058` |
| OCR verification required | Manual/register | `ATT-FR-074` |
| Duplicate attendance | All | `ATT-FR-081` row 2 |
| Invalid check-out sequence | All | `ATT-FR-081` row 4 |
| Mode disabled | All | `ATT-FR-104` |

---

## 26. Data Ownership

| Data | Owner | This module holds |
|---|---|---|
| `AttendanceDay`, punches, evidence, corrections | **`BC-03`** | **Owns** |
| Manual workflow state, OCR verification state | **`BC-03`** | **Owns** |
| Attendance configuration values | **`BC-25`** stores; **`BC-03`** defines meaning | A typed read |
| Student name, profile, contact, guardian | `BC-01` | A `StudentRecordId` reference only |
| `PersonId`, global profile | `BC-10` | Nothing |
| Membership validity | `BC-02` | A consumed projection, not a copy of record |
| Seat allocation, occupancy | `BC-04` | Nothing |
| Operating hours, holidays, grace | `BC-06` | A consumed rule set |
| Credentials, sessions, roles | `BC-18` | Nothing |
| Audit entries | `BC-24` | Nothing — emits only |
| Metrics, reports | `BC-26` | Nothing |
| Register images | **Unresolved** — `ATT-GAP-010`, `ATT-GAP-016` | Nothing today |
| Biometric templates | **Unresolved** — `ATT-GAP-012`, `ATT-GAP-014` | Nothing today |

`ATT-FR-002` (§3.3) is the normative statement; this table is its data-level expansion.

**Retention.** BC Map `Q-04` — *"Retention period for `StudentAttendance` after enrollment archival?"* — is
**open** and is carried in Master PRD §Open Questions. `ID-5` requires attendance history to survive account
deletion, pseudonymised. This module therefore **MUST NOT** define its own retention period —
**`ATT-GAP-005`**.

---

## 27. Non-Functional Requirements

`ATT-NFR-001` — *(stated in §15.4)* Contention **MUST** be confined to one student-day.

`ATT-NFR-002` — Attendance capture **MUST** remain correct under burst arrival of 50+ students; correctness
**MUST NOT** degrade with concurrency.

`ATT-NFR-003` — This document **MUST NOT** state a latency figure, throughput number or percentile target. No
Rank 1–5 document defines one for attendance, and an invented number becomes a false acceptance criterion —
**`ATT-GAP-017a`**.

`ATT-NFR-004` — Every attendance decision **MUST** be reproducible from the recorded evidence, the rules in force
at the time, and the correction history.

`ATT-NFR-005` — Every rejection **MUST** carry a specific, distinguishable reason. A generic failure is a defect.

`ATT-NFR-006` — Attendance data **MUST** be tenant-isolated to the standard of `X-13`, verified by the
Multi-Tenant Test Suite.

`ATT-NFR-007` — No attendance operation **MUST** depend on a synchronous call to `BC-22`, `BC-24` or `BC-26`.

`ATT-NFR-008` — The module **MUST** remain functional when `BC-04` is unavailable; occupancy propagation is
asynchronous and advisory.

`ATT-NFR-009` — Where membership validity (`E-03`) is stale or unavailable, attendance **MUST** still be
recordable and **MUST** be flagged rather than blocked (BC Map `E-03`, `MP-GBR-16`).

`ATT-NFR-010` — A rule that cannot be checked **MUST** be treated as unmet. A requirement in this document with no
acceptance criterion is not satisfied by assertion.

`ATT-NFR-011` — Every timestamp **MUST** be timezone-explicit (`LIB-12.4`).

`ATT-NFR-012` — Offline behaviour **MUST NOT** be promised beyond what `E-24` authorises — see §27.1.

`ATT-NFR-013` — The module **MUST NOT** require a distributed transaction (`ATT-XC-009`).

`ATT-NFR-014` — Accessibility of attendance surfaces **MUST NOT** be worse for the Manual mode than for the app
modes; the students served by Manual are those least served by devices.

### 27.1 Offline / connectivity

**`E-24` exists**: `BC-03 Attendance → BC-30 Offline Sync`, `CF`, sync port — *"Attendance defines the
conflict-resolution policy; Sync executes it."* Master PRD `MP-ASM-03` records the assumption that *"libraries
operate with intermittent connectivity; offline attendance capture is required."* EA lists *Offline Attendance
Capture (V1)*.

`ATT-PO-011` — This module **MUST** define the conflict-resolution policy for attendance mutations replayed by
`BC-30`, and **MUST NOT** implement the queue, the replay or the conflict detection itself.

`ATT-PO-012` — The conflict-resolution policy **MUST** preserve every invariant in §6.2. A replayed punch **MUST**
be absorbed by idempotency (`ATT-INV-003`), not applied twice.

`ATT-PO-013` — A replayed punch **MUST NOT** overwrite a correction made while the device was offline.

`ATT-PO-014` — The offline behaviour of **Dynamic QR** is undefined: a rotating server-validated code cannot be
validated offline. This document **MUST NOT** promise offline Dynamic QR — **`ATT-GAP-016a`**.

---

## 28. Business Rules

The complete `ATT-BR-*` register, with the section that states each in context.

| ID | Rule | § |
|---|---|---|
| `ATT-BR-001` | Permission and scope are both evaluated | §4.1 |
| `ATT-BR-002` | Evidence describes what was verified, not who the person is | §6.1 |
| `ATT-BR-003` | One `AttendanceDay`, one transaction | §6.3 |
| `ATT-BR-004` | The six modes are independent; each is sufficient alone | §7.2 |
| `ATT-BR-005` | Any enabled mode may be used; never two for one attendance | §7.2 |
| `ATT-BR-006` | Modes 3 and 4 are single modes with a compound condition | §7.2 |
| `ATT-BR-007` | Wi-Fi belongs only to mode 3; GPS only to mode 4 | §7.2 |
| `ATT-BR-008` | A smartphone is never mandatory | §7.3 |
| `ATT-BR-009` | A QR identifies the context, not the person | §8.1 |
| `ATT-BR-010` | A QR is rejected outside its bound tenant; never falls back | §8.3 |
| `ATT-BR-011` | No silent failure | §8.4 |
| `ATT-BR-012` | Fixed QR alone does not prove physical presence — state the bound | §8.5 |
| `ATT-BR-013` | Dynamic QR is independent of Fixed QR | §9.1 |
| `ATT-BR-014` | A dynamic code is a context token, not a per-student ticket | §9.3 |
| `ATT-BR-015` | The server's clock decides validity | §9.3 |
| `ATT-BR-016` | Wi-Fi is environment verification | §10.1 |
| `ATT-BR-017` | Wi-Fi configuration is tenant-scoped | §10.3 |
| `ATT-BR-018` | GPS is environment verification, not identity | §11.1 |
| `ATT-BR-019` | GPS configuration is tenant-scoped | §11.3 |
| `ATT-BR-020` | Face is independent; requires no other mode | §12.1 |
| `ATT-BR-021` | Face enrollment is tenant-scoped | §12.2 |
| `ATT-BR-022` | Withdrawal from Face never deletes attendance history | §12.2 |
| `ATT-BR-023` | Manual is a first-class mode | §13 |
| `ATT-BR-024` | A manual entry never silently becomes another method | §13A |
| `ATT-BR-025` | No cross-tenant manual entry | §13A |
| `ATT-BR-026` | OCR is data-capture assistance, not authentication or identity | §13B |
| `ATT-BR-027` | Confidence is not self-certifying | §13C |
| `ATT-BR-028` | High-confidence entries are presented, not auto-created by default | §13C |
| `ATT-BR-029` | Check-out is optional at tenant level | §14.2 |
| `ATT-BR-030` | A missed check-out is never auto-completed with an invented time | §14.3 |
| `ATT-BR-031` | A missed check-out never retracts the check-in | §14.3 |
| `ATT-BR-032` | Times are timezone-explicit, never server-local | §14.6 |
| `ATT-BR-033` | No second presence system | §14.7 |
| `ATT-BR-034` | Idempotency is enforced inside the aggregate | §15.1 |
| `ATT-BR-035` | Presence belongs to the student-day, not the method | §15.2 |
| `ATT-BR-036` | Throughput never bought by relaxing an invariant | §15.4 |
| `ATT-BR-037` | Library stores the selection; this module owns the behaviour | §16.1 |
| `ATT-BR-038` | Defaults: modes off, except Manual on | §16.3 |
| `ATT-BR-039` | An auth device is not an attendance scanner | §17 |
| `ATT-BR-040` | No silent manipulation of attendance | §18 |
| `ATT-BR-041` | Six false equivalences that must never be claimed | §19.1 |
| `ATT-BR-042` | Never overstate a control; state its bound where offered | §19.3 |
| `ATT-BR-043` | A configurable whose default is unresolved has no value, and none may be substituted | §16.3 |
| `ATT-BR-044` | The `LIB-16.2` operability check: a tenant that configures nothing is still fully operable | §16.3 |
| `ATT-BR-045` | Neither module holds a shadow copy of the other's system of record | §23.4 |

---

## 29. Exclusions

Each exclusion states what is **impossible**, not merely discouraged.

| ID | Exclusion — this module **MUST NOT**… | Owner instead |
|---|---|---|
| `ATT-XC-001` | …record staff attendance in any form | `BC-07` (V2) |
| `ATT-XC-002` | …be built as a separate service, process or deployable | `ADR-0001` |
| `ATT-XC-003` | …assume a direct edge to `BC-26` or `BC-13` | `ATT-GAP-003`/`004` |
| `ATT-XC-004` | …consume `BC-29` File & Media | `E-22` excludes `BC-03` |
| `ATT-XC-005` | …consume `BC-27` AI Assistance | No edge exists |
| `ATT-XC-006` | …consume `BC-23`, `BC-31`, or `BC-11`…`BC-17` | `E-21`, `X-03`, `X-05` |
| `ATT-XC-007` | …read or write another context's database | Single Owner Rule, `L3` |
| `ATT-XC-008` | …place a credential, secret or biometric template in evidence | `ID-1` |
| `ATT-XC-009` | …use a distributed transaction or cross-aggregate lock | BC Map §8 |
| `ATT-XC-010` | …define a seventh V1 mode, including RFID/NFC/BLE | §33 Future |
| `ATT-XC-011` | …implement a generic verification layer, pipeline or chain | §7.2 |
| `ATT-XC-012` | …put authentication material in a QR | `ID-1` |
| `ATT-XC-013` | …specify dynamic-QR cryptography | Security Platform, `ATT-GAP-006` |
| `ATT-XC-014` | …treat Wi-Fi as identity or claim it prevents sharing | §10.1 |
| `ATT-XC-015` | …specify network identification or spoof detection | `ATT-GAP-007` |
| `ATT-XC-016` | …treat GPS as identity | §11.1 |
| `ATT-XC-017` | …specify mock-location detection | `ATT-GAP-008a` |
| `ATT-XC-018` | …make Face an authentication method or framework | `BC-18`, `AUTH-1.1` |
| `ATT-XC-019` | …specify a liveness algorithm or anti-spoofing technique | `ATT-GAP-013` |
| `ATT-XC-020` | …specify biometric storage, retention or deletion design | `ATT-GAP-012`/`014` |
| `ATT-XC-021` | …create a Device Management bounded context or own device lifecycle | §17, `ATT-GAP-009` |

**This table is the complete `ATT-XC` register — all 21 of them.** Three further prohibitions are carried as
`MUST NOT` functional requirements rather than exclusions, because each is a boundary against a *named owner*
rather than a general prohibition: `ATT-FR-098` (no configuration system — `BC-25` is `PRD-023`'s under
`ADR-0017`), `ATT-FR-130` (no audit store — `BC-24` owns it) and `ATT-FR-146` (no analytics ownership — `BC-26`
owns the metric layer). They are listed here so a reader searching only the exclusion register does not conclude
the prohibition is absent.

---

## 30. Acceptance Criteria

**213 criteria.** Every one of the 285 obligations in force — across `ATT-FR`, `ATT-BR`, `ATT-INV`, `ATT-EVT`,
`ATT-XC`, `ATT-PO`, `ATT-CFG` and `ATT-NFR` — is covered by at least one, verified mechanically rather than
asserted (§31.1). **No criterion tests a `GAP`**, because a gap is a question and a question cannot pass.

§30.1–§30.12 cover the user-facing flows. **§30.13–§30.19 cover the structural obligations** — ownership, mode
independence, invariants, corrections, ports, exclusions, configurables and non-functional rules. Those were the
obligations a first draft of this section left unverified, and several of them are the ones most likely to be
broken silently: a boundary crossed, an edge invented, a claim overstated. They are criteria now, not prose.

### 30.1 Student App — Fixed QR (mode 1)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-001` | An authenticated student scanning an active fixed QR for their tenant produces exactly one check-in | `ATT-FR-010` |
| `ATT-AC-002` | The same scan repeated produces no second check-in | `ATT-FR-019`, `ATT-INV-003` |
| `ATT-AC-003` | An unauthenticated scan produces no attendance | `ATT-FR-018` |
| `ATT-AC-004` | A QR bound to tenant A, scanned by a student of tenant B, is rejected and does not fall back | `ATT-BR-010` |
| `ATT-AC-005` | A revoked QR produces no attendance and returns a specific reason | `ATT-FR-016`, `ATT-FR-018` |
| `ATT-AC-006` | An inactive (never activated) QR produces no attendance | `ATT-FR-013` |
| `ATT-AC-007` | Replacing a QR leaves previously recorded attendance intact | `ATT-FR-015` |
| `ATT-AC-008` | Activation, replacement and revocation each produce an audit fact | `ATT-FR-017` |
| `ATT-AC-009` | A QR payload inspection finds no password, OTP, token, credential or identity value | `ATT-XC-012` |
| `ATT-AC-010` | Two entrance-associated QRs are distinguishable on the resulting records | `ATT-FR-014` |
| `ATT-AC-011` | Every rejection returns a distinguishable reason; none is silent | `ATT-BR-011` |
| `ATT-AC-012` | Client-side manipulation of the validation result does not produce attendance | `ATT-FR-011` |
| `ATT-AC-013` | Documentation offering Fixed QR states its presence-proof limitation | `ATT-BR-012` |

### 30.2 Student App — Dynamic QR (mode 2)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-014` | A currently-valid dynamic code produces exactly one check-in | `ATT-FR-021` |
| `ATT-AC-015` | An expired code is rejected with "expired", distinct from "invalid" | `ATT-FR-026` |
| `ATT-AC-016` | A code replayed after consumption produces no second attendance for that student-day | `ATT-FR-027`, `ATT-FR-094` |
| `ATT-AC-017` | Codes rotate at the configured interval | `ATT-FR-025`, `ATT-CFG-005` |
| `ATT-AC-018` | A code valid for tenant A is rejected for tenant B | `ATT-FR-023` |
| `ATT-AC-019` | Twenty students scanning the same valid code concurrently each get an independent outcome | `ATT-FR-028`, `ATT-BR-014` |
| `ATT-AC-020` | A client-supplied timestamp does not affect validity | `ATT-FR-029`, `ATT-BR-015` |
| `ATT-AC-021` | With the mode disabled, a displayed code produces no attendance | `ATT-FR-030` |
| `ATT-AC-022` | Enabling Dynamic QR does not enable, disable or alter Fixed QR | `ATT-BR-013` |
| `ATT-AC-023` | Expiry evaluation is unaffected by manipulating the client clock | `ATT-FR-022` |

### 30.3 Fixed QR + Wi-Fi (mode 3)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-024` | QR valid + approved network → check-in recorded | `ATT-FR-031` |
| `ATT-AC-025` | QR valid + unapproved network → rejected, no record | `ATT-FR-035`, `ATT-FR-036` |
| `ATT-AC-026` | QR valid + Wi-Fi unavailable → rejected with a distinct reason | `ATT-FR-034` |
| `ATT-AC-027` | A mode-3 failure never downgrades to a mode-1 record | `ATT-FR-036` |
| `ATT-AC-028` | The Wi-Fi outcome appears in the punch's verification evidence | `ATT-FR-037` |
| `ATT-AC-029` | Tenant A's approved network does not validate tenant B's attendance | `ATT-BR-017` |
| `ATT-AC-030` | Mode 3 cannot be enabled with no approved network configured | `ATT-CFG-008` |
| `ATT-AC-031` | Wi-Fi configuration changes produce an audit fact | `ATT-FR-038` |
| `ATT-AC-032` | With modes 1 and 3 both enabled, a mode-1 attendance performs no Wi-Fi check | `ATT-BR-007` |
| `ATT-AC-033` | No product surface or document describes Wi-Fi as identity or as preventing sharing | `ATT-XC-014` |

### 30.4 Fixed QR + GPS (mode 4)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-034` | QR valid + inside radius → check-in recorded | `ATT-FR-040` |
| `ATT-AC-035` | QR valid + outside radius → rejected with "outside library area" | `ATT-FR-046` |
| `ATT-AC-036` | Location unavailable → rejected with a distinct reason | `ATT-FR-043` |
| `ATT-AC-037` | Permission denied → distinct reason, not reported as a system error | `ATT-FR-044` |
| `ATT-AC-038` | Accuracy worse than threshold → rejected with "inaccurate" | `ATT-FR-045`, `ATT-CFG-012` |
| `ATT-AC-039` | A mode-4 failure never downgrades to a mode-1 record | `ATT-FR-047` |
| `ATT-AC-040` | The location outcome appears in verification evidence | `ATT-FR-048` |
| `ATT-AC-041` | Radius outside its allowed range is rejected at configuration time | `ATT-CFG-011` |
| `ATT-AC-042` | Coordinate and radius changes produce an audit fact | `ATT-FR-049` |
| `ATT-AC-043` | With modes 1 and 4 both enabled, a mode-1 attendance performs no location check | `ATT-BR-007` |
| `ATT-AC-044` | GPS configuration is tenant-scoped | `ATT-BR-019` |
| `ATT-AC-045` | No surface describes GPS as identity | `ATT-XC-016` |

### 30.5 Face (mode 5)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-046` | A face match above threshold for an enrolled student produces exactly one check-in, with no QR, GPS or Wi-Fi involved | `ATT-BR-020`, `ATT-FR-051` |
| `ATT-AC-047` | An unenrolled student produces no attendance | `ATT-FR-052` |
| `ATT-AC-048` | Enrollment without a recorded consent is refused | `ATT-FR-053` |
| `ATT-AC-049` | A match below threshold is treated as no match | `ATT-FR-055` |
| `ATT-AC-050` | An unknown face produces no attendance | `ATT-FR-056` |
| `ATT-AC-051` | Multiple detected faces produce a distinct failure, never a guess | `ATT-FR-057` |
| `ATT-AC-052` | Two students matching above threshold produce an ambiguity rejection | `ATT-FR-058` |
| `ATT-AC-053` | A failed match is reportable so staff can serve the student another way | `ATT-FR-059` |
| `ATT-AC-054` | Face attendance obeys the same duplicate rules as other modes | `ATT-FR-060` |
| `ATT-AC-055` | Where liveness is available, a failed liveness result prevents attendance | `ATT-FR-063` |
| `ATT-AC-056` | A student enrolled at tenant A is not matchable at tenant B | `ATT-BR-021` |
| `ATT-AC-057` | Withdrawal from face verification leaves attendance history intact | `ATT-BR-022` |
| `ATT-AC-058` | Enrollment, withdrawal and configuration changes each produce an audit fact | `ATT-FR-062` |
| `ATT-AC-059` | No face template or raw image appears in any event payload or audit record | `ATT-XC-008` |
| `ATT-AC-060` | Face verification never issues, extends or affects a `BC-18` session | `ATT-XC-018` |
| `ATT-AC-061` | With `ATT-GAP-012`/`014` unresolved, the mode is not implemented | `ATT-FR-064` |

### 30.6 Manual — individual entry (mode 6, §13A)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-062` | Reception selects a student and records attendance; exactly one check-in results | `ATT-FR-065`, `ATT-FR-066` |
| `ATT-AC-063` | The record carries all ten required fields of `ATT-FR-067` | `ATT-FR-067` |
| `ATT-AC-064` | The record's method is `MANUAL` and its source is `MANUAL_STAFF_ENTRY` | `ATT-FR-067` |
| `ATT-AC-065` | No process rewrites a manual record's method to any other mode | `ATT-BR-024`, `ATT-FR-008` |
| `ATT-AC-066` | Manual entry for an already-open presence resolves as duplicate check-in | `ATT-FR-068`, `ATT-FR-093` |
| `ATT-AC-067` | Every manual entry produces an audit fact naming the staff actor | `ATT-FR-069` |
| `ATT-AC-068` | Staff cannot record attendance for a student outside the active tenant | `ATT-BR-025` |
| `ATT-AC-069` | A student with no device and no other enabled mode can still be recorded present | `ATT-BR-008`, `ATT-BR-023` |
| `ATT-AC-070` | Manual mode is enabled by default in a tenant that has configured nothing | `ATT-CFG-017`, `ATT-BR-038` |

### 30.7 Manual — register image → OCR/Vision (§13B)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-071` | An uploaded register image is processed and detected entries are presented, not created | `ATT-FR-071`, `ATT-BR-028` |
| `ATT-AC-072` | Every record produced carries method `MANUAL` | `ATT-FR-072` |
| `ATT-AC-073` | The workflow introduces no seventh mode | `ATT-FR-072`, `ATT-XC-010` |
| `ATT-AC-074` | Matching resolves against authoritative student records, not a local directory | `ATT-FR-073` |
| `ATT-AC-075` | A 50-entry register produces 50 independent transactions; one failure does not roll back the others | `ATT-FR-006` |
| `ATT-AC-076` | With `ATT-GAP-010`/`011` unresolved, the workflow is not implemented, and §13A is unaffected | `ATT-FR-080` |

### 30.8 OCR failure → manual verification (§13C)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-077` | An undetectable entry enters `NEEDS_MANUAL_VERIFICATION` | `ATT-FR-074` |
| `ATT-AC-078` | An unreadable entry enters `NEEDS_MANUAL_VERIFICATION` | `ATT-FR-074` |
| `ATT-AC-079` | An ambiguous multi-student match enters `NEEDS_MANUAL_VERIFICATION` | `ATT-FR-074` |
| `ATT-AC-080` | An incomplete detection enters `NEEDS_MANUAL_VERIFICATION` | `ATT-FR-074` |
| `ATT-AC-081` | **No attendance record exists for any entry still in `NEEDS_MANUAL_VERIFICATION`** | `ATT-INV-009` |
| `ATT-AC-082` | Staff can review the source image, inspect detections, select the student, correct values, confirm, and reject | `ATT-FR-075` |
| `ATT-AC-083` | A rejected entry creates no attendance and is auditable | `ATT-FR-076` |
| `ATT-AC-084` | A high-confidence detection matching no authoritative student still enters `NEEDS_MANUAL_VERIFICATION` | `ATT-BR-027` |
| `ATT-AC-085` | With unattended creation disabled (default), no entry is created without staff confirmation | `ATT-CFG-020`, `ATT-BR-028` |
| `ATT-AC-086` | The audit chain links image → detection → match → verification → record → corrections | `ATT-FR-078` |

### 30.9 Entry / exit determinism (§14)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-087` | No open presence + check-in → check-in recorded | `ATT-FR-081` r1 |
| `ATT-AC-088` | Open presence + check-in → duplicate; existing presence unchanged | `ATT-FR-081` r2 |
| `ATT-AC-089` | Open presence + check-out → check-out recorded | `ATT-FR-081` r3 |
| `ATT-AC-090` | No open presence + check-out → rejected, no record | `ATT-FR-081` r4 |
| `ATT-AC-091` | Check-out cannot be recorded with a time earlier than its check-in | `ATT-INV-002` |
| `ATT-AC-092` | With check-out disabled, a check-in-only day is valid, not an error | `ATT-BR-029` |
| `ATT-AC-093` | A missed check-out is marked, never auto-completed with an invented time | `ATT-FR-082`, `ATT-BR-030` |
| `ATT-AC-094` | A missed check-out does not retract the check-in | `ATT-BR-031` |
| `ATT-AC-095` | No `StudentCheckedOut` event is emitted for a missed check-out | `ATT-FR-083` |
| `ATT-AC-096` | An invalid sequence leaves no intermediate state | `ATT-FR-087` |
| `ATT-AC-097` | A policy change does not reclassify an existing record | `ATT-FR-089` |
| `ATT-AC-098` | No domain timestamp originates from `DateTime.now()` or the client | `ATT-FR-088` |

### 30.10 Duplicate, concurrency, volume (§15)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-099` | Same idempotency key retried → original outcome, no second punch | `ATT-FR-090`, `ATT-FR-091` |
| `ATT-AC-100` | Concurrent check-ins for one student → exactly one open presence | `ATT-FR-084`, `ATT-INV-004` |
| `ATT-AC-101` | Concurrent check-outs for one student → exactly one closed presence | `ATT-FR-085` |
| `ATT-AC-102` | Simultaneous check-in and check-out reach a deterministic final state | `ATT-FR-086` |
| `ATT-AC-103` | QR check-in followed by manual entry produces no second open presence | `ATT-FR-093`, `ATT-BR-035` |
| `ATT-AC-104` | **50+ students checking in within one burst all succeed, with every §6.2 invariant intact** | `ATT-FR-096`, `ATT-NFR-002` |
| `ATT-AC-105` | Two different students checking in concurrently do not contend | `ATT-NFR-001` |
| `ATT-AC-106` | Idempotency keys are tenant-scoped | `ATT-FR-092`, `ATT-FR-126` |

### 30.11 Owner configuration (§16)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-107` | Each of the six modes can be enabled and disabled **independently**, without affecting the other five | `ATT-FR-099` |
| `ATT-AC-108` | No RFID mode appears in any configuration surface | `ATT-FR-100`, `ATT-XC-010` |
| `ATT-AC-109` | An invalid configuration value is rejected, is not partially applied, and the previous value stands | `ATT-FR-101`, `ATT-FR-102` |
| `ATT-AC-110` | A configuration change affects only subsequent operations | `ATT-FR-103` |
| `ATT-AC-111` | Disabling a mode stops new attendance but retracts none already recorded | `ATT-FR-104` |
| `ATT-AC-112` | Every configuration change produces an audit fact with the actor | `ATT-FR-105` |

### 30.12 Tenancy, authorization, events, boundary

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-113` | Every attendance-owned artefact in `ATT-FR-124` carries `tenantId`; the Multi-Tenant Test Suite finds no cross-tenant read | `ATT-INV-012`, `ATT-FR-124` |
| `ATT-AC-114` | Missing or ambiguous tenant context fails closed and never defaults to a tenant | `ATT-FR-127` |
| `ATT-AC-115` | A parent can read guarded students' attendance and cannot create, correct or delete any | `ATT-FR-004`, `ATT-FR-119` |
| `ATT-AC-116` | A `reception` role at library A grants nothing at library B | `ATT-FR-121` |
| `ATT-AC-117` | Exactly four `attendance.*` events are published, with the BC Map §9 names, and no other | `ATT-FR-134`, `ATT-EVT-001`…`004` |
| `ATT-AC-118` | **No `SeatAllocation` or `SeatLayout` is ever created, modified, deleted or read by this module; the only `BC-04` contact is the `E-08` event, and no attendance QR assigns a seat** | `ATT-FR-138`, `ATT-FR-139`, `ATT-FR-144` |

### 30.13 Ownership, roles and scope (§3)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-119` | Every attendance fact in the system is reachable through an `AttendanceDay` owned by this module; no attendance fact exists outside it | `ATT-FR-001` |
| `ATT-AC-120` | **No aggregate belonging to another bounded context is created, mutated or deleted by any attendance path, in any mode, by any actor** | `ATT-FR-002`, `ATT-INV-001` |
| `ATT-AC-121` | Only the five Master PRD §6 roles appear in any attendance surface, permission or fixture; a sixth role name appears nowhere | `ATT-FR-003` |
| `ATT-AC-122` | Every attendance permission resolves to a scope drawn from the closed register `self` / `guardianOf` / `tenantWide`, and an out-of-register scope is rejected | `ATT-FR-005`, `ATT-BR-001` |
| `ATT-AC-123` | An actor holding a permission but failing its scope on a given record is denied, proving permission and scope are evaluated separately | `ATT-BR-001` |
| `ATT-AC-124` | Stored `VerificationEvidence` describes what was verified and contains no identity attribute beyond the `StudentRecordId` reference | `ATT-BR-002` |

### 30.14 Mode set and mode independence (§7)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-125` | Exactly six attendance modes exist; a seventh cannot be configured, recorded or referenced | `ATT-FR-007` |
| `ATT-AC-126` | Each of the six modes can be enabled or disabled per tenant with no effect on the other five | `ATT-FR-009` |
| `ATT-AC-209` | **A tenant with every mode disabled is accepted by configuration validation; no "at least one mode must be enabled" rule is enforced while `ATT-GAP-018` is open** | `ATT-FR-106` |
| `ATT-AC-127` | **With several modes enabled, a student completing any one enabled mode obtains attendance without performing a second method** | `ATT-BR-004`, `ATT-BR-005` |
| `ATT-AC-128` | Modes 3 and 4 are recorded as one `AttendanceMethod` each, not as a QR punch plus a separate Wi-Fi or GPS punch | `ATT-BR-006` |
| `ATT-AC-129` | A single operation mutates exactly one `AttendanceDay`; no path mutates two aggregates in one transaction | `ATT-BR-003` |

### 30.15 Mode-level rules not covered above (§8–§13)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-130` | A fixed QR is bound to exactly one tenant and is rejected when presented in another | `ATT-FR-012` |
| `ATT-AC-131` | A fixed QR carries no credential and cannot authenticate a session | `ATT-BR-009` |
| `ATT-AC-132` | A dynamic code outside its validity window is rejected as expired | `ATT-FR-024` |
| `ATT-AC-133` | Approved networks are configurable per tenant and owned by the Owner role through `BC-25` | `ATT-FR-032`, `ATT-FR-033` |
| `ATT-AC-134` | Wi-Fi evidence is recorded as environment verification and is never used to identify the student | `ATT-BR-016` |
| `ATT-AC-135` | Library coordinates and acceptance radius are configurable per tenant, with the radius bounded | `ATT-FR-041`, `ATT-FR-042` |
| `ATT-AC-136` | GPS evidence is recorded as environment verification and is never used to identify the student | `ATT-BR-018` |
| `ATT-AC-137` | **No Owner-facing surface, document string or help text describes mode 3 as spoofing-resistant or mode 4 as location-spoofing-resistant while `ATT-GAP-007` / `ATT-GAP-008a` are open** | `ATT-FR-039`, `ATT-FR-050` |
| `ATT-AC-138` | A face match resolves to exactly one enrolled `StudentRecordId` within the tenant, and an ambiguous match produces no attendance | `ATT-FR-054` |
| `ATT-AC-139` | Face verification supports check-out wherever the tenant has check-out enabled | `ATT-FR-061` |
| `ATT-AC-140` | A second manual workflow for high-volume register capture exists and is distinct from individual entry | `ATT-FR-070` |
| `ATT-AC-141` | The OCR high-confidence threshold is configurable and governs which entries are presented as high-confidence | `ATT-FR-077` |
| `ATT-AC-142` | The register-image workflow is recorded as Manual mode, never as a seventh mode, and never as authentication | `ATT-BR-026` |
| `ATT-AC-143` | No attendance-specific audit store and no attendance-specific file store exists in the module, and no audit record has an update or delete path | `ATT-FR-079`, `ATT-FR-130` |

### 30.16 Invariants, timing and concurrency (§6, §14, §15)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-144` | Concurrent scans by the same student produce exactly one state transition | `ATT-FR-020`, `ATT-INV-010` |
| `ATT-AC-145` | Idempotency is enforced inside the aggregate boundary; a check-then-write implementation fails this criterion under concurrent load | `ATT-BR-034` |
| `ATT-AC-146` | A transport-level replay is absorbed by idempotency and creates no second record | `ATT-FR-095` |
| `ATT-AC-147` | Every `AttendanceDay` carries exactly one `tenantId` and every punch within it belongs to that tenant | `ATT-INV-006` |
| `ATT-AC-148` | Every punch records exactly one `AttendanceMethod` drawn from the six V1 modes | `ATT-INV-007` |
| `ATT-AC-149` | **No stored attendance fact can be destructively updated or deleted; the append-only correction record is the only mutation path** | `ATT-INV-008` |
| `ATT-AC-150` | Every timestamp is timezone-explicit and resolved against the tenant's configured zone, never server local time | `ATT-BR-032`, `ATT-NFR-011` |
| `ATT-AC-151` | Throughput is achieved without relaxing an invariant, batching across aggregates or deferring duplicate detection | `ATT-BR-036` |
| `ATT-AC-152` | No second presence or "currently inside" system of record exists beyond the `AttendanceDay` aggregate, no shadow copy of seat occupancy is held here, and no attendance record is ever reconciled backwards from an occupancy state | `ATT-BR-033`, `ATT-FR-140`, `ATT-BR-045` |

### 30.17 Corrections, audit and authorization (§18–§20)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-153` | Authorised staff can correct a record, and the correction emits `attendance.AttendanceCorrected` | `ATT-FR-110`, `ATT-FR-111` |
| `ATT-AC-154` | A correction never changes the recorded `AttendanceMethod` of the original punch | `ATT-FR-112` |
| `ATT-AC-155` | A correction is subject to the same authorisation and tenant rules as creation | `ATT-FR-113` |
| `ATT-AC-156` | A missed check-out can be corrected, and the record shows both the original missed state and the correction | `ATT-FR-114` |
| `ATT-AC-157` | A correction outside a configured correction window is rejected with a specific reason | `ATT-FR-115`, `ATT-CFG-023` |
| `ATT-AC-158` | The full correction history is retrievable by an authorised actor, is append-only, and carries actor and reason on every entry | `ATT-FR-116`, `ATT-INV-005`, `ATT-INV-011`, `ATT-BR-040` |
| `ATT-AC-159` | Every attendance operation is authorised by `BC-18`; no authorisation decision is evaluated, granted, cached or inferred locally | `ATT-FR-117` |
| `ATT-AC-160` | No new RBAC system, role, permission model or scope is defined by this module | `ATT-FR-118` |
| `ATT-AC-161` | An account holding no role in the active tenant is treated exactly as an account with no access | `ATT-FR-120` |
| `ATT-AC-162` | A detected fraud signal is recordable and emits `attendance.FraudSignalDetected` | `ATT-FR-122` |
| `ATT-AC-163` | **No attendance record, evidence object, event payload, audit fact or log line contains a password, OTP, session token, credential or key** | `ATT-FR-123`, `ATT-FR-133` |
| `ATT-AC-164` | `StudentRecordId` never appears in any artefact crossing a tenant boundary | `ATT-FR-125` |
| `ATT-AC-165` | A suspended tenant rejects attendance writes | `ATT-FR-128` |
| `ATT-AC-166` | Audit facts reach `BC-24` via `E-20` as fire-and-forget outbox-backed events, with no synchronous audit call on any attendance path | `ATT-FR-129`, `ATT-PO-009` |
| `ATT-AC-167` | Each occurrence listed in `ATT-FR-131` produces an audit fact carrying the acting actor and the tenant of record | `ATT-FR-131`, `ATT-FR-132` |

### 30.18 Ports, events and downstream boundary (§5, §22, §23, §24, §27)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-168` | Membership validity is consumed as a read projection through `E-03` and is never written by this module | `ATT-PO-001` |
| `ATT-AC-169` | Attendance rules are consumed from `BC-06` through `E-04` and are conformed to without local translation or reinterpretation | `ATT-PO-002` |
| `ATT-AC-170` | An entitlement check runs through `E-17` **before** the aggregate mutates | `ATT-PO-003` |
| `ATT-AC-171` | Tenant context arrives ambiently through `E-18` and appears as no domain method parameter | `ATT-PO-004` |
| `ATT-AC-172` | Configuration is read through `E-19` typed accessors, with no raw string lookup and no local configuration store | `ATT-PO-005`, `ATT-FR-097`, `ATT-FR-098` |
| `ATT-AC-173` | The authenticated actor arrives from a `BC-18` session established before the operation; this module performs no authentication | `ATT-PO-007` |
| `ATT-AC-174` | Notification-relevant occurrences leave as facts through `E-23`; no channel, template, quiet-hour rule or dispatch exists here | `ATT-PO-010`, `ATT-FR-148` |
| `ATT-AC-175` | Check-in and check-out events reach `BC-04` through `E-08` carrying a stable event identifier, and Seating remains the occupancy owner | `ATT-PO-008`, `ATT-FR-141` |
| `ATT-AC-176` | A redelivered event represents no new fact, and attendance completes without `BC-04` having processed anything | `ATT-FR-136`, `ATT-FR-142` |
| `ATT-AC-177` | **No check-out event is emitted for a check-out that did not occur** | `ATT-FR-143` |
| `ATT-AC-178` | Event names follow `<Context>.<Aggregate><PastTenseVerb>`; no imperative name enters the bus | `ATT-FR-135` |
| `ATT-AC-179` | The four events are published as facts to the backbone with no direct edge to `BC-26` or `BC-13`, and no attendance path depends on either consuming them | `ATT-FR-137` |
| `ATT-AC-180` | Operational facts are exposed as reads of the attendance aggregate, are never labelled certified metrics, and no report, metric definition or read model is built here | `ATT-FR-145`, `ATT-FR-146`, `ATT-FR-147` |
| `ATT-AC-181` | The conflict-resolution policy for replayed mutations is defined here and executed by `BC-30`; no queue, replay loop or conflict detector exists in this module | `ATT-PO-006`, `ATT-PO-011` |
| `ATT-AC-182` | A replayed punch is absorbed by idempotency rather than applied twice, and preserves every §6.2 invariant | `ATT-PO-012` |
| `ATT-AC-183` | A replayed punch never overwrites a correction made while the device was offline | `ATT-PO-013` |
| `ATT-AC-184` | **No surface, document string or configuration promises offline Dynamic QR while `ATT-GAP-016a` is open** | `ATT-PO-014`, `ATT-NFR-012` |

### 30.19 Exclusions, configurables and non-functional obligations (§16, §17, §28, §29)

| ID | Criterion | Verifies |
|---|---|---|
| `ATT-AC-185` | **No staff attendance is recorded, stored, corrected or represented, including in the data model** | `ATT-XC-001` |
| `ATT-AC-186` | The module ships inside the monolith as a module, not as a separate service, process or deployable | `ATT-XC-002` |
| `ATT-AC-187` | **No integration edge to `BC-26`, `BC-13`, `BC-29`, `BC-27`, `BC-23`, `BC-31` or `BC-11`…`BC-17` exists in code, configuration or dependency graph** | `ATT-XC-003`, `ATT-XC-004`, `ATT-XC-005`, `ATT-XC-006` |
| `ATT-AC-188` | No attendance path reads from or writes to another bounded context's database, table or store | `ATT-XC-007` |
| `ATT-AC-189` | No distributed transaction, two-phase commit or cross-aggregate lock is used, and none is required | `ATT-XC-009`, `ATT-NFR-013` |
| `ATT-AC-190` | **No generic verification layer, pipeline or chain exists, and no attendance requires a sequence of modes** | `ATT-XC-011` |
| `ATT-AC-191` | The document specifies no dynamic-QR cryptography, no network-identification or spoof-detection mechanism, no mock-location detection, no liveness algorithm and no biometric storage design | `ATT-XC-013`, `ATT-XC-015`, `ATT-XC-017`, `ATT-XC-019`, `ATT-XC-020` |
| `ATT-AC-192` | No Device Management bounded context, device lifecycle, provisioning, pairing, firmware or inventory capability is created | `ATT-XC-021`, `ATT-FR-107`, `ATT-FR-108`, `ATT-FR-109` |
| `ATT-AC-193` | `BC-18`'s `Device` is never used as an attendance scanner, and no attendance-hardware record is stored in `BC-18`'s model | `ATT-BR-039` |
| `ATT-AC-194` | **No surface claims QR = authentication, GPS = identity, Wi-Fi = identity, OCR = authentication, or OCR = definitive identity without verification** | `ATT-BR-041` |
| `ATT-AC-195` | Where a protection is bounded, the bound is stated rather than the protection overstated | `ATT-BR-042` |
| `ATT-AC-196` | "Attendance Method" set in the Library module changes behaviour owned here, and the Library module implements none of that behaviour | `ATT-BR-037` |
| `ATT-AC-197` | Each of the six mode-enable configurables independently controls exactly its own mode | `ATT-CFG-001`, `ATT-CFG-002`, `ATT-CFG-003`, `ATT-CFG-004`, `ATT-CFG-016` |
| `ATT-AC-198` | **Every** configurable in §16.3 is validated before persistence, rejects an out-of-domain value, and takes effect only at its stated effective point — including each of the six whose default and allowed range were decided by the Product Owner | `ATT-CFG-005`, `ATT-CFG-006`, `ATT-CFG-007`, `ATT-CFG-009`, `ATT-CFG-010`, `ATT-CFG-011`, `ATT-CFG-012`, `ATT-CFG-013`, `ATT-CFG-015`, `ATT-CFG-018`, `ATT-CFG-019`, `ATT-CFG-021`, `ATT-CFG-022`, `ATT-CFG-023`, `ATT-CFG-024` |
| `ATT-AC-199` | **Each of the six V1 configurables formerly blocked by `ATT-GAP-017` carries the exact default and allowed range its owner decided — `ATT-CFG-005` 30 s / 15–120 s, `ATT-CFG-006` 60 s / 30–300 s, `ATT-CFG-011` 50 m / 20–200 m, `ATT-CFG-012` 30 m / 5–100 m, `ATT-CFG-019` 0.90 / 0.80–1.00, `ATT-CFG-023` 15 min / 0–60 min — no value is invented, widened or narrowed, and `ATT-CFG-014` presents no V1 default because Face is V3** | `ATT-CFG-005`, `ATT-CFG-006`, `ATT-CFG-011`, `ATT-CFG-012`, `ATT-CFG-014`, `ATT-CFG-019`, `ATT-CFG-023`, `ATT-BR-043` |

| `ATT-AC-200` | Every configuration change is audited with the acting actor and is tenant-resolvable | `ATT-CFG-001`…`ATT-CFG-024` |
| `ATT-AC-201` | **This document states no latency figure, throughput number or percentile target** | `ATT-NFR-003` |
| `ATT-AC-202` | Every attendance decision is reproducible from recorded evidence, the rules in force at the time, and the correction history | `ATT-NFR-004` |
| `ATT-AC-203` | Every rejection carries a specific, distinguishable reason; a generic failure fails this criterion | `ATT-NFR-005` |
| `ATT-AC-204` | Tenant isolation meets the `X-13` standard and is verified by the Multi-Tenant Test Suite | `ATT-NFR-006` |
| `ATT-AC-205` | No attendance operation depends on a synchronous call to `BC-22`, `BC-24` or `BC-26`, and the module remains functional when `BC-04` is unavailable | `ATT-NFR-007`, `ATT-NFR-008` |
| `ATT-AC-206` | **Stale or unavailable membership validity produces a flagged attendance record, never a blocked one** | `ATT-NFR-009` |
| `ATT-AC-207` | Every obligation in this document has at least one acceptance criterion, and any obligation without one is reported as unmet rather than assumed satisfied | `ATT-NFR-010` |
| `ATT-AC-208` | Manual-mode surfaces meet the same accessibility standard as the app modes, measured rather than asserted | `ATT-NFR-014` |
| `ATT-AC-210` | Enabling a mode whose required setting has no value is rejected with a reason naming the missing setting; the mode does not enable with an assumed value | `ATT-FR-149` |
| `ATT-AC-211` | No attendance is recorded, accepted or rejected by evaluating a setting that has no value; the operation fails closed instead | `ATT-FR-150` |
| `ATT-AC-212` | A tenant that has configured nothing can record attendance by Manual on day one; and every V1 setting among the seven now carries a default, so operability no longer depends on those settings being unreachable | `ATT-BR-044` |
| `ATT-AC-213` | A setting with no platform default is presented to the Owner as requiring an explicit value, never as a blank field carrying a default | `ATT-FR-151` |
| `ATT-AC-214` | **A value outside a configurable's stated allowed range is rejected before persistence with a specific reason and is not partially applied — including the cross-setting case of a rotation interval exceeding the validity window, which is rejected even though both values lie inside their own ranges** | `ATT-CFG-005`, `ATT-CFG-006`, `ATT-NFR-005` |

---

## 31. Traceability

### 31.1 Coverage summary

| Register | In force | Covered by ≥1 `ATT-AC` | Coverage |
|---|---|---|---|
| `ATT-FR-*` | 151 | 151 | **100%** |
| `ATT-BR-*` | 45 | 45 | **100%** |
| `ATT-INV-*` | 12 | 12 | **100%** |
| `ATT-EVT-*` | 4 | 4 | **100%** |
| `ATT-XC-*` | 21 | 21 | **100%** |
| `ATT-PO-*` | 14 | 14 | **100%** |
| `ATT-CFG-*` | 24 | 24 | **100%** |
| `ATT-NFR-*` | 14 | 14 | **100%** |
| **Obligation-bearing total** | **285** | **285** | **100%** |
| `ATT-GAP-*` | 18 | **0 — by design** | Gaps are questions, never criteria |

**No orphan requirement** (every obligation has a criterion) and **no orphan criterion** (all 213 criteria name at
least one requirement). These figures are **measured**, not asserted: the companion verification report records
the extraction method, the per-register counts and the reproducible command.

> **The denominator moved in v1.3, and the numerator moved with it.** Six obligations were added by the Stage 4
> findings reconciliation and **each arrived with its criterion in the same edit** — `ATT-BR-043` is verified by
> `ATT-AC-199`, and `ATT-FR-149`, `ATT-FR-150`, `ATT-BR-044`, `ATT-FR-151` by `ATT-AC-210`…`ATT-AC-213`
> respectively; `ATT-BR-045` is verified by `ATT-AC-152`. Coverage was re-measured after the edit rather than
> assumed to have survived it, which is the same discipline the retraction below records.

> **This table previously read 100% while the measured value was 49.1%** — 137 of 279 obligations, with 142 having
> no criterion at all. The claim was written before the criteria existed and was false. It was found by the
> mechanical pass this document's own `ATT-NFR-010` requires (*"a rule that cannot be checked **MUST** be treated
> as unmet"*), and it was fixed by **writing the 91 missing criteria (`ATT-AC-119`…`ATT-AC-209`), not by lowering
> the claim to match**. This mirrors `TR-2` in `PRD-005`, where a false 100% was retracted and the corrected
> figure published. A coverage number that has never been executed is a decorative number; this one has.

### 31.2 Upstream traceability

| This document | Traces to | Rank |
|---|---|---|
| `ATT-INV-003`, `ATT-FR-090` | `MP-GBR-18` idempotency | 1 |
| `ATT-INV-005`, `ATT-BR-040` | `MP-GBR-11` append-only corrections | 1 |
| `ATT-FR-089`, `ATT-FR-103` | `MP-GBR-19` non-retroactive policy | 1 |
| `ATT-NFR-009` | `MP-GBR-16` Attendance flags, Seating blocks | 1 |
| `ATT-FR-005`, `ATT-BR-001` | `MP-GBR-20`, `MP-GBR-21` scope rules | 1 |
| `ATT-XC-002` | `ADR-0001` modular monolith | 2 |
| `ATT-FR-097`, `ATT-FR-098` | `ADR-0017` `BC-25` ownership | 2 |
| `ATT-FR-117`, `ATT-FR-118` | Authentication PRD `AUTH-1.1`, `AUTH-2.*` | 3 |
| `ATT-FR-125` | `ID-2` tenant containment | 4 |
| `ATT-BR-037` | `LIB-16.4` reference settings | 3 |
| `ATT-FR-089`, `ATT-BR-032` | `LIB-12.8`, `LIB-12.4` | 3 |
| `ATT-FR-138`…`144` | `PRD-007` `SEAT-BR-020`, `SEAT-XC-012`, `SEAT-FR-109`…`115` | 3 |
| `ATT-INV-002`…`005`, §6.3 | BC Map §8 `AttendanceDay` invariants | 4 |
| `ATT-PO-001`…`010` | BC Map §7 `E-03`, `E-04`, `E-08`, `E-17`…`E-20`, `E-23`, `E-24` | 4 |
| `ATT-EVT-001`…`004` | BC Map §9 event surface | 4 |
| §5.5 | Dependency Matrix `L2`, `L3`, `X-01`…`X-13` | 4 |

---

## 32. Open Questions / Gaps

**Eighteen numbers, 21 rows — 18 still open. None is a requirement. None may be resolved by implementation
choice** (§0.4).

> **Re-audited in v1.1; `ATT-GAP-001` reconciled in v1.2; the count restated in v1.3.** The table below is the
> original register, preserved. **§32.1 is the resolution ledger** and is the authoritative status for each row.
>
> **The count is stated over the 21 rows, and a row is counted by the status in its own verdict cell:
> 2 resolved, 1 narrowed, 18 open.** Where a row's status changed, §32.1 states the source that changed it.
>
> **Read the denominator before comparing counts.** The register declares **18 numbers**; the ledger carries
> **21 rows**, because three suffixed successors (`ATT-GAP-008a`, `016a`, `017a`) are counted within their
> parent's number. Every count in this document is now stated over **rows**, so that a tool counting the ledger's
> verdict column and a reader counting the register reach the same three figures. **`ATT-GAP-012` is counted as
> OPEN**, which is what its verdict cell says: its *storage sub-question* is answered negatively, but the
> ownership question that defines the gap is not, and a partially answered gap is an open gap. The v1.1 and v1.2
> changelog entries state the earlier figures **3 resolved / 1 narrowed / 17 open**, which counted that partial
> answer as a resolution; **those figures are superseded by this row, and no gap's status changed to produce the
> new ones.**
>
> **The register still declares eighteen `ATT-GAP-*` numbers.** A resolved gap keeps its number — `PRD_LIFECYCLE.md`
> §5 rule 5: *"Numbers are never reused, even after withdrawal."* Resolution changes a row's **status**, never the
> register's size.

| ID | Question | Authoritative sources in tension | Owner who must decide | Blocks |
|---|---|---|---|---|
| **`ATT-GAP-001`** | ✅ **RESOLVED 2026-08-04 — this document is `PRD-006`.** *The question was:* is this PRD `PRD-006` or `PRD-008`? `PRD_REGISTRY.md` line 236 allocates **`PRD-006` = Attendance Management, `BC-03`**, and line 238 allocates **`PRD-008` = Revenue & Finance, `BC-05`**; frozen `PRD-007` refers to the Attendance PRD as **`PRD-006`** twice (§14, and its dependency table), while the authoring instruction had specified `PRD-008`. **Resolved by conforming this document to the standing allocation**, not by reassigning any number: registry §8 rule 1 (*"Numbers are never reused or reassigned"*) is **satisfied**, since `PRD-006` was already Attendance's and `PRD-008` remains reserved to Revenue & Finance. **No registry edit was required** and none was made. See §32.2 and [`PRD-006_NUMBERING_RECONCILIATION.md`](./PRD-006_NUMBERING_RECONCILIATION.md) | `PRD_REGISTRY.md` line **236** (allocation) · `PRD-007` v1.0 **FROZEN, Rank 3**, lines **223** and **862** — all three now **agree** with this document | *Was: registry owner + architecture owner.* **Closed by conformance** — no owner decision was needed, because no authority was in conflict with the registry | **Nothing.** This gap no longer blocks Stage 7 |
| **`ATT-GAP-002`** | ✅ **RESOLVED in v1.1 — see §32.1 and §5.2.** *The question was:* where is the authenticated `BC-18` context composed for a `BC-03` operation, given that `E-11` is `BC-18 → BC-01` and no `BC-18 → BC-03` edge exists? **Answered from existing governance, not by invention**: frozen `PRD-007` (Rank 3) consumes `BC-18` with **no `E-` edge** (its §3 context table, and `SEAT-BR-030`), so a Core context receiving an already-established session without its own inbound identity edge is a **ratified pattern**. Attendance receives the authenticated context from the application layer (`ATT-PO-007`) | BC Map §7.2 · frozen `PRD-007` §3, `SEAT-BR-030` — **no longer in tension** | *Was: architecture owner.* **Closed by an existing ratified pattern** — no owner decision was needed | **Nothing.** No `BC-18 → BC-03` edge is asserted or required |
| **`ATT-GAP-003`** | Is `BC-26` a consumer of `attendance.*`? BC Map §9 says yes for three events; §7 declares no edge | BC Map §9 vs §7 | Architecture owner | Analytics of attendance |
| **`ATT-GAP-004`** | Is `BC-13` a consumer of `attendance.FraudSignalDetected`? §9 says yes; §7 declares no edge | BC Map §9 vs §7 | Architecture owner | Fraud escalation |
| **`ATT-GAP-005`** | What is the retention period for attendance after enrollment archival? | BC Map `Q-04` **open** · `ID-5` requires retention | Legal counsel + architecture owner | Deletion behaviour |
| **`ATT-GAP-006`** | What cryptographic construction secures a dynamic QR code? | No Rank 1–5 source. Secrets owned by Security Platform | Security Platform owner | Dynamic QR build |
| **`ATT-GAP-007`** | How is an approved Wi-Fi network technically identified, and can spoofing be detected? | No Rank 1–5 source | Architecture owner | Mode 3 anti-spoof claims |
| **`ATT-GAP-008`** | Is the attendance GPS centre the same value as Library PRD `LIB-6.5` Map Location, or a separate attendance-owned value? | `LIB-6.5` (Rank 3) is silent on attendance use | Library PRD owner | Mode 4 configuration |
| **`ATT-GAP-008a`** | Is mock-location detection authorised, and who provides it? | No Rank 1–5 source | Architecture owner | Mode 4 anti-spoof claims |
| **`ATT-GAP-009`** | Which context owns attendance hardware lifecycle (face scanners, QR display points)? `BC-18` owns *auth* devices; `BC-08` Inventory is V2 | BC Map §3.1, §3.3 | Architecture owner | Face scanner management |
| **`ATT-GAP-010`** | May `BC-03` hold a `FileRef` from `BC-29`? `E-22`'s consumers are `BC-01`, `BC-10`, `BC-14` only | BC Map §7.3, `ADR-0016` | Architecture owner — needs an ADR (BC Map §7) | Register-image workflow |
| **`ATT-GAP-011`** | Who owns OCR/Vision processing? No OCR capability is defined anywhere in `docs/**`; no `BC-03` → `BC-27` edge | BC Map §7 · EA has no OCR node | Architecture owner — needs an ADR | Register-image workflow |
| **`ATT-GAP-012`** | Which context **owns and stores** biometric face-enrollment data? | No biometric architecture exists. `SXC-4` assigns a *photo* to `BC-01`, not a template to `BC-03` | Architecture owner + Security Platform | **Face mode entirely** |
| **`ATT-GAP-013`** | What liveness/anti-spoofing capability is available, and who provides it? | No Rank 1–5 source | Architecture owner | Liveness claims |
| **`ATT-GAP-014`** | What is the retention and deletion obligation for biometric data, including under `ID-5` erasure and for minors? | `ID-5`, `MP-GBR-04` constrain erasure; neither mentions biometrics | Legal counsel + Security Platform | **Face mode entirely** |
| **`ATT-GAP-015`** | Is Face attendance **V1** or **V3**? EA v2.1 lists `Face Recognition (V3)`; the product instruction says V1. EA is Rank 6 descriptive, but no Rank 1–5 document places it in V1 | EA v2.1 (Rank 6) vs product decision | Product owner + architecture owner | Face scheduling |
| **`ATT-GAP-016`** | What is the retention rule for an uploaded physical-register image containing many students' handwriting? | No source | Legal counsel + architecture owner | Register-image workflow |
| **`ATT-GAP-016a`** | What is the offline behaviour of Dynamic QR, which cannot be server-validated offline? | `E-24` exists; `MP-ASM-03` assumes offline capture; neither addresses rotating codes | Architecture owner | Offline Dynamic QR |
| **`ATT-GAP-017`** | What are the default values and allowed ranges for the seven numeric configurables marked unresolved in §16.3 (`ATT-CFG-005`, `006`, `011`, `012`, `014`, `019`, `023`)? | No Rank 1–5 source. `LIB-16.2` requires *every* setting to have a documented default | Product owner | Those seven configurables |
| **`ATT-GAP-017a`** | What are the latency/throughput targets for attendance capture? | No Rank 1–5 source; EA states no figure | Product owner + architecture owner | `ATT-NFR-003` |
| **`ATT-GAP-018`** | Is an "at least one mode enabled" constraint authorised? | No Rank 1–5 source | Product owner | `ATT-FR-106` |

**Count note.** The register declares `ATT-GAP-001`…`018` (18). Three suffixed entries — `ATT-GAP-008a`,
`ATT-GAP-016a`, `ATT-GAP-017a` — follow the suffixed-successor precedent used by `PRD-005` (`MM-GAP-010a`) and are
counted within their parent's number, giving **21 rows against 18 numbers**. This is stated rather than hidden.

### 32.1 Gap resolution ledger — the re-audit result

Every one of the 21 rows was re-tested against authoritative sources. A row moves out of `OPEN` **only** when a
Rank 1–5 document, a frozen PRD or an accepted ADR decides it. **Nothing here is resolved by preference,
inference from silence, or convenience.** Where no source exists, the row says so and names who must decide.

| Gap | Verdict | Basis, or why it cannot close |
|---|---|---|
| `ATT-GAP-001` | ✅ **RESOLVED** | See §32.2. **No two authorities were ever in conflict** — the registry (line 236) and frozen `PRD-007` (lines 223, 862) always agreed on `PRD-006`; only this draft's filename and header dissented, and a draft has no standing against either. Closed by **conforming the draft**, which required no registry edit, no renumbering and no ADR. |
| `ATT-GAP-002` | ✅ **RESOLVED** | Frozen `PRD-007` (Rank 3) consumes `BC-18` with **no `E-` edge** — §3 context table, `SEAT-BR-030`. A Core context receiving an established session without its own identity edge is a **ratified pattern**. Applied at §5.2. |
| `ATT-GAP-003` | 🔴 **OPEN — inherited, not owned** | BC Map §9 names `BC-26` a consumer; §7 declares no edge. This is the **systemic** `SM-GAP-11`/`MM-GAP-010` defect affecting ten producing contexts. `ADR-0018` §3.2 states resolution *"requires the architecture owner and a separate ADR."* Frozen `PRD-004` and `PRD-005` both declined to resolve it; **this document follows the frozen precedent exactly.** |
| `ATT-GAP-004` | 🔴 **OPEN — and materially worse than `003`** | Same §9-vs-§7 shape, but `BC-13`'s inbound edge situation is *not* the analytics one. BC Map §6 rule 2: *"`BC-13` acts **on** other contexts, not beside them… T&S publishes `EnforcementActionTaken` events and other contexts subscribe and self-restrict. **T&S never reaches into their models.**"* `E-14`'s targets are `BC-11`, `BC-12`, `BC-14`, `BC-15` — **`BC-03` is not among them**, so `BC-03` is not even a self-restriction subscriber. Fraud escalation has **no authorised path in either direction**. Architecture owner. |
| `ATT-GAP-005` | 🔴 **OPEN — upstream question already open** | BC Map `Q-04` is open *in the authoritative document itself* (L543), with only an unratified note: *"default 7 years financial, 2 years attendance."* A PRD may not promote an architecture document's own open question to an answer. Legal counsel + architecture owner. |
| `ATT-GAP-006` | 🔴 **OPEN** | No Rank 1–5 source defines a cryptographic construction. Secrets are `BC-25`'s *references* only (BC Map L134); the construction is Security Platform's. Inventing one here would be a security design, which §0.4 forbids. |
| `ATT-GAP-007` | 🔴 **OPEN** | No source identifies a network technically or authorises spoof detection. `ATT-FR-039`'s prohibition on anti-spoof claims stands. |
| `ATT-GAP-008` | 🔴 **OPEN — Library PRD owner** | `LIB-6.5` Map Location is owned by `BC-06` and is silent on attendance use. Merging the two values would take ownership of a Rank 3 field. |
| `ATT-GAP-008a` | 🔴 **OPEN** | No source authorises mock-location detection. `ATT-FR-050` stands. |
| `ATT-GAP-009` | 🔴 **OPEN — a genuine V1 hole** | `BC-18` owns `Device` for *authentication* (L380); `BC-08` owns physical devices but is **V2** (L103). **No V1 context can own a V1 face scanner's lifecycle.** Architecture owner. |
| `ATT-GAP-010` | 🔴 **OPEN — needs an ADR; precedent named** | `E-22` excludes `BC-03` (L331); L292 makes the edge non-existent. **`ADR-0016` is the exact precedent** — it added `BC-10` to this same consumer list, on the finding that a Rank 3 requirement depended on an edge §7 said did not exist. The mechanism to close this is therefore *known and proven*; only the decision is missing. **This document does not make it** — and unlike `ADR-0016`'s trigger, no Rank 3 requirement compels `BC-03`'s inclusion, so the case is weaker, not stronger. |
| `ATT-GAP-011` | 🟡 **NARROWED — direction resolved, ownership open** | BC Map §7.4 `F-1`/`F-3`/`F-4` + `MP-GBR-29`…`32` settle the direction and the approval requirement (§5.4). **The requested `BC-03` → `BC-27` edge is refuted, not granted.** Remaining question, stripped of its false edge component: *which context owns an OCR/Vision capability?* Zero hits for `OCR`/`vision`/`document AI` across `docs/**`, including EA's AI tree; `BC-27`'s charter (L136) contains no vision function. Architecture owner. |
| `ATT-GAP-012` | 🔴 **OPEN — storage sub-question RESOLVED negatively** | §12.4a rows 1 and 5. Ownership: unassigned by every source. Storage: **settled** — `BC-03` has no `E-22` path, so it cannot store a template at all. The gap is narrowed to ownership. |
| `ATT-GAP-013` | 🔴 **OPEN** | §12.4a row 4 — the only `liveness` hits in the repository are infrastructure health probes. No biometric liveness capability exists. |
| `ATT-GAP-014` | 🔴 **OPEN — and now shown to be a conflict, not a void** | §12.4a row 7. `ID-5`/`MP-GBR-04` promise erasure by **pseudonymisation**, which is structurally inapplicable to a template that *is* the identifier. Legal counsel + Security Platform. |
| `ATT-GAP-015` | 🔴 **OPEN — correctly framed, cannot self-close** | EA v2.1 lists `Face Recognition (V3)` (L754) but is **Rank 6, descriptive only** — Baseline §4: *"Update it to match 1–5; never the reverse."* EA therefore cannot *force* V3. **But no Rank 1–5 document places Face in V1 either**, so the product instruction cannot be ratified from sources. Product owner + architecture owner. Note this gap is **currently moot in effect**: `ATT-FR-064` blocks the build regardless of version class. |
| `ATT-GAP-016` | 🔴 **OPEN — legal counsel** | No retention source. Aggravating factor recorded at §13E: the image carries **third-party** handwriting. |
| `ATT-GAP-016a` | 🔴 **OPEN** | `E-24` and `MP-ASM-03` exist; neither addresses a rotating code that cannot be validated offline. `ATT-PO-014`/`ATT-NFR-012` prohibitions stand. |
| `ATT-GAP-017` | 🔴 **OPEN — and it is a live `LIB-16.2` breach** | Seven configurables have no default. `LIB-16.2` (Rank 3): *"Every setting **MUST** have a documented default."* Inventing seven numbers would satisfy the letter and destroy the point. Product owner. Recorded as the single **FAIL** in the verification report. |
| `ATT-GAP-017a` | 🔴 **OPEN** | No Rank 1–5 latency/throughput figure. EA states none. |
| `ATT-GAP-018` | 🔴 **OPEN** | No source authorises an *"at least one mode enabled"* constraint. `ATT-FR-106` and `ATT-AC-209` preserve the permissive behaviour rather than inventing a restriction. |

**Result over the 21 rows: 2 resolved (`ATT-GAP-001`, `ATT-GAP-002`), 1 narrowed (`ATT-GAP-011`), 18 open** —
counted by each row's own verdict cell, so that this figure and a mechanical scan of the column above agree.
Of the 18 open, 2 (`ATT-GAP-010`, `ATT-GAP-012` storage) now carry a
*definite negative* answer rather than an unknown, and 2 (`ATT-GAP-004`, `ATT-GAP-014`) were **upgraded in
severity** by the re-audit. **No gap was closed by invention.** The count did not improve much, and it should
not have: a re-audit that resolves most of its own open questions has usually re-labelled them.

> **The most recent resolution — `ATT-GAP-001`, closed in v1.2 — is the weakest kind of good news** and is recorded as
> such. It was closed by **conforming this document to a decision the registry had already made**, not by
> answering an open architectural question. It required no owner ruling, no ADR and no registry edit. **It tells
> you nothing about whether attendance can be built** — the two gaps that actually block a mode from being built,
> `ATT-GAP-012` and `ATT-GAP-014`, are untouched by it and remain open.

### 32.2 `ATT-GAP-001` — the numbering conflict, RECONCILED

> ✅ **Status: RESOLVED 2026-08-04.** This document is **`PRD-006`**. The filename, the header and every internal
> self-reference now carry that number. **`PRD_REGISTRY.md` was left byte-for-byte unmodified**, no number was
> reassigned, no ADR was raised, and no requirement changed. The execution record is
> [`PRD-006_NUMBERING_RECONCILIATION.md`](./PRD-006_NUMBERING_RECONCILIATION.md).

Re-verified against primary sources, with **`PRD_REGISTRY.md` left byte-for-byte unmodified**:

| Source | Location | Says |
|---|---|---|
| `PRD_REGISTRY.md` §4.2 | line **236** | `PRD-006` · Attendance Management · **`BC-03`** · `[CORE]` · V1 · `PLANNED` |
| `PRD_REGISTRY.md` §4.2 | line **238** | `PRD-008` · **Revenue & Finance** · `BC-05` · `[CORE]` · V1 · `PLANNED` |
| `PRD-007` **FROZEN**, Rank 3 | line **223** | *"`BC-03` Attendance (**`PRD-006`**, PLANNED)"* |
| `PRD-007` **FROZEN**, Rank 3 | line **862** | *"`BC-03` Attendance is a **separate bounded context** and **`PRD-006`** is its PRD."* |
| `PRD_REGISTRY.md` §8 rule 1 | line **554** | *"**Numbers are never reused or reassigned**"* |
| `PRD_REGISTRY.md` §8 rule 5 | line **559** | *"If this register disagrees with a PRD, **fix this register**."* |

**Three independent authorities call this document `PRD-006`** — the registry, and a **frozen Rank 3 PRD twice**.
Only the authoring instruction said `PRD-008`, and `PRD-008` is **already allocated to Revenue & Finance**, so
adopting it was never a free choice: it collided with a live allocation and breached §8 rule 1.

**Why §8 rule 5 does not apply.** Rule 5 (*"fix this register"*) is frequently mis-read as *"the PRD wins."* It
cannot apply here for two reasons. First, the disagreement was never registry-vs-PRD — it was the registry **and a
frozen PRD** against a draft. Second, applying it would require **modifying `PRD_REGISTRY.md`**, which rule 1
forbids independently, and which would have changed a correct register to match an incorrect draft.

#### How this was reconciled

The draft was brought into conformance with the standing allocation. That direction matters: **the register was
right and the draft was wrong**, so the draft moved.

| Governance test | Source | Result |
|---|---|---|
| Does this reassign a PRD number? | Registry §8 rule 1, line **554** | **No.** `PRD-006` was already Attendance's and `PRD-008` remains reserved to Revenue & Finance. Both allocations are **honoured**, neither is changed |
| Does it require an ADR *before* the change? | `DOCUMENTATION_BASELINE.md` §7 step 1, line **286** | **No.** That rule governs **Rank 1–5** documents. This document's own header declares it *"**Unranked** … claims no authority"*, and `PRD_REGISTRY.md` does not appear in the rank ladder (lines 203–215) |
| Does it change structure, ownership, a boundary or a platform rule? | `ADR-INDEX.md` Process step 1, line **87** | **No.** `BC-03` ownership, all nine edges, the aggregate, every requirement and all six modes are untouched |
| Does it add a bounded context to a PRD's ownership? | Registry §8 rule 6, line **560** | **No** |
| Is a frozen document modified? | `PRD_LIFECYCLE.md` Stage 7, line **175** | **No.** `PRD-007` is byte-identical; its two citations of `PRD-006` are now **satisfied** rather than dangling |

**An ADR was therefore not raised, because there was no decision to record.** An ADR documents a choice between
options; here the registry had already chosen at line 236, and this document had no authority to choose otherwise.
Raising one would have manufactured a governance artefact for a conformance action — and `ADR-0017`'s own history
warns against the opposite failure of *inventing* governance to fill a gap.

> **`ATT-GAP-001` no longer blocks Stage 7.** The condition it guarded against — a frozen PRD carrying a number
> allocated to a different bounded context, corrupting every downstream citation including two inside an
> already-frozen document — **cannot now occur.** The remaining Stage 3–7 gates are unaffected by this change and
> remain unpassed; **this reconciliation does not advance the document's lifecycle stage.**

#### The one derived record that is now stale — identified, NOT modified

`PRD_REGISTRY.md` is **correct on the number** and needs no correction for it. Its *derived summary counts*,
however, describe a repository state that predates this document's existence:

| Location | Current text | Why it is now stale |
|---|---|---|
| `PRD_REGISTRY.md` line **236** | `PRD-006` … `PLANNED` | A `DRAFT` document for `BC-03` now exists on disk |
| `PRD_REGISTRY.md` line **501** | *"9 files, 7 PRD identities — `PRD-000`…`PRD-005` and `PRD-007`"* | Two further files, an eighth identity |
| `PRD_REGISTRY.md` line **504** | *"`DRAFT` — **0** — unchanged"* | This document is `DRAFT` |
| `PRD_REGISTRY.md` line **505** | *"`PLANNED` — **17** — `PRD-006`, `PRD-008`…"* | `PRD-006` would move out of `PLANNED` |

**These are not corrected here.** Registry §8 rule 3 requires the register to be updated *"in the same commit as
the change it records"*, and rule 2 requires **entry evidence** for a status change — for `DRAFT`, *"a document on
disk with a version header"* (§2), which now exists. The update is therefore **available and owned by the registry
owner**; it is not this document's to make, and this document does not make it. This is the same defect class the
repository already tracks as `GCP-01`/`GCP-07`/`GCP-08` — *a derived statement left behind by a change to the
thing it describes* — and it is recorded rather than silently absorbed.

---

## 33. V1 / V2 / V3 / Future Classification

### 33.1 V1 — specified in this document

| Capability | Status |
|---|---|
| Fixed QR attendance | **V1** — specified, buildable |
| Dynamic QR attendance | **V1** — specified; construction blocked by `ATT-GAP-006` |
| Fixed QR + Wi-Fi | **V1** — specified; anti-spoof claims blocked by `ATT-GAP-007` |
| Fixed QR + GPS | **V1** — specified; anti-spoof claims blocked by `ATT-GAP-008a` |
| Face verification | **V1 per the product decision** — specified; **build blocked** by `ATT-GAP-012`/`014`; **version contested** by `ATT-GAP-015` |
| Manual — individual entry | **V1** — specified, buildable, enabled by default |
| Manual — register image OCR/Vision | **V1** — specified; **build blocked** by `ATT-GAP-010`/`011` |
| Check-in / check-out determinism | **V1** — specified, buildable |
| Duplicate & idempotency | **V1** — specified, buildable |
| Corrections | **V1** — specified, buildable |
| Owner mode configuration | **V1** — specified; seven defaults blocked by `ATT-GAP-017` |
| Offline attendance capture | **V1** — policy defined here, executed by `BC-30` |

### 33.2 V2 / V3 / Future — named, not specified

| Capability | Class | Source |
|---|---|---|
| Anti-fraud controls (beyond §19.3) | **V2** | EA v2.1 attendance tree |
| Clock skew handling | **V2** | EA v2.1 |
| Late entry / early exit rules | **V2** | EA v2.1 (rules owned by `BC-06`) |
| Attendance policies | **V2** | EA v2.1 |
| Attendance reports | **V2** | EA v2.1 — and `BC-26` owns metrics regardless |
| Staff attendance | **V2** | BC Map `BC-07` |
| Visitor entry | **V2** | BC Map `BC-09` |
| Public live occupancy | **V2** | `ARCHITECTURE_RULINGS.md` §6 — *"must not be invented"* |
| **RFID attendance** | **FUTURE — NOT V1** | See §33.3 |
| NFC / BLE attendance | **V3** | EA v2.1 |
| Hybrid attendance | **Future** | EA v2.1 |

### 33.3 RFID — Future only

**RFID is not V1.** It is classified **Future**, subject to architecture support.

The future concept, documented for direction only and specifying nothing:

```
RFID reader → student association → attendance validation → AttendanceRecord
```

`ATT-XC-010` (§7.1) is the binding rule. This document contains **no** RFID requirement, **no** RFID
configurable, **no** RFID acceptance criterion, **no** RFID event, **no** RFID device requirement and **no** RFID
implementation task. EA v2.1 lists `RFID Attendance (V3)`; whether Future or V3 is the correct class is not
decided here, because nothing depends on the answer while it is out of V1 scope.

> **No V1 Device Management architecture is created for RFID**, and none is implied. §17 leaves attendance
> hardware ownership open as `ATT-GAP-009` for the V1 Face scanner; RFID readers are not in scope at all.

---

## 34. Change Log

| Version | Date | Change |
|---|---|---|
| **v1.3 — DRAFT** | 2026-08-04 | **Stage 4 findings reconciliation. Still DRAFT, still unranked, still not frozen, still no ADR raised.** Closes the eight findings `RQ-1`…`RQ-8` raised by [`PRD-006_REQUIREMENTS_REVIEW.md`](./PRD-006_REQUIREMENTS_REVIEW.md), whose **verdict and findings are left exactly as issued** — this changelog and [`PRD-006_STAGE4_FINDINGS_CORRECTION.md`](./PRD-006_STAGE4_FINDINGS_CORRECTION.md) record what was done about them; the review is not re-verdicted by the document it reviewed. **`RQ-1`** (seven configurables with no default — a live `LIB-16.2` breach): closed **without inventing a single value**, by specifying *the behaviour in the absence of a value* instead of the value. `ATT-BR-043` forbids substitution of any kind — not zero, not a framework default, not another tenant's, another mode's or an example's; `ATT-FR-149` makes a mode whose required setting is empty **un-enableable**, with the rejection naming the missing setting; `ATT-FR-150` makes evaluation against a valueless setting **fail closed**; `ATT-BR-044` states the `LIB-16.2` operability check and shows the breach is **latent** — all seven belong to capabilities that are off by default, so a day-one tenant records attendance by Manual and never reaches them; `ATT-FR-151` requires the Owner to be shown that no platform default exists, so **a blank field is never presented as though it carried one**. **`ATT-GAP-017` remains 🔴 OPEN and the `LIB-16.2` breach remains a breach** — a hole that is specified as a hole is still a hole, and recording this as a resolution would be the exact `§0.4` failure of resolving a gap by implementation choice. **`RQ-2`**: `ATT-AC-199` re-cited from a partial list to **all seven** configurables plus `ATT-BR-043`, and `ATT-AC-210`…`ATT-AC-213` added so each new obligation arrives with its own criterion. **`RQ-3`** (three different open-gap counts in one document): the count is now stated **over the 21 rows and read from each row's own verdict cell — 2 resolved, 1 narrowed, 18 open** — so the figure and a mechanical scan of the ledger agree, as Stage 5 requires. `ATT-GAP-012` is counted **open**, which is what its verdict cell says: its storage sub-question is answered negatively, but the ownership question that defines it is not, and a partially answered gap is an open gap. The earlier 3/1/17 figures are marked **superseded**, and **no gap's status was changed to produce the new ones**. **`RQ-4`**: the `ATT-GAP-002` §32 register row, which still read OPEN while §32.1 recorded it RESOLVED, is reconciled to **RESOLVED** with its basis (frozen `PRD-007` §3 and `SEAT-BR-030`) and its owner closed. **`RQ-5`**: §23.4, previously a heading with no body, now states the seat-occupancy boundary in both directions and adds `ATT-BR-045` — neither module holds a shadow copy of the other's system of record, and **the attendance record is never reconciled backwards from occupancy**. **`RQ-6`**: `ATT-FR-078` made unconditional within its workflow — if the open questions do not permit the full evidence chain to be retained, **the workflow does not ship; the chain is not the part that gets dropped**. **`RQ-7`**: *\"MUST conceptually support\"* → *\"**MUST** support\"* in `ATT-FR-096`; an obligation qualified by \"conceptually\" is untestable. **`RQ-8`**: `ATT-INV-010` re-labelled a **narrowing** of `ATT-INV-004` rather than a restatement, with the tenant qualifier explained as load-bearing — one person **MAY** hold an open presence at two libraries at once, and that is not a violation. **Registers changed by addition only: `ATT-FR` 148 → 151, `ATT-BR` 42 → 45, `ATT-AC` 209 → 213; total 506 → 516, obligation-bearing 279 → 285.** No identifier was renumbered, withdrawn or reused; the six V1 modes, the RFID-Future classification, §13A buildability, §13C staff verification, every edge, event, invariant, exclusion and configurable **value** are untouched. Coverage re-measured after the edit, not assumed: **285/285 = 100%, 0 orphan criteria**. **No default or security value was invented, no authoritative document was modified, and no ADR was raised** — nothing here decides structure, ownership, boundaries or platform rules; `RQ-1`'s architectural question is precisely what `ATT-GAP-017` holds open for its named owner. **This reconciliation does not advance the lifecycle and does not freeze anything**: Stage 4's verdict remains **⚠️ CONDITIONAL** while `ATT-GAP-017` is open, and Stages 5, 6 and 7 remain unattempted. |
| **v1.2 — DRAFT** | 2026-08-04 | **PRD numbering reconciliation — `PRD-008` → `PRD-006`. Metadata only. Still Stage 2, still unranked, still not frozen, still no ADR raised.** This document now carries **`PRD-006`**, the number [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) line 236 has always allocated to Attendance Management / `BC-03`. The drafting-time `PRD-008` was withdrawn because line 238 reserves it for **Revenue & Finance / `BC-05`**; **that reservation is preserved intact and this document makes no claim on it.** **The direction of the correction is the point: the register was right and the draft was wrong, so the draft moved.** Changed: the two filenames (via `git mv`, history preserved), the header *PRD* and *Version* rows, `ATT-GAP-001`, its §32.1 ledger row, §32.2, and the end-of-file line. **`ATT-GAP-001` moves 🔴 OPEN → ✅ RESOLVED, taking the open count from 18 to 17** — and it is the **only** register entry whose status changed. **No requirement identifier was added, removed, renumbered or reworded**; all ten registers remain at **506 identifiers** (`ATT-GAP-*` still declares 18 numbers / 21 rows — a resolved gap keeps its number per `PRD_LIFECYCLE.md` §5 rule 5); coverage remains **279/279**; the six V1 modes, the RFID-Future classification, §13A buildability and the §13C staff-verification rule are untouched; no edge, event, invariant, exclusion or configurable changed. **No ADR was raised, and none is required** — Baseline §7 step 1 governs **Rank 1–5** documents and this one is Unranked by its own header; `ADR-INDEX.md` Process step 1 governs changes to structure, ownership, boundaries or platform rules, none of which this touches; and registry §8 rule 1 is **satisfied, not excepted**, because no number was reassigned. **`PRD_REGISTRY.md`, `PRD-007` and every other authoritative document are byte-for-byte unmodified** — `PRD-007`'s two citations of `PRD-006` (lines 223, 862) are now **satisfied** rather than dangling. The four stale *derived* registry summary lines this creates are **identified in §32.2 and deliberately not corrected**, as they belong to the registry owner under §8 rule 3. **This reconciliation does not advance the lifecycle: Stages 3, 4, 5, 6 and 7 remain unpassed**, and 17 gaps remain open. Execution record: [`PRD-006_NUMBERING_RECONCILIATION.md`](./PRD-006_NUMBERING_RECONCILIATION.md) |
| **v1.1 — DRAFT** | 2026-08-04 | **Gap re-audit. Still Stage 2, still unranked, still not frozen, still no ADR raised.** No requirement identifier was added, removed, renumbered or reworded; all ten registers are unchanged at **506 identifiers**; coverage remains **279/279**; the six V1 modes, the RFID-Future classification, §13A buildability and the §13C staff-verification rule are all preserved untouched. Three sections were added — **§12.4a** (biometric boundary audited across eight dimensions), **§32.1** (gap resolution ledger) and **§32.2** (the numbering conflict re-verified) — and three existing passages were corrected. **Result: 2 gaps resolved, 1 narrowed, 18 open.** `ATT-GAP-002` closes on frozen `PRD-007`'s ratified pattern of consuming `BC-18` with no `E-` edge. `ATT-GAP-011` is **narrowed by refutation**: the first draft asked for a `BC-03` → `BC-27` edge, and BC Map §7.4 `F-1`/`F-3`/`F-4` with `MP-GBR-29`…`32` show that edge would be **architecturally backwards** — a capability is an untrusted caller into the domain's command API, never the reverse — so its absence is correct and `ATT-XC-005` is strengthened rather than relaxed; §13C's staff verification is identified as already being `F-4`'s mandatory Human-in-the-Loop approval record. The storage sub-question of `ATT-GAP-012` is **answered negatively and definitely**: `BC-03` has no `E-22` path, so it cannot hold a biometric template at all. Two gaps were **upgraded in severity** rather than closed: `ATT-GAP-004`, because BC Map §6 rule 2 and `E-14` show `BC-03` is not even a Trust & Safety self-restriction subscriber, leaving fraud escalation with no authorised path in either direction; and `ATT-GAP-014`, because `ID-5`/`MP-GBR-04` promise erasure by **pseudonymisation**, which is structurally inapplicable to data that *is* the identifier — making it a conflict rather than a void, and confirming `ATT-FR-064`'s outright build block on Rank 1 grounds instead of merely on absence. `ATT-GAP-001` was re-verified against primary sources with **`PRD_REGISTRY.md` left byte-for-byte unmodified**, and is escalated: three authorities (the registry, and frozen `PRD-007` twice) call this document `PRD-006`, while `PRD-008` is already allocated to Revenue & Finance — so the gap **blocks any Stage 7 freeze**. **Nothing was resolved by invention, by inference from silence, or by convenience**; the 18 remaining gaps each name the owner who must decide. **No authoritative document was modified, no ADR file was created, and no API, schema, task or code artefact was produced.** |
| **v1.0 — DRAFT** | 2026-08-04 | **Initial draft. Stage 2 of `PRD_LIFECYCLE.md`. Not reviewed, not frozen, unranked, no ADR raised.** Specifies `BC-03` Attendance for V1. Six independent attendance modes established as a closed set, with mode independence (`ATT-BR-004`…`ATT-BR-007`) stated as the central product rule and a generic verification layer explicitly prohibited (`ATT-XC-011`). RFID classified Future only, with zero V1 artefacts. Manual attendance established as a first-class mode with two workflows — individual entry (buildable today) and physical-register OCR/Vision (blocked on two missing edges) — separated deliberately so the smartphone-less student is served without waiting for an AI architecture decision. 506 identifiers across ten registers, 279 obligation-bearing, 209 acceptance criteria, **100% coverage of obligations — measured, not asserted**. The first internal pass of this draft published 100% while the true figure was 137/279 = 49.1%; the mechanical check required by `ATT-NFR-010` caught it, and it was corrected by writing the 91 missing criteria (`ATT-AC-119`…`ATT-AC-209`) rather than by lowering the claim. Ten out-of-range placeholder identifiers left over from drafting were deleted, the single out-of-range exclusion (drafted as number 023) was renumbered `ATT-XC-021` to close the exclusion range at 21, and the §0.3 total was corrected from an arithmetically impossible 296 to the true 506. **Eighteen gaps recorded and none resolved by invention**, including `ATT-GAP-001`, a direct conflict between the instructed number `PRD-008` and `PRD_REGISTRY.md`'s allocation of `PRD-006` to this context, and `ATT-GAP-012`/`014`, which block the Face mode from being built at all. **No integration edge was invented** — every consumed and published edge is quoted from BC Map §7; the four events are exactly BC Map §9's. **No authoritative document was modified.** |

---

*End of `PRD-006_ATTENDANCE-MANAGEMENT.md` v1.3 DRAFT.*
