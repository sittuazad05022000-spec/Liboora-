<!--
  PRD-021A — Part A3 — Community Feed Ranking
  DRAFT v0.1

  PROVENANCE
  ----------
  This document is the STEP 2 CORRECTION PASS output over the A3 draft that was
  delivered in chat and reviewed adversarially. The review returned NOT READY with
  6 P0, 7 P1, 4 P2 and 3 P3 findings.

  This pass applies ONLY the corrections that require no new architectural or
  product decision. Every finding whose resolution needed a named owner is left
  DEFERRED and routed, not decided.

  APPLIED IN THIS PASS
    P0-1  Release wording corrected. This is a V2 capability carrying a
          first-generation algorithm (RANK-1). No "V1 release" claim remains.
    P0-5  The invented A4-A8 ownership roster is removed. Ownership is stated
          against actual repository bounded contexts.
    P1-3  Enforcement/moderation is a HARD FILTER only. It is never a soft
          ranking penalty.
    P1-4  One scoring table. Active weights sum coherently. Reserved weights are
          separated and marked NOT IN EFFECT.
    P1-5  Latency numbers are non-binding objectives, not thresholds.
    P1-6  Candidate cap and pagination convention are no longer minted here.
    P1-7  "Multi-tenant isolation" replaced by "community isolation" wherever the
          tenant question is unresolved for BC-15.
    P2-1  The degenerate Community Relevance signal is deactivated.
    P2-2  Viewer-reference behavioural telemetry removed from the evaluation record.
    P2-3  Identifiers carry a consistent prefix, declared PROPOSED and UNRATIFIED.
    P2-4  Storage-ownership contradiction corrected.
    P3-1  The five-expert review model is removed from product requirements.
    P3-2  Official priority no longer uses P0-P3 notation.
    P3-3  A single section structure. Sections 0-36, contiguous.

  DEFERRED, NOT DECIDED IN THIS PASS
    D-1  helpState / unresolved-help ownership
    D-2  A2 LCF-GAP-012 comments/reactions decision
    D-3  per-viewer impression / already-seen tracking
    D-4  BC-15 -> BC-11 social relevance edge
    D-5  ranking configuration ownership between A3 and BC-25

  NOT DONE
    No ADR created or numbered. No bounded context, event, permission, integration
    edge or aggregate row added to any register. A1 and A2 are not modified. No
    frozen or accepted artefact is amended. No scope silently changed.
-->

# PRD-021A — Part A3
# Community Feed Ranking

**v0.1 — DRAFT** · correction pass applied; unresolved items deferred, not decided

---

## 0. Provenance and status

```
Status        : DRAFT — v0.1.
Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
Lifecycle     : No stage advanced. No acceptance criterion is claimed to pass.
Capability    : V2 — inherited from BC-15 by repository authority (see §7).
Algorithm     : RANK-1, the first generation of the ranking algorithm.
Predecessors  : A1 v0.2 (Community Foundation), A2 v0.4 (Community Feed & Content)
Repository    : This document amends no other artefact.
```

**What this document does NOT do:**
- creates no bounded context
- creates no integration edge, event, permission, role, configurable or aggregate row in any Rank 1–5 register
- amends no `FROZEN` PRD, no `ACCEPTED` ADR, no Rank 1–4 artefact
- does not modify A1 or A2
- does not mint an ADR number
- does not resolve A2's open conflicts, and does not depend on resolving them to ship its active subset
- claims no acceptance criterion passes

⚠ **The `LCR-` prefix used below is proposed, not conferred.** A2 records that every repository PRD carries a registered prefix and that ratifying a new one is a **Governance Owner** act. `LCR-` inherits exactly that posture — it is proposed here and ratified nowhere. Recorded as `LCR-GAP-001`.

---

## 1. Executive Summary

A3 answers one question:

> Given a set of posts a student is **already authorised** to see, in what order should they appear?

A3 does **not** decide whether a student may see a post. That is settled upstream before A3 is invoked.

The mandatory pipeline is:

```
A1        Community authorisation
   |
A2        Candidate generation
   |
A2/BC-13  Eligibility, privacy and enforcement filtering   <-- HARD filters
   |
A3        Deterministic scoring
   |
A3        Diversity and freshness ordering
   |
A2        Final feed response
```

`LCR-FR-001` | A3 SHALL order posts. A3 SHALL NOT admit, authorise, or widen the set of posts it receives.

`LCR-INV-001` | A3 can change the **sequence** of a result set. A3 can never change its **membership** except by removing a post. This restates A2 `LCF-FR-078` and is the load-bearing invariant of this part.

**Honest statement of current capability.** Of the nine signals the design reserves, exactly one — **Recency** — has a substrate in the repository today. Seven are `DEFERRED` because their substrate does not exist, or exists only behind another owner's undecided question. One is `WITHDRAWN` as degenerate. §11 and §14 state this precisely rather than implying a richer model than the repository can support.

`LCR-FR-002` | A3 SHALL NOT fabricate a ranking signal. A signal whose substrate does not exist SHALL contribute exactly **zero**, and SHALL be listed in the deferred register (§14).

---

## 2. Problem Statement

`LCR-FR-003` — A2 orders the feed reverse-chronologically (`LCF-FR-075`). That is correct, safe, and insufficient once a community is active: a genuinely useful post is buried by a newer trivial one.

`LCR-FR-004` — A2 deliberately declined to specify ranking. `LCF-FR-076`: "This part SHALL NOT define a ranking signal, weight, decay function or engagement metric. Those are A3-owned." A2 `LCF-XC-021` records "Any new ranking system | **A3 only**." This part exists to fill exactly that seam and nothing wider.

`LCR-FR-005` — Ordering must be explainable and reproducible. A feed a team cannot explain is a feed it cannot debug, tune, or defend to a regulator.

**What this problem is not.** It is not search relevance (`BC-23`, A2 `LCF-XC-014`), not discovery, not a global network, and not personalisation. Those have separate owners.

---

## 3. Goals

`LCR-FR-006` | Surface useful content earlier than a purely chronological order would, using only signals the repository can supply.

`LCR-FR-007` | Be deterministic: identical inputs plus identical configuration SHALL yield identical ordering.

`LCR-FR-008` | Be reproducible after the fact from recorded inputs and a version identifier.

`LCR-FR-009` | Degrade safely. A ranking failure SHALL NOT become a feed failure.

`LCR-FR-010` | Remain implementable by a small team without machine learning, model serving, or an experimentation platform.

`LCR-FR-011` | Add no ownership that another bounded context already holds.

---

## 4. Non-Goals and Exclusions

ID | Excluded | Owner / reason
--- | --- | ---
`LCR-XC-001` | Authorisation, membership and community access decisions | A1; A3 receives an already-authorised set
`LCR-XC-002` | `CommunityPost`, `CommunityComment`, `CommunityReaction` and their lifecycle | `BC-15`, specified by A2 (`LCF-INV-002`)
`LCR-XC-003` | Feed retrieval, pagination convention and response shape | A2 §13, §14
`LCR-XC-004` | Search indexing, query rewriting and search relevance | `BC-23` (BC Map **L132**); categorically separate index class per `AR-3` (BC Map **§11.1 L494**)
`LCR-XC-005` | Abuse reports, moderation decisions, strikes, enforcement | `BC-13` (BC Map **L379**); reaches `BC-15` outbound by `E-14` (BC Map **L318**)
`LCR-XC-006` | Anti-spam heuristics, reputation scoring, abuse detection | `BC-13` — A2 `LCF-XC-028`, EA **L919**
`LCR-XC-007` | Friendship, follow, block and the relationship graph | `BC-11` (BC Map **L377**)
`LCR-XC-008` | Student identity, profile, privacy mode | `BC-10` (BC Map **L376**)
`LCR-XC-009` | Notification dispatch of any kind | `BC-22` (BC Map **L131**), reached only by `E-23`
`LCR-XC-010` | Settings hierarchy, feature flags, configuration platform | `BC-25` (BC Map **L134**), reached only by `E-19`
`LCR-XC-011` | The metric/semantic layer, projections, reports, exports | `BC-26` (BC Map **L135**)
`LCR-XC-012` | Machine learning, neural recommendation, learning-to-rank, reinforcement learning, automated weight optimisation | Excluded from `RANK-1` entirely (§29)
`LCR-XC-013` | Cross-library, cross-community, global or location-based ranking | Prohibited by `LCR-INV-002` (§26)
`LCR-XC-014` | Any new storage system | `BC-29` only, reached via `BC-14` — A2 `LCF-XC-020`
`LCR-XC-015` | Any new permission identifier | `AUTH-7.22` closes the catalogue; `ADR-0036` §7.1 records **zero** `PERM-*` repo-wide
`LCR-XC-016` | The analytics product for community content | `Community Analytics` is **V3** — EA **L973**, A2 `LCF-XC-029`

