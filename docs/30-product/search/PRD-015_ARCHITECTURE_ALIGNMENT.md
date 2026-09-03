# `PRD-015` Search Indexing v0.1 — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **L88–L106**) |
| **Subject** | [`PRD-015_SEARCH_INDEXING.md`](PRD-015_SEARCH_INDEXING.md) — `PRD-015`, **`BC-23` Search Indexing** `[GENERIC]`, **v0.1 `DRAFT`** |
| **Version** | v0.1 |
| **Reviewer role** | **Architecture reviewer** — *"Stage 3; authority to require an ADR"* (`PRD_LIFECYCLE.md` **L277**). ⚠ **The role is UNASSIGNED** — **L283**: *"Every PRD needs a named owner. None has one"* (`PGA-08`). See §2 |
| **Gate addressed by** | This document — *"a written alignment record naming every conflict and its disposition"* (`PRD_LIFECYCLE.md` **L101–L102**) |
| **Worked examples followed** | [`LIBRARY_PRD_ALIGNMENT.md`](../library/LIBRARY_PRD_ALIGNMENT.md) · [`STUDENT_IDENTITY_ALIGNMENT.md`](../student-identity/STUDENT_IDENTITY_ALIGNMENT.md) — the two the gate names — plus [`PRD-008_ARCHITECTURE_ALIGNMENT.md`](../revenue-finance/PRD-008_ARCHITECTURE_ALIGNMENT.md) and [`PRD-021C_C0_C8_STAGE3_ARCHITECTURE_ALIGNMENT.md`](../library-marketplace/PRD-021C_C0_C8_STAGE3_ARCHITECTURE_ALIGNMENT.md) for format |
| **Base commit reviewed** | `0611b1c93d1eb61e1d9a9e0caed68410bb890d70` |
| **PRD hash at review** | `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` — measured at **v0.1, 1,426 lines, 93,802 characters, 95,608 bytes**. *(Python byte-level `sha256` and `len()`; `wc -m` reports **bytes** under this locale and must not be used for a character count — the instrument note the `PRD-008` records carry.)* |
| **Date** | 2026-09-03 |
| **Status of this record** | **Unranked.** A review record is a validation artefact, not a specification. It claims no authority and confers no status |
| **Verdict (measured)** | ⚠ **CONDITIONAL PASS — 6 of 6 Stage-3 checks PASS as measured; Stage 3 is NOT COMPLETE.** The subject's **own** §42 declares `SRCH-GAP-002`, `SRCH-GAP-003` and `SRCH-GAP-007` as **blocking Stage 3**, and all three are **Architecture-Owner / Product-Owner decisions this review has no authority to take.** See §11 |
| **Formal conferral** | ⛔ **NOT CONFERRED.** A **measured** pass is not a **conferred** pass. See §2 and §11.2 |
| **Mandate** | **Stage 3 measurement only.** ⛔ No PRD requirement added, removed or reworded · no ranked document touched · no ADR created or accepted · no edge, event or bounded context created · no registry or baseline update · **no freeze, no baseline, no rank, no approval** · no checker altered · **0** `IMPL-*` identifiers · **0** application-code files |
| **Stage 4 / 5** | ⛔ **NOT ENTERED** |

> ⛔ **This is not Stage 4.** This record performs the Stage-3 act only. Stage 4 is a *requirements* review
> against a different gate (`PRD_LIFECYCLE.md` **L108** onward) by a separate authority.
>
> ⛔ **A measured PASS is not an APPROVAL, a FREEZE, a BASELINE or a RANK.** Those are four further facts,
> none claimed anywhere in this document. `PRD-015` remains **`PLANNED`** in `PRD_REGISTRY.md` **L315**.
>
> ⛔ **This record decides nothing that belongs to an owner.** Where `PRD-015` left a question open, it
> **stays open here.** An alignment record must not close by review what no owner has closed by decision.

---

## 1. Method

Every finding cites a document **on disk in this repository**, by path and line, re-read at its source at
`0611b1c`. Nothing is asserted from memory. Where the subject conflicts with a higher-precedence document,
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §4 decides which document is
*wrong* — never which to ignore: *"A conflict is a defect. If you find one, do not choose — raise it."*
That rule is applied literally in §9, where **two Rank-3 baselines place obligations on `BC-23` that the
subject does not carry**, and this record raises them rather than resolving them.

### 1.1 Sources validated against

