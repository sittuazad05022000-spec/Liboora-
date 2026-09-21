# ADR-0168 — V1 public seat-availability thresholds: `Available` < 80%, `Limited Availability` 80–<100%, `Full` = 100%, derived from allocation versus capacity only

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — **2026-09-19**, under the one-act conferral recorded **verbatim** at **§8.1**. ⛔ **Reverting on completion** *(`ADR-0033` §7.1)*. ⚠️⚠️ **NO INDEPENDENT REVIEW CLAIMED** |
| **Rank** | 2 — Architecture Decision Record |
| **Date prepared** | 2026-09-19 |
| **Bounded context** | `BC-04` Seating *(computes the state)* · Library §14B Public Preview *(the contract served)* |
| **Supersedes** | ⛔ **NOTHING** |
| **Superseded by** | — |
| ⭐⭐ **Deciding authority** | ⭐⭐ **Product Owner** — `PRD_OWNERSHIP_MODEL` §2.2 *("business intent: scope, priority, acceptance")*; ⭐ the office **`ADR-0167`** §1 `D-4` and §9 step 1 expressly reserved this to |
| **Contributing offices** | ⛔⛔ **NONE.** ⛔ No Architecture, Privacy or Security Owner input is claimed or exercised |
| **Decides** | ⭐ **The three threshold boundaries** · ⭐ **the derivation input class** · ⭐ **the privacy limb on free-seat counts**. ⛔ **Nothing else** |
| **Expressly does NOT decide** | ⛔ The `E-35` edge *(already decided — `ADR-0167`)* · ⛔ the event **name** · ⛔ the BC Map amendment · ⛔ any UI, widget, copy or layout · ⛔ `SEAT-CFG-017` · ⛔ `SEAT-GAP-005` / `SEAT-GAP-014` · ⛔ `LIB-24.2`'s privacy review · ⛔ Public Live Occupancy *(stays **V2**)* · ⛔ ⚠️ **the two residual ambiguities at §5** · ⛔ any `PERM-*`, role, office or scope |
| **Amends** | ⛔⛔ **NOTHING.** ⭐ It **supplies the value** `ADR-0167` `D-4` left open |
| **Origin** | ⭐ **`ADR-0167`** §9 step 1 — the **blocking** Product Owner act |

> ⭐⭐ **Identifier check, performed immediately before drafting.** `ADR-0167` is the
> highest ADR file present. `ADR-0168` measured **0** files on disk and **0**
> references in `docs/`. `ADR-0150`…`ADR-0167` gap-tested **contiguous**. ⛔ No
> number reused *(`ADR-INDEX` Process rule 2)*.

---

## 1. ⭐⭐ The decision

### `D-1` — ⭐ The three thresholds

⭐ Let **`A`** = the number of seats with an **active allocation**, and **`C`** = the
**total seat capacity** *(⚠️ see **§5.1** — the precise meaning of `C` carries a
disclosed ambiguity this ADR does **not** resolve)*.

| State | Condition | Boundary form |
|---|---|---|
| ⭐ **`Available`** | `A / C` **< 80%** | ⛔ 80% **excluded** |
| ⭐ **`Limited Availability`** | **80% ≤** `A / C` **< 100%** | ⭐ 80% **included**; ⛔ 100% **excluded** |
| ⭐ **`Full`** | `A / C` **= 100%** | ⭐ 100% **included** |

⭐⭐ **The bands are contiguous, non-overlapping and exhaustive over `0% ≤ A/C ≤ 100%`.**
⭐ Each boundary belongs to **exactly one** band — ⛔ there is no value of `A/C` in
range that yields two states or none.

### `D-2` — ⭐⭐ The derivation input is ALLOCATION, and attendance is forbidden

⭐ The state **MUST** be computed **inside `BC-04`** from **`SeatAllocation` state
versus seat capacity**.

⛔⛔ **It MUST NOT be derived from, or influenced by:**

| ⛔ Forbidden input | Authority |
|---|---|
| Attendance records | ⭐⭐ **`LIB-14B.14`** |
| Physical presence, check-in or check-out | `LIB-14B.14`; ⭐ `BC-03` is not an input |
| The `E-08`-fed **live occupancy** figure | `LIB-14B.14`; ⭐ `E-08` is the attendance edge |
| Arrival, departure or dwell timing | `LIB-14B.14` |
| ⭐ **Occupancy rate** *(as distinct from allocation rate)* | ⭐⭐ **`SEAT-FR-245`** — §3.2 |