---

## 5. Ownership Boundaries

⚠ **Correction applied (P0-5).** The reviewed draft assigned ownership to "A4 … A8". `grep -rl "Part A4" docs/` … `"Part A8"` returns **0 files each** — those parts do not exist. Worse, two of the concerns assigned to them are already owned by **V1** bounded contexts. Ownership below is stated against the actual repository.

Concern | Owner | Repository basis | A3's relationship
--- | --- | --- | ---
Community access / authorisation | **A1** | A1 is a read-composition capability; owns no aggregate (`AR-1` §23) | Consumes the decision; never makes it
Library membership validity | **`BC-02`** | BC Map **L371** | Consumed upstream of A3
`CommunityPost` and content lifecycle | **`BC-15`**, specified by A2 | BC Map **L119**; A2 `LCF-INV-002` | Reads identifiers only
Feed retrieval and pagination | **A2** | A2 §13, §14 | A3 is invoked by A2
**Feed ordering / ranking** | **A3** | A2 `LCF-XC-021` "Any new ranking system \| A3 only"; `LCF-FR-074`…`078` | **Owned here**
Comments and reactions | **`BC-15`**, specified by A2 | A2 L241–242, L1065, L1076 | ⏸ Gated — see `LCR-GAP-003`
Enforcement, moderation, anti-spam | **`BC-13`** | BC Map **L379**, **L318** (`E-14`) | Consumed as a **hard filter** (§10)
Notifications | **`BC-22`** | BC Map **L131**, `E-23` | Untouched by A3
Identity / profile / privacy mode | **`BC-10`** | BC Map **L376** | Untouched by A3
Social relationships | **`BC-11`** | BC Map **L377** | ⏸ No edge exists — `LCR-GAP-004`
Configuration values | **`BC-25`** | BC Map **L134**, `E-19` | ⏸ Unresolved — `LCR-GAP-005`
Analytics semantic layer | **`BC-26`** | BC Map **L135** | Emits facts only; interprets nothing

`LCR-INV-003` | A3 SHALL NOT introduce a second answer to any ownership question already answered above. Where a concern is owned elsewhere, A3 consumes a contract or does without.

**Parts A4–A8 are not referenced as owners anywhere in this document.** They do not exist. When they are authored they may take custody of the concerns this part records as deferred; nothing here presumes their shape.

---

## 6. Ranking Principles

`LCR-BR-001` | Authorisation precedes ranking, always.

`LCR-BR-002` | Community isolation is absolute and is enforced before scoring.

`LCR-BR-003` | Usefulness outranks popularity. Raw engagement SHALL NOT be able to dominate.

`LCR-BR-004` | Enforcement outcomes are **hard filters**, never score adjustments (§10).

`LCR-BR-005` | Freshness matters, but is not the only thing that matters.

`LCR-BR-006` | Every ordering SHALL be deterministic and reproducible.

`LCR-BR-007` | An unavailable signal contributes zero and is declared, never estimated.

`LCR-INV-004` | No signal, weight or configuration value can cause an unauthorised post to appear. This is not a tunable property.

---

## 7. Scope and Version Classification

⚠ **Correction applied (P0-1).** The reviewed draft was labelled "Scope: V1 Ranking Specification" and used "V1" throughout to mean the release train. The repository places this capability in **V2**, and A2 spent a full revision resolving exactly that conflict. This part does not reopen it.

Claim | Repository evidence
--- | ---
Community Feed is **V2** | `MASTER_PRD.md` **L92** `MP-SCOPE-04` → `BC-15 \| V2` (**Rank 1**)
`BC-15` Community & Groups is **V2** | BC Map **L119**
`Community Feed (V2)` | EA **L970**
A2 classified itself V2 on this basis | A2 v0.4 Conflict 1, **RESOLVED**

`LCR-FR-012` | A3 is a **V2 capability**. It ships no earlier than the capability it orders.

`LCR-FR-013` | The algorithm specified here is **`RANK-1`** — the *first generation* of the ranking algorithm, not a V1 release artefact. Subsequent generations (`RANK-2`, …) are §29 scope.

**Terminology used consistently below.** "V2" refers to the release train. "`RANK-1`" refers to this algorithm generation. The two are never used interchangeably. Where the reviewed draft said "V1 ranking", this part says "`RANK-1`".

---

## 8. Ranking Pipeline

`LCR-FR-014` | The pipeline SHALL execute in exactly this order:

Step | Stage | Owner | Kind
--- | --- | --- | ---
1 | Resolve community scope | A1/A2 | Precondition
2 | Authorise viewer for the community | A1 | **Hard**
3 | Generate candidates | A2 | Precondition
4 | Remove invalid, deleted, non-`PUBLISHED` candidates | A2 | **Hard filter**
5 | Apply privacy and enforcement filters | A2 / `BC-13` via `E-14` | **Hard filter**
6 | Compute active signal values | A3 | Scoring
7 | Compute the composite score | A3 | Scoring
8 | Apply diversity rules | A3 | Ordering
9 | Apply the stable tie-break | A3 | Ordering
10 | Return ordered post identifiers | A3 → A2 | Output

`LCR-FR-015` | Steps 1–5 SHALL complete before step 6 begins. A3 SHALL NOT interleave scoring with filtering.

`LCR-FR-016` | If A3 receives a candidate that should have been removed at steps 4–5, A3 SHALL discard it and SHALL record a contract violation. A3 SHALL NOT rank it. This is a defence-in-depth measure, not a substitute for upstream filtering.

`LCR-INV-005` | Steps 4 and 5 can only **remove**. Steps 6–9 can only **reorder**. No step can add.

---

## 9. Candidate Generation

Candidate generation is **A2-owned**. A3 states only what it requires of the input.

`LCR-FR-017` | Every candidate set SHALL carry the community scope identifier it was generated for.

`LCR-FR-018` | A3 SHALL reject a candidate set that does not carry a community scope identifier. It SHALL fail closed — no ranking, no partial result.

`LCR-FR-019` | A3 SHALL reject a candidate set containing a post from any community other than the one in scope.

`LCR-FR-020` | Duplicate post identifiers SHALL be reduced to one occurrence before scoring.

`LCR-FR-021` | The candidate set SHALL be **bounded**. A3 SHALL NOT accept an unbounded set.

⛔ **The numeric bound is NOT set here (P1-6 correction).** The reviewed draft minted "200 candidates". A2 `LCF-BR-008` states a page-size bound "is a configuration concern and SHALL NOT be minted here (`LCF-GAP-006`)". A3 inherits that refusal rather than overriding a sibling part.

`LCR-FR-022` | The candidate bound SHALL be supplied by configuration. Its value is deferred — `LCR-GAP-005`, `LCF-GAP-006`.

⛔ **Pagination convention is NOT selected here (P1-6 correction).** The reviewed draft said "cursor-based". A2 §14.1 records `grep -rniE 'cursor' docs/10-architecture/*.md` → **zero results**, and routes the convention to the **Architecture Owner** as `LCF-ADR-003` / `LCF-DEC-005`. A3 selects nothing.

`LCR-FR-023` | A3 SHALL operate correctly under whatever pagination convention A2 and the Architecture Owner settle on, and SHALL NOT depend on the token's internal structure.

