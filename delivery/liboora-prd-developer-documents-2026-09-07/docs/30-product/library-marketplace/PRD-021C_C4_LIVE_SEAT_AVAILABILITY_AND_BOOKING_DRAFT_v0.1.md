<!--
  PROVENANCE — PRD-021C Part C4 (Seat Availability & Booking Initiation)

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 NOT entered.

  TWO SCOPE REDUCTIONS ARE FORCED BY THE REPOSITORY, NOT CHOSEN
  -------------------------------------------------------------
  1. "LIVE" seat availability is FORBIDDEN in V1.
       LIB-14B.13   — Public Live Occupancy is V2 and MUST NOT be implemented in V1
       SEAT-XC-009  — per-seat identity/state and live occupancy MUST NOT be public in V1
       ARCH §6      — Public Live Occupancy deferred to V2, "must not be invented"
     C4's public surface is therefore AGGREGATE CAPACITY + COARSE INDICATOR only
     (LIB-14B.11, LIB-14B.12, SEAT-FR-117, LIB-7.3). Recorded as XPC-CONF-009.

  2. BOOKING IS ALREADY OWNED, FROZEN, BY PRD-007.
       PRD-SEAT-MANAGEMENT.md L153 defines Booking; sections 11 and 12 fully
       specify student self-booking, booking modes, reservations and conversion.
     C4 therefore DEFINES NO BOOKING. C4 is a presentation and INITIATION
     surface that hands off to BC-04. Recorded as XPC-CONF-008.

  Concurrency and idempotency are FROZEN (SEAT-BR-031, SEAT-FR-196..205,
  SEAT-BR-032, SEAT-XC-013). C4 CITES them and specifies NOTHING new.

  What this file does NOT do
  --------------------------
    - Defines no booking, reservation, allocation, seat or membership entity.
    - Creates no bounded context, edge, event, aggregate or invariant.
    - Amends no FROZEN PRD and no Rank 1-6 artefact.
    - Mints no IMPL-* identifier. Confers no lifecycle stage.
-->

# PRD-021C — PART C4

## Seat Availability & Booking Initiation

### v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Stage 3 has **not** been entered.
> ⚠⚠ **The supplied part title was "Live Seat Availability & Booking". Both words
> "Live" and "Booking" are constrained by frozen authority. §1.1 and §1.2 record
> exactly why, and the reduction is registered as `XPC-CONF-009` and
> `XPC-CONF-008` — not applied silently.**

| Field | Value |
|---|---|
| **PRD** | `PRD-021C` Part **C4** |
| **Part title (as authored)** | Seat Availability & Booking Initiation |
| **Part title (as supplied)** | ~~Live Seat Availability & Booking~~ — ⛔ reduced, see §1.1 / §1.2 |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** — Stage 2 |
| **Structural classification** | Part of the `AR-1` read composition (module 19). ⛔ **NOT a bounded context** |
| **Release** | **V1** — in the reduced form §1.1 establishes |
| **Identifier prefix** | `LSB-*` — collision-checked at **0** occurrences |
| **Owns** | ⛔ **No booking. No reservation. No allocation. No seat. No membership state. No lock. No idempotency store.** Presentation and initiation semantics only |
| **Consumes** | `BC-04` Seating *(the booking authority)* · `BC-02` Membership · `BC-06` Library Policy · `BC-18` Identity & Access · `BC-23` Search Indexing |
| **Cross-part** | [`C0`](./PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md) · [`C1`](./PRD-021C_C1_MARKETPLACE_FOUNDATION_DRAFT_v0.1.md) · [`C2`](./PRD-021C_C2_LIBRARY_SEARCH_AND_LOCAL_DISCOVERY_DRAFT_v0.1.md) · [`C3`](./PRD-021C_C3_LIBRARY_PUBLIC_PROFILE_DRAFT_v0.1.md) |

---

## §1. Purpose

C4 specifies two things:

1. **What a prospective student may learn about seat availability before joining** — publicly, anonymously, from the discovery surface.
2. **How the act of booking is *initiated* from that surface** — and handed to `BC-04`, which owns it.

C4 specifies **neither** live occupancy **nor** the booking operation. Both are
already decided by frozen authority, in opposite directions: one is forbidden in
V1, the other is fully owned elsewhere.

