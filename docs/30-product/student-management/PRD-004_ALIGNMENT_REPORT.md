# `PRD-004` Alignment Report — Student Management & Library Members Directory

| Field | Value |
|---|---|
| **Document** | Alignment Report for [`Student_Management_PRD_v1.md`](Student_Management_PRD_v1.md) (`PRD-004`) |
| **Version** | v1.0 |
| **Status** | Supporting record. **Not ranked**, therefore editable without an ADR |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04-B` |
| **Purpose** | Phase 20 deliverable 2. Records how `PRD-004` was aligned to the authoritative architecture, what was preserved, what conflicted, what duplicated, and what is missing |
| **Precedence** | Below every document it cites. Where this report disagrees with a PRD, ADR, the Master PRD, the BC Map or the Dependency Matrix, **the other document is right and this report is a defect** |
| **Governing principle** | `SID-4.56` — *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."* |

---

## 1. The audit that was requested, and the fact that changed it

The instruction was: *"First audit the existing Student Management PRD against the current authoritative
architecture."* Then: *"1. preserve valid requirements 2. identify conflicts 3. identify duplicates 4. identify
missing requirements 5. integrate the Library Members Directory capability 6. maintain requirement traceability
7. create implementation tasks."*

**There is no existing Student Management PRD.** This was established mechanically, not assumed:

| Check | Command | Result |
|---|---|---|
| Any student-named specification | `find docs -iname "*student*"` | Only `docs/30-product/student-identity/**` — a **different** PRD (`PRD-003`, `BC-10`) |
| Registered status of `PRD-004` | `PRD_REGISTRY.md` line 224 | `PLANNED` — *"named but never written"* |
| Registry's own statement | `PRD_REGISTRY.md` §5 | *"`Listed in v1.0` means the v1.0 Master PRD named them. **None was ever written.** All nine are `PLANNED`."* |

**Consequence for each numbered step, stated rather than glossed:**

| Step | Status | Why |
|---|---|---|
| 1 Preserve valid requirements | **Vacuously satisfied — nothing to preserve** | No prior `SM-*` requirement existed in any file. Zero requirements were carried forward, and zero were discarded |
| 2 Identify conflicts | **Performed against the frozen architecture instead** | The only conflicts available to find were between the *requested scope* and Ranks 1–4. Three were found (§3) |
| 3 Identify duplicates | **Performed against the whole repository** | Four were found (§4) |
| 4 Identify missing requirements | **Performed** | Nine are recorded as `SM-GAP-*`, not invented (§5) |
| 5 Integrate the Directory | **Done as chapter 5** | `LMD-1` … `LMD-31` (§6) |
| 6 Maintain traceability | **Done** | 233 of 242 identifiers sourced; see [`PRD-004_TRACEABILITY.md`](PRD-004_TRACEABILITY.md) |
| 7 Create implementation tasks | **Done** | 18 tasks; see [`PRD-004_IMPLEMENTATION_TASKS.md`](PRD-004_IMPLEMENTATION_TASKS.md) |

> **Why this is reported instead of quietly skipped.** An audit report of a nonexistent document could have been
> written to look complete — "reviewed, N requirements preserved" — and nobody reading only this report would
> know. Recording the absence is the difference between a verified milestone and a plausible one.

---

## 2. What the audit was performed *against*

Since there was no prior PRD, the baseline for alignment was the authoritative stack itself, read in precedence
order per `DOCUMENTATION_BASELINE.md` §4:

| Rank | Document | What it contributed |
|---|---|---|
| 1 | `MASTER_PRD.md` | §8 **module 4** Student Management → `BC-01`; §8 **module 3** Library Member Directory → `BC-01` *(read composition)*; `MP-GBR-*` global rules |
| 2 | `ADR-0011`, `ADR-0013`, `ADR-0016` | Identity triad; capability-context ownership; `E-22` consumer list |
| 3 | `Student_Identity_PRD_v1.md` | `SID-2.8` normative ownership table; `SID-2.38`–`SID-2.41` the **approved read-composition pattern** |
| 3 | `Library_PRD_v1.md` v1.1 | `TR-1`…`TR-5` closed role set (`LIB-4.1`); `LIB-16.6` directory-disable rule |
| 3 | `Authentication_PRD_v2.md` | `AUTH-7.*` audit obligations; registration ownership |
| 4 | `LIBOORA_BOUNDED_CONTEXT_MAP.md` v1.5 | Line 96 scope; line 370 aggregate + invariants; **line 209 closed status set**; line 292 closed edge set |
| 4 | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` v1.3 | `L1`–`L5` laws; §10.4 gate order |
| 5 | `ARCHITECTURE_RULINGS.md` | **`AR-1`** read composition is not a context; `AR-2` registration ownership |
| 7 | `CONFIGURATION_GUIDE.md` | **`LCFG-5`** member directory, default **Disabled**, `AP-3` deny-by-default |

**Frozen-document integrity:** verified by `git diff --quiet 588a2d6 -- <path>` for `MASTER_PRD.md` and
`Student_Identity_PRD_v1.md` → **unchanged**. No Rank 1–5 document was edited to make `PRD-004` fit.

---

## 3. Conflicts identified — three, all resolved *in favour of the frozen architecture*

Every conflict here is between **the requested scope** and an authoritative document. In each case the request
was corrected, the correction was recorded in the PRD with its reasoning, and **no frozen document was changed.**

### 3.1 `CONF-1` — The requested lifecycle contradicts the closed status set

| Field | Value |
|---|---|
| **Requested** | *Prospective → Registered → Active → Suspended → Expired → Archived* |
| **Authoritative** | BC Map **line 209**: *"`BC-01`: Active/Inactive/Suspended/Archived enrollment state \| `BC-02`: Valid/Expired/Frozen membership state … **Two independent state machines — a student can be Active with an Expired membership.**"* |
| **Conflict** | `Expired` is a **`MembershipStatus`** owned by `BC-02`. Adding it to `EnrollmentStatus` would make line 209's explicitly documented case — *Active student, Expired membership* — unrepresentable. `Prospective` and `Registered` are not in the closed set either |
| **Resolution** | `EnrollmentStatus` = closed set `Active \| Inactive \| Suspended \| Archived` (`SM-2.5`). `SM-2.7` forbids `Expired` as a value. Expiry still **appears** in the Directory as a `BC-02` projection (`LMD-16`, `LMD-26`) — the user-visible need is met without moving ownership |
| **ADR required** | **No.** The PRD conforms to the frozen rule; nothing was overridden. An ADR would be required only to *change* line 209 |
| **Authority for acting** | The brief itself: *"Do not assume these exact states are approved. Derive the actual lifecycle from existing requirements."* |

### 3.2 `CONF-2` — The requested `LibraryMember` aggregate contradicts `AR-1` and the Single Owner Rule

| Field | Value |
|---|---|
| **Requested** | A `LibraryMember` Aggregate Root, with its own database tables and write APIs, as *"the **authoritative** library-specific directory"* |
| **Authoritative** | Master PRD §8 line 155: `\| 3 \| Library Member Directory \| BC-01 Enrollment *(read composition)* \|` · BC Map line 370: `BC-01 Enrollment \| StudentRecord \| …` · **`AR-1`**: a read composition *"owns no aggregate, no invariant, no business state"* · BC Map rule **R1** Single Owner |
| **Conflict** | The brief was **internally contradictory**: it demanded the Directory be authoritative *and* said *"Never make the Directory authoritative over another bounded context's data."* Both cannot hold — `BC-01` is already authoritative for the student-member record. A second aggregate would create a second member store, breaking `R1` |
| **Resolution** | No `LibraryMember` aggregate (`SM-1.7`). *"The member record **IS** the `StudentRecord`; 'member' is a directory view of it, not a second entity."* Chapter 5 is a read composition following the **already-approved** `SID-2.38`–`SID-2.41` pattern. `SM-10.6` forbids a `library_member` or `member_directory` table |
| **ADR required** | **No.** Conforms to `AR-1`, `R1` and Rank 1 |

### 3.3 `CONF-3` — A standalone Directory PRD contradicts the registry's existing adjudication

| Field | Value |
|---|---|
| **Requested** | A standalone `Library_Members_Directory_PRD_v1.md`, and, in the first ask, a new bounded context |
| **Authoritative** | `PRD_REGISTRY.md` line 338: *"Library Member Directory (module 3) \| read composition \| V1 \| **No PRD. Belongs to `PRD-004`**"* · `PRD_LIFECYCLE.md` Stage 1 gate: a new PRD requires *"a context identified in the Bounded Context Map, **not already owned** in `PRD_REGISTRY.md` §6"* |
| **Conflict** | The Directory **fails all four** Stage 1 gate questions: it is a composition; `BC-01` is already owned by `PRD-004`; it owns no aggregate; it owns no invariant. `PRD_LIFECYCLE.md` names this outcome — a large PRD behind a screen that owns no state — *"the commonest wrong outcome"* |
| **Resolution** | Directory delivered as **chapter 5 of `PRD-004`** (Option A, selected by the user after the conflict was reported). **No standalone PRD. No `BC-32`.** Context count remains **31** |
| **ADR required** | **No.** This is the resolution the registry already prescribed |

**Conflicts requiring an ADR: 0.** Every conflict resolved *toward* the frozen architecture, never against it.

---

## 4. Duplicates identified — four, each resolved by pointing rather than restating

A duplicated requirement is worse than a missing one: two copies drift, and nothing says which governs.

| ID | Candidate duplicate | Already owned by | Resolution in `PRD-004` |
|---|---|---|---|
| `DUP-1` | Student registration flow | `AR-2` — Authentication owns registration; `BC-18` owns `Account` | Chapter 3 specifies **enrollment**, not account creation. `SM-1.2`: holds `AccountId` from `E-11`, resolves `PersonId` via `E-13`; **introduces no identity concept** |
| `DUP-2` | Person profile fields (name, photo, contact) | `SID-2.8` normative table: `BC-10` owns global person attributes; `BC-01` owns *"Student Record, organisation profile, Library Identification Photo, parent contact"* | Chapter 4 restricts itself to the `BC-01` column of `SID-2.8` and cites it. **`SID-2.8` was not copied**, because `SID-2.42` makes it normative and changing a row needs an ADR |
| `DUP-3` | Directory listing / search / filter mechanics | `SID-2.38`–`SID-2.41` already define the approved read-composition pattern; `BC-23` owns indexing (`E-21`) | Chapter 5 **applies** the pattern by reference and delegates indexing. `LMD-2` forbids persisting any member row, table, cache or materialised entity |
| `DUP-4` | Membership validity / expiry / seat / fee status | `BC-02`, `BC-04`, `BC-05` | Directory **projects** these read-only (`LMD-16`, `LMD-26`). §5.4 is a normative *owner-per-field* table so every displayed field names its owning context |

**Duplicate requirements written: 0.** Four were avoided by citation.

---

## 5. Missing requirements — nine, recorded as `PROPOSED GAP`, not invented

Instruction: *"If a requirement has no authoritative source, mark it as PROPOSED GAP rather than inventing it."*

| ID | Missing decision | Why it is a gap |
|---|---|---|
| `SM-GAP-1` | Retention period for student financial/attendance history | `ID-5` says *"under legal basis"* but names **no duration**. Writing "7 years" would fabricate a legal position |
| `SM-GAP-2` | `enrollmentNumber` format and whether it is human-meaningful | `SM-INV-1` requires uniqueness only. `SMCFG-5`'s default is a placeholder pending a decision |
| `SM-GAP-3` | Whether `Inactive` blocks seat allocation | `MP-GBR-16` covers membership validity; `SM-2.14` covers `Suspended`. `Inactive` unspecified |
| `SM-GAP-4` | `TR-5` Parent access to the Directory and to member detail | Parent Portal is Master PRD module 5, a composition with **no PRD**. Its authorisation model is undefined |
| `SM-GAP-5` | **Member tags and free-text member notes** | Requested **twice** in the brief. **No source in the Master PRD, BC Map, Library PRD, Student Identity PRD or any ADR** |
| `SM-GAP-6` | Emergency contact as a field distinct from guardian contact | `SID-2.8` names *"parent/guardian contact"* only |
| `SM-GAP-7` | Directory visibility of members to **other members** | `LCFG-5` says the directory *"exposes members to members"* but **no requirement defines the member-facing field set** |
| `SM-GAP-8` | Bulk import / `registrationSource = Import` validation rules | `SM-3.8` names the source; no import specification exists |
| `SM-GAP-9` | Attendance-percentage definition used by the Directory indicator | Owned by `BC-03`; `PRD-006` is unwritten, so the formula has no owner yet |

> **These nine rows are quoted from `PRD-004` §10.6, which is authoritative for them.** An earlier draft of this
> report paraphrased rows 6–9 from memory and produced four *different* gaps (bulk-import file format, export
> permission, photo size limits, re-enrollment path). The mismatch was caught by diffing this table against the
> PRD rather than by reading either document alone. The PRD's wording governs; this report was corrected.

**Requirements invented: 0.** Each gap carries **no** traceability entry by design — that is what marks it as a
gap rather than a requirement.

---

## 6. Directory integration — the architectural rule, checked clause by clause

The user's rule, verbatim: *"Library Members Directory is a READ COMPOSITION. It: owns no aggregate · owns no
independent invariant · does not create a `LibraryMember` aggregate · does not create a second student/member
database · does not own Membership · does not own Seat · does not own Attendance · does not own Fees · does not
own Global Identity."*

| Clause | Enforced by | Verified |
|---|---|---|
| Owns no aggregate | `SM-1.7`, `LMD-1` | ✅ Only aggregate in `PRD-004` is `StudentRecord` (§2) |
| Owns no independent invariant | `LMD-3` | ✅ All 11 invariants are `SM-INV-*` on `StudentRecord`; **zero** `LMD` invariants |
| No `LibraryMember` aggregate | `SM-1.7` | ✅ String absent as an aggregate anywhere in the PRD |
| No second student/member database | `LMD-2`, `SM-10.6` | ✅ *"MUST NOT be a `library_member` table, a `member_directory` table, or any denormalised copy"* |
| Does not own Membership | `LMD-16`, §5.4 | ✅ `BC-02` projection |
| Does not own Seat | §5.4 | ✅ `BC-04` projection |
| Does not own Attendance | §5.4 | ✅ `BC-03` projection |
| Does not own Fees | §5.4 | ✅ `BC-05` projection |
| Does not own Global Identity | `SM-1.2`, `SM-1.4` | ✅ `PersonId` held non-nullable via `E-13` ACL, never authored |

**Prohibitions, each checked:**

| Prohibition | Result |
|---|---|
| No standalone Directory PRD | ✅ None created |
| No new bounded context | ✅ Count remains **31** |
| No `BC-32` | ✅ String `BC-32` absent from the repository |
| No frozen document modified | ✅ `git diff --quiet 588a2d6` clean for Rank 1–5 |
| No invented requirements | ✅ 9 gaps recorded instead |

**Additionally verified:** **no integration edge was added.** All six `BC-01` edges — `E-01`, `E-09`, `E-11`,
`E-13`, `E-21`, `E-22` — pre-exist in the BC Map. This matters because BC Map line 292 states: *"If an edge is
not in this table, it does not exist and adding it requires an ADR."*

---

## 7. Dependency-direction validation

| Law | Requirement | `PRD-004` conformance |
|---|---|---|
| `L1` Acyclic | Never waivable | ✅ `BC-01` rank 8 depends only on lower ranks: `BC-10` (7.5), `BC-18` (4), plus event-only outbound |
| `L2` Downward only | No upward compile dependency | ✅ `BC-02`/`BC-05`/`BC-23` reached by **event**, not call (`SM-EV-*`) |
| `L3` Ports only | Domain depends on declared ports | ✅ 12 `SM-PO-*` protected operations; `BC-10` via **ACL** (`E-13`) |
| `L4` Capability ≠ domain | A capability never depends on a domain | ✅ Directory (capability) reads projections; **not** placed in the domain layer, per `SID-2.41` |
| `L5` Contracts import nothing | — | ✅ No contracts change proposed |

`X-05` (`LIBRARY MANAGEMENT ↔ STUDENT NETWORK`, `BC-11`…`BC-17`) — **not crossed.** `BC-10` is not the social
side of that boundary, and depending on it has been legal since `ADR-0011`.

---

## 8. What this report does **not** claim

| Not claimed | Actual state |
|---|---|
| That `PRD-004` is approved | **`DRAFT`, Lifecycle Stage 2.** Not frozen, not baselined, not ranked |
| That a prior PRD was reviewed | **No prior PRD existed.** §1 |
| That the 9 gaps are decided | They are **open questions**, deliberately unanswered |
| That any code was written | **Zero files under `lib/` changed.** No development started |
| That the Directory is implemented | 18 tasks are **specified**, none executed |
| That gate 3 is green | It is **legitimately red** — 9 `cross-context` violations from `TASK-D10`/`BLK-01`, unrelated to this PRD and **not waived** |

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created as Phase 20 deliverable 2. Records that **no prior Student Management PRD existed**, so step 1 (*preserve valid requirements*) is vacuous rather than complete; three conflicts (`CONF-1`…`CONF-3`) resolved toward the frozen architecture with **zero ADRs required**; four duplicates (`DUP-1`…`DUP-4`) avoided by citation; nine missing decisions recorded as `SM-GAP-*` rather than invented. All nine clauses of the Directory read-composition rule and all five prohibitions verified individually. **No frozen document modified, no integration edge added, no bounded context created, no application code written.** |
