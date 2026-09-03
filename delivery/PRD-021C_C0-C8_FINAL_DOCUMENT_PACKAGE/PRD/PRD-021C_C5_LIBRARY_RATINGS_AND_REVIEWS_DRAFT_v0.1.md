<!--
  PROVENANCE — PRD-021C Part C5 (Library Ratings & Reviews)

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 NOT entered.

  READ THIS FIRST
  ---------------
  This part does NOT specify a rating or review system, and that is a
  MEASUREMENT, not an omission. Two independent repository authorities defer
  Reviews & Ratings to V2 and forbid inventing it:

    Library_PRD_v1.md L1016   (FROZEN, Rank 3)
    ARCHITECTURE_RULINGS.md   section 6, L291 ("Explicitly deferred - do not invent")

  What this part therefore contains is the lawful portion: the finding, the
  V1 absence discipline that binds C1-C8, the preserved supplied intent marked
  FUTURE, and one OPEN decision routed to its owners.

  What this file does NOT do
  --------------------------
    - Creates no bounded context, edge, event, aggregate or invariant.
    - Creates no Rating, Review, Score, Star, Testimonial or Reputation entity.
    - Creates no moderation, reporting or verification system.
    - Amends no FROZEN PRD and no Rank 1-6 artefact.
    - Does NOT tier Reviews & Ratings to V1. Only an owner may do that.
    - Mints no IMPL-* identifier. Confers no lifecycle stage.
-->

# PRD-021C — PART C5

## Library Ratings & Reviews — Non-Authorisation Finding and V1 Absence Discipline

### v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Stage 3 has **not** been entered.

| Field | Value |
|---|---|
| **PRD** | `PRD-021C` Part **C5** |
| **Part title** | Library Ratings & Reviews — Non-Authorisation Finding and V1 Absence Discipline |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** — Stage 2 |
| **Structural classification** | ⭐ **Application / read composition capability of the Library domain** (`AR-1`; `MASTER_PRD.md` §8 **module 19**). ⛔ **NOT a bounded context.** ⛔ **NOT `BC-17`** |
| **Release** | ⛔⛔ **The rating/review capability is NOT V1.** `Library_PRD_v1.md` **L1016** and `ARCHITECTURE_RULINGS.md` **§6 L291** both place it at **V2**. What *is* V1 in this part is the **absence discipline** — the rules that keep the V1 surfaces free of rating-shaped artefacts |
| **Identifier prefix** | `LRR-*` — collision-checked at **0** occurrences repo-wide (§3.1) |
| **Owns** | ⛔ **No aggregate. No invariant. No business state. No rating. No review.** This part owns exactly one thing: the **record of a refusal** and the negative constraints that protect it |
| **Consumes** | ⛔ **Nothing.** C5 reads no context and calls no port. It cites authorities; it does not integrate |
| **Cross-part** | [`C0`](./PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md) · [`C1`](./PRD-021C_C1_MARKETPLACE_FOUNDATION_DRAFT_v0.1.md) · [`C2`](./PRD-021C_C2_LIBRARY_SEARCH_AND_LOCAL_DISCOVERY_DRAFT_v0.1.md) · [`C3`](./PRD-021C_C3_LIBRARY_PUBLIC_PROFILE_DRAFT_v0.1.md) · [`C4`](./PRD-021C_C4_LIVE_SEAT_AVAILABILITY_AND_BOOKING_DRAFT_v0.1.md) |

---

## §0. Verdict, stated before the evidence

⛔⛔ **A V1 library rating and review capability CANNOT be lawfully authored in
this repository, and this part does not author one.**

The instruction that authorised C5 required, as its **first** step, that the
author *"verify whether Ratings/Reviews already belong to another BC/PRD"* and
that *"if repository authority says Reviews/Ratings are V2 or unowned: do not
force them into V1."* That verification was performed first. It returned an
unambiguous answer from **two independent authorities**, one of them **FROZEN at
Rank 3**, and the second of which sits under a heading that reads *"Explicitly
deferred — **do not invent**."*

⭐ **The finding is stronger than "not yet specified".** Reviews & Ratings is not
merely absent — it is **affirmatively excluded**, by name, in five existing
requirement documents, and the cross-part conflict it raises was **already
recorded and already resolved** in this same PRD's `C0` as `XPC-CONF-006`.
Authoring a V1 rating system here would therefore not have filled a gap. It
would have **silently overturned a resolved decision** and contradicted a frozen
Rank 3 document.

⭐ **What is lawful, and is authored here, is the other half of the same
question.** A deferred feature still generates V1 obligations: the surfaces that
*would have* carried it must not carry a hole shaped like it. That discipline —
that a refused element is **omitted**, never rendered as an empty state, a
placeholder, a greyed control or a *"coming soon"* teaser — is not invented here
either. It is the discipline [`ADR-0097`](../../00-governance/adr/ADR-0097-profileviews-certified-uniqueviewers-not-certified.md)
`U1`–`U8` established for `UniqueViewers` **one day earlier in this same PRD**,
and §4 below applies it to ratings.

---

## §1. The measurement

### §1.1 Prefix collision check — measured, not assumed

`PRD_LIFECYCLE.md` §5 rule 2 requires a prefix be checked against every existing
register **before use**; rule 3 requires that on collision the **new** prefix
changes, never the existing one.

| Candidate | Occurrences measured repo-wide | Verdict |
|---|---|---|
| `LRR-` | **0** | ✅ Free — registered to C5 |
| `LDR-` | **0** | ✅ Free — registered to C6 |
| `LTS-` | **0** | ✅ Free — registered to C7 |
| `LMT-` | **0** | ✅ Free — registered to C8 |
| ~~`LRV-`~~ | **0** | ⚪ Free but **not used** — rejected on meaning, not collision: *"LRV"* reads as *review*, and a prefix that names the refused feature would make every exclusion in this part look like a requirement for it |

### §1.2 The two governing authorities

| Rank | Document | Line | Text, quoted |
|---|---|---|---|
| **3 — FROZEN** | `Library_PRD_v1.md` | **L1016** | `\| Reviews & Ratings \| **V2** \| New context; not in the V1 31 \|` |
| **5** | `ARCHITECTURE_RULINGS.md` §6 | **L291** | `\| **Reviews & Ratings** \| Library PRD §24 \| **Deferred — V2.** No bounded context assigned; will require a new context and an ADR when tiered \|` |

⭐ **§6's heading is itself normative.** It reads *"## 6. Explicitly deferred —
**do not invent**"* (**L279**). An item on that list is not an open design space
awaiting a volunteer; it is a **closed** one.

