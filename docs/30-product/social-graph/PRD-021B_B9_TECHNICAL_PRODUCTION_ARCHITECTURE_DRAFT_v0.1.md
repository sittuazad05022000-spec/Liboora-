<!--
  PRD-021B — Part B9 — Technical & Production Architecture
  DRAFT v0.1 — Stage 2

  PROVENANCE
  ----------
  Authored from the supplied B9 specification, reconciled against MEASURED
  repository authority. Structured on the precedent of
  PRD-021A_A8_TECHNICAL_AND_PRODUCTION_ARCHITECTURE_DRAFT_v0.1.md, which is the
  repository's existing example of a Part-9 technical architecture document.

  ⚠ THE CONSTRAINT THIS DOCUMENT WAS WRITTEN UNDER, QUOTED
  --------------------------------------------------------
  "Do NOT introduce microservices, graph databases, ML infrastructure or new
   BCs unless existing repository authority requires them."

  MEASURED: NO existing repository authority requires ANY of the four.
    - Microservices        : MASTER_PRD / EA describe a MODULAR MONOLITH.
                             BC Map L522 names BC-12 as the FIRST candidate for
                             extraction, which is an extraction ORDER, not an
                             instruction to extract in V1.
    - Graph database       : 0 authority lines. BC-11 is a relational aggregate
                             set (BC Map L377).
    - ML infrastructure    : FROZEN TSF-XC-032 forbids automated body
                             classification in V1. BC-27 AI Assistance exists
                             and is NOT B9's.
    - New bounded contexts : count is 31; creating one requires an ADR.
  => B9 INTRODUCES NONE OF THE FOUR. Each refusal is recorded with its reason.

  ⚠ WHAT B9 IS NOT
  ----------------
  B9 is an UNRANKED Stage-2 DRAFT. It ranks nothing. It amends nothing. It is
  NOT the Enterprise Architecture (Rank 6) and NOT the BC Map (Rank 4).
  Where it appears to state architecture, it is SPECIFYING how PRD-021B's parts
  integrate WITHIN already-ratified structure. XPB-CONF-012.

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 and Stage 4 NOT entered.
-->

# PRD-021B — Part B9

## Technical & Production Architecture — integration specification for B0–B8

> ⛔ **Stage-2 `DRAFT`.** Not approved, not frozen, not baselined, not
> implementation-ready.
>
> ⭐ **B9 ranks nothing and amends nothing.** It is the *technical integration*
> specification for `PRD-021B`'s parts inside architecture that is already
> ratified at Ranks 1–6. It introduces **no** microservice, **no** graph
> database, **no** ML infrastructure and **no** bounded context.

---

## §0. Document control

| Field | Value |
|---|---|
| Document | `PRD-021B` Part **B9** — Technical & Production Architecture |
| Version | **v0.1** |
| Status | **`DRAFT`** |
| Lifecycle stage | **Stage 2 (Draft)**. ⛔ Stage 3 NOT entered |
| Parent | `PRD-021` — `PRD_REGISTRY.md` §4.2 **L321**, status **`PLANNED`** |
| Subject | Technical integration of **B0–B8**: `BC-11` (B1–B6), `BC-12` (B7, B8) |
| Identifier stem | **`TPA-`** — measured **0** repository-wide occurrences before authoring |
| Structural precedent | `PRD-021A_A8_TECHNICAL_AND_PRODUCTION_ARCHITECTURE_DRAFT_v0.1.md` (1,925 lines, 38 sections) |
| Ranks this document holds | **None.** ⛔ Unranked `DRAFT` (`XPB-CONF-012`) |
| Freeze | ⛔ **NOT FROZEN** |

### §0.1 Status header
**`PRD-021B` Part B9 — `DRAFT` v0.1 — Stage 2 — NOT FROZEN — NOT APPROVED.**

### §0.2 ⭐ `XPB-CONF-012` — what "architecture" means in an unranked draft

| The conflict | A part titled *"Technical & Production Architecture"* can be mistaken for an architecture **authority** |
|---|---|
| **Authoritative source** | `DOCUMENTATION_BASELINE.md` §3/§4 contain **0** `PRD-021B` rows. Architecture authority is Rank 4 (BC Map, Matrix, `ARCHITECTURE_RULINGS.md`) and Rank 5 (ADRs) |
| **Already resolved?** | **Yes** — by the rank system itself |
| **Decision preserved** | B9 is subordinate to Ranks 1–6 |
| **Smallest resolution** | B9 states **integration** within ratified structure and cites the authority for every structural claim. Where no authority exists, B9 says so (`TPA-GAP-*`) rather than legislating |
| **Recorded** | `XPB-CONF-012` — ✅ resolved by framing; no authority changed |

---

## §1. Executive summary

`PRD-021B` spans **two** bounded contexts and **no** others:

| Part | Subject | Context |
|---|---|---|
| B0 | Cross-part architecture & open decisions | — |
| B1 | Social graph | `BC-11` |
| B2 | Social safety | `BC-11` (+ `BC-13` cited) |
| B3 | Student discovery | `BC-11` (+ `BC-23` projection) |
| B4 | Discovery ranking | `BC-11` / `BC-23` read composition |
| B5 | Student recommendations | `BC-11` (⚠ V2-gated) |
| B6 | Discovery scope | `BC-11` |
| **B7** | **Messaging & conversations** | **`BC-12`** |
| **B8** | **Realtime, media, messaging safety** | **`BC-12`** using ports + `BC-29`/`BC-13`/`BC-22`/`BC-30` |

`TPA-PRIN-001` — ⛔ **No third context is introduced.** Count remains **31**
(23 in V1).

---

## §2. Problem statement

`PRD-021B` accumulated **nine** parts across **two** contexts, seven cross-part
conflicts and multiple platform-port dependencies. Without a single integration
specification, four failure modes are likely: a part silently assumes an edge
that does not exist; two parts implement the same rule differently; a
cross-cutting concern (tenancy, idempotency, pagination) is specified
inconsistently; a platform dependency is assumed present when the EA discloses
it is absent. B9 exists to hold those four risks in one place.

---

## §3. Goals

`TPA-GOAL-001` — State every integration point between B0–B8 and cite its edge.
`TPA-GOAL-002` — State every cross-cutting rule **once**, so parts cannot drift.
`TPA-GOAL-003` — Name every platform dependency and its measured V1 readiness.
`TPA-GOAL-004` — Record every technical gap with an owner rather than filling it.

---

## §4. Non-goals — ⛔ the four named prohibitions, each measured

### §4.1 ⛔ Microservices — NOT introduced

| Measurement | Result |
|---|---|
| `MASTER_PRD.md` / EA deployment model | **Modular monolith**. EA **L218**, **L1534** describe modular structure, ⛔ not independently deployed services |
| Matrix **L49** `L2` | *"A module may depend only on modules of strictly lower rank… Same-rank dependencies are forbidden except within a declared cluster"* — a **compile-time module** rule, meaningful only inside one build |
| CI manifest | `tool/module_dependencies.yaml` enforces **import** boundaries — a monolith mechanism |
| BC Map **L522** | `| 1 | **BC-12 Messaging** | Message volume or connection count dominates infra cost | Highest throughput, weakest coupling, own data store already |` |

