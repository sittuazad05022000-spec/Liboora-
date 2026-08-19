# `PRD-016` Implementation Tasks — `IMPL-900` … `IMPL-929`

| Field | Value |
|---|---|
| **Module** | `platform/audit` — rank 5, Bounded Context **`BC-24`** Audit Trail |
| **Aggregate** | `AuditEntry` — the only one |
| **Source PRD** | [`../../30-product/audit/PRD-016_AUDIT_TRAIL.md`](../../30-product/audit/PRD-016_AUDIT_TRAIL.md) v0.1 `DRAFT` |
| **PRD hash** | `281f15e8de65dde8c8b5a5e8edda71f8e34eff07c7abc411698fbfc0f6f339be` — **unchanged** by this document |
| **Range allocated** | **`IMPL-900` … `IMPL-929`** — 30 tasks · `IMPL-930`…`999` declared growth reserve |
| **Obligations claimed** | **35 of 35 = 100.0%** — computed by [`../../../tool/docs_check/prd016_task_coverage.py`](../../../tool/docs_check/prd016_task_coverage.py) |
| **Acceptance criteria proven** | ⛔ **0 of 18.** No implementation exists |
| **Stage** | 6 of 9. **Stage 8 is not started.** |
| **Status of this document** | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md` |
| **Version** | v1.0 · 2026-08-19 |

---

## 1. The one thing this document is not

**It is not an implementation, and it is not a design.** It allocates numbers and states what each numbered unit of
work must satisfy, citing `AUD-*` obligations that already exist in the PRD. It contains **no** schema, SQL, DDL,
migration, API shape, class signature, field list, widget tree, storage engine choice, index definition, estimate or
sprint assignment.

That restraint is not stylistic. `PRD-016` §2 states that the `AuditEntry` field set is *"discovered, not designed"* —
Bounded Context Map **L384** names four value objects and the PRD adds none. A backlog that named a fifth field, or
named a table, would supply by implementation choice precisely what the PRD refused to invent. Three of this module's
five open gaps (`AUD-GAP-001`, `AUD-GAP-003`, `AUD-GAP-004`) would be closed by a single line of schema. §8 lists the
tasks that must therefore **not** exist.

**Nothing under `lib/` was modified.** `lib/platform/audit/audit.dart` is byte-unchanged since commit `a44ebb0`. The
three code contradictions the PRD recorded (`D-016-01`, `D-016-02`, `D-016-03`) are **not repaired here** — §4.1
measures them, and Stage 8 owns them.

---

## 2. Stage 6 prerequisites — verified, not assumed

| Prerequisite | Required by | State |
|---|---|---|
| Stage 1 Discovery passed | `PRD_LIFECYCLE.md` | ✅ [`PRD-016_STAGE1_DISCOVERY.md`](../../30-product/audit/PRD-016_STAGE1_DISCOVERY.md) |
| Stage 2 draft exists with registers declared up front | `PRD_LIFECYCLE.md` | ✅ `PRD-016_AUDIT_TRAIL.md` v0.1, 8 registers, ranges in §0.2 |
| Stage 3 Architecture alignment recorded | `PRD_LIFECYCLE.md` | ✅ [`PRD-016_ARCHITECTURE_ALIGNMENT.md`](../../30-product/audit/PRD-016_ARCHITECTURE_ALIGNMENT.md) — **ALIGNED 6/6**, 0 conflicts |
| Stage 4 conflicts closed or deferred with reason **and** owner | `PRD_LIFECYCLE.md` | ✅ [`PRD-016_STAGE4_REQUIREMENTS_REVIEW.md`](../../30-product/audit/PRD-016_STAGE4_REQUIREMENTS_REVIEW.md) — **PASS 6/6**, 5 deferrals each with a named owner |
| Stage 5 prefixes registered, counts and ranges verified mechanically, zero collisions | `PRD_LIFECYCLE.md` L120–127 | ✅ [`TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) **v1.14 §2J** · conferred by [`PRD-016_STAGE5_CONFERRAL.md`](../../30-product/audit/PRD-016_STAGE5_CONFERRAL.md) · two committed checkers, both exit 0 |

Stage 6 is therefore genuinely reachable. **Registered is not verified**, and Stage 5 conferred nothing about this
stage — the conferral record's closing line says so explicitly: *"not Stage 6, not freeze, not verification."*

---

## 3. `IMPL-*` allocation

### 3.1 Why this range — computed, not chosen

`PRD_LIFECYCLE.md` Stage 6 allocation rule 1: *"Take the next free range. **Never reuse or reassign a number** —
cross-references in commits, reviews and test names outlive the document."* Rule 2: *"Leave the previous group room to
grow contiguously."*

Every `IMPL-*` identifier in the repository was enumerated rather than read off a table:

```
grep -rhoE 'IMPL-[0-9]{3,4}' docs/ tool/ lib/ test/ packages/ | sort -u
→ 014-016 020-021 030-031 040-041 050-052 060-062 070-073 097
  100-115 120-128 199-217 220-227 299-324 399-442 450
  499-680 699-790 799-830 899-900
  451 distinct numbers · highest 900
```

**`IMPL-900` is the next free number and `IMPL-900`…`IMPL-999` the next free block.** `IMPL-800`…`829` belongs to
`PRD-013` Tenancy (30 tasks, `ADR-0050`) and `IMPL-830`…`899` is that module's **declared growth reserve** for its four
open `TEN-GAP-*`. Beginning at `900` leaves `PRD-013` its whole reserve untouched, satisfying rule 2. **Nothing below
`900` is touched, reused or reassigned.**

⚠ **`IMPL-900` already occurs in the repository, and the occurrence was checked rather than assumed harmless.**

