# SEARCH, RANKING AND DISCOVERY — `PRD-021C` C0–C8

**Derived document.** ⛔ No authority. Authority: [`../PRD/`](../PRD/) (**FROZEN**) ·
**`Accepted`** ADRs in [`../ADR/`](../ADR/) · [`../ARCHITECTURE/`](../ARCHITECTURE/).

---

## 1. ⭐⭐ Read this first — there is no ranking, and this is not an omission

C6 **§1** records the ownership position in one line:

> | **Ranking** | ⛔⛔ **Nobody owns a composite ranking, and none exists to own** |
>
> — C6 **§1**, **L78**

A composite ranking was **asked for** and **refused on measurement**. The refusal
is reasoned, recorded, and load-bearing: if you build a ranking, you are not
filling a gap — you are contradicting a frozen finding.

**The two things that DO exist:**

| Concern | Owner | Nature |
|---|---|---|
| **The query contract and the index** | **`BC-23`**, via `Library_PRD_v1.md` **§14A** (FROZEN 2026-08-03, and by **`ADR-0094`** the V1 `BC-23` discovery/query contract) | Retrieval and relevance |
| **The ordering surface** | ⭐⭐ **C2, already** — `LSD-FR-023`, `LSD-FR-025`, `LSD-FR-026`, `LSD-FR-028`…`032` | A declared deterministic ordering |
| **Presentation over that ordering, plus one tie-break** | **C6** | `LDR-FR-012`, `LDR-FR-013` |

⭐ **Ordering is not ranking.** An ordering applies a declared key. A ranking
computes a merit score. §14A names exactly one ordering — **Distance-based
Sorting** (**L114**) — and C6 **§1.2** states *"That is the whole of it"*, then
enumerates the refusals: ⛔ no composite score, ⛔ no weighted blend, ⛔ no rating
input, ⛔ no completeness input, ⛔ no freshness or recency input.

---

## 2. Why C6 owns no ranking — the decisive measurement

C6 **§1.1** (**L80**) is titled *"The decisive measurement: C2 already owns the
ordering surface"*, and the argument is worth reproducing because it is the kind
an implementer would otherwise re-open:

`LSD-XC-002` (C2 §8) reads:

> ⛔ **MUST NOT** create a second ranking or relevance system — BC Map **L132**;
> `ADR-0091` §3

> ⭐ **That exclusion binds C6 exactly as it binds C2.** C2 and C6 are parts of the
> **same** capability — module 19 — not two capabilities that could each hold a
> ranking. A C6 that defined a ranking would be *"a second ranking system"* by the
> plainest reading of a constraint that C2 already published against itself.
>
> — C6 **§1.1**

⭐ And C6 **§1.1** closes with the defect it avoided:

> ⭐ **Had C6 restated any of these, it would have created a duplicate-ownership
> defect inside one PRD** — the precise defect the authorising instruction's
> cross-part reconciliation list forbids.

**For you as an implementer:** the ordering rules live in **C2**. Read them there.
⛔ Do not implement an ordering rule from C6, and ⛔ do not implement it twice.

### 2.1 The C2 ordering requirements you must implement against

From C6 **§1.1**'s table (**L86**–**L94**), which cites C2:

| C2 requirement | What it fixes |
|---|---|
| `LSD-FR-023` | **Distance sort** on the non-query browse surface |
| `LSD-FR-025` | On a **text query**, ordering **MUST** be `BC-23`'s relevance ordering, and C2 **MUST NOT** re-order across relevance bands |
| `LSD-FR-026` | On **non-query browse**, a declared deterministic post-retrieval sort, **key published to the user**, ⛔ never a computed relevance score |
| `LSD-FR-027` | C2 **MUST NOT** define, store or tune a relevance formula, scoring weight, boost, analyzer or synonym list |
| `LSD-FR-028` | Pagination **MUST** use the opaque cursor convention (BC Map §15.3, `PG-1`…`PG-4`) |
| `LSD-FR-029`…`031` | Counts and facets **MUST NOT** disclose platform or tenant volumes |
| `LSD-FR-032` | Search **MUST NOT** require authentication and **MUST NOT** personalise |
| `LSD-AC-006`, `LSD-AC-007` | The ordering criteria, as acceptance criteria |

