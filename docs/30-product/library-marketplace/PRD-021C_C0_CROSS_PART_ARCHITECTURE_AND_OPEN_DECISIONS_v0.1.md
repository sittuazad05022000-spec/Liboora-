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
| **Version** | **v0.2b** ⚠ *(the filename still says `v0.1` and is deliberately NOT renamed — 366+ citations across the repository resolve by path)* |
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
| **C3** | `PRD-021C_C3_LIBRARY_PUBLIC_PROFILE_DRAFT_v0.1.md` *(v0.2)* | `LPP-` | 44 | 22 |
| **C4** | `PRD-021C_C4_LIVE_SEAT_AVAILABILITY_AND_BOOKING_DRAFT_v0.1.md` | `LSB-` | 36 | 18 |

### §1.1 Identifier registers — declared up front, ranges published as a promise

Per `PRD_LIFECYCLE.md` Stage 2 rule 1 (*"every requirement has a unique
identifier"*), rule 2 (*prefixes checked against §5's collision procedure
**before** writing*), and rule 3 (*ranges contiguous*).

| Register | Meaning | Range | Count | Contiguous |
|---|---|---|---|---|
| `XPC-CONF-*` | Cross-part conflict record | `XPC-CONF-001` … `XPC-CONF-015` | 15 | Yes |
| `XPC-OD-*` | Open decision | `XPC-OD-001` … `XPC-OD-007` | 7 | Yes |
| `LMP-FR-*` | C1 functional requirement | `LMP-FR-001` … `LMP-FR-024` | 24 | Yes |
| `LMP-AC-*` | C1 acceptance criterion | `LMP-AC-001` … `LMP-AC-012` | 12 | Yes |
| `LMP-XC-*` | C1 exclusion | `LMP-XC-001` … `LMP-XC-010` | 10 | Yes |
| `LSD-FR-*` | C2 functional requirement | `LSD-FR-001` … `LSD-FR-032` | 32 | Yes |
| `LSD-AC-*` | C2 acceptance criterion | `LSD-AC-001` … `LSD-AC-016` | 16 | Yes |
| `LSD-XC-*` | C2 exclusion | `LSD-XC-001` … `LSD-XC-012` | 12 | Yes |
| `LPP-FR-*` | C3 functional requirement | `LPP-FR-001` … `LPP-FR-044` | 44 | Yes |
| `LPP-AC-*` | C3 acceptance criterion | `LPP-AC-001` … `LPP-AC-022` | 22 | Yes |
| `LPP-XC-*` | C3 exclusion | `LPP-XC-001` … `LPP-XC-017` | 17 | Yes |
| `LSB-FR-*` | C4 functional requirement | `LSB-FR-001` … `LSB-FR-036` | 36 | Yes |
| `LSB-AC-*` | C4 acceptance criterion | `LSB-AC-001` … `LSB-AC-018` | 18 | Yes |
| `LSB-XC-*` | C4 exclusion | `LSB-XC-001` … `LSB-XC-014` | 14 | Yes |

**Total: 136 FR · 68 AC · 53 XC · 22 cross-part records = 279 identifiers.**