| # | Source | Path | Rank |
|---|---|---|---|
| 1 | Master PRD global rules — `MP-GBR-08` **L339**, `MP-RSK-01` **L551** | `docs/30-product/MASTER_PRD.md` | **1** |
| 2 | `Accepted` ADRs — `ADR-0011`, `ADR-0033`, `ADR-0083`, `ADR-0086`, `ADR-0091`, `ADR-0093`, **`ADR-0094`**, `ADR-0096`, `ADR-0098` | `docs/00-governance/adr/` | **2** |
| 3 | **Library PRD §14A — FROZEN** | `docs/30-product/library/14A-Library-Discovery-And-Enrollment.md` | **3** |
| 4 | **Student Identity PRD v1.0 §4.9** — `SID-4.38`…`SID-4.41` | `docs/30-product/student-identity/Student_Identity_PRD_v1.md` | **3** |
| 5 | **Trust & Safety PRD v0.1 §8.3** — `TSF-FR-023`, `TSF-INV-005` | `docs/30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md` | **3** |
| 6 | `PRD-021C` C0 / C2 / C6 — **FROZEN** | `docs/30-product/library-marketplace/` | **3** |
| 7 | `PRD-021B` B3 / B4 — baselined by `ADR-0092` | `docs/30-product/social-graph/` | **3** |
| 8 | Bounded Context Map — §3 **L90–L154**, §4.1 **L176–L182**, §7 **L290–L336**, §11 **L482–L512** | `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** |
| 9 | Module Dependency Matrix — `L2` **L49**, §3 ranks, `X-13` **L362** | `docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **4** |
| 10 | Architecture Rulings — `AR-1` **L23**, **`AR-3` L95–L120**, `AR-7` **L254** | `docs/10-architecture/ARCHITECTURE_RULINGS.md` | **4** |
| 11 | PRD register **L315**, **L726–L727**; lifecycle §5, §6, §7 | `docs/00-governance/prd-ecosystem/` | **5** |

### 1.2 Classification scheme

| Class | Meaning |
|---|---|
| ✅ **PASS** | Measured compliant against the named authority |
| ⚠ **CONDITIONAL** | Compliant as written, but compliance depends on a decision nobody has taken |
| ⛔ **BLOCKED** | A required authority is absent, so the check cannot be answered |
| ❌ **FAIL** | Measured non-compliant |
| ⚠ **RAISED** | A conflict in a ranked document, disclosed and **not** resolved here |

---

## 2. ⭐⭐ The conferral question, answered before the verdict

`PRD_LIFECYCLE.md` **L277** assigns Stage 3 to the **Architecture reviewer**. **L283** states, verbatim:

> **Every PRD needs a named owner. None has one** — `PRD_GAP_ANALYSIS.md` `PGA-08`.

**Consequence, stated plainly and applied throughout:** no acting role in this repository holds conferred
authority to *confer* Stage 3 on `PRD-015`. Therefore this record **measures** alignment and **does not
confer** it. The distinction is not decorative — the freshness gate states it independently:

> *"It does not confer Stage 3 or Stage 4… a supplement makes a record **fresh**, never **conferred**.
> Freshness and conferral are different facts."*
> — `tool/docs_check/alignment_record_freshness.py`

⛔ **This record therefore never uses the word CONFERRED of its own verdict**, and any later reader who
needs Stage 3 *conferred* must obtain it from a named Architecture reviewer, not from these measurements.

### 2.1 Why this record is nevertheless lawful to write

The Stage-3 **gate itself is a written alignment record** (`PRD_LIFECYCLE.md` **L101–L102**), and two
worked examples are named. Producing the gate artefact is the reviewing act; conferral is a separate role
act. Instruction §17's condition — *"if and only if repository governance permits a Stage 3 alignment
record at this point"* — is therefore **satisfied**.

### 2.2 ⛔ What this record deliberately does NOT do to the checker

`tool/docs_check/alignment_record_freshness.py` holds a hardcoded `RECORDS` list containing **only**
`PRD-008` and `PRD-019`. **`PRD-015` is absent, and this record does NOT add it.** Registering a new
record in the gate that checks records would be **altering a checker to make a gate green** — the exact
defect that file's own docstring names: *"A green gate signed by the author of the thing being gated is
not a gate."* The `PRD hash at review` row above is nevertheless present and carries a real 64-hex
`sha256`, because the *discipline* applies whether or not the *checker* is watching — and because
`PRD-019_ARCHITECTURE_ALIGNMENT.md` currently **FAILS** that gate for precisely the missing anchor
(§10.2).

