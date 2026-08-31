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
         -> RESOLVED at v0.3 by explicit Product Owner decision (SHIP).
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
Status        : DRAFT — v0.6.
Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
Readiness     : NOT READY. Blockers remain open (section 31, section 32).
Lifecycle     : No stage advanced. No acceptance criterion is claimed to pass.
Capability    : V2 — inherited from BC-15 by repository authority (see section 7).
Algorithm     : RANK-1, the first generation of the ranking algorithm.
Predecessors  : A1 v0.2 (Community Foundation), A2 v0.8 (Community Feed & Content)
Supersedes    : A3 v0.5. v0.1, v0.2, v0.3, v0.4 and v0.5 retained on disk and in
                history; none is deleted, edited nor overwritten. This is
                deliberate and load-bearing: ACCEPTED ADR-0082 L422 records the
                sha256 of A3 v0.5 (6fb17cb1b8ba3a6c...) as a hash anchor, and
                L424 records that A3 is "deliberately NOT EDITED". Authoring v0.6
                as a NEW FILE keeps that anchor byte-true and leaves every
                existing citation to v0.5 resolving. v0.6 falsifies nothing in
                ADR-0082 and requires no amendment to it.
Identifiers   : The LCR- prefix is REGISTERED to PRD-021A A3 by ACCEPTED
                ADR-0080 section 5 (L196); LCR-GAP-001 is CLOSED. Individual
                LCR-* identifiers in this document remain PROPOSED and
                UNRATIFIED - the prefix is conferred, the requirements it labels
                are not.
This revision : Finding S-1 remediation only (see section 0.5). The four
                remaining statements that the LCR- prefix is "proposed, not
                conferred" are reconciled with ADR-0080 section 5 L196, which
                REGISTERED it. ⭐ NO weight is changed. NO identifier is minted.
                NO decision is taken. LCR-DEC-009 remains REFUSED and
                LCR-RS-003 remains at weight 0.
Release gate  : STILL BLOCKED. PRD-020 must ship first
                (PRODUCT_IMPLEMENTATION_ROADMAP L161-164). Resolving ranking
                blockers does not touch that gate.
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

✅ **The `LCR-` prefix used below is REGISTERED**, not merely proposed. `ACCEPTED` `ADR-0080` §5 (**L196**) registered `LCR-` to `PRD-021A` A3 — and `LCF-` to A2 at **L195** — in the same act that constituted the **Governance Owner** role this gap had been routed to. `LCR-GAP-001` is therefore ✅ **CLOSED** (§31).

⛔ **The distinction that survives, and matters.** Registering the *prefix* does not ratify the *identifiers*. Every `LCR-*` identifier below remains **PROPOSED and UNRATIFIED**: the namespace is conferred, the requirements it labels are not. ⚠ *Corrected at v0.6 (finding `S-1`):* v0.5 recorded the closure at §0.4 and §31 but left this paragraph, §30, §33 (`LCR-RSK-011`) and §36 still asserting the prefix was unconferred — the same document said both. The registered reading is the correct one; the four stale statements are reconciled at v0.6 and **no identifier status is changed by doing so**.

---

### 0.1 Revision note — v0.2 Stage-3 architecture-alignment integration

v0.2 differs from v0.1 in exactly three respects. **No new product, architecture, privacy or scope decision is taken, and no ADR, BC, edge, aggregate, event, permission or storage is created.**

| # | Change | Nature |
|---|---|---|
| 1 | **D5 configuration ownership CLOSED.** `LCR-GAP-005` and `LCR-DEC-005` **RETIRED**; §19 re-based on FROZEN `PRD-023` (`CNF-FR-052`, `CNF-XC-001`, `CNF-FR-030`) and `ADR-0017` §3.1 item 6 | **Conformance** to an already-frozen decision — not a new one |
| 2 | **Finding F-1 recorded** (§37.1): A2 normatively consumes `BC-11` with no registered `BC-15 → BC-11` edge | **Escalation only.** No edge minted, no shape chosen |
| 3 | **Finding F-2 recorded** (§37.2): EA's Community (V2) block does not enumerate comments/reactions; the only EA `Comments` entry is V3 under Notes Sharing | **Escalation only.** No version decided, no A2/EA amendment |

**Unchanged in v0.2:** all 14 v0.1 correction-pass fixes; D1 (help state) deferred; D2 deferred; D3 (impressions) deferred on the `SM-4.5b` + `AP-3` fail-safe; D4 (edge) deferred; the pipeline order; the ML/AI exclusion; every other register entry.

### 0.2 Revision note — v0.3 D2-P scope-resolution integration

**Upstream authority.** An explicit **Product Owner** scope decision resolved A2's
`LCF-GAP-012`: **Community Comments and Community Reactions are IN SCOPE and SHALL SHIP** in
this generation. Recorded in `PRD-021A_LCF-GAP-012_DECISION_RECORD.md`; A2 amended to **v0.5**,
where `LCF-XC-017` is narrowed to threads/mentions and the comment/reaction specification is
preserved in full. v0.3 integrates that decision and **takes no decision of its own**.

| # | Change | Nature |
|---|---|---|
| 1 | **`LCR-DEC-002` RESOLVED** — comments/reactions ship. Retained in the register, not retired | Integration of an upstream PO decision |
| 2 | **`LCR-RS-004` Legitimate engagement → 🟡 ELIGIBLE.** Its substrate is now authoritative: A2 v0.5 `LCF-FR-061` publishes **"comment count, reaction summary"** per post in the feed response, and `LCF-FR-084` defines the summary as an aggregate count per kind | Substrate became real; **no weight assigned** |
| 3 | **`LCR-RS-003` Helpfulness stays ⏸ DEFERRED** on a **narrower, measured** gap | Honest non-activation |
| 4 | **`LCR-GAP-003` NARROWED** — no longer "do comments/reactions exist" (answered) but "which reaction kind denotes helpfulness", gated by A2's new `LCF-GAP-014` | Scope reduction |

⭐ **Why `LCR-RS-004` is ELIGIBLE and not ACTIVE.** `LCR-FR-033` requires active weights to sum
to exactly `100`, and `LCR-FR-034` states that **"weights are assigned when a signal activates,
by whoever owns its activation."** Activating a second signal therefore requires a **numeric
weight split**, which is a Product Owner **value** decision. The decision received was about
**scope**, not values. Publishing a number here would invent a product decision, so `ELIGIBLE`
records that the *substrate* barrier is gone while the *value* barrier remains. **The active
set is unchanged: `LCR-RS-001` Recency = 100.**

⭐ **Why `LCR-RS-003` cannot activate even under SHIP.** Helpfulness requires distinguishing a
*helpful* reaction from any other kind. A2 `LCF-BR-010` requires the reaction kind set to "be
defined in this part's data model (§22)", but §22 declares only `Closed set` and **never
enumerates a member** — unlike `LCF-FR-027`, which enumerates the post-type set exactly. A2
v0.5 records this as new gap **`LCF-GAP-014`** (Product Owner). Until a kind set exists, no kind
can denote helpfulness. Inferring one would breach `LCR-FR-044`.

**Unchanged in v0.3:** every v0.1 correction and every v0.2 Stage-3 integration; D1 (help
state), D3 (impressions), D4 (edge) deferred; the pipeline order; the ML/AI exclusion; the
active weight table; **no** ADR, BC, edge, aggregate, event, permission or storage created; A1,
A2 v0.3/v0.4, A3 v0.1/v0.2 and every frozen artefact untouched. **Status remains NOT READY.**

---

### 0.3 Revision note — v0.4 owner-ruling integration

**Upstream authority.** Four explicit rulings were received and recorded in
`PRD-021A_LCF-GAP-012_DECISION_RECORD.md` **v2.0 section 7**, with the architectural halves
carried by `ACCEPTED` ADRs. v0.4 **integrates** them and **takes no decision of its own**.

| # | Ruling received | Recorded at | Effect in this document |
|---|---|---|---|
| 1 | Reaction kind set = `LIKE`, `HELPFUL`, `CELEBRATE` | DR v2.0 section 7.2; A2 **v0.6** `LCF-BR-010a`, section 22 | A2 `LCF-GAP-014` RESOLVED, so the substrate `LCR-RS-003` needed now exists |
| 2 | `HELPFUL` **is** the helpfulness signal | DR v2.0 section 7.3 | `LCR-GAP-003` **RESOLVED**; `LCR-RS-003` is designated on a named kind |
| 3 | Recency = **70**, Legitimate engagement = **30**, total **100** | DR v2.0 section 7.4 | `LCR-DEC-008` **RESOLVED**; `LCR-RS-004` moves ELIGIBLE → **ACTIVE**; section 12.1 renormalised under `LCR-FR-035` |
| 4 | Community scope identifier carries **no** `tenantId` | `ADR-0078` (`Accepted`) | `LCR-GAP-009` **RESOLVED** by an Architecture Owner ruling, not by this document |

⭐ **Why `LCR-RS-003` becomes ELIGIBLE and not ACTIVE.** Two distinct barriers stood in front of
helpfulness: a **substrate** barrier (no reaction kind meant "helpful") and a **weight** barrier
(`LCR-FR-034` reserves weight values to the activation owner). Ruling 2 removes the substrate
barrier completely — `HELPFUL` is a named, closed-set member of A2 v0.6's kind set, so
`LCR-FR-044`'s prohibition on proxy inference is satisfied by an **explicit** indication. Ruling
3 assigns weights to **two** signals only: recency and legitimate engagement. **No weight was
assigned to helpfulness.** Under `LCR-FR-028a` an eligible signal contributes exactly zero and
*"no implementation SHALL infer a default weight"*, so `LCR-RS-003` is recorded **ELIGIBLE at
weight 0**. Inventing a third weight — or silently re-splitting the 70/30 the owner supplied —
would be precisely the value decision this document is not entitled to take.

