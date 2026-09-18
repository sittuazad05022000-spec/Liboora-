# ADR-0147 — The 12 `DashboardMetrics` counters are certified as `BC-26` metrics; `ANL-OBD-001` is resolved jointly

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-18 |
| **Date** | 2026-09-18 |
| **Deciders** | **Product Owner** *(metric definition and business meaning)* **and Architecture Owner** *(the `BC-26` semantic-layer boundary)*, **jointly** — the form `ADR-0097` used for the only prior metric certification. ⭐ Both roles **filled for this act only** by **direct conferral from the human principal of this engagement**, in the same manner and with the same disclosure as `ADR-0032` §5.2, `ADR-0033` §7.2, `ADR-0080` §5, `ADR-0096` and `ADR-0097`. ⛔ **No ARB quorum, attendee list, Security review or Privacy Owner review is asserted** — `PRD_OWNERSHIP_MODEL.md` **L509** records that *"no holder is appointed"* to the Privacy Owner role. ⛔ **No personal name is recorded** — §7 rule 4 |
| **Authority instrument** | ⭐ Recorded **verbatim in this header**, on the `ADR-0097` precedent *(whose cited form `PRD-021C_OWNER_DECISION_FORM.md` §5 was itself a blank template; the operative authority was the principal's quoted instruction)*: <br>*"I confer Product Owner and Architecture Owner authority, jointly and for this act only, to resolve `ANL-OBD-001` and to certify `BC-26` metric definitions for the 12 existing `DashboardMetrics` counters, and nothing else. `ProfileViews` is unchanged. `UniqueViewers` remains uncertified."* |
| **Amends** | ⛔ **Nothing is edited.** Declaratory and constitutive: it **defines** metrics under an authority (`BC-26`) that already exists — BC Map **L135**, **L385** — in the artefact class `PRD_OWNERSHIP_MODEL.md` **L284** makes competent. ⛔ **`PRD-009` is NOT edited** and remains **FROZEN v0.6, Rank 3**. ⛔ **`PRD-007` is NOT edited** and remains **FROZEN v1.1**. ⛔ **`PRD-006` is NOT edited.** ⛔ **The BC Map is NOT amended.** ⛔ **`tool/module_dependencies.yaml` is NOT amended.** ⛔ **No Accepted ADR is edited** (`ADR-INDEX` **L206**) |
| **Baseline** | ⛔ **No baseline re-issue.** No Rank 1–3 document changes version; no Rank 1–5 document changes at all. `DOCUMENTATION_BASELINE.md` §7 rule 4 |
| **Closes** | ⭐ **`ANL-OBD-001`** — *"who owns a Certified Metric's definition?"* — resolved **jointly** (§2.1). ⭐ **`DD6-GAP-004`** for **these 12 metrics only**; ⛔ it remains OPEN for every other candidate |
| **Does NOT close** | ⛔ **`ANL-GAP-001` / F-1** — certification authorises migration; the migration is `IMPL-2005`. ⛔ **`ANL-GAP-002`** — `attendance.AttendanceCorrected` is unconsumed, so `ANL-FR-053` restatement is unsatisfiable. ⛔ **`ANL-CFG-003`/`ANL-GAP-020`** — the numeric freshness threshold stays **OWED to SRE**. ⛔ **`ANL-OBD-003`** — narrowed, not closed (§3.4). ⛔ **`ANL-OBD-004`** — OPEN, HIGH RISK; ⛔ **no metric may take `guardianOf`**. ⛔ `ANL-OBD-002`, `-005`, `-006`, `-007`, `-009`. ⛔ **`ANL-AL-B1`**. ⛔ **`SEAT-GAP-008`**. ⛔ **F-2**, **F-3**. ⛔ Confers no lifecycle stage; verifies no code; closes no acceptance criterion |
| **Related** | `ADR-0097` *(the precedent; `ProfileViews`)* · `ADR-0096` *(`E-30`)* · `ADR-0113` *(`PRD-009` FROZEN v0.6)* · `ADR-0032`/`ADR-0033` *(presence→seating; `E-27` withdrawn)* · `MP-GBR-36`, `MP-GBR-21` *(Rank 1)* · `AN-2`, `AN-3` *(manifest **L325**, **L317**)* · BC Map **L135**, **L305** (`E-08`), **L385**, **L418**, **L490** · FROZEN `PRD-007` `SEAT-FR-116`, `SEAT-FR-245`, `SEAT-XC-019`, `SEAT-AC-173` · `DD-0006` §10.3 *(unranked; evidence only)* |

> ⭐⭐ **`ProfileViews` remains the only metric certified by `ADR-0097`, and is BYTE-UNCHANGED by this ADR.**
> ⛔⛔ **`UniqueViewers` remains NOT CERTIFIED** — `ADR-0097` §5, rules `U1`–`U8`. It is **uncomputable**, not
> merely unbuilt: `ADR-0096` §17.2.1 fixes the `E-30` payload to carry **no viewer identity**.

---

## 1. Context

`lib/platform/analytics/analytics.dart` **L36–53** defines `DashboardMetrics`: **10 mutable counters + 2 derived
getters = 12**, matching `PRD-009` **L229** and `IMPL-2005` verbatim. ⛔⛔ **None was a `CertifiedMetric`** —
inline field increments with no definition, owner, version or source record (`AIV-A05`), which is the substance of
**F-1** / `ANL-GAP-001` (**HIGH RISK**).

`MP-GBR-36` (Rank 1) mandates the semantic layer but **names no owner** — that silence is `ANL-OBD-001`.
`PRD-009` is **FROZEN at Rank 3**, so an ADR is the only competent instrument.

### 1.1 ⚠️ A scheduling defect in the Stage-6 record, disclosed and NOT amended

`IMPL-2005` records **`Blocked by` = "—"** and classes itself **V1**. That is **wrong**: migration required 12
certification acts that had never occurred. The plan also orders `IMPL-2005` *before* `IMPL-2003` (versioning) and
`IMPL-2006` (`timeSemantics`), which supply two of the nine fields. ⛔ **This ADR does not amend that row** — a
Stage-6 gate record is the Implementation Lead's artefact. ⭐ **Raised and routed.**

---

## 2. Decision

### 2.1 ⭐⭐ `ANL-OBD-001` — RESOLVED: definitions are owned **jointly**

> ⭐ **A Certified Metric definition is owned JOINTLY by the Product Owner and the Architecture Owner. Neither
> alone may certify one.** The Product Owner owns the **business meaning**; the Architecture Owner owns the
> **`BC-26` semantic-layer boundary** and the **structural** properties.

⭐ **Rationale, measured rather than preferred:** `ADR-0097` — the only prior metric certification — was decided
in exactly this joint form. `PRD_OWNERSHIP_MODEL.md` §5 independently requires it: *"**Only the Architecture
Owner approves**"*, so a Product-Owner-only rule could not certify anything, while an Architecture-Owner-only
rule would assign business meaning to the wrong office.

⛔ **`ANL-OBD-001` is now CLOSED.** ⛔ It confers no standing licence: this ADR's own conferral is *"for this act
only"* (`ADR-0033` §7.1 — *"A conferral for one act is not a standing licence"*).

### 2.2 What is certified

> ⭐ **All 12 `DashboardMetrics` counters are certified as `CertifiedMetric` instances of `BC-26`, at
> `version: 1`, each carrying all nine `ANL-FR-008` fields.**

⛔ **`ANL-FR-009` is satisfied by construction: 0 of the 108 required field values (12 × 9) is blank.**

### 2.3 ⛔⛔ `ADR-0148` — RAISED, NARROWED, WITHDRAWN AND CLOSED AT ZERO GOVERNANCE COST

⚠️⚠️ **This subsection is the audit trail of an ADR that was drafted and then deliberately NOT created.** It is
recorded here because the reasoning that made it unnecessary is the reasoning that makes `SeatsOccupied` lawful,
and a reader who cannot see it would have to re-derive it.

**The conflict — `ADR0147-CONF-001`.** `PRD-007` (FROZEN, Rank 3) states the meaning of *"Occupied"* twice, in
opposite senses:

| Party | Requirement | Location | Meaning |
|---|---|---|---|
| **A** | `SEAT-FR-037` (order 2: *"F5 active allocation exists → `Occupied`"*), `SEAT-FR-041` (*"`Occupied` means allocated, **not physically present**"*), `SEAT-AC-020` | **§6** *"Seat lifecycle — the deterministic state model"* | **allocation-driven** |
| **B** | `SEAT-FR-245` (*"A seat allocated to an absent student is allocated but **not occupied**"*), `SEAT-AC-173` (*"70 allocated, 40 checked in → **70% and 40%**"*) | **§25** *"Operational metrics — counts, not analytics"* | **attendance-driven** |

⭐⭐ **Architecture Owner ruling: Party B governs, NARROWED TO `BC-26` SCOPE ONLY.** *"Occupied"* is
presence-qualified **for the `BC-26` `SeatsOccupied` metric**. ⛔ `BC-04`'s `SeatState` vocabulary is
**unchanged**.

⭐⭐ **Why the narrowing needs NO amendment to any frozen document — the decisive structural finding:** the two
statements are not a contradiction but **two subjects sharing one word**, and the document itself separates them
by section. `SEAT-FR-037`/`-041`/`AC-020` are **§6 `SeatState`** requirements; `SEAT-FR-245`/`SEAT-XC-019` are
**§25 metric** requirements. **`SEAT-XC-019`** makes the division binding: *"The module **MUST NOT** define a
metric that `BC-26` also defines. Where a figure is needed both operationally and analytically, this module
publishes the underlying facts (§22) and **`BC-26` defines the metric**."*

⚠️⚠️ **A wider ruling was authorised first, then withdrawn on new evidence — and the evidence is recorded rather
than the reversal concealed.** The initial ruling amended `SEAT-FR-037`, `SEAT-FR-041` and `SEAT-AC-020`.
Measurement then found that **FROZEN `PRD-006` v1.9 (Rank 3) discharges its own §19 requirement by citing
`SEAT-FR-041` verbatim** at **L2201**, under a heading reading *"What is ALREADY satisfied by the frozen
document — checked, not assumed"*, and that `ATT-GAP-002b` is marked **✅ RESOLVED** on the same chain. Amending
`SEAT-FR-041` would have invalidated a second frozen Rank-3 PRD's self-discharge — **outside** the conferral, and
not silently survivable. ⭐ The narrowed ruling dissolves that consequence entirely.

**Net effect of the narrowing, measured:**

| | Outcome |
|---|---|
| ⭐ | **0** frozen documents amended — `PRD-007` stays **v1.1**, `PRD-006` stays **v1.9** |
| ⭐ | **0** baseline re-issues (`DOCUMENTATION_BASELINE.md` §7 rules 2–4 never engage) |
| ⭐ | **`ADR-0032` §2's premise survives intact** — it cites `SEAT-FR-041`, which is unchanged |
| ⭐ | **`PRD-006` L2201's discharge survives intact** |
| ⭐ | **`ADR-0032` requires NO supersession** — determined, not assumed: `ADR-0033` already amended its §5.1/§6.2, its `O-5` ruling is untouched by a `BC-26` metric definition, and `ADR-INDEX` **L206** bars editing it |

**L2 — WITHDRAWN.** A new `BC-04` event (`SEAT-EVT-005` `seating.SeatOccupancyChanged`) was authorised, then
withdrawn as **unnecessary**: measurement showed `seating.SeatAssigned` carries `studentRecordId` and
`attendance.StudentCheckedIn`/`CheckedOut` carry `studentRecordId`, so **`BC-26` can compute the intersection
from facts it already consumes** — exactly the division `SEAT-XC-019` prescribes. ⛔ **`SEAT-FR-206`'s closed
event set is NOT opened. BC Map §9 is NOT amended. `E-27` is NOT reused** (BC Map **L10**: permanently vacant).

⭐ **`E-08` is sufficient as declared**, and this is proven rather than assumed: **`SEAT-FR-116`** — *"Live
occupancy counts **MUST** be recomputable from the current allocation set **and the current `BC-03` open-session
set**"* — and **`SEAT-AC-111`** — *"converges from the current allocation set and `BC-03` open sessions"*.

---

## 3. The 12 Certified Metrics — the authoritative definitions

### 3.0 Properties binding all 12 — derived, not chosen

| Property | Value | Authority |
|---|---|---|
| `owningContext` | **`BC-26` Analytics Read Model** — sole definitional authority | BC Map **L135**, **L385** |
| `version` | **1** for every metric | `ANL-FR-010`; `ANL-INV-004` |
| `metricId` casing | **`PascalCase`** — derived from `ProfileViews`, the only prior exemplar | `ADR-0097` §3.1 |
| `accessScope` | **`tenantWide`** for all 12 (§3.4) | `MP-GBR-21`; `ANL-INV-007` |
| Unit (1–8, 11–12) | Dimensionless non-negative integer count | `ANL-FR-008` |
| Unit (9–10) | **INR minor units, `int`** — ⛔ deliberately not `Money` | `PRD-009` §8.3; `AIV-A07` |
| Grain | One tenant, one period | `ANL-INV-006`; BC Map **L490** |
| Rebuildability | Fully rebuildable by replay; ⛔ **not** a system of record | `ANL-INV-001`, `-003` |
| Determinism | ⛔ **No wall-clock read inside projection logic** | `ANL-INV-005` |
| Duplicates | Idempotent on `eventId` | `ANL-FR-003` |
| Out-of-order | No cross-aggregate ordering assumption | `ANL-FR-051` |
| Timezone | **IST** | `ANL-FR-055`; `MP-CON-12` |
| `freshnessExpectation` | §3.3 — behavioural | `ANL-FR-057`; `ADR-0097` §4.2 |

### 3.1 ⭐⭐ `timeSemantics` — the two regimes, and the `ANL-INV-005` correction

**Regime 1 — the IST day, for the six `...Today` metrics:**

> ⭐ **The period is the half-open IST interval `[00:00:00 IST, next-day 00:00:00 IST)`** —
> **start-inclusive, end-exclusive** — evaluated against the **event's own `occurredAt`**, never against a
> read-time clock.

⛔⛔ **This CORRECTS a measured breach of `ANL-INV-005`.** `analytics.dart` **L157–160** called
`_clock.today()` **inside** `_isToday()`, invoked from four event handlers (**L185**, **L202**, **L234**,
**L247**) — a wall-clock read inside projection logic, which `ANL-INV-005` forbids: *"Replay from zero is
deterministic — **no wall-clock read inside projection logic**."* A replay tomorrow produced different values
than a replay today. ⭐ Under event time the values are **permanent and replay-stable**.

⚠️ **Disclosed behavioural change**, accepted under **`IMPL-2005`**: a payment received at 23:59 previously
stopped counting once the clock passed midnight; it now counts for the IST day on which it occurred, permanently.

⚠️ **Naming residue, disclosed not resolved:** the `...Today` suffix is retained because `IMPL-2005` and
`PRD-009` **L229** name these counters. Under event time they hold per-IST-day values rather than
"the current day". ⛔ **No rename is performed** — the identifiers are cited by the Stage-6 record.

**Regime 2 — cumulative since inception**, for `StudentsEnrolled`, `MembershipsCreated`, `SeatsAssigned`,
`SeatsReleased`. ⛔ No repository source supplies a window (measured: **0** matches for `cumulative`, `lifetime`,
`to-date`, `running total`, `all-time`, `since inception` in `PRD-009`), and `ADR-0097` `T5` certifies **no**
period beyond the `ProfileViews` 7-day window, so none was inherited and none was invented.

**Regime 3 — point-in-time**, for `SeatsOccupied` (§3.5) and `InsideNow` (§3.6). ⛔ Neither is day-bounded.

### 3.2 `sourceEvents[]` and `calculation` — each traced to its emission condition

⭐ **Every `definition` below restates the emission condition of its source event.** ⛔ **No business meaning is
invented**; where a fact's meaning is owned by another context, that ownership is named and preserved.

| # | `metricId` | `sourceEvents[]` | `definition` + `calculation` | Authority |
|---|---|---|---|---|
| 1 | **`StudentsEnrolled`** | `enrollment.StudentEnrolled` | The cumulative count of students enrolled in the tenant since inception. One qualifying fact increments by exactly one. | BC Map **L404**; D-4.1 |
| 2 | **`MembershipsCreated`** | `membership.MembershipCreated` | The cumulative count of memberships created since inception. One fact increments by one. | `MM-EVT-001`; D-4.2 |
| 3 | **`CheckInsToday`** | `attendance.StudentCheckedIn` | The count of student check-ins recorded on one IST day. One fact whose `occurredAt` falls in the day interval increments by one. | `ATT-EVT-001`; D-3 |
| 4 | **`CheckOutsToday`** | `attendance.StudentCheckedOut` | The count of student check-outs recorded on one IST day. One fact in the interval increments by one. | `ATT-EVT-002`; D-3 |
| 5 | **`LateEntriesToday`** | `attendance.StudentCheckedIn` | The count of check-ins on one IST day that `BC-03` flagged as late entry. ⛔ `BC-26` counts the flag **as received** and does **not** define lateness — the `lateEntryPolicy` is **`BC-06` Library Policy**'s, reaching `BC-03` over **`E-04`**. | `ATT-PO-002`; D-5a |
| 6 | **`FlaggedEntriesToday`** | `attendance.StudentCheckedIn` | The count of check-ins on one IST day where the membership-validity projection was flagged invalid. ⛔ Validity is **`BC-02` Membership**'s, reaching `BC-03` over **`E-03`** — which *"**flags, never blocks**"*. | `ATT-PO-001`; D-5a |
| 7 | **`SeatsAssigned`** | `seating.SeatAssigned` | The cumulative count of seat allocations becoming `Active`, from any origin, since inception. | `SEAT-EVT-001` **L1474**; D-4.3 |
| 8 | **`SeatsReleased`** | `seating.SeatReleased` | The cumulative count of seat allocations becoming `Released`, from any cause, since inception. | `SEAT-EVT-002` **L1475**; D-4.4 |
| 9 | **`CollectedTodayMinor`** | `fee.FeePaymentReceived` | The sum, in INR minor units, of payments **confirmed** on one IST day. ⭐ ⛔ **`PENDING` payments are excluded by definition** — `FEE-EVT-002` publishes *"**only** when a payment reaches `CONFIRMED`"*. | **`FEE-EVT-002`**; D-3 |
| 10 | **`DuesRaisedTodayMinor`** | `fee.FeeDueRaised` | The sum, in INR minor units, of fee obligations created on one IST day. | **`FEE-EVT-001`**; D-3 |
| 11 | **`SeatsOccupied`** | `seating.SeatAssigned`, `SeatReleased`, `SeatTransferred`, `attendance.StudentCheckedIn`, `StudentCheckedOut` | §3.5 | `SEAT-FR-245`, `SEAT-FR-116` |
| 12 | **`InsideNow`** | `attendance.StudentCheckedIn`, `StudentCheckedOut` | §3.6 | D-10a |

### 3.3 `freshnessExpectation` — behavioural, ⛔ no number invented

> ⭐ For **every** one of the 12: *"Where `BC-26` is unavailable or the value cannot be resolved, the surface
> **MUST** mark itself temporarily unavailable. ⛔ It **MUST NOT** render zero, a stale value of unknown age, or
> an inferred value."*

⭐ Transcribed from **`ADR-0097` §4.2**, already `Accepted`, which discharges `ANL-FR-057` **without** a numeric
threshold. ⛔⛔ **`ANL-CFG-003` remains OWED to SRE** and `ANL-GAP-020` remains **OPEN** — *"⛔ I decline to
invent SLA numbers; no repository standard exists"* (`PRD-009` **L823**). ⛔ **No number is supplied here.**

### 3.4 `accessScope` — `tenantWide` for all 12, and why `guardianOf` is barred

⭐ All 12 are **tenant aggregates**, so `self` cannot apply: `ANL-FR-016` scopes a **student** to *"only their
own analytics"*, which is a per-student readout, not an aggregate.

⛔⛔ **`guardianOf` is NOT assigned to any metric.** `ANL-OBD-004` is **OPEN and HIGH RISK** and requires a
decision *"before any guardian-facing analytic ships"*.

⇒ **`tenantWide`** is the only remaining member of `MP-GBR-21`'s **closed** register. ⛔ No fourth scope is
introduced.

⚠️⚠️ **A tension is recorded rather than smoothed over.** **`ANL-XC-005`** states: *"**Reception MUST NOT** be
able to see aggregate financial or business-performance analytics; least privilege makes it **impossible**, not
merely hidden."* `CollectedTodayMinor` and `DuesRaisedTodayMinor` **are** aggregate financial analytics, yet
`tenantWide` is the only available scope and the register may not be extended without an ADR.

> ⭐ **Resolution:** `ANL-XC-005`'s exclusion is enforced at **authorisation**, not by scope. **`ANL-BR-004`** —
> *"A management **role MUST NOT** by itself grant data visibility — authorization (`BC-18`) and entitlement
> (`BC-21`) remain authoritative"* — and **`ANL-FR-038`** (per-query actor permissions) place the Reception
> exclusion in **`BC-18`**. ⛔ **`BC-26` MUST NOT serve these two metrics to a caller `BC-18` has not
> authorised.**

⛔⛔ **`ANL-OBD-003` is NARROWED, NOT CLOSED.** It remains **OPEN** — *"the exact per-role metric visibility
matrix"*, `[OWED — Product Owner + BC-18]` — for every metric outside these 12. ⭐ This ADR fixes the **scope**
of 12 metrics; it does **not** author the per-role matrix.

### 3.5 ⭐⭐ `SeatsOccupied` — the presence-qualified definition

> ⭐ **`SeatsOccupied`** is the **point-in-time** count of seats that have an **active allocation** whose
> **allocated student has a currently-open attendance session**.
>
> ⭐ `calculation`: maintain the active-allocation set (`SeatAssigned` adds; `SeatReleased` removes;
> `SeatTransferred` re-points the allocation to the destination seat) and the open-session set
> (`StudentCheckedIn` opens; `StudentCheckedOut` closes). **`SeatsOccupied` = the count of active allocations
> whose `studentRecordId` is in the open-session set.**
>
> ⛔⛔ **`SeatsAssigned − SeatsReleased` MUST NOT be used as, labelled as, or presented as occupancy.** That
> figure is **allocation**.

**Authority:** `SEAT-FR-245` (*"A seat allocated to an absent student is allocated but not occupied"*) ·
`SEAT-AC-173` (70 allocated / 40 checked in ⇒ **`SeatsOccupied` = 40**) · `SEAT-FR-116` (recomputable from the
allocation set **and** the `BC-03` open-session set) · `SEAT-XC-019` (`BC-04` publishes facts, `BC-26` defines
the metric) · `E-08` (BC Map **L305**).

⭐ **Feasible without any new fact:** `seating.SeatAssigned` carries `studentRecordId` and
`attendance.StudentCheckedIn`/`CheckedOut` carry `studentRecordId`. The join key already exists in events
`BC-26` already consumes. ⛔ **0 new events, 0 new edges, 0 new domain facts.**

⚠️ **`SEAT-FR-246` obligation carried:** the figure **MUST** be accompanied by its as-of time.

⚠️⚠️ **Two residues, disclosed and NOT resolved.** **(1)** `seating.SeatTransferred` is declared at
`SEAT-EVT-003` and routed to `BC-26` (BC Map **L418**), but measurement shows **`BC-04` never emits it** —
`lib/domain/library/seating/seating.dart` emits exactly two events (`SeatAssigned` **L197**, `SeatReleased`
**L258**) and the seating domain contains **no transfer use case**. The consumer is therefore implemented against
the declared contract and is **dead code until `BC-04` implements transfers**. ⛔ **Emitting it is NOT authorised
by this ADR.** **(2)** `SeatTransferred`'s **payload is specified nowhere** — `SEAT-FR-065` fixes the
*history row*, `SEAT-AC-225` fixes only cardinality. ⛔ The consumer is therefore **defensive**: it acts only on
`SEAT-FR-209`'s mandatory `studentRecordId` and treats absent fields as a no-op. ⛔ **No payload contract is
invented.**

### 3.6 ⭐ `InsideNow` — the running open-session count

> ⭐ **`InsideNow`** is the **point-in-time** count of students with a **currently-open attendance session**: all
> `StudentCheckedIn` facts less all `StudentCheckedOut` facts, **not bounded to any day**.
>
> ⭐ **A student who checked in on a previous day and has not checked out IS counted as inside.**

⛔ **`InsideNow` does NOT inherit the §3.1 IST-day boundary.** ⭐ Consequence: it reads **no clock at all**, which
strengthens `ANL-INV-005` compliance.

⚠️⚠️ **Residue, disclosed and NOT resolved: there is no stale-session rule.** A student who never checks out
inflates `InsideNow` indefinitely. ⛔ **No repository source supplies a session-expiry rule and none is
invented.** Routed to the **Product Owner** with `ANL-OBD-003`.

---

## 4. The decision record — 42 of 42 items, each with its source

⭐ **13 groups · 42 items · 0 blank.** ⚠️ An earlier draft of this record miscounted them as *"17 groups / 41
items"*; the figure is corrected here by mechanical recount rather than restated.

| ID | Decision | Answer | Source |
|---|---|---|---|
| **D-1** | Metric-definition ownership | **Joint PO + AO** | Human conferral; `ADR-0097` precedent |
| **D-00** | Authority instrument | Verbatim in header | `ADR-0097` form |
| **D-0** | Acceptance date | **2026-09-18** | Human |
| **D-2** | Metrics certified | **All 12** | Human |
| **D-3a** | Event time vs read time | **Event time (`occurredAt`)** | Human; required by `ANL-INV-005` |
| **D-3b** | IST day boundary | **`[00:00, next 00:00)`**, start-incl/end-excl | Human; IST from `ANL-FR-055` |
| **D-3c** | Behavioural change accepted | **Yes, under `IMPL-2005`** | Human |
| **D-4.1–4.4** | Period for metrics 1, 2, 7, 8 | **Cumulative since inception** (each answered separately) | Human; ⛔ 0 repository sources |
| **D-5a** | Cross-context flags | **Counted as-received** | BC Map §9; `ANL-INV-002` |
| **D-5b** | New edge needed? | **No** | `ATT-PO-001`/`-002`; `E-03`/`E-04` already declared |
| **D-6** | `freshnessExpectation` | **Behavioural** (§3.3) | `ADR-0097` §4.2 |
| **D-7.1–7.12** | The 12 definitions | §3.2, §3.5, §3.6 | Emission conditions of each source event |
| **D-8.1–8.12** | The 12 access scopes | **`tenantWide`** ×12 | §3.4; `MP-GBR-21` |
| **D-9a** | `SeatsOccupied` formula | **Presence-qualified** (§3.5) | `SEAT-FR-245`; `SEAT-AC-173` |
| **D-9b** | `SeatsOccupied` time | **Point-in-time** | `SEAT-FR-246` |
| **D-9c** | Is `assigned − released` occupancy? | ⛔ **No** | `SEAT-FR-245` |
| **D-10a** | `InsideNow` formula | **Running open-session count** | Human |
| **D-10b** | Inherits D-3? | ⛔ **No** | Follows from D-10a |
| **D-10c** | Overnight counts as inside? | ⭐ **Yes** | Human |
| **D-11** | `metricId` casing | **`PascalCase`** | `ADR-0097` §3.1 |

### 4.1 `ANL-FR-008` / `ANL-FR-009` certification audit

| Field | 12/12 present? |
|---|---|
| `metricId` · `name` · `definition` · `sourceEvents[]` · `calculation` · `owningContext` · `timeSemantics` · `freshnessExpectation` · `accessScope` | ⭐ **YES — 108 of 108 values, 0 blank** |
| `version` (`ANL-FR-010`) · `unit` (`ADR-0097` §3.1) | ⭐ carried as separately-authorised extras |

⭐⭐ **`ANL-FR-009` — *"A metric missing any of the nine MUST be rejected at registration, not published with
blanks"* — is satisfied. Certification is lawful.**

⚠️ **The nine-field divergence is resolved by rule, as `IMPL-2000` was.** `IMPL-2000` lists `formula`, `unit`,
`version` where `ANL-FR-008` lists `definition`, `calculation`, `owningContext`.
`DOCUMENTATION_BASELINE.md` — *"Where a gate record and the PRD disagree, **the PRD governs**"* — and that
file's `PRD-009` row marks the Stage-6 document *"Not part of the specification"*. ⛔ Neither subject was edited.

---

## 5. Consequences

### 5.1 What acceptance authorises
⭐ `IMPL-2005` becomes executable · ⭐ `IMPL-2006` is discharged for these 12 · ⭐ `AN-2` continues to hold,
because definitions live only in `lib/platform/analytics/semantic_layer.dart`.

### 5.2 ⛔ What acceptance does NOT achieve
⛔ **F-1 / `ANL-GAP-001` do not close on acceptance** — certification authorises the migration; the migration
must then be performed. ⛔ **0** of `PRD-009`'s 36 `ANL-AC-*` are discharged: measured, **none** binds
`ANL-FR-008` or `ANL-FR-009`, so no requirement moves to ✅ (`PRD_LIFECYCLE.md` Stage 8). ⛔ `ANL-GAP-002`
persists, so `ANL-FR-053` restatement stays unsatisfiable for metrics 3–6.

### 5.3 ⚠️ Disclosure — `PRD-009` does not cite either metric ADR
Measured: **0** references to `ADR-0097`, `ProfileViews` or `UniqueViewers` in `PRD-009`. This ADR is the
**second** metric instrument the FROZEN Rank-3 PRD does not cite. ⛔ **Disclosed, not repaired** — repair means
unfreezing a Rank-3 document.

---

## 6. ⛔ What this ADR deliberately does not do

⛔ Certify `UniqueViewers` · ⛔ alter `ProfileViews` · ⛔ create any 13th metric · ⛔ invent a threshold, SLA,
session-expiry rule, day-boundary source or payload contract · ⛔ create an event, edge, domain fact, aggregate or
bounded context · ⛔ open `SEAT-FR-206`'s closed event set · ⛔ reuse `E-27` · ⛔ amend `PRD-006`, `PRD-007`,
`PRD-009`, the BC Map or `tool/module_dependencies.yaml` · ⛔ edit `ADR-0032` or any Accepted ADR · ⛔ introduce a
fourth access scope · ⛔ assign `guardianOf` · ⛔ close `ANL-OBD-002`/`-003`/`-004`/`-005`/`-006`/`-007`/`-009` ·
⛔ close `ANL-GAP-001`/`-002`/`-020`, `SEAT-GAP-008` or `ANL-AL-B1` · ⛔ amend any `IMPL-*` row · ⛔ open the Figma
gate · ⛔ record a personal name.

## 7. Residues carried forward — OPEN, none closed

| Residue | Owner |
|---|---|
| `seating.SeatTransferred` is **never emitted**; consumer is dead code until `BC-04` implements transfers | Architecture Owner |
| `seating.SeatTransferred` **payload unspecified** — consumer is defensive | Architecture Owner |
| `InsideNow` has **no stale-session rule** | Product Owner |
| **`ANL-OBD-003`** — per-role visibility matrix, **narrowed not closed** | Product Owner + `BC-18` |
| **`ANL-OBD-004`** — `guardianOf` reach, **HIGH RISK** | `BC-18` owner |
| **`ANL-CFG-003`** / `ANL-GAP-020` — numeric freshness | **SRE** |
| **`SEAT-GAP-008`** — operating-day boundary source | `BC-06` owner + Architecture |
| **`ANL-GAP-002`** — `AttendanceCorrected` unconsumed | Architecture + Implementation |
| **`ANL-AL-B1`** — Rank-4 `iam.*` conflict | Architecture Owner |
| `IMPL-2005`'s `Blocked by` = "—" is **wrong** | Implementation Lead |
| `PRD-009` cites neither `ADR-0097` nor this ADR | Product Owner |

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-18 | ⭐⭐ **Accepted. `ANL-OBD-001` RESOLVED — Certified Metric definitions are owned JOINTLY by the Product Owner and Architecture Owner. All 12 `DashboardMetrics` counters certified at `version: 1` with all nine `ANL-FR-008` fields — 108 of 108 values, 0 blank.** ⭐⭐ **`SeatsOccupied` is certified presence-qualified** per `SEAT-FR-245`/`SEAT-AC-173` (70 allocated / 40 present ⇒ **40**); ⛔ `assigned − released` is **allocation, never occupancy**. ⭐ **`InsideNow`** is a running open-session count, ⛔ **not** day-bounded, so overnight presence counts. ⭐⭐ **A measured `ANL-INV-005` breach is corrected**: `analytics.dart` **L157–160** read the wall clock inside projection logic at four call sites; the IST day is now evaluated against `occurredAt`, making all six `...Today` metrics replay-stable. ⚠️⚠️ **`ADR-0148` was drafted, conferred, NARROWED and WITHDRAWN without being created — and the trail is recorded at §2.3 rather than erased.** The wide ruling would have amended FROZEN `SEAT-FR-037`/`-041`/`AC-020`; measurement then found **FROZEN `PRD-006` v1.9 L2201 discharges its own §19 by citing `SEAT-FR-041` verbatim**, so the narrowed `BC-26`-only ruling was taken on the structural separation `SEAT-XC-019` already draws between §6 `SeatState` and §25 metrics. Its L2 limb — a new `SEAT-EVT-005` `seating.SeatOccupancyChanged` — was **withdrawn as unnecessary** once measurement showed `SeatAssigned` and `StudentCheckedIn`/`CheckedOut` **both carry `studentRecordId`**, so `BC-26` can compute the intersection from facts it already consumes. ⭐⭐ **Net governance cost: ZERO.** ⛔ **0** frozen documents amended (`PRD-007` stays v1.1, `PRD-006` v1.9, `PRD-009` v0.6), ⛔ **0** baseline re-issues, ⛔ **0** BC Map edits, ⛔ **0** events added to the closed `SEAT-FR-206` set, ⛔ `E-27` **not** reused, ⛔ `ADR-0032` **not** edited and **not** requiring supersession (determined at §2.3). ⭐ `ProfileViews` **byte-unchanged**; ⛔ `UniqueViewers` **remains uncertified** (`U1`–`U8`; uncomputable from the `E-30` payload). ⛔ **11 residues carried forward OPEN** (§7), including two newly measured: `SeatTransferred` is **never emitted** by `BC-04` and its **payload is specified nowhere**, so its consumer is defensive dead code. ⛔ **No threshold, SLA, session-expiry rule, payload contract, domain fact, edge, event or access scope invented.** ⛔ F-1 **NOT closed** — this authorises `IMPL-2005`; it does not perform it. ⛔ **0** of 36 `ANL-AC-*` discharged. |
