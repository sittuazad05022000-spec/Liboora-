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
| **Prepared** | 2026-10-30 (read-only review, HEAD `dc555f63f89dfd13656662ca48b44924bc9b0d45`) |
| **Next review** | 2026-11-13, or on receipt of the first of DR-0/DR-1/DR-2 |
| **Links** | PRD-004 frozen; `DD-0002-student-management-surface-design.md`; IMPL-319 (read-only review only) |

---

## Summary

IMPL-319 ("field-level authorization, history, and operations surface") is scoped as a **read-only governance review**: this record surfaces governance questions raised during the review of the PRD-004 frozen surface (`docs/30-product/student-management/Student_Management_PRD_v1.md`) and its implementation tasks (`docs/30-product/student-management/PRD-004_IMPLEMENTATION_TASKS.md`), without resolving them. No implementation commits were made and none are proposed by this record.

Four decision matters were identified:

| # | Matter | Classification | Decision matter |
|---|---|---|---|
| 1 | Whether `IMPL-315 → IMPL-310 → IMPL-301` is a functional prerequisite for `IMPL-319`, beyond the declared `IMPL-306` dependency | **B** — task table is a backlog record, editable without an ADR | **DR-0** (Product Owner) |
| 2 | `SM-6.2` field-level authorization + TR-4 "own subset" have no governing definition identified in the reviewed sources; permission catalogue is closed (ADR-0132) | **C** — genuine human decision | **DR-1** (Product Owner) |
| 3 | GAP-011/IDV-012: non-nullable DOB vs SM-4.5a `Unknown` minor path | **C** — REQUIREMENT CONFLICT | **DR-2 Conflict A** (Architecture Owner + Domain Owner) |
| 4 | GAP-012/IDV-013: `StudentRecord` stores BC-10 fields (BC-10-owned per SM-4.2) contradicting SM-4.2 "MUST NOT store" and SM-4.5 derivation rule | **C** — REQUIREMENT CONFLICT | **DR-2 Conflict B** (Architecture Owner + Domain Owner) |

**Verdict: WAITING FOR DECISIONS** (DR-0, DR-1, DR-2).

---

## DR-0 — IMPL-319 dependency question (Product Owner)

`PRD-004_IMPLEMENTATION_TASKS.md` §10.7 (L134) declares `IMPL-319 Depends on: IMPL-306`. Line 7 of that task doc states: *"Backlog record. Not ranked, therefore editable without an ADR."*

`IMPL-319` is declared `app`-layer, with requirements `SM-6.1`–`SM-6.8`. `SM-6.1` (L673–674) lists archive and restore among the operations this module must provide. The operation matrix (`SM-8.5`, L892) governs the closed `SM-PO-*` list. `IMPL-315` owns BC-18 authorization for `SM-PO-*` operations (`Depends on: IMPL-310, SM-8.5–SM-8.9`, L100–101). Whether `IMPL-315 → IMPL-310 → IMPL-301` is a functional prerequisite for `IMPL-319` remains an open Product Owner decision.

Independently verified relationships:

```
IMPL-319 → IMPL-306
IMPL-315 → IMPL-310 → IMPL-301
```

**No authoritative evidence in this review establishes a dependency between IMPL-315 and IMPL-319.** Should the task table be amended to `IMPL-319 Depends on: IMPL-306, IMPL-315`? That is the decision requested.

---

## DR-1 — SM-6.2 field-level authorization and TR-4 "own subset" (Product Owner)

- `SM-6.2` (L676–677): *"Update MUST be field-level authorized. A caller authorized to view MUST NOT implicitly be authorized to edit (LMD-29)."*
- TR-4 "own subset" appears in the SM-PO-4 row of the operation matrix in §8.2 (L870).
- No governing definition was identified in the reviewed sources. This is a scoped search finding, not a repository-wide absence claim. `ADR-0132` reported zero `PERM-*` identifiers repository-wide; derived capability is the lawful mechanism across 253 identifiers; the `Permission` enum (9 values, runtime construct, `lib/platform/identity/identity.dart:185–195`) is not a catalogue entry; `ADR-0043` §5.1 forbids inventing a new permission ID.

Clarify:
1. the meaning of TR-4 "own subset" in SM-PO-4 (§8.2, L870); and
2. what `SM-6.2` field-level authorization requires, expressible via existing role/action/scope as derived capability — **no new permission ID**.

