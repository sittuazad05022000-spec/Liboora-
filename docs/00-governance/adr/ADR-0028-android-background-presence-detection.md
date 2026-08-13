# ADR-0028 — Wi-Fi presence detection needs an Android execution and permission model, and `PRD-006` contains none

| Field | Value |
|---|---|
| **Status** | **Proposed** — not binding. *(`ADR-INDEX.md` status vocabulary: "Under consideration; not binding")* |
| **Date** | 2026-08-05 |
| **Deciders** | **Architecture owner (ARB) + platform owner** — a platform-wide rule, named in `ADR-INDEX.md` Process step 1. **Product owner** input required on the acceptable degree of automation (see §6) |
| **Supersedes** | Nothing |
| **Amends** | **Nothing.** `PRD-006` is byte-identical |
| **Baseline** | **None issued.** Baseline remains **`BASELINE-2026-08-04-E`** |
| **Closes** | **Nothing** |
| **Related** | `ATT-FR-002` (L216) · `ATT-XC-021` · `ATT-PO-011` (L1697) · `ATT-NFR-003` (L1652, `ATT-GAP-017a`) · `ATT-FR-044` (L739) · `ATT-NFR-005` (L1660) · `ATT-BR-008` (L529) · `ATT-NFR-014` (L1673) · `ATT-FR-088` (L1055) · `ATT-FR-090`…`095` · `ATT-NFR-001`/`002` · `ADR-0027` (R-8) |

> ⚠️ **`Proposed`. This ADR maps a void and proposes nothing to fill it.**
>
> Measured on `PRD-006` v1.4 (~2400 lines):
> ```
> grep -in "android"                          → 0 hits
> grep -in "background|foreground service"    → 0 hits
> ```

---

## 0. Product Owner decisions recorded — a row on §6's spectrum was chosen; **no interval was supplied**

> **This section records Product Owner answers. It does not change this ADR's status.** The execution model, the
> permission matrix and every numeric value remain **Architecture Owner (ARB) + platform owner** decisions. This ADR
> remains **`Proposed`**.

| PO decision | Question asked | Answer as given |
|---|---|---|
| **`D-14`** | D5 — how is presence detected? | **C** — app-open detection **+** periodic/background-aware checks **+** reconciliation. *"**Do not invent the periodic-check interval.** Do not claim Android background execution is guaranteed on every device."* |
| **`D-15`** | D6 — disconnect grace | **EXACTLY 5 MINUTES**; abandoned status **`INCOMPLETE / EXIT NOT VERIFIED`** |

### 0.1 `D-14` selects **row 3** of §6's spectrum

§6 offered four models and declined to choose. The Product Owner has now chosen, and the answer maps onto **row 3**:

| Model (§6, verbatim) | Status after `D-14` |
|---|---|
| Fully background, no user action | **not selected** — and `D-14`'s own clause forbids claiming it is guaranteed |
| Background detection + user-visible ongoing indicator | **not selected**, not excluded as an implementation detail of row 3 |
| **Opportunistic detection on app open / periodic wake, with reconciliation** | ✅ **SELECTED** — *"app-open detection + periodic/background-aware checks + reconciliation"* |
| Explicit user action (student taps to start/end presence) | **not selected** |

**§6's tension is resolved in the honest direction.** This ADR recorded that *"the lower rows are more reliable, and
the upper rows are what the Product Owner asked for"*, and that a move down the spectrum would be *"a legitimate scope
refinement, not a failure."* `D-14` is exactly that move: it takes the moderate-automation, low-platform-risk row
rather than insisting on the top one. The phrase **"background-aware"** — the Product Owner's word — is read as
*aware of and tolerant of background restriction*, not as an assertion that background execution works.

**`D-14` also settles B-8 in principle.** *"Reconciliation"* is named explicitly as part of the model, which
corroborates §7's finding that this behaviour is *"already half-solved"*. **B-8's mechanism is still not specified**,
and §7's open portion is unchanged.

