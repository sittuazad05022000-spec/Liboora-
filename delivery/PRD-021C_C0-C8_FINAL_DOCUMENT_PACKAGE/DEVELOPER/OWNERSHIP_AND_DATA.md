# OWNERSHIP AND DATA — `PRD-021C` C0–C8

**Derived document.** ⛔ No authority. Authority: [`../PRD/`](../PRD/) (**FROZEN**) ·
**`Accepted`** ADRs in [`../ADR/`](../ADR/) · [`../ARCHITECTURE/`](../ARCHITECTURE/).

Covers required topics: **data/entity ownership**, **BC ownership**, **tenant isolation**.

---

## 1. ⭐⭐ There is no schema, and that is the specification

**`LMT-FR-006`** — C1–C7 require **0** new tables, **0** columns, **0** migrations
and **0** constraints. C8 **§6.1** is titled *"No schema"*. C8 **§5.1** is titled
*"Proposed entities: none"*.

**This document therefore contains no DDL and no table definitions, because the
frozen specification defines none.** Writing a schema here would invent the very
thing `PRD-021C` refuses to create. What follows instead is the **ownership
record** — which is what the specification *does* define, and what actually
governs your implementation.

---

## 2. The entity and field ownership matrix

Reproduced from C0 **§3.1**, whose own heading is
*"Entity and field ownership — C1…C4 own none of it"*. C8 **§5.2** carries the
seven-column form of the same record.

| Presented item | Owning context | Owning PRD | Status of owner | Part(s) |
|---|---|---|---|---|
| Library name · business address · map location · library status · business contact | `BC-19` Tenancy | `PRD-013` | **FROZEN** | C2, C3 |
| Logo · cover image · description (branding values) | `BC-25` Configuration | `PRD-023` | **FROZEN** | C3 |
| Gallery media (`FileRef` only) | `BC-29` File & Media | `PRD-017` | **FROZEN** | C3 |
| Operating hours · weekly holidays · emergency closure | `BC-06` Library Policy | `PRD-002` | **FROZEN** (§14A/§14B) | C3 |
| Membership plans · pricing | `BC-02` Membership | `PRD-005` | **FROZEN** | C3, C4 |
| Seat capacity (aggregate) · coarse availability indicator | `BC-04` Seating | `PRD-007` | **FROZEN** | C3, C4 |
| `SeatAllocation` · `Reservation` · `Booking` · `SeatState` · `Lock` | `BC-04` Seating | `PRD-007` | **FROZEN** | C4 |
| Visibility mode (Public / Private) | `BC-19` + §14A `LIB-DISC-001` | `PRD-002`/`PRD-013` | **FROZEN** | C1, C2, C3 |
| Discovery projection · query · relevance | `BC-23` Search Indexing | `PRD-015` — ⚠ **does not exist** | `PLANNED` | C2 |
| Membership request / join | `BC-02` Membership (`LIB-DISC-009`) | `PRD-005` | **FROZEN** | C1, C4 |
| Student record | `BC-01` Enrollment (`LIB-DISC-010`) | `PRD-004` | **FROZEN** | C4 |
| Authentication · registration · session | `BC-18` Identity & Access (`LIB-DISC-008`, `AR-2`) | `PRD-001` | **FROZEN** | C1, C4 |
| Authorisation decision | `BC-18` only (`X-13`) | `PRD-001` | **FROZEN** | all |
| Entitlement / quota answer | `BC-21` Entitlement | `PRD-014` | **FROZEN** | C4 |
| Audit record | `BC-24` Audit Trail | `PRD-016` | **FROZEN** | all |
| Notification delivery | `BC-22` Notification Delivery | — | `PLANNED` | C4 |

⭐ **Read the last four columns together.** Twelve of the sixteen rows are owned by
a **FROZEN** PRD. Changing how any of those values behaves is not a marketplace
decision at all — it requires an ADR against the owning PRD.

`XPC-CONF-001`…`XPC-CONF-014` (C0 **§5**) record every conflict this matrix
surfaced, each with an owner and a smallest-compatible resolution.

---

## 3. What this means when you write code

| Temptation | Why it is forbidden | Rule |
|---|---|---|
| Cache a library's name in a marketplace table | Creates a second copy with its own staleness and no owner | C0 §3.2 — ⛔ no business state |
| Store a computed availability number | `BC-04` owns availability; a stored derivative is new state | C0 §3.1 row 6 |
| Persist a `FileRef`'s bytes | `BC-29` owns media; only the reference travels | C0 §3.1 row 3 |
| Add a `is_featured` column to support ordering | A new column, and an ordering input C6 does not own | `LMT-FR-006`; C6 §4.4, §4.5 |
| Keep a local copy of the search index | `BC-23` owns the index; `LMT-XC-006` forbids a new one | `LMT-XC-006` |
| Add a read-through cache in front of a projection | *"a **second** derived copy with its own staleness, and no owner"* | `LMT-XC-017` |

