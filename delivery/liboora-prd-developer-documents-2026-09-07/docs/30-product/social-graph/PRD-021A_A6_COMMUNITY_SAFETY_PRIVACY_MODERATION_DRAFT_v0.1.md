<!--
  PROVENANCE
  ==========
  Document      : PRD-021A Part A6 — Community Safety, Privacy & Moderation
  Status        : DRAFT — v0.1
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : No stage advanced. Stage 3 is NOT CONFERRED for any part.
                  The 9-stage PRD_LIFECYCLE.md ladder is untouched by this
                  file's existence.
  Authorization : Product Owner decision D-A, recorded at PRD_REGISTRY.md
                  section 11, authorized PRD-021A as the product decomposition
                  of BC-15 Community & Groups (V2). A SUBSEQUENT Product Owner
                  instruction authorized A6, A7 and A8 as PARTS OF PRD-021A.
                  See 0.4 — that instruction is disclosed, not paraphrased,
                  and the prior refusal it overrides is quoted in full.

  WHAT THIS DOCUMENT IS
  ---------------------
  An INTEGRATION CONTRACT between BC-15 Community & Groups and the existing
  BC-13 Trust & Safety capability specified by PRD-020. It is NOT a moderation
  system, NOT a competing trust-and-safety PRD, and NOT a claim on any BC-13
  aggregate.

  WHAT THIS DOCUMENT DOES NOT DO
  ------------------------------
    - does NOT own or duplicate ModerationCase, AbuseReport,
      EnforcementAction, StrikeRecord or Appeal (all BC-13, BC Map L379)
    - does NOT define moderator roles, enforcement policies, strike
      thresholds, moderation enums, severities, SLAs or policy values
    - does NOT create an aggregate, a bounded context, a bounded-context
      edge, a permission identifier or a role
    - does NOT take a Product Owner, Architecture Owner, Governance Owner
      or Privacy Owner decision
    - does NOT resolve TSF-GAP-001, TSF-GAP-002, TSF-GAP-006, TSF-GAP-009,
      TSF-GAP-010, ADR-0070, R-1/R-2/R-3, or any open PRD-020 item
    - does NOT pull BC-15 or BC-13 scope between release bands
    - does NOT modify PRD-020, the BC Map, the Module Dependency Matrix, the
      Enterprise Architecture, the Traceability Matrix, DOCUMENTATION_BASELINE,
      any ADR or any FROZEN PRD
    - does NOT confer a lifecycle stage or register an identifier

  THE CENTRAL MEASURED FINDING OF THIS PART
  -----------------------------------------
  BC-13 has ZERO inbound edges. Measured on the live BC Map section 7 edge
  table: no row lists BC-13 in its target column. PRD-020 F-3 states the same
  fact independently: "BC-13 has exactly ONE edge, and it is outbound. There
  is no inbound edge and no port."

  CONSEQUENCE, AND IT IS NOT COSMETIC:
    - CONSUMING enforcement (BC-13 -> BC-15) is LAWFUL AS WRITTEN. E-14
      (BC Map L318) already names BC-15 in its consumer set.
    - FILING a report (BC-15 -> BC-13) has NO REGISTERED EDGE. By BC Map
      L292 that edge "does not exist".

  Therefore every requirement in this part that depends on the outbound
  reporting path is written SELF-BLOCKED, in the exact shape LCF-FR-043 and
  A2 v0.8 use. This part does NOT claim the edge exists, and does NOT mint it.
  See 2.3 and LCS-ADR-001.
-->

# PRD-021A — Part A6

## Community Safety, Privacy & Moderation

### Specification v0.1 — DRAFT

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT BASELINED.** Committed for review and
> traceability only. Publication is a **filing act**: it confers no lifecycle
> stage, ratifies no identifier, and closes no gap.
>
> ⛔ **This part owns no moderation capability.** `BC-13` Trust & Safety, as
> specified by `PRD-020`, keeps every case, report, strike, appeal and
> enforcement decision. §6 enumerates that boundary explicitly, and §23
> restates it as a closing audit.
>
> ⛔ **The outbound reporting edge `BC-15 → BC-13` DOES NOT EXIST.** Measured,
> not assumed — §2.3. Every requirement depending on it is **self-blocked**.

---

## 0. Document control

| Field | Value |
|---|---|
| **Part** | `PRD-021A` A6 |
| **Title** | Community Safety, Privacy & Moderation |
| **Version** | v0.1 |
| **Status** | **DRAFT** — not baselined, not approved, not frozen |
| **Authorization** | Product Owner instruction authorizing A6 as a **part of `PRD-021A`** — §0.4 |
| **Predecessors read** | A1 v0.2, A2 v0.8, A3 v0.6, A4 v0.1, A5 v0.1 (all DRAFT); `PRD-021A_STAGE3_ARCHITECTURE_ALIGNMENT.md` |
| **Authorities read** | `PRD-020` v0.5 (2,734 L), BC Map v1.8, Module Dependency Matrix, `MASTER_PRD.md`, `PRD_LIFECYCLE.md`, `PRD_REGISTRY.md`, `PRD_OWNERSHIP_MODEL.md`, `ADR-0001`, `ADR-0055`, `ADR-0059`, `ADR-0065`, `ADR-0078`, `ADR-0080`, `ADR-0082` |
| **Identifier prefix** | `LCS-` — **PROPOSED, NOT REGISTERED.** Collision-measured: `LCS-` returns **0** occurrences across `docs/`, `lib/`, `test/`, `tool/`. Registration is a Governance Owner act (`PRD_LIFECYCLE.md` §5 rule 3, exercised for `LCF-`/`LCR-` by `ADR-0080` §5). **Not exercised here** |
| **Bounded context** | `BC-15` Community & Groups — `[SUPPORTING]`, **V2**, BC Map **L119** |
| **Integrates with** | `BC-13` `[CORE]` V1 (**L117**), `BC-11` (**L115**), `BC-18` (**L127**), `BC-24`, `BC-19`, `BC-25` |
| **Aggregates created** | **ZERO.** §10 |
| **Bounded contexts created** | **ZERO.** Count remains **31** |
| **Edges created** | **ZERO — RATIFIED for both halves, and the zero is now the *correct* answer rather than a deferred one.** Owner ruling **AO-4** (2026-08-31) selected **Option B**, the existing-edge-fed local projection, and ⛔ **expressly forbade a `BC-15` → `BC-13` edge.** `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md) (2026-08-31) then closed the remaining half **also at zero**, because report **filing** is `BC-13`'s **internal command surface** invoked by *"any authenticated person"* (`PRD-020` **§21.3 L1800**) and ⛔ **not** a cross-context integration. A6's refusal to mint an edge was therefore **correct on both counts**. ✅✅ **`LCS-ADR-001` is now FULLY closed: `LCS-ADR-001a` (moderation reads — ✅ CLOSED by AO-4) and `LCS-ADR-001b` (report filing — ✅ CLOSED by `ADR-0084`).** |
| **ADRs minted** | **ZERO.** Next free number remains `ADR-0083` |
| **Permissions minted** | **ZERO.** `AUTH-7.22` closes the catalogue; `ADR-0036` §7.1 records zero `PERM-*` repo-wide |
| **Roles minted** | **ZERO** |
| **Policy values minted** | **ZERO** — no threshold, severity, SLA, retention period or rate limit is stated |

### 0.1 Normative language

`SHALL` / `SHALL NOT` are binding on any implementation **of this part**, and
take effect only subject to §0.3. `MAY` is permissive. `SHOULD` expresses a
preference that an implementer may decline with a recorded reason.

⚠ **Every `SHALL` in §§7–9 and §12 is additionally conditional on
`LCS-ADR-001`** — the unregistered outbound reporting edge. Those requirements
are written self-blocked and are **not** implementable until an `ACCEPTED` ADR
registers the edge.

### 0.2 What this document is not

Not an approval, not a baseline, not an architecture amendment, not an ADR, and
not a claim of scope over `BC-13`. It is a **measured integration proposal**.

### 0.3 Standing conditions inherited from the family

This part inherits, and does not attempt to resolve, every open condition on
its predecessors:

| Condition | Source | State |
|---|---|---|
| Stage 3 not conferred for `PRD-021A` | `PRD-021A_STAGE3_ARCHITECTURE_ALIGNMENT.md`; re-run confirms 6/6 measured but conferral withheld | ⛔ OPEN |
| `BC-15 → BC-11` consumption edge unregistered | A2 v0.8 `LCF-ADR-007` **L1725** | ⛔ OPEN — **A6 depends on it too** (§9) |
| `BC-15` has no module or cluster assignment | Matrix **L90**, **L480–483**; yaml **L234** | ⛔ OPEN |
| `BC-15` aggregates unregistered in BC Map §8 | A2 `LCF-ADR-001`, `LCF-GAP-009` | ⛔ OPEN |
| A1 `LCM-DEC-001` community-creation authority | A1 v0.2 header | ⛔ OPEN |
| A4 scope allocation | A4 `LCG-DEC-001` — A4 is a **CANDIDATE** | ⛔ OPEN |
| A5 existence | A5 `LCO-DEC-001` / A3 `LCR-DEC-006` | ⛔ OPEN |
| `BC-15` release band | **V2** — `MP-SCOPE-04` (`MASTER_PRD.md` **L92**), BC Map **L119** | **UNCHANGED** |

⛔ **This part changes none of the above.** Where A6 requires one of them, it
records the dependency and stops.

### 0.4 ⭐ The authorization, and the refusal it overrides — disclosed in full

`PRD_REGISTRY.md` **§11.4 L757** currently records, from decision `D-A`:

> | **A6** | Community moderation | ⛔ **NO STANDALONE PRD — NOT AUTHORIZED** | **`BC-13` / `PRD-020` Trust & Safety.** `ModerationCase` is `BC-13`'s (BC Map **L379**) … ⛔ **A6 not created** |

The Product Owner has since instructed that A6 be completed **as a part of the
authorized `PRD-021A`**, expressly stating: *"They are NOT permission to create
competing standalone PRDs for `BC-13`, `BC-22`, or the platform architecture."*

⭐ **The two statements are compatible, and the distinction is the whole basis
of this part's existence.** The refusal was of a **standalone PRD** that would
own moderation. This document is an **integration contract** inside `PRD-021A`
that owns none. Read that way, §11.4's *"Existing owner that keeps the scope"*
column is **honoured, not contradicted**: `BC-13` / `PRD-020` keeps the scope.

⚠ **A disclosed consequence, routed and not repaired.** `PRD_REGISTRY.md`
**§11.4** now reads as stale in one respect — its verification line *"`ls
docs/30-product/social-graph/ | grep -E "_A[678]_"` returns **nothing**"* is
falsified by this file's existence. ⛔ **A6 does not edit the registry.** The
registry is an **unranked** governance document (its own **L285**), so no ADR is
required to amend it — but amending it is a **Governance Owner** act, not this
part's. Recorded as **`LCS-GAP-001`**, routed to the Governance Owner.

---

## 1. Executive summary

`BC-15` will host user-generated community content. `BC-13` Trust & Safety
already owns every safety decision on this platform and is classified `[CORE]`
because, per BC Map **L117**, *"on a minor-heavy product this is existential
legal risk, not a commodity."*

A6 therefore specifies **one thing**: the contract by which community content
becomes reportable, filterable and enforceable **using the existing capability**,
without `BC-15` acquiring a single safety decision.

**Four measured facts govern every section that follows.**

| # | Fact | Measured at | Consequence for A6 |
|---|---|---|---|
| **A6-F1** | `BC-13` owns `ModerationCase`, `AbuseReport`, `EnforcementAction`, `StrikeRecord`, `Appeal` | BC Map **L379** | A6 references all five; **owns none**; **duplicates none** |
| **A6-F2** | `E-14` (`BC-13 → BC-11, BC-12, BC-14, BC-15`) already names `BC-15` | BC Map **L318**; `PRD-020` `TSF-FR-029` (*"it does … so no amendment is needed"*) | ✅ **Inbound enforcement consumption is LAWFUL AS WRITTEN.** No edge needed |
| **A6-F3** | ✅ **MEASUREMENT CONFIRMED — INTERPRETATION CORRECTED (2026-08-31, `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md)).** `BC-13` has **ZERO** inbound edges | Live §7 scan: **0** rows target `BC-13` — ⭐ **re-measured and still 0.** The count was never wrong; the *inference* was. `PRD-020` **§21.3 L1800** states the zero is **BY DESIGN**: *"`BC-13` has **no published inbound edge** (`F-3`), so every command below is **internal to the safety application, not a cross-context API**"* | ✅ **Outbound reporting needs NO EDGE, because filing is not an integration.** `PRD-020` **§21.3** gives `FileAbuseReport` the actor *"**Any authenticated person**"* — a person invoking `BC-13`'s **own** command surface through a registered port, which is exactly what `F-3` requires. ⭐ **Symmetry proof:** `BC-11` and `BC-12` — `BC-15`'s own same-rank cluster peers, both `[SUPPORTING]`, both holding reportable content — also have **0** edges to `BC-13`. `BC-15` is not an exception to the pattern; it **is** the pattern. §2.3 dependents are unblocked accordingly |
| **A6-F4** | `BC-11` owns `BlockList`, `RateLimitCounter` | BC Map **L377**; `PRD-020` `F-6`, `TSF-XC-004`…`006` | Block/mute **delegated**; consumption gated on `LCF-ADR-007` (§9) |

