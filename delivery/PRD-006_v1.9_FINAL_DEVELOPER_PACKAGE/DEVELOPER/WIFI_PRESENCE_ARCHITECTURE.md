# WIFI_PRESENCE_ARCHITECTURE — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md) §10A (**FROZEN**).

---

## 1. The fixed direction of flow

§23.4a states this chain is *"fixed and is not negotiable"*:

```
Wi-Fi observation → Attendance verification → student presence
                  → existing Seat/Occupancy contract → Seat Card
```

Nothing may bypass a link. In particular **the Seat Card MUST NOT read raw Wi-Fi
data**, and **no `Wi-Fi → BC-04` edge is created** — BC Map L292 is explicit that
*"an edge not in this table does not exist and adding it requires an ADR."*

## 2. The observation path

§10A.4 fixes the pipeline, and it introduces **no new infrastructure**:

```
NetworkCallback
      │  (device-side, event-driven)
      ▼
V1 Local Write Queue  ──  BC-30 Offline Sync, via the already-authorised E-24
      │
      ▼
WorkManager reconciliation
      │
      ▼
backend-derived state   ──  status computed as a predicate over observations
```

> **No other scheduler, no periodic interval and no `Job Runtime` dependency is
> introduced.**

`ATT-PO-006` governs the queue relationship: **Attendance defines the
conflict-resolution policy; `BC-30` executes it.** `ATT-PO-011` … `ATT-PO-013`
specify that policy — replay is absorbed by **idempotency**, every §6.2 invariant
survives it, and **a replayed punch MUST NOT overwrite a correction** made while
the device was offline.

## 3. Derived state, not stored state — and never a timer

The single most important architectural property of this capability:

> The 5 minutes is a **predicate over recorded observations**, evaluated when the
> session is read or reconciled — **never a scheduled job.**

Frozen `SEAT-FR-116` already requires the `BC-03` open-session set to be
**recomputable**, so a derived predicate satisfies the frozen contract and *"a
timer would not be needed to satisfy it."*

**`WorkManager`'s guarantee is EVENTUAL, never PUNCTUAL.** It is used for
**reconciliation**, and the 5-minute rule **MUST NOT** be built on it as a
deadline. That is precisely why the rule is a predicate.

## 4. What is explicitly NOT specified — and MUST NOT be supplied

| Not specified | Why, and what owns it |
|---|---|
| **The network verification mechanism** | `ATT-XC-015` forbids specifying one. `ADR-0027` (**`Proposed`**) owns the question. **`ATT-GAP-007`** is *narrowed by permission, not closed* |
| **The periodic-check interval** | `D-14` explicitly withholds it — *"Do not invent the periodic-check interval."* `ATT-NFR-003` independently forbids a latency or throughput figure while **`ATT-GAP-017a`** is open |
| **Any OS permission, service type or scheduling mechanism** | `ATT-FR-044` remains the only OS-permission line in the PRD, and it concerns **mode 4** |
| **Any router, gateway, hardware, network identifier, API or certificate** | `D-13` **permits** a library-side device or software component if Architecture/Security determines one is necessary, but **selects no mechanism** |
| **Retention of observations** | **`ATT-GAP-005` OPEN.** This module **MUST NOT** define its own |

**Do not fill these in.** Each is a decision reserved to a named owner.

## 5. Explicitly excluded mechanisms

**No polling loop, no Wi-Fi scanning, no server timer and no mandatory foreground
service is specified.**

| Mechanism | Status | Reason |
|---|---|---|
| **Polling loop** | Not used | The model is event-driven plus reconciliation |
| **`WifiManager.startScan()`** | **Not used** | *"throttled by the platform"* |
| **Server timer** | **Not used** | §10A.4 is a predicate |
| **Foreground service** | **Not required** | It would buy *punctuality* the derived-state model does not need, at the cost of a persistent notification. Whether one is nonetheless warranted is **`ADR-0028`'s question**, not the PRD's |

## 6. What the student experiences — nine steps (§10A.10)

1. The student **books a shift**.
2. The student **arrives** at the library.
3. A **registered device** connects to the authorized Wi-Fi network.
4. The network is **verified** — *by the mechanism Architecture/Security finally
   approves* (`ADR-0027`; **not specified**).
5. The device is **associated with the student's Liboora account** — association
   is **required, never inferred** (§10A.3).
6. The **presence session starts automatically**.
7. **Attendance is recorded automatically** — under the seventh type of §7.1a,
   *once it is definable*.