### §1.1 ⛔ Why "Live" is removed — three independent frozen prohibitions

| Authority | Rank / status | What it says |
|---|---|---|
| `LIB-14B.13` | Approved, authoritative | *"Public Live Occupancy is **V2** and **MUST NOT** be implemented in V1. It requires a completed privacy review (`LIB-24.2`)."* |
| `LIB-14B.12` | Approved, authoritative | Public availability *"**MUST** be expressed as a coarse qualitative indicator … and **MUST NOT** expose a precise free-seat count in V1."* |
| `SEAT-XC-009` | **FROZEN** (`PRD-007`) | *"Per-seat identity, per-seat state and live occupancy **MUST NOT** be exposed publicly in V1."* |
| `ARCHITECTURE_RULINGS.md` §6 | Rank 5 | Public Live Occupancy — deferred **V2**, with the ruling *"must not be invented."* |
| `LIB-7.3` | **FROZEN** | Published Seat Capacity **MUST** be an **aggregate** count. |

⭐ **Four authorities, three documents, one direction.** The supplied intent asked
for a feature that the repository has already examined and deferred, with a named
blocking prerequisite (`LIB-24.2`, a privacy review whose **Privacy Owner role is
VACANT** — `XPC-OD-005`).

> **Why the reduction is recorded rather than quietly performed.** Deleting
> "Live" from a title and writing a smaller feature would leave no trace that the
> larger feature was requested, examined and refused on authority. A future
> reader would see only a modest seat panel and could reasonably re-propose live
> occupancy as an oversight. `XPC-CONF-009` exists so the refusal is discoverable
> and so the V2 path (`LIB-24.2` → design) stays visible.

⛔ **What C4 therefore does not specify, at any level of detail:** live occupancy
count, live occupancy percentage, precise free-seat count, per-seat map, per-seat
state, per-seat history, seat-level timing, waitlist position, or any value
derived from attendance (`LIB-14B.14`).

### §1.2 ⛔ Why C4 defines no booking — `PRD-007` already owns it, frozen

`PRD-SEAT-MANAGEMENT.md` (`PRD-007`, **FROZEN**, v1.1, `BC-04` Seating `[CORE]`,
Rank 3) at **L153** defines the term:

> *"**`Booking`** — A **student-initiated** request that produces a reservation or an allocation per §12."*

and then specifies it exhaustively:

| Concern | Already frozen in `PRD-007` |
|---|---|
| Student may view availability and book for themselves | `SEAT-FR-076` *(gated by `SEAT-CFG-008`, default **disabled**)* |
| `self` scope only; never on another's behalf | `SEAT-FR-077`, `SEAT-FR-078` |
| Availability must not disclose the holder | `SEAT-FR-079` |
| Booking must carry explicit dates | `SEAT-FR-080` |
| Booking must not exceed membership `validUntil` | `SEAT-FR-081` |
| Booking must not start in the past | `SEAT-FR-082` |
| Advance window consumed from `BC-06`, never self-defined | `SEAT-FR-083` |
| Overlapping bookings vs `seatQuota` | `SEAT-FR-084` |
| Booking vs Reservation vs Assignment vs Allocation | `SEAT-FR-085` |
| Booking mode — `Direct` · `HoldThenConfirm` · `ApprovalRequired` (**default**) | `SEAT-CFG-010`, `SEAT-BR-018` |
| When a reservation converts | `SEAT-FR-088`…`091` |
| Expiry behaviour | `SEAT-FR-092`…`095` |

⭐ **There is nothing left for C4 to define, and defining it anyway would create a
second booking authority.** `LIB-14B.27` `PO-4` already names **Seat Booking** as
a protected operation whose owning module is **`BC-04`**. C4's lawful contribution
is the *initiation* path from an anonymous discovery surface to that owner.

> **The distinction that makes C4 legitimate rather than redundant.** `PRD-007`
> answers *"what happens when a student books."* It does not answer *"what a
> stranger who has never logged in sees, and how their intent survives the walk
> to the login screen."* That gap is real, is unowned by `BC-04`, and is exactly
> where `LIB-14B.33`…`39` intent preservation lives. C4 specifies the gap and
> nothing beyond it.

---

## §2. Identifier register

