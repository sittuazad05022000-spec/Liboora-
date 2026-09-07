# PRD-015 — Architecture Owner Decision + Stage-3 Conferral Packet

| Field | Value |
|---|---|
| **Type** | ⚖️ **DECISION PACKET.** It presents the remaining decisions so an authorised owner can take them **explicitly**. ⛔ It takes **none** of them |
| **Not** | Not a PRD · not an ADR · not an approval · not an ARB ruling · not a conferral · not a freeze · not a baseline · not a Stage-4 artefact |
| **Version** | v1.0 |
| **Date** | 2026-09-03 |
| **Subject** | [`PRD-015_SEARCH_INDEXING.md`](./PRD-015_SEARCH_INDEXING.md) **v0.1 `DRAFT`**, registry **`PLANNED`** — sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544`, 1,426 lines, 95,608 bytes, **byte-unchanged by this packet** |
| **Supplements** | [`PRD-015_ARCHITECTURE_ALIGNMENT.md`](./PRD-015_ARCHITECTURE_ALIGNMENT.md) (`4154519`) · [`PRD-015_STAGE3_CLOSURE_ASSESSMENT.md`](./PRD-015_STAGE3_CLOSURE_ASSESSMENT.md) (`34ac2d3`) · [`PRD-015_PO_DECISION_RESOLUTION_RECORD.md`](./PRD-015_PO_DECISION_RESOLUTION_RECORD.md) (`a7ec941`) — ⛔ **none is edited in place** |
| **Decision authority exercised** | ⛔ **NONE.** Every item is presented for decision; **0** are decided here |
| **Approvals asserted** | ⛔ **None.** No ARB, Architecture Owner, Architecture Reviewer, Security, Privacy, Governance or PEA approval is claimed |
| **ADRs Accepted / created** | ⛔ **Zero.** `ADR-0088` / `ADR-0089` / `ADR-0090` remain **RESERVED and UNWRITTEN** |
| **Measured architecture result** | ✅ **6 of 6** Stage-3 checks PASS — carried forward, **not re-litigated** |
| **Conferral** | ⛔ **TEMPLATE ONLY** (§11). ⛔ A blank template is **not** a conferral |
| **Final status** | ⚠ **STAGE 3 REMAINS CONDITIONAL / NOT CONFERRED** |

> **What this packet is for.** Three prior records measured Stage 3, tested whether it could be conferred, and
> recorded the Product Owner's decisions. What remains is a set of decisions that **only the Architecture Owner
> may take**, plus one act only the human principal may perform. This packet makes each of them explicit,
> evidenced and answerable — ⛔ **without taking any of them**.
>
> **The instruction's own limit, quoted verbatim and honoured throughout:**
> *"Do NOT make those decisions silently. Do NOT invent technical values."*
> *"Do not manufacture any Architecture Owner decision or conferral."*
> *"Leave the actual decision blank. DO NOT fill it yourself."*

---

## 1. ⭐⭐⭐ Four findings measured this pass that change the packet's content

Each is **new** — none appears in the three prior records.

| # | Finding | Consequence |
|---|---|---|
| **G-1** | ⭐⭐⭐ **`search.indexer` and `search.retrieval` are EXISTING declared ports.** Dependency Matrix §6: `library_management` **L194** (*"`search.indexer` # write-side index notification"*), `person_identity` **L221**, a third module **L249**, and `ai` **L273** (*"`search.retrieval` # permission-aware retrieval ONLY"*) | ⭐⭐ **The earlier statement that `BC-23` "declares no ports whatsoever" needs precision.** `BC-23` declares **no *outbound* port block of its own** — there is no `search:` consumer block — but **other modules already declare ports *into* `BC-23`**. The inbound surface exists and is lawful; the **outbound** one (`BC-23` → `BC-18`) does not. This **narrows** decision `ENT` (§9) from *"nothing exists"* to *"the missing piece is precisely one outbound declaration"* |
| **G-2** | ⭐⭐ **P8 is PARTIALLY governed by Rank 4 authority already.** BC Map **L453**: *"Every projection (`BC-26`) and **index (`BC-23`)** must be rebuildable from the log. **This is tested quarterly, not assumed**"* — and `PRD-015` **§34** already cites it as `SRCH-INV-005` | ⭐ **The rebuild *policy* is decided; only the *posture and duration* are open.** P8 therefore splits into a **CLOSED** half (rebuildability, mandatory, Rank 4) and an **OPEN** half (degrade / stale / unavailable, and duration). §8 presents only the open half |
| **G-3** | ⭐⭐ **EA declares the entire search capability tree at V2/V3, not V1.** `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1516-1560**: *Global Search (V2)*, *Full Text Search (V2)* with *"Tokenisation & Analysers (V2)"*, *"Fuzzy Matching (V2)"*, *"**Synonyms (V3)**"*, *"**Multi-Language Support (V3)**"*, *Search Index (V2)* with *"Bulk Reindexing (V2)"*, *Search Suggestions (V3)* incl. *"Autocomplete (V3)"* | ⚠⚠ **A precedence question the Architecture Owner must see.** EA is **Rank 6 Descriptive** — `DOCUMENTATION_BASELINE.md` **L139**: *"must follow the PRDs, never lead them"* — so it **cannot** veto a V1 capability. But two nodes bear directly on approved V1 behaviour: **Multi-Language Support is tagged V3** while `SRCHPO-1` approved Hindi for **V1**, and **Synonyms is tagged V3** while §20 **V4** requires declared abbreviation pairs. Recorded as **`SRCHAO-C1`** (§10.1); the `ADR-0061` / `ADR-0058` precedent (*Rank 3 outranks an EA V2 tag by precedence; the **EA is NOT edited***) is the governing pattern |
| **G-4** | ⭐ **A sibling PRD already ruled on the same boundary, in `BC-23`'s favour.** `PRD-SEAT-MANAGEMENT.md` **L1863** `SEAT-XC-021`: *"Full-text search, fuzzy matching, phonetic matching, relevance ranking and search-index administration are **out of scope**. `BC-23` Search Indexing owns indexing, and `E-21` does not list `BC-04` as a producer — so this module **MUST NOT** publish to the search index in V1, and **MUST NOT** be given an edge to it without an ADR"* | ⭐ **Independent corroboration** that (a) `BC-23`'s ownership is respected platform-wide, (b) the *"no edge without an ADR"* discipline this packet applies to `ENT` is **already the repository's practice**, and (c) **no duplicate search system exists** — `SEAT-FR-262` serves seat search from its own bounded state instead |

---

## 2. ⛔ The registered P1–P8 meanings — reproduced so they cannot drift

Instruction §2 is **CRITICAL** and is honoured literally. These are the subject's **own** §36 rows
(**L833-842**), verbatim:

| # | Registered meaning | Required to exist by |
|---|---|---|
| **P1** | Search engine / index technology selection | §0.3 |
| **P2** | Analyzer, tokenizer and normalization rule **configuration** | `SRCH-FR-023`, `SRCH-FR-024` |
| **P3** | **Edit-distance bound** and minimum token length for tolerance | `SRCH-BR-012` C2, C3 |
| **P4** | **Minimum prefix length** for partial matching | `SRCH-FR-030` |
| **P5** | Maximum **page size** cap | `SRCH-FR-039` |
| **P6** | Acceptable **projection lag** per event class (except `SEV-9`) | §32 |
| **P7** | Query **latency, throughput and availability** targets | §36 |
| **P8** | **Rebuild** availability posture and duration | §34 |

⛔ **No P-row is relabelled anywhere in this packet.** The already-approved *behaviour* decisions
(`SRCHPO-4`…`SRCHPO-10`) are **separate** from these implementation/design parameters and are never conflated
with them — the exact confusion the previous pass caught and instruction §2 forbids.

---

## 3. ⭐ Architecture Owner decision table — master index

