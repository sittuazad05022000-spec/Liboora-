# EVENT_CONTRACTS — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT.md) §22 (**FROZEN**) · BC Map §9.

---

## 1. The surface is closed at exactly four events

**`ATT-EVT-001` … `ATT-EVT-004`. Four. `ATT-FR-134` forbids inventing more, and
`ATT-AC-117` requires a test asserting *"Exactly four `attendance.*` events are
published, with the BC Map §9 names, and no other."***

| ID | Event | Consumers | Purpose | Payload | Delivery |
|---|---|---|---|---|---|
| `ATT-EVT-001` | **`attendance.StudentCheckedIn`** | `BC-04`, `BC-26`, `BC-22` | Occupancy, parent notification | `StudentRecordId`, tenant, timestamp, **`method`**, day reference | Required · idempotent **by event identifier** |
| `ATT-EVT-002` | **`attendance.StudentCheckedOut`** | `BC-04`, `BC-26` | Occupancy release | Same shape | Same |
| `ATT-EVT-003` | **`attendance.AttendanceCorrected`** | `BC-24`, `BC-26` | Audit + restated metrics | Correction reference, actor, reason | Same |
| `ATT-EVT-004` | **`attendance.FraudSignalDetected`** | `BC-24`, `BC-13`, `BC-22` | Anti-proxy enforcement | Signal type, tenant, day reference | Same, **plus raw evidence payloads** |

**Naming convention — `ATT-FR-135`:** `<Context>.<Aggregate><PastTenseVerb>`. All
four names above conform; any new name would have to as well, but see §2.

## 2. Why a fifth event does not exist, and must not be created

This was **attempted and measured**, so it is not an open design question.

A fifth `attendance.*` event was injected into §22.1 as a probe and the Stage 5
gate re-run. **It failed five ways:**

1. the `ATT-EVT-*` count,
2. the §0.3 total,
3. the obligation-bearing total,
4. an **`ATT-NFR-010` coverage** failure,
5. *"section 2F registers `ATT-EVT-*` as 4 (001..004); computed 5"* — a **Rank 4**
   document (`TRACEABILITY_MATRIX.md`) this PRD has **no authority to amend**.

`ATT-AC-117` independently asserts *"exactly four … and no other"*. **The probe
was reverted and the gate returned to exit 0 before anything was written.**

### 2.1 The transport problem was dissolved, not paid for

A presence *state change that is neither a check-in nor a check-out* **has no
event to travel on**. That is intentional. `ADR-0032` (`Accepted`) selected option
**`O-5`** — **read-time composition** — so the Seat Card **pulls** presence
instead of receiving it. *"A pull needs no carrier."*

**`ATT-AC-216`** locks this in: a test asserts the published surface still
contains **exactly four** events *after* presence became visible on the Seat Card.

## 3. `StudentCheckedOut` MUST NOT be overloaded

Overloading it to mean *"entered grace"* is named and refused. It would:

- emit **a check-out that did not happen**, fabricating the exit §10A.5 forbids;
- write an **attendance-shaped fact `SEAT-XC-007` forbids `BC-04` from holding**.

**`ATT-AC-217`:** *"`StudentCheckedOut` is emitted only for a real recorded
exit."* Entering the grace period, or any presence state change that is not an
exit, emits **no** `StudentCheckedOut`, and a test asserts **no check-out exists
for a student who merely entered grace**.

| Transition | Event emitted |
|---|---|
| Attendance recorded | `attendance.StudentCheckedIn` |
| **Real recorded exit** | `attendance.StudentCheckedOut` |
| **Entering the 5-minute grace** | **NONE** |
| Grace expiry → `SESSION ENDED` | `StudentCheckedOut` **only because this is a real recorded exit** (§10A.4a row 3) |
| Any other presence change | **NONE** |

## 4. The `method` field is load-bearing

`ATT-EVT-001` carries **`method`**, and `ATT-AC-214` depends on it: manual
attendance must render 🟠 `PRESENCE UNVERIFIED` and **never** 🟢 `PRESENT`, and
*"the distinguishing input is the `method` **already** carried in the
`attendance.StudentCheckedIn` payload."*