⚠ **`LSD-FR-025`'s "must not re-order across relevance bands" is easy to break.**
Applying your own secondary sort to a relevance-ordered result set re-orders
across bands. That is prohibited even if the secondary key seems harmless.

⚠ **`LSD-FR-026` requires the sort key be published to the user.** A silent sort
is non-conformant. The user must be able to see *what* the list is ordered by.

---

## 3. ⛔ What may never become an ordering input

C6 **§2** dispositioned nine requested ranking inputs. **Tally: 2
delegated/integrated · 2 unavailable · 2 refused · 3 dissolved-or-satisfied.**
The prohibitions that matter when writing code:

### 3.1 Rating and rating count — ⛔ *impossible*, not deferred

C6 **§2.1** (**L168**) is titled *"Two of the nine inputs are not merely deferred
— they are impossible"*:

> C5 §0 established that a library rating capability cannot be lawfully authored:
> `Library_PRD_v1.md` **L1016** (FROZEN, Rank 3) and `ARCHITECTURE_RULINGS.md`
> **§6 L291** both defer it to **V2**, and §6's heading is *"Explicitly deferred —
> **do not invent**"*.
>
> ⭐ **A ranking formula that names an input which cannot exist is not a
> specification — it is a promise no build can keep.**

⛔ There is no rating field to read, so there is nothing to sort by. See
[`ARCHITECTURE_AND_BOUNDARIES.md`](./ARCHITECTURE_AND_BOUNDARIES.md) §4.3 on C5
being **V2** and the requirement to *build the absence*.

### 3.2 Availability — ⛔ refused on three independent grounds

`LDR-FR-015` (C6 **§4.4**, **L361**) — ⛔ C6 **MUST NOT** order, group by merit,
filter by default or otherwise privilege results on the basis of the coarse
availability indicator. `LDR-BR-008` refuses it on **three** grounds, *any one
sufficient*:

| # | Ground | Authority |
|---|---|---|
| 1 | Ordering by availability makes it a **quality signal**, which C5 excludes | `LRR-FR-007`; `LRR-XC-008` |
| 2 | Live occupancy is **V2** and *"must not be invented"*; a coarse three-value indicator cannot bear an ordering weight without implying precision it does not have | `SEAT-XC-009`; `LIB-14B.13`; `ARCHITECTURE_RULINGS.md` **§6** |
| 3 | ⭐ **It would leak occupancy by inference.** A list ordered by availability discloses the relative fullness of every library in it — an inference route `LSD-XC-008` closes *"by value **or by inference**"* | `LSD-XC-008`; `LIB-14B.11`…`14` |

> ⭐ **Ground 3 is the one a designer would miss.** Hiding the seat count and then
> sorting by it publishes the same fact in a different alphabet.
>
> — C6 **L372**

⚠ **Note the scope of ground 3.** It is not only about *sorting*. Grouping,
default-filtering, badge-ordering or "show available first" all publish the same
inference.

### 3.3 Listing completeness — ⛔ refused, and the rejected argument is recorded

`LDR-FR-016` (C6 **§4.5**, **L377**) — ⛔ C6 **MUST NOT** order or privilege
results on the basis of listing completeness, field-fill percentage, photo count,
description length or similar.

C6 records the counter-argument it rejected, deliberately:

> a list where fuller listings appear first **is** a list that recommends them.
> ⭐ Recording the rejected argument is deliberate — a future owner reconsidering
> this should see it was **considered, not overlooked**.
>
> — C6 **L398**

