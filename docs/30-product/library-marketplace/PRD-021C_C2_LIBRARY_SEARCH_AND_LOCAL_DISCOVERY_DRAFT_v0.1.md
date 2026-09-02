<!--
  PROVENANCE — PRD-021C Part C2 (Library Search & Local Discovery)

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 NOT entered.

  Ownership note
  --------------
  BC-23 Search Indexing owns indices, permission-aware indexing, tenant index
  isolation, relevance and query rewriting. C2 creates NO second search system
  and NO second ranking system. C2 specifies the query contract it CONSUMES.

  Two OPEN decisions gate 8 of C2's requirements:
    XPC-OD-001 — E-21's consumer enumeration omits BC-19 (Architecture Owner)
    XPC-OD-002 — PRD-015, BC-23's owner, does not exist (Product + Arch Owner)

  What this file does NOT do
  --------------------------
    - Creates no index, analyzer, scorer, ranking model or relevance formula.
    - Creates no bounded context, edge, event, aggregate or invariant.
    - Amends no FROZEN PRD and no Rank 1-6 artefact.
    - Mints no IMPL-* identifier. Confers no lifecycle stage.
-->

# PRD-021C — PART C2

## Library Search & Local Discovery

### v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Stage 3 has **not** been entered.
> ⚠⚠ **8 of 32 requirements are CONDITIONAL on an OPEN decision** — see §2.

| Field | Value |
|---|---|
| **PRD** | `PRD-021C` Part **C2** |
| **Part title** | Library Search & Local Discovery |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** — Stage 2 |
| **Structural classification** | Part of the `AR-1` read composition (module 19). ⛔ **NOT a bounded context** |
| **Release** | **V1** |
| **Identifier prefix** | `LSD-*` — collision-checked at **0** occurrences |
| **Owns** | ⛔ **No index. No ranking model. No relevance formula. No aggregate.** Query shape and filter semantics only |
| **Consumes** | `BC-23` Search Indexing *(the provider; ⚠ conditional)* · `BC-19` Tenancy · `BC-06` Library Policy · `BC-02` Membership · `BC-04` Seating |
| **Cross-part** | [`C0`](./PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md) · [`C1`](./PRD-021C_C1_MARKETPLACE_FOUNDATION_DRAFT_v0.1.md) |

---

## §1. Purpose

C2 specifies how a prospective student **finds** a library: by name, city,
locality, PIN code and proximity, with the filters §14A.4 enumerates, ordered by
a mechanism `BC-23` owns.

C2 does **not** build search. It specifies the **contract it consumes** from
`BC-23`, and the presentation semantics of the result set.

### §1.1 ⭐ Why C2 owns no ranking

BC Map **L132** assigns `BC-23` Search Indexing ownership of *"indices,
permission-aware indexing, tenant index isolation, **relevance**, query
rewriting."* Relevance is therefore **not** C2's to define.

⭐ **`ADR-0091` §3 is the governing precedent and it cuts precisely here.** For
`PRD-021B` B4 it ruled that a *"post-retrieval ordering layer inside a read
composition"* is lawful, while `BC-23`'s ownership of *relevance* is *"neither
transferred nor diluted"* — and it **narrowed** the ruling so that on a **text
query surface** relevance is binding, because *"on a text query, relevance **is**
the user's expressed intent; re-ordering across relevance bands would make a
search box stop answering the query."*

C2 adopts that ruling as written:

| Surface | Ordering authority |
|---|---|
| **Text query** (name, city, locality, PIN) | ⭐ **`BC-23` relevance is binding.** C2 **MUST NOT** re-order across relevance bands |
| **Non-query browse** (nearby, filter-only) | C2 **MAY** apply a **declared, deterministic** post-retrieval sort — distance ascending — because no text query has expressed an intent to honour |

⛔ **This creates no ranking system.** A declared distance sort on a filter-only
browse is an ordering rule, not a relevance model, and it is the same structure
`ADR-0091` admitted for `DISC-RANK-1`.

### §1.2 Normative language

