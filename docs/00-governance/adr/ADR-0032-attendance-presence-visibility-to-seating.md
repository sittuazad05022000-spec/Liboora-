# ADR-0032 — Attendance presence visibility to Seating: how live student presence reaches the Seat Card

| Field | Value |
|---|---|
| **ADR** | **`ADR-0032`** |
| **Status** | **Accepted** — in force, binding on all implementation. *(`ADR-INDEX.md` status vocabulary: "In force. Binding on all implementation")*. **Option `O-5` selected — see §5.1.** Authority basis recorded verbatim in §5.2; it is a **conferral by the human principal**, not an ARB meeting, and it is not represented as one |
| **Date** | 2026-08-05 |
| **Raised by** | `PRD-006` Attendance Management §23.4a, `ATT-GAP-002b` |
| **Authority to decide** | **Architecture Owner** (BC Map §7 — a new edge or a widened contract), with **Seat Management product owner** consulted because a **frozen Rank 3** requirement is implicated |
| **Contexts** | `BC-03` Attendance (source of presence) · `BC-04` Seating (owner of the Seat Card and of occupancy) |
| **Blocks** | ~~The Seat Card live presence display in `PRD-006` §23.4a, in full~~ — **released by this acceptance.** See §5.1 |
| **Amends** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` §7.1 — **one new edge `E-27`**, no edge removed, no existing edge's mode, mechanism or contract changed *(Rank 4)* · `PRD-SEAT-MANAGEMENT.md` `SEAT-FR-103` — **one field cell** *(Rank 3, **FROZEN**)* · `TRACEABILITY_MATRIX.md` §2F — `ATT-AC-*` count only *(Rank 4)*. **No context added, no aggregate changed, no event added, no invariant relaxed** |

---

## 1. The requirement, stated as the product stated it

The Seat Card must show **current student presence** alongside **seat allocation**, and the two **MUST NOT** be
collapsed into one field. Six renderings are named: 🟢 `PRESENT` (with a *Presence Since* time) · 🟡
`PRESENCE CHECKING` (inside the approved 5-minute grace) · ⚪ `NOT PRESENT` · 🟡 `OUTSIDE SHIFT WINDOW` · 🔴
`SHIFT OVERSTAY / PRESENCE OUTSIDE BOOKED WINDOW` · 🟠 `NO BOOKED SHIFT / PRESENCE UNASSIGNED`.

The required direction of flow is fixed and this ADR does not reopen it:

```
Wi-Fi observation → Attendance verification → student presence → existing Seat/Occupancy contract → Seat Card
```

**The Seat Card MUST NOT read raw Wi-Fi data.** No `Wi-Fi → BC-04` edge is proposed in any option below.

## 2. What is already satisfied — established by inspection, so that it is not re-litigated

**The conceptual separation the requirement asks for is already law, and it is law on the frozen side.** This was
checked in the source document rather than assumed:

| Already-existing guarantee | Where |
|---|---|
| **"`Occupied` means allocated, not physically present."** Physical presence is separately derived | frozen `SEAT-FR-041` |
| The seat card **already** shows the derived `SeatState` **and** `occupancy (present / not present)` | frozen `SEAT-FR-103` |
| Cross-context values on the card are **composed at read time**, never stored on the seat | frozen `SEAT-FR-104` |
| Composed values are **labelled as-of** and never presented as authoritative | frozen `SEAT-FR-105` |
| An unavailable composed value renders **marked unavailable**, never stale-as-current, never a failure | frozen `SEAT-FR-106` |
| Occupancy is **advisory and recomputable**; the allocation is the authoritative fact | frozen `SEAT-FR-115`, `SEAT-FR-116` |
| Neither module holds a shadow copy of the other's system of record | `ATT-BR-045`, `SEAT-BR-020` |

> **Therefore the "don't overwrite seat status with attendance status / keep the two dimensions independently
> queryable" requirement needs no new rule at all.** It is guaranteed today. Saying otherwise would manufacture a
> problem in order to solve it. **What follows is about fidelity and transport only.**

## 3. What is missing — two distinct blockers, and both were measured

### 3.1 The frozen contract is BINARY; the requirement needs SIX renderings

`SEAT-FR-103` specifies `occupancy (present / not present)`. `PRESENCE CHECKING`, `OUTSIDE SHIFT WINDOW`,
`SHIFT OVERSTAY` and `NO BOOKED SHIFT` **cannot be represented in a two-valued field.** Widening it modifies a
**frozen Rank 3** requirement — not this ADR's act, and not `PRD-006`'s.

### 3.2 The event surface is CLOSED — proved, not argued

`E-08` carries exactly `StudentCheckedIn` / `StudentCheckedOut`. A presence **state change that is neither a
check-in nor a check-out** — entering grace, crossing the booked-shift end, crossing tolerance into overstay — **has
no event to travel on.**

A fifth `attendance.*` event was injected into `PRD-006` §22.1 and the Stage 5 gate re-run:

```
FAIL — 5 problem(s):
  * section 0.3 declares ATT-EVT-* as 4 ending 004; computed 5 ending 005
  * section 0.3 total is 516; computed 517
  * section 0.3 obligation-bearing is 285; computed 286
  * ATT-NFR-010 requires every obligation to carry a criterion; 1 uncovered: [<probe identifier>]
  * section 2F registers ATT-EVT-* as 4 (001..004); computed 5 (001..005)
