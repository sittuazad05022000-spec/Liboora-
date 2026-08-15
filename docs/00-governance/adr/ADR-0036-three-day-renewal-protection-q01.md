# ADR-0036 — Making 3-day renewal protection lawful in V1: `Q-01` is the blocking question, and the frozen PRDs were written to accept its answer

| Field | Value |
|---|---|
| **Status** | **ACCEPTED** — *"In force. Binding on all implementation"* (`ADR-INDEX.md` status vocabulary), **on questions 1 and 3 only. Question 2 remains OPEN** — tracked as the unnumbered *window boundary* row of **§7.3**, deliberately **without** a new `MM-GAP-*` identifier (see §8.3). **ACCEPTED by direct conferral of Architecture Owner authority by the human principal** on the `ADR-0032` §5.2 / `ADR-0033` precedent — **no ARB quorum, attendee list, sign-off date or Security review is asserted.** **This is a PARTLY ACCEPTED record and says so in its own status row**, because accepting all three questions when only two were answered would be the more convenient and less true reading. Superseded status text, retained per Process step 3: *"**PROPOSED** — Recorded, not in force. **This ADR is not self-accepted.** It records findings and asks **three** questions of named authorities."* See **§8.2** |
| **Date** | 2026-08-05 |
| **Raised by** | V1 product requirement: *"3-DAY RENEWAL PROTECTION MUST BE PART OF V1 … DO NOT downgrade it to V2"*, against frozen `PRD-005` Membership Management and frozen `PRD-007` Seat Management |
| **Decision by** | **Architecture Owner + `BC-04` owner** jointly for `Q-01` (`MM-GAP-001` assigns it in those words) · **Product Owner** for the protection semantics · **`BC-25` configuration authority** for any parameter identifier |
| **Supersedes / amends** | **Nothing yet.** No frozen document is modified by this ADR. **No requirement identifier is created. No configuration identifier is created. No seat state, aggregate, event, edge or permission is created.** It identifies the *minimum* amendment that the requirement would need **if** the authorities rule as §6 recommends |
| **Governs** | 3-day renewal protection (V1) · `Q-01` · `SEAT-GAP-003` · `MM-GAP-001` · `FEE-GAP-013` (renewal-protection portion) |

> **The headline, stated before any detail: the requirement is NOT forbidden by the frozen architecture, and a
> previous review of mine said it was. That review was wrong, and the correction matters more than the conclusion.**
>
> `PRD-008` §39.2, written at v0.9 on 2026-08-05, recorded that frozen `MM-XC-012`, `MM-FR-100` and `MM-FR-111`
> *"forbid"* the behaviour. Re-measured against the surrounding definitions rather than the identifier lines alone,
> that finding **conflated three different things**:
>
> | Thing | Frozen status | Does it block 3-day protection? |
> |---|---|---|
> | **Money arithmetic** — prorated credits, refunds, term deduction | ⛔ Forbidden in V1 (`MM-XC-012`, `MM-FR-100`) | **No.** Protection needs no money arithmetic |
> | **Entitlement extension** — validity beyond `endDate` | ⛔ Forbidden in V1 (`MM-FR-111`) | **No, if protection confers no entitlement** |
> | **Seat release timing after expiry** | ❓ **OPEN — `Q-01`**, and *explicitly* not decided by either frozen PRD | **YES. This is the actual blocker** |
>
> **The frozen PRDs do not forbid a protection window. They decline to decide when an expired membership releases a
> seat, and they say so in those words.** `MM-FR-112`: *"Seat reclamation after expiry **MUST** be `BC-04`'s
> decision … This module **MUST NOT** specify when the seat is released."* `SEAT-BR-024` and its rationale go
> further: the seat PRD is *"written to be correct under any resolution"* of `Q-01`, *"because the release action
> becomes a policy-driven trigger over an already-flagged allocation rather than a redesign."*
>
> **So the requirement does not need a frozen rule to be broken. It needs an open question to be answered.** That
> is a materially different — and much cheaper — governance act, and it is why this ADR does not propose amending
> `MM-FR-111` or `MM-XC-012` at all.

---

## 1. The requirement, stated exactly as received

> *"When a membership expires, the existing student receives a 3-calendar-day renewal protection window. During this
> protection window: the student's protected membership/seat rights MUST remain protected …; another student MUST NOT
> be incorrectly allocated the protected seat; the system must clearly distinguish protected/renewal state from
> available state; renewal must remain possible …; no hidden penalty; no arbitrary fee; no silent term deduction."*

Worked example, as supplied: membership due **5 August** → protection window **5 August → 8 August**.

**And the binding constraint on how it may be satisfied:** *"If existing frozen Membership/Seat architecture
currently prohibits this behaviour, DO NOT violate the frozen rule … preserve 3-day protection as the V1 product
requirement … amend the minimum necessary rule … do NOT downgrade to V2."*

---

## 2. What was measured, with line references

### 2.1 The membership side declines to decide seat release

| Source | Line | Text measured | Bearing |
|---|---|---|---|
| `PRD-005` (FROZEN) | **L191** | `MM-XC-012` — *"Proration arithmetic executed as money (**V2**…)"* | Forbids **money**. Protection needs none |
| `PRD-005` (FROZEN) | **L759** | `MM-FR-100` — *"**MUST NOT** compute a prorated monetary credit … **MUST NOT** compute a refund"* | Forbids **money**. Protection needs none |
| `PRD-005` (FROZEN) | **L814** | `MM-FR-111` — *"V1 **MUST NOT** implement a grace period that extends **entitlement** beyond `endDate`"* | Forbids **entitlement extension** — see §3 |
| `PRD-005` (FROZEN) | **L820-823** | *"Note also **what** `Q-01` asks: it is about **seat release** timing …, **not** about extending membership validity. Even when settled, it may confer **no entitlement extension at all**"* | **Decisive.** The frozen document itself separates the two, and anticipates exactly this case |
| `PRD-005` (FROZEN) | **L825** | `MM-FR-112` — *"Seat reclamation after expiry **MUST** be `BC-04`'s decision … This module **MUST NOT** specify when the seat is released"* | Membership **defers** to `BC-04`; it does not prohibit |

### 2.2 The seat side already retains the seat, and was built for this answer