⭐ **The asymmetry in A6-F2 versus A6-F3 is the single most important structural
fact in this part.** Enforcement flows *into* `BC-15` over a registered edge and
needs nothing. Reports must flow *out of* `BC-15` and have nowhere lawful to go.
A part that ignored this would specify a reporting button that cannot exist.

### 1.1 Ownership disposition — the five-way classification, applied

Per the Product Owner's ownership rule, every section below is classified. The
aggregate distribution across A6's 22 substantive sections:

| Class | Count | Meaning |
|---|---|---|
| **OWNED BY `PRD-021A`** | **6** | Community-local state and behaviour: eligibility states, pre-ranking filter order, visibility rules |
| **INTEGRATION WITH EXISTING CONTEXT** | **7** | A contract with `BC-13`/`BC-11`/`BC-18`/`BC-24` that A6 specifies but does not control |
| **DELEGATED TO EXISTING CONTEXT** | **8** | Wholly `BC-13`'s or `BC-11`'s; A6 states the delegation and adds nothing |
| **OPEN OWNER DECISION** | **6** | Routed, unresolved, named owner |
| **FUTURE / V2 SCALE** | **3** | Deliberately deferred |

⛔ **No integration dependency is converted into ownership anywhere in this
document.** §23 re-audits this claim section by section.

---

## 2. Problem statement

### 2.1 What is being asked

`BC-15` community content must be reportable, must disappear when `BC-13`
enforces, must never be served to a blocked party, and must never leak across
libraries. All four are **safety** behaviours, and `BC-13` owns safety.

### 2.2 Why a naive answer is wrong

The naive answer is to give `BC-15` a moderation queue. That fails on four
independent measurements:

| Naive move | Fails against | Measured |
|---|---|---|
| `BC-15` holds `ModerationCase` | BC Map **L379** | `ModerationCase` is `BC-13`'s aggregate root |
| `BC-15` decides removal | `PRD-020` `TSF-XC-021` | *"`BC-13` **MUST NOT** write into … `BC-15`"* — restriction is by **event**, and symmetrically `BC-15` does not decide |
| `BC-15` defines moderator roles | `PRD-020` `TSF-XC-031` | *"**MUST NOT** specify community roles"* is `BC-13`'s constraint; the mirror constraint is that **A6 must not specify moderation roles** |
| `BC-15` scopes moderation per library | `F-1`, `F-2` | `BC-15` is **Global** (`ID-2`); `X-05` is *Separate Ways*. Library-scoped moderation **cannot** be built in the Global band |

### 2.3 ⛔ The structural obstacle — measured, not asserted

**Live measurement of BC Map §7 (L292–L336), target column:**

```
rows whose TARGET contains BC-13 ....................... 0
rows whose SOURCE is BC-13 ............................. 1   (E-14, L318)
rows whose TARGET contains BC-15 ....................... 1   (E-14, inbound)
rows whose SOURCE is BC-15 ............................. 0
```

`PRD-020` **L94** (`F-3`) states it independently and in terms:

> *"**`BC-13` has exactly ONE edge, and it is outbound.** `E-14` (BC Map
> **L318**), event-only, to `BC-11`/`BC-12`/`BC-14`/`BC-15`. **There is no
> inbound edge and no port**"* → *"T&S has no read path into reported content."*

BC Map **L292** supplies the consequence:

> *"Every edge that crosses a context boundary in V1. **If an edge is not in
> this table, it does not exist** and adding it requires an ADR."*

⛔ **Therefore: `BC-15` cannot lawfully call `BC-13` to file a report.** Not
*"should not"*. **Cannot** — the edge does not exist.

⭐ **This is the same defect class the Stage-3 record found in A2 v0.7, and A6
applies the remedy A2 v0.8 adopted, pre-emptively rather than after a gate
failure.** Every A6 requirement that depends on the outbound path carries a
self-blocking clause in the `LCF-FR-043` shape, and the edge is raised as
`LCS-ADR-001` for the **Architecture Owner**. A6 does **not** mint it.

⚠ **Note carefully what is NOT claimed.** A6 does **not** claim the reporting
edge exists because a requirement is self-blocked. Self-blocking makes this
draft **compliant**; it does **not** register anything. The distinction is drawn
verbatim from the Stage-3 record §2.4.

### 2.4 What A6 can therefore legitimately deliver now