⭐ **Why the active set is exactly 100 and no more.** `LCR-FR-033` requires active weights to sum
to exactly `100`. The active set after v0.4 is `LCR-RS-001` = **70** and `LCR-RS-004` = **30**,
which sums to **100** with no residue and no rounding. `LCR-FR-035`'s renormalisation obligation
is discharged **by the ruling itself**: the owner supplied a complete, already-normalised split
rather than a single number requiring A3 to re-derive the remainder.

⚠ **What v0.4 does NOT do.** It does not advance a lifecycle stage, does not claim any
acceptance criterion passes, and does **not** declare readiness. Section 37.2 records that
`LCR-FND-013` is now **BLOCKED rather than open** — the version question was determined, but the
Enterprise Architecture edit that would record it is blocked by `ADR-0075` section 8. Five gaps
and four decision requirements remain open. **Status remains NOT READY — NOT FROZEN.**

⭐ **Superseded at v0.5 as to `LCR-FND-013` only.** The Enterprise Architecture edit is no longer
blocked: it was **performed** by `ACCEPTED` **`ADR-0079`**, which executed `ADR-0075` section 8.5
**Option A** (append-only). `LCR-FND-013` is therefore **CLOSED** at v0.5 — see section 0.4 and
section 37.2. Everything else in the paragraph above still holds, and the **status is unchanged:
NOT READY — NOT FROZEN.**

---

### 0.4 Revision note — v0.5 governance-and-architecture integration

**Upstream authority.** Three `ACCEPTED` ADRs were issued by their competent owners and are
**integrated** here. v0.5 **takes no decision of its own**, amends no other artefact, changes no
weight, and mints no identifier.

| # | Act received | Recorded at | Effect in this document |
|---|---|---|---|
| 1 | The EA community enumeration was **EXECUTED**, by append-only section | `ADR-0079` (`Accepted`); EA **v2.3** section 12 | **`LCR-FND-013` CLOSED** — section 37.2. Its own stated precondition, *"SHALL NOT be recorded as closed while the EA remains unamended"*, is now satisfied |
| 2 | The **Governance Owner** role is **constituted** by derivation | `ADR-0080` (`Accepted`); `PRD_OWNERSHIP_MODEL.md` **v1.3** section 10 | **`LCR-GAP-001` CLOSED** — the `LCR-` prefix is **REGISTERED to `PRD-021A` A3**; section 31 |
| 3 | `LCR-DEC-009` is **REFUSED as undecidable** | `ADR-0081` (`Accepted`) section 2 | `LCR-DEC-009` recorded ⛔ **REFUSED and still OPEN** — section 32. ⭐ **No weight assigned** |

⭐ **Why `LCR-FND-013` closes now and could not close at v0.4.** The v0.4 blocker was stated
precisely, and that precision is what unblocked it: the risk was **inserting** two nodes into the
EA `Community (V2)` capability tree at **L972**, which measurement showed would silently
invalidate **240** line-citations across **39** files, **three FROZEN**. `ADR-0079` did not accept
that risk and did not seek an exemption — it took the path `ADR-0075` section 8.5 had already
pre-authorised as **Option A** and **appended** the enumeration as a new EA **section 12**, below
**L2404**, the highest EA line cited anywhere in the repository. Post-execution measurement:
**482** citations re-resolved, **0** invalidated, **0** cited-line contents changed, **EA L967–973
byte-identical**, **0** frozen files touched. The determination the ruling made is now written
where the EA can be read to say it.

⛔ **Why `LCR-DEC-009` does NOT close, in the same pass that closed three other items.** Because
no authority anywhere assigns a helpfulness weight. `ADR-0081` section 2 probed six sources and
all six returned nothing: no `Accepted` ADR; the Decision Record, which states at **L303–304**
that section 7.3 *"does **not** assign a weight"*; the Owner Decision Request, which states at
**L365** that it proposes *"no value of any kind"*; no Rank 1–5 document; and `LCR-FR-028a`, which
forbids inferring a default. Two of the three conceivable resolutions are **prohibited** —
publishing a number invents a product decision, and carving one out of the ruled `70`/`30`
overwrites a decision the Product Owner **did** make. So `LCR-DEC-009` is **refused, not
resolved**, and it stays in the open count. ⭐ **`LCR-RS-003` therefore remains `ELIGIBLE` at
weight exactly `0`, and the active set remains `LCR-RS-001` = 70 plus `LCR-RS-004` = 30 = exactly
`100`.** Section 12.1 is **byte-unchanged**.

⭐ **Why closing `LCR-GAP-001` is a genuine closure and not self-authorisation.** `ADR-0080` does
not *invent* a Governance Owner. `PRD_LIFECYCLE.md` §6 **L282** already assigns the role
*"Stage 7; the baseline"*, and three `ACCEPTED` ADRs — `ADR-0053` **L8**, `ADR-0054` **L8**,
`ADR-0064` **L7** — have already **exercised** it by naming it as `Deciders`. The authority
pre-existed the document; what was missing was the written definition. Registering the `LCR-`
prefix is a Stage 7 act, so with the role constituted the act has an author. The role is recorded
**VACANT**, with **no personal name** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4).

**Unchanged in v0.5:** every v0.1 correction, every v0.2 Stage-3 integration, the v0.3 scope
resolution and all four v0.4 owner rulings; **section 12.1's weight table byte-for-byte**;
`LCR-RS-002`, `005`, `006`, `007`, `008` DEFERRED; `LCR-RS-003` ELIGIBLE at 0; `LCR-RS-009`
WITHDRAWN; the pipeline order; the ML/AI exclusion; **no** BC, edge, event, permission, aggregate
row, configurable or storage created; **no** ADR minted by this document; A1, A2 and every frozen
artefact untouched.

⚠ **What v0.5 does NOT resolve.** **6 gaps** (`LCR-GAP-002`, `004`, `006`, `007`, `008`, `010`) and
**6 decision requirements** (`LCR-DEC-001`, `003`, `004`, `006`, `007`, and the refused `009`)
remain **open**. `ADR-0075` **Option B** — the 281 bare EA line-citations — remains open. BC Map
§7 (edges) and §8 (aggregates) are **structured registers**, so the append-only technique that
worked for the EA **does not apply** to them; `LCR-GAP-004` and `LCR-GAP-008` are therefore still
**routed, not performed**.

⛔ **Status remains NOT READY — NOT FROZEN.** Independently of every item above, `PRD-021` **must
not ship before `PRD-020`** (`PRODUCT_IMPLEMENTATION_ROADMAP` **L161–164**), and `PRD-020` is
still `DRAFT`. Closing three items is progress; it is not readiness.

---

### 0.5 Revision note — v0.6 finding `S-1` remediation (`LCR-` prefix consistency)

v0.6 differs from v0.5 in **exactly one respect**: the four remaining statements that the `LCR-`
prefix is *"proposed, not conferred"* are reconciled with the closure v0.5 itself recorded.
**No product, architecture, privacy, scope or governance decision is taken. No ADR, BC, edge,
aggregate, event, permission, storage, requirement or identifier is created, removed, merged,
split or renumbered. No weight is changed.**

**Source of truth:** `PRD-021A_ITEM_DISPOSITION_REASSESSMENT.md` §5.1, finding `S-1`.

⭐ **The defect, precisely.** v0.5 closed `LCR-GAP-001` on the authority of `ACCEPTED` `ADR-0080`
§5 **L196**, which **REGISTERED** the `LCR-` prefix to `PRD-021A` A3, and recorded that closure at
§0.4 and in the §31 register row. But four *other* passages — written at v0.1 and never revisited —
continued to assert the opposite. The same document therefore said both that the prefix **was**
registered and that it was **never conferred**. That is a self-contradiction about a *governance
fact*, and the registered reading is the correct one because it rests on an `ACCEPTED` ADR.

| # | Site | v0.5 text (stale) | v0.6 |
|---|---|---|---|
| 1 | §0 prefix note | *"proposed, not conferred … ratified nowhere"* | ✅ **REGISTERED** by `ADR-0080` §5 **L196**; `LCR-GAP-001` **CLOSED** |
| 2 | §30 preamble | *"itself **proposed and unratified**"* | ✅ **REGISTERED**; criteria themselves still unratified and none claimed to pass |
| 3 | §33 `LCR-RSK-011` | *"The `LCR-` prefix is never ratified, orphaning every identifier"* | ⛔ **RETIRED** — precondition ceased to exist; original text retained inline, **position kept** |
| 4 | §36 closing line | *"The `LCR-` prefix itself is unratified"* | ✅ **REGISTERED**; the **237** identifiers it labels remain unratified |

⭐ **The distinction v0.6 preserves at every one of the four sites.** Registering a *namespace* is
not ratifying its *contents*. The prefix is conferred; the **237 live identifiers across 12
registers** it labels remain **PROPOSED and UNRATIFIED**, and not one acceptance criterion is
claimed to pass (`LCR-FR-100`). Collapsing that distinction would have converted a prefix
registration into a bulk ratification of 237 requirements — which `ADR-0080` §5 does not do and
this document has no authority to do.

⛔ **`LCR-RSK-011` is RETIRED, not deleted.** Its position is retained and it is still counted, per
`PRD-023` `CNF-FR-008` (a retired identifier SHALL NOT be reused) and `PRD_LIFECYCLE.md` §5 rule 5.
Register counts in §36 are therefore **unchanged at 237 / 12**. This mirrors A2 v0.8's treatment of
`LCF-RSK-014`, the identical risk in the `LCF-` namespace.

