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
The C6 protection is verified by **`SRCH-AC-044`** (for `SRCH-BR-002`) and **`SRCH-AC-071`** (for `SRCH-XC-009`)
in §43. *(This is a cross-reference in prose, not an identifier — no `SRCH-*` register admits a bare note.)*

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

---

## 15. Query model

`SRCH-FR-021` — A query **MUST** consist of: an optional **text term**, zero or more **filters** (§23), a
**pagination** cursor (§25), and — for a tenant-operational index — the caller's **tenant context** (§9).
⛔ No other input **MAY** influence matching. In particular no viewer identity, location, history or session
attribute reaches the matcher, because `E-21` carries none and `SRCH-XC-003` forbids inventing them.

`SRCH-FR-022` — A text term **MUST** be interpreted **only** against fields whose declared match role admits it
(§13, `SRCH-FR-018`). ⛔ A query **MUST NOT** be able to name an arbitrary field, nor cause an ineligible field to
participate in matching.

⚠ **A query is a request, never an instruction.** The caller states *what it is looking for*; `BC-23` decides
*how* that is matched. This is what makes the capability reusable (§10) and what keeps the manipulation route
`XPC-OD-009` identified confined to indexed text rather than to caller-supplied tuning.

## 16. Query normalization

Normalization is the layer that makes flexible search possible **without** loosening relevance: it removes
differences that carry no meaning, before any tolerance is considered.

`SRCH-FR-023` — ⭐⭐ Normalization **MUST** be applied **identically** at index time and at query time, by the same
declared rule set.
`SRCH-FR-024` — Normalization **MUST**, where compatible with the field's declared script and language scope:

| # | Rule | Illustration |
|---|---|---|
| N1 | Case folding — matching is **case-insensitive** | `central library` ≡ `Central Library` ≡ `CENTRAL LIBRARY` |
| N2 | Leading, trailing and repeated **whitespace** collapse | `  Central   Library ` ≡ `Central Library` |
| N3 | **Punctuation and separator** normalization | `St. Mary's` ≡ `St Marys`; `Co-operative` ≡ `Co operative` |
| N4 | Unicode canonical normalization and compatible **diacritic** folding | `Café` ≡ `Cafe` |
| N5 | **Tokenization** into terms on normalized separators | `Central Library` → `central` + `library` |
| N6 | Removal of zero-width, control and formatting characters | invisible characters cannot create a distinct name |

`SRCH-BR-008` — ⭐ Normalization **MUST** be symmetric and total: any transformation applied to a query term
**MUST** have been applied to the indexed term, and vice versa. ⛔ An asymmetric rule **MUST NOT** be introduced,
because it silently makes some indexed documents permanently unreachable.

⚠ **Normalization is not tolerance.** N1–N6 do not guess. Two strings that normalize identically **are** the same
term at the EXACT tier (§18); nothing is loosened, so nothing irrelevant is admitted.

⚠ **Scope constraint (not a decision):** the *set of languages and scripts* whose diacritic and separator rules
apply is not stated by any repository authority. The **behaviour** above is required; the **language/script
inventory** is `SRCH-GAP-007`, owner **Product Owner** (which markets V1 serves) with **Architecture Owner**
(analyzer configuration). ⛔ No inventory is asserted here.

---

## 17. ⭐⭐⭐ Flexible / tolerant search — the reusable capability

### 17.1 The requirement

`SRCH-FR-025` — ⭐⭐ `BC-23` **MUST** implement matching as an **ordered ladder of tiers**, not as an
exact-string-only test. A query **MUST** be evaluated at each tier in order, and every tier a document satisfies
**MUST** be recorded as that document's match tier.

| Tier | Name | Section | Admits |
|---|---|---|---|
| **T1** | **EXACT / VERY STRONG MATCH** | §18 | Normalized term equals the indexed value, or equals it as a whole field |
| **T2** | **TOKEN / PARTIAL MATCH** | §19 | All query tokens present as tokens or token prefixes |
| **T3** | **CLOSE VARIANT / TOLERANT MATCH** | §20, §21 | Word-form variants, equivalent variations, and **bounded** minor misspellings |
| **T4** | **IRRELEVANT** | §22.3 | ⛔ **EXCLUDED from the result set entirely** |

`SRCH-FR-026` — ⭐ Every returned result **MUST** carry the tier at which it matched, so that relevance is
**explainable** and testable. ⛔ A result **MUST NOT** be returned without an attributable tier.

### 17.2 What flexibility explicitly buys

Each row below is a required behaviour, satisfied by the section named — **not** a new mechanism:

| The user types | They MUST still find | By |
|---|---|---|
| `central library` / `Central Library` / `CENTRAL LIBRARY` | *Central Library* | N1 case folding → **T1** |
| `Central   Library` (stray spaces) | *Central Library* | N2 → **T1** |
| `St Marys` | *St. Mary's* | N3 → **T1** |
| `library` | *Libraries* | §20 word-form equivalence → **T3** |
| `libraries` | *Library* | §20 (symmetric) → **T3** |
| `Central Lib` | *Central Library* | §19 token + prefix → **T2** |
| `lib central` (order swapped) | *Central Library* | §19 order-independent token match → **T2** |
| `Centrl Library` (one-character slip) | *Central Library* | §21 bounded typo tolerance → **T3** |
| `Central Library Delhi` (extra token) | *Central Library* — only if §19's multi-token rule is satisfied | §19.3 |
| `xylophone` | ⛔ **nothing** | **T4 — excluded** (§22.3) |

⭐ **`SRCH-FR-025` therefore answers the product requirement directly: a small spelling mistake MUST NOT
automatically produce zero results.** It is answered at **T3**, beneath two stronger tiers, and never by
abandoning relevance.

### 17.3 The four properties tolerance MUST NOT cost

`SRCH-BR-009` — Tolerance **MUST** preserve all four of the following, and any tolerance rule that cannot is
**MUST NOT** be admitted:

| Property | Requirement | Where enforced |
|---|---|---|
| **Relevance** | An irrelevant document **MUST NOT** appear at any tier | §22.3 `SRCH-BR-013`; §19.3 `SRCH-BR-010` |
| **Determinism** | The same query, index state and authorisation **MUST** yield the same results in the same order | `SRCH-FR-034` |
| **Explainability** | Every result **MUST** be attributable to a tier and a matched field | `SRCH-FR-026`, `SRCH-FR-036` |
| **Authorisation & isolation** | Tolerance **MUST NOT** widen what the caller is entitled to see | §27, §28, §29 |

`SRCH-FR-027` — ⭐⭐ Tolerance **MUST NOT** be applied to fields whose declared match role is **exact** (§13).
Identifier-like values — codes, PIN codes, registration numbers, identifiers — **MUST** match exactly or by
prefix only. ⛔ A typo-tolerant identifier match is a correctness defect, not a convenience.

⚠⚠ **The implementation-specific tolerance parameters are NOT decided here.** The *behaviour* above is required.
The **edit-distance bound, minimum term length before tolerance applies, minimum prefix length, and analyzer
configuration** are implementation parameters that **no repository authority states**. They are recorded as
**`SRCH-GAP-002`**, owner **Architecture Owner**. ⛔ **No numeric value is invented in this document.** A
conformant implementation must have such bounds; this PRD requires that they exist, are declared, and are
uniform — not what they are.

## 18. Exact matching — T1

`SRCH-FR-028` — A document **MUST** match at **T1** when a normalized query term equals a normalized indexed
value of an eligible field, either as the whole field or as a complete token sequence within it.
T1 **MUST** be evaluated first, and a T1 match **MUST** outrank every weaker tier (§22).

## 19. Partial and token matching — T2

### 19.1 Token matching

`SRCH-FR-029` — A document **MUST** match at **T2** when **every** query token matches an indexed token of an
eligible field. Token matching **MUST** be **order-independent** (`lib central` finds *Central Library*).

### 19.2 Prefix / partial matching

`SRCH-FR-030` — A query token **MUST** be able to match an indexed token by **prefix**, so that an incomplete word
matches the word it begins (`Lib` → `Library`). ⛔ Prefix matching **MUST NOT** be applied as a suffix or
infix match on **exact**-role fields.

### 19.3 Multi-word queries

`SRCH-BR-010` — ⭐ A multi-word query **MUST** be treated **conjunctively**: every token must be satisfied by the
document, at some tier. ⛔ A document satisfying only **one** token of a multi-token query **MUST NOT** be returned
merely because that one token matched — that is the precise mechanism by which flexible search degenerates into
irrelevant search.

⚠ **Consequence, stated honestly:** `Central Library Delhi` will **not** match a *Central Library* whose indexed
eligible fields contain no `Delhi`. That is correct behaviour under `SRCH-BR-010`: adding a token narrows.
Whether the discovery *surface* should additionally interpret a city token as a **filter** is a §14A product
question, ⛔ **not** `BC-23`'s — see `SRCH-XC-001`.

## 20. Similar word forms and equivalent variations — T3

`SRCH-FR-031` — A document **MUST** be able to match at **T3** through declared **word-form equivalence**, covering
at least:

| # | Class | Illustration |
|---|---|---|
| V1 | **Singular / plural** forms | `library` ≡ `libraries` |
| V2 | **Related word forms** of one stem | `reading` ≡ `read`; `booking` ≡ `book` |
| V3 | **Equivalent written variations** | `centre` ≡ `center`; `&` ≡ `and` |
| V4 | Declared **abbreviation / expansion** pairs | `lib` ≡ `library`, only where declared |

`SRCH-FR-032` — Word-form equivalence **MUST** be **symmetric**: if `library` matches *Libraries*, then
`libraries` **MUST** match *Library*.
`SRCH-BR-011` — ⛔ Equivalence **MUST** be derived from a **declared** rule set or vocabulary, and **MUST NOT** be
inferred from usage, click behaviour, co-occurrence or any learned model (`SRCH-XC-005`).

⚠ **V4 is deliberately narrow.** An undeclared abbreviation table is indistinguishable from invented product
vocabulary, which `SRCH-XC-014` forbids. The *rule classes* are required; the *vocabulary inventory* is
`SRCH-GAP-007` (§16), owner **Product Owner**.

## 21. Typo and misspelling handling — T3

`SRCH-FR-033` — ⭐ A document **MUST** be able to match at **T3** when a query token differs from an indexed token
by a **bounded, minor** character difference — insertion, deletion, substitution or transposition — such that a
reasonable minor misspelling does not produce zero results.

`SRCH-BR-012` — Typo tolerance **MUST** be constrained by all of the following, and an implementation that cannot
satisfy them **MUST NOT** enable it:

| # | Constraint | Reason |
|---|---|---|
| C1 | It **MUST NOT** apply to **exact**-role fields | `SRCH-FR-027` |
| C2 | It **MUST NOT** apply below a declared minimum token length | short tokens are mutually reachable and matching becomes noise |
| C3 | The permitted difference **MUST** be bounded and uniform across consumers | `SRCH-FR-009`, `SRCH-FR-034` |
| C4 | A T3 typo match **MUST NOT** outrank any T1 or T2 match | §22.2 |
| C5 | It **MUST NOT** widen authorisation, tenant scope or field eligibility | §27, §28, §14 |

⚠ **C2's minimum length and C3's bound are `SRCH-GAP-002`, owner Architecture Owner.** ⛔ Not fabricated here.

## 22. Relevance model

### 22.1 Determinism

`SRCH-FR-034` — ⭐ Relevance ordering **MUST** be **deterministic and total**: identical query, index state and
authorisation **MUST** produce an identical order. Ties **MUST** be broken by a declared, stable tiebreak so that
no two executions differ. ⛔ Arbitrary or unstable ordering **MUST NOT** be returned.

### 22.2 The ordering rule

`SRCH-FR-035` — Results **MUST** be ordered by, in strict precedence:

1. **Match tier** — T1 before T2 before T3 (§17.1). ⭐ A tier boundary **MUST NOT** be crossed by any other factor.
2. **Field precedence** — a match on a higher-precedence eligible field before a lower one, per the owning
   contract's declared field order. ⚠ **Measured: §14A declares no field precedence order** (zero occurrences of
   *precedence*). This is recorded as **`SRCH-GAP-009`**, owner **Product Owner** — ⛔ this PRD **MUST NOT**
   invent one, because field precedence is a §14A product statement (`SRCH-XC-001`). Until it is declared,
   ordering degrades gracefully to tier + stable tiebreak, which remains deterministic and total.
3. The **declared stable tiebreak** (`SRCH-FR-034`).

`SRCH-FR-036` — Relevance **MUST** be explainable: for every result, the tier, the matched field and the applied
rule class **MUST** be attributable. ⛔ An unexplainable score **MUST NOT** be the basis of ordering.

⚠ **There is no numeric relevance score in this model, and that is deliberate.** A score would require weights;
weights are not authorised (`SRCH-XC-009`); inventing them would breach the instruction's §4 and `ADR-0094`'s
method. Tier + field precedence + stable tiebreak is fully ordering-complete **without** a single invented number.

### 22.3 ⭐⭐ T4 — irrelevant means excluded, not ranked last

`SRCH-BR-013` — ⭐⭐ A document that satisfies **no** authorised tier **MUST be excluded from the result set**.
⛔ It **MUST NOT** be returned at a low position, with a low score, or as a "weak" or "suggested" match.

⚠ **This is the single rule that separates flexible search from bad search.** Returning everything ordered by
similarity means a query for `xylophone` returns libraries — which destroys precision, makes empty results
impossible to distinguish from bad results (§26), and makes result *presence* an information channel
(`SRCH-XC-016`).

### 22.4 Relevance is not ranking — restated normatively

The layer table in **§5.3** is normative and is not repeated. Two consequences bind here:

- `BC-23` orders **only** by `SRCH-FR-035`. ⛔ Nothing in §22 grants `BC-23` a business ordering.
- A consumer with its own authorised ordering — §14A's distance sort is the only one that exists — applies it
  **after** retrieval (`SRCH-XC-009`). ⛔ `PRD-021C` C6 therefore does **not** acquire a second ranking engine
  from this document, satisfying `LSD-XC-002` and C6 **L78**.

---

## 23. Filtering

`SRCH-FR-037` — Filters **MUST** be applied **conjunctively** with the text match and **MUST** only ever narrow
the result set. ⛔ A filter **MUST NOT** broaden it, and **MUST NOT** re-admit a T4 document.
`SRCH-FR-038` — A filter **MUST** be accepted only on a field whose declared match role is **filter** or **exact**
(§13). ⛔ A filter on an ineligible or never-public field **MUST** be rejected as invalid — not silently ignored,
which would itself disclose the field's existence (`SRCH-XC-016`).

## 24. Sorting

`SRCH-BR-014` — `BC-23` **MUST** offer exactly one ordering: **relevance** (`SRCH-FR-035`). ⛔ It **MUST NOT**
offer, accept or implement a business sort parameter. Any other ordering — including §14A's distance sort — is
applied by the authorised consumer **after** retrieval, under that consumer's own authority.

⚠ This is `SRCH-XC-009` seen from the consumer's side, and it is why §14A **L114**'s single named ordering stays
where §14A put it.

## 25. Pagination