| Deliverable | Blocked? | Why |
|---|---|---|
| Content eligibility states owned by `BC-15` | ✅ **NO** | Local state; no edge crossed |
| Safety filter **position** in the feed pipeline | ✅ **NO** | Local ordering constraint (§5) |
| Consumption of `safety.EnforcementActionTaken` | ✅ **NO** | `E-14` exists — `A6-F2` |
| Audit emission | ✅ **NO** | `E-20` *"All contexts → `BC-24`"* |
| Config reads | ✅ **NO** | `E-19` *"All contexts → `BC-25`"* |
| Report **filing** | ✅ **NO — UNBLOCKED. `LCS-ADR-001b` CLOSED 2026-08-31 by `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md).** | ⭐⭐ **The blocker rested on an inverted premise, and the inversion is named rather than quietly dropped.** Every measurement in the superseded text below was **re-run and confirmed true**: rows targeting `BC-13` = **0**; rows sourced from `BC-15` = **0**; `E-14`/`E-28`/`E-29` are inbound; and ⛔ **no all-context edge targets `BC-13`** — that last fact is still correct. ⭐ **What was wrong was the conclusion drawn from it.** A6 searched for a **cross-context edge** to carry a report, and reasoned that its absence blocked filing. But `PRD-020` **§21.3 L1800** declares `BC-13`'s zero inbound edges **deliberate**: *"no published inbound edge (`F-3`), so every command below is internal to the safety application, **not a cross-context API**"*. ✅ **Filing a report is a person acting on `BC-13`'s own command surface**, not `BC-15` integrating with `BC-13`. `FileAbuseReport`'s actor is *"Any authenticated person"*, its idempotency key is `(reporter, subject, category, window)` supplied **by the client**, and its authorisation is *"rate-limited by `BC-18`/edge"*. ⛔ **`BC-15` is not a party to the call and supplies no transport** — it supplies only the **subject reference** the reporter names, exactly as §8's ownership table already said (*"`AbuseReport` | `BC-13` | ⛔ Never held"*). ⚠ **No edge was minted to reach this result**, and none is needed: an edge would assert a cross-context coupling that `PRD-020` **§21.3** says must not exist |
| Block/mute **consumption** | ⛔ **YES** | `LCF-ADR-007` — `A6-F4` |
| Moderator queue / case UI | ⛔ **REFUSED** | Not A6's scope in any world — `BC-13`'s |

---

## 3. Goals

| ID | Goal |
|---|---|
| `LCS-G-001` | Specify the `BC-15` ⟷ `BC-13` integration contract **without transferring any safety decision to `BC-15`** |
| `LCS-G-002` | Define the community-local **content eligibility state** that safety filtering reads |
| `LCS-G-003` | Fix the **mandatory ordering** of safety filtering relative to A3 ranking, so ranking can never surface ineligible content |
| `LCS-G-004` | Specify enforcement **consumption** over the existing `E-14` edge |
| `LCS-G-005` | State every delegation to `BC-13`/`BC-11` explicitly, so no reader infers `BC-15` ownership |
| `LCS-G-006` | Raise, and leave open, every architecture act this contract requires |

## 4. Non-goals

| ID | Non-goal |
|---|---|
| `LCS-NG-001` | ⛔ Building a moderation queue, console, or case-management surface |
| `LCS-NG-002` | ⛔ Defining moderator roles, strike thresholds, severities, SLAs or categories |
| `LCS-NG-003` | ⛔ Resolving library-scoped moderation (`TSF-GAP-001`/`002`, `F-1`/`F-2`, `R-1`/`R-2`/`R-3`, `ADR-0070`) |
| `LCS-NG-004` | ⛔ Holding, mirroring or caching any `BC-13` aggregate |
| `LCS-NG-005` | ⛔ Pulling `BC-15` into V1 |
| `LCS-NG-006` | ⛔ Automated/ML content classification — §22 records it as FUTURE |

---

## 5. Architecture principles

| ID | Principle | Anchored in |
|---|---|---|
| `LCS-AP-001` | **Safety decisions are `BC-13`'s. `BC-15` supplies subjects and applies outcomes.** | BC Map **L286**, **L379** |
| `LCS-AP-002` | **`BC-13` acts on `BC-15` by event, never by write.** `BC-15` self-restricts. | BC Map **L286**; `TSF-XC-021` |
| `LCS-AP-003` | **Fail closed.** Where safety state is unavailable, content is withheld, not served. | §15; A2 v0.8's own gating idiom |
| `LCS-AP-004` | **No aggregate duplication.** `BC-15` holds references, never copies. | §10; `MP-CON-08` |
| `LCS-AP-005` | **Global band discipline.** `BC-15` holds no `tenantId`. | `ID-2` (**L488**); `ACCEPTED` `ADR-0078` |
| `LCS-AP-006` | **An unregistered edge is not an edge.** Requirements crossing one are self-blocked. | BC Map **L292** |
| `LCS-AP-007` | **Modular monolith preserved.** No new deployable, no service boundary. | `ADR-0001` (scope *"Whole platform"*) |

---

## 6. ⭐ Ownership boundaries — what remains `PRD-020` / `BC-13`

**This section is the one the Product Owner asked to be stated explicitly. It is
normative.**

### 6.1 Retained in full by `BC-13` / `PRD-020` — A6 owns none of it

| Object / capability | Owner | Authority | A6's relation |
|---|---|---|---|
| `ModerationCase` (aggregate root) | `BC-13` | BC Map **L379** | ⛔ **Never held.** Reference only, by opaque case reference |
| `AbuseReport` | `BC-13` | BC Map **L379** | ⛔ **Never held.** A6 supplies a subject reference |
| `EnforcementAction` | `BC-13` | BC Map **L379** | ⛔ **Never held.** A6 consumes the *event* |
| `StrikeRecord` | `BC-13` | BC Map **L379** | ⛔ **Never held, never read, never counted** |
| `Appeal` | `BC-13` | BC Map **L379** | ⛔ **Never held.** §12 delegates wholly |
| Report categories & severities | `BC-13` | `PRD-020` §12.2 | ⛔ **A6 enumerates none** |
| Triage SLAs | `BC-13` | `TSF-CFG-005`/`006` | ⛔ **A6 states no duration** |
| Strike escalation | `BC-13` | BC Map **L379** invariant | ⛔ **A6 defines no threshold** |
| Enforcement action set | `BC-13` | `TSF-FR-028` | ⛔ **A6 adds none.** `COMMUNITY_RESTRICTION`, `CONTENT_REMOVAL` **already exist** |
| Moderator roles & permissions | `BC-13` + `BC-18` | `PRD-020` §9.3; `AUTH-7.22` | ⛔ **A6 mints none** |
| Appeal adjudication | `BC-13` | `PRD-020` §16 | ⛔ **Wholly delegated** |
| Policy versions | `BC-13` | `PRD-020` §9.3 | ⛔ **A6 authors none** |
| Reporter anonymity | `BC-13` | `TSF-INV-009`, `TSF-BR-015` | ⛔ **A6 must not weaken it** — §18 |
| `BlockList`, `RateLimitCounter` | **`BC-11`** | BC Map **L377**; `F-6` | ⛔ **Not `BC-13`'s either.** §9, §19 |

⭐ **Note the last row.** A frequent error would be to route block/mute to
`BC-13`. `PRD-020` `TSF-XC-004`…`006` expressly disclaim it: *"T&S does not own
Block, Mute or graph rate limits."* They are `BC-11`'s. A6 routes them to
`BC-11`, which is why A6 inherits `LCF-ADR-007`.

### 6.2 What A6 legitimately owns — community-local, no edge crossed

| ID | Owned object | Why it is `BC-15`'s and not `BC-13`'s |
|---|---|---|
| `LCS-OWN-001` | **Content eligibility state** on `CommunityPost` / `Comment` / `Reaction` | The *projection* of an enforcement outcome onto local content. `TSF-XC-021` forbids `BC-13` writing here, so someone must hold it locally, and that someone is `BC-15` |
| `LCS-OWN-002` | **Filter position** in the read pipeline (§5, §12 of A8) | An ordering constraint over `BC-15`'s own read path |
| `LCS-OWN-003` | **Visibility rules** for restricted content to author vs others | Presentation of `BC-15` content |
| `LCS-OWN-004` | **Reportability surface** — which `BC-15` objects are reportable subjects | The subject register is `BC-13`'s (`TSF-FR-027`); *which local objects map onto it* is `BC-15`'s |
| `LCS-OWN-005` | **Local safety audit facts** emitted over `E-20` | `BC-15`'s own actions |
| `LCS-OWN-006` | **Community-scope isolation** of all the above | §14 |

⛔ **Every one of these six is local state or local ordering. None is a safety
decision. None duplicates a `BC-13` aggregate.**

### 6.3 The five-way classification, section by section

| § | Subject | Classification |
|---|---|---|
| 7 | Reporting integration | **INTEGRATION** — ✅✅ **BOTH PATHS NOW CLOSED.** ✅ **Read path** closed by Owner ruling **AO-4** (2026-08-31) (`LCS-ADR-001a`, `E-14`-fed local projection, no new edge). ✅ **Filing path** closed by `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md) (`LCS-ADR-001b`): filing is `BC-13`'s **internal command surface** invoked by a **person** (`PRD-020` **§21.3 L1800**), ⛔ **not** an integration edge — so the correct carrier count is **zero**, and zero is what both halves now lawfully use |
| 8 | Moderation intake | **DELEGATED** to `BC-13` |
| 9 | Content eligibility states | **OWNED** |
| 10 | Safety filtering before ranking | **OWNED** (ordering) |
| 11 | Moderation visibility | **OWNED** (presentation) / **DELEGATED** (case data) |
| 12 | Removed / restricted content | **OWNED** |
| 13 | Community member safety | **INTEGRATION** with `BC-11` |
| 14 | Block / mute / privacy | **DELEGATED** to `BC-11` ⛔ gated by `LCF-ADR-007` |
| 15 | Moderator authorization | **DELEGATED** to `BC-18` + `BC-13` |
| 16 | Enforcement integration | **INTEGRATION** over `E-14` ✅ lawful |
| 17 | Appeals | **DELEGATED** wholly to `BC-13` |
| 18 | Audit | **INTEGRATION** over `E-20` ✅ lawful |
| 19 | Tenant / community isolation | **OWNED** |
| 20 | Safety failure behaviour | **OWNED** (fail-closed) |
| 21 | Moderation event integration | **INTEGRATION** over `E-14` / `E-20` |
| 22 | Retention / deletion | **OPEN OWNER DECISION** |
| 23 | Privacy | **INTEGRATION** / **OPEN** |
| 24 | Rate limiting / abuse prevention | **DELEGATED** to `BC-11` ⛔ gated |
| 25 | Security audit | **OWNED** (self-audit) |
| 26 | Edge cases | mixed — each row classified |
| 27 | Acceptance criteria | **OWNED** (verification of the above) |

---

## 7. Reporting integration — ⛔ SELF-BLOCKED

**Classification: INTEGRATION WITH EXISTING CONTEXT.** The report is `BC-13`'s
in every respect; A6 specifies only how a `BC-15` object becomes its subject.

### 7.1 What already exists, and needs nothing from A6

`PRD-020` **`TSF-FR-027`** (§9.2) already provides:

> *"The `AbuseReport` subject type register **MUST** include `COMMUNITY_POST`
> and `COMMUNITY_COMMENT` from V1, **unpopulated until `BC-15` ships**."*

⭐ **The subject types A6 needs already exist.** `PRD-020` built them
deliberately so that, per **L603**, *"the machinery is built now so that
`BC-15` inherits it rather than reinventing it."* A6 **inherits**; it does not
extend the register.

⚠ **Measured gap, disclosed:** the register covers `COMMUNITY_POST` and
`COMMUNITY_COMMENT`. It does **not** cover a **reaction**, a **community
itself**, a **group** (A4) or an **official communication** (A5).
`PRD-020` `TSF-XC-034` refused *"Library official post"* as a reportable type
*"for want of a subject"*, recording `TSF-GAP-010` — **owner Product Owner**.

⛔ **A6 does not add subject types.** The register is `BC-13`'s. Recorded as
`LCS-GAP-002`, routed to the **`BC-13`/`PRD-020` owner**, and noted as
*partially anticipated* by `TSF-GAP-010`.

### 7.2 The requirements — every one self-blocked

`LCS-FR-001` | A reader of a `BC-15` community object **SHALL** be able to file
an abuse report against it from the surface where it was encountered.

`LCS-FR-002` | The report **SHALL** be filed **into `BC-13`**. `BC-15` **SHALL
NOT** create, store or number a report, a case, or any local equivalent.

`LCS-FR-003` | `BC-15` **SHALL** supply only: the subject type (from `BC-13`'s
existing register, `TSF-FR-027`) and an opaque subject reference. It **SHALL
NOT** supply a category, a severity or an SLA — `PRD-020` §12.2 sets severity
*"by policy, not by the reporter."*

`LCS-FR-004` | `BC-15` **SHALL NOT** retain the reporter's identity in any
`BC-15` record, projection, cache, index or event. `TSF-INV-009` and
`TSF-BR-015` make reporter disclosure a *"retaliation delivery mechanism"*, and
that reasoning binds `BC-15` identically.

`LCS-FR-005` | Idempotency of report submission is `BC-13`'s, on
`(reporterId, subjectRef, categoryCode, idempotencyKey)` per `TSF-FR-048`.
`BC-15` **SHALL** pass an idempotency key through and **SHALL NOT** define its
own de-duplication rule.

`LCS-FR-006` | The acknowledgement shown to the reporter **SHALL** be the case
reference `BC-13` returns (`TSF-FR-046`). `BC-15` **SHALL NOT** synthesise one.

