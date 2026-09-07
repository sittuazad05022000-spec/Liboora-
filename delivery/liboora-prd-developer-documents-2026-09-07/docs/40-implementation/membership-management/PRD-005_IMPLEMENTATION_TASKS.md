# `PRD-005` Implementation Tasks — `IMPL-400` … `IMPL-441`

| Field | Value |
|---|---|
| **Document** | Implementation tasks for [`PRD-MEMBERSHIP-MANAGEMENT.md`](../../30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md) (`PRD-005`, `BC-02`) |
| **Version** | v1.0 |
| **Status** | Backlog record. **Not ranked**, therefore editable without an ADR |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04-C` |
| **Purpose** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 6** gate — allocate an `IMPL-*` range and record a task document in which every task traces back to requirements |
| **Implementation state** | ⛔ **NOTHING IN THIS DOCUMENT IS IMPLEMENTED.** Zero files under `lib/` were created or modified. No development has started |
| **Source of truth** | `PRD-005` v1.4. Where this file disagrees with it, **the PRD is right and this file is a defect** |
| **Stage** | Stage 6 of 9. `PRD-005` remains **`DRAFT`**; this document does **not** freeze it and does **not** advance the registry |

---

## 1. The one thing this document is not

It is **not** evidence of progress, and it is **not** a specification. Forty-two well-formed task rows can read like
work completed; they are a plan for work **not** begun. Verified, not asserted:

```
git diff --stat fe36cd1 -- lib/   → (empty)     # zero application-code changes
git status --short                → only docs/40-implementation/ and tool/docs_check/
```

`PRD-005` `MM-NFR-014`, quoting `SID-4.56`: *"a rule that cannot be checked SHALL be treated as unmet, not as
satisfied by intent."* The same standard applies to a task. Until its test exists and runs, the task is **not done**,
however complete its description reads here.

**What this document deliberately does not contain:** no schema, no SQL, no DDL, no API shape, no widget tree, no
class signature and no estimate. `PRD-005` §0.3 places all of those outside the PRD; expanding them here would be
writing the specification that Stage 6 does not authorise. Scope cells name **what** must be built and the
requirements that govern it, not **how**.

---

## 2. Stage 6 prerequisites — verified, not assumed

`PRD_LIFECYCLE.md` §2: *"A gate is not an opinion — if the artefact does not exist, the stage has not been passed,
however complete the work feels."* Stage 6 is entered only from a satisfied Stage 5.

| Prerequisite | Required artefact | State |
|---|---|---|
| **Stage 5 — Traceability** | All `MM-*` prefixes registered in [`TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) §2, zero collisions | ✅ **Satisfied** — §2D of the matrix (v1.5): ten registers, 333 identifiers, collisions **0** |
| **Stage 4 — Requirements Review** | Uniquely identified, testable, non-duplicating | ✅ Fifth independent review, verdict **A — PASS**, no findings |
| **Stage 6 — this document** | `IMPL-*` range allocated + every task traces to requirements | ✅ This file, mechanically checked by `tool/docs_check/prd005_task_coverage.py` |
| **Stage 7 — Freeze** | A row in `DOCUMENTATION_BASELINE.md` §3 | ⛔ **Not attempted here.** Out of scope for Stage 6 |

> **Stage 6 does not confer freeze.** Completing this gate makes `PRD-005` *eligible* for a Stage 7 proposal; it does
> not perform one, and this document creates no ADR and edits no registry. `PRD_LIFECYCLE.md` §7: *"No fast path.
> Stage 7 is not skippable."*

---

## 3. `IMPL-*` allocation

### 3.1 Why this range — computed, not chosen

`PRD_LIFECYCLE.md` Stage 6 allocation rule 1: *"Take the next free range. **Never reuse or reassign a number** —
cross-references in commits, reviews and test names outlive the document."* Rule 2: *"Leave the previous group room to
grow contiguously."*

Every `IMPL-*` identifier in the repository was enumerated rather than read off a table:

```
grep -rhoE 'IMPL-[0-9]{3}' docs/ tool/ lib/ test/ | sort -u
→ 014-016 020 021 030 031 040 041 050-052 060-062 070-073 097
  100-115 120-128 199 200-217 220-227 300-323
→ highest in use: IMPL-323
grep -rn 'IMPL-4[0-9][0-9]' docs/ tool/ lib/ test/    → (empty)
```

**`IMPL-400` is therefore the allocation.** `IMPL-324` … `IMPL-399` is left reserved so that `PRD-004` — whose backlog
ends at `IMPL-323` and which still has **11 open `SM-GAP-*` decisions** that may yet require tasks — can extend
contiguously. That is rule 2 applied to the immediately preceding group, exactly as Student Identity began at
`IMPL-200` rather than `IMPL-128` to leave Library Management room.

### 3.2 The allocation table

| Range | Owner | Grouping |
|---|---|---|
| `IMPL-014` … `IMPL-073` | Authentication, platform, release readiness | [`IMPLEMENTATION_ROADMAP.md`](../IMPLEMENTATION_ROADMAP.md) |
| `IMPL-100` … `IMPL-127` | Library Management | [`LIBRARY_IMPLEMENTATION_TASKS.md`](../LIBRARY_IMPLEMENTATION_TASKS.md) |
| `IMPL-128` … `IMPL-199` | Reserved for Library Management growth | — |
| `IMPL-200` … `IMPL-226` | Student Identity | [`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md`](../STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md) |
| `IMPL-227` … `IMPL-299` | Reserved for Student Identity growth | — |
| `IMPL-300` … `IMPL-323` | Student Management (`PRD-004`, `BC-01`) | [`PRD-004_IMPLEMENTATION_TASKS.md`](../../30-product/student-management/PRD-004_IMPLEMENTATION_TASKS.md) |
| `IMPL-324` … `IMPL-399` | **Reserved for Student Management growth** — 11 open `SM-GAP-*` may require tasks | — |
| **`IMPL-400` … `IMPL-409`** | **Wave 1 — Plan aggregate, its mutability rules and configurables** | This document |
| **`IMPL-410` … `IMPL-419`** | **Wave 2 — Creation, activation and the term calculus** | This document |
| **`IMPL-420` … `IMPL-427`** | **Wave 3 — Status machine, renewal, upgrade, expiry, persistence** | This document |
| **`IMPL-428` … `IMPL-434`** | **Wave 4 — Edges, events, the validity projection and operational views** | This document |
| **`IMPL-435` … `IMPL-441`** | **Wave 5 — Security, concurrency, audit, exclusions and acceptance proof** | This document |
| `IMPL-442` … `IMPL-499` | **Reserved for Membership Management growth** — 5 open `MM-GAP-*` may require tasks | — |
| `IMPL-500` + | Unallocated | — |

