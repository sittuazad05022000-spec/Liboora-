# ARCHITECTURE AND BOUNDARIES — `PRD-021C` C0–C8

**Derived document.** ⛔ No authority. Authority: [`../PRD/`](../PRD/) (**FROZEN**) ·
**`Accepted`** ADRs in [`../ADR/`](../ADR/) · [`../ARCHITECTURE/`](../ARCHITECTURE/).

---

## 1. ⭐⭐ The structural premise, stated before anything else

**The Library Marketplace is not a bounded context.**

C8 **§3** is titled *"The structural premise: the marketplace is not a context"*,
and C0 **§2** answers the same question from the repository. The marketplace is a
**capability-layer composition** over domain contexts that already exist.

This is not a stylistic preference. It is the fact from which every other rule in
`PRD-021C` follows, and it is measurable:

| Measurement | Value | Source |
|---|---|---|
| Bounded contexts created by C0–C8 | **0** | C0 **L533** — *"Bounded contexts created ⛔ 0"* |
| Bounded contexts in the repository, before and after | **31** | `../ARCHITECTURE/LIBOORA_BOUNDED_CONTEXT_MAP.md` **L10** |
| Integration edges, before and after | **29** | BC Map §7 (26 `E-nn` rows + `E-28`, `E-29`, `E-30`) |
| Domain events created | **0** | C8 `LMT-XC-008`; C0 §3.3 |
| Tables / columns / migrations | **0** | C8 `LMT-FR-006` |
| Aggregates / invariants / business state | **0** | C0 **§3.2** |

⚠ **`E-27` is permanently vacant** and `E-31` *"would be next and ⛔ is not minted
here"* (C8 `LMT-XC-009`). If your design needs a new edge, you have left the
specification — stop and route it to the Architecture Owner.

---

## 2. The dependency law

BC Map **L292**, quoted by C8 `LMT-XC-009`:

> *"if an edge is not in this table, it **does not exist** and adding it requires an ADR."*

and C8 `LMT-FR-014`, delegating to ruling `F-1`:

> *"no capability context may import, reference or query a domain context"*

**Two rules, and they are different.** The first governs *whether a dependency may
exist*. The second governs *how it is reached*. Both bind:

| You want to… | Lawful route | ⛔ Forbidden |
|---|---|---|
| Read owned data | The owner's **provided read** | ⛔ Querying the owner's tables |
| Cause a domain change | The owner's **public command API via a registered port** — the domain **re-validates** and treats you as **untrusted** (`LMT-BR-012`, ruling `F-3`) | ⛔ Writing the owner's state |
| Reach a context with no edge | ⛔ **Nothing.** Write the requirement as conditional and blocked, and record the gap with an owner | ⛔ Inventing an edge |

⭐ **C0 §4 applies this without exception**, including against itself:

> ⛔ **No edge is created, extended or implied by this draft.** Where an edge is
> missing, the requirement is written as **conditional and blocked**, and the gap
> is recorded in §5 with a named owner.

### 2.1 ⚠ The wildcard/enumeration distinction — the trap in §4

Five edges carry the **wildcard** source *"All contexts"* and are therefore
available to the marketplace: `E-17`, `E-18`, `E-19`, `E-20`, `E-23`.

**Two do not.** `E-21` (domain → search index) and `E-22` (domain → file/media)
carry **enumerations**, and the contexts the marketplace needs are **absent** from
them:

| Edge | BC Map line | Enumerated source/consumers | Missing | Recorded as |
|---|---|---|---|---|
| `E-21` | **L330** | `BC-01`, `BC-10` | **`BC-19`** | `XPC-CONF-004`, **OPEN** |
| `E-22` | **L331** | `BC-01`, `BC-10`, `BC-12`, `BC-14` | **`BC-19`**, **`BC-25`** | `XPC-CONF-007`, **OPEN** |

⭐ C0 **§4** records that `ADR-0084` already tested the "treat it as a wildcard"
argument for `E-21` and it *"**failed**"*, and that the finding is *"honoured, not
re-litigated"*. **Do not re-litigate it in code.**

⛔ `E-24` (offline booking queue) is sourced from **`BC-03` Attendance only**;
`BC-04` is **not** a consumer. C0 resolves this *"by exclusion, not by an edge"*
(`XPC-CONF-011`) — which is why C8 `LMT-FR-025` forbids any local write buffer,
store-and-forward queue or offline mutation log.

---

## 3. Module placement

C8 **§4** governs placement and C8 `LMT-FR-012` names the mechanism for deferred
work: the **declared port** `platform/services:job_runtime`
(`tool/module_dependencies.yaml` **L338**). ⛔ No new job system, scheduler or
worker pool.