```

The probe was **reverted** and the gate returned to exit 0 before this ADR was written. Four independent
obligations agree: `ATT-FR-134` (no invented event name), `ATT-AC-117` (**"exactly four … and no other"**),
`PRD-006` §0.3, and **Rank 4** `TRACEABILITY_MATRIX.md` §2F.

> **This is the same shape as `R-19` and NOT the shape the two new status strings had.** Status rows 8/9 were addable
> because status strings are **not registered identifiers** — measured, `grep` over the matrix = 0. An **event is** a
> registered identifier. **Three superficially similar additions have now produced three different verdicts, and each
> was probed separately rather than inferred from the others.**

## 4. Three shortcuts, named and refused

Named explicitly so they are not taken later by someone who does not know they were considered.

| Shortcut | Why it is refused |
|---|---|
| Let the Seat Card read Wi-Fi observations directly | `ATT-BR-045`, `SEAT-BR-020`, BC Map **L292**. It would also put verification logic inside the seating context, which `SEAT-FR-108` assigns to `BC-03` |
| Have `BC-04` infer `PRESENCE CHECKING` from the **absence** of a recent event | This is exactly the *"last known network event"* fabrication `PRD-006` §10A.5 prohibits, **relocated to another context**. `SEAT-FR-115` makes occupancy advisory precisely so it cannot be reasoned from this way |
| Overload `StudentCheckedOut` to mean "entered grace" | It would emit **a check-out that did not happen** — fabricating the exit §10A.5 forbids, and writing an attendance-shaped fact `SEAT-XC-007` forbids `BC-04` from holding |

## 5. Options, for the Architecture Owner

**`O-5` is SELECTED (§5.1). `O-1`…`O-4` are recorded as NOT selected, with reasons, and are left visible rather than deleted** — an options table edited down to the winner is no longer a record of a decision.

| # | Option | What it costs | What it needs |
|---|---|---|---|
| **O-1** | **Widen the existing `E-08` contract's payload** to carry a richer presence state, keeping one edge and one event family | Changes an event **shape**, so every existing consumer (`BC-04`, `BC-26`, `BC-22`) must tolerate it; `ATT-EVT-001`/`002` semantics stay check-in/check-out, so the extra states still have no *trigger* even if the payload could hold them | BC Map §9 amendment; consumer review. **Does not by itself solve §3.2** |
| **O-2** | **A fifth `attendance.*` event** — a presence-state-changed event | **Two Rank 4 amendments** (§2F `ATT-EVT-*` count, and an `ATT-AC` for `ATT-NFR-010` coverage), plus `ATT-AC-117` restatement. Measured cost: the 5-way gate failure in §3.2 | Architecture Owner + the Rank 4 register owner. **This is the honest cost, not a reason to prefer a cheaper-looking option that does not work** |
| **O-3** | **A read-side composition**: `BC-04` composes presence at card-read time from a `BC-03` read projection, exactly as `SEAT-FR-104` already composes name and membership from `BC-01`/`E-02` | Needs a `BC-03` → `BC-04` **read** path that does not exist; but it **reuses a pattern the frozen document already ratifies**, needs no new event, and inherits `SEAT-FR-105`/`106`'s as-of labelling and visible degradation for free. The card refreshes on read, not on push | A new edge (BC Map §7) + widening `SEAT-FR-103`'s occupancy field. **Flagged as the option most consistent with existing ratified patterns — which is an observation about fit, not a decision** |
| **O-4** | **Ship the binary field only in V1** — 🟢/⚪ from existing `E-08`, and defer the four richer states | **Zero new architecture.** But it silently under-delivers: a student in grace renders as `NOT PRESENT`, and an overstaying student renders as `PRESENT` — the two cases the product asked for most | Product Owner acceptance that the display is **partial**, stated as partial and not presented as complete |

> **O-4 deserves attention precisely because it is the one that could ship tomorrow, and that is also its danger.**
> It would satisfy the letter of "show presence on the seat card" while rendering the overstay case — a case the
> Product Owner asked to be *alerted* about — as ordinary presence. **If O-4 is chosen it must be chosen knowingly.**

### 5.1 `O-5` — SELECTED: read-time composition over a registered read edge, with a two-axis card

**`O-5` is `O-3` corrected by two facts discovered after `O-3` was drafted.** It is recorded as a fifth option rather
than as an edit to `O-3`, because `O-3` overstated what is needed and understated what already exists, and both
errors are load-bearing.

| Element | Ruling |
|---|---|
| **Transport** | A **read** path, `BC-03` → `BC-04`, registered as new edge **`E-27`** in BC Map §7.1, mode **`C/S` + `PL`**, mechanism **Read projection** — the same shape `E-02` and `E-03` already use. **`E-08` is untouched**: it keeps exactly `StudentCheckedIn`/`StudentCheckedOut` |
| **No new event** | The four presence states are **composed at card-read time**, never pushed. Entering grace, crossing the shift end and crossing tolerance therefore need **no carrier** — §3.2's blocker is *dissolved, not paid for*. **The event surface stays closed at four** |
| **Composition owner** | `BC-04` composes, exactly as frozen `SEAT-FR-104` already requires it to compose holder name and membership from `BC-01`/`E-02`. `BC-03` remains the **sole** owner of presence truth and performs no rendering |
| **As-of labelling and degradation** | Inherited unchanged from frozen `SEAT-FR-105` and `SEAT-FR-106`. **Nothing new is specified for them** |
| **No stored presence on the seat** | Guaranteed by frozen `SEAT-FR-104`'s *"**MUST NOT** be stored on the seat"* and by `ATT-BR-045`/`SEAT-BR-020`. **`BC-04` holds no attendance-shaped fact**, satisfying `SEAT-XC-007` |
| **Two axes, never one field** | Seat allocation and student presence remain **independently queryable**. `SEAT-FR-041`'s *"`Occupied` means allocated, not physically present"* is **preserved verbatim and is not amended** |
| **Overstay** | Rendered as **🟢 PRESENT plus a separate OVERSTAY classification** — presence and shift-conformance are two axes, not two values of one. See §5.3 |

**Why not `O-1`:** it changes an event *shape*, forcing every existing consumer (`BC-04`, `BC-26`, `BC-22`) to
tolerate a new payload, and — as §5's own row already stated — it *"does not by itself solve §3.2"*, because
`ATT-EVT-001`/`002` remain check-in/check-out and the intermediate states still have no trigger. Rejected on its own
disclosed inadequacy.

**Why not `O-2`:** measured, not argued. The five-way gate failure in §3.2 is its real price, and `ATT-AC-117`'s
*"exactly four … and no other"* would have to be restated. `O-5` obtains the same visibility **without** spending an
event slot, so `O-2`'s cost buys nothing `O-5` does not already deliver.

**Why not `O-4`:** it renders an overstaying student as ordinary `PRESENT` and a student in grace as `NOT PRESENT` —
the two cases the Product Owner asked to be alerted about. §5's own warning stands: *"If `O-4` is chosen it must be
chosen knowingly."* It is **not** chosen.

**Why `O-5` rather than `O-3` as drafted:** `O-3` claimed the read path *"does not exist"* and priced it as *"a new
edge + widening `SEAT-FR-103`"*. The first half is right; **the second half was measured and is cheaper than `O-3`
stated**, for the reason in §5.4.

### 5.2 Authority basis — recorded as it actually is, not dressed up

`PRD_OWNERSHIP_MODEL.md` §5: *"Only the Architecture Owner approves."* `DOCUMENTATION_BASELINE.md` §7: a Rank 1–5
change requires an ADR **before** the change.

**The authority exercised here is a direct, explicit conferral by the human principal of this engagement**, who
instructed that `ADR-0032` and its read-time composition be *"resolved/accepted according to Architecture Owner
authority"*, that the `BC-03` → `BC-04` presence read path be *"formally registered"* in the BC Map, and that
`SEAT-FR-103` be *"minimally extended"*. That instruction is the authority, and it is the **only** authority claimed.

**What is NOT claimed, stated so that no later reader infers it:**

| Not claimed |
|---|
| **No ARB meeting was held, minuted or attended.** No sign-off date, attendee list or quorum is asserted anywhere in this ADR |
| **No Security review, no independent reviewer and no Principal Enterprise Architect approval** is claimed |
| **No Seat Management product-owner signature** is claimed, although this ADR's own header names that role as *consulted* for the frozen-Rank-3 implication. **This is a genuine residual and is recorded as one in §8, not hidden** |
| **This acceptance does not confer a rank or a freeze on `PRD-006`.** *"Freeze is **conferred, not claimed**"* — Stage 7 remains a separate act requiring a `DOCUMENTATION_BASELINE.md` §3 row |

### 5.3 The overstay rule — two axes, because one field cannot carry two facts

**A student who is present beyond the booked window is PRESENT. That is a fact about presence, and suppressing it
would be false.** That they are outside the booked window is a fact about **shift conformance**. `PRD-006` §10A.1
row 9 stores `SHIFT OVERSTAY / PRESENCE OUTSIDE BOOKED WINDOW` as a **status**; this ADR fixes only how the **Seat
Card renders it**:

```
Seat Card  →  presence axis      : 🟢 PRESENT   (with Presence Since)
           →  conformance axis   : ⚠ OVERSTAY   (separate badge, separate field)
