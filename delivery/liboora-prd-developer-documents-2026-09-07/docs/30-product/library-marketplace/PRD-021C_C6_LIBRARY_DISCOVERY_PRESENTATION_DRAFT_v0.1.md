<!--
  PROVENANCE — PRD-021C Part C6 (Library Discovery Presentation)

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 NOT entered.

  READ THIS FIRST — THE TITLE CHANGED, AND THE CHANGE IS THE FINDING
  ------------------------------------------------------------------
  The supplied brief asked for "Library Discovery & RANKING". This part is
  titled "Library Discovery PRESENTATION" because the repository already
  assigns ranking and relevance elsewhere, and measurably so:

    BC Map L132        BC-23 Search Indexing owns "relevance, query rewriting"
    AR-1 read-model    "Discovery projection & query -> BC-23"
    C2 LSD-XC-002      MUST NOT create a second ranking or relevance system
    C2 LSD-FR-025/027  C2 already owns the ordering surface and is already
                       forbidden from defining a relevance formula

  C6 is therefore the PRESENTATION layer over an ordering that already exists.
  It does not rank. The authorising instruction expressly permitted this
  reduction: "Define C6 only as the library-marketplace presentation/integration
  layer if that is what repository authority supports."

  What this file does NOT do
  --------------------------
    - Creates no bounded context, edge, event, aggregate or invariant.
    - Creates no ranking system, no relevance formula, no score, no weight,
      no boost, no analyzer, no synonym list.
    - Creates no rating input (C5: ratings are V2).
    - Duplicates neither C2's ordering rules nor PRD-021B's student ranking.
    - Amends no FROZEN PRD and no Rank 1-6 artefact.
    - Mints no IMPL-* identifier. Confers no lifecycle stage.
-->

# PRD-021C — PART C6

## Library Discovery Presentation — the Marketplace Presentation Layer over `BC-23` Ordering

### v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Stage 3 has **not** been entered.

| Field | Value |
|---|---|
| **PRD** | `PRD-021C` Part **C6** |
| **Part title** | Library Discovery Presentation — the Marketplace Presentation Layer over `BC-23` Ordering |
| **Supplied title** | ~~*Library Discovery & Ranking*~~ — ⛔ **narrowed on repository evidence** (§1, §2) |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** — Stage 2 |
| **Structural classification** | ⭐ **Application / read composition capability of the Library domain** (`AR-1`; `MASTER_PRD.md` §8 **module 19**). ⛔ **NOT a bounded context.** ⛔ **NOT `BC-17`** |
| **Release** | **V1** — as module 19 already is at Rank 1 |
| **Identifier prefix** | `LDR-*` — collision-checked at **0** occurrences repo-wide (C5 §1.1) |
| **Owns** | ⛔ **No aggregate. No invariant. No business state. No ranking. No relevance. No score.** C6 owns **presentation of an ordering it receives**: how a result set is laid out, grouped, labelled, truncated, disclosed and degraded |
| **Consumes** | **C2** (the ordering surface, `LSD-FR-023`…`032`) · **C1** (the visibility gate) · **C3** (the field set rendered per result) · **C4** (the coarse availability indicator) · `BC-23` **indirectly through C2 only** — ⛔ C6 issues no query of its own |
| **Cross-part** | [`C0`](./PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md) · [`C1`](./PRD-021C_C1_MARKETPLACE_FOUNDATION_DRAFT_v0.1.md) · [`C2`](./PRD-021C_C2_LIBRARY_SEARCH_AND_LOCAL_DISCOVERY_DRAFT_v0.1.md) · [`C3`](./PRD-021C_C3_LIBRARY_PUBLIC_PROFILE_DRAFT_v0.1.md) · [`C4`](./PRD-021C_C4_LIVE_SEAT_AVAILABILITY_AND_BOOKING_DRAFT_v0.1.md) · [`C5`](./PRD-021C_C5_LIBRARY_RATINGS_AND_REVIEWS_DRAFT_v0.1.md) |

---

## §1. ⭐⭐ The ownership question, answered first

The authorising instruction required, before any authoring, that C6 *"verify
actual ownership of: search/indexing, relevance, availability, ranking"*, and
warned: *"Do NOT assume C6 owns ranking if repository assigns library
relevance/ranking to another existing capability."*

That verification was performed. **All four are already owned.** None is owned by
C6, and one of them is owned by C6's own sibling.

| Capability | Owner, measured | Authority |
|---|---|---|
| **Search & indexing** | **`BC-23` Search Indexing** — *"Owns indices, permission-aware indexing, tenant index isolation, relevance, query rewriting"* | BC Map **L132** |
| **Relevance** | **`BC-23`** — the same cell, the same sentence | BC Map **L132** |
| **Discovery projection & query** | **`BC-23`** | `AR-1` read-model table (`ARCHITECTURE_RULINGS.md` **L23**+) |
| **The V1 query contract `BC-23` publishes** | **`Library_PRD_v1.md` §14A** — FROZEN 2026-08-03 | [`ADR-0094`](../../00-governance/adr/ADR-0094-section-14a-is-the-v1-bc-23-discovery-contract.md), `XPC-OD-002` = **A** |
| **Ordering on the marketplace surface** | ⭐⭐ **C2, already** — `LSD-FR-023`, `LSD-FR-025`, `LSD-FR-026`, `LSD-FR-028`…`032` | C2 §7 |
| **Availability (capacity + coarse indicator)** | **`BC-04` Seating**, presented by **C4** | BC Map **L100**; C4 `LSB-FR-007`…`012` |
| **Ranking** | ⛔⛔ **Nobody owns a composite ranking, and none exists to own** | §2 |

### §1.1 ⭐⭐ The decisive measurement: C2 already owns the ordering surface

`LSD-XC-002` (C2 **L322** register, §8) reads:

> ⛔ **MUST NOT** create a second ranking or relevance system — BC Map **L132**;
> `ADR-0091` §3

⭐ **That exclusion binds C6 exactly as it binds C2.** C2 and C6 are parts of the
**same** capability — module 19 — not two capabilities that could each hold a
ranking. A C6 that defined a ranking would be *"a second ranking system"* by the
plainest reading of a constraint that C2 already published against itself.

And C2 has already specified the ordering rules the supplied brief asked C6 to
write:

| C2 requirement | What it already fixes |
|---|---|
| `LSD-FR-023` | Distance sort on the non-query browse surface |
| `LSD-FR-025` | On a **text query**, ordering **MUST** be `BC-23`'s relevance ordering, and C2 **MUST NOT** re-order across relevance bands |
| `LSD-FR-026` | On **non-query browse**, a declared deterministic post-retrieval sort, key published to the user, ⛔ never a computed relevance score |
| `LSD-FR-027` | C2 **MUST NOT** define, store or tune a relevance formula, scoring weight, boost, analyzer or synonym list |
| `LSD-FR-028` | Pagination **MUST** use the opaque cursor convention (BC Map §15.3, `PG-1`…`PG-4`) |
| `LSD-FR-029`…`031` | Counts and facets **MUST NOT** disclose platform or tenant volumes |
| `LSD-FR-032` | Search **MUST NOT** require authentication and **MUST NOT** personalise |
| `LSD-AC-006`, `LSD-AC-007` | The ordering criteria |

