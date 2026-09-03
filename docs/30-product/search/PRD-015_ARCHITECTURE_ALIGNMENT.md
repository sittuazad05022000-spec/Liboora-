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
## 9. ⚠⚠ RAISED — two Rank-3 baselines place `BC-23` obligations the subject does not carry

This section exists because `DOCUMENTATION_BASELINE.md` §4 forbids the reviewer from choosing:

> *"A conflict is a defect. If you find one, **do not choose — raise it**."*

Both items below are **RAISED, not resolved.** ⛔ This record does not amend the subject, does not amend
either baseline, and does not decide which document is wrong.

### 9.1 The measurement that produced both

| Token searched in `PRD-015` | Occurrences |
|---|---|
| `SID-` (Student Identity requirement prefix) | **0** |
| `Student_Identity` / Student Identity PRD | **0** |
| `TSF-` (Trust & Safety requirement prefix) | **0** |
| `SDS-` (`PRD-021B` B3 discovery prefix) | **0** |

⭐ `PRD-015` §7 enumerates its `E-21` sources and §6.2 enumerates its V1 consumers, but **neither list
reaches these two ranked documents**, and no requirement in the subject cites an obligation either places on
`BC-23`.

### 9.2 ⚠ RAISED `SRCHAL-R1` — Student Identity PRD §4.9 places four `SHALL`s on `BC-23`

**Authority:** `docs/30-product/student-identity/Student_Identity_PRD_v1.md` **§4.9 "Search Indexing —
`BC-23` (`E-21`)"**, **L939–L955**. Rank **3**, `BASELINE-2026-08-04`, recorded authoritative at
`DOCUMENTATION_BASELINE.md` **L155**.

| Requirement | Line | Obligation placed on `BC-23` |
|---|---|---|
| `SID-4.38` | **L941** | *"Discoverability of a public profile **SHALL** be provided by `BC-23`, driven by this module's events. `BC-23` **SHALL NOT** read this module's store. (`X-08`.)"* |
| `SID-4.39` | **L944** | Only the `SID-2.28` allow-list fields may be indexed; never-public fields *"**SHALL NOT** be indexed at all, in any index, for any purpose"* |
| `SID-4.40` | **L948** | A Public → Private transition **SHALL** remove the profile from public search *"as part of the same operation, **not** on the next scheduled reindex"* (`MP-GBR-26`) |
| `SID-4.41` | **L951** | ⛔ No mobile-number lookup; `BC-23` *"**SHALL NOT** confirm or deny that a mobile number is registered"* (`AR-7`, `SID-2.37`) |

**Why this is a conflict and not merely an omission.** `SID-4.38` is a **`SHALL` on `BC-23`**, issued by a
baselined Rank-3 document. `PRD-015` is now the registered home of the `BC-23` capability (`ADR-0094` §2
rule 4). A `SHALL` addressed to a context whose specification does not acknowledge it is **unowned**: no
acceptance criterion in `PRD-015`'s 78 covers `SID-4.39`'s never-index rule or `SID-4.40`'s
same-operation removal.

**⭐ Mitigating evidence, recorded for the owner's benefit.** The conflict is one of *citation*, not of
*contradiction* — the subject's independently-derived requirements are **compatible** in substance:

| `SID` obligation | Compatible `PRD-015` requirement | Contradiction? |
|---|---|---|
| `SID-4.38` events-not-store | `SRCH-FR-004` — projection by event only; `SRCH-XC-*` forbids reading source stores | ✅ None |
| `SID-4.39` never-index | `SRCH-FR-012`, `SRCH-XC-016` — never-public values not indexed and not inferable | ✅ None |
| `SID-4.40` same-operation removal | `SRCH-FR-013` — **no propagation window** (`SEV-9`, BC Map **L427**) | ✅ None |
| `SID-4.41` no mobile lookup | `SRCH-FR-013`/`SRCH-XC-016`; §37.2's identical *empty* vs *empty (filtered)* responses | ✅ None |

⚠ **But compatibility measured by a reviewer is not traceability declared by a specification.** And the
gap is live rather than theoretical: `SRCH-GAP-006` records that **`BC-10` Identity is an authorised `E-21`
source with no V1 consumer enabled** — so the moment that gap is closed toward *index it*, `SID-4.38`–`4.41`
become binding on a `PRD-015` surface that does not cite them.

**Disposition:** ⚠ **RAISED.** Required act: the **Architecture Owner** (or the eventual named `PRD-015`
owner) determines whether §4.9's obligations are carried into `PRD-015` by explicit citation, or whether
§4.9 remains the authority and `PRD-015` cross-references it. ⛔ **`OWNER NOT ESTABLISHED`** for `PRD-015`
itself (`PGA-08`), so this record names the *required act*, not the *decision*.

### 9.3 ⚠ RAISED `SRCHAL-R2` — `PRD-020` §8.3 makes `BC-23` step [4] of a non-bypassable safety pipeline

**Authority:** `docs/30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md` **§8.3, L544–L570**. Rank **3**
by `ADR-0086`, baselined at `DOCUMENTATION_BASELINE.md` **L202**.

The pipeline, verbatim in structure:

```
Candidate set → BC-23 Search index (permission-aware)
   [1] … → [2] … → [3] Safety → BC-13 → [4] Ranking → BC-23 — relevance
```

| Requirement | Obligation |
|---|---|
| `TSF-FR-023` | Suspended, terminated or discovery-restricted subjects **MUST NOT** appear in *"any discovery result, recommendation or search suggestion"* |
| **`TSF-INV-005`** | ⭐⭐ *"Step [3] **MUST** run after [1] and [2] and **MUST** be non-bypassable. A ranking or recommendation path that reaches the index without step 3 is a **defect**."* |
| `TSF-FR-024` | A safety exclusion **MUST** be indistinguishable from non-existence (`MP-GBR-22`) |

**Why this is a conflict.** `TSF-INV-005` is an **invariant** whose subject matter is *the path to the
index* — and `PRD-015` is the document that now specifies that path (`SRCH-FR-001`, `SRCH-FR-002`: retrieval
**only** through the query port). An invariant declaring a class of index access a *defect* must be
discoverable from the specification of the port it constrains. Measured: it is not (`TSF-` = 0).

**⭐ Mitigating evidence.** Again substantively compatible, and in one respect the subject is *stronger*:

| `TSF` obligation | Compatible `PRD-015` behaviour | Note |
|---|---|---|
| `TSF-FR-024` exclusion ≡ non-existence | §37.2 requires *Success — empty* and *Success — empty (filtered)* to be **identical**, and `SRCH-XC-016` closes ordering/count/timing/pagination channels | ⭐ Independently derived, same result |
| `TSF-FR-023` no suggestion leakage | §14A.6 eligibility governs the public corpus; `SRCH-FR-014` removes on eligibility loss | ⚠ Covers libraries; person-discovery is `SRCH-GAP-005`/`006` |
| `TSF-INV-005` step [3] non-bypassable | ⚠ **Not carried.** `PRD-015` requires entitlement re-evaluation (§27) but names **no safety step** | ⚠ The substantive gap |

⭐ **`PRD-021B` B3 already enforces `TSF-INV-005` from the consumer side** — `SDS-IDX-010` forbids querying
without steps [1]–[3]. So the invariant is *honoured by the consumer* while being *unstated by the
provider*. That is a defensible V1 posture (`PRD-015` §6.2 enables **no** person-discovery consumer), but
it is a posture nobody has recorded as a decision.

**Disposition:** ⚠ **RAISED.** Required act: **Architecture Owner** + **Trust & Safety owner** determine
whether the safety step belongs in the `BC-23` query-port contract or remains a consumer obligation. ⛔ Not
decided here. ⛔ No requirement added to either document. ⛔ `SRCH-GAP-005` is **not** closed by this.

### 9.4 What §9 explicitly does not do

⛔ No frozen or baselined document is modified — `Student_Identity_PRD_v1.md` and
`PRD-020_TRUST_AND_SAFETY.md` are **unchanged**, as are §14A and every `PRD-021A/B/C` artefact.
⛔ Neither conflict is *resolved*: the instruction's own rule — *"If a conflict exists, report it. Do not
resolve it by rewriting frozen history"* — is applied literally.
⛔ Neither raised item creates a new `SRCH-GAP-*`; the subject's nine gap IDs are preserved unchanged, and
`SRCHAL-R1`/`R2` are **record-local** identifiers under a prefix measured to be unused repo-wide (§10.3).