> ⚠ **The total was 246 at v0.1 and is disclosed here as changed, not silently
> restated.** C3 **v0.2** added §9A (Owner Profile Engagement Summary): **+16
> FR**, **+8 AC**, **+7 XC**, plus **`XPC-CONF-015`** and **`XPC-OD-007`** in
> this document — **+33** identifiers. The figure **246** remains correct for the
> C1–C4 authoring baseline at commit
> `21704ba8c71f76f8689ddd0fc1680f78fe768359`, and any artefact citing 246 is
> citing that baseline rather than being wrong.

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
| `XPC-CONF-004` | BC Map **L330** (`E-21`: `BC-01`, `BC-10` → `BC-23`); `AR-1` (*"Discovery projection & query → `BC-23`"*); `AR-3` | `AR-1`/`AR-3` require the tenant record to be projected into `BC-23`, but `E-21`'s consumer cell is an **enumeration** that **omits `BC-19`** | ✅ **RESOLVED 2026-09-02 — [`ADR-0093`]** *(was ⛔ DEFERRED — OPEN, `XPC-OD-001`)* | **Architecture Owner** | ⭐ **The first branch was taken**: `E-21`'s source cell was extended to include `BC-19` by ADR, the exact one-cell act of `ADR-0016` and `ADR-0055`; BC Map **L330** now reads `BC-01, BC-10, BC-19`. ⛔ The second branch — *"another existing carrier"* — was tested and **found not to exist**. C2's index-fed requirements are **no longer conditional** |
| `XPC-CONF-005` | `PRD_REGISTRY.md` **L315**; filesystem | `BC-23`'s owner is **`PRD-015` Search Indexing**, which is `PLANNED` and **has no document** (measured: `docs/30-product/` has no `PRD-015` directory) | ✅ **RESOLVED 2026-09-02 — [`ADR-0094`]** *(was ⛔ DEFERRED — OPEN, `XPC-OD-002`)* | **Product Owner** + **Architecture Owner** | ⭐ **`Library_PRD_v1.md` §14A is ruled the V1 `BC-23` discovery/query contract** — so C2's provider is now specified by an **existing FROZEN authority**, and ⛔ **`PRD-015` was NOT authored and remains `PLANNED`**, meaning ⚠ **the underlying observation stays TRUE: `BC-23`'s registered owner still has no document.** That is a *registry* residue, not a C2 blocker. C2 still **MUST NOT** specify index internals, analyzers, scoring or relevance — those remain `PRD-015`'s when it is written. C2 specifies only the **query contract it consumes**. `LSD-XC-001`…`LSD-XC-004` |
| `XPC-CONF-006` | `ARCHITECTURE_RULINGS.md` **§6** (*"Reviews & Ratings — Deferred V2. No bounded context assigned; will require a new context and an ADR when tiered"*) | Supplied intent implies ratings/reviews on library profiles | ✅ **RESOLVED by exclusion** | — | **Excluded from V1.** `LPP-XC-005` and `LSD-XC-009` state it. ⛔ No rating entity, field, sort key or filter is created — §6 says such an item *"must not be invented"* |
| `XPC-CONF-007` | BC Map **L331** (`E-22`: `BC-01`, `BC-10`, `BC-12`, `BC-14` → `BC-29`); `AR-1` (*"Gallery → `BC-29`"*) | `AR-1` requires gallery media for the public profile, but `E-22`'s consumer enumeration **omits `BC-19`** and **`BC-25`** | ✅ **RESOLVED 2026-09-02 — [`ADR-0095`], BOTH admitted** *(was ⛔ DEFERRED — OPEN, `XPC-OD-003`)* | **Architecture Owner** | ⭐ **The `ADR-0055` precedent was followed exactly, including its §3 discipline of testing each candidate SEPARATELY** — and it is `ADR-0095`'s own title (*"`E-22`'s consumer list includes `BC-19` and `BC-25`"*). BC Map **L331** now reads `BC-01, BC-10, BC-12, BC-14, BC-19, BC-25`. The authority was the **Architecture Owner's** and was **exercised by conferral**, not assumed by a draft. C3's gallery requirements `LPP-FR-014`…`LPP-FR-017` are **no longer conditional** |
| `XPC-CONF-008` | `PRD-007` **FROZEN** §2 **L153**; §11 `SEAT-FR-076`…`084`; §12 | Supplied C4 asks `PRD-021C` to "define booking". `PRD-007` **already defines** `Booking` as *"a **student-initiated** request that produces a reservation or an allocation per §12"* | ✅ **RESOLVED** | — | ⛔ **C4 defines no booking.** C4 is a **presentation and initiation surface** over `BC-04`'s existing `SEAT-FR-076`…`084` and §12. `LSB-XC-001`…`LSB-XC-006` |
| `XPC-CONF-009` | `PRD-007` **FROZEN** `SEAT-XC-009`, `SEAT-FR-117`; §14B `LIB-14B.11`…`LIB-14B.14`; `ARCHITECTURE_RULINGS.md` §6 | Supplied C4 title asks for **"Live Seat Availability"**. `SEAT-XC-009` states per-seat state and live occupancy **MUST NOT** be public in V1; `LIB-14B.13` makes Public Live Occupancy **V2**; §6 says it *"must not be invented"* | ✅ **RESOLVED — scope reduced** | — | ⭐ **"Live" is NOT specified for the public surface in V1.** C4 publishes only the **aggregate capacity** and **coarse indicator** (`Available` / `Limited` / `Full`) that `LIB-7.3`, `LIB-14B.12` and `SEAT-FR-117` already permit. Authenticated per-seat state remains `BC-04`'s own surface. `LSB-FR-007`…`LSB-FR-012`, `LSB-XC-007`…`LSB-XC-009` |
| `XPC-CONF-010` | `PRD-007` **FROZEN** §21.2 `SEAT-BR-031`, `SEAT-FR-196`…`200`; §21.3 `SEAT-FR-201`…`205`, `SEAT-BR-032` | Instruction requires C4 to "resolve concurrency/idempotency using existing architecture" | ✅ **RESOLVED** | — | ⛔ **Nothing invented.** C4 **cites** the frozen two-lock rule (seat **and** student allocation set), the idempotency-key requirement, the 24-hour retention and gate **G3**. `LSB-FR-024`…`LSB-FR-031` |
| `XPC-CONF-011` | BC Map **L333** (`E-24`: **`BC-03` only** → `BC-30`) | Supplied intent implies offline/retry booking. `BC-04` Seating is **not** an `E-24` consumer | ✅ **RESOLVED by exclusion** | — | ⛔ **No offline booking queue in V1.** `LSB-XC-010` states it. Client retry is served by the **existing idempotency key** (`SEAT-FR-201`), which needs no `BC-30` edge. Should offline booking be wanted, it is an `E-24` amendment — recorded as `XPC-OD-004`, **not** taken |
| `XPC-CONF-012` | Matrix **L354** (`X-05`); BC Map **L180** (`ID-3`), **L284** | A "local library marketplace" naturally suggests social signals — friends at a library, community activity. `X-05` forbids `LIBRARY MANAGEMENT ↔ BC-11…BC-17`; `ID-3` forbids the global band resolving *"which library a person attends"* | ✅ **RESOLVED by exclusion** | — | ⛔ **No social signal appears anywhere in C1–C4.** `LMP-XC-006`, `LSD-XC-010`, `LPP-XC-008`. `PRD-021A` (`BC-15`) and `PRD-021B` (`BC-11`/`BC-12`) are **not** consumed and **not** cited as data sources |
| `XPC-CONF-013` | `Library_PRD_v1.md` **L1014**, `LIB-24.2`; `ARCHITECTURE_RULINGS.md` **L290**; `PRD_OWNERSHIP_MODEL.md` §11 (Privacy Owner, **constituted, holder VACANT**) | Public Live Occupancy requires a **completed privacy review** that does not exist, and the Privacy Owner role has **no holder recorded** | ⛔ **DEFERRED — OPEN** (`XPC-OD-005`) | **Privacy Owner** | V1 excludes the feature entirely (`XPC-CONF-009`), so V1 is **not blocked**. The review is required only if Public Live Occupancy is tiered to V2 |
| `XPC-CONF-014` | Enterprise Architecture **L992** (`Student Marketplace (V3)`); `DOCUMENTATION_BASELINE.md` (EA is **Rank 6**, *"Descriptive — must follow the PRDs, never lead them"*) | The EA tree shows only a **V3 Student Marketplace** and no V1 library-directory node, so the EA appears to contradict `MASTER_PRD.md` **L171** | ✅ **RESOLVED — precedence applied, EA unedited** | — | ⭐ Under the `ADR-0061`/`ADR-0091` precedent a **higher rank prevails over an EA wave tag without editing the EA**. `MASTER_PRD.md` is **Rank 1**; the EA is **Rank 6** and descriptive. ⛔ **EA is byte-unchanged.** Residual staleness recorded as `XPC-OD-006` |