---

## 3. Check 1 — Context ownership is exclusive ✅ **PASS**

**Authority:** BC Map **§3** (Context Register, **L90–L154**). **Failure mode:** *two PRDs own one aggregate.*

### 3.1 The claim, and its uniqueness

BC Map **L132**, verbatim:

> `| **BC-23** | **Search Indexing** | [GENERIC] | Search | V1 | Owns indices, permission-aware indexing, tenant index isolation, relevance, query rewriting. |`

`PRD-015` §5.1 quotes this row **verbatim** and enumerates exactly **five** owned subjects. Measured
against the register:

| Test | Measurement | Result |
|---|---|---|
| PRDs claiming `BC-23` in `PRD_REGISTRY.md` | **exactly 1** — `PRD-015` at **L315** (field-parsed on the context column, not substring-matched) | ✅ No contest |
| Subjects `PRD-015` claims | 5 — and all 5 appear in **L132** | ✅ No extension |
| Subjects `PRD-015` claims **beyond** L132 | **0** | ✅ |
| Aggregates `PRD-015` claims to own | **0** — `SRCH-INV-001`: *"`BC-23` holds **no** source of truth"* | ✅ Cannot contest an aggregate it disclaims |

### 3.2 The eleven adjacent ownerships, each honoured

`PRD-015` §5.2 tabulates eleven subjects it does **not** own, each with the BC Map line that grants it
elsewhere: `BC-19` the tenant record (**L128**), `BC-01` enrollment, `BC-10` identity, `BC-26` analytics,
`BC-27` RAG, `BC-24` audit, `BC-25` configuration, `BC-29` files, `BC-30` sync, `BC-31` outbound,
`BC-13` moderation. Every line citation resolves. ⭐ **This is a positive finding**: the exclusivity is
asserted with the *other* owner named, which is what makes it falsifiable.

### 3.3 ⭐⭐ The ranking boundary — the one place exclusivity was genuinely at risk

The instruction's Check 1 requires that `BC-23` not become the owner of *business/marketplace ranking*.
Three ranked documents already fix this, and the subject complies with all three:

| Authority | Statement | `PRD-015`'s position |
|---|---|---|
| `PRD-021C` C6 **L78** (FROZEN) | *"⛔⛔ **Nobody owns a composite ranking, and none exists to own**"* | §5.3 layer table renders composite ranking as *"⛔ **Nobody. Does not exist**"* |
| `PRD-021C` C2 `LSD-XC-002` **L315** (FROZEN) | *"⛔ **MUST NOT** create a second ranking or relevance system"* | §22.4 keeps `BC-23` at relevance only; C6 *"does not acquire a second ranking engine from this document"* |
| `PRD-021B` B4 `DRK-XC-005` | *"⛔ B4 **MUST NOT** perform indexing, query rewriting, tokenisation, stemming, synonym expansion or text scoring. Owner: `BC-23`"* | Reciprocal and consistent — B4 disclaims what `PRD-015` claims, and `PRD-015` disclaims B4's post-retrieval ordering (`SRCH-BR-014`, `SRCH-XC-009`) |

⭐ **The two documents disclaim each other in opposite directions and neither leaves a hole.** B4 owns a
post-retrieval ordering layer; `BC-23` owns text relevance. `SRCH-BR-002` positively forbids `BC-23`
considering rating, popularity, availability, completeness, recency, commercial standing, viewer identity
or any behavioural signal — which is exactly the material B4's layer works on.

### 3.4 The nine reserved domains, tested individually

| Domain the instruction protects | Owner | Claimed by `PRD-015`? |
|---|---|---|
| Business / marketplace ranking | ⛔ nobody (C6 **L78**) | **No** — `SRCH-BR-002`, `SRCH-XC-009` |
| Recommendation | `PRD-021B` B5 | **No** — `SRCH-XC-005` forbids feedback loops |
| Analytics | `BC-26` (**L135**) | **No** — §5.2 row 4 |
| Authorization | `BC-18` (**L130**) | **No** — §27 consumes, never decides. ⚠ see §6.2 |
| Identity | `BC-10` (**L124**) | **No** — §5.2 row 3 |
| Tenant ownership | `BC-19` (**L128**) | **No** — §5.2 row 1; `SRCH-BR-006` |
| Audit | `BC-24` (**L133**) | **No** — §5.2 row 6 |
| Content | `BC-14` | **No** — not referenced |
| Messaging | `BC-12` | **No** — not referenced |
| Trust & safety | `BC-13` (**L117**) | **No** — §5.2 row 11 |