⭐ **Had C6 restated any of these, it would have created a duplicate-ownership
defect inside one PRD** — the precise defect the authorising instruction's
cross-part reconciliation list forbids (*"no duplicate ownership"*, *"no
duplicate ranking system"*).

### §1.2 §14A specifies **one** ordering, and it is not a ranking

`Library_PRD_v1.md` **§14A** — FROZEN, and by [`ADR-0094`](../../00-governance/adr/ADR-0094-section-14a-is-the-v1-bc-23-discovery-contract.md)
**the V1 `BC-23` discovery/query contract** — enumerates its discovery
capabilities at **L114**. The ordering it names is:

> **Distance-based Sorting**

⭐ **That is the whole of it.** ⛔ No composite score. ⛔ No weighted blend. ⛔ No
rating input. ⛔ No completeness input. ⛔ No freshness or recency input. ⛔ No
tie-break policy. ⛔ No ranking version. A frozen contract that names exactly one
sort, plus `BC-23`'s own relevance for text queries, is not an incomplete
ranking specification awaiting C6 — it is a **complete and deliberately narrow**
one.

### §1.3 ⭐ Why an ordering layer is lawful at all, and how far it extends

[`ADR-0091`](../../00-governance/adr/ADR-0091-prd-021b-b4-b5-b6-alignment.md) §3
settled the general question for `PRD-021B` B4, and its reasoning transfers:

> `XPB-CONF-001` — **DETERMINED** from Rank 1. B4's ordering layer is a lawful
> **read composition** … owns no aggregate, no invariant and no business state.

grounded in `MASTER_PRD.md` **L171**:

> `| 19 | Library Discovery & Enrollment | Composition over BC-19, BC-25, BC-29, BC-06, BC-02, BC-04, projected via BC-23 | *not a context* | V1 |`

⭐ **The permission and its limit come from the same sentence.** *Composition* is
authorised; *projected via `BC-23`* names who supplies the ordering. A read
composition may **arrange** what it receives. It may not **compute the merit** of
what it receives — that is `BC-23`'s *relevance*, and `ADR-0091` §3's own
narrowing is that the layer *"owns no … business state"*, which a persisted or
tuned score would be.

---

## §2. ⭐ What "ranking" would have required — and why it is unavailable

The supplied brief listed nine ranking inputs. Each was tested against the
repository **separately**, following the `ADR-0055` §3 discipline that
`ADR-0095` reused, rather than accepted or rejected as a block.

| # | Supplied ranking input | Availability, measured | Disposition |
|---|---|---|---|
| 1 | **Search relevance** | ✅ Exists — but it is **`BC-23`'s**, and C2 `LSD-FR-025` already forbids re-ordering across its bands | 🔗 **INTEGRATION** — consumed, never computed |
| 2 | **Distance** | ✅ Exists — §14A **L114** *Distance-based Sorting*; C2 `LSD-FR-023` already applies it | 📤 **DELEGATED to C2** |
| 3 | **Rating** | ⛔⛔ **DOES NOT EXIST** — deferred **V2** | ⛔ **UNAVAILABLE** — C5 §1.2 |
| 4 | **Rating count** | ⛔⛔ **DOES NOT EXIST** — same authority | ⛔ **UNAVAILABLE** — C5 §1.2 |
| 5 | **Availability** | ⚠ Exists **only as a coarse indicator** (`Available`/`Limited`/`Full`); live occupancy is **V2** and *"must not be invented"* | ⛔ **NOT an ordering input** — §4.4, `LDR-BR-003` |
| 6 | **Listing completeness** | ⚠ **Computable, but unauthorised as a rank input** — §14A names no such input, and it would be a merit judgement | ⛔ **REFUSED** — §4.5 |
| 7 | **Cold start** | ⚠ Meaningful only for a **learned or reputation-weighted** ranking. With inputs 3, 4, 6 unavailable there is no cold-start problem | ✅ **DISSOLVED** — §4.6 |
| 8 | **Deterministic versioning / tie-break** | ⚠ A ranking-version register presupposes a ranking to version | ✅ **REDUCED** to a tie-break C6 *does* own — §4.3 |
| 9 | **Anti-gaming** | ⭐ **Structurally satisfied**, not implemented — §4.7 | ✅ **SATISFIED by construction** |

**Tally: 2 delegated/integrated · 2 unavailable · 2 refused · 3
dissolved-or-satisfied.** ⚠ Re-derived by counting the disposition cells.

### §2.1 ⭐⭐ Two of the nine inputs are not merely deferred — they are *impossible*

Inputs 3 and 4 are **rating** and **rating count**. C5 §0 established that a
library rating capability cannot be lawfully authored: `Library_PRD_v1.md`
**L1016** (FROZEN, Rank 3) and `ARCHITECTURE_RULINGS.md` **§6 L291** both defer
it to **V2**, and §6's heading is *"Explicitly deferred — **do not invent**"*.

⭐ **A ranking formula that names an input which cannot exist is not a
specification — it is a promise no build can keep.** C6 therefore does not write
a formula with two holes in it, and does not write a formula with the holes
silently removed either. It records that **the composite ranking the brief
described is not constructible in V1**, and specifies the presentation layer that
*is*.

### §2.2 ⛔ No ML, no AI — and this is a structural fact, not a policy promise

The brief required *"no ML/AI"*. C6 introduces none, and the repository
independently forecloses it:

| Route | Why it is closed |
|---|---|
| A learned ranker inside C6 | C6 owns no business state (`AR-1`); model weights are business state |
| `BC-27` AI Assistance ranking discovery | `E-26` runs `BC-27 → BC-26, BC-23` — AI **reads from** search; it does not order for it. ⛔ Wrong direction |
| Relevance tuning via `BC-23` | ⛔ `LSD-FR-027`: no formula, weight, boost, analyzer or synonym list — and `LSD-XC-004` bars authoring `BC-23`'s internals |
| Personalisation from a viewer profile | ⛔ `LSD-FR-032`: no personalisation; the seeker surface is **anonymous** (`LIB-DISC-005`) |
| Behavioural signals from view telemetry | ⛔ `E-30`'s payload carries **no viewer identity** (BC Map **§17.2.1**) — there is no per-viewer history to learn from |

⭐ **The last row is the strongest.** The one V1 event about a library profile was
deliberately built to identify nobody ([`ADR-0096`](../../00-governance/adr/ADR-0096-profile-view-fact-produced-by-bc-19-over-new-edge-e-30.md)
§4.2). Personalised ranking is therefore not *forbidden pending review* — it is
**not computable from the data the architecture permits to exist.**

### §2.3 ⛔ No duplication of `PRD-021B`'s student discovery or ranking

⛔ **`PRD-021B` (`BC-11`/`BC-12`) is not consumed, not cited as a data source and
not extended by C6.** Its ordering layer concerns *people*; C6 concerns
*libraries*. They are separated by `X-05` (Matrix **L354**), which forbids
`LIBRARY MANAGEMENT ↔ BC-11…BC-17`, and by `ID-3` (BC Map **L180**), which
forbids the global band resolving *"which library a person attends"*.

⭐ **`ADR-0091` §3's *reasoning* is borrowed; its *requirements* are not.** C6
cites it for the proposition that a read composition may order lawfully — a
Rank-1-derived proposition of general application. ⛔ No `XPB-*` identifier is
consumed, restated or depended upon.

---

## §3. Identifier registers

| Register | Meaning | Range | Count | Contiguous |
|---|---|---|---|---|
| `LDR-FR-*` | V1 functional requirement | `LDR-FR-001` … `LDR-FR-022` | 22 | Yes |
| `LDR-BR-*` | Business rule | `LDR-BR-001` … `LDR-BR-009` | 9 | Yes |
| `LDR-XC-*` | Exclusion / negative constraint | `LDR-XC-001` … `LDR-XC-014` | 14 | Yes |
| `LDR-AC-*` | Acceptance criterion (Given/When/Then) | `LDR-AC-001` … `LDR-AC-014` | 14 | Yes |

**Total: 59 identifiers.** ⛔ **No orphan** — the coverage map is §9.0.

### §3.1 Normative language

| Term | Meaning |
|---|---|
| **MUST** / **MUST NOT** | Absolute requirement. A build violating it is defective |
| **SHOULD** | Strong recommendation; deviation requires a recorded reason |
| **MAY** | Genuinely optional |
| *(no keyword)* | Explanatory prose. Creates **no** requirement. Quoted `>` blocks are rationale and are **not** normative |

### §3.2 Ownership vocabulary

Reusing `PRD-021A` A8 §0.5's five labels verbatim, because they are the
repository's established vocabulary for exactly this problem:

| Label | Meaning |
|---|---|
| ✅ **OWNED BY C6** | C6 decides it, and no existing owner does |
| 🔗 **INTEGRATION** | An existing owner decides it; C6 states how it consumes the decision |
| 📤 **DELEGATED** | An existing owner decides it and C6 adds nothing at all |
| ⛔ **REFUSED / UNAVAILABLE** | C6 records why it cannot be specified |
| 🔮 **FUTURE / V2+** | Deliberately out of band |

`LDR-BR-001` — ✅ **OWNED BY C6.** C6 **MUST NOT** convert an integration
dependency into ownership. Where C6 describes a capability owned elsewhere it
**MUST** cite the owner's identifier and **MUST NOT** restate that capability's
rules as its own.

> ⭐ This is `LCT-INV-001` from `PRD-021A` A8 §0.5, adopted rather than reinvented.
> It is the rule that keeps §4 short: everything C2 already says is **cited**,
> never repeated.

---

## §4. V1 requirements — the presentation layer

### §4.1 The boundary, stated normatively

`LDR-FR-001` — ✅ **OWNED.** C6 **MUST** treat the ordered result sequence it
receives from C2 as **authoritative and final as to order**.

`LDR-FR-002` — ⛔ C6 **MUST NOT** re-order, re-rank, re-score, boost, demote,
pin, promote, insert, inject or interleave any result within that sequence.

`LDR-FR-003` — ⛔ C6 **MUST NOT** define, compute, store, persist, cache, tune,
version or expose a relevance score, ranking score, composite score, weight,
boost factor, decay function, prior or quality signal.

`LDR-BR-002` — ⭐ `LDR-FR-002` and `LDR-FR-003` are **not new prohibitions.**
They are `LSD-XC-002` and `LSD-FR-027` applied to the part that sits downstream
of C2, stated here because a reader arriving at a part once titled *"& Ranking"*
must find the refusal in **this** document and not only in a sibling.

`LDR-FR-004` — ✅ **OWNED.** C6 **MUST** publish the **sort key in force** to the
user in plain language on every ordered surface — for example *"Nearest first"*
or *"Best match"*.

`LDR-BR-003` — The publishable key set is **closed** and contains exactly two
members: **`RELEVANCE`** (text-query surfaces, supplied by `BC-23` per
`LSD-FR-025`) and **`DISTANCE`** (non-query browse, per `LSD-FR-023` and §14A
**L114**). ⛔ A third key **MUST NOT** be added by C6; ⛔ specifically **not**
`RATING` (C5 — does not exist), **not** `AVAILABILITY` (§4.4), **not**
`COMPLETENESS` (§4.5), **not** `POPULARITY`, **not** `RECENCY`, **not**
`FEATURED`, **not** `SPONSORED`.

### §4.2 Layout, grouping and disclosure — ✅ what C6 genuinely owns

`LDR-FR-005` — ✅ **OWNED.** C6 **MUST** define the result-row composition: which
of C3's public fields appear on a row, in what visual hierarchy, at what
truncation length.

`LDR-FR-006` — ⛔ A result row **MUST NOT** contain a field absent from §14A.5,
and **MUST NOT** contain any field C3 marks owner-only or never-public.

`LDR-FR-007` — ✅ **OWNED.** C6 **MAY** group results under headings that are
**purely descriptive of the sort key already in force** — for example distance
bands *"Within 1 km"*, *"1–3 km"* under `DISTANCE`.

`LDR-BR-004` — A grouping heading **MUST NOT** alter the sequence, **MUST NOT**
imply merit, and **MUST NOT** be derived from any input outside the sort key in
force. ⛔ *"Top picks"*, *"Best value"*, *"Highly recommended"* and *"Popular
nearby"* are merit groupings and are excluded.

`LDR-FR-008` — ✅ **OWNED.** C6 **MUST** render the coarse availability indicator
C4 supplies (`Available`/`Limited`/`Full`) as a **row attribute**, at C4's
fidelity, unmodified.

`LDR-FR-009` — ⛔ C6 **MUST NOT** convert that indicator into a number, a
percentage, a bar, a gauge, a seat count, a trend or an ordering input.

`LDR-FR-010` — ⛔ C6 **MUST NOT** display a result count, total, *"showing X
of Y"*, page count or *"N libraries near you"* that discloses the platform-wide
or area-wide library total.

`LDR-BR-005` — 📤 **DELEGATED.** `LDR-FR-010` restates no rule: `LSD-FR-029` and
`LIB-18.2` already own the volume-disclosure prohibition. It appears here only
because a *presentation* layer is where a total is most naturally added by a
designer, and the citation must be reachable from the layout requirements.

`LDR-FR-011` — 📤 **DELEGATED.** Pagination **MUST** use the opaque cursor
convention already established — BC Map §15.3 `PG-1`…`PG-4` and C2
`LSD-FR-028`. ⛔ C6 defines **no** pagination mechanism, no page-size policy and
no cursor format.

### §4.3 ✅ Tie-break — the one determinism rule C6 does own

`LDR-FR-012` — ✅ **OWNED.** Where the sort key in force yields **equal** values
for two or more results, C6 **MUST** apply a single declared, deterministic,
stable tie-break so that the presented order is reproducible.

`LDR-FR-013` — The tie-break **MUST** be a **stable, opaque, non-semantic**
ordering of the result identifiers as supplied. It **MUST NOT** be random,
time-seeded, session-seeded, viewer-derived, round-robin, rotational or
weighted.

`LDR-BR-006` — ⭐ **The tie-break MUST NOT be dressed as a preference.** It is a
mechanical stability device. ⛔ It **MUST NOT** be documented, labelled or
explained to the user as a ranking, quality judgement or recommendation, and ⛔
**MUST NOT** be tuned to favour any library, tier, subscription plan or
`TenantTier`.

> ⭐ **This is the honest residue of supplied item 8** (*"deterministic
> versioning/tie-break"*). A **ranking version register** presupposes a ranking
> to version, and §2 measured that none exists. What genuinely remains is the
> narrow problem of two libraries at an identical distance — a real,
> presentation-layer, testable concern. ⛔ C6 mints **no ranking-version
> identifier**, because versioning nothing is not determinism, it is theatre.

`LDR-FR-014` — ⛔ C6 **MUST NOT** vary the presented order by viewer, session,
device, cookie, anonymous session identifier, request time or A/B assignment.

`LDR-BR-007` — 🔗 **INTEGRATION.** `LDR-FR-014` is the presentation-side
consequence of `LSD-FR-032` (no personalisation) and `LIB-14B.17`, and is
enforceable **because** `LIB-14B.6` restricts the anonymous session identifier to
rate limiting and `LIB-14B.42` forbids identifying the visitor.

### §4.4 ⛔ Availability is not an ordering input

`LDR-FR-015` — ⛔ C6 **MUST NOT** order, group by merit, filter by default or
otherwise privilege results on the basis of the coarse availability indicator.

`LDR-BR-008` — Refused on **three** independent grounds, any one sufficient:

| # | Ground | Authority |
|---|---|---|
| 1 | Ordering by availability makes it a **quality signal**, which C5 excludes | `LRR-FR-007`; `LRR-XC-008` |
| 2 | Live occupancy is **V2** and *"must not be invented"*; a coarse three-value indicator cannot bear an ordering weight without implying precision it does not have | `SEAT-XC-009`; `LIB-14B.13`; `ARCHITECTURE_RULINGS.md` **§6** |
| 3 | ⭐ **It would leak occupancy by inference.** A list ordered by availability discloses the relative fullness of every library in it — an inference route `LSD-XC-008` closes *"by value **or by inference**"* | `LSD-XC-008`; `LIB-14B.11`…`14` |

⭐ **Ground 3 is the one a designer would miss.** Hiding the seat count and then
sorting by it publishes the same fact in a different alphabet.

### §4.5 ⛔ Listing completeness is not an ordering input

`LDR-FR-016` — ⛔ C6 **MUST NOT** order or privilege results on the basis of
listing completeness, field-fill percentage, photo count, description length or
profile richness.

`LDR-FR-017` — ✅ **OWNED.** A result row **MUST** render gracefully when an
optional public field is absent: the field is **omitted** and the layout closes
up. ⛔ No *"incomplete listing"*, *"add more info"*, completeness meter, percent
badge or warning icon **MUST** be shown on any seeker-facing surface.

`LDR-BR-009` — ⭐ Completeness is **computable but unauthorised as a rank
input**, and the distinction matters. §14A **L114** names one sort; ordering by
completeness would introduce a **merit judgement the frozen contract does not
authorise**, and would rank a library **on the diligence of its owner rather
than on its fitness for the seeker's query** — a rating substitute in all but
name (`LRR-FR-005`).

> ⚠ **A tempting counter-argument, recorded and rejected.** One could argue
> completeness is a *data-quality* signal rather than a *merit* signal, and
> therefore lawful. It is rejected because the seeker cannot tell the difference:
> a list where fuller listings appear first **is** a list that recommends them.
> ⭐ Recording the rejected argument is deliberate — a future owner reconsidering
> this should see it was considered, not overlooked.

### §4.6 ✅ Cold start — dissolved, not solved

`LDR-FR-018` — A newly verified and activated library **MUST** appear in results
under the **same rules** as every other library, from the moment `C1`'s
visibility gate admits it (`LIB-DISC-002`: verified **and** activated).

`LDR-FR-019` — ⛔ C6 **MUST NOT** apply a new-listing boost, a new-listing
penalty, a probation period, a *"new"* badge, a grace ranking, a warm-up window
or a reduced-visibility state.

> ⭐⭐ **Supplied item 7 is DISSOLVED, and this is a genuine reduction rather than
> a deferral.** Cold start is a problem *only* for rankings driven by accumulated
> signal — ratings, engagement, reputation. §2 measured that inputs 3, 4 and 6
> are unavailable or refused, so a new library is **already** ordered identically
> to an established one: by distance, or by `BC-23` relevance over its text
> fields. ⛔ There is no cold-start disadvantage to compensate for, and inventing
> a boost to compensate for a disadvantage that does not exist would **create**
> the ranking asymmetry it purported to fix.

### §4.7 ✅ Anti-gaming — satisfied by construction

`LDR-FR-020` — ⛔ C6 **MUST NOT** expose the sort key's underlying values, the
tie-break's internal ordering, the index's internal identifiers or any diagnostic
that would let an owner reverse-engineer position.

`LDR-FR-021` — ⛔ C6 **MUST NOT** provide, and **MUST NOT** be extended to
provide, a paid, sponsored, promoted, featured or subscription-tier-influenced
placement.

`LDR-FR-022` — ⛔ C6 **MUST NOT** read `TenantTier`, `Quota`, subscription state,
`BC-20` billing state or `BC-21` entitlement state as an ordering or presentation
input.

> ⭐⭐ **Supplied item 9 is SATISFIED BY CONSTRUCTION, and this is the strongest
> result in the part.** Anti-gaming defences are needed when a ranking has
> manipulable inputs. Enumerate C6's inputs: **distance** — a physical fact an
> owner cannot inflate without moving the building; **`BC-23` relevance over
> §14A.5 public text** — owned, tuned and specified entirely by `BC-23`, which
> C6 may not influence (`LSD-FR-027`, `LSD-XC-004`); **a mechanical tie-break**
> — non-semantic and untunable by rule (`LDR-BR-006`).
>
> ⭐ There is **nothing to game**. Not *"gaming is monitored"* — gaming has no
> surface. ⚠ The one residual manipulation route is **keyword stuffing** in the
> public text fields, and that route belongs to `BC-23`'s analyzer and query
> rewriting (**L132**), which ⛔ C6 and C2 are both forbidden to author. It is
> disclosed, not claimed as solved, and routed in §7.

### §4.8 🔗 Fallback and degradation

⛔ **Slot `023` in the `LDR-FR-*` register is deliberately NOT allocated.** No
identifier is minted here — see the note below.

> ⚠ **This slot is intentionally empty, and the emptiness is recorded rather
> than silently skipped.** A fallback requirement was drafted here stating that
> C6 must present a degraded ordering if `BC-23` is unavailable. It was
> **withdrawn** on measurement: what happens when the index is unavailable is a
> property of the **query layer**, owned by C2 and ultimately by `BC-23`
> (**L132**), not of the presentation layer — and `LSD-FR-025`/`026` already fix
> what order C2 supplies in each mode. Specifying a C6-side fallback order would
> have created a **second ordering authority active precisely when the first
> failed**, which is the worst possible moment to have two. ⛔ Withdrawn, and
> `LDR-FR-*` therefore stops at **022**, keeping the register contiguous at 22
> members.
>
> ⭐ **The withdrawn slot number is written as `023` and NOT as a fully formed
> `LDR-FR-` identifier anywhere in this document.** This is deliberate: a bare
> identifier token would be indistinguishable, to any grep or contiguity check,
> from an allocated requirement, and the register would measure **23** members
> against a declared **22**. ⛔ An unallocated slot must not be rendered as an
> allocated one. The withdrawal is therefore recorded in prose and by slot
> number, and the `LDR-FR-*` token space contains exactly its 22 real members.

`LDR-FR-022` is the final functional requirement. ⭐ **Degradation is therefore
📤 DELEGATED in full**: whatever sequence C2 supplies, C6 presents under
`LDR-FR-001`, publishing the sort key in force under `LDR-FR-004`. If C2 supplies
a distance ordering because relevance is unavailable, the label the user sees
changes from *"Best match"* to *"Nearest first"* — ⭐ **the presentation layer's
correct and only response to a degraded upstream is to tell the truth about which
ordering it is showing.**

---

## §5. ⭐ Determinism — stated as a consequence, not an aspiration

The brief required *"deterministic versioning/tie-break"* and *"deterministic V1
ordering"*. C6 delivers determinism, and it is worth being precise about **why**
it holds:

| # | Property | Why it holds |
|---|---|---|
| 1 | The **input set** is deterministic | The visibility gate is a boolean over `LIB-DISC-002`/`004`, evaluated by C1 |
| 2 | The **sort key set** is closed at **two** members | `LDR-BR-003`; §14A **L114**; `LSD-FR-023`/`025` |
| 3 | Neither key reads a **mutable merit signal** | Inputs 3, 4 unavailable (C5); 5, 6 refused (§4.4, §4.5) |
| 4 | **Ties** resolve by a stable non-semantic rule | `LDR-FR-012`, `LDR-FR-013` |
| 5 | Order does **not** vary by viewer, session or time | `LDR-FR-014`; `LSD-FR-032` |
| 6 | ⛔ There is **no score to version** | §2; `LDR-FR-003` |

⭐⭐ **Row 6 is the finding.** The brief assumed determinism would need to be
*engineered* — a version register, a frozen weight vector, a documented tie-break
cascade. In this repository it is **structural**: an ordering with two declared
keys, no merit inputs, no personalisation and a stable tie-break is deterministic
because there is nothing in it that could vary. ⛔ **Zero ranking-version
identifiers were minted**, and C5 `LRR-BR-008` records the same result from the
ratings side.

---

## §6. Cross-part boundary — ⛔ no duplicate ownership

| Concern | Owner | C6's relation |
|---|---|---|
| Index, relevance, analyzers, query rewriting | **`BC-23`** (BC Map **L132**) | ⛔ None. C6 never queries `BC-23` |
| The V1 query contract | **`Library_PRD_v1.md` §14A** ([`ADR-0094`](../../00-governance/adr/ADR-0094-section-14a-is-the-v1-bc-23-discovery-contract.md)) | 🔗 Cited |
| Visibility gate, tenant-less split, auth boundary | **C1** | 🔗 Consumed |
| Query, filters, ordering, pagination, counts | **C2** | 📤 **DELEGATED in full** |
| Public field set and per-field source | **C3** | 🔗 Consumed for row composition |
| Coarse availability indicator | **C4** over `BC-04` | 🔗 Rendered unmodified |
| Ratings / reviews | ⛔ **Nobody — V2** | ⛔ Unavailable (**C5**) |
| Trust, safety, reporting, moderation | **`BC-13`** / `PRD-020` | ⛔ None — see **C7** |
| Student discovery & ranking | **`PRD-021B`** | ⛔ **None.** `X-05`; `ID-3` — §2.3 |
| Owner-facing analytics | **`BC-26`** / `PRD-009` | ⛔ None. ⭐ `ProfileViews` **MUST NOT** be an ordering or presentation input (`LRR-FR-006`, `LDR-XC-009`) |

---

## §7. Open decisions — routed, not resolved

⛔ **This part decides nothing.** Registered in `C0` §6 as **`XPC-OD-009`**.

| # | Decision required | Owner | Blocks | Smallest lawful act |
|---|---|---|---|---|
| **`XPC-OD-009`** | **Who specifies `BC-23`'s defence against keyword stuffing in §14A.5 public text fields?** ⚠ Measured: the one residual manipulation route into C6's ordering runs through `BC-23`'s analyzer and query rewriting (**L132**), and ⛔ **both C2 and C6 are forbidden to author it** (`LSD-FR-027`, `LSD-XC-004`). `PRD-015`, `BC-23`'s registered owner, is **`PLANNED` and absent from disk** (`PRD_REGISTRY.md` **L315**) — an observation [`ADR-0094`](../../00-governance/adr/ADR-0094-section-14a-is-the-v1-bc-23-discovery-contract.md) explicitly **left standing** rather than closed | **Architecture Owner** *(index internals)* **+ Product Owner** *(acceptable-use rules for public text)* | ⛔ **Nothing in V1.** C6's ordering is otherwise ungameable (§4.7), and the route affects text-query relevance only — never the distance sort | Record it against `PRD-015` when that PRD is authored. ⛔ **C6 MUST NOT** mitigate it by adding a ranking input, a completeness penalty or a moderation check |

⚠ **`XPC-OD-009` is DISCLOSED, not solved, and deliberately so.** The tempting
mitigation — demote listings whose text looks stuffed — would require C6 to
compute a quality judgement, which `LDR-FR-003` forbids and which would
reintroduce every ranking problem §2 measured away.

---

## §8. Exclusions

| # | Excluded | Authority |
|---|---|---|
| `LDR-XC-001` | ⛔ **MUST NOT** create a second ranking, relevance or scoring system | BC Map **L132**; `LSD-XC-002`; `ADR-0091` §3 |
| `LDR-XC-002` | ⛔ **MUST NOT** define, store, tune or version a score, weight, boost, decay or prior | `LDR-FR-003`; `LSD-FR-027` |
| `LDR-XC-003` | ⛔ **MUST NOT** re-order, pin, promote, demote, insert or interleave within C2's sequence | `LDR-FR-002`; `LSD-FR-025` |
| `LDR-XC-004` | ⛔ **MUST NOT** author `BC-23`'s index internals, analyzers, scoring or query rewriting | BC Map **L132**; `LSD-XC-004` |
| `LDR-XC-005` | ⛔ **MUST NOT** add a third sort key to the closed set `{RELEVANCE, DISTANCE}` | `LDR-BR-003`; §14A **L114** |
| `LDR-XC-006` | ⛔ **MUST NOT** use a rating or rating count as an ordering, grouping or filter input | **C5** §1.2; `LSD-XC-009`; `LRR-XC-015` |
| `LDR-XC-007` | ⛔ **MUST NOT** use availability as an ordering or merit input, by value or by inference | `LDR-BR-008`; `LSD-XC-008`; `SEAT-XC-009` |
| `LDR-XC-008` | ⛔ **MUST NOT** use listing completeness, photo count or description length as an ordering input; ⛔ no completeness meter or badge | `LDR-FR-016`, `LDR-FR-017`; `LDR-BR-009` |
| `LDR-XC-009` | ⛔ **MUST NOT** use `ProfileViews`, view counts, popularity or trending as an ordering or presentation input | `LRR-FR-005`, `LRR-FR-006`; C3 `LPP-XC-015`; §14A.5 never-public |
| `LDR-XC-010` | ⛔ **MUST NOT** apply a new-listing boost, penalty, probation, badge or warm-up | `LDR-FR-018`, `LDR-FR-019` |
| `LDR-XC-011` | ⛔ **MUST NOT** provide paid, sponsored, promoted, featured or tier-influenced placement; ⛔ **MUST NOT** read `TenantTier`, `BC-20` or `BC-21` state | `LDR-FR-021`, `LDR-FR-022` |
| `LDR-XC-012` | ⛔ **MUST NOT** personalise, or vary order by viewer, session, device, time or A/B assignment | `LDR-FR-014`; `LSD-FR-032`; `LIB-14B.17`, `LIB-14B.42` |
| `LDR-XC-013` | ⛔ **MUST NOT** use any ML, learned ranker, embedding, model or AI signal in ordering or presentation | §2.2; `E-26` direction; `LSD-FR-027` |
| `LDR-XC-014` | ⛔ **MUST NOT** consume, cite as a data source, or duplicate `PRD-021B` student discovery/ranking, or any `BC-11`…`BC-17` signal | `X-05` (Matrix **L354**); `ID-3` (BC Map **L180**); `LSD-XC-010` |

---

## §9. Acceptance criteria

Given/When/Then form. ⚠ **0 of 14 is proven by a test — no test exists.**

### §9.0 Coverage map — ⛔ no orphan requirement, ⛔ no orphan criterion

| Criterion | Exercises |
|---|---|
| `LDR-AC-001` | `LDR-FR-001`, `LDR-FR-002`, `LDR-BR-002`, `LDR-XC-003` |
| `LDR-AC-002` | `LDR-FR-003`, `LDR-XC-001`, `LDR-XC-002` |
| `LDR-AC-003` | `LDR-FR-004`, `LDR-BR-003`, `LDR-XC-005` |
| `LDR-AC-004` | `LDR-FR-005`, `LDR-FR-006` |
| `LDR-AC-005` | `LDR-FR-007`, `LDR-BR-004` |
| `LDR-AC-006` | `LDR-FR-008`, `LDR-FR-009` |
| `LDR-AC-007` | `LDR-FR-010`, `LDR-BR-005`, `LDR-FR-011` |
| `LDR-AC-008` | `LDR-FR-012`, `LDR-FR-013`, `LDR-BR-006` |
| `LDR-AC-009` | `LDR-FR-014`, `LDR-BR-007`, `LDR-XC-012` |
| `LDR-AC-010` | `LDR-FR-015`, `LDR-BR-008`, `LDR-XC-007` |
| `LDR-AC-011` | `LDR-FR-016`, `LDR-FR-017`, `LDR-BR-009`, `LDR-XC-008` |
| `LDR-AC-012` | `LDR-FR-018`, `LDR-FR-019`, `LDR-XC-010` |
| `LDR-AC-013` | `LDR-FR-020`, `LDR-FR-021`, `LDR-FR-022`, `LDR-XC-011` |
| `LDR-AC-014` | `LDR-XC-006`, `LDR-XC-009`, `LDR-XC-013`, `LDR-XC-014`, `LDR-BR-001` |

### §9.1 The criteria

`LDR-AC-001` — **C2's sequence is presented unmodified**
> **Given** a text query returning five libraries in the order `[A, B, C, D, E]` from C2
> **When** C6 presents that result set
> **Then** the presented order is exactly `A, B, C, D, E`
> **And** no result has been pinned, promoted, demoted, inserted or interleaved
> **And** no result appears that C2 did not supply.

`LDR-AC-002` — **No score exists anywhere in the presented output**
> **Given** any ordered result set
> **When** the rendered output, the API payload and the persisted state of the presentation layer are all inspected
> **Then** no relevance score, ranking score, composite score, weight, boost factor, decay value or prior is present
> **And** no such value is stored, cached or logged by the presentation layer.

`LDR-AC-003` — **The sort key in force is published, and only from the closed set**
> **Given** a text-query surface and a non-query browse surface
> **When** each is presented
> **Then** the text-query surface declares `RELEVANCE` in plain language and the browse surface declares `DISTANCE`
> **And** no surface declares `RATING`, `AVAILABILITY`, `COMPLETENESS`, `POPULARITY`, `RECENCY`, `FEATURED` or `SPONSORED`.

`LDR-AC-004` — **A row carries only lawful public fields**
> **Given** a library whose record includes public fields, owner-only fields and tenant-operational fields
> **When** its result row is presented
> **Then** every field shown appears in §14A.5
> **And** no field C3 marks owner-only or never-public is present, in the rendered row or in the row's API payload.

`LDR-AC-005` — **Grouping headings describe the sort key and never imply merit**
> **Given** a browse surface ordered by `DISTANCE`
> **When** results are grouped
> **Then** the headings describe distance bands only
> **And** no heading reads *"Top picks"*, *"Best value"*, *"Highly recommended"* or *"Popular nearby"*
> **And** the sequence within and across groups is identical to C2's supplied sequence.

`LDR-AC-006` — **Availability renders at C4's fidelity and no finer**
> **Given** three libraries whose C4 indicators are `Available`, `Limited` and `Full`
> **When** their rows are presented
> **Then** each shows exactly its coarse indicator
> **And** no row shows a seat count, free-seat count, percentage, bar, gauge, occupancy trend or any value from which a count could be inferred.

`LDR-AC-007` — **No volume disclosure, and pagination is the inherited cursor**
> **Given** a query matching many libraries
> **When** the first page is presented and the next page requested
> **Then** no total count, *"showing X of Y"*, page count or *"N libraries near you"* appears
> **And** the next page is requested with an opaque server-generated cursor
> **And** the cursor exposes no offset, ordering key, database identifier, table name or index structure
> **And** an expired or malformed cursor produces a domain error, never a silent reset to page one.

`LDR-AC-008` — **Ties resolve stably and mechanically**
> **Given** two libraries at an identical distance from the same point, all other inputs equal
> **When** the same browse query is executed three times against an unchanged index
> **Then** the relative order of those two results is identical on all three executions
> **And** the order does not change with request time, session, device or repetition
> **And** the tie-break is not labelled, documented or explained to the user as a ranking, recommendation or quality judgement.

`LDR-AC-009` — **Order does not vary by viewer**
> **Given** the same query issued by two different anonymous clients from the same location, with different devices, user agents and anonymous session identifiers
> **When** both result sets are presented
> **Then** the two orders are identical
> **And** no A/B assignment, cookie, session value or device attribute has influenced either order.

`LDR-AC-010` — **Availability does not order, and does not leak by inference**
> **Given** ten libraries at mixed distances with mixed availability indicators
> **When** the browse surface is presented
> **Then** the order is by distance alone
> **And** no `Full` library has been demoted and no `Available` library promoted
> **And** the presented order permits no inference about the relative fullness of any library.

`LDR-AC-011` — **Completeness neither orders nor is displayed**
> **Given** two libraries at an identical distance, one with a full listing and one with only the mandatory fields
> **When** both rows are presented
> **Then** neither is ordered ahead of the other on account of completeness
> **And** the sparse row omits its absent optional fields with the layout closing up
> **And** no completeness meter, percentage, *"incomplete listing"* label, *"add more info"* prompt or warning icon appears on the seeker-facing surface.

`LDR-AC-012` — **A new library is ordered identically to an established one**
> **Given** a library verified and activated one minute ago, and an established library at the same distance
> **When** the browse surface is presented
> **Then** the new library appears at the position its distance dictates
> **And** it carries no *"new"* badge, no probation state and no reduced visibility
> **And** it receives neither a boost nor a penalty for its age.

`LDR-AC-013` — **Placement cannot be bought, and internals are not exposed**
> **Given** two libraries at an identical distance on different `TenantTier` values and different subscription states
> **When** the browse surface is presented
> **Then** their relative order is unaffected by tier, subscription, billing or entitlement state
> **And** no result is marked sponsored, promoted or featured
> **And** the response exposes no sort-key value, tie-break internal, index identifier or ordering diagnostic.

`LDR-AC-014` — **No forbidden input reaches the presentation layer**
> **Given** a fully instrumented presentation of any ordered result set
> **When** every input the layer reads is enumerated
> **Then** the set contains only: C2's ordered sequence, C1's visibility outcome, C3's public field values, and C4's coarse indicator
> **And** it contains **no** rating, rating count, `ProfileViews` value, view count, popularity signal, ML or embedding output, and **no** `BC-11`…`BC-17` social signal
> **And** no capability owned elsewhere has had its rules restated as C6's own.

---

## §10. Traceability to authority

| Requirement group | Governing authority |
|---|---|
| §1 — ownership determination | BC Map **L132** (`BC-23` owns relevance); `AR-1` read-model table; [`ADR-0094`](../../00-governance/adr/ADR-0094-section-14a-is-the-v1-bc-23-discovery-contract.md); C2 `LSD-FR-023`…`032`, `LSD-XC-002`, `LSD-XC-004` |
| §1.2 — the one frozen ordering | `Library_PRD_v1.md` **§14A L114** — *Distance-based Sorting* (**FROZEN** 2026-08-03) |
| §1.3 — why an ordering layer is lawful | `MASTER_PRD.md` **L171** module 19 (**Rank 1**); [`ADR-0091`](../../00-governance/adr/ADR-0091-prd-021b-b4-b5-b6-alignment.md) §3; `AR-1` |
| §2 — the nine inputs | **C5** §1.2 (ratings **V2**); `SEAT-XC-009`; `LIB-14B.11`…`14`; `ARCHITECTURE_RULINGS.md` **§6** |
| §2.2 — no ML/AI | `E-26` (BC Map **L339**) direction; `LSD-FR-027`; `LSD-FR-032`; BC Map **§17.2.1** (no viewer identity) |
| §2.3 — no `PRD-021B` duplication | `X-05` (Matrix **L354**); `ID-3` (BC Map **L180**); `LSD-XC-010` |
| `LDR-FR-001`…`004`, `LDR-BR-002`, `LDR-BR-003` | `LSD-FR-023`, `025`, `026`, `027`; `LSD-XC-002`; §14A **L114** |
| `LDR-FR-005`…`011`, `LDR-BR-004`, `LDR-BR-005` | §14A.5; C3 `LPP-FR-001`…`029`; C4 `LSB-FR-007`…`012`; `LSD-FR-028`…`031`; `LIB-18.2`; BC Map §15.3 `PG-1`…`PG-4` |
| `LDR-FR-012`…`014`, `LDR-BR-006`, `LDR-BR-007` | `LSD-FR-032`; `LIB-14B.6`, `LIB-14B.17`, `LIB-14B.42` |
| `LDR-FR-015`, `LDR-BR-008` | `SEAT-XC-009`; `LIB-14B.11`…`14`; `LSD-XC-008`; **C5** `LRR-FR-007` |
| `LDR-FR-016`, `LDR-FR-017`, `LDR-BR-009` | §14A **L114**; **C5** `LRR-FR-005` |
| `LDR-FR-018`, `LDR-FR-019` | `LIB-DISC-002`; C1 visibility gate |
| `LDR-FR-020`…`022` | `LIB-18.2`; BC Map **L129** (`BC-20`), **L130** (`BC-21`); `MP-SCOPE-06` |
| §5 — determinism | `LDR-BR-003`; **C5** `LRR-BR-008`; §14A **L114** |
| §7 `XPC-OD-009` | BC Map **L132**; `PRD_REGISTRY.md` **L315**; [`ADR-0094`](../../00-governance/adr/ADR-0094-section-14a-is-the-v1-bc-23-discovery-contract.md) |

---

## §11. Status

**`DRAFT` · Stage 2 · NOT FROZEN · NOT APPROVED · NOT BASELINED · Rank: none.**
Stage 3 **not** entered, and **no Stage-3 alignment record exists for
`PRD-021C`**.

⭐⭐ **C6 is a PRESENTATION layer, not a ranking part**, and the reduction is
evidenced rather than asserted: `BC-23` owns relevance (BC Map **L132**), §14A
names exactly one sort (**L114**), C2 already owns the ordering surface
(`LSD-FR-023`…`032`), and `LSD-XC-002` already forbids a second ranking system.

**Self-measurement — what this part creates:**

| Class | Count | Note |
|---|---|---|
| New bounded contexts | **0** | Count remains **31** (23 in V1) |
| New context edges | **0** | Set remains **29**; `E-27` still permanently vacant |
| New domain events | **0** | ⛔ None registered, ⛔ none proposed |
| New aggregates / business state | **0** | ⛔ Including zero persisted scores |
| New ranking or relevance systems | **0** | ⭐ The central finding — §1, §2 |
| New sort keys | **0** | The set is **closed at 2**: `RELEVANCE`, `DISTANCE` |
| New ranking-version identifiers | **0** | ⭐ Refused — versioning nothing is theatre (`LDR-BR-006`) |
| New pagination mechanisms | **0** | 📤 `PG-1`…`PG-4` inherited |
| ML / AI components | **0** | §2.2 — structurally foreclosed, not merely prohibited |
| ADRs written | **0** | 0 required |
| Rank 1–6 documents modified | **0** | §14A, BC Map, `AR-1` all **byte-unchanged** |
| `IMPL-*` minted | **0** | — |
| Lines of application code | **0** | — |
| Identifiers minted | **59** | 22 FR · 9 BR · 14 XC · 14 AC |

⚠ **One identifier slot was deliberately not allocated** — slot `023` of the
`LDR-FR-*` register, the withdrawn fallback requirement (§4.8). The register
stops at **022** and remains contiguous at **22** members; the withdrawal is
recorded, not hidden. ⭐ **The slot is referred to by number only, never as a
formed `LDR-FR-` token**, so that a grep or contiguity check measures the
register at its true size of 22 rather than at 23 (§4.8).

⚠ **Not proven:** **0** of the 14 acceptance criteria are proven by an executed
test.

⭐ **One open decision** is routed and **not** resolved: **`XPC-OD-009`**
(keyword-stuffing defence in `BC-23`), owners **Architecture Owner + Product
Owner**. ⛔ It blocks nothing in V1.

---

## §12. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-03 | Part created at **Stage 2**. ⭐⭐ **The supplied title *"Library Discovery & Ranking"* was NARROWED to *"Library Discovery Presentation"* on measured repository evidence**, exercising the authorising instruction's own permission (*"Define C6 only as the library-marketplace presentation/integration layer if that is what repository authority supports"*). All four capabilities the instruction told C6 to verify were found **already owned**: **search/indexing** and **relevance** by **`BC-23`** in one sentence of BC Map **L132**; **discovery projection & query** by `BC-23` per `AR-1`; **availability** by `BC-04` presented through C4. ⭐⭐ **And the ordering surface was found owned by C6's own sibling**: C2 `LSD-FR-023`/`025`/`026`/`027`/`028`…`032` already fix distance sort, relevance ordering, post-retrieval sort, cursor pagination and count suppression, while **`LSD-XC-002`** already reads *"⛔ MUST NOT create a second ranking or relevance system"* — a constraint that binds C6 identically, since C2 and C6 are parts of the **same** capability (module 19), not two capabilities each entitled to a ranking. ⭐ **§14A (FROZEN 2026-08-03), which [`ADR-0094`](../../00-governance/adr/ADR-0094-section-14a-is-the-v1-bc-23-discovery-contract.md) made the V1 `BC-23` query contract, names exactly ONE ordering at L114 — *Distance-based Sorting*** — ⛔ no composite score, no weights, no tie-break cascade, no ranking version. ⭐ **The nine supplied ranking inputs were tested SEPARATELY**, per the `ADR-0055` §3 discipline: **2 delegated/integrated** (relevance → `BC-23`; distance → C2), **2 UNAVAILABLE** (**rating** and **rating count** — deferred **V2** by `Library_PRD_v1.md` **L1016** and `ARCHITECTURE_RULINGS.md` **§6 L291**, per **C5**), **2 REFUSED** (availability — refused on **three** grounds including ⭐ *leakage by inference*, closing the route `LSD-XC-008` bars *"by value or by inference"*; and completeness — refused because it ranks *"a library on the diligence of its owner rather than on its fitness for the seeker's query"*, ⚠ with the counter-argument that it is a data-quality rather than merit signal **recorded and rejected** rather than unmentioned), and **3 DISSOLVED-OR-SATISFIED**. ⭐⭐ **Two supplied items were dissolved rather than deferred, and this is the substance of the reduction.** **Cold start** is a problem only for signal-accumulating rankings; with inputs 3, 4 and 6 gone a new library is **already** ordered identically to an established one, so ⛔ a compensating boost would **create** the asymmetry it claimed to fix. **Anti-gaming** is **satisfied by construction**: enumerate C6's inputs — distance (a physical fact), `BC-23` relevance (which C6 may not influence), a non-semantic tie-break (untunable by `LDR-BR-006`) — and ⭐ **there is nothing to game**, not merely nothing detected. ⚠ The one residual route, **keyword stuffing** in §14A.5 text, belongs to `BC-23`'s analyzer which ⛔ **both C2 and C6 are forbidden to author**, so it is **disclosed and routed as `XPC-OD-009`**, ⛔ **not** mitigated by adding a ranking input. ⭐ **What C6 genuinely owns is narrow and real**: row composition, descriptive grouping, sort-key disclosure, coarse-indicator rendering, graceful omission of absent optional fields, and ⭐ **the one determinism rule that survives** — a stable non-semantic **tie-break** (`LDR-FR-012`, `LDR-FR-013`), explicitly ⛔ **not** dressed as a preference and ⛔ **not** tunable by tier. ⛔ **A ranking-version register was REFUSED** — *"versioning nothing is not determinism, it is theatre"*. ⚠ **One drafted requirement was WITHDRAWN and the withdrawal recorded**: a C6-side fallback ordering, drafted for slot `023`, would have created *"a second ordering authority active precisely when the first failed"*; the register therefore stops at **022** and degradation is 📤 **DELEGATED**, C6's only correct response being to **truthfully relabel** the sort key in force. ⛔ **No ML/AI**, and §2.2 shows this is **structural** rather than promised — personalised ranking is **not computable**, because `E-30`'s payload identifies nobody (BC Map **§17.2.1**). ⛔ **No duplication of `PRD-021B`**: its *reasoning* on lawful read-composition ordering (`ADR-0091` §3) is cited; ⛔ **no `XPB-*` identifier is consumed**, and `X-05`/`ID-3` keep the surfaces apart. ⭐ **C3 compatibility preserved**: `LDR-XC-009` forbids `ProfileViews`, view counts, popularity and trending as ordering or presentation inputs, keeping the certified owner-only metric off every seeker surface. ⛔ **Zero contexts, zero edges, zero events, zero scores, zero sort keys added, zero ranking-version identifiers, zero pagination mechanisms, zero ADRs, zero Rank 1–6 modifications, zero `IMPL-*`, zero lines of code.** **59 identifiers minted** — 22 FR · 9 BR · 14 XC · 14 AC. ⛔ **Confers no lifecycle stage.** Stage 3 **not** entered |