---

## 10. Hard Filters — Enforcement, Privacy, Eligibility

⚠ **Correction applied (P1-3).** The reviewed draft contradicted itself: its pipeline section placed moderation in the hard filters, while its "Negative Signals" section re-admitted moderation as a **soft score penalty**. That is a security regression, and it contradicts A2. This part removes the soft path entirely.

**Repository position.** A2 `LCF-FR-060`: "The feed SHALL exclude posts suppressed by the local enforcement read model." `E-14` (BC Map **L318**) delivers `EnforcementActionTaken{personId, action, scope, until}` to `BC-15`, which **self-restricts**; BC Map **L379** places every enforcement action under `BC-13` with a case, an actor and a reason.

`LCR-FR-024` | A post suppressed by the enforcement read model SHALL NOT enter the ranking pipeline. It SHALL NOT be scored, penalised, demoted or reordered. It SHALL be **absent**.

`LCR-FR-025` | A3 SHALL NOT accept, define, or apply a score adjustment derived from an enforcement action, a moderation decision, a strike, or an abuse report.

`LCR-FR-026` | A3 SHALL NOT interpret an abuse report. A report is an input to `BC-13`, not to ranking.

`LCR-INV-006` | There SHALL exist no configuration value, weight, or signal combination by which a suppressed post can be ranked into a feed. The suppression path and the scoring path do not meet.

**Categories that are hard filters, never signals:**

Category | Removed by | Basis
--- | --- | ---
Post outside the community in scope | A2 / A3 step 4–5 | `LCR-INV-002`
Deleted or non-`PUBLISHED` post | A2 | A2 lifecycle §11
Enforcement-suppressed post | A2 local read model | A2 `LCF-FR-060`, `E-14`
Author-level enforcement in scope | A2 local read model | `E-14`, BC Map **L318**
Privacy-restricted content | A2 / `BC-10` policy | BC Map **L376**
Post the viewer is not authorised to read | A1 | A2 `LCF-FR-064`

`LCR-FR-027` | §14's quality signals SHALL be restricted to **content-quality** indications that are not enforcement outcomes. Where no such non-enforcement signal exists, §14 contributes zero.

---

## 11. Ranking Signals — Availability Register

This section is the honest core of the document. Each signal is stated with its substrate status, measured against the repository.

ID | Signal | Status | Substrate evidence
--- | --- | --- | ---
`LCR-RS-001` | **Recency** | ✅ **ACTIVE** | A2 post model carries `createdAt`; A2 `LCF-FR-075` already orders by it
`LCR-RS-002` | **Unresolved help priority** | ⏸ **DEFERRED** | No `helpState` field exists. A2 `LCF-FR-027`: the post-type set is "**closed** … exactly `TEXT`, `NOTE`, `MEDIA`, `LINK`". → `LCR-GAP-002`
`LCR-RS-003` | **Helpfulness** | ⏸ **DEFERRED** | Requires a helpful/resolution indication. None exists; the nearest surface is comments/reactions, which A2 `LCF-XC-017` **defers** and whose status is A2's open `LCF-GAP-012`. → `LCR-GAP-003`
`LCR-RS-004` | **Legitimate engagement** | ⏸ **DEFERRED** | Same substrate as `LCR-RS-003`. A2 `LCF-EVT-005`/`006` exist as event definitions, but the surface itself is gated by `LCF-GAP-012`. → `LCR-GAP-003`
`LCR-RS-005` | **Official announcement priority** | ⏸ **DEFERRED** | No announcement post type and no priority field. A2's type set is closed (`LCF-FR-027`); A2 `LCF-FR-002` notes announcements have "no durable home" but does not create one. → `LCR-GAP-002`
`LCR-RS-006` | **Social relevance** | ⏸ **DEFERRED** | No `BC-15 → BC-11` integration edge exists. BC Map **L292**: "If an edge is not in this table, **it does not exist**." → `LCR-GAP-004`
`LCR-RS-007` | **Already-seen suppression** | ⏸ **DEFERRED** | Requires per-viewer impression records. None exist in A2 or any BC. Creating them is a personal-data decision affecting a minor-inclusive population (`SM-INV-3`; BC-10 **L376** "privacy default = most restrictive"). → `LCR-GAP-006`
`LCR-RS-008` | **Content-quality penalty** | ⏸ **DEFERRED** | Any non-enforcement quality score would come from `BC-13` anti-spam (A2 `LCF-XC-028`, EA **L919**). No contract is published. Enforcement outcomes are excluded by `LCR-FR-025`. → `LCR-GAP-007`
`LCR-RS-009` | ~~Community relevance~~ | ⛔ **WITHDRAWN** | **P2-1 correction.** Every candidate is already community-scoped and cross-community candidates are rejected at step 5, so this signal is **constant across the candidate set** and mathematically cannot affect ordering. It is withdrawn rather than carried as inert weight.

`LCR-FR-028` | A `DEFERRED` signal SHALL contribute exactly zero to the composite score. Its weight SHALL be recorded as **reserved and not in effect**.

`LCR-FR-029` | A `DEFERRED` signal SHALL NOT be activated by configuration alone. Activation requires the substrate to exist and its owner to publish a contract.

`LCR-FR-030` | A `WITHDRAWN` signal SHALL NOT be reintroduced without a stated, varying definition.

**Consequence, stated plainly.** With one active signal, `RANK-1` orders by recency inside a hard-filtered, community-scoped set, then applies diversity and a stable tie-break. That is a **modest but honest** improvement over A2 `LCF-FR-075`: the diversity pass and the deterministic tie-break are real, testable behaviour that A2 does not provide. It is not a rich ranking model, and this part does not pretend otherwise.

---

## 12. Scoring Model

⚠ **Correction applied (P1-4).** The reviewed draft carried **two** mutually inconsistent weight tables, and its arithmetic did not reach the "0–100" it claimed (positives summed to 95). This part publishes **one** table, separates active from reserved, and states the arithmetic exactly.

### 12.1 The single weight table

Signal | Status | Weight | In effect?
--- | --- | --- | ---
`LCR-RS-001` Recency | ACTIVE | **100** | ✅ Yes
`LCR-RS-002` Unresolved help | DEFERRED | *reserved* | ⛔ No — 0
`LCR-RS-003` Helpfulness | DEFERRED | *reserved* | ⛔ No — 0
`LCR-RS-004` Legitimate engagement | DEFERRED | *reserved* | ⛔ No — 0
`LCR-RS-005` Official priority | DEFERRED | *reserved* | ⛔ No — 0
`LCR-RS-006` Social relevance | DEFERRED | *reserved* | ⛔ No — 0
`LCR-RS-007` Already-seen | DEFERRED | *reserved* | ⛔ No — 0
`LCR-RS-008` Content quality | DEFERRED | *reserved* | ⛔ No — 0

`LCR-FR-031` | The composite score SHALL be the weighted sum of **active** signals only, normalised to the range `0`–`100`.

`LCR-FR-032` | Each signal SHALL be normalised to `0.0`–`1.0` before its weight is applied.

`LCR-FR-033` | The active weights SHALL sum to exactly `100`. With one active signal, recency carries the whole range. This is a **consequence** of the availability register, not a design preference.

`LCR-FR-034` | **No reserved weight is published here.** Assigning a number to a deferred signal would imply a decision about a substrate that does not exist and an owner who has not been asked. Weights are assigned when a signal activates, by whoever owns its activation.

`LCR-FR-035` | When a signal activates, the full active set SHALL be renormalised so the sum remains exactly `100`. Activation SHALL NOT silently inflate the range.

### 12.2 What the score cannot do

`LCR-INV-007` | A high score SHALL NOT overcome a hard filter. Score is compared only among posts that already passed §10.

`LCR-FR-036` | Score SHALL NOT be exposed to a student-facing client (§22).

---

## 13. Recency

`LCR-FR-037` | Recency SHALL be computed from the post's authoritative creation timestamp, supplied by A2. A3 SHALL NOT store its own copy.