| Register | Range | Count | Contiguous |
|---|---|---|---|
| `LSB-FR-*` | `LSB-FR-001` … `LSB-FR-036` | 36 | Yes |
| `LSB-AC-*` | `LSB-AC-001` … `LSB-AC-018` | 18 | Yes |
| `LSB-XC-*` | `LSB-XC-001` … `LSB-XC-014` | 14 | Yes |

### §2.1 Normative language

| Term | Meaning |
|---|---|
| **MUST** / **MUST NOT** | Absolute requirement. A build violating it is defective |
| **SHOULD** | Strong recommendation; deviation requires a recorded reason |
| **MAY** | Genuinely optional |
| *(no keyword)* | Explanatory prose. Creates **no** requirement. Quoted `>` blocks are rationale and are **not** normative |

### §2.2 Ownership split — what C4 owns and what it only renders

| Concern | Owner | C4 |
|---|---|---|
| `Seat`, `SeatLayout`, `SeatAllocation` | `BC-04` (`PRD-007`, FROZEN) | ⛔ renders aggregates only |
| `Booking`, `Reservation`, booking mode, conversion, expiry | `BC-04` | ⛔ initiates, never defines |
| Seat locks, quota locks, lock timeout | `BC-04` (`SEAT-FR-196`…`200`) | ⛔ cites only |
| Idempotency keys, keys store, retention | `BC-04` (`SEAT-FR-201`…`205`) | ⛔ cites only |
| Membership validity, `seatQuota` | `BC-02` | ⛔ consumes |
| `reservationWindow`, hours, holidays | `BC-06` | ⛔ consumes |
| Authentication, session, authorisation | `BC-18` | ⛔ delegates |
| Aggregate capacity + coarse indicator projection | `BC-04` (`SEAT-FR-117`) | ⛔ consumes |
| **Public presentation of the coarse indicator** | *(unowned)* | ✅ **C4** |
| **Anonymous→authenticated intent handoff for `PO-4`** | *(unowned by `BC-04`)* | ✅ **C4** |
| **Staleness disclosure on a public availability read** | *(unowned)* | ✅ **C4** |

---

## §3. The public availability surface — anonymous

`LSB-FR-001` — Seat availability information on the public discovery surface
**MUST** be readable **without authentication** (`LIB-14B.1`, §14A.8), and
**MUST NOT** be gated behind a sign-in prompt or a mobile-number request
(`LIB-14B.5`).

`LSB-FR-002` — Public availability **MUST** be served from the public read
projection of `LIB-14B.8`. A public availability request **MUST NOT** reach
`BC-04`'s operational store, seat table or allocation table by any path.

`LSB-FR-003` — The public availability value **MUST** originate from the
aggregate projection `SEAT-FR-117` permits `BC-04` to publish. C4 **MUST NOT**
compute availability from any other source.

`LSB-FR-004` — Public availability **MUST NOT** be derived from attendance
records, check-in events, `E-08` traffic, or any presence signal
(`LIB-14B.14`, `LIB-14B.21`).

`LSB-FR-005` — Public availability **MUST NOT** reveal, directly or by
inference, the presence, absence, arrival time or routine of any individual.

`LSB-FR-006` — Where the availability projection is unavailable, the surface
**MUST** mark availability as temporarily unknown. It **MUST NOT** display a
default of *Available*, and **MUST NOT** display a cached value of unknown age.

> **`LSB-FR-006` forbids the one convenient default.** Showing *Available* when
> the source is down converts better and is a false statement about a commercial
> premises: a student travels to a full library. *Unknown* is the honest value,
> and it is the only value the platform can actually support at that moment.

---

## §4. Aggregate capacity and the coarse indicator

`LSB-FR-007` — The public surface **MAY** display **total seat capacity** as an
aggregate count, and **MAY** display capacity per zone kind, exactly as
`LIB-14B.11` and `LIB-7.3` permit.

`LSB-FR-008` — Public availability **MUST** be expressed **only** as a coarse
qualitative indicator drawn from a closed value set — *Available* · *Limited* ·
*Full* · *Unknown* — per `LIB-14B.12`.

`LSB-FR-009` — The mapping from `BC-04`'s aggregate projection to the coarse
indicator **MUST** be owned and published by `BC-04`. C4 **MUST NOT** define
thresholds, percentages or boundaries for that mapping.