---
## 10. Validation performed

### 10.1 Repository validator suite — baseline unchanged

Run at the reviewed state, all 31 discovered checkers:

```
31 validators discovered
FAIL: alignment_record_freshness.py
FAIL: prd004_traceability.py
FAIL: prd005_traceability.py
FAIL: prd006_traceability.py
FAIL: prd007_traceability.py
FAIL: prd020_stage5.py
⇒ TOTAL=31  PASS=25  FAIL=6
```

⭐ **All six failures pre-date this review and pre-date the subject document itself.** The set is
**identical**, member for member, to the pre-existing baseline. **0 failures introduced; 0 checkers
altered; 0 checkers added.**

⚠ **Instrument note for future readers:** `prd020_stage5.py` emits its problems in **non-deterministic
order**. Compare its output as a **set**, never by textual diff — a reordered line is not a regression.

### 10.2 ⭐ Why this record carries a `sha256` even though no gate demands one

`tool/docs_check/alignment_record_freshness.py` checks **two** records (`records checked : 2`), and
`PRD-015` is not among them (§2.2). Its single current problem is instructive:

```
--- PRD-019_ARCHITECTURE_ALIGNMENT.md
    FAIL anchor missing: no sha256 in the record
PROBLEMS: 1
  - PRD-019_ARCHITECTURE_ALIGNMENT.md: no 64-hex hash found in the record chain —
    the freshness anchor is missing, so this check cannot run (it must not pass silently)
```

⭐ **A record without a subject hash cannot be shown to have reviewed the bytes it claims to review.**
`PRD-019_ARCHITECTURE_ALIGNMENT.md` is the repository's worked example of that defect. This record therefore
carries `fe3093e6…c2c4544` in its header **by discipline rather than by compulsion** — the anchor is what
lets a later reader prove whether `PRD-015` has since drifted.

⛔ **And this record is still not registered in `RECORDS`.** Adding it would convert an unmonitored-but-honest
record into a monitored-and-self-signed one. The gate's own contrast is decisive:

> *"FRESH via `PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md`. **Freshness is not conferral** — Stage 3
> remains the Architecture Reviewer's act."*
> *"This gate reports drift. It does not confer, refresh or repair a stage verdict."*

⚠ **Consequence, disclosed rather than hidden:** if `PRD-015` is edited after this review, **no automated
check will notice** that this record has gone stale. The remedy is a **supplement** (the `PRD-008` V17
pattern), never an in-place edit of these findings — Guard 4's rule.

### 10.3 Identifier hygiene

| Act | Measurement | Result |
|---|---|---|
| Record-local finding prefix | `SRCHAL-` — **0** occurrences repo-wide outside this file | ✅ Selected, no collision |
| Alternatives also checked | `S15F-` 0 · `P15A-` 0 · `SRCHREV-` 0 | ✅ Any would have been free |
| Subject's gap IDs | `SRCH-GAP-001`…`009` — **9**, reproduced verbatim in §13 | ✅ **0 renamed, 0 added, 0 closed** |
| `IMPL-*` identifiers created | **0** — the single occurrence in this record is the mandate's negative assertion | ✅ |
| ADR numbers consumed | **0** | ✅ |

**Collision procedure applied** per `PRD_LIFECYCLE.md` §5 rule 2: a prefix is measured across the repository
**before** first use, not assumed. ⛔ `SRCHAL-*` identifiers bear no authority — they name findings *of this
review*, and are not requirement, gap or decision identifiers.

### 10.4 Architecture invariants — Δ = 0 across the review

| Invariant | Before | After | Δ |
|---|---|---|---|
| Bounded contexts (`BC-01`…`BC-31`) | 31 | 31 | **0** |
| Integration edges (`E-nn` tokens 30; `E-27` permanently vacant ⇒ **29** real) | 29 | 29 | **0** |
| `E-27` files/rows resurrecting it | 0 | 0 | **0** |
| ADR files on disk | 86 | 86 | **0** |
| `ADR-0088` / `ADR-0089` / `ADR-0090` files | 0 / 0 / 0 | 0 / 0 / 0 | **0** ✅ reservation intact |
| Frozen documents modified | — | **0** | **0** |
| `PRD_REGISTRY.md` rows changed (append-only) | — | **0** | **0** |
| `DOCUMENTATION_BASELINE.md` rows changed | — | **0** | **0** |
| BC Map / Dependency Matrix rows changed | — | **0** | **0** |
| Checkers changed | — | **0** | **0** |
| Application-code files changed (`lib/ test/ web/ android/ ios/ tool/`) | — | **0** | **0** |
| `PRD-015` substantive requirements altered | — | **0** | **0** |

⭐ **The subject document is byte-identical to the reviewed hash.** A Stage-3 review that edits its own
subject has reviewed nothing; `fe3093e6…c2c4544` still resolves at `0611b1c`.

### 10.5 Coverage of the review itself

| Dimension | Count |
|---|---|
| Stage-3 checks answered by measurement | **6 of 6** |
| Distinct repository documents opened and cited | **31** |
| Rank-1 / Rank-2 / Rank-3 / Rank-4 authorities cited | **2 / 9 / 7 / 3** |
| Requirement identifiers of the subject examined | **156** (42 FR · 14 BR · 6 INV · 16 XC · 78 AC) |
| Findings accepted | **6** (§14) |
| Findings **rejected, with reasons** | **5** (§15) |
| Conflicts raised, unresolved | **2** (§9) |
| Gaps preserved open | **9** |
| Gaps closed | **0** |

---
## 11. ⭐⭐⭐ Consolidated Stage 3 verdict

### 11.1 The six checks, as measured

`PRD_LIFECYCLE.md` **L90** requires the PRD to be validated *"against Ranks 1–5, **in this order**"*. The
order was followed; each row names the authority the lifecycle itself names.

| # | Check | Authority | Failure mode it guards | Verdict | Section |
|---|---|---|---|---|---|
| 1 | Context ownership is exclusive | BC Map §3 | Two PRDs own one aggregate | ✅ **PASS** | §3 |
| 2 | Every integration edge exists in §7 | BC Map §7 | *"If an edge is not in this table, it does not exist"* | ✅ **PASS** | §4 |
| 3 | Rank direction is downward | Dependency Matrix `L2` | Illegal import | ✅ **PASS** | §5 |
| 4 | No authorisation decided outside `BC-18` | `X-13` | ⭐ *A security defect that passes its own tests* | ✅ **PASS** | §6 |
| 5 | No credential, OTP or session outside `BC-18` | `ID-1` | Prohibited | ✅ **PASS** | §7 |
| 6 | Tenant scoping correct | `MP-GBR-08`, `X-13` | Cross-tenant leak — `MP-RSK-01`, **Critical** | ✅ **PASS** | §8 |

**6 of 6 PASS as measured. 0 FAIL. 0 BLOCKED.**

### 11.2 ⭐⭐⭐ Why 6/6 PASS is nevertheless **CONDITIONAL**, and never **CONFERRED**

Three distinct facts are routinely collapsed into one. This record separates them.

| Fact | State | Basis |
|---|---|---|
| **(a) Measured alignment** | ✅ **6 of 6 checks PASS** | §3–§8, each with line-cited evidence |
| **(b) Stage 3 completeness** | ⚠ **NOT COMPLETE** | The subject's **own** §42 declares three gaps *blocking Stage 3* |
| **(c) Formal conferral** | ⛔ **NOT CONFERRED** | `PRD_LIFECYCLE.md` **L283** / `PGA-08` — the conferring role is **unassigned** |

**On (b) — the subject disqualifies itself, and the reviewer respects that.** `PRD-015` §42 marks three of
its nine gaps `Blocks: Stage 3`:

| Gap | Question | Owner | Why the reviewer cannot close it |
|---|---|---|---|
| **`SRCH-GAP-002`** | Implementation parameters P1–P8: engine, analyzer config, **edit-distance bound**, minimum token/prefix length, page-size cap, projection lag, latency/availability targets, rebuild posture, transport binding | **Architecture Owner** | Every one is a **number**. Instruction §10 and the subject both forbid inventing them |
| **`SRCH-GAP-003`** | The mechanism by which a source system's entitlement decision is evaluated **at query time** | **Architecture Owner** | The `X-13` boundary itself (§6.2). A reviewer-chosen mechanism would be the defect Check 4 exists to catch |
| **`SRCH-GAP-007`** | The language/script inventory and declared variant/abbreviation vocabulary | **Product Owner** + **Architecture Owner** | A market-scope decision (§12.4) |

⭐ **A document that declares its own Stage-3 blockers is not failing the gate — it is passing the honesty
test the gate depends on.** Reporting a bare PASS here would contradict the subject and would silently close
three owner decisions. Hence **CONDITIONAL**.

**On (c) — the decisive constraint.** `PRD_LIFECYCLE.md` **L277** assigns Stage 3 to the *Architecture
reviewer*; **L283** states *"Every PRD needs a named owner. **None has one**"*. No acting role can therefore
**confer** Stage 3. The freshness gate independently confirms the separation: *"It does not confer Stage 3 or
Stage 4… a supplement makes a record **fresh**, never **conferred**."*

> ⛔ **The word CONFERRED is not used of this verdict, anywhere in this document.**

### 11.3 The verdict

> ## ⚠ **CONDITIONAL PASS — MEASURED, NOT CONFERRED**
>
> **`PRD-015` Search Indexing v0.1 `DRAFT` is architecturally aligned on all six Stage-3 checks
> as measured at `fe3093e6…c2c4544`.**
>
> **Stage 3 is NOT COMPLETE**, on three grounds:
> 1. `SRCH-GAP-002`, `SRCH-GAP-003` and `SRCH-GAP-007` are declared by the subject as **blocking Stage 3**,
>    and all three are **owner decisions** (§11.2);
> 2. two Rank-3 baselines place `BC-23` obligations the subject does not cite — **`SRCHAL-R1`**,
>    **`SRCHAL-R2`** — raised and unresolved (§9);
> 3. **no named Architecture reviewer exists** to confer the stage (`PGA-08`).
>
> ⛔ **NOT** an approval · **NOT** a freeze · **NOT** a baseline · **NOT** a rank · **NOT** a conferral.

### 11.4 ⛔ What this verdict is NOT

Following the `PRD-008` V17 supplement's row of the same name:

| | |
|---|---|
| ⛔ **What this verdict is NOT** | It is not a conferral, and **Stage 3 is therefore NOT satisfied by this document alone.** It records that the six lifecycle checks were run and what they returned. Conferral is a role act under `PRD_LIFECYCLE.md` §6 by a **named** Architecture reviewer. It is not a Stage-4 requirements review, not an approval to implement, not a rank assignment, and not a licence to create `IMPL-*` identifiers |

### 11.5 Conditions that must be discharged before Stage 3 can be conferred

⚠ These are **required acts for owners**, not decisions taken here. ⛔ No owner is invented; where the
repository establishes none, this record writes **`OWNER NOT ESTABLISHED`**.

| # | Condition | Required actor | Evidence of the requirement |
|---|---|---|---|
| C1 | Close `SRCH-GAP-002` (P1–P8) | **Architecture Owner** | `PRD-015` §36, §42; `ADR-0094` §5 |
| C2 | Close `SRCH-GAP-003` — ⭐ **the policy decision must sit in `BC-18`** (`SRCHAL-A4`) | **Architecture Owner** | `X-13`; BC Map **L130**; §6.2 |
| C3 | Close `SRCH-GAP-007` (language/script inventory) | **Product Owner** + **Architecture Owner** | `PRD-015` §16, §20 |
| C4 | Dispose of `SRCHAL-R1` — Student Identity §4.9 | **Architecture Owner** + Student Identity owner | `Student_Identity_PRD_v1.md` **L939–L955** |
| C5 | Dispose of `SRCHAL-R2` — `PRD-020` §8.3 / `TSF-INV-005` | **Architecture Owner** + Trust & Safety owner | `PRD-020` **L544–L570** |
| C6 | Resolve `SRCH-GAP-001` — the `PLANNED` → `DRAFT` registry transition | **Governance Owner** | `PRD_REGISTRY.md` **L315**, **L726–L727** |
| C7 | Name a `PRD-015` owner and an Architecture reviewer so Stage 3 **can** be conferred | ⛔ **`OWNER NOT ESTABLISHED`** — `PGA-08` is itself unassigned | `PRD_LIFECYCLE.md` **L283** |

⭐ **C7 is the root condition.** C1–C6 are dischargeable by named roles; C7 must be discharged before any of
them can be *accepted*. ⛔ This record does not assign it.

### 11.6 What did **not** block, and why that matters

⚠ An honest verdict must also record what it declined to treat as a blocker. Four candidate blockers were
tested and **rejected** (§15): the `E-27` census, the missing consumer-direction edge, the `BC-19`→`BC-23`
rank direction, and the zero `BC-18` citations. Had any been accepted uncritically, this review would have
returned **FAIL** on a correct document — the failure mode `PRD-008` §3.4 names: *"A reading that invalidates
the gate's own prerequisite is the wrong reading."*

---
## 12. ⭐⭐⭐ Flexible / tolerant search — architectural verification

This section verifies that the architecture supports **reusable** tolerant matching across the repository-
authorised search surfaces, not merely library search. It is a verification of **architecture**, not a
specification of parameters.

> ⛔ **Nothing in this section invents an edit-distance threshold, a numeric relevance score, a field
> weight, a ranking formula or a fuzzy-match percentage.** Where `PRD-015` correctly leaves a parameter
> OPEN, it is **preserved as OPEN** here and attributed to its gap.

### 12.1 The mechanism is a tier ladder, and every tier is named

`SRCH-FR-025` requires matching as *"an **ordered ladder of tiers**, not as an exact-string-only test"*:

| Tier | Name | Admits | Section |
|---|---|---|---|
| **T1** | EXACT / VERY STRONG | Normalized term equals the indexed value or whole field | §18 |
| **T2** | TOKEN / PARTIAL | All query tokens present as tokens **or token prefixes** | §19 |
| **T3** | CLOSE VARIANT / TOLERANT | Word-form variants, equivalent variations, **bounded** minor misspellings | §20, §21 |
| **T4** | **IRRELEVANT** | ⛔ **EXCLUDED from the result set entirely** | §22.3 |

⭐ **`SRCH-FR-026` requires every result to carry the tier at which it matched** — *"so that relevance is
**explainable** and testable"*, and *"a result MUST NOT be returned without an attributable tier."*
**Architecturally this is the important property:** tolerance is *structured* rather than *scored*, so it can
be tested by tier attribution without any number existing.

### 12.2 The ten required behaviours, each traced to a mechanism

Each row is measured against `PRD-015` §17.2 (**L465–L474**) and its governing section:

| # | Required behaviour | The user types | MUST still find | Mechanism | Tier | ✅ |
|---|---|---|---|---|---|---|
| 1 | **Case-insensitive** | `central library` / `CENTRAL LIBRARY` | *Central Library* | N1 case folding (§16) | T1 | ✅ |
| 2 | **Whitespace tolerant** | `Central   Library` | *Central Library* | N2 whitespace collapse | T1 | ✅ |
| 3 | **Punctuation tolerant** | `St Marys` | *St. Mary's* | N3 punctuation/separator normalization | T1 | ✅ |
| 4 | **Token match** | `library` | *Central **Library*** | §19 token match | T2 | ✅ |
| 5 | **Order-independent multi-token** | `lib central` | *Central Library* | §19 *"MUST be **order-independent**"* (**L514**) | T2 | ✅ |
| 6 | **Partial / prefix** | `Central Lib` | *Central Library* | §19 token + **prefix** | T2 | ✅ |
| 7 | **Singular / plural** | `library` | *Libraries* | §20 `V1` word-form equivalence | T3 | ✅ |
| 8 | **Plural / singular (symmetric)** | `libraries` | *Library* | §20 **L547**: *"`libraries` **MUST** match *Library*"* | T3 | ✅ |
| 9 | **Bounded minor typo** | `Centrl Library` | *Central Library* | §21 bounded typo tolerance | T3 | ✅ |
| 10 | **Irrelevant ⇒ nothing** | `xylophone` | ⛔ **nothing** | §22.3 `SRCH-BR-013` | **T4 excluded** | ✅ |