### 3.4 Cold start — ✅ *dissolved*, not solved

`LDR-FR-018` (C6 **§4.6**, **L403**) — a newly verified and activated library
**MUST** appear under the **same rules** as every other library, from the moment
C1's visibility gate admits it (`LIB-DISC-002`: verified **and** activated).

`LDR-FR-019` — ⛔ C6 **MUST NOT** apply a new-listing boost, a new-listing
penalty, a probation period, a *"new"* badge, a grace ranking, a warm-up window
or a reduced-visibility state.

⭐ **Why "dissolved":** cold start is a problem only for a **learned or
reputation-weighted** ranking. With rating, rating count and completeness all
unavailable as inputs, there is no disadvantage for a new listing to overcome —
and C6 notes that a boost to compensate for a non-existent disadvantage would
**create** the asymmetry it purported to fix.

### 3.5 Anti-gaming — ✅ satisfied by construction

`LDR-FR-020` (C6 **§4.7**, **L421**) — ⛔ C6 **MUST NOT** expose the sort key's
underlying values, the tie-break's internal ordering, the index's internal
identifiers or any diagnostic that would let an owner reverse-engineer position.

`LDR-FR-021` — ⛔ C6 **MUST NOT** provide, and **MUST NOT** be extended to
provide, a **paid, sponsored, promoted, featured or subscription-tier-influenced
placement**.

⚠ One residual route is **disclosed, not claimed as solved**: keyword stuffing in
public text fields, which belongs to `BC-23`'s analyzer and query rewriting
(**L132**) — and which ⛔ **both C6 and C2 are forbidden to author**. It is routed,
not fixed.

### 3.6 ⛔ No ML, no AI — structural, not a policy promise

C6 **§2.2** (**L182**) forecloses every route, and the fifth is the strongest:

| Route | Why it is closed |
|---|---|
| A learned ranker inside C6 | C6 owns **no business state** (`AR-1`); model weights are business state |
| `BC-27` AI Assistance ranking discovery | `E-26` runs `BC-27 → BC-26, BC-23` — AI **reads from** search; it does not order for it. ⛔ **Wrong direction** |
| Relevance tuning via `BC-23` | ⛔ `LSD-FR-027`: no formula, weight, boost, analyzer or synonym list; `LSD-XC-004` bars authoring `BC-23`'s internals |
| Personalisation from a viewer profile | ⛔ `LSD-FR-032`: no personalisation; the seeker surface is **anonymous** (`LIB-DISC-005`) |
| Behavioural signals from view telemetry | ⛔ `E-30`'s payload carries **no viewer identity** (BC Map **§17.2.1**) — **there is no per-viewer history to learn from** |

> ⭐ **The last row is the strongest.** The one V1 event about a library profile was
> deliberately built to identify nobody (`ADR-0096` §4.2). Personalised ranking is
> therefore not *forbidden pending review* — it is **not computable from the data
> the architecture permits to exist.**
>
> — C6 **L200**

⭐ This is why [`INTEGRATIONS_AND_EVENTS.md`](./INTEGRATIONS_AND_EVENTS.md) §3.1
insists `E-30`'s payload must not be extended: extending it would *manufacture*
the input that makes personalised ranking possible.

---

## 4. The one thing C6 does own — the tie-break

> `LDR-FR-012` — ✅ **OWNED.** Where the sort key in force yields **equal** values
> for two or more results, C6 **MUST** apply a single declared, deterministic,
> stable tie-break so that the presented order is reproducible.
>
> `LDR-FR-013` — The tie-break **MUST** be a **stable, opaque, non-semantic**
> ordering of the result identifiers as supplied. It **MUST NOT** be random,
> time-seeded, session-seeded, viewer-derived, round-robin, rotational or
> weighted.
>
> — C6 **§4.3**, **L329**–**L336**

`LDR-BR-006` adds: ⭐ **the tie-break MUST NOT be dressed as a preference.**

