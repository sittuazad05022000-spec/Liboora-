# SEAT_CARD_INTEGRATION — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md) §23, §23.4a, §30.20 (**FROZEN**) · [`../ADR/ADR-0032`](../ADR/ADR-0032-attendance-presence-visibility-to-seating.md) (**`Accepted`**, `O-5`) · [`../ADR/ADR-0033`](../ADR/ADR-0033-e27-core-cluster-edge-allowlist.md) (**`Accepted`**, `O-C`) · frozen `PRD-007` `SEAT-FR-041`/`103`/`104`/`105`/`106`/`108`/`115`/`116`.

> ⚠️ **Read §3 before writing any code.** Two accepted ADRs and two frozen PRDs
> disagree on the *transport*, and the disagreement is real rather than a reading
> error. §3 states which one governs and shows the measurement.

---

## 1. Ownership split — the rule that makes everything else follow

| Fact | Owner | Source |
|---|---|---|
| **Attendance** and **presence truth** | **`BC-03`** | §23 |
| **Seat allocation** **and live occupancy** | **`BC-04`** | §23, `E-08` |

`E-08`, verbatim: *"Seating is the occupancy owner, Attendance is the trigger."*

The relevant obligations are `ATT-FR-138`, `ATT-FR-139`, `ATT-FR-140` and
`ATT-FR-141`. `ATT-FR-141` requires this module to publish `ATT-EVT-001` and
`ATT-EVT-002` **with a stable event identifier** so Seating can act on them
idempotently.

## 2. Allocation and presence are two independent axes

Frozen `PRD-007` `SEAT-FR-041`: **"`Occupied` means allocated, not physically
present."**

The two **MUST NOT** be collapsed into one field. §23.4a is emphatic that the
separation *"is already law, and it is law on the **other** side of the
boundary"* — `SEAT-FR-103` already required the card to show the derived
`SeatState` **and** occupancy; `SEAT-FR-104`/`105`/`106` already required
cross-context values to be composed at read time, labelled **as-of**, and to
**degrade visibly** rather than fail or show stale-as-current; `SEAT-FR-115`/`116`
make occupancy **advisory and recomputable**.

**No new rule was written for this**, because *"manufacturing a problem in order
to solve it would be the more impressive-looking and less honest answer."*

## 3. How presence reaches the card — and a documented inconsistency

### 3.1 What is settled

**`ADR-0032`** is **`Accepted`** and selected option **`O-5`**: presence is
**composed at read time** by `BC-04`. The transport blocker was *dissolved by
making the path a pull* — **no fifth event was created**, because *"a pull needs
no carrier."*

### 3.2 The inconsistency, measured rather than smoothed over

`ADR-0032` originally carried `O-5` over a **new read edge `E-27`**. **`ADR-0033`
is also `Accepted`, is dated the same day, selects option `O-C`, and
`E-27` is WITHDRAWN.**

| Measurement | Result |
|---|---|
| Edge rows in BC Map (`ARCHITECTURE/LIBOORA_BOUNDED_CONTEXT_MAP.md`, **v1.7**) | **26**, contiguous `E-01` … `E-26` |
| `E-27` as an **edge row** | **0 occurrences — the edge does not exist** |
| `E-27` in the BC Map at all | **3 occurrences, all in changelog prose** recording the withdrawal |
| `E-27` cited as transport in **frozen `PRD-006`** §23.4a (L2170) | **still present — stale** |
| `E-27` cited as transport in **frozen `PRD-007`** `SEAT-FR-103` (L867) | **still present — stale** |

`ADR-0033` §5 listed the amendments its own decision requires, including *"Amend
`ADR-0032` §5.1/§6.2: `O-5` read-time composition **stands**, but it is carried by
the **frozen `SEAT-FR-104` composition pattern**, not by a new edge"* and *"Update
`PRD-006` §23.4a and `SEAT-FR-103`'s amendment note to cite the composition
pattern instead of `E-27`."*

**Those two steps have not been executed.** Both PRDs are hash-verified unchanged.
This package **does not execute them either** — amending a frozen Rank 3 document
is the Architecture Owner's act, and doing it inside a delivery package would be
precisely the unauthorised edit this work was instructed to avoid.

### 3.3 Which governs, and why

**`ADR-0033` governs.** It is `Accepted`, it explicitly selects `O-C`, it names
the BC Map in its `Amends` row, and **the BC Map v1.7 measurably has no `E-27`
row**. The residual `E-27` citations in the two frozen PRDs are **stale
references to a withdrawn edge**, and `ADR-0033` itself is the document that
withdrew it.

