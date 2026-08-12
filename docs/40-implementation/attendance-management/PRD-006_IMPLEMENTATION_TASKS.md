# `PRD-006` Implementation Tasks — `IMPL-600` … `IMPL-679`

| Field | Value |
|---|---|
| **Document** | Implementation tasks for [`PRD-006_ATTENDANCE-MANAGEMENT.md`](../../30-product/attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md) (`PRD-006`, `BC-03`) |
| **Version** | v1.0 |
| **Status** | Backlog record. **Not ranked**, therefore editable without an ADR |
| **Date** | 2026-08-04 |
| **Baseline** | Written against `BASELINE-2026-08-04-E`. **Not admitted to it** |
| **Purpose** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 6** gate — allocate an `IMPL-*` range and record a task document in which every task traces back to requirements |
| **Implementation state** | ⛔ **NOTHING IN THIS DOCUMENT IS IMPLEMENTED.** Zero files under `lib/` were created or modified. No development has started |
| **Source of truth** | `PRD-006` v1.3 **DRAFT**. Where this file disagrees with it, **the PRD is right and this file is a defect** |
| **Stage** | Stage 6 of 9. `PRD-006` remains **`DRAFT`** with **⚠️ CONDITIONAL** Stage 3 and Stage 4 verdicts; this document does **not** freeze it, does **not** upgrade either verdict, and does **not** advance the registry |

---

## 1. The one thing this document is not

It is **not** evidence of progress, and it is **not** a specification. Eighty well-formed task rows can read like
work completed; they are a plan for work **not** begun. Verified, not asserted:

```
git diff --stat a9daeff -- lib/  → (empty)     # zero application-code changes
git status --short               → only docs/40-implementation/attendance-management/
                                   and tool/docs_check/
```

`PRD-006` `ATT-NFR-010` states: *"A rule that cannot be checked **MUST** be treated as unmet. A requirement in this
document with no acceptance criterion is not satisfied by assertion."* The same standard applies to a task. Until its
test exists and runs, the task is **not done**, however complete its description reads here.

**What this document deliberately does not contain:** no schema, no SQL, no DDL, no API shape, no wire format, no
cryptographic construction, no widget tree, no class signature, no device architecture and no estimate. `PRD-006` §0.1
places all of those outside the PRD in those words — *"no API surface, no database schema, no table, column, index,
migration, SQL, wire format, cryptographic construction or class design"* — and expanding any of them here would be
writing the specification that Stage 6 does not authorise. Scope cells name **what** must be built and the
requirements that govern it, never **how**.

**This backlog is subordinate to a `DRAFT` PRD whose two completed reviews both returned `CONDITIONAL`.** That is
stated in §2 rather than smoothed over, and it changes what this document may claim: a task list built on a
conditional review is a plan, not a licence.

---

## 2. Stage 6 prerequisites — verified, not assumed

`PRD_LIFECYCLE.md` §2: *"A gate is not an opinion — if the artefact does not exist, the stage has not been passed,
however complete the work feels."*

