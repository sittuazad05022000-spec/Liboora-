<!--
  PRD-021C — MEMORY / CONTINUATION RECORD

  PURPOSE
  -------
  A durable repository record of the complete current state of PRD-021C
  C0-C4, so that a future session can reconstruct the project state from
  GitHub WITHOUT relying on chat history.

  WHAT THIS FILE IS
  -----------------
  A documentation / memory artefact. NOTHING ELSE.

  WHAT THIS FILE IS NOT
  ---------------------
    - NOT a PRD. NOT an authority. NOT a specification.
    - It confers NO lifecycle stage and changes NO lifecycle state.
    - It creates NO requirement, identifier, context, edge or event.
    - It does NOT freeze, approve, baseline or rank anything.
    - It does NOT resolve any OPEN decision.
    - Where this record and a real authority disagree, THE AUTHORITY WINS
      and this record is stale and must be corrected.

  Every fact below was measured from the repository. Nothing is inferred.
-->

# PRD-021C — Memory & Continuation Record

### v1.0 — 2026-09-02

> ⚠ **This is a memory artefact, not a PRD.** It records state. It grants no
> authority, confers no lifecycle stage and decides nothing.
> ⚠ **`PRD-021C` C1–C4 remain `DRAFT` / Stage 2.** Creating this record did not
> change that, and must not be read as having changed it.

---

## §1. Lifecycle state — read this first

```
PRD-021C C1–C4 = DRAFT / STAGE 2
NOT FROZEN
NOT APPROVED
NOT BASELINED
Rank: none
Stage 3 NOT entered
owns no bounded context
0 ACs proven by tests
0 lines of application code
```

Additionally measured: **0** ADRs created · **0** bounded contexts created ·
**0** integration edges created · **0** published events created · **0**
aggregates created · **0** metric definitions created · **0** analytics systems
created · **0** new public fields created · **0** `IMPL-*` identifiers minted ·
**0** Rank 1–6 documents modified · **0** FROZEN PRDs modified.

---

## §2. Title and purpose

| Field | Value |
|---|---|
| **PRD** | `PRD-021C` |
| **Working title** | Library Marketplace — Local Library Discovery, Public Profile & Seat Availability |
| **Parts** | `C0` cross-part architecture · `C1` Marketplace Foundation · `C2` Library Search & Local Discovery · `C3` Library Public Profile · `C4` Seat Availability & Booking Initiation |
| **Structural classification** | ⛔ **NOT a bounded context.** Part of the **`AR-1`** read composition registered as **`MASTER_PRD.md` §8 module 19**, Rank 1, Release **V1** |
| **Owns** | ⛔ **No entity, no field, no aggregate, no invariant, no event.** Composition rules and presentation semantics only |
| **Consumes** | `BC-19` Tenancy · `BC-25` Configuration · `BC-29` File & Media *(⚠ conditional)* · `BC-06` Library Policy · `BC-02` Membership · `BC-04` Seating · `BC-23` Search Indexing *(⚠ conditional)* · `BC-26` Analytics Read Model *(⚠ conditional, read-only)* |

**Purpose.** `PRD-021C` specifies the public, student-facing surface by which a
prospective student finds a library, reads its public profile, sees aggregate
seat availability, and is handed off to the owning context to act. It is a
**read composition** over existing domain read models. It **duplicates nothing**
from Library Management and **masters no data**.

**The governing authority** is `ARCHITECTURE_RULINGS.md` **`AR-1`**:

> *"Library Discovery & Enrollment is **NOT a new bounded context**… an
> **application / read composition capability of the Library domain**… owns
> **no aggregate**, **no invariant**, **no business state**… only orchestrates
> **public read models**… Discovery references, never duplicates."*

and `MASTER_PRD.md` **L171**, which registers module 19 at **Rank 1**,
**V1**, as *"Composition over `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`,
`BC-04`, **projected via `BC-23`**"* and explicitly *"not a context"*.

---

## §3. Part-by-part current status

| Part | File | Version | Status | Stage |
|---|---|---|---|---|
| **C0** | `PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md` | **v0.2** | `DRAFT` | **2** |
| **C1** | `PRD-021C_C1_MARKETPLACE_FOUNDATION_DRAFT_v0.1.md` | **v0.1** | `DRAFT` | **2** |
| **C2** | `PRD-021C_C2_LIBRARY_SEARCH_AND_LOCAL_DISCOVERY_DRAFT_v0.1.md` | **v0.1** | `DRAFT` | **2** |
| **C3** | `PRD-021C_C3_LIBRARY_PUBLIC_PROFILE_DRAFT_v0.1.md` | **v0.2** | `DRAFT` | **2** |
| **C4** | `PRD-021C_C4_LIVE_SEAT_AVAILABILITY_AND_BOOKING_DRAFT_v0.1.md` | **v0.1** | `DRAFT` | **2** |
| — | `PRD-021C_C1_C2_C3_C4_CROSS_PART_AUDIT.md` | **v1.0** | audit record | — |
| — | `PRD-021C_MEMORY_AND_CONTINUATION_RECORD.md` *(this file)* | **v1.0** | memory artefact | — |

⚠ **The C0 and C3 filenames still say `v0.1` while their contents are `v0.2`.**
This is deliberate: renaming a file breaks inbound links. The **header table and
change history inside each file are authoritative** for version.