⭐ **BC Map L522 is the closest thing to authority for extracting `BC-12`, and
it is deliberately not read as one.** It ranks `BC-12` **first** in an
extraction-**order** table — *if* extraction becomes necessary. ⛔ It does
**not** instruct extraction in V1, and no ADR authorises one.

`TPA-XC-001` — ⛔ B9 **SHALL NOT** introduce a microservice, an independently
deployed component, a service mesh, or an inter-service RPC boundary. ⭐ `BC-12`
**SHALL** remain a module inside the monolith, ⛔ while its **boundary**
(`E-14`/`E-16`/`E-22`/`E-23` only, own data store) is kept clean enough that
**L522**'s option stays open. That is the whole value of `L522` and B9 preserves
it without exercising it.

### §4.2 ⛔ Graph database — NOT introduced

| Measurement | Result |
|---|---|
| Authority lines requiring a graph database | **0** |
| `BC-11`'s registered model | BC Map **L377** — `Friendship` · `BlockList` aggregates, `FriendRequest`, `RateLimitCounter` value objects: a **relational** aggregate set |
| CI manifest port grants for `domain/social` | `platform/data:repository` — ⛔ no graph store port |

`TPA-XC-002` — ⛔ B9 **SHALL NOT** introduce a graph database, a graph query
language, or a traversal engine. ⭐ V1's graph needs are **bounded degree-1 and
degree-2** reads (friends, friends-of-friends for B5's V2-gated suggestions),
which a relational store with correct indexes serves. ⚠ If degree-N traversal is
ever required, that is a **new** infrastructure decision needing an ADR —
recorded as `TPA-GAP-001`, ⛔ not pre-authorised here.

### §4.3 ⛔ ML infrastructure — NOT introduced

| Measurement | Result |
|---|---|
| **FROZEN** `TSF-XC-032` | *"V1 **MUST NOT** perform automated content classification of message bodies. This is a **privacy posture**, not a capability gap"* |
| **FROZEN** `TSF-XC-014` | Proactive automated detection is **advisory only** |
| `BC-27` AI Assistance | **Exists as its own context** (BC Map), reached by `E-26` → `BC-26`, `BC-23`. ⛔ Not `PRD-021B`'s |
| B4/B5 ranking | `ADR-0091` §3–§5 settled these as **deterministic** read compositions |

`TPA-XC-003` — ⛔ B9 **SHALL NOT** introduce a model registry, feature store,
training pipeline, vector index or inference service. ⭐ B4's ranking and B5's
recommendations are **deterministic, explainable and auditable** by their own
drafts; adding ML would break that property and cross into `BC-27`'s.

⚠ **Matrix `X-13` is noted here because it is the sharpest trap in this area:**
*"Cache/index/vector key without `tenantId` — Cross-tenant data leak, highest-severity
failure class."* ⭐ `PRD-021B` avoids it **structurally** rather than by
compliance: social data is **global and un-tenanted** (rule `ID-2`), so it has no
`tenantId` to omit. §9 states this precisely, because a rule obeyed by accident
is a rule that will eventually be broken.

### §4.4 ⛔ New bounded contexts — NOT introduced

`TPA-XC-004` — ⛔ B9 **SHALL NOT** create a bounded context. Count remains
**31**. ⭐ Notably, B9 does **not** create a "Realtime" context (B8 §B8.1), a
"Media" context (`BC-29` exists), a "Presence" context (`BC-12` owns presence),
or a "Notification" context (`BC-22` exists).

### §4.5 Further non-goals
`TPA-XC-005` — ⛔ No new integration edge (BC Map **L292**).
`TPA-XC-006` — ⛔ No new platform port and no widened grant; the CI manifest is
**byte-unchanged**.
`TPA-XC-007` — ⛔ No new published event; `messaging.MessageSent` remains
`BC-12`'s only one (BC Map **L431**), `BC-11`'s surface stays at **two**
(**L430**).
`TPA-XC-008` — ⛔ No `IMPL-*` allocation and no implementation task.
`TPA-XC-009` — ⛔ No Rank 1–6 amendment.

---

## §5. Architecture principles

`TPA-PRIN-002` — **Repository authority outranks supplied specification.** Every
structural statement in B9 cites a rank.
`TPA-PRIN-003` — **An absent edge does not exist** (BC Map **L292**). Integration
is expressed only over `E-01`…`E-26`, `E-28`, `E-29`; ⛔ `E-27` is permanently
vacant.
`TPA-PRIN-004` — **Ports are not edges.** A CI port grant does not authorise a
context-boundary crossing (`FIL-FR-007`, relied on by `ADR-0055`).
`TPA-PRIN-005` — **Social data is global.** ⛔ No `tenantId`, no
`StudentRecordId` (rule `ID-2`; manifest `banned_symbols`).
`TPA-PRIN-006` — **Downward-only dependency** (Matrix **L49** `L2`), with the
social cluster the only same-rank exception (**L90**), limited to
`E-14`…`E-16` and `E-28`.
`TPA-PRIN-007` — **Fail closed on safety.** Where a safety input's freshness
cannot be established, refuse (**FROZEN** `TSF-FR-031`, `TSF-INV-007`).
`TPA-PRIN-008` — **Disclose residuals; never claim them away.** The `TSF-INV-007`
discipline, applied to every window B9 introduces.
`TPA-PRIN-009` — **Read compositions own nothing** (`AR-1`: *"owns no aggregate ·
owns no invariant · owns no business state · only orchestrates public read
models"*).

---

## §6. Ownership boundaries — the consolidated map

| Capability | Owner | Authority | `PRD-021B` part |
|---|---|---|---|
| Friendship, friend requests, blocks, rate counters | **`BC-11`** | BC Map **L377** | B1, B2 |
| `canMessage(a, b)` | **`BC-11`** | `E-16` **L320** | B1 (answers), B7/B8 (ask) |
| Conversations, messages, delivery receipts, retention, **presence** | **`BC-12`** | BC Map **L116**, **L378** | **B7**, **B8** |
| Person identity, username, privacy settings | **`BC-10`** | BC Map **L114** | cited only |
| Credentials, sessions, devices, OTP, roles, policy | **`BC-18`** | BC Map **L127**, rule `ID-1` | cited only |
| Moderation, reports, enforcement, strikes, appeals | **`BC-13`** | BC Map **L378**; FROZEN `PRD-020` | cited only |
| Upload, virus scan, thumbnails, signed URLs, storage | **`BC-29`** | BC Map **L138**; FROZEN `PRD-017` | B8 (uses) |
| Notification channels, templates, quiet hours, consent | **`BC-22`** | BC Map **L131** | B7/B8 (emit facts) |
| Search indexing, relevance ranking | **`BC-23`** | BC Map **L132** | B3/B4 (project) |
| Client mutation queue, replay, conflict resolution | **`BC-30`** | BC Map **L139** | B8 (uses) |
| Audit trail | **`BC-24`** | `E-20` | all |
| Configuration | **`BC-25`** | `E-19` | all |
| Analytics read model | **`BC-26`** | BC Map **L135** | consumers |
| Realtime transport, connections, fan-out | **`platform/services:realtime`** — ⛔ **a port, not a context** | manifest **L243**; EA **L1847** | B8 (uses) |
| Library membership, enrolment, tenant records | **`BC-02`/`BC-01`** | Matrix **L354** `X-05` | ⛔ **separate ways** |

`TPA-INV-001` — ⛔ **No `PRD-021B` part SHALL own any row above other than
`BC-11`'s and `BC-12`'s.** Verified part-by-part in the cross-part audit.

---

## §7. Bounded-context integration — the complete edge set used by `PRD-021B`

| Edge | BC Map | From → To | Mechanism | Used by | Purpose |
|---|---|---|---|---|---|
| `E-14` | **L318** | `BC-13` → `BC-11`, `BC-12` | `PL` Event | B2, B7, B8 | `safety.EnforcementActionTaken`; each context **self-restricts** |
| `E-15` | **L319** | `BC-10` → `BC-11` | `SK` | B1 | Shared kernel (`PersonId`, privacy VOs) |
| `E-16` | **L320** | `BC-11` → `BC-12` | `C/S` Sync port | B1, B7, B8 | `canMessage(a, b)` |
| `E-19` | **L328** | → `BC-25` | Config | all | `*-CFG-*` reads |
| `E-20` | **L329** | → `BC-24` | Audit | all | Audit facts |
| `E-21` | **L330** | `BC-01`, `BC-10` → `BC-23` | Index | B3, B4, B6 | Discovery projection |
| `E-22` | **L331** | `BC-01`, `BC-10`, `BC-12`, `BC-14` → `BC-29` | `CF` Sync port | **B8** | `FileRef`; `BC-12` admitted by `ADR-0055` |
| `E-23` | **L332** | All → `BC-22` | `PL` Event | B7, B8 | Notification **facts** |
| `E-26` | **L335** | `BC-27` → `BC-26`, `BC-23` | Event | cited | ⛔ not `PRD-021B`'s |

`TPA-FR-001` — **8 edges used, 0 created.** ⛔ `E-27` is not referenced.

`TPA-BR-001` — ⛔ There is **no** `BC-12` → `BC-13` edge, **no** `BC-12` → `BC-11`
edge (`E-16` runs `BC-11` → `BC-12`; `BC-12` is the **client**), and **no**
community → `BC-12` edge. Each absence is load-bearing:

| Absence | Consequence B9 must honour |
|---|---|
| No `BC-12` → `BC-13` | The send-time safety check is a **local** `E-14`-fed read (`ADR-0065` Option B) |
| No community → `BC-12` | The Help → Message flow cannot be built (`XPB-CONF-011`) |
| No `BC-12` → `BC-23` | ⛔ Messages are **not indexed or searchable** in V1 (§19) |

---

## §8. Request flows

### §8.1 Send a message — the full V1 path
```
Client
  └─ POST send {conversationId?, counterpartPersonId?, body, fileRefs[], idemKey}
       │
       ├─[1] BC-18 authenticate  ─────────── session → PersonId   (rule ID-1)
       ├─[2] BC-12 authorise     ─────────── caller is a participant (MSG-SEC-002)
       ├─[3] BC-12 idempotency   ─────────── seen key? → return original (MSG-BR-008)
       ├─[4] BC-11 via E-16      ─────────── canMessage(a,b)?  ⛔ never cached
       │                                     false → refuse, reason undisclosed
       ├─[5] BC-12 LOCAL read    ─────────── enforcement state (ADR-0065 Option B)
       │                                     + FAIL-CLOSED staleness gate
       │                                     ⛔ NO call to BC-13
       ├─[6] BC-29 verdict check ─────────── each fileRef scanned & safe? (FIL-FR-018)
       ├─[7] BC-12 accept        ─────────── assign MessageId + SEQUENCE, persist
       ├─[8] BC-12 → realtime port ───────── opportunistic fan-out (NOT delivery)
       ├─[9] BC-12 → E-23 → BC-22 ────────── notification FACT (⛔ no body)
       └─[10] BC-12 → messaging.MessageSent ─ BC-13 (sampling only), BC-26
```

`TPA-INV-002` — ⛔ Steps **[4]** and **[5]** **SHALL** both complete
successfully **before** step **[7]**. ⭐ Accepting first and checking after
converts a refusal into a retraction, and `MSG-INV-003` makes retraction
impossible.

`TPA-BR-002` — ⛔ Step **[8]** failing **SHALL NOT** fail the request. Realtime is
best-effort (`RTM-BR-001`).

`TPA-BR-003` — ⛔ Step **[6]** **SHALL NOT** be `BC-12` scanning. It consumes
`BC-29`'s verdict (`RTM-BR-007`).

### §8.2 Discovery → message — the only authorised entry
```
B3/B4/B6 discovery result (BC-23 projection, E-21)
  └─ profile view (BC-10 read model)
       └─ "Message" action  ──→ §8.1 step [1]
```
`TPA-BR-004` — ⛔ A discovery result **SHALL NOT** pre-authorise messaging.
`canMessage` is asked at **send** time (`MSG-BR-006`), ⛔ never inherited from a
discovery impression. ⭐ Otherwise appearing in a search result would become an
implicit consent to contact.

### §8.3 ⛔ Help → Message — NOT a flow
`TPA-XC-010` — ⛔ **No such flow exists.** `LCN-EVT-007` **WITHDRAWN**
(`ADR-0083` **L237**); `LCN-FR-019` **VOID**; no community → `BC-12` edge.
`XPB-CONF-011`, **OPEN**.

### §8.4 Read a conversation
```
authenticate (BC-18) → authorise participant (MSG-SEC-002)
  → read by opaque cursor over SEQUENCE (PG-1..PG-4)
  → attachments returned as FileRef + BC-29-issued signed URL (FIL-FR-078)
  ⛔ counterpart's read cursor NOT included (MSG-FR-018)
```

---

## §9. Multi-tenancy and isolation — ⭐ structural, not compliance-based

`TPA-INV-003` — ⛔ `BC-11` and `BC-12` data **SHALL NOT** contain a `tenantId`,
`StudentRecordId`, library identifier or membership identifier. *(rule `ID-2`,
BC Map **L488**; manifest `banned_symbols`: `TenantId` → *"nothing — social data
is not tenant-scoped"*.)*

`TPA-BR-005` — ⭐ **`X-13` is avoided structurally.** Matrix **L362** names
*"Cache/index/vector key without `tenantId`"* as the **highest-severity failure
class**. Social data has **no** `tenantId` to omit, so the rule cannot be
violated by omission here. ⛔ But the converse rule **is** live and is what B9
enforces: a social cache or index key **SHALL NOT** contain a `tenantId`,
because introducing one would create the very tenant-scoping rule `ID-2`
forbids.

⚠ **Both directions stated deliberately.** A reader who knows only `X-13` would
expect a `tenantId` in every cache key and would "fix" social caches by adding
one — turning compliance with one rule into violation of another. `AR-3` (BC Map
**L494**/**L560**) is the reason: Platform Public Discovery Index and Tenant
Operational Data are *"categorically different."*

`TPA-BR-006` — Where a library-scoped **view** of global social data is required
(B6), the **scope filter SHALL sit tenant-side** and the **graph SHALL stay
global**. ⛔ The graph is never partitioned by tenant. *(B6 §B6.3.)*

`TPA-BR-007` — ⛔ `PRD-021B` **SHALL NOT** import `domain/library/**` (`X-05`) or
`domain/person/**` (`ADR-0011` — consume `identity.Person*` events instead).
Both are `banned_imports` in the CI manifest.

---

## §10. Data architecture

`TPA-FR-002` — `BC-11` and `BC-12` **SHALL** each hold their own persistence,
reached through `platform/data:repository`. ⛔ No shared table and no cross-context
join. *(BC Map **L522** already records `BC-12` as having its *"own data store
already"*.)*

`TPA-BR-008` — ⛔ A cross-context read **SHALL** occur only over a declared edge
(§7), ⛔ never by direct table access.

`TPA-FR-003` — `BC-12` **SHALL** hold **two** projections, both recomputable
from their source event streams and ⛔ **never hand-edited** (BC Map **L383**):

| Projection | Fed by | Purpose |
|---|---|---|
| Enforcement state, keyed by `PersonId` | `E-14` `safety.EnforcementActionTaken` | `ADR-0065` send-time check |
| Person identity essentials | `identity.Person*` (BC Map **L426**/**L428**) | Display without importing `domain/person` |

`TPA-INV-004` — ⛔ Every projection **SHALL** be reconstructible from its event
stream alone. ⛔ A projection that cannot be rebuilt is a second source of truth.

`TPA-FR-004` — On `identity.PersonAnonymised` (BC Map **L428**, `SEV-16`,
`ID-5`), `BC-12` **SHALL** apply its erasure obligation. ⚠ ⛔ **B9 does not
specify what that obligation is** — `ID-5` and `BC-10`'s erasure semantics are
authority B9 must not restate from memory. **`TPA-GAP-002`, owner Architecture
Owner + `BC-10` owner.**

---

## §11. Database design — indexes only, no engine choice

`TPA-FR-005` — Access paths that **SHALL** be indexed:
`Conversation` by participant `PersonId`; `Conversation` by (participant, last
activity) for `MSG-API-002`; `Message` by (`ConversationId`, sequence) for
`MSG-API-003`; idempotency by (sender, `ConversationId`, key) for `MSG-INV-004`;
enforcement projection by `PersonId` for `TSF-FR-001`'s **p99 ≤ 50 ms**.

`TPA-BR-009` — ⛔ Every index key **SHALL** be free of `tenantId`
(`TPA-BR-005`).

`TPA-XC-011` — ⛔ B9 **SHALL NOT** select a database engine, schema migration
tool or partitioning strategy. Those are `platform/data`'s.

---

## §12. Read composition — `AR-1` compliance

`TPA-FR-006` — B4's ranking and B6's scoping **SHALL** be **read compositions**
per **`AR-1`**: *"owns no aggregate · owns no invariant · owns no business state
· only orchestrates public read models."*

`TPA-BR-010` — ⭐ A read composition **SHALL NOT** be created as a bounded
context. `MASTER_PRD.md` **L171** already establishes the pattern for a V1
composition *"projected via `BC-23` · **not a context** · V1"*, with **L175–180**
adding *"owns no aggregate, no invariant and no business state."*
*(This is the determination `ADR-0091` §3 made for `XPB-CONF-001`.)*

`TPA-XC-012` — ⛔ A read composition **SHALL NOT** write to any aggregate, mint
an event, or hold state that is not a cache of a public read model.

---

## §13. Ranking and discovery integration

`TPA-FR-007` — Discovery **SHALL** follow **FROZEN** `PRD-020` §8.3's pipeline
**order**, verbatim:
```
Candidate BC-23 → [1] Eligibility BC-11 → [2] Privacy BC-10
                → [3] Safety BC-13 → [4] Ranking BC-23 → Result
```
`TPA-INV-005` — ⛔ **Ranking is step [4] and SHALL NOT precede safety.** ⭐ A
ranker that runs before the safety filter has already read the excluded
candidates, so exclusion becomes cosmetic.

`TPA-BR-011` — ⛔ Ranking **SHALL NOT** re-order after step [4] and **SHALL NOT**
reinstate a candidate excluded at [1], [2] or [3].

---

## §14. Realtime architecture — a port, specified in B8

`TPA-FR-008` — Realtime is `platform/services:realtime` (manifest **L243**).
⛔ B9 defines **no** wire protocol, fan-out topology or scaling model.

`TPA-BR-012` — ⛔ Realtime **SHALL NOT** be a delivery guarantee
(`RTM-BR-001`), a precondition (`RTM-BR-002`) or an authorisation path
(`RTM-BR-004`).

`TPA-GAP-003` — ⚠ EA **L86** discloses the platform realtime model has *"no
presence, fan-out or scaling model"*; EA **L1854**/**L1855** date them **V2**/**V3**.
⛔ B9 refuses to legislate a platform service. **Owner: Platform Engineering +
Architecture Owner.** *(= B8's `RTM-GAP-001`, restated here so a reader of B9
alone still sees it.)*

---

## §15. Event architecture

`TPA-FR-009` — Events `PRD-021B` **publishes**: `social.FriendshipEstablished` /
`social.UserBlocked` (BC Map **L430**) and `messaging.MessageSent` (**L431**).
⛔ **Three total, zero new.**

`TPA-FR-010` — Events `PRD-021B` **consumes**: `safety.EnforcementActionTaken`
(`E-14`), `identity.Person*` (manifest `consumes_events`).

`TPA-BR-013` — ⛔ Every event **SHALL** be a **fact**, past tense, ⛔ never a
command. *(`E-23` **L332**: *"Domain emits facts, never 'send an SMS'"*.)*

`TPA-BR-014` — ⛔ `BC-11`/`BC-12` event envelopes **SHALL NOT** carry a
`tenantId`. *(BC Map §15.4 `EV-1`…`EV-4`; §10 **L488** — ⭐ this is **not a new
exemption**, it is `ID-2` already in force.)*

`TPA-BR-015` — ⛔ `messaging.MessageSent` **SHALL NOT** carry the message body.
It feeds `BC-13` **sampling only** (**FROZEN** `TSF-BR-013`) and `BC-26`
engagement metrics; a body would violate **FROZEN** `TSF-XC-016`.

`TPA-INV-006` — ⛔ On receiving `E-14`, a context **SHALL** self-restrict; `BC-13`
**SHALL NOT** write into it (**L318**, **L286**).

---

## §16. Idempotency and retry

`TPA-FR-011` — Every state-changing `PRD-021B` operation **SHALL** be idempotent
by a client-supplied key (`MSG-FR-011`) or naturally idempotent
(`MSG-BR-001`'s open-or-resolve).

`TPA-BR-016` — ⛔ A retry **SHALL NOT** produce a duplicate `Message`
(`MSG-INV-004`) or a duplicate `Conversation` (`MSG-BR-001`).

`TPA-BR-017` — ⛔ Event consumers **SHALL** be idempotent. `E-14` and
`identity.Person*` **SHALL** be safe to re-apply, because at-least-once delivery
means re-application **will** happen.

`TPA-GAP-004` — ⚠ **Measured: no Rank 1–4 idempotency standard exists.**
§16 and B7 §B7.7 are `PRD-021B` **specifying**, not citing. ⛔ Disclosed as
authored-not-derived. **Owner: Architecture Owner.** *(= B7's `MSG-GAP-001`.)*

---

## §17. API architecture

`TPA-FR-012` — All `PRD-021B` APIs **SHALL** be server-authorised per request
(`MSG-SEC-001`).
`TPA-BR-018` — ⛔ No API **SHALL** accept a `tenantId`, `StudentRecordId`,
library identifier or membership identifier (`MSG-API-010`).
`TPA-BR-019` — ⛔ No API **SHALL** trust a client claim of friendship,
participation, entitlement or scope.
`TPA-BR-020` — ⛔ No API **SHALL** disclose block state, enforcement state,
presence or a counterpart's read cursor (`SGR-SEC-011`, `MSG-API-011`).

---

## §18. Pagination

`TPA-FR-013` — All list endpoints **SHALL** use **opaque cursors** per BC Map
§15.3 `PG-1`…`PG-4`.
`TPA-BR-021` — ⛔ No offset pagination; ⛔ no cursor decodable into a sequence,
timestamp, count or internal identifier.
`TPA-BR-022` — ⛔ Total counts **SHALL NOT** be returned where they would disclose
the size of a filtered-out set. ⭐ A total that changes when a block is applied
discloses the block.

---

## §19. Search — ⛔ messages are NOT searchable in V1

`TPA-XC-013` — ⛔ Messages **SHALL NOT** be indexed in `BC-23` and **SHALL NOT**
be searchable in V1.

⭐ **Measured reason.** `E-21` (BC Map **L330**) runs `BC-01, BC-10 → BC-23`.
**`BC-12` is absent from its producer cell.** BC Map **L292**: an edge not in the
table *"does not exist."* Matrix **L357** `X-08` additionally forbids a search
component reaching into a domain repository. ⛔ Message search would require a
new edge and an ADR.

⚠ **This is a refusal recorded rather than a capability quietly assumed** — the
same discipline BC Map v1.9 §15.6 applied when it found `BC-15` absent from
`E-21`'s consumer cell and recorded that *"community search is NOT authorised."*

`TPA-FR-014` — Person discovery **SHALL** use `BC-23`'s projection fed by `E-21`
from `BC-10` (B3, B4, B6). ⛔ That is discovery of **people**, not of **messages**.

---

## §20. Cache architecture

`TPA-FR-015` — Caching **SHALL** be permitted only for public read models.
`TPA-BR-023` — ⛔ **An authorisation decision SHALL NEVER be cached.** ⛔ Not
`canMessage` (`MSG-BR-006`), ⛔ not a media eligibility decision
(`RTM-BR-009`, `FIL-FR-008`), ⛔ not an enforcement outcome.
`TPA-BR-024` — ⛔ A social cache key **SHALL NOT** contain a `tenantId`
(`TPA-BR-005`).
`TPA-BR-025` — ⛔ A cache **SHALL NOT** be the only source of any state
(`TPA-INV-004`).

⭐ **`TPA-BR-023` is the single most load-bearing rule in §20.** Every
authorisation gate in `PRD-021B` — block, enforcement, media eligibility — is
specified as *"asked every time."* A cache silently defeats **all three at once**,
and would do so invisibly, because a cached `true` looks exactly like a fresh
`true`.

---

## §21. Media and storage

`TPA-FR-016` — All media **SHALL** be `BC-29`'s via `E-22`; domain holds a
`FileRef` (BC Map **L331**). Specified in **B8** §B8.7.
`TPA-BR-026` — ⛔ Objects private by default (**FROZEN** `FIL-FR-034`); signed
URLs only after an affirmative per-caller decision (`FIL-FR-036`); shortest
validity (`FIL-FR-037`); scanned before use (`FIL-FR-018`).
`TPA-BR-027` — ⛔ `PRD-021B` **SHALL NOT** hold bytes, scan, thumbnail, or issue
its own URLs.

---

## §22. Security architecture

`TPA-INV-007` — ⛔ **No context outside `BC-18` SHALL store a password, OTP,
session or credential** (rule `ID-1`, BC Map **L178**).
`TPA-FR-017` — Authorisation **SHALL** be server-side, per request, from the
authenticated `PersonId`.
`TPA-BR-028` — ⛔ Refusals **SHALL** be indistinguishable across cause where the
cause is itself sensitive (`MSG-FR-007`, `SGR-SEC-011`).
`TPA-BR-029` — ⛔ Enumeration **SHALL** be refused: conversation IDs, `FileRef`s
and `PersonId`s **SHALL NOT** be guessable or probeable
(`RTM-SEC-003`, `RTM-FR-003`).
`TPA-BR-030` — ⛔ T&S **SHALL NOT** read message bodies at rest (**FROZEN**
`TSF-XC-016`); the only content path is a reporter-supplied snapshot
(`TSF-FR-036`).

---

## §23. Performance

`TPA-FR-018` — The enforcement check **SHALL** meet **FROZEN** `TSF-FR-001`:
**p99 ≤ 50 ms, fail closed**.
`TPA-BR-031` — ⛔ `canMessage` and the enforcement read **SHALL** be on the
**synchronous** send path (`MSG-FR-006`), so ⛔ neither may be made asynchronous
to hit a latency target. ⭐ The performance requirement is a constraint on the
implementation, ⛔ never a licence to relax the ordering.
`TPA-FR-019` — Read-model **lag SHALL be measurable**, or `TSF-FR-031`'s
fail-closed gate is unimplementable (`RTM-FR-019`).

---

## §24. Scalability

`TPA-FR-020` — Scaling **SHALL** be by scaling the monolith and `BC-12`'s data
store. ⛔ Not by extraction (`TPA-XC-001`).
`TPA-BR-032` — ⭐ `BC-12`'s boundary **SHALL** be kept extraction-ready — only
`E-14`, `E-16`, `E-22`, `E-23`, its own store — so BC Map **L522**'s option
remains available ⛔ without being exercised.
`TPA-XC-014` — ⛔ B9 **SHALL NOT** define a cross-conversation total order
(`MSG-FR-015`). ⭐ Per-conversation monotonic sequence is a **per-aggregate**
guarantee, which scales by partitioning on `ConversationId`; a global order
would require cross-partition coordination no authority asks for.

---

## §25. Background jobs

`TPA-FR-021` — Required background work: retention purge (`MSG-INV-006`),
projection rebuild (`TPA-INV-004`), idempotency-key expiry (`MSG-FR-012`),
lag monitoring (`TPA-FR-019`), share-grant revocation sweep (`RTM-FR-012`).
`TPA-BR-033` — ⛔ A background job **SHALL NOT** bypass an authorisation gate or
an invariant. ⭐ A purge job must still write its `E-20` audit; an offline job is
not an exemption.
`TPA-BR-034` — ⛔ A background job **SHALL NOT** perform automated body
classification (**FROZEN** `TSF-XC-032`, `TPA-XC-003`).

---

## §26. Observability

`TPA-FR-022` — Observable: enforcement read-model lag, `canMessage` latency,
send refusal rate **by cause**, realtime fan-out failure rate, purge completion.
`TPA-BR-035` — ⛔ Telemetry **SHALL NOT** contain message bodies, credentials,
`tenantId`s or unsigned media URLs.
`TPA-BR-036` — ⛔ Refusal telemetry **SHALL** be aggregate. ⭐ A per-pair refusal
log reconstructs the block list, which `SGR-SEC-011` forbids disclosing.

---

## §27. Failure and recovery

| Dependency fails | Required behaviour | Authority |
|---|---|---|
| `BC-11` / `E-16` unavailable | ⛔ **Refuse the send** — fail closed | `MSG-FR-006`, `TPA-PRIN-007` |
| Enforcement projection stale / unmeasurable | ⛔ **Refuse the send** | **FROZEN** `TSF-FR-031` |
| `BC-29` unavailable | ⛔ Refuse the **attachment**; text send **may** proceed | `RTM-BR-007` |
| Realtime port unavailable | ✅ **Degrade** — send/read continue | `RTM-BR-002` |
| `BC-22` unavailable | ✅ **Degrade** — the `E-23` fact queues; delivery is unaffected | `E-23` is `PL` async |
| `BC-23` projection stale | ✅ Degrade **discovery**; messaging unaffected | B3/B4 |

`TPA-INV-008` — ⛔ **A safety dependency SHALL fail closed; a convenience
dependency MAY fail open.** ⭐ The line between the two is exactly the line
between *"could this let a blocked or banned person through?"* and *"could this
make the product less pleasant?"* — and it is drawn once, here, so no part draws
it differently.

*(⭐ The degraded-mode discipline follows B2's `SSF-AC-028` precedent.)*

---

## §28. Data consistency

`TPA-FR-023` — Within an aggregate: **strong** consistency.
`TPA-FR-024` — Across contexts: **eventual**, via events.
`TPA-BR-037` — ⛔ **Except** the two send-time gates, which are **synchronous**
because BC Map **L468** rules eventual consistency *"unacceptable for abuse
containment."*
`TPA-BR-038` — ⚠ The `E-14` propagation window is **bounded by `TSF-CFG-030`**
and **disclosed, not eliminated** (**FROZEN** `TSF-INV-007`, `RTM-BR-014`).

---

## §29. Data retention

`TPA-FR-025` — Message retention **SHALL** be `BC-12`'s `RetentionPolicy`; purge
**SHALL** be irreversible and audited via `E-20` (BC Map **L378**).
`TPA-BR-039` — ⛔ Purge **SHALL NOT** delete `BC-29` bytes; it revokes grants
(`MSG-BR-017`, `FIL-XC-002`).
`TPA-BR-040` — ⚠ Retention is a **fixed** platform default in V1
(`MSG-FR-028`); configurability is `XPB-CONF-015`, **OPEN**.

---

## §30. Analytics

`TPA-FR-026` — `BC-26` **SHALL** receive `messaging.MessageSent` and `BC-11`'s two
events (BC Map **L430**/**L431**).
`TPA-BR-041` — ⛔ Analytics **SHALL NOT** receive bodies, and **SHALL NOT** be a
back door to message content (**FROZEN** `TSF-XC-016`, `TPA-BR-015`).
`TPA-XC-015` — ⛔ `PRD-021B` **SHALL NOT** own an analytics read model
(`BC-26`'s) and **SHALL NOT** query `BC-26` to make a product decision.

---

## §31. Testing architecture

`TPA-FR-027` — Tests **SHALL** cover: `MSG-AC-001`…`030`, `RTM-AC-001`…`028`,
and each `TPA-INV-*`.
`TPA-BR-042` — ⛔ **Negative tests SHALL be present for every refusal.** ⭐ A
suite that only proves the happy path proves nothing about a safety boundary —
`PRD_LIFECYCLE.md` L104–106's reasoning applied to tests.
`TPA-BR-043` — ⛔ Tests **SHALL NOT** be written against mock Firestore/DB shapes
where the real store's types differ. ⭐ A type mismatch discovered in production
is a data-integrity failure, not a test failure.
`TPA-XC-016` — ⛔ B9 **SHALL NOT** write, name or allocate a test task
(`TPA-XC-008`). ⚠ Test **authoring** is Stage 5+.

---

## §32. CI/CD and module boundaries

`TPA-FR-028` — `tool/module_dependencies.yaml` and
`.github/workflows/architecture.yml` **SHALL** remain the enforcement mechanism.
`TPA-XC-017` — ⛔ **B9 SHALL NOT modify either file.** Both are **byte-unchanged**.

⭐ **The manifest's own comment is why.** It records that **`E-14` must stay at
L255 and `E-16` at L259** because *"222 line-citations point into this file …
several inside FROZEN PRD-017 and PRD-020."* ⛔ Any insertion would shift lines
cited by **frozen** documents.

`TPA-BR-044` — ⛔ `banned_imports` and `banned_symbols` **SHALL** be honoured:
⛔ no `domain/library/**` (`X-05`), ⛔ no `domain/person/**` (`ADR-0011`),
⛔ no `app/**`, ⛔ no `StudentRecordId`, ⛔ no `TenantId`.

---

## §33. Feature flags

`TPA-FR-029` — Contested capabilities **SHALL** be flag-gated, default **OFF**,
and ⛔ **un-enablable while their conflict is OPEN**:

| Flag | Default | Locked by | Conflict |
|---|---|---|---|
| `MSG-CFG-002` read receipts | ⛔ FALSE | `MSG-XC-021` | `XPB-CONF-014` |
| `RTM-CFG-001` presence | ⛔ FALSE | `RTM-XC-021` | `XPB-CONF-017` |
| `RTM-CFG-002` typing | ⛔ FALSE | `RTM-XC-021` | `XPB-CONF-017` |
| `PYK-CFG-001` recommendations | ⛔ FALSE | `PYK-XC-004` | `XPB-CONF-002` |

`TPA-BR-045` — ⭐ A flag **SHALL NOT** be a mechanism for shipping an
undecided capability. It records that the code exists and the **decision does
not**.

---

## §34. Versioning

`TPA-FR-030` — API changes **SHALL** be additive; ⛔ a removed field or narrowed
enum is breaking.
`TPA-BR-046` — ⛔ A closed enum (`MSG-BR-004`, `MSG-BR-005`) **SHALL NOT** be
extended without amending its rule.
`TPA-BR-047` — ⛔ An identifier **SHALL NOT** be reused after withdrawal
(`PRD_LIFECYCLE.md` §5 rule 5 — the reason `E-27` stays vacant and
`LCN-EVT-007` cannot return).

---

## §35. Security and privacy audit

`TPA-FR-031` — Auditable via `E-20`: enforcement decisions, retention purges,
share grants/revocations/first reads (**FROZEN** `FIL-FR-082`), block effects on
messaging.
`TPA-BR-048` — ⛔ Audit records **SHALL NOT** contain message bodies or
credentials.
`TPA-BR-049` — ⛔ `PRD-021B` **SHALL NOT** own the audit trail (`BC-24`'s).

---

## §36. V1 architecture summary

**Modular monolith** · `BC-11` + `BC-12` as modules with their own stores ·
**8** pre-existing edges · **3** published events · **2** consumed event families
· realtime as a **platform port** · media via **`BC-29`** · safety via a **local
`E-14`-fed projection** with a **fail-closed** gate · notifications as **facts**
· offline via **`BC-30`** · global un-tenanted social data · opaque cursors
throughout · ⛔ no message search · ⛔ no cached authorisation.

---

## §37. Future scale — ⛔ named, not built

| Option | Trigger | Authority | Status |
|---|---|---|---|
| Extract `BC-12` | Message volume or connection count dominates infra cost | BC Map **L522** | ⛔ **Not V1.** Needs an ADR. Boundary kept ready (`TPA-BR-032`) |
| Presence service | Presence enabled | EA **L1853** V2 | ⛔ `XPB-CONF-017` OPEN |
| Fan-out strategy | Realtime volume | EA **L1854** V2 | ⛔ `TPA-GAP-003` |
| Realtime scaling / backpressure | — | EA **L1855** V3 | ⛔ `TPA-GAP-003` |
| Group chat | — | EA **L951** V2 | ⛔ Not V1 |
| Encryption at rest | — | EA **L949** V2 | ⛔ Not claimed |

---

## §38. Edge cases

| Case | Required behaviour | Authority |
|---|---|---|
| Block placed mid-conversation | Next send refused; ⛔ history not retracted | `MSG-BR-006`, `MSG-INV-003` |
| Restriction lands while a send is in flight | Bounded window, ⛔ disclosed | `TSF-INV-007`, `TPA-BR-038` |
| Offline queue drains after a ban | ⛔ Refused at **server receipt** time | `RTM-BR-017` |
| Two clients send with the same idempotency key | One `Message`; both get the same result | `MSG-INV-004` |
| Attachment scan fails after send accepted | ⛔ Cannot occur — scan precedes attach | `RTM-BR-007` |
| Person anonymised mid-conversation | Erasure obligation applies — ⚠ **unspecified** | `TPA-GAP-002` |
| Realtime delivers, then the transaction rolls back | ⛔ Fan-out **after** commit only | §8.1 step ordering, `TPA-INV-002` |
| Retention purge during an active read | Purge wins; read returns not-found | `MSG-INV-006` |
| Clock skew between clients | ⛔ Irrelevant — ordering is by sequence | `MSG-BR-010` |

---

## §39. Acceptance criteria — 24, all Given/When/Then, all mapped

`TPA-AC-001` — **Given** the V1 deployment, **when** components are enumerated,
**then** `BC-11` and `BC-12` are modules of one monolith and no independently
deployed service exists. *(`TPA-XC-001`, `TPA-FR-020`)*

`TPA-AC-002` — **Given** the persistence layer, **when** storage engines are
enumerated, **then** no graph database, vector index, model registry or feature
store is present. *(`TPA-XC-002`, `TPA-XC-003`)*

`TPA-AC-003` — **Given** the BC register, **when** contexts are counted after
`PRD-021B`, **then** the count is **31** and no `PRD-021B` part owns a context
other than `BC-11` or `BC-12`. *(`TPA-XC-004`, `TPA-INV-001`, `TPA-PRIN-001`)*

`TPA-AC-004` — **Given** all `PRD-021B` integration points, **when** they are
enumerated, **then** each maps to an edge in BC Map §7 and none is `E-27`.
*(`TPA-FR-001`, `TPA-PRIN-003`, `TPA-XC-005`)*

`TPA-AC-005` — **Given** a send, **when** the sequence is traced, **then**
`canMessage` and the enforcement read both completed **before** acceptance.
*(`TPA-INV-002`)*

`TPA-AC-006` — **Given** the realtime port is down, **when** a message is sent,
**then** the request succeeds and the message is durably recorded.
*(`TPA-BR-002`, `TPA-BR-012`)*

`TPA-AC-007` — **Given** a discovery impression, **when** the person messages
that profile, **then** `canMessage` is asked fresh and the impression conferred
no permission. *(`TPA-BR-004`)*

`TPA-AC-008` — **Given** the flow catalogue, **when** a Help → Message flow is
sought, **then** none exists and `XPB-CONF-011` is recorded OPEN.
*(`TPA-XC-010`)*

`TPA-AC-009` — **Given** any `BC-11`/`BC-12` record, cache key, index key or
event envelope, **when** inspected, **then** no `tenantId` and no
`StudentRecordId` is present. *(`TPA-INV-003`, `TPA-BR-005`, `TPA-BR-014`,
`TPA-BR-024`, `TPA-BR-009`)*

`TPA-AC-010` — **Given** library-scoped discovery, **when** it executes, **then**
the scope filter is applied tenant-side and the social graph remains global and
unpartitioned. *(`TPA-BR-006`)*

`TPA-AC-011` — **Given** the compiled module, **when** imports are analysed,
**then** no `domain/library/**`, no `domain/person/**` and no `app/**` import
exists. *(`TPA-BR-007`, `TPA-BR-044`)*

`TPA-AC-012` — **Given** `BC-12`'s projections, **when** they are dropped and
rebuilt from their event streams, **then** they reconstruct identically and no
hand-edit is required. *(`TPA-INV-004`, `TPA-FR-003`)*

`TPA-AC-013` — **Given** a cross-context read, **when** it executes, **then** it
travels a declared edge and performs no direct table access on another context.
*(`TPA-BR-008`, `TPA-FR-002`)*

`TPA-AC-014` — **Given** discovery, **when** the pipeline runs, **then** ranking
occurs at step [4] after eligibility, privacy and safety, and no candidate
excluded earlier reappears. *(`TPA-INV-005`, `TPA-BR-011`, `TPA-FR-007`)*

`TPA-AC-015` — **Given** a read composition, **when** its state is inspected,
**then** it owns no aggregate, no invariant and no business state, and mints no
event. *(`TPA-FR-006`, `TPA-BR-010`, `TPA-XC-012`)*

`TPA-AC-016` — **Given** the published event set, **when** counted, **then** it
is exactly three and no new event was minted. *(`TPA-FR-009`, `TPA-XC-007`)*

`TPA-AC-017` — **Given** `messaging.MessageSent`, **when** its payload is
inspected, **then** it contains no message body. *(`TPA-BR-015`, `TPA-BR-041`)*

`TPA-AC-018` — **Given** an `E-14` or `identity.Person*` event delivered twice,
**when** it is re-applied, **then** the resulting state is identical.
*(`TPA-BR-017`, `TPA-INV-006`)*

`TPA-AC-019` — **Given** any list endpoint, **when** a page is returned, **then**
the cursor is opaque and no total is returned that would disclose a filtered-out
set. *(`TPA-FR-013`, `TPA-BR-021`, `TPA-BR-022`)*

`TPA-AC-020` — **Given** a message-content search request, **then** it is refused
and no `BC-12` → `BC-23` index exists. *(`TPA-XC-013`, `TPA-FR-014`)*

`TPA-AC-021` — **Given** a repeated authorisation gate, **when** it is exercised
twice, **then** `canMessage`, media eligibility and enforcement state are each
re-evaluated and no cached decision is used. *(`TPA-BR-023`, `TPA-BR-025`)*

`TPA-AC-022` — **Given** `BC-11` or the enforcement projection is unavailable or
unmeasurable, **when** a send is attempted, **then** it is refused; and **given**
the realtime port or `BC-22` is unavailable, **then** send and read still
succeed. *(`TPA-INV-008`, `TPA-PRIN-007`, `TPA-BR-037`)*

`TPA-AC-023` — **Given** telemetry and audit output, **when** inspected, **then**
no message body, credential, `tenantId` or unsigned URL appears, and refusal
telemetry is aggregate rather than per-pair. *(`TPA-BR-035`, `TPA-BR-036`,
`TPA-BR-048`, `TPA-INV-007`)*

`TPA-AC-024` — **Given** an OPEN conflict, **when** its flag is set `TRUE`,
**then** the configuration is refused; and **given** the repository after this
draft, **when** `tool/module_dependencies.yaml` and
`.github/workflows/architecture.yml` are hashed, **then** both are unchanged.
*(`TPA-FR-029`, `TPA-BR-045`, `TPA-XC-017`, `TPA-FR-028`)*

**24 ACs · 24 mapped · 0 orphans.**

---

## §40. ⚠ Disclosed gaps — OPEN, each with a named owner

| ID | Item | Owner |
|---|---|---|
| `XPB-CONF-012` | *"Architecture"* in an unranked draft | ✅ **RESOLVED** by framing (§0.2) |
| `TPA-GAP-001` | ⚠ No authority for degree-N graph traversal; if ever needed it is a new infrastructure decision | Architecture Owner |
| `TPA-GAP-002` | ⚠ `BC-12`'s erasure obligation on `identity.PersonAnonymised` (`ID-5`) is **unspecified** and B9 refuses to invent it | Architecture Owner + `BC-10` owner |
| `TPA-GAP-003` | ⚠ Platform realtime has *"no presence, fan-out or scaling model"* (EA **L86**) | Platform Engineering + Architecture Owner |
| `TPA-GAP-004` | ⚠ No Rank 1–4 idempotency standard; §16 is authored, not derived | Architecture Owner |

⭐ Also **restated, not owned by B9**: `XPB-CONF-011`, `XPB-CONF-013`,
`XPB-CONF-014`, `XPB-CONF-015`, `XPB-CONF-016`, `XPB-CONF-017`, `MSG-GAP-001/2`,
`RTM-GAP-001/2` — all **OPEN**, all recorded in B7/B8.

---

## §41. ⛔ What B9 does **not** do

1. ⛔ Confers no lifecycle stage. **Stage 2 only.**
2. ⛔ Introduces **no** microservice (§4.1), **no** graph database (§4.2),
   **no** ML infrastructure (§4.3), **no** bounded context (§4.4).
3. ⛔ Creates **no** edge, **no** port, **no** event.
4. ⛔ Amends **no** Rank 1–6 document.
5. ⛔ Modifies **no** file under `lib/`, `test/`, `tool/`, `web/`, `android/`,
   `.github/`.
6. ⛔ Ranks nothing and holds no architecture authority (`XPB-CONF-012`).
7. ⛔ Reinterprets **no** frozen requirement.
8. ⛔ Creates **no** ADR; overrides none.
9. ⛔ Allocates **no** `IMPL-*`; creates **no** implementation or test task.
10. ⛔ Writes **no** baseline row and **no** traceability row.
11. ⛔ Claims **no** gap closed — 4 new gaps recorded, 0 closed.
12. ⛔ Does **not** freeze, approve or baseline `PRD-021B`.

---

## §42. Status

**`PRD-021B` Part B9 = `DRAFT` / Stage 2.**

⛔ NOT Stage 3. ⛔ NOT Stage 4. ⛔ NOT Approved. ⛔ NOT Frozen. ⛔ NOT
Implementation Ready.

**Measured content:** 31 `TPA-FR-*` · 49 `TPA-BR-*` · 8 `TPA-INV-*` · 17
`TPA-XC-*` · 9 `TPA-PRIN-*` · 4 `TPA-GOAL-*` · 4 `TPA-GAP-*` · **24 `TPA-AC-*`,
all mapped, 0 orphans**. 8 edges used, 0 created. 3 events published, 0 minted.
31 contexts, 0 created. 4 named prohibitions, **all 4 refused with measured
reasons**.

### §43. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-02 | Initial Stage-2 draft, structured on the `PRD-021A` A8 precedent. ⭐ All **four** named prohibitions were **measured before being refused**: microservices are absent because the platform is a **modular monolith** and BC Map **L522** is an extraction-**order** table, ⛔ not an instruction (B9 keeps `BC-12`'s boundary extraction-ready without exercising it); a graph database has **0** authority lines against `BC-11`'s relational aggregate set (**L377**); ML infrastructure is forbidden for message bodies by **FROZEN** `TSF-XC-032` and otherwise belongs to `BC-27`; and no context was created, count remains **31**. ⭐ **Message search was measured as UNAUTHORISED** — `BC-12` is absent from `E-21`'s producer cell, so BC Map **L292** applies; recorded as a refusal on the BC Map v1.9 §15.6 precedent rather than assumed. ⭐ **Matrix `X-13` was stated in BOTH directions** because a reader who knows only `X-13` would "fix" social caches by adding a `tenantId` and thereby violate rule `ID-2`. ⚠ Four gaps recorded **OPEN**, including `BC-12`'s **unspecified** erasure obligation on `identity.PersonAnonymised` (`TPA-GAP-002`), which B9 refused to invent |