⭐ **The L291 row states the exact price of authorisation**, and it is a price no
draft can pay: *"will require **a new context** and **an ADR**"*. The instruction
authorising C5–C8 forbids both — ⛔ *"do NOT … create a new bounded context"* —
and `ARCHITECTURE_RULINGS.md` §6 independently forbids the invention. Two
constraints, arrived at separately, agree.

### §1.3 Corroboration — a third document already recorded the same finding

`LIBRARY_PRD_ALIGNMENT.md` **L307** and **L311** record Reviews & Ratings as
*"Not in the 31 contexts"* and observe that it *"has no bounded context —
correctly, since it is not V1 scope."* ⭐ The word **correctly** matters: the
alignment record treats the absence as the intended state, not as a defect
awaiting repair.

### §1.4 The feature is already excluded by name in five requirement documents

⭐ **This is the measurement that decides the question.** Had ratings merely been
unspecified, C5 might have been the natural place to specify them. They are not
unspecified. They are **excluded**, in force, in every sibling part of this very
PRD and in one part of `PRD-021A`:

| Identifier | Document | Line | Exclusion, quoted |
|---|---|---|---|
| `LMP-XC-009` | C1 | **L243** | *"⛔ **MUST NOT** create a rating, review, star, score or ranking-of-libraries entity"* |
| `LSD-XC-009` | C2 | **L322** | *"⛔ **MUST NOT** create, consume, sort by or filter by a rating, review or star value"* |
| `LPP-XC-005` | C3 | **L761** | *"Show a rating, review, star score, testimonial or any reputation value"* |
| `LSB-XC-013` | C4 | **L420** | *"Show any rating, review or reputation value alongside availability"* |
| `LCF-XC-002` | `PRD-021A` A2 | — | *"Ratings and reviews of libraries \| Library Discovery surface; explicitly **not** the private Community"* |

⚠ **`LCF-XC-002` is quoted here with a caveat, because it is the one row that
could be misread as support.** It says ratings belong to the *Library Discovery
surface* rather than to the community — which sounds like it assigns them to the
surface C1–C6 compose. It does **not** authorise them. It is a **negative**
requirement resolving a *placement* question inside `PRD-021A`, written to keep
ratings out of `BC-15`; it neither tiers the feature to V1 nor overrides
`Library_PRD_v1.md` **L1016**, and `PRD-021A` A2 is Rank-none draft-band product
text against a **FROZEN Rank 3** statement. ⭐ Recording this the honest way —
as a row that *appears* helpful and is measured not to be — is the point of the
table.

### §1.5 The conflict was already resolved, in this same PRD

`C0` **L279**, `XPC-CONF-006`, verbatim:

> ✅ **RESOLVED by exclusion** — **Excluded from V1.** `LPP-XC-005` and
> `LSD-XC-009` state it. ⛔ No rating entity, field, sort key or filter is
> created — §6 says such an item *"must not be invented"*.

⭐ **A resolved conflict is not re-opened by receiving a new instruction to build
the thing it resolved against.** §6 of `C0` is the register that exists to
prevent exactly that, and `C0` §6's own preamble states the rule: *"resolving an
unrelated decision as a side effect of an authorised pass is exactly the defect
this register exists to prevent."* The mirror of that rule is that an authorised
pass may not **un**-resolve one either.

### §1.6 ⚠ One apparent contradiction, measured and DISMISSED

`LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L988** reads `│   ├── Ratings (V3)`,
which at first glance conflicts with the V2 deferral — a **third** tier for the
same name.

⭐ **It is not the same feature.** Reading the surrounding tree shows L988 sits
beneath **`Notes Sharing (V2)`** — it is the rating *of a shared note*, a
`BC-14` Content Sharing concern, and has no relationship to the rating of a
**library**. ⛔ **No conflict exists, and the EA is byte-unchanged.**

⚠ **This non-conflict is recorded rather than silently skipped**, because a
reader who greps `Ratings` will find L988 and needs to know it was seen, read in
context, and dismissed on evidence — not missed. It also means the repository
now has **two** deferred rating features at **two** different tiers for **two**
different subjects, which is precisely the kind of collision a future tiering
ADR must not conflate.

### §1.7 What authorisation would actually require

⛔ **None of the following has occurred, and this part performs none of them.**

| # | Required act | Owner | Status |
|---|---|---|---|
| 1 | Tier Reviews & Ratings from **V2** to **V1** | **Product Owner** | ⛔ Not done. `Library_PRD_v1.md` is **FROZEN**; a tier change there is a Rank 3 amendment |
| 2 | Assign a **bounded context** — L291: *"No bounded context assigned"* | **Architecture Owner** | ⛔ Not done, and ⛔ **expressly forbidden by the instruction authorising this part** |
| 3 | Record an **ADR** — L291: *"will require … an ADR when tiered"* | **Architecture Owner** | ⛔ Not done. C5 is a PRD part, not an ADR, and a draft may not confer its own authority |
| 4 | Declare the **edges** the new context needs | **Architecture Owner** | ⛔ Not done. BC Map **L292**: *"If an edge is not in this table, it does not exist"* |
| 5 | Declare the **events** it publishes | **Architecture Owner** | ⛔ Not done |
| 6 | Reconcile with `PRD-020` for **review moderation** | **`BC-13` owner** | ⛔ Not done — and see §6 row 8: `PRD-020` is itself `PLANNED` |

⭐ **Six required acts, six owners, zero performed.** The gap between what the
supplied requirement assumed and what the repository can lawfully support is not
a detail — it is the whole distance between a V2 feature with no context and a
V1 feature with a specification.

---

## §2. What C5 therefore **is**

C5 is a **Stage-2 non-authorisation finding** carrying four lawful products:

| # | Product | Section | Normative? |
|---|---|---|---|
| 1 | The **finding** and its citations | §0, §1 | Descriptive |
| 2 | The **V1 absence discipline** — how the surfaces behave *because* ratings are absent | §4, §5 | ✅ **Normative for V1** |
| 3 | The **preserved supplied intent**, dispositioned item by item | §6 | 🔮 **FUTURE — explicitly NOT normative** |
| 4 | The **open decision**, routed to named owner roles | §7 | Routing only |

⛔ **C5 is not a placeholder for a future rating PRD.** When Reviews & Ratings is
tiered, §1.7 shows it will need its own context, its own ADR and its own PRD in
the registry. ⭐ C5 will then be **superseded on its subject and retained on its
discipline** — §4's omission rules survive tiering unchanged, because they
describe how a surface behaves in the *absence* of the feature, and some
surfaces (an unrated library on a rated platform) will always be in that state.

### §2.1 Normative language

| Term | Meaning |
|---|---|
| **MUST** / **MUST NOT** | Absolute requirement. A build violating it is defective |
| **SHOULD** | Strong recommendation; deviation requires a recorded reason |
| **MAY** | Genuinely optional |
| *(no keyword)* | Explanatory prose. Creates **no** requirement. Quoted `>` blocks are rationale and are **not** normative |

---

## §3. Identifier registers

| Register | Meaning | Range | Count | Contiguous |
|---|---|---|---|---|
| `LRR-FR-*` | V1 functional requirement *(all of them absence-discipline)* | `LRR-FR-001` … `LRR-FR-018` | 18 | Yes |
| `LRR-BR-*` | Business rule | `LRR-BR-001` … `LRR-BR-008` | 8 | Yes |
| `LRR-XC-*` | Exclusion / negative constraint | `LRR-XC-001` … `LRR-XC-016` | 16 | Yes |
| `LRR-AC-*` | Acceptance criterion (Given/When/Then) | `LRR-AC-001` … `LRR-AC-012` | 12 | Yes |

**Total: 54 identifiers.** Every one is traceable to §10 and testable by §9.
⛔ **No orphan identifier**: every `LRR-FR-*` and `LRR-BR-*` is exercised by at
least one `LRR-AC-*`, and the mapping is published in §9.0.

⚠ **The `-BR-` family is a repository convention, not a new invention.**
`PRD-020` uses `TSF-BR-*` for business rules distinct from functional
requirements (`PRD-020` §0.2). C1–C4 had no rules of that shape and so declared
no `BR` register; C5 does, so it declares one.

---

## §4. V1 requirements — the absence discipline

⭐ **These are genuine V1 requirements about V1 behaviour.** They do not describe
a rating feature. They describe what the marketplace surfaces **must do** given
that no rating exists — and they are testable today, against a build that has
no rating code at all.

### §4.1 Omission, not empty state

`LRR-FR-001` — No V1 marketplace surface (C1 foundation, C2 search, C3 public
profile, C4 availability, C6 ordering presentation) **MUST** render a rating
value, review body, star glyph, numeric score, letter grade, percentage
recommendation, testimonial or reputation badge for a library.

`LRR-FR-002` — Where the supplied design placed such an element, the element
**MUST** be **omitted entirely** — the surrounding layout **MUST** close up as if
it had never been specified.

`LRR-FR-003` — Omission **MUST NOT** be implemented as any of the following, and
this list is closed and exhaustive: a **zero** value, a **null** or **dash**
render, an **empty star row**, the words *"no ratings yet"*, *"be the first to
review"*, *"unrated"*, *"not yet rated"*, *"coming soon"*, a **disabled**
control, a **greyed** control, a **blurred** value, a **locked** value, a
**skeleton** or shimmer placeholder, a **teaser**, an **upsell**, or a
**reserved empty slot** in the layout.

> ⭐ **`LRR-FR-003` is the load-bearing requirement in this part, and it is
> transplanted, not invented.** [`ADR-0097`](../../00-governance/adr/ADR-0097-profileviews-certified-uniqueviewers-not-certified.md)
> `U1`–`U8` imposed exactly this list on `UniqueViewers` **one day earlier**,
> for exactly this reason: a placeholder is a *product claim* that the feature
> exists and is merely empty. For a feature that has **no bounded context**,
> that claim is false, and it creates a support and roadmap liability that a
> plain omission does not.

`LRR-FR-004` — The absence **MUST NOT** be explained to the user. ⛔ No
tooltip, footnote, help article link or interstitial **MUST** state that ratings
are planned, deferred, coming in a later version, or under consideration.

> A deferral is a **governance** fact recorded in `ARCHITECTURE_RULINGS.md` §6.
> Publishing it as a **product** promise commits an owner who has not decided —
> §1.7 row 1 — and a public commitment is materially harder to reverse than a
> register row.

### §4.2 No rating-shaped substitute

`LRR-FR-005` — No V1 surface **MUST** display a derived, proxy or
rating-adjacent value that a reasonable user would read as a quality judgement
of a library. The closed list of prohibited substitutes: **popularity rank**,
*"most viewed"*, *"trending"*, *"top rated"*, *"recommended"*, *"editor's
choice"*, *"verified excellent"*, *"members' favourite"*, **badge tiers**,
**medal or trophy iconography**, and any **percentile** or **leaderboard**
position.

`LRR-FR-006` — `ProfileViews` — the **only** metric certified anywhere in this
repository ([`ADR-0097`](../../00-governance/adr/ADR-0097-profileviews-certified-uniqueviewers-not-certified.md))
— **MUST NOT** be rendered on any public or seeker-facing surface, and **MUST
NOT** be used as, converted into, or presented alongside a quality signal.

> ⭐ **This is the single most likely accidental violation in the whole PRD, and
> it is a direct C3 compatibility requirement.** `ProfileViews` now exists, is
> certified, and is available to exactly one audience — the **library owner**,
> on an owner-only overlay outside the public projection (C3 `LPP-FR-030`,
> `LPP-XC-015`). A *"1,204 views"* badge on a public search result would be a
> popularity ranking wearing a metric's clothes, would breach C3's own
> owner-only boundary, and would place *Internal Analytics* — which §14A.5 puts
> on the **frozen never-public list** — into a public response. C5 states the
> prohibition explicitly so that the certification of `ProfileViews` cannot be
> mistaken for a licence to publish it.

`LRR-FR-007` — Seat availability **MUST NOT** be presented as a quality signal.
The coarse `Available` / `Limited` / `Full` indicator C4 publishes
(`LSB-FR-007`…`012`) is a **capacity** fact; ⛔ *"Always available"*, *"Rarely
full"* or *"Popular — usually full"* are quality claims and are excluded.

`LRR-FR-008` — Membership counts, enrolment counts, attendance volumes and
occupancy history **MUST NOT** appear on any seeker-facing surface, whether as
a number, a band, a bar, a sparkline or an adjective.

> `LIB-14B.22` and `LIB-18.2` already forbid disclosing tenant volumes; C3
> `LPP-FR-030`…`034` restate it for the profile. `LRR-FR-008` closes the
> specific route where a volume becomes a *rating substitute* rather than a
> *disclosure*, which is the same act reached by a different motive.

### §4.3 No import, embed or federation

`LRR-FR-009` — No V1 surface **MUST** import, embed, scrape, mirror, cache,
proxy or link-preview a rating or review from any external source, including
mapping providers, search engines, social platforms, aggregator sites and
directory listings.

`LRR-FR-010` — A library owner **MUST NOT** be able to place a rating,
review, star image, score, testimonial or award claim into any free-text or
media field that C3 renders — specifically the description, tagline, gallery
captions and branding assets (`LPP-FR-009`…`017`).

`LRR-BR-001` — `LRR-FR-010` is enforced as a **content rule on the owning
context**, not as a new validation system in the composition. The description
and tagline are `BC-25`/`BC-19` fields; the gallery is a `BC-29` `FileRef`
reached over `E-22`. ⛔ C5 creates no validator, no classifier, no scanner and
no moderation queue.

⚠ `LRR-BR-002` — **`LRR-FR-010` is therefore NOT fully enforceable in V1, and
that is disclosed rather than hidden.** A star glyph typed into a description,
or a *"Rated #1"* banner baked into a gallery image, is **detectable only by
content moderation**, and the only moderation authority in the repository is
`BC-13`/`PRD-020` — which C1–C7 **may not depend on** (`X-05`; see C7 §2).
The residual exposure is recorded as a **known limit**, routed with `XPC-OD-008`
in §7. ⛔ **No second moderation system is created to close it** — that is the
larger defect.

### §4.4 No collection, no storage, no interest

`LRR-FR-011` — No V1 surface **MUST** collect a rating, review, star, comment,
free-text opinion, thumbs-up/down, reaction, emoji response or *"was this
helpful"* signal about a library from any user, authenticated or anonymous.

`LRR-FR-012` — No V1 surface **MUST** persist such an input if one arrives —
including via a crafted request to an endpoint that never advertised the field.
An unrecognised field **MUST** be rejected, ⛔ **never** silently stored for
later use.

`LRR-BR-003` — A request carrying a rating-shaped field **MUST** produce a
domain error, not a silent no-op. Silent acceptance would create an
undocumented data store for a feature with no owner, no retention policy and no
privacy review — the exact shape of the shadow system §1.7 exists to prevent.

`LRR-FR-013` — No V1 telemetry, analytics event or log **MUST** record a
user's expressed opinion about a library. ⭐ The one V1 event about a library
profile is `tenancy.LibraryProfileViewed` ([`ADR-0096`](../../00-governance/adr/ADR-0096-profile-view-fact-produced-by-bc-19-over-new-edge-e-30.md)),
and its payload is fixed by BC Map **§17.2.1** to the subject library and the
occurrence time — ⛔ **no viewer identity, and no sentiment field.**

`LRR-BR-004` — ⛔ **The `E-30` payload MUST NOT be extended to carry a rating,
sentiment, dwell time, scroll depth or engagement score.** BC Map **§17.2.1**
fixes the payload; extending it is a **Rank 4 amendment requiring an ADR**, and
C5 has neither the authority nor a decision to apply.

### §4.5 Verified-member indicator — refused, and why

`LRR-FR-014` — No V1 surface **MUST** display a *"verified member"*,
*"verified student"*, *"actually attended"* or equivalent indicator against any
opinion, comment or contribution about a library.

`LRR-BR-005` — This is refused on **two independent grounds**, either of which
alone is sufficient:

| # | Ground | Authority |
|---|---|---|
| 1 | **There is nothing to attach it to.** The indicator qualifies a review; no review exists (§0) | `Library_PRD_v1.md` **L1016** |
| 2 | ⭐ **It would disclose membership.** Publishing *"this person is a member of this library"* on a seeker-facing surface publishes a tenant membership fact to an anonymous audience, and links a **global-band person** to a **tenant** | `LIB-14B.22`; `ID-3` (BC Map **L180**) — the global band **MUST NOT** resolve *"which library a person attends"*; `X-05` (Matrix **L354**) |

> ⭐ **Ground 2 is the more important, because it survives the tiering of ratings.**
> If Reviews & Ratings reaches V1 tomorrow, ground 1 disappears and ground 2 does
> not. A verified-member badge is an `ID-3` violation whether or not there is a
> review beneath it, so the future rating context will inherit this constraint
> rather than escape it. ⛔ C5 does not resolve how a future rating context might
> establish credibility without disclosing membership; that is part of
> `XPC-OD-008`.

### §4.6 Spam, manipulation and moderation — refused for want of a subject

`LRR-FR-015` — C5 **MUST NOT** specify spam detection, duplicate detection,
fake-review detection, vote-brigading detection, sockpuppet detection or
rating-manipulation controls.

`LRR-BR-006` — ⭐ **Rating manipulation is not mitigated in V1; it is
IMPOSSIBLE in V1.** There is no rating to manipulate. A control specified
against a non-existent surface is a register entry that can never be satisfied
and can never fail — untestable by construction.

> ⭐ **This mirrors `PRD-020` `TSF-XC-034` exactly**, which refused to write a
> requirement for *"Library official posts"* because *"no such object exists in
> the repository"*, noting that *"inventing a reportable type for an object with
> no owner would create a register entry that can never be satisfied."* C5
> reaches the identical disposition by the identical reasoning, for the identical
> class of defect.

`LRR-FR-016` — C5 **MUST NOT** specify review reporting, review moderation, a
moderator queue, an appeal path or an enforcement ladder for reviews.

`LRR-BR-007` — Moderation of user-generated content is owned by **`BC-13` Trust
& Safety** and specified by **`PRD-020`** (`ModerationCase`, BC Map **L379**).
⛔ C5 **MUST NOT** create a second moderation system. ⚠ And it may not extend
`PRD-020` either: `PRD-020` is itself **`DRAFT` Stage 2** and **`PLANNED`** in
the registry (`PRD_REGISTRY.md` **L320**), so there is no approved moderation
specification for a reviews feature to plug into even if reviews existed.

### §4.7 Determinism — the one supplied requirement that survives intact

`LRR-FR-017` — Because no rating exists, every V1 ordering, filter and
aggregate **MUST** be computable **without** a rating input, and **MUST** remain
deterministic in its absence.

`LRR-FR-018` — No V1 aggregate, count, facet or sort key **MUST** be defined in
terms of a rating, an average, a rating count, a weighted score or a Bayesian
prior.

`LRR-BR-008` — ⭐ **The supplied requirement for "deterministic calculation" is
therefore SATISFIED, in the strongest available form.** A quantity that is never
computed cannot be computed inconsistently. C6 §5 carries the positive statement
of the same fact: two of the nine supplied ranking inputs — **rating** and
**rating count** — are **unavailable**, and their absence is the reason C6's
ordering is provably deterministic rather than merely intended to be.

---

## §5. Business-rule summary

| ID | Rule | Consequence if violated |
|---|---|---|
| `LRR-BR-001` | Content prohibitions bind the **owning context**, not the composition | A validator in the composition would be a second content-rules system |
| `LRR-BR-002` | ⚠ `LRR-FR-010` is **not fully enforceable in V1** — disclosed limit | Pretending enforcement exists is worse than the gap |
| `LRR-BR-003` | Rating-shaped input **errors**; never silently stored | A shadow store with no owner, retention or privacy review |
| `LRR-BR-004` | ⛔ `E-30`'s payload **MUST NOT** be extended | Unauthorised Rank 4 amendment; viewer-anonymity breach |
| `LRR-BR-005` | Verified-member indicator refused on **two** grounds | `ID-3` breach; membership disclosure to anonymous audience |
| `LRR-BR-006` | Manipulation controls are **impossible**, not deferred | Untestable register entries |
| `LRR-BR-007` | Moderation stays with `BC-13`/`PRD-020` | A second safety platform |
| `LRR-BR-008` | Determinism holds **because** the input is absent | — *(this rule records a satisfied requirement, not a risk)* |

---

## §6. Preserved supplied intent — 🔮 **FUTURE / V2**, explicitly NOT normative

⛔⛔ **Nothing in this section is a requirement.** No identifier is minted here.
This is a **verbatim disposition record** of the eleven items the authorising
instruction supplied for C5, preserved so that the tiering owner inherits the
full request rather than a summary of it.

⭐ **Why preserve it at all.** `PRD_LIFECYCLE.md` §5 rule 6 and the repository's
consistent practice is that a refused item is **recorded as refused**, not
deleted — `PRD-021A` `A4_NON_EXISTENCE_FINDING.md` and `ADR-0097`'s
`UniqueViewers` treatment are both instances. A future owner asking *"what was
actually asked for?"* must be able to read it here.

| # | Supplied item | Disposition | Band | Blocking authority |
|---|---|---|---|---|
| 1 | 1–5 star rating, one active per student per library | ⛔ **Not authorised** | 🔮 V2 | `Library_PRD_v1.md` **L1016** |
| 2 | Update / remove own rating | ⛔ Not authorised — nothing to update | 🔮 V2 | as row 1 |
| 3 | Average rating + rating count on the library | ⛔ Not authorised; ⛔ **and excluded from V1 aggregates** by `LRR-FR-018` | 🔮 V2 | `LSD-XC-009`; `LPP-XC-005` |
| 4 | Written review body | ⛔ Not authorised | 🔮 V2 | `ARCHITECTURE_RULINGS.md` **§6 L291** |
| 5 | Edit / delete own review | ⛔ Not authorised | 🔮 V2 | as row 4 |
| 6 | Verified-member indicator | ⛔ **Refused on two grounds — and ground 2 survives tiering** | 🔮 V2 **+ unresolved** | `ID-3`; `LIB-14B.22`; `X-05` — §4.5 |
| 7 | Spam / duplicate / fake-review protection | ⛔ **Impossible, not deferred** | 🔮 V2 | `LRR-BR-006`; cf. `TSF-XC-034` |
| 8 | Review reporting & moderation | ⛔ Not authorised — and its owner `PRD-020` is itself `PLANNED` | 🔮 V2 **+ blocked** | `PRD_REGISTRY.md` **L320**; `LRR-BR-007` |
| 9 | Privacy + safety integration | ⛔ Not authorised. ⭐ The privacy authority is `BC-10` (**L114**) and the review it would need has **no appointed Privacy Owner** | 🔮 V2 **+ blocked** | `PRD_OWNERSHIP_MODEL.md` **L509**; `C0` `XPC-OD-005` |
| 10 | Deterministic calculation | ✅ **SATISFIED in V1** — vacuously and provably | ✅ **V1** | `LRR-FR-017`, `LRR-FR-018`, `LRR-BR-008` |
| 11 | Given/When/Then acceptance criteria | ✅ **DELIVERED in V1** — §9, twelve criteria testing the **absence** | ✅ **V1** | — |

**Disposition tally: 8 not authorised · 1 impossible · 2 satisfied/delivered.**
⚠ Re-derived by counting the rows, not by arithmetic on an expected figure.
⭐ Note that rows 6, 8 and 9 carry a **second** blocker beyond the tier — so
tiering ratings to V1 would **not** by itself unblock them.

---

## §7. Open decision — routed, not resolved

⛔ **This part decides nothing.** The row below carries a named owner **role**,
never a personal name (`PRD_OWNERSHIP_MODEL.md` §7 rule 4). It is registered in
`C0` §6 as **`XPC-OD-008`**.

| # | Decision required | Owner | Blocks | Smallest lawful act |
|---|---|---|---|---|
| **`XPC-OD-008`** | **Should Reviews & Ratings be tiered from V2 to V1 — and if so, under which bounded context?** ⚠ Six prerequisite acts, six owners, **zero performed** (§1.7). ⚠ Three of the eleven supplied items carry a **second, independent** blocker that tiering alone will not clear (§6 rows 6, 8, 9) | **Product Owner** *(tier)* **+ Architecture Owner** *(context + ADR + edges + events)* | ⛔ **Nothing in V1.** V1 is complete and coherent without ratings; C1–C4 already exclude them and C6 is deterministic **because** of their absence | **Keep the deferral.** If tiering is wanted: an ADR that assigns a context, declares its edges and events, and amends `Library_PRD_v1.md` **L1016** — in that order. ⛔ **Not requested by any owner, and not required for V1** |

⚠⚠ **`XPC-OD-008` is DELIBERATELY NOT bundled with the five decisions of
2026-09-02.** Those were conferred explicitly, item by item, and executed as
`ADR-0093`…`ADR-0097`. ⛔ No conferral covers ratings. Treating a general
instruction to *"create Part C5"* as a conferral to **tier a V2 feature and mint
a bounded context** would be exactly the over-reading `C0` §6's preamble warns
against — and the authorising instruction for this pass independently forbids
creating a bounded context.

---

## §8. Exclusions

| # | Excluded | Authority |
|---|---|---|
| `LRR-XC-001` | ⛔ **MUST NOT** create a `Rating`, `Review`, `Score`, `Star`, `Testimonial` or `Reputation` entity, aggregate, table, column or field | `Library_PRD_v1.md` **L1016**; `ARCHITECTURE_RULINGS.md` **§6 L291** |
| `LRR-XC-002` | ⛔ **MUST NOT** create a bounded context | `ARCHITECTURE_RULINGS.md` **§6 L291** *("will require a new context")*; instruction authorising this part; BC Map count **31** |
| `LRR-XC-003` | ⛔ **MUST NOT** create or amend a context edge | BC Map **L292** — *"If an edge is not in this table, it does not exist"* |
| `LRR-XC-004` | ⛔ **MUST NOT** publish, name or propose a domain event | BC Map §9; cf. `PRD-020` `TSF-EVT-*` held to **2** for the same reason |
| `LRR-XC-005` | ⛔ **MUST NOT** extend the `tenancy.LibraryProfileViewed` payload | BC Map **§17.2.1**; `LRR-BR-004` |
| `LRR-XC-006` | ⛔ **MUST NOT** render a rating, review, star, score, grade, percentage or reputation value | `LRR-FR-001`; `LPP-XC-005`; `LSB-XC-013` |
| `LRR-XC-007` | ⛔ **MUST NOT** render an empty state, placeholder, zero, dash, disabled, greyed, blurred, locked, skeleton, teaser or *"coming soon"* in a rating's place | `LRR-FR-003`; `ADR-0097` `U1`–`U8` |
| `LRR-XC-008` | ⛔ **MUST NOT** display a rating **substitute** — popularity, trending, top-rated, recommended, badge tier, percentile, leaderboard | `LRR-FR-005` |
| `LRR-XC-009` | ⛔ **MUST NOT** render `ProfileViews` on a public or seeker-facing surface, or use it as a quality signal | `LRR-FR-006`; C3 `LPP-FR-030`, `LPP-XC-015`; §14A.5 never-public |
| `LRR-XC-010` | ⛔ **MUST NOT** import, embed, scrape, mirror, cache or link-preview an external rating or review | `LRR-FR-009` |
| `LRR-XC-011` | ⛔ **MUST NOT** collect, accept or persist a rating-shaped input | `LRR-FR-011`, `LRR-FR-012`, `LRR-BR-003` |
| `LRR-XC-012` | ⛔ **MUST NOT** display a verified-member or attendance-verified indicator | `LRR-FR-014`; `ID-3`; `LIB-14B.22` |
| `LRR-XC-013` | ⛔ **MUST NOT** create a moderation, reporting, appeal or enforcement system | `LRR-BR-007`; `BC-13` (**L117**); `PRD-020` |
| `LRR-XC-014` | ⛔ **MUST NOT** create a spam, fake-review, sockpuppet or manipulation-detection system | `LRR-BR-006`; cf. `TSF-XC-034` |
| `LRR-XC-015` | ⛔ **MUST NOT** define a rating-based ordering, filter, facet or aggregate | `LRR-FR-018`; `LSD-XC-009`; `LSD-XC-002` |
| `LRR-XC-016` | ⛔ **MUST NOT** state, imply or promise to a user that ratings are planned, deferred or forthcoming | `LRR-FR-004` |

⭐ **`LRR-XC-006` deliberately duplicates `LPP-XC-005` and `LSB-XC-013` in
substance.** That is not a duplicate *ownership* claim — an exclusion assigns no
ownership. It is restated so that a reader arriving at C5 to ask *"where are the
ratings?"* finds the answer in the part named for it, rather than only in two
sibling parts named for something else.

---

## §9. Acceptance criteria

Given/When/Then form. ⚠ **0 of 12 is proven by a test — no test exists.**

### §9.0 Coverage map — ⛔ no orphan requirement, ⛔ no orphan criterion

| Criterion | Exercises |
|---|---|
| `LRR-AC-001` | `LRR-FR-001`, `LRR-FR-002`, `LRR-XC-006` |
| `LRR-AC-002` | `LRR-FR-003`, `LRR-XC-007` |
| `LRR-AC-003` | `LRR-FR-004`, `LRR-XC-016` |
| `LRR-AC-004` | `LRR-FR-005`, `LRR-XC-008` |
| `LRR-AC-005` | `LRR-FR-006`, `LRR-XC-009` |
| `LRR-AC-006` | `LRR-FR-007`, `LRR-FR-008` |
| `LRR-AC-007` | `LRR-FR-009`, `LRR-XC-010` |
| `LRR-AC-008` | `LRR-FR-010`, `LRR-BR-001`, `LRR-BR-002` |
| `LRR-AC-009` | `LRR-FR-011`, `LRR-FR-012`, `LRR-BR-003`, `LRR-XC-011` |
| `LRR-AC-010` | `LRR-FR-013`, `LRR-BR-004`, `LRR-XC-005` |
| `LRR-AC-011` | `LRR-FR-014`, `LRR-BR-005`, `LRR-XC-012` |
| `LRR-AC-012` | `LRR-FR-017`, `LRR-FR-018`, `LRR-BR-008`, `LRR-XC-015` |

⚠ `LRR-FR-015`, `LRR-FR-016`, `LRR-BR-006`, `LRR-BR-007`, `LRR-XC-001`…`005`,
`013`, `014` are **structural refusals verified by inspection, not by execution**
— they assert that a *system does not exist*, which no runtime test can observe.
⭐ Their verification method is the **repository check**: a `grep` for the
prohibited entity or system returning **0**. That is stated here rather than
padding §9 with criteria that could never fail.

### §9.1 The criteria

`LRR-AC-001` — **No rating appears on any V1 surface**
> **Given** a verified, activated, Public library with a complete listing
> **When** an anonymous seeker views it on the search results surface, the public profile surface and the availability surface
> **Then** no rating value, star glyph, numeric score, grade, percentage or reputation badge is present on any of the three
> **And** the layout contains no gap, reserved slot or unexplained whitespace where one would have been.

`LRR-AC-002` — **Omission is not an empty state**
> **Given** the same library
> **When** the public profile response is inspected in full, including the rendered DOM and the API payload
> **Then** no field, element, attribute or key named for a rating, review, star, score or reputation is present at all
> **And** specifically **no** zero value, dash, empty star row, *"no ratings yet"*, *"be the first to review"*, *"unrated"*, *"coming soon"*, disabled control, greyed control, blurred value, locked value, skeleton placeholder, teaser or upsell is present.

`LRR-AC-003` — **The absence is not explained to the user**
> **Given** any V1 marketplace surface
> **When** every tooltip, footnote, help link, empty state and interstitial on it is read
> **Then** none states or implies that ratings or reviews exist, are planned, are deferred, are coming soon or are under consideration.

`LRR-AC-004` — **No rating substitute is displayed**
> **Given** three libraries with materially different view counts, member counts and listing completeness
> **When** an anonymous seeker views them on any V1 surface
> **Then** none carries *"popular"*, *"trending"*, *"top rated"*, *"recommended"*, *"editor's choice"*, *"members' favourite"*, a badge tier, a medal, a trophy, a percentile or a leaderboard position
> **And** no visual treatment distinguishes them on any quality dimension.

`LRR-AC-005` — **`ProfileViews` stays owner-only and is never a quality signal**
> **Given** a library whose certified `ProfileViews` metric has a non-zero value
> **When** an anonymous seeker views its public profile **and** its search result row
> **Then** the view count is absent from both, in the rendered output and in the API payload
> **And when** the authenticated library owner views their own overlay
> **Then** the value is labelled **views** — ⛔ never *visitors*, *people*, *unique visitors*, *users*, *viewers*, *reach* or *audience* (`ADR-0097` §4.3)
> **And** it is presented as an engagement measure, ⛔ never as a rating, score, rank or quality indicator.

`LRR-AC-006` — **Capacity and volume are not repackaged as quality**
> **Given** a library reporting the coarse indicator `Full`, and another reporting `Available`
> **When** an anonymous seeker views both
> **Then** each shows only its coarse indicator
> **And** neither shows *"always available"*, *"rarely full"*, *"popular — usually full"*, a member count, an enrolment count, an attendance volume, an occupancy history, a bar, a sparkline or an equivalent adjective.

`LRR-AC-007` — **No external rating is imported**
> **Given** a library that holds a public rating on an external mapping, search, social or directory service
> **When** its V1 marketplace surfaces are rendered and its API payloads inspected
> **Then** no external rating, review, star, score or review count appears, whether inline, embedded, iframed, cached, proxied or as a link preview
> **And** no outbound request is made to any such service on the render path.

`LRR-AC-008` — **Owner-supplied rating claims are prohibited — and the residual limit is disclosed**
> **Given** a library owner who enters *"★★★★★ Rated #1 in the city"* into the description field
> **When** the field is submitted
> **Then** the prohibition is enforced by the **owning context** that stores the field, ⛔ not by a new validator in the composition
> **And when** the owner instead uploads a gallery image with a five-star graphic baked into the pixels
> **Then** ⚠ **the criterion records that V1 does NOT detect this**, because detection requires content moderation, the only moderation authority is `BC-13`, and `X-05` forbids this composition depending on it
> **And** the residual exposure is the disclosed limit `LRR-BR-002`, ⛔ not a silent failure and ⛔ not a reason to build a second moderation system.

`LRR-AC-009` — **A rating-shaped input is rejected, never stored**
> **Given** a crafted request to a V1 marketplace endpoint carrying an unadvertised field `rating: 5` and a field `review: "great place"`
> **When** the request is processed
> **Then** it produces a domain error
> **And** no value is persisted in any table, cache, queue, log or analytics store
> **And** the response body does not echo the submitted values back.

`LRR-AC-010` — **The one library-profile event carries no sentiment**
> **Given** an anonymous seeker rendering a library's public profile
> **When** the resulting `tenancy.LibraryProfileViewed` event is inspected
> **Then** its payload contains the subject library and the occurrence time and nothing further
> **And** it carries no rating, sentiment, dwell time, scroll depth, engagement score, viewer identity, `PersonId`, `AccountId`, device identifier or fingerprint.

`LRR-AC-011` — **No verified-member indicator, and membership is not disclosed**
> **Given** an authenticated student who is a current member of library **L**
> **When** any anonymous seeker views **L**'s public profile, search result and availability surface
> **Then** no indicator identifies that student, or any student, as a verified member, verified attendee or past visitor
> **And** no response field, count or aggregate allows an anonymous caller to determine that any specific person is a member of **L**.

`LRR-AC-012` — **V1 ordering is deterministic without a rating input**
> **Given** two libraries identical on every V1 ordering input
> **When** the same search or browse query is executed twice against an unchanged index
> **Then** the two result orders are identical
> **And** no ordering, filter, facet or aggregate in the executed path reads a rating, an average, a rating count, a weighted score or a Bayesian prior
> **And** the determinism holds **because** the input does not exist, ⛔ not because a rating tie was broken.

---

## §10. Traceability to authority

| Requirement group | Governing authority |
|---|---|
| §0, §1 — the finding | `Library_PRD_v1.md` **L1016** (**FROZEN**, Rank 3); `ARCHITECTURE_RULINGS.md` **§6 L279**, **L291**; `LIBRARY_PRD_ALIGNMENT.md` **L307**, **L311** |
| §1.4 — pre-existing exclusions | `LMP-XC-009` (C1 **L243**); `LSD-XC-009` (C2 **L322**); `LPP-XC-005` (C3 **L761**); `LSB-XC-013` (C4 **L420**); `LCF-XC-002` (`PRD-021A` A2) |
| §1.5 — the resolved conflict | `C0` **L279** `XPC-CONF-006` |
| §1.6 — the dismissed non-conflict | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L988** (Rank 6, descriptive; the child of *Notes Sharing (V2)*) |
| `LRR-FR-001`…`004` | `LPP-XC-005`; `LSB-XC-013`; ⭐ [`ADR-0097`](../../00-governance/adr/ADR-0097-profileviews-certified-uniqueviewers-not-certified.md) `U1`–`U8` — the omission discipline |
| `LRR-FR-005`…`008` | §14A.5 *Internal Analytics* (**never-public**); `LIB-14B.22`; `LIB-18.2`; C3 `LPP-FR-030`, `LPP-XC-015`; C4 `LSB-FR-007`…`012`, `SEAT-XC-009` |
| `LRR-FR-009`, `LRR-FR-010`, `LRR-BR-001`, `LRR-BR-002` | `LPP-FR-009`…`017`; BC Map **L134** (`BC-25`), **L128** (`BC-19`), **L138** (`BC-29`), **L331** (`E-22`); `X-05` (Matrix **L354**) |
| `LRR-FR-011`…`013`, `LRR-BR-003`, `LRR-BR-004` | BC Map **§17.2.1** (`E-30` payload); [`ADR-0096`](../../00-governance/adr/ADR-0096-profile-view-fact-produced-by-bc-19-over-new-edge-e-30.md) §4.2; BC Map §9.1 (envelope) |
| `LRR-FR-014`, `LRR-BR-005` | `ID-3` (BC Map **L180**); `LIB-14B.22`; `X-05` (Matrix **L354**) |
| `LRR-FR-015`, `LRR-FR-016`, `LRR-BR-006`, `LRR-BR-007` | BC Map **L117** (`BC-13`), **L379** (`ModerationCase`); `PRD-020` `TSF-XC-034` *(the refusal-for-want-of-a-subject precedent)*; `PRD_REGISTRY.md` **L320** |
| `LRR-FR-017`, `LRR-FR-018`, `LRR-BR-008` | `LSD-XC-002`, `LSD-XC-009`; BC Map **L132** (`BC-23` owns relevance); C6 §5 |
| §7 `XPC-OD-008` | `ARCHITECTURE_RULINGS.md` **§6 L291**; `PRD_LIFECYCLE.md` §5; `PRD_OWNERSHIP_MODEL.md` §7 rule 4 |

---

## §11. Status

**`DRAFT` · Stage 2 · NOT FROZEN · NOT APPROVED · NOT BASELINED · Rank: none.**
Stage 3 **not** entered, and **no Stage-3 alignment record exists for
`PRD-021C`**.

⛔⛔ **The rating and review capability is NOT authorised, NOT specified and NOT
scheduled.** It remains **V2** where `Library_PRD_v1.md` **L1016** and
`ARCHITECTURE_RULINGS.md` **§6 L291** put it.

**Self-measurement — what this part creates:**

| Class | Count | Note |
|---|---|---|
| New bounded contexts | **0** | Count remains **31** (23 in V1) |
| New context edges | **0** | Set remains **29**; `E-27` still permanently vacant |
| New domain events | **0** | ⛔ None registered and ⛔ **none proposed** |
| New aggregates / entities / fields | **0** | ⛔ Including zero rating entities |
| New moderation / safety systems | **0** | `BC-13`/`PRD-020` untouched |
| New analytics systems or metrics | **0** | `ProfileViews` remains the only certified metric, and §4.2 **restricts** its rendering |
| ADRs written | **0** | ⭐ **1 required if the feature is ever tiered** — routed as `XPC-OD-008`, ⛔ not written |
| Rank 1–6 documents modified | **0** | `Library_PRD_v1.md` and `ARCHITECTURE_RULINGS.md` are **byte-unchanged** |
| `IMPL-*` minted | **0** | — |
| Lines of application code | **0** | — |
| Identifiers minted | **54** | 18 FR · 8 BR · 16 XC · 12 AC |

⚠ **Not proven:** **0** of the 12 acceptance criteria are proven by an executed
test, and 11 further refusals are verifiable only by repository inspection
(§9.0).

⭐ **One open decision** is routed and **not** resolved: **`XPC-OD-008`**, owners
**Product Owner + Architecture Owner**. ⛔ It blocks nothing in V1.

---

## §12. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-03 | Part created at **Stage 2**. ⛔⛔ **A V1 rating/review capability was NOT authored, and the refusal is the substance of the part.** Two independent authorities were measured first, as the authorising instruction required: `Library_PRD_v1.md` **L1016** (**FROZEN**, **Rank 3**) tiers *Reviews & Ratings* to **V2** and records *"New context; not in the V1 31"*; `ARCHITECTURE_RULINGS.md` **§6 L291**, under the heading *"Explicitly deferred — **do not invent**"*, records *"Deferred — V2. No bounded context assigned; will require a new context and an ADR when tiered."* Corroborated by `LIBRARY_PRD_ALIGNMENT.md` **L307**/**L311**. ⭐ **The feature was already excluded by name in five requirement documents** — `LMP-XC-009`, `LSD-XC-009`, `LPP-XC-005`, `LSB-XC-013`, `LCF-XC-002` — and the conflict was **already RESOLVED** in `C0` as **`XPC-CONF-006`**, so authoring it would have **un-resolved a settled decision** rather than filled a gap. ⚠ `LCF-XC-002` is quoted **with its caveat**: it places ratings on *"the Library Discovery surface"* and could be misread as authorising them, but it is a negative placement rule inside a Rank-none draft and cannot override a FROZEN Rank 3 tier. ⚠ **One apparent contradiction was measured and DISMISSED**: EA **L988** `Ratings (V3)` is a child of **Notes Sharing (V2)** — *notes* ratings, a `BC-14` concern — so it is a different feature at a different tier, ⛔ not a conflict, and the EA is **byte-unchanged**. ⭐ **What WAS authored is the lawful half**: the **V1 absence discipline** — **18 FR**, **8 BR**, **16 XC**, **12 AC** — which transplants [`ADR-0097`](../../00-governance/adr/ADR-0097-profileviews-certified-uniqueviewers-not-certified.md) `U1`–`U8`'s omission rule from `UniqueViewers` to ratings: a refused element is **omitted**, ⛔ never a zero, dash, empty star row, *"no ratings yet"*, disabled, greyed, blurred, locked, skeleton, teaser or *"coming soon"*. ⭐ **`LRR-FR-006` is the C3 compatibility guard**: `ProfileViews` is now certified and owner-only, so C5 explicitly forbids rendering it on a seeker-facing surface or converting it into a popularity signal — the most likely accidental breach of C3 `LPP-XC-015` and of §14A.5's **never-public** *Internal Analytics* list. ⭐ **Two supplied items were REFUSED on grounds that survive tiering**: the **verified-member indicator** breaches `ID-3` and `LIB-14B.22` whether or not a review exists beneath it, and **manipulation controls** are **impossible rather than deferred** — the identical disposition, on identical reasoning, that `PRD-020` `TSF-XC-034` gave *"Library official posts"* (*"inventing a reportable type for an object with no owner would create a register entry that can never be satisfied"*). ⭐ **One supplied item is SATISFIED in the strongest available form**: determinism holds **because** the rating input does not exist (`LRR-BR-008`), which is also why C6's ordering is provably deterministic. ⛔ **Zero contexts, zero edges, zero events, zero aggregates, zero ADRs, zero Rank 1–6 modifications, zero `IMPL-*`, zero lines of code.** ⭐ **One open decision routed, not resolved: `XPC-OD-008`** (tier + context + ADR), owners **Product Owner + Architecture Owner**, blocking **nothing in V1** — and ⚠ **three of the eleven supplied items carry a second blocker that tiering alone would not clear** (§6 rows 6, 8, 9). ⛔ **Confers no lifecycle stage.** Stage 3 **not** entered |
