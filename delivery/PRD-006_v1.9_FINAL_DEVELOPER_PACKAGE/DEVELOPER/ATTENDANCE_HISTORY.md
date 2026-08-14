# ATTENDANCE_HISTORY — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md) §10A.5, §10A.6, §18, §21, §24, §26 (**FROZEN**).

---

## 1. What history is, and what it may never claim

Attendance history is a record of **facts that were observed**, plus an explicit
record of **what could not be observed**. That second half is the part
implementations usually get wrong.

| History may say | History may **NOT** say |
|---|---|
| *"A qualifying exit closed this session at T"* | *"The student left at T"* when T was inferred from silence |
| *"A proper exit could not be verified"* | *"Session ended"* with an invented timestamp |
| *"Verified presence 06:00 → 10:00"* | *"Study Hours = 4"* as this module's own certified metric |
| *"Attendance was recorded manually"* | *"Presence was verified"* |
| *"No attendance today"* | *"Presence unverified"* — a different fact |

## 2. Never fabricate an exit — §10A.5

Where an exit cannot be reliably verified, the stored status is
**`INCOMPLETE / EXIT NOT VERIFIED`**, and the exit timestamp stays **empty**.

The prohibition is carried by requirements that already existed — §10A.5 *"adds no
`ATT-*` identifier"*; it is **`ATT-BR-030`, `ATT-BR-031`, `ATT-FR-083` and
`ATT-FR-088`** applied to this case.

- **`ATT-BR-030`** already forbids **auto-completing a missed check-out with an
  invented timestamp**.
- **`ATT-FR-083`'s reason applies unchanged:** *"Seating derives live occupancy
  from `E-08`; a fabricated exit silently"* corrupts another context's state.

**Causes are named, and none of them is fraud** — process death, force-stop,
reboot, OEM background restriction, revoked permission. An
`INCOMPLETE / EXIT NOT VERIFIED` entry **MUST NOT** be presented to a student or to
staff as suspicious, and **MUST NOT** raise `ATT-EVT-004`.

Verified by **`ATT-AC-093`**, **`ATT-AC-095`**, **`ATT-AC-177`** and
**`ATT-AC-220`**.

## 3. The two `SESSION ENDED` facts must stay distinguishable

§10A.4a rows 1 and 3 both store `SESSION ENDED`, but a **physically verified
exit** and a **Wi-Fi-based exit detection** **MUST NOT** be conflated, merged,
displayed identically, or **stored as the same value**.

**History must therefore carry the exit method**, not just the status. A history
view that renders both as an identical "checked out" line violates this.

## 4. Corrections are append-only

| Rule | Obligation |
|---|---|
| A correction **MUST** emit **`attendance.AttendanceCorrected`** (`ATT-EVT-003`) | `ATT-FR-111` |
| Corrections are **append-only** | `ATT-INV-005`, `ATT-BR-040`, platform rule **`MP-GBR-11`** |
| Corrections are permitted only per configuration | `ATT-CFG-022` (**Enabled** by default) |
| The correction window is **15 minutes** by default (range 0–60 minutes) | `ATT-CFG-023` |
| Who may correct | **`reception`, `manager`** — §19, subject to `ATT-CFG-022` |
| Every correction **MUST** produce an audit fact | `ATT-FR-131` |

**A correction never edits the original in place.** The original stays; the
correction is appended; the event is emitted; audit records it.

### 4.1 A correction outranks an inference

§10A.4a row 1 includes a **§18 correction** among the physically verified exits,
and *"a human act beats every inference."*

**And a replay must never undo one.** `ATT-PO-013`: *"A replayed punch **MUST
NOT** overwrite a correction made while the device was offline."*

## 5. Offline replay and history integrity

| Rule | Obligation |
|---|---|
| This module **defines** the conflict-resolution policy; `BC-30` **executes** it | `ATT-PO-006`, `ATT-PO-011` |
| The policy **MUST** preserve every §6.2 invariant; a replayed punch **MUST NOT** be applied twice | `ATT-PO-012` |
| A replayed punch **MUST NOT** overwrite a correction | `ATT-PO-013` |
| Duplicate prevention | `ATT-INV-003`, `ATT-FR-090`, platform rule **`MP-GBR-18` idempotency** |
| **Dynamic QR offline behaviour is UNDEFINED** | **`ATT-PO-014`** — a rotating server-validated code cannot be validated offline. **Do not invent a fallback** |