**Unchanged in v0.6:** every v0.1 correction; every v0.2 Stage-3 integration; the v0.3 scope
resolution; all four v0.4 owner rulings; every v0.5 integration; **§12.1's weight table
byte-for-byte**; the pipeline order; the ML/AI exclusion; the hard-filter treatment of enforcement;
and A1, A2 v0.7 and every frozen artefact untouched.

⚠ **What v0.6 explicitly does NOT do.**

- **`LCR-DEC-009` remains `REFUSED`** and the helpfulness weight remains **unassigned**.
  `LCR-RS-003` stays **ELIGIBLE at weight 0**; the active set is unchanged at `LCR-RS-001` = **70**
  and `LCR-RS-004` = **30**, summing to exactly **100** (`LCR-FR-033`). Assigning a weight is a
  Product Owner act and `ADR-0081` ruled the question **undecidable on present evidence**.
- **`LCR-FND-001` is not closed.** A2's consumption of `BC-11` with no registered `BC-15 → BC-11`
  edge is still an open architectural finding. ⭐ A2 **v0.8** gives its three consuming requirements
  a **self-blocking** form and raises the edge as `LCF-ADR-007`; that makes the consumption
  lawful-as-written, but it does **not** register the edge, which needs **two** Architecture Owner
  acts. A3 mints nothing here and takes no position on the shape of that edge.
- **6 gaps** (`LCR-GAP-002`, `004`, `006`, `007`, `008`, `010`) and **6 decision requirements**
  (`LCR-DEC-001`, `003`, `004`, `006`, `007`, and the refused `009`) remain **open**.
- `ADR-0075` **Option B** — the bare EA line-citations — remains open. `ADR-0082` is **not amended**.
- **No lifecycle stage is advanced or conferred.**

⛔ **Status remains NOT READY — NOT FROZEN.** Independently of every item above, `PRD-021` **must
not ship before `PRD-020`** (`PRODUCT_IMPLEMENTATION_ROADMAP` **L161–164**), and `PRD-020` is still
`DRAFT`. Removing a self-contradiction improves *integrity*; it confers no *readiness*.

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
Comments and reactions | **`BC-15`**, specified by A2 | A2 v0.5 L241–242, L1065, L1076 | ✅ **IN SCOPE** — `LCF-GAP-012` RESOLVED (PO decision). A3 consumes published aggregates only; it owns neither aggregate
Enforcement, moderation, anti-spam | **`BC-13`** | BC Map **L379**, **L318** (`E-14`) | Consumed as a **hard filter** (§10)
Notifications | **`BC-22`** | BC Map **L131**, `E-23` | Untouched by A3
Identity / profile / privacy mode | **`BC-10`** | BC Map **L376** | Untouched by A3
Social relationships | **`BC-11`** | BC Map **L377** | ⏸ No edge exists — `LCR-GAP-004`
Configuration values | **`BC-25`** | BC Map **L134**, `E-19`; `PRD-023` `CNF-FR-030` | ✅ **Settled** — A3 declares, `BC-25` resolves (§19)
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

`LCR-FR-022` | The candidate bound SHALL be supplied by configuration, declared in A3's own configurable register per `CNF-FR-052` (§19). Its **value** is a Product Owner input, not an ownership question — `LCF-GAP-006`.

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
`LCR-RS-003` | **Helpfulness** | 🟡 **ELIGIBLE at v0.4 — substrate authoritative and designated, weight not assigned** | ✅ **Substrate barrier removed.** A2 **v0.6** enumerates the closed reaction kind set as exactly `LIKE`, `HELPFUL`, `CELEBRATE` (`LCF-BR-010a`, section 22), resolving `LCF-GAP-014`; and an explicit ruling designates **`HELPFUL`** as the helpfulness indication (DR v2.0 section 7.3), resolving `LCR-GAP-003`. `HELPFUL` is an **explicit** member-supplied indication, so reading it satisfies `LCR-FR-044` rather than breaching it. ⛔ **Weight barrier remains:** the weight ruling covered recency and engagement only; none was assigned here, and `LCR-FR-028a` forbids inferring one. Contributes exactly **0**
`LCR-RS-004` | **Legitimate engagement** | ✅ **ACTIVE at v0.4 — weight 30** | ✅ Substrate exists and is published: A2 **`LCF-FR-061`** carries "comment count, reaction summary" per post in the feed response; **`LCF-FR-084`** defines the summary as an aggregate count per kind; `LCF-EVT-005`/`006` emit the changes. ✅ **Weight assigned by explicit ruling: 30** (DR v2.0 section 7.4), completing the activation `LCR-FR-034` reserved to the activation owner. `LCR-DEC-008` RESOLVED. Binding on activation: `LCR-BR-010` (cap, self-exclusion, per-actor dedup) and `LCR-BR-010a` (aggregate-only)
`LCR-RS-005` | **Official announcement priority** | ⏸ **DEFERRED** | No announcement post type and no priority field. A2's type set is closed (`LCF-FR-027`); A2 `LCF-FR-002` notes announcements have "no durable home" but does not create one. → `LCR-GAP-002`
`LCR-RS-006` | **Social relevance** | ⏸ **DEFERRED** | No `BC-15 → BC-11` integration edge exists. BC Map **L292**: "If an edge is not in this table, **it does not exist**." → `LCR-GAP-004`
`LCR-RS-007` | **Already-seen suppression** | ⏸ **DEFERRED** | Requires per-viewer impression records. None exist in A2 or any BC. Creating them is a personal-data decision affecting a minor-inclusive population (`SM-INV-3`; BC-10 **L376** "privacy default = most restrictive"). → `LCR-GAP-006`
`LCR-RS-008` | **Content-quality penalty** | ⏸ **DEFERRED** | Any non-enforcement quality score would come from `BC-13` anti-spam (A2 `LCF-XC-028`, EA **L919**). No contract is published. Enforcement outcomes are excluded by `LCR-FR-025`. → `LCR-GAP-007`
`LCR-RS-009` | ~~Community relevance~~ | ⛔ **WITHDRAWN** | **P2-1 correction.** Every candidate is already community-scoped and cross-community candidates are rejected at step 5, so this signal is **constant across the candidate set** and mathematically cannot affect ordering. It is withdrawn rather than carried as inert weight.

`LCR-FR-028` | A `DEFERRED` signal SHALL contribute exactly zero to the composite score. Its weight SHALL be recorded as **reserved and not in effect**.

`LCR-FR-028a` | An `ELIGIBLE` signal — one whose substrate is authoritative but whose weight has not been assigned by its activation owner — SHALL likewise contribute exactly zero until a weight is assigned under `LCR-FR-034` and the active set is renormalised under `LCR-FR-035`. `ELIGIBLE` SHALL NOT be treated as active, and no implementation SHALL infer a default weight.

`LCR-FR-029` | A `DEFERRED` signal SHALL NOT be activated by configuration alone. Activation requires the substrate to exist and its owner to publish a contract.

`LCR-FR-030` | A `WITHDRAWN` signal SHALL NOT be reintroduced without a stated, varying definition.

**Consequence, stated plainly.** With one active signal, `RANK-1` orders by recency inside a hard-filtered, community-scoped set, then applies diversity and a stable tie-break. That is a **modest but honest** improvement over A2 `LCF-FR-075`: the diversity pass and the deterministic tie-break are real, testable behaviour that A2 does not provide. It is not a rich ranking model, and this part does not pretend otherwise.

---

## 12. Scoring Model

⚠ **Correction applied (P1-4).** The reviewed draft carried **two** mutually inconsistent weight tables, and its arithmetic did not reach the "0–100" it claimed (positives summed to 95). This part publishes **one** table, separates active from reserved, and states the arithmetic exactly.

### 12.1 The single weight table

Signal | Status | Weight | In effect?
--- | --- | --- | ---
`LCR-RS-001` Recency | ✅ ACTIVE | **70** | ✅ Yes
`LCR-RS-002` Unresolved help | DEFERRED | *reserved* | ⛔ No — 0
`LCR-RS-003` Helpfulness | 🟡 ELIGIBLE | *not assigned* | ⛔ No — 0 (`LCR-FR-028a`; designated on `HELPFUL`, no weight ruled)
`LCR-RS-004` Legitimate engagement | ✅ ACTIVE | **30** | ✅ Yes
`LCR-RS-005` Official priority | DEFERRED | *reserved* | ⛔ No — 0
`LCR-RS-006` Social relevance | DEFERRED | *reserved* | ⛔ No — 0
`LCR-RS-007` Already-seen | DEFERRED | *reserved* | ⛔ No — 0
`LCR-RS-008` Content quality | DEFERRED | *reserved* | ⛔ No — 0

⭐ **Active weight arithmetic at v0.4 — `70 + 30 = 100` exactly.** Two signals are active and
their weights sum to exactly `100` with no residue, no rounding and no implicit remainder, as
`LCR-FR-033` requires. Both values were supplied together by an explicit owner ruling (DR v2.0
section 7.4), so `LCR-FR-035`'s renormalisation obligation is discharged by the ruling rather
than re-derived here. Six signals contribute exactly zero: five `DEFERRED` under `LCR-FR-028`
and one `ELIGIBLE` under `LCR-FR-028a`. ⚠ **`LCR-RS-003` Helpfulness is deliberately absent from
the active set** despite having an authoritative, designated substrate — because no weight was
ruled for it. Its future activation SHALL renormalise the whole active set under `LCR-FR-035`;
it SHALL NOT be granted a share carved silently out of the 70 or the 30.