| `XPC-CONF-015` | BC Map **L135**, **L385** (`BC-26` Analytics Read Model, Rank 4); `PRD_REGISTRY.md` **L246** (`PRD-009`, `PLANNED`); §14A.5 *Internal Analytics* (**never-public**); `LIB-14B.22`; BC Map §9 event surface | Supplied C3 requirement adds an **Owner Profile Views summary** to the library profile. Three separate tensions: (a) *Internal Analytics* is on the **frozen never-public list**; (b) `LPP-FR-002`/`004`/`008` forbid non-`14A.5` fields, authentication gates and viewer-varying order; (c) **no profile-view event producer and no lawful edge into `BC-26` exists** | ✅ **RESOLVED 2026-09-02 — presentation reconciled (v0.2) *and* production decided (`ADR-0096` + `ADR-0097`)** *(was ⚠ PARTIALLY RESOLVED — production DEFERRED, `XPC-OD-007`)* | **Architecture Owner** + **Product Owner** | ⭐ **Analytics ownership reconciled to the owner that already exists — nothing invented.** `BC-26` owns the metric/semantic layer, `CertifiedMetric` and `ReadModel`; `PRD-009` owns the analytics experience. C3 **renders only** (`LPP-FR-035`…`038`) and defines **no** metric semantics. (a) resolved: the summary is an **owner-only overlay outside the public projection** (`LPP-FR-030`, `LPP-XC-015`) — nothing analytic reaches a public response. (b) resolved **without amending** `LPP-FR-002`/`004`/`008`: it is not a profile field, not a read gate, and position **7** is a **reserved slot invariant within each audience class** (C3 §9A.2). (c) ✅ **NOW DECIDED 2026-09-02** *(was ⛔ not decided — `XPC-OD-007`)*: **[`ADR-0096`]** mints the producer and the lawful edge — `tenancy.LibraryProfileViewed` from **`BC-19`** over **new edge `E-30`** into `BC-26` — and **[`ADR-0097`]** certifies **`ProfileViews` only**, ⛔ **refusing `UniqueViewers`**. ⭐ **`LPP-XC-011`…`014` are NOT relaxed and remain in force**: C3 still mints no analytics system, pipeline, metric semantic, event or edge — ⭐ **the event and edge were minted by the ARCHITECTURE OWNER in the BC Map, which is precisely why C3's prohibition survives its own unblocking.** C3 remains **render-only**. ⚠ **This conflict therefore moves from PARTIALLY RESOLVED to RESOLVED**, and tension (a) is unaffected — *Internal Analytics* remains on the frozen **never-public** list, honoured by the owner-only overlay |

