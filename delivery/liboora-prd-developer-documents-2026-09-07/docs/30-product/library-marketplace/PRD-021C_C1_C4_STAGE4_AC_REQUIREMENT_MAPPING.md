# `PRD-021C` C1–C4 — Stage 4 Check 4 Remedy: **Acceptance-Criterion → Requirement Mapping**

| Field | Value |
|---|---|
| Document | `PRD-021C_C1_C4_STAGE4_AC_REQUIREMENT_MAPPING.md` |
| Act | 🔧 **REMEDY + MEASUREMENT.** This document repairs a named Stage-4 check defect and re-measures it. ⛔ It is **not** a conferral and performs **no** governance act. |
| Authority claimed | ⛔ **NONE beyond measurement and the mechanical citation of pre-existing requirements.** No stage is conferred, no requirement is created, no scope is changed. |
| Instruction basis | The human principal's instruction to *"Resolve the Stage-4 AC→Requirement failure … Use the existing lawful mapping remedy from PRD-020 / PRD-021A"*, and *"Map each orphan AC to an existing requirement with exact evidence"*, with the express prohibitions *"Do NOT invent requirements or rewrite C1–C4 scope"* and *"Do NOT modify already-correct C5–C8 mappings"*. |
| Convention followed | `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` §1.1/§1.2 (method and prohibitions) and `PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` (form, and the precedent that such a record lawfully edits its subject). |
| Defect remedied | Check 4 of `PRD_LIFECYCLE.md` **L108–L119** — *"Every acceptance criterion maps to a requirement"*; failure mode *"Orphan criterion"*. Recorded as ⛔⛔ **FAIL, 64 of 123 orphaned** at `PRD-021C_C0_C8_STAGE4_REQUIREMENTS_REVIEW.md` §9. |
| ⚠ **This record edited its subject** | **Yes** — **64** acceptance-criterion blocks gained a requirement citation across **four** files. Precedent: `PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` **L10** (*"206 acceptance-criterion rows gained a requirement citation"*) and `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` **L11**. |
| Identifiers minted | ⛔ **ZERO.** Verified by census: 528 total, every register contiguous, byte-identical family counts. |
| Subjects edited | C1, C2, C3, C4 only. ⛔ C0 and C5–C8 byte-unchanged. |
| Verdict | ✅ **CHECK 4 NOW PASSES — 123 of 123 acceptance criteria mapped, 0 orphans.** |
| ⛔ Stage 4 status | ⛔⛔ **STILL BLOCKED — NOT CONFERRED.** Blocker-2 (reviewer authority) is **unresolved** and is **not resolvable from repository evidence**. See §5. |
| Status | Unranked working record. ⛔ Not admitted to `DOCUMENTATION_BASELINE.md` — admission is the Governance Owner's act. |

---

## 1. What this record does, and what it deliberately does not do

### 1.1 How the mapping was produced

Following `PRD-020` §1.1, in four steps:

1. **Extracted every acceptance criterion** in C1–C4 by identifier, in document order, using a
   format-aware instrument that recognises both the plain form (`` `LMP-AC-001` — **Title** ``, C1/C2)
   and the bolded form (`` **`LPP-AC-001`** — **Title** ``, C3/C4). Counts: C1 **12**, C2 **16**,
   C3 **22**, C4 **18** = **68**.
2. **Built a requirement pool** from each part's own functional-requirement register, read in full:
   C1 `LMP-FR-001`…`024` (L88–L226) · C2 `LSD-FR-001`…`032` (L148–L304) ·
   C3 `LPP-FR-001`…`044` (L230–L993) · C4 `LSB-FR-001`…`036` (L175–L396).
3. **Matched only where a requirement states, in normative language, the same obligation the
   criterion tests.** ⛔ Thematic adjacency was **not** accepted as a match — the `PRD-020` §1.1
   rule. Where a criterion's Then-clauses span two or three obligations, all of the
   corresponding requirements are cited; where it tests one, one is cited.
4. **Verified every citation resolves to a *defined* identifier**, not merely a referenced one:
   **104** citations, **0** undefined (§4.3).

The citation was added as a single trailing line inside each criterion's existing
Given/When/Then blockquote, in the form:

```
> **Exercises** — `LMP-FR-002`, `LMP-FR-003`, `LMP-FR-016`
```

⭐ **The criterion text itself is untouched.** The diff is **64 insertions, 0 deletions** (§4.1) —
no Given, When, Then or And line was altered, reordered or removed in any of the four files.

### 1.2 What this record deliberately does NOT do

| # | Not done | Why |
|---|---|---|
| 1 | ⛔ Invent, extend or reword a requirement to receive an orphan criterion | `PRD-008_STAGE4_CONFERRAL.md` §4: *"The most corrupting way to pass a requirements review is to write the missing requirement."* Every one of the 64 criteria was matched to text that already existed at `779d94a`. |
| 2 | ⛔ Rewrite C1–C4 scope | The instruction forbids it. Only citation lines were added. |
| 3 | ⛔ Touch C5–C8 | The instruction forbids it (*"Do NOT modify already-correct C5–C8 mappings"*). Proven byte-unchanged at §4.2. |
| 4 | ⛔ Mint, renumber or reuse any identifier | `PRD_LIFECYCLE.md` §5 rule 5. Census unchanged at **528** (§4.3). |
| 5 | ⛔ Accept the inverse direction (requirement → AC) as a mapping | `PRD-020` §1.2. Check 4 requires the criterion to name its requirement, not the reverse. |
| 6 | ⛔ Touch `TRACEABILITY_MATRIX.md`, `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md`, any ADR, or any Rank 1–5 document | `PRD-020` §1.2. Diff proves 0 such files (§4.1). |
| 7 | ⛔ Change any `*-GAP-*` or `PGA-*` status | Not this record's act. |
| 8 | ⛔ Modify any validator or fixture under `tool/` | Diff proves 0 (§4.1). |
| 9 | ⛔ Confer Stage 4, or treat a repaired check as a conferral | §5, and `PRD-021A` mapping §11: *"A complete evidence set does not confer a stage."* |
| 10 | ⛔ Resolve any of the six open decisions, tier Reviews & Ratings, or create `IMPL-*`, freeze, baseline or approval | Stage 4 authorises none of these; `IMPL-*` is Stage 6, freeze Stage 7, code Stage 8. |

