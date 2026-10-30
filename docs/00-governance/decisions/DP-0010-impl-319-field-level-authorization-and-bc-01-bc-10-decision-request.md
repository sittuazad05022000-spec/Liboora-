# DP-0010 — IMPL-319: field-level authorization, history, and operations surface (BC-01 + BC-10)

| Field | Value |
|---|---|
| **Type** | Decision request |
| **Status** | OPEN · 0 responses received |
| **Supersedes** | none |
| **Authorizes** | none |
| **Sponsor / Owner** | Product Owner (DR-0, DR-1) |
| **Convenor** | Architecture Owner |
| **Parties affected** | Library Domain (BC-01), Person Domain (BC-10) |
| **Recorded** | 2026-10-30 (read-only review, HEAD `dc555f63f89dfd13656662ca48b44924bc9b0d45`) |
| **Next review** | 2026-11-13, or on receipt of the first of DR-0/DR-1/DR-2 |
| **Links** | PRD-004 frozen; `DD-0002-student-management-surface-design.md`; IMPL-319 (read-only review only); `lib/platform/audit/audit.dart` (BC-24 app-layer read port, Classification A) |

---

## Summary

IMPL-319 ("field-level authorization, history, and operations surface") is scoped as a **read-only governance review**: this record surfaces governance questions raised during the review of the PRD-004 frozen surface (`docs/30-product/student-management/Student_Management_PRD_v1.md`) and its implementation tasks (`docs/30-product/student-management/PRD-004_IMPLEMENTATION_TASKS.md`), without resolving them. No implementation commits were made and none are proposed by this record.

Five issues were identified and classified B / C / D:

| # | Issue | Classification | Resolver |
|---|---|---|---|
| 1 | `IMPL-319 Depends on: IMPL-306` omits the SM-6.1 / BC-18 chain (`IMPL-315 → IMPL-310 → IMPL-301`) | **B** — task table is a backlog record, editable without an ADR | Product Owner |
| 2 | `SM-6.2` field-level authorization + TR-4 "own subset" have zero governing definitions; permission catalogue is closed (ADR-0132) | **C** — genuine human decision | Product Owner |
| 3 | `SM-6.3` optimistic concurrency references `StudentRecord.version`, which does not exist | **D** — implementation dependency | Technical Owner |
| 4a | GAP-011/IDV-012: non-nullable DOB vs SM-4.5a `Unknown` minor path | **C** — REQUIREMENT CONFLICT | Architecture Owner + Domain Owner |
| 4b | GAP-012/IDV-013: `StudentRecord` stores BC-10 fields (BC-10-owned per SM-4.2) contradicting SM-4.2 "MUST NOT store" and SM-4.5 derivation rule | **C** — REQUIREMENT CONFLICT | Architecture Owner + Domain Owner |
| 5 | BC-24 wiring (IMPL-316) — app-layer read port `AuditTrail.forTenant()` is already A-classified | **A/D** — can proceed | Technical Owner |

**Verdict: WAITING FOR DECISIONS** (DR-0, DR-1, DR-2).

---

## Issue 1 — task-table dependency under-specification (B)

`PRD-004_IMPLEMENTATION_TASKS.md` §10.7 (L134) declares `IMPL-319 Depends on: IMPL-306`. Line 7 of that task doc states: *"Backlog record. Not ranked, therefore editable without an ADR."*

The under-specification: SM-6.1 includes archive/restore, which are in the closed SM-PO-* list governed by SM-8.5; IMPL-315 owns BC-18 authorization for SM-PO-* operations (L100–101: `Depends on: IMPL-310, SM-8.5–SM-8.9`). The full chain is:

```
IMPL-306 → IMPL-315 → IMPL-319
            ↳ IMPL-310 → IMPL-301
```

## Issue 2 — field-level authorization definitions absent (C)

- `SM-6.2` (L676–677): *"Update MUST be field-level authorized. A caller authorized to view MUST NOT implicitly be authorized to edit (LMD-29)."*
- TR-4 row in §8.2 (L870) references "own subset."
- Zero governing definitions exist for either: `ADR-0132` measured zero `PERM-*` identifiers repository-wide; derived capability is the lawful mechanism across 253 identifiers; the `Permission` enum (9 values, runtime construct, `lib/platform/identity/identity.dart:185–195`) is not a catalogue entry; `ADR-0043` §5.1 (L175–177) forbids inventing a new permission ID.

