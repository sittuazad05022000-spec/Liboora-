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
