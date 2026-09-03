# PRD-015 — SEARCH INDEXING (V1)

| Field | Value |
|---|---|
| **Document** | `PRD-015_SEARCH_INDEXING.md` |
| **PRD** | `PRD-015` |
| **Module** | Search Indexing |
| **Bounded Context** | **`BC-23` Search Indexing** |
| **Classification** | `[GENERIC]` — platform search capability |
| **Release** | **V1** |
| **Version** | **v0.1 — DRAFT** |
| **Status** | **`DRAFT`** — Stage 2 of [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md). ⛔ **NOT approved. NOT architecture-reviewed. NOT requirements-reviewed. NOT frozen. NOT baselined. No rank held.** Status is *conferred* by the register, never claimed by a document about itself |
| **Date** | 2026-09-03 |
| **Baseline** | Written **against** `BASELINE-2026-09-03-A`. ⛔ **Not admitted to it.** |
| **Precedence rank if admitted** | Rank 3 (module PRD) — ⛔ **not held today**, because admission is a baseline act |
| **Owns** | *"indices, permission-aware indexing, tenant index isolation, relevance, query rewriting"* — **BC Map L132**, verbatim and unextended |
| **Identifier prefix** | **`SRCH-*`** — collision-checked **before** writing (`PRD_LIFECYCLE.md` §5 rule 2): `SRCH-` measured **0** occurrences repository-wide. ⛔ `IDX-` was **refused** (21 pre-existing occurrences) per §5 rule 3 — *"change the new prefix, never the existing one"* |
| **Authorities applied** | `MASTER_PRD.md` **L171**, **L192** (Rank 1) · `Accepted` `ADR-0093`, **`ADR-0094`**, `ADR-0098` (Rank 2) · `Library_PRD_v1.md` **§14A** — **FROZEN 2026-08-03** (Rank 3) · BC Map **L132**, **L330**, **L453**, **L524** · `ARCHITECTURE_RULINGS.md` **`AR-1`**, **`AR-3`** (Rank 4) |
| **Scope constraint** | ⭐⭐ **This PRD does NOT restate, amend or supersede `Library_PRD_v1.md` §14A.** §14A **is** the V1 library-discovery contract by `Accepted` `ADR-0094` §2. This PRD authors **only** the capability layer §14A does not contain — see §3 |

---

> ### ⚠️⚠️ READ THIS BEFORE TREATING ANY STATEMENT HERE AS SETTLED
>
> **`Accepted` [`ADR-0094`](../../00-governance/adr/ADR-0094-section-14a-is-the-v1-bc-23-discovery-contract.md) §3
> option B — *"author `PRD-015`"* — was REJECTED by the Product Owner and Architecture Owner jointly.** That
> rejection is **not** overridden by this document, and pretending otherwise would be the single most serious
> defect this PRD could contain.
>
> **What was rejected, stated exactly:** authoring a PRD that would *"restate frozen §14A text in a new document"*,
> *"creating a **second** search/query authority and a divergence risk, for zero new information"* (`ADR-0094`
> **L52**, §3 row B).
>
> **What was expressly preserved, in the same ADR:** `ADR-0094` §2 rule 4 — *"`PRD-015` remains `PLANNED`…* ⭐ *It is
> **not** obsolete — should a future release need search capability **beyond §14A's library-discovery scope**,
> `PRD-015` remains the registered home for it."*
>
> **This draft is written strictly inside that carve-out.** It restates **no** §14A field, eligibility rule or
> visibility rule. It authors the **capability contract** that §14A measurably does not contain, and that two
> frozen/baselined records **require `BC-23`'s owner** to author:
>
> | Requirement in force | Where | What it demands of `BC-23`'s owner |
> |---|---|---|
> | **`LSD-FR-008`** | `PRD-021C` C2, **FROZEN** | *"The query port's contract — request shape, pagination, error taxonomy — **MUST** be defined by `BC-23`'s owner, and C2 **MUST NOT** author it"* |
> | **`XPC-OD-009`** | `PRD-021C` C0 **L427** / `ADR-0098` **L221** | *"Record it against **`PRD-015`** when that PRD is authored"* |
>
> ⛔ **THE REGISTRY STATUS IS NOT CHANGED BY THIS DOCUMENT.** `PRD_REGISTRY.md` **L315** still reads `PLANNED`.
> A `PLANNED` → `DRAFT` transition is a **Governance Owner act** requiring conferred authority — the register's own
> **L726-727** records that no such authority may be assumed. **`SRCH-GAP-001` carries this openly** (§42). This
> document is therefore a **Stage-2 draft on disk whose registry status is not yet conferred**, which is a disclosed
> state, not an oversight.