| Source | Line | Text measured | Bearing |
|---|---|---|---|
| `PRD-007` (FROZEN) | **L1202** | `SEAT-FR-155` — on `MembershipExpired`, the module **MUST flag** every affected active allocation | The seat is **already not released** on expiry |
| `PRD-007` (FROZEN) | **L1162** | `SEAT-BR-024` — *"An existing allocation **MUST NOT** be automatically released, truncated or moved because an eligibility input changed. It **MUST** be flagged for human resolution"* | Retention is the **frozen default** |
| `PRD-007` (FROZEN) | **L1166-1172** | *"`Q-01` … is **open** … This PRD is **written to be correct under any resolution**: retention plus flagging is valid whether the answer turns out to be immediate, end-of-day or 24-hour grace, because the **release action becomes a policy-driven trigger over an already-flagged allocation rather than a redesign**"* | **Decisive.** A grace answer is *pre-authorised in design*, and needs **no redesign** |
| `PRD-007` (FROZEN) | **L2157** | Edge case 4: *"The allocation is **not** auto-released. It is flagged and enters the expiry work queue. Release timing awaits the `Q-01` grace decision"* | The queue this requirement needs **already exists** |
| `PRD-007` (FROZEN) | **L2255** | `SEAT-GAP-003` — `Q-01`, owned by *"Architecture + this module"*; *"**Bounded.** `SEAT-FR-155` flags and queues; no automatic release happens, so **no wrong behaviour is shipped**"* | The gap is already recorded and already bounded |
| BC Map | **L540** | `Q-01` — *"Does an expired membership release the seat immediately, at end-of-day, or after a grace period?"* Recommendation: *"Configurable per tenant (`BC-25`), **default 24h grace**"* | The question's own recommendation **contemplates a grace period** |

**The seat is retained today. Nothing has to be built to stop another student taking it — `SEAT-BR-024` already
forbids automatic release, and `SEAT-BR-011` plus gate `G15` already reject allocating a seat that holds an active
allocation.** What is missing is not protection; it is the **named, bounded, 3-day policy** and the **state label**
that distinguishes *protected* from *available*.

---

## 3. Why `MM-FR-111` is not amended, and does not need to be

`MM-FR-111` forbids *"a grace period that **extends entitlement** beyond `endDate`."* The word doing the work is
**entitlement**. The frozen document defines what it protects two requirements earlier:

`MM-FR-109` — *"An `Expired` membership **MUST NOT** confer entitlement under any read path (`MM-INV-004`)."*

**A protection window that confers no entitlement does not touch `MM-FR-111`.** Under the shape proposed in §6:

| During the 3-day window | Value | Which frozen rule this satisfies |
|---|---|---|
| Membership status | **`Expired`** — unchanged, not `Active`, not a new status | `MM-FR-109`, `MM-INV-004` |
| Entitlement conferred | **None** | `MM-FR-111` — no extension exists to forbid |
| `endDate` | **Unchanged** | `MM-FR-111` |
| Money computed | **None** — no credit, no refund, no fee, no term deduction | `MM-XC-012`, `MM-FR-100` |
| Next term length on renewal | **Full, undiminished** | `MM-XC-012` — no proration arithmetic occurs |
| What actually persists | The **seat allocation**, already retained | `SEAT-BR-024` |

**The student cannot use the library during the window.** They are expired, they confer no entitlement, and every
`BC-02` read path says so. What they retain is that **no other student is given their seat** — and that is not
entitlement, it is `BC-04` release timing, which `MM-FR-112` explicitly assigns elsewhere.

> **This is also why the product requirement's own prohibitions are satisfied automatically rather than by extra
> rules.** *"No hidden penalty · no arbitrary fee · no silent term deduction"* are all consequences of the window
> performing **no money arithmetic at all** — which is exactly what `MM-XC-012` and `MM-FR-100` already mandate.
> The frozen rule and the product requirement point the **same way** here; they are not in tension.

### 3.1 The finding that cuts against this ADR, recorded rather than omitted

Frozen `PRD-005` **§24.3 (L1719)** contains a **rejected finding** in a table titled *"Where my recommendation lost
to an existing decision"*:

| My instinct | Existing decision | Outcome |
|---|---|---|
| *"A short grace period after expiry is humane and standard"* | *"`Q-01` is **open**; Master PRD line 673 confirms it"* | *"**Existing decision preserved.** No grace period (`MM-FR-111`). Recorded as `MM-GAP-001`"* |

**A previous author proposed grace and was refused.** That refusal must be confronted, not stepped around. Read
with its stated reason, it **supports** this ADR rather than blocking it:

| The refusal said | It did **not** say |
|---|---|
| The architecture *"has **not** decided it"* | That the behaviour is wrong |
| *"A recommendation inside an open question is **not a decision**"* | That the question may not be decided |
| *"Implementing one now would both **invent a decision** and possibly invent the wrong one"* | That a decision, properly taken, is unavailable |

**The refusal was procedural, not substantive.** It refused *a PRD author inventing an answer to an open question* —
which is precisely what this ADR also refuses to do. The remedy the refusal implies is to **take the decision
through the authority that owns it**, and that is what §5 and §8 do. Had the refusal been substantive, this ADR
would have to say so and the requirement would face a genuine frozen obstacle.

Note also **who** the refusal names as owner: `MM-GAP-001` assigns `Q-01` to *"Architecture + `BC-04` owner"* — the
same two authorities §8 addresses.

---

## 4. The primitive that looks right and is not: `Reservation`

`PRD-007` **L152** defines `Reservation` as *"a time-bounded, expiring hold that **blocks acquisition but confers no
occupancy**."* Read alone, that is an almost exact description of what this requirement needs: a bounded hold, no
entitlement. **It is unusable here, and the reason is in the same frozen document.**

`SEAT-FR-155` (**L1202**), in the very requirement that handles expiry:

> *"On `membership.MembershipExpired` (`MM-EVT-005`), this module **MUST** flag every affected active allocation for
> release per `SEAT-BR-024`, and **MUST auto-cancel any unexpired reservation per A2**."*

And `SEAT-FR-125` condition **A2** (**L1000**): *"The holder's membership becomes invalid before conversion"* →
auto-cancelled.

