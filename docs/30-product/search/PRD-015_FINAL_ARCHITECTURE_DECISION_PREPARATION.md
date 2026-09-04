# `PRD-015` — FINAL ARCHITECTURE DECISION PREPARATION

| Field | Value |
|---|---|
| **Document** | `PRD-015_FINAL_ARCHITECTURE_DECISION_PREPARATION.md` |
| **Version** | **v1.0** |
| **Date** | 2026-09-03 |
| **Subject** | [`PRD-015_SEARCH_INDEXING.md`](PRD-015_SEARCH_INDEXING.md) — sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` |
| **Supplements** | [`PRD-015_ARCHITECTURE_OWNER_DECISION_PACKET.md`](PRD-015_ARCHITECTURE_OWNER_DECISION_PACKET.md) (`94d78bb`) — **appended to, never edited** |
| **Type** | **Decision-preparation record.** It audits authority, identifies compatible options, recommends the **smallest** compatible one, and states tradeoffs |
| **Act** | 🔍 **PREPARATION.** ⛔ **Not** a PRD · **not** an ADR · **not** an approval · **not** an ARB ruling · **not** a freeze · **not** a baseline · **not** a conferral |
| **Decision authority exercised** | ⛔ **NONE.** Recommendations are **recommendations**. **0** decisions are taken |
| **Approvals asserted** | ⛔ **None.** No Architecture Owner approval, ARB ruling, Security review or Privacy review is claimed |
| **ADRs created / Accepted** | ⛔ **Zero.** `ADR-0088` / `ADR-0089` / `ADR-0090` remain **RESERVED and UNWRITTEN**. No ADR number is invented |
| **Values invented** | ⛔ **Zero.** No engine, library, analyzer, stemmer, transliteration, edit distance, token length, prefix length, latency, throughput, availability, rebuild duration, API, RPC, endpoint, event, port name, edge ID or vocabulary pair |
| **Benchmarks performed** | ⛔ **NONE.** No measurement of any candidate technology was made. Nothing in §4 is a benchmark result |
| **Conferral** | ⛔ **TEMPLATE ONLY** (§13). ⛔ A blank approval form is **not** a conferral |
| **Final status** | ⚠ **STAGE 3 REMAINS CONDITIONAL / NOT CONFERRED** |

> ⚠⚠ **READ THIS FIRST — WHY THIS SUPPLEMENT EXISTS AND WHAT IT CHANGES.**
>
> The prior packet (`94d78bb`) reported **P1, P7 and ENT** as open-ended architecture gaps with **no repository
> authority**. This pass audited **`MASTER_PRD.md` §10**, **`tool/module_dependencies.yaml`**, **Dependency Matrix
> §2/§5/§10.3** and **`Library_PRD_v1.md` §20** — four sources the earlier passes did not open — and **three of
> those reports are now materially wrong in the direction that matters: authority EXISTS where the packet said
> it did not.**
>
> ⭐⭐⭐ **The single most important correction: `platform/search` HAS a module block.** All three prior records
> state that **no `search:` module block exists**. It exists, at `tool/module_dependencies.yaml` **L373**, in the
> **machine-enforced** manifest whose violations *fail the build*. That block already carries the assertion
> **`SE-2` — *"every index write carries a permission scope"*.** The write-side half of `ENT` is therefore not a
> gap at all; it is **already enforced law**.
>
> ⭐⭐⭐ **The second correction: naming a search engine in `PRD-015` would be UNLAWFUL, not merely premature.**
> Rank 1 `MASTER_PRD.md` **L219** and **`MP-CON-01`** make the stack *vendor-neutral by construction*; Dependency
> Law **L3** bars vendor names from domain code; **`MP-CON-02`** rules that choosing an implementation is
> *"a **deployment decision, not an architecture decision**."* **P1 was mis-framed by every prior pass, including
> mine.** The lawful architecture decision is *which abstraction must exist*, not *which product to buy*.
>
> ⭐⭐ **The third correction: `P7` is a ROUTING question that is already answered, and answering it with numbers
> would violate a FROZEN requirement.** `Library_PRD_v1.md` **L862-864** `LIB-20.1`: *"Platform-wide NFR budgets
> **MUST** be taken from the Enterprise Architecture NFR Budgets document. This PRD **MUST NOT** state a competing
> latency or availability figure."*
>
> **Net effect: 4 of 12 items move from *"decision required"* toward *"reuse existing authority"*, and the number
> of genuinely open human decisions falls from 14 to 9.** That is a reduction achieved by **measurement**, not by
> approving anything.

---

## 1. Repository audit — six findings, four of them corrections

### 1.1 Git pre-checks (instruction §1 / §24)

| Check | Result |
|---|---|
| `git status --short` | ✅ clean (before this file) |
| `git rev-parse HEAD` | `94d78bb6f0ad59b1860584b88649a3b595f8a5cc` |
| `git rev-parse github/main` | `94d78bb6f0ad59b1860584b88649a3b595f8a5cc` |
| Parity | ✅ `0 0` |
| Subject sha256 | ✅ `fe3093e6…c2c4544` — **unchanged** |

### 1.2 The six findings

| # | Finding | Evidence | Consequence |
|---|---|---|---|
| **H-1** | ⭐⭐⭐ **The stack is vendor-neutral BY LAW, and naming an engine in a PRD is a violation.** Rank 1 `MASTER_PRD.md` **L219**: *"The approved Enterprise Architecture v2.1 is **vendor-neutral by construction**. It names no database, no backend-as-a-service and no AI provider."* **`MP-CON-01`** (**L237**): *"No vendor name may appear in domain code. Vendors live behind ports."* **`MP-CON-02`**: *"Choosing a BaaS for V1 is a **deployment decision, not an architecture decision.**"* **`MP-CON-03`**: *"The Data Layer must remain abstract."* Dependency Law **L3** (Matrix **L50**): *"Domain code contains no vendor name, no SDK import, no HTTP client, **no SQL**."* | Matrix **L50**; `MASTER_PRD.md` **L219**, **L226**, **L237-239** | ⛔ **`P1` as posed — *"choose a search engine"* — is not an Architecture Owner decision this repository permits a PRD to record.** The lawful decision is the **abstraction**. See §4 |
| **H-2** | ⭐⭐⭐ **`platform/search` HAS a manifest block — the prior "no `search:` block" finding is FALSE.** `tool/module_dependencies.yaml` **L373-384**: `rank: 5`, `imports: [contracts]`, `consumes_events: ["*"]`, `banned_imports: ["domain/**", "app/**"]  # X-08`, and two assertions — **`SE-1`** *"every index name is tenant-prefixed"* (`X-13`) and ⭐⭐ **`SE-2`** *"every index write carries a permission scope"* | `tool/module_dependencies.yaml` **L373-384** | ⭐⭐ **The write-side of `ENT` is ALREADY LAW and already mechanically enforced.** What is missing is only the **query-side** consumption declaration. See §11 |
| **H-3** | ⭐⭐⭐ **`SEARCH → IDENTITY` is ALREADY PERMITTED — no exception, no edge, no ADR needed for lawfulness.** Matrix §5 grid: row **`R5 SEARCH`** × column **`IAM`** = **`◇`** (*"port (no import)"*). Ranks: `platform/search` = **5**, `platform/identity` = **4** (manifest **L38**, **L36**) ⇒ **strictly downward ⇒ Dependency Law `L2` satisfied.** ⛔ Law `L4` is not engaged (identity is not a domain module) | Matrix §5 grid; manifest **L36**, **L38** | ⭐⭐⭐ **`ENT` collapses from an architecture question to a DECLARATION question.** The dependency is lawful today; it is simply **undeclared**. See §11 |
| **H-4** | ⭐⭐ **`P8`'s approach is ALREADY ESTABLISHED by name.** Matrix **L357** `X-08` forbids *"`SEARCH → domain repository` for indexing"* (*"Reindex by scanning the table"*) and names the remedy: ⭐ **"Event-driven index + explicit `Index Backfill Job`."** Reinforced mechanically — `platform/search.banned_imports: ["domain/**"]  # X-08` and `consumes_events: ["*"]`. EA **L1536** carries `Index Backfill Jobs (V2)` | Matrix **L357**; manifest **L378-379**; EA **L81**, **L1536** | ⭐⭐ **`P8` Option A (incremental-first + backfill for recovery) is the repository-established approach**, not a candidate. Only the **duration** and the **availability posture** remain open. See §10 |
| **H-5** | ⭐⭐⭐ **`P7` is a ROUTING question, and stating numbers in `PRD-015` would violate a FROZEN requirement.** `Library_PRD_v1.md` **L862-864** **`LIB-20.1`** (FROZEN, Rank 3): *"Platform-wide NFR budgets **MUST** be taken from the Enterprise Architecture NFR Budgets document. **This PRD MUST NOT state a competing latency or availability figure.**"* Rank 1 **`MP-NFR-01`** assigns availability targets to **SRE / OBSERVABILITY**, not to a module PRD. ⛔ **And the NFR Budgets document DOES NOT EXIST** — `find docs/ -iname "*NFR*"` returns only `PRD-001`'s own §11 chapter; EA **L339** lists `NFR Budgets (V1)` as a *planned node*; `PRD-023`'s baseline row names *"NFR Budgets"* among its **five hard-external blockers** | `Library_PRD_v1.md` **L862-864**; `MASTER_PRD.md` **L483**, **L491**; EA **L69**, **L339**; `DOCUMENTATION_BASELINE.md` **L191** | ⛔ **The recommendation is NOT a set of numbers — it is that `PRD-015` must NOT carry numbers**, and that the missing NFR Budgets document must be commissioned. See §9 |
| **H-6** | ⭐ **A precedent FORM for per-function targets exists, so nothing needs inventing when the owner does act.** `Student_Identity_PRD_v1.md` §5 **L1178-1192** publishes a p95/p99 table per operation plus a degradation rule; `PRD-001` **§11.3** publishes availability as **99.9% / 99.95% monthly** with an explicit rationale (*"session validation and authorization are held to a higher target than sign-in"*) | `Student_Identity_PRD_v1.md` **L1178-1192**; `prd-v2/11-NFR-…` **L64-72** | ⭐ When the NFR Budgets owner acts, the **shape** is settled by precedent. ⛔ No figure is transplanted here |

### 1.3 Measured absences (re-verified this pass, excluding my own records)