**MUST**/**MUST NOT** absolute · **SHOULD** strong recommendation · **MAY**
optional · unkeyworded prose and `>` blocks are **not** normative.

---

## §2. ⚠⚠ Conditional requirements — the two blocking open decisions

| Open decision | Owner | Requirements blocked |
|---|---|---|
| **`XPC-OD-001`** — BC Map **L330** `E-21` admits **`BC-01`, `BC-10`** to `BC-23`. **`BC-19` is absent**, so the `TenantOrganisation` record has no lawful carrier into the discovery index | **Architecture Owner** | `LSD-FR-001`…`LSD-FR-006` |
| **`XPC-OD-002`** — `BC-23`'s owner `PRD-015` **does not exist** (`PRD_REGISTRY.md` **L315**, `PLANNED`; measured absent from `docs/30-product/`) | **Product Owner** + **Architecture Owner** | `LSD-FR-007`, `LSD-FR-008` |

⚠ **These requirements are written, identified and counted — and marked
CONDITIONAL.** They are not silently dropped to make coverage read cleanly, and
they are not asserted as implementable.

⛔ **`E-21` is NOT extended by this draft.**
[`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md)
records that `E-21`'s source cell *"is an **enumeration**… not a wildcard, so the
wildcard argument was tested there and **failed**"*, and
[`ADR-0083`](../../00-governance/adr/ADR-0083-prd-021a-owner-rulings-executed.md)
§4.5 refused to mint an edge on exactly this question. Both refusals are
**honoured**.

---

## §3. Identifier registers

| Register | Range | Count | Contiguous |
|---|---|---|---|
| `LSD-FR-*` | `LSD-FR-001` … `LSD-FR-032` | 32 | Yes |
| `LSD-AC-*` | `LSD-AC-001` … `LSD-AC-016` | 16 | Yes |
| `LSD-XC-*` | `LSD-XC-001` … `LSD-XC-012` | 12 | Yes |

---

## §4. The projection — ⚠ CONDITIONAL on `XPC-OD-001` / `XPC-OD-002`

`LSD-FR-001` — ⚠ *Conditional on `XPC-OD-001`.* Public library discovery **MUST**
be served from the **Platform Public Discovery Index** owned by `BC-23`, whose
indexed unit is the `TenantOrganisation` record (`AR-3`; BC Map §11.1).

`LSD-FR-002` — ⚠ *Conditional on `XPC-OD-001`.* The projection into `BC-23`
**MUST** be fed by **events** on an existing edge, and search **MUST NOT** read
domain tables (`E-21` note: *"Search never reads domain tables"*; `F-1`, `F-2`).

`LSD-FR-003` — ⚠ *Conditional on `XPC-OD-001`.* The projection **MUST** contain
only the fields §14A.5 permits publicly, and **MUST NOT** contain any tenant
operational value (BC Map §11.1; `LIB-14B.22`).

`LSD-FR-004` — ⚠ *Conditional on `XPC-OD-001`.* A library **MUST** enter the
projection only when verified, activated and Public, and **MUST** leave it within
`LCFG-6` of ceasing to satisfy any of those (`LIB-DISC-002`, `LIB-DISC-004`).

`LSD-FR-005` — ⚠ *Conditional on `XPC-OD-001`.* Projection updates **MUST** be
idempotent by event identifier, so a redelivered event produces no duplicate
entry (BC Map §9.1).

`LSD-FR-006` — ⚠ *Conditional on `XPC-OD-001`.* The projection **MUST NOT** be
partitioned by caller tenant, because the public discovery index has no caller
tenant context; this exemption **MUST NOT** be extended to any other index
(`AR-3`; BC Map §11.1).

`LSD-FR-007` — ⚠ *Conditional on `XPC-OD-002`.* C2 **MUST** consume a query port
exposed by `BC-23` and **MUST NOT** query an index directly (`E-26` pattern;
`F-2`).

`LSD-FR-008` — ⚠ *Conditional on `XPC-OD-002`.* The query port's contract —
request shape, pagination, error taxonomy — **MUST** be defined by `BC-23`'s
owner, and C2 **MUST NOT** author it.

> **`LSD-FR-008` is a refusal, deliberately written as a requirement.** The
> honest position is that C2's provider is unspecified. Authoring the provider's
> contract here would make C2 look complete while silently creating a second
> search authority — the exact outcome the instruction forbids.

---

## §5. Search capabilities

Every capability below maps to a §14A.4 entry. ⛔ **No capability is added.**

`LSD-FR-009` — Search **MUST** support **library name** as a text query
(§14A.4).

`LSD-FR-010` — Search **MUST** support **city** as a query or filter (§14A.4).

`LSD-FR-011` — Search **MUST** support **locality** as a query or filter
(§14A.4).

`LSD-FR-012` — Search **MUST** support **PIN code** as a query or filter
(§14A.4).

`LSD-FR-013` — Search **MUST** support **nearby discovery** when the client has
granted location permission (§14A.4, `LIB-DISC-013`).

`LSD-FR-014` — Nearby discovery **MUST NOT** be attempted without an explicit
client location grant, and the absence of a grant **MUST NOT** block name, city,
locality or PIN search.

`LSD-FR-015` — Where location permission is available, discovery **MUST**
prioritise nearby libraries (`LIB-DISC-013`).

`LSD-FR-016` — Location values supplied by an anonymous client **MUST NOT** be
persisted, associated with a person, or used for any purpose beyond serving the
request that carried them.

> **`LSD-FR-016` has no `LIB-DISC-*` parent and is stated because its absence
> would be a privacy defect.** §14A requires proximity discovery and is silent on
> retention of the coordinate. On a minor-heavy product, retaining an
> unauthenticated location trace is exactly the class of risk `BC-13` is
> classified `[CORE]` for. The requirement is **restrictive**, adds no public
> field, and creates no entity — so it is the smallest compatible form.

---

## §6. Filters

Each filter maps to a §14A.4 entry and reads from the owning context.

| Filter | `LSD-FR` | Value owner |
|---|---|---|
| Facilities & amenities | `LSD-FR-017` | `BC-19` / `BC-25` |
| Membership fee | `LSD-FR-018` | `BC-02` Membership |
| Operating hours | `LSD-FR-019` | `BC-06` Library Policy |
| Library type | `LSD-FR-020` | `BC-19` Tenancy |
| Future availability | `LSD-FR-021` | `BC-04` Seating — ⚠ see `LSD-FR-022` |
| Distance | `LSD-FR-023` | Derived from the client-supplied coordinate |

`LSD-FR-017` — Search **MUST** support filtering by **facilities and amenities**,
read from the owning context and never redefined here (§14A.4, §14A.5).

`LSD-FR-018` — Search **MUST** support filtering by **membership fee**, using
plan values read from `BC-02`. C2 **MUST NOT** store or compute a price
(`LXC-7`, `LIB-14B.15`), and displayed values **MUST** be marked indicative
(`LIB-14B.18`).

`LSD-FR-019` — Search **MUST** support filtering by **operating hours**, computed
from `BC-06` hours, holidays and emergency closures in the library's configured
time zone (`LIB-14B.19`, `LCFG-1`).

`LSD-FR-020` — Search **MUST** support filtering by **library type**, read from
`BC-19`.

`LSD-FR-021` — Search **MUST** support a **future availability** filter
expressed **only** as the coarse qualitative indicator `LIB-14B.12` permits.

`LSD-FR-022` — The availability filter **MUST NOT** expose, or allow inference
of, a precise free-seat count, a live occupancy count or percentage, or any
per-seat fact — including by repeated querying, result-count differencing or
filter-boundary probing (`LIB-14B.11`, `LIB-14B.12`, `SEAT-XC-009`).

> **`LSD-FR-022`'s inference clause is the requirement most likely to be missed.**
> A filter that returns *"libraries with more than N seats free"* discloses a
> precise count to anyone willing to vary `N` — even though no single response
> ever contains a number. The frozen prohibition is on the **fact**, not on the
> field, so the filter must be coarse in its *domain*, not merely in its display.

`LSD-FR-023` — Distance-based sorting **MUST** be supported on non-query browse
surfaces (§14A.4), subject to §1.1's ordering split.

`LSD-FR-024` — Filters **MUST** be composable, and a combination that matches
nothing **MUST** return an empty result rather than an error.

---

## §7. Ordering, pagination and result semantics

`LSD-FR-025` — On a **text query** surface, result ordering **MUST** be
`BC-23`'s relevance ordering, and C2 **MUST NOT** re-order across relevance
bands (§1.1; `ADR-0091` §3's narrowing).

`LSD-FR-026` — On a **non-query browse** surface, C2 **MAY** apply a declared,
deterministic post-retrieval sort; the sort key **MUST** be published to the user
and **MUST NOT** be a computed relevance score.

`LSD-FR-027` — C2 **MUST NOT** define, store or tune a relevance formula,
scoring weight, boost, analyzer or synonym list (BC Map **L132**).

`LSD-FR-028` — Pagination **MUST** use the **opaque cursor** convention the
BC Map already establishes (§15.3), and **MUST NOT** expose an offset that
reveals total tenant count (`LIB-18.2`).

`LSD-FR-029` — Result counts **MUST NOT** disclose the total number of libraries
on the platform, including through a "total results" value on an unfiltered query
(`LIB-18.2`, `LIB-14B.22`).

`LSD-FR-030` — A Private, Draft, Pending, Suspended or Archived library **MUST
NOT** appear in any result, count, facet or aggregate (`LIB-DISC-004`,
`LIB-14B.23`).

`LSD-FR-031` — Facet counts **MUST** be computed only over libraries lawfully in
the projection, so a facet cannot reveal the existence of an excluded library.

`LSD-FR-032` — Search **MUST NOT** require authentication (`LIB-DISC-005`), and
**MUST NOT** personalise results to a known viewer, because on this surface there
is no known viewer (`LIB-14B.17`).

---

## §8. Exclusions

| # | Excluded | Authority |
|---|---|---|
| `LSD-XC-001` | ⛔ **MUST NOT** create a second search system, index or search engine | BC Map **L132**; `F-1`, `F-2` |
| `LSD-XC-002` | ⛔ **MUST NOT** create a second ranking or relevance system | BC Map **L132**; `ADR-0091` §3 |
| `LSD-XC-003` | ⛔ **MUST NOT** publish a domain event or mint an event identifier | BC Map §9 |
| `LSD-XC-004` | ⛔ **MUST NOT** author `BC-23`'s index internals, analyzers, scoring or query-rewriting rules | BC Map **L132**; C0 `XPC-OD-002` |
| `LSD-XC-005` | ⛔ **MUST NOT** read a domain table from the search path | `E-21` note; `F-1` |
| `LSD-XC-006` | ⛔ **MUST NOT** create an integration edge, including into `BC-23` | BC Map §7; `ADR-0084` |
| `LSD-XC-007` | ⛔ **MUST NOT** index or expose tenant operational data | BC Map §11.1; `MP-GBR-08`; `X-13` |
| `LSD-XC-008` | ⛔ **MUST NOT** expose a precise free-seat count, live occupancy count or percentage, or any per-seat fact — by value or by inference | `SEAT-XC-009`; `LIB-14B.11`…`LIB-14B.13` |
| `LSD-XC-009` | ⛔ **MUST NOT** create, consume, sort by or filter by a rating, review or star value | `ARCHITECTURE_RULINGS.md` §6 — **Deferred V2**, *"must not be invented"* |
| `LSD-XC-010` | ⛔ **MUST NOT** use a social signal — friends, community, messages, reputation — as a discovery, filter or ordering input | `X-05`; `ID-3` |
| `LSD-XC-011` | ⛔ **MUST NOT** persist an anonymous client's location or associate it with a person | `LSD-FR-016` |
| `LSD-XC-012` | ⛔ **MUST NOT** define a rate-limiting policy; protection is consumed from §14B.8 | `ARCHITECTURE_RULINGS.md` §6 |

---

## §9. Acceptance criteria

Given/When/Then form. ⚠ **0 of 16 is proven by a test — no test exists.**

`LSD-AC-001` — **Name search returns matching public libraries**
> **Given** three verified, activated, Public libraries whose names are "Central Study Hall", "Central Library" and "Riverside Reading Room"
> **When** an anonymous client searches the name "Central"
> **Then** the first two are returned and the third is not
> **And** the ordering is the relevance ordering supplied by `BC-23`, unmodified.

`LSD-AC-002` — **City, locality and PIN each return correct results**
> **Given** libraries in three cities, four localities and five PIN codes
> **When** a client queries by each of city, locality and PIN in turn
> **Then** each query returns exactly the libraries matching that value
> **And** no library outside the value appears.

`LSD-AC-003` — **Nearby discovery requires an explicit grant**
> **Given** a client that has **not** granted location permission
> **When** it requests nearby discovery
> **Then** nearby discovery is not performed
> **And** name, city, locality and PIN search remain fully available.

`LSD-AC-004` — **Nearby prioritisation applies when a grant exists**
> **Given** a client that has granted location permission, and libraries at 0.4 km, 3 km and 20 km
> **When** it requests nearby discovery
> **Then** results are prioritised by proximity, nearest first.

`LSD-AC-005` — **Anonymous location is not persisted**
> **Given** an anonymous nearby-discovery request carrying a coordinate
> **When** the request completes
> **Then** the coordinate is not stored, not associated with any person, and not used for any later request.

`LSD-AC-006` — **Relevance is not re-ordered on a text query**
> **Given** a text query whose `BC-23` result ordering is `[A, B, C]` in descending relevance
> **When** C2 renders the result set
> **Then** the rendered order is `[A, B, C]`
> **And** no distance, price or availability value has moved an item across a relevance band.

`LSD-AC-007` — **Non-query browse sort is declared and deterministic**
> **Given** a filter-only browse with no text query
> **When** results are ordered by distance ascending
> **Then** the sort key is shown to the user
> **And** two identical requests return the same order.

`LSD-AC-008` — **Availability filter is coarse and non-inferable**
> **Given** a library with exactly 7 of 60 seats free
> **When** any sequence of availability-filtered queries is issued
> **Then** no response, and no difference between responses, reveals the number 7 or the percentage
> **And** only a coarse indicator is ever returned.

`LSD-AC-009` — **Fee filter uses `BC-02` values and marks them indicative**
> **Given** a library whose publicly offered plan is priced in `BC-02`
> **When** a fee-range filter is applied and results rendered
> **Then** the value used is `BC-02`'s
> **And** the displayed price is marked indicative
> **And** no price is stored or recomputed by C2.

`LSD-AC-010` — **Hours filter respects time zone, holidays and emergency closure**
> **Given** a library in a different time zone with a weekly holiday today and an active emergency closure
> **When** an "open now" filter is applied
> **Then** the library is excluded
> **And** the computation used `BC-06` values in the library's configured time zone.

`LSD-AC-011` — **Excluded libraries never appear in results, counts or facets**
> **Given** one Public+activated library and one each of Private, Draft, Pending, Suspended, Archived
> **When** an unfiltered browse and every facet are inspected
> **Then** only the Public+activated library appears
> **And** no facet count, total, or aggregate reflects the other five.

`LSD-AC-012` — **Total platform library count is not disclosed**
> **Given** an unfiltered anonymous browse
> **When** the response and its pagination metadata are inspected
> **Then** no value discloses the total number of libraries on the platform
> **And** the cursor is opaque and reveals no offset or ordinal.

`LSD-AC-013` — **Search never reads a domain table**
> **Given** the search execution path
> **When** its data access is inspected
> **Then** it reads only the `BC-23` projection through the query port
> **And** it performs no read against a `BC-01`…`BC-09` or `BC-19` table.

`LSD-AC-014` — **Projection update is idempotent**
> **Given** a projection-feeding event delivered twice with the same event identifier
> **When** both deliveries are processed
> **Then** the projection contains exactly one entry for that library
> **And** no duplicate result appears in search.

`LSD-AC-015` — **Empty result is not an error**
> **Given** a composable filter combination that matches no library
> **When** the query executes
> **Then** an empty result set is returned successfully
> **And** no error is raised and no internal detail is disclosed.

`LSD-AC-016` — **No result is personalised**
> **Given** two anonymous clients issuing an identical query with identical location grants
> **When** both receive results
> **Then** the result sets and their ordering are identical
> **And** no viewer-specific value influenced either.

---

## §10. Traceability to authority

| Requirement group | Governing authority |
|---|---|
| `LSD-FR-001`…`008` | `AR-1`; `AR-3`; BC Map §11.1, **L330**; `F-1`, `F-2`; ⚠ `XPC-OD-001`, `XPC-OD-002` |
| `LSD-FR-009`…`016` | §14A.4; `LIB-DISC-005`, `013` |
| `LSD-FR-017`…`024` | §14A.4, §14A.5; `LXC-7`; `LIB-14B.15`, `18`, `19`, `12`, `11`; `SEAT-XC-009`; `LCFG-1` |
| `LSD-FR-025`…`032` | BC Map **L132**, §15.3; `ADR-0091` §3; `LIB-18.2`; `LIB-DISC-004`, `005`; `LIB-14B.17`, `23` |

---

## §11. Status

**`DRAFT` · Stage 2 · NOT FROZEN · NOT APPROVED · NOT BASELINED · Rank: none.**
Stage 3 **not** entered. **8 of 32** requirements ⚠ **CONDITIONAL** on
`XPC-OD-001` / `XPC-OD-002`. **0** ADRs, **0** contexts, **0** edges, **0**
events, **0** indices, **0** ranking models, **0** `IMPL-*`, **0** Rank 1–6
documents modified, **0** lines of code.

---

## §12. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-02 | Created. Specifies library search and local discovery as a **consumer** of `BC-23`, with the `ADR-0091` ordering split applied verbatim. 32 FR (8 conditional) · 16 AC · 12 XC |