### 3.5 Result — ✅ **PASS**

Exactly one PRD claims `BC-23`; it claims exactly the five granted subjects; it owns **no aggregate**; and
the one boundary that was genuinely contestable — relevance versus business ranking — is separated in a
direction all three ranked authorities already require.

---

## 4. Check 2 — Every integration edge exists in BC Map §7 ✅ **PASS**

**Authority:** BC Map **§7 L292**: *"Every edge that crosses a context boundary in V1. If an edge is not in
this table, it **does not exist** and adding it requires an ADR."*

### 4.1 Census — every `E-nn` token in the subject, tested

| Token | Occurrences | In BC Map §7? | Use in `PRD-015` |
|---|---|---|---|
| **`E-21`** | 24 | ✅ **L330** — `BC-01, BC-10, BC-19 → BC-23`, `PL` + Event | The **only** inbound edge claimed (§38) |
| **`E-26`** | 9 | ✅ **L335** — `BC-27 AI → BC-26, BC-23`, `CF` Sync port | The AI consumer port, cited not extended |
| `E-18` | 2 | ✅ **L316** — all contexts → `BC-19`, ambient `TenantContext` | Cited as `AR-3`'s caller-context requirement |
| `E-22` | 1 | ✅ **L331** | Cited in §5.2 to attribute files to `BC-29` |
| `E-01` | 1 | ✅ **L298** | Inside the §44.4 edge-set enumeration only |
| `E-28`, `E-29`, `E-30` | 1 each | ✅ §15.1, §17 (`ADR-0083`, `ADR-0096`) | Inside the §44.4 enumeration only |
| **`E-27`** | 1 | ⚠ **Absent — correctly so** | See §4.2 |

**Edges created by `PRD-015`: 0.** **Events minted: 0.** **Bounded contexts created: 0.** §38 states this
positively: *"⛔ **No new bounded context. No new edge. No new event.**"*

### 4.2 ⚠ The one apparent violation, resolved by reading rather than counting

A naive census flags `E-27` as *"referenced but not authorised"*. **The flag is a false positive.** The
single occurrence, at §44.4, asserts the edge's **non-existence**:

> `| Authorised context edges | **29** — E-01…E-26, E-28, E-29, E-30; ⛔ E-27 permanently vacant (BC Map **L874**) | 29 | ⭐ 0 |`

BC Map **L870–L875** confirms the notation exactly: *"the edge set becomes **`E-01`…`E-26`, `E-28`, `E-29`,
`E-30`** — **29 edges, with `E-27` a deliberate gap that records a withdrawal**. A reader who finds no
`E-27` has found the correct state."* The subject's citation is **L874**, which is inside that block.
⭐ **A reference to a thing's absence is not a use of that thing** — the identical disposition the
`PRD-021C` Stage-3 record reached at its §5.1 for 21 such mentions.

### 4.3 ⭐⭐ The query direction — the sharpest question in this check, and why it is not a defect

**The observation.** `E-21` is the **write** direction: sources publish events *into* `BC-23`. `E-26` covers
`BC-27 AI` *querying* `BC-23`. But the V1 enabled consumers in §6.2 — `PRD-021C` C2, C6 and the §14A
discovery surface — **query** `BC-23`, and **no numbered edge names them as consumers of `BC-23`.**
Measured: §7 rows mentioning `BC-23` are exactly **three** (`E-21`, `E-26`, and `E-22` where `BC-23` is
recorded as *excluded*). C2 is not among them.

**Why this is lawful, on established repository authority and not on a special plea.**

1. **`AR-1` (Rank 4) rules Library Discovery is not a context at all.** `ARCHITECTURE_RULINGS.md` **L23**
   and BC Map **L86**: it *"owns no aggregate, no invariant and no business state"* and — decisively —
   *"It composes `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02` and `BC-04` **through `BC-23`**."*
   ⭐ **The composition-through-`BC-23`** is stated by the ruling itself. A read composition that is *not a
   context* cannot cross a *context* boundary, so §7 — which governs edges *between contexts* — does not
   reach it.
2. **`Accepted` `ADR-0033` §3 already rejected the contrary reading**, verbatim: *"It governs **edges**. It
   does **not** state that every cross-context read must be an edge."*