| ID | Decision | Repository evidence | Recommended option | Alternatives | Impact | Owner |
|---|---|---|---|---|---|---|
| **`SRCHAO-P1`** | Search engine / index technology | ⛔ **0** authoritative hits (§4) | ⛔ **NONE — no recommendation made** (§4.2) | 4 candidate classes, all **NOT APPROVED** | Determines P2, P3, P4, P7, P8 feasibility | **Architecture Owner** |
| **`SRCHAO-P2`** | Analyzer / tokenizer configuration | Behaviour fixed by `SRCH-FR-023`/`024`; scripts fixed by `SRCHPO-1`; ⛔ config absent | ⛔ **NONE** — but the *requirement set* is now fully derivable (§5.1) | Gated on `P1` | Determines whether Devanagari behaviour is correct | **Architecture Owner** |
| **`SRCHAO-P3`** | Edit-distance bound + min token length | ⛔ **0** hits for `levenshtein\|edit.distance\|damerau\|fuzziness` | ⛔ **NONE** — 3 posture classes offered (§6) | strict / moderate / permissive | False positives ↔ typo recall; abuse surface | **Architecture Owner** |
| **`SRCHAO-P4`** | Minimum prefix length | ⛔ **0** hits | ⛔ **NONE** — 3 approaches offered (§7) | fixed / tier-scoped / field-scoped | Autocomplete quality; enumeration cost | **Architecture Owner** |
| **`SRCHAO-P5`** | Page size cap | ✅ **`LCFG-12`** = **20**, range 5–50, Security | ✅ **Cite, do not re-decide** (§8.1) | — | ⚠ Traceability only | **Architecture Owner** (citation) |
| **`SRCHAO-P6`** | Projection lag / removal latency | ✅ **`LCFG-6`** = **60 s**, range 0–300 s, Security | ✅ **Cite, do not re-decide; do not widen** (§8.2) | — | ⚠ Traceability + misuse risk | **Architecture Owner** (citation) |
| **`SRCHAO-P7`** | Latency / throughput / availability | ⛔ **0** targets for `BC-23`; subject **L826-827** says so explicitly | ⛔ **NONE — no SLA approved** (§9.1) | 3 target *classes*, all **NOT APPROVED** | Operational commitment | **Architecture Owner** |
| **`SRCHAO-P8`** | Rebuild posture and duration | ⭐ **Split** — rebuildability **CLOSED** by BC Map **L453**; posture/duration **OPEN** (§9.2) | ⛔ **NONE** for the open half | 3 postures | Availability during rebuild | **Architecture Owner** |
| **`SRCHAO-ENT`** | Query-time entitlement mechanism | ⭐⭐ **G-1** narrows it: inbound ports exist; the **outbound** declaration does not | ⛔ **NONE** — 3 lawful shapes identified (§10.2) | edge / module-block port / consumer-mediated | ⭐⭐⭐ **Security-critical** | **Architecture Owner** |
| **`SRCHAO-EDGE`** | Whether a numbered `BC-23` → `BC-18` edge is required | BC Map §7 has **0** such edge; **L292** governs; `SEAT-XC-021` shows the discipline | ⛔ **NONE** — ⛔ no edge ID manufactured (§10.3) | Subsumed by `ENT` | Rank 4 ⇒ **ADR first** | **Architecture Owner** |
| **`SRCHAO-VOC`** | Variant / abbreviation vocabulary | ⛔ **0** authority; EA tags *Synonyms* **V3** | ⛔ **NONE** (§10.4) | 3 scopes | §20 **V4** unusable until decided | ⭐ **Product Owner** |
| **`SRCHAO-R1`** | Student Identity `SID-4.38`…`4.41` disposition | §4.9 titled `BC-23`; subject `SID-` × **0**; §6.2 excludes student discovery | ⛔ **NONE** — two lawful dispositions (§10.5) | carry / rule discharged | Latent now; live on enablement | **Architecture Owner** |
| **`SRCHAO-R2`** | Trust & Safety `TSF-FR-023` / `TSF-INV-005` disposition | §8.3 names `BC-23` step **[4]**; subject `TSF-` × **0** | ⛔ **NONE** — two lawful dispositions (§10.6) | carry / rule discharged | Same | **Architecture Owner** |
| **`SRCHAO-CONF`** | Stage-3 conferral for this specific act | `PRD_OWNERSHIP_MODEL.md` **L197**, §7 rule 4, §12.1; `ADR-0033` §7.1 | ⛔ **NONE — cannot be recommended** | — | Gates limb **C** | ⭐ **Human principal** |

**14 decisions presented · 0 taken.**

---

## 4. `SRCHAO-P1` — search engine / index technology

### 4.1 The search performed

| Term searched across all of `docs/` | Hits |
|---|---|
| `elasticsearch`, `opensearch`, `meilisearch`, `typesense`, `algolia`, `pg_trgm`, `tsvector`, `lucene`, `solr`, `sphinx`, `vespa` | ⛔ **0 authoritative** |
| `full.text search` | **2**, ⭐ **both non-authoritative for P1** — EA **L1523** *"Full Text Search (V2)"* is a **Rank 6 descriptive capability node** naming no technology; `PRD-SEAT-MANAGEMENT.md` **L1863** is an **out-of-scope disclaimer** (**G-4**) |

⭐ **No authoritative technology decision exists.** The subject already says so at **L826-828**, and `ADR-0094` §5
confirms it decided *the contract, not the engine*.

### 4.2 ⛔ No recommendation is made — and why that is the correct output

Instruction §4: *"DO NOT choose a technology merely because it is popular."* A technology choice is inseparable
from operational context — hosting, cost, team skills, data residency — **none of which this repository states**.
⛔ Recommending one would be exactly the invention the instruction forbids.

**Status: `ARCHITECTURE DECISION REQUIRED`.**

### 4.3 Candidate classes — ⛔ **OPTIONS ONLY, NOT APPROVED**

⚠ Presented as **classes** rather than product endorsements. Every cell is a *capability question the owner must
verify against the chosen product's own documentation* — ⛔ **not a claim made by this packet**.

| | **A — Dedicated search engine** | **B — RDBMS-native full-text** | **C — Embedded / lightweight search service** | **D — Managed SaaS search** |
|---|---|---|---|---|
| **Matching capability (T1/T2/T3)** | Tier ladder maps naturally | ⚠ Verify tier separation is expressible | Tier ladder typically native | Typically native |
| **Hindi / Devanagari** | ⚠ **MUST be verified** — Unicode + script-aware analysis | ⚠ **MUST be verified** — often the weakest area | ⚠ **MUST be verified** | ⚠ **MUST be verified** |
| **Typo tolerance (T3)** | Usually native | ⚠ Often requires an extension | Usually native | Usually native |
| **Prefix search** | Usually native | ⚠ Often index-strategy dependent | Usually native | Usually native |
| **Operational fit** | Separate service to run | ⭐ No new datastore | Separate service, lighter | ⛔ External dependency |
| **Tenant isolation** | ⚠ Must satisfy `SRCH-INV-004`, `SRCH-BR-004`, `X-13` **whichever is chosen** | Same | Same | ⚠⚠ **Plus** data-residency and processor questions |
| **Repository compatibility** | ⚠ Must honour `SRCH-FR-035` — **tier + field precedence + stable tiebreak, no numeric score**. ⛔ Any engine whose ordering *cannot* be constrained to this is **non-conformant** | Same | Same | Same |
| **Major tradeoff** | Operational weight | Capability ceiling | Ecosystem maturity | ⛔ Egress of indexed data |

⭐⭐ **One repository constraint binds every option and should be read first.** `SRCH-FR-035` (**L578-590**) and
**L597-600** establish there is **no numeric relevance score** in this model, deliberately, because *"a score
would require weights; weights are not authorised (`SRCH-XC-009`)"*. ⛔ **An engine cannot be selected on the
strength of its scoring quality**, because its scoring must be **suppressed or constrained** to tier + field
precedence + stable tiebreak. This inverts the usual selection criterion and is easy to miss.