```
grep -rnE 'IMPL-9[0-9]{2}' docs/ tool/ lib/ test/ packages/
→ 3 hits, in 2 files, none of them a task:
  docs/40-implementation/tenancy/PRD-013_IMPLEMENTATION_TASKS.md:114
      | `IMPL-900` + | Unallocated | — |
  docs/40-implementation/TRACEABILITY_MATRIX.md:999   §2J prose, "the next free block is IMPL-900+"
  docs/40-implementation/TRACEABILITY_MATRIX.md:1469  §2J changelog, same statement
```

All three are **boundary labels naming this number as free**, not assignments of work to it. Taking `IMPL-900` is
therefore what rule 1's *"take the next free range"* instructs, not a reassignment of an occupied number. The
distinction matters because a scanner that counts string occurrences — as the enumeration above does — reports `900`
as present, and treating that report as occupancy would push this backlog to `IMPL-1000` and silently strand a decade.
**The occurrence is disclosed rather than filtered out**, so a later reader can re-derive the decision.

### 3.2 The allocation table

| Range | Owner | Grouping |
|---|---|---|
| `IMPL-014` … `IMPL-073` | Authentication, platform, release readiness | [`../IMPLEMENTATION_ROADMAP.md`](../IMPLEMENTATION_ROADMAP.md) |
| `IMPL-100` … `IMPL-127` | Library Management | `LIBRARY_IMPLEMENTATION_TASKS.md` |
| `IMPL-128` … `IMPL-199` | Reserved — Library Management growth | — |
| `IMPL-200` … `IMPL-226` | Student Identity | `STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` |
| `IMPL-227` … `IMPL-299` | Student Identity growth — **partly consumed** (§3.3) | — |
| `IMPL-300` … `IMPL-323` | Student Management (`PRD-004`, `BC-01`) | `PRD-004_IMPLEMENTATION_TASKS.md` |
| `IMPL-324` … `IMPL-399` | Reserved — Student Management growth | — |
| `IMPL-400` … `IMPL-441` | Membership Management (`PRD-005`, `BC-02`) | `PRD-005_IMPLEMENTATION_TASKS.md` |
| `IMPL-442` … `IMPL-499` | `PRD-005` declared growth reserve | — |
| `IMPL-500` … `IMPL-599` | Seat Management (`PRD-007`, `BC-04`) | `PRD-007_IMPLEMENTATION_TASKS.md` |
| `IMPL-600` … `IMPL-699` | Attendance / integration backlogs | — |
| `IMPL-700` … `IMPL-799` | Revenue & Finance (`PRD-008`, `BC-06`) — `ADR-0049` | `PRD-008_IMPLEMENTATION_TASKS.md` |
| `IMPL-800` … `IMPL-829` | Tenancy (`PRD-013`, `BC-19`) — 30 tasks, `ADR-0050` | [`../tenancy/PRD-013_IMPLEMENTATION_TASKS.md`](../tenancy/PRD-013_IMPLEMENTATION_TASKS.md) |
| `IMPL-830` … `IMPL-899` | Reserved — **`PRD-013` growth**, 4 open `TEN-GAP-*`. **Not touched here** | — |
| **`IMPL-900` … `IMPL-909`** | **Wave 1 — Ownership boundary, the aggregate, immutability, the four invariants** | This document |
| **`IMPL-910` … `IMPL-919`** | **Wave 2 — Recording: envelope, idempotency, server time, atomicity, availability, inbound edge** | This document |
| **`IMPL-920` … `IMPL-929`** | **Wave 3 — Query confinement, the ownership exclusions, acceptance harness** | This document |
| `IMPL-930` … `IMPL-999` | **Reserved for `PRD-016` growth** — 5 open `AUD-GAP-*` may require tasks | This document, unallocated |
| `IMPL-1000` + | Unallocated | — |

**30 tasks, `IMPL-900` … `IMPL-929`, contiguous with no gaps inside the allocated span.** Wave boundaries fall on round
tens so that a task added to a wave later does not force a renumber: rule 1 forbids reassignment, so slack must be
**planned rather than found**.

`IMPL-930`…`999` is declared as this module's growth reserve because **five** `AUD-GAP-*` are genuinely open and two of
them (`AUD-GAP-001` retention, `AUD-GAP-003` legal hold) would each require real tasks once their owners decide. If
`AUD-GAP-001` is ever resolved by a named retention period, that work takes `IMPL-930`+ rather than a number inside a
wave.

### 3.3 A known staleness, disclosed rather than corrected

`PRD_LIFECYCLE.md`'s Stage 6 range table ends `| IMPL-227+ | **Unallocated** |`. The enumeration in §3.1 shows
`IMPL-227` is **occupied**, and `ADR-0049` has already recorded this. Trusting that table would violate allocation
rule 1 by reassigning a live number.

**This is an already-recorded condition, not a newly found conflict.** `PRD-005`, `PRD-007`, `PRD-008` and `PRD-013`
all record it in their own §3.3, stating the rule this document follows: *the occupancy enumeration in §3.1, not the
table, is the authority on what is free.*

This document therefore treats that table as **stale but harmless** and **does not edit it**. Amending
`PRD_LIFECYCLE.md` is a Rank 1 governance change requiring an ADR *before* the change (baseline §7) and is outside
Stage 6. Carried forward in §9.

---

## 4. Blocking dependencies outside `PRD-016`