`LCR-FR-038` | Recency SHALL use deterministic, bucketed decay. Bucketed decay is chosen over a continuous function because it is trivially reproducible and testable without floating-point drift.

Age bucket | Normalised recency
--- | ---
0–6 hours | `1.00`
6–24 hours | `0.85`
1–3 days | `0.65`
3–7 days | `0.40`
7–14 days | `0.20`
older than 14 days | `0.10`

`LCR-FR-039` | Bucket boundaries and values SHALL be configuration-supplied. The values above are the **initial proposal**, not a ratified parameter set — `LCR-GAP-005`.

`LCR-FR-040` | Recency SHALL influence ordering only. It SHALL NOT cause deletion, archival, hiding, or exclusion of any post.

`LCR-BR-008` | An old post remains eligible indefinitely. Decay floors at the oldest bucket and never reaches zero.

`LCR-FR-041` | Recency SHALL be evaluated against a single request-scoped clock reading, so that all candidates in one request share one reference time. This is required for `LCR-FR-007` determinism.

---

## 14. Deferred Signals — Reserved Design

This section preserves the reserved design for each deferred signal so that no work is lost, while making unmistakably clear that **none of it is in effect**. Nothing here is a decision.

`LCR-FR-042` | Every subsection below is **reserved**. None SHALL be implemented in `RANK-1`.

### 14.1 Unresolved help priority — DEFERRED

Reserved intent: an unanswered request for help is the single most useful thing a study-library feed can surface, so it would carry a strong, time-bounded boost.

⛔ **Blocked.** No `helpState` exists. A2 `LCF-FR-027` closes the post-type set to `TEXT`, `NOTE`, `MEDIA`, `LINK` and requires "a PRD amendment" for a fifth type. A3 cannot mint a field inside `BC-15`'s aggregate — that would be inventing a requirement in a sibling part.

`LCR-FR-043` | A3 SHALL NOT define, store, or infer a help state. → `LCR-GAP-002`

`LCR-BR-009` | *Reserved:* were the signal to activate, an unresolved post SHALL NOT be able to hold a top position indefinitely; the boost decays and terminates.

### 14.2 Helpfulness — DEFERRED

Reserved intent: prefer content other members found genuinely useful over content that merely attracted attention.

⛔ **Blocked.** No helpfulness indication exists. The nearest substrate is comments/reactions, whose existence in this generation is **A2's open `LCF-GAP-012`** — routed to the **Product Owner**. Building on it would silently resolve someone else's open question.

`LCR-FR-044` | A3 SHALL NOT infer helpfulness from any proxy. → `LCR-GAP-003`

### 14.3 Legitimate engagement — DEFERRED

Reserved intent: a small, capped contribution from validated community activity.

⛔ **Blocked.** Same substrate and same gate as §14.2.

`LCR-BR-010` | *Reserved:* engagement SHALL be capped such that it can never independently determine ordering, SHALL exclude self-engagement, and SHALL be deduplicated per actor. This cap is a **design constraint on activation**, recorded now so it is not forgotten later.

### 14.4 Official announcement priority — DEFERRED

Reserved intent: a library's urgent notice should reach the top of its community feed for a bounded period.

⛔ **Blocked.** No announcement post type and no priority field. A2 `LCF-FR-002` explicitly observes that library announcements have "no durable home" and that `BC-22` is "a **push channel**, not a readable record" — it names the gap without creating the type.

`LCR-FR-045` | A3 SHALL NOT create an announcement type, a priority field, or a pinning mechanism. → `LCR-GAP-002`

⚠ **Notation corrected (P3-2).** The reviewed draft used `P0`–`P3` for announcement priority, colliding with review-severity notation. Reserved levels are named `PRIO-URGENT`, `PRIO-IMPORTANT`, `PRIO-NORMAL`, `PRIO-INFO`.

`LCR-BR-011` | *Reserved:* every priority level SHALL carry an expiry. On expiry the post SHALL return to ordinary ordering. Permanent domination SHALL NOT be expressible.

### 14.5 Social relevance — DEFERRED

Reserved intent: a small contribution where an existing, permitted relationship makes a post more relevant.

⛔ **Blocked.** No `BC-15 → BC-11` edge exists. BC Map **L292**: "If an edge is not in this table, **it does not exist**." Note the precedent: `ADR-0055` §3 tested necessity **per context** and concluded `BC-11` "answers eligibility as a boolean and never holds a `FileRef`" — an edge is admitted only on a demonstrated, specific need.

`LCR-FR-046` | A3 SHALL NOT read `BC-11` state, directly or through any intermediary. → `LCR-GAP-004`

`LCR-BR-012` | *Reserved:* social relevance SHALL be capped at a small contribution and SHALL never override authorisation, privacy, block or community isolation.

### 14.6 Already-seen suppression — DEFERRED

Reserved intent: prefer unseen content so a returning student sees something new.

⛔ **Blocked, and deliberately so.** This requires per-viewer, per-post impression records — a **new personal-data store** describing the reading behaviour of a population that includes minors. `SM-INV-3` (Student Management, **FROZEN**, L314) treats unknown age as a minor; BC-10 **L376** sets "privacy default = most restrictive". A behavioural-tracking store is not a ranking detail and must not be introduced as one.

`LCR-FR-047` | A3 SHALL NOT record, store, or consume per-viewer impression data in `RANK-1`. → `LCR-GAP-006`

### 14.7 Content-quality penalty — DEFERRED

Reserved intent: demote low-quality content that is not severe enough for enforcement.

⛔ **Blocked, and narrowed.** Anti-spam and reputation scoring belong to `BC-13` (A2 `LCF-XC-028`; EA **L919** `Anti-Spam & Rate Limits (V1)`), and no consumable contract is published. Critically, this signal **may never** carry an enforcement outcome — `LCR-FR-025` forbids it, because enforcement is a hard filter (§10).

`LCR-FR-048` | Any future quality signal SHALL be a non-enforcement, content-level indication supplied by its owner under a published contract. → `LCR-GAP-007`

---

## 15. Diversity

Diversity is **active** — it needs no signal substrate beyond data A2 already returns (author reference and post type).

`LCR-FR-049` | Diversity SHALL be applied after scoring and before the tie-break, as a deterministic reordering within the scored set.

`LCR-FR-050` | Diversity SHALL NOT remove any post. It SHALL only change position.

`LCR-BR-013` | Within the first page, a single author SHOULD NOT occupy an excessive share of consecutive positions where an alternative author is available in the candidate set.

`LCR-BR-014` | Within the first page, a single post type SHOULD NOT occupy an excessive share of consecutive positions where an alternative type is available.

`LCR-FR-051` | The numeric limits for `LCR-BR-013` and `LCR-BR-014` SHALL be configuration-supplied — `LCR-GAP-005`. No value is minted here.

`LCR-FR-052` | Where insufficient diversity exists in the candidate set, the ordering SHALL fall back to pure score order. Diversity SHALL NOT fabricate variety, block a page, or leave a gap.

`LCR-FR-053` | Diversity SHALL be deterministic: the same scored set SHALL always produce the same diversified order. No randomisation, jitter, or shuffling SHALL be used.

---

## 16. Stable Tie-Breaking

`LCR-FR-054` | Two candidates with an equal composite score SHALL be ordered by a total, deterministic tie-break:

```
1. composite score      DESC
2. creation timestamp   DESC
3. post identifier      ASC     <- total order, guarantees no ambiguity
```

`LCR-FR-055` | The tie-break SHALL be **total**: no two distinct candidates SHALL ever compare as equal after step 3.

`LCR-INV-008` | Identical candidate set + identical configuration + identical algorithm version ⇒ **byte-identical ordering**. This is the property that makes `LCR-FR-008` reproducibility testable.

---

## 17. Cold Start

`LCR-FR-056` | A3 SHALL produce a useful ordering with no personalisation data, no viewer history, and no engagement data. In `RANK-1` this is the **only** mode, since all personalised signals are deferred.

`LCR-FR-057` | A newly created community with few posts SHALL receive a valid ordering. An empty candidate set SHALL yield an empty ordering and SHALL NOT be an error (§27).

