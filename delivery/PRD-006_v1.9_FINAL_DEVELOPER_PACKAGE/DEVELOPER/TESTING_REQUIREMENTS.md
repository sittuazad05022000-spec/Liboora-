# TESTING_REQUIREMENTS — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md) §30 (**FROZEN**).

---

## 1. The acceptance register — 222 criteria

| Property | Value |
|---|---|
| **Register** | `ATT-AC-001` … **`ATT-AC-222`** |
| **Count** | **222** |
| **Coverage requirement** | `ATT-NFR-010` — **every obligation must carry a criterion** |
| **Measured coverage** | **285 / 285 = 100.0%** |
| **Gate** | `prd006_traceability.py` — **exit 0**, dangling **0**, orphans **0** |

Confirmed three ways: the PRD's §0.3 register row reads **222**, the gate prints
`AC 222 222 ATT-AC-001 … ATT-AC-222`, and **222** distinct `ATT-AC-*` identifiers
appear in the document.

> ⚠️ **`IMPL-679`'s description says *"all 213 `ATT-AC-*`"*. That figure is
> stale.** The register grew to **222** when `ADR-0032` and the `R-19` tolerance
> criterion added `ATT-AC-214` … `ATT-AC-222`. **Bind the harness to 222.**

## 2. `ATT-AC-*` are verified BY tests, not satisfied by tasks

The task backlog is explicit: *"`ATT-AC-*` do not appear in Requirements cells. An
acceptance criterion is **verified by** a task's test, not"* satisfied by the task
itself.

**Every `ATT-AC-*` must map to a named test.** `IMPL-679` is the acceptance
harness that binds them — ⛔ **BLOCKED** on **`ATT-GAP-017a`** for the
non-functional half only.

## 3. The v1.9 criteria (§30.20) — nine tests you must write

Added by `ADR-0032` (`Accepted`, `O-5`) and the `R-19` tolerance criterion. *"Every
row verifies an obligation **already registered**"* — no requirement was created to
make them citable.

| ID | What the test must assert |
|---|---|
| **`ATT-AC-214`** | A **manually recorded attendance** renders 🟠 `PRESENCE UNVERIFIED` and **never** 🟢 `PRESENT`. The distinguishing input is the **`method`** already carried in the `StudentCheckedIn` payload |
| **`ATT-AC-215`** | ⚪ `NOT ATTENDED` and 🟠 `PRESENCE UNVERIFIED` are **never merged** — two distinct states, and **no code path maps one onto the other** |
| **`ATT-AC-216`** | The `attendance.*` published surface still contains **exactly four** events after presence became visible on the Seat Card, **and entering the 5-minute grace publishes nothing** |
| **`ATT-AC-217`** | **No `StudentCheckedOut` exists for a student who merely entered grace.** It is emitted **only for a real recorded exit** |
| **`ATT-AC-218`** | Exposed presence facts contain **no SSID, BSSID, signal strength, MAC address or other network datum**, and **no consumer can obtain one through the exposed path** |
| **`ATT-AC-219`** | Presence exposed for composition is **never a stored copy** held by the consumer — computed per read, carrying the **observation instant** |
| **`ATT-AC-220`** | **Presence is never fabricated from silence.** A gap with no observation yields `INCOMPLETE / EXIT NOT VERIFIED`, and **no invented exit timestamp** appears |
| **`ATT-AC-221`** | On a **06:00–10:00** shift with verified presence **05:50 → 10:10**, the booked-shift figure is **exactly 4 hours**; **both** tolerance windows are operationally accepted and **both contribute zero** |
| **`ATT-AC-222`** | A student present beyond the booked window plus tolerance is reported as **present** *and* as **outside the booked window** — the overstay fact **MUST NOT** replace or suppress presence |

## 4. Earlier criteria that carry the highest risk