OPEN process question: whether clarifying a matrix within an existing operation requires an ADR. SM-8.5 governs protected operations, not matrices — unresolved. Route to Architecture Owner for ADR guidance if the Product Owner is uncertain.

**Search limitation (scoped, not repository-wide):** the permission catalogue was checked by inspecting `ADR-0132`, `ADR-0043`, and the `Permission` enum; the repository-wide `PERM-*` count cited is the measured value **reported by ADR-0132 itself**, not a fresh independent measurement. A later review that independently re-runs the grep must re-state the count.

---

## DR-2 Conflict A — GAP-011 / IDV-012: `Unknown` minor status (Architecture Owner + Domain Owner)

`StudentRecord.dateOfBirth` is declared `required final` (L53), but `SM-4.5a` (L444–448) requires an `Unknown` minor-status path when BC-10 DOB is absent:

> `SM-4.5a` — Where the `BC-10` Date of Birth is **absent**, this module **MUST NOT** infer, default or assume an age, and **MUST NOT** treat `SM-INV-3` as satisfied. It **MUST** instead record the enrollment's minor-status as **`Unknown`** and **MUST** require a staff-recorded **age declaration** — a `TR-1`/`TR-2`/`TR-3` attestation of whether the student is a minor — before the record may leave `Pending`. The declaration **MUST** be audited with actor and timestamp (`SM-8.13`).

`SM-4.5` (L428–429) additionally requires age to be derived from BC-10 via E-13, never stored. `DD-0002-student-management-surface-design.md` (L1303, L472–473) marks GAP-011/IDV-012 as REQUIREMENT CONFLICT, Architecture + Domain Owner.

**The deciding act must choose between the domain model as shipped and the frozen Rank-3 PRD, without pre-selecting any resolution.** Note that making local DOB nullable would itself implicate SM-4.2 (a BC-10 field stored here), so the reconciled contract is undecided.

---

## DR-2 Conflict B — GAP-012 / IDV-013: BC-10 field storage interaction (Architecture Owner + Domain Owner)

`StudentRecord` stores `fullName` (L50, mutable), `phone` (L51, mutable), `email` (L52, optional), `dateOfBirth` (L53, final) via `EnrollStudent` (L347–398).

**BC-10-owned fields (SM-4.2, L413–414):** *"This module **MUST NOT** store Full Name, Username, Global Profile Photo, Bio, Gender, Date of Birth, Address, Email or Occupation. Those are owned by `BC-10` (`SID-2.8`) and read through `E-13`."* — i.e. **`fullName`, `dateOfBirth`, `email`** (plus Username, Global Profile Photo, Bio, Gender, Address, Occupation) are BC-10-owned and **MUST NOT** be stored here.

**`phone` is NOT a proven BC-10-owned field.** It appears in `StudentRecord` and `EnrollStudent`, but it is **absent** from SM-4.2's BC-10-owned list. Phone storage is therefore an implementation-storage fact only, not a proven conflict — the record's `_assertInvariants()` (L105–109) even treats it as a fallback contact channel alongside `email` ("At least one contact channel (phone or email) is required"). No conclusion is drawn about whether phone should be stored.

**SM-6.4** (L682–683): *"An update to a `BC-10`-owned field **MUST** be rejected with a pointer to `BC-10`, not silently ignored (`SM-4.2`)."* — this specifies the required **rejection behaviour** for a BC-10 field update attempt; it does not, by itself, settle whether the field should also be removed from local storage.

**No assumption is made that BC-01 must store BC-10 fields, and no implementation solution is prescribed.** The deciding act must clarify how SM-4.2, SM-4.5, and SM-6.4 interrelate: specifically whether the surface is expected to **store**, **derive and discard**, or **refuse storage** of BC-10 fields, and how a rejected update should be surfaced.

`DD-0002-student-management-surface-design.md` (L1304, L473) marks GAP-012/IDV-013 as REQUIREMENT CONFLICT, Architecture + Domain Owner, and L1313 states these must be resolved before BC-01 surfaces are built.

**OPEN authority-identification question:** DD-0002 names "Architecture + Domain Owner" but does not specify whether Library Domain (BC-01) or Person Domain (BC-10) joins, or whether both; the deciding act must resolve this.

---

## Decision history

| Date | Change |
|---|---|
| 2026-10-30 | Opened: read-only review of IMPL-319 surfaces; four decision matters recorded as DR-0 (Product Owner), DR-1 (Product Owner), DR-2 Conflict A + Conflict B (Architecture Owner + Domain Owner); all OPEN; verdict WAITING FOR DECISIONS |
