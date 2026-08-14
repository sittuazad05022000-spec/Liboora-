# ATTENDANCE_STATE_MACHINE — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT.md) §10A.1, §10A.2, §10A.4, §10A.4a, §10A.5 (**FROZEN**).

> **This is the highest-risk logic in the module.** Four of the five "rules that
> bite first" live here. Read §3 (grace) and §4 (exit precedence) before writing
> any session code.

---

## 1. The nine stored statuses

The complete stored vocabulary is **nine strings** and no more. See
[`DOMAIN_RULES.md`](./DOMAIN_RULES.md) §4 for the full table with sources. In
short:

`VERIFIED PRESENCE` · `SCHEDULE MISMATCH` · `SESSION ENDED` ·
`INCOMPLETE / EXIT NOT VERIFIED` · `UNKNOWN DEVICE / UNVERIFIED PRESENCE` ·
`VERIFIED MEMBER` · `UNVERIFIED — NO ATTENDANCE` ·
**`NO BOOKED SHIFT / PRESENCE UNASSIGNED`** ·
**`SHIFT OVERSTAY / PRESENCE OUTSIDE BOOKED WINDOW`**

Rows **8** and **9** were added by `D-20` and are **stored, not derived**.

## 2. Session lifecycle

```
                 device associated with account, on authorized network,
                 network verified by the approved mechanism (ADR-0027, Proposed)
                                        │
                                        ▼
                              ┌──────────────────┐
                              │ VERIFIED PRESENCE│◄──────────────┐
                              │  (session open)  │               │
                              └────────┬─────────┘               │
                                       │                          │
                    ALL valid devices lose verified presence      │  ANY valid device
                                       │                          │  regains presence
                                       ▼                          │  within 5 min
                                  ══ T0 ══                        │  → SAME session
                                       │                          │
                            T0 → T0 + 5 min                       │
                              (recoverable) ─────────────────────┘
                                       │
                            still no valid device
                                       │
                                       ▼
                              ┌──────────────────┐
                              │  SESSION ENDED   │  ← Wi-Fi-based exit detection
                              └──────────────────┘

  reconnect AFTER the session has already ended
      → a new session MUST NOT be created *merely* because a device reconnected.
        The ended session stays ended; new presence is evaluated on its own terms.
```

## 3. The 5-minute disconnect rule — `D-15`

> **The grace period is EXACTLY 5 MINUTES.** This value was supplied by the
> Product Owner. It is **not** derived, inferred, or defaulted, and it **MUST
> NOT** be widened, narrowed or made configurable without a further decision from
> the same authority.

| Phase | Rule |
|---|---|
| **T0** | The instant **all** valid registered devices lose verified Wi-Fi presence. The grace period starts **here — not when the first device disconnects** |
| **T0 → T0 + 5 min** | The session is **recoverable**. A brief disconnect **MUST NOT** immediately end it. If **any** valid registered device regains verified presence, the **SAME** session continues |
| **After T0 + 5 min**, no valid device | **`SESSION ENDED`** |
| **Reconnect after the session already ended** | A new session **MUST NOT** be created *merely* because a device reconnects |

### 3.1 Two prohibitions with teeth

**No second grace period exists.** The specification defines *"exactly one, of
exactly this length"*, and **MUST NOT** introduce another for reconnection, for
re-verification, or for session closure.

**No server timer implements this rule.**

> The 5 minutes is a **predicate over recorded observations**, evaluated when the
> session is read or reconciled — **never a scheduled job.**

This is a design constraint, not an optimisation. Frozen `SEAT-FR-116` already
requires the `BC-03` open-session set to be **recomputable**; a derived predicate
satisfies that, and *"a timer would not be needed to satisfy it."*

The observation path is fixed:

```
NetworkCallback → V1 Local Write Queue (BC-30, via the already-authorised E-24)
               → WorkManager reconciliation → backend-derived state
```

**No other scheduler, no periodic interval and no `Job Runtime` dependency is
introduced** (§10A.10, `ADR-0028`).

## 4. Exit precedence — `SESSION ENDED` vs `INCOMPLETE / EXIT NOT VERIFIED`

§10A.4a. **Evaluate in order. The first matching row wins.**

