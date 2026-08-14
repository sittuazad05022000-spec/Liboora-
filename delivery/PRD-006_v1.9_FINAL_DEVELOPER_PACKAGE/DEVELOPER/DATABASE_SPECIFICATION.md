# DATABASE_SPECIFICATION — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md) (**FROZEN**) · the **`Accepted`** ADRs in [`../ADR/`](../ADR/) · BC Map §8.

---

## 1. Read this first — this document contains no schema

**There is no database schema to specify, because the frozen specification does
not define one.**

Measured, not assumed. A case-insensitive search for `CREATE TABLE`, `varchar`,
`NOT NULL` and `primary key` across the five authoritative documents:

| Document | DDL occurrences |
|---|---|
| `PRD-006_ATTENDANCE-MANAGEMENT.md` (frozen v1.9) | **0** |
| `ADR-0034` (`Accepted`, admitting ADR) | **0** |
| `ADR-0032` (`Accepted`, Seat Card presence) | **0** |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` (v1.7) | **0** |
| `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **0** |

The PRD's occurrences of the word *"column"* refer to an **owner column in a
table of prose**, not to a database column.

**Writing DDL here would have invented fields no one approved** — precisely what
this package was instructed not to do. This document therefore specifies the
**constraints any future schema must satisfy**, and names what is still
undecided.

## 2. What the specification defines instead of tables

| Concept | Source |
|---|---|
| **`AttendanceDay` aggregate** and its invariants | BC Map §8; `ATT-INV-002` … `ATT-INV-005` and §6.3 |
| **12 invariants** — `ATT-INV-001` … `ATT-INV-012` | §6.2 / §6.3 |
| **Nine stored status strings** | §10A.1 |
| **24 configurables** with authority + default + range | §16 |
| **14 ports** — including how offline replay is resolved | §20, §27.1 |

**Model the aggregate and its invariants. Let persistence follow from them.**

## 3. Constraints any schema MUST satisfy

### 3.1 The nine status strings are the complete stored vocabulary

§10A.1 defines **nine**, and **rows 8 and 9 are explicitly stored, not derived**:

`VERIFIED PRESENCE` · `SCHEDULE MISMATCH` · `SESSION ENDED` ·
`INCOMPLETE / EXIT NOT VERIFIED` · `UNKNOWN DEVICE / UNVERIFIED PRESENCE` ·
`VERIFIED MEMBER` · `UNVERIFIED — NO ATTENDANCE` ·
**`NO BOOKED SHIFT / PRESENCE UNASSIGNED`** ·
**`SHIFT OVERSTAY / PRESENCE OUTSIDE BOOKED WINDOW`**

**Do not add a tenth**, and do not "normalise" two of them into one — `ADR-0029`
considered inventing an extra string for a null shift reference and **refused**.

### 3.2 Exit method must be stored separately from status

§10A.4a rows 1 and 3 both yield **`SESSION ENDED`** but are **different facts**. A
Wi-Fi-based exit and a physically verified exit **MUST NOT** be conflated, merged,
displayed identically, or **stored as the same value**.