`LCR-FR-031` | The composite score SHALL be the weighted sum of **active** signals only, normalised to the range `0`–`100`.

`LCR-FR-032` | Each signal SHALL be normalised to `0.0`–`1.0` before its weight is applied.

`LCR-FR-033` | The active weights SHALL sum to exactly `100`. At v0.4 two signals are active — recency at `70` and legitimate engagement at `30` — and `70 + 30 = 100`. The split is a **received owner ruling** (DR v2.0 section 7.4), not a design preference of this document, and the count of active signals remains a **consequence** of the availability register.

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

`LCR-FR-039` | Bucket boundaries and values SHALL be configuration-supplied, declared in A3's own configurable register per `CNF-FR-052` (§19). The values above are the **initial proposal**, not a ratified parameter set.

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

### 14.2 Helpfulness — ELIGIBLE at v0.4 (designated, unweighted)

Reserved intent: prefer content other members found genuinely useful over content that merely attracted attention.

✅ **Substrate authoritative and designated.** Two things changed. First, A2 **v0.6** enumerates
the reaction kind set as exactly `LIKE`, `HELPFUL`, `CELEBRATE` (`LCF-BR-010a`, A2 section 22),
which closes A2's `LCF-GAP-014` — the kind set is now *defined* where `LCF-BR-010` always
required it to be defined. Second, an explicit ruling designates **`HELPFUL`** as the
helpfulness indication (DR v2.0 section 7.3), which closes **`LCR-GAP-003`**. A3 therefore
neither selects nor names a kind: it **reads a designation it was given**.

⭐ **This satisfies `LCR-FR-044` rather than straining it.** `LCR-FR-044` forbids inferring
helpfulness from any *proxy* — reaction volume, comment volume, any aggregate count — and
requires an **explicit** helpful indication. A `HELPFUL` reaction is exactly that: a member
deliberately choosing the kind that means helpful. Counting `HELPFUL` is not a proxy for
helpfulness; it *is* the indication. Counting `LIKE` or `CELEBRATE` would be a proxy, and
`LCR-BR-010b` below forbids it.

⛔ **Not ACTIVE: no weight was ruled.** The weight ruling (DR v2.0 section 7.4) assigned values
to recency and legitimate engagement only. `LCR-FR-034` reserves weight values to the activation
owner and `LCR-FR-028a` states that an eligible signal contributes exactly zero and that *"no
implementation SHALL infer a default weight"*. Helpfulness is therefore **ELIGIBLE at weight 0**
until a weight is ruled and the active set is renormalised under `LCR-FR-035`.

`LCR-FR-044` | A3 SHALL NOT infer helpfulness from any proxy — including reaction volume, comment volume or any aggregate count. A helpful signal requires an **explicit** helpful indication. ✅ **Satisfied at v0.4** by the `HELPFUL` designation; `LCR-GAP-003` RESOLVED.

`LCR-BR-010b` | *Reserved, binding on activation:* helpfulness SHALL be derived **only** from the aggregate count of `HELPFUL` reactions published under A2 `LCF-FR-084`. It SHALL NOT read `LIKE` or `CELEBRATE`, SHALL NOT enumerate reacting members, and SHALL NOT combine kinds into a single undifferentiated total.

### 14.3 Legitimate engagement — ACTIVE at v0.4 (weight 30)

Reserved intent: a small, capped contribution from validated community activity.

✅ **ACTIVE at weight 30.** After the D2-P decision the engagement surface became real and,
critically, **already published in the shape A3 needs**; the weight ruling then completed the
activation:

| A2 v0.5 authority | What it provides |
|---|---|
| **`LCF-FR-061`** | The feed response carries, per post, "… edit marker, **comment count, reaction summary**" |
| **`LCF-FR-084`** | The reaction summary is an **aggregate count per kind**, and SHALL NOT enumerate reacting members (`LCF-SEC-011`) |
| **`LCF-EVT-005` / `LCF-EVT-006`** | `community.CommentPublished` and `community.ReactionChanged` carry the changes |

A3 therefore needs **no** new field, store, edge or event to compute this signal: it reads
counts A2 already publishes. ✅ **`LCR-DEC-008` is RESOLVED** — the activation owner assigned
**30**, with recency at **70**, summing to exactly `100` (DR v2.0 section 7.4). The signal is
**ACTIVE**, and `LCR-BR-010` and `LCR-BR-010a` below are therefore **no longer reserved: they
are binding now**.

⭐ **Privacy note — no new exposure.** `LCF-FR-084` guarantees aggregate counts only, so
consuming them creates no per-member behavioural record and does not disturb `LCR-FR-073` or
`LCR-INV-010`. This is precisely why engagement is available while already-seen suppression
(`LCR-RS-007`) is not: the latter would require **new** per-viewer data (`LCR-GAP-006`).

`LCR-BR-010` | ✅ **BINDING at v0.4** (no longer reserved): engagement SHALL be capped such that it can never independently determine ordering, SHALL exclude self-engagement, and SHALL be deduplicated per actor. ⭐ The cap is satisfied structurally by the ruled weights — at `30` against recency's `70`, engagement cannot outrank recency on its own, so the cap is a **consequence of the ruling** and not merely an instruction to implementers.

`LCR-BR-010a` | ✅ **BINDING at v0.4** (no longer reserved): engagement SHALL be derived **only** from the aggregate counts A2 publishes (`LCF-FR-061`, `LCF-FR-084`). A3 SHALL NOT enumerate reacting or commenting members, and SHALL NOT retain any per-actor engagement record. ⚠ Activation creates **no** new personal-data store, so it does **not** touch `LCR-GAP-006`, which remains open for `LCR-RS-007`.

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

`LCR-FR-051` | The numeric limits for `LCR-BR-013` and `LCR-BR-014` SHALL be configuration-supplied, declared in A3's own configurable register per `CNF-FR-052` (§19). No value is minted here.

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

✅ **Stage-3 integration — D5 CLOSED by existing frozen authority (was `LCR-GAP-005` / `LCR-DEC-005`).** v0.1 routed configuration ownership to the Architecture Owner as an open decision. Stage-3 measurement showed that routing was **mis-directed**: `PRD-023` is **FROZEN** (conferred 2026-08-20 by `ACCEPTED` `ADR-0053`, Rank 3) and already settles it:

- **`CNF-FR-052`** — "A flag **SHALL** be declared by the PRD that owns the behaviour it gates, in that PRD's own configurable register. This module **SHALL NOT** originate a flag."
- **`CNF-XC-001`** — `BC-25` "**MUST NOT** define, change, re-range, re-default, rename, retire or reclassify" any parameter. "*Owner: each register's PRD.*"
- **`CNF-FR-030`** — `BC-25` serves a parameter "only where an owning PRD has declared it"; a value present in storage but absent from the register "**SHALL NOT** be served" and is a **defect**.
- **`ADR-0017` §3.1 item 6** — "the `LCFG-1`…`LCFG-13` definitions stay in the Library PRD; `PRD-023` owns the resolution machinery, **not the value list**."

`PRD-023` §3.6 records this split executed **104 times across 8 FROZEN owning PRDs**. No new decision is taken here; A3 conforms to a decision already frozen.

⚠ **Supersedes correction `P1-1` of the v0.1 pass.** `P1-1` correctly removed the reviewed draft's stored `RankingConfiguration` entity — **that removal stands and is unchanged** (`LCR-FR-065`). What `P1-1` additionally did was **defer** the A3-schema / `BC-25`-value split to the Architecture Owner as `D-5`. Stage-3 measurement shows that deferral was unnecessary, because the authorities quoted above had already frozen the split before this part was written. `P1-1`'s *prohibition* is therefore retained and strengthened into a standing one; only its *deferral* is retired. **No configuration store is created here, and none was created by `P1-1` either.**

`LCR-FR-063` | A3 SHALL own the **schema and semantics** of ranking policy: which signals exist, their status, how they normalise, and how versions supersede.

`LCR-FR-064` | A3 SHALL **declare** every ranking parameter it requires in its own configurable register, per `CNF-FR-052`. `BC-25` SHALL **resolve and serve** those values through `E-19` and SHALL NOT originate, re-range or re-default any of them (`CNF-XC-001`). A parameter absent from A3's register SHALL NOT be served (`CNF-FR-030`).

`LCR-FR-065` | A3 SHALL NOT create a configuration store, and SHALL read every value through a `BC-25` typed accessor on `E-19` — "no raw string lookups in domain code" (BC Map **L328**). This is a standing prohibition, not a temporary one.

`LCR-FR-065a` | Populating A3's configurable register requires the `LCR-` prefix conferral (`LCR-GAP-001`) and Product Owner input for each **value**. Those are open; the **ownership question is not**.

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
`RankingPolicy` (schema) | Signal roster, status, normalisation rules, version semantics | ✅ A3-owned **definition**; parameter **values** resolved by `BC-25` via `E-19` (§19)
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

`LCR-FR-074` | Retention of evaluation records SHALL be bounded. The bound SHALL be declared in A3's own configurable register and resolved by `BC-25` via `E-19` (§19).

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

⚠ **Correction applied (P2-3).** The reviewed draft used bare `AC-001`…`AC-015`, which would collide with A1's `LCM-AC-*` and A2's `LCF-AC-001`…`036`. Criteria below carry the `LCR-` prefix, which is ✅ **REGISTERED** to `PRD-021A` A3 by `ACCEPTED` `ADR-0080` §5 (**L196**); `LCR-GAP-001` is **CLOSED**. ⚠ *Corrected at v0.6 (`S-1`)* — this note previously read *"proposed and unratified"*, which the closure recorded at §0.4 had already superseded. ⛔ The criteria themselves remain **UNRATIFIED and none is claimed to pass** (`LCR-FR-100`): a registered prefix confers no verification result.