⚠ **`tool/` is not in this package** — it is excluded as tooling. The port name
above is reproduced from C8 so you know what to look for; read it in the
repository, not here.

---

## 4. The boundaries that must not move

### 4.1 ⭐⭐ Availability and booking — C4 defines **no booking**

This is the boundary most likely to be got wrong, because C4's title contains the
word *booking*.

C4 **L17–L21**, in the file's own provenance header:

> **BOOKING IS ALREADY OWNED, FROZEN, BY PRD-007.**
> `PRD-SEAT-MANAGEMENT.md` L153 defines Booking; sections 11 and 12 fully specify
> student self-booking, booking modes, reservations and conversion.
> **C4 therefore DEFINES NO BOOKING.** C4 is a presentation and **INITIATION**
> surface that hands off to `BC-04`.

Recorded as `XPC-CONF-008`. Frozen `PRD-007` **L153** defines the term:

> *"**`Booking`** — A **student-initiated** request that produces a reservation or an allocation per §12."*

C4 **§1.2** then tabulates what `PRD-007` already froze — `SEAT-FR-076`…`SEAT-FR-084`
covering self-scope, holder non-disclosure, explicit dates, the membership
`validUntil` bound, the no-past-start rule, the advance window consumed from
`BC-06`, and overlapping bookings against `seatQuota`. C4 **cites** these and
**specifies nothing new**; concurrency and idempotency are likewise frozen
(`SEAT-BR-031`, `SEAT-FR-196`…`205`, `SEAT-BR-032`, `SEAT-XC-013`).

**What you build for C4:** a surface that *presents* availability and *initiates*
a booking through `BC-04`'s command API. **What you must not build:** a booking
entity, a reservation, an allocation, a lock, a seat state, or any rule about them.

### 4.2 ⛔ "Live" availability is forbidden in V1

C4 **L10–L15**:

> **"LIVE" seat availability is FORBIDDEN in V1.**
> `LIB-14B.13` — Public Live Occupancy is V2 and MUST NOT be implemented in V1
> `SEAT-XC-009` — per-seat identity/state and live occupancy MUST NOT be public in V1

The public surface is **aggregate capacity + coarse indicator only**
(`LIB-14B.11`, `LIB-14B.12`, `SEAT-FR-117`, `LIB-7.3`), recorded as `XPC-CONF-009`.

C4 **L95–L98** enumerates the refusals: ⛔ live occupancy count, ⛔ live occupancy
percentage, ⛔ precise free-seat count, ⛔ per-seat map, ⛔ per-seat state, ⛔ per-seat
history, ⛔ seat-level timing, ⛔ waitlist position, and ⛔ **any value derived from
attendance** (`LIB-14B.14`).

⚠ **"Derived from attendance" catches the clever implementations too.** A free-seat
count reconstructed by subtracting occupancy from capacity is a derived value and
is forbidden by the same rule.

### 4.3 ⛔ Ratings and reviews (C5) are **V2** — build the absence

C5 is a **V2** feature. Two frozen authorities say so: `Library_PRD_v1.md`
**L1016** and `ARCHITECTURE_RULINGS.md` **L291**. C0 **L500** records C5's V1
position as **vacuous**.

⭐ This is why the C5 implementation group (`IMPL-1775`…`IMPL-1778`) is *"a set of
absence tests rather than a review feature"*
([`../IMPLEMENTATION/PRD-021C_IMPLEMENTATION_TASKS.md`](../IMPLEMENTATION/PRD-021C_IMPLEMENTATION_TASKS.md) §0 rule 3):

> Where the PRD's own answer is *"do not build this"*, the task implements **the refusal**.

C7 **§4.5** reinforces it: abusive reviews and rating manipulation are
**IMPOSSIBLE, not deferred** — there is no review surface to abuse.

### 4.4 Trust & safety (C7) — the report is entered, never decided

C7 **§0** states the finding before its evidence, and **§1.3** explains why C7
cannot simply call `BC-13`. Frozen `PRD-020` owns the **report**, the **moderation
case**, the **enforcement action** and the **effective restriction**. C7 owns the
**report-entry surface** (**§4.1**) and the **presentation of enforcement
consequences** (**§4.2**) — nothing else.

### 4.5 ⛔ No duplication of `PRD-021B`

C6 **§2.3** — ⛔ no duplication of `PRD-021B`'s student discovery or ranking.
`PRD-021B` is **FROZEN** at Rank 3 and owns that surface.

---