### 0.2 ⛔ REMAINING ARCHITECTURE + PLATFORM DECISIONS — the substance of this ADR, still open

**`D-14` chose a shape. It supplied no value and no mechanism.** Specifically, all of the following remain open:

- **The periodic-check interval.** The Product Owner **prohibited** inventing it: *"Do not invent the periodic-check interval."* None is stated here, in `PRD-006`, or anywhere else. §5 constraint **C-3** independently forbids it — `ATT-NFR-003` states no latency or throughput figure, an omission carried as `ATT-GAP-017a`. **Two independent prohibitions now cover the same number, and it is not written.**
- **B-1, B-2, B-4, B-5, B-6, B-7, B-9** — §3's behaviours remain 🔴 absent or ⚠️ partial exactly as tabulated. Choosing row 3 does not describe how a connectivity change is observed, what happens at each background limit, or what a reboot does.
- **§4's permission matrix** — every *"To be decided"* cell is still to be decided. `D-14` names no permission and no API level.
- **No timeout, backoff, retry count or battery budget** — none proposed, per §10.

### 0.3 What `D-15`'s five minutes is, and what it is **not**

`D-15` fixes a **grace duration**: after **all** of a student's valid devices lose presence, five minutes elapse
before the session is treated as ended. It is written into `PRD-006` §10A.4 with its T0 defined, and the abandoned
status string is `INCOMPLETE / EXIT NOT VERIFIED`, one of the seven fixed strings.

> **Five minutes is not a detection interval, and must not be reused as one.** A grace period says how long to wait
> before concluding a session ended; a check interval says how often to look. They are different quantities with
> different owners — the first is the Product Owner's and is now answered, the second is the platform owner's and is
> **deliberately unanswered**. Inferring the second from the first would be inventing the value `D-14` prohibits.

`PRD-006` §10A.4 also records that **no second grace period exists**, so nothing here introduces one.

### 0.4 The prohibition on overclaiming, honoured

*"Do not claim Android background execution is guaranteed on every device."* No such claim is made here or in
`PRD-006`. §1's measured void, §5's C-1 and C-2 accessibility constraints, and §6's platform-risk column all stand
unamended. `PRD-006` §33.1 records background detection as **V1 scope that is not yet buildable**, and §10A.10 states
what the student experience does **not** promise — neither document asserts reliability this ADR has no basis to
assert.
> The only OS-permission line in the entire document is `ATT-FR-044` (L739), which covers **denied location
> permission**. There is nothing else to build on and nothing to contradict.

---

## 1. Context

Option B requires (§12) that *"the student should **NOT** be required to keep the Liboora UI open continuously"*, while
simultaneously instructing *"**DO NOT** assume unrestricted Android background execution."*

Those two statements are both correct and together define the problem: presence must be detected without a foreground
UI, on a platform that deliberately restricts exactly that.

`PRD-006` is silent by design, and the silence is fenced by three rules that this ADR does **not** disturb:

| Rule | Effect |
|---|---|
| `ATT-FR-002` (L216) | The module owns no configuration and no device lifecycle |
| `ATT-XC-021` | Device lifecycle is excluded from this module's scope |
| `ATT-PO-011` (L1697) | The module **defines the offline/reconnect policy** and **MUST NOT** implement the queue or replay machinery |

`ATT-PO-011` is the important one: it means this ADR's output is a **policy**, and the mechanism belongs to the
platform layer. That division already exists and is respected here.

## 2. The question

**What Android execution model and permission set support Wi-Fi presence detection, within real platform
restrictions, without requiring a permanently open UI?**

## 3. The nine behaviours that must be specified

Taken from the Product Owner's §12 and §15. Each is currently **unspecified** in `PRD-006`.