`LCS-FR-007` | A filed report **SHALL NOT**, by itself, change the eligibility
state of the subject (§9). Only an enforcement outcome does. A report is an
accusation, not a decision.

> ⛔ **Self-blocking clause — Stage 3 Check 2 discipline applied pre-emptively.**
> BC Map **L292** provides: *"If an edge is not in this table, it does not exist
> and adding it requires an ADR."* **Live measurement: zero BC Map §7 rows
> target `BC-13`** (§2.3), and `PRD-020` `F-3` independently states *"there is
> no inbound edge and no port."* The `BC-15 → BC-13` reporting path this
> section requires therefore **does not exist**.
>
> **Until an `ACCEPTED` ADR registers that edge, community reporting SHALL be
> treated as blocked** — `LCS-FR-001`…`LCS-FR-007` are **not implementable**,
> in the same shape `LCF-FR-043` uses for `LCF-ADR-002` and A2 v0.8's three
> clauses use for `LCF-ADR-007`.
>
> ⚠ **Fail-closed direction is deliberate and is not a product choice.**
> Blocking the *reporting button* is the safe reading only because §12 blocks
> the *content* too: A6 does **not** ship a community whose content is visible
> but unreportable. §12 `LCS-FR-030` makes that dependency explicit.
>
> Decision owner: ⛔ **Architecture Owner** — `LCS-ADR-001` (§29). This part
> raises the requirement; **registering the edge is that owner's act.**

### 7.3 ⚠ Why this edge is harder than `LCF-ADR-007` — disclosed, not solved

A reader might assume `LCS-ADR-001` is a routine second instance of
`LCF-ADR-007`. **It is not, and overstating the ease would be misleading.**

| Consideration | `LCF-ADR-007` (`BC-15 → BC-11`) | `LCS-ADR-001` (`BC-15 → BC-13`) |
|---|---|---|
| Target's existing inbound edges | `BC-11` has inbound `E-15` | ⛔ `BC-13` has **ZERO** |
| Is the target's isolation *deliberate*? | Not stated as a design invariant | ⭐ **YES.** `F-3` is load-bearing: `ADR-0065` resolved `TSF-GAP-003` **without** adding an edge, expressly *"because `F-3` is what Option A would have had to break"* |
| Precedent for admission | `E-22` admitted `BC-12` by `ADR-0055` | ⛔ `ADR-0055` §3 and `ADR-0059` **refused** `BC-13` admission to `E-22` per-context |
| Same-rank cluster issue | Yes — Matrix **L90** | Yes — `BC-13` is also in the Social cluster |

⭐ **Therefore `LCS-ADR-001` may well be answered by *refusal*, and A6 must not
presume otherwise.** `PRD-020` `TSF-XC-065` shows the precedent shape: an
admission request *"reclassified from 'open gap' to 'closed by existing
ruling'"*.

⚠ **An alternative shape exists in the repository and is NAMED, NOT CHOSEN.**
`ADR-0065` resolved a structurally identical problem (`BC-13` needing to reach
content it cannot read) by a **read model / event projection**, not an edge. A
symmetric solution — `BC-15` emits a *reportable-content fact* over an existing
all-context edge, and `BC-13` consumes it — **might** avoid a new edge entirely.

⛔ **A6 does not select it.** Selecting an integration shape is an
**Architecture Owner** act. Both options are recorded under `LCS-ADR-001`
with **no recommendation ranked as a decision**, per the `PRD-020` §10.1
discipline of naming options without choosing.

---

## 8. Moderation intake — DELEGATED

**Classification: DELEGATED TO EXISTING CONTEXT.** A6 adds nothing.

`LCS-FR-008` | Triage, investigation, queueing, prioritisation and disposition
of a community report **SHALL** be performed entirely by `BC-13` under
`PRD-020` §12–§16. `BC-15` **SHALL NOT** implement any of them.

`LCS-FR-009` | `BC-15` **SHALL NOT** expose a moderation queue, case list, case
detail, evidence view, or moderator workflow of any kind.

`LCS-FR-010` | `BC-15` **SHALL NOT** read `ModerationCase`, `AbuseReport`,
`StrikeRecord` or `Appeal`. ⭐ This is not merely a boundary rule — `A6-F3` makes
it **structurally impossible**: there is no inbound edge to read them over, and
`X-05` (Matrix **L354**) is *Separate Ways*.

`LCS-FR-011` | `BC-15` **SHALL NOT** hold a moderator-facing projection of
`BC-13` state, because holding one would duplicate a `BC-13` aggregate
(`LCS-AP-004`).

⚠ **Evidence snapshots.** `TSF-FR-045` requires *"evidence snapshot"* on every
report. Whether a community-post snapshot is captured by `BC-13` at filing time,
or supplied by `BC-15`, is **undetermined** — and it interacts with `A6-F3`
(`BC-13` has no read path into content) and with `F-4` (`BC-13` may not hold a
`FileRef`, so it cannot snapshot media). ⛔ **A6 does not decide it.** Recorded
as `LCS-GAP-003`, routed to the **Architecture Owner** jointly with the `BC-13`
owner, and flagged as **coupled to `LCS-ADR-001`**.

---

## 9. Content eligibility states — OWNED BY `PRD-021A`

**Classification: OWNED.** This is `BC-15`'s own content state, and the one
place A6 legitimately holds something.

### 9.1 Why `BC-15` must hold this, and why it is not a `BC-13` duplicate

`PRD-020` `TSF-XC-021` (**L371**) is explicit:

> *"`BC-13` **MUST NOT** write into `BC-10`, `BC-11`, `BC-12`, `BC-14` or
> `BC-15`. Restriction is achieved [by event]."*

⭐ **So `BC-13` cannot mark a post as removed.** It publishes
`safety.EnforcementActionTaken`; the consuming context *self-restricts*. The
local flag that expresses that self-restriction **must** live in `BC-15`, and
holding it is **not** duplication — it is the mandated mechanism, symmetric with
how `BC-12` holds its own send-time restriction check under `TSF-FR-031`.

### 9.2 The states

⛔ **A6 mints no moderation enum.** These are **content lifecycle** states of a
`BC-15` aggregate, not moderation outcomes, and they are deliberately *fewer*
than `BC-13`'s action set so they can never be mistaken for it.

`LCS-FR-012` | Every `BC-15` content object **SHALL** carry exactly one
eligibility value drawn from:

| Value | Meaning | Set by |
|---|---|---|
| `ELIGIBLE` | Servable, subject to §10 filters | default on publish |
| `WITHHELD` | Not servable to anyone but the author; no decision has been taken | `BC-15`, on fail-closed (§20) or a pending-state gate |
| `RESTRICTED` | Not servable, by a consumed enforcement outcome | `BC-15`, on `E-14` consumption |

`LCS-FR-013` | `WITHHELD` and `RESTRICTED` **SHALL** be distinct.
⭐ Collapsing them would make a **transport failure** indistinguishable from a
**safety decision** — the precise error `PRD-020` `TSF-AC-025`'s two-clause
restatement exists to prevent.

`LCS-FR-014` | `BC-15` **SHALL NOT** interpret, re-derive or extend the
enforcement action semantics that produced a `RESTRICTED` value. It **SHALL**
record only that a restriction applies, and the opaque action reference.

`LCS-FR-015` | Eligibility **SHALL** be evaluated per reader, not cached
globally, because block state (§14) is a reader-dependent input.

`LCS-FR-016` | ⛔ `BC-15` **SHALL NOT** hold a strike count, a severity, an
appeal state, or any duration derived from `BC-13` policy.

`LCS-FR-017` | The `until` field of `TSF-EVT-002`'s *"closed four-field shape"*
(`{personId, action, scope, until}`, BC Map **L318**) **SHALL** be honoured as
an expiry input. `BC-15` **SHALL NOT** extend, shorten or default it.
⚠ Where `until` is absent or null, `TSF-FR-124` records that a **reversal** is
expressed as a past-dated or nulled `until` — so a null **cannot** be read as
"forever" by `BC-15`. Handling is specified at §26 `LCS-EDGE-004` and the
residual ambiguity is routed as `LCS-GAP-004`.

> ⛔ **Self-blocking clause — `BC-11` consumption.** `LCS-FR-015` requires reader
> block state, which is `BC-11`-owned (`BlockList`, BC Map **L377**). That
> consumption crosses the **same unregistered `BC-15 → BC-11` edge** A2 v0.8
> raises as `LCF-ADR-007`. **Until an `ACCEPTED` ADR registers that edge,
> per-reader eligibility evaluation SHALL be treated as blocked, and content
> SHALL be `WITHHELD` rather than served unfiltered** (§20). ⭐ A6 introduces
> **no new edge requirement here** — it inherits A2's. Decision owner:
> ⛔ **Architecture Owner** — `LCF-ADR-007` (A2 v0.8 **L1725**).

---

## 10. Safety filtering before feed ranking — OWNED (ordering)

**Classification: OWNED BY `PRD-021A`.** A3 owns ranking; A6 owns the constraint
that ranking never sees ineligible content.

`LCS-FR-018` | Safety and privacy filtering **SHALL** execute **before** A3
ranking, and A3 **SHALL** receive only an already-filtered candidate set.

`LCS-FR-019` | ⛔ A3 ranking **SHALL NOT** be capable of restoring, re-ranking
or surfacing an object excluded by §9 or §14. Exclusion is **not** a weight of
zero — it is absence from the candidate set.

⭐ **This is the single most important safety-architecture statement in A6, and
A3 already agrees with it.** A3 v0.6 defers `LCR-RS-006` *"at weight 0 rather
than depending on the edge"*. A weight-based exclusion is a **ranking** concept
and can be overridden by another signal; set-membership exclusion cannot. A6
requires the stronger form.

`LCS-FR-020` | Filter order **SHALL** be: **(1)** community authorization →
**(2)** eligibility (§9) → **(3)** block/mute (§14) → **(4)** A3 ranking. Steps
1–3 are **mandatory and non-bypassable**; step 4 is **fallible** (§20).

`LCS-FR-021` | If any of steps 1–3 cannot be evaluated, the pipeline **SHALL**
fail closed (§20) and **SHALL NOT** proceed to step 4 with an unfiltered set.

`LCS-FR-022` | ⛔ A6 **SHALL NOT** specify ranking weights, decay, diversity or
freshness. Those are A3's (`LCR-RS-*`) and remain wholly A3's.

---

## 11. Moderation visibility — OWNED (presentation) / DELEGATED (data)

`LCS-FR-023` | An author **SHALL** be able to see that their own content is
`RESTRICTED`. Silent removal is a dark pattern and, on a minor-heavy product,
obstructs the appeal right `PRD-020` §16 guarantees.