⭐ **All three examples named in the instruction resolve:** `library` ↔ `libraries` (rows 7–8, symmetric by
`SRCH-BR-008`), `Central Lib` → *Central Library* (row 6), `Centrl` → *Central* (row 9).

⚠ **Row 11, recorded honestly by the subject rather than glossed:** `Central Library Delhi` (an extra token)
matches *"only if §19's multi-token rule is satisfied"*, and §19 **L529** states the consequence plainly —
*"`Central Library Delhi` will **not** match a *Central Library* whose indexed…"* text lacks the token. ⭐ **A
specification that discloses what its own rule excludes is stronger than one that implies everything matches.**

### 12.3 ⭐⭐ Normalization is separated from tolerance — the property that makes reuse safe

`PRD-015` §16 draws a boundary this review considers architecturally decisive:

> ⚠ *"**Normalization is not tolerance.** N1–N6 do not guess. Two strings that normalize identically **are**
> the same term at the EXACT tier (§18); nothing is loosened, so nothing irrelevant is admitted."*

and `SRCH-BR-008` makes normalization **symmetric and total**:

> *"any transformation applied to a query term **MUST** have been applied to the indexed term, and vice
> versa. ⛔ An asymmetric rule **MUST NOT** be introduced, because it silently makes some indexed documents
> permanently unreachable."*

⭐ **`SRCH-FR-023` requires the identical rule set at index time and query time.** Architecturally, this is
what allows a *single* `BC-23` analyzer to serve *multiple* consumers: rows 1–3 above are achieved with **no
tolerance at all**, so the cheap cases cannot degrade precision, and only rows 7–9 engage T3.

### 12.4 What is OPEN — and stays OPEN

| Parameter | Status in the subject | Gap | Preserved OPEN here? |
|---|---|---|---|
| Search engine / analyzer configuration | ⛔ Not selected | `SRCH-GAP-002` P1 | ✅ **Yes** |
| **Edit-distance bound** for T3 typo tolerance | ⛔ Not stated — §21 requires it be *bounded*, not *what the bound is* | `SRCH-GAP-002` | ✅ **Yes** |
| Minimum token / prefix length for T2 | ⛔ Not stated (**L572**: *"⛔ Not fabricated here"*) | `SRCH-GAP-002` | ✅ **Yes** |
| Page-size cap, projection lag, latency/availability targets | ⛔ Not stated | `SRCH-GAP-002` | ✅ **Yes** |
| Language / script inventory; variant & abbreviation vocabulary | ⛔ Not stated — the *behaviour* is required, the *inventory* is not | **`SRCH-GAP-007`** | ✅ **Yes** |
| §14A **field precedence** order for `SRCH-FR-035` layer 2 | ⛔ §14A declares none (measured: 0 occurrences of *precedence*) | **`SRCH-GAP-009`** | ✅ **Yes** |
| Numeric relevance scores / field weights / ranking formula | ⛔ **None exist anywhere in the subject** (§8.2 measurement) | — | ✅ **Yes — and see §12.6** |

⭐⭐ **The subject's discipline here is exemplary and is the reason Check 6 passes.** §16's own words:
*"⛔ No inventory is asserted here."* §20's: *"⛔ Not fabricated here."* This review adds nothing to either.

### 12.5 Reusability beyond library search — verified, and bounded correctly

Instruction §10 requires the capability be reusable *"across applicable repository-authorized search
surfaces, not merely library search."* Measured:

| Surface | Reuse posture | Authority |
|---|---|---|
| §14A library discovery (V1) | ✅ Enabled consumer | `ADR-0094`; `PRD-015` §6.2 |
| `PRD-021C` C2 / C6 | ✅ Enabled consumers; consume the port, author no matcher | `LSD-FR-008`; C6 **L78** |
| `PRD-021B` B3 student discovery | ⚠ **Not enabled in V1** — `SRCH-GAP-005`, no `E-21` consumer authority measured for `BC-11`/`BC-12` | `PRD-015` §6.2 |
| `BC-01` Enrollment / `BC-10` Identity | ⚠ Route authorised by `E-21`; **no V1 consumer enabled** — `SRCH-GAP-006` | BC Map **L330** |
| `PRD-021A` community search | ⛔ **Refused** — `AO-9`, BC Map **L753**: *"`BC-15` is NOT a consumer"* | BC Map **L753** |

⭐ **`SRCH-FR-008` authors the capability once in `BC-23` and forbids per-surface implementation** — so the
mechanism is *reusable by construction*, while **which surfaces may reuse it** remains an authorisation
question the subject correctly refuses to answer for itself (§4.4). ⭐ **Consumers may also constrain what
they expose** — §14A.6 eligibility narrows the public corpus without altering the matcher — which is the
correct direction of constraint: a consumer may **narrow**, never **widen** (§40 **E12**).

### 12.6 ⭐⭐ Search relevance vs business ranking — the separation holds (instruction §11)

| Layer | Owner | May decide | Authority |
|---|---|---|---|
| **Retrieval + tier attribution** (relevance) | ⭐ **`BC-23`** | Which documents match, and at which tier | `SRCH-FR-025`, `SRCH-FR-026` |
| **Domain ordering after retrieval** | ⭐ **The consuming domain** | Business meaning: distance, price, availability, promotion | §14A **L114**; `PRD-021C` C6 |
| **Composite business ranking** | ⛔ **Nobody** | — | `PRD-021C` C6 **L78**: *"Nobody owns a composite ranking"* |

Verified as a two-sided property, not a one-sided claim:

- **`BC-23` does not claim business ranking.** §3.3 measured **zero** numeric scores and **zero** weights;
  relevance is expressed as a **tier**, which carries no business meaning.
- **Consumers do not claim relevance.** `LSD-XC-002` forbids a second relevance system; `DRK-XC-005` forbids
  B4 performing *"indexing, query rewriting, tokenisation, stemming, synonym expansion or text scoring —
  Owner: `BC-23`"*; `SDS-IDX-007` forbids a second index.
- **Ordering is applied *after* retrieval.** C6 applies §14A **L114** distance sort to an already-retrieved
  set; `PRD-021B` B4 orders a candidate set it did not match.

⭐⭐ **The architecture is therefore modular in the required sense:** tolerant matching can be reused by a new
consumer **without** that consumer inheriting anyone's business ranking, and a consumer can change its
business ordering **without** touching the matcher. ⛔ Relevance is **not** silently converted into universal
business ranking — the conversion is impossible here, because there is no score to convert.

---
## 13. Gap handling — all nine preserved, none closed

⛔ **This review closes no gap.** `PRD_LIFECYCLE.md` **§6** reserves gap closure to owners, and the
instruction's rule is applied literally: *do not close any gap merely because it would make Stage 3 easier.*
⭐ Three of these gaps are precisely what makes the Stage-3 verdict **CONDITIONAL** (§11.2) — closing them by
review would have manufactured a clean PASS out of unanswered questions.

### 13.1 The subject's nine gaps, reproduced with identifiers unchanged