| # | Behaviour | Currently in `PRD-006`? |
|---|---|---|
| B-1 | Wi-Fi connectivity change detection | 🔴 absent |
| B-2 | Background execution limits and what happens at each limit | 🔴 absent |
| B-3 | Permission requirements and request timing | ⚠️ only `ATT-FR-044` for denied location |
| B-4 | App restart behaviour | 🔴 absent |
| B-5 | Device reboot behaviour | 🔴 absent |
| B-6 | Connectivity loss and recovery | ⚠️ `ATT-PO-011` sets policy ownership, no behaviour |
| B-7 | Delayed / late-arriving events | ⚠️ `ATT-FR-090`…`095` give idempotency, not lateness semantics |
| B-8 | Reconciliation of missed transitions | 🔴 absent |
| B-9 | Battery impact | 🔴 absent |

## 4. Permission matrix — structure required, values deferred

The Product Owner's §13 requires a six-column matrix. The **structure** is fixed here; the **contents** require
platform input, because Android behaviour varies by API level and the environment targets **API 35**.

| Permission | Purpose | Required / Optional | When requested | Android version considerations | Behavior when denied |
|---|---|---|---|---|---|
| Network / Wi-Fi state access | Detect whether the device is on an authorized network | **To be decided** — depends on `ADR-0027`'s chosen family | **To be decided** | **To be decided** — access to network details has tightened across API levels | Must fail with a **distinguishable reason**, never a generic error (`ATT-NFR-005`), and **MUST NOT** silently downgrade (`ATT-FR-036`) |
| Location (foreground) | Only if `ADR-0027` selects a family that requires it, **or** if the tenant enables optional location verification | **Optional** — `ATT-CFG-010` default **Unset** | Only when the tenant has enabled location verification | Reading certain network details has historically required location permission — **must be confirmed by platform input, not assumed** | `ATT-FR-044` (L739) **already specifies** the denied-location path. Reuse it; do not invent a new one |
| Location (background) | Continuous location while the app is not in use | **Presumed NOT required** | — | Subject to the strictest platform review | **Preference recorded, not decided:** the request says *"only if genuinely required and legally/platform-permitted"*; §13 says *"location permission should remain conditional where technically possible"* |
| Background execution / foreground-service entitlement | Detect connectivity changes without an open UI | **To be decided** | **To be decided** | Central to B-2; strongly version-dependent | **To be decided** |
| Notification (if a user-visible ongoing indicator is required) | Platform requirement that accompanies some background modes | **To be decided** | **To be decided** | Depends on the execution model chosen | **To be decided** |

**Every "to be decided" above is deliberate.** Filling them would mean asserting Android platform behaviour and a
permission policy without platform input — precisely what §23 prohibits.

## 5. Constraints that already bind, and are not negotiable

| # | Constraint | Source |
|---|---|---|
| C-1 | A student **MUST NOT** be required to have a smartphone in order to attend | `ATT-BR-008` (L529) |
| C-2 | Manual attendance accessibility **MUST NOT** get worse — *"the students served by Manual are those least served by devices"* | `ATT-NFR-014` (L1673) |
| C-3 | No latency or throughput figure may be stated (that omission is `ATT-GAP-017a`) — **so no scan interval, backoff or timeout may be invented here** | `ATT-NFR-003` (L1652) |
| C-4 | Session timestamps come from the platform time port, never the device clock | `ATT-FR-088` (L1055) |
| C-5 | An end timestamp **MUST NOT** be fabricated | `ATT-BR-030` (L1025) |
| C-6 | Every failure reason must be distinguishable | `ATT-NFR-005` |
| C-7 | The module defines policy; it does not implement the queue/replay machinery | `ATT-PO-011` |
| C-8 | No continuous polling / heartbeat architecture | request §14; `ATT-NFR-007` already aligns |

**C-1 and C-2 together mean the Android model, whatever it is, can never become the only way to attend.** That is
already guaranteed because the six existing modes remain intact.