> **Why C4 refuses to define the thresholds.** A threshold such as *"Limited
> below 20% free"* is a derivation from a precise free count. Placing that
> derivation in a presentation layer means the presentation layer receives the
> precise count — which `LIB-14B.12` forbids from crossing the public boundary at
> all. Keeping the mapping inside `BC-04` is what makes the prohibition
> enforceable rather than merely stated.

`LSB-FR-010` — The public surface **MUST NOT** display a precise free-seat count,
a free-seat percentage, an occupancy count, an occupancy percentage, or any
numeric availability value other than the aggregate capacity of `LSB-FR-007`.

`LSB-FR-011` — The coarse indicator **MUST NOT** be refinable by inference,
including by repeated querying, response-time differencing, indicator-transition
observation, or correlation with the aggregate capacity.

> **`LSB-FR-011` is restrictive-only and has no direct frozen parent — this is
> disclosed.** `LIB-14B.12` prohibits *publishing* a precise count; it does not
> address deriving one. An observer polling a three-value indicator every minute
> can reconstruct a change curve and, with capacity known, approximate the count
> the prohibition exists to withhold. The frozen prohibition is on **the fact**,
> not merely on **the field**, so this requirement closes the inference path. It
> **adds no capability** and grants no permission.

`LSB-FR-012` — Whether availability is published at all **MUST** remain the
publishing library's choice. §14A.5 lists *"Seat Capacity (Optional)"*; a library
that publishes nothing **MUST** show no availability panel, and its absence
**MUST NOT** be presented as *Full*, as *Unknown-due-to-error*, or as a
deficiency.

---

## §5. The authenticated availability view

`LSB-FR-013` — Once a caller is authenticated **and** authorised for a library,
seat availability **MUST** be served by `BC-04` under `PRD-007`'s rules, not by
the public projection.

`LSB-FR-014` — The authenticated view **MUST NOT** disclose which student holds
an occupied or reserved seat (`SEAT-FR-079`, `PRD-007` §28.2).

`LSB-FR-015` — The transition from the public coarse indicator to the
authenticated view **MUST** be a change of **source**, not an unlock of extra
public data. C4 **MUST NOT** cache, retain or re-serve authenticated seat detail
on any public surface.

`LSB-FR-016` — Where self-booking is disabled for a tenant
(`SEAT-CFG-008`, default **disabled**), the surface **MUST NOT** present a
booking action, and **MUST NOT** imply that booking is available and failing.

`LSB-FR-017` — Where self-booking is disabled, the surface **MUST** still be able
to present availability and the library's own contact information, so the student
can proceed at the desk (`LIB-16.2`).

`LSB-FR-018` — The surface **MUST** reflect the tenant's effective booking mode
(`SEAT-CFG-010`: `Direct` · `HoldThenConfirm` · `ApprovalRequired`, default
`ApprovalRequired`) in what it tells the student to expect. C4 **MUST NOT**
default, override, infer or simplify the mode.

> **`LSB-FR-018` matters because the three modes produce visibly different
> outcomes.** Under `ApprovalRequired` — the default — a student who taps *Book*
> gets a pending request, not a seat. A surface that says "Seat booked!" for all
> three modes is lying in two of them. C4 renders the mode `BC-04` reports; it
> does not choose one.

---

## §6. Booking initiation — the handoff

`LSB-FR-019` — Seat Booking **MUST** be treated as protected operation `PO-4`
(`LIB-14B.27`), whose owning module is **`BC-04`**. C4 **MUST NOT** execute,
partially execute, pre-validate as authoritative, or simulate the booking.

`LSB-FR-020` — When an **anonymous** visitor initiates booking, the platform
**MUST** record the intended action and its context, route to the `BC-18`
authentication flow, and on success **resume** the original action
(`LIB-14B.33`, `LIB-DISC-012`).

`LSB-FR-021` — Preserved intent **MUST** carry only the action, the target
library identifier, and any selection already made. It **MUST NOT** carry a
credential (`LIB-14B.34`), **MUST** expire after `LCFG-11` (`LIB-14B.35`), and
**MUST NOT** be usable against a library other than the one it named
(`LIB-14B.37`).

`LSB-FR-022` — Resumption **MUST** re-evaluate authorisation at the moment of
resumption. Intent recorded before authentication **MUST NOT** be treated as
pre-authorised (`LIB-14B.36`, `LIB-14B.29`).

