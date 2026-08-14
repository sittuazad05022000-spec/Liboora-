# ADR-0032 — Attendance presence visibility to Seating: how live student presence reaches the Seat Card

| Field | Value |
|---|---|
| **ADR** | **`ADR-0032`** |
| **Status** | **Proposed** — not binding. *(`ADR-INDEX.md` status vocabulary: "Under consideration; not binding")* |
| **Date** | 2026-08-05 |
| **Raised by** | `PRD-006` Attendance Management §23.4a, `ATT-GAP-002b` |
| **Authority to decide** | **Architecture Owner** (BC Map §7 — a new edge or a widened contract), with **Seat Management product owner** consulted because a **frozen Rank 3** requirement is implicated |
| **Contexts** | `BC-03` Attendance (source of presence) · `BC-04` Seating (owner of the Seat Card and of occupancy) |
| **Blocks** | The Seat Card live presence display in `PRD-006` §23.4a, in full |

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

**None is selected. This ADR is `Proposed`.**

| # | Option | What it costs | What it needs |
|---|---|---|---|
| **O-1** | **Widen the existing `E-08` contract's payload** to carry a richer presence state, keeping one edge and one event family | Changes an event **shape**, so every existing consumer (`BC-04`, `BC-26`, `BC-22`) must tolerate it; `ATT-EVT-001`/`002` semantics stay check-in/check-out, so the extra states still have no *trigger* even if the payload could hold them | BC Map §9 amendment; consumer review. **Does not by itself solve §3.2** |
| **O-2** | **A fifth `attendance.*` event** — a presence-state-changed event | **Two Rank 4 amendments** (§2F `ATT-EVT-*` count, and an `ATT-AC` for `ATT-NFR-010` coverage), plus `ATT-AC-117` restatement. Measured cost: the 5-way gate failure in §3.2 | Architecture Owner + the Rank 4 register owner. **This is the honest cost, not a reason to prefer a cheaper-looking option that does not work** |
| **O-3** | **A read-side composition**: `BC-04` composes presence at card-read time from a `BC-03` read projection, exactly as `SEAT-FR-104` already composes name and membership from `BC-01`/`E-02` | Needs a `BC-03` → `BC-04` **read** path that does not exist; but it **reuses a pattern the frozen document already ratifies**, needs no new event, and inherits `SEAT-FR-105`/`106`'s as-of labelling and visible degradation for free. The card refreshes on read, not on push | A new edge (BC Map §7) + widening `SEAT-FR-103`'s occupancy field. **Flagged as the option most consistent with existing ratified patterns — which is an observation about fit, not a decision** |
| **O-4** | **Ship the binary field only in V1** — 🟢/⚪ from existing `E-08`, and defer the four richer states | **Zero new architecture.** But it silently under-delivers: a student in grace renders as `NOT PRESENT`, and an overstaying student renders as `PRESENT` — the two cases the product asked for most | Product Owner acceptance that the display is **partial**, stated as partial and not presented as complete |

> **O-4 deserves attention precisely because it is the one that could ship tomorrow, and that is also its danger.**
> It would satisfy the letter of "show presence on the seat card" while rendering the overstay case — a case the
> Product Owner asked to be *alerted* about — as ordinary presence. **If O-4 is chosen it must be chosen knowingly.**

## 6. What an accepting decision must also amend

Listed so an acceptance is not partial:

1. **`PRD-007`** `SEAT-FR-103` — occupancy field widened beyond two values *(frozen Rank 3)*
2. **`LIBOORA_BOUNDED_CONTEXT_MAP.md`** §7 — a new edge, or `E-08`'s definition *(Rank 4)*
3. **`TRACEABILITY_MATRIX.md`** §2F — only under **O-2** *(Rank 4)*
4. **`PRD-006`** §22.1, §23.4a, §0.3 — only under **O-2**
5. **`PRD-007`** `SEAT-GAP-009` — related and should be resolved in the same pass; it already records *"No `BC-04` → `BC-03` edge exists, and `E-08` runs the other way"*

## 7. Consequence of leaving this `Proposed` — disclosed, not minimised

The Seat Card shows **allocation** correctly today and **cannot** show the six presence renderings. `PRD-006` can
compute the presence state internally; it has **no authorised way to make it visible on a seat**. Nothing is
broken — but a requirement the Product Owner asked for is **not delivered**, and this ADR is why.

**This ADR asserts no ARB, Architecture Owner, Security or reviewer approval. It selects no option. It creates no
edge, event, port or read model, and it modifies no Rank 1–4 document.**