**Stage 1 is recorded `NOT APPLICABLE`, not passed.** Stage 1's gate requires
*"a context identified in the Bounded Context Map, not already owned"*.
`PRD-021C` identifies **no** context, by design, under `AR-1`. The gate cannot
be met and does not apply. ⭐ Precedent: `PRD-012a` carries Stage 1
`NOT APPLICABLE` by `ADR-0060`, recorded as *"a gate that does not apply rather
than a gate skipped"* — and no `BC-32` was created to make its row look like the
others.

**Stage 2's gate** — *"a document with a version/status header, and its
identifier registers declared up front with ranges"* — is met by every part.

---

## §4. Identifier registers — FR / AC / XC totals

### §4.1 Current totals (at commit `28ca93d`)

| Register | Range | Count | Contiguous |
|---|---|---|---|
| `XPC-CONF-*` | `XPC-CONF-001` … `XPC-CONF-015` | 15 | Yes |
| `XPC-OD-*` | `XPC-OD-001` … `XPC-OD-007` | 7 | Yes |
| `LMP-FR-*` (C1) | `LMP-FR-001` … `LMP-FR-024` | 24 | Yes |
| `LMP-AC-*` (C1) | `LMP-AC-001` … `LMP-AC-012` | 12 | Yes |
| `LMP-XC-*` (C1) | `LMP-XC-001` … `LMP-XC-010` | 10 | Yes |
| `LSD-FR-*` (C2) | `LSD-FR-001` … `LSD-FR-032` | 32 | Yes |
| `LSD-AC-*` (C2) | `LSD-AC-001` … `LSD-AC-016` | 16 | Yes |
| `LSD-XC-*` (C2) | `LSD-XC-001` … `LSD-XC-012` | 12 | Yes |
| `LPP-FR-*` (C3) | `LPP-FR-001` … `LPP-FR-044` | 44 | Yes |
| `LPP-AC-*` (C3) | `LPP-AC-001` … `LPP-AC-022` | 22 | Yes |
| `LPP-XC-*` (C3) | `LPP-XC-001` … `LPP-XC-017` | 17 | Yes |
| `LSB-FR-*` (C4) | `LSB-FR-001` … `LSB-FR-036` | 36 | Yes |
| `LSB-AC-*` (C4) | `LSB-AC-001` … `LSB-AC-018` | 18 | Yes |
| `LSB-XC-*` (C4) | `LSB-XC-001` … `LSB-XC-014` | 14 | Yes |

| Totals | FR | AC | XC | Cross-part | **Total** |
|---|---|---|---|---|---|
| **Current** (`28ca93d`) | **136** | **68** | **53** | **22** | **279** |
| **C1–C4 baseline** (`21704ba`) | 120 | 60 | 46 | 20 | **246** |

### §4.2 ⭐ The 246 identifier total — what it refers to

**246** is the **exact and correct** total for the **C1–C4 Stage-2 authoring
baseline at commit `21704ba8c71f76f8689ddd0fc1680f78fe768359`**:

> **120 FR · 60 AC · 46 XC · 20 cross-part records = 246 identifiers.**

It is recorded as 246 in `PRD_REGISTRY.md` **§15.1** and in C0 **§1.1** as
authored. It is **not wrong** — it is the figure for that commit.

The current total is **279**, because commit **`28ca93d`** added the C3 Owner
Profile Engagement Summary (§9 below): **+16 FR**, **+8 AC**, **+7 XC**, plus
`XPC-CONF-015` and `XPC-OD-007` = **+33**.

> **Both numbers are true of different commits, and neither is a defect.** A
> future session that finds "246" in `PRD_REGISTRY.md` §15.1 and "279" in C0
> §1.1 is not looking at an inconsistency — it is looking at a register that was
> appended at `21704ba` and a draft that grew at `28ca93d`. C0 §1.1 discloses
> the change explicitly rather than silently restating it. `PRD_REGISTRY.md`
> §15.1 was **deliberately not edited**, because that register is cited by line
> number in **366+** places and is **append-only**.

---

## §5. The 6 OPEN decisions and their owners

⛔ **None is decided.** Each carries a named **owner role**, never a personal
name (`PRD_OWNERSHIP_MODEL.md` §7 rule 4). `XPC-OD-007` is a **7th**, added at
`28ca93d`; the enumerated set of **6** is `XPC-OD-001`…`006` and is reproduced
first, unchanged.

| # | Decision required | Owner | Blocks |
|---|---|---|---|
| `XPC-OD-001` | Does `E-21`'s consumer enumeration admit **`BC-19`**, so the `TenantOrganisation` record can be projected into `BC-23` for public discovery? | **Architecture Owner** | C2 index-fed requirements `LSD-FR-001`…`008` |
| `XPC-OD-002` | **`PRD-015` Search Indexing does not exist.** Who specifies the `BC-23` query contract C2 consumes? | **Product Owner** + **Architecture Owner** | C2 cannot be Stage-3 complete while its provider is unspecified |
| `XPC-OD-003` | Does `E-22`'s consumer enumeration admit **`BC-19`** and/or **`BC-25`**, so public gallery/branding media can be served as a `FileRef`? | **Architecture Owner** | C3 gallery requirements `LPP-FR-014`…`017` |
| `XPC-OD-004` | Should `BC-04` Seating become an `E-24` consumer, enabling an offline booking queue? | **Architecture Owner** | Nothing in V1 — C4 excludes offline booking |
| `XPC-OD-005` | The privacy review `LIB-24.2` requires before Public Live Occupancy may be designed | **Privacy Owner** *(role constituted by `ADR-0077`; ⚠ **holder VACANT**)* | Nothing in V1 — V1 excludes the feature |
| `XPC-OD-006` | The Enterprise Architecture tree has no V1 library-directory node although `MASTER_PRD.md` **L171** registers module 19 at V1 | **Architecture Owner** | Nothing — precedence resolves it |

