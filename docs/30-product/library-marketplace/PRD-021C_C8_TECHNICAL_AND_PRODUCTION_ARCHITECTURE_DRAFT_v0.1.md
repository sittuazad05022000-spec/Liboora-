<!--
  PROVENANCE
  Document      : PRD-021C — Part C8
  Created       : 2026-09-03
  Lifecycle     : DRAFT — Stage 2 (authored). Stage 3 NOT entered.
  Authority     : Repository-measured. See §14 Traceability.
  Rank          : none (product part). Amends no Rank 1–6 document.
  Prefix        : LMT-  (measured 0 occurrences repo-wide before authoring)
  Scope         : Technical & production architecture for PRD-021C parts C1–C7
  Creates       : 0 bounded contexts · 0 edges · 0 events · 0 aggregates ·
                  0 tables · 0 indexes · 0 queues · 0 worker pools · 0 cron jobs ·
                  0 caches · 0 permissions · 0 roles · 0 numeric budgets ·
                  0 ADRs · 0 IMPL-* · 0 lines of code
  Modifies      : 0 existing files
  ⛔ This part does NOT freeze, approve, baseline, or confer any lifecycle stage.
-->

# PRD-021C — PART C8

## Technical & Production Architecture — the Composition Layer for C1–C7, Built Entirely from Existing Conventions

### v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — Stage 2.** This part is authored, not aligned, not approved, not
> frozen and not baselined. ⛔ No Stage-3 alignment record exists for `PRD-021C`
> and this document does not create one. ⛔ No `IMPL-*` task is minted.

| Field | Value |
|---|---|
| **PRD** | `PRD-021C` — Library Marketplace |
| **Part title** | Technical & Production Architecture for C1–C7 |
| **Version** | v0.1 |
| **Status** | **DRAFT** — Stage 2 |
| **Structural classification** | ⛔ **NOT a bounded context.** The composition/read-model architecture of a capability that `MASTER_PRD.md` **L171** classifies *"not a context"* |
| **Release** | V1 |
| **Identifier prefix** | `LMT-` |
| **Owns** | The **statement** of how C1–C7 compose over existing infrastructure · the **seven-column ownership record** for every entity and integration C1–C7 touch · the **prohibition register** that keeps the composition from acquiring infrastructure |
| **Consumes** | Every convention named in §0.4. ⛔ Creates none |
| **Cross-part** | Inherits `XPC-OD-004`/`005`/`006` (OPEN, untouched) · `XPC-OD-008` (C5) · `XPC-OD-009` (C6) · `XPC-OD-010` (C7) · **`TSF-GAP-009`** (OPEN, upstream) · **`GAP-BCMAP-BC26-EDGES`** (OPEN, upstream) |

---

## §0 What this part is, and what it refuses to be

### §0.1 ⭐⭐ The central finding

**C1–C7 require ZERO new infrastructure.** Every technical need they generate is
already met by a convention the repository has already declared, and C8's work is
to **name the convention and the owner**, not to design a mechanism.

⭐ This is the same finding `PRD-021A` A8 reached for the social capability — its
§0.2 records *"New infrastructure components | **0** | ⭐ the central finding"*.
C8 reaches it for the marketplace capability, by the same method and with the
same discipline.

The instruction is explicit and C8 obeys it literally: *"do NOT invent
infrastructure. Reuse existing repository: database conventions, API conventions,
event conventions, auth, caching, indexing, jobs, observability, booking/seat
systems, analytics."*

### §0.2 Self-measurement — what this document creates

| Class | Count | Note |
|---|---|---|
| New bounded contexts | **0** | Count remains **31 (23 in V1)** |
| New context edges | **0** | ⛔ Set remains **29**, `E-27` permanently vacant |
| New domain events | **0** | ⭐ C8 registers none and proposes none — §7 |
| New aggregates | **0** | §5 refuses to duplicate any |
| New database tables | **0** | ⭐ §6 — the composition owns no store |
| New indexes | **0** | 📤 `BC-23`; `AR-3` classes unchanged |
| New caches | **0** | §9 — no cache tier is introduced |
| New queues / worker pools / cron jobs | **0** | §8 — `ADR-0058` + `FIL-XC-017` |
| New API conventions | **0** | 📤 §9.1 envelope, `PG-1`…`PG-4` pagination |
| New permissions / roles | **0** | 📤 `BC-18` |
| New metrics | **0** | 📤 `BC-26`; `ADR-0097` untouched |
| New numeric budgets / latency targets | **0** | ⭐ §10 refuses to mint them |
| New infrastructure components | **0** | ⭐⭐ **the central finding** — §0.1 |
| ADRs written | **0** | ⚠ **2 required**, routed in §13 — ⛔ neither written here |
| Existing files modified | **0** | C8 is a new file only |

### §0.3 ⛔ Prohibited technologies and mechanisms

⛔ C8 **MUST NOT** introduce, name as required, or assume: a message broker other
than the declared outbox; a second event bus; a search engine other than
`BC-23`; an analytics store other than `BC-26`; a media store other than
`BC-29`; a graph database; a vector store; an ML model or feature store; a
recommendation service; a CDN configuration; a service mesh; sharding;
multi-region replication; a read replica; a materialised view outside `BC-26`; a
cron scheduler; a distributed lock service; a feature-flag system other than
`BC-25`.

⭐ **Sharding and multi-region are named in the Enterprise Architecture at
L2077/L2078 as FUTURE**, and C8 ⛔ does not promote them.

### §0.4 The conventions C8 reuses, and where each is declared

| # | Convention | Declared at | C8 §ref |
|---|---|---|---|
| 1 | Event naming `<Context>.<Aggregate><PastTenseVerb>` | BC Map §9 | §7.1 |
| 2 | Event Delivery Contract (outbox, at-least-once, idempotency, ordering, envelope, evolution, DLQ, replay) | BC Map **§9.1** | §7.2 |
| 3 | Opaque cursor pagination `PG-1`…`PG-4` | BC Map **L709**–**L712** | §9.3 |
| 4 | `AR-3` two index classes | `ARCHITECTURE_RULINGS.md` **L95**–**L125** | §6.2 |
| 5 | `AR-1` read-model→owner routing | `ARCHITECTURE_RULINGS.md` **L23**–**L50** | §5.2 |
| 6 | Job runtime as a **declared port**, not a deployment | `ADR-0058`; yaml **L338** | §8 |
| 7 | Ambient `TenantContext` (`E-18`) | BC Map **L327** | §6.3 |
| 8 | Typed configuration (`E-19`) | BC Map **L328** | §9.5 |
| 9 | Fire-and-forget outbox-backed audit (`E-20`) | BC Map **L329** | §11 |
| 10 | Index feeding (`E-21`) | BC Map **L330** | §6.2 |
| 11 | `FileRef` media, never bytes (`E-22`) | BC Map **L331** | §5.3 |
| 12 | Profile-view fact (`E-30`) | BC Map **§17.1** | §12 |
| 13 | Rank ladder + `L2` downward-only | yaml **L26**–**L48**; Matrix **L49** | §4 |
| 14 | Consistency model + the three overrides | BC Map **§10**, **§10.1** | §10.2 |
| 15 | Discovery/auth rules `LIB-DISC-001`…`009` | §14A **L302**–**L318** | §9.4 |
| 16 | Rate limiting `LIB-14B.6`/`.41`/`.42` | 14B | §9.6 |
| 17 | Ownership vocabulary + `LCT-INV-001` | A8 **§0.5** | §0.5 |