ID | Criterion | Status
--- | --- | ---
`LCR-AC-001` | Given a viewer not authorised for a community, when ranking is requested for it, then no candidate from that community is returned (`LCR-INV-004`, `LCR-FR-014`) | Verifiable
`LCR-AC-002` | Given candidates from two communities in one request, when ranking runs, then the request is **rejected** and nothing is ranked (`LCR-FR-019`, `LCR-INV-002`) | Verifiable
`LCR-AC-003` | Given a candidate set with no community scope, when ranking runs, then it fails closed (`LCR-FR-018`, `LCR-FR-086`) | Verifiable
`LCR-AC-004` | Given two candidates in different age buckets, when ranking runs, then the newer receives the higher recency contribution (`LCR-FR-038`, `LCR-FR-041`) | Verifiable
`LCR-AC-005` | Given an enforcement-suppressed post, when ranking runs, then it is absent from the result and no score is computed for it (`LCR-FR-024`) | Verifiable
`LCR-AC-006` | Given a suppressed post and any configuration, when ranking runs, then no configuration makes it appear (`LCR-INV-006`) | Verifiable
`LCR-AC-007` | Given an identical candidate set, configuration and version, when ranking runs twice, then the orderings are identical (`LCR-INV-008`, `LCR-FR-007`) | Verifiable
`LCR-AC-008` | Given two candidates with equal score and equal timestamp, when ranking runs, then the tie-break orders them totally and repeatably (`LCR-FR-054`, `LCR-FR-055`) | Verifiable
`LCR-AC-009` | Given a first page with multiple authors available, when ranking runs, then diversity limits the consecutive run of a single author (`LCR-BR-013`, `LCR-FR-049`) | Verifiable
`LCR-AC-010` | Given a candidate set with no diversity available, when ranking runs, then pure score order is returned with no gap or error (`LCR-FR-052`) | Verifiable
`LCR-AC-011` | Given A3 unavailable, when the feed is requested, then the feed renders in reverse-chronological order (`LCR-FR-059`, `LCR-FR-060`) | Verifiable
`LCR-AC-012` | Given A3 unavailable, when the feed renders, then the visible set is identical to the hard-filtered set — never wider (`LCR-INV-009`) | Verifiable
`LCR-AC-013` | Given an empty candidate set, when ranking runs, then an empty ordering is returned and no error is raised (`LCR-FR-057`) | Verifiable
`LCR-AC-014` | Given a previously approved configuration version, when rollback occurs, then it activates and no historical evaluation record changes (`LCR-FR-068`) | Verifiable
`LCR-AC-015` | Given any completed ranking, when the evaluation record is inspected, then it contains no viewer identifier and no per-student behavioural attribute (`LCR-FR-073`) | Verifiable
`LCR-AC-016` | Given a duplicate candidate identifier, when ranking runs, then exactly one occurrence appears in the result (`LCR-FR-020`) | Verifiable
`LCR-AC-017` | Given a deferred signal and any configuration value, when ranking runs, then that signal contributes exactly zero (`LCR-FR-028`, `LCR-FR-029`) | Verifiable
`LCR-AC-018` | Given a repeated identical request, when ranking runs, then no second evaluation record is created (`LCR-API-004`) | Verifiable
`LCR-AC-019` | ⏸ Given a help-priority post, … (`LCR-FR-043`, `LCR-FR-002`) | **DEFERRED** — no substrate (`LCR-GAP-002`)
`LCR-AC-020` | ⏸ Given an already-seen post, … (`LCR-FR-047`, `LCR-FR-002`) | **DEFERRED** — no substrate (`LCR-GAP-006`)
`LCR-AC-021` | ⏸ Given an active official announcement, … (`LCR-FR-045`, `LCR-FR-002`) | **DEFERRED** — no substrate (`LCR-GAP-002`)
`LCR-AC-022` | ✅ Given two posts of equal recency where one carries a higher aggregate engagement count, the higher-engagement post SHALL rank first; and given a post whose only engagement is self-engagement, that engagement SHALL contribute zero (`LCR-BR-010a`, `LCR-FR-033`) | **VERIFIABLE at v0.4** — substrate authoritative (A2 `LCF-FR-061`/`084`) and weight ruled at `30` (`LCR-DEC-008` RESOLVED). Bounded by `LCR-BR-010`/`010a`

`LCR-FR-100` | No criterion above is claimed to pass. **19 verifiable, 3 deferred.** ⭐ v0.4 moves exactly one criterion (`LCR-AC-022`) from deferred to verifiable, because its weight was ruled. ⚠ Helpfulness has **no** acceptance criterion at v0.4: its substrate is designated but unweighted, and writing a criterion for an unweighted signal would assert an ordering effect that `LCR-FR-028a` guarantees is zero.

⚠ Note: A2 `LCF-GAP-011` records that `integration_test/` does not exist in the repository. Criteria requiring end-to-end execution inherit that constraint.

---

## 31. Gap Register

Every gap below is a genuine open question routed to a named owner. **None is decided by this document.**

ID | Gap | Owner | Cited at
--- | --- | --- | ---
`LCR-GAP-001` | ✅ **CLOSED at v0.5 by `ACCEPTED` `ADR-0080`.** The gap was never *"which prefix"* — it was *"the role that ratifies a prefix is not constituted"*. `ADR-0080` constitutes the **Governance Owner** by **derivation from rules that already existed** (`PRD_LIFECYCLE.md` §6 **L282** assigns it *"Stage 7; the baseline"*, and `ADR-0053`, `ADR-0054` and `ADR-0064` have each already **named it as `Deciders`**), then exercises it: measured against every registered prefix, **`LCR-` collides with none**, so it is **REGISTERED to `PRD-021A` A3** under `PRD_LIFECYCLE.md` §5 rule 3. ⛔ Registration settles **only** the prefix. It creates no requirement, closes no other gap, and confers **no readiness** — a registered prefix on a draft is still a draft | **Governance Owner** — ✅ decided | §0, §30
`LCR-GAP-002` | No `helpState`, no announcement type and no priority field exist. A2 `LCF-FR-027` closes the post-type set; adding to it requires a PRD amendment A3 cannot make | **Product Owner** (with `BC-15`/A2 author) | §11 (`LCR-RS-002`, `LCR-RS-005`), §14.1, §14.4, §30
`LCR-GAP-003` | ✅ **RESOLVED at v0.4.** Both halves are closed. The existence half was answered at v0.3 (comments/reactions ship). The **kind** half is answered by two received rulings: A2 **v0.6** enumerates the closed set as exactly `LIKE`, `HELPFUL`, `CELEBRATE` (`LCF-BR-010a`, closing A2 `LCF-GAP-014`), and **`HELPFUL`** is designated as the helpfulness indication (DR v2.0 section 7.3). ⚠ Resolution of this gap makes `LCR-RS-003` **ELIGIBLE, not ACTIVE** — the *substrate* barrier is gone, the *weight* barrier is not, and no weight was ruled for helpfulness | **Product Owner** — ✅ decided | section 11 (`LCR-RS-003`), section 14.2, section 30
`LCR-GAP-004` | Social relevance requires a `BC-15 → BC-11` edge. BC Map **L292**: an edge not in the table does not exist. `ADR-0055` §3 sets the necessity-test precedent | **Architecture Owner** | §11 (`LCR-RS-006`), §14.5
~~`LCR-GAP-005`~~ | ⛔ **RETIRED at v0.2 — not a gap.** Configuration ownership is settled by FROZEN `PRD-023` (`CNF-FR-052`, `CNF-XC-001`, `CNF-FR-030`) and `ADR-0017` §3.1 item 6. v0.1 mis-routed it. Per `PRD-023` `CNF-FR-008` a retired identifier SHALL NOT be reused | — (closed) | §19
`LCR-GAP-006` | Per-viewer impression tracking would create a new personal-data store over a minor-inclusive population (`SM-INV-3`; BC-10 **L376**) | **Privacy Owner + Product Owner** | §11 (`LCR-RS-007`), §14.6, §30
`LCR-GAP-007` | No consumable non-enforcement content-quality contract is published by `BC-13` | **`BC-13` owner** | §11 (`LCR-RS-008`), §14.7
`LCR-GAP-008` | BC Map §8 (**L370–386**) has no aggregate row for `BC-15`, so A3's ranking entities cannot be registered. Inherited from A2 `LCF-GAP-009` / `LCF-ADR-001` | **Architecture Owner** | §20
`LCR-GAP-009` | ✅ **RESOLVED at v0.4 by `ADR-0078` (`Accepted`).** The community scope identifier carries **no** `tenantId`. Determined, not chosen: BC Map **L487** declares `BC-10` Global with no `tenantId`, **L488** enforces it via `banned_symbols`, **L422–428** already publish five `identity.*` events from that Global context, and `ID-3` (**L180**) makes tenant-scoped identifiers in a Global context an affirmative prohibition. The apparent Rank 4 conflict with **L450** was resolved by measurement rather than by ranking one Rank 4 rule above another; `ADR-0078` section 4.2 discloses L450's wording as a separate Rank 4 clarity defect and routes it. ⚠ The BC Map is **byte-unchanged** | **Architecture Owner** — ✅ decided | section 23
`LCR-GAP-010` | No binding latency or throughput budget. Consistent with A2 `LCF-GAP-010` | **Product Owner + Architecture Owner** | §24