### `D-3` — ⭐ Exact free-seat counts remain private

⛔⛔ **No exact or approximate free-seat count, allocated count, capacity figure,
percentage or ratio may be published**, in the payload or on any public surface.
⭐ The public output is the **state label alone**.

⭐ This **confirms and does not weaken** `ADR-0167` `D-3`, `LIB-14B.12`,
`LIB-14B.11` and `SEAT-FR-117`. ⭐⭐ **The percentages in `D-1` are an internal
computation rule, ⛔ NOT a published value.**

### `D-4` — ⛔ The configurable 90% threshold/event remains **V2**

⛔⛔ **`SEAT-CFG-017` and `SEAT-EVT-004` are untouched.** ⭐ `SEAT-CFG-017` remains
**HELD** and *"Unset in V1 — no event is emitted and no value is substituted"*;
⛔ `SEAT-GAP-005` stays **OPEN**; ⛔ the **90%** figure is **not** applied as a
fallback *(§27.1 forbids it in terms)*.

⭐⭐ **The 80% in `D-1` and the 90% in `SEAT-CFG-017` are unrelated numbers serving
unrelated mechanisms** — §4.

---

## 2. ⭐ Scope

| Dimension | Disposition |
|---|---|
| ⭐ Threshold values | ⭐⭐ **DECIDED** |
| ⭐ Boundary inclusivity | ⭐⭐ **DECIDED** — §3.1 |
| ⭐ Derivation input class | ⭐ **CONFIRMED** *(`ADR-0167` fixed it; this ADR restates it as product intent)* |
| ⭐ Free-seat privacy | ⭐ **CONFIRMED** |
| ⚠️ **Meaning of "capacity"** | ⛔⛔ **NOT RESOLVED — §5.1** |
| ⚠️ **Zero-capacity behaviour** | ⛔⛔ **NOT RESOLVED — §5.2** |
| ⛔ Event name · BC Map edit · UI · code | ⛔ **NOT DECIDED** |

---

## 3. ⭐ Why this decision is sound on the evidence

### 3.1 ⭐⭐ The boundaries were made explicit, because the English was not

⚠️ The instruction reads *"**below 80%**"*, *"**80% to below 100%**"*, *"**reach
100%**"*. ⭐ That is unambiguous in intent, ⛔ but an implementer needs the operators.
⭐⭐ **`D-1` states them without altering the decision:**

| Reading | `A/C = 79.9%` | `A/C = 80%` | `A/C = 99.9%` | `A/C = 100%` |
|---|---|---|---|---|
| ⭐ `D-1` | `Available` | ⭐ **`Limited`** | `Limited` | ⭐ **`Full`** |

⭐ *"below 80%"* ⇒ 80% is **not** `Available`; *"80% to below 100%"* ⇒ 80% **is**
`Limited`; *"reach 100%"* ⇒ 100% **is** `Full`. ⭐⭐ **Each boundary lands in exactly
one band — the decision is internally complete.**

### 3.2 ⭐⭐ The frozen specification independently supports the allocation basis

⭐ **`SEAT-FR-245`** *(FROZEN)*:

> *"**Allocation rate and occupancy rate MUST be presented as two distinct figures
> and MUST NOT be labelled interchangeably.** A seat allocated to an absent student
> is allocated but not occupied. Conflating them produces a number that is wrong in
> one of the two senses no matter how it is read."*

⭐ And **`SEAT-AC-173`**: *"A zone with 100 seats, **70 allocated**, 40 holders
checked in → **70% and 40%**, never conflated into one."*

⭐⭐ **The Product Owner's choice of allocation is the one of the two that
`LIB-14B.14` permits, and the frozen spec already names it as a distinct,
separately-requestable figure.** ⛔ The 40% occupancy figure is the attendance-derived
one and is forbidden. ⭐ **The decision and the specification agree.**

### 3.3 ⭐ The chosen basis answers the stated commercial need

⭐ 14B: *"The commercial need is **'do they have room for me?'** — which a coarse
indicator answers completely."* ⭐⭐ **Allocation is the correct basis for that
question**: a seat allocated to an absent student is **not available to a walk-in**.
⛔ An occupancy-based reading would advertise it as free.

