# Student Management PRD — `PRD-004`

| Field | Value |
|---|---|
| **PRD ID** | `PRD-004` |
| **Document** | Student Management — `BC-01` Enrollment |
| **Version** | v1.0 (Startup MVP) |
| **Status** | **DRAFT** — Lifecycle Stage 2. Not frozen, not baselined, not approved |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04-B` |
| **Rank if approved** | Rank 3 (module PRD) — **not yet ranked** |
| **Owning context** | **`BC-01` Enrollment** `[CORE]`, Library Management cluster, rank 8 |
| **Product modules** | Master PRD §8 **module 4** (Student Management) and **module 3** (Library Member Directory, *read composition*) |
| **Consumes through ports** | `BC-10` Global Person Identity (`E-13` ACL) · `BC-18` Identity & Access (`E-11`) · `BC-02` Membership (`E-01`) · `BC-05` Fee & Collection (`E-09`) · `BC-23` Search Indexing (`E-21`) · `BC-29` File & Media (`E-22`) · `BC-24` Audit Trail · `BC-25` Configuration (`E-19`) |
| **ADRs applied** | [`ADR-0011`](../../00-governance/adr/ADR-0011-global-person-identity.md) · [`ADR-0016`](../../00-governance/adr/ADR-0016-e22-consumer-list-includes-bc-10.md) · [`ADR-0013`](../../00-governance/adr/ADR-0013-capability-context-ownership.md) |
| **Rulings applied** | `AR-1` (read composition is not a context) · `AR-2` (Authentication owns registration) |
| **Governing principle** | `SID-4.56` — *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."* |

---

## 0. How to read this document

### 0.1 Normative language

`PRD_LIFECYCLE.md` Stage 2 rule 4 requires every draft to define its normative language. This document
uses the following, and nothing else carries obligation.

| Term | Meaning |
|---|---|
| **MUST** / **MUST NOT** | An absolute requirement. A build that violates it is defective. Every **MUST** in this document is intended to be falsifiable — if it cannot be checked, `SID-4.56` applies and it is treated as **unmet**, not as satisfied by intent |
| **SHOULD** / **SHOULD NOT** | A strong default. It may be departed from only with a recorded reason; the departure is a design decision, not a defect |
| **MAY** | Genuinely optional. Neither choice is a defect |

Descriptive prose, rationale blocks (`>` quotations) and the tables in §9.2 carry **no** obligation. Where
a table is normative it says so explicitly (`LMD-24`, `SID-2.42` pattern).

**Precedence.** This document is a module PRD. Where it conflicts with `MASTER_PRD.md`, an accepted ADR, or
another ranked document, **the ranked document governs and the conflict is a defect in this document**
(`DOCUMENTATION_BASELINE.md` §4). Do not resolve such a conflict by choosing — raise it.

### 0.2 Identifier registers — declared up front

Per `PRD_LIFECYCLE.md` Stage 2, the registers are published **as a promise**, with ranges. A gap would make the
promise false.

| Prefix | Meaning | Count | Range | Chapter |
|---|---|---|---|---|
| `SM-c.n` | Functional requirement | **107** | `SM-1.1` … `SM-10.12` | 1–4, 6–8, 10 |
| `SM-BR-n` | Business rule | **16** | `SM-BR-1` … `SM-BR-16` | §9.1 |
| `SM-XC-n` | Exclusion — must be impossible | **14** | `SM-XC-1` … `SM-XC-14` | §1.5 |
| `SM-INV-n` | Domain invariant | **11** | `SM-INV-1` … `SM-INV-11` | §2.6 |
| `SM-EV-n` | Domain event (**closed set**) | **10** | `SM-EV-1` … `SM-EV-10` | §7.4 |
| `SM-PO-n` | Protected operation (**closed list**) | **12** | `SM-PO-1` … `SM-PO-12` | §8.2 |
| `SM-AC-n` | Acceptance criterion | **30** | `SM-AC-1` … `SM-AC-30` | §10.4 |
| `SMCFG-n` | Configurable parameter | **7** | `SMCFG-1` … `SMCFG-7` | §10.3 |
| `LMD-n` | Library Members Directory requirement | **31** | `LMD-1` … `LMD-31` | 5 |
| `SM-GAP-n` | **PROPOSED GAP** — no authoritative source | **10** | `SM-GAP-1` … `SM-GAP-10` | §10.6 |

**Total base identifiers: 248** (of which **10** are proposed gaps carrying no authority).

**Sub-lettered clarifications: 15.** The 2026-08-04 correction pass resolved review findings by *clarifying*
existing requirements rather than renumbering the document. A clarification that narrows or completes an existing
requirement takes that requirement's number with a letter suffix — `SM-7.1a` qualifies `SM-7.1`; `SM-4.5a`,
`SM-4.5b` and `SM-4.5c` complete `SM-4.5`. This keeps every pre-existing identifier stable, which matters because
`§10.7` tasks, `§10.4` criteria and three supporting documents cite them.

| Suffixed identifier | Qualifies | Finding resolved |
|---|---|---|
| `SM-7.1a` | `SM-7.1` — scopes it to the domain layer | `RF-01` |
| `LMD-24a`, `LMD-24b` | `LMD-24` — composition may not enter the domain layer or confer authority | `RF-01` |
| `SM-7.12a`, `SM-7.12b` | `SM-7.12` — consent gate and payload limit for `SM-EV-10` | `RF-02` |
| `SM-4.5a`, `SM-4.5b`, `SM-4.5c` | `SM-4.5` — behaviour when Date of Birth is absent | `RF-06` |
| `SM-3.14a`, `SM-3.14b` | `SM-3.14` — which archived record restore targets | `RF-13` |
| `LMD-15a`, `LMD-15b` | `LMD-15` — authoritative vs best-effort filters | `RF-11` |
| `SM-7.7a`, `SM-7.7b` | `SM-7.7` — producer-side transactional outbox | `RF-19` |
| `SM-8.4a` | `SM-8.4` — interim `TR-5` Parent denial, `SM-GAP-4` stays open | `RF-12` |

**Total normative identifiers: 263** — 248 base + 15 sub-lettered. Every one is counted; none is hidden.

**Per-chapter `SM-c.n` allocation**, published so that a gap is detectable rather than deniable:

| Chapter | Range | Count |
|---|---|---|
| 1 Purpose, Scope & Ownership | `SM-1.1` … `SM-1.8` | 8 |
| 2 `StudentRecord` & Lifecycle | `SM-2.1` … `SM-2.16` | 16 |
| 3 Registration & Enrollment | `SM-3.1` … `SM-3.17` | 17 |
| 4 Profile, Guardian & Documents | `SM-4.1` … `SM-4.12` | 12 |
| **5 Library Members Directory** | **numbered `LMD-1` … `LMD-31`** | 0 |
| 6 Student Operations | `SM-6.1` … `SM-6.8` | 8 |
| 7 Cross-Context Integrations | `SM-7.1` … `SM-7.17` | 17 |
| 8 Security, Permissions & Audit | `SM-8.1` … `SM-8.17` | 17 |
| **9 Business Rules & Edge Cases** | **numbered `SM-BR-1` … `SM-BR-16`** | 0 |
| 10 Data, API, AC, Traceability, Tasks | `SM-10.1` … `SM-10.12` | 12 |

> ⚠ **Chapters 5 and 9 deliberately contain no `SM-c.n` identifier.** Chapter 5 is the Directory capability and
> numbers exclusively in `LMD-n` so that a read-composition requirement can never be mistaken for a domain
> requirement of `BC-01`. Chapter 9 is the business-rule chapter and numbers exclusively in `SM-BR-n`. Both are
> intentional, not gaps — which is why the allocation table above exists rather than a single unchecked range.
>
> **This table was added by validation, not by drafting.** The first draft of this section declared **118**
> `SM-c.n` over the range `SM-1.1` … `SM-10.6`. A mechanical count found **105** over `SM-1.1` … `SM-10.10`. The
> register was wrong, not the chapters; the register was corrected. Per `SID-4.56`, a declared count that is not
> checked is not a fact.
>
> **Corrected again on 2026-08-04** by the independent-review correction pass: `SM-c.n` **105 → 107**
> (`SM-10.11`, `SM-10.12`), `SM-EV-n` **9 → 10** (`SM-EV-10`, finding `RF-02`), `SM-AC-n` **28 → 30**
> (`SM-AC-29`, `SM-AC-30`), `SM-GAP-n` **9 → 10** (`SM-GAP-10`), plus 15 sub-lettered clarifications. Every count
> in this section is reproduced by `tool/docs_check/prd004_traceability.py`, which is the only reason it may be
> stated as fact.

**Prefix collision check.** Verified mechanically against the authentication (`AUTH`/`BR`/`XC`/`AC`/`EV`/`CFG`/`PO`),
Library (`LIB`/`LCFG`/`LXC`/`LEV`/`LAC`) and Student Identity (`SID`/`SID-BR`/`SXC`/`SPO`/`SEV`/`SID-INT`/`SID-INV`/
`SCFG`/`SID-AC`) registers. **Zero collisions.**

> ⚠ **Two near-collisions, recorded because they nearly happened.** `BR-n` is taken by the Authentication PRD
> (297 rules) and `PO-n` by it as well, with `SPO-n` already added to disambiguate in Student Identity. This
> document therefore uses **`SM-BR-n`** and **`SM-PO-n`**, never the bare forms. `MP-SM-01` exists in the Master
> PRD as a *metric* identifier; it is not a requirement prefix and does not collide with `SM-c.n`.

---

## 1. Purpose, Scope & Ownership

### 1.1 Purpose

`BC-01` Enrollment owns **the identity and lifecycle of a person as a student of one specific library.** BC Map
line 96 states it owns *"registration, profile, status, guardian linkage, documents."*

This document specifies that context, and **module 3 Library Member Directory** as a read-composition capability
of it — the placement mandated by `PRD_REGISTRY.md` §6: *"Library Member Directory (module 3) — read composition —
**No PRD. Belongs to `PRD-004`**."*

`SM-1.1` — This module **MUST** be the sole authority for the `StudentRecord` aggregate within a tenant.

`SM-1.2` — This module **MUST NOT** introduce any identity concept of its own. It holds `AccountId` (`E-11`) and a
non-nullable `PersonId` (`E-13`), both resolved from their owners.

`SM-1.3` — This module **MUST** key exclusively on `StudentRecordId` (rule `ID-4`).

### 1.2 The three concepts, kept distinct

| Question | Answered by | Context | Identifier |
|---|---|---|---|
| *"Who is this person globally?"* | Global Person Identity | `BC-10` | `PersonId` |
| *"Is this person a student of this library, and what is their record?"* | **This module** | **`BC-01`** | `StudentRecordId` |
| *"How does the library operationally manage them?"* | **This module** (§6) | **`BC-01`** | `StudentRecordId` |
| *"What may this person pay for and use?"* | Membership | `BC-02` | `MembershipId` |

`SM-1.4` — A `StudentRecord` **MUST NOT** be merged with, or substituted for, a `GlobalPersonIdentity`. One human
enrolled at three libraries has **three** `StudentRecordId`s and **one** `PersonId` (BC Map §4.1).

`SM-1.5` — `StudentRecordId` **MUST NOT** appear in any global context, event or index (`ID-2`, `MP-GBR-03`).

### 1.3 Directory position — normative

`SM-1.6` — The Library Members Directory **MUST** be implemented as an **application-layer read composition**
(`AR-1`, `SID-2.41`). It **MUST NOT** own an aggregate, an independent invariant, a lifecycle or a table.

`SM-1.7` — The Directory **MUST NOT** introduce a `LibraryMember` aggregate. The member record **is** the
`StudentRecord`; "member" is a directory *view* of it, not a second entity.

> **Why this is stated as a requirement rather than a note.** BC Map rule **R1** requires that a term resolve to
> exactly one model per context, and §11 already records that `Member` means `MembershipHolder` in `BC-02` and
> `CommunityMember` in `BC-15`. A third `LibraryMember` aggregate in `BC-01` would make the word ambiguous in the
> one context that must not be ambiguous, and would create a second writer over the student record.

### 1.4 Ownership boundary — normative

| Asset | Owner | Context |
|---|---|---|
| `StudentRecord`, enrollment number, `EnrollmentStatus` | **This module** | `BC-01` |
| `ContactDetails`, `GuardianLink`, `DocumentRef` | **This module** | `BC-01` |
| Library Identification Photo, organisation profile, parent/guardian contact | **This module** | `BC-01` |
| Credentials, OTP, session, authorisation decision, verified mobile number | Authentication | `BC-18` |
| `PersonId`, Full Name, Username, Global Profile, Global Profile Photo, DOB, gender, privacy | Global Person Identity | `BC-10` |
| Membership plan, term, validity, expiry | Membership | `BC-02` |
| Attendance records, percentage, present days | Attendance | `BC-03` |
| Seat allocation, shift, zone | Seating | `BC-04` |
| Fee dues, receipts, outstanding balance | Fee & Collection | `BC-05` |
| Staff, managers, receptionists, staff attendance, payroll, permissions | Staff / Authentication | `BC-07`, `BC-18` |
| File bytes, storage paths, signed URLs | File & Media | `BC-29` |
| Settings, feature flags (`LCFG-5`) | Configuration | `BC-25` |

`SM-1.8` — This table is **normative**. Changing a row requires an ADR (pattern of `SID-2.42`).

### 1.5 Exclusions — `SM-XC-1` … `SM-XC-14`

Each **MUST** be impossible, not merely undone.

| ID | This module MUST NOT | Source |
|---|---|---|
| `SM-XC-1` | Store a password, OTP, session or credential | `ID-1`, `LXC-1` |
| `SM-XC-2` | Create, mutate or delete a `GlobalPersonIdentity` | `ADR-0011`, `SID-2.8` |
| `SM-XC-3` | Create a second identity system or a local username | `ID-1`, `SM-1.2` |
| `SM-XC-4` | Model `Staff`, `Manager`, `Receptionist` or `Librarian` as a student record | `LIB-5.1` |
| `SM-XC-5` | Own staff attendance, payroll, staff performance or staff permissions | BC Map §11 (`StaffAttendance` ≠ `StudentAttendance`) |
| `SM-XC-6` | Introduce a role name of its own | `LIB-4.1`, `AUTH-7.21` |
| `SM-XC-7` | Write to `BC-02`, `BC-03`, `BC-04` or `BC-05` tables | `L3`, Single Owner Rule |
| `SM-XC-8` | Become the authority for any value it composes in the Directory | `SID-2.38` |
| `SM-XC-9` | Emit `StudentRecordId` in any global event or search index | `ID-2`, `MP-GBR-03` |
| `SM-XC-10` | Depend on `BC-11`…`BC-17` (Student Network) | `X-05` |
| `SM-XC-11` | Store file bytes or a raw storage path | `E-22` |
| `SM-XC-12` | Evaluate its own authorisation decision instead of calling `BC-18` | `X-13`, `LIB-4.2` |
| `SM-XC-13` | Expose the Directory when `LCFG-5` is disabled | `LIB-16.6`, `LCFG-5` |
| `SM-XC-14` | Hard-delete a `StudentRecord` outside the legally compelled erasure path | `MP-GBR-14`, `ID-5` |

---

## 2. `StudentRecord` & Student Lifecycle

### 2.1 Aggregate

`SM-2.1` — The aggregate root **MUST** be `StudentRecord`, identified by `StudentRecordId`, exactly as BC Map
line 370 declares. No alternative root is permitted.

**Value objects** (BC Map line 370, verbatim): `ContactDetails`, `GuardianLink`, `DocumentRef`, `EnrollmentStatus`.

`SM-2.2` — `StudentRecord` **MUST** hold: `studentRecordId`, `tenantId`, `personId` *(non-nullable)*,
`accountId`, `enrollmentNumber`, `EnrollmentStatus`, `ContactDetails`, `GuardianLink?`, `DocumentRef[]`,
`LibraryIdentificationPhoto?` as a `FileRef`, `registeredAt`, `registrationSource`, audit references.

`SM-2.3` — `personId` **MUST** be non-nullable (`ADR-0011`, `ID-4`).

`SM-2.4` — `StudentRecord` **MUST NOT** hold a `MembershipId`, seat number, attendance total or fee balance as
stored state. Those are read through their owners (§7).

> **`SM-2.4` is the requirement most likely to be violated for convenience.** Denormalising `membershipValidUntil`
> onto the student row makes the Directory trivially fast — and creates a second, silently divergent source of
> truth for the value that `MP-GBR-16` uses to block seating. The Directory reads it instead (§5.4).

### 2.2 Lifecycle — derived, not assumed

Your Phase 4 brief proposed *Prospective → Registered → Active → Suspended → Expired → Archived*. **The
repository does not support that set.** BC Map §11 line 209 states the authoritative values:

> *"`Status` — BC-01: **Active/Inactive/Suspended/Archived** enrollment state | BC-02: Valid/Expired/Frozen
> membership state. `EnrollmentStatus` vs `MembershipStatus`. **Two independent state machines** — a student can
> be Active with an Expired membership."*

`SM-2.5` — `EnrollmentStatus` **MUST** be the closed set **`Active`, `Inactive`, `Suspended`, `Archived`**.

`SM-2.6` — `Prospective` and `Registered` **MUST NOT** be `EnrollmentStatus` values. Pre-enrollment intent is
owned by Library Discovery (§14A) and a record does not exist until registration completes (§3).

`SM-2.7` — `Expired` **MUST NOT** be an `EnrollmentStatus` value. Expiry is a `MembershipStatus` owned by `BC-02`.
A student with an expired membership remains `Active` in this module.

> **This is the single most important correction in this chapter.** Adding `Expired` to `EnrollmentStatus` would
> collapse the two state machines BC Map line 209 deliberately separates, and would make the sentence *"a student
> can be Active with an Expired membership"* unrepresentable. The Directory still shows expiry — as a **`BC-02`
> projection** (`LMD-16`), not as an enrollment state.

### 2.3 Transitions

| From → To | Authority | Validation |
|---|---|---|
| *(none)* → `Active` | `TR-1`, `TR-2`, `TR-3` | Registration completed (§3) |
| `Active` → `Inactive` | `TR-1`, `TR-2` | Reason required |
| `Active` → `Suspended` | `TR-1`, `TR-2` | Reason required |
| `Inactive` → `Active` | `TR-1`, `TR-2` | — |
| `Suspended` → `Active` | `TR-1`, `TR-2` | Reason required |
| `Active`/`Inactive`/`Suspended` → `Archived` | **`TR-1` only** | **No outstanding dues** (`E-09`) |
| `Archived` → `Active` | **`TR-1` only** | Restore; new audit entry |

`SM-2.8` — Every transition **MUST** carry an actor, a timestamp and a reason where the table requires one.

`SM-2.9` — A transition to `Archived` **MUST** be rejected if `BC-05` reports outstanding dues (`E-09`).

`SM-2.10` — `Archived` → any state other than `Active` **MUST** be prohibited.

`SM-2.11` — A transition **MUST NOT** be applied retroactively. `effectiveFrom` **MUST** be the transition
timestamp; back-dating is prohibited (pattern of `MP-GBR-19`).

`SM-2.12` — Every transition **MUST** emit `SM-EV-2` `StudentStatusChanged` (`E-01`).

`SM-2.13` — Status history **MUST** be retained append-only. A status change **MUST NOT** overwrite prior history.

### 2.4 `Suspended` semantics

`SM-2.14` — On entering `Suspended`, this module **MUST** emit `SM-EV-2`
(`enrollment.StudentStatusChanged`). `BC-04` Seating and `BC-02` Membership **MUST** react by refusing new seat
allocation and new membership creation respectively; `BC-03` Attendance **MUST** continue to record, flagging the
suspension. This module **MUST NOT** enforce any of those three behaviours itself — each is owned by the
reacting context (`E-01`, rule `F-3`, `SM-XC-8`).

> **Citation note.** `MP-GBR-16` (*"A student may not be **seated** without a valid **membership**"*) is about
> `MembershipStatus`, not `EnrollmentStatus`, so it is **analogous** here rather than authoritative — its
> *"seating blocks; attendance records and flags"* asymmetry is the pattern this requirement follows. The
> authority for `Suspended` behaviour is `E-01` plus the reacting contexts' own ownership. An earlier draft cited
> `MP-GBR-16` as though it governed directly (finding `RF-10`).

### 2.5 Archive, not delete

`SM-2.15` — Archive **MUST** be a soft state change (`MP-GBR-14`). It **MUST NOT** delete attendance or financial
history.

`SM-2.16` — Legally compelled erasure **MUST** follow `ID-5`: delete the `Account`, anonymise the `Person`,
**retain** `StudentRecord` financial and attendance history pseudonymised. This module **MUST NOT** implement its
own deletion pipeline.

### 2.6 Invariants — `SM-INV-1` … `SM-INV-11`

| ID | Invariant | Source |
|---|---|---|
| `SM-INV-1` | Unique `(tenantId, enrollmentNumber)` | BC Map line 370 |
| `SM-INV-2` | At least one contactable channel | BC Map line 370 |
| `SM-INV-3` | Guardian mandatory if age < 18, **or if minor-status is `Unknown`** (`SM-4.5a`, `SM-4.5b`) | BC Map line 370, `AP-3`, `SID-4.56` |
| `SM-INV-4` | Cannot `Archive` with open dues | BC Map line 370, `E-09` |
| `SM-INV-5` | `personId` non-nullable | `ADR-0011`, `ID-4` |
| `SM-INV-6` | One **non-`Archived`** `StudentRecord` per `(tenantId, personId)`. Archived records are exempt — `ID-5` requires history to be retained (`SM-3.14a`, `SM-10.2`) | §3.3 duplicate prevention, `ID-5` |
| `SM-INV-7` | `EnrollmentStatus` ∈ closed set of 4 | `SM-2.5` |
| `SM-INV-8` | Every record belongs to exactly one `tenantId`, never null | `X-13`, `MP-GBR-08` |
| `SM-INV-9` | Status history append-only | `SM-2.13` |
| `SM-INV-10` | Every document is a `FileRef`, never bytes | `E-22` |
| `SM-INV-11` | No credential field exists on the aggregate | `ID-1`, `SM-XC-1` |

---

## 3. Student Registration & Enrollment

### 3.1 Authority

Ruling `AR-2` is binding: **Authentication owns registration** of the account. This module enrolls an
already-authenticated person.

`SM-3.1` — This module **MUST NOT** create an `Account`. It resolves an existing `AccountId` through `E-11`.

`SM-3.2` — This module **MUST NOT** create a `GlobalPersonIdentity`. Every `Account` already has exactly one,
created atomically at account creation (`ADR-0011`, `MP-GBR-02`).

`SM-3.3` — Enrollment **MUST** resolve `PersonId` through the `E-13` ACL and store it non-nullably.

> **`SM-3.2` is the requirement that prevents the accident your brief warned about.** Because `ADR-0011` made
> identity creation atomic with the account, there is no code path in which this module *needs* to create one — so
> any such code path is a defect, not an option.

### 3.2 Registration flow

`SM-3.4` — Registration **MUST** execute in this order: (1) resolve `AccountId`; (2) resolve `PersonId` via
`E-13`; (3) duplicate check (§3.3); (4) validate; (5) allocate `enrollmentNumber`; (6) persist with
`EnrollmentStatus = Active`; (7) emit `SM-EV-1`.

`SM-3.5` — Steps 5–7 **MUST** be atomic. A failure **MUST** leave no partial record and **MUST NOT** consume an
`enrollmentNumber`.

`SM-3.6` — Registration **MUST** be idempotent by `(tenantId, personId, idempotencyKey)` (pattern of
`MP-GBR-18`).

`SM-3.7` — A failed registration **MUST** emit no event.

`SM-3.8` — `registrationSource` **MUST** be recorded as a closed set: `StaffAssisted`, `SelfEnrollment`,
`Import`.

`SM-3.9` — Staff-assisted registration **MUST** be permitted to `TR-1`, `TR-2`, `TR-3`.

`SM-3.10` — Self-enrollment **MUST** be gated by Library Discovery (§14A) and **MUST** create the record only
after the person authenticates (`AR-2`).

### 3.3 Duplicate prevention

`SM-3.11` — A second `Active` `StudentRecord` for the same `(tenantId, personId)` **MUST** be rejected
(`SM-INV-6`).

`SM-3.12` — The duplicate check **MUST** use `personId`, never name, mobile number or email. Names collide;
identities do not.

`SM-3.13` — Rejection **MUST** return the existing `StudentRecordId` to an authorized caller so staff can open
the record rather than retry.

`SM-3.14` — An `Archived` record for the same `(tenantId, personId)` **MUST** offer restore (§2.3) rather than
create a second record.

`SM-3.14a` — Because `SM-10.2`'s unique constraint is **partial** (it excludes `Archived`), more than one
`Archived` record **MAY** exist for one `(tenantId, personId)`. Where more than one exists, restore **MUST**
target the **most recently archived** record, determined by `archivedAt` descending, and the remaining archived
records **MUST** remain archived. Where `archivedAt` ties, the record with the greater `StudentRecordId`
ordinal **MUST** be chosen so that the outcome is deterministic (`SM-3.16` pattern).

`SM-3.14b` — The restore operation **MUST** present the count of archived records for that
`(tenantId, personId)` to the caller, and **MUST NOT** silently discard the existence of the others.

> **Why the constraint stays partial.** Making `(tenant_id, person_id)` absolutely unique would make archival
> destructive: a student who leaves and returns twice could not retain two separate historical records, and
> `ID-5` requires that financial and attendance history be **retained**. The partial index is therefore correct;
> what was missing was a deterministic rule for *which* archived record restore targets (finding `RF-13`).

`SM-3.15` — The same `personId` enrolling at a **different** tenant **MUST** be permitted and **MUST** create an
independent `StudentRecordId` (`MP-ASM-04`, BC Map §4.1).

### 3.4 Concurrency

`SM-3.16` — Concurrent registration for one `(tenantId, personId)` **MUST** be resolved by a unique database
constraint, not by an application check alone.

`SM-3.17` — `enrollmentNumber` allocation **MUST** be collision-free under concurrency.

---

## 4. Student Profile, Guardian & Documents

### 4.1 What this module stores

`SM-4.1` — This module **MUST** store the **organisation-internal** student profile only: `ContactDetails`,
`GuardianLink`, `DocumentRef[]`, Library Identification Photo.

`SM-4.2` — This module **MUST NOT** store Full Name, Username, Global Profile Photo, Bio, Gender, Date of Birth,
Address, Email or Occupation. Those are owned by `BC-10` (`SID-2.8`) and read through `E-13`.

`SM-4.3` — The **Library Identification Photo** is owned here and **MUST** be distinct from the Global Profile
Photo owned by `BC-10` (`Student_Identity_PRD_v1.md` line 122).

> **Two photos is deliberate, not duplication.** The Global Profile Photo is the person's own, visible per their
> privacy settings. The Library Identification Photo is the library's operational record for door identification.
> Conflating them means a student changing their avatar changes the reception desk's identification photo.

### 4.2 Guardian

`SM-4.4` — `GuardianLink` **MUST** be mandatory when the person's age is **known** to be under 18
(`SM-INV-3`).

`SM-4.5` — Age **MUST** be derived from the `BC-10` Date of Birth read through `E-13`, never stored here
(`SM-4.2`).

#### 4.2.1 Date of Birth is optional at `BC-10` — the three cases

Date of Birth is an **optional** field of the Global Person Identity (`PRD-003` §2.4 *Optional* list; `SID-2.5`
*"Only the minimum information required for identity **SHALL** be mandatory"*). This module therefore **MUST NOT**
assume a Date of Birth is present, and **MUST** define deterministic behaviour for all three cases. An earlier
draft defined only the first two, which left `SM-INV-3` unevaluable (finding `RF-06`).

| # | Case | Required behaviour |
|---|---|---|
| 1 | **DOB present, age < 18** | `GuardianLink` is **mandatory**. Enrollment without it **MUST** be rejected with a typed error (`SM-4.4`, `SM-INV-3`) |
| 2 | **DOB present, age ≥ 18** | `GuardianLink` is **optional**. It **MUST** be accepted if supplied, and its absence **MUST NOT** block enrollment |
| 3 | **DOB absent** | `SM-4.5a` below governs. `SM-INV-3` is **indeterminate**, not satisfied |

`SM-4.5a` — Where the `BC-10` Date of Birth is **absent**, this module **MUST NOT** infer, default or assume an
age, and **MUST NOT** treat `SM-INV-3` as satisfied. It **MUST** instead record the enrollment's minor-status as
**`Unknown`** and **MUST** require a staff-recorded **age declaration** — a `TR-1`/`TR-2`/`TR-3` attestation of
whether the student is a minor — before the record may leave `Pending`. The declaration **MUST** be audited with
actor and timestamp (`SM-8.13`).

`SM-4.5b` — Until minor-status is either derived from a Date of Birth or declared under `SM-4.5a`, the record
**MUST** be treated as **minor** for safeguarding purposes: `GuardianLink` is required, and any capability gated
on `ID-6` minor consent **MUST** remain closed. This is a **fail-safe**, not a legal determination — it is the
deny-by-default posture required by `AP-3`, applied to the case where the input is missing.

> **Why fail-safe and not fail-open.** `SID-4.56` requires that a rule which cannot be checked be treated as
> **unmet**, not as satisfied by intent. `SM-INV-3` exists to protect minors; if the input it depends on is
> absent, the only posture consistent with `SID-4.56` and `AP-3` is the protective one. This creates minor
> friction for adult students with no recorded Date of Birth — that cost is deliberate and is resolved by the
> `SM-4.5a` declaration, which is a single staff action.

`SM-4.5c` — This module **MUST NOT** require, request or cause a Date of Birth to become mandatory at `BC-10`.
Whether `PRD-003` should make it mandatory is a decision for the `BC-10` owner and would require an ADR; it is
recorded as proposed gap `SM-GAP-10` and **MUST NOT** be resolved here (`SM-XC-2`, `SID-2.42`).

`SM-4.6` — Parent/guardian **contact** is owned by this module (`SID-2.8`, line 498).

`SM-4.7` — A guardian's own `Account` and `TR-5` Parent role **MUST NOT** be created by this module.

`SM-4.8` — Minor consent **MUST** be gated by `BC-18` Consent Management (`ID-6`). This module **MUST NOT**
implement a consent record.

### 4.3 Documents

`SM-4.9` — Every document **MUST** be stored as a `FileRef` issued by `BC-29` through `E-22` (`SM-INV-10`).

`SM-4.10` — This module **MUST NOT** store bytes, a raw storage path or a signed URL.

`SM-4.11` — Document access **MUST** be authorized per request; a `FileRef` **MUST NOT** be a bearer capability.

`SM-4.12` — A `BC-29` outage **MUST** degrade document display only, and **MUST NOT** fail the record
(`SID-2.40`).

---

## 5. Library Members Directory

> **Architectural position — normative.** Master PRD §8 module 3: *"Library Member Directory — `BC-01` Enrollment
> **(read composition)**."* Per `AR-1` and `SID-2.41` this chapter specifies an **application-layer read
> composition**. It owns no aggregate, no invariant, no table and no lifecycle. Every value it shows is owned by
> another context or by chapters 2–4 of this document.

### 5.1 Nature and gating

`LMD-1` — The Directory **MUST** be a read composition. It **MUST NOT** own an aggregate or an independent
invariant (`AR-1`, `SM-1.6`).

`LMD-2` — The Directory **MUST NOT** persist a member row, member table, member cache or materialised member
entity beyond a display request (`SID-2.38`).

`LMD-3` — The Directory **MUST NOT** define a `MemberStatus` of its own. It displays `EnrollmentStatus` (`BC-01`)
and `MembershipStatus` (`BC-02`) as two distinct fields (`SM-2.7`, BC Map line 209).

`LMD-4` — Directory exposure **MUST** be gated by `LCFG-5`, whose default is **Disabled** (`AP-3`, deny by
default).

`LMD-5` — Disabling `LCFG-5` **MUST** suppress directory exposure **without deleting** any membership or student
record (`LIB-16.6`, verbatim requirement).

`LMD-6` — `LCFG-5` **MUST** be read through the `BC-25` typed accessor (`E-19`); no raw string lookup
(`ADR-0013`).

`LMD-7` — The Directory **MUST NOT** appear in any public or unauthenticated surface (`14B` line 173: *"Member
Directory in any form — `LCFG-5`, tenant-private"*).

### 5.2 Listing, search, filter, sort, pagination

`LMD-8` — The member list **MUST** be scoped to exactly one `tenantId`, applied server-side before any filter
(`MP-GBR-08`, `X-13`).

`LMD-9` — Listing **MUST** be paginated. An unbounded list **MUST NOT** be returned.

`LMD-10` — Default page size **MUST** be `SMCFG-1`; maximum `SMCFG-2`. A request exceeding the maximum **MUST** be
clamped, not rejected.

`LMD-11` — Pagination **MUST** be stable under concurrent writes — cursor-based, not offset-based, where ordering
permits.

`LMD-12` — Search **MUST** be served by `BC-23` Search Indexing through `E-21`. The Directory **MUST NOT** query
domain tables directly for search (`E-21`: *"Search never reads domain tables"*).

`LMD-13` — Search **MUST** be permission-aware and tenant-partitioned (`PRD-015` scope).

`LMD-14` — Search **MUST** match on enrollment number and on identity fields the caller is authorized to see;
matching **MUST NOT** leak an unauthorized field through result ranking or highlighting.

`LMD-15` — Filters **MUST** be limited to: `EnrollmentStatus`, membership status, membership expiry window, shift,
seat assigned/unassigned, fee status, registration date range, guardian-required. Each **MUST** resolve to a
projection owned by the context in §5.4.

`LMD-15a` — Filters divide into two classes, and the distinction **MUST** be visible in the API contract:

| Class | Fields | Guarantee |
|---|---|---|
| **Authoritative** | `EnrollmentStatus`, registration date range, guardian-required | Owned locally (§5.4 row 2). Cursor-stable under `LMD-11` |
| **Best-effort** | membership status, membership expiry window, shift, seat assigned/unassigned, fee status | Composed from an **eventually consistent** foreign projection (§5.4). Results **MUST** be labelled with the projection's as-of time (`LMD-23`) and **MUST NOT** be presented as an exact count |

`LMD-15b` — `LMD-11` cursor stability **MUST** be guaranteed only for **authoritative** filters. A best-effort
filter **MAY** yield a row that shifts page between requests as the upstream projection converges; this **MUST**
be disclosed in the API contract rather than concealed.

> **Why this is a real limit and not a workaround.** `LMD-11` demands pagination stable under concurrent writes,
> while `LMD-15` permits filtering on values this module does not own and cannot transactionally observe. Those
> two cannot both hold absolutely (finding `RF-11`). Claiming stability over an eventually consistent projection
> would be a promise the architecture cannot keep, and `SID-4.56` treats an uncheckable promise as unmet. Stating
> the limit is the honest resolution; the alternative — dropping the filters — removes real operational value.

`LMD-16` — A membership-expiry filter **MUST** read the `BC-02` `MembershipValidity` projection and **MUST NOT**
compute expiry from any locally stored date (`SM-2.4`).

`LMD-17` — Sorting **MUST** be limited to fields present in the composed projection, and **MUST** be
deterministic — every sort **MUST** have a documented tie-breaker.

`LMD-18` — An empty result **MUST** be distinguishable from an unavailable projection (`SID-2.40`).

### 5.3 Member detail

`LMD-19` — Member detail **MUST** compose, and **MUST NOT** duplicate: identity core (`BC-10`, `E-13`), enrollment
record (this module), membership (`BC-02`), seat (`BC-04`), attendance summary (`BC-03`), fee status (`BC-05`),
documents (`BC-29`).

`LMD-20` — Every composed value **MUST** be fetched under the **caller's own** authorisation (`SID-2.39`).

`LMD-21` — Composition **MUST** degrade gracefully: an unavailable contributor **MUST** render that section
unavailable and **MUST NOT** fail the rest of the screen (`SID-2.40`).

`LMD-22` — Composition **MUST NOT** occur in the domain layer (`SID-2.41`, `AR-1`).

`LMD-23` — A stale projection **MUST** be labelled with its as-of time where it affects a decision; it **MUST
NOT** be presented as authoritative (`SID-2.38`).

### 5.4 Read projections — owner per field

The `Mechanism` column states **how** each field group reaches the screen. Two mechanisms exist, and the
distinction is normative:

- **Declared edge** — a BC Map §7 integration edge traversed by this module. Available to the domain layer.
- **`AR-1` composition** — an application-layer read composition of another context's public read model. It is
  **not** an integration edge, it creates no dependency for the domain layer, and it requires no entry in
  BC Map §7 (`SM-7.1a`, `LMD-22`, `SID-2.41`). The contributing context remains the sole authority.

| Field group | Owner | Edge | Mechanism | Consistency |
|---|---|---|---|---|
| Full Name, Global Profile Photo, DOB, gender | `BC-10` | `E-13` | **Declared edge** — sync port through ACL | Strong, read-time |
| Enrollment number, `EnrollmentStatus`, contact, guardian, documents | **This module** | — | Owned | Strong |
| Plan, membership status, `validUntil`, seat quota | `BC-02` | **none — none required** | **`AR-1` composition** of the `BC-02` public read model | Eventual |
| Attendance percentage, present days | `BC-03` | **none — none required** | **`AR-1` composition** of the `BC-03` public read model | Eventual |
| Current seat, shift, zone | `BC-04` | **none — none required** | **`AR-1` composition** of the `BC-04` public read model | Eventual |
| Fee status, outstanding balance | `BC-05` | **none — none required** | **`AR-1` composition** of the `BC-05` public read model | Eventual |
| Document `FileRef` resolution | `BC-29` | `E-22` | **Declared edge** — sync port | Strong, read-time |

> **On the four *"none required"* rows.** BC Map §7 declares no `BC-01`→`BC-03` and no `BC-01`→`BC-04` edge, and
> its `BC-01`→`BC-02` (`E-01`) and `BC-01`→`BC-05` (`E-09`) edges are **event** edges for enrollment and dues
> assertion — not read edges. That is correct and **MUST NOT** be changed to suit this screen. Composition at the
> application layer is the authorised mechanism, exactly as `AR-1` ruled for Library Discovery. An earlier draft
> cited an *"`E-02` pattern"* here; `E-02` is `BC-02`→`BC-04`, an edge between two **other** contexts, and that
> citation was wrong. It has been removed rather than reinterpreted.

`LMD-24` — This table is **normative**. The Directory **MUST NOT** become authoritative for any row it does not
own (`SM-XC-8`, `SID-2.38`).

`LMD-24a` — No row in this table **MUST** be read from this module's **domain layer** (`SM-7.1`, `SM-7.1a`,
`LMD-22`). A composed value **MUST NOT** be persisted by this module, cached beyond the display request, or used
to evaluate any invariant this module owns (`SID-2.38`–`SID-2.41`).

`LMD-24b` — Composition **MUST NOT** make `BC-01` authoritative over `MembershipStatus`, seat assignment,
attendance or fee balance. Each remains owned by `BC-02`, `BC-04`, `BC-03` and `BC-05` respectively, and every
**write** to those values **MUST** be delegated to the owning module's command API, which re-validates its own
invariants (`LMD-28`, rule `F-3`, `AR-1`).

### 5.5 Status and expiry indicators

`LMD-25` — Enrollment status and membership status **MUST** be displayed as **two** independent indicators. A
single merged badge **MUST NOT** be used (BC Map line 209).

`LMD-26` — An expiring-soon indicator **MUST** derive from the `BC-02` projection and its threshold **MUST** be
`SMCFG-3`.

`LMD-27` — An `Archived` record **MUST NOT** appear in the default list, and **MUST** be reachable through an
explicit archived filter available to `TR-1` and `TR-2`.

### 5.6 Authorized directory actions

`LMD-28` — The Directory **MUST NOT** perform any write itself. Every action **MUST** delegate to the owning
module's command API, which re-validates every invariant (`AR-1`, rule `F-3`).

`LMD-29` — Directory-initiated actions **MUST** be limited to the protected operations in §8.2, and each **MUST**
be authorized individually — visibility in a list **MUST NOT** imply permission to act.

`LMD-30` — Bulk actions **MUST** be limited to status change and export, **MUST** be capped at `SMCFG-4` records,
and **MUST** report per-record outcomes. A partial failure **MUST NOT** roll back succeeded records, and **MUST
NOT** be reported as success (§9.2, `SM-BR-14`).

`LMD-31` — Directory export **MUST** be an audited protected operation (`SM-PO-11`) and **MUST** respect
`LCFG-5` and per-field authorisation.

---

## 6. Student Operations

`SM-6.1` — This module **MUST** provide: view record, update profile, change status, manage guardian, manage
documents, archive, restore, view history.

`SM-6.2` — Update **MUST** be field-level authorized. A caller authorized to view **MUST NOT** implicitly be
authorized to edit (`LMD-29`).

`SM-6.3` — Concurrent update **MUST** be resolved by optimistic concurrency on a record version; a lost update
**MUST NOT** occur silently.

`SM-6.4` — An update to a `BC-10`-owned field **MUST** be rejected with a pointer to `BC-10`, not silently
ignored (`SM-4.2`).

`SM-6.5` — Member history **MUST** expose status transitions, profile changes and document changes with actor,
timestamp and reason.

`SM-6.6` — History **MUST** be read from `BC-24` Audit Trail where the entry is an audit fact; this module **MUST
NOT** maintain a parallel audit store.

`SM-6.7` — **Library transfer MUST NOT be implemented as a record move.** It is an archive at the source tenant
and an independent registration at the destination, because `StudentRecordId` never crosses a tenant (`ID-2`).

`SM-6.8` — Membership renewal **MUST** be delegated to `BC-02`. This module **MUST NOT** extend a membership term.

---

## 7. Cross-Context Integrations

### 7.1 Edges — all declared in BC Map §7

> BC Map line 292: *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."*
> **Every edge below already exists. This document adds none.**

| Edge | Direction | Mode | Mechanism | Purpose | Failure behaviour |
|---|---|---|---|---|---|
| `E-11` | `BC-18` → `BC-01` | `CF` | Sync port | `AccountId` resolution; stored, never mutated | Registration fails closed |
| `E-13` | `BC-01` → `BC-10` | **`ACL`** | Sync port through ACL | Resolve identity core for held `PersonId` | Identity section unavailable (`SID-2.40`) |
| `E-01` | `BC-01` → `BC-02` | `C/S` | Event | `StudentEnrolled`, `StudentStatusChanged` | Retry with idempotent consumer |
| `E-09` | `BC-01` → `BC-05` | `C/S` | Event | `StudentArchived` → dues assertion | **Archive blocked** on open dues |
| `E-21` | `BC-01` → `BC-23` | `PL` | Event | Index for search | Search degrades; list still works |
| `E-22` | `BC-01` → `BC-29` | `CF` | Sync port | `FileRef` for documents/photo | Documents unavailable only |

`SM-7.1` — This module's **domain layer** **MUST NOT** create, traverse or depend upon an integration edge
absent from BC Map §7. A **domain-layer** dependency on another bounded context that BC Map §7 does not declare
is a defect, and adding such an edge requires an ADR (BC Map line 292).

`SM-7.1a` — `SM-7.1` binds the **domain layer**. It does **not** prohibit **application-layer read
composition**, which ruling `AR-1` established is *not* an integration edge: a read composition *"owns no
aggregate, owns no invariant, owns no business state, only orchestrates public read models, delegates all
domain operations to their owning modules."* `AR-1` composes read models from seven contexts — including
`BC-02` Membership Plans and `BC-04` Seat Capacity — and **assigns no `BC-` identifier and declares no new
edge**. §5.4 composition follows that identical precedent (`LMD-22`, `SID-2.41`).

> **Why this distinction is load-bearing.** Without it this chapter contradicts itself: `LMD-19` requires the
> member detail screen to display membership, seat, attendance and fee status, while BC Map §7 declares **no**
> `BC-01`→`BC-03` or `BC-01`→`BC-04` edge in any direction, and `E-01`/`E-09` are **event** edges, not read
> edges. The resolution is not to invent read edges — it is to recognise that composing a screen is not the
> same act as a domain dependency. `AR-1` already ruled on exactly this, for exactly this reason.

`SM-7.2` — Every edge **MUST** be traversed through a declared port; no concrete cross-module class (`L3`).

`SM-7.3` — `E-13` **MUST** be traversed through an **ACL**, never a direct import (`ID-3`, `X-05` boundary).

`SM-7.4` — Reference direction across `E-13` **MUST** be upward only. `BC-10` **MUST NOT** hold a
`StudentRecordId` or `tenantId` (`ID-2`, BC Map line 317).

### 7.2 Consistency and failure

`SM-7.5` — Event-based edges (`E-01`, `E-09`, `E-21`) **MUST** be eventually consistent with idempotent
consumers.

`SM-7.6` — Sync-port edges (`E-11`, `E-13`, `E-22`) **MUST** fail closed for writes and degrade gracefully for
reads.

`SM-7.7` — Retry **MUST** be bounded and **MUST NOT** duplicate a domain effect; the consumer's idempotency key
**MUST** be the event ID.

`SM-7.7a` — Publication **MUST** be **producer-side atomic**: every event in §7.4 **MUST** be recorded in a
transactional **outbox** within the same transaction as the state change that caused it, and dispatched from the
outbox afterwards. A committed state change with an unpublished event, or a published event with an uncommitted
state change, **MUST** be impossible (`SM-7.17`).

`SM-7.7b` — The outbox **MUST** be tenant-partitioned (`MP-GBR-08`, `X-13`) and **MUST** preserve per-aggregate
ordering (`SM-7.16`).

> **Why producer-side is required, not only consumer-side.** `SM-7.5` and `SM-7.7` make *consumers* idempotent,
> which prevents double-application of a delivered event — but nothing above prevented an event from being **lost**
> between commit and publish, which would silently break `E-01` (*"Membership may not exist without an active
> enrollment"*). BC Map `E-20` already specifies *"fire-and-forget, **outbox-backed**"* for audit; the same
> mechanism is required here (finding `RF-19`).

`SM-7.8` — A stale projection **MUST NOT** be used to authorize an operation. Authorisation **MUST** be a
`BC-18` decision at request time (`X-13`, `LCFG-13` principle: *"never applies to an authorization decision"*).

### 7.3 Forbidden dependencies

`SM-7.9` — This module **MUST NOT** depend on `BC-11`…`BC-17` (`X-05`).

`SM-7.10` — This module **MUST NOT** be depended upon by `BC-10` (`ID-2`, `SM-7.4`).

`SM-7.11` — This module **MUST NOT** depend on a capability platform's concrete class; only declared ports
(`L3`, `L4`).

### 7.4 Events — `SM-EV-1` … `SM-EV-10`, closed set

Event names **MUST** follow the BC Map §8 convention `<context>.<Aggregate><PastTenseVerb>`. For this module the
context prefix is **`enrollment.`** — the convention is binding, and BC Map §8 already registers this module's
events in that form.

| ID | Event | Consumers | Payload | Justification |
|---|---|---|---|---|
| `SM-EV-1` | `enrollment.StudentEnrolled` | `BC-02`, `BC-23` | `studentRecordId`, `tenantId`, `enrollmentNumber`, `at` | `E-01` — Membership may not exist without active enrollment |
| `SM-EV-2` | `enrollment.StudentStatusChanged` | `BC-02`, `BC-04`, `BC-23` | ids, `from`, `to`, `reason`, `actor`, `at` | `E-01`; Seating must react to suspension |
| `SM-EV-3` | `enrollment.StudentArchived` | `BC-05`, `BC-02`, `BC-23` | ids, `at` | `E-09` — emitted **after** the dues pre-condition has passed and the archive is committed (`SM-7.17`) |
| `SM-EV-4` | `enrollment.StudentRestored` | `BC-02`, `BC-23` | ids, `at` | Reverses `SM-EV-3` for consumers that reacted |
| `SM-EV-5` | `enrollment.StudentProfileUpdated` | `BC-23` | ids, changed field names **only** | `E-21` reindex |
| `SM-EV-6` | `enrollment.GuardianLinkChanged` | `BC-22` | ids, `hasGuardian` | Minor-safeguarding notice. `E-23` — the domain emits a **fact**, never *"send an SMS"* |
| `SM-EV-7` | `enrollment.StudentDocumentAttached` | `BC-23` | ids, `documentType` | Reindex; no `FileRef` in payload |
| `SM-EV-8` | `enrollment.StudentDocumentRemoved` | `BC-23` | ids, `documentType` | Reindex |
| `SM-EV-9` | `enrollment.EnrollmentNumberAssigned` | `BC-23` | ids, `enrollmentNumber` | Searchable identifier. Emitted with `SM-EV-1` when assignment is synchronous |
| `SM-EV-10` | `enrollment.StudentLinkedToPerson` | `BC-10` **via the `E-13` ACL** | `personId`, `tenantId`, `at`, `consentRecordRef` — **never** `studentRecordId` (`SM-7.15`) | **BC Map §8 already assigns this event to `BC-01`** as *"the consented social bridge."* BC Map line 466: *"Enroll → activate social profile … Consent gate → `StudentLinkedToPerson` → ACL"* |

**`SM-EV-10` is not a new event.** It is an existing architectural obligation that an earlier draft of this
document omitted. It is recorded here so that the register matches the Bounded Context Map; the BC Map is
**not** modified, and no ADR is required (finding `RF-02`).

`SM-7.12` — This set **MUST** be closed at **ten** events. A new event requires an ADR.

`SM-7.12a` — `SM-EV-10` **MUST** be emitted **only** after `BC-18` Consent Management has recorded consent
(`ID-6`, `SM-4.8`). Absent consent it **MUST NOT** be emitted, and enrollment **MUST** still succeed — the
social profile simply remains inactive. This module **MUST NOT** evaluate the consent rule itself; it consumes
the `BC-18` decision (`SM-4.8`).

`SM-7.12b` — `SM-EV-10` **MUST NOT** carry `StudentRecordId`, because `BC-10` is a global context
(`SM-7.15`, `ID-2`, `MP-GBR-03`). It carries the `PersonId` this module already holds (`SM-INV-5`).

`SM-7.13` — Every event **MUST** carry `eventId`, `occurredAt`, `correlationId`, `tenantId`, `actor`.

`SM-7.14` — No event payload **MUST** contain a credential, an OTP, a raw document byte, a `FileRef` resolvable
without authorisation, or a `BC-10`-owned personal field.

`SM-7.15` — `StudentRecordId` **MUST NOT** appear in any event consumed by a global context (`ID-2`,
`MP-GBR-03`). `BC-23` indexes are tenant-partitioned, which is why `E-21` is permitted.

`SM-7.16` — Ordering **MUST** be guaranteed per `studentRecordId` only. Global ordering **MUST NOT** be assumed.

`SM-7.17` — Events **MUST** be emitted only on committed state change. **No CRUD event** is emitted for a read.

> **`SM-7.17` and the ten-event ceiling answer your Phase 13 constraint directly.** Every event above has a named
> consumer and a declared edge. `StudentViewed` is deliberately absent — viewing is an *audit* concern (§8.3), not
> a domain event.

---

## 8. Security, Permissions & Audit

### 8.1 Isolation

`SM-8.1` — Every query and command **MUST** be tenant-scoped server-side; a tenant-less store access **MUST** be
refused (`X-13`, tenant-key check).

`SM-8.2` — `tenantId` **MUST NOT** be accepted from a client-supplied parameter as the authorisation basis; it
**MUST** derive from the session's authorisation context.

`SM-8.3` — A cross-tenant read **MUST** be impossible, not merely filtered.

`SM-8.4` — A Platform Administrator **MUST NOT** have access to tenant student data by virtue of the role;
access requires explicit, audited, time-bounded elevation (`LIB-4.2`, `AUTH-7.13`, `AUTH-7.16`, `CFG-12`).

### 8.2 Protected operations — `SM-PO-1` … `SM-PO-12`, closed list

Roles are the authoritative closed set `TR-1` Owner, `TR-2` Manager, `TR-3` Reception, `TR-4` Student, `TR-5`
Parent, Platform Administrator (`LIB-4.1`, `AUTH-7.21`). **This module introduces no role** (`SM-XC-6`).

| ID | Operation | `TR-1` | `TR-2` | `TR-3` | `TR-4` | `TR-5` |
|---|---|---|---|---|---|---|
| `SM-PO-1` | View member list (Directory) | ✅ | ✅ | ✅ | ❌ | ❌ |
| `SM-PO-2` | View member detail | ✅ | ✅ | ✅ | own only | ❌ *(interim — `SM-8.4a`)* |
| `SM-PO-3` | Register student | ✅ | ✅ | ✅ | self-enroll | ❌ |
| `SM-PO-4` | Update profile | ✅ | ✅ | ✅ | own subset | ❌ |
| `SM-PO-5` | Change status → `Inactive`/`Suspended` | ✅ | ✅ | ❌ | ❌ | ❌ |
| `SM-PO-6` | Reactivate → `Active` | ✅ | ✅ | ❌ | ❌ | ❌ |
| `SM-PO-7` | Archive | ✅ | ❌ | ❌ | ❌ | ❌ |
| `SM-PO-8` | Restore from archive | ✅ | ❌ | ❌ | ❌ | ❌ |
| `SM-PO-9` | View/attach/remove documents | ✅ | ✅ | view | own only | ❌ |
| `SM-PO-10` | View sensitive data (guardian contact, DOB) | ✅ | ✅ | ❌ | own only | ❌ *(interim — `SM-8.4a`)* |
| `SM-PO-11` | Directory export | ✅ | ❌ | ❌ | ❌ | ❌ |
| `SM-PO-12` | Bulk status change | ✅ | ✅ | ❌ | ❌ | ❌ |

`SM-8.4a` — `TR-5` Parent is **denied** `SM-PO-2` and `SM-PO-10` in V1. This is an **interim decision, not a
resolution**: the Parent Portal is Master PRD §8 module 5, a composition with no PRD, so no authoritative
grant exists. Where no authorisation exists, `AP-3` requires deny, and `SID-4.56` forbids treating an
uncheckable rule as satisfied. Proposed gap `SM-GAP-4` therefore **remains open**; when the Parent Portal
authorisation model is defined, these two cells **MUST** be revisited, and widening them requires a document
change under `SM-8.5`.

> **Why the table no longer says "GAP".** A closed list (`SM-8.5`) cannot contain an undefined cell — an
> undefined permission is not a permission, it is an unimplementable instruction, and an implementer facing it
> would have to guess. Recording the safe interim value makes the list executable while the open question stays
> visible in §10.6. The gap is not closed by this requirement; only the ambiguity is. Finding `RF-12`.

`SM-8.5` — This list **MUST** be closed. A new protected operation requires a document change and an ADR if it
alters a boundary.

`SM-8.6` — Every operation **MUST** be authorized by a `BC-18` policy decision at request time. This module
**MUST NOT** evaluate its own authorisation (`SM-XC-12`, `X-13`).

`SM-8.7` — `TR-4` and `TR-5` hold no staff permission in this module (`LIB-4.1` closing note).

`SM-8.8` — Staff and managers **MUST NOT** appear as records in this module; they access it by role only
(`SM-XC-4`, `SM-XC-5`).

`SM-8.9` — An unauthorized access attempt **MUST** fail closed, **MUST** be audited, and **MUST NOT** reveal
whether the record exists (anti-enumeration, pattern of `AR-7`).

### 8.3 Audit

`SM-8.10` — The following **MUST** be audited to `BC-24`: registration, profile modification, status change,
suspension, archive, restore, guardian change, document attach/remove, **sensitive-data access** (`SM-PO-10`),
export, every bulk operation, and every authorisation denial.

`SM-8.11` — Every audit entry **MUST** carry actor, role, tenant, target `studentRecordId`, action, timestamp,
correlation ID, and reason where required.

`SM-8.12` — Audit entries **MUST** be append-only. This module **MUST NOT** update or delete an audit entry
(`X-10`, `AU-1`).

`SM-8.13` — Sensitive-data **reads** **MUST** be audited even though they emit no domain event (`SM-7.17`).

`SM-8.14` — A bulk operation **MUST** produce one audit entry per affected record, not one for the batch.

### 8.4 Privacy and retention

`SM-8.15` — Data minimisation: this module **MUST NOT** collect a field it does not use in a specified
requirement.

`SM-8.16` — Retention of financial and attendance history **MUST** follow `ID-5` and the Data Privacy runbook.
This module **MUST NOT** define its own retention period — **`SM-GAP-1`**.

`SM-8.17` — Export **MUST** be minimised to authorized fields and **MUST** be audited (`SM-PO-11`).

---

## 9. Business Rules & Functional Requirements

### 9.1 Business rules — `SM-BR-1` … `SM-BR-16`

| ID | Rule | Source |
|---|---|---|
| `SM-BR-1` | One `StudentRecord` per `(tenant, person)`; the same person may enroll at many tenants | `MP-ASM-04`, `SM-INV-6` |
| `SM-BR-2` | `EnrollmentStatus` and `MembershipStatus` are independent state machines | BC Map line 209 |
| `SM-BR-3` | A student may be `Active` with an expired membership | BC Map line 209 |
| `SM-BR-4` | A student may not be **seated** without a valid membership; seating blocks, attendance flags | `MP-GBR-16` |
| `SM-BR-5` | Archive is blocked by outstanding dues | `E-09`, `SM-INV-4` |
| `SM-BR-6` | Guardian mandatory under 18 | `SM-INV-3`, `ID-6` |
| `SM-BR-7` | Soft delete preferred; hard delete only where legally compelled | `MP-GBR-14`, `ID-5` |
| `SM-BR-8` | Every critical action is auditable | `MP-GBR` audit rule, `SM-8.10` |
| `SM-BR-9` | Registration is idempotent | `MP-GBR-18` pattern |
| `SM-BR-10` | `StudentRecordId` never leaves its tenant | `MP-GBR-03`, `ID-2` |
| `SM-BR-11` | `PersonId` is non-nullable and immutable once set | `ADR-0011`, `ID-4` |
| `SM-BR-12` | The Directory is deny-by-default | `LCFG-5`, `AP-3` |
| `SM-BR-13` | The Directory never becomes authoritative for a composed value | `SID-2.38` |
| `SM-BR-14` | A partial bulk failure is reported as partial, never as success | `LMD-30` |
| `SM-BR-15` | Library transfer is archive-plus-new-registration, never a record move | `ID-2`, `SM-6.7` |
| `SM-BR-16` | Status changes are never retroactive | `MP-GBR-19` pattern |

### 9.2 Edge cases — specified, not discovered later

| Case | Required behaviour | Requirement |
|---|---|---|
| Same identity, multiple libraries | Permitted; independent `StudentRecordId` | `SM-3.15` |
| Duplicate registration | Rejected; existing id returned to authorized caller | `SM-3.11`, `SM-3.13` |
| Archived person re-registers | Offer restore, not a second record | `SM-3.14` |
| Concurrent registration | DB unique constraint decides | `SM-3.16` |
| Expired membership | Enrollment unaffected; Directory shows two indicators | `SM-2.7`, `LMD-25` |
| Suspended member | Seat/membership blocked; attendance still recorded | `SM-2.14` |
| Deleted/disabled Account | Record retained, pseudonymised per `ID-5` | `SM-2.16` |
| Missing external reference | Section unavailable; record still renders | `LMD-21` |
| Stale projection | Labelled as-of; never used to authorize | `LMD-23`, `SM-7.8` |
| Failed integration | Bounded retry, idempotent, no duplicate effect | `SM-7.7` |
| Library transfer | Archive + new registration | `SM-6.7` |
| Membership renewal | Delegated to `BC-02` | `SM-6.8` |
| Conflicting updates | Optimistic concurrency; no silent lost update | `SM-6.3` |
| Unauthorized access | Fail closed, audited, existence not revealed | `SM-8.9` |
| Bulk partial failure | Per-record outcomes; no rollback of successes | `LMD-30` |
| `LCFG-5` disabled | Directory suppressed; no data deleted | `LMD-5` |

---

## 10. Data Model, API, Acceptance Criteria, Traceability & Tasks

### 10.1 Persistence

`SM-10.1` — Table `student_record`: PK `student_record_id`; **mandatory** `tenant_id`; `person_id` NOT NULL;
`account_id`; `enrollment_number`; `enrollment_status`; `registered_at`; `registration_source`; `version`;
`created_by`; `updated_by`.

`SM-10.2` — Unique constraints **MUST** exist on `(tenant_id, enrollment_number)` (`SM-INV-1`) and
`(tenant_id, person_id)` where status ≠ `Archived` (`SM-INV-6`). The second constraint is deliberately
**partial**: archived records are exempt so that history survives re-enrollment (`ID-5`, `SM-3.14a`).

`SM-10.3` — Every table **MUST** be tenant-partitioned and every access tenant-keyed (`X-13`).

`SM-10.4` — Archive **MUST** be a status value plus timestamp, not a row deletion (`MP-GBR-14`).

`SM-10.5` — Indexes **MUST** support the §5.2 filters: `(tenant_id, enrollment_status)`,
`(tenant_id, registered_at)`, `(tenant_id, enrollment_number)`.

`SM-10.6` — There **MUST NOT** be a `library_member` table, a `member_directory` table, or any denormalised copy
of membership, seat, attendance or fee data (`LMD-2`, `SM-2.4`).

### 10.2 API surface

Every endpoint is owned by **`BC-01`**. Authorisation is a `BC-18` decision (`SM-8.6`).

| Endpoint | Op | `SM-PO` | Idempotent | Notes |
|---|---|---|---|---|
| `POST /students` | Register | `SM-PO-3` | ✅ key required | `SM-3.4`–`SM-3.6` |
| `GET /students/{id}` | Detail | `SM-PO-2` | n/a | Composed per §5.3 |
| `GET /students` | List | `SM-PO-1` | n/a | Paginated, filtered, sorted (§5.2) |
| `GET /students/search` | Search | `SM-PO-1` | n/a | Served by `BC-23` (`LMD-12`) |
| `PATCH /students/{id}` | Update | `SM-PO-4` | version required | Field-level authz (`SM-6.2`) |
| `POST /students/{id}/status` | Status change | `SM-PO-5`/`6` | ✅ | Reason required |
| `POST /students/{id}/archive` | Archive | `SM-PO-7` | ✅ | Blocked on dues (`E-09`) |
| `POST /students/{id}/restore` | Restore | `SM-PO-8` | ✅ | `TR-1` only |
| `GET /students/{id}/history` | History | `SM-PO-2` | n/a | From `BC-24` (`SM-6.6`) |
| `POST /students/{id}/documents` | Attach | `SM-PO-9` | ✅ | `FileRef` only (`SM-4.9`) |
| `POST /students/bulk/status` | Bulk status | `SM-PO-12` | ✅ | Capped `SMCFG-4`; per-record results |
| `POST /students/export` | Export | `SM-PO-11` | ✅ | Audited; `LCFG-5` respected |

`SM-10.7` — Every mutating endpoint **MUST** require an idempotency key and **MUST** return the same result for a
repeat.

`SM-10.8` — Every error **MUST** be a typed domain error; a validation failure **MUST NOT** be a generic 500.

`SM-10.9` — No endpoint **MUST** accept `tenant_id` as an authorisation input (`SM-8.2`).

### 10.3 Configurables — `SMCFG-1` … `SMCFG-7`

All resolved through `BC-25` (`E-19`, typed accessors, no raw lookups).

| ID | Parameter | Default | Range | Class |
|---|---|---|---|---|
| `SMCFG-1` | Directory default page size | **20** | 5–50 | Security (bounds enumeration) |
| `SMCFG-2` | Directory maximum page size | **50** | 10–100 | Security |
| `SMCFG-3` | Membership expiring-soon threshold | **7 days** | 1–30 | Product |
| `SMCFG-4` | Bulk operation record cap | **100** | 10–500 | Security |
| `SMCFG-5` | Enrollment number format | tenant-prefixed sequence | — | Product |
| `SMCFG-6` | Documents per student | **10** | 1–25 | Product |
| `SMCFG-7` | Directory export row cap | **1000** | 100–5000 | Security |

`SM-10.10` — Every configurable **MUST** have a documented default; a library that changed nothing **MUST** be
fully operable (`LIB-16.2` pattern).

### 10.4 Acceptance criteria — `SM-AC-1` … `SM-AC-30`

Every criterion **MUST** name the requirement it verifies. A criterion that verifies nothing is not an acceptance
criterion, and a requirement that no criterion verifies is unenforced (`SID-4.56`). The `Verifies` column makes
both conditions mechanically checkable.

| ID | Criterion | Verifies |
|---|---|---|
| `SM-AC-1` | Registering the same `(tenant, person)` twice yields one record and a typed rejection | `SM-INV-6`, `SM-3.11`, `SM-3.13` |
| `SM-AC-2` | The same person registers at two tenants and receives two distinct `StudentRecordId`s | `SM-3.15`, `MP-ASM-04` |
| `SM-AC-3` | `personId` cannot be null — schema rejects it | `SM-INV-5`, `ADR-0011`, `ID-4` |
| `SM-AC-4` | No credential column exists on `student_record` (schema scan) | `SM-XC-1`, `SM-4.2` |
| `SM-AC-5` | Setting `EnrollmentStatus = Expired` is rejected — not in the closed set | `SM-2.2`, BC Map line 209 |
| `SM-AC-6` | A student remains `Active` when their membership expires | `SM-2.4`, BC Map line 209 |
| `SM-AC-7` | Archive with open dues is refused with a domain error | `SM-INV-4`, `E-09` |
| `SM-AC-8` | Archive does not delete attendance or fee history | `SM-10.4`, `MP-GBR-14`, `ID-5` |
| `SM-AC-9` | `Archived → Suspended` is refused | `SM-2.10`, `SM-2.13` |
| `SM-AC-10` | Every status change writes an audit entry with actor and reason | `SM-8.10`, `SM-6.6` |
| `SM-AC-11` | Status history is append-only; an update attempt fails | `SM-8.11`, `X-10` |
| `SM-AC-12` | A tenant-less repository call is refused (`X-13`) | `SM-8.1`, `SM-10.3`, `X-13` |
| `SM-AC-13` | A cross-tenant read returns nothing and is audited | `SM-8.1`, `MP-GBR-03` |
| `SM-AC-14` | A client-supplied `tenant_id` cannot widen access | `SM-8.2`, `SM-10.9` |
| `SM-AC-15` | `LCFG-5` disabled ⇒ Directory returns not-enabled; records remain intact | `LMD-3`, `LIB-16.6`, `LCFG-5` |
| `SM-AC-16` | Re-enabling `LCFG-5` restores the Directory with no data loss | `LMD-3`, `LIB-16.6` |
| `SM-AC-17` | Directory list is paginated; page size above `SMCFG-2` is clamped | `LMD-10`, `SMCFG-2` |
| `SM-AC-18` | No `library_member` table exists (schema scan) | `SM-10.6`, `LMD-2`, `AR-1` |
| `SM-AC-19` | Directory shows enrollment and membership status as two fields | `LMD-25`, BC Map line 209 |
| `SM-AC-20` | An unavailable `BC-02` projection renders that section unavailable only | `LMD-21`, `SID-2.40` |
| `SM-AC-21` | Directory search results come from `BC-23`, not a domain table query | `LMD-12`, `E-21` |
| `SM-AC-22` | A stale projection is never used in an authorisation decision | `LMD-23`, `SID-2.38` |
| `SM-AC-23` | `TR-3` Reception cannot archive; `TR-2` cannot archive; `TR-1` can | `SM-PO-7`, `LIB-4.1` |
| `SM-AC-24` | Sensitive-data access is audited even with no state change | `SM-8.13`, `SM-7.17` |
| `SM-AC-25` | Bulk partial failure reports per-record outcomes and is not success | `SM-8.17`, `SMCFG-4` |
| `SM-AC-26` | Repeating a mutating call with the same idempotency key changes nothing | `SM-10.7`, `SM-7.7` |
| `SM-AC-27` | Documents are `FileRef`s; no byte or path is stored (schema scan) | `SM-4.9`, `SM-4.10`, `SM-INV-10` |
| `SM-AC-28` | `StudentRecordId` appears in no global event or index | `SM-7.15`, `ID-2`, `MP-GBR-03` |
| `SM-AC-29` | With **no** `BC-10` Date of Birth, enrollment records minor-status `Unknown`, requires a guardian, keeps `ID-6`-gated capability closed, and cannot leave `Pending` until an age declaration is recorded and audited | `SM-INV-3`, `SM-4.5a`, `SM-4.5b`, `AP-3`, `SID-4.56` |
| `SM-AC-30` | With two `Archived` records for one `(tenant, person)`, restore targets the most recently archived, leaves the other archived, and reports the count | `SM-3.14a`, `SM-3.14b`, `SM-10.2` |

`SM-10.11` — Every requirement in this document **MUST** be verifiable by at least one criterion above, by a
`§10.7` task, or be declared a proposed gap in §10.6. A requirement satisfying none of the three is **unmet** by
`SID-4.56`, not merely untested.

`SM-10.12` — A committed event **MUST** exist for `SM-EV-10` in the outbox whenever consent has been recorded and
enrollment committed, and **MUST NOT** exist otherwise (`SM-7.7a`, `SM-7.12a`).

### 10.5 Traceability

| Requirement group | Traces to |
|---|---|
| §1 ownership, `SM-XC-*` | Master PRD §8 modules 3–4 · BC Map lines 96, 370, 209, §4.1 `ID-1`…`ID-6` · `X-05`, `X-13` · `LIB-4.1`, `LIB-5.1` |
| §2 lifecycle, `SM-INV-*` | BC Map line 209 (closed status set), line 370 (invariants) · `MP-GBR-14`, `MP-GBR-16`, `MP-GBR-19` · `ID-5` |
| §3 registration | `AR-2` · `ADR-0011`, `MP-GBR-02` · `E-11`, `E-13` · `MP-ASM-04` · `MP-GBR-18` |
| §4 profile/guardian/documents | `SID-2.8` (normative ownership), `Student_Identity_PRD_v1.md` line 122 · `E-22`, `ADR-0016` · `ID-6` |
| §5 Directory `LMD-1`…`LMD-31` | **Master PRD §8 module 3** *(read composition)* · `AR-1` · `SID-2.38`–`SID-2.41` · `LIB-16.6`, `LCFG-5`, `AP-3` · `14B` line 173 · `E-21` |
| §6 operations | BC Map line 96 · `ID-2` · `MP-GBR-19` |
| §7 integrations, `SM-EV-*` | BC Map §7 edges `E-01`, `E-09`, `E-11`, `E-13`, `E-21`, `E-22` · line 292 · rule `F-3` |
| §8 security/audit, `SM-PO-*` | `LIB-4.1`, `LIB-4.2` · `AUTH-7.13`, `AUTH-7.16`, `AUTH-7.21` · `X-10`, `X-13` · `CFG-12` |
| §9 rules, edge cases | `MP-GBR-03`, `MP-GBR-14`, `MP-GBR-16`, `MP-GBR-18`, `MP-GBR-19` · BC Map line 209 |
| §10 data/API/config | `X-13` · `E-19`, `ADR-0013` · `LIB-16.2` pattern |

#### 10.5.1 Coverage — computed, not asserted

The group table above shows *where* each chapter's authority comes from. It does **not** by itself prove
per-identifier coverage, and an earlier version of this section claimed *"233 of 242 identifiers (96.3%)"* on the
strength of it. That claim was **withdrawn**: the table has ten rows, so no per-identifier mapping existed, and
`§0.2` itself says a declared count that is not checked is not a fact (finding `RF-07`).

Coverage is now **computed** by [`tool/docs_check/prd004_traceability.py`](../../../tool/docs_check/prd004_traceability.py),
which classifies every identifier at one of two tiers:

- **DIRECT** — the defining line, or its section preamble, cites an external authority: a ranked document
  identifier (`MP-*`, `SID-*`, `LIB-*`, `AUTH-*`), a BC Map rule/edge/prohibition, a ruling (`AR-n`) or an ADR.
- **DERIVED** — it cites another identifier in this document that is itself traced. A requirement may legitimately
  refine another requirement, and an acceptance criterion legitimately verifies a requirement rather than a ranked
  document.

An internal citation chain that never reaches an external source does **not** count: a document cannot be its own
authority. `SM-GAP-*` are excluded from the denominator, because carrying no source is what makes a gap a gap.

| Measure | Value |
|---|---|
| Base identifiers located | **248** |
| Proposed gaps (excluded from denominator) | **10** |
| Denominator — real requirements | **238** |
| Traced **DIRECT** | **211** |
| Traced **DERIVED** | **10** |
| **Untraced** | **17** |
| **Coverage** | **221 / 238 = 92.9%** |

**The 17 untraced identifiers are named, not hidden:** `SM-2.8`, `SM-3.12`, `SM-3.13`, `SM-3.14`, `SM-3.16`,
`SM-3.17`, `SM-4.1`, `SM-6.1`, `SM-6.3`, `SM-6.5`, `SM-6.6`, `SM-6.8`, `SM-8.11`, `SM-8.15`, `SM-10.1`,
`SM-10.7`, `SM-10.8`.

These are **not** proposed gaps. Each is a design decision this module is entitled to make within its own
aggregate — how it de-duplicates, what its concurrency strategy is, what its table is called — and no ranked
document legislates them. They are listed so that the 92.9% is falsifiable: re-run the script and it prints the
same seventeen. Whether any deserves an external citation is a review question, not a defect this document can
close by asserting a higher number.

> **On the direction of the change.** The withdrawn figure was 96.3%; the computed figure is 92.9%, which is
> **lower**. The correction pass did not tune the metric upward — it replaced an unverifiable claim with a
> reproducible one and accepted the worse result.

### 10.6 PROPOSED GAPS — `SM-GAP-1` … `SM-GAP-10`

> **These are not requirements.** Each is a decision the repository does not currently make. They are recorded so
> that nobody implements an invented answer, and **must not** be converted to requirements without a source.

| ID | Gap | Why it is a gap, not a requirement |
|---|---|---|
| `SM-GAP-1` | Retention period for student financial/attendance history | `ID-5` mandates retention "under legal basis" but names no duration. Inventing "7 years" would be fabricating a legal position |
| `SM-GAP-2` | `enrollmentNumber` format and whether it is human-meaningful | `SM-INV-1` requires uniqueness only. `SMCFG-5`'s default is a placeholder pending a decision |
| `SM-GAP-3` | Whether `Inactive` blocks seat allocation | `MP-GBR-16` covers membership validity and `SM-2.14` covers `Suspended`. `Inactive` is unspecified |
| `SM-GAP-4` | `TR-5` Parent access to the Directory and to member detail | Parent Portal is Master PRD module 5, a composition with **no PRD**. Its authorisation model is undefined. **Still open.** `SM-8.4a` records an interim **deny** so that §8.2 remains an executable closed list; the interim value is a safe default under `AP-3`, not an answer to the question |
| `SM-GAP-5` | Member tags and free-text member notes | Requested in the original brief; **no authoritative source anywhere in the repository**. Not specified |
| `SM-GAP-6` | Emergency contact as a field distinct from guardian contact | `SID-2.8` names "parent/guardian contact" only |
| `SM-GAP-7` | Directory visibility of members to other members | `LCFG-5` says the directory "exposes members to members" but no requirement defines the member-facing field set |
| `SM-GAP-8` | Bulk import / `registrationSource = Import` validation rules | `SM-3.8` names the source; no import specification exists |
| `SM-GAP-9` | Attendance-percentage definition used by the Directory indicator | Owned by `BC-03`; `PRD-006` is unwritten, so the formula has no owner yet |
| `SM-GAP-10` | Whether Date of Birth should become **mandatory** at `BC-10` | `PRD-003` lists it as **Optional** (§2.4, `SID-2.5`) while `SID-5.9` says it *"**SHALL** be stored, because minor-safety obligations (`ID-6`) depend on it."* That tension is internal to `PRD-003` and is **not** this module's to resolve. `SM-4.5a`/`SM-4.5b` make this module safe either way. Resolving it requires the `BC-10` owner and an ADR (finding `RF-17`) |

> **`SM-GAP-5` deserves naming explicitly.** Member tags and notes were requested twice. They appear nowhere in
> the Master PRD, BC Map, Library PRD, Student Identity PRD or any ADR. Writing them as requirements would have
> been the easiest way to appear thorough and the clearest violation of *"do not invent requirements."*

### 10.7 Implementation tasks — `IMPL-300` … `IMPL-323`

Recorded for the backlog. **Nothing here is implemented by this document.**

> **Six tasks were added by the 2026-08-04 correction pass** (finding `RF-09`). A set-difference of the
> `Requirements` column against the register found 40 identifiers in no task at all — including `LMD-25`–`LMD-29`,
> which fell into the gap between `IMPL-312` (`LMD-1`–`LMD-24`) and `IMPL-317` (`LMD-30`, `LMD-31`). That is the
> signature of a hand-written range list that was never mechanically checked. `IMPL-318`–`IMPL-323` close the gap
> and cover the corrections themselves.

| Task | Scope | Module | Depends on | Requirements | Test requirement |
|---|---|---|---|---|---|
| `IMPL-300` | `StudentRecord` aggregate + value objects | `domain/library` | — | `SM-2.1`–`SM-2.4` | Unit: invariants |
| `IMPL-301` | `EnrollmentStatus` closed state machine | `domain/library` | `IMPL-300` | `SM-2.5`–`SM-2.13` | Reject `Expired`, reject illegal transitions |
| `IMPL-302` | Schema + unique constraints + indexes | `platform/data` | `IMPL-300` | `SM-10.1`–`SM-10.6` | Schema scan: no credential, no `library_member` |
| `IMPL-303` | Tenant-key enforcement on all access | `platform/data` | `IMPL-302` | `SM-8.1`–`SM-8.3` | `X-13` checker category 12 |
| `IMPL-304` | `E-11` account resolution port | `domain/library` | `IMPL-300` | `SM-3.1` | Contract test |
| `IMPL-305` | `E-13` identity ACL | `domain/library` | `IMPL-300`, `IMPL-214` | `SM-3.3`, `SM-7.3`, `SM-7.4` | ACL test: no reverse reference |
| `IMPL-306` | Registration use case + idempotency | `domain/library` | `IMPL-301`–`305` | `SM-3.4`–`SM-3.10` | Idempotency, atomic rollback |
| `IMPL-307` | Duplicate prevention | `domain/library` | `IMPL-302`, `IMPL-306` | `SM-3.11`–`SM-3.17` | Concurrency: DB constraint decides |
| `IMPL-308` | Guardian + minor rules | `domain/library` | `IMPL-305` | `SM-4.4`–`SM-4.8` | Under-18 mandatory guardian |
| `IMPL-309` | Document `FileRef` via `E-22` | `domain/library` | `IMPL-300` | `SM-4.9`–`SM-4.12` | No bytes/path stored |
| `IMPL-310` | Status/archive/restore use cases | `domain/library` | `IMPL-301` | `SM-2.8`–`SM-2.16`, `SM-6.1` | Dues-block on archive |
| `IMPL-311` | `SM-EV-1`…`9` publication | `domain/library` | `IMPL-301` | `SM-7.12`–`SM-7.17` | No `StudentRecordId` in global event |
| `IMPL-312` | **Directory read composition (application layer)** | `app` | `IMPL-306`, `IMPL-310` | `LMD-1`–`LMD-24`, `LMD-24a`, `LMD-24b`, `LMD-15a`, `LMD-15b` | No domain-layer composition; no member table; foreign filters labelled best-effort |
| `IMPL-313` | **`LCFG-5` gating via `E-19`** | `app` | `IMPL-312` | `LMD-4`–`LMD-7` | Disabled ⇒ suppressed, data intact |
| `IMPL-314` | Directory search via `BC-23` (`E-21`) | `app` | `IMPL-311` | `LMD-12`–`LMD-14` | No domain-table search query |
| `IMPL-315` | `SM-PO-*` authorisation via `BC-18` | `app` | `IMPL-310` | `SM-8.5`–`SM-8.9` | Per-operation matrix test |
| `IMPL-316` | Audit to `BC-24` incl. read auditing | `platform/audit` | `IMPL-310` | `SM-8.10`–`SM-8.14` | Append-only (`X-10`) |
| `IMPL-317` | Bulk operations + export caps | `app` | `IMPL-312`, `IMPL-315` | `LMD-30`, `LMD-31`, `SM-10.7` | Partial failure reported as partial |
| `IMPL-318` | **Status · expiry · archived-filter indicators** | `app` | `IMPL-312` | `LMD-25`–`LMD-29` | Two independent badges (`SM-AC-19`); archived hidden by default |
| `IMPL-319` | **Field-level authz, history & operations surface** | `app` | `IMPL-306` | `SM-6.1`–`SM-6.8` | Unauthorised field edit refused; history read from `BC-24` |
| `IMPL-320` | **`SM-EV-10` consent-gated person link** | `domain/library` | `IMPL-305`, `IMPL-311` | `SM-EV-10`, `SM-7.12a`, `SM-7.12b`, `SM-10.12` | Not emitted absent consent; carries no `StudentRecordId` |
| `IMPL-321` | **Producer-side transactional outbox** | `platform/event` | `IMPL-302`, `IMPL-311` | `SM-7.7a`, `SM-7.7b` | Commit-without-publish impossible; tenant-partitioned |
| `IMPL-322` | **Absent-DOB minor-status path** | `domain/library` | `IMPL-308` | `SM-4.5a`–`SM-4.5c`, `SM-INV-3` | `SM-AC-29` passes; fail-safe to minor |
| `IMPL-323` | **Deterministic restore among archived records** | `domain/library` | `IMPL-307` | `SM-3.14a`, `SM-3.14b` | `SM-AC-30` passes |

**18 tasks.** `IMPL-305` depends on `IMPL-214` (the `E-13` ACL task already registered against `PRD-004` in
`PRD_REGISTRY.md` line 224).

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created as `DRAFT` under Lifecycle Stage 2. Specifies `BC-01` Enrollment and, per `PRD_REGISTRY.md` §6, **Master PRD §8 module 3 Library Member Directory as a read-composition chapter (§5)** rather than a separate PRD or bounded context. 242 identifiers declared across 10 registers, zero prefix collisions. **No frozen document modified; no integration edge added; no bounded context created.** Three corrections to the requested scope are recorded rather than silently applied: `EnrollmentStatus` excludes `Expired`, `Prospective` and `Registered` (BC Map line 209 declares a closed 4-value set); no `LibraryMember` aggregate is created (`AR-1`); and 9 requested items are marked **PROPOSED GAP** rather than invented. |
