<!--
  PRD-021A — PART A8 — TECHNICAL & PRODUCTION ARCHITECTURE
  DRAFT v0.1

  AUTHORITY NOTE — READ BEFORE ANYTHING ELSE
  ==========================================
  This is PART A8 of the authorized PRD-021A. It is NOT a standalone PRD and
  NOT an amendment to any Rank 1-6 architecture document.

  PRD_REGISTRY.md §11.4 recorded, under decision D-A:
      "A8 | ⛔ NO STANDALONE PRD — NOT AUTHORIZED |
       Enterprise Architecture · Module Dependency Matrix · ADR-0001 ·
       existing A1-A5 technical sections · existing Stage-3 record"
  That refusal stands and is honoured. See §0.4.

  THE CENTRAL MEASURED FINDING OF A8
  ==================================
  PRD-021A is a V2 capability. A2 `LCF-FR-024` fixes this, on three
  unanimous Rank 1-4 authorities (MASTER_PRD L92, EA L970, BC Map L119/L147).

  This single fact determines the whole of A8, because the EA version tags
  make the V2 platform band available and the V3 band unavailable:

    AVAILABLE at V2   EVENT PLATFORM (EA L1294) · Transactional Outbox
                      (L1305) · Cache Service (L1882) · Rate Limiter Service
                      (L1883) · Idempotency Service (L1892) · Job Runtime
                      (L1865) · Fan-Out Strategy (L1854) · Read Replicas
                      (L2075) · Consumer Groups, DLQ, Schema Registry
    ALREADY V1        Realtime Engine (L1847) · File Pipeline (L1873) ·
                      Storage Abstraction (L1881) · Row Level Isolation
                      (L2081) · Pagination & Filtering Standards (L379)
    ⛔ NOT AVAILABLE  Realtime Scaling & Backpressure (L1855, V3) ·
                      Ordering Guarantees (L1301, V3) · Event Replay (V3) ·
                      Poison Message Handling (V3) · Schema Evolution (V3) ·
                      Partitioning & Sharding (L2077, V3) · Query Cache and
                      Distributed Cache (L2091-2092, V3) · Multi-Region
                      Replication (L2078, Future)

  A8 therefore introduces NO new infrastructure. Every technical need of
  A1-A7 is met by a capability the EA already enumerates in the V1 or V2
  band. That is the finding, and it is why A8 is short on invention.

  THE CROSS-PART CONFLICT A8 EXISTS TO FIND
  =========================================
  A2 `LCF-FR-104` closes the community event set at SIX and states
  "A seventh SHALL require a PRD amendment."
  A5 `LCO-FR-113` obeyed it and proposed no seventh.
  A7 §3 proposes SEVEN facts `LCN-EVT-001`..`007`, of which four have no
  counterpart in A2's six, and three collide with A2 names inexactly.
  A8 surfaces this as `LCT-CONF-001` and routes it. A8 does NOT resolve it:
  amending A2's event set is A2's act, not A8's.

  WHAT A8 CREATES
  ===============
  Edges: ZERO.  Bounded contexts: ZERO.  Aggregates: ZERO.
  Events: ZERO (A8 registers none and proposes none).
  Permissions: ZERO.  Roles: ZERO.  Numeric budgets: ZERO.
  ADRs: ZERO written (2 required and routed).
  Infrastructure components: ZERO.
  Prefix: LCT- (measured 0 occurrences repo-wide before minting).
-->

# PRD-021A — PART A8

## Technical & Production Architecture

| | |
|---|---|
| **Document** | `PRD-021A_A8_TECHNICAL_AND_PRODUCTION_ARCHITECTURE_DRAFT_v0.1.md` |
| **Part of** | PRD-021A — Library Community (authorized; parts A1–A8) |
| **Version** | `v0.1` |
| **Status** | ⚠ **DRAFT** — not reviewed, not aligned, not frozen |
| **Stage** | Stage 1 output. ⛔ Stage 3 **NOT** conferred for any PRD-021A part |
| **Scope band** | **V2**, inherited from A2 `LCF-FR-024` (§7.1) |
| **Identifier prefix** | `LCT-` — ⚠ **not yet registered** under `PRD_LIFECYCLE.md` §5 rule 3 |
| **Precedes** | A1 v0.2, A2 v0.8, A3 v0.6, A4 v0.1, A5 v0.1, A6 v0.1, A7 v0.1 |

---

## 0. Document control

### 0.1 What this document is

A8 is the **cross-part technical integration architecture** for PRD-021A. Its
subject is the seams between A1→A2→A3→A4→A5→A6→A7 and the seams between
PRD-021A as a whole and the platform architecture that already exists.

It is a **reference-and-gap** document. Where the Enterprise Architecture, the
Bounded Context Map, the Module Dependency Matrix or `ADR-0001` already decide
a question, A8 cites the decision and stops. Where nothing decides a question
that PRD-021A actually needs decided, A8 records a gap and routes it.

### 0.2 What this document creates — the self-measurement

| Class | Count | Note |
|---|---|---|
| New bounded contexts | **0** | Count remains 31 |
| New context edges | **0** | §7 of the BC Map is untouched; 26 edges remain 26 |
| New aggregates | **0** | §10 explicitly refuses to duplicate any |
| New domain events | **0** | A8 registers none and proposes none — §15 |
| New permissions | **0** | `AUTH-7.22` closes the catalogue |
| New roles | **0** | |
| New infrastructure components | **0** | ⭐ the central finding — §5.4 |
| New numeric budgets / thresholds | **0** | §23 refuses to mint latency targets |
| ADRs written | **0** | 2 required, routed in §41 |
| Existing files modified | **0** | A8 is a new file only |

### 0.3 Prohibited technologies — explicit compliance statement

The instruction authorizing A8 prohibits eight classes of infrastructure. A8
introduces **none** of them, and in every case the EA independently agrees:

| Prohibited | A8 introduces it? | Independent EA position |
|---|---|---|
| Kubernetes | ⛔ No | Not enumerated anywhere in the EA tree |
| Microservice mesh | ⛔ No | `ADR-0001` — modular monolith, scope *whole platform* |
| Distributed ranking cluster | ⛔ No | A3 is an in-process scorer; EA has no such node |
| ML ranking infrastructure | ⛔ No | A3 §14 defers all learned signals; `ML & Prediction Services` is AI-platform-owned |
| Dedicated streaming platform | ⛔ No | `EVENT PLATFORM (V2)` is the one backbone (BC Map `LCF-XC-022`) |
| Sharding | ⛔ No | `Partitioning & Sharding (V3)` — EA L2077, out of band |
| Multi-region | ⛔ No | `Multi-Region Replication (Future)` — EA L2078 |
| Unnecessary distributed systems | ⛔ No | §5.4 |

`LCT-XC-001` | A8 SHALL NOT introduce any infrastructure component that the
Enterprise Architecture does not already enumerate in the **V1 or V2** band.

`LCT-XC-002` | A8 SHALL NOT depend on any capability the EA tags **V3** or
**Future**. Where PRD-021A appears to need one, A8 SHALL record a gap rather
than assume availability. Four such cases exist — §13.3, §15.6, §20.4, §24.3.

### 0.4 Reconciliation with the D-A refusal

`PRD_REGISTRY.md` §11.4 (L750–760) recorded A8 as **"⛔ NO STANDALONE PRD —
NOT AUTHORIZED"**, and named the owners that keep the scope: *Enterprise
Architecture · Module Dependency Matrix · `ADR-0001` · existing A1–A5
technical sections · existing Stage-3 record.*

That refusal is **not contradicted by this document**, because the refusal was
of a standalone PRD that would **own** platform architecture. A8 owns none.
Every one of the five named owners retains its scope in full — §6.1 tabulates
this owner by owner, and §43 verifies it.

⚠ **Disclosure.** §11.4's verification line reads
`ls docs/30-product/social-graph/ | grep -E "_A[678]_"` *returns nothing*. With
A6, A7 and A8 present that line is now **false**. A6 already routed this as
`LCS-GAP-001` to the **Governance Owner**. A8 does not repair the registry —
editing it is a governance act, not an architecture act.

### 0.5 Ownership vocabulary

Every section of A8 is classified with exactly one of five labels, per the
authorizing instruction:

| Label | Meaning |
|---|---|
✅ **OWNED BY PRD-021A** | PRD-021A decides it, and no existing owner does |
🔗 **INTEGRATION** | An existing owner decides it; PRD-021A states how it consumes the decision |
📤 **DELEGATED** | An existing owner decides it and PRD-021A adds nothing at all |
⛔ **OPEN OWNER DECISION** | Nobody has decided it; A8 records and routes it |
🔮 **FUTURE / V2+ SCALE** | Deliberately out of the current band |

`LCT-INV-001` | A8 SHALL NOT convert an integration dependency into ownership.
Where A8 must describe a capability owned elsewhere, it SHALL cite the owner's
identifier and SHALL NOT restate the capability's rules as its own.

---

## 1. Executive Summary

✅ OWNED BY PRD-021A — *this summary is A8's own*

A8 examined the seven sibling parts and the platform architecture and reached
one governing conclusion:

> **PRD-021A needs no new architecture. It needs seven seams specified and
> nine gaps routed.**

The reason is the version band. A2 `LCF-FR-024` fixes PRD-021A at **V2**, and
the EA's V2 band already contains every runtime capability the community
feature set requires: a transactional outbox, an event bus with consumer
groups and a dead-letter queue, a cache service, a rate limiter, an
idempotency service, a job runtime, a fan-out strategy and read replicas. The
V1 band already contains the realtime engine, the file pipeline, storage
abstraction, row-level isolation and pagination standards.

`LCT-FR-001` | A8 SHALL treat the EA V1+V2 band as the complete inventory of
available infrastructure, and SHALL specify only integration contracts on top
of it.

**The four findings that matter:**

1. ⭐ **A cross-part event conflict exists and is material.** A2 closed the
   event set at six with an explicit amendment clause; A7 proposes seven facts,
   four of them genuinely new. This is not a wording problem — it is two parts
   of one PRD asserting incompatible contracts. `LCT-CONF-001`, §15.3.
2. ⭐ **The event envelope collides with the tenancy rule.** BC Map §9.1 L450
   makes `tenantId` **mandatory on every domain event**; rule `ID-2` (L488)
   forbids `BC-15` from ever holding one. `ADR-0078` resolved the *scope
   identifier* question but did not amend L450. `LCT-CONF-002`, §15.4 — ✅ **RESOLVED by AO-6, 2026-08-31** via BC Map **§15.4** `EV-1`…`EV-4`. ⚠ **BC Map L450 itself remains unamended and is deliberately left so:** AO-6 authorised recording the envelope exception, not editing Rank 4 prose, and Governance authorization item 6 forbids modifying frozen/Rank-sensitive documents absent an explicit requirement. ⭐ The residue is now a **wording** residue, not a rule conflict.
3. ⭐ **Projection rebuild is required but its mechanism is V3.** BC Map L453
   requires every projection to be rebuildable from the log; `Event Replay` is
   **V3** (EA). A2's feed projection is required to be rebuildable
   (`LCF-NFR-006`). `LCT-GAP-004`, §15.6.
4. ⭐ **Two safety paths in PRD-021A have no registered transport.** A6's
   reporting path is self-blocked (`LCS-ADR-001`, `BC-13` has zero inbound
   edges) and `BC-15` is neither an `E-22` media consumer nor an `E-21` search
   producer. A8 records these as capability gaps and refuses to route around
   them. §19, §21.

`LCT-FR-002` | A8 SHALL NOT resolve any of the four findings above. Each
belongs to an owner named in §41.

---

## 2. Problem Statement

✅ OWNED BY PRD-021A

Seven parts were drafted independently against a shared architecture. Each was
internally disciplined; none was responsible for the seams. Four failure modes
follow from that, and A8 exists for them:

| # | Failure mode | Concrete instance found |
|---|---|---|
| 1 | **Contract divergence** — two parts specify the same fact differently | A2 `community.CommentPublished` vs A7 `community.CommentAdded` (§15.3) |
| 2 | **Capacity assumption** — a part assumes a platform capability that is out of band | Projection rebuild vs `Event Replay (V3)` (§15.6) |
| 3 | **Silent ownership creep** — an integration hardens into ownership | Prevented by `LCT-INV-001`; audited in §43 |
| 4 | **Unrouted seam** — no part owns a question, so nobody answers it | Cache key composition for a non-tenant-scoped context (§20.3) |

`LCT-FR-003` | For every seam between two PRD-021A parts, A8 SHALL name the
owning part on each side and SHALL NOT introduce a third owner.

---

## 3. Goals

✅ OWNED BY PRD-021A

| ID | Goal |
|---|---|
| `LCT-G-001` | Specify each A1→A7 integration seam as a contract with a named owner on each side |
| `LCT-G-002` | Map every PRD-021A technical need onto an EA capability that already exists in the V1 or V2 band |
| `LCT-G-003` | Detect and route every cross-part contradiction, without resolving any |
| `LCT-G-004` | Guarantee that isolation, authorization and safety filtering survive every degraded mode |
| `LCT-G-005` | Keep V1/V2 startup-friendly: no new operational surface, no new runtime component |
| `LCT-G-006` | Leave every existing owner's scope byte-for-byte intact |