**Membership expiry is the exact trigger that destroys a reservation.** A design that expressed the protection
window as a `Reservation` would be cancelled by frozen rule at the instant it was supposed to begin. Worse, it would
be cancelled *"per A2"* with A2 recorded as the cause (`SEAT-FR-126`), producing an audit trail that says the
student's protection was revoked for ineligibility.

There is a second, independent reason:

| Reason | Frozen source |
|---|---|
| Expiry **auto-cancels** an unexpired reservation, naming A2 as the cause | `SEAT-FR-155`, `SEAT-FR-125` A2 |
| A reservation and an allocation are **different facts** (F4 vs F5), and *"setting one **MUST NOT** implicitly clear another"* — so converting a retained allocation into a reservation would mean **releasing the allocation first**, which `SEAT-BR-024` forbids | `SEAT-BR-009`, `SEAT-BR-024` |
| `Reserved` ranks **below** `Occupied` in the `SeatState` derivation, so the seat would present as *reserved* rather than *held* | **L392-393** derivation order |

> **This is recorded because it was the attractive shortcut.** Reusing `Reservation` would have let this ADR claim
> that the requirement needs **no** new vocabulary at all — a tidier and more flattering result. It is wrong, and a
> reader who later reaches for the same shortcut needs to find the reason it fails written down.

### 4.1 What *does* already exist, measured

The retention half of the requirement is **already frozen behaviour**, and nothing needs building for it:

| Requirement clause | Already satisfied by | Status |
|---|---|---|
| *"the protected seat MUST remain protected"* | `SEAT-BR-024` — no automatic release, truncation or move | ✅ **frozen already** |
| *"another student MUST NOT be allocated the protected seat"* | `SEAT-BR-011` (one active allocation per seat per window) + gate **G16** under a pessimistic lock; `SEAT-INV-001` | ✅ **frozen already** |
| *"the system must distinguish protected state from available state"* | `SeatState` derivation rule 2: an active allocation ⇒ **`Occupied`**, never `Available` (**L392**); plus the **`Expiry-flagged`** work queue (**L1536**) | ⚠️ **partly** — see §4.2 |
| *"renewal must remain possible"* | Renewal is `BC-02`'s act, unaffected by expiry; `SEAT-XC-011` keeps it off seat screens but permits a deep link | ✅ **frozen already** |
| *"no hidden penalty / arbitrary fee / silent term deduction"* | `MM-XC-012`, `MM-FR-100` forbid the arithmetic entirely | ✅ **frozen already** |
| *"3 calendar days, then the seat is releasable"* | — nothing decides **when** release happens | ⛔ **`Q-01`** |

### 4.2 The state-label question, stated precisely

The requirement asks that *protected* be distinguishable from *available*. Two things are already true and one is
not:

1. **The seat does not present as `Available`.** An active allocation derives **`Occupied`** (**L392**), and the
   allocation is retained (`SEAT-BR-024`). So the *acquisition-blocking* half is satisfied.
2. **A human-facing distinction exists.** The `Expiry-flagged` work queue (**L1536**) lists *"allocations whose
   membership has expired, awaiting `Q-01` policy"*, and `SEAT-FR-217` guarantees a queue *"MUST NOT perform an
   automatic action on its contents."*
3. **What does not exist is a named state or flag meaning *"in renewal protection until date D"*.** `SeatState` is
   a **closed four-value derived** vocabulary (`Available`, `Reserved`, `Occupied`, `Maintenance`, **L150**) and
   `SEAT-BR-010` forbids storing it as directly settable. **Adding a fifth value would be a substantive amendment
   to a frozen invariant, and this ADR does not propose one** — §6 proposes the strictly smaller alternative.

---

## 5. The decision the requirement actually needs

**One open question, answered by its existing owners.** Not a frozen rule broken.

| | |
|---|---|
| **Question** | `Q-01` — *"Does an expired membership release the seat immediately, at end-of-day, or after a grace period?"* (BC Map **L540**; Master PRD **L673**) |
| **Recorded as** | `SEAT-GAP-003` (`PRD-007` **L2255**) · `MM-GAP-001` (`PRD-005` **L1760**) |
| **Owner, in the frozen documents' own words** | *"Architecture + `BC-04` owner"* (`MM-GAP-001`); *"Architecture + this module"* (`SEAT-GAP-003`) |
| **Status today** | **OPEN.** This ADR does **not** close it. It states what answer the V1 requirement needs, and asks the owners for it (§8) |
| **The answer the requirement needs** | *"After a grace period"* — of **3 calendar days**, not the 24 hours the open question's own recommendation suggests |

### 5.1 The one place the requirement and the existing recommendation disagree

| Source | Duration |
|---|---|
| BC Map **L540** `Q-01` recommendation | *"default **24h** grace"* |
| Master PRD **L673** | *"recommendation: configurable, default **24h**"* |
| **This V1 product requirement** | **3 calendar days** |

**This is a real disagreement and it is not resolved by preferring the newer instruction.** It is, however, a
disagreement between a **product requirement** and a **recommendation inside an open question** — and frozen
`PRD-005` **L816** already ruled on that class of conflict in this exact case: *"A recommendation inside an open
question is **not a decision**."*

So the 24-hour figure has **no binding force**, and 3 days does not override a decision — there is no decision to
override. What it does do is **answer the open question with a different value than the recommendation anticipated**,
which is precisely the kind of act that needs the owner's signature rather than an author's judgement. It is
**question 1 of §8**.

> **Two further asymmetries the owners should see, because they change the shape of the answer, not just the number.**
>
> | Recommendation says | Requirement says | Consequence |
> |---|---|---|
> | *"Configurable **per tenant** (`BC-25`)"* | Fixed default 3 days; §17 of the brief says *"Do NOT make it silently configurable"* and *"Do not invent a new configuration ID"* | **Scope differs.** Tenant-configurable and fixed-platform-default are different governance objects — see §7.2 |
> | **24 hours** — a duration | **3 calendar days** — a *calendar* span | *Calendar* days need a day boundary and a timezone rule; 24h does not. **Recorded as a gap in §7.3, not answered here** |

### 5.2 Why answering `Q-01` is sufficient, and nothing else must change

Because frozen `PRD-007` says so, in the rationale to its most load-bearing rule (**L1166-1172**):