SM-6.2's requirement-range inclusion in the trace is verified, but **verified ownership is absent** — this is a gap of definition, not of intent.

## Issue 3 — untraced optimistic-concurrency target (D)

`SM-6.3` (L679–680) names `StudentRecord.version`; `lib/domain/library/enrollment/domain/student_record.dart:30–141` has no `version` field. One of the 13 untraced PRD identifiers (`SM-6.3`). Fix requires a Technical Owner assignment only.

## Issue 4a — GAP-011 / IDV-012: `Unknown` minor status (C)

`StudentRecord.dateOfBirth` is non-nullable, but `SM-4.5a` (L444–448) requires an `Unknown` minor-status path when BC-10 DOB is absent:

> `SM-4.5a.` If the minor's date of birth (DO-B) is not yet known at the time the student record is created, then the student record MUST record the status of the DO-B as `Unknown`. The date of birth MUST be captured from BC-10 when it becomes available.

`DD-0002-student-management-surface-design.md` (L1303) marks GAP-011 as REQUIREMENT CONFLICT, Architecture + Domain Owner.

## Issue 4b — GAP-012 / IDV-013: BC-10 field storage interaction (C)

`StudentRecord` stores `fullName` (L50), `phone` (L51), `email` (L52), `dateOfBirth` (L53) via `EnrollStudent` (L347–398). SM-4.2 (L413–414) lists `fullName`, `dateOfBirth`, `email` as BC-10-owned fields the surface **MUST NOT store**, and SM-4.5 (L428) derives age from BC-10 DOB (event E-13), never stored. The interaction of SM-4.2 / SM-4.5 / SM-6.4 is unclear; SM-6.4 does not inherently require local storage. `DD-0002-student-management-surface-design.md` (L1304) marks GAP-012 as REQUIREMENT CONFLICT, Architecture + Domain Owner, and L1313 states these must be resolved before BC-01 surfaces are built.

Note: `phone` is stored but is **not** on SM-4.2's BC-10-owned list — phone storage is a neutral implementation fact, not a conflict.

## Issue 5 — BC-24 wiring (A / D)

`AuditTrail.forTenant()` (L57) is an already-governed app-layer read port (Classification A); BC-24 wiring gaps under IMPL-316 are a separate implementation dependency.

---

## Decision requests

### DR-0 (Product Owner)

Confirm whether `IMPL-319`'s declared `Depends on: IMPL-306` suffices, or whether `IMPL-315` (functional prerequisite for SM-6.1 / BC-18 authorization) is a missing dependency — i.e., should the task table read `IMPL-319 Depends on: IMPL-306, IMPL-315`? The task doc is editable without an ADR per its own header.

### DR-1 (Product Owner)

Clarify:
1. the meaning of TR-4 "own subset" in SM-PO-4 (§8.2, L870); and
2. what `SM-6.2` field-level authorization requires, expressible via existing role/action/scope as derived capability — **no new permission ID**.

OPEN process question: whether clarifying a matrix within an existing operation requires an ADR. SM-8.5 governs protected operations, not matrices — unresolved. Route to Architecture Owner for ADR guidance if the Product Owner is uncertain.

### DR-2 (Architecture Owner + Domain Owner)

Resolve two REQUIREMENT CONFLICTs (GAP-011/IDV-012 and GAP-012/IDV-013), per `DD-0002-student-management-surface-design.md` L480–484.

Additionally, this record poses an OPEN authority-identification question: DD-0002 names "Architecture + Domain Owner" but does not specify whether Library Domain (BC-01) or Person Domain (BC-10) joins, or whether both; the deciding act must resolve this.

---

## What can proceed now (A-class)

- `StudentRecord.version` addition (Issue 3) — Technical Owner assignment only.
- BC-24 app-layer read-port scaffolding (`AuditTrail.forTenant()`, L57).
- IMPL-310 domain work (archive/restore), IMPL-316 scope, operation-level SM-PO-* BC-18 wiring (IMPL-315).
- `SM-6.5` / `SM-6.6` / `SM-6.8` surface scaffolding (already A-classified).

## What remains blocked (C)

- IMPL-319 full implementation — blocked by DR-0, DR-1, and DR-2 (Conflict A + Conflict B).
- `UpdateStudentProfile` domain use case and SM-6.4 implementation — blocked by DR-2.

## Decision history

| Date | Change |
|---|---|
| 2026-10-30 | Opened: read-only review of IMPL-319 surfaces; 5 issues classified B/C/D; verdict WAITING FOR DECISIONS |