⭐ **Seventeen conventions, zero of them authored here.**

### §0.5 Ownership vocabulary (adopted, not invented)

✅ **OWNED** · 🔗 **INTEGRATION** · 📤 **DELEGATED** · ⛔ **OPEN OWNER DECISION**
· 🔮 **FUTURE / V2+ SCALE**. Adopted from `PRD-021A` A8 §0.5.

**`LMT-BR-001`** — C8 **SHALL NOT** convert an integration dependency into
ownership. Where C8 must describe a capability owned elsewhere, it **SHALL** cite
the owner's identifier and **SHALL NOT** restate that capability's rules as its
own. *(A8 `LCT-INV-001`, adopted verbatim in force.)*

---

## §1 Identifier registers

| Family | Meaning | Range | Count | Contiguous |
|---|---|---|---|---|
| `LMT-FR-*` | V1 architectural requirement | `LMT-FR-001` … `LMT-FR-026` | 26 | Yes |
| `LMT-BR-*` | Architectural rule / invariant | `LMT-BR-001` … `LMT-BR-012` | 12 | Yes |
| `LMT-XC-*` | Explicit exclusion | `LMT-XC-001` … `LMT-XC-020` | 20 | Yes |
| `LMT-AC-*` | Acceptance criterion (Given/When/Then) | `LMT-AC-001` … `LMT-AC-016` | 16 | Yes |

**Total: 74 identifiers.**

### §1.1 Normative language

**MUST** / **MUST NOT** bind the C1–C7 composition. 📤 **DELEGATED** marks a rule
stated by its owner and ⛔ not restated. 🔗 **INTEGRATION** marks a consumed
dependency. ⛔ **OPEN** marks an unresolved decision with a named owner.

---

## §2 Scope — the seven parts C8 serves

| Part | Prefix | Structural nature | Infrastructure it needs |
|---|---|---|---|
| C1 Marketplace Foundation | `LMP-` | Composition | None new |
| C2 Search & Local Discovery | `LSD-` | Query surface over `BC-23` | None new |
| C3 Library Public Profile | `LPP-` | Read composition + owner-only analytics readout | None new |
| C4 Live Seat Availability & Booking | `LSB-` | Presentation over `BC-04` | None new |
| C5 Ratings & Reviews | `LRR-` | ⛔ **Non-authorisation finding** — nothing to build | **None — no runtime surface** |
| C6 Discovery Presentation | `LDR-` | Presentation over `BC-23` ordering | None new |
| C7 Trust & Safety Integration | `LTS-` | Integration over `BC-13` via the rank-9 shell | None new |

**`LMT-FR-001`** — ⛔ C8 **MUST NOT** specify runtime architecture for **C5**.
⭐ C5 authored no capability; there is nothing to host, store, index, cache, audit
or scale. ⭐ **An architecture section for a non-existent capability would be
precisely the defect C5 refused to create.**

---

## §3 ⭐⭐ The structural premise: the marketplace is not a context

**`LMT-BR-002`** — The marketplace is a **read-composition over contexts that
already own their data**. `MASTER_PRD.md` **L171**:

> `| 19 | Library Discovery & Enrollment | Composition over BC-19, BC-25, BC-29, BC-06, BC-02, BC-04, projected via BC-23 | *not a context* | V1 |`

**`LMT-FR-002`** — Every field a marketplace surface renders **MUST** originate
from the owner `AR-1` names for it. ⛔ C8 **MUST NOT** introduce a marketplace-side
system of record for any of them.

**`LMT-XC-001`** — ⛔ **No marketplace aggregate, entity, table or store is
created.** The composition holds **nothing**; it reads.

> ⭐ **This single premise is what makes the "zero infrastructure" finding true
> rather than optimistic.** A capability that stores nothing needs no schema, no
> migration, no retention policy of its own, no backup, no consistency model and
> no isolation mechanism beyond the ones its sources already enforce.

---

## §4 Module placement and the dependency law

**`LMT-FR-003`** — Marketplace composition **MUST** be realised at the **rank-9
`app`** shell and in **rank-8 `domain/library`**, using only ports those modules
already declare (`tool/module_dependencies.yaml` **L97**–**L149**, **L502**–**L517**).

**`LMT-BR-003`** — 📤 **DELEGATED — `L2`** (Matrix **L49**): *"A module may
depend only on modules of **strictly lower rank**. Same-rank dependencies are
forbidden except within a declared cluster."* ⛔ C8 **MUST NOT** request an
exception, a new cluster, or a rank change.

**`LMT-XC-002`** — ⛔ No `domain/library` → `domain/social` dependency
(`X-05`; yaml **L150**, **L261**). ⭐ C7's report path uses the rank-9 shell's
**already declared** `domain/social` port (**L509**), which is rank 9 → rank 8,
downward, and therefore `L2`-clean.

**`LMT-XC-003`** — ⛔ No new port, no new `imports:` entry and no new
`banned_imports:` relaxation is requested by C1–C7.

**`LMT-BR-004`** — 📤 **`AP-1`** (yaml **L523**): *"no business invariant is
enforced in a widget."* ⛔ Marketplace presentation code **MUST NOT** enforce
eligibility, availability, authorization or safety; it renders decisions made by
their owners.

**`LMT-BR-005`** — 📤 **`AP-2`** (yaml **L525**–**L526**): *"`TenantContext` is written
exactly once per request/route, at the shell."*

---

## §5 Entities and integrations — the seven-column ownership record

The instruction requires, for every proposed entity and integration:
**Owner · Source of truth · Scope · Lifecycle · Authorization · Indexes/constraints
· Retention.**

### §5.1 ⭐ Proposed entities: none

**`LMT-FR-004`** — C1–C7 propose **0** new entities. The table below is therefore
a record of **existing** entities the composition reads, stated in the required
seven columns.

### §5.2 The record