## 5. Bounded contexts the marketplace composes

Named by C0 **§3.1** and C8 **§5**. ⛔ The marketplace owns **none** of them.

| Context | Role in the marketplace | Owning PRD | Status |
|---|---|---|---|
| `BC-19` Tenancy | Library identity, address, location, status, contact | `PRD-013` | **FROZEN** |
| `BC-25` Configuration | Logo, cover image, description | `PRD-023` | **FROZEN** |
| `BC-29` File & Media | Gallery media, `FileRef` only | `PRD-017` | **FROZEN** |
| `BC-06` Library Policy | Operating hours, holidays, closure | `PRD-002` | **FROZEN** |
| `BC-02` Membership | Plans, pricing, join | `PRD-005` | **FROZEN** |
| `BC-04` Seating | Capacity, availability, **all booking** | `PRD-007` | **FROZEN** |
| `BC-01` Enrollment | Student record | `PRD-004` | **FROZEN** |
| `BC-18` Identity & Access | Authentication, **every authorisation decision** | `PRD-001` | **FROZEN** |
| `BC-21` Entitlement | Quota answers | `PRD-014` | **FROZEN** |
| `BC-24` Audit Trail | Audit records | `PRD-016` | **FROZEN** |
| `BC-13` Trust & Safety | Reports, cases, enforcement | `PRD-020` | **FROZEN** |
| `BC-23` Search Indexing | Discovery projection, query, relevance | `PRD-015` | ⚠ `PLANNED` — **no document** |
| `BC-26` Analytics Read Model | `ProfileViews` | `PRD-009` | ⚠ `PLANNED` — **no document** |
| `BC-22` Notification Delivery | Notification delivery | — | ⚠ `PLANNED` |

⚠⚠ **`PRD-015` and `PRD-009` do not exist.** Measured: `git ls-files | grep -c` for
each returns **0**, and C0 says so in terms — *"`PRD-015` — ⚠ **does not exist**"*
and *"`PRD-009` is `PLANNED` and absent from disk (`PRD_REGISTRY.md` **L246**)"*.

**This is a real, open dependency, not a documentation gap.** C2's search surface
and C3's Profile Views readout depend on contexts whose specifications have not
been written. An implementer reaching one of these has reached **an unwritten
upstream**, not a missing file in this package.

---

## 6. What the marketplace *does* own

C0 **§3.2**, complete and unabridged:

| Owned | Detail |
|---|---|
| **Composition and presentation rules** | Which owned read model appears on which public surface, in what order, under what visibility gate |
| **Query shape and filter semantics** | The filter set of §14A.4, expressed as measurable requirements |
| **The authentication boundary placement** | Where an anonymous surface stops, per §14B.6 — **enforced**, never redefined |
| **Nothing else** | ⛔ No aggregate. ⛔ No invariant. ⛔ No business state. ⛔ No stored price, seat, membership, index or media byte |

**Build exactly that list. Everything else belongs to somebody else.**

---

## 7. The parts, and their owned registers

| Part | Stem | Lines | Scope |
|---|---|---|---|
| **C0** | `XPC-` | 576 | Cross-part architecture, ownership matrix, conflict register, open decisions |
| **C1** | `LMP-` | 365 | Marketplace foundation — tenancy-scoped public read surface |
| **C2** | `LSD-` | 472 | Library search & local discovery |
| **C3** | `LPP-` | 1,039 | Library public profile |
| **C4** | `LSB-` | 593 | Seat availability presentation & booking **initiation** |
| **C5** | `LRR-` | 726 | Ratings & reviews — ⛔ **V2**; V1 is absence |
| **C6** | `LDR-` | 755 | Discovery presentation & ordering |
| **C7** | `LTS-` | 719 | Trust & safety integration |
| **C8** | `LMT-` | 778 | Technical & production architecture |

**Total 6,023 lines / 446,994 bytes.** **30 registers · 528 identifiers · 258
normative obligations (220 `*-FR-*` + 38 `*-BR-*`) · 118 exclusions · 123
acceptance criteria** — [`../IMPLEMENTATION/TRACEABILITY_MATRIX.md`](../IMPLEMENTATION/TRACEABILITY_MATRIX.md) **§2R**.

⚠ **Reverse coverage is 210 of 258 = 81.4%; 48 obligations carry no acceptance
criterion.** Registered at its measured value and **not** repaired by minting
criteria. See [`TESTING_REQUIREMENTS.md`](./TESTING_REQUIREMENTS.md) §5.

---

## 8. Required-topic coverage map

The instruction governing this package names 16 topics. Each is covered **where
supported by repository evidence**, and the evidence is named.