---

## 4. Non-Goals

| ID | Non-goal | Why |
|---|---|---|
| `LCT-NG-001` | Restating the Enterprise Architecture | EA is Rank 6 and authoritative; A8 cites |
| `LCT-NG-002` | Restating the Module Dependency Matrix rules | `L2` is the Matrix's; A8 cites (§24.1) |
| `LCT-NG-003` | Re-deciding `ADR-0001` | *Scope: whole platform*, Accepted |
| `LCT-NG-004` | Duplicating any per-part technical section | A2 §22–§25, A3 §20–§25, A5 §19–§24, A6 §19–§25, A7 §15–§22 stand as written |
| `LCT-NG-005` | Owning ranking logic | A3's, entirely — §12.1 |
| `LCT-NG-006` | Owning moderation | `BC-13`/`PRD-020`'s — A6 §6.1 |
| `LCT-NG-007` | Owning notification delivery | `BC-22`'s — A7 §§10–13 |
| `LCT-NG-008` | Selecting a pagination convention | Open as `LCF-ADR-003` — §18 |
| `LCT-NG-009` | Minting latency, throughput or capacity numbers | §23 |
| `LCT-NG-010` | Choosing a database engine, broker product or cache product | Storage Abstraction (EA L1881) is a hexagonal port; product choice is Platform Engineering's |

---

## 5. Architecture Principles

### 5.1 Inherited, not authored

📤 DELEGATED — `ADR-0001`, EA §10, Matrix §L-rules

`LCT-FR-004` | PRD-021A SHALL be implemented inside the existing **modular
monolith with a pure-Dart shared kernel** (`ADR-0001`, Accepted, *Scope: whole
platform*). A8 selects no alternative style and proposes no extraction.

`LCT-FR-005` | PRD-021A SHALL comply with EA §10.1 ownership rules, §10.2
multi-tenant invariants, §10.3 version-tag semantics and §10.4 naming
conventions without restating them.

### 5.2 A8's own principles

✅ OWNED BY PRD-021A

| ID | Principle | Consequence |
|---|---|---|
| `LCT-AP-001` | **Cite, do not copy.** | A rule that exists upstream is referenced by identifier and line, never paraphrased into a new `SHALL` |
| `LCT-AP-002` | **Degradation never widens visibility.** | Every failure mode in §27 loses freshness, richness or ordering — never a filter |
| `LCT-AP-003` | **Isolation is structural, not procedural.** | Enforced by key composition and index naming (§9), so forgetting a predicate fails loudly |
| `LCT-AP-004` | **Filters upstream of scoring.** | A3 `LCR-INV-005`: steps 4–5 remove, 6–9 reorder, nothing adds |
| `LCT-AP-005` | **One transport.** | The `PL` mechanism of BC Map §10 / `EVENT PLATFORM` is the only event transport (A2 `LCF-XC-022`) |
| `LCT-AP-006` | **A conflict is a finding, not a task.** | A8 surfaces and routes; owners decide |
| `LCT-AP-007` | **Startup-friendly by default.** | Nothing in A8 adds a process, a cluster or an operational runbook |

### 5.3 The V2 band determination

🔗 INTEGRATION — A2 `LCF-FR-024`; EA version tags

`LCT-FR-006` | A8 SHALL inherit A2's V2 scoping. It SHALL NOT re-argue the
band and SHALL NOT present any requirement as V1-deliverable.

`LCT-FR-007` | Every platform dependency A8 relies on SHALL be recorded with
its EA line and version tag, per A2 `LCF-FR-025`, so a V1 reader can see why
the dependency is not yet available.

### 5.4 ⭐ The zero-new-infrastructure finding

✅ OWNED BY PRD-021A — *the load-bearing claim of A8*

`LCT-FR-008` | A8 SHALL introduce **no new infrastructure component**. Every
technical need of A1–A7 maps to an existing EA capability:

| PRD-021A need | Existing EA capability | Tag | Available at V2? |
|---|---|---|---|
| Publish community facts atomically | `Transactional Outbox` | V2 | ✅ |
| Deliver facts to consumers | `Event Bus`, `Consumer Groups` | V2 | ✅ |
| Handle undeliverable facts | `Dead Letter Queue` | V2 | ✅ |
| Validate fact shape | `Event Schema Registry`, `Contract Validation` | V2 | ✅ |
| Cache feed pages | `Cache Service` | V2 | ✅ |
| Limit posting rate | `Rate Limiter Service` | V2 | ✅ |
| Deduplicate writes | `Idempotency Service` | V2 | ✅ |
| Run projection updates | `Job Runtime` | V2 | ✅ |
| Deliver realtime updates | `Realtime Engine`, `Connection Management` | V1 | ✅ |
| Fan out realtime updates | `Fan-Out Strategy` | V2 | ✅ |
| Store attachments | `File Pipeline`, `Storage Abstraction`, `Signed URLs` | V1 | ✅ |
| Scan attachments | `Virus & Malware Scan` | V2 | ✅ |
| Isolate rows by tenant | `Row Level Isolation` | V1 | ✅ |
| Serve reads off primary | `Read Replicas` | V2 | ✅ |
| Paginate | `Pagination & Filtering Standards` | V1 | ⚠ node exists, content unspecified — §18 |

⭐ **Fifteen needs, fifteen existing capabilities, zero additions.** This is
the strongest available evidence that PRD-021A is an application of the
platform rather than an extension of it — and it is why A8 is a short document
with a long conflict register rather than the reverse.

---

## 6. Ownership Boundaries

### 6.1 What A8 does not own — owner by owner

📤 DELEGATED

`PRD_REGISTRY.md` §11.4 named five owners that keep A8's subject matter. Each
retains it in full:

| Owner | Retains | A8's only relationship |
|---|---|---|
| **Enterprise Architecture** (Rank 6) | The capability tree, every version tag, §10 governing rules | Cites capabilities and tags; adds no node |
| **Module Dependency Matrix** | Rule `L2`, cluster definitions, the module tree (L480–483) | Cites `L2` and records that `BC-15` has no module (§24.1) |
| **`ADR-0001`** | Modular monolith, shared kernel | Cites; proposes no extraction |
| **A1–A5 technical sections** | A2 §22–§25, A3 §20–§25, A5 §19–§24 | References; restates nothing |
| **Existing Stage-3 record** | Its six checks, `D-1`…`D-6`, `R-1`…`R-3` | Adds no finding to it and confers no stage |

Additionally retained in full, none of it A8's:

| Object | Owner | Authority |
|---|---|---|
| `ModerationCase`, `AbuseReport`, `EnforcementAction`, `StrikeRecord`, `Appeal` | `BC-13` | BC Map L379; A6 §6.1 |
| Channel selection, templates, quiet hours, consent, unsubscribe, dedup, delivery guarantees, inbox | `BC-22` | BC Map L131, L205; A7 §§10–13 |
| `BlockList`, `RateLimitCounter` | `BC-11` | BC Map L377; `PRD-020` `F-6` |
| Ranking signals, weights, scoring, diversity, tie-break | **A3** | A3 §§11–16 |
| Post lifecycle, visibility, aggregate shape, the six events | **A2** | A2 §§11, 12, 22, 24 |
| Community existence, membership predicate, privacy posture | **A1** | A2 §7.3 |
| Community roles | **A4** ⚠ CANDIDATE | A4 §0; BC Map L214 |
| Official library identity and official post types | **A5** ⚠ gated | A5 §§4, 6 |
| Content eligibility states, safety filter order | **A6** | A6 §§9, 10 |
| Community notification facts and payload rules | **A7** | A7 §§3, 15 |
| `TenantContext`, entitlement, config, audit sinks | `BC-19`, `BC-21`, `BC-25`, `BC-24` | `E-18`, `E-17`, `E-19`, `E-20` |
| Authentication, session, authorization decision | `BC-18` | `X-13`; `ID-1` |

### 6.2 What A8 does own

✅ OWNED BY PRD-021A

| ID | A8 owns | Section |
|---|---|---|
| `LCT-OWN-001` | The A1→A7 seam inventory and each seam's contract direction | §7.3 |
| `LCT-OWN-002` | The composed request flow for the three principal reads and two principal writes | §8 |
| `LCT-OWN-003` | The **production integration** of A3's ranking pipeline — not its logic | §12 |
| `LCT-OWN-004` | The degraded-mode matrix, and the invariant that degradation never widens visibility | §13, §27 |
| `LCT-OWN-005` | The cross-part isolation composition rule and its five surfaces | §9 |
| `LCT-OWN-006` | The cross-part conflict register | §41 |

`LCT-INV-002` | Nothing in §6.2 SHALL be read as a transfer from §6.1. Each
`LCT-OWN-*` is a statement about *composition*, and composition of
independently owned parts is the only thing A8 owns.

---

## 7. Bounded Context Integration

### 7.1 The edge inventory — measured, not assumed

🔗 INTEGRATION — BC Map §7

BC Map L292 is binding: *"If an edge is not in this table, it does not
exist."* The table holds **26 edges, `E-01`…`E-26`**. Measured against it:

| Question | Measured answer |
|---|---|
| Edges whose **target** contains `BC-15` | **1** — `E-14` (inbound, from `BC-13`) |
| Edges whose **source** is `BC-15` | **0** |
| Edges whose target contains `BC-13` | **0** — `BC-13` has **zero inbound edges** |
| All-context edges usable by `BC-15` with no new edge | **5** — `E-17`, `E-18`, `E-19`, `E-20`, `E-23` |

`LCT-FR-009` | A8 SHALL NOT propose, imply or design around any edge absent
from BC Map §7. The count SHALL remain 26.

### 7.2 What `BC-15` may lawfully do today

🔗 INTEGRATION

| Edge | Direction | What it gives PRD-021A | Consumed by |
|---|---|---|---|
| `E-18` | All contexts → `BC-19` | Ambient `TenantContext` | §9 |
| `E-19` | All contexts → `BC-25` | Typed config accessors, no raw strings | §33 |
| `E-20` | All contexts → `BC-24` | Audit facts, fire-and-forget, outbox-backed | §22.5, §26 |
| `E-17` | All write paths → `BC-21` | `check(tenantId, feature, delta)` | §8.4 |
| `E-23` | All contexts → `BC-22` | Notification facts — ⭐ **A7 needs no new edge** | §15, A7 §2.3 |
| `E-14` | `BC-13` → `BC-15` | Inbound enforcement — ⭐ **A6's consumption is lawful as written** | §22.4, A6 §16 |

### 7.3 ⭐ The seam inventory — A8's own contribution

✅ OWNED BY PRD-021A

| Seam | Producer side | Consumer side | Contract | Status |
|---|---|---|---|---|
| A1 → A2 | A1 membership predicate | A2 `LCF-AUTH-001` | Synchronous, in-process, fail-closed | ✅ specified |
| A2 → A3 | A2 candidate set | A3 `LCR-FR-017`…`022` | Bounded set carrying community scope; A3 rejects unscoped | ✅ specified |
| A3 → A2 | Ordered post ids | A2 §16 | Reorder-only; A3 may not add | ✅ specified |
| A2 → A6 | Post state | A6 §9 eligibility | A6 classifies; A2 renders | ✅ specified |
| A6 → A2/A3 | Eligibility verdict | A3 step 5 hard filter | Removal, not down-weighting (A6 `LCS-FR-019`) | ✅ specified |
| A4 → A1/A2/A5 | Community roles | Authorization inputs | ⛔ **A4 is a CANDIDATE** — seam cannot close | ⛔ `LCT-GAP-001` |
| A5 → A2 | Official post | A2 feed | Reuses `CommunityPost` (A5 §19) | ⚠ A5 gated |
| A5 → A7 | Official publication fact | A7 `LCN-EVT-006` | ⛔ blocked on A5's own gate | ⛔ open |
| A6 → A7 | Eligibility change fact | A7 `LCN-EVT-005` | Carries no moderation detail (A7 §8) | ⚠ subject to `LCT-CONF-001` |
| A2 → A7 | Content facts | A7 `LCN-EVT-001`…`003` | ⚠ **name divergence** from A2's six | ⛔ `LCT-CONF-001` |
| A2 → `BC-14` | Attachment reference | Media | ⛔ **`BC-15` is not an `E-22` consumer** | ⛔ `LCT-GAP-005` |
| A6 → `BC-13` | Report | Moderation intake | ⛔ **no edge exists** | ⛔ `LCS-ADR-001` |

`LCT-FR-010` | A8 SHALL NOT close a seam whose either side is owned by a part
that is itself blocked. Four seams above are open for that reason, and A8
records them as open rather than specifying a provisional contract.

### 7.4 Rank and cluster position

🔗 INTEGRATION — Matrix

`LCT-FR-011` | PRD-021A code SHALL live under `domain/social`, rank **8**
(`module_dependencies.yaml` L47), and SHALL depend only on strictly
lower-ranked modules (Matrix rule `L2`, L49).

⚠ **Disclosure — two measured facts A8 does not fix.** The Matrix's Social
cluster (L90) enumerates `BC-11`, `BC-12`, `BC-13` and states *"Only edges
`E-14`…`E-16`"* — `BC-15` is **absent**. The module tree (L480–483) lists
`identity/`, `graph/`, `messaging/`, `safety/` — there is **no community
module**. Both are consequences of `BC-15` being V2 while the Matrix describes
V1. Recorded as `LCT-GAP-002`, routed to the **Architecture Owner**. A8 does
not edit the Matrix.

