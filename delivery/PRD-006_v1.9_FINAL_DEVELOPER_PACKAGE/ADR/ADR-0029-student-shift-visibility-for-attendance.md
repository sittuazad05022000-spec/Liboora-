# ADR-0029 — How `BC-03` Attendance Obtains a Student's Booked Shift

| Field | Value |
|---|---|
| **Status** | **`Proposed`** — *"Under consideration; not binding"* (`ADR-INDEX.md`) |
| **Date** | 2026-08-05 |
| **Deciders** | **Architecture owner (ARB).** Required by BC Map §7 L292: *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."* |
| **Consulted** | `BC-04` Seating owner (frozen `PRD-007`) · `BC-06` Library Policy owner (`Library_PRD_v1.md`) · Product Owner |
| **Supersedes** | Nothing |
| **Superseded by** | Nothing |
| **Related** | `ADR-0024` · `ADR-0025` · `SEAT-FR-046` (frozen `PRD-007` L476-480) · `PRD-007` L158 · BC Map L101, `E-03` (L300), `E-04` (L301), `E-08` (L305), §7 L292 · `ATT-FR-089` · [`PRD-006_PO_DECISION_RESOLUTION_RECORD.md`](../../30-product/attendance-management/PRD-006_PO_DECISION_RESOLUTION_RECORD.md) §4 |

> **What this ADR is.** The Product Owner has required that every automatically-detected verified presence be
> compared against *"the student's booked library schedule"*, producing **`SCHEDULE MISMATCH`** when the presence
> falls outside it. Measurement shows `BC-03` has **no authorised input carrying that schedule**.
>
> **This ADR frames the question and does not answer it.** It proposes no edge, extends no payload and selects no
> option.

---

## 1. The requirement that created the question