**⭐ 7th open decision, added at `28ca93d`:**

| # | Decision required | Owner | Blocks |
|---|---|---|---|
| `XPC-OD-007` | **Which context lawfully produces the profile-view fact, over which declared edge — and does `PRD-009` certify `ProfileViews` and `UniqueViewers` as `CertifiedMetric`s of `BC-26`?** | **Architecture Owner** *(producer + edge)* + **Product Owner** *(`PRD-009` metrics)* | C3 §9A — `LPP-FR-030`…`044` (**15 FR**) and `LPP-AC-015`…`022` (**8 AC**) |

`XPC-OD-007` measured basis: the V1 event surface (BC Map §9) contains **no view
event for any aggregate**; the only edge into `BC-26` is **`E-26`**
(`BC-27 AI → BC-26 Analytics, BC-23 Search`, BC Map **L335**), which is an AI
retrieval port and **not** a telemetry ingress; and **`PRD-009` is `PLANNED` and
absent from disk**. ⚠ Note the neighbouring precedent `SM-7.17`:
*"`StudentViewed` is deliberately absent — viewing is an **audit** concern, not
a domain event"* — so the producer question may resolve toward `BC-24` Audit
Trail rather than a new emitter.

---

## §6. Repository conflicts and their dispositions

**15 conflicts recorded in C0 §5. 9 resolved · 1 partially resolved · 5
deferred to OPEN decisions. 0 resolved by inventing anything.**

| # | Conflict | Disposition |
|---|---|---|
| `XPC-CONF-001` | Supplied C1 asks for marketplace at **V1**; `BC-17` Marketplace is **V3** | ✅ **RESOLVED — determined, not decided.** `BC-17` stays V3, untouched. See §7 |
| `XPC-CONF-002` | Stage 1 says a presentation composition gets *"No PRD"*, yet requirements were required | ✅ **RESOLVED.** `MASTER_PRD.md` **L180** already directs *"Requirements are specified in `docs/30-product/library/`"*; §14A/§14B are such documents. Stage 1 recorded `NOT APPLICABLE` |
| `XPC-CONF-003` | §14A (FROZEN) and §14B (Approved) **already own** discovery filters and the public profile field set | ✅ **RESOLVED.** C2/C3 **consume and cite**; add no public field, remove no restriction |
| `XPC-CONF-004` | `E-21` (BC Map **L330**) enumerates `BC-01`, `BC-10` → `BC-23`, **omitting `BC-19`** | ⛔ **DEFERRED → `XPC-OD-001`** |
| `XPC-CONF-005` | `BC-23`'s owner `PRD-015` is `PLANNED` and **has no document** | ⛔ **DEFERRED → `XPC-OD-002`** |
| `XPC-CONF-006` | Ratings/reviews implied on library profiles | ✅ **RESOLVED by exclusion.** `ARCHITECTURE_RULINGS.md` §6 — deferred **V2**, *"must not be invented"*. `LPP-XC-005`, `LSD-XC-009` |
| `XPC-CONF-007` | `E-22` (BC Map **L331**) omits **`BC-19`** and **`BC-25`** for gallery `FileRef`s | ⛔ **DEFERRED → `XPC-OD-003`** |
| `XPC-CONF-008` | Supplied C4 asks `PRD-021C` to *"define booking"*; **`PRD-007` FROZEN already defines it** | ✅ **RESOLVED — scope reduced.** See §8.1 |
| `XPC-CONF-009` | Supplied C4 title asks for **"Live Seat Availability"**; *live* is forbidden in V1 | ✅ **RESOLVED — scope reduced.** See §8.2 |
| `XPC-CONF-010` | C4 asked to resolve concurrency/idempotency | ✅ **RESOLVED — cited, not restated.** `PRD-007` §21.2/§21.3 frozen rules referenced only |
| `XPC-CONF-011` | `E-24` (BC Map **L333**) admits **`BC-03` only** → `BC-30`; `BC-04` is not a consumer | ✅ **RESOLVED by exclusion.** No offline booking queue in V1; `LSB-XC-010`. Residue → `XPC-OD-004` |
| `XPC-CONF-012` | A "local marketplace" invites social signals; `X-05` and `ID-3` forbid them | ✅ **RESOLVED by exclusion.** `LMP-XC-006`, `LSD-XC-010`, `LPP-XC-008`. `PRD-021A`/`PRD-021B` are **not** data sources |
| `XPC-CONF-013` | Public Live Occupancy needs a privacy review that does not exist; **Privacy Owner VACANT** | ⛔ **DEFERRED → `XPC-OD-005`.** V1 not blocked, because V1 excludes the feature |
| `XPC-CONF-014` | EA **L992** shows only `Student Marketplace (V3)` and no V1 library-directory node | ✅ **RESOLVED — precedence applied, EA unedited.** `MASTER_PRD.md` is Rank 1; EA is **Rank 6, descriptive**. Residue → `XPC-OD-006` |
| `XPC-CONF-015` | C3 Profile Views summary vs the **never-public** *Internal Analytics* rule, vs `LPP-FR-002`/`004`/`008`, vs a **missing event producer** | ⚠ **PARTIALLY RESOLVED.** Presentation and ownership reconciled; **production DEFERRED → `XPC-OD-007`.** See §9 and §10 |