---

## 8. Request Flows

✅ OWNED BY PRD-021A — *composition only; each step's logic is its owner's*

### 8.1 Read a community feed

```
1  BC-18   Authenticate                          → fail 401
2  BC-19   Establish ambient TenantContext (E-18) → fail loudly, never default
3  A1      Resolve community scope from server state (never from client)
4  A1      Authorise viewer membership            → fail 403  [HARD]
5  BC-21   check(tenantId, feature, delta) (E-17) — read paths: skipped
6  A2      Retrieve bounded candidate set, scoped
7  A2      Remove invalid / deleted / non-PUBLISHED   [HARD FILTER]
8  A6      Apply eligibility: ELIGIBLE only            [HARD FILTER]
9  A6/BC-11 Apply block/mute (BlockList is BC-11's)    [HARD FILTER]
10 A3      Score, diversify, tie-break                 [REORDER ONLY]
11 A2      Paginate                                     [§18 convention open]
12 BC-24   Emit read-audit fact if required (E-20, fire-and-forget)
```

`LCT-FR-012` | Steps 1–9 SHALL complete before step 10 begins, per A3
`LCR-FR-015`.
`LCT-FR-013` | Steps 4, 7, 8 and 9 SHALL be capable only of **removal**; steps
10 and 11 only of **reordering and truncation**. No step SHALL add a post
(A3 `LCR-INV-005`).
`LCT-FR-014` | Step 3 SHALL derive community scope from server-side state.
A client-supplied `CommunityId` SHALL be treated as an untrusted lookup key,
never as an authorization input (§22.2).

### 8.2 Publish a post

```
1  BC-18  Authenticate
2  BC-19  TenantContext (E-18)
3  A1     Authorise membership + posting right   [HARD]
4  A4     Role-gated post types  ⛔ blocked — A4 CANDIDATE
5  BC-21  check(...) (E-17)                      [HARD, write path]
6  BC-11  Rate limit (RateLimitCounter is BC-11's)   [HARD]
7  A2     Validate content; A6 restriction state check
8  ── one DB transaction ──────────────────────────
     8a A2   Persist CommunityPost
     8b      Write outbox row (same transaction, BC Map L446)
   ─────────────────────────────────────────────────
9  BC-24  Audit (E-20)
10 async  Outbox → Event Bus → consumers (A3, A7→BC-22, BC-26)
```

`LCT-FR-015` | Steps 8a and 8b SHALL occur in **one** database transaction.
An event SHALL NEVER be published from application code after commit
(BC Map L446).
`LCT-FR-016` | Step 10 SHALL be asynchronous. A notification or ranking
consumer failure SHALL NOT fail the publish (§18 of A7, `LCN-FR-054`).
`LCT-FR-017` | Step 4 SHALL remain unimplementable until A4 ceases to be a
CANDIDATE. Until then, post-type gating by community role SHALL NOT be built.

### 8.3 Report content

⛔ OPEN OWNER DECISION — the flow **cannot be specified**

`LCT-FR-018` | A8 SHALL NOT specify a reporting request flow. A6
`LCS-ADR-001` records that `BC-13` has **zero inbound edges** and that
`ADR-0055`/`ADR-0059` previously **refused** `BC-13`'s admission to a
per-context inbound path. A8 SHALL NOT design around that refusal, SHALL NOT
propose an edge, and SHALL NOT propose an intermediary.

### 8.4 Entitlement placement

🔗 INTEGRATION — `E-17`

`LCT-FR-019` | Entitlement checks SHALL occur on **write paths only**, per
`E-17`'s own wording (*"All write paths → BC-21"*). A8 SHALL NOT insert an
entitlement check on a read path, because doing so would extend `E-17` beyond
its registered scope.

---

## 9. Multi-Tenant & Community Isolation

### 9.1 The tenancy posture — inherited, and unusual

🔗 INTEGRATION — BC Map §11, rule `ID-2`, `ADR-0078`

`BC-15` sits in the `BC-11`→`BC-17` **Student Network** band, which BC Map §11
declares **Global — no `tenantId`, keyed on `PersonId`**, and which rule `ID-2`
(L488) forbids from ever receiving a `StudentRecordId` or a `tenantId`.

`ADR-0078` (Accepted) ruled that the **community scope identifier carries no
`tenantId`**, and did so as an interpretive ruling that amended nothing.

`LCT-FR-020` | PRD-021A SHALL NOT introduce `tenantId` or `StudentRecordId`
into any `BC-15`-owned structure. `module_dependencies.yaml` L266–267 bans both
symbols in `domain/social` with `use_instead: "nothing — social data is not
tenant-scoped"`.

`LCT-FR-021` | The isolation unit for PRD-021A SHALL be the **community scope
identifier**, not the tenant. A8 SHALL NOT reason about community isolation as
a special case of tenant isolation.

### 9.2 ⭐ The five surfaces — A8's composition rule

✅ OWNED BY PRD-021A

`module_dependencies.yaml` L534–539 enumerates five surfaces requiring a
tenant key, with `tenant_key_violation_severity: blocker` (L541). BC Map L510
calls a leak through one of them *"the single highest-severity failure mode in
the entire architecture."*

`LCT-FR-022` | For each of the five surfaces, the PRD-021A key SHALL be
composed on the **community scope identifier**:

| Surface | Key composition | Enforcement |
|---|---|---|
| Cache keys | Community scope identifier in the key prefix | §20 |
| Search index names | Community scope identifier in the index name | §19 — ⛔ but see `LCT-GAP-006` |
| Vector namespaces | Not applicable — PRD-021A has no vector surface | `LCT-XC-003` |
| Storage prefixes | Community scope identifier in the prefix | §21 — ⛔ but see `LCT-GAP-005` |
| Projection table names | Community scope identifier in the partition key | §11 |

`LCT-INV-003` | Isolation SHALL be **structural**: a query, cache read, index
lookup or storage read that omits the community scope identifier SHALL fail at
runtime, not silently return a wider set. This mirrors BC Map §11's rule for
tenant-scoped contexts and applies it to the community unit.

`LCT-FR-023` | A cross-community leak SHALL be classified **blocker**
severity, matching L541. It SHALL NOT be triaged as a functional defect.

### 9.3 Cross-library isolation — the honest limit

⛔ OPEN OWNER DECISION

`LCT-FR-024` | A8 SHALL record that **cross-library isolation is not
expressible inside `BC-15`**. Because `BC-15` may hold no `tenantId`, it cannot
formulate a predicate of the form *"posts belonging to library X."* A6
`LCS-GAP-006` already records this; A8 concurs and adds nothing.

⚠ The authorizing instruction requires *"mandatory cross-library leakage
tests"* (§39.6). A8 specifies those tests as **negative** assertions — that no
library-identifying value is present on any PRD-021A surface — because the
positive form is unformulable. This is a faithful, not a weakened, reading:
`ID-2` makes absence the correct assertion.

---

## 10. Data Architecture

### 10.1 The no-duplication rule

📤 DELEGATED

`LCT-FR-025` | PRD-021A SHALL NOT duplicate any of the following. Each SHALL
be held **by reference** to its owning context:

| Entity | Owner | Reference PRD-021A holds |
|---|---|---|
| Person | `BC-10` | `PersonId` only — never a `StudentRecordId` (`ID-2`) |
| Profile | `BC-10` | `PersonId`; no copied profile fields |
| Library membership | `BC-02` | ⛔ Not referenced directly — see §10.3 |
| Social relationships (follow, block, mute) | `BC-11` | Queried, never stored (`BlockList` is `BC-11`'s) |
| `ModerationCase` and its family | `BC-13` | ⛔ Not held at all. Only the `E-14` four-field outcome |
| Notification delivery state | `BC-22` | ⛔ Not held at all (A7 §14) |
| Media binaries | `BC-29`/`BC-14` | ⛔ Not held — and no reference path exists (§21) |

`LCT-INV-004` | A copy of an entity owned elsewhere is a second system of
record. PRD-021A SHALL hold **none**.

### 10.2 What PRD-021A does persist

🔗 INTEGRATION — A2 §22 owns the shapes

`LCT-FR-026` | The persisted set SHALL be exactly A2's aggregate set plus A6's
eligibility state. A8 introduces no entity and alters no shape. A2 §22 and A6
§9 are authoritative.

### 10.3 ⭐ The membership reference gap

⛔ OPEN OWNER DECISION

`LCT-FR-027` | A8 SHALL record that PRD-021A cannot hold a reference to a
library membership. `BC-02` membership is **tenant-scoped**; `BC-15` may hold
no `tenantId`. The only registered bridge between the two tenancy models is
`PersonId` via the `E-13` ACL, and Matrix `X-05` classifies the relationship
**Separate Ways** (`PRD-020` `F-2`).

A1 owns the membership predicate and evaluates it at request time (§8.1
step 4). ⚠ That works for a synchronous authorization check and **does not**
work for an offline projection that must pre-filter by membership. Recorded as
`LCT-GAP-003`, routed to the **Architecture Owner**. A8 proposes no bridge.

---

## 11. Database Design

🔗 INTEGRATION — EA `DATA PLATFORM`; Platform Engineering owns products

`LCT-FR-028` | PRD-021A SHALL use the platform's existing relational store via
`Storage Abstraction` (EA L1881, V1). A8 selects no engine.

`LCT-FR-029` | `Row Level Isolation` (EA L2081, **V1**) SHALL be the primary
structural isolation mechanism, keyed per §9.2.

`LCT-FR-030` | Read scaling SHALL use `Read Replicas` (EA L2075, **V2**). A8
SHALL NOT propose `Partitioning & Sharding` (EA L2077, **V3**) — this both
respects the version band and satisfies the standing prohibition on sharding.

`LCT-FR-031` | The feed projection SHALL NOT be treated as a system of record
(A2 `LCF-RM-002`, BC Map L385). It SHALL be rebuildable — ⚠ subject to
`LCT-GAP-004` (§15.6).

`LCT-FR-032` | Index and projection table names SHALL carry the community
scope identifier (§9.2, surface 5).

⛔ **A8 mints no schema.** Column types, index definitions and migration order
are implementation concerns owned by Platform Engineering. A8 states only the
four constraints above.

---

## 12. Feed Architecture

### 12.1 The ownership split, stated first

🔗 INTEGRATION — A3 owns ranking; A8 owns production integration only

`LCT-FR-033` | **A3 is the owner of ranking logic.** A8 SHALL NOT specify a
signal, a weight, a scoring formula, a diversity rule or a tie-break. A3
§§11–16 are authoritative and A8 restates none of them.

`LCT-FR-034` | A8 owns only the **production integration** of that logic: where
it sits in the request path, what it is handed, what happens when it fails.

### 12.2 The pipeline

✅ OWNED BY PRD-021A (composition) — 🔗 each stage's logic is its owner's

The authorizing instruction specifies the pipeline; A3 `LCR-FR-014` already
specifies a ten-step ordering. They agree, and A8 records the mapping rather
than a second pipeline:

| Instruction stage | A3 `LCR-FR-014` step | Owner | Kind |
|---|---|---|---|
| Community authorization | 1–2 | A1 | **Hard** |
| Candidate retrieval | 3 | A2 | Precondition |
| Eligibility filtering | 4 | A2 | **Hard filter** |
| Safety / privacy filtering | 5 | A6 · `BC-13` via `E-14` · `BC-11` blocks | **Hard filter** |
| A3 ranking | 6–7 | A3 | Scoring |
| Diversity / freshness | 8–9 | A3 | Ordering |
| Cursor pagination | 10 → A2 §14 | A2 | Output ⚠ §18 |
| Response | — | A2 | Output |

`LCT-INV-005` | The two orderings SHALL be treated as **one** pipeline. A8
SHALL NOT introduce a stage absent from A3 `LCR-FR-014`.

⚠ **Disclosure on "cursor pagination."** The instruction names cursor
pagination. A2 §14.1 measured `grep -rniE 'cursor' docs/10-architecture/*.md`
→ **zero results**, and routed the convention to the Architecture Owner as
`LCF-ADR-003`/`LCF-DEC-005`; A3 `LCR-FR-023` requires independence from the
token's internal structure. A8 therefore treats cursor pagination as the
**expected** outcome of `LCF-ADR-003` but **does not select it**, because
selecting it would decide an open Architecture Owner question. §18.

### 12.3 Read path composition

`LCT-FR-035` | Ranking SHALL execute **in-process**, inside the modular
monolith (`ADR-0001`). A8 SHALL NOT propose a ranking service, a ranking
cluster or a ranking sidecar.

`LCT-FR-036` | The candidate set handed to A3 SHALL be bounded, per A3
`LCR-FR-021`. Its numeric bound SHALL come from configuration via `E-19` and
SHALL NOT be minted here (A3 `LCR-FR-022`, `LCF-GAP-006`).

`LCT-FR-037` | A3 SHALL receive a candidate set carrying its community scope
identifier and SHALL fail closed if it is absent (A3 `LCR-FR-018`).

---

## 13. Feed Failure & Ranking Fallback

### 13.1 The mandated behaviour

🔗 INTEGRATION — A3 §18 already specifies it

The instruction requires: on ranking failure → deterministic recent eligible
posts; safety/privacy filters remain mandatory; authorization remains
mandatory; tenant/community isolation remains mandatory.

A3 §18 already specifies exactly this. A8 maps rather than duplicates:

| Requirement | A3 identifier | Text |
|---|---|---|
| Deterministic recent posts | `LCR-FR-060` | Reverse-chronological + §16 tie-break |
| Filters remain mandatory | `LCR-INV-009` | *"Fallback SHALL NOT widen visibility, relax a filter, or bypass authorisation"* |
| Not a user-visible error | `LCR-FR-061` | A ranking failure SHALL NOT surface as a feed error |
| Observable | `LCR-FR-062` | Entering/leaving fallback is observable |

### 13.2 ⭐ Why this is safe by construction

✅ OWNED BY PRD-021A — *A8's own reasoning*

`LCT-FR-038` | Fallback safety SHALL be **structural, not procedural**. Because
authorization and all hard filters execute at steps 1–9, strictly upstream of
A3 (steps 10+), **losing A3 cannot lose them**. A3 `LCR-INV-009` states the
same conclusion; A8 records the mechanism.

`LCT-INV-006` | No degraded mode in PRD-021A SHALL be implemented by relaxing
an upstream filter. If a proposed degradation requires moving a filter
downstream of A3, that proposal SHALL be rejected.

### 13.3 The degraded-mode matrix

✅ OWNED BY PRD-021A

| Failing component | Feed behaviour | What is lost | Isolation preserved? |
|---|---|---|---|
| A3 ranking | Reverse-chronological fallback | Relevance ordering | ✅ |
| A6 eligibility source | ⛔ **Fail closed** — refuse to serve | Availability | ✅ |
| `BC-13` `E-14` read model | ⛔ **Fail closed** (A2 `LCF-NFR-010`, `LCF-RM-004`) | Availability | ✅ |
| `BC-11` block lookup | ⛔ **Fail closed** | Availability | ✅ |
| `BC-22` notification | Publish continues; no notification | Notification only (A7 `LCN-FR-054`) | ✅ |
| Realtime engine | Poll/refresh only | Freshness (A2 `LCF-NFR-009`) | ✅ |
| Cache service | Serve from source | Latency | ✅ |
| Attachment resolution | Post renders, attachment unresolved (A2 `LCF-NFR-007`) | Attachment only | ✅ |
| Event bus | Writes commit; outbox drains later | Propagation timeliness | ✅ |

`LCT-FR-039` | **Safety components fail closed; enrichment components fail
open.** A component SHALL be classified into exactly one of the two, and the
classification SHALL follow whether its absence could widen visibility.

⚠ **`LCT-GAP-007`.** A closed-failure feed is a **blank feed** for the
student. Whether that is acceptable product behaviour, or whether an explicit
"temporarily unavailable" state is required, is a **Product Owner** question.
A8 records it and mints no user-facing copy.

---

## 14. Realtime Architecture

🔗 INTEGRATION — EA `Realtime Engine (V1)`, `Fan-Out Strategy (V2)`

`LCT-FR-040` | Realtime delivery SHALL use `Realtime Engine` (EA L1847, V1)
with `Connection Management` (L1852, V1) and `Fan-Out Strategy` (L1854, V2).
A8 introduces no realtime transport.

`LCT-FR-041` | Realtime messages SHALL be **content-free signals**, per A2
`LCF-INV-013`. A signal SHALL carry an identifier prompting an authorized
fetch, never the post body — so authorization and eligibility are re-evaluated
on the fetch rather than trusted at fan-out time.

`LCT-FR-042` | A realtime outage SHALL degrade **freshness only, never
correctness** (A2 `LCF-NFR-009`).

`LCT-FR-043` | Recovery SHALL be by authorized re-fetch, not by replaying
missed signals. A client reconnecting SHALL re-read through §8.1, so every
filter re-applies.

`LCT-FR-044` | ⛔ No requirement SHALL depend on `Realtime Scaling &
Backpressure` (EA L1855, **V3**) — A2 `LCF-NFR-012` states the same.

⚠ **`LCT-GAP-008`.** Fan-out to a large community has no capacity model in
band: `Presence Service` and `Fan-Out Strategy` are V2 but their *sizing* is
unspecified, and backpressure is V3. A7 `LCN-DEC-003` already holds the
fan-out limit question open. A8 concurs and mints no limit. → **Architecture
Owner** with Product Owner input.

---

## 15. Event Architecture

### 15.1 The delivery contract — wholly inherited

📤 DELEGATED — BC Map §9.1, owned by `EVENT PLATFORM`

`LCT-FR-045` | Every PRD-021A event SHALL comply with BC Map §9.1 without
restatement: outbox atomicity (L446), at-least-once delivery with idempotent
consumers keyed on `eventId` (L447), per-aggregate ordering with partition key
`aggregateId` and **no** cross-aggregate ordering assumption (L448), the
ten-field envelope (L449), additive-only schema evolution within a major
version (L451), retry-with-backoff → DLQ with SLO-monitored depth (L452).

`LCT-FR-046` | PRD-021A SHALL use the `PL` mechanism of BC Map §10 as its only
event transport (A2 `LCF-XC-022`). A8 proposes no second transport and no
streaming platform.

### 15.2 The naming rule

📤 DELEGATED — BC Map L401 (binding)

`LCT-FR-047` | Every PRD-021A event name SHALL follow
`<Context>.<Aggregate><PastTenseVerb>`. BC Map L401: *"An event named as an
imperative (`SendReminder`) is a **command**, belongs to Workflow, and must
not enter the event bus as a domain event."*

### 15.3 ⭐⭐ `LCT-CONF-001` — the cross-part event conflict

⛔ OPEN OWNER DECISION — **the most material finding in A8**

**Measured.** A2 §24 defines six events and closes the set:

> `LCF-FR-104` | *"The event set SHALL be closed at these six. A seventh SHALL
> require a PRD amendment."*

A5 obeyed this explicitly — `LCO-FR-113`: *"⛔ **A2's event set is CLOSED at
six.** … A5 therefore proposes **no seventh event** by its own authority."*

A7 §3 proposes **seven** facts. Reconciled against A2's six:

| A7 fact | A2 counterpart | Status |
|---|---|---|
| `LCN-EVT-001` `community.PostPublished` | `LCF-EVT-001` `community.PostPublished` | ✅ **exact name match** |
| `LCN-EVT-002` `community.CommentAdded` | `LCF-EVT-005` `community.CommentPublished` | ⚠ **name divergence** — same fact, two names |
| `LCN-EVT-003` `community.ReactionAdded` | `LCF-EVT-006` `community.ReactionChanged` | ⚠ **name divergence** — and different semantics (*Added* vs *Changed*) |
| `LCN-EVT-004` `community.MembershipChanged` | — | ⛔ **no counterpart** — would be a 7th |
| `LCN-EVT-005` `community.ContentEligibilityChanged` | — | ⛔ **no counterpart** — would be an 8th |
| `LCN-EVT-006` `community.OfficialCommunicationPublished` | — | ⛔ **no counterpart** — 9th; also blocked on A5 |
| `LCN-EVT-007` `community.HelpRequestAnswered` | — | ⛔ **no counterpart** — 10th; also blocked on `LCR-DEC-009` |

**Three distinct defects, not one:**

1. **Quantity.** Four A7 facts have no A2 counterpart. `LCF-FR-104` makes each
   a PRD amendment. A7 did not cite `LCF-FR-104` (measured: zero occurrences
   of `LCF-FR-104` or `LCF-EVT-` in A7).
2. **Naming.** Two facts describe A2 events under different names. Two names
   for one fact is a contract fork; consumers keyed on `eventType` would miss.
3. **Semantics.** `ReactionAdded` and `ReactionChanged` are not synonyms — A2's
   `Changed` covers removal and switching; A7's `Added` does not.

⛔ **A8 resolves none of it.** The event set is **A2's**, and `LCF-FR-104`
names the remedy: *a PRD amendment*. Choosing between (a) amending A2 to widen
the set, (b) folding A7's four extra facts into existing payloads as A5's
`LCO-ADR-003` contemplates, or (c) reducing A7's fact list, is an **A2
ownership act**.

`LCT-FR-048` | `LCT-CONF-001` SHALL block A7's event register from being
treated as settled. Until A2 rules, A7 §3's seven facts SHALL be read as
**proposed and unregistered**, which is how A7 §0 already labels them.

→ Routed to the **Social Domain owner** as A2's owner, with the **Architecture
Owner** consulted on naming (BC Map L401). `LCT-ADR-001`.

### 15.4 ✅ `LCT-CONF-002` — the envelope vs the tenancy rule — **RESOLVED by AO-6 (2026-08-31)**: `BC-15` events carry **no `tenantId`**; `ID-2` is **preserved, not overridden**; recorded as BC Map §15.4 `EV-1`…`EV-4`; ⛔ no other BC gains the exception

⛔ OPEN OWNER DECISION

**Measured.** BC Map §9.1 L450: *"`tenantId` is **mandatory** on every domain
event. A consumer that processes an event without establishing tenant context
must fail loudly, not default."* The L449 envelope lists `tenantId` as a field.

But rule `ID-2` (L488) forbids `BC-15` from ever receiving a `tenantId`, and
`module_dependencies.yaml` L266–267 bans the symbol in `domain/social`.

A `BC-15` event therefore **cannot** satisfy L450 without violating `ID-2`.

`ADR-0078` (Accepted) ruled the community **scope identifier** carries no
`tenantId` — but it was an interpretive ruling that **amended nothing**, and it
did not amend L450. A2 `LCF-FR-094` records every payload's tenant field as
**UNRESOLVED**; A7 `LCN-FR-042` forbids `tenantId` on its facts.

`LCT-FR-049` | A8 SHALL rely on `ADR-0078` and SHALL NOT reopen it. A8
records that `ADR-0078` settled the *scope identifier* but left the *envelope
field* unsettled, and routes only the residue.

→ `LCT-GAP-009`, **Architecture Owner**. A8 proposes no envelope variant.

### 15.5 Per-event attributes

📤 DELEGATED — A2 §24 for the six; A7 §3.3 for the proposed facts

`LCT-FR-050` | The eight attributes the instruction requires — owner,
producer, consumer, payload, version, idempotency, retry, ordering — SHALL be
carried per event by its owning part: A2 §24 for `LCF-EVT-001`…`006`
(with `LCF-FR-104`…`107`), A7 §3.3 for `LCN-EVT-001`…`007`. A8 SHALL NOT
maintain a third register.

`LCT-FR-051` | Where a part specifies fewer than eight attributes, the missing
ones SHALL be taken from BC Map §9.1 (§15.1), which supplies retry, ordering
and idempotency platform-wide.

### 15.6 ⭐ `LCT-GAP-004` — rebuild required, mechanism out of band

⛔ OPEN OWNER DECISION

BC Map L453: *"Every projection (`BC-26`) and index (`BC-23`) must be
rebuildable from the log. This is tested quarterly, not assumed."*
A2 `LCF-NFR-006`: the feed projection SHALL be rebuildable from the event
stream.

But `Event Replay` and its children — `Replay by Time Range`, `Replay by
Aggregate`, `Read Model Rebuild` — are all tagged **V3** in the EA. PRD-021A is
V2.

`LCT-FR-052` | A8 SHALL record that a **required** property depends on an
**out-of-band** capability. A8 SHALL NOT propose a private replay mechanism —
that would be new infrastructure, forbidden by `LCT-XC-001`, and would
duplicate a capability the `EVENT PLATFORM` owns.

→ **Architecture Owner**: either `Read Model Rebuild` is needed at V2, or A2
`LCF-NFR-006` is unsatisfiable in band. `LCT-ADR-002`. ✅✅ **ANSWERED — Architecture Owner ruling AO-5, 2026-08-31: the SECOND limb is correct.** `Read Model Rebuild` is **NOT** pulled forward to V2, and A2 `LCF-NFR-006` **is** unsatisfiable in the V2 band. The ruling's own words: V2 *"must not pull Event Replay/V3 forward"*, A8 *"SHALL NOT invent new V2 infrastructure"*, and where the requirement is impossible *"mark the requirement as conditional/deferred rather than pretending V2 provides Event Replay."* ⭐⭐ **A8's refusal at L955–957 is vindicated exactly as written** — it declined to propose a private replay mechanism on the grounds that it would be new infrastructure forbidden by `LCT-XC-001` and would duplicate an `EVENT PLATFORM` capability, and the ruling adopts that reasoning rather than overriding it. ✅ A2 `LCF-NFR-006` has been marked **CONDITIONAL / DEFERRED** in place at A2 **L1526**, with the requirement **retained, not deleted or weakened**, and ⛔ it **SHALL NOT** be recorded as passing, waived or approximated in V2. ⚠ It **auto-reactivates** when the platform's capability band provides an event stream.

### 15.7 No unnecessary events

`LCT-FR-053` | A8 SHALL create **zero** events. Every fact PRD-021A needs is
either already in A2's six or already proposed in A7's seven. A8 adds nothing
to either register — and per A5 `LCO-FR-117`, state changes that need only
**auditability** SHALL use `E-20` rather than a published event, because a
domain event is a contract with consumers and audit is not.

---

## 16. Idempotency & Retry

📤 DELEGATED — BC Map §9.1; EA `Idempotency Service (V2)`, `Idempotency Support (V2)`

`LCT-FR-054` | Every PRD-021A consumer SHALL be idempotent keyed on `eventId`
(BC Map L447; A2 `LCF-FR-106`).

`LCT-FR-055` | Write endpoints SHALL use `Idempotency Support` (EA L1757, V2)
at the API edge and `Idempotency Service` (EA L1892, V2) in the runtime. A8
selects no key format — that is the service's contract.

`LCT-FR-056` | Enforcement application from `E-14` SHALL be idempotent on
`(caseId, actionId)`, per `PRD-020` `TSF-FR-123`: *"a duplicate delivery MUST
NOT produce a second restriction."* A6 §16 already binds this.

`LCT-FR-057` | Retry SHALL be backoff-then-DLQ (BC Map L452). A8 SHALL NOT
mint a retry count, a backoff curve or a DLQ depth threshold — all are
configuration, routed via `E-19`, and `CONFIGURATION_GUIDE.md` L863 makes
adding a parameter a PRD amendment.

`LCT-FR-058` | ⛔ No requirement SHALL depend on `Poison Message Handling`
(EA, **V3**). A poison message at V2 SHALL rest in the DLQ and be handled by
`Manual Reprocess` (V2).

---

## 17. API Architecture

🔗 INTEGRATION — EA `API PLATFORM (V1)`

`LCT-FR-059` | PRD-021A endpoints SHALL be delivered through the existing
`API PLATFORM` with `API Contracts` (OpenAPI as source of truth),
`Tenant Resolution`, `Request Validation` and `Timeout & Retry Policy`. A8
introduces no gateway and no BFF of its own.

`LCT-FR-060` | Authorization SHALL be a `BC-18` decision, never evaluated in
`domain/social`. `module_dependencies.yaml` L186 declares the port
`platform/identity:policy_decision  # ask BC-18 per request; never cache
(MP-GBR-26)` — note **never cache**, which constrains §20.

`LCT-FR-061` | ⛔ A8 SHALL NOT specify endpoint paths, verbs, status codes or
schemas. A2 §23 and A5 §20 hold API contracts for their own surfaces, both
marked documentation-only. A8 adds no endpoint.

---

## 18. Pagination

⛔ OPEN OWNER DECISION

`LCT-FR-062` | A8 SHALL NOT select a pagination convention. A2 §14.1 measured
**zero** occurrences of `cursor` across `docs/10-architecture/*.md` and routed
the convention to the **Architecture Owner** as `LCF-ADR-003`/`LCF-DEC-005`.
A3 `LCR-FR-023` requires independence from token internals.

`LCT-FR-063` | Whatever convention is chosen SHALL satisfy four constraints
already stated by the parts: bounded page size (A2 `LCF-FR-065`), stability
under concurrent writes (A2 `LCF-BR-006`/`007`), opacity to A3
(`LCR-FR-023`), and no leakage of a filtered-out post's existence through
page-count or token arithmetic — because that would defeat A6 `LCS-FR-025`.

⚠ `Pagination & Filtering Standards` is EA L379, tagged **V1** — so the
*capability node* exists while its *content* is unspecified. A8 records this
distinction rather than reading the node as a decision.

---

## 19. Search

⛔ OPEN OWNER DECISION — 🔮 and partly FUTURE

**Measured.** `E-21` reads *"`BC-01`, `BC-10` → `BC-23` Search Indexing"*.
`BC-15` is **not** a producer.

`LCT-FR-064` | ✅✅ **CONFIRMED CORRECT — Architecture Owner ruling AO-9, 2026-08-31.** A8 SHALL NOT design a community search path. `BC-15` cannot
publish to `BC-23` without a new edge, and BC Map L292 makes an unregistered
edge non-existent. ⭐⭐ **AO-9 was a CONDITIONAL authorization and the condition FAILED, so the refusal stands.** The ruling permits `BC-15` to use the existing search architecture *"only if the existing `E-21` contract supports it without inventing a new search protocol"*, and directs that *"if an architectural amendment is required, record it explicitly rather than silently claiming `E-21` support."* ✅ Re-measured on the live BC Map at v1.9: `E-21` (**L330**) reads `BC-01`, `BC-10` → `BC-23 Search Indexing` — ⛔ **`BC-15` is absent from the consumer cell.** The contract does **not** support it. ✅ Per the ruling's own conditional the refusal is therefore **recorded, not overridden**: community search is **out of band for V2**, and this requirement plus `LCT-AC-032` are **CONFIRMED**, as is A8's original measurement at L1043–1044. ⛔ **No `E-21` amendment was made and no support was claimed** — the tempting move here was to read AO-9's permissive clause and mint the edge; measurement forbade it.

`LCT-FR-065` | A2 §15 already scopes community filtering to **in-community
filtering over an authorized candidate set**, not platform search. A8 concurs
and adds nothing.

`LCT-FR-066` | If community search is ever added, index names SHALL carry the
community scope identifier (§9.2, surface 2), and results SHALL pass A6's
eligibility filter **before** presentation — a search result set is a candidate
set and inherits §12.2's hard filters.

→ `LCT-GAP-006`, **Architecture Owner** (edge) + **Product Owner** (scope).

---

## 20. Cache Architecture

### 20.1 The available capability

🔗 INTEGRATION — EA `Cache Service (V2)`

`LCT-FR-067` | Caching SHALL use `Cache Service` (EA L1882, **V2**). ⛔ A8
SHALL NOT depend on `Query Cache` or `Distributed Cache` (EA L2091–2092, both
**V3**).

### 20.2 What may not be cached

📤 DELEGATED

`LCT-FR-068` | An authorization decision SHALL NOT be cached
(`module_dependencies.yaml` L186: *"ask BC-18 per request; never cache"*,
authority `MP-GBR-26`).

`LCT-FR-069` | An eligibility verdict SHALL NOT be cached beyond the request,
because A6's restriction cascade must take effect promptly; and the `BC-13`
read model already fails closed on staleness (A2 `LCF-RM-004`).

### 20.3 ⭐ Cache key composition — the isolation surface

✅ OWNED BY PRD-021A

`LCT-FR-070` | Every PRD-021A cache key SHALL carry the **community scope
identifier** in its prefix. BC Map L510 names *"a cache key missing the tenant
prefix"* as part of the highest-severity failure class;
`module_dependencies.yaml` L535 lists cache keys first among the five surfaces
and L541 grades a violation **blocker**.

`LCT-FR-071` | A cache read whose key omits the community scope identifier
SHALL fail, not fall back to a wider lookup (`LCT-INV-003`).

`LCT-FR-072` | A cached feed page SHALL additionally be keyed on the viewer,
because two members of one community may see different pages after block/mute
and eligibility filtering. ⭐ A community-keyed-only page cache would be a
**per-viewer leak inside a correctly tenant-isolated cache** — the failure mode
§9.2 exists to prevent, and the one most easily missed.

### 20.4 The gap

⛔ `LCT-GAP-010`. The five-surface rule is written in tenant vocabulary
(`tenant_key_required_in`). PRD-021A has no tenant to key on. §9.2 applies the
rule's **intent** by substituting the community scope identifier, but the
substitution is A8 reading the rule, not the rule reading itself. Whether the
boundary checker (`BOUNDARY_CHECKER_DESIGN.md` L185 enforces these five
surfaces) can express a non-tenant key is unknown to A8. → **Architecture
Owner**.

---

## 21. Media & Storage

⛔ OPEN OWNER DECISION — a hard blocker, disclosed not routed around

**Measured.** `E-22` reads *"`BC-01`, `BC-10`, `BC-12`, `BC-14` → `BC-29` File
& Media"*. `BC-15` is **not** a consumer.

`LCT-FR-073` | A8 SHALL record that **PRD-021A has no registered media path**.
A2 §10 specifies attachments and routes them via `BC-14`; but `BC-15` → `BC-14`
is itself unregistered, and `BC-15` → `BC-29` is excluded by `E-22`'s closed
consumer list.

`LCT-FR-074` | A8 SHALL NOT propose an edge, a proxy through `BC-14`, or a
direct storage path. ⭐ `PRD-020` `F-4` records that `BC-13` was **deliberately**
excluded from `E-22` and that `ADR-0055` §3 refused it per-context, made
executable by `ADR-0059`. The consumer list is curated, not accidental —
so its shortness is evidence, not an oversight to correct.

`LCT-FR-075` | If a media path is granted, storage prefixes SHALL carry the
community scope identifier (§9.2, surface 4), and `Virus & Malware Scan`
(EA, V2) SHALL precede any read path.

`LCT-FR-076` | Until then, A2 `LCF-NFR-008` governs: a `BC-14` outage degrades
attachment-bearing posts only, and `TEXT` posts remain fully readable. A
`TEXT`-only V2 launch is therefore **architecturally coherent**.

→ `LCT-GAP-005`, **Architecture Owner**.

---

## 22. Security Architecture

### 22.1 The fourteen mandated concerns

The authorizing instruction names fourteen. Each is addressed, and for each
A8 states the owner — because most are not A8's:

| # | Concern | Owner | Where |
|---|---|---|---|
| 1 | Authentication | `BC-18` | §8.1 step 1; `ID-1` |
| 2 | Authorization | `BC-18` + A1 predicate | §8.1 steps 3–4 |
| 3 | Object-level authorization | A2 `LCF-AUTH-*` | §22.3 |
| 4 | Membership validation | A1 | §8.1 step 4 |
| 5 | Community scope validation | A1/A2 | §22.2 |
| 6 | IDOR prevention | A8 composition | §22.3 |
| 7 | Cross-library isolation | ⛔ not expressible | §9.3 |
| 8 | Cache isolation | A8 | §20.3 |
| 9 | Search isolation | ⛔ no path | §19 |
| 10 | Event isolation | A2/A7 payload rules | §22.6 |
| 11 | Notification isolation | A7 `LCN-FR-059` | §22.6 |
| 12 | Storage isolation | ⛔ no path | §21 |
| 13 | Rate limiting | `BC-11` | §22.7 |
| 14 | Auditability | `BC-24` via `E-20` | §22.5 |

### 22.2 ⭐ The never-trust rule

✅ OWNED BY PRD-021A

`LCT-SEC-001` | The server SHALL NOT trust any of the following when supplied
by a client: `LibraryId` · `CommunityId` · membership status · role ·
`AuthorId`.

`LCT-SEC-002` | Each SHALL be resolved from server-side state:

| Client-supplied | Correct server behaviour |
|---|---|
| `LibraryId` | ⛔ Never accepted — `BC-15` holds no tenant identifier (`ID-2`) |
| `CommunityId` | Accepted as an **untrusted lookup key**; membership re-evaluated against it (§8.1 step 4). Never an authorization input |
| Membership status | ⛔ Never accepted — A1 evaluates the predicate per request |
| Role | ⛔ Never accepted — `BC-18` decides; A4 defines; ⚠ A4 is a CANDIDATE |
| `AuthorId` | ⛔ Never accepted — derived from the authenticated principal |

`LCT-INV-007` | A client-supplied identifier SHALL be treated as *"which
object"*, never as *"whether allowed."* Conflating the two is the IDOR class.

### 22.3 IDOR prevention

`LCT-SEC-003` | Every read of a PRD-021A object by identifier SHALL re-derive
the object's community scope from persisted state and re-run §8.1 steps 3–9
against it. Possession of an identifier SHALL confer nothing.

`LCT-SEC-004` | A post identifier from community A SHALL NOT resolve for a
viewer authorized only in community B — and SHALL fail **identically** to a
non-existent identifier, so response shape does not disclose existence
(A6 `LCS-FR-025`).

### 22.4 Enforcement consumption

🔗 INTEGRATION — `E-14`, A6 §16

`LCT-SEC-005` | Enforcement SHALL be consumed over `E-14` in its closed
four-field shape `{personId, action, scope, until}` (`PRD-020` `TSF-EVT-002`).
A8 SHALL NOT widen it.

`LCT-SEC-006` | The `BC-13` read model SHALL fail closed on staleness
(A2 `LCF-RM-004`, `LCF-NFR-010`). BC Map L468: *"eventual consistency is
unacceptable for abuse containment."*

### 22.5 Auditability

`LCT-SEC-007` | Audit facts SHALL be emitted over `E-20` — fire-and-forget,
outbox-backed. An audit failure SHALL NOT fail the operation, per `E-20`'s own
semantics. A5 §17 and A6 §17 hold their own audit requirements; A8 adds none.

### 22.6 Event and notification isolation

`LCT-SEC-008` | No PRD-021A event payload SHALL carry a post body, an
attachment reference or a `StudentRecordId` (A2 `LCF-FR-105`), nor a
`tenantId` (`ADR-0078`, A7 `LCN-FR-042`).

`LCT-SEC-009` | A notification SHALL NOT disclose the existence of content the
recipient may not read (A7 `LCN-FR-059`), and SHALL NOT be treated as a
capability grant (A7 `LCN-FR-037`). ⭐ Both exist because a notification is a
read path that bypasses §8.1 — the one place where the feed's filters do not
run.

### 22.7 Rate limiting

📤 DELEGATED — `BC-11`

`LCT-SEC-010` | Graph and posting rate limits SHALL be `BC-11`'s
(`RateLimitCounter`, BC Map L377; `PRD-020` `F-6`, `TSF-XC-004`…`006`).
Transport is `Rate Limiter Service` (EA L1883, V2). ⛔ A8 mints no limit value.

---

## 23. Performance

`LCT-FR-077` | ⛔ A8 SHALL mint **no** latency target, throughput target or
capacity budget. A2 `LCF-NFR-003` already refuses: *"Latency targets SHALL NOT
be minted in this part."* A8 inherits the refusal rather than overriding a
sibling.

`LCT-FR-078` | Performance SHALL be bounded **structurally**: pagination
bounds response size (A2 `LCF-NFR-001`); a tenant-partitioned index avoids
full scans (`LCF-NFR-002`); the candidate set is bounded (A3 `LCR-FR-021`).
⭐ These are shape constraints, not numbers — and shape constraints are what a
PRD can own.

`LCT-FR-079` | Numeric budgets SHALL arrive by configuration via `E-19`
(`CNF-FR-052`). `CONFIGURATION_GUIDE.md` L863: adding a parameter is a PRD
amendment.

---

## 24. Scalability

### 24.1 The rank constraint

🔗 INTEGRATION — Matrix `L2`

`LCT-FR-080` | `domain/social` is rank **8**; it may depend only on strictly
lower ranks, with same-rank dependencies forbidden outside a declared cluster
(Matrix L49). PRD-021A SHALL NOT introduce a same-rank dependency.

⚠ **`LCT-GAP-002`** (from §7.4): `BC-15` is in **no** declared cluster (L90)
and has **no** module (L480–483). → Architecture Owner.

### 24.2 Scaling posture

`LCT-FR-081` | V2 scaling SHALL be **vertical and read-replica based**
(EA L2075, V2). ⛔ A8 SHALL NOT propose sharding (V3), multi-region (Future),
extraction to a service, or a mesh.

`LCT-FR-082` | The modular monolith SHALL remain the deployment unit
(`ADR-0001`). ⭐ A single-deployment community feature is the correct
startup-stage choice, and the EA's own `Service Extraction Playbook` and
`Strangler Fig` strategy exist precisely so extraction can be deferred until
evidence demands it.

### 24.3 🔮 Future scale — explicitly deferred

| Capability | EA tag | When |
|---|---|---|
| `Partitioning & Sharding` | V3 | 🔮 |
| `Multi-Region Replication` | Future | 🔮 |
| `Realtime Scaling & Backpressure` | V3 | 🔮 |
| `Ordering Guarantees` (global) | V3 | 🔮 |
| `Autoscaling Workers` | V3 | 🔮 |
| `Distributed Cache` / `Query Cache` | V3 | 🔮 |
| `Event Replay` | V3 | 🔮 ⚠ but see `LCT-GAP-004` |
| `Community Analytics` | V3 (EA L973) | 🔮 A2 `LCF-XC-029` |

`LCT-FR-083` | No PRD-021A requirement SHALL depend on any row above.

---

## 25. Background Jobs

🔗 INTEGRATION — EA `Job Runtime (V2)`

`LCT-FR-084` | Asynchronous work SHALL run on `Job Runtime` (EA L1865, V2)
with `Worker Pools`, `Queue Management` and `Retry & Backoff` (all V2).

`LCT-FR-085` | Per EA §10 rule 5 — *"Workflow orchestrates, Platform Services
executes"* — scheduling intent belongs to the Workflow platform and workers to
`Job Runtime`. A8 introduces neither a scheduler nor a worker pool.

`LCT-FR-086` | A job SHALL establish community scope explicitly. A job runs
outside a request and therefore outside ambient context (`E-18`); a job that
cannot establish scope SHALL fail loudly, mirroring BC Map L450's rule for
consumers. ⭐ Background jobs are the classic isolation hole, because ambient
context is exactly what they lack.

⛔ A8 mints no job, no schedule and no concurrency limit.

---

## 26. Observability

🔗 INTEGRATION — EA `OBSERVABILITY PLATFORM (V1)`; `E-20`

`LCT-FR-087` | PRD-021A SHALL use existing `Structured Logging`, metrics and
tracing. A8 introduces no telemetry pipeline.

`LCT-FR-088` | The following SHALL be observable, because each is a silent
failure otherwise:

| Signal | Why |
|---|---|
| Entering/leaving ranking fallback | A3 `LCR-FR-062` — silent relevance loss |
| Fail-closed refusals (A6, `BC-13`, `BC-11`) | A blank feed must be attributable |
| Outbox lag and DLQ depth | BC Map L452 — SLO-monitored, *"not a silent bin"* |
| Consumer lag | EA `Consumer Lag Monitoring` (V2) |
| Contract violations at A3 step 5 | A3 `LCR-FR-016` — an upstream filter leak |
| Cache-key composition failures | §20.3 — blocker severity |

`LCT-FR-089` | Observability output SHALL NOT carry post bodies, reporter
identities (`PRD-020` `TSF-INV-009`) or `StudentRecordId`. ⭐ The observability
plane is a third data plane subordinate to the data plane
(`module_dependencies.yaml` amendment A-9) — a log line is a data export.

⛔ A8 mints no SLO value.

---

## 27. Failure & Recovery

`LCT-FR-090` | The degraded-mode matrix of §13.3 SHALL govern all failure
handling, under `LCT-INV-006`: no degradation by relaxing an upstream filter.

`LCT-FR-091` | Recovery SHALL be **re-read, not replay**. A client recovering
from any outage SHALL re-enter §8.1 at step 1, so every filter re-applies. ⭐
This makes recovery correct by construction and needs no reconciliation logic.

`LCT-FR-092` | A database failure SHALL surface as an unavailability, never as
a partial or unfiltered result. A partially filtered feed is a privacy
incident; an unavailable feed is an outage.

---

## 28. Data Consistency

🔗 INTEGRATION — BC Map §10, §10.1

`LCT-FR-093` | PRD-021A SHALL be **eventually consistent by default**, per
BC Map §10, with two overrides:

| Path | Consistency | Mechanism |
|---|---|---|
| Post persistence + outbox | **Strong** — one transaction | BC Map L446 |
| Enforcement application | **Eventual** + fail-closed gate | BC Map L468; A2 `LCF-RM-004` |
| Feed projection | Eventual | Rebuildable ⚠ `LCT-GAP-004` |
| Notification | Eventual, fail-open | A7 `LCN-FR-054` |
| Eligibility read | **Fail closed on staleness** | A6; A2 `LCF-NFR-010` |

`LCT-FR-094` | PRD-021A SHALL NOT assume cross-aggregate ordering (BC Map
L448). Two posts in one community have independent orderings; feed order is
established by A3, not by the event log.

`LCT-FR-095` | ⛔ A8 SHALL NOT introduce a saga. BC Map §10 places sagas in
`BC-28` (V2) and PRD-021A has no multi-context write requiring compensation —
every PRD-021A write is single-aggregate.

---

## 29. Data Retention

⛔ OPEN OWNER DECISION

`LCT-FR-096` | Retention and deletion SHALL follow the platform's existing
posture. A8 mints no retention period.

`LCT-FR-097` | Deletion SHALL be reference-aware: A2 `LCF-EVT-003`
(`community.PostDeleted`) already signals `BC-14` reference-removal
(`LCF-FR-050`) and cache invalidation. A8 adds no deletion path.

⚠ Retention interacts with `BC-13` (a moderation case may outlive the content
it concerns) and with `BC-24` (audit is append-only). ⭐ Neither can be resolved
by PRD-021A: `ModerationCase` retention is `BC-13`'s and audit retention is
`BC-24`'s. → `LCT-GAP-011`, **Privacy Owner** with the Governance Owner.
`PRD-020` `TSF-CFG-003` is instructive — *"longer windows turn detection into
profiling"* — and shows the value is a policy act, not an architecture act.

---

## 30. Analytics

📤 DELEGATED — `BC-26`; 🔮 `Community Analytics` is V3

`LCT-FR-098` | Analytics SHALL be `BC-26`'s. ⛔ `Community Analytics` is EA
L973, **V3** — excluded by A2 `LCF-XC-029`/`LCF-FR-026`. A8 SHALL NOT specify
a community analytics surface.

`LCT-FR-099` | Analytics consumption SHALL be event-driven off the existing
facts. No analytics-specific event SHALL be created (§15.7).

`LCT-FR-100` | Analytics payloads SHALL be privacy-conscious per A5 §23 and
SHALL NOT re-identify a reporter or carry a `StudentRecordId`.

---

## 31. Testing Architecture

✅ OWNED BY PRD-021A (the composition tests) — 📤 unit tests are each part's

`LCT-FR-101` | Cross-part integration tests SHALL exist for every seam in
§7.3 whose both sides are unblocked. A8 SHALL NOT specify tests for a seam it
has declared open.

`LCT-FR-102` | The **Multi-Tenant Test Suite** SHALL be extended to the
community scope identifier across all five surfaces of §9.2. BC Map L510: the
suite *"exists specifically to make this class of bug fail in CI."*

`LCT-FR-103` | Isolation tests SHALL be **negative** where positive assertions
are unformulable (§9.3): assert the **absence** of any library-identifying
value on every PRD-021A surface.

`LCT-FR-104` | Boundary tests SHALL assert that `domain/social` imports no
banned symbol (`module_dependencies.yaml` L266–267) and no same-rank module
(Matrix `L2`). ⭐ The existing `check_module_boundaries` tool already performs
this; PRD-021A needs no new tool.

`LCT-FR-105` | Degraded-mode tests SHALL cover every row of §13.3, asserting
in each case that the filter set is unchanged.

---

## 32. CI/CD & Deployment

📤 DELEGATED — Platform Engineering

`LCT-FR-106` | PRD-021A SHALL deploy as part of the existing modular monolith
(`ADR-0001`). A8 introduces no pipeline, no artefact and no environment.

`LCT-FR-107` | Merge SHALL be gated on the existing checks — boundary checker,
`docs_check`, multi-tenant suite. A8 adds no gate but requires that the
`LCT-FR-102` extension be inside the existing gate rather than beside it.

---

## 33. Feature Flags

🔗 INTEGRATION — EA `Feature Delivery Service (V2)`; `E-19`

`LCT-FR-108` | PRD-021A SHALL be deliverable behind a flag served by
`Feature Delivery Service` (EA L1891, V2), which the EA notes *reads
CONFIGURATION PLATFORM* — so flags arrive through `E-19` with typed accessors
and no raw strings.

`LCT-FR-109` | ⛔ A flag SHALL NOT gate a safety filter, an authorization check
or an isolation predicate. ⭐ A flag is a **product** control; making it a
**safety** control creates a configuration path to a privacy incident.

`LCT-FR-110` | A8 SHALL mint no flag name. `CONFIGURATION_GUIDE.md` L863
makes that a PRD amendment.

---

## 34. Versioning

`LCT-FR-111` | API versioning SHALL use `API Versioning` (EA L1787, V2).

`LCT-FR-112` | Event schema changes SHALL be **additive only** within a major
version, with a new `schemaVersion` and dual publication for breaking changes
(BC Map L451), registry-enforced. ⛔ `Schema Evolution` is **V3**; at V2 only
`Schema Compatibility Rules` and `Contract Validation` (both V2) are available
— so PRD-021A SHALL stay additive rather than rely on an evolution mechanism.

`LCT-FR-113` | A3's ranking configuration versioning is A3 §19's. A8 adds
nothing.

---

## 35. Security & Privacy Audit

### 35.1 Audit result

| # | Control | Status | Owner |
|---|---|---|---|
| 1 | Authentication before any community read | ✅ | `BC-18` |
| 2 | Authorization not evaluated in `domain/social` | ✅ | `BC-18`; yaml L186 |
| 3 | Authorization decision never cached | ✅ | §20.2; `MP-GBR-26` |
| 4 | Object-level re-derivation on every identifier read | ✅ | §22.3 |
| 5 | Membership re-evaluated per request | ✅ | A1; §8.1 |
| 6 | Community scope never taken from client as authz input | ✅ | `LCT-SEC-001` |
| 7 | IDOR: identical failure for wrong-scope and non-existent | ✅ | `LCT-SEC-004` |
| 8 | Cross-library isolation | ⛔ **not expressible** | `LCS-GAP-006`; §9.3 |
| 9 | Cache keyed on community **and viewer** | ✅ | `LCT-FR-070`/`072` |
| 10 | Search isolation | ⛔ **no path exists** | §19 |
| 11 | Event payloads carry no body, no `StudentRecordId`, no `tenantId` | ✅ | `LCT-SEC-008` |
| 12 | Notifications disclose no unreadable content; grant nothing | ✅ | `LCT-SEC-009` |
| 13 | Storage isolation | ⛔ **no path exists** | §21 |
| 14 | Rate limiting delegated to `BC-11` | ✅ | `LCT-SEC-010` |
| 15 | Auditability over `E-20`, fire-and-forget | ✅ | `LCT-SEC-007` |
| 16 | Reporter identity never disclosed | ✅ | `TSF-INV-009`; A6 |
| 17 | Observability carries no personal data | ✅ | `LCT-FR-089` |
| 18 | Flags cannot disable a safety control | ✅ | `LCT-FR-109` |
| 19 | Background jobs establish scope explicitly | ✅ | `LCT-FR-086` |
| 20 | Degradation never widens visibility | ✅ | `LCT-INV-006` |

**17 controls satisfied · 3 blocked by a missing registered path.**

`LCT-FR-114` | The three ⛔ rows SHALL NOT be closed by A8. Each requires an
edge that does not exist, and BC Map L292 makes an unregistered edge
non-existent. ⭐ A8 leaving them open is the correct outcome: the alternative is
an architecture that quietly assumes a path the context map forbids.

### 35.2 Privacy posture

`LCT-FR-115` | PRD-021A SHALL hold no personal data of record. Person and
profile are `BC-10`'s, held by `PersonId` reference (§10.1). ⭐ The tenancy rule
that makes cross-library isolation inexpressible (`ID-2`) is the same rule that
makes PRD-021A structurally unable to accumulate a tenant-linked personal
dataset — the constraint cuts both ways.

---

## 36. V1 Architecture

`LCT-FR-116` | ⛔ PRD-021A has **no V1 architecture**, because PRD-021A is V2
(A2 `LCF-FR-024`). A8 SHALL NOT present a V1 subset.

`LCT-FR-117` | The V1 surface SHALL remain **empty by design**, per A2 §7.2
consequence 6 and `PRD-020` `TSF-FR-027` — the abuse-report subject register
lists `COMMUNITY_POST` and `COMMUNITY_COMMENT` from V1 but *"unpopulated until
`BC-15` ships."*

⭐ *"Startup-friendly V1"* is satisfied by PRD-021A shipping **nothing** in V1,
and by its V2 form adding **no** new infrastructure (§5.4). That is a stronger
result than a trimmed V1 would be.

---

## 37. Future Scale

🔮 Enumerated in §24.3. `LCT-FR-083` forbids dependency on any of it.

`LCT-FR-118` | A8 SHALL NOT design for a future band. EA §10.3 owns version-tag
semantics, and the `Service Extraction Playbook` exists so extraction is
evidence-driven.

---

## 38. Edge Cases

| # | Case | Behaviour | Authority |
|---|---|---|---|
| 1 | Membership revoked mid-session | Next request fails at §8.1 step 4 | A1; per-request evaluation |
| 2 | Enforcement lands mid-page-read | Next page reflects it; served page may be stale by one page | Eventual + fail-closed gate |
| 3 | Community deleted while paginating | Subsequent pages fail authorization | §8.1 step 3 |
| 4 | Post eligibility flips mid-ranking | Filter ran at step 8; result may include it for one request | `LCT-INV-006` — filters never move |
| 5 | Duplicate `E-14` delivery | Idempotent on `(caseId, actionId)` | `TSF-FR-123` |
| 6 | Outbox committed, broker down | Write durable; propagation delayed | BC Map L446 |
| 7 | Consumer poisons on a payload | DLQ; `Manual Reprocess` (V2) | `LCT-FR-058` |
| 8 | Two members, one community, different feeds | Correct — viewer-keyed cache | `LCT-FR-072` |
| 9 | Client supplies another community's `CommunityId` | Identical failure to non-existent | `LCT-SEC-004` |
| 10 | Job runs with no ambient context | Fails loudly | `LCT-FR-086` |
| 11 | A4 role required but A4 is CANDIDATE | Feature not built | `LCT-FR-017` |
| 12 | A3 returns a post filtered upstream | A3 discards + records violation | A3 `LCR-FR-016` |
| 13 | Notification consumer down at publish | Publish succeeds; no notification | A7 `LCN-FR-054` |
| 14 | Eligibility source down | ⛔ Blank feed | ⚠ `LCT-GAP-007` |
| 15 | Attachment unresolved | Post renders without it | A2 `LCF-NFR-007` |
| 16 | Reporting attempted | ⛔ No path | `LCS-ADR-001` |

---

## 39. Acceptance Criteria

Given / When / Then. Each maps to a seam or control above.

### 39.1 Cross-part seams

`LCT-AC-001` | **Given** a non-member, **when** a community feed is requested,
**then** the request fails at authorization and no candidate is retrieved.
*(A1→A2)*

`LCT-AC-002` | **Given** a candidate set without a community scope identifier,
**when** it reaches A3, **then** A3 fails closed and returns no partial
result. *(A2→A3; `LCR-FR-018`)*

`LCT-AC-003` | **Given** a candidate set containing a post from another
community, **when** it reaches A3, **then** A3 rejects the set. *(`LCR-FR-019`)*

`LCT-AC-004` | **Given** a post whose eligibility is `WITHHELD` or
`RESTRICTED`, **when** the feed is composed, **then** the post is **absent
from the candidate set** — not present with a zero weight. *(A2→A6;
`LCS-FR-019`)*

`LCT-AC-005` | **Given** A3 returns an ordering, **when** it is compared with
its input, **then** the output is a permutation of a subset — never a
superset. *(A3→A2; `LCR-INV-005`)*

`LCT-AC-006` | **Given** a published post, **when** the transaction commits,
**then** exactly one outbox row exists in the same transaction and no event was
published from application code. *(A2→A7; BC Map L446)*

`LCT-AC-007` | **Given** an official communication, **when** it enters the
feed, **then** it is a `CommunityPost` and no parallel entity exists.
*(A5→A2; A5 §19)*

`LCT-AC-008` | **Given** an eligibility change, **when** a notification fact is
produced, **then** it carries no moderation reason, category or actor.
*(A6→A7; A7 §8)*

### 39.2 ⭐ Cross-library leakage — mandatory

`LCT-AC-009` | **Given** any PRD-021A persisted row, **when** its columns are
inspected, **then** no `tenantId` and no `StudentRecordId` is present.
*(`ID-2`; yaml L266–267)*

`LCT-AC-010` | **Given** any PRD-021A cache key, **when** it is inspected,
**then** it contains the community scope identifier and no library identifier.
*(§20.3)*

`LCT-AC-011` | **Given** any PRD-021A event payload, **when** it is inspected,
**then** it contains no `tenantId`, no `StudentRecordId`, no post body and no
attachment reference. *(`LCT-SEC-008`)*

`LCT-AC-012` | **Given** a cache read whose key omits the community scope
identifier, **when** it executes, **then** it fails rather than returning a
wider set. *(`LCT-INV-003`)*

`LCT-AC-013` | **Given** two viewers in the same community with a block between
them, **when** both read the feed, **then** each receives a different page and
neither page is served from the other's cache entry. *(`LCT-FR-072`)*

`LCT-AC-014` | **Given** any `domain/social` source file, **when** the boundary
checker runs, **then** no banned symbol and no same-rank import is found.
*(`LCT-FR-104`)*

### 39.3 Authorization & IDOR

`LCT-AC-015` | **Given** a valid post identifier from community A, **when** a
viewer authorized only in community B requests it, **then** the response is
byte-identical to the response for a non-existent identifier.
*(`LCT-SEC-004`)*

`LCT-AC-016` | **Given** a client-supplied `AuthorId` differing from the
authenticated principal, **when** a post is created, **then** the supplied
value is ignored and the principal is recorded. *(`LCT-SEC-002`)*

`LCT-AC-017` | **Given** a client-supplied membership status or role, **when**
any request is authorized, **then** the supplied values are ignored and
server-side state is evaluated. *(`LCT-SEC-001`)*

`LCT-AC-018` | **Given** membership revoked after a page-1 read, **when**
page 2 is requested, **then** it fails authorization. *(§8.1 step 4)*

### 39.4 Degraded modes

`LCT-AC-019` | **Given** A3 unavailable, **when** a feed is requested, **then**
posts are returned in reverse-chronological order, the student sees no error,
and the returned set is a subset of what full ranking would have been eligible
to order. *(A3 §18; `LCR-INV-009`)*

`LCT-AC-020` | **Given** A3 unavailable, **when** the fallback feed is
inspected, **then** every hard filter — authorization, eligibility, block/mute,
community scope — is still applied. *(`LCT-INV-006`)*

`LCT-AC-021` | **Given** the eligibility source unavailable, **when** a feed is
requested, **then** the request **fails closed** and no unfiltered post is
returned. *(§13.3)*

`LCT-AC-022` | **Given** the `BC-13` read model stale beyond tolerance, **when**
a feed is requested, **then** the gate refuses. *(A2 `LCF-RM-004`)*

`LCT-AC-023` | **Given** a realtime outage, **when** a client reconnects,
**then** it re-reads through the full pipeline and no missed signal is replayed.
*(`LCT-FR-043`)*

`LCT-AC-024` | **Given** a database failure, **when** a feed is requested,
**then** an unavailability is returned — never a partial or unfiltered page.
*(`LCT-FR-092`)*

### 39.5 Events, retry, notification, moderation

`LCT-AC-025` | **Given** the same event delivered twice, **when** consumers
process it, **then** the effect is identical to single delivery.
*(`LCT-FR-054`)*

`LCT-AC-026` | **Given** the same `EnforcementActionTaken` delivered twice,
**when** applied, **then** no second restriction is created.
*(`TSF-FR-123`)*

`LCT-AC-027` | **Given** a consumer failing repeatedly, **when** retries
exhaust, **then** the event lands in the DLQ and DLQ depth is observable.
*(BC Map L452)*

`LCT-AC-028` | **Given** `BC-22` unavailable, **when** a post is published,
**then** the publish succeeds and no notification is delivered.
*(A7 `LCN-FR-054`)*

`LCT-AC-029` | **Given** content the recipient may not read, **when**
notification facts are produced, **then** no fact referencing that content is
produced for that recipient. *(A7 `LCN-FR-059`)*

`LCT-AC-030` | **Given** an audit emission failure, **when** the operation
completes, **then** the operation is not failed. *(`E-20`)*

### 39.6 Media, search, jobs, flags

`LCT-AC-031` | **Given** `BC-14` unavailable, **when** a feed containing
attachment-bearing and `TEXT` posts is read, **then** `TEXT` posts render fully
and attachment-bearing posts render with unresolved references.
*(A2 `LCF-NFR-008`)*

`LCT-AC-032` | ✅ **CONFIRMED CORRECT by AO-9 (2026-08-31) — the criterion stands exactly as written and its wording is UNCHANGED.** ⚠ It is **not** recorded as passing; it remains a criterion to be verified. **Given** community search is not implemented, **when** the
codebase is inspected, **then** no `BC-15` → `BC-23` publication path exists.
*(§19)*

`LCT-AC-033` | **Given** a background job with no ambient context, **when** it
runs, **then** it fails loudly rather than operating across communities.
*(`LCT-FR-086`)*

`LCT-AC-034` | **Given** any feature flag, **when** it is disabled, **then** no
authorization check, safety filter or isolation predicate is bypassed.
*(`LCT-FR-109`)*

⚠ **`LCT-AC-035`** | **Given** A4 remains a CANDIDATE, **when** role-gated
post types are sought, **then** the capability is absent — **this criterion
asserts absence and is expected to remain asserted until A4 is resolved.**

---

## 40. Risks & Mitigations

| ID | Risk | Mitigation |
|---|---|---|
| `LCT-R-001` | `LCT-CONF-001` is resolved by silently letting A7's names win, forking the event contract | §15.3 routes it to A2's owner as an amendment, per `LCF-FR-104` |
| `LCT-R-002` | A missing edge (media, search, reporting) is worked around by an in-part path | `LCT-XC-001`; `LCT-FR-074`; three ⛔ rows left open in §35.1 |
| `LCT-R-003` | Cache isolation implemented on community only, leaking between viewers | `LCT-FR-072` + `LCT-AC-013` |
| `LCT-R-004` | Fail-closed produces a blank feed, read as a bug and "fixed" by failing open | `LCT-INV-006`; `LCT-GAP-007` routed to Product Owner |
| `LCT-R-005` | `LCT-GAP-004` deferred until a projection needs rebuilding in production | ✅ **Routed as `LCT-ADR-002` before build — and the routing paid off: AO-5 answered it on 2026-08-31.** ⭐ Raising it early rather than discovering it in production is precisely what this risk row argued for |
| `LCT-R-006` | A V3 capability assumed available because its parent node is V2 | `LCT-FR-007` requires the tag on every dependency |
| `LCT-R-007` | Notification treated as a read path with its own authorization | `LCT-SEC-009`; A7 `LCN-FR-037` |
| `LCT-R-008` | A8 read as authority to amend EA/Matrix | §0.4, §6.1, `LCT-INV-001` |

---

## 41. ADR Requirements & Routing

### 41.1 ADRs required

| ID | Question | Owner | Blocking |
|---|---|---|---|
| `LCT-ADR-001` | Reconcile A7's seven proposed facts with A2's set closed at six by `LCF-FR-104`, including two name divergences and one semantic divergence | **Social Domain owner** (as A2's owner), Architecture Owner consulted on BC Map L401 naming | ⛔ Blocks A7's event register |
| `LCT-ADR-002` | ✅ **RESOLVED — AO-5, 2026-08-31.** Is `Read Model Rebuild` required at V2, or is A2 `LCF-NFR-006` unsatisfiable in band? → **Unsatisfiable in band, and that is the ratified answer.** ⛔ Event Replay stays **V3**; V2 gains **no** new infrastructure. ⭐ The resolution is a **deferral with the requirement preserved**, not a waiver: A2 **L1526** now carries `LCF-NFR-006` as **CONDITIONAL/DEFERRED**, and three alternatives were **refused by name** — inventing a V2 replay mechanism, silently claiming V2 provides Event Replay, and quietly deleting the requirement | **Architecture Owner** | ✅ **CLOSED.** ⚠ The projection-rebuild *guarantee* is still **not delivered** in V2 — what changed is that its absence is now **ratified and disclosed** rather than an open question |

⛔ **A8 writes neither.** 73 ADR files exist; `ADR-0083` does not, and A8 does
not create it.

### 41.2 Gap register

| ID | Gap | Owner |
|---|---|---|
| `LCT-GAP-001` | A4→A1/A2/A5 role seam cannot close while A4 is a CANDIDATE | Product Owner |
| `LCT-GAP-002` | `BC-15` absent from Matrix L90 cluster and L480–483 module tree | Architecture Owner |
| `LCT-GAP-003` | No membership reference path for offline projections (`X-05` Separate Ways) | Architecture Owner |
| `LCT-GAP-004` | ✅ **CLOSED by AO-5, 2026-08-31.** Projection rebuild required (BC Map L453) but `Event Replay` is V3 — ⭐ **the gap was real and the answer is that the V3 boundary holds.** A2 `LCF-NFR-006` is marked conditional/deferred at A2 **L1526** instead of being satisfied by invented V2 infrastructure | Architecture Owner → `LCT-ADR-002` ✅ **resolved** |
| `LCT-GAP-005` | `BC-15` is not an `E-22` consumer — no registered media path | Architecture Owner |
| `LCT-GAP-006` | `BC-15` is not an `E-21` producer — no registered search path | Architecture Owner + Product Owner |
| `LCT-GAP-007` | Product behaviour of a fail-closed blank feed unspecified | Product Owner |
| `LCT-GAP-008` | Fan-out capacity model absent; backpressure is V3 | Architecture Owner + Product Owner |
| `LCT-GAP-009` | BC Map L450 mandates `tenantId` on every event; `ID-2` forbids it for `BC-15` | Architecture Owner |
| `LCT-GAP-010` | The five-surface rule is tenant-worded; PRD-021A substitutes community scope | Architecture Owner |
| `LCT-GAP-011` | Retention interaction between community content, `BC-13` cases and `BC-24` audit | Privacy Owner + Governance Owner |

### 41.3 Conflicts

| ID | Conflict | Disposition |
|---|---|---|
| `LCT-CONF-001` | A7's seven facts vs A2's `LCF-FR-104` closure at six | ⛔ **RAISED, NOT RESOLVED** → `LCT-ADR-001` |
| `LCT-CONF-002` | Event envelope `tenantId` vs `ID-2` | ✅✅ **RESOLVED — Architecture Owner ruling AO-6, 2026-08-31.** `BC-15` events carry **no `tenantId`**, and the reason matters: ⭐⭐ **this is NOT a new exemption from `ID-2` — it is a repair to an envelope rule that was wrongly phrased as universal.** Measured: BC Map §10 **L488** already reads *"`BC-11`→`17` Student Network | **Global.** No `tenantId` … Must never receive a `StudentRecordId` or `tenantId` (rule `ID-2`)"*. `ID-2` was therefore **always** authoritative for the global band; the defect was the envelope rule claiming `tenantId` on every event. ✅ `ID-2` is **preserved, not weakened**. The exception is recorded explicitly as `EV-1`…`EV-4` in BC Map **§15.4**, and ⛔ **no other bounded context receives it** unless separately authorised. `LCT-GAP-009` is **CLOSED** |

### 41.4 Preserved untouched

A8 changed nothing about, and asserts no position on:
`LCS-ADR-001` · `LCS-DEC-001`…`003` · `LCS-GAP-001`…`006` · `LCN-ADR-001` ·
`LCN-DEC-001`…`003` · `LCN-GAP-001`…`008` · `LCF-ADR-001`…`007` ·
`LCF-GAP-002`/`003`/`006`/`009`/`010` · `LCR-DEC-006`/`009` · `LCM-DEC-001` ·
`LCG-DEC-001`…`003` · `LCO-DEC-001`/`002` · `LCO-ADR-003` · `LCO-GAP-020` ·
`TSF-GAP-001`/`002`/`005`/`006`/`009`/`010` · `R-1`/`R-2`/`R-3` · `ADR-0070` ·
`ADR-0075` · `ADR-0036` §8.2 q2 · the Stage-3 record's `D-1`…`D-6` ·
✅ `ADR-INDEX` L9-vs-L110 drift — **REPAIRED 2026-08-31; the line reference is now L9-vs-L111** because registering `ADR-0083` added one row above the derivation paragraph. ⭐⭐ **A8's finding was correct and was more precise than it knew:** the two cells genuinely disagreed, and measurement showed **L110 was the CORRECT one** (73 ADRs / 59 accepted) while **L9 was stale** (72 / 58) — it had missed the `ADR-0082` registration. ⛔ **The fix was NOT to copy the good figure into the bad cell.** Both readings were discarded and a mechanical classifier was re-run over all **74** `ADR-*.md` files with an explicit unparsed bucket (which returned **0**), giving **74 total · 60 accepted · 13 proposed · 1 execution-blocked**. ⚠ So the visible 58→60 is **one real addition plus one line of accumulated drift**, not two additions. · `DOCUMENTATION_BASELINE.md` L218 mis-ranking — ⚠ **still open, deliberately**: repairing it means editing a Rank-1 protected document, which no ruling authorises ·
`PRD_REGISTRY.md` §11.4's now-false verification line.

---

## 42. Implementation Checklist

⚠ **Nothing on this list is buildable yet.** PRD-021A is V2; Stage 3 is not
conferred; `LCT-ADR-001` and `LCT-ADR-002` are open; A4 is a CANDIDATE; A5 is
gated; A6's reporting path is self-blocked.

| # | Item | Blocked by |
|---|---|---|
| 1 | Register the `LCT-` prefix | `PRD_LIFECYCLE.md` §5 rule 3 |
| 2 | Resolve `LCT-ADR-001` | Social Domain owner |
| 3 | ✅ **DONE — `LCT-ADR-002` resolved by AO-5, 2026-08-31.** Event Replay stays V3; A2 `LCF-NFR-006` is conditional/deferred at A2 **L1526**. ⚠ Resolving the decision does **not** make item 3's downstream work buildable — nothing on this list is buildable while Stage 3 is unconferred | Architecture Owner |
| 4 | Resolve `LCS-ADR-001` (reporting) | Architecture Owner |
| 5 | Resolve `LCF-ADR-003` (pagination) | Architecture Owner |
| 6 | Resolve `LCT-GAP-005`/`006` (media, search) | Architecture Owner |
| 7 | Resolve A4's CANDIDATE status | Product Owner |
| 8 | Extend the Multi-Tenant Test Suite to community scope | after 1–7 |
| 9 | Implement §8 flows | after 1–8 |
| 10 | Implement §9 key composition on all five surfaces | with 9 |
| 11 | Implement §13.3 degraded modes + §39.4 tests | with 9 |
| 12 | Wire §26 observability signals | with 9 |

---

## 43. Final Architecture Consistency Audit

### 43.1 Self-measurement

| Assertion | Measured |
|---|---|
| New bounded contexts | **0** — remains 31 |
| New context edges | **0** — remains 26 |
| New aggregates | **0** |
| New domain events | **0** |
| New permissions | **0** |
| New roles | **0** |
| New infrastructure components | **0** |
| New numeric values | **0** |
| ADRs written | **0** (2 routed) |
| Existing files modified | **0** |
| Prohibited technologies introduced | **0** of 8 |
| V3/Future capabilities depended upon | **0** |

### 43.2 Ownership audit — the `LCT-INV-001` test

| Owner | Scope retained? | Evidence |
|---|---|---|
| Enterprise Architecture | ✅ Full | A8 cites tags; adds no node |
| Module Dependency Matrix | ✅ Full | A8 cites `L2`; §24.1 records `BC-15`'s absence as a gap |
| `ADR-0001` | ✅ Full | §5.1, §24.2 |
| A1–A5 technical sections | ✅ Full | §§12, 13, 15.5, 23 delegate to them by identifier |
| Existing Stage-3 record | ✅ Full | No finding added; no stage conferred |
| `BC-13` / `PRD-020` | ✅ Full | §21, §22.4; §8.3 refuses to design a reporting flow |
| `BC-22` | ✅ Full | §15, §22.6 delegate to A7's delegations |
| `BC-11` | ✅ Full | §22.7 |
| `BC-18` | ✅ Full | §17, §20.2 |
| A2, A3, A4, A5, A6, A7 | ✅ Full | §6.1 |

### 43.3 Six-check advisory self-review

⚠ **Advisory only.** Stage 3 is a reviewer act; A8 confers nothing.

| Check | Self-review | Note |
|---|---|---|
| 1 Context ownership exclusive | ✅ | A8 owns no context |
| 2 Every integration edge exists in §7 | ⚠⚠ **STILL Conditional — and now for a SHARPER, MEASURED reason.** A8 proposes no edge. Of the three needed paths it documented as having none: ✅ **media** is now `E-29` (**AO-3**) and ✅ **blocks/rate limits** are now `E-28` (**AO-1**), both admitted to BC Map §15.1. ⛔ **search is REFUSED** (**AO-9** — condition failed). ⛔⛔ **But a NEW and more serious finding replaces the old one:** re-measured on the live §7 table at v1.9, **`BC-15` is the source of ZERO edges** — `E-14`, `E-28` and `E-29` are **all inbound**. So A4's `GroupCreated`/`GroupMembershipGranted`/`GroupMembershipRevoked` are **unpublishable** (`LCG-ADR-002`, OPEN) and A6 cannot **file** a report (`LCS-ADR-001b`, OPEN). ⭐ This is a **genuine Stage-3 Check-2 failure** for A4 and A6, and it is recorded as a failure rather than absorbed into the *disclosed-and-gated* standard — disclosure is not satisfaction |
| 3 Rank direction downward | ✅ | §24.1; `LCT-GAP-002` disclosed |
| 4 No authorization outside `BC-18` | ✅ | §17, §20.2 |
| 5 No credential/OTP/session outside `BC-18` | ✅ | A8 mentions none |
| 6 Tenant scoping correct | ✅ **PASS** (was ⚠ Conditional) | §9 complies with `ID-2`, and `LCT-CONF-002` is ✅ **RESOLVED by AO-6** — BC Map §15.4 `EV-1`…`EV-4` record that `BC-15` events carry no `tenantId`, with `ID-2` **preserved rather than excepted**. ⚠ The BC Map **L450** *wording* residue survives (Rank 4 prose, unamended by design), but it is no longer a **rule** conflict |

### 43.4 Register state

| Register | Count |
|---|---|
| `LCT-G-*` goals | 6 |
| `LCT-NG-*` non-goals | 10 |
| `LCT-AP-*` principles | 7 |
| `LCT-OWN-*` | 6 |
| `LCT-FR-*` | 119 — contiguous `001`–`119`, no gaps |
| `LCT-SEC-*` | 10 |
| `LCT-INV-*` | 7 |
| `LCT-XC-*` | 3 |
| `LCT-AC-*` | 35 |
| `LCT-R-*` risks | 8 |
| `LCT-GAP-*` | 11 |
| `LCT-CONF-*` | 2 |
| `LCT-ADR-*` | 2 |
| **Total** | **226** |

⭐ **The `LCT-FR-*` count was corrected from 118 to 119 by A8's own §43 audit
before publication.** Recorded rather than silently amended, because a register
that disagrees with its document is the defect class A8 exists to catch: A2's
`LCF-GAP-002`/`003` non-contiguity and the `ADR-INDEX` L9-vs-L111 drift (⚠ **cited as L110 before `ADR-0083` was registered**) are the
same class. ✅ **The `ADR-INDEX` one is now CLOSED** — both count cells were re-derived from the files on 2026-08-31 rather than reconciled against each other. ⚠ **A2's `LCF-GAP-002`/`003` non-contiguity remains open upstream**, and is untouched by these rulings. ⭐ A8 was right that a register disagreeing with its own document is a defect class worth naming: it caught this one in `ADR-INDEX`, and the repair followed A8's own standard of re-measuring rather than patching.

### 43.5 Final determination

`LCT-FR-119` | A8 v0.1 is a **DRAFT**. It is not reviewed, not aligned, not
frozen, and confers no stage on itself or on any sibling part.

⭐ **A8's substantive result is a negative one, and that is the correct
result.** PRD-021A requires no new architecture: fifteen technical needs map
onto fifteen capabilities the Enterprise Architecture already enumerates in the
V1 or V2 band (§5.4). What PRD-021A actually lacks is not infrastructure but
**three registered paths** — reporting, media and search — and **two owner
rulings** on contracts its own parts have written inconsistently. A8 names all
five and resolves none, because none is A8's to resolve.

---

*End of PRD-021A — Part A8 — Technical & Production Architecture — DRAFT v0.1*