| Query | Scope | Result |
|---|---|---|
| `elasticsearch\|opensearch\|lucene\|solr\|meilisearch\|typesense\|algolia` | `docs/` `tool/` minus `PRD-015_*` | ⛔ **0 files** |
| `pg_trgm\|tsvector` | `docs/` `tool/` minus `PRD-015_*` | ⛔ **0 files** |
| `postgres` | `docs/` `tool/` minus `PRD-015_*` | ⚠ **2 files** — `MASTER_PRD.md` **L226** (*"Managed PostgreSQL … **Not named in EA — candidate only**"*) and an **archived** guide **L639** which states *"A grep for `supabase\|postgres\|…` across the architecture returns zero. Only Firebase Cloud Messaging (V1) and Firebase Crashlytics (V1) are named."* ⇒ **candidate, explicitly NOT authority** |
| `levenshtein\|edit.distance\|damerau\|fuzziness\|jaro\|soundex\|metaphone` | `docs/` `tool/` minus `PRD-015_*` | ⛔ **0 hits** — `P3` has no authority |
| `minimum prefix\|prefix length\|min_prefix` | `docs/` `tool/` minus `PRD-015_*` | ⛔ **0 hits** — `P4` has no authority |
| `synonym\|abbreviation` | `docs/` `tool/` minus `PRD-015_*` | ⛔ **0 authoritative** — BC Map **L844** is a *prohibition*; EA **L1527** a *V3 tag*; EA **L2436** a *style rule* — `VOC` has no authority |
| `p95\|p99` numeric | `docs/` | ⚠ **2 hits, both `Student_Identity_PRD_v1.md`** (**L1188-1189**) — that module's own budget, ⛔ **not a search target** |
| `platform/search` in `provides_ports.policy_decision.consumers` | manifest **L443-444** | ⛔ **0** — consumers are `[domain/library, domain/social, platform/ai, platform/analytics, platform/workflow]` |

---

## 2. The registered `P1`–`P8` — reproduced verbatim, 0 relabelled

⛔ **These meanings are the repository's, from `PRD-015` §36 L833-842. This document does not redefine one of them.**

| ID | Registered meaning (verbatim) |
|---|---|
| **P1** | Search engine / index technology selection (§0.3) |
| **P2** | Analyzer, tokenizer and normalization rule configuration (`SRCH-FR-023`/`024`) |
| **P3** | Edit-distance bound and minimum token length (`SRCH-BR-012` C2/C3) |
| **P4** | Minimum prefix length (`SRCH-FR-030`) |
| **P5** | Maximum page size cap (`SRCH-FR-039`) |
| **P6** | Acceptable projection lag per event class except `SEV-9` (§32) |
| **P7** | Query latency, throughput and availability targets |
| **P8** | Rebuild availability posture and duration (§34) |

**Owner line (§36 L844): Architecture Owner.**

---

## 3. Final recommendation matrix (instruction §18)

⛔ **`Recommended` means *recommended*. Nothing in this column is approved.**

| Decision | Recommended | Evidence | Confidence | Human approval needed |
|---|---|---|---|---|
| **P1** | ⭐ **Do NOT name an engine in `PRD-015`. Declare the required *capability behind an abstraction*, and record engine choice as a deployment decision** — the `MP-CON-02` shape | `MASTER_PRD.md` **L219**, **L226**, **L237-239**; Matrix **L50** (`L3`); manifest **L373** | **HIGH** *(on the posture)* | **YES** — to confirm the posture and to authorise the capability statement |
| **P2** | ⭐ **An application-level normalization layer owned by `BC-23`, engine-independent** — because `SRCH-BR-008` demands symmetry+totality regardless of engine, and `H-1` forbids binding the PRD to an engine's analyzer | `PRD-015` **L426-428**, **L419-424**; `MASTER_PRD.md` **L237** | **MEDIUM-HIGH** | **YES** — plus 3 sub-decisions (§5) |
| **P3** | ⛔ **No value recommended.** Three policy classes presented (§6) | ⛔ **0 hits** repo-wide | ⛔ **NONE** | **YES** |
| **P4** | ⛔ **No value recommended.** Three policy classes presented (§7) | ⛔ **0 hits** repo-wide | ⛔ **NONE** | **YES** |
| **P5** | ✅ **Existing authority — `LCFG-12` = 20, range 5–50, owner Security.** ⛔ Not changed, ⛔ not duplicated | `CONFIGURATION_GUIDE.md` **L362**, **L804** | **HIGH** | ⛔ **NO** *(traceability act only — §8)* |
| **P6** | ✅ **Existing authority — `LCFG-6` = 60 s, range 0–300 s, owner Security, removal latency ONLY.** ⛔ Not reinterpreted | `CONFIGURATION_GUIDE.md` **L356**; `Library_PRD_v1.md` **L721**, **L727** | **HIGH** | ⛔ **NO** *(traceability act only — §8)* |
| **P7** | ⭐⭐ **`PRD-015` MUST NOT state figures (`LIB-20.1`). Route to the NFR Budgets document — which must first be commissioned, because it does not exist** | `Library_PRD_v1.md` **L862-864**; `MASTER_PRD.md` **L483**, **L491**; EA **L339** | **HIGH** *(on the routing)* | **YES** — to confirm routing + commission the document |
| **P8** | ⭐⭐ **Option A — event-driven incremental indexing, with an explicit `Index Backfill Job` for recovery/rebuild.** Already repository-established | Matrix **L357** (`X-08`); manifest **L378-379**; EA **L1536**; BC Map **L453** | **HIGH** *(approach)* / ⛔ **NONE** *(duration)* | **YES** — for **posture + duration only**; the approach needs confirmation, not invention |
| **ENT** | ⭐⭐⭐ **Reuse the existing `identity.policy_decision` port. Two declarations only — no new port name, no new API, no new edge** | Matrix §5 `R5 SEARCH`×`IAM` = `◇`; manifest **L36**, **L38**, **L443-444**, **L381-384**; amendments `A-2`/`A-3` | **HIGH** | **YES** — a manifest amendment is an Architecture Owner act |
| **EDGE** | ⭐⭐ **No new BC edge appears to be required** — ports are not edges (`ADR-0033`; **14 of 17** `library_management` ports have no usable numbered edge). ⛔ Confirmation still required | BC Map **L292**; `ADR-0033`; `PRD-008` **L879**; `ADR-0035` **L238** | **MEDIUM-HIGH** | **YES** — to confirm; ⛔ **no edge ID proposed** |
| **VOC** | ⭐ **DEFER V4 for V1.** V1/V2/V3 do not depend on a declared table; `SRCH-FR-031` V4 is already *"only where declared"* | `PRD-015` **L542**, **L552-553**; ⛔ 0 authority; EA **L1527** = V3 | **MEDIUM-HIGH** | **YES** — Product Owner *(one line)* |
| **R1** | ⭐ **KEEP LATENT until student discovery is enabled**, and make the `SID-4.40` ÷ `LCFG-6` reconciliation a **precondition** of enablement | `Student_Identity_PRD_v1.md` **L939-953**; `PRD-015` **L511-525**; `LIB-16.9` **L727** | **HIGH** | ⛔ **NO** *(recommendation; activation is a later act)* |
| **R2** | ⭐ **KEEP LATENT. `BC-13` remains the Trust & Safety authority.** A step-[3] hook is required **before** any ranking/recommendation enablement, not now | `PRD-020` **L550-568**; `PRD-015` **L578-590** | **HIGH** | ⛔ **NO** *(recommendation; `BC-13` co-owns activation)* |

---

## 4. `P1` — Search engine / index technology selection

### 4.1 What the search returned

| Query | Result |
|---|---|
| `elasticsearch` `opensearch` `lucene` `solr` `meilisearch` `typesense` `algolia` | ⛔ **0 files** outside my own records |
| `pg_trgm` `tsvector` `tsquery` | ⛔ **0 files** outside my own records |
| `postgres` `postgresql` | ⚠ **2 files, both explicitly non-authoritative** (§1.3) |
| *"any internal indexing abstraction"* | ⭐ **FOUND** — `platform/search:indexer` (4 declarations) and `search.retrieval` (1), plus the `platform/search` block itself |
| *"any existing search service"* | ⭐ **FOUND** — `platform/search`, rank 5, `BC-23`, with assertions `SE-1`/`SE-2` |

### 4.2 ⭐⭐⭐ The decisive finding — `P1` is mis-framed, and this must be said before any option is listed

`P1`'s registered wording is *"Search engine / index technology selection."* Measured against Rank 1 authority,
**a `BC-23` PRD may not record that selection at all**:

| Authority | Rank | Text | Effect on `P1` |
|---|---|---|---|
| `MASTER_PRD.md` **L219** | **1** | *"vendor-neutral **by construction**. It names no database, no backend-as-a-service and no AI provider"* | An engine name in `PRD-015` contradicts the platform posture |
| **`MP-CON-01`** **L237** | **1** | *"No vendor name may appear in domain code. **Vendors live behind ports**, wired at the composition root"* | The lawful artefact is a **port**, not a product |
| ⭐⭐ **`MP-CON-02`** | **1** | *"Choosing a BaaS for V1 is a **deployment decision, not an architecture decision**. It must not collapse the 25 approved platforms into a vendor's feature list"* | **Engine choice is explicitly classified as NOT an architecture decision** |
| **`MP-CON-03`** | **1** | *"The Data Layer must remain **abstract** so a dedicated backend can replace direct BaaS access later"* | Replaceability is a requirement, so the PRD must not bind to one engine |
| Dependency Law **`L3`** (Matrix **L50**) | **4** | *"Domain code contains no vendor name, no SDK import, no HTTP client, **no SQL**"* | Even *"PostgreSQL FTS"* as a PRD-level answer leaks an implementation into a specification |
| `MASTER_PRD.md` **L226** | **1** | Persistence → `data.repository` port → *"Managed PostgreSQL"* → **"Not named in EA — candidate only"** | ⭐ The repository's **own** pattern for a technology: **capability + abstraction + candidate**, never *"approved engine"* |

> ⭐⭐⭐ **THEREFORE, THE RECOMMENDED FORM OF THE `P1` DECISION IS NOT A PRODUCT NAME.**
>
> It is: **declare the search capability behind the abstraction that already exists** —
> `platform/search:indexer` (write side) and `search.retrieval` (read side) — **and record any engine as a
> *candidate implementation behind that port*, exactly as `MASTER_PRD.md` **L226** does for persistence.**
>
> This is the **smallest compatible architecture** the instruction asks for: it introduces **no new system**,
> **no new port name**, **no new module**, and **no vendor into a specification**.

### 4.3 ⛔ Why no engine is recommended — three independent reasons

| # | Reason |
|---|---|
| **1** | ⛔ **It would be unlawful for this document to make that choice** (§4.2). `MP-CON-02` classifies it as a **deployment** decision; a Stage-3 preparation record has no deployment authority |
| **2** | ⛔ **No benchmark was performed.** Instruction §9: *"Do not claim a benchmark was performed if it was not."* **No candidate was measured, installed, queried or profiled.** Any capability statement in §4.4 is a *documented vendor claim*, not a repository measurement |
| **3** | ⭐⭐ **The usual selection criterion is INVERTED here, and this is easy to get wrong.** `PRD-015` **L597-600**: *"There is no numeric relevance score in this model, and that is deliberate… weights are not authorised (`SRCH-XC-009`)."* `SRCH-FR-035` fixes ordering as **tier → field precedence → stable tiebreak**. ⇒ An engine cannot be selected for *scoring quality*; its scoring must be **suppressible and overridable**. A benchmark-driven ranking comparison would select on the **wrong axis** |