> *"This PRD is **written to be correct under any resolution**: retention plus flagging is valid whether the answer
> turns out to be immediate, end-of-day or 24-hour grace, **because the release action becomes a policy-driven
> trigger over an already-flagged allocation rather than a redesign**."*

Read against the mechanism that already exists:

| Step | Mechanism | Exists today? |
|---|---|---|
| Expiry is detected and materialised | `MM-FR-105` scheduled transition → `MM-EVT-005` | ✅ frozen |
| The seat module hears it | `SEAT-FR-155` | ✅ frozen |
| The allocation is **flagged, not released** | `SEAT-FR-155` → `SEAT-BR-024` | ✅ frozen |
| It enters a queue that takes **no automatic action** | `Expiry-flagged` queue (**L1536**), `SEAT-FR-217` | ✅ frozen |
| The seat presents as **`Occupied`**, so no one else can take it | `SeatState` rule 2 (**L392**), `SEAT-BR-011`, gate **G16** | ✅ frozen |
| **A policy decides when the flagged allocation is released** | ⛔ **`Q-01`** | ❌ **the only missing piece** |

**Five of six links are frozen and in place. The sixth is an unanswered question, not a contrary rule.** That is the
entire finding of this ADR, and it is why §6 proposes an amendment measured in a handful of requirements rather than
a redesign.

---

## 6. The minimum amendment — recommended, **not applied**

**Nothing in this section is in force.** No frozen document is modified by this ADR, and each item below is scoped so
that a reader can see exactly how small the change is and refuse any part of it independently.

### 6.1 What must change, and where