`SRCH-FR-039` — The query port **MUST** provide bounded, deterministic pagination whose page size is capped by the
port, ⛔ never by the caller alone. *(Request shape and pagination are `LSD-FR-008`'s explicit demands on
`BC-23`'s owner — see §37.)*
`SRCH-FR-040` — Pagination **MUST NOT** change authorisation, tenant scope or field eligibility on any page.
Page *n* **MUST** be subject to exactly the checks page 1 was (§27, §28).

⚠ **Result-set stability under concurrent index updates** is a real consequence and is not decided here: whether a
cursor is snapshot-consistent or live is an implementation property bounded by `SRCH-GAP-002` and §32.

## 26. Empty result handling

`SRCH-FR-041` — An empty result set **MUST** be a valid, successful response. ⛔ `BC-23` **MUST NOT** avoid
emptiness by widening tiers beyond T3, dropping query tokens, or returning T4 documents (`SRCH-BR-013`).
`SRCH-FR-042` — An empty result **MUST NOT** be distinguishable, by response shape, error, timing or message, from
a result set emptied by authorisation, tenant scope or field-eligibility filtering (`SRCH-XC-016`, §30).

⚠⚠ **`SRCH-FR-042` is a security requirement wearing a usability costume.** *"No results"* and *"results you are
not entitled to see"* **must** look identical, or search becomes an existence oracle.

---

## 27. ⭐⭐⭐ Authorization — being indexed is not being visible

This is the most security-critical section in the document, and it restates a rule the repository already holds
rather than inventing one.

`SRCH-INV-001` (§5.2) established that `BC-23` holds no source of truth. It follows that `BC-23` also holds no
**entitlement** truth. The indexing decision and the visibility decision are **different decisions, made by
different owners, at different times.**

| | Indexing decision | Visibility decision |
|---|---|---|
| **Who decides** | The owning context, by publishing an `E-21` event | The **source system's** authorisation, at query time |
| **When** | When the fact changes | On **every** query, and on **every** page (§25) |
| **What it means** | *"this document may exist in an index"* | *"this caller may see this document now"* |
| ⛔ **What it does NOT mean** | ⭐⭐ *"everyone may search it"* | — |

`SRCH-BR-001`…`SRCH-BR-014` are fully allocated; the requirements below are therefore expressed as invariants and
functional requirements already registered, plus the exclusions registered in §14 and §7.

**The governing rule, stated as the instruction requires it:**

> ⭐⭐⭐ **Being indexed does NOT make data searchable by everyone. Search results MUST NEVER bypass source-system
> authorization.**

This is enforced by the requirements already registered, applied here:

- `SRCH-FR-001` — retrieval is only ever through the query port, so there is no path that skips the check.
- `SRCH-FR-007` — a tenant-operational query with no tenant context is **rejected**, never widened.
- `SRCH-INV-002` — a document lives in exactly one index class, so a public query can never reach tenant rows.
- `SRCH-INV-004` — tenant data can never be present in the public index in the first place.
- `SRCH-FR-020`, `SRCH-XC-016` — a never-public field is neither returned nor inferable.
- `SRCH-FR-040` — authorisation is re-evaluated per page; it is not a first-page-only gate.
- `SRCH-FR-013` — a privacy-mode change applies with **no propagation window** (`SEV-9`), so the index cannot
  keep serving a subject who has just withdrawn.
- `SRCH-FR-042` — an authorisation-emptied result is indistinguishable from a genuinely empty one.

⚠ **The failure mode this section exists to prevent, named exactly:** an index is a *copy*. If entitlement were
evaluated when the copy was written rather than when it is read, then every later revocation — suspension,
privacy-mode change, anonymisation, unpublication, membership ending — would leave a searchable residue. The
index would become a permanent, silent bypass of the owning system's access control. `SRCH-FR-014`,
`SRCH-FR-012` and `SRCH-FR-013` exist precisely so that revocation propagates into the index, and §27's
query-time re-evaluation exists so that it is still correct in the window before it does.

⚠ **What is NOT authored here, and why:** the platform's authorisation model itself — roles, scopes, capability
contexts, the `E-18` caller-context contract — is **not** `BC-23`'s to define, and no requirement above
redefines it. `BC-23` **consumes** the source system's decision. Recorded as **`SRCH-GAP-003`**: the precise
mechanism by which the source system's entitlement decision is evaluated for an index document at query time is
an integration contract requiring the **Architecture Owner**, and is not stated by any current authority.
⛔ It is not invented here — and until it is decided, the only index class this PRD's V1 enabled set actually
exercises is the **anonymous public discovery index**, where the caller has no entitlements to bypass.

## 28. Tenant isolation

`SRCH-INV-004` (§9) and `SRCH-BR-004` (§9) are the operative requirements; this section states their consequences.

| # | Consequence | Basis |
|---|---|---|
| 1 | A tenant-operational query **MUST** be scoped by the caller's tenant key before matching, never filtered after | `SRCH-BR-004`, `MP-GBR-08`, `SE-1`, `X-13` |
| 2 | Tolerance (§20, §21) **MUST NOT** cross a tenant boundary — a typo cannot reach another tenant's document | `SRCH-BR-012` C5 |
| 3 | Relevance **MUST NOT** be computed across tenants — corpus statistics **MUST NOT** leak one tenant's data into another's ordering | `SRCH-FR-035` (tier + field precedence only, no corpus statistics) |
| 4 | Pagination, error text and result counts **MUST NOT** reveal the existence of another tenant's documents | `SRCH-XC-016`, `SRCH-FR-042` |
| 5 | A tenant-less query **MUST** be **rejected**, never served unscoped | `SRCH-FR-007` |

⚠ **Consequence 3 is the non-obvious one, and it is why §22 has no numeric score.** A conventional relevance
score is computed from corpus-wide term statistics. In a shared index, those statistics are a covert channel: the
*score* of a document in tenant A varies with the *contents* of tenant B. `SRCH-FR-035`'s tier-and-precedence
ordering has no corpus term, so this channel does not exist by construction.

## 29. Privacy

`SRCH-FR-012` (anonymisation ⇒ removal), `SRCH-FR-013` (privacy mode, no propagation window) and `SRCH-FR-020`
(never-public fields) are the operative requirements. Applied:

- ⭐ **Anonymisation is removal, not masking.** A masked document is still a document; its presence, count and
  position remain observable, which `SRCH-XC-016` forbids. `SRCH-FR-012` therefore removes.
- ⭐ **Privacy mode has no grace period.** BC Map **L427** records `SEV-9` as having **no propagation window**;
  `SRCH-FR-013` inherits that, so `BC-23` **MUST NOT** define an eventual-consistency allowance for it.
- ⭐ **Personal data is not indexed for a surface that does not exist.** `BC-10` and `BC-01` are authorised `E-21`
  sources with **no V1 enabled consumer** (§6.2, `SRCH-GAP-006`). ⛔ This PRD does **not** enable person search
  in V1, so the least-privilege position is preserved by default.

## 30. Security

`SRCH-XC-016` (§14) is the operative exclusion. Its concrete obligations:

| # | Attack | Required posture |
|---|---|---|
| S1 | **Existence probing** — inferring a private value by observing whether results narrow | Filters on ineligible fields are **rejected** (`SRCH-FR-038`); never silently ignored |
| S2 | **Enumeration** — walking the corpus via pagination | Page size capped by the port (`SRCH-FR-039`); per-page authorisation (`SRCH-FR-040`) |
| S3 | **Error-channel disclosure** — distinguishing "no match" from "not permitted" | Indistinguishable responses (`SRCH-FR-042`) |
| S4 | **Cross-tenant inference via relevance** | No corpus-statistic scoring (§28 consequence 3) |
| S5 | **Injection into the index** | Events only, single write path (`SRCH-FR-004`, `SRCH-XC-012`) |
| S6 | **Tuning abuse** — a caller steering ordering | No exposed weight or boost (`SRCH-XC-009`); uniform behaviour (`SRCH-FR-009`) |

## 31. Abuse and rate limiting

⚠⚠ **This section deliberately decides nothing.**

The public discovery surface is **anonymous** (`AR-3`: caller tenant context *"none"*), which means `BC-23` has no
viewer identity with which to attribute abuse. `SRCH-XC-006` already excludes bot detection, CAPTCHA and IP
reputation, because **no owner exists** for them (`XPC-OD-010`, OPEN) and `LIB-14B.42` constrains what the
anonymous surface may collect (`PRD-021C` C6 **L359**).

Two distinct open items are therefore **recorded, not solved**:

| Gap | Question | Owner | Blocks V1? |
|---|---|---|---|
| **`SRCH-GAP-004`** | **Keyword stuffing** in §14A.5 public text — a library inflating its own text-query relevance | ⭐ **Architecture Owner** (index internals / analyzer) **+ Product Owner** (acceptable-use rules) | ⛔ **No** — `XPC-OD-009` records that it blocks nothing in V1 |
| **`SRCH-GAP-008`** | Query-volume abuse / rate limiting on the anonymous surface | ⛔ **No owner exists** — `XPC-OD-010` is OPEN | ⛔ **No** — recorded, not assigned |

⭐ **`SRCH-GAP-004` is the discharge of `XPC-OD-009`'s routing instruction** — *"Record it against `PRD-015` when
that PRD is authored"* (`PRD-021C` C0 **L427**; `ADR-0098` **L221**). It is **recorded**, with its owners named
as that record names them. ⛔ It is **not decided**, because deciding it here would answer an owner decision this
document has no authority to answer.

## 32. Index consistency

`SRCH-FR-004` (events only) and `SRCH-INV-005` (rebuildable from the log) are operative.

- `BC-23` is an **eventually consistent projection**. BC Map **L330** classifies `E-21` as `PL`+Event; a
  projection lags by construction.
- ⭐ The **one** exception is `SRCH-FR-013`: privacy-mode change has **no propagation window** (`SEV-9`).
- ⚠ The **acceptable lag** for every other event class is **not stated** by any authority. It is
  **`SRCH-GAP-002`** (§36), owner **Architecture Owner**. ⛔ No number is invented.

## 33. Stale data handling

`SRCH-INV-003` (§8) is operative: on disagreement, the **owning context wins**.

- ⭐ A stale document **MUST NOT** be treated as a business fact. A consumer needing an authoritative value
  **MUST** resolve it against the owning context using the identifier `SRCH-FR-005` requires.
- ⭐ Staleness **MUST NOT** be resolved in the caller's favour on authorisation. Where the index and the source
  system disagree about visibility, §27's query-time re-evaluation governs — the index never grants access.

## 34. Rebuild and recovery

`SRCH-INV-005` — every index **MUST** be fully rebuildable from the event log, and BC Map **L453** requires this
to be *"tested quarterly, not assumed."* Consequences:

- ⭐ A rebuilt index **MUST** be **equivalent** to the incrementally maintained one for matching and ordering
  purposes. `SRCH-FR-034`'s determinism makes this checkable rather than aspirational.
- ⭐ Rebuild **MUST NOT** re-admit removed documents: replay **MUST** honour `*Deleted` (`SRCH-FR-011`),
  anonymisation (`SRCH-FR-012`), privacy mode (`SRCH-FR-013`) and eligibility loss (`SRCH-FR-014`).
- ⚠ Rebuild **availability posture** — whether search degrades, serves stale, or is unavailable during a rebuild —
  is an operational decision recorded in **`SRCH-GAP-002`**. ⛔ Not decided here.

## 35. Failure handling

| Condition | Required behaviour | Basis |
|---|---|---|
| Query on a tenant index with no tenant context | **Reject.** ⛔ Never widen | `SRCH-FR-007` |
| Filter on an ineligible or never-public field | **Reject as invalid.** ⛔ Never silently ignore | `SRCH-FR-038` |
| No document satisfies any tier | **Successful empty result.** ⛔ Never widen past T3 | `SRCH-FR-041`, `SRCH-BR-013` |
| Index unavailable | ⭐ **Fail closed.** ⛔ `BC-23` **MUST NOT** fall back to reading a domain table | `SRCH-FR-004`; BC Map **L330** |
| Event cannot be projected | Do not partially index; the log remains the recovery source | `SRCH-INV-005` |

⚠ **"Fail closed" is not a preference; it is forced.** BC Map **L330** states *"Search never reads domain
tables"*, so no read-through fallback is architecturally available. A degraded-search fallback path would be a
second retrieval route and a second authorisation surface.

## 36. Performance

⚠⚠ **No performance target is stated in this document, and that is a deliberate refusal.**

Searched and measured: no repository authority states a latency budget, throughput target, index-size limit,
freshness SLO or availability target for `BC-23`. `ADR-0094` decided the *contract*, not the *engine*
(`ADR-0094` §5: what the ADR *"does not do"*).

`SRCH-GAP-002` therefore records, as one owned item, every implementation parameter this PRD requires to **exist**
but refuses to **invent**:

| # | Parameter | Required to exist by |
|---|---|---|
| P1 | Search engine / index technology selection | §0.3 |
| P2 | Analyzer, tokenizer and normalization rule configuration | `SRCH-FR-023`, `SRCH-FR-024` |
| P3 | Edit-distance bound and minimum token length for tolerance | `SRCH-BR-012` C2, C3 |
| P4 | Minimum prefix length for partial matching | `SRCH-FR-030` |
| P5 | Maximum page size cap | `SRCH-FR-039` |
| P6 | Acceptable projection lag per event class (except `SEV-9`, which has none) | §32 |
| P7 | Query latency, throughput and availability targets | this section |
| P8 | Rebuild availability posture and duration | §34 |

**Owner: Architecture Owner.** ⛔ **Blocks Stage 3 architecture review; blocks nothing in Stage 2**, because every
row above is an implementation property of a requirement that is already fully specified behaviourally.

---

## 37. ⭐⭐ APIs and contracts — the discharge of `LSD-FR-008`

### 37.1 Why this section exists

`PRD-021C` C2 is **FROZEN** and contains a requirement written deliberately as a **refusal**:

> **`LSD-FR-008`** — *"The query port's contract — request shape, pagination, error taxonomy — **MUST** be defined
> by `BC-23`'s owner, and C2 **MUST NOT** author it."*
> *(Accompanying note: "`LSD-FR-008` is a refusal, deliberately written as a requirement.")*

`BC-23`'s owner is `PRD-015`. This section is therefore the **only** lawful place in the repository for this
contract, and its absence was the concrete reason C2 could not proceed past a port stub.

### 37.2 The three elements `LSD-FR-008` names

**(a) Request shape** — fixed by `SRCH-FR-021`: optional text term · zero or more filters · pagination cursor ·
tenant context where the index class requires it. ⛔ Nothing else, per `SRCH-FR-021` and `SRCH-FR-022`.

**(b) Pagination** — fixed by `SRCH-FR-039` (bounded, deterministic, port-capped page size) and `SRCH-FR-040`
(authorisation and scope re-evaluated on every page).

**(c) Error taxonomy** — the response classes below are **required to be distinct**, with one required
**indistinguishability** constraint:

| Class | Cause | Required response | Basis |
|---|---|---|---|
| **Success — populated** | ≥1 document matched at T1–T3 | Results, each carrying its match tier | `SRCH-FR-026` |
| **Success — empty** | No document matched at any tier | ⭐ Successful empty result | `SRCH-FR-041` |
| **Success — empty (filtered)** | Matches existed but were removed by authorisation, tenant scope or field eligibility | ⭐⭐ **Indistinguishable** from *Success — empty* | `SRCH-FR-042`, `SRCH-XC-016` |
| **Invalid request** | Filter on an ineligible/never-public field; malformed cursor; caller-set page size above the cap | **Reject.** ⛔ Never silently ignore, never widen | `SRCH-FR-038`, `SRCH-FR-039` |
| **Not permitted — no tenant context** | Tenant-operational index queried with no tenant context | ⭐ **Reject.** ⛔ Never fall back to unscoped | `SRCH-FR-007` |
| **Unavailable** | Index unavailable | ⭐ **Fail closed.** ⛔ No domain-table fallback | `SRCH-FR-004`; BC Map **L330** |

⚠⚠ **The two rows that must not be collapsed, and the two that must not be separated.** *Invalid request* must be
distinct from *Success — empty*, or a rejected filter becomes indistinguishable from a filter that matched nothing
(and `SRCH-FR-038`'s protection is lost). Conversely *Success — empty* and *Success — empty (filtered)* **must**
be identical, or the taxonomy itself becomes the existence oracle §30 S3 describes.

### 37.3 What is deliberately not fixed here

⛔ **No wire format, protocol, endpoint path, field naming convention or serialisation is stated.** `LSD-FR-008`
demands *request shape, pagination and error taxonomy* — the three elements above — and no authority grants
`PRD-015` the platform's API-convention decision. Transport binding is **`SRCH-GAP-002`** (P1), owner
**Architecture Owner**.

⚠ **Honest limitation:** C2 can now be reviewed against a defined contract, but cannot be *implemented* against
one until `SRCH-GAP-002` and `SRCH-GAP-003` are closed. That is a Stage-3 dependency, recorded rather than
concealed.

## 38. Events and integration boundaries

`E-21` is the **only** authorised inbound edge, and this PRD adds **no** edge and **no** event.

| Aspect | Value | Authority |
|---|---|---|
| Inbound edge | **`E-21`** — `BC-01`, `BC-10`, `BC-19` → `BC-23` | BC Map **L330** |
| Pattern | `PL` + Event; *"Search never reads domain tables"* | BC Map **L330** |
| `BC-19` as a source | Added by **`ADR-0093`** | BC Map **L330** |
| Contract | `Library_PRD_v1.md` §14A, by **`ADR-0094`** | BC Map **L330** |
| Index class | Platform Public Discovery Index (**`AR-3`**) | BC Map **L330**; `AR-3` |
| ⛔ Excluded source | **`BC-15` is deliberately NOT a source** | BC Map **L330**, **L753**; `ADR-0083` §4.5 `AO-9` |
| Consumer edge for AI | **`E-26`** — *"permission-aware ports only — never direct index or table access"* | BC Map **L335** |

⛔ **No new bounded context. No new edge. No new event.** Context count, edge count and event inventory are
unchanged by this document (verified in §44.4).

## 39. Testing requirements

Stage-2 statement of **what must be testable**. ⛔ No test is authored, and no test is offered as implementation.

| # | Class | Must demonstrate |
|---|---|---|
| T-A | **Tier ladder** | Each §17.2 row resolves to its stated tier; `xylophone` returns nothing |
| T-B | **Normalization symmetry** | `SRCH-BR-008` — index-time and query-time rules are identical |
| T-C | **Variant symmetry** | `SRCH-FR-032` — equivalence holds in both directions |
| T-D | **Exact-field protection** | `SRCH-FR-027` — no tolerance on identifier-like fields |
| T-E | **Conjunctive multi-token** | `SRCH-BR-010` — a one-token-of-three match is excluded |
| T-F | **T4 exclusion** | `SRCH-BR-013` — no low-ranked irrelevant residue |
| T-G | **Determinism** | `SRCH-FR-034` — repeated identical execution is order-identical |
| T-H | **Explainability** | `SRCH-FR-026`, `SRCH-FR-036` — every result attributable to tier + field |
| T-I | **Tenant isolation** | §28 — including that a typo cannot cross a tenant boundary |
| T-J | **Public-index purity** | `SRCH-INV-004` — no tenant-private field ever present |
| T-K | **Inference resistance** | `SRCH-XC-016`, `SRCH-FR-042` — empty vs filtered-empty indistinguishable |
| T-L | **Revocation propagation** | `SRCH-FR-012`, `SRCH-FR-013`, `SRCH-FR-014` |
| T-M | **Rebuild equivalence** | `SRCH-INV-005`; BC Map **L453** — *"tested quarterly, not assumed"* |
| T-N | **Uniformity across consumers** | `SRCH-FR-009` — identical behaviour regardless of caller |

## 40. Edge cases

| # | Case | Required behaviour |
|---|---|---|
| E1 | Empty text term, filters only | Valid — filters applied alone (`SRCH-FR-021`, `SRCH-FR-037`) |
| E2 | Text term of only punctuation/whitespace | Normalizes to no tokens ⇒ treated as E1, ⛔ never as "match all at T3" |
| E3 | Token below the tolerance minimum length | Matched at T1/T2 only (`SRCH-BR-012` C2) |
| E4 | Query token matching **two** documents identically | Both returned; order fixed by the stable tiebreak (`SRCH-FR-034`) |
| E5 | Same document matching at two tiers on two fields | Recorded at its **strongest** tier (`SRCH-FR-025`) |
| E6 | Indexed value containing an invisible/zero-width character | N6 removes it — ⛔ it cannot create an unmatchable name |
| E7 | Typo that turns one valid indexed token into another | ⚠ Ambiguous by nature; both are T3 candidates, order by stable tiebreak — ⛔ `BC-23` **MUST NOT** guess intent |
| E8 | Document deleted between page 1 and page 2 | Page 2 re-evaluated (`SRCH-FR-040`); the removed document is absent — ⛔ never resurrected |
| E9 | Event arrives for an ineligible field | Field not indexed (`SRCH-INV-006`); ⛔ not stored "for later" |
| E10 | Anonymisation arriving for an already-deleted document | Idempotent no-op; ⛔ never re-created |
| E11 | Query naming a field that does not exist | **Invalid request** (§37.2) — ⛔ not silently dropped |
| E12 | Public query arriving with a tenant context | Public index served identically; ⛔ tenant context **MUST NOT** widen the public result set |

⭐ **E12 is the mirror of `SRCH-FR-007`** and closes the loop `AR-3` opens: the public index has *no* tenant key,
so presenting a tenant context to it must change nothing at all.

## 41. Risks

| # | Risk | Severity | Mitigation in this PRD | Residual |
|---|---|---|---|---|
| R1 | Tenant data reaching the public index | ⭐⭐ **Highest in the architecture** (`AR-3`) | `SRCH-INV-004`, `SRCH-INV-002`, `SRCH-FR-006`, T-J | Implementation-verified, not document-verified |
| R2 | Index becoming a silent authorisation bypass | ⭐⭐ Critical | §27 query-time re-evaluation; `SRCH-FR-040`; `SRCH-FR-012`–`014` | ⚠ **`SRCH-GAP-003`** — the entitlement-evaluation mechanism is undecided |
| R3 | Tolerance degrading precision | High | Tier ladder; `SRCH-BR-010`; `SRCH-BR-013`; `SRCH-FR-027` | ⚠ **`SRCH-GAP-002`** — bounds undecided |
| R4 | A second ranking engine emerging | High | §5.3; `SRCH-BR-002`; `SRCH-XC-009`; `SRCH-BR-014` | Discipline-dependent; C6 must consume, not tune |
| R5 | Keyword stuffing inflating relevance | Medium | Recorded as **`SRCH-GAP-004`** with named owners | ⚠ Open by design — `XPC-OD-009` blocks nothing in V1 |
| R6 | Divergence between this PRD and frozen §14A | ⭐⭐ The risk `ADR-0094` §3 rejected option B to avoid | §3 boundary table; `SRCH-XC-001`, `SRCH-XC-002`; **no §14A field restated** | ⚠ Must be re-checked on any §14A amendment |
| R7 | Cross-tenant leakage through relevance statistics | Medium | §28 consequence 3; no corpus-statistic scoring | Depends on P2 honouring §22 |
| R8 | Anonymous-surface query abuse | Medium | ⛔ Not solved — **`SRCH-GAP-008`** | ⚠ No owner exists (`XPC-OD-010`) |
| R9 | This draft being mistaken for conferred status | Medium | Header + warning block; **`SRCH-GAP-001`** | ⚠ Registry **L315** still reads `PLANNED` |

⭐ **R6 is the risk this document was most likely to create, and §3 is the control.** It is listed openly because
`ADR-0094` §3's rejection of option B was grounded in exactly this risk.

## 42. Open decisions and gaps

⛔ **Every item below is recorded, owned and unresolved. None is answered by invention.**

| Gap | Question | Owner | Blocks | Basis |
|---|---|---|---|---|
| **`SRCH-GAP-001`** | `PRD-015`'s registry status is `PLANNED`; this document is a Stage-2 draft. A `PLANNED` → `DRAFT` transition needs conferred authority | ⭐ **Governance Owner** | ⛔ Nothing in authoring; **blocks Stage-2 conferral** | `PRD_REGISTRY.md` **L315**, **L726-727** |
| **`SRCH-GAP-002`** | All implementation parameters P1–P8: engine, analyzer config, edit-distance bound, minimum token/prefix length, page-size cap, projection lag, latency/availability targets, rebuild posture, transport binding | **Architecture Owner** | **Stage 3**; nothing in Stage 2 | §36; `ADR-0094` §5 |
| **`SRCH-GAP-003`** | The mechanism by which a source system's entitlement decision is evaluated for an index document **at query time** | **Architecture Owner** | **Stage 3**; and any tenant-operational surface | §27 |
| **`SRCH-GAP-004`** | ⭐ **Keyword stuffing** in §14A.5 public text inflating text-query relevance | ⭐ **Architecture Owner** (analyzer) **+ Product Owner** (acceptable use) | ⛔ **Nothing in V1** | ⭐ `XPC-OD-009` (C0 **L427**; `ADR-0098` **L221**) — **this row is its discharge** |
| **`SRCH-GAP-005`** | Whether `PRD-021B` student discovery becomes an `E-21` consumer; no consumer authority is measured for `BC-11`/`BC-12` | **Architecture Owner** (edge) **+ Product Owner** (scope) | ⛔ Nothing in V1 — not enabled (§6.2) | §6.2; `ADR-0094` §2 rule 4 |
| **`SRCH-GAP-006`** | `BC-01` and `BC-10` are authorised `E-21` sources with **no V1 enabled consumer** — index them, or defer the route? | **Product Owner** (need) **+ Architecture Owner** (posture) | ⛔ Nothing in V1 | §7; BC Map **L330** |
| **`SRCH-GAP-007`** | The language/script inventory and the declared variant/abbreviation vocabulary for §16 and §20 | **Product Owner** (markets) **+ Architecture Owner** (analyzer) | **Stage 3** | §16; §20 V4 |
| **`SRCH-GAP-008`** | Query-volume abuse and rate limiting on the anonymous public surface | ⛔ **No owner exists** | ⛔ Nothing in V1 | `XPC-OD-010` (OPEN); `LIB-14B.42` |
| **`SRCH-GAP-009`** | ⭐ §14A declares **no field precedence order**, which `SRCH-FR-035` layer 2 requires | **Product Owner** — it is a §14A product statement | ⛔ Nothing (ordering stays deterministic without it) | §22.2, measured: zero occurrences of *precedence* in §14A |

⭐⭐ **`SRCH-GAP-001` and `SRCH-GAP-004` are the two that matter most for governance.** The first is this
document's own honest status disclosure. The second is the **discharge of a routing instruction placed on
`PRD-015` by a baselined ADR** — the reason `ADR-0098` **L221** and `PRD-021C` C0 **L427** both point here.

---

## 43. Acceptance criteria

**Every one of the 78 obligation-bearing identifiers has exactly one acceptance criterion, and every criterion is
written in Given / When / Then form.** The mapping is positional and total:

| Obligations | Acceptance criteria |
|---|---|
| `SRCH-FR-001` … `SRCH-FR-042` | `SRCH-AC-001` … `SRCH-AC-042` |
| `SRCH-BR-001` … `SRCH-BR-014` | `SRCH-AC-043` … `SRCH-AC-056` |
| `SRCH-INV-001` … `SRCH-INV-006` | `SRCH-AC-057` … `SRCH-AC-062` |
| `SRCH-XC-001` … `SRCH-XC-016` | `SRCH-AC-063` … `SRCH-AC-078` |

⚠ **A criterion existing is not a criterion passing.** ⛔ None of the below is asserted as satisfied; this is a
Stage-2 document and no implementation exists to verify against (`PRD_LIFECYCLE.md` — Stage 4 is a separate,
conferred act).

### 43.1 Functional requirements — `SRCH-AC-001` … `SRCH-AC-042`

**`SRCH-AC-001`** *(`SRCH-FR-001`)* — **Given** an authorised consumer, **when** it attempts to read a `BC-23`
index by any route other than the query port, **then** the attempt fails and no index content is returned.

**`SRCH-AC-002`** *(`SRCH-FR-002`)* — **Given** two authorised consumers on different surfaces, **when** each
issues an equivalent query, **then** both are served by the same query port and the same matching implementation.

**`SRCH-AC-003`** *(`SRCH-FR-003`)* — **Given** an event from a context that is **not** `BC-01`, `BC-10` or
`BC-19`, **when** it reaches `BC-23`, **then** no index document is created from it.

**`SRCH-AC-004`** *(`SRCH-FR-004`)* — **Given** an index needing population, **when** `BC-23` populates it,
**then** every value originates from an `E-21` event and no domain table is read.

**`SRCH-AC-005`** *(`SRCH-FR-005`)* — **Given** any index document, **when** it is inspected, **then** it carries
the identifier of its owning aggregate and that identifier resolves against the owning context.

**`SRCH-AC-006`** *(`SRCH-FR-006`)* — **Given** the two index classes of §9, **when** their storage and query
paths are inspected, **then** they are separate and no single index serves both classes.

**`SRCH-AC-007`** *(`SRCH-FR-007`)* — **Given** a caller with **no** tenant context, **when** it queries a
tenant-operational index, **then** the query is rejected and no unscoped search is performed.

**`SRCH-AC-008`** *(`SRCH-FR-008`)* — **Given** the matching capability of §17–§22, **when** the codebase is
inspected, **then** exactly one implementation exists inside `BC-23` and none exists per consumer surface.

**`SRCH-AC-009`** *(`SRCH-FR-009`)* — **Given** two different consumers with the same authorisation, **when** each
issues the identical query against the same index state, **then** both receive the same matches in the same order.

**`SRCH-AC-010`** *(`SRCH-FR-010`)* — **Given** a `*Created`, `*Updated` or `*Deleted` event on `E-21`, **when**
it is processed, **then** the corresponding index document is created, updated or deleted respectively.

**`SRCH-AC-011`** *(`SRCH-FR-011`)* — **Given** a document present in more than one index, **when** a `*Deleted`
event for it is processed, **then** it is absent from **every** index.

**`SRCH-AC-012`** *(`SRCH-FR-012`)* — **Given** an indexed person, **when** `identity.PersonAnonymised` is
processed, **then** the subject's indexed personal fields are **removed**, not overwritten with masked values.

**`SRCH-AC-013`** *(`SRCH-FR-013`)* — **Given** an indexed person, **when**
`identity.PersonPrivacyModeChanged` is processed, **then** the change is applied with no propagation window and no
query served after it reflects the prior mode.

**`SRCH-AC-014`** *(`SRCH-FR-014`)* — **Given** a library present in the public discovery index, **when** a status
change removes its eligibility, **then** it is removed from the public discovery index.

**`SRCH-AC-015`** *(`SRCH-FR-015`)* — **Given** an index document, **when** its fields are enumerated, **then**
every field is declared-eligible under §13 and no other field is present.

**`SRCH-AC-016`** *(`SRCH-FR-016`)* — **Given** a source event omitting an eligible field, **when** the document
is projected, **then** the field is absent and no default, synthesised or inferred value appears.

**`SRCH-AC-017`** *(`SRCH-FR-017`)* — **Given** a field not declared indexable by its owning contract, **when**
indexing is attempted, **then** the field is not indexed.

**`SRCH-AC-018`** *(`SRCH-FR-018`)* — **Given** any eligible field, **when** its configuration is inspected,
**then** exactly one match role — text, exact or filter — is declared for it.

**`SRCH-AC-019`** *(`SRCH-FR-019`)* — **Given** the public discovery index, **when** its contents are enumerated,
**then** every field present is marked public by the owning contract.

**`SRCH-AC-020`** *(`SRCH-FR-020`)* — **Given** a field marked never-public, **when** any query is executed,
**then** the field is not indexed, matched, filtered, sorted or returned, and does not influence relevance.

**`SRCH-AC-021`** *(`SRCH-FR-021`)* — **Given** a query carrying an input other than text term, filters,
pagination cursor and tenant context, **when** it is processed, **then** the extra input does not influence
matching.

**`SRCH-AC-022`** *(`SRCH-FR-022`)* — **Given** a query naming a field whose match role does not admit text,
**when** it is processed, **then** that field does not participate in text matching.

**`SRCH-AC-023`** *(`SRCH-FR-023`)* — **Given** the normalization rule set, **when** it is applied at index time
and at query time, **then** the same rules produce the same normalized form in both cases.

**`SRCH-AC-024`** *(`SRCH-FR-024`)* — **Given** the queries `central library`, `Central   Library`, `St Marys`
and `Cafe`, **when** each is executed against *Central Library*, *Central Library*, *St. Mary's* and *Café*
respectively, **then** each matches at T1 under rules N1–N6.

**`SRCH-AC-025`** *(`SRCH-FR-025`)* — **Given** the ten queries of §17.2, **when** each is executed, **then** each
resolves to the tier that table states, and the T4 query returns no results.

**`SRCH-AC-026`** *(`SRCH-FR-026`)* — **Given** any populated result set, **when** each result is inspected,
**then** every result carries the tier at which it matched and none lacks one.

**`SRCH-AC-027`** *(`SRCH-FR-027`)* — **Given** a field whose declared match role is **exact**, **when** a query
token differing from the indexed value by one character is executed, **then** no T3 match is produced.

**`SRCH-AC-028`** *(`SRCH-FR-028`)* — **Given** a normalized query term equal to a normalized indexed value,
**when** the query is executed, **then** the document matches at T1 and is ordered above all T2 and T3 matches.

**`SRCH-AC-029`** *(`SRCH-FR-029`)* — **Given** the query `lib central` and an indexed *Central Library*, **when**
the query is executed, **then** the document matches at T2 irrespective of token order.

**`SRCH-AC-030`** *(`SRCH-FR-030`)* — **Given** the query token `Lib` and an indexed token `Library`, **when** the
query is executed against a **text**-role field, **then** the token matches by prefix; **and given** an
**exact**-role field, **then** no suffix or infix match is produced.

**`SRCH-AC-031`** *(`SRCH-FR-031`)* — **Given** the query `library` and an indexed *Libraries*, **when** the query
is executed, **then** the document matches at T3 by declared word-form equivalence class V1.

**`SRCH-AC-032`** *(`SRCH-FR-032`)* — **Given** that `library` matches *Libraries*, **when** `libraries` is
queried against an indexed *Library*, **then** it also matches — equivalence holds in both directions.

**`SRCH-AC-033`** *(`SRCH-FR-033`)* — **Given** the query `Centrl Library` and an indexed *Central Library*,
**when** the query is executed, **then** the document matches at T3 and the result set is not empty.

**`SRCH-AC-034`** *(`SRCH-FR-034`)* — **Given** an unchanged index state, query and authorisation, **when** the
query is executed repeatedly, **then** every execution returns the identical results in the identical order,
including for tied documents.

**`SRCH-AC-035`** *(`SRCH-FR-035`)* — **Given** documents matching at T1, T2 and T3 for one query, **when** the
result set is ordered, **then** all T1 precede all T2, which precede all T3, and no other factor crosses a tier
boundary.

**`SRCH-AC-036`** *(`SRCH-FR-036`)* — **Given** any result, **when** an explanation is requested, **then** the
tier, matched field and applied rule class are attributable, and no ordering rests on an unexplainable score.

**`SRCH-AC-037`** *(`SRCH-FR-037`)* — **Given** a result set and an additional filter, **when** the filter is
applied, **then** the result set is unchanged or smaller, and no T4 document is admitted.

**`SRCH-AC-038`** *(`SRCH-FR-038`)* — **Given** a filter naming an ineligible or never-public field, **when** the
query is submitted, **then** it is rejected as invalid and is **not** silently ignored.

**`SRCH-AC-039`** *(`SRCH-FR-039`)* — **Given** a caller requesting a page size above the port's cap, **when** the
query is executed, **then** the cap governs and the caller's value alone does not determine page size.

**`SRCH-AC-040`** *(`SRCH-FR-040`)* — **Given** a multi-page result set, **when** page *n* is requested, **then**
the same authorisation, tenant scope and field-eligibility checks applied to page 1 are applied again.

**`SRCH-AC-041`** *(`SRCH-FR-041`)* — **Given** a query no document satisfies at T1–T3, **when** it is executed,
**then** a successful empty result is returned, no token is dropped, no tier is widened and no T4 document appears.

**`SRCH-AC-042`** *(`SRCH-FR-042`)* — **Given** two queries — one matching nothing, one whose matches are removed
by authorisation, tenant scope or field eligibility — **when** both are executed, **then** their responses are
indistinguishable in shape, status, message and timing characteristics.

### 43.2 Business rules — `SRCH-AC-043` … `SRCH-AC-056`

**`SRCH-AC-043`** *(`SRCH-BR-001`)* — **Given** the platform's contexts, **when** index construction, relevance
and query rewriting are traced to an owner, **then** `BC-23` is the sole owner and no consumer implements any of
the three.

**`SRCH-AC-044`** *(`SRCH-BR-002`)* — ⭐ **Given** two documents matching one query at the **same** tier on the
**same** field, **when** they differ in rating, popularity, availability, completeness, recency or commercial
standing, **then** their relative order is unchanged by those differences.

**`SRCH-AC-045`** *(`SRCH-BR-003`)* — **Given** a consumer absent from the §6.2 enabled set, **when** the
capability is assessed, **then** its absence is attributable to a missing edge authority and not to a missing
capability.

**`SRCH-AC-046`** *(`SRCH-BR-004`)* — **Given** any tenant-operational index identity, **when** it is inspected,
**then** it includes the tenant key and the index is not addressable without one.

**`SRCH-AC-047`** *(`SRCH-BR-005`)* — **Given** a newly authorised consumer, **when** it is enabled, **then** it
is enabled by authorising its edge and no matching rule is re-specified for it.

**`SRCH-AC-048`** *(`SRCH-BR-006`)* — **Given** a library whose eligibility is ambiguous, **when** `BC-23`
processes its event, **then** `BC-23` indexes exactly what it is given and makes no eligibility determination.

**`SRCH-AC-049`** *(`SRCH-BR-007`)* — **Given** a field the owning contract publishes as **filter**, **when**
`BC-23`'s configuration is inspected, **then** the field has not been widened to a tolerant-text field.

**`SRCH-AC-050`** *(`SRCH-BR-008`)* — **Given** the normalization rule set, **when** each rule is checked for
symmetry, **then** every transformation applied to a query term is also applied to indexed terms, and no indexed
document is unreachable through its own indexed value.

**`SRCH-AC-051`** *(`SRCH-BR-009`)* — **Given** any tolerance rule in force, **when** it is evaluated against
relevance, determinism, explainability and authorisation/isolation, **then** all four properties still hold.

**`SRCH-AC-052`** *(`SRCH-BR-010`)* — ⭐ **Given** a three-token query and a document satisfying only one token,
**when** the query is executed, **then** the document is **not** returned.

**`SRCH-AC-053`** *(`SRCH-BR-011`)* — **Given** the word-form equivalence set, **when** its provenance is traced,
**then** every entry derives from a declared rule set or vocabulary and none from usage, clicks, co-occurrence or
a learned model.

**`SRCH-AC-054`** *(`SRCH-BR-012`)* — **Given** typo tolerance enabled, **when** constraints C1–C5 are tested,
**then** all five hold: no tolerance on exact-role fields; none below the declared minimum token length; a bounded
and uniform difference; no T3 match outranking a T1 or T2 match; and no widening of authorisation, tenant scope or
field eligibility.

**`SRCH-AC-055`** *(`SRCH-BR-013`)* — ⭐⭐ **Given** a query satisfying no tier for a document, **when** the query
is executed, **then** the document is absent from the result set entirely — not present at a low position, with a
low score, or labelled weak or suggested.

**`SRCH-AC-056`** *(`SRCH-BR-014`)* — **Given** the query port, **when** its accepted parameters are enumerated,
**then** relevance is the only ordering offered and no business sort parameter is accepted or implemented.

### 43.3 Invariants — `SRCH-AC-057` … `SRCH-AC-062`

**`SRCH-AC-057`** *(`SRCH-INV-001`)* — **Given** any indexed value, **when** its authority is traced, **then** it
is a projection of a fact owned by another context and `BC-23` is authoritative for nothing.

**`SRCH-AC-058`** *(`SRCH-INV-002`)* — **Given** any index document, **when** index membership is enumerated,
**then** it appears in exactly one index class and never in both.

**`SRCH-AC-059`** *(`SRCH-INV-003`)* — **Given** an index document disagreeing with its owning context, **when**
the disagreement is resolved, **then** the owning context's value governs and the index is treated as stale.

**`SRCH-AC-060`** *(`SRCH-INV-004`)* — ⭐⭐ **Given** the Platform Public Discovery Index, **when** its every field
is enumerated against §14A's public boundary, **then** no Tenant Operational Data value is present.

**`SRCH-AC-061`** *(`SRCH-INV-005`)* — ⭐ **Given** an index rebuilt from the event log alone, **when** it is
compared with the incrementally maintained index, **then** the two are equivalent for matching and ordering, and
the comparison is exercised on a recurring schedule rather than assumed.

**`SRCH-AC-062`** *(`SRCH-INV-006`)* — **Given** a field not declared eligible, **when** indexing, matching and
projection are exercised, **then** the field is absent from all three.

### 43.4 Exclusions — `SRCH-AC-063` … `SRCH-AC-078`

**`SRCH-AC-063`** *(`SRCH-XC-001`)* — ⭐ **Given** this document, **when** it is compared against `Library_PRD_v1.md`
§14A, **then** it defines, alters or restates no §14A field, eligibility rule or visibility rule.

**`SRCH-AC-064`** *(`SRCH-XC-002`)* — **Given** the repository, **when** library-discovery contracts are
enumerated, **then** §14A is the only one and this document is not a second.

**`SRCH-AC-065`** *(`SRCH-XC-003`)* — **Given** `BC-23`'s V1 behaviour, **when** relevance inputs are enumerated,
**then** no ML model, learned relevance or behavioural personalisation is present.

**`SRCH-AC-066`** *(`SRCH-XC-004`)* — **Given** `BC-23`'s V1 components, **when** they are enumerated, **then**
no vector database, semantic embedding or LLM retrieval path is present, and RAG retrieval remains `BC-27`'s
behind `E-26`.

**`SRCH-AC-067`** *(`SRCH-XC-005`)* — **Given** `BC-23` in operation, **when** its inputs are enumerated, **then**
no click-feedback or relevance-learning loop exists.

**`SRCH-AC-068`** *(`SRCH-XC-006`)* — **Given** `BC-23`'s V1 scope, **when** it is inspected, **then** no fraud
detection, bot detection, CAPTCHA or IP-reputation mechanism is defined by it.

**`SRCH-AC-069`** *(`SRCH-XC-007`)* — **Given** the V1 release, **when** enabled search surfaces are enumerated,
**then** no cross-entity or student search surface is enabled.

**`SRCH-AC-070`** *(`SRCH-XC-008`)* — **Given** `BC-23`'s stores, **when** they are inspected, **then** no
identity, profile, library-management, membership, seat, booking, fee or analytics data is held authoritatively.

**`SRCH-AC-071`** *(`SRCH-XC-009`)* — ⭐ **Given** the query port, **when** its parameters are enumerated,
**then** no ranking weight, boost or business-ordering parameter is exposed; **and when** a consumer applies its
own authorised ordering, **then** it does so after retrieval on the returned set.

**`SRCH-AC-072`** *(`SRCH-XC-010`)* — **Given** a consumer not in the §6.2 enabled set, **when** it calls the
query port, **then** it is not served.

**`SRCH-AC-073`** *(`SRCH-XC-011`)* — **Given** `BC-15`, **when** `BC-23`'s indexed sources are enumerated,
**then** `BC-15` is absent.

**`SRCH-AC-074`** *(`SRCH-XC-012`)* — **Given** an attempt to write, correct or backfill an index document by any
path other than `E-21`, **when** it is made, **then** it is refused.

**`SRCH-AC-075`** *(`SRCH-XC-013`)* — **Given** a field §14A.10 marks never-public — expressly including
*Internal Analytics* — **when** the indices are enumerated, **then** the field is absent.

**`SRCH-AC-076`** *(`SRCH-XC-014`)* — **Given** the matching capability, **when** its implementation is inspected,
**then** no consumer's field names, surface or product vocabulary is hardcoded, and fields enter matching only by
eligibility declaration.

**`SRCH-AC-077`** *(`SRCH-XC-015`)* — **Given** an index document, **when** its provenance is traced, **then** no
value was joined in from another context.

**`SRCH-AC-078`** *(`SRCH-XC-016`)* — ⭐⭐ **Given** a never-public value, **when** an adversary varies queries and
observes result presence, ordering, counts, timing, error text and pagination artefacts, **then** the value cannot
be inferred from any of them.

---

## 44. Traceability

⭐ **Every figure below was computed by script over this document, not asserted from memory.**

### 44.1 Register integrity

| Register | Declared (§0.4) | Measured unique | Highest | Contiguous from 001 | Verdict |
|---|---|---|---|---|---|
| `SRCH-FR-*` | 42 | **42** | `SRCH-FR-042` | ✅ no gaps | ✅ **PASS** |
| `SRCH-BR-*` | 14 | **14** | `SRCH-BR-014` | ✅ no gaps | ✅ **PASS** |
| `SRCH-INV-*` | 6 | **6** | `SRCH-INV-006` | ✅ no gaps | ✅ **PASS** |
| `SRCH-XC-*` | 16 | **16** | `SRCH-XC-016` | ✅ no gaps | ✅ **PASS** |
| `SRCH-AC-*` | 78 | **78** | `SRCH-AC-078` | ✅ no gaps | ✅ **PASS** |
| `SRCH-GAP-*` | 9 | **9** | `SRCH-GAP-009` | ✅ no gaps | ✅ **PASS** |

Malformed or undeclared pseudo-identifiers matching `SRCH-*-<word>`: **0**.

### 44.2 Forward traceability — obligation → acceptance criterion

| Metric | Value |
|---|---|
| Obligation-bearing identifiers (FR + BR + INV + XC) | **78** |
| Obligations with at least one acceptance criterion | **78** |
| Obligations with **no** acceptance criterion | ⭐ **0** |
| Coverage | ✅ **100%** |

### 44.3 Reverse traceability — acceptance criterion → obligation

| Metric | Value |
|---|---|
| Acceptance criteria | **78** |
| Criteria citing exactly one obligation explicitly | **78** |
| ⭐ **Orphan criteria** (citing no obligation) | ⭐ **0** |
| Duplicate targets (two criteria for one obligation) | **0** |
| Criteria in complete Given / When / Then form | ⭐ **78 of 78** |

⚠ **What this does NOT establish.** Per the authoring instruction — *"do not declare complete merely because every
AC exists"* — the tables above prove **structural** completeness only. ⛔ They do **not** establish that the
criteria are *satisfied* (no implementation exists), nor that they are *sufficient* (a Stage-4 requirements-review
judgement, and `PRD_LIFECYCLE.md` **§6** records that the Requirements-reviewer role is **unassigned** —
`PGA-08`). Three obligations additionally carry a **known residual dependency**: `SRCH-AC-054` (bounds are
`SRCH-GAP-002`), `SRCH-AC-035` (field precedence is `SRCH-GAP-009`), and every tenant-operational criterion
(mechanism is `SRCH-GAP-003`).

### 44.4 Architecture invariants — before and after this document

| Invariant | Before | After | Δ |
|---|---|---|---|
| Bounded contexts | **31** | **31** | ⭐ **0** |
| Authorised context edges | **29** — `E-01`…`E-26`, `E-28`, `E-29`, `E-30`; ⛔ `E-27` permanently vacant (BC Map **L874**) | **29** | ⭐ **0** |
| ADR files | **86** | **86** | ⭐ **0** |
| New events defined | — | **0** | ⭐ **0** |
| Frozen documents modified | — | **0** | ⭐ **0** |
| `IMPL-*` identifiers allocated | **0** | **0** | ⭐ **0** |
| Application/test code files changed | — | **0** | ⭐ **0** |
| `PRD_REGISTRY.md` rows changed | — | **0** | ⭐ **0** (`SRCH-GAP-001`) |
| `DOCUMENTATION_BASELINE.md` rows changed | — | **0** | ⭐ **0** |

### 44.5 Outbound citations — what this PRD depends on

| Authority | Rank | Used for |
|---|---|---|
| `MASTER_PRD.md` **L171**, **L192** | 1 | `BC-23` exists, is V1, is permission-aware and tenant-partitioned |
| `ADR-0093` | 2 | `BC-19` added as an `E-21` source |
| ⭐ **`ADR-0094`** | 2 | §14A **is** the V1 discovery contract; §3 option-B rejection; §2 rule 4 carve-out; §2.1 index-class determination |
| `ADR-0098` **L221** | 2 | Routes `XPC-OD-009` to `PRD-015` |
| `Library_PRD_v1.md` **§14A** (FROZEN) | 3 | Field eligibility, public boundary, the single distance ordering — **cited, never restated** |
| `PRD-021C` C2 `LSD-FR-008`, `LSD-XC-002` | 3 | The query-port mandate; the no-second-ranking prohibition |
| `PRD-021C` C0 **L427**, C6 **L78**, **L359** | 3 | `XPC-OD-009`/`010`; "nobody owns a composite ranking"; `LIB-14B.42` |
| BC Map **L132**, **L330**, **L335**, **L427-428**, **L453**, **L753** | 4 | The grant; `E-21`; `E-26`; privacy events; replay; `AO-9` refusal |
| `ARCHITECTURE_RULINGS.md` **`AR-1`**, **`AR-3`** | 4 | Discovery is a composition; the two index classes |
| `PRD_LIFECYCLE.md` §5, §6 | — | Identifier rules; role assignment (`PGA-08`) |
| `PRD_REGISTRY.md` **L315**, **L726-727** | — | Current `PLANNED` status; the conferral rule |

### 44.6 Inbound satisfaction — what this PRD unblocks

| Dependency | Prior state | State after this draft |
|---|---|---|
| `D-10` — `PRD-003`, `PRD-004` → `PRD-015` (`BC-23`, EVENT, `E-21`) | ⛔ *"Unsatisfied"* (`PRD_DEPENDENCY_GRAPH.md` **L112**) | ⚠ **Addressable** — a target document now exists; ⛔ **not** satisfied until status is conferred (`SRCH-GAP-001`) |
| `D-15` — `PRD-011` → `PRD-009`, `PRD-015` | ⛔ *"Both unwritten"* (**L117**) | ⚠ **Half addressed** — `PRD-009` remains unwritten |
| `LSD-FR-008` — C2's refusal awaiting `BC-23`'s owner | ⛔ Nothing to satisfy it | ✅ **Answered by §37** (subject to conferral) |
| `XPC-OD-009` — *"record it against `PRD-015` when authored"* | ⛔ No `PRD-015` to record against | ✅ **Discharged as `SRCH-GAP-004`** |
| `ADR-0098` **L276** — *"`PRD-015` still does not exist"* | ⛔ True | ⚠ **A draft now exists on disk**; the register is unchanged |
| `DOCUMENTATION_BASELINE.md` **L356** — `XPC-OD-009` *"routed to `PRD-015`"*, admitted **OPEN** | ⛔ Nowhere to route to | ⚠ **Recorded as `SRCH-GAP-004`**; ⛔ the baseline row is **not edited** — it remains OPEN, as `ADR-0098` §6 admitted it |

⛔ **This document does not update `PRD_DEPENDENCY_GRAPH.md`, `TRACEABILITY_MATRIX.md` or `PRD_REGISTRY.md`.**
Those are Governance-Owner acts on append-only, line-cited files, and performing them here would claim a
conferral this document does not hold.

---

## 45. Implementation checklist

⚠⚠ **This is a Stage-2 readiness checklist, NOT an implementation plan.** ⛔ No `IMPL-*` identifier is allocated,
no task is assigned, no estimate is given, and no item below may be read as authorising work to begin.
`PRD_LIFECYCLE.md` requires Stages 3, 4 and 5 to be **conferred** first, and every one of them is unreached.

### 45.1 Gates that must be passed before implementation

| # | Gate | State | Blocker |
|---|---|---|---|
| 1 | `PRD-015` status conferred `PLANNED` → `DRAFT` | ⛔ **NOT DONE** | `SRCH-GAP-001` — **Governance Owner** |
| 2 | Stage 3 architecture review | ⛔ **NOT REACHED** | Reviewer role unassigned (`PGA-08`) |
| 3 | Stage 4 requirements review | ⛔ **NOT REACHED** | Reviewer role unassigned (`PGA-08`) |
| 4 | Stage 5 traceability conferral | ⛔ **NOT REACHED** | Traceability-owner role unassigned |
| 5 | `SRCH-GAP-002` P1–P8 decided | ⛔ **OPEN** | **Architecture Owner** |
| 6 | `SRCH-GAP-003` entitlement mechanism decided | ⛔ **OPEN** | **Architecture Owner** |
| 7 | `SRCH-GAP-007` language/vocabulary inventory declared | ⛔ **OPEN** | **Product Owner** + Architecture Owner |
| 8 | `SRCH-GAP-009` §14A field precedence declared | ⛔ **OPEN** | **Product Owner** |

### 45.2 Build order implied by the requirements (informative)

⚠ Informative sequencing only — it confers nothing and starts nothing.

1. `E-21` event consumption and projection (`SRCH-FR-004`, `010`–`014`) with replay (`SRCH-INV-005`).
2. The two index classes as **separate** stores (`SRCH-FR-006`, `SRCH-INV-002`, `SRCH-INV-004`).
3. Field eligibility and match roles (`SRCH-FR-017`, `018`; `SRCH-INV-006`).
4. Normalization, symmetric at index and query time (`SRCH-FR-023`, `024`; `SRCH-BR-008`).
5. The tier ladder T1 → T2 → T3, with T4 exclusion (`SRCH-FR-025`–`033`; `SRCH-BR-010`, `013`).
6. Deterministic, explainable relevance ordering (`SRCH-FR-034`–`036`).
7. The query port: request shape, pagination, error taxonomy (§37; `SRCH-FR-021`, `039`, `040`, `041`, `042`).
8. Authorisation, tenant scoping and inference resistance (§27, §28, §30) — ⛔ gated on `SRCH-GAP-003`.

### 45.3 Definition of "done" for **this document** (Stage 2 only)

| Criterion | State |
|---|---|
| Version/status header present | ✅ |
| Registers declared up front with ranges | ✅ §0.4 |
| Prefix collision-checked **before** writing | ✅ `SRCH-` = 0; `IDX-` refused |
| Ranges contiguous, identifiers unique | ✅ measured §44.1 |
| Normative language defined | ✅ §0.1 |
| Every **MUST** carries an acceptance criterion | ✅ 78/78 |
| Every criterion in Given/When/Then form | ✅ 78/78 |
| Forward **and** reverse traceability | ✅ 0 orphans, 0 duplicates |
| Undecided questions recorded with owners | ✅ 9 gaps |
| ⛔ No frozen document modified | ✅ 0 |
| ⛔ No stage beyond 2 claimed | ✅ |

---

## 46. Change history

| Version | Date | Change | Authority |
|---|---|---|---|
| v0.1 | 2026-09-03 | Initial Stage-2 draft. Authored strictly inside the `ADR-0094` §2 rule 4 carve-out; discharges `LSD-FR-008` (§37) and records `XPC-OD-009` as `SRCH-GAP-004` (§31, §42). ⛔ No §14A text restated; no registry or baseline row changed; no stage beyond 2 claimed | `ADR-0094` §2 rule 4; `LSD-FR-008`; `ADR-0098` **L221** |

---

**END OF `PRD-015` v0.1 — DRAFT.**
⛔ **Status not conferred. Not reviewed. Not frozen. Not baselined. No rank held.**
Nine gaps are open and owned (§42). Freeze is conferred, not claimed.