---

## 0. Document control

### 0.1 Normative language

**MUST** / **MUST NOT** — an absolute requirement; a conformant implementation cannot omit it.
**SHOULD** / **SHOULD NOT** — a strong recommendation; departure requires a recorded reason.
**MAY** — genuinely optional.

Prose alone never constitutes a requirement. Every obligation in this document carries a `SRCH-*` identifier, and
every **MUST** carries at least one `SRCH-AC-*` acceptance criterion (§43).

### 0.2 What this document is

The Stage-2 Product Requirements Document for **`BC-23` Search Indexing**, authoring the **reusable search
capability** that BC Map **L132** grants `BC-23` and that no existing artefact specifies.

### 0.3 What this document is NOT

- ⛔ **Not** a replacement for `Library_PRD_v1.md` §14A. §14A remains the V1 library-discovery contract (`ADR-0094`).
- ⛔ **Not** a second search, query, relevance or ranking authority. `BC-23` was already sole owner (BC Map **L132**);
  this document describes that existing ownership and creates no new one.
- ⛔ **Not** a business/marketplace ranking specification — see §5.3 and §22.4.
- ⛔ **Not** an infrastructure, engine, database, library or algorithm selection — see §36 and `SRCH-GAP-002`.
- ⛔ **Not** a Stage 3, 4 or 5 record. No stage is claimed. No `IMPL-*` identifier is allocated.

### 0.4 Identifier registers — declared up front, with ranges

`PRD_LIFECYCLE.md` Stage 2 requires registers declared **up front with ranges**, contiguous from 001.

| Prefix | Meaning | Count | Range |
|---|---|---|---|
| `SRCH-FR-*` | Functional requirements | **42** | `001`–`042` |
| `SRCH-BR-*` | Business rules | **14** | `001`–`014` |
| `SRCH-INV-*` | Invariants | **6** | `001`–`006` |
| `SRCH-XC-*` | Explicit exclusions — what `BC-23` **MUST NOT** do | **16** | `001`–`016` |
| `SRCH-AC-*` | Acceptance criteria (Given/When/Then) | **78** | `001`–`078` |
| `SRCH-GAP-*` | Recorded gaps — open, with named owner | **9** | `001`–`009` |

**Obligation-bearing identifiers: 78** (42 FR + 14 BR + 6 INV + 16 XC). **Acceptance criteria: 78.**
Counts are **computed by script** over this document (§44), never asserted from memory.

---

## 1. Executive summary

`BC-23` Search Indexing is a **V1 bounded context** (BC Map **L132**) whose registered owner, `PRD-015`, has never
been written. The consequence is measurable and specific: **the platform has an authorised search *route* and an
authorised library-discovery *field set*, but no authorised statement of how a query is matched.**

- `ADR-0093` authorised the **route** (`E-21` source list gained `BC-19`).
- `ADR-0094` authorised the **contract** for library discovery (`Library_PRD_v1.md` §14A).
- ⚠ **Neither authorises matching semantics.** Measured: §14A contains **zero** occurrences of *fuzzy*, *typo*,
  *token*, *prefix*, *partial*, *case-insensitive*, *stem*, *plural*, *spelling*, *relevance* or *rank*.

§14A.4 says a seeker may *"Search by Library Name"*. It does not say whether `central lib` finds
*Central Library*, whether `Libraries` finds *library*, or what happens on a one-character typo. **Left
unspecified, each consumer would answer differently — and the first consumer to answer would become a de facto
second search authority, which `LSD-XC-002` forbids.**