| Dependency | Owner | Effect on this backlog |
|---|---|---|
| `TEN-FR-011` — *"Reading tenant context when it is unset MUST throw"* | `BC-19` / `PRD-013` **FROZEN** | **Consumed, not reimplemented.** `IMPL-921` depends on it existing; `AUD-FR-015` cites it rather than restating it |
| Tenant context propagation (`TEN-FR-002`, `TEN-FR-010`, `TEN-FR-013`, `TEN-FR-014`) | `BC-19` / `PRD-013` **FROZEN** | `IMPL-920`, `IMPL-921`, `IMPL-923` cannot be demonstrated until a resolved tenant context exists. `PRD-013` is frozen but `IMPL-800`…`829` are **unimplemented**, so this is a real sequencing dependency, not a paper one |
| Transactional Outbox | Platform / `ADR` per BC Map §9.1 | `IMPL-913` requires an outbox in the **emitter's** transaction. This module does not own it — `AUD-FR-008` cites BC Map §9.1 *"Atomicity with state"* and manifest `ID-6` |
| The Class A fact register | `BC-18` | **`AUD-GAP-005`** — `event_register_source: docs/prd/authentication` does not exist, so `EVT-1001`…`EVT-1036` member names are unavailable. `IMPL-916` therefore implements the enforceable **class contract** (`A-5`, `ID-3`, manifest `AU-2`), not an enumerated list |
| `AUTH-10.27` vs `E-20` / manifest `AU-3` | `BC-18` + **ARB** | **`AUD-GAP-002`.** `IMPL-913` and `IMPL-914` are written so this module's obligation is identical under either reading, so the gap **does not block** |
| A retention period, legal-hold mechanism, support-access action list | **SECURITY + DATA Governance**, Product Owner | **`AUD-GAP-001`, `AUD-GAP-003`, `AUD-GAP-004`.** No task exists for any of them (§8). With `AUD-BR-003` — never remove — *purge* has no path in V1, so no task is blocked |

### 4.1 The pre-existing scaffold — measured, not assumed

`lib/platform/audit/audit.dart` exists and predates `PRD-016`: **64 lines**, commit `a44ebb0` (*"feat(scaffold)"*).
It was read line by line rather than described.

| Obligation | Scaffold state | Evidence |
|---|---|---|
| `AUD-INV-001` append-only, no update/delete/purge/modify path | ✅ **satisfied in place** | No method matches the four banned names. Header L3–4 states the intent; `append` L35 is annotated *"The ONLY mutation method. Intentional."* |
| `AUD-XC-001` no public mutating method | ✅ **satisfied in place** | Same measurement. This is why `X-10` passes today |
| `AUD-INV-002` non-null `tenantId` | ✅ **satisfied in place** | `tenantId` is `required` at L12 and L37, typed `TenantId` from `liboora_contracts` |
| `AUD-INV-003` actor of record | ✅ **satisfied in place** | `actor` is `required` at L13 and L38 |
| `AUD-FR-013` no import from `domain/**` or `app/**` | ✅ **satisfied in place** | Single import, L7, `package:liboora_contracts` |
| `AUD-FR-012` publishes no domain event | ✅ **satisfied in place** | No publish, emit or event type in the file |
| `AUD-FR-016` no cross-tenant read surface | ⛔ **CONTRADICTED — `D-016-01`** | `recent([int n = 25])` L60–61 has no tenant filter; `count` L63 returns a global total; callers `lib/app/dashboards/ops_page.dart:270,272,282` |
| `AUD-FR-005` ten-field envelope · `AUD-FR-006` idempotency on `eventId` · `AUD-FR-007` server time | ⛔ **CONTRADICTED — `D-016-02`** | L9–27 carries no `eventId`, `correlationId`, `causationId` or `schemaVersion`; L51 defaults an absent `at` to `DateTime.fromMillisecondsSinceEpoch(0)` — epoch zero, not server time |
| `AUD-FR-008` outbox, same transaction | ⛔ **CONTRADICTED — `D-016-03`** | L33 `final List<AuditEntry> _entries = []` — in-memory, no transaction participation |
| Remaining **26** obligations | ⚪ **unstarted** | Not represented in the file at all |

**Six obligations satisfied in place, three contradicted, twenty-six unstarted.** *Satisfied in place is not proven:*

```
find test -iname '*audit*' | wc -l   →  0
```

**No test observes any of the six.** That is why every one of them still carries a task in §5 — the task is to bind
the behaviour to a test, not to write code that already exists. `IMPL-904` does not create append-only-ness; it proves
it and makes its removal fail the build.

**The three contradictions are not repaired by this document.** A Stage 6 backlog may not edit `lib/`. They are routed
to Stage 8 through `IMPL-922` (`D-016-01`), `IMPL-910`/`911`/`912` (`D-016-02`) and `IMPL-913` (`D-016-03`), which is
what a backlog is permitted to do with a contradiction: schedule it.

---

## 5. The 30 tasks