| ID | Assertion |
|---|---|
| **`ATT-AC-117`** | *"Exactly four `attendance.*` events are published, with the BC Map §9 names, and no other"* (`ATT-FR-134`, `ATT-EVT-001`…`004`) |
| **`ATT-AC-093`**, **`ATT-AC-095`**, **`ATT-AC-177`** | Never fabricate an exit; **only verified duration counts** (`ATT-BR-030`, `ATT-BR-031`, `ATT-FR-083`, `ATT-FR-088`) |
| **`ATT-AC-181`** | The conflict-resolution policy is **defined here and executed by `BC-30`**; **no queue, replay loop or conflict detector exists in this module** |
| **`ATT-AC-209`** | The permissive behaviour is preserved — **no unauthorised *"at least one mode"* constraint** (`ATT-GAP-018`) |

## 5. Test areas derived from §10A

### 5.1 The grace period

- T0 is *"**all** valid devices lost presence"*, **not** "a device disconnected".
- Reconnect **inside** grace → **SAME** session, **no** new check-in event.
- Reconnect **after** the session ended → **no** resurrection; new presence is
  *"evaluated on its own terms"*.
- Grace is **exactly 5 minutes** — assert the boundary, and assert **no second
  grace period** exists anywhere.
- Assert the rule holds **without any timer or scheduled job** — status must be
  correct when computed purely from stored observations.

### 5.2 Exit precedence (§10A.4a) — all six rows

Each row needs its own test, evaluated **in order**:

1. A **physically verified exit** wins over every inference.
2. Observations merely **stopped** → `INCOMPLETE / EXIT NOT VERIFIED`, **no** exit
   instant.
3. A **valid loss observation** + no recovery in 5 min → `SESSION ENDED`,
   method = *Wi-Fi-based exit detection*.
4. Loss + recovery inside 5 min → `VERIFIED PRESENCE`, **same** session.
5. Still open with a valid device → `VERIFIED PRESENCE`.
6. Unplaceable on the evidence → `INCOMPLETE / EXIT NOT VERIFIED`.

**Plus:** rows 1 and 3 are **both `SESSION ENDED`** but **MUST NOT** be stored as
the same value, conflated, merged, or displayed identically. Assert the **exit
method** is distinguishable.

### 5.3 Multi-device

Two verified phones → **ONE** `VERIFIED PRESENCE`, **no** doubled duration, **one**
session. Grace starts only when **all** devices have lost presence.

### 5.4 Unknown device / unknown person

- Unassociated device → `UNKNOWN DEVICE / UNVERIFIED PRESENCE`, **no** attendance,
  **no** duration.
- Manually verified → `VERIFIED MEMBER` via the §13 workflow **and its
  authorisation rules**.
- Not verified → `UNVERIFIED — NO ATTENDANCE`, and **no attendance record exists**.

### 5.5 Shift tolerance

The `ATT-AC-221` worked example is the primary test. Also assert:

- 05:30–06:00 presence **MAY** be accepted operationally but adds **zero** hours.
- 10:00–10:30 is **not** silently normal presence.
- After 10:30 → **overstay**, not silent `VERIFIED PRESENCE`.
- Tolerance applies to **both** sides, and there is **no second tolerance**.

### 5.6 The nine status strings

Assert **exactly nine** stored values exist, that rows **8** and **9** are
**stored** rather than derived, and that **no tenth** string can be produced.

### 5.7 Android platform events

All four converge on the safe outcome when observations merely stopped:

| Event | Assert |
|---|---|
| **Force-stop** | **No** presence claim for the unobserved period; reconciliation on next open |
| **OEM restriction** | **No** fabricated presence; **not** reported as the student's fault |
| **Reboot** | **No** exit inferred at the reboot instant |
| **Permission revoked** | **Stops** asserting presence **and** does **not** assert an exit |

### 5.8 Offline replay

- A replayed punch is **absorbed by idempotency**, never applied twice
  (`ATT-PO-012`, `MP-GBR-18`).