This PRD closes that gap and only that gap. It specifies a **tiered, deterministic, permission-aware matching
capability** (§17–§22) offered through a **single query port** (§37) reusable by every repository-authorised search
consumer (§6, §10), while holding four lines that the repository already drew:

1. **Public means the §14A public field set and nothing else** (`AR-3`; `ADR-0094` §2.1).
2. **Being indexed is not being visible.** Authorisation is re-evaluated at query time, never inherited from the
   index (§27).
3. **Relevance is not ranking.** `BC-23` orders by match quality; business ordering stays with its existing owner
   (§5.3).
4. **Where the repository does not decide, this PRD records a gap instead of inventing a value** (§42).

---

## 2. Goals

| # | Goal | Authority |
|---|---|---|
| G1 | Give `BC-23` a written, testable V1 capability contract | BC Map **L132**; `PRD_LIFECYCLE.md` Stage 1 gate |
| G2 | Specify **flexible/tolerant** matching so a near-miss query returns relevant results | Product requirement (§17); gap measured in §14A |
| G3 | Keep flexibility **bounded** — relevant, precise, deterministic, explainable | §4 of the authoring instruction; `AR-3` |
| G4 | Publish **one** query port reusable by all authorised consumers | `LSD-FR-007`, `LSD-FR-008`; `E-26` pattern |
| G5 | Preserve the public/tenant index boundary absolutely | `AR-3`; `ADR-0094` §2.1; `MP-GBR-08`, `SE-1`, `X-13` |
| G6 | Never create a second ranking, analytics or identity system | `LSD-XC-002`; BC Map **L132**, **L135** |
| G7 | Record every undecided question as an owned gap rather than inventing an answer | `DOCUMENTATION_BASELINE.md` §7; `ADR-0094` precedent |

## 3. Scope — and the exact boundary against frozen §14A

⭐⭐ **This is the most important section in the document.** It is what makes this PRD lawful under `ADR-0094`.

| Subject | Owner | In `PRD-015` scope? |
|---|---|---|
| Which library **fields** are discoverable | **§14A.4 / §14A.5** (FROZEN) | ⛔ **NO** — cited, never restated |
| Which libraries **are** discoverable (eligibility) | **§14A.6** (FROZEN) | ⛔ **NO** |
| The **public / never-public** boundary | **§14A.10** (FROZEN) | ⛔ **NO** — consumed as a binding constraint |
| Library-discovery **product** capabilities (search by name/city/PIN, filters, distance sort) | **§14A.4**, restated by `PRD-021C` C2 | ⛔ **NO** |
| Distance-based **sorting** | **§14A** L114; `PRD-021C` C6 | ⛔ **NO** |
| **How a text query is matched** to indexed text | ⛔ **NOBODY — measured absent** | ✅ **YES** |
| Query **normalisation** and rewriting | `BC-23` (BC Map **L132** *"query rewriting"*) | ✅ **YES** |
| **Relevance** ordering within a result set | `BC-23` (BC Map **L132** *"relevance"*) | ✅ **YES** |
| Query **port contract** — request shape, pagination, error taxonomy | ⭐ **`BC-23`'s owner, by `LSD-FR-008`** | ✅ **YES** |
| **Index lifecycle** — build, update, delete, rebuild, staleness | `BC-23` (BC Map **L132**, **L453**) | ✅ **YES** |
| **Permission-aware** indexing and tenant index isolation | `BC-23` (BC Map **L132**) | ✅ **YES** |
| Keyword-stuffing defence in §14A.5 public text | ⛔ **OPEN — `XPC-OD-009`** | ⚠ **RECORDED, not decided** (`SRCH-GAP-004`) |

`SRCH-XC-001` — `BC-23` **MUST NOT** define, alter or restate any §14A field, eligibility rule or visibility rule.
`SRCH-XC-002` — `BC-23` **MUST NOT** publish a second library-discovery contract. §14A is the contract (`ADR-0094`).

## 4. Non-goals (V1)