`LCS-FR-024` | The notice shown **SHALL** carry only the opaque case/action
reference and the fact of restriction. It **SHALL NOT** carry the reporter's
identity (`TSF-INV-009`), the evidence, the severity, or the strike count.

`LCS-FR-025` | A non-author reader **SHALL NOT** be able to distinguish
`RESTRICTED` from `WITHHELD` from *never existed*. ⭐ Uniform responses are the
`LCF-SEC-006` discipline A2 already adopts for membership refusals, and the same
reasoning applies: a distinguishable response is an enumeration oracle.

`LCS-FR-026` | ⛔ `BC-15` **SHALL NOT** render a case history, an appeal status
or a moderation audit trail. Those are `BC-13` surfaces.

⚠ **Open, routed.** *Where* an author reads the notice — a `BC-15` surface, or a
`BC-13` surface reached from `BC-15` — is an **integration-shape** question
coupled to `LCS-ADR-001`. ⛔ Not decided. `LCS-GAP-005`, **Architecture Owner**.

---

## 12. Removed / restricted content — OWNED

`LCS-FR-027` | `RESTRICTED` content **SHALL** be excluded from: the feed, direct
retrieval, search results, notification payloads (A7), counts, and any
aggregate or projection.

`LCS-FR-028` | Restriction **SHALL** cascade to dependents: restricting a post
**SHALL** withhold its comments and reactions from the feed. ⛔ It **SHALL NOT**
alter their own eligibility values, because that would record a safety decision
`BC-13` never took.

`LCS-FR-029` | `BC-15` **SHALL NOT** hard-delete content on restriction.
Deletion is a **retention** act, and retention is unresolved (§22).

`LCS-FR-030` | ⭐ **Community content SHALL NOT be servable while §7 reporting
is blocked.** ⚠⚠ **THIS REQUIREMENT STILL STANDS AND IS STILL NOT RELAXED — it is a standing fail-closed invariant, and [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md) does NOT weaken it by one word.** ⭐ **What changed is the ANTECEDENT, not the rule:** `LCS-ADR-001b` is now ✅ **CLOSED**, so the condition *"while reporting is blocked"* is **no longer satisfied**. The clause remains armed and will fire again the instant reporting genuinely becomes unavailable. ⛔ **It is not downgraded, scoped down, or marked inapplicable.** While the antecedent held, community content **SHALL** have been
`WITHHELD`. Shipping visible-but-unreportable user-generated content on a
minor-heavy product would be the unsafe reading, and this requirement is what
makes §7's fail-closed direction coherent rather than merely convenient.

⚠ **Disclosed consequence, stated plainly:** `LCS-FR-030` means **A6, as
written, blocked the community product until `LCS-ADR-001b` was resolved — and it is now resolved.** ⭐ **AO-4** closed the *reads* half; `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md) closed the *filing* half by showing the required carrier was **zero edges**, because filing runs against `BC-13`'s own command surface (`PRD-020` **§21.3 L1800**). ✅ **The block therefore LIFTS — on the merits, not by waiver.** ⚠⚠ **The requirement itself is untouched and stays fail-closed:** if reporting later becomes unavailable for any operational reason, `LCS-FR-030` fires again and content is `WITHHELD` again. That was
a real cost and it is not hidden. The alternative — serving unreportable content
— is worse, and `BC-13`'s `[CORE]` classification (*"existential legal risk"*,
**L117**) is the repository's own statement of why.

---

## 13. Community member safety — INTEGRATION

`LCS-FR-031` | Member-to-member safety (harassment, unwanted contact) within a
community **SHALL** be handled by the existing `BC-13` reporting path (§7) and
`BC-11` block/mute (§14). ⛔ A6 defines **no** community-specific abuse category.

`LCS-FR-032` | Minor-safety concerns **SHALL** route to `BC-13` unchanged.
⛔ A6 **SHALL NOT** define a minor-safety rule, threshold or age gate — those are
`BC-13`'s (`MINOR_SAFETY`, `PRD-020` §12.2) and, for age, `BC-10`/`BC-18`'s.

`LCS-FR-033` | A person restricted by `TSF-EVT-002` with a community scope
**SHALL** be prevented from posting, commenting and reacting for the duration of
`until`, by `BC-15` self-restriction (§9).

`LCS-FR-034` | ⚠ **Staleness.** `PRD-020` `TSF-FR-031` requires `BC-12` to apply
a *"fail-closed staleness gate"* on the send path, within `TSF-CFG-030`, because
*"eventual consistency is unacceptable for abuse containment"* (BC Map **L468**).
`BC-15` **SHALL** apply the **same discipline** on its write paths: if the local
restriction projection is staler than the budget, the write **SHALL** be refused.
⛔ **A6 states no numeric budget** — `TSF-CFG-030` is `BC-13`'s configuration and
A6 mints no `LCS-CFG-*`.

---

## 14. Block / mute / privacy integration — DELEGATED to `BC-11` ⛔ gated

`LCS-FR-035` | Block and mute state **SHALL** be `BC-11`'s `BlockList`
(BC Map **L377**). `BC-15` **SHALL NOT** hold, mirror or cache block state.
`PRD-020` `TSF-XC-004`…`006` confirm `BC-13` does not own it either.

`LCS-FR-036` | A block **SHALL** suppress community content **bidirectionally** —
neither party sees the other's posts, comments or reactions.

`LCS-FR-037` | Mute **SHALL** suppress content unidirectionally for the muting
reader only, and **SHALL NOT** be observable by the muted party.

`LCS-FR-038` | ⛔ `BC-15` **SHALL NOT** disclose, by presence, absence, count,
ordering or timing, that a block or mute exists.

`LCS-FR-039` | Privacy of community membership visibility is A1's / A4's, not
A6's. A6 **SHALL NOT** redefine who can see a member list.

> ⛔ **Self-blocking clause.** `LCS-FR-035`…`038` consume a `BC-11`-owned
> aggregate across the `BC-15 → BC-11` edge that BC Map §7 does not record
> (**L292**). **Until an `ACCEPTED` ADR registers that edge, community content
> SHALL be treated as blocked rather than served unfiltered.** This is the
> **identical** requirement A2 v0.8 `LCF-AUTH-012` already carries, and A6
> **adds no new edge** — it inherits `LCF-ADR-007` (A2 **L1725**). Decision
> owner: ⛔ **Architecture Owner**.

---

## 15. Moderator authorization integration — DELEGATED

`LCS-FR-040` | Authorization for any moderation act **SHALL** be decided by
`BC-18` (`X-13`, `ID-1`; BC Map **L127**: `BC-18` *"owns … roles, permissions,
policy decisions"*), applied to `BC-13` moderator roles. ⛔ `BC-15` **SHALL NOT**
decide it.

`LCS-FR-041` | ⛔ A6 **SHALL NOT** mint a permission identifier. `AUTH-7.22`
closes the catalogue, and `ADR-0036` §7.1 records **zero** `PERM-*` repo-wide —
the same constraint A2 `LCF-AUTH-008` observes.

`LCS-FR-042` | ⛔ A6 **SHALL NOT** define an *"Authorized Community Moderator"*
role. `PRD-020` §9.3 lists that actor as **"Deferred to `BC-15` (V2)"**.

⭐⭐ **This is the most tempting over-reach in the entire A6 scope, and it is
refused.** `PRD-020` §9.3 appears to *hand* `BC-15` the community-moderator
actor. But a deferral is **not** an authorization to invent: defining a role
requires a `BC-18` permission bundle (`LCS-FR-041` forbids minting one), a
`CommunityRole` specification (A4's, and **A4 is itself a CANDIDATE** with
`LCG-DEC-001` open), and a Product Owner scope act. **Three prerequisites, none
satisfied.**

⛔ Recorded as **`LCS-DEC-001` — OPEN**, owner **Product Owner** jointly with the
`BC-13` owner, and expressly **coupled to A4's `LCG-DEC-001`**. A6 takes no part
of it. §26 `LCS-EDGE-007` records what breaks while it is open.

---

## 16. Enforcement integration — INTEGRATION ✅ LAWFUL AS WRITTEN

⭐ **This is the one substantive integration in A6 that requires no new edge and
is therefore implementable today.**

`LCS-FR-043` | `BC-15` **SHALL** consume `safety.EnforcementActionTaken`
(`TSF-EVT-002`) over the existing **`E-14`** edge (BC Map **L318**, **L433**),
whose consumer set already names `BC-15`. `PRD-020` `TSF-FR-029` confirms:
*"it does … so no amendment is needed."*

`LCS-FR-044` | Consumption **SHALL** be idempotent on `(caseId, actionId)`, per
`TSF-FR-123`: *"a duplicate delivery **MUST NOT** produce a second
restriction."*

`LCS-FR-045` | `BC-15` **SHALL** treat the payload as the **closed four-field
shape** `{personId, action, scope, until}` (**L318**). It **SHALL NOT** expect,
require or read a fifth field.

`LCS-FR-046` | `BC-15` **SHALL** self-restrict only. It **SHALL NOT** call back
into `BC-13`, consistent with BC Map **L286** (*"T&S never reaches into their
models"*) and its converse.

`LCS-FR-047` | A reversal **SHALL** be recognised as `TSF-EVT-002` with a
past-dated or nulled `until` (`TSF-FR-124`), **not** as a new event type.
`BC-15` **SHALL** restore eligibility accordingly.

`LCS-FR-048` | `BC-15` **SHALL** apply an action whose `scope` it does not
recognise by **failing closed** — withholding rather than ignoring.
⚠ The `scope` vocabulary is `BC-13`'s and A6 **enumerates none**.

⛔ **No self-blocking clause is required in §16, and none is added.** The edge
exists. ⭐ Recording *why* a section is unblocked matters as much as recording
why others are: it demonstrates the blocking clauses elsewhere are measured
findings, not a blanket disclaimer.

---

## 17. Appeals integration — DELEGATED IN FULL

`LCS-FR-049` | Appeals **SHALL** be handled entirely by `BC-13` under
`PRD-020` §16. ⛔ `BC-15` **SHALL NOT** accept, store, route or adjudicate one.

`LCS-FR-050` | `BC-15` **SHALL NOT** implement the invariant that *"appeal
cannot be decided by the enforcing actor"* (BC Map **L379**) — it is `BC-13`'s
invariant, and re-implementing it would duplicate an aggregate's rule.

`LCS-FR-051` | Where an author is shown a restriction notice (§11), any appeal
affordance **SHALL** hand off to `BC-13`. ⚠ The transport is undetermined —
`LCS-GAP-005`, coupled to `LCS-ADR-001`.

⚠ `PRD-020` **L1286** records that appeal intake **must remain reachable while
suspended**, because *"the appeal lives behind a login the suspension blocks"*,
and `BC-18` owns sessions. That is a `BC-13`/`BC-18` constraint. A6 records it
as **inherited context** and adds nothing.

---

## 18. Audit requirements — INTEGRATION ✅ LAWFUL

`LCS-FR-052` | `BC-15` **SHALL** emit audit facts for its own safety-relevant
acts over the existing **`E-20`** edge (*"All contexts → `BC-24`"*, BC Map
**L328**), fire-and-forget, outbox-backed.

`LCS-FR-053` | Auditable `BC-15` acts **SHALL** include: eligibility transition,
restriction applied, restriction reversed, fail-closed withholding, and content
served-or-withheld decisions at a sampling rate set by `BC-25` configuration.

`LCS-FR-054` | ⛔ Audit records **SHALL NOT** contain reporter identity
(`TSF-INV-009`), content bodies, or any `BC-13` case detail.

`LCS-FR-055` | `BC-15` **SHALL NOT** implement its own audit store. `BC-24`
owns audit. Domain never calls audit synchronously (**L328**).

⚠ **Open, disclosed.** Audit **retention** for these records is `BC-24`'s and is
not restated here; the `BC-15`-specific retention question is §22
(`LCS-DEC-002`).

---

## 19. Tenant / community isolation — OWNED

`LCS-FR-056` | `BC-15` **SHALL NOT** hold a `tenantId` or a `StudentRecordId`,
per `ID-2` (BC Map **L488**) and `ACCEPTED` `ADR-0078`, which determined the
community scope identifier carries **no** `tenantId`.

`LCS-FR-057` | Isolation **SHALL** be enforced by **community scope**, using the
opaque `communityId` shape `ADR-0078` settled — **not** by tenant partition.

`LCS-FR-058` | Every safety evaluation **SHALL** be scoped to the community in
which the content was published. Cross-community leakage of eligibility, block
effect or restriction state **SHALL NOT** occur.

`LCS-FR-059` | ⛔ `BC-15` **SHALL NOT** implement library-scoped moderation.
`F-1` and `F-2` establish it *cannot* be built in the Global band, and
`TSF-GAP-001`/`002` remain **OPEN** with `R-1`/`R-2`/`R-3` **unselected** and
`ADR-0070` **not opened**. A6 preserves all of that untouched.

⭐ **Note the precision required here.** The Product Owner's security list
demands *"cross-library isolation"*. In the Global band there is **no library
partition to isolate by** — `ADR-0078` settled that. A6 therefore delivers
cross-**community** isolation, and records that cross-**library** isolation of
`BC-15` content is **not expressible** in the current architecture. ⛔ Not
solved. `LCS-GAP-006`, **Architecture Owner**, expressly linked to
`TSF-GAP-001`/`002` and `ADR-0070`.

---

## 20. Safety failure behaviour — OWNED (fail closed)

`LCS-FR-060` | If eligibility state cannot be read → content **SHALL** be
`WITHHELD`.

`LCS-FR-061` | If block/mute state cannot be read → content **SHALL** be
`WITHHELD`. ⛔ **Not** served unfiltered.

`LCS-FR-062` | If the `E-14` consumer is lagging beyond the staleness budget →
write paths **SHALL** refuse (§13 `LCS-FR-034`), mirroring `TSF-FR-031`.

`LCS-FR-063` | If reporting is unavailable (including because `LCS-ADR-001b` is
unresolved) → content **SHALL** be `WITHHELD` (§12 `LCS-FR-030`). ⭐ **The `LCS-ADR-001b` clause of the antecedent is now discharged** (✅ CLOSED, `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md)), but ⚠⚠ **the requirement is NOT deleted or narrowed** — *"including because"* was always non-exhaustive, and every **operational** cause of reporting unavailability still triggers withholding in full.