- A replayed punch **never overwrites a correction** made offline (`ATT-PO-013`).
- **Every §6.2 invariant survives** replay.
- **Dynamic QR offline behaviour is undefined** (`ATT-PO-014`) — assert **no
  fallback was invented**.

### 5.9 Location Verification

Default **OFF**. When denied: the other six modes still work (`ATT-BR-008`), and
the failure is **distinguishable, never a silent downgrade** (`ATT-NFR-005`,
`ATT-FR-036`).

### 5.10 Audit

- Emitted to `BC-24` via `E-20`, **fire-and-forget outbox**, **never synchronous**
  (`ATT-FR-129`).
- **No attendance-specific audit store** (`ATT-FR-130`, `X-10`).
- Every act in `ATT-FR-131`'s list produces a fact.
- Every fact carries **actor + tenant** (`ATT-FR-132`) and **no secret**
  (`ATT-FR-133`).

### 5.11 Boundary tests

- The **four non-existent edges** are **impossible**, not merely unwired
  (`IMPL-605`).
- Entitlement is checked **before** mutation (`ATT-PO-003`) — an **ordering** test.
- Attendance is complete **when the attendance write commits**, **not** when
  occupancy updates (`ATT-XC-009`, `ATT-NFR-013`, `ATT-FR-142`).
- **No** transaction spans check-in and seat occupancy.
- Presence is **never stored** on the seat or the allocation (`SEAT-FR-104`).

## 6. Negative tests — assert absence

Several requirements can only be proven by asserting something **does not** exist.
These are as mandatory as the positive ones.

| Assert the ABSENCE of | Obligation |
|---|---|
| A fifth `attendance.*` event | `ATT-FR-134`, `ATT-AC-117`, `ATT-AC-216` |
| A `StudentCheckedOut` on entering grace | `ATT-AC-217` |
| Any network datum in exposed facts | `ATT-AC-218` |
| A stored presence copy in the consumer | `ATT-AC-219` |
| An invented exit timestamp | `ATT-AC-220` |
| A tenth status string | §10A.1 |
| An `ATT-CFG-025` | §16.3, `R-8` |
| A timer, polling loop, `startScan()`, or mandatory foreground service | §10A.4, §10A.10 |
| A periodic-check interval | `D-14` |
| A latency or throughput figure | `ATT-NFR-003`, `ATT-GAP-017a` |
| A retention period or purge job | `ATT-GAP-005` |
| A new role | `ATT-FR-118` |
| An `E-27` edge | `ADR-0033` (`Accepted`, `O-C`) |
| A `VerificationStrategy` pipeline | `ATT-XC-011`, `ATT-BR-004` |

## 7. Gate state to maintain

| Gate | Expected |
|---|---|
| `prd006_traceability.py` | **exit 0** — `285/285 = 100.0%`, dangling 0, orphans 0, collisions 0 |
| `prd006_task_coverage.py` | **exit 0** — 80 tasks, `IMPL-600..679`, 0 holes, 0 duplicates |
| `check_module_boundaries.dart` | **Red, pre-existing** — 9 `ADR-0012` time-boxed violations (`BLK-01`/`TASK-D10`) |
| `prd007_traceability.py` | **2 pre-existing failures** — not caused by this module |

**Never weaken a gate to make a change pass.** The specification's own history
records probes being **reverted** when they failed a gate, and the gate left
intact.

## 8. Checklist

- [ ] All **222** `ATT-AC-*` bound to named tests (not 213).
- [ ] All nine §30.20 criteria implemented.
- [ ] All six exit-precedence rows tested **in order**.
- [ ] Grace boundary tested, **and** proven timer-free.
- [ ] Exit method distinguishable between rows 1 and 3.
- [ ] All four Android platform events tested.
- [ ] Replay idempotent; corrections never overwritten.
- [ ] Every §6 **absence** asserted.
- [ ] Both `prd006_*` gates **exit 0**.