### 4.4 Candidate classes — for the deployment decision, ⛔ NOT approved, ⛔ NOT benchmarked

⚠ **Classes, not products.** *"Existing repo support"* means **declared authority**, not *"is it popular."*

| Candidate class | Existing repo support | Hindi / Devanagari | Typo support | Prefix | Operational fit | Duplication risk | Verdict |
|---|---|---|---|---|---|---|---|
| **A — Relational full-text capability of the primary datastore** *(the `data.repository` implementation)* | ⚠ **Closest to existing** — `MASTER_PRD.md` **L226** names a managed relational store as the V1 persistence *candidate*; `Primary Database (V1)` at EA **L2071** | ⚠ **Vendor-dependent; unverified here.** Unicode collation is typically available; script-aware analysis typically weaker | ⚠ Typically requires an extension or an app-level layer | ⚠ Typically prefix-capable | ⭐⭐ **Best — introduces NO new runtime component** | ⭐⭐ **Lowest — no second system** | ⛔ **NOT APPROVED.** ⭐ **Smallest** by component count. ⚠ `X-08` bars `BC-23` from reading domain tables, so co-location must not become table-scanning — the index stays a **separate, event-fed store** even if the same engine hosts it |
| **B — Dedicated search engine as a separate runtime component** | ⛔ **0 authority.** EA **L1516-1560** describes search *capabilities*, names **no product** | ⚠ Typically strongest script/analyzer support | ⚠ Typically native | ⚠ Typically native | ⚠ **New component**: deploy, secure, monitor, back up, patch, tenant-isolate | ⚠⚠ **Highest** — a second data store to keep consistent; `SRCH-INV-005` rebuildability becomes materially harder | ⛔ **NOT APPROVED.** ⚠ Largest operational and governance surface |
| **C — Application-level index built on primitives already declared** | ⭐ **Highest fit with `platform/search`** — `imports: [contracts]`, `consumes_events: ["*"]`, `banned_imports: ["domain/**"]` describe exactly this shape | ⭐ **Fully controllable** — the `N1`–`N6` and `SRCH-BR-008` symmetry rules are implemented directly, so Devanagari behaviour is *specified*, not inherited | ⚠ Must be implemented | ⚠ Must be implemented | ⚠ More app code; ⭐ but no new infrastructure | ⭐⭐ **Lowest** | ⛔ **NOT APPROVED.** ⭐⭐ **Best match to `SRCH-FR-035`'s no-score model** and to `SRCH-BR-008`'s symmetry+totality duty |
| **D — Third-party hosted / managed search service** | ⛔ **0 authority** | ⚠ Vendor-dependent | ⚠ Typically native | ⚠ Typically native | ⛔ **Data egress.** Tenant records leave the platform boundary | ⚠⚠ **Highest** + external processor | ⛔ **NOT APPROVED.** ⛔⛔ **Engages the VACANT Privacy Owner** (`PRD_OWNERSHIP_MODEL.md` **L509**) and `X-13` tenant isolation across a trust boundary. ⚠ **Cannot be approved while that office is unfilled** |

### 4.5 Recommendation, risks, and what is required

| Field | Content |
|---|---|
| **RECOMMENDED OPTION** | ⭐ **Adopt the `MASTER_PRD.md` L226 form: declare the capability + the existing abstraction (`platform/search:indexer`, `search.retrieval`); record the engine as a *candidate implementation behind the port*, decided at deployment.** ⛔ **Name no engine in `PRD-015`.** If a candidate must be nominated for planning, **class A or class C** are the smallest; ⛔ **neither is approved and neither was benchmarked** |
| **WHY** | It is the only form that satisfies `MP-CON-01`/`02`/`03` and `L3` simultaneously; it reuses the **already-declared** `platform/search` module and its two ports; it introduces **no new system**; and it leaves `SRCH-FR-035`'s no-score model implementable |
| **RISKS** | **(a)** Deferring the engine leaves `P2`, `P3`, `P4` partially engine-conditioned — mitigated by §5's recommendation to own normalization at application level. **(b)** A later class-B/D choice would raise `X-13` isolation and (for D) Privacy Owner questions **not** resolved here. **(c)** ⚠ Class A risks a future implementer reading *"same engine"* as *"query the domain tables"* — an `X-08` violation; the PRD-level mitigation already exists (`SRCH-FR-005` event-fed indexing) and should be cited explicitly |
| **HUMAN APPROVAL REQUIRED** | ⭐ **YES** — to confirm the *posture* (capability-behind-port, no engine named) and to authorise the capability statement. ⛔ **This document does NOT mark `P1` approved** |

---

## 5. `P2` — Analyzer, tokenizer and normalization rule configuration

### 5.1 What is already closed, and what that leaves

⛔ **The prior packet §5.1 already derived the complete *requirement* set (9 rows). It is not re-derived here.**
This section does the one thing that packet did not: it identifies **who must own the rules**, and shows that the
answer is forced by an existing FROZEN requirement rather than chosen.