### 3.4 ⭐ No collision with existing values

| Probe | Result |
|---|---|
| `80%` in `PRD-007` or the Library PRDs | ⛔ **0** — ⭐ no existing threshold is displaced |
| `A ≤ C` guaranteed? | ⭐ BC Map **L373** — *"**One active allocation per seat per time window**"* *(pessimistic lock / DB unique constraint)* ⇒ ⭐⭐ `A` cannot exceed the **configured seat count** |

---

## 4. ⛔⛔ The 80% and the 90% are unrelated — proven, not asserted

⚠️ ⭐ Two percentages now exist near seat capacity. ⭐⭐ **They must never be
conflated**, and the instruction was right to separate them.

| | ⭐ **This decision's 80%** | ⛔ **`SEAT-CFG-017`'s 90%** |
|---|---|---|
| **Purpose** | ⭐ Selects a **public display label** | ⛔ Triggers an **internal event** |
| **Mechanism** | ⭐ A read projection over `E-35` | ⛔ `SEAT-EVT-004` `seating.OccupancyThresholdCrossed` |
| **Consumers** | ⭐ Public preview *(via `BC-23`)* | ⛔ `BC-22`, `BC-26` |
| **Input** | ⭐⭐ **Allocation** ÷ capacity | ⛔⛔ **Live occupancy** *(attendance-derived)* |
| **Configurable?** | ⛔ **NO** — `LIB-7.4`: *"never a configuration toggle"* | ⭐ **YES** — a `BC-06`-owned configurable |
| **Owner** | ⭐ `BC-04`, value set here | ⛔ **`BC-06` via `E-05`** |
| **V1 status** | ⭐⭐ **V1** | ⛔⛔ **V2 — HELD**, *"Unset in V1"*, `SEAT-GAP-005` **OPEN** |

⭐⭐ **Different input, different mechanism, different consumers, different owner,
different tier.** ⛔ Deciding the 80% does **not** decide, unblock, substitute for or
pre-empt the 90%.

---

## 5. ⚠️⚠️ Two residual ambiguities — DISCLOSED, ⛔ NOT resolved

⭐⭐ **Both were found by measurement while verifying this decision. ⛔ Neither is
invented away, and ⛔ neither is resolved here — resolving them was not conferred.**

### 5.1 ⚠️⚠️ "Total capacity" is not a single number in this repository

⭐ **`SEAT-FR-018`** *(FROZEN)*:

> *"Where a `Floor`'s **declared capacity** (`LIB-10.4`) and the **seat count
> configured** here differ, this module **MUST** surface the difference and **MUST
> NOT** silently reconcile it."*

⭐ **`SEAT-AC-010`**: *"A floor declares capacity **50** and **60** seats are
configured → **both** figures are shown as distinct labelled values; **neither is
silently corrected**."*

⛔⛔ **So `C` in `A / C` has two candidate meanings**, and with 50 vs 60 the same
allocation yields **different public states**.

| Candidate `C` | ⭐ Argument for | ⚠️ Argument against |
|---|---|---|
| ⭐ **Configured seat count** *(`BC-04`)* | ⭐⭐ `BC-04` owns it; ⭐ `A ≤ C` is guaranteed by the **L373** invariant; ⭐ it is what a walk-in can actually occupy | ⚠️ May exceed the library's declared capacity |
| ⭐ **Declared capacity** *(`LIB-10.4`, `BC-06`)* | ⭐ The library's own published figure; ⭐ `LIB-7.3`'s *"aggregate count"* sense | ⛔⛔ **`A` could exceed `C`**, producing `A/C > 100%` — ⭐ a state `D-1` does not define |

⚠️ **Provisional note, ⛔ NOT a decision:** the **configured seat count** is the only
candidate for which `A ≤ C` is structurally guaranteed. ⛔⛔ **This ADR does not
choose it.** ⭐ Routed to the **Product Owner** *(which figure expresses the intent)*
with **Architecture Owner** input *(which is computable within `BC-04` without a new
edge — `LIB-10.4` is `BC-06`-owned)*.

⭐ Registered as **`GAP-SEATAVAIL-CAPACITY`**.

### 5.2 ⚠️ Zero-capacity behaviour is undefined

⛔ If `C = 0`, `A / C` is undefined — ⛔ and `D-1` assigns **no state**.

