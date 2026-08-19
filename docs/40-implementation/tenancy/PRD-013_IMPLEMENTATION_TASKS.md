# `PRD-013` Implementation Tasks — `IMPL-800` … `IMPL-829`

| Field | Value |
|---|---|
| **Document** | Implementation tasks for [`PRD-013_TENANCY.md`](../../30-product/tenancy/PRD-013_TENANCY.md) (`PRD-013`, `BC-19` Tenant) |
| **Version** | v1.0 |
| **Status** | Backlog record. **Not ranked**, therefore editable without an ADR |
| **Date** | 2026-08-19 |
| **Baseline** | `BASELINE-2026-08-17-A` |
| **Purpose** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 6** gate — allocate an `IMPL-*` range and record a task document in which every task traces back to requirements |
| **Subject hash** | `688239cb28c96648addbed4d08081ed2821e867e5873a1f028ae3c49f0f1ba9c` — `PRD-013` v0.1 `DRAFT`, unchanged by this document |
| **Implementation state** | ⚠️ **A PRE-EXISTING PARTIAL SCAFFOLD EXISTS** — `lib/platform/tenancy/tenancy.dart` (85 lines, commit `a44ebb0`). **This document creates and modifies nothing**: zero `lib/` files were written by it. See §4.1, which measures what the scaffold already satisfies and what it contradicts |
| **Source of truth** | `PRD-013` v0.1. Where this file disagrees with it, **the PRD is right and this file is a defect** |
| **Stage** | Stage 6 of 9. `PRD-013` remains **v0.1 `DRAFT`**; this document does **not** freeze it and does **not** advance the registry |

---

## 1. The one thing this document is not

It is **not** evidence of progress, and it is **not** a specification. Thirty well-formed task rows can read like work
completed; they are a plan for work that is at best **partially begun and unverified**. Verified, not asserted:

```
git diff --stat HEAD -- lib/      → (empty)     # this document changed no code
ls lib/platform/tenancy/          → tenancy.dart   (85 lines, commit a44ebb0)
find test -iname '*tenan*'        → (empty)     # zero tests for BC-19
```

**A first draft of this document claimed `lib/platform/tenancy/` did not exist. That claim was false, and it was
caught by running the check rather than by re-reading the sentence.** The correction is recorded here rather than
quietly applied, and §4.1 now measures the scaffold instead of assuming a blank slate. This is the same class of
error the Stage 5 conferral records three times: the instrument, or the assumption, was wrong before the document was.

`PRD-013` `TEN-FR-011` requires that reading unset tenant context **throws** rather than defaulting, and its Rank 1
authority `MP-GBR-07` states that a consumer without tenant context *"fails loudly, never defaults"*. The same standard
applies to a task. Until its test exists and runs, the task is **not done**, however complete its description reads
here. Of `PRD-013`'s 13 acceptance criteria, **0 are proven by a passing test** — `IMPL-829` is the task that would
change that, and it has not been started.

**What this document deliberately does not contain:** no schema, no SQL, no DDL, no API shape, no widget tree, no class
signature and no estimate. Scope cells name **what** must be built and the requirements that govern it, not **how**.

**No `ResidencyRegion` value is named anywhere in this document.** `TEN-GAP-001` records the value set as unenumerated
and `ADR-0041` L214 declines to *"name a period, a statute or a jurisdiction rule"*. `IMPL-808` implements immutability
in a form that is testable **without** any enumeration existing — which is precisely what `TEN-AC-010` requires
(*"whatever value is supplied"*). Inventing a value here would resolve an open gap by implementation choice.

---

## 2. Stage 6 prerequisites — verified, not assumed

`PRD_LIFECYCLE.md` §2: *"A gate is not an opinion — if the artefact does not exist, the stage has not been passed,
however complete the work feels."* Stage 6 is entered only from a satisfied Stage 5.