Column meanings, fixed once. **Requirements** cites the `AUD-*` obligations the task must satisfy — this is the Stage 6
gate and **no cell may be empty**. **Blocked by** and **Blocks** record allocation rule 3's two directions and are
checked against each other mechanically. **Priority** is `P1` (something else cannot proceed without it, or the harness
that proves everything), `P2` (needed for a coherent V1) or `P3` (required by the PRD but on no other task's path).

`AUD-AC-*` do **not** appear in Requirements cells. An acceptance criterion is **verified by** a task's test, not
**implemented by** a task; §6 maps them separately and `IMPL-929` is the task that proves the whole set of 18 runs.
`AUD-GAP-*` do **not** appear either: they are **open questions**, and citing one as verifiable would resolve it by
implementation choice. Where a *Test requirement* names an `AUD-AC-*` or an `AUD-GAP-*`, it records which criterion
observes the task, or which gap it must leave untouched — never a claimed obligation.

### 5.1 Wave 1 — Ownership boundary, the aggregate, immutability, the four invariants (`IMPL-900` … `IMPL-909`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-900` | Bounded-context skeleton for `BC-24` under `platform/audit` owning the `AuditEntry` aggregate and no other, per Bounded Context Map §8 L384 | `platform/audit` | P1 | — | `IMPL-901`, `IMPL-902`, `IMPL-903`, `IMPL-915`, `IMPL-918` | `AUD-FR-001` | Structural: no aggregate other than `AuditEntry` is representable in this module |
| `IMPL-901` | `AuditEntry` as the module's only aggregate root, carrying `Actor`, `Action`, `Target` and `TenantContext` as value objects — **no fifth value object**, which would require an ADR amending L384 | `platform/audit` | P1 | `IMPL-900` | `IMPL-904`, `IMPL-907`, `IMPL-908`, `IMPL-909`, `IMPL-910`, `IMPL-925`, `IMPL-926`, `IMPL-927` | `AUD-FR-004` | A second aggregate root is not constructible; the value-object set is exactly the four L384 names |
| `IMPL-902` | Audit storage, retention **execution** and audit query owned here — the ownership `AUTH-10.26` vacates to this module, not asserted by it | `platform/audit` | P1 | `IMPL-900` | `IMPL-917`, `IMPL-920`, `IMPL-928` | `AUD-FR-002` | Storage, retention execution and query entry points exist in this module and in no `BC-18` module |
| `IMPL-903` | No decision here about *what* is auditable in another context; each emitter's auditable-action list is consumed, never authored, overridden or extended | `platform/audit` | P1 | `IMPL-900` | `IMPL-916` | `AUD-FR-003`, `AUD-XC-011` | No auditable-action list, allow-list or filter over another context's actions exists in this module |
| `IMPL-904` | Immutability of a written entry in its entirety — no update, delete, purge or modify path, enforced so that adding one **fails the build** rather than review | `platform/audit` | P1 | `IMPL-901` | `IMPL-905`, `IMPL-906` | `AUD-INV-001`, `AUD-XC-001` | A public method matching `update*`/`delete*`/`purge*`/`modify*` fails the boundary checker; a mutation attempt leaves the stored entry byte-identical — `AUD-AC-001`, `AUD-AC-002` |
| `IMPL-905` | Immutability holding for **every** role including Platform Administrator — no privileged path, support route, break-glass or administrative override | `platform/audit` | P2 | `IMPL-904` | `IMPL-929` | `AUD-BR-002`, `AUD-XC-002` | An alter or remove attempt while acting as Platform Administrator fails, with no privileged path succeeding — `AUD-AC-003` |
| `IMPL-906` | Correction as a **new** entry, per `X-10`'s verbatim remedy *"Append a correcting entry"* | `platform/audit` | P2 | `IMPL-904` | `IMPL-929` | `AUD-BR-001` | Correcting a wrong entry produces a second entry; the original remains present and unchanged — `AUD-AC-004` |
| `IMPL-907` | Non-null `tenantId` on every entry, failing **loudly** rather than defaulting to a tenant | `platform/audit` | P1 | `IMPL-901` | `IMPL-920`, `IMPL-923` | `AUD-INV-002` | A write without `tenantId` fails loudly; no default tenant and no null is observable — `AUD-AC-005` |
| `IMPL-908` | An actor of record on every entry | `platform/audit` | P2 | `IMPL-901` | `IMPL-929` | `AUD-INV-003` | A write without an actor fails — `AUD-AC-006` |
| `IMPL-909` | No credential, OTP value, session token, device trust marker, key material or unmasked personal datum in an entry, its payload **or any log line** | `platform/audit` | P2 | `IMPL-901` | `IMPL-929` | `AUD-INV-004`, `AUD-XC-004` | None of the six is storable or loggable here — `AUD-AC-015`; owner of the excluded subject is `BC-18` |

### 5.2 Wave 2 — Recording: envelope, idempotency, server time, atomicity, availability, inbound edge (`IMPL-910` … `IMPL-919`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-910` | The full Bounded Context Map §9.1 **L449–450** envelope on every recorded entry — the ten canonical fields, with a non-null `tenantId`. Repairs `D-016-02`'s missing envelope fields | `platform/audit` | P1 | `IMPL-901` | `IMPL-911`, `IMPL-912`, `IMPL-913` | `AUD-FR-005` | Every entry carries all ten envelope fields; the field set is taken from L449–450 and **not extended** — `AUD-AC-011` |
| `IMPL-911` | Idempotent recording keyed on `eventId`, per BC Map §9.1 at-least-once delivery: *"every consumer must be idempotent"*. Repairs the idempotency half of `D-016-02` | `platform/audit` | P2 | `IMPL-910` | `IMPL-929` | `AUD-FR-006` | The same fact delivered twice with the same `eventId` produces exactly one entry — `AUD-AC-010` |
| `IMPL-912` | Server time as the authoritative recorded moment; any client-asserted moment retained only as a distinct non-authoritative field within `payload`. Repairs `D-016-02`'s epoch-zero default | `platform/audit` | P2 | `IMPL-910` | `IMPL-929` | `AUD-FR-007` | The authoritative time is server-supplied; a client-supplied timestamp never appears as the authoritative moment, and no absent timestamp defaults to epoch zero — `AUD-AC-012` |
| `IMPL-913` | The audit fact committing in the **same transaction as the state change it describes**, via the Transactional Outbox, never published from application code after commit. Repairs `D-016-03` | `platform/audit` | P1 | `IMPL-910` | `IMPL-914` | `AUD-FR-008` | Fact and state change commit or roll back together; no post-commit publish path exists — `AUD-AC-013`; manifest `ID-6` |
| `IMPL-914` | Unavailability of this module neither failing nor delaying the emitting operation — audit **visibility** is delayed, the operation is not | `platform/audit` | P2 | `IMPL-913` | `IMPL-929` | `AUD-FR-009` | With this module unavailable the emitting operation completes and its outbox row is written — `AUD-AC-014`; **`AUD-GAP-002` left untouched**, no reading of `AUTH-10.27` chosen |
| `IMPL-915` | `E-20` as the module's **only** inbound integration edge — BC Map §7.3 L329, *"fire-and-forget, outbox-backed"* | `platform/audit` | P1 | `IMPL-900` | `IMPL-919` | `AUD-FR-010` | The inbound edge set of `platform/audit` is exactly `{E-20}`; a new edge fails the boundary checker, per BC Map §7 *"If an edge is not in this table, it does not exist"* |
| `IMPL-916` | Sole consumption of every **Class A** fact, enforced as the manifest's class contract rather than as an enumerated event list | `platform/audit` | P2 | `IMPL-903` | `IMPL-929` | `AUD-FR-011` | A Class A subscription by any module other than `platform/audit` fails as a boundary violation — manifest `AU-2`, `A-5`, `ID-3`. **`AUD-GAP-005` left untouched**: no `EVT-*` member name is invented |
| `IMPL-917` | Erasure by making an entry **non-identifying through key destruction**, never by removal | `platform/audit` | P2 | `IMPL-902` | `IMPL-929` | `AUD-BR-003`, `AUD-XC-012` | After an erasure request the entry is still present, its identifying key destroyed, **no row removed** — `AUD-AC-018`; `MP-GBR-04`, `ID-5` |
| `IMPL-918` | No import from `domain/**` or `app/**` — the forbidden Capability → Domain direction | `platform/audit` | P1 | `IMPL-900` | `IMPL-924` | `AUD-FR-013` | `platform/audit` contains no such import; adding one fails `check_module_boundaries` — `AUD-AC-017`, manifest `banned_imports` |
| `IMPL-919` | The published-event surface **empty** — no domain event, no notification, no delivery request through any channel | `platform/audit` | P2 | `IMPL-915` | `IMPL-929` | `AUD-FR-012`, `AUD-XC-010` | The set of event types published by `platform/audit` is empty; publishing any type fails — `AUD-AC-016`. **No event is invented**; `AUD-EVT-*` stays empty |

### 5.3 Wave 3 — Query confinement, the ownership exclusions, acceptance harness (`IMPL-920` … `IMPL-929`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-920` | Every audit query confined to one tenant — *"A library sees only audit concerning its own context"* | `platform/audit` | P1 | `IMPL-902`, `IMPL-907` | `IMPL-921`, `IMPL-922` | `AUD-FR-014` | A query under tenant A returns nothing of tenant B — `AUD-AC-007`; `AU-7` (Auth §10.4), `AUTH-10.23` |
| `IMPL-921` | A query with no resolved tenant context **failing** — never an empty result, never a default tenant | `platform/audit` | P2 | `IMPL-920` | `IMPL-929` | `AUD-FR-015` | The unresolved-context query throws; neither an empty list nor a default tenant's data is returned — `AUD-AC-008`. Consumes `PRD-013` `TEN-FR-011` (**FROZEN**) rather than redefining it |
| `IMPL-922` | Removal of every cross-tenant read surface — no global count, no *"recent entries"* listing, no aggregate total, no diagnostic view. **This is the `D-016-01` repair**, including its three `ops_page.dart` call sites | `platform/audit` | P1 | `IMPL-920` | `IMPL-923` | `AUD-FR-016` | No method returns a value derived from more than one tenant's entries, counts and totals included — `AUD-AC-009`. The three callers at `ops_page.dart:270,272,282` must compile against the tenant-confined surface |
| `IMPL-923` | Cross-tenant reach **impossible** across query, projection, cache, index and diagnostic surface — an attempt is an error, **not an empty result** | `platform/audit` | P2 | `IMPL-907`, `IMPL-922` | `IMPL-929` | `AUD-XC-003` | No surface returns, references, counts or infers another tenant's entry; the attempt errors — `AUD-AC-007`, `AUD-AC-009`; `X-13` **blocker**, `MP-RSK-01` **Critical** |
| `IMPL-924` | No authorisation decision made, stored, cached or evaluated here. Confining a query to a tenant is **not** deciding access | `platform/audit` | P2 | `IMPL-918` | `IMPL-929` | `AUD-XC-005` | No role, permission, scope or policy type is representable; supplying a tenant context produces no authorisation outcome — `AUD-AC-017`; owner `BC-18` |
| `IMPL-925` | No `Tenant` aggregate, tenant-context propagation, `TenantTier`, `Quota`, `ResidencyRegion` or `TenantLifecycleState` defined, stored or claimed here | `platform/audit` | P3 | `IMPL-901` | `IMPL-929` | `AUD-XC-006` | None of the six is definable in this module — `AUD-AC-017`; owner `BC-19`, `TEN-FR-001`…`005` **FROZEN** |
| `IMPL-926` | No `EntitlementSet`, `FeatureGate`, `UsageCounter` or `Limit` defined, stored or computed here | `platform/audit` | P3 | `IMPL-901` | `IMPL-929` | `AUD-XC-007` | None of the four is definable — `AUD-AC-017`; owner `BC-21`, BC Map L383 |
| `IMPL-927` | No subscription or billing state defined, stored or computed here | `platform/audit` | P3 | `IMPL-901` | `IMPL-929` | `AUD-XC-008` | No subscription or billing type is definable — `AUD-AC-017`; owner `BC-20`, BC Map L382 |
| `IMPL-928` | No analytics projection, certified metric or read model owned here, and no becoming a system of record for a domain fact it records | `platform/audit` | P3 | `IMPL-902` | `IMPL-929` | `AUD-XC-009` | No projection, metric or read model is defined; `E-20` remains one-way — owner `BC-26`, BC Map L385 |
| `IMPL-929` | The acceptance harness — bind each of the **18** `AUD-AC-*` to a named running test, and prove the module's two highest-severity properties, append-only (`X-10`) and tenant confinement (`X-13`), as a whole rather than per method | `test/architecture` | P1 | `IMPL-905`, `IMPL-906`, `IMPL-908`, `IMPL-909`, `IMPL-911`, `IMPL-912`, `IMPL-914`, `IMPL-916`, `IMPL-917`, `IMPL-919`, `IMPL-921`, `IMPL-923`, `IMPL-924`, `IMPL-925`, `IMPL-926`, `IMPL-927`, `IMPL-928` | — | `AUD-INV-001`, `AUD-XC-003` | All 18 criteria bound to tests that run in CI; an unbound criterion fails the harness |

> **`IMPL-929`'s `Blocked by` list is computed, not written.** It is *every otherwise-terminal task* in the graph —
> every task that blocks nothing else — derived from the dependency edges rather than typed, and re-derived by the gate
> script on every run. `PRD-007`'s backlog records a defect caught exactly here: a hand-written harness edge list
> omitted the multi-tenancy task although its criteria required it. Deriving the list makes that omission impossible
> rather than unlikely.

---

## 6. Traceability — task group → requirements → invariants → acceptance

Allocation rule 4 requires this table. Every figure is produced by
[`../../../tool/docs_check/prd016_task_coverage.py`](../../../tool/docs_check/prd016_task_coverage.py), not counted by
hand, and the script fails if a published total drifts.

| Wave | Tasks | Requirements claimed | Invariants enforced | Acceptance criteria proven |
|---|---|---|---|---|
| **1** Ownership boundary, aggregate, immutability, invariants | `IMPL-900`–`909` | `AUD-FR-001`–`004`, `AUD-BR-001`, `AUD-BR-002`, `AUD-XC-001`, `AUD-XC-002`, `AUD-XC-004`, `AUD-XC-011` | `AUD-INV-001`, `AUD-INV-002`, `AUD-INV-003`, `AUD-INV-004` — **all four** | `AUD-AC-001`–`006`, `AUD-AC-015` |
| **2** Recording — envelope, idempotency, time, atomicity, availability, inbound edge | `IMPL-910`–`919` | `AUD-FR-005`–`013`, `AUD-BR-003`, `AUD-XC-010`, `AUD-XC-012` | *(none new — recording rules are propagation and ordering obligations, not aggregate invariants)* | `AUD-AC-010`–`014`, `AUD-AC-016`, `AUD-AC-017` (import half), `AUD-AC-018` |
| **3** Query confinement, ownership exclusions, harness | `IMPL-920`–`929` | `AUD-FR-014`–`016`, `AUD-XC-003`, `AUD-XC-005`–`009` | `AUD-INV-001` re-proven whole by the harness | `AUD-AC-007`, `AUD-AC-008`, `AUD-AC-009`, `AUD-AC-017`, and **all 18** bound by `IMPL-929` |

**Coverage of the obligation set — recomputed, not asserted.** The PRD defines **35** Class A obligations
(16 `AUD-FR-*` + 3 `AUD-BR-*` + 4 `AUD-INV-*` + **0** `AUD-EVT-*` + 12 `AUD-XC-*`). Every one is claimed by at least
one task: **35 / 35 = 100.0%**.

⚠ **`AUD-EVT-*` contributes zero obligations, and that is load-bearing rather than incidental.** `BC-24` publishes no
domain event — it is a producer in **zero** BC Map §9 rows while appearing **25** times as a consumer, the widest
fan-in in the map. `IMPL-919` therefore claims `AUD-FR-012` and `AUD-XC-010`, which make the empty surface
*enforceable*; **no task creates an event to fill the register.** A backlog that invented one would breach BC Map §7
(*"If an edge is not in this table, it does not exist"*) and the authoring prohibition on inventing events.

⚠ **100% of obligations claimed is not 100% verified, and the difference is the whole of Stages 8 and 9.**
**0 of 18** `AUD-AC-*` are bound to a passing test today — `find test -iname '*audit*'` returns nothing. Coverage of
acceptance criteria over obligations remains **27 / 35 = 77.1%** exactly as `TRACEABILITY_MATRIX.md` §2J publishes it;
this table does not improve that figure and must not be read as doing so. The eight uncovered obligations
(`AUD-FR-001`…`004`, `AUD-FR-010`, `AUD-FR-011`, `AUD-XC-009`, `AUD-XC-011`) are covered **structurally** by
`AUD-AC-017`, and each still carries a task — `IMPL-900`, `IMPL-901`, `IMPL-902`, `IMPL-903`, `IMPL-915`, `IMPL-916`,
`IMPL-928` and `IMPL-903` respectively.

---

## 7. Critical path — computed, not asserted

Derived from the dependency graph by the gate script, not stated:

```
tasks 30 · edges 47 · roots 1 (IMPL-900) · leaves 1 (IMPL-929) · cycles 0
longest chain 7
```

The 7-task chain is:

```
IMPL-900 → IMPL-901 → IMPL-907 → IMPL-920 → IMPL-922 → IMPL-923 → IMPL-929
```

The path runs **boundary → aggregate → mandatory tenant key → tenant-confined query → removal of the cross-tenant
surface → impossibility of cross-tenant reach → harness**. That is the correct shape: `X-13` rates a missing tenant key
*"the highest-severity failure class in the system"* and `MP-RSK-01` rates a cross-tenant leak **Critical**, so the
longest chain in an audit backlog *should* be the tenant-isolation chain rather than the recording chain.

Every wave-3 pure-exclusion task (`IMPL-925`…`928`) is off the critical path, because an exclusion is enforced by the
**absence of a type** and so depends only on the boundary existing. `IMPL-904`, which makes append-only-ness
unbreakable, is likewise short-pathed — the scaffold already satisfies it (§4.1), so the work is to bind it to a test,
not to build it.

---

## 8. Tasks that must **not** be created

| Task that must not exist | Rule it would break |
|---|---|
| Define an audit retention period, or a configurable holding one | Closes **`AUD-GAP-001`** by implementation choice. `MP-NFR-10` assigns retention to **SECURITY + DATA Governance**; `Q-04` is *"Open — needs counsel"*. `AUD-CFG-*` is deliberately **unissued** — no number is burned |
| Implement a legal-hold mechanism, scope or release path | Closes **`AUD-GAP-003`**. `MP-GBR-13` and BC Map L384 say hold *"blocks purge"* but define no mechanism. With `AUD-BR-003` never removing a record, *purge* has no path in V1, so nothing is blocked by its absence |
| Enumerate a support-access action list | Closes **`AUD-GAP-004`**. `AUD-FR-003` places the auditable-action list with the **emitter**; no emitter has published one. EA's `Support Access Log (V3)` is **Rank 6, descriptive only** |
| Enumerate `EVT-1001`…`EVT-1036` or any Class A member name | Closes **`AUD-GAP-005`** with names the repository does not contain — `event_register_source` points at a non-existent path. `IMPL-916` enforces the class contract instead |
| Choose a reading of `AUTH-10.27` vs `E-20` | Closes **`AUD-GAP-002`**, an **ARB** act. `IMPL-913`/`IMPL-914` are written so the obligation is identical either way |
| Publish any domain event from `platform/audit` | `AUD-FR-012`, `AUD-XC-010`, `AUD-AC-016`. `BC-24` is a producer in zero BC Map §9 rows; adding one needs an ADR amending §9 |
| Add a fifth value object to `AuditEntry` | `AUD-FR-004` — BC Map **L384** names four. A further field arrives through the **envelope** (`AUD-FR-005`), already canonical at Rank 4, not through an invented aggregate field |
| Add an update, delete, purge or modify method, even a private one reachable from a public path | `AUD-INV-001`, `AUD-XC-001`, `X-10`, manifest `banned_method_names`, `MP-GBR-13` |
| Add a break-glass or administrative override for corrections | `AUD-BR-002`, `AUD-XC-002`, `AU-4` (Auth §10.4) — *"Audit is beyond the control of the roles whose actions it records"* |
| Implement erasure as row deletion | `AUD-BR-003`, `AUD-XC-012`. Erasure is **key destruction**; `MP-GBR-04` retains history pseudonymised |
| Author, override or extend another context's auditable-action list | `AUD-FR-003`, `AUD-XC-011`. With 25 inbound producers this would be a veto over every other context's compliance obligation |
| Own an analytics projection or certified metric over recorded facts | `AUD-XC-009`. Owner `BC-26`; `E-20` is one-way |
| Repair `D-016-01`, `D-016-02` or `D-016-03` **in this document** | Stage 8. A Stage 6 backlog may not edit `lib/`. They are **scheduled** by `IMPL-922`, `IMPL-910`–`912` and `IMPL-913` |
| Add a task numbered below `IMPL-900`, or inside `IMPL-830`…`899` | Allocation rule 1 — reassignment. `IMPL-830`…`899` is `PRD-013`'s declared growth reserve |

**Five of these fourteen would close an open `AUD-GAP-*` by writing code.** They are listed so the omission reads as a
decision rather than an oversight.

---

## 9. What this document does **not** claim

| Not claimed | Actual state |
|---|---|
| That anything was implemented | **0 `lib/` files written or changed.** `git status --short lib/ packages/ test/` → 0 lines |
| That the scaffold satisfies `PRD-016` | **6 obligations satisfied in place, 3 contradicted, 26 unstarted** (§4.1). Satisfied-in-place is **not proven** — no test observes any of the six |
| That any criterion is proven | ⛔ **0 of 18** `AUD-AC-*` bound to a passing test. `find test -iname '*audit*'` → empty |
| That `D-016-01`/`02`/`03` are fixed | **Not fixed.** Scheduled to `IMPL-922`, `IMPL-910`–`912`, `IMPL-913`. A Stage 6 backlog may not edit `lib/` |
| That coverage improved | The **27/35 = 77.1%** acceptance coverage in `TRACEABILITY_MATRIX.md` §2J is **unchanged**. This document raises *obligations claimed by a task* to 35/35 — a different measurement |
| That `PRD-016` is frozen | **v0.1 `DRAFT`.** Stage 7 not entered. `FROZEN` is conferred by a `DOCUMENTATION_BASELINE.md` §3 row, not by any file below Rank 1 |
| That the registry advanced | `PRD_REGISTRY.md` §4.2 still records `PRD-016` as **`PLANNED`**, byte-identical |
| That `PRD-016`'s gaps are resolved | **`AUD-GAP-001`…`005` remain OPEN.** §8 records the five tasks that would have closed them |
| That `AUD-EVT-*` or `AUD-CFG-*` gained members | **Both still empty.** No event invented, no configurable issued, no retention period, jurisdiction or legal rule supplied |
| That `PRD_LIFECYCLE.md`'s stale range table is fixed | **Not edited** (§3.3). Amending a Rank 1 document needs an ADR *before* the change |
| That `PGA-08` is cured | **Not cured.** `PRD-016` still has no standing named owner; authority for this stage is per-act conferral |
| That `PRD-013`'s tasks are done | `IMPL-800`…`829` are **unimplemented**. §4 records this as a real sequencing dependency for `IMPL-920`/`921`/`923` |
| That the module boundary checker passes repo-wide | It **exits 1** on 9 pre-existing `app → domain/library` violations, unrelated to `BC-24` and not repaired here |
| That `AUD-GAP-002` is reconciled | **Not reconciled.** Routed to `BC-18` + ARB; both tasks written to be indifferent to the outcome |

---

## 10. Definition of done — applies to every task

Per [`../DEFINITION_OF_DONE.md`](../DEFINITION_OF_DONE.md) and Dependency Matrix §10.4, a task is done only when all
six pipeline gates pass with its change in place:

```
dart format
flutter analyze
dart run tool/check_module_boundaries.dart    ◄ blocks merge
flutter test test/architecture/               ◄ blocks merge
flutter test
flutter build web --release
```

A task whose test does not run is **not done**, however complete its description reads here. For this module the third
gate is unusually load-bearing: `AUD-AC-001` is satisfied by the boundary checker refusing a banned method name, so
`check_module_boundaries` is not merely a guard on the work but the **instrument that proves** the module's core
invariant.

---

## 11. Stage 6 exit gate — re-runnable

```
python3 tool/docs_check/prd016_task_coverage.py     → exit 0
```

The gate fails if any of the following becomes true: a task has an empty **Requirements** cell; a task cites an
`AUD-*` identifier `PRD-016` does not define; a task cites an `AUD-GAP-*` or `AUD-AC-*` as an obligation; an `IMPL-*`
is duplicated, falls outside `IMPL-900`…`929`, or collides with any number below `900`; a **Blocked by** entry names no
known task; a **Priority** cell is blank or is not `P1`/`P2`/`P3`; **Blocks** and **Blocked by** disagree for a local
pair; `IMPL-929`'s dependency list stops being exactly the set of otherwise-terminal tasks; the dependency graph
acquires a cycle or a second root or leaf; §7's published graph figures drift from the computed ones; or any of the
**35** obligations loses its last claiming task.

⚠ The checker **expands ellipsis ranges** in every cell it reads, per finding **`S4-D-01`**: `AUD-XC-005`…`008`
notation is established practice in this repository (frozen `PRD-007` uses it at `SEAT-AC-166`), and a token-only
scanner silently under-counts. A gate that under-counts coverage reports a false gap; one that under-counts obligation
claims reports a false pass, which is worse.

Current result — **PASS** (figures reproduced in §6 and §7 from this run).

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created as the **Stage 6** gate artefact for `PRD-016` v0.1 `DRAFT`. Allocated **`IMPL-900` … `IMPL-929`** — 30 tasks in 3 waves — plus `IMPL-930`…`999` as a declared growth reserve for the five open `AUD-GAP-*`, after enumerating every `IMPL-*` in the repository (**451** distinct numbers) rather than reading `PRD_LIFECYCLE.md`'s stale `IMPL-227+` table. ⚠ **`IMPL-900` was found to occur already** — 3 hits in 2 files — and each occurrence was opened and shown to be an *"Unallocated"* **boundary label**, not an assignment, so taking the number is rule 1's *"take the next free range"* and not a reassignment; the occurrence is **disclosed in §3.1 rather than filtered out**, because a scanner counting string occurrences would report `900` as occupied and push this backlog to `IMPL-1000`, stranding a decade. `IMPL-830`…`899` is left untouched as `PRD-013`'s declared reserve. Records `Priority`, `Blocks` and `Blocked by` per task (rule 3) and the group→requirement→invariant→acceptance table (rule 4). **Coverage is computed, not asserted**: `prd016_task_coverage.py` proves **35/35 = 100.0%** of Class A obligations claimed, 0 undefined citations, 0 `AUD-GAP-*`/`AUD-AC-*` cited as obligations, 0 duplicate or out-of-range identifiers, 0 collisions below `IMPL-900`, 0 cycles, `Blocks`/`Blocked by` mutually consistent, 1 root and 1 leaf; §7's **47 edges** and **7-task critical path**, and `IMPL-929`'s **17** harness edges, are derived from the graph rather than typed. §4.1 measures the **pre-existing scaffold** at `lib/platform/audit/audit.dart` (64 lines, commit `a44ebb0`, predating `PRD-016`) obligation by obligation: **6 satisfied in place, 26 unstarted, and 3 genuine contradictions recorded rather than fixed** — `D-016-01` (`recent()`/`count` expose cross-tenant reads), `D-016-02` (no `eventId`/`correlationId`/`causationId`/`schemaVersion`; `at` defaults to epoch zero) and `D-016-03` (in-memory list, no outbox). All three are **scheduled** to `IMPL-922`, `IMPL-910`–`912` and `IMPL-913` because a Stage 6 backlog may not edit `lib/`. ⚠ **Satisfied-in-place is explicitly not treated as proven**: `find test -iname '*audit*'` returns **0**, so all six already-satisfied obligations still carry tasks whose work is to bind them to a test. ⚠ **`AUD-EVT-*` and `AUD-CFG-*` remain empty and no task fills either**; `IMPL-919` instead makes the empty event surface *enforceable*. Lists **14 tasks that must not be created**, **five** of which would close an open `AUD-GAP-*` by writing code. **Nothing is implemented: zero `lib/` files changed; no schema, SQL, DDL, migration, API shape, class signature, field list, storage engine, index or estimate; no fifth `AuditEntry` value object named; no retention period, legal-hold mechanism, support-access list, `EVT-*` member name, event, integration edge or configuration value invented; `AUD-GAP-001`…`005` all still OPEN; `PRD-016` unmodified at `281f15e8…f339be` and still v0.1 `DRAFT`; `TRACEABILITY_MATRIX.md`, `PRD_REGISTRY.md`, `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, all 50 ADRs, the four earlier `PRD-016` records and every other module's backlog untouched; no registry change, no ADR, and no freeze.** |