| Question | Status entering this pass | Authority |
|---|---|---|
| Which scripts? | ✅ **CLOSED** — English/Latin + Hindi/Devanagari, closed set for V1 | `SRCHPO-1` (`PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L57**) |
| What must normalization *do*? | ✅ **CLOSED** — `N1`–`N6` | `PRD-015` **L416-425** |
| Must it be symmetric and total? | ✅ **CLOSED** | `SRCH-BR-008` **L427-429** |
| May equivalence be *learned*? | ✅ **CLOSED — NO** | `SRCH-BR-011` **L549-550** |
| ⭐ **WHERE do the rules live — in the engine, or in `BC-23`?** | ⛔ **OPEN — this is the actual `P2` architecture question** | see §5.2 |
| Which library / stemmer / analyzer product? | ⛔ **OPEN, and gated on `P1`** — ⛔ nothing proposed | `SRCH-GAP-002` |

### 5.2 ⭐⭐⭐ The decisive finding — `SRCH-BR-008` and `SRCH-FR-023` make engine-owned normalization unverifiable

`SRCH-FR-023` (**L414-415**) requires normalization *"applied **identically** at index time and at query time,
**by the same declared rule set**."* `SRCH-BR-008` (**L427-429**) requires it to be **symmetric and total**, and
states the failure mode explicitly: *"an asymmetric rule … silently makes some indexed documents permanently
unreachable."*

| Requirement clause | What it demands of the *location* of the rules |
|---|---|
| ⭐⭐ *"by the same **declared** rule set"* (`SRCH-FR-023`) | The rule set must be a **declared artefact** — something a reviewer can read. An engine's built-in analyzer behaviour is a **vendor property**, not a declaration the repository holds |
| ⭐⭐ *"symmetric and **total**"* (`SRCH-BR-008`) | **Totality is a proof obligation over the whole rule set.** It can only be discharged against rules that are **enumerable** |
| ⭐ `SRCH-AC-050` (**L1172**) — *"**when each rule is checked** for symmetry"* | ⭐⭐⭐ **The acceptance criterion iterates the rules one by one.** ⇒ The rule set must be **enumerable and individually inspectable** or `SRCH-AC-050` is **untestable** |
| `SRCH-FR-034` determinism (**L578-581**) | Identical query + index + authorisation ⇒ identical order. An engine analyzer upgrade would change normalization **without a repository change** |

> ⭐⭐⭐ **THEREFORE `P2`'s architecture half is decided by an existing FROZEN acceptance criterion, not by taste.**
>
> `SRCH-AC-050` requires *each rule* to be checked. A rule set that is not enumerable in the repository cannot
> satisfy it. ⇒ **The normalization rule set MUST be a declared, `BC-23`-owned artefact.** An engine may
> *execute* it; the engine **MUST NOT be the definition of it**.
>
> ⭐ This also **de-couples `P2` from `P1`** — which matters, because §4 defers `P1`. The rule set can be
> declared and reviewed **before** any engine exists.

### 5.3 The three sub-decisions that remain — ⛔ none decided, ⛔ no value proposed

⭐ **Sub-decision 2 was surfaced by the prior packet (§5.3 row 2) and is reproduced because it is the one with a
genuine correctness-versus-security tension. ⛔ It is not resolved here.**

| # | Sub-decision | Why it cannot be defaulted | Owner |
|---|---|---|---|
| **P2-a** | ⭐ Whether **`N1` case folding** is declared **not applicable** to Devanagari, or is allowed to silently no-op | ⚠ Devanagari is **unicameral**. Under `SRCH-AC-050`'s per-rule check these differ: *"not applicable"* is an auditable declaration; a silent no-op is an **unchecked** rule. ⛔ The distinction is invisible at runtime and only appears in review | Architecture Owner |
| **P2-b** | ⭐⭐ The **ZWJ / ZWNJ policy** (`U+200D` / `U+200C`) under `N6` | ⚠⚠ **Genuine tension, both directions harmful.** `N6` requires removing zero-width characters — but ZWJ/ZWNJ are **meaningful in Indic conjuncts**, so blanket removal may corrupt legitimate Devanagari tokens, while retention permits **invisible-character spoofing** of names. ⛔ Neither limb is a default; ⛔ no policy is proposed | Architecture Owner **+** Security *(spoofing limb)* |
| **P2-c** | Whether **Hinglish** tolerance is validated and enabled in V1, or deferred | `SRCHPO-2`/`3` make it *"permitted, **not required**"*, and `SRCHPO-3` makes *"where technically validated"* **load-bearing** — an implementation that cannot validate it **MUST NOT** claim it. ⛔ No transliteration rule, stemmer or language-detection method is proposed | Architecture Owner |

### 5.4 Recommendation, risks, and what is required

| Field | Content |
|---|---|
| **RECOMMENDED OPTION** | ⭐⭐ **Declare the normalization rule set as a `BC-23`-owned, engine-independent artefact** (`N1`–`N6` over Latin + Devanagari per `SRCHPO-1`), with the engine as **executor, never definition**. ⛔ **No library, stemmer, tokenizer, transliteration rule or language-detection method is proposed.** ⛔ `P2-a`, `P2-b`, `P2-c` are left **OPEN** |
| **WHY** | It is the only location that makes `SRCH-AC-050`'s **per-rule** symmetry check performable and `SRCH-FR-023`'s *"declared rule set"* literally true; it satisfies `MP-CON-01` (§4.2); and ⭐ it lets `P2`'s architecture half close **without waiting on `P1`** |
| **RISKS** | **(a)** ⚠ Application-level normalization must not **diverge** from engine-internal analysis, or `SRCH-BR-008` symmetry breaks in the gap between the two — the mitigation is that the declared rule set is **authoritative** and any engine analysis must be **disabled or made equivalent**, which is a constraint the eventual `P1` choice must satisfy. **(b)** ⛔ `P2-b` left open means Devanagari indexing **cannot be implemented correctly yet** — this is a real V1 schedule risk and is stated rather than hidden. **(c)** More application code than delegating to an engine |
| **HUMAN APPROVAL REQUIRED** | ⭐ **YES** — for the **location** (rule set owned and declared by `BC-23`) **and separately** for `P2-a`, `P2-b`, `P2-c`. ⛔ **This document does NOT mark `P2` approved** |

---

## 6. `P3` — Edit-distance bound and minimum token length

### 6.1 ⛔ Zero authority, and therefore ⛔ zero recommended value

| Query | Scope | Result |
|---|---|---|
| `levenshtein\|edit.distance\|damerau\|fuzziness\|jaro\|soundex\|metaphone` | `docs/` `tool/` minus `PRD-015_*` | ⛔ **0 hits** |
| `minimum token length\|min_token\|token length` | `docs/` `tool/` minus `PRD-015_*` | ⛔ **0 hits** |

`PRD-015` **L572** states it directly: *"`C2`'s minimum length and `C3`'s bound are `SRCH-GAP-002`, owner
Architecture Owner."* ⛔ **No number is invented here, and none is recommended.**

### 6.2 ⭐⭐ What IS closed — and it is more than the prior passes recorded

⭐ **This is `P3`'s useful finding: the *shape* of the answer is fully constrained even though the *value* is
absent. An owner supplying a value has five constraints to satisfy, all pre-existing.**

| # | Constraint on any `P3` value | Source | Consequence for the owner |
|---|---|---|---|
| **C1** | ⛔ **MUST NOT** apply to **exact**-role fields | `SRCH-BR-012` C1; `SRCH-FR-027` | The bound is **per field role**, not global |
| **C2** | ⛔ **MUST NOT** apply below a declared **minimum token length** | `SRCH-BR-012` C2 | ⇒ `P3` is **two** values, not one, and they are **coupled** (§6.3) |
| **C3** | The permitted difference **MUST** be **bounded and uniform across consumers** | `SRCH-BR-012` C3; `SRCH-FR-009`; `SRCH-FR-034` | ⛔ **Rules out per-consumer tuning.** One platform-wide value |
| **C4** | A T3 match **MUST NOT** outrank any T1 or T2 match | `SRCH-BR-012` C4; `SRCH-FR-035` | ⭐ The bound cannot be *"fixed"* later by re-ranking — ordering is already fixed |
| **C5** | ⛔ **MUST NOT** widen authorisation, tenant scope or field eligibility | `SRCH-BR-012` C5 | A larger bound is **never** a security relaxation — this limb is already safe |
| ⭐⭐ **C6** | ⭐ **`SRCH-BR-012`'s own preamble: an implementation that cannot satisfy `C1`–`C5` MUST NOT enable tolerance** | `PRD-015` **L561-562** | ⭐⭐⭐ **THEREFORE `P3` IS NOT A V1 BLOCKER.** T3 typo tolerance is **disableable by an existing FROZEN rule**, and T1/T2 remain fully specified. ⇒ A missing `P3` value **degrades the feature**; it does **not** block the PRD |

> ⭐⭐⭐ **The most important `P3` finding, which no prior pass stated: `SRCH-BR-012`'s preamble already supplies
> the lawful behaviour in the absence of a decision — *do not enable T3*.** `P3` therefore needs a decision to
> **enable** tolerance, not to **avoid breaking**. ⭐ This removes `P3` from the critical path.

### 6.3 ⚠ The coupling that makes a single number wrong

⚠ **The two `P3` values are not independent, and choosing them separately produces a defect.** `PRD-015`
**L569** gives C2's reason: *"short tokens are mutually reachable and matching becomes noise."* ⇒ For any
minimum token length **L** and any distance bound **d**, as **d** approaches **L** the number of tokens mutually
reachable within **d** grows until distinct short words collide. ⛔ **No values for `L` or `d` are proposed, and
no threshold formula is invented** — but an owner setting them **independently** can produce a pair that
satisfies both C2 and C3 in isolation while still violating C2's *stated purpose*.

⭐ **Recommended form of the decision: `L` and `d` are approved as a PAIR, with the noise test performed on the
pair.** ⛔ That is a statement about **procedure**, not about values.

### 6.4 Policy classes — ⛔ OPTIONS ONLY, ⛔ NONE APPROVED, ⛔ NO VALUES

| Class | Posture | Tradeoff | ⚠ Note |
|---|---|---|---|
| **A — Do not enable T3 in V1** | Tolerance off; T1 + T2 only | ⭐⭐ **Requires NO invented value** and is **already lawful** under `SRCH-BR-012`'s preamble | ⭐ **Smallest.** ⚠ `SRCH-FR-033`'s *"reasonable minor misspelling does not produce zero results"* is then **unimplemented** — an honest V1 gap, ⛔ not a violation, because the preamble authorises non-enablement |
| **B — Enable T3 with a conservative pair** | Tolerance on, tightly bounded | Fewer zero-result queries; ⚠ some precision loss | ⛔ **Requires two invented values** ⇒ Architecture Owner act. ⚠ Must pass §6.3's pair test |
| **C — Enable T3 with a length-scaled bound** | Bound varies with token length | ⭐ Best precision/recall balance in principle | ⚠⚠ **Must be re-tested against `C3` *"bounded and uniform across consumers"*** — a scaled bound is still uniform *as a rule*, but ⛔ whether the repository's C3 admits a **function** rather than a **constant** is itself an owner question, ⭐ and it is easy to miss. ⛔ Raised, not answered |

### 6.5 Recommendation, risks, and what is required

| Field | Content |
|---|---|
| **RECOMMENDED OPTION** | ⛔ **NO VALUE IS RECOMMENDED — there is 0 repository authority and inventing one is forbidden.** ⭐ **What IS recommended is procedural: (i)** record that **class A is the lawful default** under `SRCH-BR-012`'s preamble, so V1 is unblocked; **(ii)** if T3 is to be enabled, approve `L` and `d` **as a pair** per §6.3; **(iii)** rule on whether `C3` admits a function (class C) before class C is considered |
| **WHY** | It supplies the owner with everything that **is** determined — six constraints, a coupling, and a lawful default — without inventing the two numbers the repository does not hold |
| **RISKS** | **(a)** ⚠ Class A means `SRCH-FR-033` ships unimplemented; if that is unacceptable to the Product Owner, `P3` returns to the critical path — ⭐ **this is a product/architecture handoff that should be made explicit rather than assumed**. **(b)** Approving `L` and `d` independently risks the §6.3 noise defect. **(c)** ⛔ Class C may not be admissible at all under `C3`; proceeding without that ruling risks a later rework |
| **HUMAN APPROVAL REQUIRED** | ⭐ **YES** — Architecture Owner, for the posture and (if enabling) the pair; ⚠ **plus a Product Owner acknowledgement** if class A leaves `SRCH-FR-033` unimplemented. ⛔ **This document does NOT mark `P3` approved** |

---

## 7. `P4` — Minimum prefix length

### 7.1 ⛔ Zero authority, and therefore ⛔ zero recommended value

| Query | Scope | Result |
|---|---|---|
| `minimum prefix\|prefix length\|min_prefix` | `docs/` `tool/` minus `PRD-015_*` | ⛔ **0 hits** |

⛔ **No value is invented and none is recommended.**

### 7.2 ⭐⭐ `P4` is NOT `P3` — the two are structurally different, and conflating them is the trap

⚠ **Prior passes grouped `P3` and `P4` as *"two missing numbers."* They are not symmetric, and the asymmetry
changes who must decide and how urgently.**

| Property | `P3` (typo bound) | `P4` (minimum prefix length) |
|---|---|---|
| Tier | **T3** | ⭐⭐ **T2** — `SRCH-FR-030` sits in §19.2, under **T2** |
| ⭐⭐ **Is there a "do not enable" escape?** | ✅ **YES** — `SRCH-BR-012` preamble (§6.2 `C6`) | ⛔⛔ **NO.** `SRCH-FR-030` is an unconditional **MUST** (*"A query token **MUST** be able to match an indexed token by prefix"*) with **no enabling condition and no disable clause** |
| Consequence of no decision | ⭐ Feature degrades lawfully | ⛔⛔ **A FROZEN `MUST` is unimplementable.** `SRCH-AC-030` (**L1103**) tests `Lib` → `Library` and **would fail** |
| Owner | Architecture Owner | Architecture Owner |

> ⭐⭐⭐ **THEREFORE `P4` — NOT `P3` — IS THE REAL V1 BLOCKER OF THE TWO.**
>
> `P3` has a lawful default. `P4` has none: `SRCH-FR-030` must be satisfied, `SRCH-AC-030` must pass, and
> neither can happen until a minimum prefix length exists. ⛔ **This inverts the priority the prior passes
> implied**, and it is the single most actionable finding in this section.

### 7.3 ⭐ What constrains any `P4` value

| # | Constraint | Source |
|---|---|---|
| **1** | ⛔ Prefix matching **MUST NOT** be applied as a **suffix or infix** match on **exact**-role fields | `SRCH-FR-030` **L519-520** |
| **2** | ⭐⭐ A multi-word query is **conjunctive** — *every* token must be satisfied | `SRCH-BR-010` **L524-527**. ⇒ A **short** minimum prefix does **not** produce the usual flood, because each additional token **narrows**. ⭐ This materially weakens the standard *"short prefixes are too broad"* argument, and it is easy to overlook |
| **3** | Page size is already capped at **20** (range 5–50, owner Security) | `LCFG-12` — `CONFIGURATION_GUIDE.md` **L362** ⇒ ⭐ result-set **volume** is already bounded independently of `P4`; the residual concern is **query cost**, not response size |
| **4** | ⚠ Prefix matching interacts with **enumeration** on the anonymous surface | `PRD-015` **L750** `S2`; ⛔ ⚠ mitigation owner **does not exist** — `SRCH-GAP-008`, `XPC-OD-010` **OPEN** |
| **5** | Ordering is tier-based with **no score**, so a prefix match cannot be *"ranked down"* | `SRCH-FR-035`; `SRCH-BR-013` (no-tier ⇒ **excluded**, not ranked last) |

### 7.4 Approach classes — ⛔ OPTIONS ONLY, ⛔ NONE APPROVED, ⛔ NO VALUES

| Class | Posture | ⚠ Note |
|---|---|---|
| **A — A single platform-wide minimum prefix length** | One constant, all eligible fields | ⭐ **Simplest and most auditable.** ⛔ Requires one invented value ⇒ owner act. ⭐ Constraint 2 makes a short value safer than intuition suggests |
| **B — Per-field-role minimum** | Different minima for different field roles | ⚠ More precise; ⚠⚠ but `SRCH-FR-034` determinism and `SRCH-FR-036` explainability must still hold per field, and the **field precedence order does not exist** (`SRCH-GAP-009`, Product Owner) ⇒ ⛔ **class B is gated on a Product-Owner gap that is still open** |
| **C — Authenticated vs anonymous minimum** | Stricter minimum on the public surface | ⚠⚠ **Directly engages `SRCH-GAP-008`, whose owner DOES NOT EXIST.** ⛔ Cannot be approved while `XPC-OD-010` is OPEN. ⚠ Also risks `SRCH-FR-002`'s *"one matching semantics platform-wide"* |

### 7.5 Recommendation, risks, and what is required

| Field | Content |
|---|---|
| **RECOMMENDED OPTION** | ⛔ **NO VALUE IS RECOMMENDED.** ⭐ **What IS recommended: (i)** treat `P4` as **higher priority than `P3`** because it has no lawful default (§7.2); **(ii)** prefer **class A** in *form* — a single platform-wide minimum — because classes B and C are each gated on an **open gap owned by someone else** (`SRCH-GAP-009`, `SRCH-GAP-008`); ⛔ **no number is proposed for it** |
| **WHY** | Class A is the only class that can be decided by the Architecture Owner **alone, today**. Classes B and C require gaps whose owners are respectively **open** and **non-existent** to close first |
| **RISKS** | **(a)** ⛔ Until `P4` is set, `SRCH-FR-030` is unimplementable and `SRCH-AC-030` fails — ⚠ **a FROZEN `MUST` in a knowingly failing state.** **(b)** ⚠ A class-A value chosen without regard to the anonymous surface leaves `S2` enumeration unmitigated — ⛔ and **no owner exists to mitigate it**, so this risk cannot currently be transferred. **(c)** Choosing class B or C now would import another owner's open gap into `PRD-015`'s critical path |
| **HUMAN APPROVAL REQUIRED** | ⭐ **YES** — Architecture Owner, for the class **and** the value. ⚠ **Plus an explicit acknowledgement that `SRCH-GAP-008` has no owner**, since class A leaves enumeration risk accepted rather than mitigated. ⛔ **This document does NOT mark `P4` approved** |

---

## 8. `P5` and `P6` — ✅ existing authority, ⛔ no decision required

### 8.1 Both values already exist and are re-verified byte-for-byte this pass

⛔ **Neither is a decision. Neither is changed, duplicated, widened or reinterpreted.**

| | `P5` | `P6` |
|---|---|---|
| Registered meaning | Maximum page size cap (`SRCH-FR-039`) | Acceptable projection lag per event class except `SEV-9` (§32) |
| Config ID | **`LCFG-12`** | **`LCFG-6`** |
| Value | **20** | **60 s** |
| Range | **5 – 50** | **0 – 300 s** |
| Owner | **Security** | **Security** |
| Declared at | `CONFIGURATION_GUIDE.md` **L362** *(verified this pass)* | `CONFIGURATION_GUIDE.md` **L356** *(verified this pass)* |
| Verdict | ✅ **CLOSED** | ⚠ **PARTIALLY closed — see §8.3** |

### 8.2 ⭐ `P5` — closed, and the reason it is safely closed

`LCFG-12`'s recorded rationale is *"Bounds enumeration rate and page weight"* (**L362**) — ⭐ **the same
enumeration concern `PRD-015` **L750** raises as `S2`.** ⇒ The existing value was set for **exactly** the purpose
`PRD-015` needs it for. ⛔ Nothing to decide. ⭐ The **only** required act is **traceability**: `PRD-015` must
**cite** `LCFG-12` — measured `LCFG` × **0** occurrences in the subject.

### 8.3 ⚠⚠ `P6` — the closure is NARROWER than "P6 is closed", and this is the trap

⚠ **`LCFG-6` does NOT satisfy `P6` as registered.** `P6`'s registered wording is *"acceptable projection lag
**per event class** except `SEV-9`."* `LCFG-6`'s declared scope is **one** class only:

| Source | Text | Scope delivered |
|---|---|---|
| `CONFIGURATION_GUIDE.md` **L356** | *"Public index is eventually consistent. **Removal latency only**"* | ⚠ **Removal only** |
| `Library_PRD_v1.md` **L721** | *"**Applies only to Public→Private removal latency**"* | ⚠ **Removal only** |
| `LIB-16.9` **L727** | *"`LCFG-6` **MUST NOT** be applied to any authorization, membership,"* … | ⛔ **Explicit prohibition on reuse** |
| Guide §-heading **L372** | *"`LCFG-6` — the value most likely to be misused"* | ⚠⚠ **The repository warns of this exact misuse, by name** |

> ⭐⭐⭐ **THEREFORE: `P6` splits, and reporting it as closed would be an error the repository explicitly
> anticipates.**
>
> | Limb | Status |
> |---|---|
> | Public→Private **removal** latency | ✅ **CLOSED** — `LCFG-6` = 60 s, owner Security |
> | ⛔ Lag for **every other** event class | ⛔ **OPEN** — `SRCH-GAP-002`, Architecture Owner. ⛔ 0 authority. ⛔ **`LCFG-6` MUST NOT be stretched to cover it** (`LIB-16.9`) |
> | `SEV-9` privacy-mode change | ✅ **CLOSED — no propagation window at all** (`SRCH-FR-013`; BC Map **L427**) ⇒ correctly excluded by `P6`'s own wording |

### 8.4 Recommendation

| Field | Content |
|---|---|
| **RECOMMENDED** | ✅ **`P5`: cite `LCFG-12`. ⛔ Do not re-decide.** ⚠ **`P6`: cite `LCFG-6` for the removal limb ONLY, and record the remaining event classes as OPEN under `SRCH-GAP-002`.** ⛔ **Do not report `P6` as closed** |
| **WHY** | `LIB-16.9` forbids extending `LCFG-6`, and the Configuration Guide names this value as the one most likely to be misused. ⭐ Recording the split is the honest form |
| **HUMAN APPROVAL REQUIRED** | ⛔ **NO for `P5`** — traceability act only. ⚠ **YES for `P6`'s open limb** — Architecture Owner. ⛔ No lag figure is proposed |

---

## 9. `P7` — Query latency, throughput and availability targets

### 9.1 ⭐⭐⭐ The decisive finding — `PRD-015` is FORBIDDEN from answering `P7`

⚠ **Every prior pass treated `P7` as *"numbers are missing, the Architecture Owner must supply them."* That
framing is wrong, and supplying numbers here would breach a FROZEN Rank 3 requirement.**

| Authority | Rank | Text *(verified verbatim this pass)* | Effect |
|---|---|---|---|
| ⭐⭐⭐ **`LIB-20.1`** — `Library_PRD_v1.md` **L862-864** | **3, FROZEN** | *"Platform-wide NFR budgets **MUST** be taken from the Enterprise Architecture NFR Budgets document. **This PRD MUST NOT state a competing latency or availability figure.**"* | ⛔ **A latency or availability figure in `PRD-015` is a VIOLATION**, not a gap-fill |
| **`MP-NFR-01`** — `MASTER_PRD.md` **L492** | **1** | *"Per-function availability targets with SLOs, SLIs and error budgets"* — **Owner: SRE / OBSERVABILITY** | ⛔ The owner of availability targets is **not** the module PRD, and **not** the Architecture Owner either |
| `MASTER_PRD.md` **L484** | **1** | *"the measurable form lives in §25 and in the **`NFR Budgets (V1)`** document"* | ⭐ Names the destination artefact |
| EA **L339** | **6** | `NFR Budgets (V1)` — listed as a **planned node** | ⚠ Planned, ⛔ not written |

### 9.2 ⛔⛔ And the destination document DOES NOT EXIST

| Check | Result |
|---|---|
| `find docs/ -iname "*NFR*"` *(re-run this pass)* | ⚠ **Exactly 1 file**: `docs/30-product/authentication/prd-v2/11-NFR-Compliance-and-Final-Acceptance.md` — ⛔ that is `PRD-001`'s **own** chapter, ⛔ not a platform budgets document |
| A platform-wide `NFR Budgets` document | ⛔ **DOES NOT EXIST** |
| `PRD-023` baseline | ⚠ Names *"NFR Budgets"* among its **hard-external blockers** ⇒ ⭐ **`PRD-015` is not the first PRD blocked on this. It is a platform-level omission, not a search problem** |

> ⭐⭐⭐ **THEREFORE THE `P7` RECOMMENDATION IS NOT A SET OF NUMBERS — IT IS THAT `PRD-015` MUST NOT CARRY
> NUMBERS, AND THAT THE MISSING DOCUMENT MUST BE COMMISSIONED.**
>
> ⭐ `P7` is **mis-assigned** in `PRD-015` §36. It is registered to the **Architecture Owner**, but `MP-NFR-01`
> assigns availability targets to **SRE / OBSERVABILITY** and `LIB-20.1` routes the figures to a **different
> document**. ⇒ The Architecture Owner's lawful act on `P7` is to **route and commission**, ⛔ not to decide.

### 9.3 ⭐ The precedent FORM exists, so nothing needs inventing when the real owner acts

⛔ **No figure below is transplanted, adapted or proposed for search. Only the SHAPE is cited.**

| Precedent | What it demonstrates |
|---|---|
| `Student_Identity_PRD_v1.md` §5 **L1178-1192** | ⭐ A **per-operation** p95/p99 table plus an explicit degradation rule — ⇒ the repository's established shape is **per-operation**, not one global number |
| `PRD-001` §11.3 | ⭐ Availability as two tiers with a **stated rationale** (*"session validation and authorization are held to a higher target than sign-in"*) — ⇒ ⭐⭐ **differentiated targets with reasons are the house style** |
| ⭐⭐ Applied to search | ⇒ When the owner acts, targets should be **per tier**, because **T3 typo matching is inherently costlier than T1** and a single blended number would be **unmeasurable**. ⛔ No tier value is proposed |

### 9.4 Recommendation, risks, and what is required

| Field | Content |
|---|---|
| **RECOMMENDED OPTION** | ⭐⭐ **(i)** ⛔ **`PRD-015` MUST NOT state any latency, throughput or availability figure** — `LIB-20.1`. **(ii)** ⭐ Record `P7` as **ROUTED** to the `NFR Budgets (V1)` document, owner **SRE / OBSERVABILITY** per `MP-NFR-01`. **(iii)** ⭐⭐ **Commission that document** — it does not exist and blocks `PRD-023` as well. **(iv)** ⭐ Record that search targets must be **per tier** when written. **(v)** ⭐ Correct `P7`'s owner line in §36 from *Architecture Owner* to the routing above |
| **WHY** | It is the only form that does not breach `LIB-20.1`, it puts the decision with the office `MP-NFR-01` names, and it surfaces that the blocker is **platform-wide** rather than search-specific |
| **RISKS** | **(a)** ⛔ Routing does not make `P7` closed — it makes it **correctly owned and still open**; ⚠ this must not be read as progress toward Stage-3 closure. **(b)** ⚠ Commissioning the NFR Budgets document is a **larger** act than a search decision and may take longer — ⭐ but `PRD-015` does not need it to *close Stage 3* if `P7` is recorded as externally routed, and **whether that is acceptable is itself the owner's call**. **(c)** ⚠ `P7`'s throughput limb is entangled with `SRCH-GAP-008` (rate limiting), whose owner **does not exist** — ⛔ so the throughput limb cannot be fully specified even by the correct owner |
| **HUMAN APPROVAL REQUIRED** | ⭐ **YES** — to confirm the **routing**, to **commission** the NFR Budgets document, and to correct `P7`'s owner line. ⛔ **No figure is approved, proposed or implied. This document does NOT mark `P7` approved** |

---

## 10. `P8` — Rebuild availability posture and duration

### 10.1 ⭐⭐ The approach is ALREADY repository-established — it is not a candidate

⚠ **Prior passes presented `P8`'s indexing approach as an open choice. It is not: the Dependency Matrix names
the remedy, and the manifest enforces it mechanically.**

| Evidence *(verified verbatim this pass)* | What it settles |
|---|---|
| ⭐⭐ Matrix **L357** `X-08` — anti-pattern `SEARCH → domain repository` for indexing, temptation *"Reindex by scanning the table"*, **Correct approach: "Event-driven index + explicit `Index Backfill Job`"** | ⭐⭐⭐ **The approach is NAMED BY THE MATRIX.** ⇒ `P8` Option A is **established**, not proposed |
| `tool/module_dependencies.yaml` **L378-379** — `banned_imports: ["domain/**", "app/**"] # X-08` and `consumes_events: ["*"]` | ⭐ **Mechanically enforced** — a table-scanning rebuild **fails the build** |
| BC Map **L453** — *"Every projection (`BC-26`) and **index (`BC-23`)** must be rebuildable from the log. **This is tested quarterly, not assumed**"* | ✅ Rebuildability **mandatory** at Rank 4, ⭐ and **quarterly tested** |
| EA **L1536** — `Index Backfill Jobs (V2)` | ⚠ Rank 6 descriptive tag; ⛔ not a decision. ⚠ **Tagged V2** — see §10.4 risk (b) |
| `SRCH-INV-005` (**L798**), `SRCH-AC-061` (**L1212**) | ✅ Mirrored into the subject and made **acceptance-testable** |

### 10.2 The split — what is closed, what is genuinely open

| Limb | Status | Basis |
|---|---|---|
| **Rebuildability itself** | ✅ **CLOSED — mandatory** | BC Map **L453**; `SRCH-INV-005` |
| **Rebuild correctness** | ✅ **CLOSED** | §34: rebuilt index equivalent for matching **and** ordering; ⛔ **MUST NOT** re-admit removed documents (`SRCH-FR-011`–`014`) |
| **Indexing approach** | ✅ **CLOSED — event-driven incremental + explicit backfill job** | ⭐⭐ Matrix **L357** *(newly recognised as closed, §10.1)* |
| **Periodic trigger** | ✅ **CLOSED — at least quarterly** | ⭐ BC Map **L453** *"tested quarterly"* ⇒ a quarterly exercise is **already required**. ⚠ Whether that is the **only** trigger remains open |
| ⛔ **Availability posture during rebuild** | ⛔ **OPEN** | §34 **L806-807**: *"whether search degrades, serves stale, or is unavailable during a rebuild — is an operational decision recorded in `SRCH-GAP-002`"* |
| ⛔ **Duration target** | ⛔ **OPEN** | ⛔ **0** authority. ⚠⚠ **And see §10.3 — this limb is BLOCKED, not merely undecided** |
| ⛔ **Full vs incremental rebuild** | ⛔ **OPEN** | EA **L1535** `Bulk Reindexing (V2)` — Rank 6 descriptive |

### 10.3 ⭐⭐⭐ The duration limb is BLOCKED by `P7`, not merely open

⚠ **A rebuild duration target is a *time* commitment on the write path. Under `LIB-20.1` (§9.1), `PRD-015`
**MUST NOT** state a competing latency figure — and a rebuild-duration budget is exactly such a figure.**

> ⭐⭐⭐ ⇒ **`P8`'s duration limb inherits `P7`'s routing.** It belongs in the `NFR Budgets (V1)` document, ⛔ not
> in `PRD-015`, ⛔ and not in an Architecture Owner ruling recorded in a PRD. ⭐ **No prior pass connected these
> two, and it means the duration limb cannot be closed by the Architecture Owner at all** — it is blocked behind
> the same missing document.

### 10.4 ⭐⭐ The posture limb carries a hidden SECURITY question

⛔ **OPTIONS ONLY, ⛔ NONE APPROVED.**

| Posture | Availability | ⚠⚠ The question it actually raises |
|---|---|---|
| **(a) Serve stale from the old index until cutover** | ⭐ **Highest** | ⛔⛔ **THIS IS A SECURITY DECISION, NOT AN OPERATIONAL ONE.** `SRCH-FR-013` gives privacy-mode change **no propagation window** (`SEV-9`) and `SRCH-FR-014` governs revocation. ⇒ ⭐⭐ **A stale index served during a rebuild must STILL honour `SEV-9`'s zero window** — i.e. the *old* index must keep receiving removal and privacy events **while** the new one builds. ⚠ That is a **materially harder** engineering requirement than *"serve stale"* sounds, and ⛔ it means posture (a) **cannot be approved by an operations decision alone** |
| **(b) Degrade to a reduced tier set** | ⚠ Partial | ⚠ Changes matching behaviour mid-rebuild ⇒ `SRCH-FR-034` determinism (*identical query + index + authorisation ⇒ identical order*) must be re-examined, ⭐ and `SRCH-FR-036` explainability must still attribute a tier |
| **(c) Unavailable during rebuild** | ⛔ Lowest | ⭐⭐ **Simplest and safest** — no stale-authorisation surface at all. ⚠ Consumes the `P7` availability budget, ⛔ which does not exist yet (§9.2) ⇒ ⚠ **its cost is currently unmeasurable** |

### 10.5 Recommendation, risks, and what is required

| Field | Content |
|---|---|
| **RECOMMENDED OPTION** | ⭐⭐ **(i) Approach: CONFIRM the already-established Matrix `L357` approach** — event-driven incremental indexing plus an explicit `Index Backfill Job` for recovery/rebuild. ⛔ Nothing to choose; this is a **confirmation**, not a decision. **(ii) Trigger: record that BC Map `L453` already mandates at least a quarterly rebuild test.** **(iii) Posture: ⛔ NOT recommended — but escalate posture (a) to SECURITY**, because §10.4 shows it is a `SEV-9`/`SRCH-FR-014` question, not an operational one; ⭐ posture **(c)** is the smallest and safest if availability permits. **(iv) Duration: ⛔ NO target — route to `NFR Budgets (V1)` with `P7`** (§10.3) |
| **WHY** | Four of `P8`'s seven limbs are already closed by Rank 4 authority and the machine-enforced manifest; of the three open limbs, one is **blocked** behind `P7` and one is **mis-classified** as operational when it is security. ⭐ Naming those two facts is the whole value of this section |
| **RISKS** | **(a)** ⚠ If posture (a) is approved as *"operational"* without Security review, the platform ships a rebuild window in which **privacy-mode changes may not propagate** — ⛔ a direct `SEV-9` breach, and ⭐ the single most consequential risk in this document. **(b)** ⚠ EA **L1535-1536** tag both `Bulk Reindexing` and `Index Backfill Jobs` as **V2** — ⇒ ⛔ **the mandatory-at-Rank-4 rebuild capability may have no V1 implementation vehicle.** ⭐ This is the same Rank-3-vs-Rank-6 collision already raised as `SRCHAO-C1`, ⛔ and it is unresolved because `PRD-015` has no rank. **(c)** Duration remains unbounded, so *"rebuildable"* is guaranteed without any promise of **how long** — acceptable only while stated openly |
| **HUMAN APPROVAL REQUIRED** | ⭐ **YES** — Architecture Owner to **confirm** the approach and trigger; ⚠⚠ **Security Platform (jointly) for the posture limb**; ⛔ **and the duration limb cannot be approved here at all** — it routes with `P7`. ⛔ **This document does NOT mark `P8` approved** |

---

## 11. `ENT` and `EDGE` — query-time entitlement ⭐⭐⭐ security-critical

### 11.1 ⭐⭐⭐ Three corrections that collapse `ENT` from an architecture question to a declaration

⚠⚠ **All three prior PRD-015 records state that `BC-23` has no module block and that a Rank 4 register must be
amended to admit the dependency. Two of those three claims are FALSE. Measured this pass:**

| # | Prior claim | ⭐ Measured reality | Evidence |
|---|---|---|---|
| **1** | *"`BC-23` has no module block, so it can declare no outbound port"* | ⛔⛔ **FALSE.** `platform/search` **HAS** a block, in the **machine-enforced** manifest whose violations **fail the build** | `tool/module_dependencies.yaml` **L373-384**: `rank: 5`, `imports: [{target: contracts}]`, `consumes_events: ["*"]`, `banned_imports: ["domain/**","app/**"] # X-08`, assertions `SE-1`, `SE-2` |
| **2** | *"`SEARCH → IDENTITY` needs an exception / edge / ADR to be lawful"* | ⛔⛔ **FALSE.** It is **already permitted and already downward** | Matrix §5 grid **L140** row `R5 SEARCH` × col `IAM` = **`◇`** (*port, no import*); manifest **L36** `platform/identity: 4`, **L38** `platform/search: 5` ⇒ **5 → 4 is strictly downward ⇒ Dependency Law `L2` SATISFIED.** ⛔ `L4` not engaged (identity is not a domain module) |
| **3** | *"the write-side entitlement obligation is an open architecture question"* | ⛔ **FALSE — it is ALREADY LAW** | ⭐⭐ Manifest **L383-384** assertion **`SE-2`**: *"**every index write carries a permission scope**"*, plus **`SE-1`**: *"every index name is tenant-prefixed"* (`X-13`) |

> ⭐⭐⭐ **THEREFORE `ENT` IS NOT AN ARCHITECTURE DECISION. IT IS A DECLARATION GAP.**
>
> The dependency is **lawful today** (correction 2). The module that would declare it **exists today**
> (correction 1). The **write side** is already enforced (correction 3). What is missing is that
> `platform/search` does not list `platform/identity:policy_decision` among its ports, and
> `identity.policy_decision` does not list `search` among its consumers.
>
> ⇒ ⭐⭐ **The remaining act is TWO LINES in one file — not a new port, not a new API, not a new edge, not a new
> module, not an ADR-gated Rank 4 amendment.**

### 11.2 The established pattern this reuses — ⛔ nothing invented

`identity.policy_decision` is **already** the repository's answer to *"how does a module consume an authorization
decision"*, used by **six** modules:

| Consumer | Where | ⭐ Note |
|---|---|---|
| `library_management` | Matrix **L193** — *"authorisation check"* | |
| `person_identity` | Matrix **L220** — ⭐⭐ *"**ask BC-18, never evaluate or cache**"* | ⭐⭐⭐ **This comment is the exact discipline `BC-23` needs.** `PRD-015` §27 requires **query-time re-evaluation** and forbids the index granting access; *"never evaluate or cache"* says the same thing in the manifest's own words |
| `student_network` | Matrix **L248** | |
| `ai` | Matrix **L272** — alongside `search.retrieval  # permission-aware retrieval ONLY` at **L273** | ⭐ `BC-27` already consumes both `identity.policy_decision` **and** `search.retrieval` — ⇒ the **shape works** |
| `analytics` | Matrix **L290** | |
| `workflow` | Matrix **L305** | |
| ⛔ **`search`** | ⛔ **ABSENT** from `provides_ports.policy_decision.consumers` (manifest **L443-444**: `[domain/library, domain/social, platform/ai, platform/analytics, platform/workflow]`) | ⇒ **the gap, stated precisely** |

⭐ **And the amendment precedent exists in the same file.** `A-2` (`account_directory`) and `A-3`
(`notification_address`, manifest **L448-450**) show the house form: a **named port**, a **named consumer list**,
and a **`constraint:` string** narrowing it. ⇒ ⛔ **No new form needs inventing.**

### 11.3 The three shapes, re-scored against the corrections

| Shape | Prior assessment | ⭐ Re-scored |
|---|---|---|
| **(1)** A numbered BC Map §7 edge `BC-23` → `BC-18` | *"a lawful shape"* | ⛔ **NOT REQUIRED and should be avoided.** BC Map **L453**: *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."* ⇒ ⛔ ADR-gated, ⛔ instruction §24 forbids creating one, ⭐ **and ports are not edges** (`ADR-0033`; **14 of 17** `library_management` ports have no numbered edge) ⇒ ⭐ an edge is the **largest** remedy for a gap that needs none |
| **(2)** Declare the port in `platform/search` | *"requires a `search:` module block that does not exist"* | ⭐⭐⭐ **NOW THE SMALLEST — the block EXISTS (L373).** Two lines: add `ports: [platform/identity:policy_decision]` to `platform/search`, and add `platform/search` to `policy_decision.consumers`. ⭐ Follows `A-2`/`A-3` exactly, ⭐ and becomes **mechanically enforced** immediately |
| **(3)** Consumer-mediated — the consumer supplies an evaluated decision to the query port | *"the only shape requiring no amendment"* | ⚠⚠ **NOW THE WORST.** ⛔ It contradicts `SRCH-FR-002`'s *"single entry point … one matching semantics platform-wide"*; ⛔ it contradicts **`SE-2`**, which already places the permission scope **inside** `BC-23`'s write path — ⇒ ⭐ **shape (3) would make `BC-23` enforce entitlement on write but delegate it on read, which is asymmetric and unauditable**; ⚠ and it multiplies the obligation across every consumer |

### 11.4 `EDGE` — ⭐ resolved as *not required*, on repository precedent

| Question | Finding |
|---|---|
| Is an edge required for a **port** call? | ⛔ **No.** `ADR-0033`; `PRD-008` **L879**; `ADR-0035` **L238** — ports are not edges; **14 of 17** `library_management` ports have no usable numbered edge |
| Is the call lawful without one? | ✅ **Yes** — Matrix §5 `R5 SEARCH`×`IAM` = `◇` **is** the permission, and `5 → 4` satisfies `L2` (§11.1 correction 2) |
| ⛔ Is an edge ID proposed? | ⛔ **NO.** ⛔ `E-27` remains **permanently vacant** and is **not reusable** (`PRD_LIFECYCLE.md` §5 rule 5) |
| Precedent for declining to mint an edge | ⭐ `SEAT-XC-021` — *"**MUST NOT** be given an edge to it without an ADR"* ⇒ ⭐ declining is the repository's own practice |

⭐ **`EDGE` is therefore recommended CLOSED as *no edge required*, and it is subsumed by `ENT` shape (2).**

### 11.5 Recommendation, risks, and what is required

| Field | Content |
|---|---|
| **RECOMMENDED OPTION** | ⭐⭐⭐ **Shape (2), as a two-line manifest amendment in the `A-2`/`A-3` form:** add `platform/identity:policy_decision` to `platform/search.ports`, and add `platform/search` to `provides_ports.policy_decision.consumers`. ⭐ Carry the `person_identity` discipline verbatim as the `constraint:` string — ***"ask BC-18, never evaluate or cache"*** — because `PRD-015` §27 requires exactly that. ⛔ **No new port name, no API, no RPC, no endpoint, no event, no entitlement object, no edge ID, no ADR.** ⭐ `EDGE` recommended **CLOSED — not required** |
| **WHY** | The dependency is already lawful (Matrix `◇`, `5 → 4`), the declaring block already exists (**L373**), the write side is already enforced (`SE-2`), the pattern is already used by six modules, and the amendment form already exists twice in the same file. ⭐⭐ **This is the smallest possible change that closes a security-critical gap, and it makes the obligation machine-enforced rather than prose** |
| **RISKS** | **(a)** ⚠ A manifest amendment is an **Architecture Owner act** and the manifest is **build-enforcing** — ⛔ a malformed edit **breaks the build for every module**, so it must be made by the owner, not inferred from this document. **(b)** ⚠⚠ **Until it is made, `BC-23` has NO declared query-time authorization path while `SE-2` already obliges the write path** — ⭐ that asymmetry is the actual live security exposure, and it is **worse than a plain gap** because the write-side assertion may be read as covering both. **(c)** ⚠ `platform/search.banned_imports` includes `app/**`; shape (3) would have routed decisions through consumers including `app` — ⛔ a further reason to reject it. **(d)** ⭐ Adding the port does **not** by itself satisfy `PRD-015` §27 — the **query-time re-evaluation** behaviour must still be implemented and tested (`SRCH-FR-040`, `SRCH-FR-042`) |
| **HUMAN APPROVAL REQUIRED** | ⭐ **YES** — Architecture Owner, for the manifest amendment. ⚠ **Security Platform should be informed**, since the gap is an authorization gap. ⛔ **This document does NOT amend the manifest, does NOT mark `ENT` approved, and did NOT edit `tool/module_dependencies.yaml`** |

---

## 12. `VOC`, `C1`, `R1`, `R2` — the four non-`P` items

### 12.1 `VOC` — variant / abbreviation vocabulary ⭐ **Product-owned, and already narrow**

| Fact | Evidence |
|---|---|
| ⛔ **0 authoritative vocabulary exists** | `synonym\|abbreviation\|alias\|short form` → three hits, **none authoritative**: BC Map **L844** is a *prohibition*; EA **L1527** *"Synonyms (**V3**)"* is a Rank 6 **tag**; EA **L2436** is a *style* rule |
| Equivalence must be **declared** | `SRCH-BR-011` **L549-550** — ⛔ **MUST NOT** be inferred from usage, click behaviour, co-occurrence or any learned model |
| ⭐⭐ **`SRCH-FR-031` V4 is ALREADY conditional** | **L544**: *"Declared **abbreviation / expansion** pairs — `lib` ≡ `library`, **only where declared**"* ⇒ ⭐⭐⭐ **With 0 declared pairs, V4 is satisfied VACUOUSLY. It is not violated** |
| V1/V2/V3 do **not** depend on a table | **L541-543** — singular/plural, related word forms, written variations are **rule classes**, ⛔ not vocabulary entries |
| Owner | **Product Owner** — `SRCH-GAP-007` (**L553**) |

⭐ **RECOMMENDED: DEFER V4 for V1.** ⭐ *Why it is safe:* `SRCH-FR-031`'s *"only where declared"* means an empty
vocabulary is **conformant**, not defective — ⇒ **`VOC` is not a Stage-3 architecture blocker at all.** ⚠ **RISK:**
`lib` → *Library* is the illustration the PRD itself chose, so a user may expect it; deferring V4 means that
specific expectation is unmet in V1. ⛔ **No pair is invented.** **Approval:** ⭐ Product Owner, one line.

### 12.2 `C1` — the EA V2/V3 precedence question ⚠ **raised, ⛔ not resolvable yet**

| Fact | Evidence |
|---|---|
| EA tags the whole search tree **V2/V3** | EA **L1516-1560**, incl. *"Multi-Language Support (**V3**)"* **L1528** and *"Synonyms (**V3**)"* **L1527** |
| ⚠ Two nodes collide with approved **V1** behaviour | `SRCHPO-1` approves **Hindi for V1**; §20 declares abbreviation pairs at **V4** |
| EA is **Rank 6, Descriptive** | `DOCUMENTATION_BASELINE.md` **L139** — *"must follow the PRDs, never lead them"* |
| ⭐ The usual remedy | `ADR-0061` — *a Rank 3 statement outranks an EA V2 tag* |
| ⛔⛔ **But the remedy is UNAVAILABLE** | ⚠ `PRD-015` is **v0.1 `DRAFT`**, registry **`PLANNED`** ⇒ **it has no rank** ⇒ ⛔ the `ADR-0061` precedence argument **cannot be invoked by it** |
| ⭐ Same collision recurs at `P8` | §10.4 risk (b) — `Index Backfill Jobs` tagged **V2** while BC Map **L453** makes rebuildability **mandatory at Rank 4** ⇒ ⭐⭐ **`C1` is not one anomaly; it is a systematic collision** |

⭐ **RECOMMENDED: raise `C1` for an Architecture Owner ruling, and note that it BLOCKS ITSELF** — the ranking of
`PRD-015` (gated on `SRCH-GAP-001`, **Governance Owner, VACANT**) must precede the precedence argument. ⛔ **The EA
is NOT edited.** ⛔ **No ADR is created.** **Approval:** ⭐ Architecture Owner ruling; ⚠ Governance Owner action on
`SRCH-GAP-001` is a **precondition**.

### 12.3 `R1` and `R2` — ⭐ both correctly LATENT, ⛔ no decision needed now

| | `R1` — Student Identity | `R2` — Trust & Safety |
|---|---|---|
| Status | ⭐ **LATENT — correct** | ⭐ **LATENT — correct** |
| Basis | `Student_Identity_PRD_v1.md` **L939-953**; `PRD-015` **L511-525** | `PRD-020` **L550-568**; `PRD-015` **L578-590** |
| ⭐ Recommended | **KEEP LATENT until student discovery is enabled**, and make the `SID-4.40` ÷ `LCFG-6` reconciliation a **precondition** of enablement — ⚠ because `LIB-16.9` (**L727**) forbids applying `LCFG-6` to authorization or membership, so the two must be reconciled **before**, not during, enablement | **KEEP LATENT. `BC-13` remains the Trust & Safety authority.** A step-`[3]` hook is required **before** any ranking or recommendation is enabled — ⚠ and `SRCH-FR-035`'s **no-score** model means such a feature would be a **new capability**, not a tuning change |
| Approval | ⛔ **NO** — activation is a later act | ⛔ **NO** — `BC-13` co-owns activation |
| ⚠ Risk | Enabling discovery without the reconciliation would apply a **removal-latency** value to an **authorization** question — ⛔ the precise misuse `LIB-16.9` prohibits | Enabling ranking without the `BC-13` hook would place a Trust & Safety decision inside `BC-23` — ⛔ a boundary violation |

---

## 13. ⛔ STAGE-3 CONFERRAL — TEMPLATE ONLY

> ⛔⛔ **THIS IS A BLANK, UNEXECUTED FORM. IT IS NOT A CONFERRAL AND MUST NOT BE READ AS ONE.**
> ⛔ Nothing in this document, and nothing in the instruction that produced it, performs this act. It becomes an
> act **only** when the human principal supplies it expressly, in their own instruction, naming `PRD-015`.

| Field | Value |
|---|---|
| **Subject** | `PRD-015_SEARCH_INDEXING.md` — sha256 `fe3093e6…c2c4544` |
| **Stage** | **Stage 3 — Architecture Alignment** (`PRD_LIFECYCLE.md` **L86-106**) |
| **Role** | **Architecture Owner / Architecture Reviewer** — the office `PRD_OWNERSHIP_MODEL.md` **L197** records for `PRD-015` as **ARB** |
| **Authority basis** | ⛔ **NOT SUPPLIED.** Would be the principal's express instruction, on the `ADR-0032` §5.2 / `ADR-0033` §7.2 / `ADR-0036` §8.2 precedent |
| **Scope** | ⛔ **Specific act only, NOT a standing licence** — `ADR-0033` §7.1 |
| **Date** | ⛔ **BLANK** |
| **`CONFERRED / WITHHELD`** | **______** ⛔ **BLANK** |
| **Identity / signature** | ⛔ **DELIBERATELY OMITTED** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 (**L318**): *"**Never** record a personal name."* ⭐ The office is named; ⛔ **no holder is appointed** |
| **What is NOT asserted** | ⛔ No ARB quorum, attendee list, sign-off date, minutes, Security review or PEA approval |

⚠⚠ **Even if conferred, Stage 3 would still NOT close** — the substantive decisions in §14 remain open. ⭐ **The
conferral is not the bottleneck.**

**Status: ⛔ TEMPLATE ONLY — NOT CONFERRED.**

---

## 14. Closure criteria — measured against this pass

| # | Condition | Entering this pass | ⭐ After this pass |
|---|---|---|---|
| 1 | `P1` resolved | ⛔ UNMET — *"choose an engine"* | ⚠ **UNMET, but RE-FRAMED** — the lawful act is now known (§4.5) and needs **confirmation**, not invention |
| 2 | `P2` resolved | ⛔ UNMET | ⚠ **UNMET — architecture half now determined** by `SRCH-AC-050` (§5.2); **3** sub-decisions remain |
| 3 | `P3` resolved | ⛔ UNMET | ⭐⭐ **NOT A BLOCKER** — `SRCH-BR-012`'s preamble supplies a lawful default (§6.2 `C6`) |
| 4 | `P4` resolved | ⛔ UNMET | ⛔⛔ **UNMET and ESCALATED** — ⭐ **the true blocker**: no default exists, `SRCH-FR-030` is an unconditional `MUST` (§7.2) |
| 5 | `P5` | ⛔ UNMET | ✅ **MET on authority** — `LCFG-12`; ⭐ traceability citation still required |
| 6 | `P6` | ⛔ UNMET | ⚠ **SPLIT** — removal limb ✅ **CLOSED**; other event classes ⛔ **OPEN** (§8.3) |
| 7 | `P7` resolved | ⛔ UNMET | ⚠ **RE-ROUTED, still open** — ⛔ `PRD-015` **must not** answer it (`LIB-20.1`); owner is **SRE / OBSERVABILITY**; ⛔ destination document **does not exist** (§9) |
| 8 | `P8` resolved | ⛔ UNMET | ⚠ **4 of 7 limbs CLOSED** (§10.2); posture ⚠ **escalated to Security**; duration ⛔ **blocked behind `P7`** |
| 9 | `ENT` / `EDGE` resolved | ⛔ UNMET — *"Rank 4 amendment required"* | ⭐⭐⭐ **COLLAPSED to a two-line manifest declaration** (§11.5); `EDGE` recommended **CLOSED — not required** |
| 10 | `VOC` resolved | ⛔ UNMET | ⭐ **NOT A BLOCKER** — V4 satisfied **vacuously** (§12.1) |
| 11 | `R1` / `R2` recorded | ⛔ UNMET | ✅ **RECORDED — both correctly LATENT** (§12.3) |
| 12 | Architecture Owner authority valid for this act | ⛔ UNMET | ⛔ **UNMET** — office exists, holder not conferred |
| 13 | Formal conferral performed | ⛔ UNMET | ⛔ **UNMET** — §13 is a template |
| 14 | Traceability — `PRD-015` cites `LCFG-12` / `LCFG-6` | ⛔ UNMET — `LCFG` × **0** | ⛔ **UNMET** — ⭐ but now a **two-citation edit**, not a decision |

### 14.1 ⭐⭐ Net movement — achieved by measurement, ⛔ not by approving anything

| Metric | Before | After |
|---|---|---|
| Items requiring a **human decision** | **14** | ⭐ **9** |
| Items that were **mis-framed** | — | ⭐⭐ **3 corrected** — `P1` (unlawful to answer), `P7` (wrong owner), `ENT` (declaration, not architecture) |
| Items **removed from the critical path** | — | ⭐ **3** — `P3`, `VOC`, `EDGE` |
| ⚠ Items **escalated** | — | ⚠ **2** — `P4` *(the real blocker)*, `P8` posture *(→ Security)* |
| ⛔ Values invented | **0** | ⛔ **0** |
| ⛔ Decisions taken | **0** | ⛔ **0** |
| Closure conditions met | **0 / 14** | ⚠ **2 / 14** *(`P5`, `R1`/`R2`)* |

⚠⚠ **2 of 14 met ⇒ `STAGE 3 = CONDITIONAL / NOT CONFERRED`.** ⭐ The reduction is real, but it is a reduction in
**scope**, not an advance in **approval**.

---

## 15. Validation performed

| # | Check | Result |
|---|---|---|
| 1 | `PRD-015_SEARCH_INDEXING.md` byte-unchanged | ✅ sha256 `fe3093e6…c2c4544` — **0 bytes changed** |
| 2 | Prior packet `94d78bb` edited? | ⛔ **No** — supplemented only |
| 3 | Other three PRD-015 records edited? | ⛔ **No** |
| 4 | `tool/module_dependencies.yaml` edited? | ⛔ **No** — §11 **recommends**, ⛔ does not amend |
| 5 | EA / BC Map / Matrix / Configuration Guide edited? | ⛔ **No** |
| 6 | ADRs created, amended or Accepted | ⛔ **Zero.** `ADR-0088` / `0089` / `0090` remain **RESERVED and UNWRITTEN** |
| 7 | Edge IDs proposed | ⛔ **Zero.** `E-27` remains permanently vacant, ⛔ not reused |
| 8 | Numeric values invented | ⛔ **Zero** — no engine, library, analyzer, stemmer, edit distance, token length, prefix length, latency, throughput, availability, rebuild duration, lag or vocabulary pair |
| 9 | `P1`–`P8` meanings reproduced verbatim | ✅ §2 — from `PRD-015` §36 **L833-842**; **0** relabelled |
| 10 | Benchmarks claimed | ⛔ **NONE** — §4.3 reason 2 states this explicitly |
| 11 | Personal names recorded | ⛔ **Zero** — §7 rule 4 |
| 12 | Approvals or conferrals asserted | ⛔ **Zero** — §13 is a blank form |
| 13 | Every citation re-opened this pass | ✅ `MASTER_PRD.md` **L219-239**, **L484**, **L492**; Matrix **L50**, **L140**, **L193-305**, **L357**; manifest **L36**, **L38**, **L373-384**, **L443-450**; BC Map **L453**; `CONFIGURATION_GUIDE.md` **L356**, **L362**; `Library_PRD_v1.md` **L862-864**; `PRD_OWNERSHIP_MODEL.md` **L197**, **L318**; EA **L339**, **L1527**, **L1536** |
| 14 | Flutter source touched | ⛔ **No** — documentation only; ⛔ no `lib/`, `pubspec.yaml` or build change |

---

## 16. ⛔ What this document does NOT do

| ⛔ | |
|---|---|
| **1** | ⛔ Does **not** decide `P1`–`P8`, `ENT`, `EDGE`, `VOC`, `C1`, `R1` or `R2`. **0 decisions taken** |
| **2** | ⛔ Does **not** name a search engine, library, analyzer, stemmer or transliteration method |
| **3** | ⛔ Does **not** state a latency, throughput, availability, rebuild-duration, lag, edit-distance, token-length or prefix-length value |
| **4** | ⛔ Does **not** amend the manifest, the Matrix, the BC Map, the EA or the Configuration Guide |
| **5** | ⛔ Does **not** create, amend or Accept an ADR, and does **not** mint an edge ID |
| **6** | ⛔ Does **not** claim any benchmark, ARB ruling, Security review, Privacy review or PEA approval |
| **7** | ⛔ Does **not** confer Stage 3, and does **not** change `PRD-015`'s `PLANNED` registry status |
| **8** | ⛔ Does **not** edit the four prior `PRD-015` records — it **supplements** them |
| **9** | ⚠ Does **not** resolve `C1`, which is **blocked** behind `SRCH-GAP-001` (Governance Owner, **VACANT**) |
| **10** | ⚠ Does **not** mitigate `SRCH-GAP-008` — ⛔ **no owner exists** (`XPC-OD-010` OPEN) |

---

## 17. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-03 | Initial record. Audits four sources the prior passes did not open (`MASTER_PRD.md` §10, `tool/module_dependencies.yaml`, Dependency Matrix §2/§5/§10.3, `Library_PRD_v1.md` §20). Corrects **3** mis-framings (`P1` unlawful to answer here, `P7` mis-owned, `ENT` a declaration not an architecture gap). Removes **3** items from the critical path (`P3`, `VOC`, `EDGE`). Escalates **2** (`P4` as the true blocker; `P8` posture to Security). Reduces open human decisions **14 → 9**. ⛔ **0 decisions taken, 0 values invented, 0 approvals asserted.** ⚠ **Stage 3 remains CONDITIONAL / NOT CONFERRED** |