| Prerequisite | Required artefact | State |
|---|---|---|
| **Stage 3 — Architecture alignment** | An alignment record with a verdict | ✅ **Satisfied** — [`PRD-013_ARCHITECTURE_ALIGNMENT.md`](../../30-product/tenancy/PRD-013_ARCHITECTURE_ALIGNMENT.md), verdict ✅ **ALIGNED**. Its subject hash is **stale**; assessed in [`PRD-013_STAGE5_CONFERRAL.md`](../../30-product/tenancy/PRD-013_STAGE5_CONFERRAL.md) §4 as **not requiring re-alignment**, and deliberately not rewritten |
| **Stage 4 — Requirements review** | Testable, uniquely identified, non-duplicating; conflicts closed or deferred with a reason and an owner | ✅ **Satisfied** — ⚠️ PASS WITH CORRECTIONS → 4 corrections applied → ✅ **STAGE 4 PASS**, 0 findings |
| **Stage 5 — Traceability** | All `TEN-*` prefixes registered in [`TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) §2 with counts and ranges, verified mechanically, zero collisions | ✅ **Satisfied** — §2I of the matrix (v1.13): eight registers, **51** in force / **63** declared, collisions **0** in both directions. Conferred by [`PRD-013_STAGE5_CONFERRAL.md`](../../30-product/tenancy/PRD-013_STAGE5_CONFERRAL.md); two independent checkers exit 0 |
| **Stage 6 — this document** | `IMPL-*` range allocated + every task traces to requirements | ✅ This file, mechanically checked by [`tool/docs_check/prd013_task_coverage.py`](../../../tool/docs_check/prd013_task_coverage.py) |
| **Stage 7 — Freeze** | A row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank | ⛔ **Not attempted here.** Out of scope for Stage 6 |

> **Stage 6 does not confer freeze.** Completing this gate makes `PRD-013` *eligible* for a Stage 7 proposal; it does
> not perform one, and this document creates no ADR and edits no registry. `PRD_LIFECYCLE.md` §7: *"No fast path.
> Stage 7 is not skippable."* `PRD_REGISTRY.md` still records `PRD-013` as **`PLANNED`** and is byte-identical.

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
  100-115 120-128 199-217 220-227 299-324 399-442 450
  499-680 699-790 799
  418 distinct numbers · highest 799

grep -rlE 'IMPL-8[0-9]{2}' docs/ tool/ lib/ test/ | wc -l
→ 0        # the entire IMPL-8xx decade is unreferenced
```

**`IMPL-800` is therefore the next free number, and `IMPL-800`…`IMPL-899` the next free block.** `IMPL-700`…`799`
belongs to `PRD-008` Revenue & Finance (83 tasks, admitted by `ADR-0049`), so beginning at `800` leaves that group the
whole remainder of its own decade band and satisfies rule 2. **Nothing below `800` is touched, reused or reassigned.**

### 3.2 The allocation table

| Range | Owner | Grouping |
|---|---|---|
| `IMPL-014` … `IMPL-073` | Authentication, platform, release readiness | [`IMPLEMENTATION_ROADMAP.md`](../IMPLEMENTATION_ROADMAP.md) |
| `IMPL-100` … `IMPL-127` | Library Management | [`LIBRARY_IMPLEMENTATION_TASKS.md`](../LIBRARY_IMPLEMENTATION_TASKS.md) |
| `IMPL-128` … `IMPL-199` | Reserved for Library Management growth | — |
| `IMPL-200` … `IMPL-226` | Student Identity | [`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md`](../STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md) |
| `IMPL-227` … `IMPL-299` | Student Identity growth — **partly consumed**, contrary to `PRD_LIFECYCLE.md`'s table (§3.3) | — |
| `IMPL-300` … `IMPL-323` | Student Management (`PRD-004`, `BC-01`) | `PRD-004_IMPLEMENTATION_TASKS.md` |
| `IMPL-324` … `IMPL-399` | Reserved for Student Management growth | — |
| `IMPL-400` … `IMPL-441` | Membership Management (`PRD-005`, `BC-02`) | `PRD-005_IMPLEMENTATION_TASKS.md` |
| `IMPL-442` … `IMPL-499` | `PRD-005`'s declared growth reserve | — |
| `IMPL-500` … `IMPL-599` | Seat Management (`PRD-007`, `BC-04`) | [`PRD-007_IMPLEMENTATION_TASKS.md`](../seat-management/PRD-007_IMPLEMENTATION_TASKS.md) |
| `IMPL-600` … `IMPL-699` | Attendance / integration backlogs | — |
| `IMPL-700` … `IMPL-799` | Revenue & Finance (`PRD-008`, `BC-06`) — 83 tasks, `ADR-0049` | `PRD-008_IMPLEMENTATION_TASKS.md` |
| **`IMPL-800` … `IMPL-809`** | **Wave 1 — Ownership boundary, the `Tenant` aggregate, value objects, invariants** | This document |
| **`IMPL-810` … `IMPL-819`** | **Wave 2 — Tenant context: declaration, propagation, enforcement, partitioning** | This document |
| **`IMPL-820` … `IMPL-829`** | **Wave 3 — Exclusions, the closed event surface, isolation, acceptance harness** | This document |
| `IMPL-830` … `IMPL-899` | **Reserved for `PRD-013` growth** — 4 open `TEN-GAP-*` may require tasks | This document, unallocated |
| `IMPL-900` + | Unallocated | — |

**30 tasks, `IMPL-800` … `IMPL-829`, contiguous with no gaps inside the allocated span.** Wave boundaries fall on
round tens so that a task added to a wave later does not force a renumber: rule 1 forbids reassignment, so slack must
be **planned rather than found**. `IMPL-830`…`899` is declared as this module's growth reserve because `PRD-013`'s four
`TEN-GAP-*` are genuinely open — if `TEN-GAP-001` is ever resolved by an enumerated `ResidencyRegion` set, that work
takes `IMPL-830`+ rather than a number inside a wave.

### 3.3 A known staleness, disclosed rather than corrected

`PRD_LIFECYCLE.md`'s Stage 6 range table ends `| IMPL-227+ | **Unallocated** |`. The enumeration above shows
`IMPL-227` is **occupied**, and `ADR-0049` has already recorded this. Trusting that table would violate allocation
rule 1 by reassigning a live number.

**This is an already-recorded condition, not a newly found conflict.** `PRD-005`'s and `PRD-007`'s backlogs record it
in their own §3.3, stating the rule this document follows: *"the occupancy enumeration in §3.1, not the table, is the
authority on what is free."*

This document therefore treats that table as **stale but harmless** and **does not edit it**. Amending
`PRD_LIFECYCLE.md` is outside Stage 6 and is explicitly forbidden for this work. Carried forward in §9 rather than
fixed silently.

---

## 4. Blocking dependencies outside `PRD-013`

| Dependency | Owner | Effect on this backlog |
|---|---|---|
| `TenantId` as an R0 contract | `liboora_contracts` | `IMPL-805` consumes it. `TEN-FR-008` requires the existing declaration; **no new contract is created here** |
| `TenantContext` interface location | `liboora_contracts` | `IMPL-810` declares it there per `TEN-FR-013`. This is the one task whose module is **not** `platform/tenancy` |
| `TenantOrganisation`, `StaffAssignment` | **`PRD-002`** | Excluded, never implemented here (`IMPL-820`, `IMPL-821`) |
| Authorisation decisions | **`BC-18`** | Excluded (`IMPL-822`). `X-13` and `ID-1` are never waived |
| `Subscription` and billing state | **`BC-20`** | Excluded (`IMPL-825`) |
| Entitlement outputs | **`BC-21`** | Excluded (`IMPL-822`) |
| Tenant lifecycle state machine | **`PRD-002`**, frozen `LIB-8.1`…`8.8` | Excluded (`IMPL-826`). The module stores the value and defines no machine |
| Transactional Outbox | Platform | `IMPL-827` writes both events through it, in the same transaction as the aggregate mutation |

**No task in this document is blocked by an unfrozen decision.** Every external dependency is either an existing R0
contract or an exclusion — and an exclusion needs nothing from its owner in order to be enforced.

### 4.1 The pre-existing scaffold — measured, not assumed

`lib/platform/tenancy/tenancy.dart` was created by commit `a44ebb0` (*"feat(scaffold): Liboora modular monolith"*),
**before `PRD-013` was written**. It is 85 lines and declares `TenantTier`, `Tenant`, `Branch` and
`MutableTenantContext`. `packages/liboora_contracts/lib/src/ports/tenant_context.dart` declares the `TenantContext`
interface, and `.../identifiers.dart` declares `TenantId`.

**This changes what the tasks are, and it is measured rather than described.** Each row below was produced by grepping
the code, not by reading the file:

| Obligation | Scaffold state | Effect on the task |
|---|---|---|
| `TEN-FR-008` `TenantId` from R0, not redeclared | ✅ `grep -c 'class TenantId' lib/platform/tenancy/tenancy.dart` → **0**; resolves to `liboora_contracts` | `IMPL-805` **verifies** rather than creates |
| `TEN-FR-013` `TenantContext` declared in `liboora_contracts` | ✅ present at `src/ports/tenant_context.dart`, R0, no exported setter on the interface | `IMPL-810` **verifies** rather than creates |
| `TEN-FR-011` unset read throws, never defaults | ✅ two `throw const TenantContextMissing()` sites; the file's own comment: *"never default. A silent default is how cross-tenant leaks happen"* | `IMPL-812` **verifies**; the test is still absent |
| `TEN-FR-015` never a domain method parameter | ✅ the R0 doc comment states the constraint | `IMPL-814` **verifies** |
| `TEN-FR-004` `Tenant` the only aggregate root | ⚠️ **`Branch` is also declared here**, and Bounded Context Map L210 assigns `Branch` to **`BC-06`**, not `BC-19` | `IMPL-801` must **remove or relocate** `Branch`, not merely add a type. Recorded as `D-013-01` |
| `TEN-FR-005` the four value objects | ⚠️ only `TenantTier` exists. `Quota`, `ResidencyRegion` and `TenantLifecycleState` are **absent repo-wide** | `IMPL-802` creates three of four |
| `TEN-FR-009` no reliance on `TenantTier` in R0 | ✅ `TenantTier` is declared **locally**, not in `liboora_contracts` — exactly what the requirement demands | `IMPL-806` **verifies** |
| `TEN-FR-014` async-scoped context | ❌ `grep -cE 'Zone|runZoned|AsyncLocal'` → **0**. `MutableTenantContext` holds four plain mutable fields; concurrent requests **would** observe each other | `IMPL-813` is a **real rewrite**, not a check. Recorded as `D-013-02` |
| `TEN-BR-001` suspended tenant rejects all writes | ❌ `Tenant.suspended` is stored; **nothing reads it**. `grep -rn '\.suspended' lib/` finds no enforcement in this module | `IMPL-818` enforces a field that exists but is inert |
| `TEN-FR-018` `tenant_id` on every row | ❌ 0 occurrences in the module | `IMPL-815` unstarted |
| `TEN-FR-019`/`020` key, index, namespace partitioning | ❌ 0 occurrences | `IMPL-816`, `IMPL-817` unstarted |
| `TEN-EVT-001`/`002`, `TEN-FR-021` | ❌ `grep -rn 'TenantProvisioned\|TenantSuspended' lib/` → **0 hits repo-wide** | `IMPL-827`, `IMPL-828` unstarted |
| `TEN-XC-001`, `TEN-XC-002` | ✅ 0 occurrences of `TenantOrganisation` or `StaffAssignment` in the module | `IMPL-820`, `IMPL-821` **verify** — currently **vacuously** satisfied |
| `TEN-XC-003`/`004`/`005`/`006` | ✅ `EntitlementSet`, `FeatureGate`, `UsageCounter`, `Limit` absent repo-wide; no credential or subscription type here | `IMPL-822`…`825` **verify** — vacuously satisfied |
| `TEN-XC-008` no lifecycle state machine | ✅ absent — but so is `TenantLifecycleState`, the value the module is *required* to store | `IMPL-826` verifies the absence; `IMPL-802` supplies the value |
| All 13 `TEN-AC-*` | ❌ **0 tests exist.** `find test -iname '*tenan*'` → empty | `IMPL-829` unstarted |

**Two genuine contradictions between the scaffold and `PRD-013`, recorded not resolved:**

| ID | Finding | Disposition |
|---|---|---|
| **`D-013-01`** | `Branch` is declared in `platform/tenancy` while Bounded Context Map L210 assigns it to `BC-06`. `TEN-FR-004` makes `Tenant` the module's only aggregate root and `TEN-FR-003` forbids owning *"any tenant-facing business record beyond `Tenant`"* | **Not fixed here.** Moving a type across a bounded-context boundary is an ownership change; `PRD_LIFECYCLE.md` Stage 7's table routes an *"Ownership/boundary change"* to an **ADR**. `IMPL-801` carries it; the Architecture Reviewer owns the ruling. Editing `lib/` from a Stage 6 backlog would be implementing, which Stage 6 does not authorise |
| **`D-013-02`** | `MutableTenantContext` is **not** async-scoped, contradicting `TEN-FR-014` and making `TEN-AC-002` currently **false** | **Not fixed here**, for the same reason. `IMPL-813` carries it. It is a P1 on the critical path, which is the correct consequence |

> **Why these two are findings and not defects in `PRD-013`.** The PRD post-dates the scaffold and was reviewed against
> the architecture, not against the code. `PRD-013` is the **Rank 3 requirement**; the scaffold is code written before
> it. Where they disagree, the code is wrong and the task is what makes it right. Recording the reverse — amending
> `TEN-FR-014` to match a non-async implementation — would be letting the implementation write the requirement.

---

## 5. The 30 tasks

Column meanings, fixed once. **Requirements** cites the `TEN-*` obligations the task must satisfy — this is the
Stage 6 gate and no cell may be empty. **Blocked by** and **Blocks** record allocation rule 3's two directions and are
checked against each other mechanically. **Priority** is `P1` (nothing else can proceed without it), `P2` (needed for
a coherent V1) or `P3` (required by the PRD but not on any other task's path).

`TEN-AC-*` do not appear in Requirements cells. An acceptance criterion is **verified by** a task's test, not
**implemented by** a task; §6 maps them separately, and `IMPL-829` is the task that proves the whole set of 13 runs.
`TEN-GAP-*` do not appear either: they are **open questions**, and citing one as verifiable would resolve it by
implementation choice. Where a task's *Test requirement* names a `TEN-AC-*` or a `TEN-GAP-*`, it does so to record
which criterion observes the task, or which gap it must leave untouched — not as a claimed obligation.

### 5.1 Wave 1 — Ownership boundary, the `Tenant` aggregate, value objects, invariants (`IMPL-800` … `IMPL-809`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-800` | Bounded-context skeleton for `BC-19` Tenant under `platform/tenancy`, and the two ownership rights — the `Tenant` aggregate and tenant-context propagation — with no tenant-facing business record beyond `Tenant` | `platform/tenancy` | P1 | — | `IMPL-801`, `IMPL-802`, `IMPL-803`, `IMPL-809`, `IMPL-820`, `IMPL-821`, `IMPL-824`, `IMPL-825` | `TEN-FR-001`, `TEN-FR-003` | Structural: no tenant-facing business record other than `Tenant` is representable in this module |
| `IMPL-801` | `Tenant` as the module's only aggregate root | `platform/tenancy` | P1 | `IMPL-800` | `IMPL-804`, `IMPL-805`, `IMPL-806`, `IMPL-818`, `IMPL-827` | `TEN-FR-004` | A second aggregate root is not constructible in this module — compile-level, not convention |
| `IMPL-802` | The four value objects `TenantTier`, `Quota`, `ResidencyRegion`, `TenantLifecycleState` carried by `Tenant` | `platform/tenancy` | P1 | `IMPL-800` | `IMPL-803`, `IMPL-806`, `IMPL-807`, `IMPL-808`, `IMPL-815`, `IMPL-826` | `TEN-FR-005` | All four are value objects of `Tenant`; none is an entity and none is independently persisted |
| `IMPL-803` | `TenantTier` and `Quota` as **inputs** to entitlement derivation, never derived outputs | `platform/tenancy` | P1 | `IMPL-800`, `IMPL-802` | `IMPL-822` | `TEN-FR-006` | No code path in this module computes `TenantTier` or `Quota` from an entitlement result |
| `IMPL-804` | The absent entitlement types — no `FeatureGate`, `UsageCounter` or `Limit` is defined, stored or computed here | `platform/tenancy` | P1 | `IMPL-801` | `IMPL-822` | `TEN-FR-007` | Type inventory of `platform/tenancy` contains none of the three names; adding one fails the build |
| `IMPL-805` | `TenantId` consumed as the `liboora_contracts` (R0) value object rather than redeclared | `platform/tenancy` | P1 | `IMPL-801` | `IMPL-810` | `TEN-FR-008` | No local `TenantId` declaration exists; the imported symbol resolves to `liboora_contracts` |
| `IMPL-806` | No dependency on `TenantTier` having been promoted to `liboora_contracts` | `platform/tenancy` | P1 | `IMPL-801`, `IMPL-802` | `IMPL-829` | `TEN-FR-009` | The module compiles against a `liboora_contracts` that does **not** export `TenantTier` |
| `IMPL-807` | `Tenant` ID immutability | `platform/tenancy` | P1 | `IMPL-802` | `IMPL-829` | `TEN-INV-001` | An attempt to mutate the ID of an existing `Tenant` is rejected and the stored ID is unchanged — `TEN-AC-009` |
| `IMPL-808` | `ResidencyRegion` immutable after first write, **without** asserting any permitted value set | `platform/tenancy` | P1 | `IMPL-802` | `IMPL-829` | `TEN-INV-002` | A second write is rejected whatever value is supplied; the test passes with no enumeration in existence — `TEN-AC-010`, `TEN-GAP-001` untouched |
| `IMPL-809` | Tenant-context propagation to every rank that reads it, through the declared mechanisms only — no new integration edge | `platform/tenancy` | P1 | `IMPL-800` | `IMPL-810` | `TEN-FR-002` | The edge set of `platform/tenancy` is exactly the declared one; a new edge fails the boundary check |

### 5.2 Wave 2 — Tenant context: declaration, propagation, enforcement, partitioning (`IMPL-810` … `IMPL-819`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-810` | The `TenantContext` interface and its read-only accessor, declared in `liboora_contracts` | `liboora_contracts` | P1 | `IMPL-805`, `IMPL-809` | `IMPL-811`, `IMPL-812`, `IMPL-813` | `TEN-FR-013` | The interface exposes no setter reachable from a consumer; declaration location is `liboora_contracts`, not `platform/tenancy` |
| `IMPL-811` | A resolved tenant context required before any tenant-scoped operation executes | `platform/tenancy` | P1 | `IMPL-810` | `IMPL-814`, `IMPL-815`, `IMPL-818`, `IMPL-819` | `TEN-FR-010` | A tenant-scoped operation with no resolved context is refused before any read or write — `TEN-AC-001` |
| `IMPL-812` | Reading unset tenant context throws — never defaults to a tenant and never returns null | `platform/tenancy` | P1 | `IMPL-810` | `IMPL-829` | `TEN-FR-011` | The unset read raises; no default tenant and no null is observable — `TEN-AC-001` |
| `IMPL-813` | Async-scoped tenant context, so concurrent requests cannot observe each other's | `platform/tenancy` | P1 | `IMPL-810` | `IMPL-829` | `TEN-FR-014` | Two concurrent requests for different tenants never observe each other's context — `TEN-AC-002` |
| `IMPL-814` | Tenant context never passed as a domain method parameter | `platform/tenancy` | P1 | `IMPL-811` | `IMPL-829` | `TEN-FR-015` | No domain method signature in this module accepts a tenant-context or tenant-id parameter |
| `IMPL-815` | `tenant_id` on every row of a tenant-scoped context owned here, and **absent as a column** from a global context | `platform/tenancy` | P1 | `IMPL-802`, `IMPL-811` | `IMPL-816`, `IMPL-819` | `TEN-FR-018` | Every persisted tenant-scoped row carries a non-null `tenant_id`; a global-context row has no such column — `TEN-AC-014` |
| `IMPL-816` | Every cache key, search index name and vector namespace touching tenant data partitioned by the resolved `tenantId` | `platform/tenancy` | P1 | `IMPL-815` | `IMPL-817`, `IMPL-823` | `TEN-FR-019` | A key, index name or namespace constructed without the resolved `tenantId` fails — `TEN-AC-015` |
| `IMPL-817` | A change to a cache key, index name or vector namespace treated as a security-reviewable change | `platform/tenancy` | P2 | `IMPL-816` | `IMPL-829` | `TEN-FR-020` | Such a change cannot be accepted without a recorded security review against `MP-GBR-09` — `TEN-AC-016` |
| `IMPL-818` | A suspended tenant rejects all writes | `platform/tenancy` | P1 | `IMPL-801`, `IMPL-811` | `IMPL-827` | `TEN-BR-001` | A write attempted against a suspended tenant is rejected — `TEN-AC-006` |
| `IMPL-819` | Structural tenant isolation, re-asserted at every authorisation decision **without** this module making one | `platform/tenancy` | P1 | `IMPL-811`, `IMPL-815` | `IMPL-823` | `TEN-BR-004` | Isolation holds structurally with authorisation absent; no authorisation outcome is produced here |

### 5.3 Wave 3 — Exclusions, the closed event surface, isolation, acceptance harness (`IMPL-820` … `IMPL-829`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-820` | `TenantOrganisation` exclusion — no code path may create, write or claim it | `platform/tenancy` | P1 | `IMPL-800` | `IMPL-829` | `TEN-XC-001` | Writing `TenantOrganisation` from `platform/tenancy` fails — `TEN-AC-008` |
| `IMPL-821` | `StaffAssignment` exclusion, including every `LIB-6.x` field rule | `platform/tenancy` | P1 | `IMPL-800` | `IMPL-829` | `TEN-XC-002` | Writing `StaffAssignment` or applying a `LIB-6.x` field rule here fails — `TEN-AC-008` |
| `IMPL-822` | The authorisation-decision, entitlement-output and authorisation-outcome exclusions — no role, permission, scope, policy, `EntitlementSet`, `FeatureGate`, `UsageCounter` or `Limit`, and no cached tenant context relied on as evidence that an authorisation still holds | `platform/tenancy` | P1 | `IMPL-803`, `IMPL-804` | `IMPL-829` | `TEN-XC-003`, `TEN-XC-006`, `TEN-XC-010` | None of the named types is representable; supplying tenant context produces no authorisation outcome — `TEN-AC-008` |
| `IMPL-823` | Cross-tenant access impossible across operation, query, cache, index and projection | `platform/tenancy` | P1 | `IMPL-816`, `IMPL-819` | `IMPL-829` | `TEN-XC-007` | A read issued under tenant A returns no row, reference or derived count of tenant B, and attempting one is an error rather than an empty result — `TEN-AC-011` |
| `IMPL-824` | The credential exclusion — no password, OTP, session or device record | `platform/tenancy` | P1 | `IMPL-800` | `IMPL-829` | `TEN-XC-004` | None of the four is storable here — `ID-1`, `TEN-AC-008` |
| `IMPL-825` | The subscription and billing exclusion — no `Subscription`, `SubscriptionInvoice`, `SubscriptionPlan`, `PaymentAttempt` or `DunningState` | `platform/tenancy` | P1 | `IMPL-800` | `IMPL-829` | `TEN-XC-005` | None of the five is definable or storable here — `TEN-AC-008` |
| `IMPL-826` | The lifecycle state-machine exclusion — the module stores `TenantLifecycleState` and defines no state, transition or machine | `platform/tenancy` | P1 | `IMPL-802` | `IMPL-829` | `TEN-XC-008` | No state name, transition or machine definition appears in `platform/tenancy` — `TEN-AC-012` |
| `IMPL-827` | The two domain events with the full Bounded Context Map §9.1 envelope, written via Transactional Outbox in the same transaction as the aggregate mutation | `platform/tenancy` | P1 | `IMPL-801`, `IMPL-818` | `IMPL-828` | `TEN-EVT-001`, `TEN-EVT-002`, `TEN-FR-021` | Each event carries all ten envelope fields with a non-null `tenantId`; a consumer processing one without establishing tenant context fails loudly — `TEN-AC-007` |
| `IMPL-828` | The event surface closed at exactly two types | `platform/tenancy` | P1 | `IMPL-827` | `IMPL-829` | `TEN-XC-009` | Publishing a third event type fails; no reinstatement event is invented — `TEN-AC-013`, `TEN-GAP-004` untouched |
| `IMPL-829` | The acceptance harness — bind each of the 13 `TEN-AC-*` to a named running test, and prove `TEN-BR-004` through `TEN-AC-008` and `TEN-AC-011` together | `test/architecture` | P1 | `IMPL-806`, `IMPL-807`, `IMPL-808`, `IMPL-812`, `IMPL-813`, `IMPL-814`, `IMPL-817`, `IMPL-820`, `IMPL-821`, `IMPL-822`, `IMPL-823`, `IMPL-824`, `IMPL-825`, `IMPL-826`, `IMPL-828` | — | `TEN-BR-004` | All 13 criteria are bound to tests that run in CI; an unbound criterion fails the harness |

> **`IMPL-829`'s `Blocked by` list is computed, not written.** It is *every otherwise-terminal task* in the graph,
> derived from the dependency edges rather than typed. `PRD-007`'s backlog records a defect caught exactly here — a
> hand-written harness edge list omitted the multi-tenancy task although its criteria required it. Deriving the list
> makes that class of omission impossible rather than unlikely.

---

## 6. Traceability — task group → requirements → invariants → acceptance

Allocation rule 4 requires this table. Coverage figures are produced by
`tool/docs_check/prd013_task_coverage.py`, not counted by hand.

| Wave | Tasks | Requirements claimed | Invariants enforced | Acceptance criteria proven |
|---|---|---|---|---|
| **1** Ownership boundary, aggregate, value objects, invariants | `IMPL-800`–`809` | `TEN-FR-001`–`009` *(in force: 001–009)*, `TEN-FR-002` | `TEN-INV-001`, `TEN-INV-002` | `TEN-AC-009`, `TEN-AC-010` (ID immutability, residency immutability) |
| **2** Tenant context — declaration, propagation, enforcement, partitioning | `IMPL-810`–`819` | `TEN-FR-010`, `TEN-FR-011`, `TEN-FR-013`–`015`, `TEN-FR-018`–`020`, `TEN-BR-001`, `TEN-BR-004` | *(none new — context enforcement is a propagation rule, not an aggregate invariant)* | `TEN-AC-001`, `TEN-AC-002`, `TEN-AC-006`, `TEN-AC-014`, `TEN-AC-015`, `TEN-AC-016` |
| **3** Exclusions, closed event surface, isolation, acceptance | `IMPL-820`–`829` | all 10 `TEN-XC-*`, both `TEN-EVT-*`, `TEN-FR-021`, `TEN-BR-004` | *(re-proves `TEN-INV-001`/`002` through the harness — `IMPL-829`)* | `TEN-AC-007`, `TEN-AC-008`, `TEN-AC-011`, `TEN-AC-012`, `TEN-AC-013` — and, through `IMPL-829`, all **13** |

**Mechanically verified totals:**

| Register | Claimed / in force |
|---|---|
| `TEN-FR` | **18 / 18** |
| `TEN-BR` | **2 / 2** |
| `TEN-INV` | **2 / 2** |
| `TEN-EVT` | **2 / 2** |
| `TEN-XC` | **10 / 10** |
| **TOTAL obligations** | **34 / 34 = 100.0%** |

> **Why `TEN-AC-*`, `TEN-GAP-*` and `TEN-CFG-*` are outside that denominator, stated rather than assumed.** A
> `TEN-AC-*` is a criterion *verified by* a task's test, not a thing a task *builds*; `IMPL-829` is the task that
> proves all 13 are bound to running tests. A `TEN-GAP-*` is an **open question**, and citing one as an obligation
> would resolve it by implementation choice. `TEN-CFG-*` is **declared empty** — its single member `TEN-CFG-001` is
> retired, so there is nothing to claim; this is recorded as vacuously satisfied, not as evidence of configuration
> discipline. `PRD-013`'s **51** in-force identifiers minus **13** `TEN-AC-*` minus **4** `TEN-GAP-*` = **34**, the
> figure above. Same denominator rule as `PRD-005` and `PRD-007`, applied to a smaller register rather than reinvented.

**The acceptance-criteria column is an allocation, not a proof.** `TEN-AC-*` are grouped to the wave whose behaviour
they exercise. The binding of each individual criterion to a named test is `IMPL-829`'s deliverable and is **not**
claimed as done here. **0 of 13 criteria are currently proven by a passing test.**

**100% coverage means every obligation has a task, not that any obligation is met.** Of the 34, §4.1 measures **9** as
already satisfied by the pre-existing scaffold in a form no test observes, **2** as actively contradicted by it
(`D-013-01`, `D-013-02`) and **23** as unstarted. A reader who takes 34/34 as progress has read the wrong number.

---

## 7. Critical path — computed, not asserted

Derived from the dependency graph, not stated:

```
tasks 30 · edges 52 · roots 1 (IMPL-800) · leaves 1 (IMPL-829) · cycles 0
longest chain 9
```

The 9-task chain is:

```
IMPL-800 → IMPL-801 → IMPL-805 → IMPL-810 → IMPL-811 → IMPL-815
         → IMPL-816 → IMPL-817 → IMPL-829
```

Every wave-3 exclusion task is off the critical path — an exclusion is enforced by the absence of a type, so it
depends only on the boundary existing. The path runs through **context declaration → propagation → row partitioning →
key partitioning**, which is the correct shape: `MP-GBR-08`/`09` isolation cannot be demonstrated until keys and rows
both carry the tenant.

---

## 8. Tasks that must **not** be created

| Task that must not exist | Rule it would break |
|---|---|
| Enumerate `ResidencyRegion`'s permitted values | Resolves `TEN-GAP-001` by implementation choice. `ADR-0041` L214 declines to name a jurisdiction rule; a backlog may not supply one |
| Publish a `tenancy.TenantReinstated` event | `TEN-XC-009` closes the surface at two. `TEN-GAP-004` records the absence as an open gap, **not** a defect to fix here |
| Expose `TenantTier` to `platform/business` | `TEN-GAP-002` is open. Choosing a visibility rule would close it silently |
| Define a tenant deletion identity | `TEN-GAP-003` is open |
| Implement the tenant lifecycle state machine | `TEN-XC-008`. Owned by `PRD-002` and frozen `LIB-8.1`…`8.8` |
| Cache an authorisation outcome alongside tenant context | `TEN-XC-010`. A cached context is not evidence an authorisation still holds |
| Promote `TenantTier` into `liboora_contracts` | `TEN-FR-009` forbids assuming it; promoting it is an R0 contract change requiring its own ADR |
| Restate `AUTH-5.33`, `BR-5.20`, `XC-7.14` or `AUTH-5.36` | `PRD-013` **retired** its duplicates of these rather than restate them. Re-adding one revives a retired identifier's subject |
| Add a task numbered below `IMPL-800` | Allocation rule 1 — reassignment |

**Four of these nine would close an open `TEN-GAP-*` by writing code.** They are listed so that the omission is
visible as a decision rather than read as an oversight.

---

## 9. What this document does **not** claim

| Not claimed | Actual state |
|---|---|
| That this document implemented anything | **0 `lib/` files written by it.** A pre-existing scaffold of 85 lines exists from commit `a44ebb0`; §4.1 measures it |
| That the scaffold satisfies `PRD-013` | **9 obligations verified-in-place, 2 contradicted (`D-013-01`, `D-013-02`), 23 unstarted.** Verified-in-place is not proven: no test observes any of them |
| That any criterion is proven | **0 of 13** `TEN-AC-*` bound to a passing test. `find test -iname '*tenan*'` → empty |
| That `D-013-01`/`D-013-02` are fixed | **Not fixed.** Both are boundary/behaviour corrections routed to their owners; a Stage 6 backlog may not edit `lib/` |
| That `PRD-013` is frozen | **v0.1 `DRAFT`.** Stage 7 not attempted; `FROZEN` is conferred by a baseline row, not by this file |
| That the registry advanced | `PRD_REGISTRY.md` still records `PRD-013` as **`PLANNED`**, byte-identical |
| That `PRD-013`'s gaps are resolved | **`TEN-GAP-001`…`004` remain OPEN.** §8 records the four tasks that would have closed them |
| That `PRD_LIFECYCLE.md`'s stale range table is fixed | **Not edited.** §3.3 discloses it; amending governance is outside Stage 6 |
| That the alignment record's stale hash is repaired | **Not edited.** Assessed in the Stage 5 conferral §4; routed to the Architecture Reviewer |
| That `PGA-08` is cured | **Not cured.** `PRD-013` still has no standing named owner |
| That the module boundary checker passes | It **exits 1** repo-wide on 9 pre-existing `app → domain/library` violations, unrelated to `BC-19` |
| That `Branch` has been relocated to `BC-06` | **Not moved.** `D-013-01` records the contradiction; the move requires an ADR |

---

## 10. Definition of done — applies to every task

Per [`DEFINITION_OF_DONE.md`](../DEFINITION_OF_DONE.md) and Dependency Matrix §10.4, a task is done only when all six
pipeline gates pass with its change in place:

```
dart format                                   
flutter analyze                               
dart run tool/check_module_boundaries.dart    ◄ blocks merge
flutter test test/architecture/               ◄ blocks merge
flutter test                                  
flutter build web --release                   
```

A task whose test does not run is **not done**, however complete its description reads here.

---

## 11. Stage 6 exit gate — re-runnable

```
python3 tool/docs_check/prd013_task_coverage.py     → exit 0
```

The gate fails if any of the following becomes true: a task has an empty **Requirements** cell; a task cites a
`TEN-*` identifier `PRD-013` does not define **or has retired**; a task cites a `TEN-GAP-*` or `TEN-AC-*` as an
obligation; an `IMPL-*` is duplicated, falls outside `IMPL-800`…`829`, or collides with any number below `800`; a
**Blocked by** entry names no known task; a **Priority** cell is blank; **Blocks** and **Blocked by** disagree for a
local pair; the dependency graph acquires a cycle; or any of the **34** obligations loses its last claiming task.

Current result — **PASS**:

```
Tasks parsed 30 · unique 30 · duplicates 0 · out of range 0 · foreign collisions 0
Tasks with no requirement 0 · undefined citations 0 · retired citations 0
AC/GAP cited as obligation 0 · unresolvable dependencies 0 · missing Priority 0
Blocks/Blocked-by disagreements 0 · cycles 0 · longest chain 9 · roots 1 · leaves 1
Coverage 34/34 = 100.0%
```

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created as the **Stage 6** gate artefact for `PRD-013` v0.1 `DRAFT`. Allocated **`IMPL-800` … `IMPL-829`** — 30 tasks in 3 waves, plus `IMPL-830`…`899` as a declared growth reserve — after enumerating every `IMPL-*` in the repository (**418** distinct numbers, highest **799**) and confirming the whole `IMPL-8xx` decade is unreferenced, rather than reading `PRD_LIFECYCLE.md`'s stale `IMPL-227+` table, which `ADR-0049` has already shown to be wrong. Records `Priority`, `Blocks` and `Blocked by` per task (rule 3) and the group→requirement→invariant→acceptance table (rule 4). §4.1 measures the **pre-existing scaffold** at `lib/platform/tenancy/tenancy.dart` (85 lines, commit `a44ebb0`, predating `PRD-013`) obligation by obligation, finding 9 satisfied-but-untested, 23 unstarted and **two genuine contradictions recorded rather than fixed** — `D-013-01` (`Branch` declared here although Bounded Context Map L210 assigns it to `BC-06`) and `D-013-02` (`MutableTenantContext` is not async-scoped, so `TEN-FR-014` is violated and `TEN-AC-002` is currently false). Both are routed to their owners because a Stage 6 backlog may not edit `lib/`. A first draft of this document asserted that `lib/platform/tenancy/` did not exist; **that claim was false and is corrected in §1 rather than silently removed.** Coverage is **computed, not asserted**: `tool/docs_check/prd013_task_coverage.py` proves **34/34 = 100.0%** of obligations claimed, 0 undefined citations, 0 retired identifiers cited, 0 `TEN-GAP-*`/`TEN-AC-*` cited as obligations, 0 duplicate or out-of-range IDs, 0 collisions below `IMPL-800`, 0 cycles, `Blocks`/`Blocked by` mutually consistent, 1 root and 1 leaf; the 9-task critical path and `IMPL-829`'s 15 harness edges are derived from the graph rather than typed. Lists **9 tasks that must not be created**, four of which would close an open `TEN-GAP-*` by writing code. **Nothing is implemented: zero `lib/` files changed, no estimates invented, no specification written, no schema, SQL, DDL, API shape, widget tree or class signature; no `ResidencyRegion` value named; `PRD-013` unmodified at `688239cb…ba9c` and still v0.1 `DRAFT`; `TRACEABILITY_MATRIX.md`, `PRD_REGISTRY.md`, `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, the alignment record and every other backlog untouched; no registry entry, no ADR, and no freeze.** |