**Therefore status alone is insufficient.** The exit method (*"physically verified
exit"*, *"Wi-Fi-based exit detection"*, or **none**) is its own stored fact.

### 3.3 No fabricated exit timestamp may ever be persisted

**`ATT-AC-220`** and §10A.5: a gap containing no observation yields
`INCOMPLETE / EXIT NOT VERIFIED` **rather than a computed exit instant**. Any exit
timestamp column **must be genuinely nullable**, and the code must never populate
it from the *"last known network event"*.

### 3.4 Session state is DERIVED — do not persist it as truth

The 5-minute grace is *"a **predicate over recorded observations**, evaluated when
the session is read or reconciled — **never a scheduled job**"*, and frozen
`SEAT-FR-116` requires the `BC-03` open-session set to be **recomputable**.

**Consequence:** observations are the durable facts; open/closed session status is
**computed**. A materialised status is a cache and must be recomputable from the
observations at any time. **No timer table, no scheduled-job table, no
"session_expires_at" treated as authoritative.**

### 3.5 Presence must not be stored outside `BC-03`

- **`ATT-AC-219`:** presence exposed for composition is **never a stored copy**
  held by the consumer; it is computed on each read and carries its observation
  instant.
- Frozen **`SEAT-FR-104`:** presence is **composed at read time** and **MUST NOT
  be stored** on the seat or the allocation.
- **No shadow copy** of presence in the seating schema. `PRD-006`'s
  no-shadow-copy business rule is listed by `ADR-0033` among the things `O-C`
  leaves unchanged.

### 3.6 No raw network data may be retained where it can escape

**`ATT-AC-218`:** no SSID, BSSID, signal strength, MAC address or other network
datum may cross the module boundary, and **no consumer may obtain one through the
exposed path**. Whatever is stored internally, the boundary must not leak it —
including via views, projections, exports, logs or error payloads.

### 3.7 Append-only corrections; audit has no update or delete path

- `ATT-INV-005` / `ATT-BR-040` pair with platform rule **`MP-GBR-11` append-only
  corrections**.
- **`X-10`: no update and no delete path** for audit.
- A correction is a **new appended row** that emits `ATT-EVT-003`, never an
  in-place edit of the original.

### 3.8 Idempotency must be enforceable in storage

`ATT-INV-003` / `ATT-FR-090` pair with **`MP-GBR-18` idempotency**, and events are
idempotent **by event identifier** with `ATT-FR-141` requiring a **stable** one.
`ATT-PO-011` … `ATT-PO-013` require that a replayed punch is **absorbed rather
than applied twice**, that **every §6.2 invariant survives replay**, and that a
replayed punch **MUST NOT overwrite a correction** made while the device was
offline.

**This is a uniqueness constraint, not application-layer politeness.**

### 3.9 Tenant isolation

`ATT-BR-017` requires tenant isolation, and tenant context is **ambient** via
`ATT-PO-004` (`E-18`, `SK`) — *"never a domain method parameter"*. Every stored
attendance fact is tenant-scoped, and no query may be able to omit the scope.

### 3.10 Multi-device does not mean multi-session

§10A.2: two verified devices produce **ONE** `VERIFIED PRESENCE`. Device
observations may be many; **the session is one**. Do not let a per-device row
become a per-device session.

## 4. What is NOT decided — do not decide it in a migration

| Undecided | Owner / record |
|---|---|
| **Retention period for attendance and observation data** | **`ATT-GAP-005` OPEN.** *"the module MUST NOT define its own"* |
| **The booked-shift read path** — needed by the tolerance and the conformance badge | **`ATT-GAP-002a` OPEN** · `ADR-0029` (**`Proposed`**) |
| **Network identity** — no identifier, certificate or fingerprint may be specified | `ATT-XC-015` · **`ATT-GAP-007`** *narrowed by permission, not closed* |
| **Verified session duration semantics** | §10A.6 — the **ARB question remains open** |
| **The 25th configurable** for the 30-minute tolerance | Not created: the gate requires a **default and a range**, and **no range has been approved**. `ADR-0031` is `Proposed` |
| **Any latency / throughput target** | **`ATT-GAP-017a` OPEN**, `ATT-NFR-003` |
| **Whether a relational database is used at all** | Architecture Owner |

> A migration is a decision made in code. **Do not use one to close an open gap.**

## 5. Configuration storage

24 configurables, `ATT-CFG-001` … `ATT-CFG-024`, each with authority, default and
range (§16). They are read through **typed accessors** via `ATT-PO-005` —
*"no raw string lookups"* — and `BC-25` Configuration owns them.

Every configuration change is **audited** (`ATT-FR-038`) and **tenant-isolated**
(`ATT-BR-017`). Authority is `owner` for every row **except `ATT-CFG-008`**
(approved Wi-Fi networks), which is **`owner` + `manager`** by decision `D-12`.

**The 30-minute tolerance is not one of the 24.** Implement the behaviour; do not
add a 25th row, and do not invent a range to justify one.

## 6. If you are asked to design the schema

1. Model the **`AttendanceDay` aggregate** and the **12 invariants** first.
2. Make **observations** durable and **session status derived**.
3. Store the **exit method** separately from the status.
4. Make every fabrication-prone column **nullable and honestly empty**.
5. Enforce **idempotency** and **tenant scope** in the storage layer.
6. Leave every §4 item **undecided**, and say so in the migration's comments.
7. Get an **ADR** before anything crosses a context boundary.