`LCR-FR-058` | A new member SHALL receive the same ordering as an established member of the same community, because no viewer-specific signal is active.

---

## 18. Fallback

`LCR-FR-059` | If A3 is unavailable, times out, or its configuration cannot be resolved, the feed SHALL be served using the fallback ordering.

`LCR-FR-060` | The fallback ordering SHALL be reverse-chronological, matching A2 `LCF-FR-075`, followed by the §16 tie-break.

`LCR-FR-061` | A ranking failure SHALL NOT surface as a feed error to the student.

`LCR-INV-009` | Fallback SHALL operate on the **same hard-filtered set** as normal ranking. Fallback SHALL NOT widen visibility, relax a filter, or bypass authorisation. This is safe by construction: hard filters run upstream of A3, so losing A3 cannot lose them.

`LCR-FR-062` | Entering or leaving fallback SHALL be observable (§23) so silent degradation is detectable.

---

## 19. Versioning and Configuration

⚠ **Correction applied — partially deferred (P1-1 / D-5).** The reviewed draft gave A3 a stored `RankingConfiguration` entity. `BC-25` Configuration owns "settings hierarchy, feature flags" (BC Map **L134**) and is reachable only through `E-19`, "Typed config accessors; no raw string lookups in domain code" (**L328**). Deciding the split between an A3-owned policy schema and `BC-25`-owned values is an **Architecture Owner** act. This part therefore states the distinction and **defers the ownership decision** rather than resolving it.

`LCR-FR-063` | A3 SHALL own the **schema and semantics** of ranking policy: which signals exist, their status, how they normalise, and how versions supersede.

`LCR-FR-064` | ⏸ **DEFERRED** — whether ranking parameter **values** are stored by `BC-25` and read via `E-19`, or held in an A3-owned store, is an Architecture Owner decision. → `LCR-GAP-005`

`LCR-FR-065` | Until `LCR-GAP-005` is decided, A3 SHALL NOT create a configuration store. It SHALL read values through a typed accessor whose backing is decided later. This keeps the code correct under either outcome.

`LCR-FR-066` | Every ranking result SHALL carry the algorithm version and configuration version that produced it.

`LCR-FR-067` | A configuration version SHALL be immutable once activated. A change SHALL create a new version.

`LCR-FR-068` | Rollback SHALL mean activating a previously approved version. Rollback SHALL NOT rewrite, delete, or reinterpret a historical evaluation record.

`LCR-FR-069` | An algorithm version identifier SHALL be recorded in the form `RANK-<n>`. This generation is `RANK-1`.

---

## 20. Data Model

⚠ **Correction applied (P2-4).** The reviewed draft claimed "No storage ownership is introduced" while simultaneously introducing three stored entities. Both statements cannot be true. This part states the position precisely.

**The precise position.** A3 introduces **no domain-content storage**. It does not store posts, comments, reactions, memberships, profiles, relationships or moderation records. It does require a small amount of **ranking-operational state**, and the ownership of even that is partly deferred.

`LCR-FR-070` | A3 SHALL NOT store, copy, cache or shadow: `CommunityPost`, `CommunityComment`, `CommunityReaction`, membership, student profile, relationship state, or any moderation record.

Entity | Purpose | Status
--- | --- | ---
`RankingPolicy` (schema) | Signal roster, status, normalisation rules, version semantics | ✅ A3-owned **definition**; storage backing deferred — `LCR-GAP-005`
`RankingVersion` | Immutable algorithm-generation record and its activation window | ✅ A3-owned
`RankingEvaluationRecord` | Minimal reproducibility record | ✅ A3-owned, **content constrained by `LCR-FR-072`**

`LCR-FR-071` | ⏸ These entities are **contingent** on A2's open `LCF-ADR-001` / `LCF-GAP-009` — BC Map §8 (**L370–386**) currently has **no aggregate row for `BC-15` at all**. A3 SHALL NOT add a row to the aggregate registry, and SHALL NOT treat its entities as registered until the Architecture Owner acts. → `LCR-GAP-008`

### 20.1 The evaluation record — privacy-constrained

⚠ **Correction applied (P2-2).** The reviewed draft stored a "viewer context reference" in every evaluation record. Combined with a per-request candidate list, that is a **per-student reading-behaviour log** over a minor-inclusive population, and it contradicted the same draft's claim that sensitive data was not retained.

`LCR-FR-072` | A `RankingEvaluationRecord` SHALL contain **only**:

Field | Rationale
--- | ---
Record identifier | Idempotency and correlation
Community scope identifier | Isolation assertion and debugging
Candidate-set digest | Reproducibility without storing the member list
Result-set digest | Detect ordering drift between versions
Algorithm version | Reproducibility
Configuration version | Reproducibility
Outcome (`RANKED` / `FALLBACK` / `REJECTED`) | Degradation visibility
Timestamp | Ordering of records

`LCR-FR-073` | A `RankingEvaluationRecord` SHALL NOT contain a viewer identifier, a `PersonId`, a `StudentRecordId`, a session reference, a device reference, or any per-student behavioural attribute.

`LCR-INV-010` | It SHALL NOT be possible to reconstruct an individual student's reading history from A3's stored state. This is a structural property of `LCR-FR-072`, not an access-control promise.

`LCR-FR-074` | Retention of evaluation records SHALL be bounded. The bound is a configuration concern — `LCR-GAP-005`.

---

## 21. Ranking Contract

`LCR-FR-075` | A3 SHALL expose a single ranking operation, invoked by A2, with this conceptual shape:

```
RankCommunityFeed
  in  : communityScopeRef        (mandatory)
        candidatePostRefs[]      (bounded, pre-filtered, deduplicated)
        candidateMetadata[]      (createdAt, authorRef, postType — per candidate)
        paginationContext        (opaque, structure not interpreted)
        algorithmVersion?        (optional pin)
  out : orderedPostRefs[]
        algorithmVersion
        configurationVersion
        outcome                  (RANKED | FALLBACK)
```

`LCR-API-001` | The operation SHALL be service-internal. It SHALL NOT be exposed to a student-facing client.

`LCR-API-002` | The operation SHALL require an authenticated internal caller. Authentication alone SHALL NOT be treated as authorisation (`14B` **L231** records the distinction).

`LCR-API-003` | The operation SHALL validate that every candidate carries the community scope in the request, and SHALL fail closed on any mismatch (`LCR-FR-018`, `LCR-FR-019`).

`LCR-API-004` | The operation SHALL be idempotent: repeating a request with identical inputs SHALL return an identical ordering and SHALL NOT create a second evaluation record.

`LCR-API-005` | The operation SHALL be bounded in input size (`LCR-FR-021`) and SHALL time out rather than run unbounded.

`LCR-API-006` | On timeout or internal error, the operation SHALL return the fallback outcome rather than an error, so A2 can always render (`LCR-FR-059`).

`LCR-API-007` | The contract SHALL be versioned. A change to the response shape SHALL be a new contract version.

`LCR-API-008` | The operation SHALL NOT accept a viewer identity attribute beyond what the community authorisation decision already required. It has no personalised signal to apply it to in `RANK-1`.

`LCR-API-009` | Diagnostic output (per-signal values, composite score, ordering rationale) SHALL be available only to internal operators, and SHALL NOT be returned on a student-facing path (`LCR-FR-036`).

`LCR-API-010` | The response SHALL carry post **references only**. A3 SHALL NOT return post content, author profile fields, or attachment detail — A2 `LCF-FR-062`/`063` already constrain what the feed may carry.

---

## 22. Privacy and Security

`LCR-FR-076` | A3 SHALL receive the minimum data required to order: a post reference, a creation timestamp, an author reference, and a post type. Nothing further.

`LCR-FR-077` | A3 SHALL NOT receive or read a `StudentRecordId`, a real name, contact details, or any profile attribute. A2 `LCF-FR-063` already forbids the feed carrying the author's `StudentRecordId`.

`LCR-FR-078` | A3 SHALL NOT log post content, author personal data, or viewer identity.