⚠ **Option D additionally engages the Privacy Owner** — an office `PRD_OWNERSHIP_MODEL.md` **L509** records as
**VACANT** — because indexed data would leave the platform boundary. ⛔ This packet takes no view; it flags that
D has a second, currently unfillable, approval dependency.

---

## 5. `SRCHAO-P2` — analyzer / tokenizer configuration

### 5.1 ⭐ Required behaviour — fully derivable, and derived here

This is the packet's most useful contribution to P2: the **requirement set is now complete**, even though the
configuration is not. Nothing below is invented — each row cites the requirement that creates it.

| # | Analyzer must deliver | Required by | Script scope |
|---|---|---|---|
| 1 | **Case folding** — matching case-insensitive | `SRCH-FR-024` **N1** | Latin. ⚠ **Devanagari is unicameral — it has no case.** A configuration that assumes case folding is universal is wrong for Hindi |
| 2 | **Whitespace** collapse | **N2** | Both |
| 3 | **Punctuation / separator** normalization (`St. Mary's` ≡ `St Marys`) | **N3** | ⚠ Both — Devanagari uses the **danda** (`।`) as a separator, not a full stop |
| 4 | **Unicode canonical normalization + compatible diacritic folding** | **N4** | ⚠⚠ Both, and **NFC vs NFD matters more for Devanagari than for Latin** — matras and nukta forms have multiple encodings |
| 5 | **Tokenization** on normalized separators | **N5** | ⚠ Both — ⛔ Devanagari word boundaries are **not** identical to Latin whitespace rules |
| 6 | **Zero-width / control / formatting** character removal | **N6** | ⚠⚠ **Critical for Devanagari** — ZWJ/ZWNJ (`U+200D`/`U+200C`) are **meaningful** in Indic conjuncts, so blanket removal may corrupt tokens while retention may permit invisible-character spoofing. ⭐ **This is a genuine tension the owner must resolve** |
| 7 | **Symmetry and totality** — every query transform applied to indexed terms and vice versa | `SRCH-BR-008` | Both — ⛔ asymmetry makes documents *permanently unreachable* |
| 8 | Support for **T2 token + prefix** and **T3 typo + word-form** matching | `SRCH-FR-029`/`030`/`031`/`033` | Both |
| 9 | ⚠ **Hinglish tolerance where technically validated** | `SRCHPO-2`/`3` | ⛔ Permitted, **not required**; ⛔ no transliteration rule authorised |

### 5.2 Existing repository authority

| Question | Authority |
|---|---|
| Which scripts must be handled? | ✅ **`SRCHPO-1`** — English/Latin + Hindi/Devanagari, closed set |
| What must normalization do? | ✅ `SRCH-FR-023`/`024` **N1–N6** |
| Must it be symmetric? | ✅ `SRCH-BR-008` |
| May equivalence be learned? | ⛔ **No** — `SRCH-BR-011`: not *"from usage, click behaviour, co-occurrence or any learned model"* |
| Which library / configuration? | ⛔ **Absent** |
| Which stemmer? | ⛔ **Absent** — and ⛔ not invented (`SRCHPO` §2.3) |

### 5.3 ⛔ Decisions still requiring approval

1. The analyzer/tokenizer **configuration** for Latin and Devanagari (gated on `P1`).
2. ⭐ The **ZWJ/ZWNJ policy** (row 6) — a genuine correctness-versus-spoofing tension, surfaced here for the
   first time.
3. ⭐ Whether **N1 case folding** is declared *not applicable* to Devanagari, or silently no-ops — ⚠ these differ
   for `SRCH-BR-008` symmetry auditing.
4. Whether **Hinglish** tolerance is validated and enabled, or deferred.

⛔ No library, no stemming rule, no transliteration rule, no language detection is proposed.

---

## 6. `SRCHAO-P3` — edit-distance bound + minimum token length

**Search:** `levenshtein|edit.distance|damerau|fuzziness` across `docs/` → ⛔ **0 hits.** No authoritative value.

**What the repository already fixes** — `SRCH-BR-012` (**L561-570**): **C1** never on exact-role fields · **C2**
never below a declared minimum token length · **C3** the bound must be **bounded and uniform across consumers** ·
**C4** a T3 match never outranks T1/T2 · **C5** never widens authorisation, tenant scope or field eligibility.
⭐ *"an implementation that cannot satisfy them **MUST NOT** enable it."*

### Posture classes — ⛔ **OPTIONS ONLY, NONE APPROVED**

| | **Strict** | **Moderate** | **Permissive** |
|---|---|---|---|
| Typo recall | Lower | Balanced | Higher |
| False positives | Lowest | Moderate | ⚠ Highest |
| Performance | Cheapest | Moderate | ⚠ Most expensive |
| Short-token behaviour | ⭐ Safest — short tokens are *mutually reachable*, exactly C2's stated reason | Requires a well-chosen floor | ⚠⚠ Degenerates: at high tolerance, short tokens match almost anything |
| ⚠⚠ **Hindi behaviour** | ⭐ **Read this before choosing.** Devanagari's **matra** marks are separate code points, so a single visual "letter" may be **2–3 code points**. A bound measured in code points is therefore **not** equivalent in strictness across the two scripts — ⛔ a value tuned on English may be far more permissive in Hindi | Same tension | ⚠⚠ Most exposed |
| Security / abuse | ⭐ Smallest surface | Moderate | ⚠ Larger `SRCH-GAP-008` surface (rate limiting, **`OWNER NOT ESTABLISHED`**) |

⭐⭐ **The Hindi row is a new finding and is the reason a single scalar may not satisfy `C3`'s uniformity
requirement.** ⛔ This packet does **not** propose a per-script bound — it flags that the owner must decide
whether C3's *"uniform across consumers"* is satisfied by one value across two scripts.

**Status: `ARCHITECTURE OWNER DECISION REQUIRED`.** ⛔ No number appears in this section.

---

## 7. `SRCHAO-P4` — minimum prefix length

**Search:** ⛔ **0** authoritative hits. `SRCH-FR-030` (**L520-522**) requires prefix matching and forbids suffix
or infix matching on **exact**-role fields; it fixes **no length**.

### Approaches — ⛔ **OPTIONS ONLY, NONE APPROVED**

| | **A — single fixed minimum** | **B — tier-scoped** | **C — field-scoped** |
|---|---|---|---|
| Autocomplete | Predictable | Better UX at T2 | Best for name-like fields |
| False-positive risk | ⚠ One value must serve every field | Moderate | Lowest |
| Index / query cost | Lowest | Moderate | ⚠ Highest |
| Short-token ambiguity | ⚠⚠ Worst case governs | Better | Best |
| ⚠ Devanagari | Same code-point-vs-grapheme caveat as §6 | Same | Same |
| Complexity | ⭐ Simplest to audit | Moderate | ⚠ Hardest to keep uniform |