---

## 2. The defect, restated exactly

`PRD_LIFECYCLE.md` **L108–L119**, Stage 4 check 4:

> | Every acceptance criterion maps to a requirement | Orphan criterion |

Measured at `779d94a` (`PRD-021C_C0_C8_STAGE4_REQUIREMENTS_REVIEW.md` §9.1):

| Part | AC | Mapped | Orphaned |
|---|---|---|---|
| C1 Marketplace Foundation | 12 | 1 | **11** |
| C2 Search & Local Discovery | 16 | 1 | **15** |
| C3 Public Profile | 22 | 1 | **21** |
| C4 Live Seat Availability & Booking | 18 | 1 | **17** |
| C5–C8 | 55 | **55** | 0 |
| **Total** | **123** | **59** | ⛔ **64** |

⭐ **The cause was structural, not substantive.** C5–C8 each publish an explicit coverage
construct — C5's §9.0 coverage map (**L563–L569**, `| Criterion | Exercises |`) is the model —
whereas C1–C4 published their criteria as bare Given/When/Then blocks with no citation
construct at all. The four incidental hits (`LMP-AC-012`, `LSD-AC-016`, `LPP-AC-008`,
`LSB-AC-018`) cite requirements *inside* a Then-clause as part of the assertion, not through a
mapping construct. ⭐ The behaviours were specified; the *link* was absent. That is why the
remedy is a citation and never a new requirement.

---

## 3. The mapping — 64 rows, with grounding evidence

Each row gives the criterion, the requirement(s) it exercises, the line at which the **first**
cited requirement is **defined** in the same file, and that requirement's own normative text
verbatim (truncated for width). ⛔ No row cites a requirement that did not exist at `779d94a`.

#### C1 Marketplace Foundation — `PRD-021C_C1_MARKETPLACE_FOUNDATION_DRAFT_v0.1.md`