⭐ Measured: **no** requirement in `PRD-007`, the Library PRD or §14B addresses a
library with zero configured seats. ⭐ It is reachable — a library may publish a
public profile before configuring a seat layout.

⛔⛔ **Not resolved here.** ⭐ Candidate dispositions *(offered as options, ⛔ not
chosen)*: publish **no** availability field at all *(⭐ `LIB-14B.10`: "a field with
no owner **MUST NOT** be published"; ⭐ `LIB-14B.11` lists seat information as
publishable, ⛔ not mandatory)*; or treat it as **not applicable**. ⛔ Treating it as
`Full` or `Available` would both be misleading.

⭐ Registered as **`GAP-SEATAVAIL-ZEROCAP`**. ⭐ Routed to the **Product Owner**.

### 5.3 ⭐ Why these do not block recording the decision

⭐⭐ **The thresholds are decided and are correct as stated.** ⛔ The two residuals
are **parameters of the formula**, not the boundaries themselves — ⭐ and both must be
settled before implementation. ⭐ They join `ADR-0167` §9 as **blocking** items.

---

## 6. ⛔ Alternatives and inferences REFUSED

| # | Move | ⛔ Refused because |
|---|---|---|
| 1 | ⭐ Resolve `C` myself as the configured seat count | ⛔⛔ **A product decision** — it changes which libraries read `Full`. ⭐ §5.1 discloses and routes it |
| 2 | ⭐ Define zero-capacity behaviour | ⛔ Same — ⭐ §5.2 |
| 3 | ⭐ Treat 80% and 90% as one threshold, or align them | ⛔⛔ **§4** — different input, mechanism, consumers, owner and tier. ⭐ The instruction expressly kept 90% at V2 |
| 4 | ⭐ Use the live occupancy figure because `BC-04` already has it | ⛔⛔ **`LIB-14B.14`** — it is `E-08`-fed from `BC-03` Attendance; ⛔ **`SEAT-FR-245`** forbids conflating the two rates |
| 5 | ⭐ Publish the percentage since it is now defined | ⛔⛔ **`D-3`**, `LIB-14B.12`, `ADR-0167` `D-3`. ⭐⭐ The percentage is an **internal computation**, ⛔ never a published value |
| 6 | ⭐ Mint the event name or amend the BC Map while here | ⛔ **Architecture Owner** acts — `ADR-0167` §9 steps 2–3; ⛔ outside this conferral |
| 7 | ⭐ Record this inside `ADR-0167` | ⛔⛔ **`ADR-INDEX` Process rule 2** — *"**Never edit an Accepted ADR's decision text**"*. ⭐ `ADR-0167` is `Accepted`; ⭐⭐ a separate ADR by a **different office** is the correct form |

---

## 7. ⭐ Authority

⭐ **Product Owner** — `PRD_OWNERSHIP_MODEL` §2.2: *"business intent: **scope,
priority, acceptance**"*. ⭐⭐ `ADR-0167` §1 `D-4` reserved this act in terms:
*"⛔⛔ **This ADR does NOT decide what makes a library `Available`, `Limited` or
`Full`.** ⭐ That is a **Product Owner** act."*

⭐ **The two offices did not overlap.** ⭐⭐ `ADR-0167` *(Architecture)* fixed **which
data may cross the boundary** — a lineage question. ⭐ This ADR *(Product)* fixes
**what the cut-offs are** — an intent question. ⛔ Neither trespassed.

⛔ **This office may NOT:** create roles or permissions *(⛔ conferral; `AUTH-7.22`
closed at zero)* · amend frozen/approved specs *(⛔ conferral)* · alter edges or
boundaries *(**Architecture Owner**)* · decide document status *(**Governance
Owner**)*.

---

## 8. ⭐⭐ Authority record

### 8.1 ⭐⭐ The conferral — VERBATIM

> ⭐⭐ **VERBATIM — human principal of this engagement, as Product Owner, 2026-09-19:**
>
> ```
> "As Product Owner, I decide the V1 public seat-availability thresholds as
> follows: `Available` when allocated seats are below 80% of capacity; `Limited
> Availability` when allocated seats are 80% to below 100%; and `Full` when
> allocated seats reach 100%. The derivation must use seat allocation versus total
> capacity only, never attendance or physical presence. Exact free-seat counts
> remain private. The configurable 90% occupancy threshold/event remains V2.
> Record this decision in the appropriate ADR; do not modify frozen/approved
> specifications or create permissions or roles."
> ```