| Entity / data | Owner | Source of truth | Scope | Lifecycle | Authorization | Indexes / constraints | Retention |
|---|---|---|---|---|---|---|---|
| Library organisation record (name, address, status, contact) | **`BC-19`** | `Tenant` aggregate (BC Map **L381**) | Tenant | Tenant lifecycle: created → verified → activated → suspended (**L128**) | `BC-18` policy; public projection anonymous (`ADR-0010`) | 📤 `BC-19`'s; public copy in the `AR-3` **Platform Public Discovery Index** | 📤 `BC-19`'s |
| Logo, cover, description, branding | **`BC-25`** | Configuration store (**L134**) | Tenant | Config lifecycle | `BC-18` | 📤 `BC-25`'s | 📤 `BC-25`'s |
| Gallery media | **`BC-19`** holds the `FileRef`; **`BC-29`** holds bytes | `BC-29` storage (**L138**) | Tenant | Upload → scan → thumbnail → signed URL | `BC-18`; signed URL by `BC-29` | 📤 `BC-29`'s | 📤 `BC-29`'s |
| Hours, holidays | **`BC-06`** | `BC-06` store | Tenant | 📤 | `BC-18` | 📤 | 📤 |
| Plans, pricing | **`BC-02`** | `BC-02` store | Tenant | 📤 | `BC-18` | 📤 | 📤 |
| Seat capacity / availability | **`BC-04`** | `BC-04` store | Tenant | 📤 | `BC-18` | 📤 **incl. the seat uniqueness constraint** (§10.2) | 📤 |
| Public discovery projection | **`BC-23`** | Index, fed by `E-21` | **Platform-wide, no tenant key** (`AR-3`) | Rebuildable from the event log (§9.1) | Anonymous read, gated by `LIB-DISC-002`+`004` | 📤 `BC-23`'s; contents limited to §14A.5 | Rebuildable, not a system of record |
| `ProfileViews` metric | **`BC-26`** | Projection from `E-30` | Tenant (owner-only readout) | `ADR-0097` counting rules | Owner-only; ⛔ never seeker-facing | 📤 `BC-26`'s | 📤 `BC-26`'s |
| Moderation case | **`BC-13`** | `ModerationCase` (**L379**) | Global (no `tenantId`, `ID-2`) | `PRD-020`'s | `PRD-020`'s | 📤 | 📤 |
| Audit entry | **`BC-24`** | Immutable append-only log (**L133**) | Per actor of record (**L384**) | Append-only, never mutated | 📤 `BC-24`'s | 📤 | 📤 `BC-24`'s |
| Person identity, privacy | **`BC-10`** | `PersonId` (**L114**) | Platform-wide, **no `tenantId`** (`ID-2`) | Created `1:1` with the account | 📤 | 📤 | 📤 |
| Membership | **Library Membership (`BC-03`)** | Membership store | Tenant | `LIB-DISC-009` — creation owned by Membership | `BC-18` | 📤 | 📤 |

**`LMT-BR-006`** — ⭐ Every 📤 cell above is **deliberately delegated, not
unknown.** Per `LMT-BR-001`, C8 **MUST NOT** state a retention period, an index
definition or a lifecycle transition on behalf of an owner that has already
defined it. ⛔ **Filling those cells with plausible values would be inventing
architecture** — the precise act the instruction forbids.

**`LMT-XC-004`** — ⛔ C8 **MUST NOT** define retention for any data class. No
marketplace-side data exists to retain (`LMT-XC-001`), and every source's
retention is its owner's.

### §5.3 Media

**`LMT-FR-005`** — Marketplace surfaces **MUST** reference media by **`FileRef`**
and **MUST NOT** hold bytes or a raw storage path (`E-22`, BC Map **L331**).

**`LMT-XC-005`** — ⛔ No second media store, transform pipeline, thumbnailer,
virus scanner or URL signer. `BC-29` is *"the sole media infrastructure owner"*.

---

## §6 Data architecture and multi-tenant isolation

### §6.1 No schema

**`LMT-FR-006`** — C1–C7 require **0** new tables, columns, migrations or
constraints. ⭐ Consequence of `LMT-XC-001`.

### §6.2 ⭐⭐ The two index classes, and which one each surface uses

📤 **DELEGATED — `AR-3`** (`ARCHITECTURE_RULINGS.md` **L95**–**L125**).

| Surface | Index class | Tenant key | Caller |
|---|---|---|---|
| C2 search, C6 presented list, C3 public profile | **Platform Public Discovery Index** — indexed unit `TenantOrganisation`, contents limited to §14A.5 public metadata | ⛔ **None** | Anonymous |
| C4 seat availability, C3 owner-only readout, C7 protected ops | **Tenant Operational Data** | ✅ **Mandatory** (`MP-GBR-08`, `SE-1`, `X-13`) | Authenticated, tenant context required (`E-18`) |

**`LMT-FR-007`** — Every marketplace read **MUST** be classified into exactly one
of these two classes before it is implemented, and **MUST** carry the tenant key
requirement of the class it falls in.

**`LMT-BR-007`** — ⛔ A read **MUST NOT** mix the classes in one query. ⭐ A join
between an untenanted public index and tenanted operational rows is the shape
that produces the failure BC Map §11.1 calls *"the single highest-severity
failure mode in the entire architecture … a cross-tenant data leak via a
capability context."*

**`LMT-FR-008`** — The public index **MUST** contain **only** §14A.5 public
metadata, and **MUST NOT** contain seat counts, occupancy, membership, fee,
attendance, internal analytics or moderation data. 🔗 Enforces `LSD-XC-008`'s
*"by value or by inference"* bar and C6 §4.4.

**`LMT-XC-006`** — ⛔ No new index, index class, analyzer, tokenizer, synonym
list, relevance formula or query rewriter. 📤 `BC-23` (**L132**).

### §6.3 Tenant context

**`LMT-BR-008`** — 📤 **`E-18`** (**L327**): tenant context is **ambient** —
*"propagated, never passed as a parameter through domain methods."* ⛔ C8
**MUST NOT** introduce a tenant parameter into a marketplace domain signature.

**`LMT-FR-009`** — Where tenant context is required and absent, the operation
**MUST fail loudly** and **MUST NOT** default, fall back to a
"first"/"default"/"any" tenant, or proceed untenanted. 🔗 §9.1's rule that a
consumer *"must fail loudly not default"* on a missing `tenantId`.

**`LMT-XC-007`** — ⛔ No tenant id, `StudentRecordId` or tenant-scoped identifier
may enter `BC-10`…`BC-17` (`ID-2`; yaml `banned_symbols` **L266**–**L267**). ⭐ This
binds C7's report path: a report carries a `PersonId` and a **public** subject
reference, ⛔ never a `StudentRecordId`.

---

## §7 Event architecture

### §7.1 Naming

**`LMT-BR-009`** — 📤 **DELEGATED — BC Map §9**: event names are
`<Context>.<Aggregate><PastTenseVerb>`; ⭐ *"imperatives are commands and belong
to Workflow, must not enter the event bus."*

### §7.2 Delivery — inherited whole