`LCR-FR-079` | A3 SHALL NOT expose score, signal values, or ordering rationale to a student.

`LCR-INV-011` | A3 makes no authorisation decision. There is no code path in which A3 grants, extends, infers or restores access to a post. Ordering and authorisation are disjoint concerns, and A3 holds only the former.

`LCR-FR-080` | A3 SHALL treat every ranking input as already privacy-filtered, and SHALL NOT attempt to re-derive a privacy decision it is not the owner of.

---

## 23. Community Isolation

⚠ **Correction applied (P1-7).** The reviewed draft titled this "Multi-Tenant Isolation". That vocabulary is unavailable here: `BC-15` sits in the **Global** band and under rule `ID-2` (BC Map **L488**) "must never receive a `StudentRecordId` or `tenantId`", while BC Map **L450** requires `tenantId` on every domain event. A2 recorded this as **Conflicts 5 and 6** and left its tenant field **UNRESOLVED**. A3 inherits that unresolved state and therefore speaks of **community** isolation.

`LCR-INV-002` | Candidates from one community SHALL NEVER appear in the ordering produced for another community. This is the strongest invariant in this part.

`LCR-FR-081` | Community scope SHALL be expressed as the **opaque community scope identifier** A2 defines (`LCF-FR-093`). A3 SHALL NOT introduce a scope key of its own.

`LCR-FR-082` | ⏸ Whether that identifier is, contains, or accompanies a `tenantId` is **UNRESOLVED** and inherited from A2 Conflicts 5 and 6. A3 SHALL NOT resolve it and SHALL NOT assume either answer. → `LCR-GAP-009`

`LCR-FR-083` | Community scope SHALL be present in every ranking request, every evaluation record, and every cache key A3 uses.

`LCR-FR-084` | A3 SHALL NOT construct a cache, index or projection spanning more than one community.

`LCR-FR-085` | A3 SHALL NOT produce cross-community aggregates, comparisons or rankings.

`LCR-FR-086` | A3 SHALL fail closed on a missing or ambiguous community scope. It SHALL NOT default, guess, or widen (`LCR-FR-018`).

---

## 24. Performance Objectives

⚠ **Correction applied (P1-5).** The reviewed draft presented `100 ms` / `150 ms` / `20 ms` / `250 ms` as targets. A2 explicitly **refused** to mint latency numbers: `LCF-NFR-003` is blocked by `LCF-GAP-010`, "This part mints no latency or throughput budget." `CONFIGURATION_GUIDE.md` **L863** records that adding a parameter is a PRD amendment. A3 therefore states objectives, not thresholds.

`LCR-NFR-001` | ⚠ **NON-BINDING.** Ranking a bounded candidate set SHOULD complete well within the feed request's own budget. No numeric threshold is ratified here.

`LCR-NFR-002` | ⚠ **NON-BINDING.** Configuration resolution SHOULD be negligible relative to ranking, which is why `LCR-NFR-004` requires caching.

`LCR-NFR-003` | ⏸ **DEFERRED.** Binding latency and throughput budgets are a Product Owner + Architecture Owner concern, consistent with A2's `LCF-GAP-010`. → `LCR-GAP-010`

`LCR-NFR-004` | Active ranking configuration and immutable version records SHOULD be cached. Caches SHALL be community-scoped where they hold anything community-specific (`LCR-FR-084`).

`LCR-NFR-005` | A3 SHALL NOT cache a per-viewer ranked feed. A membership change, an enforcement action or a deletion can invalidate an ordering at any moment, and a stale personalised cache is a correctness and privacy hazard.

`LCR-NFR-006` | Ranking SHALL be stateless with respect to the viewer, which in `RANK-1` is trivially satisfied — no viewer-specific signal is active.

`LCR-NFR-007` | Ranking SHALL be computable within a single request without a distributed coordination step, a background job, or a model-serving dependency.

---

## 25. Observability

`LCR-FR-087` | A3 SHALL emit operational telemetry for: candidate count received, candidate count discarded by `LCR-FR-016`, ranked count returned, outcome, algorithm version, configuration version, and ranking duration.

`LCR-FR-088` | A3 SHALL emit a distinct, alertable signal when the fallback path is taken (`LCR-FR-062`).

`LCR-FR-089` | A3 SHALL emit a distinct, alertable signal when `LCR-FR-016` discards a candidate, because that indicates an upstream filtering defect.

`LCR-FR-090` | Telemetry SHALL NOT contain post content, author personal data, or viewer identity (`LCR-FR-078`).

`LCR-FR-091` | A3 SHALL emit facts only. Metric definition, aggregation and reporting belong to `BC-26` (BC Map **L135**). A3 SHALL NOT build a metric layer, a projection store, or a report.

---

## 26. Analytics and Evaluation

`LCR-FR-092` | The product question A3 is answerable against is: *does the ordering help a member find useful content sooner than reverse-chronological ordering would?*

`LCR-FR-093` | Evaluation SHALL be possible **offline**: replay a recorded candidate set through a version and compare orderings. `LCR-INV-008` makes this exact.

`LCR-FR-094` | A3 SHALL NOT require an online experimentation platform, traffic splitting, or a holdout population in `RANK-1`.

`LCR-FR-095` | Success SHALL NOT be measured by engagement volume alone. Engagement-maximising objectives are the mechanism by which a study-focused feed degrades into an attention product.

`LCR-FR-096` | ⏸ The community analytics **product** is **V3** — EA **L973**, A2 `LCF-XC-029`. A3 SHALL NOT build it.

---

## 27. Anti-Gaming

`LCR-FR-097` | A3 SHALL consume trusted signals. A3 SHALL NOT build a fraud-detection, reputation, or abuse-detection system — that is `BC-13` (A2 `LCF-XC-028`, EA **L919**).

`LCR-FR-098` | In `RANK-1` the anti-gaming surface is **structurally minimal**: the only active signal is recency, which is derived from an authoritative timestamp A3 does not control. There is no engagement counter to inflate.

`LCR-BR-015` | *Reserved:* when any engagement-derived signal activates, it SHALL be capped (`LCR-BR-010`), SHALL exclude self-engagement, and SHALL be deduplicated per actor. Activation without these constraints SHALL NOT occur.

`LCR-FR-099` | A3 SHALL NOT take an enforcement action, issue a strike, or suppress an author. Those are `BC-13` outcomes reaching `BC-15` by `E-14`.

---

## 28. Edge Cases

Situation | Required behaviour
--- | ---
Post deleted between candidate generation and ranking | Discard; never return (`LCR-FR-016`)
Post enforcement-suppressed mid-request | Discard; never scored (`LCR-FR-024`)
Membership becomes invalid mid-request | Upstream re-authorisation governs; A3 returns only what it was given
Author enforcement in scope | Handled upstream as a hard filter (§10)
Duplicate candidate identifier | Reduce to one (`LCR-FR-020`)
Candidate from another community | **Reject the whole request**, fail closed (`LCR-FR-019`)
Candidate set missing community scope | **Reject**, fail closed (`LCR-FR-018`)
Empty candidate set | Empty ordering, outcome `RANKED`, **not an error** (`LCR-FR-057`)
Single candidate | Return it; diversity and tie-break are no-ops
All candidates identical timestamp | Tie-break resolves totally by identifier (`LCR-FR-055`)
Ranking configuration unresolvable | Fallback (`LCR-FR-059`)
Ranking timeout | Fallback (`LCR-API-006`)
Algorithm version pinned but retired | Fallback; record the outcome
Configuration rollback during traffic | New requests use the newly active version; historical records unchanged (`LCR-FR-068`)
Clock skew within a request | Single request-scoped clock reading (`LCR-FR-041`)
Post created during pagination | A2 owns pagination stability (`LCF-BR-006`); A3 orders what it receives
Post deleted during pagination | A2 owns pagination stability (`LCF-BR-007`)
Repeated identical refresh | Identical ordering (`LCR-INV-008`); no seen-based drift, since seen-tracking is deferred
Concurrent requests, same community | Independent and identical; ranking holds no mutable shared state

---