### 3.4 The build instruction

Compose presence at read time using the **`SEAT-FR-104` composition pattern that
frozen `PRD-007` already ratifies** — the same pattern already used for holder
name, membership status and membership expiry. **Do not create an edge.** Under
`O-C`, *"The Dependency Matrix and the allow-list are NOT amended … That is the
point of choosing it."*

`ADR-0033` states what `O-C` does **not** change: *"the four Seat Card states ·
read-time composition · 'stores none of it' · the prohibition on reading raw
Wi-Fi · **exactly four attendance events** · no `StudentCheckedOut` overload · the
5-minute grace · the 30-minute tolerance · `SEAT-FR-041`"* — and **"`O-5`
survives intact — only its transport documentation changes."**

## 4. The four presence states on the card

**Source: frozen `PRD-007` `SEAT-FR-103`**, as amended by `ADR-0032` §6.1. The
field is widened *"in fidelity only — one field, still one field"*, because a
two-valued field cannot represent a student inside an approved grace period, and
rendering that student as `not present` **would be false**.

| Presence state | Meaning |
|---|---|
| 🟢 **`PRESENT`** | Currently verified present, with a *Presence Since* time |
| 🔵 **`ATTENDED · LEFT`** | Attended today **and** a recorded exit exists; not present now |
| 🟠 **`PRESENCE UNVERIFIED`** | Attendance exists but current presence cannot be verified — **including every manually recorded attendance** |
| ⚪ **`NOT ATTENDED`** | No attendance today. **A different fact from `PRESENCE UNVERIFIED`, and MUST NOT be merged with it** |

> ⛔ **`ATTENDED · LEFT` is specified but NOT yet answerable — disclosed, not
> glossed.** `ADR-0032` records it as **still blocked and NOT unblocked by that
> ADR**: it needs *"attended earlier today"* **after** departure, but
> `SEAT-BR-036` puts period aggregation in `BC-26` and `SEAT-FR-114` **resets
> occupancy each operating day**, so `BC-04` cannot answer it from current state.
> Implement the other three states; **do not fabricate `ATTENDED · LEFT` from
> whatever is locally available.**

### 4.1 The shift-conformance badge is a separate field on a second axis

A student present beyond the booked window plus tolerance renders **🟢 `PRESENT`
and a separate ⚠ `OVERSTAY` badge**. The badge **MUST NOT** replace, recolour or
suppress the presence indicator, and **presence MUST NOT be downgraded because of
overstay** — *"presence and shift-conformance are two facts, and one field cannot
carry two facts."* Verified by **`ATT-AC-222`**.

> ⛔ **The shift-relative renderings are blocked on a different gap.** Outside-window
> and overstay both need a **booked shift `BC-03` cannot read** —
> **`ATT-GAP-002a`, OPEN**; `ADR-0029` is `Proposed`. *"The presence axis builds;
> the conformance badge waits on that input."*

### 4.2 §23.4a's six requested renderings

§23.4a records the product's **six** requested renderings and maps each to a §10A
state. They are the *request*; `SEAT-FR-103`'s four states are the *card
contract*. Both are in the package; neither is a substitute for the other.

| Requested rendering | §10A state |
|---|---|
| 🟢 **PRESENT** *(+ "Presence Since")* | `VERIFIED PRESENCE`, session open |
| 🟡 **PRESENCE CHECKING** | inside the 5-minute grace (§10A.4) — **not yet an exit** |
| ⚪ **NOT PRESENT** | no open verified presence |
| 🟡 **OUTSIDE SHIFT WINDOW** | inside tolerance but outside the booked shift (§10A.7a) |
| 🔴 **SHIFT OVERSTAY / PRESENCE OUTSIDE BOOKED WINDOW** | §10A.1 row 9 |
| 🟠 **NO BOOKED SHIFT / PRESENCE UNASSIGNED** | §10A.1 row 8 |

## 5. Four shortcuts that are refused — named so they are not retried

§23.4a and `ADR-0032` name these explicitly *"so they are not taken later by
someone who does not know they were considered."*

