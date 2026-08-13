# ADR-0024 — A Library Presence Session is required for V1, and this ADR frames where it lives without placing it

| Field | Value |
|---|---|
| **Status** | **Proposed** — not binding. *(`ADR-INDEX.md` status vocabulary: "Under consideration; not binding")* |
| **Date** | 2026-08-05 |
| **Deciders** | **Architecture owner (ARB)** — placement of a new aggregate and its relationship to `AttendanceDay` is a structure decision, named in `ADR-INDEX.md` Process step 1 |
| **Supersedes** | Nothing |
| **Amends** | **Nothing.** While `Proposed` this ADR amends no document, binds nothing and confers nothing. All Rank 1–7 documents are byte-identical |
| **Baseline** | **None issued.** A `Proposed` ADR is not binding; no Rank 1–3 document changes version. Baseline remains **`BASELINE-2026-08-04-E`** |
| **Closes** | **Nothing** |
| **Related** | `ATT-BR-033` (L1066) · `ATT-FR-140` · `ATT-BR-045` (L1564) · BC Map `E-08` (L305), §8 aggregates (L368-390) · `ATT-INV-004` · `ATT-BR-003` · `ARCHITECTURE_RULINGS.md` L290 · `ADR-0013` · `ADR-0025` (attendance integration) · `ADR-0026` (Study Hours) · [`PRD-006_ADDITIVE_WIFI_PRESENCE_IMPACT_REPORT.md`](../../30-product/attendance-management/PRD-006_ADDITIVE_WIFI_PRESENCE_IMPACT_REPORT.md) §15 |

> ⚠️ **`Proposed`. This ADR frames a decision it is not authorised to make.**
>
> `ADR-0013` and `ADR-0014` were likewise authored `Proposed` and accepted later. That is the precedent followed here.

---

## 1. Context

The Product Owner has decided that **Wi-Fi Presence is required for V1** (Option B). That scope decision is genuine
and is not re-litigated here.

The capability needs a concept that does not exist in `PRD-006` v1.4: a **Library Presence Session** with a start, an
end, a duration and a status, following the lifecycle

```
NOT_PRESENT → AUTHORIZED_WIFI_VERIFIED → PRESENCE_ACTIVE → WIFI_DISCONNECTED → PRESENCE_ENDED
```

**The obstacle is a MUST NOT, quoted exactly.** `PRD-006` §14.7 `ATT-BR-033` (L1066):

> This module **MUST NOT** create a second presence, occupancy or "currently inside" system of record beyond the
> `AttendanceDay` aggregate. Live seat occupancy is `BC-04`'s (§23).

Reinforced by `ATT-BR-045` (L1564) — *"Neither module **SHALL** hold a shadow copy of the other's system of record"* —
and BC Map `E-08` (L305) — *"**Seating is the occupancy owner**, Attendance is the trigger."*

BC Map §8 (L368-390) further fixes the aggregate boundary in a **Rank 4** document:

```
BC-03 | AttendanceDay (aggregate = one student-day, not one punch)
      | Punch, VerificationEvidence(GPS/WiFi/QR), CorrectionRecord
      | no more than one open session per student at any moment
```

So a Presence Session is neither a field on `AttendanceDay` nor obviously a new aggregate. **Someone with authority
must place it.** This ADR does not.

## 2. The question

**Where does the Library Presence Session live, such that `ATT-BR-033` is honoured rather than bypassed?**

The Product Owner's own instruction (§7) sets the constraint on any answer: *"Do not create a competing second
'currently inside' system of record"* and *"If a dedicated Presence Session entity is architecturally necessary → define
its ownership and relationship to `AttendanceDay` through an ADR."*

## 3. Alternatives

### Option 1 — Subordinate entity inside the `AttendanceDay` aggregate

`PresenceSession` becomes a child of `AttendanceDay`, alongside `Punch` and `VerificationEvidence`.

- **For:** `AttendanceDay` remains the single system of record, so `ATT-BR-033` is satisfied on a plain reading. No new aggregate. No new bounded context.
- **Against:** BC Map §8 states the aggregate is *"one student-day, not one punch."* A session that spans a disconnect/reconnect within a day is a second lifecycle inside a day-shaped aggregate. Multiple sessions per day (10:00–12:00, 13:00–…) means the child is a collection with its own state machine. Also `ATT-BR-003` (one transaction, one aggregate) makes every presence transition a write to the whole attendance aggregate.
- **Cost:** amends BC Map §8 (**Rank 4**) to list `PresenceSession` among `BC-03` entities.

### Option 2 — Separate aggregate inside `BC-03`, with `AttendanceDay` retaining attendance authority