---

## 32. Decision Requirements

A3 mints **no ADR number** and creates **no ADR**. `ADR-INDEX.md` is not amended. The items below are decision *requirements*, recorded so an owner can act.

ID | Decision required | Owner | Blocks
--- | --- | --- | ---
`LCR-DEC-001` | Does a help/resolution state exist in this generation, and who owns it? | Product Owner | `LCR-RS-002`, 1 AC
`LCR-DEC-002` | Resolve A2 `LCF-GAP-012` — do comments/reactions exist in this generation? | Product Owner | ✅ **RESOLVED — SHIP.** Explicit PO scope decision; recorded in `PRD-021A_LCF-GAP-012_DECISION_RECORD.md`; A2 v0.5 narrowed `LCF-XC-017`. Retained here, not retired — a resolved decision keeps its position (`PRD-023` `CNF-FR-008`)
`LCR-DEC-003` | Is per-viewer impression tracking permissible for this population? | Privacy Owner + Product Owner | `LCR-RS-007`, 1 AC
`LCR-DEC-004` | Admit a `BC-15 → BC-11` edge under an `ADR-0055`-style necessity test? | Architecture Owner | `LCR-RS-006`
~~`LCR-DEC-005`~~ | ⛔ **RETIRED at v0.2** — answered by FROZEN `PRD-023` before this part was written. No decision is required | — (closed) | —
`LCR-DEC-006` | ✅ **RESOLVED — 2026-08-31 by Product Owner ruling PO-7, in three parts.** **(1)** An official communication surface **DOES exist**. **(2)** It **is Part A5** (`PRD-021A_A5_OFFICIAL_LIBRARY_COMMUNICATION`) — not a new part, not a standalone PRD, and not a seventh A2 event type. **(3)** ⛔ **It does NOT extend A2's closed type set.** A2's six-event contract (`community.PostPublished`, `PostEdited`, `PostDeleted`, `PostRemoved`, `CommentPublished`, `ReactionChanged`) **remains authoritative unless A2 is separately amended**, and A5 may publish through its own mechanism without touching it. ⭐ **This is the answer that lets `LCR-RS-005` stop waiting on a question about a document that already existed** — A5 was drafted, but nothing had ruled whether it *was* the surface this signal presupposed. ⚠ **`LCR-RS-005`'s own activation is NOT granted by this**: PO-7 settles *where* official communication lives, not what weight the signal carries, and no weight was invented. *(Prior text retained verbatim: Does an official announcement surface exist, and does it extend A2's closed type set? | Product Owner | `LCR-RS-005`, 1 AC)* | **Product Owner** — ✅ decided | `LCR-RS-005`, 1 AC
`LCR-DEC-007` | Register `BC-15`'s aggregates in BC Map §8 (inherited from A2 `LCF-ADR-001`) | Architecture Owner | §20 registration
`LCR-DEC-008` | ✅ **RESOLVED at v0.4.** The activation owner assigned **Recency = 70** and **Legitimate engagement = 30**, total exactly **100** (DR v2.0 section 7.4). `LCR-RS-004` is now **ACTIVE**, `LCR-AC-022` is **verifiable**, and `LCR-BR-010`/`010a` are **binding**. Retained here, not retired — resolution is not retirement (`PRD-023` `CNF-FR-008`). ⚠ The ruling covered **two** signals; it assigned **no** weight to `LCR-RS-003` helpfulness, which therefore stays ELIGIBLE at 0 | **Product Owner** — ✅ decided | `LCR-RS-004` activation, `LCR-AC-022`

`LCR-DEC-009` | ✅ **CLOSED — 2026-08-31 by PERMANENT DEFERRAL, and ZERO values were invented.** Product Owner ruling **PO-2**: `LCR-RS-003` Helpfulness **stays `ELIGIBLE` at weight `0`**, permanently; the active set stays **Recency = 70**, **Legitimate Engagement = 30**, **Helpfulness = 0**, summing to exactly **100** under `LCR-FR-035`. ⭐⭐ **This closes the item WITHOUT answering the question it asked, and that distinction is the whole ruling.** The question was *"what weight should Helpfulness carry?"*; the answer is *"none, deliberately, and the item is closed rather than left open pending one."* A **deliberate zero** is a decision; a **guessed non-zero** would have been an invention. ⭐ **`ADR-0081`'s REFUSAL is NOT overturned — it is discharged.** That ADR refused this item as *undecidable* after six determinability probes returned nothing, correctly, because the only two moves available to it were to invent a value or to overwrite the `70`/`30` split the Product Owner had ruled. It lacked the authority to choose deferral; the Product Owner has it. **The refusal was right when it was made and is now spent, not wrong.** ⛔ **The `70`/`30` split is BYTE-UNCHANGED** — `LCR-FR-035` (**L616**) and §12.1 are not touched, so no renormalisation occurs and `LCR-RS-004`/`LCR-AC-022`/`LCR-BR-010` are undisturbed. ⛔ **A3 did NOT carve this weight out of the ruled split**, exactly as the prior text required. ⚠ **`LCR-RS-003` is NOT retired and NOT deleted.** It remains a registered, `ELIGIBLE` signal with an authoritative and designated substrate (`HELPFUL`); its weight is `0`. Reviving it would need a fresh Product Owner ruling and a renormalisation, not merely an edit here. ⚠ **Resolution is not retirement** (`PRD-023` `CNF-FR-008`), so this row is retained rather than removed. *(Prior text retained verbatim: ⛔ **OPEN at v0.5 — formally REFUSED as undecidable, and expressly NOT resolved** (`ACCEPTED` `ADR-0081` section 2). Assign a weight for `LCR-RS-003` Helpfulness and renormalise the active set to exactly `100` under `LCR-FR-035`. Its substrate is authoritative **and designated** (`HELPFUL`), so unlike every other deferred signal there is no remaining substrate barrier — only a value. A3 SHALL NOT carve this weight out of the ruled `70`/`30` split.)* | **Product Owner** — ✅ decided by permanent deferral | `LCR-RS-003` stays ELIGIBLE at `0`

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
`LCR-RSK-006` | A3 builds a configuration store that later conflicts with `BC-25` | Medium | `LCR-FR-065` forbids one outright; `CNF-XC-001` / `E-19` are the binding authority
`LCR-RSK-007` | Numeric parameters harden into de facto standards | Medium | Every number is configuration-supplied and flagged as a proposal
`LCR-RSK-008` | `LCR-GAP-008` is refused, leaving entities unregistered | Medium | Inherited from A2; A3 adds no registry row unilaterally
`LCR-RSK-009` | Engagement-maximising metrics drive later tuning | Medium | `LCR-FR-095` states the anti-goal explicitly
`LCR-RSK-010` | Fallback masks a persistent ranking outage | Medium | `LCR-FR-062`, `LCR-FR-088` make fallback alertable
`LCR-RSK-011` | ⛔ **RETIRED at v0.6 — the risk did not materialise.** *(Original text, retained: "The `LCR-` prefix is never ratified, orphaning every identifier.")* The precondition has ceased to exist: the prefix **was** ratified — `ACCEPTED` `ADR-0080` §5 **L196** REGISTERED `LCR-` to `PRD-021A` A3. A registered prefix cannot be orphaned by the non-occurrence of its own registration. **Position retained, never renumbered** (`PRD-023` `CNF-FR-008`); the row is still counted | ~~Medium~~ — **not applicable** | ~~`LCR-GAP-001` routes it to the Governance Owner~~ — **discharged** by `ADR-0080`; `LCR-GAP-001` ✅ CLOSED

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
Does it duplicate `BC-25` configuration? | ✅ No — `LCR-FR-065` forbids a store; `CNF-FR-052` / `CNF-XC-001` govern (§19)
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
Does it resolve a conflict it does not own? | ✅ No — 9 gaps and 9 decision requirements. **Five** are now **resolved**, every one by its named owner upstream: `LCR-DEC-002` and `LCR-DEC-008` by the **Product Owner**, `LCR-GAP-003` by the **Product Owner**, `LCR-GAP-009` by the **Architecture Owner** via `ACCEPTED` `ADR-0078`, and at v0.5 `LCR-GAP-001` by the **Governance Owner** via `ACCEPTED` `ADR-0080`. This document records rulings; it issues none
Does it invent a weight for a newly available signal? | ✅ No — every active weight was **received**, not derived: `LCR-RS-001` = 70 and `LCR-RS-004` = 30 come from the ruling at DR v2.0 section 7.4
Do the active weights sum to exactly 100? | ✅ Yes — `70 + 30 = 100`, no residue, no rounding (`LCR-FR-033`, section 12.1)
Does it weight a designated-but-unruled signal? | ✅ No — `LCR-RS-003` is designated on `HELPFUL` yet carries **weight 0** as `ELIGIBLE`, because no weight was ruled (`LCR-FR-028a`); the outstanding value is routed as `LCR-DEC-009`, which at v0.5 is **REFUSED as undecidable and remains OPEN** (`ADR-0081` section 2). ⭐ v0.5 changed **no** weight: the active set is still `70 + 30 = 100` and `LCR-RS-003` is still exactly **0**
Does it claim the EA enumeration was performed? | ✅ **Yes at v0.5 — and it truly was, by someone else.** `ACCEPTED` **`ADR-0079`** executed `ADR-0075` section 8.5 **Option A**: the EA is now **v2.3**, and its new **section 12** enumerates **Community Comments (V2)** and **Community Reactions (V2)** owned by `BC-15`. A3 neither performed nor authorised that act — it was an **Architecture Owner** act under EA §10.5 — and A3 amends the EA nowhere. `LCR-FND-013` is **CLOSED** in section 37.2 on that authority. ⚠ `ADR-0075` is **not** superseded and **not** restatused; its Option B (retiring bare line-number citation) remains open
Does it advance a lifecycle stage or claim readiness? | ✅ No — **NOT READY, NOT FROZEN.** The `PRD-020` release gate (`PRODUCT_IMPLEMENTATION_ROADMAP` **L161–164**) is untouched by ranking work