**`LMT-FR-010`** — 📤 **DELEGATED IN FULL — BC Map §9.1 Event Delivery
Contract.** C1–C7 inherit, and ⛔ C8 restates none of it as its own:
transactional outbox in the same DB transaction; at-least-once delivery; **every
consumer idempotent keyed on `eventId`** with a processed-events table; ordering
**per aggregate** via partition key `aggregateId`, ⛔ never global; the envelope
(`eventId`, `eventType`, `schemaVersion`, `occurredAt`, `tenantId`, `actorId`,
`correlationId`, `causationId`, `aggregateId`, `payload`); additive-only schema
evolution with dual publication; retry with backoff then **DLQ** under an SLO;
and every `BC-26` projection and `BC-23` index **rebuildable from the log**,
tested quarterly.

### §7.3 ⭐ The events C1–C7 use — all pre-existing

| Event | Producer | Edge | Marketplace use |
|---|---|---|---|
| `tenancy.*` (`*Created/Updated/Deleted`) | `BC-19` | **`E-21`** → `BC-23` | Feeds the public discovery index (C2, C6, C3) |
| `tenancy.LibraryProfileViewed` | `BC-19` | **`E-30`** → `BC-26` | C3 owner-only Profile Views |
| `safety.EnforcementActionTaken` | `BC-13` | **`E-14`** | C7 enforcement-consequence rendering |
| Audit facts | all contexts | **`E-20`** → `BC-24` | C7 auditability |

**`LMT-FR-011`** — C1–C7 **MUST** operate using **only** these existing events.