`PresenceSession` is its own aggregate in the Attendance context. `AttendanceDay` stays authoritative for attendance;
`PresenceSession` is authoritative for *verified presence intervals* only.

- **For:** clean lifecycle separation; matches the request's §16 requirement that Attendance, Presence and Study Hours stay three distinct concepts; keeps `ATT-BR-003` intact.
- **Against:** requires the Architecture Owner to affirm that *"verified presence interval"* is **not** the *"second presence … system of record"* that `ATT-BR-033` forbids. That is a genuine semantic judgement. It may be a defensible distinction — verification state is not occupancy state — but **this ADR must not make that finding on the ARB's behalf.**
- **Cost:** amends BC Map §8 (**Rank 4**) and `ATT-BR-033` itself in `PRD-006`.

### Option 3 — Owned by `BC-04` Seating, which already owns occupancy

- **For:** `BC-04` is already the occupancy owner per `E-08`, so no ownership conflict arises at all.
- **Against:** presence-in-the-library is not seat occupancy; a student may be present without a seat. It would also make attendance depend on Seating for its own trigger, inverting `E-08`. And `ARCHITECTURE_RULINGS.md` L290 defers **Public Live Occupancy to V2**, warning that *"live per-seat occupancy is a proxy for individual presence and **must not be invented**."*
- **Cost:** amends BC Map §7 edges and §8, plus `PRD-007` (**Rank 3, FROZEN** — `ADR-0020`).

### Option 4 — A new bounded context for Presence

- **For:** maximal separation; no existing MUST NOT is stretched.
- **Against:** a new bounded context is the heaviest possible structural change; `ADR-0013` sets the precedent that capability contexts are platform-owned, which would place it outside `BC-03` entirely and require new edges for every consumer.
- **Cost:** BC Map §4, §7, §8, Dependency Matrix, `PRD_REGISTRY.md`.

## 4. Decision

**None. Deferred to the Architecture owner (ARB).**

This ADR records that a Presence Session is **necessary for the V1 capability the Product Owner has approved**, that
its placement is a structural decision, and that four placements are available with materially different costs.

It does **not** choose, because choosing would be an ownership and structure ruling that only the ARB may make
(`PRD_OWNERSHIP_MODEL.md` §5: *"Only the Architecture Owner approves"*).

## 5. Constraints binding on any option chosen

Whichever option is selected, the following are **not negotiable** and are recorded here so the decision cannot
accidentally violate them:

| # | Constraint | Source |
|---|---|---|
| 1 | `BC-04` remains the owner of seat occupancy | `E-08`, `ATT-BR-033` |
| 2 | `AttendanceDay` remains authoritative for attendance | `ATT-BR-033`, request §7 |
| 3 | No shadow copy of another module's system of record | `ATT-BR-045` |
| 4 | One authoritative session per student + library + active session; no overlapping duplicates | `ATT-INV-004`, request §2 |
| 5 | Every record tenant-scoped, backend-enforced | `ATT-BR-017`, request §17 |
| 6 | Session start/end derive from the platform time port, never a client clock | `ATT-FR-088` (L1055) |
| 7 | An end timestamp **MUST NOT** be fabricated | `ATT-BR-030` (L1025) |
| 8 | Attendance, Presence and Study Hours remain three distinct concepts | request §16 |
| 9 | Live public occupancy remains **V2-deferred** and must not be introduced through this door | `ARCHITECTURE_RULINGS.md` L290 |

## 6. Consequences

- **If accepted with any option:** BC Map §8 (**Rank 4**) requires amendment, ADR-first per `DOCUMENTATION_BASELINE.md` L286. `ATT-BR-033` requires amendment in `PRD-006` to name the permitted exception explicitly rather than leaving it implied.
- **If Option 2 or 3 is chosen:** the semantic finding — that verified presence is or is not the forbidden "second presence system of record" — must be stated in the accepting decision **in words**, so that no future reader must infer it.
- **If left `Proposed`:** `PRD-006` cannot progress past Stage 4 for the Wi-Fi Presence scope, because an approved V1 requirement would have no data owner. Existing QR, Wi-Fi-assisted QR and GPS attendance are **unaffected** and remain fully specified.

## 7. What this ADR explicitly does not do

- It does **not** create, name or place a `PresenceSession` aggregate.
- It does **not** amend `ATT-BR-033`, BC Map §8, or any other document.
- It does **not** decide the Study Hours question — that is `ADR-0026`.
- It does **not** decide how attendance is produced from a session — that is `ADR-0025`.
- It does **not** assert approval by any person or body.