Product Owner decision, recorded as **`D-10`**/**`D-16`** scope in
[`PRD-006_PO_DECISION_RESOLUTION_RECORD.md`](../../30-product/attendance-management/PRD-006_PO_DECISION_RESOLUTION_RECORD.md):

> *"Every verified presence must be compared to the student's booked library schedule. Booked 06:00–10:00 → in-shift
> = `VERIFIED PRESENCE`; outside = `SCHEDULE MISMATCH` → alert the student and create an Owner/Manager review item."*

The product rule is settled. The **input** is not available.

---

## 2. The measurement — why this is a real void and not an oversight

| # | Measurement | Result |
|---|---|---|
| M-1 | `grep -in "shift"` across `PRD-006` | **3 hits, every one about `BC-07` Staff & Shift** (L174, L235, L240). **Zero** about a student's booked shift. The concept has never existed in this module |
| M-2 | BC Map **L101** — what `BC-06` owns | *"working hours, holidays, attendance rules, seat rules, grace periods"* — **branch-wide policy, not a per-student booking** |
| M-3 | Frozen `PRD-007` **L158** | *"**`Shift`** — a named time window; **`Shift` definitions are owned by `BC-06`** (`LIB-16.4`)"* — `BC-06` owns the *definition* of a shift |
| M-4 | Frozen `PRD-007` **`SEAT-FR-046`** (L476-480) | A `SeatAllocation` MUST carry `StudentRecordId` · `tenantId` · allocation type · time window (`validFrom`, `validUntil`) · **shift reference (nullable)** — so the *per-student booking* is `BC-04`'s |
| M-5 | `BC-03` inbound edge **`E-03`** (BC Map L300) | `BC-02 → BC-03`, payload `MembershipValidity{studentRecordId, validUntil, seatQuota}`. **Carries no shift** |
| M-6 | `BC-03` inbound edge **`E-04`** (BC Map L301) | `BC-06 → BC-03`, payload `AttendanceRules{openTime, closeTime, graceMinutes, lateEntryPolicy}`. **Branch-wide; carries no per-student shift** |
| M-7 | Is there a `BC-04 → BC-03` edge? | **No.** `E-08` is `BC-03 → BC-04`, the opposite direction |
| M-8 | BC Map §7 **L292** | *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."* |

**Conclusion.** The per-student booked shift is held by **`BC-04`** (`SeatAllocation`, `SEAT-FR-046`), defined by
**`BC-06`** (`PRD-007` L158), and **`BC-03` can reach neither for this purpose**. The requirement therefore has no
authorised input, and `SCHEDULE MISMATCH` cannot be computed today.

---

## 3. Constraints any accepted option must satisfy

| # | Constraint | Source |
|---|---|---|
| **C-1** | `BC-03` **MUST NOT** become the owner of a student's booking or schedule | Single Owner Rule; `SEAT-FR-046` |
| **C-2** | `BC-03` **MUST NOT** hold a shadow copy of `BC-04`'s system of record | `ATT-BR-045` |
| **C-3** | No new edge may be assumed | BC Map §7 **L292** |
| **C-4** | `PRD-007` is **FROZEN, Rank 3**. It **MUST NOT** be silently modified | `PRD_LIFECYCLE.md`; `DOCUMENTATION_BASELINE.md` L286 |
| **C-5** | Branch-wide `AttendanceRules` open/close times **MUST NOT** be substituted for a per-student shift | See §3.1 |
| **C-6** | Attendance **MUST** be evaluated against the rules in force **at the moment recorded**; a later booking change **MUST NOT** retroactively reclassify a record | `ATT-FR-089`, `LIB-12.8`, `MP-GBR-19` |
| **C-7** | Where the shift is unknown or unavailable, presence **MUST** still be recordable and flagged rather than blocked | `ATT-NFR-009` pattern, `MP-GBR-16` |
| **C-8** | A `SeatAllocation`'s shift reference is **nullable** — a student may legitimately have **no** shift | `SEAT-FR-046` |
| **C-9** | The outcome **MUST** be tenant-scoped | `ATT-BR-017`, `X-13` |

### 3.1 Why the tempting substitution is refused

`E-04` already delivers `AttendanceRules{openTime, closeTime, …}`, and it would be trivial to compare presence
against **branch opening hours** and call the result `SCHEDULE MISMATCH`.

**That would be wrong, and visibly so.** A library open 06:00–22:00 with a student booked 06:00–10:00 would return
`VERIFIED PRESENCE` for an arrival at 19:00 — the exact case the Product Owner wants flagged. Worse, it would
report a *pass* where the truth is *unknown*, which is the failure mode this module refuses elsewhere
(`ATT-BR-030`: never auto-complete with an invented value; `ATT-NFR-010`: a rule that cannot be checked is unmet).

**Branch hours are not a booking.** The substitution is available, cheap, and is **not taken**.

### 3.2 Why C-8 matters more than it looks

Because the shift reference is **nullable**, an accepted option must state what happens when a student has a
verified presence and **no** booked shift. Three readings exist (always `VERIFIED PRESENCE`; always
`SCHEDULE MISMATCH`; a third outcome), and the Product Owner's seven-string vocabulary contains **no string for
"no shift booked"**. This ADR records the ambiguity and does not resolve it: inventing an eighth status string is
forbidden, and silently folding the case into either existing string is a product decision, not an architecture
one.

---

## 4. Options — framed, none selected

| # | Option | For | Against | Cost |
|---|---|---|---|---|
| **O-1** | **New edge `BC-04 → BC-03`** carrying the student's allocation window | Reads the true system of record; smallest semantic distance | Adds an edge in **both** directions between `BC-03` and `BC-04`, inverting `E-08`'s stated direction and risking a cycle. BC Map §7 amendment (Rank 4) | ADR + Rank 4 amendment |
| **O-2** | **Extend `E-04`'s payload** so `BC-06` delivers per-student shift assignments | Reuses an existing edge; `BC-06` already *defines* `Shift` (M-3) | `BC-06` owns **definitions**, not **per-student bookings** (M-4) — this would make Library Policy a booking authority it is not. Rank 4 payload amendment | ADR + Rank 4 amendment + `BC-06` owner consent |
| **O-3** | **Application-layer composition** — the caller supplies the shift context, as `BC-18` identity is supplied today | Uses a **ratified pattern**: `ATT-GAP-002` closed on frozen `PRD-007` consuming `BC-18` with **no `E-` edge**; `ATT-PO-007` already receives composed context | Places a cross-context read in the application layer; needs a rule that the composed shift is evidence, never a `BC-03`-owned fact | ADR only; **no Rank 4 amendment** |
| **O-4** | **`BC-04` computes the mismatch** and `BC-03` records only what it is told | Keeps the schedule entirely inside its owner | Requires `BC-04` to consume presence, and `PRD-007` is **FROZEN** (C-4). Inverts the trigger relationship | ADR + a change to a frozen Rank 3 PRD |
| **O-5** | **Defer `SCHEDULE MISMATCH` from V1**, ship the other six statuses | Unblocks everything else immediately; invents nothing | Removes a status the Product Owner explicitly required — **a product decision, not an architecture one**, so the ARB cannot choose this alone | Product Owner + ARB jointly |

**O-3 is noted as the only option needing no Rank 4 amendment**, and that observation is **not** a recommendation:
the ratified pattern it leans on (`ATT-GAP-002`) concerns *identity* composition, and whether a *schedule* is
analogous is exactly the judgement reserved to the ARB.

---

## 5. What an accepting decision must record

1. Which option, and the edge or pattern it authorises — by name.
2. The exact payload, if any, and which document owns it.
3. The behaviour when the shift reference is **null** (§3.2) — and, if a new status string is needed, a Product
   Owner decision, since the vocabulary is fixed at seven strings.
4. How C-6 is honoured: which version of the booking a mismatch is judged against.
5. Whether a mismatch may ever **block** attendance, or only flag it (C-7 says flag).
6. Whether the review item is a new event or fits `ATT-FR-134`'s existing four (`ADR-0025` §6, `R-7`).

---

## 6. What is already settled and needs nothing from this ADR

| Already true | Source |
|---|---|
| The **product meaning** of `SCHEDULE MISMATCH` — student alerted, Owner/Manager review item created | Product Owner decision |
| Notification is a **fact**, never a channel, template or dispatch decision | `ATT-FR-148`, `X-04`, `LIB-16.5` |
| Failure signals must be **distinguishable** | `ATT-NFR-005`, and §25's existing signal table |
| A mismatch must not retroactively reclassify an older record | `ATT-FR-089` |
| Where an input is stale, flag rather than block | `ATT-NFR-009` |
| Tenant isolation | `ATT-BR-017`, `X-13` |

---

## 7. What this ADR explicitly does **not** do

- It does **not** add, name or reserve an edge. `BC-04 → BC-03` **does not exist** and is not asserted here.
- It does **not** extend `E-04`'s payload.
- It does **not** modify `PRD-007` (FROZEN), the BC Map, or any Rank 1–4 document.
- It does **not** substitute branch opening hours for a per-student booking (§3.1).
- It does **not** invent an eighth status string, a notification cooldown, or an escalation interval.
- It does **not** decide the null-shift case.
- It is **`Proposed`** and binds nothing.

## 8. The contract shape the Product Owner requires — proposed, not created

> **A later Product Owner instruction specifies what the resulting contract should provide.** It is recorded here as
> the **required shape** of whatever mechanism an accepting authority selects. **This creates no edge, no event, no
> port and no read model**, and BC Map §7 L292 continues to govern: an edge absent from its table does not exist.

| Field | Requirement | Note |
|---|---|---|
| student / member reference | The subject of the lookup | `StudentRecordId` — already the only student identifier `BC-03` holds |
| **booked shift — NULLABLE** | The nullability is **load-bearing, not an oversight** | `SEAT-FR-046` (frozen `PRD-007`) makes it nullable; null now maps to an authorised status, **`NO BOOKED SHIFT / PRESENCE UNASSIGNED`** (`D-20`) |
| effective start / end | The window verified presence is compared against | Per-student, **never** branch opening hours |
| tenant / branch context | Isolation | `ATT-BR-017`, and `ATT-INV-010`'s tenant qualifier |

**The prohibitions are unchanged and are restated because the instruction restates them.** The shift **MUST NOT** be
taken from branch opening hours, a guessed shift, the current time window, or default branch hours. *"If the
architecture currently lacks an authorized `BC-04` → Attendance data path: DO NOT silently add it."*

### 8.1 What `D-20` changed here, and what it did not

**Changed:** the null case now has a name. This ADR previously recorded (§3.2) that the null-shift outcome had no
authorised status; `D-20` supplies one, so §7's *"does not decide the null-shift case"* is superseded **as to the
status name only**.

**Not changed — and this is the important half:** the **data path remains absent**. A status that names the null case
does not tell `BC-03` whether the case obtains. **Distinguishing "no booking" from "booking, wrong window" still
requires reading the booking**, which is exactly what no edge provides. So `ATT-GAP-002a` stays 🔴 **OPEN**, this ADR
stays **`Proposed`**, and the two new statuses are **specified but not evaluable**. Recording that plainly is
preferable to letting a resolved vocabulary imply a resolved dependency.

---

*End of `ADR-0029` — `Proposed`.*