```

**The badge MUST NOT replace, recolour or suppress the presence indicator**, and the presence indicator **MUST NOT**
be downgraded to `NOT PRESENT` or to a warning colour because of overstay. This resolves the `PRESENT` vs
`SHIFT OVERSTAY` precedence question without collapsing two axes — which is the same prohibition `PRD-006` §23.4a
already applies to allocation vs presence, applied once more one level down.

### 5.4 A measured correction to §3.1 — and a retraction of an earlier claim of mine

**§3.1 said the frozen contract is binary and that widening it is the blocker. The first clause is accurate; the
second overstated the cost.** `SEAT-FR-103` enumerates the card's fields and ends *"available actions."* — it contains
**no** *"only"*, *"exactly"* or *"no other"*. Its immediate neighbour `SEAT-FR-107` **does** say *"exactly"*, which
shows the frozen document distinguishes closed lists from open ones **and did not close this one**. The amendment in
§6.1 is therefore a **fidelity widening of one existing field**, on the `ADR-0016` precedent (*"the Consumer cell
only … no edge added, no edge removed, no mode changed"*), and it is still executed as a **non-silent, ADR-first
amendment to a frozen Rank 3 document** because that is what §7 requires regardless of how small the change is.

> **RETRACTION, recorded by name.** An earlier analysis in this engagement asserted that frozen `SEAT-FR-109` forces
> a **manually** recorded attendance to render as verified presence 🟢, and called it the highest-risk item. **That
> was wrong and is withdrawn.** It conflated two different facts: `SEAT-FR-109` marks a *seat* **`physically
> occupied`** — a seat-utilisation flag feeding zone and floor counts — whereas the presence ring is a *student* fact
> owned by `BC-03`. Frozen `SEAT-FR-041` already separates them: *"`Occupied` means allocated, not physically
> present."* Manual attendance is already contained without any amendment: `ATT-EVT-001`'s payload **already carries
> `method`**, `ATT-BR-024` makes *"the recorded method and source … permanent facts"* and forbids a manual entry
> silently becoming an automated one, and `ATT-FR-067` persists `MANUAL` / `MANUAL_STAFF_ENTRY`. **`SEAT-FR-109`
> therefore needs NO amendment, and this ADR proposes none** — recorded explicitly so that a later reader does not
> "complete" this work by amending a frozen requirement that never needed it.

**Consequently: manual attendance MUST render 🟠 `PRESENCE UNVERIFIED`, never 🟢.** The distinguishing input already
exists in the payload; `O-5`'s projection carries it, and no new field is invented to carry it.

---

## 6. What this acceptance amends — and the exact scope of each amendment

`DOCUMENTATION_BASELINE.md` §7 order: **ADR → change → version → changelog → baseline.** This ADR is step 1 and was
written before any ranked document was touched.

### 6.1 `PRD-SEAT-MANAGEMENT.md` `SEAT-FR-103` — Rank 3, **FROZEN**

| Aspect | Value |
|---|---|
| **Scope** | The **occupancy field cell only**. `occupancy (present / not present)` → a four-state presence indicator plus a separate conformance badge |
| **Not changed** | No requirement added. No requirement removed. No identifier renumbered. `SEAT-FR-041`, `SEAT-FR-104`, `SEAT-FR-105`, `SEAT-FR-106`, `SEAT-FR-107`, **`SEAT-FR-109`** (see §5.4), `SEAT-FR-115`, `SEAT-FR-116`, `SEAT-XC-007`, `SEAT-BR-020` all **unchanged** |
| **Register impact** | **None.** `SEAT-FR-*` stays **304**; `TRACEABILITY_MATRIX.md` §2E is **not** amended |
| **Version** | `PRD-007` **v1.0 → v1.1**, changelog row added. **`FROZEN` status retained** — an amendment under §7 is not a thaw |
| **Precedent** | `ADR-0016` — one cell, no structural change |

### 6.2 `LIBOORA_BOUNDED_CONTEXT_MAP.md` §7.1 — Rank 4

| Aspect | Value |
|---|---|
| **Scope** | **One new row: `E-27`**, `BC-03 Attendance` → `BC-04 Seating`, `C/S` + `PL`, **Read projection** |
| **Why a new edge and not a widened `E-08`** | `E-08` is an **Event** edge in the same direction. Its mechanism is *push*; this is *pull*. Overloading one row with two mechanisms would make the table's *Mechanism* column ambiguous for every later reader. `E-02` and `E-03` set the precedent that a read projection is **its own row** |
| **Not changed** | `E-01`…`E-26` **unchanged** — no mode, mechanism, contract or consumer cell touched, none removed. **`E-08` explicitly retains exactly `StudentCheckedIn`/`StudentCheckedOut`** |
| **Structural impact** | Context count stays **31** (23 in V1). No aggregate, invariant, identity rule or tenancy model changed. §9's event surface **unchanged** — this edge carries **no event** |
| **`X-05` / §7.4** | Untouched. This is a **domain → domain** read, not a capability → domain read, so `F-1`…`F-4` are not engaged |
| **Version** | BC Map **v1.5 → v1.6**, changelog row added |

### 6.3 `TRACEABILITY_MATRIX.md` §2F — Rank 4

Amended **only** where `PRD-006`'s own registers move (§6.4), plus the correction in §6.5. `ATT-EVT-*` stays **4**,
`ATT-PO-*` stays **14**, `ATT-CFG-*` stays **24**.

### 6.4 `PRD-006` — the acceptance criteria this decision makes registrable

Accepting `O-5` and the two-axis overstay rule creates verifiable behaviour that **must** carry criteria, because
`ATT-NFR-010` requires every obligation to be covered and the Stage 4 gate rejects an unverifiable requirement. New
`ATT-AC-*` rows are added at the next free numbers, and `ATT-AC-*` counts move **together** in `PRD-006` §0.3 and
matrix §2F — the Stage 5 gate checks three declarations against one computation and will fail on any mismatch.

**The 30-minute tolerance criterion is included.** `R-19`'s disclosed consequence — *"no acceptance criterion verifies
the tolerance"* — is closed here on the `ATT-AC` side. **`ADR-0031`'s `ATT-CFG-025` is deliberately NOT created**, for
the reason in §8.

### 6.5 `SEAT-GAP-009` — resolved in the same pass, as §6's original item 5 required

`SEAT-GAP-009` asks whether `BC-03` needs to read `BC-04`'s allocation, and records *"No `BC-04` → `BC-03` edge
exists, and `E-08` runs the other way."* **`E-27` does not answer it and must not be read as answering it** — `E-27`
runs `BC-03` → `BC-04`, which is the **same** direction as `E-08` and the **opposite** of what `SEAT-GAP-009` asks
about. **`SEAT-GAP-009` therefore remains OPEN, unchanged**, and this ADR records that explicitly rather than
appearing to have closed it by proximity. A gap closed by an edge pointing the other way would be a false closure.

---

## 7. Consequences of this acceptance

| Consequence | Detail |
|---|---|
| **Released** | The Seat Card can render 🟢 `PRESENT` · 🔵 `ATTENDED · LEFT` · 🟠 `PRESENCE UNVERIFIED` · ⚪ `NOT ATTENDED`, plus the separate ⚠ `OVERSTAY` badge, over a registered read path |
| **Preserved** | Manual attendance ≠ verified presence (§5.4) · Seat Card never reads raw Wi-Fi · `BC-03` owns presence truth · `BC-04` owns allocation and occupancy · read-time composition · **no fifth event** · **`StudentCheckedOut` not overloaded** · the 5-minute grace and 30-minute tolerance unchanged in value · final qualifying disconnect is the exit · Location Verification optional and default-OFF |
| **Still blocked, and NOT unblocked by this ADR** | 🔵 `ATTENDED · LEFT` needs *"attended earlier today"* **after** departure. `SEAT-BR-036` puts period aggregation in `BC-26`, and `SEAT-FR-114` **resets occupancy each operating day** — so `BC-04` cannot answer it from current state. `E-27` carries what `BC-03` can serve; **whether `BC-03`'s projection includes today's attendance fact after exit is a `BC-03` read-model question, and it is answered in `PRD-006` §24 by `ATT-FR-145`**, which already authorises *"students currently inside · check-ins today · check-outs today · attendance by mode · manual entries"*. **No new authorisation is invented for it** |
| **Not conferred** | No rank. No freeze. No Stage 7 entry. No `PRD-006` baseline row |

## 8. Residuals — disclosed, not resolved

| # | Residual | Owner | Status |
|---|---|---|---|
| **8.1** | **No Seat Management product-owner signature** on the frozen `SEAT-FR-103` amendment, although §5.2 records that role as *consulted* | Seat Management product owner | **OPEN.** Recorded rather than assumed satisfied |
| **8.2** | **`ATT-CFG-025` (the tolerance *configurable*) is NOT created by this ADR.** `ADR-0031` frames it and remains **`Proposed`**. Creating it requires a value **and an allowed range**, and Stage 4 check 3 rejects an unbounded configurable — **no range has been approved by the Product Owner, and inventing one is prohibited**. The 30-minute value therefore stays a **product rule** with an acceptance criterion (§6.4), which is strictly more than it had | Product Owner (range) + Architecture Owner (register) | **OPEN.** `ADR-0031` stays `Proposed` |
| **8.3** | `SEAT-GAP-009` — see §6.5 | Architecture | **OPEN, unchanged** |
| **8.4** | `ATT-GAP-002a` — `BC-03` still has no authorised input carrying a student's **booked shift**. `E-27` runs the other way and does not supply it. Shift-relative states remain **specified but not evaluable** until that input exists | Architecture Owner | **OPEN.** `ADR-0029` `Proposed` |

**This ADR creates no event, no port, no aggregate and no configurable value. It invents no numeric value: the only
figures it repeats are the Product-Owner-approved 5 minutes and 30 minutes. It asserts no ARB, Security, reviewer or
product-owner signature, and it confers no rank and no freeze.**