| Gap | Question (as the subject states it) | Owner **as the repository establishes it** | Blocks | Stage-3 disposition |
|---|---|---|---|---|
| **`SRCH-GAP-001`** | Registry status is `PLANNED`; a `PLANNED` → `DRAFT` transition needs conferred authority | ⭐ **Governance Owner** | Stage-2 conferral | ⚠ **OPEN** — confirmed: `PRD_REGISTRY.md` **L315** still reads `PLANNED` |
| **`SRCH-GAP-002`** | Implementation parameters **P1–P8** | **Architecture Owner** | ⛔ **Stage 3** | ⚠ **OPEN — blocking.** Every item is a number (§12.4) |
| **`SRCH-GAP-003`** | Query-time entitlement evaluation mechanism | **Architecture Owner** | ⛔ **Stage 3** | ⚠ **OPEN — blocking.** ⭐ Constraint added, not closure: **the decision must sit in `BC-18`** (`SRCHAL-A4`) |
| **`SRCH-GAP-004`** | **Keyword stuffing** in §14A.5 public text inflating relevance | ⭐ **Architecture Owner** (analyzer) **+ Product Owner** (acceptable use) | Nothing in V1 | ⚠ **OPEN.** ✅ Verified as the **discharge of `XPC-OD-009`** — C0 **L427**, `ADR-0098` **L221** both route here |
| **`SRCH-GAP-005`** | Whether `PRD-021B` discovery becomes an `E-21` consumer | **Architecture Owner** (edge) **+ Product Owner** (scope) | Nothing in V1 | ⚠ **OPEN.** ⭐ Correctly *not* closed by minting an edge (§4.3) |
| **`SRCH-GAP-006`** | `BC-01`/`BC-10` are authorised `E-21` sources with **no V1 consumer** | **Product Owner** (need) **+ Architecture Owner** (posture) | Nothing in V1 | ⚠ **OPEN.** ⚠ Interacts with `SRCHAL-R1` (§9.2) |
| **`SRCH-GAP-007`** | Language/script inventory; variant & abbreviation vocabulary | **Product Owner** (markets) **+ Architecture Owner** (analyzer) | ⛔ **Stage 3** | ⚠ **OPEN — blocking** (§12.4) |
| **`SRCH-GAP-008`** | Query-volume abuse / rate limiting on the anonymous public surface | ⛔ **`OWNER NOT ESTABLISHED`** | Nothing in V1 | ⚠ **OPEN** — see §13.2 |
| **`SRCH-GAP-009`** | §14A declares **no field precedence order**, which `SRCH-FR-035` layer 2 requires | **Product Owner** — it is a §14A product statement | Nothing (ordering stays deterministic without it) | ⚠ **OPEN.** ✅ Measurement re-verified: **0** occurrences of *precedence* in §14A |

**Totals: 9 preserved · 0 renamed · 0 merged · 0 added · 0 closed.** ⛔ **3 blocking Stage 3.**

### 13.2 ⛔ `SRCH-GAP-008` — the one gap where this record writes `OWNER NOT ESTABLISHED`

The instruction requires an owner *only where evidence establishes it*, and otherwise the literal words.
Measured evidence:

- `PRD-015` §42 states, of this row alone: ⛔ **"No owner exists"**.
- Its basis `XPC-OD-010` (`PRD-021C` C0 **L428**) is itself **OPEN**.
- `LIB-14B.42` records the requirement, not an owner.

> ⛔ **`OWNER NOT ESTABLISHED`** for `SRCH-GAP-008`.

**Missing evidence, stated explicitly** so a future reader knows what to look for: no document in this
repository assigns rate limiting on an anonymous, pre-authentication surface to a named context or role.
`BC-18` owns *authorisation*, which is not the same as *volume control on unauthenticated traffic*; no
API/BFF (`BC-31`) ownership statement covers it either. ⭐ **The correct output of a review here is a named
absence, not a plausible guess.** ⛔ This record does not assign the gap, does not nominate a context, and
does not require an ADR for it.

### 13.3 The other governance items named in the instruction

| Item | Status | Evidence |
|---|---|---|
| **Registry / conferral gap** | ⚠ **OPEN** — `SRCH-GAP-001`; and **no Architecture reviewer is named** to confer Stage 3 | `PRD_REGISTRY.md` **L315**; `PRD_LIFECYCLE.md` **L283** (`PGA-08`) |
| **P1–P8** | ⚠ **OPEN — blocking Stage 3** | `SRCH-GAP-002`; `PRD-015` §36 |
| **Query-time entitlement** | ⚠ **OPEN — blocking Stage 3**, with the `BC-18` constraint recorded | `SRCH-GAP-003`; §6.2 |
| **Keyword stuffing** | ⚠ **OPEN**, blocks nothing in V1 | `SRCH-GAP-004`; `XPC-OD-009` |
| **`PRD-021B` consumer authority** | ⚠ **OPEN** | `SRCH-GAP-005` |
| **`BC-01`/`BC-10` V1 consumer** | ⚠ **OPEN** | `SRCH-GAP-006` |
| **Language inventory** | ⚠ **OPEN — blocking Stage 3** | `SRCH-GAP-007` |
| **Rate limiting** | ⚠ **OPEN — `OWNER NOT ESTABLISHED`** | `SRCH-GAP-008` (§13.2) |
| **§14A field precedence** | ⚠ **OPEN** | `SRCH-GAP-009` |
| **`PRD-021B` B3/B4 relationship** | ⚠ **RAISED** as `SRCHAL-R2`; B-side disclaimers verified intact | §9.3; §4.4 |

⛔ **No new gap identifier is created by this review.** `SRCHAL-A*` and `SRCHAL-R*` are review findings, not
gaps: they carry no owner, no blocking status and no lifecycle standing.

---

## 14. ⭐⭐⭐ Five-expert review

Each expert reports **findings**, **concerns**, **conflicts** and a **verdict**. Findings accepted by the
review are numbered `SRCHAL-A*`; rejected findings are in **§15**.

### 14.1 Expert 1 — Product / Requirements Reviewer

**Findings**

| # | Finding |
|---|---|
| 1 | The document's **scope refusals are as explicit as its requirements**: §5 lists what `PRD-015` does **not** own (eligibility, §14A.5 field set, business ordering), each routed to its owner. A capability PRD that specifies its own non-scope is testable at its boundary. |
| 2 | **Requirement completeness is structural, not asserted.** 156 obligation-bearing identifiers (42 FR · 14 BR · 6 INV · 16 XC) and **78 acceptance criteria**, mapped positionally and totally, every one in Given/When/Then form (§43). |
| 3 | ⭐ The **ten user-visible tolerant-search behaviours** required by the product brief all resolve to a named mechanism and tier (§12.2), including all three worked examples. |
| 4 | ⭐⭐ `SRCH-FR-026` — every result carries its **match tier** — converts "relevance" from an opinion into a **testable attribution**. This is the single most valuable product requirement in the document. |
| 5 | **§19 L529 discloses a genuine product consequence** (`Central Library Delhi` will not match) rather than hiding it behind an implication that everything matches. |

**Concerns**

- ⚠ `SRCH-GAP-007` (language/script inventory) is a **market-scope** decision the Product Owner must take;
  until then the tolerant behaviours are specified but not *bounded to a market*.
- ⚠ `SRCH-GAP-009` — §14A declares no field precedence, which `SRCH-FR-035` layer 2 wants. Ordering stays
  deterministic without it, so this degrades explainability rather than correctness.
- ⚠ `SRCH-GAP-004` (keyword stuffing) is an **acceptable-use** product question as much as an analyzer one.

**Conflicts** — ⚠ **1**: `SRCHAL-R1` — Student Identity §4.9's four `SHALL`s on `BC-23` are not cited by the
subject, and person-search is exactly the surface `SRCH-GAP-006` would open (§9.2).

**Verdict — ✅ PASS (product scope and requirement quality)**, ⚠ **CONDITIONAL** overall: two product-owner
gaps (`SRCH-GAP-007`, `SRCH-GAP-009`) and one raised conflict remain open. ⛔ No requirement added or reworded.

### 14.2 Expert 2 — Enterprise / Domain Architect

**Findings**