⚠ **Interaction the owner must see:** EA **L1547** tags *"Autocomplete (V3)"*, while `SRCH-FR-030` requires
prefix matching in the **V1** capability. ⭐ These are **different objects** — prefix *matching* is not
*autocomplete suggestion* — but the distinction should be stated deliberately rather than assumed
(cf. `ADR-0061`'s *"the two describe different objects"*). Recorded with **`SRCHAO-C1`**.

**Status: `ARCHITECTURE OWNER DECISION REQUIRED`.** ⛔ No number appears in this section.

---

## 8. `SRCHAO-P5` and `SRCHAO-P6` — existing configuration, verified not re-decided

### 8.1 `LCFG-12` — public search page size

| Field | Value |
|---|---|
| Value / range / owner | **20** · **5 – 50** · **Security** |
| Rationale | *"Bounds enumeration rate and page weight"* |
| Declared | `14B-Public-Library-Preview.md` **L342**, **L374** |
| Valued | `CONFIGURATION_GUIDE.md` §2A **L362**; environment table **L804** (dev 50 / staging 20 / **prod 20**); monitoring **L885** |
| Satisfies | `SRCH-FR-039` (P5) |

✅ **Verified. ⛔ Not duplicated, not changed.** **Required act:** `PRD-015` must **cite** it — measured `LCFG` × **0**
in the subject (`SRCHCL-C2` / `SRCHPO-C1`).

### 8.2 `LCFG-6` — discovery index propagation

| Field | Value |
|---|---|
| Value / range / owner | **60 s** · **0 – 300 s** · **Security** |
| Scope | ⭐⭐ *"Public index is eventually consistent. **Removal latency only**"* — `CONFIGURATION_GUIDE.md` **L356**; `Library_PRD_v1.md` **L721**: *"**Applies only to Public→Private removal latency**"* |
| Guard | `LIB-16.9` (**L727**): *"`LCFG-6` **MUST NOT** be applied to any authorization, membership,"* … |
| Guide §-heading | **L372** — *"`LCFG-6` — the value most likely to be misused"* |

✅ **Verified. ⛔ Not duplicated, not changed, and ⛔ NOT reinterpreted as a general freshness SLO** — instruction
§9 required this and the repository independently warns of the same misuse twice. ⭐ **Consequence for P7:**
`LCFG-6` does **not** supply a freshness target; P7's freshness limb remains **OPEN**.

---

## 9. `SRCHAO-P7` and `SRCHAO-P8`

### 9.1 P7 — performance / availability

**Search:** `latency budget|p95|p99|throughput|availability target|uptime|SLO|SLA` across `docs/10-architecture/`
and `docs/00-governance/` → ⛔ **no `BC-23` target.** Hits are generic platform prose (BC Map **L452** DLQ depth
*"SLO-monitored"*; EA **L322** *"Service SLAs (V3)"*; EA **L87**/**L210** observability commentary). The subject
states it directly at **L826-827**: *"no repository authority states a latency budget, throughput target,
index-size limit, freshness SLO or availability target for `BC-23`."*

**Candidate target *classes* — ⛔ NOT APPROVED. ⛔ No number appears in this section.**

| Class | What would be committed | ⚠ Note |
|---|---|---|
| **Query latency** | A percentile-based read-path budget | ⚠ Must be stated **per tier** or it is unmeasurable — T3 typo matching is inherently costlier than T1 |
| **Throughput** | Sustained query rate | ⚠ Entangled with `SRCH-GAP-008` (rate limiting), whose owner is **NOT ESTABLISHED** |
| **Availability** | Uptime for the query port | ⚠ Must interact with P8's rebuild posture — ⭐ *a rebuild that makes search unavailable consumes the availability budget* |
| **Freshness** | Index lag for **non-removal** events | ⭐⭐ **Distinct from `LCFG-6`**, which is removal-only (§8.2). ⛔ Do not conflate |
| **Index size** | Growth ceiling | ⚠ Gated on `P1` |

⛔ **No SLA is approved by this task.** **Status: `ARCHITECTURE OWNER DECISION REQUIRED`.**

### 9.2 P8 — rebuild posture ⭐ **(the split, per G-2)**

| Half | Status | Authority |
|---|---|---|
| **Rebuildability itself** | ✅ **CLOSED — mandatory** | BC Map **L453** (**Rank 4**): *"Every projection (`BC-26`) and **index (`BC-23`)** must be rebuildable from the log. **This is tested quarterly, not assumed**"*; reproduced in the subject as `SRCH-INV-005` (**L798-799**) |
| **Rebuild correctness** | ✅ **CLOSED** | §34: a rebuilt index **MUST** be equivalent for matching and ordering (`SRCH-FR-034` makes this checkable), and **MUST NOT** re-admit removed documents (`SRCH-FR-011`/`012`/`013`/`014`) |
| **Trigger** | ⚠ **PARTIAL** | *"tested quarterly"* implies a **periodic** exercise; ⛔ whether that is the only trigger is undecided |
| **Availability posture** | ⛔ **OPEN** | §34 **L806-807**: *"whether search degrades, serves stale, or is unavailable during a rebuild — is an operational decision recorded in `SRCH-GAP-002`"* |
| **Duration target** | ⛔ **OPEN** | ⛔ **0** authority; ⛔ no duration invented |
| **Full vs incremental** | ⛔ **OPEN** | EA **L1535** tags *"Bulk Reindexing (V2)"* — Rank 6 descriptive, ⛔ not a decision |

**Posture options — ⛔ NOT APPROVED:** **(a)** serve stale from the old index until cutover — highest
availability, ⚠ but `SRCH-FR-013`/`014` revocation semantics must still hold on the *stale* index, which is a
**security** question, not merely operational; **(b)** degrade to a reduced tier set — ⚠ changes matching
behaviour mid-rebuild, so `SRCH-FR-034` determinism must be re-examined; **(c)** unavailable during rebuild —
simplest and safest, ⚠ but consumes the P7 availability budget.

⭐ **Option (a) is the one that carries a hidden security question** — surfaced here rather than left implicit.

**Status: `ARCHITECTURE OWNER DECISION REQUIRED` (open half only).**

---

## 10. Boundary, entitlement, vocabulary and the two raised findings

### 10.1 `SRCHAO-C1` — the EA V2/V3 precedence question ⭐ **(new, per G-3)**

| Fact | Evidence |
|---|---|
| EA declares the search tree at **V2/V3** | **L1516-1560** |
| EA is **Rank 6, Descriptive** | `DOCUMENTATION_BASELINE.md` **L139**: *"must follow the PRDs, never lead them"* |
| A Rank 3 statement **outranks** an EA version tag by precedence, and ⛔ **the EA is NOT edited** | `ADR-0061`; `ADR-0058` / `FIL-GAP-015` precedent (*"the two describe different objects"*) |
| ⚠ Two nodes touch approved V1 behaviour | *"Multi-Language Support (**V3**)"* **L1528** vs `SRCHPO-1` approving Hindi for **V1**; *"Synonyms (**V3**)"* **L1527** vs §20 **V4** declared abbreviation pairs |
| ⚠ `PRD-015` is **not yet Rank 3** | It is **v0.1 `DRAFT`**, registry `PLANNED` — so ⛔ **the `ADR-0061` precedence argument is not yet available to it** |

⭐⭐ **This is the finding most likely to be missed.** The usual resolution (*Rank 3 outranks a Rank 6 tag*)
**does not yet apply**, because the subject has no rank. ⛔ **Raised, not resolved** — Architecture Owner.

### 10.2 `SRCHAO-ENT` — query-time entitlement ⭐⭐⭐ **security-critical**

**Formalised (restating existing authority, deciding nothing):**

| Statement | Authority |
|---|---|
| **`BC-18` = authorization decision authority** | BC Map **L127**: *"Owns credentials, sessions, devices, OTP, roles, permissions, **policy decisions**, consent"*; `X-13` |
| **`BC-23` = search / index / retrieval authority** | BC Map **L132**: *"Owns indices, permission-aware indexing, tenant index isolation, relevance, query rewriting"* |
| **Search cannot return a resource the principal is not authorized to see** | §27 (**L662-712**); `SRCH-FR-001`/`007`/`INV-002`/`INV-004`/`FR-020`/`XC-016`/`FR-040`/`FR-013`/`FR-042` |

**⭐⭐ Existing authorization-consumption patterns found (instruction §12: *"If a lawful existing pattern exists,
cite it"*):**

| Pattern | Where | Shape |
|---|---|---|
| ⭐ **`identity.policy_decision` as a declared port** | Matrix **L193** `library_management` (*"authorisation check"*), **L220** `person_identity` (⭐⭐ *"**ask BC-18, never evaluate or cache**"*), **L248**, **L272**, **L290**, **L305** | **6 modules** already consume `BC-18`'s decision this way. ⭐ This **is** the repository's established pattern |
| ⭐ **Inbound ports into `BC-23` already exist** (**G-1**) | `search.indexer` at **L194**, **L221**, **L249**; `search.retrieval # permission-aware retrieval ONLY` at **L273** | The write-side and AI read-side are declared |
| ⚠ **`BC-23` has no module block of its own** | Matrix §6 defines `library_management`, `person_identity`, `student_network`, `ai`, `analytics`, `workflow`, `audit:` (**L313**) — ⛔ **no `search:`** | ⇒ `BC-23` can declare **no outbound port**, including `identity.policy_decision` |
| ⚠ `search` absent from `identity.policy_decision`'s consumers | The six modules above do **not** include `search` | ⇒ the pattern exists but **has not been extended to `BC-23`** |

⭐⭐⭐ **The precise missing architectural decision, stated exactly:**

> **`BC-23` must consume `BC-18`'s policy decision at query time, by the same
> `identity.policy_decision` pattern six other modules already use — but `BC-23` has no Matrix §6 module block in
> which to declare that port, and no BC Map §7 edge that would authorise the call. One of those two Rank 4
> registers must admit it. ⛔ Which one, and in what shape, is the Architecture Owner's decision.**

**Three lawful shapes — ⛔ NONE recommended, ⛔ none named, ⛔ nothing invented:** **(1)** a numbered BC Map §7
edge `BC-23` → `BC-18`; **(2)** a `search:` module block in Matrix §6 declaring `identity.policy_decision`;
**(3)** consumer-mediated — the *consumer* supplies an already-evaluated decision to the query port, so `BC-23`
never calls `BC-18`. ⚠ Shape (3) is the only one requiring **no** Rank 4 amendment, ⛔ but it moves an obligation
onto every consumer and must be tested against `SRCH-FR-002`'s *"single entry point … one matching semantics
platform-wide"*.

⛔ **Nothing invented:** no API, RPC, endpoint, event, token, entitlement object, port name or edge ID.

**Status: `ARCHITECTURE OWNER DECISION REQUIRED`.**

### 10.3 `SRCHAO-EDGE` — is an edge required?

⛔ **Not manufactured.** BC Map **L292**: *"If an edge is not in this table, it does not exist."* Both candidate
registers are **Rank 4** ⇒ `DOCUMENTATION_BASELINE.md` §7 rule 1 requires an **ADR first**, and instruction §24
forbids creating one here. ⭐ **`SEAT-XC-021` (G-4) shows this is already the repository's practice**: *"**MUST
NOT** be given an edge to it without an ADR."* ⛔ No `E-nn` number is proposed; `E-27` remains permanently vacant
and is ⛔ **not** reusable (`PRD_LIFECYCLE.md` §5 rule 5).

**Raised. Subsumed by `SRCHAO-ENT`.**

### 10.4 `SRCHAO-VOC` — variant / abbreviation vocabulary ⭐ **Product-owned**

**Search:** `synonym|abbreviation|alias|short form` across library, configuration and architecture docs → ⛔ **0
authoritative vocabulary.** The three hits are: BC Map **L844** (a *prohibition* on aliasing `communityId`), EA
**L1527** (*"Synonyms (**V3**)"* — Rank 6 tag), EA **L2436** (a *style* rule).

`SRCH-BR-011` (**L548-549**) requires equivalence to derive from a **declared** rule set or vocabulary, and §20's
note (**L552-553**) is explicit: *"An undeclared abbreviation table is indistinguishable from invented product
vocabulary, which `SRCH-XC-014` forbids… the *vocabulary inventory* is `SRCH-GAP-007` (§16), owner **Product
Owner**."*

**Scope options — ⛔ NONE recommended, ⛔ no vocabulary listed:** **(a)** English abbreviations only; **(b)**
English + Hindi variants; **(c)** ⭐ **defer V4 entirely for V1** — ⚠ note that §20 **V1/V2/V3** (singular-plural,
word forms, spelling variants) do **not** depend on a declared table, so deferring **V4 alone** leaves T3 largely
functional. ⭐ This third option was not previously visible and materially reduces the blocking surface.

**Status: `PRODUCT DECISION REQUIRED`.**

### 10.5 `SRCHAO-R1` — Student Identity

| Question (instruction §15) | Answer |
|---|---|
| Which obligations bind `BC-23`? | `SID-4.39` (*"in any index, for any purpose"*), `SID-4.40` (removal *"as part of the same operation, not on the next scheduled reindex"*), `SID-4.41` (*"**SHALL NOT** confirm or deny"*). §4.9 is **titled** *"Search Indexing — `BC-23` (`E-21`)"* |
| Which belong to consumers? | `SID-4.38`'s first limb — `BC-10` drives discoverability by **events**; its second limb (*"`BC-23` **SHALL NOT** read this module's store"*) binds `BC-23` |
| Does V1 index student records? | ⛔ **NO** — §6.2 (**L521**) excludes `PRD-021B` student discovery (`SRCH-GAP-005`); `ADR-0094` §2 rule 4 confines V1 to §14A library scope |
| Latent or live? | ⭐ **LATENT** |
| What must happen before student discovery is enabled? | (1) `E-21` consumer authority for `BC-11`/`BC-12` (`SRCH-GAP-005`, ADR); (2) `SID-4.39`'s allow-list must bind `BC-23`'s field eligibility; (3) `SID-4.40`'s **no-propagation-window** rule must be reconciled with **`LCFG-6`'s 60 s** — ⭐⭐ **these are in tension and the tension is new**: `SID-4.40` says *same operation*, `LCFG-6` allows 60 s, and `LIB-16.9` already forbids using `LCFG-6` on authorization paths; (4) `SID-4.41`'s mobile-number prohibition must bind the query port |

⛔ Frozen `Student_Identity_PRD_v1.md` **0 bytes**; ⛔ no ownership transferred.

**Two lawful dispositions — ⛔ neither taken:** **(A)** carry the four obligations into `PRD-015` as owner-side
traceability; **(B)** rule authoritatively that they bind only on enablement and record that ruling.

### 10.6 `SRCHAO-R2` — Trust & Safety

| Question (instruction §16) | Answer |
|---|---|
| Must `BC-23` provide a safety hook? | ⚠ **Not in V1** — but `TSF-INV-005` binds *"a ranking or recommendation path that **reaches the index**"*, and `SRCH-FR-035` has **no hook** for a step-[3] filter (`SRCHPO-C2`) |
| Latent because student discovery is excluded? | ✅ **Yes** — §8.3's pipeline is **person** discovery; §6.2 excludes it |
| What must happen before the consumer is enabled? | Same `SRCH-GAP-005` gate, **plus** a decision on where step [3] executes relative to `BC-23`'s tiers |
| Does `BC-13` remain the safety authority? | ✅ **YES.** §8.3 **L556** marks step [3] *"← THIS PRD"* (`BC-13`) and gives `BC-23` only step **[4] Ranking — relevance** |

⛔ Frozen `PRD-020` **0 bytes**; ⛔ **no Trust & Safety ownership moved to `BC-23`**; ⛔ search relevance does not
become a T&S authority.

**Two lawful dispositions — ⛔ neither taken:** **(A)** carry `TSF-FR-023`/`TSF-INV-005` into `PRD-015` as a
consumer-side obligation on the query port; **(B)** rule that they bind on enablement and record it.

### 10.7 Flexible search — preserved, re-verified at `a7ec941`

| Behaviour | Requirement | Status |
|---|---|---|
| Case-insensitive · whitespace · punctuation · Unicode/diacritic · tokenization · invisible-char removal | `SRCH-FR-024` **N1–N6** | ✅ |
| Order-independent multi-token | `SRCH-FR-029` (`lib central` → *Central Library*) | ✅ |
| Partial / prefix | `SRCH-FR-030` (**`Central Lib` → *Central Library***) | ✅ |
| Singular / plural, symmetric | `SRCH-FR-031` V1 + `SRCH-FR-032` (**`library` ↔ `libraries`**) | ✅ |
| Bounded minor typo | `SRCH-FR-033` (**`Centrl` → *Central***) | ✅ |
| Multi-word conjunctive | `SRCH-BR-010` | ✅ |
| Irrelevant-query exclusion | §22.3 (`xylophone` → nothing) | ✅ |

⛔ **Not weakened. 0 numeric thresholds introduced in this step**, per instruction §17.

---

## 11. Five-expert review of every unresolved decision

Each expert reviewed **all 14** items on its own criteria.

| Expert | Verdict | Key finding |
|---|---|---|
| **Product Architect** | ⚠ **CONDITIONAL** | User value is intact and V1 language scope is explicit. ⭐ **New:** `SRCHAO-VOC` option (c) — deferring **V4 alone** — leaves §20 V1–V3 functional, materially shrinking the blocking surface. ⚠ Future consumers (`PRD-021B`, `BC-27`) are gated, not forgotten. ⛔ No duplicate search system: `SEAT-XC-021` confirms it platform-wide |
| **Enterprise / Domain Architect** | ⚠ **CONDITIONAL** | ⭐⭐ **`BC-23` does not lack ports — it lacks an *outbound* declaration** (**G-1**). Six modules already consume `identity.policy_decision`; three already declare `search.indexer`. ⛔ No edge created; ⛔ no BC created; no circular dependency (`BC-23` is the source of **0** edges). ⚠ **`SRCHAO-C1`**: the `ADR-0061` precedence route is **unavailable** while `PRD-015` is unranked |
| **Search / IR Architect** | ⚠ **CONDITIONAL** | All ten behaviours preserved; **0** thresholds invented. ⭐⭐ **Three new script-specific risks surfaced:** Devanagari is **unicameral** (N1 has no meaning there); **ZWJ/ZWNJ** removal under N6 is a correctness-vs-spoofing tension; a **code-point** edit-distance bound is **not** equivalent in strictness across Latin and Devanagari, which stresses `SRCH-BR-012` **C3**'s uniformity requirement. ⭐ Also: an engine must be selectable **despite** its scoring, since `SRCH-FR-035` permits **no numeric score** |
| **Security / Privacy / Multi-Tenancy** | ⚠ **CONDITIONAL** | `BC-18` authority intact; tenant isolation intact; corpus-statistic channel **structurally absent** (7 prohibitions); `BC-18` × 0, credential × 0, OTP × 0, session × 1 (a prohibition). ⛔ `ENT` remains **OPEN** ⇒ the surface cannot be certified. ⭐⭐ **Two new security-shaped findings:** P8 posture **(a)** *serve stale* silently engages `SRCH-FR-013`/`014` revocation semantics; and **`SID-4.40`'s *same-operation* removal is in tension with `LCFG-6`'s 60 s**. ⚠ P1 option **D** additionally requires the **VACANT** Privacy Owner |
| **QA / Governance / Architecture Reviewer** | ⛔ **BLOCKED** | ⭐ The packet is lawful: **0** decisions taken, **0** values invented, **0** frozen documents touched, **0** ADRs, reserved numbers untouched, P1–P8 meanings preserved verbatim (instruction §2). ⛔ **But it closes no Stage-3 blocker**, because a *decision packet* is not a *decision*. Conferral authority remains **invalid for this act**: the ARB office exists (**L197**) but is **VACANT** (§7 rule 4) and fillable only per act (§12.1), which `ADR-0033` §7.1 bars inheriting |

**0 of 5 support conferral — 4 CONDITIONAL, 1 BLOCKED. Unanimous.**

---

## 12. HUMAN ARCHITECTURE OWNER DECISIONS REQUIRED

⛔ **Every `Decision:` field below is DELIBERATELY BLANK and MUST be completed by the authorised owner.** ⛔ This
packet does not fill any of them.

---

**`SRCHAO-P1` — Search engine / index technology**
- **Question:** Which search/index technology serves `BC-23`?
- **Repository evidence:** ⛔ **0** authoritative hits; subject **L826-828**; `ADR-0094` §5.
- **Recommended option:** ⛔ **NONE** — §4.2.
- **Alternatives:** A dedicated engine · B RDBMS-native · C embedded service · D managed SaaS — ⛔ all **NOT APPROVED**.
- **Consequences:** Gates P2, P3, P4, P7, P8. ⚠ Must be selectable **despite** scoring (`SRCH-FR-035`). ⚠ D also needs the **VACANT** Privacy Owner.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-P2` — Analyzer / tokenizer configuration**
- **Question:** What analyzer configuration satisfies N1–N6 for **Latin and Devanagari**, symmetrically?
- **Repository evidence:** `SRCH-FR-023`/`024`; `SRCH-BR-008`; `SRCH-BR-011`; `SRCHPO-1`.
- **Recommended option:** ⛔ **NONE** — but §5.1's **9-row requirement set** is complete and derived.
- **Alternatives:** Gated on `P1`.
- **Consequences:** ⚠ Three sub-decisions: **ZWJ/ZWNJ** policy · whether **N1** is declared N/A for Devanagari · whether **Hinglish** is validated and enabled.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-P3` — Edit-distance bound + minimum token length**
- **Question:** What bound and minimum token length satisfy `SRCH-BR-012` **C2/C3**?
- **Repository evidence:** ⛔ **0** hits; `SRCH-BR-012` C1–C5.
- **Recommended option:** ⛔ **NONE** — strict / moderate / permissive presented as **classes only**.
- **Alternatives:** §6.
- **Consequences:** ⚠⚠ A code-point bound is **not** equivalent across the two scripts — C3's *"uniform"* may or may not be satisfied by one value. ⚠ Larger tolerance widens the `SRCH-GAP-008` abuse surface (**owner NOT ESTABLISHED**).
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-P4` — Minimum prefix length**
- **Question:** What minimum prefix length applies to `SRCH-FR-030`?
- **Repository evidence:** ⛔ **0** hits.
- **Recommended option:** ⛔ **NONE** — A fixed / B tier-scoped / C field-scoped.
- **Alternatives:** §7.
- **Consequences:** Autocomplete quality ↔ false positives ↔ index cost. ⚠ Distinguish prefix **matching** (V1) from EA's *"Autocomplete (V3)"*.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-P5` — Cite `LCFG-12`**
- **Question:** Confirm P5 is satisfied by `LCFG-12` and require `PRD-015` to cite it.
- **Repository evidence:** `14B` **L374**; `CONFIGURATION_GUIDE.md` **L362**, **L804**.
- **Recommended option:** ✅ **Cite, do not re-decide** — the value exists and is Security-owned.
- **Alternatives:** ⛔ None lawful — ⛔ re-deciding would duplicate a Security-owned configurable.
- **Consequences:** Closes the P5 traceability defect only.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-P6` — Cite `LCFG-6`, scope-limited**
- **Question:** Confirm P6 is satisfied by `LCFG-6` **for removal latency only**.
- **Repository evidence:** `CONFIGURATION_GUIDE.md` **L356**, **L372**; `Library_PRD_v1.md` **L721**; `LIB-16.9` **L727**.
- **Recommended option:** ✅ **Cite; ⛔ do NOT widen into a general freshness SLO.**
- **Alternatives:** ⛔ None lawful.
- **Consequences:** ⚠ P7's freshness limb stays **OPEN**. ⚠ Tension with `SID-4.40` (§10.5) on enablement.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-P7` — Latency / throughput / availability**
- **Question:** What targets, if any, does `BC-23` commit to for V1?
- **Repository evidence:** ⛔ **0** targets; subject **L826-827**.
- **Recommended option:** ⛔ **NONE. No SLA is approved by this task.**
- **Alternatives:** Five target classes, ⛔ all **NOT APPROVED**.
- **Consequences:** ⚠ Latency must be per-tier to be measurable. ⚠ Availability interacts with P8. ⚠ Freshness ≠ `LCFG-6`.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-P8` — Rebuild posture and duration (open half only)**
- **Question:** During rebuild, does search degrade, serve stale, or become unavailable — and over what duration?
- **Repository evidence:** ⭐ Rebuildability **already mandatory** — BC Map **L453**, `SRCH-INV-005`. Posture/duration ⛔ absent (§34 **L806-807**).
- **Recommended option:** ⛔ **NONE**.
- **Alternatives:** (a) stale · (b) degraded · (c) unavailable.
- **Consequences:** ⚠⚠ Option (a) engages `SRCH-FR-013`/`014` **revocation** semantics — a **security** question, not merely operational.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-ENT` — Query-time entitlement mechanism ⭐⭐⭐ security-critical**
- **Question:** By what mechanism does `BC-23` obtain `BC-18`'s entitlement decision at query time?
- **Repository evidence:** ⭐ `identity.policy_decision` consumed by **6** modules (**L193**, **L220**, **L248**, **L272**, **L290**, **L305**); ⭐ `search.indexer` / `search.retrieval` inbound ports exist (**L194**, **L221**, **L249**, **L273**); ⛔ **no `search:` module block**; ⛔ **no `BC-23`→`BC-18` edge**; BC Map **L292**.
- **Recommended option:** ⛔ **NONE** — three lawful shapes at §10.2.
- **Alternatives:** (1) BC Map §7 edge · (2) Matrix §6 `search:` block · (3) consumer-mediated.
- **Consequences:** (1) and (2) are **Rank 4** ⇒ **ADR first**. (3) needs no amendment ⚠ but stresses `SRCH-FR-002`'s single-semantics rule.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-EDGE` — Is a numbered edge required?**
- **Question:** Does the model require an edge, a port, the existing policy-decision pattern, or another shape?
- **Repository evidence:** BC Map **L292**; `SEAT-XC-021` (*"MUST NOT be given an edge … without an ADR"*); `PRD_LIFECYCLE.md` §5 rule 5 (`E-27` never reused).
- **Recommended option:** ⛔ **NONE. ⛔ No edge ID manufactured.**
- **Alternatives:** Subsumed by `SRCHAO-ENT`.
- **Consequences:** Rank 4 ⇒ ADR precedes any register change.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-VOC` — Variant / abbreviation vocabulary ⭐ Product Owner**
- **Question:** What declared vocabulary supports §20 **V4**?
- **Repository evidence:** ⛔ **0** authority; `SRCH-BR-011`; §20 note **L552-553**; EA **L1527** tags *Synonyms* **V3**.
- **Recommended option:** ⛔ **NONE** — ⭐ but option (c), **defer V4 alone**, leaves V1–V3 functional.
- **Alternatives:** (a) English only · (b) English + Hindi · (c) defer V4.
- **Consequences:** Until decided, §20 **V4** cannot be implemented without breaching `SRCH-XC-014`.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-R1` — Student Identity disposition**
- **Question:** Carry `SID-4.38`…`4.41` into `PRD-015`, or rule that they bind on enablement?
- **Repository evidence:** §4.9 **L939-953**; subject `SID-` × **0**; §6.2 exclusion.
- **Recommended option:** ⛔ **NONE** — (A) carry · (B) rule.
- **Consequences:** ⚠⚠ `SID-4.40`'s *same-operation* removal is **in tension with `LCFG-6`'s 60 s** — this must be resolved before student discovery is enabled.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-R2` — Trust & Safety disposition**
- **Question:** Carry `TSF-FR-023`/`TSF-INV-005` into `PRD-015`, or rule that they bind on enablement?
- **Repository evidence:** §8.3 **L550-566**; subject `TSF-` × **0**; `BC-13` remains the safety authority.
- **Recommended option:** ⛔ **NONE** — (A) carry · (B) rule.
- **Consequences:** ⚠ `SRCH-FR-035` has **no hook** for a non-bypassable step-[3] filter (`SRCHPO-C2`). ⛔ T&S ownership must **not** move to `BC-23`.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

**`SRCHAO-C1` — EA V2/V3 precedence ⭐ new**
- **Question:** How is the Rank 6 EA's *Multi-Language Support (V3)* / *Synonyms (V3)* tagging reconciled with V1 behaviour while `PRD-015` is unranked?
- **Repository evidence:** EA **L1516-1560**; `DOCUMENTATION_BASELINE.md` **L139**; `ADR-0061`; `ADR-0058` / `FIL-GAP-015`.
- **Recommended option:** ⛔ **NONE** — ⛔ the EA must **not** be edited (both precedents).
- **Consequences:** ⚠ The usual *Rank 3 outranks a Rank 6 tag* route is **unavailable** until `PRD-015` is ranked.
- **Decision:** `APPROVE / REJECT / DEFER` → **______**
- **Notes:** ______

---

## 13. PRD-015 STAGE-3 ARCHITECTURE CONFERRAL — ⛔ TEMPLATE ONLY

> ⛔⛔ **THIS IS A BLANK TEMPLATE. IT IS NOT A CONFERRAL AND MUST NOT BE READ AS ONE.**
> Nothing in this packet, and nothing in the instruction that produced it, has performed this act.
> ⛔ **The prose below is an unexecuted form.** It becomes an act **only** when the human principal supplies it
> expressly, in their own instruction, naming `PRD-015`.

| Field | Value |
|---|---|
| **Subject** | `PRD-015_SEARCH_INDEXING.md` — sha256 `fe3093e6…c2c4544` |
| **Stage** | **Stage 3 — Architecture Alignment** (`PRD_LIFECYCLE.md` **L86-106**) |
| **Role conferred** | **Architecture Owner / Architecture Reviewer** — the office `PRD_OWNERSHIP_MODEL.md` **L197** records for `PRD-015` as **ARB** |
| **Authority basis** | ⛔ **NOT YET SUPPLIED.** Would be: the human principal's express instruction, on the `ADR-0032` §5.2 / `ADR-0033` §7.2 / `ADR-0036` §8.2 precedent, in the `PRD-008_STAGE3_CONFERRAL.md` **L8** form |
| **Scope of the grant** | ⛔ **Specific act only, NOT a standing licence** — `ADR-0033` **§7.1** |
| **Date** | ⛔ **BLANK** |
| **Explicit approval field** | `CONFERRED / WITHHELD` → **______** ⛔ **BLANK** |
| **Identity / signature** | ⛔ **DELIBERATELY OMITTED.** `PRD_OWNERSHIP_MODEL.md` **§7 rule 4**: *"**Never** record a personal name. If a name is needed operationally, it belongs in a team directory outside the repository."* ⭐ The office is conferred; **no holder is appointed and no personal name is recorded** |
| **What would NOT be asserted** | ⛔ No ARB quorum, attendee list, sign-off date, minutes, Security review or PEA approval — the disclosure every prior one-act conferral carries (`ADR-0033` §7.3; `PRD_OWNERSHIP_MODEL.md` §12.1) |

**The form of words the precedent uses**, reproduced so the principal can see exactly what the act would be —
⛔ **and reproduced as a quotation of the template, not as a statement made by this document**:

> *"I hereby confer Architecture Owner / Architecture Reviewer authority for this specific `PRD-015` Stage-3
> act."*

⚠⚠ **Even if conferred, Stage 3 would still NOT close.** Limbs **A** and **B** fail independently on
`SRCHAO-P1`…`P4`, `P7`, the open half of `P8`, `ENT`, `VOC`, `R1` and `R2`. ⭐ **The conferral is not the
bottleneck — the substantive Architecture Owner decisions are.**

**Current conferral status: ⛔ TEMPLATE ONLY — NOT CONFERRED.**

---

## 14. Closure criteria — exactly what must be true

Stage 3 becomes **`FORMALLY CONFERRED`** when **all seven** hold:

| # | Condition | Now |
|---|---|---|
| 1 | Blocking architectural decisions resolved — `P1`, `P2`, `P3`, `P4`, `P7`, `P8` (open half) | ⛔ **UNMET** — 6 open |
| 2 | Query-time entitlement architecture resolved (`ENT` / `EDGE`), decision residing in `BC-18` | ⛔ **UNMET** |
| 3 | Product-owned vocabulary decision resolved (`VOC`) | ⛔ **UNMET** |
| 4 | `R1` and `R2` dispositions recorded | ⛔ **UNMET** |
| 5 | Architecture Owner authority **valid for this specific act** | ⛔ **UNMET** — office exists, holder not conferred |
| 6 | Formal conferral explicitly performed | ⛔ **UNMET** — §13 is a template |
| 7 | Documentation traceability complete — `PRD-015` cites `LCFG-12` / `LCFG-6` (`SRCHCL-C2`) | ⛔ **UNMET** — `LCFG` × **0** |

**7 of 7 unmet ⇒ `STAGE 3 = CONDITIONAL / NOT CONFERRED`.**

⚠ Two further items are **tracked but not closure conditions**: `SRCH-GAP-001` (`PLANNED`→`DRAFT`, **Governance
Owner**, VACANT) gates **Stage-2** conferral, and `SRCHAO-C1` is raised for ruling.

---

## 15. Validation performed

| # | Check | Result |
|---|---|---|
| 1 | `PRD-015` byte-unchanged | ✅ sha256 `fe3093e6…c2c4544`, **0 bytes** |
| 2 | Three prior records unchanged | ✅ **0 bytes** each |
| 3 | Frozen documents unchanged | ✅ `Student_Identity_PRD_v1.md`, `PRD-020`, `Library_PRD_v1.md`, `14B`, `PRD-SEAT-MANAGEMENT.md` — **0 bytes** |
| 4 | Rank 4 registers unchanged | ✅ BC Map, Dependency Matrix — **0 bytes**; ⛔ no edge, no module block, no port added |
| 5 | Rank 6 EA unchanged | ✅ **0 bytes** — `ADR-0061`/`ADR-0058` precedent honoured |
| 6 | Append-only registers unchanged | ✅ registry, baseline, ownership model — **0 bytes** |
| 7 | Checkers unchanged | ✅ **0 modified**; `alignment_record_freshness.py` `RECORDS` still **2** |
| 8 | New stem collision-checked | ✅ **`SRCHAO-`** — **0** pre-existing occurrences |
| 9 | Architecture invariants | ✅ Contexts **31** · `E-nn` **30**, real edges **29** (`E-27` vacant) · numbered ADRs **86** · `ADR-0088`/`0089`/`0090` **0 files** — **Δ = 0** |
| 10 | P1–P8 registered meanings | ✅ Reproduced **verbatim** (§2); ⛔ **0** relabelled |
| 11 | Invented values | ⛔ **0** — no engine, edit distance, prefix length, token minimum, latency, throughput, availability, rebuild duration, analyzer config, transliteration, stemming, ranking weight, API, endpoint, event, port, edge ID, vocabulary entry or ADR number |
| 12 | Decisions taken | ⛔ **0 of 14** — every `Decision:` field blank |
| 13 | Ten flexible-search behaviours | ✅ All preserved (§10.7) |

---

## 16. ⛔ What this packet does NOT do

| Act | Confirmation |
|---|---|
| Take any Architecture Owner decision | ⛔ **No — 0 of 14** |
| Confer Stage 3 | ⛔ **No** — §13 is a **template only** |
| Recommend a search technology | ⛔ **No** — §4.2 |
| Invent any numeric value | ⛔ **No** — §15 row 11 |
| Create a `BC-23` → `BC-18` edge, port or module block | ⛔ **No** — §10.3 |
| Create or amend an ADR | ⛔ **No** — **0**; reserved numbers untouched |
| Modify `PRD-015` or any prior record | ⛔ **No** — **0 bytes** |
| Modify a frozen document, Rank 4 register or the EA | ⛔ **No** — **0 bytes** |
| Close any gap | ⛔ **No** — all remain as the prior records left them |
| Move Trust & Safety or authorization ownership into `BC-23` | ⛔ **No** |
| Record a personal name | ⛔ **No** — §7 rule 4 |
| Enter Stage 4, perform a Requirements Review, or create `IMPL-*` | ⛔ **No** |
| Write code, migrations, or freeze / baseline / rank / approve | ⛔ **No** |

---

## 17. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-03 | Created as the **Architecture Owner Decision + Stage-3 Conferral Packet**. Presents **14** decisions and takes **0**. ⭐⭐⭐ **Four new measurements:** **G-1** — `search.indexer`/`search.retrieval` are **existing declared ports** in 4 module blocks and `identity.policy_decision` is consumed by **6** modules, so the `ENT` gap narrows to *one missing outbound declaration*, not *nothing exists*; **G-2** — BC Map **L453** already makes index rebuildability **mandatory and quarterly-tested**, splitting P8 into a CLOSED and an OPEN half; **G-3** — the **Rank 6 EA** tags the whole search tree **V2/V3** incl. *Multi-Language Support (V3)* and *Synonyms (V3)*, raising `SRCHAO-C1`, whose usual `ADR-0061` precedence remedy is **unavailable while `PRD-015` is unranked**; **G-4** — `SEAT-XC-021` independently confirms `BC-23`'s ownership and the *no-edge-without-an-ADR* discipline. ⭐⭐ **Three script-specific risks surfaced for the first time:** Devanagari is **unicameral** (N1); **ZWJ/ZWNJ** is a correctness-vs-spoofing tension (N6); a **code-point** edit-distance bound is not equivalent across scripts, stressing `SRCH-BR-012` **C3**. ⭐ **Two security-shaped findings:** P8 *serve-stale* engages revocation semantics; **`SID-4.40` vs `LCFG-6`** is a live tension on enablement. ⭐ **One scope reduction offered:** deferring §20 **V4 alone** leaves V1–V3 functional. Instruction §2 honoured — **P1–P8 meanings reproduced verbatim and 0 relabelled**. Five experts: **0 of 5** for conferral (4 CONDITIONAL, 1 BLOCKED). Closure criteria **7 of 7 unmet**. ⛔ **0** decisions taken · **0** values invented · **0** subject bytes · **0** prior-record bytes · **0** frozen documents · **0** Rank 4 registers · **0** EA bytes · **0** checkers · **0** ADRs · **0** `IMPL-*` · **0** application-code files |

**Amendment rule.** When a decision on this packet is taken, the remedy is a **new decision record or supplement**
— ⛔ **never a silent edit of these blanks**, because a packet whose blanks fill themselves cannot be
distinguished from one that was never answered.

---

**End of `PRD-015_ARCHITECTURE_OWNER_DECISION_PACKET.md`.**
**Decisions presented: 14. Decisions taken: ⛔ 0. Values invented: ⛔ 0.**
**Conferral: ⛔ TEMPLATE ONLY — NOT CONFERRED.**
**⚠ STAGE 3 REMAINS CONDITIONAL / NOT CONFERRED.** `PRD-015` remains **v0.1 `DRAFT`**, registry **`PLANNED`**.
⛔ **STAGE 4 NOT ENTERED · IMPLEMENTATION IDs NOT CREATED · FREEZE NOT PERFORMED · BASELINE NOT PERFORMED · NO FROZEN DOCUMENTS MODIFIED.**