⭐ **`LMT-XC-017` is worth reading in full**, because it refuses something most
teams would consider an obvious optimisation:

> ⛔ No cache tier, cache invalidation protocol or read replica. ⭐ The public
> discovery index is **already** the read-optimised representation (`AR-3`).

---

## 4. ⭐⭐ Tenant isolation — the two index classes

This is the highest-severity area in the whole specification. C8 **§6.2**
delegates to ruling `AR-3` (`ARCHITECTURE_RULINGS.md` **L95–L125**) and splits
every marketplace read into **exactly two classes**:

| Surface | Index class | Tenant key | Caller |
|---|---|---|---|
| C2 search · C6 presented list · C3 public profile | **Platform Public Discovery Index** — indexed unit `TenantOrganisation`, contents limited to §14A.5 public metadata | ⛔ **None** | Anonymous |
| C4 seat availability · C3 owner-only readout · C7 protected ops | **Tenant Operational Data** | ✅ **Mandatory** (`MP-GBR-08`, `SE-1`, `X-13`) | Authenticated, tenant context required (`E-18`) |

**`LMT-FR-007`** — every marketplace read **MUST** be classified into exactly one
class **before it is implemented**, and **MUST** carry that class's tenant-key
requirement.

### 4.1 ⛔⛔ The rule whose violation is the worst failure in the architecture

**`LMT-BR-007`** — ⛔ a read **MUST NOT** mix the classes in one query.

C8 states the consequence by quoting BC Map **§11.1**: a join between an
untenanted public index and tenanted operational rows is the shape that produces

> *"the single highest-severity failure mode in the entire architecture … a
> cross-tenant data leak via a capability context."*

⚠ **The dangerous query looks helpful.** "Show the public list, and mark which
ones the current user has a booking at" is exactly the join `LMT-BR-007` forbids.
Compose the two reads separately; do not join them in the datastore.

### 4.2 What the public index may contain

**`LMT-FR-008`** — the public index **MUST** contain **only** §14A.5 public
metadata, and **MUST NOT** contain seat counts, occupancy, membership, fee,
attendance, internal analytics or moderation data.

⭐ It enforces `LSD-XC-008`'s bar — *"by value **or by inference**"*. A field that
does not state occupancy but permits it to be computed is still a violation.

### 4.3 Tenant context is ambient

**`LMT-BR-008`** — 📤 `E-18` (BC Map **L327**): tenant context is **ambient**,
*"propagated, never passed as a parameter through domain methods."*
⛔ Do **not** introduce a tenant parameter into a marketplace domain signature.

**`LMT-FR-009`** — where tenant context is required and absent, the operation
**MUST fail loudly**. ⛔ It **MUST NOT** default, fall back to a
"first"/"default"/"any" tenant, or proceed untenanted.

### 4.4 ⛔ The identifier that must never cross the boundary

**`LMT-XC-007`** — ⛔ no tenant id, `StudentRecordId` or tenant-scoped identifier
may enter `BC-10`…`BC-17` (ruling `ID-2`; `banned_symbols` **L266–L267**).

⭐ This binds C7's report path concretely: a report carries a `PersonId` and a
**public** subject reference, and ⛔ **never** a `StudentRecordId`.

---

## 5. Media

C8 **§5.3**. Gallery media travels as a **`FileRef` only**, owned by `BC-29` under
frozen `PRD-017`. ⛔ The marketplace serves no bytes from a marketplace-side copy —
see [`ERROR_AND_FAILURE_HANDLING.md`](./ERROR_AND_FAILURE_HANDLING.md) §2, where
the required behaviour when `BC-29` is unavailable is to **omit the image**.

⚠ Reaching `BC-29` depends on `E-22`, whose consumer enumeration **omits `BC-19`
and `BC-25`** — `XPC-CONF-007`, **OPEN**. This is a live blocker on the media
path, not a settled integration.

---

## 6. Verifying your own data-layer work

Three checks that follow directly from the rules above:

1. **Migration count.** Your change should add **0** tables and **0** columns
   (`LMT-FR-006`). If it adds one, you are outside the specification.
2. **Class purity.** Every query you write belongs to exactly one index class
   (`LMT-FR-007`), and no query joins across the two (`LMT-BR-007`).
3. **Loud failure.** Removing tenant context from an operational read causes a
   visible failure, not a silent default (`LMT-FR-009`).

⛔ These are checks against the *specification*. They are **not** evidence that
Stage 8 has been performed — no application code exists for `PRD-021C`.