### 8.2 ⭐ Validity

| # | Element | Supplied? | Words relied on |
|---|---|---|---|
| 1 | First-person, office named | ⭐ **YES** | *"**As Product Owner, I decide**"* |
| 2 | Single, bounded subject | ⭐ **YES** | *"the V1 public seat-availability **thresholds**"* |
| 3 | The decision itself | ⭐ **YES** | ⭐ All three bands stated |
| 4 | Derivation constraint | ⭐ **YES** | *"allocation versus total capacity only, **never attendance or physical presence**"* |
| 5 | Privacy constraint | ⭐ **YES** | *"Exact free-seat counts **remain private**"* |
| 6 | V2 preservation | ⭐ **YES** | *"The configurable 90% … **remains V2**"* |
| 7 | Recording instruction | ⭐ **YES** | *"**Record this decision in the appropriate ADR**"* |
| 8 | Express prohibitions | ⭐ **YES** | *"do not modify frozen/approved specifications or create permissions or roles"* |

⭐⭐ **8 / 8.** ⭐ `ADR-0080` **L7**; `ADR-0106` — *"the only authority competent"*.

### 8.3 ⚠️ Two form notes, recorded rather than smoothed over

⚠️ **(a) The instruction did not use the word *"confer"*, and did not state a
reversion.** ⭐ It says *"**As Product Owner, I decide**"* — ⭐⭐ **a direct exercise
of the office rather than a conferral onto this engagement**, which is the stronger
form: ⛔ nothing is delegated, ⭐ the principal decides. ⭐ The `ADR-0164` §4.2
distinction *(product confirmation vs conferral)* is **not** engaged, because this
is not an authorization allocation — ⛔ no role gains a capability. ⭐ Consistent with
`PRD_OWNERSHIP_MODEL` §7 rule 4, ⛔ **no personal name is recorded**.

⚠️ **(b) Acceptance was not expressly mentioned.** ⭐ The instruction says *"**Record
this decision in the appropriate ADR**"*. ⭐⭐ Recording a decision **already taken**
by the competent office is the recording act itself — ⭐ unlike `ADR-0165`/`0166`,
where the office had to be conferred **in order to decide**, and where acceptance
therefore needed express cover. ⭐ Here the decision **pre-exists the ADR**; ⛔ the ADR
does not make it. ⭐ Accordingly the status is `Accepted` **as a record of a Product
Owner decision**, ⛔ **not** as an independent governance ratification of it.

### 8.4 ⛔ Not reused

⛔ `ADR-0167`'s **Architecture Owner** conferral — ⭐ reverted on completion,
⛔ different office. ⛔ `ADR-0162` §2 · `ADR-0164` §10.2 · `ADR-0165` §9.1 ·
`ADR-0166` §9.1 — ⭐ all **Authorization Owner**, all spent.

---

## 9. ⭐ What remains before implementation

| # | Act | Office | Status |
|---|---|---|---|
| ⭐ ~~1~~ | ~~Decide the thresholds~~ | ~~Product Owner~~ | ⭐⭐ **DONE — this ADR** |
| ⚠️ **1a** | ⭐⭐ **Resolve `GAP-SEATAVAIL-CAPACITY`** — which figure is `C` | **Product Owner** *(+ Architecture input)* | ⛔⛔ **BLOCKING** |
| ⚠️ **1b** | ⭐ **Resolve `GAP-SEATAVAIL-ZEROCAP`** | **Product Owner** | ⛔⛔ **BLOCKING** |
| 2 | Mint the `E-35` event name in `BC-04`'s closed register | Architecture Owner | ⛔ Outstanding |
| 3 | Execute the BC Map append → v1.19 | Architecture Owner | ⛔ Outstanding |
| 4 | Register `ADR-0167` **and** `ADR-0168` in `ADR-INDEX` | Governance Owner | ⛔ Outstanding |
| 5 | Design the public surface | UX Architecture Owner | ⛔ Outstanding |
| 6 | Implement | Technical | ⛔ Outstanding |

---

## 10. ⭐ Sources

