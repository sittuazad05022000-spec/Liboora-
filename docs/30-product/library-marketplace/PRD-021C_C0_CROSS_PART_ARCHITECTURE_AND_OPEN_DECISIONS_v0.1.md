<!--
  PROVENANCE — PRD-021C Part C0 (cross-part architecture and open decisions)

  Purpose of this file
  --------------------
  Cross-part companion to PRD-021C Parts C1, C2, C3 and C4. It carries the
  ownership matrix, the dependency-direction rules, the identifier registers,
  the acceptance-criteria coverage summary, and the OPEN DECISIONS register.

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 (Architecture Review) NOT
                  entered. No alignment record exists and none is claimed.
                  The Stage 3 checks reproduced in section 7 are a PREPARATORY
                  SELF-ASSESSMENT ONLY. They are NOT a Stage 3 gate result.

  What this file does NOT do
  --------------------------
    - It creates no bounded context. The count remains 31.
    - It creates no integration edge and no published event.
    - It amends no FROZEN PRD and no Rank 1-6 artefact.
    - It mints no IMPL-* identifier and creates no implementation task.
    - It confers no lifecycle stage.
    - It creates no ADR. Where an ADR is required, it is recorded as an OPEN
      decision with a named owner instead.
-->

# PRD-021C — PART C0

## Cross-Part Architecture, Coverage Summary & Open Decisions

### v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Stage 3 has **not** been
> entered. Section 7 is a **preparatory self-assessment**, ⛔ **not** a Stage 3
> alignment record.

