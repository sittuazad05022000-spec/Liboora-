# DEVELOPER_GUIDE — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md) (**FROZEN**) and the **`Accepted`** ADRs in [`../ADR/`](../ADR/).

---

## 1. What this module is

`BC-03` **Attendance** answers exactly three questions, and §19 assigns all three
to it by name:

| Question | Owner |
|---|---|
| *By what means was this attendance produced?* | **`BC-03`** — attendance method |
| *Was the device on the network / in the area?* | **`BC-03`** — environment verification |
| *What presence fact is now true?* | **`BC-03`** — the attendance record |

Everything else it needs, it **asks another context for**. Everything else it
produces, it **publishes as a fact** and lets the owner act.

## 2. What this module must never own

This list is not stylistic advice. Each line is a registered obligation, and
breaking one is a specification violation rather than a design disagreement.

| It must NOT own | Owner | Obligation |
|---|---|---|
| **Live seat occupancy** | `BC-04` Seating | §23, `E-08` — *"Seating is the occupancy owner, Attendance is the trigger"* |
| **Study Hours aggregation / analytics / metrics** | `BC-26` | `ATT-FR-146` |
| **Authentication** | `BC-18` | §19 |
| **Student identity** | `BC-01` (`StudentRecordId`) / `BC-10` (`PersonId`) | §19 |
| **Membership validity as a gate** | `BC-02` | `ATT-PO-001` — Attendance **records and flags, never blocks** |
| **Library opening rules** | `BC-06` | `ATT-PO-002` — *conform, do not translate* |
| **Retention policy** | undecided | **`ATT-GAP-005` OPEN.** This module **MUST NOT** define its own |
| **Offline queue and replay mechanics** | `BC-30` | `ATT-PO-006` — Attendance **defines** the policy, Sync **executes** it |
| **Notification delivery** | `BC-22` | `ATT-PO-010` — publish facts, never *"send an SMS"* |

**`ATT-FR-147` — attendance is never presented as certified.** `ATT-FR-145`
permits exposing operational facts; it does not permit certifying them.

## 3. The rules that bite first

New implementers break these five most often, so they are stated before anything
else.

1. **You may not add a fifth event.** The `attendance.*` surface is **exactly
   four** events (`ATT-FR-134`, `ATT-AC-117`). A presence change that is neither a
   check-in nor a check-out **has no event**, and that is intentional — the Seat
   Card gets presence by a **read**, not a message (`ADR-0032`, `O-5`).
2. **You may not overload `StudentCheckedOut`.** Entering the grace period is
   **not** a check-out. `ATT-AC-217` requires a test proving no check-out exists
   for a student who merely entered grace.
3. **You may not implement the 5-minute rule as a timer.** It is a **predicate
   over recorded observations**, evaluated on read or reconciliation (§10A.4).
4. **You may not infer an exit from silence.** No observations means
   `INCOMPLETE / EXIT NOT VERIFIED`, never a computed exit instant (§10A.4a row 2,
   §10A.5, `ATT-AC-220`).
5. **You may not let anything outside `BC-03` see raw Wi-Fi data.** No SSID,
   BSSID, signal strength or MAC address may cross the module boundary
   (`ATT-AC-218`, `ATT-BR-045`).

## 4. Ports — what it consumes, and from whom

The module has **14** ports (`ATT-PO-001` … `ATT-PO-014`). The consuming and
publishing ones, verbatim from §20:

| Port | Edge | Counterpart | Kind | Contract |
|---|---|---|---|---|
| `ATT-PO-001` | `E-03` | `BC-02` Membership | `C/S` + `PL` | `MembershipValidity` — **records and flags, never blocks** |
| `ATT-PO-002` | `E-04` | `BC-06` Library Policy | `CF` | `AttendanceRules{openTime, closeTime, graceMinutes, lateEntryPolicy}` — **conform, do not translate** |
| `ATT-PO-003` | `E-17` | `BC-21` Entitlement | `CF` | `check(tenantId, feature, delta)` **before** the aggregate mutates |
| `ATT-PO-004` | `E-18` | `BC-19` Tenancy | `SK` | `TenantContext`, **propagated — never a domain method parameter** |
| `ATT-PO-005` | `E-19` | `BC-25` Configuration | `CF` | **Typed** config accessors; no raw string lookups |
| `ATT-PO-006` | `E-24` | `BC-30` Offline Sync | `CF` | Attendance **defines** conflict resolution; Sync **executes** it |
| `ATT-PO-008` | `E-08` | `BC-04` Seating | `PL` | `StudentCheckedIn` / `StudentCheckedOut` → Seating updates occupancy |
| `ATT-PO-009` | `E-20` | `BC-24` Audit Trail | `PL` | Audit facts, **fire-and-forget, outbox-backed. Never synchronous** |
| `ATT-PO-010` | `E-23` | `BC-22` Notification Delivery | `PL` | **Facts only** |