**Do not drop, flatten or normalise `method` away.** A Seat Card correctness
criterion rests on it.

## 5. Idempotency

Every event is **idempotent by event identifier**. `ATT-FR-141` additionally
requires `ATT-EVT-001` and `ATT-EVT-002` to be published **with a stable event
identifier** so Seating can act idempotently.

This is the same guarantee the offline path needs: `ATT-INV-003`/`ATT-FR-090` pair
with platform rule **`MP-GBR-18` idempotency**, and `ATT-PO-011` … `ATT-PO-013`
require a replayed punch to be **absorbed by idempotency rather than applied
twice**, and to **never overwrite a correction** made while offline.

## 6. Publication is a fact, never a command

| Port | Consumer | Rule |
|---|---|---|
| `ATT-PO-008` (`E-08`) | `BC-04` Seating | *"Seating is the occupancy owner; Attendance is the trigger"* |
| `ATT-PO-009` (`E-20`) | `BC-24` Audit Trail | **Fire-and-forget, outbox-backed. Never called synchronously** |
| `ATT-PO-010` (`E-23`) | `BC-22` Notification Delivery | **Facts only — never *"send an SMS"*** |

## 7. Consumption MUST NOT be depended upon

**`ATT-FR-137` forbids depending on `BC-26` or `BC-13` consumption**, recorded as
gaps **`ATT-GAP-003`** and **`ATT-GAP-004`**.

§22.3 records the unresolved consumer question: BC Map §9 lists `BC-26` as a
consumer of `ATT-EVT-001`/`002`/`003`, `BC-22` of `ATT-EVT-001`/`004`, and `BC-13`
of `ATT-EVT-004` — but the reachability of those consumers is not settled.
`ATT-EVT-004` is emitted *"where the event's consumers are reachable"*.

**Implementation consequence:** publish correctly and **do not build any
behaviour that requires a consumer to have acted.** No acknowledgement waits, no
read-back of a consumer's state, no synchronous dependency.

## 8. `AttendanceCorrected`

`ATT-FR-111`: **a correction MUST emit `attendance.AttendanceCorrected`**
(`ATT-EVT-003`). Corrections are **append-only** — `ATT-INV-005`/`ATT-BR-040` pair
with platform rule **`MP-GBR-11` append-only corrections**, and audit has **no
update and no delete path** (`X-10`). See
[`ATTENDANCE_HISTORY.md`](./ATTENDANCE_HISTORY.md).

## 9. `FraudSignalDetected` — and what it may not imply

`ATT-EVT-004` carries **raw evidence payloads** and reaches `BC-24`, `BC-13` and
`BC-22`. Two constraints from elsewhere in the specification bind its use:

- **No control in this document makes proxy attendance impossible** (`ATT-FR-039`,
  `ATT-BR-042`, §10A.8 claim 3).
- **`INCOMPLETE / EXIT NOT VERIFIED` is NOT a fraud signal.** Its causes are
  *"named, and none of them is fraud"* — process death, force-stop, reboot, OEM
  restriction, revoked permission. It **MUST NOT** be presented as suspicious, and
  **MUST NOT** raise `ATT-EVT-004`.

## 10. Implementation checklist

- [ ] Exactly **four** event types exist in code. A test asserts the count.
- [ ] Names match BC Map §9 exactly and follow `<Context>.<Aggregate><PastTenseVerb>`.
- [ ] **No** fifth event, for any reason, including presence changes.
- [ ] Entering grace emits **nothing**.
- [ ] `StudentCheckedOut` only for a **real recorded exit**.
- [ ] `method` present on `StudentCheckedIn` and preserved end-to-end.
- [ ] Stable event identifier; consumers can dedupe.
- [ ] Audit publication is **fire-and-forget via outbox**, never synchronous.
- [ ] Notifications receive **facts**, not instructions.
- [ ] **No** code path depends on a consumer having consumed.
- [ ] `INCOMPLETE / EXIT NOT VERIFIED` never raises a fraud signal.
