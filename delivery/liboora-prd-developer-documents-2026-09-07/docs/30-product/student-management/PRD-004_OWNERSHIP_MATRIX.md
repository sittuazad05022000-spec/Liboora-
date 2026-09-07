# `PRD-004` Ownership Matrix — who owns each field the Directory displays

| Field | Value |
|---|---|
| **Document** | Ownership Matrix for [`Student_Management_PRD_v1.md`](Student_Management_PRD_v1.md) (`PRD-004`) |
| **Version** | v1.0 |
| **Status** | Supporting record. **Not ranked**, therefore editable without an ADR |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04-B` |
| **Purpose** | Phase 20 deliverable 3. Makes the read-composition claim **checkable** rather than asserted, by naming the owning context of every datum the Directory renders |
| **Precedence** | Below `MASTER_PRD.md` (Rank 1), the BC Map (Rank 4) and `SID-2.8` (Rank 3). Where this matrix disagrees with them, **they are right and this matrix is a defect** |
| **Derived from** | BC Map line 209, line 292, line 370, §4.1 `ID-1`…`ID-6` · `SID-2.8` normative ownership table · `AR-1` · `PRD-004` §5.4 |

---

## 1. Why a matrix, and not a paragraph

`PRD-004` §5 claims the Library Members Directory *"owns no aggregate and no independent invariant."* That claim
is only worth anything if it can be **falsified**. A single field with no named owner elsewhere would disprove it.

This matrix therefore lists every field the Directory displays and names the context that authors it. The test is
mechanical: **if a row's owner is `BC-01` and the field is not part of `StudentRecord`, or if a row has no owner
at all, the read-composition claim is broken.**

Per `SID-4.56`: *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."* A prose
assurance that the Directory is read-only is exactly such an uncheckable rule. This table is the check.

---

## 2. Aggregate ownership — the short answer

| Aggregate | Owning context | Owning PRD | Authority |
|---|---|---|---|
| `StudentRecord` (+ `ContactDetails`, `GuardianLink`, `DocumentRef`, `EnrollmentStatus`) | **`BC-01` Enrollment** | **`PRD-004`** | BC Map line 370 |
| `Account` | `BC-18` Identity & Access | `PRD-001` | `ADR-0011` |
| `Person` | `BC-10` Global Person Identity | `PRD-003` | `ADR-0011` |
| `Membership` | `BC-02` Membership | `PRD-005` (`PLANNED`) | BC Map |
| `Attendance` | `BC-03` Attendance | `PRD-006` (`PLANNED`) | BC Map |
| `Seat` / `SeatAllocation` | `BC-04` Seating | `PRD-007` (`PLANNED`) | BC Map |
| `Fee` / `Invoice` / `Payment` | `BC-05` Fee & Collection | `PRD-008` (`PLANNED`) | BC Map |
| **`LibraryMember`** | **does not exist** | — | `SM-1.7`, `AR-1`, BC Map `R1` |

> **The last row is the point of this document.** The requested `LibraryMember` aggregate is absent by decision,
> not by omission. *"The member record **IS** the `StudentRecord`; 'member' is a directory view of it, not a
> second entity."* (`SM-1.7`)

---

## 3. Field-level ownership — every column the Directory can render

**Legend.** **Owner** = the context that authors the value. **Directory right** = what chapter 5 may do.
`READ` = display a projection. **`NONE`** = the Directory may not surface it at all.

### 3.1 Identity columns

| Field | Owner | Source edge | Directory right | Enforcing requirement |
|---|---|---|---|---|
| `studentRecordId` | **`BC-01`** | — (own aggregate) | `READ` | `SM-1.3`, `ID-4` |
| `enrollmentNumber` | **`BC-01`** | — | `READ` | `SM-INV-1` |
| `personId` | `BC-10` | `E-13` **ACL** | **`NONE`** — held, never displayed or exported | `SM-1.2`, `SM-AC-28`, `ID-4` |
| `accountId` | `BC-18` | `E-11` | **`NONE`** | `SM-1.2` |
| Display name | `BC-10` (global) / `BC-01` (organisation profile) | `E-13` | `READ` | `SID-2.8` |
| Library Identification Photo | **`BC-01`** (ref), bytes in `BC-29` | `E-22` `FileRef` | `READ` via `FileRef` | `SID-2.8`, `SM-AC-27` |

> **Why `personId` is `NONE` rather than `READ`.** `ID-4` requires library contexts to key **exclusively** on
> `StudentRecordId` while holding a non-nullable `PersonId`. Rendering or exporting `PersonId` would let one
> tenant correlate a human across libraries — the precise cross-tenant leak `SM-AC-28` tests for.

### 3.2 Enrollment columns — the only columns `BC-01` authors

| Field | Owner | Directory right | Enforcing requirement |
|---|---|---|---|
| `enrollmentStatus` (`Active` \| `Inactive` \| `Suspended` \| `Archived`) | **`BC-01`** | `READ` | `SM-2.5`, BC Map line 209 |
| Enrollment date | **`BC-01`** | `READ` | `SM-3.*` |
| Guardian link | **`BC-01`** | `READ`, permission-gated | `SM-INV-4` (mandatory if age < 18) |
| Contact channel | **`BC-01`** | `READ`, permission-gated | `SM-INV-3` (≥ 1 contactable channel) |
| Document refs | **`BC-01`** (refs), `BC-29` (bytes) | `READ` as `FileRef` | `SM-AC-27` |

### 3.3 Projected columns — owned elsewhere, displayed read-only

**Every row here is a field the brief wanted the Directory to "own". None is owned by it.**

| Field | Owner | Source | Directory right | Enforcing requirement |
|---|---|---|---|---|
| Membership plan name | `BC-02` | `E-01` event projection | `READ` | `LMD-16`, §5.4 |
| `membershipStatus` (`Valid` \| `Expired` \| `Frozen`) | `BC-02` | `E-01` | `READ` | `LMD-16`, `SM-2.7` |
| Membership expiry date | `BC-02` | `E-01` | `READ` | `LMD-26` |
| Expiry / near-expiry indicator | `BC-02` (**derived**, not stored) | `E-01` | `READ` — computed at display | `LMD-26`, `LMD-2` |
| Seat number / allocation | `BC-04` | projection | `READ` | §5.4 |
| Last attendance / present-today | `BC-03` | projection | `READ` | §5.4 |
| Outstanding dues / fee status | `BC-05` | `E-09` | `READ` | §5.4, `SM-INV-*` archive pre-condition |
| Search relevance ordering | `BC-23` | `E-21` | `READ` | `L2` (event, not call) |

> **`SM-2.7` is what this section protects.** BC Map line 209 documents that *"a student can be Active with an
> Expired membership."* Two columns in this matrix carry those two independent states, each from its own owner.
> Had `Expired` been added to `EnrollmentStatus` as the brief proposed, these two rows would have collapsed into
> one and that documented case would have become unrepresentable.

### 3.4 Fields with **no owner** — `PROPOSED GAP`, therefore not displayable

| Requested field | Gap ID | Directory right today |
|---|---|---|
| Member tags | `SM-GAP-5` | **`NONE`** — no authoritative source anywhere in the repository |
| Member free-text notes | `SM-GAP-5` | **`NONE`** — same |
| Member-facing field set (members seeing members) | `SM-GAP-7` | **`NONE`** — `LCFG-5` says the directory *"exposes members to members"*, but no requirement defines **which** fields a `TR-4` Student may see |
| Emergency contact, distinct from guardian contact | `SM-GAP-6` | **`NONE`** — `SID-2.8` names *"parent/guardian contact"* only |
| Attendance-percentage indicator | `SM-GAP-9` | **`NONE`** — the formula is owned by `BC-03`, and `PRD-006` is unwritten |

> **Gap IDs and wording are quoted from `PRD-004` §10.6, which is authoritative.** An earlier draft of this table
> attributed *"directory export"* to `SM-GAP-7`; the PRD assigns `SM-GAP-7` to the member-facing field set. The
> mismatch was found by diffing against the PRD, and this table was corrected to follow it.

**A field with no owner is not implemented.** These three were requested; inventing an owner for them would have
created exactly the unauthorised state `AR-1` forbids.

---

## 4. Ownership invariants — the falsifiable form

| ID | Invariant | How to falsify it |
|---|---|---|
| `OWN-1` | Every field in §3 has exactly one owning context | Find a row with two owners, or none (excluding §3.4) |
| `OWN-2` | Only §3.1–§3.2 rows are owned by `BC-01`, and each belongs to `StudentRecord` | Find a `BC-01` row that is not part of the line-370 aggregate |
| `OWN-3` | Every §3.3 row is `READ` | Find a projected field the Directory writes |
| `OWN-4` | No row creates a persisted member entity | Find a `library_member` / `member_directory` table (`SM-10.6`) |
| `OWN-5` | No row adds an integration edge | Find a source edge outside `E-01`, `E-09`, `E-11`, `E-13`, `E-21`, `E-22` (BC Map line 292) |
| `OWN-6` | `personId` never leaves the module | Find it in a response body, export or global index (`SM-AC-28`) |

**Result at v1.0: `OWN-1`…`OWN-6` all hold.** These are documentation-level checks; `OWN-4` and `OWN-6` become
*executable* at `IMPL-302` (schema scan) and `IMPL-316`, which is why both tasks carry a scan in their definition
of done rather than a review.

---

## 5. Role × operation ownership

Roles are the closed set `TR-1` Owner · `TR-2` Manager · `TR-3` Reception · `TR-4` Student · `TR-5` Parent
(`LIB-4.1`). *"It MUST NOT introduce a role name of its own."* **`PRD-004` introduces none.**

| Concern | Owner | Note |
|---|---|---|
| Role definitions | `BC-18` / Library PRD `LIB-4.1` | `PRD-004` **consumes**, never extends |
| Permission evaluation | `BC-18` | 12 `SM-PO-*` operations × 5 roles, §8.2 |
| Directory visibility toggle | `BC-25` Configuration → `PRD-023` | **`LCFG-5`**, default **Disabled**, `AP-3` deny-by-default |
| Audit of directory reads | `BC-24` Audit Trail | `SM-AC-24` — sensitive reads audited **even with no state change** |
| Platform Administrator access | — | **No tenant data by role** (`LIB-4.2`) |
| `TR-5` Parent directory access | **unowned** | **`SM-GAP-4`** — Parent Portal is a composition with no PRD |

---

## 6. What this matrix does **not** claim

| Not claimed | Actual state |
|---|---|
| That the owning PRDs exist | `PRD-005`…`PRD-008` are **`PLANNED`**. The *contexts* own these fields; the specifications are unwritten |
| That projections are implemented | Zero code. Ownership is specified, not built |
| That `OWN-4`/`OWN-6` are machine-checked today | They are **documentation checks** until `IMPL-302` / `IMPL-316` |
| That `SM-GAP-*` fields are refused forever | They are **undecided**. A source, then a requirement — in that order |

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created as Phase 20 deliverable 3. Names the owning context of every field the Directory can render, in four classes: `BC-01`-owned identity/enrollment columns, projected read-only columns from `BC-02`/`BC-03`/`BC-04`/`BC-05`/`BC-23`, fields deliberately **`NONE`** (`personId`, `accountId`), and five requested fields with **no owner** recorded as `SM-GAP-5`/`SM-GAP-6`/`SM-GAP-7`/`SM-GAP-9` (wording quoted from `PRD-004` §10.6 after a first draft mis-attributed `SM-GAP-7`). Records that **`LibraryMember` does not exist** as an aggregate. States six falsifiable ownership invariants `OWN-1`…`OWN-6`, all holding at v1.0, and identifies which become executable at `IMPL-302`/`IMPL-316` rather than claiming they are enforced now. **No frozen document modified; no new role, edge or aggregate introduced.** |