`ATT-PO-011` … `ATT-PO-013` define the **offline conflict-resolution policy**: a
replayed punch is absorbed by **idempotency** rather than applied twice, every
§6.2 invariant survives replay, and **a replayed punch MUST NOT overwrite a
correction** made while the device was offline.

`ATT-PO-014` records that **the offline behaviour of Dynamic QR is undefined** — a
rotating server-validated code cannot be validated offline. Do not invent a
fallback.

## 5. Configuration

**24 registered configurables**, `ATT-CFG-001` … `ATT-CFG-024`, each with an
authority and a default (§16). Read them through **typed accessors** via
`ATT-PO-005`; never a raw string lookup.

Authority is `owner`/`tenantWide` for every row **except `ATT-CFG-008`**
(approved Wi-Fi networks), which is **`owner` + `manager`** by Product Owner
decision **`D-12`**. Every configuration change is **audited** (`ATT-FR-038`) and
**tenant-isolated** (`ATT-BR-017`).

> **The 30-minute shift tolerance is NOT in this register.** It is binding
> product intent (§10A.7a) and is Owner **and** Manager configurable, but no
> `ATT-CFG-025` row exists — because the traceability gate requires every
> configurable to carry a **default and a range**, and **no range has been
> approved by the Product Owner**. `ADR-0031` remains `Proposed`. Implement the
> behaviour; do not fabricate a range to make it registrable.

## 6. Roles (§19)

| Operation | Role(s) | Scope |
|---|---|---|
| Configure attendance modes and values (§16) | `owner` | `tenantWide` |
| **Manage authorized Wi-Fi networks** | **`owner`, `manager`** (`D-12`) | `tenantWide` |
| Operational attendance actions | `manager` | `tenantWide` |
| Individual manual entry (§13A) | `reception`, `manager` | `tenantWide` |
| OCR verification (§13C) | `reception`, `manager` | `tenantWide` |
| Corrections (§18) | `reception`, `manager` — subject to `ATT-CFG-022` | `tenantWide` |
| Self attendance (modes 1–5) | `student` | `self` |
| View own attendance | `student` | `self` |
| View guarded students' attendance | `parent` — subject to `ATT-CFG-024` | `guardianOf` |

**`ATT-FR-118` forbids defining a new role.** If a feature seems to need one,
it needs a decision instead.

## 7. Register totals — the shape of the specification

| Register | Range | Count |
|---|---|---|
| `ATT-FR-*` | functional requirements | **151** |
| `ATT-BR-*` | business rules | **45** |
| `ATT-INV-*` | invariants | **12** |
| `ATT-EVT-*` | `001` … `004` | **4** |
| `ATT-XC-*` | explicit exclusions | **21** |
| `ATT-PO-*` | `001` … `014` | **14** |
| `ATT-CFG-*` | `001` … `024` | **24** |
| `ATT-NFR-*` | non-functional | **14** |
| `ATT-AC-*` | acceptance criteria | **222** |
| `ATT-GAP-*` | 18 numbers / 23 rows | **18 open, 4 resolved, 1 narrowed** |
| **Total** | | **525** |
| **Obligation-bearing** | | **285** |

The traceability gate reports **285/285 = 100.0%** coverage with **0** dangling
references and **0** orphans, and the task gate reports **80** tasks spanning
`IMPL-600` … `IMPL-679` with **0** holes.

## 8. Where to go next

[`DOMAIN_RULES.md`](./DOMAIN_RULES.md), then
[`ATTENDANCE_STATE_MACHINE.md`](./ATTENDANCE_STATE_MACHINE.md). Those two carry
the logic most likely to be implemented wrongly.