## 29. Scope

### 29.1 In scope for `RANK-1`

- deterministic, rule-based ordering within an authorised, community-scoped set
- recency signal with bucketed decay
- deterministic diversity by author and post type
- total, stable tie-break
- cold-start behaviour (the only behaviour, in this generation)
- safe reverse-chronological fallback
- algorithm and configuration versioning with rollback
- minimal, privacy-constrained evaluation records
- operational observability and offline replay evaluation
- community isolation with fail-closed scope validation

### 29.2 Explicitly out of scope

- machine learning, neural recommendation, learning-to-rank, reinforcement learning, automated weight tuning
- online experimentation, traffic splitting, holdout populations
- cross-library, cross-community, global or location-based ranking
- personalisation of any kind
- per-viewer impression or behaviour tracking
- authorisation, membership, privacy or moderation decisions
- comment, reaction, help-state, or announcement modelling
- search relevance, indexing, query rewriting
- notification dispatch
- a metric layer, projection store, or analytics product

### 29.3 Deferred, awaiting an owner

Every item in §14, plus §19's configuration-ownership question, §20's aggregate-registration contingency, §23's tenant-identifier question, and §24's binding budgets. All are enumerated in §31.

---

## 30. Acceptance Criteria

⚠ **Correction applied (P2-3).** The reviewed draft used bare `AC-001`…`AC-015`, which would collide with A1's `LCM-AC-*` and A2's `LCF-AC-001`…`036`. Criteria below carry the `LCR-` prefix, which is itself **proposed and unratified** (`LCR-GAP-001`).

ID | Criterion | Status
--- | --- | ---
`LCR-AC-001` | Given a viewer not authorised for a community, when ranking is requested for it, then no candidate from that community is returned | Verifiable
`LCR-AC-002` | Given candidates from two communities in one request, when ranking runs, then the request is **rejected** and nothing is ranked | Verifiable
`LCR-AC-003` | Given a candidate set with no community scope, when ranking runs, then it fails closed | Verifiable
`LCR-AC-004` | Given two candidates in different age buckets, when ranking runs, then the newer receives the higher recency contribution | Verifiable
`LCR-AC-005` | Given an enforcement-suppressed post, when ranking runs, then it is absent from the result and no score is computed for it | Verifiable
`LCR-AC-006` | Given a suppressed post and any configuration, when ranking runs, then no configuration makes it appear | Verifiable
`LCR-AC-007` | Given an identical candidate set, configuration and version, when ranking runs twice, then the orderings are identical | Verifiable
`LCR-AC-008` | Given two candidates with equal score and equal timestamp, when ranking runs, then the tie-break orders them totally and repeatably | Verifiable
`LCR-AC-009` | Given a first page with multiple authors available, when ranking runs, then diversity limits the consecutive run of a single author | Verifiable
`LCR-AC-010` | Given a candidate set with no diversity available, when ranking runs, then pure score order is returned with no gap or error | Verifiable
`LCR-AC-011` | Given A3 unavailable, when the feed is requested, then the feed renders in reverse-chronological order | Verifiable
`LCR-AC-012` | Given A3 unavailable, when the feed renders, then the visible set is identical to the hard-filtered set — never wider | Verifiable
`LCR-AC-013` | Given an empty candidate set, when ranking runs, then an empty ordering is returned and no error is raised | Verifiable
`LCR-AC-014` | Given a previously approved configuration version, when rollback occurs, then it activates and no historical evaluation record changes | Verifiable
`LCR-AC-015` | Given any completed ranking, when the evaluation record is inspected, then it contains no viewer identifier and no per-student behavioural attribute | Verifiable
`LCR-AC-016` | Given a duplicate candidate identifier, when ranking runs, then exactly one occurrence appears in the result | Verifiable
`LCR-AC-017` | Given a deferred signal and any configuration value, when ranking runs, then that signal contributes exactly zero | Verifiable
`LCR-AC-018` | Given a repeated identical request, when ranking runs, then no second evaluation record is created | Verifiable
`LCR-AC-019` | ⏸ Given a help-priority post, … | **DEFERRED** — no substrate (`LCR-GAP-002`)
`LCR-AC-020` | ⏸ Given an already-seen post, … | **DEFERRED** — no substrate (`LCR-GAP-006`)
`LCR-AC-021` | ⏸ Given an active official announcement, … | **DEFERRED** — no substrate (`LCR-GAP-002`)
`LCR-AC-022` | ⏸ Given an engagement-bearing post, … | **DEFERRED** — gated by A2 `LCF-GAP-012` (`LCR-GAP-003`)

`LCR-FR-100` | No criterion above is claimed to pass. **18 verifiable, 4 deferred.**

⚠ Note: A2 `LCF-GAP-011` records that `integration_test/` does not exist in the repository. Criteria requiring end-to-end execution inherit that constraint.

---

## 31. Gap Register

Every gap below is a genuine open question routed to a named owner. **None is decided by this document.**

ID | Gap | Owner | Cited at
--- | --- | --- | ---
`LCR-GAP-001` | The `LCR-` prefix is proposed, not conferred. Ratifying a PRD identifier prefix is a governance act | **Governance Owner** | §0, §30
`LCR-GAP-002` | No `helpState`, no announcement type and no priority field exist. A2 `LCF-FR-027` closes the post-type set; adding to it requires a PRD amendment A3 cannot make | **Product Owner** (with `BC-15`/A2 author) | §11 (`LCR-RS-002`, `LCR-RS-005`), §14.1, §14.4, §30
`LCR-GAP-003` | Helpfulness and engagement signals depend on comments/reactions, whose status in this generation is A2's own open `LCF-GAP-012` | **Product Owner** | §11 (`LCR-RS-003`, `LCR-RS-004`), §14.2, §14.3, §30
`LCR-GAP-004` | Social relevance requires a `BC-15 → BC-11` edge. BC Map **L292**: an edge not in the table does not exist. `ADR-0055` §3 sets the necessity-test precedent | **Architecture Owner** | §11 (`LCR-RS-006`), §14.5
`LCR-GAP-005` | Ranking configuration ownership: `BC-25` values via `E-19`, or an A3-owned store. All numeric parameters (decay buckets, diversity limits, candidate bound, retention) inherit this | **Architecture Owner** (with `BC-25` owner) | §9, §13, §15, §19, §20.1
`LCR-GAP-006` | Per-viewer impression tracking would create a new personal-data store over a minor-inclusive population (`SM-INV-3`; BC-10 **L376**) | **Privacy Owner + Product Owner** | §11 (`LCR-RS-007`), §14.6, §30
`LCR-GAP-007` | No consumable non-enforcement content-quality contract is published by `BC-13` | **`BC-13` owner** | §11 (`LCR-RS-008`), §14.7
`LCR-GAP-008` | BC Map §8 (**L370–386**) has no aggregate row for `BC-15`, so A3's ranking entities cannot be registered. Inherited from A2 `LCF-GAP-009` / `LCF-ADR-001` | **Architecture Owner** | §20
`LCR-GAP-009` | Whether the community scope identifier carries a `tenantId` is unresolved. Inherited from A2 Conflicts 5 and 6 (BC Map **L450** vs **L488**) | **Architecture Owner** | §23
`LCR-GAP-010` | No binding latency or throughput budget. Consistent with A2 `LCF-GAP-010` | **Product Owner + Architecture Owner** | §24

---

## 32. Decision Requirements

A3 mints **no ADR number** and creates **no ADR**. `ADR-INDEX.md` is not amended. The items below are decision *requirements*, recorded so an owner can act.