`LSB-FR-023` — If the library's state changed during authentication — suspended,
made Private, plan withdrawn, capacity exhausted, self-booking disabled —
resumption **MUST** re-validate and **MUST** fail cleanly with an explanation
rather than proceed on stale state (`LIB-14B.38`).

> **`LSB-FR-023` is the requirement that connects C4 to the staleness problem.**
> The interval between "student taps Book" and "student finishes OTP" is long
> enough for the last seat to go. Every gate must be re-evaluated at the moment
> of the write — which is precisely what `SEAT-FR-087` and `SEAT-FR-091` already
> require inside `BC-04`. C4's obligation is to not defeat that by treating a
> pre-auth check as a promise.

---

## §7. Concurrency and idempotency — cited, not specified

⛔ **C4 specifies no concurrency control and no idempotency mechanism.** Both are
frozen in `PRD-007`. The requirements below constrain **C4's conduct** so that it
cannot defeat them.

`LSB-FR-024` — Two concurrent booking initiations against one seat **MUST**
resolve to exactly one success and one explicit, distinguishable failure, as
`SEAT-BR-031` requires. C4 **MUST NOT** present a silent overwrite, a
last-write-wins outcome, or two successes.

`LSB-FR-025` — The losing initiation **MUST** surface the conflict reason
`BC-04` returns, and **MUST** allow retry against **freshly read** state
(`SEAT-FR-196`). C4 **MUST NOT** retry against the state it already held.

`LSB-FR-026` — C4 **MUST NOT** implement, hold, emulate or bypass either lock
`PRD-007` requires: the lock on the **seat** (`SEAT-INV-001`) or the lock on the
**student's allocation set** (`SEAT-INV-002`, `SEAT-FR-198`).

> **Two locks, not one — reproduced because it is the failure this surface can
> cause.** `PRD-007`'s own rationale warns that *"a build that locks only the
> seat allows one student to win two seats concurrently and exceed
> `seatQuota`."* A discovery surface that lets a student open two library tabs
> and tap *Book* in each is exactly how that race is generated in practice. C4
> does not fix it — `BC-04` does — but C4 must not pretend one lock suffices.

`LSB-FR-027` — A lock-acquisition timeout reported by `BC-04`
(`SEAT-FR-199`) **MUST** be surfaced as a **retryable** failure. C4 **MUST NOT**
present it as a success, as a validity failure, or as a capacity failure.

`LSB-FR-028` — Every booking initiation C4 forwards **MUST** carry a
caller-supplied idempotency key, per `SEAT-FR-201`.

`LSB-FR-029` — A repeat initiation bearing an already-applied key **MUST**
surface the **original result** returned by `BC-04` (`SEAT-BR-032`, gate `G3`).
C4 **MUST NOT** re-issue the operation and **MUST NOT** synthesise a second
outcome.

`LSB-FR-030` — C4 **MUST NOT** generate a new idempotency key on a user-visible
retry of the same intent, and **MUST NOT** generate a key per network attempt. A
network retry **MUST** produce exactly one allocation, one history row, one audit
event and one notification fact (`SEAT-FR-203`).

`LSB-FR-031` — C4 **MUST NOT** store, mirror, expire or extend idempotency keys.
Scope and the fixed **24-hour** retention are owned by `SEAT-FR-202` and are
*"fixed, not configurable"*. A retry **MUST NOT** be able to create a second
allocation (`SEAT-XC-013`).

---

## §8. Staleness, failure and honesty of the surface

`LSB-FR-032` — Every public availability value **MUST** carry the age of the
projection it came from. The surface **MUST NOT** present availability as
current when its source age is unknown.

`LSB-FR-033` — Where projection age exceeds `LCFG-6`, availability **MUST** be
presented as possibly stale, or as *Unknown*. It **MUST NOT** be presented as
authoritative.

`LSB-FR-034` — The surface **MUST NOT** describe any availability value as
*live*, *real-time*, *current occupancy*, or any wording implying live occupancy,
because Public Live Occupancy is **V2** (`LIB-14B.13`).

> **`LSB-FR-034` is a wording requirement and is deliberate.** A coarse
> indicator labelled *"Live availability"* makes a V2 claim with V1 data. The
> prohibition in `LIB-14B.13` is on the capability; labelling a lesser capability
> as though it were the deferred one is the same misrepresentation reached by a
> different route.