| # | Shortcut | Why it is refused |
|---|---|---|
| **1** | Let the Seat Card **read Wi-Fi observations directly** | Barred by `ATT-BR-045`, `SEAT-BR-020` and BC Map L292; it would relocate verification logic into the seating context that **`SEAT-FR-108` assigns to `BC-03`** |
| **2** | Have `BC-04` infer `PRESENCE CHECKING` from the **absence** of a recent event | *"Exactly the 'last known network event' fabrication §10A.5 prohibits, merely moved to another context."* `SEAT-FR-115` makes occupancy advisory **precisely so it cannot be reasoned from this way** |
| **3** | **Overload `StudentCheckedOut`** to mean *"entered grace"* | It would emit **a check-out that did not happen**, fabricating the exit §10A.5 forbids and writing an attendance-shaped fact **`SEAT-XC-007` forbids `BC-04` from holding** |
| **4** | Ship the **binary field only** (`ADR-0032` option `O-4`) | Needs zero architecture and **silently under-delivers**: a student in grace renders `NOT PRESENT`, and **an overstaying student renders `PRESENT`** — the very case the Product Owner asked to be alerted about |

## 6. Prohibitions restated (because widening a field invites them)

Frozen `SEAT-FR-103`'s amendment note restates three, and they bind the seating
side as much as this one. The seating module:

- **MUST NOT** read raw Wi-Fi or any network observation;
- **MUST NOT** perform presence verification (`SEAT-FR-108` assigns it to `BC-03`);
- **MUST NOT** infer a presence state from the **absence** of an event.

And `SEAT-FR-104` still governs: presence is **composed at read time** and **MUST
NOT be stored** on the seat or the allocation. `SEAT-FR-105`/`106` still govern
the **as-of label** and **visible degradation**.

## 7. What `BC-03` must expose, and what it must never leak

| Requirement | Obligation |
|---|---|
| Presence facts are **computed from this module's own aggregate on each read** and carry the **observation instant** they were computed from | `ATT-AC-219` |
| **Nothing obliges or permits a consumer to hold a stored copy** | `ATT-AC-219` |
| The exposed facts contain **no SSID, BSSID, signal strength, MAC address or other network datum**, and **no consumer can obtain one through the exposed path** | **`ATT-AC-218`** |
| The exposed facts carry **no invented exit timestamp**; a gap with no observation yields `INCOMPLETE / EXIT NOT VERIFIED` | **`ATT-AC-220`** |
| Presence exposure is **a read, never a fifth event** | **`ATT-AC-216`** |

## 8. Acceptance criteria for this integration (§30.20)

| ID | Criterion |
|---|---|
| `ATT-AC-214` | **Manual attendance renders 🟠 `PRESENCE UNVERIFIED`, never 🟢 `PRESENT`.** The distinguishing input is the `method` **already** carried in the `StudentCheckedIn` payload |
| `ATT-AC-215` | **⚪ `NOT ATTENDED` and 🟠 `PRESENCE UNVERIFIED` are never merged**, and **no code path maps one onto the other** |
| `ATT-AC-216` | The `attendance.*` surface still contains **exactly four** events after presence became visible on the card |
| `ATT-AC-217` | **`StudentCheckedOut` is emitted only for a real recorded exit** — entering grace emits none |
| `ATT-AC-218` | **No raw network observation crosses the module boundary** |
| `ATT-AC-219` | Presence exposed for composition is **never a stored copy** held by the consumer |
| `ATT-AC-220` | **Presence is never fabricated from silence** |
| `ATT-AC-221` | The 30-minute tolerance applies **both sides** and contributes **nothing** to booked-shift Study Hours — 05:50→10:10 on a 06:00–10:00 shift yields **exactly 4 hours** |
| `ATT-AC-222` | **Presence and shift-conformance are two axes** and are never collapsed |

## 9. Implementation checklist

- [ ] Presence **composed at read time** via the `SEAT-FR-104` pattern. **No new
      edge.** `E-27` does **not** exist.
- [ ] Presence **never stored** on the seat or the allocation.
- [ ] Allocation and presence remain **two independent fields**.
- [ ] Overstay is a **separate badge**; presence is never downgraded by it.
- [ ] `NOT ATTENDED` ≠ `PRESENCE UNVERIFIED`; no mapping between them.
- [ ] Manual attendance → `PRESENCE UNVERIFIED`, driven by the `method` field.
- [ ] **No** raw Wi-Fi datum in anything exposed.
- [ ] **No** fifth event; **no** `StudentCheckedOut` overload.
- [ ] `ATTENDED · LEFT` left **unpopulated** rather than fabricated.
- [ ] As-of instant carried; degradation **visible**, never stale-as-current.