**Resolved: 13 · Partially resolved: 0 · Deferred/OPEN: 2.** ⭐ *(Advanced 2026-09-02 from "9 · 1 · 5" by the owner-decision execution pass: `XPC-CONF-004`, `005` and `007` move OPEN → RESOLVED, and `XPC-CONF-015` moves PARTIALLY RESOLVED → RESOLVED. The tally was **re-derived by counting the disposition cells**, not by arithmetic on the old figure. ⛔ **The two that remain OPEN are `XPC-CONF-013`** — the Privacy Owner review, office **VACANT**, `XPC-OD-005` — **and `XPC-CONF-014`/`XPC-OD-006`**, the EA staleness disclosed-not-repaired; ⛔ **neither is touched by any of the five decisions, and neither is silently closed.** ⚠ Note `XPC-CONF-005`'s underlying fact survives its own resolution: `PRD-015` still has no document, which is a **registry** residue and not a C2 blocker.)*

> **`XPC-CONF-015` is the one conflict in this register where the answer already
> existed and the work was to find it rather than settle it.** A profile-views
> readout looks like it needs a tracking system. The repository already has an
> analytics owner at Rank 4 with an explicit *"metric definitions single-sourced
> from the semantic layer"* invariant, and a registered product owner for the
> analytics experience. Inventing a counter inside a composition capability that
> owns no aggregate would have created the second analytics system the
> requirement explicitly forbids. What genuinely does **not** exist is the
> *producer* of the view fact and the *edge* to carry it — and that is recorded
> OPEN rather than minted, following `ADR-0084` and `ADR-0083` §4.5, both of
> which **refused** to mint an edge to make a consumer list convenient.

---

## §6. Open decisions register

⚠⚠ **UPDATED 2026-09-02 — FIVE of these are now RESOLVED, and the resolutions were NOT made by this draft.** They were made by the **explicit conferral of the human principal**, recorded as `ADR-0093`…`ADR-0097` and executed in the same pass; this register merely reports them. ⭐ **`XPC-OD-001` = A · `XPC-OD-002` = A · `XPC-OD-003` = C · `XPC-OD-007A` = C · `XPC-OD-007B` = B.**

⛔ **`XPC-OD-004`, `XPC-OD-005` and `XPC-OD-006` remain OPEN and are DELIBERATELY NOT resolved here.** No conferral covered them, none is required for V1, and ⛔ **resolving an unrelated decision as a side effect of an authorised pass is exactly the defect this register exists to prevent.** `XPC-OD-005` in particular still awaits a **Privacy Owner** whose office is **VACANT**.

⛔ **Nothing in this section is decided by this draft.** Each row carries a named owner role,
never a personal name (`PRD_OWNERSHIP_MODEL.md` §7 rule 4).

| # | Decision required | Owner | Blocks | Smallest lawful act |
|---|---|---|---|---|
| `XPC-OD-001` | Does `E-21`'s consumer enumeration admit **`BC-19`**, so the `TenantOrganisation` record can be projected into `BC-23` for public discovery? | **Architecture Owner** | ~~C2's index-fed requirements (`LSD-FR-001`…`LSD-FR-008`)~~ → ⭐ **UNBLOCKED** | ✅ **RESOLVED 2026-09-02 — [`ADR-0093`], option A.** The Architecture Owner, by direct conferral for this act, amended `E-21`'s **Upstream (source) cell only** to read `BC-01, BC-10, BC-19` (BC Map **L330**). ⭐ **The act was exactly the one this row predicted** — the one-cell `ADR-0016`/`ADR-0055` amendment, no larger. ⛔ **No edge added, no edge removed, no pattern or mechanism changed, no new search system, no `BC-15` community search** (`ADR-0083` §4.5 **AO-9** preserved). ⚠ The prior note that *"`ADR-0084` records `E-21` as an enumeration"* stands and is the very reason an ADR was required rather than a typed-in cell |
| `XPC-OD-002` | `PRD-015` Search Indexing does not exist. Who specifies the `BC-23` query contract C2 consumes? | **Product Owner** + **Architecture Owner** | ~~C2 cannot be Stage-3 complete while its provider is unspecified~~ → ⭐ **UNBLOCKED** | ✅ **RESOLVED 2026-09-02 — [`ADR-0094`], option A.** Product Owner **and** Architecture Owner **jointly** (a contract is a product surface *and* an architecture route) ruled that **`Library_PRD_v1.md` §14A IS the V1 `BC-23` discovery/query contract**. ⭐ **The ADR is DECLARATORY and edits nothing** — §14A is **FROZEN 2026-08-03** and is **byte-unchanged**; the ruling recognises authority §14A already held rather than extending it (`ADR-0060` precedent). ⭐ Its **§2.1** performs the mandatory **`AR-3` index-class determination**: the index is a **Platform Public Discovery Index**, ⛔ **not** Tenant Operational Data — *a seeker discovering a library is by definition not yet a member of it* — with content limited to §14A public fields filtered by §14A.6. ⛔ **`PRD-015` was NOT authored and remains `PLANNED`**; ⛔ no second search, query or ranking authority exists |
| `XPC-OD-003` | Does `E-22`'s consumer enumeration admit **`BC-19`** and/or **`BC-25`**, so public gallery/branding media can be served as a `FileRef`? | **Architecture Owner** | ~~C3's gallery requirements (`LPP-FR-014`…`LPP-FR-017`)~~ → ⭐ **UNBLOCKED** | ✅ **RESOLVED 2026-09-02 — [`ADR-0095`], option C: BOTH.** `E-22`'s **Downstream (consumer) cell** now reads `BC-01, BC-10, BC-12, BC-14, BC-19, BC-25` (BC Map **L331**). ⭐ **Each was tested SEPARATELY, so "both" is the measured answer and not a convenience union** — the `ADR-0055` §3 discipline: **§3.1** admits `BC-19` on gallery media (it owns the library organisation record, **L128**; `AR-1` **L23** already routes *"Gallery → `BC-29`"*); **§3.2** admits `BC-25` on an **independent** ground (**L134** already grants it *"branding values"*, `LPP-FR-011` requires the logo from it, and L134's own *"secret **references**"* phrasing anticipates the `FileRef` shape); **§3.3** shows A alone leaves the logo unlawful and B alone leaves the gallery unlawful. ⛔ **§3.4 preserves the `BC-11`/`BC-13` refusals** and admits neither `BC-23`, `BC-26` nor any C-part. ⛔ `BC-29` remains sole media-infrastructure owner, `FileRef` remains a reference, **no source BC owns bytes, and no duplicate media infrastructure is created — guaranteed by construction, since the amendment reuses the existing edge rather than adding one** |
| `XPC-OD-004` | Should `BC-04` Seating become an `E-24` consumer, enabling an offline booking queue? | **Architecture Owner** | Nothing in V1 — C4 excludes offline booking | An `E-24` amendment by ADR. ⛔ **Not requested and not required for V1** |
| `XPC-OD-005` | The privacy review `LIB-24.2` requires before Public Live Occupancy may be designed | **Privacy Owner** *(role constituted by `ADR-0077`; ⚠ holder **VACANT**)* | Nothing in V1 — V1 excludes the feature | Conduct and record the review **before** any V2 design. `ARCHITECTURE_RULINGS.md` §6: *"must not be invented"* |
| `XPC-OD-006` | The Enterprise Architecture tree has no V1 library-directory node although `MASTER_PRD.md` **L171** registers module 19 at V1 | **Architecture Owner** | Nothing — precedence resolves it (`XPC-CONF-014`) | An EA refresh. ⚠ **Disclosed, not repaired** — the identical disposition `ADR-0091` gave `XPB-DRIFT-001` |
| `XPC-OD-007A` | **Which context lawfully produces the profile-view fact, over which declared edge?** Measured at draft time: the V1 event surface (BC Map §9) contained **no view event for any aggregate**, and the only edge into `BC-26` was **`E-26`** (`BC-27 AI → BC-26, BC-23`), which is not a telemetry ingress | **Architecture Owner** | ~~C3 §9A `LPP-FR-030`…`LPP-FR-044`~~ → ⭐ **UNBLOCKED** | ✅ **RESOLVED 2026-09-02 — [`ADR-0096`], option C: a NEW event and a NEW lawful edge.** Event **`tenancy.LibraryProfileViewed`**, produced by **`BC-19 Tenancy`**, carried over **NEW edge `E-30`** (`BC-19 → BC-26`, `PL`, Event, **V1**), appended as BC Map **§17** rather than edited into §7 — the `ADR-0079` §8.5 Option A method that shifts **zero** of the §7 line citations. ⭐ **`E-30`, not `E-27`**: `E-27` is **permanently vacant** (withdrawn by `ADR-0033`), and `PRD_LIFECYCLE.md` §5 rule 5 forbids reuse *"even after withdrawal"*; `E-28`/`E-29` already exist in §15.1. ⭐ **The producer was DETERMINED across eight candidates, not assumed** — `BC-19` wins on three measurements: it owns the entity (BC Map **L128**, `MASTER_PRD.md` **L171**), it **already publishes** `tenancy.*` events (**L435**), and it owns the `Tenant` aggregate (**L381**). ⭐ **The event name was DERIVED from §9's binding convention** (`<Context>.<Aggregate><PastTenseVerb>`), never invented and never an imperative. ⛔⛔ **This row's own prior speculation was TESTED AND REJECTED.** It suggested *"the producer question may resolve toward `BC-24`, not a new emitter"*, citing `SM-7.17`. `ADR-0096` **§3.3** refuses `BC-24 → BC-26` on two measurements: `BC-24` is the source of **0** edges, so that route is *larger* not smaller; and `AuditEntry` requires an *"actor of record"* (**L384**) which an **anonymous** public-profile view has none of. ⭐ **`SM-7.17` is DISTINGUISHED on its facts, NOT overruled** — a staff member viewing a student has a named actor *and* a named data subject; a seeker viewing a public library profile has neither — and `Student_Management_PRD_v1.md` is **byte-unchanged**. ⛔ **`E-26` is NOT reused as telemetry** (wrong producer, wrong direction of benefit, wrong mechanism). ⭐ **§4 makes viewer anonymity a property of the PAYLOAD**: ⛔ no viewer identity, no `StudentRecordId`, no social signal, no credential/session/IP — and ⛔ no count, total or trend, so the event is a **fact**, never an analytics-derived duplicate. ⚠⚠ **`GAP-BCMAP-BC26-EDGES` was DISCOVERED and DISCLOSED rather than exploited**: `BC-26` already sits in ~20 §9 *"Primary consumer"* cells with no §7 edge. Using that as authority would have resolved a **pre-existing unrelated inconsistency by side effect** and would have rested a new fact on an **absence**, so it is routed to the Architecture Owner as a separate question (`ADR-0096` §1.2, BC Map **§17.4**) |
| `XPC-OD-007B` | **Does `BC-26` certify `ProfileViews` and `UniqueViewers` as `CertifiedMetric`s?** Measured at draft time: **`PRD-009` is `PLANNED` and absent from disk** (`PRD_REGISTRY.md` **L246**) | **Product Owner** + **Architecture Owner** *(jointly, per C3 **L148**)* | ~~C3 §9A `LPP-FR-035`…`LPP-FR-038`~~ → ⭐ **UNBLOCKED, one metric certified and one refused** | ✅ **RESOLVED 2026-09-02 — [`ADR-0097`], option B: `ProfileViews` ONLY.** ⭐ **`ProfileViews` is the FIRST `CertifiedMetric` instance named anywhere in this repository** — BC Map **L385** established the *class*, but no *instance* had ever been defined, so the ADR **exercises** `BC-26`'s existing ownership rather than extending it. **It is therefore DECLARATORY and amends nothing**: ⛔ **`PRD-009` is NOT created and remains `PLANNED`** — it *"is not obsolete… remains the registered home"* — and ⛔ the BC Map is not touched by it. ⭐ All six required properties are defined under `BC-26` authority: **authoritative definition** · **counting rule** (one fact = one; counts *events*, not viewers) · **duplicate handling** — ⛔ **NO viewer-level deduplication, forced by `ADR-0096` §4.2**, with only two non-identity exclusions (transport duplicates by event-identity idempotency; non-render requests), so **`ProfileViews` is an impression count** · **bot handling `B1`–`B5`** (⭐ `B5` answers C3's own open question: the owner's own visits **count by default**, the honest answer, since excluding them requires the identity the payload forbids; ⚠ `B4`'s method is deliberately left UNSPECIFIED as a disclosed residue) · **trend period `T1`–`T5`** (rolling 7-day vs preceding non-overlapping 7-day is the **only** certified comparison; ⛔ omit on insufficient data, **never** `0%`, `—` or *"new"*) · **privacy `P1`–`P7`**. ⭐ **§4.3 binds the LABEL to the definition** — it MUST read **views**; ⛔ never *visitors*, *people*, *unique visitors*, *users*, *viewers*, *reach* or *audience*. ⛔⛔ **`UniqueViewers` is NOT certified**, on four grounds — chiefly that it is **not computable from the certified input**, and making it computable would require breaking a privacy rule. `U1`–`U8` require it be **OMITTED**, and ⛔ **NOT displayed as zero, unknown, a placeholder, *"coming soon"*, disabled, greyed, blurred, locked, a teaser, an upsell, or approximated/estimated/modelled/inferred**; ⛔ C3 must not compute uniqueness itself; ⚠ `U8` keeps it **CONDITIONAL, not forbidden forever**. ⭐ **This resolves `LPP-FR-036` to *omit* by supplying the fact its condition was waiting on** — the two `007` decisions are **consistent by construction, not by coincidence**. ⚠ `P7`: **no Privacy Owner review is asserted** — the office is constituted but **VACANT** (`PRD_OWNERSHIP_MODEL.md` **L509**), and **`XPC-CONF-013` is NOT resolved by this** |
| ⚠ *(register note)* | **`XPC-OD-007` is recorded above as its two constituent parts `007A` and `007B`, and this is NOT the minting of two new identifiers.** The A/B split is the one `PRD-021C_OWNER_DECISION_FORM.md` §4/§5 itself put to the owner, precisely because the two halves have **different owners** — `007A` is an Architecture Owner act, `007B` a joint Product/Architecture act — and could lawfully have been answered differently. ⭐ **They were in fact answered differently in character**: `007A` **created** an event and an edge; `007B` **refused** a metric. The `XPC-OD-*` register at **L77** therefore still counts **7** decisions, `XPC-OD-001`…`XPC-OD-007`, with `007` carrying two parts. ⚠ **The prior single-row wording is superseded in scope, not deleted** — its measurements (no view event existed; `E-26` was the only edge into `BC-26`) were **true when written** and are the very evidence `ADR-0096` §1.1 relies on | — | — | — |

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
| Every integration edge exists in §7 | BC Map §7 **+ §17** | ✅ **SATISFIED** *(was ⚠ PARTIAL)* | ⭐ **Repaired by amendment, not by waiver** — which is what the prior *"recorded as blocking, not waived"* was holding the line for. 5 wildcard edges ✅; **`E-21`** now enumerates `BC-19` (**L330**, `ADR-0093`) and **`E-22`** now enumerates `BC-19` and `BC-25` (**L331**, `ADR-0095`); the profile-view fact travels the **new `E-30`** declared at **§17.1** (`ADR-0096`). ⚠ **`E-30` is declared in §17, not §7** — an *append* rather than an edit, so the 1,293 existing §7 line citations shift by **zero**; §17's own preamble states it is a **normative extension of §7 and §9**. ⚠ **§7.5's derived statistics are knowingly stale** (they count 28 edges and 7 `PL`); the true totals — **29** and **8** — are stated at **§17.3** and the §7 cells were deliberately left untouched to preserve that byte-identity |
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
| C2 | 32 | 16 | 32 | **100%** | ⭐ **0** *(was 8, on `XPC-OD-001` + `XPC-OD-002` — both now RESOLVED by `ADR-0093`/`ADR-0094`)* |
| C3 | 44 | 22 | 44 | **100%** | ⭐ **0** *(was 19 — 4 on `XPC-OD-003`, RESOLVED by `ADR-0095`; 15 on `XPC-OD-007`, RESOLVED by `ADR-0096`+`ADR-0097`)*. ⚠ **`LPP-FR-036` is UNBLOCKED but its outcome is OMISSION**: `UniqueViewers` is ⛔ **not certified**, so the requirement now has a determinate answer rather than a pending one — **unblocked is not the same as displayed** |
| C4 | 36 | 18 | 36 | **100%** | 0 |
| **Total** | **136** | **68** | **136** | **100%** | ⭐ **0** *(was 27)* |

