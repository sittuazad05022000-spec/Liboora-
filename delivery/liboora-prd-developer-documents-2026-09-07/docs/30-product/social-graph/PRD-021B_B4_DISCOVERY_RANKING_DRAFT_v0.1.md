<!--
  PRD-021B — Part B4 — Discovery Algorithm & Ranking
  DRAFT v0.1 — Stage 2

  PROVENANCE
  ----------
  Authored from the supplied B4 specification, reconciled against measured
  repository authority. Where the supplied specification and the repository
  disagreed, the repository won and the conflict was RECORDED, not overridden.

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 NOT entered. Stage 4 NOT entered.
                  No alignment record exists for B4 and none is claimed.
  Algorithm     : DISC-RANK-1 — first generation, rule-based, no ML.

  THREE CONFLICTS WITH THE SUPPLIED SPECIFICATION ARE DISCLOSED, NOT HIDDEN
    XPB-CONF-001  B0 §2 row 8 assigns "Ranking" to BC-23. B3 SDS-XC-007 says
                  "B4 MUST NOT rank" is BC-23's. B4 therefore does NOT claim
                  BC-23's relevance ranking. It owns a SEPARATE, categorically
                  distinct post-retrieval ORDERING layer, on the A3 precedent
                  (LCR-XC-004 + AR-3). Recorded as OPEN, ARB.
    XPB-CONF-002  EA L930 places "Recommended Students" at V2. The supplied
                  spec asks for V1 recommendations in B5. B4's fallback and
                  frequency rules are written to serve SEARCH ordering in V1
                  and recommendation ordering only when B5's wave gate opens.
    XPB-CONF-003  Several requested ranking signals have NO authorised source.
                  They are DEFERRED with owners, not invented.

  What this file does NOT do
    - It creates no bounded context. The count remains 31.
    - It creates no integration edge and mints no published event.
    - It amends no FROZEN PRD and no Rank 1-5 artefact.
    - It mints no IMPL-* identifier and creates no implementation task.
    - It confers no lifecycle stage and modifies no B0/B1/B2/B3 requirement.
-->

# PRD-021B — PART B4

## Discovery Algorithm & Ranking — `DISC-RANK-1`

### Specification v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Stage 3 has **not** been
> entered. Stage 4 has **not** been entered. Nothing here is claimed to pass.

---

## §0. Document control

### §0.1 Status header

| Field | Value |
|---|---|
| Document | `PRD-021B` Part B4 — Discovery Algorithm & Ranking |
| Version | **v0.1** |
| Status | **DRAFT** |
| Lifecycle stage | **Stage 2 (Draft)** — Stage 3 and Stage 4 NOT entered |
| Architectural form | **Read composition (`AR-1` shape)** — ⛔ **not** a bounded context |
| Algorithm generation | **`DISC-RANK-1`** — deterministic, rule-based, ⛔ no ML |
| Contexts consumed | `BC-23` (candidate set + relevance), `BC-11` (relationship signals via B1), `BC-10` (privacy), `BC-02` (membership validity), `BC-25` (configuration via `E-19`), `BC-24` (audit via `E-20`) |
| Context count | **31** — unchanged. ⛔ No `BC-` identifier minted |
| Edges created | **0** |
| Events minted | **0** |
| Freeze | ⛔ **NOT FROZEN** |
| Open conflicts | `XPB-CONF-001`, `XPB-CONF-002`, `XPB-CONF-003` — all **OPEN**, all with owners (§3) |

### §0.2 Identifier registers — declared up front, with ranges

| Register | Meaning | Range | Count |
|---|---|---|---|
| `DRK-FR-nnn` | Functional requirement | `001`–`014` | **14** |
| `DRK-BR-nnn` | Business rule | `001`–`011` | **11** |
| `DRK-SIG-nnn` | Ranking signal (with source verdict) | `001`–`010` | **10** |
| `DRK-CFG-nnn` | Configurable — default **and** range | `001`–`008` | **8** |
| `DRK-DET-nnn` | Determinism / reproducibility rule | `001`–`006` | **6** |
| `DRK-EXP-nnn` | Explainability / audit rule | `001`–`006` | **6** |
| `DRK-PRV-nnn` | Privacy rule | `001`–`005` | **5** |
| `DRK-SEC-nnn` | Security rule | `001`–`004` | **4** |
| `DRK-EVAL-nnn` | Evaluation rule | `001`–`005` | **5** |
| `DRK-EC-nnn` | Edge case | `001`–`012` | **12** |
| `DRK-XC-nnn` | Explicit exclusion (what must be impossible) | `001`–`016` | **16** |
| `DRK-SCOPE-nnn` | V1 / Future scope statement | `001`–`005` | **5** |
| `DRK-AC-nnn` | Acceptance criterion (GWT) | `001`–`026` | **26** |
| `DRK-GAP-nnn` | Disclosed gap — OPEN, with owner | `001`–`005` | **5** |
| **Total** | | | **133** |

Ranges contiguous `001..max` — **measured, not asserted** (§B4.18).
⛔ No `IMPL-*` identifier minted.

### §0.3 Prefix collision — executed before writing

`DRK-` measured **0** occurrences across `docs/` prior to authoring.
`RNK-`, `SRK-`, `DSC-` also measured 0; `DRK-` chosen because `RNK-` reads as a
generic ranking stem and would collide semantically with `PRD-021A`'s `LCR-`
feed-ranking register in review.