| # | Source | Locus | Relied on for |
|---|---|---|---|
| 1 | ⭐⭐ `ADR-0167` | `D-3`, `D-4`, §5.2, §9 | ⭐ **The edge, the payload boundary, and the reservation of this act** |
| 2 | ⭐⭐ `PRD-SEAT-MANAGEMENT.md` **FROZEN** | **`SEAT-FR-245`**, `SEAT-AC-173`, **`SEAT-FR-018`**, `SEAT-AC-010`, `SEAT-FR-041`, `SEAT-FR-117`, `SEAT-XC-020`, §27.1 | ⭐ **Allocation ≠ occupancy; the capacity ambiguity** |
| 3 | `14B-Public-Library-Preview.md` | `LIB-14B.11`, **`LIB-14B.12`**, **`LIB-14B.14`**, `LIB-14B.10` | The V1 contract and the privacy limb |
| 4 | `Library_PRD_v1.md` | `LIB-7.3`, **`LIB-7.4`**, `LIB-10.4`, `LIB-24.2` | Aggregate-only; ⛔ never a toggle |
| 5 | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **L373**, **L305** | ⭐ `A ≤ C` invariant; ⛔ `E-08` is the attendance edge |
| 6 | `PRD_OWNERSHIP_MODEL` | §2.2, §7 rule 4 | The Product Owner's remit; ⛔ no personal name |
| 7 | `ADR-0080` · `ADR-0106` · `ADR-0033` | L7 · L7 · §7.1 | Authority mechanism |
| 8 | `ADR-INDEX` | Process rule 2 | ⛔ Never edit an Accepted ADR |

---

## 11. ⭐ Status after acceptance