`LCS-FR-064` | If A3 ranking fails → the feed **SHALL** fall back to
deterministic recent **eligible** posts, and **SHALL** retain authorization,
eligibility, block/mute and community-scope filtering **in full**. ⭐ Ranking is
the **only** fallible stage; no safety stage is ever degraded (§10).

`LCS-FR-065` | A fail-closed withholding **SHALL** be audited (§18) and
**SHALL** be distinguishable in telemetry from a `RESTRICTED` exclusion, so a
transport outage is never mistaken for a moderation wave.

---

## 21. Moderation event integration — INTEGRATION

`LCS-FR-066` | The **only** `BC-13` event `BC-15` consumes **SHALL** be
`TSF-EVT-002` `safety.EnforcementActionTaken` over `E-14`.

`LCS-FR-067` | ⛔ `BC-15` **SHALL NOT** consume `TSF-EVT-001`
`safety.AbuseReportFiled`. Measured: its consumer set is `BC-24`, `BC-22` only
(BC Map **L432**; `TSF-EVT-001`). `BC-15` is **not** a consumer, and
`TSF-FR-122` forbids that event carrying reporter identity or content.

`LCS-FR-068` | ⛔ A6 **SHALL NOT** define a new event type, name or version.
Event definition for `BC-15` content is A2's/A8's; safety event definition is
`BC-13`'s.

`LCS-FR-069` | Ordering **SHALL NOT** be assumed across `E-14` deliveries.
Idempotency (`LCS-FR-044`) plus `until`-based expiry (`LCS-FR-047`) **SHALL** be
sufficient for correctness under reordering.

---

## 22. Data retention / deletion — ⛔ OPEN OWNER DECISION

`LCS-FR-070` | `BC-15` **SHALL** retain `RESTRICTED` content rather than
hard-deleting it, so that a reversal (`LCS-FR-047`) can restore it.

`LCS-FR-071` | ⛔ **A6 states no retention period.** Not one number.

⛔ **`LCS-DEC-002` — OPEN.** Retention duration for restricted community
content, and the deletion behaviour on account closure, are **undetermined**.
Deciding requires: a **Privacy Owner** ruling (minor-heavy product, plausible
statutory retention), a `BC-25` configuration parameter (and
`CONFIGURATION_GUIDE.md` **L863** records that *adding a parameter is a PRD
amendment*), and consistency with `BC-24` audit retention. **Owner: Privacy
Owner, jointly with the Governance Owner.** A6 mints no `LCS-CFG-*` and takes
no part of this.

⚠ Interaction disclosed: right-to-erasure versus safety-evidence retention is a
genuine conflict on this product, and it is **raised, not resolved**.

---

## 23. Privacy requirements — INTEGRATION / OPEN

`LCS-FR-072` | Reporter identity **SHALL NOT** be stored, logged, cached,
indexed, emitted or rendered by `BC-15` (`TSF-INV-009`).

`LCS-FR-073` | Community content **SHALL NOT** be exposed outside its community
scope by any safety mechanism, including notices, audit records and telemetry.

`LCS-FR-074` | `BC-15` **SHALL NOT** build a behavioural profile of a person
from safety signals. ⚠ `PRD-020` `TSF-CFG-003` records that *"longer windows
turn detection into profiling"* — A6 inherits that caution and defines no window.

`LCS-FR-075` | Minor-specific privacy handling **SHALL** be `BC-10`/`BC-18`/
`BC-13`'s. ⛔ A6 defines no age rule.

⛔ **`LCS-DEC-003` — OPEN.** Whether a community author is entitled to know that
their content was *reported* (as distinct from *restricted*, which §11 grants)
is a **Privacy Owner** decision balancing transparency against `TSF-INV-009`
anonymity. A6 grants **only** restriction visibility and takes no position on
report visibility.

---

## 24. Rate limiting / abuse prevention — DELEGATED ⛔ gated

`LCS-FR-076` | Rate limiting **SHALL** use `BC-11`'s `RateLimitCounter`
(BC Map **L377**). ⛔ `BC-15` **SHALL NOT** introduce a second counter — the
constraint A2 `LCF-FR-034` / `LCF-FR-096` already carry.

`LCS-FR-077` | Report-filing rate limits **SHALL** be `BC-13`'s
(`TSF-FR-048` idempotency plus `BC-13` policy). ⛔ A6 sets no limit.

`LCS-FR-078` | ⛔ **A6 states no threshold, window or quota value.** Zero
numbers.

> ⛔ **Self-blocking clause.** `LCS-FR-076` consumes `BC-11`'s
> `RateLimitCounter` across the unregistered `BC-15 → BC-11` edge (**L292**).
> **Until an `ACCEPTED` ADR registers that edge, the rate-limited community
> operations SHALL be treated as blocked.** Inherited from A2 v0.8's identical
> clause; **no new edge is required by A6**. Decision owner:
> ⛔ **Architecture Owner** — `LCF-ADR-007`.

---

## 25. Security audit

| Requirement | Disposition | Authority |
|---|---|---|
| Authentication | **DELEGATED** — `BC-18` (`ID-1`) | A6 decides none |
| Authorization | **DELEGATED** — `BC-18` (`X-13`) | `LCS-FR-040` |
| Object-level authorization | **OWNED** — every content read authorized against community membership and eligibility per object, not per collection | `LCS-FR-020` |
| Membership validation | **DELEGATED** — A1's predicate; A6 defines none | mirrors `LCF-AUTH-001` |
| Community scope validation | **OWNED** | `LCS-FR-057`, `LCS-FR-058` |
| IDOR prevention | **OWNED** — opaque references; uniform refusals (`LCS-FR-025`) | `LCF-SEC-006` idiom |
| Cross-library isolation | ⛔ **NOT EXPRESSIBLE** in the Global band — `LCS-GAP-006` | `ID-2`, `F-1`, `F-2` |
| Cache isolation | **OWNED** — per-reader, per-community keys; §9 forbids global eligibility caching | `LCS-FR-015` |
| Search isolation | **OWNED** — `RESTRICTED`/`WITHHELD` excluded from indexing | `LCS-FR-027` |
| Event isolation | **OWNED** — no cross-community payload | `LCS-FR-073` |
| Notification isolation | **INTEGRATION** — A7 §; excluded content never notified | `LCS-FR-027` |
| Storage isolation | **DELEGATED** — `BC-29` via A2's `FileRef` discipline | `E-22`; ⚠ `BC-15` is **not** an `E-22` consumer |
| Rate limiting | **DELEGATED** ⛔ gated | §24 |
| Auditability | **INTEGRATION** over `E-20` | §18 |

