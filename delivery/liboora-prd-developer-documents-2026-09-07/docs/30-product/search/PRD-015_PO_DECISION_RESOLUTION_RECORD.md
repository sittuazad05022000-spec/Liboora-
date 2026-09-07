# PRD-015 — Product Owner Decision Resolution Record

| Field | Value |
|---|---|
| **Type** | Decision **resolution** record. It records answers that were given, and what they do and do **not** authorise |
| **Not** | Not a PRD · not an ADR · not an approval · not an ARB ruling · not a conferral · not a freeze · not a baseline |
| **Version** | v1.0 |
| **Date** | 2026-09-03 |
| **Form** | Follows [`PRD-006_PO_DECISION_RESOLUTION_RECORD.md`](../attendance-management/PRD-006_PO_DECISION_RESOLUTION_RECORD.md) — the repository's established precedent for recording a Product-Owner-only answer without letting it read as an architecture approval |
| **Subject** | [`PRD-015_SEARCH_INDEXING.md`](./PRD-015_SEARCH_INDEXING.md) **v0.1 `DRAFT`**, registry **`PLANNED`** — sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544`, 1,426 lines, 95,608 bytes, **byte-unchanged by this record** |
| **Supplements** | [`PRD-015_ARCHITECTURE_ALIGNMENT.md`](./PRD-015_ARCHITECTURE_ALIGNMENT.md) (Stage-3 measurement, `4154519`) and [`PRD-015_STAGE3_CLOSURE_ASSESSMENT.md`](./PRD-015_STAGE3_CLOSURE_ASSESSMENT.md) (closure assessment, `34ac2d3`) — ⛔ **neither is edited in place** |
| **Decision authority exercised** | ⭐ **Product Owner only** |
| **Approvals asserted** | ⛔ **None.** No ARB, Architecture Owner, Architecture Reviewer, Security Platform, Privacy Owner, Governance Owner, Principal Enterprise Architect or independent-reviewer approval is claimed |
| **ADRs Accepted by this record** | ⛔ **Zero.** No ADR is created, amended, Accepted or consumed. `ADR-0088` / `ADR-0089` / `ADR-0090` remain **RESERVED and UNWRITTEN** |
| **Measured architecture result** | ✅ **6 of 6** Stage-3 checks PASS — carried forward unchanged, **not re-litigated** |
| **Formal conferral** | ⛔ **NOT CONFERRED.** A Product Owner answer is not the Architecture Owner's act (§6) |
| **Final decision** | ⚠ **STAGE 3 REMAINS CONDITIONAL / NOT CONFERRED** |

> **What this record is for.** The Product Owner answered the language/script question and stated the required
> search behaviours. Some of those answers settle a question completely. Others settle the **product** half of a
> question whose **architecture** half belongs to someone else. This record separates the two, so that nobody
> later reads a product answer as an architecture approval.
>
> **The separation is the Product Owner's own instruction**, quoted verbatim from the instruction this record
> executes:
> *"Where a decision only determines product policy, record the policy. Where technical implementation remains
> undefined, keep it OPEN for the appropriate later stage."*
> *"Product decides WHAT behavior is required. Architecture/engineering later decides HOW it is implemented,
> subject to repository governance."*
> *"Do not falsely close a technical parameter merely because the product behavior has been approved."*

---

## 1. ⭐⭐⭐ Five findings that change what this record can lawfully claim

Each was **measured at `34ac2d3`**, not assumed from the instruction.

| # | Finding | Consequence |
|---|---|---|
| **F-1** | ⭐⭐⭐ **The instruction's P-labels are NOT the repository's P-labels.** The instruction §4 assigns P1 = *case normalization*, P2 = *tokenization*, P3 = *partial/prefix*, P4 = *typo tolerance*, P7 = *language scope*, P8 = *multi-word*. The subject's **actual** §36 (**L833-842**) assigns P1 = *engine/index technology*, P2 = *analyzer/tokenizer config*, P3 = *edit-distance bound + min token length*, P4 = *min prefix length*, P7 = *latency/throughput/availability*, P8 = *rebuild posture and duration* | ⛔ The answers **cannot** be written into the `P1`…`P8` slots. Doing so would silently redefine eight registered identifiers and report six undecided *implementation* parameters as decided. The answers are recorded under **new `SRCHPO-` identifiers** and mapped to the real P-rows in **§3.3** |
| **F-2** | ⭐⭐ **Every behaviour the instruction "decides" is ALREADY a MUST in the subject.** Case-insensitivity = `SRCH-FR-024` N1; tokenization = N5 + `SRCH-FR-029`; prefix = `SRCH-FR-030`; typo tolerance = `SRCH-FR-033`; multi-word = `SRCH-BR-010`; singular/plural = `SRCH-FR-031` V1 + `SRCH-FR-032` | ⭐ These are **confirmations**, not new decisions. That is a *stronger* result than a new decision: it means the product direction and the drafted requirement already agree, and ⛔ **no PRD edit is needed to make them true** |
| **F-3** | ⭐⭐ **`SRCH-GAP-007` is a THREE-part gap, and the Product Owner owns only part of it.** §42 **L985**: *"The language/script **inventory** and the declared **variant/abbreviation vocabulary** for §16 and §20"*, owner *"**Product Owner** (markets) **+ Architecture Owner** (analyzer)"* | ⭐ The inventory half is now **answered**. ⛔ The **variant/abbreviation vocabulary** (§20 V4, **L552-553**) and the **analyzer configuration** halves are **NOT** answered ⇒ the gap becomes **PARTIALLY CLOSED**, not CLOSED (§2.4) |
| **F-4** | ⭐⭐ **`SRCH-GAP-003` is owned by the Architecture Owner ALONE.** §42 **L981**: owner *"**Architecture Owner**"* — the Product Owner is **not** a co-owner, unlike `004`, `005`, `006` and `007` | ⛔ A Product Owner record **cannot** close it, even partially. The policy it states is a **restatement of existing requirements**, not a closure (§4) |
| **F-5** | ⭐ **Editing `PRD-015` would break the Stage-3 freshness anchor.** `PRD-015_ARCHITECTURE_ALIGNMENT.md` **L12** anchors the review to sha256 `fe3093e6…c2c4544`; **L685** reads *"`fe3093e6…c2c4544` still resolves at `0611b1c`"* | ⛔ **`PRD-015` is left byte-unchanged.** Instruction §18 permits *"the smallest lawful documentation update"* — and the smallest lawful update here is **none**, because F-2 shows the behaviours are already required and F-1 shows the P-slots must not be overwritten (§7) |

---

## 2. The decisions as given

Recorded verbatim in substance. Where the Product Owner attached a constraint, the constraint is **part of the
decision** and is reproduced, not summarised away.

### 2.1 Language and script scope — the one genuinely new product decision

| ID | Decision | Constraints attached by the Product Owner |
|---|---|---|
| **`SRCHPO-1`** | ⭐⭐⭐ **V1 canonical supported languages/scripts = exactly two: English (Latin script) and Hindi (Devanagari script).** This is a **closed set** for V1 | *"Do not claim universal transliteration support unless repository authority already establishes it."* Measured: no such authority exists — a repository-wide search for `supported language\|language inventory\|locale.*support\|i18n\|internationali\|Devanagari\|Hindi\|script support\|multilingual` returned **0 hits** before this record. ⛔ Therefore **no** claim of universal transliteration is made |
| **`SRCHPO-2`** | ⭐⭐ **Hinglish / Romanized Hindi = supported *query behaviour* where technically validated. It is NOT a canonical third language** | Explicitly **NOT**: a third canonical language · a separate BC · a separate index · a separate search system. ⛔ *"Do not invent transliteration rules."* ⛔ *"Do not invent Hindi/English stemming algorithms."* ⛔ *"Do not invent language detection."* — none is invented |
| **`SRCHPO-3`** | ⚠ **The conditional in `SRCHPO-2` is load-bearing.** *"where technically validated"* means Hinglish tolerance is **permitted, not required**, in V1 | An implementation that cannot validate it **MUST NOT** claim it. This mirrors `SRCH-BR-012`'s existing discipline (**L561**): *"an implementation that cannot satisfy them **MUST NOT** enable it"* |

⭐ **Why this decision is lawful to record and the others are confirmations.** `SRCH-GAP-007`'s Product-Owner half
is defined at **L985** as *"which markets V1 serves"* (§16 note, **L435-436**). Market scope is a product
question by construction, and the Product Owner is a named co-owner of that gap. ⛔ No other gap in §42 names the
Product Owner as an owner of the question this instruction answers.

### 2.2 Search behaviour policy — confirmations of existing MUSTs

⚠ **Read F-2 first.** These are not new requirements. Each row states the product policy **and** the
already-drafted requirement that carries it, so that the record cannot be mistaken for an amendment.

| ID | Product policy | Already required by | Status |
|---|---|---|---|
| **`SRCHPO-4`** | **Case-insensitive matching — ENABLED** | `SRCH-FR-024` **N1** (**L419**): *"Case folding — matching is **case-insensitive**"* | ✅ **CONFIRMED** — already a MUST |
| **`SRCHPO-5`** | **Token-aware matching — ENABLED** | `SRCH-FR-024` **N5** (**L423**) tokenization + `SRCH-FR-029` (**L514**) order-independent token matching | ✅ **CONFIRMED** — already a MUST. ⛔ The **tokenizer algorithm** is deliberately **not** defined (§3.2) |
| **`SRCHPO-6`** | **Bounded partial / prefix matching — ENABLED.** `Central Lib` → *Central Library* | `SRCH-FR-030` (**L520**): *"A query token **MUST** be able to match an indexed token by **prefix**"* | ✅ **CONFIRMED** — already a MUST. ⛔ **No numeric prefix length invented** (§3.2) |
| **`SRCHPO-7`** | **Minor typo tolerance — ENABLED.** `Centrl` → *Central* | `SRCH-FR-033` (**L557**): *"bounded, minor character difference — insertion, deletion, substitution or transposition"* | ✅ **CONFIRMED** — already a MUST. ⛔ **No edit-distance number, no typo percentage** (§3.2) |
| **`SRCHPO-8`** | **Multi-word queries — ENABLED**, relevance-aware, and unrelated token matches **MUST NOT** become false positives | `SRCH-BR-010` (**L525-528**): conjunctive treatment; *"A document satisfying only **one** token … **MUST NOT** be returned"* | ✅ **CONFIRMED** — already a MUST, and the *stricter* form: the subject already forbids the false-positive mode the instruction warns against. ⛔ **No ranking formula invented** |
| **`SRCHPO-9`** | **Singular/plural and word-form tolerance — ENABLED**, symmetrically | `SRCH-FR-031` **V1** (**L539**) + `SRCH-FR-032` (**L546-547**) symmetry | ✅ **CONFIRMED** — already a MUST |
| **`SRCHPO-10`** | **Irrelevant queries return nothing.** `xylophone` returns ⛔ **no** library | §22.3 T4-EXCLUDED + `SRCH-BR-010` | ✅ **CONFIRMED** — already a MUST |

### 2.3 ⛔ What `SRCHPO-1` does **not** authorise

| Not authorised | Why |
|---|---|
| A Devanagari **analyzer**, tokenizer, stemmer or collation | Analyzer configuration is `SRCH-GAP-002` **P2**, owner **Architecture Owner** (**L985** names the analyzer half explicitly) |
| **Transliteration** rules, tables, or an ICU/Aksharamukha-class mapping | ⛔ Instruction §3: *"Do not invent transliteration rules."* No repository authority defines one |
| **Language detection** on a query | ⛔ Instruction §3. Detection is an implementation mechanism, and `SRCH-BR-011` (**L548-549**) already forbids inference *"from usage, click behaviour, co-occurrence or any learned model"* |
| Hindi **stemming** or word-form vocabulary for §20 V1–V4 | `SRCH-BR-011` requires a **declared** rule set; the vocabulary is the second half of `SRCH-GAP-007` and is **not** answered here |
| Changing **`LCFG-2`** | `LCFG-2` (*language* = `en`, range *"Supported set"*) is declared at `Library_PRD_v1.md` **L717** — a **FROZEN Rank 3** document — and valued in `CONFIGURATION_GUIDE.md`, which *"cannot change the envelope"*. ⛔ Neither is touched (§7) |
| Any V1 **market** launch, locale rollout or translated UI | This record scopes *search matching*, not product localisation. ⛔ No string catalogue, no locale bundle, no `l10n` claim |
| A second index, a per-language index, or a per-script BC | ⛔ `SRCHPO-2`'s own constraint, and `SRCH-XC-010` (**L523**) closes the consumer set |

### 2.4 ⭐ Why `SRCH-GAP-007` becomes **PARTIALLY CLOSED**, not **CLOSED**

The gap text (**L985**) has three parts. Measured, one is answered:

| Part | Owner | Answered? | Evidence |
|---|---|---|---|
| Language / script **inventory** | **Product Owner** (markets) | ✅ **YES** — English/Latin + Hindi/Devanagari, closed for V1 | `SRCHPO-1` |
| Declared **variant / abbreviation vocabulary** for §20 **V4** | **Product Owner** | ⛔ **NO** | **L552-553**: *"the *vocabulary inventory* is `SRCH-GAP-007` (§16), owner **Product Owner**."* No `lib`≡`library`-class table is supplied by this record, and ⛔ none is invented |
| **Analyzer configuration** for the declared scripts | **Architecture Owner** | ⛔ **NO** | **L985**: *"+ **Architecture Owner** (analyzer)"*; and §16 **L435-436** |

⚠ **Honest consequence.** Because two of three parts remain unanswered — one of them still the Product Owner's
own — `SRCH-GAP-007` **must not** be marked CLOSED. It is **PARTIALLY CLOSED**. ⭐ It does, however, **cease to
block on the market-scope question**, which was the specific reason `PRD-015_ARCHITECTURE_ALIGNMENT.md` **L1007**
gave for its blocking status: *"a **market-scope** decision the Product Owner must take."* That reason is now
discharged.

⚠ **A second, narrower consequence, stated because it would otherwise be missed.** §16 **N4** (**L422**) requires
*"Unicode canonical normalization and compatible **diacritic** folding"*, and the alignment record **L1060**
observed that *"Without `SRCH-GAP-007`'s language inventory, N3/N4's separator and diacritic rules have no
declared"* scope. `SRCHPO-1` now supplies that scope — Latin and Devanagari — so **N3/N4 acquire a declared
domain of application** for the first time. ⛔ It does **not** supply the folding table itself, which is P2.

---

## 3. `SRCH-GAP-002` — what the answers do and do not do to P1–P8

### 3.1 The actual §36 rows, restated so the mapping cannot be misread

Verbatim from **L833-842**:

| # | Parameter (repository's own wording) | Required to exist by |
|---|---|---|
| P1 | Search engine / index technology selection | §0.3 |
| P2 | Analyzer, tokenizer and normalization rule configuration | `SRCH-FR-023`, `SRCH-FR-024` |
| P3 | Edit-distance bound and minimum token length for tolerance | `SRCH-BR-012` C2, C3 |
| P4 | Minimum prefix length for partial matching | `SRCH-FR-030` |
| P5 | Maximum page size cap | `SRCH-FR-039` |
| P6 | Acceptable projection lag per event class (except `SEV-9`) | §32 |
| P7 | Query latency, throughput and availability targets | §36 |
| P8 | Rebuild availability posture and duration | §34 |

**Owner (L844): Architecture Owner.** ⛔ The Product Owner is **not** an owner of this gap.

### 3.2 Status of each P-row after this record

| # | Repository parameter | New authority? | Status |
|---|---|---|---|
| **P1** | Engine / index technology | ⛔ **None.** Measured **0** hits for `elasticsearch\|opensearch\|meilisearch\|typesense\|algolia\|postgres full.text\|tsvector\|pg_trgm\|lucene\|solr` across all `docs/` | ⛔ **OPEN** — Architecture Owner |
| **P2** | Analyzer / tokenizer / normalization config | ⚠ **Scope narrowed, not configured.** `SRCHPO-1` tells the analyzer *which scripts* it must handle; it does not say *how* | ⛔ **OPEN** — Architecture Owner. ⭐ Now **better specified as a question** |
| **P3** | Edit-distance bound + min token length | ⛔ **None.** Measured **0** hits for `levenshtein\|edit.distance\|damerau\|fuzziness`. `SRCHPO-7` approves the *behaviour*; `SRCH-BR-012` C2/C3 still demand the *numbers* | ⛔ **OPEN** — Architecture Owner |
| **P4** | Minimum prefix length | ⛔ **None.** `SRCHPO-6` approves the behaviour; the number is absent | ⛔ **OPEN** — Architecture Owner |
| **P5** | Maximum page size cap | ✅ **`LCFG-12`** = **20**, range **5–50**, owner **Security** — `14B-Public-Library-Preview.md` **L342**/**L374**; `CONFIGURATION_GUIDE.md` §2A **L361** | ⚠ **Value exists; `PRD-015` cites `LCFG` 0 times** ⇒ traceability defect `SRCHCL-C2` stands. ⛔ **Not duplicated here** (instruction §4) |
| **P6** | Projection lag per event class | ✅ **`LCFG-6`** = **60 s**, range **0–300 s**, owner **Security**, *"Removal latency only"* — `Library_PRD_v1.md` **L721**/**L727** (`LIB-16.9`) | ⚠ Same as P5. ⛔ **Not duplicated here** |
| **P7** | Latency / throughput / availability targets | ⛔ **None.** **L826-827** states it directly: *"no repository authority states a latency budget, throughput target, index-size limit, freshness SLO or availability target for `BC-23`"* | ⛔ **OPEN** — Architecture Owner. ⚠ **The instruction's "P7 = language scope" is NOT this row** (F-1) |
| **P8** | Rebuild posture and duration | ⛔ **None.** `SRCHPO-8` (multi-word) is a **different subject entirely** | ⛔ **OPEN** — Architecture Owner. ⚠ F-1 applies |

⭐⭐ **`SRCH-GAP-002` result: PARTIALLY CLOSED — and only by evidence that pre-existed this record.** 2 of 8 rows
(P5, P6) have authoritative values; 6 of 8 have none. ⛔ **Nothing in this record closes any P-row**, because the
gap's owner is the Architecture Owner and its unresolved parts are all implementation values.

### 3.3 ⭐ Instruction-label → repository-parameter map

Published so that a later reader can reconcile the two numberings without re-deriving them.

| Instruction §4 label | What it actually decides | Recorded as | Repository parameter it does **not** close |
|---|---|---|---|
| "P1 — Case normalization" | Case-insensitivity | **`SRCHPO-4`** | ⛔ Not P1 (engine selection) |
| "P2 — Tokenization" | Token-aware matching | **`SRCHPO-5`** | ⛔ Not P2 (analyzer config) — narrows it only |
| "P3 — Partial/prefix" | Prefix matching enabled | **`SRCHPO-6`** | ⛔ Not P4 (min prefix length) |
| "P4 — Typo tolerance" | Bounded typo tolerance | **`SRCHPO-7`** | ⛔ Not P3 (edit-distance bound) |
| "P7 — Language/script scope" | English + Hindi | **`SRCHPO-1`**, **`SRCHPO-2`** | ⛔ Not P7 (latency/availability); belongs to `SRCH-GAP-007` |
| "P8 — Multi-word matching" | Conjunctive multi-word | **`SRCHPO-8`** | ⛔ Not P8 (rebuild posture) |

---

## 4. `SRCH-GAP-003` — the security policy, restated; the mechanism, still undecided

### 4.1 What is recorded

| ID | Statement | Already carried by |
|---|---|---|
| **`SRCHPO-11`** | ⭐⭐⭐ **`BC-18` owns authorization decisions.** BC Map **L127**: `BC-18` *"Owns credentials, sessions, devices, OTP, roles, permissions, **policy decisions**, consent"* | `X-13`; `PRD_LIFECYCLE.md` Stage-3 check 4 |
| **`SRCHPO-12`** | **`BC-23` owns** indexing, retrieval, matching and relevance capability — BC Map **L132**: *"Owns indices, permission-aware indexing, tenant index isolation, relevance, query rewriting"* | BC Map **L132** |
| **`SRCHPO-13`** | ⛔ **`BC-23` does NOT own** authorization policy, entitlement policy, identity authority, credential authority or tenant authority | §27 **L705-708**; measured in the subject: `BC-18` × **0**, `credential` × **0**, `OTP` × **0**, `session` × **1** (a *prohibition*, L398) |
| **`SRCHPO-14`** | **A search result may be returned only when the requesting principal is authorized to see the underlying resource. Indexing MUST NOT bypass authorization** | §27 **L662-712**, already headed *"⭐⭐⭐ Being indexed does NOT make data searchable by everyone. Search results MUST NEVER bypass source-system authorization"* — enforced by `SRCH-FR-001`/`007`/`INV-002`/`INV-004`/`FR-020`/`XC-016`/`FR-040`/`FR-013`/`FR-042` |
| **`SRCHPO-15`** | ⭐ **Query-time entitlement decision authority = `BC-18`; the implementation mechanism remains subject to architecture/implementation design** | Recorded verbatim as the instruction §6 requires |

### 4.2 ⛔ Why this does **not** close `SRCH-GAP-003`

| Ground | Measurement |
|---|---|
| **Wrong owner** | §42 **L981** names *"**Architecture Owner**"* — **alone**. A Product Owner record has no standing to close it (**F-4**) |
| **The policy was never the gap** | The gap asks for *"the **mechanism** by which a source system's entitlement decision is evaluated for an index document **at query time**"*. `SRCHPO-11`…`15` state the **authority**, which §27 already stated. ⛔ Restating a requirement does not answer a mechanism question |
| **Three structural absences persist** | ⛔ **No `BC-23` → `BC-18` edge** — BC Map §7 places `BC-23` in exactly **2** cells, `E-21` and `E-26`, **both inbound**; **L292**: *"If an edge is not in this table, it does not exist."* ⛔ **No `search:` module block** in Dependency Matrix §6, so `BC-23` declares **no ports whatsoever**. ⛔ **`search` is absent** from `identity.policy_decision`'s consumer list (`library_management` L193, `person_identity` L220 *"ask BC-18, never evaluate or cache"*, `student_network`, `ai`, `analytics`, `workflow`) |
| **A permitted direction is not a mechanism** | Matrix §5 row `R5 SEARCH` × column `IAM` = **`◇`** (port permitted). ⭐ Lawful **direction**, undefined **mechanism** |

### 4.3 ⛔ No edge invented — instruction §7 honoured

| Not created | Confirmation |
|---|---|
| `BC-23` → `BC-18` BC Map edge | ⛔ **0 bytes** of `LIBOORA_BOUNDED_CONTEXT_MAP.md` changed. No `E-nn` minted; edge count remains **29** with `E-27` permanently vacant |
| A `search:` module block or `identity.policy_decision` port | ⛔ **0 bytes** of `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` changed |
| An API, endpoint, RPC, event, token or entitlement object name | ⛔ **0.** None appears anywhere in this record |

⭐ Both files are **Rank 4**, and `DOCUMENTATION_BASELINE.md` §7 rule 1 requires an **ADR first**. Instruction §19
forbids creating one unless governance explicitly requires it — and governance requires the *Architecture Owner*
to raise it, not this record. ⭐ The `ADR-0096` §1.2 precedent is followed: a new fact must not rest on an
*absence*.

**`SRCH-GAP-003` result: ⛔ OPEN.** The policy is affirmed; the mechanism is not decided.

---

## 5. Tenant isolation and leakage — preserved, re-measured

| Property | Status | Evidence |
|---|---|---|
| Tenant scoping | ✅ **Preserved** | `SRCH-INV-004`, `SRCH-BR-004` (§9); §28; `MP-GBR-08`; `X-13` |
| Authorization-aware retrieval | ✅ **Preserved** | `SRCH-FR-040` per-page authorisation; §27 query-time re-evaluation |
| No cross-tenant result leakage | ✅ **Preserved** | §28 consequence 3 (**L721**) |
| ⭐⭐ **No corpus-statistic leakage** | ✅ **Structurally absent** | **7** occurrences of `corpus` in the subject, **all prohibitions**: **L721**, **L726-728** (*"this channel does not exist by construction"*), **L750** `S2`, **L752** `S4`, **L966** `R7`. `SRCH-FR-035` orders by **tier + field precedence + stable tiebreak — no corpus term** |
| No relevance variation from another tenant's private corpus | ✅ **Preserved** | Same — there is **no numeric relevance score** at all (**L597-600**) |
| "Existence in an index" never implies exposure | ✅ **Preserved** | §27 heading; `SRCH-FR-042` + `SRCH-XC-016` make an authorisation-emptied result **indistinguishable** from a genuinely empty one |
| No credential / OTP / session duplication | ✅ **Preserved** | Measured: `credential` **0**, `OTP` **0**, `session` **1** (a prohibition) |

⚠ **`SRCHPO-1` was tested against this section and adds no channel.** Declaring two scripts changes *which
characters normalize*, not *whose documents are visible*; N1–N6 are already required to be **symmetric and
total** (`SRCH-BR-008`), and `SRCH-BR-012` **C5** already forbids tolerance from widening *"authorisation,
tenant scope or field eligibility"*.

---

## 6. Stage-3 conferral — the distinction the instruction requires be kept

### 6.1 What this record is, in authority terms

| Question | Answer |
|---|---|
| Is a Product Owner decision recorded? | ✅ **Yes** — `SRCHPO-1`…`SRCHPO-10` |
| Is that the **Architecture Owner's** formal act? | ⛔ **No.** `PRD_OWNERSHIP_MODEL.md` **§5**: *"**Only the Architecture Owner approves.** The others attest, review or confirm"* |
| Does the **ARB** office exist for `PRD-015`? | ✅ **Yes** — **L197**: `| PRD-015 | Search Indexing | BC-23 | Product Owner | Search Platform | ARB | Platform Engineering |` |
| Is that office **filled**? | ⛔ **No.** §7 rule 4: *"**Never** record a personal name"* ⇒ every office is **VACANT of a holder** by construction (`ADR-0080` **L85**) |
| How is it lawfully filled? | §12.1 — *"filled **for this act only** by direct conferral from the human principal"*, on the `ADR-0032` §5.2 / `ADR-0033` §7.2 / `ADR-0036` §8.2 precedent |
| Has such a conferral, **naming `PRD-015`**, been supplied? | ⛔ **No.** The instruction states its own limit: *"This prompt authorizes recording that as the user's product decision, but NOT inventing technical implementation details"*, and §16: *"If a human principal's explicit conferral is required and has NOT actually been supplied, DO NOT manufacture it"* |
| Can `PRD-008`'s conferral be reused? | ⛔ **No.** `ADR-0033` **§7.1**: *"**A conferral for one act is not a standing licence**"* |
| Can another role stand in? | ⛔ **No.** `ADR-0098`: *"Product / Architecture / Requirements Reviewer is **NOT** treated as Governance Owner"* |

### 6.2 The four-limb closure test, re-run

| Limb | Requirement | Result |
|---|---|---|
| **A** | All blocking gaps resolved **or** classified non-blocking | ⛔ **FAIL** — `SRCH-GAP-002` **PARTIALLY CLOSED** (6 of 8 open), `SRCH-GAP-003` **OPEN**, `SRCH-GAP-007` **PARTIALLY CLOSED** |
| **B** | Required **Architecture** / Product Owner decisions present | ⛔ **FAIL** — the Product half of `007` is now present; ⛔ **every Architecture-Owner decision is still absent** |
| **C** | A legitimate Architecture reviewer / conferrer exists **for this act** | ⛔ **FAIL** — office established, **holder not conferred** for `PRD-015` |
| **D** | The record can be formally conferred per `PRD_LIFECYCLE.md` | ⛔ **FAIL** — follows from A, B and C |

⭐ **Progress is real and is recorded as such:** limb **B** moved from *"no owner decisions at all"* to *"the
Product Owner's decision is on record"*, and limb **A** moved two gaps from **OPEN** to **PARTIALLY CLOSED**.
⛔ **Neither movement satisfies its limb.**

### 6.3 ⭐⭐ The exact act still missing

| # | Missing act | Owner | Limb |
|---|---|---|---|
| 1 | Decide **P1, P2, P3, P4, P7, P8** — engine/transport, analyzer config, edit-distance bound, min prefix length, latency/availability targets, rebuild posture | **Architecture Owner** | **A**, **B** |
| 2 | Cite **`LCFG-12`** and **`LCFG-6`** in `PRD-015` for P5/P6 (`SRCHCL-C2`) | **Architecture Owner** | **A** |
| 3 | Define the **query-time entitlement mechanism**, decision residing **in `BC-18`** — a numbered BC Map §7 edge **or** a `search:` Matrix §6 block, **ADR first** | **Architecture Owner** | **A**, **B** |
| 4 | Supply the **variant / abbreviation vocabulary** (§20 V4) and the **analyzer configuration** for Latin + Devanagari | **Product Owner** (vocabulary) **+ Architecture Owner** (analyzer) | **A** |
| 5 | Dispose of **`SRCHAL-R1`** and **`SRCHAL-R2`** | **Architecture Owner** | **A** |
| 6 | ⭐⭐ **Confer Architecture Owner / Architecture Reviewer authority for this specific act, naming `PRD-015`**, in the `PRD-008_STAGE3_CONFERRAL.md` **L8** / `ADR-0033` §7.2 form | **Human principal** | **C** |

---

## 7. ⛔ Why `PRD-015` itself is left byte-unchanged

Instruction §18 permits *"the smallest lawful documentation update"*. Measured, the smallest lawful update is
**none**:

| Candidate edit | Rejected because |
|---|---|
| Write the answers into §36 `P1`…`P8` | ⛔ **F-1** — the labels differ. This would redefine eight registered identifiers and report six undecided implementation values as decided, breaching instruction §5 |
| Add English/Hindi to §16's scope note | ⚠ The note (**L434-436**) is a *routing* statement pointing at `SRCH-GAP-007`, and the gap is **not fully closed** (§2.4). Editing it to imply closure would misreport two unanswered parts |
| Mark `SRCH-GAP-007` CLOSED in §42 | ⛔ **False** — §2.4. Two of three parts remain open |
| Add the behaviours as new requirements | ⛔ **F-2** — they are **already MUSTs**. A duplicate requirement is a divergence risk, and `SRCH-BR-008`-class symmetry rules make duplication actively harmful |
| Bump `PRD-015` to v0.2 | ⛔ Instruction §18: *"do not change the PRD version unless lifecycle rules require it."* No lifecycle rule requires it; and **F-5** — a version bump changes bytes, breaking the Stage-3 sha256 anchor at **L12** and forcing a re-measurement the objective forbids doing *"merely for cosmetic reasons"* |

⭐ **The decision is therefore recorded *about* the PRD rather than *in* it** — exactly the pattern
`PRD-006_PO_DECISION_RESOLUTION_RECORD.md` established, and exactly what preserves the Stage-3 freshness anchor.

---

## 8. `SRCHAL-R1` — Student Identity §4.9 re-audit

### 8.1 The obligations, read at source

`Student_Identity_PRD_v1.md` **§4.9** (**L939-953**), heading: *"Search Indexing — `BC-23` *(`E-21`)*"*.

| ID | Obligation (abridged) | Whose act? |
|---|---|---|
| `SID-4.38` | *"Discoverability of a public profile **SHALL** be provided by `BC-23`, driven by this module's events. `BC-23` **SHALL NOT** read this module's store"* | ⭐ **Both** — `BC-10` emits; `BC-23` must not read the store |
| `SID-4.39` | *"Only allow-list fields (`SID-2.28`) **SHALL** be indexed… A field in the never-public set **SHALL NOT** be indexed at all, in any index, for any purpose"* | ⭐⭐ **`BC-23`-binding** — *"in any index"* is addressed to the indexer |
| `SID-4.40` | Public→Private *"**SHALL** remove the person from public search results as part of the same operation, not on the next scheduled reindex"* | ⭐⭐ **`BC-23`-binding** — a no-propagation-window obligation on the index |
| `SID-4.41` | *"Public profile search **SHALL NOT** support lookup by mobile number, and **SHALL NOT** confirm or deny that a mobile number is registered"* | ⭐⭐ **`BC-23`-binding** — a query-surface prohibition |

### 8.2 Disposition

| Test | Result |
|---|---|
| Are they applicable to `BC-23`? | ✅ **Yes** — three of four are addressed to the index/query surface, and the section is *titled* `BC-23` |
| Satisfied by another authoritative contract? | ⚠ **Partly, structurally.** `PRD-015` §6.2 measures `PRD-021B` student discovery as ⛔ **NOT** a V1 enabled consumer (`SRCH-GAP-005`, no measured `E-21` consumer authority for `BC-11`/`BC-12`). ⭐ So in V1 **`BC-23` indexes no student profile**, and the obligations have **no V1 surface to bind** |
| Merely consumer responsibilities? | ⛔ **No** — `SID-4.39`/`4.40`/`4.41` bind the indexer, not the consumer |
| Reproduced anywhere? | ✅ Measured: `SID-4.38`…`4.41` appear in `PRD-021B` **B0**, **B3**, **B4** and its Stage-3/Stage-4 records — ⭐ i.e. in **consumer** documents |
| Genuinely missing from `PRD-015`? | ⚠ **Yes** — measured `SID-` × **0** in the subject |

⭐ **Disposition: `SRCHAL-R1` REMAINS RAISED.** Consumer conformance is **not** the owner's specification. ⛔ It is
**not** falsely closed, and ⛔ **not** escalated to FAIL either — because §6.2's V1 exclusion means no student
document is indexed in V1, so the finding is **latent, not live**. ⛔ **0 bytes** of the frozen
`Student_Identity_PRD_v1.md` changed. Owner: **Architecture Owner** (§6.3 item 5).

---

## 9. `SRCHAL-R2` — PRD-020 §8.3 Trust & Safety re-audit

### 9.1 The obligations, read at source

`PRD-020_TRUST_AND_SAFETY.md` §8.3 publishes a **four-step discovery pipeline** (**L550-560**) that names
`BC-23` explicitly:

```
[1] Eligibility  BC-11 → [2] Privacy BC-10 → [3] Safety BC-13 ← THIS PRD → [4] Ranking BC-23
```

| ID | Obligation | Whose act? |
|---|---|---|
| `TSF-FR-023` | *"A person under `SUSPENSION`, `TERMINATION` or `DISCOVERY_RESTRICTION` **MUST NOT** appear in any discovery result, recommendation or search suggestion"* | ⭐ **Outcome obligation** — binds whoever produces the result |
| `TSF-INV-005` | *"Step **[3] MUST run after [1] and [2] and MUST be non-bypassable.** A ranking or recommendation path that reaches the index without step 3 is a defect"* | ⭐⭐ **Explicitly names the index path** ⇒ **`BC-23`-relevant** |

### 9.2 Disposition

| Test | Result |
|---|---|
| `BC-23`-owned? | ⛔ **No, and this matters.** `BC-13` owns the safety decision; **L556** marks step [3] *"← THIS PRD"* and assigns `BC-23` only step **[4] Ranking — relevance** |
| Consumer obligations? | ⚠ **Partly** — but `TSF-INV-005`'s *"reaches the index"* clause is a **pipeline-ordering** constraint that `BC-23` must not defeat |
| Already satisfied elsewhere? | ⚠ **Structurally, in V1.** §6.2 excludes student discovery; §8.1's same-logic applies — the V1 enabled set is **library** discovery, so no person-level safety exclusion is exercised. `TSF-` appears in `PRD-021B` B1/B2/B3/B4 (consumers) |
| Missing `BC-23` traceability? | ⚠ **Yes** — measured `TSF-` × **0** in the subject |
| ⭐ Does `BC-23` become a T&S authority? | ⛔ **NO — and must not.** `SRCHPO-13` and §27 **L705-708** keep decision authority outside `BC-23`. Search relevance **MUST NOT** become a Trust & Safety authority; `BC-23` **consumes** step [3]'s outcome |

⭐ **Disposition: `SRCHAL-R2` REMAINS RAISED**, on the same latency reasoning as R1. ⛔ **No T&S ownership is
transferred into `BC-23`.** ⛔ **0 bytes** of the frozen `PRD-020_TRUST_AND_SAFETY.md` changed. Owner:
**Architecture Owner**.

⚠ ⭐ **One asymmetry disclosed.** `TSF-INV-005` is *"non-bypassable"* and `SRCH-FR-035`'s ordering model has **no
hook** for a step-[3] filter, because `BC-23`'s V1 pipeline has no person-safety stage. That is **consistent**
with §6.2's exclusion, ⛔ **not** a latent defect — but it means that enabling `PRD-021B` discovery later will
require the mechanism, and it is recorded here so the dependency is not discovered late.

---

## 10. Five-expert closure review

Each expert answers **its own** listed questions.

### 10.1 Product Architect — ⚠ **CONDITIONAL**

| Question | Finding |
|---|---|
| English + Hindi scope explicit? | ✅ **Yes** — `SRCHPO-1`, a closed two-member set |
| Hinglish correctly scoped? | ✅ **Yes** — `SRCHPO-2`/`3`: query behaviour where validated; ⛔ not a canonical language, BC, index or system |
| Flexible matching still a reusable capability? | ✅ **Yes** — `SRCH-BR-003` (**L524-525**): absence from the V1 enabled set *"**MUST NOT** be read as a defect in the capability"* |
| Is library search the only consumer? | ⛔ **No** — §6.2 also enables `PRD-021C` **C6** and holds `BC-27` AI's `E-26` port open |
| Duplicate search system created? | ⛔ **No** — `SRCH-FR-001`/`002` single query port; `SRCHPO-2` forbids a per-language index |
| Product vs implementation decisions mixed? | ✅ **Not mixed** — **F-1** kept them apart; §3.3 publishes the map |
| **Verdict** | ⚠ **CONDITIONAL** — the product half of `SRCH-GAP-007` is answered; the **variant/abbreviation vocabulary**, also Product-owned (**L552-553**), is not |

### 10.2 Enterprise / Domain Architect — ⚠ **CONDITIONAL**

| Question | Finding |
|---|---|
| `BC-23` ownership | ✅ Intact — BC Map **L132**, unchanged |
| BC Map integrity | ✅ **0 bytes changed**; 31 contexts, 29 edges, `E-27` vacant |
| Unauthorized edge creation | ⛔ **None** — §4.3 |
| Dependency direction | ✅ Matrix §5 `R5 SEARCH` → `IAM` = `◇` is lawful **downward**; ⛔ mechanism undefined |
| Circular dependency | ⛔ **None** — `BC-23` is the source of **0** edges |
| `BC-18` authorization authority | ✅ **Preserved** — `SRCHPO-11`/`13` |
| New BC / duplicate context | ⛔ **None** |
| **Verdict** | ⚠ **CONDITIONAL** — integrity preserved, but `BC-23` still declares **no ports** and has **no edge to `BC-18`** |

### 10.3 Search / Information Retrieval Architect — ⚠ **CONDITIONAL**

| Behaviour | Finding |
|---|---|
| Case-insensitive | ✅ N1 |
| Normalization | ✅ N1–N6, symmetric and total (`SRCH-BR-008`) |
| Token matching | ✅ N5 + `SRCH-FR-029`, order-independent |
| Partial / prefix | ✅ `SRCH-FR-030`; ⛔ min length **OPEN** (P4) |
| Singular / plural | ✅ `SRCH-FR-031` V1 + `SRCH-FR-032` symmetry |
| Bounded typo tolerance | ✅ `SRCH-FR-033`; ⛔ bound **OPEN** (P3) |
| Multi-word | ✅ `SRCH-BR-010` conjunctive |
| Irrelevant-query exclusion | ✅ `xylophone` → nothing (T4 EXCLUDED, §22.3) |
| English + Hindi scope | ✅ **`SRCHPO-1`** — and it gives §16 N3/N4 a **declared domain** for the first time |
| Hinglish query behaviour | ✅ Permitted-where-validated; ⛔ no transliteration, stemming or detection invented |
| Invented thresholds | ⛔ **Zero** |
| Second ranking engine | ⛔ **None** — `SRCH-FR-035` remains tier + field precedence + stable tiebreak, with **no numeric score** |
| **Verdict** | ⚠ **CONDITIONAL** — all ten §17.2 behaviours preserved; P2/P3/P4 implementation values remain **OPEN** |

### 10.4 Security / Privacy / Multi-Tenancy Architect — ⚠ **CONDITIONAL**

| Question | Finding |
|---|---|
| `BC-18` authorization authority | ✅ **Preserved and restated** (`SRCHPO-11`) |
| Query-time entitlement | ⛔ **Mechanism still undecided** (`SRCH-GAP-003`) — policy affirmed, contract absent |
| Tenant isolation | ✅ Preserved — §5 |
| Indexed-data protection | ✅ §27; `SRCH-FR-042` + `SRCH-XC-016` prevent the existence oracle |
| Corpus-statistic leakage | ✅ **Structurally absent** — 7 prohibitions; no corpus term in ordering |
| Credential / OTP / session duplication | ✅ **None** — 0 / 0 / 1-prohibition |
| Does `SRCHPO-1` add a channel? | ⛔ **No** — script scope changes normalization, not visibility; `SRCH-BR-012` C5 already bars widening |
| **Verdict** | ⚠ **CONDITIONAL** — every invariant holds, but the security-critical mechanism gap is **OPEN**, so the surface cannot be certified |

### 10.5 QA / Governance Auditor — ⛔ **BLOCKED (NOT CONFERRABLE)**

| Question | Finding |
|---|---|
| Decisions explicitly authorized? | ✅ The **product** decision is. ⛔ The Architecture decisions are **not** |
| Every closure has repository evidence? | ✅ **Yes** — and ⭐ **no gap is marked CLOSED**; two are **PARTIALLY CLOSED** with the unanswered parts itemised |
| Owner decisions fabricated? | ⛔ **None.** **F-1** prevented six false P-closures; §2.3 lists seven things `SRCHPO-1` does not authorise |
| Frozen document modified? | ⛔ **None** — `Student_Identity_PRD_v1.md`, `PRD-020`, `Library_PRD_v1.md`, `14B` all **0 bytes** |
| Reserved ADR consumed? | ⛔ **None** — `ADR-0088`/`0089`/`0090` still unwritten; **0** ADRs created |
| Lifecycle stage skipped? | ⛔ **No** — Stage 3 only |
| Stage-3 conferral authority valid? | ⛔ **NO.** Office established (**L197**), **holder not conferred** for `PRD-015`; `ADR-0033` §7.1 bars inheritance |
| **Verdict** | ⛔ **BLOCKED — Stage 3 cannot legally be conferred.** The Product Owner act is lawful and recorded; the Architecture Owner act is absent |

**Panel result: 0 of 5 support conferral — 4 CONDITIONAL, 1 BLOCKED. Unanimous.**

---

## 11. Findings register

| ID | Finding | Disposition |
|---|---|---|
| **`SRCHPO-A1`** | The instruction's P-labels differ from §36's; recording answers in the P-slots would have falsely closed six implementation parameters | ✅ **ACCEPTED** — §3.3 publishes the map |
| **`SRCHPO-A2`** | All six behaviour "decisions" are already MUSTs in the subject | ✅ **ACCEPTED** — recorded as confirmations (§2.2) |
| **`SRCHPO-A3`** | `SRCHPO-1` supplies §16 N3/N4 with a declared script domain for the first time | ✅ **ACCEPTED** — §2.4 |
| **`SRCHPO-A4`** | `SRCH-GAP-007`'s blocking *reason* (market scope) is discharged even though the gap is not | ✅ **ACCEPTED** — §2.4 |
| **`SRCHPO-C1`** | `SRCHCL-C2` stands: `PRD-015` cites `LCFG` **0** times though `LCFG-12`/`LCFG-6` supply P5/P6 | ⚠ **RAISED** — Architecture Owner (§6.3 item 2) |
| **`SRCHPO-C2`** | `TSF-INV-005` requires a non-bypassable safety step; `SRCH-FR-035` has no hook for one | ⚠ **RAISED** — consistent with §6.2's V1 exclusion, but a live dependency for any later `PRD-021B` enablement (§9) |
| **`SRCHPO-X1`** | *"The Product Owner answered, therefore Stage 3 is conferrable."* | ⛔ **REJECTED** — `PRD_OWNERSHIP_MODEL.md` §5: *"**Only the Architecture Owner approves.**"* A product answer is limb **B**'s *product half*, not limb **C** |
| **`SRCHPO-X2`** | *"`SRCH-GAP-007` is CLOSED."* | ⛔ **REJECTED** — **L985** and **L552-553**: the variant/abbreviation vocabulary and the analyzer configuration are unanswered. **PARTIALLY CLOSED** |
| **`SRCHPO-X3`** | *"`SRCH-GAP-003` is closed because the policy is now explicit."* | ⛔ **REJECTED** — the gap asks for a **mechanism**; its owner is the **Architecture Owner alone** (**L981**); three structural absences persist |
| **`SRCHPO-X4`** | *"A logical authorization dependency justifies minting the `BC-23` → `BC-18` edge."* | ⛔ **REJECTED** — instruction §7; BC Map **L292**; Rank 4 ⇒ ADR first; `ADR-0096` §1.2's refusal to rest a fact on an absence |
| **`SRCHPO-X5`** | *"Approving typo tolerance and prefix matching decides P3 and P4."* | ⛔ **REJECTED** — instruction §5. `SRCH-BR-012` **C2**/**C3** demand a declared minimum length and bound; **0** repository hits for `levenshtein\|edit.distance\|damerau\|fuzziness` |
| **`SRCHPO-X6`** | *"Hinglish support implies a transliteration/detection capability."* | ⛔ **REJECTED** — `SRCHPO-3`'s *"where technically validated"* is permissive, and `SRCH-BR-011` forbids inference from any learned model |
| **`SRCHPO-X7`** | *"R1/R2 are discharged because `PRD-021B` reproduces `SID-`/`TSF-` identifiers."* | ⛔ **REJECTED** — consumer conformance is not the owner's specification (§8.2, §9.2) |
| **`SRCHPO-X8`** | *"`PRD-015` should be edited to record the decision."* | ⛔ **REJECTED** on five measured grounds — §7 |

**8 rejected with reasons · 4 accepted · 2 raised.**

---

## 12. Validation performed

| # | Check | Result |
|---|---|---|
| 1 | `PRD-015` byte-unchanged | ✅ sha256 `fe3093e6…c2c4544`, 1,426 lines, 95,608 bytes — **0 bytes** |
| 2 | Stage-3 measurement record unchanged | ✅ **0 bytes** — its §17 forbids in-place edits |
| 3 | Closure assessment unchanged | ✅ **0 bytes** — supplemented, not edited |
| 4 | Frozen documents unchanged | ✅ `Student_Identity_PRD_v1.md`, `PRD-020_TRUST_AND_SAFETY.md`, `Library_PRD_v1.md`, `14B-Public-Library-Preview.md` — **0 bytes each** |
| 5 | Rank 4 architecture registers unchanged | ✅ BC Map and Dependency Matrix — **0 bytes each** |
| 6 | Append-only registers unchanged | ✅ `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md`, `PRD_OWNERSHIP_MODEL.md` — **0 bytes each** |
| 7 | Checkers unchanged | ✅ `tool/docs_check/*.py` — **0 modified**; `alignment_record_freshness.py`'s `RECORDS` still covers **2** records, ⛔ `PRD-015` not added |
| 8 | New stem collision-checked | ✅ **`SRCHPO-`** — **0** pre-existing occurrences repository-wide before use |
| 9 | Architecture invariants | ✅ Contexts **31** · `E-nn` tokens **30**, real edges **29** (`E-27` vacant) · numbered ADR files **86** · `ADR-0088`/`0089`/`0090` **0 files each** — **Δ = 0** |
| 10 | Invented values | ⛔ **0** — no threshold, edit distance, prefix length, weight, score, percentage, latency figure, algorithm, library, API, endpoint, event, port, edge, BC or `IMPL-*` |
| 11 | ADRs | ⛔ **0** created, amended or Accepted; reserved numbers untouched |
| 12 | Ten flexible-search behaviours | ✅ All **10** of §17.2 (**L465-474**) preserved, including `xylophone` → nothing |

---

## 13. ⛔ What this record does **NOT** do

| Act | Confirmation |
|---|---|
| Confer Stage 3 | ⛔ **No** — §6. `FORMAL CONFERRAL = NOT CONFERRED` |
| Approve, on any authority other than the Product Owner's | ⛔ **No** — no ARB, Architecture Owner, Security, Privacy, Governance or PEA approval asserted |
| Close `SRCH-GAP-002` | ⛔ **No** — **PARTIALLY CLOSED** by pre-existing evidence only; 6 of 8 rows OPEN |
| Close `SRCH-GAP-003` | ⛔ **No** — **OPEN** |
| Close `SRCH-GAP-007` | ⛔ **No** — **PARTIALLY CLOSED**; two of three parts unanswered |
| Close `SRCHAL-R1` / `SRCHAL-R2` | ⛔ **No** — both **REMAIN RAISED** |
| Change `SRCH-GAP-008`'s ownership | ⛔ **No** — **`OWNER NOT ESTABLISHED`** preserved |
| Modify `PRD-015` | ⛔ **No** — **0 bytes** (§7) |
| Modify any frozen or append-only document | ⛔ **No** — **0 bytes** |
| Create or amend an ADR | ⛔ **No** — **0** |
| Mint a BC, edge, event, port or identifier outside `SRCHPO-` | ⛔ **No** |
| Enter Stage 4 or perform a Requirements Review | ⛔ **No** |
| Create `IMPL-*` | ⛔ **No** — **0** |
| Write application code or a migration | ⛔ **No** — **0** files under `lib/ test/ web/ android/ ios/ tool/ .github/` |
| Freeze, baseline, rank or approve | ⛔ **No** |
| Change `PRD-015`'s status | ⛔ **No** — **v0.1 `DRAFT`**, registry **`PLANNED`** |
| Transfer T&S or authorization ownership into `BC-23` | ⛔ **No** — §9.2, `SRCHPO-13` |
| Claim transliteration, stemming, detection or locale support | ⛔ **No** — §2.3 |

---

## 14. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-03 | Created as a **Product-Owner-only decision resolution record** on the `PRD-006_PO_DECISION_RESOLUTION_RECORD.md` precedent, because `PRD-015`'s Stage-3 records are governed by an amendment rule forbidding in-place edits and its sha256 anchor must survive. ⭐⭐⭐ **Records the V1 language/script decision** — English (Latin) + Hindi (Devanagari), a closed set, with Hinglish/Romanized Hindi as *permitted-where-validated query behaviour* and explicitly **not** a canonical third language. ⭐⭐ **Discovers that the instruction's P1–P8 labels do not match §36's** and refuses to write answers into those slots, which would have falsely closed six implementation parameters. ⭐ **Measures that all six behaviour "decisions" are already MUSTs** in the subject, so no PRD edit is needed. `SRCH-GAP-007` → **PARTIALLY CLOSED** (inventory answered; variant vocabulary and analyzer config not). `SRCH-GAP-002` → **PARTIALLY CLOSED** by pre-existing `LCFG-12`/`LCFG-6` only. `SRCH-GAP-003` → **OPEN**; policy affirmed, mechanism undecided, ⛔ **no edge invented**. `SRCHAL-R1`/`R2` → **REMAIN RAISED**, with the V1-exclusion latency reasoning stated. Five-expert panel **0 of 5 for conferral — 4 CONDITIONAL, 1 BLOCKED**. Closure test **A/B/C/D all FAIL**. **14 findings — 4 accepted, 2 raised, 8 REJECTED with reasons.** ⛔ **0** subject bytes · **0** Stage-3 record bytes · **0** frozen documents · **0** append-only registers · **0** Rank-4 registers · **0** checkers · **0** ADRs · **0** `IMPL-*` · **0** application-code files |

**Amendment rule.** This record states what was decided **on the date it was decided**. If a later decision
supersedes it, the remedy is a **new record or a supplement** — ⛔ **never a silent rewrite of these answers**,
because a decision record that changes its own answers cannot be distinguished from one that never had them.

---

**End of `PRD-015_PO_DECISION_RESOLUTION_RECORD.md`.**
**Product decision: ✅ RECORDED — English (Latin) + Hindi (Devanagari); Hinglish as validated query behaviour.**
**Measured architecture result: ✅ 6 of 6 PASS. Formal conferral: ⛔ NOT CONFERRED.**
**⚠ STAGE 3 REMAINS CONDITIONAL / NOT CONFERRED.** `PRD-015` remains **v0.1 `DRAFT`**, registry **`PLANNED`**.
⛔ **STAGE 4 NOT ENTERED · IMPLEMENTATION IDs NOT CREATED · FREEZE NOT PERFORMED · BASELINE NOT PERFORMED · NO FROZEN DOCUMENTS MODIFIED.**