3. **The `PRD-008` Stage-3 record tested this as a general rule and it held** (§3.4): of 17 declared ports,
   **14** have no numbered edge, including `identity.policy_decision` — the authorisation port Check 4 of
   this very gate requires every context to call. *"A reading that invalidates the gate's own prerequisite
   is the wrong reading."*
4. **The subject does not rely on ambiguity.** `SRCH-FR-001` requires retrieval *"only through a query
   port"*, and `SRCH-FR-002` makes that port the single entry point — the same `CF`-port pattern `E-26`
   documents. Nothing reads an index directly.

**Disposition:** ✅ no defect, and **no edge is invented**. This is recorded as accepted finding
`SRCHAL-A2` so that a later reader does not "fix" it by minting one.

### 4.4 Second search system — measured, none exists

| Candidate | Measurement | Result |
|---|---|---|
| `PRD-021C` C2 | `LSD-FR-008` **refuses** to author the port contract; `LSD-XC-002` forbids a second relevance system | ✅ Consumes only |
| `PRD-021C` C6 | C6 **L78** disclaims composite ranking; applies §14A **L114** distance sort **after** retrieval | ✅ Post-retrieval only |
| `PRD-021B` B3 | `SDS-IDX-007` *"⛔ B3 **MUST NOT** build a second index"*; `SDS-IDX-008` must not write to it | ✅ Consumes only |
| `PRD-021B` B4 | `DRK-XC-005` forbids indexing, rewriting, tokenisation, stemming, synonyms, text scoring | ✅ Ordering layer only |
| `PRD-021A` community search | ⛔ **`AO-9` refused it.** BC Map **L753**: *"NOT AUTHORISED… `BC-15` is NOT a consumer"* | ✅ `PRD-015` §6.2 marks it ⛔ **NO** |
| `PRD-015` itself | Authors the capability once, in `BC-23` (`SRCH-FR-008`), and forbids per-surface implementation | ✅ One authority |

⭐ **`PRD-015`'s arrival *reduces* the duplication risk rather than raising it.** Before it, `LSD-FR-008`'s
demand was unanswerable, and — in the subject's own §1 — *"the first consumer to answer would become a de
facto second search authority, which `LSD-XC-002` forbids."*

### 4.5 Result — ✅ **PASS**

All eight distinct authorised edge tokens resolve to §7. The ninth (`E-27`) is cited only to assert its
vacancy. **0 edges created, 0 events minted, 0 contexts added.** The missing consumer-direction edge is
lawful on `AR-1`, `ADR-0033` §3 and the `PRD-008` §3.4 general measurement, and **no edge was invented to
close it**.

---

## 5. Check 3 — Rank direction is downward ✅ **PASS**