### §6.1 Five conflicts that were deferred rather than decided

`XPC-CONF-004`, `005`, `007`, `013` and the production half of `015` were **not
resolved**. Each maps to an OPEN decision with a named owner. In particular, no
integration edge was minted to make a consumer list convenient — `ADR-0084`
records that for `E-21` the wildcard argument *"was tested there and **failed**"*,
and `ADR-0083` §4.5 (AO-9) **refused** to mint an `E-21` edge for `BC-15`.
**Both refusals were honoured; 0 edges were created.**

---

## §7. ⭐ The `BC-17` determination — and why `BC-17` remains V3 / unchanged

**`BC-17` Marketplace is byte-unchanged and remains Release V3.**

### §7.1 What `BC-17` actually is

Measured in five places:

| Source | Measured content |
|---|---|
| BC Map **L121** | `BC-17` · Marketplace · `[SUPPORTING]` · **Global Student** · **V3** · *Owns listings, orders, listing moderation* |
| BC Map **L148** | `BC-17` is one of exactly **2** V3 contexts |
| BC Map **L488** | Global band — **no `tenantId`** — keyed on **`PersonId`** |
| EA **L992** | `Student Marketplace (V3)` — *Buy & Sell Books · Stationery · Listing Moderation · Order History* |
| `MASTER_PRD.md` **L94** | `MP-SCOPE-06` wave assignment |

⭐ **`BC-17` is a student-to-student second-hand book and stationery classifieds
context.** It is a different subject that happens to share the English word
*"marketplace"* with the requested library directory.

### §7.2 Why it was not promoted, extended or occupied

Placing a library directory in `BC-17` would breach **two** structural rules
simultaneously:

- **`X-05`** (Dependency Matrix **L354**) forbids the dependency
  `LIBRARY MANAGEMENT ↔ BC-11…BC-17`.
- **`ID-3`** (BC Map **L180**) forbids the global, `PersonId`-keyed band from
  resolving *"which library a person attends"* at all.

### §7.3 What was found instead

The capability the request describes **already exists at Rank 1** —
`ARCHITECTURE_RULINGS.md` **`AR-1`** plus `MASTER_PRD.md` **L171** module 19,
already **V1**, already *"not a context"*.

⭐ **This is a DETERMINATION from Rank 1 authority, not a decision.**
Consequently: **0** ADRs were needed, **0** wave assignments changed, and the
bounded-context count remains **31**.

⭐ **Governing precedent:** `ADR-0091` §3 used the *same* `MASTER_PRD.md` L171
cell to resolve `PRD-021B`'s `XPB-CONF-001`, finding it *"exactly the shape B4
claims, already at Rank 1, already V1."*

`C1` records the refusal explicitly in **`LMP-XC-001`**: C1 does not claim,
extend or occupy `BC-17`.

---

## §8. `XPC-CONF-008` and `XPC-CONF-009` — the two C4 scope reductions

Both were recorded as conflicts and reduced in the open, **not performed
silently**.

### §8.1 `XPC-CONF-008` — C4 does **not** define booking

The supplied C4 asked `PRD-021C` to *"define booking"*. **`PRD-007`
`PRD-SEAT-MANAGEMENT.md` is FROZEN (v1.1, `BC-04` Seating `[CORE]`, Rank 3,
2,891 lines) and already defines it** at **L153**:

> **`Booking`** — *"A **student-initiated** request that produces a reservation
> or an allocation per §12."*

`PRD-007` further owns §11 `SEAT-FR-076`…`084` (with `SEAT-CFG-008` default
**disabled**) and §12 `SEAT-FR-085`…`095`, whose `SEAT-CFG-010` is a **closed
set**: `Direct` · `HoldThenConfirm` · `ApprovalRequired` *(default)*.

**Reduction:** ⛔ **C4 defines no booking.** C4 is a **presentation and
initiation surface** over `BC-04`'s existing behaviour, handing off at
`LIB-14B.27` **`PO-4` Seat Booking → `BC-04`**. Recorded in
`LSB-XC-001`…`LSB-XC-006`.