Replay is absorbed **by idempotency**, not by "latest write wins" and not by
merging.

## 6. Session duration in history

**Verified session duration is recorded** (§10A.6, `D-11`) — *"subject to the ARB
question it leaves open"*, and that question **remains open**. Do not close it in
code.

**Only verified duration counts.** *"Never fabricate an exit; only verified
duration counts"* — `ATT-BR-030`, `ATT-BR-031`, `ATT-FR-083`, `ATT-FR-088`,
verified by `ATT-AC-093`, `ATT-AC-095`, `ATT-AC-177`.

### 6.1 Study Hours are not this module's figure

`ATT-FR-146`: this module **MUST NOT** own analytics — **`BC-26` owns metrics**.
History may expose **operational facts** (`ATT-FR-145`), but attendance is
**never certified** (`ATT-FR-147`).

Study Hours count **only verified presence inside the booked shift**. On a
06:00–10:00 shift with verified presence 05:50 → 10:10, the booked-shift figure is
**exactly 4 hours**; the two 10-minute tolerance segments contribute **nothing**
(`ATT-AC-221`). The excluded time *"is not a metric being withheld, it is presence
that falls outside the booked shift the figure is about."*

## 7. Audit — §21

| Requirement | Rule |
|---|---|
| `ATT-FR-129` | Audit facts **MUST** be emitted to **`BC-24`** via **`E-20`**, as **fire-and-forget outbox-backed events**. The domain **MUST NOT** call audit **synchronously** |
| `ATT-FR-130` | This module **MUST NOT** create an attendance-specific audit store — **`X-10`: audit has no update or delete path** |
| `ATT-FR-132` | Every audit fact **MUST** carry the **acting actor** and the **tenant of record** |
| `ATT-FR-133` | **No audit fact may contain an authentication secret** (`ATT-FR-123`) |

### 7.1 What must produce an audit fact — `ATT-FR-131`, verbatim list

configuration changes (§16) · fixed QR activation, replacement and revocation ·
dynamic QR configuration changes · face enrollment, withdrawal and configuration
change · **every manual attendance entry** · **every OCR verification decision,
including rejection** · **every attendance correction** · failed and suspicious
attempts where supported · device/scanner configuration where this module owns the
action.

## 8. Manual and unknown-person entries in history

| Case | History records |
|---|---|
| **Manual attendance** | Attendance exists, but **presence is NOT verified**. `ATT-AC-214` requires it to render 🟠 `PRESENCE UNVERIFIED`, **never** 🟢 `PRESENT`, distinguished by the **`method`** field |
| Unknown device, unassociated | **`UNKNOWN DEVICE / UNVERIFIED PRESENCE`** — no automatic attendance, **no session duration** |
| Unknown person, **manually verified** as a member | **`VERIFIED MEMBER`**, via the existing Manual workflow (§13, `ATT-BR-038`, `ATT-FR-110`…`116`) and its authorisation rules |
| Unknown person, **not** verified | **`UNVERIFIED — NO ATTENDANCE`** — **no attendance record exists** |

## 9. Retention is NOT defined here

> **`ATT-GAP-005` is OPEN, and this module MUST NOT define its own retention
> policy.**

Do not add a purge job, a TTL, an archive window or a "keep 90 days" default. §24
and §26 are explicit that retention is owed and undecided. A migration or a
scheduled cleanup that silently picks a period would close an open gap by
accident.

## 10. Implementation checklist

- [ ] Exit timestamp is **nullable and honestly empty** when unverified.
- [ ] **Exit method stored** alongside status; Wi-Fi exit ≠ physically verified exit.
- [ ] `INCOMPLETE / EXIT NOT VERIFIED` is never rendered as suspicious and never
      raises a fraud signal.
- [ ] Corrections **append**, emit `ATT-EVT-003`, and are audited.
- [ ] A replay **never** overwrites a correction and **never** applies twice.
- [ ] **No** attendance-specific audit store; audit is **outbox, async, never
      synchronous**.
- [ ] Audit facts carry actor + tenant, and **never a secret**.
- [ ] `method` preserved so manual ≠ verified downstream.
- [ ] **No** retention policy, TTL or purge job.
- [ ] Study Hours attributed to **`BC-26`**, never certified here.
