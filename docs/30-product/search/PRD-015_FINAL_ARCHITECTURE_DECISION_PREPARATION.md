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
</content>
</invoke>