| Field | Value |
|---|---|
| **PRD** | `PRD-021C` — a **lettered suffix of the existing number `PRD-021`**, exactly as `PRD-021A` and `PRD-021B` are. ⛔ **No new `PRD-nnn` number is consumed** |
| **Title** | Local Library Marketplace & Booking |
| **Parts** | **C0** (this file) · **C1** Marketplace Foundation · **C2** Library Search & Local Discovery · **C3** Library Public Profile · **C4** Live Seat Availability & Booking |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** |
| **Lifecycle stage** | **Stage 2 (Draft)** — [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §Stage 2. ⛔ Stage 3 **NOT** entered |
| **Date** | 2026-09-02 |
| **Release** | **V1**, in the reduced and repository-derived form §3 establishes — ⛔ **not** the V1 the supplied intent assumed |
| **Baseline** | Written against `BASELINE-2026-09-02-A`. ⛔ **No baseline row exists or is requested** |
| **Rank** | ⛔ **None.** A `DRAFT` holds no rank. Rank 3 is conferred by [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3/§4 and is **not claimed here** |
| **Structural classification** | ⭐ **Application / read composition capability of the Library domain**, under ruling **`AR-1`** and `MASTER_PRD.md` §8 **module 19**. ⛔ **NOT a bounded context.** Context count remains **31** |
| **Identifier prefixes** | `XPC-*` (C0) · `LMP-*` (C1) · `LSD-*` (C2) · `LPP-*` (C3) · `LSB-*` (C4) — see §2 |
| **Authorities applied** | `MASTER_PRD.md` (Rank 1) · `ADR-0091`, `ADR-0061`, `ADR-0016`, `ADR-0055`, `ADR-0020` (Rank 2) · `Library_PRD_v1.md` §14A/§14B **FROZEN**, `PRD-007` **FROZEN**, `PRD-005` **FROZEN**, `PRD-013` **FROZEN**, `PRD-017` **FROZEN**, `PRD-020` **FROZEN** (Rank 3) · BC Map, Module Dependency Matrix (Rank 4) · `ARCHITECTURE_RULINGS.md` `AR-1`…`AR-7` (Rank 5) · Enterprise Architecture (Rank 6, **descriptive**) |

---

## §1. Scope of this document

`PRD-021C` consists of five files:

| Part | File | Register stem | FRs | ACs |
|---|---|---|---|---|
| **C0** | `PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md` | `XPC-` | — | — |
| **C1** | `PRD-021C_C1_MARKETPLACE_FOUNDATION_DRAFT_v0.1.md` | `LMP-` | 24 | 12 |
| **C2** | `PRD-021C_C2_LIBRARY_SEARCH_AND_LOCAL_DISCOVERY_DRAFT_v0.1.md` | `LSD-` | 32 | 16 |
| **C3** | `PRD-021C_C3_LIBRARY_PUBLIC_PROFILE_DRAFT_v0.1.md` | `LPP-` | 28 | 14 |
| **C4** | `PRD-021C_C4_LIVE_SEAT_AVAILABILITY_AND_BOOKING_DRAFT_v0.1.md` | `LSB-` | 36 | 18 |

### §1.1 Identifier registers — declared up front, ranges published as a promise

Per `PRD_LIFECYCLE.md` Stage 2 rule 1 (*"every requirement has a unique
identifier"*), rule 2 (*prefixes checked against §5's collision procedure
**before** writing*), and rule 3 (*ranges contiguous*).

| Register | Meaning | Range | Count | Contiguous |
|---|---|---|---|---|
| `XPC-CONF-*` | Cross-part conflict record | `XPC-CONF-001` … `XPC-CONF-014` | 14 | Yes |
| `XPC-OD-*` | Open decision | `XPC-OD-001` … `XPC-OD-006` | 6 | Yes |
| `LMP-FR-*` | C1 functional requirement | `LMP-FR-001` … `LMP-FR-024` | 24 | Yes |
| `LMP-AC-*` | C1 acceptance criterion | `LMP-AC-001` … `LMP-AC-012` | 12 | Yes |
| `LMP-XC-*` | C1 exclusion | `LMP-XC-001` … `LMP-XC-010` | 10 | Yes |
| `LSD-FR-*` | C2 functional requirement | `LSD-FR-001` … `LSD-FR-032` | 32 | Yes |
| `LSD-AC-*` | C2 acceptance criterion | `LSD-AC-001` … `LSD-AC-016` | 16 | Yes |
| `LSD-XC-*` | C2 exclusion | `LSD-XC-001` … `LSD-XC-012` | 12 | Yes |
| `LPP-FR-*` | C3 functional requirement | `LPP-FR-001` … `LPP-FR-028` | 28 | Yes |
| `LPP-AC-*` | C3 acceptance criterion | `LPP-AC-001` … `LPP-AC-014` | 14 | Yes |
| `LPP-XC-*` | C3 exclusion | `LPP-XC-001` … `LPP-XC-010` | 10 | Yes |
| `LSB-FR-*` | C4 functional requirement | `LSB-FR-001` … `LSB-FR-036` | 36 | Yes |
| `LSB-AC-*` | C4 acceptance criterion | `LSB-AC-001` … `LSB-AC-018` | 18 | Yes |
| `LSB-XC-*` | C4 exclusion | `LSB-XC-001` … `LSB-XC-014` | 14 | Yes |

**Total: 120 FR · 60 AC · 46 XC · 20 cross-part records = 246 identifiers.**

### §1.2 Prefix collision check — measured, not assumed

`PRD_LIFECYCLE.md` §5 rule 2 requires prefixes be *"checked against every
existing register before use"*, and rule 3 requires that on collision **the new
prefix changes, never the existing one**.

| Candidate | Occurrences measured repo-wide | Verdict |
|---|---|---|
| `XPC-` | **0** | ✅ Free — registered to C0 |
| `LMP-` | **0** | ✅ Free — registered to C1 |
| `LSD-` | **0** | ✅ Free — registered to C2 |
| `LPP-` | **0** | ✅ Free — registered to C3 |
| `LSB-` | **0** | ✅ Free — registered to C4 |
| ~~`LMD-`~~ | **350** — Library Module Dependency | ⛔ **REJECTED.** Was the natural choice for "Library Marketplace Discovery"; the new prefix was changed per rule 3 |

⚠ **`LMD-` is recorded as rejected rather than omitted**, because a register
that lists only its accepted prefixes is indistinguishable from one that never
checked.

### §1.3 Normative language

| Term | Meaning |
|---|---|
| **MUST** / **MUST NOT** | Absolute requirement. A build violating it is defective |
| **SHOULD** | Strong recommendation; deviation requires a recorded reason |
| **MAY** | Genuinely optional |
| *(no keyword)* | Explanatory prose. Creates **no** requirement. Quoted `>` blocks are rationale and are **not** normative |

---

## §2. ⭐ The structural question, answered from the repository

The supplied product intent asks for **marketplace functionality in V1**. The
repository defines **`BC-17` Marketplace** as **V3**. The instruction was not to
change the repository, but to determine which of three structures is correct.

### §2.1 What `BC-17` actually is — measured

| Source | Line | Text |
|---|---|---|
| BC Map §3.2 | **L121** | `\| **BC-17** \| Marketplace \| [SUPPORTING] \| Global Student \| V3 \| Owns listings, orders, listing moderation. \|` |
| BC Map §3.4 | **L148** | `\| **V3** \| 2 \| BC-16, BC-17 \|` |
| BC Map §11 | **L488** | `BC-11→17 Student Network` — **Global.** No `tenantId`. Keyed on `PersonId` |
| `MASTER_PRD.md` | **L94** | `\| **MP-SCOPE-06** \| Reputation (BC-16), Marketplace (BC-17) \| V3 \|` |
| Enterprise Architecture | **L992** | `├── Student Marketplace (V3)` — children: *Buy & Sell Books · Stationery · Listing Moderation · Order History* |

⭐⭐ **`BC-17` is a `PersonId`-keyed, `tenantId`-free, student-to-student
classifieds context for selling second-hand books and stationery.** It is **not**
a directory of libraries. The supplied intent's "marketplace" — students finding
and booking *libraries* — is a **different subject** that happens to share an
English word.

### §2.2 The three candidate structures, tested

| # | Candidate | Test | Verdict |
|---|---|---|---|
| 1 | **A future / V3 specification under `BC-17`** | Would key library discovery on `PersonId` with **no `tenantId`**, and would place a *directory of tenants* inside the *Global Student* platform. `X-05` (Matrix **L354**) forbids `LIBRARY MANAGEMENT ↔ BC-11…BC-17`; `ID-3` (BC Map **L180**) forbids the global band from resolving *"which library a person attends"* | ⛔ **REJECTED.** Structurally illegal **and** it would defer to V3 a capability the repository already places at V1 |
| 2 | ⭐ **A read / presentation composition over existing library ownership** | `AR-1` rules *"Library Discovery & Enrollment is **NOT** a new bounded context… an application / read composition capability of the Library domain… owns no aggregate, no invariant, no business state"*. `MASTER_PRD.md` **L171** registers it as **module 19**, **V1**, *"Composition over `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`, `BC-04`, projected via `BC-23`"*, *"not a context"* | ✅ **SELECTED** — see §2.3 |
| 3 | Another smallest compatible structure | Considered: a new `BC-32` Library Directory. Would raise the context count from 31, require an ADR, and duplicate what module 19 already owns at Rank 1 | ⛔ **REJECTED** as strictly larger than candidate 2 with no capability gained |

### §2.3 ⭐ The ruling this draft is written under

> **`PRD-021C` C1–C4 are parts of the existing V1 read composition registered at
> `MASTER_PRD.md` §8 module 19 — "Library Discovery & Enrollment" — under ruling
> `AR-1`. They own no aggregate, no invariant and no business state. `BC-17`
> Marketplace remains V3, untouched, and is not the home of this capability.**

⭐ **This is a DETERMINATION from Rank 1 authority, not a decision.** It required
no ADR, no wave change and no new context. The same method — and the same
`MASTER_PRD.md` **L171** cell — is the `ACCEPTED` precedent set by
[`ADR-0091`](../../00-governance/adr/ADR-0091-prd-021b-b4-b5-b6-owner-decisions.md)
§3 for `PRD-021B`'s `XPB-CONF-001`, which found *"that is **exactly the shape**
B4 claims, already at Rank 1, already V1."*

⚠ **What this does NOT do:** it does **not** promote `BC-17` to V1, does **not**
give `PRD-021C` a bounded context, and does **not** confer Rank 3. `MP-SCOPE-06`
and BC Map **L121**/**L148** are **byte-unchanged**.

### §2.4 Why the supplied word "marketplace" is retained in the title

The title `Local Library Marketplace & Booking` is retained because it is the
product intent's own name for the surface. ⚠ **`LMP-XC-001` states explicitly
that the word carries no `BC-17` ownership claim**, so that a future reader
cannot mistake the title for a wave change.

---

## §3. Authoritative ownership matrix

Every field, entity, operation and event this composition presents is **owned
elsewhere**. `AR-1`'s table is reproduced and extended, and nothing is added to
it.

### §3.1 Entity and field ownership — C1…C4 own none of it

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

`XPC-CONF-001` … `XPC-CONF-014` in §5 record every conflict this matrix surfaced.

### §3.2 What C1…C4 own

| Owned | Detail |
|---|---|
| **Composition and presentation rules** | Which owned read model appears on which public surface, in what order, under what visibility gate |
| **Query shape and filter semantics** | The filter set of §14A.4, expressed as measurable requirements |
| **The authentication boundary placement** | Where an anonymous surface stops, per §14B.6 — **enforced**, never redefined |
| **Nothing else** | ⛔ No aggregate. ⛔ No invariant. ⛔ No business state. ⛔ No stored price, seat, membership, index or media byte |

### §3.3 Event ownership — C1…C4 publish nothing

`LMP-XC-004`, `LSD-XC-003`, `LPP-XC-003` and `LSB-XC-004` each state that the
part publishes **no** domain event and mints **no** event identifier. BC Map §9
Published Language is **unchanged**.

⚠ **This is a deliberate consequence of `AR-1`.** A read composition that owns no
state has no fact of its own to publish. Every event a C-part *consumes* is an
existing one, listed in §4.

---

## §4. Dependency direction — no new edge

`AR-1`'s composition is served entirely by edges that already exist. Measured
against BC Map §7:

| Need | Edge | BC Map line | Exists | Notes |
|---|---|---|---|---|
| Tenant context on every request | `E-18` | **L327** | ✅ | Source cell is the wildcard *"All contexts"* |
| Typed configuration | `E-19` | **L328** | ✅ | Wildcard source |
| Audit emission | `E-20` | **L329** | ✅ | Wildcard source, fire-and-forget |
| Entitlement check before a write | `E-17` | **L326** | ✅ | Wildcard source; **C4 only**, and the write is `BC-04`'s |
| Notification facts | `E-23` | **L332** | ✅ | Wildcard source; **C4 only**, emitted by `BC-04` |
| Domain → search index | `E-21` | **L330** | ⚠ | Source cell is an **enumeration** — `BC-01`, `BC-10`. **`BC-19` is absent** → `XPC-CONF-004`, **OPEN** |
| Domain → file/media `FileRef` | `E-22` | **L331** | ⚠ | Consumers are `BC-01`, `BC-10`, `BC-12`, `BC-14`. **`BC-19`/`BC-25` absent** → `XPC-CONF-007`, **OPEN** |
| Offline booking queue | `E-24` | **L333** | ⛔ | Source is **`BC-03` Attendance only**. `BC-04` is **not** a consumer → `XPC-CONF-011`, resolved by **exclusion**, not by an edge |

⭐ **The wildcard/enumeration distinction is applied exactly as
[`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md)
established it**: five edges carry the wildcard source *"All contexts"* and are
therefore available to any context, while `E-21` and `E-22` hold **enumerations**
and are **not**. `ADR-0084` records that the wildcard argument *"was tested there
and **failed**"* for `E-21`. That finding is **honoured, not re-litigated**.

⛔ **No edge is created, extended or implied by this draft.** Where an edge is
missing, the requirement is written as **conditional and blocked**, and the gap
is recorded in §5 with a named owner.

---

## §5. Cross-part conflict register

Format per instruction: **authority → conflict → resolved/deferred → owner →
smallest compatible resolution.**

| # | Authority | Conflict | Disposition | Owner | Smallest compatible resolution |
|---|---|---|---|---|---|
| `XPC-CONF-001` | BC Map **L121**, **L148**; `MASTER_PRD.md` **L94** (`MP-SCOPE-06`) | Supplied C1 asks for marketplace at **V1**; `BC-17` Marketplace is **V3** | ✅ **RESOLVED — determined, not decided** | — (no decision required) | `BC-17` stays **V3, untouched**. C1–C4 are parts of the **existing V1** read composition at `MASTER_PRD.md` §8 **module 19** under `AR-1`. §2.3 |
| `XPC-CONF-002` | `AR-1`; `MASTER_PRD.md` **L171**–**L180**; Stage 1 (*"It is a presentation composition… **No PRD**"*) | Stage 1's gate says a presentation composition gets **no PRD** — yet the supplied intent requires specified requirements | ✅ **RESOLVED** | — | `MASTER_PRD.md` **L180** already directs *"Requirements are specified in `docs/30-product/library/`"*, and §14A/§14B **are** such requirement documents for module 19. C1–C4 follow that established form. ⛔ **Stage 1 is recorded `NOT APPLICABLE`, not passed** — §7.1 |
| `XPC-CONF-003` | §14A (**FROZEN**) §14A.4, §14A.5; §14B (Approved) | Supplied C2 and C3 restate discovery filters and public profile fields that §14A/§14B **already own** | ✅ **RESOLVED** | — | C2/C3 **consume and cite**; they add no public field and remove no restriction, in §14B.2's own words. Every C2 filter maps to a §14A.4 capability; every C3 field to a §14A.5 field |
| `XPC-CONF-004` | BC Map **L330** (`E-21`: `BC-01`, `BC-10` → `BC-23`); `AR-1` (*"Discovery projection & query → `BC-23`"*); `AR-3` | `AR-1`/`AR-3` require the tenant record to be projected into `BC-23`, but `E-21`'s consumer cell is an **enumeration** that **omits `BC-19`** | ⛔ **DEFERRED — OPEN** (`XPC-OD-001`) | **Architecture Owner** | Either extend `E-21`'s consumer list to include `BC-19` by ADR — the exact one-cell act of `ADR-0016` and `ADR-0055` — **or** rule that the public discovery index is fed by another existing carrier. ⛔ **Not chosen here.** C2's index-fed requirements are marked **conditional on `XPC-OD-001`** |
| `XPC-CONF-005` | `PRD_REGISTRY.md` **L315**; filesystem | `BC-23`'s owner is **`PRD-015` Search Indexing**, which is `PLANNED` and **has no document** (measured: `docs/30-product/` has no `PRD-015` directory) | ⛔ **DEFERRED — OPEN** (`XPC-OD-002`) | **Product Owner** + **Architecture Owner** | C2 **MUST NOT** specify index internals, analyzers, scoring or relevance — those are `PRD-015`'s. C2 specifies only the **query contract it consumes**. `LSD-XC-001`…`LSD-XC-004` |
| `XPC-CONF-006` | `ARCHITECTURE_RULINGS.md` **§6** (*"Reviews & Ratings — Deferred V2. No bounded context assigned; will require a new context and an ADR when tiered"*) | Supplied intent implies ratings/reviews on library profiles | ✅ **RESOLVED by exclusion** | — | **Excluded from V1.** `LPP-XC-005` and `LSD-XC-009` state it. ⛔ No rating entity, field, sort key or filter is created — §6 says such an item *"must not be invented"* |
| `XPC-CONF-007` | BC Map **L331** (`E-22`: `BC-01`, `BC-10`, `BC-12`, `BC-14` → `BC-29`); `AR-1` (*"Gallery → `BC-29`"*) | `AR-1` requires gallery media for the public profile, but `E-22`'s consumer enumeration **omits `BC-19`** and **`BC-25`** | ⛔ **DEFERRED — OPEN** (`XPC-OD-003`) | **Architecture Owner** | The `ADR-0055` precedent is exact (*"`E-22`'s consumer list includes `BC-12`"*) but the authority is the **Architecture Owner's**, not this draft's. C3's gallery requirements are **conditional on `XPC-OD-003`**; `LPP-FR-014`…`LPP-FR-017` |
| `XPC-CONF-008` | `PRD-007` **FROZEN** §2 **L153**; §11 `SEAT-FR-076`…`084`; §12 | Supplied C4 asks `PRD-021C` to "define booking". `PRD-007` **already defines** `Booking` as *"a **student-initiated** request that produces a reservation or an allocation per §12"* | ✅ **RESOLVED** | — | ⛔ **C4 defines no booking.** C4 is a **presentation and initiation surface** over `BC-04`'s existing `SEAT-FR-076`…`084` and §12. `LSB-XC-001`…`LSB-XC-006` |
| `XPC-CONF-009` | `PRD-007` **FROZEN** `SEAT-XC-009`, `SEAT-FR-117`; §14B `LIB-14B.11`…`LIB-14B.14`; `ARCHITECTURE_RULINGS.md` §6 | Supplied C4 title asks for **"Live Seat Availability"**. `SEAT-XC-009` states per-seat state and live occupancy **MUST NOT** be public in V1; `LIB-14B.13` makes Public Live Occupancy **V2**; §6 says it *"must not be invented"* | ✅ **RESOLVED — scope reduced** | — | ⭐ **"Live" is NOT specified for the public surface in V1.** C4 publishes only the **aggregate capacity** and **coarse indicator** (`Available` / `Limited` / `Full`) that `LIB-7.3`, `LIB-14B.12` and `SEAT-FR-117` already permit. Authenticated per-seat state remains `BC-04`'s own surface. `LSB-FR-007`…`LSB-FR-012`, `LSB-XC-007`…`LSB-XC-009` |
| `XPC-CONF-010` | `PRD-007` **FROZEN** §21.2 `SEAT-BR-031`, `SEAT-FR-196`…`200`; §21.3 `SEAT-FR-201`…`205`, `SEAT-BR-032` | Instruction requires C4 to "resolve concurrency/idempotency using existing architecture" | ✅ **RESOLVED** | — | ⛔ **Nothing invented.** C4 **cites** the frozen two-lock rule (seat **and** student allocation set), the idempotency-key requirement, the 24-hour retention and gate **G3**. `LSB-FR-024`…`LSB-FR-031` |
| `XPC-CONF-011` | BC Map **L333** (`E-24`: **`BC-03` only** → `BC-30`) | Supplied intent implies offline/retry booking. `BC-04` Seating is **not** an `E-24` consumer | ✅ **RESOLVED by exclusion** | — | ⛔ **No offline booking queue in V1.** `LSB-XC-010` states it. Client retry is served by the **existing idempotency key** (`SEAT-FR-201`), which needs no `BC-30` edge. Should offline booking be wanted, it is an `E-24` amendment — recorded as `XPC-OD-004`, **not** taken |
| `XPC-CONF-012` | Matrix **L354** (`X-05`); BC Map **L180** (`ID-3`), **L284** | A "local library marketplace" naturally suggests social signals — friends at a library, community activity. `X-05` forbids `LIBRARY MANAGEMENT ↔ BC-11…BC-17`; `ID-3` forbids the global band resolving *"which library a person attends"* | ✅ **RESOLVED by exclusion** | — | ⛔ **No social signal appears anywhere in C1–C4.** `LMP-XC-006`, `LSD-XC-010`, `LPP-XC-008`. `PRD-021A` (`BC-15`) and `PRD-021B` (`BC-11`/`BC-12`) are **not** consumed and **not** cited as data sources |
| `XPC-CONF-013` | `Library_PRD_v1.md` **L1014**, `LIB-24.2`; `ARCHITECTURE_RULINGS.md` **L290**; `PRD_OWNERSHIP_MODEL.md` §11 (Privacy Owner, **constituted, holder VACANT**) | Public Live Occupancy requires a **completed privacy review** that does not exist, and the Privacy Owner role has **no holder recorded** | ⛔ **DEFERRED — OPEN** (`XPC-OD-005`) | **Privacy Owner** | V1 excludes the feature entirely (`XPC-CONF-009`), so V1 is **not blocked**. The review is required only if Public Live Occupancy is tiered to V2 |
| `XPC-CONF-014` | Enterprise Architecture **L992** (`Student Marketplace (V3)`); `DOCUMENTATION_BASELINE.md` (EA is **Rank 6**, *"Descriptive — must follow the PRDs, never lead them"*) | The EA tree shows only a **V3 Student Marketplace** and no V1 library-directory node, so the EA appears to contradict `MASTER_PRD.md` **L171** | ✅ **RESOLVED — precedence applied, EA unedited** | — | ⭐ Under the `ADR-0061`/`ADR-0091` precedent a **higher rank prevails over an EA wave tag without editing the EA**. `MASTER_PRD.md` is **Rank 1**; the EA is **Rank 6** and descriptive. ⛔ **EA is byte-unchanged.** Residual staleness recorded as `XPC-OD-006` |

**Resolved: 9 · Deferred/OPEN: 5.**

---

## §6. Open decisions register

⛔ **None of these is decided by this draft.** Each carries a named owner role,
never a personal name (`PRD_OWNERSHIP_MODEL.md` §7 rule 4).

| # | Decision required | Owner | Blocks | Smallest lawful act |
|---|---|---|---|---|
| `XPC-OD-001` | Does `E-21`'s consumer enumeration admit **`BC-19`**, so the `TenantOrganisation` record can be projected into `BC-23` for public discovery? | **Architecture Owner** | C2's index-fed requirements (`LSD-FR-001`…`LSD-FR-008`) | A one-cell edge amendment by ADR, precedent `ADR-0016` / `ADR-0055`. ⛔ **Not performed here** — `ADR-0084` records `E-21` as an enumeration, and extending it is an Architecture Owner act |
| `XPC-OD-002` | `PRD-015` Search Indexing does not exist. Who specifies the `BC-23` query contract C2 consumes? | **Product Owner** + **Architecture Owner** | C2 cannot be Stage-3 complete while its provider is unspecified | Author `PRD-015`, **or** rule that §14A's discovery capability list is the contract for V1 |
| `XPC-OD-003` | Does `E-22`'s consumer enumeration admit **`BC-19`** and/or **`BC-25`**, so public gallery/branding media can be served as a `FileRef`? | **Architecture Owner** | C3's gallery requirements (`LPP-FR-014`…`LPP-FR-017`) | One-cell amendment by ADR, precedent `ADR-0055`. ⛔ **Not performed here** |
| `XPC-OD-004` | Should `BC-04` Seating become an `E-24` consumer, enabling an offline booking queue? | **Architecture Owner** | Nothing in V1 — C4 excludes offline booking | An `E-24` amendment by ADR. ⛔ **Not requested and not required for V1** |
| `XPC-OD-005` | The privacy review `LIB-24.2` requires before Public Live Occupancy may be designed | **Privacy Owner** *(role constituted by `ADR-0077`; ⚠ holder **VACANT**)* | Nothing in V1 — V1 excludes the feature | Conduct and record the review **before** any V2 design. `ARCHITECTURE_RULINGS.md` §6: *"must not be invented"* |
| `XPC-OD-006` | The Enterprise Architecture tree has no V1 library-directory node although `MASTER_PRD.md` **L171** registers module 19 at V1 | **Architecture Owner** | Nothing — precedence resolves it (`XPC-CONF-014`) | An EA refresh. ⚠ **Disclosed, not repaired** — the identical disposition `ADR-0091` gave `XPB-DRIFT-001` |

---

## §7. Architecture consistency chain — preparatory self-assessment

> ⚠⚠ **THIS IS NOT A STAGE 3 GATE RESULT.** Stage 3's gate is *"a written
> alignment record naming every conflict and its disposition"*. **No such record
> exists for `PRD-021C`, and none is claimed.** The table below is a
> **self-assessment performed while drafting**, reproduced so a future reviewer
> can see what was and was not checked.

| Check | Authority | Self-assessment | Note |
|---|---|---|---|
| Context ownership is exclusive | BC Map §3 | ⚠ **Not applicable in the usual sense** | C1–C4 own **no** context and **no** aggregate (`AR-1`). Nothing to contest |
| Every integration edge exists in §7 | BC Map §7 | ⚠ **PARTIAL** | 5 wildcard edges ✅; `E-21` and `E-22` ⛔ **enumerations that omit the contexts needed** → `XPC-OD-001`, `XPC-OD-003`. **Recorded as blocking, not waived** |
| Rank direction is downward | Matrix `L2` | ✅ Believed satisfied | A read composition consuming domain read models and capability ports. No upward import |
| No authorisation decided outside `BC-18` | `X-13` | ✅ Believed satisfied | Every C-part delegates to `BC-18`; `LMP-XC-007`, `LSB-XC-011` |
| No credential, OTP or session outside `BC-18` | `ID-1` | ✅ Believed satisfied | `LMP-XC-008` |
| Tenant scoping correct | `MP-GBR-08`, `X-13`, `AR-3` | ⚠ **Requires review** | The public discovery surface is **deliberately tenant-less** (`AR-3`), which is lawful **only** for the Platform Public Discovery Index. Every operational read stays tenant-scoped (`E-18`). This is the highest-severity area and is flagged for Stage 3 rather than self-certified |

### §7.1 Stage 1 — recorded `NOT APPLICABLE`, not passed

Stage 1's gate is *"a context identified in the Bounded Context Map, **not
already owned** in `PRD_REGISTRY.md` §6."* `PRD-021C` identifies **no** context —
by design, under `AR-1`. The gate therefore **cannot be met and does not
apply**, which is a different thing from being skipped.

⭐ **Precedent:** `PRD-012a` carries **Stage 1 `NOT APPLICABLE`** by `ADR-0060`,
recorded in `PRD_REGISTRY.md` as *"a gate that does not apply rather than a gate
skipped."* The same form is used here.

---

## §8. Acceptance-criteria coverage summary

| Part | FRs | ACs | FRs with ≥1 AC | Coverage | Blocked by an open decision |
|---|---|---|---|---|---|
| C1 | 24 | 12 | 24 | **100%** | 0 |
| C2 | 32 | 16 | 32 | **100%** | 8 (`XPC-OD-001`, `XPC-OD-002`) |
| C3 | 28 | 14 | 28 | **100%** | 4 (`XPC-OD-003`) |
| C4 | 36 | 18 | 36 | **100%** | 0 |
| **Total** | **120** | **60** | **120** | **100%** | **12** |

⚠⚠ **Two disclosures this table must carry, or it would overstate itself:**

1. **"Coverage" means every FR is named by at least one AC.** It does **not**
   mean an AC is *proven*. **0 of 60** ACs is proven by a test — **no test
   exists**, and no `lib/` or `test/` code is created by this draft.
2. **12 of 120 FRs are conditional on an OPEN decision** and cannot be
   implemented until `XPC-OD-001`, `XPC-OD-002` or `XPC-OD-003` is resolved by
   its owner. They are written as requirements, marked conditional, and counted
   honestly rather than quietly dropped to make the table read cleanly.

---

## §9. Status

| Field | Value |
|---|---|
| **Lifecycle stage** | **Stage 2 (Draft)** |
| **Status** | **`DRAFT`** |
| **Freeze** | ⛔ **NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED** |
| **Baseline row** | ⛔ **None.** `DOCUMENTATION_BASELINE.md` §3 contains **no** `PRD-021C` row, and none is requested |
| **Rank** | ⛔ **None** |
| **Stage 3** | ⛔ **NOT ENTERED.** Gate is a written alignment record; **none exists** |
| **Open decisions** | **6** — `XPC-OD-001` … `XPC-OD-006`, all ⛔ **OPEN** |
| **Conflicts recorded** | **14** — 9 resolved, 5 deferred |
| **ADRs created** | ⛔ **0** |
| **Bounded contexts created** | ⛔ **0.** Count remains **31** |
| **Integration edges created** | ⛔ **0.** Count remains **28**, `E-27` permanently vacant |
| **Published events minted** | ⛔ **0** |
| **`IMPL-*` identifiers minted** | ⛔ **0** |
| **Rank 1–6 documents modified** | ⛔ **0** |

---

## §10. What `PRD-021C` does **not** do

1. ⛔ **Creates no bounded context.** `BC-17` stays **V3**; the count stays **31**.
2. ⛔ **Promotes no wave.** `MP-SCOPE-06` and BC Map **L121**/**L148** are byte-unchanged.
3. ⛔ **Creates no integration edge.** Where one is needed it is an **OPEN decision**, not an act.
4. ⛔ **Mints no published event.**
5. ⛔ **Defines no booking.** `PRD-007` **FROZEN** owns `Booking`, `Reservation`, `SeatAllocation` and `SeatState`.
6. ⛔ **Defines no seat, membership, student or tenant entity.**
7. ⛔ **Creates no second search or ranking system.** `BC-23` keeps relevance; `PRD-015` keeps the index.
8. ⛔ **Creates no payment system.** `BC-05` and `BC-20` keep money; C3 shows **indicative** prices only (`LIB-14B.18`).
9. ⛔ **Creates no rating, review or reputation.** Deferred **V2** by `ARCHITECTURE_RULINGS.md` §6.
10. ⛔ **Creates no ADR** and ratifies none.
11. ⛔ **Amends no FROZEN PRD.** §14A, §14B, `PRD-004`, `PRD-005`, `PRD-007`, `PRD-013`, `PRD-014`, `PRD-016`, `PRD-017`, `PRD-020` are byte-unchanged.
12. ⛔ **Confers no lifecycle stage** beyond Draft, and **no** freeze, approval or baseline row.
13. ⛔ **Writes no application code.** **0** lines under `lib/`, `test/`, `tool/`, `web/`, `android/`, `.github/`.
14. ⛔ **Consumes no social context.** `X-05` and `ID-3` preserved; `PRD-021A`/`PRD-021B` are not data sources.

---

## §11. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-02 | Created as the Stage-2 cross-part companion to C1–C4. Records the `AR-1` / module 19 determination (§2.3), the 14-item conflict register (§5), the 6 open decisions (§6) and the 246-identifier register set (§1.1). ⛔ No ADR, no edge, no context, no event, no `IMPL-*`, no Rank 1–6 edit, no freeze |