**`LMT-XC-008`** — ⛔ **No new domain event is created, requested or assumed.**
⭐ C8 registers **0** events and proposes **0**, exactly as A8 did (*"A8 registers
none and proposes none"*).

**`LMT-XC-009`** — ⛔ **No new edge is created or assumed.** BC Map **L292**:
*"if an edge is not in this table, it **does not exist** and adding it requires an
ADR."* ⭐ Set remains **29**; `E-27` permanently vacant; `E-31` would be next and
⛔ is not minted here.

**`LMT-XC-010`** — ⛔ No extension of `E-30`'s payload. ⭐⭐ **The payload boundary
IS the privacy control** (§17.2.1) — it carries the subject library and the
occurrence time and ⛔ no viewer identity in any form. 🔗 Reinforces C3, C7
`LTS-XC-008` and `ADR-0097`'s refusal to certify `UniqueViewers`.

**`LMT-BR-010`** — ⛔ C8 **MUST NOT** rely on `BC-26` receiving events over any
path other than a **declared** edge. ⚠⚠ **`GAP-BCMAP-BC26-EDGES` is OPEN and
INHERITED** — `BC-26` appears as *"Primary consumer"* in ~20 §9 event rows while
§7 declares no edge into it besides `E-26`. ⭐ `ADR-0096` deliberately **refused
to use that anomaly as authority** and minted `E-30` explicitly instead; C8
reuses that discipline and ⛔ does not resolve the gap. **Owner: Architecture
Owner.**

---

## §8 Jobs and background work

**`LMT-FR-012`** — Where C1–C7 require deferred work, it **MUST** be submitted
through the **declared port** `platform/services:job_runtime`
(`tool/module_dependencies.yaml` **L338**, under `platform/workflow`'s `ports:`),
per `ADR-0058`.

**`LMT-BR-011`** — 📤 **DELEGATED — `ADR-0058`**: V1 is a **lightweight
in-process adapter**, ⛔ **not** the V2 Job Runtime deployment (EA
**L1860**–**L1871**), and `submit` **MUST be non-`async`**.

**`LMT-XC-011`** — ⛔ **No own worker pool, queue, retry scheduler or cron.**
📤 `FIL-XC-017`. ⭐ Measured: C1–C7 introduce **0** queues, **0** worker pools,
**0** cron jobs.

**`LMT-FR-013`** — ⭐ Measured: C1–C7 require **no** deferred work of their own.
Index feeding, projection building, media processing and audit writing are all
their owners' background work, reached over existing edges. `LMT-FR-012` states
the lawful route should a need later arise; it does not assert one exists.

---

## §9 API architecture

### §9.1 Read composition

**`LMT-FR-014`** — Marketplace endpoints **MUST** compose from owner-provided
reads and **MUST NOT** query another context's tables. 📤 `F-1` (*"no capability
context may import, reference or query a domain context"*); BC Map **L330**:
*"Search never reads domain tables."*

**`LMT-BR-012`** — 📤 **`F-3`**: where a marketplace action causes a domain
change, it **MUST** invoke the domain's public command API through a **registered
port**; the domain **re-validates**, and the caller is treated as **untrusted**.
⭐ This is the rule under which C7's report submission and C4's booking initiation
operate.

**`LMT-XC-012`** — ⛔ No new API convention, envelope, error taxonomy, version
scheme or content type. 📤 existing conventions.

### §9.2 Idempotency

**`LMT-FR-015`** — State-changing marketplace endpoints **MUST** be idempotent
using the existing **idempotency key at the API edge** mechanism (BC Map §10.1's
duplicate-payment override) and the `platform/services:idempotency` port
`domain/library` already declares. ⛔ No new idempotency store.

### §9.3 Pagination

**`LMT-FR-016`** — Every marketplace list **MUST** paginate by **opaque
server-generated cursor**. 📤 **`PG-1`…`PG-4`** (BC Map **L709**–**L712**):
clients **MUST NOT** parse, construct or decrement a cursor; a cursor **MUST NOT**
expose ordering keys, DB ids, offsets, table names or index structure; an expired
or malformed cursor **MUST** yield a domain error and ⛔ **never** a silent reset.

**`LMT-XC-013`** — ⛔ No offset pagination, page numbers, total-count guarantee
or new pagination mechanism. 🔗 Consistent with C2's count suppression.

### §9.4 Authentication and authorization

**`LMT-FR-017`** — 📤 **DELEGATED — `LIB-DISC-005`/`006`/`008`**: public browsing
requires no authentication; protected operations always require it; auth and
registration are owned by Authentication. Every protected marketplace operation
**MUST** be authorized **server-side** by a `BC-18` policy decision.

**`LMT-XC-014`** — ⛔ No role, permission, scope, policy language or consent
mechanism is defined. 📤 `BC-18` (**L127**).

**`LMT-FR-018`** — Object references in marketplace URLs and payloads **MUST** be
authorized per request against the caller's policy decision, ⛔ never inferred
from possession of an identifier.

### §9.5 Configuration

**`LMT-FR-019`** — Tunable marketplace values **MUST** be read through typed
accessors over **`E-19`** (`CF`, sync port); ⛔ *"no raw string lookups in domain
code"* (BC Map **L328**). ⛔ No new configuration store or flag system.

### §9.6 Rate limiting

**`LMT-FR-020`** — Public marketplace surfaces **MUST** be rate-limited **per
origin** (`LIB-14B.41`); a short-lived anonymous session id **MAY** be used
(`LIB-14B.6`); and the mechanism ⛔ **MUST NOT** identify the visitor
(`LIB-14B.42`).

**`LMT-XC-015`** — ⛔ No rate-limit counter, bucket, store or evaluator is
created. `RateLimitCounter` remains `BC-11`'s (BC Map **L377**). 🔗 C7
`LTS-XC-005`.

---

## §10 Performance, consistency and failure handling

### §10.1 ⛔ No numeric budgets

**`LMT-XC-016`** — ⛔ C8 **MUST NOT** mint a latency target, throughput budget,
percentile SLO, payload-size cap, cache TTL or timeout value. ⭐ **A8 refused the
same** (*"§23 refuses to mint latency targets"*), and the reason holds here: a
number invented in a product part becomes an unowned obligation that no operator
agreed to and no test can justify. ⚠ **Disclosed as an absence**, not presented
as satisfied.

**`LMT-FR-021`** — Where a marketplace surface needs a performance obligation, it
**MUST** inherit the obligation of the owner whose read it composes, and ⛔ **MUST
NOT** state a stricter or looser one.

**`LMT-XC-017`** — ⛔ No cache tier, cache invalidation protocol or read replica.
⭐ The public discovery index is **already** the read-optimised representation
(`AR-3`); adding a cache in front of a projection would create a **second**
derived copy with its own staleness, and no owner.

### §10.2 Consistency

**`LMT-FR-022`** — 📤 **DELEGATED — BC Map §10** consistency table and **§10.1**'s
three overrides, which C1–C7 inherit unchanged:

| Override | Mechanism | Marketplace relevance |
|---|---|---|
| Double seat allocation | **DB unique constraint + row lock** | C4 booking — 📤 `BC-04`'s, ⛔ not re-specified |
| Abuse containment | **Synchronous enforcement check at send time in `BC-12`** | C7 — ⛔ C7 adds no check of its own |
| Duplicate payment | **Idempotency key at API edge + gateway reference uniqueness + reconciliation job** | C4 — `LMT-FR-015` |

**`LMT-FR-023`** — All other marketplace reads are **eventually consistent** by
construction, because they read projections fed by events. ⭐ **The correct
response to staleness is truthful labelling, not a stronger guarantee** — the
discipline C4 established for seat indicators and C6 for sort keys.

### §10.3 Failure handling and degraded modes

**`LMT-FR-024`** — When an upstream owner is unavailable, the marketplace surface
**MUST** degrade by **omitting or truthfully relabelling** the affected element,
and ⛔ **MUST NOT** substitute a locally computed value, a cached guess, a zero,
or a placeholder presented as data.

| Upstream down | Required behaviour | ⛔ Forbidden |
|---|---|---|
| `BC-23` index | Present whatever ordering C2 supplies, relabelled | ⛔ A C6-side fallback ordering — the slot C6 §4.8 **withdrew** |
| `BC-04` availability | Omit the indicator | ⛔ Rendering "available" or "0" as fact |
| `BC-26` projection | Omit the owner-only readout | ⛔ Estimating, or showing `UniqueViewers` as zero/unknown/placeholder (`ADR-0097`) |
| `BC-13` intake | Report affordance reports failure honestly | ⛔ Queuing locally, ⛔ claiming a case was opened |
| `BC-29` media | Omit the image | ⛔ Serving bytes from a marketplace-side copy |

**`LMT-FR-025`** — ⛔ The marketplace **MUST NOT** implement a local write buffer,
store-and-forward queue or offline mutation log for any C1–C7 action.
⭐ Consequence of `LMT-XC-001` and `LMT-XC-011`.

---

## §11 Observability, analytics and audit

**`LMT-FR-026`** — Marketplace telemetry **MUST** use the
`platform/observability:telemetry` port both `domain/library` and `app` already
declare. ⛔ No new observability stack, log store, tracing system or dashboard
platform.

**`LMT-XC-018`** — ⛔ **No metric is defined, computed, certified, aggregated,
projected or reported by C8.** 📤 `BC-26` is the **sole** analytics authority
(**L135**, **L385**). ⭐ `ProfileViews` remains the only `CertifiedMetric`
instance and **`UniqueViewers` remains NOT CERTIFIED** (`ADR-0097`) — ⛔ and
**MUST NOT** be rendered as zero, unknown, a placeholder, *"coming soon"*,
disabled, blurred, teased or estimated.

**`LMT-XC-019`** — ⛔ No second analytics store, warehouse, event-tracking SDK,
product-analytics tool or materialised view outside `BC-26`.

**Audit.** 📤 **`E-20`** — `PL`, Event, **fire-and-forget, outbox-backed**;
*"Domain never calls audit synchronously"* (**L329**). ⛔ No audit entry for an
anonymous public view, because `AuditEntry` requires an *"actor of record"*
(**L384**) — 🔗 C7 `LTS-BR-007`, and the same determination `ADR-0096` made.
⛔ No second audit store.

**`LMT-XC-020`** — ⛔ **No second search, media, analytics, audit, authorization,
safety, configuration or job system exists after this part.** ⭐ This is the
single sentence the instruction's *"do NOT invent infrastructure"* reduces to,
and §0.2 measures it at **0** across every class.

---

## §12 C3 Profile Views — architectural compatibility, preserved

| C3 / `ADR-0096` / `ADR-0097` property | C8 treatment |
|---|---|
| `E-30` `BC-19 → BC-26` (`PL`, Event, V1) is the producing path | ✅ **Unchanged** — §7.3 |
| Payload carries subject library + occurrence time, ⛔ **no viewer identity in any form** | ✅ **Unchanged** — `LMT-XC-010` |
| `BC-26` is the sole analytics authority | ✅ **Unchanged** — `LMT-XC-018` |
| `ProfileViews` certified; readout is **owner-only aggregate** | ✅ **Unchanged** |
| **`UniqueViewers` NOT CERTIFIED** and not renderable in any surrogate form | ✅ **Reinforced** — `LMT-XC-018`, `LMT-FR-024` |
| `BC-19` gains **no** analytics capability | ✅ **Unchanged** — it states a fact; it cannot count, aggregate, project, define or report |
| ⛔ `PRD-009` remains `PLANNED`, not created | ✅ **Unchanged** |

⭐ **C8 adds no requirement that touches this design**, and its degraded-mode rule
(`LMT-FR-024`) **strengthens** `ADR-0097` by forbidding the placeholder renderings
that would otherwise creep in when the projection is unavailable.

---

## §13 ⚠ ADRs required — routed, not written

| # | Required ADR | Why | Owner | ⛔ Status |
|---|---|---|---|---|
| 1 | A referral transport between `BC-13` and `BC-19` | **`TSF-GAP-009`** — no transport exists; `X-05` makes a direct edge the wrong shape. Would need an edge (`E-31`) | **Architecture Owner** with the **`BC-19` owner** | ⛔ **NOT written.** Blocks `IMPL-1424` |
| 2 | Resolution of `BC-26`'s undeclared inbound edges | **`GAP-BCMAP-BC26-EDGES`** — ~20 §9 rows name `BC-26` as consumer while §7 declares only `E-26` | **Architecture Owner** | ⛔ **NOT written.** `ADR-0096` §1.2 refused to resolve it as a side effect |

⭐ **A8 recorded exactly this shape** — *"ADRs written | **0** | 2 required,
routed in §41."* C8 matches it: **2 required, 0 written.** ⛔ Writing either would
exceed a Stage-2 part's authority and would resolve an Architecture Owner
question by drafting.

**Inherited OPEN decisions, untouched:** `XPC-OD-004`, `XPC-OD-005`,
`XPC-OD-006` (from C0) · `XPC-OD-008` (C5) · `XPC-OD-009` (C6) · `XPC-OD-010`
(C7). ⛔ C8 resolves **none** of them and creates **no** new one.

---

## §14 Acceptance criteria

### §14.0 Coverage map

| AC | Covers |
|---|---|
| `LMT-AC-001` | `LMT-FR-001`, `LMT-XC-001`, `LMT-FR-006` |
| `LMT-AC-002` | `LMT-FR-002`, `LMT-BR-002`, `LMT-FR-004` |
| `LMT-AC-003` | `LMT-FR-003`, `LMT-BR-003`, `LMT-XC-002`, `LMT-XC-003` |
| `LMT-AC-004` | `LMT-BR-004`, `LMT-BR-005` |
| `LMT-AC-005` | `LMT-FR-007`, `LMT-BR-007` |
| `LMT-AC-006` | `LMT-FR-008`, `LMT-XC-006` |
| `LMT-AC-007` | `LMT-BR-008`, `LMT-FR-009`, `LMT-XC-007` |
| `LMT-AC-008` | `LMT-FR-010`, `LMT-BR-009` |
| `LMT-AC-009` | `LMT-FR-011`, `LMT-XC-008`, `LMT-XC-009` |
| `LMT-AC-010` | `LMT-FR-012`, `LMT-BR-011`, `LMT-XC-011`, `LMT-FR-013` |
| `LMT-AC-011` | `LMT-FR-014`, `LMT-BR-012`, `LMT-FR-015` |
| `LMT-AC-012` | `LMT-FR-016`, `LMT-XC-013` |
| `LMT-AC-013` | `LMT-FR-017`, `LMT-FR-018`, `LMT-XC-014` |
| `LMT-AC-014` | `LMT-FR-020`, `LMT-XC-015` |
| `LMT-AC-015` | `LMT-FR-022`, `LMT-FR-023`, `LMT-FR-024`, `LMT-FR-025` |
| `LMT-AC-016` | `LMT-XC-010`, `LMT-XC-018`, `LMT-XC-019`, `LMT-XC-020`, `LMT-XC-016`, `LMT-XC-017` |

⚠ **`LMT-AC-001`, `LMT-AC-003`, `LMT-AC-009`, `LMT-AC-010` and `LMT-AC-016` are
verified by repository inspection, not by execution** — they assert absences.
**0** of the 16 criteria are proven by an executed test at Stage 2.

### §14.1 Criteria

**`LMT-AC-001`** — **Given** parts C1–C7, **when** their storage requirements are
enumerated, **then** the total is **0** new tables, **0** columns, **0**
migrations and **0** marketplace-side stores — **and** C5 in particular has no
runtime architecture, because it authored no capability.

**`LMT-AC-002`** — **Given** any field rendered on a marketplace surface,
**when** its origin is traced, **then** it resolves to the owner `AR-1` names for
it — **and** no marketplace-side system of record is found for any field.

**`LMT-AC-003`** — **Given** the module dependency register, **when** C1–C7's
realisation is checked, **then** every call is downward per `L2`, no
`domain/library` → `domain/social` dependency exists, and **0** new ports,
imports or `banned_imports` relaxations were added.

**`LMT-AC-004`** — **Given** a marketplace widget, **when** it renders,
**then** it enforces no business invariant (`AP-1`) — **and given** a request,
**when** tenant context is set, **then** it is written exactly once at the shell
(`AP-2`).

**`LMT-AC-005`** — **Given** any marketplace read, **when** it is classified,
**then** it falls in exactly one `AR-3` class and carries that class's tenant-key
requirement — **and** no single query joins the untenanted public index to
tenanted operational rows.

**`LMT-AC-006`** — **Given** the Platform Public Discovery Index, **when** its
contents are inspected, **then** only §14A.5 public metadata is present — **and**
no seat count, occupancy, membership, fee, attendance, internal-analytics or
moderation value is present by value or by inference.

**`LMT-AC-007`** — **Given** a marketplace operation requiring tenant context,
**when** that context is absent, **then** the operation fails loudly and does not
default to any tenant — **and given** a payload crossing into `BC-10`…`BC-17`,
**when** inspected, **then** it carries no `TenantId` and no `StudentRecordId`.

**`LMT-AC-008`** — **Given** any event a marketplace component consumes,
**when** the same `eventId` is delivered twice, **then** the effect occurs once,
recorded in the processed-events table — **and** ordering is asserted only per
`aggregateId`, never globally.

**`LMT-AC-009`** — **Given** parts C1–C7, **when** the event and edge sets are
measured, **then** **0** new events and **0** new edges were created or assumed;
the edge set remains **29** with `E-27` vacant — **and** `E-30`'s payload is
unextended.

**`LMT-AC-010`** — **Given** parts C1–C7, **when** background work is measured,
**then** **0** queues, **0** worker pools and **0** cron jobs were introduced —
**and** the only lawful deferral route named is the declared
`platform/services:job_runtime` port with a non-`async` `submit`.

**`LMT-AC-011`** — **Given** a marketplace action that changes domain state,
**when** it executes, **then** it calls the domain's public command API through a
registered port, the domain re-validates, and a replayed request with the same
idempotency key produces no second effect.

**`LMT-AC-012`** — **Given** a marketplace list, **when** a client attempts to
construct, decrement or parse a cursor, **then** the cursor is opaque and exposes
no ordering key, DB id, offset, table name or index structure — **and** an expired
cursor yields a domain error rather than a silent reset to the first page.

**`LMT-AC-013`** — **Given** a protected marketplace operation invoked with only
a guessed object identifier, **when** it is evaluated, **then** it is refused by a
server-side `BC-18` policy decision — **and** C8 defines no role, permission or
consent rule of its own.

**`LMT-AC-014`** — **Given** the public marketplace surface under load, **when**
rate limiting applies, **then** it limits per origin without identifying the
visitor — **and** no fingerprint, persistent visitor id or cross-session
correlation key was introduced, and no rate-limit counter is owned here.

**`LMT-AC-015`** — **Given** an unavailable upstream owner, **when** a
marketplace surface renders, **then** the affected element is omitted or
truthfully relabelled — **and** no locally computed value, cached guess, zero or
data-styled placeholder is shown, and no local write buffer or offline mutation
log exists.

**`LMT-AC-016`** — **Given** the completed C1–C8 set, **when** infrastructure is
measured, **then** the counts are **0** for new search, media, analytics, audit,
authorization, safety, configuration and job systems, **0** caches, **0** read
replicas and **0** numeric budgets — **and** `BC-26` remains the sole analytics
authority with `UniqueViewers` still **NOT CERTIFIED** and unrendered in any
surrogate form.

---

## §15 Traceability to authority

| Claim | Authority | Locator |
|---|---|---|
| Marketplace is *"not a context"*; composition over six BCs projected via `BC-23` | `MASTER_PRD.md` (Rank 1) | **L171** |
| Read-model → owner routing | `ARCHITECTURE_RULINGS.md` `AR-1` | **L23**–**L50** |
| Two index classes; tenant key mandatory on operational data | `ARCHITECTURE_RULINGS.md` `AR-3` | **L95**–**L125** |
| Cross-tenant leak = highest-severity failure mode | BC Map §11.1 | **L498**+ |
| Event naming; Event Delivery Contract | BC Map §9, **§9.1** | §9, §9.1 |
| Opaque cursor pagination `PG-1`…`PG-4` | BC Map §15.3 | **L709**–**L712** |
| Consistency model + three overrides | BC Map §10, **§10.1** | §10, §10.1 |
| An edge absent from §7 does not exist | BC Map §7 | **L292** |
| `E-18` ambient tenant context | BC Map §7.3 | **L327** |
| `E-19` typed config, no raw string lookups | BC Map §7.3 | **L328** |
| `E-20` audit fire-and-forget, never synchronous | BC Map §7.3 | **L329** |
| `E-21` index feeding; *"Search never reads domain tables"* | BC Map §7.3 | **L330** |
| `E-22` `FileRef` never bytes; `BC-29` sole media owner | BC Map §7.3, §3.3 | **L331**, **L138** |
| `E-30` and `tenancy.LibraryProfileViewed`; payload boundary is the privacy control | BC Map §17.1, **§17.2.1**; `ADR-0096` | **L879**+ |
| `F-1`…`F-4` forbidden edges | BC Map §7.4 | **L341**–**L344** |
| `AuditEntry` requires an actor of record | BC Map §8 | **L384** |
| `RateLimitCounter` is `BC-11`'s | BC Map §8 | **L377** |
| `BC-26` sole analytics authority; `CertifiedMetric` | BC Map §3.3, §8 | **L135**, **L385** |
| `ProfileViews` certified; `UniqueViewers` **not** | `ADR-0097` | — |
| `GAP-BCMAP-BC26-EDGES` open; `ADR-0096` §1.2 refused to use it | BC Map §17.4 | §17.4 |
| Rank ladder; `app` rank 9 ports; `AP-1` (**L523**) / `AP-2` (**L525**–**L526**); `banned_symbols` | `tool/module_dependencies.yaml` | **L26**–**L48**, **L502**–**L526**, **L266** |
| `L2` downward-only | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **L49** |
| `X-05` Separate Ways | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`; yaml | **L354**; **L150**, **L261** |
| Job runtime is a declared port, not the V2 deployment; `submit` non-`async`; `FIL-XC-017` | `ADR-0058`; yaml | **L338** |
| Job Runtime V2 is future | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` | **L1860**–**L1871** |
| Sharding / multi-region are future | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` | **L2077**, **L2078** |
| Discovery/auth rules | `14A-...md` (FROZEN) `LIB-DISC-001`…`009` | **L302**–**L318** |
| Public §14A.5 field set | `14A-...md` §14A.5 | §14A.5 |
| Rate limit per origin; must not identify visitor | `14B-...md` | **L333**, **L337**, **L71** |
| `TSF-GAP-009` open; `TSF-XC-033` | `PRD-020` §11.3 | **L790**–**L812** |
| Self-measurement + ownership vocabulary + `LCT-INV-001` | `PRD-021A` A8 §0.2, **§0.5** | **L93**–**L107**, **L149**–**L167** |
| Edge numbers never reused | `PRD_LIFECYCLE.md` §5 rule 5 | — |
| Baseline moves only for Rank 1–3 version changes | `DOCUMENTATION_BASELINE.md` §7 rule 4 | — |

---

## §16 Status

| Field | Value |
|---|---|
| **Lifecycle** | **DRAFT — Stage 2.** ⛔ Stage 3 not entered; ⛔ no alignment record |
| **Approval** | ⛔ None |
| **Freeze / baseline** | ⛔ Neither. `BASELINE-2026-09-02-A` stands — C8 is unranked |

**Registers:** `LMT-FR-*` **26** · `LMT-BR-*` **12** · `LMT-XC-*` **20** ·
`LMT-AC-*` **16** = **74 identifiers**, each family contiguous from `001`.

⭐ **Identifier-rendering discipline, stated because it was measured.** No
unallocated, reserved, withdrawn or placeholder slot is rendered anywhere in
`PRD-021C` C5–C8 as a formed identifier token. ⚠ A draft of this part briefly
carried a suffixed reserved marker in §11; it was **removed** on measurement,
because a `\b`-delimited token remains greppable regardless of any suffix and the
register measured **27** against a declared **26**. ⛔ **An unallocated slot must
never be rendered as an allocated one** — the same discipline C6 §4.8 applies to
its withdrawn slot `023`, which it names **by number only**.

⚠ **Not proven:** **0** of the 16 acceptance criteria are proven by an executed
test at Stage 2.

⚠⚠ **Two ADRs are REQUIRED and ⛔ NOT written** (§13): the `BC-13` → `BC-19`
referral transport (**`TSF-GAP-009`**, Architecture Owner with the `BC-19` owner,
blocks `IMPL-1424`) and the `BC-26` inbound-edge resolution
(**`GAP-BCMAP-BC26-EDGES`**, Architecture Owner). Both are **inherited**, not
created here, and ⛔ neither is resolved.

---

## §17 Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-03 | Part created at **Stage 2**, covering the technical and production architecture of C1–C7. ⭐⭐ **The central finding is that C1–C7 require ZERO new infrastructure**, and §0.2 measures it across fifteen classes: **0** contexts, **0** edges, **0** events, **0** aggregates, **0** tables, **0** indexes, **0** caches, **0** queues/worker-pools/cron, **0** API conventions, **0** permissions/roles, **0** metrics, **0** numeric budgets, **0** infrastructure components, **0** ADRs written, **0** existing files modified. ⭐ **This mirrors `PRD-021A` A8's own §0.2**, whose *"New infrastructure components | 0 | ⭐ the central finding"* is the precedent for both the table and the discipline. ⭐⭐ **The finding rests on one structural premise, not on optimism**: `MASTER_PRD.md` **L171** (Rank 1) classifies module 19 as *"Composition over BC-19, BC-25, BC-29, BC-06, BC-02, BC-04, projected via BC-23"* and — decisively — ***"not a context"***. `LMT-XC-001` therefore holds that the composition **stores nothing**, from which it follows that it needs no schema, no migration, no retention policy of its own, no backup, no consistency model and no isolation mechanism beyond those its sources already enforce. ⭐ **Seventeen existing conventions are enumerated in §0.4 with the exact location of each declaration**, and every one is 📤 **DELEGATED rather than restated**, under `LMT-BR-001` — A8's `LCT-INV-001` adopted verbatim. ⭐ **The Event Delivery Contract is inherited WHOLE** (`LMT-FR-010`): outbox in the same transaction, at-least-once, per-consumer idempotency keyed on `eventId` with a processed-events table, ordering **per aggregate** and ⛔ never global, the ten-field envelope, additive-only evolution with dual publication, retry→**DLQ** under an SLO, and every projection and index **rebuildable from the log** — ⛔ C8 re-specifies none of it. ⭐ **The four events C1–C7 use are all pre-existing** — `tenancy.*` over `E-21`, `tenancy.LibraryProfileViewed` over `E-30`, `safety.EnforcementActionTaken` over `E-14`, audit facts over `E-20` — so **`LMT-XC-008`** registers **0** events and proposes **0**, exactly as A8 did, and **`LMT-XC-009`** mints **0** edges under **L292** (*"if an edge is not in this table, it does not exist"*), leaving the set at **29** with `E-27` permanently vacant and `E-31` ⛔ unminted. ⭐⭐ **The `AR-3` classification is made MANDATORY per read** (`LMT-FR-007`) and **`LMT-BR-007`** forbids joining the untenanted public index to tenanted operational rows in one query — ⭐ because that join is the exact shape of what BC Map §11.1 calls *"the single highest-severity failure mode in the entire architecture … a cross-tenant data leak via a capability context."* **`LMT-FR-009`** requires a missing tenant context to **fail loudly**, ⛔ never defaulting to a first/default/any tenant. ⭐ **The seven-column ownership record (§5.2) covers twelve existing data classes** — Owner · Source of truth · Scope · Lifecycle · Authorization · Indexes/constraints · Retention — and ⭐⭐ **its 📤 cells are deliberately delegated rather than filled**: **`LMT-BR-006`** states that inventing a plausible retention period or index definition on an owner's behalf **would be inventing architecture**, the precise act the instruction forbids. ⛔ **`LMT-FR-001` refuses to specify runtime architecture for C5**, because C5 authored no capability and *"an architecture section for a non-existent capability would be precisely the defect C5 refused to create."* ⭐ **Jobs are handled by citation, not design**: `ADR-0058` makes `platform/services:job_runtime` a **declared PORT** at yaml **L338** — ⛔ **not** the V2 Job Runtime deployment (EA **L1860**–**L1871**) — with `submit` **non-`async`**, and `FIL-XC-017` forbidding an own worker pool, queue, retry scheduler or cron; **`LMT-FR-013`** then measures that C1–C7 need **no** deferred work of their own, so the port is named as the lawful route rather than asserted as a live dependency. ⛔ **`LMT-XC-016` REFUSES to mint numeric budgets** — latency targets, percentile SLOs, payload caps, cache TTLs, timeouts — on A8's stated ground that *"a number invented in a product part becomes an unowned obligation that no operator agreed to and no test can justify"*; **`LMT-FR-021`** instead inherits each owner's obligation. ⛔ **`LMT-XC-017` refuses a cache tier**, because the public discovery index **already is** the read-optimised representation and a cache in front of a projection would create a **second** derived copy with its own staleness and no owner. ⭐ **§10.3's degraded-mode table is the operational heart of the part**: every failure resolves to *omit or truthfully relabel*, and ⛔ never to a locally computed value, cached guess, zero or data-styled placeholder — including the explicit refusal of a C6-side fallback ordering, ⭐ **the very slot C6 §4.8 withdrew**, keeping the two parts consistent. ⭐⭐ **C3 Profile Views compatibility is preserved and REINFORCED** (§12): `E-30` unchanged, its payload ⛔ unextended (**`LMT-XC-010`**), `BC-26` still the **sole** analytics authority (**`LMT-XC-018`**, **L135**/**L385**), `ProfileViews` still the only `CertifiedMetric` instance, and **`UniqueViewers` still NOT CERTIFIED** — with `LMT-FR-024` **strengthening** `ADR-0097` by forbidding the zero/unknown/placeholder renderings that would otherwise appear when the projection is unavailable; `BC-19` gains no analytics capability and `PRD-009` remains `PLANNED`. ⚠⚠ **TWO ADRs are REQUIRED and ⛔ NEITHER is written** (§13): the `BC-13` → `BC-19` referral transport (**`TSF-GAP-009`**, inherited from `PRD-020`, Architecture Owner with the `BC-19` owner, blocks `IMPL-1424`) and the `BC-26` inbound-edge resolution (**`GAP-BCMAP-BC26-EDGES`**, Architecture Owner) — ⭐ matching A8's own *"2 required, routed"* posture, and ⛔ declining to resolve an Architecture Owner question by drafting. ⛔ **`XPC-OD-004`, `XPC-OD-005`, `XPC-OD-006` remain OPEN and untouched**; `XPC-OD-008`/`009`/`010` are inherited from C5/C6/C7; ⛔ **C8 creates no new open decision.** ⚠ **One identifier-rendering defect was CAUGHT BY MEASUREMENT AND REMOVED, and the removal is recorded rather than hidden**: a draft of §11 carried a suffixed reserved marker, and a contiguity check measured the `LMT-FR-*` register at **27** against a declared **26** — because a `\b`-delimited identifier stays greppable regardless of any suffix. The marker was **deleted**, the register is **26** and contiguous, and §16 now states the discipline generally: ⛔ **no unallocated, reserved, withdrawn or placeholder slot is rendered anywhere in C5–C8 as a formed identifier token.** ⭐ **The same defect class was caught and fixed in C6**, whose withdrawn slot `023` is named **by number only** (§4.8). ⛔ **Zero contexts, zero edges, zero events, zero aggregates, zero tables, zero indexes, zero caches, zero queues, zero worker pools, zero cron jobs, zero permissions, zero roles, zero metrics, zero numeric budgets, zero second systems of any kind, zero ADRs, zero Rank 1–6 modifications, zero `IMPL-*`, zero lines of code.** **74 identifiers minted** — 26 FR · 12 BR · 20 XC · 16 AC. ⛔ **Confers no lifecycle stage.** Stage 3 **not** entered |
