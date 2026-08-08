# Student Management — Module Index

**Owning context:** `BC-01` Enrollment & Student Records, rank 8, tenant-scoped
**Specification:** `PRD-004` Student Management
**Status:** 🟡 **`DRAFT` v1.0 — Stage 2.** Not frozen, not baselined, not ranked
**Reviewed:** 2026-08-04 — independent review verdict **C**; **corrected** 2026-08-04 — decision **B, needs
another review before freeze**

> **This is a navigation index only. It carries no requirement and no authority.**
> Where this page and `PRD-004` disagree, `PRD-004` governs. Where `PRD-004` and a ranked
> document disagree, the ranked document governs (`DOCUMENTATION_BASELINE.md` §4).

---

## What this module is

`BC-01` owns the **Student Record** — one student's enrollment at one library. It is tenant-scoped:
a `StudentRecordId` never leaves the tenant that issued it (`MP-GBR-03`). A person who joins three
libraries has three Student Records and one identity.

```
Authentication Account          (AccountId,  BC-18, rank 4)
        │ 1 ──── 1   mandatory · atomic  (E-12)
        ▼
Global Person Identity          (PersonId,   BC-10, rank 7.5, [CORE])
        │ 1 ──── 0..*           read through the ACL only  (E-13)
        ▼
Student Record — this library   (StudentRecordId, BC-01, rank 8)   ← THIS MODULE
        │
        └──► Membership (BC-02) · Attendance (BC-03) · Seating (BC-04) · Fees (BC-05)
             consume it. It does not read them from its domain layer.
```

**Enrollment status and membership status are two independent state machines.** A student can be
`Active` with an `Expired` membership. `BC-01` owns `EnrollmentStatus`; `BC-02` owns
`MembershipStatus`; neither derives the other (BC Map §6, status row).

## The Library Members Directory lives here

Chapter 5 (`LMD-1`…`LMD-31`) specifies the Library Members Directory as a **read composition over
existing owned data**, following the precedent set by ruling `AR-1`:

- **No `LibraryMember` aggregate** and no `library_member` table.
- **No second membership state machine.** The Directory displays `BC-02`'s status; it never computes one.
- **No new bounded context.** No `BC-32` is assigned. The count remains **31** (23 in V1).
- **Disabled by default** — `LCFG-5` is deny-by-default because a meaningful share of users are minors.

The Directory is a *view*. Every field it shows is owned by some other context and read through a
declared edge. See `PRD-004_OWNERSHIP_MATRIX.md` for the field-by-field attribution.

## Documents

| Document | Purpose |
|---|---|
| [`Student_Management_PRD_v1.md`](./Student_Management_PRD_v1.md) | **The specification.** 10 chapters, **248** base identifiers + 15 sub-lettered clarifications, ten registers. `DRAFT`, corrected 2026-08-04 |
| [`PRD-004_INDEPENDENT_REVIEW_REPORT.md`](./PRD-004_INDEPENDENT_REVIEW_REPORT.md) | **Independent 6-persona review, 2026-08-04.** Verdict **C**; 21 findings (0 critical, 3 high, 11 medium, 2 low, 5 observation). Review record — not normative |
| [`PRD-004_CORRECTION_REPORT.md`](./PRD-004_CORRECTION_REPORT.md) | **Correction record, 2026-08-04.** All 3 HIGH findings resolved with **no ADR and no ranked-document change**; 15 accepted, 3 rejected with evidence. Traceability recomputed **96.3% → 92.9%**. Decision **`B` — needs another review**; **not frozen**. Review record — not normative |
| [`PRD-004_ALIGNMENT_REPORT.md`](./PRD-004_ALIGNMENT_REPORT.md) | Alignment record: 3 conflicts, 4 duplicates avoided, 9 proposed gaps |
| [`PRD-004_OWNERSHIP_MATRIX.md`](./PRD-004_OWNERSHIP_MATRIX.md) | Field-level ownership for every Directory column; `OWN-1`…`OWN-6` |
| [`PRD-004_TRACEABILITY.md`](./PRD-004_TRACEABILITY.md) | Register collision check. **v1.1** — §4 event register now matches PRD §7.4 (`RF-04`) and its coverage claim is withdrawn in favour of PRD §10.5.1 (`RF-07`). The PRD governs |
| [`PRD-004_IMPLEMENTATION_TASKS.md`](./PRD-004_IMPLEMENTATION_TASKS.md) | `IMPL-300`…`IMPL-317`, five waves. ⛔ **Nothing started.** ⚠ The PRD §10.7 now runs to `IMPL-323`; this file still stops at `IMPL-317` |

## Chapter map

| Chapter | Contents |
|---|---|
| §0 | How to read; the ten register declarations |
| 1 | Purpose, responsibilities owned and **not** owned, `SM-XC-1`…`SM-XC-14` exclusions |
| 2 | The Student Record model, identity relationships, enrollment lifecycle |
| 3 | Enrollment operations — create, update, suspend, archive, restore |
| 4 | Guardians, documents, contact channels |
| 5 | **The Library Members Directory** — `LMD-1`…`LMD-31`. Carries no `SM-c.n` requirement |
| 6 | Roles and permissions, drawn from the closed set `TR-1`…`TR-5` |
| 7 | Integration seams, `SM-EV-1`…`SM-EV-9` domain events |
| 8 | Protected operations `SM-PO-1`…`SM-PO-12`, the role matrix |
| 9 | Business rules `SM-BR-1`…`SM-BR-16`, 16 edge cases. Carries no `SM-c.n` requirement |
| 10 | Data model, API, config, acceptance criteria, traceability, gaps, tasks |