**42 tasks, `IMPL-400` … `IMPL-441`, contiguous with no gaps inside the allocated span.** Wave boundaries fall on
round numbers so that a task added to a wave later does not force a renumber: rule 1 forbids reassignment, so slack
must be **planned rather than found**. `IMPL-442` … `IMPL-499` is this group's own reserve, held for the same reason
`IMPL-324` … `IMPL-399` is held for `PRD-004`.

### 3.3 A known staleness, disclosed rather than corrected

`PRD_LIFECYCLE.md`'s Stage 6 range table ends `| IMPL-227+ | **Unallocated** |`, and
`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` §1.1 line 97 says the same. Both predate `PRD-004`'s allocation of
`IMPL-300` … `IMPL-323`.

**This is an already-recorded condition, not a newly found conflict.** `PRD-004_IMPLEMENTATION_TASKS.md` §7 line 225
states it in its own "not claimed" table: *"That `IMPL-300`…`323` are registered | They are declared in `PRD-004`
§10.7 and here. The roadmap's `IMPL-*` register is **not yet updated**."*

This document therefore treats those two tables as **stale but harmless** — the occupancy enumeration in §3.1, not the
table, is the authority on what is free — and **does not edit them**. Amending `PRD_LIFECYCLE.md` (governance) or
another backlog's allocation table is outside Stage 6 and is explicitly forbidden for this work. Carried forward in §9
rather than fixed silently.

---

## 4. Blocking dependencies outside `PRD-005`

`PRD-005` cannot be fully implemented from its own backlog. These constraints are **inherited, not introduced here**.

| Blocker | Effect on this backlog | Register |
|---|---|---|
| **`BLK-01`** / `TASK-D10` demo surfaces | **Gate 3 is red today** (9 `cross-context` violations; `ADR-0012` expiry 2026-10-31). Any PR in this backlog inherits a red gate 3 until `TASK-D10` lands. **The violations must not be waived to make it green** | [`IMPLEMENTATION_BLOCKER_REGISTER.md`](../IMPLEMENTATION_BLOCKER_REGISTER.md) |
| **`PRD-004`** `BC-01` — `IMPL-300`, `IMPL-301`, `IMPL-311` | **`IMPL-410` cannot complete.** `MM-FR-033` and `MM-BR-028` require a `StudentRecordId` whose `EnrollmentStatus` is `Active`, delivered over `E-01`. `PRD-004` is **frozen** (v1.2) but **unimplemented** — zero `lib/` files exist | `PRD_REGISTRY.md`, `PRD-004_IMPLEMENTATION_TASKS.md` |
| **`PRD-008`** `BC-05` Fee **`PLANNED`** | `E-07` and `E-10` have no owning specification. `IMPL-412` (the payment gate) and `IMPL-430` (`FeeDue` generation) **MUST** be built against the port with a fake, never deferred | `PRD_REGISTRY.md` |
| **`PRD-006`/`PRD-007`** `BC-03`/`BC-04` **`PLANNED`** | The consumers of the `E-02`/`E-03` validity projection are unspecified. `IMPL-432` builds the **producer** side only; the `MM-BR-007` asymmetry cannot be proven end-to-end until they exist | `PRD_REGISTRY.md` |
| **`PRD-023`** `BC-25` Configuration unwritten | `IMPL-407` reads all nine `MM-CFG-*` through `E-19`; the configuration PRD does not exist | `ADR-0017` |
| **`BC-18`** Authorisation, **`BC-21`** Entitlement | `IMPL-436` consumes `BC-18`'s decisions and never defines a role (`MM-XC-016`); `E-17` is called before mutation. Both are **ports** here, never implementations | BC Map §7 |
| **`MM-GAP-001`**, `MM-GAP-002`, `MM-GAP-005`, `MM-GAP-010`, `MM-GAP-010a` | Five open questions. **No task implements any of them** — see §8. `MM-FR-111` requires the *absence* of a grace period, which `IMPL-425` proves as a negative | `PRD-005` §25.2 |

> **Consequence, stated rather than buried.** `BC-02` sits between a frozen-but-unbuilt upstream (`BC-01`) and three
> `PLANNED` downstreams (`BC-03`, `BC-04`, `BC-05`). **Waves 1–3 are buildable today.** The integration halves of
> waves 4–5 are buildable **against ports with fakes**, which is precisely what `IMPL-428` exists to make possible. A
> membership module shipped before `PRD-008` would generate no dues and could not activate on payment. That is a
> scheduling fact, not a defect in this backlog.

---

## 5. The 42 tasks