| # | Condition | Status | Exit method | Note |
|---|---|---|---|---|
| **1** | A **physically verified exit** exists (check-out, Manual, §18 correction) | **`SESSION ENDED`** | *Physically verified exit* | **A human act beats every inference** |
| **2** | **No** valid loss observation was received, and observations simply **stopped** — process killed, **force-stopped**, device rebooted, permission revoked, OEM background restriction | **`INCOMPLETE / EXIT NOT VERIFIED`** | **none** | See §5 |
| **3** | A **valid loss observation** was received for the last remaining valid device, and no valid device regained presence within the 5 minutes | **`SESSION ENDED`** | *Wi-Fi-based exit detection* | The normal automatic exit |
| **4** | A valid loss observation was received and **any** valid device regained presence within the 5 minutes | **`VERIFIED PRESENCE`** — the **SAME** session | not applicable | §10A.4; **no** second grace |
| **5** | The session is still open and at least one valid device holds verified presence | **`VERIFIED PRESENCE`** | not applicable | Nothing has ended |
| **6** | The outcome cannot be placed in rows 1–5 on the evidence recorded | **`INCOMPLETE / EXIT NOT VERIFIED`** | **none** | *"The safe default is the one that fabricates nothing"* |

### 4.1 Rows 1 and 3 are both `SESSION ENDED` — and MUST NOT be conflated

The two are **different facts that share a status**. The specification requires
that a Wi-Fi-based exit and a physically verified exit **MUST NOT** be:

- conflated,
- merged,
- displayed identically, or
- **stored as the same value**.

Row 1 records *"physically verified exit"*; row 3 records *"Wi-Fi-based exit
detection"*. Keep the **exit method** as its own field.

## 5. Never fabricate an exit — §10A.5

Row 2 exists because the tempting implementation is the forbidden one. Where an
exit cannot be reliably verified the status is **`INCOMPLETE / EXIT NOT
VERIFIED`**, and:

> Do **not** close the session at the *"last known network event"* and call it an
> exit. That is the fabrication §10A.5 prohibits.

**Causes are named, and none of them is fraud.** An `INCOMPLETE / EXIT NOT
VERIFIED` outcome arises from process death, force-stop, reboot, OEM restriction
or revoked permission. It **MUST NOT** be presented to a student or to staff as
suspicious.

Verified by **`ATT-AC-220`**: a gap containing no observation yields
`INCOMPLETE / EXIT NOT VERIFIED` rather than a computed exit instant, and the
exposed presence facts carry **no invented exit timestamp**.

## 6. Worked outcomes (§10A.7b examples)

| # | Scenario | Outcome |
|---|---|---|
| 4 | 06:00 connect · 09:20 disconnect · **no reconnect** | After the grace the session is **non-recoverable**. If the configured Wi-Fi exit method qualifies → **`SESSION ENDED`** with the exit fact recorded |
| 5 | **No booked shift** · Wi-Fi verified | **`NO BOOKED SHIFT / PRESENCE UNASSIGNED`** (row 8). **Not** `VERIFIED PRESENCE` |
| 6 | Shift 06:00–10:00 · connected 19:00 | **Not** normal `VERIFIED PRESENCE`. Row 9 or row 2, per the precedence table |

## 7. Events emitted by state transitions

Only **two** of the four events relate to session state, and the mapping is
deliberately narrow:

| Transition | Event | Note |
|---|---|---|
| Attendance recorded (session opens) | **`attendance.StudentCheckedIn`** (`ATT-EVT-001`) | Carries `method` — the input `ATT-AC-214` uses to distinguish manual from verified |
| A **real recorded exit** | **`attendance.StudentCheckedOut`** (`ATT-EVT-002`) | Only for a real exit |
| **Entering the grace period** | **NO EVENT** | `ATT-AC-217`: entering grace, or any presence change that is not an exit, emits **no** `StudentCheckedOut` |
| Any other presence state change | **NO EVENT** | The surface is closed at four (`ATT-FR-134`). The Seat Card reads instead — see [`SEAT_CARD_INTEGRATION.md`](./SEAT_CARD_INTEGRATION.md) |

## 8. Implementation checklist

- [ ] T0 is *"all devices lost presence"*, **not** *"a device disconnected"*.
- [ ] The 5 minutes is a **predicate over observations**, not a timer or job.
- [ ] Reconnect inside grace continues the **SAME** session — no new session, no
      new check-in event.
- [ ] Reconnect after end does **not** resurrect the session.
- [ ] Exit precedence is evaluated **in order**, row 1 first.
- [ ] **Exit method is stored** so Wi-Fi exit ≠ physically verified exit.
- [ ] Silence yields `INCOMPLETE / EXIT NOT VERIFIED`, never a computed exit
      instant.
- [ ] `INCOMPLETE / EXIT NOT VERIFIED` is **never** rendered as suspicious.
- [ ] Entering grace emits **no** `StudentCheckedOut`.
- [ ] Multi-device is **OR** — one session regardless of device count.
- [ ] No second grace period anywhere in the code.