| # | Topic | Document | Principal evidence |
|---|---|---|---|
| 1 | Architecture / boundaries | this document | C0 §2, §4 · C8 §3, §4 |
| 2 | BC ownership | this document §5; [`OWNERSHIP_AND_DATA.md`](./OWNERSHIP_AND_DATA.md) | C0 §3.1 · C8 §5 |
| 3 | Data / entity ownership | [`OWNERSHIP_AND_DATA.md`](./OWNERSHIP_AND_DATA.md) | C0 §3.1 · C8 §5.1, §6.1 |
| 4 | API / contract expectations | [`API_AND_CONTRACTS.md`](./API_AND_CONTRACTS.md) | C8 §9 |
| 5 | Integrations | [`INTEGRATIONS_AND_EVENTS.md`](./INTEGRATIONS_AND_EVENTS.md) | C0 §4 · C8 §7.3 |
| 6 | Events | [`INTEGRATIONS_AND_EVENTS.md`](./INTEGRATIONS_AND_EVENTS.md) | C0 §3.3 · C8 §7 |
| 7 | Authorization | [`AUTHORIZATION_AND_SECURITY.md`](./AUTHORIZATION_AND_SECURITY.md) | C8 §9.4 · C7 §4.4 |
| 8 | Tenant isolation | [`OWNERSHIP_AND_DATA.md`](./OWNERSHIP_AND_DATA.md) §4 | C8 §6.2, §6.3 |
| 9 | Search / ranking | [`SEARCH_RANKING_AND_DISCOVERY.md`](./SEARCH_RANKING_AND_DISCOVERY.md) | C2 §1.1, §5–§7 · C6 §1–§5 |
| 10 | Availability / booking boundaries | this document §4.1, §4.2 | C4 **L17**, **L95**, §1.2 |
| 11 | Analytics | [`ANALYTICS_AND_OBSERVABILITY.md`](./ANALYTICS_AND_OBSERVABILITY.md) | C8 §11 · C3 · `ADR-0097` |
| 12 | Testing requirements | [`TESTING_REQUIREMENTS.md`](./TESTING_REQUIREMENTS.md) | the 123 ACs · §2R |
| 13 | Error / failure handling | [`ERROR_AND_FAILURE_HANDLING.md`](./ERROR_AND_FAILURE_HANDLING.md) | C8 §10.3 |
| 14 | Observability | [`ANALYTICS_AND_OBSERVABILITY.md`](./ANALYTICS_AND_OBSERVABILITY.md) §5 | C8 §11 |
| 15 | Security | [`AUTHORIZATION_AND_SECURITY.md`](./AUTHORIZATION_AND_SECURITY.md) | C8 §6.2, §9.4 · C7 §4.4 |
| 16 | Implementation task references | [`IMPLEMENTATION_TASK_REFERENCE.md`](./IMPLEMENTATION_TASK_REFERENCE.md) | `PRD-021C_IMPLEMENTATION_TASKS.md` |

⚠ **Two topics are covered by recording an absence rather than a specification**,
because the frozen sources define none: there is **no endpoint table** (see
[`API_AND_CONTRACTS.md`](./API_AND_CONTRACTS.md) §1) and **no database schema**
(C8 `LMT-FR-006` requires **0** tables). Writing either would have invented the
thing this package was instructed not to invent.

---

## 9. Open items you will meet

**FROZEN is a process status.** It means *changing this now requires an ADR*. It
does **not** mean complete, correct or free of open questions.

| Open item | Status |
|---|---|
| `XPC-OD-004`, `XPC-OD-006`, `XPC-OD-008`, `XPC-OD-009`, `XPC-OD-010` | **OPEN** |
| `XPC-OD-005` | **OPEN — and unclosable as constituted.** Its owner role, **Privacy Owner**, has **no holder** (`../GOVERNANCE/PRD_OWNERSHIP_MODEL.md` **L509**) |
| `XPC-CONF-004` (`E-21` omits `BC-19`), `XPC-CONF-007` (`E-22` omits `BC-19`/`BC-25`) | **OPEN** |
| `GAP-BCMAP-BC26-EDGES` | **OPEN and INHERITED** — C8 `LMT-BR-010`. Owner: Architecture Owner |
| `ADR-0088`, `ADR-0089`, `ADR-0090` — cited **4**, **2** and **2** times, **not written** | **OPEN.** Reserved identifiers, absent from the repository and therefore from this package |

⛔ **Do not close any of these by guessing.** Five sibling decisions were closed
by `ADR-0093`…`ADR-0097`; these were not.