## Registers

| Register | Range | Meaning | Closed? |
|---|---|---|---|
| `SM-c.n` | Ch 1–10 | Requirements (107) | — |
| `SM-BR-*` | 1–16 | Business rules | — |
| `SM-XC-*` | 1–14 | Exclusions — out of scope by decision | — |
| `SM-INV-*` | 1–11 | Domain invariants | — |
| `SM-EV-*` | 1–10 | Domain events | **Yes** (`SM-7.12`) |
| `SM-PO-*` | 1–12 | Protected operations | **Yes** |
| `SM-AC-*` | 1–30 | Acceptance criteria | **Yes** |
| `SMCFG-*` | 1–7 | Configurable parameters | — |
| `LMD-*` | 1–31 | Library Members Directory | — |
| `SM-GAP-*` | 1–10 | **Proposed** gaps — not requirements | — |

**Total: 248 base identifiers**, plus **15 sub-lettered clarifications** added by the 2026-08-04 correction pass
(`PRD-004` §0.2) — **263** in total. This module introduces no new role name.

## Declared edges this module uses

`PRD-004` **adds no edge** to the Bounded Context Map. It uses only these existing ones:

| Edge | Direction | Purpose |
|---|---|---|
| `E-11` | `BC-18` → `BC-01` | Account provisioning |
| `E-13` | `BC-01` → `BC-10` | Identity read, **through the ACL** |
| `E-01` | `BC-01` → `BC-02` | Enrollment informs membership |
| `E-09` | `BC-01` → `BC-05` | `StudentArchived` → Fees asserts no dues, **else blocks** |
| `E-21` | `BC-01`, `BC-10` → `BC-23` | Search projection. Search never reads domain tables |
| `E-22` | `BC-01`, `BC-10`, `BC-14` → `BC-29` | Consent (`BC-10` added by `ADR-0016`) |

**If an edge is not in the Map's §7 table, it does not exist, and adding it requires an ADR**
(BC Map, line 292).

Finding `RF-01` concerned chapter 5 appearing to read `BC-02`/`BC-03`/`BC-04`/`BC-05` across edges that are not
declared. **Resolved 2026-08-04 without adding an edge:** the Directory is an **application-layer read
composition** under `AR-1`, which already composes `BC-02` Membership Plans and `BC-04` Seat Capacity with no
declared edge and no `BC-` identifier assigned. `SM-7.1` now binds the **domain layer** only; `SM-7.1a`,
`LMD-24a` and `LMD-24b` bound the permission. The context count remains **31**. See
[`PRD-004_CORRECTION_REPORT.md`](./PRD-004_CORRECTION_REPORT.md) §1.1.

## Current state, honestly

- **Nothing is implemented.** No `domain/enrollment` module, no `StudentRecordId` type, no rank 8 tier.
- **0 of 30** acceptance criteria have been executed. None can be — there is no code to execute them against.
- **0 of 24** implementation tasks started (`IMPL-300`…`IMPL-323`).
- **10 proposed gaps** remain open. They are *proposals*, not approved requirements.
- **Traceability is 221/238 = 92.9%**, computed by `tool/docs_check/prd004_traceability.py`. 17 requirements have
  no external source; all 17 are named in `PRD-004` §10.5.1 rather than hidden.
- **Upstream blockers:** `BLK-01`/`TASK-D10` (P0, boundary checker exits 1) and `IMPL-220`
  (`SID-INT-*` unenforced) both sit above this module.
- **May implementation begin? No.** The three high-severity findings are now resolved, but the specification is
  still `DRAFT` and the correction pass changed an architectural interpretation (`RF-01`) and the closed event set
  (`SM-EV-10`). Decision **B** requires a **second independent review before freeze**, and implementation may not
  begin against an unfrozen PRD.

## Related

| Link | Why |
|---|---|
| [`MASTER_PRD.md`](../MASTER_PRD.md) | Rank 1. `MP-GBR-02`, `MP-GBR-03`, `MP-GBR-16` bind this module |
| [`LIBOORA_BOUNDED_CONTEXT_MAP.md`](../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) | Rank 4. Edges, aggregate definition, the event naming convention |
| [`ARCHITECTURE_RULINGS.md`](../../10-architecture/ARCHITECTURE_RULINGS.md) | Rank 5. **`AR-1`** is the precedent chapter 5 relies on |
| [`student-identity/README.md`](../student-identity/README.md) | `BC-10`, the identity this module references |
| [`CONFIGURATION_GUIDE.md`](../../20-configuration/CONFIGURATION_GUIDE.md) | `LCFG-5` governs Directory exposure |
| [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) | Why this is Stage 2 and what Stage 3 requires |