| Prerequisite | Required artefact | State |
|---|---|---|
| **Stage 3 — Architecture Alignment** | Ownership, edges and patterns checked against BC Map, Dependency Matrix and ADRs | ⚠️ **CONDITIONAL** — [`PRD-006_ARCHITECTURE_ALIGNMENT.md`](../../30-product/attendance-management/PRD-006_ARCHITECTURE_ALIGNMENT.md). **Performed, not passed.** `PRD-006`'s own header states *"a conditional verdict is not a pass, so no stage is claimed passed"* |
| **Stage 4 — Requirements Review** | Testable, uniquely identified, non-duplicating; conflicts closed or deferred with a reason and an owner | ⚠️ **CONDITIONAL** — [`PRD-006_REQUIREMENTS_REVIEW.md`](../../30-product/attendance-management/PRD-006_REQUIREMENTS_REVIEW.md) with [`PRD-006_STAGE4_FINDINGS_CORRECTION.md`](../../30-product/attendance-management/PRD-006_STAGE4_FINDINGS_CORRECTION.md). Eight findings recorded; **six closed by writing what was missing** (`ATT-FR-149`–`151`, `ATT-BR-043`–`045`, `ATT-AC-210`–`213`). **The verdict was not upgraded** |
| **Stage 5 — Traceability** | All `ATT-*` prefixes registered in [`TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) §2 with counts and ranges, verified mechanically, zero collisions | ✅ **Satisfied** — §2F of the matrix (v1.7): ten registers, **516** identifiers, **285** obligation-bearing, collisions **0**, `ATT-NFR-010` coverage 285/285 = 100.0%; [`tool/docs_check/prd006_traceability.py`](../../../tool/docs_check/prd006_traceability.py) exit 0 |
| **Stage 6 — this document** | `IMPL-*` range allocated + every task traces to requirements | ✅ This file, mechanically checked by [`tool/docs_check/prd006_task_coverage.py`](../../../tool/docs_check/prd006_task_coverage.py) |
| **Stage 7 — Freeze** | A row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank | ⛔ **Not attempted here.** Out of scope for Stage 6 |

> **Why Stage 6 is entered at all with two conditional verdicts, stated rather than assumed.** `PRD_LIFECYCLE.md`
> Stage 6's gate is *"an `IMPL-*` range allocated and a task document in which every task traces back to
> requirements."* Its gate text conditions nothing on a Stage 3 or Stage 4 **verdict grade** — it conditions on the
> artefacts existing, which they do. What a conditional verdict changes is **what may be built, not whether a
> backlog may be written**: every condition those two reviews left open is an open `ATT-GAP-*`, each such gap
> blocks named tasks in §4, and §8 lists the tasks that would close one by writing code. **A conditional Stage 4 is
> therefore represented here as a constraint on the tasks, not as a passed stage.** This differs from `PRD-007`,
> whose Stage 4 returned **A — PASS**; that document's prerequisites table is not copied.

> **Stage 6 does not confer freeze.** Completing this gate does not make `PRD-006` frozen, ranked or authoritative,
> and this document creates no ADR and edits no registry. `PRD_REGISTRY.md` still records what it recorded before
> and is **byte-identical**. `PRD-006` remains **`DRAFT`**, **unranked** and **not admitted to any baseline**.

---

## 3. `IMPL-*` allocation

### 3.1 Why this range — computed, not chosen

`PRD_LIFECYCLE.md` Stage 6 allocation rule 1: *"Take the next free range. **Never reuse or reassign a number** —
cross-references in commits, reviews and test names outlive the document."* Rule 2: *"Leave the previous group room
to grow contiguously."*

Every `IMPL-*` identifier in the repository was enumerated rather than read off a table:

```
grep -rhoE 'IMPL-[0-9]{3}' docs/ tool/ lib/ test/ | sort -u
→ 247 distinct numbers; highest token seen: IMPL-600
grep -rnE 'IMPL-6[0-9][0-9]' docs/ tool/ lib/ test/
→ docs/40-implementation/seat-management/PRD-007_IMPLEMENTATION_TASKS.md:107
  docs/40-implementation/seat-management/PRD-007_IMPLEMENTATION_TASKS.md:113
```

**Both `IMPL-600` occurrences are declarations that the number is free, not uses of it.** Line 107 reads
`| IMPL-600 + | Unallocated | — |` in `PRD-007`'s own allocation table; line 113 reads *"A future gap resolution
takes `IMPL-600`+ under rule 1."* The boundary token was inspected at its source rather than inferred from the
maximum, **because a maximum cannot distinguish an allocation from a marker** — which is `PRD-007` §3.1's own stated
reason for doing the same thing to the single `IMPL-500` token it found.

**`IMPL-600` is therefore the allocation.** Nothing is skipped ahead of it: unlike `PRD-004` (`IMPL-324`–`399`) and
`PRD-005` (`IMPL-442`–`499`), **`PRD-007` declared no growth reserve of its own** — its §3.2 states *"the ten waves
consume the whole hundred… so a reserve would be speculative"* — so `IMPL-600` is the immediate next free number and
rule 2 requires no gap.

### 3.2 The allocation table

| Range | Owner | Grouping |
|---|---|---|
| `IMPL-014` … `IMPL-073` | Authentication, platform, release readiness | [`IMPLEMENTATION_ROADMAP.md`](../IMPLEMENTATION_ROADMAP.md) |
| `IMPL-100` … `IMPL-127` | Library Management | [`LIBRARY_IMPLEMENTATION_TASKS.md`](../LIBRARY_IMPLEMENTATION_TASKS.md) |
| `IMPL-128` … `IMPL-199` | Reserved for Library Management growth | — |
| `IMPL-200` … `IMPL-226` | Student Identity | [`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md`](../STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md) |
| `IMPL-227` … `IMPL-299` | Reserved for Student Identity growth | — |
| `IMPL-300` … `IMPL-323` | Student Management (`PRD-004`, `BC-01`) | [`PRD-004_IMPLEMENTATION_TASKS.md`](../../30-product/student-management/PRD-004_IMPLEMENTATION_TASKS.md) |
| `IMPL-324` … `IMPL-399` | Reserved for Student Management growth | — |
| `IMPL-400` … `IMPL-441` | Membership Management (`PRD-005`, `BC-02`) | [`PRD-005_IMPLEMENTATION_TASKS.md`](../membership-management/PRD-005_IMPLEMENTATION_TASKS.md) |
| `IMPL-442` … `IMPL-499` | Reserved for Membership Management growth | — |
| `IMPL-500` … `IMPL-599` | Seat Management (`PRD-007`, `BC-04`) — **no growth reserve declared** | [`PRD-007_IMPLEMENTATION_TASKS.md`](../seat-management/PRD-007_IMPLEMENTATION_TASKS.md) |
| **`IMPL-600` … `IMPL-609`** | **Wave 1 — Context boundary, ownership split, ports, aggregate, invariants** | This document |
| **`IMPL-610` … `IMPL-619`** | **Wave 2 — Roles, mode framework, mode independence, Fixed QR** | This document |
| **`IMPL-620` … `IMPL-629`** | **Wave 3 — Dynamic QR, Wi-Fi mode, GPS mode** | This document |
| **`IMPL-630` … `IMPL-639`** | **Wave 4 — Face verification, its prohibitions, and the blocked build** | This document |
| **`IMPL-640` … `IMPL-649`** | **Wave 5 — Manual entry, register image, OCR failure path, audit** | This document |
| **`IMPL-650` … `IMPL-659`** | **Wave 6 — Entry/exit determinism, time, duplicates, concurrency, volume** | This document |
| **`IMPL-660` … `IMPL-669`** | **Wave 7 — Owner configuration, configurables, device boundary, corrections** | This document |
| **`IMPL-670` … `IMPL-679`** | **Wave 8 — Authorization, tenancy, audit, events, Seating boundary, NFRs, acceptance** | This document |
| `IMPL-680` … `IMPL-699` | **Reserved for Attendance Management growth — 18 open `ATT-GAP-*` may require tasks** | — |
| `IMPL-700` + | Unallocated | — |

**80 tasks, `IMPL-600` … `IMPL-679`, contiguous with no gaps inside the allocated span.** Wave boundaries fall on
round tens so that a task added to a wave later does not force a renumber: rule 1 forbids reassignment, so slack must
be **planned rather than found**.

**This backlog holds a growth reserve and `PRD-007`'s did not, and the difference is a fact about the two PRDs
rather than a stylistic choice.** `PRD-007` reserved nothing because its 14 open `SEAT-GAP-*` receive no tasks and a
reserve would have been speculative. Here the reserve is **`IMPL-680`–`699`**, held for the same reason `PRD-004`
and `PRD-005` hold theirs: **18 `ATT-GAP-*` are open**, and four of them (`ATT-GAP-009`, `ATT-GAP-012`,
`ATT-GAP-013`, `ATT-GAP-014`) block a whole mode from being built. When an owner decides one, the resulting work
takes a number from the reserve under rule 1 — it does not reuse a task number in `IMPL-600`–`679` and it does not
retro-fit itself into an existing row.

### 3.3 A known staleness, disclosed rather than corrected

`PRD_LIFECYCLE.md`'s Stage 6 range table ends `| IMPL-227+ | **Unallocated** |`, and
`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` §1.1 says the same. Both predate `PRD-004`'s `IMPL-300`…`323`,
`PRD-005`'s `IMPL-400`…`441` and `PRD-007`'s `IMPL-500`…`599`. **Four tables are now stale, not three.**

**This is an already-recorded condition, not a newly found conflict.** `PRD-004_IMPLEMENTATION_TASKS.md` §7 records
it, `PRD-005_IMPLEMENTATION_TASKS.md` §3.3 records it again and states the rule this document follows — *"the
occupancy enumeration in §3.1, not the table, is the authority on what is free"* — and
`PRD-007_IMPLEMENTATION_TASKS.md` §3.3 records it a third time.

This document therefore treats those tables as **stale but harmless** and **does not edit them**. Amending
`PRD_LIFECYCLE.md` is governance editing and is explicitly forbidden for this work; amending another backlog's
allocation table is outside Stage 6. Carried forward in §9 rather than fixed silently.

---

## 4. Blocking dependencies outside `PRD-006`

`PRD-006` cannot be fully implemented from its own backlog. `BC-03` Attendance consumes **six** inbound edges,
publishes to **three** contexts, and — uniquely among the modules backlogged so far — contains **one mode it is
forbidden to build at all**. These constraints are **inherited, not introduced here**.

| Blocker | Effect on this backlog | Register |
|---|---|---|
| **`BLK-01`** / `TASK-D10` demo surfaces | **Gate 3 is red today** (9 `cross-context` violations; `ADR-0012` expiry 2026-10-31). Any PR in this backlog inherits a red gate 3 until `TASK-D10` lands. **The violations must not be waived to make it green** | [`IMPLEMENTATION_BLOCKER_REGISTER.md`](../IMPLEMENTATION_BLOCKER_REGISTER.md) |
| **`ATT-GAP-009`** — no V1 owner for a face scanner's lifecycle | **`IMPL-630` is BLOCKED.** `BC-18` owns `Device` for *authentication*; `BC-08` owns physical devices and is **V2**. `PRD-006` §32.1 calls this *"a genuine V1 hole"* and names the architecture owner. **No device architecture or ownership is invented here** | `PRD-006` §17.1, §32.1 |
| **`ATT-GAP-012`** — no owner for a face template | **`IMPL-631` is BLOCKED.** Ownership is unassigned by every source; the storage sub-question is settled **negatively** — `BC-03` has no `E-22` path, so it cannot store a template at all | `PRD-006` §12.4a, §32.1 |
| **`ATT-GAP-013`** — no liveness capability exists | **`IMPL-632` is BLOCKED.** The only `liveness` hits in the repository are infrastructure health probes | `PRD-006` §12.3, §32.1 |
| **`ATT-GAP-014`** — biometric erasure is a conflict, not a void | **`IMPL-633` is BLOCKED.** `ID-5`/`MP-GBR-04` promise erasure by **pseudonymisation**, structurally inapplicable to a template that *is* the identifier. Legal counsel + Security Platform | `PRD-006` §12.4, §32.1 |
| **`ATT-GAP-015`** — Face is `V3` in EA, unplaced in Rank 1–5 | **Moot in effect but recorded.** `ATT-FR-064` blocks the Face build regardless of version class, so `IMPL-634` implements the *refusal*, not the feature | `PRD-006` §12.5, §32.1 |
| **`ATT-GAP-011`** — no context owns an OCR/Vision capability | **`IMPL-641` builds against a port with a fake and defines no capability owner.** The requested `BC-03` → `BC-27` edge is **refuted, not granted** (BC Map §7.4 `F-1`/`F-3`/`F-4`). Direction resolved; ownership open | `PRD-006` §13E, §32.1 |
| **`ATT-GAP-016`** — no retention rule for a register image | **`IMPL-644` cannot set a retention period.** Aggravated by third-party handwriting on the image. Legal counsel | `PRD-006` §13E, §32.1 |
| **`ATT-GAP-017`** — seven configurables have no default | **`IMPL-661` cannot supply the missing seven.** `LIB-16.2` requires a documented default for every setting; `ATT-BR-043` states a configurable whose default is unresolved **has no value and none may be substituted**. The single **FAIL** in the verification report | `PRD-006` §16.3, §32.1 |
| **`ATT-GAP-005`** — retention period undecided upstream | **`IMPL-673` implements audit emission, never a retention policy.** BC Map `Q-04` is open *in the authoritative document itself*; a PRD may not promote an architecture document's own open question to an answer | `PRD-006` §21, §32.1 |
| **`ATT-GAP-006`** — no cryptographic construction exists | **`IMPL-620` builds the rotation *behaviour* only.** Secrets are `BC-25`'s references; the construction is Security Platform's. Inventing one would be a security design, which `PRD-006` §0.4 forbids | `PRD-006` §9.4, §32.1 |
| **`ATT-GAP-007`** / **`ATT-GAP-008`** / **`ATT-GAP-008a`** | **`IMPL-622`, `IMPL-625` and `IMPL-626` build the prohibitions, not the detections.** No source identifies a network technically, authorises spoof or mock-location detection, or licenses reuse of `LIB-6.5` Map Location for attendance | `PRD-006` §10.4, §11.4, §32.1 |
| **`ATT-GAP-003`** / **`ATT-GAP-004`** / **`ATT-GAP-010`** — named consumers with no edge | **`IMPL-674` publishes exactly four events to exactly the consumers BC Map §7 authorises.** `BC-26` and `BC-13` are named in §9 as consumers of `attendance.*` events while §7 declares no edge; `E-22` excludes `BC-03`. **No task adds an edge.** `ATT-GAP-004` is materially worse than `003`: `BC-03` is not even a self-restriction subscriber of `E-14` | `PRD-006` §5.4, §22.3, §32.1 |
| **`ATT-GAP-016a`** / **`ATT-GAP-017a`** | **`IMPL-676` and `IMPL-677` implement the prohibitions.** No source addresses a rotating code that cannot be validated offline, and no Rank 1–5 latency or throughput figure exists — so none is asserted | `PRD-006` §27, §27.1, §32.1 |
| **`ATT-GAP-018`** — no *"at least one mode"* constraint is authorised | **`IMPL-663` preserves the permissive behaviour.** `ATT-FR-106` and `ATT-AC-209` decline to invent a restriction | `PRD-006` §16.5, §32.1 |
| **`PRD-005`** `BC-02` — `IMPL-432` (`E-03` producer) | **`IMPL-604` builds the consumer against a port with a fake.** `ATT-PO-001` consumes `MembershipValidity`; Attendance **records and flags, never blocks**. `PRD-005` is **frozen** (v1.4) but **unimplemented** | `PRD-005_IMPLEMENTATION_TASKS.md` §4 |
| **`PRD-004`** `BC-01` — `IMPL-300`, `IMPL-301` | **`IMPL-603` has no upstream identity projection.** `StudentRecordId` is `BC-01`'s; this module never creates or renames a student. `PRD-004` is frozen (v1.2) and unimplemented | `PRD_REGISTRY.md` |
| **`PRD-007`** `BC-04` — `IMPL-551` (`E-08` consumer) | **`IMPL-675` is the producer side of a link whose consumer is also unbuilt.** `PRD-007` §4 records that `IMPL-551` *"has no upstream"* — this task is that upstream. **Seating is the occupancy owner; Attendance is the trigger** | `PRD-007` §4, `PRD-006` §23.1 |
| **`BC-06`** Library Policy — `E-04` | **`IMPL-605`, `IMPL-651` and `IMPL-660` conform to `AttendanceRules{openTime, closeTime, graceMinutes, lateEntryPolicy}` and define nothing.** `ATT-PO-002`: *conform, do not translate* | BC Map §7.1 |
| **`PRD-023`** `BC-25` Configuration unwritten | **`IMPL-661` reads all 24 `ATT-CFG-*` through `E-19`**; the configuration PRD does not exist | `ADR-0017` |
| **`BC-18`** Authorisation, **`BC-21`** Entitlement, **`BC-19`** Tenancy, **`BC-30`** Offline Sync | `IMPL-670` consumes `BC-18`'s decisions and defines no role; `IMPL-602` calls `E-17` **before** the aggregate mutates; `IMPL-671` takes `TenantContext` from `E-18` as ambient context, never a domain parameter; `IMPL-677` **defines** the conflict-resolution policy `BC-30` executes. All are **ports** here, never implementations | BC Map §7.1, §7.3 |
| **`BC-24`** Audit, **`BC-22`** Notification | `IMPL-673` emits over `E-20` fire-and-forget, **never synchronously**; `IMPL-678` emits **facts** over `E-23` and implements no dispatch — never *"send an SMS"* | BC Map §7.3 |
| **`ATT-GAP-001`** … **`ATT-GAP-018`** (18 open of 21 rows) | Eighteen open questions. **No task resolves any of them** — see §8. `IMPL-679` exists in part to keep them open: `PRD-006` §0.4 states a gap resolved by implementation choice *"is not resolved — it is an undocumented architecture decision made by whoever happened to write the code first"* | `PRD-006` §32.1 |

> **Consequence, stated rather than buried.** `BC-03` sits downstream of two frozen-but-unbuilt contexts (`BC-01`,
> `BC-02`), one unwritten configuration context (`BC-25`) and one draft-and-unbuilt downstream (`BC-04`).
> **Waves 1–3 and 5–8 are largely buildable today**, because the aggregate, the twelve invariants, five of the six
> modes, the entry/exit state table, the configuration surface and the event boundary are this module's own. **Wave 4
> is not buildable at all** — and that is not a scheduling fact but a product one: `ATT-FR-064` forbids building Face
> verification, and four open gaps sit under it. `IMPL-630`–`634` are therefore written as **BLOCKED** tasks whose
> only permitted deliverable is the refusal and the recorded reason. An attendance module shipped today would offer
> five working modes and a sixth that correctly refuses to exist.

---

## 5. The 80 tasks

Column meanings, fixed once. **Requirements** cites the `ATT-*` obligations the task must satisfy — this is the
Stage 6 gate and no cell may be empty. **Blocked by** and **Blocks** record allocation rule 3's two directions and
are checked against each other mechanically; **`Blocks` is derived from the graph, not typed by hand**, because two
hand-written directions of one edge drift. **Priority** is `P1` (nothing else can proceed without it), `P2` (needed
for a coherent V1) or `P3` (required by the PRD but not on any other task's path).

`ATT-AC-*` do not appear in Requirements cells. An acceptance criterion is **verified by** a task's test, not
**implemented by** a task; §6 maps them separately, and `IMPL-679` is the task that proves the whole set of 213 runs.
`ATT-GAP-*` do not appear either: `PRD-006` §0.4 states they are *"questions addressed to a named owner… not
requirements, they are not deferred requirements, and they may not be satisfied by an implementer choosing an
answer."* Where a gap **blocks** a task, it is named in the Scope and Test cells as a recorded blocker — which is
the opposite of citing it as an obligation.

> **On the ⛔ **BLOCKED** marker.** **Twelve** tasks carry it — `IMPL-630`, `IMPL-631`, `IMPL-633`, `IMPL-634`,
> `IMPL-638`, `IMPL-639`, `IMPL-643`, `IMPL-648`, `IMPL-649`, `IMPL-667`, `IMPL-677`, `IMPL-679`, counted from the
> table rather than estimated. A blocked task is **not** deferred and **not** removed:
> its requirement exists in the PRD and must be represented, so the task exists and its *permitted deliverable is
> the boundary, the refusal and the recorded reason* — never a guess at the missing answer. `IMPL-630`–`IMPL-634`,
> `IMPL-638` and `IMPL-639` are the extreme case: `ATT-FR-064` requires face verification **not** to be built until
> two named owners answer, so the task that satisfies `ATT-FR-064` is the one that makes the mode observably refuse
> to exist.

### 5.1 Wave 1 — Context boundary, ownership split, ports, aggregate, invariants (`IMPL-600` … `IMPL-609`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-600` | Bounded-context skeleton for `BC-03` Attendance and the ownership split — the module, its public surface, and what it owns versus what it must not | `domain/library` | P1 | — | `IMPL-601`, `IMPL-602`, `IMPL-604`, `IMPL-606`, `IMPL-607`, `IMPL-609`, `IMPL-610`, `IMPL-630` | `ATT-FR-001`, `ATT-FR-002`, `ATT-XC-001`, `ATT-XC-002`, `ATT-XC-007` | Structural: no student-profile, membership-validity, seat, staff-attendance, money or notification-dispatch type is representable here; no separate service or process is introduced; no other context's store is reachable |
| `IMPL-601` | The Single Owner Rule as an enforced boundary, not a comment — no aggregate owned by another context is creatable, mutable or deletable from here | `test` | P1 | `IMPL-600` | `IMPL-679` | `ATT-INV-001` | Architecture test: constructing or mutating a foreign aggregate from this module fails to compile or is rejected by the boundary checker |
| `IMPL-602` | The six inbound port surfaces of §5.2 and the arrival of an already-authenticated actor — declared as ports with fakes, never as implementations of the upstream contexts | `platform/data` | P1 | `IMPL-600` | `IMPL-603`, `IMPL-605`, `IMPL-609`, `IMPL-630`, `IMPL-655`, `IMPL-660`, `IMPL-672`, `IMPL-677` | `ATT-PO-001`, `ATT-PO-002`, `ATT-PO-004`, `ATT-PO-005`, `ATT-PO-006`, `ATT-PO-007` | Each port has a fake; membership validity is recorded and flagged but never blocks; library rules are conformed to and never re-derived; tenant context is ambient and never a domain method parameter; this module performs no authentication |
| `IMPL-603` | The entitlement check that runs *before* the aggregate mutates, not after | `platform/business` | P1 | `IMPL-602` | `IMPL-616` | `ATT-PO-003` | Ordering test: a denied entitlement leaves no attendance fact and no partial mutation; the check is observably invoked before the aggregate is entered |
| `IMPL-604` | The three outbound port surfaces of §5.3 — occupancy trigger, audit, notification — each fire-and-forget where the map says so | `platform/event` | P1 | `IMPL-600` | `IMPL-605`, `IMPL-652`, `IMPL-673`, `IMPL-674`, `IMPL-678` | `ATT-PO-008`, `ATT-PO-009`, `ATT-PO-010` | Audit emission is never awaited synchronously; a failed downstream delivery does not fail the attendance operation; the notification port carries facts and no channel or recipient |
| `IMPL-605` | The four edges that do **not** exist, expressed as impossibilities — Analytics, File & Media, AI Assistance, Search Indexing | `test` | P1 | `IMPL-602`, `IMPL-604` | `IMPL-674` | `ATT-XC-003`, `ATT-XC-004`, `ATT-XC-005`, `ATT-XC-006` | Architecture test: no client, adapter, port or import for `BC-26`, `BC-29`, `BC-27` or `BC-23` exists here, and adding one fails the boundary checker |
| `IMPL-606` | `VerificationEvidence` semantics — it records what was verified, never who the person is, and never a secret | `domain/library` | P1 | `IMPL-600` | `IMPL-608` | `ATT-BR-002`, `ATT-XC-008` | An evidence object carrying a password, OTP, session token, credential, secret or raw biometric payload is unrepresentable, not merely discouraged |
| `IMPL-607` | One `AttendanceDay`, one transaction — and the bulk workflow decomposed into per-student units rather than one wide write | `domain/library` | P1 | `IMPL-600` | `IMPL-608` | `ATT-FR-006`, `ATT-BR-003`, `ATT-XC-009` | A single operation cannot mutate two `AttendanceDay` aggregates; the bulk path is observably per-student; no distributed transaction or two-phase commit is used |
| `IMPL-608` | The seven synchronous invariants of §6.2, enforced inside the aggregate rather than by a service that calls it politely | `domain/library` | P1 | `IMPL-606`, `IMPL-607` | `IMPL-613`, `IMPL-616`, `IMPL-620`, `IMPL-637`, `IMPL-642`, `IMPL-650`, `IMPL-657`, `IMPL-669`, `IMPL-672`, `IMPL-677` | `ATT-INV-002`–`ATT-INV-008` | Each of the seven has a test that violates it directly against the aggregate and is rejected: check-out before check-in, a non-idempotent punch, a second open session, a destructive correction, a punch without a tenant, a punch without exactly one method, a delete |
| `IMPL-609` | Roles and scope taken from Master PRD §6 — five roles, a closed scope register, and permission-plus-scope evaluated together | `platform/identity` | P1 | `IMPL-600`, `IMPL-602` | `IMPL-616`, `IMPL-640`, `IMPL-669`, `IMPL-670` | `ATT-FR-003`, `ATT-FR-004`, `ATT-FR-005`, `ATT-BR-001` | No sixth role is definable; parent access is read-only and guarded-student scoped; holding a permission without scope on the record is refused |

### 5.2 Wave 2 — Roles, mode framework, mode independence, Fixed QR (`IMPL-610` … `IMPL-619`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-610` | The closed set of six V1 attendance modes, and the impossibility of a seventh | `domain/library` | P1 | `IMPL-600` | `IMPL-611`, `IMPL-612`, `IMPL-614`, `IMPL-615`, `IMPL-640`, `IMPL-661` | `ATT-FR-007`, `ATT-XC-010` | The mode enumeration has exactly six members; RFID, NFC and BLE are not members and cannot be added without changing the type |
| `IMPL-611` | Mode independence — each mode is sufficient alone, and no generic verification-layer abstraction is introduced to make them look uniform | `domain/library` | P1 | `IMPL-610` | `IMPL-613`, `IMPL-620`, `IMPL-632` | `ATT-BR-004`, `ATT-BR-005`, `ATT-XC-011` | Each enabled mode produces attendance on its own; two modes are never required for one attendance; no verification pipeline, chain or strategy registry exists |
| `IMPL-612` | Modes 3 and 4 as single modes with a compound condition, not two modes composed — and the confinement of Wi-Fi to one and GPS to the other | `domain/library` | P1 | `IMPL-610` | `IMPL-624`, `IMPL-628` | `ATT-BR-006`, `ATT-BR-007` | A Wi-Fi condition applied to any mode other than Fixed QR + Wi-Fi is unrepresentable; the same for GPS and Fixed QR + GPS |
| `IMPL-613` | The recorded `AttendanceMethod` is the mode actually used and cannot be substituted, defaulted or downgraded | `domain/library` | P1 | `IMPL-608`, `IMPL-611` | `IMPL-679` | `ATT-FR-008` | A punch whose recorded method differs from the path that produced it is rejected; no fallback silently rewrites the method |
| `IMPL-614` | Per-tenant enable/disable of each mode as a domain capability, and the guarantee that no student is required to own a smartphone | `domain/library` | P2 | `IMPL-610` | `IMPL-679` | `ATT-FR-009`, `ATT-BR-008` | Each of the six is independently switchable; with every app-based mode disabled a student can still attend through a staff-operated path |
| `IMPL-615` | A QR identifies the attendance context, never the person — and carries no secret | `domain/library` | P1 | `IMPL-610` | `IMPL-616`, `IMPL-620` | `ATT-BR-009`, `ATT-XC-012` | A QR payload containing a password, OTP, session token, credential or personal identifier is unrepresentable; scanning one authenticates nobody |
| `IMPL-616` | The Fixed QR flow of §8.2 with every validation server-side | `app` | P1 | `IMPL-603`, `IMPL-608`, `IMPL-609`, `IMPL-615` | `IMPL-617`, `IMPL-619`, `IMPL-624`, `IMPL-628` | `ATT-FR-010`, `ATT-FR-011` | A client-supplied validation result is ignored; the server repeats every step; a tampered client cannot produce attendance |
| `IMPL-617` | Fixed QR generation, activation and entrance association, with hard tenant binding | `domain/library` | P1 | `IMPL-616` | `IMPL-618`, `IMPL-619` | `ATT-FR-012`, `ATT-FR-013`, `ATT-FR-014`, `ATT-BR-010` | An unactivated code produces nothing; a code presented for a tenant other than its bound tenant is rejected and never falls back; two entrances are distinguishable |
| `IMPL-618` | Fixed QR replacement and revocation, each audited, neither retroactive | `domain/library` | P2 | `IMPL-617` | `IMPL-679` | `ATT-FR-015`, `ATT-FR-016`, `ATT-FR-017` | Replacement leaves prior attendance intact; a revoked code stops producing attendance immediately; all three lifecycle operations emit an audit fact |
| `IMPL-619` | Fixed QR rejection, duplicate scan and concurrency behaviour — and the honest statement of what a long-lived QR does not prove | `domain/library` | P1 | `IMPL-616`, `IMPL-617` | `IMPL-658` | `ATT-FR-018`, `ATT-FR-019`, `ATT-FR-020`, `ATT-BR-011`, `ATT-BR-012` | Every rejection case creates no record and returns a distinguishable reason; a repeat scan in the same day is absorbed; concurrent scans yield exactly one transition; no surface claims Fixed QR proves physical presence |

### 5.3 Wave 3 — Dynamic QR, Wi-Fi mode, GPS mode (`IMPL-620` … `IMPL-629`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-620` | The Dynamic QR flow, independent of Fixed QR, with expiry and replay validated server-side and **no cryptographic construction specified** | `domain/library` | P1 | `IMPL-608`, `IMPL-611`, `IMPL-615` | `IMPL-621`, `IMPL-677` | `ATT-FR-021`, `ATT-FR-022`, `ATT-BR-013`, `ATT-XC-013` | Enabling or disabling Dynamic QR leaves Fixed QR untouched; the displayed code's own claim about its validity is never trusted; no algorithm, key length or signing scheme appears in the module — `ATT-GAP-006` stays open |
| `IMPL-621` | Dynamic code generation, bounded validity window, rotation on the configured interval, and a distinguishable expiry reason | `domain/library` | P1 | `IMPL-620` | `IMPL-622`, `IMPL-623`, `IMPL-663` | `ATT-FR-023`, `ATT-FR-024`, `ATT-FR-025`, `ATT-FR-026` | An expired code is rejected with a reason distinct from "invalid"; rotation is observable at the configured interval; each code is tenant-bound |
| `IMPL-622` | Single-use per student-day, and concurrent scans of one code by many students each evaluated independently | `domain/library` | P1 | `IMPL-621` | `IMPL-658` | `ATT-FR-027`, `ATT-FR-028`, `ATT-BR-014` | A consumed code produces no second attendance for the same student-day; one student's failure does not fail another's scan of the same code |
| `IMPL-623` | Server-side time evaluation, the disabled-mode refusal, and the refusal to compensate for clock skew | `domain/library` | P1 | `IMPL-621` | `IMPL-679` | `ATT-FR-029`, `ATT-FR-030`, `ATT-BR-015` | Client-supplied time is never used; a displayed code produces nothing while the mode is disabled; no skew-tolerance window is introduced |
| `IMPL-624` | Wi-Fi as **environment** verification and the mode-3 flow — never identity, never authentication, never proof a person was present | `domain/library` | P1 | `IMPL-612`, `IMPL-616` | `IMPL-625`, `IMPL-626` | `ATT-BR-016`, `ATT-XC-014`, `ATT-FR-031` | The recorded evidence describes a network condition and no identity claim; no surface or payload describes Wi-Fi as authentication |
| `IMPL-625` | Tenant-scoped approved-network configuration owned by the Owner and stored through the configuration port | `domain/library` | P1 | `IMPL-624` | `IMPL-626`, `IMPL-627`, `IMPL-664` | `ATT-FR-032`, `ATT-FR-033`, `ATT-BR-017` | One tenant's approved network never validates another tenant's attendance; the value is read through the port, never from a local file or constant |
| `IMPL-626` | The four Wi-Fi failure outcomes and the evidence recorded on success | `domain/library` | P1 | `IMPL-624`, `IMPL-625` | `IMPL-627` | `ATT-FR-034`, `ATT-FR-035`, `ATT-FR-036`, `ATT-FR-037` | Network-unavailable and network-not-approved are distinguishable reasons; neither creates a record; neither silently downgrades to plain Fixed QR; success records `VerificationEvidence` |
| `IMPL-627` | Wi-Fi configuration audit, and the **bound stated rather than hidden** — this mode is not presented as spoof-proof | `domain/library` | P2 | `IMPL-625`, `IMPL-626` | `IMPL-679` | `ATT-FR-038`, `ATT-FR-039`, `ATT-XC-015` | Configuration changes emit an audit fact; no Owner-facing surface claims spoof resistance; no spoof-detection mechanism is specified — `ATT-GAP-007` stays open |
| `IMPL-628` | GPS as environment verification, the mode-4 flow, and tenant coordinates plus an acceptance radius | `domain/library` | P1 | `IMPL-612`, `IMPL-616` | `IMPL-629`, `IMPL-664` | `ATT-BR-018`, `ATT-XC-016`, `ATT-FR-040`, `ATT-FR-041`, `ATT-FR-042` | Location is never recorded as identity; coordinates and radius are tenant-scoped and read through the port; the radius has a bound |
| `IMPL-629` | Every GPS failure outcome, the evidence, the audit fact and the honesty bound on mock location | `domain/library` | P1 | `IMPL-628` | `IMPL-679` | `ATT-FR-043`–`ATT-FR-050`, `ATT-BR-019`, `ATT-XC-017` | Location-unavailable, permission-denied, accuracy-below-threshold and outside-radius are four distinguishable reasons, none creating a record and none downgrading to plain Fixed QR; no mock-location detection is implemented and no surface claims it — `ATT-GAP-008a` stays open |

### 5.4 Wave 4 — Face verification, its prohibitions, and the blocked build (`IMPL-630` … `IMPL-639`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-630` | This module owns the **meaning** of an attendance scan and owns no device — no Device Management context, no generic device lifecycle. ⛔ **BLOCKED: `ATT-GAP-009`** — no V1 context owns a face scanner's lifecycle | `domain/library` | P1 | `IMPL-600`, `IMPL-602` | `IMPL-631`, `IMPL-632` | `ATT-FR-107`, `ATT-FR-108`, `ATT-BR-039`, `ATT-XC-021` | The module defines what a scan asserts and defines no device entity; an authentication device is not usable as an attendance scanner; **the deliverable is the boundary and the recorded blocker, not a device model** — `ATT-GAP-009` stays open and no ownership is assumed |
| `IMPL-631` | Scanner association deferred to the designated owner rather than invented here. ⛔ **BLOCKED: `ATT-GAP-009`** | `domain/library` | P2 | `IMPL-630` | `IMPL-638` | `ATT-FR-109` | No scanner registry, pairing flow or device identity is created; the requirement is met by the association being obtained from the owner once designated — until then the path is refused with a recorded reason |
| `IMPL-632` | Face as an independent attendance path and **not** an authentication method — plus the §12.1 flow shape | `domain/library` | P1 | `IMPL-611`, `IMPL-630` | `IMPL-633` | `ATT-BR-020`, `ATT-XC-018`, `ATT-FR-051` | Face requires no QR, GPS, Wi-Fi or RFID; no session, token or login is issued by a face match |
| `IMPL-633` | Face enrollment with recorded consent before any capture, tenant-scoped. ⛔ **BLOCKED: `ATT-GAP-012`, `ATT-GAP-014`** — nobody owns a face template and erasure is a legal conflict | `domain/library` | P1 | `IMPL-632` | `IMPL-634`, `IMPL-635`, `IMPL-639` | `ATT-FR-052`, `ATT-FR-053`, `ATT-BR-021` | Attendance by face without enrollment is impossible; capture without recorded consent is impossible; an enrollment at one library never applies at another. **No template store, format or location is chosen** — both gaps stay open |
| `IMPL-634` | The refusal to design biometric storage, and withdrawal that never deletes attendance history. ⛔ **BLOCKED: `ATT-GAP-012`** | `domain/library` | P1 | `IMPL-633` | `IMPL-639` | `ATT-XC-020`, `ATT-BR-022` | No template format, encryption scheme, storage location or retention design appears anywhere in the module; withdrawal removes the enrollment and leaves every prior attendance fact intact |
| `IMPL-635` | Face matching to exactly one enrolled student, the confidence threshold, and the unknown-face rejection | `domain/library` | P1 | `IMPL-633` | `IMPL-636`, `IMPL-637`, `IMPL-638`, `IMPL-639`, `IMPL-665` | `ATT-FR-054`, `ATT-FR-055`, `ATT-FR-056` | A below-threshold match is **no match**, not a weak yes; an unknown face creates no record; a match resolves to exactly one student inside the tenant |
| `IMPL-636` | The three cases where the system must refuse rather than guess — multiple faces, two above-threshold matches, and the staff fallback path | `app` | P1 | `IMPL-635` | `IMPL-639` | `ATT-FR-057`, `ATT-FR-058`, `ATT-FR-059` | Multiple detected faces fail with a distinguishable reason; two above-threshold enrolled matches are ambiguous and create nothing; a failed match is reportable so the student is served by another enabled mode |
| `IMPL-637` | Face subject to the same duplicate and idempotency rules as every other mode, and check-out parity where the tenant uses check-out | `domain/library` | P1 | `IMPL-608`, `IMPL-635` | `IMPL-639` | `ATT-FR-060`, `ATT-FR-061` | A repeated face scan in the same student-day is absorbed by the same idempotency mechanism as Fixed QR; face check-out closes the same presence the state table governs |
| `IMPL-638` | The liveness signal recorded when the platform offers one, and the refusal to specify an algorithm. ⛔ **BLOCKED: `ATT-GAP-013`** — no biometric liveness capability exists in the ecosystem | `domain/library` | P2 | `IMPL-631`, `IMPL-635` | `IMPL-639` | `ATT-FR-063`, `ATT-XC-019` | Where a platform signal exists its outcome is recorded as evidence; no liveness or anti-spoofing algorithm, technique or threshold is defined here — `ATT-GAP-013` stays open |
| `IMPL-639` | Face lifecycle audit facts, and **the requirement that face verification not be built** until two named owners answer. ⛔ **BLOCKED: `ATT-GAP-012`, `ATT-GAP-014`, `ATT-GAP-015`** | `domain/library` | P1 | `IMPL-633`, `IMPL-634`, `IMPL-635`, `IMPL-636`, `IMPL-637`, `IMPL-638` | `IMPL-679` | `ATT-FR-062`, `ATT-FR-064` | Enrollment, re-enrollment, deletion and configuration change each emit an audit fact. **The mode is observably unavailable**: a test asserts face verification cannot be enabled while the two gaps are open and that the refusal carries the recorded reason rather than a generic error. This task implements the refusal, never the feature |

### 5.5 Wave 5 — Manual entry, register image, OCR failure path, audit (`IMPL-640` … `IMPL-649`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-640` | Manual attendance as a **first-class mode**, not a fallback — and the individual-entry flow of §13A | `app` | P1 | `IMPL-609`, `IMPL-610` | `IMPL-641`, `IMPL-642`, `IMPL-643` | `ATT-BR-023`, `ATT-FR-065`, `ATT-FR-066` | Manual is present in the mode enumeration on equal terms; the flow validates authorisation before recording; no surface describes it as temporary, degraded or emergency-only |
| `IMPL-641` | The fields a manual record must preserve, the prohibition on a manual entry becoming another method, and the tenant boundary on staff action | `domain/library` | P1 | `IMPL-640` | `IMPL-679` | `ATT-FR-067`, `ATT-BR-024`, `ATT-BR-025` | A manual record retains the student reference, date, time, method and acting staff member; its method never silently becomes QR, Face or automated; staff cannot record for a student outside the active tenant |
| `IMPL-642` | Manual entry under the same duplicate, sequence and idempotency rules as every other mode, with an audit fact naming the actor | `domain/library` | P1 | `IMPL-608`, `IMPL-640` | `IMPL-679` | `ATT-FR-068`, `ATT-FR-069` | A duplicate manual entry is absorbed identically to a duplicate scan; every manual entry produces an audit fact identifying the staff member |
| `IMPL-643` | The register-image capture workflow of §13B as **data-capture assistance**, never authentication and never identity. ⛔ **BLOCKED: `ATT-GAP-011`** — no context owns an OCR/Vision capability | `app` | P2 | `IMPL-640` | `IMPL-644`, `IMPL-645`, `IMPL-649` | `ATT-FR-070`, `ATT-FR-071`, `ATT-BR-026` | The workflow is built against a capability port with a fake and **defines no capability owner and no new edge** — the requested edge to `BC-27` is refuted by BC Map §7.4, not granted. No surface describes OCR as authentication or identity verification |
| `IMPL-644` | Every record from the register-image workflow carries the Manual method, and matching resolves only against authoritative student records | `domain/library` | P2 | `IMPL-643` | `IMPL-648` | `ATT-FR-072`, `ATT-FR-073` | No record from this workflow carries any method other than Manual; matching never invents, guesses or creates a student record and never bypasses the identity port |
| `IMPL-645` | An unresolved detection **never** becomes an attendance record | `domain/library` | P2 | `IMPL-643` | `IMPL-646`, `IMPL-647` | `ATT-FR-074`, `ATT-INV-009` | An undetectable, unreadable or unmatched entry produces no attendance fact by any path; the invariant is asserted against the aggregate directly, not only through the workflow |
| `IMPL-646` | Staff review of the source image and detected information, with an auditable rejection | `app` | P2 | `IMPL-645` | `IMPL-648` | `ATT-FR-075`, `ATT-FR-076` | Staff can view the image, inspect what was detected and accept or reject each entry; a rejection creates no record and is auditable |
| `IMPL-647` | The high-confidence threshold as a configurable, and the rule that confidence is **not self-certifying** | `domain/library` | P2 | `IMPL-645` | `IMPL-649`, `IMPL-665` | `ATT-FR-077`, `ATT-BR-027`, `ATT-BR-028` | The threshold is read through the configuration port; a high-confidence entry is presented for creation rather than created autonomously by default; a confidently-wrong detection is still wrong and correctable |
| `IMPL-648` | The audit relationship between image, detection and record — held **without** creating an attendance-private audit or file store. ⛔ **BLOCKED: `ATT-GAP-016`** — no retention rule exists for an image carrying third-party handwriting | `platform/audit` | P2 | `IMPL-644`, `IMPL-646` | `IMPL-649` | `ATT-FR-078`, `ATT-FR-079` | The relationship is retained through the existing audit port; no attendance-specific audit table or media store exists. **No retention period is set** — `ATT-GAP-016` stays open and the task records the blocker rather than choosing a number |
| `IMPL-649` | The workflow's own blocker, recorded as a requirement, plus accessibility parity for the Manual path. ⛔ **BLOCKED: `ATT-GAP-010`, `ATT-GAP-011`** | `app` | P3 | `IMPL-643`, `IMPL-647`, `IMPL-648` | `IMPL-679` | `ATT-FR-080`, `ATT-NFR-014` | A test asserts the register-image workflow is observably unavailable while both gaps are open, with the recorded reason rather than a generic failure; Manual-mode surfaces are no less accessible than app-based ones |

### 5.6 Wave 6 — Entry/exit determinism, time, duplicates, concurrency, volume (`IMPL-650` … `IMPL-659`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-650` | The deterministic entry/exit state table of §14.1 as the **only** logic resolving check-in and check-out | `domain/library` | P1 | `IMPL-608` | `IMPL-651`, `IMPL-653`, `IMPL-654`, `IMPL-655`, `IMPL-656`, `IMPL-657`, `IMPL-675` | `ATT-FR-081`, `ATT-INV-010` | Every row of the published table has a test; no branch outside the table decides a transition; at most one presence is open per student per tenant at any moment |
| `IMPL-651` | Optional check-out at tenant level, and a missed check-out treated as a recorded fact rather than repaired with an invented time | `domain/library` | P2 | `IMPL-650` | `IMPL-652`, `IMPL-666` | `ATT-BR-029`, `ATT-FR-082`, `ATT-BR-030`, `ATT-BR-031` | With check-out disabled the table's check-out rows are unreachable; an open presence past the boundary is flagged, never auto-completed with a fabricated timestamp, and never retracts the check-in |
| `IMPL-652` | A check-out event is published only for a check-out that actually happened | `platform/event` | P1 | `IMPL-604`, `IMPL-651` | `IMPL-676` | `ATT-FR-083` | A missed check-out emits no check-out event; the downstream occupancy owner therefore never sees a release that did not occur |
| `IMPL-653` | Concurrency determinism for check-in, check-out, and the two racing each other | `domain/library` | P1 | `IMPL-650` | `IMPL-659` | `ATT-FR-084`, `ATT-FR-085`, `ATT-FR-086` | Concurrent check-ins yield exactly one open presence; concurrent check-outs exactly one closed presence; a simultaneous check-in and check-out reaches a deterministic final state under repeated runs |
| `IMPL-654` | An invalid sequence rejected with a specific reason and no partial mutation | `domain/library` | P1 | `IMPL-650` | `IMPL-679` | `ATT-FR-087` | Each invalid transition in the table returns its own distinguishable reason and leaves the aggregate unchanged |
| `IMPL-655` | Every timestamp from the platform time port, evaluation against the rules in force at the moment of attendance, and explicit tenant time zone | `platform/services` | P1 | `IMPL-602`, `IMPL-650` | `IMPL-679` | `ATT-FR-088`, `ATT-FR-089`, `ATT-BR-032` | No client-supplied or server-local time reaches a punch; a later rule change does not retroactively alter a past decision; no timestamp is stored or compared without an explicit zone |
| `IMPL-656` | The refusal to build a second presence or "currently inside" system of record | `test` | P1 | `IMPL-650` | `IMPL-679` | `ATT-BR-033` | Architecture test: no occupancy counter, presence cache or currently-inside projection is defined in this module |
| `IMPL-657` | Idempotency enforced **inside** the aggregate, tenant-scoped, returning the original outcome on retry | `domain/library` | P1 | `IMPL-608`, `IMPL-650` | `IMPL-658`, `IMPL-659`, `IMPL-677` | `ATT-FR-090`, `ATT-FR-091`, `ATT-FR-092`, `ATT-BR-034` | A retry with the same key returns the first outcome and creates nothing; the key is tenant-scoped so two tenants cannot collide; the check is not a pre-read followed by an unguarded write |
| `IMPL-658` | Duplicate prevention **across** modes, and replay absorbed at both the code and transport levels | `domain/library` | P1 | `IMPL-619`, `IMPL-622`, `IMPL-657` | `IMPL-679` | `ATT-FR-093`, `ATT-FR-094`, `ATT-FR-095`, `ATT-BR-035` | A student who checks in by Fixed QR and is then entered manually has one presence, not two; a replayed dynamic code produces no second attendance; a replayed request is absorbed by idempotency |
| `IMPL-659` | Burst behaviour at 50+ concurrent arrivals with **no invariant relaxed** to achieve it, and contention confined to one student-day | `domain/library` | P2 | `IMPL-653`, `IMPL-657` | `IMPL-679` | `ATT-FR-096`, `ATT-BR-036`, `ATT-NFR-001` | Correctness is asserted under concurrent load rather than throughput being asserted; no batching across aggregates and no relaxed invariant appears in the fast path; two different students checking in do not contend |

### 5.7 Wave 7 — Owner configuration, configurables, device boundary, corrections (`IMPL-660` … `IMPL-669`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-660` | All attendance configuration read through the configuration port — and **no** settings store, hierarchy or feature-flag system of this module's own | `platform/data` | P1 | `IMPL-602` | `IMPL-661`, `IMPL-663`, `IMPL-664`, `IMPL-665`, `IMPL-666`, `IMPL-668` | `ATT-FR-097`, `ATT-FR-098`, `ATT-BR-037` | Every configurable is reached through the port with typed accessors and no raw string lookup; no local settings table exists; the Library module's stored selection is honoured and its behaviour is owned here |
| `IMPL-661` | Independent Owner control of each of the six modes, RFID absent from the V1 configurable set, and **no invented minimum-one-mode rule** | `app` | P1 | `IMPL-610`, `IMPL-660` | `IMPL-662` | `ATT-FR-099`, `ATT-FR-100`, `ATT-FR-106` | Each of the six toggles independently; RFID is not offered as a V1 mode; a tenant with every mode disabled is accepted rather than rejected — `ATT-GAP-018` stays open and no restriction is invented |
| `IMPL-662` | The seven mode and workflow enable/disable configurables | `platform/data` | P1 | `IMPL-661` | `IMPL-667`, `IMPL-668` | `ATT-CFG-001`–`ATT-CFG-004`, `ATT-CFG-016`–`ATT-CFG-018` | Each switch is read through the port, is tenant-scoped, and observably gates exactly one mode or workflow and no other |
| `IMPL-663` | The three Dynamic QR timing configurables | `platform/data` | P1 | `IMPL-621`, `IMPL-660` | `IMPL-667` | `ATT-CFG-005`, `ATT-CFG-006`, `ATT-CFG-007` | Rotation interval, validity window and single-use-per-student-day each change observable behaviour and are read through the port |
| `IMPL-664` | The five Wi-Fi and GPS environment configurables | `platform/data` | P1 | `IMPL-625`, `IMPL-628`, `IMPL-660` | `IMPL-667` | `ATT-CFG-008`–`ATT-CFG-012` | Approved networks, strictness, coordinates, radius and minimum accuracy are all tenant-scoped and read through the port; changing one alters only its own mode |
| `IMPL-665` | The five Face and OCR threshold configurables | `platform/data` | P2 | `IMPL-635`, `IMPL-647`, `IMPL-660` | `IMPL-667` | `ATT-CFG-013`–`ATT-CFG-015`, `ATT-CFG-019`, `ATT-CFG-020` | Enrollment-required, match threshold, liveness-required, OCR high-confidence threshold and unattended-creation are read through the port; the unattended-creation switch defaults to presenting rather than creating |
| `IMPL-666` | The four operational configurables — check-out tracking, staff correction, correction window, parent visibility | `platform/data` | P1 | `IMPL-651`, `IMPL-660` | `IMPL-667`, `IMPL-669` | `ATT-CFG-021`–`ATT-CFG-024` | Each is tenant-scoped, read through the port, and observably changes the behaviour it names; none disables an invariant |
| `IMPL-667` | A configurable whose default is unresolved **has no value and none may be substituted** — plus the operability check and the Owner-facing disclosure. ⛔ **BLOCKED: `ATT-GAP-017`** — seven configurables have no default, a live `LIB-16.2` breach | `app` | P1 | `IMPL-662`, `IMPL-663`, `IMPL-664`, `IMPL-665`, `IMPL-666` | `IMPL-679` | `ATT-BR-038`, `ATT-BR-043`, `ATT-BR-044`, `ATT-FR-149`, `ATT-FR-150`, `ATT-FR-151` | A test asserts that each defaultless setting resolves to *no value*, that a mode requiring one is unavailable with a recorded reason rather than falling back to a guess, that **no attendance is accepted or rejected by evaluating a valueless setting**, and that a tenant configuring nothing is still fully operable. **No default is invented** — `ATT-GAP-017` stays open |
| `IMPL-668` | Configuration change validation, atomicity, effect timing, and the audit fact | `domain/library` | P1 | `IMPL-660`, `IMPL-662` | `IMPL-679` | `ATT-FR-101`–`ATT-FR-105` | An invalid value is rejected with a specific reason and the previous value survives; no change is partially applied; a change takes effect from the next operation and never retroactively; disabling a mode stops new attendance without altering existing records; every change emits an audit fact with the actor |
| `IMPL-669` | Corrections — append-only, actor and reason recorded, method immutable, history retrievable, window honoured, and **never silently** | `domain/library` | P1 | `IMPL-608`, `IMPL-609`, `IMPL-666` | `IMPL-675` | `ATT-FR-110`–`ATT-FR-116`, `ATT-BR-040`, `ATT-INV-011` | A correction appends and never destructively updates; it carries actor and reason; it cannot change the original recorded method; a missed check-out is correctable and the result shows both the original and the correction; a correction outside the configured window is refused; full history is retrievable by an authorised actor; no path mutates attendance without producing a correction record |

### 5.8 Wave 8 — Authorization, tenancy, audit, events, Seating boundary, NFRs, acceptance (`IMPL-670` … `IMPL-679`)

| Task | Scope | Module | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|---|
| `IMPL-670` | The four-way distinction of §19.1 and the six false equivalences that must never be claimed — plus authorisation delegated wholly to the identity context | `platform/identity` | P1 | `IMPL-609` | `IMPL-671` | `ATT-BR-041`, `ATT-BR-042`, `ATT-FR-117`, `ATT-FR-118` | No surface, payload, log line or document in the module equates a QR with authentication, GPS with identity, Wi-Fi with presence or a face match with a session; no role, permission model or RBAC evaluation is defined here; every operation is authorised by the identity context |
| `IMPL-671` | Parent read-only access, the no-role account, no cross-tenant role inheritance, fraud-signal recording, and the absolute prohibition on secrets | `platform/identity` | P1 | `IMPL-670` | `IMPL-679` | `ATT-FR-119`–`ATT-FR-123` | A parent cannot create, correct or delete any record; an account with no role in the active tenant behaves exactly as one with no access; a role at one library grants nothing at another; a detected fraud signal is recordable and emits its event; no record, evidence object, event payload, audit fact or log line contains a credential |
| `IMPL-672` | Multi-tenancy with **no exception** — every owned fact and configuration tenant-scoped, failing closed where context is missing | `platform/tenancy` | P1 | `IMPL-602`, `IMPL-608` | `IMPL-673`, `IMPL-678` | `ATT-INV-012`, `ATT-FR-124`–`ATT-FR-128` | Every listed artefact carries and is partitioned by tenant; a student reference never crosses a tenant boundary; no cache, index or key is constructed without the tenant; a missing or ambiguous tenant context fails closed rather than defaulting; a suspended tenant rejects writes |
| `IMPL-673` | Audit facts emitted fire-and-forget to the audit context, with no attendance-private audit store | `platform/audit` | P1 | `IMPL-604`, `IMPL-672` | `IMPL-679` | `ATT-FR-129`–`ATT-FR-133` | Emission is never awaited and never fails the operation; no local audit table exists; each listed occurrence produces a fact carrying actor and tenant; no fact carries a secret. **No retention period is set** — `ATT-GAP-005` stays open |
| `IMPL-674` | Exactly the four events of BC Map §9, named by the binding convention, published as facts with producer-side idempotency safety | `platform/event` | P1 | `IMPL-604`, `IMPL-605` | `IMPL-675` | `ATT-FR-134`–`ATT-FR-137` | A fifth event name is unrepresentable; an imperative name is rejected; a redelivered event does not represent a new fact; the module publishes facts and never commands, and **adds no consumer and no edge** — `ATT-GAP-003`, `ATT-GAP-004` and `ATT-GAP-010` stay open |
| `IMPL-675` | The four event payloads and their boundaries — what each carries, and the classes of data none may carry | `platform/event` | P1 | `IMPL-650`, `IMPL-669`, `IMPL-674` | `IMPL-676` | `ATT-EVT-001`–`ATT-EVT-004` | Each event carries a stable identifier, tenant and its declared payload shape; none carries credentials, evidence internals, biometric data, profile or membership detail; the fraud event additionally carries no raw evidence payload |
| `IMPL-676` | The Seating boundary — this module triggers, Seating owns occupancy, and neither holds a shadow copy of the other's record | `domain/library` | P1 | `IMPL-652`, `IMPL-675` | `IMPL-679` | `ATT-FR-138`–`ATT-FR-144`, `ATT-BR-045` | No seat allocation or layout is created, modified, deleted or read; the only contact is the event; no occupancy count is owned, computed or published here; attendance completes without the downstream having processed anything; an attendance QR cannot assign, transfer or release a seat and a seat QR cannot record attendance |
| `IMPL-677` | The offline conflict-resolution policy this module **defines** and the sync context executes — with every invariant preserved and Dynamic QR's offline behaviour left undefined. ⛔ **BLOCKED: `ATT-GAP-016a`** | `platform/data` | P1 | `IMPL-602`, `IMPL-608`, `IMPL-620`, `IMPL-657` | `IMPL-679` | `ATT-PO-011`–`ATT-PO-014`, `ATT-NFR-012` | A replayed punch preserves every §6.2 invariant and never overwrites a correction made while the device was offline; no offline capability is promised beyond what the sync edge authorises; a test asserts Dynamic QR has **no** offline path rather than a best-effort one — `ATT-GAP-016a` stays open |
| `IMPL-678` | Operational reads of this module's own aggregate, the refusal to own analytics, and notification-relevant occurrences emitted as facts | `app` | P2 | `IMPL-604`, `IMPL-672` | `IMPL-679` | `ATT-FR-145`–`ATT-FR-148` | Exposed figures are described as operational reads of current state, never as certified metrics; no metric definition, warehouse, time series or report engine exists here; notification emissions carry facts and never a channel, recipient or message |
| `IMPL-679` | The acceptance harness binding all 213 `ATT-AC-*` to named tests, plus the remaining non-functional obligations. ⛔ **BLOCKED: `ATT-GAP-017a`** — no Rank 1–5 latency or throughput figure exists, so none is asserted | `test` | P1 | `IMPL-601`, `IMPL-613`, `IMPL-614`, `IMPL-618`, `IMPL-623`, `IMPL-627`, `IMPL-629`, `IMPL-639`, `IMPL-641`, `IMPL-642`, `IMPL-649`, `IMPL-654`, `IMPL-655`, `IMPL-656`, `IMPL-658`, `IMPL-659`, `IMPL-667`, `IMPL-668`, `IMPL-671`, `IMPL-673`, `IMPL-676`, `IMPL-677`, `IMPL-678` | — | `ATT-NFR-002`–`ATT-NFR-011`, `ATT-NFR-013` | Every one of the 213 criteria resolves to at least one running test; burst correctness, reproducibility from recorded evidence, distinguishable rejection reasons, tenant isolation, no synchronous dependency on notification/audit/analytics, functioning while the seating context is unavailable, attendance still recordable when membership validity is stale, every obligation carrying a criterion, and every timestamp zone-explicit are each asserted. **No latency figure, throughput number or percentile target is stated anywhere** — `ATT-GAP-017a` stays open |

---

## 6. Traceability — task group → requirement → invariant → acceptance

Allocation rule 4 requires this table. The requirement, invariant and coverage figures are produced by
[`tool/docs_check/prd006_task_coverage.py`](../../../tool/docs_check/prd006_task_coverage.py), not counted by hand.

| Wave | Tasks | Requirements claimed | Invariants enforced | Acceptance criteria proven |
|---|---|---|---|---|
| **1** Boundary, ownership, ports, aggregate, invariants | `IMPL-600`–`609` | `ATT-FR-001`–`006`, `ATT-BR-001`–`003`, `ATT-XC-001`–`009`, `ATT-PO-001`–`010` | `ATT-INV-001`–`ATT-INV-008` | `ATT-AC-119`–`124` (ownership, roles, scope), `ATT-AC-168`–`184` (ports and downstream boundary) |
| **2** Modes, mode independence, Fixed QR | `IMPL-610`–`619` | `ATT-FR-007`–`020`, `ATT-BR-004`–`012`, `ATT-XC-010`–`012` | — *(the mode framework carries none of its own; §6.2's set is enforced in wave 1)* | `ATT-AC-001`–`013` (Fixed QR), `ATT-AC-125`–`129` (mode set and independence) |
| **3** Dynamic QR, Wi-Fi, GPS | `IMPL-620`–`629` | `ATT-FR-021`–`050`, `ATT-BR-013`–`019`, `ATT-XC-013`–`017` | — | `ATT-AC-014`–`023` (Dynamic QR), `ATT-AC-024`–`033` (Wi-Fi), `ATT-AC-034`–`045` (GPS) |
| **4** Face verification and the blocked build | `IMPL-630`–`639` | `ATT-FR-051`–`064`, `ATT-FR-107`–`109`, `ATT-BR-020`–`022`, `ATT-BR-039`, `ATT-XC-018`–`021` | — | `ATT-AC-046`–`061` (Face) — **including the criteria that prove the mode is unavailable** |
| **5** Manual entry, register image, OCR failure | `IMPL-640`–`649` | `ATT-FR-065`–`080`, `ATT-BR-023`–`028`, `ATT-NFR-014` | `ATT-INV-009` | `ATT-AC-062`–`070` (individual entry), `ATT-AC-071`–`076` (register image), `ATT-AC-077`–`086` (OCR failure → manual verification) |
| **6** Entry/exit, time, duplicates, concurrency, volume | `IMPL-650`–`659` | `ATT-FR-081`–`096`, `ATT-BR-029`–`036`, `ATT-NFR-001` | `ATT-INV-010` | `ATT-AC-087`–`098` (entry/exit determinism), `ATT-AC-099`–`106` (duplicate, concurrency, volume), `ATT-AC-144`–`152` (invariants, timing, concurrency) |
| **7** Configuration, configurables, device boundary, corrections | `IMPL-660`–`669` | `ATT-FR-097`–`106`, `ATT-FR-110`–`116`, `ATT-FR-149`–`151`, `ATT-BR-037`, `ATT-BR-038`, `ATT-BR-040`, `ATT-BR-043`, `ATT-BR-044`, all 24 `ATT-CFG-*` | `ATT-INV-011` | `ATT-AC-107`–`112` (owner configuration), `ATT-AC-153`–`167` (corrections, audit, authorization), and the configurable criteria of `ATT-AC-185`–`213` |
| **8** Authorization, tenancy, audit, events, Seating, NFRs, acceptance | `IMPL-670`–`679` | `ATT-FR-117`–`148`, `ATT-BR-041`, `ATT-BR-042`, `ATT-BR-045`, all four `ATT-EVT-*`, `ATT-PO-011`–`014`, `ATT-NFR-002`–`013` | `ATT-INV-012` | `ATT-AC-113`–`118` (tenancy, authorization, events, boundary), `ATT-AC-130`–`143` (mode-level rules), `ATT-AC-185`–`213` (exclusions, configurables, non-functional) — and, through `IMPL-679`, all **213** |

**Mechanically verified totals:**

| Register | Claimed / defined |
|---|---|
| `ATT-FR` | **151 / 151** |
| `ATT-BR` | **45 / 45** |
| `ATT-INV` | **12 / 12** |
| `ATT-EVT` | **4 / 4** |
| `ATT-XC` | **21 / 21** |
| `ATT-PO` | **14 / 14** |
| `ATT-CFG` | **24 / 24** |
| `ATT-NFR` | **14 / 14** |
| **TOTAL obligations** | **285 / 285 = 100.0%** |

> **Why `ATT-AC-*` and `ATT-GAP-*` are outside that denominator, stated rather than assumed.** An `ATT-AC-*` is a
> criterion *verified by* a task's test, not a thing a task *builds*; `IMPL-679` is the task that proves all 213 are
> bound to running tests. An `ATT-GAP-*` is an **open question** — `PRD-006` §0.4 states gaps *"are not requirements,
> they are not deferred requirements, and they may not be satisfied by an implementer choosing an answer."* Counting
> either would inflate coverage while making it mean less. `PRD-006`'s **516** identifiers minus **213** `ATT-AC-*`
> minus **18** `ATT-GAP-*` = **285**, the figure above, and the same figure `PRD-006` §0.3 publishes as its
> obligation-bearing count. This is the denominator rule `PRD-005` used (333 − 97 − 13 = 223) and `PRD-007` used
> (683 − 226 − 14 = 443), applied to a third register rather than reinvented.

**The invariant column partitions cleanly, and that is a property of this PRD rather than a tidy-up.** Eight of the
twelve invariants are the §6.2 aggregate set and are all enforced in wave 1 by `IMPL-608`; the remaining four are
each stated in the section whose behaviour they govern — OCR (`ATT-INV-009`), presence (`ATT-INV-010`), corrections
(`ATT-INV-011`) and tenancy (`ATT-INV-012`) — so each falls in exactly one later wave. No invariant is claimed
twice and none is unclaimed.

**The acceptance-criteria column is an allocation, not a proof.** `ATT-AC-*` are grouped to the wave whose behaviour
they exercise, following `PRD-006`'s own §30.1–§30.19 sectioning, so an implementer knows which criteria their wave
should make pass. Three bands legitimately appear against more than one wave — `ATT-AC-130`–`143` (§30.15,
*"mode-level rules not covered above"*) and `ATT-AC-185`–`213` (§30.19, exclusions plus configurables plus NFRs)
span work in waves 2–4 and waves 7–8 respectively, because the PRD's own criteria sections cut across its mode
sections. That is stated here rather than hidden. The binding of each individual criterion to a named test is
`IMPL-679`'s deliverable and is **not** claimed as done.

### 6.1 How much of the coverage is actually reachable

100% coverage is not the same as 100% buildable, and stating only the first figure would be the more flattering of
two true statements. Partitioning the 285 obligations by whether **any** unblocked task claims them:

| Reachability | Count | Share |
|---|---|---|
| Claimed by at least one **unblocked** task | **242** | 84.9% |
| Reachable **only** through a ⛔ blocked task | **43** | 15.1% |
| Claimed by no task | **0** | 0% |

The 43 divide into four groups, each traceable to a named authority rather than to a difficulty: the **Face** block
(`ATT-FR-052`, `053`, `062`–`064`, `107`–`109`, `ATT-BR-021`, `022`, `039`, `ATT-XC-019`–`021`) behind
`ATT-GAP-009`/`012`/`013`/`014`/`015`; the **register-image and OCR** path (`ATT-FR-070`, `071`, `078`–`080`,
`ATT-BR-026`) behind `ATT-GAP-010`/`011`/`016`; the **valueless configurables** (`ATT-FR-149`–`151`, `ATT-BR-038`,
`043`, `044`) behind `ATT-GAP-017`; and the **offline and non-functional** set (`ATT-PO-011`–`014`,
`ATT-NFR-002`–`014`) behind `ATT-GAP-016a`/`017a`.

> **This is the number a reader should take from §6, not the 100%.** Every obligation has a path *or* a documented
> blocker — which is what the Stage 6 gate asks — but roughly one obligation in seven cannot be started until someone
> with authority answers a question. The `ATT-NFR-*` concentration is the sharpest case: 13 of 14 non-functional
> obligations sit behind `IMPL-679`, so the module's quality bar is the last thing that becomes assertable and the
> first thing a schedule would be tempted to drop.

---

## 7. Critical path — computed, not asserted

Derived from the `Blocked by` column by the same script that checks it, so the claim is reproducible:

```
600 → 602 → 609 → 640 → 643 → 645 → 646 → 648 → 649 → 679
```

**Longest chain: 10 of 80 tasks.** Graph facts, also computed: **0 cycles**; exactly **one root** (`IMPL-600`);
exactly **one leaf** (`IMPL-679`); `Blocks`/`Blocked by` disagreements **0**. Priorities: **64 × P1, 15 × P2,
1 × P3**.

**The critical path runs through the OCR workflow, and that is worth noticing rather than admiring.** The longest
chain is not the Fixed QR path a reader would expect; it is the register-image path, because §13B's workflow is the
only one in the PRD with a genuinely sequential shape — capture, then detect, then review, then audit, then the
recorded blocker. **Every task on that chain from `IMPL-643` onward is either blocked or downstream of a blocked
task** (`ATT-GAP-011`, and `ATT-GAP-010` and `ATT-GAP-016` behind it). The longest path in this backlog is therefore
also the one least likely to be walked, which is a fact about `PRD-006`'s open questions and not a modelling
artefact.

**`IMPL-600` is the only root.** Every path runs through the bounded-context boundary because `ATT-FR-001` and
`ATT-FR-002` make the ownership split — what this module owns versus the six things it must not — the precondition
for everything else. Even `IMPL-660` (the configuration surface) depends on `IMPL-602`, since `ATT-FR-097` requires
configuration to arrive through the `E-19` port rather than by direct lookup.

**`IMPL-679` is blocked by every otherwise-terminal task, and that list is derived, not typed.** The harness binds
all 213 criteria, so it cannot begin until each task nothing else depends on has landed — **23** such tasks, computed
from the graph rather than enumerated by hand. Computing the edge set caught a defect during authoring that a
hand-written list would have carried: `IMPL-672` (multi-tenancy) and `IMPL-671` (authorization) would both have been
left outside the harness's ancestry although `ATT-AC-113`–`118` require exactly that work.

**Do not start `IMPL-678` early to show visible progress.** Operational reads are the part a stakeholder can see,
and it sits late for a reason: `ATT-FR-146` forbids this module owning a metric, and a figure built before
`IMPL-672` (tenancy) has nothing correctly scoped to read. The shortcut is a running counter, which `ATT-BR-033` and
`ATT-BR-036` both forbid.

**`IMPL-657` and `IMPL-608` must not be merged into one task.** `ATT-BR-034` requires idempotency to be enforced
*"inside the aggregate boundary, not by a pre-check followed by a write"* — the invariant set and the idempotency
mechanism are two things with two distinct failure modes, and a pre-check that passes before a concurrent write is
exactly the defect `ATT-FR-090` exists to close. `IMPL-653` is the task whose test exercises both together under
real concurrency.


---

## 8. Tasks that must **not** be created

| Tempting task | Why it must not exist |
|---|---|
| "Add a staff punch-in screen while we're here" | `ATT-XC-001`. Staff attendance is `BC-07` HR & Staff, which is **V2**. A staff member's presence is an employment record, not a student-day fact, and this aggregate cannot represent one |
| "Extract attendance into its own service so scanning scales" | `ATT-XC-002`, `ADR-0001`. The module is a bounded context **inside the monolith**. `ATT-FR-096`'s 50-concurrent-scan target is met inside the process or not at all |
| "Add a `BC-26` Analytics client so the attendance dashboard has data" | `ATT-XC-003`, `ATT-FR-137`, **`ATT-GAP-003` open**. BC Map §9 names `BC-26` a consumer of three events; §7 declares no `BC-03` → `BC-26` edge. `ADR-0018` §3.2 puts resolution with the architecture owner and a separate ADR. Frozen `PRD-004` and `PRD-005` both declined; this backlog follows them |
| "Call Trust & Safety when a fraud signal fires" | `ATT-XC-003`, `ATT-FR-137`, **`ATT-GAP-004` open — and materially worse than `003`**. BC Map §6 rule 2: T&S *"acts **on** other contexts, not beside them… **T&S never reaches into their models**."* `E-14`'s targets are `BC-11`, `BC-12`, `BC-14`, `BC-15` — `BC-03` is not among them, so it is not even a self-restriction subscriber. There is **no authorised path in either direction** to build against |
| "Upload the register image to File & Media" | `ATT-XC-004`, **`ATT-GAP-010` open**. `E-22`'s consumer list excludes `BC-03`. `ADR-0016` is the known precedent for adding a consumer — which is exactly why this is an **ADR**, not a task. Unlike `ADR-0016`'s trigger, no Rank 3 requirement compels the inclusion, so the case is weaker |
| "Send the register photo to the AI service to run the OCR" | `ATT-XC-005`, **`ATT-GAP-011` narrowed, ownership still open**. BC Map §7.4 `F-1`/`F-3`/`F-4` **refute** the requested `BC-03` → `BC-27` edge rather than granting it, and `BC-27`'s charter contains no vision function. Which context owns an OCR capability is unanswered; building one here answers it by default |
| "Add fuzzy student search to the manual-entry screen" | `ATT-XC-006`, `ATT-FR-070`. `E-21`'s consumers are `BC-01` and `BC-10`. A branch-bounded exact lookup through the `ATT-PO-*` port is adequate and is this module's own |
| "Join the student-profile table to render names on the register" | `ATT-XC-007`, `ATT-BR-002`, `L3`. The Single Owner Rule is not relaxed for a read. Names arrive through `ATT-PO-001`…`ATT-PO-003` or they do not arrive |
| "Keep the session token in `VerificationEvidence` to debug a failed scan" | `ATT-XC-008`, `ATT-FR-123`, `ATT-FR-133`, `ID-1`. Evidence describes **what was verified, never who the person is or how they authenticated**. This is the one where a debugging convenience becomes a credential store |
| "Wrap check-in and seat occupancy in a single transaction so they can't diverge" | `ATT-XC-009`, `ATT-NFR-013`, `ATT-FR-142`. Attendance is complete when the attendance write commits. `SEAT-FR-115` already makes occupancy advisory and non-corrupting, which is the design's answer to divergence |
| "Add an NFC tap mode — the reader hardware is already on the desk" | `ATT-XC-010`, §33. RFID, NFC and BLE are **Future/V3**. V1 has **six** modes and a seventh is a scope decision, not a task |
| "Build a `VerificationStrategy` pipeline so the six modes plug in uniformly" | `ATT-XC-011`, `ATT-BR-004`. The modes are **independent and each sufficient alone**; a shared pipeline creates the cross-mode coupling `ATT-BR-005` exists to forbid, and makes `IMPL-611`'s independence test unwritable |
| "Sign the dynamic code with HMAC-SHA256 on a 30-second window" | `ATT-XC-013`, **`ATT-GAP-006` open**. Every part of that sentence — construction, algorithm, key length, rotation period — is Security Platform's to decide. Secrets are `BC-25`'s **references** only. Choosing one here is a security design, which §0.4 forbids in those words |
| "Detect a spoofed SSID so Wi-Fi mode is trustworthy" | `ATT-XC-015`, `ATT-FR-039`, **`ATT-GAP-007` open**. No source authorises spoof detection or defines how a network is technically identified. `ATT-FR-039` requires the mode **not** be presented as anti-proxy until the gap is answered — a detector would present it as exactly that |
| "Add mock-location detection to GPS mode" | `ATT-XC-017`, `ATT-FR-050`, **`ATT-GAP-008a` open**. Same shape as the row above, same prohibition, same unanswered owner |
| "Reuse the library's Map Location as the geofence centre" | **`ATT-GAP-008` open**. `LIB-6.5` Map Location is a **Rank 3** field owned by `BC-06` and is silent on attendance use. Merging the two values takes ownership of someone else's field to save a configuration screen |
| "Implement face verification behind a disabled feature flag so it's ready" | **`ATT-FR-064` blocks the build outright**; **`ATT-GAP-012` and `ATT-GAP-014` both open**. A flag does not soften a build block — the code is still written, the storage shape still chosen, the ownership question still answered by whoever typed first. `IMPL-630`…`IMPL-639` exist to hold this boundary, not to route around it |
| "Store the face template encrypted in the attendance tables" | `ATT-XC-020`, **`ATT-GAP-012` open**. The storage sub-question is answered **negatively**: with no `E-22` path, `BC-03` cannot store a template at all. "Encrypted" is not the missing part; the authority to hold it is |
| "Add a liveness / anti-spoof check to face capture" | `ATT-XC-019`, **`ATT-GAP-013` open**. Repository-wide, the only `liveness` hits are **infrastructure health probes**. No biometric liveness capability exists to call |
| "Write the biometric erasure routine so we're GDPR-clean" | `ATT-XC-020`, **`ATT-GAP-014` open — a conflict, not a void**. `ID-5`/`MP-GBR-04` promise erasure by **pseudonymisation**, which is structurally inapplicable to a template that *is* the identifier. Legal counsel and Security Platform must resolve the contradiction; an implementer cannot |
| "Classify Face as V1 because the brief asks for it" | **`ATT-GAP-015` open**. EA v2.1 lists `Face Recognition (V3)` but is **Rank 6, descriptive** — Baseline §4: *"Update it to match 1–5; never the reverse."* EA cannot force V3, **and no Rank 1–5 document places Face in V1 either**. Neither direction is ratifiable from sources |
| "Register the face scanner and manage its lifecycle here" | `ATT-XC-021`, `ATT-BR-039`, **`ATT-GAP-009` open**. `BC-18` owns `Device` in the *authentication* sense; `BC-08` owns physical devices but is **V2**. **No V1 context can own a V1 scanner's lifecycle** — a real hole between two contexts, neither of which can take it |
| "Pick `0.85` for the OCR confidence threshold — any sane number works" | `ATT-BR-043`, **`ATT-GAP-017` open**. Seven configurables have no default and `LIB-16.2` requires one, so this **is** a live breach. Inventing seven numbers *"would satisfy the letter and destroy the point."* `ATT-FR-149`/`ATT-FR-150` specify the behaviour in the **absence** of a value; that is the whole of the permitted work |
| "Set the retention period to 2 years — the BC Map says so" | **`ATT-GAP-005` open**. BC Map `Q-04` is open **in the authoritative document itself** (L543) and carries only an unratified note. A PRD may not promote an architecture document's own open question to an answer, and a task may not either |
| "Set a retention period for the register image" | **`ATT-GAP-016` open**. No retention source exists, and §13E records the aggravating factor: the image carries **third-party handwriting**. Legal counsel |
| "Auto-create attendance from high-confidence OCR rows" | `ATT-BR-027`, `ATT-BR-028`. Confidence is **not self-certifying**; high-confidence entries are **presented for confirmation**, not created. The default is not a tuning knob |
| "Auto-close a missed check-out at closing time" | `ATT-BR-030`, `ATT-BR-031`, `ATT-FR-143`. A missed check-out is a **recorded state**, not a defect to be tidied. Inventing the timestamp also emits `ATT-EVT-002` for an event that did not occur |
| "Cache validity so Dynamic QR works offline" | `ATT-PO-014`, `ATT-NFR-012`, **`ATT-GAP-016a` open**. A rotating server-validated code **cannot** be validated offline; `ATT-AC-184` forbids any surface, string or setting promising otherwise. This is also the fail-closed rule: an offline scan fails, it does not assume valid |
| "Set the check-in latency budget at p95 ≤ 500 ms so the NFR is testable" | **`ATT-GAP-017a` open**. No Rank 1–5 document states a latency or throughput figure and EA states none. `IMPL-659` asserts **correctness** under 50+ concurrent arrivals, which is what `ATT-FR-096` and `ATT-NFR-001` actually require, and `IMPL-679` carries the gap unresolved. Neither may convert a measurement into a budget, because a budget nobody ratified becomes the number the next reviewer treats as a requirement |
| "Show a live 'currently inside' count on the dashboard" | `ATT-BR-033`, `ATT-FR-140`, `ATT-FR-146`, `ATT-BR-045`. A second presence system of record. Occupancy is `BC-04`'s (`E-08`: *"Seating is the occupancy owner, Attendance is the trigger"*) and the metric layer is `BC-26`'s |
| "Reconcile a disputed attendance record against seat occupancy" | `ATT-BR-045`. Explicitly: *"**the attendance record is never reconciled backwards from occupancy**."* The arrow has one direction and it is not this one |
| "Emit `attendance.ReminderRequested` so parents are notified" | `ATT-FR-134`, `ATT-FR-135`, `ATT-FR-148`. The event register is **closed at four** by BC Map §9, and an imperative name is a **command**, not a fact. `BC-22` decides channel and recipient |
| "Define an `AttendanceOperator` role for reception staff" | `ATT-FR-118`, `ATT-FR-117`. `BC-18` owns the authorisation model; this module **evaluates nothing**. A new role needs an ADR |
| "Enforce 'at least one mode must be enabled'" | `ATT-FR-106`, **`ATT-GAP-018` open**. No source authorises the constraint. `ATT-AC-209` **preserves the permissive behaviour** rather than inventing a restriction that feels safer |
| "Add a per-library settings table so configuration is fast" | `ATT-FR-097`, `ATT-FR-098`, `ADR-0017`. Configuration is `BC-25`'s, reached through `E-19`. A local settings table is a second configuration system with its own divergence mode |
| "Let a correction change the recorded method to the one that actually happened" | `ATT-FR-112`, `ATT-BR-024`. The method of the original punch is immutable; a manual entry **never silently becomes another method**. Correct the times, not the history |
| "Waive the 9 cross-context violations so gate 3 goes green" | `BLK-01`. Real debt owned by `TASK-D10`, `ADR-0012` expiry 2026-10-31. A waiver converts a tracked breach into an untracked one |

**Thirty-seven tasks a competent engineer might reasonably add, each mapped to the rule it would break** — counted
from the table above, not estimated. They are listed so their absence is visible as a **decision** rather than an
oversight, the same reason `PRD-007`'s backlog lists nineteen, `PRD-005`'s fourteen and `PRD-004`'s six.

**Twenty of the thirty-seven would close an `ATT-GAP-*` by writing code**, which §0.4 forbids in these words:
*"A gap resolved by implementation choice is not resolved — it is an undocumented architecture decision made by
whoever happened to write the code first."* Those twenty rows reference **19 distinct gaps: all 18 that §32.1
records as `OPEN`, plus the one it records as `NARROWED` (`ATT-GAP-011`)** — a narrowed gap still has an unanswered
half, and its remaining half (which context owns an OCR capability) is exactly what a task would answer by default.
No open gap is left without a corresponding forbidden task, and that completeness is deliberate: a gap with no
tempting task attached to it is a gap nobody has yet been tempted to close, and it would be the next one closed by
accident.

> **The `ATT-GAP-017a` row was added because the check found it missing, not because it was foreseen.** The first
> draft of this table covered 18 of the 19 gaps; a mechanical comparison against §32.1's verdict column named the
> omission. It is recorded here rather than quietly patched, because the omission is the evidence that the check is
> worth running — a latency budget is the single easiest gap to close by accident, since inventing a number *feels*
> like engineering rigour rather than like an unratified decision.

> **The proportion is the finding, not the list.** Over half of what a reasonable engineer would build next is
> blocked by a question nobody has answered. That is a statement about `PRD-006`'s readiness, not about the
> engineer — and it is why §2's Stage 3 and Stage 4 verdicts are **⚠️ CONDITIONAL** rather than ✅.

---

## 9. What this document does **not** claim

| Not claimed | Actual state |
|---|---|
| That any task is started | **Zero.** No `lib/` file created or modified. §5 is a backlog, not a progress report |
| That `PRD-006` is frozen | It is **`DRAFT`**. Stage 6 makes it *eligible* for a Stage 7 proposal and nothing more |
| That Stage 3 or Stage 4 passed | Both were **performed** and both returned **⚠️ CONDITIONAL**. A conditional verdict is not a pass, and §2 records it as a constraint on these tasks rather than as a cleared prerequisite. This is where `PRD-006` differs from `PRD-007`, whose Stage 4 was an unqualified **PASS** — that document's ✅ wording is **not** reused here |
| That the registry was updated | `PRD_REGISTRY.md` still records `PRD-006` as **`PLANNED`** and is **byte-identical**. Status is conferred by admission to the baseline, never self-declared |
| That the traceability matrix was updated | `TRACEABILITY_MATRIX.md` is **byte-identical**. Stage 5 registered the prefixes in §2F; Stage 6's gate names no matrix edit, and `PRD-005`'s and `PRD-007`'s Stage 6 made none |
| That an ADR was created | **None.** No ranked document changed, so `DOCUMENTATION_BASELINE.md` §7 is not triggered |
| That estimates exist | **None is given.** No sizing was requested. An invented figure would be the same defect class as an invented default — a number with no source that a later reader treats as a commitment |
| That 80 tasks complete `BC-03` | They cover `PRD-006` v1.3's **285 obligations**. The **18 open `ATT-GAP-*`** remain undecided and unimplemented, and **12** tasks are blocked behind them |
| That the 12 blocked tasks can be unblocked by better engineering | Each is blocked by a **decision**, not a difficulty. §4 names the authority for each: architecture owner, product owner, legal counsel or Security Platform. No amount of implementation skill closes one |
| That face verification is deliverable | `IMPL-630`–`639` exist to record the boundary. `ATT-FR-064` **blocks the build outright** while `ATT-GAP-012` and `ATT-GAP-014` are open, and `ATT-GAP-015` leaves even the version class unratified |
| That the seven valueless configurables have values | They do not. `IMPL-667` implements `ATT-BR-043`/`ATT-FR-149`/`ATT-FR-150`/`ATT-FR-151` — the behaviour in the **absence** of a value — and is itself ⛔ blocked on `ATT-GAP-017`, which stays open. The `LIB-16.2` breach remains a breach |
| That the 213 `ATT-AC-*` are bound to tests | They are **allocated to waves** in §6. Binding each to a named test is `IMPL-679`'s deliverable, and `IMPL-679` is itself blocked |
| That the wave→`ATT-AC-*` mapping is exhaustive per wave | It follows `PRD-006` §30's own sectioning. Where the PRD's criteria span two waves the band is shared, and §6 states that rather than hiding it |
| That `IMPL-600`…`679` are in the roadmap register | They are declared **here** and nowhere else yet. `IMPLEMENTATION_ROADMAP.md` and `PRD_LIFECYCLE.md`'s Stage 6 table still end at `IMPL-227+` |
| That the stale `IMPL-227+` tables were corrected | They were **not**, and correcting them was not attempted. Four documents now carry the stale claim; §3.3 records which and why amending a governance document is out of scope for a backlog. `PRD-004` §7 and `PRD-005` §3.3 recorded the same staleness and also left it |
| That gate 3 will be green | It is **red** and stays red until `TASK-D10`/`BLK-01`. `ADR-0012` expiry 2026-10-31. The 9 violations are real debt and **must not be waived** |
| That the upstreams exist | `PRD-004` and `PRD-005` are frozen but **unimplemented**; `PRD-007` is frozen and unimplemented; `PRD-023` (`BC-25` Configuration) is unwritten though `ATT-FR-097` depends on it. See §4 |
| That module paths are architecture decisions | The `Module` column reuses the **existing** rank map. No new module is proposed, no directory is created, and no file path is specified |
| That the critical path is a schedule | §7's 10-task chain is a **graph property**, not a plan. Every task on it from `IMPL-643` onward is blocked or downstream of a blocked task, so the longest path is also the one least likely to be walked |
| That anything here is a specification | No schema, SQL, DDL, API shape, endpoint, payload format, widget tree, class signature, table name or column is written. §5's `Scope` cells describe **obligations**, and its `Test requirement` cells describe **what must be true**, not how |

---

## 10. Definition of done — applies to every task

A task is done when **all** hold. Items 3 and 4 block merge (`TRACEABILITY_MATRIX.md` §10.4).

1. `dart format --set-exit-if-changed .` → exit 0
2. `flutter analyze` → `No issues found!`
3. `dart run tool/check_module_boundaries.dart` → **no new violation** (the 9 existing `TASK-D10` violations are pre-existing and **must not be waived**)
4. `flutter test test/architecture/` → all pass
5. `flutter test` → all pass, **including the task's own new test**
6. The `ATT-*` requirements in the task's Requirements cell are each asserted by at least one test
7. No frozen document modified; no integration edge used beyond the **six inbound BC Map edges** of §5.2 (`E-03`, `E-04`, `E-17`, `E-18`, `E-19`, `E-24`) and the **three outbound** of §5.3 (`E-08`, `E-20`, `E-23`) — `ATT-PO-007` is deliberately **edgeless**, the already-authenticated actor arriving without a `BC-03` → `BC-18` edge per `ATT-GAP-002`'s resolution
8. `python3 tool/docs_check/prd006_task_coverage.py` → exit 0 *(if the task row itself changed)*

> **Item 6 is the one that is usually skipped.** A task can pass items 1–5 while asserting nothing about its
> requirements. `ATT-NFR-010` and `SID-4.56` treat such a requirement as **unmet**, not as satisfied by intent.

> **Item 7 has a specific edge here.** §5.2 closes the inbound edge set at six and `ATT-XC-007` forbids reading another
> context's tables. A task that queries a `BC-01`, `BC-02`, `BC-04` or `BC-18` table to avoid building a port passes
> items 1–5 and violates the Single Owner Rule that `ATT-XC-007` makes a defect. `IMPL-605` exists so that the four
> **non-existent** edges — Analytics, File & Media, AI Assistance, Search Indexing — fail as structural
> impossibilities rather than as review findings.

> **A ninth item applies to the 12 blocked tasks, and it is not a test.** A blocked task is done when its
> **boundary** is asserted and its gap is still open — `IMPL-630` is done when face verification is *unbuildable*,
> not when it works. Any commit that makes a blocked task's capability function has closed an `ATT-GAP-*` by
> implementation choice, which §0.4 forbids, and item 8's gap check is what catches it.

---

## 11. Stage 6 exit gate — re-runnable

```
python3 tool/docs_check/prd006_task_coverage.py     → exit 0
```

The gate fails if any of the following becomes true: a task has an empty **Requirements** cell; a task cites an
`ATT-*` identifier `PRD-006` does not define; a task cites an `ATT-GAP-*` as an obligation; an `IMPL-*` is
duplicated, falls outside `IMPL-600`…`IMPL-679`, or collides with `IMPL-014`–`073` / `100`–`127` / `200`–`226` /
`300`–`323` / `400`–`499` / `500`–`599`; a **Blocked by** entry names no known task; a **Priority** cell is blank;
**Blocks** and **Blocked by** disagree for a local pair; the dependency graph acquires a cycle; or any of the **285**
obligations loses its last claiming task.

Current result — **PASS**:

```
Tasks parsed 80 · unique 80 · duplicates 0 · out of range 0 · foreign collisions 0
Allocation span IMPL-600..679 · holes 0
Tasks with no requirement 0 · undefined citations 0 · malformed ranges 0
Unresolvable dependencies 0 · missing Priority 0 · Blocks/Blocked-by disagreements 0
Cycles 0 · longest chain 10 · roots 1 · leaves 1
Priorities P1 64 · P2 15 · P3 1
Tasks marked BLOCKED 12 · BLOCKED without a named gap 0
Coverage 285/285 = 100.0%   (excluded: 213 ATT-AC verified by tests, 21 ATT-GAP questions)
```

> **The gate was tested against 12 deliberate mutations before this result was accepted**, because a check that has
> only ever returned PASS has not been shown to be capable of returning FAIL. A duplicated identifier, an
> out-of-range identifier, a collision with the seat range, an emptied Requirements cell, a citation to a
> non-existent requirement, a gap cited as an obligation, a dangling dependency, a one-sided `Blocks` entry, an
> introduced cycle, a blanked `Priority`, a dropped obligation and a `BLOCKED` marker with its gap reference stripped
> were each injected in turn. **All 12 produced exit 1 and named the offending task**; the file was then restored and
> verified byte-identical to its pre-mutation state.

> **Running this gate revealed that the Stage 5 gate is sensitive to this file's existence, and that was fixed here
> rather than there.** `prd006_traceability.py` treats an `ATT-<REG>-<n>` token found anywhere under `tool/` as a
> namespace collision, exempting only itself. The first draft of `prd006_task_coverage.py` quoted six such
> identifiers in its docstring and so turned the **passing** Stage 5 gate red. The identifiers were reworded
> descriptively in the new file; **`prd006_traceability.py` was not modified**, because loosening a sibling gate to
> accommodate a new file is how a namespace check stops being one.

**One pre-existing failure is widened by one line and is disclosed rather than hidden.**
`prd007_traceability.py` exits 1 on two problems, both of which are `PRD-006` sibling documents citing `SEAT-*`
identifiers — `PRD-006_VERIFICATION_REPORT.md`, `PRD-006_REQUIREMENTS_REVIEW.md`, the PRD itself (18 citations) and
two others. This file adds **exactly one** such line: §8's single-transaction row cites **`SEAT-FR-115`** (§5's
`IMPL-676` row states the Seating boundary using only `ATT-*` identifiers, and was checked rather than assumed). It
is **a citation, not a definition** — inspected at its line, per the §2C.1 principle that *a bare-substring hit must
be inspected at its line, not counted as a failure*. The problem **count is unchanged at two**, no new failure class
is introduced, and the practice follows `PRD-006`'s own: a document that must state a boundary against Seating has to
name the requirement on the other side of it.

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created as the **Stage 6** gate artefact for `PRD-006` v1.3 **DRAFT**. Allocated **`IMPL-600` … `IMPL-679`** — 80 tasks in 8 waves, contiguous with 0 holes — after enumerating every `IMPL-*` in the repository (247 distinct tokens) rather than reading `PRD_LIFECYCLE.md`'s stale `IMPL-227+` table, and after inspecting both `IMPL-600` tokens at their source lines to confirm they are `PRD-007` §3.2's *"Unallocated"* markers rather than uses — applying `PRD-007`'s own principle that *"a maximum cannot distinguish an allocation from a marker."* **No reserve needed skipping**, because `PRD-007` declared none; that is a finding about `PRD-007`, not a licence, so `IMPL-680`–`699` is reserved here (rule 2) against the 18 open gaps. Records `Priority`, `Blocks` and `Blocked by` per task (rule 3) and the group→requirement→invariant→acceptance table (rule 4). Coverage is **computed, not asserted**: `tool/docs_check/prd006_task_coverage.py` proves **285/285 = 100.0%** of obligations claimed, 0 undefined citations, 0 gaps cited as obligations, 0 duplicate or out-of-range identifiers, 0 collisions with the six foreign ranges, 0 cycles, `Blocks`/`Blocked by` mutually consistent, 1 root, 1 leaf, and 0 `BLOCKED` markers lacking a named gap; the 10-task critical path is derived from the graph. **The gate was then tested against 12 deliberate mutations, all 12 of which produced exit 1**, because a check that has only ever passed has not been shown able to fail. Three defects the derivation caught during authoring were fixed rather than argued away: a hand-written `Blocked by` list for `IMPL-679` left `IMPL-671` (authorization) and `IMPL-672` (multi-tenancy) outside the acceptance harness's ancestry although the tenancy acceptance band requires them, so the harness's 23 edges are now computed as *"every otherwise-terminal task"*; a `BLOCKED` count written as *"Thirteen"* measured **12**; and §8's forbidden-task table covered 18 of the 19 gaps until a comparison against §32.1's verdict column named the omission (`ATT-GAP-017a`, a latency budget — the easiest gap to close by accident, because inventing a number feels like rigour). Lists **37 tasks that must not be created**, each mapped to the rule it would break, **20 of which would close a gap by writing code**, together referencing all 18 open gaps plus the 1 narrowed one. **Stage 3 and Stage 4 are represented as ⚠️ CONDITIONAL, which is what they returned** — `PRD-007`'s ✅ prerequisite wording is deliberately **not** reused, and §2 records why Stage 6 may still be entered on a conditional verdict: the gate conditions on the artefacts existing, not on a verdict grade. Running the new tool turned the **passing** Stage 5 gate red, because `prd006_traceability.py` treats an `ATT-<REG>-<n>` token under `tool/` as a namespace collision; the new file's docstring was reworded and **the Stage 5 tool was not modified**. **Nothing is implemented: zero `lib/` files changed, no estimates invented, no specification written, no schema, SQL, DDL, API shape, event, payload, widget tree or class signature; no configuration default and no security value invented; the 18 open `ATT-GAP-*` remain open and 12 tasks remain blocked behind them; `PRD-006` unmodified and still `DRAFT`; `PRD-007`, `PRD_REGISTRY.md`, the BC Map, the Dependency Matrix, all 20 ADRs, `DOCUMENTATION_BASELINE.md`, `PRD_LIFECYCLE.md`, `TRACEABILITY_MATRIX.md` and the four sibling backlogs all byte-identical; the four stale `IMPL-227+` tables left stale; no registry entry, no ADR, and no freeze.** |