`LSB-FR-035` — A booking initiation that fails **MUST** report which stage failed
in terms the student can act on — not authorised · self-booking disabled ·
membership invalid · capacity exhausted · conflict, retry · temporarily
unavailable. It **MUST NOT** report a single opaque failure for all causes.

`LSB-FR-036` — Failure responses **MUST NOT** disclose internal identifiers,
seat identifiers, another student's data, table names, query structure, stack
traces or configuration values (`LIB-14B.25`, `PRD-007` §28.2).

---

## §9. Exclusions

⛔ Each exclusion is a **boundary**, not a backlog item.

| ID | C4 does **not** | Authority |
|---|---|---|
| `LSB-XC-001` | Define `Booking`. It is defined at `PRD-SEAT-MANAGEMENT.md` **L153** and specified by `SEAT-FR-076`…`084`, all **FROZEN** | `PRD-007` (FROZEN); `XPC-CONF-008` |
| `LSB-XC-002` | Define `Reservation`, conversion, expiry or no-show handling | `SEAT-FR-085`…`095` (FROZEN) |
| `LSB-XC-003` | Define booking mode, or default one. `SEAT-CFG-010` is a closed tenant value set, default `ApprovalRequired` | `SEAT-CFG-010`, `SEAT-BR-018` (FROZEN) |
| `LSB-XC-004` | Publish, emit or define **any** event. `BC-04`'s published event set is **closed** and adding one requires an ADR | `SEAT-FR-206`; BC Map §9; `AR-1` |
| `LSB-XC-005` | Hold any seat, allocation, reservation or booking state. C4 is stateless | `AR-1`; `LSB-XC-001` |
| `LSB-XC-006` | Own or duplicate membership state, validity or `seatQuota`. `BC-02` owns them; `PRD-007` §18 rules *"consume, never recreate"* | `PRD-007` §18; `PRD-005` (FROZEN) |
| `LSB-XC-007` | Expose live occupancy, an occupancy count, or an occupancy percentage publicly | `LIB-14B.13`; `SEAT-XC-009`; `ARCHITECTURE_RULINGS.md` §6 |
| `LSB-XC-008` | Expose a per-seat identifier, per-seat state, per-seat history, seat map or seat timing publicly | `LIB-14B.11`; `SEAT-XC-009` |
| `LSB-XC-009` | Expose a precise free-seat count, a waitlist position, or any presence-derived value | `LIB-14B.12`, `LIB-14B.14` |
| `LSB-XC-010` | Queue, replay or reconcile a booking offline. `E-24` (BC Map **L333**) names **`BC-03` Attendance only** as the `BC-30` source; `BC-04` is **not** an offline-sync participant | BC Map **L333**; `XPC-OD-004` *(not required for V1)* |
| `LSB-XC-011` | Decide any authorisation locally. Authentication and authorisation are `BC-18`'s; a valid session is **not** permission | `X-13`; `LIB-14B.29`, `LIB-14B.30` |
| `LSB-XC-012` | Take, hold, quote, compute or refund money. `BC-04` *"holds no money"* and C4 holds less | `SEAT-FR-094`; `LXC-7` |
| `LSB-XC-013` | Show any rating, review or reputation value alongside availability | `ARCHITECTURE_RULINGS.md` §6 — deferred **V2**, requires a new context and an ADR |
| `LSB-XC-014` | Surface any social signal — who is seated, who is attending, peers present, `PersonId`-keyed data | `X-05` (Matrix **L354**); `ID-3` (BC Map **L180**); `LIB-14B.22` |

---

## §10. Acceptance criteria

⚠ **0 of the 18 criteria below is proven by an executed test.** They are
authored specifications of verifiable behaviour, at Stage 2.

**`LSB-AC-001` — Availability is readable anonymously**
> **Given** a Public library that publishes seat capacity
> **When** an unauthenticated caller reads its availability panel
> **Then** the aggregate capacity and a coarse indicator are returned
> **And** no sign-in prompt and no mobile-number request occurs.
> **Exercises** — `LSB-FR-001`, `LSB-FR-007`

**`LSB-AC-002` — No public path reaches operational seat data**
> **Given** the public availability endpoint
> **When** its read path is traced
> **Then** it resolves only to the public read projection
> **And** no seat table, allocation table or `BC-04` operational store is reachable from it.
> **Exercises** — `LSB-FR-002`, `LSB-FR-003`