`LCS-SEC-001` | ⛔ `BC-15` **SHALL NEVER** trust a client-supplied `LibraryId`,
`CommunityId`, membership status, role or `AuthorId`. Each **SHALL** be derived
server-side: community scope from the authorized request context, membership from
A1's predicate, role from A4/`BC-18`, author identity from the authenticated
`PersonId`.

`LCS-SEC-002` | A client-supplied `LibraryId` **SHALL** be rejected outright,
not merely ignored — `BC-15` is Global and has no lawful use for one (`ID-2`).

---

## 26. Edge cases

| ID | Case | Disposition | Class |
|---|---|---|---|
| `LCS-EDGE-001` | Enforcement arrives for content that does not exist yet | Restriction **SHALL** be recorded against the `personId` and applied on publish. `TSF-EVT-002` is person-scoped, not content-scoped | OWNED |
| `LCS-EDGE-002` | Enforcement arrives twice | Exactly one restriction — `LCS-FR-044`, `TSF-FR-123`, `TSF-AC-028` | INTEGRATION |
| `LCS-EDGE-003` | Reversal arrives before the action | Idempotent, `until`-driven; ordering not assumed — `LCS-FR-069` | OWNED |
| `LCS-EDGE-004` | `until` is null | ⛔ **SHALL NOT** be read as permanent, because `TSF-FR-124` uses a nulled `until` for **reversal**. `BC-15` **SHALL** treat null as *no active restriction* and audit the occurrence | ⚠ **OPEN** — `LCS-GAP-004` |
| `LCS-EDGE-005` | Author blocked by reader, then content restricted | Both filters apply; the reader's response **SHALL** be indistinguishable — `LCS-FR-025` | OWNED |
| `LCS-EDGE-006` | Post restricted, comments not | Comments withheld from feed, own eligibility unchanged — `LCS-FR-028` | OWNED |
| `LCS-EDGE-007` | Community needs a moderator before `LCS-DEC-001` resolves | ⛔ **No community-level moderation exists.** All moderation is platform-level `BC-13`. Disclosed, not worked around | ⛔ **OPEN** |
| `LCS-EDGE-008` | Reaction is reported | ⛔ **No subject type exists** (`TSF-FR-027` covers post and comment only) — `LCS-GAP-002` | ⛔ **OPEN** |
| `LCS-EDGE-009` | Official communication (A5) is reported | ⛔ Refused for want of a subject — `TSF-XC-034`, `TSF-GAP-010`; and A5's own existence is open | ⛔ **OPEN** |
| `LCS-EDGE-010` | `E-14` consumer offline for an extended period | Writes refuse on staleness (`LCS-FR-062`); reads withhold (`LCS-FR-060`); audited (`LCS-FR-065`) | OWNED |
| `LCS-EDGE-011` | Group (A4) content reported | ⛔ A4 is a **CANDIDATE** (`LCG-DEC-001` open); no subject type. Deferred | ⛔ **OPEN** |
| `LCS-EDGE-012` | Restricted author appeals successfully | Reversal restores eligibility (`LCS-FR-047`); `BC-15` re-evaluates per reader | INTEGRATION |

---

## 27. Acceptance criteria — Given / When / Then

⚠ **Every criterion below is `PENDING` and unverifiable today**, because §7,
§14 and §24 are self-blocked and Stage 3 is not conferred. They are written
measurably so that they become executable the moment their gates clear.

### 27.1 Enforcement consumption — executable once `BC-15` exists (no edge blocker)

| ID | Criterion | Status |
|---|---|---|
| `LCS-AC-001` | **Given** a published `ELIGIBLE` post, **when** `TSF-EVT-002` is consumed with a community `scope` naming its author, **then** the post becomes `RESTRICTED` and is absent from the feed candidate set (`LCS-FR-033`) | `PENDING` |
| `LCS-AC-002` | **Given** `TSF-EVT-002` delivered **twice**, **when** consumed, **then** exactly **one** restriction exists (`TSF-AC-028` parity) (`LCS-FR-012`) | `PENDING` |
| `LCS-AC-003` | **Given** a restriction, **when** a reversal arrives with a nulled `until`, **then** eligibility is restored and the transition is audited (`LCS-FR-047`) | `PENDING` |
| `LCS-AC-004` | **Given** an action whose `scope` is unrecognised, **when** consumed, **then** content is **WITHHELD**, not ignored, and the unrecognised value is audited (`LCS-FR-048`) | `PENDING` |
| `LCS-AC-005` | **Given** the `E-14` projection is staler than the budget, **when** a post is attempted, **then** the write is **REFUSED** (`TSF-FR-031` parity) (`LCS-FR-062`) | `PENDING` |

### 27.2 Filter ordering and ranking fallback

| ID | Criterion | Status |
|---|---|---|
| `LCS-AC-006` | **Given** a candidate set containing a `RESTRICTED` post, **when** the feed is built, **then** A3 ranking **never receives** that post — asserted on the input to ranking, not the output (`LCS-FR-027`) | `PENDING` |
| `LCS-AC-007` | **Given** A3 ranking throws, **when** the feed is requested, **then** deterministic recent **eligible** posts are returned **and** authorization, eligibility, block/mute and community-scope filters are all still applied (`LCS-FR-064`) | `PENDING` |
| `LCS-AC-008` | **Given** eligibility state is unreadable, **when** the feed is requested, **then** content is **WITHHELD** and the pipeline does **not** proceed to ranking (`LCS-FR-060`) | `PENDING` |

### 27.3 Isolation and leakage — mandatory cross-boundary tests

| ID | Criterion | Status |
|---|---|---|
| `LCS-AC-009` | **Given** two communities, **when** content is restricted in one, **then** no eligibility, restriction or block effect is observable in the other (`LCS-FR-073`) | `PENDING` |
| `LCS-AC-010` | **Given** a reader in community X, **when** they request any `BC-15` read path with a forged `communityId` for Y, **then** the request is refused and the refusal is indistinguishable from *not found* (`LCS-SEC-001`) | `PENDING` |
| `LCS-AC-011` | **Given** any `BC-15` record, projection, cache entry, index document, event payload or audit record, **when** inspected, **then** it contains **no** `tenantId` and **no** `StudentRecordId` (`ID-2`, `ADR-0078`) (`LCS-FR-056`) | `PENDING` |
| `LCS-AC-012` | **Given** a client-supplied `LibraryId`, **when** any `BC-15` endpoint receives it, **then** the request is **rejected** (`LCS-SEC-002`) | `PENDING` |
| `LCS-AC-013` | **Given** a cache populated for reader A, **when** reader B requests the same community, **then** B's eligibility is evaluated independently and A's block state does not affect B (`LCS-FR-015`) | `PENDING` |

### 27.4 Privacy and anonymity

| ID | Criterion | Status |
|---|---|---|
| `LCS-AC-014` | **Given** a filed report, **when** every `BC-15` store, log, cache, index, event and audit record is inspected, **then** the reporter's `PersonId` is **absent** (`TSF-INV-009`, `LCS-FR-072`) | `PENDING` — ✅ **no longer blocked; now genuinely testable.** `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md) closed `LCS-ADR-001b`, and it closed it in a way that makes this criterion **structurally easy** rather than merely reachable: because filing goes **directly** to `BC-13`'s command surface, `BC-15` is never a party to the call and therefore never holds the reporter's identity to begin with. ⚠ **Still `PENDING`, not passing** — an acceptance criterion is verified against a running implementation at Stage 5/6, and ⛔ no implementation exists. Recording it as passing now would be a fabrication |
| `LCS-AC-015` | **Given** restricted content, **when** the **author** views it, **then** they see the fact of restriction and an opaque reference, and **no** reporter identity, evidence, severity or strike count (`LCS-FR-023`) | `PENDING` |
| `LCS-AC-016` | **Given** restricted content, **when** a **non-author** views it, **then** the response is byte-indistinguishable from `WITHHELD` and from never-existed (`LCS-FR-025`) | `PENDING` |

### 27.5 Blocked-path criteria — verifying the blocks themselves

⭐ These assert the **self-blocking** is real, which is what makes A6 auditable
rather than aspirational.

| ID | Criterion | Status |
|---|---|---|
| `LCS-AC-017` | **Given** reporting is unavailable, **when** the community product is assembled, **then** community content is `WITHHELD` and **no** reporting path is exposed (`LCS-FR-030`) | `PENDING` — ⚠ **antecedent REWRITTEN, criterion RETAINED.** `AO-4` closed `LCS-ADR-001a` and `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md) closed `LCS-ADR-001b`, so the original antecedent (*"Given `LCS-ADR-001b` is unresolved"*) can no longer be constructed. ⭐ **The criterion is therefore re-stated against the general fail-closed condition rather than deleted** — testing withholding behaviour under reporting unavailability remains required, and is now exercised by fault injection instead of by an open decision. ⛔ **Not** recorded as passing |
| `LCS-AC-018` | **Given** `LCF-ADR-007` is unresolved, **when** a feed read is attempted, **then** content is `WITHHELD` rather than served without block filtering (`LCS-FR-061`) | `PENDING` |
| `LCS-AC-019` | **Given** the repository as it stands, **when** `BC-15` code is searched, **then** it contains **no** `ModerationCase`, `AbuseReport`, `StrikeRecord` or `Appeal` type, and **no** moderation queue (`LCS-FR-009`) | `PENDING` |
| `LCS-AC-020` | **Given** A6, **when** its text is measured, **then** it defines **zero** moderator roles, **zero** severities, **zero** thresholds, **zero** SLAs, **zero** permission identifiers and **zero** policy values (`LCS-FR-078`) | ✅ **VERIFIABLE NOW** — §28 |

---

## 28. Self-measurement — what A6 minted

| Quantity | Count | Verification |
|---|---|---|
| Aggregates created | **0** | No aggregate root defined; §9 states content state on **existing** A2/A4 aggregates |
| Bounded contexts created | **0** | Count remains **31** |
| Bounded-context edges created | **0** | ✅✅ **Now the ratified answer for BOTH halves.** Owner ruling **AO-4** (2026-08-31) selected Option B and ⛔ **forbade** a `BC-15` → `BC-13` edge; `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md) then closed the filing half **without** minting one either, because filing is `BC-13`'s **internal command surface** (`PRD-020` **§21.3 L1800**), not an integration. ⭐ **A6 therefore ends where it began — at zero — and the zero is now approved twice over rather than pending.** The **inherited** `LCF-ADR-007` was separately **ACCEPTED** by **AO-1** and admitted as **`E-28`** in BC Map §15.1 — ⚠ that edge belongs to A2, and A6 still mints nothing. ✅ `LCS-ADR-001b` is **CLOSED** with **0** new edges, **0** new events and **0** Rank 1–5 modifications |
| ADRs created | **0** | ⚠ **Stale as written — corrected here.** `ADR-0083` is no longer free: it was **created and Accepted 2026-08-31** as the record of these 22 Owner rulings, and is registered in `ADR-INDEX.md`. The ADR total is **74**. ⭐ A6 still creates **zero** ADRs — `ADR-0083` is the *governance* record of the rulings, not an A6 artefact |
| Permission identifiers | **0** | `AUTH-7.22`, `ADR-0036` §7.1 |
| Roles | **0** | `LCS-FR-042` refuses the tempting one |
| Moderation enums | **0** | §9's three values are **content lifecycle**, not moderation outcomes |
| Severities / categories / SLAs | **0** | All `BC-13`'s |
| Numeric policy values | **0** | No threshold, window, quota, retention period or rate limit |
| `LCS-CFG-*` identifiers | **0** | `CONFIGURATION_GUIDE.md` **L863** |
| Events defined | **0** | `LCS-FR-068` |
| `BC-13` aggregates read or held | **0** | `LCS-FR-010`, `LCS-FR-011` |
| Existing documents modified | **0** | A6 is a new file only |