`SRCH-XC-003` — ⛔ **No ML/AI ranking, learned relevance or behavioural personalisation.** No repository authority
requires it, and `E-21` carries no viewer identity, so personalisation is **not computable** from `BC-23`'s inputs.
`SRCH-XC-004` — ⛔ **No vector database, semantic embedding or LLM retrieval.** `BC-27` owns *"RAG retrieval"*
(BC Map **L136**) and reaches `BC-23` through the `E-26` port; duplicating it here would create a second retriever.
`SRCH-XC-005` — ⛔ **No autonomous relevance learning or click-feedback loop.** Requires behavioural data
`BC-23` is not granted and `LIB-14B.42` forbids collecting on the anonymous surface.
`SRCH-XC-006` — ⛔ **No fraud detection, bot detection, CAPTCHA or IP reputation.** No owner exists
(`XPC-OD-010`, OPEN); inventing one here would answer an open owner decision.
`SRCH-XC-007` — ⛔ **No cross-entity or student search enabled in V1.** The *capability* is reusable (§10); the
*enabled consumer set* is closed (§6.2). `ADR-0094` §2 rule 4 names cross-entity/student search as a **future**
need, not a V1 one.

---

## 5. `BC-23` ownership

### 5.1 The grant, verbatim

> BC Map **L132**: `| **BC-23** | **Search Indexing** | [GENERIC] | Search | V1 | Owns indices, permission-aware
> indexing, tenant index isolation, relevance, query rewriting. |`

Five owned subjects: **indices · permission-aware indexing · tenant index isolation · relevance · query rewriting.**
This document specifies all five and claims nothing beyond them.

`SRCH-BR-001` — `BC-23` **MUST** remain the **sole** owner of index construction, relevance and query rewriting.
No consumer **MAY** build an index, and no consumer **MAY** re-implement relevance.

### 5.2 What `BC-23` does not own

| Subject | Actual owner | Authority |
|---|---|---|
| The tenant / library organisation record | **`BC-19` Tenancy** | BC Map **L128** |
| Student enrollment records | **`BC-01`** | BC Map **L405-407** |
| Person identity & profile | **`BC-10`** | BC Map **L424-428** |
| Metrics, projections, reports, exports | **`BC-26` Analytics** | BC Map **L135** |
| RAG retrieval, prompts, guardrails | **`BC-27` AI** | BC Map **L136**; `E-26` |
| Audit record of who did what | **`BC-24`** | BC Map **L133** |
| Settings, feature flags, branding | **`BC-25`** | BC Map **L134** |
| Files, bytes, signed URLs | **`BC-29`** | BC Map **L138**; `E-22` |
| Client mutation queue, conflict policy | **`BC-30`** | BC Map **L139** |
| Outbound third-party contracts | **`BC-31`** | BC Map **L140** |
| Moderation decisions | **`BC-13`** | BC Map **L117** |

`SRCH-INV-001` — `BC-23` holds **no** source of truth. Every indexed value is a **projection** of a fact owned
elsewhere. ⛔ `BC-23` **MUST NOT** be read as authoritative for any business fact.
`SRCH-XC-008` — ⛔ `BC-23` **MUST NOT** duplicate identity, profile, library-management, membership, seat,
booking, fee or analytics data as an authoritative store.

### 5.3 ⭐⭐ Relevance is not ranking — the distinction that protects `PRD-021C` C6

This repository has already ruled on ordering, and this PRD must not disturb it.

- `PRD-021C` **C6 L78**: *"⛔⛔ **Nobody owns a composite ranking, and none exists to own**"*.
- `PRD-021C` **C2 `LSD-XC-002`** (L315): *"⛔ **MUST NOT** create a second ranking or relevance system"*
  — authority BC Map **L132**; `ADR-0091` §3.
- §14A **L114** names exactly **one** ordering: *Distance-based Sorting*.

| Layer | Who decides | What it may consider |
|---|---|---|
| **Match / no-match** | **`BC-23`** (this PRD) | Does the document satisfy the query at an authorised tier? |
| **Relevance order** *within* matches | **`BC-23`** (this PRD, §22) | Match **tier** and field precedence only |
| **Business / product ordering** of the result set | **The consumer's own authorised rule** — e.g. §14A distance sort | Whatever that consumer's own authority permits |
| **Composite marketplace ranking** | ⛔ **Nobody. Does not exist** | — |