### §0.4 Normative language

**MUST**/**MUST NOT** absolute · **SHOULD**/**SHOULD NOT** strong, deviation
recorded · **MAY** optional · ⛔ prohibition · ⚠ disclosed defect/gap/risk ·
⭐ load-bearing.

---

## §B4.1 Architectural form — why B4 is not a context

⭐ **B4 is a read composition, not a bounded context**, tested against the same
four `AR-1` criteria B3 used:

| Criterion | `AR-1` text | B4 | Verdict |
|---|---|---|---|
| Owns an aggregate? | *"owns **no aggregate**"* | No — orders a transient list | ✅ same |
| Owns an invariant? | *"no invariant"* | No — every rule it enforces belongs to another owner | ✅ same |
| Owns business state? | *"no business state"* | No — ⛔ ordering is never persisted (`DRK-XC-009`) | ✅ same |
| What does it do? | *"orchestrates **public read models only**"* | Orders an already-filtered read composition | ✅ same |

`DRK-FR-001` — B4 **MUST** be implementable as a pure function of
(candidate list, signal values, configuration version). ⛔ It **MUST NOT** hold
a store, an aggregate or a lifecycle.

`DRK-FR-002` — B4 **MUST** consume B3's published read contract
(`SDS-FR-017`) and **MUST NOT** query `BC-23`'s index itself.
⭐ This is what keeps `SDS-IDX-010` and `TSF-INV-005` intact: B4 sits strictly
**downstream** of steps [1]–[3].

`DRK-XC-001` — ⛔ B4 **MUST NOT** create a bounded context. Count stays **31**.
`DRK-XC-002` — ⛔ B4 **MUST NOT** create an integration edge. Every context it
reads is reached through an edge that **already exists** (§B4.4).
`DRK-XC-003` — ⛔ B4 **MUST NOT** mint a published event. `BC-11`'s surface
stays closed at two (BC Map **L430**).

---

## §B4.2 ⭐ The ownership conflict, stated before anything is claimed

> ⚠ **This section exists because the supplied specification and the repository
> disagree. It is recorded, not resolved by assertion.**

### `XPB-CONF-001` — "Ranking" is already assigned to `BC-23`

| Field | Value |
|---|---|
| **Supplied specification** | *"B4 owns ranking/scoring/configuration/versioning/diversity/freshness/frequency/fallback/evaluation."* |
| **Repository authority** | **FROZEN** `PRD-020` §8.3 step **[4]**: `Ranking — BC-23 — relevance`. B0 §2 row 8: `Ranking → BC-23`, B1/B2/B3 all ⛔. B3 `SDS-XC-007`: *"⛔ **B3 MUST NOT rank.** Ranking is step [4], owned by **`BC-23`**"* |
| **Already resolved elsewhere?** | ✅ **Yes — the pattern is, the assignment is not.** `PRD-021A` A3 owns *feed* ranking without owning `BC-23`, by `LCR-XC-004`: search relevance is *"categorically separate index class per `AR-3`"*. `AR-3` (BC Map **§11.1 L494**) establishes two *"categorically different"* classes and says conflating them is the failure mode |
| **Disposition** | ⛔ **B4 does NOT claim `BC-23`'s relevance ranking.** B4 owns a **post-retrieval ordering layer** over an already-retrieved, already-filtered candidate list. `BC-23` scores *text relevance against a query*; B4 orders *people already proven eligible, private-safe and safety-cleared*. These are different inputs, different stages and different failure modes |
| **Residual question** | Whether that ordering layer is a lawful A3-shaped capability or an encroachment on step [4] is **not mine to settle** |
| **Owner** | **ARB** (`PRD_OWNERSHIP_MODEL.md` **L203**) |
| **Status** | ⛔ **OPEN** — `DRK-GAP-001` |
| **Blocks B4 authoring?** | ⛔ No — written so that either reading is satisfiable (§B4.3) |
| **Blocks implementation?** | ✅ **Yes** — the module that hosts the ordering layer cannot be chosen until ARB rules |