## 6. The honest tension the deciders must resolve

The Product Owner asks for two things that are in tension on this platform:

- *"The student should not be required to keep the UI open continuously"* (§12)
- *"Do not assume unrestricted Android background execution"* (§12)

Between them lies a spectrum, and **where on it the product sits is a Product decision informed by a platform fact**:

| Model | Automation | Platform risk |
|---|---|---|
| Fully background, no user action | highest | highest — most exposed to OS restriction, doze, vendor battery managers |
| Background detection + user-visible ongoing indicator | high | moderate — usually more durable, but more intrusive and may require extra permission |
| Opportunistic detection on app open / periodic wake, with reconciliation | moderate | low |
| Explicit user action (student taps to start/end presence) | lowest | lowest — no background entitlement at all |

**This ADR does not choose.** But it records the consequence plainly: **the lower rows are more reliable, and the
upper rows are what the Product Owner asked for.** If the platform owner reports that the top row is not dependable
on API 35, the Product Owner must choose a lower row — and that is a legitimate scope refinement, not a failure.

Note the connection to `ADR-0025` §4.2: if the model chosen here requires a user action anyway, then the
"confirmation-step" attendance variant becomes materially cheaper, because it no longer subtracts anything the user
was not already doing.

## 7. Reconciliation — the part that is already half-solved

B-7 and B-8 are the least blocked behaviours, because the existing rules already provide the machinery:

- `ATT-FR-090`…`ATT-FR-095` — idempotency keys, replay tolerance, duplicate suppression.
- `ATT-NFR-001` / `ATT-NFR-002` — concurrent contention and opening-hour burst behaviour.
- `ATT-FR-088` — authoritative server time, so a late event can be placed correctly on the timeline.
- `ATT-BR-030` — a missing end must **not** be fabricated, which tells reconciliation what it may *not* do.

What is missing is only the **policy**: how long a session may remain open without a signal, and what an unresolved
open session becomes. Both are numeric or state decisions and are **not** invented here — they appear on the decision
sheet instead.

## 8. Decision

**None. Deferred to the Architecture owner + platform owner, with a Product owner input on §6.**

The accepting decision must fill B-1…B-9, complete the §4 matrix, and state the reconciliation policy without
violating C-1…C-8.

## 9. Consequences

- **If accepted:** `PRD-006` gains a platform-behaviour section and a permission matrix; `ATT-XC-021`'s fence is amended to admit a bounded exception; `ATT-GAP-017a` may need a latency figure, which is its own product decision.
- **If left `Proposed`:** presence detection cannot be implemented, because there is no lawful description of how the app learns about a Wi-Fi change. Existing QR, QR+Wi-Fi, GPS and Manual attendance are **entirely unaffected** — all four are foreground, user-initiated flows that never needed background execution.

## 10. What this ADR explicitly does not do

- It does **not** specify an execution model, service type or detection mechanism.
- It does **not** state which permissions are required, when they are requested, or what happens if denied — beyond reusing the existing `ATT-FR-044` for denied location.
- It does **not** propose any interval, timeout, backoff, retry count or battery budget.
- It does **not** invent a grace period. The Product Owner supplied one as `D-15`; §0.3 records it and states that it is **not** a detection interval.
- It does **not** amend `ATT-XC-021`, `ATT-FR-002`, `ATT-PO-011` or any other rule.
- It does **not** assert approval by any person or body.
- It does **not** state the periodic-check interval `D-14`'s model implies. Two independent prohibitions cover that number (`D-14`'s own clause and C-3 / `ATT-NFR-003`), and it is not written.
- It does **not** treat `D-14`'s selection of §6 row 3 as specifying B-1…B-9 or any permission — §0.2 lists what remains open.
- It does **not** claim Android background execution is guaranteed on any device, still less on every device.
- It does **not** become `Accepted` by virtue of §0. Its status is unchanged: **`Proposed`**.