`SRCH-BR-002` — `BC-23` relevance **MUST** be derived **only** from match tier (§22) and field precedence. It
**MUST NOT** consider rating, popularity, availability, completeness, recency, commercial standing, viewer
identity or any behavioural signal.
`SRCH-XC-009` — ⛔ `BC-23` **MUST NOT** expose a tunable ranking weight, boost or business-ordering parameter to
any consumer. A consumer applying its own authorised ordering **MUST** do so **after** retrieval, on the returned
set, using its own authority — never by influencing `BC-23`'s relevance.
`SRCH-AC-note` — the C6 protection is verified by `SRCH-AC-014` and `SRCH-AC-015` (§43).

⚠ **Why this matters concretely:** `XPC-OD-009` measured that *"the one residual manipulation route into C6's
ordering runs through `BC-23`'s analyzer and query rewriting"*. `SRCH-BR-002` and `SRCH-XC-009` confine that route
to **text-query relevance only** — never the distance sort — exactly as `XPC-OD-009` describes.

---

## 6. Search consumers

### 6.1 The authorised consumer pattern

`SRCH-FR-001` — `BC-23` **MUST** expose search **only** through a query port (§37). No consumer **MAY** read an
index directly. *(`LSD-FR-007`; `E-26` port pattern.)*
`SRCH-FR-002` — The query port **MUST** be the single entry point for every authorised consumer, so that one
matching semantics applies platform-wide rather than per surface.

### 6.2 ⭐ V1 **enabled** consumers — a closed set

`ADR-0094` §2 rule 4 confines V1 to §14A's library-discovery scope. This PRD does **not** widen it.

| Consumer | Surface | Authority | V1 enabled? |
|---|---|---|---|
| `PRD-021C` **C2** Library Search & Local Discovery | Public library discovery | `LSD-FR-007`/`008`; `ADR-0094` | ✅ **YES** |
| `PRD-021C` **C6** Library Discovery Presentation | Presentation of C2 results | C6 §1.1; §14A L114 | ✅ **YES** — consumes C2's results; applies its own distance ordering |
| `Library_PRD_v1.md` **§14A** discovery surface | Public library directory | §14A.4 (FROZEN); `AR-3` | ✅ **YES** |
| `BC-27` AI Assistance | Retrieval for AI | **`E-26`** (BC Map **L335**) — *"permission-aware ports only, never direct index or table access"* | ⚠ **Port exists; enablement is `BC-27`'s to exercise.** Not authored here |
| `PRD-021A` community / participant search | Community | ⛔ **`AO-9` refused it.** BC Map **L753**: *"NOT AUTHORISED… `BC-15` is NOT a consumer"* | ⛔ **NO** |
| `PRD-021B` student discovery | Social graph | ⚠ No `E-21` consumer authority measured for `BC-11`/`BC-12` | ⛔ **NO** — `SRCH-GAP-005` |
| Cross-entity / student search | Platform | `ADR-0094` §2 rule 4 names it **future** | ⛔ **NO** |

`SRCH-XC-010` — ⛔ `BC-23` **MUST NOT** serve a consumer that is not in the V1 enabled set above. Adding a consumer
requires the authority that consumer's own edge demands — for community search, `AO-9`'s recorded refusal
(BC Map **L753**) must first be lifted by ADR.
`SRCH-BR-003` — ⭐ A consumer's **absence** from the V1 enabled set **MUST NOT** be read as a defect in the
capability. The capability is reusable by construction (§10); enablement is a separate, authority-gated act.

---

## 7. Searchable entities and documents

`SRCH-FR-003` — `BC-23` **MUST** index **only** entities reachable on an authorised `E-21` edge. BC Map **L330**
fixes the source list at exactly **`BC-01`, `BC-10`, `BC-19`**.

