# Membership Management PRD — `PRD-005`

| Field | Value |
|---|---|
| **PRD ID** | `PRD-005` |
| **Document** | Membership Management — `BC-02` Membership |
| **Version** | v1.4 (Startup MVP) |
| **Status** | **FROZEN** — [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) Stage 7. Admitted to the documentation baseline by [`ADR-0019`](../../00-governance/adr/ADR-0019-membership-management-prd-v1.4-baseline.md). **Frozen, not `VERIFIED`** — Stage 9 requires implementation evidence that does not yet exist |
| **Date** | 2026-08-04 *(four times corrected same day across five independent reviews)* |
| **Baseline** | **`BASELINE-2026-08-04-D`** |
| **Rank** | **Rank 3** (module PRD) — the fifth Rank 3 module baseline, per [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3.3 and §4 |
| **Owning context** | **`BC-02` Membership** `[CORE]`, Library Management cluster, rank 8 |
| **Product module** | Master PRD §8 **module 6** (Membership Management) |
| **Consumes through ports** | `BC-01` Enrollment (`E-01`) · `BC-05` Fee & Collection (`E-10`) · `BC-06` Library Policy (via `BC-05`, `E-06`) · `BC-21` Entitlement (`E-17`) · `BC-19` Tenancy (`E-18`) · `BC-25` Configuration (`E-19`) · `BC-24` Audit Trail (`E-20`) · `BC-22` Notification (`E-23`) |
| **Publishes to** | `BC-04` Seating (`E-02`) · `BC-03` Attendance (`E-03`) · `BC-05` Fee & Collection (`E-07`) · `BC-22` Notification (`E-23`) · `BC-24` Audit Trail (`E-20`) — **`BC-26` Analytics is deliberately not listed; see `MM-BR-035` and `MM-GAP-010`** |
| **ADRs applied** | [`ADR-0001`](../../00-governance/adr/ADR-0001-modular-monolith.md) · [`ADR-0003`](../../00-governance/adr/ADR-0003-hybrid-tenancy-global-account.md) · [`ADR-0012`](../../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md) · [`ADR-0013`](../../00-governance/adr/ADR-0013-capability-context-ownership.md) · [`ADR-0014`](../../00-governance/adr/ADR-0014-tenant-key-and-audit-mutation-enforcement.md) · [`ADR-0018`](../../00-governance/adr/ADR-0018-student-management-prd-v1.2-baseline.md) · [`ADR-0019`](../../00-governance/adr/ADR-0019-membership-management-prd-v1.4-baseline.md) *(this document's admission)* |
| **Rulings applied** | `AR-1` (Discovery delegates membership creation to `BC-02`) · `AR-2` (Authentication owns registration) |
| **Depends on** | [`PRD-004`](../student-management/Student_Management_PRD_v1.md) **v1.2, FROZEN** — `E-01`, *"Membership may not exist without an active enrollment"* |
| **Supporting documents** | [`PRD-005_BLOCKER_ANALYSIS.md`](PRD-005_BLOCKER_ANALYSIS.md) (`C-2`/`C-3` investigation) · [`PRD-005_CORRECTION_REPORT.md`](PRD-005_CORRECTION_REPORT.md) (ratification + correction pass) · [`PRD-005_SECOND_INDEPENDENT_REVIEW.md`](PRD-005_SECOND_INDEPENDENT_REVIEW.md) (adversarial re-review, verdict B, findings `F-1`…`F-4`) · [`PRD-005_F1-F4_CORRECTION_REPORT.md`](PRD-005_F1-F4_CORRECTION_REPORT.md) (v1.2 correction of `F-1`…`F-4`) · [`PRD-005_THIRD_INDEPENDENT_REVIEW.md`](PRD-005_THIRD_INDEPENDENT_REVIEW.md) (third adversarial review, verdict B, findings `TR-1`…`TR-5`) · [`PRD-005_TR-1-TR-5_CORRECTION_REPORT.md`](PRD-005_TR-1-TR-5_CORRECTION_REPORT.md) (v1.3 correction of `TR-1`…`TR-5`) · [`PRD-005_FOURTH_INDEPENDENT_REVIEW.md`](PRD-005_FOURTH_INDEPENDENT_REVIEW.md) (fourth adversarial review, verdict B, findings `QR-1`/`QR-2`) · [`PRD-005_QR-1-QR-2_CORRECTION_REPORT.md`](PRD-005_QR-1-QR-2_CORRECTION_REPORT.md) (v1.4 correction of `QR-1`/`QR-2`) |

---

## 0. How to read this document

### 0.1 Normative language

`PRD_LIFECYCLE.md` Stage 2 rule 4 requires every draft to define its normative language. This document uses the
following, and nothing else carries obligation.

| Term | Meaning |
|---|---|
| **MUST** / **MUST NOT** | An absolute requirement. A build that violates it is defective. Every **MUST** here is intended to be falsifiable — if it cannot be checked, `SID-4.56` applies and it is treated as **unmet**, not as satisfied by intent |
| **SHOULD** / **SHOULD NOT** | A strong default. It may be departed from only with a recorded reason; the departure is a design decision, not a defect |
| **MAY** | Genuinely optional. Neither choice is a defect |
| **RECOMMENDED** | A capability this document proposes for V1 but does **not** make mandatory. It carries **no** obligation and is listed separately in §24.2. It is not a requirement until product review promotes it |

Descriptive prose and rationale blocks (`>` quotations) carry **no** obligation. Where a table is normative it says so
explicitly.

**Precedence.** This document is a module PRD. Where it conflicts with `MASTER_PRD.md` (Rank 1), an accepted ADR
(Rank 2), another Rank 3 module PRD, or the Bounded Context Map / Dependency Matrix (Rank 4), **the ranked document
governs and the conflict is a defect in this document** (`DOCUMENTATION_BASELINE.md` §4). Do not resolve such a
conflict by choosing — raise it. Conflicts discovered while writing this document are recorded in §25, **not** silently
resolved.

### 0.2 Identifier registers — declared up front

Per `PRD_LIFECYCLE.md` Stage 2, the registers are published **as a promise**, with contiguous ranges. A gap would make
the promise false.

| Prefix | Meaning | Count | Range | Chapter |
|---|---|---|---|---|
| `MM-FR-n` | Functional requirement | **119** | `MM-FR-001` … `MM-FR-118`, plus the suffixed `MM-FR-057a` | 2–11, 19–20 |
| `MM-BR-n` | Business rule | **35** | `MM-BR-001` … `MM-BR-035` | §12, §14 |
| `MM-INV-n` | Domain invariant (enforced inside the aggregate) | **12** | `MM-INV-001` … `MM-INV-012` | §14.2 |
| `MM-EVT-n` | Domain event (**closed set**) | **7** | `MM-EVT-001` … `MM-EVT-007` | §12 |
| `MM-XC-n` | Exclusion — must be impossible | **16** | `MM-XC-001` … `MM-XC-016` | §1.5 |
| `MM-AC-n` | Acceptance criterion | **97** | `MM-AC-001` … `MM-AC-094`, plus the suffixed `MM-AC-074a`, `MM-AC-076a`, `MM-AC-080a` | §23 |
| `MM-NFR-n` | Non-functional requirement | **14** | `MM-NFR-001` … `MM-NFR-014` | §16.5 |
| `MM-PO-n` | Protected operation (**closed list**) | **11** | `MM-PO-001` … `MM-PO-011` | §16.3 |
| `MM-CFG-n` | Configurable | **9** | `MM-CFG-001` … `MM-CFG-009` | §13.4 |
| `MM-GAP-n` | Proposed gap / open question — **not a requirement** | **13** | `MM-GAP-001` … `MM-GAP-010`, plus the suffixed successors `MM-GAP-006a`, `MM-GAP-007a` and `MM-GAP-010a` | §25.2 |

**Total: 333 identifiers**, of which **320 carry obligation** and 13 are `MM-GAP-*` open questions, which are not
obligations. Of the 320, **223 are obligations that an acceptance criterion can verify** (all registers except
`MM-AC-*` itself).

**Coverage counting rule (binding on every coverage figure in this document).** An obligation counts as *verified* if
and only if **its identifier appears in the *Verifies* column of at least one `MM-AC-*` row in §23**. Nothing else
counts — not a mention in the criterion text, not a mention in a surrounding note, and **not prose stating that a rule
is covered elsewhere**. This rule is deliberately strict, because `MM-NFR-014` requires that *"a rule that cannot be
checked SHALL be treated as unmet, not as satisfied by intent"*, and a metric that can be raised by writing prose
measures prose rather than verification. Under this rule the measured figures are:

| Scope | Verified | Total | Coverage |
|---|---|---|---|
| `MM-BR-*`, `MM-INV-*`, `MM-XC-*`, `MM-PO-*`, `MM-EVT-*` (the five *rule* registers) | **77** | **81** | **95.1%** |
| All criterion-verifiable obligations | **134** | **223** | **60.1%** |

Per register: `MM-BR-*` 31/35 · `MM-INV-*` 12/12 · `MM-EVT-*` 7/7 · `MM-XC-*` 16/16 · `MM-PO-*` 11/11 · `MM-FR-*`
48/119 · `MM-NFR-*` 7/14 · `MM-CFG-*` 2/9.

The four rule-register obligations **not** verified under this rule are `MM-BR-012`, `MM-BR-022`, `MM-BR-027` and
`MM-BR-028`. Each is a restatement whose substance is exercised by criteria written against its definition site
(`MM-AC-051`/`052`, `MM-AC-004`…`011`, `MM-AC-015`), so the risk is low — but they are counted as **uncovered**, not
as covered by argument. The residual `MM-FR-*`, `MM-NFR-*` and `MM-CFG-*` balance is detail inside chapters whose
behaviour §23's criteria exercise; it is likewise counted honestly rather than excluded to improve the ratio. See §23.1.

> **On the two suffixed identifiers.** `MM-GAP-006` and `MM-GAP-007` were **closed** at v1.1 (§5.1, §12). A
> letter-suffixed successor records the residual non-blocking observation each one left behind, rather than reusing a
> retired number or renumbering the register — so every citation written against `MM-GAP-006`/`007` in this document,
> in [`PRD-005_BLOCKER_ANALYSIS.md`](PRD-005_BLOCKER_ANALYSIS.md) or in any review report stays resolvable.
>
> **`MM-FR-057a` uses the same convention** for the same reason. It is a narrowing of `MM-FR-057` added at v1.2 to
> resolve finding **F-3**, and is numbered as a suffix rather than appended to the end of the register so that it sits
> beside the rule it qualifies and so that no existing `MM-FR-*` citation in any document or review shifts meaning.

### 0.3 What this document is not

It is not an API specification (§19 is conceptual, per the authoring instruction and because no Event Catalog or API
standard exists yet in this repository). It contains **no** SQL, **no** migrations, **no** code, and **no** visual
mockups. It does not modify any existing document.

---

## 1. Purpose, Scope & Ownership

### 1.1 Purpose

`BC-02` Membership owns, in the Bounded Context Map's words at line 97:

> *"the commercial right-to-use: which plan a student holds, for what term, and whether it is currently valid."*

That single sentence is the whole mandate, and this document's job is to make it deterministic. Membership Management
answers exactly one authoritative question for the rest of the platform — ***"is this student's membership currently
valid?"*** — and owns the lifecycle that produces the answer.

`MM-FR-001` — This module **MUST** be the single authoritative source for membership validity. No other module **MAY**
recompute it from dates, plan data or payment state.

`MM-FR-002` — This module **MUST** publish validity as a read projection (`MembershipValidity`, `E-02`) rather than
exposing its tables. Consumers **MUST NOT** read `BC-02` tables directly (Dependency Matrix `L3`, Single Owner Rule).

### 1.2 The three concepts, kept distinct

The single most common failure mode in this domain is collapsing three different things into one. The Bounded Context
Map §11 already separates them, and `PRD-004` §1.2 does the same for its two. This document adds the third.

| Question | Concept | Owner | Identifier |
|---|---|---|---|
| *"Who is this human, globally?"* | Person identity | `BC-10` | `PersonId` |
| *"Is this person a student of this library?"* | Enrollment / student record | `BC-01` (`PRD-004`) | `StudentRecordId` |
| ***"What may this student pay for and use, and until when?"*** | **Membership** | **`BC-02` (this document)** | **`MembershipId`** |

`MM-FR-003` — A `Membership` **MUST** reference a `StudentRecordId`. It **MUST NOT** store a `PersonId`, an
`AccountId`, a name, a mobile number, an email address, a photograph or any other identity or profile field.

> **Why.** `BC-01` owns the student record and `BC-10` owns identity. Duplicating either here would create the
> multi-owner profile that ruling `AR-1` and `PRD-004` §1.4 exist to prevent, and would put PII into a context that has
> no business holding it. It also keeps `MP-GBR-34` (*"No event may ever carry a mobile number"*) trivially satisfiable.

### 1.3 Status is two independent state machines

BC Map line 209 is explicit, and `PRD-004` `SM-2.7` already enforces its half:

> *"`Status` — BC-01: Active/Inactive/Suspended/Archived enrollment state | BC-02: Valid/Expired/Frozen membership
> state. **Two independent state machines** — a student can be Active with an Expired membership."*

`MM-FR-004` — `MembershipStatus` **MUST** be a field of the `Membership` aggregate and **MUST** be independent of
`EnrollmentStatus`. A student whose `EnrollmentStatus` is `Active` **MUST** be able to hold a membership whose
`MembershipStatus` is `Expired`, and the reverse combination **MUST** also be representable.

`MM-FR-005` — This module **MUST NOT** write, derive or infer `EnrollmentStatus`. It **MUST NOT** store a copy of it.

### 1.4 Ownership boundary — normative

| Concern | Owner | This module |
|---|---|---|
| Student profile, contact details, guardian, documents | `BC-01` (`PRD-004`) | References `StudentRecordId` only |
| Person identity, DOB, gender | `BC-10` | No access, no storage |
| Authentication, session, roles, permissions | `BC-18` | Consumes authorisation decisions; defines none |
| Library member directory (read composition) | `BC-01` §5 (`PRD-004`) | **Supplies** plan/status/`validUntil`/quota to it |
| **Membership plans, terms, validity, status, entitlement** | **`BC-02` — this document** | **Owns** |
| Payment transaction, gateway, ledger, receipt, refund, reconciliation | `BC-05` / Business Platform | Consumes payment **outcome** only |
| Fee due generation | `BC-05` | Emits the event that triggers it (`E-07`) |
| Seat allocation, occupancy | `BC-04` | Publishes validity; never allocates |
| Attendance | `BC-03` | Publishes validity; never records presence |
| Notification delivery (SMS/push/email/in-app) | `BC-22` | Emits facts only (`E-23`, `MP-GBR-33`) |
| Analytics, dashboards, projections | `BC-26` | Emits events only (`MP-GBR-37`) |
| Tenant limits and feature gates | `BC-21` Entitlement | Calls `check()` before mutating (`E-17`) |
| Search indexing | `BC-23` | **No `BC-02` → `BC-23` edge exists** — see `MM-GAP-004` |
| Audit storage | `BC-24` | Emits audit events; stores no audit log |

### 1.5 Exclusions — `MM-XC-001` … `MM-XC-016`

Each is a thing that **MUST be impossible** in a correct V1 build, not merely undone.

| ID | Excluded — must be impossible |
|---|---|
| `MM-XC-001` | Storing or mutating any student profile or identity field (`MM-FR-003`) |
| `MM-XC-002` | Writing to `BC-01`, `BC-03`, `BC-04` or `BC-05` tables (`L3`, Single Owner Rule) |
| `MM-XC-003` | Processing a card/UPI/cash payment, calling a gateway, or holding a gateway credential |
| `MM-XC-004` | Storing a monetary ledger, balance, receipt or refund record (`BC-05` owns these) |
| `MM-XC-005` | Sending an SMS, push, email or in-app message (`BC-22`, `MP-GBR-33`) |
| `MM-XC-006` | Computing churn, retention, cohort, forecast or any analytic metric (§9, `MP-GBR-37`) |
| `MM-XC-007` | Auto-renewal — any code path that renews without an explicit human command (**V3**) |
| `MM-XC-008` | Membership downgrade (**V2**) |
| `MM-XC-009` | Membership freeze / unfreeze (**V2** — see `MM-GAP-001`) |
| `MM-XC-010` | Membership transfer between students or libraries (**V2** / **Future**) |
| `MM-XC-011` | Membership cancellation with refund (**V2**) |
| `MM-XC-012` | Proration arithmetic executed as money (**V2**; and `Q-06` is open — see `MM-GAP-002`) |
| `MM-XC-013` | Cross-library or cross-tenant membership (**Future**) |
| `MM-XC-014` | Reading or writing another tenant's membership under any circumstance (§16.1) |
| `MM-XC-015` | Silently changing the price of an existing membership (`MM-BR-033`) |
| `MM-XC-016` | Defining a role, permission or authorisation model (`BC-18` owns it; `AR-2`) |

---

## 2. Membership Plans — V1

A `MembershipPlan` is a library's offering to its students. BC Map line 203 warns that this is **not** the SaaS tier
sold to library owners: `MembershipPlan` (`BC-02`) vs `SubscriptionPlan` (`BC-20`). The two must never be conflated.

### 2.1 Plan as an aggregate

`MM-FR-006` — `MembershipPlan` **MUST** be a separate aggregate root from `Membership`. Editing a plan **MUST NOT**
occur in the same transaction as creating or renewing a membership.

> **Why.** BC Map §8 states *"The aggregate is the transaction boundary — one aggregate, one database transaction, no
> exceptions."* A plan is edited by an owner at leisure; a membership is created at a reception desk under time
> pressure. They have different lifecycles, different actors and different contention profiles.

`MM-FR-007` — Every `MembershipPlan` **MUST** be scoped to exactly one `tenantId`, and **MUST** carry a `branchId`
(`Q-02`/`MP-CON-13`: `branchId` is modelled in V1 even though multi-branch is V3).

### 2.2 Plan fields

`MM-FR-008` — A plan **MUST** carry: `planId`, `tenantId`, `branchId`, `name`, `durationDays`, `price`, `currency`,
`availability`, `isActive`, `createdAt`, `createdBy`, `version`.

`MM-FR-009` — A plan **MAY** carry: `description`, `seatQuota`, `eligibilityRule`, `updatedAt`, `updatedBy`.

`MM-FR-010` — `name` **MUST** be unique per (`tenantId`, `branchId`) among plans that are not archived, so reception
staff cannot be shown two identically named plans.

`MM-FR-011` — `durationDays` **MUST** be a positive integer. Duration **MUST** be expressed in **days**, not months.

> **Why days, not months.** A "1 month" plan is ambiguous on 31 January, and the ambiguity lands precisely on the
> month-end and leap-year edge cases §21 requires to be deterministic. Days make end-date arithmetic total. A library
> that wants to sell "monthly" configures `durationDays: 30`, which is a product decision, and the UI **MAY** present
> it as "1 month (30 days)".

`MM-FR-012` — `price` **MUST** be a non-negative decimal stored with explicit scale, **MUST NOT** be a floating-point
type, and **MUST** be accompanied by `currency`.

`MM-FR-013` — `currency` **MUST** be an ISO-4217 code and **MUST** default to the tenant's configured currency
(`MM-CFG-001`). A plan **MUST NOT** mix currencies.

`MM-FR-014` — `seatQuota`, when present, **MUST** be a non-negative integer representing the seat allowance the plan
confers. It is the `SeatQuota` of BC Map line 211 and **MUST NOT** be confused with `Seat` (`BC-04`, a physical
position).

`MM-FR-015` — `availability` **MUST** be one of `Public` (offerable to any enrolled student) or `StaffOnly` (offerable
only by staff at reception). A `StaffOnly` plan **MUST NOT** appear in any student-facing plan list.

### 2.3 Eligibility rules — deliberately minimal

`MM-FR-016` — A plan **MAY** declare an `eligibilityRule`. In V1 the supported rule set **MUST** be limited to:
requires an `Active` enrollment (always applied), and an optional `minAgeYears` / `maxAgeYears` bound.

`MM-FR-017` — Age-bounded eligibility **MUST** be evaluated by asking `BC-01` for a boolean/qualitative answer. This
module **MUST NOT** read, store or compute from a date of birth (`MM-XC-001`).

> **Why so narrow, and a caution.** A general rule engine is a product in its own right and nothing in the Master PRD
> or EA asks for one. The age bound is included only because plans such as a minors' shift are a real library practice.
> **However**, whether DOB is even reliably available is an *open question in `PRD-003`*, recorded as `GCP-05` /
> `SM-GAP-10` in `DOCUMENTATION_BASELINE.md` §6 and unresolved. Age-bounded eligibility is therefore specified as
> **`MAY`**, and `MM-GAP-003` records that it cannot be made mandatory until `GCP-05` closes. This document does not
> resolve `GCP-05`.

### 2.4 Plan lifecycle

`MM-FR-018` — A plan **MUST** support: create, edit, activate, deactivate, and list.

`MM-FR-019` — Deactivation (`isActive: false`) **MUST NOT** delete the plan, **MUST NOT** alter any existing
membership, and **MUST NOT** alter any price snapshot.

`MM-FR-020` — A deactivated plan **MUST NOT** be selectable for a new membership, a renewal or an upgrade target.

`MM-FR-021` — A plan **MUST NOT** be hard-deleted once any membership references it. The system **MUST** offer
deactivation instead and **MUST** state that reason to the actor.

### 2.5 What may change after a plan is in use — normative

This is the crux of plan governance, and the instruction asks for it explicitly. **This table is normative.**

| Field | Before first use | After a membership exists | Rationale |
|---|---|---|---|
| `name` | Editable | **Editable** | A display label. Historical memberships hold a snapshot, so history is unaffected |
| `description` | Editable | **Editable** | Display only |
| `price` | Editable | **Editable — future-effective only** | Existing memberships hold a price snapshot and **MUST NOT** change (`MM-BR-033`) |
| `currency` | Editable | **IMMUTABLE** | Changing it would silently restate the meaning of every snapshot |
| `durationDays` | Editable | **Editable — future-effective only** | Existing terms are already computed and **MUST NOT** shift |
| `seatQuota` | Editable | **Editable — takes effect on next renewal** | See `MM-FR-025` and `MM-GAP-005` |
| `availability` | Editable | **Editable** | Affects offerability, not existing rights |
| `isActive` | Editable | **Editable** | Deactivation is the intended retirement path |
| `eligibilityRule` | Editable | **Editable — future-effective only** | Existing memberships are not re-validated |
| `planId` | — | **IMMUTABLE** | Identity |
| `tenantId`, `branchId` | — | **IMMUTABLE** | Scope. Changing it would be a cross-tenant data move |

`MM-FR-022` — Every plan edit **MUST** increment `version` and **MUST** be audited with actor, timestamp, and the
before/after values of the changed fields (§17).

`MM-FR-023` — An edit to `price`, `durationDays` or `eligibilityRule` **MUST** apply only to memberships created,
renewed or upgraded **after** the edit is committed. It **MUST NOT** alter any existing membership.

`MM-FR-024` — Attempting to edit `currency`, `planId`, `tenantId` or `branchId` on a plan that has any referencing
membership **MUST** fail with a typed domain error naming the field.

`MM-FR-025` — A change to `seatQuota` **MUST NOT** alter the `seatQuota` already published for an active membership in
the `MembershipValidity` projection. It takes effect when that membership is next renewed or upgraded.

> **Why not immediately.** `seatQuota` is consumed by `BC-04` Seating to permit allocations. Retroactively reducing it
> could invalidate a seat a student is physically sitting in. That is a real-world conflict of the kind BC Map §10.1
> says cannot be compensated. Deferring to the next renewal is the conservative, non-destructive choice. `MM-GAP-005`
> records that whether an owner should be able to force an immediate quota change is a product decision not yet taken.

### 2.6 Price snapshot integrity

`MM-FR-026` — On creation, renewal or upgrade, the membership **MUST** store a `priceSnapshot` and `currencySnapshot`
copied from the plan **at that moment**, together with the plan `version` used.

`MM-FR-027` — `priceSnapshot`, `currencySnapshot` and `planVersionAtPurchase` **MUST** be immutable for the life of
the membership.

`MM-FR-028` — Historical membership pricing **MUST NOT** be derivable by re-reading the plan. Any read path that
displays the amount applicable to a past membership **MUST** use the snapshot.

> **Why this matters beyond tidiness.** `BC-05` Fee & Collection raises a `FeeDue` from `MM-EVT-001`. If the amount
> were resolved by re-reading the plan, a price edit would silently restate money already owed or collected — which
> BC Map §8 forbids for `FeeLedger` (*"receipt is immutable once issued"*) and which would make the ledger and the
> membership disagree about history.

### 2.7 Plan listing and search

`MM-FR-029` — Plan listing **MUST** be tenant- and branch-scoped, **MUST** support filtering by `isActive` and
`availability`, and **MUST** support sorting by `name` and `price`.

`MM-FR-030` — Plan search **MUST** be a simple case-insensitive substring match on `name` executed within `BC-02`.

> **Why not `BC-23` Search Indexing.** BC Map §7.3 `E-21` lists `BC-01` and `BC-10` as the only indexing producers.
> There is **no `BC-02` → `BC-23` edge**, and line 292 holds that *"if an edge is not in this table, it does not exist
> and adding it requires an ADR."* A tenant's plan list is a handful of rows; a local match is sufficient and needs no
> new edge. Recorded as `MM-GAP-004` so that a future need for indexed membership search is raised as an ADR rather
> than smuggled in.

### 2.8 Plan validation

`MM-FR-031` — Plan creation and edit **MUST** reject: empty `name`; `durationDays` < 1; negative `price`; a `currency`
that is not a valid ISO-4217 code; a `currency` differing from the tenant default without an explicit override; a
duplicate `name` within (`tenantId`, `branchId`); `minAgeYears` > `maxAgeYears`.

`MM-FR-032` — Every rejection **MUST** be a typed domain error identifying the offending field. A generic failure is
a defect.

---

## 3. Membership Creation — V1

### 3.1 Preconditions

`MM-FR-033` — Creation **MUST** verify, before mutating anything, that: the actor is authorised (§16.3); the target
`StudentRecordId` exists in this tenant and its `EnrollmentStatus` is `Active`; the plan exists in this tenant/branch,
is `isActive`, and satisfies `availability` for the actor; the tenant is itself active; and `BC-21` Entitlement permits
the operation (`E-17`).

`MM-FR-034` — The `EnrollmentStatus` precondition **MUST** be evaluated by consuming `BC-01` state through `E-01`. It
**MUST NOT** be evaluated against a locally cached copy older than `MM-CFG-002`.

> **`E-01` is the governing edge**, and BC Map states its contract as *"Membership may not exist without an active
> enrollment."* `PRD-004` `SM-EV-1`/`SM-EV-2` are the events that carry it.

`MM-FR-035` — A student whose `EnrollmentStatus` is `Inactive`, `Suspended` or `Archived` **MUST NOT** receive a new
membership. The failure **MUST** be a typed error that names the enrollment state.

### 3.2 Creation inputs and outputs

`MM-FR-036` — Creation **MUST** accept: `studentRecordId`, `planId`, `startDate`, `idempotencyKey`. It **MAY** accept
a `note`.

`MM-FR-037` — `membershipId` **MUST** be system-generated, **MUST** be globally unique, and **MUST NOT** encode
tenant, student or sequence information that would leak across tenants or allow enumeration.

`MM-FR-038` — `startDate` **MUST** default to the current business date in the tenant's timezone (§4.4) and **MUST
NOT** be accepted more than `MM-CFG-003` days in the past or `MM-CFG-004` days in the future.

`MM-FR-039` — `endDate` **MUST** be computed by the module, **MUST NOT** be supplied by the caller, and **MUST** be
derived as specified in §4.3.

`MM-FR-040` — On success the module **MUST** persist the membership with `priceSnapshot`, `currencySnapshot`,
`planVersionAtPurchase`, `createdAt`, `createdBy`, and **MUST** emit `MM-EVT-001` `membership.MembershipCreated`.

### 3.3 Initial status and the payment dependency

This is the most consequential design decision in the document, and the architecture has already made it.

`MM-FR-041` — A newly created membership **MUST** be given an initial status determined by whether payment is
required: `PendingPayment` if the applicable amount is greater than zero and no payment outcome has been received, or
`Active` if the applicable amount is zero, or if a payment outcome for this membership has already been received.

`MM-FR-042` — A membership in `PendingPayment` **MUST NOT** confer entitlement. It **MUST** be reported as **not
valid** by the validity rule (§4.5) and **MUST NOT** appear as valid in the `MembershipValidity` projection.

`MM-FR-043` — Activation of a `PendingPayment` membership **MUST** occur only on receipt of `fee.FeePaymentReceived`
from `BC-05` (`E-10`), or by an explicitly authorised manual activation (`MM-PO-004`) which **MUST** be audited with a
reason.

> **This is not invented.** BC Map `E-10` states: *"`FeePaymentReceived` → **may activate a pending membership**
> (saga in V2, direct handler in V1)"*, and line 421 lists `BC-05` → `BC-02` with purpose *"Activates membership"*.
> The word *pending* is the architecture's own. `PendingPayment` is therefore a **recovered** state, not a new one —
> Line 209's column-3 illustration does not name it, which is not a contradiction: that column carries contextual
> meaning, not a binding enumeration. See §5.1, where this is ratified and `MM-GAP-006` is closed.

`MM-FR-044` — This module **MUST NOT** call a payment gateway, capture a payment, or record a monetary transaction. It
consumes the **outcome** only (§10).

### 3.4 Duplicate prevention and idempotency

`MM-FR-045` — The aggregate **MUST** enforce **no overlapping active terms for one `StudentRecordId`** — BC Map §8's
stated `BC-02` invariant, restated as `MM-INV-001`.

`MM-FR-046` — Overlap **MUST** be enforced by a database-level constraint or an equivalent serialising lock, not by a
read-then-write check in application code.

> **Why a constraint, not a check.** BC Map §10.1 lists *"double seat allocation"* as a case where eventual
> consistency fails because two staff act concurrently and the conflict *"cannot be compensated"*. Two reception staff
> selling the same student a membership at the same moment is the identical shape. A read-check-write is a race by
> construction. The Map's own prescription for the analogous seat case is *"DB-level unique constraint + row lock"*.

`MM-FR-047` — Every creation command **MUST** carry an `idempotencyKey`. A repeated command with the same key and the
same tenant **MUST** return the **original** result — the same `membershipId`, no new event, no second write.

`MM-FR-048` — Idempotency records **MUST** be tenant-scoped and **MUST** be retained for at least `MM-CFG-005`.

`MM-FR-049` — A creation attempt that would overlap an existing non-terminal membership **MUST** fail with a typed
error naming the conflicting `membershipId` and its term — and **MUST NOT** silently return the existing membership,
because the actor may have intended a different plan.

### 3.5 Failure handling

`MM-FR-050` — Every failure **MUST** leave no partial state: no membership row, no event, no audit entry claiming
success.

`MM-FR-051` — If `MM-EVT-001` cannot be published after the membership is committed, the event **MUST** be retried
from a transactional outbox. The membership **MUST NOT** be rolled back and the event **MUST NOT** be dropped.

> Dependency Matrix §382 records that the outbox is what keeps `E-07`/`E-10` from being a `BC-02` ↔ `BC-05` cycle. It
> is also the only way a domain write and an event publication can both be guaranteed without a distributed
> transaction, which `ADR-0001`'s modular monolith deliberately avoids.

---

## 4. Membership Activation & Validity — V1

### 4.1 Activation conditions

`MM-FR-052` — A membership **MUST** transition to `Active` only when all of: its status is `PendingPayment` or
`Scheduled`; the required payment outcome has been received (or the amount is zero, or `MM-PO-004` manual activation
was authorised); `startDate` has been reached in the tenant's timezone; and `endDate` has not passed.

`MM-FR-053` — A membership whose `startDate` is in the future and whose payment condition is satisfied **MUST** be
held in `Scheduled` and **MUST NOT** confer entitlement until `startDate`.

`MM-FR-054` — Activation **MUST** emit `MM-EVT-002` `membership.MembershipActivated` (not listed in BC Map §9, which
is the *seed* of the Event Catalog rather than a closed set for `BC-02` — reconciled in §12, `MM-GAP-007` closed).

### 4.2 Term semantics — normative

`MM-FR-055` — A term **MUST** be a closed inclusive interval of **business dates** in the tenant's timezone:
`[startDate, endDate]`. Both endpoints are dates, not timestamps.

`MM-FR-056` — `endDate` **MUST** be strictly greater than or equal to `startDate`. `endDate < startDate` **MUST** be
impossible (`MM-INV-002`, BC Map §8: *"`validUntil > validFrom`"*).

> **A disclosed narrowing.** BC Map §8 writes the invariant as strictly `validUntil > validFrom`. A single-day plan
> (`durationDays: 1`) yields `endDate == startDate` under §4.3, which satisfies `>=` but not `>`. Rather than silently
> pick one, this is recorded as `MM-GAP-008`: either single-day plans are disallowed, or the Map's `>` is read as
> applying to an exclusive-end formulation. **This document does not decide it**; `MM-FR-011` permits `durationDays:
> 1`, so implementations **MUST** treat `MM-GAP-008` as blocking for single-day plans only.

### 4.3 End-date calculation — deterministic

`MM-FR-057` — `endDate` **MUST** be computed as `startDate + (durationDays − 1)` days, using calendar-date arithmetic
in the tenant's timezone.

`MM-FR-058` — The computation **MUST** be a pure function of (`startDate`, `durationDays`, tenant timezone). It **MUST
NOT** depend on the current clock, on holidays, or on the working calendar.

> **Why `− 1`.** A 30-day membership starting on the 1st is valid *through* the 30th, not through the 31st. Inclusive
> endpoints with an off-by-one are the classic source of a customer-visible "my membership ended a day early" dispute.
> Stating the formula once, here, makes it testable.

`MM-FR-057a` — **The single permitted re-derivation, and the only one.** When a delayed payment activates a
membership whose `startDate` has already passed **and** `MM-CFG-009` is enabled (§10.2), the term **MUST** be
re-derived by setting `startDate` to the activation date and recomputing `endDate` by the **`MM-FR-057` formula
unchanged**. The activation date **MUST** be captured once, as `activatedAt` (§13.1), and passed in as the new
`startDate` input; the computation itself **MUST** remain the pure function `MM-FR-058` requires. Moving `endDate`
while holding `startDate` fixed **MUST** be impossible, because it would yield a term longer than `durationDays` and
break `MM-FR-057`.

> **Why this is stated as an input change, not an exception to the formula.** The naive reading — *"recompute
> `endDate` from the activation date"* — would make `endDate` a function of the clock, contradicting `MM-FR-058`, and
> would silently stretch the term past `durationDays`, contradicting `MM-FR-057`. Re-deriving **both** endpoints from
> a new `startDate` achieves the same commercial intent (the student is not charged for days they could not use)
> while leaving both requirements literally true: the formula is untouched, and the function stays pure because the
> activation date enters as a **recorded input** (`activatedAt`), not as a call to the clock inside the calculation.
> `MM-FR-047`'s idempotency therefore still holds — replaying the same activation event yields the same term.
> `MM-INV-002` (`endDate >= startDate`) is preserved for every `durationDays >= 1`.

`MM-FR-059` — Month-end, leap-day and 28/29/30/31-day-month cases **MUST** be handled by day arithmetic alone. Because
duration is in days (`MM-FR-011`), there is **no** "same day next month" rule and therefore no undefined 31 → 30
February case.

`MM-FR-060` — Holidays and library closure days **MUST NOT** extend a term in V1.

> **Why not.** `BC-06` Library Policy owns `HolidayCalendar`, and BC Map `E-06` routes it to `BC-05` for *"proration
> and freeze-day computation"* — both of which are **V2** here (`MM-XC-009`, `MM-XC-012`). There is no `BC-06` →
> `BC-02` edge in §7. Extending terms for holidays in V1 would require an edge that does not exist and a proration
> rule that is deferred. Recorded as `MM-GAP-009`.

### 4.4 Timezone and boundary rules

`MM-FR-061` — All term arithmetic, expiry determination and business-date resolution **MUST** use the tenant's
configured timezone (`MM-CFG-006`), never the server's, never the client's.

`MM-FR-062` — A term **MUST** be considered to end at the **end of** `endDate` in the tenant timezone — that is, the
membership is valid for the whole of `endDate`.

`MM-FR-063` — Timestamps persisted for audit and events (`createdAt`, `activatedAt`) **MUST** be stored in UTC. Only
term endpoints are dates.

`MM-FR-064` — A change to the tenant's configured timezone **MUST NOT** retroactively alter the `startDate` or
`endDate` of any existing membership.

### 4.5 The authoritative validity rule — normative

This is the rule the instruction asks for, and the reason `BC-02` exists as a separate context.

`MM-FR-065` — **A membership is valid at business date `D` if and only if all of the following hold:** its
`MembershipStatus` is `Active`; `startDate <= D`; `D <= endDate`; and its `tenantId` matches the querying tenant
context.

`MM-FR-066` — This rule **MUST** be implemented once, inside `BC-02`, and exposed through the `MembershipValidity`
projection (`E-02`) and a synchronous validity port. It **MUST NOT** be reimplemented in `BC-03`, `BC-04`, `BC-01`'s
directory, any dashboard, or any client.

`MM-FR-067` — The projection contract **MUST** carry at least
`MembershipValidity{studentRecordId, validUntil, seatQuota}` — the exact shape BC Map `E-02` specifies — and **MUST**
additionally carry `isValid`, `status`, `planId` and `tenantId`.

> The three extra fields are additive, not a redefinition: `isValid` prevents every consumer from re-deriving the rule
> from `validUntil` (which is the duplication `MM-FR-066` forbids), and `status` lets the Library Member Directory show
> *why* something is invalid, which `PRD-004` `LMD-16` and `LMD-26` already require it to display.

`MM-FR-068` — A membership in `PendingPayment`, `Scheduled` or `Expired` **MUST** report `isValid: false`.

### 4.6 What happens when validity ends

`MM-FR-069` — When a term ends the membership **MUST** transition to `Expired` (§7) and the projection **MUST** be
updated so that consumers observe `isValid: false`.

`MM-FR-070` — Loss of validity **MUST NOT** alter the student's `EnrollmentStatus`, delete the membership, or alter
any historical snapshot (`MM-FR-005`, `MM-FR-027`).

`MM-FR-071` — This module **MUST NOT** release a seat, cancel an attendance record, or write to any downstream
context. It emits `MM-EVT-005` and downstream contexts apply their own policy.

> **`Q-01` is open and is not decided here.** BC Map `Q-01` asks *"does an expired membership release the seat
> immediately, at end-of-day, or after a grace period?"* with a recommendation of *"configurable per tenant (BC-25),
> default 24h grace"*, and Master PRD line 673 still lists it as **Open**. Seat-release semantics are `BC-04`'s to
> implement; the grace period is `Q-01`'s to settle. §7.4 covers this explicitly.

---

## 5. Membership Status & Entitlement — V1

### 5.1 The V1 status set

`MM-FR-072` — `MembershipStatus` **MUST** be a closed set of exactly these six V1 values:

| Status | Meaning | Confers entitlement |
|---|---|---|
| `PendingPayment` | Created; required payment outcome not yet received | **No** |
| `Scheduled` | Payment condition satisfied; `startDate` not yet reached | **No** |
| `Active` | Within term, payment satisfied | **Yes** |
| `Expired` | `endDate` has passed | **No** |
| `Superseded` | Replaced by an upgrade (§6) | **No** |
| `Cancelled` | Voided before activation (§5.4) | **No** |

`MM-FR-073` — `Frozen` **MUST NOT** be a reachable V1 status (`MM-XC-009`). The field **MAY** be modelled to admit it
later, but no V1 command **MUST** be able to produce it.

> **Relationship to BC Map line 209 — ratified, not a divergence.** Line 209 sits in BC Map **§5 Ubiquitous
> Language Collisions**, whose preamble states its own authority verbatim: *"The resolution column is binding: these
> are the names that must appear in code, APIs, events and UI copy."* The row has four columns. `Valid/Expired/Frozen`
> sits in column 3, headed **`Context B meaning`** — a gloss explaining why the bare word `Status` is ambiguous.
> Column 4, headed **`Resolution (binding)`**, reads: *"`EnrollmentStatus` vs `MembershipStatus`. **Two independent
> state machines** — a student can be Active with an Expired membership."*
>
> **This document complies with the binding column in full:** it names the type `MembershipStatus` (`MM-FR-072`),
> keeps it independent of `EnrollmentStatus` (§1.3, `MM-XC-002`), and preserves the documented case — a student
> `Active` in `BC-01` with an `Expired` membership here (`MM-FR-065`).
>
> Four corroborating findings, each verified against a primary source:
> 1. **Columns 2 and 3 are demonstrably not exhaustive enumerations.** The same table's `Role` row (line 212) glosses
>    `AccessRole` as *"a permission bundle (Owner/Manager/Reception)"* — three values — while the Rank 3
>    Authentication PRD defines **five**, adding Platform Support (§2.2.6) and Platform Administrator (§2.2.7), and
>    `BR-2.9` speaks of *"Owner, Manager, Reception, and both platform roles"*. If column 2 were an exhaustive
>    enumeration, that Rank 3 PRD would be in breach. It is not. Therefore these columns illustrate meaning; they do
>    not close a value set.
> 2. **`Frozen` cannot be a V1 `MembershipStatus`.** Membership Freeze is **V2** (EA line 728) and its stated purpose
>    in the event surface is *"Proration + seat hold"*, with Proration also **V2** (EA line 731). Reading column 3 as
>    the V1 set would mandate a V1 status reachable only by a V2 feature.
> 3. **A pre-activation state is required by Rank 4 itself.** `E-10` (line 307) reads *"`FeePaymentReceived` → may
>    activate a **pending** membership (saga in V2, direct handler in V1)"*, and the event surface (line 421) gives
>    that event the purpose *"**Activates membership**, receipt"*. `Valid/Expired/Frozen` cannot represent *"a pending
>    membership"*. `PendingPayment` is recovered from the Map, not asserted against it.
> 4. **`Valid` is derived, not stored.** `E-02` (line 299) publishes `MembershipValidity{studentRecordId, validUntil,
>    seatQuota}` and the §8 aggregate invariant is `validUntil > validFrom` — both treat validity as computed from
>    dates. `MM-FR-065` defines it as status **and** date range **and** tenant. Storing `Valid` as a status would make
>    one fact representable two ways, which is the conflation `MM-FR-066` exists to prevent.
>
> **Status of `MM-GAP-006`: closed.** Ratified 2026-08-04 on the evidence above — see
> [`PRD-005_BLOCKER_ANALYSIS.md`](PRD-005_BLOCKER_ANALYSIS.md) §2 and
> [`PRD-005_CORRECTION_REPORT.md`](PRD-005_CORRECTION_REPORT.md) §2. **No ADR is required and the BC Map is not
> modified**, because the binding column is satisfied and no ranked statement is contradicted. One residual
> observation is carried forward, against the BC Map rather than against this document: §5's per-context columns
> would be clearer if annotated *"illustrative, not exhaustive"*, and the event surface has no `BC-02` pre-activation
> state despite `E-10` (`MM-GAP-006a`, §25.2 — an editorial observation, not a blocker).

### 5.2 Transitions — normative and closed

`MM-FR-074` — The following are the **only** permitted V1 transitions. Any other transition **MUST** be impossible.

| From | To | Trigger | Event |
|---|---|---|---|
| — | `PendingPayment` | Create, amount > 0 | `MM-EVT-001` |
| — | `Scheduled` | Create, amount = 0 or already paid, future `startDate` | `MM-EVT-001` |
| — | `Active` | Create, amount = 0 or already paid, `startDate` = today | `MM-EVT-001` + `MM-EVT-002` |
| `PendingPayment` | `Scheduled` | Payment received, future `startDate` | `MM-EVT-002` |
| `PendingPayment` | `Active` | Payment received, `startDate` reached | `MM-EVT-002` |
| `PendingPayment` | `Cancelled` | Authorised void, or payment window elapsed (`MM-CFG-007`) | `MM-EVT-007` |
| `Scheduled` | `Active` | `startDate` reached | `MM-EVT-002` |
| `Scheduled` | `Cancelled` | Authorised void before activation | `MM-EVT-007` |
| `Active` | `Expired` | `endDate` passed | `MM-EVT-005` |
| `Active` | `Superseded` | Upgrade committed (§6) | `MM-EVT-004` |
| `Expired` | `Superseded` | Upgrade from expired is **not** permitted in V1 — see `MM-FR-093` | — |

`MM-FR-075` — `Expired`, `Superseded` and `Cancelled` **MUST** be terminal. A renewal **MUST** create a **new**
membership rather than reviving a terminal one (§6.2, `MM-BR-020`).

### 5.3 Student status vs membership status

`MM-FR-076` — The two **MUST** be displayed and stored as separate fields wherever both appear, exactly as `PRD-004`
`SM-2.7` and §509 already require of the Directory.

`MM-FR-077` — A student suspension (`enrollment.StudentStatusChanged`, `E-01`) **MUST NOT** change
`MembershipStatus`. It **MUST** cause the validity projection to report `isValid: false` for the duration of the
suspension, without mutating the membership record.

> **Why suppress rather than mutate.** `PRD-004` §288 requires that on suspension *"`BC-04` Seating and `BC-02`
> Membership MUST react by refusing new seat…"*. Refusing entitlement is the requirement; rewriting the membership's
> own status would destroy the term the student paid for, and would be unrecoverable on un-suspension. Suppression at
> the projection is reversible and leaves the paid term intact. V1 carries no distinct reason code on the projection:
> `MM-FR-068` and `MM-FR-077` both express suppression as `isValid: false`. Whether a read should distinguish
> *suspended* from *expired* is a presentation concern this document does not decide.

### 5.4 Cancellation before activation is not "Membership Cancellation"

`MM-FR-078` — Voiding a `PendingPayment` or `Scheduled` membership that never conferred entitlement **MUST** be
permitted (`MM-PO-005`), **MUST** be audited with a reason, and **MUST** emit `MM-EVT-007`.

`MM-FR-079` — This **MUST NOT** be extended to an `Active` membership, **MUST NOT** trigger a refund, and **MUST NOT**
be presented to users as "cancel membership". Membership Cancellation with refund is **V2** (`MM-XC-011`).

> **Why this is V1 and not scope creep.** A reception desk that creates a membership on the wrong student or wrong plan
> needs a correction path *before money moves*. Without one, the only recovery is an overlapping-term error blocking
> the correct membership forever (`MM-INV-001`). This is error correction on a non-entitling record, not commercial
> cancellation. Classified **Required for V1** in §24.1.

---

## 6. Membership Renewal & Upgrade — V1

### 6.1 Renewal eligibility

`MM-FR-080` — Renewal **MUST** be permitted only when: the source membership exists in this tenant; its status is
`Active` or `Expired`; the student's `EnrollmentStatus` is `Active`; the target plan is `isActive`; and Entitlement
permits (`E-17`).

`MM-FR-081` — Renewal **MUST** be permitted from `Expired` without limit of elapsed time in V1. No re-enrollment
**MUST** be required.

`MM-FR-082` — Renewal **MUST NOT** be permitted from `PendingPayment`, `Scheduled`, `Superseded` or `Cancelled`.

`MM-FR-083` — V1 renewal **MUST** renew onto the **same plan** by default. Renewing onto a different plan **MUST** be
treated as a new membership creation (§3), not as a renewal, so that term arithmetic and price snapshotting stay
unambiguous.

### 6.2 Renewal creates a new membership

`MM-FR-084` — Renewal **MUST** create a **new** `Membership` with a new `membershipId`, a new term and a fresh price
snapshot, and **MUST** record `renewedFromMembershipId`. It **MUST NOT** mutate the previous membership's term.

> **Why not extend in place.** `MM-FR-027` makes the price snapshot immutable, and `BC-05` raises a `FeeDue` per
> renewal event. Extending a term in place would make one record carry two prices and two fee events, and would erase
> the history a library needs to answer "what did this student pay, and for which period?". It also keeps
> `MM-INV-001`'s overlap constraint meaningful.

### 6.3 New term calculation — the three boundary cases

`MM-FR-085` — The new term's `startDate` **MUST** be computed as follows. **This table is normative.**

| Case | Condition | New `startDate` | Rationale |
|---|---|---|---|
| Renewal **before** expiry | Source `Active`, `today < endDate` | `endDate + 1 day` | The student keeps every day already paid for. No overlap, no lost day |
| Renewal **on** the expiry boundary | Source `Active`, `today == endDate` | `endDate + 1 day` | Identical to the above — the source is valid for all of `endDate` (`MM-FR-062`) |
| Renewal **after** expiry | Source `Expired`, `today > endDate` | `today` | Back-dating to `endDate + 1` would sell days already elapsed |

`MM-FR-086` — The new `endDate` **MUST** be computed from the new `startDate` by §4.3, using the **target plan's
current** `durationDays`.

`MM-FR-087` — Renewal before expiry **MUST NOT** create overlapping active terms. The new membership **MUST** be
`Scheduled` (or `PendingPayment`) until its `startDate`, at which point the source is already `Expired`.

`MM-FR-088` — The renewal amount **MUST** be the target plan's **current** price at the moment of renewal, snapshotted
onto the new membership. It **MUST NOT** be copied from the source membership's snapshot.

### 6.4 Renewal duplicate prevention, idempotency, failure

`MM-FR-089` — Every renewal command **MUST** carry an `idempotencyKey` and **MUST** be idempotent per `MM-FR-047`.

`MM-FR-090` — A second renewal of the same source membership **MUST** fail with a typed error naming the existing
successor, and **MUST NOT** create a second successor (`MM-INV-005`).

`MM-FR-091` — Renewal **MUST** emit `MM-EVT-003` `membership.MembershipRenewed` on success, and **MUST** leave no
partial state on failure (`MM-FR-050`).

`MM-FR-092` — Renewal **MUST** follow the same payment dependency as creation (§3.3): a renewal requiring payment
**MUST** begin in `PendingPayment` and **MUST NOT** confer entitlement until the payment outcome arrives.

### 6.5 Upgrade

`MM-FR-093` — Upgrade **MUST** be permitted only from an `Active` membership. Upgrade from `Expired`, `PendingPayment`,
`Scheduled`, `Superseded` or `Cancelled` **MUST** be rejected.

> An expired membership has no remaining value to carry forward; the correct operation is renewal onto the desired
> plan, which §6.1/`MM-FR-083` routes to creation.

`MM-FR-094` — The set of available upgrade targets **MUST** be the active plans in the same tenant/branch whose price
is **strictly greater** than the source membership's `priceSnapshot`.

`MM-FR-095` — An "upgrade" to a plan of equal or lower price **MUST** be rejected as a downgrade (`MM-XC-008`, EA line
727: Membership Downgrade is **V2**).

`MM-FR-096` — Upgrade **MUST** create a new `Membership` referencing the target plan with `upgradedFromMembershipId`
set, and **MUST** transition the source membership to `Superseded`.

`MM-FR-097` — The upgrade's effective date **MUST** be the current business date, and the new term **MUST** run
`[today, today + (targetPlan.durationDays − 1)]`.

`MM-FR-098` — The source membership's `endDate` **MUST NOT** be altered. Its remaining days are recorded, not
rewritten, by `Superseded` plus `upgradedFromMembershipId`.

`MM-FR-099` — The **price difference** applicable to an upgrade **MUST** be computed as
`targetPlan.price − sourceMembership.priceSnapshot` and published on `MM-EVT-004`, together with the source's remaining
day count.

`MM-FR-100` — This module **MUST NOT** compute a prorated monetary credit for the source membership's unused days, and
**MUST NOT** compute a refund.

> **This is the `Q-06` boundary, and it is open.** BC Map `Q-06` asks *"who owns proration arithmetic — BC-02 (rules)
> or BC-20/Business (execution)?"*, recommending *"BC-02 computes the entitlement delta, Business Platform executes
> the money"*, and Master PRD line 678 still lists it **Open**. `MM-FR-099` publishes the **entitlement delta**
> (price difference and remaining days) which is the recommendation's `BC-02` half; it deliberately stops short of
> money. Full Proration Rules are **V2** (EA line 731). Recorded as `MM-GAP-002` — this document does **not** close
> `Q-06`.

`MM-FR-101` — Upgrade **MUST** be idempotent per `MM-FR-047`, **MUST** reject a second upgrade of the same source
(`MM-INV-005`), **MUST** emit `MM-EVT-004` on success, and **MUST** follow §3.3's payment dependency.

`MM-FR-102` — Upgrade immediately after creation, while the source is still `PendingPayment`, **MUST** be rejected by
`MM-FR-093`. The correct correction path is void-and-recreate (§5.4).

---

## 7. Membership Expiry — V1

### 7.1 Expiry rule

`MM-FR-103` — A membership **MUST** be considered expired once the tenant-timezone business date is strictly greater
than `endDate`.

`MM-FR-104` — Expiry **MUST** be deterministic from stored data. It **MUST NOT** depend on whether a background job
has run.

> **Why both a rule and a job.** Reading validity must never return a stale `Active` because a scheduler was down.
> The rule at §4.5 is evaluated at read time; the job below exists to *materialise* the status change and emit the
> event, not to define truth. This split is what makes `MM-AC-041` testable with the scheduler stopped.

### 7.2 Expiry detection

`MM-FR-105` — A scheduled process **MUST** transition due memberships from `Active` to `Expired` and emit `MM-EVT-005`
`membership.MembershipExpired` exactly once per membership.

`MM-FR-106` — The process **MUST** be idempotent and safe to re-run, **MUST** be tenant-scoped in its effects, and
**MUST NOT** emit a duplicate event for a membership already `Expired`.

`MM-FR-107` — A membership whose `endDate` has passed **MUST** report `isValid: false` under §4.5 **even if** the
process has not yet run.

`MM-FR-108` — The module **MUST** emit `MM-EVT-006` `membership.MembershipExpiringSoon` when a membership is within
`MM-CFG-008` days of `endDate`, exactly once per membership per threshold crossing.

### 7.3 Entitlement after expiry

`MM-FR-109` — An `Expired` membership **MUST NOT** confer entitlement under any read path (`MM-INV-004`).

`MM-FR-110` — `Expired` **MUST NOT** be an `EnrollmentStatus`. `PRD-004` `SM-2.7` already forbids it; this document
**MUST NOT** contradict it.

### 7.4 Grace period — NOT decided here

`MM-FR-111` — V1 **MUST NOT** implement a grace period that extends entitlement beyond `endDate`.

> **Why, precisely.** The instruction says *"grace period only if already established by architecture"* and *"do not
> invent a grace period if the architecture has not decided it."* The architecture has **not** decided it: BC Map
> `Q-01` is an **open question** whose recommendation is *"configurable per tenant (BC-25), default 24h grace"*, and
> Master PRD line 673 lists it as **Open**. A recommendation inside an open question is not a decision.
>
> Note also *what* `Q-01` asks: it is about **seat release** timing (`BC-02` → `BC-04` handler semantics), not about
> extending membership validity. Even when settled, it may confer no entitlement extension at all. Implementing one
> now would both invent a decision and possibly invent the wrong one. Recorded as `MM-GAP-001`.

`MM-FR-112` — Seat reclamation after expiry **MUST** be `BC-04`'s decision, driven by `MM-EVT-005`. This module
**MUST NOT** specify when the seat is released.

---

## 8. Operational Membership Views — V1

### 8.1 Nature and boundary

`MM-FR-113` — The views in this chapter **MUST** be operational lists answering *"what must staff do today?"*. They
**MUST NOT** compute rates, trends, cohorts, forecasts or comparisons between periods (§9).

`MM-FR-114` — Every view **MUST** be tenant- and branch-scoped and **MUST** be subject to §16.3 authorisation.

### 8.2 Required V1 views

| View | Content | Requirement |
|---|---|---|
| Active memberships | Status `Active`, valid today | `MM-FR-115` |
| Expiring memberships | `Active`, `endDate` within `MM-CFG-008` days | `MM-FR-115` |
| Expired memberships | Status `Expired`, `endDate` within a selected window | `MM-FR-115` |
| Renewal-due list | Expiring **plus** recently expired and not yet renewed | `MM-FR-116` |
| Today's renewals | Renewals created today | `MM-FR-116` |
| Plan-wise current count | Count of currently valid memberships grouped by plan | `MM-FR-117` |
| Membership detail | One membership, full term/plan/status/snapshot/history refs | `MM-FR-118` |

`MM-FR-115` — The active, expiring and expired lists **MUST** be provided, **MUST** support pagination, and **MUST**
support filtering by `status`, `planId` and a date range over `startDate` or `endDate`.

`MM-FR-116` — The renewal-due and today's-renewals lists **MUST** be provided and **MUST** be derivable from
membership state without any analytics store.

`MM-FR-117` — A plan-wise count of currently valid memberships **MUST** be provided as a **current-state count**. It
**MUST NOT** include historical trend, period comparison or growth rate.

> **Why this is operational and not analytics.** "How many students are on the Night Shift plan right now" is a
> capacity question a manager answers at the desk; it is a `COUNT` over current state. "How is Night Shift retention
> trending quarter over quarter" requires history, cohorts and a projection — that is `BC-26`'s job and, per EA, is
> not V1. The dividing line used throughout this document is: **current state = operational; change over time =
> analytics.**

`MM-FR-118` — Search within these views **MUST** support locating a membership by student. The student's name **MUST
NOT** be stored here (`MM-FR-003`); the view **MUST** resolve it through `BC-01`, or accept a `studentRecordId`
supplied by a `BC-01`-owned search.

> This is the same discipline `PRD-004` `LMD-16` applies in the other direction: the Directory reads the `BC-02`
> projection for expiry rather than duplicating it. Here, `BC-02` reads `BC-01` for names rather than duplicating them.

### 8.3 Dashboard consumption

`MM-FR-113` through `MM-FR-118` **MAY** be consumed by the Owner, Manager and Reception dashboards. EA line 811 lists
*Membership Overview (V1)* on the dashboard, and line 778 *Membership Status (V1)* — both are satisfied by these
current-state views without any analytics dependency.

---

## 9. Membership Analytics — explicitly NOT V1

`MM-XC-006` forbids it. Concretely, V1 **MUST NOT** include: churn, retention, cohort analysis, renewal-rate
analytics, plan performance analytics, predictive membership analytics, membership trends, or forecasting.

`MM-BR-030` — This module **MUST NOT** own an analytics store, and `BC-26` **MUST** learn about membership only from
the events in §12 (`MP-GBR-37`: *"Analytics has no read access to domain tables… every projection must be rebuildable
from the event log"*).

**The V1/V3 line, stated once:**

| V1 operational membership data (this document) | V3 membership analytics (`BC-26`, not this document) |
|---|---|
| Current count of valid memberships per plan | Plan performance and revenue contribution over time |
| Who expires in the next 7 days | Predicted churn probability per student |
| Who expired and has not renewed | Renewal-rate and retention curves |
| Renewals created today | Cohort retention by join month |
| One membership's term and status | Membership trend and forecast |

> **A conflict is recorded here rather than resolved.** The instruction states *"the existing architecture classifies
> Membership Analytics = V3"*, and EA line 734 does say **V3** inside the Membership Management module. But EA line
> 837 (*Analytics & Growth Reports*) and line 1607 (*Business Intelligence*) both say **V2**. The three lines
> disagree. **What matters for this PRD is that all three agree it is not V1**, so nothing changes here — but the
> V2-vs-V3 discrepancy is a real defect in a Rank 6 document and is recorded as a cross-document conflict in §25.1.
> This document does not choose between them.

---

## 10. Payment / Finance Boundary

### 10.1 The split — normative

| Membership Management (`BC-02`) owns | Revenue & Finance (`BC-05`) / Business Platform owns |
|---|---|
| The **amount applicable** to a membership (price snapshot) | The payment **transaction** |
| The **entitlement** a membership confers | The payment **gateway** and vendor integration |
| The renewal / upgrade **decision** and eligibility | **Collection**, receipts, the financial **ledger** |
| **Activation** upon a required payment outcome | **Refunds** and **reconciliation** |
| The entitlement **delta** on upgrade (`MM-FR-099`) | The **money** movement for that delta (`Q-06`) |

`MM-BR-001` — This module **MUST NOT** contain a payment ledger, balance, receipt or refund record (`MM-XC-004`).
`BC-05`'s `FeeLedger` invariant — *"balance = Σ dues − Σ receipts (never stored independently)"* — would be violated by
any second ledger.

`MM-BR-002` — This module **MUST** learn payment outcomes **only** by consuming `fee.FeePaymentReceived` via `E-10`.
It **MUST NOT** poll a gateway.

`MM-BR-003` — This module **MUST** emit `MM-EVT-001`/`003`/`004` so that `BC-05` can raise or adjust a `FeeDue` via
`E-07`. It **MUST NOT** create the `FeeDue` itself.

### 10.2 Failure scenarios — deterministic outcomes

**This table is normative.**

| Scenario | Required outcome |
|---|---|
| **Payment succeeds, membership update fails** | The payment stands; `BC-05`'s ledger is authoritative. The membership remains `PendingPayment` and **MUST** appear in a **reconciliation queue** for staff action. The payment **MUST NOT** be reversed by this module, and the membership **MUST NOT** be silently activated later without the event |
| **Payment fails** | Membership stays `PendingPayment`, confers nothing, and remains correctable or voidable (§5.4). No event beyond `MM-EVT-001` is emitted |
| **Payment callback duplicated** | Activation **MUST** be idempotent on the payment reference. The second callback **MUST** produce no second activation and no second `MM-EVT-002` |
| **Payment confirmation delayed** | The membership stays `PendingPayment` and confers nothing. On arrival it activates. If `startDate` has **not** passed, the original term stands unchanged. If `startDate` **has** passed, the outcome is governed by `MM-CFG-009` and by `MM-FR-057a` — **either** the original term stands (default, `MM-CFG-009` = `false`), **or** the whole term is re-derived from a new `startDate` equal to the activation date, with `endDate` recomputed by the **same** `MM-FR-057` formula so the student receives the full `durationDays` they paid for. `endDate` **MUST NOT** be moved while `startDate` is held fixed, as that would lengthen the term beyond `durationDays` |
| **User retries the operation** | The `idempotencyKey` **MUST** cause the original result to be returned. A retry **MUST NOT** create a second membership or a second fee event |
| **Payment received for a voided membership** | Activation **MUST** be refused. The event **MUST** be recorded and surfaced in the reconciliation queue for a refund decision by `BC-05` — this module **MUST NOT** initiate the refund |

`MM-BR-004` — A visible **reconciliation queue** **MUST** exist for memberships whose payment and entitlement state
disagree.

> **This is architecture, not invention.** BC Map §10 line 465 states the V1 constraint for *"Renew membership with
> payment"* explicitly: *"reception UI performs the two steps as an explicit two-stage flow with a **visible
> reconciliation queue for failures** — deliberately not hidden behind a fake atomic button."* The saga is V2 (`BC-28`).
> The queue is the V1 mechanism the Map names, so it is mandatory here.

`MM-BR-005` — Duplicate payment capture protection **MUST** rely on the gateway reference uniqueness and idempotency
key that BC Map §10.1 prescribes, since *"charging a student twice is unrecoverable trust damage"*. Enforcement of the
payment side is `BC-05`'s; this module **MUST** be idempotent on its own activation path regardless.

---

## 11. Cross-Domain Boundaries & Integrations

### 11.1 Edges — all pre-declared in BC Map §7

`MM-BR-006` — This module **MUST NOT** use any integration edge not listed below. BC Map line 292: *"if an edge is not
in this table, it does not exist and adding it requires an ADR."*

| Edge | Direction | Pattern | Mechanism | Use here |
|---|---|---|---|---|
| `E-01` | `BC-01` → `BC-02` | `C/S` | Event | `StudentEnrolled`, `StudentStatusChanged` — enrollment precondition (§3.1) |
| `E-02` | `BC-02` → `BC-04` | `C/S` + `PL` | Read projection | `MembershipValidity` — Seating **rejects** if invalid |
| `E-03` | `BC-02` → `BC-03` | `C/S` + `PL` | Read projection | Same projection — Attendance **flags**, does not block |
| `E-07` | `BC-02` → `BC-05` | `C/S` | Event | `MembershipCreated/Renewed/Upgraded` → `FeeDue` |
| `E-10` | `BC-05` → `BC-02` | `C/S` | Event | `FeePaymentReceived` → activates pending membership |
| `E-17` | `BC-02` → `BC-21` | `CF` | Sync port | `check(tenantId, feature, delta)` **before** mutation |
| `E-18` | `BC-02` → `BC-19` | `SK` | Ambient `TenantContext` | Never a domain method parameter |
| `E-19` | `BC-02` → `BC-25` | `CF` | Sync port | Typed config accessors (§13.4) |
| `E-20` | `BC-02` → `BC-24` | `PL` | Event, outbox-backed | Audit — never synchronous |
| `E-23` | `BC-02` → `BC-22` | `PL` | Event | Facts only, never "send an SMS" |

`MM-BR-007` — The `E-02`/`E-03` asymmetry **MUST** be preserved: Seating **blocks** on invalid membership, Attendance
**records and flags**. `MP-GBR-16` states it as a global rule and BC Map §7.1 adds *"documented here so a future
engineer does not 'fix' it."*

`MM-BR-008` — This module **MUST NOT** consume `BC-06` Library Policy directly. No `BC-06` → `BC-02` edge exists
(§4.3 rationale, `MM-GAP-009`).

`MM-BR-009` — This module **MUST NOT** produce to `BC-23` Search Indexing. `E-21` names only `BC-01` and `BC-10`
(§2.7, `MM-GAP-004`).

### 11.2 Ownership respected — no duplication

`MM-BR-010` — Student profile → `BC-01`. Enrollment relationship → `BC-01`. **Membership lifecycle and entitlement →
this module.** Attendance → `BC-03`. Seat allocation and occupancy → `BC-04`. Financial transactions → `BC-05`.
Authentication/authorisation → `BC-18`. Notification delivery → `BC-22`. Analytics → `BC-26`. None of these **MUST**
be reimplemented here.

`MM-BR-011` — This module **MUST** supply the Library Member Directory (`PRD-004` §5) with plan, membership status,
`validUntil` and seat quota through the `E-02` projection, and **MUST NOT** duplicate the Directory.

> `PRD-004` §604 already records the contract from the other side: *"Plan, membership status, `validUntil`, seat quota
> | `BC-02` | none — none required | composition of the `BC-02` public read model | Eventual."* This document supplies
> exactly that and nothing more.

### 11.3 Consistency and failure per edge

`MM-BR-012` — Validity consumed by `BC-04`/`BC-03` is **eventually consistent**. BC Map §10 accepts a bounded staleness
of **< 5s** for seat assignment: *"stale membership projection is an accepted, bounded risk."*

`MM-BR-013` — If the `E-01` stream is unavailable, creation **MUST** fail closed rather than assume an active
enrollment. If `BC-21` Entitlement times out, the policy **MUST** follow `Q-03`'s per-gate rule — paid gates
fail-closed. Membership creation is a paid gate and therefore **MUST** fail closed.

---

## 12. Domain Events — `MM-EVT-001` … `MM-EVT-007`, closed set (enforced by `MM-BR-035`)

`MM-BR-014` — Event names **MUST** follow the binding convention of BC Map §9 (*Published Language — Event Surface*):
`<Context>.<Aggregate><PastTenseVerb>`. An imperative name is a command and **MUST NOT** enter the event bus.

`MM-BR-015` — No event **MUST** carry a mobile number (`MP-GBR-34`), and no event **MUST** carry a name, email,
photograph or any `BC-10` profile field.

`MM-BR-016` — Every event **MUST** carry `tenantId`, `membershipId`, `studentRecordId`, `occurredAt` (UTC), an
`eventId` for idempotency, and a monotonic `sequence` per membership for ordering.

| ID | Event | Trigger | Consumers | Payload beyond the common set | Purpose |
|---|---|---|---|---|---|
| `MM-EVT-001` | `membership.MembershipCreated` | Membership persisted | `BC-05`, `BC-04`, `BC-22` | `planId`, term, `priceSnapshot`, `currency`, `status`, `seatQuota` | Generates dues, unlocks seating |
| `MM-EVT-002` | `membership.MembershipActivated` | Transition to `Active` | `BC-04`, `BC-03`, `BC-22` | `activatedAt`, `activationReason`, term | Entitlement begins |
| `MM-EVT-003` | `membership.MembershipRenewed` | Renewal committed | `BC-05`, `BC-22` | new term, `priceSnapshot`, `renewedFromMembershipId` | Extends validity |
| `MM-EVT-004` | `membership.MembershipUpgraded` | Upgrade committed | `BC-05`, `BC-04`, `BC-22` | `fromPlanId`, `toPlanId`, `priceDifference`, `remainingDaysOnSource`, `upgradedFromMembershipId` | Adjusts dues, new quota |
| `MM-EVT-005` | `membership.MembershipExpired` | Term ended, materialised | `BC-04`, `BC-22` | `expiredOn` | Seat reclamation policy |
| `MM-EVT-006` | `membership.MembershipExpiringSoon` | Within `MM-CFG-008` of `endDate` | `BC-22`, `BC-28` (V2) | `endDate`, `daysRemaining` | Reminder trigger — **a fact, not a command** |
| `MM-EVT-007` | `membership.MembershipVoided` | Void before activation (§5.4) | `BC-05`, `BC-24` | `reason`, `voidedBy` | Correction record |

`MM-BR-017` — Consumers **MUST** be idempotent on `eventId`. Producers **MUST** deliver at-least-once through a
transactional outbox with retry.

`MM-BR-018` — Ordering **MUST** be guaranteed per `membershipId` via `sequence`. Global cross-membership ordering
**MUST NOT** be assumed by any consumer.

`MM-BR-019` — Notification and Analytics **MUST NOT** be part of this domain. They are consumers of facts (`E-23`,
`MP-GBR-33`; `MP-GBR-37`).

`MM-BR-035` — The event register above **MUST** be closed at **seven** events. Adding, removing or renaming an
`MM-EVT-*` **MUST** require a new version of this document, and **MUST NOT** be done by an implementation. Every
**V1** consumer named in the table **MUST** be reachable on an integration edge already declared in `MM-BR-006`; a V1
consumer that is not **MUST NOT** be listed here. A consumer annotated **`(V2)`** asserts **no V1 edge and no V1
delivery obligation**: it **MAY** be listed only where BC Map §9 already names it, and **MUST NOT** be depended on by
any V1 behaviour in this document.

> **Why `BC-28` is annotated `(V2)` rather than removed.** `MM-EVT-006`'s consumer cell names `BC-22` and `BC-28`
> (V2). Three facts about the BC Map are verifiable directly and are the *only* ones this note relies on: `BC-28`
> Workflow Orchestration is a **V2** context (register line 137, V2 roll-up line 147); BC Map **§9** line 411 names
> `BC-28` a consumer of `membership.MembershipExpiringSoon`; and BC Map **§7** declares **no edge to `BC-28` at all**.
>
> **What that absence does and does not establish.** It does **not** establish that the absence is by construction.
> §7 is scoped by its preamble (line 292) to *"every edge that crosses a context boundary **in V1**"*, but V2 status
> alone does not keep a context out of the table: **§7 does declare edges whose consumers are V2 contexts** — `E-14`
> (line 318) runs from **V1** `BC-13` Trust & Safety to `BC-11`, `BC-12` and the **V2** contexts `BC-14` and `BC-15`,
> and `BC-14` appears again as an upstream on `E-22` (line 331). So `BC-28`'s absence from §7 is consistent with two
> readings — a deliberate deferral of V2 orchestration edges, or an omission — and **the BC Map does not distinguish
> between them.** Which of the two it is **is not a question this document may settle**; it is recorded for the
> architecture owner as **`MM-GAP-010a`** (§25.2).
>
> **Why `PRD-005` is nevertheless correct under either reading, and why `BC-28` is retained.** BC Map §9 line 411
> names `BC-28` itself, so deleting it would make this table diverge from the Rank 4 Published Language. The `(V2)`
> annotation, made enforceable by `MM-BR-035` above, is what keeps the claim honest: it asserts **no V1 edge and no V1
> delivery obligation**. **No V1 edge to `BC-28` is asserted, none is invented, the BC Map is not modified, and no V1
> behaviour here depends on `BC-28`.** V1 delivery of this event is to `BC-22` on `E-23` alone — which is true whether
> the absent edge turns out to be deliberate or an omission, so no resolution of `MM-GAP-010a` can falsify anything in
> this document.
>
> **How this differs from the `BC-26` case below.** `BC-26` Analytics is a **V1** context (line 135) named as a
> consumer in §9 with no inbound §7 edge from any of the eleven producers that name it — a tension squarely inside
> §7's declared V1 scope, and one that would bear on V1 delivery obligations. `BC-28` is V2 and carries no V1 delivery
> obligation here, so the two are recorded as **separate** open questions (`MM-GAP-010` and `MM-GAP-010a`) rather than
> one being treated as an instance of the other.

> **Why `BC-26` Analytics is not listed as a consumer, and why that follows the frozen precedent rather than
> departing from it.** BC Map **§9** names `BC-26` a consumer of `membership.MembershipCreated` (line 409),
> `MembershipRenewed` (410), `MembershipExpired` (412) and `MembershipFrozen`/`Unfrozen` (413). But BC Map **§7**
> declares **no `BC-02` → `BC-26` edge**: `BC-26`'s only inbound edge in the entire table is `E-26`, from `BC-27` AI
> (line 335). Line 292 states that an edge absent from §7 *"does not exist"* and that adding one **requires an ADR**.
>
> That is a **tension internal to the Bounded Context Map (Rank 4)**, not a decision this document may take. The
> frozen [Student Management PRD v1.2](../student-management/Student_Management_PRD_v1.md) §7.4 met the **identical**
> tension for `BC-01` — §9 names `BC-26` a consumer of `enrollment.StudentEnrolled` and `StudentProfileUpdated` while
> §7 declares no `BC-01` → `BC-26` edge — and resolved it by **not listing `BC-26` as a consumer**, emitting nothing
> additional for it, and recording `SM-GAP-11` for the architecture owner. `ADR-0018` then froze that document with
> that treatment intact.
>
> **This document follows that precedent exactly**: `BC-26` is **not** listed as a consumer, **no `BC-02` → `BC-26`
> edge is invented**, no ADR is created, the BC Map is not modified, and **nothing additional is emitted** for
> `BC-26`. The tension is recorded as **`MM-GAP-010`**, the sibling of `SM-GAP-11`, for the architecture owner.
>
> **This costs Analytics nothing.** `MM-BR-030` already requires that `BC-26` learn about membership **only** from
> the events in this section, and every one of them is published to the event bus regardless of which consumers this
> table enumerates. If and when the architecture owner resolves `MM-GAP-010` — by adding a `BC-02` → `BC-26` edge to
> §7 under an ADR, or by ruling that `E-20`-style *"All contexts"* fan-out covers projections — `BC-26` becomes a
> listed consumer with **no change to any event, payload or producer** in this document.

> **Why this register is complete at seven, and why that follows established practice rather than departing from it.**
> BC Map **§9** (*Published Language — Event Surface*, line 397) lists five rows for `BC-02`: `MembershipCreated`,
> `MembershipRenewed`, `MembershipExpiringSoon`, `MembershipExpired`, and `MembershipFrozen`/`Unfrozen`. This document
> registers seven, **adding** `MembershipActivated`, `MembershipUpgraded` and `MembershipVoided`, and **excluding**
> `Frozen`/`Unfrozen`.
>
> **The precedent is a frozen Rank 3 PRD, ratified at Rank 2.** BC Map §9 lists **four** `BC-01` events. The frozen
> [Student Management PRD v1.2](../student-management/Student_Management_PRD_v1.md) §7.4 declares a **closed set of
> ten**, adding six (`StudentArchived`, `StudentRestored`, `GuardianLinkChanged`, `StudentDocumentAttached`,
> `StudentDocumentRemoved`, `EnrollmentNumberAssigned`). Its §7.4 preamble cites §9 for the **naming convention**, not
> as an enumeration. Its independent review examined every event individually and questioned one as *redundant* — on
> design merit, never on the ground that adding an event required an ADR — and `ADR-0018` then froze the document with
> all six additions intact, without amending the BC Map. **A Rank 3 module PRD declaring its own complete event
> register is therefore established, ratified practice.** Three additions here is a smaller departure than the six
> already blessed.
>
> **§9 marks closure explicitly when it means it, and `BC-02` carries no such marker.** The only *"closed set"* in the
> entire BC Map is line 429, for `BC-10`, and it closes the register by **delegating it to that context's Rank 3
> PRD** — *"`SEV-1`…`SEV-16` — closed set, see Student Identity PRD §4.14"*. §9 also describes itself as the
> *"**seed** of the full Event Catalog"*, an artefact that does not yet exist (architecture README open action item
> #4). *"Names… are fixed here"* binds the **spelling** of the events it lists — `MembershipRenewed` may not be
> renamed — not the size of the set. **Closure of this register is therefore this document's own obligation, and is
> stated as an enforceable requirement in `MM-BR-035` rather than asserted in prose.**
>
> **No ADR trigger applies.** The BC Map states exactly one, at line 292, and it is scoped to **edges**: *"If an edge
> is not in this table, it **does not exist** and adding it requires an ADR."* That is §7, not §9, and it is why
> `ADR-0016` was needed for a missing edge consumer. These three events introduce **no new edge**: every **V1**
> consumer named in the table above is reachable on an edge this document already declares in `MM-BR-006` — `BC-05` on
> `E-07`, `BC-04` on `E-02`, `BC-03` on `E-03`, `BC-22` on `E-23` and `BC-24` on `E-20`. **`BC-26` is not among them
> and is therefore not listed as a consumer**; see `MM-BR-035` and `MM-GAP-010`. The single `(V2)`-annotated consumer,
> `BC-28` on `MM-EVT-006`, asserts **no V1 edge** — see the `(V2)` note above and `MM-BR-035`.
>
> **Each addition is sourced, not invented.** `MembershipUpgraded` is **already in the Map** — `E-07` (line 304) reads
> *"`MembershipCreated/Renewed/**Upgraded**/Frozen` → generates or adjusts `FeeDue`"*, so its absence from the §9
> table is an internal omission in Rank 4, the same defect class `ADR-0016` addressed. `MembershipActivated` is
> required because `E-10` (line 307) and §9 line 421 (*"**Activates membership**"*) treat activation as a distinct
> transition, and `MembershipCreated` cannot tell `BC-04`/`BC-03` when entitlement **begins** if status is
> `PendingPayment`. `MembershipVoided` is required by §5.4.
>
> **The `Frozen`/`Unfrozen` exclusion is correctness, not divergence.** Both serve Membership Freeze (**V2**, EA line
> 728), and §9 gives them the purpose *"Proration + seat hold"* with Proration also **V2** (EA line 731). A V1 PRD
> excluding a V2 capability's events is right; the inconsistency is that §9's *"V1 event surface"* table contains two
> V2-only rows.
>
> **Status of `MM-GAP-007`: closed.** Ratified 2026-08-04 — see
> [`PRD-005_BLOCKER_ANALYSIS.md`](PRD-005_BLOCKER_ANALYSIS.md) §3 and
> [`PRD-005_CORRECTION_REPORT.md`](PRD-005_CORRECTION_REPORT.md) §3. **No ADR is required and the BC Map is not
> modified.** Two observations are carried forward against the BC Map, not against this document (`MM-GAP-007a`,
> §25.2): `MembershipUpgraded` is at `E-07` but missing from §9, and §9's V1 table lists two V2-only events.

---

## 13. Data Requirements

### 13.1 `Membership` aggregate

`MM-BR-020` — `Membership` **MUST** be the aggregate root and the transaction boundary. One membership, one
transaction (BC Map §8).

**This table is normative.**

| Field | Purpose | Req. | Mutability | Owner | Validation | Scope |
|---|---|---|---|---|---|---|
| `membershipId` | Identity | Required | **Immutable** | `BC-02` | System-generated, non-enumerable | Global unique |
| `tenantId` | Tenant scope | Required | **Immutable** | `BC-19` | Must equal ambient `TenantContext` | Tenant key |
| `branchId` | Branch scope | Required | **Immutable** | `BC-06` | Must exist in tenant | Tenant-scoped |
| `studentRecordId` | The member | Required | **Immutable** | `BC-01` | Must exist, enrollment `Active` at creation | Tenant-scoped |
| `planId` | Plan reference | Required | **Immutable** | `BC-02` | Must exist, `isActive` at creation | Tenant-scoped |
| `planVersionAtPurchase` | Which plan revision applied | Required | **Immutable** | `BC-02` | Must match plan version | Tenant-scoped |
| `startDate` | Term start (date) | Required | **Immutable** after activation | `BC-02` | Within `MM-CFG-003`/`004` bounds | Tenant timezone |
| `endDate` | Term end (date, inclusive) | Required | **Immutable** after activation | `BC-02` | `>= startDate`, computed per §4.3 | Tenant timezone |
| `status` | Lifecycle state | Required | Mutable **only** via §5.2 | `BC-02` | Must be one of the six values | Tenant-scoped |
| `priceSnapshot` | Amount applicable | Required | **Immutable** | `BC-02` | `>= 0`, decimal, not float | Tenant-scoped |
| `currencySnapshot` | Currency of the snapshot | Required | **Immutable** | `BC-02` | ISO-4217 | Tenant-scoped |
| `seatQuotaSnapshot` | Seat allowance conferred | Optional | **Immutable** | `BC-02` | `>= 0` | Tenant-scoped |
| `createdAt` / `createdBy` | Creation metadata | Required | **Immutable** | `BC-02` | UTC; actor resolvable | Tenant-scoped |
| `activatedAt` / `activatedBy` | Activation metadata | Optional | Write-once | `BC-02` | Set only on activation | Tenant-scoped |
| `renewedFromMembershipId` | Renewal lineage | Optional | **Immutable** | `BC-02` | Must exist, same tenant + student | Tenant-scoped |
| `upgradedFromMembershipId` | Upgrade lineage | Optional | **Immutable** | `BC-02` | Must exist, same tenant + student | Tenant-scoped |
| `paymentReference` | Which payment activated it | Optional | Write-once | `BC-05` | Opaque; **not** an amount or ledger entry | Tenant-scoped |
| `idempotencyKey` | Duplicate suppression | Required | **Immutable** | `BC-02` | Unique per tenant per command type | Tenant-scoped |
| `version` | Optimistic concurrency | Required | Incremented | `BC-02` | Monotonic | Tenant-scoped |
| `voidReason` / `voidedBy` | Void record (§5.4) | Optional | Write-once | `BC-02` | Required when `Cancelled` | Tenant-scoped |

`MM-BR-021` — The aggregate **MUST NOT** contain any field owned by `BC-01`, `BC-10`, `BC-05`'s ledger, `BC-03` or
`BC-04` (`MM-FR-003`, `MM-XC-001`, `MM-XC-004`).

### 13.2 `MembershipPlan` aggregate

`MM-BR-022` — Fields are as specified in §2.2, with mutability governed by the normative table in §2.5. `planId`,
`tenantId`, `branchId` and `currency`-after-use are **immutable**; `version` is incremented on every edit.

### 13.3 Persistence rules

`MM-BR-023` — Every table **MUST** carry `tenantId` as part of its primary or unique key, per `X-13` (Dependency
Matrix, enforced by `ADR-0014`).

`MM-BR-024` — Membership records **MUST NOT** be hard-deleted. Terminal states are the retirement path.

`MM-BR-025` — No SQL, DDL or migration is specified in this document (§0.3).

### 13.4 Configurables — `MM-CFG-001` … `MM-CFG-009`

All **MUST** be read through `E-19` (`BC-25` Configuration) with typed accessors, never raw string lookups.

| ID | Configurable | Default | Notes |
|---|---|---|---|
| `MM-CFG-001` | Tenant default currency | `INR` | Master PRD targets India |
| `MM-CFG-002` | Max staleness of cached enrollment state | 5 s | Matches BC Map's < 5s bound |
| `MM-CFG-003` | Max back-dating of `startDate` (days) | 7 | Reception corrections |
| `MM-CFG-004` | Max forward-dating of `startDate` (days) | 90 | Advance sales |
| `MM-CFG-005` | Idempotency record retention | 30 days | ≥ any client retry window |
| `MM-CFG-006` | Tenant timezone | `Asia/Kolkata` | §4.4 |
| `MM-CFG-007` | `PendingPayment` auto-void window | 7 days | Prevents indefinite blocking of `MM-INV-001` |
| `MM-CFG-008` | Expiring-soon threshold (days) | 7 | Drives `MM-EVT-006` and the expiring view |
| `MM-CFG-009` | Re-derive the **whole term** from the activation date on delayed payment (`startDate` := activation date, `endDate` by the `MM-FR-057` formula) | `false` | §10.2, `MM-FR-057a` |

`MM-BR-026` — `MM-CFG-008` **MUST** be the single threshold used by both `MM-EVT-006` and the expiring-memberships
view, so the reminder and the list can never disagree.

> `PRD-004` `LMD-26` already requires its expiring-soon indicator's threshold to be configurable rather than
> hard-coded. Sharing one configurable keeps the Directory, the operational view and the notification consistent.

---

## 14. Business Rules & Invariants

### 14.1 Business rules

| ID | Rule |
|---|---|
| `MM-BR-027` | A membership **MUST** belong to exactly one tenant, and that tenant **MUST** equal the ambient `TenantContext` on every read and write |
| `MM-BR-028` | A membership **MUST** reference a `StudentRecordId` that exists in the same tenant with `EnrollmentStatus` `Active` at creation |
| `MM-BR-029` | An inactive, unavailable or wrong-tenant plan **MUST NOT** be selectable for create, renew or upgrade |
| `MM-BR-030` | *Restated from §9, which is the definition site.* This module **MUST NOT** own an analytics store, and `BC-26` **MUST** learn about membership only from the events in §12 |
| `MM-BR-031` | Membership validity **MUST** be unambiguous: exactly one answer from §4.5 for a given membership and date |
| `MM-BR-032` | An `Expired`, `PendingPayment`, `Scheduled`, `Superseded` or `Cancelled` membership **MUST NOT** be treated as active entitlement |
| `MM-BR-033` | Historical membership pricing **MUST NOT** change (`MM-FR-027`) |
| `MM-BR-034` | Renewal **MUST NOT** create overlapping or contradictory validity (§6.3, `MM-INV-001`) |

Additional rules recovered from the architecture rather than invented: `MM-BR-007` (the `E-02`/`E-03` asymmetry,
`MP-GBR-16`), `MM-BR-004` (the reconciliation queue, BC Map §10 line 465), `MM-BR-015` (no mobile number in events,
`MP-GBR-34`), `MM-BR-023` (`tenantId` in every key, `X-13`).

### 14.2 Invariants — enforced synchronously inside the aggregate

| ID | Invariant | Source |
|---|---|---|
| `MM-INV-001` | **No overlapping active terms for one `StudentRecordId`** | BC Map §8 `BC-02` row |
| `MM-INV-002` | `endDate >= startDate` | BC Map §8 (`validUntil > validFrom`; see `MM-GAP-008`) |
| `MM-INV-003` | `status` is always one of the six §5.1 values, reached only by a §5.2 transition | This document |
| `MM-INV-004` | A membership not satisfying §4.5 confers no entitlement | `MP-GBR-16` |
| `MM-INV-005` | A membership has at most one successor by renewal and at most one by upgrade | `MM-FR-090`, `MM-FR-101` |
| `MM-INV-006` | `priceSnapshot`, `currencySnapshot`, `planVersionAtPurchase` never change | `MM-FR-027` |
| `MM-INV-007` | `tenantId` never changes and always matches the ambient context | `X-13`, `ADR-0003` |
| `MM-INV-008` | A duplicate command with an identical `idempotencyKey` produces no second membership | `MM-FR-047` |
| `MM-INV-009` | `Expired`, `Superseded` and `Cancelled` are terminal | `MM-FR-075` |
| `MM-INV-010` | A membership references exactly one plan and never zero | §13.1 |
| `MM-INV-011` | `activatedAt` is set if and only if the membership has ever been `Active` | §4.1 |
| `MM-INV-012` | `Frozen` is unreachable in V1 | `MM-XC-009` |

Restatement for locality (no new obligation): invariants `MM-INV-001` and `MM-INV-008` are enforced by database
constraints rather than application checks. The governing requirement is `MM-FR-046`, defined in §3.4.

---

## 15. Concurrency & Idempotency

**This table is normative.** Each row states the required deterministic outcome.

| Scenario | Required outcome |
|---|---|
| Two reception staff create a membership for the same student simultaneously | Exactly **one** succeeds. The other fails with a typed overlap error naming the winning `membershipId`. Enforced by the `MM-INV-001` constraint, not by a read-check |
| Same, but with an identical `idempotencyKey` (one client, retried) | Exactly one membership; the second call returns the **original** result with no new event |
| User double-taps **Renew** | One renewal. The second call is suppressed by `idempotencyKey`, or fails with `MM-FR-090` naming the existing successor |
| Duplicate payment callback | Activation is idempotent on `paymentReference`. No second activation, no second `MM-EVT-002` |
| Two simultaneous renewal requests, different keys | One succeeds; the other fails with `MM-FR-090`. **Never** two successors |
| Two simultaneous upgrade requests | One succeeds and sets the source `Superseded`; the other fails because the source is no longer `Active` (`MM-FR-093`) |
| Simultaneous renewal **and** upgrade of the same source | Serialised by the source's `version`. The loser fails on a stale-version conflict. Both **MUST NOT** commit |
| Plan becomes inactive mid-operation | The plan's `isActive` **MUST** be re-checked inside the committing transaction. If deactivated, the operation fails with a typed error. A plan deactivated after commit **MUST NOT** affect the committed membership (`MM-FR-019`) |
| Plan price changes mid-operation | The snapshot **MUST** be taken inside the committing transaction together with `planVersionAtPurchase`, so the amount and the version agree |
| Membership expires while a renewal is being processed | The renewal **MUST** still succeed. Eligibility permits `Active` **or** `Expired` (`MM-FR-080`), and the new `startDate` is recomputed by §6.3's after-expiry case. A mid-flight expiry **MUST NOT** turn a valid renewal into an error |
| Expiry job runs concurrently with an upgrade | Serialised by `version`. If expiry wins, the upgrade fails `MM-FR-093`; if the upgrade wins, the source becomes `Superseded` and the expiry job **MUST NOT** overwrite it |
| Network retry after an unknown outcome | `idempotencyKey` makes the retry safe and returns the original result. Clients **MUST NOT** need to query to decide whether to retry |

`MM-NFR-001` — Optimistic concurrency via `version` **MUST** be used for all membership mutations; the overlap and
idempotency constraints **MUST** additionally be enforced at the database level.

---

## 16. Security & Multi-Tenancy

### 16.1 Tenant and library isolation

`MM-NFR-002` — Every query and mutation **MUST** be filtered by the ambient `TenantContext` (`E-18`). `tenantId`
**MUST NOT** be accepted as a domain-method parameter.

`MM-NFR-003` — Cross-tenant access **MUST** be impossible, not merely denied: the tenant predicate **MUST** be applied
at the data-access layer so that omitting it is a compile-or-check-time failure, per `X-13` as enforced by `ADR-0014`.

`MM-NFR-004` — A membership **MUST** be scoped to a `branchId` and branch-level read filtering **MUST** be supported,
even though multi-branch is V3 (`MP-CON-13`).

`MM-NFR-005` — An identifier from another tenant **MUST** produce a *not found*, never a *forbidden*, so that
existence cannot be probed across tenants.

### 16.2 Authorisation model — consumed, not defined

`MM-NFR-006` — This module **MUST NOT** define roles, permissions or an authorisation model (`MM-XC-016`). It **MUST**
consume `BC-18`'s decisions (`AR-2`, `AR-6`: authentication and authorisation are separate stages).

`MM-NFR-007` — Every protected operation **MUST** be authorised **before** any state is read or mutated, and least
privilege **MUST** apply: the ability to view memberships **MUST NOT** imply the ability to create, renew, upgrade,
void or edit a plan.

### 16.3 Protected operations — `MM-PO-001` … `MM-PO-011`, closed list

| ID | Operation | Notes |
|---|---|---|
| `MM-PO-001` | Create membership plan | Owner/Manager class |
| `MM-PO-002` | Edit / activate / deactivate plan | Owner/Manager class |
| `MM-PO-003` | Create membership | Reception class and above |
| `MM-PO-004` | **Manually activate** a `PendingPayment` membership | Elevated — bypasses the payment gate; **MUST** require a reason and **MUST** be audited |
| `MM-PO-005` | Void a pre-activation membership | Elevated; reason required |
| `MM-PO-006` | Renew membership | Reception class and above |
| `MM-PO-007` | Upgrade membership | Reception class and above |
| `MM-PO-008` | View membership detail | Includes price snapshot |
| `MM-PO-009` | List operational membership views | §8 *(this document)* |
| `MM-PO-010` | Query validity for a student | Also used machine-to-machine by `BC-03`/`BC-04` |
| `MM-PO-011` | Change a membership configurable (`MM-CFG-*`) | Owner class; `BC-25` performs the write |

`MM-NFR-008` — `MM-PO-004` **MUST** be separately grantable from `MM-PO-003`. A user who can create a membership
**MUST NOT** implicitly be able to activate one without payment.

> Without this separation, the payment gate is decorative: any reception user could create and then immediately
> activate, conferring entitlement with no money. That is the revenue-leakage failure `Q-03` is concerned with, in a
> different guise.

### 16.4 Data minimisation and auditability

`MM-NFR-009` — This module **MUST** store no PII (`MM-FR-003`). Its sensitive data is commercial — price snapshots and
entitlement — not personal.

`MM-NFR-010` — A student-facing view **MUST** expose only that student's own memberships, and **MUST NOT** expose
another student's membership, any `StaffOnly` plan, or any internal reconciliation state.

### 16.5 Non-functional requirements

| ID | Requirement |
|---|---|
| `MM-NFR-011` | A validity check **MUST** complete fast enough to sit in the seat-assignment and check-in paths without becoming their bottleneck; the projection exists for this reason |
| `MM-NFR-012` | Validity **MUST** remain correct when the expiry job has not run (`MM-FR-107`) — the read rule is authoritative |
| `MM-NFR-013` | Every failure surfaced to a user **MUST** be a typed domain error naming the offending field or state; a generic failure is a defect (`MM-FR-032`) |
| `MM-NFR-014` | Every rule in this document **MUST** be falsifiable by a test. Per `SID-4.56`, a rule that cannot be checked is **unmet**, not satisfied by intent |

---

## 17. Audit

Audit **MUST** be emitted as events through `E-20` (`BC-24`), fire-and-forget and outbox-backed. This module
**MUST NOT** call audit synchronously and **MUST NOT** store an audit log (`MP-GBR-13`: the trail is
*"append-only with no update or delete path in code"*). This is the audit-transport consequence of `MM-BR-023`
(§16.1) and `MM-XC-004`; it introduces no identifier of its own.

**Mutations requiring audit — normative.**

| Mutation | Audited | Must record |
|---|---|---|
| Plan create | **Yes** | Actor, timestamp, all field values |
| Plan edit | **Yes** | Actor, timestamp, **before/after of changed fields**, new `version` |
| Plan activate / deactivate | **Yes** | Actor, timestamp, previous state |
| Membership create | **Yes** | Actor, `studentRecordId`, `planId`, term, `priceSnapshot`, initial status, `idempotencyKey` |
| Membership activation (event-driven) | **Yes** | `paymentReference`, activating event id, resulting term |
| Membership activation (`MM-PO-004`, manual) | **Yes — elevated** | Actor, **reason**, and the fact that the payment gate was bypassed |
| Renewal | **Yes** | Actor, source and new `membershipId`, both terms, new snapshot |
| Upgrade | **Yes** | Actor, `fromPlanId`, `toPlanId`, `priceDifference`, `remainingDaysOnSource` |
| Void (§5.4) | **Yes** | Actor, **reason**, prior status |
| Expiry (job) | **Yes** | System actor, `expiredOn` — the actor **MUST NOT** be recorded as a human |
| Configurable change | **Yes** | Delegated to `BC-25`; this module records the consuming decision only |
| Read of a membership | **No** | Access logging is a platform concern, not a domain mutation |

Restatement for locality (no new obligation): audit records carry no mobile number, name or other `BC-10` field. The
governing rules are `MP-GBR-34` (Rank 1) and `MM-BR-015`, defined in §12.

---

## 18. Notification Integration

This module emits **facts**; `BC-22` owns delivery over SMS, push, email and in-app
(`MP-GBR-33`: *"The domain emits facts (`membership.MembershipExpiringSoon`), never instructions ('send an SMS')"*).
The governing rule is `MM-BR-019`, defined in §12; it is restated below for locality, not redefined.

| Fact emitted | Event | Notification purpose (owned by `BC-22`) |
|---|---|---|
| Membership expiring | `MM-EVT-006` | Renewal reminder |
| Membership expired | `MM-EVT-005` | Lapse notice |
| Membership renewed | `MM-EVT-003` | Confirmation |
| Membership activated | `MM-EVT-002` | Welcome / entitlement begins |
| Membership upgraded | `MM-EVT-004` | Confirmation |

Consequently (`MM-BR-019`), this module **MUST NOT** select a channel, compose a message body, hold a template,
schedule a send, or track a delivery receipt.

> EA line 855 lists *Membership Expiry Reminder* as **V2** in its notification module. That concerns the **reminder
> feature** in `BC-22`, not the **fact**: `MM-EVT-006` is in BC Map §9's V1 `BC-02` event list, so emitting it in V1 is
> correct even if the notification that consumes it ships later. Emitting a fact no one yet consumes is harmless;
> retrofitting the emitter later is not.

---

## 19. API Requirements — conceptual only

The following capabilities **MUST** exist, each realising the requirement cited in its own row — this list introduces
no identifier of its own. **No URLs, verbs, payload schemas or status codes are specified**, per the authoring
instruction and because this repository has no API standard document to conform to.

| Capability | Notes |
|---|---|
| Create plan | `MM-PO-001` |
| Update plan (incl. activate/deactivate) | `MM-PO-002`, subject to §2.5 |
| List / view plans | `MM-PO-009`; `StaffOnly` filtered by audience |
| Create membership | `MM-PO-003`; requires `idempotencyKey` |
| View membership detail | `MM-PO-008` |
| **Check membership validity** | `MM-PO-010`; the §4.5 rule; also the `E-02`/`E-03` projection |
| Renew membership | `MM-PO-006`; requires `idempotencyKey` |
| Upgrade membership | `MM-PO-007`; requires `idempotencyKey` |
| List operational memberships | `MM-PO-009`; §8 views |
| Void pre-activation membership | `MM-PO-005`; reason required |
| Manually activate | `MM-PO-004`; elevated, reason required |

Restatement for locality (no new obligation): every mutating capability accepts an `idempotencyKey` and returns a
typed error on rejection. The governing requirements are `MM-FR-047` (§3.4) and `MM-NFR-013` (§16.5).

---

## 20. UI/UX Functional Requirements

No mockups are provided. These are functional requirements only.

| Surface | Requirement |
|---|---|
| Plan list | **MUST** show name, duration in days, price with currency, availability and active state; **MUST** allow filtering by active state |
| Create / edit plan | **MUST** disable or clearly mark fields that are immutable after use (§2.5) and **MUST** explain why rather than failing silently on submit |
| Membership creation flow | **MUST** require an explicit student selection and plan selection; **MUST** display the computed `endDate` **before** submission; **MUST** show the amount applicable |
| Payment step | **MUST** present creation and payment as an explicit two-stage flow — BC Map §10 line 465: *"deliberately not hidden behind a fake atomic button"* |
| Membership detail | **MUST** show term, status, plan, price snapshot, and renewal/upgrade lineage |
| Membership status | **MUST** display `MembershipStatus` and `EnrollmentStatus` as **separate** fields, never merged (`MM-FR-076`) |
| Validity | **MUST** present validity as the module's answer (`isValid` + status), **MUST NOT** re-derive it in the client from dates (`MM-FR-066`) |
| Renewal flow | **MUST** show the computed new term **before** confirmation, including which §6.3 case applies |
| Upgrade flow | **MUST** show current plan, target plan, price difference and remaining days on the source before confirmation |
| Expiring / expired lists | **MUST** be available, filterable by plan and date range, and paginated |
| Reconciliation queue | **MUST** be visible to authorised staff (`MM-BR-004`) |
| Validation / error states | **MUST** surface the typed error's field and reason; **MUST NOT** show a generic failure |
| `PendingPayment` presentation | **MUST** make clear that the membership confers **no** entitlement yet |

---

## 21. Edge Cases — specified, not discovered later

| # | Case | Required behaviour |
|---|---|---|
| 1 | Student/member does not exist | Typed *not found*; nothing created |
| 2 | Student exists but is `Inactive`/`Suspended`/`Archived` | Rejected, naming the enrollment state (`MM-FR-035`) |
| 3 | Plan is inactive | Rejected (`MM-FR-020`), re-checked in-transaction (§15) |
| 4 | Plan price changes after membership creation | Existing membership unaffected; snapshot governs (`MM-FR-027`) |
| 5 | Plan `currency` change attempted after use | Rejected as immutable (`MM-FR-024`) |
| 6 | Renewal before expiry | New term starts `endDate + 1`; no overlap (§6.3) |
| 7 | Renewal exactly at expiry (`today == endDate`) | Same as case 6 — source valid for all of `endDate` (`MM-FR-062`) |
| 8 | Renewal after expiry | New term starts **today**, not `endDate + 1` (§6.3) |
| 9 | Duplicate renewal | Suppressed by `idempotencyKey`, or rejected naming the existing successor |
| 10 | Upgrade immediately after creation, still `PendingPayment` | Rejected; correct path is void-and-recreate (`MM-FR-102`) |
| 11 | Upgrade near expiry | Permitted while `Active`; new term starts today, source `Superseded`, remaining days published not refunded (`MM-FR-099`) |
| 12 | Payment failure | Stays `PendingPayment`, confers nothing, correctable |
| 13 | Payment timeout / delayed confirmation | Stays `PendingPayment`; activates on arrival; `MM-CFG-009` governs whether the whole term is re-derived per `MM-FR-057a`, never `endDate` alone |
| 14 | Duplicate payment callback | Idempotent on `paymentReference`; no second activation |
| 15 | Concurrent renewal | One succeeds; never two successors (§15) |
| 16 | Concurrent upgrade | One succeeds; the other fails on source status (§15) |
| 17 | Tenant or library inactive | All mutations rejected; `E-18`/`tenancy.TenantSuspended` gates |
| 18 | Month-end dates (31 Jan + 30 days) | Pure day arithmetic; no "same day next month" rule exists (`MM-FR-059`) |
| 19 | Leap year (29 Feb) | Day arithmetic crosses it without special handling; a term may legitimately include 29 Feb |
| 20 | Timezone boundary — creation at 23:55 local | Business date resolved in the **tenant** timezone (`MM-FR-061`), never the server's |
| 21 | Tenant timezone reconfigured | Existing terms unchanged (`MM-FR-064`) |
| 22 | Network retry, unknown outcome | `idempotencyKey` returns the original result (§15) |
| 23 | Partial failure — membership committed, event not published | Outbox retries; membership stands; event not dropped (`MM-FR-051`) |
| 24 | Partial failure — payment captured, membership write failed | Payment stands; reconciliation queue; no silent activation (§10.2) |
| 25 | Payment arrives for a voided membership | Activation refused; surfaced for a `BC-05` refund decision (§10.2) |
| 26 | `PendingPayment` never paid | Auto-voided after `MM-CFG-007` so it cannot block `MM-INV-001` forever |
| 27 | Student suspended mid-term | Membership record untouched; projection reports `isValid: false` (`MM-FR-077`) |
| 28 | Expiry job down for a day | Reads still report `isValid: false` correctly; events emitted once when it resumes (`MM-FR-107`) |
| 29 | Single-day plan (`durationDays: 1`) | `endDate == startDate`; **blocked by `MM-GAP-008`** until the `>` vs `>=` reading is settled |
| 30 | Plan `seatQuota` reduced while a student is seated | Existing membership's published quota unchanged until renewal (`MM-FR-025`) |

---

## 22. V2 / V3 / Future — explicitly out of V1

Sourced from EA lines 722–735, not invented here.

| Capability | Version | Exclusion |
|---|---|---|
| Membership Downgrade | **V2** | `MM-XC-008` |
| Membership Freeze / Unfreeze | **V2** | `MM-XC-009` |
| Membership Transfer | **V2** | `MM-XC-010` |
| Membership Cancellation (with refund) | **V2** | `MM-XC-011` |
| Proration Rules | **V2** | `MM-XC-012` |
| Membership History (as a feature surface) | **V2** | Lineage fields exist; the *feature* is V2 |
| Auto Renewal | **V3** | `MM-XC-007` |
| Membership Analytics | **V3** per EA line 734 (**V2** per lines 837/1607 — see §25.1) | `MM-XC-006` |
| Cross-Library Membership | **Future** | `MM-XC-013` |
| Saga-based renewal with compensation | **V2** (`BC-28`) | V1 uses the two-stage flow + reconciliation queue |

---

## 23. Acceptance Criteria — `MM-AC-001` … `MM-AC-094` (97 criteria)

Every criterion is deterministic and testable.

| ID | Criterion | Verifies |
|---|---|---|
| `MM-AC-001` | Creating a plan with `durationDays` 0 or negative is rejected naming the field | `MM-FR-031` |
| `MM-AC-002` | Creating a plan with a duplicate name in the same tenant/branch is rejected | `MM-FR-010` |
| `MM-AC-003` | Creating a plan with a negative price is rejected | `MM-FR-031` |
| `MM-AC-004` | A plan's `currency` cannot be changed once a membership references it | `MM-FR-024` |
| `MM-AC-005` | Editing a plan's `price` leaves every existing membership's `priceSnapshot` byte-identical | `MM-FR-023`, `MM-FR-027` |
| `MM-AC-006` | Editing a plan's `durationDays` leaves every existing membership's `endDate` unchanged | `MM-FR-023` |
| `MM-AC-007` | Deactivating a plan changes no existing membership's status or term | `MM-FR-019` |
| `MM-AC-008` | A deactivated plan cannot be selected for create, renew or upgrade | `MM-FR-020` |
| `MM-AC-009` | A plan with referencing memberships cannot be hard-deleted; deactivation is offered | `MM-FR-021` |
| `MM-AC-010` | Every plan edit increments `version` and produces an audit entry with before/after | `MM-FR-022`, §17 |
| `MM-AC-011` | Reducing a plan's `seatQuota` does not change the quota published for an active membership | `MM-FR-025` |
| `MM-AC-012` | A `StaffOnly` plan never appears in a student-facing list | `MM-FR-015` |
| `MM-AC-013` | Plan search matches case-insensitively on name within the tenant only | `MM-FR-030` |
| `MM-AC-014` | Creating a membership for a non-existent student returns *not found* and creates nothing | Edge 1 |
| `MM-AC-015` | Creating a membership for a `Suspended` student is rejected naming the enrollment state | `MM-FR-035` |
| `MM-AC-016` | `endDate` equals `startDate + durationDays − 1` for a 30-day plan starting 1 Jan → 30 Jan | `MM-FR-057` |
| `MM-AC-017` | A 30-day plan starting 31 Jan yields 1 Mar in a non-leap year by day arithmetic | Edge 18 |
| `MM-AC-018` | A term spanning 29 Feb in a leap year includes it and needs no special case | Edge 19 |
| `MM-AC-019` | `endDate` is never supplied by the caller; a supplied value is ignored or rejected | `MM-FR-039` |
| `MM-AC-020` | A membership requiring payment is created as `PendingPayment` | `MM-FR-041` |
| `MM-AC-021` | A `PendingPayment` membership reports `isValid: false` | `MM-FR-042`, `MM-FR-068` |
| `MM-AC-022` | A zero-price membership starting today is created `Active` | `MM-FR-041` |
| `MM-AC-023` | A membership with a future `startDate` is `Scheduled` and confers nothing until that date | `MM-FR-053` |
| `MM-AC-024` | `fee.FeePaymentReceived` transitions `PendingPayment` → `Active`/`Scheduled` and emits `MM-EVT-002` | `MM-FR-043`, `MM-EVT-002`, `E-10` |
| `MM-AC-025` | A duplicate `fee.FeePaymentReceived` produces no second activation and no second event | Edge 14 |
| `MM-AC-026` | Manual activation requires `MM-PO-004`, a reason, and is audited as bypassing the payment gate | `MM-FR-043`, `MM-PO-004`, §17 |
| `MM-AC-027` | A user holding `MM-PO-003` but not `MM-PO-004` cannot activate without payment | `MM-NFR-008`, `MM-PO-003`, `MM-PO-004` |
| `MM-AC-028` | Two concurrent creates for one student yield exactly one membership; the loser gets a typed overlap error | §15, `MM-INV-001` |
| `MM-AC-029` | A repeated create with the same `idempotencyKey` returns the original `membershipId` and emits no second event | `MM-FR-047` |
| `MM-AC-030` | An overlapping create is rejected naming the conflicting membership, not silently returning it | `MM-FR-049` |
| `MM-AC-031` | Overlap is rejected even when the two writes race, proving a DB constraint rather than a read-check | `MM-FR-046` |
| `MM-AC-032` | Renewal before expiry sets the new `startDate` to `endDate + 1` | §6.3 |
| `MM-AC-033` | Renewal on the expiry date (`today == endDate`) also sets `endDate + 1` | §6.3 case 2 |
| `MM-AC-034` | Renewal after expiry sets the new `startDate` to today, not `endDate + 1` | §6.3 case 3 |
| `MM-AC-035` | Renewal creates a **new** `membershipId` and leaves the source's term unmodified | `MM-FR-084` |
| `MM-AC-036` | Renewal snapshots the plan's **current** price, not the source's snapshot | `MM-FR-088` |
| `MM-AC-037` | A second renewal of the same source is rejected naming the existing successor | `MM-FR-090` |
| `MM-AC-038` | Renewal from `PendingPayment` or `Scheduled` is rejected | `MM-FR-082` |
| `MM-AC-039` | A membership that expires mid-renewal still renews, using the after-expiry rule | §15 |
| `MM-AC-040` | Renewal emits exactly one `MM-EVT-003` | `MM-FR-091`, `MM-EVT-003` |
| `MM-AC-041` | With the expiry job stopped, a membership past `endDate` still reports `isValid: false` | `MM-FR-107`, `MM-NFR-012` |
| `MM-AC-042` | The expiry job emits `MM-EVT-005` exactly once per membership and is safe to re-run | `MM-FR-105`, `MM-FR-106`, `MM-EVT-005` |
| `MM-AC-043` | `MM-EVT-006` fires once per membership per threshold crossing at `MM-CFG-008` | `MM-FR-108`, `MM-EVT-006` |
| `MM-AC-044` | No entitlement is granted after `endDate`; there is no grace path in V1 | `MM-FR-111`, `MM-INV-004` |
| `MM-AC-045` | Expiry does not alter `EnrollmentStatus` and does not delete the membership | `MM-FR-070` |
| `MM-AC-046` | Upgrade from `Expired` is rejected | `MM-FR-093` |
| `MM-AC-047` | Upgrade targets exclude plans priced at or below the source snapshot | `MM-FR-094`, `MM-FR-095` |
| `MM-AC-048` | Upgrade sets the source to `Superseded` and leaves its `endDate` unchanged | `MM-FR-096`, `MM-FR-098` |
| `MM-AC-049` | `MM-EVT-004` carries `priceDifference` and `remainingDaysOnSource`, and **no** monetary credit or refund | `MM-FR-099`, `MM-FR-100`, `MM-EVT-004` |
| `MM-AC-050` | Two concurrent upgrades of one source yield exactly one `Superseded` transition | §15 |
| `MM-AC-051` | A cross-tenant `membershipId` returns *not found*, never *forbidden* | `MM-NFR-005` |
| `MM-AC-052` | No query path can return a membership from another tenant, including every §8 view *(of this document)* | `MM-NFR-002`, `MM-NFR-003` |
| `MM-AC-053` | No `MM-EVT-*` payload contains a mobile number, name, email or any `BC-10` field | `MM-BR-015` |
| `MM-AC-054` | Every §17 mutation produces an audit event; a read produces none | §17 |
| `MM-AC-055` | The plan-wise view returns a current-state count only, with no period comparison or rate | `MM-FR-117`, `MM-XC-006` |
| `MM-AC-056` | A student suspension flips `isValid` to false without changing `MembershipStatus` | `MM-FR-077` |
| `MM-AC-057` | A `PendingPayment` membership is auto-voided after `MM-CFG-007` and stops blocking new creation | Edge 26 |
| `MM-AC-058` | `MembershipStatus` and `EnrollmentStatus` are returned as separate fields on every surface that shows both | `MM-FR-076`, `PRD-004` `SM-2.7` |

### 23.1 Boundary, invariant and exclusion criteria — `MM-AC-059` … `MM-AC-094` (39 criteria)

Added at v1.2 to close the verification gap recorded as **F-4**. Each criterion verifies a rule that previously had
**no** verifying criterion, so that `MM-NFR-014` (*"a rule that cannot be checked is **unmet**"*) holds for the
invariant, exclusion, protected-operation and event registers in full, and for **31 of the 35** business rules —
`MM-BR-012`, `MM-BR-022`, `MM-BR-027` and `MM-BR-028` remain **uncovered** under the strict counting rule of §0.2 and
are named as such in the note below, in §0.2 and in §25.3. **No new obligation is created here** — every criterion
below tests text that already exists. Three criteria carry a
letter suffix (`MM-AC-074a`, `MM-AC-076a`, `MM-AC-080a`) because they were added by the post-edit audit after the
block had been numbered; the suffix convention is the one documented in §0.2.

| ID | Criterion | Verifies |
|---|---|---|
| `MM-AC-059` | No schema in this module contains a monetary ledger, balance, receipt or refund table | `MM-BR-001`, `MM-XC-004` |
| `MM-AC-060` | No code path in this module calls a payment gateway, and no gateway credential is readable by it | `MM-BR-002`, `MM-XC-003` |
| `MM-AC-061` | The only inbound payment signal handled is `fee.FeePaymentReceived` on `E-10`; no polling loop exists | `MM-BR-002` |
| `MM-AC-062` | This module creates no `FeeDue`; `MM-EVT-001`/`003`/`004` are emitted and `BC-05` raises the due | `MM-BR-003`, `MM-EVT-001` |
| `MM-AC-063` | A membership whose payment succeeded but whose update failed appears in the reconciliation queue and is not silently activated | `MM-BR-004` |
| `MM-AC-064` | Activation is idempotent on `paymentReference`: a replayed callback yields no second activation | `MM-BR-005` |
| `MM-AC-065` | Only the ten edges listed in `MM-BR-006` are used; no call leaves this module on any other edge | `MM-BR-006` |
| `MM-AC-066` | An invalid membership causes Seating to **reject** assignment and Attendance to **record and flag**, not block | `MM-BR-007`, `MM-FR-060` |
| `MM-AC-067` | No `BC-06` Library Policy call and no `BC-23` Search Indexing write originates in this module | `MM-BR-008`, `MM-BR-009` |
| `MM-AC-068` | No write from this module targets a `BC-01`, `BC-03`, `BC-04` or `BC-05` table | `MM-BR-010`, `MM-XC-002` |
| `MM-AC-069` | The Library Member Directory receives plan, membership status and term from this module, not from `BC-01` | `MM-BR-011` |
| `MM-AC-070` | With the `E-01` stream unavailable, membership creation **fails closed** rather than assuming an active enrollment | `MM-BR-013` |
| `MM-AC-071` | Every `MM-EVT-*` name matches `<Context>.<Aggregate><PastTenseVerb>`; no imperative name is publishable | `MM-BR-014` |
| `MM-AC-072` | Every `MM-EVT-*` payload carries `tenantId`, `membershipId`, `studentRecordId`, `occurredAt`, `eventId` and `sequence` | `MM-BR-016` |
| `MM-AC-073` | Re-delivering an event with a seen `eventId` produces no duplicate consumer effect; delivery is outbox-backed | `MM-BR-017` |
| `MM-AC-074` | Events for one `membershipId` are ordered by `sequence`; no consumer relies on cross-membership ordering | `MM-BR-018` |
| `MM-AC-074a` | No notification is sent and no analytic metric is computed inside this module; both are reached only as event consumers | `MM-BR-019`, `MM-XC-005`, `MM-XC-006` |
| `MM-AC-075` | The event register contains exactly **seven** `MM-EVT-*` entries; every consumer named **without** a `(V2)` annotation resolves to an edge declared in `MM-BR-006`; and no V1 code path delivers to, or depends on, a `(V2)`-annotated consumer | `MM-BR-035` |
| `MM-AC-076` | `BC-26` is not named a consumer of any `MM-EVT-*`, and no `BC-02` → `BC-26` call exists | `MM-BR-035`, `MM-BR-030` |
| `MM-AC-076a` | Voiding a pre-activation membership emits exactly one `MM-EVT-007` carrying `reason` and `voidedBy`, and no void path exists for an `Active` membership | `MM-EVT-007`, `MM-FR-078`, `MM-FR-079` |
| `MM-AC-077` | One membership is one transaction: no command mutates two memberships atomically | `MM-BR-020`, `MM-INV-010` |
| `MM-AC-078` | The `Membership` aggregate contains no field owned by `BC-01`, `BC-10`, `BC-05`'s ledger, `BC-03` or `BC-04` | `MM-BR-021`, `MM-XC-001` |
| `MM-AC-079` | Every membership and plan table carries `tenantId` in its primary or unique key | `MM-BR-023`, `MM-INV-007` |
| `MM-AC-080` | No hard-delete path exists for a membership record; terminal states are the only retirement | `MM-BR-024` |
| `MM-AC-080a` | A duplicate command carrying an `idempotencyKey` already seen for that tenant and command type creates no second membership, proven under a write race | `MM-INV-008`, `MM-FR-046` |
| `MM-AC-081` | `MM-EVT-006` and the expiring-memberships view read the **same** `MM-CFG-008` value and cannot disagree | `MM-BR-026`, `MM-CFG-008`, `MM-EVT-006` |
| `MM-AC-082` | Every `MM-CFG-*` is read through a typed `BC-25` accessor; no raw string config lookup exists | `MM-BR-025`, `MM-CFG-001` |
| `MM-AC-083` | Creating a membership against a plan from another tenant or an inactive plan is rejected | `MM-BR-029`, `MM-INV-010` |
| `MM-AC-084` | §4.5 yields exactly **one** validity answer for a given membership and date | `MM-BR-031`, `MM-INV-004` |
| `MM-AC-085` | `Expired`, `PendingPayment`, `Scheduled`, `Superseded` and `Cancelled` each confer no entitlement | `MM-BR-032`, `MM-INV-009` |
| `MM-AC-086` | No command changes `priceSnapshot`, `currencySnapshot` or `planVersionAtPurchase` after creation | `MM-BR-033`, `MM-INV-006`, `MM-XC-015` |
| `MM-AC-087` | A renewal never produces overlapping terms for one `StudentRecordId` | `MM-BR-034`, `MM-INV-001` |
| `MM-AC-088` | A single-day plan (`durationDays: 1`) yields `endDate == startDate`, never a value below `startDate` and never a silently mis-computed term | `MM-INV-002`, `MM-FR-056` |
| `MM-AC-089` | Every status value is one of the six in §5.1 and is reachable only by a §5.2 transition | `MM-INV-003` |
| `MM-AC-090` | A membership has at most one renewal successor and at most one upgrade successor | `MM-INV-005` |
| `MM-AC-091` | `activatedAt` is set if and only if the membership has ever been `Active` | `MM-INV-011` |
| `MM-AC-092` | No V1 command can produce `Frozen`, and no freeze, downgrade, transfer, cancellation-with-refund or auto-renewal path exists | `MM-INV-012`, `MM-XC-007`, `MM-XC-008`, `MM-XC-009`, `MM-XC-010`, `MM-XC-011`, `MM-XC-012` |
| `MM-AC-093` | Each of `MM-PO-001`, `MM-PO-002`, `MM-PO-005`…`MM-PO-011` is refused when the caller lacks it, and authorised **before** any state is read or mutated | `MM-NFR-007`, `MM-PO-001`, `MM-PO-002`, `MM-PO-005`, `MM-PO-006`, `MM-PO-007`, `MM-PO-008`, `MM-PO-009`, `MM-PO-010`, `MM-PO-011` |
| `MM-AC-094` | No role, permission or authorisation model is defined in this module; no cross-tenant or cross-library membership is representable; no SMS/push/email is sent and no analytic metric is computed | `MM-NFR-006`, `MM-XC-016`, `MM-XC-005`, `MM-XC-006`, `MM-XC-013`, `MM-XC-014` |

> **On honesty of coverage.** These 39 criteria were derived by listing, mechanically, every `MM-BR-*`, `MM-INV-*`,
> `MM-XC-*`, `MM-PO-*` and `MM-EVT-*` with no verifying criterion, and then writing a criterion **only** where the
> existing rule text is already falsifiable.
>
> **The measurement rule is the strict one defined in §0.2**: an obligation is verified **only** if its identifier
> appears in the *Verifies* column of an `MM-AC-*` row. Measured under that rule, the result is **77 of 81 (95.1%)**
> in those five registers and **134 of 223 (60.1%)** across every criterion-verifiable obligation.
>
> **Why these figures are lower than the ones v1.2 published, and why the lower ones are the true ones.** v1.2 declared
> **81/81 (100.0%)** and **140/223 (62.8%)**. Those figures were produced by a script that scanned each §23 block as a
> whole — including the surrounding prose — rather than the *Verifies* column alone. The third independent review
> ([`PRD-005_THIRD_INDEPENDENT_REVIEW.md`](PRD-005_THIRD_INDEPENDENT_REVIEW.md), finding `TR-2`) reproduced the
> arithmetic and showed that the 100% figure depended on **this very paragraph**: the sentence naming `MM-BR-012`,
> `MM-BR-022`, `MM-BR-027` and `MM-BR-028` as *not* separately covered was itself being counted as evidence that they
> *were* covered. A metric that rises when you write prose about a gap is not measuring verification, so the counting
> rule was tightened rather than the number defended. **v1.3 corrects the claim, not the coverage** — no criterion was
> deleted and none was weakened.
>
> **`TR-4` moved eight identifiers into the column where they belonged, without inventing a single criterion.**
> `MM-EVT-001`…`MM-EVT-006`, `MM-PO-003` and `MM-PO-004` were each already tested by an existing criterion whose text
> named them but whose *Verifies* cell did not: `MM-AC-062`, `MM-AC-024`, `MM-AC-040`, `MM-AC-049`, `MM-AC-042`,
> `MM-AC-043`/`MM-AC-081`, `MM-AC-027` and `MM-AC-026`/`MM-AC-027` respectively. Adding the register IDs to those cells
> raised the strict measure from **69/81** to **77/81** — a traceability repair, not new coverage.
>
> **The four remaining gaps are stated, not argued away.** `MM-BR-012`, `MM-BR-022`, `MM-BR-027` and `MM-BR-028` are
> restatements whose substance is exercised at their definition sites by `MM-AC-051`/`052`, `MM-AC-004`…`011` and
> `MM-AC-015`. That is a reason the residual risk is low; it is **not** a claim that they are verified, and they are
> counted as **uncovered** in the 95.1%. The remaining **89** uncovered obligations are `MM-FR-*`, `MM-NFR-*` and
> `MM-CFG-*` detail inside chapters whose behaviour §23's criteria already exercise; they are likewise counted honestly
> in the 60.1% rather than excluded to flatter the ratio.
>
> **Nothing was padded.** `MM-AC-093` and `MM-AC-094` each verify a group of registers because the underlying
> obligations are genuinely one test apiece (an authorisation matrix, and a set of must-be-impossible constructions);
> splitting them into eighteen near-identical rows would inflate the count without adding a single distinct check.

---

## 24. Expert-Discovered Additions

Capabilities **not** in the supplied feature list, found by reviewing the domain against this repository's own
architecture. Nothing here is included because other membership products have it.

### 24.1 Classification table

| Proposed capability | Classification | Why |
|---|---|---|
| **`PendingPayment` as an explicit status** | **A — Required for V1** | Not a new idea: BC Map `E-10` says *"may activate a **pending** membership"*. Without the state, `E-10` has nothing to act on and the payment gate cannot exist |
| **`Scheduled` status for future-dated starts** | **A — Required for V1** | `MM-CFG-004` permits advance sales; without `Scheduled`, a future membership would be either wrongly `Active` (entitlement before payment period) or indistinguishable from `PendingPayment` |
| **`membership.MembershipActivated` event** | **A — Required for V1** | `BC-04`/`BC-03` must know when entitlement **begins**. `MembershipCreated` cannot say so when the status is `PendingPayment`. Raised as `MM-GAP-007` because BC Map §9 does not list it; since **closed** — reconciled under the ratified `BC-01` precedent (§12) |
| **`membership.MembershipUpgraded` event** | **A — Required for V1** | BC Map `E-07`'s contract text already names `MembershipCreated/Renewed/**Upgraded**/Frozen`; its absence from the §9 table appears to be an omission. `BC-05` cannot adjust dues without it |
| **Void before activation (§5.4)** | **A — Required for V1** | Wrong-student and wrong-plan errors happen hourly at a reception desk. With `MM-INV-001` blocking overlap, an uncorrectable bad record permanently blocks the correct one. This is error correction on a non-entitling record — **not** V2 Cancellation, which involves refunds |
| **Auto-void of stale `PendingPayment` (`MM-CFG-007`)** | **A — Required for V1** | Without it, an abandoned unpaid membership blocks `MM-INV-001` forever and the student can never be sold a membership again |
| **Visible reconciliation queue** | **A — Required for V1** | Not discovered by me — **mandated** by BC Map §10 line 465 as the V1 substitute for the V2 saga |
| **`idempotencyKey` on every mutating command** | **A — Required for V1** | BC Map §10.1 lists duplicate payment capture as *"unrecoverable trust damage"* and prescribes an idempotency key at the API edge |
| **DB-level enforcement of overlap, not application checks** | **A — Required for V1** | Read-check-write is a race. The Map prescribes a constraint + lock for the structurally identical seat case |
| **`planVersionAtPurchase` on the membership** | **A — Required for V1** | A price snapshot alone cannot prove *which* plan revision was sold. Needed for any pricing dispute and to make `MM-AC-005` checkable |
| **Duration in days, not months** | **A — Required for V1** | The instruction demands deterministic month-end and leap-year behaviour (§21 cases 18–19). Month arithmetic cannot deliver it without inventing a 31→28 rule the architecture has not specified |
| **Separation of `MM-PO-004` from `MM-PO-003`** | **A — Required for V1** | Otherwise any reception user can create-then-activate and confer entitlement with no payment, making the payment gate decorative |
| **`isValid` + `status` added to the `E-02` projection** | **A — Required for V1** | If consumers receive only `validUntil`, every one of them re-implements §4.5 — precisely what `MM-FR-066` forbids. Additive to the Map's stated shape, not a redefinition |
| **Suspension suppresses validity without mutating status** | **A — Required for V1** | `PRD-004` §288 requires `BC-02` to refuse entitlement on suspension; mutating the membership would destroy a paid term irreversibly |
| **Validity correct while the expiry job is down** | **A — Required for V1** | A scheduler outage must not silently confer paid entitlement. Read-time rule + materialising job (`MM-FR-104`) |
| **Tenant-timezone business dates, server time never used** | **A — Required for V1** | The instruction requires deterministic timezone boundaries; `ADR-0003`'s hybrid tenancy makes multi-timezone tenants a live possibility |
| Membership lineage fields (`renewedFrom`, `upgradedFrom`) | **B — Recommended for V1** | Cheap to store, and without them a renewal chain cannot be reconstructed. The *Membership History* **feature surface** remains V2 (EA line 733), so only the fields are proposed, not a UI |
| Plan-level `seatQuota` | **B — Recommended for V1** | BC Map line 211 and the `E-02` contract both name `seatQuota`, so the field is architecturally expected — but `BC-04` is `PRD-007` and unwritten, so V1 usefulness cannot be confirmed from a written PRD |
| Reason codes on void and manual activation | **B — Recommended for V1** | Free-text reasons make audit review manual. Structured codes would help, but no repository convention for reason codes exists to conform to |
| Membership notes field | **B — Recommended for V1** | Reception staff want context. No architecture document asks for it, so it stays Recommended |
| Bulk membership creation / import | **C — V2** | Belongs with `Import & Export`, EA line 718 **V2** |
| Waitlist when plan capacity is full | **C — V2/V3** | No plan-capacity concept exists in any source document. Inventing one would invent a requirement |
| Membership pause for holidays | **C — V2** | This is Membership Freeze, EA line 728 **V2** (`MM-XC-009`) |
| Family / group membership | **C — Future** | No source document mentions it; adjacent to Cross-Library Membership (Future) |
| Discount / coupon on a membership | **C — V2** | `Discount` is a `BC-05` `FeeLedger` entity (BC Map §8) with *"discount requires an authorised approver role"*. Putting it here would duplicate `BC-05` |
| Refund on early termination | **C — V2** | Requires Cancellation + Proration, both V2, and refunds are `BC-05`'s |
| Membership card / QR credential | **D — Not needed** | Attendance already owns QR (`BC-03`, EA). A second QR credential would duplicate it |
| Auto-renewal with saved payment method | **D — Not needed for V1** | Explicitly **V3** (`MM-XC-007`) and would require stored payment instruments this module must never hold |
| Churn / retention / cohort metrics | **D — Not needed** | Explicitly excluded (§9, `MM-XC-006`) |
| Membership-specific search index | **D — Not needed** | Would require a `BC-02` → `BC-23` edge that does not exist (`MM-GAP-004`) |

### 24.2 Recommended, not mandatory

Per §0.1, the four **B** items above carry **no** obligation and are **not** V1 requirements. Where a `MAY`-level
requirement exists for them (`MM-FR-009`'s `seatQuota`, `MM-FR-036`'s `note`, §13.1's lineage fields), it is `MAY`
precisely so that omitting them is not a defect. They become mandatory only if product review promotes them.

### 24.3 Where my recommendation lost to an existing decision

| My instinct | Existing decision | Outcome |
|---|---|---|
| A short grace period after expiry is humane and standard | `Q-01` is **open**; Master PRD line 673 confirms it | **Existing decision preserved.** No grace period (`MM-FR-111`). Recorded as `MM-GAP-001` |
| `BC-02` should compute a prorated credit on upgrade | `Q-06` is **open**; Proration is EA **V2** | **Existing decision preserved.** Entitlement delta only (`MM-FR-099`/`MM-FR-100`); `MM-GAP-002` |
| Expiry should auto-release the seat | `Q-01`; and `BC-04` owns allocation | **Existing decision preserved.** Event only (`MM-FR-112`) |
| Membership search deserves the platform search index | `E-21` lists only `BC-01`, `BC-10`; line 292 forbids unlisted edges | **Existing decision preserved.** Local match (`MM-FR-030`); `MM-GAP-004` |
| Age-based eligibility should be mandatory | DOB availability is unresolved (`GCP-05`/`SM-GAP-10`) | **Existing gap preserved.** `MAY` only (`MM-FR-016`); `MM-GAP-003` |

---

## 25. Cross-Document Review

### 25.1 Conflicts found

Per §0.1, a conflict with a ranked document is raised rather than silently fixed. **No existing document was
modified.** Two conflicts (**C-2**, **C-3**) were subsequently investigated in
[`PRD-005_BLOCKER_ANALYSIS.md`](PRD-005_BLOCKER_ANALYSIS.md) and **ratified as compliant on 2026-08-04** — the
apparent conflict was in this document's *characterisation* of the BC Map, not in its model. Both are now closed
without any ADR and without amending the BC Map. See [`PRD-005_CORRECTION_REPORT.md`](PRD-005_CORRECTION_REPORT.md).
**`C-8`** was found by the second independent review and resolved at v1.2 the same way — by following frozen
`PRD-004`'s treatment rather than by inventing an edge. See
[`PRD-005_SECOND_INDEPENDENT_REVIEW.md`](PRD-005_SECOND_INDEPENDENT_REVIEW.md) and
[`PRD-005_F1-F4_CORRECTION_REPORT.md`](PRD-005_F1-F4_CORRECTION_REPORT.md).

| # | Conflict | Evidence | Severity | Disposition |
|---|---|---|---|---|
| **C-1** | **Membership Analytics is classified V3 in one place and V2 in two others** | EA line **734** *"Membership Analytics (V3)"* inside Membership Management; EA line **837** *"Membership Analytics (V2)"* under Analytics & Growth Reports; EA line **1607** *"Membership Analytics (V2)"* under Business Intelligence | Medium | **No effect on this PRD** — all three agree it is **not V1**, and `MM-XC-006` excludes it either way. But EA (Rank 6) contradicts itself and should be corrected by its owner. Not resolved here |
| **C-2** | ~~`MembershipStatus` value set differs from BC Map line 209~~ — **RESOLVED, not a conflict** | Line 209 is in BC Map **§5**, whose preamble binds *"the resolution column"*. `Valid/Expired/Frozen` sits in column 3 (`Context B meaning`); column 4 (`Resolution (binding)`) requires the type name `MembershipStatus` and two independent state machines — **both satisfied**. Columns 2–3 are provably non-exhaustive: the `Role` row (L212) lists 3 `AccessRole` values where the Rank 3 Authentication PRD defines 5 (§2.2.6, §2.2.7, `BR-2.9`) | **Closed** | **`MM-GAP-006` closed 2026-08-04.** No ADR; BC Map unmodified. Corroborated by `Frozen` = V2 (EA 728), `E-10`'s *"pending membership"* (L307), and `Valid` being derived per `E-02` (L299). Residual editorial observation → `MM-GAP-006a` |
| **C-3** | ~~Three `BC-02` events are not in BC Map's list; two listed events are excluded~~ — **RESOLVED, not a conflict** | Event surface is BC Map **§9** (L397), not §8. §9 declares closure only for `BC-10` (L429), self-describes as the *"seed"* of a Catalog that does not exist, and the sole ADR trigger (L292) is scoped to **edges** — no new edge is introduced. Frozen `PRD-004` §7.4 registers **10** `BC-01` events where §9 lists **4**, ratified by `ADR-0018` | **Closed** | **`MM-GAP-007` closed 2026-08-04.** No ADR; BC Map unmodified. `Upgraded` is already at `E-07` (L304); `Activated` follows `E-10`/§9 L421; `Voided` follows §5.4; `Frozen`/`Unfrozen` correctly excluded as V2 (EA 728, 731). Residual observations → `MM-GAP-007a` |
| **C-4** | **BC Map §8 writes the term invariant as strictly `validUntil > validFrom`, which a single-day plan cannot satisfy under §4.3's inclusive endpoints** | BC Map line 371 (*Aggregate & Invariant Register*); `MM-FR-011` permits `durationDays: 1` | Medium | **`MM-GAP-008`.** Either single-day plans are disallowed or `>` is read against an exclusive-end formulation. Not decided here |
| **C-5** | **No `BC-06` → `BC-02` edge exists, yet holiday-aware terms would need one** | BC Map §7 has `E-04`/`E-05`/`E-06` from `BC-06` to `BC-03`/`BC-04`/`BC-05` only | Low | **`MM-GAP-009`.** V1 explicitly does not extend terms for holidays (`MM-FR-060`). No edge invented |
| **C-6** | **`Q-01` (expiry grace / seat release) and `Q-06` (proration ownership) are both open and both land on `BC-02`** | BC Map §13 (*Open Questions*); Master PRD lines 673, 678; `MP-DEP-07` names `Q-01`…`Q-07` as a schema-freeze dependency | Medium | **`MM-GAP-001`, `MM-GAP-002`.** V1 behaviour specified so as to be correct under **either** resolution |
| **C-7** | **EA line 855 lists *Membership Expiry Reminder* as V2 while BC Map §9 lists `MembershipExpiringSoon` as a V1 `BC-02` event** | EA 855; BC Map 411 | Low | **Not a conflict on inspection** — EA describes the `BC-22` *reminder feature*, BC Map the `BC-02` *fact*. §18 records the distinction. Emitting a fact early is harmless; retrofitting the emitter is not |
| **C-8** | **BC Map §9 names `BC-26` a consumer of `BC-02` events, but §7 declares no `BC-02` → `BC-26` edge** | BC Map L409/410/412/413 (§9 consumers) vs L335 (`E-26` is `BC-26`'s only inbound edge) and L292 (*"if an edge is not in this table, it **does not exist**"*) | Medium | **Resolved at v1.2 without an ADR.** A Rank 4 internal tension, not this document's decision. `BC-26` is **not listed** as a consumer (`MM-BR-035`), no edge is invented and nothing additional is emitted — the identical treatment frozen `PRD-004` §7.4 applied at `SM-GAP-11`. Recorded as `MM-GAP-010` for the architecture owner |

### 25.2 Open questions — `MM-GAP-001` … `MM-GAP-010`, plus `MM-GAP-006a`/`MM-GAP-007a`/`MM-GAP-010a`

**None of these is a requirement.** Each records a decision this document declines to invent. `MM-GAP-006` and
`MM-GAP-007` are **closed** (ratified 2026-08-04); their identifiers are retained rather than reused so that prior
citations remain resolvable, and each leaves a non-blocking successor observation against the BC Map.

| ID | Question | Owner | Blocking? |
|---|---|---|---|
| `MM-GAP-001` | Does an expired membership get a grace period, and does it extend *entitlement* or only *seat release*? (`Q-01`) | Architecture + `BC-04` owner | Not for V1 — `MM-FR-111` is correct under either answer |
| `MM-GAP-002` | Who executes proration money, and what exactly is the `BC-02` entitlement delta contract? (`Q-06`) | Architecture + Business Platform | Not for V1 — Proration is V2 |
| `MM-GAP-003` | Can age-based plan eligibility be mandatory when DOB's mandatory/optional status is itself unresolved? (`GCP-05` / `SM-GAP-10`) | `BC-10` owner | Not for V1 — eligibility is `MAY` |
| `MM-GAP-004` | Should membership search use `BC-23`, requiring a new `E-2x` edge? | Architecture | No — local match suffices at V1 scale |
| `MM-GAP-005` | May an owner force an immediate `seatQuota` change on active memberships? | Product | No — deferral to renewal is the safe default |
| ~~`MM-GAP-006`~~ | ~~Reconcile the V1 `MembershipStatus` set with BC Map line 209~~ | Architecture | **CLOSED 2026-08-04 — ratified compliant (§5.1). No ADR, BC Map unmodified** |
| `MM-GAP-006a` | Should BC Map §5's per-context columns be annotated *"illustrative, not exhaustive"*, and should the event surface name a `BC-02` pre-activation state given `E-10`? | Architecture (BC Map owner) | **No** — editorial hygiene in a Rank 4 document; this PRD is correct either way |
| ~~`MM-GAP-007`~~ | ~~Amend the BC Map's `BC-02` event list for `Activated`, `Upgraded`, `Voided`~~ | Architecture | **CLOSED 2026-08-04 — ratified compliant (§12). No ADR, BC Map unmodified** |
| `MM-GAP-007a` | BC Map §9 omits `MembershipUpgraded` though `E-07` (L304) names it, and lists `Frozen`/`Unfrozen` (V2 per EA 728/731) in a table headed *"V1 event surface"* | Architecture (BC Map owner) | **No** — two internal inconsistencies in Rank 4, pre-existing and independent of this PRD |
| `MM-GAP-008` | Is `endDate == startDate` (single-day plan) permitted against BC Map's strict `>`? | Architecture | Blocks single-day plans only |
| `MM-GAP-009` | Should holidays extend a term, and if so via which edge? | Architecture + `BC-06` owner | No — V1 does not extend terms |
| `MM-GAP-010` | **Systemic, not `BC-02`-specific: BC Map §9 names `BC-26` Analytics a consumer for *eleven* producing contexts — `BC-01`, `BC-02`, `BC-03`, `BC-04`, `BC-05`, `BC-10`, `BC-11`, `BC-12`, `BC-18`, `BC-20`, `BC-27` — while §7 declares an inbound edge to `BC-26` from only *one* of them (`E-26`, from `BC-27`, L335). L292 says an edge absent from §7 "does not exist".** So **ten** producer→`BC-26` relationships are asserted in §9 with no §7 edge; the `BC-02` instance (L409/410/412/413) and the frozen `BC-01` instance (`SM-GAP-11`) are two symptoms of one Rank 4 defect. The general question the architecture owner must settle is therefore: **is consumption of a Published-Language event a relationship that requires its own §7 edge at all?** Either (i) §7 needs ten new producer→`BC-26` edges under an ADR; or (ii) read-model/projection fan-out is declared *not* to be a §7 edge — the `E-20` *"All contexts"* pattern generalised — and §9 consumer cells become self-sufficient; or (iii) §9's consumer column is declared advisory, in which case §7 remains the sole authority on who may receive what. **A ruling on the class settles every module PRD at once instead of each one re-deriving the same refusal.** *(Related but tracked separately, because `BC-26` is V1 and `BC-28` is V2: the `BC-28` question is `MM-GAP-010a` below.)* | Architecture (BC Map owner) | **No** — `BC-26` is simply not listed as a consumer (`MM-BR-035`), exactly as frozen `PRD-004` did at `SM-GAP-11`. No edge invented, no ADR created, the BC Map is not modified, nothing additional emitted, no event changed. This document is correct under **all three** resolutions above |
| `MM-GAP-010a` | **Is a V2 context's absence from BC Map §7 deliberate, or an omission?** BC Map §9 L411 names `BC-28` Workflow a consumer of `membership.MembershipExpiringSoon`, yet §7 declares **no edge to `BC-28` at all**. V2 status alone does not explain this: §7 **does** declare edges whose consumers are V2 contexts — `E-14` (L318) runs from **V1** `BC-13` to `BC-11`, `BC-12` and the **V2** contexts `BC-14` and `BC-15` (L118/L119), and `BC-14` is upstream on `E-22` (L331). So the §7 table is **not** uniformly V1-only in its endpoints, and `BC-28`'s absence is consistent both with deliberate deferral of V2 orchestration edges and with an omission of the `BC-26` kind. The BC Map does not distinguish the two, and this PRD may not settle it. Related: `MM-GAP-010` (the V1 `BC-26` class). *(This observation replaces a claim in v1.3 that no wholly-V2 context appears in §7, which `E-14` falsifies; see the v1.4 history row.)* | Architecture (BC Map owner) | **No** — `BC-28` is annotated `(V2)` and `MM-BR-035` makes that annotation assert **no V1 edge and no V1 delivery obligation**; V1 delivery of `MM-EVT-006` is to `BC-22` on `E-23` alone. No edge invented, no ADR created, the BC Map is not modified. This document is correct under **either** reading |

### 25.3 Checks performed

| Check | Result |
|---|---|
| Duplicate responsibilities | **None found.** §1.4 and §11.2 map every adjacent concern to its owner; `MM-XC-001`…`016` make duplication impossible |
| Conflicting requirements | **8 recorded** in §25.1; **0 block freeze** — `C-2`/`C-3` ratified 2026-08-04, `C-8` resolved at v1.2 on the frozen `PRD-004` precedent; none silently resolved |
| Missing dependencies | `PRD-004` **FROZEN** (`E-01`) satisfied. `PRD-006`/`PRD-007`/`PRD-008` (`BC-03`/`BC-04`/`BC-05`) **do not yet exist** — this document publishes to them through pre-declared edges only, so it does not depend on their content |
| Terminology mismatch | Checked against BC Map §5: `MembershipPlan` ≠ `SubscriptionPlan` (line 203); `SeatQuota` ≠ `Seat` (line 211); `MembershipHolder` ≠ `CommunityMember` (line 200); `MembershipStatus` ≠ `EnrollmentStatus` (line 209). All observed |
| Version mismatch | Baseline `BASELINE-2026-08-04-C` cited; `PRD-004` cited at **v1.2 FROZEN**; EA cited as the source of the V2/V3 discrepancy (C-1) |
| Ownership violations | **None.** No write outside `BC-02`; no payment, notification, analytics, audit-storage or authorisation model here |
| Prefix collision | `MM-*` prefixes verified absent from `docs/**` before adoption (`PRD_REGISTRY.md` §5 procedure) |
| Register contiguity | Each range in §0.2 is contiguous with no gaps; the suffixed identifiers (`MM-FR-057a`, and `MM-GAP-006a`/`007a`/`010a`) are documented in §0.2 |
| Verification coverage | **Measured, not asserted**, under the strict counting rule defined in §0.2 (identifier present in an `MM-AC-*` *Verifies* cell; prose never counts). **77/81 = 95.1%** of the `MM-BR-*`/`MM-INV-*`/`MM-XC-*`/`MM-PO-*`/`MM-EVT-*` registers, and **134/223 = 60.1%** of all criterion-verifiable obligations (§23.1). `MM-INV-*`, `MM-EVT-*`, `MM-XC-*` and `MM-PO-*` are at **100%**; `MM-BR-*` is at 31/35. **Four rules are not verified by a criterion of their own** — `MM-BR-012`, `MM-BR-022`, `MM-BR-027`, `MM-BR-028` — each a restatement whose substance is exercised at its definition site (`MM-AC-051`/`052`, `MM-AC-004`…`011`, `MM-AC-015`); they are counted as **uncovered**, and this row does **not** claim otherwise. v1.2's *"every rule carries a verifying criterion — 81/81"* was false and is corrected here (`TR-3`) |

### 25.4 What this document deliberately did not do

- It did **not** modify `MASTER_PRD.md`, the Bounded Context Map, the EA, any ADR, `PRD-004`, or any other file.
- It did **not** resolve `Q-01`, `Q-03`, `Q-06`, `GCP-05` or the EA V2/V3 discrepancy.
- It did **not** invent a grace period, a proration rule, a search edge, a plan-capacity concept, or a role.
- It did **not** register itself in `PRD_REGISTRY.md` or claim a baseline row. Freeze is **conferred, not claimed**
  (`PRD_LIFECYCLE.md` Stage 7); this document is **`DRAFT`** at Stage 2 and says so in its header.

---

## 26. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created as **`DRAFT`** under `PRD_LIFECYCLE.md` Stage 2. Specifies `BC-02` Membership for V1: the four authoritative capabilities (Plans, Creation, Renewal, Upgrade) plus the Activation/Validity, Status/Entitlement, Expiry and Operational-Views chapters the architecture requires. **288 identifiers** across 10 registers, contiguous, zero prefix collisions. Membership Analytics excluded as not-V1 (`MM-XC-006`); Downgrade, Freeze, Transfer, Cancellation, Proration and History excluded as V2; Auto Renewal excluded as V3; Cross-Library as Future. **Seven cross-document conflicts recorded rather than resolved** (§25.1), of which two — `MM-GAP-006` and `MM-GAP-007` — were declared freeze-blocking. `Q-01` grace period and `Q-06` proration deliberately **not** decided. **No existing document was modified and no other file was created.** |
| v1.1 | 2026-08-04 | **Ratification and correction pass** following [`PRD-005_BLOCKER_ANALYSIS.md`](PRD-005_BLOCKER_ANALYSIS.md); recorded in [`PRD-005_CORRECTION_REPORT.md`](PRD-005_CORRECTION_REPORT.md). **`C-2` closed** — §5.1 rewritten: BC Map line 209 sits in §5, whose preamble binds only the *resolution* column; the six-value set satisfies that column, and columns 2–3 are proven non-exhaustive by the `Role` row, which lists three `AccessRole` values where the Rank 3 Authentication PRD defines five (Owner, Manager, Reception plus Platform Support §2.2.6 and Platform Administrator §2.2.7, with `BR-2.9` naming *"both platform roles"*) — so a Rank 3 PRD would be in breach if column 2 bound the value set. *(This row's original wording cited "`TR-1`…`TR-5`, §2.2.1–2.2.5"; the second independent review verified that §5.1's actual citations are §2.2.6, §2.2.7 and `BR-2.9`, and this row is corrected to match the evidence §5.1 relies on. The conclusion is unchanged.)* **`C-3` closed** — §12 rewritten on the ratified `BC-01` precedent: frozen `PRD-004` §7.4 registers 10 events where BC Map §9 lists 4, blessed by `ADR-0018`; the only ADR trigger (L292) is edge-scoped and no edge is added. **`MembershipUpgraded` preserved.** **Citation corrections:** the event surface is BC Map **§9** (was cited §8, in 2 places); the Aggregate & Invariant Register is **§8** (was cited §6, in 8 places); Open Questions is **§13** (was §12). **Four stale cross-references** that still described `MM-GAP-006`/`MM-GAP-007` as open questions (§4.1 note, `MM-FR-054`, §5.3 note, §24.1 row) were rewritten to state the ratified position. Two non-blocking successor observations opened against the BC Map (`MM-GAP-006a`, `MM-GAP-007a`). **Two integrity defects found by the post-edit register audit and fixed:** §0.2 still declared 9 `MM-GAP` identifiers and a total of 288 after the two successors were added — now **290 total, 279 obligation-bearing, 11 `MM-GAP`**, with the suffix convention documented; and §14.1's `MM-BR-030` row was a second em-dash-free definition of a rule defined in §9 — now an explicit restatement naming §9 as the definition site. **No requirement, invariant, event, AC, status value or scope decision changed; no ranked or frozen document modified; no ADR created; the 279 obligation-bearing identifiers are unchanged from v1.0, all registers contiguous, zero duplicate definitions.** |
| v1.2 | 2026-08-04 | **Correction of the four findings raised by [`PRD-005_SECOND_INDEPENDENT_REVIEW.md`](PRD-005_SECOND_INDEPENDENT_REVIEW.md) (verdict **B**); recorded in [`PRD-005_F1-F4_CORRECTION_REPORT.md`](PRD-005_F1-F4_CORRECTION_REPORT.md).** **`F-1` (BC-26, moderate):** BC Map §9 names `BC-26` a consumer of `BC-02` events (L409/410/412/413) but §7 declares **no `BC-02` → `BC-26` edge** (`E-26` from `BC-27` is its only inbound, L335) and L292 says an absent edge *"does not exist"*. Following frozen `PRD-004` §7.4's treatment of the identical `BC-01` tension (`SM-GAP-11`), **`BC-26` is no longer listed as a consumer** — removed from the header row and from all six `MM-EVT-*` rows — **no edge invented, no ADR, BC Map unmodified, nothing additional emitted**. The false reachability sentence in §12 (which claimed `BC-26` reachable on `E-07`/`E-02`/`E-03`/`E-20`/`E-23`, none of which terminate at `BC-26`) is corrected to the five consumers that do verify. New `MM-BR-035` makes the consumer rule enforceable; tension recorded as `MM-GAP-010`; conflict recorded as `C-8`. **`F-2` (closure unenforceable):** §12 asserted a *"closed set"* with no requirement to enforce it — no analogue of frozen `SM-7.12`. **`MM-BR-035`** now requires the register be closed at **seven** and that every consumer resolve to an `MM-BR-006` edge. **`F-3` (`endDate` contradiction):** §10.2 required `endDate` *"recomputed from the activation date"* while `MM-FR-057` defines `endDate = startDate + (durationDays − 1)` and `MM-FR-058` forbids clock dependence. Resolved by **`MM-FR-057a`**: the whole term is re-derived from a new `startDate` (= `activatedAt`) using the **unchanged** `MM-FR-057` formula, so both requirements stay literally true and the term is never stretched beyond `durationDays`; §10.2, `MM-CFG-009` and §21 edge 13 aligned. **`F-4` (verification honesty):** **39** criteria added (`MM-AC-059`…`MM-AC-094` plus `MM-AC-074a`/`076a`/`080a`, §23.1), derived by mechanically listing every `MM-BR-*`/`MM-INV-*`/`MM-XC-*`/`MM-PO-*`/`MM-EVT-*` with no verifying criterion. Coverage of those five registers rises from **13.8% (11/80)** to **100.0% (81/81)**; coverage across all criterion-verifiable obligations from **28.1%** to **62.8% (140/223)**, so `MM-NFR-014` now holds across every obligation register. *(**These two v1.2 figures were later shown to be wrong and are superseded by v1.3.** They were produced by a script that scanned each §23 block including its prose, so a note stating that four rules were **not** separately covered was counted as coverage of them. The third independent review raised this as `TR-2`; §0.2 now fixes the counting rule and the measured values are **95.1% (77/81)** and **60.1% (134/223)**. The row is annotated rather than rewritten, so the figures v1.2 actually published stay auditable — the same convention this row applied to v1.1. The **coverage** described above was real; only its **measurement** was overstated.)* Also corrected the v1.1 history row's imprecise `TR-1…TR-5` citation to the §2.2.6/§2.2.7/`BR-2.9` evidence §5.1 actually relies on. **Four defects in this correction pass were caught by its own post-edit audit and fixed before commit:** a phantom reference to a non-existent 119th `MM-FR`, three rules still uncovered after the first draft of §23.1 (`MM-BR-019`, `MM-INV-008`, `MM-EVT-007`), an `MM-AC-088` that cited the open question `MM-GAP-008` as if it were a verifiable obligation, and declared counts that overstated coverage. Registers: **332 identifiers, 320 obligation-bearing, 12 `MM-GAP`**, all contiguous, zero duplicates. **No requirement was deleted or weakened, no scope, status value, event payload or invariant changed; no ranked or frozen document modified; no ADR created; no code touched; not frozen.** |
| v1.3 | 2026-08-04 | **Correction of the five findings raised by [`PRD-005_THIRD_INDEPENDENT_REVIEW.md`](PRD-005_THIRD_INDEPENDENT_REVIEW.md) (verdict **B**); recorded in [`PRD-005_TR-1-TR-5_CORRECTION_REPORT.md`](PRD-005_TR-1-TR-5_CORRECTION_REPORT.md).** **`TR-1` (`MM-BR-035` violated by its own table, high):** v1.2's `MM-BR-035` required *every* consumer named in §12 to be reachable on an `MM-BR-006` edge, yet `MM-EVT-006` listed `BC-28`, which appears on **no** BC Map §7 edge at all. Investigation of the primary source shows the review's suggested remedy (a) — de-list `BC-28` and record a second architectural gap — would have recorded a **defect that does not exist**: BC Map §7 is scoped by its own preamble (L292) to *"every edge that crosses a context boundary **in V1**"*, `BC-28` Workflow is a **V2** context (L137, L147), and **no** wholly-V2 context (`BC-07`, `BC-08`, `BC-09`, `BC-28`) has a §7 row. `BC-28`'s absence is §7 working as designed, **not** the `BC-26` tension, in which a **V1** context is named as a consumer with no inbound edge. *(**This justification was later shown to be false and is superseded by v1.4.** §7 **does** contain edges whose consumers are V2 contexts — `E-14` (L318) runs from V1 `BC-13` to the V2 contexts `BC-14` and `BC-15` (L118/L119) — so "no wholly-V2 context has a §7 row" is untrue, and `BC-28`'s absence cannot be shown to be by construction. The fourth independent review raised this as `QR-1`. The **outcome** below stands, and is re-justified in v1.4 on the verified facts alone; the **stated ground for rejecting remedy (a)** does not, and the `BC-28` question is now recorded as `MM-GAP-010a`. The row is annotated rather than rewritten, so the reasoning v1.3 actually published stays auditable — the same convention applied to the v1.1 and v1.2 rows.)* Remedy **(b)** applied instead: `MM-BR-035`'s reachability clause is narrowed to **V1** consumers, and a `(V2)`-annotated consumer is now defined to assert **no V1 edge and no V1 delivery obligation**, may be listed only where BC Map §9 already names it (L411 does), and **MUST NOT** be depended on by any V1 behaviour. `BC-28` is retained with its `(V2)` annotation so §12 does not diverge from the Rank 4 Published Language. `MM-AC-075` re-verified and tightened to test the annotation rule. **No edge invented, no ADR created, BC Map unmodified.** **`TR-2` (coverage figure not reproducible, high):** v1.2 declared **81/81 = 100.0%** and **140/223 = 62.8%**, figures reachable only by scanning each §23 block *including its prose*; the 100% depended on the very sentence stating that four rules were **not** separately covered. A metric that rises when prose about a gap is written measures prose, not verification. §0.2 now defines a **binding strict counting rule** — an obligation is verified **only** if its identifier appears in an `MM-AC-*` *Verifies* cell — and publishes the measured result with a per-register breakdown. **The claim was corrected, not the coverage: no criterion was deleted, weakened or manufactured.** **`TR-3` (false universal claim):** §25.3's *"Every `MM-BR-*`, `MM-INV-*`, `MM-XC-*`, `MM-PO-*` and `MM-EVT-*` now carries at least one verifying `MM-AC-*` — 81/81 = 100.0%"* was untrue and is replaced by the measured statement, naming the four unverified rules explicitly. No requirement weakened, no criterion removed. **`TR-4` (traceability hygiene):** `MM-EVT-001`…`MM-EVT-006`, `MM-PO-003` and `MM-PO-004` were each already tested by an existing criterion whose **text** named them but whose *Verifies* cell did not. The register IDs were added to those **existing** cells — `MM-AC-062`, `MM-AC-024`, `MM-AC-040`, `MM-AC-049`, `MM-AC-042`, `MM-AC-043`/`MM-AC-081`, `MM-AC-027`, `MM-AC-026` — with **no new criterion, no duplicate criterion and no change to any criterion's substance**. Strict coverage consequently rises from **69/81 (85.2%)** to **77/81 (95.1%)**, and from **126/223 (56.5%)** to **134/223 (60.1%)**. **`TR-5` (gap too narrow):** `MM-GAP-010` described only the `BC-02` instance. It is broadened to the systemic Rank 4 defect — BC Map §9 names `BC-26` a consumer for **eleven** producing contexts while §7 declares an inbound edge to `BC-26` from only **one** (`E-26`) — and now poses the general question (must Published-Language consumption carry its own §7 edge?) with the three candidate resolutions, so one ruling settles the class rather than each module PRD re-deriving the same refusal. `BC-28` is explicitly excluded from the gap, with the V1-scope reasoning. Registers unchanged: **332 identifiers, 320 obligation-bearing, 12 `MM-GAP`**, all contiguous, zero duplicates, 97 `MM-AC-*` rows. **No requirement was added, deleted, weakened or renumbered; no scope, status value, event, payload or invariant changed; no ranked or frozen document modified; no ADR created; no API, schema, SQL, UI or test was specified; no code touched; not frozen, not registered, not approved.** |
| v1.4 | 2026-08-04 | **Correction of the two findings raised by [`PRD-005_FOURTH_INDEPENDENT_REVIEW.md`](PRD-005_FOURTH_INDEPENDENT_REVIEW.md) (verdict **B**); recorded in [`PRD-005_QR-1-QR-2_CORRECTION_REPORT.md`](PRD-005_QR-1-QR-2_CORRECTION_REPORT.md).** **`QR-1` (false claim about a Rank 4 document, medium):** v1.3's §12 note justified retaining `BC-28 (V2)` on the assertion that `BC-28` has no BC Map §7 row *"and neither do the other wholly-V2 contexts `BC-07`, `BC-08` and `BC-09`"*, concluding that the absence was *"that table working as designed, not a defect"*. **The premise is false.** §7 **does** declare edges whose consumers are V2 contexts: `E-14` (L318) runs from **V1** `BC-13` Trust & Safety to `BC-11`, `BC-12` and the **V2** contexts `BC-14` and `BC-15` (L118/L119), and `BC-14` is upstream on `E-22` (L331); the string *"wholly-V2"* appears nowhere in the BC Map. V2 status therefore does **not** entail absence from §7, and `BC-28`'s absence cannot be shown to be by construction. The note is rewritten to rest **only** on facts verified in the primary source — `BC-28` is V2 (L137, L147), §9 L411 names it a consumer, and §7 declares no edge to it — and to state plainly that the BC Map does not distinguish deliberate deferral from omission, which **this document may not settle**. The retention of `BC-28` with its `(V2)` annotation is **unchanged** and is re-justified on the narrow true ground: `MM-BR-035` makes `(V2)` assert **no V1 edge and no V1 delivery obligation**, V1 delivery of `MM-EVT-006` is to `BC-22` on `E-23` alone, so the document is correct under **either** reading and no resolution can falsify it. The suppressed question is now recorded for the architecture owner as **`MM-GAP-010a`** (§25.2), using the suffixed-successor convention already established by `MM-GAP-006a`/`MM-GAP-007a`; `MM-GAP-010`'s parenthetical excluding `BC-28` on the false basis is replaced by a cross-reference, and the v1.3 history row is annotated. **No edge invented, no ADR created, BC Map unmodified, no requirement changed.** **`QR-2` (residual `TR-3`-class claim, low):** §23.1's introduction still asserted that `MM-NFR-014` *"holds for the business-rule, invariant, exclusion, protected-operation and event registers"*, though `MM-BR-012`, `MM-BR-022`, `MM-BR-027` and `MM-BR-028` carry no verifying criterion — the same false universal `TR-3` corrected at §25.3, surviving one section earlier. Qualified to the measured position: full coverage of the invariant, exclusion, protected-operation and event registers, **31 of 35** business rules, with the four exceptions named. **Coverage figures are unchanged and were re-measured to confirm it: 77/81 = 95.1% and 134/223 = 60.1%** — no criterion added, deleted, weakened or manufactured, and no requirement text altered. Registers: **333 identifiers, 320 obligation-bearing, 13 `MM-GAP`** (`MM-GAP-010a` added; obligation-bearing count unchanged because `MM-GAP-*` carries no obligation), all contiguous, zero duplicates, 97 `MM-AC-*` rows. **No requirement was added, deleted, weakened or renumbered; no scope, status value, event, payload or invariant changed; no ranked or frozen document modified; no ADR created; no API, schema, SQL, UI or test was specified; no code touched; not frozen, not registered, not approved.** |
| v1.4 | 2026-08-04 | **FROZEN — admitted to the documentation baseline by [`ADR-0019`](../../00-governance/adr/ADR-0019-membership-management-prd-v1.4-baseline.md).** `PRD_LIFECYCLE.md` Stage 7 reached, after Stage 5 (`TRACEABILITY_MATRIX.md` **v1.5** §2D — ten `MM-*` registers, **333** identifiers, all contiguous, **0** duplicates, **0** collisions) and Stage 6 (`PRD-005_IMPLEMENTATION_TASKS.md` **v1.0** — **42 tasks `IMPL-400`…`IMPL-441`**, five waves, **223/223 = 100.0%** of obligations claimed), both re-run and **PASS** at exit 0 immediately before admission. `DOCUMENTATION_BASELINE.md` → **BASELINE-2026-08-04-D** with this document listed in §3.3 at **Rank 3** — the **fifth** Rank 3 module baseline and the second `[CORE]` context of the Library cluster to be frozen, so the `E-01` dependency *"membership may not exist without an active enrollment"* is now frozen on **both** sides. `PRD_REGISTRY.md` → v1.6 with the status changed `PLANNED` → **FROZEN**. **No requirement, API, event, payload, invariant, acceptance criterion, business rule, register, coverage figure or scope statement changed in this pass** — the entire diff to this file is this row plus the *Status*, *Date*, *Baseline*, *Rank* and *ADRs applied* header rows. **The version is deliberately preserved at v1.4 and was not renumbered to v1.0**, following the `PRD-003`-at-v1.0 and `PRD-004`-at-v1.2 precedents: Stage 7 confers status, and baseline §7 step 2 increments a version only when *content* changes. Registers unchanged: **333 identifiers, 320 obligation-bearing, 223 criterion-verifiable, 97 `MM-AC-*`, seven `MM-EVT-*` closed at seven by `MM-BR-035`, 13 `MM-GAP-*`**. **Coverage is admitted at its measured value, not rounded up — 77/81 = 95.1% and 134/223 = 60.1%** (`ADR-0019` §2.5), the corrected figures that replaced the false 100% retracted at v1.3 by `TR-2`; the four business rules no criterion verifies (`MM-BR-012`, `MM-BR-022`, `MM-BR-027`, `MM-BR-028`) are named in `ADR-0019` §3.5 and remain open for a post-freeze **clarifying pass**, which needs a changelog entry and no ADR. **Five gaps are admitted OPEN and are NOT ratified by admission** — `MM-GAP-001` (`Q-01` grace period), `MM-GAP-002` (`Q-06` proration), `MM-GAP-005`, `MM-GAP-010` and `MM-GAP-010a` — plus `MM-GAP-006a`/`MM-GAP-007a`, which are carried against the **BC Map** and not against this document; each requires a decision from its named owner, and `ADR-0019` §3 records those owners rather than inventing an answer. `MM-GAP-010` is admitted as **systemic** and supersedes the per-module `SM-GAP-11`/`GCP-06` instance. **No ranked document was amended, no integration edge was added** (despite four recorded temptations), no bounded context was created (still **31**), no global business rule was touched, and `TRACEABILITY_MATRIX.md`, `PRD-005_IMPLEMENTATION_TASKS.md`, `PRD-004` and the three other Rank 3 baselines are **byte-identical**. **§25.4's closing bullet and the task document's §9 are now stale** — both were true when written; they are recorded in `ADR-0019` §3.6 and deliberately **left unmodified**, on the `ADR-0018` §3.4 precedent, so the bytes the fifth independent review verified are preserved. This document is **`FROZEN`, not `VERIFIED`**: **0 of 42 tasks and 0 of 97 acceptance criteria are proven by a test**, so nothing here claims `BC-02` works. Any future change requires **an ADR before the change** (baseline §7 step 1). |
