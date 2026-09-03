# `PRD-021C` Local Library Marketplace & Booking — Implementation Tasks

| Field | Value |
|---|---|
| **Document** | `PRD-021C_IMPLEMENTATION_TASKS.md` **v1.0** · 2026-09-03 |
| **Subject** | `PRD-021C` Parts **C0–C8**, v0.1–v0.2c `DRAFT`, as **one consolidated unit** |
| **Stage** | **6 of 9 — Implementation Tasks** (`PRD_LIFECYCLE.md` **L135–L153**) |
| **Range allocated** | **`IMPL-1750` … `IMPL-1793`** — **44** tasks, contiguous, one row per number |
| **Growth reserve** | **`IMPL-1794`…`1849`** — declared reserve, ⛔ **NOT allocated and NOT used** |
| **Authority** | **Implementation lead** (`PRD_LIFECYCLE.md` **L280** — *"Implementation lead \| Stages 6 and 8"*), exercised on the explicit conferral recorded in the gate record §0. ⛔ **This act only** |
| **Prior stage** | Stage 5 registered at [`../TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) **v1.23 §2R**; Stage-5 record `PRD-021C_C0_C8_STAGE5_TRACEABILITY.md`; Stage 4 **PASSED + CONFERRED** |
| **Trace basis** | **123 acceptance criteria**, **0 orphans**, **253** distinct requirements cited — re-measured, not inherited |
| **Code written** | ⛔ **NONE. 0 lines** under `lib/`, `test/`, `web/`, `android/`, `tool/`. Code is **Stage 8** (`PRD_LIFECYCLE.md` **L182**) |
| **Status of this document** | **Unranked.** ⛔ Not admitted to `DOCUMENTATION_BASELINE.md`. Precedence: **none** |

---

## 0. The three rules that shaped this document, stated before the tasks

⭐⭐ **1. The range was measured, not read from the table.** `PRD_LIFECYCLE.md` **L147–153** declares
`IMPL-227`+ *"Unallocated"*. That table is **measurably stale** — the standing finding `S6-F-2` recorded by
`PRD-021B_B0_B9_STAGE6_READINESS_AUDIT.md`, which warns that *"the table cannot be used as the source of the
next free range; the repository must be measured."* It was measured (§1).

⭐⭐ **2. Smallest compatible scope.** One task per coherent, independently verifiable capability — **not** one
task per requirement. 258 obligations became **44** tasks. A 258-row document would be a transcription of the
PRD, not a plan, and would make the traceability table meaningless by making it total.

⭐⭐⭐ **3. No task creates product.** Every task implements a requirement that **already exists** at
Stage 4/5. ⛔ **No task invents an API, event, entity, bounded context, integration edge, requirement or
acceptance criterion**, and no task closes an open decision. Where the PRD's own answer is *"do not build
this"*, the task implements **the refusal** — which is why the C5 group is a set of absence tests rather than
a review feature.

---

## 1. The `IMPL-*` range — measured, then allocated

`PRD_LIFECYCLE.md` **L139–143**, the allocation rules, applied one at a time:

> 1. Take the next free range. **Never reuse or reassign a number.**
> 2. Leave the previous group room to grow contiguously.
> 3. Record `Priority`, `Blocks`, `Blocked by` per task.
> 4. Add a traceability table mapping task groups → requirements → invariants → acceptance.

**The census, published with its rule**, because the rule is what makes the number defensible:

| Measurement | Value |
|---|---|
| Distinct `IMPL-` numbers appearing **anywhere** in tracked files | **890** (`IMPL-13` … `IMPL-1800`) |
| Distinct numbers appearing as an **actual task row** (leading table cell) | **837** |
| ⭐ **Highest number used as a task row** | **`IMPL-1689`** |
| Numbers above 1689 used as a task row | ⭐ **NONE** |
| Numbers above 1689 appearing **only** in prose | **1690, 1700, 1750, 1800** |

⚠⚠ **The distinction that decided the starting number.** A naïve census reports the highest occupied number as
**1800** and would have started this allocation at `IMPL-1801`. Reading those four numbers at their lines shows
that **none of them is a use**: `IMPL-1690` is the *first number of `PRD-021B`'s declared reserve*,
`IMPL-1700`/`1800` are rows in `PRD-021B_IMPLEMENTATION_TASKS.md` **L220–L221** that read *"0 — empty"*, and
`IMPL-1750` is **L236**, which says of itself: *"This row is a declaration that the numbers are free, **not a
use of them**."*

⭐ **So the frontier is:** `PRD-021B` allocated `IMPL-1600`…`1689` and reserved `1690`…`1749`. Rule 2 requires
leaving the previous group room to grow contiguously, so this allocation **clears the whole reserve** and starts
at the first number after it.

| Decision | Value |
|---|---|
| Previous group | `PRD-021B` — allocated `1600`…`1689`, reserved `1690`…`1749` |
| Reserve honoured in full | ✅ **Yes** — ⛔ not encroached by a single number |
| ⭐ **Allocated to `PRD-021C`** | **`IMPL-1750` … `IMPL-1793`** — 44 tasks |
| Growth reserve declared | `IMPL-1794`…`1849` — ⛔ **not allocated**, measured empty |
| Numbers reused or reassigned | ⭐ **0** |

---

## 2. Task groups

| Group | Part | Subject | Tasks | Range | Tier |
|---|---|---|---|---|---|
| **G1** | C1 | Marketplace foundation — tenancy-scoped public read surface | 6 | `IMPL-1750`…`1755` | **V1** |
| **G2** | C2 | Library search & local discovery | 6 | `IMPL-1756`…`1761` | **V1** |
| **G3** | C3 | Library public profile | 7 | `IMPL-1762`…`1768` | **V1** |
| **G4** | C4 | Seat availability presentation & booking initiation | 6 | `IMPL-1769`…`1774` | **V1** |
| **G5** | C5 | Ratings & reviews — **absence discipline** | 4 | `IMPL-1775`…`1778` | ⛔ **V2 feature; V1 absence tests** |
| **G6** | C6 | Discovery presentation & ordering | 5 | `IMPL-1779`…`1783` | **V1** |
| **G7** | C7 | Trust & safety integration | 5 | `IMPL-1784`…`1788` | **V1** |
| **G8** | C8 | Technical & production architecture | 5 | `IMPL-1789`…`1793` | **V1** |
| | | **Total** | **44** | `IMPL-1750`…`1793` | |

---

## 3. The tasks

⭐ Every task carries all nine required fields. **Trace** cites requirements and acceptance criteria that exist
at Stage 5; **Boundary** states what the task may **not** touch, because on a marketplace that composes five
foreign contexts the boundary is the load-bearing field.

### G1 — C1 Marketplace foundation (`LMP-*`, V1)

#### `IMPL-1750` — Tenancy-scoped public read projection

| Field | Value |
|---|---|
| **Trace** | `LMP-FR-001`, `LMP-FR-002`, `LMP-FR-003` · AC `LMP-AC-001`, `LMP-AC-012` |
| **Purpose / scope** | Build the read-only projection that exposes only libraries a tenant has published, keyed by tenant, for anonymous consumption |
| **Owning BC** | ⭐ **`BC-19`** Tenancy / Library organisation — **consumed, not owned** by `PRD-021C` |
| **Dependencies** | `BC-19` tenant lifecycle events; none within this range |
| **Acceptance / verification** | `LMP-AC-001` proven by test; a request scoped to tenant A returns **0** rows belonging to tenant B |
| **Implementation boundary** | ⛔ MUST NOT define tenancy, provision tenants, or alter `BC-19` schema. Read projection only |
| **Required tests** | Unit (projection filter) · integration (cross-tenant isolation) · **architecture test asserting no write path into `BC-19`** |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** `IMPL-1751`…`1755`, G2, G3, G4 · **Blocked by** — |

#### `IMPL-1751` — Anonymous access surface with no identity leakage

| Field | Value |
|---|---|
| **Trace** | `LMP-FR-004`…`LMP-FR-008` · `LMP-XC-001`, `LMP-XC-002` · AC `LMP-AC-002`, `LMP-AC-003` |
| **Purpose / scope** | Expose the public surface to unauthenticated callers while guaranteeing no person, student or member identifier is emitted |
| **Owning BC** | **`BC-10`** Person / Identity — ⛔ **read-avoidance only**; the surface must not consult it |
| **Dependencies** | `IMPL-1750` |
| **Acceptance / verification** | `LMP-AC-002` and `LMP-AC-003` proven; response schema contains **0** identity fields |
| **Implementation boundary** | ⛔ MUST NOT authenticate, create sessions, or read `BC-10`. Identity is `BC-10`'s and is not modelled here |
| **Required tests** | Contract test on response schema · negative test asserting identity fields absent |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** G2, G3 · **Blocked by** `IMPL-1750` |

#### `IMPL-1752` — Public field whitelist and projection contract

| Field | Value |
|---|---|
| **Trace** | `LMP-FR-009`…`LMP-FR-014` · `LMP-XC-003`, `LMP-XC-004` · AC `LMP-AC-004`, `LMP-AC-005` |
| **Purpose / scope** | Declare, in code, the closed set of fields publishable on the marketplace, so that adding a field is a deliberate act |
| **Owning BC** | **`BC-19`** (source of record) |
| **Dependencies** | `IMPL-1750` |
| **Acceptance / verification** | `LMP-AC-004` proven; a field added to the source model does **not** appear publicly without an explicit whitelist entry |
| **Implementation boundary** | ⛔ MUST NOT widen the whitelist beyond the fields C1 enumerates. Widening is a **PRD amendment**, not a code change |
| **Required tests** | Golden-file test on the whitelist · test that an unlisted field is dropped |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** `IMPL-1762` · **Blocked by** `IMPL-1750` |

#### `IMPL-1753` — Error responses that disclose nothing internal

| Field | Value |
|---|---|
| **Trace** | `LMP-FR-015`…`LMP-FR-018` · `LMP-XC-005`, `LMP-XC-006` · AC `LMP-AC-006`, `LMP-AC-012` |
| **Purpose / scope** | Uniform public error shape carrying no internal identifier, table name, query fragment, stack trace or configuration value, and no tenant count or creation order |
| **Owning BC** | `PRD-021C` application layer (module 19 composition) |
| **Dependencies** | `IMPL-1751` |
| **Acceptance / verification** | `LMP-AC-012` proven verbatim — the Then-clause is already written as a test |
| **Implementation boundary** | ⛔ MUST NOT add a debug or verbose mode reachable in production |
| **Required tests** | Test per error class asserting the forbidden-content list is absent |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1751` |

#### `IMPL-1754` — Publication state gate

| Field | Value |
|---|---|
| **Trace** | `LMP-FR-019`…`LMP-FR-022` · `LMP-XC-007`, `LMP-XC-008` · AC `LMP-AC-007`, `LMP-AC-008` |
| **Purpose / scope** | Only an explicitly published, non-suspended library is visible; suspension removes it from the surface |
| **Owning BC** | **`BC-19`** — consumes `tenancy.TenantSuspended` |
| **Dependencies** | `IMPL-1750` |
| **Acceptance / verification** | `LMP-AC-007` proven; a suspended tenant's libraries return **0** results |
| **Implementation boundary** | ⛔ MUST NOT define suspension semantics or emit tenancy events — `BC-19` owns both |
| **Required tests** | Integration test across publish → suspend → republish |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** G2, G6 · **Blocked by** `IMPL-1750` |

#### `IMPL-1755` — Marketplace read caching with correctness bound

| Field | Value |
|---|---|
| **Trace** | `LMP-FR-023`, `LMP-FR-024` · `LMP-XC-009`, `LMP-XC-010` · AC `LMP-AC-009`, `LMP-AC-010`, `LMP-AC-011` |
| **Purpose / scope** | Cache the public read surface without allowing a suspended or unpublished library to be served from cache |
| **Owning BC** | `PRD-021C` application layer |
| **Dependencies** | `IMPL-1754` |
| **Acceptance / verification** | `LMP-AC-009` proven; invalidation on suspension is bounded and tested |
| **Implementation boundary** | ⛔ MUST NOT cache identity, seat state or booking data |
| **Required tests** | Cache-invalidation test · staleness-bound test |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1754` |

### G2 — C2 Library search & local discovery (`LSD-*`, V1)

#### `IMPL-1756` — `BC-23` query adapter

| Field | Value |
|---|---|
| **Trace** | `LSD-FR-001`…`LSD-FR-006` · AC `LSD-AC-001`, `LSD-AC-016` |
| **Purpose / scope** | Adapter issuing marketplace search queries to `BC-23` and mapping results to the public projection |
| **Owning BC** | ⭐ **`BC-23`** Search / Ranking — **owns querying, indexing, analysis and ranking** |
| **Dependencies** | `IMPL-1750`, `IMPL-1751` |
| **Acceptance / verification** | `LSD-AC-001` proven against a `BC-23` contract double |
| **Implementation boundary** | ⛔⛔ MUST NOT implement ranking, scoring, tokenisation, stemming or an analyzer. ⚠ `XPC-OD-002` records that the `BC-23` query contract is **unspecified** (`PRD-015` absent) — the adapter is written against C2's stated contract and **MUST NOT invent** the provider's API |
| **Required tests** | Contract test · architecture test asserting no ranking logic in `PRD-021C` |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** `IMPL-1757`…`1761` · **Blocked by** `IMPL-1751` |

#### `IMPL-1757` — Geographic / local filtering

| Field | Value |
|---|---|
| **Trace** | `LSD-FR-007`…`LSD-FR-013` · `LSD-XC-001`…`LSD-XC-003` · AC `LSD-AC-002`, `LSD-AC-003` |
| **Purpose / scope** | Filter results to a locality as C2 defines it |
| **Owning BC** | **`BC-23`** (execution) · `PRD-021C` (request shaping) |
| **Dependencies** | `IMPL-1756` |
| **Acceptance / verification** | `LSD-AC-002` proven; out-of-area libraries excluded |
| **Implementation boundary** | ⛔ MUST NOT store or infer a searcher's precise location beyond what C2 permits |
| **Required tests** | Boundary tests at the locality edge |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** `IMPL-1779` · **Blocked by** `IMPL-1756` |

#### `IMPL-1758` — Facet and filter surface

| Field | Value |
|---|---|
| **Trace** | `LSD-FR-014`…`LSD-FR-019` · `LSD-XC-004`, `LSD-XC-005` · AC `LSD-AC-004`, `LSD-AC-005` |
| **Purpose / scope** | Expose only the facets C2 enumerates, each derived from whitelisted public fields |
| **Owning BC** | **`BC-23`** |
| **Dependencies** | `IMPL-1756`, `IMPL-1752` |
| **Acceptance / verification** | `LSD-AC-004` proven; no facet exposes a non-whitelisted field |
| **Implementation boundary** | ⛔ MUST NOT add a facet over ratings — ratings are **V2** (see G5) |
| **Required tests** | Facet-inventory test · negative test for a ratings facet |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1756` |

#### `IMPL-1759` — Result pagination and stable ordering

| Field | Value |
|---|---|
| **Trace** | `LSD-FR-020`…`LSD-FR-025` · `LSD-XC-006`…`LSD-XC-008` · AC `LSD-AC-006`, `LSD-AC-007` |
| **Purpose / scope** | Deterministic, stable pagination that does not duplicate or drop results between pages |
| **Owning BC** | **`BC-23`** |
| **Dependencies** | `IMPL-1756` |
| **Acceptance / verification** | `LSD-AC-006` proven; full pagination sweep yields each result exactly once |
| **Implementation boundary** | ⛔ MUST NOT re-rank between pages in the application layer |
| **Required tests** | Property test over a full sweep |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** `IMPL-1780` · **Blocked by** `IMPL-1756` |

#### `IMPL-1760` — Empty and degraded search states

| Field | Value |
|---|---|
| **Trace** | `LSD-FR-026`…`LSD-FR-029` · `LSD-XC-009`, `LSD-XC-010` · AC `LSD-AC-008`…`LSD-AC-010` |
| **Purpose / scope** | Explicit, honest presentation when there are no results or the provider is unavailable |
| **Owning BC** | `PRD-021C` application layer |
| **Dependencies** | `IMPL-1756` |
| **Acceptance / verification** | `LSD-AC-008` proven; a provider outage never renders as "no libraries exist" |
| **Implementation boundary** | ⛔ MUST NOT substitute cached or fabricated results for a failed query |
| **Required tests** | Fault-injection test on the provider |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1756` |

#### `IMPL-1761` — Public search input hardening

| Field | Value |
|---|---|
| **Trace** | `LSD-FR-030`…`LSD-FR-032` · `LSD-XC-011`, `LSD-XC-012` · AC `LSD-AC-011`…`LSD-AC-016` |
| **Purpose / scope** | Bound query length, reject control characters, and neutralise injection into the provider |
| **Owning BC** | `PRD-021C` application layer |
| **Dependencies** | `IMPL-1756` |
| **Acceptance / verification** | `LSD-AC-016` proven; malformed input yields a bounded error, never a provider error verbatim |
| **Implementation boundary** | ⚠ ⛔ MUST NOT implement keyword-stuffing or bot defence. `XPC-OD-009` (analyzer defence) and `XPC-OD-010` (bot / scraping defence) are **OPEN with owners named** — building either here would answer an open decision by code |
| **Required tests** | Fuzz test on the input surface |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1756` |

### G3 — C3 Library public profile (`LPP-*`, V1)

#### `IMPL-1762` — Public profile read model

| Field | Value |
|---|---|
| **Trace** | `LPP-FR-001`…`LPP-FR-008` · AC `LPP-AC-001`, `LPP-AC-002` |
| **Purpose / scope** | Assemble the public profile from whitelisted `BC-19` fields |
| **Owning BC** | **`BC-19`** |
| **Dependencies** | `IMPL-1752` |
| **Acceptance / verification** | `LPP-AC-001` proven |
| **Implementation boundary** | ⛔ MUST NOT expose per-seat identity or live occupancy — `SEAT-XC-009` (**FROZEN**, `PRD-007`) forbids it in V1 |
| **Required tests** | Contract test · negative test for seat-level fields |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** `IMPL-1763`…`1768` · **Blocked by** `IMPL-1752` |

#### `IMPL-1763` — Profile media gallery via `FileRef`

| Field | Value |
|---|---|
| **Trace** | `LPP-FR-014`…`LPP-FR-017` · `LPP-XC-004`, `LPP-XC-005` · AC `LPP-AC-005`, `LPP-AC-006` |
| **Purpose / scope** | Render gallery and branding media as `FileRef`s over the declared edge |
| **Owning BC** | **`BC-25`** File / Media (owner) · `BC-19` (referencing aggregate) |
| **Dependencies** | `IMPL-1762` |
| **Acceptance / verification** | `LPP-AC-005` proven; media served only as a `FileRef`, never an internal path |
| **Implementation boundary** | ⭐ Lawful because `XPC-OD-003` is **RESOLVED by `ADR-0095`**. ⛔ MUST NOT store media, create a new edge, or bypass `BC-25` |
| **Required tests** | Integration test on `FileRef` resolution · negative test for raw paths |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1762` |

#### `IMPL-1764` — Amenities, policies and opening hours

| Field | Value |
|---|---|
| **Trace** | `LPP-FR-009`…`LPP-FR-013` · `LPP-XC-001`…`LPP-XC-003` · AC `LPP-AC-003`, `LPP-AC-004` |
| **Purpose / scope** | Present amenity, policy and hours data as published by the library |
| **Owning BC** | **`BC-19`** · `BC-06` Library Policy (source of policy) |
| **Dependencies** | `IMPL-1762` |
| **Acceptance / verification** | `LPP-AC-003` proven |
| **Implementation boundary** | ⛔ MUST NOT author, validate or interpret policy semantics — `BC-06` owns them |
| **Required tests** | Rendering test · pass-through fidelity test |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1762` |

#### `IMPL-1765` — Profile-view fact emission over `E-30`

| Field | Value |
|---|---|
| **Trace** | `LPP-FR-033`…`LPP-FR-035` · `LPP-XC-013`, `LPP-XC-014` · AC `LPP-AC-016`, `LPP-AC-017` |
| **Purpose / scope** | Emit `tenancy.LibraryProfileViewed` — the **fact** that a profile was rendered — to `BC-26` |
| **Owning BC** | ⭐ **`BC-19`** emits · **`BC-26`** Analytics consumes, over the **existing** edge **`E-30`** |
| **Dependencies** | `IMPL-1762` |
| **Acceptance / verification** | `LPP-AC-016` proven; exactly one fact per rendered profile |
| **Implementation boundary** | ⛔⛔ MUST NOT carry a count, total, trend or comparison — BC Map **L899** restricts the event to the bare fact, and aggregation is **`BC-26`'s**. ⛔ MUST NOT create an edge; `E-30` already exists (`ADR-0096`/`ADR-0097`). ⭐ Edge set stays **29** |
| **Required tests** | Event-schema test asserting no aggregate fields · architecture test asserting no new edge |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** `IMPL-1766` · **Blocked by** `IMPL-1762` |

#### `IMPL-1766` — View metrics presented as uncertified, or omitted

| Field | Value |
|---|---|
| **Trace** | `LPP-FR-036` · `LPP-XC-015` · AC `LPP-AC-018` |
| **Purpose / scope** | Implement the **omission** outcome: `UniqueViewers` is not a `CertifiedMetric`, so it is **not displayed** |
| **Owning BC** | **`BC-26`** Analytics |
| **Dependencies** | `IMPL-1765` |
| **Acceptance / verification** | `LPP-AC-018` proven; `UniqueViewers` renders **nowhere** |
| **Implementation boundary** | ⚠ `XPC-OD-007B` is **RESOLVED IN PART** — `ProfileViews` certified, `UniqueViewers` ⛔ **not certified**. MUST NOT compute, estimate or display an uncertified metric, and ⛔ MUST NOT certify one — certification is `BC-26`'s |
| **Required tests** | Negative rendering test for `UniqueViewers` |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1765` |

#### `IMPL-1767` — Profile not-found and unpublished states

| Field | Value |
|---|---|
| **Trace** | `LPP-FR-018`…`LPP-FR-024` · `LPP-XC-006`…`LPP-XC-009` · AC `LPP-AC-007`…`LPP-AC-011` |
| **Purpose / scope** | Uniform response for missing, unpublished or suspended profiles that does not disclose existence |
| **Owning BC** | `PRD-021C` application layer |
| **Dependencies** | `IMPL-1762`, `IMPL-1754` |
| **Acceptance / verification** | `LPP-AC-008` proven; an unpublished and a non-existent profile are **indistinguishable** to the caller |
| **Implementation boundary** | ⛔ MUST NOT vary status code, latency or message between the two cases |
| **Required tests** | Equivalence test across both cases |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1762` |

#### `IMPL-1768` — Public profile text sanitisation

| Field | Value |
|---|---|
| **Trace** | `LPP-FR-025`…`LPP-FR-032` · `LPP-XC-010`…`LPP-XC-012` · AC `LPP-AC-012`…`LPP-AC-015`, `LPP-AC-019`…`LPP-AC-022` |
| **Purpose / scope** | Escape and bound library-authored free text so no markup or script reaches the public surface |
| **Owning BC** | `PRD-021C` application layer |
| **Dependencies** | `IMPL-1762` |
| **Acceptance / verification** | `LPP-AC-012` proven; injected markup renders inert |
| **Implementation boundary** | ⛔ MUST NOT moderate content — moderation is `BC-13`/`PRD-020` (see G7) |
| **Required tests** | XSS corpus test · length-bound test |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1762` |

### G4 — C4 Seat availability & booking initiation (`LSB-*`, V1)

#### `IMPL-1769` — Coarse availability projection

| Field | Value |
|---|---|
| **Trace** | `LSB-FR-001`…`LSB-FR-007` · AC `LSB-AC-001`, `LSB-AC-018` |
| **Purpose / scope** | Present availability at the coarse granularity C4 permits, sourced from `BC-04` |
| **Owning BC** | ⭐ **`BC-04`** Seating / availability — **the authority** |
| **Dependencies** | `IMPL-1750` |
| **Acceptance / verification** | `LSB-AC-001` proven |
| **Implementation boundary** | ⛔⛔ MUST NOT expose per-seat identity, per-seat state or live occupancy — `SEAT-XC-009` (**FROZEN**, `PRD-007`) forbids it in V1. ⛔ MUST NOT model seats |
| **Required tests** | Contract test · negative test for per-seat fields |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** `IMPL-1770`…`1774` · **Blocked by** `IMPL-1750` |

#### `IMPL-1770` — Booking initiation handoff to `BC-04`

| Field | Value |
|---|---|
| **Trace** | `LSB-FR-008`…`LSB-FR-014` · `LSB-XC-001`…`LSB-XC-004` · AC `LSB-AC-002`…`LSB-AC-004` |
| **Purpose / scope** | Initiate a booking from the public surface and **hand off** to `BC-04`, which performs it |
| **Owning BC** | ⭐ **`BC-04`** performs the booking · **`PRD-007`** (**FROZEN**) owns booking semantics |
| **Dependencies** | `IMPL-1769`, `IMPL-1751` |
| **Acceptance / verification** | `LSB-AC-002` proven; the handoff is observable and idempotent |
| **Implementation boundary** | ⛔⛔ MUST NOT implement booking, holds, reservation expiry, conflict resolution or seat assignment. C4 **L100**: *"C4 defines no booking — `PRD-007` already owns it, frozen."* Recorded as `XPC-CONF-008` |
| **Required tests** | Integration test on handoff · **architecture test asserting no booking state machine in `PRD-021C`** |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** `IMPL-1771`, `IMPL-1772` · **Blocked by** `IMPL-1769` |

#### `IMPL-1771` — Membership eligibility check before initiation

| Field | Value |
|---|---|
| **Trace** | `LSB-FR-015`…`LSB-FR-021` · `LSB-XC-005`…`LSB-XC-007` · AC `LSB-AC-005`…`LSB-AC-007` |
| **Purpose / scope** | Consult `BC-02` Membership so an ineligible caller is refused before any `BC-04` handoff |
| **Owning BC** | **`BC-02`** Membership (authority) |
| **Dependencies** | `IMPL-1770` |
| **Acceptance / verification** | `LSB-AC-005` proven; ineligible callers produce **0** handoffs |
| **Implementation boundary** | ⛔ MUST NOT define membership tiers, entitlements or eligibility rules — `BC-02` owns them |
| **Required tests** | Integration test over eligible / ineligible / unknown |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1770` |

#### `IMPL-1772` — Booking initiation failure and refusal states

| Field | Value |
|---|---|
| **Trace** | `LSB-FR-022`…`LSB-FR-028` · `LSB-XC-008`…`LSB-XC-011` · AC `LSB-AC-008`…`LSB-AC-012` |
| **Purpose / scope** | Present refusals and provider failures honestly, without leaking seat-level detail |
| **Owning BC** | `PRD-021C` application layer |
| **Dependencies** | `IMPL-1770` |
| **Acceptance / verification** | `LSB-AC-008` proven; a `BC-04` outage never renders as "no availability" |
| **Implementation boundary** | ⛔ MUST NOT retry in a way that creates duplicate bookings |
| **Required tests** | Fault-injection · duplicate-suppression test |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1770` |

#### `IMPL-1773` — Availability staleness disclosure

| Field | Value |
|---|---|
| **Trace** | `LSB-FR-029`…`LSB-FR-033` · `LSB-XC-012`, `LSB-XC-013` · AC `LSB-AC-013`…`LSB-AC-015` |
| **Purpose / scope** | Disclose that coarse availability is point-in-time, not live |
| **Owning BC** | **`BC-04`** (source) · `PRD-021C` (presentation) |
| **Dependencies** | `IMPL-1769` |
| **Acceptance / verification** | `LSB-AC-013` proven; the surface never implies live occupancy |
| **Implementation boundary** | ⛔ MUST NOT reduce the staleness window to simulate a live feed. Public Live Occupancy is excluded from V1, and `XPC-OD-005` requires a privacy review whose owner role is **VACANT** |
| **Required tests** | Presentation test on the disclosure string |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1769` |

#### `IMPL-1774` — Offline booking queue explicitly excluded

| Field | Value |
|---|---|
| **Trace** | `LSB-FR-034`…`LSB-FR-036` · `LSB-XC-014` · AC `LSB-AC-016`, `LSB-AC-017` |
| **Purpose / scope** | Implement the exclusion: no offline queue exists, and the surface says so rather than failing opaquely |
| **Owning BC** | **`BC-04`** |
| **Dependencies** | `IMPL-1770` |
| **Acceptance / verification** | `LSB-AC-016` proven; **0** queue artefacts exist |
| **Implementation boundary** | ⛔ MUST NOT build a queue. `XPC-OD-004` asks whether `BC-04` should become an `E-24` consumer to enable one; it is **not requested and not required for V1**, and building it would answer an open decision by code |
| **Required tests** | Negative test asserting no queue endpoint |
| **Status** | **V1** — ⭐ exclusion |
| **Priority** | **P2** · **Blocks** — · **Blocked by** `IMPL-1770` |

### G5 — C5 Ratings & reviews (`LRR-*`) — ⛔ **V2 feature, V1 absence discipline**

⛔⛔ **No rating or review capability is built by any task in this group, and that is the requirement — not a
limitation of this plan.** Two independent **FROZEN** authorities tier the feature at **V2**:
`Library_PRD_v1.md` **L1016** (*"Reviews & Ratings | **V2** | New context; not in the V1 31"*) and
`ARCHITECTURE_RULINGS.md` **§6 L291**. C5 **L46** states it directly: *"The rating/review capability is **NOT
V1**."* `XPC-OD-008` asks whether to re-tier it; it is **OPEN**, owned by the **Product Owner**, and a tier
change is a **Rank 3 amendment**. ⭐ **The instruction's constraint and the repository agree**; nothing here
depends on the instruction alone.

#### `IMPL-1775` — Rating and review surfaces provably absent

| Field | Value |
|---|---|
| **Trace** | `LRR-FR-001`…`LRR-FR-006` · `LRR-XC-001`…`LRR-XC-004` · AC `LRR-AC-001`…`LRR-AC-003` |
| **Purpose / scope** | Automated proof that no rating value, review text, star widget, score or aggregate is rendered anywhere on the marketplace |
| **Owning BC** | ⛔ **NONE** — no context is created. Context count stays **31** |
| **Dependencies** | G1, G3 |
| **Acceptance / verification** | `LRR-AC-001` proven; **0** rating/review fields across every public response |
| **Implementation boundary** | ⛔⛔ MUST NOT create a reviews context, entity, table, endpoint or event |
| **Required tests** | Repository-wide absence test · response-schema sweep |
| **Status** | ⛔ **V1 absence test for a V2 feature** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1762` |

#### `IMPL-1776` — Absence presented deliberately, not as an error

| Field | Value |
|---|---|
| **Trace** | `LRR-FR-007`…`LRR-FR-012` · `LRR-XC-005`…`LRR-XC-009` · AC `LRR-AC-004`…`LRR-AC-006` |
| **Purpose / scope** | Where a reviews affordance would sit, present nothing — no empty state, "0 reviews", or "coming soon" |
| **Owning BC** | ⛔ **NONE** |
| **Dependencies** | `IMPL-1775` |
| **Acceptance / verification** | `LRR-AC-004` proven; no placeholder text exists |
| **Implementation boundary** | ⛔ MUST NOT imply a future feature in the UI — that would pre-announce a Product Owner decision |
| **Required tests** | Rendering test asserting no placeholder |
| **Status** | ⛔ **V1 absence test** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1775` |

#### `IMPL-1777` — No ordering, ranking or filtering by reputation

| Field | Value |
|---|---|
| **Trace** | `LRR-FR-013`…`LRR-FR-016` · `LRR-XC-010`…`LRR-XC-013` · AC `LRR-AC-007`…`LRR-AC-009` |
| **Purpose / scope** | Prove no ordering or filter input derives from a rating, score or reputation signal |
| **Owning BC** | **`BC-23`** (ordering executes there) |
| **Dependencies** | `IMPL-1758`, `IMPL-1779` |
| **Acceptance / verification** | `LRR-AC-007` proven; **0** reputation inputs in any query |
| **Implementation boundary** | ⛔ MUST NOT add a reputation signal to `BC-23`, which would both build a V2 feature and alter another context |
| **Required tests** | Query-shape test · facet-inventory test |
| **Status** | ⛔ **V1 absence test** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1758` |

#### `IMPL-1778` — Deterministic-absence invariants

| Field | Value |
|---|---|
| **Trace** | `LRR-FR-017`, `LRR-FR-018` · `LRR-BR-001`…`LRR-BR-008` · `LRR-XC-014`…`LRR-XC-016` · AC `LRR-AC-010`…`LRR-AC-012` |
| **Purpose / scope** | Encode C5's business rules as invariants, including `LRR-BR-008`, which records a **satisfied** condition rather than a risk |
| **Owning BC** | ⛔ **NONE** |
| **Dependencies** | `IMPL-1775` |
| **Acceptance / verification** | `LRR-AC-010` proven; every invariant holds **vacuously and provably** (C0 **L500**) |
| **Implementation boundary** | ⛔ MUST NOT reinterpret a satisfied rule as a feature requirement |
| **Required tests** | Invariant suite, one test per `LRR-BR-*` |
| **Status** | ⛔ **V1 absence test** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1775` |

### G6 — C6 Discovery presentation & ordering (`LDR-*`, V1)

#### `IMPL-1779` — Deterministic default ordering

| Field | Value |
|---|---|
| **Trace** | `LDR-FR-001`…`LDR-FR-007` · `LDR-BR-001`, `LDR-BR-002` · AC `LDR-AC-001`, `LDR-AC-002` |
| **Purpose / scope** | Stable, explainable default order for discovery results |
| **Owning BC** | ⭐ **`BC-23`** Search / Ranking |
| **Dependencies** | `IMPL-1757` |
| **Acceptance / verification** | `LDR-AC-001` proven; identical inputs yield identical order |
| **Implementation boundary** | ⛔⛔ MUST NOT implement a ranking algorithm, relevance model or scoring function in `PRD-021C` |
| **Required tests** | Determinism test · architecture test asserting no scoring code |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** `IMPL-1780`…`1783`, `IMPL-1777` · **Blocked by** `IMPL-1757` |

#### `IMPL-1780` — Result card projection

| Field | Value |
|---|---|
| **Trace** | `LDR-FR-008`…`LDR-FR-014` · `LDR-XC-001`…`LDR-XC-004` · AC `LDR-AC-003`…`LDR-AC-005` |
| **Purpose / scope** | Render each result from whitelisted fields only |
| **Owning BC** | **`BC-19`** (data) · `PRD-021C` (presentation) |
| **Dependencies** | `IMPL-1779`, `IMPL-1752` |
| **Acceptance / verification** | `LDR-AC-003` proven |
| **Implementation boundary** | ⛔ MUST NOT show ratings, per-seat state or identity |
| **Required tests** | Projection test · negative field test |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1779` |

#### `IMPL-1781` — No manipulable ordering inputs

| Field | Value |
|---|---|
| **Trace** | `LDR-FR-015`…`LDR-FR-020` · `LDR-BR-003`…`LDR-BR-006` · `LDR-XC-005`…`LDR-XC-008` · AC `LDR-AC-006`…`LDR-AC-008` |
| **Purpose / scope** | Ensure no library-controlled public text field can influence ordering from the application layer |
| **Owning BC** | **`BC-23`** |
| **Dependencies** | `IMPL-1779` |
| **Acceptance / verification** | `LDR-AC-006` proven; **0** library-authored fields reach the ordering input |
| **Implementation boundary** | ⚠ ⛔ MUST NOT implement analyzer-level anti-stuffing defence. C0 records that the residual route runs through **`BC-23`'s analyzer** and `XPC-OD-009` (*"Who specifies `BC-23`'s defence?"*) is **OPEN** — the answer is `BC-23`'s owner's, not this task's |
| **Required tests** | Ordering-input inventory test |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1779` |

#### `IMPL-1782` — Empty and partial discovery states

| Field | Value |
|---|---|
| **Trace** | `LDR-FR-021`, `LDR-FR-022` · `LDR-BR-007`, `LDR-BR-008` · `LDR-XC-009`…`LDR-XC-012` · AC `LDR-AC-009`…`LDR-AC-011` |
| **Purpose / scope** | Honest presentation of empty and partial result sets |
| **Owning BC** | `PRD-021C` application layer |
| **Dependencies** | `IMPL-1779` |
| **Acceptance / verification** | `LDR-AC-009` proven |
| **Implementation boundary** | ⛔ MUST NOT pad a short result set with out-of-area libraries |
| **Required tests** | Empty-state and partial-state tests |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1779` |

#### `IMPL-1783` — Withdrawn-slot contiguity guard

| Field | Value |
|---|---|
| **Trace** | `LDR-BR-009` · `LDR-XC-008`, `LDR-XC-013`, `LDR-XC-014` · AC `LDR-AC-012`…`LDR-AC-014` |
| **Purpose / scope** | Encode C6's remaining business rules, including the constraint enforced by `LDR-XC-008`'s MUST NOT |
| **Owning BC** | `PRD-021C` application layer |
| **Dependencies** | `IMPL-1779` |
| **Acceptance / verification** | `LDR-AC-012` proven |
| **Implementation boundary** | ⚠ C6's `LDR-FR` register ends at **022**. The **withdrawn** slot **023** is cited in C0 as a bare token (audit item `S4-A-5`, routed to the **Architecture Owner**) — ⛔ **no task implements it, and it is named here by number only** |
| **Required tests** | Invariant suite per `LDR-BR-*` |
| **Status** | **V1** |
| **Priority** | **P2** · **Blocks** — · **Blocked by** `IMPL-1779` |

### G7 — C7 Trust & safety integration (`LTS-*`, V1)

#### `IMPL-1784` — Report intake on public surfaces

| Field | Value |
|---|---|
| **Trace** | `LTS-FR-001`…`LTS-FR-006` · AC `LTS-AC-001`, `LTS-AC-002` |
| **Purpose / scope** | Let a visitor report a library profile or listing, and hand the report to the moderation owner |
| **Owning BC** | ⭐ **`BC-13`** Moderation / Trust & Safety — **`PRD-020`** (**FROZEN**) owns adjudication |
| **Dependencies** | `IMPL-1762` |
| **Acceptance / verification** | `LTS-AC-001` proven; each report reaches `BC-13` exactly once |
| **Implementation boundary** | ⛔⛔ MUST NOT adjudicate, triage, classify severity, or hide content on its own authority |
| **Required tests** | Integration test on intake · architecture test asserting no adjudication logic |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** `IMPL-1785`…`1788` · **Blocked by** `IMPL-1762` |

#### `IMPL-1785` — Acknowledgement limited to *filed and acknowledged*

| Field | Value |
|---|---|
| **Trace** | `LTS-FR-014` · `LTS-XC-001`…`LTS-XC-003` · AC `LTS-AC-003`, `LTS-AC-004` |
| **Purpose / scope** | Confirm to the reporter only that the report was filed and acknowledged — no status, outcome or timeline |
| **Owning BC** | **`BC-13`** |
| **Dependencies** | `IMPL-1784` |
| **Acceptance / verification** | `LTS-AC-003` proven; the message contains no adjudication state |
| **Implementation boundary** | ⚠⚠ ⭐ **This requirement exists *because* a gap is open.** `TSF-GAP-009` (the `BC-13` → `BC-19` referral transport) is **`PRD-020`'s own, already owned by the Architecture Owner**; C0 **L430** records that it is **deliberately NOT** given an `XPC-OD-*` identifier. C0 **L474**: the requirement *"is testable now and its outcome will not change"*. ⛔ MUST NOT report status |
| **Required tests** | Message-content test asserting the forbidden fields are absent |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1784` |

#### `IMPL-1786` — Reporter anti-abuse bounds

| Field | Value |
|---|---|
| **Trace** | `LTS-FR-007`…`LTS-FR-011` · `LTS-BR-001`…`LTS-BR-004` · `LTS-XC-004`…`LTS-XC-007` · AC `LTS-AC-005`…`LTS-AC-007` |
| **Purpose / scope** | Bound report volume per origin so intake cannot be used as an attack |
| **Owning BC** | `PRD-021C` application layer · **`BC-13`** (policy) |
| **Dependencies** | `IMPL-1784` |
| **Acceptance / verification** | `LTS-AC-005` proven |
| **Implementation boundary** | ⚠ ⛔ MUST NOT implement bot detection, CAPTCHA or scraping defence — `XPC-OD-010` asks **which context owns** those and is **OPEN**; the repository has **no owner** for them |
| **Required tests** | Rate-bound test · boundary test |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1784` |

#### `IMPL-1787` — Moderation outcome consumption

| Field | Value |
|---|---|
| **Trace** | `LTS-FR-012`, `LTS-FR-013`, `LTS-FR-015`…`LTS-FR-018` · `LTS-BR-005`…`LTS-BR-009` · AC `LTS-AC-008`…`LTS-AC-011` |
| **Purpose / scope** | Withdraw or restore public visibility when `BC-13` decides, without inferring a decision |
| **Owning BC** | **`BC-13`** decides · **`BC-19`** holds the publication state |
| **Dependencies** | `IMPL-1784`, `IMPL-1754` |
| **Acceptance / verification** | `LTS-AC-008` proven; visibility changes **only** on a `BC-13` decision |
| **Implementation boundary** | ⛔ MUST NOT infer, cache or pre-empt a moderation decision |
| **Required tests** | Integration test over decision → withdrawal → restoration |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1784` |

#### `IMPL-1788` — Report audit trail

| Field | Value |
|---|---|
| **Trace** | `LTS-XC-008`…`LTS-XC-015` · AC `LTS-AC-012`, `LTS-AC-013` |
| **Purpose / scope** | Record intake and outcome-consumption events for audit |
| **Owning BC** | ⭐ **Existing audit ownership** (`PRD-016`) — ⛔ not re-implemented here |
| **Dependencies** | `IMPL-1784`, `IMPL-1787` |
| **Acceptance / verification** | `LTS-AC-012` proven; each intake yields exactly one audit record |
| **Implementation boundary** | ⛔ MUST NOT create an audit store, schema or retention policy — the audit owner holds all three |
| **Required tests** | Audit-emission test · idempotency test |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1787` |

### G8 — C8 Technical & production architecture (`LMT-*`, V1)

#### `IMPL-1789` — Storage and persistence boundaries

| Field | Value |
|---|---|
| **Trace** | `LMT-FR-001`, `LMT-FR-006` · `LMT-XC-001` · AC `LMT-AC-001` |
| **Purpose / scope** | Implement C1–C7's storage requirements within module 19's boundary |
| **Owning BC** | `PRD-021C` (module 19 composition) |
| **Dependencies** | G1 |
| **Acceptance / verification** | `LMT-AC-001` proven verbatim |
| **Implementation boundary** | ⛔ MUST NOT own data belonging to `BC-19`, `BC-04`, `BC-10`, `BC-02` or `BC-23`; projections only |
| **Required tests** | **Module-boundary test** (`tool/check_module_boundaries.dart`, pipeline gate 3) |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** `IMPL-1790`…`1793` · **Blocked by** `IMPL-1750` |

#### `IMPL-1790` — Performance and load envelope

| Field | Value |
|---|---|
| **Trace** | `LMT-FR-002`…`LMT-FR-005`, `LMT-FR-007`…`LMT-FR-010` · `LMT-BR-001`…`LMT-BR-005` · `LMT-XC-002`…`LMT-XC-006` · AC `LMT-AC-002`…`LMT-AC-005` |
| **Purpose / scope** | Meet C8's stated latency and throughput envelope for the anonymous surface |
| **Owning BC** | `PRD-021C` |
| **Dependencies** | `IMPL-1789` |
| **Acceptance / verification** | `LMT-AC-002` proven by measurement, not assertion |
| **Implementation boundary** | ⛔ MUST NOT meet a target by weakening a stated correctness or privacy requirement |
| **Required tests** | Load test at the stated envelope · regression budget |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1789` |

#### `IMPL-1791` — Observability without personal data

| Field | Value |
|---|---|
| **Trace** | `LMT-FR-011`…`LMT-FR-016` · `LMT-BR-006`…`LMT-BR-009` · `LMT-XC-007`…`LMT-XC-011` · AC `LMT-AC-006`…`LMT-AC-009` |
| **Purpose / scope** | Logs, metrics and traces for the public surface carrying no personal data |
| **Owning BC** | `PRD-021C` · **`BC-26`** for certified product metrics |
| **Dependencies** | `IMPL-1789` |
| **Acceptance / verification** | `LMT-AC-006` proven; **0** personal fields in telemetry |
| **Implementation boundary** | ⛔ MUST NOT define or publish a product metric — `BC-26` certifies metrics (see `IMPL-1766`) |
| **Required tests** | Telemetry-schema test · PII-absence sweep |
| **Status** | **V1** |
| **Priority** | **P1** · **Blocks** — · **Blocked by** `IMPL-1789` |

#### `IMPL-1792` — Failure isolation across consumed contexts

| Field | Value |
|---|---|
| **Trace** | `LMT-FR-017`…`LMT-FR-022` · `LMT-BR-010`…`LMT-BR-012` · `LMT-XC-012`…`LMT-XC-016` · AC `LMT-AC-010`…`LMT-AC-013` |
| **Purpose / scope** | One failing upstream context degrades its own section only, never the whole marketplace |
| **Owning BC** | `PRD-021C` |
| **Dependencies** | `IMPL-1789`, `IMPL-1760`, `IMPL-1772` |
| **Acceptance / verification** | `LMT-AC-010` proven; a `BC-23` outage leaves profiles reachable |
| **Implementation boundary** | ⛔ MUST NOT serve fabricated or indefinitely stale data to mask an outage |
| **Required tests** | Fault-injection matrix, one case per consumed context |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** `IMPL-1789` |

#### `IMPL-1793` — Release readiness and pipeline conformance

| Field | Value |
|---|---|
| **Trace** | `LMT-FR-023`…`LMT-FR-026` · `LMT-XC-017`…`LMT-XC-020` · AC `LMT-AC-014`…`LMT-AC-016` |
| **Purpose / scope** | Marketplace passes all six `DEFINITION_OF_DONE.md` pipeline gates before release |
| **Owning BC** | `PRD-021C` |
| **Dependencies** | all preceding tasks |
| **Acceptance / verification** | `LMT-AC-016` proven; all six gates green |
| **Implementation boundary** | ⛔ MUST NOT weaken, skip or special-case a pipeline gate. ⛔ MUST NOT claim freeze — freeze is **Stage 7**, the **Governance Owner**'s |
| **Required tests** | Full pipeline: `dart format` · `flutter analyze` · module boundaries · architecture tests · `flutter test` · `flutter build web --release` |
| **Status** | **V1** |
| **Priority** | **P0** · **Blocks** — · **Blocked by** all G1–G8 |

---

## 4. Traceability — task groups → requirements → invariants → acceptance

Required by allocation **rule 4**.

| Group | Tasks | Requirements (own-stem) | Invariants / business rules | Acceptance criteria | Owning / consumed BCs |
|---|---|---|---|---|---|
| **G1** C1 | `IMPL-1750`…`1755` | `LMP-FR-001`…`024` (24) | `LMP-XC-001`…`010` | `LMP-AC-001`…`012` (12) | `BC-19` · `BC-10` (avoided) |
| **G2** C2 | `IMPL-1756`…`1761` | `LSD-FR-001`…`032` (32) | `LSD-XC-001`…`012` | `LSD-AC-001`…`016` (16) | **`BC-23`** |
| **G3** C3 | `IMPL-1762`…`1768` | `LPP-FR-001`…`044` (44) | `LPP-XC-001`…`017` | `LPP-AC-001`…`022` (22) | `BC-19` · `BC-25` · `BC-26` · `BC-06` |
| **G4** C4 | `IMPL-1769`…`1774` | `LSB-FR-001`…`036` (36) | `LSB-XC-001`…`014` | `LSB-AC-001`…`018` (18) | **`BC-04`** · `PRD-007` · `BC-02` |
| **G5** C5 | `IMPL-1775`…`1778` | `LRR-FR-001`…`019` (19) | `LRR-BR-001`…`008` · `LRR-XC-001`…`016` | `LRR-AC-001`…`012` (12) | ⛔ **none created** |
| **G6** C6 | `IMPL-1779`…`1783` | `LDR-FR-001`…`022` (22)… | `LDR-BR-001`…`009` · `LDR-XC-001`…`015` | `LDR-AC-001`…`014` (14) | **`BC-23`** · `BC-19` |
| **G7** C7 | `IMPL-1784`…`1788` | `LTS-FR-001`…`018` (18) | `LTS-BR-001`…`009` · `LTS-XC-001`…`015` | `LTS-AC-001`…`013` (13) | **`BC-13`** · `PRD-020` · audit owner |
| **G8** C8 | `IMPL-1789`…`1793` | `LMT-FR-001`…`026` (26) | `LMT-BR-001`…`012` · `LMT-XC-001`…`020` | `LMT-AC-001`…`016` (16) | `PRD-021C` module 19 · `BC-26` |
| **Total** | **44** | **258** obligations | **118** exclusions · **38** business rules | **123** | 6 consumed, **0 created** |

⭐ **Coverage of this table, measured:** **123 of 123** acceptance criteria fall inside a task group's range,
**0 acceptance criteria are unassigned**, and **0 tasks cite a requirement that does not exist**.

⚠⚠ **The honest limitation, stated rather than hidden.** A task group covers its part's whole register, so
"every AC is covered by a group" is a weaker claim than "every AC is covered by a named task". Stage 5 measured
**reverse coverage at 210 of 258 = 81.4%, with 48 obligations exercised by no acceptance criterion**. Those 48
are inside their group's scope and will be implemented, but **they will not be *proven* by an AC**, because
none exists. ⛔ **Writing the missing 48 criteria is a Product Owner act and is NOT done here.**

---

## 5. What this document does NOT do

| Act | Status | Who holds it |
|---|---|---|
| Write application or production code | ⛔ **NOT DONE — 0 lines** | **Stage 8** (`PRD_LIFECYCLE.md` **L182**) |
| Enter Stage 7 / claim freeze | ⛔ **NOT ENTERED** | **Governance Owner** (**L281**); **L161** — *"Freeze is **conferred**, not claimed"* |
| Create a bounded context, entity, event or integration edge | ⛔ **0 created** | Architecture Owner |
| Change any C0–C8 requirement or acceptance criterion | ⛔ **0 changed** | Product Owner |
| Close any open decision, or re-tier C5 to V1 | ⛔ **0 closed** | Named per item; C5 re-tier is a **Rank 3 amendment** |
| Write the 48 missing acceptance criteria | ⛔ **NOT DONE** | Product Owner |
| Specify the `BC-23` query contract, analyzer defence, or bot defence | ⛔ **NOT DONE** | Architecture Owner / unassigned (`XPC-OD-002`, `009`, `010`) |
| Repair `PRD_LIFECYCLE.md` L147–153's stale table | ⛔ **NOT DONE** | Governance Owner; **L164** requires an ADR **first** |
| Certify a metric | ⛔ **NOT DONE** | **`BC-26`** |
| Write a standing `tool/docs_check/*.py` gate | ⛔ **NOT DONE** | Governance Owner |

---

## 6. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-03 | **Stage 6 task document created for `PRD-021C` C0–C8 as one consolidated unit.** Range **`IMPL-1750`…`1793`** (44 tasks) allocated after a **mechanical** census — 890 numbers appear in tracked files but only **837** are task rows, the highest being **`IMPL-1689`**; the four numbers above it (**1690, 1700, 1750, 1800**) were read at their lines and are **declarations of emptiness, not uses**, so `PRD-021B`'s reserve `1690`…`1749` was honoured in full and **0** numbers were reused or reassigned. ⛔ `PRD_LIFECYCLE.md` **L147–153** was **NOT** used as the source (standing finding `S6-F-2`: the table is stale, declaring `IMPL-227`+ unallocated while 890 higher numbers occur). Trace basis re-measured: **123 ACs, 0 orphans, 253 distinct requirements cited**; ⚠ two instrument corrections were required first — an AC-window scan anchored on **register range rows** and a **two-format** AC layout (C5–C8 mapping tables vs C1–C4 `> **Exercises**` lines), and the four residual ACs (`LMP-AC-012`, `LSD-AC-016`, `LPP-AC-008`, `LSB-AC-018`) were resolved at the authoritative Stage-4 mapping document **L188–L191** rather than guessed. **Smallest compatible scope:** 258 obligations → **44** tasks, each carrying identifier, exact trace, purpose, owning BC, dependencies, acceptance, boundary, tests and V1/V2 status, plus `Priority`/`Blocks`/`Blocked by` per rule 3. ⭐ **Ownership respected as given and as measured:** `BC-23` search/ranking, `BC-26` analytics, `BC-10` identity, `BC-19` tenancy, `BC-04` seating, `PRD-007` booking (**FROZEN**, C4 **L100** — *"C4 defines no booking"*), `BC-13`/`PRD-020` moderation, `BC-02` membership, `BC-25` media and the existing audit owner — **6 contexts consumed, 0 created**; context count stays **31** and the edge set stays **29** (`E-30` reused, ⛔ none minted). ⛔⛔ **C5 remains V2 on repository authority, not on instruction alone** — `Library_PRD_v1.md` **L1016** and `ARCHITECTURE_RULINGS.md` **§6 L291**, both **FROZEN**; its four tasks implement the **absence discipline** and create no reviews context. ⚠ **Five open decisions are respected by refusal rather than by silence:** `XPC-OD-002` (unspecified `BC-23` contract), `XPC-OD-004` (offline queue — `IMPL-1774` implements the **exclusion**), `XPC-OD-005` (privacy review, owner role **VACANT**), `XPC-OD-009` and `XPC-OD-010` — each named in the boundary of the task that would otherwise have answered it by code. `TSF-GAP-009` shapes `IMPL-1785` exactly as C7 intends and is ⛔ **not adopted** as a `PRD-021C` decision. ⚠ **The traceability table's own weakness is disclosed rather than concealed:** group-level coverage is weaker than task-level, and Stage 5's **48** AC-unbacked obligations remain unproven because **writing those criteria is a Product Owner act**. **Zero-ledger:** application code **0 lines** · requirements changed **0** · ACs changed **0** · registers extended **0** · BCs **0** · events **0** · edges **0** · ADRs **0** · open decisions closed **0** · baseline rows **0** · frozen documents modified **0**. ⛔ **Stage 7 NOT entered; freeze NOT claimed.** |
| **v1.1** | 2026-09-03 | ⚠⚠ **Self-caught defect: two fabricated requirement citations removed before this document was validated.** The register-tail guard, run against the eight C-part registers' measured maxima, reported **2** violations in this document's own trace cells — one in the C5 register `LRR-FR` at slot **019**, cited by the task at `IMPL-1778`, and one in the C6 register `LDR-XC` at slot **015**, cited by the task at `IMPL-1783`. ⛔ **Neither slot exists, and neither is written out in full anywhere in this document — each is named here by register and number only, deliberately.** `grep` across every `docs/30-product/library-marketplace/` source returned **0** occurrences of both, and the instrument's maxima were independently confirmed sound because they re-sum to the four recorded invariants **exactly** (FR **220**, BR **38**, AC **123**, XC **118**), which places the `LRR-FR` tail at **018** and the `LDR-XC` tail at **014**. ⭐ **A new defect class is named here so it can be guarded for: a *range-ellipsis over-reach*.** Both errors were produced by an abbreviation whose upper bound ran **one slot past the end of its register**, and the abbreviation is precisely what concealed them: a reader sees *"the last three"* and never checks that a third exists, so **an ellipsis silently asserts the existence of every identifier it spans while displaying only its endpoints**. ⚠ The failure is the more instructive because the task at `IMPL-1783` is *itself* the withdrawn-slot guard, and it had correctly refused to trace the C6 `LDR-FR` withdrawn slot, naming it by number only — yet the very same trace cell invented a neighbouring `LDR-XC` slot. Discipline applied at one identifier does **not** propagate to the identifiers beside it. ⚠⚠ **A second, recursive instance was then caught in this entry itself:** the first draft of this changelog row *wrote both fabricated identifiers out in full in order to report them*, which re-minted the two tokens it was proving absent and drove the guard from 2 violations to 4. This is the same failure recorded at `PRD-021C_C0_C8_STAGE5_TRACEABILITY.md` **§4.4** — **prose does not neutralise a token, and `grep` does not read intent.** The only safe way to disclose a non-existent identifier is the one this document already used for the withdrawn slot: **by register and number, never as the token itself.** **Repair:** both trace cells rewritten to their registers' true tails and **enumerated by name instead of elided** — `LRR-FR-017`, `LRR-FR-018` for the first, and `LDR-XC-008`, `LDR-XC-013`, `LDR-XC-014` for the second. ⛔ **No register was extended, no requirement invented, no acceptance criterion altered, and no task added or removed** — the count stays **44** and the range stays **`IMPL-1750`…`1793`**; the sole effect is that two traces now cite requirements that actually exist. ⚠ This is disclosed rather than quietly corrected because the artefact's worth rests entirely on its traces being true, and a trace to a non-existent requirement is exactly the *"orphan task"* that Stage 6's validation forbids. |