---

## 36. Register State

Counts are the measured contents of this document. **A RETIRED identifier is excluded from its register's `Count` while its position is preserved in `Range`** — the counting rule frozen `PRD-023` applies at its **L539**, where `TEN-CFG-*` is carried at **`0`** with the note "`TEN-CFG-001` retired". Two identifier rows therefore exist in this document that no `Count` below includes: the struck-through `LCR-GAP-005` and `LCR-DEC-005` records in §31 and §32, retained so the positions cannot be reused (`PRD-023` `CNF-FR-008`).

Register | Count | Range | Notes
--- | --- | --- | ---
`LCR-FR-*` | 103 | `001`–`101` | Dense, plus `065a` (Stage-3) and `028a` (v0.3 — `ELIGIBLE` contributes zero)
`LCR-BR-*` | **17** | `001`–`015`, `010a`, `010b` | Dense, plus `010a` (v0.3 — aggregate-only engagement) and `010b` (**v0.4** — helpfulness reads `HELPFUL` only). ⭐ `010` and `010a` are **BINDING at v0.4**, no longer reserved, because `LCR-RS-004` activated; `009`, `011`, `012`, `015` and the new `010b` remain reserved-on-activation
`LCR-INV-*` | 11 | `001`–`011` | Dense
`LCR-RS-*` | 9 | `001`–`009` | **2 active (`001` = 70, `004` = 30)** · **1 eligible (`003`, designated on `HELPFUL`, weight 0)** · 5 deferred · 1 withdrawn
`LCR-XC-*` | 16 | `001`–`016` | Dense
`LCR-API-*` | 10 | `001`–`010` | Dense
`LCR-NFR-*` | 7 | `001`–`007` | 2 non-binding · 1 deferred
`LCR-AC-*` | 22 | `001`–`022` | **19 verifiable · 3 deferred** — `022` became verifiable at v0.4 when its weight was ruled
`LCR-GAP-*` | 9 | `001`–`010` | `005` **RETIRED** at v0.2 (not a gap). Of the 9 counted: **3 RESOLVED** — `003` by Product Owner ruling and `009` by `ACCEPTED` `ADR-0078` (both v0.4), plus **`001` at v0.5** by `ACCEPTED` `ADR-0080` — and **6 remain open** (`002`, `004`, `006`, `007`, `008`, `010`), each routed to a named owner. ⭐ v0.5 mints **no** new gap
`LCR-DEC-*` | **8** | `001`–`009` | `005` **RETIRED** at v0.2. Of the 8 counted: **2 RESOLVED** (`002` at v0.3, `008` at v0.4 — both retained, not retired) and **6 remain open** (`001`, `003`, `004`, `006`, `007`, `009`). `009` was new at v0.4 and is **REFUSED as undecidable at v0.5** (`ADR-0081` section 2) — ⚠ **refused is not resolved**, so it stays inside the open count. Requirements only; **A3 creates no ADR and mints no ADR number**
`LCR-RSK-*` | 11 | `001`–`011` | Dense
`LCR-FND-*` | 13 | `001`–`013` | §37 findings referred upstream — **not requirements, not decisions**; `013` records F-2's post-decision status, ✅ **CLOSED at v0.5** by `ACCEPTED` `ADR-0079`

**Total: 237 live identifiers across 12 registers** — 224 requirement-class identifiers across 11 registers, plus 13 `LCR-FND-*` findings (section 37), which are observations referred upstream and carry no normative force. **239 identifier rows are physically present**; the two-row difference is exactly the retired `LCR-GAP-005` and `LCR-DEC-005`, excluded from `Count` per the rule stated above.

v0.3 added exactly **four** identifiers — `LCR-FR-028a`, `LCR-BR-010a`, `LCR-DEC-008` and (in section 37.2) `LCR-FND-013`. **v0.4 adds exactly two** — `LCR-BR-010b` (helpfulness reads `HELPFUL` only) and `LCR-DEC-009` (the outstanding helpfulness weight) — **and removes none**. ⭐ **v0.5 adds ZERO identifiers and removes zero.** It changes the *status* of three existing ones (`LCR-GAP-001` → CLOSED, `LCR-DEC-009` → REFUSED-and-still-open, `LCR-FND-013` → CLOSED) and changes **no** count in the table above. Total remains **237 live identifiers across 12 registers**. ⭐ v0.4 mints **no** new `LCR-GAP-*`: every gap it touches was **closed**, and the one residual value question is a *decision requirement*, not a gap. `LCR-DEC-002`, `LCR-DEC-008`, `LCR-GAP-003` and `LCR-GAP-009` are **RESOLVED but retained**: resolution is not retirement, so each keeps its position and stays inside `Count`.

Two v0.1 identifiers (`LCR-GAP-005`, `LCR-DEC-005`) are **RETIRED**, not renumbered — per `PRD-023` `CNF-FR-008` a retired identifier SHALL NOT be reused, so the `GAP` and `DEC` ranges remain `001`–`010` and `001`–`007` with one position closed in each. Retired identifiers are excluded from every count above.

Every one is **PROPOSED and UNRATIFIED**. ✅ The `LCR-` **prefix** itself is **REGISTERED** to `PRD-021A` A3 by `ACCEPTED` `ADR-0080` §5 (**L196**); `LCR-GAP-001` is **CLOSED**. ⚠ *Corrected at v0.6 (`S-1`)* — this line previously read *"the `LCR-` prefix itself is unratified"*, contradicting the closure this document already recorded at §0.4 and §31. ⛔ The prefix being conferred does **not** confer the identifiers it labels: the count is unchanged at **237 live identifiers across 12 registers**, and every one of them is still unratified.

---

## 37. Stage-3 Findings Referred Upstream

These are **findings**, not decisions. Each was produced by measurement during Stage-3 architecture alignment. **A3 resolves none of them, mints nothing for them, and depends on none of them for `RANK-1`.** They are recorded here because they were discovered by this part's analysis and would otherwise be lost.

⛔ **A3 has no authority over either finding.** Both concern artefacts A3 does not own.

### 37.1 Finding F-1 — A2 consumes `BC-11` across an unregistered edge

`LCR-FND-001` | **Observation.** A2 v0.4 normatively consumes `BC-11` in two requirements: `LCF-FR-034` / `LCF-FR-096` — "The counter SHALL be the `BC-11`-owned `RateLimitCounter` (BC Map §8 L377)" — and `LCF-AUTH-012` — "`BlockList` is `BC-11`-owned (BC Map L377); this part consumes it".

`LCR-FND-002` | **Constraint.** BC Map **L292**: "If an edge is not in this table, **it does not exist**." The edges touching `BC-11` or `BC-15` are `E-14`, `E-15`, `E-16` and `E-22`. **No `BC-15 → BC-11` edge is registered.**

`LCR-FND-003` | **Observation.** A2's own `LCF-ADR-*` register raises the `BC-15 → BC-14` edge (`LCF-ADR-002`) but **does not raise `BC-15 → BC-11`**.

`LCR-FND-004` | **Characterisation.** This is an **upstream A2 architectural dependency affecting rate limiting and block enforcement** — safety-relevant paths — not an A3 ranking concern. `BC-13` is classified `[CORE]` ⚠ (BC Map **L117**) precisely because safety on a minor-heavy product is "existential legal risk".

`LCR-FND-005` | **Referral.** → **Architecture Owner**, with the A2 author. A3 SHALL NOT mint the edge, choose its shape, or select between a sync port and an event. Note only that `E-16` (`BC-11 → BC-12`, `canMessage(a, b)`) is an existing precedent shape and `ADR-0055` §3 sets the per-context necessity bar. **Neither is adopted here.**

`LCR-FND-006` | **A3 impact: none.** A3's social-relevance signal remains `⏸ DEFERRED` under `LCR-GAP-004` / `LCR-DEC-004` exactly as in v0.1. This finding does not activate it, and resolving F-1 for A2's purposes would not activate it either.

### 37.2 Finding F-2 — comments/reactions capability version is unenumerated

`LCR-FND-007` | **Observation.** The EA `Community (V2)` block (**L967–973**) enumerates Public Communities, Private Communities, Community Feed, Community Roles, `Moderation (V3)` and `Community Analytics (V3)`. **Comments and reactions are not listed.**

`LCR-FND-008` | **Observation.** The only EA `Comments` entry is **L989 — `Comments (V3)`**, under **Notes Sharing**, a different capability branch.

`LCR-FND-009` | **Constraint.** A2 `LCF-FR-026`: "This part SHALL NOT require any V3 capability." A2 nonetheless specifies `CommunityComment`, `CommunityReaction`, `LCF-API-008`–`011`, `LCF-EVT-005`/`006` and `LCF-INV-002`.

`LCR-FND-010` | **Characterisation.** Either community comments/reactions are an **unenumerated V2 capability** (EA's Community block is incomplete), or they inherit the **V3** tag (in which case A2's body is in tension with its own `LCF-FR-026`). This is **distinct from** A2's `LCF-GAP-012`, which records only the internal exclusion-vs-body contradiction and does not mention the version question.