Column meanings, fixed once. **Requirements** cites the `MM-*` obligations the task must satisfy — this is the Stage 6
gate and no cell may be empty. **Blocked by** and **Blocks** record allocation rule 3's two directions and are checked
against each other mechanically; a forward edge into a *foreign* backlog appears in prose, not in `Blocks`, because
another backlog's rows cannot be edited from here. **Priority** is `P1` (nothing else can proceed without it), `P2`
(needed for a coherent V1) or `P3` (required by the PRD but not on any other task's path).

`MM-AC-*` do not appear in Requirements cells. An acceptance criterion is **verified by** a task's test, not
**implemented by** a task; §6 maps them separately, and `IMPL-441` is the task that proves the whole set runs.

### 5.1 Wave 1 — Plan aggregate, mutability and configurables (`IMPL-400` … `IMPL-409`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-400` | Bounded-context skeleton and ownership boundary for `BC-02` — the module itself, its public surface, and the rule that no student or money field enters it | `domain/library` | P1 | — | `IMPL-401`, `IMPL-402`, `IMPL-410`, `IMPL-428` | `MM-FR-001`, `MM-FR-002`, `MM-FR-003`, `MM-FR-004`, `MM-FR-005` | Structural: the three concepts are distinct types; no `BC-01`/`BC-10` field is representable |
| `IMPL-401` | `MembershipPlan` aggregate root, identity and version | `domain/library` | P1 | `IMPL-400` | `IMPL-403`, `IMPL-404`, `IMPL-406`, `IMPL-408` | `MM-FR-006`, `MM-FR-007`, `MM-BR-022` | Unit: `planId`/`tenantId`/`branchId` immutable; `version` increments on every edit |
| `IMPL-402` | Tenant and branch scoping primitives for this module — ambient `TenantContext`, never a parameter | `platform/tenancy` | P1 | `IMPL-400` | `IMPL-403`, `IMPL-426`, `IMPL-435` | `MM-BR-027`, `MM-INV-007`, `MM-NFR-002` | `tenantId` is not accepted as a domain-method parameter — compile-level, not convention |
| `IMPL-403` | Plan fields with validation and typed rejection | `domain/library` | P1 | `IMPL-401`, `IMPL-402` | `IMPL-404`, `IMPL-405`, `IMPL-409` | `MM-FR-008`, `MM-FR-009`, `MM-FR-010`, `MM-FR-011`, `MM-FR-012`, `MM-FR-013`, `MM-FR-014`, `MM-FR-015` | Unit: each field's validation rejects with a typed error naming the field |
| `IMPL-404` | Plan eligibility rules — deliberately minimal, no invented criteria | `domain/library` | P2 | `IMPL-401`, `IMPL-403` | `IMPL-411` | `MM-FR-016`, `MM-FR-017` | Only the two specified rules exist; a third is not silently added |
| `IMPL-405` | Plan lifecycle — activate, deactivate, and the committed-membership guarantee | `domain/library` | P1 | `IMPL-403` | `IMPL-406`, `IMPL-411`, `IMPL-437` | `MM-FR-018`, `MM-FR-019`, `MM-FR-020`, `MM-FR-021`, `MM-BR-029` | Deactivating a plan leaves committed memberships untouched (`MM-FR-019`); an inactive plan is unselectable |
| `IMPL-406` | Post-use mutability enforcement — what may and may not change once a plan is in use | `domain/library` | P1 | `IMPL-401`, `IMPL-405` | `IMPL-408` | `MM-FR-022`, `MM-FR-023`, `MM-FR-024`, `MM-FR-025` | Attempting a forbidden edit on an in-use plan fails; a permitted edit succeeds and bumps `version` |
| `IMPL-407` | The nine `MM-CFG-*` configurables read through `E-19` with typed accessors | `platform/services` | P1 | — | `IMPL-408`, `IMPL-415`, `IMPL-424`, `IMPL-433` | `MM-CFG-001`, `MM-CFG-002`, `MM-CFG-003`, `MM-CFG-004`, `MM-CFG-005`, `MM-CFG-006`, `MM-CFG-007`, `MM-CFG-008`, `MM-CFG-009`, `MM-BR-026` | No raw string lookup anywhere; `MM-CFG-008` resolves to **one** value shared by `MM-EVT-006` and the expiring view |
| `IMPL-408` | Price-snapshot integrity — the snapshot and `planVersionAtPurchase` taken together | `domain/library` | P1 | `IMPL-401`, `IMPL-406`, `IMPL-407` | `IMPL-410`, `IMPL-421` | `MM-FR-026`, `MM-FR-027`, `MM-FR-028`, `MM-INV-006`, `MM-BR-033` | Historical pricing cannot change; amount and version always agree |
| `IMPL-409` | Plan listing, search and validation surface | `app` | P3 | `IMPL-403` | `IMPL-434` | `MM-FR-029`, `MM-FR-030`, `MM-FR-031`, `MM-FR-032`, `MM-BR-009` | Listing does **not** produce to `BC-23` (`MM-BR-009`); every validation failure is typed |

**`IMPL-400` is the task that makes `MM-FR-003` structural rather than aspirational.** `MM-XC-001` forbids storing or
mutating any student profile field. A test that checks "we did not store a name" passes vacuously; the test that
matters proves such a field is **not representable** in the aggregate at all.

**`IMPL-407` is unusually load-bearing for a configuration task.** `MM-BR-026` requires `MM-CFG-008` to be the *single*
threshold used by both the expiring-soon event and the expiring-soon view, *"so the reminder and the list can never
disagree."* Two independently-read configurables that happen to hold the same default would pass a naive test and fail
`MM-BR-026`. The test must prove **one source**, not two equal values.

**`IMPL-408` cannot be split from `IMPL-406`.** `MM-FR-027` and `MM-INV-006` make the snapshot immutable, but §15
requires the snapshot to be taken *inside the committing transaction together with* `planVersionAtPurchase`. A price
read before the transaction and a version read inside it can disagree under a concurrent plan edit.

### 5.2 Wave 2 — Creation, activation and the term calculus (`IMPL-410` … `IMPL-419`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-410` | `Membership` aggregate root, transaction boundary and field set | `domain/library` | P1 | `IMPL-400`, `IMPL-408` | `IMPL-411`, `IMPL-412`, `IMPL-413`, `IMPL-420`, `IMPL-426` | `MM-BR-020`, `MM-BR-021`, `MM-INV-010`, `MM-FR-036`, `MM-FR-037` | One membership, one transaction; no `BC-01`/`BC-03`/`BC-04`/ledger field present; exactly one plan reference, never zero |
| `IMPL-411` | Creation preconditions — active enrollment over `E-01`, selectable plan | `domain/library` | P1 | `IMPL-404`, `IMPL-405`, `IMPL-410` | `IMPL-413`, `IMPL-414` | `MM-FR-033`, `MM-FR-034`, `MM-FR-035`, `MM-BR-028`, `MM-BR-013` | Creation refused when enrollment is not `Active`; **fails closed** when the `E-01` stream is unavailable, and when `BC-21` times out |
| `IMPL-412` | Payment-gate split — this module never touches money | `domain/library` | P1 | `IMPL-410` | `IMPL-415`, `IMPL-430` | `MM-BR-001`, `MM-BR-002`, `MM-BR-003`, `MM-FR-041`, `MM-FR-042` | No gateway call, no ledger write, no credential; the split is provable by inspection |
| `IMPL-413` | Creation outputs and initial status | `domain/library` | P1 | `IMPL-410`, `IMPL-411` | `IMPL-414`, `IMPL-415`, `IMPL-429` | `MM-FR-038`, `MM-FR-039`, `MM-FR-040`, `MM-FR-043`, `MM-FR-044` | Initial status is `PendingPayment` or `Active` per the payment dependency, never invented |
| `IMPL-414` | Duplicate prevention and idempotency, enforced by the database | `platform/data` | P1 | `IMPL-411`, `IMPL-413` | `IMPL-416`, `IMPL-423`, `IMPL-437` | `MM-FR-045`, `MM-FR-046`, `MM-FR-047`, `MM-FR-048`, `MM-FR-049`, `MM-INV-001`, `MM-INV-008` | **Concurrent** creations for one student: exactly one succeeds, decided by the constraint — not by a read-check |
| `IMPL-415` | Activation conditions, including manual activation and the auto-void window | `domain/library` | P1 | `IMPL-407`, `IMPL-412`, `IMPL-413` | `IMPL-416`, `IMPL-417`, `IMPL-421`, `IMPL-431` | `MM-FR-052`, `MM-FR-053`, `MM-FR-054`, `MM-INV-011` | `activatedAt` set **if and only if** ever `Active`; `MM-CFG-007` voids a stale `PendingPayment` |
| `IMPL-416` | Creation and activation failure handling — deterministic outcomes | `domain/library` | P2 | `IMPL-414`, `IMPL-415` | `IMPL-430` | `MM-FR-050`, `MM-FR-051`, `MM-BR-004`, `MM-BR-005` | Every failure path yields a typed error and a reconciliation-queue entry where §10.2 requires one |
| `IMPL-417` | Term semantics — the meaning of `startDate` and `endDate` | `domain/library` | P1 | `IMPL-415` | `IMPL-418` | `MM-FR-055`, `MM-FR-056` | `endDate` is inclusive; the term is a date range, not a timestamp range |
| `IMPL-418` | Deterministic end-date calculation, including the delayed-payment re-derivation | `domain/library` | P1 | `IMPL-417` | `IMPL-419`, `IMPL-422` | `MM-FR-057`, `MM-FR-057a`, `MM-FR-058`, `MM-FR-059`, `MM-FR-060`, `MM-INV-002` | Month-end and leap-day cases fixed by table; `MM-CFG-009` `true` re-derives the **whole** term; `endDate >= startDate` always |
| `IMPL-419` | Timezone and day-boundary rules | `domain/library` | P1 | `IMPL-418` | `IMPL-424`, `IMPL-425` | `MM-FR-061`, `MM-FR-062`, `MM-FR-063`, `MM-FR-064` | Boundary tests at 23:59:59 and 00:00:00 tenant-local; UTC storage, tenant-local evaluation |

**`IMPL-414` is deliberately adversarial, and for a documented reason.** `MM-FR-046` and §15's first row require the
overlap and idempotency guarantees to be enforced *at the database level*, and §14.2 says so explicitly: enforced *"by
database constraints rather than application checks."* An application-level pre-check passes every single-threaded test
and fails in production under two reception terminals. **The test must run concurrent commands.**

**`IMPL-411` must fail closed, which is the opposite of the intuitive default.** `MM-BR-013`: if the `E-01` stream is
unavailable, creation **MUST** fail rather than assume an active enrollment, because membership creation is a paid
gate under `Q-03`. A cache-tolerant read that "assumes still enrolled" is the revenue-leak failure mode.

**`IMPL-418` carries `MM-FR-057a`, the requirement most likely to be dropped.** It is the delayed-payment case: when
`MM-CFG-009` is `true`, activation re-derives **`startDate` *and* `endDate`**, not just the start. Re-deriving only
`startDate` leaves a term shorter than the plan sold, and it is a silent error — the membership looks valid.

### 5.3 Wave 3 — Status machine, renewal, upgrade, expiry, persistence (`IMPL-420` … `IMPL-427`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-420` | The six-value status set and the closed transition machine | `domain/library` | P1 | `IMPL-410` | `IMPL-421`, `IMPL-422`, `IMPL-423`, `IMPL-431` | `MM-FR-072`, `MM-FR-073`, `MM-FR-074`, `MM-FR-075`, `MM-INV-003`, `MM-INV-009`, `MM-INV-012` | A seventh status is unrepresentable; `Expired`/`Superseded`/`Cancelled` terminal; **`Frozen` unreachable** (`MM-INV-012`) |
| `IMPL-421` | The authoritative validity rule and entitlement derivation | `domain/library` | P1 | `IMPL-408`, `IMPL-415`, `IMPL-420` | `IMPL-424`, `IMPL-425`, `IMPL-432` | `MM-FR-065`, `MM-FR-066`, `MM-FR-067`, `MM-FR-068`, `MM-INV-004`, `MM-BR-031`, `MM-BR-032` | Exactly **one** validity answer per membership per date (`MM-BR-031`); the five non-active statuses confer nothing |
| `IMPL-422` | Membership status vs student status — two independent machines | `domain/library` | P2 | `IMPL-418`, `IMPL-420` | `IMPL-434` | `MM-FR-069`, `MM-FR-070`, `MM-FR-071`, `MM-FR-076`, `MM-FR-077` | Changing student status does not change membership status, and the converse |
| `IMPL-423` | Void before activation — not a cancellation | `domain/library` | P2 | `IMPL-414`, `IMPL-420` | `IMPL-431`, `IMPL-436` | `MM-FR-078`, `MM-FR-079` | `voidReason`/`voidedBy` required; a voided pre-activation membership frees the `MM-INV-001` slot |
| `IMPL-424` | Renewal — eligibility, new membership, the three boundary cases | `domain/library` | P1 | `IMPL-407`, `IMPL-419`, `IMPL-421` | `IMPL-425`, `IMPL-427`, `IMPL-431` | `MM-FR-080`, `MM-FR-081`, `MM-FR-082`, `MM-FR-083`, `MM-FR-084`, `MM-FR-085`, `MM-FR-086`, `MM-FR-087`, `MM-FR-088`, `MM-BR-034`, `MM-INV-001` | Renewal creates a **new** membership; before/on/after-expiry start dates fixed by §6.3; **no overlap** |
| `IMPL-425` | Expiry rule, detection job, and post-expiry entitlement with **no grace period** | `domain/library` | P1 | `IMPL-419`, `IMPL-421`, `IMPL-424` | `IMPL-431`, `IMPL-433` | `MM-FR-103`, `MM-FR-104`, `MM-FR-105`, `MM-FR-106`, `MM-FR-107`, `MM-FR-108`, `MM-FR-109`, `MM-FR-110`, `MM-FR-111`, `MM-FR-112`, `MM-NFR-012` | Validity correct **when the job has not run** (`MM-FR-107`, `MM-NFR-012`); a grace period is **absent**, proven as a negative |
| `IMPL-426` | Persistence rules — tenant key, no hard delete | `platform/data` | P1 | `IMPL-402`, `IMPL-410` | `IMPL-427`, `IMPL-432`, `IMPL-435` | `MM-BR-023`, `MM-BR-024`, `MM-BR-025` | Schema scan: `tenantId` in every primary/unique key; no delete path exists |
| `IMPL-427` | Upgrade — supersession, lineage and the at-most-one-successor rule | `domain/library` | P1 | `IMPL-424`, `IMPL-426` | `IMPL-431`, `IMPL-437` | `MM-FR-093`, `MM-FR-094`, `MM-FR-095`, `MM-FR-096`, `MM-FR-097`, `MM-FR-098`, `MM-FR-099`, `MM-FR-100`, `MM-FR-101`, `MM-FR-102`, `MM-INV-005` | Source becomes `Superseded`; **at most one** renewal successor and one upgrade successor (`MM-INV-005`); no proration executed as money |

**`IMPL-425` must prove two negatives, which is why it is one task and not three.** `MM-FR-111` requires V1 **not** to
implement a grace period, and `MM-FR-112` requires seat reclamation to be `BC-04`'s decision. Both are satisfied by
absence, and absence is only demonstrable by a test that asserts entitlement ends **exactly** at `endDate` and that no
seat-release timing is specified here. `MM-GAP-001` records why: BC Map `Q-01` is an **open question** whose
recommendation is not a decision, and implementing a grace period now would invent one — possibly the wrong one.

**`MM-NFR-012` is the requirement that makes the expiry job non-authoritative.** Validity must remain correct when the
job has not run, so the *read rule* decides and the job merely materialises. A design in which `status = Expired` is the
source of truth fails this: a membership whose term ended an hour before the nightly job would still grant a seat.

**`IMPL-424` and `IMPL-427` both touch `MM-INV-001` and must not be merged.** §15 requires a *simultaneous* renewal and
upgrade of the same source to be serialised by `version`, with the loser failing on a stale-version conflict and
**neither committing twice**. Two separate tasks with one shared concurrency test (`IMPL-437`) is the only arrangement
in which that row is provable.

### 5.4 Wave 4 — Edges, events, projection and operational views (`IMPL-428` … `IMPL-434`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-428` | The ten declared integration edges as ports, and the closed edge set | `domain/library` | P1 | `IMPL-400` | `IMPL-429`, `IMPL-430`, `IMPL-432` | `MM-BR-006`, `MM-BR-007`, `MM-BR-008`, `MM-BR-010`, `MM-BR-011`, `MM-XC-002` | An eleventh edge is not constructible; **no** `BC-06` consumption (`MM-BR-008`); no write to `BC-01`/`BC-03`/`BC-04`/`BC-05` |
| `IMPL-429` | The seven-event closed register with the common payload contract | `platform/event` | P1 | `IMPL-413`, `IMPL-428` | `IMPL-430`, `IMPL-431`, `IMPL-438` | `MM-EVT-001`, `MM-EVT-002`, `MM-EVT-003`, `MM-EVT-004`, `MM-EVT-005`, `MM-EVT-006`, `MM-EVT-007`, `MM-BR-014`, `MM-BR-015`, `MM-BR-016`, `MM-BR-035` | Naming convention enforced; **no mobile number, name, email or photo** in any payload (`MM-BR-015`); an eighth event fails the build |
| `IMPL-430` | Producer-side transactional outbox with at-least-once delivery and per-membership ordering | `platform/event` | P1 | `IMPL-412`, `IMPL-416`, `IMPL-428`, `IMPL-429` | `IMPL-431`, `IMPL-439` | `MM-BR-017`, `MM-BR-018`, `MM-BR-019`, `MM-XC-005` | **Commit-without-publish is impossible**, not merely unlikely; `sequence` monotonic per `membershipId`; this module sends no message itself |
| `IMPL-431` | Event emission wired to every lifecycle transition | `domain/library` | P1 | `IMPL-415`, `IMPL-420`, `IMPL-423`, `IMPL-424`, `IMPL-425`, `IMPL-427`, `IMPL-429`, `IMPL-430` | `IMPL-441` | `MM-FR-089`, `MM-FR-090`, `MM-FR-091`, `MM-FR-092` | Renewal idempotency and the "existing successor" error path both emit correctly; a double-tap yields **one** event |
| `IMPL-432` | The `MembershipValidity` read projection published over `E-02`/`E-03` | `app` | P1 | `IMPL-421`, `IMPL-426`, `IMPL-428` | `IMPL-433`, `IMPL-434`, `IMPL-440` | `MM-BR-012`, `MM-FR-113`, `MM-FR-114`, `MM-NFR-011` | Bounded staleness **< 5s** (`MM-BR-012`); fast enough for the seat-assignment path; composed outside `domain/` |
| `IMPL-433` | The four required operational views | `app` | P2 | `IMPL-407`, `IMPL-425`, `IMPL-432` | `IMPL-434` | `MM-FR-115`, `MM-FR-116`, `MM-FR-117`, `MM-FR-118`, `MM-BR-030`, `MM-XC-006` | Views are operational counts only — **no** churn, retention, cohort or forecast (`MM-XC-006`); no analytics store |
| `IMPL-434` | Dashboard consumption and the student-facing surface | `app` | P3 | `IMPL-409`, `IMPL-422`, `IMPL-432`, `IMPL-433` | `IMPL-436` | `MM-NFR-010`, `MM-XC-013`, `MM-XC-014` | A student sees only their own memberships; no `StaffOnly` plan, no reconciliation state, no other tenant, no cross-library membership |

**All of wave 4's read work is `app`, never `domain/library`.** `AR-1` and `SID-2.41` place a read composition outside
the domain layer, and **gate 3 enforces this mechanically** — a projection built inside `domain/library` is caught by
`tool/check_module_boundaries.dart`, not by review. `MM-BR-011` additionally requires this projection to *supply* the
`PRD-004` Library Member Directory and **not duplicate** it: the Directory composes; this module publishes.

**`IMPL-430` must prove an impossibility, and the obvious test does not.** `MM-BR-017` requires at-least-once delivery
through a transactional outbox. A test that publishes an event and then finds it in the outbox proves nothing about the
failure path. The test must show that a **committed state change with an unpublished event cannot exist** — i.e. that
the outbox write shares the aggregate's transaction.

**`IMPL-429` is where a well-meaning engineer breaks `MM-BR-015`.** Notification consumers want a mobile number, and
`MM-EVT-006` exists to trigger a reminder. `MP-GBR-34` forbids it in the payload; `BC-22` resolves the contact itself.
The event is *"a fact, not a command."*

### 5.5 Wave 5 — Security, concurrency, audit, exclusions and acceptance (`IMPL-435` … `IMPL-441`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-435` | Tenant isolation made structurally impossible to omit | `platform/data` | P1 | `IMPL-402`, `IMPL-426` | `IMPL-436`, `IMPL-441` | `MM-NFR-003`, `MM-NFR-004`, `MM-NFR-005`, `MM-XC-014` | `X-13` checker category 12; omitting the tenant predicate is a **compile-or-check-time failure**, not a review catch |
| `IMPL-436` | The eleven protected operations authorised through `BC-18`, with `MM-PO-004` separately grantable | `app` | P1 | `IMPL-423`, `IMPL-434`, `IMPL-435` | `IMPL-441` | `MM-PO-001`, `MM-PO-002`, `MM-PO-003`, `MM-PO-004`, `MM-PO-005`, `MM-PO-006`, `MM-PO-007`, `MM-PO-008`, `MM-PO-009`, `MM-PO-010`, `MM-PO-011`, `MM-NFR-006`, `MM-NFR-007`, `MM-NFR-008`, `MM-XC-016` | Per-operation matrix; authorised **before** any read or mutation; **create does not imply activate** (`MM-NFR-008`); no role defined here |
| `IMPL-437` | The thirteen concurrency scenarios as deterministic outcomes | `domain/library` | P1 | `IMPL-405`, `IMPL-414`, `IMPL-427` | `IMPL-441` | `MM-NFR-001` | Every §15 row is a test; optimistic `version` on all mutations; plan `isActive` re-checked **inside** the committing transaction |
| `IMPL-438` | Audit through `E-20`, fire-and-forget and outbox-backed | `platform/audit` | P2 | `IMPL-429` | `IMPL-441` | `MM-NFR-009`, `MM-BR-024` | Append-only (`X-10`); **never synchronous**; no PII in any audit payload |
| `IMPL-439` | Notification integration as facts only | `platform/event` | P3 | `IMPL-430` | `IMPL-441` | `MM-XC-005`, `MM-XC-003`, `MM-XC-004` | No SMS/push/email/in-app send path exists; no gateway call, credential, ledger, balance, receipt or refund record |
| `IMPL-440` | The eleven remaining exclusions proven impossible, not merely absent | `domain/library` | P1 | `IMPL-432` | `IMPL-441` | `MM-XC-001`, `MM-XC-007`, `MM-XC-008`, `MM-XC-009`, `MM-XC-010`, `MM-XC-011`, `MM-XC-012`, `MM-XC-015`, `MM-BR-021`, `MM-NFR-013` | No auto-renewal code path; downgrade/freeze/transfer/cancel-with-refund unrepresentable; price of an existing membership cannot change silently |
| `IMPL-441` | Acceptance-criteria harness — all 97 `MM-AC-*` bound to executable tests | `test` | P1 | `IMPL-431`, `IMPL-435`, `IMPL-436`, `IMPL-437`, `IMPL-438`, `IMPL-439`, `IMPL-440` | — | `MM-NFR-014` | Every `MM-AC-*` maps to at least one named, running test; an unbound criterion **fails the run** (`MM-NFR-014`) |

**`IMPL-440` is the exclusion task, and its whole difficulty is the word "impossible."** `PRD-005` §1.5 opens with
*"Each is a thing that **MUST be impossible** in a correct V1 build, not merely undone."* A test asserting "no
downgrade endpoint is exposed" is not enough; the type system or the checker must make a downgrade unconstructible.
The three exclusions not listed here are covered where they belong: `MM-XC-002` in `IMPL-428` (edges), `MM-XC-006` in
`IMPL-433` (analytics), `MM-XC-013`/`MM-XC-014` in `IMPL-434`/`IMPL-435` (tenancy).

**`IMPL-441` is the task that makes `MM-NFR-014` real.** `SID-4.56`: *"a rule that cannot be checked SHALL be treated
as unmet, not as satisfied by intent."* This task's failure condition is an `MM-AC-*` with no test bound to it — the
same class of defect that Stage 5's coverage measurement found in the PRD itself, applied to code.

**`IMPL-436` is `app`, not `domain/library`, and that placement is load-bearing.** `MM-XC-016` and `MM-NFR-006` forbid
this module from defining any authorisation model; it consumes `BC-18`'s decisions. An authorisation check written into
`domain/library` would both violate `AR-2` and be caught by gate 3.

---

## 6. Traceability — task group → requirements → invariants → acceptance

Allocation rule 4 requires this table. Coverage figures are produced by
`tool/docs_check/prd005_task_coverage.py`, not counted by hand.

| Wave | Tasks | Requirements claimed | Invariants enforced | Acceptance criteria proven |
|---|---|---|---|---|
| **1** Plan, mutability, configurables | `IMPL-400`–`409` | `MM-FR-001`–`032`, `MM-BR-009`, `MM-BR-022`, `MM-BR-027`, `MM-BR-029`, `MM-BR-033`, all nine `MM-CFG-*`, `MM-BR-026`, `MM-NFR-002` | `MM-INV-006`, `MM-INV-007` | `MM-AC-001`–`014` (plans, snapshot integrity, validation) |
| **2** Creation, activation, term | `IMPL-410`–`419` | `MM-FR-033`–`064`, `MM-BR-001`–`005`, `MM-BR-013`, `MM-BR-020`, `MM-BR-021`, `MM-BR-028` | `MM-INV-001`, `MM-INV-002`, `MM-INV-008`, `MM-INV-010`, `MM-INV-011` | `MM-AC-015`–`038`, plus `MM-AC-074`/`074a`, `MM-AC-076`/`076a` (term boundaries) |
| **3** Status, renewal, upgrade, expiry | `IMPL-420`–`427` | `MM-FR-065`–`110`, `MM-FR-111`, `MM-FR-112`, `MM-BR-023`–`025`, `MM-BR-031`, `MM-BR-032`, `MM-BR-034`, `MM-NFR-012` | `MM-INV-003`, `MM-INV-004`, `MM-INV-005`, `MM-INV-009`, `MM-INV-012` | `MM-AC-039`–`058`, plus `MM-AC-080`/`080a` (renewal/expiry boundaries) |
| **4** Edges, events, projection, views | `IMPL-428`–`434` | `MM-FR-089`–`092`, `MM-FR-113`–`118`, `MM-BR-006`–`008`, `MM-BR-010`–`012`, `MM-BR-014`–`019`, `MM-BR-030`, `MM-BR-035`, all seven `MM-EVT-*`, `MM-NFR-010`, `MM-NFR-011`, `MM-XC-002`, `MM-XC-005`, `MM-XC-006`, `MM-XC-013`, `MM-XC-014` | — *(events and projections carry no aggregate invariant; they publish the result of one)* | `MM-AC-059`–`073` (events, projection staleness, view/threshold agreement) |
| **5** Security, concurrency, audit, exclusions | `IMPL-435`–`441` | All eleven `MM-PO-*`, `MM-NFR-001`, `MM-NFR-003`–`009`, `MM-NFR-013`, `MM-NFR-014`, `MM-BR-024`, `MM-XC-001`, `MM-XC-003`, `MM-XC-004`, `MM-XC-007`–`012`, `MM-XC-015`, `MM-XC-016` | *(re-proves all twelve under concurrency — `IMPL-437`)* | `MM-AC-075`, `MM-AC-077`–`079`, `MM-AC-081`–`094` (isolation, authorisation, exclusions) |

**Mechanically verified totals:**

| Register | Claimed / defined |
|---|---|
| `MM-FR` | **119 / 119** |
| `MM-BR` | **35 / 35** |
| `MM-INV` | **12 / 12** |
| `MM-EVT` | **7 / 7** |
| `MM-XC` | **16 / 16** |
| `MM-NFR` | **14 / 14** |
| `MM-PO` | **11 / 11** |
| `MM-CFG` | **9 / 9** |
| **TOTAL obligations** | **223 / 223 = 100.0%** |

> **Why `MM-AC-*` and `MM-GAP-*` are outside that denominator, stated rather than assumed.** An `MM-AC-*` is a
> criterion *verified by* a task's test, not a thing a task *builds*; `IMPL-441` is the task that proves all 97 are
> bound to running tests. An `MM-GAP-*` is an **open question** — giving one a task would implement an undecided
> matter, which is exactly what §8 forbids. Counting either would inflate coverage while making it mean less.
> `PRD-005`'s 333 identifiers minus 97 `MM-AC-*` minus 13 `MM-GAP-*` = **223**, the figure above.

**The acceptance-criteria column is an allocation, not a proof.** `MM-AC-*` are grouped to the wave whose behaviour
they exercise, so an implementer knows which criteria their wave should make pass. The binding of each individual
criterion to a named test is `IMPL-441`'s deliverable and is **not** claimed as done here.

---

## 7. Critical path — computed, not asserted

Derived from the `Blocked by` column by the same script that checks it, so the claim is reproducible:

```
400 → 401 → 403 → 405 → 406 → 408 → 410 → 411 → 413 → 415
    → 417 → 418 → 419 → 424 → 425 → 433 → 434 → 436 → 441
```

**Longest chain: 19 of 42 tasks.** Graph facts, also computed: **0 cycles**; exactly **two roots** with no local
dependency (`IMPL-400`, `IMPL-407`); exactly **one leaf** (`IMPL-441`). Priorities: **33 × P1, 6 × P2, 3 × P3**.

**Start `IMPL-400` and `IMPL-407` in parallel** — they are the only two tasks with no local predecessor, and `IMPL-407`
(configurables) unblocks four separate branches. `IMPL-400` fans out the widest.

**Do not start `IMPL-433` or `IMPL-434` early to show visible progress.** They are the operational views and dashboards
— the parts a stakeholder can see — and they sit at positions 16 and 17 of the chain. Building them first would require
a validity source that `IMPL-421` has not yet defined, and the shortcut is to read `status` directly, which
**`MM-NFR-012` forbids**: validity must be correct when the expiry job has not run.

**`IMPL-441` cannot be started at all until waves 1–5 land.** It has seven predecessors and is the single leaf. That is
deliberate: an acceptance harness written early tests the code that exists rather than the criteria that were specified.

---

## 8. Tasks that must **not** be created

| Tempting task | Why it must not exist |
|---|---|
| "Add a 24-hour grace period" | **`MM-FR-111`**, `MM-GAP-001`. BC Map `Q-01` is an **open question**; its recommendation is not a decision. `Q-01` also concerns **seat release**, not validity extension — implementing one could invent the wrong rule |
| "Implement membership freeze / unfreeze" | `MM-XC-009`, `MM-INV-012` (`Frozen` unreachable in V1), `MM-GAP-001`. **V2** |
| "Implement downgrade" | `MM-XC-008`. **V2** |
| "Implement proration arithmetic" | `MM-XC-012`, `MM-GAP-002`. `Q-06` is open; money arithmetic is `BC-05`'s |
| "Implement auto-renewal" | `MM-XC-007`. **V3** — *any* code path renewing without an explicit human command |
| "Add a membership analytics store / churn metric" | `MM-XC-006`, `MM-BR-030`, `MP-GBR-37`. `BC-26` learns only from §12 events |
| "Store the student's name/mobile for the expiry SMS" | `MM-XC-001`, `MM-BR-015`, `MP-GBR-34`. `BC-22` resolves the contact; the event is a fact |
| "Add a `membership_payment` or balance table" | `MM-XC-003`, `MM-XC-004`. `BC-05` owns every ledger, receipt and refund |
| "Index memberships into `BC-23` search" | `MM-BR-009`, `MM-GAP-004`. `E-21` names only `BC-01` and `BC-10` |
| "Read `BC-06` Library Policy for term rules" | `MM-BR-008`, `MM-GAP-009`. **No `BC-06` → `BC-02` edge exists** |
| "Add an eighth domain event" | `MM-BR-035`. The register is **closed at seven**; adding one requires a new PRD version, not an implementation |
| "Build a `member_directory` view here" | `MM-BR-011`. This module **supplies** `PRD-004`'s Directory through `E-02`; duplicating it is the `OWN-4` failure |
| "Define a `MembershipManager` role" | `MM-XC-016`, `MM-NFR-006`, `AR-2`. `BC-18` owns the authorisation model |
| "Waive the 9 cross-context violations to green gate 3" | `BLK-01`. Real debt owned by `TASK-D10`, `ADR-0012` expiry 2026-10-31 |

**Fourteen tasks a competent engineer might reasonably add, each mapped to the rule it would break.** They are listed
so that their absence is visible as a **decision** rather than an oversight — the same reason `PRD-004`'s backlog lists
six.

---

## 9. What this document does **not** claim

| Not claimed | Actual state |
|---|---|
| That any task is started | **Zero.** No `lib/` file created or modified |
| That `PRD-005` is frozen | It is **`DRAFT`**. Stage 6 makes it *eligible* for a Stage 7 proposal and nothing more |
| That the registry was updated | `PRD_REGISTRY.md` still records `PRD-005` as **`PLANNED`** and is **byte-identical**. Status is conferred by admission to the baseline, never self-declared |
| That an ADR was created | **None.** No ranked document changed, so `DOCUMENTATION_BASELINE.md` §7 is not triggered |
| That estimates exist | **None is given.** No sizing was requested; inventing one would be noise |
| That 42 tasks complete `BC-02` | They cover `PRD-005` v1.4's **223 obligations**. The **5 open `MM-GAP-*`** remain undecided and unimplemented |
| That the 97 `MM-AC-*` are bound to tests | They are **allocated to waves** in §6. Binding each to a named test is `IMPL-441`'s deliverable |
| That `IMPL-400`…`441` are in the roadmap register | They are declared **here** and nowhere else yet. `IMPLEMENTATION_ROADMAP.md` and `PRD_LIFECYCLE.md`'s Stage 6 table still end at `IMPL-227+` — the same staleness `PRD-004` records at its §7. **Not corrected here** (§3.3) |
| That gate 3 will be green | It is **red** and stays red until `TASK-D10`/`BLK-01` |
| That the upstream exists | `PRD-004` is frozen but **unimplemented**; `PRD-006`/`007`/`008` are `PLANNED`. See §4 |

---

## 10. Definition of done — applies to every task

A task is done when **all** hold. Items 3 and 4 block merge (`TRACEABILITY_MATRIX.md` §10.4).

1. `dart format --set-exit-if-changed .` → exit 0
2. `flutter analyze` → `No issues found!`
3. `dart run tool/check_module_boundaries.dart` → **no new violation** (the 9 existing `TASK-D10` violations are pre-existing and **must not be waived**)
4. `flutter test test/architecture/` → all pass
5. `flutter test` → all pass, **including the task's own new test**
6. The `MM-*` requirements in the task's Requirements cell are each asserted by at least one test
7. No frozen document modified; no integration edge used beyond the ten declared in `MM-BR-006`
8. `python3 tool/docs_check/prd005_task_coverage.py` → exit 0 *(if the task row itself changed)*

> **Item 6 is the one that is usually skipped.** A task can pass items 1–5 while asserting nothing about its
> requirements. `MM-NFR-014` and `SID-4.56` treat such a requirement as **unmet**, not as satisfied by intent.

---

## 11. Stage 6 exit gate — re-runnable

```
python3 tool/docs_check/prd005_task_coverage.py     → exit 0
```

The gate fails if any of the following becomes true: a task has an empty **Requirements** cell; a task cites an `MM-*`
identifier `PRD-005` does not define; an `IMPL-*` is duplicated, falls outside `IMPL-400`…`499`, or collides with
`IMPL-014`–`073` / `100`–`127` / `200`–`226` / `300`–`323`; a **Blocked by** entry names no known task; a **Priority**
cell is blank; **Blocks** and **Blocked by** disagree for a local pair; the dependency graph acquires a cycle; or any
of the **223** obligations loses its last claiming task.

Current result — **PASS**:

```
Tasks parsed 42 · unique 42 · duplicates 0 · out of range 0 · foreign collisions 0
Tasks with no requirement 0 · undefined citations 0 · malformed ranges 0
Unresolvable dependencies 0 · missing Priority 0 · Blocks/Blocked-by disagreements 0
Cycles 0 · longest chain 19
Coverage 223/223 = 100.0%
```

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created as the **Stage 6** gate artefact for `PRD-005` v1.4. Allocated **`IMPL-400` … `IMPL-441`** — 42 tasks in 5 waves — after enumerating every `IMPL-*` in the repository (highest in use `IMPL-323`) rather than reading the roadmap's stale `IMPL-227+` table, and reserved `IMPL-324`–`399` for `PRD-004` growth per allocation rule 2. Records `Priority`, `Blocks` and `Blocked by` per task (rule 3) and the group→requirement→invariant→acceptance table (rule 4). Coverage is **computed, not asserted**: `tool/docs_check/prd005_task_coverage.py` proves **223/223 = 100.0%** of obligations claimed, 0 undefined citations, 0 duplicate or out-of-range IDs, 0 collisions with the four foreign ranges, 0 cycles, and `Blocks`/`Blocked by` mutually consistent; the 19-task critical path is derived from the graph. Two defects the tool caught during authoring were fixed rather than argued away: `MM-BR-013` was described in `IMPL-411`'s prose but absent from its Requirements cell (an untraced obligation — precisely the `SR-01` failure class), and `IMPL-410`'s `Blocks` omitted `IMPL-412`. Lists **14 tasks that must not be created**, each mapped to the rule it would break, and the 5 open `MM-GAP-*` that receive no task. **Nothing is implemented: zero `lib/` files changed, no estimates invented, no specification written, `PRD-005` unmodified and still `DRAFT`, `PRD-004`'s backlog and allocation untouched, no registry entry, no ADR, and no freeze.** |