Concurrency and idempotency are **cited, never restated** — `SEAT-BR-031`,
`SEAT-FR-198` (*"Two locks, not one… a build that locks only the seat allows one
student to win two seats concurrently"*), `SEAT-FR-199`, `SEAT-FR-201`,
`SEAT-BR-032` (gate **G3**), `SEAT-FR-202` (per tenant+operation, **24h**,
*"fixed, not configurable"*), `SEAT-FR-203`, `SEAT-XC-013`.

### §8.2 `XPC-CONF-009` — **"Live"** is forbidden in V1

The supplied C4 title asked for **"Live Seat Availability"**. Multiple
authorities forbid it on the public surface in V1:

| Authority | Content |
|---|---|
| `LIB-14B.11` | Aggregates only |
| `LIB-14B.12` | Coarse indicator; **no precise count** |
| **`LIB-14B.13`** | *"Public Live Occupancy is **V2** and **MUST NOT** be implemented in V1"* |
| `LIB-14B.14` | Not attendance-derived |
| `PRD-007` `SEAT-XC-009` | Per-seat state and live occupancy **MUST NOT** be public in V1 |
| `PRD-007` `SEAT-FR-117` | **MAY** publish aggregate + coarse only |
| `ARCHITECTURE_RULINGS.md` **§6** | *"must not be invented"* |
| `LIB-7.3` | Aggregate count |

**Reduction:** the part title was reduced to **"Seat Availability & Booking
Initiation"**, with the supplied title struck through in the header. C4
publishes only the **aggregate capacity** and a **closed coarse indicator set**
— *Available · Limited · Full · Unknown*. `LSB-FR-009` **refuses** to define the
thresholds (they are `BC-04`'s). `LSB-FR-034` forbids the **word** "live" in the
public surface. Recorded in `LSB-FR-007`…`012` and `LSB-XC-007`…`009`.

⚠ **The filename retains the supplied words**
(`..._C4_LIVE_SEAT_AVAILABILITY_AND_BOOKING_...`) so that the originally
requested scope stays discoverable by search. **The filename is not a scope
claim.**

---

## §9. ⭐ C3 Owner Profile Engagement Summary / Profile Views requirement

Added in **C3 v0.2**, commit **`28ca93d021281adcfd75176a64867246ac5576a7`**,
as **C3 §9A**. It is a **presentation / readout requirement of C3**, explicitly
**not** a new analytics domain.

### §9.1 What it specifies

Library owners/admins see a small, non-intrusive engagement summary on their own
Library Public Profile: **Total Profile Views**, **Unique Viewers** *(only where
`BC-26` publishes it as a certified metric)*, a **period/trend summary** with an
explicitly stated period, and a **View Analytics CTA** that hands off to the
analytics experience. Individual viewer identities are **not** exposed.

**16 FR · 8 AC · 7 XC added, all contiguous:**

| Range | Content |
|---|---|
| `LPP-FR-029` | The mandated **10-item presentation order**, summary at position **7** |
| `LPP-FR-030`…`034` | Non-public by construction · unobservable to unauthorised callers · `PO-12` via `BC-18` · authorisation ≠ authentication · **tenant-scoped** |
| `LPP-FR-035`…`038` | Metrics **read** from `BC-26`, never counted/computed/inferred; C3 defines **no** metric semantics |
| `LPP-FR-039`…`041` | No individual viewer identity · small-value suppression · no social signal |
| `LPP-FR-042`…`044` | CTA hands off to `PRD-009` / `BC-26` · absent (not disabled) for unauthorised callers · degrade without zeros |
| `LPP-XC-011`…`017` | No analytics system/store/database · no event pipeline/beacon/pixel · no metric semantics · no event or edge minting · nothing analytic on the public surface · no viewer identification · no inline analytics |
| `LPP-AC-015`…`022` | Given/When/Then criteria — **all ⚠ conditional on `XPC-OD-007`** |

### §9.2 The mandated presentation order (`LPP-FR-029`)

| # | Group | Audience |
|---|---|---|
| 1 | Library Identity & Basic Information | Public |
| 2 | Photos / Media | Public ⚠ `XPC-OD-003` |
| 3 | Facilities & Amenities | Public |
| 4 | Location, Hours & Contact | Public |
| 5 | Pricing / Membership Information | Public |
| 6 | Availability Preview | Public — aggregate only |
| **7** | **Owner Profile Engagement Summary** | ⛔ **Owner/admin only** ⚠ `XPC-OD-007` |
| 8 | Owner/Admin Profile Controls | ⛔ Owner/admin only |
| 9 | Privacy & Visibility | ⛔ Owner/admin only |
| 10 | Profile Actions | Mixed — per `PO-*` |

### §9.3 ⚠ Why this is lawful — the three-way reconciliation

*Internal Analytics* is on the **never-public** list at §14A.5 **L180** and
repeated by **`LIB-14B.22`** **L177** (*"Internal analytics, dashboards,
occupancy trends"*). Three already-authored C3 requirements also appeared to
forbid it. All were reconciled **without amending any of them**:

| Requirement | Tension | Reconciliation |
|---|---|---|
| `LPP-FR-002` — field set **MUST** be exactly the §14A.5 public list | Is this a new profile field? | **No.** It is an **owner-only overlay outside the public projection** (`LPP-FR-030`). §14A.5's field set is untouched |
| `LPP-FR-004` — profile **MUST** be readable without authentication | Does it gate the profile? | **No.** The anonymous response is unchanged and indistinguishable (`LPP-FR-031`). The overlay is additive **after** a `BC-18` decision |
| `LPP-FR-008` — order **MUST NOT** vary by viewer | Position 7 is owner-only | **Order is invariant within each audience class.** Position 7 is a **reserved slot** — absent for all public viewers, occupied only for authorised owners. Its occupancy cannot vary by commercial arrangement |

---

## §10. ⭐ Analytics ownership boundary

**Analytics ownership was reconciled to the owner that already exists in the
repository. Nothing was invented.**

| Concern | Authoritative owner | Measured source |
|---|---|---|
| Metric **definition** — what "a profile view" counts as | **`BC-26` Analytics Read Model** | BC Map **L135**, **L385** (Rank 4) |
| Metric **store**, projection, report, export | **`BC-26`** | BC Map **L135** |
| The analytics **product surface** / detailed analytics | **`PRD-009` Analytics & Reports** | `PRD_REGISTRY.md` **L246** |
| Profile-view **event production** | ⚠ **UNDETERMINED** → `XPC-OD-007` | no producer exists |
| **Rendering** an already-certified metric | **C3** (`LPP-FR-035`…`044`) | C3 §9A only |

Verbatim measured facts:

- BC Map **L135** — `BC-26` · **Analytics Read Model** · `[GENERIC]` · Analytics
  · **V1** · *"Owns the metric/semantic layer, read-model store, projections,
  reports, exports."*
- BC Map **L385** — `BC-26` owns `CertifiedMetric`, `ReadModel`; *"Fully
  rebuildable from the event log; no projection is a system of record;
  **metric definitions single-sourced from the semantic layer**"*
- `PRD_REGISTRY.md` **L246** — `PRD-009` · Analytics & Reports · **`BC-26`
  Analytics Read Model** · `[GENERIC]` · **V1** · **`PLANNED`** · *Dashboards
  (modules 10–12)*

### §10.1 Two measured gaps — neither closed

1. **`PRD-009` does not exist on disk.** It is `PLANNED` at `PRD_REGISTRY.md`
   **L246**. `find docs/ -iname "*009*"` returns no `PRD-009` document. The
   *owner* is named at Rank 4; the *specification* defining `ProfileViews` and
   `UniqueViewers` as `CertifiedMetric`s has not been authored. Structurally
   identical to `XPC-OD-002` (`PRD-015`, `BC-23`'s absent owner) and recorded
   the same way.

2. **No profile-view event exists, and C3 cannot produce one.** The V1 event
   surface (BC Map §9) contains **no view event for any aggregate**. The naming
   convention `<Context>.<Aggregate><PastTenseVerb>` is **binding**, and every
   catalogued producer owns an aggregate. C3 owns none (`LPP-XC-001`) and is
   forbidden from emitting any event (`LPP-XC-003`). The only edge into `BC-26`
   is **`E-26`** (BC Map **L335**), an AI retrieval port — not a telemetry
   ingress.

⚠ Both are held in **`XPC-OD-007`**. **No event was minted. No edge was minted.**

> **The repository has already reasoned about view events once, and reached the
> opposite conclusion to a naive tracking design.** `SM-7.17` records that
> *"`StudentViewed` is deliberately absent — viewing is an **audit** concern
> (§8.3), not a domain event."* That precedent does not resolve `XPC-OD-007`,
> but it means the producer question has an existing answer for a neighbouring
> case and should be decided by the Architecture Owner, not assumed.

---

## §11. C4 booking ownership boundary through FROZEN `PRD-007`

**`BC-04` Seating, specified by the FROZEN `PRD-007`, owns booking absolutely.
C4 owns the surface and nothing else.**

| Concern | Owner |
|---|---|
| `Booking`, `Reservation`, `SeatAllocation`, `SeatState` definitions | **`PRD-007` / `BC-04`** — FROZEN |
| Booking modes (`Direct` · `HoldThenConfirm` · `ApprovalRequired`) | **`PRD-007`** §12 `SEAT-CFG-010` — **closed set** |
| Whether booking is enabled at all | **`PRD-007`** `SEAT-CFG-008` — default **disabled** |
| Concurrency — the **two-lock** rule (`SEAT-INV-001` seat + `SEAT-INV-002` allocation set) | **`PRD-007`** §21.2 |
| Idempotency key, 24h retention, gate **G3** | **`PRD-007`** §21.3 |
| Coarse-indicator thresholds | **`BC-04`** — `LSB-FR-009` **refuses** to define them |
| Presenting aggregate availability; initiating the handoff | **C4** |
| The `PO-4` handoff and intent preservation across authentication | **C4** + `LIB-14B.33`…`.39` |

C4 exposes **no** per-seat identity, **no** per-seat state, **no** live
occupancy and **no** precise free-seat count on the public surface.
`LSB-XC-001`…`LSB-XC-014` record the boundary. **`PRD-007` is byte-unchanged.**

---

## §12. Stage-2 validation results

Measured at commit **`28ca93d`**:

| Check | Result |
|---|---|
| Identifier contiguity — all 14 registers | ✅ **279 identifiers, 0 gaps** |
| C3 acceptance criteria carry full Given/When/Then | ✅ **22 / 22** |
| All C-part acceptance criteria carry full GWT | ✅ **68 / 68**, 0 orphans |
| Markdown table integrity across all C-part files | ✅ **0 malformed rows** |
| Citation resolution (C1–C4 authoring pass) | ✅ **37 / 37 resolve** |
| Prefix collision check before authoring | ✅ `XPC-`, `LMP-`, `LSD-`, `LPP-`, `LSB-` = **0 each**. ⛔ `LMD-` measured at **350** → **REJECTED and recorded as rejected** |
| Forbidden-path changes (`lib/`, `test/`, `tool/`, `web/`, `android/`, `.github/`) | ✅ **0** |
| Rank 1–6 and FROZEN artefacts modified | ✅ **0 bytes** |
| `BC-17` cell modified | ✅ **0 bytes** — still **V3** |
| C1, C2, C4 modified by the C3 change | ✅ **0 bytes** |
| ADRs / contexts / edges / events / metric definitions / `IMPL-*` created | ✅ **0 / 0 / 0 / 0 / 0 / 0** |
| Documentation checks | ⚠ **31 total: PASS = 25, FAIL = 6** — all 6 **pre-existing**, see §13 |

⚠ **`0` of the 68 acceptance criteria is proven by an executed test.** They are
authored specifications of verifiable behaviour, at Stage 2. This is stated in
each part's own §11 and is not a defect at this stage — it is what Stage 2 means.

---

## §13. Pre-existing documentation-check failures

The sweep is `for f in tool/docs_check/*.py; do python3 "$f"; done`.

```
TOTAL=31 PASS=25 FAIL=6
FAILING: alignment_record_freshness.py
         prd004_traceability.py
         prd005_traceability.py
         prd006_traceability.py
         prd007_traceability.py
         prd020_stage5.py
```

**All 6 are PRE-EXISTING and were NOT introduced by `PRD-021C`.** This was
**proven, not asserted**: the C-part changes were stashed with
`git stash push -u`, the sweep re-run, and the result was **identical — 25 pass
/ 6 fail** — then restored with `git stash pop`. **0 failures introduced.**

`alignment_record_freshness.py` exact failure text:

> `PRD-019_ARCHITECTURE_ALIGNMENT.md: no 64-hex hash found in the record chain — the freshness anchor is missing, so this check cannot run (it must not pass silently)`

⚠ Two **pre-existing** markdown table-cell mismatches also exist in
`PRD_REGISTRY.md` at **L662** and **L769**. They are far above the `PRD-021C`
append at **L1330** and are **not** attributable to this work.

---

## §14. Frozen / unchanged artefact guarantees

**Every artefact below is byte-unchanged by all `PRD-021C` work.**

| Artefact | Rank / status |
|---|---|
| `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | Rank 4 — **incl. the `BC-17` cell at L121** |
| `docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | Rank 4 — incl. `X-05` at L354 |
| `docs/10-architecture/ARCHITECTURE_RULINGS.md` | Rank 5 — `AR-1`, `AR-3`, `AR-7`, §6 |
| `docs/10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` | Rank 6, descriptive — incl. L992 |
| `docs/30-product/MASTER_PRD.md` | Rank 1 — incl. L171 module 19 |
| `docs/00-governance/prd-ecosystem/PRD_LIFECYCLE.md` | governance — hash `5031fcc97a95980e` |
| `docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md` | governance — hash `8fe1e208f89702ba` |
| `docs/30-product/library/14A-Library-Discovery-And-Enrollment.md` | **FROZEN 2026-08-03** |
| `docs/30-product/library/14B-Public-Library-Preview.md` | **Approved / authoritative** |
| `docs/30-product/library/Library_PRD_v1.md` | **FROZEN** |
| `docs/30-product/seat-management/PRD-SEAT-MANAGEMENT.md` (`PRD-007`) | **FROZEN** v1.1 |
| `docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md` (`PRD-005`) | **FROZEN** |
| `docs/30-product/file-media/PRD-017_FILE_AND_MEDIA.md` | **FROZEN** |
| `docs/30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md` | **FROZEN** |
| `docs/30-product/social-graph/` (`PRD-021B` B0–B9) | **FROZEN / BASELINED at Rank 3**, `BASELINE-2026-09-02-A` |
| `docs/00-governance/adr/` — all ADRs | **0 created, 0 modified** |
| `docs/00-governance/DOCUMENTATION_BASELINE.md` | unchanged |

**`PRD_REGISTRY.md` is the single governance file `PRD-021C` touched, and only
by APPEND.** §15 was appended at **L1330** (+128 lines); **0 existing lines were
modified**. ⚠ **That register is cited by line number in 366+ places — it is
APPEND-ONLY. Never insert.**

**Artefacts absent from the repository (confirmed by measurement):** `PRD-009`
(`BC-26`'s owner) · `PRD-015` (`BC-23`'s owner) · `ADR-0066`, `ADR-0074`,
`ADR-0088`, `ADR-0089`, `ADR-0090` · `tool/docs_check/prd021b_task_coverage.py`.

---

## §15. Git state

| Field | Value |
|---|---|
| **Repository** | `https://github.com/sittuazad05022000-spec/Liboora-.git` *(public)* |
| **Remote name** | **`github`** ⚠ there is **no `origin`** remote |
| **Other remote** | `genspark` → `https://www.genspark.ai/sb-git/me/genspark-58d4883d-c0e3-4aa0-b60d-28b6cbe2cf56.git` |
| **Branch** | `main` |
| **C1–C4 Stage-2 baseline commit** | **`21704ba8c71f76f8689ddd0fc1680f78fe768359`** |
| **C3 v0.2 engagement-summary commit** | **`28ca93d021281adcfd75176a64867246ac5576a7`** |
| **Parity at each push** | `HEAD == github/main`, ahead/behind **`0/0`** |
| **Working tree** | **clean** |
| **History** | ⛔ never amended, rebased, force-pushed or rewritten |

⭐ **`21704ba8c71f76f8689ddd0fc1680f78fe768359`** is the commit at which C1–C4
were authored and at which the **246**-identifier figure is exact. **`28ca93d`**
adds the C3 Owner Profile Engagement Summary (§9) and moves the total to **279**
(§4.2). This memory record is committed **after** `28ca93d`, so its own commit
SHA is later than both; see §18.

Commit ancestry (most recent first, from `28ca93d`):
`28ca93d` → `21704ba` → **`e49c6da` (genspark auto-backup)** → `cbad53d` →
`32d4ace` → **`766885b` (auto)** → `d5e5c1f` → `306587e` → **`8509547` (auto)** →
**`627cc59` (auto)** → **`4af7349` (auto)** → `394c30f` → `b346751` → `8f2c184` →
`60e3782` → **`1494d25` (auto)** → `3f40525` → `bd0decd` → **`e825881` (auto)** →
`1db32af` → `6ddbff9` → **`0f1bb22` (auto)** → `510a90b` → **`e398af1` (auto)** →
`8244a00` → **`21dfb1c` (auto)** → `3099569`.

### §15.1 ⚠ Genspark auto-backup disclosure

The sandbox environment performs an **automatic end-of-turn `git` backup** to the
`genspark` remote, and this has produced **commits authored by the environment
rather than by the assistant**, with the message **`genspark auto-backup`**.

**This has fired 12 times to date.** Identified commits:
`0f1bb22`, `309e1fa`, `21dfb1c`, `e398af1`, `e825881`, `1494d25`, `4af7349`,
`627cc59`, `8509547`, one further commit, `766885b`, and **`e49c6da`**.

⚠ **`e49c6da` is materially relevant to `PRD-021C`.** It is titled
`genspark auto-backup` and it **committed the then-untracked C0, C1 and C2 draft
files** (1,182 insertions) before the assistant had staged them. The C0/C1/C2
content therefore first entered history under an auto-backup commit, and was
subsequently carried forward normally by `21704ba`.

**Disposition — consistently applied and not to be changed:** these commits are
**left in history, disclosed, and never amended**. Rewriting them would violate
the standing instruction against amending, rebasing or force-pushing, and would
alter SHAs that other records already cite.

---

## §16. ⛔ DO NOT DO

1. ⛔ **Do not enter Stage 3 automatically.** Stage 3 requires *a written
   alignment record naming every conflict and its disposition*. **No such record
   exists for `PRD-021C`, and none is claimed.** C0 §7 is a *preparatory
   self-assessment*, explicitly **not** a Stage 3 gate result.
2. ⛔ **Do not freeze or baseline.** `PRD-021C` is **not** frozen, **not**
   approved, **not** baselined, and holds **no** rank.
3. ⛔ **Do not create `IMPL-*` identifiers.** **0** exist and none is authorised.
4. ⛔ **Do not create application code.** **0** lines under `lib/`, `test/`,
   `tool/`, `web/`, `android/` or `.github/`. `PRD-021C` is documentation.
5. ⛔ **Do not modify `BC-17`.** It is a student-to-student classifieds context
   at **V3** and is **byte-unchanged**. See §7. Promoting, extending or
   occupying it would breach **`X-05`** and **`ID-3`** simultaneously.
6. ⛔ **Do not modify frozen PRDs or ADRs.** See §14 for the full guaranteed-
   unchanged list. `PRD_REGISTRY.md` is **APPEND-ONLY** (cited by line number
   366+ times).
7. ⛔ **Do not resolve OPEN decisions without authorised evidence or an owner
   decision.** All **7** (§5) carry named owner roles. In particular: do **not**
   mint an `E-21` or `E-22` consumer entry, and do **not** mint a profile-view
   event or an edge into `BC-26`. `ADR-0084` and `ADR-0083` §4.5 both **refused**
   exactly such convenience minting.
8. ⛔ **Do not treat this memory record as a new PRD authority.** It is a
   documentation/memory artefact. It creates no requirement and grants no
   authority. Where it disagrees with a real authority, **the authority wins**
   and this record is stale.

---

## §17. How to resume from GitHub without chat history

1. `git clone https://github.com/sittuazad05022000-spec/Liboora-.git`, check out
   `main`, confirm `HEAD == github/main` and ahead/behind `0/0`.
2. Read **this file**, then **C0** (§5 conflicts, §6 open decisions), then
   C1 → C2 → C3 → C4, then the cross-part audit.
3. Read `PRD_REGISTRY.md` **§15** — the `PRD-021C` registration.
4. Re-measure before trusting anything: the identifier-contiguity, GWT,
   table-integrity and doc-check procedures are described in §12 and §13.
   ⚠ **Re-run the doc-check sweep and expect 25 pass / 6 fail** (§13). A
   different figure means something changed elsewhere in the repository.
5. Treat every ⚠ **CONDITIONAL** requirement as **not implementable** until its
   OPEN decision is decided by the named owner.
6. Read **§16 DO NOT DO** before making any change.

⚠ **Re-measure rather than trusting this file.** It was accurate at commit
`28ca93d`. The repository is the authority; this record is a convenience.

---

## §18. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-02 | Created as a durable memory/continuation record for `PRD-021C` C0–C4, so a future session can reconstruct state from GitHub without chat history. Records the lifecycle block (§1), title/purpose (§2), per-part status (§3), the **279** current and **246** baseline identifier totals (§4), all **7** open decisions with owners (§5), all **15** conflicts with dispositions (§6), the **`BC-17` V3 determination** (§7), the **`XPC-CONF-008`/`009`** scope reductions (§8), the **C3 Owner Profile Engagement Summary** (§9), the **analytics ownership boundary** (§10), the **C4 booking boundary through FROZEN `PRD-007`** (§11), Stage-2 validation (§12), the **6 pre-existing** doc-check failures (§13), frozen-artefact guarantees (§14), git state with the **`genspark` auto-backup disclosure** (§15), the **8-item DO NOT DO** section (§16) and a resume procedure (§17). ⛔ Documentation artefact only — **no** lifecycle change, **no** authority, **no** new identifier, **no** OPEN decision resolved. `PRD-021C` C1–C4 remain **`DRAFT` / Stage 2** |