| Source | Owns | V1 index class | Enabled in V1 |
|---|---|---|---|
| **`BC-19`** Tenancy | The library organisation record (L128) | **Platform Public Discovery Index** | ✅ **YES** — the §14A discovery surface |
| **`BC-01`** Enrollment | Student enrollment records | **Tenant Operational Data** | ⚠ Route authorised; **no V1 consumer enabled** (§6.2) — `SRCH-GAP-006` |
| **`BC-10`** Identity | Person identity & profile | **Tenant Operational Data** | ⚠ Route authorised; **no V1 consumer enabled** — `SRCH-GAP-006` |

`SRCH-XC-011` — ⛔ `BC-23` **MUST NOT** index any source not listed in `E-21`. **`BC-15` is expressly excluded**
(BC Map **L330**, **L753**; `ADR-0083` §4.5 `AO-9`).
`SRCH-INV-002` — A document **MUST** exist in exactly one index class (§9). ⛔ No document **MAY** be a member of
both the public discovery index and a tenant-partitioned index.

⚠ **`SRCH-GAP-006` is disclosed rather than resolved:** `E-21` authorises `BC-01` and `BC-10` as sources, but no V1
consumer is enabled for them and §14A governs only libraries. This PRD therefore specifies **how** they would be
indexed (index class, tenant key, authorisation) **without enabling a surface**, because enabling one would create
V1 scope no authority requires.

## 8. Source-of-truth model

`SRCH-INV-003` — The index is **never** the source of truth. On any disagreement between an index document and its
owning context, **the owning context wins** and the index is stale by definition (§33).
`SRCH-FR-004` — `BC-23` **MUST** populate every index from events on `E-21` only. ⛔ It **MUST NOT** read a domain
table. *(BC Map **L330**: "Search never reads domain tables.")*
`SRCH-FR-005` — Every index document **MUST** carry the identifier of its owning aggregate, so that any value can be
re-resolved against its owner.
`SRCH-XC-012` — ⛔ `BC-23` **MUST NOT** accept a write, correction or backfill from any path other than `E-21`. No
consumer-supplied document injection.

## 9. Index classes

`AR-3` establishes **two categorically different** index classes, and `ADR-0094` §2.1 makes the determination
binding for library discovery. This PRD adopts both without alteration.

| Aspect | **Platform Public Discovery Index** | **Tenant Operational Data Index** |
|---|---|---|
| Indexed unit | The `TenantOrganisation` itself (`BC-19`) | Rows belonging to **one** tenant |
| Contents | **Only** the §14A.4/§14A.5 public fields, filtered by §14A.6 | Tenant-private records |
| Tenant key in index identity | Not applicable — the tenant *is* the record | ⭐ **MANDATORY** (`MP-GBR-08`, `SE-1`, `X-13`) |
| Caller tenant context | **None** — pre-authentication, anonymous | ⭐ **Always required** (`E-18`) |
| Severity if violated | Mixing tenant-private data in ⇒ **blocker** | Serving a tenant-less query ⇒ **blocker** |

`SRCH-FR-006` — `BC-23` **MUST** implement these two index classes as **separate** stores with separate query
paths. ⛔ A single index **MUST NOT** serve both classes.
`SRCH-BR-004` — Every tenant-operational index identity **MUST** include the tenant key. ⛔ A tenant-operational
index **MUST NOT** be addressable without one.
`SRCH-FR-007` — A query against a tenant-operational index **MUST** be rejected when the caller carries no tenant
context. ⛔ It **MUST NOT** fall back to an unscoped search.
`SRCH-INV-004` — ⭐⭐ **Tenant Operational Data MUST NEVER enter the Platform Public Discovery Index.** This is the
*"single highest-severity failure mode in the entire architecture"* (`AR-3`, quoted by `ADR-0094` §2.1).
`SRCH-XC-013` — ⛔ `BC-23` **MUST NOT** index anything §14A.10 marks never-public — expressly including
*Internal Analytics* (`ADR-0094` §2 rule 3).

---

## 10. ⭐⭐ Reusability — the architectural principle

**Flexible search is a reusable `BC-23` capability, not a feature of one product surface.**