| AC | Exercises | Def. line | Grounding text of the first cited requirement (verbatim, truncated) |
|---|---|---|---|
| `LMP-AC-001` | `LMP-FR-002`, `LMP-FR-003`, `LMP-FR-016` | L93 | The marketplace surface **MUST** be reachable with **no account, no session and no prior relationship** with the platform (§14B.3, `LIB-DISC-005`). |
| `LMP-AC-002` | `LMP-FR-007`, `LMP-FR-009` | L128 | A library **MUST** appear on the marketplace surface only when **both** conditions hold: it is **verified and activated** (`LIB-DISC-002`), and its visibility mode is **Public** (`LIB-DISC-0 |
| `LMP-AC-003` | `LMP-FR-008`, `LMP-FR-010`, `LMP-FR-011` | L132 | A **Private** library **MUST NOT** appear on the marketplace surface in any form — not in search, not in nearby discovery, not in a count, not in an aggregate, and not in an error message (` |
| `LMP-AC-004` | `LMP-FR-004`, `LMP-FR-005` | L101 | Each field presented **MUST** be read from its owning context and **MUST NOT** be stored, cached as authoritative, recomputed or overridden by this composition (`AR-1`: *"Discovery reference |
| `LMP-AC-005` | `LMP-FR-006` | L120 | Where an owning context is unavailable, the composition **MUST** degrade by omitting that field group, **MUST** still render the remainder, and **MUST NOT** substitute a stored or stale valu |
| `LMP-AC-006` | `LMP-FR-012`, `LMP-FR-001` | L159 | The public marketplace surface **MUST** be served **without a caller tenant context**, because the tenant *is* the indexed record (`AR-3`; BC Map §11.1). |
| `LMP-AC-007` | `LMP-FR-013` | L163 | Every read of **tenant operational data** — students, memberships, attendance, fees, staff, analytics, configuration — **MUST** carry an ambient `TenantContext` via `E-18`, and a query witho |
| `LMP-AC-008` | `LMP-FR-014`, `LMP-FR-015` | L169 | The composition **MUST NOT** place tenant operational data into the public discovery index under any transformation — aggregated, derived, inferred or error-message form (BC Map §11.1; `LIB- |
| `LMP-AC-009` | `LMP-FR-016`, `LMP-FR-017`, `LMP-FR-018` | L187 | Browsing the marketplace surface **MUST NOT** require authentication (`LIB-DISC-005`, §14B.3). |
| `LMP-AC-010` | `LMP-FR-019`, `LMP-FR-020` | L197 | The user's intended action **MUST** survive authentication and **MUST** resume afterwards without re-entry (`LIB-DISC-012`, §14B.7). |
| `LMP-AC-011` | `LMP-FR-021` | L203 | Every authorisation decision **MUST** be evaluated by `BC-18`; this composition **MUST NOT** decide permission locally (`X-13`). |

#### C2 Library Search & Local Discovery — `PRD-021C_C2_LIBRARY_SEARCH_AND_LOCAL_DISCOVERY_DRAFT_v0.1.md`

| AC | Exercises | Def. line | Grounding text of the first cited requirement (verbatim, truncated) |
|---|---|---|---|
| `LSD-AC-001` | `LSD-FR-009`, `LSD-FR-001` | L192 | Search **MUST** support **library name** as a text query (§14A.4). |
| `LSD-AC-002` | `LSD-FR-010`, `LSD-FR-011`, `LSD-FR-012` | L195 | Search **MUST** support **city** as a query or filter (§14A.4). |
| `LSD-AC-003` | `LSD-FR-013`, `LSD-FR-014` | L203 | Search **MUST** support **nearby discovery** when the client has granted location permission (§14A.4, `LIB-DISC-013`). |
| `LSD-AC-004` | `LSD-FR-015` | L210 | Where location permission is available, discovery **MUST** prioritise nearby libraries (`LIB-DISC-013`). |
| `LSD-AC-005` | `LSD-FR-016` | L213 | Location values supplied by an anonymous client **MUST NOT** be persisted, associated with a person, or used for any purpose beyond serving the request that carried them. |
| `LSD-AC-006` | `LSD-FR-025`, `LSD-FR-027` | L278 | On a **text query** surface, result ordering **MUST** be `BC-23`'s relevance ordering, and C2 **MUST NOT** re-order across relevance bands (§1.1; `ADR-0091` §3's narrowing). |
| `LSD-AC-007` | `LSD-FR-023`, `LSD-FR-026` | L268 | Distance-based sorting **MUST** be supported on non-query browse surfaces (§14A.4), subject to §1.1's ordering split. |
| `LSD-AC-008` | `LSD-FR-021`, `LSD-FR-022` | L254 | Search **MUST** support a **future availability** filter expressed **only** as the coarse qualitative indicator `LIB-14B.12` permits. |
| `LSD-AC-009` | `LSD-FR-018` | L242 | Search **MUST** support filtering by **membership fee**, using plan values read from `BC-02`. C2 **MUST NOT** store or compute a price (`LXC-7`, `LIB-14B.15`), and displayed values **MUST**  |
| `LSD-AC-010` | `LSD-FR-019` | L247 | Search **MUST** support filtering by **operating hours**, computed from `BC-06` hours, holidays and emergency closures in the library's configured time zone (`LIB-14B.19`, `LCFG-1`). |
| `LSD-AC-011` | `LSD-FR-030`, `LSD-FR-031` | L297 | A Private, Draft, Pending, Suspended or Archived library **MUST NOT** appear in any result, count, facet or aggregate (`LIB-DISC-004`, |
| `LSD-AC-012` | `LSD-FR-029` | L293 | Result counts **MUST NOT** disclose the total number of libraries on the platform, including through a "total results" value on an unfiltered query (`LIB-18.2`, `LIB-14B.22`). |
| `LSD-AC-013` | `LSD-FR-006`, `LSD-FR-007` | L168 | ✅ *Unconditional; `XPC-OD-001` resolved by [`ADR-0093`].* The projection **MUST NOT** be partitioned by caller tenant, because the public discovery index has no caller tenant context; this e |
| `LSD-AC-014` | `LSD-FR-005` | L164 | ✅ *Unconditional; `XPC-OD-001` resolved by [`ADR-0093`].* Projection updates **MUST** be idempotent by event identifier, so a redelivered event produces no duplicate entry (BC Map §9.1). |
| `LSD-AC-015` | `LSD-FR-024` | L271 | Filters **MUST** be composable, and a combination that matches nothing **MUST** return an empty result rather than an error. |

#### C3 Library Public Profile — `PRD-021C_C3_LIBRARY_PUBLIC_PROFILE_DRAFT_v0.1.md`

| AC | Exercises | Def. line | Grounding text of the first cited requirement (verbatim, truncated) |
|---|---|---|---|
| `LPP-AC-001` | `LPP-FR-004`, `LPP-FR-005` | L254 | The profile **MUST** be readable **without authentication** (`LIB-14B.1`, §14A.8). No field **MUST** be gated behind a sign-in prompt, a partial blur, a paywall or a "log in to see prices" i |
| `LPP-AC-002` | `LPP-FR-002` | L234 | The profile's field set **MUST** be exactly the §14A.5 public list. It **MUST NOT** contain a field outside that list, and **MUST NOT** omit a field the library has populated and published. |
| `LPP-AC-003` | `LPP-FR-003` | L238 | Every field rendered **MUST** be traceable to a single owning context per the table below (`LIB-14B.10`). A field whose owner cannot be named **MUST NOT** be rendered. |
| `LPP-AC-004` | `LPP-FR-006` | L263 | Where a source context is unavailable, the profile **MUST** render the fields it can resolve and **MUST** mark the unresolved group as temporarily unavailable. It **MUST NOT** substitute a c |
| `LPP-AC-005` | `LPP-FR-007` | L268 | Each field group **MUST** carry the freshness of its own source. The profile **MUST NOT** present a single page-level freshness value that implies groups are equally current when they are no |
| `LPP-AC-006` | `LPP-FR-008`, `LPP-FR-029` | L272 | The profile **MUST** declare a stable presentation order of field groups. The order **MUST NOT** vary by viewer, by session, by locale or by any commercial arrangement. |
| `LPP-AC-007` | `LPP-FR-013` | L300 | Description **MUST** be rendered as the library authored it in `BC-25`. C3 **MUST NOT** summarise, translate, rewrite, truncate destructively or machine-generate description text. |
| `LPP-AC-009` | `LPP-FR-020`, `LPP-FR-021` | L363 | Operating Hours and Weekly Holidays **MUST** be read from `BC-06` and rendered in the library's configured time zone (`LCFG-1`), with the time zone shown. |
| `LPP-AC-010` | `LPP-FR-021` | L367 | Current open / closed status **MUST** be computed from `BC-06` operating hours, holidays and emergency closures (`LIB-14B.19`), and **MUST NOT** be derived from whether anyone is currently p |
| `LPP-AC-011` | `LPP-FR-023`, `LPP-FR-024` | L385 | Membership Plans and Pricing **MUST** be read from a `BC-02` projection (`LIB-14B.15`). C3 **MUST NOT** store a price, compute a price, apply a discount, prorate, or total a plan (`LXC-7`).  |
| `LPP-AC-012` | `LPP-FR-025` | L395 | Public seat information **MUST** be limited to the aggregate capacity and coarse qualitative indicator that `LIB-14B.11`, `LIB-14B.12` and `SEAT-FR-117` permit. The profile **MUST NOT** show |
| `LPP-AC-013` | `LPP-FR-026`, `LPP-FR-027` | L406 | A profile request for a library that is **non-existent, Private, Draft, Pending, Suspended or Archived MUST** produce the **same** observable response: the same status code, the same body sh |
| `LPP-AC-014` | `LPP-FR-028` | L424 | Error responses **MUST NOT** disclose internal identifiers, table names, query structure, stack traces, context names or configuration values (`LIB-14B.25`). Internal identifiers that would  |
| `LPP-AC-015` | `LPP-FR-030`, `LPP-FR-031` | L605 | The engagement summary **MUST NOT** form part of the public profile projection. It **MUST NOT** appear in an anonymous response **in any form, including aggregated, derived, inferred, cached |
| `LPP-AC-016` | `LPP-FR-032`, `LPP-FR-033` | L624 | Rendering the summary is a **protected operation** under |
| `LPP-AC-017` | `LPP-FR-034` | L634 | The summary **MUST** be scoped to the requested library's own tenant. A request **MUST** carry tenant context and **MUST** be refused where it is absent or does not match (`MP-GBR-08`, `SE-1 |
| `LPP-AC-018` | `LPP-FR-035`, `LPP-FR-038` | L650 | ✅ **UNCONDITIONAL** *(`ADR-0097`)*. **Total Profile Views MUST** be read as the **`ProfileViews` `CertifiedMetric` of `BC-26`** — ⭐ certified **2026-09-02** by [`ADR-0097`] and the **first** |
| `LPP-AC-019` | `LPP-FR-036` | L662 | ⛔⛔ **OMITTED** *(`ADR-0097`)*. ⭐ **This requirement is determinate and its answer is NOT a feature.** `XPC-OD-007B` was decided **option B**: **`ProfileViews` ONLY**. ⛔ **`UniqueViewers` is  |
| `LPP-AC-020` | `LPP-FR-037` | L682 | ✅ **UNCONDITIONAL** *(`ADR-0097`)*. The **period/trend summary** (e.g. *"+18% this week"*) **MUST** be a comparison published by `BC-26` over the **`BC-26`-defined periods now fixed by [`ADR |
| `LPP-AC-021` | `LPP-FR-039`, `LPP-FR-040` | L713 | The summary **MUST NOT** expose individual viewer identities by default. It **MUST NOT** render a viewer list, name, avatar, handle, `PersonId`, `AccountId`, partial identifier, device ident |
| `LPP-AC-022` | `LPP-FR-038`, `LPP-FR-042` | L689 | ✅ **UNCONDITIONAL** *(`ADR-0097`)* — ⭐ **and the refusal stands unchanged.** C3 **MUST NOT** define the metric semantics — what constitutes a view, whether a bot is excluded, whether an owne |

#### C4 Live Seat Availability & Booking — `PRD-021C_C4_LIVE_SEAT_AVAILABILITY_AND_BOOKING_DRAFT_v0.1.md`

| AC | Exercises | Def. line | Grounding text of the first cited requirement (verbatim, truncated) |
|---|---|---|---|
| `LSB-AC-001` | `LSB-FR-001`, `LSB-FR-007` | L175 | Seat availability information on the public discovery surface **MUST** be readable **without authentication** (`LIB-14B.1`, §14A.8), and **MUST NOT** be gated behind a sign-in prompt or a mo |
| `LSB-AC-002` | `LSB-FR-002`, `LSB-FR-003` | L180 | Public availability **MUST** be served from the public read projection of `LIB-14B.8`. A public availability request **MUST NOT** reach `BC-04`'s operational store, seat table or allocation  |
| `LSB-AC-003` | `LSB-FR-010`, `LSB-FR-008` | L227 | The public surface **MUST NOT** display a precise free-seat count, a free-seat percentage, an occupancy count, an occupancy percentage, or any numeric availability value other than the aggre |
| `LSB-AC-004` | `LSB-FR-008` | L212 | Public availability **MUST** be expressed **only** as a coarse qualitative indicator drawn from a closed value set — *Available* · *Limited* · *Full* · *Unknown* — per `LIB-14B.12`. |
| `LSB-AC-005` | `LSB-FR-009` | L216 | The mapping from `BC-04`'s aggregate projection to the coarse indicator **MUST** be owned and published by `BC-04`. C4 **MUST NOT** define thresholds, percentages or boundaries for that mapp |
| `LSB-AC-006` | `LSB-FR-004` | L188 | Public availability **MUST NOT** be derived from attendance records, check-in events, `E-08` traffic, or any presence signal (`LIB-14B.14`, `LIB-14B.21`). |
| `LSB-AC-007` | `LSB-FR-006` | L195 | Where the availability projection is unavailable, the surface **MUST** mark availability as temporarily unknown. It **MUST NOT** display a default of *Available*, and **MUST NOT** display a  |
| `LSB-AC-008` | `LSB-FR-012` | L243 | Whether availability is published at all **MUST** remain the publishing library's choice. §14A.5 lists *"Seat Capacity (Optional)"*; a library that publishes nothing **MUST** show no availab |
| `LSB-AC-009` | `LSB-FR-032`, `LSB-FR-033` | L373 | Every public availability value **MUST** carry the age of the projection it came from. The surface **MUST NOT** present availability as current when its source age is unknown. |
| `LSB-AC-010` | `LSB-FR-034` | L381 | The surface **MUST NOT** describe any availability value as *live*, *real-time*, *current occupancy*, or any wording implying live occupancy, because Public Live Occupancy is **V2** (`LIB-14 |
| `LSB-AC-011` | `LSB-FR-016`, `LSB-FR-017` | L265 | Where self-booking is disabled for a tenant (`SEAT-CFG-008`, default **disabled**), the surface **MUST NOT** present a booking action, and **MUST NOT** imply that booking is available and fa |
| `LSB-AC-012` | `LSB-FR-018` | L273 | The surface **MUST** reflect the tenant's effective booking mode (`SEAT-CFG-010`: `Direct` · `HoldThenConfirm` · `ApprovalRequired`, default `ApprovalRequired`) in what it tells the student  |
| `LSB-AC-013` | `LSB-FR-020`, `LSB-FR-021`, `LSB-FR-022` | L292 | When an **anonymous** visitor initiates booking, the platform **MUST** record the intended action and its context, route to the `BC-18` authentication flow, and on success **resume** the ori |
| `LSB-AC-014` | `LSB-FR-023` | L307 | If the library's state changed during authentication — suspended, made Private, plan withdrawn, capacity exhausted, self-booking disabled — resumption **MUST** re-validate and **MUST** fail  |
| `LSB-AC-015` | `LSB-FR-024`, `LSB-FR-025` | L327 | Two concurrent booking initiations against one seat **MUST** resolve to exactly one success and one explicit, distinguishable failure, as `SEAT-BR-031` requires. C4 **MUST NOT** present a si |
| `LSB-AC-016` | `LSB-FR-026` | L336 | C4 **MUST NOT** implement, hold, emulate or bypass either lock |
| `LSB-AC-017` | `LSB-FR-028`, `LSB-FR-029`, `LSB-FR-030` | L351 | Every booking initiation C4 forwards **MUST** carry a caller-supplied idempotency key, per `SEAT-FR-201`. |

### 3.1 Criteria that were already mapped and were NOT touched

| AC | Pre-existing citation | Action |
|---|---|---|
| `LMP-AC-012` (C1 L322) | `LMP-FR-001`, `LMP-FR-007` | ⛔ none — already satisfied Check 4 |
| `LSD-AC-016` (C2 L422) | `LSD-FR-001`, `LSD-FR-009` | ⛔ none |
| `LPP-AC-008` (C3 L840) | `LPP-FR-016` | ⛔ none |
| `LSB-AC-018` (C4 L539) | `LSB-FR-001`, `LSB-FR-007` | ⛔ none |

### 3.2 Criteria marked UNMAPPED

⛔ **None.** All 64 orphans resolved to pre-existing requirements. The instruction's fallback
(*"If genuinely unmapped, mark it UNMAPPED with reason/owner"*) was **not needed** and is
therefore **not exercised** — no row is marked UNMAPPED, because no row is.

---

## 4. Verification

### 4.1 Diff scope

```
 PRD-021C_C1_MARKETPLACE_FOUNDATION_DRAFT_v0.1.md            | 11 +++++++++++
 PRD-021C_C2_LIBRARY_SEARCH_AND_LOCAL_DISCOVERY_DRAFT_v0.1.md | 15 +++++++++++++++
 PRD-021C_C3_LIBRARY_PUBLIC_PROFILE_DRAFT_v0.1.md            | 21 +++++++++++++++++++++
 PRD-021C_C4_LIVE_SEAT_AVAILABILITY_AND_BOOKING_DRAFT_v0.1.md | 17 +++++++++++++++++
 4 files changed, 64 insertions(+)
```

⭐ **64 insertions, 0 deletions.** One insertion per orphan criterion, exactly.
Files matching `^(lib|test|web|android|ios|.github|tool)/`: **0**.
ADRs changed: **0**. Rank 1–5 documents changed: **0**. Validators changed: **0**.

### 4.2 C0 and C5–C8 are byte-unchanged

`git diff --numstat` restricted to C5/C6/C7/C8: **empty**. Confirmed by sha256:

| Part | sha256 (12) at `779d94a` | sha256 (12) now | Lines | Identifiers |
|---|---|---|---|---|
| C0 | `27722b18f3e2` | `27722b18f3e2` ✅ | 576 | 29 |
| C5 | `4327033aae82` | `4327033aae82` ✅ | 726 | 54 |
| C6 | `0bd6572931dc` | `0bd6572931dc` ✅ | 755 | 59 |
| C7 | `c90376fcaed9` | `c90376fcaed9` ✅ | 719 | 55 |
| C8 | `1cfbb5e6beb5` | `1cfbb5e6beb5` ✅ | 778 | 74 |

Subjects that lawfully changed (expected, and disclosed):

| Part | sha256 before | sha256 now | Lines before → now | Identifiers |
|---|---|---|---|---|
| C1 | `8bdc774269ec` | `c66f8de6eb64` | 354 → **365** (+11) | 46 ✅ unchanged |
| C2 | `1a5f42b2e689` | `ea2e3e73f4ef` | 457 → **472** (+15) | 60 ✅ unchanged |
| C3 | `3e194d433ff3` | `930ac35443fc` | 1018 → **1039** (+21) | 83 ✅ unchanged |
| C4 | `60839e911d2d` | `6d22b31172f9` | 576 → **593** (+17) | 68 ✅ unchanged |

⭐ **Line counts rose by exactly the citation count; identifier counts did not move at all.**

### 4.3 Zero identifiers minted

| Part | Identifiers | Contiguous from `001` | Family breakdown |
|---|---|---|---|
| C0 | 29 | ✅ | `XPC-CONF` 19 · `XPC-OD` 10 |
| C1 | 46 | ✅ | `LMP-FR` 24 · `LMP-XC` 10 · `LMP-AC` 12 |
| C2 | 60 | ✅ | `LSD-FR` 32 · `LSD-XC` 12 · `LSD-AC` 16 |
| C3 | 83 | ✅ | `LPP-FR` 44 · `LPP-XC` 17 · `LPP-AC` 22 |
| C4 | 68 | ✅ | `LSB-FR` 36 · `LSB-XC` 14 · `LSB-AC` 18 |
| C5 | 54 | ✅ | `LRR-FR` 18 · `LRR-BR` 8 · `LRR-XC` 16 · `LRR-AC` 12 |
| C6 | 59 | ✅ | `LDR-FR` 22 · `LDR-BR` 9 · `LDR-XC` 14 · `LDR-AC` 14 |
| C7 | 55 | ✅ | `LTS-FR` 18 · `LTS-BR` 9 · `LTS-XC` 15 · `LTS-AC` 13 |
| C8 | 74 | ✅ | `LMT-FR` 26 · `LMT-BR` 12 · `LMT-XC` 20 · `LMT-AC` 16 |
| **Total** | **528** | ✅ | ⭐ **identical to the figure measured at `40b52b2` and `779d94a`** |

Citation targets are all **defined**, not merely referenced:

| Part | Defined FR/BR/XC | Citations added | Distinct targets | ⛔ Undefined |
|---|---|---|---|---|
| C1 | 34 | 22 | 21 | **0** |
| C2 | 44 | 24 | 24 | **0** |
| C3 | 61 | 31 | 29 | **0** |
| C4 | 50 | 27 | 26 | **0** |
| **Total** | — | **104** | — | ⛔ **0** |

### 4.4 Check 4 re-measured — the exact Stage-4 mapping check

| Part | AC | Mapped | Orphaned |
|---|---|---|---|
| C1 | 12 | **12** | 0 |
| C2 | 16 | **16** | 0 |
| C3 | 22 | **22** | 0 |
| C4 | 18 | **18** | 0 |
| C5 | 12 | **12** | 0 |
| C6 | 14 | **14** | 0 |
| C7 | 13 | **13** | 0 |
| C8 | 16 | **16** | 0 |
| **Total** | **123** | ✅ **123** | ✅ **0** |

✅ **CHECK 4 PASSES.** Orphan list: **empty**.

### 4.5 The other five checks and the gate, re-measured on the edited subjects

| # | Check | Result | Measurement |
|---|---|---|---|
| 1 | Every requirement testable | ✅ **PASS** | 258 FR/BR definitions == 220 declared FR + 38 declared BR; **0** vague ("fast", "easy", "robust", "user-friendly", …) |
| 2 | Every exclusion states what must be impossible | ✅ **PASS** | 118 XC sites, **0** deferrals. ⚠ Five lines flagged by the scanner read as *citations of an external deferral*, not as the exclusion deferring: `LMP-XC-009`/`LSD-XC-009`/`LPP-XC-005`/`LSB-XC-013` each cite `ARCHITECTURE_RULINGS.md` §6 (*"Deferred V2, **must not be invented**"*) as the **authority for a prohibition**, and `LRR-XC-016` forbids *"stat[ing], impl[ying] or promis[ing] … that ratings are planned, deferred or forthcoming"* — an exclusion **of** deferral language. ⭐ Read, not re-run. |
| 3 | Every configurable has a default and a range | ✅ **PASS, vacuously** | **0** `*-CFG-*` identifiers across all nine subjects. The two configurable-shaped requirements are delegations: `LSB-FR-027` → `BC-04`/`SEAT-FR-199`; `LMT-FR-019` → typed accessors over `E-19`. |
| 4 | Every acceptance criterion maps to a requirement | ✅ **PASS** *(was FAIL)* | **123 of 123**, 0 orphans — §4.4 |
| 5 | No requirement restates another PRD's | ✅ **PASS** | **0** foreign-stem *definitions*. All foreign occurrences are in citation position (`SEAT` 69, `TSF` 38, `LCF` 5, `FIL` 4). ⚠ Six C6 lines flagged by the scanner sit under the header `\| C2 requirement \| What it already fixes \|` (C6 L95–L96) — ⭐ that table **cites** C2's `LSD-FR-023`…`032` precisely to show C6 does **not** restate them. Instrument defect **I-2**, read not re-run. |
| 6 | Business rules do not contradict Rank 1 | ✅ **PASS** | 38 BR, **0** contradictions. `LMT-BR-002` (C8 L171–174) quotes `MASTER_PRD.md` **L171** verbatim, including *"not a context"*. |
| — | **Gate (L119)** — *"conflicts closed or explicitly deferred with a reason and an owner"* | ✅ **SATISFIED** | 6 open decisions, each with reason **and** owner: `XPC-OD-004` Architecture Owner · `XPC-OD-005` Privacy Owner *(⚠ holder VACANT)* · `XPC-OD-006` Architecture Owner · `XPC-OD-008` Product Owner + Architecture Owner · `XPC-OD-009` Architecture Owner + `BC-23` owner · `XPC-OD-010` Architecture Owner + Security reviewer |

⭐ **Six of six checks now pass, and the gate is satisfied.**

### 4.6 Invariants preserved

| Invariant | Required | Measured | ✅ |
|---|---|---|---|
| Identifier total | 528 | **528** | ✅ |
| Bounded contexts | 31 | **31** (BC Map L10) | ✅ |
| Declared edges | 29 | **26** §7 rows + `E-28`, `E-29` (§15.1) + `E-30` (§17) = **29** | ✅ |
| `E-27` | vacant | **0** table rows | ✅ |
| Edge slot **31** | unminted | **0** occurrences | ✅ |
| Bounded-context slot **32** | unminted | **0** occurrences | ✅ |
| ADR count | 85 | **85** (git-counted) | ✅ |
| ADR slots **0088** / **0089** / **0090** | unwritten | **0** / **0** / **0** | ✅ |
| `BC-23` | sole search/ranking authority | unchanged; `LSD-XC-002` intact | ✅ |
| `BC-26` | sole analytics authority | unchanged | ✅ |
| `ProfileViews` | certified | unchanged (`ADR-0097`) | ✅ |
| `UniqueViewers` | ⛔ NOT CERTIFIED, omitted | unchanged | ✅ |
| C5 Reviews & Ratings | **V2**, unchanged | C5 byte-identical; *"Does NOT tier Reviews & Ratings to V1"* intact | ✅ |
| PRD-007 booking ownership | intact | C4 cites `SEAT-FR-076`…`084` (FROZEN); defines no `Booking` | ✅ |
| New BC / entity / event / edge | none | **0** | ✅ |
| `IMPL-*` for PRD-021C | none | **0** | ✅ |
| App code touched | none | **0** files | ✅ |

---

## 5. ⛔⛔ Blocker-2 — reviewer authority. NOT RESOLVED.

Repairing Check 4 does **not** confer Stage 4. `PRD-021A`'s mapping record is the precedent
and it says so explicitly: its verdict remained *"⚠️ **STAGE-4 EVIDENCE PASS — FORMAL
CONFERRAL PENDING** … ⛔ **NOT CONFERRED**"* even after all 206 citations were added.

### 5.1 What was inspected

| Source | Finding |
|---|---|
| `PRD_GAP_ANALYSIS.md` **L391** | `~~PGA-08~~` — *"No PRD has a named owner"* — ✅ **CLOSED 2026-08-04**, *"resolved **role-based**, not by naming individuals"* |
| `PRD_GAP_ANALYSIS.md` **L410** | The criterion *"Every PRD has a **named** owner"* is recorded ⛔ **"Not satisfied, by design"** — *"No personal name exists to record, and recording one would fabricate accountability"* |
| `PRD_OWNERSHIP_MODEL.md` §2.2 (L83–L86) | Names **four** roles: **Product Owner**, **Domain Owner**, **Architecture Owner**, **Technical Owner**. ⛔ **"Requirements Reviewer" is not among them.** |
| `PRD_OWNERSHIP_MODEL.md` §1.1 | *"No name exists to record… A name written here would be fabricated, and a fabricated owner is worse than an absent one."* |
| `PRD_OWNERSHIP_MODEL.md` §7 rule 4 | *"**Never** record a personal name."* |
| `PRD_OWNERSHIP_MODEL.md` §9 (L353, L355) | The **Privacy Owner** office is *constituted* yet *"**vacant as constituted** — constituting an office does not fill it, and nothing in this document appoints anyone"*, and ⛔ a role may not perform *"its own conferral"* |
| `PRD_LIFECYCLE.md` **L278** | `\| Requirements reviewer \| Stage 4 \|` — the role exists and owns Stage 4 |
| `PRD_LIFECYCLE.md` **L272** | *"Roles, not people — the repository names no individuals, and this document does not invent any."* |
| `ADR-0048` L57–L60 | Separates **RUN** the checks (*"creates no verdict"* — permitted) from **CONFER** the stage (*"requirements reviewer only"* — refused) |
| `ADR-0048` L65–L68 | *"A Stage 3 record must not accept the ADR it depends on; it may only observe that someone with authority did."* One level up: a record may not confer the stage it measures. |
| Repository-wide grep for a named holder | ⛔ **0 results.** No document names any individual as Requirements Reviewer. |
| `git ls-files \| grep CONFERRAL` | 11 conferral artefacts exist — for `PRD-008`, `PRD-013`, `PRD-014`, `PRD-016`, `PRD-017`, `PRD-020`, `PRD-021A`, `PRD-021B`. ⛔ **None for `PRD-021C`.** |

### 5.2 The one lawful designation mechanism, and why it is unavailable in this act

`PRD-008_STAGE4_CONFERRAL.md` L1–L18 shows the **only** mechanism the repository has ever
used to fill this role:

> | Conferred by | **Requirements Reviewer**, exercised by **direct, explicit and unconditional conferral of the human principal of this engagement** |
> | Instruction (verbatim) | *"Confer Requirements Reviewer authority for the specific act of formally reviewing and, if the existing Stage 4 evidence satisfies `PRD_LIFECYCLE.md`, conferring Stage 4."* |
> | Authority basis | That instruction **is** the authority, and it is **the only authority claimed**. |
> | Scope | **This specific act only.** |

And `ADR-0033` §7.1 binds its reach:

> *"A conferral for one act is not a standing licence."*

⭐ **Therefore the `PRD-008` and `PRD-021A` conferrals cannot reach `PRD-021C`.** Each was
scoped to its own subject and its own act. A fresh, explicit conferral instruction naming
this subject would be required.

**The instruction governing this act contains no such conferral.** It directs, verbatim:

> *"Find an existing repository-authorized named Requirements Reviewer, **if one exists**. If the
> repository provides a lawful designation mechanism, use it. **Never self-appoint or assume
> Product/Architecture/Governance Owner is the reviewer.** If no lawful designation is possible,
> keep Stage 4 BLOCKED and report it."*

### 5.3 Determination

| Question | Answer |
|---|---|
| Does a repository-authorised **named** Requirements Reviewer exist? | ⛔ **No.** None is named anywhere, and `PRD_OWNERSHIP_MODEL.md` §7 rule 4 forbids recording one. |
| Is `PGA-08` the obstacle? | ⚠ **Not as an open gap** — it is **CLOSED**. The obstacle is *how* it closed: role-based, with *"every PRD has a named owner"* deliberately **"Not satisfied, by design"**. |
| Does the repository provide a lawful designation mechanism? | ⚠ **Yes, exactly one** — explicit conferral by the human principal, per-act (`PRD-008` L7–L9; `ADR-0033` §7.1–§7.2). |
| Was that mechanism exercised for `PRD-021C`? | ⛔ **No.** The governing instruction asks whether a reviewer exists; it does **not** confer the role. |
| Can this record self-appoint? | ⛔ **Prohibited** by the instruction and by `ADR-0048` L57–L60. |
| Can the Product, Architecture or Governance Owner stand in? | ⛔ **Prohibited** by the instruction, and unavailable in any case: `PRD_OWNERSHIP_MODEL.md` §9.3 shows why none of the four roles absorbs a new one, and `PRD-021A` mapping §11 already ruled *"the PO rulings do not supply this authority… Stage 4 belongs to the Requirements reviewer (L278)"*. |
| Result | ⛔⛔ **BLOCKER-2 STANDS. No lawful designation is possible in this act.** |

---

## 6. Determination

### 6.1 The two bars, measured separately

| Bar | Requirement | Result |
|---|---|---|
| **Evidence** | All six Stage-4 checks pass and the L119 gate is satisfied | ✅ **MET** — 6 of 6 checks pass; gate satisfied (§4.5) |
| **Authority** | A repository-authorised Requirements Reviewer confers the stage | ⛔ **NOT MET** — no holder exists and none can be lawfully designated (§5) |

### 6.2 Stage 4 status

⛔⛔ **STAGE 4 — EVIDENCE PASS, NOT CONFERRED. THE STAGE REMAINS BLOCKED.**

`PRD_LIFECYCLE.md` **L41**: *"A gate is not an opinion — if the artefact does not exist, the
stage has not been passed, however complete the work feels."* The conferral artefact does not
exist, and cannot be created by this record.

⭐ `PRD-021A` mapping §11 states the principle directly: *"A complete evidence set does not
confer a stage."*

### 6.3 What this record does NOT confer or authorise

| Act | Status |
|---|---|
| Stage 4 conferral | ⛔ **NOT CONFERRED** |
| Stage 5 Traceability / `APPROVED` | ⛔ **NOT ENTERED** — requires Stage 4 conferred |
| Stage 6 `IMPL-*` allocation | ⛔ **NOT AUTHORISED** — 0 `IMPL-*` created |
| Stage 7 Freeze / `FROZEN` | ⛔ **NOT AUTHORISED** |
| Stage 8 Implementation / code | ⛔ **NOT AUTHORISED** — 0 lines of app code touched |
| Stage 9 Verification / `VERIFIED` | ⛔ **NOT AUTHORISED** |
| Baseline admission | ⛔ **NOT PERFORMED** — Governance Owner's act |
| Resolution of the 6 open decisions | ⛔ **NOT PERFORMED** |
| Tiering Reviews & Ratings to V1 | ⛔ **REFUSED** — remains **V2** |

### 6.4 The remaining path

1. ✅ **DONE** — Check 4 repaired to 123/123 by citation, minting **0** identifiers (this record).
2. ⛔ **OUTSTANDING** — **Requirements Reviewer** authority designated by the one lawful
   mechanism: an explicit conferral instruction from the human principal, naming
   `PRD-021C` C0–C8 and this act.
3. ⛔ **OUTSTANDING** — that reviewer adopts or re-measures this evidence, confirms **no
   requirement was created to reach the PASS** (§1.2 row 1, §4.3), and then confers Stage 4
   **or withholds it**.

⚠ Step 3's third obligation is the one this record was most exposed to, and it is the reason
§4.3 measures the identifier census rather than asserting it.

---

## 7. Disclosures

| # | Disclosure |
|---|---|
| D-1 | ⚠ **A `genspark` auto-backup commit fired mid-act** and captured the 64 citation lines as commit `04fdf13` (*"genspark auto-backup"*) before this record was written. This is the **4th** such occurrence in this engagement (`52920d9`, `1d45e9e`, `da86a0d`). ⭐ It is **left in history and disclosed, not amended** — the instruction forbids amend, rebase, squash and force-push, and `779d94a` remains an ancestor. The citations it captured are the identical 64 lines verified in §4. |
| D-2 | ⚠ Check 2 and Check 5 each produced **scanner flags that are instrument artefacts, not defects** (§4.5 rows 2 and 5). Both were resolved by **reading the flagged source lines**, never by adjusting the instrument until it agreed. `PRD-021A_STAGE4_CONFERRAL` §1: *"A reviewer who reaches a PASS by re-running an instrument until it agrees has reviewed nothing."* |
| D-3 | ⚠ Check 1's raw scanner reported **280** definition rows and **47** without a normative keyword, against the validated **258** / **19**. The delta is the four subjects' new `> **Exercises**` lines being counted where a citation table row was already counted, plus the six C6 citation-table rows. The **declared** register figures (220 FR + 38 BR = 258) are unchanged and are the repository figures. |
| D-4 | ⚠ **Finding S4-A-5 is carried, not repaired.** The `LDR-FR` slot **023** renders as a greppable token at C0 **L128** and **L576**, inside C0's own defect-disclosure prose, although C6's register defines only **22** functional requirements. Pre-existing at `6ae3278`. Routed to the **Architecture Owner**. ⭐ **This record therefore cites every unused or unminted slot by NUMBER ONLY** — never as a spelled identifier — because a `\b`-delimited identifier is greppable regardless of surrounding prose, so spelling one while asserting it is unused causes any census whose glob matches this filename to count it as minted. That defect has recurred **five** times in this engagement and is not recurred here. |
| D-5 | ⚠ The **Privacy Owner** office (`XPC-OD-005`, `XPC-CONF-013`) remains **VACANT as constituted**. Unchanged by this record. |
| D-6 | ⚠ `PRD-015` and `PRD-009` remain **`PLANNED` and absent from disk**. Unchanged. |

---

## 8. Files changed by this act

| File | Change | Lines |
|---|---|---|
| `PRD-021C_C1_MARKETPLACE_FOUNDATION_DRAFT_v0.1.md` | 11 `> **Exercises**` citation lines | 354 → 365 |
| `PRD-021C_C2_LIBRARY_SEARCH_AND_LOCAL_DISCOVERY_DRAFT_v0.1.md` | 15 citation lines | 457 → 472 |
| `PRD-021C_C3_LIBRARY_PUBLIC_PROFILE_DRAFT_v0.1.md` | 21 citation lines | 1018 → 1039 |
| `PRD-021C_C4_LIVE_SEAT_AVAILABILITY_AND_BOOKING_DRAFT_v0.1.md` | 17 citation lines | 576 → 593 |
| `PRD-021C_C1_C4_STAGE4_AC_REQUIREMENT_MAPPING.md` | **new** — this record | — |

⛔ **0** app-code files · **0** ADRs · **0** Rank 1–5 documents · **0** validators · **0** fixtures ·
**0** registry/baseline/matrix documents · **0** changes to C0, C5, C6, C7, C8.

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-09-02 | Created. Check 4 remedied by citation: 64 orphan acceptance criteria mapped to pre-existing requirements across C1–C4, **0** identifiers minted. Check 4 re-measured **123/123**. All six Stage-4 checks now pass and the L119 gate is satisfied. ⛔ Stage 4 remains **NOT CONFERRED** — Blocker-2 (reviewer authority) is unresolved and not resolvable from repository evidence (§5). |