**`LSB-AC-003` — Precise counts are absent**
> **Given** a library with 100 seats of which 37 are free
> **When** an anonymous caller reads availability
> **Then** the response may contain `100`
> **And** the response contains neither `37`, nor `63`, nor any percentage, nor any per-seat identifier or state.
> **Exercises** — `LSB-FR-010`, `LSB-FR-008`

**`LSB-AC-004` — Indicator values come from the closed set**
> **Given** any library's public availability response over any source state
> **When** the indicator value is inspected
> **Then** it is exactly one of *Available*, *Limited*, *Full*, *Unknown*
> **And** no other value, numeric or textual, appears.
> **Exercises** — `LSB-FR-008`

**`LSB-AC-005` — Thresholds are not implemented in the presentation layer**
> **Given** the C4 surface implementation
> **When** it is inspected for availability logic
> **Then** it contains no threshold, percentage or boundary computation
> **And** it receives the indicator already resolved by `BC-04`.
> **Exercises** — `LSB-FR-009`

**`LSB-AC-006` — Availability is never presence-derived**
> **Given** a library inside operating hours with zero people currently checked in and all seats unallocated
> **When** an anonymous caller reads availability
> **Then** the indicator reflects the allocation-based aggregate
> **And** no attendance record, check-in event or `E-08` message contributes to the value.
> **Exercises** — `LSB-FR-004`

**`LSB-AC-007` — Source failure yields *Unknown*, never *Available***
> **Given** the availability projection is unreachable
> **When** an anonymous caller reads the panel
> **Then** availability is presented as temporarily unknown
> **And** it is not presented as *Available*
> **And** no cached value of unknown age is shown.
> **Exercises** — `LSB-FR-006`

**`LSB-AC-008` — A non-publishing library shows no panel**
> **Given** a library that has not published seat capacity
> **When** an anonymous caller reads its profile
> **Then** no availability panel is rendered
> **And** the absence is not rendered as *Full*, as an error, or as a deficiency.
> **Exercises** — `LSB-FR-012`

**`LSB-AC-009` — Staleness is disclosed**
> **Given** an availability projection whose age exceeds `LCFG-6`
> **When** the panel is rendered
> **Then** the value is marked possibly stale or shown as *Unknown*
> **And** it is not presented as authoritative.
> **Exercises** — `LSB-FR-032`, `LSB-FR-033`

**`LSB-AC-010` — The word "live" is not used**
> **Given** every public string on the availability surface
> **When** the strings are inspected
> **Then** none describes the value as *live*, *real-time* or *current occupancy*.
> **Exercises** — `LSB-FR-034`

**`LSB-AC-011` — No booking action when self-booking is disabled**
> **Given** a tenant with `SEAT-CFG-008` at its default **disabled**
> **When** an authorised student views availability
> **Then** no booking action is offered
> **And** availability and the library's contact information remain visible
> **And** no booking attempt is made that could fail.
> **Exercises** — `LSB-FR-016`, `LSB-FR-017`

**`LSB-AC-012` — Booking mode is reported, not simplified**
> **Given** three tenants configured `Direct`, `HoldThenConfirm` and `ApprovalRequired`
> **When** an authorised student initiates booking in each
> **Then** the outcome described to the student matches that tenant's mode
> **And** no tenant's outcome is described as an immediate confirmed seat unless its mode is `Direct`.
> **Exercises** — `LSB-FR-018`

**`LSB-AC-013` — Anonymous intent survives authentication and is re-authorised**
> **Given** an anonymous visitor who initiates booking at library `L`
> **When** they complete `BC-18` authentication within `LCFG-11`
> **Then** the original action at `L` resumes
> **And** authorisation is evaluated at the moment of resumption
> **And** the preserved intent carried no credential
> **And** the intent cannot be redirected to any library other than `L`.
> **Exercises** — `LSB-FR-020`, `LSB-FR-021`, `LSB-FR-022`

**`LSB-AC-014` — State change during authentication fails cleanly**
> **Given** an anonymous visitor who initiates booking, and the library becomes Private, is suspended, or exhausts capacity during authentication
> **When** the intent is resumed
> **Then** the operation fails with an explanation naming the changed condition
> **And** it does not proceed on the pre-authentication state.
> **Exercises** — `LSB-FR-023`