`DRK-BR-001` — ⭐ **Until `XPB-CONF-001` is resolved, B4 orders only WITHIN the
sequence `BC-23` supplies for a query-driven surface**, and **MUST NOT**
contradict `SDS-BR-018` (*"B3 MUST return results in the order `BC-23` supplies,
after filtering. Filtering MUST NOT reorder."*).

⚠ **Read that carefully — it is a real constraint, not a formality.** For the V1
**search** surface, `BC-23` relevance is authoritative and B4's contribution is
limited to **tie-breaking and diversity within equal-relevance bands**
(`DRK-FR-009`). B4 becomes a full ordering layer only on a surface where
`BC-23` supplies **no** relevance ordering — which is the recommendation surface,
and that surface is **V2** (`XPB-CONF-002`).

`DRK-XC-004` — ⛔ B4 **MUST NOT** re-order across relevance bands on a
query-driven surface while `XPB-CONF-001` is OPEN. Doing so would silently
override frozen `PRD-020` §8.3 step [4].

---

## §B4.3 Separation of search relevance from discovery ordering

| | **Search relevance** | **Discovery ordering (B4)** |
|---|---|---|
| Owner | **`BC-23`** (BC Map **L132**) | B4, subject to `XPB-CONF-001` |
| Input | A viewer-supplied query string | A filtered candidate list, no query |
| Question answered | *"how well does this text match?"* | *"of these equally-matching people, who first?"* |
| Stage | `PRD-020` §8.3 step **[4]** | **After** [4] |
| Authority for separation | `AR-3`; A3 `LCR-XC-004` | This document |

`DRK-XC-005` — ⛔ B4 **MUST NOT** perform indexing, query rewriting, tokenisation,
stemming, synonym expansion or text scoring. Owner: `BC-23` (BC Map **L132**).
`DRK-XC-006` — ⛔ B4 **MUST NOT** write to, read from or build any index.
Authority: B3 `SDS-IDX-007`, `SDS-IDX-008`; `SID-4.38` (*"`BC-23` SHALL NOT read
this module's store (`X-08`)"*) applies symmetrically in intent.
`DRK-BR-002` — Where `BC-23` supplies a relevance score, that score **MUST** be
the **primary** sort key and B4's signals **MUST** be strictly subordinate.

---

## §B4.4 Pipeline position — ⭐ ordering happens LAST

```
  [0] Candidate set     BC-23     — permission-aware index         (B3 SDS-BR-015)
       │
  [1] Eligibility       BC-11     — not blocked either direction   (PRD-020 §8.3, FROZEN)
       │                            + library membership via E-02  (B3 SDS-FR-004)
  [2] Privacy           BC-10     — PrivacySettings                (PRD-020 §8.3, FROZEN)
       │
  [3] Safety            BC-13     — suspended/terminated/restricted (PRD-020 §8.3, FROZEN)
       │
  [4] Relevance         BC-23     — text relevance, query surfaces  (PRD-020 §8.3, FROZEN)
       │
  [5] ORDERING          ★ B4 ★    — tie-break · diversity · freshness
       │                            ⛔ NOTHING is admitted or excluded here
  [6] Scope clamp       B6        — LIBRARY only in V1              (B6 GLS-FR-004)
       │
   Result
```

`DRK-FR-003` — ⭐ B4 **MUST** run **strictly after** steps [1], [2] and [3].
Authority: **FROZEN** `TSF-INV-005` — *"Step [3] MUST run after [1] and [2] and
MUST be non-bypassable. A ranking or recommendation path that reaches the index
without step 3 is a defect."*

`DRK-FR-004` — ⭐ B4 **MUST NOT** add, admit, re-admit or resurrect any person
into the candidate set. B4 is **order-only**.

`DRK-XC-007` — ⛔ **It MUST be IMPOSSIBLE for B4 to widen a candidate set.** The
implementation **MUST** be a permutation of its input: same multiset in, same
multiset out. A B4 output containing an identifier absent from its input is a
**defect**, testable by set comparison (`DRK-AC-003`).

`DRK-XC-008` — ⛔ **It MUST be IMPOSSIBLE for B4 to be invoked before step [3].**
Enforced by construction: B4's only input is B3's post-filter contract
(`DRK-FR-002`), which is produced after [3] by `SDS-IDX-010`.

`DRK-BR-003` — A B4 failure **MUST NOT** become a discovery failure. On any
internal error B4 **MUST** return its input order unchanged and record the
degradation (`DRK-BR-010`). Precedent: A3 `LCR-FR-009`.

`DRK-XC-009` — ⛔ B4 **MUST NOT** persist an ordering, a score, a rank position
or a candidate list. Authority: B3 `SDS-DM-005` / `LCM-RM-006` — the composed
discovery result is owned by *"nobody — not persisted."*

---

## §B4.5 ⭐ Ranking signals — every source verified, none invented

> **Method:** each requested signal was tested against three questions — does a
> source exist? is there an authorised path to it? is it V1? A "no" anywhere
> means **DEFERRED with an owner**, never invented.

| ID | Signal | Source | Authorised path | Verdict |
|---|---|---|---|---|
| `DRK-SIG-001` | **`BC-23` relevance score** | `BC-23` | Already the step-[4] output | ✅ **ACTIVE** — primary key |
| `DRK-SIG-002` | **Mutual-connection count** | `BC-11` | B1 `SGR-FR-025` (V1 derivation) + `SGR-FR-020` (*"B1 MUST expose relationship signals for B3's read composition"*) | ✅ **ACTIVE** |
| `DRK-SIG-003` | **Same-library membership** | `BC-02` | `E-02` `MembershipValidity` — B3 `SDS-FR-004`, `MM-BR-006` allowlist | ✅ **ACTIVE** — but see `DRK-BR-004` |
| `DRK-SIG-004` | **Profile completeness** | `BC-10` | `identity.PersonProfileUpdated` → `BC-11` (BC Map **L425**) | ✅ **ACTIVE**, computed from allow-listed fields only (`SID-4.39`) |
| `DRK-SIG-005` | **Account freshness / recency of join** | `BC-10` | `identity.PersonIdentityCreated` (BC Map **L424**) — ⚠ `BC-11` is **NOT** in its consumer cell | ⚠ **DEFERRED** → `DRK-GAP-002` |
| `DRK-SIG-006` | **Pending-request state** | `BC-11` | B1, same-context read | ✅ **ACTIVE** as a **suppression** input, not a boost (`DRK-BR-007`) |
| `DRK-SIG-007` | **Shared attendance / same study hall / co-presence** | `BC-03`, `BC-04` | **Measured: 0 edges** from `BC-03`/`BC-04` to `BC-11`/`BC-12`/`BC-13` in BC Map §7. `X-05` Separate Ways forbids `domain/library/**` imports (CI **L266**) | ⛔ **REFUSED** → `DRK-GAP-003` |
| `DRK-SIG-008` | **Common interests / tags** | — | `Common Interests` is **V2** (EA **L931**). No V1 interest store measured | ⛔ **REFUSED — V2** → `DRK-SCOPE-002` |
| `DRK-SIG-009` | **Nearby / geographic proximity** | — | `Nearby Students` **V2** (EA **L929**); B6 sets LOCAL/NEARBY **OFF** | ⛔ **REFUSED — V2** → `DRK-SCOPE-003` |
| `DRK-SIG-010` | **Behavioural engagement / click-through / impressions** | — | Measured **0** impression or already-seen store anywhere in `docs/10-architecture/`. A3 deferred the identical question as `D-3` | ⛔ **REFUSED** → `DRK-GAP-004` |

⭐ **4 of 10 requested signals have no lawful V1 source and are refused.** Each
refusal names the measurement that produced it. ⛔ **No signal was invented to
fill a gap.**

`DRK-BR-004` — ⚠ **`DRK-SIG-003` is nearly always constant and therefore nearly
always inert.** In V1 the scope is LIBRARY-only (B6 `GLS-FR-002`), so every
candidate shares the viewer's library and this signal cannot affect ordering.
It is retained at **weight 0** and marked **NOT IN EFFECT**, on the A3 `LCR-RS-009`
precedent, where a mathematically constant signal was **withdrawn rather than
carried as inert weight**. ⛔ It **MUST NOT** be reported as contributing.

`DRK-BR-005` — ⛔ A signal whose source is `DEFERRED` or `REFUSED` **MUST NOT**
appear in the active weight table, **MUST NOT** be assigned a non-zero weight,
and **MUST NOT** be referenced by any acceptance criterion as passing.

`DRK-XC-010` — ⛔ **It MUST be IMPOSSIBLE for B4 to read a library-domain store.**
CI `banned_imports` (`tool/module_dependencies.yaml` **L265**) bans
`domain/library/**` from `domain/social`. ⚠ Note the consequence: because
`DRK-SIG-003` arrives on `E-02` keyed by `studentRecordId`, and `StudentRecordId`
is a **banned symbol** in `domain/social` (CI **L269**), any B4 implementation
consuming it **MUST** sit tenant-side, exactly as B3 `SDS-XC-002` already requires.

---

## §B4.6 The scoring model — `DISC-RANK-1`

`DRK-FR-005` — B4 **MUST** compute an ordering key as a weighted sum of
**ACTIVE** signals only, normalised to `[0.0, 1.0]` each.

### Active weight table — sums to 1.00

| Signal | Weight | Direction | In effect? |
|---|---|---|---|
| `DRK-SIG-001` `BC-23` relevance | **0.60** | higher first | ✅ query surfaces only |
| `DRK-SIG-002` mutual-connection count | **0.25** | higher first | ✅ |
| `DRK-SIG-004` profile completeness | **0.15** | higher first | ✅ |
| **Total** | **1.00** | | |

### Reserved weights — ⛔ NOT IN EFFECT

| Signal | Weight | Why reserved |
|---|---|---|
| `DRK-SIG-003` same-library | `0.00` | Constant in V1 — `DRK-BR-004` |
| `DRK-SIG-005` account freshness | *reserved* | `DRK-GAP-002` unresolved |
| `DRK-SIG-007` co-presence | *reserved* | ⛔ Refused — `X-05` |
| `DRK-SIG-008` common interests | *reserved* | V2 |
| `DRK-SIG-009` proximity | *reserved* | V2 |
| `DRK-SIG-010` behavioural | *reserved* | ⛔ No source |

`DRK-FR-006` — On a **non-query** surface (no `BC-23` relevance available), the
remaining active weights **MUST** be renormalised to sum to 1.00 —
`DRK-SIG-002` → `0.625`, `DRK-SIG-004` → `0.375`. ⚠ Applies only when a
non-query surface is lawfully enabled (`XPB-CONF-002`).

`DRK-BR-006` — Weights **MUST** be configuration, not code constants, supplied
by `BC-25` through **`E-19`** (BC Map **L328**: *"All contexts → BC-25 … Typed
config accessors; no raw string lookups in domain code"*).
⭐ This is an **existing** edge; no new edge is required for configuration.

`DRK-BR-007` — `DRK-SIG-006` (pending request) is a **suppression**, not a
boost: a person with an outbound pending request from the viewer **MUST** be
moved to the end of the ordering or omitted by B5 policy — never boosted.

`DRK-XC-011` — ⛔ **It MUST be IMPOSSIBLE for enforcement or moderation state to
act as a soft ranking penalty.** Safety is a **hard filter at step [3]** only.
Authority: **FROZEN** `TSF-FR-023`; A3 `P1-3` established the identical rule.
A B4 implementation that down-weights a suspended person instead of excluding
them is a defect, because it makes exclusion **distinguishable** and breaches
`TSF-FR-024`.

---

## §B4.7 Configuration — every configurable has a default **and** a range

| ID | Configurable | Default | Range | Owner |
|---|---|---|---|---|
| `DRK-CFG-001` | `weight.relevance` | `0.60` | `0.00`–`1.00` | `BC-25` via `E-19` |
| `DRK-CFG-002` | `weight.mutualConnections` | `0.25` | `0.00`–`1.00` | `BC-25` |
| `DRK-CFG-003` | `weight.profileCompleteness` | `0.15` | `0.00`–`1.00` | `BC-25` |
| `DRK-CFG-004` | `mutualCount.saturationCap` | `10` | `1`–`50` | `BC-25` |
| `DRK-CFG-005` | `diversity.maxPerBand` | `3` | `1`–`20` | `BC-25` |
| `DRK-CFG-006` | `ordering.pageSize` | `20` | `1`–`50` | `BC-25`; ⚠ bounded server-side per B3 `SDS-API-003` |
| `DRK-CFG-007` | `ordering.timeBudgetMs` | `50` | `10`–`500` | `BC-25`; non-binding objective, not a threshold |
| `DRK-CFG-008` | `config.versionPin` | `DISC-RANK-1` | enum of published versions | `BC-25` |

`DRK-BR-008` — Every weight **MUST** be validated on load: outside its declared
range, the loader **MUST** reject the configuration and retain the last valid
version. ⛔ It **MUST NOT** silently clamp.
`DRK-BR-009` — Active weights **MUST** sum to `1.00 ± 0.001`. A configuration
that does not **MUST** be rejected as invalid.
`DRK-XC-012` — ⛔ **It MUST be IMPOSSIBLE for a client to supply a weight, a
signal value, a configuration version or an ordering key.** All configuration is
server-side through `E-19`. Authority: `MP-GBR-08`; B3 `SDS-SEC-003` sets the
identical rule for `tenantId`.
`DRK-SEC-001` — Any request carrying a client-supplied weight or ordering
parameter **MUST** be rejected, not ignored.
`DRK-XC-013` — ⛔ B4 **MUST NOT** define a settings hierarchy, a feature-flag
mechanism or a configuration store. Owner: `BC-25` (BC Map **L134**). A3
`LCR-XC-010` sets the same boundary, and A3's `D-5` recorded configuration
ownership between a ranking part and `BC-25` as **open** — ⚠ inherited here as
`DRK-GAP-005`.

---

## §B4.8 Determinism, versioning and reproducibility

`DRK-DET-001` — ⭐ Identical inputs + identical configuration version **MUST**
yield an identical ordering. Precedent: A3 `LCR-FR-007`.
`DRK-DET-002` — Ties **MUST** be broken by a **stable, non-random** key:
`PersonId` ascending. ⛔ No randomisation, no shuffling, no time-seeded jitter.
`DRK-DET-003` — ⛔ B4 **MUST NOT** use wall-clock time as a scoring input.
Freshness (`DRK-FR-011`) **MUST** be computed from an explicit `asOf` supplied
with the request, so a replay reproduces the result.
`DRK-DET-004` — Every ordering **MUST** be reproducible from recorded inputs plus
the configuration version identifier. Precedent: A3 `LCR-FR-008`.
`DRK-DET-005` — The algorithm version (`DISC-RANK-1`) **MUST** be an explicit,
published value; a weight change **MUST** produce a new configuration version.
`DRK-DET-006` — ⛔ B4 **MUST NOT** contain a learned parameter, a model artefact
or any value derived from observed behaviour.

`DRK-XC-014` — ⛔ **It MUST be IMPOSSIBLE for `DISC-RANK-1` to include machine
learning, learning-to-rank, neural ranking, reinforcement learning, automated
weight optimisation, embeddings or a model server.** Authority: A3
`LCR-XC-012` sets this exclusion for the sibling ranking part; EA **L933**
places `AI Discovery` at **Future**; BC Map **L335** `E-26` confines AI to
*"permission-aware ports only — never direct index or table access."*
Testable: the dependency manifest for the hosting module contains **0** ML
packages (`DRK-AC-019`).

---

## §B4.9 Diversity, freshness, frequency and fallback

`DRK-FR-007` — **Diversity.** Within an equal-score band, B4 **MUST NOT** return
more than `DRK-CFG-005` candidates sharing a single dominant signal value.
`DRK-FR-008` — Diversity **MUST** be applied as a **re-ordering within a band**,
never as an exclusion. ⛔ A diversity rule that drops a candidate breaches
`DRK-XC-007`.
`DRK-FR-009` — ⭐ On query surfaces, diversity and tie-breaking **MUST** operate
**only inside equal-relevance bands**, preserving `BC-23`'s band order
(`DRK-BR-001`, `DRK-XC-004`).
`DRK-FR-010` — **Band definition.** Two candidates are in the same relevance
band when their `BC-23` scores differ by less than a configured epsilon; ⚠ the
epsilon is **not minted here** — it is `BC-23`'s scale, and B4 does not own it
→ `DRK-GAP-002` companion note.
`DRK-FR-011` — **Freshness** **MUST** be computed only from `asOf` and an
authorised timestamp. ⚠ Because `DRK-SIG-005` is **DEFERRED**, freshness has
**no active input in V1** and is specified but **NOT IN EFFECT**.
`DRK-FR-012` — **Frequency control.** B4 **MUST** expose a stable ordering across
repeated identical requests so a caller can page without duplication or loss.
`DRK-FR-013` — ⛔ Per-viewer frequency capping ("do not show X again for N days")
**MUST NOT** be implemented in B4 — it requires per-viewer impression state,
which has **no authorised store** (`DRK-SIG-010`, `DRK-GAP-004`). It is
recorded as **B5 policy** if and when a store is authorised.
`DRK-FR-014` — **Fallback.** If any active signal is unavailable, B4 **MUST**
renormalise the remaining active weights and continue. If **all** signals are
unavailable, B4 **MUST** return input order.
`DRK-BR-010` — A fallback **MUST** be recorded in the explainability record
(`DRK-EXP-003`) and **MUST NOT** be silent.
`DRK-BR-011` — ⛔ Fallback **MUST NOT** relax a filter. Degradation affects
**order only**, never membership. This is the `TSF-INV-005` guarantee restated
for the failure path.

---

## §B4.10 Explainability and audit

`DRK-EXP-001` — ⭐ For any ordering, B4 **MUST** be able to produce a per-candidate
record naming each contributing signal, its normalised value and its weight.
`DRK-EXP-002` — The record **MUST** include the configuration version and the
algorithm version.
`DRK-EXP-003` — Degradations, fallbacks and rejected configurations **MUST** be
recorded.
`DRK-EXP-004` — ⛔ **The explanation MUST NOT be exposed to a peer.** A viewer
**MUST NOT** learn why another person ranked where they did. Authority:
**FROZEN** `TSF-XC-030` — *"T&S MUST NOT publish the reason for a discovery
exclusion to any peer-facing surface"* — extended here to ordering rationale,
because a rank explanation leaks the same information class.
`DRK-EXP-005` — Audit records **MUST** reach `BC-24` through **`E-20`** (BC Map
**L329**, *"All contexts → BC-24 … fire-and-forget, outbox-backed"*).
⭐ Existing edge; none created.
`DRK-EXP-006` — ⛔ Audit records **MUST NOT** contain profile content, message
content or a full candidate list. Precedent: B1 `SGR-FR-024`.

`DRK-PRV-001` — ⛔ B4 **MUST NOT** read a profile field that `BC-10`'s
allow-list excludes. Authority: `SID-4.39` — never-public fields
*"MUST NOT be indexed at all, in any index, for any purpose."*
`DRK-PRV-002` — `DRK-SIG-004` (profile completeness) **MUST** be computed as a
**count of allow-listed fields present**, never by reading a restricted value.
`DRK-PRV-003` — ⛔ B4 **MUST NOT** infer a private attribute from an ordering
position, and **MUST NOT** expose a score to any client.
`DRK-PRV-004` — ⛔ **It MUST be IMPOSSIBLE to distinguish "excluded by safety"
from "ranked last."** Authority: **FROZEN** `TSF-FR-024` — exclusion *"MUST be
indistinguishable from non-existence."* Therefore excluded people are absent
from B4's input entirely (`DRK-FR-004`).
`DRK-PRV-005` — `DRK-SIG-002` (mutual count) **MUST** exclude anyone blocked in
either direction. Authority: B1 `SGR-FR-026`.

`DRK-SEC-002` — ⛔ B4 **MUST NOT** accept a `tenantId` or `StudentRecordId` in a
social-side call. Authority: `ID-2` (BC Map **L488**); CI banned symbols
(**L268-270**).
`DRK-SEC-003` — Cursors and page tokens **MUST** be opaque and **MUST NOT**
encode a score, a weight or an internal identifier. Authority: BC Map §15.3
`PG-1`…`PG-4`; B3 `SDS-API-002`.
`DRK-SEC-004` — ⛔ B4 **MUST NOT** make an authorisation decision. Owner:
`BC-18` (`X-13`). B4 receives an already-authorised set.

---

## §B4.11 Evaluation

`DRK-EVAL-001` — B4 **MUST** be evaluable offline by replaying recorded inputs
against a configuration version and comparing orderings.
`DRK-EVAL-002` — ⛔ Evaluation **MUST NOT** use viewer-referenced behavioural
telemetry. Precedent: A3 `P2-2` removed exactly this from its evaluation record.
`DRK-EVAL-003` — Aggregate evaluation metrics **MAY** be projected by `BC-26`
through its existing event-driven path. ⛔ B4 **MUST NOT** build a metric store.
Owner: `BC-26` (BC Map **L135**); A3 `LCR-XC-011`.
`DRK-EVAL-004` — ⛔ B4 **MUST NOT** run an online experiment, A/B split or
bandit. No experimentation platform is measured in the repository.
`DRK-EVAL-005` — A configuration change **MUST** be evaluable before activation
by replay; ⛔ activation **MUST NOT** depend on live traffic comparison.

---

## §B4.12 Scope — V1 · Future · Deferred

| ID | Statement | Wave | Authority |
|---|---|---|---|
| `DRK-SCOPE-001` | Post-retrieval ordering for the **library-scoped search** surface | **V1** | EA **L927** `Search Students (V1)`; subject to `XPB-CONF-001` |
| `DRK-SCOPE-002` | Common-interest signal | **V2** | EA **L931** |
| `DRK-SCOPE-003` | Proximity signal | **V2** | EA **L929** |
| `DRK-SCOPE-004` | Ordering for the recommendation surface | **V2** | EA **L930** `Recommended Students (V2)` — `XPB-CONF-002` |
| `DRK-SCOPE-005` | ML / AI ranking | **Future** | EA **L933**; ⛔ `DRK-XC-014` |

`DRK-XC-015` — ⛔ **It MUST be IMPOSSIBLE for B4 to order a global, local or
nearby candidate set in V1.** B6 clamps scope to LIBRARY (`GLS-FR-002`), so no
such set can reach B4. A B4 input containing an out-of-scope candidate is a
**B6 defect**, and B4 **MUST** reject the whole request rather than order it
(`DRK-EC-011`).
`DRK-XC-016` — ⛔ B4 **MUST NOT** rank libraries, content, posts, messages or
seats. Its only subject is a person candidate list. Library discovery ordering
belongs to the `AR-1` capability; feed ranking to `PRD-021A` A3.

---

## §B4.13 Edge cases

| ID | Case | Required behaviour |
|---|---|---|
| `DRK-EC-001` | Empty candidate list | Return empty. ⛔ No error, no padding |
| `DRK-EC-002` | Single candidate | Return as-is; ⛔ no score computed |
| `DRK-EC-003` | All scores identical | Order by `PersonId` ascending (`DRK-DET-002`) |
| `DRK-EC-004` | `BC-23` relevance absent on a query surface | Treat as total degradation: return input order, record it |
| `DRK-EC-005` | Mutual count unavailable | Renormalise remaining weights (`DRK-FR-014`) |
| `DRK-EC-006` | Configuration invalid or out of range | Reject, keep last valid version (`DRK-BR-008`) |
| `DRK-EC-007` | Weights do not sum to 1.00 | Reject configuration (`DRK-BR-009`) |
| `DRK-EC-008` | Candidate blocked between [3] and [5] | Not B4's to fix — ⛔ B4 **MUST NOT** filter. B3 re-validates on next request |
| `DRK-EC-009` | Mutual count exceeds saturation cap | Clamp to `DRK-CFG-004`; ⛔ no unbounded contribution |
| `DRK-EC-010` | Duplicate `PersonId` in input | Return the duplicate as received; ⛔ B4 **MUST NOT** dedupe (that would change the multiset, `DRK-XC-007`) — record as an upstream defect |
| `DRK-EC-011` | Out-of-scope candidate present | Reject the request; report as a **B6** violation (`DRK-XC-015`) |
| `DRK-EC-012` | Time budget exceeded | Return input order; record degradation. ⛔ **MUST NOT** return a partial ordering |

---

## §B4.14 Acceptance criteria — 26, all GWT, all mapped

| ID | Given | When | Then (measurable) | Requirement |
|---|---|---|---|---|
| `DRK-AC-001` | A candidate list from B3 | B4 orders it | Output is a permutation of input: same multiset, same cardinality | `DRK-XC-007`, `DRK-FR-004` |
| `DRK-AC-002` | Identical input and configuration version | B4 runs twice | Both orderings are byte-identical | `DRK-DET-001` |
| `DRK-AC-003` | A candidate absent from B3's output | B4's result is inspected | That identifier is absent from B4's output | `DRK-XC-007` |
| `DRK-AC-004` | Two candidates with equal scores | Ordering is produced | They appear in `PersonId` ascending order | `DRK-DET-002` |
| `DRK-AC-005` | A configuration with weights summing to `0.95` | Loaded | Configuration is rejected; previous version stays active | `DRK-BR-009`, `DRK-EC-007` |
| `DRK-AC-006` | `weight.relevance = 1.7` | Loaded | Rejected as out of range; ⛔ not clamped | `DRK-BR-008`, `DRK-EC-006` |
| `DRK-AC-007` | A request carrying a client-supplied weight | Received | Request is rejected, not ignored | `DRK-SEC-001`, `DRK-XC-012` |
| `DRK-AC-008` | A suspended person | Discovery runs | They are absent from B4's input and output; ⛔ no down-weighted entry exists | `DRK-XC-011`, `DRK-PRV-004` |
| `DRK-AC-009` | A query surface with `BC-23` relevance bands | B4 orders | Band order is preserved; re-ordering occurs only within a band | `DRK-BR-001`, `DRK-XC-004`, `DRK-FR-009` |
| `DRK-AC-010` | Mutual-count signal unavailable | B4 orders | Remaining active weights renormalise to `1.00`; result returned | `DRK-FR-014`, `DRK-EC-005` |
| `DRK-AC-011` | All signals unavailable | B4 orders | Input order returned; degradation recorded | `DRK-BR-003`, `DRK-BR-010` |
| `DRK-AC-012` | An internal B4 error | Discovery request completes | Discovery succeeds with input order; ⛔ no 5xx | `DRK-BR-003` |
| `DRK-AC-013` | An ordering was produced | Explainability record requested | Record names each active signal, its value, its weight, config version and algorithm version | `DRK-EXP-001`, `DRK-EXP-002` |
| `DRK-AC-014` | A peer-facing response | Inspected | ⛔ Contains no score, weight, rank position rationale or explanation | `DRK-EXP-004`, `DRK-PRV-003` |
| `DRK-AC-015` | An audit record is emitted | `BC-24` store is read | Record arrived via `E-20`; contains no profile or message content | `DRK-EXP-005`, `DRK-EXP-006` |
| `DRK-AC-016` | A blocked person | Mutual count computed | They are excluded from the count | `DRK-PRV-005` |
| `DRK-AC-017` | Profile completeness computed | Field access is traced | Only `BC-10` allow-listed fields were read | `DRK-PRV-001`, `DRK-PRV-002` |
| `DRK-AC-018` | A social-side B4 call | Payload inspected | ⛔ Contains no `tenantId` and no `StudentRecordId` | `DRK-SEC-002` |
| `DRK-AC-019` | The hosting module's dependency manifest | Inspected | ⛔ Contains zero ML, model-serving or embedding packages | `DRK-XC-014`, `DRK-DET-006` |
| `DRK-AC-020` | A page token | Decoded | ⛔ Contains no score, weight or internal identifier | `DRK-SEC-003` |
| `DRK-AC-021` | An empty candidate list | B4 runs | Empty result; ⛔ no error and no padding | `DRK-EC-001` |
| `DRK-AC-022` | A mutual count of `40` with cap `10` | Score computed | Contribution is clamped at the cap | `DRK-EC-009`, `DRK-CFG-004` |
| `DRK-AC-023` | An equal-score band of 8 sharing one signal value, cap `3` | Diversity applied | Order changes; ⛔ all 8 remain present | `DRK-FR-007`, `DRK-FR-008` |
| `DRK-AC-024` | A candidate outside library scope | Reaches B4 | Whole request rejected and reported as a B6 violation | `DRK-XC-015`, `DRK-EC-011` |
| `DRK-AC-025` | Two runs at different wall-clock times, same `asOf` | Compared | Orderings identical | `DRK-DET-003` |
| `DRK-AC-026` | ⚠ `DRK-SIG-003` same-library in a V1 library-scoped set | Contribution measured | Contribution is exactly `0.00` and it is not reported as active | `DRK-BR-004`, `DRK-BR-005` |

⭐ **26 ACs · 26 map to a requirement in this document · 0 orphans.**
⚠ **No AC asserts a deferred or refused signal works.** `DRK-AC-026` deliberately
asserts the **inertness** of `DRK-SIG-003` rather than its function.

---

## §B4.15 Disclosed gaps — OPEN, each with an owner

| ID | Gap | Blocks authoring? | Blocks implementation? | Owner |
|---|---|---|---|---|
| `DRK-GAP-001` | ⭐ `XPB-CONF-001` — is a post-retrieval ordering layer lawful beside `BC-23` step [4]? | ⛔ No | ✅ **Yes** | **ARB** |
| `DRK-GAP-002` | `DRK-SIG-005` needs `BC-11` added to `identity.PersonIdentityCreated`'s consumer cell (BC Map **L424**) — a Rank 4 append. Also carries the band-epsilon question (`DRK-FR-010`) | ⛔ No | ⚠ Signal only | **ARB** |
| `DRK-GAP-003` | `DRK-SIG-007` co-presence has **0** authorised edges and is blocked by `X-05` | ⛔ No | ⛔ No — refused | **Architecture Owner** |
| `DRK-GAP-004` | `DRK-SIG-010` / `DRK-FR-013` need a per-viewer impression store; **0** measured. A3 deferred the same as `D-3` | ⛔ No | ⚠ Frequency capping only | **Architecture Owner** |
| `DRK-GAP-005` | Ranking-configuration ownership between B4 and `BC-25` — inherited from A3 `D-5`, still open | ⛔ No | ⚠ Yes | **ARB** |

---

## §B4.16 What B4 does **not** do

⛔ Creates no bounded context (**31** unchanged) · ⛔ creates no integration edge
· ⛔ mints no published event · ⛔ mints no `PERM-*` (`AUTH-7.22` closes the
catalogue) · ⛔ mints no `IMPL-*` and creates no implementation task · ⛔ builds
no index, no store, no cache of record · ⛔ persists no ordering · ⛔ filters,
admits or excludes nobody · ⛔ makes no authorisation decision · ⛔ amends no
frozen PRD (`PRD-020`, `PRD-021A` A1, `Student_Identity_PRD_v1` byte-unchanged)
· ⛔ amends no Rank 1–5 artefact · ⛔ modifies no CI rule · ⛔ creates no ADR ·
⛔ resolves `XPB-CONF-001`, `-002` or `-003` · ⛔ modifies any B0/B1/B2/B3
requirement · ⛔ claims no Stage 3 or Stage 4 result · ⛔ writes no application
code.

---

## §B4.17 Status

> ## `PRD-021B` Part B4 STATUS: **DRAFT / STAGE 2**

⛔ **NOT** Stage 3. ⛔ **NOT** Stage 4. ⛔ **NOT** `APPROVED`. ⛔ **NOT**
`FROZEN`. ⛔ **NOT** implementation-ready.

**Exact next step: Stage 3 — Architecture Review**, whose gate is a written
alignment record. ⚠ **`XPB-CONF-001` will be the first thing that record must
confront**, and it is an **ARB** question, not an authoring one.

---

**END — `PRD-021B` Part B4 v0.1 — DRAFT / Stage 2.**