**Read the exclusion list in `LDR-FR-013` as a list of tempting implementations:**

| ⛔ Forbidden tie-break | Why |
|---|---|
| Random | Not reproducible |
| Time-seeded | Same query returns different order — not reproducible |
| Session-seeded | Not reproducible, and edges toward personalisation |
| Viewer-derived | Personalisation (`LSD-FR-032`) |
| Round-robin / rotational | A **fairness policy** in disguise — i.e. a merit judgement |
| Weighted | A ranking in disguise |

✅ **Conformant:** a stable, opaque, non-semantic ordering of the identifiers as
supplied. The user-visible effect must be *"these are equal"*, ⛔ never *"this one
is better"*.

---

## 5. Discovery boundaries you must not cross

### 5.1 ⛔ `BC-23`'s internals are not yours

> **`LMT-XC-006`** — ⛔ No new index, analyzer, tokenizer, synonym list, relevance
> formula or query rewriter. 📤 `BC-23` (**L132**).

⛔ Do not add a search index. ⛔ Do not add a synonym file. ⛔ Do not add a
stemmer or tokenizer. ⛔ Do not post-process relevance. These belong to `BC-23`.

⚠ **And `BC-23`'s owning PRD does not exist.** **`PRD-015`** is ⚠ absent from the
repository entirely. So there is no document to consult for the index internals —
which makes inventing them *more* tempting and *equally* forbidden.

### 5.2 The projection is unconditional

C2 **§4** (**L140**) records that the projection is **UNCONDITIONAL since
2026-09-02**, and C2 **§2** (**L99**) records that its two blocking open decisions
are **RESOLVED**.

⭐ Note the interaction with [`INTEGRATIONS_AND_EVENTS.md`](./INTEGRATIONS_AND_EVENTS.md)
§2.1: the projection being unconditional does **not** dissolve
**`XPC-CONF-004`**, which concerns `E-21`'s **enumeration** omitting `BC-19`. Two
different questions; one resolved, one **OPEN**.

### 5.3 Counts and facets must not disclose volumes

`LSD-FR-029`…`031` — counts and facets **MUST NOT** disclose platform or tenant
volumes. `LMT-XC-013` correspondingly forbids a **total-count guarantee**.

⚠ "Showing 1–20 of 4,312 results" is a **platform volume disclosure**. This is
also why pagination is cursor-based (`PG-1`…`PG-4`) rather than offset-based —
offsets plus page counts reconstruct the total.

### 5.4 Search is anonymous

`LSD-FR-032` — search **MUST NOT** require authentication and **MUST NOT**
personalise. ⭐ Both halves matter: it must work for an anonymous visitor, **and**
it must return the same thing regardless of who is asking.

### 5.5 ⛔ No duplication of `PRD-021B`'s student discovery

C6 **§2.3** (**L200**):

> ⛔ **`PRD-021B` (`BC-11`/`BC-12`) is not consumed, not cited as a data source and
> not extended by C6.** Its ordering layer concerns *people*; C6 concerns
> *libraries*. They are separated by `X-05` (Matrix **L354**), which forbids
> `LIBRARY MANAGEMENT ↔ BC-11…BC-17`, and by `ID-3` (BC Map **L180**).

⛔ Do not reuse `PRD-021B`'s ordering code, and ⛔ do not read its data.

---

## 6. Determinism — a consequence, not a feature

C6 **§5** (**L484**) frames determinism as a **consequence** of the design rather
than a separately engineered property. Once you have:

- a declared sort key (`LSD-FR-023` / `LSD-FR-025` / `LSD-FR-026`),
- ⛔ no computed relevance score on the marketplace side (`LSD-FR-026`),
- ⛔ no personalisation (`LSD-FR-032`),
- ⛔ no random, time-, session- or viewer-seeded tie-break (`LDR-FR-013`),
- ⛔ no new-listing boost or probation (`LDR-FR-019`),