| Item | State |
|---|---|
| **This ADR** | ⭐⭐ **Accepted** — 2026-09-19 |
| ⭐ **Thresholds** | ⭐⭐ **DECIDED** — `<80` / `80–<100` / `=100` |
| ⭐ **Derivation** | ⭐ **Allocation ÷ capacity**; ⛔ **never attendance** |
| ⭐ **Free-seat counts** | ⛔ **PRIVATE** |
| ⚠️ **`GAP-SEATAVAIL-CAPACITY`** | ⛔⛔ **OPEN — BLOCKING** *(Product Owner)* |
| ⚠️ **`GAP-SEATAVAIL-ZEROCAP`** | ⛔⛔ **OPEN — BLOCKING** *(Product Owner)* |
| **`E-35`** | ⭐ Declared *(`ADR-0167`)*; ⛔ BC Map **not yet amended** |
| **Event name** | ⛔ **NOT minted** |
| **`SEAT-CFG-017` / 90%** | ⛔⛔ **V2, HELD** — untouched; `SEAT-GAP-005` **OPEN** |
| **Public Live Occupancy** | ⛔ **V2** — unchanged |
| **`SEAT-GAP-014`** | ⛔ **OPEN** — not engaged |
| **`PERM-*`** | ⛔ **0** — `AUTH-7.22` closed at zero |
| **Coverage / holds** | ⭐ **95 / 104** · ⛔ **9** — unchanged |
| **`ADR-INDEX`** | ⛔ **Not modified** — a Governance Owner act |

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| ⭐⭐ **1.0** | 2026-09-19 | ⭐⭐ **Created and `Accepted`. The V1 public seat-availability thresholds are DECIDED by the Product Owner: `Available` when allocated < 80% of capacity, `Limited Availability` at 80% to below 100%, `Full` at 100%** — supplying the value **`ADR-0167`** `D-4` expressly left open and reserved to this office. ⭐⭐ **THE BOUNDARY OPERATORS WERE MADE EXPLICIT** *(§3.1)* — the instruction's English *("below 80%", "80% to below 100%", "reach 100%")* is unambiguous in intent ⛔ but an implementer needs the inclusivity: ⭐ **80% is `Limited` not `Available`; 100% is `Full`**; the bands are **contiguous, non-overlapping and exhaustive**, ⛔ with no value yielding two states or none. ⭐⭐ **THE FROZEN SPECIFICATION INDEPENDENTLY CORROBORATES THE ALLOCATION BASIS** *(§3.2)* — **`SEAT-FR-245`**: *"**Allocation rate and occupancy rate MUST be presented as two distinct figures and MUST NOT be labelled interchangeably.** A seat allocated to an absent student is allocated but not occupied"*, with **`SEAT-AC-173`** *(100 seats, 70 allocated, 40 checked in → **70% and 40%**, never conflated)* — ⭐⭐ **the Product Owner chose the one of the two figures that `LIB-14B.14` permits**, the other being attendance-derived and forbidden; ⭐ and it is the right basis commercially, since **a seat allocated to an absent student is not available to a walk-in**. ⭐⭐ **THE 80% AND `SEAT-CFG-017`'s 90% ARE PROVEN UNRELATED** *(§4)* — different **input** *(allocation vs live occupancy)*, **mechanism** *(read projection vs `SEAT-EVT-004`)*, **consumers** *(public vs `BC-22`/`BC-26`)*, **owner** *(`BC-04` vs **`BC-06` via `E-05`**)*, **configurability** *(⛔ `LIB-7.4` "never a configuration toggle" vs configurable)* and **tier** *(V1 vs **V2**)*; ⛔⛔ **`SEAT-CFG-017` stays HELD and "Unset in V1", `SEAT-GAP-005` stays OPEN, and the 90% is NOT applied as a fallback.** ⚠️⚠️ **TWO RESIDUAL AMBIGUITIES WERE FOUND BY MEASUREMENT AND ARE DISCLOSED, ⛔ NOT INVENTED AWAY** *(§5)*: **(1) `GAP-SEATAVAIL-CAPACITY`** — ⭐⭐ *"total capacity"* **is not a single number in this repository**: FROZEN **`SEAT-FR-018`** holds that a `Floor`'s **declared capacity** *(`LIB-10.4`)* and the **configured seat count** may differ and *"**MUST NOT** be silently reconciled"*, with **`SEAT-AC-010`** giving **50 vs 60** — ⛔ so the same allocation yields **different public states** depending on which is `C`; ⚠️ noted provisionally that only the configured count structurally guarantees `A ≤ C` *(BC Map **L373**)*, ⛔⛔ **but NOT chosen — it is a product decision**; **(2) `GAP-SEATAVAIL-ZEROCAP`** — ⛔ `C = 0` leaves `A/C` undefined and `D-1` assigns **no state**, and ⭐ **no requirement anywhere addresses a zero-seat library**, which is reachable. ⭐⭐ **Both are registered, routed to the Product Owner, and added to the BLOCKING list at §9.** ⛔ **SEVEN MOVES REFUSED** *(§6)*, incl. ⛔ resolving `C` or the zero case myself *(product decisions)*, ⛔ aligning the 80% with the 90%, ⛔ using the `E-08`-fed live occupancy *(`LIB-14B.14`, `SEAT-FR-245`)*, ⛔ publishing the percentage now that it is defined *(⭐⭐ it is an **internal computation**, ⛔ never a published value)*, and ⛔⛔ **recording this inside `ADR-0167`** — *"**Never edit an Accepted ADR's decision text**"* *(Process rule 2)*, ⭐ a separate ADR by a **different office** being the correct form. ⚠️ **TWO FORM NOTES RECORDED RATHER THAN SMOOTHED OVER** *(§8.3)*: the instruction said *"**As Product Owner, I decide**"* ⛔ without the word *"confer"* and ⛔ without a reversion clause — ⭐⭐ **a direct exercise of the office, which is the stronger form**, and ⛔ not an authorization allocation, so `ADR-0164` §4.2 is not engaged; and ⭐ acceptance was not expressly mentioned, so the status is `Accepted` **as a record of a decision already taken by the competent office**, ⛔ **not** as an independent ratification of it. ⭐⭐ **THE TWO OFFICES DID NOT OVERLAP** — `ADR-0167` *(Architecture)* fixed **which data may cross the boundary** *(lineage)*; this ADR *(Product)* fixes **what the cut-offs are** *(intent)*. ⛔ Supersedes **NOTHING** · ⛔ **0** frozen/approved specs modified · ⛔ **0** `PERM-*` *(`AUTH-7.22` closed at zero)* · ⛔ **0** roles, offices or scopes · ⛔ **0** edges, contexts, aggregates or events · ⛔ **0** free-seat counts published · ⛔ **0** UI or runtime code · ⛔ `SEAT-CFG-017`, `SEAT-GAP-005`, `SEAT-GAP-014` and `LIB-24.2` untouched · ⛔ coverage **95 / 104** and **9** holds unchanged · ⛔ `ADR-INDEX` **not modified** · ⛔ **no commit, no push**. |