| # | Finding |
|---|---|
| 1 | ✅ **Ownership is exclusive.** Exactly **one** PRD claims `BC-23` (field-parsed on the registry's context column); the subject claims **0** aggregates outside it (§3.1). |
| 2 | ⭐⭐ **`SRCHAL-A2`** — no numbered edge names C2/C6/§14A as *consumers* of `BC-23`, yet this is **not** a §7 defect: `AR-1` rules Library Discovery *"composes… **through `BC-23`**"* and is **not a context**; `ADR-0033` §3 rules L292 *"governs edges… does not state that every cross-context read must be an edge"*; and `PRD-008` §3.4 measured 14 of 17 ports with no edge. **No edge was invented** (§4.3). |
| 3 | ⭐ **`SRCHAL-A3`** — `E-21`'s `BC-19` (R4) → `BC-23` (R5) direction is lawful because the pattern cell is `PL` + Event and §7.4 `F-2` routes capability learning through `liboora_contracts` (**R0**): the real dependency is R5 → R0, **downward**. Had the subject specified a *sync read*, Check 3 would **FAIL**; `SRCH-FR-004` specifies events (§5.3). |
| 4 | ✅ **`SRCHAL-A1`** — `PRD-015`'s arrival **reduces** duplication risk. Before it, `LSD-FR-008`'s demand for an owner-defined query port was unanswerable, and *"the first consumer to answer would become a de facto second search authority, which `LSD-XC-002` forbids"* (§4.4). |
| 5 | ✅ **No second search system exists** — six candidates measured, five reciprocal disclaimers verified (`LSD-XC-002`, C6 **L78**, `SDS-IDX-007/008`, `DRK-XC-005`, `AO-9`). ⭐ The disclaimers are **reciprocal**, so there is no hole between provider and consumers. |

**Concerns**

- ⚠ `SRCH-GAP-005`/`006` leave two authorised `E-21` source routes with no enabled consumer. Architecturally
  clean (an authorised route need not be used), but it defers the person-search boundary question.
- ⚠ `SRCH-GAP-002` (P1) leaves the transport binding open, so the port's *shape* is specified while its
  *binding* is not.

**Conflicts** — ⚠ **1**: `SRCHAL-R2` — `TSF-INV-005` constrains *the path to the index*, which the subject
now specifies, yet the subject does not cite it (§9.3).

**Verdict — ✅ PASS on Checks 1, 2 and 3.** ⛔ No edge, event, context, rank or ADR created.

### 14.3 Expert 3 — Search / Information-Retrieval Engineer

**Findings**

| # | Finding |
|---|---|
| 1 | ⭐⭐ **The tier ladder is the right architecture for a reusable matcher.** T1–T4 with mandatory tier attribution (`SRCH-FR-025`/`026`) gives tolerance **structure instead of a score** — testable without any numeric parameter existing. |
| 2 | ⭐⭐ **Normalization is correctly separated from tolerance** (§16): N1–N6 *"do not guess"*, so case, whitespace, punctuation, diacritics and zero-width characters are handled at **T1** and cannot degrade precision. |
| 3 | ⭐⭐ **`SRCH-BR-008`'s symmetry rule is the deepest engineering insight in the document**: an asymmetric normalization *"silently makes some indexed documents permanently unreachable"*, and `SRCH-FR-023` forces the identical rule set at index and query time. This is the classic analyzer-mismatch defect, pre-empted. |
| 4 | ⭐⭐ **T4 excludes rather than ranks last** (§22.3, `SRCH-BR-013`). §22.3's reasoning is correct: unbounded similarity means *"a query for `xylophone` returns libraries — which destroys precision, makes empty results impossible"*. **An empty result set must remain possible**, or the search is uninformative. |
| 5 | ✅ **Order-independent token matching** (**L514**) and prefix matching give `lib central` and `Central Lib` without a scoring model. |
| 6 | ✅ **Projection is event-driven** (`SRCH-FR-004`) with rebuildability as an invariant (`SRCH-INV-005`), tested quarterly per BC Map **L453** rather than assumed. |

**Concerns**

- ⚠ `SRCH-GAP-002` leaves the **edit-distance bound**, minimum token/prefix length and page-size cap open.
  ⛔ Correctly so — these are engine-coupled. But T3 cannot be *tested* until the bound exists.
- ⚠ Without `SRCH-GAP-007`'s language inventory, N3/N4's separator and diacritic rules have no declared
  domain of application.
- ⚠ `SRCH-GAP-009`'s missing field precedence weakens `SRCH-FR-035` layer 2's explainability.

**Conflicts** — ✅ **0**. ⭐ No consumer claims a competing matcher: `DRK-XC-005` explicitly reserves
tokenisation, stemming, synonym expansion and text scoring to `BC-23`.

**Verdict — ✅ PASS.** The retrieval architecture is sound and reusable. ⚠ Parameterisation is **OPEN** by
design. ⛔ **No threshold, score, weight, formula or percentage is supplied by this review.**

### 14.4 Expert 4 — Security / Privacy Architect

**Findings**

| # | Finding |
|---|---|
| 1 | ⭐⭐⭐ **The corpus-statistic leakage channel does not exist by construction** (§8.2). Measured: **zero** corpus-frequency terms and **zero** numeric relevance scores in the subject. A tenant's ranking therefore *cannot* vary with another tenant's content — because there is no score for another tenant's content to perturb. ⭐ This preserves the Stage-2 property, and preserves it *structurally* rather than by promise. |
| 2 | ⭐⭐ **`AR-3`'s two index classes are adopted without alteration** (§8.1): the public index's unit is `TenantOrganisation` with **no** caller tenant context; tenant-operational queries require the tenant key **mandatorily** (`MP-GBR-08`, `SE-1`, `X-13`). |
| 3 | ⭐⭐ **The mirror risk is closed explicitly.** §40 **E12**: a tenant context ⛔ *"MUST NOT widen the public result set"* — the inverse of `SRCH-FR-007`, and the direction reviewers usually forget. |
| 4 | ⭐⭐ **Query-time entitlement re-evaluation is required, and the reasoning is exactly right** (§27): *"an index is a **copy**… If entitlement were evaluated when the copy was written… the index would become a permanent, **silent bypass** of the owning system's access control."* `SRCH-FR-040` re-evaluates **per page**. |
| 5 | ✅ **No credential, OTP, password or session is defined** (§7.1): counts 0/0/0, and the single `session` occurrence (**L398**) is a **prohibition**. `ID-1` intact. |
| 6 | ⭐⭐ **The existence-oracle problem is solved, not restated** (§37.2): *Invalid request* must stay **distinct** from *Success — empty*, while *Success — empty* and *Success — empty (filtered)* must be **identical**. `SRCH-XC-016` additionally closes ordering, count, timing, error-text and pagination channels. |
| 7 | ✅ **Anonymisation is removal, not masking** (`SRCH-FR-012`, `SEV-16`/`ID-5`); privacy mode has **no propagation window** (`SRCH-FR-013`, inheriting `SEV-9` from BC Map **L427** rather than inventing an eventual-consistency allowance). |

**Concerns**

- ⚠⚠ **`SRCHAL-A4` — the most important concern in this review.** `PRD-015` contains **zero** occurrences of
  `BC-18`, attributing visibility to *"the source system's authorisation"*. This is **not** a Check-4 failure
  (the subject decides nothing and routes to `SRCH-GAP-003`), **but** a closure that let `BC-01` or `BC-19`
  evaluate entitlement locally would satisfy every §27 requirement while violating `X-13` — *"a security
  defect that passes its own tests."* ⛔ **Constraint recorded for the owner: `SRCH-GAP-003`'s closure must
  place the policy decision in `BC-18`.**
- ⚠ `SRCH-GAP-008` — anonymous-surface query-volume abuse has ⛔ **`OWNER NOT ESTABLISHED`** (§13.2). The
  public surface is pre-authentication by `AR-3`, so no `BC-18` control applies to it.
- ⚠ `SRCH-GAP-004` — keyword stuffing is an integrity concern on public text, not a leakage concern.

**Conflicts** — ⚠ **2 raised**: `SRCHAL-R1` (`SID-4.39`'s never-index rule and `SID-4.40`'s same-operation
removal are uncited, though `SRCH-FR-012`/`013` are substantively compatible) and `SRCHAL-R2`
(`TSF-INV-005`'s non-bypassable safety step is enforced by B3 as consumer but unstated by the provider).

**Verdict — ✅ PASS on Checks 4, 5 and 6**, with **`SRCHAL-A4`'s constraint recorded** and two conflicts
raised. ⭐ `MP-RSK-01`'s Critical failure mode — cross-tenant leak via a capability context — is
**structurally avoided**. ⛔ No quantitative privacy threshold, retention period or leakage budget invented.

### 14.5 Expert 5 — QA / Governance Reviewer

**Findings**

| # | Finding |
|---|---|
| 1 | ⭐⭐ **`SRCHAL-A5` — the subject declares its own Stage-3 blockers.** §42 marks `SRCH-GAP-002`, `003` and `007` as blocking Stage 3, and §42's preamble states *"Every item below is recorded, owned and unresolved. None is answered by invention."* A document that disqualifies itself is passing the honesty test the gate depends on. |
| 2 | ⭐⭐ **`SRCHAL-A6` — `SRCH-GAP-004` is the verified discharge of a routing instruction.** `XPC-OD-009` (C0 **L427**, `ADR-0098` **L221**) instructed that keyword stuffing be *"recorded against `PRD-015`"*. It is — with named owners and an explicit "blocks nothing in V1". ⭐ **A routed open decision was actually collected**, which is rarer than routing one. |
| 3 | ✅ **Traceability is total**: 78 obligations ↔ 78 acceptance criteria, positional and complete; the subject's own §44 register reports `SRCH-GAP-*` 9 of 9 with ✅ no gaps. |
| 4 | ✅ **Registry honesty**: `SRCH-GAP-001` discloses that `PRD_REGISTRY.md` **L315** still reads `PLANNED`, and R9 in §41 names *"this draft being mistaken for conferred status"* as a risk the document mitigates in its own header. |
| 5 | ✅ **Validator baseline unchanged**: 31 checkers, 25 PASS / 6 FAIL, the identical pre-existing set; **0 checkers altered** (§10.1). |
| 6 | ⭐ **`ADR-0088`/`0089`/`0090` remain 0 files each** — the `PRD-021B` reservation is intact, and **0 ADR numbers were consumed** by this review (§10.4). |

**Concerns**

- ⚠⚠ **The conferral hole is structural, not incidental.** `PRD_LIFECYCLE.md` **L283**: *"Every PRD needs a
  named owner. **None has one**."* With `PGA-08` unassigned, **no Stage-3 record in this repository can be
  conferred** — this one included. Recorded as condition **C7** (§11.5), the root condition.
- ⚠ **This record is not monitored for drift.** `PRD-015` is deliberately absent from
  `alignment_record_freshness.py`'s `RECORDS` (§2.2), so no gate will notice if the subject changes. The
  remedy is a **supplement** (the `PRD-008` V17 pattern), never an in-place edit.
- ⚠ `PRD_REGISTRY.md` **L1429** carries a now-stale line (*"⛔ Does not create `PRD-015`… with no document
  on disk"*). It **pre-dates** the subject and the registry is **append-only**, so ⛔ it was **not** edited.
  Disclosed for the Governance Owner.

**Conflicts** — ⚠ **2 raised** (§9), and **0 resolved by this review**, per `DOCUMENTATION_BASELINE.md` §4.

**Verdict — ⚠ CONDITIONAL PASS.** Governance discipline is high and the audit trail is complete, but Stage 3
is ⛔ **NOT CONFERRABLE** by any acting role. ⛔ No freeze, baseline, rank or approval performed.

### 14.6 Expert panel summary

| Expert | Findings | Concerns | Conflicts | Verdict |
|---|---|---|---|---|
| 1 — Product / Requirements | 5 | 3 | ⚠ 1 (`SRCHAL-R1`) | ✅ **PASS** (⚠ conditional on 2 product-owner gaps) |
| 2 — Enterprise / Domain Architect | 5 | 2 | ⚠ 1 (`SRCHAL-R2`) | ✅ **PASS** (Checks 1, 2, 3) |
| 3 — Search / IR Engineer | 6 | 3 | ✅ 0 | ✅ **PASS** (parameters OPEN by design) |
| 4 — Security / Privacy Architect | 7 | 3 | ⚠ 2 (`R1`, `R2`) | ✅ **PASS** (Checks 4, 5, 6) + `SRCHAL-A4` constraint |
| 5 — QA / Governance | 6 | 3 | ⚠ 2 raised, 0 resolved | ⚠ **CONDITIONAL PASS** — ⛔ not conferrable |

⭐ **No expert returned FAIL or BLOCKED.** The binding limitation is **conferral authority**, not alignment.

---
## 15. Findings register

`PRD_LIFECYCLE.md` **L104–L106** makes this section mandatory, not optional:

> **"A rejected finding must be recorded as rejected, with its reason.** The Student Identity review accepted
> 11 of 13 and rejected 2, preserving the draft's intent deliberately. **A review that records only accepted
> findings is indistinguishable from a review that found nothing.**"

### 15.1 Findings — ACCEPTED (consolidated index; detailed in §14)

| ID | Finding | Raised by | Disposition | Section |
|---|---|---|---|---|
| **`SRCHAL-A1`** | `PRD-015` **reduces** duplication risk: before it, `LSD-FR-008`'s demand for an owner-defined query port was unanswerable, and the first consumer to answer would have become a de facto second search authority | Expert 2 | ✅ **Accepted** — favourable to the subject; no action required | §4.4 |
| **`SRCHAL-A2`** | ⭐⭐ No numbered edge names C2/C6/§14A as *consumers* of `BC-23`, yet this is **not** a §7 defect — `AR-1` (composition *through* `BC-23`, not a context), `ADR-0033` §3, and `PRD-008` §3.4's 17-port measurement | Expert 2 | ✅ **Accepted** — **recorded so a later reader does not "fix" it by minting an edge.** ⛔ 0 edges created | §4.3 |
| **`SRCHAL-A3`** | ⭐ `E-21`'s `BC-19` (R4) → `BC-23` (R5) direction is lawful: the pattern cell is `PL` + Event and §7.4 `F-2` routes learning through `liboora_contracts` (R0), so the real dependency is R5 → R0 | Expert 2 | ✅ **Accepted** — with the ⚠ caveat that a *sync read* closure would **FAIL** Check 3 | §5.3 |
| **`SRCHAL-A4`** | ⚠⚠ `PRD-015` contains **zero** `BC-18` occurrences while attributing visibility to *"the source system's authorisation"*. Not a Check-4 failure, but a local-evaluation closure would be *"a security defect that passes its own tests"* | Expert 4 | ✅ **Accepted** — ⭐ **constraint recorded for the owner: `SRCH-GAP-003`'s closure must place the policy decision in `BC-18`.** ⛔ Gap **not** closed; ⛔ no ADR required (no named reviewer exists) | §6.2 |
| **`SRCHAL-A5`** | ⭐⭐ The subject **declares its own Stage-3 blockers** (§42: `SRCH-GAP-002`/`003`/`007`) | Expert 5 | ✅ **Accepted** — **this is what makes the verdict CONDITIONAL rather than PASS** | §11.2 |
| **`SRCHAL-A6`** | ⭐⭐ `SRCH-GAP-004` is the verified **discharge of `XPC-OD-009`**'s routing instruction (C0 **L427**, `ADR-0098` **L221**) | Expert 5 | ✅ **Accepted** — a routed open decision was actually collected. ⛔ Remains OPEN | §13.1 |

**6 accepted.** ⭐ Note that **four of the six are favourable to the subject** — `A1`, `A2`, `A3`, `A5`/`A6`
record *why apparent defects are not defects* and *why the document's honesty is a strength*. Only `A4`
imposes a forward constraint, and even that is addressed to a gap's owner rather than to the document.

### 15.2 ⭐⭐⭐ Findings — REJECTED, with reasons

Each of the five below was a **genuine candidate defect** produced by a literal reading of a Rank-4
authority. Each would have returned **FAIL** on a correct document. Each is recorded with the evidence that
defeated it, so that a future reviewer does not re-raise it as new.

| # | Rejected finding (as it would have been written) | Which check it would have failed | ⛔ Reason for rejection |
|---|---|---|---|
| **`SRCHAL-X1`** | *"`PRD-015` cites `E-27`, which does not exist in BC Map §7. Per L292, **an edge not in the table does not exist** ⇒ **FAIL Check 2**."* | Check 2 | ⛔ **Rejected — the citation asserts the edge's *absence*, not its use.** BC Map **L870–L875** states the 29-edge set *"with `E-27` a deliberate gap that records a withdrawal"*, and the subject cites **L874**, inside that block. ⭐ **A reference to a thing's absence is not a use of that thing** — the identical disposition `PRD-021C`'s Stage-3 record reached for 21 such mentions. |
| **`SRCHAL-X2`** | *"The V1 consumers (C2, C6, §14A discovery) **query** `BC-23`, but no §7 row names them as consumers. A cross-context read with no edge ⇒ **FAIL Check 2**."* | Check 2 | ⛔ **Rejected on three independent authorities.** (1) `AR-1` (Rank 4) rules Library Discovery is **not a bounded context** and *"composes… **through `BC-23`**"* — a read composition cannot cross a *context* boundary. (2) `ADR-0033` §3 (Accepted): L292 *"governs **edges**. It does **not** state that every cross-context read must be an edge."* (3) `PRD-008` §3.4 measured **14 of 17** ports with no numbered edge, **including `identity.policy_decision`** — the authorisation port Check 4 requires of every context. ⭐ *"A reading that invalidates the gate's own prerequisite is the wrong reading."* Accepted instead as `SRCHAL-A2`. |
| **`SRCHAL-X3`** | *"`E-21` has `BC-19` (Rank **4**) depending on `BC-23` (Rank **5**) — upward. `L2` permits dependence only on lower ranks ⇒ **FAIL Check 3**."* | Check 3 | ⛔ **Rejected — the pattern cell was not read.** `E-21`'s pattern is **`PL` + Event**, not `CF`, and §7.4 rule **`F-2`** routes capability learning through **`liboora_contracts` (Rank 0)**. The real dependency is R5 → R0, **downward**. ⚠ **This rejection is conditional and the condition is recorded**: had the subject specified a *synchronous read* rather than `SRCH-FR-004`'s event projection, the finding would have been **accepted as a FAIL**. Accepted instead as `SRCHAL-A3`. |
| **`SRCHAL-X4`** | *"`PRD-015` never mentions `BC-18` — **zero** occurrences — while deciding what a caller may see. Authorisation outside `BC-18` ⇒ **FAIL Check 4** (`X-13`)."* | Check 4 | ⛔ **Rejected — the subject decides no authorisation.** §27 states the platform's authorisation model *"is **not** `BC-23`'s to define"*, `BC-23` *"**consumes** the source system's decision"*, and the mechanism is routed to **`SRCH-GAP-003`** with *"⛔ It is not invented here."* ⭐ **A check cannot fail on a decision nobody took.** The residual risk is real and was **kept** — as the forward constraint in `SRCHAL-A4` — but it is a constraint on a *future closure*, not a defect in the *current text*. |
| **`SRCHAL-X5`** | *"§42 declares three gaps blocking Stage 3 ⇒ the review should return **BLOCKED**, since a required authority is absent."* | Overall verdict | ⛔ **Rejected — `BLOCKED` is the wrong class.** Per §1.2, `BLOCKED` means *a required authority is absent so the check cannot be answered*. All six checks **were** answerable and **were** answered by measurement against Ranks 1–5. What is absent is **owner decisions for closure** and **conferral authority** — which is precisely the definition of ⚠ **CONDITIONAL**. ⭐ Returning `BLOCKED` would have discarded six valid measurements; returning `PASS` would have concealed three owner decisions. **CONDITIONAL is the only honest class.** |

**5 rejected, each with its reason and its defeating evidence.**

### 15.3 Why this register is the load-bearing part of the record

⭐⭐ **Four of the five rejected findings are `FAIL` verdicts that a mechanical reading would have produced**
— `X1` from a token census, `X2` from an edge-table lookup, `X3` from a rank comparison, `X4` from a
string count. Each was defeated only by reading a *second* authority: `AR-1`, `ADR-0033` §3, the `E-21`
pattern cell, and §27's own refusal.

⚠ **And the rejections are not unconditional.** `X3` is explicitly reversible if `SRCH-FR-004` ever becomes
a synchronous read, and `X4`'s residual risk was **retained** as `SRCHAL-A4` rather than dismissed. ⭐ A
rejection that records the condition of its own reversal is auditable; one that does not is an opinion.

---

## 16. ⛔ What this record does NOT do

| # | ⛔ Not done | Evidence |
|---|---|---|
| 1 | **Does not confer Stage 3** | §2, §11.2 — the conferring role is unassigned (`PGA-08`, `PRD_LIFECYCLE.md` **L283**). The word CONFERRED is never used of this verdict |
| 2 | **Does not enter Stage 4 or Stage 5** | Stage 4 is a requirements review under a different gate by a separate authority |
| 3 | **Does not freeze, baseline, rank or approve** | `PRD-015` remains **`PLANNED`** (`PRD_REGISTRY.md` **L315**) and **unranked** (`DOCUMENTATION_BASELINE.md` §3 has no `PRD-015` row) |
| 4 | **Creates no `IMPL-*` identifier** | 0 created (§10.3) |
| 5 | **Changes no application code** | 0 files under `lib/ test/ web/ android/ ios/ tool/ .github/` (§10.4) |
| 6 | **Alters no requirement of the subject** | `PRD-015` is byte-identical to `fe3093e6…c2c4544` |
| 7 | **Modifies no frozen or baselined document** | §14A, `PRD-021A/B/C`, `PRD-014/016/017/020`, `Student_Identity_PRD_v1.md` — all unchanged (§9.4) |
| 8 | **Consumes no ADR number, and creates no ADR** | `ADR-0088`/`0089`/`0090` remain **0 files each** — the `PRD-021B` reservation is intact (§10.4). ⛔ No ADR was required: the ADR-requiring power (**L277**) belongs to a *named* reviewer |
| 9 | **Invents no edge, event or bounded context** | 29 edges and 31 contexts, Δ = 0 (§10.4). `SRCHAL-A2`/`X2` record *why* no edge was minted |
| 10 | **Invents no rank value and reranks nothing** | Ranks were read from the Dependency Matrix §3 (§5.1) |
| 11 | **Invents no owner and no owner decision** | ⛔ `OWNER NOT ESTABLISHED` written for `SRCH-GAP-008` (§13.2) |
| 12 | **Closes no gap** | 9 preserved, 0 closed (§13.1) |
| 13 | **Resolves neither raised conflict** | `SRCHAL-R1`, `SRCHAL-R2` raised only (§9), per `DOCUMENTATION_BASELINE.md` §4 |
| 14 | **Invents no threshold, score, weight, formula or percentage** | §12.4 — every OPEN parameter preserved OPEN |
| 15 | **Alters no checker** | ⛔ `PRD-015` deliberately **not** added to `alignment_record_freshness.py`'s `RECORDS` (§2.2, §10.2) |
| 16 | **Edits no registry or baseline row** | Both are append-only / owner-governed; the stale `PRD_REGISTRY.md` **L1429** line is **disclosed, not edited** (§14.5) |
| 17 | **Modifies no earlier alignment record** | `PRD-019`'s missing anchor is **reported** (§10.2), not repaired — that is its owner's act |

---

## 17. Change history

| Version | Date | Change | Commit |
|---|---|---|---|
| **v0.1** | 2026-09-03 | Stage 3 Architecture Alignment Review of `PRD-015` v0.1 at `fe3093e6…c2c4544`. Six lifecycle checks measured (6 PASS / 0 FAIL / 0 BLOCKED); flexible-search and ranking-separation architecture verified; 6 findings accepted, **5 rejected with reasons**, **2 Rank-3 conflicts raised**; 9 gaps preserved, 0 closed. Verdict: ⚠ **CONDITIONAL PASS — measured, ⛔ NOT CONFERRED** | *this commit* |

⚠ **Amendment rule for future readers:** if `PRD-015` changes, this record becomes **stale**, and no
automated gate will report it (§10.2). The remedy is a **supplement** in the `PRD-008` V17 pattern —
⛔ **never an in-place edit of these findings**, which would destroy the audit trail this record exists to
create.

---

**END OF `PRD-015` STAGE 3 ARCHITECTURE ALIGNMENT RECORD**

⚠ **CONDITIONAL PASS — MEASURED, NOT CONFERRED** · ⛔ Stage 4 **NOT ENTERED** · ⛔ Implementation IDs
**NOT CREATED** · ⛔ Freeze / Baseline **NOT PERFORMED**