⚠⚠ **Two disclosures this table must carry, or it would overstate itself:**

1. **"Coverage" means every FR is named by at least one AC.** It does **not**
   mean an AC is *proven*. **0 of 60** ACs is proven by a test — **no test
   exists**, and no `lib/` or `test/` code is created by this draft.
2. ⭐ **UPDATED 2026-09-02: ZERO FRs remain conditional on an OPEN decision.** All
   **27** previously-blocked requirements are unblocked by `ADR-0093`…`ADR-0097`.
   ⛔ **Unblocking is NOT approval and NOT implementability.** `PRD-021C` is still
   **Stage 2**, still has **no Stage-3 alignment record**, and still has **0** proven
   ACs and **0** `IMPL-*` identifiers, so nothing here may be built. ⚠ **And one
   unblocked requirement resolves to a REFUSAL rather than a feature**:
   `LPP-FR-036` `UniqueViewers` is ⛔ **not certified** and must be **omitted** —
   counted here as unblocked because it now has a determinate answer, which is
   the honest reading and not a softening of it. *(Prior text, retained verbatim:
   **"12 of 120 FRs are conditional on an OPEN decision** and cannot be
   implemented until `XPC-OD-001`, `XPC-OD-002` or `XPC-OD-003` is resolved by
   its owner."* ⚠ Note that sentence said **12 of 120** while the table beside it
   totalled **27 of 136** — a pre-existing internal disagreement now moot at zero,
   and recorded rather than erased.)

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
| **Open decisions** | **7 registered** — `XPC-OD-001` … `XPC-OD-007` (agrees with the §2 register at **L77**, which is **unchanged**) — of which ⭐ **5 are now ✅ RESOLVED** (`001`=A, `002`=A, `003`=C, `007A`=C, `007B`=B, by `ADR-0093`…`ADR-0097`) and ⛔ **3 remain OPEN: `XPC-OD-004`, `XPC-OD-005`, `XPC-OD-006`**. ⚠ **5 + 3 = 8 against 7 registered identifiers, and that is not an error**: `XPC-OD-007` is answered in **two parts** (`007A` producer/edge, `007B` metric certification) because the form put them separately to **different owners**; ⛔ **no new `XPC-OD-*` identifier was minted** |
| **Conflicts recorded** | **15** — ⭐ **13 resolved · 0 partially resolved · 2 deferred** *(was 9 · 1 · 5)*; `XPC-CONF-004`/`005`/`007` resolved by `ADR-0093`/`0094`/`0095`, `XPC-CONF-015` completed by `ADR-0096`+`ADR-0097`. ⛔ **`XPC-CONF-013`** (Privacy Owner **VACANT**) **and `XPC-CONF-014`** (EA staleness) **stay OPEN.** Agrees with **L77** and the re-derived §5 tally |
| **ADRs created** | ⭐ **5 — `ADR-0093`, `ADR-0094`, `ADR-0095`, `ADR-0096`, `ADR-0097`** *(was ⛔ 0)*. ⛔ **Not created by this draft** — created by the **Architecture Owner** and, for `ADR-0094`/`ADR-0097`, the **Product Owner jointly**, on explicit conferral from the human principal; this document reports them. ⛔ **`ADR-0088`, `ADR-0089` and `ADR-0090` were NOT consumed** — they are **reserved and unwritten** for `PRD-021B` B0–B3's `FOD-1`/`FOD-2`, which is why numbering opened at `0093`. ⭐ **Two of the five (`ADR-0094`, `ADR-0097`) amend nothing at all and are declaratory** |
| **Bounded contexts created** | ⛔ **0.** Count remains **31** (23 in V1) — ⭐ **unchanged by all five decisions**, which is the point: each reused an **existing** context rather than minting one. ⛔ No `BC-32` |
| **Integration edges created** | ⭐ **1 — `E-30`** (`BC-19 → BC-26`, `PL`, Event, V1), by `ADR-0096`, appended as BC Map **§17.1** *(was ⛔ 0)*. **Edge count 28 → 29.** ⛔ **`E-27` is STILL permanently vacant and was NOT reused** — withdrawn by `ADR-0033`, and `PRD_LIFECYCLE.md` §5 rule 5 forbids reuse *"even after withdrawal"*; `E-28`/`E-29` already existed, so `E-30` is the next lawful number. ⚠ `ADR-0093` and `ADR-0095` created **0** edges between them — they amended the **cells** of `E-21` and `E-22` |
| **Published events minted** | ⭐ **1 — `tenancy.LibraryProfileViewed`**, producer **`BC-19 Tenancy`**, consumer `BC-26`, by `ADR-0096` (BC Map **§17.2**) *(was ⛔ 0)*. ⭐ The name was **derived** from §9's binding convention `<Context>.<Aggregate><PastTenseVerb>`, ⛔ never an imperative. ⛔ **It carries no viewer identity and no count, total or trend** — a **fact**, not an analytics-derived duplicate. ⛔ **Minted by the Architecture Owner in the BC Map, NOT by any C-part**; `LPP-XC-011`…`014` remain in force and C3 remains render-only |
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
| **v0.2** | 2026-09-02 | Updated for **C3 v0.2 §9A** (Owner Profile Engagement Summary). Added **`XPC-CONF-015`** (analytics ownership reconciled to the **existing** `BC-26` / `PRD-009` owners — nothing invented) and **`XPC-OD-007`** (no profile-view event producer and no lawful edge into `BC-26`). Register totals **246 → 279**, disclosed in §1.1 rather than silently restated; **246** remains correct for the C1–C4 baseline at `21704ba`. Conflict register **14 → 15**; open decisions **6 → 7**. ⛔ Still no ADR, no edge, no context, no event, no metric definition, no analytics system, no `IMPL-*`, no Rank 1–6 edit, no freeze. `BC-17` unchanged; C1, C2, C4 unchanged |
| **v0.2b** | 2026-09-02 | ⭐⭐ **FIVE OWNER DECISIONS EXECUTED — the blockers are removed by authority, not by assumption.** The human principal explicitly conferred, and the named owners exercised: **`XPC-OD-001` = A** ([`ADR-0093`] — `E-21`'s **source** cell admits `BC-19`), **`XPC-OD-002` = A** ([`ADR-0094`] — `Library_PRD_v1.md` **§14A** IS the V1 `BC-23` discovery/query contract, **declaratory**, §14A **byte-unchanged**, index class ruled **Platform Public Discovery Index** per `AR-3`), **`XPC-OD-003` = C** ([`ADR-0095`] — `E-22`'s **consumer** cell admits **both** `BC-19` **and** `BC-25`, each tested separately), **`XPC-OD-007A` = C** ([`ADR-0096`] — event **`tenancy.LibraryProfileViewed`** produced by **`BC-19`** over **new edge `E-30`**, appended as BC Map **§17**), **`XPC-OD-007B` = B** ([`ADR-0097`] — **`ProfileViews` CERTIFIED**, the repository's **first** `CertifiedMetric` instance, with counting rule, duplicate handling, bot handling `B1`–`B5`, trend period `T1`–`T5` and privacy `P1`–`P7`; ⛔ **`UniqueViewers` NOT certified**, `U1`–`U8` require **omission**, ⛔ never zero/unknown/*"coming soon"*/disabled/approximated). **Sections updated:** §5 conflict rows `XPC-CONF-004`/`005`/`007`/`015` and the re-derived tally (**13 · 0 · 2**, was 9 · 1 · 5); §6 preamble and the decision rows, with `XPC-OD-007` reported as its two parts `007A`/`007B` plus a register note; §7 chain row *"Every integration edge exists in §7"* ⚠ PARTIAL → ✅ **SATISFIED**; §8 coverage (blocked **27 → 0**) and disclosure 2; the closing summary block (ADRs **0 → 5**, edges **0 → 1**, events **0 → 1**, contexts **still 0/31**). ⛔⛔ **`XPC-OD-004`, `XPC-OD-005` and `XPC-OD-006` are DELIBERATELY LEFT OPEN and were NOT silently resolved** — no conferral covered them; `XPC-OD-005` still awaits a **Privacy Owner** whose office is **VACANT**, and `XPC-CONF-013` is **not** discharged. ⛔⛔ **NO LIFECYCLE MOVEMENT WHATSOEVER.** `PRD-021C` remains **Stage 2**; ⛔ no Stage-3 alignment record was written, no alignment PASS claimed, no rank assigned, nothing frozen, nothing baselined, nothing approved; **0** `IMPL-*` identifiers and **0** `lib/`/`test/` files. ⭐ **"Unblocked" is not "approved"**, and one unblocked requirement (`LPP-FR-036`) resolves to a **refusal**. ⚠ **Baseline identifier does NOT move** — `BASELINE-2026-09-02-A` stands; the only document amended is the **Rank 4** BC Map (v1.10 → **v1.11**), and `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier only for **Rank 1–3**. ⚠ **Frozen and Rank 1–3 artefacts are byte-unchanged**: `Library_PRD_v1.md` (incl. §14A), `14B`, `MASTER_PRD.md`, `PRD_REGISTRY.md`, `PRD_LIFECYCLE.md`, `ARCHITECTURE_RULINGS.md`, `PRD-007`, `PRD-021B` and `Student_Management_PRD_v1.md` — the last notable because `SM-7.17` was **distinguished on its facts, ⛔ not overruled**. ⚠ **One residue DISCLOSED and NOT resolved: `GAP-BCMAP-BC26-EDGES`** — `BC-26` appears in ~20 BC Map §9 consumer cells with no §7 edge. ⛔ **It was deliberately NOT used as authority for the new fact**, because doing so would have resolved a pre-existing unrelated inconsistency by side effect and rested a new fact on an *absence*; routed to the Architecture Owner (`ADR-0096` §1.2, BC Map §17.4). ⚠ **A second residue disclosed:** BC Map §7.5's derived statistics remain **stale** (28 edges, 7 `PL`); true totals **29** and **8** are stated at §17.3, the §7 cells left untouched to preserve the byte-identity that makes the append method safe. |
| **v0.2a** | 2026-09-02 | ⚠ **Internal-consistency correction only — no decision, no architecture, no lifecycle change.** Three stale self-statements left behind by the v0.2 edit are brought into agreement with this document's own authoritative registers: the header **Version** field `v0.1` → **`v0.2`** (the change-history row above already recorded v0.2); §9's closing **Open decisions** cell `6` → **7**; and §9's closing **Conflicts recorded** cell `14 — 9 resolved, 5 deferred` → **15 — 9 resolved · 1 partially resolved · 5 deferred**. The §2 register at **L76**/**L77** and the §5 disposition line at **L291** were already correct and are **byte-unchanged** — this edit corrects the *summary* to match the *register*, never the reverse. ⛔ **Resolves no open decision**, mints no identifier, creates no ADR, edge, event, context, metric definition or `IMPL-*`, amends no FROZEN or Rank 1–6 artefact, and confers no Stage 3, freeze, approval, baseline or rank. `XPC-OD-001`…`XPC-OD-007` all remain **OPEN** |