8. **Verified session duration is recorded** — subject to the ARB ruling in
   §10A.6.
9. **Study Hours may use it** — aggregation remains `BC-26`'s (`ATT-FR-146`).

### 6.1 Detection model — `D-14` = C

The student **MUST NOT** be required to keep the Liboora app visibly open
continuously. Detection is:

> **app-open detection, plus periodic/background-aware checks, plus
> reconciliation and filling of legitimate gaps**

and reconciliation is *"already half-solved"* by the offline policy in §27.1
(`ATT-PO-011` … `ATT-PO-013`), *"which absorbs a replayed punch by idempotency
rather than applying it twice."*

**No interval is attached to "periodic".** See §4.

## 7. Multi-device — OR presence

§10A.2. One account, one session. Two verified phones produce **ONE**
`VERIFIED PRESENCE`, never two sessions and never doubled duration. The grace
clock (T0) starts only when **all** valid registered devices have lost verified
presence. Full transitions in
[`ATTENDANCE_STATE_MACHINE.md`](./ATTENDANCE_STATE_MACHINE.md).

## 8. Unknown devices and unknown people

§10A.3. Association is required, never inferred:

| Situation | Outcome |
|---|---|
| On the authorized network, **not associated** with a Liboora account | **`UNKNOWN DEVICE / UNVERIFIED PRESENCE`** — no automatic attendance, no session duration |
| Subsequently **manually verified** as a member by authorised staff | **`VERIFIED MEMBER`**, via the existing Manual workflow (§13) and its authorisation rules |
| **Not** verified | **`UNVERIFIED — NO ATTENDANCE`**. **No attendance record exists** |

## 9. Raw network data must not leave the module

**`ATT-AC-218`** requires a test asserting that the presence facts exposed for
composition contain **no** SSID, BSSID, signal strength, MAC address or other
network datum, **and that no consumer can obtain one through the exposed path**.

`ATT-BR-045` and `SEAT-BR-020` bar the shortcut from the other side, and
`SEAT-FR-108` assigns verification logic to `BC-03` — so relocating it into the
seating context would violate the frozen seating PRD as well.

## 10. Session duration and Study Hours

**Verified session duration is recorded** (§10A.6, `D-11`) — *"subject to the ARB
question it leaves open"*, which remains open and **MUST NOT** be closed by an
implementer.

**Aggregation is not this module's job.** `ATT-FR-146`: `BC-26` owns metrics.
Study Hours count **only verified presence inside the booked shift** — see
[`DOMAIN_RULES.md`](./DOMAIN_RULES.md) §8 and the 05:50→10:10 worked example
(**exactly 4 hours**), verified by `ATT-AC-221`.

## 11. Location Verification is optional (§10A.12, `D-21`)

**Default OFF**, per-library, Owner **and** Manager configurable. When enabled it
is an **additional signal, never the sole identity proof**. A **denied location
permission MUST NOT destroy all attendance capability** — the other six modes
remain (`ATT-BR-008`), and the failure **MUST be distinguishable rather than
silent** (`ATT-NFR-005`, `ATT-FR-036`).

**The order of reasoning is fixed by the decision itself:** *"First establish
whether the chosen Wi-Fi verification mechanism actually requires location."*
Until `ADR-0027` answers that (`R-15`), any permission is *"a conditional
dependency of a mechanism that has not been selected"* — **not** a requirement of
this capability.

## 12. Existing attendance is untouched

§10A.11. Wi-Fi Presence is **additive**. All six existing modes and `ATT-BR-007`
are preserved verbatim, and `FIXED_QR_WIFI` is **not** reinterpreted.

## 13. Implementation checklist

- [ ] Observation flow is `NetworkCallback` → local queue (`E-24`) →
      `WorkManager` reconciliation → derived state. No other scheduler.
- [ ] **No** timer, **no** polling, **no** `startScan()`, **no** mandatory
      foreground service.
- [ ] Status computed as a **predicate**, recomputable on read.
- [ ] **No** periodic interval, latency or throughput figure in code or config.
- [ ] **No** network verification mechanism chosen — `ADR-0027` owns it.
- [ ] **No** raw Wi-Fi datum crosses the module boundary.
- [ ] Device–account association **required**, never inferred.
- [ ] Multi-device is **OR**; T0 = all devices lost.
- [ ] Replay is **idempotent** and never overwrites a correction.
- [ ] Location Verification defaults **OFF** and its denial degrades **visibly**.