…then the same query necessarily returns the same order. ⭐ **Determinism is what
is left over when every non-deterministic input has been refused** — you do not
need to add a mechanism to achieve it, and adding one would be a sign something
non-deterministic had crept in.

⚠ **A determinism-version register was requested and reduced.** C6 **§2** item 8
records that *"a ranking-version register presupposes a ranking to version"* — so
it was ✅ **REDUCED** to the tie-break C6 actually owns (§4.3). ⛔ Do not build a
ranking-version register.

---

## 7. Degradation — ⛔ and the trap of the withdrawn slot

C6 **§4.8** (**L449**):

> ⛔ **Slot `023` in the `LDR-FR-*` register is deliberately NOT allocated.**
>
> ⚠ **This slot is intentionally empty, and the emptiness is recorded rather than
> silently skipped.** A fallback requirement was drafted here stating that C6 must
> present a degraded ordering if `BC-23` is unavailable. It was **withdrawn** on
> measurement: what happens when the index is unavailable is a property of the
> **query layer**, owned by C2 and ultimately by `BC-23` (**L132**), not of the
> presentation layer.

⭐⭐ **This is the single most likely place to introduce a defect.** The obvious
engineering instinct — "if search is down, fall back to a local ordering" — was
drafted, measured, and **withdrawn**. And C8 **§10.3**'s degraded-mode table
independently forbids it from the other side: when `BC-23` is down, present C2's
ordering **relabelled**, and ⛔ **no C6-side fallback**.

⭐ Note the two parts agree. C6 withdrew the slot; C8 forbade the behaviour. See
[`ERROR_AND_FAILURE_HANDLING.md`](./ERROR_AND_FAILURE_HANDLING.md) §3.

⚠ **Do not mint `LDR-FR-023`.** The slot is empty **by decision**, and C8 **§16**
generalises the discipline: ⛔ no unallocated, reserved, withdrawn or placeholder
slot is rendered anywhere in C5–C8 as a formed identifier token.

---

## 8. Self-check before shipping a discovery surface

1. **Am I computing a score anywhere?** If yes — stop. There is no ranking.
2. **Am I sorting by rating?** There is no rating. It is **V2** and *impossible*
   in V1.
3. **Am I sorting, grouping or default-filtering by availability?** Refused on
   three grounds — and it leaks occupancy by inference.
4. **Am I favouring fuller listings?** Refused.
5. **Am I boosting or penalising new listings?** Refused.
6. **Is my tie-break stable, opaque and non-semantic?** Random, time-seeded and
   round-robin are all prohibited.
7. **Is the sort key published to the user?** `LSD-FR-026` requires it.
8. **Am I re-ordering within a relevance-ordered result set?** `LSD-FR-025`
   forbids crossing relevance bands.
9. **Am I disclosing a total count or using offset pagination?** Both prohibited.
10. **Does my surface require login or personalise?** Both prohibited.
11. **Am I about to add a C6-side fallback ordering?** That is the **withdrawn
    slot**. Stop.

---

## 9. Open items in this area

| Item | Status | Owner |
|---|---|---|
| **`PRD-015`** — `BC-23` Search Indexing owner — ⚠ **does not exist** | **OPEN upstream** | Product / Architecture Owner |
| `XPC-CONF-004` — `E-21` enumeration omits `BC-19` | **OPEN** | Architecture Owner |
| Keyword stuffing in public text fields — `BC-23` analyzer concern | **DISCLOSED, routed** | `BC-23` owner |
| `XPC-OD-008` — inherited from C6 | **OPEN** | Per C0 §5 |
| Library rating capability | ⛔ **V2** — *"do not invent"* (`ARCHITECTURE_RULINGS.md` §6 **L291**) | V2 |

⛔ **Stage 8 implementation has NOT been performed.** No search or discovery
surface described here has been built. **0** lines of application code exist for
`PRD-021C`.