**Authority:** `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **`L2` (L49)**: *"A module may depend only on modules
of **strictly lower rank**. Same-rank dependencies are forbidden except within a declared cluster."*
**Failure mode:** *illegal import.*

### 5.1 The ranks, read from §3 rather than assumed

| Party | Rank | Source |
|---|---|---|
| `liboora_contracts` | **R0** | §3 |
| `BC-19` Tenancy · `BC-18` Identity & Access | **R4** — SHARED CORE · IDENTITY & ACCESS | §3 |
| ⭐ **`BC-23` Search** | **R5** — *"AUDIT · **SEARCH** · COMMUNICATION · INTEGRATION"* | §3 |
| `BC-21` Entitlement · `BC-27` AI | **R6** | §3 |
| `BC-26` Analytics | **R7** | §3 |
| `BC-10` Global Person Identity | **R7.5** | §3, `ADR-0011` |
| `BC-01` Enrollment (Library Management) | **R8** | §3 |
| API / BFF — the §14A discovery surface's shell | **R9** | §3 |

### 5.2 Every dependency direction the subject asserts

| Dependency | Direction by rank | Lawful under `L2`? |
|---|---|---|
| `PRD-021C` C2 / C6 read compositions → `BC-23` | R8/R9 → **R5**, downward | ✅ |
| §14A public discovery surface → `BC-23` | R9 → **R5**, downward | ✅ |
| `BC-27` AI → `BC-23` via `E-26` | R6 → **R5**, downward | ✅ |
| `BC-01` Enrollment → `BC-23` (`E-21` source) | R8 → **R5**, downward | ✅ |
| `BC-10` Identity → `BC-23` (`E-21` source) | R7.5 → **R5**, downward | ✅ |
| `BC-23` → `liboora_contracts` (event schemas) | R5 → **R0**, downward | ✅ |
| `BC-23` → any domain table | ⛔ **does not exist** — `SRCH-FR-004`, `SRCH-XC-012`; BC Map **L330** *"Search never reads domain tables"* | ✅ The forbidden direction is positively excluded |

### 5.3 ⭐ The one direction that needed care — `BC-19` → `BC-23`

`E-21`'s source list includes **`BC-19` (R4)** publishing to **`BC-23` (R5)**. Read as an *import*, that is
R4 depending on R5 — **upward**, and unlawful. It is not an import, and three facts establish that:

1. **The pattern cell says `PL` + Event** (BC Map **L330**), not `CF` sync port. Under §7.4 rule **`F-2`**,
   capability contexts *"learn about the domain **exclusively** through Published Language events defined in
   `liboora_contracts`"* — the **R0** shared kernel.
2. **The dependency therefore runs `BC-23` (R5) → `liboora_contracts` (R0)**, which is downward. The
   publisher depends on nothing it publishes to; the subscriber depends on the schema.
3. **The subject enforces exactly this**: `SRCH-FR-004` — *"`BC-23` **MUST** populate every index from
   events on `E-21` only. ⛔ It **MUST NOT** read a domain table."*

⭐ Had the subject specified a *sync read* from `BC-19`, this check would **FAIL**. It specifies an event
subscription, which is the whole reason `L2` survives event-fed capabilities. Recorded as `SRCHAL-A3`.

### 5.4 Roadmap and dependency-graph consistency

| Record | States | Consistent with the subject? |
|---|---|---|
| `PRODUCT_IMPLEMENTATION_ROADMAP.md` **Wave 3.1** | `PRD-015` · `BC-23` · *"`E-21`. Needs `BC-01` and `BC-10` field sets to index"* | ✅ And ⭐ the subject **discloses** that those field sets have no V1 consumer — `SRCH-GAP-006` |
| `PRD_DEPENDENCY_GRAPH.md` **L112** `D-10` | `PRD-003`, `PRD-004` → `PRD-015`, EVENT, `E-21` — *"Unsatisfied"* | ✅ Direction is consumer → `PRD-015`, never reverse |
| `PRD_DEPENDENCY_GRAPH.md` **L117** `D-15` | `PRD-011` → `PRD-009`, `PRD-015` | ✅ Same direction |

⛔ **No rank value is invented, no document is re-ranked, and no roadmap wave is changed by this record.**
`PRD-015` holds **no** rank — `DOCUMENTATION_BASELINE.md` §3's 92 rank rows contain **no** `PRD-015` row,
and the subject's header says so: *"Precedence rank if admitted | Rank 3 — ⛔ **not held today**"*.

### 5.5 Circularity

**No cycle exists.** Every asserted dependency points at a strictly lower rank, and the one edge that could
close a loop — `BC-23` reading back into a domain — is forbidden twice over (BC Map **L330**;
`SRCH-XC-012`). Consumers depend on `BC-23`; `BC-23` depends on **R0** contracts and on nothing above it.

### 5.6 Result — ✅ **PASS**

---

## 6. Check 4 — No authorisation decided outside `BC-18` ✅ **PASS** *(with a recorded constraint)*

**Authority:** `X-13`. **Failure mode, in the gate's own words:** ***"A security defect that passes its own
tests."*** `BC-18` grant, BC Map **L130**: *"Owns credentials, sessions, devices, OTP, roles, permissions,
**policy decisions**, consent."*

### 6.1 Decisions are consumed, never invented

| Test | Measurement |
|---|---|
| Authorisation rules `PRD-015` **defines** | **0** |
| Roles, scopes or permission names `PRD-015` **invents** | **0** |
| Policy-decision APIs `PRD-015` **specifies** | **0** — §37.3: *"⛔ No wire format, protocol, endpoint path…"* |
| Positive refusal present? | ✅ §27: *"the platform's authorisation model itself — roles, scopes, capability contexts, the `E-18` caller-context contract — is **not** `BC-23`'s to define, and no requirement above redefines it. `BC-23` **consumes** the source system's decision."* |

The governing rule is restated by the subject in the strongest available form:

> ⭐⭐⭐ **"Being indexed does NOT make data searchable by everyone. Search results MUST NEVER bypass
> source-system authorization."** — `PRD-015` §27

and is carried by eight already-registered requirements (`SRCH-FR-001`, `007`, `012`, `013`, `020`, `040`,
`042`, `SRCH-INV-002`, `SRCH-INV-004`, `SRCH-XC-016`) rather than by prose alone.

### 6.2 ⚠ The finding this check produced — an under-citation, not a violation

**Measured: `PRD-015` contains ZERO occurrences of `BC-18`.** §27 attributes the visibility decision to
*"the **source system's** authorisation, at query time"*. `BC-18` — which BC Map **L130** grants *"policy
decisions"* — is never named.

**Why this is not a Check-4 failure.** The check forbids authorisation being **decided** outside `BC-18`.
`PRD-015` decides none: it routes the entire mechanism to **`SRCH-GAP-003`**, owner **Architecture Owner**,
and states *"⛔ It is not invented here."* **A check cannot fail on a decision nobody took.**

**Why it is still worth recording.** If `SRCH-GAP-003` were later closed by having `BC-01` or `BC-19`
evaluate entitlement locally — a reading §27's phrase *"the source system's authorisation"* does not
exclude — that would be an `X-13` violation *of exactly the kind the gate calls a defect that passes its own
tests*, because every requirement in §27 would still be satisfied. Recorded as **accepted finding
`SRCHAL-A4`**, with the constraint stated for the gap's owner: **the closure of `SRCH-GAP-003` must place
the policy decision in `BC-18`.** ⛔ This record does **not** close the gap, does not name the mechanism,
and does **not** require an ADR — the Architecture reviewer's ADR-requiring authority (**L277**) is
exercised by a *named* reviewer, and §2 establishes there is none.

### 6.3 ⭐ The strongest evidence in the subject's favour

§27's failure-mode paragraph identifies, unprompted, the precise defect class this check exists to catch:

> *"an index is a **copy**. If entitlement were evaluated when the copy was written rather than when it is
> read, then every later revocation… would leave a searchable residue. The index would become a permanent,
> **silent bypass** of the owning system's access control."*

`SRCH-FR-040` (per-page re-evaluation) and `SRCH-FR-012`/`013`/`014` (revocation propagation) are its
answer, and `SRCH-FR-013` inherits `SEV-9`'s **no propagation window** from BC Map **L427** rather than
inventing an eventual-consistency allowance.

### 6.4 Result — ✅ **PASS**

---

## 7. Check 5 — No credential, OTP or session outside `BC-18` ✅ **PASS**

**Authority:** `ID-1`, BC Map **L178**: *"No context outside BC-18 may store a password, OTP, session or
credential."* **Failure mode:** *prohibited.*

### 7.1 Mechanical scan of the subject

| Term | Occurrences | Every occurrence's role |
|---|---|---|
| `credential` | **0** | — |
| `OTP` | **0** | — |
| `password` | **0** | — |
| `session` | **1** | ⭐ **A prohibition.** §15 **L398**: *"⛔ No other input **MAY** influence matching. In particular no viewer identity, location, history or **session**"* |

**The single occurrence forbids the thing `ID-1` forbids.** No credential surface is created, no session is
stored, and no identity is minted.

### 7.2 The two adjacent `ID-*` rules, also honoured

| Rule | Statement | Position |
|---|---|---|
| **`ID-2`** | *"`StudentRecordId` **never** leaves its tenant. It must not appear in any Global Student context, event or **index**"* | ✅ `SRCH-INV-002` (one index class per document) and `SRCH-INV-004` (no tenant data in the public index) make this structural, not procedural |
| **`ID-5`** | Account deletion anonymises the Person | ✅ `SRCH-FR-012` treats `identity.PersonAnonymised` (**L428**) as **removal, not masking** — §29: *"A masked document is still a document; its presence, count and position remain observable"* |

⭐ **`BC-23` does not become an independent identity authority.** The subject holds no `PersonId` authority
(§5.2 row 3), mints no identifier, and — §29 — indexes **no** person surface in V1 at all.

### 7.3 Result — ✅ **PASS**

---

## 8. Check 6 — Tenant scoping correct ✅ **PASS**

**Authority:** `MP-GBR-08` (`MASTER_PRD.md` **L339**): *"Every search index and vector namespace is
tenant-partitioned. Every RAG retrieval is tenant-scoped **and** permission-aware."* · `X-13` (Dependency
Matrix **L362**) · **Failure:** *cross-tenant leak — `MP-RSK-01`, Critical* (`MASTER_PRD.md` **L551**).

### 8.1 `AR-3` adopted without alteration

`ARCHITECTURE_RULINGS.md` **L95–L120** and BC Map **§11.1 L494–L508** establish two categorically different
index classes. `PRD-015` §9 reproduces both columns and adds four requirements:

| Requirement | Effect |
|---|---|
| `SRCH-FR-006` | Two **separate** stores with separate query paths; ⛔ one index **MUST NOT** serve both |
| `SRCH-BR-004` | Tenant key **mandatory** in every tenant-operational index identity |
| `SRCH-FR-007` | A tenant-less query is **rejected**; ⛔ never a fallback to unscoped |
| `SRCH-INV-004` | ⭐⭐ Tenant operational data **MUST NEVER** enter the public discovery index |
| `SRCH-XC-013` | Never-public §14A.10 items excluded, *expressly including Internal Analytics* (`ADR-0094` §2 rule 3) |

`SRCH-FR-007` is the literal answer to BC Map **L487**'s demand that *"a query without tenant predicate
must fail at runtime, not silently return everything."* `SRCH-INV-004` quotes `AR-3`'s own severity: the
*"single highest-severity failure mode in the entire architecture."*

### 8.2 ⭐⭐⭐ Re-verification of the corpus-statistic property — the finding this check exists to preserve

The instruction asks specifically whether the Stage-2 conclusion — that tenant leakage through
corpus-statistic scoring was **structurally avoided** — still holds on the committed bytes. **It does, and
the mechanism is verifiable rather than promised.**

| Step | Measurement at `0611b1c` |
|---|---|
| The covert channel named | §28 consequence 3: *"A conventional relevance score is computed from corpus-wide term statistics. In a shared index, those statistics are a covert channel: the **score** of a document in tenant A varies with the **contents** of tenant B."* |
| The ordering rule that would carry it | `SRCH-FR-035` — ordering is **(1)** match tier, **(2)** field precedence, **(3)** declared stable tiebreak |
| Corpus terms in that rule | ⭐ **ZERO** |
| Numeric relevance scores anywhere in §22 | ⭐ **ZERO** — §22.2: *"There is no numeric relevance score in this model, and that is deliberate"* |
| Tolerance crossing a tenant boundary | Forbidden — §28 consequence 2, `SRCH-BR-012` C5: *"a typo cannot reach another tenant's document"* |
| Test obligation | §39 **T-I** — *"including that a typo cannot cross a tenant boundary"* |

⭐⭐ **The property is preserved by construction, not by rule.** A rule *"do not use cross-tenant
statistics"* would be an unverifiable promise; a relevance model with **no score at all** cannot carry the
channel. §28's own words: *"this channel does not exist by construction."* This is the single strongest
architectural result in the subject document, and it is **re-confirmed on the current bytes**.

### 8.3 The public index is not a tenant index — and the mirror case is closed

`AR-3` gives the public class *"caller tenant context: none — pre-authentication, anonymous"*. The obvious
inverse risk — a caller *presenting* a tenant context to the public index and widening it — is closed
explicitly by §40 **E12**: *"Public index served identically; ⛔ tenant context **MUST NOT** widen the
public result set."* ⭐ Called out in the subject as *"the mirror of `SRCH-FR-007`"*.

### 8.4 Inference channels, closed individually

`SRCH-XC-016` forbids a never-public value being inferred *"not by result presence, ordering, count,
timing, error text or pagination artefact."* Six named postures in §30 (S1–S6), and the §37.2 error
taxonomy's ⚠⚠ rule — *Invalid request* must stay **distinct** from *Success — empty*, while *Success —
empty* and *Success — empty (filtered)* must stay **identical** — is the correct resolution of the
existence-oracle problem, not a restatement of it.

### 8.5 Privacy boundaries

| Obligation | Requirement | Authority honoured |
|---|---|---|
| Anonymisation | `SRCH-FR-012` — **removal**, not masking | BC Map **L428** `SEV-16`, `ID-5` |
| Privacy mode | `SRCH-FR-013` — **no propagation window** | BC Map **L427** `SEV-9` |
| Eligibility loss | `SRCH-FR-014` — removal from the public index | §14A.6 |
| Rebuildability | `SRCH-INV-005` | BC Map **L453** — *"tested quarterly, not assumed"* |

### 8.6 Result — ✅ **PASS**

⛔ **No quantitative privacy threshold, retention period, propagation window or leakage budget is invented
by this record.** Where the subject inherits a value (`SEV-9`'s *no window*), it is cited to its source.

---