ID | Decision required | Owner | Blocks
--- | --- | --- | ---
`LCR-DEC-001` | Does a help/resolution state exist in this generation, and who owns it? | Product Owner | `LCR-RS-002`, 1 AC
`LCR-DEC-002` | Resolve A2 `LCF-GAP-012` — do comments/reactions exist in this generation? | Product Owner | `LCR-RS-003`, `LCR-RS-004`, 1 AC
`LCR-DEC-003` | Is per-viewer impression tracking permissible for this population? | Privacy Owner + Product Owner | `LCR-RS-007`, 1 AC
`LCR-DEC-004` | Admit a `BC-15 → BC-11` edge under an `ADR-0055`-style necessity test? | Architecture Owner | `LCR-RS-006`
`LCR-DEC-005` | Where do ranking configuration values live — `BC-25` via `E-19`, or A3? | Architecture Owner | every numeric parameter
`LCR-DEC-006` | Does an official announcement surface exist, and does it extend A2's closed type set? | Product Owner | `LCR-RS-005`, 1 AC
`LCR-DEC-007` | Register `BC-15`'s aggregates in BC Map §8 (inherited from A2 `LCF-ADR-001`) | Architecture Owner | §20 registration

`LCR-FR-101` | A3 SHALL NOT proceed to implementation of any deferred signal before its blocking decision is recorded by its named owner.

---

## 33. Risks and Mitigations

ID | Risk | Severity | Mitigation
--- | --- | --- | ---
`LCR-RSK-001` | `RANK-1` is perceived as delivering little, since only recency is active | Medium | §11 states the position openly. Diversity, tie-break determinism and safe fallback are real additions over A2 `LCF-FR-075`
`LCR-RSK-002` | A deferred signal is activated informally, bypassing its owner | **High** | `LCR-FR-029`, `LCR-FR-101`; every signal names its blocking gap
`LCR-RSK-003` | Enforcement is reintroduced as a soft penalty by a later editor | **High** | `LCR-FR-025`, `LCR-INV-006`; §10 records why the soft path was removed
`LCR-RSK-004` | A cache is built spanning communities | **High** | `LCR-FR-084`, `LCR-NFR-005`, `LCR-INV-002`
`LCR-RSK-005` | Impression tracking is added quietly as a ranking tweak | **High** | `LCR-FR-047`, `LCR-GAP-006` names the privacy owner
`LCR-RSK-006` | A3 builds a configuration store that later conflicts with `BC-25` | Medium | `LCR-FR-065` forbids creating one until `LCR-DEC-005` lands
`LCR-RSK-007` | Numeric parameters harden into de facto standards | Medium | Every number is configuration-supplied and flagged as a proposal
`LCR-RSK-008` | `LCR-GAP-008` is refused, leaving entities unregistered | Medium | Inherited from A2; A3 adds no registry row unilaterally
`LCR-RSK-009` | Engagement-maximising metrics drive later tuning | Medium | `LCR-FR-095` states the anti-goal explicitly
`LCR-RSK-010` | Fallback masks a persistent ranking outage | Medium | `LCR-FR-062`, `LCR-FR-088` make fallback alertable
`LCR-RSK-011` | The `LCR-` prefix is never ratified, orphaning every identifier | Medium | `LCR-GAP-001` routes it to the Governance Owner

---

## 34. Implementation Checklist

- [ ] Confirm A1's authorisation contract shape
- [ ] Confirm A2's candidate-generation contract, including the metadata A3 requires (§21)
- [ ] Confirm A2's hard-filter guarantee covers enforcement suppression (`LCF-FR-060`)
- [ ] Implement community-scope validation with fail-closed behaviour
- [ ] Implement bucketed recency
- [ ] Implement the composite scorer over active signals only
- [ ] Implement deterministic diversity
- [ ] Implement the total tie-break
- [ ] Implement the fallback path and make it observable
- [ ] Implement algorithm/configuration versioning and rollback
- [ ] Implement the privacy-constrained evaluation record (§20.1)
- [ ] Assert no viewer identifier reaches stored state
- [ ] Assert no cross-community cache key is constructible
- [ ] Add reproducibility tests (`LCR-INV-008`)
- [ ] Add offline replay harness
- [ ] Run the acceptance criteria in §30 (18 verifiable)
- [ ] Confirm every deferred signal contributes zero (`LCR-AC-017`)
- [ ] Route all §32 decisions to their named owners

---

## 35. Architecture Consistency Audit

Check | Result
--- | ---
Does it create a bounded context? | ✅ No
Does it add an integration edge? | ✅ No — `LCR-GAP-004` routes the only candidate
Does it add an event, permission or role? | ✅ No
Does it add an aggregate registry row? | ✅ No — `LCR-FR-071` refuses; `LCR-GAP-008` routes it
Does it amend a `FROZEN` PRD? | ✅ No
Does it amend an `ACCEPTED` ADR? | ✅ No
Does it modify A1 or A2? | ✅ No
Does it mint an ADR number? | ✅ No — §32 records requirements only
Does it duplicate A1's authorisation ownership? | ✅ No — `LCR-FR-001`, `LCR-INV-011`
Does it duplicate A2's content or feed ownership? | ✅ No — `LCR-FR-070`, `LCR-XC-002`, `LCR-XC-003`
Does it duplicate `BC-13` moderation? | ✅ No — `LCR-XC-005`, `LCR-FR-099`
Does it duplicate `BC-11` relationships? | ✅ No — `LCR-XC-007`, `LCR-FR-046`
Does it duplicate `BC-10` identity? | ✅ No — `LCR-XC-008`, `LCR-FR-077`
Does it duplicate `BC-22` notifications? | ✅ No — `LCR-XC-009`
Does it duplicate `BC-25` configuration? | ✅ No — `LCR-FR-065` refuses to build one; `LCR-GAP-005` routes it
Does it duplicate `BC-26` analytics? | ✅ No — `LCR-FR-091`, `LCR-FR-096`
Does it duplicate `BC-23` search relevance? | ✅ No — `LCR-XC-004`; separate index class per `AR-3`
Does it reference non-existent parts A4–A8 as owners? | ✅ No — removed (P0-5)
Does it claim a V1 release slot? | ✅ No — V2 capability, `RANK-1` algorithm (P0-1)
Can ranking bypass authorisation? | ✅ No — `LCR-INV-004`, `LCR-INV-011`
Can enforcement be softened into a score? | ✅ No — `LCR-FR-025`, `LCR-INV-006` (P1-3)
Can one community leak into another? | ✅ No — `LCR-INV-002`, fail-closed
Does it introduce ML/AI? | ✅ No — `LCR-XC-012`
Is ordering deterministic and reproducible? | ✅ Yes — `LCR-INV-008`
Is fallback authorisation-safe? | ✅ Yes — `LCR-INV-009`
Does it store per-student behavioural data? | ✅ No — `LCR-FR-073`, `LCR-INV-010` (P2-2)
Does it fabricate an unavailable signal? | ✅ No — `LCR-FR-002`, `LCR-FR-028`
Does it resolve a conflict it does not own? | ✅ No — 10 gaps and 7 decisions routed to named owners

---

## 36. Register State

Counts are the measured contents of this document.

Register | Count | Range | Notes
--- | --- | --- | ---
`LCR-FR-*` | 101 | `001`–`101` | Dense
`LCR-BR-*` | 15 | `001`–`015` | Dense; `009`–`012`, `015` are reserved-on-activation
`LCR-INV-*` | 11 | `001`–`011` | Dense
`LCR-RS-*` | 9 | `001`–`009` | 1 active · 7 deferred · 1 withdrawn
`LCR-XC-*` | 16 | `001`–`016` | Dense
`LCR-API-*` | 10 | `001`–`010` | Dense
`LCR-NFR-*` | 7 | `001`–`007` | 2 non-binding · 1 deferred
`LCR-AC-*` | 22 | `001`–`022` | **18 verifiable · 4 deferred**
`LCR-GAP-*` | 10 | `001`–`010` | Dense; all routed to named owners
`LCR-DEC-*` | 7 | `001`–`007` | Requirements only; **no ADR created**
`LCR-RSK-*` | 11 | `001`–`011` | Dense

**Total: 219 identifiers across 11 registers.**

Every one is **PROPOSED and UNRATIFIED**. The `LCR-` prefix itself is unratified (`LCR-GAP-001`).

---

*End of PRD-021A Part A3 v0.1 (DRAFT). Correction pass applied. 10 gaps and 7 decision requirements remain open and are routed, not resolved.*