| # | Change | Document | Kind | Why it is the minimum |
|---|---|---|---|---|
| **A1** | Record the `Q-01` answer: an expired membership's allocation is released after a **3-calendar-day** protection window, not immediately | An **ADR accepted by the Architecture Owner + `BC-04` owner** | **new decision**, closes `Q-01` | The question's owners are the only authority. No PRD may answer it — `PRD-005` L816-823 already declined to |
| **A2** | Add the release trigger over the already-flagged allocation | `PRD-007` (FROZEN) — new `SEAT-FR-*` in §22.4 | **amendment**, additive | `SEAT-BR-024` already retains and flags; this supplies only *when* the flag is actioned. **No new state, aggregate or event** |
| **A3** | Add the protection-window fact to the flagged allocation so a human and a screen can tell *protected* from *simply overdue* | `PRD-007` (FROZEN) — additive field on the existing flag, **not** a `SeatState` value | **amendment**, additive | Strictly smaller than a fifth `SeatState` value, which `SEAT-BR-010`/**L150** would make a substantive change to a closed derived vocabulary |
| **A4** | Nothing | `PRD-005` (FROZEN) | **none** | `MM-FR-111`/`MM-FR-112` are already correct: see §3. `MM-FR-112` *requires* `BC-04` to make this decision |
| **A5** | Nothing | `PRD-008`, `PRD-022` | **none** | The window computes no money (§3). `FEE-GAP-013`'s renewal-protection portion is answered by A1-A3, not by a finance rule |

**`PRD-005` is not amended at all.** That is not an oversight and it is the most important line in this table: the
membership module already says the seat decision is not its to make.

### 6.2 The amendment path, per the governance documents

| Act | Required by | Route |
|---|---|---|
| Closing `Q-01` | It is an architectural open question with named owners | **An accepted ADR.** This one is `PROPOSED` and is not it |
| Amending FROZEN `PRD-007` | `DOCUMENTATION_BASELINE.md` §7 step 1 — *"any future change requires an ADR before the change"* | The **same** ADR, accepted, then a `PRD-007` version bump + changelog + Stage 5/6 re-run |
| Allocating a configuration identifier, **if** the window is made configurable | `CONFIGURATION_GUIDE.md` **§5** — *"Promoting a structural fact to configurable"* requires *"an ADR **and** a PRD amendment"* | **Not proposed.** See §7.2 |

### 6.3 What A2 and A3 must **not** do, stated as constraints on the future author

Written now, while the reasoning is visible, so the amendment cannot quietly grow:

1. **MUST NOT** add a fifth `SeatState` value. The vocabulary is closed at four (**L150**) and derived
   (`SEAT-BR-010`).
2. **MUST NOT** express the window as a `Reservation` — `SEAT-FR-155` auto-cancels it per A2 (§4).
3. **MUST NOT** release, truncate or move the allocation during the window — `SEAT-BR-024`.
4. **MUST NOT** confer entitlement, alter `endDate`, or change the membership away from `Expired` — `MM-FR-109`,
   `MM-FR-111`, `MM-INV-004`.
5. **MUST NOT** compute money: no fee, no penalty, no credit, no refund, no deduction from the renewed term —
   `MM-XC-012`, `MM-FR-100`, and the requirement's own prohibitions.
6. **MUST NOT** let the seat module extend, renew or expire a membership — `SEAT-FR-157`.
7. **MUST NOT** make the release automatic *inside a work queue* — `SEAT-FR-217`. The trigger is a policy over a
   flagged allocation; whether the release itself is automatic or human is part of A1's answer.
8. **MUST NOT** create a cross-tenant or cross-library signal about the student. No such authority exists.

### 6.4 The calendar arithmetic the window needs already exists, and must be reused rather than reinvented

*"3 **calendar** days"* raises questions that a 24-hour duration does not: which timezone, when does a day end, what
happens at month and leap boundaries. **All three are already answered by frozen `PRD-005` §4.3-4.4, and A2/A3 MUST
reuse them rather than state their own:**

| Question the window raises | Already frozen | Consequence for A2/A3 |
|---|---|---|
| Which timezone decides a calendar day? | `MM-FR-061` — *"All term arithmetic, expiry determination and business-date resolution **MUST** use the tenant's configured timezone (`MM-CFG-006`), never the server's, never the client's"* | **Reuse.** The window is computed in the tenant timezone. No new timezone rule, and **no new `MM-CFG-*`** |
| How are days added across month ends and leap days? | `MM-FR-059` — *"Month-end, leap-day and 28/29/30/31-day-month cases **MUST** be handled by day arithmetic alone"*; `MM-FR-057` uses *"calendar-date arithmetic in the tenant's timezone"* | **Reuse.** Day arithmetic only. There is no *"same day next month"* case to get wrong |
| When exactly does the expiring term end? | `MM-FR-062` — *"valid for the whole of `endDate`"* | The window's **start boundary** is defined relative to a frozen, unambiguous instant |
| Must the computation be replay-stable? | `MM-FR-058` — a **pure function**, *"MUST NOT depend on the current clock"* | The window's end date **MUST** be derived from `endDate` + N days, not from *"now + 3 days"* at the moment the job runs. Otherwise a delayed or re-run expiry job silently moves it |
| May a later timezone change move it? | `MM-FR-064` — a timezone change *"**MUST NOT** retroactively alter the `startDate` or `endDate` of any existing membership"* | **The same non-retroactivity MUST apply to an already-started protection window.** Precedent exists; no new principle is invented |

> **`MM-FR-058` is the one most easily violated by a plausible implementation.** *"Set `protectedUntil = today + 3
> days`"* inside the expiry job reads naturally and is wrong: if the scheduled process runs late, is retried, or is
> replayed, the window moves. Derived as `endDate + 3` it is a pure function of recorded inputs and survives replay —
> which is also what `MM-FR-047`'s idempotency requires of the expiry path generally.

### 6.5 The boundary this ADR will **not** decide

The requirement's worked example is *"membership due **5 August** → protection window **5 August → 8 August**."*
Counted inclusively that is **4** calendar days; counted as *"the 3 days following `endDate`"* it is 6, 7 and 8
August. Both readings fit the words.

Against `MM-FR-062` — the membership is valid *"for the whole of `endDate`"* — 5 August is a **day the student may
still use the library**, so treating it as the first day of a *post-expiry* protection window would double-count it.
**That is an argument, not an authority.** Off-by-one errors in inclusive date intervals are exactly what frozen
`MM-FR-057`'s *"Why `− 1`"* note calls *"the classic source of a customer-visible dispute"*, and this ADR will not
resolve a customer-visible boundary by inference. **Recorded as question 2 of §8.**

---

## 7. What was NOT invented, and the gaps that remain

### 7.1 Nothing was created

| Category | Created by this ADR |
|---|---|
| Bounded contexts | **None.** Count remains **31**. No `BC-32` |
| `SeatState` values | **None.** Still the closed four of **L150** |
| Aggregates | **None.** No `SeatHold`, no `ProtectionWindow`, no `RenewalGrace` |
| Requirement identifiers | **None.** No `SEAT-FR-*`, `MM-FR-*`, `SAAS-FR-*` or `FEE-FR-*` allocated. §6 describes changes an **amendment** would make; allocation is the owning PRD's act |
| Configuration identifiers | **None.** No `SEAT-CFG-*`, `MM-CFG-*`, `CFG-*`, `LCFG-*`, `ICFG-*` |
| Permissions | **None.** No `PERM-*`. `AUTH-7.22` closes the catalogue and **0** exist repository-wide |
| Events | **None.** `MM-EVT-005` already exists and already drives this path |
| Dependency edges / ports | **None.** `BC-02` → `BC-04` via `MM-EVT-005` is already declared |
| Timezone / calendar rules | **None.** `MM-FR-057`…`MM-FR-064` are reused (§6.4) |
| Money rules | **None.** The window computes no money at all |

### 7.2 The configurability question — recorded, not answered

The brief says: *"Default 3 days. Do NOT make it silently configurable. Do not invent a new configuration ID. If
configurable authority is not currently authorised: record the requirement and create the minimum governance path."*

**Measured:**

| Fact | Source |
|---|---|
| No `SEAT-CFG-*` parameter exists for expiry grace or protection. The nearest are `SEAT-CFG-007` (7d pending expiry), `SEAT-CFG-015` (30min reservation), `SEAT-CFG-016` (1 reservation), `SEAT-CFG-018` (7d expiring-soon) | `PRD-007` **L1908**, **L1919** |
| `CONFIGURATION_GUIDE.md` holds **no** renewal-protection parameter | measured |
| *"Adding a parameter"* requires *"a **PRD amendment** — the specification declares what is configurable, this guide does not"* | `CONFIGURATION_GUIDE.md` **§5** (**L534**) |
| *"Promoting a structural fact to configurable"* requires *"an ADR **and** a PRD amendment"* | `CONFIGURATION_GUIDE.md` **§5** (**L535**) |
| `Q-01`'s own recommendation is *"**configurable per tenant** (`BC-25`)"* — a **different scope** from a platform default | BC Map **L540** |

**Consequence: this ADR proposes the window as a fixed 3-day default and does NOT propose making it configurable.**
Configurability is a *promotion of a structural fact*, needing an ADR **and** a PRD amendment **and** an identifier
from a register this ADR may not write to. The 3-day value is therefore **not silently configurable** — it is
deliberately not configurable at all until an authority says otherwise, which is the safer of the two errors and the
one the brief asks for.

**The unresolved tension is recorded rather than smoothed over:** `Q-01`'s recommendation wants tenant
configurability; the brief wants a fixed default. Both cannot be satisfied by silence. **Question 3 of §8.**

### 7.3 Gaps this ADR opens or inherits

**⚠ Amended at v2.0 on acceptance.** The sentence below was written while this ADR was `PROPOSED` and is **retained** because it correctly states the rule that governed it then: *"No gap is closed by this ADR. It is `PROPOSED`; closing anything would be self-acceptance."* **That reasoning is unchanged; the status is not.** The conferral of §8.2 closes **two** of the rows below, and the *Status after this ADR* column now reads **as at v2.0**. **Three rows remain OPEN**, and none of them is closed by implication.

| Gap | Subject | Authority | Status after this ADR |
|---|---|---|---|
| `Q-01` / `SEAT-GAP-003` / `MM-GAP-001` | Seat release timing after expiry | Architecture Owner + `BC-04` owner | ✅ **ANSWERED at v2.0 — a 3-calendar-day protection window, mandatory V1** (§8.2 question 1). **The gap entries themselves are NOT edited here:** `MM-GAP-001` sits in **frozen** `PRD-005` and `SEAT-GAP-003` in **frozen** `PRD-007`, and neither may be rewritten by this ADR. Their **resolution is recorded here**; propagating it into those registers is a separate act requiring its own authority |
| `FEE-GAP-013` (renewal-protection portion) | Renewal protection had no owning specification | now visibly `BC-04` + `BC-02`, via `Q-01` | **OPEN**, but **correctly routed** — and `PRD-008` §39.2's *"forbidden"* framing is **superseded by §3 of this ADR** |
| **new** — window boundary (inclusive vs following-day) | Whether the window starts on `endDate` or the day after | **Product Owner** | ⛔ **STILL OPEN at v2.0.** §6.5, question 2, §8.2, §8.3. **The conferral said *"3-day"* and that does not choose a first day.** Deliberately carries **no** `MM-GAP-*` identifier (§8.3) |
| **new** — configurability scope | Fixed platform default vs `Q-01`'s tenant-configurable recommendation | Product Owner + `BC-25` | ✅ **ANSWERED at v2.0 — FIXED, not tenant-configurable** (§8.2 question 3). **No `SEAT-CFG-*` or `BC-25` identifier was allocated, and none was needed** — that is the point of answering *fixed* |
| **new** — release actor | Whether release at window end is automatic or human, given `SEAT-FR-217` forbids a queue acting on its own contents | `BC-04` owner | **OPEN.** Part of A1 |

> **`PRD-008` §39.2 must be corrected, not merely superseded.** It states that frozen rules *"forbid"* this
> behaviour. That claim is wrong (§3), it is in a **non-frozen** document, and leaving it standing would let a future
> reader re-derive the wrong conclusion from a document that looks authoritative. Correcting it is a `PRD-008`
> changelog act requiring no ADR, and it is recorded here so the correction is traceable to the finding that forced
> it.

---

## 8. Authority — the three questions, and why this ADR is `PROPOSED`

**This ADR is not self-accepted.** It records findings and asks three questions. `PRD_OWNERSHIP_MODEL.md` §2.2 and
the `MM-GAP-001`/`SEAT-GAP-003` texts name the owners; this document names none of its own.

| # | Question | Authority | If unanswered |
|---|---|---|---|
| **1** | **Is `Q-01` answered as *"after a 3-calendar-day grace period"*?** The open question's own recommendation says 24h; the V1 requirement says 3 days. A recommendation inside an open question is not a decision (`PRD-005` **L816**), so there is no decision to override — but 3 days is not the anticipated value, and only these owners may set it | **Architecture Owner + `BC-04` owner**, jointly, per `MM-GAP-001` | **The requirement cannot be implemented.** The seat is retained regardless (`SEAT-BR-024`), so **no wrong behaviour ships** — but no bounded window exists, and release timing stays undefined |
| **2** | **Does the window include `endDate`, or begin the day after?** *"Due 5 Aug → 5 Aug to 8 Aug"* admits both readings; `MM-FR-062` makes 5 August a usable day | **Product Owner** | A1-A3 cannot be written without a boundary. **Not inferred here** (§6.5) |
| **3** | **Fixed 3-day platform default, or tenant-configurable as `Q-01` recommends?** If configurable, `CONFIGURATION_GUIDE.md` §5 requires an ADR **and** a PRD amendment **and** a `SEAT-CFG-*`/`BC-25` identifier this ADR may not allocate | **Product Owner + `BC-25` configuration authority** | **Fixed 3 days, not configurable, is the fail-safe** and is what §6 proposes |

**What this ADR does *not* ask for, deliberately:** permission to amend `MM-FR-111`, `MM-XC-012` or `MM-FR-100`.
§3 establishes that none of them is in the way. **Asking to amend a frozen rule that does not block the requirement
would spend governance authority for nothing** — and would leave a record implying the frozen rules were the
obstacle, when the obstacle is an unanswered question.

### 8.1 Status of the V1 requirement, stated unambiguously

**3-day renewal protection remains a V1 product requirement.** It is **not** downgraded to V2, **not** marked
optional, **not** removed, and **not** replaced with a different duration. What is recorded is that its
implementation is **blocked on `Q-01`**, a question with named owners that has been open since the BC Map was
written — and that the frozen architecture is **already positioned to accept the answer** without redesign.

| | |
|---|---|
| V1 requirement | ✅ **Preserved** |
| Downgraded to V2 | ❌ **No** |
| Duration changed from 3 days | ❌ **No** |
| Frozen rule violated | ❌ **No** — none is in the way (§3) |
| Frozen document modified by this ADR | ❌ **No** |
| Blocked | ⛔ **Yes — on `Q-01`**, with the owners named and the evidence assembled |

---

### 8.2 The conferral, and the one question it did not answer

**On 2026-08-05 the human principal conferred authority directly**, in the same manner and with the same disclosure
as `ADR-0032` §5.2 and `ADR-0033` §7.2: **no ARB quorum, attendee list, sign-off date or Security review is
asserted.** The decision as given was:

> *"3-day renewal protection remains mandatory V1. No membership extension, penalty, proration or term deduction."*

**Mapped onto the three questions of §8, one by one:**

| # | Question | Outcome |
|---|---|---|
| **1** | Is `Q-01` answered as *"after a 3-calendar-day grace period"*? | ✅ **ANSWERED — YES.** *"3-day renewal protection remains mandatory V1."* The duration is **3 calendar days**, it is **mandatory**, and it is **V1**. `MM-GAP-001`'s 24h recommendation is **overridden by the authority entitled to override it** — and §5.1 already recorded that a recommendation inside an open question was never a decision, so nothing is being reversed |
| **2** | Does the window include `endDate`, or begin the day after? | ⛔ **NOT ANSWERED. STILL BLOCKED.** The decision says *"3-day"*; it does **not** say whether 5 August is day 0 or day 1. §6.5 refuses to infer this, and that refusal **stands** |
| **3** | Fixed 3-day platform default, or tenant-configurable? | ✅ **ANSWERED — FIXED.** The decision reads *"remains mandatory V1"* with no configurability granted, and lists no `SEAT-CFG-*`/`BC-25` parameter. Under `CONFIGURATION_GUIDE.md` §5 a configurable would require an ADR **and** a PRD amendment **and** an identifier this ADR may not allocate. **Fixed, not configurable, is both the fail-safe and what §6 proposed** |

#### Why question 2 is not quietly closed by the "3-day" wording

It would be easy to read *"3-day"* as settling the boundary, and it does not. **The two readings of the requirement's
own worked example differ by a day, and both remain consistent with the words "3-day":**

| Reading | *"Due 5 Aug"* → window | Days |
|---|---|---|
| `endDate` inclusive | **5 Aug → 8 Aug** | 4 calendar days by inclusive count — the requirement's own example text |
| Day after `endDate` | **6, 7, 8 Aug** | 3 calendar days |

Frozen `MM-FR-062` makes the membership valid *"for the whole of `endDate`"*, so 5 August is a day the student may
**still use the library** — which argues for the second reading. **But §6.5 already recorded that this is "an
argument, not an authority",** and frozen `MM-FR-057`'s *"Why `− 1`"* note calls inclusive-interval off-by-ones
*"the classic source of a customer-visible dispute."* A one-day error here is visible to a paying student on a date
that decides whether their seat is released. **It is therefore recorded as an open gap and not
inferred** — the *window boundary* row of §7.3, which already carried it before this acceptance.

#### What is now in force, and what still is not

| | Status |
|---|---|
| 3-day duration, mandatory, V1 | ✅ **In force** |
| Not downgraded to V2, not optional, not removed | ✅ **Confirmed by the authority** |
| No membership extension | ✅ **In force** — and it never needed an amendment; `MM-FR-111`'s separation clause already said so (§3) |
| No penalty, no proration, no term deduction | ✅ **In force**, same basis |
| Fixed, not tenant-configurable | ✅ **In force** (question 3) |
| Seat retained during the window | ✅ Already true — frozen `SEAT-BR-024`, unchanged |
| **The window's first day** | ⛔ **NOT decided** — §7.3 *window boundary*, **Product Owner** |
| A1–A3, the minimum amendment of §6 | ❌ **NOT applied.** §6 is *recommended*, and it cannot be written without question 2. **`PRD-007` is untouched; `PRD-005` is untouched** |
| Any frozen document | ❌ **Unmodified.** `PRD-SEAT-MANAGEMENT.md` and `PRD-MEMBERSHIP-MANAGEMENT.md` stand byte-identical |
| A fifth `SeatState` value | ❌ **Not created** (§4.2). The vocabulary stays the closed four |

**What acceptance does not license.** Per `ADR-0033` §7.1, *"A conferral for one act is not a standing licence."*
This conferral covers questions 1 and 3. **It does not authorise writing A1–A3, amending `PRD-007`, or choosing the
window boundary** — each needs its own decision, and the boundary needs the **Product Owner**.

#### 8.3 Why question 2 gets **no new `MM-GAP-*` identifier** — a collision this pass nearly caused

A first draft of this acceptance recorded question 2 as **`MM-GAP-011`**. **That was wrong twice over, and it is
recorded rather than silently corrected**, because the near-miss is the useful part:

| Objection | Measured |
|---|---|
| **`MM-GAP-011` is already spoken for — as a *phantom*** | `PRD-005_FIFTH_INDEPENDENT_REVIEW.md` **L275** asserts *"Phantom identifiers (`MM-FR-119`, `MM-GAP-011`) — **0** / **0**"*. It names `MM-GAP-011` as an identifier that **must not exist**. Minting it would have **falsified a passing review check** |
| **The `MM-GAP-*` register lives in a FROZEN document** | `PRD-MEMBERSHIP-MANAGEMENT.md` **L62** declares the register as **13** entries — `MM-GAP-001`…`MM-GAP-010` plus the suffixed successors. It is Rank 3 and frozen by `ADR-0019`; **this ADR may not add a row to it**, and §8's own text says the ADR *"names none of its own"* |

**So the boundary question keeps the form it already had:** the unnumbered ***window boundary*** row of §7.3, owner
**Product Owner**. It loses nothing by being unnumbered — it is stated, owned, and blocking — and it gains the
property of not colliding with a frozen register or a review invariant.

---

## 9. Consequences

**If the authorities answer as §5 proposes:**

- `Q-01` closes; `SEAT-GAP-003` and `MM-GAP-001` close with it. **Two long-standing gaps in two frozen PRDs resolve
  from one decision** — and `MP-DEP-07` names `Q-01`…`Q-07` as a schema-freeze dependency, so the effect reaches
  beyond this feature.
- `PRD-007` takes an additive amendment (A2, A3) under `PRD_LIFECYCLE.md` Stage 7: ADR → version increment →
  changelog → baseline update, with Stage 5/6 re-run. **`PRD-005` is not amended.**
- The `Expiry-flagged` work queue gains a defined exit condition; it currently has none.

**If they answer otherwise (immediate or end-of-day release):**

- The requirement **cannot** be delivered as specified, and that becomes a **product** conflict to escalate — not a
  documentation problem to solve by rewording. This ADR would be marked `REJECTED` and the finding retained.

**Either way, and starting now:**

- **No wrong behaviour ships.** `SEAT-BR-024` retains the allocation, `SEAT-BR-011` and gate **G16** stop another
  student acquiring it, and `SEAT-FR-217` stops the queue acting on its own. The **unsafe** failure mode — a seat
  silently resold under a student who is about to renew — is already prevented by frozen rules.
- `PRD-008` §39.2's *"forbidden"* finding is **wrong and must be corrected** (§7.3).

---

## 10. Compliance

| Constraint | How this ADR complies |
|---|---|
| Do not violate a frozen rule | **No frozen document is modified.** §3 shows none is violated |
| Do not invent architecture | §7.1 — nothing created; every mechanism cited already exists |
| Do not invent roles, permissions, configuration IDs, contexts, edges, aggregates or events | §7.1, §7.2 — **zero** allocated |
| Do not downgrade the requirement to V2 | §8.1 — preserved as V1 |
| Do not mark anything accepted unless the correct authority accepts it | **Status `PROPOSED`.** Three questions open; no gap closed |
| Preserve the frozen rule; create the smallest governance path | §6 amends **one** frozen document, additively, and **not** the membership PRD |
| Do not rely on grep alone | Every finding read with surrounding prose. **§3.1 exists only because of that** — a rejected-findings table 900 lines from the requirement would not have surfaced any other way, and it is the finding that most nearly refutes this ADR |
| Report findings that weaken your own position | §3.1 (a prior author's grace proposal was refused), §4 (the attractive shortcut fails), §6.5 and §7.2 (two boundaries left undecided), §7.3 (my own earlier finding was wrong) |

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| **v2.0** | 2026-08-05 | **PARTLY ACCEPTED — `Proposed` → `Accepted` on questions 1 and 3; question 2 stays OPEN.** By **direct conferral of Architecture Owner authority by the human principal** on the `ADR-0032` §5.2 / `ADR-0033` precedent — **no ARB quorum, attendee list, sign-off date or Security review asserted.** The decision given: *"3-day renewal protection remains mandatory V1. No membership extension, penalty, proration or term deduction."* **Question 1 ANSWERED** — `Q-01` is a **3-calendar-day** window, **mandatory**, **V1**; `MM-GAP-001`'s 24h *recommendation* is overridden by the authority entitled to override it, and §5.1 had already established a recommendation inside an open question was never a decision, so nothing is reversed. **Question 3 ANSWERED — FIXED, not tenant-configurable**, so **no `SEAT-CFG-*` and no `BC-25` parameter was allocated and none was needed.** **Question 2 is NOT answered and the status row says so** — *"3-day"* does not decide whether 5 August is day 0 or day 1; frozen `MM-FR-062` makes `endDate` a usable day, which is **an argument, not an authority** (§6.5), and frozen `MM-FR-057` calls inclusive-interval off-by-ones *"the classic source of a customer-visible dispute"*. **Accepting all three when two were answered would have been the convenient reading; the status row is `ACCEPTED … on questions 1 and 3 only`.** **A near-collision is recorded rather than hidden (new §8.3):** a first draft numbered question 2 **`MM-GAP-011`** — which `PRD-005_FIFTH_INDEPENDENT_REVIEW.md` **L275** names as a **phantom identifier asserted to have 0 occurrences**, so minting it would have **falsified a passing review check**, and the `MM-GAP-*` register lives in **frozen** `PRD-005` (**L62**, 13 entries) which this ADR may not extend. **The mint was retracted**; the boundary keeps the unnumbered *window boundary* row of §7.3. **§7.3's own header sentence is retained verbatim** — *"No gap is closed by this ADR. It is `PROPOSED`…"* — with an amendment note, because the reasoning was right for the status it had. **NOT done:** §6's A1–A3 amendment is **still not applied** and cannot be until question 2 is answered; **`PRD-007` untouched**; **`PRD-005` untouched**; **no frozen document modified** (`PRD-SEAT-MANAGEMENT.md` and `PRD-MEMBERSHIP-MANAGEMENT.md` byte-identical); **no fifth `SeatState` value** (the closed four stand, §4.2); **no `Reservation` primitive** (still refused per `SEAT-FR-155`); `MM-GAP-001`/`SEAT-GAP-003` **entries not edited** in their frozen homes — the answer is recorded here and propagating it needs its own authority; **no Dart source touched.** The conferral is **not a standing licence** (`ADR-0033` §7.1). |
| **v1.0** | 2026-08-05 | **First record. `PROPOSED` — not accepted, not in force.** Raised by the V1 requirement for 3-day renewal protection against frozen `PRD-005` and `PRD-007`. **Its central act is to overturn one of my own prior findings:** `PRD-008` §39.2 (v0.9) recorded that `MM-XC-012`, `MM-FR-100` and `MM-FR-111` *"forbid"* the behaviour; re-measured with surrounding prose, that conflated **money arithmetic** (forbidden, and not needed), **entitlement extension** (forbidden, and not conferred) and **seat-release timing** (`Q-01`, **open** — the actual blocker). Frozen `PRD-005` **L820-823** makes the separation itself, `MM-FR-112` **defers** seat reclamation to `BC-04`, and frozen `PRD-007` **L1166-1172** states the seat PRD is *"written to be correct under any resolution"* of `Q-01` because *"the release action becomes a policy-driven trigger over an already-flagged allocation rather than a redesign."* **So the requirement needs an open question answered, not a frozen rule broken.** Measured that the retention half is **already frozen behaviour** (`SEAT-BR-024`, `SEAT-BR-011`, gate `G16`, `SeatState` rule 2, the `Expiry-flagged` queue, `SEAT-FR-217`), and that the calendar arithmetic it needs **already exists** (`MM-FR-057`…`MM-FR-064`, `MM-CFG-006`) and must be reused — including `MM-FR-058`'s purity, which forbids the natural-but-wrong *"now + 3 days"*. **Rejected the attractive shortcut** of expressing protection as a `Reservation`: `SEAT-FR-155` **auto-cancels** an unexpired reservation on expiry *"per A2"*, the exact trigger, and `SEAT-BR-009`/`SEAT-BR-024` block the conversion anyway. **Recorded the finding that most nearly refutes this ADR:** frozen `PRD-005` §24.3 **L1719** contains a **refused** grace-period proposal — refused because *"the architecture has not decided it"* and *"a recommendation inside an open question is not a decision"*, i.e. **procedurally, not substantively**, which is why it supports rather than blocks the route taken here. **Nothing invented:** no bounded context (still **31**, no `BC-32`), no fifth `SeatState` value, no aggregate, no requirement identifier, no configuration identifier, no permission, no event, no edge, no port, no money rule. **No gap closed** — `Q-01`/`SEAT-GAP-003`/`MM-GAP-001` stay **OPEN**, and **three new open questions** are recorded (window boundary, configurability scope, release actor) rather than inferred. **Proposes the minimum amendment**: close `Q-01` by accepted ADR, then **two additive requirements in `PRD-007` only** — **`PRD-005` is not amended at all**, because it already says the decision is not its to make. **3-day renewal protection is preserved as a V1 requirement** and is **not** downgraded, made optional, removed or re-timed; it is recorded as **blocked on `Q-01`**, with the safe failure mode already guaranteed by frozen rules. **Also records that `PRD-008` §39.2 is wrong and must be corrected**, a changelog act needing no ADR. No frozen document, BC Map, Dependency Matrix, Traceability Matrix or module manifest was modified; no Dart source was touched. |

---

*End of `ADR-0036` **v1.0 — PROPOSED**. Recorded, not in force. `Q-01` remains OPEN. Three questions await three
named authorities. No frozen document was modified.*