**`LSB-AC-015` — Concurrency yields one success and one distinguishable failure**
> **Given** two students initiating booking for the same seat simultaneously
> **When** both initiations are forwarded to `BC-04`
> **Then** exactly one succeeds
> **And** the other receives an explicit conflict reason
> **And** the failing client can retry only against freshly read state
> **And** no silent overwrite and no double success is presented.
> **Exercises** — `LSB-FR-024`, `LSB-FR-025`

**`LSB-AC-016` — Quota cannot be beaten by racing two surfaces**
> **Given** one student with `seatQuota` of 1, initiating booking for two different seats concurrently from two sessions
> **When** both are forwarded
> **Then** exactly one allocation results
> **And** the second fails against `SEAT-INV-002`
> **And** C4 holds no lock of its own and bypasses neither lock.
> **Exercises** — `LSB-FR-026`

**`LSB-AC-017` — Idempotent retry returns the original result**
> **Given** a booking initiation forwarded with idempotency key `K` that succeeded
> **When** the same intent is retried and reaches `BC-04` again with `K`
> **Then** the original result is surfaced
> **And** exactly one allocation, one history row, one audit event and one notification fact exist
> **And** C4 did not mint a new key for the retry.
> **Exercises** — `LSB-FR-028`, `LSB-FR-029`, `LSB-FR-030`

**`LSB-AC-018` — Failures are actionable and leak nothing**
> **Given** five induced failures: not authorised · self-booking disabled · membership invalid · capacity exhausted · lock timeout
> **When** each response is inspected
> **Then** each names its distinct cause, and the lock timeout is presented as retryable
> **And** no response contains an internal identifier, a seat identifier, another student's data, a table name, a query fragment or a stack trace.

---

## §11. Traceability to authority

| Requirement group | Governing authority |
|---|---|
| `LSB-FR-001`…`006` | `AR-1`; `LIB-14B.1`, `5`, `8`; §14A.8; `LIB-14B.14`, `21`; `SEAT-FR-117` |
| `LSB-FR-007`…`012` | `LIB-14B.11`, `12`; `LIB-7.3`; `SEAT-FR-117`, `SEAT-XC-009`; §14A.5 *"Seat Capacity (Optional)"*; `XPC-CONF-009` |
| `LSB-FR-013`…`018` | `SEAT-FR-076`, `077`, `078`, `079`; `SEAT-CFG-008`, `SEAT-CFG-010`, `SEAT-BR-018`; `LIB-16.2`; `PRD-007` §28.2 |
| `LSB-FR-019`…`023` | `LIB-14B.27` `PO-4`; `LIB-14B.29`, `33`, `34`, `35`, `36`, `37`, `38`; `LIB-DISC-012`; `LCFG-11`; `SEAT-FR-087`, `091` |
| `LSB-FR-024`…`031` | `SEAT-BR-031`; `SEAT-FR-196`…`200`; `SEAT-INV-001`, `SEAT-INV-002`; `SEAT-FR-201`…`205`; `SEAT-BR-032`; `SEAT-XC-013` — **all FROZEN, cited only** |
| `LSB-FR-032`…`036` | `LIB-14B.13`, `20`, `25`; `LCFG-6`; `PRD-007` §28.2 |

---

## §12. Status

**`DRAFT` · Stage 2 · NOT FROZEN · NOT APPROVED · NOT BASELINED · Rank: none.**
Stage 3 **not** entered. **0** requirements conditional on an open decision.
**2** scope reductions forced by frozen authority and registered as
`XPC-CONF-008` and `XPC-CONF-009`. **0** ADRs, **0** contexts, **0** edges,
**0** events, **0** aggregates, **0** bookings defined, **0** locks defined,
**0** idempotency mechanisms defined, **0** `IMPL-*`, **0** Rank 1–6 documents
modified, **0** lines of code.

---

## §13. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-02 | Created. Supplied title *"Live Seat Availability & Booking"* reduced to **Seat Availability & Booking Initiation** on frozen authority: *Live* is V2 (`LIB-14B.13`, `SEAT-XC-009`, `ARCHITECTURE_RULINGS.md` §6) and *Booking* is already owned by `PRD-007` (FROZEN). 36 FR · 18 AC · 14 XC |