### 28.1 Identifier register

| Register | Count | Range |
|---|---|---|
| `LCS-G-*` | 6 | `001`–`006` |
| `LCS-NG-*` | 6 | `001`–`006` |
| `LCS-AP-*` | 7 | `001`–`007` |
| `LCS-OWN-*` | 6 | `001`–`006` |
| `LCS-FR-*` | 78 | `001`–`078` |
| `LCS-SEC-*` | 2 | `001`–`002` |
| `LCS-EDGE-*` | 12 | `001`–`012` |
| `LCS-AC-*` | 20 | `001`–`020` |
| `LCS-GAP-*` | 6 | `001`–`006` |
| `LCS-DEC-*` | 3 | `001`–`003` |
| `LCS-ADR-*` | 1 | `001` |
| **Total** | **147** | across **11** registers |

⛔ All **PROPOSED and UNRATIFIED**. The `LCS-` prefix is **not registered**;
registration is a Governance Owner act not exercised here.

---

## 29. Open items — routed, not closed

### 29.1 Architecture decisions required

| ID | Requirement | Owner | State |
|---|---|---|---|
| **`LCS-ADR-001`** | ✅✅ **FULLY RESOLVED — both halves closed, and each by a different mechanism.** ✅ **`LCS-ADR-001a` — moderation READS — CLOSED** by Owner ruling **AO-4** (2026-08-31). Option **(b)** was selected: an **existing-edge-fed local projection** on the `ADR-0065` pattern, reusing `E-14` (**L318**), which already lists `BC-15`. ⛔ **No `BC-15` → `BC-13` edge was created**, so `F-3` is **preserved exactly as `ADR-0065` intended** and the `ADR-0055` §3 / `ADR-0059` refusals are **honoured, not overturned**. ⭐⭐ **A6's §7.3 analysis is vindicated in full:** it predicted this decision *"may well be answered by refusal"* of the edge, named option (b) as the alternative, and declined to rank either — and the Architecture Owner chose precisely the option A6 named without recommending. ✅✅ **`LCS-ADR-001b` — report FILING — CLOSED 2026-08-31 by `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md), and closed by a correction to this row's own reasoning.** ⭐ **Every measurement this row asserted was re-run and CONFIRMED:** `E-14` is inbound (`BC-13` → … `BC-15`); rows targeting `BC-13` = **0**; rows sourced from `BC-15` = **0**; all-context edges `E-18`/`E-19`/`E-20`/`E-23` target `BC-19`/`BC-25`/`BC-24`/`BC-22` and ⛔ **none targets `BC-13`**. ⭐⭐ **The numbers were right; the question was wrong.** This row searched for a **cross-context carrier** for filing. `PRD-020` **§21.3 L1800** states that no such carrier may exist — `BC-13` has *"no published inbound edge (`F-3`)"* **by design**, because `FileAbuseReport` is *"internal to the safety application, **not a cross-context API**"* with the actor *"**Any authenticated person**"*. ✅ **A report is filed by a person against `BC-13` directly; `BC-15` contributes only the subject reference** it already declares it never owns (§8: *"`AbuseReport` | `BC-13` | ⛔ Never held"*). ⭐ **Symmetry proof:** cluster peers `BC-11` and `BC-12`, both holding reportable content, also have **0** edges to `BC-13`. ⚠ The same-rank `L2` / Social-cluster concerns raised here are discharged as moot — **AO-7** extended the declared cluster to `BC-11`/`12`/`13`/**`BC-15`** (Matrix **L90**/**L652**), but no transport was needed in the first place. ⭐ **A4's `LCG-ADR-002` was the same structural finding and is CLOSED on a parallel measurement** — BC Map §7 sources the source cell in **column 3**, and five edges carry the wildcard source *"All contexts"*, so `BC-15` publishes lawfully over `E-20`/`E-23` under §9 + §9.1. ⛔ A6 still mints **no** edge, claims **no** invented carrier, and `LCS-FR-030` is **not** lifted as a rule — only its antecedent is discharged | **Architecture Owner** | ✅ **001a CLOSED · 001b CLOSED** |
| *(inherited)* `LCF-ADR-007` | `BC-15 → BC-11` consumption edge | **Architecture Owner** | ⛔ **OPEN** — A6 adds no new requirement |

### 29.2 Gaps

| ID | Gap | Owner |
|---|---|---|
| `LCS-GAP-001` | `PRD_REGISTRY.md` §11.4's verification line is falsified by A6/A7/A8 existing | **Governance Owner** |
| `LCS-GAP-002` | `AbuseReport` subject register lacks reaction, community, group, official-communication types | **`BC-13`/`PRD-020` owner** (⚠ partially `TSF-GAP-010`) |
| `LCS-GAP-003` | Evidence-snapshot responsibility for community content, given `F-3` and `F-4` | **Architecture Owner** + `BC-13` owner |
| `LCS-GAP-004` | Null `until` semantics ambiguity | **`BC-13`/`PRD-020` owner** |
| `LCS-GAP-005` | Author-notice and appeal hand-off surface | **Architecture Owner** |
| `LCS-GAP-006` | Cross-**library** isolation of `BC-15` content is not expressible in the Global band | **Architecture Owner** (⚠ `TSF-GAP-001`/`002`, `ADR-0070`) |

### 29.3 Owner decisions

| ID | Decision | Owner |
|---|---|---|
| `LCS-DEC-001` | Whether an *Authorized Community Moderator* exists, and its authority | **Product Owner** + `BC-13` owner (⚠ coupled to A4 `LCG-DEC-001`) |
| `LCS-DEC-002` | Retention/deletion for restricted community content | **Privacy Owner** + Governance Owner |
| `LCS-DEC-003` | Whether an author learns their content was *reported* | **Privacy Owner** |

### 29.4 ⛔ Preserved untouched — `PRD-020` items A6 does NOT close

`TSF-GAP-001`, `TSF-GAP-002`, `TSF-GAP-003` *(resolved by `ADR-0065`, unchanged)*,
`TSF-GAP-005`, `TSF-GAP-006`, `TSF-GAP-009`, `TSF-GAP-010`, `R-1`/`R-2`/`R-3`
**unselected**, `ADR-0070` **not opened**, `ADR-0075` **execution-blocked**.

⭐ **A6 touches none of them.** `TSF-GAP-006` in particular asks whether `BC-15`
is pulled into V1 — `PRD-020` **L599** records that as *"a Rank 1 scope act"*.
A6 does **not** perform it; `BC-15` remains **V2**.

---

## 30. Future / V2 scale — deliberately deferred

| Item | Disposition |
|---|---|
| Automated or ML content classification | ⛔ **FUTURE.** `BC-27` AI exists but `E-26` targets `BC-26`/`BC-23` only — no `BC-15` path. No infrastructure introduced |
| Community-level delegated moderation | ⛔ **FUTURE**, gated on `LCS-DEC-001` |
| Proactive scanning / hash matching | ⛔ **FUTURE.** Would require a `BC-29` path `BC-15` does not have |

---

## 31. Verification of this document

| Assertion | Result |
|---|---|
| Existing documents modified | ✅ **0** |
| `BC-13` aggregates claimed | ✅ **0** |
| Moderation decisions taken | ✅ **0** |
| Roles / permissions / thresholds / severities minted | ✅ **0** |
| Edges minted | ✅ **0** (1 raised, 1 inherited) |
| ADRs minted | ✅ **0** |
| Owner decisions taken | ✅ **0** (3 raised) |
| `PRD-020` items closed | ✅ **0** |
| Lifecycle stages conferred | ✅ **0** |
| Unregistered-edge requirements left unconditional | ✅ **0** — all self-blocked |

---

| Field | Value |
|---|---|
| **Version** | v0.1 |
| **Date** | 2026-08-25 |
| **Status** | **DRAFT** — NOT FROZEN, NOT CONFERRED, NOT BASELINED |
| **Part of** | `PRD-021A` (authorized by `D-A`; A6 authorized as a **part**, not a standalone PRD) |
| **Determination** | An **integration contract** — ⭐ **and the final measurement narrows what that contract contains.** `BC-13`/`PRD-020` retains every safety decision — ✅ **Owner ruling **AO-4** (2026-08-31) confirms this by construction**, since Option B has `BC-15` hold only a **local projection** of state that remains `BC-13`'s. ✅ Moderation **reads** are lawful as an `E-14`-fed local projection (`LCS-ADR-001a`, `ADR-0065` pattern, **zero** new edges). ✅✅ Report **filing** is **no longer self-blocked**: `ACCEPTED` [`ADR-0084`](../../00-governance/adr/ADR-0084-bc15-outbound-carriers-measured-option-b-selected.md) closed `LCS-ADR-001b` on the finding that filing is a **person invoking `BC-13`'s own command surface** (`PRD-020` **§21.3 L1800**) — ⛔ **not** a `BC-15` integration, so the correct edge count is **zero**. ⭐ The measurements that appeared to block it were **all correct and all re-confirmed**; the inference from them was inverted. Block/mute and rate limiting are unblocked by **AO-1**, admitted as **`E-28`** (A2's edge, inherited — A6 mints nothing). Enforcement consumption over `E-14` is ✅ **lawful as written**, as it always was. ⚠ **A6 ends having created zero edges and zero events** |