`SRCH-FR-008` — The matching capability (§17–§22) **MUST** be implemented **once**, inside `BC-23`, and offered
identically to every authorised consumer through the query port. ⛔ It **MUST NOT** be implemented per surface.
`SRCH-FR-009` — Matching behaviour **MUST NOT** vary by consumer identity. Two consumers issuing the same query
against the same index with the same authorisation **MUST** receive the same matches in the same relevance order.
`SRCH-BR-005` — ⭐ The **capability** is defined for all authorised search surfaces; the **enabled consumer set** is
closed (§6.2). A future consumer is enabled by authorising its edge — ⛔ **never** by re-specifying matching.
`SRCH-XC-014` — ⛔ `BC-23` **MUST NOT** hardcode any consumer's field names, surface or product vocabulary into the
matching capability. Fields enter matching by **field-eligibility declaration** (§13), not by special case.

⚠ **What this principle costs, stated plainly:** because matching is uniform, a consumer cannot request bespoke
matching. That is intentional — bespoke matching per surface is precisely how a second search authority is born.

## 11. Index lifecycle

`SRCH-FR-010` — `BC-23` **MUST** create, update and delete index documents in response to the
`*Created` / `*Updated` / `*Deleted` events `E-21` carries (BC Map **L330**).
`SRCH-FR-011` — A `*Deleted` event **MUST** remove the document from every index in which it appears.
`SRCH-FR-012` — An identity anonymisation event (`identity.PersonAnonymised`, BC Map **L428**) **MUST** be treated
as a removal of the anonymised subject's indexed personal fields, not as an update.
`SRCH-FR-013` — A privacy-mode change (`identity.PersonPrivacyModeChanged`, BC Map **L427**) **MUST** be applied
with **no propagation window** — the event is recorded as having none (`SEV-9`).
`SRCH-FR-014` — A status change that removes eligibility (suspension, deactivation, unpublication) **MUST** remove
the document from the public discovery index.
`SRCH-INV-005` — ⭐ Every index **MUST** be fully rebuildable from the event log (BC Map **L453**: *"Every
projection (BC-26) and index (BC-23) must be rebuildable from the log. This is tested quarterly, not assumed."*).
`SRCH-BR-006` — ⛔ Eligibility **MUST NOT** be decided by `BC-23`. Publication is `BC-19`'s and §14A.6's choice;
`BC-23` *"only indexes what it is given"* (`ADR-0094` §2.1).

## 12. Data projection rules

`SRCH-FR-015` — Each index document **MUST** be a projection containing only declared-eligible fields (§13).
`SRCH-FR-016` — A field absent from the source event **MUST** be absent from the document. ⛔ `BC-23` **MUST NOT**
synthesise, default or infer a missing value.
`SRCH-XC-015` — ⛔ `BC-23` **MUST NOT** enrich a document by joining data from another context. Composition is the
consumer's act, not the index's.

## 13. Field eligibility

`SRCH-FR-017` — A field **MUST** be indexable only where its owning contract declares it so. For library
discovery, that contract is **§14A.4 / §14A.5**, filtered by **§14A.6**, bounded by **§14A.10** (`ADR-0094` §2).
`SRCH-FR-018` — Each eligible field **MUST** declare its match role: **text** (participates in tolerant matching,
§17), **exact** (identifier-like; exact/prefix only, §18), or **filter** (equality/range only, never text-matched).
`SRCH-BR-007` — ⛔ A field's match role **MUST NOT** be widened by `BC-23`. A field the owning contract publishes as
a filter **MUST NOT** become a tolerant-text field.
`SRCH-INV-006` — ⭐ **A field that is not declared eligible is not indexed, not matchable, and not returnable.**

## 14. Public vs private search data

`SRCH-FR-019` — The public discovery index **MUST** contain only fields the owning contract marks public.
`SRCH-FR-020` — A field marked never-public **MUST NOT** be indexed, matched, filtered, sorted, returned, or used
to influence relevance — ⭐ **including indirectly.**
`SRCH-XC-016` — ⛔ `BC-23` **MUST NOT** allow a never-public value to be **inferred** from search behaviour: not by
result presence, ordering, count, timing, error text or pagination artefact.

⚠ **`SRCH-XC-016` is the subtle one.** Excluding a field from output is insufficient if a query can still probe it.
If `?internal_note=x` narrows results, the note is disclosed even though it is never displayed.
