# ANDROID_BACKGROUND_BEHAVIOUR — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md) §10A.4, §10A.5, §10A.10 (**FROZEN**) · `ADR-0028` (**`Proposed`** — see §7).

---

## 1. The central fact

> **Android background execution is NOT guaranteed on every device, and this
> document states that as a fact rather than a caveat.**

That sentence is from the frozen PRD. The whole design follows from it: because
background execution cannot be relied upon, **presence state is derived from
recorded observations** rather than maintained by a running process.

## 2. Detection model — `D-14` = C

The student **MUST NOT** be required to keep the Liboora app visibly open
continuously. Detection is:

> **app-open detection, plus periodic/background-aware checks, plus reconciliation
> and filling of legitimate gaps**

Reconciliation is *"already half-solved"* by the offline policy in §27.1
(`ATT-PO-011` … `ATT-PO-013`), *"which absorbs a replayed punch by idempotency
rather than applying it twice."*

## 3. The platform-event table — required behaviour and prohibitions

§10A.10 specifies these *"so no implementer supplies them differently"*.

| Platform event | What happens | What **MUST NOT** happen |
|---|---|---|
| **Force-stop** by the user | Background execution stops · `WorkManager` stops · `NetworkCallback` stops · **no presence claim is made for the unobserved period**. On next app open, **reconciliation occurs** | A presence claim for the unobserved period |
| **OEM background restriction** (battery optimiser, vendor policy) | Observations may be **delayed, batched or dropped** | **Fabricated presence.** A restriction **MUST NOT** produce evidence — and it **MUST NOT** be reported as the student's fault |
| **Device reboot** | Callbacks are **not re-registered** until the app or an authorised receiver runs | **Inferring an exit at the reboot instant** — the fourth prohibited assumption in §10A.5 |
| **Permission revoked** mid-session | Verification **can no longer be performed** | **Continuing to assert verified presence** · **asserting an exit** |

**Every one of these four paths leads to the same safe outcome when observations
simply stopped:** `INCOMPLETE / EXIT NOT VERIFIED` (§10A.4a **row 2**) — never a
computed exit instant.

## 4. Mechanisms explicitly NOT used

> **No polling loop, no Wi-Fi scanning, no server timer and no mandatory
> foreground service is specified.**

| Mechanism | Status | Reason |
|---|---|---|
| **Polling loop** | Not used | The model is event-driven plus reconciliation |
| **`WifiManager.startScan()`** | **Not used** | *"throttled by the platform"* |
| **Server timer** | **Not used** | §10A.4 is a **predicate**, not a schedule |
| **Foreground service** | **NOT required** | It *"would buy **punctuality** that the derived-state model of §10A.4 does not need, at the cost of a persistent notification."* Whether one is nonetheless warranted is **`ADR-0028`'s question, not this document's** |

**Do not add a foreground service to make the 5-minute rule punctual.** The rule
does not need punctuality — see §5.

## 5. `WorkManager` is EVENTUAL, never PUNCTUAL

> **`WorkManager`'s guarantee is EVENTUAL, never PUNCTUAL.** It is used for
> **reconciliation**, and the 5-minute rule **MUST NOT** be built on it as a
> deadline. That is why §10A.4 is a predicate over observations rather than a
> timer.

This is the single most important implementation consequence in this document. The
grace period is evaluated **when the session is read or reconciled**, so a late or
skipped worker changes **when** the state is observed, not **what** the state is.

The authorised path, and nothing beyond it:

```
NetworkCallback → V1 Local Write Queue (BC-30, via the already-authorised E-24)
               → WorkManager reconciliation → backend-derived state
```

> **No other scheduler, no periodic interval and no `Job Runtime` dependency is
> introduced.**

## 6. What is NOT promised, and MUST NOT be

| Not promised | Source |
|---|---|
| **No periodic-check interval is stated.** `D-14` explicitly withholds it — *"Do not invent the periodic-check interval."* | §10A.10 |
| **No latency or throughput figure.** `ATT-NFR-003` forbids one while **`ATT-GAP-017a`** is open | §10A.10 |
| **Android background execution is NOT claimed to be guaranteed on every device.** `ADR-0028` frames the platform question and *"its permission matrix is six columns of 'To be decided'"* | §10A.10 |
| **No OS permission, service type or scheduling mechanism is specified.** `ATT-FR-044` remains the only OS-permission line, and it concerns **mode 4** | §10A.10 |
| Where platform restrictions prevent reliable background execution, the approved `D-14` architecture governs. **"This document promises no behaviour the platform may be unable to deliver."** | §10A.10 |

**Do not pick an interval, a service type, or a permission set to "complete" the
design.** Each is reserved.

## 7. `ADR-0028` is `Proposed` — non-binding

`ADR-0028` *Android background presence detection* is **`Proposed`**, which
`ADR-INDEX.md` defines as *"Under consideration; **not binding**"*.

**Read it for context; do not implement its options as rules.** Its permission
matrix is explicitly unresolved. The binding statements about Android behaviour are
the ones in the **frozen PRD** §10A.10, reproduced above.

## 8. Location permissions

§10A.12, decision **`D-21`**. **Location Verification is OPTIONAL, default OFF.**

- **`ACCESS_FINE_LOCATION` and `ACCESS_BACKGROUND_LOCATION` are NOT added as
  mandatory permissions**, and **MUST NOT** be forced on every student.
- A **denied location permission MUST NOT destroy all attendance capability** —
  the other six modes remain (**`ATT-BR-008`**: no smartphone is required to attend
  at all).
- The failure **MUST be distinguishable rather than silent** — **`ATT-NFR-005`,
  `ATT-FR-036`**.
- Order of reasoning, fixed by the decision: *"First establish whether the chosen
  Wi-Fi verification mechanism actually requires location."* Until `ADR-0027`
  (`Proposed`) answers that, a permission is *"a conditional dependency of a
  mechanism that has not been selected."*

## 9. User-facing consequences

| Situation | Required treatment |
|---|---|
| An OEM dropped observations | **MUST NOT** be reported as the student's fault |
| Observations stopped for any reason | `INCOMPLETE / EXIT NOT VERIFIED` — **MUST NOT** be presented as suspicious. *"Causes are named, and none of them is fraud"* |
| Permission denied | Visible, distinguishable degradation — **no silent downgrade** |
| Verification unavailable | **MUST NOT** continue asserting verified presence, **MUST NOT** assert an exit |

## 10. Implementation checklist

- [ ] **No** foreground service required for the grace rule.
- [ ] **No** timer, **no** polling, **no** `startScan()`.
- [ ] `WorkManager` used **only for reconciliation**, never as a deadline.
- [ ] **No** periodic interval hard-coded or configured.
- [ ] Force-stop → **no** presence claim for the unobserved period; reconcile on
      next open.
- [ ] Reboot → **no** exit inferred at the reboot instant.
- [ ] Permission revoked → stop asserting presence **and** do not assert an exit.
- [ ] OEM restriction → **never** fabricate presence, **never** blame the student.
- [ ] All four platform events converge on **`INCOMPLETE / EXIT NOT VERIFIED`**
      when observations merely stopped.
- [ ] **No** location permission added as mandatory; the other six modes survive
      denial.
- [ ] Session status **recomputable** from stored observations at any time
      (frozen `SEAT-FR-116`).