`LCR-FND-011` | **Referral.** → **Product Owner** (scope) and **Architecture Owner** (EA enumeration). A3 SHALL NOT decide the version, amend A2, or amend the EA.

`LCR-FND-012` | **A3 impact at v0.2: none.** `LCR-RS-003` and `LCR-RS-004` remained `⏸ DEFERRED` under `LCR-GAP-003` / `LCR-DEC-002`. F-2 **narrowed** the D2 question by adding a second condition on it; it did not answer it.

`LCR-FND-013` | ✅ **Status at v0.5 — F-2 is CLOSED. The blocked act was performed.** ⭐ `ACCEPTED` **`ADR-0079`** executed `ADR-0075` section 8.5 **Option A**, and the Enterprise Architecture now **says** what the ruling determined: EA **v2.3** carries a new **section 12 "Capability Enumeration Addenda"** enumerating **Community Comments — V2 — `BC-15`** and **Community Reactions — V2 — `BC-15`**. ⭐ **Why this stopped being blocked, precisely:** the blocker was never *"editing the EA is unsafe"* — it was *"**inserting into the capability tree** is unsafe"*. Measurement with a precise regex established that the highest EA line cited anywhere in the repository is **L2404** (in `PRD-012a_PART8`, itself FROZEN), across **482** citations in **57** files — so a section **appended below** every citation invalidates nothing, while an insertion at **L972** would have invalidated **240**. The v0.4 row below reports **175 / 32 files** from an earlier, broader measurement; the precise figure is **240**, and ⚠ a broad regex additionally reported 34 citations above L2404 which were **individually verified as false positives** referring to *other* documents' own lines. **Measured after execution:** all **482** EA line-citations re-resolved, **0** invalidated, **0** cited-line contents changed, **0** frozen files touched, EA **L967–973 byte-identical**, and no diff hunk between L12 and L2449. Also closed as a consequence: A2's `LCF-GAP-013` enumeration half (A2 **v0.7**). ⚠ **A3 impact: still none, and that is the point.** Per `MP-CON-08` (`MASTER_PRD.md` **L519**, **Rank 1**) the EA is **Rank 6 and descriptive**; it could not gate a ranking signal before and does not enable one now. `LCR-RS-004` was already ACTIVE on Rank 1–3 authority. ⛔ **`ADR-0075` is NOT superseded and its status is NOT changed;** its **Option B** — retiring the **281** remaining bare line-number citations in favour of section-plus-node anchors — is the only remediation that removes the *class* of defect and **remains open**. ⛔ Closing this finding advances **no** lifecycle stage and confers **no** readiness

`LCR-FND-013` *(v0.4 text, retained)* | ⛔ **Status at v0.4 — F-2 is BLOCKED, not closed.** ⭐ The **version** question is now formally **determined**: an explicit ruling places Community Comments and Community Reactions at **V2**, and `ADR-0075` records that determination as `Accepted` in principle. But the act that would make the Enterprise Architecture *say* so — enumerating the two nodes in the `Community (V2)` block — is **BLOCKED and was deliberately not performed**. Measured cause: the EA is cited **by line number 329 times** repository-wide, and inserting two lines at the required point would silently invalidate **175** citations across **32** files, **three of which are FROZEN** (`PRD-017` via `ADR-0054`, and the `PRD-012a` family). No CI gate detects this class of breakage. The attempted edit was applied, measured, and **fully reverted** to a byte-identical EA (sha `bb07d1e7…`, 2,549 lines, `v2.2`); four remediation options are routed in `ADR-0075` **section 8.5**, of which Option B — retiring line-number citation in favour of section-plus-node anchors — is the only one that removes the *class* of defect. ⚠ **A3 impact: still none.** Per `MP-CON-08` (`MASTER_PRD.md` **L519**, **Rank 1**) the EA is **Rank 6 and descriptive**, so an unenumerated EA node cannot gate a ranking signal; `LCR-RS-004` activates on Rank 1–3 authority regardless. What follows below was written at v0.3 and remains accurate as to the *determination*. ⛔ **This finding SHALL NOT be recorded as closed while the EA remains unamended.**

`LCR-FND-013` *(v0.3 text, retained)* | ⭐ **Status at v0.3 — F-2 remains OPEN and is now the sole architectural residue of D2.** The **scope** half of F-2 is answered: the Product Owner decided comments/reactions **ship**, and A2 v0.5 narrowed `LCF-XC-017`. The **version** half is answered by **determination, not choice**: `MASTER_PRD.md` **L92** (`MP-SCOPE-04`, **Rank 1**) places `BC-15` at **V2**, and A2 `LCF-INV-002` makes `BC-15` sole owner of both aggregates — therefore **V2**, and expressly **not** by inheritance from EA **L989** `Comments (V3)`, which sits under **Notes Sharing**. What remains is purely the **EA enumeration**: the `Community (V2)` block (**L967–973**) lists neither capability, and the EA contains **no reaction node at any version** (measured: 0 occurrences). Per `MP-CON-08` (**L519**) the EA is **Rank 6, descriptive**, and *"a disagreement is a defect to be raised, not a choice to be made"* — so A3 **raises** it and neither amends the EA nor decides its placement. Adding the nodes is an **Architecture Owner** act under EA §10.5. **A3 impact: none** — the EA is descriptive and cannot gate a ranking signal.

---

*End of PRD-021A Part A3 v0.5 (DRAFT). Correction pass (v0.1), Stage-3 integration (v0.2), D2-P scope resolution (v0.3) and the four owner rulings (v0.4) are retained in full; three `ACCEPTED` ADRs are integrated at v0.5.*

*⭐ **What v0.5 resolved.** Three items, each on an `ACCEPTED` ADR issued by its competent owner, and **none** by a decision of this document. **`LCR-FND-013` CLOSED** — `ADR-0079` executed the EA enumeration by append-only section (EA **v2.3**, new section 12), satisfying the finding's own precondition; measured **482** EA citations re-resolved, **0** invalidated, **0** frozen files touched. **`LCR-GAP-001` CLOSED** — `ADR-0080` constituted the **Governance Owner** by derivation from `PRD_LIFECYCLE.md` **L282** and three ADRs that had already exercised the role, and registered the `LCR-` prefix to A3. **`LCR-DEC-009` REFUSED** — see below; refusal is a disposition, **not** a resolution.*

*⭐ **What v0.5 explicitly did NOT do.** It changed **no weight** — the active set is still `LCR-RS-001` = **70** plus `LCR-RS-004` = **30** = exactly **100**, `LCR-RS-003` is still `ELIGIBLE` at exactly **0**, and section 12.1 is byte-unchanged. It **minted no identifier** — the total is still **237 live across 12 registers**. It amended **no** other artefact, **no** frozen document, **no** Rank 1–5 register, and issued **no** ADR.*

*⛔ **`LCR-DEC-009` is REFUSED as undecidable, not resolved** (`ADR-0081` section 2). Six determinability probes returned nothing: no `Accepted` ADR, no Decision Record value (**L303–304**: section 7.3 *"does **not** assign a weight"*), no Owner Decision Request value (**L365**: *"no value of any kind"*), no Rank 1–5 document, and `LCR-FR-028a` forbids inference. Publishing a number would invent a product decision; carving one from the ruled `70`/`30` would overwrite a decision the Product Owner **did** make. It stays **OPEN** with the **Product Owner**. **6 gaps and 6 decision requirements remain open.***

*⭐ **What v0.4 resolved.** `LCR-GAP-003` (helpfulness designated on `HELPFUL`), `LCR-GAP-009` (community scope carries no `tenantId`, per `ACCEPTED` `ADR-0078`) and `LCR-DEC-008` (weights ruled) are **RESOLVED**. `LCR-RS-004` Legitimate engagement is **ACTIVE at 30**, joining `LCR-RS-001` Recency at **70** — the active set sums to **exactly 100**. `LCR-AC-022` became verifiable; `LCR-BR-010` and `LCR-BR-010a` became binding.*

*⚠ **What v0.4 did NOT resolve** *(as written at v0.4; superseded at v0.5 as to `LCR-FND-013` and `LCR-GAP-001` only)*. `LCR-RS-003` Helpfulness is **ELIGIBLE at weight 0** — designated but unruled, routed as new `LCR-DEC-009`; inventing its weight was refused. **7 gaps and 6 decision requirements remain open.** `LCR-FND-013` is **BLOCKED, not closed**: the V2 determination stands, but the EA enumeration was reverted because it would have broken 175 line-citations across 32 files, three of them FROZEN (`ADR-0075` section 8). ⭐ **v0.5 correction:** the enumeration was subsequently **performed** by `ADR-0079` using the append-only path, so `LCR-FND-013` is **CLOSED**; and `LCR-GAP-001` is **CLOSED** by `ADR-0080`. The refusal of `LCR-DEC-009` **stands and is reaffirmed**.*

*⛔ **Status: NOT READY — NOT FROZEN. NOT APPROVED. NOT BASELINED. NOT RELEASED.** No lifecycle stage advanced and no acceptance criterion is claimed to pass. Independently of every blocker above, `PRD-021` **must not ship before `PRD-020`** (`PRODUCT_IMPLEMENTATION_ROADMAP` **L161–164**); that gate is unaffected by ranking work and is not satisfied, and `PRD-020` is still `DRAFT`. `ADR-0081` section 5.1 enumerates **eleven** genuinely unmet readiness conditions across `PRD-021A`. Stage 7 has not been performed and `PRD_LIFECYCLE.md` §7 states there is **no fast path** — *"Stage 7 is not skippable"*. v0.1, v0.2, v0.3 and v0.4 are preserved in repository history.*
